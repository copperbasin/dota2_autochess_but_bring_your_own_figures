(function() {
  var module, _uid;

  module = emulator;

  _uid = 0;

  module.FSM_unit_state = {
    "idling": _uid++,
    "attacking_pre": _uid++,
    "attacking": _uid++,
    "cell_moving_start": _uid++,
    "cell_moving_end ": _uid++,
    "casting_pre": _uid++,
    "casting": _uid++,
    "stunned": _uid++
  };

  _uid = 0;

  module.FSM_event = {
    "tick": _uid++
  };

  module.FSM = (function() {
    FSM.prototype.state_list = [];

    FSM.prototype.transition_hash = {};

    function FSM() {
      this.state_list = [];
      this.transition_hash = [];
    }

    return FSM;

  })();


  /*
  Что должно работать
  idling -> attacking_pre -> attacking -> idling
  idling -> casting_pre -> casting -> idling
  idling -> cell_moving_start -> cell_moving_end -> idling
  
  idling -> *_pre -> [event stun_receive] -> idling
   */

}).call(this);
