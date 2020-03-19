(function() {
  var com_name, conf;

  com_name = "Number_input";

  conf = React.createClass(CKR.react_key_map(com_name, {
    render: function() {
      return div((function(_this) {
        return function() {
          return input({
            type: "number",
            value: _this.text,
            on_change: _this.on_change,
            placeholder: _this.props.placeholder || '',
            pattern: "-?[0-9]*([\.,][0-9]*)?",
            step: _this.props.step || 1,
            style: _this.props.style || {}
          });
        };
      })(this));
    },
    props_change: function(props) {
      if (props.value === this.props.value) {
        return;
      }
      if (props.value === parseFloat(this.text)) {
        return;
      }
      return this.set_text(props);
    },
    set_text: function(props) {
      if (props.value != null) {
        if (isNaN(props.value)) {
          this.text = '';
          return;
        }
        this.text = props.value.toString();
      }
    },
    mount: function() {
      this.set_text(this.props);
      this.force_update();
    },
    on_change: function(event) {
      var num_value, value, _base;
      value = event.target.value;
      this.text = value;
      this.force_update();
      num_value = parseFloat(value);
      if (this.props.can_empty && value === '') {
        this.props.on_change(num_value);
        return;
      }
      if (isNaN(num_value)) {
        return;
      }
      if (typeof (_base = this.props).on_change === "function") {
        _base.on_change(num_value);
      }
    }
  }));

  define_com("Number_input", conf);

}).call(this);
