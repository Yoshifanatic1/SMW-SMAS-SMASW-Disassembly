; RAM Define tags:
; "Player" = RAM address associated with the player sprite in levels.
; "NorSpr" = RAM address associated with normal sprites.
; "NorSprZZ_Y" = RAM address associated with normal sprite Y of ID ZZ. Can also refer to a group of sprites if ZZ is XX.
; "GenSpr" = RAM address associated with a generator sprite.
; "Ending" = RAM address associated with the ending.
; "Level" = RAM address associated with a level function
; "WarpZone" = RAM associated wiith the warp screen wave effect or the "Warp to X World" screen
; "CharacterSelect", "GameOverScreen", "LevelPreview", "TitleScreen", "SlotMachine" "ErrorScreen" "SplashScreen" = Used on that specific screen.
; "Global" = Used anywhere or close to everywhere.

!RAM_SMB2U_Global_ScratchRAM00 = $000000
!RAM_SMB2U_Global_ScratchRAM01 = $000001
!RAM_SMB2U_Global_ScratchRAM02 = $000002
!RAM_SMB2U_Global_ScratchRAM03 = $000003
!RAM_SMB2U_Global_ScratchRAM04 = $000004
!RAM_SMB2U_Global_ScratchRAM05 = $000005
!RAM_SMB2U_Global_ScratchRAM06 = $000006
!RAM_SMB2U_Global_ScratchRAM07 = $000007
!RAM_SMB2U_Global_ScratchRAM08 = $000008
!RAM_SMB2U_Global_ScratchRAM09 = $000009
!RAM_SMB2U_Global_ScratchRAM0A = $00000A
!RAM_SMB2U_Global_ScratchRAM0B = $00000B
!RAM_SMB2U_Global_ScratchRAM0C = $00000C
!RAM_SMB2U_Global_ScratchRAM0D = $00000D
!RAM_SMB2U_Global_ScratchRAM0E = $00000E
!RAM_SMB2U_Global_ScratchRAM0F = $00000F
!RAM_SMB2U_Global_FrameCounter = $000010
!RAM_SMB2U_Global_StripeImageToUpload = $000011
!RAM_SMB2U_NorSpr_CurrentSlotID = $000012

; $000014-$00008F
;--------------------------------------------------------------------

; Level:
!RAM_SMB2U_Player_XPosHi = $000014
!RAM_SMB2U_NorSpr_XPosHi = !RAM_SMB2U_Player_XPosHi+$01				; $000015
!RAM_SMB2U_Player_YPosHi = !RAM_SMB2U_Player_XPosHi+$0A				; $00001E
!RAM_SMB2U_NorSpr_YPosHi = !RAM_SMB2U_Player_YPosHi+$01				; $00001F
!RAM_SMB2U_Player_XPosLo = $000028
!RAM_SMB2U_NorSpr_XPosLo = !RAM_SMB2U_Player_XPosLo+$01				; $000029
!RAM_SMB2U_Player_YPosLo = !RAM_SMB2U_Player_XPosLo+$0A				; $000032
!RAM_SMB2U_NorSpr_YPosLo = !RAM_SMB2U_Player_YPosLo+$01				; $000033
!RAM_SMB2U_Player_XSpeed = $00003C
!RAM_SMB2U_NorSpr_XSpeed = !RAM_SMB2U_Player_XSpeed+$01				; $00003D
!RAM_SMB2U_Player_YSpeed = !RAM_SMB2U_Player_XSpeed+$0A				; $000046
!RAM_SMB2U_NorSpr_YSpeed = !RAM_SMB2U_Player_YSpeed+$01				; $000047
!RAM_SMB2U_Player_CurrentState = $000050
!RAM_SMB2U_NorSpr_CurrentStatus = $000051

; $00005A = Player tile collision flags?

; $000064 = Player tile properties?
!RAM_SMB2U_NorSpr_PropertyBits0065 = $000065
!RAM_SMB2U_NorSpr_Table7E006F = $00006F
	!RAM_SMB2U_NorSpr_FacingDirection = !RAM_SMB2U_NorSpr_Table7E006F
!RAM_SMB2U_NorSpr_Table7E0079 = $000079
	!RAM_SMB2U_NorSpr_DontClingToBirdoFlag = $000079
!RAM_SMB2U_Player_PickupAnimationTimer = $000082
	!RAM_SMB2U_Player_InHawkmouthTimer = !RAM_SMB2U_Player_PickupAnimationTimer
!RAM_SMB2U_Player_WalkingFrameTimer = $000084
!RAM_SMB2U_Player_HurtTimer = $000085
!RAM_SMB2U_NorSpr_DecrementingTable7E0086 = !RAM_SMB2U_Player_HurtTimer+$01
	!RAM_SMB2U_NorSprStatus03_DrawCrumblingRock_DespawnTimer = !RAM_SMB2U_NorSpr_DecrementingTable7E0086
	!RAM_SMB2U_NorSprStatus04_Explosion_DespawnTimer = !RAM_SMB2U_NorSpr_DecrementingTable7E0086
	!RAM_SMB2U_NorSprStatus05_SmokePuff_DespawnTimer = !RAM_SMB2U_NorSpr_DecrementingTable7E0086
	!RAM_SMB2U_NorSprStatus06_DrawDugUpSand_DespawnTimer = !RAM_SMB2U_NorSpr_DecrementingTable7E0086
	!RAM_SMB2U_NorSprStatus07_SinkInQuicksand_DespawnTimer = !RAM_SMB2U_NorSpr_DecrementingTable7E0086
	!RAM_SMB2U_NorSprStatus08_DrawPOWBlockSmoke_DespawnTimer = !RAM_SMB2U_NorSprStatus03_DrawCrumblingRock_DespawnTimer
	!RAM_SMB2U_NorSprStatus09_DrawDeadMiniFryguy_DespawnTimer = !RAM_SMB2U_NorSpr_DecrementingTable7E0086

; SlotMachine:
!RAM_SMB2U_SlotMachine_LeftReelState = $000029
!RAM_SMB2U_SlotMachine_MiddleReelState = !RAM_SMB2U_SlotMachine_LeftReelState+$01
!RAM_SMB2U_SlotMachine_RightReelState = !RAM_SMB2U_SlotMachine_LeftReelState+$02
!RAM_SMB2U_SlotMachine_LeftReelContents = $00002F
!RAM_SMB2U_SlotMachine_MiddleReelContents = !RAM_SMB2U_SlotMachine_LeftReelContents+$01
!RAM_SMB2U_SlotMachine_RightReelContents = !RAM_SMB2U_SlotMachine_LeftReelContents+$02
!RAM_SMB2U_SlotMachine_ButtonPressDelay = $000032
!RAM_SMB2U_SlotMachine_All3ReelsStoppedFlag = $000033
!RAM_SMB2U_SlotMachine_LeftReel1YSpeed = $000038
!RAM_SMB2U_SlotMachine_LeftReel2YSpeed = !RAM_SMB2U_SlotMachine_LeftReel1YSpeed+$01
!RAM_SMB2U_SlotMachine_MiddleReel1YSpeed = !RAM_SMB2U_SlotMachine_LeftReel1YSpeed+$02
!RAM_SMB2U_SlotMachine_MiddleReel2YSpeed = !RAM_SMB2U_SlotMachine_LeftReel1YSpeed+$03
!RAM_SMB2U_SlotMachine_RightReel1YSpeed = !RAM_SMB2U_SlotMachine_LeftReel1YSpeed+$04
!RAM_SMB2U_SlotMachine_RightReel2YSpeed = !RAM_SMB2U_SlotMachine_LeftReel1YSpeed+$05
!RAM_SMB2U_SlotMachine_LeftReel1SubYPos = $00003E
!RAM_SMB2U_SlotMachine_LeftReel2SubYPos = !RAM_SMB2U_SlotMachine_LeftReel1SubYPos+$01
!RAM_SMB2U_SlotMachine_MiddleReel1SubYPos = !RAM_SMB2U_SlotMachine_LeftReel1SubYPos+$02
!RAM_SMB2U_SlotMachine_MiddleReel2SubYPos = !RAM_SMB2U_SlotMachine_LeftReel1SubYPos+$03
!RAM_SMB2U_SlotMachine_RightReel1SubYPos = !RAM_SMB2U_SlotMachine_LeftReel1SubYPos+$04
!RAM_SMB2U_SlotMachine_RightReel2SubYPos = !RAM_SMB2U_SlotMachine_LeftReel1SubYPos+$05
!RAM_SMB2U_SlotMachine_LeftReel1YPosLo = $000044
!RAM_SMB2U_SlotMachine_LeftReel2YPosLo = !RAM_SMB2U_SlotMachine_LeftReel1YPosLo+$01
!RAM_SMB2U_SlotMachine_MiddleReel1YPosLo = !RAM_SMB2U_SlotMachine_LeftReel1YPosLo+$02
!RAM_SMB2U_SlotMachine_MiddleReel2YPosLo = !RAM_SMB2U_SlotMachine_LeftReel1YPosLo+$03
!RAM_SMB2U_SlotMachine_RightReel1YPosLo = !RAM_SMB2U_SlotMachine_LeftReel1YPosLo+$04
!RAM_SMB2U_SlotMachine_RightReel2YPosLo = !RAM_SMB2U_SlotMachine_LeftReel1YPosLo+$05
!RAM_SMB2U_SlotMachine_LeftReel1YPosHi = $00004A
!RAM_SMB2U_SlotMachine_LeftReel2YPosHi = !RAM_SMB2U_SlotMachine_LeftReel1YPosHi+$01
!RAM_SMB2U_SlotMachine_MiddleReel1YPosHi = !RAM_SMB2U_SlotMachine_LeftReel1YPosHi+$02
!RAM_SMB2U_SlotMachine_MiddleReel2YPosHi = !RAM_SMB2U_SlotMachine_LeftReel1YPosHi+$03
!RAM_SMB2U_SlotMachine_RightReel1YPosHi = !RAM_SMB2U_SlotMachine_LeftReel1YPosHi+$04
!RAM_SMB2U_SlotMachine_RightReel2YPosHi = !RAM_SMB2U_SlotMachine_LeftReel1YPosHi+$05
!RAM_SMB2U_SlotMachine_LeftReel1Icon = $000050
!RAM_SMB2U_SlotMachine_LeftReel2Icon = !RAM_SMB2U_SlotMachine_LeftReel1Icon+$01
!RAM_SMB2U_SlotMachine_MiddleReel1Icon = !RAM_SMB2U_SlotMachine_LeftReel1Icon+$02
!RAM_SMB2U_SlotMachine_MiddleReel2Icon = !RAM_SMB2U_SlotMachine_LeftReel1Icon+$03
!RAM_SMB2U_SlotMachine_RightReel1Icon = !RAM_SMB2U_SlotMachine_LeftReel1Icon+$04
!RAM_SMB2U_SlotMachine_RightReel2Icon = !RAM_SMB2U_SlotMachine_LeftReel1Icon+$05
!RAM_SMB2U_SlotMachine_ScreenFlashTimer = $000056
!RAM_SMB2U_SlotMachine_ActivateLeftReelFlag = $000057
!RAM_SMB2U_SlotMachine_ActivateMiddleReelFlag = !RAM_SMB2U_SlotMachine_ActivateLeftReelFlag+$01
!RAM_SMB2U_SlotMachine_ActivateRightReelFlag = !RAM_SMB2U_SlotMachine_ActivateLeftReelFlag+$02


; TitleScreen
!RAM_SMB2U_TitleScreen_ClearTitleScreenFlag = $000017
!RAM_SMB2U_TitleScreen_StoryTextDisplayIndex = $000018
!RAM_SMB2U_TitleScreen_DoneDisplayingTextFlag = $000019
!RAM_SMB2U_TitleScreen_WaitBeforeDisplayingNextLineOfTextTimer = $00001A


; Ending
!RAM_SMB2U_Ending_WaitBeforeThoughtBubbleDisappears = $000014
!RAM_SMB2U_Ending_SleepingMarioAnimationFrame = $000015
!RAM_SMB2U_Ending_SleepingMarioAnimationLoopCounter = $000016
!RAM_SMB2U_Ending_ThoughtBubbleAnimationFrame = $0000017
!RAM_SMB2U_Ending_ThoughtBubbleAnimationFrameCounter = $000018
!RAM_SMB2U_Ending_TheEndTextAnimationFrame = $00001B
!RAM_SMB2U_Ending_GenericCastListTimer = $000028
!RAM_SMB2U_Ending_CastListState = $000029
!RAM_SMB2U_Ending_CastListPaletteFadeIndex = $00002A
!RAM_SMB2U_Ending_CastListSpriteIndex = $00002B
!RAM_SMB2U_Ending_CastListSpriteDataPtrLo = $00002F
!RAM_SMB2U_Ending_CastListSpriteDataPtrHi = !RAM_SMB2U_Ending_CastListSpriteDataPtrLo+$01
!RAM_SMB2U_Ending_CastListSpriteDataPtrBank = !RAM_SMB2U_Ending_CastListSpriteDataPtrLo+$02
!RAM_SMB2U_Ending_FirstPartState = $000050
!RAM_SMB2U_Ending_WaitBeforeGoingToPart2 = $000083
!RAM_SMB2U_Ending_WaitBeforeSubconExitsVase = !RAM_SMB2U_NorSpr_DecrementingTable7E0086
!RAM_SMB2U_Ending_WaitBeforeCorkIsLifted = !RAM_SMB2U_NorSpr_DecrementingTable7E0086+$08

;--------------------------------------------------------------------

!RAM_SMB2U_Player_CharacterGFXSet = $00008F
!RAM_SMB2U_NorSpr_SpriteID = $000090

!RAM_SMB2U_Player_InAirFlag = $000099
!RAM_SMB2U_Player_DuckingFlag = $00009A
!RAM_SMB2U_Player_WalkBobbingIndex = $00009B
!RAM_SMB2U_Player_CarryingSomethingFlag = $00009C
!RAM_SMB2U_Player_FacingDirection = $00009D

!RAM_SMB2U_NorSpr_Table7E009F = $00009F
!RAM_SMB2U_NorSpr_IsBeingCarriedFlag = $0000A8
!RAM_SMB2U_NorSpr_Table7E00B1 = $0000B1

!RAM_SMB2U_Level_ScreenScrollXSpeed = $0000BA

!RAM_SMB2U_Player_BasePose = $0000C7

!RAM_SMB2U_Global_CameraYPosHi = $0000CA
!RAM_SMB2U_Global_CameraYPosLo = $0000CB
!RAM_SMB2U_Level_SpriteListDataLo = $0000CC
!RAM_SMB2U_Level_SpriteListDataHi = !RAM_SMB2U_Level_SpriteListDataLo+$01

; $0000D8 = Something related to vertical scroll

; $0000E9 = Seems to be an index related to tile collision

!RAM_SMB2U_Level_IsHorizontalLevelFlag = $0000EB

!RAM_SMB2U_Level_XOffscreenSpriteFlags = $0000ED
!RAM_SMB2U_Level_YOffscreenSpriteFlag = $0000EE
; $0000EF = Empty
!RAM_SMB2U_Global_StripeImageDataLo = $0000F0
!RAM_SMB2U_Global_StripeImageDataHi = !RAM_SMB2U_Global_StripeImageDataLo+$01
!RAM_SMB2U_Global_StripeImageDataBank = !RAM_SMB2U_Global_StripeImageDataLo+$02
!RAM_SMB2U_Ending_Layer1SubconsXPosLo = $0000F3
!RAM_SMB2U_Ending_Layer1SubconsAnimationTimer = $0000F4

!RAM_SMB2U_Global_ControllerHold1 = $0000F6
!RAM_SMB2U_Global_ControllerHold2 = $0000F8
!RAM_SMB2U_Global_ControllerPress1 = $0000FA
!RAM_SMB2U_Global_ControllerPress2 = $0000FC

!RAM_SMB2U_Global_ScreenDisplayRegisteMirror = $0000FE
!RAM_SMB2U_Global_IRQNMIAndJoypadEnableFlagsMirror = $0000FF

!RAM_SMB2U_Global_EndOfStack = !RAM_SMB2U_Global_StartOfStack-$FF
	!RAM_SMB2U_Global_WaitForVBlankFlag = $000154
	!RAM_SMB2U_Global_StartOfStack = $0001FF
!RAM_SMB2U_Global_Layer1XPosLo = $000200
!RAM_SMB2U_Global_Layer1XPosHi = !RAM_SMB2U_Global_Layer1XPosLo+$01
!RAM_SMB2U_Global_Layer2XPosLo = $000202
!RAM_SMB2U_Global_Layer2XPosHi = !RAM_SMB2U_Global_Layer2XPosLo+$01
!RAM_SMB2U_Global_Layer3XPosLo = $000204
!RAM_SMB2U_Global_Layer3XPosHi = !RAM_SMB2U_Global_Layer3XPosLo+$01

!RAM_SMB2U_Global_Layer1YPosLo = $000206
!RAM_SMB2U_Global_Layer1YPosHi = !RAM_SMB2U_Global_Layer1YPosLo+$01
!RAM_SMB2U_Global_Layer2YPosLo = $000208
!RAM_SMB2U_Global_Layer2YPosHi = !RAM_SMB2U_Global_Layer2YPosLo+$01
!RAM_SMB2U_Global_Layer3YPosLo = $00020A
!RAM_SMB2U_Global_Layer3YPosHi = !RAM_SMB2U_Global_Layer3YPosLo+$01
!RAM_SMB2U_Global_P1CtrlDisableLo = $00020C
!RAM_SMB2U_Global_P1CtrlDisableHi = $00020D

!RAM_SMB2U_Global_ScratchRAM7E0210 = $000210
	!RAM_SMB2U_TitleScreen_CurrentStateTimer = !RAM_SMB2U_Global_ScratchRAM7E0210
	!RAM_SMB2U_CharacterSelect_CurrentStateTimer = !RAM_SMB2U_Global_ScratchRAM7E0210
	!RAM_SMB2U_LevelPreview_WaitBeforeFadeOut = !RAM_SMB2U_Global_ScratchRAM7E0210
	!RAM_SMB2U_Level_UnknownPauseMenuTimer = !RAM_SMB2U_Global_ScratchRAM7E0210
	!RAM_SMB2U_SlotMachine_FlashingPaletteFrameCounter = !RAM_SMB2U_Global_ScratchRAM7E0210
	!RAM_SMB2U_Ending_SleepingMarioAnimationFrameCounter = !RAM_SMB2U_Global_ScratchRAM7E0210
	!RAM_SMB2U_Ending_TheEndTextAnimationFrameCounter = !RAM_SMB2U_Global_ScratchRAM7E0210

!RAM_SMB2U_Level_FreeMovementDebugFlag = $000214

; $000218-$00021C
;--------------------------------------------------------------------

;Global
!RAM_SMB2U_Global_TileAnimationFrameCounter = $000219
!RAM_SMB2U_Global_TileAnimationFrameIndex = $00021A
!RAM_SMB2U_Global_TileAnimationSourceAddressLo = $00021B
!RAM_SMB2U_Global_TileAnimationSourceAddressHi = !RAM_SMB2U_Global_TileAnimationSourceAddressLo+$01

;Level
; $000218 = Scratch RAM?
; $000219-$00021C = Same as global
!RAM_SMB2U_Level_FrameAdvanceDebugActiveFlag = $00021D
; $00021E = Empty
!RAM_SMB2U_Level_SpriteTileXDispHi = $00021F

;--------------------------------------------------------------------

!RAM_SMB2U_Level_PauseMenuOpenCloseFrameIndex = $00022B
	; $00022B = Something related to the warp zone wave effect

!RAM_SMB2U_WarpZone_FadeDirection = $000231
!RAM_SMB2U_WarpZone_ScanlineWiggleSpeed = $000232

!RAM_SMB2U_Global_BG1And2WindowMaskSettingsMirror = $000235
!RAM_SMB2U_Global_BG3And4WindowMaskSettingsMirror = !RAM_SMB2U_Global_BG1And2WindowMaskSettingsMirror+$01
!RAM_SMB2U_Global_ObjectAndColorWindowSettingsMirror = $000237
!RAM_SMB2U_Global_ColorMathInitialSettingsMirror = $000238
!RAM_SMB2U_Global_ColorMathSelectAndEnableMirror = !RAM_SMB2U_Global_ColorMathInitialSettingsMirror+$01
!RAM_SMB2U_Global_HDMAEnableMirror = $00023A
!RAM_SMB2U_Global_MainScreenWindowMaskMirror = $00023B
!RAM_SMB2U_Global_SubScreenWindowMaskMirror = $00023C						; Note: This RAM is cleared, but never read from. It's named this because this is what it most likely was going to be used for given its placement and where it's cleared.
!RAM_SMB2U_Global_FixedColorData1Mirror = $00023D
!RAM_SMB2U_Global_FixedColorData2Mirror = $00023E
!RAM_SMB2U_Global_FixedColorData3Mirror = $00023F

!RAM_SMB2U_Global_MainScreenLayersMirror = $000243
!RAM_SMB2U_Global_SubScreenLayersMirror = !RAM_SMB2U_Global_MainScreenLayersMirror+$01

!RAM_SMB2U_Global_VCountTimerLo = $00024B
!RAM_SMB2U_Global_BG1AddressAndSize = $00024C

!RAM_SMB2U_Ending_Layer1SubconsXPosHi = $00024F

!RAM_SMB2U_Global_ConveyorBeltTileAnimationSourceAddressLo = $000252
!RAM_SMB2U_Global_ConveyorBeltTileAnimationSourceAddressHi = !RAM_SMB2U_Global_ConveyorBeltTileAnimationSourceAddressLo+$01
!RAM_SMB2U_Global_BossFlashingPaletteIndex = $000254

!RAM_SMB2U_Ending_SleepingMarioAnimationIndex = $00025E

!RAM_SMB2U_Global_UpdateEntirePaletteFlag = $0002A9

!RAM_SMB2U_Level_DisableLayer2Scroll = $0002C3
; $0002C4 = A flag that makes layer 1 transparent

!RAM_SMB3_Global_Layer2Map16DataPtrLo = $0002DF
!RAM_SMB3_Global_Layer2Map16DataPtrHi = $0002E0
!RAM_SMB3_Global_Layer2Map16DataPtrBank = $0002E1

!RAM_SMB2U_Player_TopHeadTileSourceAddressLo = $0002ED
!RAM_SMB2U_Player_TopHeadTileSourceAddressHi = !RAM_SMB2U_Player_TopHeadTileSourceAddressLo+$01
!RAM_SMB2U_Player_BottomHeadTileSourceAddressLo = $0002EF
!RAM_SMB2U_Player_BottomHeadTileSourceAddressHi = !RAM_SMB2U_Player_BottomHeadTileSourceAddressLo+$01
!RAM_SMB2U_Player_TopBodyTileSourceAddressLo = $0002F1
!RAM_SMB2U_Player_TopBodyTileSourceAddressHi = !RAM_SMB2U_Player_TopBodyTileSourceAddressLo+$01
!RAM_SMB2U_Player_BottomBodyTileSourceAddressLo = $0002F3
!RAM_SMB2U_Player_BottomBodyTileSourceAddressHi = !RAM_SMB2U_Player_BottomBodyTileSourceAddressLo+$01

!RAM_SMB2U_Level_OAMBufferIndexLo = $0002F6
!RAM_SMB2U_Level_OAMBufferIndexHi = !RAM_SMB2U_Level_OAMBufferIndexLo+$01

!RAM_SMB2U_Global_StripeImageUploadIndexLo = $000300
!RAM_SMB2U_Global_StripeImageUploadIndexHi = !RAM_SMB2U_Global_StripeImageUploadIndexLo+$01
!RAM_SMB2U_Global_StripeImageUploadTable = $000302
!RAM_SMB2U_Player_SubXPos = $000407
!RAM_SMB2U_NorSpr_SubXPos = $000408
!RAM_SMB2U_Player_SubYPos = $000411
!RAM_SMB2U_NorSpr_SubYPos = $000412
!RAM_SMB2U_Player_PlayerLocked = $00041B
!RAM_SMB2U_NorSpr_SpriteLocked = !RAM_SMB2U_Player_PlayerLocked+$01

!RAM_SMB2U_Player_OnScreenPosXLo = $000428
!RAM_SMB2U_Level_SpriteTileXDispLo = $000429
!RAM_SMB2U_Player_OnScreenPosYHi = $00042A
!RAM_SMB2U_Player_OnScreenPosYLo = $00042B
!RAM_SMB2U_Level_SpriteTileYDispLo = $00042C
!RAM_SMB2U_Player_CarriedSpriteIndex = $00042D
!RAM_SMB2U_NorSpr_HasBeenTossedTimer = $00042F
!RAM_SMB2U_NorSpr_DecrementingTable7E0438 = $000438
!RAM_SMB2U_NorSpr_SpriteListIndex = $000441
!RAM_SMB2U_NorSpr_Table7E044A = $00044A
	!RAM_SMB2U_NorSpr_DisableHorizontalMovement = !RAM_SMB2U_NorSpr_Table7E044A
!RAM_SMB2U_NorSpr_DecrementingTable7E0453 = $000453
!RAM_SMB2U_NorSpr_DecrementingTable7E045C = $00045C
	!RAM_SMB2U_NorSpr_FlashingTimer = !RAM_SMB2U_NorSpr_DecrementingTable7E045C
!RAM_SMB2U_NorSpr_Table7E0465 = $000465
!RAM_SMB2U_NorSpr_PropertyBits046E = $00046E
!RAM_SMB2U_NorSpr_Table7E0477 = $000477
!RAM_SMB2U_NorSpr_Table7E0480 = $000480
!RAM_SMB2U_NorSpr_PropertyBits0489 = $000489
!RAM_SMB2U_NorSpr_PropertyBits0492 = $000492
!RAM_SMB2U_NorSpr_IsABossFlag = $00049B

!RAM_SMB2U_NorSpr_EnemiesKilledCounter = $0004AD
; $0004AE = Some sort of level initialization flag
!RAM_SMB2U_NorSpr_SpriteToCarryThroughScreenTransition = $0004AF
!RAM_SMB2U_Player_HasUnlockedDoor = $0004B0
;Empty $0004B1
!RAM_SMB2U_Player_RidingMagicCarpetFlag = $0004B2
!RAM_SMB2U_NorSpr3C_Door_DespawnTimer = $0004B3
!RAM_SMB2U_NorSprXX_Hawkmouth_CloseMouthFlag = $0004B4
!RAM_SMB2U_NorSprXX_Hawkmouth_OpenMouthSize = $0004B5
!RAM_SMB2U_NorSprXX_Hawkmouth_WaitBeforeOpeningMouthTimer = $0004B6
!RAM_SMB2U_NorSpr3C_Door_WaitBeforeBeingKickedOutOfSubspaceTimer = $0004B7
!RAM_SMB2U_Level_DisableReadFromSpriteListTableFlag = $0004B8
!RAM_SMB2U_GenSpr_SpriteID = $0004B9

!RAM_SMB2U_Level_OrangeDoorAnimationFrameCounter = $0004BE
	!RAM_SMB2U_Level_BobOmbDoorAnimationFrameCounter = !RAM_SMB2U_Level_OrangeDoorAnimationFrameCounter
!RAM_SMB2U_Global_CameraXPosHi = $0004BF

!RAM_SMB2U_Global_CameraXPosLo = $0004C1

!RAM_SMB2U_Player_CurrentHP = $0004C3
!RAM_SMB2U_Player_NumberOfHealthUpgrades = $0004C4
!RAM_SMB2U_Level_ShakeLayer1Timer = $0004C5
!RAM_SMB2U_Level_ShakingLayer1DispYLo = $0004C6

!RAM_SMB2U_Player_HideAndFreezePlayerFlag = $0004C8

!RAM_SMB2U_Player_HoverTimer = $0004CA
!RAM_SMB2U_Player_PowerJumpCharge = $0004CB
!RAM_SMB2U_Player_XSpeedOffset = $0004CC
!RAM_SMB2U_NorSpr_XSpeedOffset = !RAM_SMB2U_Player_XSpeedOffset+$01
!RAM_SMB2U_Player_YSpeedOffset = $0004D6
!RAM_SMB2U_NorSpr_YSpeedOffset = !RAM_SMB2U_Player_YSpeedOffset+$01
!RAM_SMB2U_Player_InQuicksandDepth = $0004E0
!RAM_SMB2U_Player_StarPowerTimer = $0004E1
!RAM_SMB2U_Player_CheckpointPlayerXPosLo = $0004E2
!RAM_SMB2U_Player_CheckpointPlayerYPosLo = $0004E3
!RAM_SMB2U_Player_CheckpointPlayerOnScreenPosX = $0004E4
!RAM_SMB2U_Player_CheckpointPlayerOnScreenPosYLo = $0004E5
!RAM_SMB2U_Player_CheckpointPlayerYSpeed = $0004E6
!RAM_SMB2U_Player_CheckpointPlayerState = $0004E7
!RAM_SMB2U_Player_CheckpointLevel = $0004E8
!RAM_SMB2U_Player_CheckpointSublevel = !RAM_SMB2U_Player_CheckpointLevel+$01
!RAM_SMB2U_Player_CheckpointScreen = !RAM_SMB2U_Player_CheckpointLevel+$02
!RAM_SMB2U_Player_CheckpointEntranceType = !RAM_SMB2U_Player_CheckpointLevel+$03

; $0004EC = Something quicksand related
!RAM_SMB2U_Level_ExitLevelAction = $0004ED			; Note: 01 = Character select. 02 = Game over. 03 = Slot machine. 04+ = Warp zone
!RAM_SMB2U_Player_CurrentLifeCount = $0004EE
!RAM_SMB2U_Player_VaseWarpType = $0004EF
!RAM_SMB2U_NorSpr_Table7E04F0 = $0004F0
!RAM_SMB2U_NorSpr2A_Fryguy_RemainingMiniFryguys = $0004F9
!RAM_SMB2U_GenSpr4A_VeggieGenerator_VeggieSpawnPosDataIndex = $0004FA
!RAM_SMB2U_Level_DisableScrollingFlag = $0004FB
!RAM_SMB2U_NorSpr3F_Mushroom_CollectedMushroom1 = $0004FC
!RAM_SMB2U_NorSpr3F_Mushroom_CollectedMushroom2 = !RAM_SMB2U_NorSpr3F_Mushroom_CollectedMushroom1+$01
!RAM_SMB2U_Level_UnusedRAM7E04FE = $0004FE

!RAM_SMB2U_NorSpr_StopWatchTimer = $000500

!RAM_SMB2U_Player_ReturnPointXPosHi = $000511
!RAM_SMB2U_Player_ReturnPointYPosHi = $000512
!RAM_SMB2U_Player_ReturnPointXPosLo = $000513
!RAM_SMB2U_Player_ReturnPointYPosLo = $000514

!RAM_SMB2U_Level_CurrentLevel = $000533
!RAM_SMB2U_Level_CurrentSublevelOfLevel = !RAM_SMB2U_Level_CurrentLevel+$01
; $000535 = Screen Number?
!RAM_SMB2U_Player_EntranceTypeToUse = !RAM_SMB2U_Level_CurrentLevel+$03

!RAM_SMB2U_Level_ScreensInLvl = $000541

; $000544 = Seems level tileset related.

!RAM_SMB2U_Player_GrabBigObjectDelayFrame6 = $000548
!RAM_SMB2U_Player_GrabBigObjectDelayFrame5 = !RAM_SMB2U_Player_GrabBigObjectDelayFrame6+$01
!RAM_SMB2U_Player_GrabBigObjectDelayFrame4 = !RAM_SMB2U_Player_GrabBigObjectDelayFrame6+$02
!RAM_SMB2U_Player_GrabBigObjectDelayFrame3 = !RAM_SMB2U_Player_GrabBigObjectDelayFrame6+$03
!RAM_SMB2U_Player_GrabBigObjectDelayFrame2 = !RAM_SMB2U_Player_GrabBigObjectDelayFrame6+$04
!RAM_SMB2U_Player_GrabBigObjectDelayFrame1 = !RAM_SMB2U_Player_GrabBigObjectDelayFrame6+$05
!RAM_SMB2U_Player_StandingJumpSpeed = !RAM_SMB2U_Player_GrabBigObjectDelayFrame6+$06
!RAM_SMB2U_Player_CarryingJumpSpeed = !RAM_SMB2U_Player_StandingJumpSpeed+$01
!RAM_SMB2U_Player_PowerJumpSpeed = !RAM_SMB2U_Player_StandingJumpSpeed+$02
!RAM_SMB2U_Player_CarryingPowerJumpJumpSpeed = !RAM_SMB2U_Player_PowerJumpSpeed+$01
!RAM_SMB2U_Player_MovingJumpSpeed = !RAM_SMB2U_Player_StandingJumpSpeed+$04
!RAM_SMB2U_Player_CarryingMovingJumpSpeed = !RAM_SMB2U_Player_MovingJumpSpeed+$01
!RAM_SMB2U_Player_QuicksandJumpYSpeed = !RAM_SMB2U_Player_GrabBigObjectDelayFrame6+$0C
!RAM_SMB2U_Player_MaxHoverTime = !RAM_SMB2U_Player_GrabBigObjectDelayFrame6+$0D
!RAM_SMB2U_Player_GravityNoHoldButton = !RAM_SMB2U_Player_GrabBigObjectDelayFrame6+$0E
!RAM_SMB2U_Player_GravityHoldButton = !RAM_SMB2U_Player_GrabBigObjectDelayFrame6+$0F
!RAM_SMB2U_Player_QuicksandJumpYAcceleration = !RAM_SMB2U_Player_GrabBigObjectDelayFrame6+$10
!RAM_SMB2U_Player_RightWalkSpeed = !RAM_SMB2U_Player_GrabBigObjectDelayFrame6+$11
!RAM_SMB2U_Player_RightCarryingWalkSpeed = !RAM_SMB2U_Player_RightWalkSpeed+$01
!RAM_SMB2U_Player_RightQuicksandWalkSpeed = !RAM_SMB2U_Player_RightWalkSpeed+$02
!RAM_SMB2U_Player_LeftWalkSpeed = !RAM_SMB2U_Player_GrabBigObjectDelayFrame6+$14
!RAM_SMB2U_Player_LeftCarryingWalkSpeed = !RAM_SMB2U_Player_LeftWalkSpeed+$01
!RAM_SMB2U_Player_LeftQuicksandWalkSpeed = !RAM_SMB2U_Player_LeftWalkSpeed+$02
;Empty $00055F

!RAM_SMB2U_Level_UnusedRAM7E0593 = $000593
!RAM_SMB2U_NorSpr3C_Door_UnusedRAM7E0594 = $000594
!RAM_SMB2U_NorSpr17_Phanto_ActivationCountdown = $000595
!RAM_SMB2U_CharacterSelect_BufferGlitchedStripeImageIndex = $000596					; Note: This could be made into freeram with a couple small changes
!RAM_SMB2U_Ending_TopContributerIDTable = $000597
!RAM_SMB2U_Ending_NumberOfTiedTopContributers = $00059B
!RAM_SMB2U_Ending_TopContributersNameDisplayLoopCounter = $00059C
!RAM_SMB2U_Ending_TopContributersNameDisplayTimer = $00059D

;Empty $00059F-$000600

!RAM_SMB2U_Player_HasCollected1UpMushroom = $000620
!RAM_SMB2U_Level_HasCollectedCoinDuringSubspaceTripCounter = $000621

!RAM_SMB2U_Level_SpawnNextGeneratedSpriteCounter = $000623

!RAM_SMB2U_Player_TeleportFlag = $000627			; Note: 01 = Set Checkpoint, 02 = Don't set checkpoint
!RAM_SMB2U_Player_InsideGenericVaseOrSubspaceFlag = $000628
; $000629 = Affects whether a hawkmouth teleports you or takes you out of a level
!RAM_SMB2U_Player_CurrentCherryCount = $00062A
!RAM_SMB2U_Player_CurrentCoinCount = $00062B
!RAM_SMB2U_Player_BigVeggiePluckedCounter = $00062C
!RAM_SMB2U_Player_MariosContributionCount = $00062D
!RAM_SMB2U_Player_PeachsContributionCount = !RAM_SMB2U_Player_MariosContributionCount+$01
!RAM_SMB2U_Player_ToadsContributionCount = !RAM_SMB2U_Player_MariosContributionCount+$02
!RAM_SMB2U_Player_LuigisContributionCount = !RAM_SMB2U_Player_MariosContributionCount+$03
!RAM_SMB2U_Ending_HighestContributionCount = $000631

!RAM_SMB2U_Level_CurrentWorld = $000635

!RAM_SMB2U_SlotMachine_PayoutStripeImageText = $000680

; $0006C2 = Flag to make player do grow animation? Also has a different function

!RAM_SMB2U_NorSpr_Table7E0702 = $000702

!RAM_SMB2U_SlotMachine_CoinPayoutCounter = $000712
!RAM_SMB2U_SlotMachine_3CoinServiceTextPaletteFrameCounter = $000713
!RAM_SMB2U_SlotMachine_3CoinServiceTextPaletteIndex = $000714

!RAM_SMB2U_Global_HandlePauseMenuGraphicsUploadFlag = $000722

!RAM_SMB2U_Global_UploadLevelPreviewGraphicsIndex = $000759

!RAM_SMB2U_Global_TileAnimationVRAMAddressLo = $000765
!RAM_SMB2U_Global_TileAnimationVRAMAddressHi = !RAM_SMB2U_Global_TileAnimationVRAMAddressLo+$01
!RAM_SMB2U_Global_TileAnimationUploadIndex = $000767

!RAM_SMB2U_Level_CurrentVaseInteriorSublevel = $00076B

!RAM_SMB2U_Level_IsAnInteriorAreaFlag = $000772

!RAM_SMB2U_Global_BGModeAndTileSizeSetting = $000775

!RAM_SMB2U_Player_DoorTypeBeingEntered = $000778
!RAM_SMB2U_Player_BobombAndBrownDoorState = $000779

!RAM_SMB2U_Level_UseCandleFlamePaletteAnimationFlag = $00077C
!RAM_SMB2U_Level_CandleFlamePaletteAnimationFrameCounter = $00077D
!RAM_SMB2U_Level_CandleFlamePaletteAnimationIndex = $00077E
!RAM_SMB2U_Level_UseGiantPhantoBGPaletteAnimationFlag = $00077F
; $000780 = Timer related to the BG Phantos
; $000781 = Timer related to the BG Phantos
!RAM_SMB2U_SlotMachine_PayoutTextBlinkingIndex = $000782
!RAM_SMB2U_SlotMachine_PayoutTextBlinkingFrameCounter = $000783
!RAM_SMB2U_Level_UseIceCrystalBGPaletteAnimationFlag = $000784
!RAM_SMB2U_Level_IceCrystalBGPaletteAnimationFrameCounter = $000785
!RAM_SMB2U_Level_IceCrystalBGPaletteAnimationIndex = $000786
!RAM_SMB2U_Level_AnimatedTileBankToUse = $000787
!RAM_SMB2U_Global_TileAnimationSourceAddressBank = $000788

!RAM_SMB2U_Level_WaitBeforeRestoringPreviousMusicTimer = $00078A 
	!RAM_SMB2U_SlotMachine_WaitBeforePlayingDrumrollEndSoundTimer = $00078A

!RAM_SMB2U_Global_BlinkingCursorPos = $00078E

!RAM_SMB2U_Global_BlinkingCursorFrameCounter = $000790
!RAM_SMB2U_Level_UseLayer3StarBGPaletteAnimationFlag = $000791

!RAM_SMB2U_SlotMachine_HasPlayedDrumrollEndSoundFlag = $00793

!RAM_SMB2U_SlotMachine_HasGiven3CoinServiceFlag = $00796
!RAM_SMB2U_SlotMachine_DelaySlowdownOfLeftReel = $000797
!RAM_SMB2U_SlotMachine_DelaySlowdownOfMiddleReel = !RAM_SMB2U_SlotMachine_DelaySlowdownOfLeftReel+$01
!RAM_SMB2U_SlotMachine_DelaySlowdownOfRightReel = !RAM_SMB2U_SlotMachine_DelaySlowdownOfLeftReel+$02
!RAM_SMB2U_SlotMachine_SpinningReelSoundFrameCounter = $00079A

; $00079E = Something related to digging up coins
!RAM_SMB2U_Ending_PauseMenuOpenFlag = $00079F
!RAM_SMB2U_Ending_DisplayPushStartFlag = $0007A0
!RAM_SMB2U_Ending_WaitBeforeDisplayingPushStartTimer = $0007A1
!RAM_SMB2U_Level_AllowPauseFlag = $0007A2
!RAM_SMB2U_Level_PreventPauseTimer = $0007A3
!RAM_SMB2U_Level_SpriteTileYDispHi = $0007A4

!RAM_SMB2U_Global_OAMBuffer = $000800
!RAM_SMB2U_Global_OAMTileSizeBuffer = $000A20

!RAM_SMB2U_Global_PaletteMirror = $000B00
!RAM_SMB2U_NorSpr_Table7E0D00 = $000D00
!RAM_SMB2U_Level_UseVaseInteriorWindowHDMAFlag = $000D0B
!RAM_SMB2U_Level_VaseInteriorWindowHDMATable = $000D0C

!RAM_SMB2U_LevelPreview_ProgressSquaresStripeImage = $001168
!RAM_SMB2U_LevelPreview_WorldNumberStripeImage = $00117A
!RAM_SMB2U_CharacterSelect_LifeCounterStripeImage = $001194
!RAM_SMB2U_WarpZone_WorldNumberStripeImage = $0011B9
!RAM_SMB2U_GameOverScreen_MenuCursorStripeImage = $0011C4

!RAM_SMB2U_NorSpr41_MagicCarpet_AccelerationTBL = $001206
!RAM_SMB2U_NorSpr_SpriteCollisionTypeTable = $00120B

; $001268 = RAM table related to Wart's graphics routine.

!RAM_SMB2U_Player_CurrentCharactersPalette = $0012D0

!RAM_SMB2U_SlotMachine_CoinAndLifeCounterStripeImageText = $001400

!RAM_SMB2U_Level_SpawningLightDoorStripeImage = $00144E

; $001A00 = Something related to generic vases.

!RAM_SMB2U_Level_SpriteListData = $001B00

!RAM_SMB2U_Global_HDMAGradientRedChannelData = $001C00
!RAM_SMB2U_Global_HDMAGradientGreenChannelData = $001C60
!RAM_SMB2U_Global_HDMAGradientBlueChannelData = $001CC0

!RAM_SMB2U_Global_HDMAGradientRedChannelScanlinesAndPtrsTable = $001D20
!RAM_SMB2U_Global_HDMAGradientGreenChannelScanlinesAndPtrsTable = $001D60
!RAM_SMB2U_Global_HDMAGradientBlueChannelScanlinesAndPtrsTable = $001DA0
!RAM_SMB2U_Global_SoundCh1 = $001DE0
!RAM_SMB2U_Global_SoundCh2 = !RAM_SMB2U_Global_SoundCh1+$01
!RAM_SMB2U_Global_MusicCh1 = !RAM_SMB2U_Global_SoundCh1+$02
!RAM_SMB2U_Global_SoundCh3 = !RAM_SMB2U_Global_SoundCh1+$03

; $001F00 = Carried sprite Y offset low while big?
; $001F01-$001F06 = Unknown/Unused?
; $001F07 = Carried sprite Y offset low while small?
; $001F08-$001F0D = Unknown/Unused?
; $001F0E = Carried sprite Y offset high while big?
; $001F0F-$001F14 = Unknown/Unused?
; $001F15 = Carried sprite Y offset high while small?
; $001F16-$001F1B = Unknown/Unused?

!RAM_SMB2U_Level_LevelDataMap16Lo = $7E2000
!RAM_SMB2U_Level_LevelDataMap16Hi = !RAM_SMB2U_Level_LevelDataMap16Lo+$7000

!RAM_SMB2U_Global_Layer2BGStripeImageUploadIndexLo = $7F0000
!RAM_SMB2U_Global_Layer2BGStripeImageUploadIndexHi = !RAM_SMB2U_Global_Layer2BGStripeImageUploadIndexLo+$01
!RAM_SMB2U_Global_Layer2TilemapStripeImageUploadTable = $7F0002
!RAM_SMB2U_Global_Layer3BGStripeImageUploadIndexLo = $7F0800
!RAM_SMB2U_Global_Layer3BGStripeImageUploadIndexHi = !RAM_SMB2U_Global_Layer3BGStripeImageUploadIndexLo+$01
!RAM_SMB2U_Global_Layer3TilemapStripeImageUploadTable = $7F0802

!RAM_SMB2U_Global_Layer2Map16Table = !RAM_SMB2U_Level_LevelDataMap16Lo+$010000

!RAM_SMB2U_Global_Layer3Map16Table = $7FC000

!RAM_SMB2U_Level_PauseMenuWindow1HDMATable = $7FF000
!RAM_SMB2U_Level_PauseMenuWindow2HDMATable = !RAM_SMB2U_Level_PauseMenuWindow1HDMATable+$0200
!RAM_SMB2U_WarpZone_WaveEffectHDMATable = $7FF400
!RAM_SMB2U_TitleScreen_Mode2LayerScrollingDataTable = $7FF600

!RAM_SMB2U_TitleScreen_Mode2ScreenScrollVRAMAddressLo = $7FF800
!RAM_SMB2U_TitleScreen_Mode2ScreenScrollVRAMAddressHi = !RAM_SMB2U_TitleScreen_Mode2ScreenScrollVRAMAddressLo+$01
!RAM_SMB2U_TitleScreen_Mode2ScreenScrollDataSizeLo = $7FF802
!RAM_SMB2U_TitleScreen_Mode2ScreenScrollDataSizeHi = !RAM_SMB2U_TitleScreen_Mode2ScreenScrollDataSizeLo+$01
!RAM_SMB2U_TitleScreen_Mode2ScreenScrollFrameIndexLo = $7FF804
!RAM_SMB2U_TitleScreen_Mode2ScreenScrollFrameIndexHi = !RAM_SMB2U_TitleScreen_Mode2ScreenScrollFrameIndexLo+$01
!RAM_SMB2U_TitleScreen_CurrentMode2ScreenToScrollLo = $7FF806
!RAM_SMB2U_TitleScreen_CurrentMode2ScreenToScrollHi = !RAM_SMB2U_TitleScreen_CurrentMode2ScreenToScrollLo+$01

!RAM_SMB2U_Global_InitialWorld = $7FFB00

struct SMB2U_OAMBuffer !RAM_SMB2U_Global_OAMBuffer
	.XDisp: skip $01
	.YDisp: skip $01
	.Tile: skip $01
	.Prop: skip $01
endstruct align $04

struct SMB2U_UpperOAMBuffer !RAM_SMB2U_Global_OAMBuffer+$0200
	.Slot: skip $01
endstruct align $01

struct SMB2U_OAMTileSizeBuffer !RAM_SMB2U_Global_OAMTileSizeBuffer
	.Slot: skip $01
endstruct

struct SMB2U_PaletteMirror !RAM_SMB2U_Global_PaletteMirror
	.LowByte: skip $01
	.HighByte: skip $01
endstruct align $02

struct SMB2U_StripeImageUploadTable !RAM_SMB2U_Global_StripeImageUploadTable
	.LowByte: skip $01
	.HighByte: skip $01
endstruct align $02

;---------------------------------------------------------------------------

;!RAM_SMB2U_NorSprXX_GenericEnemies_ = 

!RAM_SMB2U_NorSpr02_Tweeter_HopCounter = !RAM_SMB2U_NorSpr_Table7E0079

!RAM_SMB2U_NorSpr09_BobOmb_WaitBeforeExplosionTimer = !RAM_SMB2U_NorSpr_DecrementingTable7E0086
!RAM_SMB2U_NorSpr09_BobOmb_EmergeFromVaseTimer = !RAM_SMB2U_NorSpr_Table7E0480

;---------------------------------------------------------------------------

!RAM_SMB2U_NorSpr08_Ostro_AnimationFrame = !RAM_SMB2U_NorSpr_Table7E009F
!RAM_SMB2U_NorSpr08_Ostro_NoShyGuyRiderFlag = !RAM_SMB2U_NorSpr_Table7E00B1
!RAM_SMB2U_NorSpr08_Ostro_TurnAroundDecisionTimer = !RAM_SMB2U_NorSpr_Table7E0477

;---------------------------------------------------------------------------

!RAM_SMB2U_NorSprXX_Albatoss_IsNotCarryingBobOmb = !RAM_SMB2U_NorSpr_Table7E00B1

;---------------------------------------------------------------------------

;!RAM_SMB2U_NorSprXX_Ninji_ = !RAM_SMB2U_NorSpr_Table7E009F

;---------------------------------------------------------------------------

!RAM_SMB2U_NorSpr12_Pidgit_WaitBeforeNextSwoopAttack = !RAM_SMB2U_NorSpr_DecrementingTable7E0086
!RAM_SMB2U_NorSpr12_Pidgit_SwoopAttackFlag = !RAM_SMB2U_NorSpr_Table7E00B1
!RAM_SMB2U_NorSpr12_Pidgit_IdleXMovementDirection = !RAM_SMB2U_NorSpr_Table7E0477
!RAM_SMB2U_NorSpr12_Pidgit_IdleYMovementDirection = !RAM_SMB2U_NorSpr_Table7E0480

;---------------------------------------------------------------------------

!RAM_SMB2U_NorSpr13_Trouter_WaitBeforeJumping = !RAM_SMB2U_NorSpr_DecrementingTable7E0086
;!RAM_SMB2U_NorSpr13_Trouter_ = !RAM_SMB2U_NorSpr_Table7E009F
!RAM_SMB2U_NorSpr13_Trouter_YSpeedIndex = !RAM_SMB2U_NorSpr_Table7E00B1

;---------------------------------------------------------------------------

!RAM_SMB2U_NorSpr14_Hoopster_PreventTurnAroundTimer = !RAM_SMB2U_NorSpr_DecrementingTable7E0086
;!RAM_SMB2U_NorSpr14_Hoopster_ = !RAM_SMB2U_NorSpr_Table7E009F
!RAM_SMB2U_NorSpr14_Hoopster_MovementDirection = !RAM_SMB2U_NorSpr_Table7E0477
;!RAM_SMB2U_NorSpr14_Hoopster_ = !RAM_SMB2U_NorSpr_Table7E0702

;---------------------------------------------------------------------------

!RAM_SMB2U_NorSpr17_Phanto_RumbleFrameCounter = !RAM_SMB2U_NorSpr_Table7E044A
!RAM_SMB2U_NorSpr17_Phanto_XMovementDirection = !RAM_SMB2U_NorSpr_Table7E0477
!RAM_SMB2U_NorSpr17_Phanto_ChangeXSpeedCounter = !RAM_SMB2U_NorSpr_Table7E0480

;---------------------------------------------------------------------------

!RAM_SMB2U_NorSprXX_Cobrat_InitialYPos = !RAM_SMB2U_NorSpr_Table7E0079
!RAM_SMB2U_NorSprXX_Cobrat_WaitBeforeSpittingBullet = !RAM_SMB2U_NorSpr_DecrementingTable7E0453

!RAM_SMB2U_NorSpr19_GroundDwellingCobrat_WaitBobbingTimer = !RAM_SMB2U_NorSpr_Table7E0477
!RAM_SMB2U_NorSpr19_GroundDwellingCobrat_OutOfTheGroundFlag = !RAM_SMB2U_NorSpr_Table7E0480

!RAM_SMB2U_NorSpr18_VaseDwellingCobrat_WaitBeforeJumpingTimer = !RAM_SMB2U_NorSpr_DecrementingTable7E0086
!RAM_SMB2U_NorSpr18_VaseDwellingCobrat_CurrentState = !RAM_SMB2U_NorSpr_Table7E00B1

;---------------------------------------------------------------------------

!RAM_SMB2U_NorSpr1A_Pokey_NumberOfBodySegments = !RAM_SMB2U_NorSpr_Table7E0079
!RAM_SMB2U_NorSpr1A_Pokey_TurnAroundDecisionTimer = !RAM_SMB2U_NorSpr_Table7E009F

;---------------------------------------------------------------------------

!RAM_SMB2U_NorSprXX_StraightEnemyProjectile_HasHitWall = !RAM_SMB2U_NorSpr_Table7E00B1

;---------------------------------------------------------------------------

!RAM_SMB2U_NorSpr1C_Birdo_BirdoType = !RAM_SMB2U_NorSpr_Table7E0079
!RAM_SMB2U_NorSpr1C_Birdo_SpitEggTimer = !RAM_SMB2U_NorSpr_DecrementingTable7E0086
!RAM_SMB2U_NorSpr1C_Birdo_MovementTimer = !RAM_SMB2U_NorSpr_Table7E00B1
!RAM_SMB2U_NorSpr1C_Birdo_FinalHitTimer = !RAM_SMB2U_NorSpr_Table7E0702

;---------------------------------------------------------------------------

!RAM_SMB2U_NorSpr1D_Mouser_WaitBeforeThrowingBombTimer = !RAM_SMB2U_NorSpr_DecrementingTable7E0086
!RAM_SMB2U_NorSpr1D_Mouser_MovementTimer = !RAM_SMB2U_NorSpr_Table7E00B1
!RAM_SMB2U_NorSpr1D_Mouser_CurrentHP = !RAM_SMB2U_NorSpr_Table7E0465

;---------------------------------------------------------------------------

!RAM_SMB2U_NorSpr1F_Tryclyde_BottomHeadShootTimer2 = !RAM_SMB2U_NorSpr_Table7E00B1
!RAM_SMB2U_NorSpr1F_Tryclyde_CurrentHP = !RAM_SMB2U_NorSpr_Table7E0465
!RAM_SMB2U_NorSpr1F_Tryclyde_TopHeadShootAndMovementTimer = !RAM_SMB2U_NorSpr_Table7E0477
!RAM_SMB2U_NorSpr1F_Tryclyde_BottomHeadShootTimer1 = !RAM_SMB2U_NorSpr_Table7E0480

;---------------------------------------------------------------------------

!RAM_SMB2U_NorSpr20_Fireball_DisableGravity = !RAM_SMB2U_NorSpr_Table7E0079
;!RAM_SMB2U_NorSpr20_Fireball_ = !RAM_SMB2U_NorSpr_Table7E00B1
!RAM_SMB2U_NorSpr20_Fireball_AnimationFrameCounter = !RAM_SMB2U_NorSpr_DecrementingTable7E0453
!RAM_SMB2U_NorSpr20_Fireball_AnimationFrame = !RAM_SMB2U_NorSpr_Table7E0480

;---------------------------------------------------------------------------

!RAM_SMB2U_NorSpr21_Clawgrip_MovementTimer = !RAM_SMB2U_NorSpr_Table7E0079
!RAM_SMB2U_NorSpr21_Clawgrip_RockThrowTimer = !RAM_SMB2U_NorSpr_DecrementingTable7E0086
!RAM_SMB2U_NorSpr21_Clawgrip_CurrentHP = !RAM_SMB2U_NorSpr_Table7E0465

;---------------------------------------------------------------------------

!RAM_SMB2U_NorSprXX_Panser_OpenMouthTimer = !RAM_SMB2U_NorSpr_DecrementingTable7E0086
!RAM_SMB2U_NorSprXX_Panser_WaitBeforeShootingFireball = !RAM_SMB2U_NorSpr_Table7E009F

;---------------------------------------------------------------------------

!RAM_SMB2U_NorSpr26_Autobomb_ShootFireballTimer = !RAM_SMB2U_NorSpr_Table7E009F
!RAM_SMB2U_NorSpr26_Autobomb_NoShyGuyRiderFlag = !RAM_SMB2U_NorSpr_Table7E00B1

;---------------------------------------------------------------------------

!RAM_SMB2U_NorSpr28_WaterSpout_BehaviorTimer = !RAM_SMB2U_NorSpr_Table7E0079
;!RAM_SMB2U_NorSpr28_WaterSpout_ = !RAM_SMB2U_NorSpr_Table7E009F
!RAM_SMB2U_NorSpr28_WaterSpout_InitialYPos = !RAM_SMB2U_NorSpr_Table7E00B1

;---------------------------------------------------------------------------

;!RAM_SMB2U_NorSpr29_Flurry_ = !RAM_SMB2U_NorSpr_Table7E009F
;!RAM_SMB2U_NorSpr29_Flurry_ = !RAM_SMB2U_NorSpr_Table7E04A4

;---------------------------------------------------------------------------

!RAM_SMB2U_NorSpr2A_Fryguy_YMovementDirection = !RAM_SMB2U_NorSpr_Table7E0079
;!RAM_SMB2U_NorSpr2A_Fryguy_ = !RAM_SMB2U_NorSpr_Table7E009F
!RAM_SMB2U_NorSpr2A_Fryguy_CurrentHP = !RAM_SMB2U_NorSpr_Table7E0465
!RAM_SMB2U_NorSpr2A_Fryguy_XMovementDirection = !RAM_SMB2U_NorSpr_Table7E0477

;---------------------------------------------------------------------------

;!RAM_SMB2U_NorSpr_Table7E0079
!RAM_SMB2U_NorSpr2B_MiniFryguy_ = !RAM_SMB2U_NorSpr_DecrementingTable7E0086
!RAM_SMB2U_NorSpr2B_MiniFryguy_ = !RAM_SMB2U_NorSpr_Table7E009F
;!RAM_SMB2U_NorSpr2B_MiniFryguy_ = !RAM_SMB2U_NorSpr_DecrementingTable7E0453
;!RAM_SMB2U_NorSpr_Table7E0465
!RAM_SMB2U_NorSpr2B_MiniFryguy_ = !RAM_SMB2U_NorSpr_Table7E04A4
!RAM_SMB2U_NorSpr2B_MiniFryguy_ = !RAM_SMB2U_NorSpr_Table7E04F0

;---------------------------------------------------------------------------

!RAM_SMB2U_NorSpr2C_Wart_MovementTimer = !RAM_SMB2U_NorSpr_Table7E0079
!RAM_SMB2U_NorSpr2C_Wart_SpitBubblesTimer = !RAM_SMB2U_NorSpr_DecrementingTable7E0086
!RAM_SMB2U_NorSpr2C_Wart_HurtTimer = !RAM_SMB2U_NorSpr_DecrementingTable7E0086
!RAM_SMB2U_NorSpr2C_Wart_IsFallingOffscreenFlag = !RAM_SMB2U_NorSpr_Table7E00B1
!RAM_SMB2U_NorSpr2C_Wart_CurrentHP = !RAM_SMB2U_NorSpr_Table7E0465
!RAM_SMB2U_NorSpr2C_Wart_AnimationFrameCounter = !RAM_SMB2U_NorSpr_Table7E0477
!RAM_SMB2U_NorSpr2C_Wart_BubbleYSpeedIndex = !RAM_SMB2U_NorSpr_Table7E0480
!RAM_SMB2U_NorSpr2C_Wart_InitialXPosHi = !RAM_SMB2U_NorSpr_Table7E04F0

;---------------------------------------------------------------------------

!RAM_SMB2U_NorSpr2D_HawkmouthBoss_YMovementDirection = !RAM_SMB2U_NorSpr_Table7E0079
!RAM_SMB2U_NorSpr2D_HawkmouthBoss_AppearBehindLayer1Timer = !RAM_SMB2U_NorSpr_DecrementingTable7E0086
!RAM_SMB2U_NorSpr2D_HawkmouthBoss_CloseMouthFlag = !RAM_SMB2U_NorSpr_Table7E00B1
!RAM_SMB2U_NorSpr2D_HawkmouthBoss_NoMovementTimer = !RAM_SMB2U_NorSpr_DecrementingTable7E0438
!RAM_SMB2U_NorSpr2D_HawkmouthBoss_WaitBeforeClosingMouth = !RAM_SMB2U_NorSpr_DecrementingTable7E0453
!RAM_SMB2U_NorSpr2D_HawkmouthBoss_CurrentHP = !RAM_SMB2U_NorSpr_Table7E0465
!RAM_SMB2U_NorSpr2D_HawkmouthBoss_OpenMouthSize = !RAM_SMB2U_NorSpr_Table7E0480

;---------------------------------------------------------------------------

!RAM_SMB2U_NorSprXX_Spark_MovementAxis = !RAM_SMB2U_NorSpr_Table7E0477

;---------------------------------------------------------------------------

!RAM_SMB2U_NorSpr38_RocketShip_CanLaunchFlag = !RAM_SMB2U_NorSpr_Table7E00B1
!RAM_SMB2U_NorSpr38_RocketShip_CanEjectCharacter = !RAM_SMB2U_NorSpr_Table7E0477

;---------------------------------------------------------------------------

!RAM_SMB2U_NorSpr39_MushroomBlock_TileToTurnInto = !RAM_SMB2U_NorSpr_Table7E0079

;---------------------------------------------------------------------------

!RAM_SMB2U_NorSpr3B_FallingLog_InitialYPos = !RAM_SMB2U_NorSpr_Table7E0079
!RAM_SMB2U_NorSpr3B_FallingLog_IsInFrontOfWaterfall = !RAM_SMB2U_NorSpr_Table7E00B1
;!RAM_SMB2U_NorSpr_DecrementingTable7E0438

;---------------------------------------------------------------------------

!RAM_SMB2U_NorSpr3C_Door_ = !RAM_SMB2U_NorSpr_Table7E00B1
!RAM_SMB2U_NorSpr3C_Door_IsLockedFlag = !RAM_SMB2U_NorSpr_Table7E0477

;---------------------------------------------------------------------------

!RAM_SMB2U_NorSpr41_MagicCarpet_DespawnTimer = !RAM_SMB2U_NorSpr_Table7E00B1

;---------------------------------------------------------------------------

;Standalone ROM specific RAM addresses
!RAM_SMB2U_TitleScreen_EraseFileProcess = $000020
!RAM_SMB2U_SplashScreen_DisplayTimer = $000021
	!RAM_SMB2U_TitleScreen_FileAMaxWorld = $000021
!RAM_SMB2U_SplashScreen_PaletteAnimationTimer = $000022
	!RAM_SMB2U_TitleScreen_FileBMaxWorld = !RAM_SMB2U_TitleScreen_FileAMaxWorld+$01
!RAM_SMB2U_SplashScreen_PaletteAnimationIndex =  !RAM_SMB2U_SplashScreen_PaletteAnimationTimer+$01
	!RAM_SMB2U_TitleScreen_FileCMaxWorld = !RAM_SMB2U_TitleScreen_FileAMaxWorld+$02
!RAM_SMB2U_SplashScreen_DisplayMarioCoinShineFlag = $000024
!RAM_SMB2U_TitleScreen_FileASelectedWorld = $000025
!RAM_SMB2U_TitleScreen_FileBSelectedWorld = !RAM_SMB2U_TitleScreen_FileASelectedWorld+$01
!RAM_SMB2U_TitleScreen_FileCSelectedWorld = !RAM_SMB2U_TitleScreen_FileASelectedWorld+$02
!RAM_SMB2U_ErrorScreen_PaletteMirror = $000200						; Note: This must be set to $000200 or else problems may occur
!RAM_SMB2U_ErrorScreen_TextTilemap = $000800

struct SMB2U_ErrorScreen_TextTilemap !RAM_SMB2U_ErrorScreen_TextTilemap
	.Row: skip $40
endstruct

struct SMB2U_ErrorScreen_PaletteMirror !RAM_SMB2U_ErrorScreen_PaletteMirror
	.LowByte: skip $01
	.HighByte: skip $01
endstruct align $02
