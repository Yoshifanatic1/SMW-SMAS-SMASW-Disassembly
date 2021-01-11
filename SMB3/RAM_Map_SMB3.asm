; RAM Define tags:
;!A_B_C_D_E
; A = RAM type (ex. RAM, ARAM, VRAM, OAM, SRAM, IRAM, BWRAM, etc)
; B = GameID (ex. SMB3)
; C = Game mode RAM for general context of where the RAM is used (ex. Level)
; D = Optional sub tag for further context (ex. Player)
; E = RAM address's function
;
; Game Mode tags:
; "Level" = RAM address associated with a level function
; "Overworld" = RAM address associated with the overworld.
; "PeachRescued" = RAM address associated with the first part of the ending.
; "WorldRollcall" = RAM address associated with the second part of the ending.
; "TitleScreen" = RAM address associated with the title screen
; "ErrorScreen", "SplashScreen", "SpadeGame", "SlidingPictureGame", "CardFlipGame" = Used on that specific screen.
; "BattleMode" = Used in the battle mode accessed from the title screen
; "2PDuel" = Used in the battle mode accessed from the overworld in a 2 player game.
; "Global" = Used anywhere or close to everywhere.
;
; Sub tags (optional)
; "Player" = RAM address associated with the player sprite in levels.
; "NorSpr" = RAM address associated with normal sprites.
; "NorSprZZ_Y" = RAM address associated with normal sprite Y of ID ZZ. Can also refer to a group of sprites if ZZ is XX.
; "GenSpr" = RAM address associated with a generator sprite.
; "ExtSpr" = RAM address associated with an extended sprite.
; "ScrollSpr" = RAM address associated with a scroll sprite.
; "ShooterSpr" = RAM address associated with a shooter sprite.
; "BattleNorSpr" = RAM address associated with a battle mode normal sprite
; "BattleSmokeSpr" = RAM address associated with a battle mode smoke sprite
; "BattleBounceSpr" = RAM address associated with a battle mode bounce sprite
; "OWSpr" = RAM address associated with an overworld sprite
; "BreathSpr" = RAM address associated with breath sprites
; "SplashSpr" = RAM address associated with splash sprites
; "MExtSpr" = RAM address associated with minor extended sprites
; "FireSpr" = RAM address associated with player fireball sprites

!RAM_SMB3_Global_ScratchRAM00 = $000000
!RAM_SMB3_Global_ScratchRAM01 = $000001
!RAM_SMB3_Global_ScratchRAM02 = $000002
!RAM_SMB3_Global_ScratchRAM03 = $000003
!RAM_SMB3_Global_ScratchRAM04 = $000004
!RAM_SMB3_Global_ScratchRAM05 = $000005
!RAM_SMB3_Global_ScratchRAM06 = $000006
!RAM_SMB3_Global_ScratchRAM07 = $000007
!RAM_SMB3_Global_ScratchRAM08 = $000008
!RAM_SMB3_Global_ScratchRAM09 = $000009
!RAM_SMB3_Global_ScratchRAM0A = $00000A
!RAM_SMB3_Global_ScratchRAM0B = $00000B
!RAM_SMB3_Global_ScratchRAM0C = $00000C
!RAM_SMB3_Global_ScratchRAM0D = $00000D
!RAM_SMB3_Global_ScratchRAM0E = $00000E
!RAM_SMB3_Global_ScratchRAM0F = $00000F
; $000014 = Flag to fade out and end level.
!RAM_SMB3_Global_FrameCounter = $000015
!RAM_SMB3_Global_ScreenDisplayRegisterMirror = $000016
!RAM_SMB3_Global_ControllerHold1 = $000017
!RAM_SMB3_Global_ControllerPress1 = $000018

; $00001B = Index used for animating the pipe munchers

!RAM_SMB3_Overworld_Load2PlayerBattleFlag = $00001D
!RAM_SMB3_Overworld_OWSprIDBeingEntered = $00001E

!RAM_SMB3_Level_ScreensInLvl = $000022
; $000023 = Max number of overworld screens?
; $000024 = Overworld screen position index
; $000025 = Overworld scroll direction?
!RAM_SMB3_Level_LevelDataPtrLo = $00002B
	!RAM_SMB3_Level_BGDataPtrLo = $00002B
!RAM_SMB3_Level_LevelDataPtrHi = !RAM_SMB3_Level_LevelDataPtrLo+$01
	!RAM_SMB3_Level_BGDataPtrHi = !RAM_SMB3_Level_BGDataPtrLo+$01
!RAM_SMB3_Level_LevelDataPtrBank = !RAM_SMB3_Level_LevelDataPtrLo+$02
	!RAM_SMB3_Level_BGDataPtrBank = !RAM_SMB3_Level_BGDataPtrLo+$02
; $00002E = Pointer to level map16 data, low byte
; $00002E = Pointer to spade level text?
!RAM_SMB3_Level_SpriteDataPtrLo = $000031
!RAM_SMB3_Level_SpriteDataPtrHi = !RAM_SMB3_Level_SpriteDataPtrLo+$01
!RAM_SMB3_Level_SpriteDataPtrBank = !RAM_SMB3_Level_SpriteDataPtrLo+$02

!RAM_SMB3_Global_StripeImageDataLo = $000036
!RAM_SMB3_Global_StripeImageDataHi = !RAM_SMB3_Global_StripeImageDataLo+$01
!RAM_SMB3_Global_StripeImageDataBank = !RAM_SMB3_Global_StripeImageDataLo+$02

!RAM_SMB3_Global_CurrentlyProcessedMap16TileLo = $0000B3

; $000043-$0000F1
;--------------------------------------------------------------------

; Level:
!RAM_SMB3_Level_Player_XPosHi = $000043
!RAM_SMB3_Level_NorSpr_XPosHi = $000044
!RAM_SMB3_Level_NorSpr_Table7E004D = $00004D
!RAM_SMB3_Level_Player_YPosHi = $000055
!RAM_SMB3_Level_NorSpr_YPosHi = $000056
!RAM_SMB3_Level_Player_XPosLo = $00005E
!RAM_SMB3_Level_NorSpr_XPosLo = $00005F
!RAM_SMB3_Level_NorSpr_Table7E0068 = $000068
!RAM_SMB3_Level_Player_YPosLo = $000070
!RAM_SMB3_Level_NorSpr_YPosLo = $000071
!RAM_SMB3_Level_Player_OnScreenXPos = $000079
!RAM_SMB3_Level_NorSpr_OnScreenXPos = $00007A
!RAM_SMB3_Level_Player_OnScreenYPos = $000082
!RAM_SMB3_Level_NorSpr_OnScreenYPos = $000083
!RAM_SMB3_Level_Player_XSpeed = $00008B
!RAM_SMB3_Level_NorSpr_XSpeed = $00008C
!RAM_SMB3_Level_Player_YSpeed = $00009D
!RAM_SMB3_Level_NorSpr_YSpeed = !RAM_SMB3_Level_NorSpr_XSpeed+$12								; $00009E
; $0000A6 = Player tile collision flags
; $0000A7 = Normal sprite tile collision flags
; $0000BA = Some sort of animation timer for the player. Related to walking.
!RAM_SMB3_Level_Player_CurrentPowerUp = $0000BB
!RAM_SMB3_Level_Player_CurrentPose = $0000BC
!RAM_SMB3_Level_Player_FacingDirection = $0000BD					; Todo: This might have other uses.

!RAM_SMB3_Level_Player_DeathState = $0000BF
; $0000D8 = Pointer to level map16 data, high byte?

!RAM_SMB3_Level_MExtSpr_Table7E00DF = $0000DF
!RAM_SMB3_Level_ExtSpr_XPosHi = $0000E2

!RAM_SMB3_Level_SplashSpr_XPosHi = $0000EF

; Overworld:
!RAM_SMB3_Overworld_Mario_YPosLo = $000043
!RAM_SMB3_Overworld_Luigi_YPosLo = !RAM_SMB3_Overworld_Mario_YPosLo+$01
!RAM_SMB3_Overworld_Mario_XPosHi = $000045
!RAM_SMB3_Overworld_Luigi_XPosHi = !RAM_SMB3_Overworld_Mario_XPosHi+$01
!RAM_SMB3_Overworld_Mario_XPosLo = $000047
!RAM_SMB3_Overworld_Luigi_XPosLo = !RAM_SMB3_Overworld_Mario_XPosLo+$01
!RAM_SMB3_Overworld_Mario_MovementTimer = $000049
!RAM_SMB3_Overworld_Luigi_MovementTimer = !RAM_SMB3_Overworld_Mario_MovementTimer+$01
!RAM_SMB3_Overworld_Mario_MovementDirection = $00004B
!RAM_SMB3_Overworld_Luigi_MovementDirection = !RAM_SMB3_Overworld_Mario_MovementDirection+$01
!RAM_SMB3_Overworld_Mario_UnusedRAM1 = $00004D
!RAM_SMB3_Overworld_Luigi_UnusedRAM1 = !RAM_SMB3_Overworld_Mario_UnusedRAM1+$01

!RAM_SMB3_Overworld_Mario_UnusedRAM2 = $000052
!RAM_SMB3_Overworld_Luigi_UnusedRAM2 = !RAM_SMB3_Overworld_Mario_UnusedRAM2+$01

!RAM_SMB3_Overworld_CurrentWarpWhistleState = $000059
	!RAM_SMB3_Overworld_PlayerEntryAnimation = $000059

; TitleScreen:
!RAM_SMB3_TitleScreen_Mario_XPosHi = $000043
!RAM_SMB3_TitleScreen_Luigi_XPosHi = !RAM_SMB3_TitleScreen_Mario_XPosLo+$01
!RAM_SMB3_TitleScreen_Sprite_XPosHi = $000045
!RAM_SMB3_TitleScreen_Mario_YPosHi = $00004B
!RAM_SMB3_TitleScreen_Luigi_YPosHi = !RAM_SMB3_TitleScreen_Mario_XPosLo+$01
!RAM_SMB3_TitleScreen_Sprite_YPosHi = $00004D
!RAM_SMB3_TitleScreen_Mario_XPosLo = $000053
!RAM_SMB3_TitleScreen_Luigi_XPosLo = !RAM_SMB3_TitleScreen_Mario_XPosLo+$01
!RAM_SMB3_TitleScreen_Sprite_XPosLo = $000055
!RAM_SMB3_TitleScreen_Mario_YPosLo = $00005B
!RAM_SMB3_TitleScreen_Luigi_YPosLo = !RAM_SMB3_TitleScreen_Mario_YPosLo+$01
!RAM_SMB3_TitleScreen_Sprite_YPosLo = $00005D
!RAM_SMB3_TitleScreen_Mario_XSpeed = $000063
!RAM_SMB3_TitleScreen_Luigi_XSpeed = !RAM_SMB3_TitleScreen_Mario_XSpeed+$01
!RAM_SMB3_TitleScreen_Sprite_XSpeed = $000065
!RAM_SMB3_TitleScreen_Mario_YSpeed = $00006B
!RAM_SMB3_TitleScreen_Luigi_YSpeed = !RAM_SMB3_TitleScreen_Mario_YSpeed+$01
!RAM_SMB3_TitleScreen_Sprite_YSpeed = $00006D
!RAM_SMB3_TitleScreen_Mario_SubXPos = $000073
!RAM_SMB3_TitleScreen_Luigi_SubXPos = !RAM_SMB3_TitleScreen_Mario_SubXPos+$01
!RAM_SMB3_TitleScreen_Sprite_SubXPos = $000075
!RAM_SMB3_TitleScreen_Mario_SubYPos = $00007B
!RAM_SMB3_TitleScreen_Luigi_SubYPos = !RAM_SMB3_TitleScreen_Mario_SubYPos+$01
!RAM_SMB3_TitleScreen_Sprite_SubYPos = $00007D
!RAM_SMB3_TitleScreen_Mario_InAirFlag = $000083
!RAM_SMB3_TitleScreen_Luigi_InAirFlag = !RAM_SMB3_TitleScreen_Mario_InAirFlag+$01
!RAM_SMB3_TitleScreen_Mario_YXPPCCCT = $000085
!RAM_SMB3_TitleScreen_Luigi_YXPPCCCT = !RAM_SMB3_TitleScreen_Mario_YXPPCCCT+$01
!RAM_SMB3_TitleScreen_Mario_MovementDirection = $000087
!RAM_SMB3_TitleScreen_Luigi_MovementDirection = !RAM_SMB3_TitleScreen_Mario_MovementDirection+$01
!RAM_SMB3_TitleScreen_Mario_WalkingAnimationIndex = $000089
!RAM_SMB3_TitleScreen_Luigi_WalkingAnimationIndex = !RAM_SMB3_TitleScreen_Mario_WalkingAnimationIndex+$01
!RAM_SMB3_TitleScreen_Mario_WalkingAnimationFrameCounter = $00008B
!RAM_SMB3_TitleScreen_Luigi_WalkingAnimationFrameCounter = !RAM_SMB3_TitleScreen_Mario_WalkingAnimationFrameCounter+$01
!RAM_SMB3_TitleScreen_Mario_CurrentPose = $00008D
!RAM_SMB3_TitleScreen_Luigi_CurrentPose = !RAM_SMB3_TitleScreen_Mario_CurrentPose+$01
!RAM_SMB3_TitleScreen_Mario_GFXSet = $00008F
!RAM_SMB3_TitleScreen_Luigi_GFXSet = !RAM_SMB3_TitleScreen_Mario_GFXSet+$01
!RAM_SMB3_TitleScreen_Mario_OAMIndex = $000091
!RAM_SMB3_TitleScreen_Luigi_OAMIndex = !RAM_SMB3_TitleScreen_Mario_OAMIndex+$01
!RAM_SMB3_TitleScreen_Mario_OffscreenTileFlags = $000093
!RAM_SMB3_TitleScreen_Luigi_OffscreenTileFlags = !RAM_SMB3_TitleScreen_Mario_OffscreenTileFlags+$01
!RAM_SMB3_TitleScreen_Mario_TailGlideAnimationTimer = $000095
!RAM_SMB3_TitleScreen_Luigi_TailGlideAnimationTimer = !RAM_SMB3_TitleScreen_Mario_TailGlideAnimationTimer+$01
!RAM_SMB3_TitleScreen_Mario_CarryingSomethingFlag = $000097
!RAM_SMB3_TitleScreen_Luigi_CarryingSomethingFlag = !RAM_SMB3_TitleScreen_Mario_CarryingSomethingFlag+$01
!RAM_SMB3_TitleScreen_Mario_BonkedAnimationTimer = $000099
!RAM_SMB3_TitleScreen_Luigi_BonkedAnimationTimer = !RAM_SMB3_TitleScreen_Mario_BonkedAnimationTimer+$01
!RAM_SMB3_TitleScreen_Mario_KickAnimationTimer = $00009B
!RAM_SMB3_TitleScreen_Luigi_KickAnimationTimer = !RAM_SMB3_TitleScreen_Mario_KickAnimationTimer+$01
!RAM_SMB3_TitleScreen_Mario_ShrinkAnimationTimer = $00009D
!RAM_SMB3_TitleScreen_Player_HoldInPlaceFlag = $00009E
!RAM_SMB3_TitleScreen_Player_SpriteIndex = $00009F
!RAM_SMB3_TitleScreen_Sprite_YXPPCCCT = $0000A0
!RAM_SMB3_TitleScreen_Sprite_CurrentState = $0000A6
!RAM_SMB3_TitleScreen_CurrentState = $0000AC
!RAM_SMB3_TitleScreen_WaitBeforeRestartingTitleScreenTimerHi = $0000AD
!RAM_SMB3_TitleScreen_WaitBeforeRestartingTitleScreenTimerLo = $0000AE
!RAM_SMB3_TitleScreen_ResetTitleScreenFlag = $0000AF
!RAM_SMB3_TitleScreen_UnknownFlag = $0000B0
!RAM_SMB3_TitleScreen_3PaletteAnimationFrameCounter = $0000B1
	!RAM_SMB3_TitleScreen_WaitBeforeMovingCurtainUpTimer = $0000B1
	!RAM_SMB3_TitleScreen_ShakeLayer1Timer = $0000B1
	!RAM_SMB3_TitleScreen_WaitBeforeDroppingSpritesTimer = $0000B1
!RAM_SMB3_TitleScreen_Mario_ScriptIndex = $0000B2
!RAM_SMB3_TitleScreen_Luigi_ScriptIndex = $0000B3
!RAM_SMB3_TitleScreen_Mario_ScriptTimer = $0000B4
!RAM_SMB3_TitleScreen_Luigi_ScriptTimer = $0000B5

!RAM_SMB3_TitleScreen_NewSpriteIndex = $0000BE
!RAM_SMB3_TitleScreen_WaitBeforeSpawningNextSpriteTimer = $0000BF
!RAM_SMB3_TitleScreen_Enable3PaletteAnimationFlag = $0000C0
!RAM_SMB3_TitleScreen_3PaletteAnimationIndex = $0000C1

; WorldRollcall:
!RAM_SMB3_WorldRollcall_CurrentState = $000043

!RAM_SMB3_WorldRollcall_WaitBeforeMovingCurtainBackUpTimerHi = $00004B
	!RAM_SMB3_WorldRollcall_WaitBeforeDisplayingNextScreenTimerHi = $00004B
!RAM_SMB3_WorldRollcall_WaitBeforeMovingCurtainBackUpTimerLo = $00004C
	!RAM_SMB3_WorldRollcall_WaitBeforeDisplayingNextScreenTimerLo = $00004C
!RAM_SMB3_WorldRollcall_CurrentWorld = $00004D

!RAM_SMB3_WorldRollcall_WaitBeforeMovingCurtainDownTimer = $0000B1
	!RAM_SMB3_WorldRollcall_WaitBeforeDisplayingTheEndTimer = $0000B1

; PeachRescued:
!RAM_SMB3_PeachRescued_Player_XPosHi = !RAM_SMB3_TitleScreen_Mario_XPosHi

!RAM_SMB3_PeachRescued_Player_XPosLo = !RAM_SMB3_TitleScreen_Mario_XPosLo
!RAM_SMB3_PeachRescued_Peach_XPosLo = !RAM_SMB3_TitleScreen_Luigi_XPosLo

!RAM_SMB3_PeachRescued_Player_YPosLo = !RAM_SMB3_TitleScreen_Mario_YPosLo
!RAM_SMB3_PeachRescued_Peach_YPosLo = !RAM_SMB3_TitleScreen_Luigi_YPosLo

!RAM_SMB3_PeachRescued_Player_YXPPCCCT = !RAM_SMB3_TitleScreen_Mario_YXPPCCCT
!RAM_SMB3_PeachRescued_Peach_YXPPCCCT = !RAM_SMB3_TitleScreen_Luigi_YXPPCCCT

!RAM_SMB3_PeachRescued_Player_CurrentPose = !RAM_SMB3_TitleScreen_Mario_CurrentPose
!RAM_SMB3_PeachRescued_Peach_CurrentPose = !RAM_SMB3_TitleScreen_Luigi_CurrentPose
!RAM_SMB3_PeachRescued_Player_GFXSet = $00008F
!RAM_SMB3_PeachRescued_Peach_GFXSet = !RAM_SMB3_PeachRescued_Player_GFXSet+$01
!RAM_SMB3_PeachRescued_Player_OAMIndex = !RAM_SMB3_TitleScreen_Mario_OAMIndex
!RAM_SMB3_PeachRescued_Peach_OAMIndex = !RAM_SMB3_TitleScreen_Luigi_OAMIndex

!RAM_SMB3_PeachRescued_Player_SpriteIndex = !RAM_SMB3_TitleScreen_Player_SpriteIndex
!RAM_SMB3_PeachRescued_PhaseTimer1 = $0000A0
!RAM_SMB3_PeachRescued_PhaseTimer2 = !RAM_SMB3_PeachRescued_PhaseTimer1+$01				; $0000A1
!RAM_SMB3_PeachRescued_WaitBeforeDisplayingText = !RAM_SMB3_PeachRescued_PhaseTimer1+$02		; $0000A2
!RAM_SMB3_PeachRescued_CurrentState = $0000A3

!RAM_SMB3_PeachRescued_TextBoxStripeImageIndex = $0000A6
	!RAM_SMB3_PeachRescued_TextIndex = $0000A6
!RAM_SMB3_PeachRescued_CurrentTextBoxState = $0000A7

; BattleMode:
!RAM_SMB3_BattleMode_CurrentState = $000075

!RAM_SMB3_BattleMode_MariosPose = $00008D
!RAM_SMB3_BattleMode_LuigisPose = !RAM_SMB3_BattleMode_MariosPose+$01

;--------------------------------------------------------------------

!RAM_SMB3_Global_ControllerHold1P1 = $0000F2
!RAM_SMB3_Global_ControllerHold1P2 = $0000F3
!RAM_SMB3_Global_ControllerHold2P1 = $0000F4
!RAM_SMB3_Global_ControllerHold2P2 = !RAM_SMB3_Global_ControllerHold2P1+$01
!RAM_SMB3_Global_ControllerPress1P1 = $0000F6
!RAM_SMB3_Global_ControllerPress1P2 = !RAM_SMB3_Global_ControllerPress1P1+$01
!RAM_SMB3_Global_ControllerPress2P1 = $0000F8
!RAM_SMB3_Global_ControllerPress2P2 = !RAM_SMB3_Global_ControllerPress2P1+$01
!RAM_SMB3_Global_P1CtrlDisableLo = $0000FA
!RAM_SMB3_Global_P2CtrlDisableLo = $0000FB
!RAM_SMB3_Global_P1CtrlDisableHi = $0000FC
!RAM_SMB3_Global_P2CtrlDisableHi = $0000FD

!RAM_SMB3_Global_CurrentVBlankRoutinePath = $000100
!RAM_SMB3_Global_CurrentRasterEffect = $000101
!RAM_SMB3_Global_EndOfStack = !RAM_SMB3_Global_StartOfStack-$FF
	!RAM_SMB3_Global_WaitForVBlankFlag = $000154
	!RAM_SMB3_Global_EnableDebugModeFlag = $000160
!RAM_SMB3_Global_StartOfStack = $0001FF
!RAM_SMB3_Global_BG1And2WindowMaskSettingsMirror = $000200
!RAM_SMB3_Global_BG3And4WindowMaskSettingsMirror = $000201
!RAM_SMB3_Global_ObjectAndColorWindowSettingsMirror = $000202
!RAM_SMB3_Global_ColorMathInitialSettingsMirror = $000203
!RAM_SMB3_Global_ColorMathSelectAndEnableMirror = $000204
!RAM_SMB3_Global_FixedColorData1Mirror = $000205
!RAM_SMB3_Global_FixedColorData2Mirror = $000206
!RAM_SMB3_Global_FixedColorData3Mirror = $000207
!RAM_SMB3_Global_MainScreenLayersMirror = $000208
!RAM_SMB3_Global_SubScreenLayersMirror = $000209
!RAM_SMB3_Global_MainScreenWindowMaskMirror = $00020A
!RAM_SMB3_Global_SubScreenWindowMaskMirror = $00020B
!RAM_SMB3_Global_BGModeAndTileSizeSettingMirror = $00020C
!RAM_SMB3_Global_MosaicSizeAndBGEnableMirror = $00020D
!RAM_SMB3_Global_SpecialLayerBGModeAndTileSizeSettingMirror = $00020E

; $000210 = Layer 1 scroll X speed?
!RAM_SMB3_Global_OAMSizeAndDataAreaDesignationMirror = $00021E
!RAM_SMB3_ErrorScreen_SpecialStartUpScreenColor4Hi = !RAM_SMB3_ErrorScreen_SpecialStartUpScreenColor4Lo+$01
; $000222 = Dynamic Player graphics low and high byte table 1?
; $00022E = Dynamic Player graphics low and high byte table 2?
; $000238 = Dynamic Player graphics bank byte 1?
; $000239 = Dynamic Player graphics bank byte 2?
!RAM_SMB3_Level_PreviousSpriteDataLo = $00023A
!RAM_SMB3_Level_PreviousSpriteDataHi = !RAM_SMB3_Level_PreviousSpriteDataLo+$01
!RAM_SMB3_Level_PreviousSpriteDataBank = !RAM_SMB3_Level_PreviousSpriteDataLo+$02

!RAM_SMB3_Global_AnimatedFGTileAnimationFrameIndex = $000243

!RAM_SMB3_Level_FireSpr_XPosHi = $000247

!RAM_SMB3_CoinSpr_XPosHi = $00024C

!RAM_SMB3_Level_PauseMenuStatus = $00028C
!RAM_SMB3_Level_PauseMenuCursorPos = $00028E
!RAM_SMB3_Global_HDMAEnableMirror = $000293

!RAM_SMB3_Level_MExtSpr_XPosHi = $0002AE

!RAM_SMB3_Level_CoinAndQuestionBlockAnimationFrameIndex = $0002B1

!RAM_SMB3_Level_Layer3BGFromHeader = $0002BF

!RAM_SMB3_Level_Layer2BGPaletteFromHeader = $0002C5

!RAM_SMB3_BattleMode_MariosRoundWinCount = $0002DA
!RAM_SMB3_BattleMode_LuigisRoundWinCount = !RAM_SMB3_BattleMode_MariosRoundWinCount+$01

!RAM_SMB3_BattleMode_MariosWinCount = $0002DE
!RAM_SMB3_BattleMode_LuigisWinCount = !RAM_SMB3_BattleMode_MariosWinCount+$01


!RAM_SMB3_WorldRollcall_OpenPauseMenuFlag = $0002E5

!RAM_SMB3_Level_Layer2BGFromHeader = $000350
!RAM_SMB3_Level_AirshipLayer3BGParallaxRow1XPosLo = $000357
!RAM_SMB3_Level_AirshipLayer3BGParallaxRow1XPosHi = !RAM_SMB3_Level_AirshipLayer3BGParallaxRow1XPosLo+$01
!RAM_SMB3_Level_AirshipLayer3BGParallaxRow2XPosLo = !RAM_SMB3_Level_AirshipLayer3BGParallaxRow1XPosLo+$02
!RAM_SMB3_Level_AirshipLayer3BGParallaxRow2XPosHi = !RAM_SMB3_Level_AirshipLayer3BGParallaxRow2XPosLo+$01
!RAM_SMB3_Level_AirshipLayer3BGParallaxRow3XPosLo = !RAM_SMB3_Level_AirshipLayer3BGParallaxRow1XPosLo+$04
!RAM_SMB3_Level_AirshipLayer3BGParallaxRow3XPosHi = !RAM_SMB3_Level_AirshipLayer3BGParallaxRow3XPosLo+$01
!RAM_SMB3_Level_AirshipLayer3BGParallaxRow4XPosLo = !RAM_SMB3_Level_AirshipLayer3BGParallaxRow1XPosLo+$06
!RAM_SMB3_Level_AirshipLayer3BGParallaxRow4XPosHi = !RAM_SMB3_Level_AirshipLayer3BGParallaxRow4XPosLo+$01

!RAM_SMB3_Global_FilledInPMeterSegments = $000413
;$000414 = Some sort of level transition flag.

; $000419 = Something related to the reserve box

; $00041B = Something related to the reserve box
!RAM_SMB3_Global_ReserveBoxState = $00041C
!RAM_SMB3_Overworld_ReserveBoxPageIndex = $00041D

!RAM_SMB3_Overworld_ReserveBoxSlotIndex = $00041F

!RAM_SMB3_Level_ToadHouseChestContentsIndex = $000421
; Info:
; 00 = Do not use
; 01 = Warp whistle
; 02 = P-wing
; 03 = Frog suit
; 04 = Tanooki suit
; 05 = Hammer suit
; 06 = Random suit
; 07 = Random basic powerup

!RAM_SMB3_Global_CoinsToGive = $000422

!RAM_SMB3_Level_Layer1VerticalScrollSetting = $000424
!RAM_SMB3_Level_IsVerticalLevelFlag = $000425
!RAM_SMB3_Overworld_UsedReserveStarFlag = $000428
!RAM_SMB3_Overworld_PlayerPowerUpPose = $000429

!RAM_SMB3_Overworld_OWSpr_YPosLo = $000500			; Todo: $0500 seems like it has another use.
!RAM_SMB3_Overworld_OWSpr_XPosLo = $00050F
	; $000510 = Player Pipe Animation timer?
	!RAM_SMB3_TitleScreen_Mario_PowerUpPoofAnimationTimer = $000511
!RAM_SMB3_Overworld_OWSpr_XPosHi = $00051E

!RAM_SMB3_Level_Player_TailSwipeTimer = $000517
!RAM_SMB3_Level_NorSpr_DecrementingTable7E0518 = $000518
!RAM_SMB3_Level_NorSpr_DecrementingTable7E0520 = $000520
!RAM_SMB3_Level_NorSpr_Table7E0526 = $000526
!RAM_SMB3_Level_NorSpr_Table7E052D = $00052D

!RAM_SMB3_Level_Player_IsAboveTopOfLevelFlag = $000544
!RAM_SMB3_Level_EntranceSettings = $000545
	!RAM_SMB3_Level_Player_SlidingXSpeed = $000545

!RAM_SMB3_Level_Player_SomersaultJumpFlag = $00054F

!RAM_SMB3_Level_Player_SizeChangeAnimationTimer = $000551
!RAM_SMB3_Level_Player_HurtTimer = $000552
!RAM_SMB3_Level_Player_StarPowerTimer = $000553
!RAM_SMB3_Level_Player_SmokePuffAnimationTimer = $000554
!RAM_SMB3_Level_Player_FireFlowerGetPaletteAnimationTimer = $000555
!RAM_SMB3_Level_Player_FreezePlayerTimer = $000556
!RAM_SMB3_Level_Player_KickAnimationTimer = $000557
!RAM_SMB3_Level_Player_EnterVerticalPipeAnimationTimer = $000558
!RAM_SMB3_Level_Player_GoalWalkAnimationTimer = $000559
!RAM_SMB3_Level_Player_BoardAirshipAnimationState = $00055A

; $000560 = Some address affected by the current tileset.

!RAM_SMB3_Level_GenSpr_SpriteID = $000566
!RAM_SMB3_Level_PSwitchTimer = $000567

!RAM_SMB3_Level_Player_IsClimbingFlag = $00056B

!RAM_SMB3_Level_Player_HitCeilingFlag = $00056D
!RAM_SMB3_Level_Player_FlightTimer = $00056E
!RAM_SMB3_Level_Player_DuckingFlag = $00056F
!RAM_SMB3_Level_Player_DuckingOnWhiteScrewBlockTimer = $000570
; $000571 = Something related to entering pipes. Direction perhaps?
!RAM_SMB3_Level_WarpToCoinHeavenTimer = $000572

!RAM_SMB3_Level_Player_WalkingAnimationFrameCounter = $000574
!RAM_SMB3_Level_Player_IsSwimmingFlag = $000575

!RAM_SMB3_Level_Player_InKuriboShoeFlag = $000577

!RAM_SMB3_Level_Player_IsTanookiStatueTimer = $00057A
!RAM_SMB3_Level_Player_CantBuildUpPSpeedFlag = $00057B

!RAM_SMB3_Level_RunScrollSpritesFlag = $000580
!RAM_SMB3_Level_10CoinBlockCounter = $000581

!RAM_SMB3_Level_Player_BigInSmallSpaceFlag = $000585
; $000586 = Some sort of powerup related flag
!RAM_SMB3_Level_Player_BehindLayer1Flag = $000587
	!RAM_SMB3_Overworld_OWSpr_XOffscreenFlag = $000587
!RAM_SMB3_Level_Player_BehindLayer1Timer = $000588
!RAM_SMB3_Level_Player_OnSlipperyGroundFlag = $000589
!RAM_SMB3_Level_Player_InQuicksandFlag = $00058A

!RAM_SMB3_Level_TemporarilyDisableTimeLimitFlag = $00058C

!RAM_SMB3_Level_SplashSpr_YPosHi = $00058E

!RAM_SMB3_Overworld_Player_InCanoeFlag = $000597
!RAM_SMB3_Overworld_EnableDarknessFlag = $000598

!RAM_SMB3_Overworld_TileAnimationTimer = $00059A

!RAM_SMB3_Level_ExtSpr_SubYPos = $0005A1
!RAM_SMB3_Level_ExtSpr_SubXPos = $0005AB
!RAM_SMB3_Level_ExtSpr_YPosLo = $0005BF
!RAM_SMB3_Level_ExtSpr_XPosLo = $0005C9
!RAM_SMB3_Level_ExtSpr_YSpeed = $0005D3
!RAM_SMB3_Level_ExtSpr_XSpeed = $0005DD
!RAM_SMB3_Level_TimerHundreds = $0005EE
!RAM_SMB3_Level_TimerTens = $0005EF
!RAM_SMB3_Level_TimerOnes = $0005F0
!RAM_SMB3_Level_WaitBeforeDecrementingTimer = $0005F1
!RAM_SMB3_Global_OpenReserveBoxFlag = $0005F2
!RAM_SMB3_Level_FreezeTimeLimitFlag = $0005F3
!RAM_SMB3_Level_ConsecutiveEnemiesStompedCounter = $0005F4

!RAM_SMB3_Level_FireSpr_YPosHi = $0005FA

!RAM_SMB3_Level_NorSpr_XOffscreenFlag = $000651
!RAM_SMB3_Level_NorSpr_CurrentStatus = $000661
!RAM_SMB3_Level_NorSpr_Table7E0669 = $000669
!RAM_SMB3_Level_NorSpr_SpriteID = $000671
!RAM_SMB3_Level_NorSpr_Table7E0679 = $000679
	!RAM_SMB3_Level_NorSpr_YXPPCCCT = !RAM_SMB3_Level_NorSpr_Table7E0679
!RAM_SMB3_Level_NorSpr_YOffscreenFlag = $000681
!RAM_SMB3_Level_NorSpr_Table7E0689 = $000689
!RAM_SMB3_Level_NorSpr_Table7E0691 = $000691

!RAM_SMB3_Global_PointsToGiveLo = $00069C
!RAM_SMB3_Global_PointsToGiveMid = !RAM_SMB3_Global_PointsToGiveLo+$01

!RAM_SMB3_Level_Player_ShowCarryingAnimationFlag = $0006A4
!RAM_SMB3_Level_Player_CarryingSomethingFlag = $0006A5
!RAM_SMB3_Level_NorSpr_DecrementingTable7E06A6 = $0006A6
!RAM_SMB3_Level_NorSpr_DecrementingTable7E06AB = $0006AB

!RAM_SMB3_Level_Player_NumberOfClingingMicroGoombas = $0006B6
; $0006B7 = Normal sprite in liquid flag table?

!RAM_SMB3_Level_ExtSpr_Table7E06BD = $0006BD
!RAM_SMB3_Level_ExtSpr_Table7E06C7 = $0006C7
!RAM_SMB3_Level_ExtSpr_Table7E06D1 = $0006D1

!RAM_SMB3_Global_TilesetFromHeader = $00070A
!RAM_SMB3_Overworld_ScrollMapTimer = $000710
; $000713 = Flag to disable the level fade in?/Flag to indicate the player died?
!RAM_SMB3_Global_FullPMeterFrameCounter = $000714
!RAM_SMB3_Level_Player_CurrentScoreHi = $000715
!RAM_SMB3_Level_Player_CurrentScoreMid = !RAM_SMB3_Level_Player_CurrentScoreHi+$01
!RAM_SMB3_Level_Player_CurrentScoreLo = !RAM_SMB3_Level_Player_CurrentScoreHi+$02

; $0722 = Overworld layer 1 X pos lo (Mario)
; $0723 = Overworld layer 1 X pos lo (Luigi)
; $0724 = Overworld layer 1 X pos hi (Mario)
; $0725 = Overworld layer 1 X pos hi (Luigi)
!RAM_SMB3_Level_Player_CurrentCharacter = $000726
!RAM_SMB3_Global_CurrentWorld = $000727
!RAM_SMB3_Overworld_CurrentProcess = $000729

!RAM_SMB3_Global_TwoPlayerGameFlag = $00072B
	!RAM_SMB3_TitleScreen_MenuSelectionIndex = !RAM_SMB3_Global_TwoPlayerGameFlag
!RAM_SMB3_Level_Player_MariosLives = $000736
!RAM_SMB3_Level_Player_LuigisLives = !RAM_SMB3_Level_Player_MariosLives+$01
!RAM_SMB3_Level_BackgroundColorSettingFromHeader = $00073C
; $00073D = Something related to exiting a level. If set to 01, the player is sent to a post koopaling throne room cutscene.
!RAM_SMB3_Global_NumberOfCardGameMatches = $000741
!RAM_SMB3_Global_DontShuffleCardGameDeckFlag = $000742
!RAM_SMB3_Overworld_FleeingAirshipPosPtrIndex = $000743

!RAM_SMB3_Level_NorSpr_SubXPos = $00074F
!RAM_SMB3_Level_NorSpr_SubYPos = !RAM_SMB3_Level_NorSpr_SubXPos+$12			; $000761
!RAM_SMB3_Level_NorSpr_Table7E0769 =  $000769
!RAM_SMB3_Level_NorSpr_Table7E0771 = $000771
!RAM_SMB3_Level_NorSpr_Table7E0776 = $000776
!RAM_SMB3_Level_NorSpr_Table7E077B = $00077B
!RAM_SMB3_Global_RandomByte01 = $000782
!RAM_SMB3_Global_RandomByte02 = !RAM_SMB3_Global_RandomByte01+$01
!RAM_SMB3_Global_RandomByte03 = !RAM_SMB3_Global_RandomByte01+$02
!RAM_SMB3_Global_RandomByte04 = !RAM_SMB3_Global_RandomByte01+$03
!RAM_SMB3_Global_RandomByte05 = !RAM_SMB3_Global_RandomByte01+$04
!RAM_SMB3_Global_RandomByte06 = !RAM_SMB3_Global_RandomByte01+$05
!RAM_SMB3_Global_RandomByte07 = !RAM_SMB3_Global_RandomByte01+$06
!RAM_SMB3_Global_RandomByte08 = !RAM_SMB3_Global_RandomByte01+$07
!RAM_SMB3_Global_RandomByte09 = !RAM_SMB3_Global_RandomByte01+$08
!RAM_SMB3_Global_RandomByte0A = !RAM_SMB3_Global_RandomByte01+$09

!RAM_SMB3_Level_TriggerEndingFlag = $00078E
	; $00078E = Something related to the title screen.
!RAM_SMB3_Level_NorSpr_Table7E0797 = $000797					; Note: Sprite being stood/stomped on flag?

!RAM_SMB3_Overworld_DrawbridgeState = $0007BC
;$0007BE = Koopa kid state?

!RAM_SMB3_NorSprXXX_GiantQuestionMarkBlock_BlockHitFlags = $0007E3

!RAM_SMB3_Global_OAMBuffer = $000800
!RAM_SMB3_Global_OAMTileSizeBuffer = $000A20

!RAM_SMB3_SlidingPictureGame_TopRowXPosLo = $001000
!RAM_SMB3_SlidingPictureGame_MiddleRowXPosLo = !RAM_SMB3_SlidingPictureGame_TopRowXPosLo+$01
!RAM_SMB3_SlidingPictureGame_BottomRowXPosLo = !RAM_SMB3_SlidingPictureGame_TopRowXPosLo+$02
!RAM_SMB3_SlidingPictureGame_TopRowXPosHi = $001003
!RAM_SMB3_SlidingPictureGame_MiddleRowXPosHi = !RAM_SMB3_SlidingPictureGame_TopRowXPosHi+$01
!RAM_SMB3_SlidingPictureGame_BottomRowXPosHi = !RAM_SMB3_SlidingPictureGame_TopRowXPosHi+$02
!RAM_SMB3_SlidingPictureGame_TopRowImage = $001006
!RAM_SMB3_SlidingPictureGame_MiddleRowImage = !RAM_SMB3_SlidingPictureGame_TopRowImage+$01
!RAM_SMB3_SlidingPictureGame_BottomRowImage = !RAM_SMB3_SlidingPictureGame_TopRowImage+$02

!RAM_SMB3_SlidingPictureGame_CurrentState = $00100B
!RAM_SMB3_SlidingPictureGame_TopRowState = $00100C
	!RAM_SMB3_SlidingPictureGame_XUpTextYPosLo = $00100C
	!RAM_SMB3_SlidingPictureGame_UnknownRAM7E100C = $00100C
!RAM_SMB3_SlidingPictureGame_MiddleRowState = !RAM_SMB3_SlidingPictureGame_TopRowState+$01
	!RAM_SMB3_SlidingPictureGame_RemainingLivesToAward = $00100D
!RAM_SMB3_SlidingPictureGame_BottomRowState = !RAM_SMB3_SlidingPictureGame_TopRowState+$02
!RAM_SMB3_SlidingPictureGame_TopRowXSpeed = $00100F
!RAM_SMB3_SlidingPictureGame_MiddleRowXSpeed = !RAM_SMB3_SlidingPictureGame_TopRowXSpeed+$01
!RAM_SMB3_SlidingPictureGame_BottomRowXSpeed = !RAM_SMB3_SlidingPictureGame_TopRowXSpeed+$02
!RAM_SMB3_SlidingPictureGame_TopRowDelayTimer = $001012
	!RAM_SMB3_SlidingPictureGame_WaitBeforeGoingBackToOverworldTimer = $001012
!RAM_SMB3_SlidingPictureGame_MiddleRowDelayTimer = !RAM_SMB3_SlidingPictureGame_TopRowDelayTimer+$01
!RAM_SMB3_SlidingPictureGame_BottomRowDelayTimer = !RAM_SMB3_SlidingPictureGame_TopRowDelayTimer+$02
!RAM_SMB3_SlidingPictureGame_TopRowSubXPos = $001015
!RAM_SMB3_SlidingPictureGame_MiddleRowSubXPos = !RAM_SMB3_SlidingPictureGame_TopRowSubXPos+$01
!RAM_SMB3_SlidingPictureGame_BottomRowSubXPos = !RAM_SMB3_SlidingPictureGame_TopRowSubXPos+$02

!RAM_SMB3_SlidingPictureGame_NumberOfRoundsToPlay = $001019

!RAM_SMB3_Level_Player_SuctionXOffset = $001020
!RAM_SMB3_Level_NorSpr_Table7E1021 = $001021
!RAM_SMB3_Global_ScratchRAM7E1026 = $001026
!RAM_SMB3_Global_ScratchRAM7E1027 = !RAM_SMB3_Global_ScratchRAM7E1026+$01
; $001028 = Something related to the spade game intro
	!RAM_SMB3_CardFlipGame_CursorPosIndex = $001028
!RAM_SMB3_CardFlipGame_FirstCardFlippedIndex = $001029
!RAM_SMB3_Global_ScratchRAM7E102A = $00102A
!RAM_SMB3_CardFlipGame_DelayTimer = $00102B
!RAM_SMB3_CardFlipGame_CardOAMIndex = $00102C
!RAM_SMB3_CardFlipGame_CardFlipAnimationTimer = $00102D

!RAM_SMB3_CardFlipGame_NumberOfCardsFlipped = $001030
!RAM_SMB3_CardFlipGame_ContentsOfFirstCardFlipped = $001031

!RAM_SMB3_CardFlipGame_CurrentState = $001034

!RAM_SMB3_CardFlipGame_RemainingTries = $001035
!RAM_SMB3_CardFlipGame_CardFlipAnimationFrame = $001036

!RAM_SMB3_CardFlipGame_BorderPaletteAnimationTimer = $00103D
!RAM_SMB3_CardFlipGame_CoinsToGive = $00103E

!RAM_SMB3_SpadeGame_CurrentState = $001040
!RAM_SMB3_CardFlipGame_CurrentInitializationState = $001041
!RAM_SMB3_SpadeGame_GameType = $001042
!RAM_SMB3_Global_MusicRegisterBackup = $001061
!RAM_SMB3_Global_SoundCh1 = $001200
!RAM_SMB3_Global_SoundCh2 = !RAM_SMB3_Global_SoundCh1+$01
!RAM_SMB3_Global_MusicCh1 = !RAM_SMB3_Global_SoundCh1+$02
!RAM_SMB3_Global_SoundCh3 = !RAM_SMB3_Global_SoundCh1+$03
!RAM_SMB3_Global_PaletteMirror = $001300
!RAM_SMB3_Global_UpdateEntirePaletteFlag = $001500
!RAM_SMB3_Global_LoadOverworldMusicBank = $001503
!RAM_SMB3_Global_StripeImageUploadIndexLo = $001600
!RAM_SMB3_Global_StripeImageUploadIndexHi = !RAM_SMB3_Global_StripeImageUploadIndexLo+$01
!RAM_SMB3_Global_StripeImageUploadTable = $001602

!RAM_SMB3_BattleMode_MariosState = $001800
!RAM_SMB3_BattleMode_LuigisState = !RAM_SMB3_BattleMode_MariosState+$01
!RAM_SMB3_BattleNorSpr_CurrentStatus = !RAM_SMB3_BattleMode_MariosState+$02
!RAM_SMB3_BattleBounceSpr_DespawnTimer = !RAM_SMB3_BattleNorSpr_CurrentStatus+$0D
!RAM_SMB3_BattleMode_MariosYPosLo = $001811
!RAM_SMB3_BattleMode_LuigisYPosLo = !RAM_SMB3_BattleMode_MariosYPosLo+$01
!RAM_SMB3_BattleNorSpr_YPosLo = !RAM_SMB3_BattleMode_MariosYPosLo+$02
!RAM_SMB3_BattleBounceSpr_YPosLo = !RAM_SMB3_BattleNorSpr_YPosLo+$0D
!RAM_SMB3_BattleMode_MariosXPosLo = $001822
!RAM_SMB3_BattleMode_LuigisXPosLo = !RAM_SMB3_BattleMode_MariosXPosLo+$01
!RAM_SMB3_BattleNorSpr_XPosLo = !RAM_SMB3_BattleMode_MariosXPosLo+$02
!RAM_SMB3_BattleBounceSpr_XPosLo = !RAM_SMB3_BattleNorSpr_XPosLo+$0D
!RAM_SMB3_BattleMode_MariosYSpeed = $001833
!RAM_SMB3_BattleMode_LuigisYSpeed = !RAM_SMB3_BattleMode_MariosYSpeed+$01
!RAM_SMB3_BattleNorSpr_YSpeed = !RAM_SMB3_BattleMode_MariosYSpeed+$02
!RAM_SMB3_BattleBounceSpr_YSpeed = !RAM_SMB3_BattleNorSpr_YSpeed+$0D
!RAM_SMB3_BattleMode_MariosXSpeed = $001844
!RAM_SMB3_BattleMode_LuigisXSpeed = !RAM_SMB3_BattleMode_MariosXSpeed+$01
!RAM_SMB3_BattleNorSpr_XSpeed = !RAM_SMB3_BattleMode_MariosXSpeed+$02
!RAM_SMB3_BattleBounceSpr_XSpeed = !RAM_SMB3_BattleNorSpr_XSpeed+$0D

!RAM_SMB3_BattleMode_MariosClimbingAnimationFrameCounter = $001855
!RAM_SMB3_BattleMode_LuigisClimbingAnimationFrameCounter = !RAM_SMB3_BattleMode_MariosClimbingAnimationFrameCounter+$01
!RAM_SMB3_BattleNorSpr_AnimationFrameCounter = $001857

!RAM_SMB3_BattleMode_MariosFacingDirection = $001864
!RAM_SMB3_BattleMode_LuigisFacingDirection = !RAM_SMB3_BattleMode_MariosFacingDirection+$01
!RAM_SMB3_BattleNorSpr_FacingDirection = !RAM_SMB3_BattleMode_MariosFacingDirection+$02

!RAM_SMB3_BattleMode_MariosSubYPosLo = $001873
!RAM_SMB3_BattleMode_LuigisSubYPosLo = !RAM_SMB3_BattleMode_MariosSubYPosLo+$01
!RAM_SMB3_BattleNorSpr_SubYPosLo = !RAM_SMB3_BattleMode_MariosSubYPosLo+$02
!RAM_SMB3_BattleBounceSpr_SubYPosLo = !RAM_SMB3_BattleNorSpr_SubYPosLo+$0D
!RAM_SMB3_BattleMode_MariosSubXPosLo = $001884
!RAM_SMB3_BattleMode_LuigisSubXPosLo = !RAM_SMB3_BattleMode_MariosSubXPosLo+$01
!RAM_SMB3_BattleNorSpr_SubXPosLo = !RAM_SMB3_BattleMode_MariosSubXPosLo+$02
!RAM_SMB3_BattleBounceSpr_SubXPosLo = !RAM_SMB3_BattleNorSpr_SubXPosLo+$0D

!RAM_SMB3_BattleMode_MariosTileCollisionFlags = $001895
!RAM_SMB3_BattleMode_LuigisTileCollisionFlags = !RAM_SMB3_BattleMode_MariosTileCollisionFlags+$01
!RAM_SMB3_BattleNorSpr_TileCollisionFlags = !RAM_SMB3_BattleMode_MariosTileCollisionFlags+$02

!RAM_SMB3_BattleMode_MariosKickAnimationTimer = $0018B3
!RAM_SMB3_BattleMode_LuigisKickAnimationTimer = !RAM_SMB3_BattleMode_MariosKickAnimationTimer+$01
!RAM_SMB3_BattleMode_MariosSquishAnimationTimer = $0018B5
!RAM_SMB3_BattleMode_LuigisSquishAnimationTimer = !RAM_SMB3_BattleMode_MariosSquishAnimationTimer+$01

!RAM_SMB3_BattleMode_DisableMarioToLuigiCollision = $0018B9
!RAM_SMB3_BattleMode_POWBlockQuakeTimer = $0018BA
!RAM_SMB3_BattleNorSpr_SpriteID = $0018BB

!RAM_SMB3_BattleNorSpr_DisableSpriteCollisionTimer = $0018DA

!RAM_SMB3_BattleMode_MariosDeathFreezeTimer = $0018E7
!RAM_SMB3_BattleMode_LuigisDeathFreezeTimer = !RAM_SMB3_BattleMode_MariosDeathFreezeTimer+$01
!RAM_SMB3_BattleNorSpr_DecrementingTable7E18E9 = $0018E9
	!RAM_SMB3_BattleNorSpr_TurnAroundAnimationTimer = !RAM_SMB3_BattleNorSpr_DecrementingTable7E18E9

!RAM_SMB3_BattleMode_MarioIsJumpingFlag = $0018F6
!RAM_SMB3_BattleMode_LuigiIsJumpingFlag = !RAM_SMB3_BattleMode_MarioIsJumpingFlag+$01
!RAM_SMB3_BattleMode_TileMariosFeetAreTouching = $0018F8
!RAM_SMB3_BattleMode_TileLuigisFeetAreTouching = !RAM_SMB3_BattleMode_TileMariosFeetAreTouching+$01
!RAM_SMB3_BattleNorSpr_TileSpritesFeetAreTouching = !RAM_SMB3_BattleMode_TileMariosFeetAreTouching+$02

!RAM_SMB3_BattleMode_MariosUnusedFlashingTimer = $00190A
!RAM_SMB3_BattleMode_LuigisUnusedFlashingTimer = !RAM_SMB3_BattleMode_MariosUnusedFlashingTimer+$01
!RAM_SMB3_BattleMode_TileMariosHeadIsIn = $00190F
!RAM_SMB3_BattleMode_TileLuigisHeadIsIn = !RAM_SMB3_BattleMode_TileMariosHeadIsIn+$01
!RAM_SMB3_BattleNorSpr_TileSpritesHeadIsIn = !RAM_SMB3_BattleMode_TileMariosHeadIsIn+$02

!RAM_SMB3_BattleNorSpr_InsidePipeTimer = $00191E

!RAM_SMB3_BattleMode_MariosCoinCount = $00192E
!RAM_SMB3_BattleMode_LuigisCoinCount = !RAM_SMB3_BattleMode_MariosCoinCount+$01
!RAM_SMB3_BattleMode_PlayerHasWonTimer = $001930
!RAM_SMB3_BattleNorSpr_SpeedUpAnimationFlag = $001931
!RAM_SMB3_BattleMode_POWBlockHitCounter = $00193E

!RAM_SMB3_BattleMode_MariosYPosHi = $001942
!RAM_SMB3_BattleMode_LuigisYPosHi = !RAM_SMB3_BattleMode_MariosYPosHi+$01
!RAM_SMB3_BattleNorSpr_YPosHi = !RAM_SMB3_BattleMode_MariosYPosHi+$02
!RAM_SMB3_BattleNorSpr_Table7E1953 = $001953

!RAM_SMB3_BattleMode_MariosWalkingFrameCounter = $00199C
!RAM_SMB3_BattleMode_LuigisWalkingFrameCounter = !RAM_SMB3_BattleMode_MariosWalkingFrameCounter+$01
!RAM_SMB3_BattleMode_MariosWalkingPose = $00199E
!RAM_SMB3_BattleMode_LuigisWalkingPose = !RAM_SMB3_BattleMode_MariosWalkingPose+$01

!RAM_SMB3_BattleNorSpr_StoredXSpeed = $00196F
!RAM_SMB3_BattleNorSpr_UnusedFreezeSpriteTimer = $00197C

!RAM_SMB3_BattleMode_4EnemiesKilledFlag = $0019A0

!RAM_SMB3_BattleMode_MariosPowerUp = $0019AB
!RAM_SMB3_BattleMode_LuigisPowerUp = !RAM_SMB3_BattleMode_MariosPowerUp+$01
!RAM_SMB3_BattleMode_MariosIsDuckingFlag = $0019AD
!RAM_SMB3_BattleMode_LuigisIsDuckingFlag = !RAM_SMB3_BattleMode_MariosIsDuckingFlag+$01
!RAM_SMB3_BattleMode_MariosHurtAnimationTimer = $0019AF
!RAM_SMB3_BattleMode_LuigisHurtAnimationTimer = !RAM_SMB3_BattleMode_MariosHurtAnimationTimer+$01
!RAM_SMB3_BattleMode_MariosNewPowerUpState = $0019B1
!RAM_SMB3_BattleMode_LuigisNewPowerUpState = !RAM_SMB3_BattleMode_MariosNewPowerUpState+$01
!RAM_SMB3_BattleMode_MariosHurtTimer = $0019B3
!RAM_SMB3_BattleMode_LuigisHurtTimer = !RAM_SMB3_BattleMode_MariosHurtTimer+$01
!RAM_SMB3_BattleMode_MariosFreezeHurtTimerFlag = $0019B5
!RAM_SMB3_BattleMode_LuigisFreezeHurtTimerFlag = !RAM_SMB3_BattleMode_MariosFreezeHurtTimerFlag+$01
!RAM_SMB3_BattleMode_HiddenMushroomXPos = $0019B7

!RAM_SMB3_BattleMode_HiddenMushroomYPos = $0019B9

; $0019C0 = Timer that visually swaps the battle mode players

!RAM_SMB3_BattleSmokeSpr_XPosLo = $0019C5
!RAM_SMB3_BattleSmokeSpr_YPosLo = $0019CE
!RAM_SMB3_BattleSmokeSpr_AnimationFrameCounter = $0019D7
!RAM_SMB3_BattleSmokeSpr_AnimationFrame = $0019E0

; $0019E9 = Battle mode smoke sprite related
!RAM_SMB3_BattleSmokeSpr_SpriteID = $0019E9
!RAM_SMB3_BattleSmokeSpr_OAMXDisp = $0019FB
!RAM_SMB3_Level_ScrollSpr_SpriteID = $001A01
!RAM_SMB3_Level_ScrollSpr_HorizontalAutoScrollType = $001A02
!RAM_SMB3_Level_ScrollSpr_ScrollDirection = $001A03
	!RAM_SMB3_Level_ScrollSpr_MovementIndex = !RAM_SMB3_Level_ScrollSpr_ScrollDirection
	!RAM_SMB3_BattleSmokeSpr_OAMYDisp = $001A04
!RAM_SMB3_Level_AutoscrollLayerXPosHi = $001A0A
!RAM_SMB3_Level_AutoscrollLayerYPosHi = !RAM_SMB3_Level_AutoscrollLayerXPosHi+$01
!RAM_SMB3_Level_AutoscrollLayerXPosLo = $001A0C
!RAM_SMB3_Level_AutoscrollLayerYPosLo = !RAM_SMB3_Level_AutoscrollLayerXPosLo+$01
	!RAM_SMB3_BattleSmokeSpr_OAMProp = $001A0D
!RAM_SMB3_Level_AutoscrollLayerXSpeed = $001A0E
!RAM_SMB3_Level_AutoscrollLayerYSpeed = !RAM_SMB3_Level_AutoscrollLayerXSpeed+$01
!RAM_SMB3_Level_AutoscrollLayerSubXPos = $001A10
!RAM_SMB3_Level_AutoscrollLayerSubYPos = !RAM_SMB3_Level_AutoscrollLayerSubXPos+$01
!RAM_SMB3_Level_ShooterSpr_SpriteID = $001A15
	!RAM_SMB3_BattleSmokeSpr_OAMTileSize = $001A16
!RAM_SMB3_Level_ShooterSpr_YPosHi = $001A1D
	!RAM_SMB3_BattleSmokeSpr_OAMTile = $001A1F
!RAM_SMB3_Level_ShooterSpr_YPosLo = $001A25
	!RAM_SMB3_BattleMode_WinnerTextAnimationIndex = $001A2B
	!RAM_SMB3_BattleMode_WinnerTextAnimationTimer = $001A2C
!RAM_SMB3_Level_ShooterSpr_XPosHi = $001A2D
	; $001A2D = Something battle mode related.
	!RAM_SMB3_BattleMode_PreventMushroomSpawns = $001A2F
	!RAM_SMB3_BattleMode_PreventMysteryMushroomSpawns = $001A30
!RAM_SMB3_Level_ShooterSpr_XPosLo = $001A35
	; $001A35 = Something battle mode related.
	!RAM_SMB3_BattleMode_CoinWinTileAnimationIndex = $001A38
	!RAM_SMB3_BattleMode_CoinWinPaletteAnimationIndex = $001A39

	!RAM_SMB3_BattleMode_MushroomSpawnCounter = $001A3F
!RAM_SMB3_BattleNorSpr_IsTurningAroundFlag = $001A40
!RAM_SMB3_BattleNorSpr_TurningAroundStartingPoseIndex = $001A4D

!RAM_SMB3_Level_FireSpr_SubXPos = $001A55

!RAM_SMB3_BattleNorSpr_BlueEnemyFlag = $001A5A

!RAM_SMB3_SlidingPictureGame_BeepNoiseCounter = $001A5F
!RAM_SMB3_SlidingPictureGame_BeepNoiseCounterOffset = $001A60

!RAM_SMB3_BattleMode_DisplayRoundNumberTextFlag = $001A67

!RAM_SMB3_BattleMode_RoundNumberTextAnimationFrameCounter = $001A6A
!RAM_SMB3_BattleMode_RoundNumberTextAnimationFrame = $001A6B

!RAM_SMB3_Level_SpriteListData = $001B40

!RAM_SMB3_Level_NorSpr_Table7E1CC8 = $001CC8
!RAM_SMB3_Level_NorSpr_Table7E1CCD = $001CCD

!RAM_SMB3_Level_NorSpr_Table7E1CD7 = $001CD7
!RAM_SMB3_Level_NorSpr_Table7E1CDC = $001CDC
!RAM_SMB3_Level_FireSpr_CurrentState = $001CE1
!RAM_SMB3_Level_FireSpr_YPosLo = $001CE3
!RAM_SMB3_Level_FireSpr_XPosLo = $001CE5
!RAM_SMB3_Level_FireSpr_YSpeed = $001CE7
!RAM_SMB3_Level_FireSpr_XSpeed = $001CE9

!RAM_SMB3_NorSpr083_Lakitu_ChasePlayerFlag = $001CF0

!RAM_SMB3_Level_NorSpr_Table7E1CF6 = $001CF6
	!RAM_SMB3_Level_NorSpr_FireballHPCounter = !RAM_SMB3_Level_NorSpr_Table7E1CF6

!RAM_SMB3_WorldRollcall_WaitBeforeDisplayingPushStartTimer = $001CFC

; $001C20 = Circular buffer for following sprite X low byte positions
; $001C60 = Circular buffer for following sprite Y low byte positions

!RAM_SMB3_Level_ShakeLayer1YOffset = $001CF2
!RAM_SMB3_Level_ShakeLayer1Timer = $001CF3
!RAM_SMB3_Level_Player_DisableControlsTimer = $001CF4
!RAM_SMB3_Level_Player_SpinningTimer = $001CF5

!RAM_SMB3_Level_ScreenFlashTimer = $001CFB
!RAM_SMB3_Overworld_LevelsClearedBits = $001D00				; 128 bytes
!RAM_SMB3_Global_Player_IndividualPlayerData = $001D80

!RAM_SMB3_Overworld_GameOverMenuCursor = $001DCB

!RAM_SMB3_Level_SublevelLevelDataLo = $001DFE
!RAM_SMB3_Level_SublevelLevelDataHi = !RAM_SMB3_Level_SublevelLevelDataLo+$01
!RAM_SMB3_Level_SublevelLevelDataBank = !RAM_SMB3_Level_SublevelLevelDataLo+$02
!RAM_SMB3_Level_SublevelSpriteDataLo = $001E01
!RAM_SMB3_Level_SublevelSpriteDataHi = !RAM_SMB3_Level_SublevelSpriteDataLo+$01
!RAM_SMB3_Level_SublevelSpriteDataBank = !RAM_SMB3_Level_SublevelSpriteDataLo+$02
!RAM_SMB3_Level_ItemMemoryBits = $001E04
!RAM_SMB3_Global_CardFlipGameCardContentsTable = $001E84
!RAM_SMB3_Global_Map16FloorTileAttributeTable = $001E96
!RAM_SMB3_Global_Map16WallTileAttributeTable = !RAM_SMB3_Global_Map16FloorTileAttributeTable+$04

!RAM_SMB3_Level_DisableScrollingFlag = $001EB8
!RAM_SMB3_Level_PreviousTilesetFromHeader = $001EB9
!RAM_SMB3_Level_SublevelTilesetFromHeader = $001EBA
!RAM_SMB3_Level_PreviousLevelDataLo = $001EBB
!RAM_SMB3_Level_PreviousLevelDataHi = !RAM_SMB3_Level_PreviousLevelDataLo+$01
!RAM_SMB3_Level_PreviousLevelDataBank = !RAM_SMB3_Level_PreviousLevelDataLo+$02

!RAM_SMB3_Level_GraphicsAndPaletteSettingFromHeader = $001EBF

!RAM_SMB3_Overworld_OWSpr_InitialYPosLo = $001EED
!RAM_SMB3_Overworld_OWSpr_InitialXPosLo = $001EFB
!RAM_SMB3_Overworld_OWSpr_InitialXPosHi = $001F09
!RAM_SMB3_Overworld_OWSpr_SpriteID = $001F17

!RAM_SMB3_BattleMode_CurrentStage = $001F26

!RAM_SMB3_Level_OpenToadHouseChestFlags = $001F30

; $001F40 = P-Meter tiles on the status bar?

!RAM_SMB3_Overworld_ActiveMusicBoxFlag = $001F55
!RAM_SMB3_Level_SubscreenExitProperties = $001F56
!RAM_SMB3_Level_SubscreenExitEntranceXPosition = $001F66

!RAM_SMB3_Level_BreathSpr_MovementTimer = $001F7C
!RAM_SMB3_Level_BreathSpr_YPosHi = $001F80
!RAM_SMB3_Level_BreathSpr_YPosLo = $001F84
!RAM_SMB3_Level_BreathSpr_XPosHi = $001F88
!RAM_SMB3_Level_BreathSpr_XPosLo = $001F8C
!RAM_SMB3_Level_SplashSpr_DespawnTimer = $001F90
!RAM_SMB3_Level_SplashSpr_YPosLo = $001F93
!RAM_SMB3_Level_SplashSpr_XPosLo = $001F96
!RAM_SMB3_Level_SplashSpr_Table7E1F99 = $001F99
!RAM_SMB3_Level_MExtSpr_SpriteID = $001F9C
!RAM_SMB3_Level_MExtSpr_YPosLo = $001F9F
!RAM_SMB3_Level_MExtSpr_XPosLo = $001FA2
!RAM_SMB3_Level_MExtSpr_Table7E1FA5 = $001FA5
!RAM_SMB3_Level_MExtSpr_Table7E1FA8 = $001FA8
!RAM_SMB3_Level_MExtSpr_Table7E1FAB = $001FAB
!RAM_SMB3_Level_MExtSpr_Table7E1FAE = $001FAE
!RAM_SMB3_Level_MExtSpr_Table7E1FB1 = $001FB1
!RAM_SMB3_CoinSpr_SpriteExitsFlag = $001FB4
!RAM_SMB3_CoinSpr_YPosLo = $001FB8
!RAM_SMB3_CoinSpr_XPosLo = $001FBC
!RAM_SMB3_CoinSpr_YSpeed = $001FC0
!RAM_SMB3_CoinSpr_AnimationFrameCounter = $001FC4
!RAM_SMB3_Level_ExtSpr_SpriteID = $001FC8
; $001FE9 = Normal sprite tile properties table
!RAM_SMB3_Level_NorSpr_Table7E1FD2 = $001FD2
!RAM_SMB3_Level_ExtSpr_YPosHi = $001FD7

!RAM_SMB3_SlidingPictureGame_NumberOfLivesToAward = $001FF9

!RAM_SMB3_Global_LevelDataMap16Lo = $7E2000

!RAM_SMB3_Overworld_AutoMoveWhenDirectionHeldTimer = $7E3950

!RAM_SMB3_Overworld_OWSpr_HammerBroPrizeTable = $7E3956
!RAM_SMB3_Level_CurrentMiniChestPrize = $7E3963
!RAM_SMB3_Overworld_CurrentMiniChestPrize = $7E3964
!RAM_SMB3_Overworld_UsedReserveAnchorFlag = $7E396F
!RAM_SMB3_Overworld_DontDestroyEnteredSpriteFlag = $7E3972

!RAM_SMB3_SpadeGame_CurrentDiceRoll = $7E3991

;!RAM_SMB3_Global_LevelDataMap16Hi = !RAM_SMB3_Global_LevelDataMap16Lo+$7000		; Todo: This is a guess

!RAM_SMB3_WorldRollcall_Layer1World1To4Tilemap = $7E6000
!RAM_SMB3_WorldRollcall_Layer1World5To8Tilemap = !RAM_SMB3_WorldRollcall_Layer1World1To4Tilemap+$2000

!RAM_SMB3_BattleMode_Mode2ScreenScrollFrameIndexLo = $7F3000
!RAM_SMB3_BattleMode_Mode2ScreenScrollFrameIndexHi = !RAM_SMB3_BattleMode_Mode2ScreenScrollFrameIndexLo+$01

!RAM_SMB3_BattleMode_Mode2ScreenScrollVRAMAddressLo = $7F3004
!RAM_SMB3_BattleMode_Mode2ScreenScrollVRAMAddressHi = !RAM_SMB3_BattleMode_Mode2ScreenScrollVRAMAddressLo+$01
!RAM_SMB3_BattleMode_Mode2ScreenScrollDataSizeLo = $7F3006
!RAM_SMB3_BattleMode_Mode2ScreenScrollDataSizeHi = !RAM_SMB3_BattleMode_Mode2ScreenScrollDataSizeLo+$01
!RAM_SMB3_BattleMode_ResultsScreenTilemapVRAMAddressLo = $7F3008
!RAM_SMB3_BattleMode_ResultsScreenTilemapVRAMAddressHi = !RAM_SMB3_BattleMode_ResultsScreenTilemapVRAMAddressLo+$01
!RAM_SMB3_BattleMode_UnusedTilemapVRAMAddressLo = $7F300A
!RAM_SMB3_BattleMode_UnusedTilemapVRAMAddressHi = !RAM_SMB3_BattleMode_UnusedTilemapVRAMAddressLo+$01
!RAM_SMB3_BattleMode_ResultsScreenCursoPosLo = $7F300C
!RAM_SMB3_BattleMode_ResultsScreenCursoPosHi = !RAM_SMB3_BattleMode_ResultsScreenCursoPosLo+$01

!RAM_SMB3_BattleMode_ResultsScreenTilemapData = $7F3800
!RAM_SMB3_BattleMode_UnusedTilemapData = $7F4000

!RAM_SMB3_BattleMode_Mode2LayerScrollingDataTable = $7F5000

!RAM_SMB3_Global_WindowHDMATable1 = $7F9000
!RAM_SMB3_Global_WindowHDMATable2 = $7F9200

!RAM_SMB3_Global_DecompressionBuffer = $7FA500

!RAM_SMB3_Level_Player_CurrentPaletteDataTable = $7FC500

!RAM_SMB3_Level_PeachDoorOpenTimer = $7FC587

!RAM_SMB3_Global_InitialWorld = $7FFB00

!RAM_SMB3_Global_DisplayTitleScreenMenuOptionsIndex = $7FFC03

!RAM_SMB3_Global_FurthestReachedWorld = $7FFF02

struct SMB3_OAMBuffer !RAM_SMB3_Global_OAMBuffer
	.XDisp: skip $01
	.YDisp: skip $01
	.Tile: skip $01
	.Prop: skip $01
endstruct align $04

struct SMB3_UpperOAMBuffer !RAM_SMB3_Global_OAMBuffer+$0200
	.Slot: skip $01
endstruct align $01

struct SMB3_OAMTileSizeBuffer !RAM_SMB3_Global_OAMTileSizeBuffer
	.Slot: skip $01
endstruct

struct SMB3_StripeImageUploadTable !RAM_SMB3_Global_StripeImageUploadTable
	.LowByte: skip $01
	.HighByte: skip $01
endstruct align $02

struct SMB3_PaletteMirror !RAM_SMB3_Global_PaletteMirror
	.LowByte: skip $01
	.HighByte: skip $01
endstruct align $02

struct SMB3_IndividualPlayerData !RAM_SMB3_Global_Player_IndividualPlayerData
	.ReserveSlots: skip $1C
	.CardSlots: skip $03
	.Score: skip $03
	.CoinCount: skip $01
endstruct

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr006_VerticalBounceSprite_BounceTimer = !RAM_SMB3_Level_NorSpr_Table7E0526

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr00C_BouncingPowerUps_AnimationFrame = !RAM_SMB3_Level_NorSpr_Table7E0669

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr018_Bowser_CurrentAttackState = !RAM_SMB3_Level_NorSpr_Table7E004D
!RAM_SMB3_NorSpr018_Bowser_CurrentState = !RAM_SMB3_Level_NorSpr_Table7E0068
;!RAM_SMB3_Level_NorSpr_DecrementingTable7E0518
!RAM_SMB3_NorSpr018_Bowser_AnimationFrame = !RAM_SMB3_Level_NorSpr_Table7E0669
!RAM_SMB3_NorSpr018_Bowser_AttackPhaseTimer = !RAM_SMB3_Level_NorSpr_DecrementingTable7E06A6

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr019_FireFlower_DisableInteractionTimer = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0520

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr01E_RaccoonLeaf_FlyingOutOfBlockTimer = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0518
!RAM_SMB3_NorSpr01E_RaccoonLeaf_DisableInteractionTimer = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0520
!RAM_SMB3_NorSpr01E_RaccoonLeaf_HorizontalMovementDirection = !RAM_SMB3_Level_NorSpr_Table7E0691

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr029_Spike_HeldSpikeBallPositionIndex = !RAM_SMB3_Level_NorSpr_Table7E004D
!RAM_SMB3_NorSpr029_Spike_ThrowDecisionCounter = !RAM_SMB3_Level_NorSpr_Table7E0068
!RAM_SMB3_NorSpr029_Spike_ThrowAnimationTimer = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0518
!RAM_SMB3_NorSpr029_Spike_AnimationFrame = !RAM_SMB3_Level_NorSpr_Table7E0669

;---------------------------------------------------------------------------

!RAM_SMB3_NorSprXXX_SpikeBlowingPiranhaPlant_YOffsetOfSpikeBall = !RAM_SMB3_Level_NorSpr_Table7E0068
!RAM_SMB3_NorSprXXX_SpikeBlowingPiranhaPlant_AnimationFrame = !RAM_SMB3_Level_NorSpr_Table7E0669
!RAM_SMB3_NorSprXXX_SpikeBlowingPiranhaPlant_YAccelerationIndexOfSpikeBall = !RAM_SMB3_Level_NorSpr_Table7E0771

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr02B_KuribosShoe_WaitBeforeNextJump = !RAM_SMB3_Level_NorSpr_Table7E0068
!RAM_SMB3_NorSpr02B_KuribosShoe_AnimationFrame = !RAM_SMB3_Level_NorSpr_Table7E0669

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr02D_BossBass_HorizontalMovementDirection = !RAM_SMB3_Level_NorSpr_Table7E0068
!RAM_SMB3_NorSpr02D_BossBass_WaitBeforeRespawningEnemy = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0518
!RAM_SMB3_NorSpr02D_BossBass_FinAnimationCounter = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0520
!RAM_SMB3_NorSpr02D_BossBass_AnimationFrame = !RAM_SMB3_Level_NorSpr_Table7E0669
!RAM_SMB3_NorSpr02D_BossBass_PlayerHasBeenEatenFlag = !RAM_SMB3_Level_NorSpr_Table7E1021

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr02E_ElevatorPlatform_IsRisingFlag = !RAM_SMB3_Level_NorSpr_Table7E0068

;---------------------------------------------------------------------------

!RAM_SMB3_NorSprXXX_Nipper_HopAroundFlag = !RAM_SMB3_Level_NorSpr_Table7E004D
!RAM_SMB3_NorSprXXX_Nipper_HopAroundTimer = !RAM_SMB3_Level_NorSpr_Table7E0068
!RAM_SMB3_NorSprXXX_Nipper_WaitBeforeHoppingAgainTimer = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0518
!RAM_SMB3_NorSprXXX_Nipper_AnimationFrame = !RAM_SMB3_Level_NorSpr_Table7E0669

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr034_ToadHouseToad_CurrentState = !RAM_SMB3_Level_NorSpr_Table7E004D
!RAM_SMB3_NorSpr034_ToadHouseToad_MessageToDisplay = !RAM_SMB3_Level_NorSpr_Table7E0068
!RAM_SMB3_NorSpr034_ToadHouseToad_WaitBeforeWritingNextLetter = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0518

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr035_ToadHouseChestItem_OpenReserveBoxFlag = !RAM_SMB3_Level_NorSpr_Table7E004D
!RAM_SMB3_NorSpr035_ToadHouseChestItem_WaitBeforeExitingLevelTimer = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0518
!RAM_SMB3_NorSpr035_ToadHouseChestItem_ItemToGive = !RAM_SMB3_Level_NorSpr_Table7E0669
!RAM_SMB3_NorSpr035_ToadHouseChestItem_ReserveBoxSlotIndex = !RAM_SMB3_Level_NorSpr_Table7E0689
!RAM_SMB3_NorSpr035_ToadHouseChestItem_ReserveBoxPageIndex = !RAM_SMB3_Level_NorSpr_Table7E0691

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr03D_FireBreathingNipper_AnimationFrame = !RAM_SMB3_Level_NorSpr_Table7E0669

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr03E_BuoyantPlatform_PlayerWeightIndex = !RAM_SMB3_Level_NorSpr_Table7E004D
!RAM_SMB3_NorSpr03E_BuoyantPlatform_YDispFromInitialYPos = !RAM_SMB3_Level_NorSpr_Table7E0068

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr03F_DryBones_CollapsedAnimationFrame = !RAM_SMB3_Level_NorSpr_Table7E0068
!RAM_SMB3_NorSpr03F_DryBones_StunTimer = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0518
!RAM_SMB3_NorSpr03F_DryBones_WalkingAnimationFrame = !RAM_SMB3_Level_NorSpr_Table7E0669

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr040_BusterBeetle_HeldBlockPositionIndex = !RAM_SMB3_Level_NorSpr_Table7E004D
!RAM_SMB3_NorSpr040_BusterBeetle_HoldingBlockFlag = !RAM_SMB3_Level_NorSpr_Table7E0068
!RAM_SMB3_NorSpr040_BusterBeetle_ThrowAnimationTimer = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0518
!RAM_SMB3_NorSpr040_BusterBeetle_PickupBlockAnimationTimer = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0520
!RAM_SMB3_NorSpr040_BusterBeetle_AnimationFrame = !RAM_SMB3_Level_NorSpr_Table7E0669

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr048_MiniBossBass_SwimTimer = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0518
!RAM_SMB3_NorSpr048_MiniBossBass_AnimationFrame = !RAM_SMB3_Level_NorSpr_Table7E0669
!RAM_SMB3_NorSpr048_MiniBossBass_SpriteSlotOfParent = !RAM_SMB3_Level_NorSpr_Table7E0689

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr04A_GoalSphere_HasBeenCollectedFlag = !RAM_SMB3_Level_NorSpr_Table7E0068
!RAM_SMB3_NorSpr04A_GoalSphere_WaitBeforeFadeout = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0518
!RAM_SMB3_NorSpr04A_GoalSphere_AnimationFrame = !RAM_SMB3_Level_NorSpr_Table7E0669

;---------------------------------------------------------------------------

!RAM_SMB3_NorSprXXX_BoomBoom_CurrentState = !RAM_SMB3_Level_NorSpr_Table7E0068
!RAM_SMB3_NorSprXXX_BoomBoom_DeathFlashingTimer = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0518
!RAM_SMB3_NorSprXXX_BoomBoom_StunnedTimer = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0520
!RAM_SMB3_NorSprXXX_BoomBoom_AnimationFrame = !RAM_SMB3_Level_NorSpr_Table7E0669
!RAM_SMB3_NorSprXXX_BoomBoom_WaitBeforeCrouchSliding = !RAM_SMB3_Level_NorSpr_Table7E0689
!RAM_SMB3_NorSprXXX_BoomBoom_DontSlideTowardsPlayerFlag = !RAM_SMB3_Level_NorSpr_Table7E0691
!RAM_SMB3_NorSprXXX_BoomBoom_FlashingTimer = !RAM_SMB3_Level_NorSpr_Table7E0769
!RAM_SMB3_NorSprXXX_BoomBoom_CrouchDownTimer = !RAM_SMB3_Level_NorSpr_Table7E0771
!RAM_SMB3_NorSprXXX_BoomBoom_WaitBeforeHighJump = !RAM_SMB3_Level_NorSpr_Table7E1021
!RAM_SMB3_NorSprXXX_BoomBoom_CurrentFlyingState = !RAM_SMB3_Level_NorSpr_Table7E1CD7
!RAM_SMB3_NorSprXXX_BoomBoom_WaitBeforeSwooping = !RAM_SMB3_Level_NorSpr_Table7E1CDC
!RAM_SMB3_NorSprXXX_BoomBoom_AnimationFrameCounter = !RAM_SMB3_Level_NorSpr_Table7E1FD2

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr053_UpsideDownPodoboo_InitialYPosHi = !RAM_SMB3_Level_NorSpr_Table7E004D
!RAM_SMB3_NorSpr053_UpsideDownPodoboo_InitialYPosLo = !RAM_SMB3_Level_NorSpr_Table7E0068
!RAM_SMB3_NorSpr053_UpsideDownPodoboo_WaitBeforeNextJump = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0518
!RAM_SMB3_NorSpr053_UpsideDownPodoboo_AnimationFrame = !RAM_SMB3_Level_NorSpr_Table7E0669

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr054_DonutBlock_ShakingTimer = !RAM_SMB3_Level_NorSpr_Table7E0068
!RAM_SMB3_NorSpr054_DonutBlock_IsFallingFlag = !RAM_SMB3_Level_NorSpr_Table7E1021

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr058_FireChomp_WaitBeforeExplosionTimer = !RAM_SMB3_Level_NorSpr_Table7E004D
!RAM_SMB3_NorSpr058_FireChomp_PrepareToSpitFireballTimer = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0518
!RAM_SMB3_NorSpr058_FireChomp_AnimationFrame = !RAM_SMB3_Level_NorSpr_Table7E0669
!RAM_SMB3_NorSpr058_FireChomp_MoveAroundTimer = !RAM_SMB3_Level_NorSpr_Table7E0691
!RAM_SMB3_NorSpr058_FireChomp_NumberOfTrailingFireballs = !RAM_SMB3_Level_NorSpr_Table7E1021
!RAM_SMB3_NorSpr058_FireChomp_MovementFrameCounter = !RAM_SMB3_Level_NorSpr_Table7E1FD2

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr05C_ThrowBlock_DespawnTimer = !RAM_SMB3_Level_NorSpr_DecrementingTable7E06A6

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr05D_Whirlwind_DespawnTimer = !RAM_SMB3_Level_NorSpr_Table7E004D
!RAM_SMB3_NorSpr05D_Whirlwind_SuctionDirection = !RAM_SMB3_Level_NorSpr_Table7E0679
!RAM_SMB3_NorSpr05D_Whirlwind_PlayerYAcceleration = !RAM_SMB3_Level_NorSpr_Table7E0771
!RAM_SMB3_NorSpr05D_Whirlwind_PlayerStuckInWhirlwindFlag = !RAM_SMB3_Level_NorSpr_Table7E1FD2

;---------------------------------------------------------------------------

!RAM_SMB3_NorSprXXX_Blooper_CurrentMovementState = !RAM_SMB3_Level_NorSpr_Table7E0068
!RAM_SMB3_NorSprXXX_Blooper_WaitBeforeShootingMiniBloopers = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0518
!RAM_SMB3_NorSprXXX_Blooper_SpawnNewMiniBlooperTimer = !RAM_SMB3_Level_NorSpr_Table7E0691
!RAM_SMB3_NorSprXXX_Blooper_FlashingTimer = !RAM_SMB3_Level_NorSpr_Table7E0769
!RAM_SMB3_NorSprXXX_Blooper_NumberOfTrailingMiniBloopers = !RAM_SMB3_Level_NorSpr_Table7E1021

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr063_BigBertha_SwimmingAnimationCounter = !RAM_SMB3_Level_NorSpr_Table7E0068
!RAM_SMB3_NorSpr063_BigBertha_OpenMouthTimer = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0518
!RAM_SMB3_NorSpr063_BigBertha_DelayOpeningMouthAgainTimer = !RAM_SMB3_Level_NorSpr_DecrementingTable7E06A6
!RAM_SMB3_NorSpr063_BigBertha_HorizontalMovementDirection = !RAM_SMB3_Level_NorSpr_Table7E1021
!RAM_SMB3_NorSpr063_BigBertha_InitialXPosLo = !RAM_SMB3_Level_NorSpr_Table7E1CC8
!RAM_SMB3_NorSpr063_BigBertha_InitialXPosHi = !RAM_SMB3_Level_NorSpr_Table7E1CCD

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr067_LavaLotus_FireballIndex = !RAM_SMB3_Level_NorSpr_Table7E004D
!RAM_SMB3_NorSpr067_LavaLotus_FireballSpawnTimer = !RAM_SMB3_Level_NorSpr_Table7E0068
!RAM_SMB3_NorSpr067_LavaLotus_AnimationFrame = !RAM_SMB3_Level_NorSpr_Table7E0669

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr06B_JumpingFakeBrick_JumpingAnimationTimer = !RAM_SMB3_Level_NorSpr_Table7E0068
!RAM_SMB3_NorSpr06B_JumpingFakeBrick_WaitBeforeJumpingAgainTimer = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0518

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr073_HoppingRedGoomba_HopCounter = !RAM_SMB3_Level_NorSpr_Table7E004D
!RAM_SMB3_NorSpr073_HoppingRedGoomba_TurnAroundTimer = !RAM_SMB3_Level_NorSpr_Table7E0068
!RAM_SMB3_NorSpr073_HoppingRedGoomba_WaitBeforeNext4Hops = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0518
!RAM_SMB3_NorSpr073_HoppingRedGoomba_AnimationFrame = !RAM_SMB3_Level_NorSpr_Table7E0669
!RAM_SMB3_NorSpr073_HoppingRedGoomba_WingAnimationFrameCounter = !RAM_SMB3_Level_NorSpr_Table7E1FD2

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr074_Paragoomba_CurrentState = !RAM_SMB3_Level_NorSpr_Table7E004D
!RAM_SMB3_NorSpr074_Paragoomba_TurnAroundOnGroundTimer = !RAM_SMB3_Level_NorSpr_Table7E0068
!RAM_SMB3_NorSpr074_Paragoomba_VerticalMovementTimer = !RAM_SMB3_Level_NorSpr_Table7E0068
!RAM_SMB3_NorSpr074_Paragoomba_PhaseTimer = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0518
!RAM_SMB3_NorSpr074_Paragoomba_AnimationFrame = !RAM_SMB3_Level_NorSpr_Table7E0669
!RAM_SMB3_NorSpr074_Paragoomba_TurnAroundInAirTimer = !RAM_SMB3_Level_NorSpr_Table7E0691
!RAM_SMB3_NorSpr074_Paragoomba_WingAnimationFrameCounter = !RAM_SMB3_Level_NorSpr_Table7E1FD2

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr081_HammerBro_WalkingFrameCounter = !RAM_SMB3_Level_NorSpr_Table7E004D
!RAM_SMB3_NorSpr081_HammerBro_HorizontalMovementTimer = !RAM_SMB3_Level_NorSpr_Table7E0068
!RAM_SMB3_NorSpr081_HammerBro_ThrowAnimationTimer = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0518
!RAM_SMB3_NorSpr081_HammerBro_PassThroughGroundTimer = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0520
!RAM_SMB3_NorSpr081_HammerBro_AnimationFrame = !RAM_SMB3_Level_NorSpr_Table7E0669
!RAM_SMB3_NorSpr081_HammerBro_WaitBeforeJumping = !RAM_SMB3_Level_NorSpr_DecrementingTable7E06A6
!RAM_SMB3_NorSpr081_HammerBro_WaitBeforeReadyingHammer = !RAM_SMB3_Level_NorSpr_Table7E0771

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr082_BoomerangBro_WalkingFrameCounter = !RAM_SMB3_Level_NorSpr_Table7E004D
!RAM_SMB3_NorSpr082_BoomerangBro_CurrentState = !RAM_SMB3_Level_NorSpr_Table7E0068
!RAM_SMB3_NorSpr082_BoomerangBro_ThrowAnimationTimer = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0518
!RAM_SMB3_NorSpr082_BoomerangBro_PhaseTimer = !RAM_SMB3_Level_NorSpr_DecrementingTable7E06A6
!RAM_SMB3_NorSpr082_BoomerangBro_WaitBeforeReadyingBoomerang = !RAM_SMB3_Level_NorSpr_Table7E0771

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr083_Lakitu_HorizontalMovementDirection = !RAM_SMB3_Level_NorSpr_Table7E0068
!RAM_SMB3_NorSpr083_Lakitu_PreparingToThrowTimer = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0518
!RAM_SMB3_NorSpr083_Lakitu_InitialYPosHi = !RAM_SMB3_Level_NorSpr_Table7E0776
!RAM_SMB3_NorSpr083_Lakitu_InitialYPosLo = !RAM_SMB3_Level_NorSpr_Table7E077B
!RAM_SMB3_NorSpr083_Lakitu_FrameCounter = !RAM_SMB3_Level_NorSpr_Table7E1FD2

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr084_RedSpinyEgg_AnimationFrame = !RAM_SMB3_Level_NorSpr_Table7E0669

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr086_SledgeBro_CurrentState = !RAM_SMB3_Level_NorSpr_Table7E004D
!RAM_SMB3_NorSpr086_SledgeBro_IsJumpingFlag = !RAM_SMB3_Level_NorSpr_Table7E0068
!RAM_SMB3_NorSpr086_SledgeBro_ThrowAnimationTimer = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0518
!RAM_SMB3_NorSpr086_SledgeBro_StunPlayerTimer = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0520
!RAM_SMB3_NorSpr086_SledgeBro_AnimationFrame = !RAM_SMB3_Level_NorSpr_Table7E0669
!RAM_SMB3_NorSpr086_SledgeBro_PhaseTimer = !RAM_SMB3_Level_NorSpr_Table7E0689
!RAM_SMB3_NorSpr086_SledgeBro_DisplaySmokeTimer = !RAM_SMB3_Level_NorSpr_Table7E0691
!RAM_SMB3_NorSpr086_SledgeBro_WalkingFrameCounter = !RAM_SMB3_Level_NorSpr_Table7E1FD2

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr087_FireBro_CurrentState = !RAM_SMB3_Level_NorSpr_Table7E004D
!RAM_SMB3_NorSpr087_FireBro_IsJumpingFlag = !RAM_SMB3_Level_NorSpr_Table7E0068
!RAM_SMB3_NorSpr087_FireBro_SpitAnimationTimer = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0518
!RAM_SMB3_NorSpr087_FireBro_AnimationFrame = !RAM_SMB3_Level_NorSpr_Table7E0669
!RAM_SMB3_NorSpr087_FireBro_PhaseTimer = !RAM_SMB3_Level_NorSpr_Table7E0689
!RAM_SMB3_NorSpr087_FireBro_WaitBeforeJumpingTimer = !RAM_SMB3_Level_NorSpr_Table7E0771
!RAM_SMB3_NorSpr087_FireBro_WaitBeforeSpitting = !RAM_SMB3_Level_NorSpr_Table7E1021
!RAM_SMB3_NorSpr087_FireBro_WalkingFrameCounter = !RAM_SMB3_Level_NorSpr_Table7E1FD2

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr088_YellowWavyCheepCheep_VerticalMovementDirection = !RAM_SMB3_Level_NorSpr_Table7E004D
!RAM_SMB3_NorSpr088_YellowWavyCheepCheep_AnimationFrameCounter = !RAM_SMB3_Level_NorSpr_Table7E0068
!RAM_SMB3_NorSpr088_YellowWavyCheepCheep_AnimationFrame = !RAM_SMB3_Level_NorSpr_Table7E0669

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr08A_NormalThwomp_InitialYPosLo = !RAM_SMB3_Level_NorSpr_Table7E004D
!RAM_SMB3_NorSpr08A_NormalThwomp_CurrentState = !RAM_SMB3_Level_NorSpr_Table7E0068
!RAM_SMB3_NorSpr08A_NormalThwomp_WaitBeforeRising = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0518
!RAM_SMB3_NorSpr08A_NormalThwomp_DisplaySmokeTimer = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0520

;---------------------------------------------------------------------------

!RAM_SMB3_NorSprXXX_SidewaysMovingThwomp_InitialXPosLo = !RAM_SMB3_Level_NorSpr_Table7E004D
!RAM_SMB3_NorSprXXX_SidewaysMovingThwomp_CurrentState = !RAM_SMB3_Level_NorSpr_Table7E0068
!RAM_SMB3_NorSprXXX_SidewaysMovingThwomp_PhaseTimer = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0518
!RAM_SMB3_NorSprXXX_SidewaysMovingThwomp_XSpeedIndex = !RAM_SMB3_Level_NorSpr_Table7E1021

;---------------------------------------------------------------------------

!RAM_SMB3_NorSprXXX_FixedMovementThwomp_CurrentState = !RAM_SMB3_Level_NorSpr_Table7E0068
!RAM_SMB3_NorSprXXX_FixedMovementThwomp_PhaseTimer = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0518

---------------------------------------------------------------------------

!RAM_SMB3_NorSprXXX_RotatingPeaPlatform_CurrentRotationState = !RAM_SMB3_Level_NorSpr_Table7E004D
!RAM_SMB3_NorSprXXX_RotatingPeaPlatform_AngularSpeed = !RAM_SMB3_Level_NorSpr_Table7E0068
!RAM_SMB3_NorSprXXX_RotatingPeaPlatform_PhaseTimer = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0518
!RAM_SMB3_NorSprXXX_RotatingPeaPlatform_ = !RAM_SMB3_Level_NorSpr_Table7E1021

---------------------------------------------------------------------------

!RAM_SMB3_NorSprXXX_GiantQuestionMarkBlock_NumberOfItemsToSpawn = !RAM_SMB3_Level_NorSpr_Table7E0068
!RAM_SMB3_NorSprXXX_GiantQuestionMarkBlock_AnimationFrame = !RAM_SMB3_Level_NorSpr_Table7E0669

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr09E_Podoboo_InitialYPosHi = !RAM_SMB3_Level_NorSpr_Table7E004D
!RAM_SMB3_NorSpr09E_Podoboo_InitialYPosLo = !RAM_SMB3_Level_NorSpr_Table7E0068
!RAM_SMB3_NorSpr09E_Podoboo_WaitBeforeNextJump = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0518
!RAM_SMB3_NorSpr09E_Podoboo_AnimationFrame = !RAM_SMB3_Level_NorSpr_Table7E0669
!RAM_SMB3_NorSpr09E_Podoboo_AnimationFrameCounter = !RAM_SMB3_Level_NorSpr_Table7E0691
!RAM_SMB3_NorSpr09E_Podoboo_ExtendYSpeedTimer = !RAM_SMB3_Level_NorSpr_DecrementingTable7E06A6

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr09F_Parabuzzy_AnimationFrame = !RAM_SMB3_Level_NorSpr_Table7E0669
!RAM_SMB3_NorSpr09F_Parabuzzy_AnimationFrameCounter = !RAM_SMB3_Level_NorSpr_Table7E1FD2

;---------------------------------------------------------------------------

!RAM_SMB3_NorSprXXX_OutlinePlatform_MovementDirection = !RAM_SMB3_Level_NorSpr_Table7E004D
!RAM_SMB3_NorSprXXX_OutlinePlatform_DespawnTimer = !RAM_SMB3_Level_NorSpr_Table7E0068
!RAM_SMB3_NorSprXXX_OutlinePlatform_SwitchDirectionTimer = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0518

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr0AD_RockyWrench_CurrentState = !RAM_SMB3_Level_NorSpr_Table7E0068
!RAM_SMB3_NorSpr0AD_RockyWrench_PhaseTimer = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0518
!RAM_SMB3_NorSpr0AD_RockyWrench_AnimationFrame = !RAM_SMB3_Level_NorSpr_Table7E0669

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr0AE_MetalLugnut_DetachedFromBoltFlag = !RAM_SMB3_Level_NorSpr_Table7E0068
!RAM_SMB3_NorSpr0AE_MetalLugnut_PlayerIsOnSpriteTimer = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0518
!RAM_SMB3_NorSpr0AE_MetalLugnut_AnimationFrame = !RAM_SMB3_Level_NorSpr_Table7E0669
!RAM_SMB3_NorSpr0AE_MetalLugnut_SpinningAnimationSpeed = !RAM_SMB3_Level_NorSpr_Table7E1021

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr0AF_AngrySun_SpinningTimer = !RAM_SMB3_Level_NorSpr_DecrementingTable7E0518
!RAM_SMB3_NorSpr0AF_AngrySun_CurrentState = !RAM_SMB3_Level_NorSpr_Table7E1021

;---------------------------------------------------------------------------

!RAM_SMB3_ExtSpr14_MiniBlooper_HorizontalMovementDirection = !RAM_SMB3_Level_ExtSpr_Table7E06BD
!RAM_SMB3_ExtSpr14_MiniBlooper_VerticalMovementDirection = !RAM_SMB3_Level_ExtSpr_Table7E06C7
!RAM_SMB3_ExtSpr14_MiniBlooper_DespawnTimer = !RAM_SMB3_Level_ExtSpr_Table7E06D1

;---------------------------------------------------------------------------

!RAM_SMB3_OWSpr02_Airship_FacingDirection = !RAM_SMB3_Level_NorSpr_Table7E052D

;---------------------------------------------------------------------------

!RAM_SMB3_OWSprXX_BroEnemy_FacingDirection = !RAM_SMB3_Level_NorSpr_Table7E052D

;---------------------------------------------------------------------------

!RAM_SMB3_BattleNorSpr03_FighterFly_FreezeAllMovementTimer = !RAM_SMB3_BattleNorSpr_DecrementingTable7E18E9

;---------------------------------------------------------------------------

!RAM_SMB3_BattleNorSpr02_Crab_IsAngryFlag = !RAM_SMB3_BattleNorSpr_Table7E1953

;---------------------------------------------------------------------------

;Standalone ROM specific RAM addresses
!RAM_SMB3_TitleScreen_EraseFileProcess = $000020
!RAM_SMB3_SplashScreen_DisplayTimer = $000021
	!RAM_SMB3_TitleScreen_FileAMaxWorld = $000021
!RAM_SMB3_SplashScreen_PaletteAnimationTimer = $000022
	!RAM_SMB3_TitleScreen_FileBMaxWorld = !RAM_SMB3_TitleScreen_FileAMaxWorld+$01
!RAM_SMB3_SplashScreen_PaletteAnimationIndex =  !RAM_SMB3_SplashScreen_PaletteAnimationTimer+$01
	!RAM_SMB3_TitleScreen_FileCMaxWorld = !RAM_SMB3_TitleScreen_FileAMaxWorld+$02
!RAM_SMB3_SplashScreen_DisplayMarioCoinShineFlag = $000024
	!RAM_SMB3_TitleScreen_FileSelectProcess = $000024
!RAM_SMB3_TitleScreen_FileASelectedWorld = $000025
!RAM_SMB3_TitleScreen_FileBSelectedWorld = !RAM_SMB3_TitleScreen_FileASelectedWorld+$01
!RAM_SMB3_TitleScreen_FileCSelectedWorld = !RAM_SMB3_TitleScreen_FileASelectedWorld+$02
!RAM_SMB3_ErrorScreen_PaletteMirror = $000200						; Note: This must be set to $000200 or else problems may occur
!RAM_SMB3_ErrorScreen_TextTilemap = $000800

struct SMB3_ErrorScreen_TextTilemap !RAM_SMB3_ErrorScreen_TextTilemap
	.Row: skip $40
endstruct

struct SMB3_ErrorScreen_PaletteMirror !RAM_SMB3_ErrorScreen_PaletteMirror
	.LowByte: skip $01
	.HighByte: skip $01
endstruct align $02
