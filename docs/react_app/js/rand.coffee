(function() {
  var rand_a, rand_b, rand_mod;

  window.rand_seed = 1;

  rand_a = 16807;

  rand_b = 0;

  rand_mod = Math.pow(2, 31) - 1;

  window._rand = function() {
    return window.rand_seed = (rand_a * window.rand_seed + rand_b) % rand_mod;
  };

  window.rand_range = function(a, b) {
    var val;
    val = _rand();
    return (val % (b - a + 1)) + a;
  };

  window.rand_list = function(list) {
    var idx, val;
    val = _rand();
    idx = val % list.length;
    return list[idx];
  };

  window.__debug_rand_test = function(n) {
    var hash, i, k, key, kv_list, max, v, _i, _j;
    if (n == null) {
      n = 100000;
    }
    for (max = _i = 1; _i < 20; max = ++_i) {
      hash = {};
      for (i = _j = 0; 0 <= n ? _j < n : _j > n; i = 0 <= n ? ++_j : --_j) {
        key = rand_range(0, max);
        if (hash[key] == null) {
          hash[key] = 0;
        }
        hash[key]++;
      }
      kv_list = [];
      for (k in hash) {
        v = hash[k];
        kv_list.push({
          k: k,
          v: v
        });
      }
      kv_list.sort(function(a, b) {
        return a.v - b.v;
      });
      kv_list = kv_list.map(function(_arg) {
        var k, v;
        k = _arg.k, v = _arg.v;
        return {
          k: k,
          v: (1 - v / (n / (max + 1))).toFixed(2)
        };
      });
      console.table(kv_list);
    }
  };

}).call(this);
