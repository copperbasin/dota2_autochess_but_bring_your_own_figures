module.exports =
  state :
    show_queue      : false
    starting_battle : false
    player_count : 1
  
  timeout_details: null
  listener_queue : null
  mount : ()->
    bg_change "img/white_bg.jpg"
    ton.on "queue_len_update", @listener_queue = ()=>
      ton.get_match_id_request()
      @force_update()
    
    if !localStorage.queue_debug
      ws_ton.write {
        switch : "line_up"
        unit_list: ton.line_up_gen()
      }
    
    @timeout_details = setTimeout ()=>
      @set_state {show_queue:true}
    , 10000
    return
  
  unmount : ()->
    clearTimeout @timeout_details
    ton.off "queue_len_update", @listener_queue
  
  render : ()->
    div {class: "center pad_top"}
      div {class: "background_pad"}
        if @state.starting_battle
          div "Starting battle"
        else
          div "Waiting"
          if @state.show_queue
            # i18n на коленке
            n = ton.queue_len
            if n == 1
              div "In queue #{n} player"
            else
              div "In queue #{n} players"
  