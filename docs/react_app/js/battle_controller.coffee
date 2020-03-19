(function() {
  window.Board_battle_controller = (function() {
    function Board_battle_controller() {}

    Board_battle_controller.prototype.state = null;

    Board_battle_controller.prototype.request_emulator_step_fn = null;

    Board_battle_controller.prototype.init = function() {};

    Board_battle_controller.prototype.$canvas_bg = null;

    Board_battle_controller.prototype.$canvas_fg = null;

    Board_battle_controller.prototype.canvas_controller = function(canvas_hash) {
      var $canvas_bg, $canvas_fg;
      if (!(this.$canvas_bg = $canvas_bg = canvas_hash.bg)) {
        return;
      }
      if (!(this.$canvas_fg = $canvas_fg = canvas_hash.fg)) {
        return;
      }
      this.redraw_bg();
      return this.redraw_fg();
    };

    Board_battle_controller.prototype.props_update = function(props) {};

    Board_battle_controller.prototype.refresh = function() {
      return this.has_redraw_changes_fg = true;
    };

    Board_battle_controller.prototype.has_redraw_changes_bg = true;

    Board_battle_controller.prototype.redraw_bg = function() {
      var canvas, ctx, grid_x, grid_y, x, y, _i, _j, _k, _l;
      if (!this.has_redraw_changes_bg) {
        return;
      }
      this.has_redraw_changes_bg = false;
      canvas = this.$canvas_bg;
      ctx = canvas.getContext("2d");
      canvas.width = canvas.width;
      canvas.height = canvas.height;
      ctx.fillStyle = "#eee";
      for (grid_x = _i = 0; _i < 8; grid_x = ++_i) {
        for (grid_y = _j = 0; _j < 8; grid_y = ++_j) {
          if ((grid_x + grid_y) % 2 === 1) {
            continue;
          }
          x = grid_x * battle_board_cell_size_px;
          y = grid_y * battle_board_cell_size_px;
          ctx.fillRect(x, y, battle_board_cell_size_px, battle_board_cell_size_px);
        }
      }
      ctx.fillStyle = "#555";
      for (grid_x = _k = 0; _k < 8; grid_x = ++_k) {
        for (grid_y = _l = 0; _l < 8; grid_y = ++_l) {
          if ((grid_x + grid_y) % 2 === 0) {
            continue;
          }
          x = grid_x * battle_board_cell_size_px;
          y = grid_y * battle_board_cell_size_px;
          ctx.fillRect(x, y, battle_board_cell_size_px, battle_board_cell_size_px);
        }
      }
      ctx.strokeStyle = "#555";
      ctx.beginPath();
      x = 8 * battle_board_cell_size_px - 2;
      y = 8 * battle_board_cell_size_px - 1;
      ctx.moveTo(0 + 0.5, 0 + 0.5);
      ctx.lineTo(x + 0.5, 0 + 0.5);
      ctx.lineTo(x + 0.5, y + 0.5);
      ctx.lineTo(0 + 0.5, y + 0.5);
      ctx.lineTo(0 + 0.5, 0 + 0.5);
      ctx.closePath();
      ctx.stroke();
    };

    Board_battle_controller.prototype.has_redraw_changes_fg = true;

    Board_battle_controller.prototype.redraw_fg = function() {
      var canvas, ctx, hp_bar_ox, hp_bar_oy, hp_bar_sx, hp_bar_sy, hp_bar_xpad, hp_ratio, img, side, sx, sx_2, sy, sy_2, unit, x, y, _i, _len, _ref;
      if (this.request_emulator_step_fn != null) {
        if (this.request_emulator_step_fn(this.state)) {
          this.has_redraw_changes_fg = true;
        }
      }
      if (!this.has_redraw_changes_fg) {
        return;
      }
      this.has_redraw_changes_fg = false;
      if (!this.state) {
        return;
      }
      canvas = this.$canvas_fg;
      ctx = canvas.getContext("2d");
      canvas.width = canvas.width;
      canvas.height = canvas.height;
      sx = 30;
      sy = 30;
      sx_2 = sx / 2;
      sy_2 = sy / 2;
      hp_bar_xpad = 10;
      hp_bar_sx = battle_board_cell_size_px - 2 * hp_bar_xpad;
      hp_bar_sy = 5;
      hp_bar_ox = -battle_board_cell_size_px_2 + hp_bar_xpad;
      hp_bar_oy = -battle_board_cell_size_px_2 / 2;
      _ref = this.state.unit_list;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        unit = _ref[_i];
        side = unit.side;
        x = unit.x * battle_board_cell_size_unit2px;
        y = unit.y * battle_board_cell_size_unit2px;
        img = unit_type2image_hash[unit.type];
        if (!img.loaded) {
          ctx.fillStyle = "#ff0";
          ctx.fillRect(x - sx_2, y - sy_2, sx, sy);
        } else {
          ctx.drawImage(img, x - sx_2, y - sy_2);
        }
        switch (side) {
          case 0:
            ctx.fillStyle = "#0f0";
            break;
          case 1:
            ctx.fillStyle = "#f00";
        }
        hp_ratio = unit.hp100 / unit.hp_max100;
        ctx.fillRect(x + hp_bar_ox, y + hp_bar_oy, hp_bar_sx * hp_ratio, hp_bar_sy);
      }
    };

    Board_battle_controller.prototype.key_down = function() {};

    Board_battle_controller.prototype.key_up = function() {};

    Board_battle_controller.prototype.key_press = function() {};

    Board_battle_controller.prototype.mouse_move = function() {};

    Board_battle_controller.prototype.mouse_out = function() {};

    Board_battle_controller.prototype.mouse_down = function() {};

    Board_battle_controller.prototype.mouse_up = function() {};

    Board_battle_controller.prototype.mouse_click = function() {};

    Board_battle_controller.prototype.focus_out = function() {};

    Board_battle_controller.prototype.mouse_wheel = function() {};

    return Board_battle_controller;

  })();

}).call(this);
