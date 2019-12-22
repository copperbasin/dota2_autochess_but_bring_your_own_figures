module.exports =
  unit_list : []
  state :
    waiting : true
    right_panel : "shop"
  
  mount : ()->
    bg_change "img/battle_bg.jpg"
    # EMULATION
    @timeout_waiting = setTimeout ()=>
      @set_state {waiting:false}
    , 5000
    # TEST only
    @unit_list = []
    x = 0
    y = 0
    for unit, idx in window.unit_list
      # continue if idx % 12
      continue if idx != 5
      @unit_list.push {
        x
        y
        type  : unit.type
        class : unit.class
        spec  : unit.spec
      }
      x++
      if x >= 8
        x = 0
        y++
    
    @force_update()
    return
  
  unmount : ()->
    clearTimeout @timeout_waiting
  
  render : ()->
    # shop_unit_list = clone(unit_list).map (t, idx)->
      # t.roll_count  = idx % 3
      # t.total_count = idx % 9
      # return t
    shop_unit_list = clone(unit_list).map (t, idx)->
      t.bought  = idx >= 5
      return t
    player_list = [
      {
        hp    : 100
        gold  : 10
        unit_list : unit_list
        level : 5
      }
    ]
    
    div {class: "center pad_top"}
      if @state.waiting
        div {class: "background_pad"}
          div "Waiting for players"
      
      div {class: "background_pad"}
        table {
          class: "h_layout_table"
          style:
            width : "100%"
        }
          tbody
            tr
              td {
                style :
                  width : "45%"
              }
                Match_player_stats {
                  hp    : 100
                  gold  : 1
                  gold  : 1
                  exp   : 1
                  level : 1
                }
                Chessboard_place {
                  unit_list       : @unit_list
                  unit_spare_list : []
                }
              td {
                style :
                  width : "55%"
              }
                Tab_bar {
                  hash : {
                    'shop'        : 'Shop'
                    'leaderboard' : 'Leaderboard'
                  }
                  center : true
                  value: @state.right_panel
                  on_change : (right_panel)=>
                    @set_state {right_panel}
                }
                div {
                  style:
                    height: 10
                }
                switch @state.right_panel
                  when "shop"
                    Unit_selector {
                      shop_unit_list : shop_unit_list
                      available_unit_list : @unit_list
                    }
                  when "leaderboard"
                    Leaderboard {
                      player_list : player_list
                    }
                # Unit_shop_ingame {
                  # shop_unit_list : shop_unit_list
                  # available_unit_list : @unit_list
                  # player_level : 3
                  # player_gold  : 1
                # }
  