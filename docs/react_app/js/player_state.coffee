(function() {
  window.exp2lvl = function(exp) {
    if (0 >= (exp -= 1)) {
      return 1;
    }
    if (0 >= (exp -= 2)) {
      return 2;
    }
    if (0 >= (exp -= 4)) {
      return 3;
    }
    if (0 >= (exp -= 8)) {
      return 4;
    }
    if (0 >= (exp -= 16)) {
      return 5;
    }
    if (0 >= (exp -= 32)) {
      return 6;
    }
    if (0 >= (exp -= 64)) {
      return 7;
    }
    if (0 >= (exp -= 128)) {
      return 8;
    }
    if (0 >= (exp -= 256)) {
      return 9;
    }
    return 10;
  };

  window.Shop_unit = (function() {
    function Shop_unit() {}

    Shop_unit.prototype.id = 0;

    Shop_unit.prototype.type = "";

    Shop_unit.prototype.lvl = 0;

    Shop_unit.prototype.is_bought = false;

    Shop_unit.prototype.is_hover = false;

    Shop_unit.prototype.clone = function() {
      var ret;
      ret = new Shop_unit;
      ret.id = this.id;
      ret.type = this.type;
      ret.lvl = this.lvl;
      ret.is_bought = this.is_bought;
      ret.is_hover = this.is_hover;
      return ret;
    };

    return Shop_unit;

  })();

  window.Game_unit = (function() {
    function Game_unit() {}

    Game_unit.prototype.id = 0;

    Game_unit.prototype.type = "";

    Game_unit.prototype.x = 0;

    Game_unit.prototype.y = 0;

    Game_unit.prototype.lvl = 0;

    Game_unit.prototype.star_lvl = 1;

    Game_unit.prototype.is_hover = false;

    Game_unit.prototype.clone = function() {
      var ret;
      ret = new Game_unit;
      ret.id = this.id;
      ret.type = this.type;
      ret.x = this.x;
      ret.y = this.y;
      ret.lvl = this.lvl;
      ret.star_lvl = this.star_lvl;
      return ret;
    };

    Game_unit.prototype.serialize_obj = function() {
      var ret;
      ret = {};
      ret.id = this.id;
      ret.type = this.type;
      ret.x = this.x;
      ret.y = this.y;
      ret.lvl = this.lvl;
      ret.star_lvl = this.star_lvl;
      return ret;
    };

    Game_unit.prototype.deserialize_obj = function(obj) {
      this.id = obj.id;
      this.type = obj.type;
      this.x = obj.x;
      this.y = obj.y;
      this.lvl = obj.lvl;
      this.star_lvl = obj.star_lvl;
    };

    Game_unit.prototype.cmp = function(t) {
      if (this.id !== t.id) {
        return false;
      }
      if (this.type !== t.type) {
        return false;
      }
      if (this.x !== t.x) {
        return false;
      }
      if (this.y !== t.y) {
        return false;
      }
      if (this.lvl !== t.lvl) {
        return false;
      }
      if (this.star_lvl !== t.star_lvl) {
        return false;
      }
      return true;
    };

    return Game_unit;

  })();

  this.window.Player_cross_round_state = (function() {
    Player_cross_round_state.prototype.seed = 0;

    Player_cross_round_state.prototype.hp = 100;

    Player_cross_round_state.prototype.gold = 1;

    Player_cross_round_state.prototype.exp = 1;

    Player_cross_round_state.prototype.lvl = 1;

    Player_cross_round_state.prototype.free_unit_id = 0;

    Player_cross_round_state.prototype.board_unit_hash = {};

    Player_cross_round_state.prototype.board_place_mx = [];

    Player_cross_round_state.prototype.shop_unit_list = [];

    Player_cross_round_state.prototype.is_valid = true;

    function Player_cross_round_state() {
      var col, i, j, _i, _j;
      this.board_unit_hash = {};
      this.board_place_mx = [];
      for (i = _i = 0; _i < 8; i = ++_i) {
        this.board_place_mx.push(col = []);
        for (j = _j = 0; _j < 9; j = ++_j) {
          col.push(null);
        }
      }
      this.shop_unit_list = [];
    }

    Player_cross_round_state.prototype.clone = function() {
      var col, id, ret, ret_col, unit, x, y, _i, _j, _k, _len, _len1, _len2, _ref, _ref1, _ref2;
      ret = new Player_cross_round_state;
      ret.hp = this.hp;
      ret.gold = this.gold;
      ret.exp = this.exp;
      ret.lvl = this.lvl;
      ret.free_unit_id = this.free_unit_id;
      _ref = this.board_unit_hash;
      for (id in _ref) {
        unit = _ref[id];
        ret.board_unit_hash[id] = unit.clone();
      }
      _ref1 = this.board_place_mx;
      for (x = _i = 0, _len = _ref1.length; _i < _len; x = ++_i) {
        col = _ref1[x];
        ret_col = ret.board_place_mx[x];
        for (y = _j = 0, _len1 = col.length; _j < _len1; y = ++_j) {
          unit = col[y];
          if (!unit) {
            continue;
          }
          ret_col[y] = ret.board_unit_hash[unit.id];
        }
      }
      _ref2 = this.shop_unit_list;
      for (_k = 0, _len2 = _ref2.length; _k < _len2; _k++) {
        unit = _ref2[_k];
        ret.shop_unit_list.push(unit.clone());
      }
      return ret;
    };

    Player_cross_round_state.prototype.serialize_json = function() {
      var id, ret, unit, _ref;
      ret = {};
      ret.hp = this.hp;
      ret.gold = this.gold;
      ret.exp = this.exp;
      ret.lvl = this.lvl;
      ret.free_unit_id = this.free_unit_id;
      ret.board_unit_hash = {};
      _ref = this.board_unit_hash;
      for (id in _ref) {
        unit = _ref[id];
        ret.board_unit_hash[id] = unit.serialize_obj();
      }
      return JSON.stringify(ret);
    };

    Player_cross_round_state.prototype.deserialize_json = function(json) {
      var id, new_unit, obj, unit, _ref;
      obj = JSON.parse(json);
      this.hp = obj.hp;
      this.gold = obj.gold;
      this.exp = obj.exp;
      this.lvl = obj.lvl;
      this.free_unit_id = obj.free_unit_id;
      this.board_unit_hash = {};
      _ref = obj.board_unit_hash;
      for (id in _ref) {
        unit = _ref[id];
        new_unit = new Game_unit;
        new_unit.deserialize_obj(unit);
        this.board_unit_hash[id] = new_unit;
      }
    };

    Player_cross_round_state.prototype.cmp = function(t) {
      var id, t_unit, unit, _ref;
      if (this.hp !== t.hp) {
        return false;
      }
      if (this.gold !== t.gold) {
        return false;
      }
      if (this.exp !== t.exp) {
        return false;
      }
      if (this.lvl !== t.lvl) {
        return false;
      }
      if (this.free_unit_id !== t.free_unit_id) {
        return false;
      }
      if (Object.keys(this.board_unit_hash).join() !== Object.keys(t.board_unit_hash).join()) {
        return false;
      }
      _ref = this.board_unit_hash;
      for (id in _ref) {
        unit = _ref[id];
        t_unit = t.board_unit_hash[id];
        if (!unit.cmp(t_unit)) {
          return false;
        }
      }
      return true;
    };

    Player_cross_round_state.prototype.valid_calc = function() {
      return this.is_valid = this._valid_calc();
    };

    Player_cross_round_state.prototype._valid_calc = function() {
      var id, on_board_count, unit, _ref;
      if (this.gold < 0) {
        return false;
      }
      on_board_count = 0;
      _ref = this.board_unit_hash;
      for (id in _ref) {
        unit = _ref[id];
        if (unit.y !== 8) {
          on_board_count++;
        }
      }
      if (on_board_count > this.lvl) {
        return false;
      }
      return true;
    };

    Player_cross_round_state.prototype.id_compact = function() {};

    Player_cross_round_state.prototype.get_empty_space = function() {
      var x, y, _i;
      y = 8;
      for (x = _i = 0; _i < 8; x = ++_i) {
        if (!this.board_place_mx[x][y]) {
          return [x, y];
        }
      }
      return null;
    };

    Player_cross_round_state.prototype.action_apply = function(action) {
      var dst_unit, dst_unit_x, dst_unit_y, shop_unit, src_unit, src_unit_x, src_unit_y, unit, x, y;
      switch (action.type) {
        case Player_action.BUY:
          x = action.x, y = action.y;
          shop_unit = this.shop_unit_list[action.shop_id];
          if (!shop_unit) {
            throw new Error("invalid buy. shop_unit not exists");
          }
          if (shop_unit.is_bought) {
            throw new Error("invalid buy. shop_unit is_bought");
          }
          if (shop_unit.lvl > this.lvl) {
            throw new Error("invalid buy. You are buying unit with more lvl than player");
          }
          if (this.board_place_mx[x][y]) {
            throw new Error("invalid move. dst x,y is occupied");
          }
          shop_unit.is_bought = true;
          unit = new Game_unit;
          unit.id = this.free_unit_id++;
          unit.x = x;
          unit.y = y;
          unit.type = shop_unit.type;
          unit.lvl = shop_unit.lvl;
          this.board_unit_hash[unit.id] = unit;
          this.board_place_mx[x][y] = unit;
          this.gold -= unit.lvl;
          break;
        case Player_action.SELL:
          if (!(unit = this.board_unit_hash[action.unit_id])) {
            throw new Error("invalid sell. id not exists");
          }
          delete this.board_unit_hash[unit.id];
          this.board_place_mx[unit.x][unit.y] = null;
          this.gold += unit.lvl + (unit.star_lvl - 1);
          break;
        case Player_action.MOVE:
          x = action.x, y = action.y;
          if (!(unit = this.board_unit_hash[action.unit_id])) {
            throw new Error("invalid move. id not exists");
          }
          if (!(((0 <= x && x <= 7)) && ((4 <= y && y <= 8)))) {
            throw new Error("invalid move. dst x,y out of bounds");
          }
          if (this.board_place_mx[x][y]) {
            throw new Error("invalid move. dst x,y is occupied");
          }
          this.board_place_mx[unit.x][unit.y] = null;
          unit.x = x;
          unit.y = y;
          this.board_place_mx[unit.x][unit.y] = unit;
          break;
        case Player_action.SWAP:
          if (!(src_unit = this.board_unit_hash[action.unit_id])) {
            throw new Error("invalid swap. id not exists");
          }
          if (!(dst_unit = this.board_unit_hash[action.unit_id2])) {
            throw new Error("invalid swap. id2 not exists");
          }
          dst_unit_x = src_unit.x;
          dst_unit_y = src_unit.y;
          src_unit_x = dst_unit.x;
          src_unit_y = dst_unit.y;
          src_unit.x = src_unit_x;
          src_unit.y = src_unit_y;
          this.board_place_mx[src_unit.x][src_unit.y] = src_unit;
          dst_unit.x = dst_unit_x;
          dst_unit.y = dst_unit_y;
          this.board_place_mx[dst_unit.x][dst_unit.y] = dst_unit;
          break;
        case Player_action.BUY_EXP:
          this.gold -= 4;
          this.exp += 4;
          this.lvl = exp2lvl(this.exp);
          break;
        default:
          throw new Error("unknown action");
      }
      this.valid_calc();
      if (!this.is_valid) {
        throw new Error("intermediate state is not valid");
      }
    };

    return Player_cross_round_state;

  })();

  window.Player_action = (function() {
    var enum_counter;

    function Player_action() {}

    enum_counter = 0;

    Player_action.BUY = enum_counter++;

    Player_action.SELL = enum_counter++;

    Player_action.MOVE = enum_counter++;

    Player_action.SWAP = enum_counter++;

    Player_action.BUY_EXP = enum_counter++;

    Player_action.prototype.type = -1;

    Player_action.prototype.shop_id = -1;

    Player_action.prototype.shop_cost = -1;

    Player_action.prototype.unit_id = -1;

    Player_action.prototype.unit_id2 = -1;

    Player_action.prototype.x = 0;

    Player_action.prototype.y = 0;

    Player_action.prototype.x2 = 0;

    Player_action.prototype.y2 = 0;

    Player_action.prototype.clone = function() {
      var ret;
      ret = new Player_action;
      ret.type = this.type;
      ret.shop_id = this.shop_id;
      ret.shop_cost = this.shop_cost;
      ret.unit_id = this.unit_id;
      ret.unit_id2 = this.unit_id2;
      ret.x = this.x;
      ret.y = this.y;
      ret.x2 = this.x2;
      ret.y2 = this.y2;
      return ret;
    };

    Player_action.prototype.serialize_obj = function() {
      var ret;
      ret = {};
      ret.type = this.type;
      ret.shop_id = this.shop_id;
      ret.shop_cost = this.shop_cost;
      ret.unit_id = this.unit_id;
      ret.unit_id2 = this.unit_id2;
      ret.x = this.x;
      ret.y = this.y;
      ret.x2 = this.x2;
      ret.y2 = this.y2;
      return ret;
    };

    Player_action.prototype.deserialize_obj = function(obj) {
      this.type = obj.type;
      this.shop_id = obj.shop_id;
      this.shop_cost = obj.shop_cost;
      this.unit_id = obj.unit_id;
      this.unit_id2 = obj.unit_id2;
      this.x = obj.x;
      this.y = obj.y;
      this.x2 = obj.x2;
      this.y2 = obj.y2;
    };

    return Player_action;

  })();

  this.window.Player_intermediate_state = (function() {
    Player_intermediate_state.prototype.start_state = null;

    Player_intermediate_state.prototype.final_state = null;

    Player_intermediate_state.prototype.action_list = [];

    function Player_intermediate_state() {
      this.action_list = [];
    }

    Player_intermediate_state.prototype.final_state_calc = function() {
      var action, state, _i, _len, _ref;
      state = this.start_state.clone();
      _ref = this.action_list;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        action = _ref[_i];
        state.action_apply(action);
      }
      return this.final_state = state;
    };

    Player_intermediate_state.prototype.action_add = function(action) {
      var state;
      state = this.final_state.clone();
      state.action_apply(action);
      this.action_list.push(action);
      return this.final_state = state;
    };

    Player_intermediate_state.prototype.action_list_serialize_json = function() {
      var action, action_list, _i, _len, _ref;
      action_list = [];
      _ref = this.action_list;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        action = _ref[_i];
        action_list.push(action.serialize_obj());
      }
      return JSON.stringify(action_list);
    };

    Player_intermediate_state.prototype.action_list_deserialize_json = function(json) {
      var action, action_list, new_action, _i, _len;
      action_list = JSON.parse(json);
      this.action_list.clear();
      for (_i = 0, _len = action_list.length; _i < _len; _i++) {
        action = action_list[_i];
        new_action = new Player_action;
        new_action.deserialize_obj(action);
        this.action_list.push(new_action);
      }
    };

    Player_intermediate_state.prototype.final_state_serialize_json = function() {
      return this.final_state.serialize_json();
    };

    return Player_intermediate_state;

  })();

}).call(this);
