
/*
limitations
  single board
  1 hp
  visitor lose -> lose hp
 */

(function() {
  this.Practice_game = (function() {
    Practice_game.prototype.active_player_list = [];

    Practice_game.prototype.player_list = [];

    function Practice_game() {
      var action, player, player_state;
      this.active_player_list = [];
      this.active_player_list.push(player = new Player);
      player.nickname = "Player";
      player.state = player_state = new Player_intermediate_state;
      player_state.start_state = new Player_cross_round_state;
      player_state.start_state.hp = 1;
      player_state.start_state.gold = 10;
      shop_init(player_state, 0, []);
      player_state.final_state_calc();
      this.active_player_list.push(player = new Player);
      player.nickname = "Bot";
      player.state = player_state = new Player_intermediate_state;
      player_state.start_state = new Player_cross_round_state;
      player_state.start_state.hp = 1;
      player_state.start_state.gold = 10;
      shop_init(player_state, 1, []);
      player_state.final_state_calc();
      action = new Player_action;
      action.type = Player_action.BUY;
      action.shop_id = 0;
      action.x = 0;
      action.y = 8;
      player_state.action_add(action);
      action = new Player_action;
      action.type = Player_action.MOVE;
      action.unit_id = 0;
      action.x = 0;
      action.y = 7;
      player_state.action_add(action);
      this.player_list = this.active_player_list.clone();
    }

    Practice_game.prototype._player_commit = function(player) {
      var player_state;
      player_state = player.state;
      player_state.start_state = player_state.final_state;
      player_state.final_state = player_state.final_state.clone();
      player_state.action_list.clear();
      player_state.start_state.shop_unit_list = player_state.start_state.shop_unit_list.filter(function(t) {
        return !t.is_bought;
      });
    };

    Practice_game.prototype.phase_buy_finish = function() {
      var player, _i, _len, _ref;
      _ref = this.active_player_list;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        player = _ref[_i];
        this._player_commit(player);
      }
    };

    Practice_game.prototype.phase_battle_finish = function(result, battle_final_state) {
      var player, sum, unit, _i, _j, _k, _len, _len1, _len2, _ref, _ref1, _ref2;
      switch (result) {
        case "s0":
          sum = 0;
          _ref = battle_final_state.unit_list;
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            unit = _ref[_i];
            sum += unit.star_lvl;
          }
          this.active_player_list[1].state.start_state.hp -= sum;
          break;
        case "s1":
          sum = 0;
          _ref1 = battle_final_state.unit_list;
          for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
            unit = _ref1[_j];
            sum += unit.star_lvl;
          }
          this.active_player_list[0].state.start_state.hp -= sum;
      }
      _ref2 = this.active_player_list;
      for (_k = 0, _len2 = _ref2.length; _k < _len2; _k++) {
        player = _ref2[_k];
        player.state.final_state = player.state.start_state.clone();
      }
      this.active_player_list = this.active_player_list.filter(function(t) {
        return t.state.start_state.hp > 0;
      });
    };

    return Practice_game;

  })();

}).call(this);
