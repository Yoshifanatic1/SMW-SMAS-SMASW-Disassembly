cleartable
table "../tables/fonts/standard.txt"

LevelMsg00:
	db "Welcome!   This i", $52|$80
	db "Dinosaur Land.  I", $4D|$80
	db "this strange  lan", $43|$80
	db "we    find    tha", $53|$80
	db "Princess Toadstoo", $4B|$80
	db "is  missing again", $1A|$80
	db "Looks  like Bowse", $51|$80
	db "is at it again", $1A|$80

LevelMsg01:
if !Define_Global_ROMToAssemble == !ROM_SMW_ARCADE
	db "- SWITCH PALACE ", $1C|$80
	db "\"
	db "The  power  of th", $44|$80
	db "switch  you   hav", $44|$80
	db "pushed  will  tur", $4D|$80
	db "\"
	db "      into     ", $1B|$80
	db "\"

else
	db "- SWITCH PALACE ", $1C|$80
	db "The  power  of th", $44|$80
	db "switch  you   hav", $44|$80
	db "pushed  will  tur", $4D|$80
	db "\"
	db "      into     ", $1B|$80
	db "Your progress wil", $4B|$80
	db "also   be   saved", $1B|$80
endif


LevelMsg02:
	db "Hello!   Sorry I'", $4C|$80
	db "not  home,  but  ", $08|$80
	db "have    gone    t", $4E|$80
	db "rescue  my friend", $52|$80
	db "who were  capture", $43|$80
	db "by Bowser", $1B|$80
	db "                ", $60,$61|$80
	db "         - Yoshi", $62,$63|$80

LevelMsg03:
	db "Hooray!  Thank yo", $54|$80
	db "for rescuing   me", $1B|$80
	db "My name  is Yoshi", $1B|$80
	db "On   my   way   t", $4E|$80
	db "rescue my friends", $1D|$80
	db "Bowser trapped  m", $44|$80
	db "in that egg", $1B|$80
	db "\"

LevelMsg04:
	db "It is possible  t", $4E|$80
	db "fill in the dotte", $43|$80
	db "line blocks.    T", $4E|$80
	db "fill in the yello", $56|$80
	db "ones, just go wes", $53|$80
	db "then north  to th", $44|$80
	db "top     of     th", $44|$80
	db "mountain", $1B|$80

LevelMsg05:
	db "-POINT OF ADVICE", $1C|$80
	db "You  can  hold  a", $4D|$80
	db "extra item  in th", $44|$80
	db "box at  the top o", $45|$80
	db "the screen.     T", $4E|$80
	db "use it,  press th", $44|$80
	db "SELECT Button", $1B|$80
	db "\"

LevelMsg06:
	db "-POINT OF ADVICE", $1C|$80
	db "To   pick   up   ", $40|$80
	db "shell,  use  the ", $17|$80
	db "or  Y  Button.  T", $4E|$80
	db "throw    a   shel", $4B|$80
	db "upwards,  look  u", $4F|$80
	db "and let go of  th", $44|$80
	db "button", $1B|$80

LevelMsg07:
	db "To do a spin jump", $1D|$80
	db "press    the     ", $00|$80
	db "Button.    A Supe", $51|$80
	db "Mario   spin  jum", $4F|$80
	db "can break some  o", $45|$80
	db "the   blocks   an", $43|$80
	db "defeat some of th", $44|$80
	db "tougher enemies", $1B|$80

LevelMsg08:
	db "-POINT OF ADVICE", $1C|$80
	db "This   gate  mark", $52|$80
	db "the middle of thi", $52|$80
	db "area.   By cuttin", $46|$80
	db "the tape here, yo", $54|$80
	db "can continue  fro", $4C|$80
	db "close   to    thi", $52|$80
	db "point", $1B|$80

LevelMsg09:
	db "-POINT OF ADVICE", $1C|$80
	db "The big coins  ar", $44|$80
	db "Dragon Coins.   I", $45|$80
	db "you  pick up  fiv", $44|$80
	db "of  these  in  on", $44|$80
	db "area,  you  get a", $4D|$80
	db "extra Mario", $1B|$80
	db "\"

LevelMsg0A:
	db "When you  stomp o", $4D|$80
	db "an enemy,  you ca", $4D|$80
	db "jump high  if  yo", $54|$80
	db "hold    the   jum", $4F|$80
	db "button.  Use Up o", $4D|$80
	db "the Control Pad t", $4E|$80
	db "jump high  in  th", $44|$80
	db "shallow water", $1B|$80

LevelMsg0B:
	db "If  you are  in a", $4D|$80
	db "area that you hav", $44|$80
	db "already   cleared", $1D|$80
	db "you can  return t", $4E|$80
	db "the map screen  b", $58|$80
	db "pressing    START", $1D|$80
	db "then SELECT", $1B|$80
	db "\"

LevelMsg0C:
	db "You   get    Bonu", $52|$80
	db "Stars  if  you cu", $53|$80
	db "the  tape  at  th", $44|$80
	db "end  of each area", $1B|$80
	db "If you collect 10", $6B|$80
	db "Bonus  Stars   yo", $54|$80
	db "can   play  a  fu", $4D|$80
	db "bonus game", $1B|$80

LevelMsg0D:
	db "Press Up   on  th", $44|$80
	db "Control Pad  whil", $44|$80
	db "jumping   and  yo", $54|$80
	db "can  cling  to th", $44|$80
	db "fence.    To go i", $4D|$80
	db "the  door  at  th", $44|$80
	db "end  of this area", $1D|$80
	db "use Up also", $1B|$80

LevelMsg0E:
	db "-POINT OF ADVICE", $1C|$80
	db "One   of   Yoshi'", $52|$80
	db "friends is trappe", $43|$80
	db "in  the castle  b", $58|$80
	db "Iggy Koopa.     T", $4E|$80
	db "defeat  him,  pus", $47|$80
	db "him into  the lav", $40|$80
	db "pool", $1B|$80

LevelMsg0F:
	db "Use  Mario's  cap", $44|$80
	db "to   soar  throug", $47|$80
	db "the air! Run fast", $1D|$80
	db "jump, and hold th", $44|$80
	db "Y Button.  To kee", $4F|$80
	db "balance,  use lef", $53|$80
	db "and  right  on th", $44|$80
	db "Control Pad", $1B|$80

LevelMsg10:
	db "The red dot  area", $52|$80
	db "on  the  map  hav", $44|$80
	db "two      differen", $53|$80
	db "exits.      If yo", $54|$80
	db "have  the time an", $43|$80
	db "skill,  be sure t", $4E|$80
	db "look for them", $1B|$80
	db "\"

LevelMsg11:
	db "This  is  a  Ghos", $53|$80
	db "House.     Can yo", $54|$80
	db "find   the   exit", $1E|$80
	db "Hee,  hee,  hee..", $1B|$80
	db "Don't get lost", $1A|$80
	db "\"
	db "\"
	db "\"

LevelMsg12:
	db "You can  slide th", $44|$80
	db "screen   left   o", $51|$80
	db "right  by pressin", $46|$80
	db "the L or R Button", $52|$80
	db "on   top   of  th", $44|$80
	db "controller.    Yo", $54|$80
	db "may be able to se", $44|$80
	db "further ahead", $1B|$80

LevelMsg13:
	db "There   are   fiv", $44|$80
	db "entrances  to  th", $44|$80
	db "Star   World    i", $4D|$80
	db "Dinosaur     Land", $1B|$80
	db "Find  them all an", $43|$80
	db "you   can   trave", $4B|$80
	db "between       man", $58|$80
	db "different places", $1B|$80

LevelMsg14:
	db "Here,   the  coin", $52|$80
	db "you   collect   o", $51|$80
	db "the time remainin", $46|$80
	db "can  change   you", $51|$80
	db "progress.  Can yo", $54|$80
	db "find  the  specia", $4B|$80
	db "goal", $1E|$80
	db "\"

LevelMsg15:
	db "Amazing!  Few hav", $44|$80
	db "made it  this far", $1B|$80
	db "Beyond  lies   th", $44|$80
	db "Special      Zone", $1B|$80
	db "Complete  it   an", $43|$80
	db "you can explore  ", $40|$80
	db "strange new world", $1B|$80
	db "GOOD LUCK", $1A|$80