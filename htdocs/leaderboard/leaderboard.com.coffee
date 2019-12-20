module.exports =
  render : ()->
    table {class: "table"}
      tbody
        tr
          th "#"
          th {
            style:
              width: 100
          }, "HP"
          th {
            style:
              width: 100
          }, "Gold"
          th "Fig cost"
        for player, idx in @props.player_list
          tr
            td idx+1
            td 
              Leaderboard_bar {
                value : player.hp
                max   : 100
                color : "#5F5"
              }
            td
              Leaderboard_bar {
                value : player.gold
                max   : 100
                color : "#FE0"
              }
            td player.unit_list.map((t)->t.level).reduce (a, b)->a+b