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
                   ;axe                ;1;warrior       ;orc
                   ;enchantress        ;1;druid         ;beast
                   ;ogre_magi          ;1;mage          ;ogre
                   ;tusk               ;1;warrior       ;beast
                   ;drow_ranger        ;1;hunter        ;undead
                   ;bounty_hunter      ;1;assasin       ;goblin
                   ;clockwerk          ;1;mech          ;goblin
s. shaman          ;shadow_shaman      ;1;shaman        ;troll
                   ;batrider           ;1;knight        ;troll
                   ;tinker             ;1;mech          ;goblin
                   ;anti-mage          ;1;demon_hunter  ;elf
                   ;crystal_maiden     ;2;mage          ;human
                   ;beastmaster        ;2;hunter        ;orc
                   ;juggernaut         ;2;warrior       ;orc
                   ;timbersaw          ;2;mech          ;goblin
                   ;queen_of_pain      ;2;assasin       ;demon
                   ;puck               ;2;mage          ;elf
                   ;witch_doctor       ;2;warlock       ;troll
                   ;slardar            ;2;warrior       ;naga
                   ;chaos_knight       ;2;knight        ;demon
treant p.          ;treant_protector   ;2;druid         ;elf
                   ;luna               ;3;knight        ;elf
                   ;lycan              ;3;warrior       ;hunter
                   ;venomancer         ;3;warlock       ;beast
                   ;omniknight         ;3;knight        ;human
                   ;razor              ;3;mage          ;elemental
                   ;windranger         ;3;hunter        ;elf
phantom a.         ;phantom_assassin   ;3;assasin       ;elf
                   ;abaddon            ;3;knight        ;undead
                   ;sand_king          ;3;assasin       ;beast
                   ;slark              ;3;assasin       ;naga
                   ;sniper             ;3;hunter        ;dwarf
                   ;viper              ;3;assasin       ;dragon
                   ;shadow_fiend       ;3;warlock       ;demon
                   ;lina               ;3;mage          ;human
                   ;doom               ;4;warrior       ;demon
                   ;kunkka             ;4;warrior       ;human
                   ;troll_warlord      ;4;warrior       ;troll
K.O.T.L.           ;keeper_of_the_light;4;mage          ;human
                   ;necrophos          ;4;warlock       ;undead
templar a.         ;templar_assassin   ;4;assasin       ;elf
                   ;alchemist          ;4;warlock       ;goblin
                   ;disruptor          ;4;shaman        ;orc
                   ;medusa             ;4;hunter        ;naga
                   ;dragon_knight      ;4;knight        ;human
                   ;gyrocopter         ;5;mech          ;dwarf
                   ;lich               ;5;mage          ;undead
                   ;tidehunter         ;5;hunter        ;naga
                   ;enigma             ;5;warlock       ;elemental
                   ;techies            ;5;mech          ;goblin
"""
window.unit_list = str.split("\n").map (str)->
  [display_name, type, level, _class, spec] = str.split(';').map((t)->t.trim())
  display_name = display_name or type.replace(/_/g, ' ')
  level = +level
  {
    display_name
    type
    level
    class: _class
    spec
  }
  