; RAM Define tags:
; "Player" = RAM address associated with the player sprite in levels.
; "NorSpr" = RAM address associated with normal sprites.
; "NorSprZZ_Y" = RAM address associated with normal sprite Y of ID ZZ. Can also refer to a group of sprites if ZZ is XX.
; "GenSpr" = RAM address associated with a generator sprite.
; "Level" = RAM address associated with a level function
; "Cutscene" = RAM address associated with a cutscene
; "ErrorScreen" "SplashScreen" "TitleScreen" = Used on that specific screen.
; "Global" = Used anywhere or close to everywhere.

!RAM_SMBLL_Global_ScratchRAM00 = $000000
!RAM_SMBLL_Global_ScratchRAM01 = $000001
!RAM_SMBLL_Global_ScratchRAM02 = $000002
!RAM_SMBLL_Global_ScratchRAM03 = $000003
!RAM_SMBLL_Global_ScratchRAM04 = $000004
!RAM_SMBLL_Global_ScratchRAM05 = $000005
!RAM_SMBLL_Global_ScratchRAM06 = $000006
!RAM_SMBLL_Global_ScratchRAM07 = $000007

!RAM_SMBLL_Global_FrameCounter = $000009

!RAM_SMBLL_NorSpr_SpriteID = $00001C

!RAM_SMBLL_Global_EndOfStack = !RAM_SMBLL_Global_StartOfStack-$FF
!RAM_SMBLL_Global_StartOfStack = $0001FF

!RAM_SMBLL_Player_CurrentWorld = $00075F

!RAM_SMBLL_Player_CurrentLevel = $000761

!RAM_SMBLL_TitleScreen_MenuSelectionIndex = $00077A

!RAM_SMBLL_TitleScreen_TopScoreMillionsDigit = $0007C8
!RAM_SMBLL_TitleScreen_TopScoreHundredThousandsDigit = !RAM_SMBLL_TitleScreen_TopScoreMillionsDigit+$01
!RAM_SMBLL_TitleScreen_TopScoreTenThousandsDigit = !RAM_SMBLL_TitleScreen_TopScoreMillionsDigit+$02
!RAM_SMBLL_TitleScreen_TopScoreThousandsDigit = !RAM_SMBLL_TitleScreen_TopScoreMillionsDigit+$03
!RAM_SMBLL_TitleScreen_TopScoreHundredsDigit = !RAM_SMBLL_TitleScreen_TopScoreMillionsDigit+$04
!RAM_SMBLL_TitleScreen_TopScoreTensDigit = !RAM_SMBLL_TitleScreen_TopScoreMillionsDigit+$05

!RAM_SMBLL_Global_OAMBuffer = $000800
!RAM_SMBLL_Global_OAMTileSizeBuffer = $000C00

!RAM_SMBLL_Global_FixedColorData1Mirror = $000EE0
!RAM_SMBLL_Global_FixedColorData2Mirror = $000EE1
!RAM_SMBLL_Global_FixedColorData3Mirror = $000EE2

!RAM_SMBLL_Level_NoWorld9Flag = $000F2B

!RAM_SMBLL_Global_ControllerHold1 = $000FF4
!RAM_SMBLL_Global_ControllerPress1 = $000FF6
!RAM_SMBLL_Global_ControllerHold2 = $000FF8
!RAM_SMBLL_Global_ControllerPress2 = $000FFA
!RAM_SMBLL_Global_P1CtrlDisableLo = $000FFC
!RAM_SMBLL_Global_P1CtrlDisableHi = $000FFD

!RAM_SMBLL_Global_PaletteMirror = $001000

!RAM_SMBLL_Global_UpdateEntirePaletteFlag = $001200
!RAM_SMBLL_Global_ScreenDisplayRegisterMirror = $001201

!RAM_SMBLL_Global_HDMAEnableMirror = $001203

!RAM_SMBLL_Global_MainScreenLayersMirror = $00120B
!RAM_SMBLL_Global_SubScreenLayersMirror = $00120C
!RAM_SMBLL_Global_BGModeAndTileSizeSettingMirror = $00120D

!RAM_SMBLL_Global_SoundCh1 = $001600
!RAM_SMBLL_Global_SoundCh2 = !RAM_SMBLL_Global_SoundCh1+$01
!RAM_SMBLL_Global_MusicCh1 = !RAM_SMBLL_Global_SoundCh1+$02
!RAM_SMBLL_Global_SoundCh3 = !RAM_SMBLL_Global_SoundCh1+$03

!RAM_SMBLL_Global_StripeImageUploadIndexLo = $001700
!RAM_SMBLL_Global_StripeImageUploadIndexHi = !RAM_SMBLL_Global_StripeImageUploadIndexLo+$01
!RAM_SMBLL_Global_StripeImageUploadTable = !RAM_SMBLL_Global_StripeImageUploadIndexLo+$02

!RAM_SMBLL_Global_InitialWorld = $7FFB00
!RAM_SMBLL_Global_InitialLevel = $7FFB01

!RAM_SMBLL_Global_InitialNoWorld9 = $7FFB04
!RAM_SMBLL_Global_DisplayTitleScreenMenuOptionsIndex = $7FFB05

struct SMBLL_OAMBuffer !RAM_SMBLL_Global_OAMBuffer
	.XDisp: skip $01
	.YDisp: skip $01
	.Tile: skip $01
	.Prop: skip $01
endstruct align $04

struct SMBLL_UpperOAMBuffer !RAM_SMBLL_Global_OAMBuffer+$0200
	.Slot: skip $01
endstruct align $01

struct SMBLL_OAMTileSizeBuffer !RAM_SMBLL_Global_OAMTileSizeBuffer
	.Slot: skip $04
endstruct align $04

struct SMBLL_PaletteMirror !RAM_SMBLL_Global_PaletteMirror
	.LowByte: skip $01
	.HighByte: skip $01
endstruct align $02

struct SMBLL_StripeImageUploadTable !RAM_SMBLL_Global_StripeImageUploadTable
	.LowByte: skip $01
	.HighByte: skip $01
endstruct align $02

;Standalone ROM specific RAM addresses
!RAM_SMBLL_TitleScreen_EraseFileProcess = $000051
!RAM_SMBLL_SplashScreen_DisplayTimer = $000052
	!RAM_SMBLL_TitleScreen_FileAMaxWorld = $000052
!RAM_SMBLL_SplashScreen_PaletteAnimationTimer = $000053
	!RAM_SMBLL_TitleScreen_FileBMaxWorld = !RAM_SMBLL_TitleScreen_FileAMaxWorld+$01
!RAM_SMBLL_SplashScreen_PaletteAnimationIndex =  !RAM_SMBLL_SplashScreen_PaletteAnimationTimer+$01
	!RAM_SMBLL_TitleScreen_FileCMaxWorld = !RAM_SMBLL_TitleScreen_FileAMaxWorld+$02
!RAM_SMBLL_SplashScreen_DisplayMarioCoinShineFlag = $000055
	!RAM_SMBLL_TitleScreen_FileSelectProcess = $000055
!RAM_SMBLL_TitleScreen_FileASelectedWorld = $000056
!RAM_SMBLL_TitleScreen_FileBSelectedWorld = !RAM_SMBLL_TitleScreen_FileASelectedWorld+$01
!RAM_SMBLL_TitleScreen_FileCSelectedWorld = !RAM_SMBLL_TitleScreen_FileASelectedWorld+$02
!RAM_SMBLL_ErrorScreen_PaletteMirror = $000200						; Note: This must be set to $000200 or else problems may occur
!RAM_SMBLL_ErrorScreen_TextTilemap = $000800

struct SMBLL_ErrorScreen_TextTilemap !RAM_SMBLL_ErrorScreen_TextTilemap
	.Row: skip $40
endstruct

struct SMBLL_ErrorScreen_PaletteMirror !RAM_SMBLL_ErrorScreen_PaletteMirror
	.LowByte: skip $01
	.HighByte: skip $01
endstruct align $02
