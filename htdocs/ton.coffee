ws_protocol = if location.protocol == 'http:' then "ws:" else "wss:"
window.ws_ton = new Websocket_wrap "#{ws_protocol}//#{location.hostname}:1338"

class TON_account
  balance : -1
  address : "???"
  event_mixin @
  constructor:()->
    event_mixin_constructor @
  

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
  return
