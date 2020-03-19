(function() {
  var Status_effect, module;

  module = emulator;

  Status_effect = emulator.Status_effect;

  module.Unit = (function() {
    Unit.prototype._remove = false;

    Unit.prototype._last_update_tick = 0;

    Unit.uid = 0;

    Unit.prototype.uid = 0;

    Unit.prototype.side = 0;

    Unit.prototype.x = 0;

    Unit.prototype.y = 0;

    Unit.prototype.hp100 = 100;

    Unit.prototype.hp_max100 = 100;

    Unit.prototype.hp_reg100 = 0;

    Unit.prototype.mp100 = 0;

    Unit.prototype.mp_max100 = 10000;

    Unit.prototype.mp_reg100 = 0;

    Unit.prototype.as = 100;

    Unit.prototype.bat = 1.7;

    Unit.prototype.base_a_pre = 10;

    Unit.prototype.base_a_post = 10;

    Unit.prototype.ad100 = 0;

    Unit.prototype.a_pre = 10;

    Unit.prototype.a_post = 10;

    Unit.prototype.next_tick_attack_available = 0;

    Unit.prototype.a_mod_fn_list = [];

    Unit.prototype.damage_block_fn_list = [];

    Unit.prototype.cast_pre = 1;

    Unit.prototype.status_effect_bitmap = [0, 0, 0, 0];

    Unit.prototype.status_effect_list = [];

    Unit.prototype.target_unit_uid = -1;

    Unit.prototype.fsm_idx = 0;

    Unit.prototype.fsm_next_event_tick = 0;

    Unit.prototype.fsm_ref = null;

    function Unit() {
      this.uid = module.Unit.uid++;
      this.a_mod_fn_list = [];
      this.damage_block_fn_list = [];
      this.status_effect_bitmap = [0, 0, 0, 0];
      this.status_effect_list = [];
    }

    Unit.prototype.target_policy = function(target_unit_list) {
      var best_unit, best_unit_d2, d2, dx, dy, idx, len, unit, x, y, _i;
      x = this.x, y = this.y;
      best_unit = target_unit_list[0];
      unit = best_unit;
      dx = unit.x - x;
      dy = unit.y - y;
      d2 = dx * dx + dy * dy;
      best_unit_d2 = d2;
      len = target_unit_list.length;
      for (idx = _i = 1; _i < len; idx = _i += 1) {
        unit = target_unit_list[idx];
        dx = unit.x - x;
        dy = unit.y - y;
        d2 = dx * dx + dy * dy;
        if (best_unit_d2 > d2) {
          best_unit = unit;
          best_unit_d2 = d2;
        }
      }
      return best_unit;
    };

    Unit.prototype.assert_cmp = function(t) {

      /* !pragma coverage-skip-block */
      var error_list;
      error_list = [];
      if (this.uid !== t.uid) {
        error_list.push("@uid         != t.uid          " + this.uid + " != " + t.uid);
      }
      if (this.x !== t.x) {
        error_list.push("@x           != t.x            " + this.x + " != " + t.x);
      }
      if (this.y !== t.y) {
        error_list.push("@y           != t.y            " + this.y + " != " + t.y);
      }
      if (this.side !== t.side) {
        error_list.push("@side        != t.side         " + this.side + " != " + t.side);
      }
      if (this.hp100 !== t.hp100) {
        error_list.push("@hp100       != t.hp100        " + this.hp100 + " != " + t.hp100);
      }
      if (this.hp_max100 !== t.hp_max100) {
        error_list.push("@hp_max100   != t.hp_max100    " + this.hp_max100 + " != " + t.hp_max100);
      }
      if (this.hp_reg100 !== t.hp_reg100) {
        error_list.push("@hp_reg100   != t.hp_reg100    " + this.hp_reg100 + " != " + t.hp_reg100);
      }
      if (this.mp100 !== t.mp100) {
        error_list.push("@mp100       != t.mp100        " + this.mp100 + " != " + t.mp100);
      }
      if (this.mp_max100 !== t.mp_max100) {
        error_list.push("@mp_max100   != t.mp_max100    " + this.mp_max100 + " != " + t.mp_max100);
      }
      if (this.mp_reg100 !== t.mp_reg100) {
        error_list.push("@mp_reg100   != t.mp_reg100    " + this.mp_reg100 + " != " + t.mp_reg100);
      }
      if (this.as !== t.as) {
        error_list.push("@as          != t.as           " + this.as + " != " + t.as);
      }
      if (this.bat !== t.bat) {
        error_list.push("@bat         != t.bat          " + this.bat + " != " + t.bat);
      }
      if (this.base_a_pre !== t.base_a_pre) {
        error_list.push("@base_a_pre  != t.base_a_pre   " + this.base_a_pre + " != " + t.base_a_pre);
      }
      if (this.base_a_post !== t.base_a_post) {
        error_list.push("@base_a_post != t.base_a_post  " + this.base_a_post + " != " + t.base_a_post);
      }
      if (this.ad100 !== t.ad100) {
        error_list.push("@ad100       != t.ad100        " + this.ad100 + " != " + t.ad100);
      }
      if (this.a_pre !== t.a_pre) {
        error_list.push("@a_pre       != t.a_pre        " + this.a_pre + " != " + t.a_pre);
      }
      if (this.a_post !== t.a_post) {
        error_list.push("@a_post      != t.a_post       " + this.a_post + " != " + t.a_post);
      }
      if (this.target_unit_uid !== t.target_unit_uid) {
        error_list.push("@target_unit_uid     != t.target_unit_uid      " + this.target_unit_uid + "     != " + t.target_unit_uid);
      }
      if (this.fsm_idx !== t.fsm_idx) {
        error_list.push("@fsm_idx             != t.fsm_idx              " + this.fsm_idx + "             != " + t.fsm_idx);
      }
      if (this.fsm_next_event_tick !== t.fsm_next_event_tick) {
        error_list.push("@fsm_next_event_tick != t.fsm_next_event_tick  " + this.fsm_next_event_tick + " != " + t.fsm_next_event_tick);
      }
      if (error_list.length) {
        throw new Error(error_list.join(";\n"));
      }
    };

    Unit.prototype.status_effect_raw_add = function(id, until_ts) {
      var big_idx, mask, small_idx, status_effect;
      big_idx = Math.floor(id / 32);
      small_idx = id % 32;
      mask = 1 << small_idx;
      this.status_effect_bitmap[big_idx] |= mask;
      status_effect = new Status_effect;
      status_effect.id = id;
      status_effect.until_ts = until_ts;
      this.status_effect_list.push(status_effect);
    };

    Unit.prototype.status_effect_update_bitmap = function() {
      var big_idx, id, mask, small_idx, status_effect, status_effect_bitmap, _i, _len, _ref;
      status_effect_bitmap = this.status_effect_bitmap;
      status_effect_bitmap[0] = 0;
      status_effect_bitmap[1] = 0;
      status_effect_bitmap[2] = 0;
      status_effect_bitmap[3] = 0;
      _ref = this.status_effect_list;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        status_effect = _ref[_i];
        id = status_effect.id;
        big_idx = Math.floor(id / 32);
        small_idx = id % 32;
        mask = 1 << small_idx;
        status_effect_bitmap[big_idx] |= mask;
      }
    };

    return Unit;

  })();

}).call(this);
