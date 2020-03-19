(function() {
  var com_name, conf;

  com_name = "Board_buy";

  conf = React.createClass(CKR.react_key_map(com_name, {
    state: {
      right_panel: "shop"
    },
    controller: null,
    mount: function() {
      this.controller = new Board_buy_controller;
      this.controller.readonly = this.props.readonly;
      this.controller.state = this.props.state;
      this.controller.on_change = this.props.on_change;
      window.debug_shop_state = this.controller.state;
    },
    render: function() {
      this.controller.props_update(this.props);
      return table((function(_this) {
        return function() {
          return tbody(function() {
            return tr(function() {
              td({
                style: {
                  textAlign: "left",
                  width: battle_board_cell_size_px * 8 + 3,
                  height: battle_board_cell_size_px * 10,
                  width: 500
                }
              }, function() {
                return Canvas_multi({
                  layer_list: ["bg", "fg", "hover"],
                  canvas_cb: function(canvas_hash) {
                    return _this.controller.canvas_controller(canvas_hash);
                  },
                  gui: _this.controller,
                  ref_textarea: function($textarea) {
                    _this.controller.$textarea = $textarea;
                    return _this.controller.init();
                  }
                });
              });
              if (!_this.props.readonly) {
                return td({
                  style: {
                    verticalAlign: "top",
                    width: 500
                  }
                }, function() {
                  Tab_bar({
                    hash: {
                      "shop": "Shop",
                      "leaderboard": "Leaderboard"
                    },
                    center: true,
                    value: _this.state.right_panel,
                    on_change: function(right_panel) {
                      return _this.set_state({
                        right_panel: right_panel
                      });
                    }
                  });
                  switch (_this.state.right_panel) {
                    case "shop":
                      return Board_shop({
                        state: _this.controller.state,
                        on_change: _this.props.on_change,
                        on_board_change: function() {
                          return _this.controller.refresh();
                        }
                      });
                    case "leaderboard":
                      return Leaderboard({
                        player_list: _this.props.leaderboard_player_list
                      });
                  }
                });
              }
            });
          });
        };
      })(this));
    }
  }));

  define_com("Board_buy", conf);

}).call(this);
