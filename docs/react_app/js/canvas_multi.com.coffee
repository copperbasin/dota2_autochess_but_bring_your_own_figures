(function() {
  var com_name, conf;

  com_name = "Canvas_multi";

  conf = React.createClass(CKR.react_key_map(com_name, {
    mounted: false,
    mount_done: function() {
      var draw, _base;
      this.mounted = true;
      draw = (function(_this) {
        return function() {
          var canvas_hash, name, _base, _i, _len, _ref;
          if (!_this.mounted) {
            return;
          }
          _this.canvas_actualize();
          requestAnimationFrame(draw);
          canvas_hash = {};
          _ref = _this.props.layer_list;
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            name = _ref[_i];
            canvas_hash[name] = _this.refs[name];
          }
          return typeof (_base = _this.props).canvas_cb === "function" ? _base.canvas_cb(canvas_hash) : void 0;
        };
      })(this);
      draw();
      return typeof (_base = this.props).ref_textarea === "function" ? _base.ref_textarea(this.refs.textarea) : void 0;
    },
    unmount: function() {
      return this.mounted = false;
    },
    props_change: function() {
      var _ref;
      return (_ref = this.props.gui) != null ? _ref.refresh() : void 0;
    },
    canvas_actualize: function() {
      var box, canvas, canvas_list, height, name, width, _i, _j, _len, _len1, _ref, _ref1;
      canvas_list = [];
      _ref = this.props.layer_list;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        name = _ref[_i];
        if (!(canvas = this.refs[name])) {
          continue;
        }
        canvas_list.push(canvas);
      }
      box = this.refs.box;
      _ref1 = box.getBoundingClientRect(), width = _ref1.width, height = _ref1.height;
      width = -1 + Math.floor(width * devicePixelRatio);
      height = -1 + Math.floor(height * devicePixelRatio);
      for (_j = 0, _len1 = canvas_list.length; _j < _len1; _j++) {
        canvas = canvas_list[_j];
        if (canvas.width !== width || canvas.height !== height) {
          canvas.width = width;
          canvas.height = height;
        }
      }
    },
    render: function() {
      return div({
        ref: "box",
        style: {
          width: "100%",
          height: "100%"
        }
      }, (function(_this) {
        return function() {
          var name, _i, _len, _ref;
          _ref = _this.props.layer_list || [];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            name = _ref[_i];
            canvas({
              ref: name,
              style: {
                position: "absolute"
              },
              on_click: _this.mouse_click,
              onMouseDown: _this.mouse_down,
              onMouseUp: _this.mouse_up,
              onMouseMove: _this.mouse_move,
              onMouseOut: _this.mouse_out,
              onWheel: _this.mouse_wheel
            });
          }
          return textarea({
            ref: "textarea",
            onKeyDown: _this.key_down,
            onKeyUp: _this.key_up,
            onKeyPress: _this.key_press,
            onBlur: _this.focus_out,
            style: {
              position: "absolute",
              top: -1000,
              left: -1000
            }
          });
        };
      })(this));
    },
    key_down: function(event) {
      var _ref;
      return (_ref = this.props.gui) != null ? _ref.key_down(event) : void 0;
    },
    key_up: function(event) {
      var _ref;
      return (_ref = this.props.gui) != null ? _ref.key_up(event) : void 0;
    },
    key_press: function(event) {
      var _ref;
      return (_ref = this.props.gui) != null ? _ref.key_press(event) : void 0;
    },
    mouse_click: function(event) {
      var _ref;
      this.refs.textarea.focus();
      return (_ref = this.props.gui) != null ? _ref.mouse_click(event) : void 0;
    },
    mouse_down: function(event) {
      var _ref;
      return (_ref = this.props.gui) != null ? _ref.mouse_down(event) : void 0;
    },
    mouse_up: function(event) {
      var _ref;
      this.refs.textarea.focus();
      return (_ref = this.props.gui) != null ? _ref.mouse_up(event) : void 0;
    },
    mouse_out: function(event) {
      var _ref;
      return (_ref = this.props.gui) != null ? _ref.mouse_out(event) : void 0;
    },
    mouse_move: function(event) {
      var _ref;
      return (_ref = this.props.gui) != null ? _ref.mouse_move(event) : void 0;
    },
    mouse_wheel: function(event) {
      var _ref;
      return (_ref = this.props.gui) != null ? _ref.mouse_wheel(event) : void 0;
    },
    focus_out: function(event) {
      var _ref;
      return (_ref = this.props.gui) != null ? _ref.focus_out(event) : void 0;
    }
  }));

  define_com("Canvas_multi", conf);

}).call(this);
