(function() {
  var com_name, conf;

  com_name = "Scene_match";

  conf = React.createClass(CKR.react_key_map(com_name, {
    state: {
      phase: "buy",
      battle_finish: false
    },
    buy_state: null,
    battle_start_state: null,
    mount: function() {
      bg_change("img/battle_bg.jpg");
      ton.on("update_commit_state", this.on_update_commit_state = (function(_this) {
        return function() {
          return _this.force_update();
        };
      })(this));
      ton.on("battle_start", this.on_update_commit_state = (function(_this) {
        return function() {
          return _this.restart();
        };
      })(this));
      ton.on("battle_finish", this.on_update_commit_state = (function(_this) {
        return function() {
          _this.game.phase_consensus();
          _this.battle_start_state = _this.game.board_list[_this.game.active_player_list.idx(_this.game.current_player)].gen_emulator_start_state();
          _this.set_state({
            phase: "battle"
          });
        };
      })(this));
      this.restart();
    },
    unmount: function() {
      return ton.off("update_commit_state", this.on_update_commit_state);
    },
    restart: function() {
      this.game = new Net_game(ton.match_serialized);
      if (!this.game.current_player) {
        perr("!@game.current_player");
        return;
      }
      this.buy_state = this.game.current_player.state;
      window.debug_game = this.game;
      if (this.game.match_ready && this.state.phase === "commit_wait") {
        this.set_state({
          phase: "battle_calc"
        });
        call_later((function(_this) {
          return function() {
            _this.game.sync(ton.match_serialized);
            _this.game.phase_calc_client();
            return _this.set_state({
              phase: "consensus_wait"
            });
          };
        })(this));
      } else if (this.game.current_player.is_commit_done) {
        this.set_state({
          phase: "commit_wait"
        });
      }
    },
    commit: function() {
      this.game.player_commit_server();
      return this.set_state({
        phase: "commit_wait"
      });
    },
    battle_show_finish: function() {
      return setTimeout((function(_this) {
        return function() {
          _this.restart();
          _this.game.phase_new_round();
          if (_this.game.active_player_list.length <= 1 || !_this.game.active_player_list.has(_this.game.current_player)) {
            return _this.end_game();
          } else {
            return _this.set_state({
              battle_finish: true
            });
          }
        };
      })(this), 5000);
    },
    battle_force_finish: function() {
      this.restart();
      this.game.phase_new_round();
      if (this.game.active_player_list.length <= 1 || !this.game.active_player_list.has(this.game.current_player)) {
        this.end_game();
      } else {
        this.set_state({
          phase: "buy"
        });
      }
    },
    end_game: function() {
      if (ton.last_match_serialized) {
        this.game = new Net_game(ton.last_match_serialized);
      }
      this.set_state({
        phase: "end_of_game"
      });
      return ton.unit_count_request();
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
                  leaderboard_player_list: player_list,
                  on_change: function() {
                    return _this.force_update();
                  }
                });
                Start_button({
                  label: "Ready",
                  on_click: function() {
                    return _this.commit();
                  }
                });
                if (ton.commit_ts_left) {
                  return Countdown({
                    ts: ton.commit_ts_left,
                    start_ts: ton.commit_ts_left_set_ts
                  });
                }
                break;
              case "commit_wait":
                div({
                  "class": "battle_caption"
                }, "Phase: Wait for other players");
                return table(function() {
                  return tbody(function() {
                    return tr(function() {
                      td(function() {
                        return Board_buy({
                          state: _this.buy_state,
                          readonly: true
                        });
                      });
                      return td({
                        style: {
                          verticalAlign: "top"
                        }
                      }, function() {
                        table({
                          "class": "table"
                        }, function() {
                          return tbody(function() {
                            var player, _i, _len, _results;
                            tr(function() {
                              th("Nickname");
                              th("HP");
                              th("Gold");
                              return th("Ready");
                            });
                            _results = [];
                            for (_i = 0, _len = player_list.length; _i < _len; _i++) {
                              player = player_list[_i];
                              _results.push(tr(function() {
                                td(player.nickname);
                                td(player.state.final_state.hp);
                                td(player.state.final_state.gold);
                                return td(function() {
                                  if (player.is_commit_done) {
                                    return img({
                                      "class": "s_icon",
                                      src: "img/yes.png"
                                    });
                                  } else {
                                    return img({
                                      "class": "s_icon",
                                      src: "img/no.png"
                                    });
                                  }
                                });
                              }));
                            }
                            return _results;
                          });
                        });
                        return Countdown({
                          ts: ton.commit_ts_left,
                          start_ts: ton.commit_ts_left_set_ts
                        });
                      });
                    });
                  });
                });
              case "battle_calc":
                div({
                  "class": "battle_caption"
                }, "Phase: Calculating battle result");
                return Board_buy({
                  state: _this.buy_state,
                  readonly: true
                });
              case "consensus_wait":
                div({
                  "class": "battle_caption"
                }, "Phase: Wait for consensus");
                return Board_buy({
                  state: _this.buy_state,
                  readonly: true
                });
              case "battle":
                div({
                  "class": "battle_caption"
                }, "Phase: Show battle");
                Match_player_stats(_this.buy_state.final_state);
                Board_battle({
                  start_state: _this.battle_start_state,
                  on_finish: function(result, battle_final_state) {
                    return _this.battle_show_finish();
                  }
                });
                Start_button({
                  label: "End battle",
                  on_click: function() {
                    return _this.battle_force_finish();
                  }
                });
                if (ton.commit_ts_left) {
                  return Countdown({
                    ts: ton.commit_ts_left,
                    start_ts: ton.commit_ts_left_set_ts
                  });
                }
                break;
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
                      td("Gold left");
                      return td("Reward");
                    });
                    _results = [];
                    for (_i = 0, _len = player_list.length; _i < _len; _i++) {
                      player = player_list[_i];
                      _results.push(tr(function() {
                        td(player.nickname);
                        td(player.state.final_state.hp);
                        td(player.state.final_state.gold);
                        return td(function() {
                          var figure_name, level, unit, unit_id, _j, _len1, _ref, _ref1, _results1;
                          if (player.last_game_reward) {
                            _ref = player.last_game_reward;
                            _results1 = [];
                            for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
                              figure_name = _ref[_j];
                              _ref1 = figure_name.split("_"), unit_id = _ref1[0], level = _ref1[1];
                              unit = unit_id_hash[unit_id];
                              Unit_icon_render({
                                unit: unit,
                                s: true
                              });
                              _results1.push(span(unit));
                            }
                            return _results1;
                          }
                        });
                      }));
                    }
                    return _results;
                  });
                });
                return Start_button({
                  label: "End game",
                  on_click: function() {
                    return router_set("main");
                  }
                });
            }
          });
        };
      })(this));
    }
  }));

  define_com("Scene_match", conf);

}).call(this);
