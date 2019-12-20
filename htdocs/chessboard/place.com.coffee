module.exports =
  render : ()->
    # TODO place...
    Chessboard_view {
      unit_list       : @props.unit_list
      unit_spare_list : @props.unit_spare_list
    }