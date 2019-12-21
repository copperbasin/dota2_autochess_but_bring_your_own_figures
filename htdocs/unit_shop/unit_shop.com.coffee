module.exports =
  state : {
    filter_level        : 'none'
    filter_only_combo   : "false" # NOT used now
    filter_class_list   : []
    filter_spec_list    : []
    
    # key type
    # player have
    player_unit_hash : {} # get from smart contract
    # to buy
    to_buy_unit_hash : {}
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
    filter_only_combo   = JSON.parse @state.filter_only_combo
    
    table {
      class: "h_layout_table reset_font center_pad"
      style:
        width : 220+520
    }
      tbody
        tr
          td {
            style:
              width: 220
          }
            table
              tbody
                tr
                  td "Level"
                  td {
                    style:
                      width: 100
                  }
                    Tab_bar {
                      hash : {
                        # DO NOT DELETE SPACE
                        'none': 'None'
                        ' 1': '1'
                        ' 2': '2'
                        ' 3': '3'
                        ' 4': '4'
                        ' 5': '5'
                      }
                      center : true
                      value: @state.filter_level
                      on_change : (filter_level)=>
                        @set_state {filter_level}
                    }
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
                tr
                  td {colSpan: 2}, "Class"
                for _class in class_list
                  do (_class)=>
                    tr {
                      on_click : (include)=>
                        {filter_class_list} = @state
                        if filter_class_list.has _class.name
                          filter_class_list.remove _class.name
                        else
                          filter_class_list.push _class.name
                        @set_state {filter_class_list}
                    }
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
                tr
                  td {colSpan: 2}, "Spec"
                for spec in spec_list
                  do (spec)=>
                    tr {
                      on_click : (include)=>
                        {filter_spec_list} = @state
                        if filter_spec_list.has spec.name
                          filter_spec_list.remove spec.name
                        else
                          filter_spec_list.push spec.name
                        @set_state {filter_spec_list}
                    }
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
                tr
                  td {colSpan : 2}
                    total_count = 0
                    for k,v of @state.to_buy_unit_hash
                      total_count += v
                    total_cost = total_count*figure_cost
                    div "Total cost: #{total_cost}"
                    if total_count == 0
                      Start_button {
                        disabled: true
                        label: "Buy"
                      }
                    else
                      Start_button {
                        label: "Buy #{total_count}"
                      }
          td {
            style:
              width: 550
          }
            div {
              class: "scroll_container"
              style:
                height: 885
            }
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
                    th "available"
                    th "to buy"
                  limit = @props.limit or 14 # any level fits
                  left = limit
                  for unit in @props.shop_unit_list
                    continue if filter_level?         and unit.level != filter_level
                    if @props.available_unit_list?
                      # NOT USED now
                      check_same  = @check_same  unit
                      check_class = @check_class unit
                      check_spec  = @check_spec  unit
                      continue if filter_only_combo and (!check_class and !check_spec)
                    else
                      check_same = check_class = check_spec = false
                    
                    need_check = @state.filter_spec_list.length or @state.filter_class_list.length
                    pass = false
                    pass = true if @state.filter_spec_list.length and @state.filter_spec_list.has unit.spec
                    pass = true if @state.filter_class_list.length and @state.filter_class_list.has unit.class
                    continue if need_check and !pass
                    
                    if left == 0
                      tr
                        td {colSpan}, "use filters"
                      break
                    left--
                    default_class = ""
                    
                    tr
                      td {class : default_class}
                        Unit_icon_render {unit, s:true}
                      td {class: if check_same then "check_pass" else default_class}
                        unit.display_name
                      td {class : default_class}
                        unit.level
                      td {class: if check_class then "check_pass" else default_class}
                        unit.class
                      td {class: if check_spec then "check_pass" else default_class}
                        unit.spec
                      td {class: default_class}
                        @state.player_unit_hash[unit.type] or 0
                      td {class: default_class}
                        do (unit)=>
                          Number_input {
                            value : @state.to_buy_unit_hash[unit.type] or 0
                            on_change : (value)=>
                              value = 0 if value < 0 # плохо работает, но хотя бы так
                              to_buy_unit_hash = clone @state.to_buy_unit_hash
                              to_buy_unit_hash[unit.type] = value
                              @set_state {to_buy_unit_hash}
                          }
                  if left == limit
                    tr
                      td {colSpan}, "No units"

  