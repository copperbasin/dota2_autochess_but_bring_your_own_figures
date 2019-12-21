module.exports =
  state :
    balance : 10
  mount : ()->
    bg_change "img/knight_bg.jpg"
  
  render : ()->
    div {class: "center pad_top"}
      div {class: "background_pad"}
        div "Your ton balance #{@state.balance} gramm"
        Unit_shop {
          # костыль
          available_unit_list : []
          shop_unit_list      : unit_list
          limit               : 100500
        }
  