(function() {
  var com_name, conf;

  com_name = "Scene_play_with_bot";

  conf = React.createClass(CKR.react_key_map(com_name, {
    state: {
      phase: "buy",
      battle_finish: false
    },
    buy_state: null,
    battle_start_state: null,
    bot_state: null,
    mount: function() {
      bg_change("img/battle_bg.jpg");
      this.restart();
    },
    restart: function() {
      this.game = new Practice_game;
      this.buy_state = this.game.player_list[0].state;
      this.bot_state = this.game.player_list[1].state;
      window.debug_game = this.game;
      return window.debug_bot_state = this.bot_state;
    },
    commit_and_battle_start: function() {
      this.game.phase_buy_finish();
      this.battle_start_state = prepare_battle(this.buy_state.final_state, this.bot_state.final_state);
      return this.set_state({
        phase: "battle",
        battle_finish: false
      });
    },
    battle_finish: function(result, battle_final_state) {
      this.game.phase_battle_finish(result, battle_final_state);
      if (this.game.active_player_list.length <= 1) {
        return this.set_state({
          phase: "end_of_game"
        });
      } else {
        return this.set_state({
          battle_finish: true
        });
      }
    },
    render: function() {
      var player_list;
      player_list = this.game.player_list.clone();
      player_list.sort(function(a, b) {
        return -(a.state.final_state.hp - b.state.final_state.hp);
      });
      return div({
        "class": "center pad_top"
      }, (function(_this) {
        return function() {
          return div({
            "class": "background_pad"
          }, function() {
            switch (_this.state.phase) {
              case "buy":
                div({
                  "class": "battle_caption"
                }, "Phase: " + _this.state.phase);
                Match_player_stats(_this.buy_state.final_state);
                Board_buy({
                  state: _this.buy_state,
                  leaderboard_player_list: player_list
                });
                return Start_button({
                  label: "To battle",
                  on_click: function() {
                    return _this.commit_and_battle_start();
                  }
                });
              case "battle":
                div({
                  "class": "battle_caption"
                }, "Phase: " + _this.state.phase);
                Match_player_stats(_this.buy_state.final_state);
                Board_battle({
                  start_state: _this.battle_start_state,
                  on_finish: function(result, battle_final_state) {
                    return _this.battle_finish(result, battle_final_state);
                  }
                });
                return Start_button({
                  label: "End battle",
                  disabled: !_this.state.battle_finish,
                  on_click: function() {
                    return _this.set_state({
                      phase: "buy"
                    });
                  }
                });
              case "end_of_game":
                div({
                  "class": "battle_caption"
                }, "End of game");
                table({
                  "class": "table"
                }, function() {
                  return tbody(function() {
                    var player, _i, _len, _results;
                    tr(function() {
                      td("Player name");
                      td("HP left");
                      return td("Gold left");
                    });
                    _results = [];
                    for (_i = 0, _len = player_list.length; _i < _len; _i++) {
                      player = player_list[_i];
                      _results.push(tr(function() {
                        td(player.nickname);
                        td(player.state.final_state.hp);
                        return td(player.state.final_state.gold);
                      }));
                    }
                    return _results;
                  });
                });
                return Start_button({
                  label: "Restart",
                  on_click: function() {
                    _this.restart();
                    return _this.set_state({
                      phase: "buy"
                    });
                  }
                });
            }
          });
        };
      })(this));
    }
  }));

  define_com("Scene_play_with_bot", conf);

}).call(this);
