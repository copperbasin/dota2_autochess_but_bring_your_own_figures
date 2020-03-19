(function() {
  var module;

  module = emulator;

  module.eliminate = function(state, is_last_tick) {
    var cache_side_unit_list, s0, s1;
    cache_side_unit_list = state.cache_side_unit_list;
    s0 = cache_side_unit_list[0].length;
    s1 = cache_side_unit_list[1].length;
    if (s0 > 0 && s1 > 0) {
      if (is_last_tick) {
        return "draw";
      }
      return null;
    }
    if (s0 === 0 && s1 > 0) {
      return "s1";
    }
    if (s0 > 0 && s1 === 0) {
      return "s0";
    }
    return "draw";
  };

}).call(this);
