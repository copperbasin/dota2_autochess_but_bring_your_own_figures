(function() {
  var com_name, conf;

  com_name = "Scene_demo_battle";

  conf = React.createClass(CKR.react_key_map(com_name, {
    mount: function() {
      bg_change("img/battle_bg.jpg");
      this.start_state = new emulator.State;
      this.start_state.unit_list.push(battle_unit_create({
        grid_x: 0,
        grid_y: 7,
        type: "tusk",
        side: 0
      }));
      this.start_state.unit_list.push(battle_unit_create({
        grid_x: 0,
        grid_y: 0,
        type: "tusk",
        side: 1
      }));
    },
    render: function() {
      return div({
        "class": "center pad_top"
      }, (function(_this) {
        return function() {
          return div({
            "class": "background_pad"
          }, function() {
            return Board_battle({
              start_state: _this.start_state
            });
          });
        };
      })(this));
    }
  }));

  define_com("Scene_demo_battle", conf);

}).call(this);
