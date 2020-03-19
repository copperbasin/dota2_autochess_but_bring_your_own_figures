(function() {
  var com_name, conf, __iced_k, __iced_k_noop;

  __iced_k = __iced_k_noop = function() {};

  com_name = "Unit_shop";

  conf = React.createClass(CKR.react_key_map(com_name, {
    state: {
      filter_level: 'none',
      filter_only_combo: "false",
      filter_class_list: [],
      filter_spec_list: [],
      balance: -1,
      to_buy_unit_hash: {},
      buy_in_progress: false,
      buy_status: ''
    },
    check_same: function(t) {
      var unit, _i, _len, _ref;
      _ref = this.props.available_unit_list;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        unit = _ref[_i];
        if (t.type === unit.type) {
          return true;
        }
      }
      return false;
    },
    check_class: function(t) {
      var unit, _i, _len, _ref;
      _ref = this.props.available_unit_list;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        unit = _ref[_i];
        if (t.type === unit.type) {
          continue;
        }
        if (t["class"] === unit["class"]) {
          return true;
        }
      }
      return false;
    },
    check_spec: function(t) {
      var unit, _i, _len, _ref;
      _ref = this.props.available_unit_list;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        unit = _ref[_i];
        if (t.type === unit.type) {
          continue;
        }
        if (t.spec === unit.spec) {
          return true;
        }
      }
      return false;
    },
    listener_balance: null,
    listener_price: null,
    listener_count: null,
    mount: function() {
      ton.on("balance", this.listener_balance = (function(_this) {
        return function(balance) {
          return _this.set_state({
            balance: balance
          });
        };
      })(this));
      ton.on("price_update", this.listener_price = (function(_this) {
        return function() {
          return _this.force_update();
        };
      })(this));
      return ton.on("count_update", this.listener_count = (function(_this) {
        return function() {
          return _this.force_update();
        };
      })(this));
    },
    unmount: function() {
      ton.off("balance", this.listener_balance);
      ton.off("price_update", this.listener_price);
      return ton.off("count_update", this.listener_count);
    },
    buy: function() {
      var buy_left, change_count, count, diff, id, id_list, k, new_val, old_owned_hash, old_val, retry, successful, to_buy_unit_hash, v, ___iced_passed_deferral, __iced_deferrals, __iced_k;
      __iced_k = __iced_k_noop;
      ___iced_passed_deferral = iced.findDeferral(arguments);
      this.set_state({
        buy_in_progress: true
      });
      old_owned_hash = clone(ton.owned_hash);
      (function(_this) {
        return (function(__iced_k) {
          __iced_deferrals = new iced.Deferrals(__iced_k, {
            parent: ___iced_passed_deferral
          });
          call_later(__iced_deferrals.defer({
            lineno: 44
          }));
          __iced_deferrals._fulfill();
        });
      })(this)((function(_this) {
        return function() {
          var _ref;
          id_list = [];
          _ref = _this.state.to_buy_unit_hash;
          for (id in _ref) {
            count = _ref[id];
            id_list.push(+id);
            ws_ton.write({
              player_id: localStorage.player_id,
              "switch": "buy_unit",
              id: id,
              level: ton.unit_price_hash[id].level,
              count: count
            });
          }
          (function(__iced_k) {
            __iced_deferrals = new iced.Deferrals(__iced_k, {
              parent: ___iced_passed_deferral
            });
            setTimeout(__iced_deferrals.defer({
              lineno: 55
            }), 1000);
            __iced_deferrals._fulfill();
          })(function() {
            successful = false;
            (function(__iced_k) {
              var _begin, _end, _i, _positive, _results, _step, _while;
              retry = 0;
              _begin = 0;
              _end = 30;
              if (_end > _begin) {
                _step = 1;
              } else {
                _step = -1;
              }
              _positive = _end > _begin;
              _while = function(__iced_k) {
                var _break, _continue, _next;
                _break = __iced_k;
                _continue = function() {
                  return iced.trampoline(function() {
                    retry += _step;
                    return _while(__iced_k);
                  });
                };
                _next = _continue;
                if (!!((_positive === true && retry >= 30) || (_positive === false && retry <= 30))) {
                  return _break();
                } else {

                  ton.unit_count_request(id_list);
                  (function(__iced_k) {
                    __iced_deferrals = new iced.Deferrals(__iced_k, {
                      parent: ___iced_passed_deferral
                    });
                    setTimeout(__iced_deferrals.defer({
                      lineno: 59
                    }), 1000);
                    __iced_deferrals._fulfill();
                  })(function() {
                    to_buy_unit_hash = clone(_this.state.to_buy_unit_hash);
                    change_count = 0;
                    for (k in old_owned_hash) {
                      old_val = old_owned_hash[k];
                      new_val = ton.owned_hash[k];
                      if (new_val.count === old_val.count) {
                        continue;
                      }
                      diff = new_val.count - old_val.count;
                      if (diff > 0) {
                        old_owned_hash[k] = new_val;
                        change_count++;
                      }
                      to_buy_unit_hash[k] -= diff;
                    }
                    puts("change_count=" + change_count);
                    (function(__iced_k) {
                      if (change_count === 0) {
                        (function(__iced_k) {
_continue()
                        })(__iced_k);
                      } else {
                        return __iced_k();
                      }
                    })(function() {
                      _this.set_state({
                        to_buy_unit_hash: to_buy_unit_hash
                      });
                      (function(__iced_k) {
                        __iced_deferrals = new iced.Deferrals(__iced_k, {
                          parent: ___iced_passed_deferral
                        });
                        call_later(__iced_deferrals.defer({
                          lineno: 73
                        }));
                        __iced_deferrals._fulfill();
                      })(function() {
                        var _ref1;
                        buy_left = 0;
                        _ref1 = _this.state.to_buy_unit_hash;
                        for (k in _ref1) {
                          v = _ref1[k];
                          buy_left += v;
                        }
                        puts("buy_left=" + buy_left);
                        (function(__iced_k) {
                          if (buy_left === 0) {
                            successful = true;
                            (function(__iced_k) {
_break()
                            })(__iced_k);
                          } else {
                            return __iced_k();
                          }
                        })(_next);
                      });
                    });
                  });
                }
              };
              _while(__iced_k);
            })(function() {
              _this.set_state({
                buy_in_progress: false,
                buy_status: successful ? 'successful' : 'failed'
              });
            });
          });
        };
      })(this));
    },
    render: function() {
      var filter_level, filter_only_combo;
      filter_level = this.state.filter_level === 'none' ? null : +this.state.filter_level.trim();
      filter_only_combo = JSON.parse(this.state.filter_only_combo);
      return table({
        "class": "h_layout_table reset_font center_pad",
        style: {
          width: 420 + 650
        }
      }, (function(_this) {
        return function() {
          return tbody(function() {
            tr(function() {
              return td({
                colSpan: 2
              }, function() {
                var count, equip_count, level_count_equipped_hash, level_count_owned_hash, unit, _i, _len, _ref;
                level_count_owned_hash = {
                  1: 0,
                  2: 0,
                  3: 0,
                  4: 0,
                  5: 0
                };
                level_count_equipped_hash = {
                  1: 0,
                  2: 0,
                  3: 0,
                  4: 0,
                  5: 0
                };
                for (_i = 0, _len = unit_list.length; _i < _len; _i++) {
                  unit = unit_list[_i];
                  if (count = (_ref = ton.owned_hash[unit.id]) != null ? _ref.count : void 0) {
                    level_count_owned_hash[unit.level] += count;
                    if (equip_count = ton.unit_battle_hash[unit.id]) {
                      equip_count = Math.min(equip_count, count);
                      level_count_equipped_hash[unit.level] += equip_count;
                    }
                  }
                }
                puts(level_count_equipped_hash);
                return table({
                  "class": "table center_pad"
                }, function() {
                  tr(function() {
                    var level, _j, _results;
                    th({
                      rowSpan: 4
                    }, "Your figures by level");
                    th("Level");
                    _results = [];
                    for (level = _j = 1; _j <= 5; level = ++_j) {
                      _results.push(td(level));
                    }
                    return _results;
                  });
                  tr(function() {
                    var level, _j, _results;
                    th("Count");
                    _results = [];
                    for (level = _j = 1; _j <= 5; level = ++_j) {
                      _results.push(td(level_count_owned_hash[level]));
                    }
                    return _results;
                  });
                  tr(function() {
                    var level, _j, _results;
                    th("Owned");
                    _results = [];
                    for (level = _j = 1; _j <= 5; level = ++_j) {
                      _results.push(td(function() {
                        if (level_count_owned_hash[level] >= min_figure_match_count) {
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
                      }));
                    }
                    return _results;
                  });
                  return tr(function() {
                    var level, _j, _results;
                    th(function() {
                      span("Bring to battle ");
                      return Button({
                        label: "All",
                        on_click: function() {
                          var id, _ref1;
                          _ref1 = ton.owned_hash;
                          for (id in _ref1) {
                            unit = _ref1[id];
                            ton.unit_battle_hash[id] = unit.count;
                          }
                          ton.save();
                          return _this.force_update();
                        }
                      });
                    });
                    _results = [];
                    for (level = _j = 1; _j <= 5; level = ++_j) {
                      _results.push(td(function() {
                        if (level_count_equipped_hash[level] >= min_figure_match_count) {
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
                      }));
                    }
                    return _results;
                  });
                });
              });
            });
            return tr(function() {
              td({
                style: {
                  width: 320
                }
              }, function() {
                return table(function() {
                  return tbody(function() {
                    var spec, _class, _fn, _fn1, _i, _j, _len, _len1;
                    tr(function() {
                      td({
                        "class": "shop_filter_title"
                      }, "Level");
                      return td({
                        "class": "shop_filter_value",
                        style: {
                          width: 300
                        }
                      }, function() {
                        return Tab_bar({
                          hash: {
                            'none': 'None',
                            ' 1': '1',
                            ' 2': '2',
                            ' 3': '3',
                            ' 4': '4',
                            ' 5': '5'
                          },
                          center: true,
                          value: _this.state.filter_level,
                          on_change: function(filter_level) {
                            return _this.set_state({
                              filter_level: filter_level
                            });
                          }
                        });
                      });
                    });
                    tr(function() {
                      return td({
                        colSpan: 2
                      }, "Class");
                    });
                    _fn = function(_class) {
                      return tr({
                        on_click: function(include) {
                          var filter_class_list;
                          filter_class_list = _this.state.filter_class_list;
                          if (filter_class_list.has(_class.name)) {
                            filter_class_list.remove(_class.name);
                          } else {
                            filter_class_list.push(_class.name);
                          }
                          return _this.set_state({
                            filter_class_list: filter_class_list
                          });
                        }
                      }, function() {
                        return td({
                          "class": "shop_filter_title",
                          colSpan: 2
                        }, function() {
                          return Checkbox({
                            label: _class.display_name,
                            value: _this.state.filter_class_list.has(_class.name),
                            on_change: function(include) {
                              var filter_class_list;
                              filter_class_list = _this.state.filter_class_list;
                              if (include) {
                                filter_class_list.push(_class.name);
                              } else {
                                filter_class_list.remove(_class.name);
                              }
                              return _this.set_state({
                                filter_class_list: filter_class_list
                              });
                            }
                          });
                        });
                      });
                    };
                    for (_i = 0, _len = class_list.length; _i < _len; _i++) {
                      _class = class_list[_i];
                      _fn(_class);
                    }
                    tr(function() {
                      return td({
                        colSpan: 2
                      }, "Spec");
                    });
                    _fn1 = function(spec) {
                      return tr({
                        on_click: function(include) {
                          var filter_spec_list;
                          filter_spec_list = _this.state.filter_spec_list;
                          if (filter_spec_list.has(spec.name)) {
                            filter_spec_list.remove(spec.name);
                          } else {
                            filter_spec_list.push(spec.name);
                          }
                          return _this.set_state({
                            filter_spec_list: filter_spec_list
                          });
                        }
                      }, function() {
                        return td({
                          "class": "shop_filter_title",
                          colSpan: 2
                        }, function() {
                          return Checkbox({
                            label: spec.display_name,
                            value: _this.state.filter_spec_list.has(spec.name),
                            on_change: function(include) {
                              var filter_spec_list;
                              filter_spec_list = _this.state.filter_spec_list;
                              if (include) {
                                filter_spec_list.push(spec.name);
                              } else {
                                filter_spec_list.remove(spec.name);
                              }
                              return _this.set_state({
                                filter_spec_list: filter_spec_list
                              });
                            }
                          });
                        });
                      });
                    };
                    for (_j = 0, _len1 = spec_list.length; _j < _len1; _j++) {
                      spec = spec_list[_j];
                      _fn1(spec);
                    }
                    return tr(function() {
                      return td({
                        colSpan: 2
                      }, function() {
                        var id, price, total_cost, total_count, v, _ref, _ref1;
                        total_count = 0;
                        total_cost = 0;
                        _ref = _this.state.to_buy_unit_hash;
                        for (id in _ref) {
                          v = _ref[id];
                          if (price = (_ref1 = ton.unit_price_hash[id]) != null ? _ref1.price : void 0) {
                            total_cost += v * price;
                            total_count += v;
                          }
                        }
                        div("Total cost: " + ((total_cost * 1e-9).toFixed(9)));
                        if (_this.state.buy_in_progress) {
                          Start_button({
                            disabled: true,
                            label: "Buy in progress"
                          });
                        } else if (total_count === 0) {
                          Start_button({
                            disabled: true,
                            label: "Buy"
                          });
                        } else {
                          Start_button({
                            label: "Buy " + total_count,
                            on_click: function() {
                              return _this.buy();
                            }
                          });
                        }
                        switch (_this.state.buy_status) {
                          case "successful":
                            return span("successful");
                          case "failed":
                            return span("failed");
                        }
                      });
                    });
                  });
                });
              });
              return td({
                style: {
                  width: 650
                }
              }, function() {
                return div({
                  "class": "scroll_container",
                  style: {
                    height: 753
                  }
                }, function() {
                  var colSpan;
                  colSpan = 9;
                  return table({
                    "class": "table shop_table"
                  }, function() {
                    return tbody(function() {
                      var check_class, check_same, check_spec, default_class, left, limit, need_check, pass, unit, _i, _len, _ref;
                      tr(function() {
                        th({
                          style: {
                            width: 22
                          }
                        });
                        th({
                          style: {
                            width: 120
                          }
                        }, "Name");
                        th("Lvl");
                        th("Class");
                        th("Spec");
                        th("Bring to battle");
                        th("Owned");
                        th("Price (nano)");
                        return th("To buy");
                      });
                      limit = _this.props.limit || 14;
                      left = limit;
                      _ref = _this.props.shop_unit_list;
                      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                        unit = _ref[_i];
                        if ((filter_level != null) && unit.level !== filter_level) {
                          continue;
                        }
                        if (_this.props.available_unit_list != null) {
                          check_same = _this.check_same(unit);
                          check_class = _this.check_class(unit);
                          check_spec = _this.check_spec(unit);
                          if (filter_only_combo && (!check_class && !check_spec)) {
                            continue;
                          }
                        } else {
                          check_same = check_class = check_spec = false;
                        }
                        need_check = _this.state.filter_spec_list.length || _this.state.filter_class_list.length;
                        pass = false;
                        if (_this.state.filter_spec_list.length && _this.state.filter_spec_list.has(unit.spec)) {
                          pass = true;
                        }
                        if (_this.state.filter_class_list.length && _this.state.filter_class_list.has(unit["class"])) {
                          pass = true;
                        }
                        if (need_check && !pass) {
                          continue;
                        }
                        if (left === 0) {
                          tr(function() {
                            return td({
                              colSpan: colSpan
                            }, "use filters");
                          });
                          break;
                        }
                        left--;
                        default_class = "";
                        tr(function() {
                          td({
                            "class": default_class
                          }, function() {
                            return Unit_icon_render({
                              unit: unit,
                              s: true
                            });
                          });
                          td({
                            "class": check_same ? "check_pass" : default_class
                          }, function() {
                            return unit.display_name;
                          });
                          td({
                            "class": default_class
                          }, function() {
                            return unit.level;
                          });
                          td({
                            "class": check_class ? "check_pass" : default_class
                          }, function() {
                            return unit["class"];
                          });
                          td({
                            "class": check_spec ? "check_pass" : default_class
                          }, function() {
                            return unit.spec;
                          });
                          td({
                            "class": default_class
                          }, function() {
                            return (function(unit) {
                              return Number_input({
                                value: ton.unit_battle_hash[unit.id] || 0,
                                on_change: function(value) {
                                  ton.unit_battle_hash[unit.id] = value;
                                  ton.save();
                                  return _this.force_update();
                                }
                              });
                            })(unit);
                          });
                          td({
                            "class": default_class
                          }, function() {
                            if (ton.owned_hash[unit.id] != null) {
                              return ton.owned_hash[unit.id].count;
                            } else {
                              return "?";
                            }
                          });
                          td({
                            "class": default_class
                          }, function() {
                            var _ref1;
                            return ((_ref1 = ton.unit_price_hash[unit.id]) != null ? _ref1.price : void 0) || "?";
                          });
                          return td({
                            "class": default_class
                          }, function() {
                            return (function(unit) {
                              return Number_input({
                                value: _this.state.to_buy_unit_hash[unit.id] || 0,
                                on_change: function(value) {
                                  var to_buy_unit_hash;
                                  if (value < 0) {
                                    value = 0;
                                  }
                                  to_buy_unit_hash = clone(_this.state.to_buy_unit_hash);
                                  to_buy_unit_hash[unit.id] = value;
                                  return _this.set_state({
                                    to_buy_unit_hash: to_buy_unit_hash
                                  });
                                }
                              });
                            })(unit);
                          });
                        });
                      }
                      if (left === limit) {
                        return tr(function() {
                          return td({
                            colSpan: colSpan
                          }, "No units");
                        });
                      }
                    });
                  });
                });
              });
            });
          });
        };
      })(this));
    }
  }));

  define_com("Unit_shop", conf);

}).call(this);
