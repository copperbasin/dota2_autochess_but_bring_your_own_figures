var Websocket_wrap, client_int, deep_clone, define_com, define_tag, image_uid, protocol, request_div, server_int, timer, update_style, url_parser, websocket_list, __, _base, _base1, _base2, _base3, _base4, _base5, _react_attr_map, _react_key_map,
  __slice = [].slice;

if (window.console == null) {
  window.console = {};
}

if ((_base = window.console).log == null) {
  _base.log = function() {};
}

if ((_base1 = window.console.log).bind == null) {
  _base1.bind = function() {
    return function() {};
  };
}

if ((_base2 = window.console).error == null) {
  _base2.error = function() {};
}

if ((_base3 = window.console.error).bind == null) {
  _base3.bind = function() {
    return function() {};
  };
}

if (Date.now == null) {
  Date.now = function() {
    return new Date().getTime();
  };
}

if ((_base4 = String.prototype).trim == null) {
  _base4.trim = function() {
    return this.replace(/^[\u0009\u000A\u000B\u000C\u000D\u0020\u00A0\u1680\u180E\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200A\u202F\u205F\u3000\u2028\u2029\uFEFF\xA0]+|[\u0009\u000A\u000B\u000C\u000D\u0020\u00A0\u1680\u180E\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200A\u202F\u205F\u3000\u2028\u2029\uFEFF\xA0]+$/g, '');
  };
}

if (Object.keys == null) {
  Object.keys = function(t) {
    var k, ret;
    ret = [];
    for (k in t) {
      ret.push(k);
    }
    return ret;
  };
}

if ((_base5 = Array.prototype).indexOf == null) {
  _base5.indexOf = function(t) {
    var k, v, _i, _len;
    for (k = _i = 0, _len = this.length; _i < _len; k = ++_i) {
      v = this[k];
      if (v === t) {
        return k;
      }
    }
    return -1;
  };
}

String.prototype.to_s = function() {
  return this.toString();
};

window.p = console.log.bind(console);

window.puts = console.log.bind(console);

window.pe = console.error.bind(console);

window.perr = console.error.bind(console);

window.print = console.log.bind(console);

window.println = console.log.bind(console);

Array.prototype.to_s = Array.prototype.toString;

Number.prototype.to_s = Number.prototype.toString;

String.prototype.reverse = function() {
  return this.split('').reverse().join('');
};

String.prototype.capitalize = function() {
  return this.substr(0, 1).toUpperCase() + this.substr(1);
};

String.prototype.center = function(length, char) {
  var append_end, append_length, append_start;
  if (char == null) {
    char = ' ';
  }
  append_length = Math.max(0, length - this.length) / 2;
  append_start = new Array(Math.ceil(append_length) + 1).join(char);
  append_end = new Array(Math.floor(append_length) + 1).join(char);
  return append_start + this + append_end;
};

String.prototype.ljust = function(length, char) {
  var append;
  if (char == null) {
    char = ' ';
  }
  append = new Array(Math.max(0, length - this.length) + 1).join(char);
  append = append.substr(0, length - this.length);
  return this + append;
};

String.prototype.rjust = function(length, char) {
  var append;
  if (char == null) {
    char = ' ';
  }
  append = new Array(Math.max(0, length - this.length) + 1).join(char);
  append = append.substr(0, length - this.length);
  return append + this;
};

String.prototype.repeat = function(count) {
  var res;
  res = new Array(count + 1);
  return res.join(this);
};

Number.prototype.ljust = function(length, char) {
  if (char == null) {
    char = ' ';
  }
  return this.toString().ljust(length, char);
};

Number.prototype.rjust = function(length, char) {
  if (char == null) {
    char = ' ';
  }
  return this.toString().rjust(length, char);
};

Number.prototype.center = function(length, char) {
  if (char == null) {
    char = ' ';
  }
  return this.toString().center(length, char);
};

Number.prototype.repeat = function(count) {
  return this.toString().repeat(count);
};

timer = null;

window.tic = function() {
  return timer = new Date;
};

window.toc = function() {
  return (new Date - timer) / 1000;
};

window.ptoc = function() {
  return console.log(toc().toFixed(3) + ' s');
};

window.call_later = function(cb) {
  return setTimeout(cb, 0);
};

if (window.requestAnimationFrame == null) {
  window.requestAnimationFrame = call_later;
}

window.once_interval = function(timer, cb, interval) {
  if (interval == null) {
    interval = 100;
  }
  if (!timer) {
    return setTimeout(cb, interval);
  }
  return timer;
};

window.call_later_replace = function(timer, cb, timeout) {
  if (timeout == null) {
    timeout = 0;
  }
  if (timer) {
    clearTimeout(timer);
  }
  return setTimeout(cb, timeout);
};

Array.prototype.has = function(t) {
  return -1 !== this.indexOf(t);
};

Array.prototype.upush = function(t) {
  if (-1 === this.indexOf(t)) {
    this.push(t);
  }
};

Array.prototype.clone = Array.prototype.slice;

Array.prototype.clear = function() {
  return this.length = 0;
};

Array.prototype.idx = Array.prototype.indexOf;

Array.prototype.remove_idx = function(idx) {
  if (idx < 0 || idx >= this.length) {
    return this;
  }
  this.splice(idx, 1);
  return this;
};

Array.prototype.remove = function(t) {
  this.remove_idx(this.idx(t));
  return this;
};

Array.prototype.last = Array.prototype.end = function() {
  return this[this.length - 1];
};

Array.prototype.insert_after = function(idx, t) {
  this.splice(idx + 1, 0, t);
  return t;
};

Array.prototype.append = function(list) {
  var v, _i, _len;
  for (_i = 0, _len = list.length; _i < _len; _i++) {
    v = list[_i];
    this.push(v);
  }
  return this;
};

Array.prototype.uappend = function(list) {
  var v, _i, _len;
  for (_i = 0, _len = list.length; _i < _len; _i++) {
    v = list[_i];
    this.upush(v);
  }
  return this;
};

window.h_count = window.count_h = window.hash_count = window.count_hash = function(t) {
  var k, ret;
  ret = 0;
  for (k in t) {
    ret++;
  }
  return ret;
};

window.count = function(t) {
  var k, ret;
  if (t instanceof Array) {
    return t.length;
  }
  ret = 0;
  for (k in t) {
    ret++;
  }
  return ret;
};

__ = {};

__.isObject = function(obj) {
  return obj === Object(obj);
};

__.isArray = Array.isArray || function(obj) {
  return obj instanceof Array;
};

__.copy_obj = function(obj) {
  var k, ret, v;
  ret = {};
  for (k in obj) {
    v = obj[k];
    ret[k] = v;
  }
  return ret;
};

__.clone = function(obj) {
  if (!__.isObject(obj)) {
    return obj;
  }
  if (__.isArray(obj)) {
    return obj.slice();
  } else {
    return __.copy_obj(obj);
  }
};

window.clone = __.clone;

window.deep_clone = deep_clone = function(obj) {
  var k, res, v, _i, _len;
  if (obj instanceof Array) {
    res = [];
    for (_i = 0, _len = obj.length; _i < _len; _i++) {
      v = obj[_i];
      res.push(deep_clone(v));
    }
    return res;
  }
  if (_.isObject(obj)) {
    res = {};
    for (k in obj) {
      v = obj[k];
      res[k] = deep_clone(v);
    }
    return res;
  }
  return obj;
};

window.obj_set = function(dst, src) {
  var k, v;
  for (k in src) {
    v = src[k];
    dst[k] = v;
  }
  return dst;
};

window.obj_clear = function(t) {
  var k, v;
  for (k in t) {
    v = t[k];
    delete t[k];
  }
  return t;
};

Array.prototype.set = function(t) {
  var k, v, _i, _len;
  this.length = t.length;
  for (k = _i = 0, _len = t.length; _i < _len; k = ++_i) {
    v = t[k];
    this[k] = v;
  }
  return this;
};

window.arr_set = function(dst, src) {
  var k, v, _i, _len;
  dst.length = src.length;
  for (k = _i = 0, _len = src.length; _i < _len; k = ++_i) {
    v = src[k];
    dst[k] = v;
  }
  return dst;
};

window.array_merge = window.arr_merge = function(a, b) {
  return a.concat(b);
};

window.obj_merge = function() {
  var a, k, ret, v, _i, _len;
  ret = {};
  for (_i = 0, _len = arguments.length; _i < _len; _i++) {
    a = arguments[_i];
    for (k in a) {
      v = a[k];
      ret[k] = v;
    }
  }
  return ret;
};

RegExp.escape = function(text) {
  return text.replace(/([-\/[\]{}()*+?.,\\^$|#\s])/g, "\\$1");
};

if (window.localStorage != null) {
  window.pref_storage_get = function(k) {
    return JSON.parse(localStorage.getItem(k));
  };
  window.pref_storage_set = function(k, v) {
    return localStorage.setItem(k, JSON.stringify(v));
  };
} else {
  window.pref_storage_get = function(k) {
    return JSON.parse($.cookie(k));
  };
  window.pref_storage_set = function(k, v) {
    return $.cookie(k, JSON.stringify(v));
  };
}

if (window.devicePixelRatio == null) {
  window.devicePixelRatio = 1;
}

puts("reload date " + (new Date));

window.event_mixin_constructor = function(_t) {
  _t.$event_hash = {};
  return _t.on("delete", function() {
    var k, v, _ref;
    _ref = _t.$event_hash;
    for (k in _ref) {
      v = _ref[k];
      if (k === "delete") {
        continue;
      }
      _t.$event_hash[k].clear();
    }
  });
};

window.event_mixin = function(_t) {
  var _base6;
  _t.prototype.$delete_state = false;
  _t.prototype.$event_hash = {};
  if ((_base6 = _t.prototype)["delete"] == null) {
    _base6["delete"] = function() {
      this.dispatch("delete");
    };
  }
  _t.prototype.once = function(event_name, cb) {
    var need_remove;
    need_remove = (function(_this) {
      return function() {
        _this.off(event_name, need_remove);
        cb();
      };
    })(this);
    this.on(event_name, need_remove);
  };
  _t.prototype.ensure_on = function(event_name, cb) {
    var v, _base7, _i, _len;
    if (event_name instanceof Array) {
      for (_i = 0, _len = event_name.length; _i < _len; _i++) {
        v = event_name[_i];
        this.ensure_on(v, cb);
      }
      return this;
    }
    if ((_base7 = this.$event_hash)[event_name] == null) {
      _base7[event_name] = [];
    }
    if (!this.$event_hash[event_name].has(cb)) {
      this.$event_hash[event_name].push(cb);
    }
    return this;
  };
  _t.prototype.on = function(event_name, cb) {
    var v, _base7, _i, _len;
    if (event_name instanceof Array) {
      for (_i = 0, _len = event_name.length; _i < _len; _i++) {
        v = event_name[_i];
        this.on(v, cb);
      }
      return this;
    }
    if ((_base7 = this.$event_hash)[event_name] == null) {
      _base7[event_name] = [];
    }
    this.$event_hash[event_name].push(cb);
    return this;
  };
  _t.prototype.off = function(event_name, cb) {
    var e, idx, list, v, _i, _len;
    this.$delete_state = true;
    if (event_name instanceof Array) {
      for (_i = 0, _len = event_name.length; _i < _len; _i++) {
        v = event_name[_i];
        this.off(v, cb);
      }
      return;
    }
    list = this.$event_hash[event_name];
    if (!list) {
      puts("probably lose some important because no event_name '" + event_name + "' found");
      e = new Error;
      puts(e.stack);
      return;
    }
    idx = list.idx(cb);
    if (idx >= 0) {
      list[idx] = null;
    }
  };
  return _t.prototype.dispatch = function(event_name, hash) {
    var cb, e, idx, list, _i, _len, _ref;
    if (hash == null) {
      hash = {};
    }
    if (this.$event_hash[event_name]) {
      _ref = list = this.$event_hash[event_name];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        cb = _ref[_i];
        if (cb === null) {
          continue;
        }
        try {
          cb.call(this, hash);
        } catch (_error) {
          e = _error;
          perr(e);
        }
      }
      if (this.$delete_state) {
        while (0 < (idx = list.idx(null))) {
          list.remove_idx(idx);
        }
        this.$delete_state = false;
      }
    }
  };
};

window.Event_mixin = (function() {
  event_mixin(Event_mixin);

  function Event_mixin() {
    event_mixin_constructor(this);
  }

  return Event_mixin;

})();

window.event_manager = new window.Event_mixin();

websocket_list = [];

if (!window.WebSocket) {
  request_div = document.createElement('div');
  document.body.appendChild(request_div);
  client_int = 1000;
  server_int = 15000;
  server_int = 5000;
  window.__ws_cb = function(uid, msg_uid, data) {
    var child, seek, ws, _i, _j, _len, _len1, _ref;
    for (_i = 0, _len = websocket_list.length; _i < _len; _i++) {
      ws = websocket_list[_i];
      if (ws.uid === uid) {
        if (data != null) {
          ws.dispatch("data", data);
        }
        ws.active_script_count--;
        break;
      }
    }
    if ((ws != null ? ws.active_script_count : void 0) < 2) {
      ws.send(null);
    }
    seek = "?u=" + uid + "&mu=" + msg_uid + "&";
    _ref = request_div.children;
    for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
      child = _ref[_j];
      if (-1 !== child.src.indexOf(seek)) {
        request_div.removeChild(child);
        child.onerror = null;
        break;
      }
    }
  };
  setInterval(function() {
    var ws, _i, _len;
    for (_i = 0, _len = websocket_list.length; _i < _len; _i++) {
      ws = websocket_list[_i];
      if (ws.active_script_count < 2) {
        ws.send(null);
      }
    }
  }, client_int);
}

Websocket_wrap = (function() {
  Websocket_wrap.uid = 0;

  Websocket_wrap.prototype.uid = 0;

  Websocket_wrap.prototype.msg_uid = 0;

  Websocket_wrap.prototype.websocket = null;

  Websocket_wrap.prototype.timeout_min = 100;

  Websocket_wrap.prototype.timeout_max = 5 * 1000;

  Websocket_wrap.prototype.timeout_mult = 1.5;

  Websocket_wrap.prototype.timeout = 100;

  Websocket_wrap.prototype.url = '';

  Websocket_wrap.prototype.reconnect_timer = null;

  Websocket_wrap.prototype.queue = [];

  Websocket_wrap.prototype.fallback_mode = false;

  Websocket_wrap.prototype.active_script_count = 0;

  event_mixin(Websocket_wrap);

  function Websocket_wrap(url) {
    this.url = url;
    event_mixin_constructor(this);
    this.uid = Websocket_wrap.uid++;
    this.queue = [];
    this.timeout = this.timeout_min;
    this.ws_init();
    websocket_list.push(this);
  }

  Websocket_wrap.prototype["delete"] = function() {
    return this.close();
  };

  Websocket_wrap.prototype.close = function() {
    clearTimeout(this.reconnect_timer);
    this.websocket.onopen = function() {};
    this.websocket.onclose = function() {};
    this.websocket.onclose = function() {};
    this.websocket.close();
    return websocket_list.remove(this);
  };

  Websocket_wrap.prototype.ws_reconnect = function() {
    if (this.reconnect_timer) {
      return;
    }
    this.reconnect_timer = setTimeout((function(_this) {
      return function() {
        _this.ws_init();
      };
    })(this), this.timeout);
  };

  Websocket_wrap.prototype.ws_init = function() {
    if (!window.WebSocket) {
      this.fallback_mode = true;
      this.uid = "" + Math.random();
      this.url = this.url.replace("ws:", "http:");
      this.url = this.url.replace("wss:", "https:");
      this.url += "/ws";
      this.url = this.url.replace(/\/\/ws$/, "/ws");
      return;
    }
    this.reconnect_timer = null;
    this.websocket = new WebSocket(this.url);
    this.timeout = Math.min(this.timeout_max, Math.round(this.timeout * this.timeout_mult));
    this.websocket.onopen = (function(_this) {
      return function() {
        var data, q, _i, _len;
        _this.dispatch("reconnect");
        _this.timeout = _this.timeout_min;
        q = _this.queue.clone();
        _this.queue.clear();
        for (_i = 0, _len = q.length; _i < _len; _i++) {
          data = q[_i];
          _this.send(data);
        }
      };
    })(this);
    this.websocket.onerror = (function(_this) {
      return function(e) {
        puts("Websocket error.");
        perr(e);
        _this.ws_reconnect();
      };
    })(this);
    this.websocket.onclose = (function(_this) {
      return function() {
        puts("Websocket disconnect. Restarting in " + _this.timeout);
        _this.ws_reconnect();
      };
    })(this);
    this.websocket.onmessage = (function(_this) {
      return function(message) {
        var data;
        data = JSON.parse(message.data);
        _this.dispatch("data", data);
      };
    })(this);
  };

  Websocket_wrap.prototype.send = function(data) {
    var script;
    if (this.fallback_mode) {
      script = document.createElement('script');
      script.src = "" + this.url + "?u=" + this.uid + "&mu=" + (this.msg_uid++) + "&i=" + server_int + "&d=" + (encodeURIComponent(JSON.stringify(data)));
      script.onerror = (function(_this) {
        return function() {
          request_div.removeChild(script);
          script.onerror = null;
          _this.active_script_count--;
          _this.send(data);
        };
      })(this);
      setTimeout((function(_this) {
        return function() {
          if (script.parentElement) {
            script.onerror();
          }
        };
      })(this), server_int * 3);
      request_div.appendChild(script);
      this.active_script_count++;
      return;
    }
    if (this.websocket.readyState !== this.websocket.OPEN) {
      this.queue.push(data);
    } else {
      this.websocket.send(JSON.stringify(data));
    }
  };

  Websocket_wrap.prototype.write = Websocket_wrap.prototype.send;

  return Websocket_wrap;

})();

window.Websocket_wrap = Websocket_wrap;

window.autoreload = true;

protocol = location.protocol === "http:" ? "ws:" : "wss:";

image_uid = 0;

if (window.config_hot_reload) {
  update_style = function() {
    var e, k, style_list, style_tag, v, _ref;
    style_list = [];
    _ref = window.framework_style_hash;
    for (k in _ref) {
      v = _ref[k];
      style_list.push(v);
    }
    style_tag = document.getElementsByTagName('style')[0];
    try {
      style_tag.innerHTML = style_list.join('');
    } catch (_error) {
      e = _error;
      return false;
    }
    return true;
  };
  update_style();
  window.hot_reload_event_mixin = new Event_mixin;
  url_parser = function(url) {
    var parser;
    parser = document.createElement('a');
    parser.href = url;
    return parser;
  };
  window.hot_reload_websocket = new window.Websocket_wrap("" + protocol + "//" + location.hostname + ":" + config_hot_reload_port + location.pathname);
  window.hot_reload_websocket.on("data", window.hot_reload_handler = function(data) {
    var img, new_script, src, url, _i, _len, _ref;
    if (!autoreload) {
      return;
    }
    if (data.event === 'add' && data["switch"] !== "hotreload_image") {
      location.reload();
    }
    switch (data["switch"]) {
      case "hotreload_full":
        if (data.start_ts === start_ts) {
          return;
        }
        hot_reload_event_mixin.dispatch("hotreload_full");
        location.reload();
        break;
      case "hotreload_js":
        if (data.start_ts === start_ts) {
          return;
        }
        if (!file_list.has(data.path)) {
          return;
        }
        if (/\.com\.coffee$/.test(data.path)) {
          hot_reload_event_mixin.dispatch("hotreload_com");
          new_script = document.createElement("script");
          window.hotreplace = true;
          new_script.onload = (function(_this) {
            return function() {
              window.hotreplace = false;
              return typeof window.bootstrap === "function" ? window.bootstrap() : void 0;
            };
          })(this);
          new_script.src = data.path;
          document.body.appendChild(new_script);
        } else {
          hot_reload_event_mixin.dispatch("hotreload_full");
          location.reload();
        }
        break;
      case "hotreload_style":
        window.framework_style_hash[data.path] = data.content;
        if (!update_style()) {
          location.reload();
        }
        break;
      case "hotreload_template":
        window.framework_template_hash[data.path] = window.template_preprocess(data.content);
        hot_reload_event_mixin.dispatch("hotreload_template", data.path);
        break;
      case "hotreload_image":
        _ref = document.getElementsByTagName('img');
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          img = _ref[_i];
          url = url_parser(img.src);
          src = url.pathname;
          src = src.replace(/^\//, '');
          data.path = data.path.replace(/^\//, '');
          if (src === data.path) {
            if (url.protocol) {
              img.src = "" + url.protocol + "//" + url.host + url.pathname + "?cache_killer=" + (image_uid++);
            } else {
              img.src = "" + url.pathname + "?cache_killer=" + (image_uid++);
            }
          }
        }
    }
  });
}

_react_key_map = {
  mount: 'componentWillMount',
  mount_done: 'componentDidMount',
  unmount: 'componentWillUnmount',
  unmount_done: 'componentDidUnmount',
  props_change: 'componentWillReceiveProps'
};

_react_attr_map = {
  "class": 'className',
  on_change: 'onChange',
  on_click: 'onClick',
  on_wheel: 'onWheel',
  on_mouse_move: 'onMouseMove',
  on_mouse_down: 'onMouseDown',
  on_mouse_out: 'onMouseOut',
  on_move_over: 'onMouseOver',
  on_hover: 'onMouseOver'
};

window.CKR = {
  __node_buffer: [],
  prop: function(t) {
    var lookup_list, _i, _len, _ref;
    _ref = CKR.__node_buffer;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      lookup_list = _ref[_i];
      lookup_list.remove(t);
    }
    return t;
  },
  list: function(t) {
    return CKR.__node_buffer.uappend(t);
  },
  item: function() {
    var arg, fn;
    fn = arguments[0], arg = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    return CKR.__node_buffer.last().upush(fn.apply(null, arg));
  },
  react_key_map: function(name, t) {
    var k, k2, old_state, ret, v;
    ret = {
      name: name,
      displayName: name
    };
    if (t.state) {
      if (typeof t.state !== 'function') {
        old_state = t.state;
        t.state = function() {
          return clone(old_state);
        };
      }
      t.getInitialState = t.state;
      delete t.state;
    }
    for (k in t) {
      v = t[k];
      if (k2 = _react_key_map[k]) {
        ret[k2] = v;
      }
      ret[k] = v;
    }
    ret.set_state = function() {
      return this.setState.apply(this, arguments);
    };
    ret.force_update = function() {
      return this.forceUpdate.apply(this, arguments);
    };
    return ret;
  }
};

define_tag = function(name) {
  window[name] = function() {
    var arg, attrs, buf, children, k, last, ret, t, v, _i, _j, _k, _len, _len1, _len2, _ref;
    children = [];
    attrs = {};
    for (_i = 0, _len = arguments.length; _i < _len; _i++) {
      arg = arguments[_i];
      if (arg == null) {
        continue;
      }
      if (arg.$$typeof != null) {
        children.push(arg);
      } else if (Array.isArray(arg)) {
        children.uappend(arg);
      } else if (typeof arg === 'object') {
        for (k in arg) {
          v = arg[k];
          attrs[_react_attr_map[k] || k] = v;
        }
      } else if (typeof arg === 'function') {
        CKR.__node_buffer.push([]);
        t = arg();
        children.uappend(CKR.__node_buffer.pop());
        if (Array.isArray(t)) {
          children.uappend(t);
        } else {
          children.upush(t);
        }
      } else if (typeof arg === 'string') {
        children.push(arg);
      } else if (typeof arg === 'number') {
        children.push(arg.toString());
      }
    }
    ret = children.length ? React.createElement.apply(React, [name, attrs].concat(__slice.call(children))) : React.createElement(name, attrs);
    if (last = CKR.__node_buffer.last()) {
      _ref = CKR.__node_buffer;
      for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
        buf = _ref[_j];
        buf.remove(ret);
        for (_k = 0, _len2 = children.length; _k < _len2; _k++) {
          v = children[_k];
          buf.remove(v);
        }
      }
      last.push(ret);
    }
    return ret;
  };
};

define_com = function(name, react_class) {
  if (window[name] != null) {
    if (!window.hotreplace) {
      perr('WARNING something bad is happening. You trying to rewrite already defined window property ' + name + '. It can break app');
    }
  }
  window[name] = function() {
    var arg, attrs, buf, children, k, last, ret, t, v, _i, _j, _k, _len, _len1, _len2, _ref;
    children = [];
    attrs = {};
    for (_i = 0, _len = arguments.length; _i < _len; _i++) {
      arg = arguments[_i];
      if (arg == null) {
        continue;
      }
      if (arg.$$typeof != null) {
        children.push(arg);
      } else if (Array.isArray(arg)) {
        children.uappend(arg);
      } else if (typeof arg === 'object') {
        for (k in arg) {
          v = arg[k];
          attrs[k] = v;
        }
      } else if (typeof arg === 'function') {
        CKR.__node_buffer.push([]);
        t = arg();
        children.uappend(CKR.__node_buffer.pop());
        if (Array.isArray(t)) {
          children.uappend(t);
        } else {
          children.upush(t);
        }
      } else if (typeof arg === 'string') {
        children.push(arg);
      } else if (typeof arg === 'number') {
        children.push(arg.toString());
      }
    }
    ret = children.length ? React.createElement.apply(React, [react_class, attrs].concat(__slice.call(children))) : React.createElement(react_class, attrs);
    if (last = CKR.__node_buffer.last()) {
      _ref = CKR.__node_buffer;
      for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
        buf = _ref[_j];
        buf.remove(ret);
        for (_k = 0, _len2 = children.length; _k < _len2; _k++) {
          v = children[_k];
          buf.remove(v);
        }
      }
      last.push(ret);
    }
    return ret;
  };
};

define_tag("a");

define_tag("address");

define_tag("applet");

define_tag("area");

define_tag("article");

define_tag("aside");

define_tag("b");

define_tag("base");

define_tag("basefont");

define_tag("bgsound");

define_tag("big");

define_tag("blockquote");

define_tag("body");

define_tag("br");

define_tag("button");

define_tag("caption");

define_tag("center");

define_tag("code");

define_tag("col");

define_tag("colgroup");

define_tag("canvas");

define_tag("dd");

define_tag("desc");

define_tag("details");

define_tag("dialog");

define_tag("dir");

define_tag("div");

define_tag("dl");

define_tag("dt");

define_tag("em");

define_tag("embed");

define_tag("fieldset");

define_tag("figcaption");

define_tag("figure");

define_tag("font");

define_tag("footer");

define_tag("foreignObject");

define_tag("form");

define_tag("frame");

define_tag("frameset");

define_tag("h1");

define_tag("h2");

define_tag("h3");

define_tag("h4");

define_tag("h5");

define_tag("h6");

define_tag("head");

define_tag("header");

define_tag("hgroup");

define_tag("hr");

define_tag("html");

define_tag("i");

define_tag("img");

define_tag("image");

define_tag("input");

define_tag("iframe");

define_tag("keygen");

define_tag("label");

define_tag("li");

define_tag("link");

define_tag("listing");

define_tag("main");

define_tag("malignmark");

define_tag("marquee");

define_tag("math");

define_tag("menu");

define_tag("menuitem");

define_tag("meta");

define_tag("mglyph");

define_tag("mi");

define_tag("mo");

define_tag("mn");

define_tag("ms");

define_tag("mtext");

define_tag("nav");

define_tag("nobr");

define_tag("noframes");

define_tag("noembed");

define_tag("noscript");

define_tag("object");

define_tag("ol");

define_tag("optgroup");

define_tag("option");

define_tag("p");

define_tag("param");

define_tag("plaintext");

define_tag("pre");

define_tag("rb");

define_tag("rp");

define_tag("rt");

define_tag("rtc");

define_tag("ruby");

define_tag("s");

define_tag("script");

define_tag("section");

define_tag("select");

define_tag("source");

define_tag("small");

define_tag("span");

define_tag("strike");

define_tag("strong");

define_tag("style");

define_tag("sub");

define_tag("summary");

define_tag("sup");

define_tag("table");

define_tag("tbody");

define_tag("template");

define_tag("textarea");

define_tag("tfoot");

define_tag("td");

define_tag("th");

define_tag("thead");

define_tag("title");

define_tag("tr");

define_tag("track");

define_tag("tt");

define_tag("u");

define_tag("ul");

define_tag("svg");

define_tag("var");

define_tag("video");

define_tag("wbr");

define_tag("xmp");

define_tag("progress");
