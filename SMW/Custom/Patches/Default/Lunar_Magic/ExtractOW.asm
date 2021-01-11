@asar 1.71
;Overworld Extractor by Yoshifanatic
;This patch allows you to extract an overworld into a file format similar to Lunar Magic's MWL files that I refer to as MWO (Mario World Overworld).
;To use this, set the below !hackname define to contain the name of the hack you wish to extract the overworld from, then when asar prompts you for a ROM name, enter a file name that doesn't exist. Asar will then generate a file with the name you entered. I recommend naming the file as XX.mwo, with XX being a hex number.

incsrc "../../../../../Global/Global_Definitions.asm"
incsrc "../../../../../Global/Global_Macros.asm"

; Changes:
; - Removed support for the Japanese version, because it will make maintaining this patch easier.
; - Allowed data inserted into the generated .mwo to cross bank boundaries. Prior to asar 1.60 introducing the check bankcross command, it was impossible to both use norom mapping on the generated .mwo and use lorom mapping when extracting data from the SMW ROM because of how the snestopc function worked.
; - Added support for the max 6x6 event area, 2.53's extra levels/events hijack, and 3.00's FoI event boo settings.
; - Cleaned up some of the coding.
; - Removed the GetCorrectIncbinOffsets and GetRemainder macros because asar 1.71's ability to use math on incbin offsets made them unnecessary (and they also slowed down patch compilation).
; - Moved some of the default data to separate files.

!hackname = LMASMHacks.smc
!header = $0200
!ExtraInfo = !TRUE			; Set this to !TRUE and asar will display more overworld information about the ROM you're extracting from.

lorom

;---------------------------------------------------------------------------

macro InsertExpandedAreaBlock(DataName)
!offset2 #= (readfile2("!hackname", snestopc(!offset1)+!header-$04)+!offset1+$01)|$008000
incbin "!hackname":(snestopc(!offset1)+!header)-(snestopc(!offset2)+!header)
print "Extracted ", bytes," bytes from the <DataName> at $",hex(!offset1)
endmacro

;---------------------------------------------------------------------------

!Region = readfile1("!hackname", snestopc($00FFD9)+!header)
;00 - Japan
;01 - USA
;02 - PAL
;03+ - ???

!Version = readfile1("!hackname", snestopc($00FFDB)+!header)

assert !Region == $01, "You can only use this patch on the USA version of SMW!"
assert !Version == $00, "You can only use this patch on the USA version of SMW!"

print "Extracting Overworld Data from a SMW ROM called !hackname..."

if canread4($008000) == !TRUE
	if read4($008000) != $2E524D4C
		error "You're supposed to apply this patch to a non-existing file or an .mwo!"
	else
		print "Overwriting existing .mwo"
	endif
endif
print ""

;---------------------------------------------------------------------------

!VarOffset1 = $0FF0B4
!VarOffset2 = $0FF0C1

if readfile1("!hackname", snestopc(!VarOffset1)+!header) == $FF
	!LMVer1 = 1
	!LMVer2 = 0
	!LMVer3 = 0
	!MWOYear #= $31393931
	!MWOProgram = "OriginalSMW."
	print "This ROM has not been edited with Lunar Magic yet."
else
	!LMVer1 #= (readfile1("!hackname", snestopc(!VarOffset1)+!header))&$0F
	!LMVer2 #= (readfile1("!hackname", snestopc(!VarOffset1+$02)+!header))&$0F
	!LMVer3 #= (readfile1("!hackname", snestopc(!VarOffset1+$03)+!header))&$0F
	!MWOYear #= (readfile4("!hackname", snestopc(!VarOffset2)+!header))
	!MWOProgram = "Lunar Magic."
	print "This ROM has been edited with Lunar Magic !LMVer1.!LMVer2!LMVer3."
	assert !LMVer1 > 2, "You can only use this patch on a ROM edited with Lunar Magic 3.00+!"
endif

;---------------------------------------------------------------------------

!VarOffset1 = $04E67C
!VarOffset2 = $04E5D6

if readfile3("!hackname", snestopc(!VarOffset1)+!header)&$7FFFFF == !VarOffset2
	print "LM ASM Hijack 'Expanded Castle Destruction Event Table' is missing."
endif

;---------------------------------------------------------------------------

!VarOffset1 = $04DCBC
!VarOffset2 = $04DCC1
!VarOffset3 = $05D000

if ((readfile2("!hackname", snestopc(!VarOffset1)+!header))+(readfile1("!hackname", snestopc(!VarOffset2)+!header)*$10000))&$7FFFFF == !VarOffset3
	print "LM ASM Hijack 'Expanded Overworld Layer 1 Map16' is missing."
endif

;---------------------------------------------------------------------------

!VarOffset1 = $04E49F
!VarOffset2 = $04DD8D

if readfile3("!hackname", snestopc(!VarOffset1)+!header)&$7FFFFF == !VarOffset2
	print "LM ASM Hijack 'Custom Layer 2 Events' is missing."
endif

;---------------------------------------------------------------------------

!VarOffset1 = $04DC72
!VarOffset2 = $04DC79
!VarOffset3 = $04A533

if ((readfile2("!hackname", snestopc(!VarOffset1)+!header))+(readfile1("!hackname", snestopc(!VarOffset2)+!header)*$10000))&$7FFFFF == !VarOffset3
	print "LM ASM Hijack 'Custom Overworld Layer 2 Tilemap' is missing."
endif

;---------------------------------------------------------------------------

!VarOffset1 = $04D7F9

if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $A2
	print "LM ASM Hijack 'Custom Overworld Layer 1 Data' is missing. No Layer 1 translevel number data can be extracted due to being in a different format."
endif

;---------------------------------------------------------------------------

!VarOffset1 = $0FFFEB

if readfile1("!hackname", snestopc(!VarOffset1)+!header) == $00
	!CompressionDisplay = "LC_LZ2 - Original Game Code"
	!CompressionSetting = $00
elseif readfile1("!hackname", snestopc(!VarOffset1)+!header) == $01
	!CompressionDisplay = "LC_LZ2 - Optimized for Speed"
	!CompressionSetting = $00
elseif readfile1("!hackname", snestopc(!VarOffset1)+!header) == $02
	!CompressionDisplay = "LC_LZ3 - Better Compression"
	!CompressionSetting = $02
elseif readfile1("!hackname", snestopc(!VarOffset1)+!header) == $FF
	!CompressionDisplay = "LC_LZ2 - Original Game Code"
	!CompressionSetting = $00
else
	!CompressionDisplay = "Unknown/Invalid"
	!CompressionSetting = $FF
endif

print "LM Compression Setting: !CompressionDisplay "

;---------------------------------------------------------------------------

!VarOffset1 = $04ECBA
!VarOffset2 = $04D85D

if readfile3("!hackname", snestopc(!VarOffset1)+!header)&$7FFFFF == !VarOffset2
	print "LM ASM Hijack 'Custom Overworld Events' is missing."
endif

;---------------------------------------------------------------------------

!VarOffset1 = $048509

if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
	print "LM ASM Hijack 'Extra OW Pipe/Star exit indexes' is missing."
endif

;---------------------------------------------------------------------------

!VarOffset1 = $049A35

if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
	print "LM ASM Hijack 'Extra Path exit indexes' is missing."
endif

;---------------------------------------------------------------------------

!VarOffset1 = $04E9F7

if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
	print "LM ASM Hijack 'Silent Events' is missing. No silent event data will be extracted."
endif

;---------------------------------------------------------------------------

!VarOffset1 = $009F19
!VarOffset2 = $05DD87
!VarOffset3 = $05DDA0

!ExtraOverworldLevelsAndEvents = !FALSE

if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
	print "LM ASM Hijack 'Custom Initial Level Flags' is missing. No level flag data will be extracted."

else
	if readfile3("!hackname", snestopc(!VarOffset2)+!header)&$7FFFFF != !VarOffset3
		!ExtraOverworldLevelsAndEvents = !TRUE
		print "LM ASM Hijack 'Extra overworld events and levels' is installed"
	endif
endif

;---------------------------------------------------------------------------

!VarOffset1 = $048086

if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
	print "LM ASM Hijack 'Overworld Exanimation' is missing. No ExAnimation data can be extracted."
endif

;---------------------------------------------------------------------------

!VarOffset1 = $0084F3

if readfile1("!hackname", snestopc(!VarOffset1)+!header)&$7F <= $0F
	print "LM hijack 'Custom Castle Destruction Cutscene Text' is missing. No Cutscene data can be extracted due to being in a different format."
endif

;---------------------------------------------------------------------------

!VarOffset1 = $0C9F16

if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $BF
	print "LM ASM Hijack 'Custom Credits Layer 3' is missing. No credits image will be extracted."
endif

;---------------------------------------------------------------------------

!VarOffset1 = $009C6F

if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
	print "LM ASM Hijack 'Custom Title Screen Demo' is missing. No demo data will be extracted."
endif

;---------------------------------------------------------------------------

!VarOffset1 = $01E762

if readfile1("!hackname", snestopc(!VarOffset1)+!header) == $EA
	print "LM ASM Hijack 'Sprite 19 Fix' is installed."
endif

;---------------------------------------------------------------------------

!VarOffset1 = $00A1DA

if readfile1("!hackname", snestopc(!VarOffset1)+!header) == $22
	print "LM ASM Hijack 'Title screen Demo Recording' is installed."
endif

;---------------------------------------------------------------------------

if !ExtraInfo == !TRUE
print ""

!VarOffset1 = $009EF0

!Temp2 = "on an unknown submap"
!Temp #= readfile1("!hackname", snestopc(!VarOffset1)+!header)
if !Temp = $00
	!Temp2 = "on the Main Map"
elseif !Temp = $01
	!Temp2 = "on Yoshi's Island"
elseif !Temp = $02
	!Temp2 = "in Vanilla Dome"
elseif !Temp = $03
	!Temp2 = "in the Forest of Illusion"
elseif !Temp = $04
	!Temp2 = "in the Valley of Bowser"
elseif !Temp = $05
	!Temp2 = "in the Special World"
elseif !Temp = $06
	!Temp2 = "on the Star Road"
else
	!Temp2 = "on an unknown submap"
endif
	print "Mario's starting location is !Temp2."

;---------------------------------------------------------------------------

!VarOffset1 = $009EF1

!Temp2 = "on an unknown submap"
!Temp #= readfile1("!hackname", snestopc(!VarOffset1)+!header)
if !Temp = $00
	!Temp2 = "on the Main Map"
elseif !Temp = $01
	!Temp2 = "on Yoshi's Island"
elseif !Temp = $02
	!Temp2 = "in Vanilla Dome"
elseif !Temp = $03
	!Temp2 = "in the Forest of Illusion"
elseif !Temp = $04
	!Temp2 = "in the Valley of Bowser"
elseif !Temp = $05
	!Temp2 = "in the Special World"
elseif !Temp = $06
	!Temp2 = "on the Star Road"
else
	!Temp2 = "on an unknown submap"
endif
	print "Luigi's starting location is !Temp2."

;---------------------------------------------------------------------------

!VarOffset1 = $00A267

!Temp = readfile1("!hackname", snestopc(!VarOffset1)+!header)
!Temp2 = "unknown"

if  !Temp == $80
	!Temp2 = "off"
elseif !Temp == $10
	!Temp2 = "on"
endif
print "'Allow using Start+Select to exit passed levels.' setting is !Temp2."

;---------------------------------------------------------------------------
 
!VarOffset1 = $048380
!Temp = readfile1("!hackname", snestopc(!VarOffset1)+!header)
!Temp2 = "unknown"

if !Temp == $00
	!Temp2 = "off"
elseif !Temp == $10
	!Temp2 = "on"
endif
print "'Allow using Start to scroll on main overworld map.' setting is !Temp2."

;---------------------------------------------------------------------------

!VarOffset1 = $04828D
!VarOffset2 = $04836E

!Temp = readfile1("!hackname", snestopc(!VarOffset1)+!header)

if !Temp == $80
	print "'Allow players to exchange lives (at game over, etc.)' setting is off."
elseif !Temp == $F0
	print "'Allow players to exchange lives (at game over, etc.)' setting is on."
	!Temp2 = readfile1("!hackname", snestopc(!VarOffset2)+!header)
	if !Temp2 == $80
		print "Allow using L/R for life exchange.' setting is off."
	elseif !Temp2 == $F0
		print "'Allow using L/R for life exchange.' setting is on."
	else
		print "'Allow using L/R for life exchange.' setting is unknown."
	endif
else
	print "'Allow players to exchange lives (at game over, etc.)' setting is unknown."
endif

;---------------------------------------------------------------------------

!Temp = readfile1("!hackname", snestopc($04914E)+!header)
!Temp2 = "unknown"

if !Temp == $EA
	!Temp2 = "off"
elseif !Temp == $F0
	!Temp2 = "on"
endif
print "'Allow using L+R to enter destroyed castles and fortresses.' setting is !Temp2."

;---------------------------------------------------------------------------

!VarOffset1 = $05DAE6

!Temp = readfile1("!hackname", snestopc(!VarOffset1)+!header)
!Temp2 = "unknown"

if !Temp == $80
	!Temp2 = "off"
elseif !Temp == $D0
	!Temp2 = "on"
endif
print "'Allow level 24 to redirect screen exits based on coins collected and time remaining.' setting is !Temp2."

;---------------------------------------------------------------------------

!VarOffset1 = $03BA26
!VarOffset2 = $04E622

!Temp = readfile1("!hackname", snestopc(!VarOffset1)+!header)|(readfile1("!hackname", snestopc(!VarOffset2)+!header)*$100)
!Temp2 = "unknown"

if !Temp == $8000
	!Temp2 = "off"
elseif !Temp == $D001
	!Temp2 = "on"
elseif !Temp == $D0FF
	!Temp2 = "on"
endif
print "'Bring up a save prompt when the player passes a Castle, Fortress, Ghost House, Switch Palace, level tile 0x80, or level tile 0X7E.' setting is !Temp2."

;---------------------------------------------------------------------------

!VarOffset1 = $04FD8A
!VarOffset2 = $04FD86
!VarOffset3 = $04FD89

!Temp = readfile1("!hackname", snestopc(!VarOffset1)+!header)
!Temp2 = "unknown"

if !Temp == $D0
	!Temp2 = "off"
elseif !Temp == $80
	!Temp2 = "on"
endif
print "'Hide second ghost of sprite slot C until event passed' setting is !Temp2."

if stringsequal("!Temp2","off")
	!Temp = (readfile2("!hackname", snestopc(!VarOffset2)+!header)-$1F02)
	!Temp3 = (readfile1("!hackname", snestopc(!VarOffset3)+!header))
	print "The second ghost of sprite slot C will reveal itself on these events:"
	if !Temp3&$80 != $00
		!Temp2 = $00+(!Temp*$08)
		print " - Event: $",hex(!Temp2)
	endif
	if !Temp3&$40 != $00
		!Temp2 = $01+(!Temp*$08)
		print " - Event: $",hex(!Temp2)
	endif
	if !Temp3&$20 != $00
		!Temp2 = $02+(!Temp*$08)
		print " - Event: $",hex(!Temp2)
	endif
	if !Temp3&$10 != $00
		!Temp2 = $03+(!Temp*$08)
		print " - Event: $",hex(!Temp2)
	endif
	if !Temp3&$08 != $00
		!Temp2 = $04+(!Temp*$08)
		print " - Event: $",hex(!Temp2)
	endif
	if !Temp3&$04 != $00
		!Temp2 = $05+(!Temp*$08)
		print " - Event: $",hex(!Temp2)
	endif
	if !Temp3&$02 != $00
		!Temp2 = $06+(!Temp*$08)
		print " - Event: $",hex(!Temp2)
	endif
	if !Temp3&$01 != $00
		!Temp2 = $07+(!Temp*$08)
		print " - Event: $",hex(!Temp2)
	endif
endif

;---------------------------------------------------------------------------

!VarOffset1 = $04EACC
!VarOffset2 = $04EAD1

!Temp = readfile3("!hackname", snestopc(!VarOffset1)+!header)
!Temp2 = "unknown"

if !Temp == $A030C2
	!Temp2 = "off"
elseif !Temp == $1495AD
	!Temp2 = "on"
	!Temp3 = readfile1("!hackname", snestopc(!VarOffset2)+!header)
	if !Temp3 == $01
		!Temp4 = "0 Slow"
	elseif !Temp3 == $02
		!Temp4 = "1"
	elseif !Temp3 == $03
		!Temp4 = "2"
	elseif !Temp3 == $04
		!Temp4 = "3"
	elseif !Temp3 == $05
		!Temp4 = "4"
	elseif !Temp3 == $06
		!Temp4 = "5 Normal"
	elseif !Temp3 == $07
		!Temp4 = "6"
	elseif !Temp3 == $08
		!Temp4 = "7"
	elseif !Temp3 == $0A
		!Temp4 = "8"
	elseif !Temp3 == $0B
		!Temp4 = "9"
	elseif !Temp3 == $0D
		!Temp4 = "A"
	elseif !Temp3 == $10
		!Temp4 = "B"
	elseif !Temp3 == $20
		!Temp4 = "C"
	elseif !Temp3 == $40
		!Temp4 = "D Fast"
	else
		!Temp4 = "Invalid/Corrupt Value"
	endif
print "Path Reveal Speed: !Temp4"

;0 Slow		: 01
;1		: 02
;2		: 03
;3		: 04
;4		: 05
;5 Normal	: 06
;6		: 07
;7		: 08
;8		: 0A
;9		: 0B
;A		: 0D
;B		: 10
;C		: 20
;D Fast		: 40
else

endif
print "'Disable event path fade effect' setting is !Temp2."

;---------------------------------------------------------------------------

!VarOffset1 = $04F767

!Temp = readfile1("!hackname", snestopc(!VarOffset1)+!header)
!Temp2 = "unknown"

if !Temp == $8A
	!Temp2 = "off"
elseif !Temp == $22
	!Temp2 = "on"
endif
print "'Make lighting use colors from ROM instead of palette' setting is !Temp2."

;---------------------------------------------------------------------------

!VarOffset1 = $00A4E3
!VarOffset2 = $00A4E4
!VarOffset3 = $00A4EC
!VarOffset4 = $0FF9F0

if readfile1("!hackname", snestopc(!VarOffset1)+!header) == $22
	!Temp = readfile1("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header))+!header+$1B)
else
	!Temp = readfile1("!hackname", snestopc(!VarOffset3)+!header)
endif
!Temp2 = "unknown"

if !Temp == $07
	!Temp2 = "off"
elseif !Temp == $77
	!Temp2 = "on"
endif
print "'Merge GFX slots FG1 and FG2 into SP3 and SP4 to create room for 2 more FG slots.' setting is !Temp2."

;---------------------------------------------------------------------------

!VarOffset1  = $04EAD8

!Temp = readfile2("!hackname", snestopc(!VarOffset1)+!header)
!Temp2 = !Temp/$0120
!Temp3 = !Temp2*$08

print "Max 6x6 event tile area is: ",hex(!Temp2)," rows, ",hex(!Temp3)," Tiles (",hex(!Temp)," 8x8 tiles)"

;---------------------------------------------------------------------------

!VarOffset1 = $05B1A3
!VarOffset2 = $05A590
!VarOffset3 = $03BBA2

if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
	!Temp #= readfile1("!hackname", snestopc(!VarOffset2)+!header)
else
	!Temp #= readfile1("!hackname", snestopc(!VarOffset3)+!header)
endif
if !Temp >= $25
	!Temp #= !Temp+$DC
endif
print "Yellow Switch Palace Level Number: $",hex(!Temp)

;---------------------------------------------------------------------------

!VarOffset1 = $05B1A3
!VarOffset2 = $05A591
!VarOffset3 = $03BBA7

if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
	!Temp #= readfile1("!hackname", snestopc(!VarOffset2)+!header)
else
	!Temp #= readfile1("!hackname", snestopc(!VarOffset3)+!header)
endif
if !Temp >= $25
	!Temp #= !Temp+$DC
endif
print "Blue Switch Palace Level Number: $",hex(!Temp)

;---------------------------------------------------------------------------

!VarOffset1 = $05B1A3
!VarOffset2 = $05A592
!VarOffset3 = $03BBAC

if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
	!Temp #= readfile1("!hackname", snestopc(!VarOffset2)+!header)
else
	!Temp #= readfile1("!hackname", snestopc(!VarOffset3)+!header)
endif
if !Temp >= $25
	!Temp #= !Temp+$DC
endif
print "Red Switch Palace Level Number: $",hex(!Temp)

;---------------------------------------------------------------------------

!VarOffset1 = $05B1A3
!VarOffset2 = $05A593
!VarOffset3 = $03BBB1

if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
	!Temp #= readfile1("!hackname", snestopc(!VarOffset2)+!header)
else
	!Temp #= readfile1("!hackname", snestopc(!VarOffset3)+!header)
endif
if !Temp >= $25
	!Temp #= !Temp+$DC
endif
print "Green Switch Palace Level Number: $",hex(!Temp)

;---------------------------------------------------------------------------

!VarOffset1 = $05B1A3
!VarOffset2 = $05A5A6
!VarOffset3 = $03BB9B

if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
	!Temp #= readfile1("!hackname", snestopc(!VarOffset2)+!header)
else
	!Temp #= readfile1("!hackname", snestopc(!VarOffset3)+!header)
endif
if !Temp >= $25
	!Temp #= !Temp+$DC
endif
print "Yoshi's House Level Number: $",hex(!Temp)

;---------------------------------------------------------------------------

!VarOffset1 = $00AD2B

!Temp #= readfile2("!hackname", snestopc(!VarOffset1)+!header)-$1EA1
if !Temp >= $25
	!Temp #= !Temp+$DC
endif
print "Level number that triggers the Special World overworld palette change: $",hex(!Temp)

;---------------------------------------------------------------------------

!VarOffset1 = $02A986

!Temp #= readfile2("!hackname", snestopc(!VarOffset1)+!header)-$1EA2
if !Temp >= $25
	!Temp #= !Temp+$DC
endif
print "Level number that triggers the Special World koopa palette change: $",hex(!Temp)

;---------------------------------------------------------------------------

!VarOffset1 = $00AA74

!Temp #= readfile2("!hackname", snestopc(!VarOffset1)+!header)-$1EA2
if !Temp >= $25
	!Temp #= !Temp+$DC
endif
print "Level number that triggers the Special World graphics change: $",hex(!Temp)

;---------------------------------------------------------------------------

!VarOffset1 = $00C9A7

!Temp #= readfile1("!hackname", snestopc(!VarOffset1)+!header)
if !Temp >= $25
	!Temp #= !Temp+$DC
endif
print "Boss Sequence #1 Level Number: $",hex(!Temp)

;---------------------------------------------------------------------------

!VarOffset1 = $00C9A8

!Temp #= readfile1("!hackname", snestopc(!VarOffset1)+!header)
if !Temp >= $25
	!Temp #= !Temp+$DC
endif
print "Boss Sequence #2 Level Number: $",hex(!Temp)

;---------------------------------------------------------------------------

!VarOffset1 = $00C9A9

!Temp #= readfile1("!hackname", snestopc(!VarOffset1)+!header)
if !Temp >= $25
	!Temp #= !Temp+$DC
endif
print "Boss Sequence #3 Level Number: $",hex(!Temp)

;---------------------------------------------------------------------------

!VarOffset1 = $00C9AA

!Temp #= readfile1("!hackname", snestopc(!VarOffset1)+!header)
if !Temp >= $25
	!Temp #= !Temp+$DC
endif
print "Boss Sequence #4 Level Number: $",hex(!Temp)

;---------------------------------------------------------------------------

!VarOffset1 = $00C9AB

!Temp #= readfile1("!hackname", snestopc(!VarOffset1)+!header)
if !Temp >= $25
	!Temp #= !Temp+$DC
endif
print "Boss Sequence #5 Level Number: $",hex(!Temp)

;---------------------------------------------------------------------------

!VarOffset1 = $00C9AC

!Temp #= readfile1("!hackname", snestopc(!VarOffset1)+!header)
if !Temp >= $25
	!Temp #= !Temp+$DC
endif
print "Boss Sequence #6 Level Number: $",hex(!Temp)

;---------------------------------------------------------------------------

!VarOffset1 = $00C9AD

!Temp #= readfile1("!hackname", snestopc(!VarOffset1)+!header)
if !Temp >= $25
	!Temp #= !Temp+$DC
endif
print "Boss Sequence #7 Level Number: $",hex(!Temp)

;---------------------------------------------------------------------------

!VarOffset1 = $00C9AE

!Temp #= readfile1("!hackname", snestopc(!VarOffset1)+!header)
if !Temp >= $25
	!Temp #= !Temp+$DC
endif
print "End Game Sequence Level Number: $",hex(!Temp)

;---------------------------------------------------------------------------

!VarOffset1 = $00CA13

!Temp #= readfile1("!hackname", snestopc(!VarOffset1)+!header)
if !Temp >= $25
	!Temp #= !Temp+$DC
endif
print "End Game Sequence (Back Door) Level Number: $",hex(!Temp)

;---------------------------------------------------------------------------

!VarOffset1 = $04E660

!Temp #= readfile1("!hackname", snestopc(!VarOffset1)+!header)
if !Temp >= $25
	!Temp #= !Temp+$DC
endif
print "Earthquake Sequence Level Number: $",hex(!Temp)

;---------------------------------------------------------------------------

!VarOffset1 = $00CA0C

!Temp #= readfile1("!hackname", snestopc(!VarOffset1)+!header)
if !Temp >= $25
	!Temp #= !Temp+$DC
endif
print "Boss uses Secret Exit (Big Boo) Level Number: $",hex(!Temp)

endif

;---------------------------------------------------------------------------

print ""

check bankcross off
org $008000
db "LMR."
db !Region
db !CompressionSetting
db "..@.......!MWOProgram!LMVer1.!LMVer2!LMVer3..©"
dd !MWOYear
db ".Yoshifanatic..ASM.Master"
dd MusicList				: dd MusicListEnd-MusicList					; $0040-$0047
dd InitSpriteData			: dd InitSpriteDataEnd-InitSpriteData				; $0048-$004F
dd L1Tilemap				: dd L1TilemapEnd-L1Tilemap					; $0050-$0057
dd DestroyTileEvents			: dd DestroyTileEventsEnd-DestroyTileEvents			; $0058-$005F
dd DestroyTileL1Loc			: dd DestroyTileL1LocEnd-DestroyTileL1Loc			; $0060-$0067
dd DestroyTileVRAM			: dd DestroyTileVRAMEnd-DestroyTileVRAM				; $0068-$006F
dd OWPalettes				: dd OWPalettesEnd-OWPalettes					; $0070-$0077
dd SuperGFXBypass			: dd SuperGFXBypassEnd-SuperGFXBypass				; $0078-$007F
dd L1Map16				: dd L1Map16End-L1Map16						; $0080-$0087
dd L2Events				: dd L2EventsEnd-L2Events					; $0088-$008F
dd L2Tilemap				: dd L2TilemapEnd-L2Tilemap					; $0090-$0097
dd FishPos				: dd FishPosEnd-FishPos						; $0098-$009F
dd L2EventsProp				: dd L2EventsPropEnd-L2EventsProp				; $00A0-$00A7
dd L2EventsTilemap			: dd L2EventsTilemapEnd-L2EventsTilemap				; $00A8-$00AF
dd L1LevelNums				: dd L1LevelNumsEnd-L1LevelNums					; $00B0-$00B7
dd EventFlags				: dd EventFlagsEnd-EventFlags					; $00B8-$00BF
dd UnknownEventData			: dd UnknownEventDataEnd-UnknownEventData			; $00C0-$00C7
dd LevelNames				: dd LevelNamesEnd-LevelNames					; $00C8-$00CF
dd L2EventPtrs				: dd L2EventPtrsEnd-L2EventPtrs					; $00D0-$00D7
dd SmokeSpritePos			: dd SmokeSpritePosEnd-SmokeSpritePos 				; $00D8-$00DF
dd MessageText1				: dd MessageText1End-MessageText1				; $00E0-$00E7
dd StarPipeExits			: dd StarPipeExitsEnd-StarPipeExits				; $00E8-$00EF
dd PathExits				: dd PathExitsEnd-PathExits					; $00F0-$00F7
dd NoAutoMove				: dd NoAutoMoveEnd-NoAutoMove					; $00F8-$00FF
dd LevelEventNums			: dd LevelEventNumsEnd-LevelEventNums				; $0100-$0107
dd SilentEventPtrs			: dd SilentEventPtrsEnd-SilentEventPtrs				; $0108-$010F
dd SilentEventTileNumbers		: dd SilentEventTileNumbersEnd-SilentEventTileNumbers		; $0110-$0117
dd SilentEventTilemapLocations		: dd SilentEventTilemapLocationsEnd-SilentEventTilemapLocations	; $0118-$011F
dd SilentEventLayers			: dd SilentEventLayersEnd-SilentEventLayers			; $0120-$0127
dd InitLevelFlags			: dd InitLevelFlagsEnd-InitLevelFlags				; $0128-$012F
dd InitPlayerPos			: dd InitPlayerPosEnd-InitPlayerPos				; $0130-$0137
dd CustomSprites			: dd CustomSpritesEnd-CustomSprites				; $0138-$013F
dd GlobalOWExAnimation			: dd GlobalOWExAnimationEnd-GlobalOWExAnimation			; $0140-$0147
dd MainMapExAnimation			: dd MainMapExAnimationEnd-MainMapExAnimation			; $0148-$014F
dd YISubmapExAnimation			: dd YISubmapExAnimationEnd-YISubmapExAnimation			; $0150-$0157
dd VDSubmapExAnimation			: dd VDSubmapExAnimationEnd-VDSubmapExAnimation			; $0158-$015F
dd FoISubmapExAnimation			: dd FoISubmapExAnimationEnd-FoISubmapExAnimation		; $0160-$0167
dd VoBSubmapExAnimation			: dd VoBSubmapExAnimationEnd-VoBSubmapExAnimation		; $0168-$016F
dd SPWSubmapExAnimation			: dd SPWSubmapExAnimationEnd-SPWSubmapExAnimation		; $0170-$0177
dd SRSubmapExAnimation			: dd SRSubmapExAnimationEnd-SRSubmapExAnimation			; $0178-$017F
dd OWExAnimationSettings		: dd OWExAnimationSettingsEnd-OWExAnimationSettings		; $0180-$0187
dd SpecialWorldTriggers			: dd SpecialWorldTriggersEnd-SpecialWorldTriggers		; $0188-$018F
dd SpecialMessageLevels			: dd SpecialMessageLevelsEnd-SpecialMessageLevels		; $0190-$0197
dd BossSequenceLevels			: dd BossSequenceLevelsEnd-BossSequenceLevels			; $0198-$019F
dd RevealTileList			: dd RevealTileListEnd-RevealTileList				; $01A0-$01A7
dd MiscSettings				: dd MiscSettingsEnd-MiscSettings				; $01A8-$01AF
dd CDCustceneText			: dd CDCustceneTextEnd-CDCustceneText				; $01B0-$01B7
dd CDCustceneTextPtrs			: dd CDCustceneTextPtrsEnd-CDCustceneTextPtrs			; $01B8-$01BF
dd L2TileProp				: dd L2TilePropEnd-L2TileProp					; $01C0-$01C7
dd CreditsLayer3			: dd CreditsLayer3End-CreditsLayer3				; $01C8-$01CF
dd TitleScreenDemoMoves			: dd TitleScreenDemoMovesEnd-TitleScreenDemoMoves		; $01D0-$01D7
dd TitleScreenLayer3			: dd TitleScreenLayer3End-TitleScreenLayer3			; $01D8-$01DF
dd MessageTextPtrs			: dd MessageTextPtrsEnd-MessageTextPtrs				; $01E0-$01E7
dd KoopaKidTeleportLoc			: dd KoopaKidTeleportLocEnd-KoopaKidTeleportLoc			; $01E8-$01EF
dd KoopaKidPos				: dd KoopaKidPosEnd-KoopaKidPos					; $01F0-$01F7
dd KoopaKidTiles			: dd KoopaKidTilesEnd-KoopaKidTiles				; $01F8-$01FF
dd UnknownL1Data			: dd UnknownL1DataEnd-UnknownL1Data				; $0200-$0207
dd UnknownStripeData			: dd UnknownStripeDataEnd-UnknownStripeData			; $0208-$020F
dd UnknownDestroyTileData		: dd UnknownDestroyTileDataEnd-UnknownDestroyTileData		; $0210-$0217
dd LightningDisableSetting		: dd LightningDisableSettingEnd-LightningDisableSetting		; $0218-$021F
dd FileEnd				: dd $00000000							; $0220-$0227
dd FileEnd				: dd $00000000							; $0228-$022F
dd FileEnd				: dd $00000000							; $0230-$0237
dd FileEnd				: dd $00000000							; $0238-$023F
dd FileEnd				: dd $00000000							; $0240-$0247
dd FileEnd				: dd $00000000							; $0248-$024F
dd FileEnd				: dd $00000000							; $0250-$0257
dd FileEnd				: dd $00000000							; $0258-$025F
dd FileEnd				: dd $00000000							; $0260-$0267
dd FileEnd				: dd $00000000							; $0268-$026F
dd FileEnd				: dd $00000000							; $0270-$0277
dd FileEnd				: dd $00000000							; $0278-$027F
dd FileEnd				: dd $00000000							; $0280-$0287
dd FileEnd				: dd $00000000							; $0288-$028F
dd FileEnd				: dd $00000000							; $0290-$0297
dd FileEnd				: dd $00000000							; $0298-$029F
dd FileEnd				: dd $00000000							; $02A0-$02A7
dd FileEnd				: dd $00000000							; $02A8-$02AF
dd FileEnd				: dd $00000000							; $02B0-$02B7
dd FileEnd				: dd $00000000							; $02B8-$02BF
dd FileEnd				: dd $00000000							; $02C0-$02C7
dd FileEnd				: dd $00000000							; $02C8-$02CF
dd FileEnd				: dd $00000000							; $02D0-$02D7
dd FileEnd				: dd $00000000							; $02D8-$02DF
dd FileEnd				: dd $00000000							; $02E0-$02E7
dd FileEnd				: dd $00000000							; $02E8-$02EF
dd FileEnd				: dd $00000000							; $02F0-$02F7
dd FileEnd				: dd $00000000							; $02F8-$02FF

;#############################################################################################################
;#############################################################################################################

;Overworld Data

FileStart:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $048D8A
!VarOffset2 = $048D91

MusicList:
incbin "!hackname":(snestopc(!VarOffset1)+!header)-(snestopc(!VarOffset2)+!header)
print "Extracted ", bytes," bytes from the Overworld Music Table at !VarOffset1"
MusicListEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $04F625
!VarOffset2 = $04F675

InitSpriteData:
incbin "!hackname":(snestopc(!VarOffset1)+!header)-(snestopc(!VarOffset2)+!header)
print "Extracted ", bytes," bytes from the Initial Overworld Sprite Data Table at !VarOffset1"
InitSpriteDataEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $04FC1E
!VarOffset2 = $04FC26

SmokeSpritePos:
incbin "!hackname":(snestopc(!VarOffset1)+!header)-(snestopc(!VarOffset2)+!header)
print "Extracted ", bytes," bytes from the Overworld Smoke Position Table at !VarOffset1"
SmokeSpritePosEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $04FA2E
!VarOffset2 = $04FA3A

FishPos:
incbin "!hackname":(snestopc(!VarOffset1)+!header)-(snestopc(!VarOffset2)+!header)
print "Extracted ", bytes," bytes from the Overworld Fish Position Table at !VarOffset1"
FishPosEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $0CF7DF
!VarOffset2 = $0CFFDF

L1Tilemap:
incbin "!hackname":(snestopc(!VarOffset1)+!header)-(snestopc(!VarOffset2)+!header)
print "Extracted ", bytes," bytes from the Overworld Layer 1 Tilemap Data at !VarOffset1"
L1TilemapEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $04E67C
!VarOffset2 = $04E5D6

DestroyTileEvents:
!offset1 #= readfile3("!hackname", snestopc(!VarOffset1)+!header)
if !offset1&$7FFFFF == !VarOffset2
	!offset2 #= (!offset1+$10)|$008000
else
	!offset2 #= (readfile2("!hackname", snestopc(!offset1)+!header-$04)+!offset1+$01)|$008000
endif
incbin "!hackname":(snestopc(!offset1)+!header)-(snestopc(!offset2)+!header)
print "Extracted ", bytes," bytes from the Destroy Tile Event Number Table at $",hex(!offset1)
DestroyTileEventsEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $04E69C
!VarOffset2 = $04E5B6

DestroyTileL1Loc:
!offset1 #= readfile3("!hackname", snestopc(!VarOffset1)+!header)
if !offset1&$7FFFFF == !VarOffset2
	!offset2 #= (!offset1+$20)|$008000
else
	!offset2 #= (readfile2("!hackname", snestopc(!offset1)+!header-$04)+!offset1+$01)|$008000
endif
incbin "!hackname":(snestopc(!offset1)+!header)-(snestopc(!offset2)+!header)
print "Extracted ", bytes," bytes from the Destroy Tile Layer 1 Locations Table at $",hex(!offset1)
DestroyTileL1LocEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $04EEC9
!VarOffset2 = $04E587

DestroyTileVRAM:
!offset1 #= readfile3("!hackname", snestopc(!VarOffset1)+!header)
if !offset1&$7FFFFF == !VarOffset2
	!offset2 #= (!offset1+$20)|$008000
else
	!offset2 #= (readfile2("!hackname", snestopc(!offset1)+!header-$04)+!offset1+$01)|$008000
endif
incbin "!hackname":(snestopc(!offset1)+!header)-(snestopc(!offset2)+!header)
print "Extracted ", bytes," bytes from the Destroy Tile Layer 1 VRAM Locations Table at $",hex(!offset1)
DestroyTileVRAMEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $00AD32
!VarOffset2 = $00AD33
!LMDataName = "Overworld Palette Data"

OWPalettes:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
	print "This ROM's overworld has no custom palette to extract."
else
	!offset1 #= (readfile2("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header))+!header+$12))+(readfile1("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header))+!header+$1E)*$10000)
	%InsertExpandedAreaBlock(!LMDataName)
endif
OWPalettesEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $0FFAB8
!VarOffset2 = $0FFAB9
!VarOffset3 = $0FFAC2

SuperGFXBypass:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) == $FF
	db $14,$00,$7F,$00,$7F,$00,$7F,$00,$1E,$00,$08,$00,$1D,$00,$1C,$00
	db $1D,$00,$1C,$00,$0F,$00,$10,$00,$2B,$00,$2A,$00,$29,$00,$28,$00
	db $14,$00,$7F,$00,$7F,$00,$7F,$00,$1E,$00,$08,$00,$1D,$00,$1C,$00
	db $1D,$00,$1C,$00,$0F,$00,$10,$00,$2B,$00,$2A,$00,$29,$00,$28,$00
	db $14,$00,$7F,$00,$7F,$00,$7F,$00,$1E,$00,$08,$00,$1D,$00,$1C,$00
	db $1D,$00,$1C,$00,$0F,$00,$10,$00,$2B,$00,$2A,$00,$29,$00,$28,$00
	db $14,$00,$7F,$00,$7F,$00,$7F,$00,$1E,$00,$08,$00,$1D,$00,$1C,$00
	db $1D,$00,$1C,$00,$0F,$00,$10,$00,$2B,$00,$2A,$00,$29,$00,$28,$00
	db $14,$00,$7F,$00,$7F,$00,$7F,$00,$1E,$00,$08,$00,$1D,$00,$1C,$00
	db $1D,$00,$1C,$00,$0F,$00,$10,$00,$2B,$00,$2A,$00,$29,$00,$28,$00
	db $14,$00,$7F,$00,$7F,$00,$7F,$00,$1E,$00,$08,$00,$1D,$00,$1C,$00
	db $1D,$00,$1C,$00,$0F,$00,$10,$00,$2B,$00,$2A,$00,$29,$00,$28,$00
	db $14,$00,$7F,$00,$7F,$00,$7F,$00,$1E,$00,$08,$00,$1D,$00,$1C,$00
	db $1D,$00,$1C,$00,$0F,$00,$10,$00,$2B,$00,$2A,$00,$29,$00,$28,$00
	print "Generated the default ", bytes," bytes for the Overworld SuperGFXBypass Table."
else
	!offset1 #= (readfile2("!hackname", snestopc(!VarOffset2)+!header))+(readfile1("!hackname", snestopc(!VarOffset3)+!header)*$10000)
	!offset2 #= (!offset1+$E0)|$008000
	incbin "!hackname":(snestopc(!offset1)+!header)-(snestopc(!offset2)+!header)
	print "Extracted ", bytes," bytes from the Overworld SuperGFXBypass Table at $",hex(!offset1)
endif
SuperGFXBypassEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $04DCBC
!VarOffset2 = $04DCC1
!VarOffset3 = $05D000

L1Map16:
!offset1 #= ((readfile2("!hackname", snestopc(!VarOffset1)+!header))+(readfile1("!hackname", snestopc(!VarOffset2)+!header)*$10000))
if !offset1&$7FFFFF == !VarOffset3
	!offset2 #= (!offset1+$0608)|$008000
else
	!offset2 #= (readfile2("!hackname", snestopc(!offset1)+!header-$04)+!offset1+$01)|$008000
endif
incbin "!hackname":(snestopc(!offset1)+!header)-(snestopc(!offset2)+!header)
print "Extracted ", bytes," bytes from the Overworld Layer 1 Map16 Data at $",hex(!offset1)
L1Map16End:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $04E49F
!VarOffset2 = $04DD8D

L2Events:
!offset1 #= readfile3("!hackname", snestopc(!VarOffset1)+!header)
if !offset1&$7FFFFF == !VarOffset2
	!offset2 #= (!offset1+$05CC)|$008000
else
	!offset2 #= (readfile2("!hackname", snestopc(!offset1)+!header-$04)+!offset1+$01)|$008000
endif
incbin "!hackname":(snestopc(!offset1)+!header)-(snestopc(!offset2)+!header)
print "Extracted ", bytes," bytes from the Overworld Layer 2 Event Table at $",hex(!offset1)
L2EventsEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $04DC72
!VarOffset2 = $04DC79
!VarOffset3 = $04A533
!VarOffset4 = $04D678
!VarOffset5 = $04DC8D
!VarOffset6 = $04C02B

L2Tilemap:
!offset1 #= ((readfile2("!hackname", snestopc(!VarOffset1)+!header))+(readfile1("!hackname", snestopc(!VarOffset2)+!header)*$10000))
!offset3 #= ((readfile2("!hackname", snestopc(!VarOffset5)+!header))+(readfile1("!hackname", snestopc(!VarOffset2)+!header)*$10000))
if !offset1&$7FFFFF == !VarOffset3
	!offset2 #= (!offset1+$1AF8)|$008000
else
	!offset2 #= !offset3|$008000
endif
incbin "!hackname":(snestopc(!offset1)+!header)-(snestopc(!offset2)+!header)
print "Extracted ", bytes," bytes from the Overworld Layer 2 Tilemap Data at $",hex(!offset1)
L2TilemapEnd:

L2TileProp:
if !offset3&$7FFFFF == !VarOffset6
	!offset4 #= (!offset3+$164D)|$008000
else
	!offset4 #= (readfile2("!hackname", snestopc(!offset1)+!header-$04)+!offset1+$01)|$008000
endif
incbin "!hackname":(snestopc(!offset3)+!header)-(snestopc(!offset4)+!header)
print "Extracted ", bytes," bytes from the Overworld Layer 2 Tile Properties Data at $",hex(!offset3)
L2TilePropEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $04DD45
!VarOffset2 = $04DD4A
!VarOffset3 = $0C8D00

L2EventsProp:
!offset1 #= (readfile2("!hackname", snestopc(!VarOffset1)+!header))+(readfile1("!hackname", snestopc(!VarOffset2)+!header)*$10000)
if !offset1&$7FFFFF == !VarOffset3
	!offset2 #= (!offset1+$066A)|$008000
else
	!offset2 #= (readfile2("!hackname", snestopc(!offset1)+!header-$04)+!offset1+$01)|$008000
endif
incbin "!hackname":(snestopc(!offset1)+!header)-(snestopc(!offset2)+!header)
print "Extracted ", bytes," bytes from the Overworld Layer 2 Event Tile Properties Data at $",hex(!offset1)
L2EventsPropEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $04E4BB
!VarOffset2 = $04E4B0
!VarOffset3 = $0C8000

L2EventsTilemap:
!offset1 #= (readfile2("!hackname", snestopc(!VarOffset1)+!header))+(readfile1("!hackname", snestopc(!VarOffset2)+!header)*$10000)
if !offset1&$7FFFFF == !VarOffset3
	!offset2 #= (!offset1+$0D00)|$008000
else
	!offset2 #= (readfile2("!hackname", snestopc(!offset1)+!header-$04)+!offset1+$01)|$008000
endif
incbin "!hackname":(snestopc(!offset1)+!header)-(snestopc(!offset2)+!header)
print "Extracted ", bytes," bytes from the Overworld Layer 2 Event Tilemap Data at $",hex(!offset1)
L2EventsTilemapEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $04D803
!VarOffset2 = $04D808
!VarOffset3 = $04D7F9
!LMDataName = "Overworld Layer 1 Translevel Numbers Table"

L1LevelNums:
!offset1 #= ((readfile2("!hackname", snestopc(!VarOffset1)+!header))+(readfile1("!hackname", snestopc(!VarOffset2)+!header)*$10000))
if readfile1("!hackname", snestopc(!VarOffset3)+!header) != $A2
	if !CompressionSetting == $02
		db $EC,$3B,$02,$01,$00,$02,$EC,$45,$00,$03,$7E,$00,$04,$62,$00,$05
		db $EC,$20,$02,$06,$00,$07,$62,$02,$08,$00,$09,$70,$00,$0A,$EC,$49
		db $00,$0B,$62,$02,$0C,$00,$0D,$62,$00,$0E,$78,$00,$0F,$61,$00,$10
		db $EC,$2B,$00,$11,$EC,$6A,$00,$12,$75,$00,$13,$69,$00,$14,$61,$00
		db $15,$70,$00,$16,$EC,$4C,$00,$17,$67,$00,$18,$73,$00,$19,$EC,$27
		db $00,$1A,$61,$00,$1B,$7B,$00,$1C,$61,$00,$1D,$EC,$23,$02,$1E,$00
		db $1F,$EC,$20,$A3,$00,$A5,$EC,$38,$00,$21,$61,$00,$22,$EC,$49,$02
		db $23,$00,$24,$EC,$72,$00,$25,$EC,$20,$00,$26,$7C,$00,$27,$6B,$A2
		db $02,$12,$69,$00,$29,$64,$00,$2A,$EC,$3D,$00,$2B,$76,$00,$2C,$61
		db $00,$2D,$67,$00,$2E,$EC,$22,$00,$2F,$EC,$22,$00,$30,$61,$02,$31
		db $00,$32,$79,$00,$33,$A3,$F6,$00,$35,$77,$02,$36,$00,$37,$61,$04
		db $38,$00,$39,$00,$3A,$7A,$00,$3B,$EC,$6F,$00,$3C,$62,$00,$3D,$77
		db $00,$3E,$63,$00,$3F,$F4,$47,$00,$3D,$62,$02,$41,$00,$42,$EC,$2A
		db $00,$43,$64,$02,$44,$00,$45,$76,$00,$46,$62,$00,$47,$EC,$47,$02
		db $48,$00,$49,$61,$00,$4A,$61,$00,$4B,$61,$B4,$05,$39,$02,$4D,$00
		db $4E,$61,$00,$4F,$A4,$00,$E3,$00,$51,$EC,$29,$A2,$D0,$77,$00,$53
		db $61,$04,$54,$00,$55,$00,$56,$61,$00,$57,$B9,$02,$A5,$62,$00,$59
		db $6B,$00,$5A,$79,$00,$5B,$68,$BB,$05,$7B,$EC,$43,$43,$C0,$00,$F4
		db $64,$00,$40,$C3,$05,$34,$F0,$21,$EA,$85,$C5,$81,$CB,$91,$03,$28
		db $F8,$23,$05,$34,$F0,$2A,$08,$5E,$85,$08,$3C,$D9,$EE,$A2,$01,$30
		db $F0,$2C,$06,$2C,$F0,$49,$06,$2C,$F0,$38,$EB,$CA,$09,$54,$82,$A1
		db $00,$80,$70,$91,$91,$EC,$85,$9F,$06,$2C,$F0,$24,$0A,$27,$00,$20
		db $F0,$22,$A6,$F8,$3C,$E8,$94,$0A,$12,$EC,$38,$00,$60,$B2,$00,$D2
		db $EC,$A1,$F8,$5E,$08,$3C,$97,$DE,$82,$06,$2C,$88,$03,$28,$F0,$23
		db $06,$2C,$F8,$23,$C7,$A2,$00,$CD,$9C,$A6,$9D,$C3,$84,$08,$D1,$45
		db $80,$00,$F0,$3E,$0A,$C5,$EC,$4B,$83,$08,$A5,$98,$06,$2C,$C6,$0D
		db $34,$F0,$49,$06,$2C,$43,$E0,$00,$F4,$2D,$01,$06,$61,$02,$70,$00
		db $FF,$DA,$E9,$F0,$48,$0B,$B5,$00,$55,$83,$0A,$14,$88,$82,$96,$08
		db $71,$88,$82,$F0,$45,$09,$5C,$81,$F1,$00,$A0,$83,$05,$33,$A1,$FA
		db $75,$C5,$0B,$B3,$CC,$09,$54,$F0,$24,$0A,$27,$F8,$23,$0F,$11,$FF
	else
		db $E4,$3B,$00,$02,$01,$00,$02,$E4,$45,$00,$00,$03,$3E,$00,$00,$04
		db $22,$00,$00,$05,$E4,$20,$00,$02,$06,$00,$07,$22,$00,$02,$08,$00
		db $09,$30,$00,$00,$0A,$E4,$49,$00,$00,$0B,$22,$00,$02,$0C,$00,$0D
		db $22,$00,$00,$0E,$38,$00,$03,$0F,$00,$00,$10,$E4,$2B,$00,$00,$11
		db $E4,$6A,$00,$00,$12,$35,$00,$00,$13,$29,$00,$03,$14,$00,$00,$15
		db $30,$00,$00,$16,$E4,$4C,$00,$00,$17,$27,$00,$00,$18,$33,$00,$00
		db $19,$E4,$27,$00,$03,$1A,$00,$00,$1B,$3B,$00,$03,$1C,$00,$00,$1D
		db $E4,$23,$00,$02,$1E,$00,$1F,$E4,$20,$00,$00,$20,$E4,$3B,$00,$03
		db $21,$00,$00,$22,$E4,$49,$00,$02,$23,$00,$24,$E4,$72,$00,$00,$25
		db $E4,$20,$00,$00,$26,$3C,$00,$00,$27,$2B,$00,$00,$28,$2B,$00,$00
		db $29,$24,$00,$00,$2A,$E4,$3D,$00,$00,$2B,$36,$00,$03,$2C,$00,$00
		db $2D,$27,$00,$00,$2E,$E4,$22,$00,$00,$2F,$E4,$22,$00,$05,$30,$00
		db $00,$31,$00,$32,$39,$00,$05,$33,$00,$00,$34,$00,$35,$37,$00,$09
		db $36,$00,$37,$00,$00,$38,$00,$39,$00,$3A,$3A,$00,$00,$3B,$E4,$6F
		db $00,$00,$3C,$22,$00,$00,$3D,$37,$00,$00,$3E,$23,$00,$02,$3F,$00
		db $40,$E4,$48,$00,$02,$41,$00,$42,$E4,$2A,$00,$00,$43,$24,$00,$02
		db $44,$00,$45,$36,$00,$00,$46,$22,$00,$00,$47,$E4,$47,$00,$0B,$48
		db $00,$49,$00,$00,$4A,$00,$00,$4B,$00,$00,$4C,$33,$00,$0B,$4D,$00
		db $4E,$00,$00,$4F,$00,$00,$50,$00,$00,$51,$E4,$29,$00,$00,$52,$39
		db $00,$0A,$53,$00,$00,$54,$00,$55,$00,$56,$00,$00,$57,$36,$00,$00
		db $58,$24,$00,$00,$59,$2B,$00,$00,$5A,$39,$00,$00,$5B,$28,$00,$00
		db $5C,$E4,$5E,$00,$43,$C0,$00,$F0,$46,$07,$F7,$F0,$20,$05,$16,$F0
		db $22,$08,$3D,$85,$08,$3E,$00,$C0,$92,$03,$27,$83,$08,$A5,$F0,$48
		db $07,$F5,$87,$08,$3A,$99,$08,$3E,$01,$D0,$00,$F0,$2D,$06,$2B,$F0
		db $49,$06,$2C,$F0,$38,$09,$62,$00,$D0,$8C,$09,$7A,$00,$80,$30,$00
		db $91,$0A,$15,$E4,$85,$00,$9F,$06,$2C,$F0,$24,$0A,$27,$00,$20,$F0
		db $22,$0A,$26,$F0,$3C,$06,$2C,$94,$0A,$12,$E4,$38,$00,$02,$60,$00
		db $90,$E4,$B2,$00,$F0,$46,$08,$3E,$F0,$2F,$08,$6D,$00,$40,$8A,$03
		db $26,$F0,$23,$06,$2C,$F0,$23,$08,$3E,$00,$E0,$9E,$08,$83,$9D,$08
		db $3E,$84,$08,$D1,$45,$80,$00,$F0,$3E,$0A,$C5,$E4,$4B,$00,$83,$08
		db $A5,$98,$06,$2C,$00,$E0,$F0,$4F,$09,$7E,$43,$E0,$00,$E4,$29,$00
		db $85,$0A,$07,$02,$70,$00,$FF,$9A,$09,$6D,$F0,$48,$0B,$B5,$00,$55
		db $83,$0A,$14,$88,$0F,$13,$96,$08,$71,$88,$0F,$33,$F0,$45,$09,$5C
		db $02,$80,$00,$A0,$83,$05,$33,$00,$AA,$98,$0B,$9C,$8E,$0A,$03,$F0
		db $26,$0A,$25,$00,$55,$E4,$22,$00,$FF	
	endif
	print "Generated the default ", bytes," bytes for the !LMDataName."
else
	%InsertExpandedAreaBlock(!LMDataName)
endif
L1LevelNumsEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $04D822
!VarOffset2 = $04D827
!VarOffset3 = $04D7F9

UnknownL1Data:
!offset1 #= ((readfile2("!hackname", snestopc(!VarOffset1)+!header))+(readfile1("!hackname", snestopc(!VarOffset2)+!header)*$10000))
if readfile1("!hackname", snestopc(!VarOffset3)+!header) != $A2
	if !CompressionSetting == $02
		db $EF,$FF,$EF,$FF,$FF
	else
		db $E7,$FF,$00,$E7,$FF,$00,$FF
	endif
	print "Generated the default ", bytes," bytes for the Unknown Overworld Layer 1 Data."
else
	!offset2 #= (readfile2("!hackname", snestopc(!offset1)+!header-$04)+!offset1+$01)|$008000
incbin "!hackname":(snestopc(!offset1)+!header)-(snestopc(!offset2)+!header)
print "Extracted ", bytes," bytes from the Unknown Overworld Layer 1 Data at $",hex(!offset1)
endif
UnknownL1DataEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $04ECBA
!VarOffset2 = $04D85D

EventFlags:
!offset1 #= readfile3("!hackname", snestopc(!VarOffset1)+!header)
if !offset1&$7FFFFF == !VarOffset2
	!offset2 #= (!offset1+$E0)|$008000
else
	!offset2 #= (readfile2("!hackname", snestopc(!offset1)+!header-$04)+!offset1+$01)|$008000
endif
incbin "!hackname":(snestopc(!offset1)+!header)-(snestopc(!offset2)+!header)
print "Extracted ", bytes," bytes from the Overworld Event Flags Table at $",hex(!offset1)
EventFlagsEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $04EDB8
!VarOffset2 = $04D93D

UnknownEventData:
!offset1 #= readfile3("!hackname", snestopc(!VarOffset1)+!header)
if !offset1&$7FFFFF == !VarOffset2
	!offset2 #= (!offset1+$E0)|$008000
else
	!offset2 #= (readfile2("!hackname", snestopc(!offset1)+!header-$04)+!offset1+$01)|$008000
endif
incbin "!hackname":(snestopc(!offset1)+!header)-(snestopc(!offset2)+!header)
print "Extracted ", bytes," bytes from the Unknown Overworld Event Data Table at $",hex(!offset1)
UnknownEventDataEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $04E6DE
!VarOffset2 = $04E359

L2EventPtrs:
!offset1 #= readfile3("!hackname", snestopc(!VarOffset1)+!header)
if !offset1&$7FFFFF == !VarOffset2
	!offset2 #= (!offset1+$F2)|$008000
else
	!offset2 #= (readfile2("!hackname", snestopc(!offset1)+!header-$04)+!offset1+$01)|$008000
endif
incbin "!hackname":(snestopc(!offset1)+!header)-(snestopc(!offset2)+!header)
print "Extracted ", bytes," bytes from the Layer 2 Event Pointer Table at $",hex(!offset1)
L2EventPtrsEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $048509
!VarOffset2 = $048431
!VarOffset3 = $04850A
!LMDataName = "Star/Pipe Index Table"

StarPipeExits:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
	!offset1 = !VarOffset2
	!offset2 #= (!offset1+$D8)|$008000
	incbin "!hackname":(snestopc(!offset1)+!header)-(snestopc(!offset2)+!header)
	print "Extracted ", bytes," bytes from the !LMDataName at !VarOffset2"
elseif readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset3)+!header))+!header+$17)&$7FFFFF == !VarOffset2
	!offset1 = !VarOffset2
	!offset2 #= (!offset1+$D8)|$008000
	incbin "!hackname":(snestopc(!offset1)+!header)-(snestopc(!offset2)+!header)
	print "Extracted ", bytes," bytes from the !LMDataName at !VarOffset2"
else
	!offset1 #= readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset3)+!header))+!header+$17)
	%InsertExpandedAreaBlock(!LMDataName)
endif
StarPipeExitsEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $049A35
!VarOffset2 = $049964
!VarOffset3 = $049A36

PathExits:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
	!offset1 #= !VarOffset2
	!offset2 #= (!offset1+$A8)|$008000
else
	!offset1 #= readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset3)+!header))+!header+$11)
	!offset2 #= (readfile2("!hackname", snestopc(!offset1)+!header-$04)+!offset1+$01)|$008000
endif
incbin "!hackname":(snestopc(!offset1)+!header)-(snestopc(!offset2)+!header)
print "Extracted ", bytes," bytes from the Path Exit Index Table at $",hex(!offset1)
PathExitsEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $04906C
!VarOffset2 = $049078

NoAutoMove:
incbin "!hackname":(snestopc(!VarOffset1)+!header)-(snestopc(!VarOffset2)+!header)
print "Extracted ", bytes," bytes from the No-Auto Move Level Table at !VarOffset1"
NoAutoMoveEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $05D608
!VarOffset2 = $05D668

LevelEventNums:
incbin "!hackname":(snestopc(!VarOffset1)+!header)-(snestopc(!VarOffset2)+!header)
print "Extracted ", bytes," bytes from the Level Event Numbers Table at !VarOffset1"
LevelEventNumsEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $04E9F7
!VarOffset2 = $04E9F8
!LMDataName = "Silent Event Pointer Table"

SilentEventPtrs:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
	db $00,$00,$00,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$12,$00
	db $12,$00,$12,$00,$12,$00,$12,$00,$12,$00,$12,$00,$12,$00,$12,$00
	db $18,$00,$18,$00,$18,$00,$1E,$00,$1E,$00,$28,$00,$28,$00,$28,$00
	db $28,$00,$28,$00,$28,$00,$28,$00,$28,$00,$2A,$00,$32,$00,$32,$00
	db $32,$00,$32,$00,$32,$00,$32,$00,$32,$00,$36,$00,$36,$00,$36,$00
	db $36,$00,$36,$00,$36,$00,$36,$00,$36,$00,$36,$00,$36,$00,$36,$00
	db $40,$00,$40,$00,$40,$00,$40,$00,$40,$00,$46,$00,$46,$00,$46,$00
	db $46,$00,$46,$00,$46,$00,$46,$00,$46,$00,$46,$00,$46,$00,$46,$00
	db $46,$00,$46,$00,$46,$00,$46,$00,$46,$00,$46,$00,$46,$00,$46,$00
	db $48,$00,$48,$00,$48,$00,$48,$00,$48,$00,$48,$00,$48,$00,$4C,$00
	db $4C,$00,$4C,$00,$4C,$00,$4C,$00,$4C,$00,$4E,$00,$50,$00,$50,$00
	db $52,$00,$54,$00,$54,$00,$54,$00,$54,$00,$54,$00,$56,$00,$56,$00
	db $56,$00,$56,$00,$56,$00,$56,$00,$56,$00,$56,$00,$56,$00,$56,$00
	db $56,$00,$56,$00,$56,$00,$56,$00,$56,$00,$58,$00,$58,$00,$58,$00
	db $58,$00,$58,$00,$58,$00,$58,$00,$58,$00,$58,$00,$58,$00,$58,$00
	db $58,$00
	print "Generated the default ", bytes," bytes for the !LMDataName."
else
	!offset1 #= readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header))+!header+$0D)
	%InsertExpandedAreaBlock(!LMDataName)
endif
SilentEventPtrsEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $04E9F7
!VarOffset2 = $04E9F8
!LMDataName = "Silent Event Tile Number Table"

SilentEventTileNumbers:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
	db $79,$00,$28,$09,$38,$09,$81,$00,$00,$00,$25,$00,$24,$00,$24,$00
	db $68,$00,$69,$00,$30,$0A,$A8,$0A,$66,$00,$28,$09,$38,$09,$FC,$09
	db $F8,$09,$28,$09,$9C,$09,$66,$00,$68,$00,$66,$00,$28,$09,$98,$09
	db $98,$09,$38,$09,$38,$09,$98,$09,$98,$09,$88,$0A,$84,$0A,$80,$0A
	db $8C,$0A,$98,$09,$94,$09,$66,$00,$66,$00,$84,$03,$5F,$00,$5F,$00
	db $5F,$00,$5F,$00,$5F,$00,$A0,$09
	print "Generated the default ", bytes," bytes for the !LMDataName."
else
	!offset1 #= readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header))+!header+$22)
	%InsertExpandedAreaBlock(!LMDataName)
endif
SilentEventTileNumbersEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $04E9F7
!VarOffset2 = $04E9F8
!LMDataName = "Silent Event Tilemap Location Table"

SilentEventTilemapLocations:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
	db $12,$02,$94,$10,$14,$11,$75,$02,$65,$02,$55,$02,$45,$02,$35,$02
	db $15,$02,$25,$06,$14,$31,$94,$31,$10,$05,$80,$28,$00,$29,$A4,$06
	db $28,$07,$24,$05,$A4,$05,$A9,$00,$54,$01,$3C,$00,$B0,$01,$AC,$01
	db $A8,$01,$20,$33,$A0,$32,$26,$19,$2A,$19,$2E,$19,$B0,$18,$30,$18
	db $1C,$18,$20,$18,$24,$18,$97,$05,$7B,$05,$EC,$2A,$F0,$01,$F0,$01
	db $04,$03,$04,$03,$27,$02,$16,$1D
	print "Generated the default ", bytes," bytes for the !LMDataName."
else
	!offset1 #= readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header))+!header+$28)
	%InsertExpandedAreaBlock(!LMDataName)
endif
SilentEventTilemapLocationsEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $04E9F7
!VarOffset2 = $04E9F8
!LMDataName = "Silent Event Tile Layer Table"

SilentEventLayers:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
	db $00,$01,$01,$00,$00,$00,$00,$00,$00,$00,$01,$01,$00,$01,$01,$01
	db $01,$01,$01,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
	db $01,$01,$01,$00,$00,$01,$00,$00,$00,$00,$00,$01
	print "Generated the default ", bytes," bytes for the !LMDataName."
else
	!offset1 #= readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header))+!header+$34)
	%InsertExpandedAreaBlock(!LMDataName)
endif
SilentEventLayersEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $009F19
if !ExtraOverworldLevelsAndEvents == !FALSE
	!VarOffset2 = $05DDA0
	!VarOffset3 = $05DE00
else
	!VarOffset2 = $03BE80
	!VarOffset3 = $03BF80
endif

InitLevelFlags:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$03,$00,$00,$00,$00,$00,$00,$00
	db $01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$00,$00
	db $00,$00,$01,$01,$00,$00,$00,$04,$00,$00,$00,$08,$02,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	print "Generated the default ", bytes," bytes for the Initial Overworld Level Flags Table."
else
	incbin "!hackname":(snestopc(!VarOffset2)+!header)-(snestopc(!VarOffset3)+!header)
	print "Extracted ", bytes," bytes from the Initial Overworld Level Flags Table at !VarOffset2"
endif
InitLevelFlagsEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $009EF0
!VarOffset2 = $009F06

InitPlayerPos:
incbin "!hackname":(snestopc(!VarOffset1)+!header)-(snestopc(!VarOffset2)+!header)
print "Extracted ", bytes," bytes from the Init OW Player Position Table at !VarOffset1"
InitPlayerPosEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $0EF55D
!LMDataName = "Overworld Custom Sprite Data"

CustomSprites:
	!offset1 #= readfile3("!hackname", snestopc(!VarOffset1)+!header)
if !offset1 == $FFFFFF
	print "This ROM's overworld has no custom sprite data to extract."
else
	%InsertExpandedAreaBlock(!LMDataName)
endif
CustomSpritesEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $048086
!VarOffset2 = $048087
!LMDataName = "Global Overworld ExAnimation Data"

GlobalOWExAnimation:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
elseif readfile2("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header)+$57)+!header) == $0000
	print "This ROM's overworld has no Global ExAnimation data to extract."
else
	!offset1 #= (readfile1("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header)+$58)+!header)*$10000)|(readfile2("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header)+$61)+!header))
	%InsertExpandedAreaBlock(!LMDataName)
endif
GlobalOWExAnimationEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $048086
!VarOffset2 = $048087
!LMDataName = "Main Map ExAnimation Data"

MainMapExAnimation:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
elseif readfile2("!hackname",snestopc(readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header)+$D6)+!header)+$00)+!header) == $0000
	print "The Main Map has no ExAnimation data to extract."
else
	!offset1 #= readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header)+$E1)+!header)+$00)+!header)
	%InsertExpandedAreaBlock(!LMDataName)
endif
MainMapExAnimationEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $048086
!VarOffset2 = $048087
!LMDataName = "Yoshi's Island ExAnimation Data"

YISubmapExAnimation:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
elseif readfile2("!hackname",snestopc(readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header)+$D6)+!header)+$03)+!header) == $0000
	print "The Yoshi's Island submap has no ExAnimation data to extract."
else
	!offset1 #= readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header)+$E1)+!header)+$03)+!header)
	%InsertExpandedAreaBlock(!LMDataName)
endif
YISubmapExAnimationEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $048086
!VarOffset2 = $048087
!LMDataName = "Vanilla Dome ExAnimation Data"

VDSubmapExAnimation:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
elseif readfile2("!hackname",snestopc(readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header)+$D6)+!header)+$06)+!header) == $0000
	print "The Vanilla Dome submap has no ExAnimation data to extract."
else
	!offset1 #= readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header)+$E1)+!header)+$06)+!header)
	%InsertExpandedAreaBlock(!LMDataName)
endif
VDSubmapExAnimationEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $048086
!VarOffset2 = $048087
!LMDataName = "Forest of Illusion ExAnimation Data"

FoISubmapExAnimation:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
elseif readfile2("!hackname",snestopc(readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header)+$D6)+!header)+$09)+!header) == $0000
	print "The Forest of Illusion submap has no ExAnimation data to extract."
else
	!offset1 #= readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header)+$E1)+!header)+$09)+!header)
	%InsertExpandedAreaBlock(!LMDataName)
endif
FoISubmapExAnimationEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $048086
!VarOffset2 = $048087
!LMDataName = "Valley of Bowser ExAnimation Data"

VoBSubmapExAnimation:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
elseif readfile2("!hackname",snestopc(readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header)+$D6)+!header)+$0C)+!header) == $0000
	print "The Valley of Bowser submap has no ExAnimation data to extract."
else
	!offset1 #= readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header)+$E1)+!header)+$0C)+!header)
	%InsertExpandedAreaBlock(!LMDataName)
endif
VoBSubmapExAnimationEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $048086
!VarOffset2 = $048087
!LMDataName = "Special World ExAnimation Data"

SPWSubmapExAnimation:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
elseif readfile2("!hackname",snestopc(readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header)+$D6)+!header)+$0F)+!header) == $0000
	print "The Special World submap has no ExAnimation data to extract."
else
	!offset1 #= readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header)+$E1)+!header)+$0F)+!header)
	%InsertExpandedAreaBlock(!LMDataName)
endif
SPWSubmapExAnimationEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $048086
!VarOffset2 = $048087
!LMDataName = "Star Road ExAnimation Data"

SRSubmapExAnimation:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
elseif readfile2("!hackname",snestopc(readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header)+$D6)+!header)+$12)+!header) == $0000
	print "The Star Road submap has no ExAnimation data to extract."
else
	!offset1 #= readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header)+$E1)+!header)+$12)+!header)
	%InsertExpandedAreaBlock(!LMDataName)
endif
SRSubmapExAnimationEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $048086
!VarOffset2 = $048087
!LMDataName = "Overworld ExAnimation Settings Table"

OWExAnimationSettings:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
	db $00,$00,$00,$00,$00,$00,$00
	print "Generated the default ", bytes," bytes for the Overworld ExAnimation Settings Table."
else
	!offset1 #= readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header)+$4A)+!header)
	%InsertExpandedAreaBlock(!LMDataName)
endif
OWExAnimationSettingsEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $00AD2B
!VarOffset2 = $02A986
!VarOffset3 = $00AA74	; Should also be applied to $019826, $01B9CD and $0CAE0E
			; Note: The third address listed has no equivalent in the Japanese SMW ROM.

SpecialWorldTriggers:
db readfile2("!hackname", snestopc(!VarOffset1)+!header)-$1EA2	; Level that triggers the Special World overworld palette change. Is 1 less than it would normally be.
db readfile2("!hackname", snestopc(!VarOffset2)+!header)-$1EA2	; Level that triggers the Special World koopa palette change.
db readfile2("!hackname", snestopc(!VarOffset3)+!header)-$1EA2	; Level that triggers the Special World graphics change.
print "Special World Triggers extracted."
SpecialWorldTriggersEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $05B1A3
!VarOffset2 = $05A590		;\ These addresses are where the special message levels are stored in the original SMW data.
!VarOffset3 = $05A591		;| Lunar Magic actually reads them if the custom message text hijack is not in the ROM.
!VarOffset4 = $05A592		;| If that hijack is present, then Lunar Magic reads the bank 3 addresses listed below.
!VarOffset5 = $05A593		;| Also, you can't edit these in the Japanese ROM. Doing so would be pointless anyway.
!VarOffset6 = $05A5A6		;/
!VarOffset7 = $03BBA2
!VarOffset8 = $03BBA7
!VarOffset9 = $03BBAC
!VarOffsetA = $03BBB1
!VarOffsetB = $03BB9B

SpecialMessageLevels:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22	; Yellow Switch Palace Translevel Number.
	db readfile1("!hackname", snestopc(!VarOffset2)+!header)
else
	db readfile1("!hackname", snestopc(!VarOffset7)+!header)
endif

if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22	; Blue Switch Palace Translevel Number.
	db readfile1("!hackname", snestopc(!VarOffset3)+!header)
else
	db readfile1("!hackname", snestopc(!VarOffset8)+!header)
endif

if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22	; Red Switch Palace Translevel Number.
	db readfile1("!hackname", snestopc(!VarOffset4)+!header)
else
	db readfile1("!hackname", snestopc(!VarOffset9)+!header)
endif

if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22	; Green Switch Palace Translevel Number.
	db readfile1("!hackname", snestopc(!VarOffset5)+!header)
else
	db readfile1("!hackname", snestopc(!VarOffsetA)+!header)
endif

if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22	; Yoshi's House Translevel Number.
	db readfile1("!hackname", snestopc(!VarOffset6)+!header)
else
	db readfile1("!hackname", snestopc(!VarOffsetB)+!header)
endif
print "Special Message Levels extracted."
SpecialMessageLevelsEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $00C9A7
!VarOffset2 = $00C9AF
!VarOffset3 = $00CA13
!VarOffset4 = $04E660
!VarOffset5 = $00CA0C

BossSequenceLevels:
incbin "!hackname":(snestopc(!VarOffset1)+!header)-(snestopc(!VarOffset2)+!header)
db readfile1("!hackname", snestopc(!VarOffset3)+!header)	; Back Door Translevel Number
db readfile1("!hackname", snestopc(!VarOffset4)+!header)	; Earthquake Event Translevel Number
db readfile1("!hackname", snestopc(!VarOffset5)+!header)	; Trigger Secret Exit from Big Boo Boss Translevel Number
print "Boss Sequence Levels extracted."
BossSequenceLevelsEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $04DA1D
!VarOffset2 = $04DA49

RevealTileList:
incbin "!hackname":(snestopc(!VarOffset1)+!header)-(snestopc(!VarOffset2)+!header)
print "Extracted ", bytes," bytes from the Reveal Tile Table at !VarOffset1"
RevealTileListEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $00A267
!VarOffset2 = $048380
!VarOffset3 = $04828D
!VarOffset4 = $04836E
!VarOffset5 = readfile1("!hackname", snestopc($04914E)+!header)
!VarOffset6 = $05DAE6
!VarOffset7 = $03BA26
!VarOffset8 = $04E622
!VarOffset9 = $00A4EC
!VarOffsetA = $0FF9F0
!VarOffsetB = $00A96F
!VarOffsetC = $00A98B
!VarOffsetD = $00A4E3
!VarOffsetE = $00A4E4
!VarOffsetF = $04F767
!VarOffset10 = $04EACC
!VarOffset11 = $04EAD1
!VarOffset12 = $04FD86
!VarOffset13 = $04FD89

if readfile1("!hackname", snestopc(!VarOffsetD)+!header) == $22
	!VarOffset9 = readfile1("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffsetE)+!header))+!header+$1B)
endif

MiscSettings:
db readfile1("!hackname", snestopc(!VarOffset1)+!header)				; Allow using Start+Select to exit passed levels.
db readfile1("!hackname", snestopc(!VarOffset2)+!header)				; Allow using Start to scroll on main overworld map.
db readfile1("!hackname", snestopc(!VarOffset3)+!header)				; Allow players to exchange lives (at game over, etc.)
db readfile1("!hackname", snestopc(!VarOffset4)+!header)				; Allow using L/R for life exchange.
db !VarOffset5										; Allow using L+R to enter destroyed castles and fortresses (Not available in Japanese version of SMW)
db readfile1("!hackname", snestopc(!VarOffset6)+!header)				; Allow level 24 to redirect screen exits based on coins collected and time remaining.
db readfile1("!hackname", snestopc(!VarOffset7)+!header)				;\ Bring up a save prompt when the player passes a Castle, Fortress, Ghost House, Switch Palace, level tile 0x80, or level tile 0X7E.
db readfile1("!hackname", snestopc(!VarOffset8)+!header)				;/
db readfile1("!hackname", snestopc(!VarOffset12)+!header)-$1EA2				;\ Hide second ghost of sprite slot C until event passed
db readfile1("!hackname", snestopc(!VarOffset13)+!header)				;/ Reveal on events...
dl readfile3("!hackname", snestopc(!VarOffset10)+!header)				; Disable event path fade effect
db readfile1("!hackname", snestopc(!VarOffset11)+!header)				; Path Reveal Speed
db readfile1("!hackname", snestopc(!VarOffsetF)+!header)				; Make lighting use colors from ROM instead of palette
db !VarOffset9										;\ Merge GFX slots FG1 and FG2 into SP3 and SP4 to create room for 2 more FG slots.
db readfile1("!hackname", snestopc(!VarOffsetA)+!header)				;/
incbin "!hackname":(snestopc(!VarOffsetB)+!header)-(snestopc(!VarOffsetC)+!header)

print "Misc Overworld Settings extracted."
MiscSettingsEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $0084F3
!VarOffset2 = $0084F1
!LMDataName = "Castle Destruction Cutscene Text"

CDCustceneText:
if readfile1("!hackname", snestopc(!VarOffset1)+!header)&$7F <= $0F
	base $000000
	CDTextStart:
	CDCutscene1_Line8:
	incbin "Default_Data/IggyCutscene_Line8.bin"

	CDCutscene1_Line7:
	incbin "Default_Data/IggyCutscene_Line7.bin"

	CDCutscene1_Line6:
	incbin "Default_Data/IggyCutscene_Line6.bin"

	CDCutscene1_Line5:
	incbin "Default_Data/IggyCutscene_Line5.bin"

	CDCutscene1_Line4:
	incbin "Default_Data/IggyCutscene_Line4.bin"

	CDCutscene1_Line3:
	incbin "Default_Data/IggyCutscene_Line3.bin"

	CDCutscene1_Line2:
	incbin "Default_Data/IggyCutscene_Line2.bin"

	CDCutscene1_Line1:
	incbin "Default_Data/IggyCutscene_Line1.bin"

	CDCutscene2_Line8:
	incbin "Default_Data/MortonCutscene_Line8.bin"

	CDCutscene2_Line7:
	incbin "Default_Data/MortonCutscene_Line7.bin"

	CDCutscene2_Line6:
	incbin "Default_Data/MortonCutscene_Line6.bin"

	CDCutscene2_Line5:
	incbin "Default_Data/MortonCutscene_Line5.bin"

	CDCutscene2_Line4:
	incbin "Default_Data/MortonCutscene_Line4.bin"

	CDCutscene2_Line3:
	incbin "Default_Data/MortonCutscene_Line3.bin"

	CDCutscene2_Line2:
	incbin "Default_Data/MortonCutscene_Line2.bin"

	CDCutscene2_Line1:
	incbin "Default_Data/MortonCutscene_Line1.bin"

	CDCutscene3_Line8:
	incbin "Default_Data/LemmyCutscene_Line8.bin"

	CDCutscene3_Line7:
	incbin "Default_Data/LemmyCutscene_Line7.bin"

	CDCutscene3_Line6:
	incbin "Default_Data/LemmyCutscene_Line6.bin"

	CDCutscene3_Line5:
	incbin "Default_Data/LemmyCutscene_Line5.bin"

	CDCutscene3_Line4:
	incbin "Default_Data/LemmyCutscene_Line4.bin"

	CDCutscene3_Line3:
	incbin "Default_Data/LemmyCutscene_Line3.bin"

	CDCutscene3_Line2:
	incbin "Default_Data/LemmyCutscene_Line2.bin"

	CDCutscene3_Line1:
	incbin "Default_Data/LemmyCutscene_Line1.bin"

	CDCutscene4_Line8:
	incbin "Default_Data/LudwigCutscene_Line8.bin"

	CDCutscene4_Line7:
	incbin "Default_Data/LudwigCutscene_Line7.bin"

	CDCutscene4_Line6:
	incbin "Default_Data/LudwigCutscene_Line6.bin"

	CDCutscene4_Line5:
	incbin "Default_Data/LudwigCutscene_Line5.bin"

	CDCutscene4_Line4:
	incbin "Default_Data/LudwigCutscene_Line4.bin"

	CDCutscene4_Line3:
	incbin "Default_Data/LudwigCutscene_Line3.bin"

	CDCutscene4_Line2:
	incbin "Default_Data/LudwigCutscene_Line2.bin"

	CDCutscene4_Line1:
	incbin "Default_Data/LudwigCutscene_Line1.bin"

	CDCutscene5_Line8:
	incbin "Default_Data/RoyCutscene_Line8.bin"

	CDCutscene5_Line7:
	incbin "Default_Data/RoyCutscene_Line7.bin"

	CDCutscene5_Line6:
	incbin "Default_Data/RoyCutscene_Line6.bin"

	CDCutscene5_Line5:
	incbin "Default_Data/RoyCutscene_Line5.bin"

	CDCutscene5_Line4:
	incbin "Default_Data/RoyCutscene_Line4.bin"

	CDCutscene5_Line3:
	incbin "Default_Data/RoyCutscene_Line3.bin"

	CDCutscene5_Line2:
	incbin "Default_Data/RoyCutscene_Line2.bin"

	CDCutscene5_Line1:
	incbin "Default_Data/RoyCutscene_Line1.bin"

	CDCutscene6_Line8:
	incbin "Default_Data/WendyCutscene_Line8.bin"

	CDCutscene6_Line7:
	incbin "Default_Data/WendyCutscene_Line7.bin"

	CDCutscene6_Line6:
	incbin "Default_Data/WendyCutscene_Line6.bin"

	CDCutscene6_Line5:
	incbin "Default_Data/WendyCutscene_Line5.bin"

	CDCutscene6_Line4:
	incbin "Default_Data/WendyCutscene_Line4.bin"

	CDCutscene6_Line3:
	incbin "Default_Data/WendyCutscene_Line3.bin"

	CDCutscene6_Line2:
	incbin "Default_Data/WendyCutscene_Line2.bin"

	CDCutscene6_Line1:
	incbin "Default_Data/WendyCutscene_Line1.bin"

	CDCutscene7_Line8:
	incbin "Default_Data/LarryCutscene_Line8.bin"

	CDCutscene7_Line7:
	incbin "Default_Data/LarryCutscene_Line7.bin"

	CDCutscene7_Line6:
	incbin "Default_Data/LarryCutscene_Line6.bin"
	
	CDCutscene7_Line5:
	incbin "Default_Data/LarryCutscene_Line5.bin"

	CDCutscene7_Line4:
	incbin "Default_Data/LarryCutscene_Line4.bin"

	CDCutscene7_Line3:
	incbin "Default_Data/LarryCutscene_Line3.bin"

	CDCutscene7_Line2:
	incbin "Default_Data/LarryCutscene_Line2.bin"

	CDCutscene7_Line1:
	incbin "Default_Data/LarryCutscene_Line1.bin"
	base off
	print "Generated the default ", bytes," bytes for the !LMDataName."
else
	!offset1 #= readfile3("!hackname", snestopc(!VarOffset2)+!header)
	%InsertExpandedAreaBlock(!LMDataName)
endif
CDCustceneTextEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $0084F3
!VarOffset2 = $0084F1

CDCustceneTextPtrs:
if readfile1("!hackname", snestopc(!VarOffset1)+!header)&$7F <= $0F
	dw CDCutscene1_Line8,CDCutscene1_Line7,CDCutscene1_Line6,CDCutscene1_Line5
	dw CDCutscene1_Line4,CDCutscene1_Line3,CDCutscene1_Line2,CDCutscene1_Line1
	dw CDCutscene2_Line8,CDCutscene2_Line7,CDCutscene2_Line6,CDCutscene2_Line5
	dw CDCutscene2_Line4,CDCutscene2_Line3,CDCutscene2_Line2,CDCutscene2_Line1
	dw CDCutscene3_Line8,CDCutscene3_Line7,CDCutscene3_Line6,CDCutscene3_Line5
	dw CDCutscene3_Line4,CDCutscene3_Line3,CDCutscene3_Line2,CDCutscene3_Line1
	dw CDCutscene4_Line8,CDCutscene4_Line7,CDCutscene4_Line6,CDCutscene4_Line5
	dw CDCutscene4_Line4,CDCutscene4_Line3,CDCutscene4_Line2,CDCutscene4_Line1
	dw CDCutscene5_Line8,CDCutscene5_Line7,CDCutscene5_Line6,CDCutscene5_Line5
	dw CDCutscene5_Line4,CDCutscene5_Line3,CDCutscene5_Line2,CDCutscene5_Line1
	dw CDCutscene6_Line8,CDCutscene6_Line7,CDCutscene6_Line6,CDCutscene6_Line5
	dw CDCutscene6_Line4,CDCutscene6_Line3,CDCutscene6_Line2,CDCutscene6_Line1
	dw CDCutscene7_Line8,CDCutscene7_Line7,CDCutscene7_Line6,CDCutscene7_Line5
	dw CDCutscene7_Line4,CDCutscene7_Line3,CDCutscene7_Line2,CDCutscene7_Line1
else
	!LoopCounter = 0
	!offset1 #= readfile3("!hackname", snestopc(!VarOffset2)+!header)
	while !LoopCounter != 168
		dw readfile3("!hackname", snestopc(!VarOffset2+!LoopCounter)+!header)-!offset1
		!LoopCounter #= !LoopCounter+3
	endif
endif
CDCustceneTextPtrsEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $0084D5
!VarOffset2 = $0084D3
!LMDataName = "Title Screen Layer 3 Data"

TitleScreenLayer3:
if readfile1("!hackname", snestopc(!VarOffset1)+!header)&$7F <= $0F
	print "This ROM has no custom title screen layer 3 image to extract."
else
	!offset1 #= readfile3("!hackname", snestopc(!VarOffset2)+!header)
	%InsertExpandedAreaBlock(!LMDataName)
endif
TitleScreenLayer3End:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $0C9F16
!VarOffset2 = $0C9F17
!LMDataName = "Credits Layer 3 Data"

CreditsLayer3:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $BF
else
	!offset1 #= readfile3("!hackname", snestopc(!VarOffset2)+!header)
	%InsertExpandedAreaBlock(!LMDataName)
endif
CreditsLayer3End:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $009C6F
!VarOffset2 = $009C70
!LMDataName = "Title Screen Demo Data"

TitleScreenDemoMoves:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
else
	!offset1 #= readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header)+$36)+!header)+$03
	%InsertExpandedAreaBlock(!LMDataName)
endif
TitleScreenDemoMovesEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $048E49
!VarOffset2 = $048E55

KoopaKidTeleportLoc:
incbin "!hackname":(snestopc(!VarOffset1)+!header)-(snestopc(!VarOffset2)+!header)
print "Extracted ", bytes," bytes from the Overworld Koopa Kid Teleport Table at !VarOffset1"
KoopaKidTeleportLocEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $04FB88
!VarOffset2 = $04FB94

KoopaKidPos:
incbin "!hackname":(snestopc(!VarOffset1)+!header)-(snestopc(!VarOffset2)+!header)
print "Extracted ", bytes," bytes from the Overworld Koopa Kid Position Table at !VarOffset1"
KoopaKidPosEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $04FBA2

KoopaKidTiles:
db readfile1("!hackname", snestopc(!VarOffset1)+!header)	; This is the tile number + the next two that trigger the koopa kid sprites.
KoopaKidTilesEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $04ECD3
!VarOffset2 = $04ED83

UnknownStripeData:
incbin "!hackname":(snestopc(!VarOffset1)+!header)-(snestopc(!VarOffset2)+!header)
print "Extracted ", bytes," bytes from the Unknown Overworld Stripe Image Offsets Table at !VarOffset1"
UnknownStripeDataEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $04EE7A
!VarOffset2 = $04EEAA

UnknownDestroyTileData:
incbin "!hackname":(snestopc(!VarOffset1)+!header)-(snestopc(!VarOffset2)+!header)
print "Extracted ", bytes," bytes from the Unknown Destroy Tile Data at !VarOffset1"
UnknownDestroyTileDataEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $04F709

LightningDisableSetting:
db readfile1("!hackname", snestopc(!VarOffset1)+!header)
print "Lightning Animation Disable Setting extracted."
LightningDisableSettingEnd:
reset bytes

;#############################################################################################################
;#############################################################################################################

print ""
print "Extracting Level Data from a SMW ROM called !hackname..."
print ""
;Level Data

;---------------------------------------------------------------------------

!VarOffset1 = $05F000
!VarOffset2 = $05F200

LevelEntanceTable1:
incbin "!hackname":(snestopc(!VarOffset1)+!header)-(snestopc(!VarOffset2)+!header)
print "Extracted ", bytes," bytes from the Level Entrance table 1 at !VarOffset1"
LevelEntanceTable1End:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $05F200
!VarOffset2 = $05F400

LevelEntanceTable2:
incbin "!hackname":(snestopc(!VarOffset1)+!header)-(snestopc(!VarOffset2)+!header)
print "Extracted ", bytes," bytes from the Level Entrance table 2 at !VarOffset1"
LevelEntanceTable2End:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $05F400
!VarOffset2 = $05F600

LevelEntanceTable3:
incbin "!hackname":(snestopc(!VarOffset1)+!header)-(snestopc(!VarOffset2)+!header)
print "Extracted ", bytes," bytes from the Level Entrance table 3 at !VarOffset1"
LevelEntanceTable3End:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $05F600
!VarOffset2 = $05F800

LevelEntanceTable4:
incbin "!hackname":(snestopc(!VarOffset1)+!header)-(snestopc(!VarOffset2)+!header)
print "Extracted ", bytes," bytes from the Level Entrance table 4 at !VarOffset1"
LevelEntanceTable4End:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $00F70D
!VarOffset2 = $00F70E
!VarOffset3 = $05DE00
!VarOffset4 = $05E000
!LMDataName = "Level Entrance Data Table 5"

LevelEntanceTable5:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $5C
	fillbyte $00 : fill 512
	print "Generated the default ", bytes," bytes for !LMDataName."
elseif readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header))+!header+$65)&$7FFFFF == !VarOffset3
	incbin "!hackname":(snestopc(!VarOffset3)+!header)-(snestopc(!VarOffset4)+!header)
	print "Extracted ", bytes," bytes from the !LMDataName at !VarOffset3"
else
	!offset1 #= readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header))+!header+$65)
	%InsertExpandedAreaBlock(!LMDataName)
endif
LevelEntanceTable5End:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $05D9E3
!VarOffset2 = $05D9E4
!VarOffset3 = $06FC00
!VarOffset4 = $06FE00
!LMDataName = "Level Entrance Data Table 6"

LevelEntanceTable6:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
	fillbyte $00 : fill 512
	print "Generated the default ", bytes," bytes for !LMDataName."
elseif readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header))+!header+$37)&$7FFFFF == !VarOffset3
	incbin "!hackname":(snestopc(!VarOffset3)+!header)-(snestopc(!VarOffset4)+!header)
	print "Extracted ", bytes," bytes from the !LMDataName at !VarOffset3"
else
	!offset1 #= readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header))+!header+$37)
	%InsertExpandedAreaBlock(!LMDataName)
endif
LevelEntanceTable6End:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $05D9E3
!VarOffset2 = $05D9E4
!VarOffset3 = $06FE00
!VarOffset4 = $078000
!LMDataName = "Level Entrance Data Table 7"

LevelEntanceTable7:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
	fillbyte $1A : fill 512
	print "Generated the default ", bytes," bytes for !LMDataName."
elseif readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header))+!header+$3F)&$7FFFFF == !VarOffset3
	incbin "!hackname":(snestopc(!VarOffset3)+!header)-(snestopc(!VarOffset4)+!header)
	print "Extracted ", bytes," bytes from the !LMDataName at !VarOffset3"
else
	!offset1 #= readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header))+!header+$3F)
	%InsertExpandedAreaBlock(!LMDataName)
endif
LevelEntanceTable7End:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $05D9E3
!VarOffset2 = $05D9E4
!LMDataName = "Midway Entrance Tables 1-4"

MidwayEntanceTables:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
	fillbyte $00 : fill 2048
	print "Generated the default ", bytes," bytes for !LMDataName."
else
	!offset1 #= readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header))+!header+$0A)
	%InsertExpandedAreaBlock(!LMDataName)
endif
MidwayEntanceTablesEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $05D7E3
!VarOffset2 = $05D7E4
!VarOffset3 = $05F800
!VarOffset4 = $05FA00
!LMDataName = "Secondary Entrance Table 1"

SecondaryEntanceTable1:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
	incbin "Default_Data/SecondaryEntranceTable05F800.bin"
	print "Generated the default ", bytes," bytes for !LMDataName."
elseif readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header))+!header+$01)&$7FFFFF == !VarOffset3
	incbin "!hackname":(snestopc(!VarOffset3)+!header)-(snestopc(!VarOffset4)+!header)
	print "Extracted ", bytes," bytes from the !LMDataName at !VarOffset3"
else
	!offset1 #= readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header))+!header+$01)
	%InsertExpandedAreaBlock(!LMDataName)
endif
SecondaryEntanceTable1End:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $05D7EB
!VarOffset2 = $05D7EC
!VarOffset3 = $05FA00
!VarOffset4 = $05FC00
!LMDataName = "Secondary Entrance Table 2"

SecondaryEntanceTable2:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
	incbin "Default_Data/SecondaryEntranceTable05FA00.bin"
	print "Generated the default ", bytes," bytes for !LMDataName."
elseif readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header))+!header+$01)&$7FFFFF == !VarOffset3
	incbin "!hackname":(snestopc(!VarOffset3)+!header)-(snestopc(!VarOffset4)+!header)
	print "Extracted ", bytes," bytes from the !LMDataName at !VarOffset3"
else
	!offset1 #= readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header))+!header+$01)
	%InsertExpandedAreaBlock(!LMDataName)
endif
SecondaryEntanceTable2End:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $05D81D
!VarOffset2 = $05D81E
!VarOffset3 = $05FC00
!VarOffset4 = $05FE00
!LMDataName = "Secondary Entrance Table 3"

SecondaryEntanceTable3:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
	incbin "Default_Data/SecondaryEntranceTable05FC00.bin"
	print "Generated the default ", bytes," bytes for !LMDataName."
elseif readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header))+!header+$01)&$7FFFFF == !VarOffset3
	incbin "!hackname":(snestopc(!VarOffset3)+!header)-(snestopc(!VarOffset4)+!header)
	print "Extracted ", bytes," bytes from the !LMDataName at !VarOffset3"
else
	!offset1 #= readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header))+!header+$01)
	%InsertExpandedAreaBlock(!LMDataName)
endif
SecondaryEntanceTable3End:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $05D837
!VarOffset2 = $05D838
!VarOffset3 = $05FE00
!VarOffset4 = $068000
!LMDataName = "Secondary Entrance Table 4"

SecondaryEntanceTable4:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
	incbin "Default_Data/SecondaryEntranceTable05FE00.bin"
	print "Generated the default ", bytes," bytes for !LMDataName."
elseif readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header)+$01)+!header)+$01)+!header)&$7FFFFF == !VarOffset3
	incbin "!hackname":(snestopc(!VarOffset3)+!header)-(snestopc(!VarOffset4)+!header)
	print "Extracted ", bytes," bytes from the !LMDataName at !VarOffset3"
else
	!offset1 #= readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header)+$01)+!header)+$01)+!header)
	%InsertExpandedAreaBlock(!LMDataName)
endif
SecondaryEntanceTable4End:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $05D837
!VarOffset2 = $05D838
!LMDataName = "Secondary Entrance Table 5"

SecondaryEntanceTable5:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
	fillbyte $00 : fill 512
	print "Generated the default ", bytes," bytes for !LMDataName."
else
	!offset1 #= readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header)+$13)+!header)+$01)+!header)
	%InsertExpandedAreaBlock(!LMDataName)
endif
SecondaryEntanceTable5End:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $05D837
!VarOffset2 = $05D838
!LMDataName = "Secondary Entrance Table 6"

SecondaryEntanceTable6:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
	fillbyte $00 : fill 512
	print "Generated the default ", bytes," bytes for !LMDataName."
else
	!offset1 #= readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header)+$1D)+!header)+$01)+!header)
	%InsertExpandedAreaBlock(!LMDataName)
endif
SecondaryEntanceTable6End:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $0583AD
!VarOffset2 = $0583AE
!VarOffset3 = $03FE00
!VarOffset4 = $048000
!LMDataName = "Level ExAnimation Settings Table"

LevelExAnimationSettings:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
	incbin "Default_Data/LevelExAnimationSettings.bin"
	print "Generated the default ", bytes," bytes for the !LMDataName."
elseif readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header)+$46)+!header)&$7FFFFF == !VarOffset3
	incbin "!hackname":(snestopc(!VarOffset3)+!header)-(snestopc(!VarOffset4)+!header)
	print "Extracted ", bytes," bytes from the !LMDataName at !VarOffset3"
else
	!offset1 #= readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header)+$46)+!header)
	%InsertExpandedAreaBlock(!LMDataName)
endif
LevelExAnimationSettingsEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $05803B
!VarOffset2 = $05803C
!VarOffset3 = $0EF310
!VarOffset4 = $0EF510
!LMDataName = "Level Layer 2 Flags Table"

LevelLayer2Flags:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $5C
	fillbyte $00 : fill 512
	print "Generated the default ", bytes," bytes for the !LMDataName."
elseif readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header))+!header+$10)&$7FFFFF == !VarOffset3
	incbin "!hackname":(snestopc(!VarOffset3)+!header)-(snestopc(!VarOffset4)+!header)
	print "Extracted ", bytes," bytes from the !LMDataName at !VarOffset3"
else
	!offset1 #= readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header))+!header+$10)
	%InsertExpandedAreaBlock(!LMDataName)
endif
LevelLayer2FlagsEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $0EF30F
!VarOffset2 = $0EF30C
!LMDataName = "Level Sprite List Size Table"

LevelSpriteListSize:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $42
	fillbyte $00 : fill 1024
	print "Generated the default ", bytes," bytes for the !LMDataName."
elseif readfile3("!hackname", snestopc(!VarOffset2)+!header) == $FFFFFF
	fillbyte $00 : fill 1024
	print "Generated the default ", bytes," bytes for the !LMDataName."
else
	!offset1 #= readfile3("!hackname", snestopc(!VarOffset2)+!header)
	%InsertExpandedAreaBlock(!LMDataName)
endif
LevelSpriteListSizeEnd:
reset bytes

;#############################################################################################################
;#############################################################################################################

print ""
print "Extracting ASM hacks from a SMW ROM called !hackname..."
print ""

;---------------------------------------------------------------------------

!VarOffset1 = $048F8A
!VarOffset2 = $048F8B
!VarOffset3 = $03BA10
!VarOffset4 = $03BA3C
!ASMHackName = "Save Prompt Hack Routine"

SavePromptHack:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
	print "LM ASM Hack '!ASMHackName' is not installed. This routine will not be extracted."
else
	if readfile3("!hackname", snestopc(!VarOffset2)+!header)&$7FFFFF == !VarOffset3
		incbin "!hackname":(snestopc(!VarOffset3)+!header)-(snestopc(!VarOffset4)+!header)
		print "Extracted ", bytes," bytes from the !ASMHackName at !VarOffset3"
	else
		!offset1 #= readfile3("!hackname", snestopc(!VarOffset2)+!header)
		%InsertExpandedAreaBlock(!ASMHackName)
	endif
endif
SavePromptHackEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $049199
!VarOffset2 = $04919A
!VarOffset3 = $03BA50
!VarOffset4 = $03BAE5
!ASMHackName = "Level Re-Entry Hack Routine"

LevelReEntryHack:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
	print "LM ASM Hack '!ASMHackName' is not installed. This routine will not be extracted."
else
	if readfile3("!hackname", snestopc(!VarOffset2)+!header)&$7FFFFF == !VarOffset3
		incbin "!hackname":(snestopc(!VarOffset3)+!header)-(snestopc(!VarOffset4)+!header)
		print "Extracted ", bytes," bytes from the !ASMHackName at !VarOffset3"
	else
		!offset1 #= readfile3("!hackname", snestopc(!VarOffset2)+!header)
		%InsertExpandedAreaBlock(!ASMHackName)
	endif
endif
LevelReEntryHackEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $05DBC2
!VarOffset2 = $05DBC3
!VarOffset3 = $03BB00
!VarOffset4 = $03BB0D
!ASMHackName = "Bonus Level Warp Fix Routine"

BonusAreaWarpFix:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
	print "LM ASM Hack '!ASMHackName' is not installed. This routine will not be extracted."
else
	if readfile3("!hackname", snestopc(!VarOffset2)+!header)&$7FFFFF == !VarOffset3
		incbin "!hackname":(snestopc(!VarOffset3)+!header)-(snestopc(!VarOffset4)+!header)
		print "Extracted ", bytes," bytes from the !ASMHackName at !VarOffset3"
	else
		!offset1 #= readfile3("!hackname", snestopc(!VarOffset2)+!header)
		%InsertExpandedAreaBlock(!ASMHackName)
	endif
endif
BonusAreaWarpFixEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $048E81
!VarOffset2 = $048E82
!VarOffset3 = $03BB20
!VarOffset4 = $03BB72
!ASMHackName = "Custom Level Names Routine"
!LMDataName = "Level Name Data"

CustomLevelNamesRt:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
	print "LM ASM Hack '!ASMHackName' is not installed. This routine and its associated data will not be extracted."
else
	if readfile3("!hackname", snestopc(!VarOffset2)+!header)&$7FFFFF == !VarOffset3
		incbin "!hackname":(snestopc(!VarOffset3)+!header)-(snestopc(!VarOffset4)+!header)
		print "Extracted ", bytes," bytes from the !ASMHackName at !VarOffset3"
	else
		!offset1 #= readfile3("!hackname", snestopc(!VarOffset2)+!header)
		%InsertExpandedAreaBlock(!ASMHackName)
	endif
endif
CustomLevelNamesRtEnd:
reset bytes

LevelNames:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
	incbin "Default_Data/LevelNames.bin"
	print "Generated the default ", bytes," bytes for the !LMDataName."
else
	!offset1 #= readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header))+!header+$37)
	%InsertExpandedAreaBlock(!LMDataName)
endif
LevelNamesEnd:
reset bytes

;---------------------------------------------------------------------------

; Note: When inserting the extra levels/events ASM hack, 3 sets of message text protected by RATS tags get inserted, where the first 2 contain 192 messages and the last one contains 128.

!VarOffset1 = $05B1A3
!VarOffset2 = $05B1A4
!VarOffset3 = $03BB90
!VarOffset4 = $03BCA0
!VarOffset5 = $03BE80
!VarOffset6 = $03C000
!ASMHackName = "Custom Level Messages Routine"
!LMDataName = "Level Message Data"

CustomLevelMessagesRt:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
	print "LM ASM Hack '!ASMHackName' is not installed. This routine and its associated data will not be extracted."
else
	if readfile3("!hackname", snestopc(!VarOffset2)+!header)&$7FFFFF == !VarOffset3
		incbin "!hackname":(snestopc(!VarOffset3)+!header)-(snestopc(!VarOffset4)+!header)
		print "Extracted ", bytes," bytes from the !ASMHackName at !VarOffset3"
	else
		!offset1 #= readfile3("!hackname", snestopc(!VarOffset2)+!header)
		%InsertExpandedAreaBlock(!ASMHackName)
	endif
endif
CustomLevelMessagesRtEnd:
reset bytes

MessageText1:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
	base $000000
	!offset1 #= filesize(Default_Data/Message000_01.bin)-$01
	Message000_01:
		incbin "Default_Data/Message000_01.bin":0-(!offset1)
	Message001_01:
	Message001_02:
	Message002_01:
	Message002_02:
	Message003_01:
	Message003_02:
	Message004_01:
	Message005_02:
	Message006_01:
	Message006_02:
	Message007_01:
	Message007_02:
	Message008_02:
	Message009_01:
	Message009_02:
	Message00A_01:
	Message00A_02:
	Message00B_01:
	Message00B_02:
	Message00C_01:
	Message00C_02:
	Message00D_01:
	Message00D_02:
	Message00E_01:
	Message00E_02:
	Message00F_01:
	Message00F_02:
	Message010_01:
	Message010_02:
	Message011_01:
	Message011_02:
	Message012_01:
	Message012_02:
	Message013_02:
	Message014_02:
	Message016_01:
	Message016_02:
	Message017_01:
	Message017_02:
	Message018_01:
	Message018_02:
	Message019_01:
	Message019_02:
	Message01A_01:
	Message01A_02:
	Message01B_01:
	Message01B_02:
	Message01C_01:
	Message01C_02:
	Message01D_01:
	Message01D_02:
	Message01E_01:
	Message01E_02:
	Message01F_01:
	Message01F_02:
	Message020_01:
	Message020_02:
	Message021_01:
	Message021_02:
	Message022_01:
	Message022_02:
	Message023_01:
	Message023_02:
	Message024_01:
	Message107_01:
	Message107_02:
	Message108_01:
	Message108_02:
	Message109_01:
	Message109_02:
	Message10A_01:
	Message10A_02:
	Message10B_01:
	Message10B_02:
	Message10C_01:
	Message10C_02:
	Message10D_01:
	Message10D_02:
	Message10E_01:
	Message10E_02:
	Message10F_01:
	Message10F_02:
	Message110_01:
	Message110_02:
	Message111_01:
	Message111_02:
	Message112_01:
	Message112_02:
	Message113_01:
	Message113_02:
	Message114_01:
	Message114_02:
	Message115_01:
	Message115_02:
	Message116_01:
	Message116_02:
	Message117_01:
	Message117_02:
	Message118_01:
	Message118_02:
	Message119_01:
	Message119_02:
	Message11A_01:
	Message11A_02:
	Message11B_02:
	Message11C_01:
	Message11C_02:
	Message11D_01:
	Message11D_02:
	Message11E_01:
	Message11E_02:
	Message11F_01:
	Message11F_02:
	Message120_01:
	Message120_02:
	Message121_02:
	Message122_01:
	Message122_02:
	Message123_01:
	Message123_02:
	Message124_01:
	Message124_02:
	Message125_01:
	Message125_02:
	Message126_01:
	Message126_02:
	Message127_01:
	Message127_02:
	Message128_01:
	Message128_02:
	Message129_01:
	Message129_02:
	Message12A_01:
	Message12B_01:
	Message12B_02:
	Message12C_01:
	Message12C_02:
	Message12D_01:
	Message12D_02:
	Message12E_01:
	Message12E_02:
	Message12F_01:
	Message12F_02:
	Message130_01:
	Message130_02:
	Message131_01:
	Message131_02:
	Message132_01:
	Message132_02:
	Message133_01:
	Message133_02:
	Message134_01:
	Message134_02:
	Message135_01:
	Message135_02:
	Message136_01:
	Message136_02:
	Message137_01:
	Message137_02:
	Message138_01:
	Message138_02:
	Message139_01:
	Message139_02:
	Message13A_01:
	Message13A_02:
	Message13B_01:
	Message13B_02:
		db $FE

	Message000_02:
		incbin "Default_Data/Message000_02.bin"
	Message004_02:
		incbin "Default_Data/Message004_02.bin"
	Message005_01:
		incbin "Default_Data/Message005_01.bin"
	Message008_01:
		incbin "Default_Data/SwitchPalaceMessage_01.bin"
	Message013_01:
		incbin "Default_Data/Message013_01.bin"
	Message014_01:
		incbin "Default_Data/SwitchPalaceMessage_01.bin"
	Message015_01:
		incbin "Default_Data/Message015_01.bin"
	Message015_02:
		incbin "Default_Data/Message015_02.bin"
	Message024_02:
		incbin "Default_Data/Message024_02.bin"
	Message101_01:
		incbin "Default_Data/Message101_01.bin"
	Message101_02:
		incbin "Default_Data/Message101_02.bin"
	Message102_01:
		incbin "Default_Data/Message102_01.bin"
	Message102_02:
		incbin "Default_Data/Message102_02.bin"
	Message103_01:
		incbin "Default_Data/Message103_01.bin"
	Message103_02:
		incbin "Default_Data/Message103_02.bin"
	Message104_01:
		incbin "Default_Data/Message104_01.bin"
	Message104_02:
		incbin "Default_Data/Message104_02.bin"
	Message105_01:
		incbin "Default_Data/Message105_01.bin"
	Message105_02:
		incbin "Default_Data/Message105_02.bin"
	Message106_01:
		incbin "Default_Data/Message106_01.bin"
	Message106_02:
		incbin "Default_Data/Message106_02.bin"
	Message11B_01:
		incbin "Default_Data/SwitchPalaceMessage_01.bin"
	Message121_01:
		incbin "Default_Data/SwitchPalaceMessage_01.bin"
	Message12A_02:
		incbin "Default_Data/Message12A_02.bin"
	if !ExtraOverworldLevelsAndEvents == !TRUE
		base $000000
		Message13C_01:
		Message13C_02:
		Message13D_01:
		Message13D_02:
		Message13E_01:
		Message13E_02:
		Message13F_01:
		Message13F_02:
		Message140_01:
		Message140_02:
		Message141_02:
		Message142_01:
		Message142_02:
		Message143_01:
		Message143_02:
		Message144_01:
		Message144_02:
		Message145_01:
		Message145_02:
		Message146_01:
		Message146_02:
		Message147_01:
		Message147_02:
		Message148_01:
		Message148_02:
		Message149_01:
		Message149_02:
		Message14A_01:
		Message14B_01:
		Message14B_02:
		Message14C_01:
		Message14C_02:
		Message14D_01:
		Message14D_02:
		Message14E_01:
		Message14E_02:
		Message14F_01:
		Message14F_02:
		Message150_01:
		Message150_02:
		Message151_01:
		Message151_02:
		Message152_01:
		Message152_02:
		Message153_01:
		Message153_02:
		Message154_01:
		Message154_02:
		Message155_01:
		Message155_02:
		Message156_01:
		Message156_02:
		Message157_01:
		Message157_02:
		Message158_01:
		Message158_02:
		Message159_01:
		Message159_02:
		Message15A_01:
		Message15A_02:
		Message15B_02:
		Message15C_01:
		Message15C_02:
		Message15D_01:
		Message15D_02:
		Message15E_01:
		Message15E_02:
		Message15F_01:
		Message15F_02:
		Message160_01:
		Message160_02:
		Message161_02:
		Message162_01:
		Message162_02:
		Message163_01:
		Message163_02:
		Message164_01:
		Message164_02:
		Message165_01:
		Message165_02:
		Message166_01:
		Message166_02:
		Message167_01:
		Message167_02:
		Message168_01:
		Message168_02:
		Message169_01:
		Message169_02:
		Message16A_01:
		Message16B_01:
		Message16B_02:
		Message16C_01:
		Message16C_02:
		Message16D_01:
		Message16D_02:
		Message16E_01:
		Message16E_02:
		Message16F_01:
		Message16F_02:
		Message170_01:
		Message170_02:
		Message171_02:
		Message172_01:
		Message172_02:
		Message173_01:
		Message173_02:
		Message174_01:
		Message174_02:
		Message175_01:
		Message175_02:
		Message176_01:
		Message176_02:
		Message177_01:
		Message177_02:
		Message178_01:
		Message178_02:
		Message179_01:
		Message179_02:
		Message17A_01:
		Message17B_01:
		Message17B_02:
		Message17C_01:
		Message17C_02:
		Message17D_01:
		Message17D_02:
		Message17E_01:
		Message17E_02:
		Message17F_01:
		Message17F_02:
		Message180_01:
		Message180_02:
		Message181_01:
		Message181_02:
		Message182_01:
		Message182_02:
		Message183_01:
		Message183_02:
		Message184_01:
		Message184_02:
		Message185_01:
		Message185_02:
		Message186_01:
		Message186_02:
		Message187_01:
		Message187_02:
		Message188_01:
		Message188_02:
		Message189_01:
		Message189_02:
		Message18A_01:
		Message18A_02:
		Message18B_01:
		Message18B_02:
		Message18C_01:
		Message18C_02:
		Message18D_01:
		Message18D_02:
		Message18E_01:
		Message18E_02:
		Message18F_01:
		Message18F_02:
		Message190_01:
		Message190_02:
		Message191_02:
		Message192_01:
		Message192_02:
		Message193_01:
		Message193_02:
		Message194_01:
		Message194_02:
		Message195_01:
		Message195_02:
		Message196_01:
		Message196_02:
		Message197_01:
		Message197_02:
		Message198_01:
		Message198_02:
		Message199_01:
		Message199_02:
		Message19A_01:
		Message19B_01:
		Message19B_02:
			db $FE

		base $000000
		Message19C_01:
		Message19C_02:
		Message19D_01:
		Message19D_02:
		Message19E_01:
		Message19E_02:
		Message19F_01:
		Message19F_02:
		Message1A0_01:
		Message1A0_02:
		Message1A1_01:
		Message1A1_02:
		Message1A2_01:
		Message1A2_02:
		Message1A3_01:
		Message1A3_02:
		Message1A4_01:
		Message1A4_02:
		Message1A5_01:
		Message1A5_02:
		Message1A6_01:
		Message1A6_02:
		Message1A7_01:
		Message1A7_02:
		Message1A8_01:
		Message1A8_02:
		Message1A9_01:
		Message1A9_02:
		Message1AA_01:
		Message1AA_02:
		Message1AB_02:
		Message1AC_01:
		Message1AC_02:
		Message1AD_01:
		Message1AD_02:
		Message1AE_01:
		Message1AE_02:
		Message1AF_01:
		Message1AF_02:
		Message1B0_01:
		Message1B0_02:
		Message1B1_02:
		Message1B2_01:
		Message1B2_02:
		Message1B3_01:
		Message1B3_02:
		Message1B4_01:
		Message1B4_02:
		Message1B5_01:
		Message1B5_02:
		Message1B6_01:
		Message1B6_02:
		Message1B7_01:
		Message1B7_02:
		Message1B8_01:
		Message1B8_02:
		Message1B9_01:
		Message1B9_02:
		Message1BA_01:
		Message1BB_01:
		Message1BB_02:
		Message1BC_01:
		Message1BC_02:
		Message1BD_01:
		Message1BD_02:
		Message1BE_01:
		Message1BE_02:
		Message1BF_01:
		Message1BF_02:
		Message1C0_01:
		Message1C0_02:
		Message1C1_02:
		Message1C2_01:
		Message1C2_02:
		Message1C3_01:
		Message1C3_02:
		Message1C4_01:
		Message1C4_02:
		Message1C5_01:
		Message1C5_02:
		Message1C6_01:
		Message1C6_02:
		Message1C7_01:
		Message1C7_02:
		Message1C8_01:
		Message1C8_02:
		Message1C9_01:
		Message1C9_02:
		Message1CA_01:
		Message1CB_01:
		Message1CB_02:
		Message1CC_01:
		Message1CC_02:
		Message1CD_01:
		Message1CD_02:
		Message1CE_01:
		Message1CE_02:
		Message1CF_01:
		Message1CF_02:
		Message1D0_01:
		Message1D0_02:
		Message1D1_01:
		Message1D1_02:
		Message1D2_01:
		Message1D2_02:
		Message1D3_01:
		Message1D3_02:
		Message1D4_01:
		Message1D4_02:
		Message1D5_01:
		Message1D5_02:
		Message1D6_01:
		Message1D6_02:
		Message1D7_01:
		Message1D7_02:
		Message1D8_01:
		Message1D8_02:
		Message1D9_01:
		Message1D9_02:
		Message1DA_01:
		Message1DA_02:
		Message1DB_01:
		Message1DB_02:
			db $FE
	endif
	MessageText1End:
	base off
	print "Generated the default ", bytes," bytes for the !LMDataName."
else
	if !ExtraOverworldLevelsAndEvents == !FALSE
		!offset1 #= readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header))+!header+$7B)
		%InsertExpandedAreaBlock(!LMDataName)
		MessageText1End:
	else
		!offset1 #= readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header)+$49)+!header)+$00)+!header)
		!LMDataName = "Level Message Data (Block 1)"
		%InsertExpandedAreaBlock(!LMDataName)
		MessageText1End:
		reset bytes
		MessageText2:
		!offset1 #= readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header)+$49)+!header)+$0240)+!header)
		!LMDataName = "Level Message Data (Block 2)"
		%InsertExpandedAreaBlock(!LMDataName)
		MessageText2End:
		reset bytes
		MessageText3:
		!offset1 #= readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header)+$49)+!header)+$0480)+!header)
		!LMDataName = "Level Message Data (Block 3)"
		%InsertExpandedAreaBlock(!LMDataName)
		MessageText3End:
	endif
endif
reset bytes

!LMDataName = "Level Message Data Pointers"

MessageTextPtrs:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
	dw Message000_01,Message000_02,Message001_01,Message001_02,Message002_01,Message002_02,Message003_01,Message003_02
	dw Message004_01,Message004_02,Message005_01,Message005_02,Message006_01,Message006_02,Message007_01,Message007_02
	dw Message008_01,Message008_02,Message009_01,Message009_02,Message00A_01,Message00A_02,Message00B_01,Message00B_02
	dw Message00C_01,Message00C_02,Message00D_01,Message00D_02,Message00E_01,Message00E_02,Message00F_01,Message00F_02
	dw Message010_01,Message010_02,Message011_01,Message011_02,Message012_01,Message012_02,Message013_01,Message013_02
	dw Message014_01,Message014_02,Message015_01,Message015_02,Message016_01,Message016_02,Message017_01,Message017_02
	dw Message018_01,Message018_02,Message019_01,Message019_02,Message01A_01,Message01A_02,Message01B_01,Message01B_02
	dw Message01C_01,Message01C_02,Message01D_01,Message01D_02,Message01E_01,Message01E_02,Message01F_01,Message01F_02
	dw Message020_01,Message020_02,Message021_01,Message021_02,Message022_01,Message022_02,Message023_01,Message023_02
	dw Message024_01,Message024_02,Message101_01,Message101_02,Message102_01,Message102_02,Message103_01,Message103_02
	dw Message104_01,Message104_02,Message105_01,Message105_02,Message106_01,Message106_02,Message107_01,Message107_02
	dw Message108_01,Message108_02,Message109_01,Message109_02,Message10A_01,Message10A_02,Message10B_01,Message10B_02
	dw Message10C_01,Message10C_02,Message10D_01,Message10D_02,Message10E_01,Message10E_02,Message10F_01,Message10F_02
	dw Message110_01,Message110_02,Message111_01,Message111_02,Message112_01,Message112_02,Message113_01,Message113_02
	dw Message114_01,Message114_02,Message115_01,Message115_02,Message116_01,Message116_02,Message117_01,Message117_02
	dw Message118_01,Message118_02,Message119_01,Message119_02,Message11A_01,Message11A_02,Message11B_01,Message11B_02
	dw Message11C_01,Message11C_02,Message11D_01,Message11D_02,Message11E_01,Message11E_02,Message11F_01,Message11F_02
	dw Message120_01,Message120_02,Message121_01,Message121_02,Message122_01,Message122_02,Message123_01,Message123_02
	dw Message124_01,Message124_02,Message125_01,Message125_02,Message126_01,Message126_02,Message127_01,Message127_02
	dw Message128_01,Message128_02,Message129_01,Message129_02,Message12A_01,Message12A_02,Message12B_01,Message12B_02
	dw Message12C_01,Message12C_02,Message12D_01,Message12D_02,Message12E_01,Message12E_02,Message12F_01,Message12F_02
	dw Message130_01,Message130_02,Message131_01,Message131_02,Message132_01,Message132_02,Message133_01,Message133_02
	dw Message134_01,Message134_02,Message135_01,Message135_02,Message136_01,Message136_02,Message137_01,Message137_02
	dw Message138_01,Message138_02,Message139_01,Message139_02,Message13A_01,Message13A_02,Message13B_01,Message13B_02
	if !ExtraOverworldLevelsAndEvents == !TRUE
		dw Message13C_01,Message13C_02,Message13D_01,Message13D_02,Message13E_01,Message13E_02,Message13F_01,Message13F_02
		dw Message140_01,Message140_02,Message141_01,Message141_02,Message142_01,Message142_02,Message143_01,Message143_02
		dw Message144_01,Message144_02,Message145_01,Message145_02,Message146_01,Message146_02,Message147_01,Message147_02
		dw Message148_01,Message148_02,Message149_01,Message149_02,Message14A_01,Message14A_02,Message14B_01,Message14B_02
		dw Message14C_01,Message14C_02,Message14D_01,Message14D_02,Message14E_01,Message14E_02,Message14F_01,Message14F_02
		dw Message150_01,Message150_02,Message151_01,Message151_02,Message152_01,Message152_02,Message153_01,Message153_02
		dw Message154_01,Message154_02,Message155_01,Message155_02,Message156_01,Message156_02,Message157_01,Message157_02
		dw Message158_01,Message158_02,Message159_01,Message159_02,Message15A_01,Message15A_02,Message15B_01,Message15B_02
		dw Message15C_01,Message15C_02,Message15D_01,Message15D_02,Message15E_01,Message15E_02,Message15F_01,Message15F_02
		dw Message160_01,Message160_02,Message161_01,Message161_02,Message162_01,Message162_02,Message163_01,Message163_02
		dw Message164_01,Message164_02,Message165_01,Message165_02,Message166_01,Message166_02,Message167_01,Message167_02
		dw Message168_01,Message168_02,Message169_01,Message169_02,Message16A_01,Message16A_02,Message16B_01,Message16B_02
		dw Message16C_01,Message16C_02,Message16D_01,Message16D_02,Message16E_01,Message16E_02,Message16F_01,Message16F_02
		dw Message170_01,Message170_02,Message171_01,Message171_02,Message172_01,Message172_02,Message173_01,Message173_02
		dw Message174_01,Message174_02,Message175_01,Message175_02,Message176_01,Message176_02,Message177_01,Message177_02
		dw Message178_01,Message178_02,Message179_01,Message179_02,Message17A_01,Message17A_02,Message17B_01,Message17B_02
		dw Message17C_01,Message17C_02,Message17D_01,Message17D_02,Message17E_01,Message17E_02,Message17F_01,Message17F_02
		dw Message180_01,Message180_02,Message181_01,Message181_02,Message182_01,Message182_02,Message183_01,Message183_02
		dw Message184_01,Message184_02,Message185_01,Message185_02,Message186_01,Message186_02,Message187_01,Message187_02
		dw Message188_01,Message188_02,Message189_01,Message189_02,Message18A_01,Message18A_02,Message18B_01,Message18B_02
		dw Message18C_01,Message18C_02,Message18D_01,Message18D_02,Message18E_01,Message18E_02,Message18F_01,Message18F_02
		dw Message190_01,Message190_02,Message191_01,Message191_02,Message192_01,Message192_02,Message193_01,Message193_02
		dw Message194_01,Message194_02,Message195_01,Message195_02,Message196_01,Message196_02,Message197_01,Message197_02
		dw Message198_01,Message198_02,Message199_01,Message199_02,Message19A_01,Message19A_02,Message19B_01,Message19B_02
		dw Message19C_01,Message19C_02,Message19D_01,Message19D_02,Message19E_01,Message19E_02,Message19F_01,Message19F_02
		dw Message1A0_01,Message1A0_02,Message1A1_01,Message1A1_02,Message1A2_01,Message1A2_02,Message1A3_01,Message1A3_02
		dw Message1A4_01,Message1A4_02,Message1A5_01,Message1A5_02,Message1A6_01,Message1A6_02,Message1A7_01,Message1A7_02
		dw Message1A8_01,Message1A8_02,Message1A9_01,Message1A9_02,Message1AA_01,Message1AA_02,Message1AB_01,Message1AB_02
		dw Message1AC_01,Message1AC_02,Message1AD_01,Message1AD_02,Message1AE_01,Message1AE_02,Message1AF_01,Message1AF_02
		dw Message1B0_01,Message1B0_02,Message1B1_01,Message1B1_02,Message1B2_01,Message1B2_02,Message1B3_01,Message1B3_02
		dw Message1B4_01,Message1B4_02,Message1B5_01,Message1B5_02,Message1B6_01,Message1B6_02,Message1B7_01,Message1B7_02
		dw Message1B8_01,Message1B8_02,Message1B9_01,Message1B9_02,Message1BA_01,Message1BA_02,Message1BB_01,Message1BB_02
		dw Message1BC_01,Message1BC_02,Message1BD_01,Message1BD_02,Message1BE_01,Message1BE_02,Message1BF_01,Message1BF_02
		dw Message1C0_01,Message1C0_02,Message1C1_01,Message1C1_02,Message1C2_01,Message1C2_02,Message1C3_01,Message1C3_02
		dw Message1C4_01,Message1C4_02,Message1C5_01,Message1C5_02,Message1C6_01,Message1C6_02,Message1C7_01,Message1C7_02
		dw Message1C8_01,Message1C8_02,Message1C9_01,Message1C9_02,Message1CA_01,Message1CA_02,Message1CB_01,Message1CB_02
		dw Message1CC_01,Message1CC_02,Message1CD_01,Message1CD_02,Message1CE_01,Message1CE_02,Message1CF_01,Message1CF_02
		dw Message1D0_01,Message1D0_02,Message1D1_01,Message1D1_02,Message1D2_01,Message1D2_02,Message1D3_01,Message1D3_02
		dw Message1D4_01,Message1D4_02,Message1D5_01,Message1D5_02,Message1D6_01,Message1D6_02,Message1D7_01,Message1D7_02
		dw Message1D8_01,Message1D8_02,Message1D9_01,Message1D9_02,Message1DA_01,Message1DA_02,Message1DB_01,Message1DB_02
		print "Generated the default ", bytes," bytes for !LMDataName."
	endif
else
	if readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header))+!header+$49)-$850000 == !VarOffset5
		incbin "!hackname":(snestopc(!VarOffset5)+!header)-(snestopc(!VarOffset6)+!header)
		print "Extracted ", bytes," bytes from the !LMDataName at !VarOffset5"
	else
		!LoopCounter2 = 0
		while !LoopCounter2 < 3
			!LoopCounter = 0
			if !LoopCounter2 == 2
				!MaxLoopCounter = 384
			else
				!MaxLoopCounter = 576
			endif
			!offset1 #= readfile3("!hackname", snestopc(readfile3("!hackname", snestopc(!VarOffset2)+!header))+!header+$49)+(!LoopCounter2*$0240)
			while !LoopCounter != !MaxLoopCounter
				dw readfile3("!hackname", snestopc(!offset1+!LoopCounter)+!header)-!offset1
				!LoopCounter #= !LoopCounter+3
			endif
			!LoopCounter2 #= !LoopCounter2+1
		endif
		print "Extracted ", bytes," bytes from the !LMDataName at $",hex(!offset1)
	endif
endif
MessageTextPtrsEnd:
reset bytes

;---------------------------------------------------------------------------

!VarOffset1 = $05D837
!VarOffset2 = $05D838
!VarOffset3 = $03BCE0
!VarOffset4 = $03BDA0
!ASMHackName = "Handle Extra Secondary Entrance Tables Routine"

HandleExtraSecondaryEntranceTablesRt:
if readfile1("!hackname", snestopc(!VarOffset1)+!header) != $22
	print "LM ASM Hack '!ASMHackName' is not installed. This routine will not be extracted."
else
	if readfile3("!hackname", snestopc(!VarOffset2)+!header)&$7FFFFF == !VarOffset3
		incbin "!hackname":(snestopc(!VarOffset3)+!header)-(snestopc(!VarOffset4)+!header)
		print "Extracted ", bytes," bytes from the !ASMHackName at !VarOffset3"
	else
		!offset1 #= readfile3("!hackname", snestopc(!VarOffset2)+!header)
		%InsertExpandedAreaBlock(!ASMHackName)
	endif
endif
HandleExtraSecondaryEntranceTablesRtEnd:
reset bytes

;---------------------------------------------------------------------------

;---------------------------------------------------------------------------

;---------------------------------------------------------------------------

;---------------------------------------------------------------------------

;---------------------------------------------------------------------------

;---------------------------------------------------------------------------

;---------------------------------------------------------------------------

FileEnd:

print ""
print ""

check bankcross on
