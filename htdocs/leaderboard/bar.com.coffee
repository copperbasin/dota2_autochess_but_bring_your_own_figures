module.exports =
  render : ()->
    {value, max, color} = @props
    color ?= "#000"
    if max?
      progress {
        value : value
        max   : max
      }, "#{value}"
      div {class: "progress"}
        div {
          style:
            width : "#{Math.round 100*value/max}%"
            background : color
        }
      # div "#{value}/#{max}"
    else
      div "#{value}"