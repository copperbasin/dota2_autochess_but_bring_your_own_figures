(function() {
  var com_name, conf;

  com_name = "Scene_queue";

  conf = React.createClass(CKR.react_key_map(com_name, {
    state: {
      show_queue: false,
      starting_battle: false,
      player_count: 1
    },
    listener_queue: null,
    queue_pool_interval: null,
    listener_match_found: null,
    line_up_interval: null,
    mount: function() {
      bg_change("img/white_bg.jpg");
      ton.on("queue_len_update", this.listener_queue = (function(_this) {
        return function() {
          return _this.force_update();
        };
      })(this));
      this.queue_pool_interval = setInterval((function(_this) {
        return function() {
          return ton.get_queue_len_request();
        };
      })(this), 1000);
      ws_ton.on("data", this.listener_match_found = (function(_this) {
        return function(data) {
          if (data["switch"] === "match_found") {
            ton.match_serialized = data.match;
            _this.set_state({
              starting_battle: true
            });
            return _this.timeout_start_battle = setTimeout(function() {
              return router_set("match");
            }, 1000);
          }
        };
      })(this));
      this.timeout_details = setTimeout((function(_this) {
        return function() {
          return _this.set_state({
            show_queue: true
          });
        };
      })(this), 2000);
      return this.line_up_interval = setInterval(function() {
        return ws_ton.write({
          player_id: localStorage.player_id,
          "switch": "line_up",
          unit_list: ton.line_up_gen()
        });
      }, 1000);
    },
    unmount: function() {
      clearInterval(this.line_up_interval);
      clearInterval(this.queue_pool_interval);
      clearTimeout(this.timeout_details);
      clearTimeout(this.timeout_start_battle);
      ton.off("queue_len_update", this.listener_queue);
      return ws_ton.off("data", this.listener_match_found);
    },
    render: function() {
      return div({
        "class": "center pad_top"
      }, (function(_this) {
        return function() {
          return div({
            "class": "background_pad"
          }, function() {
            var n;
            if (_this.state.starting_battle) {
              return div("Starting battle");
            } else {
              div("Waiting");
              if (_this.state.show_queue) {
                n = ton.queue_len;
                if (n === 1) {
                  return div("In queue " + n + " player");
                } else {
                  return div("In queue " + n + " players");
                }
              }
            }
          });
        };
      })(this));
    }
  }));

  define_com("Scene_queue", conf);

}).call(this);
