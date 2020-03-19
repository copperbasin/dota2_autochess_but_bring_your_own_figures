(function() {
  var com_name, conf;

  com_name = "Countdown";

  conf = React.createClass(CKR.react_key_map(com_name, {
    interval: null,
    start_ts: 0,
    mount: function() {
      this.start_ts = this.props.start_ts || Date.now();
      return this.interval = setInterval((function(_this) {
        return function() {
          return _this.force_update();
        };
      })(this), 100);
    },
    unmount: function() {
      return clearInterval(this.interval);
    },
    render: function() {
      var left_ts;
      left_ts = Math.max(0, this.props.ts - (Date.now() - this.start_ts));
      return span(Math.floor(left_ts / 1000));
    }
  }));

  define_com("Countdown", conf);

}).call(this);
