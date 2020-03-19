(function() {
  window.shop_init = function(state, todo_player_id, todo_unit_pool_list) {
    var cell, i, shop_unit_list, _i;
    shop_unit_list = state.start_state.shop_unit_list;
    for (i = _i = 0; _i < 25; i = ++_i) {
      cell = new Shop_unit;
      cell.id = i;
      cell.type = unit_list[i].type;
      cell.lvl = unit_list[i].level;
      shop_unit_list.push(cell);
    }
  };

}).call(this);
