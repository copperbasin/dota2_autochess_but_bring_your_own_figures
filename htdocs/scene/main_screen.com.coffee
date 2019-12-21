module.exports =
  mount : ()->
    bg_change "img/knight_bg.jpg"
  
  render : ()->
    div {class: "center pad_top"}
      div {class:"main_menu_item"}
        Start_button {
          label : "Start game"
          on_click : ()=>
            router_set "queue"
        }
      div {class:"main_menu_item"}
        Start_button {
          label : "Shop"
          on_click : ()=>
            router_set "shop"
        }
  