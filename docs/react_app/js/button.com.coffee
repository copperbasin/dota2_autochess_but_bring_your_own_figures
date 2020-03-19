(function() {
  var com_name, conf;

  com_name = "Button";

  conf = React.createClass(CKR.react_key_map(com_name, {
    render: function() {
      return button({
        "class": this.props["class"],
        style: this.props.style,
        disabled: this.props.disabled,
        on_click: (function(_this) {
          return function() {
            var _base;
            return typeof (_base = _this.props).on_click === "function" ? _base.on_click() : void 0;
          };
        })(this)
      }, this.props.label);
    }
  }));

  define_com("Button", conf);

}).call(this);
