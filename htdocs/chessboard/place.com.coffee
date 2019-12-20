module.exports =
  unit_list : []
  state : {
    unit_position_hash: {}
  }
  
  mount : ()->
    # TEST only
    unit_position_hash = {}
    x = 0
    y = 0
    for unit in window.unit_list
      unit_position_hash["#{x},#{y}"] = { type : unit.name }
      x++
      if x >= 8
        x = 0
        y++
    @set_state {unit_position_hash}
    return
  
  render : ()->
    div {class: "background_pad"}
      table {class:"table_chessboard"}
        tbody
          for y in [7 .. 0]
            tr
              for x in [0 .. 7]
                unit = @state.unit_position_hash["#{x},#{y}"]
                td {
                  class : if (x + y) % 2 == 0 then "odd" else "even"
                }
                  if unit
                    img {
                      # src : "img/dota/#{unit.type}_minimap_icon.png"
                      src : "img/dota/#{unit.type}_icon.png"
                    }
                  else
                    img