; RAM Define tags:
;!A_B_C_D_E
; A = RAM type (ex. RAM, ARAM, VRAM, OAM, SRAM, IRAM, BWRAM, etc)
; B = GameID (ex. SMAS)
; C = Game mode RAM for general context of where the RAM is used (ex. Level)
; D = Optional sub tag for further context (ex. Player)
; E = RAM address's function
;
; Game Mode tags:
; "ErrorScreen", "SplashScreen", "TitleScreen" "GameSelect" = Used on that specific screen.
; "Global" = Used anywhere or close to everywhere.

!RAM_SMAS_Global_ScratchRAM00 = $000000
!RAM_SMAS_Global_ScratchRAM01 = $000001
!RAM_SMAS_Global_ScratchRAM02 = $000002
!RAM_SMAS_Global_ScratchRAM03 = $000003
!RAM_SMAS_Global_ScratchRAM04 = $000004
!RAM_SMAS_Global_ScratchRAM05 = $000005
!RAM_SMAS_Global_ScratchRAM06 = $000006
!RAM_SMAS_Global_ScratchRAM07 = $000007
!RAM_SMAS_Global_ScratchRAM08 = $000008
!RAM_SMAS_Global_ScratchRAM09 = $000009
!RAM_SMAS_Global_ScratchRAM0A = $00000A
!RAM_SMAS_Global_ScratchRAM0B = $00000B
!RAM_SMAS_Global_ScratchRAM0C = $00000C
!RAM_SMAS_Global_ScratchRAM0D = $00000D
!RAM_SMAS_Global_ScratchRAM0E = $00000E
!RAM_SMAS_Global_ScratchRAM0F = $00000F

!RAM_SMAS_GameSelect_UnknownRAM000014 = $000014
!RAM_SMAS_GameSelect_UnknownRAM000015 = !RAM_SMAS_GameSelect_UnknownRAM000014+$01
!RAM_SMAS_GameSelect_UnknownRAM000016 = $000016
!RAM_SMAS_GameSelect_UnknownRAM000017 = !RAM_SMAS_GameSelect_UnknownRAM000016+$01

!RAM_SMAS_GameSelect_UnknownRAM000019 = $000019
!RAM_SMAS_GameSelect_UnknownRAM00001A = !RAM_SMAS_GameSelect_UnknownRAM000019+$01
!RAM_SMAS_GameSelect_UnknownRAM00001B = $00001B
!RAM_SMAS_SplashScreen_DisplayTimer = $00001C
	!RAM_SMAS_GameSelect_UnknownRAM00001C = !RAM_SMAS_GameSelect_UnknownRAM00001B+$01

!RAM_SMAS_GameSelect_UnknownRAM00001D = !RAM_SMAS_GameSelect_UnknownRAM00001C+$01
!RAM_SMAS_SplashScreen_UnknownRAM00001D  = $00001D

!RAM_SMAS_GameSelect_UnknownRAM000020 = $000020
!RAM_SMAS_SplashScreen_UnknownRAM000021 = $000021
	!RAM_SMAS_GameSelect_UnknownRAM000021 = !RAM_SMAS_GameSelect_UnknownRAM000020+$01
!RAM_SMAS_SplashScreen_PaletteAnimationTimer = $000022
!RAM_SMAS_SplashScreen_PaletteAnimationIndex = !RAM_SMAS_SplashScreen_PaletteAnimationTimer+$01
!RAM_SMAS_SplashScreen_DisplayMarioCoinShineFlag = $000024

!RAM_SMAS_TitleScreen_StartButtonPressedFlag = $000027						; Optimization: Junk

!RAM_SMAS_GameSelect_UnknownRAM000029 = $000029

!RAM_SMAS_Global_SoundCh1 = $000060
!RAM_SMAS_Global_SoundCh2 = !RAM_SMAS_Global_SoundCh1+$01
!RAM_SMAS_Global_MusicCh1 = !RAM_SMAS_Global_SoundCh1+$02
!RAM_SMAS_Global_SoundCh3 = !RAM_SMAS_Global_SoundCh1+$03
!RAM_SMAS_Global_SoundCh1Backup = $000064
!RAM_SMAS_Global_SoundCh2Backup = $000065
!RAM_SMAS_Global_MusicRegisterBackup = $000066
!RAM_SMAS_Global_SoundCh3Backup = $000067

!RAM_SMAS_GameSelect_HardModeWorldSelectedTable = $000070
!RAM_SMAS_GameSelect_MaxWorldTable = $000080
!RAM_SMAS_GameSelect_MaxLevelTable = $000090
!RAM_SMAS_GameSelect_NoWorld9Table = $0000A0
!RAM_SMAS_GameSelect_SelectedWorldTable = $0000B0
!RAM_SMAS_GameSelect_SelectedLevelTable = $0000C0

!RAM_SMAS_GameSelect_CurrentlyOpenedFileSelectWindow = $0000D0
!RAM_SMAS_GameSelect_CurrentlySelectedSaveFile = $0000D1
!RAM_SMAS_GameSelect_CanDisplayEraseFileMenuFlag = $0000D2
!RAM_SMAS_TitleScreen_UpdateTilemapFlag = $0000DE

!RAM_SMAS_Global_GameMode = $0000E0
!RAM_SMAS_TitleScreen_CurrentState = $0000E1
	!RAM_SMAS_GameSelect_UnknownRAM0000E1 = $0000E1

!RAM_SMAS_TitleScreen_TriangleTransitionEffectIndexLo = $0000E3
	!RAM_SMAS_TitleScreen_PhaseTimerLo = $0000E3
!RAM_SMAS_TitleScreen_TriangleTransitionEffectIndexHi = !RAM_SMAS_TitleScreen_TriangleTransitionEffectIndex+$01
	!RAM_SMAS_TitleScreen_PhaseTimerHi = !RAM_SMAS_TitleScreen_PhaseTimerLo+$01
!RAM_SMAS_Global_TriangleTransitionEffectPtrLo = $0000E5
!RAM_SMAS_Global_TriangleTransitionEffectPtrHi = !RAM_SMAS_Global_TriangleTransitionEffectPtrLo+$01
!RAM_SMAS_Global_TriangleTransitionEffectPtrBank = !RAM_SMAS_Global_TriangleTransitionEffectPtrLo+$02

!RAM_SMAS_Global_StripeImageDataLo = $0000E8
!RAM_SMAS_Global_StripeImageDataHi = !RAM_SMAS_Global_StripeImageDataLo+$01
!RAM_SMAS_Global_StripeImageDataBank = !RAM_SMAS_Global_StripeImageDataLo+$02

!RAM_SMAS_Global_StripeImageDataSizeLo = $0000EC
!RAM_SMAS_Global_StripeImageDataSizeHi = !RAM_SMAS_Global_StripeImageDataSizeLo+$01

!RAM_SMAS_Global_ControllerHold1CopyP1 = $0000F0
!RAM_SMAS_Global_ControllerHold1CopyP2 = $0000F1
!RAM_SMAS_Global_ControllerHold2CopyP1 = $0000F2
!RAM_SMAS_Global_ControllerHold2CopyP2 = $0000F3
!RAM_SMAS_Global_ControllerPress1CopyP1 = $0000F4
!RAM_SMAS_Global_ControllerPress1CopyP2 = $0000F5
!RAM_SMAS_Global_ControllerPress2CopyP1 = $0000F6
!RAM_SMAS_Global_ControllerPress2CopyP2 = $0000F7
!RAM_SMAS_Global_P1CtrlDisableLo = $0000F8
!RAM_SMAS_Global_P2CtrlDisableLo = $0000F9
!RAM_SMAS_Global_P1CtrlDisableHi = $0000FA
!RAM_SMAS_Global_P2CtrlDisableHi = $0000FB

!RAM_SMAS_Global_FrameCounter = $0000FD

!RAM_SMAS_Global_EndOfStack = !RAM_SMAS_Global_StartOfStack-$FF
	!RAM_SMAS_Global_ScreenDisplayRegister = $000100
	!RAM_SMAS_Global_OAMSizeAndDataAreaDesignation = !RAM_SMAS_Global_ScreenDisplayRegister+$01
	!RAM_SMAS_Global_BGModeAndTileSizeSetting = !RAM_SMAS_Global_ScreenDisplayRegister+$02
	!RAM_SMAS_Global_MosaicSizeAndBGEnable = !RAM_SMAS_Global_BGModeAndTileSizeSetting+$01
	!RAM_SMAS_Global_BG1AddressAndSize = !RAM_SMAS_Global_ScreenDisplayRegister+$04
	!RAM_SMAS_Global_BG2AddressAndSize = !RAM_SMAS_Global_BG1AddressAndSize+$01
	!RAM_SMAS_Global_BG3AddressAndSize = !RAM_SMAS_Global_ScreenDisplayRegister+$06
	!RAM_SMAS_Global_BG1And2TileDataDesignation = !RAM_SMAS_Global_ScreenDisplayRegister+$07
	!RAM_SMAS_Global_CurrentLayer1XPosLo = !RAM_SMAS_Global_ScreenDisplayRegister+$08
	!RAM_SMAS_Global_CurrentLayer1XPosHi = !RAM_SMAS_Global_CurrentLayer1XPosLo+$01
	!RAM_SMAS_Global_CurrentLayer1YPosLo = !RAM_SMAS_Global_ScreenDisplayRegister+$0A
	!RAM_SMAS_Global_CurrentLayer1YPosHi = !RAM_SMAS_Global_CurrentLayer1YPosLo+$01
	!RAM_SMAS_Global_CurrentLayer2XPosLo = !RAM_SMAS_Global_ScreenDisplayRegister+$0C
	!RAM_SMAS_Global_CurrentLayer2XPosHi = !RAM_SMAS_Global_CurrentLayer2XPosLo+$01
	!RAM_SMAS_Global_CurrentLayer2YPosLo = !RAM_SMAS_Global_ScreenDisplayRegister+$0E
	!RAM_SMAS_Global_CurrentLayer2YPosHi = !RAM_SMAS_Global_CurrentLayer2YPosLo+$01
	!RAM_SMAS_Global_CurrentLayer3XPosLo = !RAM_SMAS_Global_ScreenDisplayRegister+$10
	!RAM_SMAS_Global_CurrentLayer3XPosHi = !RAM_SMAS_Global_CurrentLayer3XPosLo+$01
	!RAM_SMAS_Global_CurrentLayer3YPosLo = !RAM_SMAS_Global_ScreenDisplayRegister+$12
	!RAM_SMAS_Global_CurrentLayer3YPosHi = !RAM_SMAS_Global_CurrentLayer3YPosLo+$01
	!RAM_SMAS_Global_BG1And2WindowMaskSettings = !RAM_SMAS_Global_ScreenDisplayRegister+$14
	!RAM_SMAS_Global_BG3And4WindowMaskSettings = !RAM_SMAS_Global_BG1And2WindowMaskSettings+$01
	!RAM_SMAS_Global_ObjectAndColorWindowSettings = !RAM_SMAS_Global_ScreenDisplayRegister+$16
	!RAM_SMAS_Global_MainScreenLayers = !RAM_SMAS_Global_ScreenDisplayRegister+$17
	!RAM_SMAS_Global_SubScreenLayers = !RAM_SMAS_Global_MainScreenLayers+$01
	!RAM_SMAS_Global_MainScreenWindowMask = !RAM_SMAS_Global_ScreenDisplayRegister+$19
	!RAM_SMAS_Global_SubScreenWindowMask = !RAM_SMAS_Global_MainScreenWindowMask+$01
	!RAM_SMAS_Global_ColorMathInitialSettings = !RAM_SMAS_Global_ScreenDisplayRegister+$1B
	!RAM_SMAS_Global_ColorMathSelectAndEnable = !RAM_SMAS_Global_ColorMathInitialSettings+$01
	!RAM_SMAS_Global_FixedColorData1 = !RAM_SMAS_Global_ScreenDisplayRegister+$1D
	!RAM_SMAS_Global_FixedColorData2 = !RAM_SMAS_Global_ScreenDisplayRegister+$1E
	!RAM_SMAS_Global_FixedColorData3 = !RAM_SMAS_Global_ScreenDisplayRegister+$1F
	!RAM_SMAS_Global_HDMAEnable = !RAM_SMAS_Global_ScreenDisplayRegister+$20
	!RAM_SMAS_Global_UnknownRAM = !RAM_SMAS_Global_ScreenDisplayRegister+$21
	!RAM_SMAS_Global_WaitForVBlankFlag = !RAM_SMAS_Global_ScreenDisplayRegister+$22

	!RAM_SMAS_Global_IRQEnableFlag = !RAM_SMAS_Global_ScreenDisplayRegister+$24
	!RAM_SMAS_Global_VCountTimerLo = !RAM_SMAS_Global_ScreenDisplayRegister+$25
	!SRAM_SMAS_Global_UnknownSRAM000150 = $000150
	!SRAM_SMAS_Global_UnknownSRAM000151 = !SRAM_SMAS_Global_UnknownSRAM000150+$01
	!SRAM_SMAS_Global_UnknownSRAM000152 = $000152
	!SRAM_SMAS_Global_UnknownSRAM000153 = !SRAM_SMAS_Global_UnknownSRAM000152+$01
	!SRAM_SMAS_Global_UnknownSRAM000154 = $000154
	!SRAM_SMAS_Global_UnknownSRAM000155 = !SRAM_SMAS_Global_UnknownSRAM000154+$01
	!RAM_SMAS_Global_StartOfStack = $0001FF

; $000200-$0003FF
;--------------------------------------------------------------------

;Error Screen:
!RAM_SMAS_ErrorScreen_PaletteMirror = $000200						; Note: This must be set to $000200 or else problems may occur

;Title Screen/Game Select:
!RAM_SMAS_TitleScreen_LuigisHeadAnimationIndex = $000200
!RAM_SMAS_TitleScreen_LuigisArmAnimationIndex = $000201
!RAM_SMAS_TitleScreen_PeachAnimationIndex = $000202
!RAM_SMAS_TitleScreen_ToadAnimationIndex = $000203
!RAM_SMAS_TitleScreen_ToadAnimationIndex = $000203
!RAM_SMAS_TitleScreen_BirdoEyesAnimationIndex = $000204
!RAM_SMAS_TitleScreen_BirdoClawAnimationIndex = $000205
!RAM_SMAS_TitleScreen_BirdoTailAnimationIndex = $000206
!RAM_SMAS_TitleScreen_GoombaAnimationIndex = $000207
!RAM_SMAS_TitleScreen_BobOmbAnimationIndex = $000208
!RAM_SMAS_TitleScreen_SpinyAnimationIndex = $000209
!RAM_SMAS_TitleScreen_PidgitAnimationIndex = $00020A
!RAM_SMAS_TitleScreen_MariosHeadAnimationIndex = $00020B
!RAM_SMAS_TitleScreen_MarioArmAnimationIndex = $00020C
!RAM_SMAS_TitleScreen_BowserAnimationIndex = $00020D
!RAM_SMAS_TitleScreen_AnimationTimer1 = $00020E
!RAM_SMAS_TitleScreen_AnimationTimer2 = $00020F
!RAM_SMAS_TitleScreen_AnimationTimer3 = $000210
	!RAM_SMAS_GameSelect_YoshiAnimationTimer = $000210
!RAM_SMAS_TitleScreen_AnimationTimer4 = $000211
!RAM_SMAS_TitleScreen_AnimationTimer5 = $000212
; $000213 = Empty
!RAM_SMAS_GameSelect_Layer1XPosBelowCursorLo = $000214
!RAM_SMAS_GameSelect_Layer1XPosBelowCursorHi = !RAM_SMAS_GameSelect_Layer1XPosBelowCursorLo+$01
!RAM_SMAS_GameSelect_MoveCursorRightTimer = $000216
!RAM_SMAS_GameSelect_MoveCursorLeftTimer = $000217
!RAM_SMAS_GameSelect_CursorPosIndex = $000218
!RAM_SMAS_GameSelect_UploadFileSelectGFXFlag = $000219
!RAM_SMAS_GameSelect_ActiveFileSelectTransitionFlag = $00021A
!RAM_SMAS_GameSelect_FileSelectTransitionTimer = $00021B
!RAM_SMAS_GameSelect_CurrentFileSelectMenuVRAMAddressLo = $00021C
!RAM_SMAS_GameSelect_CurrentFileSelectMenuVRAMAddressHi = !RAM_SMAS_GameSelect_CurrentFileSelectMenuVRAMAddressLo+$01
!RAM_SMAS_GameSelect_FileSelectWindowBufferIndexLo = $00021E
	!RAM_SMAS_GameSelect_TilemapBufferIndexLo = $00021E
!RAM_SMAS_GameSelect_FileSelectWindowBufferIndexHi = !RAM_SMAS_GameSelect_FileSelectWindowBufferIndexLo+$01
	!RAM_SMAS_GameSelect_TilemapBufferIndexHi = !RAM_SMAS_GameSelect_TilemapBufferIndexLo+$01
!RAM_SMAS_GameSelect_FileSelectMenuActiveFlag = $000220
!RAM_SMAS_GameSelect_EraseFileMenuAnimationIndex = $000221
!RAM_SMAS_GameSelect_EraseFileMenuCursorPos = $000222
!RAM_SMAS_GameSelect_WaitAfterSelectingFileTimer = $000223
!RAM_SMAS_GameSelect_SelectedAFileFlag = $000224
!RAM_SMAS_TitleScreen_FrameToRestartLogoPaletteAnimationLo = $000225
!RAM_SMAS_TitleScreen_FrameToRestartLogoPaletteAnimationHi = !RAM_SMAS_TitleScreen_FrameToRestartLogoPaletteAnimationLo+$01
!RAM_SMAS_Global_YoshiAnimationIndex = $000227
!RAM_SMAS_GameSelect_FileSelectGFXPrtLo = $000228
!RAM_SMAS_GameSelect_FileSelectGFXPrtHi = !RAM_SMAS_GameSelect_FileSelectGFXPrtLo+$01

;--------------------------------------------------------------------

!RAM_SMAS_GameSelect_FileSelectWindowBuffer = $000400

!RAM_SMAS_Global_OAMBuffer = $000800
	!RAM_SMAS_ErrorScreen_TextTilemap = $000800
!RAM_SMAS_Global_OAMTileSizeBuffer = $000A20

!RAM_SMAS_Global_UpdateEntirePaletteFlag = $000AC0

!RAM_SMAS_SplashScreen_SPCEngineBuffer = $7F0000
	!RAM_SMAS_TitleScreen_TilemapBuffer = $7F0000
	!RAM_SMAS_GameSelect_TilemapBuffer = $7F1000

!RAM_SMAS_Global_StripeImageUploadIndexLo = $7F8000
!RAM_SMAS_Global_StripeImageUploadIndexHi = !RAM_SMAS_Global_StripeImageUploadIndexLo+$01
!RAM_SMAS_Global_StripeImageUploadTable = !RAM_SMAS_Global_StripeImageUploadIndexLo+$02

!RAM_SMAS_GameSelect_UnusedPaletteBuffer = $7F9000
!RAM_SMAS_Global_PaletteMirror = $7F9200

!RAM_SMAS_Global_SaveBuffer = $7FFB00
	!RAM_SMAS_Global_InitialWorld = !RAM_SMAS_Global_SaveBuffer
	!RAM_SMAS_Global_InitialLevel = !RAM_SMAS_Global_SaveBuffer+$01
!RAM_SMAS_Global_CurrentGameX2 = $7FFF00

struct SMAS_Global_OAMBuffer !RAM_SMAS_Global_OAMBuffer
	.XDisp: skip $01
	.YDisp: skip $01
	.Tile: skip $01
	.Prop: skip $01
endstruct align $04

struct SMAS_Global_UpperOAMBuffer !RAM_SMAS_Global_OAMBuffer+$0200
	.Slot: skip $01
endstruct align $01

struct SMAS_Global_OAMTileSizeBuffer !RAM_SMAS_Global_OAMTileSizeBuffer
	.Slot: skip $01
endstruct

struct SMAS_Global_StripeImageUploadTable !RAM_SMAS_Global_StripeImageUploadTable
	.LowByte: skip $01
	.HighByte: skip $01
endstruct align $02

struct SMAS_Global_PaletteMirror !RAM_SMAS_Global_PaletteMirror
	.LowByte: skip $01
	.HighByte: skip $01
endstruct align $02

struct SMAS_ErrorScreen_TextTilemap !RAM_SMAS_ErrorScreen_TextTilemap
	.Row: skip $40
endstruct

struct SMAS_ErrorScreen_PaletteMirror !RAM_SMAS_ErrorScreen_PaletteMirror
	.LowByte: skip $01
	.HighByte: skip $01
endstruct align $02
