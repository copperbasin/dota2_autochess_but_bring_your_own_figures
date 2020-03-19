(function() {
  var FSM_event, State, dead_remove, fast_stun_idx, fast_stun_mask, module, retargeting, status_effect_hash, status_effect_remove, status_effect_to_idx_mask, _ref;

  module = emulator;

  status_effect_hash = module.status_effect_hash;

  State = module.State;

  FSM_event = module.FSM_event;

  dead_remove = module.dead_remove, retargeting = module.retargeting, status_effect_remove = module.status_effect_remove;

  status_effect_to_idx_mask = module.status_effect_to_idx_mask, status_effect_hash = module.status_effect_hash;

  _ref = status_effect_to_idx_mask(status_effect_hash.stun), fast_stun_idx = _ref.big_idx, fast_stun_mask = _ref.mask;

  module.Emulator = (function() {
    Emulator.prototype.tick_per_sec = 100;

    Emulator.prototype.tick_limit = 0;

    Emulator.prototype.state = null;

    Emulator.prototype.end_condition = function(state, is_last_tick) {
      if (is_last_tick) {
        return "draw";
      } else {
        return null;
      }
    };

    function Emulator() {
      this.state = new State;
    }

    Emulator.prototype.tick = function() {
      var d, d2, dx, dy, effect, fn, ms, ms_per_tick, pending_effect_list, projectile, projectile_list, regen_per_tick, state, target, tick_idx, tick_per_sec, unit, unit_list, vx, vy, _i, _j, _k, _l, _len, _len1, _len2, _len3;
      state = this.state, tick_per_sec = this.tick_per_sec;
      tick_idx = state.tick_idx, unit_list = state.unit_list, projectile_list = state.projectile_list, pending_effect_list = state.pending_effect_list;
      status_effect_remove(state);
      for (_i = 0, _len = projectile_list.length; _i < _len; _i++) {
        projectile = projectile_list[_i];
        target = projectile.target, ms = projectile.ms;
        ms_per_tick = Math.floor(ms / tick_per_sec);
        dx = target.x - projectile.x;
        dy = target.y - projectile.y;
        d2 = dx * dx + dy * dy;
        if (d2 < ms_per_tick) {
          projectile._remove = true;
          projectile.effect({
            state: state
          });
        } else {
          d = Math.sqrt(d2);
          dx /= d;
          dy /= d;
          vx = dx * ms_per_tick;
          vy = dy * ms_per_tick;
          projectile.x += vx;
          projectile.y += vy;
        }
      }
      for (_j = 0, _len1 = unit_list.length; _j < _len1; _j++) {
        unit = unit_list[_j];
        if (unit.status_effect_bitmap[fast_stun_idx] & fast_stun_mask) {
          continue;
        }
        fn = unit.fsm_ref.transition_hash[unit.fsm_idx][FSM_event.tick];
        if (typeof fn === "function") {
          fn(unit, state);
        }
      }
      for (_k = 0, _len2 = pending_effect_list.length; _k < _len2; _k++) {
        effect = pending_effect_list[_k];
        effect();
      }
      pending_effect_list.clear();
      for (_l = 0, _len3 = unit_list.length; _l < _len3; _l++) {
        unit = unit_list[_l];
        regen_per_tick = Math.floor(unit.hp_reg100 / tick_per_sec);
        unit.hp100 = Math.min(unit.hp_max100, unit.hp100 + regen_per_tick);
        if (unit.hp100 <= 0) {
          state.event_counter++;
          unit._remove = true;
        }
        regen_per_tick = Math.floor(unit.mp_reg100 / tick_per_sec);
        unit.mp100 = Math.max(0, Math.min(unit.mp_max100, unit.mp100 + regen_per_tick));
      }
      dead_remove(state);
      retargeting(state);
    };

    Emulator.prototype.go = function() {
      this.state.cache_actualize();
      while (true) {
        this.tick();
        if (this.end_condition(this.state)) {
          break;
        }
        if (this.state.tick_idx >= this.tick_limit) {
          break;
        }
        this.state.tick_idx++;
      }
      return this.end_condition(this.state, true);
    };

    return Emulator;

  })();

}).call(this);
