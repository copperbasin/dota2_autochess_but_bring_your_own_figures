module.exports =
  state :
    waiting : true
  mount : ()->
    bg_change "img/battle_bg.jpg"
    # EMULATION
    @timeout_waiting = setTimeout ()=>
      @set_state {waiting:false}
    , 5000
  
  unmount : ()->
    clearTimeout @timeout_waiting
  
  render : ()->
    div {class: "center pad_top"}
      if @state.waiting
        div {class: "background_pad"}
          div "Waiting for players"
      
      Chessboard_place {}
  