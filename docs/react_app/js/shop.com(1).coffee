(function() {
  var com_name, conf;

  com_name = "Scene_shop";

  conf = React.createClass(CKR.react_key_map(com_name, {
    state: {
      balance: -1,
      address: "???"
    },
    listener_balance: null,
    listener_address: null,
    mount: function() {
      bg_change("img/shop_bg.jpg");
      this.set_state({
        balance: ton.balance,
        address: ton.address
      });
      ton.on("balance", this.listener_balance = (function(_this) {
        return function(balance) {
          return _this.set_state({
            balance: balance
          });
        };
      })(this));
      return ton.on("address", this.listener_address = (function(_this) {
        return function(address) {
          return _this.set_state({
            address: address
          });
        };
      })(this));
    },
    unmount: function() {
      ton.off("balance", this.listener_balance);
      return ton.off("address", this.listener_address);
    },
    render: function() {
      return div({
        "class": "center pad_top"
      }, (function(_this) {
        return function() {
          return div({
            "class": "background_pad"
          }, function() {
            var balance;
            div({
              style: {
                textAlign: "left",
                position: "abosolute"
              }
            }, function() {
              return Back_button({
                on_click: function() {
                  return router_set("main");
                }
              });
            });
            balance = _this.state.balance;
            if (balance === -1) {
              balance = '?';
            } else {
              balance = balance.toFixed(9);
            }
            div("Address: " + _this.state.address);
            div("Balance: " + balance + " gramm");
            return Unit_shop({
              available_unit_list: [],
              shop_unit_list: unit_list,
              limit: 100500
            });
          });
        };
      })(this));
    }
  }));

  define_com("Scene_shop", conf);

}).call(this);
