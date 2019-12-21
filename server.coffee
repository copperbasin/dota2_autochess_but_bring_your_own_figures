#!/usr/bin/env iced
### !pragma coverage-skip-block ###
{execSync} = require 'child_process'
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
delivery = require 'webcom'


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
  engine : {
    HACK_remove_module_exports : true
  }
  vendor : 'react_min'
  gz : true
}

# ###################################################################################################
#    TON stuff
# ###################################################################################################
WebSocketServer = require('ws').Server
ton_wss = new WebSocketServer
  port: argv.ton_ws_port

my_wallet = ""
my_balance = 0
get_address = ()->
  try
    my_wallet = execSync("fift -s fift_scripts/show-addr.fif 'build/new-wallet' | grep Bounce | awk '{print $6}'", {shell:"/bin/bash"}).toString().trim()
  catch err
    perr err

get_balance = ()->
  try
    my_balance = execSync("lite-client -c 'getaccount #{my_wallet}' 2>&1 | grep nanograms -A 1 | tail -1 | awk '{print $3}'").toString().replace(/\D/g, '')*1e-9
  catch err
    perr err


address_msg = ()->{switch: "address", address:my_wallet}
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
  return

ton_wss.write = (msg)->
  ton_wss.clients.forEach (con)-> # FUCK ws@2.2.0
    con.write msg
  return

do ()->
  loop
    get_address()
    get_balance()
    ton_wss.write balance_msg()
    await setTimeout defer(), 10000 # 10 sec
