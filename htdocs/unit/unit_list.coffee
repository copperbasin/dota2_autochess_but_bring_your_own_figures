str = """
;warrior
;druid
;mage
;hunter
;assasin
;mech
;shaman
;knight
;demon_hunter
;warlock
"""
window.class_list = str.split("\n").map (str)->
  [display_name, name] = str.split(';').map((t)->t.trim())
  display_name = display_name or name.replace(/_/g, ' ').capitalize()
  {display_name, name}

str = """
;orc
;beast
;ogre
;undead
;goblin
;troll
;elf
;human
;demon
;elemental
;naga
;dwarf
;dragon
"""
window.spec_list = str.split("\n").map (str)->
  [display_name, name] = str.split(';').map((t)->t.trim())
  display_name = display_name or name.replace(/_/g, ' ').capitalize()
  {display_name, name}

str = """
                   ;axe                ;1;1;0
                   ;enchantress        ;1;2;0
                   ;ogre_magi          ;1;3;0
                   ;tusk               ;1;4;0
                   ;drow_ranger        ;1;5;0
                   ;bounty_hunter      ;1;6;0
                   ;clockwerk          ;1;7;0
s. shaman          ;shadow_shaman      ;1;8;0
                   ;batrider           ;1;9;0
                   ;tinker             ;1;0;1
                   ;anti-mage          ;1;1;1
                   ;crystal_maiden     ;2;2;1
                   ;beastmaster        ;2;3;1
                   ;juggernaut         ;2;4;1
                   ;timbersaw          ;2;5;1
                   ;queen_of_pain      ;2;6;1
                   ;puck               ;2;7;1
                   ;witch_doctor       ;2;8;1
                   ;slardar            ;2;9;1
                   ;chaos_knight       ;2;0;2
treant p.          ;treant_protector   ;2;1;2
                   ;luna               ;3;2;2
                   ;lycan              ;3;3;2
                   ;venomancer         ;3;4;2
                   ;omniknight         ;3;5;2
                   ;razor              ;3;6;2
                   ;windranger         ;3;7;2
phantom a.         ;phantom_assassin   ;3;8;2
                   ;abaddon            ;3;9;2
                   ;sand_king          ;3;0;3
                   ;slark              ;3;1;3
                   ;sniper             ;3;2;3
                   ;viper              ;3;3;3
                   ;shadow_fiend       ;3;4;3
                   ;lina               ;3;5;3
                   ;doom               ;4;6;3
                   ;kunkka             ;4;7;3
                   ;troll_warlord      ;4;8;3
K.O.T.L.           ;keeper_of_the_light;4;9;3
                   ;necrophos          ;4;0;4
templar a.         ;templar_assassin   ;4;1;4
                   ;alchemist          ;4;2;4
                   ;disruptor          ;4;3;4
                   ;medusa             ;4;4;4
                   ;dragon_knight      ;4;5;4
                   ;gyrocopter         ;5;6;4
                   ;lich               ;5;7;4
                   ;tidehunter         ;5;8;4
                   ;enigma             ;5;9;4
                   ;techies            ;5;0;5
"""
window.unit_list = str.split("\n").map (str)->
  [display_name, type, level, _class, spec] = str.split(';').map((t)->t.trim())
  display_name = display_name or type.replace(/_/g, ' ')
  level = +level
  {
    display_name
    type
    level
    class : class_list[_class].name
    spec  : spec_list[spec].name
  }
  