(function() {
  var Projectile, Unit, module;

  module = emulator;

  Unit = module.Unit;

  Projectile = module.Projectile;

  module.State = (function() {
    State.prototype.tick_idx = 0;

    State.prototype.event_counter = 0;

    State.prototype.unit_list = [];

    State.prototype.projectile_list = [];

    State.prototype.aoe_list = [];

    State.prototype.pending_effect_list = [];

    State.prototype.cache_unit_hash = {};

    State.prototype.cache_side_unit_list = [];

    function State() {
      Unit.uid = 0;
      Projectile.uid = 0;
      this.unit_list = [];
      this.projectile_list = [];
      this.aoe_list = [];
      this.pending_effect_list = [];
      this.cache_unit_hash = {};
      this.cache_side_unit_list = [];
    }

    State.prototype.assert_cmp = function(t) {

      /* !pragma coverage-skip-block */
      var a, b, idx, k, side, side_list, t_projectile_list, t_side_list, t_unit_list, unit, unit_idx, v, _i, _j, _k, _l, _len, _len1, _len2, _len3, _ref, _ref1, _ref2, _ref3, _ref4;
      if (this.unit_list.length !== t.unit_list.length) {
        throw new Error("@unit_list.length != t.unit_list.length " + this.unit_list.length + " != " + t.unit_list.length);
      }
      t_unit_list = t.unit_list;
      _ref = this.unit_list;
      for (idx = _i = 0, _len = _ref.length; _i < _len; idx = ++_i) {
        a = _ref[idx];
        b = t_unit_list[idx];
        a.assert_cmp(b);
      }
      t_projectile_list = t.projectile_list;
      _ref1 = this.projectile_list;
      for (idx = _j = 0, _len1 = _ref1.length; _j < _len1; idx = ++_j) {
        a = _ref1[idx];
        b = t_projectile_list[idx];
        a.assert_cmp(b);
      }
      _ref2 = this.cache_unit_hash;
      for (k in _ref2) {
        v = _ref2[k];
        if (!t.cache_unit_hash[k]) {
          throw new Error("Cache mismatch. key '" + k + "' mismatch in @cache_unit_hash");
        }
      }
      _ref3 = t.cache_unit_hash;
      for (k in _ref3) {
        v = _ref3[k];
        if (!this.cache_unit_hash[k]) {
          throw new Error("Cache mismatch. key '" + k + "' mismatch in @cache_unit_hash");
        }
      }
      _ref4 = this.cache_side_unit_list;
      for (side = _k = 0, _len2 = _ref4.length; _k < _len2; side = ++_k) {
        side_list = _ref4[side];
        t_side_list = t.cache_side_unit_list[side];
        for (unit_idx = _l = 0, _len3 = side_list.length; _l < _len3; unit_idx = ++_l) {
          unit = side_list[unit_idx];
          if (unit.uid !== t_side_list[unit_idx].uid) {
            throw new Error("Cache mismatch. side=" + side + " unit_idx=" + unit_idx + " unit.uid=" + unit.uid + " mismatch");
          }
        }
      }
      if (this.event_counter !== t.event_counter) {
        throw new Error("@event_counter != t.event_counter " + this.event_counter + " != " + t.event_counter);
      }
      if (this.tick_idx !== t.tick_idx) {
        throw new Error("@tick_idx != t.tick_idx " + this.tick_idx + " != " + t.tick_idx);
      }
    };

    State.prototype.cache_actualize = function() {
      var cache_side_unit_list, cache_unit_hash, unit, _i, _len, _ref;
      cache_unit_hash = {};
      cache_side_unit_list = [[], []];
      _ref = this.unit_list;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        unit = _ref[_i];
        cache_side_unit_list[unit.side].push(unit);
        cache_unit_hash[unit.uid] = unit;
      }
      this.cache_unit_hash = cache_unit_hash;
      this.cache_side_unit_list = cache_side_unit_list;
    };

    return State;

  })();

}).call(this);
