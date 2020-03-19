(function() {
  var module, _uid;

  module = emulator;

  _uid = 0;

  module.status_effect_hash = {
    none: _uid++,
    stun: _uid++,
    shackle: _uid++,
    cyclone: _uid++,
    fear: _uid++,
    taunt: _uid++,
    hide: _uid++,
    hex: _uid++,
    root: _uid++,
    disarm: _uid++,
    ethereal: _uid++,
    silence: _uid++,
    mute: _uid++,
    forced_move: _uid++,
    "break": _uid++,
    leash: _uid++,
    attack_slow: _uid++,
    move_slow: _uid++,
    blind: _uid++
  };

  module.status_effect_to_idx_mask = function(id) {
    var big_idx, mask, small_idx;
    big_idx = Math.floor(id / 32);
    small_idx = id % 32;
    mask = 1 << small_idx;
    return {
      big_idx: big_idx,
      small_idx: small_idx,
      mask: mask
    };
  };

  module.Status_effect = (function() {
    function Status_effect() {}

    Status_effect.prototype.id = -1;

    Status_effect.prototype.until_ts = 0;

    Status_effect.prototype.on_apply = function(unit, state) {};

    Status_effect.prototype.on_remove = function(unit, state) {};

    return Status_effect;

  })();

}).call(this);
