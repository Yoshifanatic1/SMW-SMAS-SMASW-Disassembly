
;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_InitAndMainLoop(Address)
namespace SMAS_InitAndMainLoop
%InsertMacroAtXPosition(<Address>)

Main:
	SEI
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
	CLC
	XCE
endif
	STZ.w !REGISTER_IRQNMIAndJoypadEnableFlags
	STZ.w !REGISTER_HDMAEnable
	STZ.w !REGISTER_DMAEnable
	STZ.w !REGISTER_APUPort0
	STZ.w !REGISTER_APUPort1
	STZ.w !REGISTER_APUPort2
	STZ.w !REGISTER_APUPort3
	LDA.b #!ScreenDisplayRegister_SetForceBlank|!ScreenDisplayRegister_MinBrightness00
	STA.w !REGISTER_ScreenDisplayRegister
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	CLC
	XCE
endif
	REP.b #$38
	LDA.w #$0000
	TCD
	LDA.w #!RAM_SMAS_Global_StartOfStack
	TCS
	SEP.b #$30
	LDA.b #Main>>16
	PHA
	PLB
	LDA.w !REGISTER_PPUStatusFlag2
	BIT.b #!PPUStatusFlag2_ConsoleRegion
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E) != $00
	BNE.b CODE_00803B
else
	BEQ.b CODE_00803B
endif
	JMP.w SMAS_DisplayRegionErrorMessage_Main

CODE_008037:
	JML.l SMAS_DisplayCopyDetectionErrorMessage_Main

CODE_00803B:
	JSR.w SMAS_InitializeMostRAM_UploadSPCEngine
	LDA.b #$00
	STA.l !SRAM_SMAS_TitleScreen_CurrentGameDemo
	STA.l !SRAM_SMAS_Global_RunningDemoFlag
	REP.b #$20
	LDA.w #$8000
	STA.w !SRAM_SMAS_Global_UnknownSRAM000150
	STA.w !SRAM_SMAS_Global_UnknownSRAM000152
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
	STZ.w !SRAM_SMAS_Global_UnknownSRAM000154
endif
	SEP.b #$20
	LDA.b #$81
	STA.w !REGISTER_IRQNMIAndJoypadEnableFlags
	STA.w !RAM_SMAS_SplashScreen_DisplayTimer
	JSR.w SMAS_VerifySaveDataIsValid_Main
if !Define_SMAS_Global_DisableCopyDetection == !FALSE
	NOP #2
	LDA.b #$AA
	STA.l !SRAM_SMAS_Global_CopyDetectionCheck2
	CMP.l !SRAM_SMAS_Global_CopyDetectionCheck1
	BNE.b CODE_008037
	LDA.b #$55
	STA.l !SRAM_SMAS_Global_CopyDetectionCheck2
	CMP.l !SRAM_SMAS_Global_CopyDetectionCheck1
	BNE.b CODE_008037
endif
CODE_00807D:
	LDA.w !RAM_SMAS_Global_WaitForVBlankFlag
	BEQ.b CODE_00807D
#SA1Pack_MainLoopStartLocation:
	JSR.w SMAS_PollJoypadInputs_Main
	CLI
	INC.b !RAM_SMAS_Global_FrameCounter
	LDX.b !RAM_SMAS_Global_GameMode
	LDA.w SMAS_GameModeSettings_AllowSpritesFlags,x
	BEQ.b CODE_008092
	JSR.w SMAS_ResetSpriteOAMRt_Main
CODE_008092:
	JSL.l CODE_0080C7
	LDX.b !RAM_SMAS_Global_GameMode
	LDA.w SMAS_GameModeSettings_AllowSpritesFlags,x
	BEQ.b CODE_0080A0
	JSR.w SMAS_CompressOAMTileSizeBuffer_Main
CODE_0080A0:
	STZ.w !RAM_SMAS_Global_WaitForVBlankFlag
	JMP.w CODE_00807D

DATA_0080A6:
	db SMAS_GameMode00_SplashAndTitleScreen_Main
	db SMAS_GameMode01_InitializeGameSelectScreen_Main
	db SMAS_GameMode02_GameSelectScreen_Main
	db SMAS_GameMode03_InitializeEraseFileMenu_Main
	db SMAS_GameMode04_ShowEraseFileMenu_Main
	db SMAS_GameMode05_CloseEraseFileMenu_Main
	db SMAS_GameMode06_FadeOutAfterGameSelect_Main
	db SMAS_GameMode07_InitializeSelectedGame_Main
	db SMAS_GameMode08_LoadSelectedGame_Main
	db SMAS_GameMode09_LoadGameDemo_Main
	db $000000

DATA_0080B1:
	db SMAS_GameMode00_SplashAndTitleScreen_Main>>8
	db SMAS_GameMode01_InitializeGameSelectScreen_Main>>8
	db SMAS_GameMode02_GameSelectScreen_Main>>8
	db SMAS_GameMode03_InitializeEraseFileMenu_Main>>8
	db SMAS_GameMode04_ShowEraseFileMenu_Main>>8
	db SMAS_GameMode05_CloseEraseFileMenu_Main>>8
	db SMAS_GameMode06_FadeOutAfterGameSelect_Main>>8
	db SMAS_GameMode07_InitializeSelectedGame_Main>>8
	db SMAS_GameMode08_LoadSelectedGame_Main>>8
	db SMAS_GameMode09_LoadGameDemo_Main>>8
	db $000000>>8

DATA_0080BC:
	db SMAS_GameMode00_SplashAndTitleScreen_Main>>16
	db SMAS_GameMode01_InitializeGameSelectScreen_Main>>16
	db SMAS_GameMode02_GameSelectScreen_Main>>16
	db SMAS_GameMode03_InitializeEraseFileMenu_Main>>16
	db SMAS_GameMode04_ShowEraseFileMenu_Main>>16
	db SMAS_GameMode05_CloseEraseFileMenu_Main>>16
	db SMAS_GameMode06_FadeOutAfterGameSelect_Main>>16
	db SMAS_GameMode07_InitializeSelectedGame_Main>>16
	db SMAS_GameMode08_LoadSelectedGame_Main>>16
	db SMAS_GameMode09_LoadGameDemo_Main>>16
	db $000000>>16

CODE_0080C7:
	LDX.b !RAM_SMAS_Global_GameMode
	LDA.l DATA_0080A6,x
	STA.b !RAM_SMAS_Global_ScratchRAM03
	LDA.l DATA_0080B1,x
	STA.b !RAM_SMAS_Global_ScratchRAM04
	LDA.l DATA_0080BC,x
	STA.b !RAM_SMAS_Global_ScratchRAM05
	JMP.w [!RAM_SMAS_Global_ScratchRAM03]
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_ResetToSMASTitleScreen(Address)
namespace SMAS_ResetToSMASTitleScreen
%InsertMacroAtXPosition(<Address>)

Main:
	JSL.l SMAS_TurnOffIO_Main
	STZ.w !REGISTER_IRQNMIAndJoypadEnableFlags
	LDA.b #SMAS_InitAndMainLoop_Main>>16
	PHA
	PLB
	SEI
	STZ.w !REGISTER_IRQNMIAndJoypadEnableFlags
	STZ.w !REGISTER_HDMAEnable
	REP.b #$20
	LDA.w #!RAM_SMAS_Global_StartOfStack
	TCS
	SEP.b #$20
	STZ.b !RAM_SMAS_Global_SoundCh1
	STZ.b !RAM_SMAS_Global_SoundCh2
	STZ.b !RAM_SMAS_Global_MusicCh1
	STZ.b !RAM_SMAS_Global_SoundCh3
	STZ.w !REGISTER_APUPort0
	STZ.w !REGISTER_APUPort1
	STZ.w !REGISTER_APUPort2
	STZ.w !REGISTER_APUPort3
	LDA.b #$F0
	STA.w !REGISTER_APUPort1
	JSR.w SMAS_InitializeMostRAM_UploadSPCEngine
	STZ.b !RAM_SMAS_Global_GameMode
	LDA.b #$03
	STA.b !RAM_SMAS_TitleScreen_CurrentState
	LDA.b #$01
	STA.w !RAM_SMAS_Global_ScreenDisplayRegister
	LDA.b #$01
	STA.w !RAM_SMAS_Global_IRQEnableFlag
	LDA.b #$00
	STA.l !SRAM_SMAS_Global_RunningDemoFlag
	STA.l !RAM_SMAS_Global_CurrentGameX2
	LDA.b #$81
	STA.w !REGISTER_IRQNMIAndJoypadEnableFlags
	STA.w !RAM_SMAS_SplashScreen_DisplayTimer
	JMP.w SMAS_InitAndMainLoop_CODE_00807D
namespace off
endmacro

;--------------------------------------------------------------------

macro ROUTINE_SMAS_CopyOfResetToSMASTitleScreen(Address)
namespace SMAS_CopyOfResetToSMASTitleScreen
%InsertMacroAtXPosition(<Address>)

Main:
	JSL.l SMAS_TurnOffIO_Main
	STZ.w !REGISTER_IRQNMIAndJoypadEnableFlags
	LDA.b #SMAS_InitAndMainLoop_Main>>16
	PHA
	PLB
	SEI
	STZ.w !REGISTER_IRQNMIAndJoypadEnableFlags
	STZ.w !REGISTER_HDMAEnable
	REP.b #$20
	LDA.w #!RAM_SMAS_Global_StartOfStack
	TCS
	SEP.b #$20
	STZ.b !RAM_SMAS_Global_SoundCh1
	STZ.b !RAM_SMAS_Global_SoundCh2
	STZ.b !RAM_SMAS_Global_MusicCh1
	STZ.b !RAM_SMAS_Global_SoundCh3
	STZ.w !REGISTER_APUPort0
	STZ.w !REGISTER_APUPort1
	STZ.w !REGISTER_APUPort2
	STZ.w !REGISTER_APUPort3
	LDA.b #$F0
	STA.w !REGISTER_APUPort1
	JSR.w SMAS_InitializeMostRAM_UploadSPCEngine
	STZ.b !RAM_SMAS_Global_GameMode
	LDA.b #$03
	STA.b !RAM_SMAS_TitleScreen_CurrentState
	LDA.b #$01
	STA.w !RAM_SMAS_Global_ScreenDisplayRegister
	LDA.b #$01
	STA.w !RAM_SMAS_Global_IRQEnableFlag
	LDA.b #$00
	STA.l !SRAM_SMAS_Global_RunningDemoFlag
	STA.l !RAM_SMAS_Global_CurrentGameX2
	LDA.b #$81
	STA.w !REGISTER_IRQNMIAndJoypadEnableFlags
	STA.w !RAM_SMAS_SplashScreen_DisplayTimer
	JMP.w SMAS_InitAndMainLoop_CODE_00807D
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_CompressOAMTileSizeBuffer(Address)
namespace SMAS_CompressOAMTileSizeBuffer
%InsertMacroAtXPosition(<Address>)

Main:
	PHD
	LDA.b #SMAS_Global_UpperOAMBuffer[$00].Slot>>8
	XBA
	LDA.b #SMAS_Global_UpperOAMBuffer[$00].Slot
	TCD
	LDY.b #$1C
-:
	TYA
	ASL
	ASL
	TAX
	LDA.b SMAS_Global_OAMTileSizeBuffer[$03].Slot,x
	ASL
	ASL
	ORA.b SMAS_Global_OAMTileSizeBuffer[$02].Slot,x
	ASL
	ASL
	ORA.b SMAS_Global_OAMTileSizeBuffer[$01].Slot,x
	ASL
	ASL
	ORA.b SMAS_Global_OAMTileSizeBuffer[$00].Slot,x
	STA.w SMAS_Global_UpperOAMBuffer[$00].Slot,y
	LDA.b SMAS_Global_OAMTileSizeBuffer[$07].Slot,x
	ASL
	ASL
	ORA.b SMAS_Global_OAMTileSizeBuffer[$06].Slot,x
	ASL
	ASL
	ORA.b SMAS_Global_OAMTileSizeBuffer[$05].Slot,x
	ASL
	ASL
	ORA.b SMAS_Global_OAMTileSizeBuffer[$04].Slot,x
	STA.w SMAS_Global_UpperOAMBuffer[$01].Slot,y
	LDA.b SMAS_Global_OAMTileSizeBuffer[$0B].Slot,x
	ASL
	ASL
	ORA.b SMAS_Global_OAMTileSizeBuffer[$0A].Slot,x
	ASL
	ASL
	ORA.b SMAS_Global_OAMTileSizeBuffer[$09].Slot,x
	ASL
	ASL
	ORA.b SMAS_Global_OAMTileSizeBuffer[$08].Slot,x
	STA.w SMAS_Global_UpperOAMBuffer[$02].Slot,y
	LDA.b SMAS_Global_OAMTileSizeBuffer[$0F].Slot,x
	ASL
	ASL
	ORA.b SMAS_Global_OAMTileSizeBuffer[$0E].Slot,x
	ASL
	ASL
	ORA.b SMAS_Global_OAMTileSizeBuffer[$0D].Slot,x
	ASL
	ASL
	ORA.b SMAS_Global_OAMTileSizeBuffer[$0C].Slot,x
	STA.w SMAS_Global_UpperOAMBuffer[$03].Slot,y
	DEY
	DEY
	DEY
	DEY
	BPL.b -
	PLD
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_ResetSpriteOAMRt(Address)
namespace SMAS_ResetSpriteOAMRt
%InsertMacroAtXPosition(<Address>)

Main:
	PHD
	REP.b #$30
	LDA.w #!RAM_SMAS_Global_OAMBuffer
	TCD
	LDY.w #$F000
	LDX.w #$0180
-:
	TYA
	STA.b SMAS_Global_OAMBuffer[$00].XDisp,x
	STA.b SMAS_Global_OAMBuffer[$01].XDisp,x
	STA.b SMAS_Global_OAMBuffer[$02].XDisp,x
	STA.b SMAS_Global_OAMBuffer[$03].XDisp,x
	STA.b SMAS_Global_OAMBuffer[$04].XDisp,x
	STA.b SMAS_Global_OAMBuffer[$05].XDisp,x
	STA.b SMAS_Global_OAMBuffer[$06].XDisp,x
	STA.b SMAS_Global_OAMBuffer[$07].XDisp,x
	STA.b SMAS_Global_OAMBuffer[$08].XDisp,x
	STA.b SMAS_Global_OAMBuffer[$09].XDisp,x
	STA.b SMAS_Global_OAMBuffer[$0A].XDisp,x
	STA.b SMAS_Global_OAMBuffer[$0B].XDisp,x
	STA.b SMAS_Global_OAMBuffer[$0C].XDisp,x
	STA.b SMAS_Global_OAMBuffer[$0D].XDisp,x
	STA.b SMAS_Global_OAMBuffer[$0E].XDisp,x
	STA.b SMAS_Global_OAMBuffer[$0F].XDisp,x
	STA.b SMAS_Global_OAMBuffer[$10].XDisp,x
	STA.b SMAS_Global_OAMBuffer[$11].XDisp,x
	STA.b SMAS_Global_OAMBuffer[$12].XDisp,x
	STA.b SMAS_Global_OAMBuffer[$13].XDisp,x
	STA.b SMAS_Global_OAMBuffer[$14].XDisp,x
	STA.b SMAS_Global_OAMBuffer[$15].XDisp,x
	STA.b SMAS_Global_OAMBuffer[$16].XDisp,x
	STA.b SMAS_Global_OAMBuffer[$17].XDisp,x
	STA.b SMAS_Global_OAMBuffer[$18].XDisp,x
	STA.b SMAS_Global_OAMBuffer[$19].XDisp,x
	STA.b SMAS_Global_OAMBuffer[$1A].XDisp,x
	STA.b SMAS_Global_OAMBuffer[$1B].XDisp,x
	STA.b SMAS_Global_OAMBuffer[$1C].XDisp,x
	STA.b SMAS_Global_OAMBuffer[$1D].XDisp,x
	STA.b SMAS_Global_OAMBuffer[$1E].XDisp,x
	STA.b SMAS_Global_OAMBuffer[$1F].XDisp,x
	TXA
	SEC
	SBC.w #$0080
	TAX
	BPL.b -
	SEP.b #$30
	PLD
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_HandleSPCUploads(Address)
namespace SMAS_HandleSPCUploads
%InsertMacroAtXPosition(<Address>)

Main:
	PHP
	REP.b #$30
	LDY.w #$0000
	LDA.w #$BBAA
CODE_008C06:
	CMP.w !REGISTER_APUPort0
	BNE.b CODE_008C06
	SEP.b #$20
	LDA.b #$CC
	BRA.b CODE_008C37

CODE_008C11:
	LDA.b [!RAM_SMAS_Global_ScratchRAM00],y
	INY
	XBA
	LDA.b #$00
	BRA.b CODE_008C24

CODE_008C19:
	XBA
	LDA.b [!RAM_SMAS_Global_ScratchRAM00],y
	INY
	XBA
CODE_008C1E:
	CMP.w !REGISTER_APUPort0
	BNE.b CODE_008C1E
	INC
CODE_008C24:
	REP.b #$20
	STA.w !REGISTER_APUPort0
	SEP.b #$20
	DEX
	BNE.b CODE_008C19
CODE_008C2E:
	CMP.w !REGISTER_APUPort0
	BNE.b CODE_008C2E
CODE_008C33:
	ADC.b #$03
	BEQ.b CODE_008C33
CODE_008C37:
	PHA
	REP.b #$20
	LDA.b [!RAM_SMAS_Global_ScratchRAM00],y
	INY
	INY
	TAX
	LDA.b [!RAM_SMAS_Global_ScratchRAM00],y
	INY
	INY
	STA.w !REGISTER_APUPort2
	SEP.b #$20
	CPX.w #$0001
	LDA.b #$00
	ROL
	STA.w !REGISTER_APUPort1
	ADC.b #$7F
	PLA
	STA.w !REGISTER_APUPort0
CODE_008C57:
	CMP.w !REGISTER_APUPort0
	BNE.b CODE_008C57
	BVS.b CODE_008C11
	STZ.w !REGISTER_APUPort0
	STZ.w !REGISTER_APUPort1
	STZ.w !REGISTER_APUPort2
	STZ.w !REGISTER_APUPort3
	PLP
	RTS
namespace off
	%SetDuplicateOrNullPointer(SMAS_HandleSPCUploads_Main, SMB1_HandleSPCUploads_Main)
	%SetDuplicateOrNullPointer(SMAS_HandleSPCUploads_Main, SMB3_HandleSPCUploads_Main)
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_VBlankRoutine(Address)
namespace SMAS_VBlankRoutine
%InsertMacroAtXPosition(<Address>)

NMIPtrs:
	dw SMAS_NMI
	dw SMB1_NMI
	dw SMBLL_NMI
	dw SMB2U_NMI
	dw SMB3_NMI
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
if !Define_Global_SMASGames&(!SMASGames_SMW) != $00
	dw SMW_NMI
else
	NOP #2
endif
endif

Main:
	SEI
#SA1Pack_NMIHijack:
	REP.b #$30
	PHA
	PHX
	PHY
	PHD
	LDA.w #$0000
	TCD
#SA1Pack_NMIHijackEnd:
	PHB
	PHK
	PLB
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	PHA
	SEP.b #$30
	LDA.l !RAM_SMAS_Global_CurrentGameX2
	TAX
	JSR.w (NMIPtrs,x)
#SA1Pack_EndOfSNESNMI:
	REP.b #$30
	PLA
	STA.w !RAM_SMAS_Global_ScratchRAM00
	PLB
	PLD
	PLY
	PLX
	PLA
EndofVBlank:
	RTI

SMAS_NMI:
	LDA.b #!RAM_SMAS_Global_ScreenDisplayRegister>>8
	XBA
	LDA.b #!RAM_SMAS_Global_ScreenDisplayRegister
	TCD
	LDA.w !REGISTER_NMIEnable
	LDA.b !RAM_SMAS_Global_ScreenDisplayRegister
	STA.w !REGISTER_ScreenDisplayRegister
	STZ.w !REGISTER_HDMAEnable
	LDA.b !RAM_SMAS_Global_WaitForVBlankFlag
	BNE.b CODE_008353
	INC.b !RAM_SMAS_Global_WaitForVBlankFlag
	PHD
	JSR.w SMAS_UploadDataDuringVBlank_Main
	SEP.b #$30
	PLD
CODE_008353:
	JSR.w SMAS_UpdateVariousRegisters_Main
	JSR.w SMAS_PlaySoundEffectsAndMusic_Main
	LDX.b #$81
	LDA.b !RAM_SMAS_Global_IRQEnableFlag
	BEQ.b CODE_008376
	AND.b #$FE
	STA.b !RAM_SMAS_Global_UnknownRAM
	LDA.w !REGISTER_IRQEnable
	LDA.b !RAM_SMAS_Global_VCountTimerLo
	STA.w !REGISTER_VCountTimerLo
	STZ.w !REGISTER_VCountTimerHi
	STZ.w !REGISTER_HCountTimerLo
	STZ.w !REGISTER_HCountTimerHi
	LDX.b #$A1
CODE_008376:
	STX.w !REGISTER_IRQNMIAndJoypadEnableFlags
	LDA.b !RAM_SMAS_Global_ScreenDisplayRegister
	STA.w !REGISTER_ScreenDisplayRegister
	LDA.b !RAM_SMAS_Global_HDMAEnable
	STA.w !REGISTER_HDMAEnable
	RTS

SMB1_NMI:
	JSL.l SMB1_InitAndMainLoop_NMIVector
	RTS

SMBLL_NMI:
	JSL.l SMBLL_InitAndMainLoop_NMIVector
	RTS

SMB2U_NMI:
	JSL.l SMB2U_InitAndMainLoop_NMIVector
	RTS

SMB3_NMI:
	JSL.l SMB3_InitAndMainLoop_NMIVector
	RTS

if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
if !Define_Global_SMASGames&(!SMASGames_SMW) != $00
SMW_NMI:
	JSL.l SMW_InitAndMainLoop_NMIVector
	RTS
endif
endif
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_UploadDataDuringVBlank(Address)
namespace SMAS_UploadDataDuringVBlank
%InsertMacroAtXPosition(<Address>)

Main:
	LDA.b #DMA[$00].Parameters>>8
	XBA
	LDA.b #DMA[$00].Parameters
	TCD
	REP.b #$10
	LDX.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STX.b DMA[$00].Parameters
	LDA.b #$80
	STA.w !REGISTER_VRAMAddressIncrementValue
	LDA.w !RAM_SMAS_GameSelect_UploadFileSelectGFXFlag
	BEQ.b CODE_008941
CODE_00891D:
	LDX.w #$6C00
	STX.w !REGISTER_VRAMAddressLo
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDX.w #SMAS_FileSelectGFX_Main
else
	LDX.w !RAM_SMAS_GameSelect_FileSelectGFXPrtLo
endif
	STX.b DMA[$00].SourceLo
	LDA.b #SMAS_FileSelectGFX_Main>>16
	STA.b DMA[$00].SourceBank
	LDX.w #(SMAS_FileSelectGFX_Main_ControllerEnd-SMAS_FileSelectGFX_Main)
	STX.b DMA[$00].SizeLo
	LDA.b #$01
	STA.w !REGISTER_DMAEnable
	STZ.w !RAM_SMAS_GameSelect_UploadFileSelectGFXFlag
	STZ.w !RAM_SMAS_Global_TriangleTransitionEffectPtrLo
	STZ.w !RAM_SMAS_Global_TriangleTransitionEffectPtrHi
	RTS

CODE_008941:
	LDX.w !RAM_SMAS_Global_TriangleTransitionEffectPtrLo
	BEQ.b CODE_008962
	STX.b DMA[$00].SourceLo
	LDA.b #SMAS_TriangleTransitionalEffectGFX_Main>>16
	STA.b DMA[$00].SourceBank
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDX.w #$5000
	LDA.w !RAM_SMAS_Global_GameMode
	BEQ.b +
endif
	LDX.w #$7000
+:
	STX.w !REGISTER_VRAMAddressLo
	LDY.w #SMAS_TriangleTransitionalEffectGFX_End-SMAS_TriangleTransitionalEffectGFX_Main
	STY.b DMA[$00].SizeLo
	LDA.b #$01
	STA.w !REGISTER_DMAEnable
	STZ.w !RAM_SMAS_Global_TriangleTransitionEffectPtrLo
	STZ.w !RAM_SMAS_Global_TriangleTransitionEffectPtrHi
CODE_008962:
	LDA.w !RAM_SMAS_TitleScreen_UpdateTilemapFlag
	BEQ.b CODE_008983
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDX.w #$7800
else
	LDX.w #$7C00
endif
	STX.w !REGISTER_VRAMAddressLo
	LDX.w #!RAM_SMAS_TitleScreen_TilemapBuffer
	STX.b DMA[$00].SourceLo
	LDA.b #!RAM_SMAS_TitleScreen_TilemapBuffer>>16
	STA.b DMA[$00].SourceBank
	LDY.w #$0800
	STY.b DMA[$00].SizeLo
	LDA.b #$01
	STA.w !REGISTER_DMAEnable
	STZ.w !RAM_SMAS_TitleScreen_UpdateTilemapFlag
CODE_008983:
	LDA.w !RAM_SMAS_Global_UpdateEntirePaletteFlag
	BEQ.b CODE_0089A6
	STZ.w !REGISTER_CGRAMAddress
	LDY.w #(!REGISTER_WriteToCGRAMPort&$0000FF<<8)+$00
	STY.b DMA[$00].Parameters
	LDY.w #!RAM_SMAS_Global_PaletteMirror
	STY.b DMA[$00].SourceLo
	LDA.b #!RAM_SMAS_Global_PaletteMirror>>16
	STA.b DMA[$00].SourceBank
	LDY.w #$0200
	STY.b DMA[$00].SizeLo
	LDA.b #$01
	STA.w !REGISTER_DMAEnable
	STZ.w !RAM_SMAS_Global_UpdateEntirePaletteFlag
CODE_0089A6:
	REP.b #$20
	SEP.b #$10
	STZ.w !REGISTER_OAMAddressLo
	LDA.w #(!REGISTER_OAMDataWritePort&$0000FF<<8)+$00
	STA.b DMA[$00].Parameters
	LDA.w #!RAM_SMAS_Global_OAMBuffer
	STA.b DMA[$00].SourceLo
	STZ.b DMA[$00].SourceBank
	LDA.w #$0220
	STA.b DMA[$00].SizeLo
	LDY.b #$01
	STY.w !REGISTER_DMAEnable
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STA.b DMA[$00].Parameters
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STA.b DMA[$00].Parameters
	LDA.w #$0000
	TCD
	LDA.w #!RAM_SMAS_Global_StripeImageUploadTable
	STA.b !RAM_SMAS_Global_StripeImageDataLo
	SEP.b #$20
	LDA.b #!RAM_SMAS_Global_StripeImageUploadTable>>16
	STA.w DMA[$00].SourceBank
	STA.b !RAM_SMAS_Global_StripeImageDataBank
	REP.b #$10
	LDY.w #$0000
	JSR.w SMAS_LoadStripeImage_Main
	REP.b #$20
	LDA.w #$0000
	STA.l !RAM_SMAS_Global_StripeImageUploadIndexLo
	DEC
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_PlaySoundEffectsAndMusic(Address)
namespace SMAS_PlaySoundEffectsAndMusic
%InsertMacroAtXPosition(<Address>)

Main:
	LDA.w !RAM_SMAS_Global_MusicCh1
	BEQ.b CODE_008865
	STA.w !REGISTER_APUPort2
	CMP.b #!Define_SMB1_LevelMusic_StopMusicCommand
	BCS.b CODE_00881F
	STA.w !RAM_SMAS_Global_MusicRegisterBackup
CODE_00881F:
	LDA.w !RAM_SMAS_Global_SoundCh1
	BNE.b CODE_00882C
	LDY.w !REGISTER_APUPort0
	CPY.w !RAM_SMAS_Global_SoundCh1Backup
	BNE.b CODE_008832
CODE_00882C:
	STA.w !REGISTER_APUPort0
	STA.w !RAM_SMAS_Global_SoundCh1Backup
CODE_008832:
	LDA.w !RAM_SMAS_Global_SoundCh2
	BNE.b CODE_00883F
	LDY.w !REGISTER_APUPort1
	CPY.w !RAM_SMAS_Global_SoundCh2Backup
	BNE.b CODE_008845
CODE_00883F:
	STA.w !REGISTER_APUPort1
	STA.w !RAM_SMAS_Global_SoundCh2Backup
CODE_008845:
	LDA.w !RAM_SMAS_Global_SoundCh3
	BNE.b CODE_008852
	LDY.w !REGISTER_APUPort3
	CPY.w !RAM_SMAS_Global_SoundCh3Backup
	BNE.b CODE_008858
CODE_008852:
	STA.w !REGISTER_APUPort3
	STA.w !RAM_SMAS_Global_SoundCh3Backup
CODE_008858:
	STZ.w !RAM_SMAS_Global_SoundCh1
	STZ.w !RAM_SMAS_Global_SoundCh2
	STZ.w !RAM_SMAS_Global_MusicCh1
	STZ.w !RAM_SMAS_Global_SoundCh3
	RTS

CODE_008865:
	LDY.w !REGISTER_APUPort2
	CPY.w !RAM_SMAS_Global_MusicRegisterBackup
	BNE.b CODE_00881F
	STA.w !REGISTER_APUPort2
	BRA.b CODE_00881F
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_IRQRoutine(Address)
namespace SMAS_IRQRoutine
%InsertMacroAtXPosition(<Address>)

IRQPtrs:
	dw SMAS_IRQ
	dw SMB1_IRQ
	dw SMBLL_IRQ
	dw SMB2U_IRQ
	dw SMB3_IRQ
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
if !Define_Global_SMASGames&(!SMASGames_SMW) != $00
	dw SMW_IRQ
else
	NOP #2
endif
endif

Main:
	REP.b #$30
	PHA
	PHX
	PHY
	PHD
	LDA.w #$0000
	TCD
	PHB
	PHK
	PLB
	SEP.b #$30
	LDA.l !RAM_SMAS_Global_CurrentGameX2
	TAX
	JSR.w (IRQPtrs,x)
#SA1Pack_EndOfSNESIRQ:
	REP.b #$30
	PLB
	PLD
	PLY
	PLX
	PLA
	RTI

SMAS_IRQ:
	LDA.w !REGISTER_IRQEnable
	BPL.b CODE_0083DE
CODE_0083CD:
	BIT.w !REGISTER_HVBlankFlagsAndJoypadStatus
	BVC.b CODE_0083CD
	LDA.w !RAM_SMAS_GameSelect_Layer1XPosBelowCursorLo
	STA.w !REGISTER_BG1HorizScrollOffset
	LDA.w !RAM_SMAS_GameSelect_Layer1XPosBelowCursorHi
	STA.w !REGISTER_BG1HorizScrollOffset
CODE_0083DE:
	RTS

SMB1_IRQ:
	JSL.l SMB1_InitAndMainLoop_IRQVector
	RTS

SMBLL_IRQ:
	JSL.l SMBLL_InitAndMainLoop_IRQVector
	RTS

SMB2U_IRQ:
	JSL.l SMB2U_InitAndMainLoop_IRQVector
	RTS

SMB3_IRQ:
	JSL.l SMB3_InitAndMainLoop_IRQVector
	RTS

if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
if !Define_Global_SMASGames&(!SMASGames_SMW) != $00
SMW_IRQ:
	JSL.l SMW_InitAndMainLoop_IRQVector
	RTS
endif
endif
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_PollJoypadInputs(Address)
namespace SMAS_PollJoypadInputs
%InsertMacroAtXPosition(<Address>)

Main:
	STZ.w !REGISTER_JoypadSerialPort1
	LDA.w !REGISTER_Joypad1Lo
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w !REGISTER_Joypad1Hi
	STA.b !RAM_SMAS_Global_ScratchRAM01
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	STA.b !RAM_SMAS_Global_ControllerHold2CopyP1
	TAY
	EOR.b !RAM_SMAS_Global_P1CtrlDisableHi
	AND.b !RAM_SMAS_Global_ControllerHold2CopyP1
	STA.b !RAM_SMAS_Global_ControllerPress2CopyP1
	STY.b !RAM_SMAS_Global_P1CtrlDisableHi
	LDA.b !RAM_SMAS_Global_ScratchRAM01
	STA.b !RAM_SMAS_Global_ControllerHold1CopyP1
	TAY
	EOR.b !RAM_SMAS_Global_P1CtrlDisableLo
	AND.b !RAM_SMAS_Global_ControllerHold1CopyP1
	STA.b !RAM_SMAS_Global_ControllerPress1CopyP1
	STY.b !RAM_SMAS_Global_P1CtrlDisableLo
	NOP
	LDA.w !REGISTER_Joypad2Lo
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w !REGISTER_Joypad2Hi
	STA.b !RAM_SMAS_Global_ScratchRAM01
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	STA.b !RAM_SMAS_Global_ControllerHold2CopyP2
	TAY
	EOR.b !RAM_SMAS_Global_P2CtrlDisableHi
	AND.b !RAM_SMAS_Global_ControllerHold2CopyP2
	STA.b !RAM_SMAS_Global_ControllerPress2CopyP2
	STY.b !RAM_SMAS_Global_P2CtrlDisableHi
	LDA.b !RAM_SMAS_Global_ScratchRAM01
	STA.b !RAM_SMAS_Global_ControllerHold1CopyP2
	TAY
	EOR.b !RAM_SMAS_Global_P2CtrlDisableLo
	AND.b !RAM_SMAS_Global_ControllerHold1CopyP2
	STA.b !RAM_SMAS_Global_ControllerPress1CopyP2
	STY.b !RAM_SMAS_Global_P2CtrlDisableLo
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_DMADataBlockToRAM(Address)
namespace SMAS_DMADataBlockToRAM
%InsertMacroAtXPosition(<Address>)

Main:
	STA.w !REGISTER_WRAMAddressLo
	STY.w !REGISTER_WRAMAddressBank
	LDA.w #(!REGISTER_ReadOrWriteToWRAMPort&$0000FF<<8)+$00
	STA.w DMA[$00].Parameters
	LDA.b !RAM_SMAS_Global_ScratchRAM02
	STA.w DMA[$00].SourceLo
	LDY.b !RAM_SMAS_Global_ScratchRAM04
	STY.w DMA[$00].SourceBank
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	STA.w DMA[$00].SizeLo
	LDY.b #$01
	STY.w !REGISTER_DMAEnable
	RTL
namespace off
	%SetDuplicateOrNullPointer(SMAS_DMADataBlockToRAM_Main, SMB3_DMADataBlockToRAM_Main)
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_UpdateVariousRegisters(Address)
namespace SMAS_UpdateVariousRegisters
%InsertMacroAtXPosition(<Address>)

Main:
	REP.b #$10
	LDA.b !RAM_SMAS_Global_OAMSizeAndDataAreaDesignation
	STA.w !REGISTER_OAMSizeAndDataAreaDesignation
	LDX.b !RAM_SMAS_Global_BG1AddressAndSize
	STX.w !REGISTER_BG1AddressAndSize
	LDA.b !RAM_SMAS_Global_BG3AddressAndSize
	STA.w !REGISTER_BG3AddressAndSize
	LDA.b !RAM_SMAS_Global_BG1And2TileDataDesignation
	STA.w !REGISTER_BG1And2TileDataDesignation
	LDA.b !RAM_SMAS_Global_CurrentLayer1XPosLo
	STA.w !REGISTER_BG1HorizScrollOffset
	LDA.b !RAM_SMAS_Global_CurrentLayer1XPosHi
	STA.w !REGISTER_BG1HorizScrollOffset
	LDA.b !RAM_SMAS_Global_CurrentLayer1YPosLo
	STA.w !REGISTER_BG1VertScrollOffset
	LDA.b !RAM_SMAS_Global_CurrentLayer1YPosHi 
	STA.w !REGISTER_BG1VertScrollOffset
	LDA.b !RAM_SMAS_Global_CurrentLayer2XPosLo
	STA.w !REGISTER_BG2HorizScrollOffset
	LDA.b !RAM_SMAS_Global_CurrentLayer2XPosHi
	STA.w !REGISTER_BG2HorizScrollOffset
	LDA.b !RAM_SMAS_Global_CurrentLayer2YPosLo
	STA.w !REGISTER_BG2VertScrollOffset
	LDA.b !RAM_SMAS_Global_CurrentLayer2YPosHi
	STA.w !REGISTER_BG2VertScrollOffset
	LDA.b !RAM_SMAS_Global_CurrentLayer3XPosLo
	STA.w !REGISTER_BG3HorizScrollOffset
	LDA.b !RAM_SMAS_Global_CurrentLayer3XPosHi
	STA.w !REGISTER_BG3HorizScrollOffset
	LDA.b !RAM_SMAS_Global_CurrentLayer3YPosLo
	STA.w !REGISTER_BG3VertScrollOffset
	LDA.b !RAM_SMAS_Global_CurrentLayer3YPosHi
	STA.w !REGISTER_BG3VertScrollOffset
	LDA.b !RAM_SMAS_Global_FixedColorData1
	STA.w !REGISTER_FixedColorData
	LDA.b !RAM_SMAS_Global_FixedColorData2
	STA.w !REGISTER_FixedColorData
	LDA.b !RAM_SMAS_Global_FixedColorData3
	STA.w !REGISTER_FixedColorData
	LDX.b !RAM_SMAS_Global_MainScreenLayers
	STX.w !REGISTER_MainScreenLayers
	LDX.b !RAM_SMAS_Global_MainScreenWindowMask
	STX.w !REGISTER_MainScreenWindowMask
	LDX.b !RAM_SMAS_Global_BG1And2WindowMaskSettings
	STX.w !REGISTER_BG1And2WindowMaskSettings
	LDA.b !RAM_SMAS_Global_ObjectAndColorWindowSettings
	STA.w !REGISTER_ObjectAndColorWindowSettings
	LDX.b !RAM_SMAS_Global_ColorMathInitialSettings
	STX.w !REGISTER_ColorMathInitialSettings
	LDX.b !RAM_SMAS_Global_BGModeAndTileSizeSetting
	STX.w !REGISTER_BGModeAndTileSizeSetting
	SEP.b #$10
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_MakeFileSelectYoshiBlink(Address)
namespace SMAS_MakeFileSelectYoshiBlink
%InsertMacroAtXPosition(<Address>)

Main:
	LDY.w !RAM_SMAS_Global_YoshiAnimationIndex
	REP.b #$20
	LDA.l !RAM_SMAS_Global_StripeImageUploadIndexLo
	TAX
	LDA.w #$DC7E
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	LDA.w #$0400
	STA.l SMAS_Global_StripeImageUploadTable[$01].LowByte,x
	LDA.w DATA_00A8B7,y
	STA.l SMAS_Global_StripeImageUploadTable[$02].LowByte,x
	INC
	STA.l SMAS_Global_StripeImageUploadTable[$03].LowByte,x
	LDA.w #$FFFF
	STA.l SMAS_Global_StripeImageUploadTable[$04].LowByte,x
	LDA.l !RAM_SMAS_Global_StripeImageUploadIndexLo
	CLC
	ADC.w #$0008
	STA.l !RAM_SMAS_Global_StripeImageUploadIndexLo
	SEP.b #$20
	INC.w !RAM_SMAS_Global_YoshiAnimationIndex
	INC.w !RAM_SMAS_Global_YoshiAnimationIndex
	TYA
	LSR
	TAY
	LDA.w DATA_00A8BD,y
	STA.w !RAM_SMAS_GameSelect_YoshiAnimationTimer
	CMP.b #$80
	BNE.b CODE_00A8B6
	STZ.w !RAM_SMAS_Global_YoshiAnimationIndex
CODE_00A8B6:
	RTS

DATA_00A8B7:
	dw $038D,$038B,$0376

DATA_00A8BD:
	db $02,$04,$80,$08,$04,$80
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_MakeFileSelectYoshiLick(Address)
namespace SMAS_MakeFileSelectYoshiLick
%InsertMacroAtXPosition(<Address>)

Main:
	LDX.w !RAM_SMAS_Global_YoshiAnimationIndex
	PHB
	LDA.b #!RAM_SMAS_Global_StripeImageUploadIndexLo>>16
	PHA
	PLB
	REP.b #$20
	LDY.w !RAM_SMAS_Global_StripeImageUploadIndexLo
	LDA.w #$FB7E
	STA.w SMAS_Global_StripeImageUploadTable[$00].LowByte,y
	LDA.w #$0400
	STA.w SMAS_Global_StripeImageUploadTable[$01].LowByte,y
	LDA.l DATA_00A956,x
	STA.w SMAS_Global_StripeImageUploadTable[$02].LowByte,y
	LDA.l DATA_00A95E,x
	STA.w SMAS_Global_StripeImageUploadTable[$03].LowByte,y
	LDA.w #$1B7F
	STA.w SMAS_Global_StripeImageUploadTable[$04].LowByte,y
	LDA.w #$0600
	STA.w SMAS_Global_StripeImageUploadTable[$05].LowByte,y
	LDA.l DATA_00A966,x
	STA.w SMAS_Global_StripeImageUploadTable[$06].LowByte,y
	LDA.l DATA_00A96E,x
	STA.w SMAS_Global_StripeImageUploadTable[$07].LowByte,y
	LDA.l DATA_00A976,x
	STA.w SMAS_Global_StripeImageUploadTable[$08].LowByte,y
	LDA.w #$3B7F
	STA.w SMAS_Global_StripeImageUploadTable[$09].LowByte,y
	LDA.w #$0600
	STA.w SMAS_Global_StripeImageUploadTable[$0A].LowByte,y
	LDA.l DATA_00A97E,x
	STA.w SMAS_Global_StripeImageUploadTable[$0B].LowByte,y
	LDA.l DATA_00A986,x
	STA.w SMAS_Global_StripeImageUploadTable[$0C].LowByte,y
	LDA.l DATA_00A98E,x
	STA.w SMAS_Global_StripeImageUploadTable[$0D].LowByte,y
	LDA.w #$FFFF
	STA.w SMAS_Global_StripeImageUploadTable[$0E].LowByte,y
	LDA.w !RAM_SMAS_Global_StripeImageUploadIndexLo
	CLC
	ADC.w #$001C
	STA.w !RAM_SMAS_Global_StripeImageUploadIndexLo
	SEP.b #$20
	PLB
	INC.w !RAM_SMAS_Global_YoshiAnimationIndex
	INC.w !RAM_SMAS_Global_YoshiAnimationIndex
	TXA
	LSR
	TAX
	LDA.w DATA_00A996,x
	STA.w !RAM_SMAS_GameSelect_YoshiAnimationTimer
	CMP.b #$80
	BNE.b CODE_00A955
	STZ.w !RAM_SMAS_Global_YoshiAnimationIndex
CODE_00A955:
	RTS

DATA_00A956:
	dw $0385,$0270,$0385,$0385

DATA_00A95E:
	dw $0386,$0259,$0386,$0386

DATA_00A966:
	dw $0368,$0280,$0279,$036C

DATA_00A96E:
	dw $0369,$0269,$0289,$036D

DATA_00A976:
	dw $039C,$039C,$039C,$036E

DATA_00A97E:
	dw $039D,$039D,$039D,$037C

DATA_00A986:
	dw $039E,$039E,$039E,$037D

DATA_00A98E:
	dw $039F,$039F,$039F,$037E

DATA_00A996:
	db $02,$08,$08,$80
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_UploadSMASSPCEngine(Address)
namespace SMAS_UploadSMASSPCEngine
%InsertMacroAtXPosition(<Address>)

Main:
	REP.b #$20
	LDA.w #SMAS_SPCEngine_Section1End-SMAS_SPCEngine_Section1
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #SMAS_SPCEngine_Section1
	STA.b !RAM_SMAS_Global_ScratchRAM02
	LDY.b #SMAS_SPCEngine_Section1>>16
	STY.b !RAM_SMAS_Global_ScratchRAM04
	LDA.w #!RAM_SMAS_SplashScreen_SPCEngineBuffer
	LDY.b #!RAM_SMAS_SplashScreen_SPCEngineBuffer>>16
	JSL.l SMAS_DMADataBlockToRAM_Main
	LDA.w #SMAS_SPCEngine_RandomChatterSampleDataEnd-SMAS_SPCEngine_Section2	; Optimization: For whatever reason, this size value is set to be an entire ROM bank.
	STA.b !RAM_SMAS_Global_ScratchRAM00						; The last 3,635 bytes of bank 3B aren't used as far as I can tell.
	LDA.w #SMAS_SPCEngine_Section2
	STA.b !RAM_SMAS_Global_ScratchRAM02
	LDY.b #SMAS_SPCEngine_Section2>>16
	STY.b !RAM_SMAS_Global_ScratchRAM04
	LDA.w #!RAM_SMAS_SplashScreen_SPCEngineBuffer+$0400
	LDY.b #(!RAM_SMAS_SplashScreen_SPCEngineBuffer+$0400)>>16
	JSL.l SMAS_DMADataBlockToRAM_Main
	SEP.b #$20
	STZ.b !RAM_SMAS_Global_ScratchRAM00
	LDA.b #!RAM_SMAS_SplashScreen_SPCEngineBuffer>>8
	STA.b !RAM_SMAS_Global_ScratchRAM01
	LDA.b #!RAM_SMAS_SplashScreen_SPCEngineBuffer>>16
	STA.b !RAM_SMAS_Global_ScratchRAM02
	JMP.w SMAS_HandleSPCUploads_Main
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro DATATABLE_RT00_SMAS_SPCEngine(Address)
namespace SMAS_SPCEngine
%InsertMacroAtXPosition(<Address>)

Section1:
	incbin "SPC700/Engine.bin":0-400
Section1End:
namespace off
endmacro

macro DATATABLE_RT01_SMAS_SPCEngine(Address)
namespace SMAS_SPCEngine
%InsertMacroAtXPosition(<Address>)

Section2:
	incbin "SPC700/Engine.bin":400-
Section2End:

MusicBank:
;$3B9DD3
	incbin "SPC700/SMAS_MusicBank.bin"
MusicBankEnd:

RandomChatterSampleData:
;$3BA251
	incbin "SPC700/RandomChatterSamples.bin"
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	%FREE_BYTES(NULLROM, 1939, $FF)						; Optimization: This block of freespace at $3BF86D should not be uploaded alongside the random chatter sample.
else
	%FREE_BYTES(NULLROM, 3635, $FF)						; Optimization: This block of freespace at $3BF1CD should not be uploaded alongside the random chatter sample.
endif
RandomChatterSampleDataEnd:
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

; Note: The random chattering sample data is uploaded automatically when the SPC engine is uploaded. This is called in the middle of the title screen.

macro ROUTINE_SMAS_UploadRandomTitleScreenChatteringSample(Address)
namespace SMAS_UploadRandomTitleScreenChatteringSample
%InsertMacroAtXPosition(<Address>)

Main:
	SEI
	STZ.w !REGISTER_IRQNMIAndJoypadEnableFlags
	STZ.w !REGISTER_HDMAEnable
	STZ.w !REGISTER_APUPort0
	LDA.b #$FF
	STA.w !REGISTER_APUPort1
	STZ.w !REGISTER_APUPort2
	STZ.w !REGISTER_APUPort3
	LDA.b #SMAS_SPCEngine_RandomChatterSampleData
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.b #SMAS_SPCEngine_RandomChatterSampleData>>8
	STA.b !RAM_SMAS_Global_ScratchRAM01
	LDA.b #SMAS_SPCEngine_RandomChatterSampleData>>16
	STA.b !RAM_SMAS_Global_ScratchRAM02
	JSR.w SMAS_HandleSPCUploads_Main
	LDA.b #$81
	STA.w !REGISTER_IRQNMIAndJoypadEnableFlags
	INC.b !RAM_SMAS_TitleScreen_CurrentState
	LDA.b #!Define_SMAS_Sound0060_RandomChatter
	STA.b !RAM_SMAS_Global_SoundCh1
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

; Note: The random chattering data is uploaded automatically when the SPC engine is uploaded. This is called in the middle of the title screen.

macro ROUTINE_RT00_SMAS_UploadMainSampleData(Address)
namespace SMAS_UploadMainSampleData
%InsertMacroAtXPosition(<Address>)

TitleScreenEntry:
	SEI
	STZ.w !REGISTER_IRQNMIAndJoypadEnableFlags
	STZ.w !REGISTER_HDMAEnable
	STZ.w !REGISTER_APUPort0
	LDA.b #$FF
	STA.w !REGISTER_APUPort1
	STZ.w !REGISTER_APUPort2
	STZ.w !REGISTER_APUPort3
	STZ.b !RAM_SMAS_Global_ScratchRAM00
	LDA.b #SampleData>>8
	STA.b !RAM_SMAS_Global_ScratchRAM01
	LDA.b #SampleData>>16
	STA.b !RAM_SMAS_Global_ScratchRAM02
	JSR.w SMAS_HandleSPCUploads_Main
	LDA.b #$81
	STA.w !REGISTER_IRQNMIAndJoypadEnableFlags
	INC.b !RAM_SMAS_TitleScreen_CurrentState
	LDA.b #!Define_SMAS_Sound0060_ResumeMusic
	STA.b !RAM_SMAS_Global_SoundCh1
	RTS

Main:
	SEI
	STZ.w !REGISTER_IRQNMIAndJoypadEnableFlags
	STZ.w !REGISTER_HDMAEnable
	STZ.w !REGISTER_DMAEnable
	STZ.w !REGISTER_APUPort0
	LDA.b #$FF
	STA.w !REGISTER_APUPort1
	STZ.w !REGISTER_APUPort2
	STZ.w !REGISTER_APUPort3
	STZ.b !RAM_SMAS_Global_ScratchRAM00
	LDA.b #SampleData>>8
	STA.b !RAM_SMAS_Global_ScratchRAM01
	LDA.b #SampleData>>16
	STA.b !RAM_SMAS_Global_ScratchRAM02
	JSR.w SMAS_HandleSPCUploads_Main
	LDA.b #$81
	STA.w !REGISTER_IRQNMIAndJoypadEnableFlags
	RTS
namespace off
endmacro

macro ROUTINE_RT01_SMAS_UploadMainSampleData(Address)
namespace SMAS_UploadMainSampleData
%InsertMacroAtXPosition(<Address>)

SampleData:
	incbin "SPC700/MainSamples.bin"
SampleDataEnd:
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

; Note: The random chattering data is uploaded automatically when the SPC engine is uploaded. This is called in the middle of the title screen.

macro DATATABLE_SMAS_PauseMenuGFX(Address)
namespace SMAS_PauseMenuGFX
%InsertMacroAtXPosition(<Address>)

Main:
	incbin "Graphics/PauseMenuGFX.bin"
End:

namespace off
	%SetDuplicateOrNullPointer(SMAS_PauseMenuGFX_Main, SMB1_PauseMenuGFX_Main)
	%SetDuplicateOrNullPointer(SMAS_PauseMenuGFX_Main, SMBLL_PauseMenuGFX_Main)
	%SetDuplicateOrNullPointer(SMAS_PauseMenuGFX_Main, SMB3_PauseMenuGFX_Main)
	%SetDuplicateOrNullPointer(SMAS_PauseMenuGFX_End, SMB1_PauseMenuGFX_End)
	%SetDuplicateOrNullPointer(SMAS_PauseMenuGFX_End, SMBLL_PauseMenuGFX_End)
	%SetDuplicateOrNullPointer(SMAS_PauseMenuGFX_End, SMB3_PauseMenuGFX_End)
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_DisplayRegionErrorMessage(Address)
namespace SMAS_DisplayRegionErrorMessage
%InsertMacroAtXPosition(<Address>)

table "Tables/Fonts/ErrorScreen.txt"

RegionErrorText:
.Line1:
	dw " THIS GAME PAK IS NOT   "

.Line2:
	dw "DESIGINED FOR YOUR SUPER"

.Line3:
	dw "FAMICOM OR SUPER NES.   "

.Line4:
	dw "   NINTENDO CO.,LTD.    "

cleartable

Main:
	JSR.w SMAS_InitializeMostRAM_Main
	SEP.b #$20
	PHD
	STZ.w !REGISTER_CGRAMAddress
	REP.b #$20
	LDA.w #$3B3B
	STA.b !RAM_SMAS_Global_ScratchRAM02
	LDA.w #!RAM_SMAS_ErrorScreen_TextTilemap
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDY.b #!RAM_SMAS_ErrorScreen_TextTilemap>>16
	JSL.l SMAS_InitializeSelectedRAM_Entry2
	LDA.w #DMA[$00].Parameters
	TCD
	LDY.b #$80
	STY.w !REGISTER_VRAMAddressIncrementValue
	LDA.w #$7FFF
	STA.w SMAS_ErrorScreen_PaletteMirror[$0C].LowByte
	LDA.w #$7FF9
	STA.w SMAS_ErrorScreen_PaletteMirror[$0D].LowByte
	LDA.w #$7FD0
	STA.w SMAS_ErrorScreen_PaletteMirror[$0E].LowByte
	LDA.w #$6AE9
	STA.w SMAS_ErrorScreen_PaletteMirror[$0F].LowByte
	LDA.w #(!REGISTER_WriteToCGRAMPort&$0000FF<<8)+$00
	STA.b DMA[$00].Parameters
	LDA.w #!RAM_SMAS_ErrorScreen_PaletteMirror
	STA.b DMA[$00].SourceLo
	LDX.b #!RAM_SMAS_ErrorScreen_PaletteMirror>>16
	STX.b DMA[$00].SourceBank
	STA.b DMA[$00].SizeLo
	LDY.b #$01
	STY.w !REGISTER_DMAEnable
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STA.b DMA[$00].Parameters
	LDA.w #$0000
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #SMAS_ErrorMessageFontGFX_Main
	STA.b DMA[$00].SourceLo
	LDX.b #SMAS_ErrorMessageFontGFX_Main>>16
	STX.b DMA[$00].SourceBank
	LDA.w #SMAS_ErrorMessageFontGFX_End-SMAS_ErrorMessageFontGFX_Main
	STA.b DMA[$00].SizeLo
	STY.w !REGISTER_DMAEnable
	PHB
	LDX.b #RegionErrorText>>16
	PHX
	PLB
	LDX.b #$00
CODE_0093F9:
	LDA.w RegionErrorText_Line1,x
	STA.w SMAS_ErrorScreen_TextTilemap[$07].Row+$0A,x
	LDA.w RegionErrorText_Line2,x
	STA.w SMAS_ErrorScreen_TextTilemap[$09].Row+$0A,x
	LDA.w RegionErrorText_Line3,x
	STA.w SMAS_ErrorScreen_TextTilemap[$0B].Row+$0A,x
	LDA.w RegionErrorText_Line4,x
	STA.w SMAS_ErrorScreen_TextTilemap[$11].Row+$0A,x
	INX
	INX
	CPX.b #RegionErrorText_Line2-RegionErrorText_Line1
	BNE.b CODE_0093F9
CODE_009417:
	PLB
	LDA.w #$1000
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #!RAM_SMAS_ErrorScreen_TextTilemap
	STA.b DMA[$00].SourceLo
	LDX.b #!RAM_SMAS_ErrorScreen_TextTilemap>>16
	STX.b DMA[$00].SourceBank
	STA.b DMA[$00].SizeLo
	STY.w !REGISTER_DMAEnable
	SEP.b #$20
	PLD
	LDA.b #$10
	STA.w !REGISTER_BG1AddressAndSize
	STZ.w !REGISTER_BG1And2TileDataDesignation
	LDA.b #$01
	STA.w !REGISTER_MainScreenLayers
	STZ.w !REGISTER_SubScreenLayers
	LDA.b #$01
	STA.w !REGISTER_BGModeAndTileSizeSetting
	STZ.w !REGISTER_ColorMathInitialSettings
	STZ.w !REGISTER_ColorMathSelectAndEnable
	STZ.w !REGISTER_BG1HorizScrollOffset
	STZ.w !REGISTER_BG1HorizScrollOffset
	STZ.w !REGISTER_BG1VertScrollOffset
	STZ.w !REGISTER_BG1VertScrollOffset
	STZ.w !REGISTER_BG2HorizScrollOffset
	STZ.w !REGISTER_BG2HorizScrollOffset
	STZ.w !REGISTER_BG2VertScrollOffset
	STZ.w !REGISTER_BG2VertScrollOffset
	STZ.w !REGISTER_BG3HorizScrollOffset
	STZ.w !REGISTER_BG3HorizScrollOffset
	STZ.w !REGISTER_BG3VertScrollOffset
	STZ.w !REGISTER_BG3VertScrollOffset
	LDA.b #!ScreenDisplayRegister_MaxBrightness0F
	STA.w !REGISTER_ScreenDisplayRegister
CODE_009473:
	BIT.w !REGISTER_HVBlankFlagsAndJoypadStatus
	BPL.b CODE_009473
	INC.b !RAM_SMAS_Global_FrameCounter
	LDA.b !RAM_SMAS_Global_FrameCounter
	CMP.b #$18
	BNE.b CODE_0094BF
	STZ.b !RAM_SMAS_Global_FrameCounter
	STZ.w !REGISTER_CGRAMAddress
	REP.b #$20
	LDA.w #DMA[$00].Parameters
	TCD
	LDY.b #$80
	STY.w !REGISTER_VRAMAddressIncrementValue
	LDA.w SMAS_ErrorScreen_PaletteMirror[$0D].LowByte
	PHA
	LDA.w SMAS_ErrorScreen_PaletteMirror[$0E].LowByte
	STA.w SMAS_ErrorScreen_PaletteMirror[$0D].LowByte
	LDA.w SMAS_ErrorScreen_PaletteMirror[$0F].LowByte
	STA.w SMAS_ErrorScreen_PaletteMirror[$0E].LowByte
	PLA
	STA.w SMAS_ErrorScreen_PaletteMirror[$0F].LowByte
	LDA.w #(!REGISTER_WriteToCGRAMPort&$0000FF<<8)+$00
	STA.b DMA[$00].Parameters
	LDA.w #!RAM_SMAS_ErrorScreen_PaletteMirror
	STA.b DMA[$00].SourceLo
	LDX.b #!RAM_SMAS_ErrorScreen_PaletteMirror>>16
	STX.b DMA[$00].SourceBank
	STA.b DMA[$00].SizeLo
	LDY.b #$01
	STY.w !REGISTER_DMAEnable
	LDA.w #$0000
	TCD
	SEP.b #$20
CODE_0094BF:
	BIT.w !REGISTER_HVBlankFlagsAndJoypadStatus
	BMI.b CODE_0094BF
	JMP.w CODE_009473
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_DisplayCopyDetectionErrorMessage(Address)
namespace SMAS_DisplayCopyDetectionErrorMessage
%InsertMacroAtXPosition(<Address>)

table "Tables/Fonts/ErrorScreen.txt"

CopyDetectionText:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E) != $00
.Line1:
	dw "         WARNING          "

.Line2:
	dw "IT IS A SERIOUS CRIME TO  "

.Line3:
	dw "COPY VIDEO GAMES ACCORDING"

.Line4:
	dw "TO COPYRIGHT LAW.  PLEASE "

.Line5:
	dw "REFER TO YOUR NINTENDO    "

.Line6:
	dw "GAME INSTRUCTION BOOKLET  "

.Line7:
	dw "FOR FURTHER INFORMATION.  "

elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_E) != $00
.Line1:
	dw "TO RESUME GAME PLAY, TURN"

.Line2:
	dw "OFF YOUR CONTROL DECK AND"

.Line3:
	dw "DISCONNECT ANY ATTACHMENT"

.Line4:
	dw "OR GAME ALTERING DEVICE. "

.Line5:
	dw "REFER TO YOUR GAME PAK   "

.Line6:
	dw "INSTRUCTION BOOKLET FOR  "

.Line7:
	dw "FURTHER INFORMATION.     "

elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
.Line1:
	dw "WARNING: IT IS A SERIOUS "

.Line2:
	dw "CRIME TO COPY VIDEO GAMES "

.Line3:
	dw "ACCORDING TO COPYRIGHT   "

.Line4:
	dw "LAW.                     "

.Line5:
	dw "PLEASE REFER TO YOUR     "

.Line6:
	dw "NINTENDO GAME INSTRUCTION"

.Line7:
	dw "BOOKLET FOR FURTHER      "

.Line8:
	dw "INFORMATION.             "

else
.Line1:
	dw "WARNING: IT IS A SERIOUS  "

.Line2:
	dw "CRIME TO COPY VIDEO GAMES."

.Line3:
	dw "18 USC 2319 PLEASE REFER  "

.Line4:
	dw "TO YOUR NINTENDO GAME     "

.Line5:
	dw "INSTRUCTION BOOKLET FOR   "

.Line6:
	dw "FURTHER INFORMATION.      "
endif

cleartable

Main:
	SEI
	STZ.w !REGISTER_IRQNMIAndJoypadEnableFlags
	STZ.w !REGISTER_HDMAEnable
	STZ.w !REGISTER_DMAEnable
	LDA.b #!ScreenDisplayRegister_SetForceBlank|!ScreenDisplayRegister_MinBrightness00
	STA.w !REGISTER_ScreenDisplayRegister
	STZ.w !REGISTER_APUPort0
	STZ.w !REGISTER_APUPort1
	STZ.w !REGISTER_APUPort3
	LDA.b #!Define_SMAS_LevelMusic_StopMusicCommand
	STA.w !REGISTER_APUPort2
	JSR.w SMAS_InitializeMostRAM_Main
	SEP.b #$20
	PHD
	STZ.w !REGISTER_CGRAMAddress
	REP.b #$20
	LDA.w #$3B3B
	STA.b !RAM_SMAS_Global_ScratchRAM02
	LDA.w #!RAM_SMAS_ErrorScreen_TextTilemap
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDY.b #!RAM_SMAS_ErrorScreen_TextTilemap>>16
	JSL.l SMAS_InitializeSelectedRAM_Entry2
	LDA.w #DMA[$00].Parameters
	TCD
	LDY.b #$80
	STY.w !REGISTER_VRAMAddressIncrementValue
	LDA.w #$7FFF
	STA.w SMAS_ErrorScreen_PaletteMirror[$0C].LowByte
	LDA.w #$7FF9
	STA.w SMAS_ErrorScreen_PaletteMirror[$0D].LowByte
	LDA.w #$7FD0
	STA.w SMAS_ErrorScreen_PaletteMirror[$0E].LowByte
	LDA.w #$6AE9
	STA.w SMAS_ErrorScreen_PaletteMirror[$0F].LowByte
	LDA.w #(!REGISTER_WriteToCGRAMPort&$0000FF<<8)+$00
	STA.b DMA[$00].Parameters
	LDA.w #!RAM_SMAS_ErrorScreen_PaletteMirror
	STA.b DMA[$00].SourceLo
	LDX.b #!RAM_SMAS_ErrorScreen_PaletteMirror>>16
	STX.b DMA[$00].SourceBank
	STA.b DMA[$00].SizeLo
	LDY.b #$01
	STY.w !REGISTER_DMAEnable
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STA.b DMA[$00].Parameters
	LDA.w #$0000
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #SMAS_ErrorMessageFontGFX_Main
	STA.b DMA[$00].SourceLo
	LDX.b #SMAS_ErrorMessageFontGFX_Main>>16
	STX.b DMA[$00].SourceBank
	LDA.w #SMAS_ErrorMessageFontGFX_End-SMAS_ErrorMessageFontGFX_Main
	STA.b DMA[$00].SizeLo
	STY.w !REGISTER_DMAEnable
	PHB
	LDX.b #CopyDetectionText>>16
	PHX
	PLB
	LDX.b #$00
CODE_009690:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E) != $00
	LDA.w CopyDetectionText_Line1,x
	STA.w SMAS_ErrorScreen_TextTilemap[$07].Row+$06,x
	LDA.w CopyDetectionText_Line2,x
	STA.w SMAS_ErrorScreen_TextTilemap[$09].Row+$06,x
	LDA.w CopyDetectionText_Line3,x
	STA.w SMAS_ErrorScreen_TextTilemap[$0B].Row+$06,x
	LDA.w CopyDetectionText_Line4,x
	STA.w SMAS_ErrorScreen_TextTilemap[$0D].Row+$06,x
	LDA.w CopyDetectionText_Line5,x
	STA.w SMAS_ErrorScreen_TextTilemap[$0F].Row+$06,x
	LDA.w CopyDetectionText_Line6,x
	STA.w SMAS_ErrorScreen_TextTilemap[$11].Row+$06,x
	LDA.w CopyDetectionText_Line7,x
	STA.w SMAS_ErrorScreen_TextTilemap[$13].Row+$06,x
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.w CopyDetectionText_Line1,x
	STA.w SMAS_ErrorScreen_TextTilemap[$06].Row+$08,x
	LDA.w CopyDetectionText_Line2,x
	STA.w SMAS_ErrorScreen_TextTilemap[$08].Row+$08,x
	LDA.w CopyDetectionText_Line3,x
	STA.w SMAS_ErrorScreen_TextTilemap[$0A].Row+$08,x
	LDA.w CopyDetectionText_Line4,x
	STA.w SMAS_ErrorScreen_TextTilemap[$0C].Row+$08,x
	LDA.w CopyDetectionText_Line5,x
	STA.w SMAS_ErrorScreen_TextTilemap[$10].Row+$08,x
	LDA.w CopyDetectionText_Line6,x
	STA.w SMAS_ErrorScreen_TextTilemap[$12].Row+$08,x
	LDA.w CopyDetectionText_Line7,x
	STA.w SMAS_ErrorScreen_TextTilemap[$14].Row+$08,x
	LDA.w CopyDetectionText_Line8,x
	STA.w SMAS_ErrorScreen_TextTilemap[$16].Row+$08,x
else
	LDA.w CopyDetectionText_Line1,x
	STA.w SMAS_ErrorScreen_TextTilemap[$07].Row+$06,x
	LDA.w CopyDetectionText_Line2,x
	STA.w SMAS_ErrorScreen_TextTilemap[$09].Row+$06,x
	LDA.w CopyDetectionText_Line3,x
	STA.w SMAS_ErrorScreen_TextTilemap[$0D].Row+$06,x
	LDA.w CopyDetectionText_Line4,x
	STA.w SMAS_ErrorScreen_TextTilemap[$0F].Row+$06,x
	LDA.w CopyDetectionText_Line5,x
	STA.w SMAS_ErrorScreen_TextTilemap[$11].Row+$06,x
	LDA.w CopyDetectionText_Line6,x
	STA.w SMAS_ErrorScreen_TextTilemap[$13].Row+$06,x
endif
	INX
	INX
	CPX.b #CopyDetectionText_Line2-CopyDetectionText_Line1
	BNE CODE_009690
	JMP.w SMAS_DisplayRegionErrorMessage_CODE_009417
namespace off
	%SetDuplicateOrNullPointer(SMAS_DisplayCopyDetectionErrorMessage_Main, SMB1_DisplayCopyDetectionErrorMessage_Main)
	%SetDuplicateOrNullPointer(SMAS_DisplayCopyDetectionErrorMessage_Main, SMBLL_DisplayCopyDetectionErrorMessage_Main)
	%SetDuplicateOrNullPointer(SMAS_DisplayCopyDetectionErrorMessage_Main, SMB2U_DisplayCopyDetectionErrorMessage_Main)
	%SetDuplicateOrNullPointer(SMAS_DisplayCopyDetectionErrorMessage_Main, SMB3_DisplayCopyDetectionErrorMessage_Main)
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_InitializeSelectedRAM(Address)
namespace SMAS_InitializeSelectedRAM
%InsertMacroAtXPosition(<Address>)

Main:
	STZ.b !RAM_SMAS_Global_ScratchRAM02
Entry2:
	STA.w DMA[$00].SourceLo
	STY.w DMA[$00].SourceBank
	LDA.w #(!REGISTER_PPUMultiplicationProductLo&$0000FF<<8)+$80
	STA.w DMA[$00].Parameters
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	STA.w DMA[$00].SizeLo
	LDY.b #$01
	STY.w !REGISTER_Mode7MatrixParameterA
	DEY
	STY.w !REGISTER_Mode7MatrixParameterA
	LDY.b !RAM_SMAS_Global_ScratchRAM02
	STY.w !REGISTER_Mode7MatrixParameterB
	LDY.b #$01
	STY.w !REGISTER_DMAEnable
	RTL
namespace off
	%SetDuplicateOrNullPointer(SMAS_InitializeSelectedRAM_Main, SMB1_InitializeSelectedRAM_Main)
	%SetDuplicateOrNullPointer(SMAS_InitializeSelectedRAM_Main, SMBLL_InitializeSelectedRAM_Main)
	%SetDuplicateOrNullPointer(SMAS_InitializeSelectedRAM_Main, SMB2U_InitializeSelectedRAM_Main)
	%SetDuplicateOrNullPointer(SMAS_InitializeSelectedRAM_Main, SMB3_InitializeSelectedRAM_Main)
	%SetDuplicateOrNullPointer(SMAS_InitializeSelectedRAM_Entry2, SMB1_InitializeSelectedRAM_Entry2)
	%SetDuplicateOrNullPointer(SMAS_InitializeSelectedRAM_Entry2, SMBLL_InitializeSelectedRAM_Entry2)
	%SetDuplicateOrNullPointer(SMAS_InitializeSelectedRAM_Entry2, SMB2U_InitializeSelectedRAM_Entry2)
	%SetDuplicateOrNullPointer(SMAS_InitializeSelectedRAM_Entry2, SMB3_InitializeSelectedRAM_Entry2)
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_InitializeTitleScreenTilemap(Address)
namespace SMAS_InitializeTitleScreenTilemap
%InsertMacroAtXPosition(<Address>)

Main:
	PHB
	PHK
	PLB
	REP.b #$30
	LDX.w #SMAS_TitleScreenTilemap_Main
	LDY.w #!RAM_SMAS_TitleScreen_TilemapBuffer
	LDA.w #$07FF
	MVN !RAM_SMAS_TitleScreen_TilemapBuffer>>16,SMAS_TitleScreenTilemap_Main>>16
	SEP.b #$30
	PLB
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.b #$80
	STA.w !RAM_SMAS_TitleScreen_BirdoEyesAnimationIndex
endif
	LDA.b #$0B
	STA.w !RAM_SMAS_TitleScreen_AnimationTimer1
	LDA.b #$08
	STA.w !RAM_SMAS_TitleScreen_AnimationTimer2
	LDA.b #$10
	STA.w !RAM_SMAS_TitleScreen_AnimationTimer3
	LDA.b #$20
	STA.w !RAM_SMAS_TitleScreen_AnimationTimer4
	LDA.b #$01
	STA.b !RAM_SMAS_TitleScreen_UpdateTilemapFlag
	STZ.w !RAM_SMAS_TitleScreen_AnimationTimer5
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
	LDA.b #$60
	STA.b !RAM_SMAS_SplashScreen_PaletteAnimationTimer
	STZ.b !RAM_SMAS_SplashScreen_PaletteAnimationIndex
endif
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_HandleExtaTitleScreenMarioAndYoshiAnimation(Address)
namespace SMAS_HandleExtaTitleScreenMarioAndYoshiAnimation
%InsertMacroAtXPosition(<Address>)

Main:
	PHB
	PHK
	PLB
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
	LDA.w !RAM_SMAS_Global_YoshiAnimationIndex
	BMI.b CODE_00B72E
	DEC.w !RAM_SMAS_TitleScreen_AnimationTimer2
	BNE.b CODE_00B72E
	JSR.w SMAS_AnimateTitleScreenYoshi_Licking
	LDA.b #$08
	STA.w !RAM_SMAS_TitleScreen_AnimationTimer2
	STA.b !RAM_SMAS_TitleScreen_UpdateTilemapFlag
endif
CODE_00B72E:
	LDA.w !RAM_SMAS_TitleScreen_AnimationTimer4
	BEQ.b CODE_00B73D
	DEC.w !RAM_SMAS_TitleScreen_AnimationTimer4
	BNE.b CODE_00B73D
	JSR.w SMAS_AnimateTitleScreenMario_Eyes
	INC.b !RAM_SMAS_TitleScreen_UpdateTilemapFlag
CODE_00B73D:
	PLB
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_HandleTitleScreenCharactersAnimation(Address)
namespace SMAS_HandleTitleScreenCharactersAnimation
%InsertMacroAtXPosition(<Address>)

Main:
	PHB
	PHK
	PLB
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	DEC.w !RAM_SMAS_TitleScreen_AnimationTimer2
	BNE +
	JSR.w SMAS_AnimateTitleScreenBobOmb_Main
	LDA.b #$08
	STA.w !RAM_SMAS_TitleScreen_AnimationTimer2
	STA.b !RAM_SMAS_TitleScreen_UpdateTilemapFlag
+:
endif
	DEC.w !RAM_SMAS_TitleScreen_AnimationTimer1
	BNE.b CODE_00B75D
	JSR.w SMAS_AnimateTitleScreenLuigi_Arm
	JSR.w SMAS_AnimateTitleScreenToad_Main
	JSR.w SMAS_AnimateTitleScreenBirdo_Tail
	JSR.w SMAS_AnimateTitleScreenPidgit_Main
	JSR.w SMAS_AnimateTitleScreenMario_HeadAndArm
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.w !RAM_SMAS_TitleScreen_BirdoEyesAnimationIndex
	BMI.b +
	JSR.w SMAS_AnimateTitleScreenBirdo_Eyes
+:
endif
	LDA.b #$09
	STA.w !RAM_SMAS_TitleScreen_AnimationTimer1
	STA.b !RAM_SMAS_TitleScreen_UpdateTilemapFlag
CODE_00B75D:
	DEC.w !RAM_SMAS_TitleScreen_AnimationTimer3
	BNE.b CODE_00B76F
	JSR.w SMAS_AnimateTitleScreenLuigi_Head
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	JSR.w SMAS_AnimateTitleScreenGoomba_Main
endif
	JSR.w SMAS_AnimateTitleScreenBowser_Main
	LDA.b #$10
	STA.w !RAM_SMAS_TitleScreen_AnimationTimer3
	STA.b !RAM_SMAS_TitleScreen_UpdateTilemapFlag
CODE_00B76F:
	DEC.w !RAM_SMAS_TitleScreen_AnimationTimer4
	BNE.b CODE_00B781
	JSR.w SMAS_AnimateTitleScreenPeach_Main
	JSR.w SMAS_AnimateTitleScreenBirdo_Claw
	LDA.b #$20
	STA.w !RAM_SMAS_TitleScreen_AnimationTimer4
	STA.b !RAM_SMAS_TitleScreen_UpdateTilemapFlag
CODE_00B781:
	PLB
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_AnimateTitleScreenLuigi(Address)
namespace SMAS_AnimateTitleScreenLuigi
%InsertMacroAtXPosition(<Address>)

Head:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.b #SMAS_TitleScreenAnimationData_Main>>16
	STA.b !RAM_SMAS_Global_ScratchRAM02
endif
	REP.b #$30
	LDA.w !RAM_SMAS_TitleScreen_LuigisHeadAnimationIndex
	AND.w #$0003
	ASL
	TAX
	LDA.w DATA_00B7FD,x
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #$03A6
	STA.b !RAM_SMAS_Global_ScratchRAM04
	JSR.w SMAS_WriteToTitleScreenBuffer_Main
	SEP.b #$30
	INC.w !RAM_SMAS_TitleScreen_LuigisHeadAnimationIndex
	RTS

Arm:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.b #SMAS_TitleScreenAnimationData_Main>>16
	STA.b !RAM_SMAS_Global_ScratchRAM02
endif
	REP.b #$30
	LDA.w !RAM_SMAS_TitleScreen_LuigisArmAnimationIndex
	AND.w #$00FF
	ASL
	TAX
	LDA.w DATA_00B805,x
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #$0464
	STA.b !RAM_SMAS_Global_ScratchRAM04
	JSR.w SMAS_WriteToTitleScreenBuffer_Main
	SEP.b #$30
	INC.w !RAM_SMAS_TitleScreen_LuigisArmAnimationIndex
	LDA.w !RAM_SMAS_TitleScreen_LuigisArmAnimationIndex
	CMP.b #$0B
	BCC.b CODE_00B7FC
	STZ.w !RAM_SMAS_TitleScreen_LuigisArmAnimationIndex
CODE_00B7FC:
	RTS

DATA_00B7FD:
	dw SMAS_TitleScreenAnimationData_LuigiHead_Frame00
	dw SMAS_TitleScreenAnimationData_LuigiHead_Frame01
	dw SMAS_TitleScreenAnimationData_LuigiHead_Frame02
	dw SMAS_TitleScreenAnimationData_LuigiHead_Frame03

DATA_00B805:
	dw SMAS_TitleScreenAnimationData_LuigiArm_Frame00
	dw SMAS_TitleScreenAnimationData_LuigiArm_Frame01
	dw SMAS_TitleScreenAnimationData_LuigiArm_Frame02
	dw SMAS_TitleScreenAnimationData_LuigiArm_Frame03
	dw SMAS_TitleScreenAnimationData_LuigiArm_Frame04
	dw SMAS_TitleScreenAnimationData_LuigiArm_Frame05
	dw SMAS_TitleScreenAnimationData_LuigiArm_Frame06
	dw SMAS_TitleScreenAnimationData_LuigiArm_Frame07
	dw SMAS_TitleScreenAnimationData_LuigiArm_Frame08
	dw SMAS_TitleScreenAnimationData_LuigiArm_Frame09
	dw SMAS_TitleScreenAnimationData_LuigiArm_Frame10
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_AnimateTitleScreenPeach(Address)
namespace SMAS_AnimateTitleScreenPeach
%InsertMacroAtXPosition(<Address>)

Main:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.b #SMAS_TitleScreenAnimationData_Main>>16
	STA.b !RAM_SMAS_Global_ScratchRAM02
endif
	REP.b #$30
	LDA.w !RAM_SMAS_TitleScreen_PeachAnimationIndex
	AND.w #$0001
	ASL
	TAX
	LDA.w DATA_00B838,x
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #$0392
	STA.b !RAM_SMAS_Global_ScratchRAM04
	JSR.w SMAS_WriteToTitleScreenBuffer_Main
	SEP.b #$30
	INC.w !RAM_SMAS_TitleScreen_PeachAnimationIndex
	RTS

DATA_00B838:
	dw SMAS_TitleScreenAnimationData_Peach_Frame00
	dw SMAS_TitleScreenAnimationData_Peach_Frame01
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_AnimateTitleScreenToad(Address)
namespace SMAS_AnimateTitleScreenToad
%InsertMacroAtXPosition(<Address>)

Main:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.b #SMAS_TitleScreenAnimationData_Main>>16
	STA.b !RAM_SMAS_Global_ScratchRAM02
endif
	REP.b #$30
	LDA.w !RAM_SMAS_TitleScreen_ToadAnimationIndex
	AND.w #$0001
	ASL
	TAX
	LDA.w DATA_00B872,x
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #$04EC
	STA.b !RAM_SMAS_Global_ScratchRAM04
	JSR.w SMAS_WriteToTitleScreenBuffer_Main
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	SEP.b #$30
	INC.w !RAM_SMAS_TitleScreen_ToadAnimationIndex
else
	LDA.w !RAM_SMAS_TitleScreen_ToadAnimationIndex
	AND.w #$0003
	ASL
	TAX
	LDA.w DATA_00B876,x
	STA.l !RAM_SMAS_TitleScreen_TilemapBuffer+$04F0
	SEP.b #$30
	INC.w !RAM_SMAS_TitleScreen_ToadAnimationIndex
	LDA.w !RAM_SMAS_TitleScreen_ToadAnimationIndex
	AND.b #$01
	BEQ.b CODE_00B871
	JSR.w SMAS_AnimateTitleScreenYoshi_Talking
endif
CODE_00B871:
	RTS

DATA_00B872:
	dw SMAS_TitleScreenAnimationData_Toad_Frame00
	dw SMAS_TitleScreenAnimationData_Toad_Frame01

if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
DATA_00B876:
	dw $010F
	dw $0202
	dw $0277
	dw $0278
endif
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

; Note: The only time you'd be able to notice these animations is during the brief moment when the characters animate while the lights are on.
; However, in the original SMAS, Birdo is standing rather than sitting, so you can see them.

macro ROUTINE_SMAS_AnimateTitleScreenBirdo(Address)
namespace SMAS_AnimateTitleScreenBirdo
%InsertMacroAtXPosition(<Address>)

if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
Eyes:										; Note: This animation only plays in the Japanese version.
	LDA.b #SMAS_TitleScreenAnimationData_Main>>16
	STA.b !RAM_SMAS_Global_ScratchRAM02
	REP.b #$30
	LDA.w !RAM_SMAS_TitleScreen_BirdoEyesAnimationIndex
	AND.w #$0003
	ASL
	TAX
	LDA.w BirdoEyeFramePtrs,x
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #$0476
	STA.b !RAM_SMAS_Global_ScratchRAM04
	JSR.w SMAS_WriteToTitleScreenBuffer_Main
	SEP.b #$30
	INC.w !RAM_SMAS_TitleScreen_BirdoEyesAnimationIndex
	LDA.w !RAM_SMAS_TitleScreen_BirdoEyesAnimationIndex
	AND.b #$0F
	CMP.b #$03
	BNE.b +
	LDA.b #$80
	STA.w !RAM_SMAS_TitleScreen_BirdoEyesAnimationIndex
+:
	RTS
endif

Claw:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.b #SMAS_TitleScreenAnimationData_Main>>16
	STA.b !RAM_SMAS_Global_ScratchRAM02
endif
	REP.b #$30
	LDA.w !RAM_SMAS_TitleScreen_BirdoClawAnimationIndex
	AND.w #$0001
	ASL
	TAX
	LDA.w DATA_00B8BF,x
	STA.b !RAM_SMAS_Global_ScratchRAM00
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.w #$04B4
else
	LDA.w #$05B4
endif
	STA.b !RAM_SMAS_Global_ScratchRAM04
	JSR.w SMAS_WriteToTitleScreenBuffer_Main
	SEP.b #$30
	INC.w !RAM_SMAS_TitleScreen_BirdoClawAnimationIndex
	RTS

Tail:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.b #SMAS_TitleScreenAnimationData_Main>>16
	STA.b !RAM_SMAS_Global_ScratchRAM02
endif
	REP.b #$30
	LDA.w !RAM_SMAS_TitleScreen_BirdoTailAnimationIndex
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	AND.w #$0003
endif
	ASL
	TAX
	LDA.w DATA_00B8C3,x
	STA.b !RAM_SMAS_Global_ScratchRAM00
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.w #$04FA
else
	LDA.w #$05FC
endif
	STA.b !RAM_SMAS_Global_ScratchRAM04
	JSR.w SMAS_WriteToTitleScreenBuffer_Main
	SEP.b #$30
	INC.w !RAM_SMAS_TitleScreen_BirdoTailAnimationIndex
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
	LDA.w !RAM_SMAS_TitleScreen_BirdoTailAnimationIndex
	CMP.b #$03
	BNE.b CODE_00B8BE
	STZ.w !RAM_SMAS_TitleScreen_BirdoTailAnimationIndex
endif
CODE_00B8BE:
	RTS

if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
BirdoEyeFramePtrs:
	dw SMAS_TitleScreenAnimationData_BirdoEyes_Frame00
	dw SMAS_TitleScreenAnimationData_BirdoEyes_Frame01
	dw SMAS_TitleScreenAnimationData_BirdoEyes_Frame02
endif

DATA_00B8BF:
	dw SMAS_TitleScreenAnimationData_BirdoClaw_Frame00
	dw SMAS_TitleScreenAnimationData_BirdoClaw_Frame01

DATA_00B8C3:
	dw SMAS_TitleScreenAnimationData_BirdoTail_Frame00
	dw SMAS_TitleScreenAnimationData_BirdoTail_Frame01
	dw SMAS_TitleScreenAnimationData_BirdoTail_Frame02
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	dw SMAS_TitleScreenAnimationData_BirdoTail_Frame03
endif
namespace off
endmacro


;#############################################################################################################
;#############################################################################################################

; Note: This animation only plays in the Japanese version.

macro ROUTINE_SMAS_AnimateTitleScreenGoomba(Address)
namespace SMAS_AnimateTitleScreenGoomba
%InsertMacroAtXPosition(<Address>)

Main:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.b #SMAS_TitleScreenAnimationData_Main>>16
	STA.b !RAM_SMAS_Global_ScratchRAM02
endif
	REP.b #$30
	LDA.w !RAM_SMAS_TitleScreen_GoombaAnimationIndex
	AND.w #$0003
	ASL
	TAX
	LDA.w DATA_00B8F4,x
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #$054E
	STA.b !RAM_SMAS_Global_ScratchRAM04
	JSR.w SMAS_WriteToTitleScreenBuffer_Main
	SEP.b #$30
	INC.w !RAM_SMAS_TitleScreen_GoombaAnimationIndex
	LDA.w !RAM_SMAS_TitleScreen_GoombaAnimationIndex
	AND.b #$0F
	CMP.b #$03
	BNE.b CODE_00B8F3
	LDA.b #$80
	STA.w !RAM_SMAS_TitleScreen_GoombaAnimationIndex
CODE_00B8F3:
	RTS

DATA_00B8F4:
	dw SMAS_TitleScreenAnimationData_Goomba_Frame00
	dw SMAS_TitleScreenAnimationData_Goomba_Frame01
	dw SMAS_TitleScreenAnimationData_Goomba_Frame02
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

; Note: This animation only plays in the Japanese version.

macro ROUTINE_SMAS_AnimateTitleScreenBobOmb(Address)
namespace SMAS_AnimateTitleScreenBobOmb
%InsertMacroAtXPosition(<Address>)

Main:
	LDA.b #SMAS_TitleScreenAnimationData_Main>>16
	STA.b !RAM_SMAS_Global_ScratchRAM02
	REP.b #$30
	LDA.w !RAM_SMAS_TitleScreen_BobOmbAnimationIndex
	AND.w #$0003
	ASL
	TAX
	LDA.w BobOmbAnimationFramePtrs,x
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #$0544
	STA.b !RAM_SMAS_Global_ScratchRAM04
	JSR.w SMAS_WriteToTitleScreenBuffer_Main
	SEP.b #$30
	INC.w !RAM_SMAS_TitleScreen_BobOmbAnimationIndex
	LDA.w !RAM_SMAS_TitleScreen_BobOmbAnimationIndex
	AND.b #$04
	BEQ.b +
	LDA.b #$80
	STA.w !RAM_SMAS_TitleScreen_BobOmbAnimationIndex
+:
	RTS

BobOmbAnimationFramePtrs:
	dw SMAS_TitleScreenAnimationData_BobOmb_Frame00
	dw SMAS_TitleScreenAnimationData_BobOmb_Frame01
	dw SMAS_TitleScreenAnimationData_BobOmb_Frame02
	dw SMAS_TitleScreenAnimationData_BobOmb_Frame03
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

; Note: This animation is completely unused.

macro ROUTINE_SMAS_AnimateTitleScreenSpiny(Address)
namespace SMAS_AnimateSpinyTitleScreenAnimation
%InsertMacroAtXPosition(<Address>)

Main:
	LDA.b #SMAS_TitleScreenAnimationData_Main>>16
	STA.b !RAM_SMAS_Global_ScratchRAM02
	REP.b #$30
	LDA.w !RAM_SMAS_TitleScreen_SpinyAnimationIndex
	AND.w #$0001
	ASL
	TAX
	LDA.w SpinyAnimationFramePtrs,x
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #$0672
	STA.b !RAM_SMAS_Global_ScratchRAM04
	JSR.w SMAS_WriteToTitleScreenBuffer_Main
	SEP.b #$30
	LDA.w !RAM_SMAS_TitleScreen_SpinyAnimationIndex
	BEQ.b label_00B884
	LDA.w !RAM_SMAS_TitleScreen_SpinyAnimationIndex
	ORA.b #$80
	STA.w !RAM_SMAS_TitleScreen_SpinyAnimationIndex
label_00B884:
	INC.w !RAM_SMAS_TitleScreen_SpinyAnimationIndex
	RTS

SpinyAnimationFramePtrs:
	dw SMAS_TitleScreenAnimationData_Spiny_Frame00
	dw SMAS_TitleScreenAnimationData_Spiny_Frame01
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_AnimateTitleScreenPidgit(Address)
namespace SMAS_AnimateTitleScreenPidgit
%InsertMacroAtXPosition(<Address>)

Main:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.b #SMAS_TitleScreenAnimationData_Main>>16
	STA.b !RAM_SMAS_Global_ScratchRAM02
endif
	REP.b #$30
	LDA.w !RAM_SMAS_TitleScreen_PidgitAnimationIndex
	AND.w #$0003
	ASL
	TAX
	LDA.w DATA_00B917,x
	STA.b !RAM_SMAS_Global_ScratchRAM00
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.w #$00B2
else
	LDA.w #$00F4
endif
	STA.b !RAM_SMAS_Global_ScratchRAM04
	JSR.w SMAS_WriteToTitleScreenBuffer_Main
	SEP.b #$30
	INC.w !RAM_SMAS_TitleScreen_PidgitAnimationIndex
	RTS

DATA_00B917:
	dw SMAS_TitleScreenAnimationData_Pidget_Frame00
	dw SMAS_TitleScreenAnimationData_Pidget_Frame01
	dw SMAS_TitleScreenAnimationData_Pidget_Frame02
	dw SMAS_TitleScreenAnimationData_Pidget_Frame03
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_AnimateTitleScreenMario(Address)
namespace SMAS_AnimateTitleScreenMario
%InsertMacroAtXPosition(<Address>)

HeadAndArm:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.b #SMAS_TitleScreenAnimationData_Main>>16
	STA.b !RAM_SMAS_Global_ScratchRAM02
endif
	REP.b #$30
	LDA.w !RAM_SMAS_TitleScreen_MariosHeadAnimationIndex
	AND.w #$000F
	ASL
	TAX
	LDA.w DATA_00B99E,x
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #$0458
	STA.b !RAM_SMAS_Global_ScratchRAM04
	JSR.w SMAS_WriteToTitleScreenBuffer_Main
	LDA.w DATA_00B9B2,x
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #$041A
	STA.b !RAM_SMAS_Global_ScratchRAM04
	JSR.w SMAS_WriteToTitleScreenBuffer_Main
	SEP.b #$30
	LDA.w !RAM_SMAS_TitleScreen_MariosHeadAnimationIndex
	BNE.b CODE_00B952
	JSR.w CODE_00B967
	STZ.w !RAM_SMAS_TitleScreen_MarioArmAnimationIndex
	BRA.b CODE_00B959

CODE_00B952:
	CMP.b #$06
	BCC.b CODE_00B959
	JSR.w CODE_00B967
CODE_00B959:
	INC.w !RAM_SMAS_TitleScreen_MariosHeadAnimationIndex
	LDA.w !RAM_SMAS_TitleScreen_MariosHeadAnimationIndex
	CMP.b #$0A
	BCC.b CODE_00B966
	STZ.w !RAM_SMAS_TitleScreen_MariosHeadAnimationIndex
CODE_00B966:
	RTS

CODE_00B967:
	REP.b #$30
	LDA.w !RAM_SMAS_TitleScreen_MarioArmAnimationIndex
	AND.w #$0003
	ASL
	TAX
	LDA.w DATA_00B9C6,x
	STA.l !RAM_SMAS_TitleScreen_TilemapBuffer+$051E
	LDA.w DATA_00B9CE,x
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #$04A0
	STA.b !RAM_SMAS_Global_ScratchRAM04
	JSR.w SMAS_WriteToTitleScreenBuffer_Main
	SEP.b #$30
	INC.w !RAM_SMAS_TitleScreen_MarioArmAnimationIndex
	RTS

Eyes:
	REP.b #$30
	LDA.w #$01B0
	STA.l !RAM_SMAS_TitleScreen_TilemapBuffer+$045C
	LDA.w #$01C0
	STA.l !RAM_SMAS_TitleScreen_TilemapBuffer+$049C
	SEP.b #$30
	RTS

DATA_00B99E:
	dw SMAS_TitleScreenAnimationData_MarioFace_Frame00
	dw SMAS_TitleScreenAnimationData_MarioFace_Frame01
	dw SMAS_TitleScreenAnimationData_MarioFace_Frame02
	dw SMAS_TitleScreenAnimationData_MarioFace_Frame03
	dw SMAS_TitleScreenAnimationData_MarioFace_Frame04
	dw SMAS_TitleScreenAnimationData_MarioFace_Frame05
	dw SMAS_TitleScreenAnimationData_MarioFace_Frame06
	dw SMAS_TitleScreenAnimationData_MarioFace_Frame07
	dw SMAS_TitleScreenAnimationData_MarioFace_Frame08
	dw SMAS_TitleScreenAnimationData_MarioFace_Frame09

DATA_00B9B2:
	dw SMAS_TitleScreenAnimationData_MarioHat_Frame00
	dw SMAS_TitleScreenAnimationData_MarioHat_Frame01
	dw SMAS_TitleScreenAnimationData_MarioHat_Frame02
	dw SMAS_TitleScreenAnimationData_MarioHat_Frame03
	dw SMAS_TitleScreenAnimationData_MarioHat_Frame04
	dw SMAS_TitleScreenAnimationData_MarioHat_Frame05
	dw SMAS_TitleScreenAnimationData_MarioHat_Frame06
	dw SMAS_TitleScreenAnimationData_MarioHat_Frame07
	dw SMAS_TitleScreenAnimationData_MarioHat_Frame08
	dw SMAS_TitleScreenAnimationData_MarioHat_Frame09

DATA_00B9C6:
	dw $007F
	dw $01D4
	dw $01D4
	dw $01D4

DATA_00B9CE:
	dw SMAS_TitleScreenAnimationData_MarioHand_Frame00
	dw SMAS_TitleScreenAnimationData_MarioHand_Frame01
	dw SMAS_TitleScreenAnimationData_MarioHand_Frame02
	dw SMAS_TitleScreenAnimationData_MarioHand_Frame03
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_AnimateTitleScreenBowser(Address)
namespace SMAS_AnimateTitleScreenBowser
%InsertMacroAtXPosition(<Address>)

Main:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.b #SMAS_TitleScreenAnimationData_Main>>16
	STA.b !RAM_SMAS_Global_ScratchRAM02
endif
	REP.b #$30
	LDA.w !RAM_SMAS_TitleScreen_BowserAnimationIndex
	AND.w #$00FF
	ASL
	TAX
	LDA.w DATA_00B9FD,x
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #$040E
	STA.b !RAM_SMAS_Global_ScratchRAM04
	JSR.w SMAS_WriteToTitleScreenBuffer_Main
	SEP.b #$30
	INC.w !RAM_SMAS_TitleScreen_BowserAnimationIndex
	LDA.w !RAM_SMAS_TitleScreen_BowserAnimationIndex
	CMP.b #$08
	BCC.b CODE_00B9FC
	STZ.w !RAM_SMAS_TitleScreen_BowserAnimationIndex
CODE_00B9FC:
	RTS

DATA_00B9FD:
	dw SMAS_TitleScreenAnimationData_Bowser_Frame00
	dw SMAS_TitleScreenAnimationData_Bowser_Frame01
	dw SMAS_TitleScreenAnimationData_Bowser_Frame02
	dw SMAS_TitleScreenAnimationData_Bowser_Frame03
	dw SMAS_TitleScreenAnimationData_Bowser_Frame04
	dw SMAS_TitleScreenAnimationData_Bowser_Frame05
	dw SMAS_TitleScreenAnimationData_Bowser_Frame06
	dw SMAS_TitleScreenAnimationData_Bowser_Frame07
namespace off
endmacro


;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_AnimateTitleScreenYoshi(Address)
namespace SMAS_AnimateTitleScreenYoshi
%InsertMacroAtXPosition(<Address>)

Talking:
	REP.b #$30
	LDA.w !RAM_SMAS_Global_YoshiAnimationIndex
	AND.w #$0001
	ASL
	TAX
	LDA.w DATA_00BA5A,x
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #$03EE
	STA.b !RAM_SMAS_Global_ScratchRAM04
	JSR.w SMAS_WriteToTitleScreenBuffer_Main
	SEP.b #$30
	INC.w !RAM_SMAS_Global_YoshiAnimationIndex
	RTS

Licking:
	REP.b #$30
	LDA.w !RAM_SMAS_Global_YoshiAnimationIndex
	AND.w #$0007
	ASL
	TAX
	LDA.w DATA_00BA5E,x
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #$03EE
	STA.b !RAM_SMAS_Global_ScratchRAM04
	JSR.w SMAS_WriteToTitleScreenBuffer_Main
	LDA.w DATA_00BA68,x
	STA.l !RAM_SMAS_TitleScreen_TilemapBuffer+$04F0
	SEP.b #$30
	INC.w !RAM_SMAS_Global_YoshiAnimationIndex
	LDA.w !RAM_SMAS_Global_YoshiAnimationIndex
	CMP.b #$05
	BNE.b CODE_00BA59
	LDA.b #$80
	STA.w !RAM_SMAS_Global_YoshiAnimationIndex
CODE_00BA59:
	RTS

DATA_00BA5A:
	dw SMAS_TitleScreenAnimationData_Yoshi_Frame00
	dw SMAS_TitleScreenAnimationData_Yoshi_Frame01

DATA_00BA5E:
	dw SMAS_TitleScreenAnimationData_Yoshi_Frame02
	dw SMAS_TitleScreenAnimationData_Yoshi_Frame03
	dw SMAS_TitleScreenAnimationData_Yoshi_Frame04
	dw SMAS_TitleScreenAnimationData_Yoshi_Frame05
	dw SMAS_TitleScreenAnimationData_Yoshi_Frame06

DATA_00BA68:
	dw $0277
	dw $0277
	dw $0277
	dw $0277
	dw $010F
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_TurnOffIO(Address)
namespace SMAS_TurnOffIO
%InsertMacroAtXPosition(<Address>)

Main:
	LDA.b #!ScreenDisplayRegister_SetForceBlank|!ScreenDisplayRegister_MinBrightness00
	STA.w !REGISTER_ScreenDisplayRegister
	STA.w !RAM_SMAS_Global_ScreenDisplayRegister
	STZ.w !REGISTER_HDMAEnable
	STZ.w !RAM_SMAS_Global_HDMAEnable
	RTL
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_CheckWhichControllersArePluggedIn(Address)
namespace SMAS_CheckWhichControllersArePluggedIn
%InsertMacroAtXPosition(<Address>)

Main:
	LDA.w !REGISTER_JoypadSerialPort1
	AND.b #$01
	EOR.b #$01
	ASL
	STA.l !SRAM_SMAS_Global_Controller1PluggedInFlag
	LDA.w !REGISTER_JoypadSerialPort2
	AND.b #$01
	ASL
	STA.l !SRAM_SMAS_Global_Controller2PluggedInFlag
	RTL
namespace off
	%SetDuplicateOrNullPointer(SMAS_CheckWhichControllersArePluggedIn_Main, SMB1_CheckWhichControllersArePluggedIn_Main)
	%SetDuplicateOrNullPointer(SMAS_CheckWhichControllersArePluggedIn_Main, SMBLL_CheckWhichControllersArePluggedIn_Main)
	%SetDuplicateOrNullPointer(SMAS_CheckWhichControllersArePluggedIn_Main, SMB2U_CheckWhichControllersArePluggedIn_Main)
	%SetDuplicateOrNullPointer(SMAS_CheckWhichControllersArePluggedIn_Main, SMB3_CheckWhichControllersArePluggedIn_Main)
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_InitializeCurrentGamemode(Address)
namespace SMAS_InitializeCurrentGamemode
%InsertMacroAtXPosition(<Address>)

Main:
	JSL.l SMAS_TurnOffIO_Main
	PHD
	LDA.b #!RAM_SMAS_Global_ScreenDisplayRegister>>8
	XBA
	LDA.b #!RAM_SMAS_Global_ScreenDisplayRegister
	TCD
	TXA
	BEQ.b CODE_008519
	LDA.b #$01
	STA.w !RAM_SMAS_Global_IRQEnableFlag
	LDA.b #$37
	STA.w !RAM_SMAS_Global_VCountTimerLo
	PHB
	PHX
	REP.b #$30
	LDA.l !RAM_SMAS_GameSelect_CurrentlyOpenedFileSelectWindow
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	AND.w #$0003
else
	AND.w #$0007
endif
	ASL
	TAX
	LDA.w DATA_00859B,x
	STA.w !RAM_SMAS_GameSelect_Layer1XPosBelowCursorLo
	LDX.w #SMAS_GameSelectScreenTilemap_Main
	LDY.w #!RAM_SMAS_GameSelect_TilemapBuffer
	LDA.w #SMAS_GameSelectScreenTilemap_End-SMAS_GameSelectScreenTilemap_Main-$01
	MVN !RAM_SMAS_GameSelect_TilemapBuffer>>16,SMAS_GameSelectScreenTilemap_Main>>16
	SEP.b #$30
	PLX
	PLB
CODE_008519:
	LDA.w SMAS_GameModeSettings_InitialYPosLo,x
	STA.b !RAM_SMAS_Global_CurrentLayer1YPosLo
	LDA.w SMAS_GameModeSettings_InitialYPosHi,x
	STA.b !RAM_SMAS_Global_CurrentLayer1YPosHi
	LDA.w SMAS_GameModeSettings_OAMSizeAndDataAreaDesignation,x
	STA.b !RAM_SMAS_Global_OAMSizeAndDataAreaDesignation
	LDA.w SMAS_GameModeSettings_BGModeAndTileSizeSetting,x
	STA.b !RAM_SMAS_Global_BGModeAndTileSizeSetting
	STZ.b !RAM_SMAS_Global_MosaicSizeAndBGEnable
	LDA.w SMAS_GameModeSettings_BG1AddressAndSize,x
	STA.b !RAM_SMAS_Global_BG1AddressAndSize
	LDA.w SMAS_GameModeSettings_BG2AddressAndSize,x
	STA.b !RAM_SMAS_Global_BG2AddressAndSize
	LDA.w SMAS_GameModeSettings_BG3AddressAndSize,x
	STA.b !RAM_SMAS_Global_BG3AddressAndSize
	LDA.w SMAS_GameModeSettings_BG1And2TileDataDesignation,x
	STA.b !RAM_SMAS_Global_BG1And2TileDataDesignation
	LDA.w SMAS_GameModeSettings_BG3And4TileDataDesignation,x
	STA.w !REGISTER_BG3And4TileDataDesignation
	LDA.b #$20
	STA.b !RAM_SMAS_Global_FixedColorData1
	ASL
	STA.b !RAM_SMAS_Global_FixedColorData2
	ASL
	STA.b !RAM_SMAS_Global_FixedColorData3
	LDA.w SMAS_GameModeSettings_MainScreenLayers,x
	STA.b !RAM_SMAS_Global_MainScreenLayers
	LDA.w SMAS_GameModeSettings_SubScreenLayers,x
	STA.b !RAM_SMAS_Global_SubScreenLayers
	LDA.w SMAS_GameModeSettings_ColorMathInitialSettings,x
	STA.b !RAM_SMAS_Global_ColorMathInitialSettings
	LDA.w SMAS_GameModeSettings_ColorMathSelectAndEnable,x
	STA.b !RAM_SMAS_Global_ColorMathSelectAndEnable
	STZ.b !RAM_SMAS_Global_MainScreenWindowMask
	STZ.b !RAM_SMAS_Global_SubScreenWindowMask
	STZ.b !RAM_SMAS_Global_BG1And2WindowMaskSettings
	STZ.b !RAM_SMAS_Global_BG3And4WindowMaskSettings
	STZ.b !RAM_SMAS_Global_ObjectAndColorWindowSettings
	REP.b #$20
	LDA.w #DMA[$00].Parameters
	TCD
	JSR.w UploadGraphicsAndTilemaps
	PLD
	TXA
	AND.w #$00FF
	ASL
	TAX
	LDA.w #SMAS_GameSelectScreenPalette_End-SMAS_GameSelectScreenPalette_Main
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w SMAS_GameModeSettings_Palette,x
	LDY.b #SMAS_GameSelectScreenPalette_Main>>16
	STA.b !RAM_SMAS_Global_ScratchRAM02
	STY.b !RAM_SMAS_Global_ScratchRAM04
	LDA.w #!RAM_SMAS_Global_PaletteMirror
	LDY.b #!RAM_SMAS_Global_PaletteMirror>>16
	JSL.l SMAS_DMADataBlockToRAM_Main
	SEP.b #$20
	RTL

DATA_00859B:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	dw $0000,$0078,$00F8,$017C
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	dw $0000,$0080,$00F0,$0170
elseif !Define_Global_ROMToAssemble&(!ROM_SMASW_E) != $00
	dw $0000,$0060,$00C0,$0120
	dw $0190
else
	dw $0000,$0060,$00C0,$1120
	dw $0190
endif

DATA_0085A5:
	dw CODE_0085BE
	dw CODE_008643

UploadGraphicsAndTilemaps:
	PHX
	LDY.b #$80
	STY.w !REGISTER_VRAMAddressIncrementValue
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STA.b DMA[$00].Parameters
	LDY.b #$01
	TXA
	ASL
	TAX
	JSR.w (DATA_0085A5,x)
	PLX
	RTS

CODE_0085BE:
	LDA.w #$0000
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #SMAS_TitleScreenGFX_Section1
	STA.b DMA[$00].SourceLo
	LDX.b #SMAS_TitleScreenGFX_Section1>>16
	STX.b DMA[$00].SourceBank
	LDA.w #SMAS_TitleScreenGFX_Section1End-SMAS_TitleScreenGFX_Section1
	STA.b DMA[$00].SizeLo
	STY.w !REGISTER_DMAEnable
	LDA.w #SMAS_TitleScreenGFX_Section2
	STA.b DMA[$00].SourceLo
	LDX.b #SMAS_TitleScreenGFX_Section2>>16
	STX.b DMA[$00].SourceBank
	LDA.w #SMAS_TitleScreenGFX_Section2End-SMAS_TitleScreenGFX_Section2
	STA.b DMA[$00].SizeLo
	STY.w !REGISTER_DMAEnable
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.w #$5000
else
	LDA.w #$7000
endif
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #SMAS_TriangleTransitionalEffectGFX_Main
	STA.b DMA[$00].SourceLo
	LDX.b #SMAS_TriangleTransitionalEffectGFX_Main>>16
	STX.b DMA[$00].SourceBank
	LDA.w #SMAS_TriangleTransitionalEffectGFX_End-SMAS_TriangleTransitionalEffectGFX_Main
	STA.b DMA[$00].SizeLo
	STY.w !REGISTER_DMAEnable
	LDA.w #$6000
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #SMAS_SplashScreenGFX_Main
	STA.b DMA[$00].SourceLo
	LDX.b #SMAS_SplashScreenGFX_Main>>16
	STX.b DMA[$00].SourceBank
	LDA.w #SMAS_SplashScreenGFX_End-SMAS_SplashScreenGFX_Main
	STA.b DMA[$00].SizeLo
	STY.w !REGISTER_DMAEnable
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.w #$7000
else
	LDA.w #$7800
endif
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #SMAS_TriangleTransitionalEffectTilemap_Main
	STA.b DMA[$00].SourceLo
	LDX.b #SMAS_TriangleTransitionalEffectTilemap_Main>>16
	STX.b DMA[$00].SourceBank
	LDA.w #SMAS_TriangleTransitionalEffectTilemap_End-SMAS_TriangleTransitionalEffectTilemap_Main
	STA.b DMA[$00].SizeLo
	STY.w !REGISTER_DMAEnable
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.w #$7800
else
	LDA.w #$7C00
endif
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #SMAS_TitleScreenTilemap_Main
	STA.b DMA[$00].SourceLo
	LDX.b #SMAS_TitleScreenTilemap_Main>>16
	STX.b DMA[$00].SourceBank
	LDA.w #SMAS_TitleScreenTilemap_End-SMAS_TitleScreenTilemap_Main
	STA.b DMA[$00].SizeLo
	STY.w !REGISTER_DMAEnable
	RTS

CODE_008643:
	LDA.w #$0000
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #SMAS_BoxArtGFX_Section1
	STA.b DMA[$00].SourceLo
	LDX.b #SMAS_BoxArtGFX_Section1>>16
	STX.b DMA[$00].SourceBank
	LDA.w #SMAS_BoxArtGFX_Section1End-SMAS_BoxArtGFX_Section1
	STA.b DMA[$00].SizeLo
	STY.w !REGISTER_DMAEnable
	LDA.w #SMAS_BoxArtGFX_Section2
	STA.b DMA[$00].SourceLo
	LDX.b #SMAS_BoxArtGFX_Section2>>16
	STX.b DMA[$00].SourceBank
	LDA.w #SMAS_BoxArtGFX_Section2End-SMAS_BoxArtGFX_Section2
	STA.b DMA[$00].SizeLo
	STY.w !REGISTER_DMAEnable
	LDA.w #$6C00
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #SMAS_TriangleTransitionalEffectTilemap_Main
	STA.b DMA[$00].SourceLo
	LDX.b #SMAS_TriangleTransitionalEffectTilemap_Main>>16
	STX.b DMA[$00].SourceBank
	LDA.w #SMAS_TriangleTransitionalEffectTilemap_End-SMAS_TriangleTransitionalEffectTilemap_Main
	STA.b DMA[$00].SizeLo
	STY.w !REGISTER_DMAEnable
	LDA.w #$7000
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #SMAS_BlankGameSelectScreenGFXFile_Main
	STA.b DMA[$00].SourceLo
	LDX.b #SMAS_BlankGameSelectScreenGFXFile_Main>>16
	STX.b DMA[$00].SourceBank
	LDA.w #SMAS_BlankGameSelectScreenGFXFile_End-SMAS_BlankGameSelectScreenGFXFile_Main
	STA.b DMA[$00].SizeLo
	STY.w !REGISTER_DMAEnable
	LDA.w #$7800
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #SMAS_GameSelectScreenTilemap_Main
	STA.b DMA[$00].SourceLo
	LDX.b #SMAS_GameSelectScreenTilemap_Main>>16
	STX.b DMA[$00].SourceBank
	LDA.w #SMAS_GameSelectScreenTilemap_End-SMAS_GameSelectScreenTilemap_Main
	STA.b DMA[$00].SizeLo
	STY.w !REGISTER_DMAEnable
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_WriteToTitleScreenBuffer(Address)
namespace SMAS_WriteToTitleScreenBuffer
%InsertMacroAtXPosition(<Address>)

Main:
	PHX
	PHY
	LDY.w #$0000
CODE_00BA77:
	LDX.b !RAM_SMAS_Global_ScratchRAM04
CODE_00BA79:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.b [!RAM_SMAS_Global_ScratchRAM00],y
else
	LDA.b (!RAM_SMAS_Global_ScratchRAM00),y
endif
	BEQ.b CODE_00BA89
	BMI.b CODE_00BA95
	STA.l !RAM_SMAS_TitleScreen_TilemapBuffer,x
	INX
	INX
	INY
	INY
	BRA.b CODE_00BA79

CODE_00BA89:
	INY
	INY
	LDA.b !RAM_SMAS_Global_ScratchRAM04
	CLC
	ADC.w #$0040
	STA.b !RAM_SMAS_Global_ScratchRAM04
	BRA.b CODE_00BA77

CODE_00BA95:
	PLY
	PLX
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_SplashScreenGFXRt(Address)
namespace SMAS_SplashScreenGFXRt
%InsertMacroAtXPosition(<Address>)

Tiles:
	db $00,$02,$04,$06,$20,$22,$24,$26
	db $08,$0A,$0C,$0E,$28,$2A,$2C,$2E
	db $40,$42,$44,$46

Main:
	LDY.b #$00
	TYX
CODE_009E31:
	LDA.b #$50
	STA.b !RAM_SMAS_Global_ScratchRAM00
CODE_009E35:
	LDA.b #$60
	STA.b !RAM_SMAS_Global_ScratchRAM01
CODE_009E39:
	LDA.b !RAM_SMAS_Global_ScratchRAM01
	STA.w SMAS_Global_OAMBuffer[$00].XDisp,y
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	STA.w SMAS_Global_OAMBuffer[$00].YDisp,y
	LDA.w Tiles,x
	STA.w SMAS_Global_OAMBuffer[$00].Tile,y
	INX
	LDA.b #$2E
	STA.w SMAS_Global_OAMBuffer[$00].Prop,y
	PHY
	TYA
	LSR
	LSR
	TAY
	LDA.b #$02
	STA.w SMAS_Global_OAMTileSizeBuffer[$00].Slot,y
	PLY
	INY
	INY
	INY
	INY
	LDA.b !RAM_SMAS_Global_ScratchRAM01
	CLC
	ADC.b #$10
	STA.b !RAM_SMAS_Global_ScratchRAM01
	CMP.b #$A0
	BCC.b CODE_009E39
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	CLC
	ADC.b #$10
	STA.b !RAM_SMAS_Global_ScratchRAM00
	CMP.b #$A0
	BCC.b CODE_009E35
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_GameMode00_SplashAndTitleScreen(Address)
namespace SMAS_GameMode00_SplashAndTitleScreen
%InsertMacroAtXPosition(<Address>)

DATA_009980:
	dw SMAS_IntroProcess00_InitializeSplashScreen_Main
	dw SMAS_IntroProcess01_FadeIntoSplashScreen_Main
	dw SMAS_IntroProcess02_ShowSplashScreen_Main
	dw SMAS_IntroProcess03_FadeOutToAndInitializeTitleScreen_Main
	dw SMAS_IntroProcess04_FadeIntoTitleScreen_Main
	dw SMAS_IntroProcess05_CharacterChatterOnTitleScreen_Main
	dw SMAS_IntroProcess06_PauseTitleScreen_Main
	dw SMAS_IntroProcess07_PauseTitleScreen_Main
	dw SMAS_IntroProcess08_PauseTitleScreen_Main
	dw SMAS_IntroProcess09_PauseTitleScreen_Main
	dw SMAS_IntroProcess0A_PlayTitleScreenMusic_Main
	dw SMAS_IntroProcess0B_Unknown_Main
	dw SMAS_IntroProcess0C_TurnOnTitleScreenLights_Main
	dw SMAS_IntroProcess0D_TurnOffTitleScreenLights_Main
	dw SMAS_IntroProcess0E_TurnOnTitleScreenLights_Main
	dw SMAS_IntroProcess0F_TurnOffTitleScreenLights_Main
	dw SMAS_IntroProcess10_TurnOnTitleScreenLights_Main
	dw SMAS_IntroProcess11_TurnOffTitleScreenLights_Main
	dw SMAS_IntroProcess12_TurnOnTitleScreenLights_Main
	dw SMAS_IntroProcess13_TurnOffTitleScreenLights_Main
	dw SMAS_IntroProcess14_PauseTitleScreen_Main
	dw SMAS_IntroProcess15_PauseTitleScreen_Main
	dw SMAS_IntroProcess16_PauseTitleScreen_Main
	dw SMAS_IntroProcess17_PauseTitleScreen_Main
	dw SMAS_IntroProcess18_PauseTitleScreen_Main
	dw SMAS_IntroProcess19_ResumeChattering_Main
	dw SMAS_IntroProcess1A_CharacterChatterOnTitleScreenAgain_Main
	dw SMAS_IntroProcess1B_CharactersForgetToPause_Main
	dw SMAS_IntroProcess1C_CharactersRealizeLightsAreOn_Main
	dw SMAS_IntroProcess1D_FadeOutToDemo_Main
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
	dw SMAS_IntroProcess1E_PlayerPressedStart_Main
endif
	dw SMAS_IntroProcess1F_FadeOutToGameSelectionScreen_Main

Main:
	LDA.b !RAM_SMAS_TitleScreen_CurrentState
	ASL
	TAX
	JSR.w (DATA_009980,x)
	LDA.b !RAM_SMAS_TitleScreen_CurrentState
	CMP.b #$04
	BCC.b CODE_009A38
	JSR.w SMAS_TitleScreenLogoGFXRt_Main
	LDA.b !RAM_SMAS_TitleScreen_CurrentState
	CMP.b #$05
	BCC.b CODE_009A38
	CMP.b #$1E
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	BEQ.b CODE_009A38
else
	BCS.b CODE_009A38
endif
	LDA.b !RAM_SMAS_Global_ControllerHold1CopyP1
	ORA.b !RAM_SMAS_Global_ControllerHold1CopyP2
	ORA.b !RAM_SMAS_TitleScreen_StartButtonPressedFlag
	AND.b #!Joypad_Start>>8
	STA.b !RAM_SMAS_TitleScreen_StartButtonPressedFlag
	LDA.b !RAM_SMAS_TitleScreen_StartButtonPressedFlag
	BEQ.b CODE_009A38
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	STZ.b !RAM_SMAS_TitleScreen_PhaseTimerLo
	STZ.b !RAM_SMAS_TitleScreen_PhaseTimerHi
else
	REP.b #$20
	LDA.w #SMAS_TitleScreenPalettes_LightEnd-SMAS_TitleScreenPalettes_Light
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #SMAS_TitleScreenPalettes_Light
	LDY.b #SMAS_TitleScreenPalettes_Light>>16
	STA.b !RAM_SMAS_Global_ScratchRAM02
	STY.b !RAM_SMAS_Global_ScratchRAM04
	LDA.w #!RAM_SMAS_Global_PaletteMirror
	LDY.b #!RAM_SMAS_Global_PaletteMirror>>16
	JSL.l SMAS_DMADataBlockToRAM_Main
	LDA.w #$0000
	STA.l SMAS_Global_PaletteMirror[$00].LowByte
	SEP.b #$20
	LDA.b #!Define_SMAS_TitleScreen_BGFixedColorData1
	STA.w !RAM_SMAS_Global_FixedColorData1
	LDA.b #!Define_SMAS_TitleScreen_BGFixedColorData2
	STA.w !RAM_SMAS_Global_FixedColorData2
	LDA.b #!Define_SMAS_TitleScreen_BGFixedColorData3
	STA.w !RAM_SMAS_Global_FixedColorData3
	INC.w !RAM_SMAS_Global_UpdateEntirePaletteFlag
	JSR.w SMAS_InitializeTitleScreenTilemap_Main
	LDA.b #$50
	STA.b !RAM_SMAS_TitleScreen_PhaseTimerLo
	STZ.b !RAM_SMAS_TitleScreen_PhaseTimerHi
	LDA.b #$0C
	STA.b !RAM_SMAS_SplashScreen_PaletteAnimationTimer
	STZ.b !RAM_SMAS_SplashScreen_PaletteAnimationIndex
endif
	LDA.b #$1E
	STA.b !RAM_SMAS_TitleScreen_CurrentState
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.b #!Define_SMAS_Sound0063_SMASMenuFadeOut
	STA.w !RAM_SMAS_Global_SoundCh3
elseif !Define_Global_ROMToAssemble&(!ROM_SMASW_E) != $00
	LDA.b #!Define_SMAS_Sound0060_TurnOffMusic
	STA.b !RAM_SMAS_Global_SoundCh1
else
	LDA.b #!Define_SMAS_Sound0060_TurnOffMusic
	STA.w !RAM_SMAS_Global_SoundCh1
endif
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
	LDA.b #!Define_SMAS_Sound0063_Correct
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	STA.w !RAM_SMAS_Global_SoundCh3
else
	STA.b !RAM_SMAS_Global_SoundCh3
endif
endif
CODE_009A38:
	RTL
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_TitleScreenLogoGFXRt(Address)
namespace SMAS_TitleScreenLogoGFXRt
%InsertMacroAtXPosition(<Address>)

Main:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E) != $00
	LDA.b #$38
else
	LDA.b #$48
endif
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDY.b #$00
	TYX
CODE_009EE8:
	LDA.b !RAM_SMAS_Global_ScratchRAM00
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	STA.w SMAS_Global_OAMBuffer[$50].XDisp,y
else
	STA.w SMAS_Global_OAMBuffer[$60].XDisp,y
endif
	LDA.b #$C8
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	STA.w SMAS_Global_OAMBuffer[$50].YDisp,y
else
	STA.w SMAS_Global_OAMBuffer[$60].YDisp,y
endif
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E) != $00
	LDA.w DATA_00A0EC,x
else
	TYA
	LSR
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	ORA.b #$C0
else
	ORA.b #$E0
endif
endif
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	STA.w SMAS_Global_OAMBuffer[$50].Tile,y
else
	STA.w SMAS_Global_OAMBuffer[$60].Tile,y
endif
	LDA.b #$22
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	STA.w SMAS_Global_OAMBuffer[$50].Prop,y
else
	STA.w SMAS_Global_OAMBuffer[$60].Prop,y
endif
	LDA.b #$02
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	STA.w SMAS_Global_OAMTileSizeBuffer[$50].Slot,x
else
	STA.w SMAS_Global_OAMTileSizeBuffer[$60].Slot,x
endif
	INY
	INY
	INY
	INY
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	CLC
	ADC.b #$10
	STA.b !RAM_SMAS_Global_ScratchRAM00
	INX
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E) != $00
	CPX.b #$0A
else
	CPX.b #$07
endif
	BNE.b CODE_009EE8

if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	%INLINEROUTINE_SMAS_U_DrawTitleScreenLogo()
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	%INLINEROUTINE_SMAS_J_DrawTitleScreenLogo()
else
	%INLINEROUTINE_SMASW_DrawTitleScreenLogo()
endif
namespace off
endmacro

;--------------------------------------------------------------------

macro INLINEROUTINE_SMASW_DrawTitleScreenLogo()
	PHB
	PHK
	PLB
	REP.b #$10
	LDA.b #$74
	STA.w SMAS_Global_OAMBuffer[$00].XDisp
	LDA.b #$3D
	STA.w SMAS_Global_OAMBuffer[$00].YDisp
	LDA.b #$9E
	STA.w SMAS_Global_OAMBuffer[$00].Tile
	LDA.b #$22
	STA.w SMAS_Global_OAMBuffer[$00].Prop
	LDA.b #$02
	STA.w SMAS_Global_OAMTileSizeBuffer[$00].Slot
	LDY.w #$0004
	LDX.w #$0001
	LDA.b #$2A
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.b #$10
	STA.b !RAM_SMAS_Global_ScratchRAM01
	LDA.b #$20
	STA.b !RAM_SMAS_Global_ScratchRAM02
	LDA.b #$0A
	STA.b !RAM_SMAS_Global_ScratchRAM03
CODE_009F47:
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	STA.w SMAS_Global_OAMBuffer[$00].XDisp,y
	LDA.b !RAM_SMAS_Global_ScratchRAM01
	STA.w SMAS_Global_OAMBuffer[$00].YDisp,y
	LDA.w DATA_00A0B1-$01,x
	STA.w SMAS_Global_OAMBuffer[$00].Tile,y
	LDA.b #$20
	STA.w SMAS_Global_OAMBuffer[$00].Prop,y
	LDA.b #$02
	STA.w SMAS_Global_OAMTileSizeBuffer[$00].Slot,x
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	CLC
	ADC.b #$10
	STA.b !RAM_SMAS_Global_ScratchRAM00
	INY
	INY
	INY
	INY
	INX
	DEC.b !RAM_SMAS_Global_ScratchRAM02
	BEQ.b CODE_009F86
	DEC.b !RAM_SMAS_Global_ScratchRAM03
	BNE.b CODE_009F47
	LDA.b #$2A
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.b !RAM_SMAS_Global_ScratchRAM01
	CLC
	ADC.b #$10
	STA.b !RAM_SMAS_Global_ScratchRAM01
	LDA.b #$0B
	STA.b !RAM_SMAS_Global_ScratchRAM03
	BRA.b CODE_009F47

CODE_009F86:
	LDA.b #$2A
	STA.b !RAM_SMAS_Global_ScratchRAM00
CODE_009F8A:
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	STA.w SMAS_Global_OAMBuffer[$00].XDisp,y
	LDA.b #$40
	STA.w SMAS_Global_OAMBuffer[$00].YDisp,y
	LDA.w DATA_00A0B1-$01,x
	STA.w SMAS_Global_OAMBuffer[$00].Tile,y
	LDA.b #$20
	STA.w SMAS_Global_OAMBuffer[$00].Prop,y
	STZ.w SMAS_Global_OAMTileSizeBuffer[$00].Slot,x
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	CLC
	ADC.b #$08
	STA.b !RAM_SMAS_Global_ScratchRAM00
	INY
	INY
	INY
	INY
	INX
	CPX.w #$0038
	BNE.b CODE_009F8A
	LDA.b #$62
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.b #$4C
	STA.b !RAM_SMAS_Global_ScratchRAM01
CODE_009FBB:
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	STA.w SMAS_Global_OAMBuffer[$00].XDisp,y
	LDA.b !RAM_SMAS_Global_ScratchRAM01
	STA.w SMAS_Global_OAMBuffer[$00].YDisp,y
	LDA.w DATA_00A0B1-$01,x
	STA.w SMAS_Global_OAMBuffer[$00].Tile,y
	LDA.b #$22
	STA.w SMAS_Global_OAMBuffer[$00].Prop,y
	LDA.b #$02
	STA.w SMAS_Global_OAMTileSizeBuffer[$00].Slot,x
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	CLC
	ADC.b #$10
	STA.b !RAM_SMAS_Global_ScratchRAM00
	INY
	INY
	INY
	INY
	INX
	CPX.w #$003C
	BNE.b CODE_009FBB
	LDA.b #$32
	STA.b !RAM_SMAS_Global_ScratchRAM00
CODE_009FEA:
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	STA.w SMAS_Global_OAMBuffer[$00].XDisp,y
	LDA.b #$5C
	STA.w SMAS_Global_OAMBuffer[$00].YDisp,y
	LDA.w DATA_00A0B1-$01,x
	STA.w SMAS_Global_OAMBuffer[$00].Tile,y
	LDA.b #$22
	STA.w SMAS_Global_OAMBuffer[$00].Prop,y
	LDA.b #$02
	STA.w SMAS_Global_OAMTileSizeBuffer[$00].Slot,x
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	CLC
	ADC.b #$10
	STA.b !RAM_SMAS_Global_ScratchRAM00
	INY
	INY
	INY
	INY
	INX
	CPX.w #$0045
	BNE.b CODE_009FEA
	LDA.b #$32
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.b #$B6
	STA.b !RAM_SMAS_Global_ScratchRAM02
	LDA.b #$06
	STA.b !RAM_SMAS_Global_ScratchRAM0A
	JSR.w CODE_00A087
	LDA.b #$A2
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.b #$BC
	STA.b !RAM_SMAS_Global_ScratchRAM02
	LDA.b #$04
	STA.b !RAM_SMAS_Global_ScratchRAM0A
	JSR.w CODE_00A087
	LDA.b #$C2
	STA.w SMAS_Global_OAMBuffer[$00].XDisp,y
	STA.w SMAS_Global_OAMBuffer[$01].XDisp,y
	STA.w SMAS_Global_OAMBuffer[$02].XDisp,y
	LDA.b #$54
	STA.w SMAS_Global_OAMBuffer[$00].YDisp,y
	STA.w SMAS_Global_OAMBuffer[$03].YDisp,y
	LDA.b #$7F
	STA.w SMAS_Global_OAMBuffer[$00].Tile,y
	LDA.b #$22
	STA.w SMAS_Global_OAMBuffer[$00].Prop,y
	STA.w SMAS_Global_OAMBuffer[$01].Prop,y
	STA.w SMAS_Global_OAMBuffer[$02].Prop,y
	STA.w SMAS_Global_OAMBuffer[$03].Prop,y
	STZ.w SMAS_Global_OAMTileSizeBuffer[$00].Slot,x
	STZ.w SMAS_Global_OAMTileSizeBuffer[$01].Slot,x
	STZ.w SMAS_Global_OAMTileSizeBuffer[$02].Slot,x
	STZ.w SMAS_Global_OAMTileSizeBuffer[$03].Slot,x
	LDA.b #$5C
	STA.w SMAS_Global_OAMBuffer[$01].YDisp,y
	LDA.b #$8F
	STA.w SMAS_Global_OAMBuffer[$01].Tile,y
	LDA.b #$64
	STA.w SMAS_Global_OAMBuffer[$02].YDisp,y
	LDA.b #$7E
	STA.w SMAS_Global_OAMBuffer[$02].Tile,y
	LDA.b #$CA
	STA.w SMAS_Global_OAMBuffer[$03].XDisp,y
	LDA.b #$8E
	STA.w SMAS_Global_OAMBuffer[$03].Tile,y
	SEP.b #$10
	PLB
	RTS

CODE_00A087:
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	STA.w SMAS_Global_OAMBuffer[$00].XDisp,y
	LDA.b #$54
	STA.w SMAS_Global_OAMBuffer[$00].YDisp,y
	LDA.b !RAM_SMAS_Global_ScratchRAM02
	STA.w SMAS_Global_OAMBuffer[$00].Tile,y
	LDA.b #$22
	STA.w SMAS_Global_OAMBuffer[$00].Prop,y
	STZ.w SMAS_Global_OAMTileSizeBuffer[$00].Slot,x
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	CLC
	ADC.b #$08
	STA.b !RAM_SMAS_Global_ScratchRAM00
	INC.b !RAM_SMAS_Global_ScratchRAM02
	INY
	INY
	INY
	INY
	INX
	DEC.b !RAM_SMAS_Global_ScratchRAM0A
	BNE.b CODE_00A087
	RTS

DATA_00A0B1:
	db $00,$02,$04,$06,$08,$0A,$0C,$0E
	db $70,$72,$20,$22,$24,$26,$28,$2A
	db $2C,$2E,$90,$92,$94,$40,$42,$44
	db $46,$48,$4A,$4C,$4E,$B0,$B2,$B4
	db $60,$61,$62,$63,$64,$65,$66,$67
	db $68,$69,$6A,$6B,$6C,$6D,$6E,$6F
	db $D0,$D1,$D2,$D3,$D4,$84,$85,$76
	db $78,$7A,$7C,$C6,$C8,$CA,$96,$98
	db $9A,$9C,$CC,$CE

if !Define_Global_ROMToAssemble&(!ROM_SMASW_E) != $00
DATA_00A0EC:
	db $E0,$E2,$E4,$E0,$E2,$E6,$E8,$EA
	db $EC,$EE
endif
endmacro

;--------------------------------------------------------------------

macro INLINEROUTINE_SMAS_U_DrawTitleScreenLogo()
	PHB
	PHK
	PLB
	STZ.b !RAM_SMAS_Global_ScratchRAM00
	STZ.b !RAM_SMAS_Global_ScratchRAM01
	STZ.b !RAM_SMAS_Global_ScratchRAM02
	STZ.b !RAM_SMAS_Global_ScratchRAM03
	REP.b #$10
	LDY.w #$0000
label_00A125:
	LDX.b !RAM_SMAS_Global_ScratchRAM02
	LDA.w DATA_00A1A7,x
	CMP.b #$FF
	BEQ.b label_00A161
	SEC
	SBC.b #$08
	STA.w SMAS_Global_OAMBuffer[$00].XDisp,y
	LDA.w DATA_00A1A7+$01,x
	STA.w SMAS_Global_OAMBuffer[$00].YDisp,y
	LDA.w DATA_00A1A7+$02,x
	STA.w SMAS_Global_OAMBuffer[$00].Tile,y
	LDA.w DATA_00A1A7+$03,x
	STA.w SMAS_Global_OAMBuffer[$00].Prop,y
	LDX.b !RAM_SMAS_Global_ScratchRAM00
	LDA.b #$02
	STA.w SMAS_Global_OAMTileSizeBuffer[$00].Slot,x
	INY
	INY
	INY
	INY
	REP.b #$20
	INC.b !RAM_SMAS_Global_ScratchRAM00
	INC.b !RAM_SMAS_Global_ScratchRAM02
	INC.b !RAM_SMAS_Global_ScratchRAM02
	INC.b !RAM_SMAS_Global_ScratchRAM02
	INC.b !RAM_SMAS_Global_ScratchRAM02
	SEP.b #$20
	BRA.b label_00A125

label_00A161:
	STZ.w !RAM_SMAS_Global_ScratchRAM02
	STZ.w !RAM_SMAS_Global_ScratchRAM03
label_00A167:
	INY
	INY
	INY
	INY
	INC.b !RAM_SMAS_Global_ScratchRAM00
	LDX.b !RAM_SMAS_Global_ScratchRAM02
	LDA.w DATA_00A248,x
	CMP.b #$FF
	BEQ.b label_00A1A3
	SEC
	SBC.b #$08
	STA.w SMAS_Global_OAMBuffer[$00].XDisp,y
	LDA.w DATA_00A248+$01,x
	STA.w SMAS_Global_OAMBuffer[$00].YDisp,y
	LDA.w DATA_00A248+$02,x
	STA.w SMAS_Global_OAMBuffer[$00].Tile,y
	LDA.w DATA_00A248+$03,x
	STA.w SMAS_Global_OAMBuffer[$00].Prop,y
	LDX.b !RAM_SMAS_Global_ScratchRAM00
	LDA.b #$00
	STA.w SMAS_Global_OAMTileSizeBuffer[$00].Slot,x
	REP.b #$20
	INC.b !RAM_SMAS_Global_ScratchRAM02
	INC.b !RAM_SMAS_Global_ScratchRAM02
	INC.b !RAM_SMAS_Global_ScratchRAM02
	INC.b !RAM_SMAS_Global_ScratchRAM02
	SEP.b #$20
	BRA.b label_00A167

label_00A1A3:
	SEP.b #$10
	PLB
	RTS

DATA_00A1A7:
	db $38,$20,$00,$02,$48,$20,$02,$02
	db $58,$20,$04,$02,$68,$20,$06,$02
	db $78,$20,$08,$02,$38,$38,$44,$00
	db $48,$30,$22,$00,$58,$30,$24,$00
	db $68,$30,$26,$00,$78,$30,$28,$00
	db $38,$48,$68,$00,$48,$40,$46,$00
	db $58,$40,$48,$00,$68,$40,$4A,$02
	db $78,$40,$4C,$00,$28,$58,$80,$00
	db $38,$58,$82,$00,$48,$50,$6A,$00
	db $58,$50,$6C,$00,$68,$50,$6E,$00
	db $98,$10,$8A,$02,$A8,$10,$8C,$02
	db $B8,$10,$8E,$02,$88,$20,$0A,$02
	db $98,$20,$0C,$02,$A8,$20,$0E,$02
	db $B8,$20,$20,$02,$88,$30,$2A,$00
	db $98,$30,$2C,$00,$A8,$30,$2E,$00
	db $B8,$30,$40,$00,$C8,$30,$42,$00
	db $88,$40,$4E,$00,$98,$40,$60,$00
	db $A8,$40,$62,$00,$B8,$40,$64,$00
	db $C8,$40,$66,$00,$B8,$50,$84,$00
	db $C8,$50,$86,$00,$D8,$50,$88,$02
	db $FF

DATA_00A248:
	db $38,$18,$A0,$02,$40,$18,$A1,$02
	db $48,$18,$A2,$02,$50,$18,$A3,$02
	db $58,$18,$A4,$02,$60,$18,$A5,$02
	db $68,$18,$A6,$02,$70,$18,$A7,$02
	db $78,$18,$A8,$02,$80,$18,$A9,$02
	db $38,$30,$AF,$02,$40,$30,$B0,$02
	db $30,$38,$B1,$00,$30,$40,$B2,$00
	db $30,$48,$B3,$00,$30,$50,$B4,$00
	db $78,$50,$B6,$00,$80,$50,$B7,$00
	db $48,$60,$BE,$00,$88,$18,$AA,$02
	db $90,$18,$AB,$02,$C8,$18,$AC,$02
	db $C8,$20,$AD,$02,$C8,$28,$AE,$02
	db $D8,$48,$B5,$00,$88,$50,$B8,$00
	db $90,$50,$B9,$00,$98,$50,$BA,$00
	db $A0,$50,$BB,$00,$A8,$50,$BC,$00
	db $B0,$50,$BD,$00,$FF
endmacro

;--------------------------------------------------------------------

macro INLINEROUTINE_SMAS_J_DrawTitleScreenLogo()
	PHB
	PHK
	PLB
	STZ.b !RAM_SMAS_Global_ScratchRAM00
	STZ.b !RAM_SMAS_Global_ScratchRAM01
	LDY.b #$00
label_00A151:
	LDX.b !RAM_SMAS_Global_ScratchRAM01
	LDA.w DATA_00A1FD,x
	CMP.b #$FF
	BEQ.b label_00A189
	STA.w SMAS_Global_OAMBuffer[$00].XDisp,y
	LDA.w DATA_00A1FD+$01,x
	SEC
	SBC.b #$10
	STA.w SMAS_Global_OAMBuffer[$00].YDisp,y
	LDA.w DATA_00A1FD+$02,x
	STA.w SMAS_Global_OAMBuffer[$00].Tile,y
	LDA.w DATA_00A1FD+$03,x
	STA.w SMAS_Global_OAMBuffer[$00].Prop,y
	LDX.b !RAM_SMAS_Global_ScratchRAM00
	LDA.b #$02
	STA.w SMAS_Global_OAMTileSizeBuffer[$00].Slot,X
	INY
	INY
	INY
	INY
	INC.b !RAM_SMAS_Global_ScratchRAM00
	INC.b !RAM_SMAS_Global_ScratchRAM01
	INC.b !RAM_SMAS_Global_ScratchRAM01
	INC.b !RAM_SMAS_Global_ScratchRAM01
	INC.b !RAM_SMAS_Global_ScratchRAM01
	BRA.b label_00A151

label_00A189:
	STZ.w !RAM_SMAS_Global_ScratchRAM01
	LDY.b #$00
label_00A18E:
	INY
	INY
	INY
	INY
	INC.b !RAM_SMAS_Global_ScratchRAM00
	LDX.b !RAM_SMAS_Global_ScratchRAM01
	LDA.w DATA_00A2C2,x
	CMP.b #$FF
	BEQ.b label_00A1C3
	STA.w SMAS_Global_OAMBuffer[$31].XDisp,y
	LDA.w DATA_00A2C2+$01,x
	SEC
	SBC.b #$10
	STA.w SMAS_Global_OAMBuffer[$31].YDisp,y
	LDA.w DATA_00A2C2+$02,x
	STA.w SMAS_Global_OAMBuffer[$31].Tile,y
	LDA.b #$00
	STA.w SMAS_Global_OAMBuffer[$31].Prop,y
	LDX.b !RAM_SMAS_Global_ScratchRAM00
	LDA.b #$00
	STA.w SMAS_Global_OAMTileSizeBuffer[$31].Slot,x
	INC.b !RAM_SMAS_Global_ScratchRAM01
	INC.b !RAM_SMAS_Global_ScratchRAM01
	INC.b !RAM_SMAS_Global_ScratchRAM01
	BRA.b label_00A18E

label_00A1C3:
	LDA.b #$E8
	STA.w SMAS_Global_OAMBuffer[$31].XDisp,y
	LDA.b #$68
	SEC
	SBC.b #$10
	STA.w SMAS_Global_OAMBuffer[$31].YDisp,y
	LDA.b #$DC
	STA.w SMAS_Global_OAMBuffer[$31].Tile,y
	LDA.b #$02
	STA.w SMAS_Global_OAMBuffer[$31].Prop,y
	LDA.b #$00
	STA.w SMAS_Global_OAMTileSizeBuffer[$31].Slot,x
	LDA.b #$F0
	STA.w SMAS_Global_OAMBuffer[$32].XDisp,y
	LDA.b #$68
	SEC
	SBC.b #$10
	STA.w SMAS_Global_OAMBuffer[$32].YDisp,y
	LDA.b #$DD
	STA.w SMAS_Global_OAMBuffer[$32].Tile,y
	LDA.b #$02
	STA.w SMAS_Global_OAMBuffer[$32].Prop,y
	LDA.b #$00
	STA.w SMAS_Global_OAMTileSizeBuffer[$32].Slot,x
	PLB
	RTS

DATA_00A1FD:
	db $18,$30,$00,$02,$28,$30,$02,$02
	db $38,$30,$04,$02,$48,$30,$06,$02
	db $58,$30,$08,$02,$68,$30,$0A,$02
	db $78,$30,$0C,$02,$88,$30,$0E,$02
	db $98,$30,$20,$02,$A8,$30,$22,$02
	db $18,$40,$24,$00,$28,$40,$26,$00
	db $38,$40,$28,$00,$48,$40,$2A,$00
	db $58,$40,$2C,$00,$68,$40,$2E,$00
	db $78,$40,$40,$00,$88,$40,$42,$00
	db $98,$40,$44,$00,$A8,$40,$46,$00
	db $B8,$40,$48,$00,$C8,$40,$4A,$00
	db $D8,$40,$4C,$00,$18,$50,$4E,$00
	db $28,$50,$60,$00,$38,$50,$62,$00
	db $48,$50,$64,$00,$58,$50,$66,$00
	db $68,$50,$68,$00,$78,$50,$6A,$00
	db $88,$50,$6C,$00,$98,$50,$6E,$00
	db $A8,$50,$80,$00,$B8,$50,$82,$00
	db $C8,$50,$84,$00,$D8,$50,$86,$00
	db $18,$60,$88,$00,$28,$60,$8A,$00
	db $38,$60,$8C,$00,$48,$60,$8E,$00
	db $58,$60,$A0,$00,$68,$60,$A2,$00
	db $78,$60,$A4,$00,$88,$60,$A6,$00
	db $98,$60,$A8,$00,$A8,$60,$AA,$00
	db $B8,$60,$AC,$00,$C8,$60,$AE,$00
	db $D8,$60,$C0,$00,$FF

DATA_00A2C2:
	db $E8,$48,$C2,$E8,$50,$C3,$E8,$58
	db $C4,$18,$70,$C5,$20,$70,$C6,$28
	db $70,$C7,$30,$70,$C8,$40,$70,$C9
	db $50,$70,$CA,$58,$70,$CB,$60,$70
	db $CC,$68,$70,$CD,$78,$70,$CE,$80
	db $70,$CF,$88,$70,$D2,$90,$70,$D3
	db $98,$70,$D4,$A0,$70,$D5,$B0,$70
	db $D6,$C0,$70,$D7,$C8,$70,$D8,$D0
	db $70,$D9,$D8,$70,$DA,$E0,$70,$DB
	db $FF
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_DisplaySMB1FileSelectWindow(Address)
namespace SMAS_DisplaySMB1FileSelectWindow
%InsertMacroAtXPosition(<Address>)

Main:
if !Define_Global_SMASGames&(!SMASGames_SMB1) == $00
	LDA.b #!Define_SMAS_Sound0063_Wrong
	STA.b !RAM_SMAS_Global_SoundCh3
	RTS
else
	LDA.w !RAM_SMAS_GameSelect_FileSelectMenuActiveFlag
	BNE.b CODE_00AA07
	LDA.w !RAM_SMAS_GameSelect_FileSelectTransitionTimer
	BNE.b CODE_00AA02
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	BNE.b CODE_00A9B3
	LDA.b #$01
	STA.w !RAM_SMAS_GameSelect_FileSelectMenuActiveFlag
	STZ.w !RAM_SMAS_GameSelect_ActiveFileSelectTransitionFlag
	JMP.w CODE_00AA33

CODE_00A9B3:
	LDA.b #!Define_SMAS_Sound0063_ToggleFileWindow
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	STA.w !RAM_SMAS_Global_SoundCh3
else
	STA.b !RAM_SMAS_Global_SoundCh3
endif
	REP.b #$20
	LDA.w #$0300
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #$0310
	STA.b !RAM_SMAS_Global_ScratchRAM02
	LDX.b #$00
CODE_00A9C5:
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$38,x
	LDA.b !RAM_SMAS_Global_ScratchRAM02
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$62,x
	INC.b !RAM_SMAS_Global_ScratchRAM00
	INC.b !RAM_SMAS_Global_ScratchRAM02
	INX
	INX
	CPX.b #$10
	BNE.b CODE_00A9C5
	STZ.w !RAM_SMAS_GameSelect_FileSelectWindowBufferIndexLo
	LDA.w #$00B0
	STA.b !RAM_SMAS_Global_ScratchRAM00
	JSR.w SMAS_BufferSaveFileDisplayInformation_SMB1
	LDA.w #!SRAM_SMAS_Global_SaveFileBaseOffset+$06
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDX.b #(!SRAM_SMAS_Global_SaveFileBaseOffset+$06)>>16
	STX.b !RAM_SMAS_Global_ScratchRAM02
	JSR.w SMAS_BufferPlayerCountOnFile_Main
	LDA.w #$78E5
	STA.w !RAM_SMAS_GameSelect_CurrentFileSelectMenuVRAMAddressLo
	SEP.b #$20
	LDA.b #$01
	STA.w !RAM_SMAS_GameSelect_ActiveFileSelectTransitionFlag
	LDA.b #$15
	STA.w !RAM_SMAS_GameSelect_FileSelectTransitionTimer
CODE_00AA02:
	JSR.w SMAS_BufferFileSelectWindow_SMB1
	BRA.b CODE_00AA33

CODE_00AA07:
	LDA.w !RAM_SMAS_GameSelect_FileSelectTransitionTimer
	BNE.b CODE_00AA30
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	BNE.b CODE_00AA18
	STZ.w !RAM_SMAS_GameSelect_ActiveFileSelectTransitionFlag
	STZ.w !RAM_SMAS_GameSelect_FileSelectMenuActiveFlag
	BRA.b CODE_00AA33

CODE_00AA18:
	LDA.b #!Define_SMAS_Sound0063_ToggleFileWindow
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	STA.w !RAM_SMAS_Global_SoundCh3
else
	STA.b !RAM_SMAS_Global_SoundCh3
endif
	REP.b #$20
	LDA.w #$070A
	STA.w !RAM_SMAS_GameSelect_TilemapBufferIndexLo
	SEP.b #$20
	LDA.b #$01
	STA.w !RAM_SMAS_GameSelect_ActiveFileSelectTransitionFlag
	LDA.b #$16
	STA.w !RAM_SMAS_GameSelect_FileSelectTransitionTimer
CODE_00AA30:
	JSR.w SMAS_ClearFileSelectWindow_SMB1
CODE_00AA33:
	RTS
endif
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_DisplaySMBLLFileSelectWindow(Address)
namespace SMAS_DisplaySMBLLFileSelectWindow
%InsertMacroAtXPosition(<Address>)

Main:
if !Define_Global_SMASGames&(!SMASGames_SMBLL) == $00
	LDA.b #!Define_SMAS_Sound0063_Wrong
	STA.b !RAM_SMAS_Global_SoundCh3
	RTS
else
	LDA.w !RAM_SMAS_GameSelect_FileSelectMenuActiveFlag
	BEQ.b CODE_00AA3C
	JMP.w CODE_00AAC0

CODE_00AA3C:
	LDA.w !RAM_SMAS_GameSelect_FileSelectTransitionTimer
	BNE.b CODE_00AAA3
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	BNE.b CODE_00AA50
	LDA.b #$01
	STA.w !RAM_SMAS_GameSelect_FileSelectMenuActiveFlag
	STZ.w !RAM_SMAS_GameSelect_ActiveFileSelectTransitionFlag
	JMP.w CODE_00AB04

CODE_00AA50:
	LDA.b #!Define_SMAS_Sound0063_ToggleFileWindow
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	STA.w !RAM_SMAS_Global_SoundCh3
else
	STA.b !RAM_SMAS_Global_SoundCh3
endif
	REP.b #$20
	LDA.w #$0300
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #$0310
	STA.b !RAM_SMAS_Global_ScratchRAM02
	LDX.b #$00
CODE_00AA62:
	LDA.b !RAM_SMAS_Global_ScratchRAM00
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$36,x
	LDA.b !RAM_SMAS_Global_ScratchRAM02
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$60,x
else
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$38,x
	LDA.b !RAM_SMAS_Global_ScratchRAM02
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$62,x
endif
	INC.b !RAM_SMAS_Global_ScratchRAM00
	INC.b !RAM_SMAS_Global_ScratchRAM02
	INX
	INX
	CPX.b #$10
	BNE.b CODE_00AA62
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.w #$030B
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$46
	LDA.w #$031B
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$70
else
	LDX.b #$00
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	LDA.w #$02E0
else
	LDA.w #$01F8
endif
CODE_00AA7B:
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$8C,x
	INC
	INX
	INX
	CPX.b #$10
	BNE.b CODE_00AA7B
endif
	STZ.w !RAM_SMAS_GameSelect_FileSelectWindowBufferIndexLo
	LDA.w #$00B0
	INC
	STA.b !RAM_SMAS_Global_ScratchRAM00
	JSR.w SMAS_BufferSaveFileDisplayInformation_SMBLL
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	LDA.w #$78F4
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.w #$78F5
else
	LDA.w #$78F1
endif
	STA.w !RAM_SMAS_GameSelect_CurrentFileSelectMenuVRAMAddressLo
	SEP.b #$20
	LDA.b #$01
	STA.w !RAM_SMAS_GameSelect_ActiveFileSelectTransitionFlag
	LDA.b #$15
	STA.w !RAM_SMAS_GameSelect_FileSelectTransitionTimer
CODE_00AAA3:
	REP.b #$20
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	LDA.w #$000C
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #$0009
	STA.b !RAM_SMAS_Global_ScratchRAM02
	LDA.w #$0018
	STA.b !RAM_SMAS_Global_ScratchRAM04
	LDA.w #$0012
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.w #$000B
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #$000A
	STA.b !RAM_SMAS_Global_ScratchRAM02
	LDA.w #$0016
	STA.b !RAM_SMAS_Global_ScratchRAM04
	LDA.w #$0014
else
	LDA.w #$000F
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #$0006
	STA.b !RAM_SMAS_Global_ScratchRAM02
	LDA.w #$001E
	STA.b !RAM_SMAS_Global_ScratchRAM04
	LDA.w #$000C
endif
	STA.b !RAM_SMAS_Global_ScratchRAM06
	SEP.b #$20
	JSR.w SMAS_BufferFileSelectWindow_SMBLL
	BRA.b CODE_00AB04

CODE_00AAC0:
	LDA.w !RAM_SMAS_GameSelect_FileSelectTransitionTimer
	BNE.b CODE_00AAE9
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	BNE.b CODE_00AAD1
	STZ.w !RAM_SMAS_GameSelect_ActiveFileSelectTransitionFlag
	STZ.w !RAM_SMAS_GameSelect_FileSelectMenuActiveFlag
	BRA.b CODE_00AB04

CODE_00AAD1:
	LDA.b #!Define_SMAS_Sound0063_ToggleFileWindow
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	STA.w !RAM_SMAS_Global_SoundCh3
else
	STA.b !RAM_SMAS_Global_SoundCh3
endif
	REP.b #$20
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	LDA.w #$0728
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.w #$072A
else
	LDA.w #$0722
endif
	STA.w !RAM_SMAS_GameSelect_TilemapBufferIndexLo
	SEP.b #$20
	LDA.b #$01
	STA.w !RAM_SMAS_GameSelect_ActiveFileSelectTransitionFlag
	LDA.b #$16
	STA.w !RAM_SMAS_GameSelect_FileSelectTransitionTimer
CODE_00AAE9:
	REP.b #$20
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	LDA.w #$000C
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #$0009
	STA.b !RAM_SMAS_Global_ScratchRAM02
	LDA.w #$0018
	STA.b !RAM_SMAS_Global_ScratchRAM04
	LDA.w #$0012
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.w #$000B
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #$000A
	STA.b !RAM_SMAS_Global_ScratchRAM02
	LDA.w #$0016
	STA.b !RAM_SMAS_Global_ScratchRAM04
	LDA.w #$0014
else
	LDA.w #$000F
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #$0006
	STA.b !RAM_SMAS_Global_ScratchRAM02
	LDA.w #$001E
	STA.b !RAM_SMAS_Global_ScratchRAM04
	LDA.w #$000C
endif
	STA.b !RAM_SMAS_Global_ScratchRAM06
	SEP.b #$20
	JSR.w SMAS_ClearFileSelectWindow_SMBLL
CODE_00AB04:
	RTS
endif
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_DisplaySMB2UFileSelectWindow(Address)
namespace SMAS_DisplaySMB2UFileSelectWindow
%InsertMacroAtXPosition(<Address>)

Main:
if !Define_Global_SMASGames&(!SMASGames_SMB2U) == $00
	LDA.b #!Define_SMAS_Sound0063_Wrong
	STA.b !RAM_SMAS_Global_SoundCh3
	RTS
else
	LDA.w !RAM_SMAS_GameSelect_FileSelectMenuActiveFlag
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	BNE.b CODE_00AB8F
else
	BEQ.b CODE_00AB0D
	JMP.w CODE_00AB8F
endif

CODE_00AB0D:
	LDA.w !RAM_SMAS_GameSelect_FileSelectTransitionTimer
	BNE.b CODE_00AB72
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	BNE.b CODE_00AB21
	LDA.b #$01
	STA.w !RAM_SMAS_GameSelect_FileSelectMenuActiveFlag
	STZ.w !RAM_SMAS_GameSelect_ActiveFileSelectTransitionFlag
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	BRA.b CODE_00ABD3
else
	JMP.w CODE_00ABD3
endif

CODE_00AB21:
	LDA.b #!Define_SMAS_Sound0063_ToggleFileWindow
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	STA.w !RAM_SMAS_Global_SoundCh3
else
	STA.b !RAM_SMAS_Global_SoundCh3
endif
	REP.b #$20
	LDA.w #$0300
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #$0310
	STA.b !RAM_SMAS_Global_ScratchRAM02
	LDX.b #$00
CODE_00AB33:
	LDA.b !RAM_SMAS_Global_ScratchRAM00
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$34,x
	LDA.b !RAM_SMAS_Global_ScratchRAM02
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$5E,x
else
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$36,x
	LDA.b !RAM_SMAS_Global_ScratchRAM02
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$60,x
endif
	INC.b !RAM_SMAS_Global_ScratchRAM00
	INC.b !RAM_SMAS_Global_ScratchRAM02
	INX
	INX
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	CPX.b #$16
else
	CPX.b #$10
endif
	BNE.b CODE_00AB33
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
	LDA.w #$030B
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$46
	LDA.w #$031B
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$70
endif
	STZ.w !RAM_SMAS_GameSelect_FileSelectWindowBufferIndexLo
	LDA.w #$00B0
	INC
	INC
	STA.b !RAM_SMAS_Global_ScratchRAM00
	JSR.w SMAS_BufferSaveFileDisplayInformation_SMB2U
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	LDA.w #$7CE4
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.w #$7CE3
else
	LDA.w #$78FD
endif
	STA.w !RAM_SMAS_GameSelect_CurrentFileSelectMenuVRAMAddressLo
	SEP.b #$20
	LDA.b #$01
	STA.w !RAM_SMAS_GameSelect_ActiveFileSelectTransitionFlag
	LDA.b #$15
	STA.w !RAM_SMAS_GameSelect_FileSelectTransitionTimer
CODE_00AB72:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
	REP.b #$20
	LDA.w #$0003
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #$0012
	STA.b !RAM_SMAS_Global_ScratchRAM02
	LDA.w #$0006
	STA.b !RAM_SMAS_Global_ScratchRAM04
	LDA.w #$0024
	STA.b !RAM_SMAS_Global_ScratchRAM06
	SEP.b #$20
endif
	JSR.w SMAS_BufferFileSelectWindow_SMB2U
	BRA.b CODE_00ABD3

CODE_00AB8F:
	LDA.w !RAM_SMAS_GameSelect_FileSelectTransitionTimer
	BNE.b CODE_00ABB8
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	BNE.b CODE_00ABA0
	STZ.w !RAM_SMAS_GameSelect_ActiveFileSelectTransitionFlag
	STZ.w !RAM_SMAS_GameSelect_FileSelectMenuActiveFlag
	BRA.b CODE_00ABD3

CODE_00ABA0:
	LDA.b #!Define_SMAS_Sound0063_ToggleFileWindow
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	STA.w !RAM_SMAS_Global_SoundCh3
else
	STA.b !RAM_SMAS_Global_SoundCh3
endif
	REP.b #$20
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	LDA.w #$0F08
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.w #$0F06
else
	LDA.w #$073A
endif
	STA.w !RAM_SMAS_GameSelect_TilemapBufferIndexLo
	SEP.b #$20
	LDA.b #$01
	STA.w !RAM_SMAS_GameSelect_ActiveFileSelectTransitionFlag
	LDA.b #$16
	STA.w !RAM_SMAS_GameSelect_FileSelectTransitionTimer
CODE_00ABB8:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
	REP.b #$20
	LDA.w #$0003
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #$0012
	STA.b !RAM_SMAS_Global_ScratchRAM02
	LDA.w #$0006
	STA.b !RAM_SMAS_Global_ScratchRAM04
	LDA.w #$0024
	STA.b !RAM_SMAS_Global_ScratchRAM06
	SEP.b #$20
endif
	JSR.w SMAS_ClearFileSelectWindow_SMB2U
CODE_00ABD3:
	RTS
endif
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_DisplaySMB3FileSelectWindow(Address)
namespace SMAS_DisplaySMB3FileSelectWindow
%InsertMacroAtXPosition(<Address>)

Main:
if !Define_Global_SMASGames&(!SMASGames_SMB3) == $00
	LDA.b #!Define_SMAS_Sound0063_Wrong
	STA.b !RAM_SMAS_Global_SoundCh3
	RTS
else
	LDA.w !RAM_SMAS_GameSelect_FileSelectMenuActiveFlag
	BEQ.b CODE_00ABDC
	JMP.w CODE_00AC53

CODE_00ABDC:
	LDA.w !RAM_SMAS_GameSelect_FileSelectTransitionTimer
	BNE.b CODE_00AC4E
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	BNE.b CODE_00ABF0
	LDA.b #$01
	STA.w !RAM_SMAS_GameSelect_FileSelectMenuActiveFlag
	STZ.w !RAM_SMAS_GameSelect_ActiveFileSelectTransitionFlag
	JMP.w CODE_00AC7F

CODE_00ABF0:
	LDA.b #!Define_SMAS_Sound0063_ToggleFileWindow
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	STA.w !RAM_SMAS_Global_SoundCh3
else
	STA.b !RAM_SMAS_Global_SoundCh3
endif
	REP.b #$20
	LDA.w #$0300
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #$0310
	STA.b !RAM_SMAS_Global_ScratchRAM02
	LDX.b #$00
CODE_00AC02:
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$36,x
	LDA.b !RAM_SMAS_Global_ScratchRAM02
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$60,x
	INC.b !RAM_SMAS_Global_ScratchRAM00
	INC.b !RAM_SMAS_Global_ScratchRAM02
	INX
	INX
	CPX.b #$10
	BNE.b CODE_00AC02
	LDA.w #$030C
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$46
	LDA.w #$031C
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$70
	STZ.w !RAM_SMAS_GameSelect_FileSelectWindowBufferIndexLo
	LDA.w #$00B0
	INC
	INC
	INC
	STA.b !RAM_SMAS_Global_ScratchRAM00
	JSR.w SMAS_BufferSaveFileDisplayInformation_SMB3
	LDA.w #!SRAM_SMAS_Global_SaveFileBaseOffset+$011D
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDX.b #(!SRAM_SMAS_Global_SaveFileBaseOffset+$011D)>>16
	STX.b !RAM_SMAS_Global_ScratchRAM02
	JSR.w SMAS_BufferPlayerCountOnFile_Main
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	LDA.w #$7CF5
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.w #$7CF3
else
	LDA.w #$7CE9
endif
	STA.w !RAM_SMAS_GameSelect_CurrentFileSelectMenuVRAMAddressLo
	SEP.b #$20
	LDA.b #$01
	STA.w !RAM_SMAS_GameSelect_ActiveFileSelectTransitionFlag
	LDA.b #$15
	STA.w !RAM_SMAS_GameSelect_FileSelectTransitionTimer
CODE_00AC4E:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	REP.b #$20
	LDA.w #$000B
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #$000A
	STA.b !RAM_SMAS_Global_ScratchRAM02
	LDA.w #$0016
	STA.b !RAM_SMAS_Global_ScratchRAM04
	LDA.w #$0014
	STA.b !RAM_SMAS_Global_ScratchRAM06
	SEP.b #$20
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	REP.b #$20
	LDA.w #$000D
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #$0008
	STA.b !RAM_SMAS_Global_ScratchRAM02
	LDA.w #$001A
	STA.b !RAM_SMAS_Global_ScratchRAM04
	LDA.w #$0010
	STA.b !RAM_SMAS_Global_ScratchRAM06
	SEP.b #$20
endif
	JSR.w SMAS_BufferFileSelectWindow_SMB3
	BRA.b CODE_00AC7F

CODE_00AC53:
	LDA.w !RAM_SMAS_GameSelect_FileSelectTransitionTimer
	BNE.b CODE_00AC7C
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	BNE.b CODE_00AC64
	STZ.w !RAM_SMAS_GameSelect_ActiveFileSelectTransitionFlag
	STZ.w !RAM_SMAS_GameSelect_FileSelectMenuActiveFlag
	BRA.b CODE_00AC7F

CODE_00AC64:
	LDA.b #!Define_SMAS_Sound0063_ToggleFileWindow
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	STA.w !RAM_SMAS_Global_SoundCh3
else
	STA.b !RAM_SMAS_Global_SoundCh3
endif
	REP.b #$20
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	LDA.w #$0F2A
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.w #$0F26
else
	LDA.w #$0F12
endif
	STA.w !RAM_SMAS_GameSelect_TilemapBufferIndexLo
	SEP.b #$20
	LDA.b #$01
	STA.w !RAM_SMAS_GameSelect_ActiveFileSelectTransitionFlag
	LDA.b #$16
	STA.w !RAM_SMAS_GameSelect_FileSelectTransitionTimer
CODE_00AC7C:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	REP.b #$20
	LDA.w #$000B
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #$000A
	STA.b !RAM_SMAS_Global_ScratchRAM02
	LDA.w #$0016
	STA.b !RAM_SMAS_Global_ScratchRAM04
	LDA.w #$0014
	STA.b !RAM_SMAS_Global_ScratchRAM06
	SEP.b #$20
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	REP.b #$20
	LDA.w #$000D
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #$0008
	STA.b !RAM_SMAS_Global_ScratchRAM02
	LDA.w #$001A
	STA.b !RAM_SMAS_Global_ScratchRAM04
	LDA.w #$0010
	STA.b !RAM_SMAS_Global_ScratchRAM06
	SEP.b #$20
endif
	JSR.w SMAS_ClearFileSelectWindow_SMB3
CODE_00AC7F:
	RTS
endif
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_DisplaySMWFileSelectWindow(Address)
namespace SMAS_DisplaySMWFileSelectWindow
%InsertMacroAtXPosition(<Address>)

Main:
if !Define_Global_SMASGames&(!SMASGames_SMW) == $00
	LDA.b #!Define_SMAS_Sound0063_Wrong
	STA.b !RAM_SMAS_Global_SoundCh3
	RTS
else
	LDA.w !RAM_SMAS_GameSelect_FileSelectMenuActiveFlag
	BNE.b CloseSMWFileSelectWindow
	LDA.w !RAM_SMAS_GameSelect_FileSelectTransitionTimer
	BNE.b CODE_00ACDD
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	BNE.b CODE_00AC99
	LDA.b #$01
	STA.w !RAM_SMAS_GameSelect_FileSelectMenuActiveFlag
	STZ.w !RAM_SMAS_GameSelect_ActiveFileSelectTransitionFlag
	JMP.w CODE_00AD3E

CODE_00AC99:
	LDA.b #!Define_SMAS_Sound0063_ToggleFileWindow
	STA.b !RAM_SMAS_Global_SoundCh3
	REP.b #$20
	LDA.w #FileSelectWindowGameName_SMW
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDY.b #$00
CODE_00ACA6:
	LDA.b (!RAM_SMAS_Global_ScratchRAM00),y
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$34,y
	CLC
	ADC.w #$0010
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$5E,y
	INY
	INY
	CPY.b #$18
	BNE.b CODE_00ACA6
	STZ.w !RAM_SMAS_GameSelect_FileSelectWindowBufferIndexLo
	REP.b #$10
	LDX.w #$0000
	TXY
	LDA.w #$0004
	STA.b !RAM_SMAS_Global_ScratchRAM02
	JSR.w CODE_00AD3F
	SEP.b #$10
	LDA.w #$7CF7
	STA.w !RAM_SMAS_GameSelect_CurrentFileSelectMenuVRAMAddressLo
	SEP.b #$20
	LDA.b #$01
	STA.w !RAM_SMAS_GameSelect_ActiveFileSelectTransitionFlag
	LDA.b #$15
	STA.w !RAM_SMAS_GameSelect_FileSelectTransitionTimer
CODE_00ACDD:
	REP.b #$20
	LDA.w #$0009
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #$000C
	STA.b !RAM_SMAS_Global_ScratchRAM02
	LDA.w #$0012
	STA.b !RAM_SMAS_Global_ScratchRAM04
	LDA.w #$0018
	STA.b !RAM_SMAS_Global_ScratchRAM06
	SEP.b #$20
	JSR.w SMAS_BufferFileSelectWindow_SMW
	BRA.b CODE_00AD3E

CloseSMWFileSelectWindow:
	LDA.w !RAM_SMAS_GameSelect_FileSelectTransitionTimer
	BNE.b CODE_00AD23
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	BNE.b CODE_00AD0B
	STZ.w !RAM_SMAS_GameSelect_ActiveFileSelectTransitionFlag
	STZ.w !RAM_SMAS_GameSelect_FileSelectMenuActiveFlag
	BRA.b CODE_00AD3E

CODE_00AD0B:
	LDA.b #!Define_SMAS_Sound0063_ToggleFileWindow
	STA.b !RAM_SMAS_Global_SoundCh3
	REP.b #$20
	LDA.w #$0F2E
	STA.w !RAM_SMAS_GameSelect_TilemapBufferIndexLo
	SEP.b #$20
	LDA.b #$01
	STA.w !RAM_SMAS_GameSelect_ActiveFileSelectTransitionFlag
	LDA.b #$16
	STA.w !RAM_SMAS_GameSelect_FileSelectTransitionTimer
CODE_00AD23:
	REP.b #$20
	LDA.w #$0009
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #$000C
	STA.b !RAM_SMAS_Global_ScratchRAM02
	LDA.w #$0012
	STA.b !RAM_SMAS_Global_ScratchRAM04
	LDA.w #$0018
	STA.b !RAM_SMAS_Global_ScratchRAM06
	SEP.b #$20
	JSR.w SMAS_ClearFileSelectWindow_SMW
CODE_00AD3E:
	RTS

CODE_00AD3F:
	LDA.l !SRAM_SMW_MarioB_StartLocation-$02,x
	BEQ.b CODE_00AD90
	LDA.w #$02FF
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$BE,y
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$C0,y
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$C4,y
	LDA.w #$02B0
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$E8,y
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$EA,y
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$EE,y
	LDA.l !SRAM_SMW_MarioB_StartLocation-$03,x
	AND.w #$00FF
	STZ.b !RAM_SMAS_Global_ScratchRAM00
CODE_00AD66:
	CMP.w #$000A
	BCC.b CODE_00AD72
	SBC.w #$000A
	INC.b !RAM_SMAS_Global_ScratchRAM00
	BRA.b CODE_00AD66

CODE_00AD72:
	INC
	ORA.w #$0340
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$C2,y
	ORA.w #$0010
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$EC,y
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	BEQ.b CODE_00AD90
	INC
	ORA.w #$0340
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$C0,y
	ORA.w #$0010
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$EA,y
CODE_00AD90:
	LDA.l !SRAM_SMW_MarioB_StartLocation-$03,x
	AND.w #$00FF
	CMP.w #$0060
	BCC.b CODE_00ADA2
	LDA.w #$039B
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$E8,y
CODE_00ADA2:
	TXA
	CLC
	ADC.w #!Define_SMW_Misc_SaveFileSize
	TAX
	TYA
	CLC
	ADC.w #$0054
	TAY
	DEC.b !RAM_SMAS_Global_ScratchRAM02
	BNE.b CODE_00AD3F
	RTS

FileSelectWindowGameName_SMW:
	dw $0300,$0301,$0302,$0303
	dw $0304,$0305,$0306,$0307
	dw $01C3,$01E3,$01B7,$01D7
endif
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_IntroProcess1A_CharacterChatterOnTitleScreenAgain(Address)
namespace SMAS_IntroProcess1A_CharacterChatterOnTitleScreenAgain
%InsertMacroAtXPosition(<Address>)

Main:
	JSR.w SMAS_HandleTitleScreenCharactersAnimation_Main
	REP.b #$20
	DEC.b !RAM_SMAS_TitleScreen_PhaseTimerLo
	BNE.b CODE_009CA7
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
	LDA.w #$0060
	STA.b !RAM_SMAS_SplashScreen_PaletteAnimationTimer
	STZ.b !RAM_SMAS_SplashScreen_PaletteAnimationIndex
endif
	STZ.w !RAM_SMAS_TitleScreen_BirdoEyesAnimationIndex
	LDA.w #SMAS_TitleScreenPalettes_LightEnd-SMAS_TitleScreenPalettes_Light
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #SMAS_TitleScreenPalettes_Light
	LDY.b #SMAS_TitleScreenPalettes_Light>>16
	STA.b !RAM_SMAS_Global_ScratchRAM02
	STY.b !RAM_SMAS_Global_ScratchRAM04
	LDA.w #!RAM_SMAS_Global_PaletteMirror
	LDY.b #!RAM_SMAS_Global_PaletteMirror>>16
	JSL.l SMAS_DMADataBlockToRAM_Main
	LDA.w #$0000
	STA.l SMAS_Global_PaletteMirror[$00].LowByte
	LDA.w #$003E
	STA.b !RAM_SMAS_TitleScreen_PhaseTimerLo
	LDA.w #!Define_SMAS_TitleScreen_BGFixedColorData1
	STA.w !RAM_SMAS_Global_FixedColorData1
	LDA.w #!Define_SMAS_TitleScreen_BGFixedColorData2
	STA.w !RAM_SMAS_Global_FixedColorData2
	LDA.w #!Define_SMAS_TitleScreen_BGFixedColorData3
	STA.w !RAM_SMAS_Global_FixedColorData3
	INC.w !RAM_SMAS_Global_UpdateEntirePaletteFlag
	INC.b !RAM_SMAS_TitleScreen_CurrentState
CODE_009CA7:
	SEP.b #$20
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_BufferSaveFileDisplayInformation(Address)
namespace SMAS_BufferSaveFileDisplayInformation
%InsertMacroAtXPosition(<Address>)

SMB1:
SMB2U:
SMB3:
	LDX.b #$00
	TXY
CODE_00ADCE:
	LDA.b (!RAM_SMAS_Global_ScratchRAM00),y
	INC
	AND.w #$00FF
	BEQ.b CODE_00ADFD
	ORA.w #$0340
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$C0,x
	ORA.w #$0010
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$EA,x
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.w #$02FD
else
	LDA.w #$02DF
endif
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$EC,x
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.w #$0351
else
	LDA.w #$02B0
endif
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$E8,x
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$EE,x
	LDA.w #$02FF
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$BE,x
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$C2,x
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$C4,x
CODE_00ADFD:
	TXA
	CLC
	ADC.w #$0054
	TAX
	INY
	INY
	INY
	INY
	CPY.b #$10
	BNE.b CODE_00ADCE
	LDA.w !RAM_SMAS_GameSelect_CursorPosIndex
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	AND.w #$0003
else
	AND.w #$0007
endif
	CMP.w #$0002
	BCS.b CODE_00AE36
	LDX.b #$00
	TXY
CODE_00AE19:
	LDA.b !RAM_SMAS_GameSelect_HardModeWorldSelectedTable,x
	AND.w #$00FF
	BEQ.b CODE_00AE26
	LDA.w #$039B
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$E8,y
CODE_00AE26:
	TYA
	CLC
	ADC.w #$0054
	TAY
	INX
	INX
	INX
	INX
	CPX.b #$10
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	BNE.b CODE_00AE19
else
	BEQ.b CODE_00AE36
	BRA.b CODE_00AE19
endif

CODE_00AE36:
	RTS

SMBLL:
	LDX.b #$00
	TXY
CODE_00AE3A:
	LDA.b (!RAM_SMAS_Global_ScratchRAM00),y
	INC
	AND.w #$00FF
	BEQ.b CODE_00AE77
	ORA.w #$0340
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$BE,x
	ORA.w #$0010
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$E8,x
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.w #$02FD
else
	LDA.w #$02DF
endif
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$EA,x
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.w #$02FE
else
	LDA.w #$02EF
endif
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$EC,x
	LDA.w #$02FF
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$C0,x
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$C2,x
	LDA.w !RAM_SMAS_GameSelect_SelectedLevelTable,y
	XBA
	AND.w #$00FF
	INC
	ORA.w #$0340
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$C4,x
	ORA.w #$0010
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$EE,x
CODE_00AE77:
	TXA
	CLC
	ADC.w #$0054
	TAX
	INY
	INY
	INY
	INY
	CPY.b #$10
	BNE.b CODE_00AE3A
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_IntroProcess0B_Unknown(Address)
namespace SMAS_IntroProcess0B_Unknown
%InsertMacroAtXPosition(<Address>)

Main:
	JSR.w SMAS_HandlTitleLogoShineAnimation_Main
	REP.b #$20
	DEC.b !RAM_SMAS_TitleScreen_PhaseTimerLo
	BNE.b SMAS_IntroProcess05_CharacterChatterOnTitleScreen_CODE_009BC1
	SEP.b #$20
	JSR.w SMAS_InitializeTitleScreenTilemap_Main
	REP.b #$20
	LDA.w #SMAS_TitleScreenPalettes_DarkEnd-SMAS_TitleScreenPalettes_Dark
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #SMAS_TitleScreenPalettes_Dark
	LDY.b #SMAS_TitleScreenPalettes_Dark>>16
	STA.b !RAM_SMAS_Global_ScratchRAM02
	STY.b !RAM_SMAS_Global_ScratchRAM04
	LDA.w #!RAM_SMAS_Global_PaletteMirror
	LDY.b #!RAM_SMAS_Global_PaletteMirror>>16
	JSL.l SMAS_DMADataBlockToRAM_Main
	LDA.w #$0000
	STA.l SMAS_Global_PaletteMirror[$00].LowByte
	SEP.b #$20
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.b #$21
else
	LDA.b #!Define_SMAS_TitleScreen_BGFixedColorData1
endif
	STA.w !RAM_SMAS_Global_FixedColorData1
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.b #$49
elseif !Define_Global_ROMToAssemble&(!ROM_SMASW_E) != $00
	LDA.b #!Define_SMAS_TitleScreen_BGFixedColorData2
else
	LDA.b #$40
endif
	STA.w !RAM_SMAS_Global_FixedColorData2
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.b #$91
elseif !Define_Global_ROMToAssemble&(!ROM_SMASW_E) != $00
	LDA.b #!Define_SMAS_TitleScreen_BGFixedColorData3
else
	LDA.b #$98
endif
	STA.w !RAM_SMAS_Global_FixedColorData3
	INC.w !RAM_SMAS_Global_UpdateEntirePaletteFlag
	REP.b #$20
	LDA.w #$0002
	STA.b !RAM_SMAS_TitleScreen_PhaseTimerLo
	SEP.b #$20
	INC.b !RAM_SMAS_TitleScreen_CurrentState
	SEP.b #$20
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_IntroProcessXX_PlayTitleScreenMusicOrPause(Address)
namespace SMAS_IntroProcessXX_PlayTitleScreenMusicOrPause
%InsertMacroAtXPosition(<Address>)

Main:
	JSR.w SMAS_UploadMainSampleData_TitleScreenEntry
	LDA.b #!Define_SMB1_MenuMusic_TitleScreen
	STA.w !RAM_SMAS_Global_MusicCh1
PauseEntry:
	INC.b !RAM_SMAS_TitleScreen_CurrentState
	RTS
namespace off
	%SetDuplicateOrNullPointer(SMAS_IntroProcessXX_PlayTitleScreenMusicOrPause_Main, SMAS_IntroProcess0A_PlayTitleScreenMusic_Main)
	%SetDuplicateOrNullPointer(SMAS_IntroProcessXX_PlayTitleScreenMusicOrPause_PauseEntry, SMAS_IntroProcess06_PauseTitleScreen_Main)
	%SetDuplicateOrNullPointer(SMAS_IntroProcessXX_PlayTitleScreenMusicOrPause_PauseEntry, SMAS_IntroProcess07_PauseTitleScreen_Main)
	%SetDuplicateOrNullPointer(SMAS_IntroProcessXX_PlayTitleScreenMusicOrPause_PauseEntry, SMAS_IntroProcess08_PauseTitleScreen_Main)
	%SetDuplicateOrNullPointer(SMAS_IntroProcessXX_PlayTitleScreenMusicOrPause_PauseEntry, SMAS_IntroProcess09_PauseTitleScreen_Main)
	%SetDuplicateOrNullPointer(SMAS_IntroProcessXX_PlayTitleScreenMusicOrPause_PauseEntry, SMAS_IntroProcess14_PauseTitleScreen_Main)
	%SetDuplicateOrNullPointer(SMAS_IntroProcessXX_PlayTitleScreenMusicOrPause_PauseEntry, SMAS_IntroProcess15_PauseTitleScreen_Main)
	%SetDuplicateOrNullPointer(SMAS_IntroProcessXX_PlayTitleScreenMusicOrPause_PauseEntry, SMAS_IntroProcess16_PauseTitleScreen_Main)
	%SetDuplicateOrNullPointer(SMAS_IntroProcessXX_PlayTitleScreenMusicOrPause_PauseEntry, SMAS_IntroProcess17_PauseTitleScreen_Main)
	%SetDuplicateOrNullPointer(SMAS_IntroProcessXX_PlayTitleScreenMusicOrPause_PauseEntry, SMAS_IntroProcess18_PauseTitleScreen_Main)
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_IntroProcessXX_TurnOffTitleScreenLights(Address)
namespace SMAS_IntroProcessXX_TurnOffTitleScreenLights
%InsertMacroAtXPosition(<Address>)

Main:
	REP.b #$20
	DEC.b !RAM_SMAS_TitleScreen_PhaseTimerLo
	BNE.b CODE_009CF4
	LDA.w #SMAS_TitleScreenPalettes_DarkEnd-SMAS_TitleScreenPalettes_Dark
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #SMAS_TitleScreenPalettes_Dark
	LDY.b #SMAS_TitleScreenPalettes_Dark>>16
	STA.b !RAM_SMAS_Global_ScratchRAM02
	STY.b !RAM_SMAS_Global_ScratchRAM04
	LDA.w #!RAM_SMAS_Global_PaletteMirror
	LDY.b #!RAM_SMAS_Global_PaletteMirror>>16
	JSL.l SMAS_DMADataBlockToRAM_Main
	LDA.w #$0000
	STA.l SMAS_Global_PaletteMirror[$00].LowByte
	LDA.w #$0002
	LDX.b !RAM_SMAS_TitleScreen_CurrentState
	CPX.b #$13
	BNE.b CODE_009CDC
	LDX.b #!Define_SMAS_Sound0060_TurnOffMusic
	STX.w !RAM_SMAS_Global_SoundCh1
CODE_009CDC:
	STA.b !RAM_SMAS_TitleScreen_PhaseTimerLo
	SEP.b #$20
	INC.w !RAM_SMAS_Global_UpdateEntirePaletteFlag
	INC.b !RAM_SMAS_TitleScreen_CurrentState
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.b #$21
else
	LDA.b #!Define_SMAS_TitleScreen_BGFixedColorData1
endif
	STA.w !RAM_SMAS_Global_FixedColorData1
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.b #$49
else
	LDA.b #!Define_SMAS_TitleScreen_BGFixedColorData2
endif
	STA.w !RAM_SMAS_Global_FixedColorData2
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.b #$91
else
	LDA.b #!Define_SMAS_TitleScreen_BGFixedColorData3
endif
	STA.w !RAM_SMAS_Global_FixedColorData3
CODE_009CF4:
	SEP.b #$20
	RTS
namespace off
	%SetDuplicateOrNullPointer(SMAS_IntroProcessXX_TurnOffTitleScreenLights_Main, SMAS_IntroProcess0D_TurnOffTitleScreenLights_Main)
	%SetDuplicateOrNullPointer(SMAS_IntroProcessXX_TurnOffTitleScreenLights_Main, SMAS_IntroProcess0F_TurnOffTitleScreenLights_Main)
	%SetDuplicateOrNullPointer(SMAS_IntroProcessXX_TurnOffTitleScreenLights_Main, SMAS_IntroProcess11_TurnOffTitleScreenLights_Main)
	%SetDuplicateOrNullPointer(SMAS_IntroProcessXX_TurnOffTitleScreenLights_Main, SMAS_IntroProcess13_TurnOffTitleScreenLights_Main)
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_IntroProcessXX_TurnOnTitleScreenLights(Address)
namespace SMAS_IntroProcessXX_TurnOnTitleScreenLights
%InsertMacroAtXPosition(<Address>)

Main:
	JSR.w SMAS_HandlTitleLogoShineAnimation_Main
	REP.b #$20
	DEC.b !RAM_SMAS_TitleScreen_PhaseTimerLo
	BNE.b CODE_009C57
	LDA.w #SMAS_TitleScreenPalettes_LightEnd-SMAS_TitleScreenPalettes_Light
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #SMAS_TitleScreenPalettes_Light
	LDY.b #SMAS_TitleScreenPalettes_Light>>16
	STA.b !RAM_SMAS_Global_ScratchRAM02
	STY.b !RAM_SMAS_Global_ScratchRAM04
	LDA.w #!RAM_SMAS_Global_PaletteMirror
	LDY.b #!RAM_SMAS_Global_PaletteMirror>>16
	JSL.l SMAS_DMADataBlockToRAM_Main
	LDA.w #$0000
	STA.l SMAS_Global_PaletteMirror[$00].LowByte
	LDA.w #$0004
	STA.b !RAM_SMAS_TitleScreen_PhaseTimerLo
	LDA.w #!Define_SMAS_TitleScreen_BGFixedColorData1
	STA.w !RAM_SMAS_Global_FixedColorData1
	LDA.w #!Define_SMAS_TitleScreen_BGFixedColorData2
	STA.w !RAM_SMAS_Global_FixedColorData2
	LDA.w #!Define_SMAS_TitleScreen_BGFixedColorData3
	STA.w !RAM_SMAS_Global_FixedColorData3
	INC.w !RAM_SMAS_Global_UpdateEntirePaletteFlag
	INC.b !RAM_SMAS_TitleScreen_CurrentState
CODE_009C57:
	SEP.b #$20
	RTS
namespace off
	%SetDuplicateOrNullPointer(SMAS_IntroProcessXX_TurnOnTitleScreenLights_Main, SMAS_IntroProcess0C_TurnOnTitleScreenLights_Main)
	%SetDuplicateOrNullPointer(SMAS_IntroProcessXX_TurnOnTitleScreenLights_Main, SMAS_IntroProcess0E_TurnOnTitleScreenLights_Main)
	%SetDuplicateOrNullPointer(SMAS_IntroProcessXX_TurnOnTitleScreenLights_Main, SMAS_IntroProcess10_TurnOnTitleScreenLights_Main)
	%SetDuplicateOrNullPointer(SMAS_IntroProcessXX_TurnOnTitleScreenLights_Main, SMAS_IntroProcess12_TurnOnTitleScreenLights_Main)
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_IntroProcess19_ResumeChattering(Address)
namespace SMAS_IntroProcess19_ResumeChattering
%InsertMacroAtXPosition(<Address>)

Main:
	JSR.w SMAS_HandleTitleScreenCharactersAnimation_Main
	JSR.w SMAS_UploadRandomTitleScreenChatteringSample_Main
	REP.b #$20
	LDA.w #$00FA
	STA.b !RAM_SMAS_TitleScreen_PhaseTimerLo
	SEP.b #$20
	RTS
namespace off
endmacro


;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_IntroProcessXX_InitializeAndFadeIntoSplashScreen(Address)
namespace SMAS_IntroProcessXX_InitializeAndFadeIntoSplashScreen
%InsertMacroAtXPosition(<Address>)

Main:
	LDA.b #$00
	STA.l !SRAM_SMAS_Global_RunningDemoFlag
	STZ.b !RAM_SMAS_Global_TriangleTransitionEffectPtrBank
	REP.b #$20
	LDA.w #SMAS_TitleScreenPalettes_LightEnd-SMAS_TitleScreenPalettes_Light
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #SMAS_TitleScreenPalettes_Light
	LDY.b #SMAS_TitleScreenPalettes_Light>>16
	STA.b !RAM_SMAS_Global_ScratchRAM02
	STY.b !RAM_SMAS_Global_ScratchRAM04
	LDA.w #!RAM_SMAS_Global_PaletteMirror
	LDY.b #!RAM_SMAS_Global_PaletteMirror>>16
	JSL.l SMAS_DMADataBlockToRAM_Main
	LDA.w #$0000
	STA.l !RAM_SMAS_GameSelect_UnusedPaletteBuffer
	STA.l SMAS_Global_PaletteMirror[$00].LowByte
	SEP.b #$20
	INC.w !RAM_SMAS_Global_UpdateEntirePaletteFlag
	LDA.b #$10
	STA.w !RAM_SMAS_Global_MainScreenLayers
	LDA.b #$20
	STA.w !RAM_SMAS_Global_ColorMathSelectAndEnable
	STZ.w !RAM_SMAS_Global_ScreenDisplayRegister
	INC.b !RAM_SMAS_TitleScreen_CurrentState
IntroProcess01Entry:
	JSR.w SMAS_SplashScreenGFXRt_Main
	INC.w !RAM_SMAS_Global_ScreenDisplayRegister
	LDA.w !RAM_SMAS_Global_ScreenDisplayRegister
	CMP.b #!ScreenDisplayRegister_MaxBrightness0F
	BNE.b CODE_009A88
	INC.b !RAM_SMAS_TitleScreen_CurrentState
CODE_009A88:
	RTS
namespace off
	%SetDuplicateOrNullPointer(SMAS_IntroProcessXX_InitializeAndFadeIntoSplashScreen_Main, SMAS_IntroProcess00_InitializeSplashScreen_Main)
	%SetDuplicateOrNullPointer(SMAS_IntroProcessXX_InitializeAndFadeIntoSplashScreen_IntroProcess01Entry, SMAS_IntroProcess01_FadeIntoSplashScreen_Main)
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_IntroProcessXX_FadeOutToAndInitializeTitleScreen(Address)
namespace SMAS_IntroProcessXX_FadeOutToAndInitializeTitleScreen
%InsertMacroAtXPosition(<Address>)

if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
ADDR_009C70:								; Note: Unused copyright detection related routine?
	LDA.b #$00
	TAX
	CLC
-:
	ADC.l $038170,x
	INX
	CPX.b #$37
	BNE.b -
	CMP.b #$DA
	BNE.b +
	LDA.b #$00
	TAX
	CLC
-:
	ADC.l $0D8182,x
	INX
	CPX.b #$37
	BNE.b -
	CMP.b #$52
	BNE.b +
	LDA.b #$00
	TAX
	CLC
-:
	ADC.l $118032,x
	INX
	CPX.b #$37
	BNE.b -
	CMP.b #$43
	BNE.b +
	LDA.b #$00
	TAX
	CLC
-:
	ADC.l $13E722,x
	INX
	CPX.b #$37
	BNE.b -
	CMP.b #$43
	BNE.b +
	LDA.b #$00
	TAX
	CLC
-:
	ADC.l $129202,x
	INX
	CPX.b #$37
	BNE.b -
	CMP.b #$43
	BNE.b +
	LDA.b #$00
	TAX
	CLC

-:
	ADC.l $14F929,x
	INX
	CPX.b #$37
	BNE.b -
	CMP.b #$43
	BNE.b +
	LDA.b #$00
	TAX
	CLC
-:
	ADC.l $208033,x
	INX
	CPX.b #$37
	BNE.b -
	CMP.b #$69
	BNE.b +
	LDA.b #$00
	TAX
	CLC
-:
	ADC.l $20A626,x
	INX
	CPX.b #$37
	BNE.b -
	CMP.b #$69
	BEQ.b Main
+:
-:
	STZ.w !REGISTER_MainScreenLayers
	LDA.b #$3F
	STA.w !REGISTER_FixedColorData
	LDA.b #$5F
	STA.w !REGISTER_FixedColorData
	LDA.b #$9F
	STA.w !REGISTER_FixedColorData
	LDA.b #!ScreenDisplayRegister_MaxBrightness0F
	STA.w !REGISTER_ScreenDisplayRegister
	BRA.b -
endif

CODE_009AB3:
	RTS

Main:
	STZ.b !RAM_SMAS_SplashScreen_PaletteAnimationTimer
	LDA.b #$01
	STA.b !RAM_SMAS_SplashScreen_DisplayMarioCoinShineFlag
	JSR.w SMAS_SplashScreenGFXRt_Main
	DEC.w !RAM_SMAS_Global_ScreenDisplayRegister
	BNE.b CODE_009AB3
	LDA.b #!ScreenDisplayRegister_SetForceBlank|!ScreenDisplayRegister_MinBrightness00
	STA.w !REGISTER_ScreenDisplayRegister
	STA.w !RAM_SMAS_Global_ScreenDisplayRegister
	JSR.w SMAS_InitializeTitleScreenTilemap_Main
	REP.b #$20
	LDA.w #SMAS_TitleScreenPalettes_DarkEnd-SMAS_TitleScreenPalettes_Dark
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #SMAS_TitleScreenPalettes_Dark
	LDY.b #SMAS_TitleScreenPalettes_Dark>>16
	STA.b !RAM_SMAS_Global_ScratchRAM02
	STY.b !RAM_SMAS_Global_ScratchRAM04
	LDA.w #!RAM_SMAS_Global_PaletteMirror
	LDY.b #!RAM_SMAS_Global_PaletteMirror>>16
	JSL.l SMAS_DMADataBlockToRAM_Main
	LDA.w #$0000
	STA.l SMAS_Global_PaletteMirror[$00].LowByte
	LDY.b #$80
	STY.w !REGISTER_VRAMAddressIncrementValue
	LDA.w #$6000
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STA.w DMA[$00].Parameters
	LDA.w #SMAS_TitleScreenTextGFX_Main
	STA.w DMA[$00].SourceLo
	LDY.b #SMAS_TitleScreenTextGFX_Main>>16
	STY.w DMA[$00].SourceBank
	LDA.w #SMAS_TitleScreenTextGFX_End-SMAS_TitleScreenTextGFX_Main
	STA.w DMA[$00].SizeLo
	LDY.b #$01
	STY.w !REGISTER_DMAEnable
	SEP.b #$20
	LDA.b #$02
	STA.w !RAM_SMAS_Global_MainScreenLayers
	LDA.b #$11
	STA.w !RAM_SMAS_Global_SubScreenLayers
	LDA.b #$02
	STA.w !RAM_SMAS_Global_ColorMathInitialSettings
	LDA.b #$20
	STA.w !RAM_SMAS_Global_ColorMathSelectAndEnable
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.b #$21
else
	LDA.b #!Define_SMAS_TitleScreen_BGFixedColorData1
endif
	STA.w !RAM_SMAS_Global_FixedColorData1
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.b #$49
else
	LDA.b #!Define_SMAS_TitleScreen_BGFixedColorData2
endif
	STA.w !RAM_SMAS_Global_FixedColorData2
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.b #$91
else
	LDA.b #!Define_SMAS_TitleScreen_BGFixedColorData3
endif
	STA.w !RAM_SMAS_Global_FixedColorData3
	LDA.b #!Define_SMAS_Sound0060_RandomChatter
	STA.w !RAM_SMAS_Global_SoundCh1
	INC.w !RAM_SMAS_Global_UpdateEntirePaletteFlag
	STZ.w !RAM_SMAS_Global_ScreenDisplayRegister
	INC.b !RAM_SMAS_TitleScreen_CurrentState
IntroProcess04Entry:
	INC.w !RAM_SMAS_Global_ScreenDisplayRegister
	LDA.w !RAM_SMAS_Global_ScreenDisplayRegister
	CMP.b #!ScreenDisplayRegister_MaxBrightness0F
	BNE.b CODE_009B5B
	REP.b #$20
	LDA.w #$011A
	STA.b !RAM_SMAS_TitleScreen_PhaseTimerLo
	SEP.b #$20
	INC.b !RAM_SMAS_TitleScreen_CurrentState
CODE_009B5B:
	RTS
namespace off
	%SetDuplicateOrNullPointer(SMAS_IntroProcessXX_FadeOutToAndInitializeTitleScreen_Main, SMAS_IntroProcess03_FadeOutToAndInitializeTitleScreen_Main)
	%SetDuplicateOrNullPointer(SMAS_IntroProcessXX_FadeOutToAndInitializeTitleScreen_IntroProcess04Entry, SMAS_IntroProcess04_FadeIntoTitleScreen_Main)
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_IntroProcess1B_CharactersForgetToPause(Address)
namespace SMAS_IntroProcess1B_CharactersForgetToPause
%InsertMacroAtXPosition(<Address>)

Main:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
	JSR.w SMAS_HandlTitleLogoShineAnimation_Main
endif
	JSR.w SMAS_HandleTitleScreenCharactersAnimation_Main
	REP.b #$20
	DEC.b !RAM_SMAS_TitleScreen_PhaseTimerLo
	BNE.b CODE_009D6E
	LDA.w #SMAS_TitleScreenPalettes_LightEnd-SMAS_TitleScreenPalettes_Light
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #SMAS_TitleScreenPalettes_Light
	LDY.b #SMAS_TitleScreenPalettes_Light>>16
	STA.b !RAM_SMAS_Global_ScratchRAM02
	STY.b !RAM_SMAS_Global_ScratchRAM04
	LDA.w #!RAM_SMAS_Global_PaletteMirror
	LDY.b #!RAM_SMAS_Global_PaletteMirror>>16
	JSL.l SMAS_DMADataBlockToRAM_Main
	LDA.w #$0000
	STA.l SMAS_Global_PaletteMirror[$00].LowByte
	LDA.w #!Define_SMAS_TitleScreen_BGFixedColorData1
	STA.w !RAM_SMAS_Global_FixedColorData1
	LDA.w #!Define_SMAS_TitleScreen_BGFixedColorData2
	STA.w !RAM_SMAS_Global_FixedColorData2
	LDA.w #!Define_SMAS_TitleScreen_BGFixedColorData3
	STA.w !RAM_SMAS_Global_FixedColorData3
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E) != $00
	LDA.w #$0248
else
	LDA.w #$0390
endif
	STA.b !RAM_SMAS_TitleScreen_PhaseTimerLo
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
	LSR
	CLC
	ADC.w #$0020
	STA.w !RAM_SMAS_TitleScreen_FrameToRestartLogoPaletteAnimationLo
endif
	SEP.b #$20
	INC.w !RAM_SMAS_Global_UpdateEntirePaletteFlag
	LDA.b #$80
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
	STA.w !RAM_SMAS_TitleScreen_AnimationTimer2
endif
	STA.w !RAM_SMAS_TitleScreen_AnimationTimer4
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
	STZ.w !RAM_SMAS_Global_YoshiAnimationIndex
endif
	JSR.w SMAS_UploadMainSampleData_TitleScreenEntry
CODE_009D6E:
	SEP.b #$20
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_IntroProcess1C_CharactersRealizeLightsAreOn(Address)
namespace SMAS_IntroProcess1C_CharactersRealizeLightsAreOn
%InsertMacroAtXPosition(<Address>)

Main:
	JSR.w SMAS_HandlTitleLogoShineAnimation_Main
	JSR.w SMAS_HandleExtaTitleScreenMarioAndYoshiAnimation_Main
	REP.b #$20
	DEC.b !RAM_SMAS_TitleScreen_PhaseTimerLo
	BNE.b CODE_009D86
	SEP.b #$20
	INC.b !RAM_SMAS_TitleScreen_CurrentState
	LDA.b #!Define_SMAS_LevelMusic_MusicFade
	STA.w !RAM_SMAS_Global_MusicCh1
CODE_009D86:
	SEP.b #$20
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_IntroProcess1D_FadeOutToDemo(Address)
namespace SMAS_IntroProcess1D_FadeOutToDemo
%InsertMacroAtXPosition(<Address>)

Main:
	DEC.w !RAM_SMAS_Global_ScreenDisplayRegister
	BNE.b SMAS_IntroProcess1C_CharactersRealizeLightsAreOn_CODE_009D86
	LDA.b #!ScreenDisplayRegister_MinBrightness00
	STA.w !REGISTER_ScreenDisplayRegister
	STA.w !RAM_SMAS_Global_ScreenDisplayRegister
	JSR.w SMAS_UploadMainSampleData_Main
	STZ.b !RAM_SMAS_TitleScreen_CurrentState
	LDA.b #$09
	STA.b !RAM_SMAS_Global_GameMode
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_IntroProcess1F_FadeOutToGameSelectionScreen(Address)
namespace SMAS_IntroProcess1F_FadeOutToGameSelectionScreen
%InsertMacroAtXPosition(<Address>)

Main:
	LDA.b !RAM_SMAS_Global_FrameCounter
	LSR
	BCS.b CODE_009E17
	REP.b #$20
	LDX.b !RAM_SMAS_TitleScreen_TriangleTransitionEffectIndexLo
	LDA.l SMAS_TriangleTransitionEffectGFXPointers_Main,x
	STA.b !RAM_SMAS_Global_TriangleTransitionEffectPtrLo
	INX
	INX
	STX.b !RAM_SMAS_TitleScreen_TriangleTransitionEffectIndexLo
	CPX.b #$46
	BNE.b CODE_009E17
	INC.b !RAM_SMAS_Global_GameMode
	STZ.b !RAM_SMAS_TitleScreen_CurrentState
	STZ.b !RAM_SMAS_TitleScreen_TriangleTransitionEffectIndexLo
	LDA.w #!ScreenDisplayRegister_SetForceBlank|((!SpriteGFXLocationInVRAMLo_0000|!SpriteGFXLocationInVRAMHi_Add1000|!SpriteSize_8x8_16x16)<<8)
	STA.w !RAM_SMAS_Global_ScreenDisplayRegister
CODE_009E17:
	SEP.b #$20
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_IntroProcess1E_PlayerPressedStart(Address)
namespace SMAS_IntroProcess1E_PlayerPressedStart
%InsertMacroAtXPosition(<Address>)

Main:
	JSR.w SMAS_HandlTitleLogoShineAnimation_Main
	DEC.b !RAM_SMAS_TitleScreen_PhaseTimerLo
	BNE.b CODE_009DAD
	LDA.b #!Define_SMAS_Sound0063_SMASMenuFadeOut
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	STA.w !RAM_SMAS_Global_SoundCh3
else
	STA.b !RAM_SMAS_Global_SoundCh3
endif
	INC.b !RAM_SMAS_TitleScreen_CurrentState
CODE_009DAD:
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_HandleSplashScreenMarioCoinShine(Address)
namespace SMAS_HandleSplashScreenMarioCoinShine
%InsertMacroAtXPosition(<Address>)

if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
ShineAnimationTimer:
	db $02,$02,$02,$02
endif

DATA_009E75:
	dw $7FFF,$2BBC,$43FF,$171C
	dw $7FFF,$2BBC,$171C,$2BBC
	dw $7FFF,$0A59,$171C,$2BBC

DATA_009E8D:
	dw $53FF,$171C,$0A59,$53FF
	dw $171C,$0A59,$53FF,$7FFF
	dw $2BBC,$53FF,$171C,$0A59

Main:
	LDA.b !RAM_SMAS_SplashScreen_PaletteAnimationIndex
	ASL
	STA.b !RAM_SMAS_Global_ScratchRAM00
	ASL
	CLC
	ADC.b !RAM_SMAS_Global_ScratchRAM00
	TAY
	LDX.b #$00
CODE_009EB1:
	LDA.w DATA_009E75,y
	STA.l SMAS_Global_PaletteMirror[$F6].LowByte,x
	LDA.w DATA_009E8D,y
	STA.l SMAS_Global_PaletteMirror[$FD].LowByte,x
	INY
	INX
	CPX.b #$06
	BCC.b CODE_009EB1
	INC.w !RAM_SMAS_Global_UpdateEntirePaletteFlag
	DEC.b !RAM_SMAS_SplashScreen_PaletteAnimationTimer
	BNE.b CODE_009EE0
	INC.b !RAM_SMAS_SplashScreen_PaletteAnimationIndex
	LDX.b !RAM_SMAS_SplashScreen_PaletteAnimationIndex
	CPX.b #$04
	BCC.b CODE_009EDC
	STZ.b !RAM_SMAS_SplashScreen_PaletteAnimationIndex
	STZ.b !RAM_SMAS_SplashScreen_PaletteAnimationTimer
	STZ.b !RAM_SMAS_SplashScreen_DisplayMarioCoinShineFlag
	BRA.b CODE_009EE0

CODE_009EDC:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.w ShineAnimationTimer,x
else
	LDA.b #$02
endif
	STA.b !RAM_SMAS_SplashScreen_PaletteAnimationTimer
CODE_009EE0:
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_GameMode05_CloseEraseFileMenu(Address)
namespace SMAS_GameMode05_CloseEraseFileMenu
%InsertMacroAtXPosition(<Address>)

Main:
	REP.b #$20
	LDA.l !RAM_SMAS_Global_StripeImageUploadIndexLo
	TAX
	LDA.w !RAM_SMAS_GameSelect_CursorPosIndex
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	AND.w #$0003
else
	AND.w #$0007
endif
	ASL
	TAY
	PHY
	LDA.w !RAM_SMAS_GameSelect_EraseFileMenuAnimationIndex
	AND.w #$000F
	XBA
	LSR
	LSR
	LSR
	STA.b !RAM_SMAS_Global_ScratchRAM0E
	TAX
	LDA.w SMAS_FileSelectMenuData_DATA_00B421,y
	CLC
	ADC.b !RAM_SMAS_Global_ScratchRAM0E
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w SMAS_FileSelectMenuData_DATA_00B435,y
	STA.b !RAM_SMAS_Global_ScratchRAM02
	LDA.w #SMAS_FileSelectMenuData_DATA_00B509
	STA.b !RAM_SMAS_Global_ScratchRAM08
	STZ.b !RAM_SMAS_Global_ScratchRAM04
	LDA.l !RAM_SMAS_Global_StripeImageUploadIndexLo
	TAX
	JSR.w SMAS_UpdateEraseFileMenuDisplay_Main
	PLY
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	BEQ.b CODE_00B3CF
	CPY.b #$04
	BEQ.b CODE_00B3CF
else
	LDA.w SMAS_FileSelectMenuData_DATA_00B43F,y
	BEQ.b CODE_00B3CF
endif
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	AND.w #$7FE0
	EOR.w #$0400
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w SMAS_FileSelectMenuData_DATA_00B43F,y
	STA.b !RAM_SMAS_Global_ScratchRAM02
	JSR.w SMAS_UpdateEraseFileMenuDisplay_Main
CODE_00B3CF:
	PHY
	LDA.w SMAS_FileSelectMenuData_DATA_00B42B,y
	SEC
	SBC.b !RAM_SMAS_Global_ScratchRAM0E
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w SMAS_FileSelectMenuData_DATA_00B435,y
	STA.b !RAM_SMAS_Global_ScratchRAM02
	LDA.w #SMAS_FileSelectMenuData_DATA_00B509
	STA.b !RAM_SMAS_Global_ScratchRAM08
	STZ.b !RAM_SMAS_Global_ScratchRAM04
	JSR.w SMAS_UpdateEraseFileMenuDisplay_Main
	PLY
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	BEQ.b CODE_00B3FF
	CPY.b #$04
	BEQ.b CODE_00B3FF
else
	LDA.w SMAS_FileSelectMenuData_DATA_00B43F,y
	BEQ.b CODE_00B3FF
endif
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	AND.w #$7FE0
	EOR.w #$0400
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w SMAS_FileSelectMenuData_DATA_00B43F,y
	STA.b !RAM_SMAS_Global_ScratchRAM02
	JSR.w SMAS_UpdateEraseFileMenuDisplay_Main
CODE_00B3FF:
	LDA.w #$FFFF
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	TXA
	STA.l !RAM_SMAS_Global_StripeImageUploadIndexLo
	SEP.b #$20
	DEC.w !RAM_SMAS_GameSelect_EraseFileMenuAnimationIndex
	LDA.w !RAM_SMAS_GameSelect_EraseFileMenuAnimationIndex
	BPL.b CODE_00B420
	STZ.w !RAM_SMAS_GameSelect_EraseFileMenuAnimationIndex
	LDA.b #$02
	STA.b !RAM_SMAS_Global_GameMode
	STZ.b !RAM_SMAS_GameSelect_CanDisplayEraseFileMenuFlag
	STZ.b !RAM_SMAS_GameSelect_UnknownRAM00001A
CODE_00B420:
	RTL
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro DATATABLE_SMAS_GameInitAndMainPointers(Address)
namespace SMAS_GameInitAndMainPointers
%InsertMacroAtXPosition(<Address>)

Lo:
	db SMB1_InitAndMainLoop_Main
	db SMBLL_InitAndMainLoop_Main
	db SMB2U_InitAndMainLoop_Main
	db SMB3_InitAndMainLoop_Main
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
if !Define_Global_SMASGames&(!SMASGames_SMW) != $00
	db SMW_InitAndMainLoop_Main
else
	NOP
endif
endif

Hi:
	db SMB1_InitAndMainLoop_Main>>8
	db SMBLL_InitAndMainLoop_Main>>8
	db SMB2U_InitAndMainLoop_Main>>8
	db SMB3_InitAndMainLoop_Main>>8
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
if !Define_Global_SMASGames&(!SMASGames_SMW) != $00
	db SMW_InitAndMainLoop_Main>>8
else
	NOP
endif
endif

Bank:
	db SMB1_InitAndMainLoop_Main>>16
	db SMBLL_InitAndMainLoop_Main>>16
	db SMB2U_InitAndMainLoop_Main>>16
	db SMB3_InitAndMainLoop_Main>>16
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
if !Define_Global_SMASGames&(!SMASGames_SMW) != $00
	db SMW_InitAndMainLoop_Main>>16
else
	NOP
endif
endif
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_GameMode08_LoadSelectedGame(Address)
namespace SMAS_GameMode08_LoadSelectedGame
%InsertMacroAtXPosition(<Address>)

Main:
	LDX.b #$0F
CODE_0081A5:
	LDA.b !RAM_SMAS_GameSelect_HardModeWorldSelectedTable,x
	STA.l !SRAM_SMAS_GameSelect_CanSelectHardModeWorldTable,x
	DEX
	BPL.b CODE_0081A5
	LDA.b !RAM_SMAS_GameSelect_CurrentlySelectedSaveFile
	STA.l !SRAM_SMAS_Global_CurrentSaveFile
	LDA.b !RAM_SMAS_GameSelect_CurrentlyOpenedFileSelectWindow
	STA.l !SRAM_SMAS_Global_LastPlayedGame
	REP.b #$20
	LDA.w #!RAMBank7FEnd-!RAMBank7FStart
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #!RAMBank7FStart
	LDY.b #!RAMBank7FStart>>16
	JSL.l SMAS_InitializeSelectedRAM_Main
	SEP.b #$20
	LDA.b !RAM_SMAS_GameSelect_CurrentlyOpenedFileSelectWindow
	TAX
	INC
	ASL
	STA.l !RAM_SMAS_Global_CurrentGameX2
	LDA.l SMAS_GameInitAndMainPointers_Lo,x
	STA.b !RAM_SMAS_Global_ScratchRAM03
	LDA.l SMAS_GameInitAndMainPointers_Hi,x
	STA.b !RAM_SMAS_Global_ScratchRAM04
	LDA.l SMAS_GameInitAndMainPointers_Bank,x
	STA.b !RAM_SMAS_Global_ScratchRAM05
	REP.b #$20
	LDA.w #!RAMBankMirrorStart+$F0
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #!RAMBankMirrorStart+$10
	LDY.b #(!RAMBankMirrorStart+$10)>>16
	JSL.l SMAS_InitializeSelectedRAM_Main
	LDA.w #(!RAMBankMirrorEnd-$0200)-!RAMBankMirrorStart
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #!RAMBankMirrorStart+$0200
	LDY.b #!RAMBankMirrorStart+$0200>>16
	JSL.l SMAS_InitializeSelectedRAM_Main
	SEP.b #$20
	PLB
	PLB
	PLB
	JSL.l SMAS_LoadSaveFileData_Main
	LDA.b #$00
	STA.l !SRAM_SMAS_Global_UnusedRAM701FF8
	STA.l !SRAM_SMAS_Global_UnusedRAM701FF9
if !Define_Global_SMASGames&(!SMASGames_SMB3) != $00
	REP.b #$30
	LDA.l !SRAM_SMAS_Global_SaveFileIndexLo
	TAX
	SEP.b #$20
	LDA.l !SRAM_SMAS_Global_SaveFileBaseOffset,x
	STA.l !RAM_SMB3_Global_FurthestReachedWorld
else
	BRA.b +
	NOP #15
+:
endif
	SEP.b #$10
	JMP.w [!RAM_SMAS_Global_ScratchRAM03]
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_LoadSaveFileData(Address)
namespace SMAS_LoadSaveFileData
%InsertMacroAtXPosition(<Address>)

Main:
	PHB
	LDA.b #!SRAMBankBaseAddress>>16
	PHA
	PLB
	REP.b #$10
	LDA.b #$20
	STA.b !RAM_SMAS_Global_ScratchRAM0E
	LDA.b #$01
	STA.b !RAM_SMAS_Global_ScratchRAM0F
	LDX.w #$0000
	LDY.w !SRAM_SMAS_Global_SaveFileIndexLo
CODE_00A61C:
	LDA.w !SRAM_SMAS_Global_SaveFileBaseOffset,y
	STA.l !RAM_SMAS_Global_InitialWorld,x
	INY
	INX
	CPX.b !RAM_SMAS_Global_ScratchRAM0E
	BNE.b CODE_00A61C
	LDA.w !SRAM_SMAS_Global_InitialSelectedWorld
	STA.l !RAM_SMAS_Global_InitialWorld
	LDA.w !SRAM_SMAS_Global_InitialSelectedLevel
	STA.l !RAM_SMAS_Global_InitialLevel
if !Define_Global_SMASGames&(!SMASGames_SMB1) != $00
	LDA.l !SRAM_SMAS_Global_LastPlayedGame
	STA.b !RAM_SMAS_Global_ScratchRAM00
	BNE.b CODE_00A654
	LDA.l !SRAM_SMAS_Global_CurrentSaveFile
	ASL
	ASL
	ORA.b !RAM_SMAS_Global_ScratchRAM00
	XBA
	LDA.b #$00
	XBA
	TAX
	LDA.l !SRAM_SMAS_GameSelect_CanSelectHardModeWorldTable,x
	STA.l !RAM_SMB1_Global_SaveBuffer_HardModeActiveFlag
CODE_00A654:
endif
	LDA.b #$00
	XBA
	LDA.l !SRAM_SMAS_Global_CurrentSaveFile
	AND.b #$03
	ASL
	ASL
	TAX
	SEP.b #$10
	PLB
	RTL
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_IntroProcess05_CharacterChatterOnTitleScreen(Address)
namespace SMAS_IntroProcess05_CharacterChatterOnTitleScreen
%InsertMacroAtXPosition(<Address>)

Main:
	REP.b #$20
	LDA.b !RAM_SMAS_TitleScreen_PhaseTimerLo
	CMP.w #$0020
	BCC.b CODE_009B6A
	SEP.b #$20
	JSR.w SMAS_HandleTitleScreenCharactersAnimation_Main
CODE_009B6A:
	REP.b #$20
	DEC.b !RAM_SMAS_TitleScreen_PhaseTimerLo
	BNE.b CODE_009BC1
	SEP.b #$20
	JSR.w SMAS_InitializeTitleScreenTilemap_Main
	REP.b #$20
	LDA.w #SMAS_TitleScreenPalettes_LightEnd-SMAS_TitleScreenPalettes_Light
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #SMAS_TitleScreenPalettes_Light
	LDY.b #SMAS_TitleScreenPalettes_Light>>16
	STA.b !RAM_SMAS_Global_ScratchRAM02
	STY.b !RAM_SMAS_Global_ScratchRAM04
	LDA.w #!RAM_SMAS_Global_PaletteMirror
	LDY.b #!RAM_SMAS_Global_PaletteMirror>>16
	JSL.l SMAS_DMADataBlockToRAM_Main
	LDA.w #$0000
	STA.l SMAS_Global_PaletteMirror[$00].LowByte
	SEP.b #$20
	LDA.b #!Define_SMAS_TitleScreen_BGFixedColorData1
	STA.w !RAM_SMAS_Global_FixedColorData1
	LDA.b #!Define_SMAS_TitleScreen_BGFixedColorData2
	STA.w !RAM_SMAS_Global_FixedColorData2
	LDA.b #!Define_SMAS_TitleScreen_BGFixedColorData3
	STA.w !RAM_SMAS_Global_FixedColorData3
	INC.w !RAM_SMAS_Global_UpdateEntirePaletteFlag
	REP.b #$20
	LDA.w #$0445
	STA.b !RAM_SMAS_TitleScreen_PhaseTimerLo
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
	LSR
	CLC
	ADC.w #$0010
	STA.w !RAM_SMAS_TitleScreen_FrameToRestartLogoPaletteAnimationLo
endif
	SEP.b #$20
	INC.b !RAM_SMAS_TitleScreen_CurrentState
	LDA.b #!Define_SMAS_Sound0060_TurnOffMusic
	STA.w !RAM_SMAS_Global_SoundCh1
CODE_009BC1:
	SEP.b #$20
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_IntroProcess02_ShowSplashScreen(Address)
namespace SMAS_IntroProcess02_ShowSplashScreen
%InsertMacroAtXPosition(<Address>)

Main:
	LDA.b !RAM_SMAS_SplashScreen_DisplayTimer
	CMP.b #$61
	BNE.b CODE_009A9B
	LDA.b #!Define_SMAS_Sound0063_Coin
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	STA.w !RAM_SMAS_Global_SoundCh3
else
	STA.b !RAM_SMAS_Global_SoundCh3
endif
	STA.b !RAM_SMAS_SplashScreen_DisplayMarioCoinShineFlag
	LDA.b #$02
	STA.b !RAM_SMAS_SplashScreen_PaletteAnimationTimer
	STZ.b !RAM_SMAS_SplashScreen_PaletteAnimationIndex
CODE_009A9B:
	JSR.w SMAS_SplashScreenGFXRt_Main
	LDA.b !RAM_SMAS_SplashScreen_DisplayMarioCoinShineFlag
	BEQ.b CODE_009AA5
	JSR.w SMAS_HandleSplashScreenMarioCoinShine_Main
CODE_009AA5:
	DEC.b !RAM_SMAS_SplashScreen_DisplayTimer
	BNE.b SMAS_IntroProcessXX_InitializeAndFadeIntoSplashScreen_CODE_009A88
	INC.b !RAM_SMAS_TitleScreen_CurrentState
	LDA.b #$F0
	STA.b !RAM_SMAS_SplashScreen_UnknownRAM00001D
	STZ.b !RAM_SMAS_SplashScreen_UnknownRAM000021
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	JMP.w SMAS_IntroProcess03_FadeOutToAndInitializeTitleScreen_Main
else
	BRA.b SMAS_IntroProcess03_FadeOutToAndInitializeTitleScreen_Main
endif
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_InitializeMostRAM(Address)
namespace SMAS_InitializeMostRAM
%InsertMacroAtXPosition(<Address>)

UploadSPCEngine:
	JSR.w SMAS_UploadSMASSPCEngine_Main
Main:
	REP.b #$20
	LDA.w #!RAM_SMAS_Global_StartOfStack-$AF
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #!RAMBankMirrorStart>>16
	TAY
	JSL.l SMAS_InitializeSelectedRAM_Main
	LDA.w #!RAMBankMirrorEnd-(!RAM_SMAS_Global_StartOfStack+$01)
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #!RAM_SMAS_Global_StartOfStack+$01
	TAY
	JSL.l SMAS_InitializeSelectedRAM_Main
	LDA.w #!RAMBank7EEnd-!RAMBank7EStart
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #!RAMBank7EStart
	LDY.b #!RAMBank7EStart>>16
	JSL.l SMAS_InitializeSelectedRAM_Main
	LDA.w #!RAMBank7FEnd-!RAMBank7FStart
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #!RAMBank7FStart
	LDY.b #!RAMBank7FStart>>16
	JSL.l SMAS_InitializeSelectedRAM_Main
	LDA.w #$0000
	STA.l !RAM_SMAS_Global_StripeImageUploadIndexLo
	DEC
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte
	SEP.b #$20
	LDX.b #$00
	JSL.l SMAS_InitializeCurrentGamemode_Main
	PHD
	LDA.b #!RAM_SMAS_Global_ScreenDisplayRegister>>8
	XBA
	LDA.b #!RAM_SMAS_Global_ScreenDisplayRegister
	TCD
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E) != $00
	LDA.b #!InitialScreenSettings_EnableOverscanFlag
	STA.w !REGISTER_InitialScreenSettings
else
	STZ.w !REGISTER_InitialScreenSettings
endif
	JSR.w SMAS_UpdateVariousRegisters_Main
	PLD
	LDA.b #$01
	STA.l !RAM_SMAS_Global_UpdateEntirePaletteFlag
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_UpdateFileSelectCursorPosition(Address)
namespace SMAS_UpdateFileSelectCursorPosition
%InsertMacroAtXPosition(<Address>)

Main:
	REP.b #$20
	LDA.w #$02FF
	STA.b !RAM_SMAS_Global_ScratchRAM00
	STA.b !RAM_SMAS_Global_ScratchRAM02
	STA.b !RAM_SMAS_Global_ScratchRAM04
	STA.b !RAM_SMAS_Global_ScratchRAM06
	STA.b !RAM_SMAS_Global_ScratchRAM08
	STA.b !RAM_SMAS_Global_ScratchRAM0A
	STA.b !RAM_SMAS_Global_ScratchRAM0C
	LDA.b !RAM_SMAS_GameSelect_CurrentlySelectedSaveFile
	AND.w #$0003
	ASL
	ASL
	TAX
	LDA.w #$034F
	STA.b !RAM_SMAS_Global_ScratchRAM00,x
	LDA.l !RAM_SMAS_Global_StripeImageUploadIndexLo
	TAX
	LDA.w !RAM_SMAS_GameSelect_CursorPosIndex
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	AND.w #$0003
else
	AND.w #$0007
endif
	ASL
	TAY
	LDA.w DATA_00B1AD,y
	XBA
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	INX
	INX
	LDA.w #$800E
	XBA
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	INX
	INX
	LDY.b #$00
CODE_00B18F:
	LDA.w !RAM_SMAS_Global_ScratchRAM00,y
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	INX
	INX
	INY
	INY
	CPY.b #$0E
	BNE.b CODE_00B18F
	LDA.w #$FFFF
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	TXA
	STA.l !RAM_SMAS_Global_StripeImageUploadIndexLo
	SEP.b #$20
	RTS

DATA_00B1AD:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	dw $7989,$7998,$7D88,$7D99
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	dw $7989,$7999,$7D87,$7D97
else
	dw $7989,$7995,$7D81,$7D8D
	dw $7D9B
endif
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_UpdateStartingAreaDisplay(Address)
namespace SMAS_UpdateStartingAreaDisplay
%InsertMacroAtXPosition(<Address>)

World:
	PHX
	PHY
	REP.b #$20
	LDA.l !RAM_SMAS_Global_StripeImageUploadIndexLo
	TAX
	LDA.w !RAM_SMAS_GameSelect_CursorPosIndex
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	AND.w #$0003
else
	AND.w #$0007
endif
	STA.b !RAM_SMAS_Global_ScratchRAM00
	ASL
	TAY
	LDA.b !RAM_SMAS_GameSelect_CurrentlySelectedSaveFile
	AND.w #$00FF
	XBA
	LSR
	LSR
	ADC.w DATA_00B29F,y
	STA.b !RAM_SMAS_Global_ScratchRAM02
	XBA
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	INX
	INX
	LDA.w #$8004
	XBA
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	INX
	INX
	LDA.b !RAM_SMAS_GameSelect_CurrentlySelectedSaveFile
	AND.w #$0003
	ASL
	ASL
	ADC.b !RAM_SMAS_Global_ScratchRAM00
	TAY
	LDA.w !RAM_SMAS_GameSelect_SelectedWorldTable,y
	AND.w #$00FF
	CLC
	ADC.w #$0341
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	INX
	INX
	ORA.w #$0010
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	INX
	INX
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	BNE.b CODE_00B237
	LDA.w !RAM_SMAS_GameSelect_HardModeWorldSelectedTable,y
	AND.w #$00FF
	ASL
	TAY
	LDA.b !RAM_SMAS_Global_ScratchRAM02
	CLC
	ADC.w #$001F
	XBA
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	INX
	INX
	LDA.w #$0002
	XBA
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	INX
	INX
	LDA.w DATA_00B2A7,y
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	INX
	INX
CODE_00B237:
	LDA.w #$FFFF
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	TXA
	STA.l !RAM_SMAS_Global_StripeImageUploadIndexLo
	SEP.b #$20
	PLY
	PLX
	RTS

Level:
	PHX
	PHY
	REP.b #$20
	LDA.l !RAM_SMAS_Global_StripeImageUploadIndexLo
	TAX
	LDA.b !RAM_SMAS_GameSelect_CurrentlySelectedSaveFile
	AND.w #$00FF
	XBA
	LSR
	LSR
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	ADC.w #$7D62
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	ADC.w #$7D63
else
	ADC.w #$797F
endif
CODE_00B25B:
	XBA
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	INX
	INX
	LDA.w #$8004
	XBA
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	INX
	INX
	LDA.b !RAM_SMAS_GameSelect_CurrentlySelectedSaveFile
	AND.w #$0003
	ASL
	ASL
	TAY
	LDA.w !RAM_SMAS_GameSelect_SelectedLevelTable+$01,y
	AND.w #$00FF
	CLC
	ADC.w #$0341
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	INX
	INX
	ORA.w #$0010
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	INX
	INX
	LDA.w #$FFFF
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	TXA
	STA.l !RAM_SMAS_Global_StripeImageUploadIndexLo
	SEP.b #$20
	PLY
	PLX
	RTS

DATA_00B29F:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	dw $7971,$797F,$7D70,$7961
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	dw $7971,$7D60,$7D6F,$7D7F
else
	dw $7971,$797C,$7D69,$7D75
endif

DATA_00B2A7:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	dw $0351,$039B
else
	dw $02B0,$039B
endif
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_HandlTitleLogoShineAnimation(Address)
namespace SMAS_HandlTitleLogoShineAnimation
%InsertMacroAtXPosition(<Address>)

Main:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.b !RAM_SMAS_Global_FrameCounter
	AND.b #$03
	BNE.b +
	LDA.b !RAM_SMAS_SplashScreen_PaletteAnimationTimer
	AND.b #$07
	ASL
	TAX
	REP.b #$20
	LDA.w DATA_00BDD6,x
	STA.b !RAM_SMAS_Global_ScratchRAM00
	CLC
	ADC.w #$000C
	STA.b !RAM_SMAS_Global_ScratchRAM03
	LDX.b #$00
	TXY
-:
	LDA.b (!RAM_SMAS_Global_ScratchRAM00),y
	STA.l SMAS_Global_PaletteMirror[$83].LowByte,x
	LDA.b (!RAM_SMAS_Global_ScratchRAM03),y
	STA.l SMAS_Global_PaletteMirror[$89].LowByte,x
	INX
	INX
	INY
	INY
	CPY.b #$0C
	BNE.b -
	SEP.b #$20
	INC.w !RAM_SMAS_Global_UpdateEntirePaletteFlag
	INC.b !RAM_SMAS_SplashScreen_PaletteAnimationTimer
+:
	RTS

DATA_00BDD6:
	dw DATA_00BDE6
	dw DATA_00BDFE
	dw DATA_00BE16
	dw DATA_00BE2E
	dw DATA_00BE46
	dw DATA_00BE5E
	dw DATA_00BE76
	dw DATA_00BE8E

DATA_00BDE6:
	dw $374D,$2288,$01A0,$7FB0,$7EA8,$49A8,$7FFF,$3F7F,$4233,$6A1F,$4D3F,$3112

DATA_00BDFE:
	dw $47D1,$330C,$11C4,$7F2C,$7E24,$4544,$53FF,$331F,$31D2,$7A9F,$5DBF,$3D93

DATA_00BE16:
	dw $57F5,$4390,$21E8,$7EA8,$6DA0,$40E0,$439F,$229F,$2171,$7FFF,$6E3F,$4A14

DATA_00BE2E:
	dw $67F9,$53F4,$320C,$7F2C,$7E24,$4544,$331F,$121F,$1110,$7A9F,$5DBF,$3D93

DATA_00BE46:
	dw $7FFF,$63F8,$4230,$7FB0,$7EA8,$49A8,$229F,$019B,$00AF,$6A1F,$4D3F,$3112

DATA_00BE5E:
	dw $67F9,$53F4,$320C,$7FF4,$7F2C,$4E0C,$331F,$121F,$1110,$599F,$3CBB,$2491

DATA_00BE76:
	dw $57F5,$4390,$21E8,$7FFF,$7F8F,$5270,$439F,$229F,$2171,$491C,$2C37,$1810

DATA_00BE8E:
	dw $47D1,$330C,$11C4,$7FF4,$7F2C,$4E0C,$53FF,$331F,$31D2,$599F,$3CBB,$2491

else
	LDA.b !RAM_SMAS_SplashScreen_PaletteAnimationTimer
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	BNE.b CODE_00BF6B
else
	BEQ.b CODE_00BED9
	JMP.w CODE_00BF6B
endif

CODE_00BED9:
	LDA.b !RAM_SMAS_SplashScreen_PaletteAnimationIndex
	CMP.b #$1C
	BEQ.b CODE_00BF57
	LDA.b #$04
	STA.b !RAM_SMAS_SplashScreen_PaletteAnimationTimer
	PHB
	PHK
	PLB
	REP.b #$20
	LDA.b !RAM_SMAS_SplashScreen_PaletteAnimationIndex
	AND.w #$00FF
	STA.b !RAM_SMAS_Global_ScratchRAM04
	CMP.w #$000E
	BCS.b CODE_00BF12
	LDA.w #$001C
	SEC
	SBC.b !RAM_SMAS_Global_ScratchRAM04
	TAX
	LDY.b #$00
CODE_00BEFD:
	LDA.w DATA_00BF6E,y
	STA.l SMAS_Global_PaletteMirror[$80].LowByte,x
	LDA.b !RAM_SMAS_Global_ScratchRAM04
	BEQ.b CODE_00BF2D
	DEC.b !RAM_SMAS_Global_ScratchRAM04
	DEC.b !RAM_SMAS_Global_ScratchRAM04
	INX
	INX
	INY
	INY
	BRA.b CODE_00BEFD

CODE_00BF12:
	LDA.b !RAM_SMAS_SplashScreen_PaletteAnimationIndex
	AND.w #$00FF
	SEC
	SBC.w #$000C
	TAY
	LDX.b #$00
CODE_00BF1E:
	LDA.w DATA_00BF6E,y
	STA.l SMAS_Global_PaletteMirror[$87].LowByte,x
	INY
	INY
	INX
	INX
	CPX.b #$10
	BNE.b CODE_00BF1E
CODE_00BF2D:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
else
	LDY.b !RAM_SMAS_SplashScreen_PaletteAnimationIndex
	CPY.b #$12
	BCS.b CODE_00BF4B
	LDA.w DATA_00BF8C,y
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDX.b #$00
	TXY
CODE_00BF3B:
	LDA.b (!RAM_SMAS_Global_ScratchRAM00),y
	STA.l SMAS_Global_PaletteMirror[$97].LowByte,x
	INX
	INX
	INX
	INX
	INY
	INY
	CPY.b #$0A
	BNE CODE_00BF3B
CODE_00BF4B:
endif
	INC.b !RAM_SMAS_SplashScreen_PaletteAnimationIndex
	INC.b !RAM_SMAS_SplashScreen_PaletteAnimationIndex
	INC.w !RAM_SMAS_Global_UpdateEntirePaletteFlag
	SEP.b #$20
	PLB
	BRA.b CODE_00BF6B

CODE_00BF57:
	REP.b #$20
	LDA.b !RAM_SMAS_TitleScreen_PhaseTimerLo
	CMP.w !RAM_SMAS_TitleScreen_FrameToRestartLogoPaletteAnimationLo
	BNE.b CODE_00BF67
	LDA.w #$00F0
	STA.b !RAM_SMAS_SplashScreen_PaletteAnimationTimer
	STZ.b !RAM_SMAS_SplashScreen_PaletteAnimationIndex
CODE_00BF67:
	SEP.b #$20
	BRA.b CODE_00BF6D

CODE_00BF6B:
	DEC.b !RAM_SMAS_SplashScreen_PaletteAnimationTimer
CODE_00BF6D:
	RTS

DATA_00BF6E:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	dw $1EDF,$435F,$5FBF,$7FFF
	dw $5FBF,$435F,$1EDF,$025F
	dw $025F,$025F,$025F,$025F
	dw $025F,$025F,$025F
else
	dw $7F52,$7FD7,$7FFD,$7FFF
	dw $7FFD,$7FD7,$7F52,$7ECF
	dw $7ECF,$7ECF,$7ECF,$7ECF
	dw $7ECF,$7ECF,$7ECF

DATA_00BF8C:
	dw DATA_00BFE4
	dw DATA_00BFE4
	dw DATA_00BFDA
	dw DATA_00BFD0
	dw DATA_00BFC6
	dw DATA_00BFBC
	dw DATA_00BFB2
	dw DATA_00BFA8
	dw DATA_00BF9E

DATA_00BF9E:
	dw $08FF,$7E4C,$03A3,$031F
	dw $00F7

DATA_00BFA8:
	dw $15FF,$7EAF,$13E6,$137F
	dw $015A

DATA_00BFB2:
	dw $21BF,$7F12,$23E9,$23DF
	dw $01BD

DATA_00BFBC:
	dw $2E1F,$7F15,$33EC,$33FF
	dw $0E1F

DATA_00BFC6:
	dw $3A7F,$7FD8,$47F0,$43FF
	dw $1A7F

DATA_00BFD0:
	dw $46DF,$7FFB,$5BF3,$53FF
	dw $26DF

DATA_00BFDA:
	dw $533F,$7FFE,$6BF7,$63FF
	dw $333F

DATA_00BFE4:
	dw $5F9F,$7FFF,$7FFD,$73FF
	dw $3F9F
endif
endif
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_GameMode03_InitializeEraseFileMenu(Address)
namespace SMAS_GameMode03_InitializeEraseFileMenu
%InsertMacroAtXPosition(<Address>)

Main:
	REP.b #$30
	LDA.w !RAM_SMAS_GameSelect_CursorPosIndex
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	AND.w #$0003
else
	AND.w #$0007
endif
	ASL
	TAY
	PHY
	LDA.w !RAM_SMAS_GameSelect_EraseFileMenuAnimationIndex
	AND.w #$000F
	XBA
	LSR
	LSR
	LSR
	STA.b !RAM_SMAS_Global_ScratchRAM0E
	TAX
	LDA.w SMAS_FileSelectMenuData_DATA_00B421,y
	SEC
	SBC.b !RAM_SMAS_Global_ScratchRAM0E
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w SMAS_FileSelectMenuData_DATA_00B435,y
	STA.b !RAM_SMAS_Global_ScratchRAM02
	LDA.w !RAM_SMAS_GameSelect_EraseFileMenuAnimationIndex
	AND.w #$000F
	ASL
	TAY
	LDA.w SMAS_FileSelectMenuData_DATA_00B449,y
	STA.b !RAM_SMAS_Global_ScratchRAM08
	STZ.b !RAM_SMAS_Global_ScratchRAM04
	LDA.l !RAM_SMAS_Global_StripeImageUploadIndexLo
	TAX
	JSR.w SMAS_UpdateEraseFileMenuDisplay_Main
	PLY
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	BEQ.b CODE_00B2FF
	CPY.w #$0004
	BEQ.b CODE_00B2FF
else
	LDA.w SMAS_FileSelectMenuData_DATA_00B43F,y
	BEQ.b CODE_00B2FF
endif
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	AND.w #$7FE0
	EOR.w #$0400
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w SMAS_FileSelectMenuData_DATA_00B43F,y
	STA.b !RAM_SMAS_Global_ScratchRAM02
	JSR.w SMAS_UpdateEraseFileMenuDisplay_Main
CODE_00B2FF:
	PHY
	LDA.w SMAS_FileSelectMenuData_DATA_00B42B,y
	CLC
	ADC.b !RAM_SMAS_Global_ScratchRAM0E
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w SMAS_FileSelectMenuData_DATA_00B435,y
	STA.b !RAM_SMAS_Global_ScratchRAM02
	LDA.w !RAM_SMAS_GameSelect_EraseFileMenuAnimationIndex
	AND.w #$000F
	ASL
	TAY
	LDA.w SMAS_FileSelectMenuData_DATA_00B451,y
	STA.b !RAM_SMAS_Global_ScratchRAM08
	STZ.b !RAM_SMAS_Global_ScratchRAM04
	JSR.w SMAS_UpdateEraseFileMenuDisplay_Main
	PLY
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	BEQ.b CODE_00B337
	CPY.w #$0004
	BEQ.b CODE_00B337
else
	LDA.w SMAS_FileSelectMenuData_DATA_00B43F,y
	BEQ.b CODE_00B337
endif
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	AND.w #$7FE0
	EOR.w #$0400
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w SMAS_FileSelectMenuData_DATA_00B43F,y
	STA.b !RAM_SMAS_Global_ScratchRAM02
	JSR.w SMAS_UpdateEraseFileMenuDisplay_Main
CODE_00B337:
	LDA.w #$FFFF
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	TXA
	STA.l !RAM_SMAS_Global_StripeImageUploadIndexLo
	SEP.b #$30
	INC.w !RAM_SMAS_GameSelect_EraseFileMenuAnimationIndex
	LDA.w !RAM_SMAS_GameSelect_EraseFileMenuAnimationIndex
	CMP.b #$04
	BNE.b CODE_00B354
	INC.b !RAM_SMAS_Global_GameMode
	STZ.w !RAM_SMAS_GameSelect_EraseFileMenuCursorPos
CODE_00B354:
	RTL
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_UpdateEraseFileMenuDisplay(Address)
namespace SMAS_UpdateEraseFileMenuDisplay
%InsertMacroAtXPosition(<Address>)

Main:
	PHY
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	XBA
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	INX
	INX
	LDA.b !RAM_SMAS_Global_ScratchRAM02
	XBA
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	INX
	INX
	LSR.b !RAM_SMAS_Global_ScratchRAM02
	LDY.b !RAM_SMAS_Global_ScratchRAM04
CODE_00B36C:
	LDA.b (!RAM_SMAS_Global_ScratchRAM08),y
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	INX
	INX
	INY
	INY
	DEC.b !RAM_SMAS_Global_ScratchRAM02
	BNE.b CODE_00B36C
	STY.b !RAM_SMAS_Global_ScratchRAM04
	PLY
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_ClearSMWSaveData(Address)
namespace SMAS_ClearSMWSaveData
%InsertMacroAtXPosition(<Address>)

Main:							; Glitch: This routine is called when erasing save files for other games. It seems to only run for the empty SMW files though.
	PHB
	PHK
	PLB
	REP.b #$30
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	AND.w #$0003
	ASL
	TAY
	LDX.w SMAS_FileSelectMenuData_DATA_00B70C,y
	LDY.w #!Define_SMW_Misc_SaveFileSize/2
	LDA.w #$0000
CODE_00B6BD:
	STA.l !SRAM_SMW_MarioA_StartLocation,x
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E) != $00
	STA.l !SRAM_SMW_MarioA_Backup,x
else
	STA.l !SRAM_SMW_MarioB_Backup,x
endif
	INX
	INX
	DEY
	BNE.b CODE_00B6BD
	STA.l !SRAM_SMW_MarioA_StartLocation-$01,x
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E) != $00
	STA.l !SRAM_SMW_MarioA_Backup-$01,x
else
	STA.l !SRAM_SMW_MarioB_Backup-$01,x
endif
	SEP.b #$30
	PLB
	RTL
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_GameMode04_ShowEraseFileMenu(Address)
namespace SMAS_GameMode04_ShowEraseFileMenu
%InsertMacroAtXPosition(<Address>)

Main:
	LDA.b !RAM_SMAS_Global_ControllerPress2CopyP1
	ORA.b !RAM_SMAS_Global_ControllerPress2CopyP2
	AND.b #!Joypad_A
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.b !RAM_SMAS_Global_ControllerPress1CopyP1
	ORA.b !RAM_SMAS_Global_ControllerPress1CopyP2
	AND.b #(!Joypad_Start>>8)|(!Joypad_Select>>8)|(!Joypad_DPadD>>8)|(!Joypad_DPadU>>8)
	ORA.b !RAM_SMAS_Global_ScratchRAM00
	BEQ.b CODE_00B58F
	STA.b !RAM_SMAS_Global_ScratchRAM00
	AND.b #(!Joypad_Select>>8)|(!Joypad_DPadD>>8)|(!Joypad_DPadU>>8)
	BEQ.b CODE_00B592
	LDA.w !RAM_SMAS_GameSelect_EraseFileMenuCursorPos
	EOR.b #$04
	STA.w !RAM_SMAS_GameSelect_EraseFileMenuCursorPos
	REP.b #$20
	LDA.l !RAM_SMAS_Global_StripeImageUploadIndexLo
	TAX
	LDA.w !RAM_SMAS_GameSelect_CursorPosIndex
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	AND.w #$0003
else
	AND.w #$0007
endif
	ASL
	TAY
	LDA.w SMAS_FileSelectMenuData_DATA_00B6D6,y
	XBA
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	LDA.w #$8006
	XBA
	STA.l SMAS_Global_StripeImageUploadTable[$01].LowByte,x
	LDA.w #$02FF
	STA.l SMAS_Global_StripeImageUploadTable[$02].LowByte,x
	STA.l SMAS_Global_StripeImageUploadTable[$03].LowByte,x
	STA.l SMAS_Global_StripeImageUploadTable[$04].LowByte,x
	PHX
	LDX.w !RAM_SMAS_GameSelect_EraseFileMenuCursorPos
	LDA.w #$034F
	STA.l SMAS_Global_StripeImageUploadTable[$02].LowByte,x
	PLX
	LDA.w #$FFFF
	STA.l SMAS_Global_StripeImageUploadTable[$05].LowByte,x
	TXA
	CLC
	ADC.w #$000C
	STA.l !RAM_SMAS_Global_StripeImageUploadIndexLo
	SEP.b #$20
	LDA.b #!Define_SMAS_Sound0063_StepOnLevelTile
	STA.b !RAM_SMAS_Global_SoundCh3
CODE_00B58F:
	JMP.w CODE_00B678

CODE_00B592:
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	AND.b #(!Joypad_Start>>8)|!Joypad_A
	BNE.b CODE_00B59F
CODE_00B598:
	LDA.b #!Define_SMAS_Sound0063_MessageBox
	STA.b !RAM_SMAS_Global_SoundCh3
	JMP.w CODE_00B678

CODE_00B59F:
	LDA.b #!Define_SMAS_Sound0063_1up
	STA.b !RAM_SMAS_Global_SoundCh3
	INC.b !RAM_SMAS_Global_GameMode
	LDA.w !RAM_SMAS_GameSelect_EraseFileMenuCursorPos
	BEQ.b CODE_00B598
	LDA.w !RAM_SMAS_GameSelect_CursorPosIndex
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	AND.b #$03
else
if !Define_Global_SMASGames&(!SMASGames_SMW) != $00
	CMP.b #$04
	BEQ.b CODE_00B5CB
endif
endif
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.b !RAM_SMAS_GameSelect_CurrentlySelectedSaveFile
	AND.b #$03
	ASL
	ASL
	ADC.b !RAM_SMAS_Global_ScratchRAM00
	TAX
	LDA.b #$FF
	STA.b !RAM_SMAS_GameSelect_SelectedWorldTable,x
	STA.b !RAM_SMAS_GameSelect_SelectedLevelTable,x
	LDA.b #$00
	STA.b !RAM_SMAS_GameSelect_HardModeWorldSelectedTable,x
	JSR.w SMAS_ClearSaveData_Main
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
if !Define_Global_SMASGames&(!SMASGames_SMW) != $00
	BRA.b CODE_00B5D6

CODE_00B5CB:
	LDA.b !RAM_SMAS_GameSelect_CurrentlySelectedSaveFile
	STA.b !RAM_SMAS_Global_ScratchRAM00
	JSL.l SMAS_ClearSMWSaveData_Main
	JSR.w SMAS_MakeFileSelectYoshiLick_Main
CODE_00B5D6:
endif
endif
	REP.b #$20
	LDA.l !RAM_SMAS_Global_StripeImageUploadIndexLo
	TAX
	LDA.w !RAM_SMAS_GameSelect_CursorPosIndex
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	AND.w #$0003
else
	AND.w #$0007
endif
	ASL
	TAY
	LDA.w SMAS_FileSelectMenuData_DATA_00B6E0,y
	STA.b !RAM_SMAS_Global_ScratchRAM00
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E) != $00
	LDA.b !RAM_SMAS_GameSelect_CurrentlySelectedSaveFile
else
	LDA.w !RAM_SMAS_GameSelect_CurrentlySelectedSaveFile
endif
	AND.w #$0003
	XBA
	LSR
	LSR
	ADC.b !RAM_SMAS_Global_ScratchRAM00
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w SMAS_FileSelectMenuData_DATA_00B6EA,y
	STA.b !RAM_SMAS_Global_ScratchRAM02
	STZ.b !RAM_SMAS_Global_ScratchRAM0E
	JSR.w CODE_00B679
	LDA.w !RAM_SMAS_GameSelect_CursorPosIndex
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	AND.w #$0003
else
	AND.w #$0007
endif
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	CMP.w #$0003
else
	CMP.w #$0001
endif
	BNE.b CODE_00B628
	PHY
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	INY
	INY
	LDA.w SMAS_FileSelectMenuData_DATA_00B6E0,y
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w !RAM_SMAS_GameSelect_CurrentlySelectedSaveFile
	AND.w #$0003
	XBA
	LSR
	LSR
	ADC.b !RAM_SMAS_Global_ScratchRAM00
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w SMAS_FileSelectMenuData_DATA_00B6EA,y
else
	LDA.w #$7D60
	STA.b !RAM_SMAS_Global_ScratchRAM00
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E) != $00
	LDA.b !RAM_SMAS_GameSelect_CurrentlySelectedSaveFile
else
	LDA.w !RAM_SMAS_GameSelect_CurrentlySelectedSaveFile
endif
	AND.w #$0003
	XBA
	LSR
	LSR
	ADC.b !RAM_SMAS_Global_ScratchRAM00
	STA.b !RAM_SMAS_Global_ScratchRAM00
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	LDA.w #$000A
else
	LDA.w #$0004
endif
endif
	STA.b !RAM_SMAS_Global_ScratchRAM02
	JSR.w CODE_00B679
	PLY
CODE_00B628:
	LDA.w SMAS_FileSelectMenuData_DATA_00B6E0,y
	STA.b !RAM_SMAS_Global_ScratchRAM00
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E) != $00
	LDA.b !RAM_SMAS_GameSelect_CurrentlySelectedSaveFile
else
	LDA.w !RAM_SMAS_GameSelect_CurrentlySelectedSaveFile
endif
	AND.w #$0003
	XBA
	LSR
	LSR
	ADC.w #$0020
	ADC.b !RAM_SMAS_Global_ScratchRAM00
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w SMAS_FileSelectMenuData_DATA_00B6EA,y
	STA.b !RAM_SMAS_Global_ScratchRAM02
	JSR.w CODE_00B679
	LDA.w !RAM_SMAS_GameSelect_CursorPosIndex
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	AND.w #$0003
else
	AND.w #$0007
endif
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	CMP.w #$0003
else
	CMP.w #$0001
endif
	BNE.b CODE_00B66A
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	INY
	INY
	LDA.w SMAS_FileSelectMenuData_DATA_00B6E0,y
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w !RAM_SMAS_GameSelect_CurrentlySelectedSaveFile
	AND.w #$0003
	XBA
	LSR
	LSR
	ADC.w #$0020
	ADC.b !RAM_SMAS_Global_ScratchRAM00
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w SMAS_FileSelectMenuData_DATA_00B6EA,y
else
	LDA.w #$7D80
	STA.b !RAM_SMAS_Global_ScratchRAM00
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E) != $00
	LDA.b !RAM_SMAS_GameSelect_CurrentlySelectedSaveFile
else
	LDA.w !RAM_SMAS_GameSelect_CurrentlySelectedSaveFile
endif
	AND.w #$0003
	XBA
	LSR
	LSR
	ADC.b !RAM_SMAS_Global_ScratchRAM00
	STA.b !RAM_SMAS_Global_ScratchRAM00
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	LDA.w #$000A
else
	LDA.w #$0004
endif
endif
	STA.b !RAM_SMAS_Global_ScratchRAM02
	JSR.w CODE_00B679
CODE_00B66A:
	LDA.w #$FFFF
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	TXA
	STA.l !RAM_SMAS_Global_StripeImageUploadIndexLo
	SEP.b #$20
CODE_00B678:
	RTL

CODE_00B679:
	PHY
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	XBA
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	INX
	INX
	LDA.b !RAM_SMAS_Global_ScratchRAM02
	XBA
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	XBA
	LSR
	AND.w #$00FF
	STA.b !RAM_SMAS_Global_ScratchRAM04
	INX
	INX
CODE_00B693:
	LDY.b !RAM_SMAS_Global_ScratchRAM0E
	LDA.w SMAS_FileSelectMenuData_DATA_00B6F4,y
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	INC.b !RAM_SMAS_Global_ScratchRAM0E
	INC.b !RAM_SMAS_Global_ScratchRAM0E
	INX
	INX
	DEC.b !RAM_SMAS_Global_ScratchRAM04
	BNE.b CODE_00B693
	PLY
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_RT00_SMAS_GameMode02_GameSelectScreen(Address)
namespace SMAS_GameMode02_GameSelectScreen
%InsertMacroAtXPosition(<Address>)

if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
DATA_00A367:
	db $27,$61,$2D,$61,$33,$61,$39,$61
	db $87,$61,$8D,$61,$93,$61,$99,$61
	db $E7,$61,$ED,$61,$F3,$61,$F9,$61
	db $47,$62,$4D,$62,$53,$62,$59,$62
endif

DATA_00A196:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	db $1F,$21,$22,$22
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	db $21,$1D,$21,$25
else
	db $19,$19,$19,$1D,$1D
endif

if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
UNK_00A38B:
	db $64,$F0,$64,$F1,$64,$F4,$64,$F5
	db $64,$F2,$64,$F3,$64,$F6,$64,$F7
endif

Main:
	LDA.b !RAM_SMAS_GameSelect_UnknownRAM0000E1
	BNE.b CODE_00A1E0
	LDA.b !RAM_SMAS_Global_FrameCounter
	LSR
	BCS.b CODE_00A1DD
CODE_00A1A4:
	REP.b #$20
	LDX.b !RAM_SMAS_TitleScreen_TriangleTransitionEffectIndexLo
	LDA.l SMAS_TriangleTransitionEffectGFXPointers_Main,x
	STA.b !RAM_SMAS_Global_TriangleTransitionEffectPtrLo
	DEX
	DEX
	STX.b !RAM_SMAS_TitleScreen_TriangleTransitionEffectIndexLo
	BPL.b CODE_00A1DD
	LDA.w #!Define_SMB1_MenuMusic_GameSelect
	STA.w !RAM_SMAS_Global_MusicCh1
	INC.b !RAM_SMAS_GameSelect_UnknownRAM0000E1
	LDX.b #$01
	STX.w !RAM_SMAS_GameSelect_UploadFileSelectGFXFlag
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.w #$0000
	STA.w !RAM_SMAS_Global_BG2AddressAndSize
else
	LDA.w #SMAS_FileSelectGFX_Main_Controller
	STA.w !RAM_SMAS_GameSelect_FileSelectGFXPrtLo
	STZ.w !RAM_SMAS_Global_BG2AddressAndSize
endif
	STZ.w !RAM_SMAS_Global_BG1And2TileDataDesignation
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.w #$0032
	STA.b !RAM_SMAS_GameSelect_UnknownRAM000014
	STZ.b !RAM_SMAS_GameSelect_UnknownRAM000015
	LDA.w #$00C0
	STA.b !RAM_SMAS_GameSelect_UnknownRAM000016
	LDA.w #$0000
	STA.b !RAM_SMAS_GameSelect_UnknownRAM000019
	STZ.b !RAM_SMAS_GameSelect_UnknownRAM00001A
endif
	LDA.w #$0001
	STA.w !RAM_SMAS_Global_MainScreenLayers
	LDA.w #$0020
	STA.b !RAM_SMAS_GameSelect_UnknownRAM00001B
	LDA.w #$0061
	STA.b !RAM_SMAS_GameSelect_UnknownRAM00001C
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.w #$0040
	STA.b !RAM_SMAS_GameSelect_UnknownRAM000020
endif
CODE_00A1DD:
	SEP.b #$20
	RTL

CODE_00A1E0:
	LDA.w !RAM_SMAS_GameSelect_MoveCursorRightTimer
	BNE.b CODE_00A220
	LDA.w !RAM_SMAS_GameSelect_MoveCursorLeftTimer
	BNE.b CODE_00A254
	LDX.w !RAM_SMAS_GameSelect_ActiveFileSelectTransitionFlag
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	BNE.b CODE_00A275
else
	BEQ.b CODE_00A1F2
	JMP.w CODE_00A275
endif

CODE_00A1F2:
	LDX.w !RAM_SMAS_GameSelect_FileSelectMenuActiveFlag
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	BNE.b CODE_00A275
else
	BEQ.b CODE_00A1FA
	JMP.w CODE_00A275
endif

CODE_00A1FA:
	LDA.b !RAM_SMAS_Global_ControllerPress1CopyP1
	ORA.b !RAM_SMAS_Global_ControllerPress1CopyP2
	AND.b #(!Joypad_DPadL>>8)|(!Joypad_DPadR>>8)
	BEQ.b CODE_00A26A
	AND.b #!Joypad_DPadR>>8
	BEQ.b CODE_00A238
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.w !RAM_SMAS_GameSelect_CursorPosIndex
	AND.b #$03
	TAX
else
	LDX.w !RAM_SMAS_GameSelect_CursorPosIndex
endif
	LDA.w DATA_00A196,x
	STA.w !RAM_SMAS_GameSelect_MoveCursorRightTimer
	INC.w !RAM_SMAS_GameSelect_CursorPosIndex
	LDA.b #!Define_SMAS_Sound0063_Coin
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	STA.w !RAM_SMAS_Global_SoundCh3
else
	STA.b !RAM_SMAS_Global_SoundCh3
	LDA.w !RAM_SMAS_GameSelect_CursorPosIndex
	CMP.b #$05
	BNE.b CODE_00A220
	STZ.w !RAM_SMAS_GameSelect_CursorPosIndex
endif
CODE_00A220:
	DEC.w !RAM_SMAS_GameSelect_MoveCursorRightTimer
	BEQ.b CODE_00A26A
	REP.b #$20
	LDA.w !RAM_SMAS_GameSelect_Layer1XPosBelowCursorLo
	CLC
	ADC.w #$0004
	AND.w #$01FF
	STA.w !RAM_SMAS_GameSelect_Layer1XPosBelowCursorLo
	SEP.b #$20
	BRA.b CODE_00A26A

CODE_00A238:
	DEC.w !RAM_SMAS_GameSelect_CursorPosIndex
	LDA.w !RAM_SMAS_GameSelect_CursorPosIndex
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	AND.b #$03
else
	AND.b #$0F
	CMP.b #$05
	BCC.b CODE_00A249
	LDA.b #$04
	STA.w !RAM_SMAS_GameSelect_CursorPosIndex
endif
CODE_00A249:
	TAX
	LDA.w DATA_00A196,x
	STA.w !RAM_SMAS_GameSelect_MoveCursorLeftTimer
	LDA.b #!Define_SMAS_Sound0063_Coin
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	STA.w !RAM_SMAS_Global_SoundCh3
else
	STA.b !RAM_SMAS_Global_SoundCh3
endif
CODE_00A254:
	DEC.w !RAM_SMAS_GameSelect_MoveCursorLeftTimer
	BEQ.b CODE_00A26A
	REP.b #$20
	LDA.w !RAM_SMAS_GameSelect_Layer1XPosBelowCursorLo
	SEC
	SBC.w #$0004
	AND.w #$01FF
	STA.w !RAM_SMAS_GameSelect_Layer1XPosBelowCursorLo
	SEP.b #$20
CODE_00A26A:
	LDA.w !RAM_SMAS_GameSelect_MoveCursorRightTimer
	ORA.w !RAM_SMAS_GameSelect_MoveCursorLeftTimer
	BEQ.b CODE_00A275
	JMP.w CODE_00A576

CODE_00A275:
	STZ.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w !RAM_SMAS_GameSelect_SelectedAFileFlag
	BEQ.b CODE_00A298
	DEC.w !RAM_SMAS_GameSelect_WaitAfterSelectingFileTimer
	LDA.w !RAM_SMAS_GameSelect_WaitAfterSelectingFileTimer
	BNE.b CODE_00A288
	LDA.b #$06
	STA.b !RAM_SMAS_Global_GameMode
CODE_00A288:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
if !Define_Global_SMASGames&(!SMASGames_SMW) != $00
	LDA.w !RAM_SMAS_GameSelect_YoshiAnimationTimer
	BMI.b CODE_00A295
	DEC.w !RAM_SMAS_GameSelect_YoshiAnimationTimer
	BNE.b CODE_00A295
	JSR.w SMAS_MakeFileSelectYoshiBlink_Main
else
	BRA.b +
	NOP #11
+
endif
endif
CODE_00A295:
	JMP.w CODE_00A576

CODE_00A298:
	LDA.w !RAM_SMAS_GameSelect_FileSelectMenuActiveFlag
	BEQ.b CODE_00A2B2
	LDA.b !RAM_SMAS_Global_ControllerPress1CopyP1
	ORA.b !RAM_SMAS_Global_ControllerPress1CopyP2
	ORA.b !RAM_SMAS_Global_ControllerPress2CopyP1
	ORA.b !RAM_SMAS_Global_ControllerPress2CopyP2
	AND.b #!Joypad_X|(!Joypad_Y>>8)
	STA.b !RAM_SMAS_Global_ScratchRAM00
	BNE.b CODE_00A2CC
	LDA.w !RAM_SMAS_GameSelect_ActiveFileSelectTransitionFlag
	BNE.b CODE_00A2CC
	BRA.b CODE_00A2D7

CODE_00A2B2:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDX.w !RAM_SMAS_GameSelect_ActiveFileSelectTransitionFlag
else
	LDA.w !RAM_SMAS_GameSelect_ActiveFileSelectTransitionFlag
endif
	BNE.b CODE_00A2CC
	LDA.b !RAM_SMAS_Global_ControllerPress1CopyP1
	ORA.b !RAM_SMAS_Global_ControllerPress1CopyP2
	AND.b #!Joypad_Start>>8
	STA.b !RAM_SMAS_Global_ScratchRAM00
	BNE.b CODE_00A2C3
	BRA.b CODE_00A2D7

CODE_00A2C3:
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	PHA
	JSR.w SMAS_InitializeFileSelectMenuWindowBuffer_Main
	PLA
	STA.b !RAM_SMAS_Global_ScratchRAM00
CODE_00A2CC:
	LDA.w !RAM_SMAS_GameSelect_CursorPosIndex
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	AND.b #$03
endif
	ASL
	TAX
	JSR.w (DATA_00A664,x)
	JMP.w CODE_00A576

CODE_00A2D7:
	LDA.w !RAM_SMAS_GameSelect_FileSelectMenuActiveFlag
	BNE.b CODE_00A2DF
	JMP.w CODE_00A576

CODE_00A2DF:
	LDA.b !RAM_SMAS_Global_ScratchRAM0C
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w !RAM_SMAS_GameSelect_CursorPosIndex
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	AND.b #$03
endif
	STA.b !RAM_SMAS_GameSelect_CurrentlyOpenedFileSelectWindow
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
	LDA.w !RAM_SMAS_GameSelect_YoshiAnimationTimer
	BMI.b CODE_00A2F8
	DEC.w !RAM_SMAS_GameSelect_YoshiAnimationTimer
	BNE.b CODE_00A2F8
	JSR.w SMAS_MakeFileSelectYoshiLick_Main
	JMP.w CODE_00A576
endif

CODE_00A2F8:
	LDA.b !RAM_SMAS_Global_ControllerPress1CopyP1
	ORA.b !RAM_SMAS_Global_ControllerPress1CopyP2
	AND.b #!Joypad_Select>>8
	BEQ.b CODE_00A321
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
	LDA.b !RAM_SMAS_GameSelect_CurrentlyOpenedFileSelectWindow
	CMP.b #$04
	BNE.b CODE_00A30D
	LDA.b #!Define_SMAS_Sound0063_Wrong
	STA.b !RAM_SMAS_Global_SoundCh3
	JMP.w CODE_00A576
endif

CODE_00A30D:
	LDA.l !SRAM_SMAS_Global_ControllerTypeX
	EOR.b #$01
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J2|!ROM_SMASW_E) != $00
	AND.b #$01
endif
	STA.l !SRAM_SMAS_Global_ControllerTypeX
	LDA.b #!Define_SMAS_Sound0063_Coin
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	STA.w !RAM_SMAS_Global_SoundCh3
else
	STA.b !RAM_SMAS_Global_SoundCh3
endif
	JSR.w SMAS_UpdateControllerTypeDisplay_Main
	JMP.w CODE_00A576

CODE_00A321:
	LDA.b !RAM_SMAS_Global_ControllerPress1CopyP1
	ORA.b !RAM_SMAS_Global_ControllerPress1CopyP2
	AND.b #(!Joypad_DPadD>>8)|(!Joypad_DPadU>>8)
	LSR
	LSR
	TAX
	LDA.b !RAM_SMAS_GameSelect_CurrentlySelectedSaveFile
	CLC
	ADC.w SMAS_FileSelectMenuData_DATA_00B714,x
	AND.b #$03
	STA.b !RAM_SMAS_GameSelect_CurrentlySelectedSaveFile
	TXY
	BEQ.b CODE_00A34D
	LDA.w !RAM_SMAS_GameSelect_ActiveFileSelectTransitionFlag
	BNE.b CODE_00A34B
	LDA.w !RAM_SMAS_GameSelect_FileSelectMenuActiveFlag
	BEQ.b CODE_00A34B
	JSR.w SMAS_UpdateFileSelectCursorPosition_Main
	LDA.b #!Define_SMAS_Sound0063_StepOnLevelTile
	STA.b !RAM_SMAS_Global_SoundCh3
	JMP.w CODE_00A576

CODE_00A34B:
	LDA.b !RAM_SMAS_GameSelect_CurrentlySelectedSaveFile
CODE_00A34D:
	ASL
	ASL
	CLC
	ADC.b !RAM_SMAS_GameSelect_CurrentlyOpenedFileSelectWindow
	STA.b !RAM_SMAS_Global_ScratchRAM01
	TAX
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.b !RAM_SMAS_GameSelect_CanDisplayEraseFileMenuFlag
	BEQ.b +
	JMP.w label_00A7D6
+:
else
	LDA.b !RAM_SMAS_GameSelect_CurrentlyOpenedFileSelectWindow
	CMP.b #$04
	BEQ.b CODE_00A386
endif
	LDA.b !RAM_SMAS_GameSelect_SelectedWorldTable,x
	INC
	BNE.b CODE_00A386
	LDA.b !RAM_SMAS_Global_ControllerPress1CopyP1
	ORA.b !RAM_SMAS_Global_ControllerPress1CopyP2
	AND.b #!Joypad_Start>>8
	BEQ.b CODE_00A36B
	JMP.w CODE_00A527

CODE_00A36B:
	LDA.b !RAM_SMAS_Global_ControllerPress1CopyP1
	ORA.b !RAM_SMAS_Global_ControllerPress1CopyP2
	AND.b #(!Joypad_DPadL>>8)|(!Joypad_DPadR>>8)|(!Joypad_B>>8)
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.b !RAM_SMAS_Global_ControllerPress2CopyP1
	ORA.b !RAM_SMAS_Global_ControllerPress2CopyP2
	AND.b #!Joypad_A
	ORA.b !RAM_SMAS_Global_ScratchRAM00
	AND.b #(!Joypad_DPadL>>8)|(!Joypad_DPadR>>8)|!Joypad_A|(!Joypad_B>>8)
	BEQ.b CODE_00A383
CODE_00A37F:
	LDA.b #!Define_SMAS_Sound0063_Wrong
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	STA.w !RAM_SMAS_Global_SoundCh3
else
	STA.b !RAM_SMAS_Global_SoundCh3
endif
CODE_00A383:
	JMP.w CODE_00A576

CODE_00A386:
	TXA
	AND.b #$03
	CMP.b #$01
	BNE.b CODE_00A390
	JMP.w CODE_00A477

CODE_00A390:
	LDA.b !RAM_SMAS_Global_ControllerPress1CopyP1
	ORA.b !RAM_SMAS_Global_ControllerPress1CopyP2
	AND.b #(!Joypad_DPadL>>8)|(!Joypad_DPadR>>8)|(!Joypad_B>>8)
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
	STA.b !RAM_SMAS_Global_ScratchRAM00
endif
	BNE.b CODE_00A39D
	JMP.w CODE_00A51F

CODE_00A39D:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
	LDA.b !RAM_SMAS_GameSelect_CurrentlyOpenedFileSelectWindow
	AND.b #$04
	BNE.b CODE_00A37F
	LDA.b !RAM_SMAS_Global_ScratchRAM00
endif
	AND.b #!Joypad_DPadL>>8
	BEQ.b CODE_00A3AC
	JMP.w CODE_00A426

CODE_00A3AC:
	LDA.b !RAM_SMAS_GameSelect_SelectedWorldTable,x
	CMP.b #$02
	BCS.b CODE_00A3B6
	LDA.b #!Define_SMAS_Sound0063_Wrong
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	STA.w !RAM_SMAS_Global_SoundCh3
else
	STA.b !RAM_SMAS_Global_SoundCh3
endif
CODE_00A3B6:
	LDA.b !RAM_SMAS_GameSelect_CurrentlyOpenedFileSelectWindow
	BNE.b CODE_00A3C0
	LDA.l !SRAM_SMAS_GameSelect_CanSelectHardModeWorldTable,x
	BNE.b CODE_00A3C6
CODE_00A3C0:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	LDA.w !RAM_SMAS_GameSelect_MaxWorldTable,x
else
	LDA.b !RAM_SMAS_GameSelect_MaxWorldTable,x
endif
	CMP.b #$01
	BEQ.b CODE_00A3CA
CODE_00A3C6:
	LDA.b #!Define_SMAS_Sound0063_FinishAddTimerToScore
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	STA.w !RAM_SMAS_Global_SoundCh3
else
	STA.b !RAM_SMAS_Global_SoundCh3
endif
CODE_00A3CA:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	INC.w !RAM_SMAS_GameSelect_SelectedWorldTable,x
else
	INC.b !RAM_SMAS_GameSelect_SelectedWorldTable,x
endif
	LDA.b !RAM_SMAS_GameSelect_CurrentlyOpenedFileSelectWindow
	BNE.b CODE_00A402
	LDA.l !SRAM_SMAS_GameSelect_CanSelectHardModeWorldTable,x
	BEQ.b CODE_00A402
	LDA.b !RAM_SMAS_GameSelect_HardModeWorldSelectedTable,x
	BNE.b CODE_00A3EA
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.w !RAM_SMAS_GameSelect_SelectedWorldTable,x
else
	LDA.b !RAM_SMAS_GameSelect_SelectedWorldTable,x
endif
	CMP.b #$09
	BCC.b CODE_00A420
	LDA.b #$01
	STA.b !RAM_SMAS_GameSelect_HardModeWorldSelectedTable,x
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	STA.w !RAM_SMAS_GameSelect_SelectedWorldTable,x
	STA.w !RAM_SMAS_GameSelect_SelectedLevelTable,x
else
	STA.b !RAM_SMAS_GameSelect_SelectedWorldTable,x
	STA.b !RAM_SMAS_GameSelect_SelectedLevelTable,x
endif
	BRA.b CODE_00A420

CODE_00A3EA:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.w !RAM_SMAS_GameSelect_SelectedWorldTable,x
	CMP.w !RAM_SMAS_GameSelect_MaxWorldTable,x
else
	LDA.b !RAM_SMAS_GameSelect_SelectedWorldTable,x
	CMP.b !RAM_SMAS_GameSelect_MaxWorldTable,x
endif
	BEQ.b CODE_00A3FA
	BCC.b CODE_00A3F6
	STZ.b !RAM_SMAS_GameSelect_HardModeWorldSelectedTable,x
	LDA.b #$01
CODE_00A3F6:
	STA.b !RAM_SMAS_GameSelect_SelectedWorldTable,x
	BRA.b CODE_00A420

CODE_00A3FA:
	STA.b !RAM_SMAS_GameSelect_SelectedWorldTable,x
	LDA.b #$01
	STA.b !RAM_SMAS_GameSelect_SelectedLevelTable,x
	BRA.b CODE_00A420

CODE_00A402:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.w !RAM_SMAS_GameSelect_SelectedWorldTable,x
	CMP.w !RAM_SMAS_GameSelect_MaxWorldTable,x
else
	LDA.b !RAM_SMAS_GameSelect_SelectedWorldTable,x
	CMP.b !RAM_SMAS_GameSelect_MaxWorldTable,x
endif
	BEQ.b CODE_00A410
	BCC.b CODE_00A40C
	LDA.b #$01
CODE_00A40C:
	STA.b !RAM_SMAS_GameSelect_SelectedWorldTable,x
	BRA.b CODE_00A420

CODE_00A410:
	STA.b !RAM_SMAS_GameSelect_SelectedWorldTable,x
	LDA.b #$01
	STA.b !RAM_SMAS_GameSelect_SelectedLevelTable,x
	LDA.w !RAM_SMAS_GameSelect_CursorPosIndex
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	AND.b #$03
endif
	CMP.b #$01
	BNE.b CODE_00A420
	JSR.w SMAS_UpdateStartingAreaDisplay_Level
CODE_00A420:
	JSR.w SMAS_UpdateStartingAreaDisplay_World
	JMP.w CODE_00A51F

CODE_00A426:
	LDA.b !RAM_SMAS_GameSelect_SelectedWorldTable,x
	CMP.b #$02
	BCS.b CODE_00A430
	LDA.b #!Define_SMAS_Sound0063_Wrong
	STA.b !RAM_SMAS_Global_SoundCh3
CODE_00A430:
	LDA.b !RAM_SMAS_GameSelect_CurrentlyOpenedFileSelectWindow
	BNE.b CODE_00A43A
	LDA.l !SRAM_SMAS_GameSelect_CanSelectHardModeWorldTable,x
	BNE.b CODE_00A443
CODE_00A43A:
	LDA.b !RAM_SMAS_GameSelect_MaxWorldTable,x
	CMP.b #$01
	BNE.b CODE_00A443
	JMP.w CODE_00A51F

CODE_00A443:
	LDA.b #!Define_SMAS_Sound0063_FinishAddTimerToScore
	STA.b !RAM_SMAS_Global_SoundCh3
	DEC.b !RAM_SMAS_GameSelect_SelectedWorldTable,x
	LDA.b !RAM_SMAS_GameSelect_CurrentlyOpenedFileSelectWindow
	BNE.b CODE_00A469
	LDA.l !SRAM_SMAS_GameSelect_CanSelectHardModeWorldTable,x
	BEQ.b CODE_00A469
	LDA.b !RAM_SMAS_GameSelect_SelectedWorldTable,x
	BNE.b CODE_00A469
	LDA.b !RAM_SMAS_GameSelect_HardModeWorldSelectedTable,x
	BNE.b CODE_00A463
	LDA.l !SRAM_SMAS_GameSelect_CanSelectHardModeWorldTable,x
	STA.b !RAM_SMAS_GameSelect_HardModeWorldSelectedTable,x
	BRA.b CODE_00A469

CODE_00A463:
	STZ.b !RAM_SMAS_GameSelect_HardModeWorldSelectedTable,x
	LDA.b #$08
	STA.b !RAM_SMAS_GameSelect_SelectedWorldTable,x
CODE_00A469:
	LDA.b !RAM_SMAS_GameSelect_SelectedWorldTable,x
	BNE.b CODE_00A471
	LDA.b !RAM_SMAS_GameSelect_MaxWorldTable,x
	STA.b !RAM_SMAS_GameSelect_SelectedWorldTable,x
CODE_00A471:
	JSR.w SMAS_UpdateStartingAreaDisplay_World
	JMP.w CODE_00A51F

CODE_00A477:
	LDA.b !RAM_SMAS_Global_ControllerPress1CopyP1
	ORA.b !RAM_SMAS_Global_ControllerPress1CopyP2
	AND.b #(!Joypad_DPadL>>8)|(!Joypad_DPadR>>8)|(!Joypad_B>>8)
	BNE.b CODE_00A482
	JMP.w CODE_00A51F

CODE_00A482:
	LDA.b !RAM_SMAS_GameSelect_MaxWorldTable,x
	CMP.b #$01
	BEQ.b CODE_00A48A
	BRA.b CODE_00A494

CODE_00A48A:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.w !RAM_SMAS_GameSelect_MaxLevelTable,x
else
	LDA.b !RAM_SMAS_GameSelect_MaxLevelTable,x
endif
	CMP.b #$01
	BNE.b CODE_00A494
	LDA.b #!Define_SMAS_Sound0063_Wrong
	BRA.b CODE_00A496

CODE_00A494:
	LDA.b #!Define_SMAS_Sound0063_FinishAddTimerToScore
CODE_00A496:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	STA.w !RAM_SMAS_Global_SoundCh3
else
	STA.b !RAM_SMAS_Global_SoundCh3
endif
	LDA.b !RAM_SMAS_Global_ControllerPress1CopyP1			;\ Note: !Joypad_B
	ORA.b !RAM_SMAS_Global_ControllerPress1CopyP2			;|
	BMI.b CODE_00A4D9						;/
	AND.b #!Joypad_DPadR>>8
	BNE.b CODE_00A4D9
	LDA.b !RAM_SMAS_GameSelect_SelectedWorldTable,x
	CMP.b !RAM_SMAS_GameSelect_MaxWorldTable,x
	BNE.b CODE_00A4B6
	DEC.b !RAM_SMAS_GameSelect_SelectedLevelTable,x
	BNE.b CODE_00A4B4
	DEC.b !RAM_SMAS_GameSelect_SelectedWorldTable,x
	BEQ.b CODE_00A4C2
	LDA.b #$04
	STA.b !RAM_SMAS_GameSelect_SelectedLevelTable,x
CODE_00A4B4:
	BRA.b CODE_00A4CA

CODE_00A4B6:
	DEC.b !RAM_SMAS_GameSelect_SelectedLevelTable,x
	BNE.b CODE_00A4CA
	LDA.b #$04
	STA.b !RAM_SMAS_GameSelect_SelectedLevelTable,x
	DEC.b !RAM_SMAS_GameSelect_SelectedWorldTable,x
	BNE.b CODE_00A4CA
CODE_00A4C2:
	LDA.b !RAM_SMAS_GameSelect_MaxWorldTable,x
	STA.b !RAM_SMAS_GameSelect_SelectedWorldTable,x
	LDA.b !RAM_SMAS_GameSelect_MaxLevelTable,x
	STA.b !RAM_SMAS_GameSelect_SelectedLevelTable,x
CODE_00A4CA:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.w !RAM_SMAS_GameSelect_NoWorld9Table,x
else
	LDA.b !RAM_SMAS_GameSelect_NoWorld9Table,x
endif
	BEQ.b CODE_00A4D6
	LDA.b !RAM_SMAS_GameSelect_SelectedWorldTable,x
	CMP.b #$09
	BNE.b CODE_00A4D6
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	DEC.w !RAM_SMAS_GameSelect_SelectedWorldTable,x
else
	DEC.b !RAM_SMAS_GameSelect_SelectedWorldTable,x
endif
CODE_00A4D6:
	JMP.w CODE_00A519

CODE_00A4D9:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	INC.w !RAM_SMAS_GameSelect_SelectedLevelTable,x
else
	INC.b !RAM_SMAS_GameSelect_SelectedLevelTable,x
endif
	LDA.b !RAM_SMAS_GameSelect_SelectedWorldTable,x
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	CMP.w !RAM_SMAS_GameSelect_MaxWorldTable,x
else
	CMP.b !RAM_SMAS_GameSelect_MaxWorldTable,x
endif
	BEQ.b CODE_00A4F3
	LDA.b !RAM_SMAS_GameSelect_SelectedLevelTable,x
	CMP.b #$05
	BCC.b CODE_00A50B
	INC.b !RAM_SMAS_GameSelect_SelectedWorldTable,x
	LDA.b !RAM_SMAS_GameSelect_SelectedWorldTable,x
	CMP.b !RAM_SMAS_GameSelect_MaxWorldTable,x
	BEQ.b CODE_00A509
	BCC.b CODE_00A509
	BRA.b CODE_00A505

CODE_00A4F3:
	LDA.b !RAM_SMAS_GameSelect_SelectedLevelTable,x
	CMP.b !RAM_SMAS_GameSelect_MaxLevelTable,x
	BEQ.b CODE_00A50B
	BCC.b CODE_00A50B
	INC.b !RAM_SMAS_GameSelect_SelectedWorldTable,x
	LDA.b !RAM_SMAS_GameSelect_SelectedWorldTable,x
	CMP.b !RAM_SMAS_GameSelect_MaxWorldTable,x
	BEQ.b CODE_00A50B
	BCC.b CODE_00A50B
CODE_00A505:
	LDA.b #$01
	STA.b !RAM_SMAS_GameSelect_SelectedWorldTable,x
CODE_00A509:
	LDA.b #$01
CODE_00A50B:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	STA.w !RAM_SMAS_GameSelect_SelectedLevelTable,x
	LDA.w !RAM_SMAS_GameSelect_NoWorld9Table,x
else
	STA.b !RAM_SMAS_GameSelect_SelectedLevelTable,x
	LDA.b !RAM_SMAS_GameSelect_NoWorld9Table,x
endif
	BEQ.b CODE_00A519
	LDA.b !RAM_SMAS_GameSelect_SelectedWorldTable,x
	CMP.b #$09
	BNE.b CODE_00A519
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	INC.w !RAM_SMAS_GameSelect_SelectedWorldTable,x
else
	INC.b !RAM_SMAS_GameSelect_SelectedWorldTable,x
endif
CODE_00A519:
	JSR.w SMAS_UpdateStartingAreaDisplay_World
	JSR.w SMAS_UpdateStartingAreaDisplay_Level
CODE_00A51F:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.b #$00
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.b !RAM_SMAS_Global_ScratchRAM0F
	STA.b !RAM_SMAS_Global_ScratchRAM01
	LDA.b !RAM_SMAS_GameSelect_CurrentlySelectedSaveFile
	ASL
	ASL
	ORA.b !RAM_SMAS_GameSelect_CurrentlyOpenedFileSelectWindow
	STA.b !RAM_SMAS_Global_ScratchRAM0C
	TAX
	STZ.b !RAM_SMAS_Global_ScratchRAM0D
	ASL
	TAY
	LDA.w DATA_00A367,y
	STA.b !RAM_SMAS_Global_ScratchRAM02
	LDA.w DATA_00A367+$01,y
	STA.b !RAM_SMAS_Global_ScratchRAM03
	LDA.b !RAM_SMAS_GameSelect_SelectedWorldTable,x
	STA.b !RAM_SMAS_Global_ScratchRAM04
	STZ.b !RAM_SMAS_Global_ScratchRAM05
	LDA.b !RAM_SMAS_GameSelect_SelectedLevelTable,x
	STA.b !RAM_SMAS_Global_ScratchRAM06
	STZ.b !RAM_SMAS_Global_ScratchRAM07
	STX.b !RAM_SMAS_GameSelect_UnknownRAM000029
	LDX.b !RAM_SMAS_GameSelect_UnknownRAM000029
endif
	LDA.b !RAM_SMAS_Global_ControllerPress2CopyP1
	ORA.b !RAM_SMAS_Global_ControllerPress2CopyP2
	AND.b #!Joypad_A
	BNE.b CODE_00A552
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDX.b !RAM_SMAS_Global_ScratchRAM0C
endif
CODE_00A527:
	LDA.b !RAM_SMAS_Global_ControllerPress1CopyP1
	ORA.b !RAM_SMAS_Global_ControllerPress1CopyP2
	AND.b #!Joypad_Start>>8
	BEQ.b CODE_00A576
	LDA.b #!Define_SMAS_Sound0063_Correct
	STA.b !RAM_SMAS_Global_SoundCh3
	STA.w !RAM_SMAS_GameSelect_SelectedAFileFlag
	LDA.b #$10
	STA.w !RAM_SMAS_GameSelect_WaitAfterSelectingFileTimer
	LDA.b #$70
	STA.w !RAM_SMAS_Global_BG2AddressAndSize
	LDA.b #$50
	STA.w !RAM_SMAS_Global_BG1And2TileDataDesignation
	STZ.b !RAM_SMAS_TitleScreen_TriangleTransitionEffectIndexLo
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	BRA.b CODE_00A577
else
if !Define_Global_SMASGames&(!SMASGames_SMW) != $00
	LDA.b !RAM_SMAS_GameSelect_CurrentlyOpenedFileSelectWindow
	CMP.b #$04
	BNE.b CODE_00A577
	JSR.w SMAS_MakeFileSelectYoshiBlink_Main
	BRA.b CODE_00A576
else
	BRA.b CODE_00A577
endif
endif

CODE_00A552:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
if !Define_Global_SMASGames&(!SMASGames_SMW) != $00
	LDA.b !RAM_SMAS_GameSelect_CurrentlyOpenedFileSelectWindow
	CMP.b #$04
	BNE.b CODE_00A56B
	LDA.b !RAM_SMAS_GameSelect_CurrentlySelectedSaveFile
	ASL
	TAY
	REP.b #$10
	LDX.w SMAS_FileSelectMenuData_DATA_00B70C,y
	LDA.l !SRAM_SMW_MarioB_StartLocation-$02,x
	BNE.b CODE_00A56B
	LDA.b #!Define_SMAS_Sound0063_Wrong
	BRA.b CODE_00A572
endif
endif

CODE_00A56B:
	STZ.w !RAM_SMAS_GameSelect_SelectedAFileFlag
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.b #$04
	STA.b !RAM_SMAS_GameSelect_CanDisplayEraseFileMenuFlag
endif
	INC.b !RAM_SMAS_Global_GameMode
	LDA.b #!Define_SMAS_Sound0063_MessageBox
CODE_00A572:
	STA.b !RAM_SMAS_Global_SoundCh3
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
	SEP.b #$10
endif
CODE_00A576:
	RTL

CODE_00A577:
	LDA.b !RAM_SMAS_GameSelect_CurrentlySelectedSaveFile
	ASL
	ASL
	ADC.b !RAM_SMAS_GameSelect_CurrentlyOpenedFileSelectWindow
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	TAX
endif
	LDA.b !RAM_SMAS_GameSelect_SelectedWorldTable,x
	INC
	BNE.b CODE_00A59C
	LDA.b #$00
	STA.l !SRAM_SMAS_Global_InitialSelectedWorld
	STA.l !SRAM_SMAS_Global_InitialSelectedLevel
	LDA.b !RAM_SMAS_GameSelect_CanDisplayEraseFileMenuFlag
	CMP.b #$04
	BNE.b CODE_00A5B2
	LDA.b #!Define_SMAS_Sound0063_Wrong
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	STA.w !RAM_SMAS_Global_SoundCh3
else
	STA.b !RAM_SMAS_Global_SoundCh3
endif
	DEC.b !RAM_SMAS_Global_GameMode
	STZ.b !RAM_SMAS_GameSelect_CanDisplayEraseFileMenuFlag
	BRA.b CODE_00A5B2

CODE_00A59C:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.b !RAM_SMAS_GameSelect_CanDisplayEraseFileMenuFlag
	CMP.b #$04
	BNE.b +
	LDA.b #!Define_SMAS_Sound0063_MessageBox
	STA.w !RAM_SMAS_Global_SoundCh3
	LDA.b #$40
	STA.w !RAM_SMAS_Global_ColorMathInitialSettings
+:
endif
	LDA.b !RAM_SMAS_GameSelect_SelectedWorldTable,x
	DEC
	BPL.b CODE_00A5A3
	LDA.b #$00
CODE_00A5A3:
	STA.l !SRAM_SMAS_Global_InitialSelectedWorld
	LDA.b !RAM_SMAS_GameSelect_SelectedLevelTable,x
	DEC
	BPL.b CODE_00A5AE
	LDA.b #$00
CODE_00A5AE:
	STA.l !SRAM_SMAS_Global_InitialSelectedLevel
CODE_00A5B2:
	LDA.b !RAM_SMAS_GameSelect_CurrentlySelectedSaveFile
	ASL
	ASL
	CLC
	ADC.b !RAM_SMAS_GameSelect_CurrentlyOpenedFileSelectWindow
	ASL
	TAX
	LDA.w SMAS_SaveFileLocations_Main,x
	STA.l !SRAM_SMAS_Global_SaveFileIndexLo
	LDA.w SMAS_SaveFileLocations_Main+$01,x
	STA.l !SRAM_SMAS_Global_SaveFileIndexHi
	RTL

if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
label_00A7D6:
	LDA.b !RAM_SMAS_Global_ControllerPress1CopyP1
	ORA.b !RAM_SMAS_Global_ControllerPress1CopyP2
	AND.b #!Joypad_Start>>8
	BEQ.b label_00A7E0
	INC.b !RAM_SMAS_Global_GameMode
label_00A7E0:
	LDA.b #$00
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.b !RAM_SMAS_Global_ScratchRAM0F
	STA.b !RAM_SMAS_Global_ScratchRAM01
	LDA.b !RAM_SMAS_GameSelect_CurrentlySelectedSaveFile
	ASL
	ASL
	ORA.b !RAM_SMAS_GameSelect_CurrentlyOpenedFileSelectWindow
	STA.b !RAM_SMAS_Global_ScratchRAM0C
	TAX
	STZ.b !RAM_SMAS_Global_ScratchRAM0D
	ASL
	TAY
	LDA.w DATA_00A367,y
	STA.b !RAM_SMAS_Global_ScratchRAM02
	LDA.w DATA_00A367+$01,y
	STA.b !RAM_SMAS_Global_ScratchRAM03
	LDA.b !RAM_SMAS_GameSelect_SelectedWorldTable,x
	STA.b !RAM_SMAS_Global_ScratchRAM04
	STZ.b !RAM_SMAS_Global_ScratchRAM05
	LDA.b !RAM_SMAS_GameSelect_SelectedLevelTable,x
	STA.b !RAM_SMAS_Global_ScratchRAM06
	STZ.b !RAM_SMAS_Global_ScratchRAM07
	RTL
elseif !Define_Global_ROMToAssemble&(!ROM_SMASW_E) != $00
	RTL
	RTL
endif
namespace off
endmacro

macro ROUTINE_RT01_SMAS_GameMode02_GameSelectScreen(Address)
namespace SMAS_GameMode02_GameSelectScreen
%InsertMacroAtXPosition(<Address>)

DATA_00A664:
	dw SMAS_DisplaySMB1FileSelectWindow_Main
	dw SMAS_DisplaySMBLLFileSelectWindow_Main
	dw SMAS_DisplaySMB2UFileSelectWindow_Main
	dw SMAS_DisplaySMB3FileSelectWindow_Main
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
if !Define_Global_SMASGames&(!SMASGames_SMW) != $00
	dw SMAS_DisplaySMWFileSelectWindow_Main
else
	NOP #2
endif
endif
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_ClearSaveData(Address)
namespace SMAS_ClearSaveData
%InsertMacroAtXPosition(<Address>)

Main:
	LDA.b !RAM_SMAS_GameSelect_CurrentlySelectedSaveFile
	ASL
	ASL
	CLC
	ADC.b !RAM_SMAS_GameSelect_CurrentlyOpenedFileSelectWindow
	ASL
	TAX
	REP.b #$20
	LDA.w SMAS_SaveFileLocations_Main,x
	REP.b #$10
	TAX
	LDA.w #$FFFF
	STA.l !SRAM_SMAS_Global_SaveFileBaseOffset,x
	SEP.b #$30
	JMP.w SMAS_VerifySaveDataIsValid_Main
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_StoreDataToSaveFileAndUpdateTempChecksum(Address)
namespace SMAS_StoreDataToSaveFileAndUpdateTempChecksum
%InsertMacroAtXPosition(<Address>)

Main:
CODE_0092B4:
	STA.l !SRAM_SMAS_Global_SaveFileBaseOffset,x
	INX
	CLC
	ADC.b !RAM_SMAS_Global_ScratchRAM00
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.b !RAM_SMAS_Global_ScratchRAM01
	ADC.b #$00
	STA.b !RAM_SMAS_Global_ScratchRAM01
	RTS
namespace off
	%SetDuplicateOrNullPointer(SMAS_StoreDataToSaveFileAndUpdateTempChecksum_Main, SMB1_StoreDataToSaveFileAndUpdateTempChecksum_Main)
	%SetDuplicateOrNullPointer(SMAS_StoreDataToSaveFileAndUpdateTempChecksum_Main, SMBLL_StoreDataToSaveFileAndUpdateTempChecksum_Main)
	%SetDuplicateOrNullPointer(SMAS_StoreDataToSaveFileAndUpdateTempChecksum_Main, SMB2U_StoreDataToSaveFileAndUpdateTempChecksum_Main)
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_GameMode06_FadeOutAfterGameSelect(Address)
namespace SMAS_GameMode06_FadeOutAfterGameSelect
%InsertMacroAtXPosition(<Address>)

Main:
	DEC.w !RAM_SMAS_Global_ScreenDisplayRegister
	BNE.b CODE_00A105
	INC.b !RAM_SMAS_Global_GameMode
	STZ.b !RAM_SMAS_GameSelect_UnknownRAM0000E1
	STZ.b !RAM_SMAS_TitleScreen_TriangleTransitionEffectIndexLo
	LDA.b #!ScreenDisplayRegister_SetForceBlank|!ScreenDisplayRegister_MinBrightness00
	STA.w !RAM_SMAS_Global_ScreenDisplayRegister
CODE_00A105:
	SEP.b #$20
	RTL
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_InitializeFileSelectMenuWindowBuffer(Address)
namespace SMAS_InitializeFileSelectMenuWindowBuffer
%InsertMacroAtXPosition(<Address>)

Main:
	REP.b #$20
	LDX.b #$80
	LDA.w #$02FF
CODE_00A675:
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer,x
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$80,x
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$0100,x
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$0180,x
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$0200,x
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$0280,x
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$0300,x
	DEX
	DEX
	BPL.b CODE_00A675
	LDY.b !RAM_SMAS_GameSelect_CurrentlySelectedSaveFile
	LDX.w DATA_00A81B,y
	LDA.w #$034F
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$DA,x
	LDX.b #$00
CODE_00A69B:
	LDA.w BlankFileText,x
	CMP.w #$FFFF
	BEQ.b CODE_00A6B3
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$DC,x
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$0130,x
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$0184,x
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$01D8,x
	INX
	INX
	BRA.b CODE_00A69B

CODE_00A6B3:
	LDX.b #$00
	LDA.w #$0360
CODE_00A6B8:
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$BE,x
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$0112,x
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$0166,x
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$01BA,x
	INC
	INX
	INX
	CPX.b #$08
	BNE.b CODE_00A6B8
	REP.b #$10
	LDX.w #$0000
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.w #$02F5
else
	LDA.w #$025A
endif
	STA.b !RAM_SMAS_Global_ScratchRAM00
CODE_00A6D5:
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$B8,x
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	INC.b !RAM_SMAS_Global_ScratchRAM00
else
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	CLC
	ADC.w #$0010
	STA.b !RAM_SMAS_Global_ScratchRAM00
endif
	TXA
	CLC
	ADC.w #$002A
	TAX
	CPX.w #$0150
	BNE.b CODE_00A6D5
	SEP.b #$10
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E) != $00
	LDA.w #$0080
	STA.w !RAM_SMAS_GameSelect_YoshiAnimationTimer
else
	LDX.b #$80
	STX.w !RAM_SMAS_GameSelect_YoshiAnimationTimer
endif
	LDA.w #SMAS_FileSelectGFX_Main_Controller
	STA.w !RAM_SMAS_GameSelect_FileSelectGFXPrtLo
	LDX.b #$01
	STX.w !RAM_SMAS_GameSelect_UploadFileSelectGFXFlag
if !Define_Global_SMASGames&(!SMASGames_SMW) != $00
	LDA.w !RAM_SMAS_GameSelect_CursorPosIndex
	AND.w #$0004
	BEQ.b CODE_00A70D
	JSR.w CODE_00A795
	JMP.w CODE_00A792
endif
endif

CODE_00A70D:
	LDX.b #$00
	LDA.w #$038B
CODE_00A712:
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$0222,x
	INC
	INX
	INX
	CPX.b #$14
	BNE.b CODE_00A712
	LDX.b #$00
CODE_00A71E:
	LDA.w FileSelectControllerIconTiles_TopRow,x
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$027C,x
	LDA.w FileSelectControllerIconTiles_UpperMiddleTiles,x
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$02A6,x
	LDA.w FileSelectControllerIconTiles_LowerMiddleTiles,x
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$02D0,x
	LDA.w FileSelectControllerIconTiles_BottomTiles,x
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$02FA,x
	INX
	INX
	CPX.b #$08
	BNE.b CODE_00A71E
	LDA.w #$0368
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #$0378
	STA.b !RAM_SMAS_Global_ScratchRAM02
	LDX.b #$00
CODE_00A748:
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$0284,x
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$02CA,x
	LDA.b !RAM_SMAS_Global_ScratchRAM02
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$02AE,x
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$0302,x
	INC.b !RAM_SMAS_Global_ScratchRAM00
	INC.b !RAM_SMAS_Global_ScratchRAM02
	INX
	INX
	CPX.b #$06
	BNE.b CODE_00A748
	LDA.w #$0380
	LDX.b #$00
CODE_00A767:
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$0322,x
	INC
	INX
	INX
	CPX.b #$0C
	BNE.b CODE_00A767
	LDA.l !SRAM_SMAS_Global_ControllerTypeX
	AND.w #$00FF
	BEQ.b CODE_00A792
	LDA.w #$0368
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$0302
	INC
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$0304
	INC
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$0306
	LDA.w #$0386
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$032A
	INC
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$032C
CODE_00A792:
	SEP.b #$20
	RTS

if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
if !Define_Global_SMASGames&(!SMASGames_SMW) != $00
CODE_00A795:
	STZ.w !RAM_SMAS_Global_YoshiAnimationIndex
	LDA.w #SMAS_FileSelectGFX_Main_Yoshi
	STA.w !RAM_SMAS_GameSelect_FileSelectGFXPrtLo
	LDX.b #$00
CODE_00A7A0:
	LDA.w FileSelectYoshiIconTiles_TopRow,x
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$0250,x
	LDA.w FileSelectYoshiIconTiles_UpperMiddleRow,x
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$027A,x
	LDA.w FileSelectYoshiIconTiles_MiddleRow,x
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$02A4,x
	LDA.w FileSelectYoshiIconTiles_LowerMiddleRow,x
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$02CE,x
	LDA.w FileSelectYoshiIconTiles_BottomRow,x
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$02F8,x
	LDA.w FileSelectYoshiText,x
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$0322,x
	INX
	INX
	CPX.b #$0C
	BNE.b CODE_00A7A0
	RTS
endif
endif

BlankFileText:				;\ Info: "FILE   NEW"
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	dw $02F2,$02F3,$02F4,$0351	;|
	dw $0351,$0351,$0370,$0371	;|
	dw $0372,$0373,$FFFF		;|
else					;|
	dw $022A,$023A,$024A,$02B0	;|
	dw $02B0,$02B0,$0370,$0371	;|
	dw $0372,$0373,$FFFF		;/
endif

FileSelectControllerIconTiles:
.TopRow:
	dw $0364,$0365,$0366,$0367

.UpperMiddleTiles:
	dw $0374,$0375,$0376,$0377

.LowerMiddleTiles:
	dw $036B,$036C,$036D,$036E

.BottomTiles:
	dw $037B,$037C,$037D,$037E

UNK_00A801:
	dw $FFFF,$0383,$0395,$0396
	dw $0397,$0383,$02FF,$0398
	dw $0399,$039A,$0383,$02FF
	dw $035F

DATA_00A81B:
	dw $5400,$FCA8

if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
if !Define_Global_SMASGames&(!SMASGames_SMW) != $00
FileSelectYoshiIconTiles:
.TopRow:
	dw $02FF,$0364,$0365,$0366
	dw $0367,$02FF

.UpperMiddleRow:
	dw $036A,$0374,$0375,$0376
	dw $0377,$436A

.MiddleRow:
	dw $037A,$0384,$0385,$0386
	dw $0387,$0378

.LowerMiddleRow:
	dw $0379,$036B,$036C,$036D
	dw $036E,$4379

.BottomRow:
	dw $02FF,$037B,$037C,$037D
	dw $037E,$02FF

FileSelectYoshiText:
	dw $038F,$0390,$0391,$0392
	dw $0393,$0394
endif
endif
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_BufferFileSelectWindow(Address)
namespace SMAS_BufferFileSelectWindow
%InsertMacroAtXPosition(<Address>)

SMB1:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
SMB2U:
endif
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
SMB3:
endif
	LDA.l !RAM_SMAS_Global_StripeImageUploadIndexLo
	TAX
	REP.b #$30
	LDA.w #$0015
	STA.b !RAM_SMAS_Global_ScratchRAM04
	LDA.w !RAM_SMAS_GameSelect_CurrentFileSelectMenuVRAMAddressLo
	XBA
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	INX
	INX
	LDA.w #$002A
	XBA
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	INX
	INX
CODE_00AEF3:
	LDY.w !RAM_SMAS_GameSelect_FileSelectWindowBufferIndexLo
	LDA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer,y
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	INX
	INX
	INC.w !RAM_SMAS_GameSelect_FileSelectWindowBufferIndexLo
	INC.w !RAM_SMAS_GameSelect_FileSelectWindowBufferIndexLo
	DEC.b !RAM_SMAS_Global_ScratchRAM04
	BNE.b CODE_00AEF3
	LDA.w !RAM_SMAS_GameSelect_CurrentFileSelectMenuVRAMAddressLo
	CLC
	ADC.w #$0020
	STA.w !RAM_SMAS_GameSelect_CurrentFileSelectMenuVRAMAddressLo
	LDA.w #$FFFF
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	TXA
	STA.l !RAM_SMAS_Global_StripeImageUploadIndexLo
	SEP.b #$30
	DEC.w !RAM_SMAS_GameSelect_FileSelectTransitionTimer
	RTS

SMBLL:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
SMB2U:
endif
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
SMB3:
endif
SMW:
	LDA.l !RAM_SMAS_Global_StripeImageUploadIndexLo
	TAX
	REP.b #$30
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.b !RAM_SMAS_Global_ScratchRAM02
	LDA.w !RAM_SMAS_GameSelect_CurrentFileSelectMenuVRAMAddressLo
	XBA
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	INX
	INX
	LDA.b !RAM_SMAS_Global_ScratchRAM04
	XBA
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	INX
	INX
CODE_00AF43:
	LDY.w !RAM_SMAS_GameSelect_FileSelectWindowBufferIndexLo
	LDA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer,y
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	INX
	INX
	INC.w !RAM_SMAS_GameSelect_FileSelectWindowBufferIndexLo
	INC.w !RAM_SMAS_GameSelect_FileSelectWindowBufferIndexLo
	DEC.b !RAM_SMAS_Global_ScratchRAM00
	BNE.b CODE_00AF43
	LDA.w !RAM_SMAS_GameSelect_CurrentFileSelectMenuVRAMAddressLo
	AND.w #$7FE0
	EOR.w #$0400
	XBA
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	INX
	INX
	LDA.b !RAM_SMAS_Global_ScratchRAM06
	XBA
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	INX
	INX
CODE_00AF72:
	LDY.w !RAM_SMAS_GameSelect_FileSelectWindowBufferIndexLo
	LDA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer,y
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	INX
	INX
	INC.w !RAM_SMAS_GameSelect_FileSelectWindowBufferIndexLo
	INC.w !RAM_SMAS_GameSelect_FileSelectWindowBufferIndexLo
	DEC.b !RAM_SMAS_Global_ScratchRAM02
	BNE.b CODE_00AF72
	LDA.w !RAM_SMAS_GameSelect_CurrentFileSelectMenuVRAMAddressLo
	CLC
	ADC.w #$0020
	STA.w !RAM_SMAS_GameSelect_CurrentFileSelectMenuVRAMAddressLo
	LDA.w #$FFFF
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	TXA
	STA.l !RAM_SMAS_Global_StripeImageUploadIndexLo
	SEP.b #$30
	DEC.w !RAM_SMAS_GameSelect_FileSelectTransitionTimer
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_ClearFileSelectWindow(Address)
namespace SMAS_ClearFileSelectWindow
%InsertMacroAtXPosition(<Address>)

SMB1:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
SMB2U:
endif
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
SMB3:
endif
	LDA.l !RAM_SMAS_Global_StripeImageUploadIndexLo
	TAX
	REP.b #$30
	LDA.w #$0015
	STA.b !RAM_SMAS_Global_ScratchRAM04
	LDA.w !RAM_SMAS_GameSelect_CurrentFileSelectMenuVRAMAddressLo
	XBA
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	INX
	INX
	LDA.w #$002A
	XBA
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	INX
	INX
	SEP.b #$20
	PHB
	LDA.b #!RAM_SMAS_GameSelect_TilemapBuffer>>16
	PHA
	PLB
	REP.b #$20
	LDA.l !RAM_SMAS_GameSelect_TilemapBufferIndexLo
	TAY
CODE_00AFD2:
	LDA.w !RAM_SMAS_GameSelect_TilemapBuffer,y
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	INX
	INX
	INY
	INY
	DEC.b !RAM_SMAS_Global_ScratchRAM04
	BNE.b CODE_00AFD2
	SEP.b #$20
	PLB
	REP.b #$20
	LDA.w !RAM_SMAS_GameSelect_CurrentFileSelectMenuVRAMAddressLo
	SEC
	SBC.w #$0020
	STA.w !RAM_SMAS_GameSelect_CurrentFileSelectMenuVRAMAddressLo
	LDA.w !RAM_SMAS_GameSelect_TilemapBufferIndexLo
	SEC
	SBC.w #$0040
	STA.w !RAM_SMAS_GameSelect_TilemapBufferIndexLo
	LDA.w #$FFFF
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	TXA
	STA.l !RAM_SMAS_Global_StripeImageUploadIndexLo
	SEP.b #$30
	DEC.w !RAM_SMAS_GameSelect_FileSelectTransitionTimer
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
	LDA.w !RAM_SMAS_GameSelect_FileSelectTransitionTimer
endif
	BNE.b CODE_00B016
	STZ.w !RAM_SMAS_GameSelect_ActiveFileSelectTransitionFlag
	STZ.w !RAM_SMAS_GameSelect_FileSelectMenuActiveFlag
CODE_00B016:
	RTS

;--------------------------------------------------------------------

SMBLL:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
SMB2U:
endif
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
SMB3:
endif
SMW:
	LDA.l !RAM_SMAS_Global_StripeImageUploadIndexLo
	TAX
	REP.b #$30
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.b !RAM_SMAS_Global_ScratchRAM02
	LDA.w !RAM_SMAS_GameSelect_CurrentFileSelectMenuVRAMAddressLo
	XBA
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	INX
	INX
	LDA.b !RAM_SMAS_Global_ScratchRAM04
	XBA
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	INX
	INX
	SEP.b #$20
	PHB
	LDA.b #!RAM_SMAS_GameSelect_TilemapBuffer>>16
	PHA
	PLB
	REP.b #$20
	LDA.l !RAM_SMAS_GameSelect_TilemapBufferIndexLo
	TAY
CODE_00B043:
	LDA.w !RAM_SMAS_GameSelect_TilemapBuffer,y
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	INX
	INX
	INY
	INY
	DEC.b !RAM_SMAS_Global_ScratchRAM00
	BNE.b CODE_00B043
	SEP.b #$20
	PLB
	REP.b #$20
	LDA.w !RAM_SMAS_GameSelect_CurrentFileSelectMenuVRAMAddressLo
	AND.w #$7FE0
	EOR.w #$0400
	XBA
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	INX
	INX
	LDA.b !RAM_SMAS_Global_ScratchRAM06
	XBA
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	INX
	INX
	SEP.b #$20
	PHB
	LDA.b #!RAM_SMAS_GameSelect_TilemapBuffer>>16
	PHA
	PLB
	REP.b #$20
	TYA
	CLC
	ADC.w #$07C0
	AND.w #$0FFF
	TAY
CODE_00B082:
	LDA.w !RAM_SMAS_GameSelect_TilemapBuffer,y
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	INX
	INX
	INY
	INY
	DEC.b !RAM_SMAS_Global_ScratchRAM02
	BNE.b CODE_00B082
	SEP.b #$20
	PLB
	REP.b #$20
	LDA.w !RAM_SMAS_GameSelect_CurrentFileSelectMenuVRAMAddressLo
	SEC
	SBC.w #$0020
	STA.w !RAM_SMAS_GameSelect_CurrentFileSelectMenuVRAMAddressLo
	LDA.w !RAM_SMAS_GameSelect_TilemapBufferIndexLo
	SEC
	SBC.w #$0040
	STA.w !RAM_SMAS_GameSelect_TilemapBufferIndexLo
	LDA.w #$FFFF
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	TXA
	STA.l !RAM_SMAS_Global_StripeImageUploadIndexLo
	SEP.b #$30
	DEC.w !RAM_SMAS_GameSelect_FileSelectTransitionTimer
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
	LDA.w !RAM_SMAS_GameSelect_FileSelectTransitionTimer
endif
	BNE.b CODE_00B0C6
	STZ.w !RAM_SMAS_GameSelect_ActiveFileSelectTransitionFlag
	STZ.w !RAM_SMAS_GameSelect_FileSelectMenuActiveFlag
CODE_00B0C6:
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_GameMode01_InitializeGameSelectScreen(Address)
namespace SMAS_GameMode01_InitializeGameSelectScreen
%InsertMacroAtXPosition(<Address>)

Main:
	LDA.l !SRAM_SMAS_Global_CurrentSaveFile
	STA.b !RAM_SMAS_GameSelect_CurrentlySelectedSaveFile
	LDA.l !SRAM_SMAS_Global_LastPlayedGame
	STA.b !RAM_SMAS_GameSelect_CurrentlyOpenedFileSelectWindow
	STA.w !RAM_SMAS_GameSelect_CursorPosIndex
	LDX.b #$01
	JSL.l SMAS_InitializeCurrentGamemode_Main
	JSR.w SMAS_UploadMainSampleData_Main
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E) != $00
else
	LDA.b #!ScreenDisplayRegister_MaxBrightness0F
	STA.w !RAM_SMAS_Global_ScreenDisplayRegister
	INC.w !RAM_SMAS_Global_UpdateEntirePaletteFlag
endif
	INC.b !RAM_SMAS_Global_GameMode
	STZ.b !RAM_SMAS_GameSelect_UnknownRAM0000E1
	LDA.b #$44
	STA.b !RAM_SMAS_TitleScreen_TriangleTransitionEffectIndexLo
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E) != $00
	TAX
	LDA.l SMAS_TriangleTransitionEffectGFXPointers_Main,x
	STA.b !RAM_SMAS_Global_TriangleTransitionEffectPtrLo
endif
	STZ.b !RAM_SMAS_Global_FrameCounter
	JSR.w CODE_00A13C
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E) != $00
	JSL.l SMAS_GameMode02_GameSelectScreen_CODE_00A1A4
-:
	LDA.w !REGISTER_HVBlankFlagsAndJoypadStatus
	BPL.b -
	LDA.b #!ScreenDisplayRegister_MaxBrightness0F
	STA.w !RAM_SMAS_Global_ScreenDisplayRegister
	INC.w !RAM_SMAS_Global_UpdateEntirePaletteFlag
	LDA.b #!Define_SMAS_Sound0063_SMASMenuFadeIn
if !Define_Global_ROMToAssemble&(!ROM_SMAS_E) != $00
	STA.w !RAM_SMAS_Global_SoundCh3
else
	STA.b !RAM_SMAS_Global_SoundCh3
endif
	RTL
else
	LDA.b #!Define_SMAS_Sound0063_SMASMenuFadeIn
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	STA.w !RAM_SMAS_Global_SoundCh3
else
	STA.b !RAM_SMAS_Global_SoundCh3
endif
	JMP.w SMAS_GameMode02_GameSelectScreen_Main
endif
CODE_00A13C:
	REP.b #$10
	LDY.w #$0000
CODE_00A141:
	LDA.b #$00
	XBA
	PHY
	TYA
	ASL
	TAY
	LDX.w SMAS_SaveFileLocations_Main,y
	PLY
	LDA.l !SRAM_SMAS_Global_SaveFileBaseOffset,x
	BMI.b CODE_00A153
	INC
CODE_00A153:
	STA.w !RAM_SMAS_GameSelect_MaxWorldTable,y
	STA.w !RAM_SMAS_GameSelect_SelectedWorldTable,y
	LDA.l !SRAM_SMAS_Global_SaveFileBaseOffset+$01,x
	BMI.b CODE_00A160
	INC
CODE_00A160:
	STA.b !RAM_SMAS_Global_ScratchRAM00
	TYA
	AND.b #$01
	BEQ.b CODE_00A170
	TYA
	AND.b #$02
	BNE.b CODE_00A170
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	BRA.b CODE_00A172

CODE_00A170:
	LDA.b #$FF
CODE_00A172:
	STA.w !RAM_SMAS_GameSelect_MaxLevelTable,y
	STA.w !RAM_SMAS_GameSelect_SelectedLevelTable,y
	LDA.l !SRAM_SMAS_Global_SaveFileBaseOffset+$04,x
	STA.w !RAM_SMAS_GameSelect_NoWorld9Table,y
	LDA.l !SRAM_SMAS_Global_SaveFileBaseOffset+$05,x
	STA.w !RAM_SMAS_GameSelect_HardModeWorldSelectedTable,y
	PHX
	TYX
	STA.l !SRAM_SMAS_GameSelect_CanSelectHardModeWorldTable,x
	PLX
	INY
	CPY.w #$0010
	BCC.b CODE_00A141
	SEP.b #$10
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_UpdateControllerTypeDisplay(Address)
namespace SMAS_UpdateControllerTypeDisplay
%InsertMacroAtXPosition(<Address>)

Main:
	REP.b #$20
	LDA.l !RAM_SMAS_Global_StripeImageUploadIndexLo
	TAX
	LDA.w !RAM_SMAS_GameSelect_CursorPosIndex
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	AND.w #$0003
else
	AND.w #$0007
endif
	ASL
	TAY
	LDA.w DATA_00B138,y
	XBA
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	LDA.w #$0006
	XBA
	STA.l SMAS_Global_StripeImageUploadTable[$01].LowByte,x
	PHY
	LDA.l !SRAM_SMAS_Global_ControllerTypeX
	AND.w #$0001
	ASL
	TAY
	LDA.w DATA_00B148,y
	STA.l SMAS_Global_StripeImageUploadTable[$02].LowByte,x
	INC
	STA.l SMAS_Global_StripeImageUploadTable[$03].LowByte,x
	INC
	STA.l SMAS_Global_StripeImageUploadTable[$04].LowByte,x
	PLY
	TXA
	CLC
	ADC.w #$000A
	TAX
	LDA.w DATA_00B140,y
	XBA
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte,x
	LDA.w #$0004
	XBA
	STA.l SMAS_Global_StripeImageUploadTable[$01].LowByte,x
	LDA.l !SRAM_SMAS_Global_ControllerTypeX
	AND.w #$0001
	ASL
	ADC.w #$0384
	STA.l SMAS_Global_StripeImageUploadTable[$02].LowByte,x
	INC
	STA.l SMAS_Global_StripeImageUploadTable[$03].LowByte,x
	TXA
	CLC
	ADC.w #$0008
	STA.l !RAM_SMAS_Global_StripeImageUploadIndexLo
	SEP.b #$20
	RTS

DATA_00B138:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	dw $7B2C,$7B3B,$7F2B,$7F3C
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	dw $7B2C,$7B3C,$7F2A,$7F3A
else
	dw $7B2C,$7B38,$7F24,$7F30
endif

DATA_00B140:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	dw $7B4B,$7B5A,$7F4A,$7F5B
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	dw $7B4B,$7B5B,$7F49,$7F59
else
	dw $7B4B,$7B57,$7F43,$7F4F
endif

DATA_00B148:
	dw $0378,$0368
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_GameMode07_InitializeSelectedGame(Address)
namespace SMAS_GameMode07_InitializeSelectedGame
%InsertMacroAtXPosition(<Address>)

DATA_008A2D:
if !Define_Global_SMASGames&(!SMASGames_SMB1) != $00
	dw SMAS_UploadSMB1MusicBank_Main
else
	NOP #2
endif
if !Define_Global_SMASGames&(!SMASGames_SMBLL) != $00
	dw SMAS_UploadSMBLLMusicBank_Main
else
	NOP #2
endif
if !Define_Global_SMASGames&(!SMASGames_SMB2U) != $00
	dw SMAS_UploadSMB2UMusicBank_Main
else
	NOP #2
endif
if !Define_Global_SMASGames&(!SMASGames_SMB3) != $00
	dw SMAS_UploadSMB3LevelMusicBank_Main
else
	NOP #2
endif
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
if !Define_Global_SMASGames&(!SMASGames_SMW) != $00
	dw SMAS_UploadSMWSPCEngine_Main
else
	NOP #2
endif
endif

Main:
	SEI
	STZ.w !REGISTER_IRQNMIAndJoypadEnableFlags
	STZ.w !REGISTER_HDMAEnable
	STZ.w !REGISTER_APUPort0
	STZ.w !REGISTER_APUPort2
	STZ.w !REGISTER_APUPort3
	LDA.b #$FF
	STA.w !REGISTER_APUPort1
	LDA.b !RAM_SMAS_GameSelect_CurrentlyOpenedFileSelectWindow
	ASL
	TAX
	JSR.w (DATA_008A2D,x)
	REP.b #$20
	LDX.b #$02
	LDA.w #SMAS_BlankPalette_End-SMAS_BlankPalette_Main
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w SMAS_GameModeSettings_Palette,x
	LDY.b #$02							; Glitch: This should be referencing bank 3C!
	STA.b !RAM_SMAS_Global_ScratchRAM02
	STY.b !RAM_SMAS_Global_ScratchRAM04
	LDA.w #!RAM_SMAS_GameSelect_UnusedPaletteBuffer
	LDY.b #!RAM_SMAS_GameSelect_UnusedPaletteBuffer>>16
	JSL.l SMAS_DMADataBlockToRAM_Main
	LDA.w #!RAM_SMAS_Global_PaletteMirror
	LDY.b #!RAM_SMAS_Global_PaletteMirror>>16
	JSL.l SMAS_DMADataBlockToRAM_Main
	LDA.w #$0000
	STA.l !RAM_SMAS_Global_StripeImageUploadIndexLo
	DEC
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte
	SEP.b #$20
	LDA.b #$81
	STA.w !REGISTER_IRQNMIAndJoypadEnableFlags
	INC.b !RAM_SMAS_Global_GameMode
	RTL
namespace off
endmacro


;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_UploadSMB1MusicBank(Address)
namespace SMAS_UploadSMB1MusicBank
%InsertMacroAtXPosition(<Address>)

Main:
	LDA.b #SMB1MusicBank
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.b #SMB1MusicBank>>8
	STA.b !RAM_SMAS_Global_ScratchRAM01
	LDA.b #SMB1MusicBank>>16
	STA.b !RAM_SMAS_Global_ScratchRAM02
	JSR.w SMAS_HandleSPCUploads_Main
	RTS
namespace off
	%SetDuplicateOrNullPointer(SMAS_UploadSMB1MusicBank_Main, SMAS_UploadSMBLLMusicBank_Main)
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_UploadSMB2UMusicBank(Address)
namespace SMAS_UploadSMB2UMusicBank
%InsertMacroAtXPosition(<Address>)

Main:
	LDA.b #SMB2U_UploadMusicBank_MusicBank
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.b #SMB2U_UploadMusicBank_MusicBank>>8
	STA.b !RAM_SMAS_Global_ScratchRAM01
	LDA.b #SMB2U_UploadMusicBank_MusicBank>>16
	STA.b !RAM_SMAS_Global_ScratchRAM02
	JSR.w SMAS_HandleSPCUploads_Main
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_UploadSMB3LevelMusicBank(Address)
namespace SMAS_UploadSMB3LevelMusicBank
%InsertMacroAtXPosition(<Address>)

Main:
	LDA.b #SMB3_UploadMusicBank_LevelMusicBank
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.b #SMB3_UploadMusicBank_LevelMusicBank>>8
	STA.b !RAM_SMAS_Global_ScratchRAM01
	LDA.b #SMB3_UploadMusicBank_LevelMusicBank>>16
	STA.b !RAM_SMAS_Global_ScratchRAM02
	JSR.w SMAS_HandleSPCUploads_Main
	RTS
namespace off
endmacro


;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_UploadSMWSPCEngine(Address)
namespace SMAS_UploadSMWSPCEngine
%InsertMacroAtXPosition(<Address>)

Main:
	LDA.b #$F0
	STA.w !REGISTER_APUPort1
	STZ.b !RAM_SMW_Misc_ScratchRAM00
	LDA.b #SMW_HandleSPCUploads_SPC700Engine>>8
	STA.b !RAM_SMW_Misc_ScratchRAM01
	LDA.b #SMW_HandleSPCUploads_SPC700Engine>>16
	STA.b !RAM_SMW_Misc_ScratchRAM02
	JSR.w SMAS_HandleSPCUploads_Main
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_GameMode09_LoadGameDemo(Address)
namespace SMAS_GameMode09_LoadGameDemo
%InsertMacroAtXPosition(<Address>)

Main:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
	SEI
	STZ.w !REGISTER_IRQNMIAndJoypadEnableFlags
	STZ.w !REGISTER_HDMAEnable
	STZ.b !RAM_SMAS_TitleScreen_CurrentState
	STZ.b !RAM_SMAS_TitleScreen_PhaseTimerLo
	LDA.b #!ScreenDisplayRegister_SetForceBlank|!ScreenDisplayRegister_MinBrightness00
	STA.w !REGISTER_ScreenDisplayRegister
	STA.w !RAM_SMAS_Global_ScreenDisplayRegister
	STZ.w !RAM_SMAS_Global_HDMAEnable
endif
	LDA.l !SRAM_SMAS_TitleScreen_CurrentGameDemo
	PHA
	INC
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	AND.b #$03
else
	CMP.b #$05
	BCC.b CODE_008250
	LDA.b #$00
endif
CODE_008250:
	STA.l !SRAM_SMAS_TitleScreen_CurrentGameDemo
	STZ.b !RAM_SMAS_GameSelect_CurrentlySelectedSaveFile
	LDA.b #$01
	STA.l !SRAM_SMAS_Global_RunningDemoFlag
	LDX.b #$0F
CODE_00825E:
	LDA.b !RAM_SMAS_GameSelect_HardModeWorldSelectedTable,x
	STA.l !SRAM_SMAS_GameSelect_CanSelectHardModeWorldTable,x
	DEX
	BPL.b CODE_00825E
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	REP.b #$20
	LDA.w #!RAMBank7FEnd-!RAMBank7FStart
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #!RAMBank7FStart
	LDY.b #!RAMBank7FStart>>16
	JSL.l SMAS_InitializeSelectedRAM_Main
	SEP.b #$20
endif
	PLA
	STA.b !RAM_SMAS_Global_ScratchRAM00
	TAX
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	INC
	ASL
	STA.l !RAM_SMAS_Global_CurrentGameX2
else
if !Define_Global_SMASGames&(!SMASGames_SMW) != $00
	PHX
	CPX.b #$04
	BNE.b CODE_00827C
	STZ.w !REGISTER_APUPort0
	STZ.w !REGISTER_APUPort2
	STZ.w !REGISTER_APUPort3
	JSR.w SMAS_UploadSMWSPCEngine_Main
CODE_00827C:
	PLX
else
	BRA.b +
	NOP #16
+
endif
endif
	LDA.l SMAS_GameInitAndMainPointers_Lo,x
	STA.b !RAM_SMAS_Global_ScratchRAM03
	LDA.l SMAS_GameInitAndMainPointers_Hi,x
	STA.b !RAM_SMAS_Global_ScratchRAM04
	LDA.l SMAS_GameInitAndMainPointers_Bank,x
	STA.b !RAM_SMAS_Global_ScratchRAM05
	REP.b #$20
	LDA.w #!RAMBankMirrorStart+$F0
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #!RAMBankMirrorStart+$10
	LDY.b #(!RAMBankMirrorStart+$10)>>16
	JSL.l SMAS_InitializeSelectedRAM_Main
	LDA.w #(!RAMBankMirrorEnd-$0200)-!RAMBankMirrorStart
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #!RAMBankMirrorStart+$0200
	LDY.b #(!RAMBankMirrorStart+$0200)>>16
	JSL.l SMAS_InitializeSelectedRAM_Main
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	LDA.w #$8000
else
	LDA.w #!RAMBank7FEnd-!RAMBank7FStart
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #!RAMBank7FStart
	LDY.b #!RAMBank7FStart>>16
	JSL.l SMAS_InitializeSelectedRAM_Main
	CPX.b #$04
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E) != $00
	BEQ.b CODE_0082C6
else
	BNE.b CODE_0082C6
endif
	LDA.w #$FFFF
	STA.l SMAS_Global_StripeImageUploadTable[$00].LowByte
CODE_0082C6:
endif
	SEP.b #$20
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
	TXA
	INC
	ASL
	STA.l !RAM_SMAS_Global_CurrentGameX2
endif
	PLB
	PLB
	PLB
	REP.b #$30
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	AND.w #$0003
	ASL
	TAX
	LDA.w SMAS_PremadeSaveFileDataOffsets_DATA_008D91,x
	TAY
	LDX.w #$0000
	TXA
	SEP.b #$20
CODE_0082E5:
	LDA.w SMAS_PremadeSaveFileData_Main,y
	STA.l !RAM_SMAS_Global_InitialWorld,x
	INY
	INX
	CPX.w #$0106
	BNE.b CODE_0082E5
	LDA.b #$00
	STA.l !RAM_SMAS_Global_InitialWorld
	STA.l !RAM_SMAS_Global_InitialLevel
	SEP.b #$30
	JMP.w [!RAM_SMAS_Global_ScratchRAM03]				; Glitch: !RAM_SMAS_Global_ScratchRAM03 gets overwritten to be #$00 before this point.
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_LoadStripeImage(Address)
namespace SMAS_LoadStripeImage
%InsertMacroAtXPosition(<Address>)

CODE_0089F6:
	STA.w !REGISTER_VRAMAddressHi
	INY
	LDA.b [!RAM_SMAS_Global_StripeImageDataLo],y
	STA.w !REGISTER_VRAMAddressLo
	INY
	LDA.b [!RAM_SMAS_Global_StripeImageDataLo],y
	ASL
	LDA.b #$40
	ROL
	STA.w !REGISTER_VRAMAddressIncrementValue
	REP.b #$20
	LDA.b [!RAM_SMAS_Global_StripeImageDataLo],y
	XBA
	ASL
	LSR
	STA.w DMA[$00].SizeLo
	STA.b !RAM_SMAS_Global_StripeImageDataSizeLo
	INY
	INY
	TYA
	ADC.b !RAM_SMAS_Global_StripeImageDataLo
	STA.w DMA[$00].SourceLo
	TYA
	ADC.b !RAM_SMAS_Global_StripeImageDataSizeLo
	TAY
	SEP.b #$20
	LDA.b #$01
	STA.w !REGISTER_DMAEnable
Main:
	LDA.b [!RAM_SMAS_Global_StripeImageDataLo],y
	BPL.b CODE_0089F6
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro DATATABLE_SMAS_TriangleTransitionEffectGFXPointers(Address)
namespace SMAS_TriangleTransitionEffectGFXPointers
%InsertMacroAtXPosition(<Address>)

Main:
	dw SMAS_TriangleTransitionalEffectGFX_Main,SMAS_TriangleTransitionalEffectGFX_Main+$20
	dw SMAS_TriangleTransitionalEffectGFX_Main+$40,SMAS_TriangleTransitionalEffectGFX_Main+$60
	dw SMAS_TriangleTransitionalEffectGFX_Main+$80,SMAS_TriangleTransitionalEffectGFX_Main+$A0
	dw SMAS_TriangleTransitionalEffectGFX_Main+$C0,SMAS_TriangleTransitionalEffectGFX_Main+$E0
	dw SMAS_TriangleTransitionalEffectGFX_Main+$0100,SMAS_TriangleTransitionalEffectGFX_Main+$0120
	dw SMAS_TriangleTransitionalEffectGFX_Main+$0140,SMAS_TriangleTransitionalEffectGFX_Main+$0160
	dw SMAS_TriangleTransitionalEffectGFX_Main+$0180,SMAS_TriangleTransitionalEffectGFX_Main+$01A0
	dw SMAS_TriangleTransitionalEffectGFX_Main+$01C0,SMAS_TriangleTransitionalEffectGFX_Main+$01E0
	dw SMAS_TriangleTransitionalEffectGFX_Main+$0200,SMAS_TriangleTransitionalEffectGFX_Main+$0220
	dw SMAS_TriangleTransitionalEffectGFX_Main+$0240,SMAS_TriangleTransitionalEffectGFX_Main+$0260
	dw SMAS_TriangleTransitionalEffectGFX_Main+$0280,SMAS_TriangleTransitionalEffectGFX_Main+$02A0
	dw SMAS_TriangleTransitionalEffectGFX_Main+$02C0,SMAS_TriangleTransitionalEffectGFX_Main+$02E0
	dw SMAS_TriangleTransitionalEffectGFX_Main+$0300,SMAS_TriangleTransitionalEffectGFX_Main+$0320
	dw SMAS_TriangleTransitionalEffectGFX_Main+$0340,SMAS_TriangleTransitionalEffectGFX_Main+$0360
	dw SMAS_TriangleTransitionalEffectGFX_Main+$0380,SMAS_TriangleTransitionalEffectGFX_Main+$03A0
	dw SMAS_TriangleTransitionalEffectGFX_Main+$03C0,SMAS_TriangleTransitionalEffectGFX_Main+$03E0
	dw SMAS_TriangleTransitionalEffectGFX_Main+$0400,SMAS_TriangleTransitionalEffectGFX_Main+$0400
	dw SMAS_TriangleTransitionalEffectGFX_Main+$0400
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro DATATABLE_SMAS_GameSelectScreenTilemap(Address)
namespace SMAS_GameSelectScreenTilemap
%InsertMacroAtXPosition(<Address>)

Main:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U) != $00
	incbin "Tilemaps/GameSelectScreenTilemap_SMAS_U.bin"
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_E) != $00
	incbin "Tilemaps/GameSelectScreenTilemap_SMAS_E.bin"
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	incbin "Tilemaps/GameSelectScreenTilemap_SMAS_J.bin"
else
	incbin "Tilemaps/GameSelectScreenTilemap_SMASW.bin"
endif
End:
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro DATATABLE_SMAS_FileSelectGFX(Address)
namespace SMAS_FileSelectGFX
%InsertMacroAtXPosition(<Address>)

Main:
.Controller:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	incbin "Graphics/FileSelectControllerGFX_SMAS_J.bin"
else
	%InsertVersionExclusiveFile(incbin, Graphics/FileSelectControllerGFX_, !ROMID.bin, )
endif
.ControllerEnd:

if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
.Yoshi:
	incbin "Graphics/FileSelectYoshiGFX.bin"
.YoshiEnd:
endif
End:

if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	incbin "Graphics/BlankFileSelectControllerGFX_SMAS_U.bin"
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	incbin "Graphics/BlankFileSelectControllerGFX_SMAS_J.bin"
else
	incbin "Graphics/BlankFileSelectControllerGFX_SMASW.bin"
endif
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro DATATABLE_RT00_SMAS_BoxArtGFX(Address)
namespace SMAS_BoxArtGFX
%InsertMacroAtXPosition(<Address>)

Section1:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	incbin "Graphics/BoxArtGFX1_SMAS_J.bin"
else
	%InsertVersionExclusiveFile(incbin, Graphics/BoxArtGFX1_, !ROMID.bin, )
endif
Section1End:
namespace off
endmacro

macro DATATABLE_RT01_SMAS_BoxArtGFX(Address)
namespace SMAS_BoxArtGFX
%InsertMacroAtXPosition(<Address>)

Section2:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	incbin "Graphics/BoxArtGFX2_SMAS_J.bin"
else
	%InsertVersionExclusiveFile(incbin, Graphics/BoxArtGFX2_, !ROMID.bin, )
endif
Section2End:
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro DATATABLE_RT00_SMAS_TitleScreenGFX(Address)
namespace SMAS_TitleScreenGFX
%InsertMacroAtXPosition(<Address>)

Section1:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	incbin "Graphics/TitleScreenCharactersGFX1_SMAS.bin"
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_E) != $00
	incbin "Graphics/TitleScreenCharactersGFX1_SMAS_E.bin"			; Note: The only difference between this file and the above is a single tile next to birdo's graphics is filled in differently.
else
	incbin "Graphics/TitleScreenCharactersGFX1_SMASW.bin"
endif
Section1End:
namespace off
endmacro

macro DATATABLE_RT01_SMAS_TitleScreenGFX(Address)
namespace SMAS_TitleScreenGFX
%InsertMacroAtXPosition(<Address>)

Section2:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	incbin "Graphics/TitleScreenCharactersGFX2_SMAS.bin"
else
	incbin "Graphics/TitleScreenCharactersGFX2_SMASW.bin"
endif
Section2End:
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro DATATABLE_SMAS_TitleScreenPalettes(Address)
namespace SMAS_TitleScreenPalettes
%InsertMacroAtXPosition(<Address>)

Dark:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	incbin "Palettes/DarkTitleScreenPalette_SMAS_U.bin"
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	incbin "Palettes/DarkTitleScreenPalette_SMAS_J.bin"
else
	incbin "Palettes/DarkTitleScreenPalette_SMASW.bin"
endif
DarkEnd:

Light:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	incbin "Palettes/TitleAndSplashScreenPalette_SMAS_U.bin"
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	incbin "Palettes/TitleAndSplashScreenPalette_SMAS_J.bin"
else
	incbin "Palettes/TitleAndSplashScreenPalette_SMASW.bin"
endif
LightEnd:
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro DATATABLE_SMAS_TitleScreenTilemap(Address)
namespace SMAS_TitleScreenTilemap
%InsertMacroAtXPosition(<Address>)

Main:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U) != $00
	incbin "Tilemaps/TitleScreenTilemap_SMAS_U.bin"
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_E) != $00
	incbin "Tilemaps/TitleScreenTilemap_SMAS_E.bin"
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	incbin "Tilemaps/TitleScreenTilemap_SMAS_J.bin"
else
	incbin "Tilemaps/TitleScreenTilemap_SMASW.bin"
endif
End:
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro DATATABLE_SMAS_GameSelectScreenPalette(Address)
namespace SMAS_GameSelectScreenPalette
%InsertMacroAtXPosition(<Address>)

Main:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	incbin "Palettes/GameSelectScreenPalette_SMAS_J.bin"
else
	%InsertVersionExclusiveFile(incbin, Palettes/GameSelectScreenPalette_, !ROMID.bin, )
endif
End:
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro DATATABLE_SMAS_BlankPalette(Address)
namespace SMAS_BlankPalette
%InsertMacroAtXPosition(<Address>)

Main:
	%FREE_BYTES(NULLROM, 512, $FF)
End:
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro DATATABLE_SMAS_TriangleTransitionalEffectGFX(Address)
namespace SMAS_TriangleTransitionalEffectGFX
%InsertMacroAtXPosition(<Address>)

Main:
	incbin "Graphics/TriangleTransitionalEffectGFX.bin"
End:
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro DATATABLE_SMAS_TriangleTransitionalEffectTilemap(Address)
namespace SMAS_TriangleTransitionalEffectTilemap
%InsertMacroAtXPosition(<Address>)

Main:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E) != $00
	incbin "Tilemaps/TriangleTransitionalEffectTilemap_SMASW_E.bin"
else
	incbin "Tilemaps/TriangleTransitionalEffectTilemap_SMASW_U.bin"
endif
End:
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro DATATABLE_SMAS_CircleHDMAData(Address)
namespace SMAS_CircleHDMAData
%InsertMacroAtXPosition(<Address>)

DATA_0096BD:
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FE,$FE,$FE,$FE
	db $FD,$FD,$FD,$FD,$FC,$FC,$FC,$FB
	db $FB,$FB,$FA,$FA,$F9,$F9,$F8,$F8
	db $F7,$F7,$F6,$F6,$F5,$F5,$F4,$F3
	db $F3,$F2,$F1,$F1,$F0,$EF,$EE,$EE
	db $ED,$EC,$EB,$EA,$E9,$E9,$E8,$E7
	db $E6,$E5,$E4,$E3,$E2,$E1,$DF,$DE
	db $DD,$DC,$DB,$DA,$D8,$D7,$D6,$D5
	db $D3,$D2,$D0,$CF,$CD,$CC,$CA,$C9
	db $C7,$C6,$C4,$C2,$C1,$BF,$BD,$BB
	db $B9,$B7,$B6,$B4,$B1,$AF,$AD,$AB
	db $A9,$A7,$A4,$A2,$9F,$9D,$9A,$97
	db $95,$92,$8F,$8C,$89,$86,$82,$7F
	db $7B,$78,$74,$70,$6C,$67,$63,$5E
	db $59,$53,$4D,$46,$3F,$37,$2D,$1F
	db $00

DATA_00973E:
	dw $FFFF,$FFFF,$8000,$5555
	dw $4000,$3333,$2AAA,$2492
	dw $2000,$1C71,$1999,$1745
	dw $1555,$13B1,$1249,$1111
	dw $1000,$0F0F,$0E38,$0D79
	dw $0CCC,$0C30,$0BA2,$0B21
	dw $0AAA,$0A3D,$09D8,$097B
	dw $0924,$08D3,$0888,$0842
	dw $0800,$07C1,$0787,$0750
	dw $071C,$06EB,$06BC,$0690
	dw $0666,$063E,$0618,$05F4
	dw $05D1,$05B0,$0590,$0572
	dw $0555,$0539,$051E,$0505
	dw $04EC,$04D4,$04BD,$04A7
	dw $0492,$047D,$0469,$0456
	dw $0444,$0432,$0421,$0410
	dw $0400,$03F0,$03E0,$03D2
	dw $03C3,$03B5,$03A8,$039B
	dw $038E,$0381,$0375,$0369
	dw $035E,$0353,$0348,$033D
	dw $0333,$0329,$031F,$0315
	dw $030C,$0303,$02FA,$02F1
	dw $02E8,$02E0,$02D8,$02D0
	dw $02C8,$02C0,$02B9,$02B1
	dw $02AA,$02A3,$029C,$0295
	dw $028F,$0288,$0282,$027C
	dw $0276,$0270,$026A,$0264
	dw $025E,$0259,$0253,$024E
	dw $0249,$0243,$023E,$0239
	dw $0234,$0230,$022B,$0226
	dw $0222,$021D,$0219,$0214
	dw $0210,$020C,$0208,$0204
	dw $0200,$01FC,$01F8,$01F4
	dw $01F0,$01EC,$01E9,$01E5
	dw $01E1,$01DE,$01DA,$01D7
	dw $01D4,$01D0,$01CD,$01CA
	dw $01C7,$01C3,$01C0,$01BD
	dw $01BA,$01B7,$01B4,$01B2
	dw $01AF,$01AC,$01A9,$01A6
	dw $01A4,$01A1,$019E,$019C
	dw $0199,$0197,$0194,$0192
	dw $018F,$018D,$018A,$0188
	dw $0186,$0183,$0181,$017F
	dw $017D,$017A,$0178,$0176
	dw $0174,$0172,$0170,$016E
	dw $016C,$016A,$0168,$0166
	dw $0164,$0162,$0160,$015E
	dw $015C,$015A,$0158,$0157
	dw $0155,$0153,$0151,$0150
	dw $014E,$014C,$014A,$0149
	dw $0147,$0146,$0144,$0142
	dw $0141,$013F,$013E,$013C
	dw $013B,$0139,$0138,$0136
	dw $0135,$0133,$0132,$0130
	dw $012F,$012E,$012C,$012B
	dw $0129,$0128,$0127,$0125
	dw $0124,$0123,$0121,$0120
	dw $011F,$011E,$011C,$011B
	dw $011A,$0119,$0118,$0116
	dw $0115,$0114,$0113,$0112
	dw $0111,$010F,$010E,$010D
	dw $010C,$010B,$010A,$0109
	dw $0108,$0107,$0106,$0105
	dw $0104,$0103,$0102,$0101
	dw $0100
namespace off
	%SetDuplicateOrNullPointer(SMAS_CircleHDMAData_DATA_0096BD, SMB1_CircleHDMAData_DATA_0096BD)
	%SetDuplicateOrNullPointer(SMAS_CircleHDMAData_DATA_0096BD, SMBLL_CircleHDMAData_DATA_0096BD)
	%SetDuplicateOrNullPointer(SMAS_CircleHDMAData_DATA_0096BD, SMB3_CircleHDMAData_DATA_0096BD)
	%SetDuplicateOrNullPointer(SMAS_CircleHDMAData_DATA_00973E, SMB1_CircleHDMAData_DATA_00973E)
	%SetDuplicateOrNullPointer(SMAS_CircleHDMAData_DATA_00973E, SMBLL_CircleHDMAData_DATA_00973E)
	%SetDuplicateOrNullPointer(SMAS_CircleHDMAData_DATA_00973E, SMB3_CircleHDMAData_DATA_00973E)
endmacro

;#############################################################################################################
;#############################################################################################################

macro DATATABLE_SMAS_BlankGameSelectScreenGFXFile(Address)
namespace SMAS_BlankGameSelectScreenGFXFile
%InsertMacroAtXPosition(<Address>)

Main:
	db $00
	%FREE_BYTES(NULLROM, 2047, $00)
End:
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro DATATABLE_SMAS_ErrorMessageFontGFX(Address)
namespace SMAS_ErrorMessageFontGFX
%InsertMacroAtXPosition(<Address>)

Main:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	incbin "Graphics/ErrorMessageFontGFX_SMAS_J.bin"
else
	incbin "Graphics/ErrorMessageFontGFX_SMAS_U.bin"
endif
End:
namespace off
	%SetDuplicateOrNullPointer(SMAS_ErrorMessageFontGFX_Main, SMB2U_ErrorMessageFontGFX_Main)
	%SetDuplicateOrNullPointer(SMAS_ErrorMessageFontGFX_End, SMB2U_ErrorMessageFontGFX_End)
endmacro

;#############################################################################################################
;#############################################################################################################

macro DATATABLE_SMAS_SplashScreenGFX(Address)
namespace SMAS_SplashScreenGFX
%InsertMacroAtXPosition(<Address>)

Main:
	incbin "Graphics/SplashScreenGFX.bin"
End:
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro DATATABLE_SMAS_TitleScreenTextGFX(Address)
namespace SMAS_TitleScreenTextGFX
%InsertMacroAtXPosition(<Address>)

Main:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	incbin "Graphics/TitleScreenTextGFX_SMAS_U.bin"
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	incbin "Graphics/TitleScreenTextGFX_SMAS_J.bin"
else
	%InsertVersionExclusiveFile(incbin, Graphics/TitleScreenTextGFX_, !ROMID.bin, )
endif
End:
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro DATATABLE_RT00_SMAS_FileSelectMenuData(Address)
namespace SMAS_FileSelectMenuData
%InsertMacroAtXPosition(<Address>)

DATA_00B421:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	dw $7AEF,$7AFE,$7EEE,$7EFF
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	dw $7AEF,$7AFF,$7EED,$7EFD
else
	dw $7AEF,$7AFB,$7EE7,$7EF3,$7AE1
endif

DATA_00B42B:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	dw $7B0F,$7B1E,$7F0E,$7F1F
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	dw $7B0F,$7B1F,$7F0D,$7F1D
else
	dw $7B0F,$7B1B,$7F07,$7F13,$7B01
endif

DATA_00B435:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	dw $0016,$0004,$0016,$0002
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	dw $0016,$0002,$0016,$0006
else
	dw $0016,$000A,$0016,$0016,$0016
endif

DATA_00B43F:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	dw $0000,$0012,$0000,$0014
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	dw $0000,$0014,$0000,$0010
else
	dw $0000,$000C,$0000,$0000,$0000
endif

DATA_00B449:
	dw DATA_00B49B
	dw DATA_00B485
	dw DATA_00B46F
	dw DATA_00B459

DATA_00B451:
	dw DATA_00B4B1
	dw DATA_00B4C7
	dw DATA_00B4DD
	dw DATA_00B4F3

DATA_00B459:
	dw $0388,$0389,$0389,$0389
	dw $0389,$0389,$0389,$0389
	dw $0389,$0389,$4388

DATA_00B46F:
	dw $038A,$0383,$0395,$0396
	dw $0397,$0383,$02FF,$02FF
	dw $02FF,$02FF,$438A

DATA_00B485:
	dw $038A,$02FF,$02FF,$02FF
	dw $0398,$0399,$039A,$0383
	dw $02FF,$035F,$438A

DATA_00B49B:
	dw $038A,$02FF,$02FF,$02FF
	dw $02FF,$02FF,$02FF,$02FF
	dw $02FF,$02FF,$438A

DATA_00B4B1:
	dw $038A,$02FF,$02FF,$034F
	dw $036F,$037F,$02FF,$02FF
	dw $02FF,$02FF,$438A

DATA_00B4C7:
	dw $038A,$02FF,$02FF,$02FF
	dw $02FF,$02FF,$02FF,$02FF
	dw $02FF,$02FF,$438A

DATA_00B4DD:
	dw $038A,$02FF,$02FF,$02FF
	dw $0381,$0383,$0397,$02FF
	dw $02FF,$02FF,$438A

DATA_00B4F3:
	dw $8388,$8389,$8389,$8389
	dw $8389,$8389,$8389,$8389
	dw $8389,$8389,$C388

DATA_00B509:
	dw $02FF,$02FF,$02FF,$02FF
	dw $02FF,$02FF,$02FF,$02FF
	dw $02FF,$02FF,$02FF
namespace off
endmacro

macro DATATABLE_RT01_SMAS_FileSelectMenuData(Address)
namespace SMAS_FileSelectMenuData
%InsertMacroAtXPosition(<Address>)

DATA_00B6D6:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	dw $7B12,$7F01,$7F11,$7B02
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	dw $7B12,$7F02,$7F10,$7B00
else
	dw $7B12,$7B1E,$7F0A,$7F16,$7B04
endif

DATA_00B6E0:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	dw $7970,$797F,$7D6F,$7960
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	dw $7970,$7D60,$7D6E,$7D7E,$7960
else
	dw $7970,$797C,$7D68,$7D74,$7962
endif

DATA_00B6EA:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	dw $000C,$0002,$000C,$000C
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	dw $000C,$000C,$000C,$0004,$0008
else
	dw $000C,$0008,$000C,$000C,$000C
endif

DATA_00B6F4:
	dw $0360,$0361,$0362,$0363
	dw $02FF,$02FF,$0370,$0371
	dw $0372,$0373,$02FF,$02FF

if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
if !Define_Global_SMASGames&(!SMASGames_SMW) != $00

DATA_00B70C:
	dw !Define_SMW_Misc_SaveFileSize*$00
	dw !Define_SMW_Misc_SaveFileSize*$01
	dw !Define_SMW_Misc_SaveFileSize*$02
	dw !Define_SMW_Misc_SaveFileSize*$03
else
	NOP #8
endif
endif

DATA_00B714:
	db $00,$01,$FF

if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
UNK_00B5ED:
	db $07,$08,$09,$0A,$7F,$17,$18,$19
	db $1A,$7F,$07,$08,$09,$0A,$0E,$17
	db $18,$19,$1A,$1E,$17,$18,$19,$1A
	db $7F,$7F,$7F,$0B,$0C,$0D,$07,$08
	db $09,$0A,$0F,$17,$18,$19,$1A,$1F
	db $1B,$1C,$1D,$20,$1B,$1C,$1D,$21
	db $1B,$1C,$1D,$30,$1B,$1C,$1D,$31
	db $65,$66,$67,$75,$76,$77
endif
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro DATATABLE_SMAS_SaveFileLocations(Address)
namespace SMAS_SaveFileLocations
%InsertMacroAtXPosition(<Address>)

; Note: Each column of this table corresponds to a game, while each row corresponds to a file.

Main:
	dw $0000,$0009,$0011,$001A
	dw $0120,$0129,$0131,$013A
	dw $0240,$0249,$0251,$025A
	dw $0360,$0369,$0371,$037A
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro DATATABLE_SMAS_GameModeSettings(Address)
namespace SMAS_GameModeSettings
%InsertMacroAtXPosition(<Address>)

AllowSpritesFlags:
	db $01,$01,$01,$01,$01,$01,$01,$01
	db $01,$00,$00,$01,$01,$01,$01,$01
	db $01,$01,$01,$01,$01,$01,$01,$01
	db $01,$01,$01,$01,$01,$01,$01,$01

OAMSizeAndDataAreaDesignation:
	db !SpriteGFXLocationInVRAMLo_6000|!SpriteGFXLocationInVRAMHi_Add1000|!SpriteSize_8x8_16x16
	db !SpriteGFXLocationInVRAMLo_0000|!SpriteGFXLocationInVRAMHi_Add1000|!SpriteSize_8x8_16x16

BGModeAndTileSizeSetting:
	db !BGModeAndTileSizeSetting_Mode03Enable
	db !BGModeAndTileSizeSetting_Mode03Enable

BG1AddressAndSize:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	db $78
else
	db $7C
endif
	db $73

BG2AddressAndSize:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	db $72
else
	db $78
endif
	db $6C

BG3AddressAndSize:
	db $00
	db $00

BG1And2TileDataDesignation:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	db $50
else
	db $70
endif
	db $70

BG3And4TileDataDesignation:
	db $00
	db $05

MainScreenLayers:
	db $13
	db $02

SubScreenLayers:
	db $00
	db $11

ColorMathInitialSettings:
	db $00
	db $02

ColorMathSelectAndEnable:
	db $20
	db $20

InitialYPosLo:
	db $00
	db $00

InitialYPosHi:
	db $00
	db $01

UNK_0088BB:
	db $00,$00,$00,$20,$00,$00,$00,$80
	db $00,$00,$06,$00,$00,$00,$00,$40
	db $00,$00,$00,$40,$00,$00,$00,$A0
	db $00,$00,$07,$00,$00,$00,$00,$20
	db $00,$00,$00,$70,$00,$00,$00,$80
	db $00,$00,$07,$00,$00,$00,$00,$20
	db $00,$00,$00,$00,$00,$00,$00,$C0
	db $00,$00,$06,$00,$00,$00,$00,$40
	db $0F,$00,$6D,$00,$24,$01,$24,$01

Palette:
	dw SMAS_BlankPalette_Main
	dw SMAS_GameSelectScreenPalette_Main
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro DATATABLE_SMAS_PremadeSaveFileDataOffsets(Address)
namespace SMAS_PremadeSaveFileDataOffsets
%InsertMacroAtXPosition(<Address>)

DATA_008D91:
	dw $0000,$0009,$0011,$001A

DATA_008D99:
	dw $0009,$0008,$0009,$0106
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro DATATABLE_SMAS_PremadeSaveFileData(Address)
namespace SMAS_PremadeSaveFileData
%InsertMacroAtXPosition(<Address>)

Main:
	db $FF,$FF,$FF,$04,$04,$00,$FF,$00,$00,$FF,$FF,$FF,$04,$00,$FF,$00
	db $00,$FF,$FF,$05,$00,$00,$00,$00,$00,$00,$FF,$FF,$04,$04,$70,$80
	db $80,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$D0,$C0,$A0,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$01,$00,$03,$00,$00,$00,$00,$00
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
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$FF,$00,$00
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro DATATABLE_SMAS_TitleScreenAnimationData(Address)
namespace SMAS_TitleScreenAnimationData
%InsertMacroAtXPosition(<Address>)

Main:
LuigiHead:
.Frame00:
	dw $01D6,$01D7,$01D8,$0000
	dw $01D9,$01DA,$01DB,$01DC,$0000
	dw $01DD,$01DE,$01DF,$0240,$0000
	dw $01E0,$01E1,$01E2,$FFFF

.Frame01:
.Frame03:
	dw $0111,$0112,$0113,$0000
	dw $0121,$0122,$0123,$0124,$0000
	dw $0106,$0107,$0108,$0109,$0000
	dw $0116,$0117,$0118,$FFFF

.Frame02:
	dw $01E3,$01E4,$01E5,$0000
	dw $01E6,$01E7,$01E8,$01E9,$0000
	dw $01EA,$01EB,$01EC,$01ED,$0000
	dw $01EE,$01EF,$01F0,$FFFF

LuigiArm:
.Frame00:
.Frame01:
	dw $0115,$0000
	dw $0125,$0126,$0000
	dw $0105,$010A,$FFFF

.Frame02:
.Frame03:
.Frame04:
.Frame05:
.Frame07:
.Frame08:
.Frame09:
.Frame10:
	dw $01F1,$0000
	dw $01F2,$01F3,$0000
	dw $01F4,$01F5,$FFFF

.Frame06:
	dw $01F6,$0000
	dw $01F7,$01F8,$0000
	dw $01F9,$01FA,$FFFF

Peach:
.Frame00:
	dw $0019,$001A,$001B,$001C,$0000
	dw $0029,$002A,$002B,$002C,$0000
	dw $0039,$003A,$003B,$003C,$FFFF

.Frame01:
	dw $021A,$021B,$021C,$021D,$0000
	dw $021E,$021F,$0220,$0221,$0000
	dw $0222,$0223,$0224,$0225,$FFFF

Toad:
.Frame00:
	dw $010D,$010E,$010F,$0131,$0000
	dw $011D,$011E,$011F,$0141,$0000
	dw $012D,$012E,$012F,$0151,$0000
	dw $000D,$000E,$000F,$00E5,$0000
	dw $001D,$001E,$001F,$00F4,$0000
	dw $002D,$002E,$002F,$FFFF

.Frame01:
	dw $0200,$0201,$0202,$0203,$0000
	dw $0204,$0205,$0206,$0207,$0000
	dw $0208,$0209,$020A,$020B,$0000
	dw $020C,$020D,$020E,$020F,$0000
	dw $0210,$0211,$0212,$0213,$0000
	dw $002D,$0214,$0215,$FFFF

if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
BirdoEyes:
.Frame00:
.Frame02:
	dw $0143,$0144,$0000
	dw $0153,$0154,$FFFF

.Frame01:
	dw $01AC,$01AD,$0000
	dw $0153,$01AE,$FFFF
endif

BirdoClaw:
.Frame00:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	dw $0152,$0000
	dw $0136,$0137,$0000
	dw $0146,$0147,$FFFF
else
	dw $0148,$0135,$0000
	dw $0158,$0145,$0000
	dw $0149,$0155,$FFFF
endif

.Frame01:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	dw $019F,$0000
	dw $01A0,$01A1,$0000
	dw $01A2,$01A3,$FFFF
else
	dw $0248,$0249,$0000
	dw $0258,$0259,$0000
	dw $0268,$0269,$FFFF
endif

BirdoTail:
.Frame00:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	dw $0139,$013A,$0000
	dw $0149,$014A,$0000
	dw $0159,$015A,$FFFF
else
	dw $01A0,$01A1,$0000
	dw $01A2,$01A3,$0000
	dw $01A4,$FFFF
endif

.Frame01:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	dw $0139,$01A4,$0000
	dw $01A5,$01A6,$0000
	dw $0159,$01A7,$FFFF
else
	dw $01A5,$01A6,$0000
	dw $01A7,$01A8,$0000
	dw $01A9,$FFFF
endif

.Frame02:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	dw $0139,$01A8,$0000
	dw $01A9,$01AA,$0000
	dw $0159,$01AB,$FFFF
else
	dw $01AA,$01AB,$0000
	dw $01AC,$01AD,$0000
	dw $01AE,$FFFF
endif

if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
.Frame03:
	dw $0139,$01A4,$0000
	dw $01A5,$01A6,$0000
	dw $0159,$01A7,$FFFF
endif

Goomba:
.Frame00:
.Frame02:
	dw $0087,$0088,$0000
	dw $0097,$0098,$0099,$FFFF

.Frame01:
	dw $01FB,$01FC,$0000
	dw $01FD,$01FE,$01FF,$FFFF

if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
BobOmb:
.Frame00:
.Frame03:
	dw $0082,$0083,$FFFF
.Frame01:
	dw $0216,$0217,$FFFF
.Frame02:
	dw $0218,$0219,$FFFF
endif

if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
Spiny:
.Frame00:
	dw $00F8,$00F9,$FFFF
.Frame01:
	dw $023E,$023F,$FFFF
endif

Pidget:
.Frame00:
	dw $015B,$015C,$015D,$0000
	dw $015E,$015F,$0160,$0161,$0000
	dw $0162,$0163,$0164,$0165,$0166,$0000
	dw $0167,$0168,$0169,$016A,$016B,$FFFF

.Frame01:
	dw $016C,$016D,$016E,$0000
	dw $016F,$0170,$0171,$0172,$0000
	dw $0173,$0174,$0175,$0176,$0177,$0000
	dw $0178,$0179,$017A,$017B,$017C,$FFFF

.Frame02:
	dw $017D,$017E,$017F,$0000
	dw $0180,$0181,$0182,$0183,$0000
	dw $0184,$0185,$0186,$0187,$0188,$0000
	dw $0189,$018A,$018B,$018C,$018D,$FFFF

.Frame03:
	dw $018E,$018F,$0190,$0000
	dw $0191,$0192,$0193,$0194,$0000
	dw $0195,$0196,$0197,$0198,$0199,$0000
	dw $019A,$019B,$019C,$019D,$019E,$FFFF

MarioFace:
.Frame00:
.Frame04:
	dw $004C,$004D,$004E,$004F,$0000
	dw $005C,$005D,$005E,$005F,$0000
	dw $006C,$006D,$006E,$006F,$FFFF

.Frame01:
.Frame03:
.Frame05:
	dw $01B4,$01B5,$01B6,$01B7,$0000
	dw $01B8,$01B9,$01BA,$01BB,$0000
	dw $01BC,$01BD,$01BE,$01BF,$FFFF

.Frame02:
.Frame06:
	dw $01C4,$01C5,$01C6,$01C7,$0000
	dw $01C8,$01C9,$01CA,$01CB,$0000
	dw $01CC,$01CD,$01CE,$01CF,$FFFF

.Frame07:
.Frame08:
.Frame09:
	dw $01C4,$01C5,$01C6,$01C7,$0000
	dw $01C8,$01C9,$01CA,$01D0,$0000
	dw $01CC,$01CD,$01CE,$01D2,$FFFF

MarioHat:
.Frame00:
.Frame04:
	dw $003D,$003E,$003F,$FFFF

.Frame01:
.Frame03:
.Frame05:
	dw $01B1,$01B2,$01B3,$FFFF

.Frame02:
.Frame06:
	dw $01C1,$01C2,$01C3,$FFFF

.Frame07:
.Frame08:
.Frame09:
	dw $01C1,$01C2,$01C3,$FFFF

MarioHand:
.Frame00:
	dw $0150,$0000
	dw $013B,$0104,$0000
	dw $013C,$FFFF

.Frame01:
.Frame02:
.Frame03:
	dw $01D1,$0000
	dw $01D3,$01D3,$0000
	dw $01D5,$FFFF

Bowser:
.Frame00:
.Frame01:
.Frame02:
	dw $0037,$0038,$0000
	dw $0047,$0048,$0049,$0000
	dw $0057,$0058,$0059,$0000
	dw $0067,$0068,$0069,$FFFF

.Frame03:
.Frame07:
	dw $0226,$0227,$0000
	dw $0228,$0229,$022A,$0000
	dw $022B,$022C,$022D,$0000
	dw $0067,$022F,$0230,$FFFF

.Frame04:
.Frame05:
.Frame06:
	dw $0231,$0232,$0000
	dw $0233,$0234,$0235,$0000
	dw $0236,$0237,$0238,$0000
	dw $0067,$023A,$023B,$FFFF

if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
Yoshi:
.Frame00:
.Frame06:
	dw $0243,$0244,$0245,$0246,$0000
	dw $0253,$0254,$0255,$0256,$0000
	dw $0263,$0264,$0265,$0266,$0000
	dw $0273,$0274,$0275,$0276,$FFFF

.Frame01:
.Frame02:
	dw $024A,$024B,$024C,$024D,$0000
	dw $025A,$025B,$025C,$025D,$0000
	dw $026A,$026B,$026C,$026D,$0000
	dw $027A,$027B,$027C,$027D,$FFFF

.Frame03:
	dw $024A,$024B,$024C,$024D,$0000
	dw $025A,$025B,$025C,$025D,$0000
	dw $026A,$026E,$026F,$026D,$0000
	dw $027A,$027E,$027F,$027D,$FFFF

.Frame04:
	dw $024A,$024B,$024C,$024D,$0000
	dw $025A,$025B,$025C,$025D,$0000
	dw $026A,$024E,$024F,$026D,$0000
	dw $027A,$025E,$025F,$027D,$FFFF

.Frame05:
	dw $024A,$024B,$024C,$024D,$0000
	dw $025A,$025B,$025C,$025D,$0000
	dw $026A,$0270,$0271,$026D,$0000
	dw $027A,$0272,$0279,$027D,$FFFF
endif
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_BufferPlayerCountOnFile(Address)
namespace SMAS_BufferPlayerCountOnFile
%InsertMacroAtXPosition(<Address>)

Main:
	REP.b #$10
	LDA.w !RAM_SMAS_GameSelect_CursorPosIndex
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	AND.w #$0003
else
	AND.w #$0007
endif
	STA.b !RAM_SMAS_Global_ScratchRAM0A
	LDA.w #$0000
	TAX
	STA.b !RAM_SMAS_Global_ScratchRAM04
CODE_00AE96:
	LDY.b !RAM_SMAS_Global_ScratchRAM04
	LDA.b [!RAM_SMAS_Global_ScratchRAM00],y
	AND.w #$00FF
	CMP.w #$00FF
	BEQ.b CODE_00AEB1
	CLC
	ADC.b !RAM_SMAS_Global_ScratchRAM0A
	ASL
	TAY
	LDA.w DATA_00AEC7,y
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$F0,x
	INC
	STA.w !RAM_SMAS_GameSelect_FileSelectWindowBuffer+$F2,x
CODE_00AEB1:
	LDA.b !RAM_SMAS_Global_ScratchRAM04
	CLC
	ADC.w #$0120
	STA.b !RAM_SMAS_Global_ScratchRAM04
	TXA
	CLC
	ADC.w #$0054
	TAX
	AND.w #$0100
	BEQ.b CODE_00AE96
	SEP.b #$10
	RTS

DATA_00AEC7:
	dw $039C,$039E,$0000,$0000
	dw $039C,$039E
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMAS_VerifySaveDataIsValid(Address)
namespace SMAS_VerifySaveDataIsValid
%InsertMacroAtXPosition(<Address>)

Main:
	SEP.b #$20
	LDA.b #$00
	STA.l !SRAM_SMAS_Global_EnableSMASDebugModeFlag
	REP.b #$30
	LDA.l !SRAM_SMAS_Global_ValidSaveData1Lo
	CMP.w #$9743
	BNE.b CODE_008C88
	LDA.l !SRAM_SMAS_Global_ValidSaveData2Lo
	CMP.w #$5321
	BEQ.b CODE_008CBF
CODE_008C88:
	SEP.b #$10
	LDA.w #(!SRAMBankBaseAddress+!SRAMBankEnd)-!SRAMBankBaseAddress
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.w #!SRAMBankBaseAddress
	LDY.b #!SRAMBankBaseAddress>>16
	JSL.l SMAS_InitializeSelectedRAM_Main
	REP.b #$10
	LDX.w #$0000
CODE_008C9D:
	JSR.w CODE_008D41
	LDA.l !SRAM_SMAS_Global_SaveFileIndexLo
	INC
	STA.l !SRAM_SMAS_Global_SaveFileIndexLo
	CMP.w #$0010
	BCC.b CODE_008C9D
	LDA.w #$9743
	STA.l !SRAM_SMAS_Global_ValidSaveData1Lo
	LDA.w #$5321
	STA.l !SRAM_SMAS_Global_ValidSaveData2Lo
	JMP.w Main

CODE_008CBF:
	LDA.w #$0000
	STA.l !SRAM_SMAS_Global_SaveFileIndexLo
	TAX
CODE_008CC7:
	AND.w #$0003
	ASL
	TAY
	LDA.w SMAS_PremadeSaveFileDataOffsets_DATA_008D99,y
	DEC
	DEC
	TAY
	STZ.b !RAM_SMAS_Global_ScratchRAM00
	STX.b !RAM_SMAS_Global_ScratchRAM02
	SEP.b #$20
CODE_008CD8:
	LDA.l !SRAM_SMAS_Global_SaveFileBaseOffset,x
	CLC
	ADC.b !RAM_SMAS_Global_ScratchRAM00
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.b !RAM_SMAS_Global_ScratchRAM01
	ADC.b #$00
	STA.b !RAM_SMAS_Global_ScratchRAM01
	INX
	DEY
	BNE.b CODE_008CD8
	REP.b #$21
	LDA.b !RAM_SMAS_Global_ScratchRAM00
	ADC.l !SRAM_SMAS_Global_SaveFileBaseOffset,x
	BNE.b CODE_008D07
	INX
	INX
CODE_008CF7:
	LDA.l !SRAM_SMAS_Global_SaveFileIndexLo
	INC
	STA.l !SRAM_SMAS_Global_SaveFileIndexLo
	CMP.w #$0010
	BCS.b CODE_008D12
	BRA.b CODE_008CC7

CODE_008D07:
	REP.b #$30
	LDX.b !RAM_SMAS_Global_ScratchRAM02
	JSR.w CODE_008D41
	STX.b !RAM_SMAS_Global_ScratchRAM02
	BRA.b CODE_008CF7

CODE_008D12:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
if !Define_Global_SMASGames&(!SMASGames_SMW) != $00
	SEP.b #$30
	LDA.b !RAM_SMW_Misc_ScratchRAM8A
	PHA
	LDA.b !RAM_SMW_Misc_ScratchRAM8B
	PHA
	PHB
	LDA.b #SMW_BufferFileSelectText_SMASEntry>>16
	PHA
	PLB
	LDX.b #$00
CODE_008D21:
	STX.b !RAM_SMW_Misc_ScratchRAM00
	PHX
	JSL.l SMW_BufferFileSelectText_SMASEntry
	BEQ.b CODE_008D2E
	JSL.l SMAS_ClearSMWSaveData_Main
CODE_008D2E:
	PLX
	INX
	CPX.b #$03
	BNE.b CODE_008D21
	PLB
	PLA
	STA.b !RAM_SMW_Misc_ScratchRAM8B
	PLA
	STA.b !RAM_SMW_Misc_ScratchRAM8A
endif
endif
	JMP.w CODE_008D3E

if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
UNK_008CC4:
	LDA.l !SRAM_SMAS_Global_UnknownSRAM700389
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.l !SRAM_SMAS_Global_UnknownSRAM700370
	AND.w #$00FF
	CLC
	ADC.b !RAM_SMAS_Global_ScratchRAM00
	SEC
	SBC.w #$0007
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.l !SRAM_SMAS_Global_UnknownSRAM700371
	AND.w #$00FF
	CLC
	ADC.b !RAM_SMAS_Global_ScratchRAM00
	SEC
	SBC.w #$0003
	STA.l !SRAM_SMAS_Global_UnknownSRAM700389
	LDA.w #$0307
	STA.l !SRAM_SMAS_Global_UnknownSRAM700370
	LDA.l !SRAM_SMAS_Global_UnknownSRAM70038A
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.l !SRAM_SMAS_Global_UnknownSRAM700379
	AND.w #$00FF
	CLC
	ADC.b !RAM_SMAS_Global_ScratchRAM00
	SEC
	SBC.w #$000C
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.l !SRAM_SMAS_Global_UnknownSRAM70037A
	AND.w #$00FF
	CLC
	ADC.b !RAM_SMAS_Global_ScratchRAM00
	SEC
	SBC.w #$0003
	STA.l !SRAM_SMAS_Global_UnknownSRAM70038A
	LDA.w #$030C
	STA.l !SRAM_SMAS_Global_UnknownSRAM700379
	LDA.l !SRAM_SMAS_Global_UnknownSRAM700388
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.l !SRAM_SMAS_Global_UnknownSRAM700381
	AND.w #$00FF
	CLC
	ADC.b !RAM_SMAS_Global_ScratchRAM00
	SEC
	SBC.w #$0006
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.l !SRAM_SMAS_Global_UnknownSRAM700382
	AND.w #$00FF
	CLC
	ADC.b !RAM_SMAS_Global_ScratchRAM00
	SEC
	SBC.w #$0001
	STA.l !SRAM_SMAS_Global_UnknownSRAM700388
	LDA.w #$0106
	STA.l !SRAM_SMAS_Global_UnknownSRAM700381
	LDA.l !SRAM_SMAS_Global_UnknownSRAM7004A0
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.l !SRAM_SMAS_Global_UnknownSRAM70038A
	AND.w #$00FF
	CLC
	ADC.b !RAM_SMAS_Global_ScratchRAM00
	SEC
	SBC.w #$0006
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.l !SRAM_SMAS_Global_UnknownSRAM70038B
	AND.w #$00FF
	CLC
	ADC.b !RAM_SMAS_Global_ScratchRAM00
	SEC
	SBC.w #$0000
	STA.l !SRAM_SMAS_Global_UnknownSRAM7004A0
	LDA.w #$0007
	STA.l !SRAM_SMAS_Global_UnknownSRAM70038A
endif
CODE_008D3E:
	SEP.b #$30
	RTS

CODE_008D41:
	LDA.l !SRAM_SMAS_Global_SaveFileIndexLo
	AND.w #$0003
	ASL
	TAY
	LDA.w SMAS_PremadeSaveFileDataOffsets_DATA_008D99,y
	DEC
	DEC
	STA.b !RAM_SMAS_Global_ScratchRAM0E
	LDA.w SMAS_PremadeSaveFileDataOffsets_DATA_008D91,y
	TAY
	STZ.b !RAM_SMAS_Global_ScratchRAM00
	SEP.b #$20
CODE_008D59:
	LDA.w SMAS_PremadeSaveFileData_Main,y
	STA.l !SRAM_SMAS_Global_SaveFileBaseOffset,x
	CLC
	ADC.b !RAM_SMAS_Global_ScratchRAM00
	STA.b !RAM_SMAS_Global_ScratchRAM00
	LDA.b !RAM_SMAS_Global_ScratchRAM01
	ADC.b #$00
	STA.b !RAM_SMAS_Global_ScratchRAM01
	LDA.w SMAS_PremadeSaveFileData_Main,y
	INX
	INY
	DEC.b !RAM_SMAS_Global_ScratchRAM0E
	BNE.b CODE_008D59
	DEC.b !RAM_SMAS_Global_ScratchRAM0F
	BPL.b CODE_008D59
	REP.b #$20
	LDA.w #$0000
	SEC
	SBC.b !RAM_SMAS_Global_ScratchRAM00
	STA.l !SRAM_SMAS_Global_SaveFileBaseOffset,x
	LDA.b !RAM_SMAS_GameSelect_CurrentlyOpenedFileSelectWindow						;\ Optimization: Junk
	AND.w #$0003						;|
	CMP.w #$0003						;|
	BNE.b CODE_008D8E					;|
CODE_008D8E:							;/
	INX
	INX
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################
