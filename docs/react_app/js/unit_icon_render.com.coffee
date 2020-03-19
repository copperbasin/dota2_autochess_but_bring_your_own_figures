(function() {
  var com_name, conf;

  com_name = "Unit_icon_render";

  conf = React.createClass(CKR.react_key_map(com_name, {
    render: function() {
      var style, unit;
      unit = this.props.unit;
      if (unit) {
        style = {};
        if (this.props.s) {
          style = {
            width: 20,
            height: 20
          };
        }
        if (this.props.l) {
          style = {
            width: 60,
            height: 60
          };
        }
        if (this.props.xl) {
          style = {
            width: 80,
            height: 80
          };
        }
        if (this.props.xxl) {
          style = {
            width: 100,
            height: 100
          };
        }
        return img({
          src: "img/dota/" + unit.type + "_icon.png",
          style: style
        });
      } else {
        return img((function(_this) {
          return function() {};
        })(this));
      }
    }
  }));

  define_com("Unit_icon_render", conf);

}).call(this);
