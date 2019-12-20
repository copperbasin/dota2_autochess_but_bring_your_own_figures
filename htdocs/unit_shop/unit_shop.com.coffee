module.exports =
  state : {
    filter_only_roll    : "true"
    filter_level        : 'none'
    filter_only_combo   : "false"
    filter_player_level : "true"
    filter_class_list   : []
    filter_spec_list    : []
  }
  
  check_same : (t)->
    for unit in @props.available_unit_list
      return true if t.type == unit.type
    false
  
  check_class : (t)->
    for unit in @props.available_unit_list
      continue if t.type == unit.type
      return true if t.class == unit.class
    false
  
  check_spec : (t)->
    for unit in @props.available_unit_list
      continue if t.type == unit.type
      return true if t.spec == unit.spec
    false
  
  render : ()->
    filter_level        = if @state.filter_level == 'none' then null else +@state.filter_level.trim()
    filter_only_roll    = JSON.parse @state.filter_only_roll
    filter_only_combo   = JSON.parse @state.filter_only_combo
    filter_player_level = JSON.parse @state.filter_player_level
    
    table {
      class: "h_layout_table reset_font"
      style:
        width : "100%"
    }
      tbody
        tr
          td
            table
              tbody
                # tr
                #   td "Only roll"
                #   td
                #     Tab_bar {
                #       hash : {
                #         'true': 'Yes'
                #         'false': 'No'
                #       }
                #       center : true
                #       value: @state.filter_only_roll
                #       on_change : (filter_only_roll)=>
                #         @set_state {filter_only_roll}
                #     }
                # tr
                #   td "Level"
                #   td {
                #     style:
                #       width: 100
                #   }
                #     Tab_bar {
                #       hash : {
                #         # DO NOT DELETE SPACE
                #         'none': 'None'
                #         ' 1': '1'
                #         ' 2': '2'
                #         ' 3': '3'
                #         ' 4': '4'
                #         ' 5': '5'
                #       }
                #       center : true
                #       value: @state.filter_level
                #       on_change : (filter_level)=>
                #         @set_state {filter_level}
                #     }
                # if @props.available_unit_list?
                #   tr
                #     td "Only combo"
                #     td
                #       Tab_bar {
                #         hash : {
                #           'true': 'Yes'
                #           'false': 'No'
                #         }
                #         center : true
                #         value: @state.filter_only_combo
                #         on_change : (filter_only_combo)=>
                #           @set_state {filter_only_combo}
                #       }
                # if @props.player_level?
                #   tr
                #     td "Available by level"
                #     td
                #       Tab_bar {
                #         hash : {
                #           'true': 'Yes'
                #           'false': 'No'
                #         }
                #         center : true
                #         value: @state.filter_player_level
                #         on_change : (filter_player_level)=>
                #           @set_state {filter_player_level}
                #       }
                for _class in class_list
                  tr
                    td _class.display_name
                    td
                      # TODO better checkbox
                      Checkbox {
                        value : @state.filter_class_list.has _class.name
                        on_change : (include)=>
                          {filter_class_list} = @state
                          if include
                            filter_class_list.push _class.name
                          else
                            filter_class_list.remove _class.name
                          @set_state {filter_class_list}
                      }
                for spec in spec_list
                  tr
                    td spec.display_name
                    td
                      # TODO better checkbox
                      Checkbox {
                        value : @state.filter_spec_list.has spec.name
                        on_change : (include)=>
                          {filter_spec_list} = @state
                          if include
                            filter_spec_list.push spec.name
                          else
                            filter_spec_list.remove spec.name
                          @set_state {filter_spec_list}
                      }
          td
            colSpan = 7
            table {class:"table shop_table"}
              tbody
                tr
                  th {
                    style:
                      width: 22
                  }
                  th {
                    style:
                      width: 120
                  }, "name"
                  th "lvl"
                  th "class"
                  th "spec"
                  th "roll"
                  th "total"
                limit = 14 # any level fits
                left = limit
                for unit in @props.shop_unit_list
                  continue if unit.total_count <= 0
                  continue if filter_only_roll      and unit.roll_count <= 0
                  continue if filter_player_level   and unit.level > @props.player_level
                  continue if filter_level?         and unit.level != filter_level
                  if @props.available_unit_list?
                    check_same  = @check_same  unit
                    check_class = @check_class unit
                    check_spec  = @check_spec  unit
                    continue if filter_only_combo and (!check_class and !check_spec)
                  else
                    check_same = check_class = check_spec = false
                  
                  if left == 0
                    tr
                      td {colSpan}, "use filters"
                    break
                  left--
                  default_class = ""
                  if @props.player_level? and unit.level > @props.player_level
                    default_class = "check_cant_afford"
                  check_ne_gold = false
                  if @props.player_gold? and unit.level > @props.player_gold
                    check_ne_gold = true
                  check_no_roll_count = 
                  tr
                    td {class : default_class}
                      Unit_icon_render {unit, s:true}
                    td {class: if check_same then "check_pass" else default_class}
                      unit.display_name
                    td {class : if check_ne_gold then "check_cant_afford" else default_class}
                      unit.level
                    td {class: if check_class then "check_pass" else default_class}
                      unit.class
                    td {class: if check_spec then "check_pass" else default_class}
                      unit.spec
                    td {class: if unit.roll_count <= 0 then "check_cant_afford" else default_class}
                      unit.roll_count
                    td {class: default_class}
                      unit.total_count
                if left == limit
                  tr
                    td {colSpan}, "No units"
                    
  