module.exports =
  render : ()->
    unit_position_hash = {}
    for unit in @props.unit_list
      {x,y} = unit
      unit_position_hash["#{x},#{y}"] = unit
    unit_spare_position_hash = {}
    for unit in @props.unit_spare_list
      {x} = unit
      unit_spare_position_hash[x] = unit
    # TODO canvas
    table {class:"table_chessboard"}
      tbody
        for y in [7 .. 0]
          tr
            for x in [0 .. 7]
              unit = unit_position_hash["#{x},#{y}"]
              td {
                class : if (x + y) % 2 == 0 then "odd" else "even"
              }
                Unit_icon_render {unit}
        tr
          td {colSpan: 8, class: "spacer"}
        tr
          for x in [0 .. 7]
            unit = unit_spare_position_hash["#{x}"]
            td {
              class : "spare"
            }
              Unit_icon_render {unit}
        tr
          for x in [0 .. 7]
            unit = unit_spare_position_hash["#{x}"]
            td {
              class : "red_spare"
            }
              Unit_icon_render {unit}
            