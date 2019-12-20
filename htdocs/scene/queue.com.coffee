module.exports =
  state :
    show_queue : false
    starting_battle : false
    player_count : 1
  
  mount : ()->
    bg_change "img/white_bg.jpg"
    @timeout_details = setTimeout ()=>
      @set_state {show_queue:true}
    , 2000
    # EMULATION
    @interval_emulation = setInterval ()=>
      if @state.player_count >= 7
        @set_state {starting_battle: true}
        @timeout_start_battle = setTimeout ()=>
          router_set "match"
        , 1000
      else
        @set_state {player_count:@state.player_count+1}
    , 2000
    
    
  
  unmount : ()->
    clearTimeout @timeout_details
    clearTimeout @timeout_start_battle
    clearInterval @interval_emulation
  
  render : ()->
    div {class: "center pad_top"}
      div {class: "background_pad"}
        if @state.starting_battle
          div "Starting battle"
        else
          div "Waiting"
          if @state.show_queue
            # i18n на коленке
            n = @state.player_count
            if n == 1
              div "In queue #{n} player"
            else
              div "In queue #{n} players"
  