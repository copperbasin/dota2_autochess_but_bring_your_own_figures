(function() {
  window.Board = (function() {
    function Board() {}

    Board.prototype.player_host = null;

    Board.prototype.player_guest = null;

    Board.prototype.gen_emulator_start_state = function() {
      return prepare_battle(this.player_host.state.final_state, this.player_guest.state.final_state);
    };

    return Board;

  })();

  window.Net_game = (function() {
    Net_game.prototype.seed = 0;

    Net_game.prototype.battle_seed = 0;

    Net_game.prototype.active_player_list = [];

    Net_game.prototype.player_list = [];

    Net_game.prototype.board_list = [];

    Net_game.prototype.unit_pool_list = [];

    Net_game.prototype.current_player = null;

    Net_game.prototype.match_ready = false;

    function Net_game(match_serialized) {
      this.sync(match_serialized);
      return;
    }

    Net_game.prototype.sync = function(match_serialized) {
      var count, err, figure_id, figure_name, found, i, idx, net_player, order_id, player, player_state, start_state, test_state, _i, _j, _k, _l, _len, _len1, _len2, _len3, _len4, _m, _n, _ref, _ref1, _ref2, _ref3, _ref4, _ref5;
      this.seed = match_serialized.seed;
      this.battle_seed = match_serialized.battle_seed;
      this.active_player_list = [];
      this.board_list = [];
      this.unit_pool_list = [];
      _ref = match_serialized.match_player_list;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        net_player = _ref[_i];
        _ref1 = net_player.figure_hash;
        for (figure_name in _ref1) {
          count = _ref1[figure_name];
          figure_id = figure_name.split("_")[0];
          for (i = _j = 0; 0 <= count ? _j < count : _j > count; i = 0 <= count ? ++_j : --_j) {
            this.unit_pool_list.push(unit_id_hash[figure_id]);
          }
        }
      }
      _ref2 = match_serialized.match_player_list;
      for (order_id = _k = 0, _len1 = _ref2.length; _k < _len1; order_id = ++_k) {
        net_player = _ref2[order_id];
        this.active_player_list.push(player = new Player);
        player.id = net_player.id;
        player.nickname = net_player.nickname;
        player.is_commit_done = net_player.is_commit_done;
        player.state = player_state = new Player_intermediate_state;
        if (net_player.commit_state) {
          player.state.action_list_deserialize_json(net_player.commit_state.action_list);
        }
        player.last_game_reward = net_player.last_game_reward;
        if (net_player.last_consensus_state) {
          start_state = new Player_cross_round_state;
          start_state.deserialize_json(net_player.last_consensus_state);
          player.state.start_state = start_state;
        } else {
          player_state.start_state = new Player_cross_round_state;
          player_state.start_state.hp = 1;
          player_state.start_state.gold = 10;
        }
      }
      this.shop_init();
      _ref3 = this.active_player_list;
      for (idx = _l = 0, _len2 = _ref3.length; _l < _len2; idx = ++_l) {
        player = _ref3[idx];
        net_player = match_serialized.match_player_list[idx];
        player_state = player.state;
        try {
          if (net_player.commit_state) {
            test_state = new Player_cross_round_state;
            test_state.deserialize_json(net_player.commit_state.final_state);
            if (!test_state.cmp(player_state.final_state)) {
              throw new Error("!test_state.cmp(player_state.final_state)");
            }
          }
        } catch (_error) {
          err = _error;
          perr(err);
          player_state.final_state = player_state.start_state.clone();
        }
        player.order_id = order_id;
      }
      found = false;
      _ref4 = this.active_player_list;
      for (_m = 0, _len3 = _ref4.length; _m < _len3; _m++) {
        player = _ref4[_m];
        if (!player.is_commit_done) {
          found = true;
          break;
        }
      }
      this.match_ready = !found;
      this.player_list = this.active_player_list.clone();
      _ref5 = this.player_list;
      for (_n = 0, _len4 = _ref5.length; _n < _len4; _n++) {
        player = _ref5[_n];
        if (player.id === localStorage.player_id) {
          this.current_player = player;
        }
      }
    };

    Net_game.prototype.shop_init = function() {
      var cell, player, player_idx, player_idx_mod, unit, _i, _len, _ref;
      window.rand_seed = this.seed + 1;
      player_idx = 0;
      player_idx_mod = this.active_player_list.length;
      while (this.unit_pool_list.length) {
        unit = rand_list(this.unit_pool_list);
        this.unit_pool_list.remove(unit);
        player = this.active_player_list[player_idx];
        player_idx = (player_idx + 1) % player_idx_mod;
        cell = new Shop_unit;
        cell.id = player.state.start_state.shop_unit_list.length;
        cell.type = unit.type;
        cell.lvl = unit.level;
        player.state.start_state.shop_unit_list.push(cell);
      }
      _ref = this.active_player_list;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        player = _ref[_i];
        player.state.final_state_calc();
      }
    };

    Net_game.prototype.player_commit_server = function() {
      ws_ton.send({
        player_id: localStorage.player_id,
        "switch": "submit_position",
        action_list: this.current_player.state.action_list_serialize_json(),
        final_state: this.current_player.state.final_state_serialize_json()
      });
      this.current_player.is_commit_done = true;
    };

    Net_game.prototype.phase_calc_client = function() {
      var battle_final_state, battle_seed, board, emu, player, player_guest, result, sum, unit, _i, _j, _k, _l, _len, _len1, _len2, _len3, _ref, _ref1, _ref2, _ref3;
      battle_seed = this.battle_seed;
      window.rand_seed = battle_seed + 1;
      this.board_list.clear();
      _ref = this.active_player_list;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        player = _ref[_i];
        this.board_list.push(board = new Board);
        board.player_host = player;
        while (true) {
          player_guest = rand_list(this.active_player_list);
          if (player_guest !== player) {
            break;
          }
        }
        board.player_guest = player_guest;
      }
      _ref1 = this.board_list;
      for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
        board = _ref1[_j];
        window.rand_seed = battle_seed + 1;
        emu = new emulator.Emulator;
        emu.end_condition = emulator.eliminate;
        emu.tick_limit = 30 * 100;
        emu.state = board.gen_emulator_start_state();
        result = emu.go();
        battle_final_state = emu.state;
        switch (result) {
          case "s1":
            sum = 0;
            _ref2 = battle_final_state.unit_list;
            for (_k = 0, _len2 = _ref2.length; _k < _len2; _k++) {
              unit = _ref2[_k];
              sum += unit.star_lvl;
            }
            board.player_host.state.final_state.hp -= sum;
        }
      }
      _ref3 = this.active_player_list;
      for (_l = 0, _len3 = _ref3.length; _l < _len3; _l++) {
        player = _ref3[_l];
        player.state.action_list.clear();
        player.state.start_state = player.state.final_state;
        player.state.final_state_calc();
      }
      ws_ton.send({
        player_id: localStorage.player_id,
        "switch": "submit_sim_result",
        match: {
          match_player_list: this.active_player_list.map(function(player) {
            return player.state.final_state.serialize_json();
          })
        }
      });
    };

    Net_game.prototype.phase_consensus = function() {
      var player, _i, _len, _ref;
      this.match_ready = false;
      _ref = this.active_player_list;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        player = _ref[_i];
        player.is_commit_done = false;
      }
    };

    Net_game.prototype.phase_new_round = function() {
      this.active_player_list = this.active_player_list.filter(function(t) {
        return t.state.start_state.hp > 0;
      });
    };

    return Net_game;

  })();

}).call(this);
