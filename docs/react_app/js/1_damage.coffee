(function() {
  var module;

  module = emulator;

  module.Damage_instance = (function() {
    function Damage_instance() {}

    Damage_instance.prototype.damage100 = 0;

    return Damage_instance;

  })();

  module.Damage_modifier = (function() {
    function Damage_modifier() {}

    Damage_modifier.prototype.order = 0;

    Damage_modifier.prototype.fn = function(di, src, dst, state) {};

    return Damage_modifier;

  })();

}).call(this);
