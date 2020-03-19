(function() {
  var filter_by_type, wrap_me;

  filter_by_type = function(unit_list, type) {
    return unit_list.filter(function(unit) {
      if (unit["class"] === name) {
        return true;
      }
      if (unit.spec === name) {
        return true;
      }
      return false;
    });
  };

  wrap_me = function(name, cb) {
    return function(state) {
      var cache_side_unit_list, filter_unit_list, side, unit_list, _i, _len;
      cache_side_unit_list = state.cache_side_unit_list;
      for (side = _i = 0, _len = cache_side_unit_list.length; _i < _len; side = ++_i) {
        unit_list = cache_side_unit_list[side];
        filter_unit_list = filter_by_type(unit_list, name);
        cb(state, filter_unit_list, side);
      }
    };
  };

  window.faction_buff = {
    warrior: wrap_me(function(state, unit_list, side) {}),
    druid: wrap_me(function(state, unit_list, side) {}),
    mage: wrap_me(function(state, unit_list, side) {}),
    hunter: wrap_me(function(state, unit_list, side) {}),
    assasin: wrap_me(function(state, unit_list, side) {}),
    mech: wrap_me(function(state, unit_list, side) {}),
    shaman: wrap_me(function(state, unit_list, side) {}),
    knight: wrap_me(function(state, unit_list, side) {}),
    demon_hunter: wrap_me(function(state, unit_list, side) {}),
    warlock: wrap_me(function(state, unit_list, side) {}),
    orc: wrap_me(function(state, unit_list, side) {}),
    beast: wrap_me(function(state, unit_list, side) {
      var mult, unit, _i, _len, _ref;
      mult = 1;
      if (unit_list.length >= 2) {
        mult = 1.1;
      }
      if (unit_list.length >= 4) {
        mult = 1.15;
      }
      if (unit_list.length >= 6) {
        mult = 1.2;
      }
      _ref = state.cache_side_unit_list[side];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        unit = _ref[_i];
        unit.ad100 = Math.floor(unit.ad100 * mult);
      }
    }),
    ogre: wrap_me(function(state, unit_list, side) {}),
    undead: wrap_me(function(state, unit_list, side) {}),
    goblin: wrap_me(function(state, unit_list, side) {}),
    troll: wrap_me(function(state, unit_list, side) {}),
    elf: wrap_me(function(state, unit_list, side) {}),
    human: wrap_me(function(state, unit_list, side) {}),
    demon: wrap_me(function(state, unit_list, side) {
      var enemy_demon_hunter, unit;
      enemy_demon_hunter = filter_by_type(state.cache_side_unit_list[+(!side)], "demon_hunter");
      if (enemy_demon_hunter.length) {
        return;
      }
      if (unit_list.length === 1) {
        unit = unit_list[0];
        unit.ad100 = Math.floor(unit.ad100 * 1.5);
      }
    }),
    elemental: wrap_me(function(state, unit_list, side) {}),
    naga: wrap_me(function(state, unit_list, side) {}),
    dwarf: wrap_me(function(state, unit_list, side) {}),
    dragon: wrap_me(function(state, unit_list, side) {})
  };

}).call(this);
