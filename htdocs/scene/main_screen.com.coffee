module.exports =
  mount : ()->
    bg_change "img/knight_bg.jpg"
  
  render : ()->
    div {class: "center pad_top"}
      div {class:"main_menu_item"}
        if ton.line_up_check()
          Start_button {
            label : "Start game"
            on_click : ()=>
              router_set "queue"
          }
        else
          Start_button {
            label : "Start game"
            disabled: true
          }
      div {class:"main_menu_item"}
        Start_button {
          label : "Shop"
          on_click : ()=>
            router_set "shop"
        }
  