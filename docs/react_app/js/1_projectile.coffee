(function() {
  var module;

  module = emulator;

  module.Projectile = (function() {
    Projectile.prototype._remove = false;

    Projectile.prototype._last_update_tick = 0;

    Projectile.uid = 0;

    Projectile.prototype.uid = 0;

    Projectile.prototype.side = 0;

    Projectile.prototype.x = 0;

    Projectile.prototype.y = 0;

    Projectile.prototype.ms = 1000;

    Projectile.prototype.target = null;

    Projectile.prototype.hd_next_tick = 0;

    Projectile.prototype.effect = function() {};

    function Projectile() {
      this.uid = module.Projectile.uid++;
    }

    Projectile.prototype.assert_cmp = function(t) {

      /* !pragma coverage-skip-block */
      var error_list;
      error_list = [];
      if (this.uid !== t.uid) {
        error_list.push("@uid         != t.uid          " + this.uid + " != " + t.uid);
      }
      if (this.x !== t.x) {
        error_list.push("@x           != t.x            " + this.x + " != " + t.x);
      }
      if (this.y !== t.y) {
        error_list.push("@y           != t.y            " + this.y + " != " + t.y);
      }
      if (this.side !== t.side) {
        error_list.push("@side        != t.side         " + this.side + " != " + t.side);
      }
      if (this.ms !== t.ms) {
        error_list.push("@ms          != t.ms           " + this.ms + " != " + t.ms);
      }
      if (this.target.uid !== t.target.uid) {
        error_list.push("@target.uid  != t.target.uid   " + this.target.uid + " != " + t.target.uid);
      }
      if (error_list.length) {
        throw new Error(error_list.join(";\n"));
      }
    };

    return Projectile;

  })();

}).call(this);
