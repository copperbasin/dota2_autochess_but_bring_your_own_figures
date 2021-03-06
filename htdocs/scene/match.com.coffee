module.exports =
  unit_list : []
  state :
    waiting : true
    right_panel : "shop"
    phase : "buy"
  
  buy_state : null
  match_update_handler : null
  mount : ()->
    bg_change "img/battle_bg.jpg"
    
    if !ton.match_serialized
      ton.get_match_request()
      @game = new Net_game {
        seed        : 1
        battle_seed : 1
        shop_unit_list : []
        match_player_list : [{
          id : localStorage.player_id
          nickname : "nickname"
        }]
      }
      @buy_state = @game.current_player.state
      window.debug_game = @game
    else
      @sync()
    
    ton.on "match_get", @match_update_handler = ()=>
      @sync()
    
    return
  
  sync : ()->
    @game = new Net_game ton.match_serialized
    @buy_state = @game.current_player.state
    @force_update()
  
  unmount : ()->
    clearTimeout @timeout_waiting
    ton.off "match_get", @match_update_handler
  
  commit : ()->
    @game.player_commit_server()
    @set_state {
      phase : "commit_wait"
    }
  
  battle_show_finish : ()->
    setTimeout ()=>
      @restart()
      @game.phase_new_round()
      if @game.active_player_list.length <= 1 or !@game.active_player_list.has @game.current_player
        @end_game()
      else
        @set_state battle_finish: true
    , 5000
  
  battle_force_finish : ()->
    @restart()
    @game.phase_new_round()
    if @game.active_player_list.length <= 1 or !@game.active_player_list.has @game.current_player
      @end_game()
    else
      @set_state phase: "buy"
    return
  
  end_game : ()->
    puts "end_game"
    # if ton.last_match_serialized
    #   @game = new Net_game ton.last_match_serialized
    # @set_state phase: "end_of_game"
    # ton.unit_count_request()
  
  render : ()->
    player_list = @game.player_list.clone()
    player_list.sort (a,b)->-(a.state.final_state.hp - b.state.final_state.hp)
    div {class: "center pad_top"}
      div {class: "background_pad"}
        # div {
        #   style:
        #     textAlign:"left"
        #     position: "abosolute"
        # }
        #   Back_button {
        #     on_click : ()=>
        #       router_set "main"
        #   }
        switch @state.phase
          when "buy"
            div {class:"battle_caption"}, "Phase: #{@state.phase}"
            Match_player_stats @buy_state.final_state
            Board_buy {
              state : @buy_state
              leaderboard_player_list : player_list
              on_change : ()=>
                @force_update()
            }
            Start_button {
              label : "Ready"
              on_click : ()=>
                @commit()
            }
            # if ton.commit_ts_left
              # Countdown {
                # ts      : ton.commit_ts_left
                # start_ts: ton.commit_ts_left_set_ts
              # }
          when "commit_wait"
            div {class:"battle_caption"}, "Phase: Wait for other players"
            table
              tbody
                tr
                  td
                    Board_buy {
                      state   : @buy_state
                      readonly: true
                    }
                  td {
                    style:
                      verticalAlign:"top"
                  }
                    table {class:"table"}
                      tbody
                        tr
                          th "Nickname"
                          th "HP"
                          th "Gold"
                          th "Ready"
                        for player in player_list
                          tr
                            td player.nickname
                            td player.state.final_state.hp
                            td player.state.final_state.gold
                            td 
                              if player.is_commit_done
                                img {
                                    class : "s_icon"
                                    src : "img/yes.png"
                                  }
                              else
                                img {
                                  class : "s_icon"
                                  src : "img/no.png"
                                }
                    # Countdown {
                      # ts      : ton.commit_ts_left
                      # start_ts: ton.commit_ts_left_set_ts
                    # }
          when "battle_calc"
            div {class:"battle_caption"}, "Phase: Calculating battle result"
            Board_buy {
              state   : @buy_state
              readonly: true
            }
          when "consensus_wait"
            div {class:"battle_caption"}, "Phase: Wait for consensus"
            Board_buy {
              state   : @buy_state
              readonly: true
            }
          
          when "battle"
            div {class:"battle_caption"}, "Phase: Show battle"
            Match_player_stats @buy_state.final_state
            Board_battle {
              start_state:@battle_start_state
              on_finish : (result, battle_final_state)=>
                @battle_show_finish()
            }
            Start_button {
              label : "End battle"
              # disabled : !@s  tate.battle_finish
              on_click : ()=>
                @battle_force_finish()
            }
            # if ton.commit_ts_left
              # Countdown {
                # ts      : ton.commit_ts_left
                # start_ts: ton.commit_ts_left_set_ts
              # }
          when "end_of_game"
            div {class:"battle_caption"}, "End of game"
            table {class:"table"}
              tbody
                tr
                  td "Player name"
                  td "HP left"
                  td "Gold left"
                  td "Reward"
                  # TODO units left
                for player in player_list
                  tr
                    td player.nickname
                    td player.state.final_state.hp
                    td player.state.final_state.gold
                    td
                      if player.last_game_reward
                        for figure_name in player.last_game_reward
                          [unit_id, level] = figure_name.split("_")
                          unit = unit_id_hash[unit_id]
                          Unit_icon_render {unit, s:true}
                          span unit
            Start_button {
              label : "End game"
              on_click : ()=>
                router_set "main"
            }