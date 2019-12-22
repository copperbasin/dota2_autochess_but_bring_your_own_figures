#!/usr/bin/env iced
### !pragma coverage-skip-block ###
require 'fy'
fs = require 'fs'
require 'lock_mixin'
{exec, execSync} = require 'child_process'
argv = require('minimist')(process.argv.slice(2))
argv.port ?= 1337
argv.ton_ws_port ?= 1338
argv.ws_port ?= argv.port+10000
{
  master_registry
  Webcom_bundle
} = require 'webcom/lib/client_configurator'
require 'webcom-client-plugin-base/src/hotreload'
require 'webcom-client-plugin-base/src/react'
require 'webcom-client-plugin-base/src/keyboard'
delivery = require 'webcom/src/index'

bundle = new Webcom_bundle master_registry
bundle.plugin_add 'Webcom hotreload'
bundle.plugin_add 'Webcom react'
bundle.plugin_add 'keyboard scheme'
bundle.feature_hash.hotreload = true

delivery.start {
  htdocs : 'htdocs'
  hotreload  : !!argv.watch
  title : "Dota2 autochess but bring your own figures"
  bundle
  port    : argv.port
  ws_port : argv.ws_port
  watch_root  : true
  allow_hard_stop : true
  watcher_ignore : (event, full_path)->
    /\b(build|wallet)\b/.test full_path
  engine : {
    HACK_remove_module_exports : true
  }
  vendor : 'react_min'
  gz : true
}

# ###################################################################################################
#    TON stuff
# ###################################################################################################
# TODO Когда я узнаю, что у lite-client'а есть RPC, то я это всё перепишу по-нормальному
{contract_addr} = require("./config.json")

my_wallet     = ""
my_wallet2    = ""
my_work_chain = ""
my_balance    = 0

lock = new Lock_mixin
lock.$limit = argv.multi_exec_max_threads or 10
multi_exec = (opt)->
  {
    ctx_list
    cb
  } = opt
  for ctx, idx in ctx_list
    do (ctx)->
      await lock.lock defer()
      exec ctx.cmd, {shell:"/bin/bash"}, (error, stdout, stderr) ->
        loop
          if error
            cb error, ctx
            break
          ctx.res = stdout.toString().trim()
          cb null, ctx
          break
        lock.unlock()
  return

res_parse = (out) ->
  p "out :#{out}"
  out = out.replace("result:", '').trim()
  return null if /error/.test out
  return JSON.parse(out)[0]

easy_exec = (t)->
  # sync and ONLY sync. Потому что иначе всё поломается т.к. не будет обновляться правильно seqno и запросы будут перетирать файлы друг-друга
  execSync(t, {shell:"/bin/bash"}).toString().trim()
get_seqno = ()->
  easy_exec("lite-client -c 'runmethod #{my_wallet} seqno' 2>&1 | grep result | awk '{print $3}'")

# ###################################################################################################
#    balance
# ###################################################################################################

get_address = ()->
  try
    my_wallet = easy_exec("fift -s fift_scripts/show-bouceable-addr.fif 'build/new-wallet'")
    [my_work_chain, my_wallet2] = easy_exec("fift -s fift_scripts/show-addr.fif 'build/new-wallet'").split(":")
  catch err
    perr err

get_balance = ()->
  return perr "!my_wallet" if !my_wallet
  try
    my_balance = easy_exec("lite-client -c 'getaccount #{my_wallet}' 2>&1 | grep nanograms -A 1 | tail -1 | awk '{print $3}'").replace(/\D/g, '')*1e-9
  catch err
    perr err

# ###################################################################################################
#    shop
# ###################################################################################################
# in gramms
get_price_cmd = (type_id, level)->"lite-client -c 'runmethod #{contract_addr} getprice #{type_id} #{level}' 2>&1 | grep result"
get_price = (type_id, level)->
  try
    out = easy_exec get_price_cmd(type_id, level)
    return res_parse out
  catch err
    perr err
  return null

get_unit_count_cmd = (type_id, level)->"lite-client -c 'runmethod #{contract_addr} getunits #{my_work_chain} 0x#{my_wallet2} #{type_id} #{level}' 2>&1 | grep result"
get_unit_count = (type_id, level)->
  return perr "!my_work_chain" if !my_work_chain
  return perr "!my_wallet2" if !my_wallet2
  try
    out = easy_exec get_unit_count_cmd(type_id, level)
    return res_parse out
  catch err
    perr err
  return null

buy_unit = (type_id, level, count)->
  return perr "!my_wallet" if !my_wallet
  figure_cost = get_price(type_id, level)
  return false if !figure_cost?
  cost  = figure_cost*count
  # Но у нас не считается нормально газ... потому
  cost = Math.min cost, 0.5
  
  seqno = get_seqno()
  try
    easy_exec([
      "fift -s fift_scripts/buy-unit.fif #{type_id} #{level} #{count}"
      "fift -s fift_scripts/wallet.fif 'build/new-wallet' #{contract_addr} #{seqno} #{cost.toFixed(9)} './build/wallet-query' -B './build/buy-unit.boc'"
      "lite-client -c 'sendfile ./build/wallet-query.boc'"
    ].join(" && "))
    return true
  catch err
    perr err
    return false
  return

# ###################################################################################################
#    matchmaking
# ###################################################################################################

get_queue_len = (type_id, level, count)->
  try
    return res_parse easy_exec("lite-client -c 'runmethod #{contract_addr} getqueuelen' 2>&1 | grep result")
  catch err
    perr err
  null

line_up = ()->
  seqno = get_seqno()
  try
    # TODO 0.5 G HARDCODE
    easy_exec([
      "fift -s fift_scripts/line-up-queue.fif"
      "fift -s fift_scripts/wallet.fif 'build/new-wallet' #{contract_addr} #{seqno} 0.5 './build/wallet-query' -B './build/line-up.boc'"
      "lite-client -c 'sendfile ./build/wallet-query.boc'"
    ].join " && ")
    return true
  catch err
    perr err
  false
  
# ###################################################################################################
#    TON ws
# ###################################################################################################
return if argv.no_fift
WebSocketServer = require('ws').Server
ton_wss = new WebSocketServer
  port: argv.ton_ws_port

address_msg = ()->{switch: "address", address:my_wallet, my_work_chain, my_wallet2}
balance_msg = ()->{switch: "balance", balance:my_balance}

ton_wss.on 'connection', (con)->
  con.write = (msg)->
    if typeof msg == 'string' or msg instanceof Buffer
      return con.send msg, (err)->
        perr 'ws', err if err
    return con.send JSON.stringify(msg), (err)->
      perr 'ws', err if err
  con.write address_msg()
  con.write balance_msg()
  con.on "message", (msg)->
    try
      data = JSON.parse msg
    catch err
      perr err
      return
    switch data.switch
      # ###################################################################################################
      #    shop/figures/player figures etc
      # ###################################################################################################
      when "get_price"
        if !data.unit_list
          perr "!data.unit_list"
          return
        
        for unit in data.unit_list
          # TOO slow for bulk
          price = get_price unit.id, unit.level
          con.write {
            switch: "get_price"
            unit_list : [{
              id    : unit.id
              level : unit.level
              price
            }]
          }
        
      when "get_price_multi_exec"
        if !data.unit_list
          perr "!data.unit_list"
          return
        
        ctx_list = []
        for unit in data.unit_list
          # TOO slow for bulk
          cmd = get_price_cmd unit.id, unit.level
          ctx_list.push {unit, cmd}
        
        multi_exec {
          ctx_list
          cb : (err, ctx)->
            return perr err, ctx if err
            {unit, res} = ctx
            con.write {
              switch: "get_price"
              unit_list : [{
                id    : unit.id
                level : unit.level
                price : res_parse res
              }]
            }
        }
      
      when "get_unit_count"
        if !data.unit_list
          perr "!data.unit_list"
          return
        
        for unit in data.unit_list
          # TOO slow for bulk
          count = get_unit_count unit.id, unit.level
          con.write {
            switch: "get_unit_count"
            unit_list : [{
              id    : unit.id
              level : unit.level
              count
            }]
          }
        
      when "get_unit_count_multi_exec"
        return perr "!data.unit_list" if !data.unit_list
        ctx_list = []
        for unit in data.unit_list
          # TOO slow for bulk
          cmd = get_unit_count_cmd unit.id, unit.level
          ctx_list.push {unit, cmd}
        
        multi_exec {
          ctx_list
          cb : (err, ctx)->
            return perr err, ctx if err
            {unit, res} = ctx
            con.write {
              switch: "get_unit_count"
              unit_list : [{
                id    : unit.id
                level : unit.level
                count : res_parse res
              }]
            }
        }
      
      when "buy_unit"
        return perr "!data.id"    if !data.id
        return perr "!data.level" if !data.level
        return perr "!data.count" if !data.count
        result = buy_unit data.id, data.level, data.count
        con.write {
          uid : data.uid
          result
        }
      # ###################################################################################################
      #    matchmaking
      # ###################################################################################################
      when "get_queue_len"
        result = get_queue_len()
        con.write {
          switch : "get_queue_len"
          result
        }
      
      when "line_up"
        # Там у Насти баг, потому посылаем от фонаря
        # return perr "!unit.unit_list" if !data.unit_list
        # # **** же костыль
        # list = []
        # list.push """
        # // add your units for match in form:
        # //
        # // UNIT_ID CONTER create-units-per-level
        # // LEVEL add-units-per-level
        # """
        # for unit in data.unit_list
        #   return perr "!unit.id"    if !unit.id
        #   return perr "!unit.count" if !unit.count
        #   return perr "!unit.level" if !unit.level
        #   
        #   list.push """
        #   #{unit.id} #{unit.count} create-units-per-level
        #   #{unit.level} add-units-per-level
        #   """
        # fs.writeFileSync "fift_scripts/units-source.fif", list.join "\n\n"
        result = line_up()
        con.write {
          switch : "line_up"
          result
        }
      
  return

ton_wss.write = (msg)->
  ton_wss.clients.forEach (con)-> # FUCK ws@2.2.0
    con.write msg
  return

do ()->
  loop
    easy_exec "lite-client -c 'last' 2>&1"
    await setTimeout defer(), 1000

do ()->
  loop
    get_address()
    get_balance()
    ton_wss.write address_msg() # иногда с первого раза не приходит
    ton_wss.write balance_msg()
    await setTimeout defer(), 10000 # 10 sec

# ###################################################################################################
#    safety
# ###################################################################################################
process.on 'uncaughtException', (err, origin) ->
  perr err
