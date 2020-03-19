(function() {
  window.Board_buy_controller = (function() {
    function Board_buy_controller() {}

    Board_buy_controller.prototype.state = null;

    Board_buy_controller.prototype.request_emulator_step_fn = null;

    Board_buy_controller.prototype.on_change = null;

    Board_buy_controller.prototype.init = function() {};

    Board_buy_controller.prototype.$canvas_bg = null;

    Board_buy_controller.prototype.$canvas_fg = null;

    Board_buy_controller.prototype.$canvas_hover = null;

    Board_buy_controller.prototype.canvas_controller = function(canvas_hash) {
      var $canvas_bg, $canvas_fg, $canvas_hover;
      if ($canvas_bg !== canvas_hash.bg) {
        this.has_redraw_changes_bg = true;
      }
      if ($canvas_fg !== canvas_hash.fg) {
        this.has_redraw_changes_fg = true;
      }
      if ($canvas_hover !== canvas_hash.hover) {
        this.has_redraw_changes_hover = true;
      }
      if (!(this.$canvas_bg = $canvas_bg = canvas_hash.bg)) {
        return;
      }
      if (!(this.$canvas_fg = $canvas_fg = canvas_hash.fg)) {
        return;
      }
      if (!(this.$canvas_hover = $canvas_hover = canvas_hash.hover)) {
        return;
      }
      this.redraw_bg();
      this.redraw_fg();
      return this.redraw_hover();
    };

    Board_buy_controller.prototype.props_update = function(props) {};

    Board_buy_controller.prototype.refresh = function() {
      return this.has_redraw_changes_fg = true;
    };

    Board_buy_controller.prototype.has_redraw_changes_bg = true;

    Board_buy_controller.prototype.redraw_bg = function() {
      var canvas, ctx, grid_x, grid_y, x, y, y0, _i, _j, _k, _l, _m, _n, _ref;
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
      ctx.lineWidth = 1;
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
      grid_y = 8;
      ctx.fillStyle = "#eee";
      for (grid_x = _m = 0; _m < 8; grid_x = ++_m) {
        if ((grid_x + grid_y) % 2 === 1) {
          continue;
        }
        x = grid_x * battle_board_cell_size_px;
        y = grid_y * battle_board_cell_size_px + battle_board_cell_size_px_2;
        ctx.fillRect(x, y, battle_board_cell_size_px, battle_board_cell_size_px);
      }
      ctx.fillStyle = "#555";
      for (grid_x = _n = 0; _n < 8; grid_x = ++_n) {
        if ((grid_x + grid_y) % 2 === 0) {
          continue;
        }
        x = grid_x * battle_board_cell_size_px;
        y = grid_y * battle_board_cell_size_px + battle_board_cell_size_px_2;
        ctx.fillRect(x, y, battle_board_cell_size_px, battle_board_cell_size_px);
      }
      ctx.strokeStyle = "#555";
      ctx.lineWidth = 1;
      ctx.beginPath();
      x = 8 * battle_board_cell_size_px - 2;
      y0 = 8.5 * battle_board_cell_size_px - 1;
      y = 9.5 * battle_board_cell_size_px - 1;
      ctx.moveTo(0 + 0.5, y0 + 0.5);
      ctx.lineTo(x + 0.5, y0 + 0.5);
      ctx.lineTo(x + 0.5, y + 0.5);
      ctx.lineTo(0 + 0.5, y + 0.5);
      ctx.lineTo(0 + 0.5, y0 + 0.5);
      ctx.closePath();
      ctx.stroke();
      if (this.mode_move && this._last_hover_cell) {
        _ref = this._last_hover_cell, x = _ref.x, y = _ref.y;
        if (y > 3) {
          if (y === 8) {
            y += 0.5;
          }
          x *= battle_board_cell_size_px;
          y *= battle_board_cell_size_px;
          ctx.fillStyle = "#ff0";
          ctx.fillRect(x, y, battle_board_cell_size_px, battle_board_cell_size_px);
        }
      }
    };

    Board_buy_controller.prototype.has_redraw_changes_fg = true;

    Board_buy_controller.prototype.redraw_fg = function() {
      var canvas, ctx, hp_bar_ox, hp_bar_oy, hp_bar_sx, hp_bar_sy, hp_bar_xpad, hp_ratio, id, img, side, sx, sx_2, sy, sy_2, unit, x, y, _ref;
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
      sx = board_icon_sx;
      sy = board_icon_sy;
      sx_2 = sx / 2;
      sy_2 = sy / 2;
      hp_bar_xpad = 10;
      hp_bar_sx = battle_board_cell_size_px - 2 * hp_bar_xpad;
      hp_bar_sy = 5;
      hp_bar_ox = -battle_board_cell_size_px_2 + hp_bar_xpad;
      hp_bar_oy = -battle_board_cell_size_px_2 / 2;
      _ref = this.state.final_state.board_unit_hash;
      for (id in _ref) {
        unit = _ref[id];
        side = unit.side;
        x = unit.x * battle_board_cell_size_px + battle_board_cell_size_px_2;
        y = unit.y * battle_board_cell_size_px + battle_board_cell_size_px_2;
        if (unit.y === 8) {
          y += battle_board_cell_size_px_2;
        }
        img = unit_type2image_hash[unit.type];
        if (unit.is_hover) {
          ctx.strokeStyle = "#ee0";
          ctx.lineWidth = 5;
          ctx.strokeRect(x - battle_board_cell_size_px_2, y - battle_board_cell_size_px_2, battle_board_cell_size_px, battle_board_cell_size_px);
        }
        if (this.mode_move && unit === this.drag_unit) {
          ctx.strokeStyle = "#0e0";
          ctx.lineWidth = 5;
          ctx.strokeRect(x - battle_board_cell_size_px_2, y - battle_board_cell_size_px_2, battle_board_cell_size_px, battle_board_cell_size_px);
        }
        if (!img.loaded) {
          ctx.fillStyle = "#ff0";
          ctx.fillRect(x - sx_2, y - sy_2, sx, sy);
          this.has_redraw_changes_fg = true;
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

    Board_buy_controller.prototype.has_redraw_changes_hover = true;

    Board_buy_controller.prototype.redraw_hover = function() {
      var canvas, ctx, img, sx, sx_2, sy, sy_2, x, y;
      if (!this.has_redraw_changes_hover) {
        return;
      }
      this.has_redraw_changes_hover = false;
      canvas = this.$canvas_hover;
      ctx = canvas.getContext("2d");
      canvas.width = canvas.width;
      canvas.height = canvas.height;
      if (!this.mode_move) {
        return;
      }
      sx = board_icon_sx;
      sy = board_icon_sy;
      sx_2 = sx / 2;
      sy_2 = sy / 2;
      img = unit_type2image_hash[this.drag_unit.type];
      if (!img.loaded) {
        this.has_redraw_changes_hover = true;
        return;
      }
      x = this._last_x;
      y = this._last_y;
      ctx.drawImage(img, x - sx_2, y - sy_2);
    };

    Board_buy_controller.prototype.mode_move = false;

    Board_buy_controller.prototype.drag_unit = null;

    Board_buy_controller.prototype._last_hover_cell = null;

    Board_buy_controller.prototype._last_x = 0;

    Board_buy_controller.prototype._last_y = 0;

    Board_buy_controller.prototype.get_hover_cell = function(event) {
      var col, grid_x, grid_y, mx, my, value, x0, x1, y0, y1, _i, _j, _len, _len1, _ref, _ref1;
      _ref = rel_mouse_coords(event), mx = _ref.x, my = _ref.y;
      this._last_x = mx;
      this._last_y = my;
      _ref1 = this.state.final_state.board_place_mx;
      for (grid_x = _i = 0, _len = _ref1.length; _i < _len; grid_x = ++_i) {
        col = _ref1[grid_x];
        x0 = grid_x * buy_board_cell_size_px;
        x1 = x0 + buy_board_cell_size_px;
        for (grid_y = _j = 0, _len1 = col.length; _j < _len1; grid_y = ++_j) {
          value = col[grid_y];
          y0 = grid_y * buy_board_cell_size_px;
          if (grid_y === 8) {
            y0 += buy_board_cell_size_px_2;
          }
          y1 = y0 + buy_board_cell_size_px;
          if (((x0 < mx && mx < x1)) && ((y0 < my && my < y1))) {
            return {
              x: grid_x,
              y: grid_y,
              unit: value
            };
          }
        }
      }
      return null;
    };

    Board_buy_controller.prototype.hover_cell_cmp = function(a, b) {
      var _ref, _ref1;
      if (!!a !== !!b) {
        return false;
      }
      if (!a) {
        return true;
      }
      if (a.x !== b.x) {
        return false;
      }
      if (a.y !== b.y) {
        return false;
      }
      if (((_ref = a.unit) != null ? _ref.id : void 0) !== ((_ref1 = b.unit) != null ? _ref1.id : void 0)) {
        return false;
      }
      return true;
    };

    Board_buy_controller.prototype.mouse_move = function(event) {
      var hover_cell, hover_change, _ref, _ref1, _ref2;
      hover_cell = this.get_hover_cell(event);
      if (hover_change = !this.hover_cell_cmp(this._last_hover_cell, hover_cell)) {
        if ((_ref = this._last_hover_cell) != null) {
          if ((_ref1 = _ref.unit) != null) {
            _ref1.is_hover = false;
          }
        }
        if (hover_cell != null) {
          if ((_ref2 = hover_cell.unit) != null) {
            _ref2.is_hover = true;
          }
        }
        this._last_hover_cell = hover_cell;
        this.has_redraw_changes_fg = true;
      }
      if (this.mode_move) {
        this.has_redraw_changes_hover = true;
        if (hover_change) {
          this.has_redraw_changes_bg = true;
        }
      }
    };

    Board_buy_controller.prototype.mouse_out = function() {
      var _ref, _ref1;
      if (this._last_hover_cell != null) {
        if ((_ref = this._last_hover_cell) != null) {
          if ((_ref1 = _ref.unit) != null) {
            _ref1.is_hover = false;
          }
        }
        this._last_hover_cell = null;
        this.has_redraw_changes_fg = true;
      }
    };

    Board_buy_controller.prototype.mouse_down = function() {
      var hover_cell;
      hover_cell = this.get_hover_cell(event);
      if (!(hover_cell != null ? hover_cell.unit : void 0)) {
        return;
      }
      this.mode_move = true;
      this.drag_unit = hover_cell.unit;
      return this.has_redraw_changes_fg = true;
    };

    Board_buy_controller.prototype._drag_finish = function() {
      this.mode_move = false;
      this.drag_unit = null;
      this.has_redraw_changes_fg = true;
      this.has_redraw_changes_bg = true;
      return this.has_redraw_changes_hover = true;
    };

    Board_buy_controller.prototype.mouse_up = function(event) {
      var action, dst_unit, err, hover_cell;
      if (!this.mode_move) {
        return;
      }
      hover_cell = this.get_hover_cell(event);
      if (!hover_cell || hover_cell.y <= 3) {
        return this._drag_finish();
      }
      if (hover_cell.x === this.drag_unit.x && hover_cell.y === this.drag_unit.y) {
        return this._drag_finish();
      }
      action = new Player_action;
      if (dst_unit = this.state.final_state.board_place_mx[hover_cell.x][hover_cell.y]) {
        action.type = Player_action.SWAP;
        action.unit_id = this.drag_unit.id;
        action.unit_id2 = dst_unit.id;
        action.x = this.drag_unit.x;
        action.y = this.drag_unit.y;
        action.x2 = dst_unit.x;
        action.y2 = dst_unit.y;
      } else {
        action.type = Player_action.MOVE;
        action.unit_id = this.drag_unit.id;
        action.x = hover_cell.x;
        action.y = hover_cell.y;
      }
      try {
        this.state.action_add(action);
        if (typeof this.on_change === "function") {
          this.on_change();
        }
      } catch (_error) {
        err = _error;
        perr(err);
      }
      this._drag_finish();
      return this.mouse_move(event);
    };

    Board_buy_controller.prototype.key_down = function() {};

    Board_buy_controller.prototype.key_up = function() {};

    Board_buy_controller.prototype.key_press = function() {};

    Board_buy_controller.prototype.mouse_click = function() {};

    Board_buy_controller.prototype.focus_out = function() {};

    Board_buy_controller.prototype.mouse_wheel = function() {};

    return Board_buy_controller;

  })();

}).call(this);
