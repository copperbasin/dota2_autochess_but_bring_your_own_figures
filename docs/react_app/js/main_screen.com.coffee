(function() {
  var com_name, conf;

  com_name = "Scene_main_screen";

  conf = React.createClass(CKR.react_key_map(com_name, {
    state: {
      line_up_check: false
    },
    listener_price_update: null,
    mount: function() {
      bg_change("img/knight_bg.jpg");
      this.set_state({
        line_up_check: ton.line_up_check()
      });
      return ton.on("price_update", this.listener_price_update = (function(_this) {
        return function() {
          return _this.set_state({
            line_up_check: ton.line_up_check()
          });
        };
      })(this));
    },
    unmount: function() {
      return ton.off("price_update", this.listener_price_update);
    },
    render: function() {
      return div({
        "class": "center pad_top"
      }, (function(_this) {
        return function() {
          div({
            "class": "main_menu_item"
          }, function() {
            if (_this.state.line_up_check) {
              return Start_button({
                label: "Start game",
                on_click: function() {
                  return router_set("queue");
                }
              });
            } else {
              return Start_button({
                label: "Start game",
                disabled: true
              });
            }
          });
          div({
            "class": "main_menu_item"
          }, function() {
            return Start_button({
              label: "Shop",
              on_click: function() {
                return router_set("shop");
              }
            });
          });
          return div({
            "class": "main_menu_item"
          }, function() {
            return Start_button({
              label: "Practice",
              on_click: function() {
                return router_set("play_with_bot");
              }
            });
          });
        };
      })(this));
    }
  }));

  define_com("Scene_main_screen", conf);

}).call(this);
