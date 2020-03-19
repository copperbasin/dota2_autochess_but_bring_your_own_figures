(function() {
  var com_name, conf;

  com_name = "Back_button";

  conf = React.createClass(CKR.react_key_map(com_name, {
    render: function() {
      return img({
        "class": "back_button",
        src: "img/back.png"
      }, this.props);
    }
  }));

  define_com("Back_button", conf);

}).call(this);
