module.exports =
  mount : ()->
    bg_change "img/knight_bg.jpg"
  
  render : ()->
    div {class: "center pad_top"}
      Start_button {
        label : "Start game"
        on_click : ()=>
          router_set "queue"
      }
  