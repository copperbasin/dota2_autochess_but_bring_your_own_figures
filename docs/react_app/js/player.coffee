(function() {
  window.Player = (function() {
    function Player() {}

    Player.prototype.id = 0;

    Player.prototype.order_id = 0;

    Player.prototype.nickname = "";

    Player.prototype.state = null;

    Player.prototype.is_commit_done = false;

    Player.prototype.last_game_reward = null;

    return Player;

  })();

}).call(this);
