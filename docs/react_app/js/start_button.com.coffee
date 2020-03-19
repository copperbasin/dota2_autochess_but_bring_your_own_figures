(function() {
  var com_name, conf;

  com_name = "Start_button";

  conf = React.createClass(CKR.react_key_map(com_name, {
    render: function() {
      return Button(this.props, {
        "class": "start_button"
      });
    }
  }));

  define_com("Start_button", conf);

}).call(this);
