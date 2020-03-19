(function() {
  var com_name, conf;

  com_name = "Tab_bar";

  conf = React.createClass(CKR.react_key_map(com_name, {
    render: function() {
      return div({
        "class": "tab"
      }, (function(_this) {
        return function() {
          var btn_style, style;
          style = _this.props.center ? {
            margin: '0 auto'
          } : {};
          btn_style = _this.props.center ? {} : {
            float: 'left'
          };
          return div({
            style: style
          }, function() {
            var k, v, _ref, _results;
            _ref = _this.props.hash || {};
            _results = [];
            for (k in _ref) {
              v = _ref[k];
              _results.push((function(k, v) {
                return Button({
                  "class": _this.props.value === k ? 'active' : '',
                  label: v,
                  on_click: function() {
                    return _this.props.on_change(k);
                  },
                  style: btn_style
                });
              })(k, v));
            }
            return _results;
          });
        };
      })(this));
    }
  }));

  define_com("Tab_bar", conf);

}).call(this);
