(function() {
  var com_name, conf;

  com_name = "App";

  conf = React.createClass(CKR.react_key_map(com_name, {
    state: {
      id: "bg1",
      last_url: "",
      router: localStorage.router_start || "main",
      bg1: {
        opacity: 0
      },
      bg2: {
        opacity: 0
      }
    },
    mount: function() {
      window.bg_change = (function(_this) {
        return function(new_url) {
          if (_this.state.last_url === new_url) {
            return;
          }
          return call_later(function() {
            var id, state;
            id = _this.state.id;
            state = {
              last_url: new_url
            };
            state[id] = {
              background: "url(" + (JSON.stringify(new_url)) + ")",
              opacity: 0.65
            };
            id = id === "bg1" ? "bg2" : "bg1";
            state[id] = {
              background: _this.state[id].background,
              opacity: 0
            };
            state.id = id;
            _this.set_state(state);
          });
        };
      })(this);
      return window.router_set = (function(_this) {
        return function(router) {
          return _this.set_state({
            router: router
          });
        };
      })(this);
    },
    render: function() {
      return div({
        id: "wrap"
      }, (function(_this) {
        return function() {
          div({
            id: "bg1",
            style: _this.state.bg1
          });
          div({
            id: "bg2",
            style: _this.state.bg2
          });
          switch (_this.state.router) {
            case "main":
              return Scene_play_with_bot({});
          }
        };
      })(this));
    }
  }));

  define_com("App", conf);

}).call(this);
