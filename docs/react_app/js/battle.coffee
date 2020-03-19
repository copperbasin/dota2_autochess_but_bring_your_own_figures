(function() {
  window.prepare_battle = function(player_a_state, player_b_state) {
    var res, unit, _id, _ref, _ref1;
    res = new emulator.State;
    _ref = player_a_state.board_unit_hash;
    for (_id in _ref) {
      unit = _ref[_id];
      if (unit.y === 8) {
        continue;
      }
      res.unit_list.push(battle_unit_create({
        grid_x: unit.x,
        grid_y: unit.y,
        type: unit.type,
        side: 0,
        star_lvl: unit.star_lvl
      }));
    }
    _ref1 = player_b_state.board_unit_hash;
    for (_id in _ref1) {
      unit = _ref1[_id];
      if (unit.y === 8) {
        continue;
      }
      res.unit_list.push(battle_unit_create({
        grid_x: 7 - unit.x,
        grid_y: 7 - unit.y,
        type: unit.type,
        side: 1,
        star_lvl: unit.star_lvl
      }));
    }
    return res;
  };

}).call(this);
