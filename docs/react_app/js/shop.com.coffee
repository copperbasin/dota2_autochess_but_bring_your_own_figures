(function() {
  var com_name, conf;

  com_name = "Board_shop";

  conf = React.createClass(CKR.react_key_map(com_name, {
    controller: null,
    mount: function() {
      this.controller = new Shop_controller;
      this.controller.state = this.props.state;
      this.controller.on_change = this.props.on_change;
      this.controller.on_board_change_fn = this.props.on_board_change;
    },
    render: function() {
      this.controller.props_update(this.props);
      return div({
        style: {
          textAlign: "left",
          width: shop_cell_size_px * 5 + 2,
          height: battle_board_cell_size_px * 10
        }
      }, (function(_this) {
        return function() {
          return Canvas_multi({
            layer_list: ["bg", "fg"],
            canvas_cb: function(canvas_hash) {
              return _this.controller.canvas_controller(canvas_hash);
            },
            gui: _this.controller,
            ref_textarea: function($textarea) {
              _this.controller.$textarea = $textarea;
              return _this.controller.init();
            }
          });
        };
      })(this));
    }
  }));

  define_com("Board_shop", conf);

}).call(this);
