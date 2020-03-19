(function() {
  var img, str, unit, unit_type_hash, _fn, _i, _len;

  str = ";warrior\n;druid\n;mage\n;hunter\n;assasin\n;mech\n;shaman\n;knight\n;demon_hunter\n;warlock";

  window.class_list = str.split("\n").map(function(str) {
    var display_name, name, _ref;
    _ref = str.split(";").map(function(t) {
      return t.trim();
    }), display_name = _ref[0], name = _ref[1];
    display_name = display_name || name.replace(/_/g, " ").capitalize();
    return {
      display_name: display_name,
      name: name
    };
  });

  str = ";orc\n;beast\n;ogre\n;undead\n;goblin\n;troll\n;elf\n;human\n;demon\n;elemental\n;naga\n;dwarf\n;dragon";

  window.spec_list = str.split("\n").map(function(str) {
    var display_name, name, _ref;
    _ref = str.split(";").map(function(t) {
      return t.trim();
    }), display_name = _ref[0], name = _ref[1];
    display_name = display_name || name.replace(/_/g, " ").capitalize();
    return {
      display_name: display_name,
      name: name
    };
  });

  str = "10001;                   ;axe                ;1;warrior       ;orc\n10002;                   ;enchantress        ;1;druid         ;beast\n10003;                   ;ogre_magi          ;1;mage          ;ogre\n10004;                   ;tusk               ;1;warrior       ;beast\n10005;                   ;drow_ranger        ;1;hunter        ;undead\n10006;                   ;bounty_hunter      ;1;assasin       ;goblin\n10007;                   ;clockwerk          ;1;mech          ;goblin\n10008;s. shaman          ;shadow_shaman      ;1;shaman        ;troll\n10009;                   ;batrider           ;1;knight        ;troll\n10010;                   ;tinker             ;1;mech          ;goblin\n10011;                   ;anti-mage          ;1;demon_hunter  ;elf\n20001;                   ;crystal_maiden     ;2;mage          ;human\n20002;                   ;beastmaster        ;2;hunter        ;orc\n20003;                   ;juggernaut         ;2;warrior       ;orc\n20004;                   ;timbersaw          ;2;mech          ;goblin\n20005;                   ;queen_of_pain      ;2;assasin       ;demon\n20006;                   ;puck               ;2;mage          ;elf\n20007;                   ;witch_doctor       ;2;warlock       ;troll\n20008;                   ;slardar            ;2;warrior       ;naga\n20009;                   ;chaos_knight       ;2;knight        ;demon\n20010;treant p.          ;treant_protector   ;2;druid         ;elf\n30001;                   ;luna               ;3;knight        ;elf\n30002;                   ;lycan              ;3;warrior       ;hunter\n30003;                   ;venomancer         ;3;warlock       ;beast\n30004;                   ;omniknight         ;3;knight        ;human\n30005;                   ;razor              ;3;mage          ;elemental\n30006;                   ;windranger         ;3;hunter        ;elf\n30007;phantom a.         ;phantom_assassin   ;3;assasin       ;elf\n30008;                   ;abaddon            ;3;knight        ;undead\n30009;                   ;sand_king          ;3;assasin       ;beast\n30010;                   ;slark              ;3;assasin       ;naga\n30011;                   ;sniper             ;3;hunter        ;dwarf\n30012;                   ;viper              ;3;assasin       ;dragon\n30013;                   ;shadow_fiend       ;3;warlock       ;demon\n30014;                   ;lina               ;3;mage          ;human\n40001;                   ;doom               ;4;warrior       ;demon\n40002;                   ;kunkka             ;4;warrior       ;human\n40003;                   ;troll_warlord      ;4;warrior       ;troll\n40004;K.O.T.L.           ;keeper_of_the_light;4;mage          ;human\n40005;                   ;necrophos          ;4;warlock       ;undead\n40006;templar a.         ;templar_assassin   ;4;assasin       ;elf\n40007;                   ;alchemist          ;4;warlock       ;goblin\n40008;                   ;disruptor          ;4;shaman        ;orc\n40009;                   ;medusa             ;4;hunter        ;naga\n40010;                   ;dragon_knight      ;4;knight        ;human\n50001;                   ;gyrocopter         ;5;mech          ;dwarf\n50002;                   ;lich               ;5;mage          ;undead\n50003;                   ;tidehunter         ;5;hunter        ;naga\n50004;                   ;enigma             ;5;warlock       ;elemental\n50005;                   ;techies            ;5;mech          ;goblin";

  window.dev_script_gen = function(opt) {
    var id, id_lo, level_hash, res_list, unit, _i, _len;
    if (opt == null) {
      opt = {};
    }
    if (opt.price == null) {
      opt.price = 400;
    }
    res_list = [];
    level_hash = {
      1: 1,
      2: 1,
      3: 1,
      4: 1,
      5: 1
    };
    for (_i = 0, _len = unit_list.length; _i < _len; _i++) {
      unit = unit_list[_i];
      id_lo = level_hash[unit.level]++;
      id = 10000 * unit.level + id_lo;
      id = unit.id || id;
      res_list.push("dictnew prices !\n" + opt.price + " create-price\n" + unit.level + " add-price\nprices @ create-unit-prices\n" + id + " add-units-list");
    }
    return res_list.join("\n\n");
  };

  window.unit_type2image_hash = {};

  window.unit_id_hash = {};

  unit_type_hash = {};

  _fn = function(img) {
    return img.onload = function() {
      return img.loaded = true;
    };
  };
  for (_i = 0, _len = unit_list.length; _i < _len; _i++) {
    unit = unit_list[_i];
    unit_type_hash[unit.type] = unit;
    unit_id_hash[unit.id] = unit;
    img = new Image;
    _fn(img);
    // img.src = "/img/dota/" + unit.type + "_icon.png";
    img.src = "https://raw.githubusercontent.com/copperbasin/dota2_autochess_but_bring_your_own_figures/promo/htdocs/img/dota/" + unit.type + "_icon.png";
    unit_type2image_hash[unit.type] = img;
  }

  window.battle_unit_create = function(opt) {
    var blueprint, grid_x, grid_y, ret, side, star_lvl, type;
    type = opt.type, side = opt.side, grid_x = opt.grid_x, grid_y = opt.grid_y, star_lvl = opt.star_lvl;
    if (!(blueprint = unit_type_hash[type])) {
      perr("can't create unit " + type);
      return null;
    }
    if (side == null) {
      side = 0;
    }
    if (grid_x == null) {
      grid_x = -1;
    }
    if (grid_y == null) {
      grid_y = -1;
    }
    ret = new emulator.Unit;
    ret.x = grid_x * battle_board_cell_size_unit + battle_board_cell_size_unit_2;
    ret.y = grid_y * battle_board_cell_size_unit + battle_board_cell_size_unit_2;
    ret.side = side;
    ret.hp100 = blueprint.hp * 100;
    ret.mp100 = blueprint.mana * 100;
    ret.hp_max100 = ret.hp100;
    ret.mp_max100 = ret.mp100;
    ret.ad100 = blueprint.attack_damage_max * 100;
    ret.as = blueprint.attack_rate * 100;
    ret.ar = blueprint.attack_range;
    ret.ar2 = ret.ar * ret.ar;
    ret.armor = blueprint.armor;
    ret.spec = blueprint.spec;
    ret["class"] = blueprint["class"];
    ret.type = blueprint.type;
    ret.display_name = blueprint.display_name;
    ret.move_type = blueprint.move_type;
    ret.fsm_ref = emulator.fsm_craft({
      attack_type: "melee"
    });
    ret.star_lvl = star_lvl;
    return ret;
  };

}).call(this);
