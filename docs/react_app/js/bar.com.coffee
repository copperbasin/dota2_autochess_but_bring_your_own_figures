(function() {
  var com_name, conf;

  com_name = "Leaderboard_bar";

  conf = React.createClass(CKR.react_key_map(com_name, {
    render: function() {
      var color, max, value, _ref;
      _ref = this.props, value = _ref.value, max = _ref.max, color = _ref.color;
      if (color == null) {
        color = "#000";
      }
      progress({
        value: value,
        max: max
      }, "" + value);
      return div({
        "class": "progress"
      }, (function(_this) {
        return function() {
          div({
            "class": "progress_fill",
            style: {
              width: "" + (Math.round(100 * value / max)) + "%",
              background: color
            }
          });
          return div({
            "class": "progress_label"
          }, "" + value);
        };
      })(this));
    }
  }));

  define_com("Leaderboard_bar", conf);

}).call(this);
