
;---------------------------------------------------------------------------

macro SMW_InsertOriginalLevelData(LevelName, VerDif, Data)
if stringsequal("<Data>", "LAYER_1")
	!ReadFileDataOffset = $0048
	!ReadFileSize = $004C
elseif stringsequal("<Data>", "LAYER_2")
	!ReadFileDataOffset = $0050
	!ReadFileSize = $0054
elseif stringsequal("<Data>", "SPRITES")
	!ReadFileDataOffset = $0058
	!ReadFileSize = $005C
else
	error "<Data> is not a valid level data type"
endif

if !ROM_<VerDif> != !ROM_SMW_U
	if !Define_Global_ROMToAssemble&(!ROM_<VerDif>) != $00
		!TEMP = <LevelName>_<VerDif>
	else
		!TEMP = <LevelName>
	endif
else
	!TEMP = <LevelName>
endif

!ReadFileDataOffset #= ((readfile2("levels/!TEMP.mwl", !ReadFileDataOffset))+$08)
!ReadFileSize #= (!ReadFileDataOffset+((readfile2("levels/!TEMP.mwl", !ReadFileSize))-$08))
incbin "levels/!TEMP.mwl":(!ReadFileDataOffset)-(!ReadFileSize)
endmacro

;---------------------------------------------------------------------------

macro SMW_AnimationTileset(Num)
	db ((SMW_LevelTileAnimations_FrameData_Local<Num>-SMW_LevelTileAnimations_FrameData_Local0)/(SMW_LevelTileAnimations_FrameData_Local1-SMW_LevelTileAnimations_FrameData_Local0)*$05)
endmacro

;---------------------------------------------------------------------------

macro SMW_LMStyleAnimationFrames(Frame1, Frame2, Frame3, Frame4)
if $<Frame1> < $0600
	!Frame1 = !RAM_SMW_Graphics_DecompressedGFX33
elseif $<Frame1> <= $087F
	!Frame1 = (($<Frame1>-$0600)*$20)+!RAM_SMW_Graphics_DecompressedGFX33
elseif $<Frame1> <= $08FF
	!Frame1 = !RAM_SMW_Graphics_DecompressedGFX32
elseif $<Frame1> <= $0BE4
	!Frame1 = (($<Frame1>-$0900)*$20)+!RAM_SMW_Graphics_DecompressedGFX32
else
	!Frame1 = !RAM_SMW_Graphics_DecompressedGFX33
endif
if $<Frame2> < $0600
	!Frame2 = !RAM_SMW_Graphics_DecompressedGFX33
elseif $<Frame2> <= $087F
	!Frame2 = (($<Frame2>-$0600)*$20)+!RAM_SMW_Graphics_DecompressedGFX33
elseif $<Frame2> <= $08FF
	!Frame2 = !RAM_SMW_Graphics_DecompressedGFX32
elseif $<Frame2> <= $0BE4
	!Frame2 = (($<Frame2>-$0900)*$20)+!RAM_SMW_Graphics_DecompressedGFX32
else
	!Frame2 = !RAM_SMW_Graphics_DecompressedGFX33
endif
if $<Frame3> < $0600
	!Frame3 = !RAM_SMW_Graphics_DecompressedGFX33
elseif $<Frame3> <= $087F
	!Frame3 = (($<Frame3>-$0600)*$20)+!RAM_SMW_Graphics_DecompressedGFX33
elseif $<Frame3> <= $08FF
	!Frame3 = !RAM_SMW_Graphics_DecompressedGFX32
elseif $<Frame3> <= $0BE4
	!Frame3 = (($<Frame3>-$0900)*$20)+!RAM_SMW_Graphics_DecompressedGFX32
else
	!Frame3 = !RAM_SMW_Graphics_DecompressedGFX33
endif
if $<Frame4> < $0600
	!Frame4 = !RAM_SMW_Graphics_DecompressedGFX33
elseif $<Frame4> <= $087F
	!Frame4 = (($<Frame4>-$0600)*$20)+!RAM_SMW_Graphics_DecompressedGFX33
elseif $<Frame4> <= $08FF
	!Frame4 = !RAM_SMW_Graphics_DecompressedGFX32
elseif $<Frame4> <= $0BE4
	!Frame4 = (($<Frame4>-$0900)*$20)+!RAM_SMW_Graphics_DecompressedGFX32
else
	!Frame4 = !RAM_SMW_Graphics_DecompressedGFX33
endif
	dw !Frame1
	dw !Frame2
	dw !Frame3
	dw !Frame4
endmacro

;---------------------------------------------------------------------------

!UP = $03
!DOWN = $02
!LEFT = $01
!RIGHT = $00
!END = $FF

macro SMW_CreateEatBlockPath(Direction, Blocks)
if !<Direction> != $FF
	if <Blocks> < $000F
		db ((<Blocks>&$01FF)<<4)+(!<Direction>&$03)
	else
		!LoopCounter = ((<Blocks>&$01FF)/$0F)
		assert <Blocks> < $0200,"512 tiles is more than enough distance for the Create/Eat Block to travel in one direction."
		assert <Blocks> > $0000,"You can't set the Create/Eat Block to move 0 tiles!"
		while !LoopCounter > 0
			db $F0+(!<Direction>&$03)
			!LoopCounter #= !LoopCounter-$01
		endif
		if (((<Blocks>&$01FF)/$0F)*$0F) != (<Blocks>&$01FF)
			db (((<Blocks>&$01FF)-(((<Blocks>&$01FF)/$0F)*$0F))<<4)+(!<Direction>&$03)
		endif
	endif
else
	db $FF
endif
endmacro

;---------------------------------------------------------------------------

macro SMW_INCGFX(graphic)
SMW_<graphic>:
if !Define_Global_ROMToAssemble&(!ROM_SMW_J) != $00
	incbin "GFX/SMW_J/<graphic>.lz1"
elseif !Define_Global_ROMToAssemble&(!ROM_SMW_E2|!ROM_SMASW_E) != $00
	incbin "GFX/SMW_E2/<graphic>.lz1"
else
	incbin "GFX/SMW_U/<graphic>.lz2"
endif
<graphic>End:
endmacro

;---------------------------------------------------------------------------

macro SMW_InsertOriginalFreespace(ROMID, RtNum)
;print "!<ROMID>Bytes bytes of freespace located at: !<ROMID>OrgLoc"
if !Define_Global_ROMToAssemble&(!ROM_SMW_E1|!ROM_SMW_E2|!ROM_SMW_ARCADE) != $00
	%InsertVersionExclusiveFile(incbin, Misc/GarbageData<RtNum>_, !ROMID.bin, )
else
	fillbyte $FF : fill !<ROMID>Bytes
endif
endmacro

;---------------------------------------------------------------------------