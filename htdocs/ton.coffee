ws_protocol = if location.protocol == 'http:' then "ws:" else "wss:"
window.ws_ton = new Websocket_wrap "#{ws_protocol}//#{location.hostname}:1338"
json_cmp = (a,b)->JSON.stringify(a) == JSON.stringify(b)

class TON_account
  balance : -1
  address : "???"
  owned_hash      : {}
  unit_price_hash : {} # id -> id level price
  
  event_mixin @
  constructor:()->
    event_mixin_constructor @
    @unit_price_hash = {}
    @unit_price_request()
    @unit_count_request()
  
  unit_price_request : ()->
    req_unit_list = []
    for unit in unit_list
      req_unit_list.push {
        id    : unit.id
        level : unit.level
      }
    
    ws_ton.write {
      # switch    : "get_price"
      switch    : "get_price_multi_exec"
      unit_list : req_unit_list
    }
    return
  
  unit_count_request : ()->
    req_unit_list = []
    for unit in unit_list
      req_unit_list.push {
        id    : unit.id
        level : unit.level
      }
    
    ws_ton.write {
      switch    : "get_unit_count_multi_exec"
      unit_list : req_unit_list
    }
    return

window.ton = new TON_account
window.ws_ton.on "data", (data)->
  switch data.switch
    when "balance"
      if ton.balance != data.balance
        ton.balance = data.balance
        ton.dispatch "balance", data.balance
    
    when "address"
      if ton.address != data.address
        ton.address = data.address
        ton.dispatch "address", data.address
    
    when "get_price"
      need_update = false
      for unit in data.unit_list
        if !json_cmp(ton.unit_price_hash[unit.id], unit)
          ton.unit_price_hash[unit.id] = unit
          need_update = true
      
      if need_update
        ton.dispatch "price_update"
    
    when "get_price"
      need_update = false
      for unit in data.unit_list
        if !json_cmp(ton.unit_price_hash[unit.id], unit)
          ton.unit_price_hash[unit.id] = unit
          need_update = true
      
      if need_update
        ton.dispatch "price_update"
    
    when "get_unit_count"
      need_update = false
      for unit in data.unit_list
        if !json_cmp(ton.unit_price_hash[unit.id], unit)
          ton.owned_hash[unit.id] = unit
          need_update = true
      
      if need_update
        ton.dispatch "count_update"
    
  return
