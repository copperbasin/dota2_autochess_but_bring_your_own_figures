(function() {
  var com_name, conf;

  com_name = "Checkbox";

  conf = React.createClass(CKR.react_key_map(com_name, {
    render: function() {
      return div((function(_this) {
        return function() {
          input({
            type: "checkbox",
            checked: _this.props.value || false,
            on_change: _this.on_change,
            style: _this.props.style || {}
          });
          return _this.props.children || _this.props.label;
        };
      })(this));
    },
    on_change: function(event) {
      var value;
      value = !!event.target.checked;
      this.props.on_change(value);
    }
  }));

  define_com("Checkbox", conf);

}).call(this);
