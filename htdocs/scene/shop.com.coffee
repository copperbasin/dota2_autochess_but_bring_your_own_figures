module.exports =
  state :
    balance : 10
  mount : ()->
    bg_change "img/shop_bg.jpg"
  
  render : ()->
    div {class: "center pad_top"}
      div {class: "background_pad"}
        div {
          style:
            textAlign:"left"
            position: "abosolute"
        }
          Back_button {
            on_click : ()=>
              router_set "main"
          }
        div "Your ton balance #{@state.balance} gramm"
        Unit_shop {
          # костыль
          available_unit_list : []
          shop_unit_list      : unit_list
          limit               : 100500
        }
  