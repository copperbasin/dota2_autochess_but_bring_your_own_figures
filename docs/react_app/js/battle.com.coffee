(function() {
  var com_name, conf, game_result_translation;

  com_name = "Board_battle";

  game_result_translation = {
    s0: "You win",
    s1: "You lose",
    draw: "Draw"
  };

  conf = React.createClass(CKR.react_key_map(com_name, {
    state: {
      play: true,
      tick_idx: 0
    },
    game_result: null,
    controller: null,
    emulator: null,
    mount: function() {
      this.emulator = new emulator.Emulator;
      this.emulator.end_condition = emulator.eliminate;
      this.emulator.tick_limit = 30 * 100;
      window.debug_emulator = this.emulator;
      this.controller = new Board_battle_controller;
      this.controller.state = this.props.start_state;
      if (!this.props.start_state) {
        perr("BAD battle !@props.start_state");
        return;
      }
      window.debug_state = this.controller.state;
      this.emulator.state = this.controller.state;
      this.controller.state.cache_actualize();
      this.controller.request_emulator_step_fn = (function(_this) {
        return function() {
          var i, tick_count, _base, _i;
          if (!_this.state.play) {
            return false;
          }
          tick_count = 1;
          for (i = _i = 0; 0 <= tick_count ? _i < tick_count : _i > tick_count; i = 0 <= tick_count ? ++_i : --_i) {
            if (_this.game_result = _this.emulator.end_condition(_this.controller.state)) {
              _this.set_state({
                play: false
              });
              if (typeof (_base = _this.props).on_finish === "function") {
                _base.on_finish(_this.game_result, _this.emulator.state);
              }
              break;
            }
            _this.emulator.tick();
            _this.emulator.state.tick_idx++;
          }
          _this.set_state({
            tick_idx: _this.emulator.state.tick_idx
          });
          return true;
        };
      })(this);
    },
    render: function() {
      this.controller.props_update(this.props);
      return div({
        style: {
          textAlign: "left",
          width: battle_board_cell_size_px * 8,
          height: battle_board_cell_size_px * 9
        }
      }, (function(_this) {
        return function() {
          var time, time_sub, _ref;
          time = Math.floor(_this.state.tick_idx / 100);
          time_sub = _this.state.tick_idx % 100;
          span("0:" + (time.rjust(2, '0')) + "." + time_sub + " " + ((_ref = game_result_translation[_this.game_result]) != null ? _ref : ''));
          return Canvas_multi({
            layer_list: ["bg", "fg"],
            canvas_cb: function(canvas_hash) {
              return _this.controller.canvas_controller(canvas_hash);
            },
            gui: _this.controller,
            ref_textarea: function($textarea) {
              _this.controller.$textarea = $textarea;
              return _this.controller.init();
            }
          });
        };
      })(this));
    }
  }));

  define_com("Board_battle", conf);

}).call(this);
