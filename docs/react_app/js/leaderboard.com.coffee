(function() {
  var com_name, conf;

  com_name = "Leaderboard";

  conf = React.createClass(CKR.react_key_map(com_name, {
    render: function() {
      return table({
        "class": "table"
      }, (function(_this) {
        return function() {
          return tbody(function() {
            var idx, player, player_, _i, _len, _ref, _results;
            tr(function() {
              th("#");
              th({
                style: {
                  width: 50
                }
              }, "Lvl");
              th({
                style: {
                  width: 100
                }
              }, "HP");
              return th({
                style: {
                  width: 100
                }
              }, "Gold");
            });
            _ref = _this.props.player_list;
            _results = [];
            for (idx = _i = 0, _len = _ref.length; _i < _len; idx = ++_i) {
              player_ = _ref[idx];
              player = player_.state.final_state;
              _results.push(tr(function() {
                td(idx + 1);
                td(function() {
                  return div({
                    "class": "lvl_badge center_pad"
                  }, player.lvl);
                });
                td(function() {
                  return Leaderboard_bar({
                    value: player.hp,
                    max: 100,
                    color: "#5F5"
                  });
                });
                return td(function() {
                  return Leaderboard_bar({
                    value: player.gold,
                    max: 100,
                    color: "#FE0"
                  });
                });
              }));
            }
            return _results;
          });
        };
      })(this));
    }
  }));

  define_com("Leaderboard", conf);

}).call(this);
