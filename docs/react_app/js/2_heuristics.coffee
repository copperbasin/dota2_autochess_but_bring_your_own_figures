(function() {
  var Damage_instance, module;

  Damage_instance = emulator.Damage_instance;

  module = emulator;

  module.tick_targeting = function(u0_list, u1_list, unit_hash) {
    var need_retarget, need_retarget_count, target, u0, _i, _len;
    need_retarget_count = 0;
    for (_i = 0, _len = u0_list.length; _i < _len; _i++) {
      u0 = u0_list[_i];
      need_retarget = false;
      if (u0.target_unit_uid === -1) {
        need_retarget = true;
      }
      if (!unit_hash[u0.target_unit_uid]) {
        need_retarget = true;
      }
      if (need_retarget) {
        need_retarget_count++;
        if (u1_list.length === 0) {
          u0.target_unit_uid = -1;
          continue;
        }
        target = u0.target_policy(u1_list);
        if (!target) {
          u0.target_unit_uid = -1;
        } else {
          u0.target_unit_uid = target.uid;
        }
      }
    }
    return need_retarget_count;
  };

  module.retargeting = function(state) {
    var cache_side_unit_list, cache_unit_hash, need_retarget_count, u0_list, u1_list;
    cache_unit_hash = state.cache_unit_hash, cache_side_unit_list = state.cache_side_unit_list;
    u0_list = cache_side_unit_list[0], u1_list = cache_side_unit_list[1];
    need_retarget_count = 0;
    need_retarget_count += module.tick_targeting(u0_list, u1_list, cache_unit_hash);
    need_retarget_count += module.tick_targeting(u1_list, u0_list, cache_unit_hash);
    return need_retarget_count;
  };

  module.dead_remove = function(state) {
    var cache_side_unit_list, cache_unit_hash, idx, projectile, projectile_list, unit, unit_list;
    unit_list = state.unit_list, projectile_list = state.projectile_list, cache_unit_hash = state.cache_unit_hash, cache_side_unit_list = state.cache_side_unit_list;
    idx = 0;
    while (true) {
      if (idx >= unit_list.length) {
        break;
      }
      unit = unit_list[idx];
      if (unit._remove) {
        unit_list.remove_idx(idx);
        delete cache_unit_hash[unit.uid];
        cache_side_unit_list[unit.side].remove(unit);
        continue;
      }
      idx++;
    }
    idx = 0;
    while (true) {
      if (idx >= projectile_list.length) {
        break;
      }
      projectile = projectile_list[idx];
      if (projectile._remove) {
        projectile_list.remove_idx(idx);
        continue;
      }
      idx++;
    }
  };

  module.damage_deal = function(src, dst, state) {
    state.pending_effect_list.push(function() {
      var di, mod, _i, _j, _len, _len1, _ref, _ref1;
      di = new Damage_instance;
      di.damage100 = src.ad100;
      _ref = src.a_mod_fn_list;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        mod = _ref[_i];
        mod.fn(di, src, dst, state);
      }
      _ref1 = dst.damage_block_fn_list;
      for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
        mod = _ref1[_j];
        mod.fn(di, src, dst, state);
      }
      dst.hp100 -= di.damage100;
      state.event_counter++;
      src.mp100 += 2500;
      dst.mp100 += 2500;
      return [src, dst];
    });
  };

  module.status_effect_remove = function(state) {
    var idx, remove_idx_list, status_effect, status_effect_list, tick_idx, unit, unit_list, _i, _j, _len, _len1, _ref;
    tick_idx = state.tick_idx, unit_list = state.unit_list;
    for (_i = 0, _len = unit_list.length; _i < _len; _i++) {
      unit = unit_list[_i];
      status_effect_list = unit.status_effect_list;
      remove_idx_list = [];
      _ref = unit.status_effect_list;
      for (idx = _j = 0, _len1 = _ref.length; _j < _len1; idx = ++_j) {
        status_effect = _ref[idx];
        if (tick_idx > status_effect.until_ts) {

          /* !pragma coverage-skip-block */
          throw new Error("OVERSHOOT " + (state.tick_idx - unit.fsm_next_event_tick));
        }
        if (tick_idx === status_effect.until_ts) {
          remove_idx_list.push(idx);
        }
      }
      if (remove_idx_list.length) {
        while (remove_idx_list.length) {
          idx = remove_idx_list.pop();
          status_effect_list.fast_remove_idx(idx);
        }
        unit.status_effect_update_bitmap();
      }
    }
  };

}).call(this);
