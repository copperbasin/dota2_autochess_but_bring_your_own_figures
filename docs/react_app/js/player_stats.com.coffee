(function() {
  var com_name, conf;

  com_name = "Match_player_stats";

  conf = React.createClass(CKR.react_key_map(com_name, {
    render: function() {
      return table((function(_this) {
        return function() {
          return tbody(function() {
            return tr(function() {
              td("HP");
              td({
                style: {
                  width: 80
                }
              }, function() {
                return Leaderboard_bar({
                  value: _this.props.hp,
                  max: 100,
                  color: "#5F5"
                });
              });
              td("Gold");
              td({
                style: {
                  width: 80
                }
              }, function() {
                return Leaderboard_bar({
                  value: _this.props.gold,
                  max: 100,
                  color: "#FE0"
                });
              });
              td("Exp");
              td({
                style: {
                  width: 80
                }
              }, function() {
                return Leaderboard_bar({
                  value: _this.props.exp,
                  max: 100,
                  color: "#FE0"
                });
              });
              return td({
                "class": "lvl_badge"
              }, _this.props.lvl);
            });
          });
        };
      })(this));
    }
  }));

  define_com("Match_player_stats", conf);

}).call(this);
