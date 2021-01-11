; RAM Define tags:
; "Player" = RAM address associated with the player sprite in levels.
; "NorSpr" = RAM address associated with normal sprites.
; "NorSprZZ_Y" = RAM address associated with normal sprite Y of ID ZZ. Can also refer to a group of sprites if ZZ is XX.
; "GenSpr" = RAM address associated with a generator sprite.
; "ExtSpr" = RAM address associated with an extended sprite.
; "MExtSpr" = RAM address associated with a minor extended sprite.
; "ClusterSpr" = RAM address associated with a cluster sprite.
; "ScrollSpr" = RAM address associated with a scroll sprite.
; "BounceSpr" = RAM address associated with a bounce sprite.
; "ScoreSpr" = RAM address associated with a Score sprite.
; "CoinSpr" = RAM address associated with a spinning coin sprite.
; "SmokeSpr" = RAM address associated with a smoke sprite.
; "Ending" = RAM address associated with the ending.
; "Level" = RAM address associated with a level function
; "Overworld" = RAM address associated with an overworld function.
; "CastleDestruction" = RAM address associated with a castle destruction cutscene
; "Global" = Used anywhere or close to everywhere.

; Dependency:
; $7E0000-$7E00FF/$7E0200-$7E1FFF = ROUTINE_InitializeFirst8KBOfRAM
; $7E0071-$7E0093 = InitializeLevelRAM
; $7E13DA-$7E1410 = InitializeLevelRAM
; $7E001A-$7E00D7 = ClearOverworldAndCutsceneRAM
; $7E13D3-$7E1BA1 = ClearOverworldAndCutsceneRAM

org $7E8000
base $7E0000

!Define_SMW_DirectPageLocation = $0000

;Mirrored RAM
!RAM_SMW_Misc_ScratchRAM00 = $000000
!RAM_SMW_Misc_ScratchRAM01 = $000001
!RAM_SMW_Misc_ScratchRAM02 = $000002
!RAM_SMW_Misc_ScratchRAM03 = $000003
!RAM_SMW_Misc_ScratchRAM04 = $000004
!RAM_SMW_Misc_ScratchRAM05 = $000005
!RAM_SMW_Misc_ScratchRAM06 = $000006
!RAM_SMW_Misc_ScratchRAM07 = $000007
!RAM_SMW_Misc_ScratchRAM08 = $000008
!RAM_SMW_Misc_ScratchRAM09 = $000009
!RAM_SMW_Misc_ScratchRAM0A = $00000A
!RAM_SMW_Misc_ScratchRAM0B = $00000B
!RAM_SMW_Misc_ScratchRAM0C = $00000C
!RAM_SMW_Misc_ScratchRAM0D = $00000D
!RAM_SMW_Misc_ScratchRAM0E = $00000E
!RAM_SMW_Misc_ScratchRAM0F = $00000F
!RAM_SMW_Flag_Lagging = $000010
!RAM_SMW_Flag_IRQToUse = $000011
!RAM_SMW_Graphics_StripeImageToUpload = $000012
!RAM_SMW_Counter_GlobalFrames = $000013
!RAM_SMW_Counter_LocalFrames = $000014
!RAM_SMW_IO_ControllerHold1 = $000015
!RAM_SMW_IO_ControllerPress1 = $000016
!RAM_SMW_IO_ControllerHold2 = $000017
!RAM_SMW_IO_ControllerPress2 = $000018
!RAM_SMW_Player_CurrentPowerUp = $000019
!RAM_SMW_Mirror_CurrentLayer1XPosLo = $00001A
!RAM_SMW_Mirror_CurrentLayer1XPosHi = !RAM_SMW_Mirror_CurrentLayer1XPosLo+$01
!RAM_SMW_Mirror_CurrentLayer1YPosLo = !RAM_SMW_Mirror_CurrentLayer1XPosLo+$02
!RAM_SMW_Mirror_CurrentLayer1YPosHi = !RAM_SMW_Mirror_CurrentLayer1YPosLo+$01
!RAM_SMW_Mirror_CurrentLayer2XPosLo = !RAM_SMW_Mirror_CurrentLayer1XPosLo+$04
!RAM_SMW_Mirror_CurrentLayer2XPosHi = !RAM_SMW_Mirror_CurrentLayer2XPosLo+$01
!RAM_SMW_Mirror_CurrentLayer2YPosLo = !RAM_SMW_Mirror_CurrentLayer1XPosLo+$06
!RAM_SMW_Mirror_CurrentLayer2YPosHi = !RAM_SMW_Mirror_CurrentLayer2YPosLo+$01
!RAM_SMW_Mirror_Layer3XPosLo = !RAM_SMW_Mirror_CurrentLayer1XPosLo+$08
!RAM_SMW_Mirror_Layer3XPosHi = !RAM_SMW_Mirror_Layer3XPosLo+$01
!RAM_SMW_Mirror_Layer3YPosLo = !RAM_SMW_Mirror_CurrentLayer1XPosLo+$0A
!RAM_SMW_Mirror_Layer3YPosHi = !RAM_SMW_Mirror_Layer3YPosLo+$01
!RAM_SMW_Misc_SecondLevelLayerXPosLo = $000026
!RAM_SMW_Misc_SecondLevelLayerXPosHi = !RAM_SMW_Misc_SecondLevelLayerXPosLo+$01
!RAM_SMW_Misc_SecondLevelLayerYPosLo = $000028
!RAM_SMW_Misc_SecondLevelLayerYPosHi = !RAM_SMW_Misc_SecondLevelLayerYPosLo+$01
!RAM_SMW_Mirror_M7CenterXPosLo = $00002A
!RAM_SMW_Mirror_M7CenterXPosHi = !RAM_SMW_Mirror_M7CenterXPosLo+$01
!RAM_SMW_Mirror_M7CenterYPosLo = $00002C
!RAM_SMW_Mirror_M7CenterYPosHi = !RAM_SMW_Mirror_M7CenterYPosLo+$01
!RAM_SMW_Mirror_M7MatrixALo = $00002E
!RAM_SMW_Mirror_M7MatrixAHi = !RAM_SMW_Mirror_M7MatrixALo+$01
!RAM_SMW_Mirror_M7MatrixBLo = $000030
!RAM_SMW_Mirror_M7MatrixBHi = !RAM_SMW_Mirror_M7MatrixBLo+$01
!RAM_SMW_Mirror_M7MatrixCLo = $000032
!RAM_SMW_Mirror_M7MatrixCHi = !RAM_SMW_Mirror_M7MatrixCLo+$01
!RAM_SMW_Mirror_M7MatrixDLo = $000034
!RAM_SMW_Mirror_M7MatrixDHi = !RAM_SMW_Mirror_M7MatrixDLo+$01
!RAM_SMW_Misc_M7RotationLo = $000036
!RAM_SMW_Misc_M7RotationHi = !RAM_SMW_Misc_M7RotationLo+$01
!RAM_SMW_Misc_M7AngleLo = $000038
!RAM_SMW_Misc_M7AngleHi = !RAM_SMW_Misc_M7AngleLo+$01
!RAM_SMW_Mirror_M7XPosLo = $00003A
!RAM_SMW_Mirror_M7XPosHi = !RAM_SMW_Mirror_M7XPosLo+$01
!RAM_SMW_Mirror_M7YPosLo = !RAM_SMW_Mirror_M7XPosLo+$02
!RAM_SMW_Mirror_M7YPosHi = !RAM_SMW_Mirror_M7XPosLo+$03
!RAM_SMW_Mirror_BGModeAndTileSizeSetting = $00003E
!RAM_SMW_Mirror_OAMAddressLo = $00003F
!RAM_SMW_Mirror_ColorMathSelectAndEnable = $000040
!RAM_SMW_Mirror_BG1And2WindowMaskSettings = $000041
!RAM_SMW_Mirror_BG3And4WindowMaskSettings = $000042
!RAM_SMW_Mirror_ObjectAndColorWindowSettings = $000043
!RAM_SMW_Mirror_ColorMathInitialSettings = $000044
!RAM_SMW_Camera_Layer1RowColumnToUpdateLeftUpLo = $000045
!RAM_SMW_Camera_Layer1RowColumnToUpdateLeftUpHi = !RAM_SMW_Camera_Layer1RowColumnToUpdateLeftUpLo+$01
!RAM_SMW_Camera_Layer1RowColumnToUpdateRightDownLo = !RAM_SMW_Camera_Layer1RowColumnToUpdateLeftUpLo+$02
!RAM_SMW_Camera_Layer1RowColumnToUpdateRightDownHi = !RAM_SMW_Camera_Layer1RowColumnToUpdateLeftUpLo+$03
!RAM_SMW_Camera_InteractiveLayer2RowColumnToUpdateLeftUpLo = $000049
!RAM_SMW_Camera_InteractiveLayer2RowColumnToUpdateLeftUpHi = !RAM_SMW_Camera_InteractiveLayer2RowColumnToUpdateLeftUpLo+$01
!RAM_SMW_Camera_InteractiveLayer2RowColumnToUpdateRightDownLo = !RAM_SMW_Camera_InteractiveLayer2RowColumnToUpdateLeftUpLo+$02
!RAM_SMW_Camera_InteractiveLayer2RowColumnToUpdateRightDownHi = !RAM_SMW_Camera_InteractiveLayer2RowColumnToUpdateLeftUpLo+$03
!RAM_SMW_Camera_XYPositionOfLastLayer1VRAMUpdateLeftUpLo = $00004D
!RAM_SMW_Camera_XYPositionOfLastLayer1VRAMUpdateLeftUpHi = !RAM_SMW_Camera_XYPositionOfLastLayer1VRAMUpdateLeftUpLo+$01
!RAM_SMW_Camera_XYPositionOfLastLayer1VRAMUpdateRightDownLo = !RAM_SMW_Camera_XYPositionOfLastLayer1VRAMUpdateLeftUpLo+$02
!RAM_SMW_Camera_XYPositionOfLastLayer1VRAMUpdateRightDownHi = !RAM_SMW_Camera_XYPositionOfLastLayer1VRAMUpdateLeftUpLo+$03
!RAM_SMW_Camera_XYPositionOfLastInteractiveLayer2VRAMUpdateLeftUpLo = $000051
!RAM_SMW_Camera_XYPositionOfLastInteractiveLayer2VRAMUpdateLeftUpHi = !RAM_SMW_Camera_XYPositionOfLastInteractiveLayer2VRAMUpdateLeftUpLo+$01
!RAM_SMW_Camera_XYPositionOfLastInteractiveLayer2VRAMUpdateRightDownLo = !RAM_SMW_Camera_XYPositionOfLastInteractiveLayer2VRAMUpdateLeftUpLo+$02
!RAM_SMW_Camera_XYPositionOfLastInteractiveLayer2VRAMUpdateRightDownHi = !RAM_SMW_Camera_XYPositionOfLastInteractiveLayer2VRAMUpdateLeftUpLo+$03
!RAM_SMW_Camera_Layer1ScrollingDirection = $000055
!RAM_SMW_Camera_Layer2ScrollingDirection = $000056
!RAM_SMW_Blocks_SubScrPos = $000057
;Empty $000058
!RAM_SMW_Blocks_SizeOrType = $000059
!RAM_SMW_Blocks_ObjectNumber = $00005A
!RAM_SMW_Misc_LevelLayoutFlags = $00005B
;Empty $00005C
!RAM_SMW_Misc_ScreensInLvl = $00005D
!RAM_SMW_Camera_LastScreenHoriz = $00005E
!RAM_SMW_Camera_LastScreenVert = $00005F
;Empty $000060-$000063
!RAM_SMW_Sprites_TilePriority = $000064
!RAM_SMW_Misc_ScratchRAM7E0065 = $000065
	!RAM_SMW_Pointer_Layer1DataLo = !RAM_SMW_Misc_ScratchRAM7E0065
	!RAM_SMW_Misc_CreditsStripeImageHeaderLo = !RAM_SMW_Pointer_Layer1DataLo
	!RAM_SMW_Misc_CreditsBackgroundPageNumber = !RAM_SMW_Pointer_Layer1DataLo
!RAM_SMW_Misc_ScratchRAM7E0066 = !RAM_SMW_Misc_ScratchRAM7E0065+$01
	!RAM_SMW_Pointer_Layer1DataHi = !RAM_SMW_Pointer_Layer1DataLo+$01
	!RAM_SMW_Misc_CreditsStripeImageHeaderHi = 	!RAM_SMW_Misc_CreditsStripeImageHeaderLo+$01
!RAM_SMW_Misc_ScratchRAM7E0067 = !RAM_SMW_Misc_ScratchRAM7E0065+$02
	!RAM_SMW_Pointer_Layer1DataBank = !RAM_SMW_Pointer_Layer1DataLo+$02
	!RAM_SMW_Misc_CreditsStripeImageIndex = !RAM_SMW_Pointer_Layer1DataBank
!RAM_SMW_Pointer_Layer2DataLo = $000068
!RAM_SMW_Pointer_Layer2DataHi = !RAM_SMW_Pointer_Layer2DataLo+$01
!RAM_SMW_Pointer_Layer2DataBank = !RAM_SMW_Pointer_Layer2DataLo+$02
!RAM_SMW_Pointer_LoMap16BlockDataLo = $00006B
!RAM_SMW_Pointer_LoMap16BlockDataHi = !RAM_SMW_Pointer_LoMap16BlockDataLo+$01
!RAM_SMW_Pointer_LoMap16BlockDataBank = !RAM_SMW_Pointer_LoMap16BlockDataLo+$02
!RAM_SMW_Pointer_HiMap16BlockDataLo = $00006E
!RAM_SMW_Pointer_HiMap16BlockDataHi = !RAM_SMW_Pointer_HiMap16BlockDataLo+$01
!RAM_SMW_Pointer_HiMap16BlockDataBank = !RAM_SMW_Pointer_HiMap16BlockDataLo+$02
!RAM_SMW_Player_CurrentState = $000071
!RAM_SMW_Player_InAirFlag = $000072
!RAM_SMW_Player_DuckingFlag = $000073
!RAM_SMW_Player_ClimbingFlag = $000074
!RAM_SMW_Player_SwimmingFlag = $000075
!RAM_SMW_Player_FacingDirection = $000076
!RAM_SMW_Player_BlockedFlags = $000077
!RAM_SMW_Player_HidePlayerTileFlags = $000078
;Empty $000079
!RAM_SMW_Player_SubXSpeed = $00007A
!RAM_SMW_Player_XSpeed = !RAM_SMW_Player_SubXSpeed+$01
!RAM_SMW_Player_SubYSpeed = $00007C					; RAM address used in SMASE
!RAM_SMW_Player_YSpeed = !RAM_SMW_Player_SubYSpeed+$01
!RAM_SMW_Player_OnScreenPosXLo = $00007E
!RAM_SMW_Player_OnScreenPosXHi = !RAM_SMW_Player_OnScreenPosXLo+$01
!RAM_SMW_Player_OnScreenPosYLo = $000080
!RAM_SMW_Player_OnScreenPosYHi = !RAM_SMW_Player_OnScreenPosYLo+$01
!RAM_SMW_Pointer_SlopeSteepnessLo = $000082
!RAM_SMW_Pointer_SlopeSteepnessHi = !RAM_SMW_Pointer_SlopeSteepnessLo+$01
!RAM_SMW_Pointer_SlopeSteepnessBank = !RAM_SMW_Pointer_SlopeSteepnessLo+$02
!RAM_SMW_Flag_UnderwaterLevel = $000085
!RAM_SMW_Flag_IceLevel = $000086
;Empty $000087
!RAM_SMW_Player_TimerBeforeWarpingInPipe = $000088
	!RAM_SMW_Player_CutsceneInputTimer1 = $000088
!RAM_SMW_Player_PipeAction = $000089
	!RAM_SMW_Player_CutsceneInputTimer2 = $000089
!RAM_SMW_Misc_ScratchRAM8A = $00008A
!RAM_SMW_Misc_ScratchRAM8B = $00008B
!RAM_SMW_Misc_ScratchRAM8C = $00008C
!RAM_SMW_Misc_ScratchRAM8D = $00008D
!RAM_SMW_Misc_ScratchRAM8E = $00008E
!RAM_SMW_Misc_ScratchRAM8F = $00008F
!RAM_SMW_Player_YPosInBlock = $000090
!RAM_SMW_Player_VerticalDirectionToPushOutOfBlock = $000091
!RAM_SMW_Player_XPosInBlock = $000092
!RAM_SMW_Player_HorizontalSideOfBlockBeingTouched = $000093
!RAM_SMW_Player_XPosLo = $000094
!RAM_SMW_Player_XPosHi = !RAM_SMW_Player_XPosLo+$01
!RAM_SMW_Player_YPosLo = $000096
!RAM_SMW_Player_YPosHi = !RAM_SMW_Player_YPosLo+$01
!RAM_SMW_Blocks_YPosLo = $000098
!RAM_SMW_Blocks_YPosHi = !RAM_SMW_Blocks_YPosLo+$01
!RAM_SMW_Blocks_XPosLo = $00009A
!RAM_SMW_Blocks_XPosHi = !RAM_SMW_Blocks_XPosLo+$01
!RAM_SMW_Blocks_Map16ToGenerate = $00009C
!RAM_SMW_Flag_SpritesLocked = $00009D
!RAM_SMW_NorSpr_SpriteID = $00009E
!RAM_SMW_NorSpr_YSpeed = $0000AA
!RAM_SMW_NorSpr_XSpeed = $0000B6
!RAM_SMW_NorSpr_Table7E00C2 = $0000C2
	!RAM_SMW_NorSprXXX_CurrentlyActiveBoss = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_Pointer_SpriteListDataLo = $0000CE
!RAM_SMW_Pointer_SpriteListDataHi = !RAM_SMW_Pointer_SpriteListDataLo+$01
!RAM_SMW_Pointer_SpriteListDataBank = !RAM_SMW_Pointer_SpriteListDataLo+$02
!RAM_SMW_Player_CurrentXPosLo = !RAM_SMW_Player_XPosLo+$3D				;$0000D1
!RAM_SMW_Player_CurrentXPosHi = !RAM_SMW_Player_CurrentXPosLo+$01
!RAM_SMW_Player_CurrentYPosLo = !RAM_SMW_Player_YPosLo+$3D				;$0000D3
!RAM_SMW_Player_CurrentYPosHi = !RAM_SMW_Player_CurrentYPosLo+$01
!RAM_SMW_NorSpr086_Wiggler_SegmentPosPtrLo = $0000D5
!RAM_SMW_NorSpr086_Wiggler_SegmentPosPtrHi = !RAM_SMW_NorSpr086_Wiggler_SegmentPosPtrLo+$01
!RAM_SMW_NorSpr086_Wiggler_SegmentPosPtrBank = !RAM_SMW_NorSpr086_Wiggler_SegmentPosPtrLo+$02
!RAM_SMW_NorSpr_YPosLo = $0000D8
!RAM_SMW_NorSpr_XPosLo = !RAM_SMW_NorSpr_YPosLo+(!Define_SMW_MaxNormalSpriteSlot+$01)
;Empty $0000F0-$0000FF
!RAM_SMW_Misc_EndOfStack = !RAM_SMW_Misc_StartOfStack-$FF
	!RAM_SMW_Misc_GameMode = $000100
	!RAM_SMW_Misc_CurrentlyLoadedSpriteGraphicsFiles = $000101
	!RAM_SMW_Misc_CurrentlyLoadedLayerGraphicsFiles = $000105
	!RAM_SMW_Misc_IntroLevelFlag = $000109
	!RAM_SMW_Misc_CurrentSaveFile = $00010A
	!RAM_SMW_Misc_ScratchRAM0110 = $000110					; RAM address used in SMASE
	!RAM_SMW_Misc_StartOfStack = $0001FF
!RAM_SMW_IO_OAMBuffer = $000200
!RAM_SMW_Sprites_OAMTileSizeBuffer = $000420
!RAM_SMW_Misc_HDMAWindowEffectTable = $0004A0						; $0004A0-$00067F
!RAM_SMW_Palettes_PaletteUploadTableIndex = $000680
!RAM_SMW_Palettes_DynamicPaletteUploadIndex = $000681
!RAM_SMW_Palettes_DynamicPaletteBytesToUpload = $000682						; Note: Due to how this works, $000682, $000703 and $000905 must all be in the $000000-$001FFF range
!RAM_SMW_Palettes_DynamicPaletteCGRAMAddress = !RAM_SMW_Palettes_DynamicPaletteBytesToUpload+$01
!RAM_SMW_Palettes_DynamicPaletteColors = !RAM_SMW_Palettes_DynamicPaletteBytesToUpload+$02
;Empty $000695-$000700
!RAM_SMW_Palettes_BackgroundColorLo = $000701
!RAM_SMW_Palettes_BackgroundColorHi = !RAM_SMW_Palettes_BackgroundColorLo+$01
!RAM_SMW_Palettes_PaletteMirror = !RAM_SMW_Palettes_BackgroundColorLo+$02
!RAM_SMW_Palettes_CopyOfBackgroundColorLo = $000903
!RAM_SMW_Palettes_CopyOfBackgroundColorHi = !RAM_SMW_Palettes_CopyOfBackgroundColorLo+$01
!RAM_SMW_Palettes_CopyOfPaletteMirror = !RAM_SMW_Palettes_CopyOfBackgroundColorLo+$02
!RAM_SMW_UnusedRAM_7E0AF5 = $000AF5
!RAM_SMW_Misc_ScratchRAM7E0AF6 = $000AF6
	!RAM_SMW_Graphics_DecompressedOverworldGFX = !RAM_SMW_Misc_ScratchRAM7E0AF6
	!RAM_SMW_Misc_IggyLarryPlatformInteraction = !RAM_SMW_Misc_ScratchRAM7E0AF6
	!RAM_SMW_Sprites_CutsceneSpriteTable7E0AF6 = !RAM_SMW_Misc_ScratchRAM7E0AF6
	!RAM_SMW_CutsceneSprites_CreditsEgg_YAcceleration = !RAM_SMW_Misc_ScratchRAM7E0AF6
	!RAM_SMW_Sprites_CutsceneSpriteYSpeed = !RAM_SMW_Misc_ScratchRAM7E0AF6+$0F
		!RAM_SMW_Sprites_SmallCastleDoorYSpeed = !RAM_SMW_Sprites_CutsceneSpriteYSpeed
		!RAM_SMW_Sprites_CastleDustYSpeed = !RAM_SMW_Sprites_CutsceneSpriteYSpeed+$01
		!RAM_SMW_Sprites_FarawayCastleRocketYSpeed = !RAM_SMW_Sprites_CutsceneSpriteYSpeed+$02
		!RAM_SMW_Sprites_EndingYoshisYSpeed = !RAM_SMW_Sprites_CutsceneSpriteYSpeed+$01
	!RAM_SMW_Sprites_CutsceneSpriteXSpeed = $000B14
		!RAM_SMW_Sprites_WhiteFlagYSpeed = !RAM_SMW_Sprites_CutsceneSpriteXSpeed+$01
		!RAM_SMW_Sprites_SmallCastleDoorXSpeed = !RAM_SMW_Sprites_CutsceneSpriteXSpeed
		!RAM_SMW_Sprites_FarawayCastleRocketXSpeed = !RAM_SMW_Sprites_CutsceneSpriteXSpeed+$02
		!RAM_SMW_Sprites_EndingPlayerXSpeed = !RAM_SMW_Sprites_CutsceneSpriteXSpeed
	!RAM_SMW_Sprites_CutsceneSpriteSubYPos = $000B23
	!RAM_SMW_Sprites_CutsceneSpriteSubXPos = $000B32
		!RAM_SMW_Sprites_EndingPlayerSubXPos = !RAM_SMW_Sprites_CutsceneSpriteSubXPos
		!RAM_SMW_Sprites_EndingYoshisSubXPos = !RAM_SMW_Sprites_CutsceneSpriteSubXPos+$01
	!RAM_SMW_Sprites_CutsceneSpriteYPosLo = $000B41
		!RAM_SMW_Sprites_SmallCastleDoorYPosLo = !RAM_SMW_Sprites_CutsceneSpriteYPosLo
		!RAM_SMW_Sprites_CastleDustYPos = !RAM_SMW_Sprites_CutsceneSpriteYPosLo+$01
		!RAM_SMW_Sprites_CastleRocketFlameYPos = !RAM_SMW_Sprites_CutsceneSpriteYPosLo+$02
		!RAM_SMW_Sprites_FarawayCastleRocketYPosLo = !RAM_SMW_Sprites_CutsceneSpriteYPosLo+$02
		!RAM_SMW_Sprites_RoyCutscenePlayerCoughYPosLo = !RAM_SMW_Sprites_CutsceneSpriteYPosLo+$02
		!RAM_SMW_Sprites_MortonCutscenePlayerCoughYPosLo = !RAM_SMW_Sprites_CutsceneSpriteYPosLo+$03
		!RAM_SMW_Sprites_EndingYoshisYPosLo = !RAM_SMW_Sprites_CutsceneSpriteYPosLo+$01
	!RAM_SMW_Sprites_CutsceneSpriteXPosLo = $000B50
		!RAM_SMW_Sprites_SmallCastleDoorXPosLo = !RAM_SMW_Sprites_CutsceneSpriteXPosLo
		!RAM_SMW_Sprites_TNTFuseAndLineXPos = !RAM_SMW_Sprites_CutsceneSpriteXPosLo
		!RAM_SMW_Sprites_CastleDustXPos = !RAM_SMW_Sprites_CutsceneSpriteXPosLo+$01
		!RAM_SMW_Sprites_WhiteFlagYPosLo = !RAM_SMW_Sprites_CutsceneSpriteXPosLo+$01
		!RAM_SMW_Sprites_FarawayCastleRocketXPosLo = !RAM_SMW_Sprites_CutsceneSpriteXPosLo+$02
		!RAM_SMW_Sprites_MortonCutscenePlayerCoughXPosLo = !RAM_SMW_Sprites_CutsceneSpriteXPosLo+$03
		!RAM_SMW_Sprites_EndingPlayerXPosLo = !RAM_SMW_Sprites_CutsceneSpriteXPosLo
	!RAM_SMW_Sprites_CutsceneSpriteYPosHi = $000B5F
		!RAM_SMW_Sprites_SmallCastleDoorYPosHi = !RAM_SMW_Sprites_CutsceneSpriteYPosHi
		!RAM_SMW_Sprites_WhiteFlagYPosHi = !RAM_SMW_Sprites_CutsceneSpriteXPosHi+$01
		!RAM_SMW_Sprites_FarawayCastleRocketYPosHi = !RAM_SMW_Sprites_CutsceneSpriteYPosHi+$02
		!RAM_SMW_Sprites_EndingYoshisYPosHi = !RAM_SMW_Sprites_CutsceneSpriteYPosHi+$01
	!RAM_SMW_Sprites_CutsceneSpriteXPosHi = $000B6E
		!RAM_SMW_Sprites_SmallCastleDoorXPosHi = !RAM_SMW_Sprites_CutsceneSpriteXPosHi
		!RAM_SMW_Sprites_FarawayCastleRocketXPosHi = !RAM_SMW_Sprites_CutsceneSpriteXPosHi+$02
		!RAM_SMW_Sprites_EndingPlayerXPosHi = !RAM_SMW_Sprites_CutsceneSpriteXPosHi
	!RAM_SMW_CutsceneSpr_HammerDebris_YAcceleration = $000B7D
	!RAM_SMW_CutsceneSpr_HammerDebris_CurrentStatus = $000B8C
!RAM_SMW_Graphics_TileAnimationSourceAddress1Lo = $000D76
!RAM_SMW_Graphics_TileAnimationSourceAddress1Hi = !RAM_SMW_Graphics_TileAnimationSourceAddress1Lo+$01
!RAM_SMW_Graphics_TileAnimationSourceAddress2Lo = !RAM_SMW_Graphics_TileAnimationSourceAddress1Lo+$02
!RAM_SMW_Graphics_TileAnimationSourceAddress2Hi = !RAM_SMW_Graphics_TileAnimationSourceAddress1Lo+$03
!RAM_SMW_Graphics_TileAnimationSourceAddress3Lo = !RAM_SMW_Graphics_TileAnimationSourceAddress1Lo+$04
!RAM_SMW_Graphics_TileAnimationSourceAddress3Hi = !RAM_SMW_Graphics_TileAnimationSourceAddress1Lo+$05
!RAM_SMW_Graphics_TileAnimationVRAMAddress1Lo = $000D7C
!RAM_SMW_Graphics_TileAnimationVRAMAddress1Hi = !RAM_SMW_Graphics_TileAnimationVRAMAddress1Lo+$01
!RAM_SMW_Graphics_TileAnimationVRAMAddress2Lo = $000D7E
!RAM_SMW_Graphics_TileAnimationVRAMAddress2Hi = !RAM_SMW_Graphics_TileAnimationVRAMAddress2Lo+$01
!RAM_SMW_Graphics_TileAnimationVRAMAddress3Lo = $000D80
!RAM_SMW_Graphics_TileAnimationVRAMAddress3Hi = !RAM_SMW_Graphics_TileAnimationVRAMAddress3Lo+$01
!RAM_SMW_Pointer_PlayerPaletteLo = $000D82
!RAM_SMW_Pointer_PlayerPaletteHi = !RAM_SMW_Pointer_PlayerPaletteLo+$01
!RAM_SMW_Player_NumberOfTilesToUpdate = $000D84
!RAM_SMW_Graphics_DynamicSpritePointersTopLo = $000D85
!RAM_SMW_Graphics_DynamicSpritePointersBottomLo = !RAM_SMW_Graphics_DynamicSpritePointersTopLo+$0A
!RAM_SMW_Graphics_DynamicSpriteTile7FLo = $000D99
!RAM_SMW_Graphics_DynamicSpriteTile7FHi = !RAM_SMW_Graphics_DynamicSpriteTile7FLo+$01
!RAM_SMW_Misc_NMIToUseFlag = $000D9B
;Empty $000D9C
!RAM_SMW_Mirror_MainScreenLayers = $000D9D
!RAM_SMW_Mirror_SubScreenLayers = $000D9E
!RAM_SMW_Mirror_HDMAEnable = $000D9F
!RAM_SMW_IO_ControllersPluggedIn = $000DA0
;Empty $000DA1
!RAM_SMW_IO_ControllerHold1CopyP1 = $000DA2
!RAM_SMW_IO_ControllerHold1CopyP2 = !RAM_SMW_IO_ControllerHold1CopyP1+$01
!RAM_SMW_IO_ControllerHold2CopyP1 = !RAM_SMW_IO_ControllerHold1CopyP1+$02
!RAM_SMW_IO_ControllerHold2CopyP2 = !RAM_SMW_IO_ControllerHold1CopyP1+$03
!RAM_SMW_IO_ControllerPress1CopyP1 = !RAM_SMW_IO_ControllerHold1CopyP1+$04
!RAM_SMW_IO_ControllerPress1CopyP2 = !RAM_SMW_IO_ControllerHold1CopyP1+$05
!RAM_SMW_IO_ControllerPress2CopyP1 = !RAM_SMW_IO_ControllerHold1CopyP1+$06
!RAM_SMW_IO_ControllerPress2CopyP2 = !RAM_SMW_IO_ControllerHold1CopyP1+$07
!RAM_SMW_IO_P1CtrlDisableLo = $000DAA
!RAM_SMW_IO_P2CtrlDisableLo = !RAM_SMW_IO_P1CtrlDisableLo+$01
!RAM_SMW_IO_P1CtrlDisableHi = !RAM_SMW_IO_P1CtrlDisableLo+$02
!RAM_SMW_IO_P2CtrlDisableHi = !RAM_SMW_IO_P1CtrlDisableLo+$03
!RAM_SMW_Mirror_ScreenDisplayRegister = $000DAE
!RAM_SMW_Misc_MosaicDirection = $000DAF
!RAM_SMW_Mirror_MosaicSizeAndBGEnable = $000DB0
!RAM_SMW_Timer_KeepGameModeActive = $000DB1
!RAM_SMW_Flag_TwoPlayerGame = $000DB2
!RAM_SMW_Player_CurrentCharacter = $000DB3
!RAM_SMW_Player_MariosLives = $000DB4
!RAM_SMW_Player_LuigisLives = !RAM_SMW_Player_MariosLives+$01
!RAM_SMW_Player_MariosCoins = $000DB6
!RAM_SMW_Player_LuigisCoins = !RAM_SMW_Player_MariosCoins+$01
!RAM_SMW_Player_MariosPowerUp = $000DB8
!RAM_SMW_Player_LuigisPowerUp = !RAM_SMW_Player_MariosPowerUp+$01
!RAM_SMW_Player_MariosYoshi = $000DBA
!RAM_SMW_Player_LuigisYoshi = !RAM_SMW_Player_MariosYoshi+$01
!RAM_SMW_Player_MariosItemBox = $000DBC
!RAM_SMW_Player_LuigisItemBox = !RAM_SMW_Player_MariosItemBox+$01
!RAM_SMW_Player_CurrentLifeCount = $000DBE
!RAM_SMW_Player_CurrentCoinCount = $000DBF
!RAM_SMW_Counter_GreenStarBlock = $000DC0
!RAM_SMW_Yoshi_CarryOverLevelsFlag = $000DC1
!RAM_SMW_Player_CurrentItemBox = $000DC2
!RAM_SMW_UnusedRAM_7E0DC3 = $000DC3
;Empty $000DC4-$000DC6
!RAM_SMW_Player_OverworldXPosMarioIsGoingToLo = $000DC7
!RAM_SMW_Player_OverworldXPosMarioIsGoingToHi = !RAM_SMW_Player_OverworldXPosMarioIsGoingToLo+$01
!RAM_SMW_Player_OverworldYPosMarioIsGoingToLo = !RAM_SMW_Player_OverworldXPosMarioIsGoingToLo+$02
!RAM_SMW_Player_OverworldYPosMarioIsGoingToHi = !RAM_SMW_Player_OverworldXPosMarioIsGoingToLo+$03
!RAM_SMW_Player_OverworldXPosLuigiIsGoingToLo = !RAM_SMW_Player_OverworldXPosMarioIsGoingToLo+$04
!RAM_SMW_Player_OverworldXPosLuigiIsGoingToHi = !RAM_SMW_Player_OverworldXPosMarioIsGoingToLo+$05
!RAM_SMW_Player_OverworldYPosLuigiIsGoingToLo = !RAM_SMW_Player_OverworldXPosMarioIsGoingToLo+$06
!RAM_SMW_Player_OverworldYPosLuigiIsGoingToHi = !RAM_SMW_Player_OverworldXPosMarioIsGoingToLo+$07
!RAM_SMW_Player_OverworldXSpeedLo = $000DCF
!RAM_SMW_Player_OverworldXSpeedHi = !RAM_SMW_Player_OverworldXSpeedLo+$01
!RAM_SMW_Player_OverworldYSpeedLo = !RAM_SMW_Player_OverworldXSpeedLo+$02
!RAM_SMW_Player_OverworldYSpeedHi = !RAM_SMW_Player_OverworldXSpeedLo+$03
!RAM_SMW_Overworld_PlayerDirection = $000DD3
!RAM_SMW_UnusedRAM_7E0DD4 = $000DD4
!RAM_SMW_Misc_ExitLevelAction = $000DD5
!RAM_SMW_Player_CurrentCharacterX4Lo = $000DD6
!RAM_SMW_Player_CurrentCharacterX4Hi = !RAM_SMW_Player_CurrentCharacterX4Lo+$01
!RAM_SMW_Flag_SwitchPlayers = $000DD8
;Empty $000DD9
!RAM_SMW_Misc_MusicRegisterBackup = $000DDA
;Empty $000DDB-$000DDD
!RAM_SMW_Misc_WhichFileToErase = $000DDE
	!RAM_SMW_Sprites_CurrentlyProcessedOverworldSprite = $000DDE
!RAM_SMW_Sprites_StartingOAMIndexForOverworldSprites = $000DDF
!RAM_SMW_Sprites_OverworldCloudSyncTable = $000DE0
!RAM_SMW_OWSpr_SpriteID = $000DE5
!RAM_SMW_OWSpr_Table7E0DF5 = $000DF5
!RAM_SMW_OWSpr_Table7E0E05 = !RAM_SMW_OWSpr_Table7E0DF5+((!Define_SMW_MaxOverworldSpriteSlot+$01)*$01)
!RAM_SMW_OWSpr_Table7E0E15 = $000E15
!RAM_SMW_OWSpr_Table7E0E25 = $000E25
!RAM_SMW_OWSpr_XPosLo = $000E35
!RAM_SMW_OWSpr_YPosLo = !RAM_SMW_OWSpr_XPosLo+((!Define_SMW_MaxOverworldSpriteSlot+$01)*$01)
!RAM_SMW_OWSpr_ZPosLo = !RAM_SMW_OWSpr_XPosLo+((!Define_SMW_MaxOverworldSpriteSlot+$01)*$02)
!RAM_SMW_OWSpr_XPosHi = $000E65
!RAM_SMW_OWSpr_YPosHi = !RAM_SMW_OWSpr_XPosHi+((!Define_SMW_MaxOverworldSpriteSlot+$01)*$01)
!RAM_SMW_OWSpr_ZPosHi = !RAM_SMW_OWSpr_XPosHi+((!Define_SMW_MaxOverworldSpriteSlot+$01)*$02)
!RAM_SMW_OWSpr_XSpeed = $000E95
!RAM_SMW_OWSpr_YSpeed = !RAM_SMW_OWSpr_XSpeed+((!Define_SMW_MaxOverworldSpriteSlot+$01)*$01)
!RAM_SMW_OWSpr_ZSpeed = !RAM_SMW_OWSpr_XSpeed+((!Define_SMW_MaxOverworldSpriteSlot+$01)*$02)
!RAM_SMW_OWSpr_SubXPos = $000EC5
!RAM_SMW_OWSpr_SubYPos = !RAM_SMW_OWSpr_SubXPos+((!Define_SMW_MaxOverworldSpriteSlot+$01)*$01)
!RAM_SMW_OWSpr_SubZPos = !RAM_SMW_OWSpr_SubXPos+((!Define_SMW_MaxOverworldSpriteSlot+$01)*$02)
!RAM_SMW_OWSpr06_KoopaKid_ActivateFlag = $000EF5
!RAM_SMW_OWSpr06_KoopaKid_TileIndex = $000EF6
!RAM_SMW_Overworld_EnterLevelFlag = $000EF7
!RAM_SMW_Flag_YoshiSaved = $000EF8
!RAM_SMW_Misc_StatusBarTilemap = $000EF9

!RAM_SMW_Misc_StatusBar_Player = !RAM_SMW_Misc_StatusBarTilemap+((SMW_StatusBarTilemap_SecondRow_Mario-SMW_StatusBarTilemap_SecondRow)/2)
!RAM_SMW_Misc_StatusBar_YoshiCoin1 = !RAM_SMW_Misc_StatusBarTilemap+((SMW_StatusBarTilemap_SecondRow_YoshiCoins-SMW_StatusBarTilemap_SecondRow)/2)
!RAM_SMW_Misc_StatusBar_YoshiCoin2 = !RAM_SMW_Misc_StatusBar_YoshiCoin1+$01
!RAM_SMW_Misc_StatusBar_YoshiCoin3 = !RAM_SMW_Misc_StatusBar_YoshiCoin1+$02
!RAM_SMW_Misc_StatusBar_YoshiCoin4 = !RAM_SMW_Misc_StatusBar_YoshiCoin1+$03
!RAM_SMW_Misc_StatusBar_TopBonusStarsHi = !RAM_SMW_Misc_StatusBarTilemap+((SMW_StatusBarTilemap_SecondRow_BonusStarNumbers-SMW_StatusBarTilemap_SecondRow)/2)
!RAM_SMW_Misc_StatusBar_TopBonusStarsLo = !RAM_SMW_Misc_StatusBar_TopBonusStarsHi+$01
!RAM_SMW_Misc_StatusBar_ItemBox = !RAM_SMW_Misc_StatusBarTilemap+((SMW_StatusBarTilemap_SecondRow_ItemBox-SMW_StatusBarTilemap_SecondRow)/2)
!RAM_SMW_Misc_StatusBar_CoinsHi = !RAM_SMW_Misc_StatusBarTilemap+((SMW_StatusBarTilemap_SecondRow_Coins-SMW_StatusBarTilemap_SecondRow)/2)+$03
!RAM_SMW_Misc_StatusBar_CoinsLo = !RAM_SMW_Misc_StatusBar_CoinsHi+$01
!RAM_SMW_Misc_StatusBar_LivesHi = !RAM_SMW_Misc_StatusBarTilemap+((SMW_StatusBarTilemap_ThirdRow_Lives-SMW_StatusBarTilemap_SecondRow)/2)+$01
!RAM_SMW_Misc_StatusBar_LivesLo = !RAM_SMW_Misc_StatusBar_LivesHi+$01
!RAM_SMW_Misc_StatusBar_BottomBonusStarsHi = !RAM_SMW_Misc_StatusBar_TopBonusStarsHi+((SMW_StatusBarTilemap_ThirdRow_BonusStarNumbers-SMW_StatusBarTilemap_SecondRow_BonusStarNumbers)/2)
!RAM_SMW_Misc_StatusBar_BottomBonusStarsLo = !RAM_SMW_Misc_StatusBar_BottomBonusStarsHi+$01
!RAM_SMW_Misc_StatusBar_TimerHundreds = !RAM_SMW_Misc_StatusBarTilemap+((SMW_StatusBarTilemap_ThirdRow_Time-SMW_StatusBarTilemap_SecondRow)/2)
!RAM_SMW_Misc_StatusBar_TimerTens = !RAM_SMW_Misc_StatusBar_TimerHundreds+$01
!RAM_SMW_Misc_StatusBar_TimerOnes = !RAM_SMW_Misc_StatusBar_TimerHundreds+$02
!RAM_SMW_Misc_StatusBar_ScoreMillions = !RAM_SMW_Misc_StatusBarTilemap+((SMW_StatusBarTilemap_ThirdRow_Score-SMW_StatusBarTilemap_SecondRow)/2)
!RAM_SMW_Misc_StatusBar_ScoreHundredThousands = !RAM_SMW_Misc_StatusBar_ScoreMillions+$01
!RAM_SMW_Misc_StatusBar_ScoreTenThousands = !RAM_SMW_Misc_StatusBar_ScoreMillions+$02
!RAM_SMW_Misc_StatusBar_ScoreThousands = !RAM_SMW_Misc_StatusBar_ScoreMillions+$03
!RAM_SMW_Misc_StatusBar_ScoreHundreds = !RAM_SMW_Misc_StatusBar_ScoreMillions+$04
!RAM_SMW_Misc_StatusBar_ScoreTens = !RAM_SMW_Misc_StatusBar_ScoreMillions+$05

!RAM_SMW_Counter_TimerFrames = $000F30
!RAM_SMW_Counter_TimerHundreds = $000F31
!RAM_SMW_Counter_TimerTens = !RAM_SMW_Counter_TimerHundreds+$01
!RAM_SMW_Counter_TimerOnes = !RAM_SMW_Counter_TimerHundreds+$02
!RAM_SMW_Player_MarioScoreLo = $000F34
!RAM_SMW_Player_MarioScoreMid = !RAM_SMW_Player_MarioScoreLo+$01
!RAM_SMW_Player_MarioScoreHi = !RAM_SMW_Player_MarioScoreLo+$02
!RAM_SMW_Player_LuigiScoreLo = !RAM_SMW_Player_MarioScoreLo+$03
!RAM_SMW_Player_LuigiScoreMid = !RAM_SMW_Player_MarioScoreLo+$04
!RAM_SMW_Player_LuigiScoreHi = !RAM_SMW_Player_MarioScoreLo+$05
;Empty $000F3A-$000F3F
!RAM_SMW_Counter_LevelEndScoreTallyLo = $000F40
!RAM_SMW_Counter_LevelEndScoreTallyHi = !RAM_SMW_Counter_LevelEndScoreTallyLo+$01
;Empty $000F42-$000F47
!RAM_SMW_Player_MarioBonusStars = $000F48
!RAM_SMW_Player_LuigiBonusStars = !RAM_SMW_Player_MarioBonusStars+$01
!RAM_SMW_ClusterSpr_Table7E0F4A = $000F4A
;Empty $000F5E-$000F71
!RAM_SMW_ClusterSpr_Table7E0F72 = $000F72
!RAM_SMW_ClusterSpr_Table7E0F86 = $000F86
!RAM_SMW_ClusterSpr_Table7E0F9A = $000F9A
!RAM_SMW_ClusterSpr04_BooRing_Ring1AngleLo = $000FAE
!RAM_SMW_ClusterSpr04_BooRing_Ring2AngleLo = !RAM_SMW_ClusterSpr04_BooRing_Ring1AngleLo+$01
!RAM_SMW_ClusterSpr04_BooRing_Ring1AngleHi = $000FB0
!RAM_SMW_ClusterSpr04_BooRing_Ring2AngleHi = !RAM_SMW_ClusterSpr04_BooRing_Ring2AngleHi+$01
!RAM_SMW_ClusterSpr04_BooRing_Ring1CenterXPosLo = $000FB2
!RAM_SMW_ClusterSpr04_BooRing_Ring2CenterXPosLo = !RAM_SMW_ClusterSpr04_BooRing_Ring1CenterXPosLo+$01
!RAM_SMW_ClusterSpr04_BooRing_Ring1CenterXPosHi = $000FB4
!RAM_SMW_ClusterSpr04_BooRing_Ring2CenterXPosHi = !RAM_SMW_ClusterSpr04_BooRing_Ring1CenterXPosHi+$01
!RAM_SMW_ClusterSpr04_BooRing_Ring1CenterYPosLo = $000FB6
!RAM_SMW_ClusterSpr04_BooRing_Ring2CenterYPosLo = !RAM_SMW_ClusterSpr04_BooRing_Ring1CenterYPosLo+$01
!RAM_SMW_ClusterSpr04_BooRing_Ring1CenterYPosHi = $000FB8
!RAM_SMW_ClusterSpr04_BooRing_Ring2CenterYPosHi = !RAM_SMW_ClusterSpr04_BooRing_Ring1CenterYPosHi+$01
!RAM_SMW_ClusterSpr04_BooRing_Ring1OffscreenFlag = $000FBA
!RAM_SMW_ClusterSpr04_BooRing_Ring2OffscreenFlag = !RAM_SMW_ClusterSpr04_BooRing_Ring1OffscreenFlag+$01
!RAM_SMW_ClusterSpr04_BooRing_UnusedRing1LevelListIndex = $000FBC
!RAM_SMW_ClusterSpr04_BooRing_UnusedRing2LevelListIndex = !RAM_SMW_ClusterSpr04_BooRing_Ring1LevelListIndex+$01
!RAM_SMW_Pointer_Map16Tiles = $000FBE			; 1024 bytes
!RAM_SMW_Misc_ItemMemorySetting = $0013BE
!RAM_SMW_Overworld_LevelNumberLo = $0013BF
!RAM_SMW_UnusedRAM_LevelNumberHi = !RAM_SMW_Overworld_LevelNumber+$01
!RAM_SMW_Overworld_TilePlayerIsStandingdOnLo = $0013C1
!RAM_SMW_Overworld_TilePlayerIsStandingdOnHi = !RAM_SMW_Overworld_TilePlayerIsStandingdOnLo+$01
!RAM_SMW_Overworld_CurrentlyLoadedSubmapLo = $0013C3
!RAM_SMW_Overworld_CurrentlyLoadedSubmapHi = !RAM_SMW_Overworld_CurrentlyLoadedSubmapLo+$01
!RAM_SMW_UnusedRAM_3upMoonsCounter = $0013C5
!RAM_SMW_Misc_CurrentlyActiveBossEndCutscene = $0013C6
!RAM_SMW_Yoshi_CurrentYoshiColor = $0013C7
;Empty $0013C8
!RAM_SMW_Flag_ShowContinueAndEnd = $0013C9
!RAM_SMW_Flag_ShowSavePrompt = $0013CA
!RAM_SMW_UnusedRAM_GotInvincibleStarFromGoal = $0013CB
!RAM_SMW_Counter_CoinHandler = $0013CC
!RAM_SMW_UnusedRAM_DisableMidpoint = $0013CD
!RAM_SMW_Flag_GotMidpoint = $0013CE
	!RAM_SMW_Flag_ActivateOverworldEvent = !RAM_SMW_Flag_GotMidpoint
!RAM_SMW_Flag_OverrideNoYoshiIntroForMidwayEntrance = $0013CF
!RAM_SMW_Overworld_DestroyTileEventTileIndex = $0013D0
!RAM_SMW_Overworld_DestroyTileEventVRAMIndex = $0013D1
!RAM_SMW_Misc_ColorOfPalaceSwitchPressed1 = $0013D2
!RAM_SMW_Timer_PreventPause = $0013D3
!RAM_SMW_Flag_Pause = $0013D4
	!RAM_SMW_Flag_MainMapFreeScrolling = $0013D4
!RAM_SMW_Flag_DisableLayer3Scroll = $0013D5
	!RAM_SMW_Player_OverworldSubXPosLo = $0013D5
!RAM_SMW_Timer_WaitBeforeScoreTally = $0013D6
	!RAM_SMW_Player_OverworldSubXPosHi = !RAM_SMW_Player_OverworldSubXPosLo+$01
!RAM_SMW_Player_OverworldSubYPosLo = !RAM_SMW_Player_OverworldSubXPosLo+$02
!RAM_SMW_Player_OverworldSubYPosHi = !RAM_SMW_Player_OverworldSubXPosLo+$03
!RAM_SMW_Pointer_CurrentOverworldProcess = $0013D9
	!RAM_SMW_Pointer_CurrentLevelEndProcess = $0013D9
!RAM_SMW_Player_SubXPos = $0013DA
!RAM_SMW_Player_WalkingFrame = $0013DB
!RAM_SMW_Player_SubYPos = !RAM_SMW_Player_SubXPos+$02
!RAM_SMW_Player_TurningAroundFlag = $0013DD
!RAM_SMW_Player_OverrideWalkingFrames = $0013DE
!RAM_SMW_Player_CapeImage = $0013DF
!RAM_SMW_Player_CurrentPose = $0013E0
!RAM_SMW_Player_SlopePlayerIsOn1 = $0013E1
!RAM_SMW_Player_SpinjumpFireballTimer = $0013E2
!RAM_SMW_Player_WallWalkStatus = $0013E3
!RAM_SMW_Player_PMeter = $0013E4
!RAM_SMW_Player_AnimationSpeedIndex = $0013E5
;Empty $0013E6-$0013E7
!RAM_SMW_Flag_CapeToSpriteInteraction = $0013E8
!RAM_SMW_Player_CapeHitboxXLo = $0013E9
!RAM_SMW_Player_CapeHitboxXHi = !RAM_SMW_Player_CapeHitboxXLo+$01
!RAM_SMW_Player_CapeHitboxYLo = $0013EB
!RAM_SMW_Player_CapeHitboxYHi = !RAM_SMW_Player_CapeHitboxYLo+$01
!RAM_SMW_Player_SlidingOnGround = $0013ED
!RAM_SMW_Player_SlopePlayerIsOn2 = $0013EE
!RAM_SMW_Player_OnGroundFlag = $0013EF
!RAM_SMW_Player_FacingDirectionOnNetDoor = $0013F0
!RAM_SMW_Flag_EnableVerticalScroll = $0013F1
!RAM_SMW_UnusedRAM_7E13F2 = $0013F2
!RAM_SMW_Timer_InflateFromPBalloon = $0013F3
!RAM_SMW_Blocks_GiveLifeInCoinBonusGameFlagsRow1 = $0013F4
!RAM_SMW_Blocks_GiveLifeInCoinBonusGameFlagsRow2 = !RAM_SMW_Blocks_GiveLifeInCoinBonusGameFlagsRow1+$01
!RAM_SMW_Blocks_GiveLifeInCoinBonusGameFlagsRow3 = !RAM_SMW_Blocks_GiveLifeInCoinBonusGameFlagsRow1+$02
!RAM_SMW_Blocks_GiveLifeInCoinBonusGameFlagsRow4 = !RAM_SMW_Blocks_GiveLifeInCoinBonusGameFlagsRow1+$03
!RAM_SMW_Blocks_GiveLifeInCoinBonusGameFlagsRow5 = !RAM_SMW_Blocks_GiveLifeInCoinBonusGameFlagsRow1+$04
!RAM_SMW_Player_CurrentLayerPriority = $0013F9
!RAM_SMW_Player_CanJumpOutOfWater = $0013FA
!RAM_SMW_Player_FreezePlayerFlag = $0013FB
!RAM_SMW_Misc_CurrentlyActiveBoss = $0013FC
!RAM_SMW_Flag_LRScrollFlag = $0013FD
!RAM_SMW_Misc_LRScrollDirection = $0013FE
!RAM_SMW_Player_FacingDirectionX2 = $0013FF
!RAM_SMW_Camera_LRScrollMoveFlag = $001400
!RAM_SMW_Timer_TimeBeforeLRScroll = $001401
!RAM_SMW_Blocks_NoteBlockBounceFlag = $001402
!RAM_SMW_Flag_Layer3TideLevel = $001403
!RAM_SMW_Flag_ScrollUpToPlayer = $001404
!RAM_SMW_Flag_AboutToWarpInPipe = $001405
!RAM_SMW_Camera_BounceOffSpringFlag = $001406
!RAM_SMW_Player_CapeFlyingPhase = $001407
!RAM_SMW_Player_CapeGlideIndex = $001408
!RAM_SMW_Player_FurthestCapeDiveStage = $1409
!RAM_SMW_UnusedRAM_7E140A = $00140A
;Empty $00140B-$00140C
!RAM_SMW_Player_SpinJumpFlag = $00140D
!RAM_SMW_Sprites_Layer2IsTouchedFlag = $00140E
!RAM_SMW_Flag_ReznorRoomOAMIndexTimer = $00140F
!RAM_SMW_Flag_DisplayYoshisWings = $001410
!RAM_SMW_Flag_Layer1HorizontalScrollLevelSetting = $001411
!RAM_SMW_Flag_Layer1VerticalScrollLevelSetting = $001412
!RAM_SMW_Flag_Layer2HorizontalScrollLevelSetting = $001413
!RAM_SMW_Flag_Layer2VerticalScrollLevelSetting = $001414
;Empty $001415-$001416
!RAM_SMW_Camera_Layer2YPosRelativeToLayer1Lo = $001417
!RAM_SMW_Camera_Layer2YPosRelativeToLayer1Hi = !RAM_SMW_Camera_Layer2YPosRelativeToLayer1Lo+$01
!RAM_SMW_Yoshi_InPipe = $001419
!RAM_SMW_Counter_SublevelsEntered = $00141A
!RAM_SMW_Flag_PreventCoinBonusGameReplay = $00141B
!RAM_SMW_Flag_SecretGoalSprite = $00141C
!RAM_SMW_Flag_ShowPlayerStart = $00141D
!RAM_SMW_Yoshi_YoshiHasWings = $00141E
!RAM_SMW_Flag_DisableNoYoshiIntro = $00141F
!RAM_SMW_Counter_YoshiCoinsCollected = $001420
!RAM_SMW_Counter_1upCheckPointsCollected = $001421
!RAM_SMW_Counter_YoshiCoinsToDisplay = $001422				; Todo: See if this can be merged with $001420
!RAM_SMW_Misc_ColorOfPalaceSwitchPressed2 = $001423
!RAM_SMW_Timer_DisplayBonusStars = $001424
!RAM_SMW_Flag_ActiveBonusGame = $001425
!RAM_SMW_Misc_DisplayMessage = $001426
!RAM_SMW_NorSpr0A0_ActivateBowserBattle_ClownCarFaceAnimationFrame = $001427
!RAM_SMW_NorSpr0A0_ActivateBowserBattle_PropellerAnimationFrameCounter = $001428
!RAM_SMW_NorSpr0A0_ActivateBowserBattle_PaletteIndex = $001429
!RAM_SMW_Player_RelativePositionNeededToScrollScreenLo = $00142A
!RAM_SMW_Player_RelativePositionNeededToScrollScreenHi = !RAM_SMW_Player_RelativePositionNeededToScrollScreenLo+$01
!RAM_SMW_Camera_RelativePositionNeededToScrollScreenRightLo = $00142C
!RAM_SMW_Camera_RelativePositionNeededToScrollScreenRightHi = !RAM_SMW_Camera_RelativePositionNeededToScrollScreenRightLo+$01
!RAM_SMW_Camera_RelativePositionNeededToScrollScreenLeftLo = !RAM_SMW_Camera_RelativePositionNeededToScrollScreenRightLo+$02
!RAM_SMW_Camera_RelativePositionNeededToScrollScreenLeftHi = !RAM_SMW_Camera_RelativePositionNeededToScrollScreenRightLo+$03
!RAM_SMW_Blocks_LowestNumberSolidMap16TileForSprites = $001430
!RAM_SMW_Blocks_HighestNumberSolidMap16TileForSprites = $001431
!RAM_SMW_NorSpr045_DirectionalCoins_NoRespawnFlag = $001432
!RAM_SMW_Timer_HDMAWindowScalingFactor = $001433
!RAM_SMW_Timer_EndLevelViaKeyhole = $001434
!RAM_SMW_Flag_KeyholeAnimationPhase = $001435
!RAM_SMW_Misc_ScratchRAM7E1436 = $001436
	!RAM_SMW_Player_OnTiltingPlatformXPosLo = !RAM_SMW_Misc_ScratchRAM7E1436
	!RAM_SMW_Player_OnTiltingPlatformXPosHi = !RAM_SMW_Player_OnTiltingPlatformXPosLo+$01
	!RAM_SMW_Overworld_SwitchBlockEventBlocksThrownCounter = !RAM_SMW_Misc_ScratchRAM7E1436
!RAM_SMW_Misc_ScratchRAM7E1437 = $001437
	!RAM_SMW_Overworld_SwitchBlockEventWaitBeforeNextEjection = !RAM_SMW_Misc_ScratchRAM7E1437
!RAM_SMW_Misc_ScratchRAM7E1438 = $001438
	!RAM_SMW_Player_OnTiltingPlatformYPosLo = !RAM_SMW_Misc_ScratchRAM7E1438
	!RAM_SMW_Player_OnTiltingPlatformYPosHi = !RAM_SMW_Player_OnTiltingPlatformYPosLo+$01
	!RAM_SMW_Overworld_SwitchBlockEventOAMOffset = !RAM_SMW_Misc_ScratchRAM7E1438
!RAM_SMW_Misc_ScratchRAM7E1439 = $001439
	!RAM_SMW_Overworld_SwitchBlockEventEjectionCounter = !RAM_SMW_Misc_ScratchRAM7E1439
!RAM_SMW_Flag_UploadLoadScreenLettersToVRAM = $00143A
!RAM_SMW_Misc_DeathMessageToDisplay = $00143B
!RAM_SMW_Timer_DisplayDeathMessageAnimation = $00143C
!RAM_SMW_Timer_TimeToDisplayDeathMessage = $00143D
!RAM_SMW_L1ScrollSpr_SpriteID = $00143E
	!RAM_SMW_Flag_CastleMovementInCutscene = !RAM_SMW_L1ScrollSpr_SpriteID
		!RAM_SMW_Flag_DropkickCounter = !RAM_SMW_Flag_CastleMovementInCutscene
		!RAM_SMW_Flag_TNTPlungerWasPressed = !RAM_SMW_Flag_CastleMovementInCutscene
		!RAM_SMW_Flag_HammeredCastleShouldCrumble = !RAM_SMW_Flag_CastleMovementInCutscene
		!RAM_SMW_Flag_PickedUpCastle = !RAM_SMW_Flag_CastleMovementInCutscene
		!RAM_SMW_Flag_KickedCastle = !RAM_SMW_Flag_CastleMovementInCutscene
		!RAM_SMW_Flag_FullyMoppedCastle = !RAM_SMW_Flag_CastleMovementInCutscene
		!RAM_SMW_Flag_ShowVictoryPoseInLarryCutscene = !RAM_SMW_Flag_CastleMovementInCutscene
!RAM_SMW_L2ScrollSpr_SpriteID = !RAM_SMW_L1ScrollSpr_SpriteID+$01
	!RAM_SMW_Sprites_WaitBeforeCastleRocketAppearsInSky = !RAM_SMW_L2ScrollSpr_SpriteID
	!RAM_SMW_Sprites_CastleDustAnimationTimer = !RAM_SMW_L2ScrollSpr_SpriteID
	!RAM_SMW_Sprites_DropkickContactAnimationTimer = !RAM_SMW_L2ScrollSpr_SpriteID
	!RAM_SMW_Sprites_WaitBeforeCastleCrumblesFromStompTimer = !RAM_SMW_L2ScrollSpr_SpriteID
	!RAM_SMW_Sprites_DudTNTSmokeAnimationTimer = !RAM_SMW_L2ScrollSpr_SpriteID
	!RAM_SMW_Sprites_TNTFuseAnimationTimer = !RAM_SMW_L2ScrollSpr_SpriteID
	!RAM_SMW_Sprites_TNTExplosionAnimationTimer = !RAM_SMW_L2ScrollSpr_SpriteID
	!RAM_SMW_Sprites_DestroyedCastleRocketAnimationTimer = !RAM_SMW_L2ScrollSpr_SpriteID
	!RAM_SMW_Sprites_DelayedTNTExplosionTimer = !RAM_SMW_L2ScrollSpr_SpriteID
	!RAM_SMW_Sprites_KickedCastleQuakeTimer = !RAM_SMW_L2ScrollSpr_SpriteID
!RAM_SMW_L1ScrollSpr_ScrollTypeIndex = $001440
	!RAM_SMW_Sprites_CastleDustFacingDirection = !RAM_SMW_L1ScrollSpr_ScrollTypeIndex
	!RAM_SMW_Sprites_DudTNTSmokeAnimationIndex = !RAM_SMW_L1ScrollSpr_ScrollTypeIndex
	!RAM_SMW_Sprites_TNTFuseAnimationIndex = !RAM_SMW_L1ScrollSpr_ScrollTypeIndex
	!RAM_SMW_Sprites_TNTExplosionAnimationIndex = !RAM_SMW_L1ScrollSpr_ScrollTypeIndex
	!RAM_SMW_Sprites_FarawayCastleRocketAnimationIndex = !RAM_SMW_L1ScrollSpr_ScrollTypeIndex
!RAM_SMW_L2ScrollSpr_ScrollTypeIndex = $001441
	!RAM_SMW_Sprites_TNTExplosionTimer = !RAM_SMW_L2ScrollSpr_ScrollTypeIndex
!RAM_SMW_L1ScrollSpr_CurrentState = $001442
	!RAM_SMW_Pointer_CurrentYoshiHouseSceneProcess = !RAM_SMW_L1ScrollSpr_CurrentState
	!RAM_SMW_Pointer_CurrentCutsceneProcess = !RAM_SMW_L1ScrollSpr_CurrentState
!RAM_SMW_L2ScrollSpr_CurrentState = $001443
	!RAM_SMW_Timer_DisplayCastleDestructionText = !RAM_SMW_L2ScrollSpr_CurrentState
	!RAM_SMW_Misc_ZoneSelectionCursorPos = $001443						; Note: Exclusive to the arcade version
!RAM_SMW_L1ScrollSpr_Timer = $001444
	!RAM_SMW_Flag_ShowWhiteFlag = !RAM_SMW_L1ScrollSpr_Timer
	!RAM_SMW_Overworld_PlayerIsSteppingOnLevelTileFlagLo = !RAM_SMW_L1ScrollSpr_Timer
!RAM_SMW_L2ScrollSpr_Timer = $001445
	!RAM_SMW_Overworld_PlayerIsSteppingOnLevelTileFlagHi = !RAM_SMW_Overworld_PlayerIsSteppingOnLevelTileFlagLo+$01
	!RAM_SMW_Sprites_SwingHammerTimer = !RAM_SMW_L2ScrollSpr_Timer
	!RAM_SMW_Sprites_QuestionMarkAnimationIndex = !RAM_SMW_L2ScrollSpr_Timer
	!RAM_SMW_Sprites_MoppingMovementDirection = !RAM_SMW_L2ScrollSpr_Timer
!RAM_SMW_L1ScrollSpr_XSpeedLo = $001446
	!RAM_SMW_Sprites_MopYPosLo = !RAM_SMW_L1ScrollSpr_XSpeedLo
	!RAM_SMW_Misc_CreditsTempLayer2XSpeedLo = !RAM_SMW_L1ScrollSpr_XSpeedLo
	!RAM_SMW_Misc_ShowPlayerCough = !RAM_SMW_L1ScrollSpr_XSpeedLo
!RAM_SMW_L1ScrollSpr_XSpeedHi = !RAM_SMW_L1ScrollSpr_XSpeedLo+$01
	!RAM_SMW_Sprites_CastleLiftoffYSpeed = !RAM_SMW_L1ScrollSpr_XSpeedHi
	!RAM_SMW_Sprites_DestroyedCastleRocketSmokeIndex = !RAM_SMW_L1ScrollSpr_XSpeedHi
	!RAM_SMW_Sprites_KickedCastleYSpeed = !RAM_SMW_L1ScrollSpr_XSpeedHi
	!RAM_SMW_Sprites_MopYPosHi = !RAM_SMW_Sprites_MopYPosLo+$01
	!RAM_SMW_Misc_CreditsTempLayer2XSpeedHi = !RAM_SMW_Misc_CreditsTempLayer2XSpeedLo+$01
!RAM_SMW_L1ScrollSpr_YSpeedLo = $001448
		!RAM_SMW_Misc_CreditsTempLayer3YSpeedLo = !RAM_SMW_L1ScrollSpr_XSpeedLo+$02
!RAM_SMW_L1ScrollSpr_YSpeedHi = !RAM_SMW_L1ScrollSpr_XSpeedLo+$01
	!RAM_SMW_Sprites_MopTimer = $001449
	!RAM_SMW_Misc_CreditsTempLayer3YSpeedHi = !RAM_SMW_Misc_CreditsTempLayer3YSpeedLo+$01
!RAM_SMW_L2ScrollSpr_XSpeedLo = $00144A
	!RAM_SMW_Flag_DisplayThankYouBubble = $00144A
!RAM_SMW_L2ScrollSpr_XSpeedHi = !RAM_SMW_L2ScrollSpr_XSpeedLo+$01
	!RAM_SMW_Sprites_CarriedEggBounceFrameCounter = !RAM_SMW_L2ScrollSpr_XSpeedHi
!RAM_SMW_L2ScrollSpr_YSpeedLo = $00144C
	!RAM_SMW_Sprites_CarriedEggXPosLo = !RAM_SMW_L2ScrollSpr_YSpeedLo
!RAM_SMW_L2ScrollSpr_YSpeedHi = !RAM_SMW_L2ScrollSpr_YSpeedLo+$01
	!RAM_SMW_Timer_WaitBeforeAllowingEndOfCastleDestructionCutscene = !RAM_SMW_L2ScrollSpr_YSpeedHi
!RAM_SMW_L1ScrollSpr_SubXPosLo = $00144E
	!RAM_SMW_Misc_CreditsTempLayer2XPosLo = !RAM_SMW_L1ScrollSpr_SubXPosLo
	!RAM_SMW_Sprites_EndingPeachWalkBobbingTimer = !RAM_SMW_L1ScrollSpr_SubXPosLo
	!RAM_SMW_Overworld_MakeStandingPlayerFaceDownTimerLo = !RAM_SMW_L1ScrollSpr_SubXPosLo
!RAM_SMW_L1ScrollSpr_SubXPosHi = !RAM_SMW_L1ScrollSpr_SubXPosLo+$01
	!RAM_SMW_Misc_CreditsTempLayer2SXPosHi = !RAM_SMW_Misc_CreditsTempLayer2SXPosLo+$01
	!RAM_SMW_Sprites_EndingPeachWalkBobbingFlag = !RAM_SMW_L1ScrollSpr_SubXPosLo+$01
	!RAM_SMW_Overworld_MakeStandingPlayerFaceDownTimerHi = !RAM_SMW_L1ScrollSpr_SubXPosLo+$01
!RAM_SMW_L1ScrollSpr_SubYPosLo = $001450
	!RAM_SMW_Misc_CreditsTempLayer3YPosLo = !RAM_SMW_L1ScrollSpr_SubXPosLo+$02
!RAM_SMW_L1ScrollSpr_SubYPosHi = !RAM_SMW_L1ScrollSpr_SubYPosLo+$01
	!RAM_SMW_Misc_CreditsTempLayer3YPosHi = !RAM_SMW_Misc_CreditsTempLayer3YPosLo+$01
!RAM_SMW_L2ScrollSpr_SubXPosLo = $001452
!RAM_SMW_L2ScrollSpr_SubXPosHi = !RAM_SMW_L2ScrollSpr_SubXPosLo+$01
!RAM_SMW_L2ScrollSpr_SubYPosLo = $001454
!RAM_SMW_L2ScrollSpr_SubYPosHi = !RAM_SMW_L2ScrollSpr_SubYPosLo+$01
!RAM_SMW_ScrollSpr_LayerIndex = $001456
!RAM_SMW_Sprites_DrawEndingYoshis = $001457
!RAM_SMW_Misc_Layer3XSpeedLo = $001458
	!RAM_SMW_Sprites_CheeringYoshiAnimationFrame = !RAM_SMW_Misc_Layer3XSpeedLo
!RAM_SMW_Misc_Layer3XSpeedHi = !RAM_SMW_Misc_Layer3XSpeedLo+$01
	!RAM_SMW_Sprites_WaitBeforeNextEndingYoshiDuckFrame = !RAM_SMW_Misc_Layer3XSpeedHi
!RAM_SMW_Misc_Layer3YSpeedLo = $00145A
	!RAM_SMW_Sprites_WhichEndingEggsHatched = !RAM_SMW_Misc_Layer3YSpeedLo
!RAM_SMW_Misc_Layer3YSpeedHi = !RAM_SMW_Misc_Layer3YSpeedLo+$01
	!RAM_SMW_Counter_NumberOfEndingEggsHatched = !RAM_SMW_Misc_Layer3YSpeedHi
	!RAM_SMW_Timer_WaitBeforeNextEnemyRollcallScreenLo = !RAM_SMW_Misc_Layer3YSpeedHi
!RAM_SMW_Misc_Layer3TideSubYPosLo = $00145C
	!RAM_SMW_Flag_EndingEggIsHatching = !RAM_SMW_Misc_Layer3TideSubYPosLo
	!RAM_SMW_Timer_WaitBeforeNextEnemyRollcallScreenHi = !RAM_SMW_Timer_WaitBeforeNextEnemyRollcallScreenLo+$01
!RAM_SMW_Misc_Layer3TideSubYPosHi = !RAM_SMW_Misc_Layer3TideSubYPosLo+$01
	!RAM_SMW_Timer_WaitBeforeFadingOutYoshisHouseScene = !RAM_SMW_Misc_Layer3TideSubYPosLo+$01
;Empty $00145E-$00145F
!RAM_SMW_Flag_Layer3VerticalScrollDirection = $001460
!RAM_SMW_UnusedRAM_7E1461 = $001461
!RAM_SMW_Misc_Layer1XPosLo = $001462
!RAM_SMW_Misc_Layer1XPosHi = !RAM_SMW_Misc_Layer1XPosLo+$01
!RAM_SMW_Misc_Layer1YPosLo = !RAM_SMW_Misc_Layer1XPosLo+$02
!RAM_SMW_Misc_Layer1YPosHi = !RAM_SMW_Misc_Layer1YPosLo+$01
!RAM_SMW_Misc_Layer2XPosLo = !RAM_SMW_Misc_Layer1XPosLo+$04
!RAM_SMW_Misc_Layer2XPosHi = !RAM_SMW_Misc_Layer2XPosLo+$01
!RAM_SMW_Misc_Layer2YPosLo = !RAM_SMW_Misc_Layer1XPosLo+$06
!RAM_SMW_Misc_Layer2YPosHi = !RAM_SMW_Misc_Layer2YPosLo+$01
!RAM_SMW_Misc_Layer3XDispLo = !RAM_SMW_Misc_Layer1XPosLo+$08
!RAM_SMW_Misc_Layer3XDispHi = !RAM_SMW_Misc_Layer3XDispLo+$01
;Empty $00146C-$00146F
!RAM_SMW_Player_CarryingSomethingFlag1 = $001470
!RAM_SMW_Misc_PlayerOnSolidSprite = $001471
!RAM_SMW_NorSpr0C6_Spotlight_LeftWindowXPosTop = $001472
;Empty $001473
!RAM_SMW_NorSpr0C6_Spotlight_RightWindowXPosTop = $001474
;Empty $001475
!RAM_SMW_NorSpr0C6_Spotlight_LeftWindowXPosBottom = $001476
;Empty $001477
!RAM_SMW_NorSpr0C6_Spotlight_RightWindowXPosBottom = $001478
;Empty $001479
!RAM_SMW_NorSpr0C6_Spotlight_LeftWindowScanlineXPos = $00147A
;Empty $00147B
!RAM_SMW_NorSpr0C6_Spotlight_RightWindowScanlineXPos = $00147C
;Empty $00147D
!RAM_SMW_NorSpr0C6_Spotlight_ShiftLeftSideOfWindow = $00147E
!RAM_SMW_NorSpr0C6_Spotlight_ShiftRightSideOfWindow = $00147F
!RAM_SMW_NorSpr0C6_Spotlight_WidthOfLeftSideOfWindow = $001480
!RAM_SMW_NorSpr0C6_Spotlight_WidthOfRightSideOfWindow = $001481
!RAM_SMW_Flag_SkipSpotlightWindowInitialization = $001482
!RAM_SMW_NorSpr0C6_Spotlight_Direction = $001483
!RAM_SMW_NorSpr0C6_Spotlight_BottomLeftWindowPosRelativeToTop = $001484
!RAM_SMW_NorSpr0C6_Spotlight_BottomRightWindowPosRelativeToTop = $001485
!RAM_SMW_UnusedRAM_7E1486 = $001486
;Empty $001487-$00148A
!RAM_SMW_Misc_RNGRoutineScratchRAM148B = $00148B
!RAM_SMW_Misc_RNGRoutineScratchRAM148C = !RAM_SMW_Misc_RNGRoutineScratchRAM148B+$01
!RAM_SMW_Misc_RandomByte1 = $00148D
!RAM_SMW_Misc_RandomByte2 = !RAM_SMW_Misc_RandomByte1+$01
!RAM_SMW_Player_CarryingSomethingFlag2 = $00148F
!RAM_SMW_Timer_StarPower = $001490
!RAM_SMW_Sprites_PositionDisp = $001491
!RAM_SMW_Timer_ShowVictoryPose = $001492
!RAM_SMW_Timer_EndLevel = $001493
!RAM_SMW_Palettes_LevelEndColorFadeDirection = $001494
!RAM_SMW_Timer_LevelEndFade = $001495
!RAM_SMW_Player_AnimationTimer = $001496
!RAM_SMW_Timer_PlayerHurt = $001497
!RAM_SMW_Timer_DisplayPlayerPickUpPose = $001498
!RAM_SMW_Timer_DisplayPlayerFaceScreenPose = $001499
!RAM_SMW_Timer_DisplayPlayerKickingPose = $00149A
!RAM_SMW_Timer_PlayerPaletteCycle = $00149B
!RAM_SMW_Timer_DisplayPlayerShootFireballPose = $00149C
!RAM_SMW_Timer_OnSwingingClimbingNetDoor = $00149D
!RAM_SMW_Timer_DisplayPlayerNetPunchPose = $00149E
!RAM_SMW_Timer_WaitBeforeCapeFlightBegins = $00149F
!RAM_SMW_Timer_ShowRunningFramesBeforeTakeOff = $0014A0
!RAM_SMW_Timer_PlayerSlidesWhenTuring = $0014A1
!RAM_SMW_Timer_CapeFlapAnimation = $0014A2
!RAM_SMW_Timer_YoshiTongueIsOut = $0014A3
!RAM_SMW_Timer_ChangeDivingState = $0014A4
!RAM_SMW_Timer_TimeToFloatAfterCapeFlight = $0014A5
!RAM_SMW_Timer_ActiveCapeSpin = $0014A6
!RAM_SMW_Timer_ReznorBridgeBreaking = $0014A7
!RAM_SMW_UnusedRAM_7E14A8 = $0014A8
!RAM_SMW_UnusedRAM_7E14A9 = $0014A9
!RAM_SMW_UnusedRAM_7E14AA = $0014AA
!RAM_SMW_Timer_BonusGameEnd = $0014AB
!RAM_SMW_UnusedRAM_7E14AC = $0014AC
!RAM_SMW_Timer_BluePSwitch = $0014AD
!RAM_SMW_Timer_SilverPSwitch = !RAM_SMW_Timer_BluePSwitch+$01
!RAM_SMW_Flag_OnOffSwitch = !RAM_SMW_Timer_BluePSwitch+$02
!RAM_SMW_Misc_ScratchRAM7E14B0 = $0014B0
	!RAM_SMW_Misc_RotatingObjectCenterXPosLo = !RAM_SMW_Misc_ScratchRAM7E14B0
!RAM_SMW_Misc_ScratchRAM7E14B1 = $0014B1
	!RAM_SMW_Misc_RotatingObjectCenterXPosHi = !RAM_SMW_Misc_RotatingObjectCenterXPosLo+$01
!RAM_SMW_Misc_ScratchRAM7E14B2 = $0014B2
	!RAM_SMW_Misc_RotatingObjectCenterYPosLo = !RAM_SMW_Misc_ScratchRAM7E14B2
!RAM_SMW_Misc_ScratchRAM7E14B3 = $0014B3
	!RAM_SMW_Misc_RotatingObjectCenterYPosHi = !RAM_SMW_Misc_RotatingObjectCenterYPosLo+$01
!RAM_SMW_Misc_ScratchRAM7E14B4 = $0014B4
	!RAM_SMW_Sprites_OnTiltingPlatformXOffsetLo = !RAM_SMW_Misc_ScratchRAM7E14B4
!RAM_SMW_Misc_ScratchRAM7E14B5 = $0014B5
	!RAM_SMW_Sprites_OnTiltingPlatformXOffsetHi = !RAM_SMW_Misc_ScratchRAM7E14B5
!RAM_SMW_Misc_ScratchRAM7E14B6 = $0014B6
	!RAM_SMW_Sprites_OnTiltingPlatformYOffsetLo = !RAM_SMW_Misc_ScratchRAM7E14B6
!RAM_SMW_Misc_ScratchRAM7E14B7 = $0014B7
	!RAM_SMW_Sprites_OnTiltingPlatformYOffsetHi = !RAM_SMW_Misc_ScratchRAM7E14B7
!RAM_SMW_Misc_ScratchRAM7E14B8 = $0014B8
	!RAM_SMW_Sprites_BrownRotatingPlatformFirstTileXPosLo = !RAM_SMW_Misc_ScratchRAM7E14B8
!RAM_SMW_Misc_ScratchRAM7E14B9 = $0014B9
	!RAM_SMW_Sprites_BrownRotatingPlatformFirstTileXPosHi = !RAM_SMW_Sprites_BrownRotatingPlatformFirstTileXPosLo+$01
!RAM_SMW_Misc_ScratchRAM7E14BA = $0014BA
	!RAM_SMW_Sprites_BrownRotatingPlatformFirstTileYPosLo = !RAM_SMW_Misc_ScratchRAM7E14BA
!RAM_SMW_Misc_ScratchRAM7E14BB = $0014BB
	!RAM_SMW_Sprites_BrownRotatingPlatformFirstTileYPosHi = !RAM_SMW_Sprites_BrownRotatingPlatformFirstTileYPosLo+$01
!RAM_SMW_Misc_ScratchRAM7E14BC = $0014BC
	!RAM_SMW_Misc_RotatingObjectXRadiusLo = !RAM_SMW_Misc_ScratchRAM7E14BC
!RAM_SMW_Misc_ScratchRAM7E14BD = !RAM_SMW_Misc_ScratchRAM7E14BD
	!RAM_SMW_Misc_RotatingObjectXRadiusHi = !RAM_SMW_Misc_RotatingObjectXRadiusLo+$01
;Empty $0014BE
!RAM_SMW_Misc_ScratchRAM7E14BF = $0014BF
	!RAM_SMW_Misc_RotatingObjectYRadiusLo = !RAM_SMW_Misc_ScratchRAM7E14BF
!RAM_SMW_Misc_ScratchRAM7E14C0 = $0014C0
	!RAM_SMW_Misc_RotatingObjectYRadiusHi = !RAM_SMW_Misc_RotatingObjectYRadiusLo+$01
;Empty $0014C1
!RAM_SMW_Sprites_BrownRotatingPlatformSineLo = $0014C2
!RAM_SMW_Sprites_BrownRotatingPlatformSineHi = !RAM_SMW_Sprites_BrownRotatingPlatformSineLo+$01 
;Empty $0014C4
!RAM_SMW_Sprites_BrownRotatingPlatformCosineLo = $0014C5
!RAM_SMW_Sprites_BrownRotatingPlatformCosineHi = !RAM_SMW_Sprites_BrownRotatingPlatformCosineLo+$01
;Empty $0014C7
!RAM_SMW_NorSpr_CurrentStatus = $0014C8
!RAM_SMW_NorSpr_YPosHi = $0014D4
!RAM_SMW_NorSpr_XPosHi = !RAM_SMW_NorSpr_YPosHi+(!Define_SMW_MaxNormalSpriteSlot+$01)
!RAM_SMW_NorSpr_SubYPos = $0014EC
!RAM_SMW_NorSpr_SubXPos = !RAM_SMW_NorSpr_SubYPos+(!Define_SMW_MaxNormalSpriteSlot+$01)
!RAM_SMW_NorSpr_Table7E1504 = $001504
!RAM_SMW_NorSpr_Table7E1510 = $001510
!RAM_SMW_NorSpr_Table7E151C = $00151C
!RAM_SMW_NorSpr_Table7E1528 = $001528
	!RAM_SMW_NorSpr_PlayerXSpeedOffset = !RAM_SMW_NorSpr_Table7E1528
	!RAM_SMW_NorSpr_FireballHPCounter = !RAM_SMW_NorSpr_Table7E1528
!RAM_SMW_NorSpr_Table7E1534 = $001534
!RAM_SMW_NorSpr_DecrementingTable7E1540 = $001540
	!RAM_SMW_NorSpr_SpinJumpKillTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540
	!RAM_SMW_NorSpr_SmushedSpriteDespawnTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540
	!RAM_SMW_NorSprStatus06_GoalCoins_WaitBeforeTurningIntoCoin = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSpr_DecrementingTable7E154C = $00154C
!RAM_SMW_NorSpr_DecrementingTable7E1558 = $001558
!RAM_SMW_NorSpr_DecrementingTable7E1564 = $001564
!RAM_SMW_NorSpr_Table7E1570 = $001570
	!RAM_SMW_NorSpr_AnimationFrameCounter = !RAM_SMW_NorSpr_Table7E1570
	!RAM_SMW_NorSprStatus06_GoalCoins_UnknownRAM = !RAM_SMW_NorSpr_Table7E1570
!RAM_SMW_NorSpr_Table7E157C = $00157C
	!RAM_SMW_NorSpr_FacingDirection = !RAM_SMW_NorSpr_Table7E157C
!RAM_SMW_NorSpr_Table7E1588 = $001588
	!RAM_SMW_NorSpr_LevelCollisionFlags = !RAM_SMW_NorSpr_Table7E1588
!RAM_SMW_NorSpr_Table7E1594 = $001594
!RAM_SMW_NorSpr_XOffscreenFlag = $0015A0
!RAM_SMW_NorSpr_DecrementingTable7E15AC = $0015AC
	!RAM_SMW_NorSpr_TurnAroundTimer = !RAM_SMW_NorSpr_DecrementingTable7E15AC
!RAM_SMW_NorSpr_SlopeSurfaceItsOn = $0015B8
!RAM_SMW_NorSpr_Table7E15C4 = $0015C4
!RAM_SMW_NorSpr_Table7E15D0 = $0015D0
	!RAM_SMW_NorSpr_OnYoshisTongue = !RAM_SMW_NorSpr_Table7E15D0
!RAM_SMW_NorSpr_NoLevelCollisionFlag = $0015DC
;Empty $0015E8
!RAM_SMW_NorSpr_CurrentSlotID = $0015E9
!RAM_SMW_NorSpr_OAMIndex = $0015EA
!RAM_SMW_NorSpr_Table7E15F6 = $0015F6
	!RAM_SMW_NorSpr_YXPPCCCT = !RAM_SMW_NorSpr_Table7E15F6
!RAM_SMW_NorSpr_Table7E1602 = $001602
	!RAM_SMW_NorSpr_AnimationFrame = !RAM_SMW_NorSpr_Table7E1602
!RAM_SMW_NorSpr_Table7E160E = $00160E
!RAM_SMW_NorSpr_LoadStatusTableIndex = $00161A
!RAM_SMW_NorSpr_Table7E1626 = $001626
!RAM_SMW_NorSpr_Table7E1632 = $001632
	!RAM_SMW_NorSpr_CurrentLayerPriority = !RAM_SMW_NorSpr_Table7E1632
!RAM_SMW_NorSpr_DecrementingTable7E163E = $00163E
!RAM_SMW_NorSpr_Table7E164A = $00164A
	!RAM_SMW_NorSpr_InLiquidFlag = !RAM_SMW_NorSpr_Table7E164A
!RAM_SMW_NorSpr_PropertyBits1656 = $001656
!RAM_SMW_NorSpr_PropertyBits1662 = $001662
!RAM_SMW_NorSpr_PropertyBits166E = $00166E
!RAM_SMW_NorSpr_PropertyBits167A = $00167A
!RAM_SMW_NorSpr_PropertyBits1686 = $001686
!RAM_SMW_Sprites_SpriteMemorySetting = $001692
!RAM_SMW_Blocks_CurrentlyProcessedMap16TileLo = $001693
!RAM_SMW_Sprites_DistanceToSnapDownToNearestTile = $001694
!RAM_SMW_Sprites_SecondTrackedSpriteIndex = $001695
	!RAM_SMW_Sprites_SpriteEnterOrExitingWater = $001695
;Empty $001696
!RAM_SMW_Counter_ConsecutiveEnemiesStomped = $001697
!RAM_SMW_Sprites_CurrentlyProcessedMiscSprite = $001698
!RAM_SMW_BounceSpr_SpriteID = $001699
!RAM_SMW_BounceSpr_CurrentStatus = $00169D
!RAM_SMW_BounceSpr_YPosLo = $0016A1
!RAM_SMW_BounceSpr_XPosLo = $0016A5
!RAM_SMW_BounceSpr_YPosHi = $0016A9
!RAM_SMW_BounceSpr_XPosHi = $0016AD
!RAM_SMW_BounceSpr_YSpeed = $0016B1
!RAM_SMW_BounceSpr_XSpeed = $0016B5
!RAM_SMW_BounceSpr_SubYPos = $0016B9
!RAM_SMW_BounceSpr_SubXPos = $0016BD
!RAM_SMW_BounceSpr_Map16TileToSpawn = $0016C1
!RAM_SMW_BounceSpr_Timer = $0016C5
!RAM_SMW_BounceSpr_Properties = $0016C9
!RAM_SMW_BounceSpr_Type = $0016CD
!RAM_SMW_BounceSpr_HitboxXLo = $0016D1
!RAM_SMW_BounceSpr_HitboxXHi = $0016D5
!RAM_SMW_BounceSpr_HitboxYLo = $0016D9
!RAM_SMW_BounceSpr_HitboxYHi = $0016DD
!RAM_SMW_ScoreSpr_SpriteID = $0016E1
!RAM_SMW_ScoreSpr_YPosLo = $0016E7
!RAM_SMW_ScoreSpr_XPosLo = $0016ED
!RAM_SMW_ScoreSpr_XPosHi = $0016F3
!RAM_SMW_ScoreSpr_YPosHi = $0016F9
!RAM_SMW_ScoreSpr_YSpeed = $0016FF
!RAM_SMW_ScoreSpr_LayerIndex = $001705
!RAM_SMW_ExtSpr_SpriteID = $00170B
!RAM_SMW_ExtSpr_YPosLo = $001715
!RAM_SMW_ExtSpr_XPosLo = $00171F
!RAM_SMW_ExtSpr_YPosHi = $001729
!RAM_SMW_ExtSpr_XPosHi = $001733
!RAM_SMW_ExtSpr_YSpeed = $00173D
!RAM_SMW_ExtSpr_XSpeed = $001747
!RAM_SMW_ExtSpr_SubYPos = $001751
!RAM_SMW_ExtSpr_SubXPos = $00175B
	!RAM_SMW_ExtSpr05_MarioFireball_HitFlag = $00175B
!RAM_SMW_ExtSpr_Table7E1765 = $001765
!RAM_SMW_ExtSpr_DecrementingTable7E176F = $00176F
!RAM_SMW_ExtSpr_Table7E1779 = $001779
!RAM_SMW_ShooterSpr_SpriteID = $001783
!RAM_SMW_ShooterSpr_YPosLo = $00178B
!RAM_SMW_ShooterSpr_YPosHi = $001793
!RAM_SMW_ShooterSpr_XPosLo = $00179B
!RAM_SMW_ShooterSpr_XPosHi = $0017A3
!RAM_SMW_ShooterSpr_ShootTimer = $0017AB
!RAM_SMW_ShooterSpr_UnusedLevelListIndex = $0017B3				; Optimization: Useless, as nothing can cause a shooter to stop spawning
!RAM_SMW_UnusedRAM_7E17BB = $0017BB
!RAM_SMW_Misc_Layer1YDisp = $0017BC
!RAM_SMW_Misc_Layer1XDisp = $0017BD
!RAM_SMW_Misc_Layer2YDisp = $0017BE
!RAM_SMW_Misc_Layer2XDisp = $0017BF
!RAM_SMW_SmokeSpr_SpriteID = $0017C0
!RAM_SMW_SmokeSpr_YPosLo = $0017C4
!RAM_SMW_SmokeSpr_XPosLo = $0017C8
!RAM_SMW_SmokeSpr_Timer = $0017CC
!RAM_SMW_BlockCoinSpr_SlotID = $0017D0
!RAM_SMW_BlockCoinSpr_YPosLo = $0017D4
!RAM_SMW_BlockCoinSpr_YSpeed = $0017D8
!RAM_SMW_BlockCoinSpr_SubYPos = $0017DC
!RAM_SMW_BlockCoinSpr_XPosLo = $0017E0
!RAM_SMW_BlockCoinSpr_LayerIndex = $0017E4
!RAM_SMW_BlockCoinSpr_YPosHi = $0017E8
!RAM_SMW_BlockCoinSpr_XPosHi = $0017EC
!RAM_SMW_MExtSpr_SpriteID = $0017F0
!RAM_SMW_MExtSpr_YPosLo = $0017FC
!RAM_SMW_MExtSpr_XPosLo = $001808
!RAM_SMW_MExtSpr_YPosHi = $001814
!RAM_SMW_MExtSpr_YSpeed = $001820
!RAM_SMW_MExtSpr_XSpeed = $00182C
!RAM_SMW_MExtSpr_SubYPos = $001838
!RAM_SMW_MExtSpr_SubXPos = $001844
!RAM_SMW_MExtSpr_Timer = $001850
!RAM_SMW_Player_DisableObjectInteractionFlag = $00185C
!RAM_SMW_MExtSpr_SlotToOverwriteWhenSlotsFull = $00185D
!RAM_SMW_Misc_ScratchRAM7E185E = $00185E
	!RAM_SMW_Sprites_CopyOfDisappearingBooFrameCounter = !RAM_SMW_Misc_ScratchRAM7E185E
	!RAM_SMW_Sprites_SumoBroFlameScratchRAM7E185E = !RAM_SMW_Misc_ScratchRAM7E185E
	!RAM_SMW_Sprites_PowerUpFromBlockSpriteSlot = !RAM_SMW_Misc_ScratchRAM7E185E
!RAM_SMW_Sprites_Map16TileBeingTouchedVerticallyLo = $00185F
!RAM_SMW_Sprites_Map16TileBeingTouchedHorizontallyLo = $001860
!RAM_SMW_NorSpr_SlotToOverwriteWhenSlotsFull = $001861
!RAM_SMW_Sprites_Map16TileBeingTouchedHorizontallyHi = $001862
!RAM_SMW_SmokeSpr_SlotToOverwriteWhenSlotsFull = $001863
;Empty $001864
!RAM_SMW_BlockCoinSpr_SlotToOverwriteWhenSlotsFull = $001865
!RAM_SMW_Sprites_BrownRoatingPlatformAngleSign1 = $001866
!RAM_SMW_Sprites_BrownRoatingPlatformAngleSign2 = $001867
!RAM_SMW_Blocks_CopyOfCurrentlyProcessedMap16TileLo1 = $001868
;Empty $001869-$00186A
!RAM_SMW_Blocks_MultiCoinBlockTimer = $00186B
!RAM_SMW_NorSpr_YOffscreenFlag = $00186C
!RAM_SMW_Sprites_PlayerXSpeedOnSwingingNetDoor = $001878
;Empty $001879
!RAM_SMW_Player_RidingYoshiFlag = $00187A
!RAM_SMW_NorSpr_Table7E187B = $00187B
	!RAM_SMW_Sprites_BackgroundToUseInKoopaKidBattle = $001884
!RAM_SMW_Timer_ShakeLayer1 = $001887
!RAM_SMW_ShakingLayer1DispYLo = $001888
!RAM_SMW_ShakingLayer1DispYHi = !RAM_SMW_ShakingLayer1DispYLo+$01
!RAM_SMW_UnusedRAM_7E188A = $00188A
!RAM_SMW_Player_RelativeYPositionDuringScreenShake = $00188B
!RAM_SMW_Flag_UpdateBackgroundSpritesInKoopaKidRooms = $00188C
!RAM_SMW_Misc_MortonRoyLudwigBackgroundXOffset = $00188D
;Empty $00188E
!RAM_SMW_Sprites_BonusGameIsOverFlag = $00188F
!RAM_SMW_Counter_NumberOfBonusGame1upsToSpawn = $001890
!RAM_SMW_Timer_PlayerHasPBalloon = $001891
!RAM_SMW_ClusterSpr_SpriteID = $001892
!RAM_SMW_UnusedRAM_7E18A6 = $0018A6
!RAM_SMW_Blocks_CopyOfCurrentlyProcessedMap16TileLo2 = $0018A7
!RAM_SMW_Sprites_MortonAndRoyLeftPillarStatus = $0018A8
!RAM_SMW_Sprites_MortonAndRoyRightPillarStatus = !RAM_SMW_Sprites_MortonAndRoyLeftPillarStatus+$01
!RAM_SMW_Sprites_MortonAndRoyLeftPillarYPosition = $0018AA
!RAM_SMW_Sprites_MortonAndRoyRightPillarYPosition = !RAM_SMW_Sprites_MortonAndRoyLeftPillarYPosition+$01
!RAM_SMW_Yoshi_SwallowTimer = $0018AC
!RAM_SMW_Yoshi_WalkingFrames = $0018AD
!RAM_SMW_Timer_YoshiTongueInit = $0018AE
!RAM_SMW_Timer_YoshiSquatting = $0018AF
!RAM_SMW_Yoshi_XPosLo = $0018B0
!RAM_SMW_Yoshi_XPosHi = !RAM_SMW_Yoshi_XPosLo+$1
!RAM_SMW_Yoshi_YPosLo = $0018B2
!RAM_SMW_Yoshi_YPosHi = !RAM_SMW_Yoshi_YPosLo+$1
;Empty $0018B4
!RAM_SMW_Flag_StandingOnBetaCage = $0018B5
!RAM_SMW_Misc_ScratchRAM7E18B6 = $0018B6
;Empty $0018B7
!RAM_SMW_Flag_RunClusterSprites = $0018B8
!RAM_SMW_GenSpr_SpriteID = $0018B9
!RAM_SMW_ClusterSpr04_BooRing_RingIndex = $0018BA
;Empty $0018BB
!RAM_SMW_Sprites_FloatingSkullSpeed = $0018BC
!RAM_SMW_Timer_StunPlayer = $0018BD
!RAM_SMW_Flag_PlayerClimbOnAir = $0018BE
!RAM_SMW_Timer_DisappearingSprite = $0018BF
!RAM_SMW_Timer_RespawnSprite = $0018C0
!RAM_SMW_Sprites_SpriteToRespawn = $0018C1
!RAM_SMW_Flag_PlayerInLakitusCloud = $0018C2
!RAM_SMW_Sprites_YPosOfRespawningSpriteLo = $0018C3
!RAM_SMW_Sprites_YPosOfRespawningSpriteHi = !RAM_SMW_Sprites_YPosOfRespawningSpriteLo+$01
;Empty $0018C5-$0018CC
!RAM_SMW_BounceSpr_SlotToOverwriteWhenSlotsFull = $0018CD
!RAM_SMW_BounceSpr07_SpinningTurnBlock_DespawnTimer = $0018CE
!RAM_SMW_Player_StarKillCount = $0018D2
!RAM_SMW_Timer_UnusedPlayerSparkle = $0018D3
!RAM_SMW_Counter_EatenRedBerries = $0018D4
!RAM_SMW_Counter_EatenPinkBerries = $0018D5
!RAM_SMW_Yoshi_BerryBeingEaten = $0018D6
!RAM_SMW_Sprites_Map16TileBeingTouchedVerticallyHi = $0018D7
;Empty $0018D8
!RAM_SMW_Timer_NoYoshiIntroDoorTimer = $0018D9
!RAM_SMW_Yoshi_LaidEggContents = $0018DA
!RAM_SMW_UnusedRAM_7E18DB = $0018DB
!RAM_SMW_Yoshi_DuckingFlag = $0018DC
!RAM_SMW_Counter_CurrentSilverCoins = $0018DD
	!RAM_SMW_Counter_GoalCoinPointsIndex = !RAM_SMW_Counter_CurrentSilverCoins
!RAM_SMW_Yoshi_EggLayTimer = $0018DE
!RAM_SMW_Sprites_YoshiSlotIndex = $0018DF
!RAM_SMW_Timer_DespawnLakituCloud = $0018E0
!RAM_SMW_Sprites_LakituCloudSlotIndex = $0018E1
!RAM_SMW_Yoshi_StrayYoshiFlag = $0018E2
!RAM_SMW_Counter_PinkBerryCloudCoins = $0018E3
!RAM_SMW_Misc_1upHandler = $0018E4
!RAM_SMW_Timer_Give1up = $0018E5
;Empty $0018E6
!RAM_SMW_Yoshi_StompGroundFlag = $0018E7
!RAM_SMW_GrowingYoshiTimer = $0018E8
!RAM_SMW_SmokeSpr_CopyOfSlotToOverwriteWhenSlotsFull = $0018E9			; Todo: Duplicate of $001863?
!RAM_SMW_MExtSpr_XPosHi = $0018EA
;Empty $0018F6
!RAM_SMW_ScoreSpr_SlotToOverwriteWhenSlotsFull = $0018F7
!RAM_SMW_BounceSpr_InteractTimer = $0018F8
!RAM_SMW_ExtSpr_SlotToOverwriteWhenSlotsFull = $0018FC
!RAM_SMW_Flag_WakeUpRipVanFish = $0018FD
!RAM_SMW_Sprites_SpecialBulletGeneratorTimer = $0018FE
!RAM_SMW_ShooterSpr_SlotToOverwriteWhenSlotsFull = $0018FF
!RAM_SMW_Counter_BonusStarsEarned = $001900
!RAM_SMW_BounceSpr_YXPPCCCT = $001901
!RAM_SMW_Counter_DirectionToTiltPlatform = $001905
!RAM_SMW_Timer_WaitBeforeNextTiltingPlatformPhase = $001906
!RAM_SMW_Counter_TiltingPlatformPhase = $001907
;Empty $001908
!RAM_SMW_Flag_ActiveCreateEatBlock = $001909
!RAM_SMW_Sprites_DisappearingBooFrameCounter = $00190A
!RAM_SMW_Sprites_BigBooBossPaletteIndex = $00190B
!RAM_SMW_NorSpr045_DirectionalCoins_DespawnTimer = $00190C
!RAM_SMW_NorSpr0A0_ActivateBowserBattle_EndOfBattleFlag = $00190D
!RAM_SMW_Sprites_SpriteBuoyancySettings = $00190E
!RAM_SMW_NorSpr_PropertyBits190F = $190F
!RAM_SMW_UnusedRAM_7E191B = $00191B
!RAM_SMW_Yoshi_KeyInMouthFlag = $00191C
!RAM_SMW_ClusterSpr_SlotToOverwriteWhenSlotsFull = $00191D
!RAM_SMW_Sprites_ColorOfFlatPalaceSwitchToSpawn = $00191E
;Empty $00191F
!RAM_SMW_Counter_RemainingBonusGame1ups = $001920
!RAM_SMW_NorSpr07C_PrincessPeach_CurrentLetterLo = $001921
!RAM_SMW_NorSpr07C_PrincessPeach_CurrentLetterHi = !RAM_SMW_NorSpr07C_PrincessPeach_CurrentLetterLo+$01
;Empty $001923-$001924
!RAM_SMW_Misc_LevelModeSetting = $001925
;Empty $001926-$001927
!RAM_SMW_Blocks_ScreenToPlaceCurrentObject = $001928
	!RAM_SMW_Pointer_CreditsBackgroundIndex = $001928
	!RAM_SMW_Unknown_7E1928 = $001928
;Empty $001929
!RAM_SMW_Misc_LevelHeaderEntranceSettings = $00192A
!RAM_SMW_Graphics_LevelSpriteGraphicsSetting = $00192B
;Empty $00192C
!RAM_SMW_Misc_FGPaletteSetting = $00192D
!RAM_SMW_Misc_SpritePaletteSetting = $00192E
!RAM_SMW_Misc_BackgroundColorSetting = $00192F
!RAM_SMW_Misc_BGPaletteSetting = $001930
!RAM_SMW_Misc_LevelTilesetSetting = $001931
	!RAM_SMW_Misc_OverworldAndCutsceneGFXToLoad = !RAM_SMW_Misc_LevelTilesetSetting
!RAM_SMW_UnusedRAM_CopyOfLevelTilesetSetting = $001932
!RAM_SMW_Misc_CurrentLayerBeingProcessedLo = $001933
!RAM_SMW_Misc_CurrentLayerBeingProcessedHi = !RAM_SMW_Misc_CurrentLayerBeingProcessedLo+$01
!RAM_SMW_Flag_RestoreSP1TilesAfterMarioStart = $001935
;Empty $001936-$001937
!RAM_SMW_Sprites_LoadStatus = $001938
!RAM_SMW_Misc_SubscreenExitEntranceNumberLo = $0019B8
!RAM_SMW_Misc_SubscreenExitProperties = $0019D8
!RAM_SMW_Misc_ItemMemoryBits = $0019F8
	!RAM_SMW_Misc_ItemMemory0Bits = !RAM_SMW_Misc_ItemMemoryBits
	!RAM_SMW_Misc_ItemMemory1Bits = !RAM_SMW_Misc_ItemMemoryBits+$0080
	!RAM_SMW_Misc_ItemMemory2Bits = !RAM_SMW_Misc_ItemMemoryBits+$0100
!RAM_SMW_Overworld_ProcessHardcodedPathFlagLo = $001B78
!RAM_SMW_Overworld_ProcessHardcodedPathFlagHi = !RAM_SMW_Overworld_ProcessHardcodedPathFlagLo+$01
!RAM_SMW_Overworld_HardcodedPathIndexLo = $001B7A
!RAM_SMW_Overworld_HardcodedPathIndexHi = !RAM_SMW_Overworld_HardcodedPathIndexLo+$01
!RAM_SMW_Overworld_Layer1SubXPos = $001B7C
!RAM_SMW_Overworld_Layer1SubYPos = !RAM_SMW_Overworld_Layer1SubXPos+$01
!RAM_SMW_CopyOfTilePlayerIsStandingdOnLo = $001B7E
!RAM_SMW_CopyOfTilePlayerIsStandingdOnHi = !RAM_SMW_CopyOfTilePlayerIsStandingdOnLo+$01
!RAM_SMW_Overworld_PlayerOnClimbingTileLo = $001B80
!RAM_SMW_Overworld_PlayerOnClimbingTileHi = !RAM_SMW_Overworld_PlayerOnClimbingTileLo+$01
!RAM_SMW_Overworld_OnScreenXPosOfCurrentEventTile = $001B82
!RAM_SMW_Overworld_OnScreenYPosOfCurrentEventTile = $001B83
!RAM_SMW_Timer_DestroyTileEvent_Unknown = $001B84
	!RAM_SMW_Timer_FadeInLevelTile = $001B84
	!RAM_SMW_Overworld_EventTileSizeAddressLo = $001B84
!RAM_SMW_Overworld_EventTileSizeAddressHi = !RAM_SMW_Overworld_EventTileSizeAddressLo+$01
!RAM_SMW_Pointer_OverworldEventProcess = $001B86
!RAM_SMW_Pointer_DisplayOverworldPrompt = $001B87
!RAM_SMW_Flag_MessageWindowSizeChangeDirection = $001B88
!RAM_SMW_Timer_WaitBeforeMessageWindowSizeChange = $001B89
!RAM_SMW_Flag_WhoGetsLivesInExchangeMenu = $001B8A
!RAM_SMW_Timer_LifeExchangeBlinkingArrowFrames = $001B8B
!RAM_SMW_Overworld_HDMATransitionEffectFlag = $001B8C
!RAM_SMW_Overworld_HDMATransitionEffectXPosLo = $001B8D
!RAM_SMW_Overworld_HDMATransitionEffectXPosHi = !RAM_SMW_Overworld_HDMATransitionEffectXPosLo+$01
!RAM_SMW_Overworld_HDMATransitionEffectYPosLo = $001B8F
!RAM_SMW_Overworld_HDMATransitionEffectYPosHi = !RAM_SMW_Overworld_HDMATransitionEffectYPosLo+$01
!RAM_SMW_Counter_BlinkingCursorFrame = $001B91
!RAM_SMW_Misc_BlinkingCursorPos = $001B92
!RAM_SMW_Flag_UseSecondaryEntrance = $001B93
!RAM_SMW_Flag_DisableBonusGameSprite = $001B94
!RAM_SMW_InYoshiWingsBonusArea = $001B95
!RAM_SMW_Flag_SideExits = $001B96
!RAM_SMW_UnusedRAM_UnknownScrollFunctionFlagLo = $001B97
!RAM_SMW_UnusedRAM_UnknownScrollFunctionFlagHi = !RAM_SMW_UnusedRAM_UnknownScrollFunctionFlagLo+$01
!RAM_SMW_Flag_ShowVictoryPoseDuringLevelEnd = $001B99
!RAM_SMW_Flag_ActiveFastBackgroundScrollGenerator = $001B9A
!RAM_SMW_Flag_PreventYoshiCarryOver = $001B9B
!RAM_SMW_Overworld_WarpingOnPipeOrStarFlag = $001B9C
!RAM_SMW_Timer_WaitBeforeLayer3TideMovesVertically = $001B9D
!RAM_SMW_Flag_ChangeSubmapMusicOnPlayerSwitch = $001B9E
!RAM_SMW_Counter_NumberOfBrokenReznorBridgeTiles = $001B9F
!RAM_SMW_Overworld_ActiveEarthquakeEvent = $001BA0
!RAM_SMW_Blocks_ScreenToPlaceNextObject = $001BA1
	!RAM_SMW_UnusedRAM_7E1BA1 = $001BA1
!RAM_SMW_Misc_Mode7TilemapIndex = $001BA2
!RAM_SMW_Graphics_Mode7TileBuffer = $001BA3
	!RAM_SMW_Graphics_3BPPTo4BPPBuffer = $001BB2
	!RAM_SMW_Flag_Alter3BPPTo4BPPConversion = $001BBC
!RAM_SMW_Misc_LevelLayer3Settings = $001BE3
!RAM_SMW_Blocks_Layer1VRAMUploadAddressLo = $001BE4
!RAM_SMW_Blocks_Layer1VRAMUploadAddressHi = !RAM_SMW_Blocks_Layer1VRAMUploadAddressLo+$01
!RAM_SMW_Blocks_Layer1TilesToUploadBuffer = $001BE6
!RAM_SMW_Blocks_Layer2VRAMUploadAddressLo = $001CE6
!RAM_SMW_Blocks_Layer2VRAMUploadAddressHi = !RAM_SMW_Blocks_Layer2VRAMUploadAddressLo+$01
!RAM_SMW_Blocks_Layer2TilesToUploadBuffer = $001CE8
!RAM_SMW_Overworld_SubmapSwitchProcess = $001DE8
!RAM_SMW_Counter_EnemyRollcallScreen = $001DE9
	!RAM_SMW_Overworld_CheckIfEventPassedFlag = $001DE9
!RAM_SMW_Overworld_CurrentEventNumber = $001DEA
!RAM_SMW_Overworld_StartingEventTileLo = $001DEB
!RAM_SMW_Overworld_StartingEventTileHi = !RAM_SMW_Overworld_StartingEventTileLo+$01
!RAM_SMW_Overworld_FinalEventTileLo = $001DED
!RAM_SMW_Overworld_FinalEventTileHi = !RAM_SMW_Overworld_FinalEventTileLo+$01
;Empty $001DEF
!RAM_SMW_Overworld_ScrollCameraXPosLo = $001DF0
!RAM_SMW_Overworld_ScrollCameraXPosHi = !RAM_SMW_Overworld_ScrollCameraXPosLo+$01
!RAM_SMW_Overworld_ScrollCameraYPosLo = $001DF2
!RAM_SMW_Overworld_ScrollCameraYPosHi = !RAM_SMW_Overworld_ScrollCameraYPosLo+$01
!RAM_SMW_Misc_TitleScreenMovementDataIndex = $001DF4
!RAM_SMW_Timer_TitleScreenInputTimer = $001DF5
	!RAM_SMW_Timer_DisplayNintendoPresents = $001DF5
	!RAM_SMW_Timer_DisplaySpecialMessage = $001DF5
!RAM_SMW_Overworld_StarPipeIndex = $001DF6
!RAM_SMW_Overworld_StarLaunchSpeed = $001DF7
!RAM_SMW_Timer_WaitBeforeStarLaunch = $001DF8
!RAM_SMW_IO_SoundCh1 = $001DF9
!RAM_SMW_IO_SoundCh2 = !RAM_SMW_IO_SoundCh1+$01
!RAM_SMW_IO_MusicCh1 = !RAM_SMW_IO_SoundCh1+$02
!RAM_SMW_IO_SoundCh3 = !RAM_SMW_IO_SoundCh1+$03
!RAM_SMW_UnusedRAM_7E1DFD = $001DFD
!RAM_SMW_UnusedRAM_7E1DFE = !RAM_SMW_UnusedRAM_7E1DFD+$01
!RAM_SMW_IO_CopyOfMusicCh1 = !RAM_SMW_UnusedRAM_7E1DFD+$02
!RAM_SMW_UnusedRAM_7E1E00 = !RAM_SMW_UnusedRAM_7E1DFD+$03
!RAM_SMW_Debug_FreeMovement = $001E01
!RAM_SMW_ClusterSpr_YPosLo = $001E02
!RAM_SMW_ClusterSpr_XPosLo = $001E16
!RAM_SMW_ClusterSpr_YPosHi = $001E2A
!RAM_SMW_ClusterSpr_XPosHi = $001E3E
!RAM_SMW_ClusterSpr_Table7E1E52 = $001E52
!RAM_SMW_ClusterSpr_Table7E1E66 = $001E66
!RAM_SMW_ClusterSpr_Table7E1E7A = $001E7A
!RAM_SMW_ClusterSpr_Table7E1E8E = $001E8E
!RAM_SMW_Overworld_LevelTileSettings = $001EA2			; 96 bytes
!RAM_SMW_Overworld_EventFlags = $001F02
!RAM_SMW_Overworld_MarioMap = $001F11
!RAM_SMW_Overworld_LuigiMap = !RAM_SMW_Overworld_MarioMap+$01
!RAM_SMW_Overworld_MarioAnimationLo = $001F13
!RAM_SMW_Overworld_MarioAnimationHi = !RAM_SMW_Overworld_MarioAnimationLo+$01
!RAM_SMW_Overworld_LuigiAnimationLo = !RAM_SMW_Overworld_MarioAnimationLo+$02
!RAM_SMW_Overworld_LuigiAnimationHi = !RAM_SMW_Overworld_MarioAnimationLo+$03
!RAM_SMW_Overworld_MarioXPosLo = $001F17
!RAM_SMW_Overworld_MarioXPosHi = !RAM_SMW_Overworld_MarioXPosLo+$01
!RAM_SMW_Overworld_MarioYPosLo = !RAM_SMW_Overworld_MarioXPosLo+$02
!RAM_SMW_Overworld_MarioYPosHi = !RAM_SMW_Overworld_MarioXPosLo+$03
!RAM_SMW_Overworld_LuigiXPosLo = !RAM_SMW_Overworld_MarioXPosLo+$04
!RAM_SMW_Overworld_LuigiXPosHi = !RAM_SMW_Overworld_MarioXPosLo+$05
!RAM_SMW_Overworld_LuigiYPosLo = !RAM_SMW_Overworld_MarioXPosLo+$06
!RAM_SMW_Overworld_LuigiYPosHi = !RAM_SMW_Overworld_MarioXPosLo+$07
!RAM_SMW_Overworld_MarioGridAlignedXPosLo = $001F1F
!RAM_SMW_Overworld_MarioGridAlignedXPosHi = !RAM_SMW_Overworld_MarioGridAlignedXPosLo+$01
!RAM_SMW_Overworld_MarioGridAlignedYPosLo = !RAM_SMW_Overworld_MarioGridAlignedXPosLo+$02
!RAM_SMW_Overworld_MarioGridAlignedYPosHi = !RAM_SMW_Overworld_MarioGridAlignedXPosLo+$03
!RAM_SMW_Overworld_LuigiGridAlignedXPosLo = !RAM_SMW_Overworld_MarioGridAlignedXPosLo+$04
!RAM_SMW_Overworld_LuigiGridAlignedXPosHi = !RAM_SMW_Overworld_MarioGridAlignedXPosLo+$05
!RAM_SMW_Overworld_LuigiGridAlignedYPosLo = !RAM_SMW_Overworld_MarioGridAlignedXPosLo+$06
!RAM_SMW_Overworld_LuigiGridAlignedYPosHi = !RAM_SMW_Overworld_MarioGridAlignedXPosLo+$07
!RAM_SMW_Flag_ActivatedGreenSwitch = $001F27
!RAM_SMW_Flag_ActivatedYellowSwitch = !RAM_SMW_Flag_ActivatedGreenSwitch+$01
!RAM_SMW_Flag_ActivatedBlueSwitch = !RAM_SMW_Flag_ActivatedGreenSwitch+$02
!RAM_SMW_Flag_ActivatedRedSwitch = !RAM_SMW_Flag_ActivatedGreenSwitch+$03
;Empty $001F2B-$001F2D
!RAM_SMW_Counter_EventsTriggered = $001F2E
!RAM_SMW_Flag_Collected5YoshiCoins = $001F2F
;Empty $001F3B
!RAM_SMW_Flag_Collected1upCheckpoints = $001F3C
;Empty $001F48
!RAM_SMW_Overworld_SaveBuffer = $001F49
!RAM_SMW_NorSpr_UnusedTable7E1FD6 = $001FD6
!RAM_SMW_NorSpr_DecrementingTable7E1FE2 = $001FE2
!RAM_SMW_Flag_CollectedMoons = $001FEE
;Empty $001FFA
!RAM_SMW_Palettes_LightningFlashColorIndex = $001FFB
!RAM_SMW_Timer_WaitBeforeNextLightningFlash = $001FFC
!RAM_SMW_Timer_LightningFrameDuration = $001FFD
!RAM_SMW_Flag_UpdateCreditsBackground = $001FFE
;Empty $001FFF

;Non Mirrored RAM
!RAM_SMW_Graphics_DecompressedGFX32 = $7E2000		; $7E2000-$7E7CFF
!RAM_SMW_Graphics_DecompressedGFX33 = !RAM_SMW_Graphics_DecompressedGFX32+$5D00
!RAM_SMW_Graphics_GraphicDecompressionBuffer = $7EAD00
!RAM_SMW_Blocks_Layer2TilesLo = $7EB900
	!RAM_SMW_Overworld_SwitchBlockXPosHi = $7EB900
	!RAM_SMW_Overworld_SwitchBlockYPosHi = !RAM_SMW_Overworld_SwitchBlockXPosHi+((!Define_SMW_MaxSwitchBlockSlot+$01)*$01)
	!RAM_SMW_Overworld_SwitchBlockZPosHi = !RAM_SMW_Overworld_SwitchBlockXPosHi+((!Define_SMW_MaxSwitchBlockSlot+$01)*$02)
	!RAM_SMW_Overworld_SwitchBlockXPosLo = !RAM_SMW_Overworld_SwitchBlockXPosHi+((!Define_SMW_MaxSwitchBlockSlot+$01)*$03)
	!RAM_SMW_Overworld_SwitchBlockYPosLo = !RAM_SMW_Overworld_SwitchBlockXPosLo+((!Define_SMW_MaxSwitchBlockSlot+$01)*$01)
	!RAM_SMW_Overworld_SwitchBlockZPosLo = !RAM_SMW_Overworld_SwitchBlockXPosLo+((!Define_SMW_MaxSwitchBlockSlot+$01)*$02)
	!RAM_SMW_Overworld_SwitchBlockXSpeed = !RAM_SMW_Overworld_SwitchBlockXPosHi+((!Define_SMW_MaxSwitchBlockSlot+$01)*$06)
	!RAM_SMW_Overworld_SwitchBlockYSpeed = !RAM_SMW_Overworld_SwitchBlockXSpeed+((!Define_SMW_MaxSwitchBlockSlot+$01)*$01)
	!RAM_SMW_Overworld_SwitchBlockZSpeed = !RAM_SMW_Overworld_SwitchBlockXSpeed+((!Define_SMW_MaxSwitchBlockSlot+$01)*$02)
	!RAM_SMW_Overworld_SwitchBlockSubXPos = !RAM_SMW_Overworld_SwitchBlockXPosHi+((!Define_SMW_MaxSwitchBlockSlot+$01)*$09)
	!RAM_SMW_Overworld_SwitchBlockSubYPos = !RAM_SMW_Overworld_SwitchBlockSubXPos+((!Define_SMW_MaxSwitchBlockSlot+$01)*$01)
	!RAM_SMW_Overworld_SwitchBlockSubZPos = !RAM_SMW_Overworld_SwitchBlockSubXPos+((!Define_SMW_MaxSwitchBlockSlot+$01)*$02)
!RAM_SMW_Blocks_Layer2TilesHi = !RAM_SMW_Blocks_Layer2TilesLo+$0400
;Empty $7EC100-$7EC67F
!RAM_SMW_Misc_Mode7BossTilemap = $7EC680
;Empty $7EC6E0-$7EC7FF
!RAM_SMW_Blocks_Map16TableLo = $7EC800
	!RAM_SMW_Overworld_LevelNumberOfEachTileTBL = !RAM_SMW_Blocks_Map16TableLo+$0800
	!RAM_SMW_Overworld_LevelDirectionFlags = !RAM_SMW_Blocks_Map16TableLo+$1000

!RAM_SMW_Overworld_Layer2EventTiles = $7F0000
!RAM_SMW_Overworld_Layer2Tiles = $7F4000
	!RAM_SMW_Misc_CreditsBackgroundBuffer = !RAM_SMW_Overworld_Layer2Tiles
!RAM_SMW_Sprites_ResetSpriteOAMRt = $7F8000
;Empty $7F8183-$7F837A
!RAM_SMW_Misc_StripeImageUploadIndexLo = $7F837B
!RAM_SMW_Misc_StripeImageUploadIndexHi = !RAM_SMW_Misc_StripeImageUploadIndexLo+$01
!RAM_SMW_Misc_StripeImageUploadTable = $7F837D						; $7F837D-$7F977A
!RAM_SMW_Graphics_DecompressedLoadingLetters = $7F977B					; $7F977B-$7F9A7A
!RAM_SMW_NorSpr086_Wiggler_SegmentPosTable = $7F9A7B
;Empty $7F9C7B-$7F9C7FF
!RAM_SMW_Blocks_Map16TableHi = !RAM_SMW_Blocks_Map16TableLo+$010000

;VRAM Map
!VRAM_SMW_Layer1GFXVRAMLocation = (!Define_SMW_Layer1GFXVRAMLocation*$1000)&$007FFF
!VRAM_SMW_Layer2GFXVRAMLocation = !VRAM_SMW_Layer1GFXVRAMLocation
!VRAM_SMW_Layer4GFXVRAMLocation = (!Define_SMW_Layer4GFXVRAMLocation*$1000)&$007FFF
!VRAM_SMW_Layer4TilemapVRAMLocation = (!Define_SMW_Layer4TilemapVRAMLocation*$0400)&$00FFFF
!VRAM_SMW_Layer1TilemapVRAMLocation = (!Define_SMW_Layer1TilemapVRAMLocation*$0400)&$00FFFF
!VRAM_SMW_Layer2TilemapVRAMLocation = (!Define_SMW_Layer2TilemapVRAMLocation*$0400)&$00FFFF
!VRAM_SMW_Layer3GFXVRAMLocation = (!Define_SMW_Layer3GFXVRAMLocation*$1000)&$007FFF
!VRAM_SMW_Layer3TilemapVRAMLocation = (!Define_SMW_Layer3TilemapVRAMLocation*$0400)&$00FFFF
!VRAM_SMW_SpriteGFXLocationLo = (!SpriteGFXLocationInVRAMLo_6000*$2000)&$00FFFF
!VRAM_SMW_SpriteGFXLocationHi = (!VRAM_SMW_SpriteGFXLocationLo+$1000+((!SpriteGFXLocationInVRAMHi_Add1000>>3)*$1000))&$00FFFF
!VRAM_SMW_Layer1TilemapVRAMLocation_Mode7 = (!Define_SMW_Layer1TilemapVRAMLocation_Mode7*$0400)&$00FFFF
!VRAM_SMW_Layer1GFXVRAMLocation_Mode7 = (!Define_SMW_Layer1GFXVRAMLocation_Mode7*$1000)&$007FFF

;CGRAM
!CGRAM_SMW_DynamicPlayerPalette = $86
!CGRAM_SMW_YoshiCoinFlash = $64
!CGRAM_SMW_YellowLevelTile = $6D
!CGRAM_SMW_RedLevelTile = $7D

;OAM Map
!OAM_SMW_GenericMiscSprite = $00
!OAM_SMW_GenericNormalSprite = $40
!OAM_SMW_NintendoPresents = $00
!OAM_SMW_ItemBoxItem_NormalLevel = $38
!OAM_SMW_ItemBoxItem_BowserReznorMortonRoyRoom = $00^(!OAM_SMW_ItemBoxItem_NormalLevel&$40)
!OAM_SMW_NorSpr0A0_ActivateBowserBattle_ItemBox = $01
!OAM_SMW_NorSpr0A0_ActivateBowserBattle_CastleRoofDuringFight = $6F
!OAM_SMW_NorSpr0A0_ActivateBowserBattle_CastleRoofDuringEnding = $64

;SMAS+W Exclusive RAM/SRAM/VRAM/OAM
if !Define_Global_ROMToAssemble&(!ROM_SMASW_U|!ROM_SMASW_E) != $00
!RAM_SMW_Blocks_Map16TableLo = $7EC700
	!RAM_SMW_Overworld_LevelNumberOfEachTileTBL = !RAM_SMW_Blocks_Map16TableLo+$0800
	!RAM_SMW_Overworld_LevelDirectionFlags = !RAM_SMW_Blocks_Map16TableLo+$1000
!RAM_SMW_Blocks_Map16TableHi = !RAM_SMW_Blocks_Map16TableLo+$010000
endif

;Lunar Magic RAM										; Todo: Some of these might need more verification
!RAM_SMW_LM_Blocks_CurrentlyProcessedMap16TileLo = !RAM_SMW_Misc_ScratchRAM03
!RAM_SMW_LM_Blocks_CurrentlyProcessedMap16TileHi = !RAM_SMW_LM_Blocks_CurrentlyProcessedMap16TileLo+$01
!RAM_SMW_LM_CustomLevelDimensions_ScratchRAM45 = $000045
!RAM_SMW_LM_CustomLevelDimensions_ScratchRAM46 = $000046
!RAM_SMW_LM_CustomLevelDimensions_ScratchRAM47 = !RAM_SMW_LM_CustomLevelDimensions_ScratchRAM46+$01
!RAM_SMW_LM_CustomLevelDimensions_ScratchRAM48 = $000048
!RAM_SMW_LM_CustomLevelDimensions_ScratchRAM49 = $000049
!RAM_SMW_LM_CustomLevelDimensions_ScratchRAM4A = $00004A
!RAM_SMW_LM_CustomLevelDimensions_ScratchRAM4B = $00004B
!RAM_SMW_LM_CustomLevelDimensions_ScratchRAM4C = $00004C
!RAM_SMW_LM_CustomLevelDimensions_ScratchRAM4D = !RAM_SMW_LM_CustomLevelDimensions_ScratchRAM4C+$01
!RAM_SMW_LM_CustomLevelDimensions_ScratchRAM4E = $00004E
!RAM_SMW_LM_CustomLevelDimensions_ScratchRAM4F = !RAM_SMW_LM_CustomLevelDimensions_ScratchRAM4E+$01
!RAM_SMW_LM_CustomLevelDimensions_ScratchRAM50 = $000050
!RAM_SMW_LM_CustomLevelDimensions_ScratchRAM51 = !RAM_SMW_LM_CustomLevelDimensions_ScratchRAM50+$01
!RAM_SMW_LM_CustomLevelDimensions_ScratchRAM52 = $000052
!RAM_SMW_LM_CustomLevelDimensions_ScratchRAM53 = !RAM_SMW_LM_CustomLevelDimensions_ScratchRAM52+$01
!RAM_SMW_LM_CustomLevelDimensions_ScratchRAM54 = $000054
!RAM_SMW_LM_CustomLayer3Interaction_ScratchRAMD8 = $0000D8
!RAM_SMW_LM_CustomLayer3Interaction_ScratchRAMD9 = !RAM_SMW_LM_CustomLayer3Interaction_ScratchRAMD8+$01
!RAM_SMW_LM_LCZ3_ScratchRAMD8 = $0000D8
!RAM_SMW_LM_LCZ3_ScratchRAMD9 = $0000D9
!RAM_SMW_LM_LCZ3_ScratchRAMDA = $0000DA
!RAM_SMW_LM_LCZ3_ScratchRAMDB = $0000DB
!RAM_SMW_LM_LCZ3_ScratchRAMDC = $0000DC
!RAM_SMW_LM_LCZ3_ScratchRAMDD = $0000DD
!RAM_SMW_LM_LCZ3_ScratchRAMDE = $0000DE
!RAM_SMW_LM_LCZ3_ScratchRAMDF = $0000DF
!RAM_SMW_LM_LCZ3_ScratchRAME0 = $0000E0
!RAM_SMW_LM_LCZ3_ScratchRAME1 = $0000E1
!RAM_SMW_LM_LCZ3_ScratchRAME2 = $0000E2
!RAM_SMW_LM_LCZ3_ScratchRAME3 = $0000E3
!RAM_SMW_LM_LCZ3_ScratchRAME4 = $0000E4
!RAM_SMW_LM_LCZ3_ScratchRAME5 = $0000E5
!RAM_SMW_LM_LCZ3_ScratchRAME6 = $0000E6
!RAM_SMW_LM_LCZ3_ScratchRAME7 = $0000E7
!RAM_SMW_LM_LCZ3_ScratchRAME8 = $0000E8
!RAM_SMW_LM_LCZ3_ScratchRAME9 = $0000E9
!RAM_SMW_LM_Misc_OldGFXBypassUnusedRAM = $0000FA
!RAM_SMW_LM_Misc_OldGFXBypassAn2GFXList = $0000FB
!RAM_SMW_LM_Misc_OldGFXBypassFGBGGFXList = $0000FC
!RAM_SMW_LM_Misc_OldGFXBypassSpriteGFXList = $0000FD
!RAM_SMW_LM_Misc_CurrentLevelMinusOneLo = $0000FE
!RAM_SMW_LM_Misc_CurrentLevelMinusOneHi = !RAM_SMW_LM_Misc_CurrentLevelMinusOneLo+$01
!RAM_SMW_LM_Table_UnknownRAM7E0695 = $000695									; Note: 100 bytes
!RAM_SMW_LM_Misc_UnknownRAM7E0BF0 = $000BF0
!RAM_SMW_LM_Misc_UnknownRAM7E0BF1 = $000BF1
!RAM_SMW_LM_Misc_UnknownRAM7E0BF2 = $000BF2
!RAM_SMW_LM_Misc_UnknownRAM7E0BF3 = $000BF3
!RAM_SMW_LM_Misc_UnknownRAM7E0BF4 = $000BF4
!RAM_SMW_LM_Misc_UnknownRAM7E0BF5 = $000BF5
!RAM_SMW_LM_Misc_24BitL1LevelScreenPosLoPtrs = $000BF6
!RAM_SMW_LM_Misc_24BitL2LevelScreenPosLoPtrs = $000C26
!RAM_SMW_LM_Misc_24BitL1LevelScreenPosHiPtrs = $000C56
!RAM_SMW_LM_Misc_24BitL2LevelScreenPosHiPtrs = $000C86
!RAM_SMW_LM_Misc_8BitL1LevelScreenPosLoPtrs = $000CB6
!RAM_SMW_LM_Misc_8BitL2LevelScreenPosLoPtrs = $000CC6
!RAM_SMW_LM_Misc_8BitL1LevelScreenPosHiPtrs = $000CD6
!RAM_SMW_LM_Misc_8BitL2LevelScreenPosHiPtrs = $000CE6
!RAM_SMW_LM_Misc_UnknownRAM7E0CF6 = $000CF6
!RAM_SMW_LM_Misc_UnknownRAM7E0D36 = $000D36
!RAM_SMW_LM_Misc_LevelScreenSizeLo = $0013D7
!RAM_SMW_LM_Misc_LevelScreenSizeHi = !RAM_SMW_LM_Misc_LevelScreenSizeLo+$01
!RAM_SMW_LM_Misc_UnknownRAM7E13CD = $0013CD
!RAM_SMW_LM_Misc_Layer3Settings = $00145E
!RAM_SMW_LM_Misc_Layer3ScrollSettings = $00145F
!RAM_SMW_LM_Misc_Layer3AutoScrollSubYPosLo = !RAM_SMW_Flag_Layer3VerticalScrollDirection
!RAM_SMW_LM_Misc_Layer3AutoScrollSubYPosHi = !RAM_SMW_LM_Misc_Layer3AutoScrollSubYPosLo+$01
!RAM_SMW_LM_Misc_Layer3InitialXOffsetLo = !RAM_SMW_Misc_Layer3XDispLo
!RAM_SMW_LM_Misc_Layer3InitialXOffsetHi = !RAM_SMW_LM_Misc_Layer3InitialXOffsetLo+$01
!RAM_SMW_LM_Misc_FixLayer3ScrollSyncXPosLo = !RAM_SMW_Overworld_ProcessHardcodedPathFlagLo
!RAM_SMW_LM_Misc_FixLayer3ScrollSyncXPosHi = !RAM_SMW_LM_Misc_FixLayer3ScrollSyncXPosLo+$01
!RAM_SMW_LM_Misc_FixLayer3ScrollSyncYPosLo = !RAM_SMW_Overworld_HardcodedPathIndexLo
!RAM_SMW_LM_Misc_FixLayer3ScrollSyncYPosHi = !RAM_SMW_LM_Misc_FixLayer3ScrollSyncYPosLo+$01
!RAM_SMW_LM_Misc_LevelScreenSizeMinus10Lo = $001936
!RAM_SMW_LM_Misc_LevelScreenSizeMinus10Hi = !RAM_SMW_LM_Misc_LevelScreenSizeMinus10Lo+$01
!RAM_SMW_LM_Misc_AltDecompressionBuffer = $7EB500
!RAM_SMW_LM_Misc_Layer3TilemapDecompressionBuffer = $7EBD00
RAM_SMW_LM_Misc_TitleScreenMovementDataBuffer = $7F0000
!RAM_SMW_LM_Misc_UnknownDecompressionBuffer = $7F2000
!RAM_SMW_LM_VRAMPatch_L1HorizVRAMLocLo = $7F8183
!RAM_SMW_LM_VRAMPatch_L1HorizVRAMLocHi = !RAM_SMW_LM_VRAMPatch_L1HorizVRAMLocLo+$01
!RAM_SMW_LM_VRAMPatch_L2HorizVRAMLocLo = $7F8185
!RAM_SMW_LM_VRAMPatch_L2HorizVRAMLocHi = !RAM_SMW_LM_VRAMPatch_L2HorizVRAMLocLo+$01
!RAM_SMW_LM_VRAMPatch_L1VertVRAMLocLo = $7F8187
!RAM_SMW_LM_VRAMPatch_L1VertVRAMLocHi = !RAM_SMW_LM_VRAMPatch_L1VertVRAMLocLo+$01
!RAM_SMW_LM_VRAMPatch_L2VertVRAMLocLo = $7F8189
!RAM_SMW_LM_VRAMPatch_L2VertVRAMLocHi = !RAM_SMW_LM_VRAMPatch_L2VertVRAMLocLo+$01
!RAM_SMW_LM_VRAMPatch_L1VertTilesVRAMUploadAddr = $7F820B
!RAM_SMW_LM_VRAMPatch_L2VertTilesVRAMUploadAddr = $7F828B
!RAM_SMW_LM_VRAMPatch_UnknownRAM1 = $7F8327
!RAM_SMW_LM_VRAMPatch_UnknownRAM2 = !RAM_SMW_LM_VRAMPatch_UnknownRAM1+$01
!RAM_SMW_LM_Blocks_Layer2TilesLo = $7FBC00									; Note: 1024 bytes. Used by the VRAM patch
!RAM_SMW_LM_Pointer_LocalExAnimationAddressLo = $7FC000
!RAM_SMW_LM_Pointer_LocalExAnimationAddressHi = !RAM_SMW_LM_Pointer_LocalExAnimationAddressLo+$01
!RAM_SMW_LM_Pointer_LocalExAnimationAddressBank = !RAM_SMW_LM_Pointer_LocalExAnimationAddressLo+$02
!RAM_SMW_LM_Counter_LocalExAnimationFrames = $7FC003
!RAM_SMW_LM_Misc_UnknownRAM7FC004 = $7FC004
!RAM_SMW_LM_Pointer_SuperGFXBypassTBLLo = $7FC006
!RAM_SMW_LM_Pointer_SuperGFXBypassTBLHi = !RAM_SMW_LM_Pointer_SuperGFXBypassTBLLo+$01
!RAM_SMW_LM_Pointer_SuperGFXBypassTBLBank = !RAM_SMW_LM_Pointer_SuperGFXBypassTBLLo+$02
!RAM_SMW_LM_Misc_UnknownRAM7FC009 = $7FC009
!RAM_SMW_LM_Flag_ExAnimationSettings = $7FC00A
!RAM_SMW_LM_Misc_Layer2Properties = $7FC00B
!RAM_SMW_LM_Misc_TotalLocalExAnimationsLo = $7FC00C								;\ Todo: I'm 99% sure that this is what these addresses are for.
!RAM_SMW_LM_Misc_TotalLocalExAnimationsHi = !RAM_SMW_LM_Misc_TotalLocalExAnimationsLo+$01				;|
!RAM_SMW_LM_Misc_TotalGlobalExAnimationsLo = $7FC00E								;|
!RAM_SMW_LM_Misc_TotalGlobalExAnimationsHi = !RAM_SMW_LM_Misc_TotalGlobalExAnimationsLo+$01			;/
!RAM_SMW_LM_Pointer_LocalAltExGFXLocLo = $7FC010
!RAM_SMW_LM_Pointer_LocalAltExGFXLocHi = !RAM_SMW_LM_Pointer_LocalAltExGFXLocLo+$01
!RAM_SMW_LM_Pointer_LocalAltExGFXLocBank = !RAM_SMW_LM_Pointer_LocalAltExGFXLocLo+$02
!RAM_SMW_LM_Pointer_GlobalAltExGFXLocLo = $7FC013
!RAM_SMW_LM_Pointer_GlobalAltExGFXLocHi = !RAM_SMW_LM_Pointer_GlobalAltExGFXLocLo+$01
!RAM_SMW_LM_Pointer_GlobalAltExGFXLocBank = !RAM_SMW_LM_Pointer_GlobalAltExGFXLocLo+$02
!RAM_SMW_LM_Pointer_GlobalExAnimationAddressLo = $7FC016
!RAM_SMW_LM_Pointer_GlobalExAnimationAddressHi = !RAM_SMW_LM_Pointer_GlobalExAnimationAddressLo+$01
!RAM_SMW_LM_Pointer_GlobalExAnimationAddressBank = !RAM_SMW_LM_Pointer_GlobalExAnimationAddressLo+$02
!RAM_SMW_LM_Misc_UnknownRAM7FC019 = $7FC019
!RAM_SMW_LM_Misc_CustomLayer3Settings = $7FC01A
!RAM_SMW_LM_Misc_UnknownRAM7FC01B = $7FC01B
!RAM_SMW_LM_Misc_UnknownRAM7FC01C = !RAM_SMW_LM_Misc_UnknownRAM7FC01B+$01
!RAM_SMW_LM_Misc_ConditionalMap16FlagsTable = $7FC060								; Note: 16 bytes
!RAM_SMW_LM_Misc_ExAnimationManualFrames = $7FC070								; Note: 16 bytes
!RAM_SMW_LM_Misc_ExAnimationLevelFrameCount = $7FC080							; Note: 32 bytes
!RAM_SMW_LM_Misc_ExAnimationGlobalFrameCount = !RAM_SMW_LM_Misc_ExAnimationLevelFrameCount+$20			; Note: 32 bytes
!RAM_SMW_LM_Misc_ExAnimationDMAParametersTable = $7FC0C0
!RAM_SMW_LM_Misc_ExAnimationOneShotTriggers = $7FC0F8							; Note: 4 bytes
!RAM_SMW_LM_Misc_ExAnimationCustomTriggers = $7FC0FC
!RAM_SMW_LM_Blocks_Layer2TilesLo = $7FC300									; Note: 1024 bytes. Used by the VRAM patch
!RAM_SMW_LM_Misc_UnknownRAM7FFFF8 = $7FFFF8
!RAM_SMW_LM_Misc_UnknownRAM7FFFF9 = $7FFFF9
!RAM_SMW_LM_Misc_UnknownRAM7FFFFA = $7FFFFA
!RAM_SMW_LM_Misc_UnknownRAM7FFFFB = $7FFFFB
!RAM_SMW_LM_Misc_UnknownRAM7FFFFC = $7FFFFC
!RAM_SMW_LM_Misc_UnknownRAM7FFFFD = $7FFFFD
!RAM_SMW_LM_Misc_UnknownRAM7FFFFE = $7FFFFE

;SA-1 RAM (used by Lunar Magic)
!RAM_SMW_SA1_SNESCodePointerLo = $000183
!RAM_SMW_SA1_SNESCodePointerHi = !RAM_SMW_SA1_SNESCodePointerLo+$01
!RAM_SMW_SA1_SNESCodePointerBank = !RAM_SMW_SA1_SNESCodePointerLo+$02
!RAM_SMW_SA1_SNESDoneFlag = $00018A

;RAM Tables

struct SMW_Stack !RAM_SMW_Misc_EndOfStack
	.Byte skip $01
endstruct align $01

struct SMW_OAMBuffer !RAM_SMW_IO_OAMBuffer
	.XDisp: skip $01
	.YDisp: skip $01
	.Tile: skip $01
	.Prop: skip $01
endstruct align $04

struct SMW_ParallaxScrollHDMA !RAM_SMW_Misc_HDMAWindowEffectTable
	.Scanline1: skip $01
	.PosLo1: skip $01
	.PosHi1: skip $01
	.Scanline2: skip $01
	.PosLo2: skip $01
	.PosHi2: skip $01
	.Scanline3: skip $01
	.PosLo3: skip $01
	.PosHi3: skip $01
	.End: skip $01
endstruct

struct SMW_UpperOAMBuffer !RAM_SMW_IO_OAMBuffer+$0200
	.Slot: skip $01
endstruct align $01

struct SMW_OAMTileSizeBuffer !RAM_SMW_Sprites_OAMTileSizeBuffer
	.Slot: skip $01
endstruct

struct SMW_StripeImageUploadTable !RAM_SMW_Misc_StripeImageUploadTable
	.LowByte: skip $01
	.HighByte: skip $01
endstruct align $02

struct SMW_DynamicSpritePointersTop !RAM_SMW_Graphics_DynamicSpritePointersTopLo
	.LowByte: skip $01
	.HighByte: skip $01
endstruct align $02

struct SMW_DynamicSpritePointersBottom !RAM_SMW_Graphics_DynamicSpritePointersBottomLo
	.LowByte: skip $01
	.HighByte: skip $01
endstruct align $02

struct SMW_PaletteMirror !RAM_SMW_Palettes_PaletteMirror
	.LowByte: skip $01
	.HighByte: skip $01
endstruct align $02

struct SMW_CopyOfPaletteMirror !RAM_SMW_Palettes_CopyOfPaletteMirror
	.LowByte: skip $01
	.HighByte: skip $01
endstruct align $02

struct SMW_GraphicDecompressionBuffer !RAM_SMW_Graphics_GraphicDecompressionBuffer
	.Tile: skip $18
endstruct align $18

struct SMW_ExAnimationDMAParameters !RAM_SMW_LM_Misc_ExAnimationDMAParametersTable
	.SizeLo: skip $01
	.SizeHi: skip $01
	.UploadAddressLo: skip $01
	.UploadAddressHi: skip $01
	.SourceLo: skip $01
	.SourceHi: skip $01
	.SourceBank: skip $01
endstruct align $07


;Sprite RAM
;---------------------------------------------------------------------------

!RAM_SMW_NorSprXXX_GenericEnemies_BounceHeight = !RAM_SMW_NorSpr_Table7E160E

!RAM_SMW_NorSprXXX_NakedKoopa_FlipOrKickShellTimer = !RAM_SMW_NorSpr_Table7E00C2

!RAM_SMW_NorSpr003_YellowNakedKoopa_WaitBeforeFacingMario = !RAM_SMW_NorSpr_Table7E1570

!RAM_SMW_NorSpr007_YellowKoopa_WaitBeforeFacingMario = !RAM_SMW_NorSpr_Table7E1570

!RAM_SMW_NorSpr00C_YellowParaKoopa_WaitBeforeFacingMario = !RAM_SMW_NorSpr_Table7E1570

!RAM_SMW_NorSpr00D_BobOmb_IsExploding = !RAM_SMW_NorSpr_Table7E1534
!RAM_SMW_NorSpr00D_BobOmb_WaitBeforeExplosion = !RAM_SMW_NorSpr_DecrementingTable7E1540

!RAM_SMW_NorSpr00F_Goomba_StunTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr00E_Keyhole_HighestSlotWithKey = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSpr00E_Keyhole_ActivateKeyholeFlag = !RAM_SMW_NorSpr_DecrementingTable7E154C
!RAM_SMW_NorSpr00E_Keyhole_XPosLo = !RAM_SMW_Misc_ScratchRAM7E1436
!RAM_SMW_NorSpr00E_Keyhole_XPosHi = !RAM_SMW_NorSpr00E_Keyhole_XPosLo+$01
!RAM_SMW_NorSpr00E_Keyhole_YPosLo = !RAM_SMW_Misc_ScratchRAM7E1438
!RAM_SMW_NorSpr00E_Keyhole_YPosHi = !RAM_SMW_NorSpr00E_Keyhole_YPosLo+$01

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr010_ParaGoomba_FacePlayerTimer = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr010_ParaGoomba_HopCounter = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSpr010_ParaGoomba_WaitBeforeHoppingAfterBigHop = !RAM_SMW_NorSpr_DecrementingTable7E1540

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr012_UnusedSprite_UnknownRAM = !RAM_SMW_NorSpr_Table7E1534

;---------------------------------------------------------------------------

!RAM_SMW_NorSprXXX_FixedMovementCheepCheep_MovementDirection = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSprXXX_FixedMovementCheepCheep_MovementFlag = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSprXXX_FixedMovementCheepCheep_TurnAroundTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr018_SurfaceJumpingCheepCheep_HopCounter = !RAM_SMW_NorSpr_Table7E00C2

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr019_DisplayMessage_WaitBeforeDisplayMessage  = !RAM_SMW_NorSpr_DecrementingTable7E1564

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr01B_Football_WaitBeforeBeingKicked = !RAM_SMW_NorSpr_DecrementingTable7E1540

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr01C_BulletBill_FiringDirection = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr01C_BulletBill_AppearBehindLayer1Timer = !RAM_SMW_NorSpr_DecrementingTable7E1540

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr01D_HoppingFlame_WaitBeforeHopping = !RAM_SMW_NorSpr_DecrementingTable7E1540

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr01E_Lakitu_FishingFlag = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSpr01E_Lakitu_ThrowingAnimationTimer = !RAM_SMW_NorSpr_DecrementingTable7E1558
!RAM_SMW_NorSpr01E_Lakitu_FishingLineXDisp = !RAM_SMW_Misc_ScratchRAM7E185E
!RAM_SMW_NorSpr01E_Lakitu_FishingLineYDisp = !RAM_SMW_Misc_ScratchRAM7E18B6

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr01F_MagiKoopa_CurrentState = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr01F_MagiKoopa_FadeTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSpr01F_MagiKoopa_FadePaletteIndex = !RAM_SMW_NorSpr_Table7E1570
!RAM_SMW_NorSpr01F_MagiKoopa_DisableInteraction = !RAM_SMW_NorSpr_Table7E15D0

;---------------------------------------------------------------------------

!RAM_SMW_NorSprXXX_NetKoopas_MovementDirectionFlag = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSprXXX_NetKoopas_TurnAroundToOtherSideTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSprXXX_NetKoopas_MovementDirection = !RAM_SMW_NorSpr_Table7E157C

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr026_Thwomp_CurrentState = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr026_Thwomp_InitialYPosLo = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSpr026_Thwomp_FaceFrame = !RAM_SMW_NorSpr_Table7E1528
!RAM_SMW_NorSpr026_Thwomp_WaitBeforeRising = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSpr026_Thwomp_SidePlayerIsOn = !RAM_SMW_NorSpr_Table7E157C

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr027_Thwimp_HoppingDirection = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr027_Thwimp_WaitBeforeNextHop = !RAM_SMW_NorSpr_DecrementingTable7E1540

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr029_KoopaKid_KoopaKidType = !RAM_SMW_NorSprXXX_CurrentlyActiveBoss

!RAM_SMW_NorSpr029_KoopaKid_MortonRoyLudwig_CurrentState = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSpr029_KoopaKid_MortonRoyLudwig_AttackPointer = !RAM_SMW_NorSpr_Table7E1528
!RAM_SMW_NorSpr029_KoopaKid_MortonRoy_LeftWallXPos = !RAM_SMW_NorSpr_Table7E1534
!RAM_SMW_NorSpr029_KoopaKid_MortonRoyLudwig_PhaseTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSpr029_KoopaKid_Ludwig_JumpRotationTimer = !RAM_SMW_NorSpr_DecrementingTable7E1558
!RAM_SMW_NorSpr029_KoopaKid_MortonRoyLudwig_RotationDirection = !RAM_SMW_NorSpr_Table7E157C
!RAM_SMW_NorSpr029_KoopaKid_MortonRoy_MovementDirection = !RAM_SMW_NorSpr_Table7E1594
!RAM_SMW_NorSpr029_KoopaKid_MortonRoy_RightWallXPos = !RAM_SMW_NorSpr_Table7E160E
!RAM_SMW_NorSpr029_KoopaKid_Ludwig_JumpingXSpeed = !RAM_SMW_NorSpr_Table7E160E
!RAM_SMW_NorSpr029_KoopaKid_MortonRoyLudwig_HitCounter = !RAM_SMW_NorSpr_Table7E1626
!RAM_SMW_NorSpr029_KoopaKid_Ludwig_WaitBeforeShootingFire = !RAM_SMW_NorSpr_DecrementingTable7E163E
!RAM_SMW_NorSpr029_KoopaKid_MortonRoyLudwig_MoveWallsInwardTimer = !RAM_SMW_NorSpr_Table7E164A
!RAM_SMW_NorSpr029_KoopaKid_MortonRoyLudwig_Mode7RoomToLoad = !RAM_SMW_NorSpr_Table7E187B
!RAM_SMW_NorSpr029_KoopaKid_MortonRoyLudwig_DisableMarioContactTimer = !RAM_SMW_NorSpr_DecrementingTable7E1FE2

!RAM_SMW_NorSpr029_KoopaKid_IggyLarry_CopyOfXPosLo = !RAM_SMW_Misc_ScratchRAM7E14B8
!RAM_SMW_NorSpr029_KoopaKid_IggyLarry_CopyOfYPosLo = !RAM_SMW_Misc_ScratchRAM7E14BA
!RAM_SMW_NorSpr029_KoopaKid_IggyLarry_WaitBeforeNextBallThrow = !RAM_SMW_NorSpr_Table7E1534
!RAM_SMW_NorSpr029_KoopaKid_IggyLarry_HurtAnimationTimer = !RAM_SMW_NorSpr_DecrementingTable7E154C
!RAM_SMW_NorSpr029_KoopaKid_IggyLarry_DisablePlayerInteractionTimer = !RAM_SMW_NorSpr_DecrementingTable7E1558
!RAM_SMW_NorSpr029_KoopaKid_IggyLarry_BallThrowAnimationTimer = !RAM_SMW_NorSpr_DecrementingTable7E1564
!RAM_SMW_NorSpr029_KoopaKid_IggyLarry_FellOffPlatformFlag = !RAM_SMW_NorSpr_Table7E160E
!RAM_SMW_NorSpr029_KoopaKid_IggyLarry_SinkingInLavaTimer = !RAM_SMW_NorSpr_DecrementingTable7E163E

!RAM_SMW_NorSpr029_KoopaKid_WendyLemmy_CurrentState = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSpr029_KoopaKid_WendyLemmy_AnimationPointer = !RAM_SMW_NorSpr_Table7E1528
!RAM_SMW_NorSpr029_KoopaKid_WendyLemmy_HitCounter = !RAM_SMW_NorSpr_Table7E1534
!RAM_SMW_NorSpr029_KoopaKid_WendyLemmy_PhaseTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSpr029_KoopaKid_WendyLemmy_DummyFlag = !RAM_SMW_NorSpr_Table7E1570
!RAM_SMW_NorSpr029_KoopaKid_WendyLemmy_SpawnPositionIndex = !RAM_SMW_NorSpr_Table7E160E

;---------------------------------------------------------------------------

!RAM_SMW_NorSprXXX_RegularPiranhaPlant_CurrentState = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSprXXX_RegularPiranhaPlant_PhaseTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSprXXX_RegularPiranhaPlant_PlayerIsCloseFlag = !RAM_SMW_NorSpr_Table7E1594

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr02B_SumoLightning_SpawnFireTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSpr02B_SumoLightning_NumberOfFlamesSpawned = !RAM_SMW_NorSpr_Table7E1570
!RAM_SMW_NorSpr02B_SumoLightning_DisableBlockCollisionTimer = !RAM_SMW_NorSpr_DecrementingTable7E1FE2

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr02C_YoshiEgg_ContentsOfEgg = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSpr02C_YoshiEgg_DontHatchYetFlag = !RAM_SMW_NorSpr_Table7E187B

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr02D_BabyYoshi_SpritesEatenCounter = !RAM_SMW_NorSpr_Table7E1570
!RAM_SMW_NorSpr02D_BabyYoshi_SlotOfSpriteBeingEaten = !RAM_SMW_NorSpr_Table7E160E
!RAM_SMW_NorSpr02D_BabyYoshi_SwallowAnimationTimer = !RAM_SMW_NorSpr_DecrementingTable7E163E

;---------------------------------------------------------------------------

!RAM_SMW_NorSprXXX_WallFollowers_SideOfBlockSpriteIsOn = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSprXXX_WallFollowers_RotationDirection = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSprXXX_WallFollowers_TurnOnCornerTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSprXXX_WallFollowers_BlinkingAnimationTimer = !RAM_SMW_NorSpr_DecrementingTable7E1558

!RAM_SMW_NorSprXXX_Urchins_AnimationFrameCounter = !RAM_SMW_NorSpr_Table7E1528
!RAM_SMW_NorSprXXX_Urchins_AnimationTimer = !RAM_SMW_NorSpr_DecrementingTable7E163E

!RAM_SMW_NorSpr02E_SpikeTop_DiagonalAnimationFrameTimer = !RAM_SMW_NorSpr_DecrementingTable7E1564

!RAM_SMW_NorSpr03A_FixedUrchin_CurrentState = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr03A_FixedUrchin_PhaseTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540

!RAM_SMW_NorSpr03B_WallDetectUrchin_CurrentState = !RAM_SMW_NorSpr03A_FixedUrchin_CurrentState
!RAM_SMW_NorSpr03B_WallDetectUrchin_PhaseTimer = !RAM_SMW_NorSpr03A_FixedUrchin_PhaseTimer

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr02F_PortableSpringboard_AnimationFrameTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr030_ThrowingDryBones_HasCollapsedFlag = !RAM_SMW_NorSpr_Table7E1534
!RAM_SMW_NorSpr030_ThrowingDryBones_CollapsedTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSpr030_ThrowingDryBones_ThrowBonesTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSpr030_ThrowingDryBones_UnusedFreezeTimer = !RAM_SMW_NorSpr_DecrementingTable7E163E

!RAM_SMW_NorSpr031_BonyBeetle_WaitBeforeGoingIntoShell = !RAM_SMW_NorSpr_Table7E1528
!RAM_SMW_NorSpr031_BonyBeetle_HasCollapsedFlag = !RAM_SMW_NorSpr030_ThrowingDryBones_HasCollapsedFlag
!RAM_SMW_NorSpr031_BonyBeetle_HideInShellTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSpr031_BonyBeetle_UnusedFreezeTimer = !RAM_SMW_NorSpr030_ThrowingDryBones_UnusedFreezeTimer

!RAM_SMW_NorSpr032_LedgeDryBones_WalkedOffLedgeFlag = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr032_LedgeDryBones_HasCollapsedFlag = !RAM_SMW_NorSpr030_ThrowingDryBones_HasCollapsedFlag
!RAM_SMW_NorSpr032_LedgeDryBones_CollapsedTimer = !RAM_SMW_NorSpr030_ThrowingDryBones_CollapsedTimer
!RAM_SMW_NorSpr032_LedgeDryBones_ThrowBonesTimer = !RAM_SMW_NorSpr030_ThrowingDryBones_ThrowBonesTimer
!RAM_SMW_NorSpr032_LedgeDryBones_UnusedFreezeTimer = !RAM_SMW_NorSpr030_ThrowingDryBones_UnusedFreezeTimer

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr033_Podoboo_FireballType = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr033_Podoboo_InitialYPosHi = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSpr033_Podoboo_InitialYPosLo = !RAM_SMW_NorSpr_Table7E1528
!RAM_SMW_NorSpr033_Podoboo_WaitBeforeNextJump = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSpr033_Podoboo_BowserFireDespawnTimer = !RAM_SMW_NorSpr_DecrementingTable7E1558
!RAM_SMW_NorSpr033_Podoboo_KeepYSpeedFailsafeTimer = !RAM_SMW_NorSpr_DecrementingTable7E1564
!RAM_SMW_NorSpr033_Podoboo_CopyOfWaitBeforeNextJump = !RAM_SMW_NorSpr_Table7E15D0

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr034_LudwigFireball_WaitBeforeMoving = !RAM_SMW_NorSpr_DecrementingTable7E1540

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr035_Yoshi_CurrentState = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr035_Yoshi_EndingYPosLo = !RAM_SMW_NorSpr_YPosLo
!RAM_SMW_NorSpr035_Yoshi_EndingXPosLo = !RAM_SMW_NorSpr_XPosLo
!RAM_SMW_NorSpr035_Yoshi_EndingYPosHi = !RAM_SMW_NorSpr_YPosHi
!RAM_SMW_NorSpr035_Yoshi_EndingXPosHi = !RAM_SMW_NorSpr_XPosHi
!RAM_SMW_NorSpr035_Yoshi_CurrentTongueLength = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSpr035_Yoshi_SwallowAnimationTimer = !RAM_SMW_NorSpr_DecrementingTable7E1564
!RAM_SMW_NorSpr035_Yoshi_CurrentMouthState = !RAM_SMW_NorSpr_Table7E1594
!RAM_SMW_NorSpr035_Yoshi_EndingOAMIndex = !RAM_SMW_NorSpr_OAMIndex
!RAM_SMW_NorSpr035_Yoshi_YoshiColor = !RAM_SMW_NorSpr_Table7E15F6
!RAM_SMW_NorSpr035_Yoshi_SlotOfSpriteBeingEaten = !RAM_SMW_NorSpr_Table7E160E
!RAM_SMW_NorSpr035_Yoshi_DisableSpriteInteraction = !RAM_SMW_NorSpr_DecrementingTable7E163E
!RAM_SMW_NorSpr035_Yoshi_UnknownRAM = !RAM_SMW_Misc_ScratchRAM7E185E
!RAM_SMW_NorSpr035_Yoshi_DisableWaterSplashTimer = !RAM_SMW_NorSpr_DecrementingTable7E1FE2

;---------------------------------------------------------------------------

!RAM_SMW_NorSprXXX_NonBossBoos_FollowingMarioFlag = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSprXXX_NonBossBoos_WaitBeforeNextFollowCheck = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSprXXX_NonBossBoos_IdleAnimationTimer = !RAM_SMW_NorSpr_DecrementingTable7E1558
!RAM_SMW_NorSprXXX_NonBossBoos_IdleAnimationFrameCounter = !RAM_SMW_NorSpr_Table7E1570

;---------------------------------------------------------------------------

!RAM_SMW_NorSprXXX_Eeries_VerticalMovementDirection = !RAM_SMW_NorSpr_Table7E00C2

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr03D_RipVanFish_CurrentState = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr03D_RipVanFish_SwimmingTimer = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSpr03D_RipVanFish_ZSpawnTimer = !RAM_SMW_NorSpr_Table7E1528

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr03E_PSwitch_Type = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSpr03E_PSwitch_DespawnTimer = !RAM_SMW_NorSpr_DecrementingTable7E163E

;---------------------------------------------------------------------------

!RAM_SMW_NorSprXXX_ParachutingEnemy_SwingDirection = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSprXXX_ParachutingEnemy_FallStraightDownFlag = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSprXXX_ParachutingEnemy_WaitForParachuteToDescend = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSprXXX_ParachutingEnemy_CurrentAngle = !RAM_SMW_NorSpr_Table7E1570
!RAM_SMW_NorSprXXX_ParachutingEnemy_ParachuteAnimationFrame = !RAM_SMW_NorSpr_AnimationFrame
!RAM_SMW_NorSprXXX_ParachutingEnemy_ParachuteYPosOffset = !RAM_SMW_Misc_ScratchRAM7E185E

;---------------------------------------------------------------------------

!RAM_SMW_NorSprXXX_Dolphins_HorizontalMovementDirection = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSprXXX_Dolphins_NoTurnAroundFlag = !RAM_SMW_NorSpr_Table7E151C

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr044_TorpedoTed_ReleaseAnimationTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr045_DirectionalCoins_MovementDirection = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr045_DirectionalCoins_DirectionToTravelNext = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSpr045_DirectionalCoins_AppearBehindLayer1Timer = !RAM_SMW_NorSpr_DecrementingTable7E1540

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr047_SwimmingAndJumpingCheepCheep_CurrentState = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr047_SwimmingAndJumpingCheepCheep_TurnOrJumpTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSpr047_SwimmingAndJumpingCheepCheep_TurnAroundCounter = !RAM_SMW_NorSpr_Table7E1570

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr048_DigginChuckRock_InGroundTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr049_ShiftingPipe_CurrentMovementPhase = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr049_ShiftingPipe_InitialClearTileOffset = !RAM_SMW_NorSpr_Table7E1534
!RAM_SMW_NorSpr049_ShiftingPipe_MovementPhaseTimer = !RAM_SMW_NorSpr_Table7E1570
!RAM_SMW_NorSpr049_ShiftingPipe_LeftMap16Tile = !RAM_SMW_Misc_ScratchRAM7E185E
!RAM_SMW_NorSpr049_ShiftingPipe_RightMap16Tile = !RAM_SMW_Misc_ScratchRAM7E18B6

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr04B_PipeLakitu_CurrentState = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr04B_PipeLakitu_PhaseTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr04C_ExplodingBlock_Contents = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr04C_ExplodingBlock_MusicNoteSpawnTimer = !RAM_SMW_NorSpr03D_RipVanFish_ZSpawnTimer
!RAM_SMW_NorSpr04C_ExplodingBlock_ShakingAnimationFrameCounter = !RAM_SMW_NorSpr_Table7E1570

;---------------------------------------------------------------------------

!RAM_SMW_NorSprXXX_SmallMontyMole_CurrentState = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSprXXX_SmallMontyMole_FollowMarioFlag = !RAM_SMW_NorSpr01E_Lakitu_FishingFlag
!RAM_SMW_NorSprXXX_SmallMontyMole_WaitBeforeJumpingOutOfGround = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSprXXX_SmallMontyMole_WaitBeforeNextHop = !RAM_SMW_NorSpr_DecrementingTable7E1558

;---------------------------------------------------------------------------

!RAM_SMW_NorSprXXX_JumpingPiranhaPlant_CurrentState = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSprXXX_JumpingPiranhaPlant_PropellerAnimationFrameCounter = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSprXXX_JumpingPiranhaPlant_WaitBeforeJumping = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSprXXX_JumpingPiranhaPlant_MouthAnimationFrameCounter = !RAM_SMW_NorSpr_AnimationFrameCounter

!RAM_SMW_NorSpr050_FireSpittingJumpingPiranhaPlant_WaitBeforeFireSpit = !RAM_SMW_NorSpr_DecrementingTable7E1540

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr051_Ninji_JumpCounter = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr051_Ninji_WaitBeforeNextJump = !RAM_SMW_NorSpr_DecrementingTable7E1540

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr052_MovingLedgeHole_ChangeDirectionTimer = !RAM_SMW_NorSpr_Table7E1570 

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr053_ThrowBlock_DespawnTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr054_ClimbingNetDoor_TurningAnimationTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSpr054_ClimbingNetDoor_WaitBeforeTurning = !RAM_SMW_NorSpr_DecrementingTable7E154C

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr055_HorizontalCheckerboardPlatform_PlatformType = !RAM_SMW_NorSpr_Table7E1602

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr057_VerticalCheckerboardPlatform_PlatformType = !RAM_SMW_NorSpr055_HorizontalCheckerboardPlatform_PlatformType

;---------------------------------------------------------------------------

!RAM_SMW_NorSprXXX_TurnBlockBridge_MovementState = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSprXXX_TurnBlockBridge_ExtendDistance = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSprXXX_TurnBlockBridge_WaitBeforeExtending = !RAM_SMW_NorSpr_DecrementingTable7E1540

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr05F_BrownChainedPlatform_PreviousXPos = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr05F_BrownChainedPlatform_XAngleSpeedLo = !RAM_SMW_Misc_ScratchRAM7E14B4
!RAM_SMW_NorSpr05F_BrownChainedPlatform_XAngleSpeedHi = !RAM_SMW_NorSpr05F_BrownChainedPlatform_XAngleSpeedLo+$01
!RAM_SMW_NorSpr05F_BrownChainedPlatform_YAngleSpeedLo = !RAM_SMW_Misc_ScratchRAM7E14B6
!RAM_SMW_NorSpr05F_BrownChainedPlatform_YAngleSpeedHi = !RAM_SMW_NorSpr05F_BrownChainedPlatform_YAngleSpeedLo+$01
!RAM_SMW_NorSpr05F_BrownChainedPlatform_ChainTileXPosLo = !RAM_SMW_Misc_ScratchRAM7E14B8
!RAM_SMW_NorSpr05F_BrownChainedPlatform_ChainTileXPosHi = !RAM_SMW_NorSpr05F_BrownChainedPlatform_ChainTileXPosLo+$01
!RAM_SMW_NorSpr05F_BrownChainedPlatform_ChainTileYPosLo = !RAM_SMW_Misc_ScratchRAM7E14BA
!RAM_SMW_NorSpr05F_BrownChainedPlatform_ChainTileYPosHi = !RAM_SMW_NorSpr05F_BrownChainedPlatform_ChainTileYPosLo+$01
!RAM_SMW_NorSpr05F_BrownChainedPlatform_AngleSpeed = !RAM_SMW_NorSpr_Table7E1504
!RAM_SMW_NorSpr05F_BrownChainedPlatform_SubAngle = !RAM_SMW_NorSpr_Table7E1510
!RAM_SMW_NorSpr05F_BrownChainedPlatform_AngleLo = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSpr05F_BrownChainedPlatform_AngleHi = !RAM_SMW_NorSpr_Table7E1528
!RAM_SMW_NorSpr05F_BrownChainedPlatform_PlayerOnPlatformFlag = !RAM_SMW_NorSpr_Table7E1602
!RAM_SMW_NorSpr05F_BrownChainedPlatform_PlayerIsTouchingPlatformFlag = !RAM_SMW_NorSpr_Table7E160E

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr060_FlatPalaceSwitch_WaitBeforeEraseSwitchObject = !RAM_SMW_NorSpr_DecrementingTable7E1540

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr061_SkullRaft_FirstPlatformFlag = !RAM_SMW_NorSpr_Table7E00C2

;---------------------------------------------------------------------------

!RAM_SMW_NorSprXXX_LineGuidedSprites_CurrentState = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSprXXX_LineGuidedSprites_LineGuideSpeedTableIndexLo = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSprXXX_LineGuidedSprites_LineGuideSpeedTableIndexHi = !RAM_SMW_NorSpr_Table7E1528
!RAM_SMW_NorSprXXX_LineGuidedSprites_LeftLineGuideSpeedTableIndex = !RAM_SMW_NorSpr_Table7E1534
!RAM_SMW_NorSprXXX_LineGuidedSprites_WaitBeforeLatchingOntoLineGuide = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSprXXX_LineGuidedSprites_RightLineGuideSpeedTableIndex = !RAM_SMW_NorSpr_Table7E1570
!RAM_SMW_NorSprXXX_LineGuidedSprites_MovementDirection = !RAM_SMW_NorSpr_Table7E157C
!RAM_SMW_NorSprXXX_LineGuidedSprites_CurrentltTouchedLineGuideTile = !RAM_SMW_NorSpr_Table7E160E
!RAM_SMW_NorSprXXX_LineGuidedSprites_IsNotMovingFlag = !RAM_SMW_NorSpr_Table7E1626
!RAM_SMW_NorSprXXX_LineGuidedSprites_TouchingPlayerFlag = !RAM_SMW_NorSpr_DecrementingTable7E163E
!RAM_SMW_NorSprXXX_LineGuidedSprites_FasterMovementFlag = !RAM_SMW_NorSpr_Table7E187B

!RAM_SMW_NorSpr062_BrownLineGuidePlatform_PlatformType = !RAM_SMW_NorSpr_Table7E1602

!RAM_SMW_NorSpr063_CheckerboardLineGuidePlatform_PlatformType = !RAM_SMW_NorSpr062_BrownLineGuidePlatform_PlatformType

!RAM_SMW_NorSpr064_LineGuideRope_PlayerYPosOffset = !RAM_SMW_Misc_ScratchRAM7E185E
!RAM_SMW_NorSpr064_LineGuideRope_PlayerXPosOffset = !RAM_SMW_Misc_ScratchRAM7E18B6

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr06A_CoinGameCloud_ResetCloudCoinCounter = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr06A_CoinGameCloud_SpawnedCoinCounter = !RAM_SMW_NorSpr_Table7E1570

;---------------------------------------------------------------------------

!RAM_SMW_NorSprXXX_WallSpringboard_CurrentAngle = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSprXXX_WallSpringboard_MaximumAngle = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSprXXX_WallSpringboard_CurrentState = !RAM_SMW_NorSpr_Table7E1528
!RAM_SMW_NorSprXXX_WallSpringboard_CanBounceHigherTimer = !RAM_SMW_NorSpr_Table7E1534
!RAM_SMW_NorSprXXX_WallSpringboard_WaitBeforeAutoBounce = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSprXXX_WallSpringboard_ReboundDirectionCounter = !RAM_SMW_NorSpr_Table7E157C

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr06F_DinoTorch_CurrentState = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr06F_DinoTorch_FireLength = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSpr06F_DinoTorch_BreathFireTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr070_Pokey_Segments = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr070_Pokey_DisconnectedUpperSegments = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSpr070_Pokey_DeadSegmentFlag = !RAM_SMW_NorSpr_Table7E1534
!RAM_SMW_NorSpr070_Pokey_ReconnectBodyTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSpr070_Pokey_DisableSegmentLossTimer = !RAM_SMW_NorSpr_DecrementingTable7E1558
!RAM_SMW_NorSpr070_Pokey_TurnTowardsMarioTimer = !RAM_SMW_NorSpr_Table7E1570
!RAM_SMW_NorSpr070_Pokey_HorizontalMovementDirection = !RAM_SMW_NorSpr_Table7E157C

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr073_GroundSuperKoopa_CurrentState = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr073_GroundSuperKoopa_TakeOffTimer = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSpr073_GroundSuperKoopa_HasFeatherFlag = !RAM_SMW_NorSpr_Table7E1534
!RAM_SMW_NorSpr073_GroundSuperKoopa_AnimationFrame = !RAM_SMW_NorSpr071_RedCapeSuperKoopa_AnimationFrame

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr079_VineHead_AppearBehindLayer1Timer = !RAM_SMW_NorSpr_DecrementingTable7E1540

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr07A_Fireworks_DecelerateTimer = !RAM_SMW_NorSpr_XSpeed
!RAM_SMW_NorSpr07A_Fireworks_CurrentState = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr07A_Fireworks_ExpandingSpeed = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSpr07A_Fireworks_CurrentType = !RAM_SMW_NorSpr_Table7E1534
!RAM_SMW_NorSpr07A_Fireworks_WaitBeforeWhistleSound = !RAM_SMW_NorSpr_DecrementingTable7E1564
!RAM_SMW_NorSpr07A_Fireworks_ColorFlashIndex = !RAM_SMW_NorSpr_DecrementingTable7E1564+$09
!RAM_SMW_NorSpr07A_Fireworks_ExplosionSize = !RAM_SMW_NorSpr_Table7E1570
!RAM_SMW_NorSpr07A_Fireworks_WaitBeforeBangSound = !RAM_SMW_NorSpr_DecrementingTable7E15AC
!RAM_SMW_NorSpr07A_Fireworks_ParticleAnimationSet = !RAM_SMW_NorSpr_Table7E1602

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr07B_GoalTape_HitboxXPosLo = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr07B_GoalTape_HitboxXPosHi = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSpr07B_GoalTape_HitboxYPosLo = !RAM_SMW_NorSpr_Table7E1528
!RAM_SMW_NorSpr07B_GoalTape_HitboxYPosHi = !RAM_SMW_NorSpr_Table7E1534
!RAM_SMW_NorSpr07B_GoalTape_ChangeDirectionTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSpr07B_GoalTape_DisplayStarsTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSpr07B_GoalTape_VerticalDirection = !RAM_SMW_NorSpr_Table7E1588
!RAM_SMW_NorSpr07B_GoalTape_RelativeYPosTapeWasHitAt = !RAM_SMW_NorSpr_Table7E1594
!RAM_SMW_NorSpr07B_GoalTape_GoalCrossedFlag = !RAM_SMW_NorSpr_Table7E1602
!RAM_SMW_NorSpr07B_GoalTape_BrokeTapeFlag = !RAM_SMW_NorSpr_Table7E160E
!RAM_SMW_NorSpr07B_GoalTape_GoalType = !RAM_SMW_NorSpr0A3_GreyChainedPlatform_ChainLength 		;\ LM: LM changes how this address is stored to to allow goal tapes to trigger more secret exits.
													;/ It's normally not dependent on normal sprite 0A3's code (3.00+)

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr07C_PrincessPeach_CurrentState = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr07C_PrincessPeach_LandedOnMarioFlag = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSpr07C_PrincessPeach_FireworksCounter = !RAM_SMW_NorSpr_Table7E1534
!RAM_SMW_NorSpr07C_PrincessPeach_PhaseTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSpr07C_PrincessPeach_WaitBeforeDrawingNextLetter = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSpr07C_PrincessPeach_BlinkTimer = !RAM_SMW_NorSpr_DecrementingTable7E154C
!RAM_SMW_NorSpr07C_PrincessPeach_MarioBlushTimer = !RAM_SMW_NorSpr_DecrementingTable7E1558
!RAM_SMW_NorSpr07C_PrincessPeach_WaitBeforeSpawningFireworks = !RAM_SMW_NorSpr_DecrementingTable7E1564
!RAM_SMW_NorSpr07C_PrincessPeach_SpawnFireworksTimer = !RAM_SMW_NorSpr_DecrementingTable7E1FE2+$09

;---------------------------------------------------------------------------

!RAM_SMW_NorSprXXX_FlyingItems_ItemToDraw = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSprXXX_FlyingItems_VerticalDirection = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSprXXX_FlyingItems_AppearBehindLayer1Timer = !RAM_SMW_NorSpr_DecrementingTable7E1540

;---------------------------------------------------------------------------

!RAM_SMW_NorSprXXX_PowerUps_StayInPlaceFlag = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSprXXX_PowerUps_IsChangingItem = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSprXXX_PowerUps_RisingOutOfSpriteBlockFlag = !RAM_SMW_NorSpr_Table7E1528
!RAM_SMW_NorSprXXX_PowerUps_RisingOutOfBlockTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSprXXX_PowerUps_NoBlockSideInteractionTimer = !RAM_SMW_NorSpr_DecrementingTable7E1558
!RAM_SMW_NorSprXXX_PowerUps_IsBerryFlag = !RAM_SMW_NorSpr_Table7E160E

!RAM_SMW_NorSpr077_Feather_HorizontalMovementDirection  = !RAM_SMW_NorSpr_Table7E1528

!RAM_SMW_NorSpr081_ChangingItem_SpriteChangeCounter = !RAM_SMW_NorSpr_Table7E187B

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr082_BonusGame_AnimationFlag = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr082_BonusGame_HitAnimationTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSpr082_BonusGame_FlashBlockLineTimer = !RAM_SMW_NorSpr_DecrementingTable7E154C
!RAM_SMW_NorSpr082_BonusGame_MovementDirection = !RAM_SMW_NorSpr_Table7E157C

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr083_LeftFlyingBlock_HitFlag = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr083_LeftFlyingBlock_ContentsOfBlock = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSpr083_LeftFlyingBlock_HorizontalDirection = !RAM_SMW_NorSpr_Table7E1534
!RAM_SMW_NorSpr083_LeftFlyingBlock_WaitBeforeTurningAround = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSpr083_LeftFlyingBlock_BounceAnimationTimer = !RAM_SMW_NorSpr_DecrementingTable7E1558
!RAM_SMW_NorSpr083_LeftFlyingBlock_VerticalDirection = !RAM_SMW_NorSpr_Table7E1594
!RAM_SMW_NorSpr083_LeftFlyingBlock_BlockContentsRisingTimer = !RAM_SMW_NorSpr_DecrementingTable7E163E

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr086_Wiggler_IndividualSegmentFacingDirectionFlags = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr086_Wiggler_IsAngryFlag = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSpr086_Wiggler_TurnTowardsMarioWhileAngryTimer = !RAM_SMW_NorSpr_Table7E1534
!RAM_SMW_NorSpr086_Wiggler_StunnedTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSpr086_Wiggler_FlipSegmentsWhenTurningTimer = !RAM_SMW_NorSpr_Table7E1602

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr087_LakituCloud_PlayerInCloudFlag = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr087_LakituCloud_PlayerHasControlledCloudFlag = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSpr087_LakituCloud_VerticalDirection = !RAM_SMW_NorSpr_Table7E1534
!RAM_SMW_NorSpr087_LakituCloud_EvaporateTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSpr087_LakituCloud_LakituSpriteSlot = !RAM_SMW_NorSpr_Table7E160E
!RAM_SMW_NorSpr087_LakituCloud_TempXPosLo = !RAM_SMW_Misc_ScratchRAM7E14B0
!RAM_SMW_NorSpr087_LakituCloud_TempYPosLo = !RAM_SMW_Misc_ScratchRAM7E14B2
!RAM_SMW_NorSpr087_LakituCloud_PlayerInCloudOAMIndex = !RAM_SMW_Misc_ScratchRAM7E18B6

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr089_Layer3Smasher_CurrentState = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr089_Layer3Smasher_PhaseTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr08A_Bird_CurrentState = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr08A_Bird_PeckingTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSpr08A_Bird_ForcedTurnAroundTimer = !RAM_SMW_NorSpr_DecrementingTable7E154C
!RAM_SMW_NorSpr08A_Bird_ActionCounter = !RAM_SMW_NorSpr_Table7E1570

;---------------------------------------------------------------------------

!RAM_SMW_NorSPr08B_FireplaceSmoke_XSpeedFrameCount = !RAM_SMW_NorSpr_Table7E1570
!RAM_SMW_NorSPr08B_FireplaceSmoke_NoHorizontalMovementFlag = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSPr08B_FireplaceSmoke_XDispIndex = !RAM_SMW_NorSpr_Table7E151C

;---------------------------------------------------------------------------

!RAM_SMW_NorSPr08C_SideExitAndFireplace_FrameIndex = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSPr08C_SideExitAndFireplace_UnusedRAM = !RAM_SMW_NorSpr019_DisplayMessage_WaitBeforeDisplayMessage

;---------------------------------------------------------------------------

!RAM_SMW_NorSPr08F_ScalePlatform_RightPlatformXPosLo = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSPr08F_ScalePlatform_InitialYPosHi = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSPr08F_ScalePlatform_InitialYPosLo = !RAM_SMW_NorSpr_Table7E1534
!RAM_SMW_NorSPr08F_ScalePlatform_RightPlatformXPosHi = !RAM_SMW_NorSpr_Table7E1602
!RAM_SMW_NorSPr08F_ScalePlatform_PlayerIsOnSpriteFlag = !RAM_SMW_Misc_ScratchRAM7E185E

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr090_GreenGasBubble_VerticalDirection = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr090_GreenGasBubble_HorizontalMovementDirection = !RAM_SMW_NorSpr_Table7E157C

;---------------------------------------------------------------------------

!RAM_SMW_NorSprXXX_Chucks_CurrentState = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSprXXX_Chucks_HeadAnimationFrame = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSprXXX_Chucks_HitCounter = !RAM_SMW_NorSpr_Table7E1528
!RAM_SMW_NorSprXXX_Chucks_HurtFrameCounter = !RAM_SMW_NorSpr_Table7E1570
!RAM_SMW_NorSprXXX_Chucks_BodyAnimationFrame = !RAM_SMW_NorSpr_Table7E1602

!RAM_SMW_NorSpr046_DigginChuck_DiggingAnimationFrameCounter = !RAM_SMW_NorSpr_Table7E1534
!RAM_SMW_NorSpr046_DigginChuck_DiggingTimer = !RAM_SMW_NorSpr091_CharginChuck_PhaseTimer
!RAM_SMW_NorSpr046_DigginChuck_HeadTurnTimer = !RAM_SMW_NorSpr_DecrementingTable7E1558
!RAM_SMW_NorSpr046_DigginChuck_ShovelAnimationFrame = !RAM_SMW_NorSpr_Table7E1570

!RAM_SMW_NorSpr091_CharginChuck_HeadTurnCounter = !RAM_SMW_NorSpr_Table7E1534
!RAM_SMW_NorSpr091_CharginChuck_PhaseTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSpr091_CharginChuck_HeadAnimationFrameCounter = !RAM_SMW_NorSpr_Table7E1594
!RAM_SMW_NorSpr091_CharginChuck_WaitBeforeChargingTimer = !RAM_SMW_NorSpr_DecrementingTable7E15AC
!RAM_SMW_NorSpr091_CharginChuck_UnusedLineOfSightTimer = !RAM_SMW_NorSpr_DecrementingTable7E163E
!RAM_SMW_NorSpr091_CharginChuck_HasLineOfSightFlag = !RAM_SMW_NorSpr_Table7E187B

!RAM_SMW_NorSpr092_SplittinChuck_WaitBeforeSplittin = !RAM_SMW_NorSpr091_CharginChuck_PhaseTimer
!RAM_SMW_NorSpr092_SplittinChuck_SpawnChuckIndex = !RAM_SMW_Misc_ScratchRAM7E185E

!RAM_SMW_NorSpr093_BouncinChuck_WaitBeforeSplittin = !RAM_SMW_NorSpr091_CharginChuck_PhaseTimer

!RAM_SMW_NorSpr095_ClappinChuck_WaitBeforeJumpsOrHops = !RAM_SMW_NorSpr091_CharginChuck_PhaseTimer
!RAM_SMW_NorSpr095_ClappinChuck_JumpingFlag = !RAM_SMW_NorSpr_Table7E160E
!RAM_SMW_NorSpr095_ClappinChuck_WaitBeforeClapSound = !RAM_SMW_NorSpr_DecrementingTable7E1FE2

!RAM_SMW_NorSpr098_PitchinChuck_JumpingFlag = !RAM_SMW_NorSpr_Table7E1534
!RAM_SMW_NorSpr098_PitchinChuck_PhaseTimer = !RAM_SMW_NorSpr091_CharginChuck_PhaseTimer
!RAM_SMW_NorSpr098_PitchinChuck_WaitBeforeThrowingNextBaseball = !RAM_SMW_NorSpr_DecrementingTable7E1558
!RAM_SMW_NorSpr098_PitchinChuck_BaseballThrowSetIndex = !RAM_SMW_NorSpr_Table7E187B

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr099_VolcanoLotus_CurrentState = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr099_VolcanoLotus_FlashingPaletteFlag = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSpr099_VolcanoLotus_PhaseTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr09A_SumoBro_CurrentState = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr09A_SumoBro_PhaseTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSpr09A_SumoBro_WaitBeforeNextStep = !RAM_SMW_NorSpr_DecrementingTable7E1558
!RAM_SMW_NorSpr09A_SumoBro_StepsTaken = !RAM_SMW_NorSpr_Table7E1570

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr09B_HammerBro_WaitBeforeThowingNextHammer = !RAM_SMW_NorSpr_DecrementingTable7E1540

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr09C_HammerBroPlatform_HitFlag = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr09C_HammerBroPlatform_VerticalDirection = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSpr09C_HammerBroPlatform_HorizontalDirection = !RAM_SMW_NorSpr_Table7E1534
!RAM_SMW_NorSpr09C_HammerBroPlatform_BounceAnimationTimer = !RAM_SMW_NorSpr_DecrementingTable7E1558
!RAM_SMW_NorSpr09C_HammerBroPlatform_HammerBroOnPlatformSpriteSlot = !RAM_SMW_NorSpr_Table7E1594

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr09D_BubbleWithSprite_Contents = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr09D_BubbleWithSprite_VerticalDirection = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSpr09D_BubbleWithSprite_TimerUntilPopping = !RAM_SMW_NorSpr_Table7E1534
!RAM_SMW_NorSpr09D_BubbleWithSprite_HorizontalDirection = !RAM_SMW_NorSpr_Table7E157C

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr09E_BallNChain_UnknownClusterSpriteRAM = !RAM_SMW_NorSpr0A3_GreyChainedPlatform_UnknownClusterSpriteRAM
!RAM_SMW_NorSpr09E_BallNChain_CurrentAngleHi = !RAM_SMW_NorSpr0A3_GreyChainedPlatform_CurrentAngleHi
!RAM_SMW_NorSpr09E_BallNChain_PreviousXPos = !RAM_SMW_NorSpr0A3_GreyChainedPlatform_PreviousXPos
!RAM_SMW_NorSpr09E_BallNChain_CurrentAngleLo = !RAM_SMW_NorSpr0A3_GreyChainedPlatform_CurrentAngleLo
!RAM_SMW_NorSpr09E_BallNChain_ChainLength = !RAM_SMW_NorSpr0A3_GreyChainedPlatform_ChainLength

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr0A0_ActivateBowserBattle_WaitBeforeNextAttack = !RAM_SMW_Misc_ScratchRAM7E14B0
!RAM_SMW_NorSpr0A0_ActivateBowserBattle_WaitBeforeMechaKoopaThrow = !RAM_SMW_Misc_ScratchRAM7E14B1
!RAM_SMW_NorSpr0A0_ActivateBowserBattle_ScalingDirection = !RAM_SMW_Misc_ScratchRAM7E14B2
!RAM_SMW_NorSpr0A0_ActivateBowserBattle_TearDropYDispIndex = !RAM_SMW_Misc_ScratchRAM7E14B3
!RAM_SMW_NorSpr0A0_ActivateBowserBattle_SongToPlayIndex = !RAM_SMW_Misc_ScratchRAM7E14B4
!RAM_SMW_NorSpr0A0_ActivateBowserBattle_HurtStateTimer = !RAM_SMW_Misc_ScratchRAM7E14B5
!RAM_SMW_NorSpr0A0_ActivateBowserBattle_WaitBeforeBowlingBallDrop = !RAM_SMW_Misc_ScratchRAM7E14B6
!RAM_SMW_NorSpr0A0_ActivateBowserBattle_FireballInitialXPosLo = !RAM_SMW_Misc_ScratchRAM7E14B7
!RAM_SMW_NorSpr0A0_ActivateBowserBattle_Phase2AttackCounter = !RAM_SMW_Misc_ScratchRAM7E14B8
!RAM_SMW_NorSpr0A0_ActivateBowserBattle_CurrentState = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSpr0A0_ActivateBowserBattle_HorizontalAccelerationDirection = !RAM_SMW_NorSpr_Table7E1528
!RAM_SMW_NorSpr0A0_ActivateBowserBattle_VerticalAccelerationDirection = !RAM_SMW_NorSpr_Table7E1534
!RAM_SMW_NorSpr0A0_ActivateBowserBattle_DuckingAnimationTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSpr0A0_ActivateBowserBattle_WaitBeforeTurningUpsideDown = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSpr0A0_ActivateBowserBattle_DisableMarioContactTimer = !RAM_SMW_NorSpr_DecrementingTable7E154C
!RAM_SMW_NorSpr0A0_ActivateBowserBattle_WaitBeforeAttackPhase1 = !RAM_SMW_NorSpr_DecrementingTable7E154C
!RAM_SMW_NorSpr0A0_ActivateBowserBattle_WaitBeforeSpawningPeach = !RAM_SMW_NorSpr_DecrementingTable7E154C
!RAM_SMW_NorSpr0A0_ActivateBowserBattle_ClownCarBlinkAnimationTimer = !RAM_SMW_NorSpr_DecrementingTable7E1558
!RAM_SMW_NorSpr0A0_ActivateBowserBattle_SmokePuffTimer = !RAM_SMW_NorSpr_DecrementingTable7E1564
!RAM_SMW_NorSpr0A0_ActivateBowserBattle_BowserAnimationFrame = !RAM_SMW_NorSpr_Table7E1570
!RAM_SMW_NorSpr0A0_ActivateBowserBattle_FacingFirection = !RAM_SMW_NorSpr_Table7E157C
!RAM_SMW_NorSpr0A0_ActivateBowserBattle_HelpAnimationTimer = !RAM_SMW_NorSpr_Table7E1594
!RAM_SMW_NorSpr0A0_ActivateBowserBattle_PeachKissMusicIsPlaying = !RAM_SMW_NorSpr_Table7E164A
!RAM_SMW_NorSpr0A0_ActivateBowserBattle_HPForCurrentPhase = !RAM_SMW_NorSpr_Table7E187B

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr0A2_MechaKoopa_WaitBeforeTurningAround = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr0A2_MechaKoopa_StunTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr0A3_GreyChainedPlatform_UnknownClusterSpriteRAM = !RAM_SMW_ClusterSpr_Table7E0F86
!RAM_SMW_NorSpr0A3_GreyChainedPlatform_CurrentAngleHi = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSpr0A3_GreyChainedPlatform_PreviousXPos = !RAM_SMW_NorSpr_Table7E1534
!RAM_SMW_NorSpr0A3_GreyChainedPlatform_CurrentAngleLo = !RAM_SMW_NorSpr_Table7E1602
!RAM_SMW_NorSpr0A3_GreyChainedPlatform_PlayerOnPlatformFlag = !RAM_SMW_NorSpr_Table7E160E
!RAM_SMW_NorSpr0A3_GreyChainedPlatform_ChainLength = !RAM_SMW_NorSpr_Table7E187B

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr0A7_IggyBall_HorizontalMovementDirection = !RAM_SMW_NorSpr_Table7E157C

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr0A8_Blargg_CurrentState = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr0A8_Blargg_InitialXPosHi = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSpr0A8_Blargg_InitialXPosLo = !RAM_SMW_NorSpr_Table7E1528
!RAM_SMW_NorSpr0A8_Blargg_InitialYPosHi = !RAM_SMW_NorSpr_Table7E1534
!RAM_SMW_NorSpr0A8_Blargg_PhaseTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSpr0A8_Blargg_InitialYPosLo = !RAM_SMW_NorSpr_Table7E1594
!RAM_SMW_NorSpr0A8_Blargg_AttackingAnimationFrame = !RAM_SMW_NorSpr_AnimationFrame

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr0A9_Reznor_SpriteGFXToLoad = !RAM_SMW_NorSprXXX_CurrentlyActiveBoss
!RAM_SMW_NorSpr0A9_Reznor_IsDeadFlag = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSpr0A9_Reznor_FiringAnimationTimer = !RAM_SMW_NorSpr_DecrementingTable7E1558
!RAM_SMW_NorSpr0A9_Reznor_PlatformBounceTimer = !RAM_SMW_NorSpr_DecrementingTable7E1564
!RAM_SMW_NorSpr0A9_Reznor_WaitBeforeShootingFire = !RAM_SMW_NorSpr_Table7E1570
!RAM_SMW_NorSpr0A9_Reznor_WaitBeforeEndingLevel = !RAM_SMW_NorSpr_DecrementingTable7E163E

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr0AA_Fishbone_CurrentState = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr0AA_Fishbone_PhaseTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSpr0AA_Fishbone_BlinkAnimationTimer = !RAM_SMW_NorSpr_DecrementingTable7E1558

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr0AB_Rex_StompCounter = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr0AB_Rex_ShowSquishedStateTimer = !RAM_SMW_NorSpr_DecrementingTable7E1558
!RAM_SMW_NorSpr0AB_Rex_DisableCapeAndBounceSpriteContactTimer = !RAM_SMW_NorSpr_Table7E15D0
!RAM_SMW_NorSpr0AB_Rex_WaitAfterFirstStomp = !RAM_SMW_NorSpr_DecrementingTable7E1FE2

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr0AC_DownFirstWoodenSpike_CurrentState = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr0AC_DownFirstWoodenSpike_InitialMovementDirection = !RAM_SMW_NorSpr01E_Lakitu_FishingFlag
!RAM_SMW_NorSpr0AC_DownFirstWoodenSpike_WaitBeforeNextPhase = !RAM_SMW_NorSpr_DecrementingTable7E1540

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr0AE_FishinBoo_VerticalDirection = !RAM_SMW_NorSpr_Table7E00C2

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr0B1_CreateEatBlock_BlockType = !RAM_SMW_NorSpr01E_Lakitu_FishingFlag
!RAM_SMW_NorSpr0B1_CreateEatBlock_CreatePathIndex = !RAM_SMW_NorSpr_Table7E1534
!RAM_SMW_NorSpr0B1_CreateEatBlock_TilesRemainingInCurrentDirection = !RAM_SMW_NorSpr_Table7E1570
!RAM_SMW_NorSpr0B1_CreateEatBlock_MovementDirection = !RAM_SMW_NorSpr_Table7E157C
!RAM_SMW_NorSpr0B1_CreateEatBlock_CurrentMovementData = !RAM_SMW_NorSpr_Table7E1602

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr0B2_FallingSpike_CurrentState = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr0B2_FallingSpike_ShakingTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr0B7_CarrotTopLiftUpperRight_MovementTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr0B9_MessageBox_HitFlag = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr0B9_MessageBox_BounceAnimationTimer = !RAM_SMW_NorSpr_DecrementingTable7E1558
!RAM_SMW_NorSpr0B9_MessageBox_UnusedBounceAnimationTimer = !RAM_SMW_NorSpr_DecrementingTable7E1564

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr0BA_TimedPlatform_ActivatedFlag = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr0BA_TimedPlatform_ClockTimer = !RAM_SMW_NorSpr_Table7E1570

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr0BB_MovingCastleStone_MovementPhase = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr0BB_MovingCastleStone_MovementTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr0BC_BowserStatue_StatueType = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr0BC_BowserStatue_WaitBeforeJumping = !RAM_SMW_NorSpr_DecrementingTable7E1540

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr0BD_SlidingNakedBlueKoopa_WaitBeforeFalling = !RAM_SMW_NorSpr09A_SumoBro_PhaseTimer
!RAM_SMW_NorSpr0BD_SlidingNakedBlueKoopa_WaitBeforeTurningIntoKoopa = !RAM_SMW_NorSpr_DecrementingTable7E1558

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr0BE_Swooper_CurrentState = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr0BE_Swooper_VerticalDirection = !RAM_SMW_NorSpr_Table7E151C

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr0BF_MegaMole_FacingDirection = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSpr0BF_MegaMole_WaitBeforeFalling  = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSpr0BF_MegaMole_MovementDirection = !RAM_SMW_NorSpr_Table7E157C

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr0C0_SinkingLavaPlatform_DespawnTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr0C1_WingedPlatform_FlyDownInitiallyFlag = !RAM_SMW_NorSpr01E_Lakitu_FishingFlag
!RAM_SMW_NorSpr0C1_WingedPlatform_VerticalMovementTimerHi = !RAM_SMW_NorSpr_Table7E1534
!RAM_SMW_NorSpr0C1_WingedPlatform_VerticalDirection = !RAM_SMW_NorSpr_Table7E157C
!RAM_SMW_NorSpr0C1_WingedPlatform_VerticalMovementTimerLo = !RAM_SMW_NorSpr_Table7E1602

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr0C2_Blurp_VerticalDirection = !RAM_SMW_NorSpr_Table7E00C2

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr0C4_GreyFallingPlatform_WaitBeforeFall = !RAM_SMW_NorSpr_DecrementingTable7E1540

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr0C5_BigBooBoss_CurrentState = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr0C5_BigBooBoss_HorizontalDirection = !RAM_SMW_NorSpr_Table7E151C
!RAM_SMW_NorSpr0C5_BigBooBoss_VerticalDirection = !RAM_SMW_NorSpr_Table7E1528
!RAM_SMW_NorSpr0C5_BigBooBoss_HitCounter = !RAM_SMW_NorSpr_Table7E1534
!RAM_SMW_NorSpr0C5_BigBooBoss_PhaseTimer = !RAM_SMW_NorSpr_DecrementingTable7E1540
!RAM_SMW_NorSpr0C5_BigBooBoss_UnusedPeekingTimer = !RAM_SMW_NorSprXXX_NonBossBoos_IdleAnimationTimer
!RAM_SMW_NorSpr0C5_BigBooBoss_FadeInFrameCounter = !RAM_SMW_NorSpr_AnimationFrameCounter

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr0C6_Spotlight_OnFlag = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr0C6_Spotlight_DeleteOtherSpotlightsFlag = !RAM_SMW_NorSpr_Table7E1534

;---------------------------------------------------------------------------

!RAM_SMW_NorSpr0C8_LightSwitch_HitFlag = !RAM_SMW_NorSpr_Table7E00C2
!RAM_SMW_NorSpr0C8_LightSwitch_BounceAnimationTimer = !RAM_SMW_NorSpr_DecrementingTable7E1558
!RAM_SMW_NorSpr0C8_LightSwitch_UnusedBounceAnimationTimer = !RAM_SMW_NorSpr_DecrementingTable7E1564

;---------------------------------------------------------------------------

!RAM_SMW_ExtSpr01_SmokePuff_DespawnTimer = !RAM_SMW_ExtSpr_DecrementingTable7E176F

;---------------------------------------------------------------------------

!RAM_SMW_ExtSpr03_FlameRemnant_AnimationFrameCounter = !RAM_SMW_ExtSpr_Table7E1765
!RAM_SMW_ExtSpr03_FlameRemnant_DespawnTimer = !RAM_SMW_ExtSpr_DecrementingTable7E176F

;---------------------------------------------------------------------------

!RAM_SMW_ExtSpr04_Hammer_AnimationFrameCounter = !RAM_SMW_ExtSpr_Table7E1765

;---------------------------------------------------------------------------

!RAM_SMW_ExtSpr05_MarioFireball_CurrentLayerPriority = !RAM_SMW_ExtSpr_Table7E1779

;---------------------------------------------------------------------------

!RAM_SMW_ExtSpr06_ThrownBone_UnknownRAM7E1765 = !RAM_SMW_ExtSpr_Table7E1765

;---------------------------------------------------------------------------

!RAM_SMW_ExtSpr07_LavaSplash_AnimationFrameCounter = !RAM_SMW_ExtSpr_DecrementingTable7E176F

;---------------------------------------------------------------------------

!RAM_SMW_ExtSpr08_LauncherArm_VerticalDirectionTimer = !RAM_SMW_ExtSpr_DecrementingTable7E176F

;---------------------------------------------------------------------------

!RAM_SMW_ExtSpr0A_CloudCoin_DisableBlockCollisionFlag = !RAM_SMW_ExtSpr_Table7E1765

!RAM_SMW_ExtSpr0E_WigglerFlower_DisableBlockCollisionFlag = !RAM_SMW_ExtSpr0A_CloudCoin_DisableBlockCollisionFlag

;---------------------------------------------------------------------------

!RAM_SMW_ExtSpr0F_SmokeTrail_DespawnTimer = !RAM_SMW_ExtSpr_DecrementingTable7E176F

;---------------------------------------------------------------------------

!RAM_SMW_ExtSpr10_SpinJumpStars_DespawnTimer = !RAM_SMW_ExtSpr_DecrementingTable7E176F

;---------------------------------------------------------------------------

!RAM_SMW_ExtSpr11_YoshiFireball_CurrentLayerPriority = !RAM_SMW_ExtSpr05_MarioFireball_CurrentLayerPriority

;---------------------------------------------------------------------------

!RAM_SMW_ExtSpr12_BreathBubble_AnimationFrameCounter = !RAM_SMW_ExtSpr_Table7E1765

;---------------------------------------------------------------------------

!RAM_SMW_ClusterSpr01_1up_YSpeed = !RAM_SMW_ClusterSpr_Table7E1E52
!RAM_SMW_ClusterSpr01_1up_XSpeed = !RAM_SMW_ClusterSpr_Table7E1E66
!RAM_SMW_ClusterSpr01_1up_SubXPos = !RAM_SMW_ClusterSpr_Table7E1E7A

;---------------------------------------------------------------------------

!RAM_SMW_ClusterSpr03_BooCeiling_UnknownTable7E0F4A = !RAM_SMW_ClusterSpr_Table7E0F4A
!RAM_SMW_ClusterSpr03_BooCeiling_UnknownTable7E0F72 = !RAM_SMW_ClusterSpr_Table7E0F72
!RAM_SMW_ClusterSpr03_BooCeiling_UnknownTable7E0F86 = !RAM_SMW_ClusterSpr_Table7E0F86
!RAM_SMW_ClusterSpr03_BooCeiling_UnknownTable7E0F9A = !RAM_SMW_ClusterSpr_Table7E0F9A
!RAM_SMW_ClusterSpr03_BooCeiling_UnknownRAM = !RAM_SMW_ClusterSpr04_BooRing_RingIndex
!RAM_SMW_ClusterSpr03_BooCeiling_UnknownTable7E1E52 = !RAM_SMW_ClusterSpr_Table7E1E52
!RAM_SMW_ClusterSpr03_BooCeiling_UnknownTable7E1E66 = !RAM_SMW_ClusterSpr_Table7E1E66

!RAM_SMW_ClusterSpr08_DeathBatCeiling_UnknownTable7E0F4A = !RAM_SMW_ClusterSpr03_BooCeiling_UnknownTable7E0F4A
!RAM_SMW_ClusterSpr08_DeathBatCeiling_UnknownTable7E0F72 = !RAM_SMW_ClusterSpr03_BooCeiling_UnknownTable7E0F72
!RAM_SMW_ClusterSpr08_DeathBatCeiling_UnknownTable7E0F86 = !RAM_SMW_ClusterSpr03_BooCeiling_UnknownTable7E0F86
!RAM_SMW_ClusterSpr08_DeathBatCeiling_UnknownTable7E0F9A = !RAM_SMW_ClusterSpr03_BooCeiling_UnknownTable7E0F9A
!RAM_SMW_ClusterSpr08_DeathBatCeiling_UnknownTable7E1E52 = !RAM_SMW_ClusterSpr03_BooCeiling_UnknownTable7E1E52
!RAM_SMW_ClusterSpr08_DeathBatCeiling_UnknownTable7E1E66 = !RAM_SMW_ClusterSpr03_BooCeiling_UnknownTable7E1E66

;---------------------------------------------------------------------------

!RAM_SMW_ClusterSpr04_BooRing_UnknownTable7E0F4A = !RAM_SMW_ClusterSpr_Table7E0F4A
!RAM_SMW_ClusterSpr04_BooRing_UnknownTable7E0F72 = !RAM_SMW_ClusterSpr_Table7E0F72
!RAM_SMW_ClusterSpr04_BooRing_UnknownTable7E0F86 = !RAM_SMW_ClusterSpr_Table7E0F86
!RAM_SMW_ClusterSpr04_BooRing_UnknownTable7E1E66 = !RAM_SMW_ClusterSpr_Table7E1E66

;---------------------------------------------------------------------------

!RAM_SMW_ClusterSpr05_CandleFlame_UnknownTable7E0F4A = !RAM_SMW_ClusterSpr_Table7E0F4A

;---------------------------------------------------------------------------

!RAM_SMW_ClusterSpr06_SumoBroFlame_DespawnTimer = !RAM_SMW_ClusterSpr_Table7E0F4A

;---------------------------------------------------------------------------

!RAM_SMW_ClusterSpr07_ReappearingBoo_BooSet = !RAM_SMW_ClusterSpr04_BooRing_RingIndex
!RAM_SMW_ClusterSpr07_ReappearingBoo_UnknownTable7E1E52 = !RAM_SMW_ClusterSpr_Table7E1E52
!RAM_SMW_ClusterSpr07_ReappearingBoo_UnknownTable7E1E66 = !RAM_SMW_ClusterSpr_Table7E1E66
!RAM_SMW_ClusterSpr07_ReappearingBoo_UnknownTable7E1E7A = !RAM_SMW_ClusterSpr_Table7E1E7A
!RAM_SMW_ClusterSpr07_ReappearingBoo_UnknownTable7E1E8E = !RAM_SMW_ClusterSpr_Table7E1E8E

;---------------------------------------------------------------------------

!RAM_SMW_OWSpr01_Lakitu_UnknownTable7E0DF5 = !RAM_SMW_OWSpr_Table7E0DF5
!RAM_SMW_OWSpr01_Lakitu_UnknownTable7E0E05 = !RAM_SMW_OWSpr_Table7E0E05
!RAM_SMW_OWSpr01_Lakitu_UnknownTable7E0E15 = !RAM_SMW_OWSpr_Table7E0E15

;---------------------------------------------------------------------------

!RAM_SMW_OWSpr03_CheepCheep_UnknownTable7E0DF5 = !RAM_SMW_OWSpr_Table7E0DF5
!RAM_SMW_OWSpr03_CheepCheep_UnknownTable7E0E25 = !RAM_SMW_OWSpr_Table7E0E25

;---------------------------------------------------------------------------

!RAM_SMW_OWSpr06_KoopaKid_UnknownTable7E0DF5 = !RAM_SMW_OWSpr_Table7E0DF5
!RAM_SMW_OWSpr06_KoopaKid_UnknownTable7E0E05 = !RAM_SMW_OWSpr_Table7E0E05
!RAM_SMW_OWSpr06_KoopaKid_UnknownTable7E0E25 = !RAM_SMW_OWSpr_Table7E0E25

;---------------------------------------------------------------------------

!RAM_SMW_OWSpr09_Bowser_UnknownTable7E0DF5 = !RAM_SMW_OWSpr_Table7E0DF5
!RAM_SMW_OWSpr09_Bowser_UnknownTable7E0E05 = !RAM_SMW_OWSpr_Table7E0E05
!RAM_SMW_OWSpr09_Bowser_UnknownTable7E0E15 = !RAM_SMW_OWSpr_Table7E0E15

;---------------------------------------------------------------------------

!RAM_SMW_OWSpr0A_Boo_UnknownTable7E0DF5 = !RAM_SMW_OWSpr_Table7E0DF5
!RAM_SMW_OWSpr0A_Boo_UnknownTable7E0E25 = !RAM_SMW_OWSpr_Table7E0E25

;---------------------------------------------------------------------------