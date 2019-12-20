module.exports =
  
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
    idx = 0
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
              if y
                span "+#{2*y} G"