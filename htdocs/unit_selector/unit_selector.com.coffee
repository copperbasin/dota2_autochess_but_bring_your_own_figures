module.exports =
  state : {
    page : 0
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
    {shop_unit_list} = @props
    idx = 25*@state.page
    gold_incr = 2*5*@state.page
    table {class: "unit_selecor_table_wrap"}
      tbody
        tr
          td {
            class:  "unit_selecor_button_place"
          }
            if @state.page != 0
              Nav_button {
                label: "prev"
                on_click : ()=>
                  @set_state {page: @state.page-1}
                style :
                  width : "100%"
              }
        tr
          td
            table {class: "unit_selecor_table"}
              tbody
                for y in [0 ... 5]
                  tr
                    for x in [0 ... 5]
                      unit = shop_unit_list[idx++]
                      check_same  = @check_same  unit
                      check_class = @check_class unit
                      check_spec  = @check_spec  unit
                      
                      _class = ""
                      _class = "check_pass" if check_same or check_class or check_spec
                      _class = "bought"     if unit.bought
                      
                      td {class: _class}
                        Unit_icon_render {unit, xl:true}
                    td
                      extra_gold_value = 2*y + gold_incr
                      if extra_gold_value
                        span "+#{extra_gold_value} G"
        tr
          td {
            class:  "unit_selecor_button_place"
          }
            if shop_unit_list[idx]
              Nav_button {
                label: "next"
                on_click : ()=>
                  @set_state {page: @state.page+1}
                style :
                  width : "100%"
              }