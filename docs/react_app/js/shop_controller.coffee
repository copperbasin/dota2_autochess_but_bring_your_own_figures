(function() {
  window.Shop_controller = (function() {
    function Shop_controller() {}

    Shop_controller.prototype.state = null;

    Shop_controller.prototype.on_board_change_fn = null;

    Shop_controller.prototype.on_change = null;

    Shop_controller.prototype.init = function() {};

    Shop_controller.prototype.$canvas_bg = null;

    Shop_controller.prototype.$canvas_fg = null;

    Shop_controller.prototype.canvas_controller = function(canvas_hash) {
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

    Shop_controller.prototype.props_update = function(props) {};

    Shop_controller.prototype.refresh = function() {
      return this.has_redraw_changes_fg = true;
    };

    Shop_controller.prototype.has_redraw_changes_bg = true;

    Shop_controller.prototype.redraw_bg = function() {
      var canvas, ctx;
      if (!this.has_redraw_changes_bg) {
        return;
      }
      this.has_redraw_changes_bg = false;
      canvas = this.$canvas_bg;
      ctx = canvas.getContext("2d");
      canvas.width = canvas.width;
      canvas.height = canvas.height;
    };

    Shop_controller.prototype.has_redraw_changes_fg = true;

    Shop_controller.prototype.redraw_fg = function() {
      var can_buy, canvas, cell, cost, ctx, grid_x, grid_y, img, x, y, _i, _j, _len, _len1, _ref, _ref1;
      if (!this.has_redraw_changes_fg) {
        return;
      }
      this.has_redraw_changes_fg = false;
      canvas = this.$canvas_fg;
      ctx = canvas.getContext("2d");
      canvas.width = canvas.width;
      canvas.height = canvas.height;
      grid_x = 0;
      grid_y = 0;
      _ref = this.state.final_state.shop_unit_list;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        cell = _ref[_i];
        x = grid_x * shop_cell_size_px;
        y = grid_y * shop_cell_size_px;
        if (cell.is_bought) {
          ctx.fillStyle = "#ff0";
          ctx.fillRect(x, y, shop_cell_size_px, shop_cell_size_px);
        }
        img = unit_type2image_hash[cell.type];
        if (!img.loaded) {
          this.has_redraw_changes_fg = true;
        }
        cost = cell.lvl;
        can_buy = (cost <= this.state.final_state.gold) && (cell.lvl <= this.state.final_state.lvl);
        if (!can_buy) {
          ctx.globalAlpha = 0.4;
        }
        ctx.drawImage(img, x + shop_cell_icon_pad_px, y + shop_cell_icon_pad_px, shop_cell_icon_size_px, shop_cell_icon_size_px);
        if (!can_buy) {
          ctx.globalAlpha = 1;
        }
        grid_x++;
        if (grid_x >= 5) {
          grid_x = 0;
          grid_y++;
        }
      }
      grid_x = 0;
      grid_y = 0;
      _ref1 = this.state.final_state.shop_unit_list;
      for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
        cell = _ref1[_j];
        x = grid_x * shop_cell_size_px;
        y = grid_y * shop_cell_size_px;
        if (cell.is_hover) {
          ctx.strokeStyle = "#000";
          ctx.strokeRect(x + 1.5, y + 1.5, shop_cell_size_px - 1, shop_cell_size_px - 1);
        }
        grid_x++;
        if (grid_x >= 5) {
          grid_x = 0;
          grid_y++;
        }
      }
    };

    Shop_controller.prototype._last_hover_cell = null;

    Shop_controller.prototype.get_hover_cell = function(event) {
      var cell, grid_x, grid_y, mx, my, x0, x1, y0, y1, _i, _len, _ref, _ref1;
      _ref = rel_mouse_coords(event), mx = _ref.x, my = _ref.y;
      grid_x = 0;
      grid_y = 0;
      _ref1 = this.state.final_state.shop_unit_list;
      for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
        cell = _ref1[_i];
        x0 = 1 + grid_x * shop_cell_size_px;
        y0 = 1 + grid_y * shop_cell_size_px;
        x1 = -1 + (grid_x + 1) * shop_cell_size_px;
        y1 = -1 + (grid_y + 1) * shop_cell_size_px;
        if (((x0 < mx && mx < x1)) && ((y0 < my && my < y1))) {
          return cell;
        }
        grid_x++;
        if (grid_x >= 5) {
          grid_x = 0;
          grid_y++;
        }
      }
      return null;
    };

    Shop_controller.prototype.hover_drop = function() {
      var _ref;
      if ((_ref = this._last_hover_cell) != null) {
        _ref.is_hover = false;
      }
      this._last_hover_cell = null;
      this.has_redraw_changes_fg = true;
    };

    Shop_controller.prototype.mouse_move = function(event) {
      var cell, _ref;
      cell = this.get_hover_cell(event);
      if (cell !== this._last_hover_cell) {
        if ((_ref = this._last_hover_cell) != null) {
          _ref.is_hover = false;
        }
        if (cell != null) {
          cell.is_hover = true;
        }
        this._last_hover_cell = cell;
        this.has_redraw_changes_fg = true;
      }
    };

    Shop_controller.prototype.mouse_down = function(event) {
      var action, buy_action, cell, err, idx, new_story, replace_action, res, x, y, _i, _j, _k, _len, _len1, _len2, _ref, _ref1, _ref2;
      if (!(cell = this.get_hover_cell(event))) {
        return;
      }
      if (!cell.is_bought) {
        if (cell.lvl > this.state.final_state.lvl) {
          return;
        }
        if (cell.lvl > this.state.final_state.gold) {
          return;
        }
        action = new Player_action;
        action.type = Player_action.BUY;
        action.shop_id = cell.id;
        action.shop_cost = cell.lvl;
        action.unit_id = this.state.final_state.free_unit_id;
        res = this.state.final_state.get_empty_space();
        if (!res) {
          perr("out of free space");
          return;
        }
        x = res[0], y = res[1];
        action.x = x;
        action.y = y;
        try {
          this.state.action_add(action);
          if (typeof this.on_change === "function") {
            this.on_change();
          }
        } catch (_error) {
          err = _error;
          perr(err);
          return;
        }
        cell.is_bought = true;
        this.has_redraw_changes_fg = true;
        if (typeof this.on_board_change_fn === "function") {
          this.on_board_change_fn();
        }
      } else {
        new_story = new Player_intermediate_state;
        new_story.start_state = this.state.start_state;
        buy_action = null;
        _ref = this.state.action_list;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          action = _ref[_i];
          if (action.type === Player_action.BUY && action.shop_id === cell.id) {
            buy_action = action;
            break;
          }
        }
        if (!buy_action) {
          perr("!buy_action");
          return;
        }
        _ref1 = this.state.action_list;
        for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
          action = _ref1[_j];
          switch (action.type) {
            case Player_action.BUY:
            case Player_action.SELL:
            case Player_action.MOVE:
              if (action.unit_id !== buy_action.unit_id) {
                new_story.action_list.push(action);
              }
              break;
            case Player_action.SWAP:
              if (action.unit_id === buy_action.unit_id) {
                replace_action = new Player_action;
                replace_action.type = Player_action.MOVE;
                replace_action.unit_id = action.unit_id2;
                replace_action.x = action.x;
                replace_action.y = action.y;
                new_story.action_list.push(replace_action);
              } else if (action.unit_id2 === buy_action.unit_id) {
                replace_action = new Player_action;
                replace_action.type = Player_action.MOVE;
                replace_action.unit_id = action.unit_id;
                replace_action.x = action.x2;
                replace_action.y = action.y2;
                new_story.action_list.push(replace_action);
              } else {
                new_story.action_list.push(action);
              }
          }
        }
        _ref2 = new_story.action_list;
        for (idx = _k = 0, _len2 = _ref2.length; _k < _len2; idx = ++_k) {
          action = _ref2[idx];
          if (action.unit_id > buy_action.unit_id) {
            action = action.clone();
            action.unit_id--;
            new_story.action_list[idx] = action;
          }
          if (action.unit_id2 > buy_action.unit_id) {
            action = action.clone();
            action.unit_id2--;
            new_story.action_list[idx] = action;
          }
        }
        try {
          new_story.final_state_calc();
          if (typeof this.on_change === "function") {
            this.on_change();
          }
        } catch (_error) {
          err = _error;
          perr(err);
          return;
        }
        this.state.action_list = new_story.action_list;
        this.state.final_state = new_story.final_state;
        cell.is_bought = false;
        this.has_redraw_changes_fg = true;
        if (typeof this.on_board_change_fn === "function") {
          this.on_board_change_fn();
        }
      }
    };

    Shop_controller.prototype.mouse_out = function() {
      return this.hover_drop();
    };

    Shop_controller.prototype.focus_out = function() {
      return this.hover_drop();
    };

    Shop_controller.prototype.key_down = function() {};

    Shop_controller.prototype.key_up = function() {};

    Shop_controller.prototype.key_press = function() {};

    Shop_controller.prototype.mouse_out = function() {};

    Shop_controller.prototype.mouse_up = function() {};

    Shop_controller.prototype.mouse_click = function() {};

    Shop_controller.prototype.mouse_wheel = function() {};

    return Shop_controller;

  })();

}).call(this);
