cleartable
table "../tables/fonts/standard.txt"

LevelStr_0100:	db "YOSHI'S\"
LevelStr_0200:	db "STAR\"
LevelStr_0300:	db "#1 IGGY'S\"
LevelStr_0400:	db "#2 MORTON'S\"
LevelStr_0500:	db "#3 LEMMY'S\"
LevelStr_0600:	db "#4 LUDWIG'S\"
LevelStr_0700:	db "#5 ROY'S\"
LevelStr_0800:	db "#6 WENDY'S\"
LevelStr_0900:	db "#7 LARRY'S\"
LevelStr_0A00:	db "DONUT\"
LevelStr_0B00:	db "GREEN\"
LevelStr_0C00:	db "TOP SECRET AREA\"
LevelStr_0D00:	db "VANILLA\"
LevelStr_0E00:	db $38,$39,$3A,$3B,$3C,"\" ;YELLOW
LevelStr_0F00:	db "RED\"
LevelStr_1000:	db "BLUE\"
LevelStr_1100:	db "BUTTER BRIDGE\"
LevelStr_1200:	db "CHEESE BRIDGE\"
LevelStr_1300:	db "SODA LAKE\"
LevelStr_1400:	db "COOKIE MOUNTAIN\"
LevelStr_1500:	db "FOREST\"
LevelStr_1600:	db "CHOCOLATE\"
LevelStr_1700:	db "CHOCO-GHOST HOUSE\"
LevelStr_1800:	db "SUNKEN GHOST SHIP\"
LevelStr_1900:	db "VALLEY\"
LevelStr_1A00:	db "BACK DOOR\"
LevelStr_1B00:	db "FRONT DOOR\"
LevelStr_1C00:	db "GNARLY\"
LevelStr_1D00:	db "TUBULAR\"
LevelStr_1E00:	db "WAY COOL\"

LevelStr_0010:	db "HOUSE\"
LevelStr_0020:	db "ISLAND\"
LevelStr_0030:	db "SWITCH PALACE\"
LevelStr_0040:	db "CASTLE\"
LevelStr_0050:	db "PLAINS\"
LevelStr_0060:	db "GHOST HOUSE\"
LevelStr_0070:	db "SECRET\"
LevelStr_0080:	db "DOME\"
LevelStr_0090:	db "FORTRESS\"
LevelStr_00A0:	db "OF", $32,$33,$34,$35,$36,$37, "ON\" ;ILLUSI
LevelStr_00B0:	db "OF BOWSER\"
LevelStr_00C0:	db "ROAD\"
LevelStr_00D0:	db "WORLD\"
LevelStr_00E0:	db "AWESOME\"

;Bit 7 set from here on out
LevelStr_0001:	db $64|$80 ;1
LevelStr_0002:	db $65|$80 ;2
LevelStr_0003:	db $66|$80 ;3
LevelStr_0004:	db $67|$80 ;4
LevelStr_0005:	db $68|$80 ;5
LevelStr_0006:	db "PALAC", $04|$80 ;E
LevelStr_0007:	db "ARE", $00|$80 ;A
LevelStr_0008:	db "GROOV", $18|$80 ;Y
LevelStr_0009:	db "MOND", $0E|$80 ;O
LevelStr_000A:	db "OUTRAGEOU", $12|$80 ;S
LevelStr_000B:	db "FUNK", $18|$80 ;Y
LevelStr_000C:	db "HOUS", $04|$80 ;E

LevelStr_None:	db "\"
