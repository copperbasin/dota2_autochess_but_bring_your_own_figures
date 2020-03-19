(function() {
  var FSM, FSM_event, FSM_unit_state, Projectile, damage_deal, module;

  module = emulator;

  Projectile = emulator.Projectile;

  FSM = emulator.FSM, FSM_unit_state = emulator.FSM_unit_state, FSM_event = emulator.FSM_event;

  damage_deal = emulator.damage_deal;

  module.fsm_craft = function(opt) {
    var can_attack, can_cast, cast_effect, cast_target_enemy, ret, state, _i, _len, _ref;
    if (opt == null) {
      opt = {};
    }
    cast_target_enemy = opt.cast_target_enemy, cast_effect = opt.cast_effect;
    if (cast_target_enemy == null) {
      cast_target_enemy = true;
    }
    ret = new FSM;
    ret.state_list.push(FSM_unit_state.idling);
    if (can_attack = opt.attack_type != null) {
      switch (opt.attack_type) {
        case "melee":
        case "ranged":
          ret.state_list.push(FSM_unit_state.attacking_pre);
          ret.state_list.push(FSM_unit_state.attacking);
          break;
        default:

          /* !pragma coverage-skip-block */
          throw new Error("unknown attack_type '" + opt.attack_type + "'");
      }
    }
    if (can_cast = opt.cast_type != null) {
      switch (opt.cast_type) {
        case "cast":
          ret.state_list.push(FSM_unit_state.casting_pre);
          ret.state_list.push(FSM_unit_state.casting);
          break;
        case "channel":

          /* !pragma coverage-skip-block */
          throw new Error("unimplemented channel cast_type");
          break;
        default:

          /* !pragma coverage-skip-block */
          throw new Error("unknown cast_type '" + opt.cast_type + "'");
      }
    }
    _ref = ret.state_list;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      state = _ref[_i];
      ret.transition_hash[state] = {};
    }
    ret.transition_hash[FSM_unit_state.idling][FSM_event.tick] = function(unit, state) {
      var tick_idx;
      tick_idx = state.tick_idx;
      if (can_cast) {
        while (true) {
          if (unit.mp100 < 10000) {
            break;
          }
          if (cast_target_enemy && unit.target_unit_uid === -1) {
            break;
          }
          unit.fsm_next_event_tick = state.tick_idx + unit.cast_pre;
          unit.fsm_idx = FSM_unit_state.casting_pre;
          return true;
        }
      }
      if (can_attack) {
        if (unit.next_tick_attack_available <= tick_idx) {
          unit.fsm_next_event_tick = state.tick_idx + unit.a_pre;
          unit.fsm_idx = FSM_unit_state.attacking_pre;
          return true;
        } else {
          unit.fsm_next_event_tick = unit.next_tick_attack_available;
          return true;
        }
      }
      return false;
    };
    if (can_attack) {
      ret.transition_hash[FSM_unit_state.attacking_pre][FSM_event.tick] = function(unit, state) {
        var target;
        if (!(target = state.cache_unit_hash[unit.target_unit_uid])) {
          unit.fsm_idx = FSM_unit_state.idling;
          unit.fsm_next_event_tick = state.tick_idx + 1;
          return true;
        }
        if (unit.fsm_next_event_tick > state.tick_idx) {
          return false;
        }
        if (unit.fsm_next_event_tick < state.tick_idx) {

          /* !pragma coverage-skip-block */
          throw new Error("OVERSHOOT " + (state.tick_idx - unit.fsm_next_event_tick));
        }
        unit.fsm_idx = FSM_unit_state.attacking;
        unit.fsm_next_event_tick = state.tick_idx + 1;
        return true;
      };
      switch (opt.attack_type) {
        case "melee":
          ret.transition_hash[FSM_unit_state.attacking][FSM_event.tick] = function(unit, state) {
            var target;
            if (!(target = state.cache_unit_hash[unit.target_unit_uid])) {
              unit.fsm_idx = FSM_unit_state.idling;
              unit.fsm_next_event_tick = state.tick_idx + 1;
              return true;
            }
            damage_deal(unit, target, state);
            unit.fsm_idx = FSM_unit_state.idling;
            unit.next_tick_attack_available = state.tick_idx + unit.a_post;
            return true;
          };
          break;
        case "ranged":
          ret.transition_hash[FSM_unit_state.attacking][FSM_event.tick] = function(unit, state) {
            var projectile, target;
            if (!(target = state.cache_unit_hash[unit.target_unit_uid])) {
              unit.fsm_idx = FSM_unit_state.idling;
              unit.fsm_next_event_tick = state.tick_idx + 1;
              return true;
            }
            projectile = new Projectile;
            projectile.hd_next_tick = state.tick_idx + 1;
            projectile.x = unit.x;
            projectile.y = unit.y;
            projectile.target = target;
            projectile.effect = function() {
              return damage_deal(unit, target, state);
            };
            state.projectile_list.push(projectile);
            state.event_counter++;
            unit.fsm_idx = FSM_unit_state.idling;
            unit.next_tick_attack_available = state.tick_idx + unit.a_post;
            return true;
          };
      }
    }
    if (can_cast) {
      if (!cast_effect) {

        /* !pragma coverage-skip-block */
        throw new Error("missing cast_effect");
      }
      if (cast_target_enemy) {
        ret.transition_hash[FSM_unit_state.casting_pre][FSM_event.tick] = function(unit, state) {
          var target;
          if (unit.fsm_next_event_tick > state.tick_idx) {
            return false;
          }
          if (unit.fsm_next_event_tick < state.tick_idx) {

            /* !pragma coverage-skip-block */
            throw new Error("OVERSHOOT " + (state.tick_idx - unit.fsm_next_event_tick));
          }
          if (!(target = state.cache_unit_hash[unit.target_unit_uid])) {
            unit.fsm_idx = FSM_unit_state.idling;
            unit.fsm_next_event_tick = state.tick_idx + 1;
            return true;
          }
          unit.fsm_idx = FSM_unit_state.casting;
          unit.fsm_next_event_tick = state.tick_idx + 1;
          return true;
        };
        ret.transition_hash[FSM_unit_state.casting][FSM_event.tick] = function(unit, state) {
          var target;
          if (!(target = state.cache_unit_hash[unit.target_unit_uid])) {
            unit.fsm_idx = FSM_unit_state.idling;
            unit.fsm_next_event_tick = state.tick_idx + 1;
            return true;
          }
          cast_effect({
            unit: unit,
            target: target,
            state: state
          });
          state.event_counter++;
          unit.fsm_idx = FSM_unit_state.idling;
          unit.fsm_next_event_tick = state.tick_idx + 1;
          return true;
        };
      } else {

        /* !pragma coverage-skip-block */
        throw new Error("!cast_target_enemy not implemented");
      }
    }
    return ret;
  };

}).call(this);
