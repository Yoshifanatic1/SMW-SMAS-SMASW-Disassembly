
; Todo: There is a glitch where you can't pause for a while after entering *1-1 from 8-4. Why?

macro SMB1Bank03Macros(StartBank, EndBank)
%BANK_START(<StartBank>)
SMB1_InitAndMainLoop_Main:
	JMP.w SMASSMB1Reset

SMB1_InitAndMainLoop_NMIVector:
	JMP.w SMB1_VBlankRoutine_Main

SMB1_InitAndMainLoop_IRQVector:
	JMP.w SMB1_IRQRoutine_Main

if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMB1_J) == $00
UNK_038009:
	db $00,$00,$03,$03,$04,$04,$05,$05
endif

CODE_038011:
	JML.l SMB1_DisplayCopyDetectionErrorMessage_Main				; Note: Call to SMAS function

SMASSMB1Reset:
if !Define_Global_ROMToAssemble&(!ROM_SMB1_U|!ROM_SMB1_E|!ROM_SMB1_J) != $00
	SEI
	CLC
	XCE
	STZ.w !REGISTER_IRQNMIAndJoypadEnableFlags
	STZ.w !REGISTER_DMAEnable
	STZ.w !REGISTER_HDMAEnable
	LDA.b #$80
	STA.w !REGISTER_ScreenDisplayRegister
	REP.b #$20
	LDA.w #!RAM_SMB1_Global_StartOfStack
	TCS
	LDA.w #!RAM_SMB1_Global_ScratchRAM00
	TCD
	SEP.b #$20
endif
if !Define_SMAS_Global_DisableCopyDetection == !FALSE
	NOP #2
	LDA.b #$AA
	STA.l !SRAM_SMAS_Global_CopyDetectionCheck2
	CMP.l !SRAM_SMAS_Global_CopyDetectionCheck1
	BNE.b CODE_038011
	LDA.b #$55
	STA.l !SRAM_SMAS_Global_CopyDetectionCheck2
	CMP.l !SRAM_SMAS_Global_CopyDetectionCheck1
	BNE.b CODE_038011
endif
if !Define_Global_ROMToAssemble&(!ROM_SMB1_U|!ROM_SMB1_E|!ROM_SMB1_J) != $00
	LDA.w !REGISTER_PPUStatusFlag2
	BIT.b #!PPUStatusFlag2_ConsoleRegion
if !Define_Global_ROMToAssemble&(!ROM_SMB1_E) != $00
	BNE.b +
else
	BEQ.b +
endif
	JML.l SMB1_DisplayRegionErrorMessage_Main

+:
	JSL.l SMB1_UploadSPCEngine_Main
	JSL.l SMB1_InitializeRAMOnStartup_Main
	JSL.l SMB1_VerifySaveDataIsValid_Main
	JSL.l SMB1_UploadMainSampleData_Main
	JSL.l SMB1_LoadSplashScreen_Main
	JSL.l SMB1_UploadMusicBank_Main
else
	SEI
	STZ.w !REGISTER_IRQNMIAndJoypadEnableFlags
	STZ.w !REGISTER_HDMAEnable
	STZ.w !REGISTER_DMAEnable
	LDA.b #!ScreenDisplayRegister_SetForceBlank
	STA.w !REGISTER_ScreenDisplayRegister
endif
	PHK
	PLB
	LDA.b #$01
	STA.w $028C
	LDA.b #$03
	STA.w $0F0B
	STZ.w $028E
	STZ.w $0E67
if !Define_Global_ROMToAssemble&(!ROM_SMB1_U|!ROM_SMB1_E|!ROM_SMB1_J) == $00
	LDA.l !SRAM_SMAS_Global_InitialSelectedLevel
	STA.w $0E24
	STA.l !RAM_SMB1_Global_SaveBuffer_CurrentLevel
	LDA.l !SRAM_SMAS_Global_InitialSelectedWorld
	STA.w !RAM_SMB1_Player_CurrentWorld
	STA.l !RAM_SMB1_Global_SaveBuffer_CurrentWorld
	ASL
	ASL
	CLC
	ADC.l !SRAM_SMAS_Global_InitialSelectedLevel
	TAX
	LDA.l UNK_05D272,x
	STA.l !SRAM_SMAS_Global_InitialSelectedLevel
	STA.l $7FFB02
	STA.w !RAM_SMB1_Player_CurrentLevel
endif
	LDA.b #!SpriteGFXLocationInVRAMLo_6000|!SpriteGFXLocationInVRAMHi_Add1000|!SpriteSize_8x8_16x16
	STA.w !REGISTER_OAMSizeAndDataAreaDesignation
	LDA.b #$01
	STA.w !REGISTER_BG1AddressAndSize
	LDA.b #$09
	STA.w !REGISTER_BG2AddressAndSize
	LDA.b #$59
	STA.w !REGISTER_BG3AddressAndSize
	STZ.w !REGISTER_BG4AddressAndSize
	LDA.b #$11
	STA.w !REGISTER_BG1And2TileDataDesignation
	LDA.b #$05
	STA.w !REGISTER_BG3And4TileDataDesignation
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDA.b #!InitialScreenSettings_EnableOverscanFlag
	STA.w !REGISTER_InitialScreenSettings
else
	STZ.w !REGISTER_InitialScreenSettings
endif
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMB1_J) == $00
	STZ.w $1681
endif
	STZ.w !RAM_SMB1_Global_GameMode
	STZ.w $0772
	LDA.b #$00
	STA.l $7FFFFF
	JSL.l CODE_04FDC4
	LDA.b #$09
	STA.w !RAM_SMB1_Global_BGModeAndTileSizeSettingMirror
	STZ.w !RAM_SMB1_Global_MosaicSizeAndBGEnableMirror
	LDA.b #$10
	STA.w !RAM_SMB1_Global_MainScreenLayersMirror
	STZ.w !RAM_SMB1_Global_SubScreenLayersMirror
	STZ.w !RAM_SMB1_Global_BG1And2WindowMaskSettingsMirror
	STZ.w !RAM_SMB1_Global_BG3And4WindowMaskSettingsMirror
	STZ.w !RAM_SMB1_Global_ObjectAndColorWindowSettingsMirror
	STZ.w !RAM_SMB1_Global_ColorMathInitialSettingsMirror
	LDA.b #$20
	STA.w !RAM_SMB1_Global_ColorMathSelectAndEnableMirror
	LDA.b #$20
	STA.w !RAM_SMB1_Global_FixedColorData1Mirror
	LDA.b #$40
	STA.w !RAM_SMB1_Global_FixedColorData2Mirror
	LDA.b #$80
	STA.w !RAM_SMB1_Global_FixedColorData3Mirror
	STZ.w !RAM_SMB1_Global_HDMAEnableMirror
	LDA.b #$80
	STA.w !RAM_SMB1_Global_ScreenDisplayRegisterMirror
	STZ.w $0154
	STZ.w !RAM_SMB1_Global_FrameAdvanceDebugActiveFlag
	STZ.w !RAM_SMB1_Global_FadeDirection
	STZ.w !RAM_SMB1_Global_DisplayPauseMenuFlag
	STA.w !RAM_SMB1_Global_CopyOfDisableSpriteOAMResetFlag
	STZ.w $0E67
	STZ.b $BA
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMB1_J) != $00
	STZ.w $1681
endif
	STZ.w $0ED6
	STZ.w $0EF9
	STZ.w $0ED4
	STZ.w !RAM_SMB1_Global_UpdateEntirePaletteFlag
	STZ.w !RAM_SMB1_Global_StripeImageToUpload
	STZ.w $028D
	REP.b #$20
	LDA.w #$0000
	STA.w SMB1_PaletteMirror[$00].LowByte
	STA.w SMB1_PaletteMirror[$80].LowByte
	LDA.w #$FFFF
	STA.w SMB1_StripeImageUploadTable[$00].LowByte
	STA.l $7F0002
	STA.l $7F2002
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	STA.w $1620
endif
	PHD
	LDA.w #DMA[$00].Parameters
	TCD
	LDX.b #$80
	STX.w !REGISTER_VRAMAddressIncrementValue
	REP.b #$20
	LDA.w #$1000
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STA.b DMA[$00].Parameters
	LDA.w #SMB1_UncompressedGFX_FG_GlobalTiles
	STA.b DMA[$00].SourceLo
	LDY.b #SMB1_UncompressedGFX_FG_GlobalTiles>>16
	STY.b DMA[$00].SourceBank
	LDA.w #SMB1_UncompressedGFX_FG_TitleLogo_End-SMB1_UncompressedGFX_FG_GlobalTiles
	STA.b DMA[$00].SizeLo
	LDX.b #$01
	STX.w !REGISTER_DMAEnable
	LDA.w #$6000
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #SMB1_UncompressedGFX_Sprite_GlobalTiles
	STA.b DMA[$00].SourceLo
	LDY.b #SMB1_UncompressedGFX_Sprite_GlobalTiles>>16
	STY.b DMA[$00].SourceBank
	LDA.w #SMB1_UncompressedGFX_Sprite_GlobalTiles_End-SMB1_UncompressedGFX_Sprite_GlobalTiles
	STA.b DMA[$00].SizeLo
	STX.w !REGISTER_DMAEnable
	LDA.w #$5000
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #SMB1_UncompressedGFX_Layer3
	STA.b DMA[$00].SourceLo
	LDY.b #SMB1_UncompressedGFX_Layer3>>16
	STY.b DMA[$00].SourceBank
	LDA.w #$0800
	STA.b DMA[$00].SizeLo
	STX.w !REGISTER_DMAEnable
	PLD
	SEP.b #$20
	JSL.l CODE_0480AE
	STZ.w $1608
	STZ.w $1609
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMB1_J) != $00
	STZ.w $160E
	STZ.w $160F
	STZ.w $160A
	STZ.w $160B
else
	STZ.w $160F
	STZ.w $160E
	STZ.w $160A
endif
	STA.w $160D
	LDA.b #$01
	STA.w $160C
	LDA.b #$81
	STA.b !RAM_SMB1_Global_FrameCounter
	STA.w !REGISTER_IRQNMIAndJoypadEnableFlags
	CLI
CODE_0381A9:
	LDA.w $0154
	BEQ.b CODE_0381A9
	JSL.l SMB1_PollJoypadInputs_Main
	LDA.w !RAM_SMB1_Global_RandomByte1						; Note: RNG routine
	AND.b #$02
	STA.w !RAM_SMB1_Global_RNGRoutineScratchRAM07C7
	LDA.w !RAM_SMB1_Global_RandomByte2
	AND.b #$02
	EOR.w !RAM_SMB1_Global_RNGRoutineScratchRAM07C7
	CLC
	BEQ.b CODE_0381C6
	SEC
CODE_0381C6:
	ROR.w !RAM_SMB1_Global_RandomByte1
	ROR.w !RAM_SMB1_Global_RandomByte2
	ROR.w !RAM_SMB1_Global_RandomByte3
	ROR.w !RAM_SMB1_Global_RandomByte4
	ROR.w !RAM_SMB1_Global_RandomByte5
	ROR.w !RAM_SMB1_Global_RandomByte6
	ROR.w !RAM_SMB1_Global_RandomByte7
	JSL.l CODE_048163
	LDA.l !SRAM_SMAS_Global_EnableSMASDebugModeFlag
	BEQ.b CODE_038205
	PHX
	LDX.w $0EC3
	LDA.w !RAM_SMB1_Global_ControllerPress2P1,x
	AND.b #!Joypad_L
	BEQ.b CODE_0381F3
	INC.w !RAM_SMB1_Global_FrameAdvanceDebugActiveFlag
CODE_0381F3:
	LDA.w !RAM_SMB1_Global_ControllerPress2P1,x
	PLX
	AND.b #!Joypad_R
	BNE.b CODE_038205
	LDA.w !RAM_SMB1_Global_FrameAdvanceDebugActiveFlag
	AND.b #$01
	BEQ.b CODE_038205
	JMP.w CODE_0382D4

CODE_038205:
	JSL.l SMB1_LevelTileAnimations_Main
	JSR.w CODE_038555
	JSL.l CODE_05EE8B
	LDA.b !RAM_SMB1_Level_CurrentLevelType
	BNE.b CODE_038218
	JSL.l CODE_0488BF
CODE_038218:
	LDA.w $0ED6
	BMI.b CODE_03823B
	BEQ.b CODE_03825F
	LDA.w $07B0
	BEQ.b CODE_03825F
	LDX.w !RAM_SMB1_Player_CurrentCharacter
	LDA.w !RAM_SMB1_Global_ControllerPress2P1,x
	BMI.b CODE_038233							; Note: !Joypad_A
	LDA.w !RAM_SMB1_Global_ControllerPress1P1,x
	AND.b #(!Joypad_Start>>8)|(!Joypad_B>>8)
	BEQ.b CODE_03825F
CODE_038233:
	STZ.w $07B0
	STZ.w $0ED6
	BRA.b CODE_03825F

CODE_03823B:
if !Define_Global_ROMToAssemble&(!ROM_SMB1_U|!ROM_SMB1_E|!ROM_SMB1_J) == $00
	LDA.w !RAM_SMB1_Global_ControllerPress2P1
	ORA.w !RAM_SMB1_Global_ControllerPress1P1
	AND.b #!Joypad_X|(!Joypad_Y>>8)
	BNE.b CODE_03824F
	LDA.w !RAM_SMB1_Global_ControllerPress2P2
	ORA.w !RAM_SMB1_Global_ControllerPress1P2
	AND.b #!Joypad_X|(!Joypad_Y>>8)
	BEQ.b CODE_03825F
CODE_03824F:
	LDA.w !RAM_SMB1_Global_ScreenDisplayRegisterMirror
	CMP.b #$0F
	BNE.b CODE_03825F
	LDA.b #!Define_SMB1_LevelMusic_MusicFade
	STA.w !RAM_SMB1_Global_MusicCh1
	JML.l SMAS_ResetToSMASTitleScreen_Main				; Note: Call to SMAS function
endif

CODE_03825F:
	LDA.w !RAM_SMB1_Global_FadeDirection
	BEQ.b CODE_038269
	JSR.w CODE_03C29E
	BRA.b CODE_0382D4

CODE_038269:
	LDA.w !RAM_SMB1_Global_DisplayPauseMenuFlag
	LSR
	BCS.b CODE_0382CD
	PHD
	LDA.b #$0700>>8
	XBA
	LDA.b #$0700
	TCD
	LDA.b !RAM_SMB1_Level_FreezeSpritesTimer
	BEQ.b CODE_03827E
	DEC.b !RAM_SMB1_Level_FreezeSpritesTimer
	BNE.b CODE_038293
CODE_03827E:
	LDX.b #$18
	DEC.b !RAM_SMB1_Global_GenericTimer
	BPL.b CODE_03828A
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDA.b #$11
else
	LDA.b #$14
endif
	STA.b !RAM_SMB1_Global_GenericTimer
	LDX.b #$2B
CODE_03828A:
	LDA.b $0788,x
	BEQ.b CODE_038290
	DEC.b $0788,x
CODE_038290:
	DEX
	BPL.b CODE_03828A
CODE_038293:
	PLD
	LDA.w $07B0
	BNE.b CODE_0382A1
	LDA.w $0ED6
	AND.b #$80
	STA.w $0ED6
CODE_0382A1:
	INC.b !RAM_SMB1_Global_FrameCounter
	INC.w !RAM_SMB1_NorSpr00C_Podoboo_AnimationFrameCounter
	LDA.w !RAM_SMB1_NorSpr00C_Podoboo_AnimationFrameCounter
	AND.b #$18
	CMP.b #$18
	BNE.b CODE_0382B2
	STZ.w !RAM_SMB1_NorSpr00C_Podoboo_AnimationFrameCounter
CODE_0382B2:
	JSL.l SMB1_CheckIfBowserTouchedLava_Main					; Note: This also connects to the palette animation routine.
	LDA.w !RAM_SMB1_Global_CopyOfDisableSpriteOAMResetFlag
	BEQ.b CODE_0382C3
	LDA.b !RAM_SMB1_Global_DisableSpriteOAMResetFlag
	LSR
	BCS.b CODE_0382C3
	JSR.w SMB1_ResetSpriteOAMRt
CODE_0382C3:
	JSR.w SMB1_ProcessGameMode_Main
	LDA.w $1680
	BMI.b CODE_0382CD
	BRA.b CODE_0382D4

CODE_0382CD:
	JSR.w CODE_0385F3
	JSL.l CODE_05DE9D
CODE_0382D4:
	JSL.l SMB1_CompressOAMTileSizeBuffer_Main
	STZ.w $0154
	JMP.w CODE_0381A9

;--------------------------------------------------------------------

DATA_0382DE:
	db SMB1_StripeImageUploadTable[$00].LowByte
	db DATA_0399C5
	db DATA_0399C5
	db DATA_0399C5
	db DATA_0399C5
	db SMB1_StripeImageUploadTable[$00].LowByte
	db $001A02
	db $001A02
	db DATA_0399C5
	db DATA_0399C5
	db DATA_0399C5
	db DATA_0399C5
	db DATA_0399C6
	db DATA_0399EB
	db DATA_039A10
	db DATA_039A63
	db DATA_039A8E
	db DATA_039AC9
	db DATA_039AE8

DATA_0382F1:
	db SMB1_StripeImageUploadTable[$00].LowByte>>8
	db DATA_0399C5>>8
	db DATA_0399C5>>8
	db DATA_0399C5>>8
	db DATA_0399C5>>8
	db SMB1_StripeImageUploadTable[$00].LowByte>>8
	db $001A02>>8
	db $001A02>>8
	db DATA_0399C5>>8
	db DATA_0399C5>>8
	db DATA_0399C5>>8
	db DATA_0399C5>>8
	db DATA_0399C6>>8
	db DATA_0399EB>>8
	db DATA_039A10>>8
	db DATA_039A63>>8
	db DATA_039A8E>>8
	db DATA_039AC9>>8
	db DATA_039AE8>>8

DATA_038304:
	dw $0000,$0300

SMB1_VBlankRoutine:
.Main:
;$038308
if !Define_Global_ROMToAssemble&(!ROM_SMB1_U|!ROM_SMB1_E|!ROM_SMB1_J) != $00
	SEI
	REP.b #$30
	PHA
	PHX
	PHY
	PHD
	LDA.w #!RAM_SMB1_Global_ScratchRAM00
	TCD
	LDA.b !RAM_SMB1_Global_ScratchRAM00
	PHA
	SEP.b #$30
endif
	PHB
	PHK
	PLB
	LDA.w !REGISTER_NMIEnable
	LDA.w !RAM_SMB1_Global_ScreenDisplayRegisterMirror
	BNE.b CODE_038315
	LDA.b #!ScreenDisplayRegister_SetForceBlank
CODE_038315:
	STA.w !REGISTER_ScreenDisplayRegister
	STZ.w !REGISTER_HDMAEnable
	LDA.w $0154
	BEQ.b CODE_038323
	JMP.w CODE_038448

CODE_038323:
	INC.w $0154
	LDX.w !RAM_SMB1_Global_StripeImageToUpload
	LDA.w DATA_0382DE,x
	STA.b $00
	LDA.w DATA_0382F1,x
	STA.b $01
	LDA.b #DATA_0399C5>>16					; Glitch: Changing this will also affect the world 6 toad cutscene!
	STA.b $02
	JSR.w SMB1_UploadStripeImage_Main
	LDX.w !RAM_SMB1_Global_StripeImageToUpload
	CPX.b #$06
	BNE.b CODE_038352
	LDA.w DATA_0382DE
	STA.b $00
	LDA.w DATA_0382F1
	STA.b $01
	LDA.b #DATA_0399C5>>16					; Glitch: Changing this will also affect the world 6 toad cutscene!
	STA.b $02
	JSR.w SMB1_UploadStripeImage_Main
CODE_038352:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	JSR.w CODE_039D6A
endif
	PHD
	LDA.b #DMA[$00].Parameters>>8
	XBA
	LDA.b #DMA[$00].Parameters
	TCD
	REP.b #$10
	LDA.b #$81
	STA.w !REGISTER_VRAMAddressIncrementValue
	LDY.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STY.b DMA[$00].Parameters
	LDA.w $0EF9
	BEQ.b CODE_03839D
	LDA.b #$7F0002>>16
	STA.b DMA[$00].SourceBank
	REP.b #$20
	LDY.w #$0040
	LDX.w #$0000
	LDA.l $7F0002,x
CODE_03837A:
	STA.w !REGISTER_VRAMAddressLo
	TXA
	CLC
	ADC.w #$0004
	STA.b DMA[$00].SourceLo
	STY.b DMA[$00].SizeLo
	TXA
	CLC
	ADC.w #$0042
	TAX
	LDA.w #$0001
	STA.w !REGISTER_DMAEnable
	LDA.l $7F0002,x
	BPL.b CODE_03837A
	SEP.b #$20
	STZ.w $0EF9
CODE_03839D:
	LDA.w $0ED4
	BEQ.b CODE_0383D6
	LDA.b #$7F2002>>16
	STA.b DMA[$00].SourceBank
	REP.b #$20
	LDY.w #$0038
	LDX.w #$0000
	LDA.l $7F2002,x
CODE_0383B2:
	STA.w !REGISTER_VRAMAddressLo
	TXA
	CLC
	ADC.w #$2004
	STA.b DMA[$00].SourceLo
	STY.b DMA[$00].SizeLo
	TXA
	CLC
	ADC.w #$003A
	TAX
	LDA.w #$0001
	STA.w !REGISTER_DMAEnable
	LDA.l $7F2002,x
	BPL.b CODE_0383B2
	STZ.w $2000					; Glitch: Write to open bus.
	STZ.w $0ED4
CODE_0383D6:
	SEP.b #$30
	LDA.b #$80
	STA.w !REGISTER_VRAMAddressIncrementValue
	JSR.w CODE_039B2A
	LDA.w !RAM_SMB1_Global_UpdateEntirePaletteFlag
	BEQ.b CODE_038410
	BMI.b CODE_03840B
	REP.b #$10
	STZ.w !REGISTER_CGRAMAddress
	LDY.w #(!REGISTER_WriteToCGRAMPort&$0000FF<<8)+$00
	STY.b DMA[$00].Parameters
	LDY.w #SMB1_PaletteMirror[$00].LowByte
	STY.b DMA[$00].SourceLo
	LDA.b #SMB1_PaletteMirror[$00].LowByte>>16
	STA.b DMA[$00].SourceBank
	LDY.w #$0200
	STY.b DMA[$00].SizeLo
	LDA.b #$01
	STA.w !REGISTER_DMAEnable
	SEP.b #$10
	STZ.w !RAM_SMB1_Global_UpdateEntirePaletteFlag
	BRA.b CODE_038410

CODE_03840B:
	LDA.b #$01
	STA.w !RAM_SMB1_Global_UpdateEntirePaletteFlag
CODE_038410:
	PLD
	LDY.b #$00
	LDX.w !RAM_SMB1_Global_StripeImageToUpload
	CPX.b #$06
	BNE.b CODE_03841C
	INY
	INY
CODE_03841C:
	REP.b #$20
	LDA.w DATA_038304,y
	REP.b #$10
	TAX
	STZ.w !RAM_SMB1_Global_StripeImageUploadIndexLo,x
	LDA.w #$FFFF
	STA.w SMB1_StripeImageUploadTable[$00].LowByte,x
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	STA.w $1620
endif
	LDA.w #$0000
	STA.l $7F0000
	LDA.w !RAM_SMB1_Level_CurrentLevelType								; Optimization: Unnecessary absolute addressing.
	AND.w #$00FF
	BEQ.b CODE_038443
	LDA.w #$0000
	STA.l $7F2000
CODE_038443:
	SEP.b #$30
	STZ.w !RAM_SMB1_Global_StripeImageToUpload
CODE_038448:
	PHD
	LDA.b #!REGISTER_ScreenDisplayRegister>>8
	XBA
	LDA.b #!REGISTER_ScreenDisplayRegister
	TCD
	LDA.w !RAM_SMB1_Global_Window2LeftPositionDesignationirror
	STA.b !REGISTER_Window2LeftPositionDesignation
	LDA.w !RAM_SMB1_Global_Window2RightPositionDesignationMirror
	STA.b !REGISTER_Window2RightPositionDesignation
	LDA.w $1210
	STA.b !REGISTER_FixedColorData
	LDA.w !RAM_SMB1_Global_ColorMathInitialSettingsMirror
	STA.b !REGISTER_ColorMathInitialSettings
	LDA.w !RAM_SMB1_Global_ColorMathSelectAndEnableMirror
	STA.b !REGISTER_ColorMathSelectAndEnable
	LDA.w !RAM_SMB1_Global_BG1And2WindowMaskSettingsMirror
	STA.b !REGISTER_BG1And2WindowMaskSettings
	LDA.w !RAM_SMB1_Global_BG3And4WindowMaskSettingsMirror
	STA.b !REGISTER_BG3And4WindowMaskSettings
	LDA.w !RAM_SMB1_Global_ObjectAndColorWindowSettingsMirror
	STA.b !REGISTER_ObjectAndColorWindowSettings
	LDA.w !RAM_SMB1_Global_MainScreenLayersMirror
	STA.b !REGISTER_MainScreenLayers
	LDA.w !RAM_SMB1_Global_SubScreenLayersMirror
	STA.b !REGISTER_SubScreenLayers
	LDA.w !RAM_SMB1_Global_MainScreenWindowMaskMirror
	STA.b !REGISTER_MainScreenWindowMask
	LDA.w !RAM_SMB1_Global_SubScreenWindowMaskMirror
	STA.b !REGISTER_SubScreenWindowMask
	LDA.w !RAM_SMB1_Global_FixedColorData1Mirror
	STA.b !REGISTER_FixedColorData
	LDA.w !RAM_SMB1_Global_FixedColorData2Mirror
	STA.b !REGISTER_FixedColorData
	LDA.w !RAM_SMB1_Global_FixedColorData3Mirror
	STA.b !REGISTER_FixedColorData
	LDA.w !RAM_SMB1_Global_BGModeAndTileSizeSettingMirror
	STA.b !REGISTER_BGModeAndTileSizeSetting
	LDA.w !RAM_SMB1_Global_MosaicSizeAndBGEnableMirror
	STA.b !REGISTER_MosaicSizeAndBGEnable
	STZ.b !REGISTER_BG3HorizScrollOffset
	STZ.b !REGISTER_BG3HorizScrollOffset
	LDA.w $0ED1
	BEQ.b CODE_0384B7
	LDA.w !RAM_SMB1_Global_CurrentLayer3XPosLo
	STA.b !REGISTER_BG2HorizScrollOffset
	LDA.w !RAM_SMB1_Global_CurrentLayer3XPosHi
	STA.b !REGISTER_BG2HorizScrollOffset
CODE_0384B7:
	LDA.w !RAM_SMB1_Global_FadeDirection
	BNE.b CODE_0384E6
	LDA.w !RAM_SMB1_Global_CurrentLayer1XPosLo
	STA.b !REGISTER_BG1HorizScrollOffset
	LDA.w !RAM_SMB1_Global_CurrentLayer1XPosHi
	STA.b !REGISTER_BG1HorizScrollOffset
	LDA.w $0ED1
	BNE.b CODE_0384D5
	LDA.w !RAM_SMB1_Global_CurrentLayer2XPosLo
	STA.b !REGISTER_BG2HorizScrollOffset
	LDA.w !RAM_SMB1_Global_CurrentLayer2XPosHi
	STA.b !REGISTER_BG2HorizScrollOffset
CODE_0384D5:
	LDA.w !RAM_SMB1_Global_CurrentLayer1YPosLo
	STA.b !REGISTER_BG1VertScrollOffset
	STZ.b !REGISTER_BG1VertScrollOffset
	LDA.w !RAM_SMB1_Global_CurrentLayer2YPosLo
	STA.b !REGISTER_BG2VertScrollOffset
	LDA.w !RAM_SMB1_Global_CurrentLayer2YPosHi
	STA.b !REGISTER_BG2VertScrollOffset
CODE_0384E6:
	PLD
	LDA.w !RAM_SMB1_Global_HDMAEnableMirror
	STA.w !REGISTER_HDMAEnable
	LDX.b #$81
	LDA.w $0EDE
	BEQ.b CODE_038508
	LDA.w !REGISTER_IRQEnable
	LDA.w !RAM_SMB1_Global_ScanlineToTriggerIRQ
	STA.w !REGISTER_VCountTimerLo
	STZ.w !REGISTER_VCountTimerHi
	STZ.w !REGISTER_HCountTimerLo
	STZ.w !REGISTER_HCountTimerHi
	LDX.b #$A1
CODE_038508:
	STX.w !REGISTER_IRQNMIAndJoypadEnableFlags
	PLB
if !Define_Global_ROMToAssemble&(!ROM_SMB1_U|!ROM_SMB1_E|!ROM_SMB1_J) != $00
	REP.b #$30
	PLA
	STA.w !RAM_SMB1_Global_ScratchRAM00
	PLD
	PLY
	PLX
	PLA
SMB1_VBlankRoutine_EndofVBlank:
	RTI
else
	RTL
endif

;--------------------------------------------------------------------

SMB1_IRQRoutine:
.Main:
;$03850D
if !Define_Global_ROMToAssemble&(!ROM_SMB1_U|!ROM_SMB1_E|!ROM_SMB1_J) != $00
	SEI
	REP.b #$30
	PHA
	PHX
	PHY
	PHD
	LDA.w #!RAM_SMB1_Global_ScratchRAM00
	TCD
	SEP.b #$30
endif
	PHB
	PHK
	PLB
	LDA.w !REGISTER_IRQEnable
	BPL.b CODE_038543
	LDA.w $0EDE
	BEQ.b CODE_038543
	LDA.w $0ED1
	BEQ.b CODE_038532
CODE_03851F:
	BIT.w !REGISTER_HVBlankFlagsAndJoypadStatus
	BVC.b CODE_03851F
	LDA.w !RAM_SMB1_Global_CurrentLayer2XPosLo
	STA.w !REGISTER_BG2HorizScrollOffset
	LDA.w !RAM_SMB1_Global_CurrentLayer2XPosHi
	STA.w !REGISTER_BG2HorizScrollOffset
	BRA.b CODE_038543

CODE_038532:
	BIT.w !REGISTER_HVBlankFlagsAndJoypadStatus
	BVC.b CODE_038532
	LDA.w !RAM_SMB1_Global_CurrentLayer3XPosLo
	STA.w !REGISTER_BG3HorizScrollOffset
	LDA.w !RAM_SMB1_Global_CurrentLayer3XPosHi
	STA.w !REGISTER_BG3HorizScrollOffset
CODE_038543:
	PLB
if !Define_Global_ROMToAssemble&(!ROM_SMB1_U|!ROM_SMB1_E|!ROM_SMB1_J) != $00
	REP.b #$30
	PLD
	PLY
	PLX
	PLA
	RTI
else
	RTL
endif

;--------------------------------------------------------------------

SMB1_ProcessGameMode:
.Main:
;$038545
	LDA.w !RAM_SMB1_Global_GameMode
	ASL
	TAX
	JMP.w (DATA_03854D,x)

DATA_03854D:
	dw SMB1_GameMode00_TitleScreen_Main
	dw SMB1_GameMode01_Level_Main
	dw SMB1_GameMode02_Cutscene_Main
	dw SMB1_GameMode03_GameOverScreen_Main

;--------------------------------------------------------------------

CODE_038555:
	LDA.w !RAM_SMB1_Global_GameMode
	CMP.b #$02
	BEQ.b CODE_03857B
	CMP.b #$01
	BNE.b CODE_0385BE
	LDA.w $0772
	CMP.b #$03
	BNE.b CODE_0385BE
	LDA.w $0E67
	BNE.b CODE_0385BE
	LDA.w !RAM_SMB1_Global_ScreenDisplayRegisterMirror
	CMP.b #$0F
	BNE.b CODE_0385BE
	LDA.w $0777
	BEQ.b CODE_03857C
	DEC.w $0777
CODE_03857B:
	RTS

CODE_03857C:
	LDA.b !RAM_SMB1_Player_CurrentState
	CMP.b #$02
	BEQ.b CODE_0385BE
	CMP.b #$03
	BEQ.b CODE_0385BE
	LDA.w $0B7A
	BNE.b CODE_0385BE
	LDA.w $0B75
	CMP.b #$02
	BCS.b CODE_0385BE
	LDA.w $0F8A
	BEQ.b CODE_03859C
	DEC.w $0F8A
	BRA.b CODE_0385BE

CODE_03859C:
	LDA.w $0B75
	BNE.b CODE_0385BE
	LDY.w !RAM_SMB1_Player_CurrentCharacter
	LDA.w !RAM_SMB1_Global_ControllerPress1P1,y
	AND.b #!Joypad_Start>>8
	BEQ.b CODE_0385BE
	LDA.b #$11
	STA.w $0777
	LDA.b #!Define_SMB1_LevelMusic_LowerVolumeCommand
	STA.w !RAM_SMB1_Global_MusicCh1
	LDA.b #!Define_SMAS_Sound0060_Pause1
	STA.w !RAM_SMB1_Global_SoundCh1
	JSL.l CODE_05DE82
CODE_0385BE:
	RTS

;--------------------------------------------------------------------

CODE_0385BF:
	JSR.w CODE_0385F8
	RTL

SMB1_ResetSpriteOAMRt:
.Main:
	PHD
	LDA.b #!RAM_SMB1_Level_SpriteOAMIndexTable>>8
	XBA
	LDA.b #!RAM_SMB1_Level_SpriteOAMIndexTable&$00
	TCD
	LDA.b #$90
	STA.b !RAM_SMB1_Level_SpriteOAMIndexTable+$1D
	LDA.b #$94
	STA.b !RAM_SMB1_Level_SpriteOAMIndexTable+$1E
	LDA.b #$98
	STA.b !RAM_SMB1_Level_SpriteOAMIndexTable+$1F
	LDA.b #$9C
	STA.b !RAM_SMB1_Level_SpriteOAMIndexTable+$20
	LDA.b #$A0
	STA.b !RAM_SMB1_Level_SpriteOAMIndexTable+$21
	LDA.b #$A4
	STA.b !RAM_SMB1_Level_SpriteOAMIndexTable+$22
	LDA.b #$A8
	STA.b !RAM_SMB1_Level_SpriteOAMIndexTable+$23
	LDA.b #$AC
	STA.b !RAM_SMB1_Level_SpriteOAMIndexTable+$24
	LDA.b #$58
	STA.b !RAM_SMB1_Level_SpriteOAMIndexTable+$25
	PLD
	LDA.b $96
	BNE.b CODE_038635
CODE_0385F3:
	LDA.w $0E67
	BNE.b CODE_03866C
CODE_0385F8:
	LDX.b #$00
	LDA.b #$F0
CODE_0385FC:
	STA.w SMB1_OAMBuffer[$00].YDisp,x
	STA.w SMB1_OAMBuffer[$10].YDisp,x
	STA.w SMB1_OAMBuffer[$20].YDisp,x
	STA.w SMB1_OAMBuffer[$30].YDisp,x
	STA.w SMB1_OAMBuffer[$40].YDisp,x
	STA.w SMB1_OAMBuffer[$50].YDisp,x
	STA.w SMB1_OAMBuffer[$60].YDisp,x
	STA.w SMB1_OAMBuffer[$70].YDisp,x
	STZ.w SMB1_OAMTileSizeBuffer[$00].Slot,x
	STZ.w SMB1_OAMTileSizeBuffer[$10].Slot,x
	STZ.w SMB1_OAMTileSizeBuffer[$20].Slot,x
	STZ.w SMB1_OAMTileSizeBuffer[$30].Slot,x
	STZ.w SMB1_OAMTileSizeBuffer[$40].Slot,x
	STZ.w SMB1_OAMTileSizeBuffer[$50].Slot,x
	STZ.w SMB1_OAMTileSizeBuffer[$60].Slot,x
	STZ.w SMB1_OAMTileSizeBuffer[$70].Slot,x
	INX
	INX
	INX
	INX
	CPX.b #$40
	BNE.b CODE_0385FC
	RTS

CODE_038635:
	LDX.b #$00
	LDA.b #$F0
CODE_038639:
	STA.w SMB1_OAMBuffer[$10].YDisp,x
	STA.w SMB1_OAMBuffer[$20].YDisp,x
	STA.w SMB1_OAMBuffer[$30].YDisp,x
	STA.w SMB1_OAMBuffer[$40].YDisp,x
	STA.w SMB1_OAMBuffer[$50].YDisp,x
	STA.w SMB1_OAMBuffer[$60].YDisp,x
	STA.w SMB1_OAMBuffer[$70].YDisp,x
	STZ.w SMB1_OAMTileSizeBuffer[$10].Slot,x
	STZ.w SMB1_OAMTileSizeBuffer[$20].Slot,x
	STZ.w SMB1_OAMTileSizeBuffer[$30].Slot,x
	STZ.w SMB1_OAMTileSizeBuffer[$40].Slot,x
	STZ.w SMB1_OAMTileSizeBuffer[$50].Slot,x
	STZ.w SMB1_OAMTileSizeBuffer[$60].Slot,x
	STZ.w SMB1_OAMTileSizeBuffer[$70].Slot,x
	INX
	INX
	INX
	INX
	CPX.b #$40
	BNE.b CODE_038639
	RTS

CODE_03866C:
	LDA.b #$F0
	STA.w SMB1_OAMBuffer[$14].YDisp
	STA.w SMB1_OAMBuffer[$15].YDisp
	STA.w SMB1_OAMBuffer[$2C].YDisp
	STA.w SMB1_OAMBuffer[$2D].YDisp
	STA.w SMB1_OAMBuffer[$2E].YDisp
	STA.w SMB1_OAMBuffer[$2F].YDisp
	STA.w SMB1_OAMBuffer[$30].YDisp
	STA.w SMB1_OAMBuffer[$31].YDisp
	STA.w SMB1_OAMBuffer[$32].YDisp
	STA.w SMB1_OAMBuffer[$33].YDisp
	RTS

if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMB1_J) != $00
UNK_038688:
	JSR.w CODE_0385F3
	RTL
endif

;--------------------------------------------------------------------

SMB1_GameMode00_TitleScreen:
.Main:
;$03868D
	LDA.w !RAM_SMB1_TitleScreen_CurrentState
	ASL
	TAX
	JSR.w (DATA_0386AC,x)
if !Define_Global_ROMToAssemble&(!ROM_SMB1_U|!ROM_SMB1_E|!ROM_SMB1_J) == $00
	LDA.l !SRAM_SMAS_Global_RunningDemoFlag
	BEQ.b CODE_0386A8
	STZ.w !RAM_SMB1_Global_SoundCh1
	STZ.w !RAM_SMB1_Global_SoundCh2
	STZ.w !RAM_SMB1_Global_MusicCh1
	STZ.w !RAM_SMB1_Global_SoundCh3
	RTS

CODE_0386A8:
endif
	STZ.w !RAM_SMB1_Global_MusicCh1
	RTS

DATA_0386AC:
	dw CODE_039D91
	dw CODE_038C25
	dw CODE_039EBA
	dw CODE_0386B4

;--------------------------------------------------------------------

CODE_0386B4:
	LDA.l !SRAM_SMAS_Global_Controller1PluggedInFlag
	BNE.b CODE_0386D9
	LDA.l !SRAM_SMAS_Global_Controller2PluggedInFlag
	BEQ.b CODE_0386D9
	LDA.w !RAM_SMB1_Global_ControllerPress1P2
	AND.b #!Joypad_Start>>8
	BEQ.b CODE_0386D9
	LDA.w !RAM_SMB1_TitleScreen_MenuSelectionIndex
	BNE.b CODE_0386E3
	LDA.w !RAM_SMB1_TitleScreen_WaitBeforePlayingDemo
	BEQ.b CODE_0386E3
	LDA.b #!Define_SMAS_Sound0063_Wrong
	STA.w !RAM_SMB1_Global_SoundCh3
	JMP.w CODE_0387A1

CODE_0386D9:
	LDA.w !RAM_SMB1_Global_ControllerPress1P1
	ORA.w !RAM_SMB1_Global_ControllerPress1P2
	BIT.b #!Joypad_Start>>8
	BEQ.b CODE_03871A
CODE_0386E3:
if !Define_Global_ROMToAssemble&(!ROM_SMB1_U|!ROM_SMB1_E|!ROM_SMB1_J) != $00
	JSR.w CODE_03AD74
endif
	JMP.w CODE_0387D3

CODE_0386E6:							; Note: Some code that resets the high score.
	LDA.b #$00
	STA.l !SRAM_SMB1_Global_TopScoreMillionsDigit
	STA.l !SRAM_SMB1_Global_TopScoreHundredThousandsDigit
	STA.l !SRAM_SMB1_Global_TopScoreTenThousandsDigit
	STA.l !SRAM_SMB1_Global_TopScoreThousandsDigit
	STA.l !SRAM_SMB1_Global_TopScoreHundredsDigit
	STA.l !SRAM_SMB1_Global_TopScoreTensDigit
	STA.w !RAM_SMB1_TitleScreen_TopScoreMillionsDigit
	STA.w !RAM_SMB1_TitleScreen_TopScoreHundredThousandsDigit
	STA.w !RAM_SMB1_TitleScreen_TopScoreTenThousandsDigit
	STA.w !RAM_SMB1_TitleScreen_TopScoreThousandsDigit
	STA.w !RAM_SMB1_TitleScreen_TopScoreHundredsDigit
	STA.w !RAM_SMB1_TitleScreen_TopScoreTensDigit
	LDA.b #!Define_SMAS_Sound0060_EchoSpinJumpKill
	STA.w !RAM_SMB1_Global_SoundCh1
	JMP.w CODE_0387C1

CODE_03871A:
if !Define_Global_ROMToAssemble&(!ROM_SMB1_U|!ROM_SMB1_E|!ROM_SMB1_J) == $00
	LDA.l !SRAM_SMAS_Global_RunningDemoFlag
	BNE.b CODE_038753
endif
	LDA.w !RAM_SMB1_Global_ControllerHold2P1
	CMP.b #!Joypad_A|!Joypad_L|!Joypad_R
	BNE.b CODE_03872E
	LDA.w !RAM_SMB1_Global_ControllerHold1P1
	CMP.b #!Joypad_B>>8
	BEQ.b CODE_0386E6
CODE_03872E:
	LDA.w !RAM_SMB1_Global_ControllerHold2P2
	CMP.b #!Joypad_A|!Joypad_L|!Joypad_R
	BNE.b CODE_03873C
	LDA.w !RAM_SMB1_Global_ControllerHold1P2
	CMP.b #!Joypad_B>>8
	BEQ.b CODE_0386E6
CODE_03873C:
	LDA.l !RAM_SMB1_Global_SaveBuffer_2PlayerFlag
	BMI.b CODE_038749
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDA.b #$38
else
	LDA.b #$40
endif
	STA.w !RAM_SMB1_TitleScreen_WaitBeforePlayingDemo
if !Define_Global_ROMToAssemble&(!ROM_SMB1_U|!ROM_SMB1_E|!ROM_SMB1_J) == $00
	BRA.b CODE_0387A4
endif

CODE_038749:
if !Define_Global_ROMToAssemble&(!ROM_SMB1_U|!ROM_SMB1_E|!ROM_SMB1_J) != $00
	LDX.w !RAM_SMB1_TitleScreen_WaitBeforePlayingDemo
	BEQ.b +
	JSR.w CODE_038861
+:
endif
	LDA.w !RAM_SMB1_Global_ControllerPress1P1
	ORA.w !RAM_SMB1_Global_ControllerPress1P2
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMB1_J) != $00
	BIT.b #(!Joypad_DPadU>>8)|(!Joypad_DPadD>>8)|(!Joypad_Select>>8)|(!Joypad_B>>8)
else
	BIT.b #(!Joypad_DPadU>>8)|(!Joypad_DPadD>>8)|(!Joypad_Select>>8)
endif
	BNE.b CODE_03875F
CODE_038753:
	LDX.w !RAM_SMB1_TitleScreen_WaitBeforePlayingDemo
	BNE.b CODE_0387A4
	JSR.w CODE_038883
	BCS.b CODE_0387C1
	BRA.b CODE_0387A7

CODE_03875F:								; Note: Code that moves the title screen menu cursor.
if !Define_Global_ROMToAssemble&(!ROM_SMB1_U|!ROM_SMB1_E|!ROM_SMB1_J) != $00
	LDY.w !RAM_SMB1_TitleScreen_WaitBeforePlayingDemo
	BEQ.b CODE_0387C1
	LDY.b #$18
	STY.w !RAM_SMB1_TitleScreen_WaitBeforePlayingDemo
	JSL.l SMB1_MoveTitleScreenMenuCursor_Main
else
	LDA.w !RAM_SMB1_TitleScreen_WaitBeforePlayingDemo
	BEQ.b CODE_0387C1
	LDA.b #$18
	STA.w !RAM_SMB1_TitleScreen_WaitBeforePlayingDemo
	LDA.l !RAM_SMB1_Global_SaveBuffer_2PlayerFlag
	BMI.b CODE_038774
	STA.w !RAM_SMB1_TitleScreen_MenuSelectionIndex
	BRA.b CODE_0387A1

CODE_038774:
	LDA.l !SRAM_SMAS_Global_RunningDemoFlag
	BNE.b CODE_0387A4
	LDA.w !RAM_SMB1_Global_ControllerPress1P1
	ORA.w !RAM_SMB1_Global_ControllerPress1P2
	BIT.b #!Joypad_Select>>8
	BEQ.b CODE_03878B
	LDA.w !RAM_SMB1_TitleScreen_MenuSelectionIndex
	EOR.b #$01
	BRA.b CODE_038799

CODE_03878B:
	AND.b #(!Joypad_DPadU>>8)|(!Joypad_DPadD>>8)
	BEQ.b CODE_0387A1
	EOR.b #!Joypad_DPadU>>8
	LSR
	LSR
	LSR
	CMP.w !RAM_SMB1_TitleScreen_MenuSelectionIndex
	BEQ.b CODE_0387A1
CODE_038799:
	STA.w !RAM_SMB1_TitleScreen_MenuSelectionIndex
	LDA.b #!Define_SMAS_Sound0063_Coin
	STA.w !RAM_SMB1_Global_SoundCh3
endif
CODE_0387A1:
if !Define_Global_ROMToAssemble&(!ROM_SMB1_U|!ROM_SMB1_E|!ROM_SMB1_J) == $00
	JSR.w CODE_038861
endif
CODE_0387A4:
	STZ.w !RAM_SMB1_Global_ControllerHold1P1
if !Define_Global_ROMToAssemble&(!ROM_SMB1_U|!ROM_SMB1_E|!ROM_SMB1_J) != $00
	LDA.w !RAM_SMB1_Global_ControllerPress1P1
	ORA.w !RAM_SMB1_Global_ControllerPress2P1
	PHA
	LDA.b !RAM_SMB1_TitleScreen_FileSelectProcess
	ORA.b !RAM_SMB1_TitleScreen_EraseFileProcess
	BNE.b +
	PLA
	AND.b #(!Joypad_DPadL>>8)|(!Joypad_DPadR>>8)|(!Joypad_B>>8)
	BEQ.b ++
	JSL.l SMB1_ChangeSelectedWorld_Main
	LDY.b #$18
	STY.w !RAM_SMB1_TitleScreen_WaitBeforePlayingDemo
	BRA.b ++

+:
	PLA
	AND.b #!Joypad_X|(!Joypad_Y>>8)
	BEQ.b +++
	LDY.b #$18
	STY.w !RAM_SMB1_TitleScreen_WaitBeforePlayingDemo
	LDA.b !RAM_SMB1_TitleScreen_FileSelectProcess
	BNE.b +
+++:
	BRA.b ++

+:
	STZ.b !RAM_SMB1_TitleScreen_FileSelectProcess
	JSL.l SMB1_LoadFileSelectMenu_Main
	STZ.w !RAM_SMB1_TitleScreen_MenuSelectionIndex
	LDA.b #$FF
	STA.l !RAM_SMB1_Global_SaveBuffer_2PlayerFlag
++:
endif
CODE_0387A7:
	LDA.w !RAM_SMB1_Global_SoundCh3
	PHA
	JSR.w CODE_03AD74
	STZ.w !RAM_SMB1_Global_SoundCh1
	STZ.w !RAM_SMB1_Global_SoundCh2
	PLA
	STA.w !RAM_SMB1_Global_SoundCh3
	LDA.b !RAM_SMB1_Player_CurrentState
	CMP.b #$06
if !Define_Global_ROMToAssemble&(!ROM_SMB1_U|!ROM_SMB1_E|!ROM_SMB1_J) != $00
	BEQ.b +
	RTS

+:
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMB1_J) != $00
	BNE.b CODE_0387D2
else
	BNE.b CODE_038839
endif
	STZ.w $0EC8
CODE_0387C1:
	STZ.w !RAM_SMB1_Global_GameMode
	STZ.w $0772
	STZ.w !RAM_SMB1_Global_CopyOfDisableSpriteOAMResetFlag
	LDA.b #$01
	STA.w !RAM_SMB1_Global_FadeDirection
	INC.w $0774
CODE_0387D2:
	RTS

CODE_0387D3:
	LDY.w !RAM_SMB1_TitleScreen_WaitBeforePlayingDemo
	BEQ.b CODE_0387C1
	LDA.b #!Define_SMAS_Sound0063_Correct
	STA.w !RAM_SMB1_Global_SoundCh3
if !Define_Global_ROMToAssemble&(!ROM_SMB1_U|!ROM_SMB1_E|!ROM_SMB1_J) != $00
	LDY.b #$18
	STY.w !RAM_SMB1_TitleScreen_WaitBeforePlayingDemo
	LDA.b !RAM_SMB1_TitleScreen_FileSelectProcess
	BNE.b +
	LDA.w !RAM_SMB1_TitleScreen_MenuSelectionIndex
	CMP.b #$03
	BNE.b ++
	LDA.b !RAM_SMB1_TitleScreen_EraseFileProcess
	EOR.b #$01
	STA.b !RAM_SMB1_TitleScreen_EraseFileProcess
	JSL.l SMB1_LoadFileSelectMenu_Entry2
	RTS

++:
	LDA.b !RAM_SMB1_TitleScreen_EraseFileProcess
	BEQ.b +++
	JSL.l SMB1_ClearSaveData_Main
	JSL.l SMB1_LoadFileSelectMenu_Entry2
	LDA.b #!Define_SMAS_Sound0063_1up
	STA.w !RAM_SMB1_Global_SoundCh3
	RTS

+++:
	INC.b !RAM_SMB1_TitleScreen_FileSelectProcess
	LDX.w !RAM_SMB1_TitleScreen_MenuSelectionIndex
	LDA.b !RAM_SMB1_TitleScreen_FileASelectedWorld,x
	STA.l !SRAM_SMAS_Global_InitialSelectedWorld
	LDA.b #$00
	STA.l !SRAM_SMAS_Global_InitialSelectedLevel
	JSL.l SMB1_LoadSaveFileData_Main
-:
	LDA.b !RAM_SMB1_TitleScreen_FileSelectProcess
	BNE.b ++
	JSL.l SMB1_LoadFileSelectMenu_Main
	RTS

++:
	JSL.l SMB1_LoadPlayerSelectMenu_Main
	RTS

+:
	LDX.w !RAM_SMB1_TitleScreen_MenuSelectionIndex
	CPX.b #$02
	BNE.b +
	LDA.l !SRAM_SMAS_Global_ControllerTypeX
	EOR.b #$01
	AND.b #$01
	STA.l !SRAM_SMAS_Global_ControllerTypeX
	LDA.b #!Define_SMAS_Sound0063_Coin
	STA.w !RAM_SMB1_Global_SoundCh3
	JSL.l SMB1_LoadPlayerSelectMenu_Entry2
	RTS

+:
endif
	LDA.l !SRAM_SMAS_Global_InitialSelectedWorld
	JSR.w CODE_038846
	LDA.b #$01
	STA.w $0E67
	JSR.w CODE_03F710
	JSL.l CODE_04C00B
	INC.w !RAM_SMB1_Level_CanFindHidden1upFlag
	INC.w $0764
	INC.w $0757
	INC.w !RAM_SMB1_Global_GameMode
	LDA.w !RAM_SMB1_Player_HardModeActiveFlag
	STA.w !RAM_SMB1_Global_UseHardModeEnemyBehaviorFlag
	STZ.w $0772
	STZ.w !RAM_SMB1_TitleScreen_WaitBeforePlayingDemo
	LDX.b #$0B
	LDA.b #$00
CODE_03880C:
	STA.w $07DA,x
	DEX
	BPL.b CODE_03880C
	PHX
	STZ.b !RAM_SMB1_Global_ScratchRAME4
	LDA.w !RAM_SMB1_Player_CurrentCoinCount
	JSR.w CODE_03883A
	STA.w $07DF
	LDA.b !RAM_SMB1_Global_ScratchRAME4
	STA.w $07DE
	STZ.b !RAM_SMB1_Global_ScratchRAME4
	LDA.w $06BB
	JSR.w CODE_03883A
	STA.w $07E5
	LDA.b !RAM_SMB1_Global_ScratchRAME4
	STA.w $07E4
	LDA.b #$01
	STA.w $0E1A
	PLX
CODE_038839:
	RTS

CODE_03883A:
	CMP.b #$0A
	BCC.b CODE_038845
	INC.b !RAM_SMB1_Global_ScratchRAME4
	SEC
	SBC.b #$0A
	BRA.b CODE_03883A

CODE_038845:
	RTS

CODE_038846:
	STA.w !RAM_SMB1_Player_CurrentWorld
	STA.w !RAM_SMB1_Player_OtherPlayersWorld
	PHA
	JSL.l CODE_05C95B
	PLA
	RTS

;--------------------------------------------------------------------

; Note: Routine that draws the title screen menu cursor.

TitleScreenMenuCursorStripeImage:
;$038853
	dw TitleScreenMenuCursorStripeImage_End-TitleScreenMenuCursorStripeImage

if !Define_Global_ROMToAssemble&(!ROM_SMB1_U|!ROM_SMB1_E|!ROM_SMB1_J) != $00
	db $02,$49,$80,$0D
	db $24,$10,$24,$10,$24,$10,$24,$10,$24,$10,$24,$10,$24,$10

else
	db $02,$49,$80,$05
	db $2E,$12,$24,$10,$24,$10
endif
.End:
	db $FF,$FF


CODE_038861:
	REP.b #$20
	LDY.b #TitleScreenMenuCursorStripeImage_End-TitleScreenMenuCursorStripeImage
CODE_038865:
	LDA.w TitleScreenMenuCursorStripeImage,y
	STA.w !RAM_SMB1_Global_StripeImageUploadIndexLo,y
	DEY
	DEY
	BPL.b CODE_038865
	LDY.w !RAM_SMB1_TitleScreen_MenuSelectionIndex
if !Define_Global_ROMToAssemble&(!ROM_SMB1_U|!ROM_SMB1_E|!ROM_SMB1_J) != $00
	TYA
	ASL
	ASL
	TAY
	LDA.w #$122E
	STA.w SMB1_StripeImageUploadTable[$02].LowByte,y
	DEC.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	DEC.w !RAM_SMB1_Global_StripeImageUploadIndexLo
else
	BEQ.b CODE_038880
	LDA.w #$1024
	STA.w SMB1_StripeImageUploadTable[$02].LowByte
	LDA.w #$122E
	STA.w SMB1_StripeImageUploadTable[$04].LowByte
CODE_038880:
endif
	SEP.b #$20
	RTS

;--------------------------------------------------------------------

; Note: Title screen demo related?

CODE_038883:
	LDX.w $0717
	LDA.w $0718
	BNE.b CODE_0388A4
	INX
	INC.w $0717
	SEC
	LDA.w $07FB
	BEQ.b CODE_03889B
	LDA.l DATA_05EE72,x
	BRA.b CODE_03889F

CODE_03889B:
	LDA.l DATA_05EE45,x
CODE_03889F:
	STA.w $0718
	BEQ.b CODE_0388BA
CODE_0388A4:
	LDA.w $07FB
	BEQ.b CODE_0388AF
	LDA.l DATA_05EE5B,x
	BRA.b CODE_0388B3

CODE_0388AF:
	LDA.l DATA_05EE30,x
CODE_0388B3:
	STA.w !RAM_SMB1_Global_ControllerHold1P1
	DEC.w $0718
	CLC
CODE_0388BA:
	RTS

;--------------------------------------------------------------------

SMB1_GameMode02_Cutscene:
.Main:
;$0388BB
	JSR.w CODE_0388D0
	LDA.w !RAM_SMB1_Cutscene_CurrentState
	BEQ.b CODE_0388CA
	LDX.b #$00
	STX.b $9E
	JSR.w CODE_03C3B0
CODE_0388CA:
	JSR.w CODE_03FD13
	JMP.w CODE_03F710

CODE_0388D0:
	LDA.w $1680
	BNE.b CODE_0388E4
	LDA.w !RAM_SMB1_Player_CurrentWorld
	CMP.b #$07
	BEQ.b CODE_0388E4
	LDA.w !RAM_SMB1_Cutscene_CurrentState
	ASL
	TAX
	JMP.w (DATA_0388EC,x)

CODE_0388E4:
	LDA.w !RAM_SMB1_Cutscene_CurrentState
	ASL
	TAX
	JMP.w (DATA_0388FA,x)

DATA_0388EC:
	dw SMB1_ToadCutscene_State00_BridgeDestruction_Main
	dw SMB1_ToadCutscene_State01_LoadToadGraphics_Main
	dw SMB1_ToadCutscene_State02_WalkRight_Main
	dw SMB1_ToadCutscene_State03_WaitForToadToBreakOutOfBag_Main
	dw SMB1_ToadCutscene_State04_SayFamousLine_Main
	dw SMB1_ToadCutscene_State05_AddTimerToScore_Main
	dw SMB1_ToadCutscene_State06_WaitBeforeFadeOut_Main

DATA_0388FA:									; Note: For some reason, SMAS+W added one of these pointers...
	dw SMB1_PeachCutscene_State00_BridgeDestruction_Main
	dw SMB1_PeachCutscene_State01_LoadPeachGraphics_Main
	dw SMB1_PeachCutscene_State02_WalkRight_Main
	dw SMB1_PeachCutscene_State03_CheckIfPlayerIsSmall_Main
	dw SMB1_PeachCutscene_State04_WaitForPlayerToFinishGrowing_Main
	dw SMB1_PeachCutscene_State05_AddTimerToScore_Main
	dw SMB1_PeachCutscene_State06_PreparePeachToStandUp_Main
	dw SMB1_PeachCutscene_State07_PeachRunsTowardsPlayer_Main
	dw SMB1_PeachCutscene_State08_InitializeCloseupImage_Main
	dw SMB1_PeachCutscene_State09_ProcessCloseupImage_Main
	dw SMB1_PeachCutscene_State0A_UnusedState_Main
	dw SMB1_PeachCutscene_State0B_UnusedState_Main
	dw SMB1_PeachCutscene_State0C_FinishCutscene_Main
	dw SMB1_PeachCutscene_State0D_InitializePauseMenu_Main
	dw SMB1_PeachCutscene_State0E_ProcessPauseMenu_Main
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_J1) == $00
	dw SMB1_PeachCutscene_State0F_FadeOut_Main
endif

;--------------------------------------------------------------------

SMB1_PeachCutscene_State03_CheckIfPlayerIsSmall:
.Main:
;$03891A
	LDA.w !RAM_SMB1_Player_CurrentSize
	BEQ.b CODE_038927
	JSL.l SMB1_SpawnMushroomDuringPeachCutscene_Main
	INC.w !RAM_SMB1_Cutscene_CurrentState
	RTS

CODE_038927:
	INC.w !RAM_SMB1_Cutscene_CurrentState
	INC.w !RAM_SMB1_Cutscene_CurrentState
	RTS

;--------------------------------------------------------------------

SMB1_PeachCutscene_State04_WaitForPlayerToFinishGrowing:
.Main:
;$03892E
	STZ.w !RAM_SMB1_Global_ControllerHold1P1
	STZ.w !RAM_SMB1_Global_ControllerPress1P1
	STZ.w !RAM_SMB1_Global_ControllerHold1P2
	STZ.w !RAM_SMB1_Global_ControllerPress1P2
	STZ.w !RAM_SMB1_Global_ControllerHold2P1
	STZ.w !RAM_SMB1_Global_ControllerHold2P2
	STZ.w !RAM_SMB1_Global_ControllerPress2P1
	STZ.w !RAM_SMB1_Global_ControllerPress2P2
	LDA.b #$02
	STA.w !RAM_SMB1_Level_WaitBeforeDecrementingTimer
	JSR.w CODE_03AD70
	LDA.w !RAM_SMB1_Player_CurrentSize
	BNE.b CODE_038956
	INC.w !RAM_SMB1_Cutscene_CurrentState
CODE_038956:
	RTS

;--------------------------------------------------------------------

SMB1_PeachCutscene_State06_PreparePeachToStandUp:
.Main:
;$038957
	INC.w !RAM_SMB1_Cutscene_CurrentState
	INC.w !RAM_SMB1_Cutscene_PeachCurrentState
	RTS

;--------------------------------------------------------------------

SMB1_PeachCutscene_State07_PeachRunsTowardsPlayer:
.Main:
;$03895E
	JSL.l SMB1_ProcessPeachMovement_Main
	LDA.w !RAM_SMB1_Cutscene_PeachCurrentState
	CMP.b #$06
	BCC.b CODE_03896C
	INC.w !RAM_SMB1_Cutscene_CurrentState
CODE_03896C:
	RTS

;--------------------------------------------------------------------

SMB1_PeachCutscene_State08_InitializeCloseupImage:
.Main:
;$03896D
	LDA.b #!Define_SMB1_LevelMusic_SMB1PeachRescued
	STA.w !RAM_SMB1_Global_MusicCh1
	JSL.l CODE_04D860
	JSL.l CODE_05DE63
	INC.w !RAM_SMB1_Cutscene_CurrentState
	RTS

;--------------------------------------------------------------------

SMB1_PeachCutscene_State09_ProcessCloseupImage:
.Main:
;$03897E
	JSL.l SMB1_PeachCutscene_State09_ProcessCloseupImage_Bank04
	RTS

;--------------------------------------------------------------------

SMB1_PeachCutscene_State0A_UnusedState:
.Main:
;$038983
	INC.w !RAM_SMB1_Cutscene_CurrentState
	RTS

;--------------------------------------------------------------------

SMB1_PeachCutscene_State0B_UnusedState:
.Main:
;$038987
	INC.w !RAM_SMB1_Cutscene_CurrentState
	RTS

;--------------------------------------------------------------------

if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_J1) == $00
SMB1_PeachCutscene_State0F_FadeOut:
.Main:
;$03898B
	DEC.w !RAM_SMB1_Global_ScreenDisplayRegisterMirror
	BNE.b CODE_038995
	LDA.b #$0C
	STA.w $0772
CODE_038995:
	RTS
endif

;--------------------------------------------------------------------

SMB1_PeachCutscene_State0D_InitializePauseMenu:
.Main:
;$038996
	JSL.l CODE_04862A
	RTS

;--------------------------------------------------------------------

SMB1_PeachCutscene_State0E_ProcessPauseMenu:
.Main:
;$03899B
	JSL.l CODE_048640
	RTS

;--------------------------------------------------------------------

SMB1_ToadCutscene_State05_AddTimerToScore:
.Main:
SMB1_PeachCutscene_State05_AddTimerToScore:
.Main:
;$0389A0
	LDA.w $07B1
	CMP.b #$06
	BCS.b CODE_0389D8
	LDA.w !REGISTER_APUPort3
	AND.b #$7F
	CMP.b #!Define_SMAS_Sound0063_AddTimerToScore
	BEQ.b CODE_0389B5
	LDA.b #!Define_SMAS_Sound0063_AddTimerToScore
	STA.w !RAM_SMB1_Global_SoundCh3
CODE_0389B5:
	JSR.w CODE_03D809
	LDA.w !RAM_SMB1_Level_TimerHundreds
	ORA.w !RAM_SMB1_Level_TimerTens
	ORA.w !RAM_SMB1_Level_TimerOnes
	BNE.b CODE_0389D8
	LDA.b #!Define_SMAS_Sound0063_FinishAddTimerToScore
	STA.w !RAM_SMB1_Global_SoundCh3
	STA.w $0E1A
	LDA.b #$30
	STA.w $0788
	LDA.b #$06
	STA.w $07B1
	INC.w !RAM_SMB1_Cutscene_CurrentState
CODE_0389D8:
	RTS

;--------------------------------------------------------------------

SMB1_PeachCutscene_State01_LoadPeachGraphics:
.Main:
;$0389D9
	JSL.l CODE_04DE54
	BRA.b CODE_0389E8

SMB1_ToadCutscene_State01_LoadToadGraphics:
.Main:
	LDA.w $0B76
	BEQ.b CODE_0389F2
	JSL.l CODE_04ED07
CODE_0389E8:
	LDX.w $071B
	INX
	STX.w !RAM_SMB1_Cutscene_MaxXPosHi
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	STZ.w $0705
	STZ.w !RAM_SMB1_Player_XSpeed
endif
	JMP.w CODE_038F23

CODE_0389F2:
	JSL.l CODE_04ECCA
	RTS

;--------------------------------------------------------------------

SMB1_ToadCutscene_State02_WalkRight:
.Main:
SMB1_PeachCutscene_State02_WalkRight:
.Main:
;$0389F7
	LDA.b $96
	BEQ.b CODE_0389FC
	RTS

CODE_0389FC:
	LDA.w $0F82
	BEQ.b CODE_038A05
	JSL.l CODE_04DD55
CODE_038A05:
	LDY.b #$00
	STY.w !RAM_SMB1_Cutscene_CanScrollFlag
	LDA.b !RAM_SMB1_Player_XPosHi
	CMP.w !RAM_SMB1_Cutscene_MaxXPosHi
	BNE.b CODE_038A35
	LDA.w !RAM_SMB1_Player_CurrentWorld
	CMP.b #$07
	BNE.b CODE_038A21
	INC.w !RAM_SMB1_Cutscene_CanScrollFlag
	JSL.l CODE_04DBDA
	BRA.b CODE_038A39

CODE_038A21:
	CMP.b #$02
	BNE.b CODE_038A2E
	LDA.w !RAM_SMB1_Player_XPosLo
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	CMP.b #$4C
else
	CMP.b #$44
endif
	BCS.b CODE_038A39
	BRA.b CODE_038A35

CODE_038A2E:
	LDA.w !RAM_SMB1_Player_XPosLo
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	CMP.b #$5C
else
	CMP.b #$54
endif
	BCS.b CODE_038A39
CODE_038A35:
	INC.w !RAM_SMB1_Cutscene_CanScrollFlag
	INY
CODE_038A39:
	TYA
	JSR.w CODE_03AFEA
	LDA.w !RAM_SMB1_Global_CurrentLayer1XPosHi
	CMP.w !RAM_SMB1_Cutscene_MaxXPosHi
	BEQ.b CODE_038A5C
	LDA.w $0768
	CLC
	ADC.b #$80
	STA.w $0768
	LDA.b #$01
	ADC.b #$00
	TAY
	JSR.w CODE_03AE82
	JSR.w CODE_03AE2C
	INC.w !RAM_SMB1_Cutscene_CanScrollFlag
CODE_038A5C:
	LDA.w !RAM_SMB1_Cutscene_CanScrollFlag
	BEQ.b CODE_038ADD
	RTS

;--------------------------------------------------------------------

SMB1_ToadCutscene_State03_WaitForToadToBreakOutOfBag:
.Main:
;$038A62
	INC.w !RAM_SMB1_Cutscene_WaitBeforeToadBreaksOutOfBag
	LDA.w !RAM_SMB1_Cutscene_WaitBeforeToadBreaksOutOfBag
	CMP.b #$70
	BNE.b CODE_038A77
	LDA.b #$01
	STA.w !RAM_SMB1_Cutscene_ToadPoppedOutOfBagFlag
	STZ.w $0F7F
	INC.w !RAM_SMB1_Cutscene_CurrentState
CODE_038A77:
	RTS

;--------------------------------------------------------------------

SMB1_ToadCutscene_State04_SayFamousLine:
.Main:
;$038A78
	LDA.w !RAM_SMB1_Cutscene_ToadTextTimer
	BNE.b CODE_038AC0
	LDA.w !RAM_SMB1_Cutscene_ToadLineToDisplay
	BEQ.b CODE_038A99
	CMP.b #$09
	BCS.b CODE_038AC0
	LDY.w !RAM_SMB1_Player_CurrentWorld
	CPY.b #$07
	BNE.b CODE_038A95
	CMP.b #$03
	BCC.b CODE_038AC0
	SBC.b #$01
	BRA.b CODE_038A99

CODE_038A95:
	CMP.b #$02
	BCC.b CODE_038AC0
CODE_038A99:
	TAY
	BNE.b CODE_038AA4
	LDA.w !RAM_SMB1_Player_CurrentCharacter
	BEQ.b CODE_038AB5
	INY
	BNE.b CODE_038AB5
CODE_038AA4:
	INY
	LDA.w !RAM_SMB1_Player_CurrentWorld
	CMP.b #$07
	BEQ.b CODE_038AB5
	DEY
	CPY.b #$04
	BCS.b CODE_038AD3
	CPY.b #$03
	BCS.b CODE_038AC0
CODE_038AB5:
	CPY.b #$03
	BNE.b CODE_038AB9
CODE_038AB9:
	TYA
	CLC
	ADC.b #$0C
	STA.w !RAM_SMB1_Global_StripeImageToUpload
CODE_038AC0:
	LDA.w !RAM_SMB1_Cutscene_ToadTextTimer
	CLC
	ADC.b #$04
	STA.w !RAM_SMB1_Cutscene_ToadTextTimer
	LDA.w !RAM_SMB1_Cutscene_ToadLineToDisplay
	ADC.b #$00
	STA.w !RAM_SMB1_Cutscene_ToadLineToDisplay
	CMP.b #$07
CODE_038AD3:
	BCC.b CODE_038AE0
	LDA.b #$06
	STA.w $07B1
	STA.w $0E67
CODE_038ADD:
	INC.w !RAM_SMB1_Cutscene_CurrentState
CODE_038AE0:
	RTS

;--------------------------------------------------------------------

SMB1_ToadCutscene_State06_WaitBeforeFadeOut:
.Main:
SMB1_PeachCutscene_State0C_FinishCutscene:
.Main:
;$038AE1
	LDA.w $07B1
	BNE.b CODE_038B14
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMB1_J) != $00
	LDY.w $1680
else
	LDA.w $1680
endif
	BNE.b CODE_038B15
	LDY.w !RAM_SMB1_Player_CurrentWorld
	CPY.b #$07
	BCS.b CODE_038B15
	LDA.b #$00
	STA.w !RAM_SMB1_Player_CurrentLevel
	STA.w !RAM_SMB1_Player_CurrentLevelNumberDisplay
	STA.w !RAM_SMB1_Level_CurrentState
	INC.w !RAM_SMB1_Player_CurrentWorld
	LDA.b #$01
	STA.w $0BA5
	JSR.w CODE_03A22B
	JSL.l CODE_04C00B
	INC.w $0757
	LDA.b #$01
	STA.w !RAM_SMB1_Global_GameMode
CODE_038B14:
	RTS

CODE_038B15:
	JMP.w CODE_03A204

CODE_038B18:
	RTS

;--------------------------------------------------------------------

DATA_038B19:
	db $FF,$FF,$F6,$FB,$F7,$FB,$F8,$FB
	db $F9,$FB,$FA,$FB,$F6,$0E,$F7,$0E
	db $F8,$0E,$F9,$0E,$FA,$0E,$FD,$FE

DATA_038B31:
	db $FF,$41,$42,$44,$45,$48,$31,$32
	db $34,$35,$38,$00

CODE_038B3D:
	LDA.w !RAM_SMB1_Level_ScoreSpr_SpriteID,x
	BEQ.b CODE_038B14
	CMP.b #$0B
	BCC.b CODE_038B52
	LDA.b #$0B
	STA.w !RAM_SMB1_Level_ScoreSpr_SpriteID,x
	CPX.b #$09
	BEQ.b CODE_038B52
	STA.w $0284
CODE_038B52:
	TAY
	LDA.w !RAM_SMB1_Level_ScoreSpr_DisplayTimer,x
	BNE.b CODE_038B5C
	STA.w !RAM_SMB1_Level_ScoreSpr_SpriteID,x
	RTS

CODE_038B5C:
	DEC.w !RAM_SMB1_Level_ScoreSpr_DisplayTimer,x
	CMP.b #$2B
	BNE.b CODE_038B83
	CPY.b #$0B
	BNE.b CODE_038B70
	JSL.l CODE_048596
	LDA.b #!Define_SMAS_Sound0063_1up
	STA.w !RAM_SMB1_Global_SoundCh3
CODE_038B70:
	LDA.w DATA_038B31,y
	LSR
	LSR
	LSR
	LSR
	TAX
	LDA.w DATA_038B31,y
	AND.b #$0F
	STA.w !RAM_SMB1_Level_ScoreSpr_AddToScoreBuffer,x
	JSR.w CODE_03BD5D
CODE_038B83:
	LDX.b $9E
	LDY.w !RAM_SMB1_Level_SpriteOAMIndexTable+$13
CODE_038B88:
	LDA.w SMB1_OAMBuffer[$00].YDisp,y
	CMP.b #$F0
	BEQ.b CODE_038B9E
	INY
	INY
	INY
	INY
	INY
	INY
	INY
	INY
	CPY.b #$90
	BNE.b CODE_038B88
	LDY.w !RAM_SMB1_Level_SpriteOAMIndexTable+$13
CODE_038B9E:
	LDA.w !RAM_SMB1_Level_ScoreSpr_YPosLo,x
	CMP.b #$18
	BCC.b CODE_038BAA
	SBC.b #$01
	STA.w !RAM_SMB1_Level_ScoreSpr_YPosLo,x
CODE_038BAA:
	LDA.w !RAM_SMB1_Level_ScoreSpr_YPosLo,x
	JSR.w CODE_03EC42
	STX.b !RAM_SMB1_Global_ScratchRAME0
	TXA
	ASL
	TAX
	REP.b #$20
	LDA.w $0E50,x
	STA.b !RAM_SMB1_Global_ScratchRAME2
	CLC
	ADC.w #$0008
	STA.b !RAM_SMB1_Global_ScratchRAMDE
	SEP.b #$20
	LDX.b !RAM_SMB1_Global_ScratchRAME0
	STZ.b !RAM_SMB1_Global_ScratchRAMDD
	LDA.b !RAM_SMB1_Global_ScratchRAME3
	BEQ.b CODE_038BD2
	LDA.b !RAM_SMB1_Global_ScratchRAMDD
	ORA.b #$01
	STA.b !RAM_SMB1_Global_ScratchRAMDD
CODE_038BD2:
	LDA.b !RAM_SMB1_Global_ScratchRAMDD
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot,y
	LDA.w !RAM_SMB1_Level_ScoreSpr_SpriteID,x
	CMP.b #$06
	BCS.b CODE_038BE2
CODE_038BDE:
	STZ.b !RAM_SMB1_Global_ScratchRAMDD
	BRA.b CODE_038BEA

CODE_038BE2:
	CMP.b #$0B
	BEQ.b CODE_038BDE
	LDA.b #$02
	STA.b !RAM_SMB1_Global_ScratchRAMDD
CODE_038BEA:
	LDA.b !RAM_SMB1_Global_ScratchRAMDF
	BEQ.b CODE_038BF4
	LDA.b !RAM_SMB1_Global_ScratchRAMDD
	ORA.b #$01
	STA.b !RAM_SMB1_Global_ScratchRAMDD
CODE_038BF4:
	LDA.b !RAM_SMB1_Global_ScratchRAMDD
	STA.w SMB1_OAMTileSizeBuffer[$01].Slot,y
	LDA.b !RAM_SMB1_Global_ScratchRAME2
	STA.w SMB1_OAMBuffer[$00].XDisp,y
	LDA.b !RAM_SMB1_Global_ScratchRAMDE
	STA.w SMB1_OAMBuffer[$01].XDisp,y
	LDA.w !RAM_SMB1_Level_ScoreSpr_SpriteID,x
	ASL
	TAX
	LDA.w DATA_038B19,x
	STA.w SMB1_OAMBuffer[$00].Tile,y
	LDA.w DATA_038B19+$01,x
	STA.w SMB1_OAMBuffer[$01].Tile,y
	TAX
	LDA.b #$32
	STA.w SMB1_OAMBuffer[$00].Prop,y
	CPX.b #$0E
	BNE.b CODE_038C1F
	INC
CODE_038C1F:
	STA.w SMB1_OAMBuffer[$01].Prop,y
	LDX.b $9E
	RTS

;--------------------------------------------------------------------

; Note: Routine for processing level preview?

CODE_038C25:
	LDA.w $073C
	ASL
	TAX
	JMP.w (DATA_038C2D,x)

DATA_038C2D:
	dw CODE_038C4B
	dw CODE_038C5D
	dw CODE_038C90
	dw CODE_038C98
	dw CODE_038D0C
	dw CODE_039220
	dw CODE_038D88
	dw CODE_039220
	dw CODE_038E44
	dw CODE_038C7C
	dw CODE_038C87
	dw CODE_038C8C
	dw CODE_038E72
	dw CODE_038EFE
	dw CODE_038F1E

;--------------------------------------------------------------------

CODE_038C4B:
	LDA.w !RAM_SMB1_Global_GameMode
	BEQ.b CODE_038C79
	LDX.b #$03									;\ Note: This LDX.b #$03 is not used
	STZ.w !RAM_SMB1_Global_StripeImageToUpload					;/ Was it originally supposed to be stored in this address?
	LDA.b #$01
	STA.w !RAM_SMB1_Global_UpdateEntirePaletteFlag
	JMP.w CODE_038F1A

CODE_038C5D:
	LDA.w $0744
	PHA
	LDA.w !RAM_SMB1_Player_CurrentPowerUp
	PHA
	STZ.w !RAM_SMB1_Player_CurrentPowerUp
	LDA.b #$02
	STA.w $0744
	JSL.l CODE_049A88
	PLA
	STA.w !RAM_SMB1_Player_CurrentPowerUp
	PLA
	STA.w $0744
CODE_038C79:
	JMP.w CODE_038F1A

;--------------------------------------------------------------------

CODE_038C7C:
	LDA.b !RAM_SMB1_Level_CurrentLevelType
	JSL.l SMB1_SetLevelMusic_Main
	JSL.l CODE_04956B
	RTS

;--------------------------------------------------------------------

CODE_038C87:
	JSL.l CODE_049A7D
	RTS

;--------------------------------------------------------------------

CODE_038C8C:
	INC.w $073C
	RTS

;--------------------------------------------------------------------

CODE_038C90:
	LDA.b #$00
	JSR.w CODE_039109
	JMP.w CODE_038F1A

;--------------------------------------------------------------------

CODE_038C98:
	JSR.w CODE_03BD66
	REP.b #$30
	LDX.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	LDA.w #$7258
	STA.w SMB1_StripeImageUploadTable[$00].LowByte,x
	LDA.w #$0700
	STA.w SMB1_StripeImageUploadTable[$01].LowByte,x
	LDA.w #$2028
	STA.w SMB1_StripeImageUploadTable[$02].LowByte,x
	SEP.b #$20
	LDA.w !RAM_SMB1_Player_CurrentWorld
	INC
	STA.w SMB1_StripeImageUploadTable[$03].LowByte,x
	LDA.b #$20
	STA.w SMB1_StripeImageUploadTable[$03].HighByte,x
	STA.w SMB1_StripeImageUploadTable[$04].HighByte,x
	STA.w SMB1_StripeImageUploadTable[$05].HighByte,x
	LDA.b #$24
	STA.w SMB1_StripeImageUploadTable[$04].LowByte,x
	LDA.w !RAM_SMB1_Player_CurrentLevelNumberDisplay
	INC
	STA.w SMB1_StripeImageUploadTable[$05].LowByte,x
	LDA.b #$FF
	STA.w SMB1_StripeImageUploadTable[$06].LowByte,x
	LDA.w !RAM_SMB1_Global_GameMode
	BNE.b CODE_038CF0
if !Define_Global_ROMToAssemble&(!ROM_SMB1_U|!ROM_SMB1_E|!ROM_SMB1_J) == $00
	LDA.l !SRAM_SMAS_Global_RunningDemoFlag
	BNE.b CODE_038CF0
endif
	LDA.l !RAM_SMB1_Global_SaveBuffer_2PlayerFlag
	BMI.b CODE_038CF0
	LDA.l !RAM_SMB1_Global_SaveBuffer_CurrentWorld
	INC
	STA.w SMB1_StripeImageUploadTable[$03].LowByte,x
CODE_038CF0:
	REP.b #$20
	TXA
	CLC
	ADC.w #$000C
	STA.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	TAX
	SEP.b #$20
	LDA.w !RAM_SMB1_Player_HardModeActiveFlag
	BEQ.b CODE_038D07
	LDA.b #$2A
	STA.w $16FA,x
CODE_038D07:
	SEP.b #$10
	JMP.w CODE_038F1A

;--------------------------------------------------------------------

CODE_038D0C:
	LDA.w $0759
	BEQ.b CODE_038D82
	STZ.w $0759
	LDY.b #$00
	JSR.w CODE_0385F3
	JSL.l CODE_0491DD
	LDA.b #$01
	STA.w $0ED6
	LDA.b #$02
	JSR.w CODE_038DAA
	LDA.w !RAM_SMB1_Level_TwoPlayerGameFlag
	BEQ.b CODE_038D81
	LDA.w !RAM_SMB1_Player_OtherPlayersLifeCount
	BMI.b CODE_038D81
	REP.b #$20
	LDA.w #$7258
	STA.w SMB1_StripeImageUploadTable[$00].LowByte,y
	LDA.w #$0700
	STA.w SMB1_StripeImageUploadTable[$01].LowByte,y
	LDA.w #$2028
	STA.w SMB1_StripeImageUploadTable[$02].LowByte,y
	SEP.b #$20
	LDA.w !RAM_SMB1_Player_OtherPlayersWorld
	INC
	STA.w SMB1_StripeImageUploadTable[$03].LowByte,y
	LDA.b #$20
	STA.w SMB1_StripeImageUploadTable[$03].HighByte,y
	STA.w SMB1_StripeImageUploadTable[$04].HighByte,y
	STA.w SMB1_StripeImageUploadTable[$05].HighByte,y
	LDA.b #$24
	STA.w SMB1_StripeImageUploadTable[$04].LowByte,y
	LDA.w !RAM_SMB1_Player_OtherPlayersLevelNumberDisplay
	INC
	STA.w SMB1_StripeImageUploadTable[$05].LowByte,y
	LDA.b #$FF
	STA.w SMB1_StripeImageUploadTable[$06].LowByte,y
	REP.b #$20
	TYA
	CLC
	ADC.w #$000C
	STA.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	TAY
	SEP.b #$20
	LDA.w $0781
	BEQ.b CODE_038D81
	LDA.b #$2A
	STA.w $16FA,y
CODE_038D81:
	RTS

CODE_038D82:
	INC.w $073C
	JMP.w CODE_038F1A

;--------------------------------------------------------------------

CODE_038D88:
	LDA.w !RAM_SMB1_Global_GameMode
	BEQ.b CODE_038DD6
	CMP.b #$03
	BEQ.b CODE_038DDC
	LDA.w !RAM_SMB1_Level_Player_TriggeredScreenExitFlag
	BNE.b CODE_038DD6
	LDY.b !RAM_SMB1_Level_CurrentLevelType
	CPY.b #$03
	BEQ.b CODE_038DA1
	LDA.w $0769
	BNE.b CODE_038DD6
CODE_038DA1:
	JSR.w SMB1_DrawLevelPreviewSprites_Main
	JSL.l CODE_0492E7
	LDA.b #$01
CODE_038DAA:
	JSR.w CODE_039109
	JSR.w CODE_039231
	STZ.w !RAM_SMB1_Global_BG1And2WindowMaskSettingsMirror
	STZ.w !RAM_SMB1_Global_BG3And4WindowMaskSettingsMirror
	STZ.w !RAM_SMB1_Global_ObjectAndColorWindowSettingsMirror
	STZ.w !RAM_SMB1_Global_ColorMathInitialSettingsMirror
	LDA.b #$20
	STA.w !RAM_SMB1_Global_ColorMathSelectAndEnableMirror
	STZ.w !RAM_SMB1_Global_HDMAEnableMirror
	LDA.b #$02
	STA.w !RAM_SMB1_Global_FadeDirection
	STZ.w !RAM_SMB1_Global_EnableMosaicFadesFlag
	STZ.w !RAM_SMB1_Global_ScreenDisplayRegisterMirror
	STZ.w !RAM_SMB1_Global_MosaicSizeAndBGEnableMirror
	STZ.w $0774
	RTS

CODE_038DD6:
	LDA.b #$08
	STA.w $073C
	RTS

CODE_038DDC:
	STZ.w !RAM_SMB1_Global_BG1And2WindowMaskSettingsMirror
	STZ.w !RAM_SMB1_Global_BG3And4WindowMaskSettingsMirror
	STZ.w !RAM_SMB1_Global_ObjectAndColorWindowSettingsMirror
	STZ.w !RAM_SMB1_Global_ColorMathInitialSettingsMirror
	LDA.b #$20
	STA.w !RAM_SMB1_Global_ColorMathSelectAndEnableMirror
	STZ.w !RAM_SMB1_Global_HDMAEnableMirror
	LDA.w $0774
	BEQ.b CODE_038E07
	STZ.w !RAM_SMB1_Global_EnableMosaicFadesFlag
	STZ.w $0774
	STZ.w !RAM_SMB1_Global_ScreenDisplayRegisterMirror
	LDA.b #$02
	STA.w !RAM_SMB1_Global_FadeDirection
	JSL.l CODE_0491DD
CODE_038E07:
	LDA.b #$09
	STA.w $07B0
	LDA.b #$03
	JSR.w CODE_039109
	LDA.w !RAM_SMB1_Level_TwoPlayerGameFlag
	BEQ.b CODE_038E1B
	LDA.w !RAM_SMB1_Player_OtherPlayersLifeCount
	BPL.b CODE_038E3A
CODE_038E1B:
	PHX
	PHY
	REP.b #$10
	LDX.w #$0000
	STZ.b !RAM_SMB1_Global_ScratchRAME5
	LDY.b !RAM_SMB1_Global_ScratchRAME4
CODE_038E26:
	LDA.w DATA_03903D,x
	STA.w SMB1_StripeImageUploadTable[$00].LowByte,y
	INX
	INY
	INC
	BNE.b CODE_038E26
	STY.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	SEP.b #$10
	PLY
	PLX
	BRA.b CODE_038E3E

CODE_038E3A:
	JSL.l CODE_0486DF
CODE_038E3E:
	STZ.w $0EC3
	JMP.w CODE_038F23

;--------------------------------------------------------------------

CODE_038E44:
	LDA.w $0774
	BEQ.b CODE_038E4F
	CMP.b #$01
	BEQ.b CODE_038E5C
	BRA.b CODE_038E59

CODE_038E4F:
	LDA.b #$01
	STA.w !RAM_SMB1_Global_FadeDirection
	STZ.w !RAM_SMB1_Global_EnableMosaicFadesFlag
	BRA.b CODE_038E71

CODE_038E59:
	INC.w $0774
CODE_038E5C:
	JSR.w CODE_03A295
	LDA.w $071F
	BNE.b CODE_038E5C
	DEC.w $071E
	BPL.b CODE_038E6C
	INC.w $073C
CODE_038E6C:
	LDA.b #$06
	STA.w !RAM_SMB1_Global_StripeImageToUpload
CODE_038E71:
	RTS

;--------------------------------------------------------------------

; Note: Routine that buffers the title screen logo and menu text

CODE_038E72:
	LDA.w !RAM_SMB1_Global_GameMode
	BEQ.b CODE_038E7A
	JMP.w CODE_038F23

CODE_038E7A:
	PHB
	LDA.b #TitleScreenLogoAndMenuStripeImage>>16
	PHA
	PLB
	LDA.b #$01
	STA.w $0EC8
	REP.b #$30
	LDX.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	LDY.w #$0000
CODE_038E8C:
	LDA.w TitleScreenLogoAndMenuStripeImage,y
	STA.w SMB1_StripeImageUploadTable[$00].LowByte,x
	INC
	BEQ.b CODE_038E9B
	INX
	INX
	INY
	INY
	BRA.b CODE_038E8C

CODE_038E9B:
	STX.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	SEP.b #$30
	PLB
	STZ.w $0E20
	LDA.b #!Define_SMB1_LevelMusic_MusicFade
	STA.w !RAM_SMB1_Global_MusicCh1
	STA.w $0ED6
	LDA.b #$05
	STA.w !RAM_SMB1_Global_StripeImageToUpload
if !Define_Global_ROMToAssemble&(!ROM_SMB1_U|!ROM_SMB1_E|!ROM_SMB1_J) != $00
	PHX
	PHY
	JSL.l SMB1_LoadFileSelectMenu_Main
	PLY
	PLX
else
	LDA.l !RAM_SMB1_Global_SaveBuffer_2PlayerFlag
	BMI.b CODE_038EBA
	JSR.w CODE_038EBD
endif
CODE_038EBA:
	JMP.w CODE_038F1A

if !Define_Global_ROMToAssemble&(!ROM_SMB1_U|!ROM_SMB1_E|!ROM_SMB1_J) == $00
CODE_038EBD:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMB1_J) == $00
	PHX
	PHY
endif
	REP.b #$30
	LDA.l !RAM_SMB1_Global_SaveBuffer_2PlayerFlag
	AND.w #$0001
	ASL
	TAY
	LDX.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	LDA.w #$024A
	CLC
	ADC.w DATA_038EFA,y
	XBA
	STA.w SMB1_StripeImageUploadTable[$00].LowByte,x
	LDA.w #$4018
	XBA
	STA.w SMB1_StripeImageUploadTable[$01].LowByte,x
	LDA.w #$0024
	STA.w SMB1_StripeImageUploadTable[$02].LowByte,x
	LDA.w #$FFFF
	STA.w SMB1_StripeImageUploadTable[$03].LowByte,x
	LDA.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	CLC
	ADC.w #$0006
	STA.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	SEP.b #$30
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMB1_J) == $00
	PLY
	PLX
endif
	RTS

DATA_038EFA:
	dw $0040,$0000
endif

;--------------------------------------------------------------------

CODE_038EFE:
	LDA.w !RAM_SMB1_Global_GameMode
	BNE.b CODE_038F23
	LDX.b #$00
CODE_038F05:
	STA.w !RAM_SMB1_Level_BridgeSpr_SpriteSlotExistsFlag,x
	STA.w $0400,x
	DEX
	BNE.b CODE_038F05
	LDA.l !RAM_SMB1_Global_SaveBuffer_2PlayerFlag
	BMI.b CODE_038F17
	STA.w !RAM_SMB1_Level_TwoPlayerGameFlag
CODE_038F17:
	JSR.w CODE_038861
CODE_038F1A:
	INC.w $073C
	RTS

;--------------------------------------------------------------------

CODE_038F1E:
	LDA.b #$FA
	JSR.w CODE_03BD6C
CODE_038F23:
	INC.w !RAM_SMB1_Cutscene_CurrentState
	RTS

;--------------------------------------------------------------------

DATA_038F27:
	db $58,$43,$00,$09
	db $16,$20,$0A,$20,$1B,$20,$12,$20,$18,$20

	db $58,$52,$00,$15
	db $20,$20,$18,$20,$1B,$20,$15,$20,$0D,$20,$28,$20,$28,$20,$1D,$20
	db $12,$20,$16,$20,$0E,$20

	db $58,$68,$00,$09
	db $00,$20,$28,$20,$28,$20,$27,$24,$25,$20
	db $FF

	db $59,$6D,$00,$0F
	db $28,$20,$28,$20,$28,$20,$25,$20,$28,$20,$28,$20,$28,$20,$28,$20

	db $59,$E0,$40,$FE
	db $28,$00

	db $59,$0B,$00,$13
	db $20,$20,$18,$20,$1B,$20,$15,$20,$0D,$20,$28,$20,$28,$20,$28,$20
	db $24,$20,$28,$20

	db $58,$AC,$40,$0D
	db $28,$20

	db $FF

	db $09,$6D,$00,$09
	db $E0,$19,$E1,$19,$E2,$19,$E3,$19,$E4,$19

	db $09,$8D,$00,$09
	db $F0,$19,$F1,$19,$F2,$19,$F3,$19,$F4,$19

	db $09,$AC,$00,$0D
	db $CA,$19,$CB,$19,$CC,$19,$CD,$19,$24,$00,$CE,$19,$CF,$19

	db $09,$CC,$00,$0D
	db $DA,$19,$DB,$19,$DC,$19,$DD,$19,$24,$00,$DE,$19,$DF,$19

	db $FF

	db $08,$CD,$00,$09
	db $E0,$19,$E1,$19,$E2,$19,$E3,$19,$E4,$19

	db $08,$ED,$00,$09
	db $F0,$19,$F1,$19,$F2,$19,$F3,$19,$F4,$19

	db $09,$2B,$00,$13
	db $C0,$19,$C1,$19,$C2,$19,$C3,$19,$C4,$19,$C5,$19,$C6,$19,$C7,$19
	db $C8,$19,$C9,$19

	db $09,$4B,$00,$13
	db $D0,$19,$D1,$19,$D2,$19,$D3,$19,$D4,$19,$D5,$19,$D6,$19,$D7,$19
	db $D8,$19,$D9,$19

	db $09,$6D,$40,$08
	db $24,$00

	db $09,$8D,$40,$08
	db $24,$00

	db $09,$AC,$40,$0C
	db $24,$00

	db $09,$CC,$40,$0C
	db $24,$00

	db $FF

DATA_03903D:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMB1_J) != $00
	db $09,$CC,$40,$0C
	db $24,$00

	db $09,$91,$00,$07
	db $AD,$02,$24,$00,$24,$00,$AD,$02

	db $09,$D2,$00,$01
	db $AD,$02

	db $09,$8D,$C0,$08
	db $AD,$02

	db $09,$AB,$00,$17
	db $A1,$02,$A2,$02,$A3,$02,$A4,$02,$AB,$02,$AC,$02,$A5,$02,$24,$00
	db $A6,$02,$A6,$02,$A7,$02,$A8,$02

	db $09,$EB,$00,$13
	db $A1,$02,$A2,$02,$A3,$02,$A4,$02,$A5,$02,$24,$00,$A6,$02,$A6,$02
	db $A7,$02,$A8,$02

	db $0A,$2B,$00,$11
	db $A1,$02,$A2,$02,$A3,$02,$A4,$02,$A5,$02,$24,$00,$A9,$02,$AA,$02
	db $A8,$02

	db $FF

	db $05,$84,$00,$29
	db $20,$08,$0E,$08,$15,$08,$0C,$08,$18,$08,$16,$08,$0E,$08,$24,$00
	db $1D,$08,$18,$08,$24,$00,$20,$08,$0A,$08,$1B,$08,$19,$08,$24,$00
	db $23,$08,$18,$08,$17,$08,$0E,$08,$2B,$08

	db $05,$E5,$00,$01
	db $24,$08

	db $05,$ED,$00,$01
	db $24,$08

	db $05,$F5,$00,$01
	db $24,$08
else
	db $09,$AB,$00,$0F
	db $A1,$02,$A2,$02,$A3,$02,$A4,$02,$A5,$02,$A6,$02,$A7,$02,$A8,$02

	db $09,$EB,$00,$19
	db $AE,$02,$AF,$02,$B0,$02,$B1,$02,$AD,$02,$A1,$02,$A2,$02,$A3,$02
	db $A4,$02,$A5,$02,$A6,$02,$A7,$02,$A8,$02

	db $0A,$2B,$00,$11
	db $AE,$02,$AF,$02,$B0,$02,$B1,$02,$AD,$02,$A9,$02,$AA,$02,$AB,$02
	db $AC,$02

	db $FF

	db $05,$84,$00,$29
	db $20,$08,$0E,$08,$15,$08,$0C,$08,$18,$08,$16,$08,$0E,$08,$24,$00
	db $1D,$08,$18,$08,$24,$00,$20,$08,$0A,$08,$1B,$08,$19,$08,$24,$00
	db $23,$08,$18,$08,$17,$08,$0E,$08,$2B,$08

	db $05,$E5,$00,$01
	db $24,$08

	db $05,$ED,$00,$01
	db $24,$08

	db $05,$F5,$00,$01
	db $24,$08
endif
	db $FF

DATA_0390C7:
	db $E5,$19,$E6,$19,$E7,$19,$E8,$19
	db $E9,$19

DATA_0390D1:
	db $F5,$19,$F6,$19,$F7,$19,$F8,$19
	db $F9,$19

DATA_0390DB:
	db $15,$20,$1E,$20,$12,$20,$10,$20
	db $12,$20

DATA_0390E5:
	db $04,$03,$02,$00
	db $24,$05,$24,$00
	db $08,$07,$06,$00

DATA_0390F1:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMB1_J) != $00
	dw $0000,$0000,$0037,$0037,$0070,$008C,$00B1,$00CD
	dw $017F,$017F,$0116,$0116
else
	dw $0000,$0000,$0037,$0037,$0070,$008C,$00B1,$00CD
	dw $015F,$015F,$0116,$0116
endif

CODE_039109:
	PHA
	ASL
	TAY
	CPY.b #$04
	BCC.b CODE_03911C
	CPY.b #$08
	BCC.b CODE_039116
	LDY.b #$08
CODE_039116:
	LDA.w !RAM_SMB1_Level_TwoPlayerGameFlag
	BNE.b CODE_03911C
	INY
CODE_03911C:
	STY.b !RAM_SMB1_Global_ScratchRAMF3
	TYA
	ASL
	AND.b #$FF
	REP.b #$30
	AND.w #$00FF
	TAY
	LDX.w DATA_0390F1,y
	LDY.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	SEP.b #$20
CODE_039130:
	LDA.w DATA_038F27,x
	CMP.b #$FF
	BEQ.b CODE_03913E
	STA.w SMB1_StripeImageUploadTable[$00].LowByte,y
	INX
	INY
	BRA.b CODE_039130

CODE_03913E:
	LDA.b #$FF
	STA.w SMB1_StripeImageUploadTable[$00].LowByte,y
	STY.b !RAM_SMB1_Global_ScratchRAME4
	SEP.b #$10
	PLA
	TAX
	CMP.b #$04
	BCC.b CODE_039150
	JMP.w CODE_0391E7

CODE_039150:
	DEX
	BNE.b CODE_0391AF
	JSL.l CODE_048895
	PHX
	LDX.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	LDA.w !RAM_SMB1_Player_CurrentLifeCount
	INC
	CMP.b #$0A
	BCC.b CODE_039190
	STZ.b !RAM_SMB1_Global_ScratchRAME4
	STZ.b !RAM_SMB1_Global_ScratchRAME5
CODE_039167:
	SEC
	SBC.b #$64
	BCC.b CODE_039170
	INC.b !RAM_SMB1_Global_ScratchRAME4
	BRA.b CODE_039167

CODE_039170:
	CLC
	ADC.b #$64
CODE_039173:
	SEC
	SBC.b #$0A
	BCC.b CODE_03917C
	INC.b !RAM_SMB1_Global_ScratchRAME5
	BRA.b CODE_039173

CODE_03917C:
	CLC
	ADC.b #$0A
	STA.b !RAM_SMB1_Global_ScratchRAME6
	LDY.b !RAM_SMB1_Global_ScratchRAME4
	BEQ.b CODE_039189
	TYA
	STA.w SMB1_StripeImageUploadTable[$06].LowByte,x
CODE_039189:
	LDA.b !RAM_SMB1_Global_ScratchRAME5
	STA.w SMB1_StripeImageUploadTable[$07].LowByte,x
	LDA.b !RAM_SMB1_Global_ScratchRAME6
CODE_039190:
	STA.w SMB1_StripeImageUploadTable[$08].LowByte,x
	LDY.w !RAM_SMB1_Player_CurrentWorld
	INY
	TYA
	STA.w SMB1_StripeImageUploadTable[$16].LowByte,x
	LDY.w !RAM_SMB1_Player_CurrentLevelNumberDisplay
	INY
	TYA
	STA.w SMB1_StripeImageUploadTable[$18].LowByte,x
	LDA.w !RAM_SMB1_Player_HardModeActiveFlag
	BEQ.b CODE_0391AD
	LDA.b #$2A
	STA.w SMB1_StripeImageUploadTable[$15].LowByte,x
CODE_0391AD:
	PLX
	RTS

CODE_0391AF:
	LDA.w !RAM_SMB1_Level_TwoPlayerGameFlag
	BEQ.b CODE_0391E6
	LDA.w $0EC3
	BEQ.b CODE_0391E6
	PHY
	LDA.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	CLC
	ADC.b #$09
	TAY
	LDA.b !RAM_SMB1_Global_ScratchRAMF3
	CMP.b #$04
	BEQ.b CODE_0391CB
	CMP.b #$06
	BNE.b CODE_0391DC
CODE_0391CB:
	LDA.w DATA_0390C7,y
	STA.w SMB1_StripeImageUploadTable[$02].LowByte,y
	LDA.w DATA_0390D1,y
	STA.w SMB1_StripeImageUploadTable[$09].LowByte,y
	DEY
	BPL.b CODE_0391CB
	BRA.b CODE_0391E5

CODE_0391DC:
	LDA.w DATA_0390DB,y
	STA.w SMB1_StripeImageUploadTable[$02].LowByte,y
	DEY
	BPL.b CODE_0391DC
CODE_0391E5:
	PLY
CODE_0391E6:
	RTS

CODE_0391E7:
	SBC.b #$04
	ASL
	ASL
	TAX
	REP.b #$30
	LDA.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	CLC
	ADC.w #$0000
	TAY
	SEP.b #$30
	LDA.b #$12
	CLC
	ADC.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	STA.b !RAM_SMB1_Global_ScratchRAME6
CODE_039200:
	LDA.w DATA_0390E5,x
	STA.w SMB1_StripeImageUploadTable[$19].LowByte,y
	INX
	INY
	INY
	INY
	INY
	INY
	INY
	CPY.b !RAM_SMB1_Global_ScratchRAME6
	BCC.b CODE_039200
	REP.b #$20
	LDA.w #$0040
	CLC
	ADC.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	STA.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	SEP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_039220:
	LDA.w $07B0
	BNE.b CODE_039239
	LDA.w !RAM_SMB1_Global_GameMode
	CMP.b #$03
	BEQ.b CODE_039231
	LDA.b #$01
	STA.w !RAM_SMB1_Global_FadeDirection
CODE_039231:
	LDA.b #$07
	STA.w $07B0
	INC.w $073C
CODE_039239:
	RTS

;--------------------------------------------------------------------

CODE_03923A:
	LDA.w $0EC9
	BNE.b CODE_039239
	REP.b #$30
	LDY.w $1A00
	STY.b $00
	LDA.w $0720
	STA.w $1A02,y
	XBA
	STA.w $0ECC
	LDA.w #$3D80
	STA.w $1A04,y
	LDA.w #$0024
	STA.w $1A06,y
	STA.w $1A08,y
	STA.w $1A0A,y
	STA.w $1A0C,y
	SEP.b #$30
	LDX.b #$00
	LDA.w $0EE7
	BEQ.b CODE_03927E
	STA.w $0EE6
	LDA.w $0720
	STA.w $0EF5
	LDA.w $0721
	INC
	STA.w $0EF4
CODE_03927E:
	STX.b $02
	LDA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,x
	AND.b #$C0
	ASL
	ROL
	ROL
	TAY
	LDA.w DATA_039445,y
	STA.b $06
	LDA.w DATA_039449,y
	STA.b $07
	REP.b #$30
	TXA
	AND.w #$00FF
	TAX
	LDA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,x
	AND.w #$003F
	ASL
	ASL
	ASL
	STA.b $03
	LDA.w $071F
	AND.w #$0001
	EOR.w #$0001
	ASL
	ASL
	ADC.b $03
	TAY
	LDX.b $00
	LDA.b ($06),y
	STA.w $1A0E,x
	INY
	INY
	LDA.b ($06),y
	STA.w $1A10,x
	INC.b $00
	INC.b $00
	INC.b $00
	INC.b $00
	SEP.b #$30
	LDX.b $02
	INX
	CPX.b #$0D
	BCS.b CODE_0392D5
	JMP.w CODE_03927E

CODE_0392D5:
	REP.b #$30
	LDY.w $1A00
	LDA.w $1A0E,y
	CMP.w #$18A2
	BEQ.b CODE_0392E7
	CMP.w #$18A3
	BNE.b CODE_0392F3
CODE_0392E7:
	STA.w $1A06,y
	STA.w $1A08,y
	STA.w $1A0A,y
	STA.w $1A0C,y
CODE_0392F3:
	LDA.b $00
	CLC
	ADC.w #$000E
	TAY
	LDA.w #$FFFF
	STA.w $1A02,y
	STY.w $1A00
	LDA.w $0743
	AND.w #$00FF
	BNE.b CODE_039341
	LDA.b !RAM_SMB1_Level_CurrentLevelType
	AND.w #$00FF
	BEQ.b CODE_039341
	CMP.w #$0003
	BEQ.b CODE_039341
	LDA.w $1A02-$0A,y
	CMP.w #$0024
	BEQ.b CODE_039334
	CMP.w #$10A4
	BEQ.b CODE_039334
	CMP.w #$0A08
	BNE.b CODE_03933D
	LDA.w $0ECE
	AND.w #$FF00
	STA.w $0ECE
	BRA.b CODE_03933D

CODE_039334:
	LDA.w $0ECE
	ORA.w #$0100
	STA.w $0ECE
CODE_03933D:
	JSL.l CODE_048D71
CODE_039341:
	SEP.b #$30
	INC.w $0721
	LDA.w $0721
	AND.b #$1F
	BNE.b CODE_039358
	STZ.w $0721
	LDA.w $0720
	EOR.b #$04
	STA.w $0720
CODE_039358:
	LDA.b #$06
	STA.w !RAM_SMB1_Global_StripeImageToUpload
	RTS

;--------------------------------------------------------------------

CODE_03935E:
	RTS

;--------------------------------------------------------------------

CODE_03935F:
	RTS

;--------------------------------------------------------------------

DATA_039360:
	dw $0C45,$0C45,$0C47,$0C47,$0C47,$0C47,$0C47,$0C47
	dw $0C57,$0C58,$0C59,$0C5A,$0024,$0024,$0024,$0024

;--------------------------------------------------------------------

CODE_039380:
	LDY.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	INY
	LDA.b #$03
	JSR.w CODE_0393CE
	LDA.b #$06
	STA.w !RAM_SMB1_Global_StripeImageToUpload
	JMP.w CODE_0393BF

;--------------------------------------------------------------------

CODE_039391:
	JSR.w CODE_03939D
	INC.w !RAM_SMB1_Level_BlocksThatChangedStateCounter
	DEC.w !RAM_SMB1_Level_RevertBlockStateFlag,x
	RTS

;--------------------------------------------------------------------

CODE_03939B:
	LDA.b #$00
CODE_03939D:
	LDY.b #$03
	CMP.b #$00
	BEQ.b CODE_0393B7
	LDY.b #$00
	CMP.b #$5B
	BEQ.b CODE_0393B7
	CMP.b #$51
	BEQ.b CODE_0393B7
	INY
	CMP.b #$60
	BEQ.b CODE_0393B7
	CMP.b #$52
	BEQ.b CODE_0393B7
	INY
CODE_0393B7:
	TYA
	LDY.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	INY
	JSR.w CODE_0393CE
CODE_0393BF:
	REP.b #$20
	LDA.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	CLC
	ADC.w #$0010
	STA.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	SEP.b #$20
	RTS

CODE_0393CE:
	STX.b $00
	STY.b $01
	ASL
	ASL
	ASL
	TAX
	LDY.b #$00
	LDA.b $06
	CMP.b #$D0
	BCC.b CODE_0393E0
	LDY.b #$04
CODE_0393E0:
	STY.b $03
	AND.b #$0F
	ASL
	STA.b $04
	STZ.b $05
	LDA.b $02
	CLC
	ADC.b #$20
	ASL
	ROL.b $05
	ASL
	ROL.b $05
	ADC.b $04
	STA.b $04
	LDA.b $05
	ADC.b $03
	STA.b $05
	LDY.b $01
CODE_039400:
	REP.b #$30
	TYA
	AND.w #$00FF
	TAY
	TXA
	AND.w #$00FF
	TAX
	LDA.b $04
	XBA
	STA.w !RAM_SMB1_Global_StripeImageUploadIndexHi,y
	CLC
	ADC.w #$2000
	STA.w SMB1_StripeImageUploadTable[$03].HighByte,y
	LDA.w #$0300
	STA.w SMB1_StripeImageUploadTable[$00].HighByte,y
	STA.w SMB1_StripeImageUploadTable[$04].HighByte,y
	LDA.w DATA_039360,x
	STA.w SMB1_StripeImageUploadTable[$01].HighByte,y
	LDA.w DATA_039360+$02,x
	STA.w SMB1_StripeImageUploadTable[$02].HighByte,y
	LDA.w DATA_039360+$04,x
	STA.w SMB1_StripeImageUploadTable[$05].HighByte,y
	LDA.w DATA_039360+$06,x
	STA.w SMB1_StripeImageUploadTable[$06].HighByte,y
	LDA.w #$FFFF
	STA.w SMB1_StripeImageUploadTable[$07].HighByte,y
	SEP.b #$30
	LDX.b $00
	RTS

;--------------------------------------------------------------------

; Note: Map16 data

DATA_039445:
	db DATA_03944D
	db DATA_0395A5
	db DATA_039765
	db DATA_0397D5

DATA_039449:
	db DATA_03944D>>8
	db DATA_0395A5>>8
	db DATA_039765>>8
	db DATA_0397D5>>8

DATA_03944D:
	db $24,$00,$24,$00,$24,$00,$24,$00,$27,$00,$27,$00,$27,$00,$27,$00
	db $24,$00,$E3,$09,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$E0,$09
	db $24,$00,$24,$00,$24,$00,$D2,$08,$D0,$08,$D3,$08,$D1,$08,$D4,$08
	db $24,$00,$D5,$08,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00
	db $24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00
	db $24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00
	db $24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$20,$2A,$24,$00,$20,$2A
	db $24,$00,$81,$28,$24,$00,$20,$2A,$24,$00,$20,$2A,$24,$00,$80,$28
	db $24,$00,$7F,$18,$7F,$18,$24,$00,$B8,$08,$BA,$08,$B9,$08,$BB,$08
	db $B8,$08,$BC,$08,$B9,$08,$BD,$08,$BA,$08,$BC,$08,$BB,$08,$BD,$08
	db $60,$08,$64,$08,$61,$08,$65,$08,$62,$08,$66,$08,$63,$08,$67,$08
	db $60,$08,$64,$08,$61,$08,$65,$08,$62,$08,$66,$08,$63,$08,$67,$08
	db $68,$08,$68,$08,$69,$08,$69,$08,$97,$08,$97,$08,$6A,$08,$6A,$08
	db $4B,$10,$4C,$10,$4D,$10,$4E,$10,$4D,$10,$4F,$10,$4D,$10,$4A,$10
	db $4D,$10,$4E,$10,$50,$10,$51,$10,$6B,$18,$70,$18,$2C,$18,$2D,$18
	db $6C,$18,$71,$18,$6D,$18,$72,$18,$6E,$18,$73,$18,$6F,$18,$74,$18
	db $86,$08,$8A,$08,$87,$08,$8B,$08,$88,$08,$8C,$08,$88,$08,$8C,$08
	db $89,$08,$8D,$08,$69,$08,$69,$08,$8E,$08,$91,$08,$8F,$08,$92,$08
	db $98,$08,$93,$08,$98,$08,$93,$08,$90,$08,$94,$08,$69,$08,$69,$08
	db $4A,$1D,$5A,$1D,$4B,$1D,$5B,$1D,$24,$00,$24,$00,$24,$00,$24,$00
	db $24,$00,$2F,$08,$24,$00,$3D,$08,$A2,$18,$A2,$18,$A3,$18,$A3,$18
	db $24,$00,$24,$00,$24,$00,$24,$00

DATA_0395A5:
	db $A2,$18,$A2,$18,$A3,$18,$A3,$18,$99,$18,$24,$00,$99,$18,$24,$00
	db $24,$00,$A2,$18,$3E,$18,$3F,$18,$5B,$18,$5C,$18,$24,$00,$A3,$18
	db $24,$10,$24,$10,$24,$10,$24,$10,$04,$12,$10,$12,$05,$12,$11,$12
	db $06,$12,$12,$12,$05,$12,$11,$12,$06,$12,$12,$12,$07,$12,$13,$12
	db $04,$12,$10,$12,$07,$12,$13,$12,$00,$12,$10,$12,$01,$12,$11,$12
	db $02,$12,$12,$12,$01,$12,$11,$12,$02,$12,$12,$12,$03,$12,$13,$12
	db $00,$12,$10,$12,$03,$12,$13,$12,$14,$12,$16,$12,$15,$12,$17,$12
	db $BE,$0C,$BE,$0C,$BF,$0C,$BF,$0C,$75,$18,$9F,$18,$76,$18,$9F,$58
	db $9F,$18,$9F,$18,$9F,$58,$9F,$58,$45,$0C,$47,$0C,$45,$0C,$47,$0C
	db $47,$0C,$47,$0C,$47,$0C,$47,$0C,$27,$20,$27,$20,$27,$20,$27,$20
	db $47,$2C,$47,$2C,$47,$2C,$47,$2C,$45,$0C,$47,$0C,$45,$0C,$47,$0C
	db $08,$0A,$18,$0A,$09,$0A,$19,$0A,$0A,$0A,$1A,$0A,$0B,$0A,$1B,$0A
	db $45,$0C,$47,$0C,$45,$0C,$47,$0C,$45,$0C,$47,$0C,$45,$0C,$47,$0C
	db $45,$0C,$47,$0C,$45,$0C,$47,$0C,$45,$0C,$47,$0C,$45,$0C,$47,$0C
	db $45,$0C,$47,$0C,$45,$0C,$47,$0C,$47,$0C,$47,$0C,$47,$0C,$47,$0C
	db $47,$0C,$47,$0C,$47,$0C,$47,$0C,$47,$0C,$47,$0C,$47,$0C,$47,$0C
	db $47,$0C,$47,$0C,$47,$0C,$47,$0C,$47,$0C,$47,$0C,$47,$0C,$47,$0C
	db $24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00
	db $AB,$0C,$AC,$0C,$AD,$0C,$AE,$0C,$E6,$09,$F6,$09,$E7,$09,$F7,$09
	db $E8,$09,$F8,$09,$E9,$09,$F9,$09,$E6,$09,$F6,$09,$E9,$09,$F9,$09
	db $CA,$09,$DA,$09,$CB,$09,$DB,$09,$EA,$09,$FA,$09,$EB,$09,$FB,$09
	db $C6,$09,$D6,$09,$C7,$09,$D7,$09,$21,$32,$24,$00,$21,$32,$24,$00
	db $26,$0E,$28,$0E,$27,$0E,$29,$0E,$2A,$0E,$2C,$0E,$2B,$0E,$2D,$0E
	db $2A,$0C,$2A,$0C,$40,$0C,$40,$0C,$24,$00,$24,$00,$24,$00,$24,$00
	db $24,$00,$47,$0C,$24,$00,$47,$0C,$82,$10,$84,$10,$83,$10,$85,$10
	db $16,$09,$18,$09,$17,$09,$19,$09,$18,$09,$19,$09,$18,$09,$19,$09
	db $24,$0C,$47,$0C,$24,$0C,$47,$0C,$86,$08,$8A,$08,$87,$08,$8B,$08
	db $8E,$08,$91,$08,$8F,$08,$92,$08,$24,$00,$2F,$00,$24,$00,$3D,$00

DATA_039765:
	db $24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00
	db $24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00
	db $24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00
	db $EC,$18,$24,$00,$ED,$18,$24,$00,$C8,$10,$A4,$10,$C9,$10,$A4,$10
	db $E0,$38,$E2,$38,$E1,$38,$E3,$38,$EE,$18,$24,$00,$EF,$18,$24,$00
	db $A4,$10,$A4,$10,$A4,$10,$A4,$10,$96,$38,$96,$38,$96,$38,$96,$38
	db $B0,$10,$B1,$10,$B2,$10,$B3,$10,$9B,$0C,$9D,$0C,$9C,$0C,$9E,$0C

DATA_0397D5:
	db $40,$0E,$50,$0E,$41,$0E,$51,$0E,$42,$0E,$52,$0E,$43,$0E,$53,$0E
	db $44,$0E,$54,$0E,$45,$0E,$55,$0E,$46,$0E,$56,$0E,$47,$0E,$57,$0E
	db $48,$0E,$58,$0E,$49,$0E,$59,$0E,$4A,$0E,$5A,$0E,$4B,$0E,$5B,$0E
	db $4B,$4E,$5B,$4E,$4A,$4E,$5A,$4E,$49,$4E,$59,$4E,$48,$4E,$58,$4E
	db $47,$4E,$57,$4E,$46,$4E,$56,$4E,$45,$4E,$55,$4E,$44,$4E,$54,$4E
	db $43,$4E,$53,$4E,$42,$4E,$52,$4E,$41,$4E,$51,$4E,$40,$4E,$50,$4E
	db $63,$0E,$73,$0E,$5C,$0E,$66,$0E,$5D,$0E,$67,$0E,$62,$0E,$72,$0E
	db $72,$0E,$73,$0E,$5E,$0E,$66,$0E,$5F,$0E,$67,$0E,$73,$0E,$72,$0E
	db $24,$00,$24,$00,$60,$0E,$70,$0E,$61,$0E,$71,$0E,$62,$0E,$72,$0E
	db $63,$0E,$73,$0E,$62,$0E,$72,$0E,$63,$0E,$73,$0E,$64,$0E,$74,$0E
	db $65,$0E,$75,$0E,$24,$00,$24,$00,$24,$00,$24,$00,$4C,$0E,$70,$0E
	db $4D,$0E,$71,$0E,$73,$0E,$72,$0E,$72,$0E,$73,$0E,$73,$0E,$72,$0E
	db $72,$0E,$73,$0E,$4E,$0E,$74,$0E,$4F,$0E,$75,$0E,$24,$00,$24,$00
	db $61,$0E,$66,$0E,$62,$0E,$72,$0E,$63,$0E,$73,$0E,$64,$0E,$67,$0E
	db $72,$0E,$73,$0E,$67,$4E,$66,$8E,$66,$4E,$67,$8E,$73,$0E,$72,$0E
	db $40,$0E,$50,$0E,$44,$0E,$54,$0E,$44,$4E,$54,$4E,$40,$4E,$50,$4E
	db $40,$0E,$50,$0E,$42,$0E,$52,$0E,$43,$0E,$53,$0E,$44,$0E,$54,$0E
	db $44,$4E,$54,$4E,$43,$4E,$53,$4E,$42,$4E,$52,$4E,$40,$4E,$50,$4E
	db $24,$00,$24,$00,$CC,$0C,$CE,$0C,$CD,$0C,$CF,$0C,$24,$00,$24,$00
	db $CC,$0C,$CE,$0C,$CD,$0C,$CF,$0C,$53,$04,$55,$04,$54,$04,$56,$04
	db $53,$04,$55,$04,$54,$04,$56,$04,$A5,$04,$A7,$04,$A6,$04,$A8,$04
	db $A5,$04,$A7,$04,$A6,$04,$A8,$04,$EA,$09,$FA,$09,$D2,$09,$E2,$09
	db $EA,$09,$FA,$09,$F2,$09,$FB,$09,$F3,$09,$DA,$09,$CB,$09,$DB,$09
	db $CA,$09,$DA,$09,$C3,$09,$E2,$09,$CA,$09,$DA,$09,$F0,$09,$DB,$09
	db $D2,$09,$E1,$09,$EB,$09,$FB,$09,$F1,$09,$FA,$09,$EB,$09,$FB,$09
	db $C0,$09,$E1,$09,$CB,$09,$DB,$09,$C8,$09,$D4,$09,$C5,$09,$D5,$09
	db $E4,$09,$F4,$09,$E5,$09,$F5,$09,$C8,$09,$D4,$09,$C8,$09,$D4,$09
	db $E4,$09,$F4,$09,$F4,$09,$E4,$09,$CA,$09,$DA,$09,$C3,$09,$D3,$09
	db $EA,$09,$FA,$09,$D2,$09,$D2,$09,$C0,$09,$D0,$09,$CB,$09,$DB,$09
	db $D2,$09,$D2,$09,$EB,$09,$FB,$09,$08,$2A,$18,$2A,$09,$2A,$19,$2A
	db $57,$0C,$59,$0C,$58,$0C,$5A,$0C,$7B,$04,$7D,$04,$7C,$04,$7E,$04

;--------------------------------------------------------------------

DATA_0399C5:
	db $FF

DATA_0399C6:										;\ Info: "THANK YOU MARIO!"
	db $05,$48,$00,$1F								;|
	db $1D,$08,$11,$08,$0A,$08,$17,$08,$14,$08,$24,$00,$22,$08,$18,$08		;|
	db $1E,$08,$24,$00,$16,$08,$0A,$08,$1B,$08,$12,$08,$18,$08,$2B,$08		;|
											;|
	db $FF										;/

DATA_0399EB:										;\ Info: "THANK YOU LUIGI!"
	db $05,$48,$00,$1F								;|
	db $1D,$08,$11,$08,$0A,$08,$17,$08,$14,$08,$24,$00,$22,$08,$18,$08		;|
	db $1E,$08,$24,$00,$15,$08,$1E,$08,$12,$08,$10,$08,$12,$08,$2B,$08		;|
											;|
	db $FF										;/

DATA_039A10:										;\ Info: "BUT OUR PRINCESS IS IN"
	db $05,$C5,$00,$2B								;|
	db $0B,$08,$1E,$08,$1D,$08,$24,$00,$18,$08,$1E,$08,$1B,$08,$24,$00		;|
	db $19,$08,$1B,$08,$12,$08,$17,$08,$0C,$08,$0E,$08,$1C,$08,$1C,$08		;|
	db $24,$00,$12,$08,$1C,$08,$24,$00,$12,$08,$17,$08				;|
											;|
	db $06,$05,$00,$1D								;| "ANOTHER CASTLE!"
	db $0A,$08,$17,$08,$18,$08,$1D,$08,$11,$08,$0E,$08,$1B,$08,$24,$00		;|
	db $0C,$08,$0A,$08,$1C,$08,$1D,$08,$15,$08,$0E,$08,$2B,$08			;|
											;|
	db $FF										;/

DATA_039A63:										;\ Info: "YOUR QUEST IS OVER."
	db $05,$A7,$00,$25								;|
	db $22,$08,$18,$08,$1E,$08,$1B,$08,$24,$00,$1A,$08,$1E,$08,$0E,$08		;|
	db $1C,$08,$1D,$08,$24,$00,$12,$08,$1C,$08,$24,$00,$18,$08,$1F,$08		;|
	db $0E,$08,$1B,$08,$AF,$08							;|
											;|
	db $FF										;/

DATA_039A8E:										;\ Info: "WE PRESENT YOU A NEW QUEST."
	db $05,$E3,$00,$35								;|
	db $20,$08,$0E,$08,$24,$00,$19,$08,$1B,$08,$0E,$08,$1C,$08,$0E,$08		;|
	db $17,$08,$1D,$08,$24,$00,$22,$08,$18,$08,$1E,$08,$24,$00,$0A,$08		;|
	db $24,$00,$17,$08,$0E,$08,$20,$08,$24,$00,$1A,$08,$1E,$08,$0E,$08		;|
	db $1C,$08,$1D,$08,$AF,$08							;|
											;|
	db $FF										;/

DATA_039AC9:										;\ Info: "PUSH BUTTON Y"
	db $06,$4A,$00,$19								;|
	db $19,$08,$1E,$08,$1C,$08,$11,$08,$24,$00,$0B,$08,$1E,$08,$1D,$08		;|
	db $1D,$08,$18,$08,$17,$08,$24,$00,$22,$08					;|
											;|
	db $FF										;/

DATA_039AE8:										;\ Info: "TO START A URA-WORLD"
	db $06,$86,$00,$27								;|
	db $1D,$08,$18,$08,$24,$00,$1C,$08,$1D,$08,$0A,$08,$1B,$08,$1D,$08		;|
	db $24,$00,$0A,$08,$24,$00,$1E,$08,$1B,$08,$0A,$08,$28,$08,$20,$08		;|
	db $18,$08,$1B,$08,$15,$08,$0D,$08						;|
											;|
	db $FF										;/

;--------------------------------------------------------------------

CODE_039B15:
	ASL
	TAY
	PLA
	STA.b $04
	PLA
	STA.b $05
	INY
	LDA.b ($04),y
	STA.b $06
	INY
	LDA.b ($04),y
	STA.b $07
	JMP.w ($0006)

;--------------------------------------------------------------------

CODE_039B2A:
	STZ.b DMA[$00].Parameters
	REP.b #$20
	STZ.w !REGISTER_OAMAddressLo
	LDA.w #(!REGISTER_OAMDataWritePort&$0000FF)|((SMB1_OAMBuffer[$00].XDisp&$0000FF)<<8)			; Note: Also writes to SourceLo
	STA.b DMA[$00].Destination
	LDA.w #SMB1_OAMBuffer[$00].XDisp>>8
	STA.b DMA[$00].SourceHi
	LDA.w #$0220
	STA.b DMA[$00].SizeLo
	LDX.b #$01
	STX.w !REGISTER_DMAEnable
	SEP.b #$20
	LDA.b #$80
	STA.w !REGISTER_OAMAddressHi
	STZ.w !REGISTER_OAMAddressLo
	LDA.w $0B76
	BNE.b CODE_039B61
	JSR.w CODE_039BA2
	LDA.w $028C
	BNE.b CODE_039B9E
	LDA.w $028D
	BEQ.b CODE_039B9E
CODE_039B61:
	REP.b #$20
	LDA.w !RAM_SMB1_Global_GraphicsUploadVRAMAddressLo
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STA.b DMA[$00].Parameters
	LDA.w !RAM_SMB1_Global_GraphicsUploadPointerLo
	STA.b DMA[$00].SourceLo
	LDY.w !RAM_SMB1_Global_GraphicsUploadPointerBank
	STY.b DMA[$00].SourceBank
	LDA.w !RAM_SMB1_Global_GraphicsUploadSizeLo
	STA.b DMA[$00].SizeLo
	STX.w !REGISTER_DMAEnable
	SEP.b #$20
	LDA.w $0B76
	BEQ.b CODE_039B9E
	DEC.w $0B76
	BEQ.b CODE_039B9E
	LDA.w !RAM_SMB1_Global_GraphicsUploadPointerHi
	CLC
	ADC.b #$08
	STA.w !RAM_SMB1_Global_GraphicsUploadPointerHi
	LDA.w !RAM_SMB1_Global_GraphicsUploadVRAMAddressHi
	CLC
	ADC.b #$04
	STA.w !RAM_SMB1_Global_GraphicsUploadVRAMAddressHi
CODE_039B9E:
	STZ.w $028C
	RTS

CODE_039BA2:
	LDA.w $028E
	BEQ.b CODE_039BC8
	REP.b #$20
	LDA.w !RAM_SMB1_Player_VRAMAddressLo
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STA.b DMA[$00].Parameters
	LDA.w !RAM_SMB1_Player_GraphicsPointerLo
	STA.b DMA[$00].SourceLo
	LDY.w !RAM_SMB1_Player_GraphicsPointerBank
	STY.b DMA[$00].SourceBank
	LDA.w !RAM_SMB1_Player_GraphicsUploadSizeLo
	STA.b DMA[$00].SizeLo
	STX.w !REGISTER_DMAEnable
	SEP.b #$20
CODE_039BC8:
	RTS

;--------------------------------------------------------------------

SMB1_UploadStripeImage:
.Main:
;$039BC9
	REP.b #$10
	LDA.b #DATA_0382DE>>16
	STA.w DMA[$01].SourceBank
	STZ.b $06
	LDY.w #$0000
	LDA.b [$00],y
	BPL.b CODE_039BDC
	SEP.b #$30
	RTS

CODE_039BDC:
	STA.b $04
	INY
	LDA.b [$00],y
	STA.b $03
	INY
	LDA.b [$00],y
	AND.b #$80
	ASL
	ROL
	STA.b $07
	LDA.b [$00],y
	AND.b #$40
	STA.b $05
	LSR
	LSR
	LSR
	ORA.b #$01
	STA.w DMA[$01].Parameters
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$01].Destination
	REP.b #$20
	LDA.b $03
	STA.w !REGISTER_VRAMAddressLo
	LDA.b [$00],y
	XBA
	AND.w #$3FFF
	TAX
	INX
	STX.w DMA[$01].SizeLo
	INY
	INY
	TYA
	CLC
	ADC.b $00
	STA.w DMA[$01].SourceLo
	LDA.b $05
	BEQ.b CODE_039C52
	INX
	TXA
	LSR
	TAX
	STX.w DMA[$01].SizeLo
	SEP.b #$20
	LDA.b $05
	LSR
	LSR
	LSR
	STA.w DMA[$01].Parameters
	LDA.b $07
	STA.w !REGISTER_VRAMAddressIncrementValue
	LDA.b #$02
	STA.w !REGISTER_DMAEnable
	LDA.b #!REGISTER_WriteToVRAMPortHi
	STA.w DMA[$01].Destination
	REP.b #$21
	TYA
	ADC.b $00
	INC
	STA.w DMA[$01].SourceLo
	LDA.b $03
	STA.w !REGISTER_VRAMAddressLo
	STX.w DMA[$01].SizeLo
	LDX.w #$0002
CODE_039C52:
	STX.b $03
	TYA
	CLC
	ADC.b $03
	TAY
	SEP.b #$20
	LDA.b $07
	ORA.b #$80
	STA.w !REGISTER_VRAMAddressIncrementValue
	LDA.b #$02
	STA.w !REGISTER_DMAEnable
	LDA.b [$00],y
	BMI.b CODE_039C6E
	JMP.w CODE_039BDC

CODE_039C6E:
	SEP.b #$30
	RTS

;--------------------------------------------------------------------

; Note: Routine that updates the status bar/TOP score.

DATA_039C71:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	db $58,$6D,$04
	db $00,$00,$20
	db $00,$20,$58
	db $62,$0C,$00
	db $00,$20,$00
	db $20,$00,$20
	db $00,$20,$00
	db $20,$00,$20
	db $FF,$7A,$06
	db $00,$00,$20
	db $00,$20,$00
	db $20,$FF

DATA_039CA5:
	db $06,$0C,$0C,$04,$04,$1C

DATA_039CAB:
	db $00,$06,$0C,$16,$1C,$21

else
	db $EF,$00,$06
	db $00,$62,$00
	db $06,$00,$62
	db $00,$06,$00
	db $6D,$00,$02
	db $00,$6D,$00
	db $02,$00,$7A
	db $00,$03,$00

DATA_039C89:
	db $06,$0C,$12
	db $18,$1E,$24
endif

CODE_039C8F:
	STA.b $00
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	CMP.b #$FA
	BEQ.b +++
	LDX.b #$22
-:
	LDA.w DATA_039C71,x
	STA.w $1620,x
	DEX
	BPL.b -
	LDX.w $0EC3
	LDA.w DATA_03BD32,x
	AND.b #$0F
	JSR.w ++
	LDX.w $0EC3
	LDA.w DATA_03BD32,x
	LSR
	LSR
	LSR
	LSR
	JSR.w ++
	LDA.w $162C
	BNE.b +
	LDA.b #$28
	STA.w $162C
+:
	LDA.b $00
	AND.b #$0F
	CMP.b #$04
	BNE.b +
	LDA.b #$58
	STA.w $1638
	LDA.b #$04
++:
	INC
	TAY
	LDA.w DATA_039CA5,y
	TAX
	LDA.w DATA_039C71-$02,x
	LSR
	STA.b $02
	LDA.w DATA_039CAB,y
	TAY
-:
	LDA.w !RAM_SMB1_TitleScreen_TopScoreMillionsDigit,y
	STA.w $1620,x
	INY
	INX
	INX
	DEC.b $02
	BNE.b -
+:
if !Define_Global_ROMToAssemble&(!ROM_SMB1_E) != $00
+++:
	RTS
else
	RTS

+++:
	LDX.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	LDA.b #$02
	STA.w SMB1_StripeImageUploadTable[$00].LowByte,x
	LDA.b #$EF
	STA.w SMB1_StripeImageUploadTable[$00].HighByte,x
	LDA.b #$00
	STA.w SMB1_StripeImageUploadTable[$01].LowByte,x
	LDA.b #$0B
	STA.w SMB1_StripeImageUploadTable[$01].HighByte,x
	LDA.b #$06
	STA.b $02
	LDY.b #$00
-:
	LDA.w !RAM_SMB1_TitleScreen_TopScoreMillionsDigit,y
	STA.w SMB1_StripeImageUploadTable[$02].LowByte,x
	LDA.b #$28
	STA.w SMB1_StripeImageUploadTable[$02].HighByte,x
	INY
	INX
	INX
	DEC.b $02
	BNE.b -
	LDA.b #$FF
	STA.w SMB1_StripeImageUploadTable[$02].LowByte,x
	INX
	INX
	INX
	INX
	STX.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	LDA.w $16F6,x
	BNE.b CODE_039CFD
	LDA.b #$24
	STA.w $16F6,x
endif
else
	JSR.w CODE_039C9A
	LDA.b $00
	LSR
	LSR
	LSR
	LSR
CODE_039C9A:
	CLC
	ADC.b #$01
	AND.b #$0F
	CMP.b #$06
	BCS.b CODE_039CFD
	PHA
	ASL
	ASL
	TAY
	LDA.b #$58
	LDX.b #$20
	CPY.b #$00
	BNE.b CODE_039CB3
if !Define_Global_ROMToAssemble&(!ROM_SMB1_U|!ROM_SMB1_J) != $00
	PLA
	RTS
else
	LDA.b #$02
	LDX.b #$28
endif
CODE_039CB3:
	STX.b !RAM_SMB1_Global_ScratchRAMF9
	LDX.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	STA.w SMB1_StripeImageUploadTable[$00].LowByte,x
	LDA.w DATA_039C71,y
	STA.w SMB1_StripeImageUploadTable[$00].HighByte,x
	LDA.w DATA_039C71+$01,y
	STA.w SMB1_StripeImageUploadTable[$01].LowByte,x
	LDA.w DATA_039C71+$02,y
	STA.b $03
	ASL
	DEC
	STA.w SMB1_StripeImageUploadTable[$01].HighByte,x
	STX.b $02
	PLA
	TAX
	LDA.w DATA_039C89,x
	SEC
	SBC.w DATA_039C71+$02,y
	TAY
	LDX.b $02
CODE_039CDF:
	LDA.w !RAM_SMB1_TitleScreen_TopScoreMillionsDigit,y
	STA.w SMB1_StripeImageUploadTable[$02].LowByte,x
	LDA.b !RAM_SMB1_Global_ScratchRAMF9
	STA.w SMB1_StripeImageUploadTable[$02].HighByte,x
	INX
	INX
	INY
	DEC.b $03
	BNE.b CODE_039CDF
	LDA.b #$FF
	STA.w SMB1_StripeImageUploadTable[$02].LowByte,x
	INX
	INX
	INX
	INX
	STX.w !RAM_SMB1_Global_StripeImageUploadIndexLo
endif
CODE_039CFD:
	RTS

CODE_039CFE:
	PHB
	PHK
	PLB
	JSR.w CODE_039C8F
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDA.b #$28
	STA.w $163C
	STA.w $163E
	STA.w $1640
endif
	PLB
	RTL

;--------------------------------------------------------------------

; Note: PAL exclusive routine.

if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
CODE_039D6A:
	LDA.w $1620
	BMI.b CODE_039DB6
	LDA.b #$001620>>16
	STA.w DMA[$00].SourceBank
	LDA.b #$01
	STA.w DMA[$00].Parameters
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination
	LDA.b #$80
	STA.w !REGISTER_VRAMAddressIncrementValue
	LDY.b #$00
	LDA.w $1620,y
CODE_039D88:
	STA.w !REGISTER_VRAMAddressHi
	INY
	LDA.w $1620,y
	STA.w !REGISTER_VRAMAddressLo
	INY
	REP.b #$21
	LDA.w $1620,y
	STA.w DMA[$00].SizeLo
	STA.b $00
	INY
	INY
	TYA
	ADC.w #$001620
	STA.w DMA[$00].SourceLo
	TYA
	ADC.b $00
	TAY
	SEP.b #$20
	LDA.b #$01
	STA.w !REGISTER_DMAEnable
	LDA.w $1620,y
	BPL.b CODE_039D88
CODE_039DB6:
	RTS
endif

;--------------------------------------------------------------------

CODE_039D06:
	LDA.w !RAM_SMB1_Global_GameMode
	CMP.b #$00
	BEQ.b CODE_039D2E
	CMP.b #$02
	BNE.b CODE_039D18
	LDA.w $0772
	CMP.b #$05
	BNE.b CODE_039D2E
CODE_039D18:
	LDX.b #$05
CODE_039D1A:
	LDA.w !RAM_SMB1_Level_ScoreSpr_AddToScoreBuffer,x
	CLC
	ADC.w !RAM_SMB1_TitleScreen_TopScoreMillionsDigit,y
	BMI.b CODE_039D39
	CMP.b #$0A
	BCS.b CODE_039D40
CODE_039D27:
	STA.w !RAM_SMB1_TitleScreen_TopScoreMillionsDigit,y
	DEY
	DEX
	BPL.b CODE_039D1A
CODE_039D2E:
	LDA.b #$00
	LDX.b #$06
CODE_039D32:
	STA.w $0144,x
	DEX
	BPL.b CODE_039D32
	RTS

CODE_039D39:
	DEC.w $0144,x
	LDA.b #$09
	BNE.b CODE_039D27

CODE_039D40:
	CPX.b #$00
	BNE.b CODE_039D50
	LDX.b #$05
	LDA.b #$09
CODE_039D48:
	STA.w !RAM_SMB1_Player_MariosScoreMillionsDigit,x
	DEX
	BNE.b CODE_039D48
	LDA.b #$13
CODE_039D50:
	SEC
	SBC.b #$0A
	INC.w $0144,x
	BRA.b CODE_039D27

if !Define_Global_ROMToAssemble&(!ROM_SMAS_U) != $00
	%FREE_BYTES(NULLROM, 37, $FF)
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1) != $00
	%FREE_BYTES(NULLROM, 58, $FF)
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J2|!ROM_SMB1_J) != $00
	%FREE_BYTES(NULLROM, 45, $FF)
elseif !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	%FREE_BYTES(NULLROM, 23, $FF)
else
	%FREE_BYTES(NULLROM, 24, $FF)
endif

;--------------------------------------------------------------------

DATA_039D70:
	db $D0,$00,$18,$30,$48,$60,$78,$90
	db $A8,$C0,$D8,$D8,$B0,$C0,$40,$44
	db $48,$50,$54,$60,$68,$70,$78,$80
	db $88,$00,$08,$10,$18,$18,$FF,$23
	db $58

;--------------------------------------------------------------------

CODE_039D91:
	LDA.b #$80
	STA.w !RAM_SMB1_Global_ScreenDisplayRegisterMirror
	LDA.b #$FF
	STA.w SMB1_PaletteMirror[$81].LowByte
	LDA.b #$7F
	STA.w SMB1_PaletteMirror[$81].HighByte
	INC.w !RAM_SMB1_Global_UpdateEntirePaletteFlag
	LDA.b #$FF
	STA.w SMB1_StripeImageUploadTable[$00].LowByte
	STA.w SMB1_StripeImageUploadTable[$00].HighByte
	LDA.b #$09
	STA.w !RAM_SMB1_Global_BGModeAndTileSizeSettingMirror
	LDA.b #$10
	STA.w !RAM_SMB1_Global_MainScreenLayersMirror
	LDA.b #$20
	STA.w !RAM_SMB1_Global_ColorMathSelectAndEnableMirror
	LDA.b #$20
	STA.w !RAM_SMB1_Global_FixedColorData1Mirror
	LDA.b #$40
	STA.w !RAM_SMB1_Global_FixedColorData2Mirror
	LDA.b #$80
	STA.w !RAM_SMB1_Global_FixedColorData3Mirror
	LDY.b #$FE
	LDX.b #$05
CODE_039DCD:
	LDA.w !RAM_SMB1_TitleScreen_TopScoreMillionsDigit,x
	CMP.b #$0A
	BCS.b CODE_039DE0
	DEX
	BPL.b CODE_039DCD
	LDA.w $07FF
	CMP.b #$A5
	BNE.b CODE_039DE0
	LDY.b #$C7
CODE_039DE0:
	JSR.w CODE_039F3E
	LDA.b #$A5
	STA.w $07FF
	STA.w !RAM_SMB1_Global_RandomByte1
	STZ.w $0EF6
	STZ.w $0EF9
	STZ.w $0EF7
	STZ.w $0EF8
	LDY.b #$6F
	JSR.w CODE_039F3E
	LDA.b #$18
	STA.w !RAM_SMB1_TitleScreen_WaitBeforePlayingDemo
	JSL.l CODE_04C00B
	JSR.w SMB1_Level_State00_InitializeLevelPreview_Main
	STZ.w !RAM_SMB1_Global_FadeDirection
	RTS

;--------------------------------------------------------------------

SMB1_Level_State00_InitializeLevelPreview:
.Main:
;$039E0C
	LDY.w !RAM_SMB1_Player_CurrentWorld
	CPY.b #$08
	BCC.b CODE_039E17
	JSL.l CODE_04C00B
CODE_039E17:
	LDY.b #$4B
	JSR.w CODE_039F3E
	LDX.b #$29
	LDA.b #$00
CODE_039E20:
	STA.w $0788,x
	DEX
	BPL.b CODE_039E20
	LDA.w !RAM_SMB1_Player_CurrentStartingScreen
	LDY.w !RAM_SMB1_Level_Player_TriggeredScreenExitFlag
	BEQ.b CODE_039E31
	LDA.w !RAM_SMB1_Level_SublevelStartingScreen
CODE_039E31:
	STA.w !RAM_SMB1_Global_CurrentLayer1XPosHi
	STA.w $0725
	STA.w $0728
	PHY
	REP.b #$20
	XBA
	AND.w #$FF00
	STA.b $42
	LSR
	STA.w !RAM_SMB1_Global_CurrentLayer2XPosLo
	LSR
	STA.w !RAM_SMB1_Global_CurrentLayer3XPosLo
	SEP.b #$20
	PLY
	JSR.w CODE_03AF0F
	LDY.b #$00
	AND.b #$01
	BEQ.b CODE_039E59
	LDY.b #$04
CODE_039E59:
	STY.w $0720
	STZ.w $0721
	ASL
	ASL
	ASL
	ASL
	STA.w $06A0
	LDA.b #$FF
	STA.w $1300
	STA.w $1301
	STA.w $1302
	STA.w $1303
	STA.w $1304
	LDA.b #$0B
	STA.w $071E
	JSL.l CODE_04C041
	LDA.w !RAM_SMB1_Global_UseHardModeEnemyBehaviorFlag
	BNE.b CODE_039E95
	LDA.w !RAM_SMB1_Player_CurrentWorld
	CMP.b #$04
	BCC.b CODE_039E98
	BNE.b CODE_039E95
	LDA.w !RAM_SMB1_Player_CurrentLevelNumberDisplay
	CMP.b #$02
	BCC.b CODE_039E98
CODE_039E95:
	INC.w !RAM_SMB1_Global_UseLateStageSpriteBehaviorFlag				; Note: This flag is set when entering level 5-3.
CODE_039E98:
	LDA.w !RAM_SMB1_Player_CurrentStartingScreen
	BEQ.b CODE_039EA2
	LDA.b #$02
	STA.w !RAM_SMB1_Player_LevelEntrancePositionIndex
CODE_039EA2:
	LDA.b $DB
	CMP.b #$21
	BEQ.b CODE_039EB1
	CMP.b #$02
	BEQ.b CODE_039EB1
	LDA.b #!Define_SMB1_LevelMusic_MusicFade
	STA.w !RAM_SMB1_Global_MusicCh1
CODE_039EB1:
	LDA.b #$01
	STA.w !RAM_SMB1_Global_FadeDirection
	INC.w $0772
	RTS

;--------------------------------------------------------------------

CODE_039EBA:
	LDA.w !REGISTER_APUPort2
	CMP.b #!Define_SMB1_LevelMusic_SMB1TitleScreen
	BEQ.b CODE_039ECA
	JSL.l SMB1_CheckWhichControllersArePluggedIn_Main				; Note: Call to SMAS function
	LDA.b #!Define_SMB1_LevelMusic_SMB1TitleScreen
	STA.w !REGISTER_APUPort2
if !Define_Global_ROMToAssemble&(!ROM_SMB1_U|!ROM_SMB1_E|!ROM_SMB1_J) != $00
	LDA.b #$04									;\ Note: This is needed to give the title screen music a chance to play
	STA.w $160C									;/ A value of #$02 is good enough, but I set it to #$04 just to be safe
endif
CODE_039ECA:
	LDA.b #$01
	STA.w $0757
	STA.w !RAM_SMB1_Player_CurrentSize
	STA.w $077F
	STZ.w !RAM_SMB1_Level_FreeMovementDebugFlag
CODE_039ED8:
	LDA.b #$02
	STA.w !RAM_SMB1_Global_FadeDirection
	LDA.b #$00
	STA.w !RAM_SMB1_Global_ScreenDisplayRegisterMirror
	STA.w $0774
	TAY
CODE_039EE6:
	STA.w !RAM_SMB1_Level_BridgeSpr_SpriteSlotExistsFlag,y
	INY
	BNE.b CODE_039EE6
	STA.w $0759
	STA.w $0769
	STA.w $0728
	LDA.b #$FF
	STA.w $03A0
	STA.w SMB1_StripeImageUploadTable[$00].LowByte
	LDA.w $071A
	LSR.w $0778
	AND.b #$01
	ROR
	ROL.w $0778
	LDA.b #$38
	STA.w $0B43
	LDA.b #$48
	STA.w $0B42
	LDA.b #$58
	STA.w $0B41
	LDX.b #$1C
CODE_039F1A:
	LDA.w DATA_039D70,x
	STA.w !RAM_SMB1_Level_SpriteOAMIndexTable,x
	DEX
	BPL.b CODE_039F1A
	JSR.w CODE_03A294
	JSR.w CODE_03A28F
	INC.w !RAM_SMB1_Global_CopyOfDisableSpriteOAMResetFlag
	INC.w $0772
	RTS

;--------------------------------------------------------------------

CODE_039F30:
	LDA.b #$00
	STA.b $06
	STX.b $07
CODE_039F36:
	STA.b ($06),y
	DEY
	CPY.b #$FF
	BNE.b CODE_039F36
	RTS

;--------------------------------------------------------------------

CODE_039F3E:
	LDA.w $00DB
	CMP.b #$21
	BNE.b CODE_039F48
	INC.w !RAM_SMB1_Global_FadeDirection
CODE_039F48:
	LDX.b #$07
	LDA.b #$00
	STA.b $06
CODE_039F4E:
	STX.b $07
CODE_039F50:
	CPX.b #$01
	BNE.b CODE_039F58
	CPY.b #$50
	BCS.b CODE_039F5A
CODE_039F58:
	STA.b ($06),y
CODE_039F5A:
	DEY
	CPY.b #$FF
	BNE.b CODE_039F50
	DEX
	BPL.b CODE_039F4E
	LDA.b #$FF
	STA.w SMB1_StripeImageUploadTable[$00].LowByte
	INC
	STZ.w !RAM_Level_ContactSpr_AnimationFrame
	STZ.w !RAM_Level_ContactSpr_AnimationFrame+$01
	STZ.w !RAM_Level_ContactSpr_AnimationFrame+$02
	STZ.w !RAM_Level_ContactSpr_AnimationFrame+$03
	STZ.w !RAM_Level_ContactSpr_AnimationFrame+$04
	LDA.w !RAM_SMB1_Player_HardModeActiveFlag
	STA.w !RAM_SMB1_Global_UseHardModeEnemyBehaviorFlag
	LDX.b #$40
CODE_039F7F:
	STZ.w $0F00,x
	INX
	BNE.b CODE_039F7F
	LDA.w $0F0B
	BEQ.b CODE_039FA1
	DEC
	STA.w $0F0B
	BNE.b CODE_039FA1
	LDA.l !RAM_SMB1_Global_SaveBuffer_HardModeActiveFlag
	STA.w $07FB
	STA.w !RAM_SMB1_Global_UseHardModeEnemyBehaviorFlag
	STA.w !RAM_SMB1_Player_HardModeActiveFlag
	JSL.l CODE_05C994
CODE_039FA1:
	RTS

;--------------------------------------------------------------------

DATA_039FA2:
	db $28,$18

DATA_039FA4:
	db $38,$28,$08,$00

DATA_039FA8:
	db $00,$20,$B0,$50,$00,$00,$B0,$B0
	db $F0

DATA_039FB1:
	db $2E,$0E,$2E,$2E,$2E,$2E,$2E,$2E

DATA_039FB9:
	db $0E,$04,$03,$02

CODE_039FBD:
	LDA.w $071A
	STA.b !RAM_SMB1_Player_XPosHi
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDA.b #$70
else
	LDA.b #$28
endif
	STA.w $070A
	LDA.b #$01
	STA.w !RAM_SMB1_Level_Player_FacingDirection
	STA.b !RAM_SMB1_Player_YPosHi
	LDA.b #$00
	STA.b !RAM_SMB1_Level_Player_CurrentPhysicsType
	DEC.w $0480
	LDY.b #$00
	STY.w !RAM_SMB1_Player_CurrentStartingScreen
	LDA.b !RAM_SMB1_Level_CurrentLevelType
	BNE.b CODE_039FDF
	INY
CODE_039FDF:
	STY.w !RAM_SMB1_Level_UnderwaterLevelFlag
	LDX.w !RAM_SMB1_Player_LevelEntrancePositionIndex
	LDY.w !RAM_SMB1_Level_Player_TriggeredScreenExitFlag
	BEQ.b CODE_039FF1
	CPY.b #$01
	BEQ.b CODE_039FF1
	LDX.w DATA_039FA4,y
CODE_039FF1:
	LDA.w DATA_039FA2,y
	STA.w !RAM_SMB1_Player_XPosLo
	LDA.w DATA_039FA8,x
	STA.w !RAM_SMB1_Player_YPosLo
	LDA.w DATA_039FB1,x
	STA.w $0256
	LDX.b #$00
	JSR.w CODE_03EA2D
	JSL.l CODE_049A88
	LDY.w $0715
	BEQ.b CODE_03A02B
	LDA.w $0757
	BEQ.b CODE_03A02B
	LDA.w DATA_039FB9,y
	STA.w !RAM_SMB1_Level_TimerHundreds
	LDA.b #$01
	STA.w !RAM_SMB1_Level_TimerOnes
	LSR
	STA.w !RAM_SMB1_Level_TimerTens
	STA.w $0757
	STA.w !RAM_SMB1_Player_StarPowerTimer
CODE_03A02B:
	LDY.w !RAM_SMB1_Player_VineScreenExitFlag
	BEQ.b CODE_03A044
	LDA.b #$03
	STA.b !RAM_SMB1_Level_Player_CurrentPhysicsType
	LDX.b #$00
	JSR.w CODE_03BF15
	LDA.b #$F0
	STA.b $44
	LDX.b #$09
	LDY.b #$00
	JSR.w SMB1_NorSpr02F_Vine_InitializationRt_Main
CODE_03A044:
	LDY.b !RAM_SMB1_Level_CurrentLevelType
	BNE.b CODE_03A04B
	JSR.w CODE_03B793
CODE_03A04B:
	LDA.b #$07
	STA.b !RAM_SMB1_Player_CurrentState
	RTS

;--------------------------------------------------------------------

DATA_03A050:
	db $56,$40,$65,$70,$66,$40,$66,$40
	db $66,$40,$66,$60,$65,$70,$00,$00

CODE_03A060:
	LDA.b #$01
	STA.w !RAM_SMB1_Global_FadeDirection
	STA.w $0E67
	STZ.w !RAM_SMB1_Global_CopyOfDisableSpriteOAMResetFlag
	DEC.w !RAM_SMB1_Player_CurrentLifeCount
	BPL.b CODE_03A079
	STZ.w $0772
	LDA.b #$03
	STA.w !RAM_SMB1_Global_GameMode
	RTS

CODE_03A079:
	LDA.w !RAM_SMB1_Player_CurrentWorld
	ASL
	TAX
	LDA.w !RAM_SMB1_Player_CurrentLevelNumberDisplay
	AND.b #$02
	BEQ.b CODE_03A086
	INX
CODE_03A086:
	LDY.w DATA_03A050,x
	LDA.w !RAM_SMB1_Player_CurrentLevelNumberDisplay
	LSR
	TYA
	BCS.b CODE_03A094
	LSR
	LSR
	LSR
	LSR
CODE_03A094:
	AND.b #$0F
	CMP.w $071A
	BEQ.b CODE_03A09F
	BCC.b CODE_03A09F
	LDA.b #$00
CODE_03A09F:
	STA.w !RAM_SMB1_Player_CurrentStartingScreen
	JSR.w CODE_03A22B
	JMP.w CODE_03A204

;--------------------------------------------------------------------

SMB1_GameMode03_GameOverScreen:
.Main:
;$03A0A8
	LDA.w !RAM_SMB1_GameOver_CurrentState
	ASL
	TAX
	JMP.w (DATA_03A0B0,x)

DATA_03A0B0:
	dw SMB1_GameOverScreen_State00_InitializeRAM_Main
	dw CODE_038C25
	dw SMB1_GameOverScreen_State02_ProcessGameOverScreen_Main

;--------------------------------------------------------------------

SMB1_GameOverScreen_State00_InitializeRAM:
.Main:
;$03A0B6
	STZ.w $073C
	STZ.w !RAM_SMB1_Global_CopyOfDisableSpriteOAMResetFlag
	LDA.b #!Define_SMB1_LevelMusic_GameOver
	STA.w !RAM_SMB1_Global_MusicCh1
	INC.w $0774
	INC.w !RAM_SMB1_GameOver_CurrentState
	RTS

;--------------------------------------------------------------------

DATA_03A0C8:
	db $42,$73,$0C,$2B

DATA_03A0CC:
	db $63,$73,$83

CODE_03A0CF:
	LDA.w !RAM_SMB1_Level_TwoPlayerGameFlag
	BEQ.b CODE_03A0DC
	LDA.w !RAM_SMB1_Player_OtherPlayersLifeCount
	BMI.b CODE_03A0DC
	JMP.w CODE_03A1E4

CODE_03A0DC:
	LDA.w !RAM_SMB1_Global_ControllerPress1P1
	ORA.w !RAM_SMB1_Global_ControllerPress1P2
	STA.w !RAM_SMB1_Global_ControllerPress1P1
	AND.b #(!Joypad_DPadU>>8)|(!Joypad_DPadD>>8)
	BEQ.b CODE_03A107
	LDY.b #!Define_SMAS_Sound0063_Coin
	STY.w !RAM_SMB1_Global_SoundCh3
	LDY.w !RAM_SMB1_GameOverScreen_BlinkingCursorPos
	AND.b #$08
	BEQ.b CODE_03A0FB
	DEY
	BPL.b CODE_03A104
	INY
	BRA.b CODE_03A101

CODE_03A0FB:
	INY
	CPY.b #$03
	BNE.b CODE_03A104
	DEY
CODE_03A101:
	STZ.w !RAM_SMB1_Global_SoundCh3
CODE_03A104:
	STY.w !RAM_SMB1_GameOverScreen_BlinkingCursorPos
CODE_03A107:
	LDA.w $0F8A
	BNE.b CODE_03A181
	LDA.w !RAM_SMB1_Global_ControllerPress1P1
	ORA.w !RAM_SMB1_Global_ControllerPress1P2
	AND.b #!Joypad_Start>>8
	BNE.b CODE_03A168
	LDA.w !RAM_SMB1_Global_ControllerPress1P1
	ORA.w !RAM_SMB1_Global_ControllerPress1P2
	AND.b #!Joypad_Select>>8
	BEQ.b CODE_03A132
	LDA.b #!Define_SMAS_Sound0063_Coin
	STA.w !RAM_SMB1_Global_SoundCh3
	INC.w !RAM_SMB1_GameOverScreen_BlinkingCursorPos
	LDA.w !RAM_SMB1_GameOverScreen_BlinkingCursorPos
	CMP.b #$03
	BNE.b CODE_03A132
	STZ.w !RAM_SMB1_GameOverScreen_BlinkingCursorPos
CODE_03A132:
	LDA.w !RAM_SMB1_Player_CurrentWorld
	CMP.b #$08
	BNE.b CODE_03A13A
	RTS

CODE_03A13A:
	LDA.w !RAM_SMB1_Global_SoundCh3
	BEQ.b CODE_03A142
	STZ.w !RAM_SMB1_Global_BlinkingCursorFrameCounter
CODE_03A142:
	INC.w !RAM_SMB1_Global_BlinkingCursorFrameCounter
	LDA.w !RAM_SMB1_Global_BlinkingCursorFrameCounter
	AND.b #$10
	LSR
	LSR
	LSR
	LSR
	ORA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot
	LDY.b #$03
CODE_03A155:
	LDA.w DATA_03A0C8,y
	STA.w SMB1_OAMBuffer[$00].XDisp,y
	DEY
	BPL.b CODE_03A155
	LDY.w !RAM_SMB1_GameOverScreen_BlinkingCursorPos
	LDA.w DATA_03A0CC,y
	STA.w SMB1_OAMBuffer[$00].YDisp
	RTS

CODE_03A168:
	LDA.b #$20
	STA.w $0F8A
	LDA.b #!Define_SMAS_Sound0060_Pause1
	STA.w !RAM_SMB1_Global_SoundCh1
	LDA.b #!Define_SMB1_LevelMusic_CopyOfMusicFade
	STA.w !RAM_SMB1_Global_MusicCh1
	LDA.w !RAM_SMB1_GameOverScreen_BlinkingCursorPos
	BEQ.b CODE_03A181
	LDA.b #!Define_SMAS_Sound0060_SaveGame
	STA.w !RAM_SMB1_Global_SoundCh1
CODE_03A181:
	JSR.w CODE_03A142
	DEC.w $0F8A
	LDA.w $0F8A
	BEQ.b CODE_03A18D
	RTS

CODE_03A18D:
	STZ.w !RAM_SMB1_Global_BlinkingCursorFrameCounter
	LDY.b #$04
	STY.w !RAM_SMB1_Player_CurrentLifeCount
	STZ.w $0F03
	STZ.w !RAM_SMB1_Player_CurrentCoinCount
	STZ.w !RAM_SMB1_Player_OtherPlayersCoinCount
	LDA.w !RAM_SMB1_Player_CurrentWorld
	STA.w !RAM_SMB1_Player_CurrentWorld
	STA.l !SRAM_SMAS_Global_InitialSelectedWorld
	STZ.w !RAM_SMB1_Player_CurrentLevelNumberDisplay
	STZ.w $0E24
	STZ.w !RAM_SMB1_Player_OtherPlayersLevelNumberDisplay
	STZ.w !RAM_SMB1_Player_OtherPlayersLevel
	STZ.w !RAM_SMB1_Player_CurrentLevel
	LDA.b #$00
	STA.l !SRAM_SMAS_Global_InitialSelectedLevel
	LDA.b #$00
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_J1) != $00
	LDY.b #$11
else
	LDY.b #$17
endif
CODE_03A1C1:
	STA.w !RAM_SMB1_Player_MariosScoreMillionsDigit,y
	DEY
	BPL.b CODE_03A1C1
	INC.w !RAM_SMB1_Level_CanFindHidden1upFlag
	LDA.w !RAM_SMB1_GameOverScreen_BlinkingCursorPos
	BEQ.b CODE_03A1DE
	JSL.l SMB1_SaveGame_Main
	LDA.w !RAM_SMB1_GameOverScreen_BlinkingCursorPos
	CMP.b #$01
	BEQ.b CODE_03A1DE
if !Define_Global_ROMToAssemble&(!ROM_SMB1_U|!ROM_SMB1_E|!ROM_SMB1_J) != $00
	JML.l SMB1_ResetGame_Main
else
	JML.l SMAS_ResetToSMASTitleScreen_Main				; Note: Call to SMAS function
endif

CODE_03A1DE:
	JMP.w CODE_03A1EF

SMB1_GameOverScreen_State02_ProcessGameOverScreen:
.Main:
	JMP.w CODE_03A0CF

CODE_03A1E4:
	JSL.l CODE_048650
	JMP.w (DATA_03A1EB,x)

DATA_03A1EB:
	dw CODE_03A22A
	dw CODE_03A1EF

;--------------------------------------------------------------------

CODE_03A1EF:
	JSR.w CODE_03A22B
	BCC.b CODE_03A204
	LDA.w !RAM_SMB1_Player_CurrentWorld
	STA.w $07FD
	STZ.w $0772
	STZ.w $07B0
	STZ.w !RAM_SMB1_Global_GameMode
	RTS

CODE_03A204:
	JSL.l CODE_04C00B
	LDA.w $1680
	BNE.b CODE_03A21A
	LDA.w !RAM_SMB1_Level_TwoPlayerGameFlag
	BNE.b CODE_03A21A
	LDA.b #$01
	STA.w !RAM_SMB1_Player_CurrentSize
	STZ.w !RAM_SMB1_Player_CurrentPowerUp
CODE_03A21A:
	INC.w $0757
	STZ.w !RAM_SMB1_Level_FreezeSpritesTimer
	STZ.b !RAM_SMB1_Player_CurrentState
	STZ.w $0772
	LDA.b #$01
	STA.w !RAM_SMB1_Global_GameMode
CODE_03A22A:
	RTS

;--------------------------------------------------------------------

CODE_03A22B:
	SEC
	LDA.w !RAM_SMB1_Level_TwoPlayerGameFlag
	BEQ.b CODE_03A280
	LDA.w !RAM_SMB1_Player_OtherPlayersLifeCount
	BMI.b CODE_03A280
	LDA.w !RAM_SMB1_Player_CurrentSize
	PHA
	LDA.w $077F
	STA.w !RAM_SMB1_Player_CurrentSize
	PLA
	STA.w $077F
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMB1_J) != $00
	LDA.w !RAM_SMB1_Player_HardModeActiveFlag
	PHA
	LDA.w $0781
	STA.w !RAM_SMB1_Player_HardModeActiveFlag
	PLA
	STA.w $0781
endif
	LDA.w !RAM_SMB1_Player_CurrentPowerUp
	PHA
	LDA.w $0780
	STA.w !RAM_SMB1_Player_CurrentPowerUp
	PLA
	STA.w $0780
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMB1_J) == $00
	LDA.w !RAM_SMB1_Player_HardModeActiveFlag
	PHA
	LDA.w $0781
	STA.w !RAM_SMB1_Player_HardModeActiveFlag
	PLA
	STA.w $0781
endif
	LDA.w !RAM_SMB1_Player_CurrentCharacter
	EOR.b #$01
	STA.w !RAM_SMB1_Player_CurrentCharacter
	STA.w !RAM_SMB1_Global_UseLuigisPlayerGraphics					; Optimization: Unnecessary. This flag is pointless.
	LDX.b #$06
CODE_03A26D:
	LDA.w !RAM_SMB1_Player_CurrentLifeCount,x
	PHA
	LDA.w !RAM_SMB1_Player_OtherPlayersLifeCount,x
	STA.w !RAM_SMB1_Player_CurrentLifeCount,x
	PLA
	STA.w !RAM_SMB1_Player_OtherPlayersLifeCount,x
	DEX
	BPL.b CODE_03A26D
	CLC
CODE_03A27F:
	RTS

CODE_03A280:
	LDA.w $0F03
	BNE.b CODE_03A27F
	CLC
	RTS

CODE_03A287:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMB1_J) != $00
	JSR.w CODE_03A22B
else
	PHB
	PHK
	PLB
	JSR.w CODE_03A22B
	PLB
endif
	RTL

;--------------------------------------------------------------------

CODE_03A28F:
	LDA.b #$FF
	STA.w $06C9
CODE_03A294:
	RTS

;--------------------------------------------------------------------

CODE_03A295:
	LDY.w $071F
	BNE.b CODE_03A29F
	LDY.b #$08
	STY.w $071F
CODE_03A29F:
	DEY
	TYA
	JSR.w CODE_03A300
	DEC.w $071F
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDA.b #$10
else
	BNE.b CODE_03A2DE
	LDA.b #$20
endif
	STA.b $00
	LDA.b $BA
	CMP.b #$03
	BNE.b CODE_03A2B5
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDA.b #$40
	STA.b $00
else
	ASL.b $00
endif
CODE_03A2B5:
	LDA.w $0ED1
	BNE.b CODE_03A2DE
	LDA.w !RAM_SMB1_Global_CurrentLayer2XPosLo
	AND.b $00
	BEQ.b CODE_03A2C8
	LDA.w $0EFC
	BEQ.b CODE_03A2D2
	BRA.b CODE_03A2DE

CODE_03A2C8:
	LDA.w $0EFC
	BEQ.b CODE_03A2DE
	STZ.w $0EFC
	BRA.b CODE_03A2D7

CODE_03A2D2:
	LDA.b #$01
	STA.w $0EFC
CODE_03A2D7:
	JSL.l CODE_049B35
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) == $00
	JSR.w CODE_03935E
endif
CODE_03A2DE:
	LDA.w !RAM_SMB1_Global_CurrentLayer3XPosLo
	AND.b #$10
	BEQ.b CODE_03A2EC
	LDA.w $0EDD
	BEQ.b CODE_03A2F6
	BRA.b CODE_03A2FF

CODE_03A2EC:
	LDA.w $0EDD
	BEQ.b CODE_03A2FF
	STZ.w $0EDD
	BRA.b CODE_03A2FB

CODE_03A2F6:
	LDA.b #$01
	STA.w $0EDD
CODE_03A2FB:
	JSL.l SMB3_BufferLayer3Tilemap_Main
CODE_03A2FF:
	RTS

CODE_03A300:
	ASL
	TAX
	JMP.w (DATA_03A305,x)

DATA_03A305:
	dw CODE_03A315
	dw CODE_03923A
	dw CODE_03923A
	dw CODE_03A436
	dw CODE_03A315
	dw CODE_03923A
	dw CODE_03923A
	dw CODE_03A436

;--------------------------------------------------------------------

CODE_03A315:
	INC.w $0726
	LDA.w $0726
	AND.b #$0F
	BNE.b CODE_03A325
	STA.w $0726
	INC.w $0725
CODE_03A325:
	INC.w $06A0
	LDA.w $06A0
	AND.b #$1F
	STA.w $06A0
	RTS

;--------------------------------------------------------------------

; Note: Some routine related to buffering level data

DATA_03A331:
	db $00,$30,$60

DATA_03A334:
	db $93,$00,$00,$11,$12,$12,$13,$00,$00,$51,$52,$53,$00,$00,$00,$00
	db $00,$00,$01,$02,$02,$03,$00,$00,$00,$00,$00,$00,$91,$92,$93,$00
	db $00,$00,$00,$51,$52,$53,$41,$42,$43,$00,$00,$00,$00,$00,$91,$92
	db $97,$87,$88,$89,$99,$00,$00,$00,$11,$12,$13,$A4,$A5,$A5,$A5,$A6
	db $97,$98,$99,$01,$02,$03,$00,$A4,$A5,$A6,$00,$11,$12,$12,$12,$13
	db $00,$00,$00,$00,$01,$02,$02,$03,$00,$A4,$A5,$A5,$A6,$00,$00,$00
	db $11,$12,$12,$13,$00,$00,$00,$00,$00,$00,$00,$9C,$00,$8B,$AA,$AA
	db $AA,$AA,$11,$12,$13,$8B,$00,$9C,$9C,$00,$00,$01,$02,$03,$11,$12
	db $12,$13,$00,$00,$00,$00,$AA,$AA,$9C,$AA,$00,$8B,$00,$01,$02,$03

DATA_03A3C4:
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$04,$00,$00,$05,$00,$00,$06
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$4D,$00,$00,$11,$13
	db $4E,$12,$4E

DATA_03A3E7:
	db $4E,$00,$0D,$1A

DATA_03A3EB:
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$71,$71,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$71,$71,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$86,$8B

DATA_03A412:
	db $72,$56,$52,$65

DATA_03A416:
	db $00,$00,$00,$18,$01,$18,$07,$18,$0F,$18,$FF,$18,$01,$1F,$07,$1F
	db $0F,$1F,$81,$1F,$01,$00,$8F,$1F,$F1,$1F,$F9,$18,$F1,$18,$FF,$1F

CODE_03A436:
	LDA.w $0728
	BEQ.b CODE_03A43E
	JSR.w CODE_03A5CC
CODE_03A43E:
	LDX.b #$0C
	LDA.b #$00
CODE_03A442:
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,x
	DEX
	BPL.b CODE_03A442
	LDY.w $0742
	BEQ.b CODE_03A48F
	LDA.w $0725
CODE_03A450:
	CMP.b #$03
	BMI.b CODE_03A459
	SEC
	SBC.b #$03
	BPL.b CODE_03A450
CODE_03A459:
	ASL
	ASL
	ASL
	ASL
	ADC.w DATA_03A331-$01,y
	ADC.w $0726
	TAX
	LDA.w DATA_03A334,x
	BEQ.b CODE_03A48F
	PHA
	AND.b #$0F
	SEC
	SBC.b #$01
	STA.b $00
	ASL
	ADC.b $00
	TAX
	PLA
	LSR
	LSR
	LSR
	LSR
	TAY
	LDA.b #$03
	STA.b $00
CODE_03A47F:
	LDA.w DATA_03A3C4,x
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,y
	INX
	INY
	CPY.b #$0B
	BEQ.b CODE_03A48F
	DEC.b $00
	BNE.b CODE_03A47F
CODE_03A48F:
	LDX.w $0741
	BEQ.b CODE_03A4C7
	LDY.w DATA_03A3E7,x
	LDX.b #$00
CODE_03A499:
	LDA.w DATA_03A3EB,y
	BEQ.b CODE_03A4C1
	PHY
	LDY.b !RAM_SMB1_Level_CurrentLevelType
	BNE.b CODE_03A4B3
	LDY.w $0EF0
	BNE.b CODE_03A4AE
	INC.w $0EF0
	INC
	BRA.b CODE_03A4BB

CODE_03A4AE:
	STZ.w $0EF0
	BRA.b CODE_03A4BD

CODE_03A4B3:
	CPY.b #$03
	BNE.b CODE_03A4BD
	CMP.b #$86
	BNE.b CODE_03A4BD
CODE_03A4BB:
	INC
	INC
CODE_03A4BD:
	PLY
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,x
CODE_03A4C1:
	INY
	INX
	CPX.b #$0D
	BNE.b CODE_03A499
CODE_03A4C7:
	STZ.w $0109
	STZ.b !RAM_SMB1_Global_ScratchRAMF9
	LDA.w $0EE8
	STA.w $0EE9
	INC.w $0EE8
	LDY.b !RAM_SMB1_Level_CurrentLevelType
	BNE.b CODE_03A4E4
	LDA.w !RAM_SMB1_Player_CurrentWorld
	CMP.b #$07
	BNE.b CODE_03A4E4
	LDA.b #$65
	BRA.b CODE_03A4EE

CODE_03A4E4:
	LDA.w DATA_03A412,y
	LDY.w $0743
	BEQ.b CODE_03A4EE
	LDA.b #$8C
CODE_03A4EE:
	STA.b $07
	LDX.b #$00
	LDA.w $0727
	ASL
	TAY
CODE_03A4F7:
	LDA.w DATA_03A416,y
	STA.b $00
	INY
	STY.b $01
	LDA.w $0743
	BEQ.b CODE_03A50E
	CPX.b #$00
	BEQ.b CODE_03A50E
	LDA.b $00
	AND.b #$08
	STA.b $00
CODE_03A50E:
	LDY.b #$00
CODE_03A510:
	LDA.w DATA_03CA9F,y
	BIT.b $00
	BEQ.b CODE_03A55B
	LDA.b $BA
	CMP.b #$03
	BNE.b CODE_03A527
	LDA.b !RAM_SMB1_Global_ScratchRAMF9
	BEQ.b CODE_03A527
	LDA.b #$68
	STA.b $07
	BRA.b CODE_03A529

CODE_03A527:
	LDA.b $07
CODE_03A529:
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,x
	LDA.b !RAM_SMB1_Global_ScratchRAMF9
	BEQ.b CODE_03A544
	LDA.b $BA
	CMP.b #$03
	BNE.b CODE_03A544
	LDA.b !RAM_SMB1_Global_ScratchRAMF9
	INC.b !RAM_SMB1_Global_ScratchRAMF9
	INC
	BNE.b CODE_03A562
	INC.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,x
	INC.b $07
	BRA.b CODE_03A562

CODE_03A544:
	LDA.b $BA
	CMP.b #$03
	BNE.b CODE_03A562
	LDA.w $0109
	BNE.b CODE_03A562
	LDA.w $0EE9
	AND.b #$01
	BNE.b CODE_03A562
	INC.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,x
	BRA.b CODE_03A562

CODE_03A55B:
	LDA.b #$FE
	STA.b !RAM_SMB1_Global_ScratchRAMF9
	INC.w $0109
CODE_03A562:
	INX
	CPX.b #$0D
	BEQ.b CODE_03A584
	LDA.b !RAM_SMB1_Level_CurrentLevelType
	CMP.b #$02
	BNE.b CODE_03A575
	CPX.b #$0B
	BNE.b CODE_03A575
	LDA.b #$56
	STA.b $07
CODE_03A575:
	INC.w $0EE9
	INY
	CPY.b #$08
	BNE.b CODE_03A510
	LDY.b $01
	BEQ.b CODE_03A584
	JMP.w CODE_03A4F7

CODE_03A584:
	LDA.w $06AD
	CMP.b #$56
	BEQ.b CODE_03A58F
	CMP.b #$72
	BNE.b CODE_03A592
CODE_03A58F:
	INC.w $06AD
CODE_03A592:
	JSR.w CODE_03A5CC
	LDA.w $06A0
	JSR.w CODE_03ACF6
	LDX.b #$00
	LDY.b #$00
CODE_03A59F:
	STY.b $00
	LDA.w $0EC9
	BNE.b CODE_03A5C7
	LDA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,x
	AND.b #$C0
	ASL
	ROL
	ROL
	TAY
	LDA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,x
	CMP.w DATA_03A5C8,y
	BCS.b CODE_03A5B9
	LDA.b #$00
CODE_03A5B9:
	LDY.b $00
	STA.b ($06),y
	TYA
	CLC
	ADC.b #$10
	TAY
	INX
	CPX.b #$0D
	BCC.b CODE_03A59F
CODE_03A5C7:
	RTS

DATA_03A5C8:
	db $14,$51,$8C,$E7

;--------------------------------------------------------------------

CODE_03A5CC:
	REP.b #$10
	LDX.w #$0004
CODE_03A5D1:
	STZ.w !RAM_SMB1_Level_3ByteObjectFlag
	STX.b $9E
	STZ.w $0729
	LDY.w !RAM_SMB1_Level_LevelDataIndex
	LDA.b [!RAM_SMB1_Level_LevelDataPtrLo],y
	CMP.b #$FD
	BEQ.b CODE_03A645
	AND.b #$0F
	CMP.b #$0F
	BNE.b CODE_03A5EB
	INC.w !RAM_SMB1_Level_3ByteObjectFlag
CODE_03A5EB:
	LDA.w $1300,x
	BPL.b CODE_03A645
	LDA.w !RAM_SMB1_Level_3ByteObjectFlag
	BEQ.b CODE_03A5F6
	INY
CODE_03A5F6:
	INY
	LDA.b [!RAM_SMB1_Level_LevelDataPtrLo],y
	ASL
	BCC.b CODE_03A607
	LDA.w $072B
	BNE.b CODE_03A607
	INC.w $072B
	INC.w $072A
CODE_03A607:
	LDY.w !RAM_SMB1_Level_LevelDataIndex
	LDA.b [!RAM_SMB1_Level_LevelDataPtrLo],y
	AND.b #$0F
	CMP.b #$0D
	BNE.b CODE_03A634
	INY
	LDA.b [!RAM_SMB1_Level_LevelDataPtrLo],y
	LDY.w !RAM_SMB1_Level_LevelDataIndex
	AND.b #$40
	BNE.b CODE_03A63D
	LDA.w $072B
	BNE.b CODE_03A63D
	LDA.w !RAM_SMB1_Level_3ByteObjectFlag
	BEQ.b CODE_03A627
	INY
CODE_03A627:
	INY
	LDA.b [!RAM_SMB1_Level_LevelDataPtrLo],y
	AND.b #$1F
	STA.w $072A
	INC.w $072B
	BRA.b CODE_03A64F

CODE_03A634:
	CMP.b #$0E
	BNE.b CODE_03A63D
	LDA.w $0728
	BNE.b CODE_03A645
CODE_03A63D:
	LDA.w $072A
	CMP.w $0725
	BCC.b CODE_03A64C
CODE_03A645:
	JSR.w CODE_03A693
	REP.b #$10
	BRA.b CODE_03A652

CODE_03A64C:
	INC.w $0729
CODE_03A64F:
	JSR.w CODE_03A675
CODE_03A652:
	LDX.b $9E
	LDA.w $1300,x
	BMI.b CODE_03A65C
	DEC.w $1300,x
CODE_03A65C:
	DEX
	BMI.b CODE_03A662
	JMP.w CODE_03A5D1

CODE_03A662:
	LDA.w $0729
	BEQ.b CODE_03A66A
	JMP.w CODE_03A5CC

CODE_03A66A:
	LDA.w $0728
	BEQ.b CODE_03A672
	JMP.w CODE_03A5CC

CODE_03A672:
	SEP.b #$10
	RTS

CODE_03A675:
	REP.b #$20
	INC.w !RAM_SMB1_Level_LevelDataIndex
	INC.w !RAM_SMB1_Level_LevelDataIndex
	LDA.w !RAM_SMB1_Level_3ByteObjectFlag
	AND.w #$00FF
	BEQ.b CODE_03A688
	INC.w !RAM_SMB1_Level_LevelDataIndex
CODE_03A688:
	SEP.b #$20
	LDA.b #$00
	STA.w $072B
	STA.w !RAM_SMB1_Level_3ByteObjectFlag
	RTS

CODE_03A693:
	REP.b #$30
	TXA
	AND.w #$00FF
	TAX
	SEP.b #$20
	LDA.w $1300,x
	BMI.b CODE_03A6AB
	REP.b #$20
	TXA
	ASL
	TAX
	LDY.w $1305,x
	SEP.b #$20
CODE_03A6AB:
	LDA.w $0F82
	BEQ.b CODE_03A6B8
	JSL.l CODE_048817
	STZ.w $0F82
	RTS

CODE_03A6B8:
	STY.b !RAM_SMB1_Global_ScratchRAMF7
	STZ.b !RAM_SMB1_Level_UseAlternateObjectsFlag
	STZ.w !RAM_SMB1_Level_3ByteObjectFlag
	LDX.w #$0010
	LDA.b [!RAM_SMB1_Level_LevelDataPtrLo],y
	CMP.b #$FD
	BEQ.b CODE_03A672
	AND.b #$0F
	CMP.b #$0F
	BNE.b CODE_03A6D2
	INC.b !RAM_SMB1_Level_UseAlternateObjectsFlag
	BRA.b CODE_03A6DC

CODE_03A6D2:
	LDX.w #$0008
	CMP.b #$0C
	BEQ.b CODE_03A6DC
	LDX.w #$0000
CODE_03A6DC:
	STX.b $07
	LDX.b $9E
	CMP.b #$0E
	BNE.b CODE_03A6EA
	STZ.b $07
	LDA.b #$2E
	BNE.b CODE_03A747						; Note: This will always branch

CODE_03A6EA:
	CMP.b #$0D
	BNE.b CODE_03A70D
	LDA.b #$22
	STA.b $07
	LDA.b !RAM_SMB1_Level_UseAlternateObjectsFlag
	BEQ.b CODE_03A6F7
	INY
CODE_03A6F7:
	INY
	LDA.b [!RAM_SMB1_Level_LevelDataPtrLo],y
	AND.b #$40
	BEQ.b CODE_03A766
	LDA.b [!RAM_SMB1_Level_LevelDataPtrLo],y
	AND.b #$7F
	CMP.b #$4B
	BNE.b CODE_03A709
	INC.w $0745
CODE_03A709:
	AND.b #$3F
	BRA.b CODE_03A747

CODE_03A70D:
	CMP.b #$0C
	BCS.b CODE_03A739
	LDA.b !RAM_SMB1_Level_UseAlternateObjectsFlag
	BEQ.b CODE_03A716
	INY
CODE_03A716:
	INY
	LDA.b [!RAM_SMB1_Level_LevelDataPtrLo],y
	AND.b #$70
	BNE.b CODE_03A727
	LDA.b #$16
	STA.b $07
	LDA.b [!RAM_SMB1_Level_LevelDataPtrLo],y
	AND.b #$0F
	BRA.b CODE_03A747

CODE_03A727:
	STA.b $00
	CMP.b #$70
	BNE.b CODE_03A735
	LDA.b [!RAM_SMB1_Level_LevelDataPtrLo],y
	AND.b #$08
	BEQ.b CODE_03A735
	STZ.b $00
CODE_03A735:
	LDA.b $00
	BRA.b CODE_03A743

CODE_03A739:
	LDA.b !RAM_SMB1_Level_UseAlternateObjectsFlag
	BEQ.b CODE_03A73E
	INY
CODE_03A73E:
	INY
	LDA.b [!RAM_SMB1_Level_LevelDataPtrLo],y
	AND.b #$70
CODE_03A743:
	LSR
	LSR
	LSR
	LSR
CODE_03A747:
	STA.b $00
	LDA.w $1300,x
	BPL.b CODE_03A7A6
	LDA.w $072A
	CMP.w $0725
	BEQ.b CODE_03A769
	LDY.w !RAM_SMB1_Level_LevelDataIndex
	LDA.b [!RAM_SMB1_Level_LevelDataPtrLo],y
	AND.b #$0F
	CMP.b #$0E
	BNE.b CODE_03A766
	LDA.w $0728
	BNE.b CODE_03A78D
CODE_03A766:
	SEP.b #$10
	RTS

CODE_03A769:
	LDA.w $0728
	BEQ.b CODE_03A77D
	LDA.b #$00
	STA.w $0728
	STA.w $0729
	STA.b $9E
	STA.b $9F
SMB1_ExtObj2D_AreaLoopCommand:
.Main:
	SEP.b #$10
	RTS

CODE_03A77D:
	LDY.w !RAM_SMB1_Level_LevelDataIndex
	LDA.b [!RAM_SMB1_Level_LevelDataPtrLo],y
	AND.b #$F0
	LSR
	LSR
	LSR
	LSR
	CMP.w $0726
	BNE.b CODE_03A766
CODE_03A78D:
	PHX
	REP.b #$20
	TXA
	ASL
	TAX
	LDA.w !RAM_SMB1_Level_LevelDataIndex
	STA.w $1305,x
	SEP.b #$20
	PLX
	LDA.b !RAM_SMB1_Level_UseAlternateObjectsFlag
	BEQ.b CODE_03A7A3
	INC.w !RAM_SMB1_Level_3ByteObjectFlag
CODE_03A7A3:
	JSR.w CODE_03A675
CODE_03A7A6:
	LDA.b !RAM_SMB1_Level_UseAlternateObjectsFlag
	BEQ.b CODE_03A7B3
	LDY.b !RAM_SMB1_Global_ScratchRAMF7
	JSL.l CODE_048E15
	SEP.b #$10
	RTS

CODE_03A7B3:
	SEP.b #$10
	LDA.b $00
	CLC
	ADC.b $07
	ASL
	TAY
	LDA.w DATA_03A7C9,y
	STA.b $04
	LDA.w DATA_03A7C9+$01,y
	STA.b $05
	JMP.w ($0004)

DATA_03A7C9:
	dw SMB1_ExtObj00_EnterablePipe_Main
	dw SMB1_ExtObj01_GrassyOrMushroomPlatform_Main
	dw SMB1_ExtObj02_RowOfBricks_Main
	dw SMB1_ExtObj03_RowOfStoneBlocks_Main
	dw SMB1_ExtObj04_RowOfCoins_Main
	dw SMB1_ExtObj05_ColumnOfBricks_Main
	dw SMB1_ExtObj06_ColumnOfStoneBlocks_Main
	dw SMB1_ExtObj07_Pipe_Main

	dw SMB1_ExtObj08_Hole_Main
	dw SMB1_ExtObj09_PulleyRope_Main
	dw SMB1_ExtObj0A_Bridge_Y07_Main
	dw SMB1_ExtObj0B_Bridge_Y08_Main
	dw SMB1_ExtObj0C_Bridge_Y10_Main
	dw SMB1_ExtObj0D_WaterOrLavaHole_Main
	dw SMB1_ExtObj0E_RowOfCoinQuestionBlocks_Y03_Main
	dw SMB1_ExtObj0F_RowOfCoinQuestionBlocks_Y07_Main

	dw SMB1_ExtObj10_Unused_Main
	dw SMB1_ExtObj11_Unused_Main
	dw SMB1_ExtObj12_Unused_Main
	dw SMB1_ExtObj13_Unused_Main
	dw SMB1_ExtObj14_Unused_Main
	dw SMB1_ExtObj15_Unused_Main

	dw SMB1_ExtObj16_QuestionBlockWithPowerup_Main
	dw SMB1_ExtObj17_QuestionBlockWithCoin_Main
	dw SMB1_ExtObj18_InvisibleCoinBlock_Main
	dw SMB1_ExtObj19_Invisible1upBlock_Main
	dw SMB1_ExtObj1A_BrickBlockWithPowerup_Main
	dw SMB1_ExtObj1B_BrickBlockWithVine_Main
	dw SMB1_ExtObj1C_BrickBlockWithStar_Main
	dw SMB1_ExtObj1D_BrickBlockWith10Coins_Main
	dw SMB1_ExtObj1E_BrickBlockWith1up_Main
	dw SMB1_ExtObj1F_LeftFacingEnterablePipe_Main
	dw SMB1_ExtObj20_FirebarBlock_Main
	dw SMB1_ExtObj21_RedSpringBoard_Main

	dw SMB1_ExtObj22_JPipe_Main
	dw SMB1_ExtObj23_Flagpole_Main
	dw SMB1_ExtObj24_Axe_Main
	dw SMB1_ExtObj25_AxeChain_Main
	dw SMB1_ExtObj26_BowserBridge_Main
	dw SMB1_ExtObj27_WarpZoneScrollStop_Main
	dw SMB1_ExtObj28_ScrollStop_Main
	dw SMB1_ExtObj29_ScrollStop_Main
	dw SMB1_ExtObj2A_FlyingCheepCheepGenerator_Main
	dw SMB1_ExtObj2B_SwimmingCheepCheepOrBulletBillGenerator_Main
	dw SMB1_ExtObj2C_DisableGenerators_Main
	dw SMB1_ExtObj2D_AreaLoopCommand_Main

	dw SMB1_ExtObj2E_ChangeSceneryCommand_Main

;--------------------------------------------------------------------

SMB1_ExtObj10_Unused:
.Main:
SMB1_ExtObj11_Unused:
.Main:
SMB1_ExtObj12_Unused:
.Main:
SMB1_ExtObj13_Unused:
.Main:
SMB1_ExtObj14_Unused:
.Main:
SMB1_ExtObj15_Unused:
.Main:
;$03A827
	RTS

;--------------------------------------------------------------------

SMB1_ExtObj2E_ChangeSceneryCommand:
.Main:
;$03A828
	PHX
	REP.b #$30
	TXA
	ASL
	TAX
	LDY.w $1305,x
	SEP.b #$20
	INY
	LDA.b [!RAM_SMB1_Level_LevelDataPtrLo],y
	SEP.b #$10
	PLX
	PHA
	AND.b #$40
	BNE.b CODE_03A850
	PLA
	PHA
	AND.b #$0F
	STA.w $0727
	PLA
	AND.b #$30
	LSR
	LSR
	LSR
	LSR
	STA.w $0742
	RTS

CODE_03A850:
	PLA
	AND.b #$07
	CMP.b #$04
	BCC.b CODE_03A85E
	AND.b #$04
	STA.w $0744
	LDA.b #$00
CODE_03A85E:
	STA.w $0741
	RTS

;--------------------------------------------------------------------

SMB1_ExtObj27_WarpZoneScrollStop:
.Main:
;$03A862
	LDX.b #$04
	LDA.w !RAM_SMB1_Player_CurrentWorld
	BEQ.b CODE_03A870
	INX
	LDY.b !RAM_SMB1_Level_CurrentLevelType
	DEY
	BNE.b CODE_03A870
	INX
CODE_03A870:
	TXA
	STA.w !RAM_SMB1_Level_WarpZoneActiveFlag
	JSR.w CODE_039109
	LDA.b #!Define_SMB1_SpriteID_NorSpr00D_PiranhaPlant
	JSR.w CODE_03A885
SMB1_ExtObj28_ScrollStop:
.Main:
SMB1_ExtObj29_ScrollStop:
.Main:
	LDA.w !RAM_SMB1_Level_DisableScrollingFlag
	EOR.b #$01
	STA.w !RAM_SMB1_Level_DisableScrollingFlag
	RTS

;--------------------------------------------------------------------

CODE_03A885:
	STA.b $00
	LDA.b #$00
	LDX.b #$08
CODE_03A88B:
	LDY.b !RAM_SMB1_NorSpr_SpriteID,x
	CPY.b $00
	BNE.b CODE_03A893
	STA.b !RAM_SMB1_NorSpr_SpriteSlotExistsFlag,x
CODE_03A893:
	DEX
	BPL.b CODE_03A88B
	RTS

;--------------------------------------------------------------------

DATA_03A897:
	db !Define_SMB1_SpriteID_NorSpr014_RedFlyingCheepCheepGenerator
	db !Define_SMB1_SpriteID_NorSpr017_BulletBillGenerator
	db !Define_SMB1_SpriteID_NorSpr018_RemoveGenerators

SMB1_ExtObj2A_FlyingCheepCheepGenerator:
.Main:
SMB1_ExtObj2B_SwimmingCheepCheepOrBulletBillGenerator:
.Main:
SMB1_ExtObj2C_DisableGenerators:
.Main:
;$03A89A
	LDX.b $00
	LDA.w DATA_03A897-$08,x
	LDY.b #$09
CODE_03A8A1:
	DEY
	BMI.b CODE_03A8AB
	CMP.w !RAM_SMB1_NorSpr_SpriteID,y
	BNE.b CODE_03A8A1
	LDA.b #$00
CODE_03A8AB:
	STA.w !RAM_SMB1_Level_SpriteToSpawnFromGeneratorObject
	RTS

;--------------------------------------------------------------------

SMB1_ExtObj01_GrassyOrMushroomPlatform:
.Main:
;$03A8AF
	LDA.w $0733
	ASL
	TAY
	LDA.w DATA_03A8C1,y
	STA.b $04
	LDA.w DATA_03A8C1+$01,y
	STA.b $05
	JMP.w ($0004)

DATA_03A8C1:
	dw CODE_03A8C7
	dw CODE_03A937
	dw CODE_03AB99

;--------------------------------------------------------------------

CODE_03A8C7:
	JSR.w CODE_03ACC2
	STX.w $0ECA
	LDA.w $1300,x
	BEQ.b CODE_03A932
	BPL.b CODE_03A8E5
	TYA
	STA.w $1300,x
	LDA.w $0725
	ORA.w $0726
	BEQ.b CODE_03A8E5
	LDA.b #$1A
	JMP.w CODE_03A96E

CODE_03A8E5:
	STA.w $0ECB
	LDX.b $07
	LDA.b #$1B
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,x
	TXY
	INY
	LDX.w $0ECA
	DEC.w $0ECB
	BEQ.b CODE_03A913
	LDA.w $130F,x
	BNE.b CODE_03A90A
	INC.w $130F,x
	LDA.b #$45
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,y
	LDA.b #$49
	BRA.b CODE_03A92E

CODE_03A90A:
	LDA.b #$46
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,y
	LDA.b #$4A
	BRA.b CODE_03A92E

CODE_03A913:
	LDA.w $130F,x
	BEQ.b CODE_03A924
	STZ.w $130F,x
	LDA.b #$47
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,y
	LDA.b #$4B
	BRA.b CODE_03A92E

CODE_03A924:
	STZ.w $130F,x
	LDA.b #$48
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,y
	LDA.b #$4C
CODE_03A92E:
	TYX
	JMP.w CODE_03A968

CODE_03A932:
	LDA.b #$1C
	JMP.w CODE_03A96E

;--------------------------------------------------------------------

CODE_03A937:
	JSR.w CODE_03ACB3
	STY.b $06
	BCC.b CODE_03A949
	LDA.w $1300,x
	LSR
	STA.w $1314,x
	LDA.b #$1D
	BRA.b CODE_03A96E

CODE_03A949:
	LDA.b #$1F
	LDY.w $1300,x
	BEQ.b CODE_03A96E
	LDA.w $1314,x
	STA.b $06
	LDX.b $07
	LDA.b #$1E
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,x
	CPY.b $06
	BNE.b CODE_03A98C
	INX
	LDA.b #$4F
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,x
	LDA.b #$50
CODE_03A968:
	INX
	LDY.b #$0F
	JMP.w CODE_03AC78

CODE_03A96E:
	LDX.b $07
	LDY.b #$00
	JMP.w CODE_03AC78

;--------------------------------------------------------------------

DATA_03A975:
	db $42,$41,$43

SMB1_ExtObj09_PulleyRope:
.Main:
;$03A978
	JSR.w CODE_03ACB3
	LDY.b #$00
	BCS.b CODE_03A986
	INY
	LDA.w $1300,x
	BNE.b CODE_03A986
	INY
CODE_03A986:
	LDA.w DATA_03A975,y
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable
CODE_03A98C:
	RTS

;--------------------------------------------------------------------

SMB1_ExtObj1F_LeftFacingEnterablePipe_Main:
.Main:
;$03A98D
	JSR.w CODE_03ACC2
	LDY.w $1300,x
	LDX.b $07
	LDA.b #$75
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,x
	LDA.b #$76
	STA.w $06A2,x
	RTS

;--------------------------------------------------------------------

SMB1_ExtObj22_JPipe:
.Main:
;$03A9A0
	LDY.b #$03
	JSR.w CODE_03ACB6
	LDY.b #$0A
	DEY
	DEY
	STY.b $05
	LDY.w $1300,x
	STY.b $06
	LDX.b $05
	INX
	LDA.w DATA_03A9E3,y
	CMP.b #$00
	BEQ.b CODE_03A9C2
	LDX.b #$00
	LDY.b $05
	JSR.w CODE_03AC78
	CLC
CODE_03A9C2:
	LDY.b $06
	LDA.w DATA_03A9E7,y
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,x
	LDA.w DATA_03A9EB,y
	STA.w $06A2,x
	BCS.b CODE_03A9E2
	LDX.b #$06
CODE_03A9D4:
	LDA.b #$00
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,x
	DEX
	BPL.b CODE_03A9D4
	LDA.w DATA_03A9EF,y
	STA.w $06A8
CODE_03A9E2:
	RTS

DATA_03A9E3:
	db $19,$18,$00,$00

DATA_03A9E7:
	db $19,$22,$21,$20

DATA_03A9EB:
	db $19,$25,$24,$23

DATA_03A9EF:
	db $15,$14

;--------------------------------------------------------------------

DATA_03A9F1:
	db $19,$18

DATA_03A9F3:
	db $17,$16,$19,$18

SMB1_ExtObj00_EnterablePipe:
.Main:
SMB1_ExtObj07_Pipe:
.Main:
;$03A9F7
	JSR.w CODE_03AA4D
	LDA.b $00
	BEQ.b CODE_03AA02
	INY
	INY
	INY
	INY
CODE_03AA02:
	TYA
	PHA
	LDA.w !RAM_SMB1_Player_CurrentLevel
	ORA.w !RAM_SMB1_Player_CurrentWorld
	BEQ.b CODE_03AA39
	LDY.w $1300,x
	BEQ.w CODE_03AA39
	JSR.w CODE_03AA6B
	BCS.b CODE_03AA39
	JSR.w CODE_03ACE0
	CLC
	ADC.b #$08
	STA.w !RAM_SMB1_NorSpr_XPosLo,x
	LDA.w $0725
	ADC.b #$00
	STA.b !RAM_SMB1_NorSpr_XPosHi,x
	LDA.b #$01
	STA.b !RAM_SMB1_NorSpr_YPosHi,x
	STA.b !RAM_SMB1_NorSpr_SpriteSlotExistsFlag,x
	JSR.w CODE_03ACE8
	STA.w !RAM_SMB1_NorSpr_YPosLo,x
	LDA.b #!Define_SMB1_SpriteID_NorSpr00D_PiranhaPlant
	STA.b !RAM_SMB1_NorSpr_SpriteID,x
	JSR.w SMB1_NorSpr00D_PiranhaPlant_InitializationRt_Main
CODE_03AA39:
	PLA
	TAY
	LDX.b $07
	LDA.w DATA_03A9EF,y
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,x
	INX
	LDA.w DATA_03A9F1,y
	LDY.b $06
	DEY
	JMP.w CODE_03AC78

CODE_03AA4D:
	LDY.b #$01
	JSR.w CODE_03ACB6
	JSR.w CODE_03ACC2
	TYA
	AND.b #$07
	STA.b $06
	LDY.w $1300,x
	RTS

;--------------------------------------------------------------------

CODE_03AA5E:
	LDX.b #$00
CODE_03AA60:
	CLC
	LDA.b !RAM_SMB1_NorSpr_SpriteSlotExistsFlag,x
	BEQ.b CODE_03AA6A
	INX
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMB1_J) != $00
	CPX.b #$07
else
	CPX.b #$08
endif
	BNE.b CODE_03AA60
CODE_03AA6A:
	RTS

;--------------------------------------------------------------------

CODE_03AA6B:
	LDX.b #$08
CODE_03AA6D:
	CLC
	LDA.b !RAM_SMB1_NorSpr_SpriteSlotExistsFlag,x
	BEQ.b CODE_03AA77
	DEX
	CPX.b #$FF
	BNE.b CODE_03AA6D
CODE_03AA77:
	RTS

;--------------------------------------------------------------------

DATA_03AA78:
	db $86,$87,$00,$88

DATA_03AA7C:
	db $8A,$8B

SMB1_ExtObj0D_WaterOrLavaHole:
.Main:
;$03AA7E
	JSR.w CODE_03ACB3
	LDX.b #$0A
	LDA.b !RAM_SMB1_Level_CurrentLevelType
	CMP.b #$03
	BNE.b CODE_03AA8A
	INX
CODE_03AA8A:
	LDY.b !RAM_SMB1_Level_CurrentLevelType
	LDA.w DATA_03AA78,y
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,x
	INX
	TYA
	LSR
	TAY
	LDA.w DATA_03AA7C,y
	LDY.b #$01
	JMP.w CODE_03AC78

;--------------------------------------------------------------------

SMB1_ExtObj0E_RowOfCoinQuestionBlocks_Y03:
.Main:
;$03AA9E
	LDA.b #$03
	BRA.b CODE_03AAA4

SMB1_ExtObj0F_RowOfCoinQuestionBlocks_Y07:
.Main:
	LDA.b #$07
CODE_03AAA4:
	PHA
	JSR.w CODE_03ACB3
	PLA
	TAX
	LDA.b #$E7
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,x
	RTS

;--------------------------------------------------------------------

SMB1_ExtObj0A_Bridge_Y07:
.Main:
;$03AAB0
	LDA.b #$06
	BRA.b CODE_03AABA

SMB1_ExtObj0B_Bridge_Y08:
.Main:
	LDA.b #$07
	BRA.b CODE_03AABA

SMB1_ExtObj0C_Bridge_Y10:
.Main:
	LDA.b #$09
CODE_03AABA:
	PHA
	JSR.w CODE_03ACB3
	LDA.w $1300,x
	BEQ.b CODE_03AAD3
	LDA.w $130F,x
	BNE.b CODE_03AACF
	INC.w $130F,x
	LDA.b #$0E
	BRA.b CODE_03AAD8

CODE_03AACF:
	LDA.b #$0D
	BRA.b CODE_03AAD8

CODE_03AAD3:
	STZ.w $130F,x
	LDA.b #$0F
CODE_03AAD8:
	PLX
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,x
	INX
	LDY.b #$00
	LDA.b #$6B
	JMP.w CODE_03AC78

;--------------------------------------------------------------------

SMB1_ExtObj23_Flagpole:
.Main:
;$03AAE4
	LDA.b #$28
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable
	LDX.b #$01
	LDY.b #$08
	LDA.b #$29
	JSR.w CODE_03AC78
	LDA.b #$64
	STA.w $06AB
	JSR.w CODE_03ACE0
	SEC
	SBC.b #$08
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	STA.w !RAM_SMB1_NorSpr_XPosLo+$09
else
	STA.w !RAM_SMB1_NorSpr_XPosLo+$05
endif
	LDA.w $0725
	SBC.b #$00
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	STA.b !RAM_SMB1_NorSpr_XPosHi+$09
else
	STA.b !RAM_SMB1_NorSpr_XPosHi+$05
endif
	LDA.b #$30
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	STA.w !RAM_SMB1_NorSpr_YPosLo+$09
else
	STA.w !RAM_SMB1_NorSpr_YPosLo+$05
endif
	LDA.b #$B0
	STA.w !RAM_SMB1_Level_GoalFlagScoreYPosLo
	LDA.b #!Define_SMB1_SpriteID_NorSpr030_Flagpole
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	STA.b !RAM_SMB1_NorSpr_SpriteID+$09
	INC.b $19
else
	STA.b !RAM_SMB1_NorSpr_SpriteID+$05
	INC.b $15
endif
	LDA.b #$FF
	STA.w $0FB4
	STA.w $0FB5
	STA.w $0FB6
	STA.w $0FB7
	RTS

;--------------------------------------------------------------------

DATA_03AB26:
	db $EA,$E9,$E9,$E9

SMB1_ExtObj04_RowOfCoins:
.Main:
;$03AB2A
	LDY.b !RAM_SMB1_Level_CurrentLevelType
	LDA.w DATA_03AB26,y
	JMP.w CODE_03AB77

;--------------------------------------------------------------------

DATA_03AB32:
	db $06,$07,$08

DATA_03AB35:
	db $FD,$10,$8D

SMB1_ExtObj26_BowserBridge:
.Main:
;$03AB38
	LDY.b #$0C
	JSR.w CODE_03ACB6
	BRA.b CODE_03AB44

SMB1_ExtObj24_Axe:
.Main:
	LDA.b #$08
	STA.w !RAM_SMB1_Global_StripeImageToUpload
SMB1_ExtObj25_AxeChain:
.Main:
CODE_03AB44:
	LDY.b $00
	LDX.w DATA_03AB32-$02,y
	LDA.w DATA_03AB35-$02,y
	BRA.b CODE_03AB55

SMB1_ExtObj20_FirebarBlock:
.Main:
	JSR.w CODE_03ACC2
	LDX.b $07
	LDA.b #$FC
CODE_03AB55:
	LDY.b #$00
	JMP.w CODE_03AC78

;--------------------------------------------------------------------

DATA_03AB5A:
	db $71,$64,$64,$6A

DATA_03AB5E:
	db $26,$51,$52,$52,$8C

SMB1_ExtObj02_RowOfBricks:
.Main:
;$03AB63
	LDY.b !RAM_SMB1_Level_CurrentLevelType
	LDA.w $0743
	BEQ.b CODE_03AB6C
	LDY.b #$04
CODE_03AB6C:
	LDA.w DATA_03AB5E,y
	JMP.w CODE_03AB77

SMB1_ExtObj03_RowOfStoneBlocks:
.Main:
	LDY.b !RAM_SMB1_Level_CurrentLevelType
	LDA.w DATA_03AB5A,y
CODE_03AB77:
	PHA
	JSR.w CODE_03ACB3
	LDX.b $07
	LDY.b #$00
	PLA
	JMP.w CODE_03AC78

;--------------------------------------------------------------------

SMB1_ExtObj05_ColumnOfBricks:
.Main:
;$03AB83
	LDY.b !RAM_SMB1_Level_CurrentLevelType
	LDA.w DATA_03AB5E,y
	BRA.b CODE_03AB8F

SMB1_ExtObj06_ColumnOfStoneBlocks:
.Main:
	LDY.b !RAM_SMB1_Level_CurrentLevelType
	LDA.w DATA_03AB5A,y
CODE_03AB8F:
	PHA
	JSR.w CODE_03ACC2
	PLA
	LDX.b $07
	JMP.w CODE_03AC78

;--------------------------------------------------------------------

CODE_03AB99:
	JSR.w CODE_03ACC2
	LDX.b $07
	LDA.b #$6C
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,x
	INX
	DEY
	BMI.b CODE_03ABB5
	LDA.b #$6D
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,x
	INX
	DEY
	BMI.b CODE_03ABB5
	LDA.b #$6E
	JSR.w CODE_03AC78
CODE_03ABB5:
	LDX.w $026A
	JSR.w CODE_03ACE8
	STA.w !RAM_SMB1_Level_BulletShooterYPosLo,x
	LDA.w $0725
	STA.w !RAM_SMB1_Level_BulletShooterXPosHi,x
	JSR.w CODE_03ACE0
	STA.w !RAM_SMB1_Level_BulletShooterXPosLo,x
	INX
	CPX.b #$06
	BCC.b CODE_03ABD1
	LDX.b #$00
CODE_03ABD1:
	STX.w $026A
	RTS

;--------------------------------------------------------------------

SMB1_ExtObj21_RedSpringBoard:
.Main:
;$03ABD5
	JSR.w CODE_03ACC2
	JSR.w CODE_03AA5E
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	BCS.b CODE_03AC04
endif
	JSR.w CODE_03ACE0
	STA.w !RAM_SMB1_NorSpr_XPosLo,x
	LDA.w $0725
	STA.b !RAM_SMB1_NorSpr_XPosHi,x
	JSR.w CODE_03ACE8
	STA.w !RAM_SMB1_NorSpr_YPosLo,x
	STA.b !RAM_SMB1_NorSpr_XSpeed,x
	LDA.b #!Define_SMB1_SpriteID_NorSpr032_RedSpringboard
	STA.b !RAM_SMB1_NorSpr_SpriteID,x
	LDY.b #$01
	STY.b !RAM_SMB1_NorSpr_YPosHi,x
	INC.b !RAM_SMB1_NorSpr_SpriteSlotExistsFlag,x
	LDX.b $07
	LDA.b #$6F
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,x
	LDA.b #$70
	STA.w $06A2,x
CODE_03AC04:
	RTS

;--------------------------------------------------------------------

SMB1_ExtObj19_Invisible1upBlock:
.Main:
;$03AC05
	LDA.w !RAM_SMB1_Level_CanFindHidden1upFlag
	BEQ.b CODE_03AC3E
	STZ.w !RAM_SMB1_Level_CanFindHidden1upFlag
	BRA.b CODE_03AC18

SMB1_ExtObj16_QuestionBlockWithPowerup:
.Main:
SMB1_ExtObj17_QuestionBlockWithCoin:
.Main:
SMB1_ExtObj18_InvisibleCoinBlock:
.Main:
	JSR.w CODE_03AC38
	JMP.w CODE_03AC2A

SMB1_ExtObj1D_BrickBlockWith10Coins:
.Main:
	STZ.w !RAM_SMB1_Level_10CoinBlockHasBeenHitFlag
SMB1_ExtObj1A_BrickBlockWithPowerup:
.Main:
SMB1_ExtObj1B_BrickBlockWithVine:
.Main:
SMB1_ExtObj1C_BrickBlockWithStar:
.Main:
SMB1_ExtObj1E_BrickBlockWith1up:
.Main:
CODE_03AC18:
	JSR.w CODE_03AC38
	STY.b $07
	LDA.b #$00
	LDY.b !RAM_SMB1_Level_CurrentLevelType
	DEY
	BEQ.b CODE_03AC26
	LDA.b #$05
CODE_03AC26:
	CLC
	ADC.b $07
	TAY
CODE_03AC2A:
	LDA.w DATA_03BF8F,y
	PHA
	JSR.w CODE_03ACC2
	LDX.b $07
	PLA
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,x
	RTS

CODE_03AC38:
	LDA.b $00
	SEC
	SBC.b #$00
	TAY
CODE_03AC3E:
	RTS

;--------------------------------------------------------------------

SMB1_ExtObj08_Hole:
.Main:
;$03AC3F
	JSR.w CODE_03ACB3
	BCC.b CODE_03AC70
	LDA.b !RAM_SMB1_Level_CurrentLevelType
	BNE.b CODE_03AC70
	LDX.w $026A
	JSR.w CODE_03ACE0
	SEC
	SBC.b #$10
	STA.w !RAM_SMB1_Level_WhirlpoolXPosLoLeftBoundary,x
	LDA.w $0725
	SBC.b #$00
	STA.w !RAM_SMB1_Level_WhirlpoolXPosHi,x
	INY
	INY
	TYA
	ASL
	ASL
	ASL
	ASL
	STA.w !RAM_SMB1_Level_WhirlpoolXPosLoRightBoundary,x
	INX
	CPX.b #$05
	BCC.b CODE_03AC6D
	LDX.b #$00
CODE_03AC6D:
	STX.w $026A
CODE_03AC70:
	LDX.b !RAM_SMB1_Level_CurrentLevelType
	LDA.b #$00
	LDX.b #$08
	LDY.b #$0F
CODE_03AC78:
	STY.w $0735
	LDY.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,x
	BEQ.b CODE_03ACA4
	CPY.b #$1B
	BEQ.b CODE_03ACA7
	CPY.b #$1E
	BEQ.b CODE_03ACA7
	CPY.b #$E7
	BEQ.b CODE_03ACA4
	CPY.b #$46
	BEQ.b CODE_03ACA7
	CPY.b #$4A
	BEQ.b CODE_03ACA7
	CPY.b #$E7
	BCS.b CODE_03ACA7
	CPY.b #$57
	BEQ.b CODE_03ACA0
	CPY.b #$56
	BNE.b CODE_03ACA4
CODE_03ACA0:
	CMP.b #$50
	BEQ.b CODE_03ACA7
CODE_03ACA4:
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,x
CODE_03ACA7:
	INX
	CPX.b #$0D
	BCS.b CODE_03ACB2
	LDY.w $0735
	DEY
	BPL.b CODE_03AC78
CODE_03ACB2:
	RTS

;--------------------------------------------------------------------

CODE_03ACB3:
	JSR.w CODE_03ACC2
CODE_03ACB6:
	LDA.w $1300,x
	CLC
	BPL.b CODE_03ACC1
	TYA
	STA.w $1300,x
	SEC
CODE_03ACC1:
	RTS

;--------------------------------------------------------------------

CODE_03ACC2:
	PHX
	REP.b #$30
	TXA
	AND.w #$00FF
	ASL
	TAX
	LDY.w $1305,x
	SEP.b #$20
	LDA.b [!RAM_SMB1_Level_LevelDataPtrLo],y
	AND.b #$0F
	STA.b $07
	INY
	LDA.b [!RAM_SMB1_Level_LevelDataPtrLo],y
	AND.b #$0F
	SEP.b #$10
	TAY
	PLX
	RTS

;--------------------------------------------------------------------

CODE_03ACE0:
	LDA.w $0726
	ASL
	ASL
	ASL
	ASL
	RTS

;--------------------------------------------------------------------

CODE_03ACE8:
	LDA.b $07
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC.b #$20
	RTS

;--------------------------------------------------------------------

DATA_03ACF2:
	db !RAM_SMB1_Level_LevelDataMap16Lo,!RAM_SMB1_Level_LevelDataMap16Lo+$D0

DATA_03ACF4:
	db !RAM_SMB1_Level_LevelDataMap16Lo>>8,!RAM_SMB1_Level_LevelDataMap16Lo+$D0>>8

CODE_03ACF6:
	PHA
	LSR
	LSR
	LSR
	LSR
	TAY
	LDA.w DATA_03ACF4,y
	STA.b $07
	PLA
	AND.b #$0F
	CLC
	ADC.w DATA_03ACF2,y
	STA.b $06
	RTS

;--------------------------------------------------------------------

CODE_03AD0B:
	PHB
	PHK
	PLB
	JSR.w CODE_03AC78
	PLB
	RTL

;--------------------------------------------------------------------

CODE_03AD13:
	PHB
	PHK
	PLB
	JSR.w CODE_03ACB6
	PLB
	RTL

;--------------------------------------------------------------------

CODE_03AD1B:
	PHB
	PHK
	PLB
	JSR.w CODE_03ACE0
	PLB
	RTL

;--------------------------------------------------------------------

CODE_03AD23:
	PHB
	PHK
	PLB
	JSR.w CODE_03AA5E
	PLB
	RTL

if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	%FREE_BYTES(NULLROM, 22, $FF)
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_E) != $00
	%FREE_BYTES(NULLROM, 24, $FF)
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMB1_J) != $00
	%FREE_BYTES(NULLROM, 9, $FF)
else
	%FREE_BYTES(NULLROM, 53, $FF)
endif

;--------------------------------------------------------------------

SMB1_GameMode01_Level:
.Main:
;$03AD60
	LDA.w !RAM_SMB1_Level_CurrentState
	ASL
	TAX
	JMP.w (DATA_03AD68,x)

DATA_03AD68:
	dw SMB1_Level_State00_InitializeLevelPreview_Main
	dw CODE_038C25
	dw CODE_039ED8
	dw CODE_03AD70

;--------------------------------------------------------------------

CODE_03AD70:
	JSL.l CODE_05C860
CODE_03AD74:
	LDA.b !RAM_SMB1_Level_Player_CurrentPhysicsType
	BNE.b CODE_03AD7B
	STZ.w $0E67
CODE_03AD7B:
	LDX.w !RAM_SMB1_Player_CurrentCharacter
	LDA.w !RAM_SMB1_Global_ControllerHold1P1,x
	STA.w !RAM_SMB1_Global_ControllerHold1P1
	JSR.w CODE_03AF21
	LDA.w $0772
	CMP.b #$03
	BCS.b CODE_03AD8F
	RTS

CODE_03AD8F:
	JSR.w CODE_03B680
	LDX.b #$00
CODE_03AD94:
	STX.b $9E
	LDA.w $0E67
	BEQ.b CODE_03AD9F
	CMP.b #$7F
	BEQ.b CODE_03ADBD
CODE_03AD9F:
	JSR.w CODE_03C3B0
	LDA.w $0E67
	BNE.b CODE_03ADAA
	JSR.w CODE_038B3D
CODE_03ADAA:
	INX
	CPX.b #$0A
	BNE.b CODE_03AD94
	JSL.l SMB1_ProcessContactSprites_Main
	LDA.w $0E67
	BEQ.b CODE_03ADBD
	LDA.b #$7F
	STA.w $0E67
CODE_03ADBD:
	JSR.w CODE_03FD9C
	JSR.w CODE_03FD13
	JSR.w CODE_03F710
	LDX.b #$01
	STX.b $9E
	JSR.w CODE_03C027
	DEX
	STX.b $9E
	JSR.w CODE_03C027
	JSR.w CODE_03C08C
	JSR.w CODE_03BCC1
	JSR.w SMB1_ProcessBulletShooters_Main
	JSR.w SMB1_ProcessWhirlpools_Main
	JSR.w CODE_03B8F5
	JSR.w CODE_03B7DE
	JSR.w CODE_03935F
	LDA.b !RAM_SMB1_Player_YPosHi
	CMP.b #$02
	BPL.b CODE_03AE00
	LDA.w !RAM_SMB1_Player_StarPowerTimer
	BEQ.b CODE_03AE12
	CMP.b #$04
	BNE.b CODE_03AE00
	LDA.w !RAM_SMB1_Global_GenericTimer
	BNE.b CODE_03AE00
	JSL.l SMB1_SetLevelMusic_Main
CODE_03AE00:
	LDA.b !RAM_SMB1_Global_FrameCounter
	PHY
	LDY.w !RAM_SMB1_Player_StarPowerTimer
	CPY.b #$08
	BCS.b CODE_03AE0C
	LSR
	LSR
CODE_03AE0C:
	PLY
	JSR.w CODE_03B2C4
	BRA.b CODE_03AE26

CODE_03AE12:
	LDA.w !RAM_SMB1_Global_GenericTimer
	CMP.b #$01
	BNE.b CODE_03AE23
	LDA.b !RAM_SMB1_Player_CurrentState
	CMP.b #$0C
	BEQ.b CODE_03AE23
	JSL.l CODE_049A88
CODE_03AE23:
	JSR.w CODE_03B2FD
CODE_03AE26:
	LDA.b !RAM_SMB1_Global_ControllerABXYHeld
	STA.b !RAM_SMB1_Global_CopyOfControllerABXYHeld
	STZ.b !RAM_SMB1_Global_ControllerLeftRightHeld
CODE_03AE2C:
	LDA.w !RAM_SMB1_Global_StripeImageToUpload
	CMP.b #$06
	BEQ.b CODE_03AE4D
	LDA.w $071F
	BNE.b CODE_03AE4A
	LDA.w $073D
	CMP.b #$20
	BMI.b CODE_03AE4D
	LDA.w $073D
	SBC.b #$20
	STA.w $073D
	STZ.w $1A00
CODE_03AE4A:
	JSR.w CODE_03A295
CODE_03AE4D:
	RTS

;--------------------------------------------------------------------

CODE_03AE4E:
	LDA.w $06FF
	CLC
	ADC.w $03A1
	STA.w $06FF
	LDA.w !RAM_SMB1_Level_DisableScrollingFlag
	BEQ.b CODE_03AE60
	JMP.w CODE_03AED5

CODE_03AE60:
	LDA.w $0755
	CMP.b #$50
	BCC.b CODE_03AED5
	LDA.w $078D
	BNE.b CODE_03AED5
	LDY.w $06FF
	DEY
	BMI.b CODE_03AED5
	INY
	CPY.b #$02
	BCC.b CODE_03AE78
	DEY
CODE_03AE78:
	LDA.w $0755
	CMP.b #$70
	BCC.b CODE_03AE82
	LDY.w $06FF
CODE_03AE82:
	TYA
	STA.w $0775
	CLC
	ADC.w $073D
	STA.w $073D
	LDA.w $071C
	STA.b $00
	LDA.w $071A
	STA.b $01
	REP.b #$30
	TYA
	AND.w #$00FF
	CLC
	ADC.b $00
	STA.b $00
	LSR
	STA.w !RAM_SMB1_Global_CurrentLayer2XPosLo
	LSR
	STA.w !RAM_SMB1_Global_CurrentLayer3XPosLo
	SEP.b #$30
	LDA.b $00
	STA.w $071C
	STA.w !RAM_SMB1_Global_CurrentLayer1XPosLo
	STA.b $42
	LDA.b $01
	STA.w $071A
	STA.b $43
	AND.b #$01
	STA.b $00
	LDA.w $0778
	AND.b #$FE
	ORA.b $00
	STA.w $0778
	JSR.w CODE_03AF0F
	LDA.b #$08
	STA.w $07A1
	BRA.b CODE_03AED8

CODE_03AED5:
	STZ.w $0775
CODE_03AED8:
	LDX.b #$00
	JSR.w CODE_03FE1E
	STA.b $00
	LDY.b #$00
	ASL
	BCS.b CODE_03AEEB
	INY
	LDA.b $00
	AND.b #$20
	BEQ.b CODE_03AF05
CODE_03AEEB:
	LDA.w $071C,y
	SEC
	SBC.w DATA_03AF0B,y
	STA.w !RAM_SMB1_Player_XPosLo
	LDA.w $071A,y
	SBC.b #$00
	STA.b !RAM_SMB1_Player_XPosHi
	LDA.b !RAM_SMB1_Global_ControllerLeftRightHeld
	CMP.w DATA_03AF0D,y
	BEQ.b CODE_03AF05
	STZ.b !RAM_SMB1_Player_XSpeed
CODE_03AF05:
	LDA.b #$00
	STA.w $03A1
	RTS

DATA_03AF0B:
	db $00,$10

DATA_03AF0D:
	db !Joypad_DPadR>>8,!Joypad_DPadL>>8

;--------------------------------------------------------------------

CODE_03AF0F:
	LDA.w $071C
	CLC
	ADC.b #$FF
	STA.w $071D
	LDA.w $071A
	ADC.b #$00
	STA.w $071B
	RTS

;--------------------------------------------------------------------

; Note: Player state pointers

CODE_03AF21:
	LDA.b !RAM_SMB1_Player_CurrentState
	ASL
	TAX
	JMP.w (DATA_03AF28,x)

DATA_03AF28:						; Info: Player state...
	dw CODE_039FBD					; 00 - Unknown (Title screen?)
	dw CODE_03B1E3					; 01 - Climb vine
	dw CODE_03B233					; 02 - End of vine climb
	dw CODE_03B205					; 03 - In pipe
	dw CODE_03B309					; 04 - Initialize fade palette to black
	dw CODE_03B32B					; 05 - Fade palette to black
	dw CODE_03A060					; 06 - Show level intro
	dw CODE_03AF42					; 07 - Enter Level?
	dw CODE_03AFF4					; 08 - Normal
	dw CODE_03B26E					; 09 - Grow
	dw CODE_03B280					; 0A - Shrink
	dw CODE_03B2A4					; 0B - Dead?
	dw CODE_03B2BA					; 0C - Unknown

;--------------------------------------------------------------------

CODE_03AF42:
	LDA.w !RAM_SMB1_Level_Player_TriggeredScreenExitFlag
	CMP.b #$02
	BEQ.b CODE_03AF85
	LDA.b #$00
	LDY.w !RAM_SMB1_Player_YPosLo
	CPY.b #$30
	BCS.b CODE_03AF55
	JMP.w CODE_03AFEA

CODE_03AF55:
	LDA.w !RAM_SMB1_Player_LevelEntrancePositionIndex
	CMP.b #$06
	BEQ.b CODE_03AF60
	CMP.b #$07
	BNE.b CODE_03AFCF
CODE_03AF60:
	LDA.w $0256
	AND.b #$F0
	BEQ.b CODE_03AF6C
	LDA.b #!Joypad_DPadR>>8
	JMP.w CODE_03AFEA

CODE_03AF6C:
	JSR.w CODE_03B259
	DEC.w !RAM_SMB1_Player_WaitBeforeWarpingInPipe
	BNE.b CODE_03AFE5
	LDA.b #$01
	STA.w !RAM_SMB1_Global_FadeDirection
	STA.w !RAM_SMB1_Global_EnableMosaicFadesFlag
	INC.w $0769
	INC.w !RAM_SMB1_Player_CurrentLevel
	JMP.w CODE_03B368

CODE_03AF85:
	LDA.w !RAM_SMB1_Player_VineScreenExitFlag
	BNE.b CODE_03AFA6
	LDA.w !RAM_SMB1_Player_YPosLo
	CMP.b #$B0
	BNE.b CODE_03AF96
	LDA.b #!Define_SMAS_Sound0060_IntoPipe
	STA.w !RAM_SMB1_Global_SoundCh1
CODE_03AF96:
	STA.w $0E4E
	LDA.b #$FF
	JSR.w CODE_03B22B
	LDA.w !RAM_SMB1_Player_YPosLo
	CMP.b #$91
	BCC.b CODE_03AFCF
	RTS

CODE_03AFA6:
	LDA.w $0399
	CMP.b #$60
	BNE.b CODE_03AFE5
	LDA.w !RAM_SMB1_Player_YPosLo
	CMP.b #$99
	LDY.b #$00
	LDA.b #!Joypad_DPadR>>8
	BCC.b CODE_03AFC2
	LDA.b #$03
	STA.b !RAM_SMB1_Level_Player_CurrentPhysicsType
	INY
	LDA.b #$08
	STA.w $05B4
CODE_03AFC2:
	STY.w !RAM_SMB1_Level_Player_DisableObjectInteractionFlag
	JSR.w CODE_03AFEA
	LDA.w !RAM_SMB1_Player_XPosLo
	CMP.b #$48
	BCC.b CODE_03AFE5
CODE_03AFCF:
	STZ.w $0E4E
	LDA.b #$08
	STA.b !RAM_SMB1_Player_CurrentState
	LDA.b #$01
	STA.w !RAM_SMB1_Level_Player_FacingDirection
	LSR
	STA.w !RAM_SMB1_Level_Player_TriggeredScreenExitFlag
	STA.w !RAM_SMB1_Level_Player_DisableObjectInteractionFlag
	STA.w !RAM_SMB1_Player_VineScreenExitFlag
CODE_03AFE5:
	RTS

;--------------------------------------------------------------------

DATA_03AFE6:
	db $03,$FD

DATA_03AFE8:
	db $00,$FF

CODE_03AFEA:
	STA.w !RAM_SMB1_Global_ControllerHold1P1
	LDA.b #$01
	STA.w $0B7A
	BRA.b CODE_03AFF7

CODE_03AFF4:
	STZ.w $0B7A
CODE_03AFF7:
	LDA.b !RAM_SMB1_Player_CurrentState
	CMP.b #$0B
	BEQ.b CODE_03B035
	LDA.b !RAM_SMB1_Level_CurrentLevelType
	BNE.b CODE_03B010
	LDY.b !RAM_SMB1_Player_YPosHi
	DEY
	BNE.b CODE_03B00D
	LDA.w !RAM_SMB1_Player_YPosLo
	CMP.b #$D0
	BCC.b CODE_03B010
CODE_03B00D:
	STZ.w !RAM_SMB1_Global_ControllerHold1P1
CODE_03B010:
	LDA.w !RAM_SMB1_Global_ControllerHold1P1
	AND.b #!Joypad_A|(!Joypad_B>>8)|!Joypad_X|(!Joypad_Y>>8)
	STA.b !RAM_SMB1_Global_ControllerABXYHeld
	LDA.w !RAM_SMB1_Global_ControllerHold1P1
	AND.b #(!Joypad_DPadL>>8)|(!Joypad_DPadR>>8)
	STA.b !RAM_SMB1_Global_ControllerLeftRightHeld
	LDA.w !RAM_SMB1_Global_ControllerHold1P1
	AND.b #(!Joypad_DPadU>>8)|(!Joypad_DPadD>>8)
	STA.b !RAM_SMB1_Global_ControllerUpDownHeld
	AND.b #!Joypad_DPadD>>8
	BEQ.b CODE_03B035
	LDA.b !RAM_SMB1_Level_Player_CurrentPhysicsType
	BNE.b CODE_03B035
	LDY.b !RAM_SMB1_Global_ControllerLeftRightHeld
	BEQ.b CODE_03B035							; Note: (!Joypad_DPadL>>8)|(!Joypad_DPadR>>8)
	STZ.b !RAM_SMB1_Global_ControllerLeftRightHeld
	STZ.b !RAM_SMB1_Global_ControllerUpDownHeld
CODE_03B035:
	LDA.l !SRAM_SMAS_Global_EnableSMASDebugModeFlag
	BNE.b CODE_03B03E
	JMP.w CODE_03B129

CODE_03B03E:
	PHX
	LDX.w $0EC3
	LDA.w !RAM_SMB1_Global_ControllerHold2P1,x
	PLX
	AND.b #!Joypad_A|!Joypad_X
	BEQ.b CODE_03B060
	AND.b #!Joypad_A
	BEQ.b CODE_03B058
	STZ.w !RAM_SMB1_Player_CurrentSize
	LDA.b #$01
	STA.w !RAM_SMB1_Player_CurrentPowerUp
	BRA.b CODE_03B060

CODE_03B058:
	STZ.w !RAM_SMB1_Player_CurrentSize
	LDA.b #$02
	STA.w !RAM_SMB1_Player_CurrentPowerUp
CODE_03B060:
	LDA.w !RAM_SMB1_Global_ControllerPress1P1
	AND.b #!Joypad_Select>>8
	BEQ.b CODE_03B075
	EOR.w !RAM_SMB1_Level_FreeMovementDebugFlag
	STA.w !RAM_SMB1_Level_FreeMovementDebugFlag
	LSR
	LSR
	LSR
	LSR
	LSR
	STA.w !RAM_SMB1_Level_Player_DisableObjectInteractionFlag
CODE_03B075:
	LDA.w !RAM_SMB1_Level_FreeMovementDebugFlag
	BNE.b CODE_03B07D
	JMP.w CODE_03B129

CODE_03B07D:
	LDA.b #$10
	STA.w !RAM_SMB1_Player_StarPowerTimer
	PHX
	LDX.w !RAM_SMB1_Player_CurrentCharacter
	LDA.w !RAM_SMB1_Global_ControllerHold2P1,x
	PLX
	AND.b #!Joypad_R
	BEQ.b CODE_03B0CD
	LDA.b !RAM_SMB1_Global_FrameCounter
	AND.b #$07
	BNE.b CODE_03B0CD
	LDA.w !RAM_SMB1_Global_ControllerHold1P1
	LSR
	BCS.b CODE_03B0A6						; Note: !Joypad_DPadR>>8
	LSR
	BCS.b CODE_03B0B4						; Note: !Joypad_DPadL>>8
	LSR
	BCS.b CODE_03B0CA						; Note: !Joypad_DPadD>>8
	LSR
	BCS.b CODE_03B0C3						; Note: !Joypad_DPadU>>8
	JMP.w CODE_03B12C

CODE_03B0A6:
	LDA.b #$09
	STA.w !RAM_SMB1_Level_TimerTens
	STA.w !RAM_SMB1_Level_TimerOnes
	STA.w !RAM_SMB1_Level_TimerHundreds
	JMP.w CODE_03B12C

CODE_03B0B4:
	STZ.w !RAM_SMB1_Level_TimerTens
	STZ.w !RAM_SMB1_Level_TimerOnes
	STZ.w !RAM_SMB1_Level_TimerHundreds
	STZ.w !RAM_SMB1_Level_FreeMovementDebugFlag
	JMP.w CODE_03B12C

CODE_03B0C3:
	JSL.l CODE_048596
	JMP.w CODE_03B12C

CODE_03B0CA:
	JMP.w CODE_03B12C

CODE_03B0CD:
	LDA.b !RAM_SMB1_Global_FrameCounter
	AND.b #$07
	BNE.b CODE_03B0EE
	LDA.w !RAM_SMB1_Global_ControllerHold1P1
	AND.b #!Joypad_B>>8
	BEQ.b CODE_03B0EE
	LDA.w !RAM_SMB1_Player_CurrentSize
	EOR.b #$01
	STA.w !RAM_SMB1_Player_CurrentSize
	LDA.w !RAM_SMB1_Player_CurrentPowerUp
	EOR.b #$02
	STA.w !RAM_SMB1_Player_CurrentPowerUp
	JSL.l CODE_049A88
CODE_03B0EE:
	LDA.w !RAM_SMB1_Global_ControllerHold1P1
	AND.b #(!Joypad_DPadL>>8)|(!Joypad_DPadR>>8)
	BEQ.b CODE_03B10C
	TAY
	LDA.b !RAM_SMB1_Global_ControllerLeftRightHeld
	STA.w !RAM_SMB1_Level_Player_FacingDirection
	LDA.w !RAM_SMB1_Player_XPosLo
	CLC
	ADC.w DATA_03AFE6-$01,y
	STA.w !RAM_SMB1_Player_XPosLo
	LDA.b !RAM_SMB1_Player_XPosHi
	ADC.w DATA_03AFE8-$01,y
	STA.b !RAM_SMB1_Player_XPosHi
CODE_03B10C:
	LDA.w !RAM_SMB1_Global_ControllerHold1P1
	AND.b #(!Joypad_DPadU>>8)|(!Joypad_DPadD>>8)
	BEQ.b CODE_03B12C
	LSR
	LSR
	TAY
	LDA.w !RAM_SMB1_Player_YPosLo
	CLC
	ADC.w DATA_03AFE6-$01,y
	STA.w !RAM_SMB1_Player_YPosLo
	LDA.b !RAM_SMB1_Player_YPosHi
	ADC.w DATA_03AFE8-$01,y
	STA.b !RAM_SMB1_Player_YPosHi
	BRA.b CODE_03B12C

CODE_03B129:
	JSR.w CODE_03B373
CODE_03B12C:
	LDY.b #$01
	LDA.w !RAM_SMB1_Player_CurrentSize
	BNE.b CODE_03B13C
	LDY.b #$00
	LDA.w !RAM_SMB1_Level_Player_IsDuckingFlag
	BEQ.b CODE_03B13C
	LDY.b #$02
CODE_03B13C:
	STY.w !RAM_SMB1_Player_HitboxSizeIndex
	LDA.b #$01
	LDY.b !RAM_SMB1_Player_XSpeed
	BEQ.b CODE_03B14A
	BPL.b CODE_03B148
	ASL
CODE_03B148:
	STA.b $46
CODE_03B14A:
	JSR.w CODE_03AE4E
	JSR.w CODE_03FD9C
	JSR.w CODE_03FD13
	LDX.b #$00
	JSR.w CODE_03EA2D
	JSR.w SMB1_HandlePlayerLevelCollision_Main
	LDA.w !RAM_SMB1_Player_YPosLo
	CMP.b #$40
	BCC.b CODE_03B189
	LDA.b !RAM_SMB1_Player_CurrentState
	CMP.b #$05
	BEQ.b CODE_03B189
	CMP.b #$07
	BEQ.b CODE_03B189
	CMP.b #$04
	BCC.b CODE_03B189
	LDA.b !RAM_SMB1_Player_CurrentState
	CMP.b #$0B
	BNE.b CODE_03B17F
	LDA.w $0256
	AND.b #$CE
	ORA.b #$30
	BRA.b CODE_03B186

CODE_03B17F:
	LDA.w $0256
	AND.b #$CE
	ORA.b #$20
CODE_03B186:
	STA.w $0256
CODE_03B189:
	LDA.b !RAM_SMB1_Player_YPosHi
	CMP.b #$02
	BMI.b CODE_03B1D8
	LDX.b #$01
	STX.w !RAM_SMB1_Level_DisableScrollingFlag
	LDY.b #$04
	STY.b $07
	LDX.b #$00
	LDY.w $0759
	BNE.b CODE_03B1A4
	LDY.w $0743
	BNE.b CODE_03B1C8
CODE_03B1A4:
	INX
	LDY.b !RAM_SMB1_Player_CurrentState
	CPY.b #$0B
	BEQ.b CODE_03B1C8
	LDY.w $0712
	BNE.b CODE_03B1C4
	INY
	STY.w $0712
	LDY.b #!Define_SMB1_LevelMusic_MarioDied
	STY.w !RAM_SMB1_Global_MusicCh1
	STA.w $0E67
	LDA.b #$01
	STA.w !RAM_SMB1_Player_CurrentSize
	STZ.w !RAM_SMB1_Player_CurrentPowerUp
CODE_03B1C4:
	LDY.b #$06
	STY.b $07
CODE_03B1C8:
	CMP.b $07
	BMI.b CODE_03B1D8
	DEX
	BMI.b CODE_03B1D9
	LDY.w $07B1
	BNE.b CODE_03B1D8
	LDA.b #$06
	STA.b !RAM_SMB1_Player_CurrentState
CODE_03B1D8:
	RTS

CODE_03B1D9:
	STZ.w !RAM_SMB1_Player_VineScreenExitFlag
	JSR.w CODE_03B1FD
	INC.w !RAM_SMB1_Level_Player_TriggeredScreenExitFlag
	RTS

;--------------------------------------------------------------------

CODE_03B1E3:
	LDA.b !RAM_SMB1_Player_YPosHi
	BNE.b CODE_03B1EE
	LDA.w !RAM_SMB1_Player_YPosLo
	CMP.b #$E4
	BCC.b CODE_03B1FD
CODE_03B1EE:
	LDA.b #$08
	STA.w !RAM_SMB1_Player_VineScreenExitFlag
	STA.w $0E67
	LDY.b #$03
	STY.b !RAM_SMB1_Level_Player_CurrentPhysicsType
	JMP.w CODE_03AFEA					; Note: !Joypad_DPadU>>8

CODE_03B1FD:
	LDA.b #$02
	STA.w !RAM_SMB1_Level_Player_TriggeredScreenExitFlag
	JMP.w CODE_03B248

;--------------------------------------------------------------------

CODE_03B205:
	LDA.b #$01
	STA.w !RAM_SMB1_Global_EnableMosaicFadesFlag
	STA.w $0218
	LDA.b !RAM_SMB1_Global_FrameCounter
	LSR
	BCC.b CODE_03B217
	LDA.b #$01
	JSR.w CODE_03B22B
CODE_03B217:
	JSR.w CODE_03AE4E
	LDY.b #$00
	LDA.w !RAM_SMB1_Level_WarpZoneActiveFlag
	BNE.b CODE_03B240
	INY
	LDA.b !RAM_SMB1_Level_CurrentLevelType
	CMP.b #$03
	BNE.b CODE_03B240
	INY
	BRA.b CODE_03B240

CODE_03B22B:
	CLC
	ADC.w !RAM_SMB1_Player_YPosLo
	STA.w !RAM_SMB1_Player_YPosLo
	RTS

;--------------------------------------------------------------------

CODE_03B233:
	LDA.b #$01
	STA.w $0E67
	STA.w !RAM_SMB1_Global_EnableMosaicFadesFlag
	JSR.w CODE_03B259
	LDY.b #$02
CODE_03B240:
	DEC.w !RAM_SMB1_Player_WaitBeforeWarpingInPipe
	BNE.b CODE_03B258
	STY.w !RAM_SMB1_Level_Player_TriggeredScreenExitFlag
CODE_03B248:
	LDA.b #$01
	STA.w !RAM_SMB1_Global_FadeDirection
	STA.w $0E67
	LDA.b #$00
	STA.w $0772
	STA.w !RAM_SMB1_Global_CopyOfDisableSpriteOAMResetFlag
CODE_03B258:
	RTS

;--------------------------------------------------------------------

CODE_03B259:
	LDA.b #$08
	STA.b !RAM_SMB1_Player_XSpeed
	LDY.b #$01
	LDA.w !RAM_SMB1_Player_XPosLo
	AND.b #$0F
	BNE.b CODE_03B269
	STA.b !RAM_SMB1_Player_XSpeed
	TAY
CODE_03B269:
	TYA
	JSR.w CODE_03AFEA
	RTS

;--------------------------------------------------------------------

CODE_03B26E:
	LDA.w !RAM_SMB1_Level_FreezeSpritesTimer
	CMP.b #$F8
	BNE.b CODE_03B278
	JMP.w CODE_03B290

CODE_03B278:
	CMP.b #$C4
	BNE.b CODE_03B27F
	JSR.w CODE_03B2AE
CODE_03B27F:
	RTS

CODE_03B280:
	LDA.w !RAM_SMB1_Level_FreezeSpritesTimer
	CMP.b #$F0
	BCS.b CODE_03B28E
	CMP.b #$C8
	BEQ.b CODE_03B2AE
	JMP.w CODE_03AFF4

CODE_03B28E:
	BNE.b CODE_03B2A3
CODE_03B290:
	LDY.w !RAM_SMB1_Level_Player_SizeChangeAnimationFlag
	BNE.b CODE_03B2A3
	STY.w $070D
	INC.w !RAM_SMB1_Level_Player_SizeChangeAnimationFlag
	LDA.w !RAM_SMB1_Player_CurrentSize
	EOR.b #$01
	STA.w !RAM_SMB1_Player_CurrentSize
CODE_03B2A3:
	RTS

;--------------------------------------------------------------------

CODE_03B2A4:
	LDA.w !RAM_SMB1_Level_FreezeSpritesTimer
	CMP.b #$F0
	BCS.b CODE_03B308
	JMP.w CODE_03AFF4

;--------------------------------------------------------------------

CODE_03B2AE:
	STZ.w !RAM_SMB1_Level_FreezeSpritesTimer
	JSL.l CODE_049A88
	LDA.b #$08
	STA.b !RAM_SMB1_Player_CurrentState
	RTS

;--------------------------------------------------------------------

; Note: Routine that updates the player palette?

CODE_03B2BA:
	LDA.w !RAM_SMB1_Level_FreezeSpritesTimer
	CMP.b #$C0
	BEQ.b CODE_03B2FA
	EOR.b #$FF
	ASL
CODE_03B2C4:
	ASL
	ASL
	ASL
	PHY
	PHX
	REP.b #$30
	AND.w #$0060
	TAX
	LDA.w !RAM_SMB1_Player_CurrentCharacter
	AND.w #$00FF
	BEQ.b CODE_03B2DD
	TXA
	CLC
	ADC.w #$0020
	TAX
CODE_03B2DD:
	LDY.w #$01E0
CODE_03B2E0:
	LDA.l DATA_05ED91,x
	STA.w SMB1_PaletteMirror[$00].LowByte,y
	INX
	INX
	INY
	INY
	CPY.w #$0200
	BNE.b CODE_03B2E0
	SEP.b #$30
	PLX
	PLY
	LDA.b #$01
	STA.w !RAM_SMB1_Global_UpdateEntirePaletteFlag
	RTS

CODE_03B2FA:
	JSR.w CODE_03B2AE
CODE_03B2FD:
	LDA.w $0256
	AND.b #$F1
	ORA.b #$0E
	STA.w $0256
	RTS

CODE_03B308:
	RTS

;--------------------------------------------------------------------

CODE_03B309:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDA.b !RAM_SMB1_NorSpr_SpriteID+$09
else
	LDA.b !RAM_SMB1_NorSpr_SpriteID+$05
endif
	CMP.b #!Define_SMB1_SpriteID_NorSpr030_Flagpole
	BNE.b CODE_03B320
	LDA.b #$00
	STA.w $0713
	LDY.w !RAM_SMB1_Player_YPosLo
	CPY.b #$9E
	BCS.b CODE_03B31D
	LDA.b #!Joypad_DPadD>>8
CODE_03B31D:
	JMP.w CODE_03AFEA

CODE_03B320:
	INC.b !RAM_SMB1_Player_CurrentState
	RTS

;--------------------------------------------------------------------

DATA_03B323:
	db $15,$23,$16,$1B,$17,$18,$23,$63

CODE_03B32B:
	JSL.l CODE_05CBE5
	BEQ.b CODE_03B340
	LDA.b #!Joypad_DPadR>>8
	JSR.w CODE_03AFEA
	LDA.w !RAM_SMB1_Player_YPosLo
	CMP.b #$AE
	BCC.b CODE_03B340
	STZ.w !RAM_SMB1_Level_DisableScrollingFlag
CODE_03B340:
	LDA.w $0746
	CMP.b #$05
	BNE.b CODE_03B372
	INC.w !RAM_SMB1_Player_CurrentLevelNumberDisplay
	LDA.w !RAM_SMB1_Player_CurrentLevelNumberDisplay
	CMP.b #$03
	BNE.b CODE_03B35F
	LDY.w !RAM_SMB1_Player_CurrentWorld
	LDA.w $0748
	CMP.w DATA_03B323,y
	BCC.b CODE_03B35F
	INC.w !RAM_SMB1_Level_CanFindHidden1upFlag
CODE_03B35F:
	INC.w !RAM_SMB1_Player_CurrentLevel
	STZ.w !RAM_SMB1_Player_CurrentStartingScreen
	JSR.w CODE_03A22B
CODE_03B368:
	JSL.l CODE_04C00B
	INC.w $0757
	JSR.w CODE_03B248
CODE_03B372:
	RTS

;--------------------------------------------------------------------

CODE_03B373:
	LDA.b #$00
	LDY.w !RAM_SMB1_Player_CurrentSize
	BNE.b CODE_03B382
	LDA.b !RAM_SMB1_Level_Player_CurrentPhysicsType
	BNE.b CODE_03B385
	LDA.b !RAM_SMB1_Global_ControllerUpDownHeld
	AND.b #!Joypad_DPadD>>8
CODE_03B382:
	STA.w !RAM_SMB1_Level_Player_IsDuckingFlag
CODE_03B385:
	JSR.w CODE_03B4AD
	LDA.w !RAM_SMB1_Level_Player_SizeChangeAnimationFlag
	BNE.b CODE_03B3A5
	LDA.b !RAM_SMB1_Level_Player_CurrentPhysicsType
	CMP.b #$03
	BEQ.b CODE_03B398
	LDY.b #$18
	STY.w $0791
CODE_03B398:
	ASL
	TAX
	JMP.w (DATA_03B39D,x)

DATA_03B39D:
	dw SMB1_PlayerPhysics00_OnGround_Main
	dw CODE_03B3C3
	dw CODE_03B3BA
	dw SMB1_PlayerPhysics03_ClimbingVine_Main

CODE_03B3A5:
	RTS

;--------------------------------------------------------------------

SMB1_PlayerPhysics00_OnGround:
.Main:
;$03B3A6
	JSR.w CODE_03B5F0
	LDA.b !RAM_SMB1_Global_ControllerLeftRightHeld
	BEQ.b CODE_03B3B0					; Note: (!Joypad_DPadL>>8)|(!Joypad_DPadR>>8)
	STA.w !RAM_SMB1_Level_Player_FacingDirection
CODE_03B3B0:
	JSR.w CODE_03B62B
	JSR.w CODE_03C0BC
	STA.w $06FF
	RTS

;--------------------------------------------------------------------

CODE_03B3BA:
	LDA.w $070A
	STA.w $0709
	JMP.w CODE_03B3FC

;--------------------------------------------------------------------

CODE_03B3C3:
	LDY.b !RAM_SMB1_Player_YSpeed
	BPL.b CODE_03B3DB
	LDA.b !RAM_SMB1_Global_ControllerABXYHeld
	AND.b #!Joypad_A|(!Joypad_B>>8)
	AND.b !RAM_SMB1_Global_CopyOfControllerABXYHeld
	BNE.b CODE_03B3E1
	LDA.w $0708
	SEC
	SBC.w !RAM_SMB1_Player_YPosLo
	CMP.w $0706
	BCC.b CODE_03B3E1
CODE_03B3DB:
	LDA.w $070A
	STA.w $0709
CODE_03B3E1:
	LDA.w !RAM_SMB1_Level_UnderwaterLevelFlag
	BEQ.b CODE_03B3FC
	JSR.w CODE_03B5F0
	LDA.w !RAM_SMB1_Player_YPosLo
	CMP.b #$14
	BCS.b CODE_03B3F5
	LDA.b #$18
	STA.w $0709
CODE_03B3F5:
	LDA.b !RAM_SMB1_Global_ControllerLeftRightHeld
	BEQ.b CODE_03B3FC						; Note: (!Joypad_DPadL>>8)|(!Joypad_DPadR>>8)
	STA.w !RAM_SMB1_Level_Player_FacingDirection
CODE_03B3FC:
	LDA.b !RAM_SMB1_Global_ControllerLeftRightHeld
	BEQ.b CODE_03B403						; Note: (!Joypad_DPadL>>8)|(!Joypad_DPadR>>8)
	JSR.w CODE_03B62B
CODE_03B403:
	JSR.w CODE_03C0BC
	STA.w $06FF
	LDA.b !RAM_SMB1_Player_CurrentState
	CMP.b #$0B
	BNE.b CODE_03B414
	LDA.b #$28
	STA.w $0709
CODE_03B414:
	JMP.w CODE_03C105

;--------------------------------------------------------------------

DATA_03B417:
	db $0E,$04,$FC,$F2

DATA_03B41B:
	db $00,$00,$FF,$FF

SMB1_PlayerPhysics03_ClimbingVine:
.Main:
	LDA.w !RAM_SMB1_Player_SubYPos
	CLC
	ADC.w !RAM_SMB1_Player_SubYSpeed
	STA.w !RAM_SMB1_Player_SubYPos
	LDY.b #$00
	LDA.b !RAM_SMB1_Player_YSpeed
	BPL.b CODE_03B430
	DEY
CODE_03B430:
	STY.b $00
	ADC.w !RAM_SMB1_Player_YPosLo
	STA.w !RAM_SMB1_Player_YPosLo
	LDA.b !RAM_SMB1_Player_YPosHi
	ADC.b $00
	STA.b !RAM_SMB1_Player_YPosHi
	LDA.b !RAM_SMB1_Global_ControllerLeftRightHeld
	AND.w $0480
	BEQ.b CODE_03B47D
	LDY.w $0791
	BNE.b CODE_03B47C
	LDY.b #$18
	STY.w $0791
	LDX.b #$00
	LDY.w !RAM_SMB1_Level_Player_FacingDirection
	LSR
	BCS.b CODE_03B460
	LDA.w $03AD
	CMP.b #$10
	BCC.b CODE_03B47C
	INX
	INX
CODE_03B460:
	DEY
	BEQ.b CODE_03B464
	INX
CODE_03B464:
	LDA.w !RAM_SMB1_Player_XPosLo
	CLC
	ADC.w DATA_03B417,x
	STA.w !RAM_SMB1_Player_XPosLo
	LDA.b !RAM_SMB1_Player_XPosHi
	ADC.w DATA_03B41B,x
	STA.b !RAM_SMB1_Player_XPosHi
	LDA.b !RAM_SMB1_Global_ControllerLeftRightHeld
	EOR.b #(!Joypad_DPadL>>8)|(!Joypad_DPadR>>8)
	STA.w !RAM_SMB1_Level_Player_FacingDirection
CODE_03B47C:
	RTS

CODE_03B47D:
	STA.w $0791
	RTS

;--------------------------------------------------------------------

if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
DATA_03B481:
	db $30,$30,$2D,$38,$38,$0D,$04

DATA_03B488:
	db $A6,$A6,$8E,$CE,$CE,$0A,$09

DATA_03B48F:
	db $FB,$FB,$FB,$FA,$FA,$FE,$FF

DATA_03B496:
	db $34,$34,$34,$00,$00,$80,$00

DATA_03B49D:
	db $D0,$E4,$ED

DATA_03B4A0:
	db $30,$1C,$13,$0E

DATA_03B4A4:
	db $C0,$00,$80
else
DATA_03B481:
	db $20,$20,$1E,$28,$28,$0D,$04

DATA_03B488:
	db $70,$70,$60,$90,$90,$0A,$09

DATA_03B48F:
	db $FC,$FC,$FC,$FB,$FB,$FE,$FF

DATA_03B496:
	db $00,$00,$00,$00,$00,$80,$00

DATA_03B49D:
	db $D8,$E8,$F0

DATA_03B4A0:
	db $28,$18,$10,$0C

DATA_03B4A4:
	db $E4,$98,$D0
endif

DATA_03B4A7:
	db $00,$FF,$01

DATA_03B4AA:
	db $00,$20,$FF

CODE_03B4AD:
	LDA.b !RAM_SMB1_Level_Player_CurrentPhysicsType
	CMP.b #$03
	BNE.b CODE_03B4E3
	LDY.b #$00
	LDA.b !RAM_SMB1_Global_ControllerUpDownHeld
	AND.w $0480
	BEQ.b CODE_03B4CF
	INY
	AND.b #$08
	BEQ.b CODE_03B4CE
	LDA.b !RAM_SMB1_Global_FrameCounter
	AND.b #$07
	BNE.b CODE_03B4CF
	LDA.b #!Define_SMAS_Sound0060_ClimbVine
	STA.w !RAM_SMB1_Global_SoundCh1
	BRA.b CODE_03B4CF

CODE_03B4CE:
	INY
CODE_03B4CF:
	LDX.w DATA_03B4AA,y
	STX.w !RAM_SMB1_Player_SubYSpeed
	LDA.b #$08
	LDX.w DATA_03B4A7,y
	STX.b !RAM_SMB1_Player_YSpeed
	BMI.b CODE_03B4DF
	LSR
CODE_03B4DF:
	STA.w $070C
	RTS

CODE_03B4E3:
	LDA.w $070E
	BNE.b CODE_03B4F2
	LDA.b !RAM_SMB1_Global_ControllerABXYHeld
	AND.b #!Joypad_A|(!Joypad_B>>8)
	BEQ.b CODE_03B4F2
	AND.b !RAM_SMB1_Global_CopyOfControllerABXYHeld
	BEQ.b CODE_03B4F5
CODE_03B4F2:
	JMP.w CODE_03B580

CODE_03B4F5:
	LDA.b !RAM_SMB1_Level_Player_CurrentPhysicsType
	BEQ.b CODE_03B50A
	LDA.w !RAM_SMB1_Level_UnderwaterLevelFlag
	BEQ.b CODE_03B4F2
	LDA.w $078A
	BNE.b CODE_03B50A
	LDA.b !RAM_SMB1_Player_YSpeed
	BPL.b CODE_03B50A
	JMP.w CODE_03B580

CODE_03B50A:
	LDA.b #$20
	STA.w $078A
	LDY.b #$00
	STY.w !RAM_SMB1_Player_SubYPos
	STY.w !RAM_SMB1_Player_SubYSpeed
	LDA.b !RAM_SMB1_Player_YPosHi
	STA.w $0707
	LDA.w !RAM_SMB1_Player_YPosLo
	STA.w $0708
	LDA.b #$01
	STA.b !RAM_SMB1_Level_Player_CurrentPhysicsType
	LDA.w $0700
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	CMP.b #$0A
else
	CMP.b #$09
endif
	BCC.b CODE_03B53D
	INY
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	CMP.b #$12
else
	CMP.b #$10
endif
	BCC.b CODE_03B53D
	INY
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	CMP.b #$1D
else
	CMP.b #$19
endif
	BCC.b CODE_03B53D
	INY
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	CMP.b #$22
else
	CMP.b #$1C
endif
	BCC.b CODE_03B53D
	INY
CODE_03B53D:
	LDA.b #$01
	STA.w $0706
	LDA.w !RAM_SMB1_Level_UnderwaterLevelFlag
	BEQ.b CODE_03B54F
	LDY.b #$05
	LDA.w !RAM_SMB1_Level_BulletShooterTimer
	BEQ.b CODE_03B54F
	INY
CODE_03B54F:
	LDA.w DATA_03B481,y
	STA.w $0709
	LDA.w DATA_03B488,y
	STA.w $070A
	LDA.w DATA_03B496,y
	STA.w !RAM_SMB1_Player_SubYSpeed
	LDA.w DATA_03B48F,y
	STA.b !RAM_SMB1_Player_YSpeed
	LDA.w !RAM_SMB1_Level_UnderwaterLevelFlag
	BEQ.b CODE_03B57B
	LDA.b #!Define_SMAS_Sound0060_Swim
	STA.w !RAM_SMB1_Global_SoundCh1
	LDA.w !RAM_SMB1_Player_YPosLo
	CMP.b #$14
	BCS.b CODE_03B580
	STZ.b !RAM_SMB1_Player_YSpeed
	BRA.b CODE_03B580

CODE_03B57B:
	LDA.b #!Define_SMAS_Sound0061_Jump
	STA.w !RAM_SMB1_Global_SoundCh2
CODE_03B580:
	LDY.b #$00
	STY.b $00
	LDA.b !RAM_SMB1_Level_Player_CurrentPhysicsType
	BEQ.b CODE_03B591
	LDA.w $0700
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	CMP.b #$1D
else
	CMP.b #$19
endif
	BCS.b CODE_03B5C0
	BCC.b CODE_03B5A8							; Note: This will always branch

CODE_03B591:
	INY
	LDA.b !RAM_SMB1_Level_CurrentLevelType
	BEQ.b CODE_03B5A8
	DEY
	LDA.b !RAM_SMB1_Global_ControllerLeftRightHeld
	CMP.b $46
	BNE.b CODE_03B5A8
	LDA.b !RAM_SMB1_Global_ControllerABXYHeld
	AND.b #!Joypad_X|(!Joypad_Y>>8)
	BNE.b CODE_03B5BB
	LDA.w $078B
	BNE.b CODE_03B5C0
CODE_03B5A8:
	INY
	INC.b $00
	LDA.w $0703
	BNE.b CODE_03B5B7
	LDA.w $0700
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	CMP.b #$27
else
	CMP.b #$21
endif
	BCC.b CODE_03B5C0
CODE_03B5B7:
	INC.b $00
	BRA.b CODE_03B5C0

CODE_03B5BB:
	LDA.b #$0A
	STA.w $078B
CODE_03B5C0:
	LDA.w DATA_03B49D,y
	STA.w $045D
	LDA.b !RAM_SMB1_Player_CurrentState
	CMP.b #$07
	BNE.b CODE_03B5CE
	LDY.b #$03
CODE_03B5CE:
	LDA.w DATA_03B4A0,y
	STA.w $0463
	LDY.b $00
	LDA.w DATA_03B4A4,y
	STA.w $0702
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDA.b #$01
	STA.w $0701
else
	STZ.w $0701
endif
	LDA.w !RAM_SMB1_Level_Player_FacingDirection
	CMP.b $46
	BEQ.b CODE_03B5EC
	ASL.w $0702
	ROL.w $0701
CODE_03B5EC:
	RTS

;--------------------------------------------------------------------

DATA_03B5ED:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	db $02,$03,$05
else
	db $02,$04,$07
endif

CODE_03B5F0:
	LDY.b #$00
	LDA.w $0700
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	CMP.b #$20
else
	CMP.b #$1C
endif
	BCS.b CODE_03B60E
	INY
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	CMP.b #$10
else
	CMP.b #$0E
endif
	BCS.b CODE_03B5FF
	INY
CODE_03B5FF:
	LDA.w !RAM_SMB1_Global_ControllerHold1P1
	AND.b #(!Joypad_DPadL>>8)|(!Joypad_DPadR>>8)|(!Joypad_DPadU>>8)|(!Joypad_DPadD>>8)|(!Joypad_Start>>8)|(!Joypad_Select>>8)|(!Joypad_Y>>8)
	BEQ.b CODE_03B624
	AND.b #(!Joypad_DPadL>>8)|(!Joypad_DPadR>>8)
	CMP.b $46
	BNE.b CODE_03B613
	LDA.b #$00
CODE_03B60E:
	STA.w $0703
	BRA.b CODE_03B624

CODE_03B613:
	LDA.w $0700
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	CMP.b #$0D
else
	CMP.b #$0B
endif
	BCS.b CODE_03B624
	LDA.w !RAM_SMB1_Level_Player_FacingDirection
	STA.b $46
	STZ.b !RAM_SMB1_Player_XSpeed
	STZ.w $0705
CODE_03B624:
	LDA.w DATA_03B5ED,y
	STA.w $070C
	RTS

;--------------------------------------------------------------------

; Note: Player physics related.

CODE_03B62B:
	AND.w $0480
	BNE.b CODE_03B638
	LDA.b !RAM_SMB1_Player_XSpeed
	BEQ.b CODE_03B67C
	BPL.b CODE_03B658
	BMI.b CODE_03B63B						; Note: This will always branch

CODE_03B638:
	LSR
	BCC.b CODE_03B658
CODE_03B63B:
	LDA.w $0705
	CLC
	ADC.w $0702
	STA.w $0705
	LDA.b !RAM_SMB1_Player_XSpeed
	ADC.w $0701
	STA.b !RAM_SMB1_Player_XSpeed
	CMP.w $0463
	BMI.b CODE_03B673
	LDA.w $0463
	STA.b !RAM_SMB1_Player_XSpeed
	BRA.b CODE_03B67C

CODE_03B658:
	LDA.w $0705
	SEC
	SBC.w $0702
	STA.w $0705
	LDA.b !RAM_SMB1_Player_XSpeed
	SBC.w $0701
	STA.b !RAM_SMB1_Player_XSpeed
	CMP.w $045D
	BPL.b CODE_03B673
	LDA.w $045D
	STA.b !RAM_SMB1_Player_XSpeed
CODE_03B673:
	CMP.b #$00
	BPL.b CODE_03B67C
	EOR.b #$FF
	CLC							;\ Optimization: INC?
	ADC.b #$01						;/
CODE_03B67C:
	STA.w $0700
	RTS

;--------------------------------------------------------------------

CODE_03B680:
	LDA.w !RAM_SMB1_Player_CurrentPowerUp
	CMP.b #$02
	BCC.b CODE_03B6CB
	LDA.b !RAM_SMB1_Global_ControllerABXYHeld
	AND.b #!Joypad_X|(!Joypad_Y>>8)
	BEQ.b CODE_03B6C1
	AND.b !RAM_SMB1_Global_CopyOfControllerABXYHeld
	BNE.b CODE_03B6C1
	LDA.w $06CE
	AND.b #$01
	TAX
	LDA.b $33,x
	BNE.b CODE_03B6C1
	LDY.b !RAM_SMB1_Player_YPosHi
	DEY
	BNE.b CODE_03B6C1
	LDA.w !RAM_SMB1_Level_Player_IsDuckingFlag
	BNE.b CODE_03B6C1
	LDA.b !RAM_SMB1_Level_Player_CurrentPhysicsType
	CMP.b #$03
	BEQ.b CODE_03B6C1
	LDA.b #!Define_SMAS_Sound0063_ShootFireball
	STA.w !RAM_SMB1_Global_SoundCh3
	LDA.b #$02
	STA.b $33,x
	LDY.w $070C
	STY.w $0711
	DEY
	STY.w $0789
	INC.w $06CE
CODE_03B6C1:
	LDX.b #$00
	JSR.w SMB1_ProcessPlayerFireballs_Main
	LDX.b #$01
	JSR.w SMB1_ProcessPlayerFireballs_Main
CODE_03B6CB:
	LDA.b !RAM_SMB1_Level_CurrentLevelType
	BNE.b CODE_03B6E3
	LDX.b #$02
CODE_03B6D1:								; Note: Loop that processes player breath sprites.
	STX.b $9E
	JSR.w CODE_03B780
	JSR.w CODE_03FD1A
	JSR.w CODE_03FDAD
	JSL.l SMB1_DrawPlayerBreathBubbleSprite_Main
	DEX
	BPL.b CODE_03B6D1
CODE_03B6E3:
	RTS

;--------------------------------------------------------------------

DATA_03B6E4:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	db $4C,$B4
else
	db $40,$C0
endif

SMB1_ProcessPlayerFireballs:
.Main:
;$03B6E6
	STX.b $9E
	LDA.b $33,x
	ASL
	BCC.b CODE_03B6F0
	JMP.w CODE_03B77A

CODE_03B6F0:
	LDY.b $33,x
	BNE.b CODE_03B6F7
	JMP.w CODE_03B779

CODE_03B6F7:
	DEY
	BEQ.b CODE_03B726
	LDA.w !RAM_SMB1_Player_XPosLo
	ADC.b #$04
	STA.w !RAM_SMB1_FireSpr_XPosLo,x
	LDA.b !RAM_SMB1_Player_XPosHi
	ADC.b #$00
	STA.b !RAM_SMB1_FireSpr_XPosHi,x
	LDA.w !RAM_SMB1_Player_YPosLo
	STA.w !RAM_SMB1_FireSpr_YPosLo,x
	LDA.b #$01
	STA.b !RAM_SMB1_FireSpr_YPosHi,x
	LDY.w !RAM_SMB1_Level_Player_FacingDirection
	DEY
	LDA.w DATA_03B6E4,y
	STA.b !RAM_SMB1_FireSpr_XSpeed,x
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDA.b #$05
else
	LDA.b #$04
endif
	STA.b !RAM_SMB1_FireSpr_YSpeed,x
	LDA.b #$07
	STA.w !RAM_SMB1_FireSpr_HitboxSizeIndex,x
	DEC.b $33,x
CODE_03B726:
	TXA
	CLC
	ADC.b #$0B
	TAX
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDA.b #$60
else
	LDA.b #$50
endif
	STA.b $00
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDA.b #$05
else
	LDA.b #$03
endif
	STA.b $02
	LDA.b #$00
	JSR.w CODE_03C193
	JSR.w CODE_03C0C2
	LDX.b $9E
	JSR.w CODE_03FD23
	JSR.w CODE_03FDA3
	JSR.w CODE_03E9B6
	JSR.w CODE_03E946
	LDA.w $03D2
	AND.b #$FC
	BEQ.b CODE_03B76F
	AND.b #$F0
	BNE.b CODE_03B775
	LDA.w !RAM_SMB1_FireSpr_XSpeed,x
	BMI.b CODE_03B764
	LDA.w $03D2
	AND.b #$0F
	CMP.b #$0F
	BEQ.b CODE_03B775
	BRA.b CODE_03B772

CODE_03B764:
	LDA.w $03D2
	AND.b #$0C
	CMP.b #$0C
	BEQ.b CODE_03B775
	BRA.b CODE_03B772

CODE_03B76F:
	JSR.w CODE_03DC70
CODE_03B772:
	JMP.w SMB1_DrawBouncingPlayerFireball_Main

CODE_03B775:
	LDA.b #$00
	STA.b $33,x
CODE_03B779:
	RTS

CODE_03B77A:
	JSR.w CODE_03FD23
	JMP.w SMB1_DrawExplodingPlayerFireball_Main

;--------------------------------------------------------------------

; Note: Routine that moves the player breath bubbles.

CODE_03B780:
	LDA.w !RAM_SMB1_Global_RandomByte2,x
	AND.b #$01
	STA.b $07
	LDA.w !RAM_SMB1_BreathSpr_YPosLo,x
	CMP.b #$F8
	BNE.b CODE_03B7BF
	LDA.w $079E
	BNE.b CODE_03B7D9
CODE_03B793:
	LDY.b #$00
	LDA.w !RAM_SMB1_Level_Player_FacingDirection
	LSR
	BCC.b CODE_03B79D
	LDY.b #$08
CODE_03B79D:
	TYA
	ADC.w !RAM_SMB1_Player_XPosLo
	STA.w !RAM_SMB1_BreathSpr_XPosLo,x
	LDA.b !RAM_SMB1_Player_XPosHi
	ADC.b #$00
	STA.b !RAM_SMB1_BreathSpr_XPosHi,x
	LDA.w !RAM_SMB1_Player_YPosLo
	CLC
	ADC.b #$08
	STA.w !RAM_SMB1_BreathSpr_YPosLo,x
	LDA.b #$01
	STA.b !RAM_SMB1_BreathSpr_YPosHi,x
	LDY.b $07
	LDA.w DATA_03B7DC,y
	STA.w $079E
CODE_03B7BF:
	LDY.b $07
	LDA.w $0436,x
	SEC
	SBC.w DATA_03B7DA,y
	STA.w $0436,x
	LDA.w !RAM_SMB1_BreathSpr_YPosLo,x
	SBC.b #$00
	CMP.b #$20
	BCS.b CODE_03B7D6
	LDA.b #$F8
CODE_03B7D6:
	STA.w !RAM_SMB1_BreathSpr_YPosLo,x
CODE_03B7D9:
	RTS

DATA_03B7DA:
	db $FF,$50

DATA_03B7DC:
	db $40,$20

;--------------------------------------------------------------------

CODE_03B7DE:
	LDA.w !RAM_SMB1_Global_GameMode
	BEQ.b CODE_03B838
	LDA.b !RAM_SMB1_Player_CurrentState
	CMP.b #$08
	BCC.b CODE_03B838
	CMP.b #$0B
	BEQ.b CODE_03B838
	LDA.b !RAM_SMB1_Player_YPosHi
	CMP.b #$02
	BPL.b CODE_03B838
	LDA.w !RAM_SMB1_Level_WaitBeforeDecrementingTimer
	BNE.b CODE_03B838
	LDA.w !RAM_SMB1_Level_TimerHundreds
	ORA.w !RAM_SMB1_Level_TimerTens
	ORA.w !RAM_SMB1_Level_TimerOnes
	BEQ.b CODE_03B82F
	LDY.w !RAM_SMB1_Level_TimerHundreds
	DEY
	BNE.b CODE_03B816
	LDA.w !RAM_SMB1_Level_TimerTens
	ORA.w !RAM_SMB1_Level_TimerOnes
	BNE.b CODE_03B816
	LDA.b #!Define_SMAS_Sound0060_IncreaseMusicTempo
	STA.w !RAM_SMB1_Global_SoundCh1
CODE_03B816:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDA.b #$14
else
	LDA.b #$18
endif
	STA.w !RAM_SMB1_Level_WaitBeforeDecrementingTimer
	LDY.b #$23
	LDA.b #$FF
	STA.w $014A
	LDA.w !RAM_SMB1_Level_FreeMovementDebugFlag
	BNE.b CODE_03B82A
	JSR.w CODE_039D06
CODE_03B82A:
	LDA.b #$A4
	JMP.w CODE_039C8F

CODE_03B82F:
	STA.w !RAM_SMB1_Player_CurrentPowerUp
	JSR.w CODE_03DF52
	INC.w $0759
CODE_03B838:
	RTS

;--------------------------------------------------------------------

SMB1_NorSpr034_WarpZone_MainRt:
.Main:
;$03B839
	LDA.w !RAM_SMB1_Level_DisableScrollingFlag
	BEQ.b CODE_03B838
	LDA.w !RAM_SMB1_Player_YPosLo
	AND.b !RAM_SMB1_Player_YPosHi
	BNE.b CODE_03B838
	STA.w !RAM_SMB1_Level_DisableScrollingFlag
	INC.w !RAM_SMB1_Level_WarpZoneActiveFlag
	JMP.w CODE_03CDE2

;--------------------------------------------------------------------

SMB1_ProcessWhirlpools:
.Main:
;$03B84E
	LDA.b !RAM_SMB1_Level_CurrentLevelType
	BNE.b CODE_03B88F
	STA.w !RAM_SMB1_Level_PlayerIsAboveWhirlpoolFlag
	JSL.l SMB1_AdjustUnderwaterHDMAGradient_Main
	LDA.w !RAM_SMB1_Level_FreezeSpritesTimer
	BNE.b CODE_03B88F
	LDY.b #$04
CODE_03B860:
	LDA.w !RAM_SMB1_Level_WhirlpoolXPosLoLeftBoundary,y
	CLC
	ADC.w !RAM_SMB1_Level_WhirlpoolXPosLoRightBoundary,y
	STA.b $02
	LDA.w !RAM_SMB1_Level_WhirlpoolXPosHi,y
	BEQ.b CODE_03B88C
	ADC.b #$00
	STA.b $01
	LDA.w !RAM_SMB1_Player_XPosLo
	SEC
	SBC.w !RAM_SMB1_Level_WhirlpoolXPosLoLeftBoundary,y
	LDA.b !RAM_SMB1_Player_XPosHi
	SBC.w !RAM_SMB1_Level_WhirlpoolXPosHi,y
	BMI.b CODE_03B88C
	LDA.b $02
	SEC
	SBC.w !RAM_SMB1_Player_XPosLo
	LDA.b $01
	SBC.b !RAM_SMB1_Player_XPosHi
	BPL.b CODE_03B890
CODE_03B88C:
	DEY
	BPL.b CODE_03B860
CODE_03B88F:
	RTS

CODE_03B890:
	LDA.w !RAM_SMB1_Level_WhirlpoolXPosLoRightBoundary,y
	LSR
	STA.b $00
	LDA.w !RAM_SMB1_Level_WhirlpoolXPosLoLeftBoundary,y
	CLC
	ADC.b $00
	STA.b $01
	LDA.w !RAM_SMB1_Level_WhirlpoolXPosHi,y
	ADC.b #$00
	STA.b $00
	LDA.b !RAM_SMB1_Global_FrameCounter
	LSR
	BCC.b CODE_03B8DB
	LDA.b $01
	SEC
	SBC.w !RAM_SMB1_Player_XPosLo
	LDA.b $00
	SBC.b !RAM_SMB1_Player_XPosHi
	BPL.b CODE_03B8C6
	LDA.w !RAM_SMB1_Player_XPosLo
	SEC
	SBC.b #$01
	STA.w !RAM_SMB1_Player_XPosLo
	LDA.b !RAM_SMB1_Player_XPosHi
	SBC.b #$00
	JMP.w CODE_03B8D9

CODE_03B8C6:
	LDA.w $0480
	LSR
	BCC.b CODE_03B8DB
	LDA.w !RAM_SMB1_Player_XPosLo
	CLC
	ADC.b #$01
	STA.w !RAM_SMB1_Player_XPosLo
	LDA.b !RAM_SMB1_Player_XPosHi
	ADC.b #$00
CODE_03B8D9:
	STA.b !RAM_SMB1_Player_XPosHi
CODE_03B8DB:
	LDA.b #$10
	STA.b $00
	LDA.b #$01
	STA.w !RAM_SMB1_Level_PlayerIsAboveWhirlpoolFlag
	STA.b $02
	LSR
	TAX
	JMP.w CODE_03C193

;--------------------------------------------------------------------

DATA_03B8EB:
	db $05,$02,$08,$04,$01

DATA_03B8F0:
	db $03,$03,$04,$04,$04

CODE_03B8F5:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDX.b #$09
else
	LDX.b #$05
endif
	STX.b $9E
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr030_Flagpole
	BEQ.b CODE_03B902
	JMP.w CODE_03B98C

CODE_03B902:
	LDA.b !RAM_SMB1_Player_CurrentState
	CMP.b #$04
	BNE.b CODE_03B93D
	LDA.b !RAM_SMB1_Level_Player_CurrentPhysicsType
	CMP.b #$03
	BNE.b CODE_03B93D
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	CMP.b #$AA
	BCS.b CODE_03B93F
	LDA.w !RAM_SMB1_Player_YPosLo
	CMP.b #$A2
	BCS.b CODE_03B93F
	LDA.w !RAM_SMB1_NorSpr_SubYPos,x
	ADC.b #$FF
	STA.w !RAM_SMB1_NorSpr_SubYPos,x
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	ADC.b #$01
	STA.w !RAM_SMB1_NorSpr_YPosLo,x
	LDA.w !RAM_SMB1_Level_GoalFlagScoreSubYPos
	SEC
	SBC.b #$FF
	STA.w !RAM_SMB1_Level_GoalFlagScoreSubYPos
	LDA.w !RAM_SMB1_Level_GoalFlagScoreYPosLo
	SBC.b #$01
	STA.w !RAM_SMB1_Level_GoalFlagScoreYPosLo
CODE_03B93D:
	BRA.b CODE_03B982

CODE_03B93F:
	LDY.w !RAM_SMB1_Level_GoalFlagScoreAmountIndex
	LDA.w DATA_03B8EB,y
	LDX.w DATA_03B8F0,y
	STA.w !RAM_SMB1_Level_ScoreSpr_AddToScoreBuffer,x
	JSR.w CODE_03BD5D
	LDA.b #$05
	STA.b !RAM_SMB1_Player_CurrentState
	LDA.b #!Define_SMB1_LevelMusic_PassedLevel
	STA.w !RAM_SMB1_Global_MusicCh1
	LDA.w !RAM_SMB1_Level_Player_FacingDirection
	AND.b #$02
	BNE.b CODE_03B962
	LDA.b #$6E
	BRA.b CODE_03B964

CODE_03B962:
	LDA.b #$60
CODE_03B964:
	STA.w $02FD
	LDA.w !RAM_SMB1_Player_XPosLo
	STA.w $03CC
	LDA.b !RAM_SMB1_Player_XPosHi
	STA.w $03CD
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDA.b #$18
else
	LDA.b #$20
endif
	STA.w $03FB
	STA.w $03FA
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) == $00
	LDA.b #$20
	STA.w $03FB
	STA.w $03FA
endif
CODE_03B982:
	JSR.w CODE_03FDCB
	JSR.w CODE_03FD39
	JSL.l SMB1_DrawFlagSpriteTile_Main
CODE_03B98C:
	RTS

;--------------------------------------------------------------------

DATA_03B98D:
	db $08,$10,$08,$00

SMB1_NorSpr032_RedSpringboard_MainRt:
.Main:
;$03B991
	JSR.w CODE_03FDCB
	LDA.w !RAM_SMB1_Level_FreezeSpritesTimer
	BNE.b CODE_03B9E1
	LDA.w $070E
	BEQ.b CODE_03B9E1
	TAY
	DEY
	TYA
	AND.b #$02
	BNE.b CODE_03B9AE
	INC.w !RAM_SMB1_Player_YPosLo
	INC.w !RAM_SMB1_Player_YPosLo
	JMP.w CODE_03B9B4

CODE_03B9AE:
	DEC.w !RAM_SMB1_Player_YPosLo
	DEC.w !RAM_SMB1_Player_YPosLo
CODE_03B9B4:
	LDA.b !RAM_SMB1_NorSpr_XSpeed,x
	CLC
	ADC.w DATA_03B98D,y
	STA.w !RAM_SMB1_NorSpr_YPosLo,x
	CPY.b #$01
	BCC.b CODE_03B9D0
	LDA.b !RAM_SMB1_Global_ControllerABXYHeld
	AND.b #!Joypad_A|(!Joypad_B>>8)
	BEQ.b CODE_03B9D0
	AND.b !RAM_SMB1_Global_CopyOfControllerABXYHeld
	BNE.b CODE_03B9D0
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDA.b #$F2
else
	LDA.b #$F4
endif
	STA.w $06DB
CODE_03B9D0:
	CPY.b #$03
	BNE.b CODE_03B9E1
	LDA.w $06DB
	STA.b !RAM_SMB1_Player_YSpeed
	STZ.w $070E
	LDA.b #!Define_SMAS_Sound0063_Springboard
	STA.w !RAM_SMB1_Global_SoundCh3
CODE_03B9E1:
	JSR.w CODE_03FD39
	JSR.w SMB1_GenericSpriteGraphicsRt_Main
	JSR.w CODE_03DC03
	LDA.w $070E
	BEQ.b CODE_03B9FC
	LDA.w $078E
	BNE.b CODE_03B9FC
	LDA.b #$04
	STA.w $078E
	INC.w $070E
CODE_03B9FC:
	RTS

;--------------------------------------------------------------------

SMB1_NorSpr02F_Vine_InitializationRt:
.Main:
;$03B9FD
	LDA.b #!Define_SMB1_SpriteID_NorSpr02F_Vine
	STA.b !RAM_SMB1_NorSpr_SpriteID,x
	LDA.b #$01
	STA.b !RAM_SMB1_NorSpr_SpriteSlotExistsFlag,x
	LDA.w !RAM_SMB1_BounceSpr_XPosHi,y
	STA.b !RAM_SMB1_NorSpr_XPosHi,x
	LDA.w !RAM_SMB1_BounceSpr_XPosLo,y
	STA.w !RAM_SMB1_NorSpr_XPosLo,x
	LDA.w !RAM_SMB1_BounceSpr_YPosLo,y
	BNE.b CODE_03BA17
	LDA.b #$F0
CODE_03BA17:
	STA.w !RAM_SMB1_NorSpr_YPosLo,x
	LDY.w $0398
	BNE.b CODE_03BA22
	STA.w $039D
CODE_03BA22:
	TXA
	STA.w $039A,y
	INC.w $0398
	LDA.b #!Define_SMAS_Sound0063_HitVineBlock
	STA.w !RAM_SMB1_Global_SoundCh3
	RTS

;--------------------------------------------------------------------

DATA_03BA2F:
	db $60

DATA_03BA30:
	db $90

SMB1_NorSpr02F_Vine_MainRt:
.Main:
;$03BA31
	CPX.b #$09
	BEQ.b CODE_03BA36
	RTS

CODE_03BA36:
	LDA.w !RAM_SMB1_Level_GrowVineAtLevelEntranceFlag
	BNE.b CODE_03BA40
	LDA.w DATA_03BA30
	BRA.b CODE_03BA43

CODE_03BA40:
	LDA.w DATA_03BA2F
CODE_03BA43:
	CMP.w $0399
	BEQ.b CODE_03BA58
	LDA.b !RAM_SMB1_Global_FrameCounter
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	AND.b #$03
	BEQ.b CODE_03BA58
	DEC.w !RAM_SMB1_NorSpr_YPosLo+$09
else
	LSR
	BCC.b CODE_03BA58
	LDA.w !RAM_SMB1_NorSpr_YPosLo+$09
	SBC.b #$01
	STA.w !RAM_SMB1_NorSpr_YPosLo+$09
endif
	INC.w $0399
CODE_03BA58:
	LDA.w $0399
	CMP.b #$08
	BCC.b CODE_03BAA5
	JSR.w CODE_03FD39
	JSR.w CODE_03FDCB
	LDY.b #$00
	JSL.l CODE_05DA72
	LDA.w $03D1
	AND.b #$0F
	CMP.b #$0F
	BNE.b CODE_03BA7F
	LDX.b #$09
	JSR.w CODE_03CDE2
	STA.w $0398
	STA.w $0399
CODE_03BA7F:
	LDA.w $0399
	CMP.b #$20
	BCC.b CODE_03BAA5
	LDX.b #$0A
	LDA.b #$01
	LDY.b #$1B
	JSR.w CODE_03EB83
	LDY.b $02
	CPY.b #$D0
	BCS.b CODE_03BAA5
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_J1) == $00
	LDA.w !RAM_SMB1_Level_GrowVineAtLevelEntranceFlag
	BNE.b CODE_03BA9D
	TYA
	BMI.b CODE_03BAA5
endif
CODE_03BA9D:
	LDA.b ($06),y
	BNE.b CODE_03BAA5
	LDA.b #$2A
	STA.b ($06),y
CODE_03BAA5:
	LDX.b $9E
	RTS

;--------------------------------------------------------------------

DATA_03BAA8:
	db $0F,$07

SMB1_ProcessBulletShooters:
.Main:
;$03BAAA
	LDA.b !RAM_SMB1_Level_CurrentLevelType
	BEQ.b CODE_03BB1D
	LDX.b #$02
CODE_03BAB0:
	STX.b $9E
	LDA.b !RAM_SMB1_NorSpr_SpriteSlotExistsFlag,x
	BNE.b CODE_03BB07
	LDA.w !RAM_SMB1_Global_RandomByte2,x
	LDY.w !RAM_SMB1_Global_UseLateStageSpriteBehaviorFlag
	AND.w DATA_03BAA8,y
	CMP.b #$06
	BCS.b CODE_03BB07
	TAY
	LDA.w !RAM_SMB1_Level_BulletShooterXPosHi,y
	BEQ.b CODE_03BB07
	LDA.w !RAM_SMB1_Level_BulletShooterTimer,y
	BEQ.b CODE_03BAD5
	SBC.b #$00							; Optimization: DEC?
	STA.w !RAM_SMB1_Level_BulletShooterTimer,y
	BRA.b CODE_03BB07

CODE_03BAD5:
	LDA.w !RAM_SMB1_Level_FreezeSpritesTimer
	BNE.b CODE_03BB07
	LDA.b #$0E
	STA.w !RAM_SMB1_Level_BulletShooterTimer,y
	LDA.w !RAM_SMB1_Level_BulletShooterXPosHi,y
	STA.b !RAM_SMB1_NorSpr_XPosHi,x
	LDA.w !RAM_SMB1_Level_BulletShooterXPosLo,y
	STA.w !RAM_SMB1_NorSpr_XPosLo,x
	LDA.w !RAM_SMB1_Level_BulletShooterYPosLo,y
	SEC
	SBC.b #$08
	STA.w !RAM_SMB1_NorSpr_YPosLo,x
	LDA.b #$01
	STA.b !RAM_SMB1_NorSpr_YPosHi,x
	STA.b !RAM_SMB1_NorSpr_SpriteSlotExistsFlag,x
	LSR
	STA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	LDA.b #$09
	STA.w !RAM_SMB1_NorSpr_HitboxSizeIndex,x
	LDA.b #!Define_SMB1_SpriteID_NorSpr033_BulletBillLauncher
	STA.b !RAM_SMB1_NorSpr_SpriteID,x
	BRA.b CODE_03BB1A

CODE_03BB07:
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr033_BulletBillLauncher
	BNE.b CODE_03BB1A
	JSR.w CODE_03DC03
	LDA.b !RAM_SMB1_NorSpr_SpriteSlotExistsFlag,x
	BEQ.b CODE_03BB1A
	JSR.w CODE_03FDCB
	JSR.w CODE_03BB20
CODE_03BB1A:
	DEX
	BPL.b CODE_03BAB0
CODE_03BB1D:
	RTS

;--------------------------------------------------------------------

DATA_03BB1E:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	db $1C,$E4
else
	db $18,$E8
endif

CODE_03BB20:
	LDA.w !RAM_SMB1_Level_FreezeSpritesTimer
	BNE.b CODE_03BB78
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	BNE.b CODE_03BB5B
	LDA.w $03D1
	AND.b #$0C
	CMP.b #$0C
	BEQ.b CODE_03BB87
	LDY.b #$01
	JSR.w SMB1_CheckPlayerPositionRelativeToSprite_X
	BMI.b CODE_03BB3A
	INY
CODE_03BB3A:
	STY.b $47,x
	DEY
	LDA.w DATA_03BB1E,y
	STA.b !RAM_SMB1_NorSpr_XSpeed,x
	LDA.b $00
	ADC.b #$28
	CMP.b #$50
	BCC.b CODE_03BB87
	LDA.b #$01
	STA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDA.b #$09
else
	LDA.b #$0A
endif
	STA.w $0792,x
	LDA.b #!Define_SMAS_Sound0063_CannonShoot
	STA.w !RAM_SMB1_Global_SoundCh3
	JSR.w CODE_03C283
CODE_03BB5B:
	LDA.w $03D1
	AND.b #$F0
	CMP.b #$F0
	BEQ.b CODE_03BB87
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	AND.b #$20
	BEQ.b CODE_03BB6D
	JSR.w CODE_03C11B
CODE_03BB6D:
	LDA.w $0E67
	BNE.b CODE_03BB78
	JSR.w CODE_03C0B5
	JSR.w CODE_03C202
CODE_03BB78:
	JSR.w CODE_03FDCB
	JSR.w CODE_03FD39
	JSR.w CODE_03E9CC
	JSR.w CODE_03DE55
	JMP.w SMB1_GenericSpriteGraphicsRt_Main

CODE_03BB87:
	JSR.w CODE_03CDE2
	RTS

;--------------------------------------------------------------------

DATA_03BB8B:
	db $04,$04,$04,$05,$05,$05,$06,$06
	db $06

DATA_03BB94:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	db $14,$EC
else
	db $10,$F0
endif

SMB1_SpawnThrownHammerRt:
.Main:
;$03BB96
	LDA.w !RAM_SMB1_Global_RandomByte2
	AND.b #$07
	BNE.b CODE_03BBA2
	LDA.w !RAM_SMB1_Global_RandomByte2
	AND.b #$08
CODE_03BBA2:
	TAY
	LDA.w $0039,y
	BNE.b CODE_03BBC1
	LDX.w DATA_03BB8B,y
	LDA.b !RAM_SMB1_NorSpr_SpriteSlotExistsFlag,x
	BNE.b CODE_03BBC1
	LDX.b $9E
	TXA
	STA.w $06AE,y
	LDA.b #$90
	STA.w $0039,y
	LDA.b #$07
	STA.w !RAM_SMB1_HammerSpr_HitboxSizeIndex,y
	SEC
	RTS

CODE_03BBC1:
	LDX.b $9E
	CLC
	RTS

;--------------------------------------------------------------------

; Note: Routine that processes hammers?

CODE_03BBC5:
	LDA.w !RAM_SMB1_Level_FreezeSpritesTimer
	BEQ.b CODE_03BBCD
	JMP.w CODE_03BC53

CODE_03BBCD:
	LDA.b $39,x
	AND.b #$7F
	LDY.w $06AE,x
	CMP.b #$02
	BEQ.b CODE_03BBF8
	BCS.b CODE_03BC0E
	TXA
	CLC
	ADC.b #$11
	TAX
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDA.b #$23
else
	LDA.b #$10
endif
	STA.b $00
	LDA.b #$0F
	STA.b $01
	LDA.b #$04
	STA.b $02
	LDA.b #$00
	JSR.w CODE_03C193
	JSR.w CODE_03C0C2
	LDX.b $9E
	JMP.w CODE_03BC50

CODE_03BBF8:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDA.b #$FD
else
	LDA.b #$FE
endif
	STA.b !RAM_SMB1_HammerSpr_YSpeed,x
	LDA.w !RAM_SMB1_NorSpr_SpriteStatusFlags,y
	AND.b #$F7
	STA.w !RAM_SMB1_NorSpr_SpriteStatusFlags,y
	LDX.b $47,y
	DEX
	LDA.w DATA_03BB94,x
	LDX.b $9E
	STA.b !RAM_SMB1_HammerSpr_XSpeed,x
CODE_03BC0E:
	DEC.b $39,x
	LDA.b $39,x
	CMP.b #$81
	BNE.b CODE_03BC1B
	LDA.b #!Define_SMAS_Sound0060_EnemyProjectileThrow
	STA.w !RAM_SMB1_Global_SoundCh1
CODE_03BC1B:
	LDA.w !RAM_SMB1_NorSpr_SpriteID,y
	CMP.b #!Define_SMB1_SpriteID_NorSpr02D_Bowser
	BNE.b CODE_03BC26
	LDA.b #$08
	BRA.b CODE_03BC33

CODE_03BC26:
	LDA.w $0047,y
	CMP.b #$02
	BNE.b CODE_03BC31
	LDA.b #$06
	BRA.b CODE_03BC33

CODE_03BC31:
	LDA.b #$02
CODE_03BC33:
	CLC
	ADC.w !RAM_SMB1_NorSpr_XPosLo,y
	STA.w !RAM_SMB1_HammerSpr_XPosLo,x
	LDA.w !RAM_SMB1_NorSpr_XPosHi,y
	ADC.b #$00
	STA.b !RAM_SMB1_HammerSpr_XPosHi,x
	LDA.w !RAM_SMB1_NorSpr_YPosLo,y
	SEC
	SBC.b #$0A
	STA.w !RAM_SMB1_HammerSpr_YPosLo,x
	LDA.b #$01
	STA.b !RAM_SMB1_HammerSpr_YPosHi,x
	BNE.b CODE_03BC53
CODE_03BC50:
	JSR.w CODE_03DDBE
CODE_03BC53:
	JSR.w CODE_03FDB7
	JSR.w CODE_03FD30
	JSR.w CODE_03E9BF
	JSL.l SMB1_DrawHammerSprite_Main
	RTS

;--------------------------------------------------------------------

CODE_03BC61:
	JSR.w CODE_03BCAF
	LDA.b !RAM_SMB1_BounceSpr_XPosHi,x
	STA.w !RAM_SMB1_CoinSpr_XPosHi,y
	LDA.w !RAM_SMB1_BounceSpr_XPosLo,x
	ORA.b #$05
	STA.w !RAM_SMB1_CoinSpr_XPosLo,y
	LDA.w !RAM_SMB1_BounceSpr_YPosLo,x
	SBC.b #$10
	STA.w !RAM_SMB1_CoinSpr_YPosLo,y
	BRA.b CODE_03BC96

CODE_03BC7B:
	JSR.w CODE_03BCAF
	LDA.w !RAM_SMB1_CoinSpr_BlockPosXHi,x
	STA.w !RAM_SMB1_CoinSpr_XPosHi,y
	LDA.b $06
	ASL
	ASL
	ASL
	ASL
	ORA.b #$05
	STA.w !RAM_SMB1_CoinSpr_XPosLo,y
	LDA.b $02
	ADC.b #$20
	STA.w !RAM_SMB1_CoinSpr_YPosLo,y
CODE_03BC96:
	LDA.b #$FB
	STA.w !RAM_SMB1_CoinSpr_YSpeed,y
	LDA.b #$01
	STA.w !RAM_SMB1_CoinSpr_YPosHi,y
	STA.w $0039,y
	STA.w !RAM_SMB1_Global_SoundCh3			; Note: !Define_SMAS_Sound0063_Coin
	STX.b $9E
	JSR.w CODE_03BD34
	INC.w $0748
	RTS

CODE_03BCAF:
	LDY.b #$08
CODE_03BCB1:
	LDA.w $0039,y
	BEQ.b CODE_03BCBD
	DEY
	CPY.b #$05
	BNE.b CODE_03BCB1
	LDY.b #$08
CODE_03BCBD:
	STY.w $06B7
	RTS

;--------------------------------------------------------------------

; Note: Routine that processes hammer sprites?

CODE_03BCC1:
	LDX.b #$08
CODE_03BCC3:
	STX.b $9E
	LDA.b $39,x
	BEQ.b CODE_03BD2A
	ASL
	BCC.b CODE_03BCD2
	JSR.w CODE_03BBC5
	JMP.w CODE_03BD2A

CODE_03BCD2:
	LDY.b $39,x
	DEY
	BEQ.b CODE_03BCF6
	INC.b $39,x
	LDA.w !RAM_SMB1_HammerSpr_XPosLo,x
	CLC
	ADC.w $0775
	STA.w !RAM_SMB1_HammerSpr_XPosLo,x
	LDA.b !RAM_SMB1_HammerSpr_XPosHi,x
	ADC.b #$00
	STA.b !RAM_SMB1_HammerSpr_XPosHi,x
	LDA.b $39,x
	CMP.b #$30
	BNE.b CODE_03BD15
	LDA.b #$00
	STA.b $39,x
	JMP.w CODE_03BD2A

CODE_03BCF6:
	TXA
	CLC
	ADC.b #$11
	TAX
	LDA.b #$50
	STA.b $00
	LDA.b #$06
	STA.b $02
	LSR
	STA.b $01
	LDA.b #$00
	JSR.w CODE_03C193
	LDX.b $9E
	LDA.b !RAM_SMB1_HammerSpr_YSpeed,x
	CMP.b #$05
	BNE.b CODE_03BD15
	INC.b $39,x
CODE_03BD15:
	LDA.b !RAM_SMB1_HammerSpr_YSpeed,x
	BNE.b CODE_03BD1D
	JSL.l CODE_05DCC9
CODE_03BD1D:
	JSR.w CODE_03FD30
	JSR.w CODE_03FDB7
	JSR.w CODE_03E9BF
	JSL.l SMB1_DrawSpinningCoinSprite_Main
CODE_03BD2A:
	DEX
	BPL.b CODE_03BCC3
	RTS

;--------------------------------------------------------------------

; Note: Routine that gives the player a coin?

DATA_03BD2E:
	db $17,$1D

DATA_03BD30:
	db $0B,$11

DATA_03BD32:
	db $02,$13

CODE_03BD34:
	LDA.b #$01
	STA.w $014A
	LDX.w !RAM_SMB1_Player_CurrentCharacter
	LDY.w DATA_03BD2E,x
	JSR.w CODE_039D06
	INC.w !RAM_SMB1_Player_CurrentCoinCount
	LDA.w !RAM_SMB1_Player_CurrentCoinCount
	CMP.b #$64
	BNE.b CODE_03BD58
	STZ.w !RAM_SMB1_Player_CurrentCoinCount
	JSL.l CODE_048596
	LDA.b #!Define_SMAS_Sound0063_1up
	STA.w !RAM_SMB1_Global_SoundCh3
CODE_03BD58:
	LDA.b #$02
	STA.w $0149
CODE_03BD5D:
	LDX.w !RAM_SMB1_Player_CurrentCharacter
	LDY.w DATA_03BD30,x
	JSR.w CODE_039D06
CODE_03BD66:
	LDY.w $0EC3
	LDA.w DATA_03BD32,y
CODE_03BD6C:
	JSR.w CODE_039C8F
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) == $00
	LDY.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	LDA.w $16F6,y
	BNE.b CODE_03BD85
	LDA.b #$28
	LDX.w $16F2,y
	CPX.b #$02
	BNE.b CODE_03BD82
	LDA.b #$24
CODE_03BD82:
	STA.w $16F6,y
CODE_03BD85:
endif
	LDX.b $9E
	RTS

;--------------------------------------------------------------------

; Note: Routine that has something to do with the power ups.

CODE_03BD88:
	LDA.b #!Define_SMB1_SpriteID_NorSpr02E_Powerup
	STA.b !RAM_SMB1_NorSpr_SpriteID+$09
	LDA.b !RAM_SMB1_BounceSpr_XPosHi,x
	STA.b !RAM_SMB1_NorSpr_XPosHi+$09
	LDA.w !RAM_SMB1_BounceSpr_XPosLo,x
	STA.w !RAM_SMB1_NorSpr_XPosLo+$09
	LDA.b #$01
	STA.b !RAM_SMB1_NorSpr_YPosHi+$09
	LDA.w !RAM_SMB1_BounceSpr_YPosLo,x
	SEC
	SBC.b #$08
	STA.w !RAM_SMB1_NorSpr_YPosLo+$09
SMB1_NorSpr02E_Powerup_InitializationRt:
.Main:
	LDA.b #$01
	STA.b $32
	STA.b $19
	LDA.b #$03
	STA.w !RAM_SMB1_NorSpr_HitboxSizeIndex+$09
	LDA.w !RAM_SMB1_NorSpr02E_Powerup_PowerupType
	CMP.b #$02
	BCS.b CODE_03BDC0
	LDA.w !RAM_SMB1_Player_CurrentPowerUp
	CMP.b #$02
	BCC.b CODE_03BDBD
	LSR
CODE_03BDBD:
	STA.w !RAM_SMB1_NorSpr02E_Powerup_PowerupType
CODE_03BDC0:
	LDA.b #$30
	STA.w $0260
	LDA.b #!Define_SMAS_Sound0063_HitItemBlock
	STA.w !RAM_SMB1_Global_SoundCh3
	RTS

;--------------------------------------------------------------------

SMB1_NorSpr02E_Powerup_MainRt:
.Main:
;$03BDCB
	LDX.b #$09
	STX.b $9E
	LDA.b $32
	BNE.b CODE_03BDD6
	JMP.w CODE_03BE7A

CODE_03BDD6:
	ASL
	BCC.b CODE_03BDFD
	LDA.w !RAM_SMB1_Level_FreezeSpritesTimer
	BNE.b CODE_03BE26
	LDA.w !RAM_SMB1_NorSpr02E_Powerup_PowerupType
	BEQ.b CODE_03BDF4
	CMP.b #$03
	BEQ.b CODE_03BDF4
	CMP.b #$02
	BNE.b CODE_03BE26
	JSR.w SMB1_NorSpr00E_GreenBouncingParakoopa_MainRt_Main
	JSR.w CODE_03E8E1
	JMP.w CODE_03BE26

CODE_03BDF4:
	JSR.w CODE_03CF08
	JSR.w SMB1_HandleNormalSpriteLevelCollision_Main
	JMP.w CODE_03BE26

CODE_03BDFD:
	LDA.b !RAM_SMB1_Global_FrameCounter
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	AND.b #$07
	BEQ.b +
	CMP.b #$03
	BEQ.b +
	CMP.b #$06
	BEQ.b +
	BRA.b CODE_03BE1D

+:
else
	AND.b #$03
	BNE.b CODE_03BE1D
endif
	DEC.w !RAM_SMB1_NorSpr_YPosLo+$09
	LDA.b $32
	INC.b $32
	CMP.b #$11
	BCC.b CODE_03BE1D
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDA.b #$13
else
	LDA.b #$10
endif
	STA.b !RAM_SMB1_NorSpr_XSpeed,x
	LDA.b #$80
	STA.b $32
	ASL
	STA.w $0260
	ROL
	STA.b $47,x
CODE_03BE1D:
	LDA.b $32
	CMP.b #$06
	BCS.b CODE_03BE26
	JMP.w CODE_03BE7A

CODE_03BE26:
	JMP.w CODE_03BE68

;--------------------------------------------------------------------

CODE_03BE29:
	LDA.b !RAM_SMB1_NorSpr_XPosHi,x
	STA.b !RAM_SMB1_Global_ScratchRAME9
	LDA.w !RAM_SMB1_NorSpr_XPosLo,x
	STA.b !RAM_SMB1_Global_ScratchRAME8
	REP.b #$20
	LDA.b !RAM_SMB1_Global_ScratchRAME8
	CMP.b $42
	BCS.b CODE_03BE4B
	CLC
	ADC.w #$000C
	STA.b !RAM_SMB1_Global_ScratchRAME6
	SEP.b #$20
	LDA.b !RAM_SMB1_Global_ScratchRAME6
	STA.w !RAM_SMB1_NorSpr_XPosLo,x
	LDA.b !RAM_SMB1_Global_ScratchRAME7
	STA.b !RAM_SMB1_NorSpr_XPosHi,x
CODE_03BE4B:
	SEP.b #$20
	JSR.w CODE_03FD39
	JSR.w CODE_03FDCB
	JSR.w CODE_03E9CC
	JSR.w CODE_03ED03
	JSR.w CODE_03DE55
	JSR.w CODE_03DC03
	LDA.b !RAM_SMB1_Global_ScratchRAME8
	STA.w !RAM_SMB1_NorSpr_XPosLo,x
	LDA.b !RAM_SMB1_Global_ScratchRAME9
	STA.b !RAM_SMB1_NorSpr_XPosHi,x
CODE_03BE68:
	JSR.w CODE_03FD39
	JSR.w CODE_03FDCB
	JSR.w CODE_03E9CC
	JSR.w CODE_03ED03
	JSR.w CODE_03DE55
	JSR.w CODE_03DC03
CODE_03BE7A:
	RTS

;--------------------------------------------------------------------

; Note: Mario Below block offset?

DATA_03BE7B:
	db $04,$12

CODE_03BE7D:
	PHA
	LDA.b #$11
	LDX.w !RAM_SMB1_Level_BlockSlotIndex
	LDY.w !RAM_SMB1_Player_CurrentSize
	BNE.b CODE_03BE8A
	LDA.b #$12
CODE_03BE8A:
	STA.b $35,x
	JSR.w CODE_03939B
	LDX.w !RAM_SMB1_Level_BlockSlotIndex
	LDA.b $02
	STA.w !RAM_SMB1_Level_BlockYPosIndex,x
	TAY
	LDA.b $06
	STA.w !RAM_SMB1_Level_BlockXPosIndex,x
	LDA.b ($06),y
	JSR.w CODE_03BF9D
	STA.b $00
	LDY.w !RAM_SMB1_Player_CurrentSize
	BNE.b CODE_03BEAA
	TYA
CODE_03BEAA:
	BCC.b CODE_03BED1
	LDY.b #$11
	STY.b $35,x
	LDA.b #$FC
	LDY.b $00
	CPY.b #$5B
	BEQ.b CODE_03BEBC
	CPY.b #$60
	BNE.b CODE_03BED1
CODE_03BEBC:
	LDA.w !RAM_SMB1_Level_10CoinBlockHasBeenHitFlag
	BNE.b CODE_03BEC9
	LDA.b #$0B
	STA.w !RAM_SMB1_Player_10CoinBlockGivesCoinsTimer
	INC.w !RAM_SMB1_Level_10CoinBlockHasBeenHitFlag
CODE_03BEC9:
	LDA.w !RAM_SMB1_Player_10CoinBlockGivesCoinsTimer
	BNE.b CODE_03BED0
	LDY.b #$FC
CODE_03BED0:
	TYA
CODE_03BED1:
	STA.w !RAM_SMB1_Level_BlockTile,x
	JSR.w CODE_03BF15
	LDY.b $02
	LDA.b #$27
	STA.b ($06),y
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDA.b #$0C
else
	LDA.b #$10
endif
	STA.w $078C
	PLA
	STA.b $05
	LDY.b #$00
	LDA.w !RAM_SMB1_Level_Player_IsDuckingFlag
	BNE.b CODE_03BEF1
	LDA.w !RAM_SMB1_Player_CurrentSize
	BEQ.b CODE_03BEF2
CODE_03BEF1:
	INY
CODE_03BEF2:
	LDA.w !RAM_SMB1_Player_YPosLo
	CLC
	ADC.w DATA_03BE7B,y
	AND.b #$F0
	STA.w !RAM_SMB1_BounceSpr_YPosLo,x
	LDY.b $35,x
	CPY.b #$11
	BEQ.b CODE_03BF09
	JSR.w CODE_03BFA9 
	BRA.b CODE_03BF0C

;--------------------------------------------------------------------

CODE_03BF09:
	JSR.w CODE_03BF34
CODE_03BF0C:
	LDA.w !RAM_SMB1_Level_BlockSlotIndex
	EOR.b #$01
	STA.w !RAM_SMB1_Level_BlockSlotIndex
	RTS

;--------------------------------------------------------------------

CODE_03BF15:
	LDA.w !RAM_SMB1_Player_XPosLo
	CLC
	ADC.b #$08
	AND.b #$F0
	STA.w !RAM_SMB1_BounceSpr_XPosLo,x
	STA.w $0E16
	LDA.b !RAM_SMB1_Player_XPosHi
	ADC.b #$00
	STA.b !RAM_SMB1_BounceSpr_XPosHi,x
	STA.w !RAM_SMB1_CoinSpr_BlockPosXHi,x
	STA.w $0E17
	LDA.b !RAM_SMB1_Player_YPosHi
	STA.b !RAM_SMB1_BounceSpr_YPosHi,x
	RTS

;--------------------------------------------------------------------

CODE_03BF34:
	JSR.w CODE_03BFCE
	LDA.b #!Define_SMAS_Sound0060_HitHead
	STA.w !RAM_SMB1_Global_SoundCh1
	STZ.b !RAM_SMB1_BounceSpr_XSpeed,x
	STZ.w !RAM_SMB1_BounceSpr_SubYSpeed,x
	STZ.b !RAM_SMB1_Player_YSpeed
	LDA.b #$FE
	STA.b !RAM_SMB1_BounceSpr_YSpeed,x
	LDA.b $05
	JSR.w CODE_03BF9D
	BCC.b CODE_03BF8E
	TYA
	CMP.b #$09
	BCC.b CODE_03BF55
	SBC.b #$05
CODE_03BF55:
	ASL
	TAY
	LDA.w DATA_03BF64,y
	STA.b $04
	LDA.w DATA_03BF64+$01,y
	STA.b $05
	JMP.w ($0004)

DATA_03BF64:
	dw CODE_03BF76
	dw CODE_03BC61
	dw CODE_03BC61
	dw CODE_03BF7E
	dw CODE_03BF76
	dw CODE_03BF86
	dw CODE_03BF7A
	dw CODE_03BC61
	dw CODE_03BF7E

;--------------------------------------------------------------------

CODE_03BF76:
	LDA #$00
	BRA.b CODE_03BF80

CODE_03BF7A:
	LDA.b #$02
	BRA.b CODE_03BF80

CODE_03BF7E:
	LDA.b #$03
CODE_03BF80:
	STA.w !RAM_SMB1_NorSpr02E_Powerup_PowerupType
	JMP.w CODE_03BD88

;--------------------------------------------------------------------

CODE_03BF86:
	LDX.b #$09
	LDY.w !RAM_SMB1_Level_BlockSlotIndex
	JSR.w SMB1_NorSpr02F_Vine_InitializationRt_Main
CODE_03BF8E:
	RTS

;--------------------------------------------------------------------

DATA_03BF8F:
	db $E8,$E7,$62,$63,$58,$59,$5A,$5B
	db $5C,$5D,$5E,$5F,$60,$61

CODE_03BF9D:
	LDY.b #$0D
CODE_03BF9F:
	CMP.w DATA_03BF8F,y
	BEQ.b CODE_03BFA8
	DEY
	BPL.b CODE_03BF9F
	CLC
CODE_03BFA8:
	RTS

;--------------------------------------------------------------------

CODE_03BFA9:
	JSR.w CODE_03BFCE
	LDA.b #$01
	STA.w !RAM_SMB1_Level_RevertBlockStateFlag,x
	LDA.w !RAM_SMB1_Global_SoundCh3
	BNE.b CODE_03BFBB
	LDA.b #!Define_SMAS_Sound0063_BreakBlock
	STA.w !RAM_SMB1_Global_SoundCh3
CODE_03BFBB:
	JSR.w CODE_03BFF5
	LDA.b #$FE					; Glitch: This should be #$01, because this value results in Mario rising when breaking a brick.
	STA.b !RAM_SMB1_Player_YSpeed
	LDA.b #$05
	STA.w $014A
	JSR.w CODE_03BD5D
	LDX.w !RAM_SMB1_Level_BlockSlotIndex
	RTS

CODE_03BFCE:
	LDX.w !RAM_SMB1_Level_BlockSlotIndex
	LDY.b $02
	BEQ.b CODE_03BFF4
	TYA
	SEC
	SBC.b #$10
	STA.b $02
	TAY
	LDA.b ($06),y
	CMP.b #$E9
	BNE.b CODE_03BFF4
	LDA.b #$00
	STA.b ($06),y
	LDA.b #!Define_SMAS_Sound0063_Coin
	STA.w !RAM_SMB1_Global_SoundCh3
	JSR.w CODE_039380
	LDX.w !RAM_SMB1_Level_BlockSlotIndex
	JSR.w CODE_03BC7B
CODE_03BFF4:
	RTS

;--------------------------------------------------------------------

CODE_03BFF5:
	LDA.w !RAM_SMB1_BounceSpr_XPosLo,x
	STA.w $03F3,x
	LDA.b #$F0
	STA.b !RAM_SMB1_BounceSpr_XSpeed,x
	STA.b $6C,x
	LDA.b #$FA
	STA.b !RAM_SMB1_BounceSpr_YSpeed,x
	LDA.b #$FC
	STA.b $AF,x
	STZ.w !RAM_SMB1_BounceSpr_SubYSpeed,x
	STZ.w $044B,x
	LDA.b !RAM_SMB1_BounceSpr_XPosHi,x
	STA.b $87,x
	LDA.w !RAM_SMB1_BounceSpr_XPosLo,x
	STA.w $0228,x
	LDA.w !RAM_SMB1_BounceSpr_YPosLo,x
	CLC
	ADC.b #$08
	STA.w $0246,x
	LDA.b #$FA						;\ Optimization: Redundant code
	STA.b !RAM_SMB1_BounceSpr_YSpeed,x			;/
	RTS

;--------------------------------------------------------------------

; Note: Routine that processes bounce sprites?

CODE_03C027:
	LDA.b $35,x
	BEQ.b CODE_03C08B
	AND.b #$0F
	PHA
	TAY
	TXA
	CLC
	ADC.b #$0D
	TAX
	DEY
	BEQ.b CODE_03C06A
	JSR.w CODE_03C15B
	JSR.w CODE_03C0C2
	INX
	INX
	JSR.w CODE_03C15B
	JSR.w CODE_03C0C2
	LDX.b $9E
	JSR.w CODE_03FD40
	JSR.w CODE_03FDD1
	JSR.w CODE_03F3AC
	PLA
	LDY.b !RAM_SMB1_BounceSpr_YPosHi,x
	BEQ.b CODE_03C08B
	PHA
	LDA.b #$F0
	CMP.w $0246,x
	BCS.b CODE_03C060
	STA.w $0246,x
CODE_03C060:
	LDA.w !RAM_SMB1_BounceSpr_YPosLo,x
	CMP.b #$F0
	PLA
	BCC.b CODE_03C08B
	BCS.b CODE_03C089					; Note: This will always branch.

CODE_03C06A:
	JSR.w CODE_03C15B
	LDX.b $9E
	JSR.w CODE_03FD40
	JSR.w CODE_03FDD1
	JSR.w CODE_03F358
	PLA
	STA.b $35,x
	LDA.w !RAM_SMB1_BounceSpr_YPosLo,x
	AND.b #$0F
	CMP.b #$05
	BCS.b CODE_03C08B
	LDA.b #$01
	STA.w !RAM_SMB1_Level_RevertBlockStateFlag,x
CODE_03C089:
	STZ.b $35,x
CODE_03C08B:
	RTS

;--------------------------------------------------------------------

CODE_03C08C:
	LDX.b #$01
CODE_03C08E:
	STX.b $9E
	LDA.w !RAM_SMB1_Level_RevertBlockStateFlag,x
	BEQ.b CODE_03C0B1
	LDA.w !RAM_SMB1_Level_BlockXPosIndex,x
	STA.b $06
	LDA.b #$05
	STA.b $07
	LDA.w !RAM_SMB1_Level_BlockYPosIndex,x
	STA.b $02
	TAY
	LDA.w !RAM_SMB1_Level_BlockTile,x
	STA.b ($06),y
	JSR.w CODE_039391
	LDA.b #$00
	STA.w !RAM_SMB1_Level_RevertBlockStateFlag,x
CODE_03C0B1:
	DEX
	BPL.b CODE_03C08E
	RTS

;--------------------------------------------------------------------

CODE_03C0B5:
	INX
	JSR.w CODE_03C0C2
	LDX.b $9E
	RTS

;--------------------------------------------------------------------

CODE_03C0BC:
	LDA.w $070E
	BNE.b CODE_03C104
	TAX
CODE_03C0C2:
	LDA.b !RAM_SMB1_Player_XSpeed,x
	ASL
	ASL
	ASL
	ASL
	STA.b $01
	LDA.b !RAM_SMB1_Player_XSpeed,x
	LSR
	LSR
	LSR
	LSR
	CMP.b #$08
	BCC.b CODE_03C0D6
	ORA.b #$F0
CODE_03C0D6:
	STA.b $00
	STA.w $0EB6
	LDY.b #$00
	CMP.b #$00
	BPL.b CODE_03C0E2
	DEY
CODE_03C0E2:
	STY.b $02
	LDA.w $0401,x
	CLC
	ADC.b $01
	STA.w $0401,x
	LDA.b #$00
	ROL
	PHA
	ROR
	LDA.w !RAM_SMB1_Player_XPosLo,x
	ADC.b $00
	STA.w !RAM_SMB1_Player_XPosLo,x
	LDA.b !RAM_SMB1_Player_XPosHi,x
	ADC.b $02
	STA.b !RAM_SMB1_Player_XPosHi,x
	PLA
	CLC
	ADC.b $00
CODE_03C104:
	RTS

;--------------------------------------------------------------------

CODE_03C105:
	LDX.b #$00
	LDA.w !RAM_SMB1_Level_FreezeSpritesTimer
	BNE.b CODE_03C111
	LDA.w $070E
	BNE.b CODE_03C104
CODE_03C111:
	LDA.w $0709
	STA.b $00
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDA.b #$05
else
	LDA.b #$04
endif
	JMP.w CODE_03C164

;--------------------------------------------------------------------

CODE_03C11B:
	LDY.b #$3D
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	CMP.b #$05
	BNE.b CODE_03C14A
CODE_03C123:
	LDY.b #$20
	BRA.b CODE_03C14A

;--------------------------------------------------------------------

CODE_03C127:
	LDY.b #$00
	BRA.b CODE_03C12D

CODE_03C12B:
	LDY.b #$01
CODE_03C12D:
	INX
	LDA.b #$03
	STA.b $00
	LDA.b #$06
	STA.b $01
	LDA.b #$02
	STA.b $02
	TYA
	JMP.w CODE_03C189

;--------------------------------------------------------------------

CODE_03C13E:
	LDY.b #$7F
	BNE.b CODE_03C144

CODE_03C142:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDY.b #$12
else
	LDY.b #$0F
endif
CODE_03C144:
	LDA.b #$02
	BNE.b CODE_03C14C

CODE_03C148:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDY.b #$1F
else
	LDY.b #$1C
endif
CODE_03C14A:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDA.b #$04
else
	LDA.b #$03
endif
CODE_03C14C:
	STY.b $00
	INX
	JSR.w CODE_03C164
	LDX.b $9E
	RTS

;--------------------------------------------------------------------

DATA_03C155:
	db $06,$08,$A0,$00,$80,$00

CODE_03C15B:
	LDY.b #$01
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDA.b #$58
else
	LDA.b #$50
endif
	STA.b $00
	LDA.w DATA_03C155,y
CODE_03C164:
	STA.b $02
	LDA.b #$00
	JMP.w CODE_03C193

;--------------------------------------------------------------------

CODE_03C16B:
	LDA.b #$00
	BRA.b CODE_03C171

CODE_03C16F:
	LDA.b #$01
CODE_03C171:
	PHA
	LDY.b !RAM_SMB1_NorSpr_SpriteID,x
	INX
	LDA.b #$05
	CPY.b #!Define_SMB1_SpriteID_NorSpr029_WeighedDownGirderPlatform
	BNE.b CODE_03C17D
	LDA.b #$09
CODE_03C17D:
	STA.b $00
	LDA.b #$0A
	STA.b $01
	LDA.b #$03
	STA.b $02
	PLA
	TAY
CODE_03C189:
	JSR.w CODE_03C193
	LDX.b $9E
	RTS

;--------------------------------------------------------------------

; Note: Routine for updating Y speed.

CODE_03C18F:
	JSR.w CODE_03C193
	RTL

CODE_03C193:
	PHA
	LDA.w !RAM_SMB1_Player_SubYPos,x
	CLC
	ADC.w !RAM_SMB1_Player_SubYSpeed,x
	STA.w !RAM_SMB1_Player_SubYPos,x
	LDY.b #$00
	LDA.b !RAM_SMB1_Player_YSpeed,x
	BPL.b CODE_03C1A5
	DEY
CODE_03C1A5:
	STY.b $07
	ADC.w !RAM_SMB1_Player_YPosLo,x
	STA.w !RAM_SMB1_Player_YPosLo,x
	LDA.b !RAM_SMB1_Player_YPosHi,x
	ADC.b $07
	STA.b !RAM_SMB1_Player_YPosHi,x
	LDA.w !RAM_SMB1_Player_SubYSpeed,x
	CLC
	ADC.b $00
	STA.w !RAM_SMB1_Player_SubYSpeed,x
	LDA.b !RAM_SMB1_Player_YSpeed,x
	ADC.b #$00
	STA.b !RAM_SMB1_Player_YSpeed,x
	CMP.b $02
	BMI.b CODE_03C1D4
	LDA.w !RAM_SMB1_Player_SubYSpeed,x
	CMP.b #$80
	BCC.b CODE_03C1D4
	LDA.b $02
	STA.b !RAM_SMB1_Player_YSpeed,x
	STZ.w !RAM_SMB1_Player_SubYSpeed,x
CODE_03C1D4:
	PLA
	BEQ.b CODE_03C201
	LDA.b $02
	EOR.b #$FF
	INC
	STA.b $07
	LDA.w !RAM_SMB1_Player_SubYSpeed,x
	SEC
	SBC.b $01
	STA.w !RAM_SMB1_Player_SubYSpeed,x
	LDA.b !RAM_SMB1_Player_YSpeed,x
	SBC.b #$00
	STA.b !RAM_SMB1_Player_YSpeed,x
	CMP.b $07
	BPL.b CODE_03C201
	LDA.w !RAM_SMB1_Player_SubYSpeed,x
	CMP.b #$80
	BCS.b CODE_03C201
	LDA.b $07
	STA.b !RAM_SMB1_Player_YSpeed,x
	LDA.b #$FF
	STA.w !RAM_SMB1_Player_SubYSpeed,x
CODE_03C201:
	RTS

;--------------------------------------------------------------------

CODE_03C202:
	LDA.w $0E9D,x
	BEQ.b CODE_03C269
	INC.w $0EA2,x
	LDA.w $0EA2,x
	LSR
	LSR
	LSR
	CMP.b #$03
	BEQ.b CODE_03C26A
	ASL
	CLC
	ADC.b #$40
	STA.b !RAM_SMB1_Global_ScratchRAME4
	LDA.w $0EAC,x
	STA.b !RAM_SMB1_Global_ScratchRAME5
	LDA.w $0EA7,x
	STA.b !RAM_SMB1_Global_ScratchRAME6
	REP.b #$20
	LDA.b !RAM_SMB1_Global_ScratchRAME5
	SEC
	SBC.b $42
	PHA
	LDA.w $0EB5
	BMI.b CODE_03C238
	PLA
	CLC
	ADC.w #$000C
	BRA.b CODE_03C23D

CODE_03C238:
	PLA
	SEC
	SBC.w #$000C
CODE_03C23D:
	STA.b !RAM_SMB1_Global_ScratchRAME5
	SEP.b #$20
	PHY
	LDY.w !RAM_SMB1_Level_SpriteOAMIndexTable+$01,x
	LDA.b !RAM_SMB1_Global_ScratchRAME5
	STA.w SMB1_OAMBuffer[$40].XDisp,y
	LDA.w $0EB1,x
	STA.w SMB1_OAMBuffer[$40].YDisp,y
	LDA.b !RAM_SMB1_Global_ScratchRAME4
	STA.w SMB1_OAMBuffer[$40].Tile,y
	LDA.b #$2D
	STA.w SMB1_OAMBuffer[$40].Prop,y
	LDA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$40].Slot,y
	LDA.b !RAM_SMB1_Global_ScratchRAME6
	BEQ.b CODE_03C268
	LDA.b #$03
	STA.w SMB1_OAMTileSizeBuffer[$40].Slot,y
CODE_03C268:
	PLY
CODE_03C269:
	RTS

CODE_03C26A:
	STZ.w $0E9D,x
	TXA
	ASL
	ASL
	ASL
	STA.b !RAM_SMB1_Global_ScratchRAME8
	ASL
	CLC
	ADC.b !RAM_SMB1_Global_ScratchRAME8
	PHX
	TAX
	LDA.b #$F0
	STA.w SMB1_OAMBuffer[$40].YDisp,x
	STZ.w SMB1_OAMTileSizeBuffer[$40].Slot,x
	PLX
	RTS

;--------------------------------------------------------------------

CODE_03C283:
	STA.w $0E9D,x
	STZ.w $0EA2,x
	LDA.w !RAM_SMB1_NorSpr_XPosLo,x
	STA.w $0EAC,x
	LDA.b !RAM_SMB1_NorSpr_XPosHi,x
	STA.w $0EA7,x
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	CLC
	ADC.b #$08
	STA.w $0EB1,x
	RTS

;--------------------------------------------------------------------

CODE_03C29E:
	LDA.w !RAM_SMB1_Global_FadeDirection
	LSR
	BCC.b CODE_03C2F3
	LDA.w !RAM_SMB1_Global_ScreenDisplayRegisterMirror
	BMI.b CODE_03C2E9
	LDA.w $1680
	BEQ.b CODE_03C2B3
	LDA.w !RAM_SMB1_Global_ScreenDisplayRegisterMirror
	BEQ.b CODE_03C2B8
CODE_03C2B3:
	DEC.w !RAM_SMB1_Global_ScreenDisplayRegisterMirror
	BNE.b CODE_03C31F
CODE_03C2B8:
	LDA.b #!ScreenDisplayRegister_SetForceBlank
	STA.w !REGISTER_ScreenDisplayRegister
	STA.w !RAM_SMB1_Global_ScreenDisplayRegisterMirror
	STZ.w !REGISTER_HDMAEnable
	STZ.w !RAM_SMB1_Global_HDMAEnableMirror
	STZ.w $0B75
	STZ.w $1680
if !Define_Global_ROMToAssemble&(!ROM_SMB1_U|!ROM_SMB1_E|!ROM_SMB1_J) == $00
	LDA.l !SRAM_SMAS_Global_RunningDemoFlag
	BEQ.b CODE_03C2DF
	LDA.w $0EC8							
	BNE.b CODE_03C2DB
	JML.l SMAS_CopyOfResetToSMASTitleScreen_Main			; Note: Call to SMAS function

CODE_03C2DB:
	JML.l SMAS_ResetToSMASTitleScreen_Main				; Note: Call to SMAS function
endif

CODE_03C2DF:
	JSL.l CODE_048000
	JSR.w CODE_03C343
	JSR.w CODE_03C36E
CODE_03C2E9:
	STZ.w !RAM_SMB1_Global_FadeDirection
	LDA.b #$01
	STA.w $0774
	BRA.b CODE_03C31F

CODE_03C2F3:
	LDA.w $0E66
	BNE.b CODE_03C303
	LDA.b $0E
	BNE.b CODE_03C303
	LDA.b #$01
	STA.b $0E
	JSR.w CODE_03AD70
CODE_03C303:
	STZ.w $0E67
	LDA.w !RAM_SMB1_Global_ScreenDisplayRegisterMirror
	CMP.b #$0F
	BEQ.b CODE_03C317
	INC.w !RAM_SMB1_Global_ScreenDisplayRegisterMirror
	LDA.w !RAM_SMB1_Global_ScreenDisplayRegisterMirror
	CMP.b #$0F
	BNE.b CODE_03C31F
CODE_03C317:
	STZ.w !RAM_SMB1_Global_FadeDirection
	STZ.w $0774
	STZ.b $0E
CODE_03C31F:
	LDA.w !RAM_SMB1_Global_EnableMosaicFadesFlag
	BEQ.b CODE_03C342
	JSR.w CODE_03C343
	LDA.w !RAM_SMB1_Global_ScreenDisplayRegisterMirror
	EOR.b #$0F
	ASL
	ASL
	ASL
	ASL
	ORA.b #$0F
	STA.w !RAM_SMB1_Global_MosaicSizeAndBGEnableMirror
	JSR.w CODE_03C35C
	LDA.w !RAM_SMB1_Global_ScreenDisplayRegisterMirror
	CMP.b #$0F
	BNE.b CODE_03C342
	STZ.w !RAM_SMB1_Global_EnableMosaicFadesFlag
CODE_03C342:
	RTS

CODE_03C343:
	PHX
	LDX.b #$00
	LDA.b #$F0
CODE_03C348:
	STA.w SMB1_OAMBuffer[$00].YDisp,x
	STA.w SMB1_OAMBuffer[$40].YDisp,x
	STZ.w SMB1_OAMTileSizeBuffer[$00].Slot,x
	STZ.w SMB1_OAMTileSizeBuffer[$40].Slot,x
	INX
	INX
	INX
	INX
	BNE.b CODE_03C348
	PLX
	RTS

CODE_03C35C:
	PHY
	LDY.b #$D0
	LDA.b #$F0
CODE_03C361:
	STA.w SMB1_OAMBuffer[$00].YDisp,y
	INY
	INY
	INY
	INY
	CPY.b #$F0
	BNE.b CODE_03C361
	PLY
	RTS

CODE_03C36E:
	JSL.l SMB1_UploadSpriteGFX_Main
	STZ.w $0BA5
	STZ.w !RAM_SMB1_GameOverScreen_BlinkingCursorPos
	STZ.w $0ED1
	STZ.w $0E40
	STZ.w $0E41
	STZ.w $0E42
	STZ.w !RAM_SMB1_Global_EnableLayer3BGFlag
	LDA.w $0E66
	BNE.b CODE_03C39A
	LDA.w !RAM_SMB1_Player_YPosLo
	STA.w $03B8
	LDA.w !RAM_SMB1_Player_XPosLo
	STA.w $03AD
	BRA.b CODE_03C39D

CODE_03C39A:
	STZ.w $0E66
CODE_03C39D:
	STZ.b $0E
	RTS

if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_J1) != $00
%FREE_BYTES(NULLROM, 24, $FF)
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J2) != $00
%FREE_BYTES(NULLROM, 16, $FF)
elseif !Define_Global_ROMToAssemble&(!ROM_SMB1_U|!ROM_SMB1_J) != $00
elseif !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
%FREE_BYTES(NULLROM, 22, $FF)
else
%FREE_BYTES(NULLROM, 16, $FF)
endif

;--------------------------------------------------------------------

CODE_03C3B0:
	LDA.b !RAM_SMB1_NorSpr_SpriteSlotExistsFlag,x
	PHA
	ASL
	BCS.b CODE_03C3C8
	PLA
	BEQ.b CODE_03C3BC
	JMP.w CODE_03CCA8

CODE_03C3BC:
	LDA.w $071F
	AND.b #$07
	CMP.b #$07
	BEQ.b CODE_03C3D3
	JMP.w CODE_03C43C

CODE_03C3C8:
	PLA
	AND.b #$0F
	TAY
	LDA.w !RAM_SMB1_NorSpr_SpriteSlotExistsFlag,y
	BNE.b CODE_03C3D3
	STA.b !RAM_SMB1_NorSpr_SpriteSlotExistsFlag,x
CODE_03C3D3:
	RTS

;--------------------------------------------------------------------

DATA_03C3D4:
	db $03,$03,$06,$06,$06,$06,$06,$06
	db $07,$07,$07

DATA_03C3DF:
	db $05,$09,$04,$05,$06,$08,$09,$0A
	db $07,$0B,$10

DATA_03C3EA:
	db $40,$B0,$B0,$80,$40,$40,$80,$40
	db $F0,$F0,$F0

CODE_03C3F5:
	LDA.b !RAM_SMB1_Player_XPosHi
	SEC
	SBC.b #$04
	STA.b !RAM_SMB1_Player_XPosHi
	LDA.w $0725
	SEC
	SBC.b #$04
	STA.w $0725
	LDA.w $071A
	SEC
	SBC.b #$04
	STA.w $071A
	LDA.w $071B
	SEC
	SBC.b #$04
	STA.w $071B
	LDA.w $072A
	SEC
	SBC.b #$04
	STA.w $072A
	LDA.b #$00
	STA.w $073B
	STA.w $072B
	STA.w !RAM_SMB1_Level_SpriteListDataIndex
	STA.w !RAM_SMB1_Level_InitialXposHiOfSpriteListSprite
	PHX
	TYX
	LDA.l DATA_04C000,x
	STA.w !RAM_SMB1_Level_LevelDataIndex
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMB1_J) != $00
	STZ.w $0EDB
	PLX
else
	PLX
	STZ.w $0EDB
endif
	RTS

CODE_03C43C:
	LDA.w $0745
	BNE.b CODE_03C444
	JMP.w CODE_03C4C7

CODE_03C444:
	LDA.w $0726
	BNE.b CODE_03C4C7
	LDY.b #$0B
CODE_03C44B:
	DEY
	BMI.b CODE_03C4C7
	LDA.w !RAM_SMB1_Player_CurrentWorld
	CMP.w DATA_03C3D4,y
	BNE.b CODE_03C44B
	LDA.w $0725
	CMP.w DATA_03C3DF,y
	BNE.b CODE_03C44B
	LDA.w !RAM_SMB1_Player_YPosLo
	CMP.w DATA_03C3EA,y
	BNE.b CODE_03C4A2
	LDA.b !RAM_SMB1_Level_Player_CurrentPhysicsType
	CMP.b #$00
	BNE.b CODE_03C4A2
	LDA.w $0EDB
	BNE.b CODE_03C48F
	LDA.b #!Define_SMAS_Sound0063_Correct
	STA.w !RAM_SMB1_Global_SoundCh3
	LDA.w !RAM_SMB1_Player_CurrentWorld
	CMP.b #$06
	BNE.b CODE_03C4BC
	INC.w $06D9
	BRA.b CODE_03C48F

CODE_03C482:
	LDA.w $0EDB
	BNE.b CODE_03C48F
	LDA.b #!Define_SMAS_Sound0063_Wrong
	STA.w !RAM_SMB1_Global_SoundCh3
	STA.w $0EDB
CODE_03C48F:
	INC.w $06DA
	LDA.w $06DA
	CMP.b #$03
	BNE.b CODE_03C4C4
	LDA.w $06D9
	CMP.b #$03
	BNE.b CODE_03C4B6
	BRA.b CODE_03C4BC

CODE_03C4A2:
	LDA.w !RAM_SMB1_Player_CurrentWorld
	CMP.b #$06
	BEQ.b CODE_03C482
	LDA.w $0EDB
	BNE.b CODE_03C4B6
	LDA.b #!Define_SMAS_Sound0063_Wrong
	STA.w !RAM_SMB1_Global_SoundCh3
	STA.w $0EDB
CODE_03C4B6:
	JSR.w CODE_03C3F5
	JSR.w CODE_03D56B
CODE_03C4BC:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMB1_J) != $00
	STZ.w $06DA
	STZ.w $06D9	
else
	LDA.b #$00
	STA.w $06DA
	STA.w $06D9
endif
CODE_03C4C4:
	STZ.w $0745
CODE_03C4C7:
	LDA.w !RAM_SMB1_Level_SpriteToSpawnFromGeneratorObject
	BEQ.b CODE_03C4DA
	STA.b !RAM_SMB1_NorSpr_SpriteID,x
	LDA.b #$01
	STA.b !RAM_SMB1_NorSpr_SpriteSlotExistsFlag,x
	STZ.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	STZ.w !RAM_SMB1_Level_SpriteToSpawnFromGeneratorObject
	JMP.w CODE_03C5CA

CODE_03C4DA:								; Note: Routine that parses the sprite list data
	LDY.w !RAM_SMB1_Level_SpriteListDataIndex
	LDA.b [!RAM_SMB1_Level_SpriteListDataLo],y
	CMP.b #$FF
	BNE.b CODE_03C4E6
	JMP.w CODE_03C5B6

CODE_03C4E6:
	AND.b #$0F
	CMP.b #$0E
	BEQ.b CODE_03C4FA
	CPX.b #$08
	BCC.b CODE_03C4FA
	INY
	LDA.b [!RAM_SMB1_Level_SpriteListDataLo],y
	AND.b #$3F
	CMP.b #!Define_SMB1_SpriteID_NorSpr02E_Powerup
	BEQ.b CODE_03C4FA
	RTS

CODE_03C4FA:
	LDA.w $071D
	CLC
	ADC.b #$30
	AND.b #$F0
	STA.b $07
	LDA.w $071B
	ADC.b #$00
	STA.b $06
	LDY.w !RAM_SMB1_Level_SpriteListDataIndex
	INY
	LDA.b [!RAM_SMB1_Level_SpriteListDataLo],y
	ASL
	BCC.b CODE_03C51F
	LDA.w $073B
	BNE.b CODE_03C51F
	INC.w $073B
	INC.w !RAM_SMB1_Level_InitialXposHiOfSpriteListSprite
CODE_03C51F:
	DEY
	LDA.b [!RAM_SMB1_Level_SpriteListDataLo],y
	AND.b #$0F
	CMP.b #$0F
	BNE.b CODE_03C541
	LDA.w $073B
	BNE.b CODE_03C541
	INY
	LDA.b [!RAM_SMB1_Level_SpriteListDataLo],y
	AND.b #$3F
	STA.w !RAM_SMB1_Level_InitialXposHiOfSpriteListSprite
	INC.w !RAM_SMB1_Level_SpriteListDataIndex
	INC.w !RAM_SMB1_Level_SpriteListDataIndex
	INC.w $073B
	JMP.w CODE_03C43C

CODE_03C541:
	LDA.w !RAM_SMB1_Level_InitialXposHiOfSpriteListSprite
	STA.b !RAM_SMB1_NorSpr_XPosHi,x
	LDA.b [!RAM_SMB1_Level_SpriteListDataLo],y
	AND.b #$F0
	STA.w !RAM_SMB1_NorSpr_XPosLo,x
	CMP.w $071D
	LDA.b !RAM_SMB1_NorSpr_XPosHi,x
	SBC.w $071B
	BCS.b CODE_03C562
	LDA.b [!RAM_SMB1_Level_SpriteListDataLo],y
	AND.b #$0F
	CMP.b #$0E
	BEQ.b CODE_03C5D3
	JMP.w CODE_03C5F1

CODE_03C562:
	LDA.b $07
	CMP.w !RAM_SMB1_NorSpr_XPosLo,x
	LDA.b $06
	SBC.b !RAM_SMB1_NorSpr_XPosHi,x
	BCC.b CODE_03C5B6
	LDA.b #$01
	STA.b !RAM_SMB1_NorSpr_YPosHi,x
	LDA.b [!RAM_SMB1_Level_SpriteListDataLo],y
	ASL
	ASL
	ASL
	ASL
	STA.w !RAM_SMB1_NorSpr_YPosLo,x
	CMP.b #$E0
	BEQ.b CODE_03C5D3
	INY
	LDA.b [!RAM_SMB1_Level_SpriteListDataLo],y
	AND.b #$40
	BEQ.b CODE_03C58A
	LDA.w !RAM_SMB1_Global_UseLateStageSpriteBehaviorFlag
	BEQ.b CODE_03C5FF
CODE_03C58A:
	LDA.b [!RAM_SMB1_Level_SpriteListDataLo],y
	AND.b #$3F
	CMP.b #!Define_SMB1_SpriteID_NorSpr037_SpawnTwoGoombasYB0
	BCC.b CODE_03C596
	CMP.b #!Define_SMB1_SpriteID_NorSpr03E_SpawnThreeKoopasY70+$01
	BCC.b CODE_03C5D0
CODE_03C596:
	CMP.b #!Define_SMB1_SpriteID_NorSpr006_Goomba
	BNE.b CODE_03C5A1
	LDY.w !RAM_SMB1_Global_UseHardModeEnemyBehaviorFlag
	BEQ.b CODE_03C5A1
	LDA.b #!Define_SMB1_SpriteID_NorSpr002_BuzzyBeetle
CODE_03C5A1:
	STA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr02D_Bowser
	BNE.b CODE_03C5AA
	STZ.w $0F4C
CODE_03C5AA:
	LDA.b #$01
	STA.b !RAM_SMB1_NorSpr_SpriteSlotExistsFlag,x
	JSR.w CODE_03C5CA
	LDA.b !RAM_SMB1_NorSpr_SpriteSlotExistsFlag,x
	BNE.b CODE_03C5FF
	RTS

CODE_03C5B6:
	LDA.w !RAM_SMB1_Level_SpriteToRandomlyGenerate
	BNE.b CODE_03C5C4
	LDA.w $0398
	CMP.b #$01
	BNE.b CODE_03C5CF
	LDA.b #!Define_SMB1_SpriteID_NorSpr000_GreenKoopa
CODE_03C5C4:
	CPX.b #$09
	BEQ.b CODE_03C5CA
	STA.b !RAM_SMB1_NorSpr_SpriteID,x
CODE_03C5CA:
	STZ.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	JSR.w CODE_03C60B
CODE_03C5CF:
	RTS

CODE_03C5D0:
	JMP.w CODE_03CB2B

CODE_03C5D3:
	INY
	INY
	LDA.b [!RAM_SMB1_Level_SpriteListDataLo],y
	LSR
	LSR
	LSR
	LSR
	LSR
	CMP.w !RAM_SMB1_Player_CurrentWorld
	BNE.b CODE_03C5EF
	DEY
	LDA.b [!RAM_SMB1_Level_SpriteListDataLo],y
	STA.w !RAM_SMB1_Level_SublevelIDAndTileset
	INY
	LDA.b [!RAM_SMB1_Level_SpriteListDataLo],y
	AND.b #$1F
	STA.w !RAM_SMB1_Level_SublevelStartingScreen
CODE_03C5EF:
	BRA.b CODE_03C5FC

CODE_03C5F1:
	LDY.w !RAM_SMB1_Level_SpriteListDataIndex
	LDA.b [!RAM_SMB1_Level_SpriteListDataLo],y
	AND.b #$0F
	CMP.b #$0E
	BNE.b CODE_03C5FF
CODE_03C5FC:
	INC.w !RAM_SMB1_Level_SpriteListDataIndex
CODE_03C5FF:
	INC.w !RAM_SMB1_Level_SpriteListDataIndex
	INC.w !RAM_SMB1_Level_SpriteListDataIndex
	STZ.w $073B
	LDX.b $9E
	RTS

CODE_03C60B:						; Note: Seems to be the routine for initializing sprites.
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr015_BowserFireGenerator
	BCS.b CODE_03C620
	TAY
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	ADC.b #$08
	STA.w !RAM_SMB1_NorSpr_YPosLo,x
	LDA.b #$01
	STA.w $03D9,x
	TYA
CODE_03C620:
	ASL
	TAY
	LDA.w DATA_03C62F,y
	STA.b $04
	LDA.w DATA_03C62F+$01,y
	STA.b $05
	JMP.w ($0004)

DATA_03C62F:								; Info: Sprite ID...
	dw SMB1_NorSpr000_GreenKoopa_InitializationRt_Main
	dw SMB1_NorSpr001_RedKoopa_InitializationRt_Main
	dw SMB1_NorSpr002_BuzzyBeetle_InitializationRt_Main
	dw SMB1_NorSpr003_RedKoopa_InitializationRt_Main
	dw SMB1_NorSpr004_StationaryGreenKoopa_InitializationRt_Main
	dw SMB1_NorSpr005_HammerBro_InitializationRt_Main
	dw SMB1_NorSpr006_Goomba_InitializationRt_Main
	dw SMB1_NorSpr007_Blooper_InitializationRt_Main
	dw SMB1_NorSpr008_BulletBill_InitializationRt_Main
	dw SMB1_NorSpr009_StationaryYellowParakoopa_InitializationRt_Main
	dw SMB1_NorSpr00A_GreenSwimmingCheepCheep_InitializationRt_Main
	dw SMB1_NorSpr00B_RedSwimmingCheepCheep_InitializationRt_Main
	dw SMB1_NorSpr00C_Podoboo_InitializationRt_Main
	dw SMB1_NorSpr00D_PiranhaPlant_InitializationRt_Main
	dw SMB1_NorSpr00E_GreenBouncingParakoopa_InitializationRt_Main
	dw SMB1_NorSpr00F_RedVerticalParakoopa_InitializationRt_Main
	dw SMB1_NorSpr010_GreenHorizontalParakoopa_InitializationRt_Main
	dw SMB1_NorSpr011_Lakitu_InitializationRt_Main
	dw SMB1_NorSpr012_Spiny_InitializationRt_Main
	dw SMB1_NorSpr013_UnknownEnemy_InitializationRt_Main
	dw SMB1_NorSpr014_RedFlyingCheepCheepGenerator_InitializationRt_Main
	dw SMB1_NorSpr015_BowserFireGenerator_InitializationRt_Main
	dw SMB1_NorSpr016_FireworksGenerator_InitializationRt_Main
	dw SMB1_NorSpr017_BulletBillGenerator_InitializationRt_Main
	dw SMB1_NorSpr018_RemoveGenerators_InitializationRt_Main
	dw SMB1_NorSpr019_UnusedSprite_InitializationRt_Main
	dw SMB1_NorSpr01A_UnusedSprite_InitializationRt_Main
	dw SMB1_NorSpr01B_SlowClockwiseFirebar_InitializationRt_Main
	dw SMB1_NorSpr01C_FastClockwiseFirebar_InitializationRt_Main
	dw SMB1_NorSpr01D_SlowCounterClockwiseFirebar_InitializationRt_Main
	dw SMB1_NorSpr01E_FastCounterClockwiseFirebar_InitializationRt_Main
	dw SMB1_NorSpr01F_LargeClockwiseFirebar_InitializationRt_Main
	dw SMB1_NorSpr020_StationaryFirebar_InitializationRt_Main
	dw SMB1_NorSpr021_StationaryFirebar_InitializationRt_Main
	dw SMB1_NorSpr022_StationaryFirebar_InitializationRt_Main
	dw SMB1_NorSpr023_UnusedSprite_InitializationRt_Main
	dw SMB1_NorSpr024_PulleyGirderPlatform_InitializationRt_Main
	dw SMB1_NorSpr025_VerticalMovingGirderPlatform_InitializationRt_Main
	dw SMB1_NorSpr026_ScreenWrappingUpMovingGirderPlatform_InitializationRt_Main
	dw SMB1_NorSpr027_ScreenWrappingDownMovingGirderPlatform_InitializationRt_Main
	dw SMB1_NorSpr028_HorizontalMovingGirderPlatform_InitializationRt_Main
	dw SMB1_NorSpr029_WeighedDownGirderPlatform_InitializationRt_Main
	dw SMB1_NorSpr02A_RightMovingGirderPlatform_InitializationRt_Main
	dw SMB1_NorSpr02B_UpMovingGirderPlatformLift_InitializationRt_Main
	dw SMB1_NorSpr02D_DownMovingGirderPlatformLift_InitializationRt_Main
	dw SMB1_NorSpr02D_Bowser_InitializationRt_Main
	dw SMB1_NorSpr02E_Powerup_InitializationRt_Main
	dw SMB1_NorSpr02F_Vine_InitializationRt_Main
	dw SMB1_NorSpr030_Flagpole_InitializationRt_Main
	dw SMB1_NorSpr031_GoalObject_InitializationRt_Main
	dw SMB1_NorSpr032_RedSpringboard_InitializationRt_Main
	dw SMB1_NorSpr033_BulletBillLauncher_InitializationRt_Main
	dw SMB1_NorSpr034_WarpZone_InitializationRt_Main
	dw SMB1_NorSpr035_PeachAndToad_InitializationRt_Main
	dw SMB1_NorSpr036_UnusedSprite_InitializationRt_Main

;--------------------------------------------------------------------

SMB1_NorSpr004_StationaryGreenKoopa_InitializationRt:
.Main:
SMB1_NorSpr009_StationaryYellowParakoopa_InitializationRt:
.Main:
SMB1_NorSpr013_UnknownEnemy_InitializationRt:
.Main:
SMB1_NorSpr019_UnusedSprite_InitializationRt:
.Main:
SMB1_NorSpr01A_UnusedSprite_InitializationRt:
.Main:
SMB1_NorSpr020_StationaryFirebar_InitializationRt:
.Main:
SMB1_NorSpr021_StationaryFirebar_InitializationRt:
.Main:
SMB1_NorSpr022_StationaryFirebar_InitializationRt:
.Main:
SMB1_NorSpr023_UnusedSprite_InitializationRt:
.Main:
SMB1_NorSpr030_Flagpole_InitializationRt:
.Main:
SMB1_NorSpr031_GoalObject_InitializationRt:
.Main:
SMB1_NorSpr032_RedSpringboard_InitializationRt:
.Main:
SMB1_NorSpr033_BulletBillLauncher_InitializationRt:
.Main:
SMB1_NorSpr034_WarpZone_InitializationRt:
.Main
;$03C69D
	RTS

;--------------------------------------------------------------------

SMB1_NorSpr006_Goomba_InitializationRt:
.Main:
;$03C69E
	JSR.w CODE_03C6D3
	JMP.w CODE_03C707

;--------------------------------------------------------------------

SMB1_NorSpr00C_Podoboo_InitializationRt:
.Main:
CODE_03C6A4:
	LDA.b #$D0
	STA.w !RAM_SMB1_NorSpr_YPosLo,x
	LDA.b #$01
	STA.b !RAM_SMB1_NorSpr_YPosHi,x
	STA.w !RAM_SMB3_NorSpr00C_Podoboo_WaitBeforeJumpingTimer,x
	STZ.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	STA.w $0B00,x
	STZ.w $0B09,x
	LDA.b #!Define_SMAS_Sound0063_Podoboo
	STA.w !RAM_SMB1_Global_SoundCh3
	JMP.w CODE_03C707

;--------------------------------------------------------------------

SMB1_NorSpr035_PeachAndToad_InitializationRt:
.Main:
;$03C6C0
	LDA.w !RAM_SMB1_Player_CurrentWorld
	CMP.b #$07
	BNE.b CODE_03C6CD
	LDA.b #$70
CODE_03C6C9:
	STA.w !RAM_SMB1_NorSpr_YPosLo,x
	RTS

CODE_03C6CD:
	LDA.b #$B8
	BRA.b CODE_03C6C9

;--------------------------------------------------------------------

DATA_03C6D1:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	db $F6,$F1
else
	db $F8,$F4
endif

SMB1_NorSpr000_GreenKoopa_InitializationRt:
.Main:
SMB1_NorSpr001_RedKoopa_InitializationRt:
.Main:
SMB1_NorSpr002_BuzzyBeetle_InitializationRt:
.Main:
CODE_03C6D3:
	LDY.b #$01
	LDA.w !RAM_SMB1_Global_UseHardModeEnemyBehaviorFlag
	BNE.b CODE_03C6DB
	DEY
CODE_03C6DB:
	LDA.w DATA_03C6D1,y
CODE_03C6DE:
	STA.b !RAM_SMB1_NorSpr_XSpeed,x
	JMP.w CODE_03C71D

;--------------------------------------------------------------------

SMB1_NorSpr003_RedKoopa_InitializationRt:
.Main:
;$03C6E3
	JSR.w CODE_03C6D3
	LDA.b #$01
	STA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	RTS

;--------------------------------------------------------------------

DATA_03C6EB:
	db $80,$50

SMB1_NorSpr005_HammerBro_InitializationRt:
.Main:
;$03C6ED
	STZ.w $03A2,x
	STZ.b !RAM_SMB1_NorSpr_XSpeed,x
	LDY.w !RAM_SMB1_Global_UseLateStageSpriteBehaviorFlag
	LDA.w DATA_03C6EB,y
	STA.w $07A2,x
	LDA.b #$0B
	JMP.w CODE_03C71F

;--------------------------------------------------------------------

SMB1_NorSpr010_GreenHorizontalParakoopa_InitializationRt:
.Main:
CODE_03C700:
	LDA.b #$00
	JMP.w CODE_03C6DE

;--------------------------------------------------------------------

SMB1_NorSpr007_Blooper_InitializationRt:
.Main:
;$03C705
	STZ.b !RAM_SMB1_NorSpr_XSpeed,x
CODE_03C707:
	LDA.b #$09
	BNE.b CODE_03C71F

SMB1_NorSpr00F_RedVerticalParakoopa_InitializationRt:
.Main:
	LDY.b #$30
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	STA.w $0402,x
	BPL.b CODE_03C717
	LDY.b #$E0
CODE_03C717:
	TYA
	ADC.w !RAM_SMB1_NorSpr_YPosLo,x
	STA.b !RAM_SMB1_NorSpr_XSpeed,x
CODE_03C71D:
	LDA.b #$03
CODE_03C71F:
	STA.w !RAM_SMB1_NorSpr_HitboxSizeIndex,x
	LDA.b #$02
	STA.b $47,x
CODE_03C726:
	LDA.b #$00
	STA.b !RAM_SMB1_NorSpr_YSpeed,x
	STA.w !RAM_SMB1_NorSpr_SubYSpeed,x
	RTS

;--------------------------------------------------------------------

SMB1_NorSpr008_BulletBill_InitializationRt:
.Main:
;$03C72E
	LDA.b #$02
	STA.b $47,x
	LDA.b #$09
	STA.w !RAM_SMB1_NorSpr_HitboxSizeIndex,x
	RTS

;--------------------------------------------------------------------

SMB1_NorSpr00A_GreenSwimmingCheepCheep_InitializationRt:
.Main:
SMB1_NorSpr00B_RedSwimmingCheepCheep_InitializationRt:
.Main:
;$03C738
	JSR.w CODE_03C707
	LDA.w !RAM_SMB1_Global_RandomByte1,x
	AND.b #$10
	STA.b !RAM_SMB1_NorSpr_XSpeed,x
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	STA.w !RAM_SMB1_NorSpr_SubYSpeed,x
	RTS

;--------------------------------------------------------------------

SMB1_NorSpr011_Lakitu_InitializationRt:
.Main:
;$03C749
	LDA.w !RAM_SMB1_Level_SpriteToRandomlyGenerate
	BNE.b CODE_03C759
CODE_03C74E:
	LDA.b #$00
	STA.w $06D1
	JSR.w CODE_03C700
	JMP.w CODE_03CBFA

CODE_03C759:
	JMP.w CODE_03CDE2

;--------------------------------------------------------------------

DATA_03C75C:
	db $26,$2C,$32,$38,$20,$22,$24,$26
	db $13,$14,$15,$16

CODE_03C768:
	LDA.w $079B
	BNE.b CODE_03C7A7
	CPX.b #$09
	BCS.b CODE_03C7A7
	LDA.b #$80
	STA.w $079B
	LDY.b #$08
CODE_03C778:
	LDA.w !RAM_SMB1_NorSpr_SpriteID,y
	CMP.b #!Define_SMB1_SpriteID_NorSpr011_Lakitu
	BEQ.b CODE_03C7A8
	DEY
	BPL.b CODE_03C778
	INC.w $06D1
	LDA.w $06D1
	CMP.b #$07
	BCC.b CODE_03C7A7
	LDX.b #$08
CODE_03C78E:
	LDA.b !RAM_SMB1_NorSpr_SpriteSlotExistsFlag,x
	BEQ.b CODE_03C797
	DEX
	BPL.b CODE_03C78E
	BMI.b CODE_03C7A5					; Note: This will always branch.

CODE_03C797:
	STZ.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	LDA.b #!Define_SMB1_SpriteID_NorSpr011_Lakitu
	STA.b !RAM_SMB1_NorSpr_SpriteID,x
	JSR.w CODE_03C74E
	LDA.b #$20
	JSR.w CODE_03C9E8
CODE_03C7A5:
	LDX.b $9E
CODE_03C7A7:
	RTS

CODE_03C7A8:
	LDA.w !RAM_SMB1_Player_YPosLo
	CMP.b #$2C
	BCC.b CODE_03C7A7
	LDA.w !RAM_SMB1_NorSpr_SpriteStatusFlags,y
	BNE.b CODE_03C7A7
	LDA.w !RAM_SMB1_NorSpr_XPosHi,y
	STA.b !RAM_SMB1_NorSpr_XPosHi,x
	LDA.w !RAM_SMB1_NorSpr_XPosLo,y
	STA.w !RAM_SMB1_NorSpr_XPosLo,x
	LDA.b #$01
	STA.b !RAM_SMB1_NorSpr_YPosHi,x
	LDA.w !RAM_SMB1_NorSpr_YPosLo,y
	SEC
	SBC.b #$08
	STA.w !RAM_SMB1_NorSpr_YPosLo,x
	LDA.w !RAM_SMB1_Global_RandomByte1,x
	AND.b #$03
	TAY
	LDX.b #$02
CODE_03C7D4:
	LDA.w DATA_03C75C,y
	STA.b $01,x
	INY
	INY
	INY
	INY
	DEX
	BPL.b CODE_03C7D4
	LDX.b $9E
	JSR.w CODE_03D420
	LDY.b !RAM_SMB1_Player_XSpeed
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	CPY.b #$0C
else
	CPY.b #$08
endif
	BCS.b CODE_03C7F9
	TAY
	LDA.w !RAM_SMB1_Global_RandomByte2,x
	AND.b #$03
	BEQ.b CODE_03C7F8
	TYA
	EOR.b #$FF
	TAY
	INY
CODE_03C7F8:
	TYA
CODE_03C7F9:
	JSR.w CODE_03C707				; Glitch: This JSR should be moved to be right after the CODE_03C805. As is, this causes a bug that was in the orignal SMB1 where lakitus throw spinies with no X speed.
	LDY.b #$02
	STA.b !RAM_SMB1_NorSpr_XSpeed,x
	CMP.b #$00
	BMI.b CODE_03C805
	DEY
CODE_03C805:
	STY.b $47,x
	LDA.b #$FD
	STA.b !RAM_SMB1_NorSpr_YSpeed,x
	LDA.b #$01
	STA.b !RAM_SMB1_NorSpr_SpriteSlotExistsFlag,x
	LDA.b #$05
	STA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
CODE_03C813:
	RTS

;--------------------------------------------------------------------

DATA_03C814:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	db $30,$43,$30,$43,$30
else
	db $28,$38,$28,$38,$28
endif

DATA_03C819:
	db $00,$00,$10,$10,$00

SMB1_NorSpr01F_LargeClockwiseFirebar_InitializationRt:
.Main:
;$03C81E
	JSR.w CODE_03C946
SMB1_NorSpr01B_SlowClockwiseFirebar_InitializationRt:
.Main:
SMB1_NorSpr01C_FastClockwiseFirebar_InitializationRt:
.Main:
SMB1_NorSpr01D_SlowCounterClockwiseFirebar_InitializationRt:
.Main:
SMB1_NorSpr01E_FastCounterClockwiseFirebar_InitializationRt:
.Main
	STZ.b !RAM_SMB1_NorSpr_XSpeed,x
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	SEC
	SBC.b #!Define_SMB1_SpriteID_NorSpr01B_SlowClockwiseFirebar
	TAY
	LDA.w DATA_03C814,y
	STA.w $0388,x
	LDA.w DATA_03C819,y
	STA.w $0203,x
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	CLC
	ADC.b #$04
	STA.w !RAM_SMB1_NorSpr_YPosLo,x
	LDA.w !RAM_SMB1_NorSpr_XPosLo,x
	CLC
	ADC.b #$04
	STA.w !RAM_SMB1_NorSpr_XPosLo,x
	LDA.b !RAM_SMB1_NorSpr_XPosHi,x
	ADC.b #$00
	STA.b !RAM_SMB1_NorSpr_XPosHi,x
	JMP.w CODE_03CBFA

;--------------------------------------------------------------------

DATA_03C850:
	db $80,$30,$40,$80,$30,$50,$50,$70
	db $20,$40,$80,$A0,$70,$40,$90,$68

DATA_03C860:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	db $11,$07,$08,$0A,$23,$28,$15,$10
	db $22,$2C,$1F,$1B
else
	db $0E,$05,$06,$0E,$1C,$20,$10,$0C
	db $1E,$22,$18,$14
endif

DATA_03C86C:
	db $10,$60,$20,$48

CODE_03C870:
	LDA.w $079B
	BNE.b CODE_03C813
	JSR.w CODE_03C707
	LDA.w !RAM_SMB1_Global_RandomByte2,x
	AND.b #$03
	TAY
	LDA.w DATA_03C86C,y
	STA.w $079B
	LDY.b #$03
	LDA.w !RAM_SMB1_Global_UseLateStageSpriteBehaviorFlag
	BEQ.b CODE_03C88C
	INY
CODE_03C88C:
	STY.b $00
	CPX.b $00
	BCC.b CODE_03C895
	JMP.w CODE_03C813

CODE_03C895:
	LDA.w !RAM_SMB1_Global_RandomByte1,x
	AND.b #$03
	STA.b $00
	STA.b $01
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDA.b #$FA
else
	LDA.b #$FB
endif
	STA.b !RAM_SMB1_NorSpr_YSpeed,x
	LDA.b #$00
	LDY.b !RAM_SMB1_Player_XSpeed
	BEQ.b CODE_03C8AF
	LDA.b #$04
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	CPY.b #$1D
else
	CPY.b #$19
endif
	BCC.b CODE_03C8AF
	ASL
CODE_03C8AF:
	PHA
	CLC
	ADC.b $00
	STA.b $00
	LDA.w !RAM_SMB1_Global_RandomByte2,x
	AND.b #$03
	BEQ.b CODE_03C8C3
	LDA.w !RAM_SMB1_Global_RandomByte3,x
	AND.b #$0F
	STA.b $00
CODE_03C8C3:
	PLA
	CLC
	ADC.b $01
	TAY
	LDA.w DATA_03C860,y
	STA.b !RAM_SMB1_NorSpr_XSpeed,x
	LDA.b #$01
	STA.b $47,x
	LDA.b !RAM_SMB1_Player_XSpeed
	BNE.b CODE_03C8E7
	LDY.b $00
	TYA
	AND.b #$02
	BEQ.b CODE_03C8E7
	LDA.b !RAM_SMB1_NorSpr_XSpeed,x
	EOR.b #$FF
	CLC
	ADC.b #$01
	STA.b !RAM_SMB1_NorSpr_XSpeed,x
	INC.b $47,x
CODE_03C8E7:
	TYA
	AND.b #$02
	BEQ.b CODE_03C8FC
	LDA.w !RAM_SMB1_Player_XPosLo
	CLC
	ADC.w DATA_03C850,y
	STA.w !RAM_SMB1_NorSpr_XPosLo,x
	LDA.b !RAM_SMB1_Player_XPosHi
	ADC.b #$00
	BRA.b CODE_03C90A

CODE_03C8FC:
	LDA.w !RAM_SMB1_Player_XPosLo
	SEC
	SBC.w DATA_03C850,y
	STA.w !RAM_SMB1_NorSpr_XPosLo,x
	LDA.b !RAM_SMB1_Player_XPosHi
	SBC.b #$00
CODE_03C90A:
	STA.b !RAM_SMB1_NorSpr_XPosHi,x
	LDA.b #$01
	STA.b !RAM_SMB1_NorSpr_SpriteSlotExistsFlag,x
	STA.b !RAM_SMB1_NorSpr_YPosHi,x
	LDA.b #$F8
	STA.w !RAM_SMB1_NorSpr_YPosLo,x
	RTS

;--------------------------------------------------------------------

SMB1_NorSpr02D_Bowser_InitializationRt:
.Main:
;$03C918
	JSR.w CODE_03C946
	STX.w $0368
	STZ.w $0363
	STZ.w !RAM_SMB1_NorSpr02D_Bowser_NumberOfBrokenBridgeSegments
	LDA.w !RAM_SMB1_NorSpr_XPosLo,x
	STA.w !RAM_SMB1_NorSpr02D_Bowser_InitialXPosLo
	LDA.b #$DF
	STA.w $079C
	STA.b $47,x
	LDA.b #$20
	STA.w !RAM_SMB1_NorSpr02D_Bowser_WaitBeforeBreakingNextBridgeSegment
	STA.w !RAM_SMB1_NorSpr02D_Bowser_WaitBeforeNextJump,x
	STA.w $0257,x
	LDA.b #$05
	STA.w !RAM_SMB1_NorSpr02D_Bowser_CurrentHP
	LSR
	STA.w !RAM_SMB1_NorSpr02D_Bowser_XAcceleration
	RTS

;--------------------------------------------------------------------

CODE_03C946:
	LDY.b #$FF
CODE_03C948:
	INY
	LDA.w !RAM_SMB1_NorSpr_SpriteSlotExistsFlag,y
	BNE.b CODE_03C948
	STY.w $06CF
	TXA
	ORA.b #$80
	STA.w !RAM_SMB1_NorSpr_SpriteSlotExistsFlag,y
	LDA.b !RAM_SMB1_NorSpr_XPosHi,x
	STA.w !RAM_SMB1_NorSpr_XPosHi,y
	LDA.w !RAM_SMB1_NorSpr_XPosLo,x
	STA.w !RAM_SMB1_NorSpr_XPosLo,y
	LDA.b #$01
	STA.b !RAM_SMB1_NorSpr_SpriteSlotExistsFlag,x
	STA.w !RAM_SMB1_NorSpr_YPosHi,y
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	STA.w !RAM_SMB1_NorSpr_YPosLo,y
CODE_03C96F:
	RTS

;--------------------------------------------------------------------

DATA_03C970:
	db $90,$80,$70,$90

DATA_03C974:
	db $FF,$01

CODE_03C976:
	LDA.w $079B
	BNE.b CODE_03C96F
	STA.w !RAM_SMB1_NorSpr_SubYSpeed,x
	LDA.b #$06
	STA.w $014B
	LDA.b #$18
	STA.w $0F4C
	STX.w $0F4D
	LDY.w $0368
	LDA.w !RAM_SMB1_NorSpr_SpriteID,y
	CMP.b #!Define_SMB1_SpriteID_NorSpr02D_Bowser
	BEQ.b CODE_03C9E4
	JSR.w CODE_03D6F9
	CLC
	ADC.b #$20
	LDY.w !RAM_SMB1_Global_UseLateStageSpriteBehaviorFlag
	BEQ.b CODE_03C9A3
	SEC
	SBC.b #$10
CODE_03C9A3:
	STA.w $079B
	LDA.w !RAM_SMB1_Global_RandomByte1,x
	AND.b #$03
	STA.w !RAM_SMB1_NorSpr_SubYPos,x
	TAY
	LDA.w DATA_03C970,y
	STA.w !RAM_SMB1_NorSpr_YPosLo,x
	LDA.w $071D
	CLC
	ADC.b #$20
	STA.w !RAM_SMB1_NorSpr_XPosLo,x
	LDA.w $071B
	ADC.b #$00
	STA.b !RAM_SMB1_NorSpr_XPosHi,x
	STZ.w $0F4C
	STZ.w $0F4D
	STZ.w $014B
	LDA.b #!Define_SMAS_Sound0063_FireSpit
	STA.w !RAM_SMB1_Global_SoundCh3
	LDA.b #$08
	STA.w !RAM_SMB1_NorSpr_HitboxSizeIndex,x
	LDA.b #$01
	STA.b !RAM_SMB1_NorSpr_YPosHi,x
	STA.b !RAM_SMB1_NorSpr_SpriteSlotExistsFlag,x
	LSR
	STA.w $0402,x
	STA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
CODE_03C9E4:
	STX.w $0F4E
	RTS

;--------------------------------------------------------------------

CODE_03C9E8:
	STA.w !RAM_SMB1_NorSpr_YPosLo,x
	LDA.w $071D
	CLC
	ADC.b #$20
	STA.w !RAM_SMB1_NorSpr_XPosLo,x
	LDA.w $071B
	ADC.b #$00
	STA.b !RAM_SMB1_NorSpr_XPosHi,x
	JMP.w CODE_03CA32

;--------------------------------------------------------------------

CODE_03C9FE:
	LDA.w !RAM_SMB1_NorSpr_XPosLo,y
	SEC
	SBC.b #$0E
	STA.w !RAM_SMB1_NorSpr_XPosLo,x
	LDA.w !RAM_SMB1_NorSpr_XPosHi,y
	STA.b !RAM_SMB1_NorSpr_XPosHi,x
	LDA.w !RAM_SMB1_NorSpr_YPosLo,y
	CLC
	ADC.b #$08
	STA.w !RAM_SMB1_NorSpr_YPosLo,x
	LDA.w !RAM_SMB1_Global_RandomByte1,x
	AND.b #$03
	STA.w !RAM_SMB1_NorSpr_SubYPos,x
	TAY
	LDA.w DATA_03C970,y
	LDY.b #$00
	CMP.w !RAM_SMB1_NorSpr_YPosLo,x
	BCC.b CODE_03CA29
	INY
CODE_03CA29:
	LDA.w DATA_03C974,y
	STA.w !RAM_SMB1_NorSpr_SubYSpeed,x
	STZ.w !RAM_SMB1_Level_SpriteToRandomlyGenerate
CODE_03CA32:
	LDA.b #$08
	STA.w !RAM_SMB1_NorSpr_HitboxSizeIndex,x
	LDA.b #$01
	STA.b !RAM_SMB1_NorSpr_YPosHi,x
	STA.b !RAM_SMB1_NorSpr_SpriteSlotExistsFlag,x
	LSR
	STA.w $0402,x
	STA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	RTS

;--------------------------------------------------------------------

DATA_03CA44:
	db $00,$30,$60,$60,$00,$20

DATA_03CA4A:
	db $60,$40,$70,$40,$60,$30

CODE_03CA50:
	LDA.w $079B
	BNE.b CODE_03CA9E
	LDA.b #$20
	STA.w $079B
	DEC.w $06D7
	LDY.b #$0A
CODE_03CA5F:
	DEY
	LDA.w !RAM_SMB1_NorSpr_SpriteID,y
	CMP.b #!Define_SMB1_SpriteID_NorSpr031_GoalObject
	BNE.b CODE_03CA5F
	LDA.w !RAM_SMB1_NorSpr_XPosLo,y
	SEC
	SBC.b #$30
	PHA
	LDA.w !RAM_SMB1_NorSpr_XPosHi,y
	SBC.b #$00
	STA.b $00
	LDA.w $06D7
	CLC
	ADC.w !RAM_SMB1_NorSpr_SpriteStatusFlags,y
	TAY
	PLA
	CLC
	ADC.w DATA_03CA44,y
	STA.w !RAM_SMB1_NorSpr_XPosLo,x
	LDA.b $00
	ADC.b #$00
	STA.b !RAM_SMB1_NorSpr_XPosHi,x
	LDA.w DATA_03CA4A,y
	STA.w !RAM_SMB1_NorSpr_YPosLo,x
	LDA.b #$01
	STA.b !RAM_SMB1_NorSpr_YPosHi,x
	STA.b !RAM_SMB1_NorSpr_SpriteSlotExistsFlag,x
	LSR
	STA.b !RAM_SMB1_NorSpr_XSpeed,x
	LDA.b #$08
	STA.b !RAM_SMB1_NorSpr_YSpeed,x
CODE_03CA9E:
	RTS

;--------------------------------------------------------------------

DATA_03CA9F:
	db $01,$02,$04,$08,$10,$20,$40,$80

;--------------------------------------------------------------------

DATA_03CAA7:
	db $40,$30,$90,$50,$20,$60,$A0,$70

DATA_03CAAF:
	db !Define_SMB1_SpriteID_NorSpr00A_GreenSwimmingCheepCheep
	db !Define_SMB1_SpriteID_NorSpr00B_RedSwimmingCheepCheep

CODE_03CAB1:
	LDA.w $079B
	BNE.b CODE_03CB21
	LDA.b !RAM_SMB1_Level_CurrentLevelType
	BNE.b CODE_03CB0E
	CPX.b #$03
	BCS.b CODE_03CB21
	LDY.b #$00
	LDA.w !RAM_SMB1_Global_RandomByte1,x
	CMP.b #$AA
	BCC.b CODE_03CAC8
	INY
CODE_03CAC8:
	LDA.w !RAM_SMB1_Player_CurrentWorld
	CMP.b #$01
	BEQ.b CODE_03CAD0
	INY
CODE_03CAD0:
	TYA
	AND.b #$01
	TAY
	LDA.w DATA_03CAAF,y
CODE_03CAD7:
	STA.b !RAM_SMB1_NorSpr_SpriteID,x
	LDA.w $06DD
	CMP.b #$FF
	BNE.b CODE_03CAE3
	STZ.w $06DD
CODE_03CAE3:
	LDA.w !RAM_SMB1_Global_RandomByte1,x
	AND.b #$07
CODE_03CAE8:
	TAY
	LDA.w DATA_03CA9F,y
	BIT.w $06DD
	BEQ.b CODE_03CAF7
	INY
	TYA
	AND.b #$07
	BRA.b CODE_03CAE8

CODE_03CAF7:
	ORA.w $06DD
	STA.w $06DD
	LDA.w DATA_03CAA7,y
	JSR.w CODE_03C9E8
	STA.w !RAM_SMB1_NorSpr_SubYPos,x
	LDA.b #$20
	STA.w $079B
	JMP.w CODE_03C60B

CODE_03CB0E:
	LDY.b #$FF
CODE_03CB10:
	INY
	CPY.b #$09
	BCS.b CODE_03CB22
	LDA.w !RAM_SMB1_NorSpr_SpriteSlotExistsFlag,y
	BEQ.b CODE_03CB10
	LDA.w !RAM_SMB1_NorSpr_SpriteID,y
	CMP.b #!Define_SMB1_SpriteID_NorSpr008_BulletBill
	BNE.b CODE_03CB10
CODE_03CB21:
	RTS

CODE_03CB22:
	LDA.b #!Define_SMAS_Sound0063_BulletShoot
	STA.w !RAM_SMB1_Global_SoundCh3
	LDA.b #!Define_SMB1_SpriteID_NorSpr008_BulletBill
	BNE.b CODE_03CAD7							; Note: This will always branch

CODE_03CB2B:
	LDY.b #!Define_SMB1_SpriteID_NorSpr000_GreenKoopa
	SEC
	SBC.b #!Define_SMB1_SpriteID_NorSpr037_SpawnTwoGoombasYB0
	PHA
	CMP.b #!Define_SMB1_SpriteID_NorSpr03B_SpawnTwoKoopasYB0-!Define_SMB1_SpriteID_NorSpr037_SpawnTwoGoombasYB0
	BCS.b CODE_03CB40
	PHA
	LDY.b #!Define_SMB1_SpriteID_NorSpr006_Goomba
	LDA.w !RAM_SMB1_Global_UseHardModeEnemyBehaviorFlag
	BEQ.b CODE_03CB3F
	LDY.b #!Define_SMB1_SpriteID_NorSpr002_BuzzyBeetle
CODE_03CB3F:
	PLA
CODE_03CB40:
	STY.b $01
	LDY.b #$B0
	AND.b #$02
	BEQ.b CODE_03CB4A
	LDY.b #$70
CODE_03CB4A:
	STY.b $00
	LDA.w $071B
	STA.b $02
	LDA.w $071D
	STA.b $03
	LDY.b #$02
	PLA
	LSR
	BCC.b CODE_03CB5D
	INY
CODE_03CB5D:
	STY.w $06D3
CODE_03CB60:
	LDX.b #$FF
CODE_03CB62:
	INX
	CPX.b #$09
	BCS.b CODE_03CB96
	LDA.b !RAM_SMB1_NorSpr_SpriteSlotExistsFlag,x
	BNE.b CODE_03CB62
	LDA.b $01
	STA.b !RAM_SMB1_NorSpr_SpriteID,x
	LDA.b $02
	STA.b !RAM_SMB1_NorSpr_XPosHi,x
	LDA.b $03
	STA.w !RAM_SMB1_NorSpr_XPosLo,x
	CLC
	ADC.b #$18
	STA.b $03
	LDA.b $02
	ADC.b #$00
	STA.b $02
	LDA.b $00
	STA.w !RAM_SMB1_NorSpr_YPosLo,x
	LDA.b #$01
	STA.b !RAM_SMB1_NorSpr_YPosHi,x
	STA.b !RAM_SMB1_NorSpr_SpriteSlotExistsFlag,x
	JSR.w CODE_03C60B
	DEC.w $06D3
	BNE.b CODE_03CB60
CODE_03CB96:
	JMP.w CODE_03C5FF

;--------------------------------------------------------------------

SMB1_NorSpr00D_PiranhaPlant_InitializationRt:
.Main:
;$03CB99
	LDA.b #$01
	STA.b !RAM_SMB1_NorSpr_XSpeed,x
	LSR
	STA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	STA.b !RAM_SMB1_NorSpr_YSpeed,x
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	STA.w !RAM_SMB1_NorSpr_SubYSpeed,x
	SEC
	SBC.b #$18
	STA.w !RAM_SMB1_NorSpr_SubYPos,x
	LDA.b #$09
	LDA.b #$0C
	JMP.w CODE_03CBFC

;--------------------------------------------------------------------

SMB1_NorSpr012_Spiny_InitializationRt:
.Main:
SMB1_NorSpr014_RedFlyingCheepCheepGenerator_InitializationRt:
.Main:
SMB1_NorSpr015_BowserFireGenerator_InitializationRt:
.Main:
SMB1_NorSpr016_FireworksGenerator_InitializationRt:
.Main:
SMB1_NorSpr017_BulletBillGenerator_InitializationRt:
.Main:
;$03CBB5
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	STA.w !RAM_SMB1_Level_SpriteToRandomlyGenerate
	SEC
	SBC.b #!Define_SMB1_SpriteID_NorSpr012_Spiny
	ASL
	TAY
	LDA.w DATA_03CBCC,y
	STA.b $04
	LDA.w DATA_03CBCC+$01,y
	STA.b $05
	JMP.w ($0004)

DATA_03CBCC:
	dw CODE_03C768
	dw CODE_03CBD8
	dw CODE_03C870
	dw CODE_03C976
	dw CODE_03CA50
	dw CODE_03CAB1

CODE_03CBD8:
	RTS

;--------------------------------------------------------------------

SMB1_NorSpr018_RemoveGenerators_InitializationRt:
.Main:
;$03CBD9
	LDY.b #$09
CODE_03CBDB:
	LDA.w !RAM_SMB1_NorSpr_SpriteID,y
	CMP.b #!Define_SMB1_SpriteID_NorSpr011_Lakitu
	BNE.b CODE_03CBE7
	LDA.b #$01
	STA.w !RAM_SMB1_NorSpr_SpriteStatusFlags,y
CODE_03CBE7:
	DEY
	BPL.b CODE_03CBDB
	LDA.b #$00
	STA.w !RAM_SMB1_Level_SpriteToRandomlyGenerate
	STA.b !RAM_SMB1_NorSpr_SpriteSlotExistsFlag,x
	RTS

;--------------------------------------------------------------------

SMB1_NorSpr00E_GreenBouncingParakoopa_InitializationRt:
.Main:
;$03CBF2
	LDA.b #$02
	STA.b $47,x
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDA.b #$F6
else
	LDA.b #$F8
endif
	STA.b !RAM_SMB1_NorSpr_XSpeed,x
CODE_03CBFA:
	LDA.b #$03
CODE_03CBFC:
	STA.w !RAM_SMB1_NorSpr_HitboxSizeIndex,x
	RTS

;--------------------------------------------------------------------

SMB1_NorSpr024_PulleyGirderPlatform_InitializationRt:
.Main:
;$03CC00
	DEC.w !RAM_SMB1_NorSpr_YPosLo,x
	DEC.w !RAM_SMB1_NorSpr_YPosLo,x
	LDY.w !RAM_SMB1_Global_UseLateStageSpriteBehaviorFlag
	BNE.b CODE_03CC10
	LDY.b #$02
	JSR.w CODE_03CC95
CODE_03CC10:
	LDY.b #$FF
	LDA.w $03A0
	STA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	BPL.b CODE_03CC1B
	TXA
	TAY
CODE_03CC1B:
	STY.w $03A0
	LDA.b #$00
	STA.b $47,x
	TAY
	JSR.w CODE_03CC95
SMB1_NorSpr029_WeighedDownGirderPlatform_InitializationRt:
.Main:
	LDA.b #$FF
	STA.w $03A2,x
	JMP.w CODE_03CC4D

SMB1_NorSpr028_HorizontalMovingGirderPlatform_InitializationRt:
.Main:
SMB1_NorSpr02A_RightMovingGirderPlatform_InitializationRt:
.Main:
	LDA.b #$00
	STA.b !RAM_SMB1_NorSpr_XSpeed,x
	JMP.w CODE_03CC4D

SMB1_NorSpr025_VerticalMovingGirderPlatform_InitializationRt:
.Main:
	LDY.b #$40
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	BPL.b CODE_03CC43
	EOR.b #$FF
	CLC
	ADC.b #$01
	LDY.b #$C0
CODE_03CC43:
	STA.w $0402,x
	TYA
	CLC
	ADC.w !RAM_SMB1_NorSpr_YPosLo,x
	STA.b !RAM_SMB1_NorSpr_XSpeed,x
CODE_03CC4D:
	JSR.w CODE_03C726
CODE_03CC50:
	LDA.b #$05
	LDY.b !RAM_SMB1_Level_CurrentLevelType
	CPY.b #$03
	BEQ.b CODE_03CC5F
	LDY.w !RAM_SMB1_Global_UseLateStageSpriteBehaviorFlag
	BNE.b CODE_03CC5F
	LDA.b #$06
CODE_03CC5F:
	STA.w !RAM_SMB1_NorSpr_HitboxSizeIndex,x
	RTS

;--------------------------------------------------------------------

SMB1_NorSpr026_ScreenWrappingUpMovingGirderPlatform_InitializationRt:
.Main:
;$03CC63
	JSR.w CODE_03CC6F
	JMP.w CODE_03CC6C

SMB1_NorSpr027_ScreenWrappingDownMovingGirderPlatform_InitializationRt:
.Main:
	JSR.w CODE_03CC7B
CODE_03CC6C:
	JMP.w CODE_03CC50

SMB1_NorSpr02B_UpMovingGirderPlatformLift_InitializationRt:
.Main:
CODE_03CC6F:
	LDA.b #$10
	STA.w !RAM_SMB1_NorSpr_SubYSpeed,x
	LDA.b #$FF
	STA.b !RAM_SMB1_NorSpr_YSpeed,x
	JMP.w CODE_03CC84

SMB1_NorSpr02D_DownMovingGirderPlatformLift_InitializationRt:
.Main:
CODE_03CC7B:
	LDA.b #$F0
	STA.w !RAM_SMB1_NorSpr_SubYSpeed,x
	LDA.b #$00
	STA.b !RAM_SMB1_NorSpr_YSpeed,x
CODE_03CC84:
	LDY.b #$01
	JSR.w CODE_03CC95
	LDA.b #$04
	STA.w !RAM_SMB1_NorSpr_HitboxSizeIndex,x
	RTS

;--------------------------------------------------------------------

DATA_03CC8F:
	db $08,$0C,$F8

DATA_03CC92:
	db $00,$00,$FF

CODE_03CC95:
	LDA.w !RAM_SMB1_NorSpr_XPosLo,x
	CLC
	ADC.w DATA_03CC8F,y
	STA.w !RAM_SMB1_NorSpr_XPosLo,x
	LDA.b !RAM_SMB1_NorSpr_XPosHi,x
	ADC.w DATA_03CC92,y
	STA.b !RAM_SMB1_NorSpr_XPosHi,x
	RTS

;--------------------------------------------------------------------

SMB1_NorSpr036_UnusedSprite_InitializationRt:
.Main:
;$03CCA7
	RTS

;--------------------------------------------------------------------

; Note: Routine that processes normal sprites?

CODE_03CCA8:
	LDX.b $9E
	LDA.b #$00
	LDY.b !RAM_SMB1_NorSpr_SpriteID,x
	CPY.b #!Define_SMB1_SpriteID_NorSpr015_BowserFireGenerator
	BCC.b CODE_03CCB5
	TYA
	SBC.b #!Define_SMB1_SpriteID_NorSpr015_BowserFireGenerator-$01
CODE_03CCB5:
	ASL
	TAY
	LDA.w DATA_03CCC4,y
	STA.b $04
	LDA.w DATA_03CCC4+$01,y
	STA.b $05
	JMP.w ($0004)

DATA_03CCC4:
	dw SMB1_NorSprXXX_Sprites00To14_MainRt_Main
	dw SMB1_NorSpr015_BowserFireGenerator_MainRt_Main
	dw SMB1_NorSpr016_FireworksGenerator_MainRt_Main
	dw SMB1_NorSpr017_BulletBillGenerator_MainRt_Main
	dw SMB1_NorSpr018_RemoveGenerators_MainRt_Main
	dw SMB1_NorSpr019_UnusedSprite_MainRt_Main
	dw SMB1_NorSpr01A_UnusedSprite_MainRt_Main
	dw SMB1_NorSpr01B_SlowClockwiseFirebar_MainRt_Main
	dw SMB1_NorSpr01C_FastClockwiseFirebar_MainRt_Main
	dw SMB1_NorSpr01D_SlowCounterClockwiseFirebar_MainRt_Main
	dw SMB1_NorSpr01E_FastCounterClockwiseFirebar_MainRt_Main
	dw SMB1_NorSpr01F_LargeClockwiseFirebar_MainRt_Main
	dw SMB1_NorSpr020_StationaryFirebar_MainRt_Main
	dw SMB1_NorSpr021_StationaryFirebar_MainRt_Main
	dw SMB1_NorSpr022_StationaryFirebar_MainRt_Main
	dw SMB1_NorSpr023_UnusedSprite_MainRt_Main
	dw SMB1_NorSpr024_PulleyGirderPlatform_MainRt_Main
	dw SMB1_NorSpr025_VerticalMovingGirderPlatform_MainRt_Main
	dw SMB1_NorSpr026_ScreenWrappingUpMovingGirderPlatform_MainRt_Main
	dw SMB1_NorSpr027_ScreenWrappingDownMovingGirderPlatform_MainRt_Main
	dw SMB1_NorSpr028_HorizontalMovingGirderPlatform_MainRt_Main
	dw SMB1_NorSpr029_WeighedDownGirderPlatform_MainRt_Main
	dw SMB1_NorSpr02A_RightMovingGirderPlatform_MainRt_Main
	dw SMB1_NorSpr02B_UpMovingGirderPlatformLift_MainRt_Main
	dw SMB1_NorSpr02D_DownMovingGirderPlatformLift_MainRt_Main
	dw SMB1_NorSpr02D_Bowser_MainRt_Main
	dw SMB1_NorSpr02E_Powerup_MainRt_Main
	dw SMB1_NorSpr02F_Vine_MainRt_Main
	dw SMB1_NorSpr030_Flagpole_MainRt_Main
	dw SMB1_NorSpr031_GoalObject_MainRt_Main
	dw SMB1_NorSpr032_RedSpringboard_MainRt_Main
	dw SMB1_NorSpr033_BulletBillLauncher_MainRt_Main
	dw SMB1_NorSpr034_WarpZone_MainRt_Main
	dw SMB1_NorSpr035_PeachAndToad_MainRt_Main

;--------------------------------------------------------------------

SMB1_NorSpr017_BulletBillGenerator_MainRt:
.Main:
SMB1_NorSpr018_RemoveGenerators_MainRt:
.Main:
SMB1_NorSpr019_UnusedSprite_MainRt:
.Main:
SMB1_NorSpr01A_UnusedSprite_MainRt:
.Main:
SMB1_NorSpr023_UnusedSprite_MainRt:
.Main:
SMB1_NorSpr030_Flagpole_MainRt:
.Main:
SMB1_NorSpr033_BulletBillLauncher_MainRt:
.Main:
;$03CD08
	RTS

;--------------------------------------------------------------------

SMB1_NorSpr035_PeachAndToad_MainRt:
.Main:
;$03CD09
	JSR.w CODE_03FDCB
	JSR.w CODE_03FD39
	JMP.w SMB1_GenericSpriteGraphicsRt_Main

;--------------------------------------------------------------------

SMB1_NorSprXXX_Sprites00To14_MainRt:
.Main:
;$03CD12
	LDA.b #$20
	STA.w $0257,x
	JSR.w CODE_03FDCB
	JSR.w CODE_03FD39
	JSR.w SMB1_GenericSpriteGraphicsRt_Main
	JSR.w CODE_03E9CC
	JSR.w SMB1_HandleNormalSpriteLevelCollision_Main
	JSR.w CODE_03E0C4
	JSR.w CODE_03DE55
	LDY.w !RAM_SMB1_Level_FreezeSpritesTimer
	BNE.b CODE_03CD34
	JSR.w CODE_03CD37
CODE_03CD34:
	JMP.w CODE_03DC03

CODE_03CD37:
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	ASL
	TAY
	LDA.w DATA_03CD48,y
	STA.b $04
	LDA.w DATA_03CD48+$01,y
	STA.b $05
	JMP.w ($0004)

DATA_03CD48:
	dw SMB1_NorSpr000_GreenKoopa_MainRt_Main
	dw SMB1_NorSpr001_RedKoopa_MainRt_Main
	dw SMB1_NorSpr002_BuzzyBeetle_MainRt_Main
	dw SMB1_NorSpr003_RedKoopa_MainRt_Main
	dw SMB1_NorSpr004_StationaryGreenKoopa_MainRt_Main
	dw SMB1_NorSpr005_HammerBro_MainRt_Main
	dw SMB1_NorSpr006_Goomba_MainRt_Main
	dw SMB1_NorSpr007_Blooper_MainRt_Main
	dw SMB1_NorSpr008_BulletBill_MainRt_Main
	dw SMB1_NorSpr009_StationaryYellowParakoopa_MainRt_Main
	dw SMB1_NorSpr00A_GreenSwimmingCheepCheep_MainRt_Main
	dw SMB1_NorSpr00B_RedSwimmingCheepCheep_MainRt_Main
	dw SMB1_NorSpr00C_Podoboo_MainRt_Main
	dw SMB1_NorSpr00D_PiranhaPlant_MainRt_Main 
	dw SMB1_NorSpr00E_GreenBouncingParakoopa_MainRt_Main
	dw SMB1_NorSpr00F_RedVerticalParakoopa_MainRt_Main
	dw SMB1_NorSpr010_GreenHorizontalParakoopa_MainRt_Main
	dw SMB1_NorSpr011_Lakitu_MainRt_Main
	dw SMB1_NorSpr012_Spiny_MainRt_Main
	dw SMB1_NorSpr013_UnknownEnemy_MainRt_Main
	dw SMB1_NorSpr014_RedFlyingCheepCheepGenerator_MainRt_Main

;--------------------------------------------------------------------

SMB1_NorSpr009_StationaryYellowParakoopa_MainRt:
.Main:
SMB1_NorSpr013_UnknownEnemy_MainRt:
.Main:
;$03CD72
	RTS

;--------------------------------------------------------------------

SMB1_NorSpr015_BowserFireGenerator_MainRt:
.Main:
;$03CD73
	JSR.w CODE_03D70B
	JSR.w CODE_03FDCB
	JSR.w CODE_03FD39
	JSR.w CODE_03E9CC
	JSR.w CODE_03DE55
	JMP.w CODE_03DC03

;--------------------------------------------------------------------

SMB1_NorSpr01B_SlowClockwiseFirebar_MainRt:
.Main:
SMB1_NorSpr01C_FastClockwiseFirebar_MainRt:
.Main:
SMB1_NorSpr01D_SlowCounterClockwiseFirebar_MainRt:
.Main:
SMB1_NorSpr01E_FastCounterClockwiseFirebar_MainRt:
.Main:
SMB1_NorSpr01F_LargeClockwiseFirebar_MainRt:
.Main:
SMB1_NorSpr020_StationaryFirebar_MainRt:
.Main:
SMB1_NorSpr021_StationaryFirebar_MainRt:
.Main:
SMB1_NorSpr022_StationaryFirebar_MainRt:
.Main:
;$03CD85
	JSR.w CODE_03D1E1
	JMP.w CODE_03DC03

;--------------------------------------------------------------------

SMB1_NorSpr02B_UpMovingGirderPlatformLift_MainRt:
.Main:
SMB1_NorSpr02D_DownMovingGirderPlatformLift_MainRt:
.Main:
;$03CD8B
	JSR.w CODE_03FDCB
	JSR.w CODE_03FD39
	JSR.w CODE_03E9D5
	JSR.w CODE_03E21E
	JSR.w CODE_03FD39
	JSR.w CODE_03F5B2
	JSR.w CODE_03DBD9
	JMP.w CODE_03DC03

;--------------------------------------------------------------------

SMB1_NorSpr024_PulleyGirderPlatform_MainRt:
.Main:
SMB1_NorSpr025_VerticalMovingGirderPlatform_MainRt:
.Main:
SMB1_NorSpr026_ScreenWrappingUpMovingGirderPlatform_MainRt:
.Main:
SMB1_NorSpr027_ScreenWrappingDownMovingGirderPlatform_MainRt:
.Main:
SMB1_NorSpr028_HorizontalMovingGirderPlatform_MainRt:
.Main:
SMB1_NorSpr029_WeighedDownGirderPlatform_MainRt:
.Main:
SMB1_NorSpr02A_RightMovingGirderPlatform_MainRt:
.Main:
;$03CDA3
	JSR.w CODE_03FDCB
	JSR.w CODE_03FD39
	JSR.w CODE_03EA04
	JSR.w CODE_03E1E7
	LDA.w !RAM_SMB1_Level_FreezeSpritesTimer
	BNE.b CODE_03CDB7
	JSR.w CODE_03CDC0
CODE_03CDB7:
	JSR.w CODE_03FD39
	JSR.w CODE_03EC5E
	JMP.w CODE_03DC03

CODE_03CDC0:
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	SEC
	SBC.b #!Define_SMB1_SpriteID_NorSpr024_PulleyGirderPlatform
	ASL
	TAY
	LDA.w DATA_03CDD4,y
	STA.b $04
	LDA.w DATA_03CDD4+$01,y
	STA.b $05
	JMP.w ($0004)

DATA_03CDD4:
	dw CODE_03D914
	dw CODE_03DB54
	dw CODE_03DBD3
	dw CODE_03DBD3
	dw CODE_03DB8A
	dw CODE_03DBB5
	dw CODE_03DBC1
	
;--------------------------------------------------------------------

CODE_03CDE2:
	STZ.w $07A2,x
CODE_03CDE5:
	CPX.b #$09
	BNE.b CODE_03CE00
	LDA.b #$F0
	STA.w SMB1_OAMBuffer[$78].YDisp
	STA.w SMB1_OAMBuffer[$79].YDisp
	STA.w SMB1_OAMBuffer[$7A].YDisp
	STA.w SMB1_OAMBuffer[$7B].YDisp
	LDA.b $DB
	CMP.b #$22
	BNE.b CODE_03CE00
	STZ.w $0743
CODE_03CE00:
	STZ.b !RAM_SMB1_NorSpr_SpriteSlotExistsFlag,x
	STZ.b !RAM_SMB1_NorSpr_SpriteID,x
	STZ.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	STZ.w !RAM_SMB1_Level_ScoreSpr_SpriteID,x
	STZ.w !RAM_SMB1_Level_NorSpr_KillCounter,x
	STZ.w $0792,x
	STZ.w $03A2,x
	LDA.b #$20
	STA.w $0257,x
	LDA.b #$00
	RTS

;--------------------------------------------------------------------

SMB1_NorSpr00C_Podoboo_MainRt:
.Main:
;$03CE1A
	LDA.w !RAM_SMB3_NorSpr00C_Podoboo_WaitBeforeJumpingTimer,x
	BNE.b CODE_03CE35
	JSR.w CODE_03C6A4
	LDA.w !RAM_SMB1_Global_RandomByte2,x
	ORA.b #$80
	STA.w !RAM_SMB1_NorSpr_SubYSpeed,x
	AND.b #$0F
	ORA.b #$06
	STA.w !RAM_SMB3_NorSpr00C_Podoboo_WaitBeforeJumpingTimer,x
	LDA.b #$F9
	STA.b !RAM_SMB1_NorSpr_YSpeed,x
CODE_03CE35:
	LDA.w !RAM_SMB1_NorSpr_YSpeed,x
	BMI.b CODE_03CE53
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	CMP.b #$C0
	BCC.b CODE_03CE53
	LDA.w $0B00,x
	CMP.b #$02
	BNE.b CODE_03CE53
	INC.w $0B00,x
	STZ.w $0B09,x
	LDA.b #!Define_SMAS_Sound0063_Podoboo
	STA.w !RAM_SMB1_Global_SoundCh3
CODE_03CE53:
	INC.w $0B09,x
	JSL.l CODE_05D614
	JMP.w CODE_03C148

;--------------------------------------------------------------------

DATA_03CE5D:
	db $30,$1C

DATA_03CE5F:
	db $00,$E8,$00,$18

DATA_03CE63:
	db $08,$F8,$0C,$F4

SMB1_NorSpr005_HammerBro_MainRt:
.Main:
;$03CE67
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	AND.b #$20
	BEQ.b CODE_03CE70
	JMP.w CODE_03CF76

CODE_03CE70:
	LDA.w $020F,x						; Note: Jump timer
	BEQ.b CODE_03CEA3
	DEC.w $020F,x
	LDA.w $03D1
	AND.b #$0C
	BNE.b CODE_03CEE9
	LDA.w $03A2,x						; Note: Hammer throw timer
	BNE.b CODE_03CE9B
	LDY.w !RAM_SMB1_Global_UseLateStageSpriteBehaviorFlag
	LDA.w DATA_03CE5D,y
	STA.w $03A2,x
	JSR.w SMB1_SpawnThrownHammerRt_Main
	BCC.b CODE_03CE9B
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	ORA.b #$08
	STA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	JMP.w CODE_03CEE9

CODE_03CE9B:
	DEC.w $03A2,x
	JMP.w CODE_03CEE9

DATA_03CEA1:
	db $20,$37

CODE_03CEA3:
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	AND.b #$07
	CMP.b #$01
	BEQ.b CODE_03CEE9
	STZ.b $00
	LDY.b #$FA
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	BMI.b CODE_03CEC7
	LDY.b #$FD
	CMP.b #$70
	INC.b $00
	BCC.b CODE_03CEC7
	DEC.b $00
	LDA.w !RAM_SMB1_Global_RandomByte2,x
	AND.b #$01
	BNE.b CODE_03CEC7
	LDY.b #$FA
CODE_03CEC7:
	STY.b !RAM_SMB1_NorSpr_YSpeed,x
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	ORA.b #$01
	STA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	LDA.b $00
	AND.w !RAM_SMB1_Global_RandomByte3,x
	TAY
	LDA.w !RAM_SMB1_Global_UseLateStageSpriteBehaviorFlag
	BNE.b CODE_03CEDB
	TAY
CODE_03CEDB:
	LDA.w DATA_03CEA1,y
	STA.w $0792,x
	LDA.w !RAM_SMB1_Global_RandomByte2,x
	ORA.b #$C0
	STA.w $020F,x
CODE_03CEE9:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDY.b #$FB
else
	LDY.b #$FC
endif
	LDA.b !RAM_SMB1_Global_FrameCounter
	AND.b #$40
	BNE.b CODE_03CEF3
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDY.b #$05
else
	LDY.b #$04
endif
CODE_03CEF3:
	STY.b !RAM_SMB1_NorSpr_XSpeed,x
	LDY.b #$01
	JSR.w SMB1_CheckPlayerPositionRelativeToSprite_X
	BMI.b CODE_03CF06
	INY
	LDA.w $07A2,x
	BNE.b CODE_03CF06
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDA.b #$F6
else
	LDA.b #$F8
endif
	STA.b !RAM_SMB1_NorSpr_XSpeed,x
CODE_03CF06:
	STY.b $47,x
SMB1_NorSpr000_GreenKoopa_MainRt:
.Main:
SMB1_NorSpr001_RedKoopa_MainRt:
.Main:
SMB1_NorSpr002_BuzzyBeetle_MainRt:
.Main:
SMB1_NorSpr003_RedKoopa_MainRt:
.Main:
SMB1_NorSpr004_StationaryGreenKoopa_MainRt:
.Main:
SMB1_NorSpr006_Goomba_MainRt:
.Main:
SMB1_NorSpr012_Spiny_MainRt:
.Main:
CODE_03CF08:
	LDY.b #$00
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	AND.b #$40
	BNE.b CODE_03CF29
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	ASL
	BCS.b CODE_03CF45
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	AND.b #$20
	BNE.b CODE_03CF76
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	AND.b #$07
	BEQ.b CODE_03CF45
	CMP.b #$05
	BEQ.b CODE_03CF29
	CMP.b #$03
	BCS.b CODE_03CF59
CODE_03CF29:
	JSR.w CODE_03C11B
	LDY.b #$00
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	CMP.b #$02
	BEQ.b CODE_03CF40
	AND.b #$40
	BEQ.b CODE_03CF45
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr02E_Powerup
	BEQ.b CODE_03CF45
	BNE.b CODE_03CF43					; Note: This will always branch

CODE_03CF40:
	JMP.w CODE_03C0B5

CODE_03CF43:
	LDY.b #$01
CODE_03CF45:
	LDA.b !RAM_SMB1_NorSpr_XSpeed,x
	PHA
	BPL.b CODE_03CF4C
	INY
	INY
CODE_03CF4C:
	CLC
	ADC.w DATA_03CE5F,y
	STA.b !RAM_SMB1_NorSpr_XSpeed,x
	JSR.w CODE_03C0B5
	PLA
	STA.b !RAM_SMB1_NorSpr_XSpeed,x
	RTS

CODE_03CF59:
	LDA.w $07A2,x
	BNE.b CODE_03CF7C
	STA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	LDA.b !RAM_SMB1_Global_FrameCounter
	AND.b #$01
	TAY
	INY
	STY.b $47,x
	DEY
	LDA.w !RAM_SMB1_Global_UseHardModeEnemyBehaviorFlag
	BEQ.b CODE_03CF70
	INY
	INY
CODE_03CF70:
	LDA.w DATA_03CE63,y
	STA.b !RAM_SMB1_NorSpr_XSpeed,x
	RTS

CODE_03CF76:
	JSR.w CODE_03C11B
	JMP.w CODE_03C0B5

CODE_03CF7C:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	CMP.b #$0B
else
	CMP.b #$0E
endif
	BNE.b CODE_03CF89
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr006_Goomba
	BNE.b CODE_03CF89
	JSR.w CODE_03CDE2
CODE_03CF89:
	RTS

;--------------------------------------------------------------------

SMB1_NorSpr00E_GreenBouncingParakoopa_MainRt:
.Main:
;$03CF8A
	JSR.w CODE_03C148
	JMP.w CODE_03C0B5

;--------------------------------------------------------------------

SMB1_NorSpr00F_RedVerticalParakoopa_MainRt:
.Main:
;$03CF90
	LDA.b !RAM_SMB1_NorSpr_YSpeed,x
	ORA.w !RAM_SMB1_NorSpr_SubYSpeed,x
	BNE.b CODE_03CFAC
	STA.w !RAM_SMB1_NorSpr_SubYPos,x
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	CMP.w $0402,x
	BCS.b CODE_03CFAC
	LDA.b !RAM_SMB1_Global_FrameCounter
	AND.b #$07
	BNE.b CODE_03CFAB
	INC.w !RAM_SMB1_NorSpr_YPosLo,x
CODE_03CFAB:
	RTS

CODE_03CFAC:
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	CMP.b !RAM_SMB1_NorSpr_XSpeed,x
	BCC.b CODE_03CFB6
	JMP.w CODE_03C12B

CODE_03CFB6:
	JMP.w CODE_03C127

;--------------------------------------------------------------------

SMB1_NorSpr010_GreenHorizontalParakoopa_MainRt:
.Main:
;$03CFB9
	JSR.w CODE_03CFDB
	JSR.w CODE_03CFFC
	LDY.b #$01
	LDA.b !RAM_SMB1_Global_FrameCounter
	AND.b #$03
	BNE.b CODE_03CFDA
	LDA.b !RAM_SMB1_Global_FrameCounter
	AND.b #$40
	BNE.b CODE_03CFCF
	LDY.b #$FF
CODE_03CFCF:
	STY.b $00
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	CLC
	ADC.b $00
	STA.w !RAM_SMB1_NorSpr_YPosLo,x
CODE_03CFDA:
	RTS

CODE_03CFDB:
	LDA.b #$13
CODE_03CFDD:
	STA.b $01
	LDA.b !RAM_SMB1_Global_FrameCounter
	AND.b #$03
	BNE.b CODE_03CFF2
	LDY.b !RAM_SMB1_NorSpr_XSpeed,x
	LDA.b !RAM_SMB1_NorSpr_YSpeed,x
	LSR
	BCS.b CODE_03CFF6
	CPY.b $01
	BEQ.b CODE_03CFF3
	INC.b !RAM_SMB1_NorSpr_XSpeed,x
CODE_03CFF2:
	RTS

CODE_03CFF3:
	INC.b !RAM_SMB1_NorSpr_YSpeed,x
	RTS

CODE_03CFF6:
	TYA
	BEQ.b CODE_03CFF3
	DEC.b !RAM_SMB1_NorSpr_XSpeed,x
	RTS

CODE_03CFFC:
	LDA.b !RAM_SMB1_NorSpr_XSpeed,x
	PHA
	LDY.b #$01
	LDA.b !RAM_SMB1_NorSpr_YSpeed,x
	AND.b #$02
	BNE.b CODE_03D012
	LDA.b !RAM_SMB1_NorSpr_XSpeed,x
	EOR.b #$FF
	CLC
	ADC.b #$01
	STA.b !RAM_SMB1_NorSpr_XSpeed,x
	LDY.b #$02
CODE_03D012:
	STY.b $47,x
	JSR.w CODE_03C0B5
	STA.b $00
	PLA
	STA.b !RAM_SMB1_NorSpr_XSpeed,x
	RTS

;--------------------------------------------------------------------

DATA_03D01D:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	db $07,$01
else
	db $3F,$03
endif

SMB1_NorSpr007_Blooper_MainRt:
.Main:
;$03D01F
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	AND.b #$20
	BNE.b CODE_03D078
	LDY.w !RAM_SMB1_Global_UseLateStageSpriteBehaviorFlag
	LDA.w !RAM_SMB1_Global_RandomByte2,x
	AND.w DATA_03D01D,y
	BNE.b CODE_03D042
	TXA
	LSR
	BCC.b CODE_03D038
	LDY.b $46
	BCS.b CODE_03D040							; Note: This will always branch.

CODE_03D038:
	LDY.b #$02
	JSR.w SMB1_CheckPlayerPositionRelativeToSprite_X
	BPL.b CODE_03D040
	DEY
CODE_03D040:
	STY.b $47,x
CODE_03D042:
	JSR.w CODE_03D07B
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	SEC
	SBC.w !RAM_SMB1_NorSpr_SubYSpeed,x
	CMP.b #$20
	BCC.b CODE_03D053
	STA.w !RAM_SMB1_NorSpr_YPosLo,x
CODE_03D053:
	LDY.b $47,x
	DEY
	BNE.b CODE_03D068
	LDA.w !RAM_SMB1_NorSpr_XPosLo,x
	CLC
	ADC.b !RAM_SMB1_NorSpr_XSpeed,x
	STA.w !RAM_SMB1_NorSpr_XPosLo,x
	LDA.b !RAM_SMB1_NorSpr_XPosHi,x
	ADC.b #$00
	STA.b !RAM_SMB1_NorSpr_XPosHi,x
	RTS

CODE_03D068:
	LDA.w !RAM_SMB1_NorSpr_XPosLo,x
	SEC
	SBC.b !RAM_SMB1_NorSpr_XSpeed,x
	STA.w !RAM_SMB1_NorSpr_XPosLo,x
	LDA.b !RAM_SMB1_NorSpr_XPosHi,x
	SBC.b #$00
	STA.b !RAM_SMB1_NorSpr_XPosHi,x
	RTS

CODE_03D078:
	JMP.w CODE_03C142

CODE_03D07B:
	LDA.b !RAM_SMB1_NorSpr_YSpeed,x
	AND.b #$02
	BNE.b CODE_03D0B8
	LDA.b !RAM_SMB1_Global_FrameCounter
	AND.b #$07
	PHA
	LDA.b !RAM_SMB1_NorSpr_YSpeed,x
	LSR
	BCS.b CODE_03D0A0
	PLA
	BNE.b CODE_03D09F
	LDA.w !RAM_SMB1_NorSpr_SubYSpeed,x
	CLC
	ADC.b #$01
	STA.w !RAM_SMB1_NorSpr_SubYSpeed,x
	STA.b !RAM_SMB1_NorSpr_XSpeed,x
	CMP.b #$02
	BNE.b CODE_03D09F
	INC.b !RAM_SMB1_NorSpr_YSpeed,x
CODE_03D09F:
	RTS

CODE_03D0A0:
	PLA
	BNE.b CODE_03D0B7
	LDA.w !RAM_SMB1_NorSpr_SubYSpeed,x
	SEC
	SBC.b #$01
	STA.w !RAM_SMB1_NorSpr_SubYSpeed,x
	STA.b !RAM_SMB1_NorSpr_XSpeed,x
	BNE.b CODE_03D0B7
	INC.b !RAM_SMB1_NorSpr_YSpeed,x
	LDA.b #$02
	STA.w !RAM_SMB3_NorSpr007_Blooper_DescendTimer,x
CODE_03D0B7:
	RTS

CODE_03D0B8:
	LDA.w !RAM_SMB3_NorSpr007_Blooper_DescendTimer,x
	BEQ.b CODE_03D0C6
CODE_03D0BD:
	LDA.b !RAM_SMB1_Global_FrameCounter
	LSR
	BCS.b CODE_03D0C5
	INC.w !RAM_SMB1_NorSpr_YPosLo,x
CODE_03D0C5:
	RTS

CODE_03D0C6:
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	ADC.b #$0C
else
	ADC.b #$10
endif
	CMP.w !RAM_SMB1_Player_YPosLo
	BCC.b CODE_03D0BD
	LDA.b #$00
	STA.b !RAM_SMB1_NorSpr_YSpeed,x
	RTS

;--------------------------------------------------------------------

SMB1_NorSpr008_BulletBill_MainRt:
.Main:
;$03D0D5
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	AND.b #$20
	BEQ.b CODE_03D0DE
	JMP.w CODE_03C148

CODE_03D0DE:
	LDA.b #$E8
	STA.b !RAM_SMB1_NorSpr_XSpeed,x
	JMP.w CODE_03C0B5

;--------------------------------------------------------------------

DATA_03D0E5:
	db $40,$80,$04,$04

SMB1_NorSpr00A_GreenSwimmingCheepCheep_MainRt:
.Main:
SMB1_NorSpr00B_RedSwimmingCheepCheep_MainRt:
.Main:
;$03D0E9
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	AND.b #$20
	BEQ.b CODE_03D0F2
	JMP.w CODE_03C142

CODE_03D0F2:
	STA.b $03
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	SEC
	SBC.b #!Define_SMB1_SpriteID_NorSpr00A_GreenSwimmingCheepCheep
	TAY
	LDA.w DATA_03D0E5,y
	STA.b $02
	LDA.w $0402,x
	SEC
	SBC.b $02
	STA.w $0402,x
	LDA.w !RAM_SMB1_NorSpr_XPosLo,x
	SBC.b #$00
	STA.w !RAM_SMB1_NorSpr_XPosLo,x
	LDA.b !RAM_SMB1_NorSpr_XPosHi,x
	SBC.b #$00
	STA.b !RAM_SMB1_NorSpr_XPosHi,x
	LDA.b #$20
	STA.b $02
	CPX.b #$02
	BCC.b CODE_03D16B
	LDA.b !RAM_SMB1_NorSpr_XSpeed,x
	CMP.b #$10
	BCC.b CODE_03D13B
	LDA.w !RAM_SMB1_NorSpr_SubYPos,x
	CLC
	ADC.b $02
	STA.w !RAM_SMB1_NorSpr_SubYPos,x
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	ADC.b $03
	STA.w !RAM_SMB1_NorSpr_YPosLo,x
	LDA.b !RAM_SMB1_NorSpr_YPosHi,x
	ADC.b #$00
	BRA.b CODE_03D150

CODE_03D13B:
	LDA.w !RAM_SMB1_NorSpr_SubYPos,x
	SEC
	SBC.b $02
	STA.w !RAM_SMB1_NorSpr_SubYPos,x
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	SBC.b $03
	STA.w !RAM_SMB1_NorSpr_YPosLo,x
	LDA.b !RAM_SMB1_NorSpr_YPosHi,x
	SBC.b #$00
CODE_03D150:
	STA.b !RAM_SMB1_NorSpr_YPosHi,x
	LDY.b #$00
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	SEC
	SBC.w !RAM_SMB1_NorSpr_SubYSpeed,x
	BPL.b CODE_03D164
	LDY.b #$10
	EOR.b #$FF
	CLC
	ADC.b #$01
CODE_03D164:
	CMP.b #$0F
	BCC.b CODE_03D16B
	TYA
	STA.b !RAM_SMB1_NorSpr_XSpeed,x
CODE_03D16B:
	RTS

;--------------------------------------------------------------------

DATA_03D16C:
	db $00,$01,$03,$04,$05,$06,$07,$07,$08,$00,$03,$06,$09,$0B,$0D,$0E
	db $0F,$10,$00,$04,$09,$0D,$10,$13,$16,$17,$18,$00,$06,$0C,$12,$16
	db $1A,$1D,$1F,$20,$00,$07,$0F,$16,$1C,$21,$25,$27,$28,$00,$09,$12
	db $1B,$21,$27,$2C,$2F,$30,$00,$0B,$15,$1F,$27,$2E,$33,$37,$38,$00
	db $0C,$18,$24,$2D,$35,$3B,$3E,$40,$00,$0E,$1B,$28,$32,$3B,$42,$46
	db $48,$00,$0F,$1F,$2D,$38,$42,$4A,$4E,$50,$00,$11,$22,$31,$3E,$49
	db $51,$56,$58

DATA_03D1CF:
	db $01,$03,$02,$00

DATA_03D1D3:
	db $00,$09,$12,$1B,$24,$2D,$36,$3F
	db $48,$51,$5A,$63

DATA_03D1DF:
	db $0C,$18

;--------------------------------------------------------------------

CODE_03D1E1:
	JSR.w CODE_03FDCB
	LDA.w $03D1
	AND.b #$08
	BNE.b CODE_03D25D
	LDA.w !RAM_SMB1_Level_FreezeSpritesTimer
	BNE.b CODE_03D1FA
	LDA.w $0388,x
	JSR.w CODE_03D8F1
	AND.b #$1F
	STA.b !RAM_SMB1_NorSpr_YSpeed,x
CODE_03D1FA:
	LDA.b !RAM_SMB1_NorSpr_YSpeed,x
	LDY.b !RAM_SMB1_NorSpr_SpriteID,x
	CPY.b #!Define_SMB1_SpriteID_NorSpr01F_LargeClockwiseFirebar
	BCC.b CODE_03D20F
	CMP.b #$08
	BEQ.b CODE_03D20A
	CMP.b #$18
	BNE.b CODE_03D20F
CODE_03D20A:
	CLC
	ADC.b #$01
	STA.b !RAM_SMB1_NorSpr_YSpeed,x
CODE_03D20F:
	STA.b !RAM_SMB1_Global_ScratchRAMEF
	JSR.w CODE_03FD39
	JSR.w CODE_03D346
	LDY.w !RAM_SMB1_Level_SpriteOAMIndexTable+$01,x
	LDA.w $03B9
	STA.w SMB1_OAMBuffer[$40].YDisp,y
	STA.b $07
	LDA.w $03AE
	STA.w SMB1_OAMBuffer[$40].XDisp,y
	STA.b $06
	LDA.b #$01
	STA.b $00
	JSR.w CODE_03D2BB
	LDY.b #$05
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr01F_LargeClockwiseFirebar
	BCC.b CODE_03D23B
	LDY.b #$0B
CODE_03D23B:
	STY.b !RAM_SMB1_Global_ScratchRAMED
	STZ.b $00
CODE_03D23F:
	LDA.b !RAM_SMB1_Global_ScratchRAMEF
	JSR.w CODE_03D346
	JSR.w CODE_03D25E
	LDA.b $00
	CMP.b #$04
	BNE.b CODE_03D255
	LDY.w $06CF
	LDA.w !RAM_SMB1_Level_SpriteOAMIndexTable+$01,y
	STA.b $06
CODE_03D255:
	INC.b $00
	LDA.b $00
	CMP.b !RAM_SMB1_Global_ScratchRAMED
	BCC.b CODE_03D23F
CODE_03D25D:
	RTS

CODE_03D25E:
	LDA.b $03
	STA.b $05
	LDY.b $06
	LDA.b $01
	LSR.b $05
	BCS.b CODE_03D26E
	EOR.b #$FF
	ADC.b #$01
CODE_03D26E:
	CLC
	ADC.w $03AE
	STA.w SMB1_OAMBuffer[$40].XDisp,y
	STA.b $06
	CMP.w $03AE
	BCS.b CODE_03D285
	LDA.w $03AE
	SEC
	SBC.b $06
	JMP.w CODE_03D289

CODE_03D285:
	SEC
	SBC.w $03AE
CODE_03D289:
	CMP.b #$59
	BCC.b CODE_03D291
	LDA.b #$F8
	BNE.b CODE_03D2A6
CODE_03D291:
	LDA.w $03B9
	CMP.b #$F8
	BEQ.b CODE_03D2A6
	LDA.b $02
	LSR.b $05
	BCS.b CODE_03D2A2
	EOR.b #$FF
	ADC.b #$01
CODE_03D2A2:
	CLC
	ADC.w $03B9
CODE_03D2A6:
	STA.w SMB1_OAMBuffer[$40].YDisp,y
	STA.b $07
	CMP.b #$F0
	BCC.b CODE_03D2B6
	LDA.b #$01
	STA.w SMB1_OAMTileSizeBuffer[$40].Slot,y
	BRA.b CODE_03D2BB

CODE_03D2B6:
	LDA.b #$00
	STA.w SMB1_OAMTileSizeBuffer[$40].Slot,y
CODE_03D2BB:
	JSR.w CODE_03F48B
	TYA
	PHA
	LDA.w !RAM_SMB1_Player_StarPowerTimer
	ORA.w !RAM_SMB1_Level_FreezeSpritesTimer
	BNE.b CODE_03D33D
	STA.b $05
	LDY.b !RAM_SMB1_Player_YPosHi
	DEY
	BNE.b CODE_03D33D
	LDY.w !RAM_SMB1_Player_YPosLo
	LDA.w !RAM_SMB1_Player_CurrentSize
	BNE.b CODE_03D2DC
	LDA.w !RAM_SMB1_Level_Player_IsDuckingFlag
	BEQ.b CODE_03D2E5
CODE_03D2DC:
	INC.b $05
	INC.b $05
	TYA
	CLC
	ADC.b #$18
	TAY
CODE_03D2E5:
	TYA
CODE_03D2E6:
	SEC
	SBC.b $07
	BPL.b CODE_03D2F0
	EOR.b #$FF
	CLC
	ADC.b #$01
CODE_03D2F0:
	CMP.b #$08
	BCS.b CODE_03D310
	LDA.b $06
	CMP.b #$F0
	BCS.b CODE_03D310
	LDA.w $03AD
	CLC
	ADC.b #$04
	STA.b $04
	SEC
	SBC.b $06
	BPL.b CODE_03D30C
	EOR.b #$FF
	CLC
	ADC.b #$01
CODE_03D30C:
	CMP.b #$08
	BCC.b CODE_03D324
CODE_03D310:
	LDA.b $05
	CMP.b #$02
	BEQ.b CODE_03D33D
	LDY.b $05
	LDA.w !RAM_SMB1_Player_YPosLo
	CLC
	ADC.w DATA_03D1DF,y
	INC.b $05
	JMP.w CODE_03D2E6

CODE_03D324:
	LDX.b #$01
	LDA.b $04
	CMP.b $06
	BCS.b CODE_03D32D
	INX
CODE_03D32D:
	TXA
	LDX.b $9E
	STA.b $47
	LDX.b #$00
	LDA.b $00
	PHA
	JSR.w CODE_03DF4D
	PLA
	STA.b $00
CODE_03D33D:
	PLA
	CLC
	ADC.b #$04
	STA.b $06
	LDX.b $9E
	RTS

;--------------------------------------------------------------------

CODE_03D346:
	PHA
	AND.b #$0F
	CMP.b #$09
	BCC.b CODE_03D352
	EOR.b #$0F
	CLC
	ADC.b #$01
CODE_03D352:
	STA.b $01
	LDY.b $00
	LDA.w DATA_03D1D3,y
	CLC
	ADC.b $01
	TAY
	LDA.w DATA_03D16C,y
	STA.b $01
	PLA
	PHA
	CLC
	ADC.b #$08
	AND.b #$0F
	CMP.b #$09
	BCC.b CODE_03D372
	EOR.b #$0F
	CLC
	ADC.b #$01
CODE_03D372:
	STA.b $02
	LDY.b $00
	LDA.w DATA_03D1D3,y
	CLC
	ADC.b $02
	TAY
	LDA.w DATA_03D16C,y
	STA.b $02
	PLA
	LSR
	LSR
	LSR
	TAY
	LDA.w DATA_03D1CF,y
	STA.b $03
	RTS

;--------------------------------------------------------------------

if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) == $00
DATA_03D38D:
	db $F8,$A0,$70,$BD,$00

DATA_03D392:
	db $00,$00,$00,$20,$20
endif

SMB1_NorSpr014_RedFlyingCheepCheepGenerator_MainRt:
.Main:
;$03D397
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDY.b #$20
endif
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	AND.b #$20
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	BNE.b +
	JSR.w CODE_03C0B5
	LDY.b #$17
+:
	LDA.b #$05
	JMP.w CODE_03C14C
else
	BEQ.b CODE_03D3A5
	LDA.b #$20
	STA.w $0257,x
	JMP.w CODE_03C148

CODE_03D3A5:
	JSR.w CODE_03C0B5
	LDY.b #$0D
	LDA.b #$05
	JSR.w CODE_03C14C
	LDA.w !RAM_SMB1_NorSpr_SubYSpeed,x
	LSR
	LSR
	LSR
	LSR
	TAY
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	SEC
	SBC.w DATA_03D38D,y
	BPL.b CODE_03D3C5
	EOR.b #$FF
	CLC
	ADC.b #$01
CODE_03D3C5:
	CMP.b #$08
	BCS.b CODE_03D3D4
	LDA.w !RAM_SMB1_NorSpr_SubYSpeed,x
	CLC
	ADC.b #$10
	LSR
	LSR
	LSR
	LSR
	TAY
CODE_03D3D4:
	LDA.w DATA_03D392,y
	STA.w $0257,x
	RTS
endif

;--------------------------------------------------------------------

CODE_03D3DB:
	db $15,$30,$40

SMB1_NorSpr011_Lakitu_MainRt:
.Main:
;$03D3DE
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	AND.b #$20
	BEQ.b CODE_03D3E7
	JMP.w CODE_03C11B

CODE_03D3E7:
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	BEQ.b CODE_03D3F4
	STZ.b !RAM_SMB1_NorSpr_YSpeed,x
	STZ.w !RAM_SMB1_Level_SpriteToRandomlyGenerate
	LDA.b #$10
	BNE.b CODE_03D407

CODE_03D3F4:
	LDA.b #$12
	STA.w !RAM_SMB1_Level_SpriteToRandomlyGenerate
	LDY.b #$02
CODE_03D3FB:
	LDA.w CODE_03D3DB,y
	STA.w $0001,y
	DEY
	BPL.b CODE_03D3FB
	JSR.w CODE_03D420
CODE_03D407:
	STA.b !RAM_SMB1_NorSpr_XSpeed,x
	LDY.b #$01
	LDA.b !RAM_SMB1_NorSpr_YSpeed,x
	AND.b #$01
	BNE.b CODE_03D41B
	LDA.b !RAM_SMB1_NorSpr_XSpeed,x
	EOR.b #$FF
	CLC										;\ Optimization: INC?
	ADC.b #$01									;/
	STA.b !RAM_SMB1_NorSpr_XSpeed,x
	INY
CODE_03D41B:
	STY.b $47,x
	JMP.w CODE_03C0B5

CODE_03D420:
	LDY.b #$00
	JSR.w SMB1_CheckPlayerPositionRelativeToSprite_X
	BPL.b CODE_03D431
	INY
	LDA.b $00
	EOR.b #$FF
	CLC										;\ Optimization: INC?
	ADC.b #$01									;/
	STA.b $00
CODE_03D431:
	LDA.b $00
	CMP.b #$3C
	BCC.b CODE_03D453
	LDA.b #$3C
	STA.b $00
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr011_Lakitu
	BNE.b CODE_03D453
	TYA
	CMP.b !RAM_SMB1_NorSpr_YSpeed,x
	BEQ.b CODE_03D453
	LDA.b !RAM_SMB1_NorSpr_YSpeed,x
	BEQ.b CODE_03D450
	DEC.b !RAM_SMB1_NorSpr_XSpeed,x
	LDA.b !RAM_SMB1_NorSpr_XSpeed,x
	BNE.b CODE_03D490
CODE_03D450:
	TYA
	STA.b !RAM_SMB1_NorSpr_YSpeed,x
CODE_03D453:
	LDA.b $00
	AND.b #$3C
	LSR
	LSR
	STA.b $00
	LDY.b #$00
	LDA.b !RAM_SMB1_Player_XSpeed
	BEQ.b CODE_03D485
	LDA.w $0775
	BEQ.b CODE_03D485
	INY
	LDA.b !RAM_SMB1_Player_XSpeed
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	CMP.b #$1D
else
	CMP.b #$19
endif
	BCC.b CODE_03D475
	LDA.w $0775
	CMP.b #$02
	BCC.b CODE_03D475
	INY
CODE_03D475:
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr012_Spiny
	BNE.b CODE_03D47F
	LDA.b !RAM_SMB1_Player_XSpeed
	BNE.b CODE_03D485
CODE_03D47F:
	LDA.b !RAM_SMB1_NorSpr_YSpeed,x
	BNE.b CODE_03D485
	LDY.b #$00
CODE_03D485:
	LDA.w $0001,y
	LDY.b $00
CODE_03D48A:
	SEC
	SBC.b #$01
	DEY
	BPL.b CODE_03D48A
CODE_03D490:
	RTS

;--------------------------------------------------------------------

; Note: Bowser bridge destruction routine?

DATA_03D491:
	db $1A,$58,$98,$96,$94,$92,$90,$8E
	db $8C,$8A,$88,$86,$84,$82,$80

SMB1_InitializeBridgeSegmentSprite:
.Main:
	PHX
	LDX.w !RAM_SMB1_NorSpr02D_Bowser_NumberOfBrokenBridgeSegments
	DEX
	DEX
	STX.w !RAM_SMB1_NorSpr02D_Bowser_UnusedBridgeSegmentIndex
	AND.b #$80
	BEQ.b CODE_03D4CE
	STZ.w !RAM_SMB1_Level_BridgeSpr_AnimationFrame,x
	LDA.b #$01
	STA.w !RAM_SMB1_Level_BridgeSpr_SpriteSlotExistsFlag,x
	LDA.b $04
	AND.b #$1F
	ASL
	ASL
	ASL
	STA.b !RAM_SMB1_Global_ScratchRAME4
	LDA.b #$00
	SEC
	SBC.b $42
	CLC
	ADC.b !RAM_SMB1_Global_ScratchRAME4
	STA.w !RAM_SMB1_Level_BridgeSpr_XPosLo,x
	LDA.b #$03
	STA.w !RAM_SMB1_Level_BridgeSpr_AnimationFrameTimer,x
CODE_03D4CE:
	PLX
	RTS

SMB1_ToadCutscene_State00_BridgeDestruction:
.Main:
SMB1_PeachCutscene_State00_BridgeDestruction:
.Main:
;$03D4D0
	LDX.w $0368
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr02D_Bowser
	BNE.b CODE_03D4EA
	STX.b $9E
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	BEQ.b CODE_03D503
	AND.b #$40
	BEQ.b CODE_03D4EA
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	CMP.b #$E0
	BCC.b CODE_03D4FD
CODE_03D4EA:
	LDA.w $0095
	BNE.b CODE_03D4F7
	LDA.b #!Define_SMB1_LevelMusic_PassedBoss
	STA.w !RAM_SMB1_Global_MusicCh1
	STA.w $0095
CODE_03D4F7:
	INC.w !RAM_SMB1_Cutscene_CurrentState
	JMP.w CODE_03D56B

CODE_03D4FD:
	JSR.w CODE_03C142
	JMP.w CODE_03D679

CODE_03D503:
	DEC.w !RAM_SMB1_NorSpr02D_Bowser_WaitBeforeBreakingNextBridgeSegment
	BNE.b CODE_03D557
	LDA.b #$04
	STA.w !RAM_SMB1_NorSpr02D_Bowser_WaitBeforeBreakingNextBridgeSegment
	LDA.w $0363
	EOR.b #$01
	STA.w $0363
	LDA.b #$02
	STA.b $05
	LDY.w !RAM_SMB1_NorSpr02D_Bowser_NumberOfBrokenBridgeSegments
	LDA.w DATA_03D491,y
	STA.b $04
	JSR.w SMB1_InitializeBridgeSegmentSprite_Main
	LDY.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	INY
	LDX.b #$18
	JSR.w CODE_039400
	LDX.b $9E
	JSR.w CODE_0393BF
	LDA.b #!Define_SMAS_Sound0063_CastleCollapse
	STA.w !RAM_SMB1_Global_SoundCh3
	LDA.w !RAM_SMB1_NorSpr02D_Bowser_NumberOfBrokenBridgeSegments
	BNE.b CODE_03D546
	LDA.b #$08
	STA.w $014B
	LDA.b #$FF
	STA.w $0F4C
CODE_03D546:
	INC.w !RAM_SMB1_NorSpr02D_Bowser_NumberOfBrokenBridgeSegments
	LDA.w !RAM_SMB1_NorSpr02D_Bowser_NumberOfBrokenBridgeSegments
	CMP.b #$0F
	BNE.b CODE_03D557
	JSR.w CODE_03C726
	LDA.b #$40
	STA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
CODE_03D557:
	JMP.w CODE_03D679

;--------------------------------------------------------------------

DATA_03D55A:
	db $21,$41,$11,$31

SMB1_NorSpr02D_Bowser_MainRt:
.Main:
;$03D55E
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	AND.b #$20
	BEQ.b CODE_03D579
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	CMP.b #$E0
	BCC.b CODE_03D4FD
CODE_03D56B:
	LDX.b #$08
CODE_03D56D:
	JSR.w CODE_03CDE2
	DEX
	BPL.b CODE_03D56D
	STA.w !RAM_SMB1_Level_SpriteToRandomlyGenerate
	LDX.b $9E
	RTS

CODE_03D579:
	STZ.w !RAM_SMB1_Level_SpriteToRandomlyGenerate
	LDA.w !RAM_SMB1_Level_FreezeSpritesTimer
	BEQ.b CODE_03D584
	JMP.w CODE_03D636

CODE_03D584:
	LDA.w $0363
	BPL.b CODE_03D58C
	JMP.w CODE_03D60B

CODE_03D58C:
	DEC.w !RAM_SMB1_NorSpr02D_Bowser_WaitBeforeBreakingNextBridgeSegment
	BNE.b CODE_03D59E
	LDA.b #$20
	STA.w !RAM_SMB1_NorSpr02D_Bowser_WaitBeforeBreakingNextBridgeSegment
	LDA.w $0363
	EOR.b #$01
	STA.w $0363
CODE_03D59E:
	LDA.b !RAM_SMB1_Global_FrameCounter
	AND.b #$0F
	BNE.b CODE_03D5A8
	LDA.b #$02
	STA.b $47,x
CODE_03D5A8:
	LDA.w !RAM_SMB1_NorSpr02D_Bowser_WaitBeforeNextJump,x
	BEQ.b CODE_03D5CA
	JSR.w SMB1_CheckPlayerPositionRelativeToSprite_X
	BPL.b CODE_03D5CA
	LDA.b #$01
	STA.b $47,x
	LDA.b #$02
	STA.w !RAM_SMB1_NorSpr02D_Bowser_XAcceleration
	LDA.b #$20
	STA.w !RAM_SMB1_NorSpr02D_Bowser_WaitBeforeNextJump,x
	STA.w $079C
	LDA.w !RAM_SMB1_NorSpr_XPosLo,x
	CMP.b #$B0
	BCS.b CODE_03D60B
CODE_03D5CA:
	LDA.b !RAM_SMB1_Global_FrameCounter
	AND.b #$03
	BNE.b CODE_03D60B
	LDA.w !RAM_SMB1_NorSpr_XPosLo,x
	CMP.w !RAM_SMB1_NorSpr02D_Bowser_InitialXPosLo
	BNE.b CODE_03D5E4
	LDA.w !RAM_SMB1_Global_RandomByte1,x
	AND.b #$03
	TAY
	LDA.w DATA_03D55A,y
	STA.w $06DC
CODE_03D5E4:
	LDA.w !RAM_SMB1_NorSpr_XPosLo,x
	CLC
	ADC.w !RAM_SMB1_NorSpr02D_Bowser_XAcceleration
	STA.w !RAM_SMB1_NorSpr_XPosLo,x
	LDY.b $47,x
	CPY.b #$01
	BEQ.b CODE_03D60B
	LDY.b #$FF
	SEC
	SBC.w !RAM_SMB1_NorSpr02D_Bowser_InitialXPosLo
	BPL.b CODE_03D603
	EOR.b #$FF
	CLC
	ADC.b #$01
	LDY.b #$01
CODE_03D603:
	CMP.w $06DC
	BCC.b CODE_03D60B
	STY.w !RAM_SMB1_NorSpr02D_Bowser_XAcceleration
CODE_03D60B:
	LDA.w !RAM_SMB1_NorSpr02D_Bowser_WaitBeforeNextJump,x
	BNE.b CODE_03D639
	JSR.w CODE_03C142
	LDA.w !RAM_SMB1_Player_CurrentWorld
	CMP.b #$05
	BCC.b CODE_03D623
	LDA.b !RAM_SMB1_Global_FrameCounter
	AND.b #$03
	BNE.b CODE_03D623
	JSR.w SMB1_SpawnThrownHammerRt_Main
CODE_03D623:
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x				;\ Note: Bowser doesn't have normal level collision it seems.
	CMP.b #$80						;|
	BCC.b CODE_03D647					;/
	LDA.w !RAM_SMB1_Global_RandomByte1,x
	AND.b #$03
	TAY
	LDA.w DATA_03D55A,y
	STA.w !RAM_SMB1_NorSpr02D_Bowser_WaitBeforeNextJump,x
CODE_03D636:
	JMP.w CODE_03D647

CODE_03D639:
	CMP.b #$01
	BNE.b CODE_03D647
	DEC.w !RAM_SMB1_NorSpr_YPosLo,x
	JSR.w CODE_03C726
	LDA.b #$FE
	STA.b !RAM_SMB1_NorSpr_YSpeed,x
CODE_03D647:
	LDA.w !RAM_SMB1_Player_CurrentWorld
	CMP.b #$07
	BEQ.b CODE_03D652
	CMP.b #$05
	BCS.b CODE_03D679
CODE_03D652:
	LDA.w $079C
	BNE.b CODE_03D679
	LDA.b #$20
	STA.w $079C
	LDA.w $0363
	EOR.b #$80
	STA.w $0363
	BMI.b CODE_03D647
	JSR.w CODE_03D6F9
	LDY.w !RAM_SMB1_Global_UseLateStageSpriteBehaviorFlag
	BEQ.b CODE_03D671
	SEC
	SBC.b #$10
CODE_03D671:
	STA.w $079C
	LDA.b #$15
	STA.w !RAM_SMB1_Level_SpriteToRandomlyGenerate
CODE_03D679:
	JSR.w CODE_03D6D4
	LDY.b #$10
	LDA.b $47,x
	LSR
	BCC.b CODE_03D685
	LDY.b #$F0
CODE_03D685:
	TYA
	CLC
	ADC.w !RAM_SMB1_NorSpr_XPosLo,x
	LDY.w $06CF
	STA.w !RAM_SMB1_NorSpr_XPosLo,y
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	CLC
	ADC.b #$08
	STA.w !RAM_SMB1_NorSpr_YPosLo,y
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	STA.w !RAM_SMB1_NorSpr_SpriteStatusFlags,y
	LDA.b $47,x
	STA.w $0047,y
	LDA.b $9E
	PHA
	LDX.w $06CF
	STX.b $9E
	LDA.b $97
	BNE.b CODE_03D6C1
	LDA.w !RAM_SMB1_Player_CurrentWorld
	CMP.b #$07
	BNE.b CODE_03D6BA
	LDA.b #!Define_SMB1_LevelMusic_FinalBowserBattle
	BRA.b CODE_03D6BC

CODE_03D6BA:
	LDA.b #!Define_SMB1_LevelMusic_BowserBattle
CODE_03D6BC:
	STA.w !RAM_SMB1_Global_MusicCh1
	STA.b $97
CODE_03D6C1:
	LDA.b #!Define_SMB1_SpriteID_NorSpr02D_Bowser
	STA.b !RAM_SMB1_NorSpr_SpriteID,x
	LDA.b #$20
	STA.w $0257,x
	PLA
	STA.b $9E
	TAX
	LDA.b #$00
	STA.w $036A
CODE_03D6D3:
	RTS

CODE_03D6D4:
	INC.w $036A
	JSR.w SMB1_NorSpr035_PeachAndToad_MainRt_Main
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	BNE.b CODE_03D6D3
	LDA.b #$0A
	STA.w !RAM_SMB1_NorSpr_HitboxSizeIndex,x
	JSR.w CODE_03E9CC
	LDA.w !RAM_SMB1_Global_GameMode
	CMP.b #$02
	BEQ.b CODE_03D6F0
	JMP.w CODE_03DE55

CODE_03D6F0:
	RTS

;--------------------------------------------------------------------

DATA_03D6F1:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	db $80,$30,$30,$80,$80,$80,$30,$50
else
	db $BF,$40,$BF,$BF,$BF,$40,$40,$BF
endif

CODE_03D6F9:
	LDY.w $0367
	INC.w $0367
	LDA.w $0367
	AND.b #$07
	STA.w $0367
	LDA.w DATA_03D6F1,y
CODE_03D70A:
	RTS

;--------------------------------------------------------------------

CODE_03D70B:
	CPX.w $0F4D
	BNE.b CODE_03D71C
	LDA.w $0F4C
	BEQ.b CODE_03D71C
	LDA.w $014B
	CMP.b #$06
	BEQ.b CODE_03D760
CODE_03D71C:
	LDA.w !RAM_SMB1_Level_FreezeSpritesTimer
	BNE.b CODE_03D755
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDA.b #$70
else
	LDA.b #$40
endif
	LDY.w !RAM_SMB1_Global_UseLateStageSpriteBehaviorFlag
	BEQ.b CODE_03D72A
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDA.b #$90
else
	LDA.b #$60
endif
CODE_03D72A:
	STA.b $00
	LDA.w $0402,x
	SEC
	SBC.b $00
	STA.w $0402,x
	LDA.w !RAM_SMB1_NorSpr_XPosLo,x
	SBC.b #$01
	STA.w !RAM_SMB1_NorSpr_XPosLo,x
	LDA.b !RAM_SMB1_NorSpr_XPosHi,x
	SBC.b #$00
	STA.b !RAM_SMB1_NorSpr_XPosHi,x
	LDY.w !RAM_SMB1_NorSpr_SubYPos,x
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	CMP.w DATA_03C970,y
	BEQ.b CODE_03D755
	CLC
	ADC.w !RAM_SMB1_NorSpr_SubYSpeed,x
	STA.w !RAM_SMB1_NorSpr_YPosLo,x
CODE_03D755:
	JSR.w CODE_03FD39
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	BNE.b CODE_03D70A				; Note: Why use the RTS from an unrelated routine when there is an RTS further down?
	JSL.l CODE_05CD01
CODE_03D760:
	RTS

;--------------------------------------------------------------------

SMB1_NorSpr016_FireworksGenerator_MainRt:
.Main:
;$03D761
	DEC.b !RAM_SMB1_NorSpr_YSpeed,x
	BNE.b CODE_03D77C
	LDA.b #$08
	STA.b !RAM_SMB1_NorSpr_YSpeed,x
	INC.b !RAM_SMB1_NorSpr_XSpeed,x
	LDA.b !RAM_SMB1_NorSpr_XSpeed,x
	CMP.b #$01
	BNE.b CODE_03D778
	LDA.b #!Define_SMAS_Sound0060_LouderFireworksBang
	STA.w !RAM_SMB1_Global_SoundCh1
	BRA.b CODE_03D77C

CODE_03D778:
	CMP.b #$04
	BCS.b CODE_03D794
CODE_03D77C:
	JSR.w CODE_03FD39
	LDA.w $03B9
	STA.w $03BA
	LDA.w $03AE
	STA.w $03AF
	LDY.w !RAM_SMB1_Level_SpriteOAMIndexTable+$01,x
	LDA.b !RAM_SMB1_NorSpr_XSpeed,x
	JSR.w CODE_03F548
	RTS

CODE_03D794:
	STZ.b !RAM_SMB1_NorSpr_SpriteSlotExistsFlag,x
	LDY.w !RAM_SMB1_Level_SpriteOAMIndexTable+$01,x
	LDA.b #$03
	STA.w SMB1_OAMTileSizeBuffer[$40].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$41].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$42].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$43].Slot,y
	LDA.b #$05
	STA.w $0149
	JMP.w CODE_03D818

;--------------------------------------------------------------------

SMB1_NorSpr031_GoalObject_MainRt:
.Main:
;$03D7AF
	STZ.w !RAM_SMB1_Level_SpriteToRandomlyGenerate
	LDA.w $0746
	CMP.b #$05
	BCS.b CODE_03D7F3
	JSR.w CODE_039B15

DATA_03D7BC:
	dw CODE_03D7F3
	dw CODE_03D7C6
	dw CODE_03D7FE
	dw CODE_03D830
	dw CODE_03D883

CODE_03D7C6:
	LDY.b #$05
	LDA.w !RAM_SMB1_Level_TimerOnes
	CMP.b #$01
	BEQ.b CODE_03D7DD
	LDY.b #$03
	CMP.b #$03
	BEQ.b CODE_03D7DD
	LDY.b #$00
	CMP.b #$06
	BEQ.b CODE_03D7DD
	LDA.b #$FF
CODE_03D7DD:
	STA.w $06D7
	STY.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	LDA.w !REGISTER_APUPort3
	AND.b #$7F
	CMP.b #!Define_SMAS_Sound0063_AddTimerToScore
	BEQ.b CODE_03D7F0
	LDA.b #!Define_SMAS_Sound0063_AddTimerToScore
	STA.w !RAM_SMB1_Global_SoundCh3
CODE_03D7F0:
	INC.w $0746
CODE_03D7F3:
	RTS

CODE_03D7F4:
	LDA.b #!Define_SMAS_Sound0063_FinishAddTimerToScore
	STA.w !RAM_SMB1_Global_SoundCh3
	STA.w $0E1A
	BRA.b CODE_03D7F0

CODE_03D7FE:
	LDA.w !RAM_SMB1_Level_TimerHundreds
	ORA.w !RAM_SMB1_Level_TimerTens
	ORA.w !RAM_SMB1_Level_TimerOnes
	BEQ.b CODE_03D7F4
CODE_03D809:
	LDY.b #$23
	LDA.b #$FF
	STA.w $014A
	JSR.w CODE_039D06
	LDA.b #$05
	STA.w $014A
CODE_03D818:
	LDY.b #$0B
	LDA.w !RAM_SMB1_Player_CurrentCharacter
	BEQ.b CODE_03D821
	LDY.b #$11
CODE_03D821:
	JSR.w CODE_039D06
	LDA.w !RAM_SMB1_Player_CurrentCharacter
	ASL
	ASL
	ASL
	ASL
	ORA.b #$04
	JMP.w CODE_03BD6C

CODE_03D830:
	LDA.b #$01
	STA.b !RAM_SMB1_Global_DisableSpriteOAMResetFlag
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	CMP.b #$72
	BCC.b CODE_03D840
	DEC.w !RAM_SMB1_NorSpr_YPosLo,x
	BRA.b CODE_03D84C

CODE_03D840:
	LDA.w $06D7
	BEQ.b CODE_03D877
	BMI.b CODE_03D877
	LDA.b #$16
	STA.w !RAM_SMB1_Level_SpriteToRandomlyGenerate
CODE_03D84C:
	JSR.w CODE_03FD39
	LDY.w !RAM_SMB1_Level_SpriteOAMIndexTable+$01,x
	LDA.w $03B9
	STA.w SMB1_OAMBuffer[$40].YDisp,y
	LDA.b !RAM_SMB1_Global_FrameCounter
	AND.b #$18
	LSR
	LSR
	CLC
	ADC.b #$04
	STA.w SMB1_OAMBuffer[$40].Tile,y
	LDA.b #$0B
	STA.w SMB1_OAMBuffer[$40].Prop,y
	LDA.w $03AE
	STA.w SMB1_OAMBuffer[$40].XDisp,y
	LDA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$40].Slot,y
	LDX.b $9E
	RTS

CODE_03D877:
	JSR.w CODE_03D84C
	LDA.b #$06
	STA.w $07A2,x
CODE_03D87F:
	INC.w $0746
	RTS

CODE_03D883:
	JSR.w CODE_03D84C
	LDA.w $07A2,x
	BNE.b CODE_03D890
	LDA.w $07B1
	BEQ.b CODE_03D87F
CODE_03D890:
	RTS

;--------------------------------------------------------------------

SMB1_NorSpr00D_PiranhaPlant_MainRt:
.Main:
;$03D891
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	BNE.b CODE_03D8EB
	LDA.w $0792,x
	BNE.b CODE_03D8EB
	LDA.b !RAM_SMB1_NorSpr_YSpeed,x
	BNE.b CODE_03D8C1
	LDA.b !RAM_SMB1_NorSpr_XSpeed,x
	BMI.b CODE_03D8B6
	JSR.w SMB1_CheckPlayerPositionRelativeToSprite_X
	BPL.b CODE_03D8B0
	LDA.b $00
	EOR.b #$FF
	CLC										;\ Optimization: INC?
	ADC.b #$01									;/
	STA.b $00
CODE_03D8B0:
	LDA.b $00
	CMP.b #$21
	BCC.b CODE_03D8EB
CODE_03D8B6:
	LDA.b !RAM_SMB1_NorSpr_XSpeed,x
	EOR.b #$FF
	CLC										;\ Optimization: INC?
	ADC.b #$01									;/
	STA.b !RAM_SMB1_NorSpr_XSpeed,x
	INC.b !RAM_SMB1_NorSpr_YSpeed,x
CODE_03D8C1:
	LDA.w !RAM_SMB1_NorSpr_SubYSpeed,x
	LDY.b !RAM_SMB1_NorSpr_XSpeed,x
	BPL.b CODE_03D8CB
	LDA.w !RAM_SMB1_NorSpr_SubYPos,x
CODE_03D8CB:
	STA.b $00
	LDA.b !RAM_SMB1_Global_FrameCounter
	LSR
	BCC.b CODE_03D8EB
	LDA.w !RAM_SMB1_Level_FreezeSpritesTimer
	BNE.b CODE_03D8EB
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	CLC
	ADC.b !RAM_SMB1_NorSpr_XSpeed,x
	STA.w !RAM_SMB1_NorSpr_YPosLo,x
	CMP.b $00
	BNE.b CODE_03D8EB
	STZ.b !RAM_SMB1_NorSpr_YSpeed,x
	LDA.b #$40
	STA.w $0792,x
CODE_03D8EB:
	LDA.b #$00
	STA.w $0257,x
	RTS

;--------------------------------------------------------------------

CODE_03D8F1:
	STA.b $07
	LDA.w $0203,x
	BNE.b CODE_03D906
	LDY.b #$18
	LDA.b !RAM_SMB1_NorSpr_XSpeed,x
	CLC
	ADC.b $07
	STA.b !RAM_SMB1_NorSpr_XSpeed,x
	LDA.b !RAM_SMB1_NorSpr_YSpeed,x
	ADC.b #$00
	RTS

CODE_03D906:
	LDY.b #$08
	LDA.b !RAM_SMB1_NorSpr_XSpeed,x
	SEC
	SBC.b $07
	STA.b !RAM_SMB1_NorSpr_XSpeed,x
	LDA.b !RAM_SMB1_NorSpr_YSpeed,x
	SBC.b #$00
	RTS

;--------------------------------------------------------------------

CODE_03D914:
	LDA.b !RAM_SMB1_NorSpr_YPosHi,x
	CMP.b #$03
	BNE.b CODE_03D91D
	JMP.w CODE_03CDE2

CODE_03D91D:
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	BPL.b CODE_03D922
	RTS

CODE_03D922:
	TAY
	LDA.w $03A2,x
	STA.b $00
	LDA.b $47,x
	BEQ.b CODE_03D92F
	JMP.w CODE_03DB3A

CODE_03D92F:
	LDA.b #$2D
	CMP.w !RAM_SMB1_NorSpr_YPosLo,x
	BCC.b CODE_03D946
	CPY.b $00
	BEQ.b CODE_03D943
	CLC
	ADC.b #$02
	STA.w !RAM_SMB1_NorSpr_YPosLo,x
	JMP.w CODE_03DB30

CODE_03D943:
	JMP.w CODE_03DB17

CODE_03D946:
	CMP.w !RAM_SMB1_NorSpr_YPosLo,y
	BCC.b CODE_03D958
	CPX.b $00
	BEQ.b CODE_03D943
	CLC
	ADC.b #$02
	STA.w !RAM_SMB1_NorSpr_YPosLo,y
	JMP.w CODE_03DB30

CODE_03D958:
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	PHA
	LDA.w $03A2,x
	BPL.b CODE_03D979
	LDA.w !RAM_SMB1_NorSpr_SubYSpeed,x
	CLC
	ADC.b #$05
	STA.b $00
	LDA.b !RAM_SMB1_NorSpr_YSpeed,x
	ADC.b #$00
	BMI.b CODE_03D989
	BNE.b CODE_03D97D
	LDA.b $00
	CMP.b #$0B
	BCC.b CODE_03D983
	BCS.b CODE_03D97D

CODE_03D979:
	CMP.b $9E
	BEQ.b CODE_03D989
CODE_03D97D:
	JSR.w CODE_03C16F
	JMP.w CODE_03D98C

CODE_03D983:
	JSR.w CODE_03DB30
	JMP.w CODE_03D98C

CODE_03D989:
	JSR.w CODE_03C16B

CODE_03D98C:
	LDY.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	PLA
	SEC
	SBC.w !RAM_SMB1_NorSpr_YPosLo,x
	CLC
	ADC.w !RAM_SMB1_NorSpr_YPosLo,y
	STA.w !RAM_SMB1_NorSpr_YPosLo,y
	LDA.w $03A2,x
	BMI.b CODE_03D9A3
	TAX
	JSR.w CODE_03E2CB
CODE_03D9A3:
	LDY.b $9E
	LDA.w !RAM_SMB1_NorSpr_YSpeed,y
	ORA.w !RAM_SMB1_NorSpr_SubYSpeed,y
	BNE.b CODE_03D9B0
	JMP.w CODE_03DABF

CODE_03D9B0:
	LDA.w !RAM_SMB1_NorSpr_YSpeed,y
	PHA
	PHA
	PHA
	JSR.w CODE_03DAC2
	LDA.b $42
	LSR
	LSR
	LSR
	STA.b !RAM_SMB1_Global_ScratchRAMF3
	LDA.b $43
	AND.b #$01
	ASL
	ASL
	ORA.b #$20
	STA.b !RAM_SMB1_Global_ScratchRAMF4
	LDA.b !RAM_SMB1_Global_ScratchRAMF3
	CLC
	ADC.b #$1F
	TAX
	AND.b #$1F
	STA.b !RAM_SMB1_Global_ScratchRAMF5
	TXA
	AND.b #$20
	BEQ.b CODE_03D9DF
	LDA.b !RAM_SMB1_Global_ScratchRAMF4
	EOR.b #$04
	STA.b !RAM_SMB1_Global_ScratchRAMF6
CODE_03D9DF:
	REP.b #$30
	LDA.b $00
	AND.w #$241F
	CMP.b !RAM_SMB1_Global_ScratchRAMF3
	BCS.b CODE_03D9F1
	CMP.b !RAM_SMB1_Global_ScratchRAMF5
	BCC.b CODE_03D9F1
	JMP.w CODE_03DA4A

CODE_03D9F1:
	TYA
	AND.w #$00FF
	TAY
	LDX.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	LDA.b $00
	AND.w #$1FFF
	XBA
	STA.w SMB1_StripeImageUploadTable[$00].LowByte,x
	LDA.w #$0300
	STA.w SMB1_StripeImageUploadTable[$01].LowByte,x
	LDA.w !RAM_SMB1_NorSpr_YSpeed,y
	AND.w #$0080
	BNE.b CODE_03DA33
	LDA.w SMB1_StripeImageUploadTable[$00].LowByte,x
	AND.w #$F003
	CMP.w #$A000
	BEQ.b CODE_03DA20
	CMP.w #$B000
	BNE.b CODE_03DA25
CODE_03DA20:
	LDA.w #$185C
	BRA.b CODE_03DA28

CODE_03DA25:
	LDA.w #$10A2
CODE_03DA28:
	STA.w SMB1_StripeImageUploadTable[$02].LowByte,x
	LDA.w #$18A3
	STA.w SMB1_StripeImageUploadTable[$03].LowByte,x
	BRA.b CODE_03DA3C

CODE_03DA33:
	LDA.w #$0024
	STA.w SMB1_StripeImageUploadTable[$02].LowByte,x
	STA.w SMB1_StripeImageUploadTable[$03].LowByte,x
CODE_03DA3C:
	LDA.w #$FFFF
	STA.w SMB1_StripeImageUploadTable[$04].LowByte,x
	TXA
	CLC
	ADC.w #$0008
	STA.w !RAM_SMB1_Global_StripeImageUploadIndexLo
CODE_03DA4A:
	SEP.b #$30
	LDA.w !RAM_SMB1_NorSpr_SpriteStatusFlags,y
	TAY
	PLA
	EOR.b #$FF
	JSR.w CODE_03DAC2
	REP.b #$30
	LDA.b $00
	AND.w #$241F
	CMP.b !RAM_SMB1_Global_ScratchRAMF3
	BCS.b CODE_03DA68
	CMP.b !RAM_SMB1_Global_ScratchRAMF5
	BCC.b CODE_03DA68
	JMP.w CODE_03DABC

CODE_03DA68:
	LDX.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	LDA.b $00
	AND.w #$1FFF
	XBA
	STA.w SMB1_StripeImageUploadTable[$00].LowByte,x
	LDA.w #$0300
	STA.w SMB1_StripeImageUploadTable[$01].LowByte,x
	PLA
	AND.w #$0080
	BEQ.b CODE_03DAA3
	LDA.w #$10A2
	STA.w SMB1_StripeImageUploadTable[$02].LowByte,x
	LDA.w SMB1_StripeImageUploadTable[$00].LowByte,x
	AND.w #$F003
	CMP.w #$A000
	BEQ.b CODE_03DA96
	CMP.w #$B000
	BNE.b CODE_03DA9B
CODE_03DA96:
	LDA.w #$183F
	BRA.b CODE_03DA9E

CODE_03DA9B:
	LDA.w #$18A3
CODE_03DA9E:
	STA.w SMB1_StripeImageUploadTable[$03].LowByte,x
	BRA.b CODE_03DAAC

CODE_03DAA3:
	LDA.w #$0024
	STA.w SMB1_StripeImageUploadTable[$02].LowByte,x
	STA.w SMB1_StripeImageUploadTable[$03].LowByte,x
CODE_03DAAC:
	LDA.w #$FFFF
	STA.w SMB1_StripeImageUploadTable[$04].LowByte,x
	TXA
	CLC
	ADC.w #$0008
	STA.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	BRA.b CODE_03DABD

CODE_03DABC:
	PLA
CODE_03DABD:
	SEP.b #$30
CODE_03DABF:
	LDX.b $9E
	RTS

CODE_03DAC2:
	PHA
	LDA.w !RAM_SMB1_NorSpr_XPosLo,y
	CLC
	ADC.b #$08
	LDX.w !RAM_SMB1_Global_UseLateStageSpriteBehaviorFlag
	BNE.b CODE_03DAD1
	CLC
	ADC.b #$10
CODE_03DAD1:
	PHA
	LDA.w !RAM_SMB1_NorSpr_XPosHi,y
	ADC.b #$00
	STA.b $02
	PLA
	AND.b #$F0
	LSR
	LSR
	LSR
	STA.b $00
	LDX.w !RAM_SMB1_NorSpr_YPosLo,y
	PLA
	BPL.b CODE_03DAEC
	TXA
	CLC
	ADC.b #$08
	TAX
CODE_03DAEC:
	TXA
	ASL
	ROL
	PHA
	ROL
	AND.b #$03
	ORA.b #$20
	STA.b $01
	LDA.b $02
	AND.b #$01
	ASL
	ASL
	ORA.b $01
	STA.b $01
	PLA
	AND.b #$E0
	CLC
	ADC.b $00
	STA.b $00
	LDA.w !RAM_SMB1_NorSpr_YPosLo,y
	CMP.b #$E8
	BCC.b CODE_03DB16
	LDA.b $00
	AND.b #$BF
	STA.b $00
CODE_03DB16:
	RTS

CODE_03DB17:
	TYX
	JSR.w CODE_03FDCB
	LDA.b #$06
	JSR.w CODE_03E07E
	LDA.w $03AD
	STA.w !RAM_SMB1_Level_ScoreSpr_XPosLo,x
	LDA.w !RAM_SMB1_Player_YPosLo
	STA.w !RAM_SMB1_Level_ScoreSpr_YPosLo,x
	LDA.b #$01
	STA.b $47,x
CODE_03DB30:
	JSR.w CODE_03C726
	STA.w !RAM_SMB1_NorSpr_YSpeed,y
	STA.w !RAM_SMB1_NorSpr_SubYSpeed,y
	RTS

CODE_03DB3A:
	PHY
	JSR.w CODE_03C123
	PLX
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	BPL.b CODE_03DB46
	JSR.w CODE_03C123
CODE_03DB46:
	LDX.b $9E
	LDA.w $03A2,x
	BMI.b CODE_03DB51
	TAX
	JSR.w CODE_03E2CB
CODE_03DB51:
	LDX.b $9E
	RTS

;--------------------------------------------------------------------

CODE_03DB54:
	LDA.b !RAM_SMB1_NorSpr_YSpeed,x
	ORA.w !RAM_SMB1_NorSpr_SubYSpeed,x
	BNE.b CODE_03DB71
	STA.w !RAM_SMB1_NorSpr_SubYPos,x
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	CMP.w $0402,x
	BCS.b CODE_03DB71
	LDA.b !RAM_SMB1_Global_FrameCounter
	AND.b #$07
	BNE.b CODE_03DB6F
	INC.w !RAM_SMB1_NorSpr_YPosLo,x
CODE_03DB6F:
	BRA.b CODE_03DB81

CODE_03DB71:
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	CMP.b !RAM_SMB1_NorSpr_XSpeed,x
	BCC.b CODE_03DB7E
	JSR.w CODE_03C16F
	JMP.w CODE_03DB81

CODE_03DB7E:
	JSR.w CODE_03C16B
CODE_03DB81:
	LDA.w $03A2,x
	BMI.b CODE_03DB89
	JSR.w CODE_03E2CB
CODE_03DB89:
	RTS

;--------------------------------------------------------------------

CODE_03DB8A:
	LDA.b #$0E
	JSR.w CODE_03CFDD
	JSR.w CODE_03CFFC
	LDA.w $03A2,x
	BMI.b CODE_03DBB4
CODE_03DB97:
	LDA.w !RAM_SMB1_Player_XPosLo
	CLC
	ADC.b $00
	STA.w !RAM_SMB1_Player_XPosLo
	LDA.b !RAM_SMB1_Player_XPosHi
	LDY.b $00
	BMI.b CODE_03DBAA
	ADC.b #$00
	BRA.b CODE_03DBAC

CODE_03DBAA:
	SBC.b #$00
CODE_03DBAC:
	STA.b !RAM_SMB1_Player_XPosHi
	STY.w $03A1
	JSR.w CODE_03E2CB
CODE_03DBB4:
	RTS

;--------------------------------------------------------------------

CODE_03DBB5:
	LDA.w $03A2,x
	BMI.b CODE_03DBC0
	JSR.w CODE_03C13E
	JSR.w CODE_03E2CB
CODE_03DBC0:
	RTS

;--------------------------------------------------------------------

CODE_03DBC1:
	JSR.w CODE_03C0B5
	STA.b $00
	LDA.w $03A2,x
	BMI.b CODE_03DBD2
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDA.b #$13
else
	LDA.b #$10
endif
	STA.b !RAM_SMB1_NorSpr_XSpeed,x
	JSR.w CODE_03DB97
CODE_03DBD2:
	RTS

;--------------------------------------------------------------------

CODE_03DBD3:
	JSR.w CODE_03DBDE
	JMP.w CODE_03DB81

;--------------------------------------------------------------------

CODE_03DBD9:
	JSR.w CODE_03DBDE
	BRA.b CODE_03DBF6

CODE_03DBDE:
	LDA.w !RAM_SMB1_Level_FreezeSpritesTimer
	BNE.b CODE_03DC02
	LDA.w !RAM_SMB1_NorSpr_SubYPos,x
	CLC
	ADC.w !RAM_SMB1_NorSpr_SubYSpeed,x
	STA.w !RAM_SMB1_NorSpr_SubYPos,x
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	ADC.b !RAM_SMB1_NorSpr_YSpeed,x
	STA.w !RAM_SMB1_NorSpr_YPosLo,x
	RTS

;--------------------------------------------------------------------

CODE_03DBF6:
	LDA.w $03A2,x
	BEQ.b CODE_03DC02
	CMP.b #$FF
	BEQ.b CODE_03DC02
	JSR.w CODE_03E2BC
CODE_03DC02:
	RTS

;--------------------------------------------------------------------

CODE_03DC03:
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr014_RedFlyingCheepCheepGenerator
	BEQ.b CODE_03DC61
	LDA.w $071C
	LDY.b !RAM_SMB1_NorSpr_SpriteID,x
	CPY.b #!Define_SMB1_SpriteID_NorSpr005_HammerBro
	BEQ.b CODE_03DC16
	CPY.b #!Define_SMB1_SpriteID_NorSpr00D_PiranhaPlant
	BNE.b CODE_03DC18
CODE_03DC16:
	ADC.b #$38
CODE_03DC18:
	SBC.b #$48
	STA.b $01
	LDA.w $071A
	SBC.b #$00
	STA.b $00
	LDA.w $071D
	CLC
	ADC.b #$48
	STA.b $03
	LDA.w $071B
	ADC.b #$00
	STA.b $02
	LDA.w !RAM_SMB1_NorSpr_XPosLo,x
	CMP.b $01
	LDA.b !RAM_SMB1_NorSpr_XPosHi,x
	SBC.b $00
	BMI.b CODE_03DC5E
	LDA.w !RAM_SMB1_NorSpr_XPosLo,x
	CMP.b $03
	LDA.b !RAM_SMB1_NorSpr_XPosHi,x
	SBC.b $02
	BMI.b CODE_03DC61
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	CMP.b #$05
	BEQ.b CODE_03DC61
	CPY.b #$0D
	BEQ.b CODE_03DC61
	CPY.b #$30
	BEQ.b CODE_03DC61
	CPY.b #$31
	BEQ.b CODE_03DC61
	CPY.b #$32
	BEQ.b CODE_03DC61
CODE_03DC5E:
	JSR.w CODE_03CDE2
CODE_03DC61:
	RTS

if !Define_Global_ROMToAssemble&(!ROM_SMB1_U|!ROM_SMB1_E|!ROM_SMB1_J) != $00
elseif !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E) != $00
	%FREE_BYTES(NULLROM, 26, $FF)
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	%FREE_BYTES(NULLROM, 16, $FF)
else
	%FREE_BYTES(NULLROM, 14, $FF)
endif

;--------------------------------------------------------------------

; Note: Routine related to Mario shooting fireballs

CODE_03DC70:
	LDA.b $33,x
	BEQ.b CODE_03DCCA
	ASL
	BCS.b CODE_03DCCA
	LDA.b !RAM_SMB1_Global_FrameCounter
	LSR
	BCS.b CODE_03DCCA
	TXA
	ASL
	ASL
	CLC
	ADC.b #$2C
	TAY
	LDX.b #$08
CODE_03DC85:
	STX.b $01
	TYA
	PHA
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	AND.b #$20
	BNE.b CODE_03DCC3
	LDA.b !RAM_SMB1_NorSpr_SpriteSlotExistsFlag,x
	BEQ.b CODE_03DCC3
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr024_PulleyGirderPlatform
	BCC.b CODE_03DC9D
	CMP.b #!Define_SMB1_SpriteID_NorSpr02B_UpMovingGirderPlatformLift
	BCC.b CODE_03DCC3
CODE_03DC9D:
	CMP.b #!Define_SMB1_SpriteID_NorSpr006_Goomba
	BNE.b CODE_03DCA7
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	CMP.b #$02
	BCS.b CODE_03DCC3
CODE_03DCA7:
	LDA.w $03D9,x
	BNE.b CODE_03DCC3
	TXA
	ASL
	ASL
	CLC
	ADC.b #$04
	TAX
	JSR.w CODE_03EAB9
	LDX.b $9E
	BCC.b CODE_03DCC3
	LDA.b #$80
	STA.b $33,x
	LDX.b $01
	JSR.w CODE_03DCD5
CODE_03DCC3:
	PLA
	TAY
	LDX.b $01
	DEX
	BPL.b CODE_03DC85
CODE_03DCCA:
	LDX.b $9E
	RTS

;--------------------------------------------------------------------

DATA_03DCCD:
	db !Define_SMB1_SpriteID_NorSpr006_Goomba
	db !Define_SMB1_SpriteID_NorSpr000_GreenKoopa
	db !Define_SMB1_SpriteID_NorSpr002_BuzzyBeetle
	db !Define_SMB1_SpriteID_NorSpr012_Spiny
	db !Define_SMB1_SpriteID_NorSpr011_Lakitu
	db !Define_SMB1_SpriteID_NorSpr007_Blooper
	db !Define_SMB1_SpriteID_NorSpr005_HammerBro
	db !Define_SMB1_SpriteID_NorSpr02D_Bowser

CODE_03DCD5:
	JSR.w CODE_03FD39
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_J1) != $00
	LDA.b #!Define_SMAS_Sound0060_KickShell
else
	LDA.b #!Define_SMAS_Sound0060_HitHead
endif
	STA.w !RAM_SMB1_Global_SoundCh1
	LDX.b $01
	LDA.b !RAM_SMB1_NorSpr_SpriteSlotExistsFlag,x
	BPL.b CODE_03DCEE
	AND.b #$0F
	TAX
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr02D_Bowser
	BEQ.b CODE_03DCFB
	LDX.b $01
CODE_03DCEE:
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr002_BuzzyBeetle
	BNE.b CODE_03DCF7
	JMP.w CODE_03DDBD

CODE_03DCF7:
	CMP.b #!Define_SMB1_SpriteID_NorSpr02D_Bowser
	BNE.b CODE_03DD75
CODE_03DCFB:
	LDA.b #$08
	STA.w $014B
	LDA.b #$18
	STA.w $0F4C
	DEC.w !RAM_SMB1_NorSpr02D_Bowser_CurrentHP
	BEQ.b CODE_03DD1F
	LDA.w !RAM_SMB1_NorSpr02D_Bowser_CurrentHP
	CMP.b #$01
	BEQ.b CODE_03DD14
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	JMP.w CODE_03DDB8
else
	JMP.w CODE_03DDBD
endif

CODE_03DD14:
	STZ.w !RAM_SMB1_NorSpr02D_Bowser_WoozyEffectAnimationFrame
	LDA.b #$01
	STA.w !RAM_SMB1_NorSpr02D_Bowser_FeelingWoozyFlag
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	JMP.w CODE_03DDB8
else
	JMP.w CODE_03DDBD
endif

CODE_03DD1F:
	LDA.b #$08
	STA.w $014B
	LDA.b #$FF
	STA.w $0F4C
	JSR.w CODE_03C726
	STA.b !RAM_SMB1_NorSpr_XSpeed,x
	STA.w !RAM_SMB1_Level_SpriteToRandomlyGenerate
	LDA.b #$FE
	STA.b !RAM_SMB1_NorSpr_YSpeed,x
	LDY.w !RAM_SMB1_Player_CurrentWorld
	LDA.w DATA_03DCCD,y
	STA.b !RAM_SMB1_NorSpr_SpriteID,x
	STX.w $02FC
	INC.w $02FC
	CMP.b #$2D
	BEQ.b CODE_03DD65
	PHX
	LDA.b $DB
	CMP.b #$21
	BEQ.b CODE_03DD64
	STX.w $0077
	INC.w $0077
	LDX.b #$08
CODE_03DD56:
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	DEX
	BMI.b CODE_03DD64
	CMP.b #!Define_SMB1_SpriteID_NorSpr02D_Bowser
	BNE.b CODE_03DD56
	INX
	STZ.b !RAM_SMB1_NorSpr_SpriteSlotExistsFlag,x
	STZ.b !RAM_SMB1_NorSpr_SpriteID,x
CODE_03DD64:
	PLX
CODE_03DD65:
	LDA.b #$20
	CPY.b #$03
	BCS.b CODE_03DD6D
	ORA.b #$03
CODE_03DD6D:
	STA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	LDX.b $01
	LDA.b #$09
	BNE.b CODE_03DDAA						; Note: this will always branch

CODE_03DD75:
	CMP.b #!Define_SMB1_SpriteID_NorSpr008_BulletBill
	BEQ.b CODE_03DDBD
	CMP.b #!Define_SMB1_SpriteID_NorSpr00C_Podoboo
	BEQ.b CODE_03DDBD
	CMP.b #!Define_SMB1_SpriteID_NorSpr015_BowserFireGenerator
	BCS.b CODE_03DDBD
SMB1_KillSprite:
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr00D_PiranhaPlant
	BNE.b CODE_03DD8F
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	ADC.b #$18
	STA.w !RAM_SMB1_NorSpr_YPosLo,x
CODE_03DD8F:
	JSR.w CODE_03E789
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	AND.b #$1F
	ORA.b #$20
	STA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	LDA.b #$02
	LDY.b !RAM_SMB1_NorSpr_SpriteID,x
	CPY.b #!Define_SMB1_SpriteID_NorSpr005_HammerBro
	BNE.b CODE_03DDA4
	LDA.b #$06
CODE_03DDA4:
	CPY.b #!Define_SMB1_SpriteID_NorSpr006_Goomba
	BNE.b CODE_03DDAA
	LDA.b #$01
CODE_03DDAA:
	JSR.w CODE_03E07E
	LDA.w !RAM_SMB1_Global_SoundCh1
	CMP.b #!Define_SMAS_Sound0060_KickShell
	BEQ.b CODE_03DDBD
CODE_03DDB8:
	LDA.b #!Define_SMAS_Sound0060_KickShell
	STA.w !RAM_SMB1_Global_SoundCh1
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) == $00
	JSL.l SMB1_InitializeContactSprite_Main
endif
CODE_03DDBD:
	RTS

;--------------------------------------------------------------------

CODE_03DDBE:
	LDA.b !RAM_SMB1_Global_FrameCounter
	LSR
	BCC.b CODE_03DDF9
	LDA.w !RAM_SMB1_Level_FreezeSpritesTimer
	ORA.w $03D6
	BNE.b CODE_03DDF9
	TXA
	ASL
	ASL
	CLC
	ADC.b #$34
	TAY
	JSR.w SMB1_CheckForContact_Main
	LDX.b $9E
	BCC.b CODE_03DDF4
	LDA.w $06BE,x
	BNE.b CODE_03DDF9
	LDA.b #$01
	STA.w $06BE,x
	LDA.b !RAM_SMB1_HammerSpr_XSpeed,x
	EOR.b #$FF
	CLC
	ADC.b #$01
	STA.b !RAM_SMB1_HammerSpr_XSpeed,x
	LDA.w !RAM_SMB1_Player_StarPowerTimer
	BNE.b CODE_03DDF9
	JMP.w CODE_03DF4D

CODE_03DDF4:
	LDA.b #$00
	STA.w $06BE,x
CODE_03DDF9:
	RTS

;--------------------------------------------------------------------

; Note: Routine for when the player touches a power up.

CODE_03DDFA:
	JSR.w CODE_03CDE5
	LDA.b #$06
	JSR.w CODE_03E04F
	LDA.b #!Define_SMAS_Sound0060_GetPowerup
	STA.w !RAM_SMB1_Global_SoundCh1
	LDA.w !RAM_SMB1_NorSpr02E_Powerup_PowerupType
	CMP.b #$02
	BCC.b CODE_03DE1D
	CMP.b #$03
	BEQ.b CODE_03DE37
	LDA.b #$23
	STA.w !RAM_SMB1_Player_StarPowerTimer
	LDA.b #!Define_SMB1_LevelMusic_HaveStar
	STA.w !RAM_SMB1_Global_MusicCh1
	RTS

CODE_03DE1D:
	LDA.w !RAM_SMB1_Player_CurrentPowerUp
	BEQ.b CODE_03DE42
	CMP.b #$01
	BNE.b CODE_03DE4E
	LDX.b $9E
	LDA.b #$02
	STA.w !RAM_SMB1_Player_CurrentPowerUp
	JSL.l CODE_049A88
	LDX.b $9E
	LDA.b #$0C
	BRA.b CODE_03DE49

CODE_03DE37:
	LDA.b #$0B
	STA.w !RAM_SMB1_Level_ScoreSpr_SpriteID,x
	LDA.b #$00					;\ Optimization: STZ.w !RAM_SMB1_Global_SoundCh1
	STA.w !RAM_SMB1_Global_SoundCh1			;/
	RTS

CODE_03DE42:
	LDA.b #$01
	STA.w !RAM_SMB1_Player_CurrentPowerUp
	LDA.b #$09
CODE_03DE49:
	LDY.b #$00
	JSR.w CODE_03DF6C
CODE_03DE4E:
	RTS

;--------------------------------------------------------------------

UNK_03DE4F:
	db $18,$E8

;--------------------------------------------------------------------

DATA_03DE51:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	db $38,$C8
else
	db $30,$D0
endif

DATA_03DE53:
	db $08,$F8

CODE_03DE55:
	LDA.b !RAM_SMB1_Global_FrameCounter
	LSR
	BCS.b CODE_03DE4E
	JSR.w CODE_03E2ED
	BCS.b CODE_03DE8F
	CPX.b #$09
	BNE.b CODE_03DE6C
	LDA.w $03AE
	BPL.b CODE_03DE6C
	CMP.b #$F4
	BCS.b CODE_03DE71
CODE_03DE6C:
	LDA.w $03D9,x
	BNE.b CODE_03DE8F
CODE_03DE71:
	LDA.b !RAM_SMB1_Player_CurrentState
	CMP.b #$08
	BNE.b CODE_03DE8F
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	AND.b #$20
	BNE.b CODE_03DE8F
	JSR.w CODE_03E2F7
	JSR.w SMB1_CheckForContact_Main
	LDX.b $9E
	BCS.b CODE_03DE90
	LDA.w $0481,x
	AND.b #$FE
	STA.w $0481,x
CODE_03DE8F:
	RTS

CODE_03DE90:
	LDY.b !RAM_SMB1_NorSpr_SpriteID,x
	CPY.b #!Define_SMB1_SpriteID_NorSpr02E_Powerup
	BNE.b CODE_03DE99
	JMP.w CODE_03DDFA

CODE_03DE99:
	LDA.w !RAM_SMB1_Player_StarPowerTimer
	BEQ.b CODE_03DEA4
	JMP.w SMB1_KillSprite

DATA_03DEA1:
	db $0A,$06,$04

CODE_03DEA4:
	LDA.w $0481,x
	AND.b #$01
	ORA.w $03D9,x
	BNE.b CODE_03DF14
	LDA.b #$01
	ORA.w $0481,x
	STA.w $0481,x
	CPY.b #!Define_SMB1_SpriteID_NorSpr012_Spiny
	BEQ.b CODE_03DF15
	CPY.b #!Define_SMB1_SpriteID_NorSpr00D_PiranhaPlant
	BNE.b CODE_03DEC1
	JMP.w CODE_03DF4D

CODE_03DEC1:
	CPY.b #!Define_SMB1_SpriteID_NorSpr00C_Podoboo
	BNE.b CODE_03DEC8
	JMP.w CODE_03DF4D

CODE_03DEC8:
	CPY.b #!Define_SMB1_SpriteID_NorSpr033_BulletBillLauncher
	BEQ.b CODE_03DF15
	CPY.b #!Define_SMB1_SpriteID_NorSpr015_BowserFireGenerator
	BCS.b CODE_03DF4D
	LDA.b !RAM_SMB1_Level_CurrentLevelType
	BEQ.b CODE_03DF4D
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	ASL
	BCS.b CODE_03DF15
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	AND.b #$07
	CMP.b #$02
	BCC.b CODE_03DF15
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr006_Goomba
	BEQ.b CODE_03DF14
	LDA.b #!Define_SMAS_Sound0060_KickShell
	STA.w !RAM_SMB1_Global_SoundCh1
	JSL.l SMB1_InitializeContactSprite_Main
	STZ.w $0F40,x
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	ORA.b #$80
	STA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	JSR.w CODE_03E043
	LDA.w DATA_03DE51,y
	STA.b !RAM_SMB1_NorSpr_XSpeed,x
	LDA.b #$03
	CLC
	ADC.w $0284
	LDY.w $07A2,x
	CPY.b #$03
	BCS.b CODE_03DF11
	LDA.w DATA_03DEA1,y
CODE_03DF11:
	JSR.w CODE_03E07E
CODE_03DF14:
	RTS

CODE_03DF15:
	LDA.b !RAM_SMB1_Player_YSpeed
	BMI.b CODE_03DF1E
	BEQ.b CODE_03DF1E
	JMP.w CODE_03DFA6

CODE_03DF1E:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDA.b #$14
	LDY.b !RAM_SMB1_NorSpr_SpriteID,x
	CPY.b #!Define_SMB1_SpriteID_NorSpr014_RedFlyingCheepCheepGenerator
	BNE.b +
	LDA.b #$07
+:
	ADC.w !RAM_SMB1_Player_YPosLo
else
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr007_Blooper
	BCC.b CODE_03DF2F
	LDA.w !RAM_SMB1_Player_YPosLo
	CLC
	ADC.b #$0C
endif
	CMP.w !RAM_SMB1_NorSpr_YPosLo,x
	BCC.b CODE_03DFA6
CODE_03DF2F:
	LDA.w $079D
	BNE.b CODE_03DFA6
	LDA.w !RAM_SMB1_Player_HurtTimer
	BNE.b CODE_03DF79
	LDA.w $03AD
	CMP.w $03AE
	BCC.b CODE_03DF44
	JMP.w CODE_03E034

CODE_03DF44:
	LDA.b $47,x
	CMP.b #$01
	BNE.b CODE_03DF4D
	JMP.w CODE_03E03D

CODE_03DF4D:
	LDA.w !RAM_SMB1_Player_HurtTimer
	BNE.b CODE_03DF79
CODE_03DF52:
	LDX.w !RAM_SMB1_Player_CurrentPowerUp
	BEQ.b CODE_03DF7C
	STA.w !RAM_SMB1_Player_CurrentPowerUp					; Note: Hurt player routine
	LDA.b #$08
	STA.w !RAM_SMB1_Player_HurtTimer
	LDA.b #!Define_SMAS_Sound0060_IntoPipe
	STA.w !RAM_SMB1_Global_SoundCh1
	JSL.l CODE_049A88
	LDA.b #$0A
CODE_03DF6A:
	LDY.b #$01
CODE_03DF6C:
	STA.b !RAM_SMB1_Player_CurrentState
	STY.b !RAM_SMB1_Level_Player_CurrentPhysicsType
	LDY.b #$FF
	STY.w !RAM_SMB1_Level_FreezeSpritesTimer
	INY
	STY.w $0775
CODE_03DF79:
	LDX.b $9E
	RTS

CODE_03DF7C:						; Note: Kill player routine.
	STX.b !RAM_SMB1_Player_XSpeed
	PHX
	LDA.b #$01
	STA.w !RAM_SMB1_Player_CurrentSize
	JSL.l CODE_049A88
	PLX
	INX
if !Define_Global_ROMToAssemble&(!ROM_SMB1_E) == $00
	LDA.b #!Define_SMB1_LevelMusic_MarioDied
	STA.w !RAM_SMB1_Global_MusicCh1
endif
	LDA.b #!Define_SMB1_LevelMusic_MarioDied			;\ Optimization: Needless code duplication.
	STA.w !RAM_SMB1_Global_MusicCh1					;/
	STA.w $0E67
	STA.w !RAM_SMB1_Level_DisableScrollingFlag
	LDA.b #$FC
	STA.b !RAM_SMB1_Player_YSpeed
	LDA.b #$0B
	BNE.b CODE_03DF6A

DATA_03DFA2:
	db $02,$06,$05,$06

CODE_03DFA6:
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr012_Spiny
	BEQ.b CODE_03DF4D
	LDA.b #!Define_SMAS_Sound0060_Contact
	STA.w !RAM_SMB1_Global_SoundCh1
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	LDY.b #$00
	CMP.b #!Define_SMB1_SpriteID_NorSpr014_RedFlyingCheepCheepGenerator
	BEQ.b CODE_03DFD4
	CMP.b #!Define_SMB1_SpriteID_NorSpr008_BulletBill
	BEQ.b CODE_03DFD4
	CMP.b #!Define_SMB1_SpriteID_NorSpr033_BulletBillLauncher
	BEQ.b CODE_03DFD4
	CMP.b #!Define_SMB1_SpriteID_NorSpr00C_Podoboo
	BEQ.b CODE_03DFD4
	INY
	CMP.b #!Define_SMB1_SpriteID_NorSpr005_HammerBro
	BEQ.b CODE_03DFD4
	INY
	CMP.b #!Define_SMB1_SpriteID_NorSpr011_Lakitu
	BEQ.b CODE_03DFD4
	INY
	CMP.b #!Define_SMB1_SpriteID_NorSpr007_Blooper
	BNE.b CODE_03DFF1
CODE_03DFD4:
	LDA.w DATA_03DFA2,y
	JSR.w CODE_03E07E
	LDA.b $47,x
	PHA
	JSR.w CODE_03E79D
	PLA
	STA.b $47,x
	LDA.b #$20
	STA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	JSR.w CODE_03C726
	STA.b !RAM_SMB1_NorSpr_XSpeed,x
	LDA.b #$FD
	STA.b !RAM_SMB1_Player_YSpeed
	RTS

CODE_03DFF1:
	CMP.b #!Define_SMB1_SpriteID_NorSpr009_StationaryYellowParakoopa
	BCC.b CODE_03E012
	AND.b #!Define_SMB1_SpriteID_NorSpr001_RedKoopa
	STA.b !RAM_SMB1_NorSpr_SpriteID,x
	LDY.b #$00
	STY.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	LDA.b #$03
	JSR.w CODE_03E07E
	JSR.w CODE_03C726
	JSR.w CODE_03E043
	LDA.w DATA_03DE53,y
	STA.b !RAM_SMB1_NorSpr_XSpeed,x
	JMP.w CODE_03E02F

DATA_03E010:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	db $0D,$09
else
	db $10,$0B
endif

CODE_03E012:
	LDA.b #$04
	STA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	INC.w $0284
	LDA.w $0284
	CLC
	ADC.w $079D
	JSR.w CODE_03E07E
	INC.w $079D
	LDY.w !RAM_SMB1_Global_UseHardModeEnemyBehaviorFlag
	LDA.w DATA_03E010,y
	STA.w $07A2,x
CODE_03E02F:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDA.b #$FA
else
	LDA.b #$FB
endif
	STA.b !RAM_SMB1_Player_YSpeed
	RTS

CODE_03E034:
	LDA.b $47,x
	CMP.b #$01
	BNE.b CODE_03E03D
	JMP.w CODE_03DF4D

CODE_03E03D:
	JSR.w CODE_03E1BE
	JMP.w CODE_03DF4D

CODE_03E043:
	LDY.b #$01
	JSR.w SMB1_CheckPlayerPositionRelativeToSprite_X
	BPL.b CODE_03E04B
	INY
CODE_03E04B:
	STY.b $47,x
	DEY
	RTS

;--------------------------------------------------------------------

CODE_03E04F:
	STA.w !RAM_SMB1_Level_ScoreSpr_SpriteID,x
	LDA.b #$30
	STA.w !RAM_SMB1_Level_ScoreSpr_DisplayTimer,x
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	STA.w !RAM_SMB1_Level_ScoreSpr_YPosLo,x
	LDA.w $03AE
	STA.w !RAM_SMB1_Level_ScoreSpr_XPosLo,x
	LDA.w !RAM_SMB1_NorSpr_XPosLo,x
	STA.b !RAM_SMB1_Global_ScratchRAMED
	LDA.b !RAM_SMB1_NorSpr_XPosHi,x
	STA.b !RAM_SMB1_Global_ScratchRAMEE
	PHX
	TXA
	ASL
	TAX
	REP.b #$20
	LDA.b !RAM_SMB1_Global_ScratchRAMED
	SEC
	SBC.b $42
	STA.w $0E50,x
	SEP.b #$20
	PLX
CODE_03E07D:
	RTS

CODE_03E07E:
	CMP.w !RAM_SMB1_Level_ScoreSpr_SpriteID,x
	BCS.b CODE_03E084
	RTS

CODE_03E084:
	STA.w !RAM_SMB1_Level_ScoreSpr_SpriteID,x
	LDA.b #$30
	STA.w !RAM_SMB1_Level_ScoreSpr_DisplayTimer,x
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	STA.w !RAM_SMB1_Level_ScoreSpr_YPosLo,x
	LDA.w $03AE
	STA.w !RAM_SMB1_Level_ScoreSpr_XPosLo,x
	PHY
	TXA
	ASL
	TAY
	LDA.w !RAM_SMB1_NorSpr_XPosLo,x
	STA.b !RAM_SMB1_Global_ScratchRAME4
	LDA.b !RAM_SMB1_NorSpr_XPosHi,x
	STA.b !RAM_SMB1_Global_ScratchRAME5
	REP.b #$20
	LDA.b !RAM_SMB1_Global_ScratchRAME4
	SEC
	SBC.b $42
	STA.w $0E50,y
	SEP.b #$20
	STA.w !RAM_SMB1_Level_ScoreSpr_XPosLo,x
	PLY
	RTS

;--------------------------------------------------------------------

; Note: Some sort of collision routine (ex. kicked koopa shell hitting enemies)

DATA_03E0B6:
	db $80,$40,$20,$10,$08,$04,$02

DATA_03E0BD:
	db $7F,$BF,$DF,$EF,$F7,$FB,$FD

CODE_03E0C4:
	LDA.b !RAM_SMB1_Global_FrameCounter
	LSR
	BCC.b CODE_03E07D
	LDA.b !RAM_SMB1_Level_CurrentLevelType
	BEQ.b CODE_03E07D
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr015_BowserFireGenerator
	BCS.b CODE_03E140
	CMP.b #!Define_SMB1_SpriteID_NorSpr011_Lakitu
	BEQ.b CODE_03E140
	CMP.b #!Define_SMB1_SpriteID_NorSpr00D_PiranhaPlant
	BEQ.b CODE_03E140
	LDA.w $03D9,x
	BNE.b CODE_03E140
	JSR.w CODE_03E2F7
	DEX
	BMI.b CODE_03E140
CODE_03E0E6:
	STX.b $01
	TYA
	PHA
	LDA.b !RAM_SMB1_NorSpr_SpriteSlotExistsFlag,x
	BEQ.b CODE_03E139
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr015_BowserFireGenerator
	BCS.b CODE_03E139
	CMP.b #!Define_SMB1_SpriteID_NorSpr011_Lakitu
	BEQ.b CODE_03E139
	CMP.b #!Define_SMB1_SpriteID_NorSpr00D_PiranhaPlant
	BEQ.b CODE_03E139
	LDA.w $03D9,x
	BNE.b CODE_03E139
	TXA
	ASL
	ASL
	CLC
	ADC.b #$04
	TAX
	JSR.w CODE_03EAB9
	LDX.b $9E
	LDY.b $01
	BCC.b CODE_03E130
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	ORA.w !RAM_SMB1_NorSpr_SpriteStatusFlags,y
	AND.b #$80
	BNE.b CODE_03E12B
	LDA.w $0481,y
	AND.w DATA_03E0B6,x
	BNE.b CODE_03E139
	LDA.w $0481,y
	ORA.w DATA_03E0B6,x
	STA.w $0481,y
CODE_03E12B:
	JSR.w CODE_03E143
	BRA.b CODE_03E139

CODE_03E130:
	LDA.w $0481,y
	AND.w DATA_03E0BD,x
	STA.w $0481,y
CODE_03E139:
	PLA
	TAY
	LDX.b $01
	DEX
	BPL.b CODE_03E0E6
CODE_03E140:
	LDX.b $9E
	RTS

CODE_03E143:
	LDA.w !RAM_SMB1_NorSpr_SpriteStatusFlags,y
	ORA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	AND.b #$20
	BNE.b CODE_03E183
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr005_HammerBro
	BNE.b CODE_03E154
	STZ.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
CODE_03E154:
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	CMP.b #$06
	BCC.b CODE_03E184
	LDA.w !RAM_SMB1_NorSpr_SpriteStatusFlags,y
	ASL
	BCC.b CODE_03E16A
	LDA.b #$06
	JSR.w CODE_03E07E
	JSR.w SMB1_KillSprite
	LDY.b $01
CODE_03E16A:
	TYA
	TAX
	JSR.w SMB1_KillSprite
	LDX.b $9E
	LDA.w !RAM_SMB1_Level_NorSpr_KillCounter,x
	CLC
	ADC.b #$04
	LDX.b $01
	JSR.w CODE_03E07E
	LDX.b $9E
	INC.w !RAM_SMB1_Level_NorSpr_KillCounter,x
	BRA.b CODE_03E1A7

CODE_03E183:
	RTS

CODE_03E184:
	LDA.w !RAM_SMB1_NorSpr_SpriteStatusFlags,y
	CMP.b #$06
	BCC.b CODE_03E1B7
	LDA.w !RAM_SMB1_NorSpr_SpriteID,y
	CMP.b #!Define_SMB1_SpriteID_NorSpr005_HammerBro
	BEQ.b CODE_03E183
	JSR.w SMB1_KillSprite
	LDY.b $01
	LDA.w !RAM_SMB1_Level_NorSpr_KillCounter,y
	CLC
	ADC.b #$04
	LDX.b $9E
	JSR.w CODE_03E07E
	LDX.b $01
	INC.w !RAM_SMB1_Level_NorSpr_KillCounter,x
CODE_03E1A7:
	LDA.w !RAM_SMB1_Level_NorSpr_KillCounter,x
	CLC
	ADC.b #!Define_SMAS_Sound0060_Stomp1-$01
	CMP.b #!Define_SMAS_Sound0060_Stomp7+$01
	BCC.b CODE_03E1B3
	LDA.b #$00
CODE_03E1B3:
	STA.w !RAM_SMB1_Global_SoundCh1
	RTS

CODE_03E1B7:
	TYA
	TAX
	JSR.w CODE_03E1BE
	LDX.b $9E
CODE_03E1BE:
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr00D_PiranhaPlant
	BEQ.b CODE_03E1E6
	CMP.b #!Define_SMB1_SpriteID_NorSpr011_Lakitu
	BEQ.b CODE_03E1E6
	CMP.b #!Define_SMB1_SpriteID_NorSpr005_HammerBro
	BEQ.b CODE_03E1E6
	CMP.b #!Define_SMB1_SpriteID_NorSpr012_Spiny
	BEQ.b CODE_03E1D8
	CMP.b #!Define_SMB1_SpriteID_NorSpr00E_GreenBouncingParakoopa
	BEQ.b CODE_03E1D8
	CMP.b #!Define_SMB1_SpriteID_NorSpr007_Blooper
	BCS.b CODE_03E1E6
CODE_03E1D8:
	LDA.b !RAM_SMB1_NorSpr_XSpeed,x
	EOR.b #$FF
	TAY
	INY
	STY.b !RAM_SMB1_NorSpr_XSpeed,x
	LDA.b $47,x
	EOR.b #$03
	STA.b $47,x
CODE_03E1E6:
	RTS

;--------------------------------------------------------------------

CODE_03E1E7:
	LDA.b #$FF
	STA.w $03A2,x
	LDA.w !RAM_SMB1_Level_FreezeSpritesTimer
	BNE.b CODE_03E21B
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	BMI.b CODE_03E21B
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr024_PulleyGirderPlatform
	BNE.b CODE_03E201
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	TAX
	JSR.w CODE_03E201
CODE_03E201:
	JSR.w CODE_03E2ED
	BCS.b CODE_03E21B
	TXA
	JSR.w CODE_03E2F9
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	STA.b $00
	TXA
	PHA
	JSR.w SMB1_CheckForContact_Main
	PLA
	TAX
	BCC.b CODE_03E21B
	JSR.w CODE_03E25F
CODE_03E21B:
	LDX.b $9E
	RTS

;--------------------------------------------------------------------

CODE_03E21E:
	LDA.w !RAM_SMB1_Level_FreezeSpritesTimer
	BNE.b CODE_03E25A
	STA.w $03A2,x
	JSR.w CODE_03E2ED
	BCS.b CODE_03E25A
	LDA.b #$02
	STA.b $00
CODE_03E22F:
	LDX.b $9E
	JSR.w CODE_03E2F7
	AND.b #$02
	BNE.b CODE_03E25A
	LDA.w !RAM_SMB1_Player_HitboxTopBoundary,y
	CMP.b #$20
	BCC.b CODE_03E244
	JSR.w SMB1_CheckForContact_Main
	BCS.b CODE_03E25D
CODE_03E244:
	LDA.w !RAM_SMB1_Player_HitboxTopBoundary,y
	CLC
	ADC.b #$80
	STA.w !RAM_SMB1_Player_HitboxTopBoundary,y
	LDA.w !RAM_SMB1_Player_HitboxBottomBoundary,y
	CLC
	ADC.b #$80
	STA.w !RAM_SMB1_Player_HitboxBottomBoundary,y
	DEC.b $00
	BNE.b CODE_03E22F
CODE_03E25A:
	LDX.b $9E
	RTS

;--------------------------------------------------------------------

CODE_03E25D:
	LDX.b $9E
CODE_03E25F:
	LDA.w !RAM_SMB1_Player_HitboxBottomBoundary,y
	SEC
	SBC.w !RAM_SMB1_Player_HitboxTopBoundary
	CMP.b #$04
	BCS.b CODE_03E272
	LDA.b !RAM_SMB1_Player_YSpeed
	BPL.b CODE_03E272
	LDA.b #$01
	STA.b !RAM_SMB1_Player_YSpeed
CODE_03E272:
	LDA.w !RAM_SMB1_Player_HitboxBottomBoundary
	SEC
	SBC.w !RAM_SMB1_Player_HitboxTopBoundary,y
	CMP.b #$06
	BCS.b CODE_03E298
	LDA.b !RAM_SMB1_Player_YSpeed
	BMI.b CODE_03E298
	LDA.b $00
	LDY.b !RAM_SMB1_NorSpr_SpriteID,x
	CPY.b #!Define_SMB1_SpriteID_NorSpr02B_UpMovingGirderPlatformLift
	BEQ.b CODE_03E28E
	CPY.b #!Define_SMB1_SpriteID_NorSpr02C_DownMovingGirderPlatformLift
	BEQ.b CODE_03E28E
	TXA
CODE_03E28E:
	LDX.b $9E
	STA.w $03A2,x
	LDA.b #$00
	STA.b !RAM_SMB1_Level_Player_CurrentPhysicsType
	RTS

CODE_03E298:
	LDA.b #$01
	STA.b $00
	LDA.w !RAM_SMB1_Player_HitboxRightBoundary
	SEC
	SBC.w !RAM_SMB1_Player_HitboxLeftBoundary,y
	CMP.b #$08
	BCC.b CODE_03E2B4
	INC.b $00
	LDA.w !RAM_SMB1_Player_HitboxRightBoundary,y
	CLC
	SBC.w !RAM_SMB1_Player_HitboxLeftBoundary
	CMP.b #$09
	BCS.b CODE_03E2B7
CODE_03E2B4:
	JSR.w CODE_03E6B5
CODE_03E2B7:
	LDX.b $9E
	RTS

;--------------------------------------------------------------------

DATA_03E2BA:
	db $80,$00

CODE_03E2BC:
	TAY
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	CLC
	ADC.w DATA_03E2BA-$01,y
	BNE.b CODE_03E2CE
	LDA.b #$02
	STA.b !RAM_SMB1_Player_YPosHi
	RTS

CODE_03E2CB:
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
CODE_03E2CE:
	LDY.b !RAM_SMB1_Player_CurrentState
	CPY.b #$0B
	BEQ.b CODE_03E2EC
	LDY.b !RAM_SMB1_NorSpr_YPosHi,x
	CPY.b #$01
	BNE.b CODE_03E2EC
	SEC
	SBC.b #$20
	STA.w !RAM_SMB1_Player_YPosLo
	TYA
	SBC.b #$00
	STA.b !RAM_SMB1_Player_YPosHi
	LDA.b #$00
	STA.b !RAM_SMB1_Player_YSpeed
	STA.w !RAM_SMB1_Player_SubYSpeed
CODE_03E2EC:
	RTS

;--------------------------------------------------------------------

CODE_03E2ED:
	LDA.w $03D0
	AND.b #$F0
	CLC
	BEQ.b CODE_03E2F6
	SEC
CODE_03E2F6:
	RTS

;--------------------------------------------------------------------

CODE_03E2F7:
	LDA.b $9E
CODE_03E2F9:
	ASL
	ASL
	CLC
	ADC.b #$04
	TAY
	LDA.w $03D1
	AND.b #$0F
	CMP.b #$0F
	RTS

;--------------------------------------------------------------------

; Note: Seems to be related to player collision with level data?

DATA_03E307:
	db $20,$10

SMB1_HandlePlayerLevelCollision:
.Main:
	LDA.w !RAM_SMB1_Level_Player_DisableObjectInteractionFlag
	BNE.b CODE_03E33D
	LDA.b !RAM_SMB1_Player_CurrentState
	CMP.b #$0B
	BEQ.b CODE_03E33D
	CMP.b #$04
	BCC.b CODE_03E33D
	LDA.b #$01
	LDY.w !RAM_SMB1_Level_UnderwaterLevelFlag
	BNE.b CODE_03E329
	LDA.b !RAM_SMB1_Level_Player_CurrentPhysicsType
	BEQ.b CODE_03E327
	CMP.b #$03
	BNE.b CODE_03E32B
CODE_03E327:
	LDA.b #$02
CODE_03E329:
	STA.b !RAM_SMB1_Level_Player_CurrentPhysicsType
CODE_03E32B:
	LDA.b !RAM_SMB1_Player_YPosHi
	CMP.b #$01
	BNE.b CODE_03E33D
	LDA.b #$FF
	STA.w $0480
	LDA.w !RAM_SMB1_Player_YPosLo
	CMP.b #$CF
	BCC.b CODE_03E33E
CODE_03E33D:
	RTS

CODE_03E33E:
	LDY.b #$02
	LDA.w !RAM_SMB1_Level_Player_IsDuckingFlag
	BNE.b CODE_03E351
	LDA.w !RAM_SMB1_Player_CurrentSize
	BNE.b CODE_03E351
	DEY
	LDA.w !RAM_SMB1_Level_UnderwaterLevelFlag
	BNE.b CODE_03E351
	DEY
CODE_03E351:
	LDA.w DATA_03EB3F,y
	STA.b !RAM_SMB1_Global_ScratchRAMEB
	TAY
	LDX.w !RAM_SMB1_Player_CurrentSize
	LDA.w !RAM_SMB1_Level_Player_IsDuckingFlag
	BEQ.b CODE_03E360
	INX
CODE_03E360:
	LDA.w !RAM_SMB1_Player_YPosLo
	CMP.w DATA_03E307,x
	BCC.b CODE_03E3A0
	LDA.b #$01
	STA.b !RAM_SMB1_Global_ScratchRAME4
	JSR.w CODE_03EB7B
	BEQ.b CODE_03E3A0
	JSR.w CODE_03E70D
	BCS.b CODE_03E3C9
	LDY.b !RAM_SMB1_Player_YSpeed
	BPL.b CODE_03E3A0
	LDY.b $04
	CPY.b #$04
	BCC.b CODE_03E3A0
	JSR.w CODE_03E6FB
	BCS.b CODE_03E393
	LDY.b !RAM_SMB1_Level_CurrentLevelType
	BEQ.b CODE_03E39C
	LDY.w $078C
	BNE.b CODE_03E39C
	JSR.w CODE_03BE7D
	BRA.b CODE_03E3A0

CODE_03E393:
	CMP.b #$2A
	BEQ.b CODE_03E39C
	LDA.b #!Define_SMAS_Sound0060_HitHead
	STA.w !RAM_SMB1_Global_SoundCh1
CODE_03E39C:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDY.b #$01
	LDA.w !RAM_SMB1_Level_CurrentLevelType
	BNE.b +
	DEY
+:
	STY.b !RAM_SMB1_Player_YSpeed
else
	LDA.b #$01
	STA.b !RAM_SMB1_Player_YSpeed
endif
CODE_03E3A0:
	LDY.b !RAM_SMB1_Global_ScratchRAMEB
	LDA.w !RAM_SMB1_Player_YPosLo
	CMP.b #$CF
	BCS.b CODE_03E40F
	STZ.b !RAM_SMB1_Global_ScratchRAME4
	JSR.w CODE_03EB7A
	JSR.w CODE_03E70D
	BCS.b CODE_03E3C9
	PHA
	STZ.b !RAM_SMB1_Global_ScratchRAME4
	JSR.w CODE_03EB7A
	STA.b $00
	PLA
	STA.b $01
	BNE.b CODE_03E3CC
	LDA.b $00
	BEQ.b CODE_03E40F
	JSR.w CODE_03E70D
	BCC.b CODE_03E3CC
CODE_03E3C9:
	JMP.w CODE_03E4C8

CODE_03E3CC:
	JSR.w CODE_03E706
	BCS.b CODE_03E40F
	LDY.b !RAM_SMB1_Player_YSpeed
	BMI.b CODE_03E40F
	CMP.b #$FD
	BNE.b CODE_03E3DC
	JMP.w CODE_03E4D1

CODE_03E3DC:
	JSR.w CODE_03E5FA
	BEQ.b CODE_03E40F
	LDY.w $070E
	BNE.b CODE_03E40B
	LDY.b $04
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	CPY.b #$06
else
	CPY.b #$05
endif
	BCC.b CODE_03E3F3
	LDA.b $46
	STA.b $00
	JMP.w CODE_03E6B5

CODE_03E3F3:
	JSR.w CODE_03E601
	LDA.b #$F0
	AND.w !RAM_SMB1_Player_YPosLo
	STA.w !RAM_SMB1_Player_YPosLo
	JSR.w CODE_03E625
	LDA.b #$00
	STA.b !RAM_SMB1_Player_YSpeed
	STA.w !RAM_SMB1_Player_SubYSpeed
	STA.w $0284
CODE_03E40B:
	LDA.b #$00
	STA.b !RAM_SMB1_Level_Player_CurrentPhysicsType
CODE_03E40F:
	LDY.b !RAM_SMB1_Global_ScratchRAMEB
	INY
	INY
	LDA.b #$02
	STA.b $00
CODE_03E417:
	INY
	STY.b !RAM_SMB1_Global_ScratchRAMEB
	LDA.w !RAM_SMB1_Player_YPosLo
	CMP.b #$20
	BCC.b CODE_03E439
	CMP.b #$E4
	BCS.b CODE_03E452
	STZ.b !RAM_SMB1_Global_ScratchRAME4
	JSR.w CODE_03EB7F
	BEQ.b CODE_03E439
	CMP.b #$20
	BEQ.b CODE_03E439
	CMP.b #$75
	BEQ.b CODE_03E439
	JSR.w CODE_03E706
	BCC.b CODE_03E453
CODE_03E439:
	LDY.b !RAM_SMB1_Global_ScratchRAMEB
	INY
	LDA.w !RAM_SMB1_Player_YPosLo
	CMP.b #$08
	BCC.b CODE_03E452
	CMP.b #$D0
	BCS.b CODE_03E452
	STZ.b !RAM_SMB1_Global_ScratchRAME4
	JSR.w CODE_03EB7F
	BNE.b CODE_03E453
	DEC.b $00
	BNE.b CODE_03E417
CODE_03E452:
	RTS

CODE_03E453:
	JSR.w CODE_03E5FA
	BEQ.b CODE_03E4C5
	JSR.w CODE_03E706
	BCC.b CODE_03E460
	JMP.w CODE_03E526

CODE_03E460:
	JSR.w CODE_03E70D
	BCS.b CODE_03E4C8
	JSR.w CODE_03E61A
	BCC.b CODE_03E472
	LDA.w $070E
	BNE.b CODE_03E4C5
	JMP.w CODE_03E4C2

CODE_03E472:
	LDY.b !RAM_SMB1_Level_Player_CurrentPhysicsType
	CPY.b #$00
	BNE.b CODE_03E4C2
	LDY.w !RAM_SMB1_Level_Player_FacingDirection
	DEY
	BNE.b CODE_03E4C2
	CMP.b #$76
	BEQ.b CODE_03E486
	CMP.b #$23
	BNE.b CODE_03E4C2
CODE_03E486:
	LDA.w $0256
	BEQ.b CODE_03E499
	LDY.b $9A
	BNE.b CODE_03E499
	LDY.b #!Define_SMAS_Sound0060_IntoPipe
	STY.w !RAM_SMB1_Global_SoundCh1
	STY.b $9A
	STZ.w !RAM_SMB1_Player_StarPowerTimer
CODE_03E499:
	AND.b #$CF
	STA.w $0256
	LDA.w !RAM_SMB1_Player_XPosLo
	AND.b #$0F
	BEQ.b CODE_03E4B3
	LDY.b #$00
	LDA.w $071A
	BEQ.b CODE_03E4AD
	INY
CODE_03E4AD:
	LDA.w DATA_03E4C6,y
	STA.w !RAM_SMB1_Player_WaitBeforeWarpingInPipe
CODE_03E4B3:
	LDA.b !RAM_SMB1_Player_CurrentState
	CMP.b #$07
	BEQ.b CODE_03E4C5
	CMP.b #$08
	BNE.b CODE_03E4C5
	LDA.b #$02
	STA.b !RAM_SMB1_Player_CurrentState
	RTS

CODE_03E4C2:
	JSR.w CODE_03E6B5
CODE_03E4C5:
	RTS

DATA_03E4C6:
	db $34,$34

CODE_03E4C8:
	JSR.w CODE_03E514
	INC.w $0748
	JMP.w CODE_03BD34

;--------------------------------------------------------------------

CODE_03E4D1:
	LDA.b #$00
	STA.w $0772
	LDA.b #$02
	STA.w !RAM_SMB1_Global_GameMode
	LDA.w !REGISTER_APUPort2
	CMP.b #!Define_SMB1_LevelMusic_PassedBoss
	BEQ.b CODE_03E4E7
	LDA.b #!Define_SMB1_LevelMusic_StopMusicCommand
	STA.w !RAM_SMB1_Global_MusicCh1
CODE_03E4E7:
	LDA.b #$18
	STA.b !RAM_SMB1_Player_XSpeed
	PHX
	LDX.b #$00
CODE_03E4EE:
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr02D_Bowser
	BNE.b CODE_03E50E
	LDA.b !RAM_SMB1_NorSpr_SpriteSlotExistsFlag,x
	CMP.b #$01
	BNE.b CODE_03E50E
	LDA.w !RAM_SMB1_NorSpr_XPosLo,x
	SEC
	SBC.w !RAM_SMB1_Global_CurrentLayer1XPosLo
	STA.w $03AE
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	STA.w $03B9
	JSL.l SMB1_BowserGFXRt_Main
CODE_03E50E:
	INX
	CPX.b #$09
	BNE.b CODE_03E4EE
	PLX
CODE_03E514:
	LDY.b $02
	LDA.b #$00
	STA.b ($06),y
	JMP.w CODE_039380

;--------------------------------------------------------------------

; Note: Something related to touching the flagpole.

DATA_03E51D:
	db $F9,$07

DATA_03E51F:
	db $FF,$00

DATA_03E521:
	db $18,$22,$50,$68,$90

CODE_03E526:
	LDY.b $04
	CPY.b #$06
	BCC.b CODE_03E530
	CPY.b #$0A
	BCC.b CODE_03E531
CODE_03E530:
	RTS

CODE_03E531:
	CMP.b #$28
	BEQ.b CODE_03E539
	CMP.b #$29
	BNE.b CODE_03E57E
CODE_03E539:
	LDA.b !RAM_SMB1_Player_CurrentState
	CMP.b #$05
	BEQ.b CODE_03E58D
	LDA.b #$01
	STA.w !RAM_SMB1_Level_Player_FacingDirection
	INC.w !RAM_SMB1_Level_DisableScrollingFlag
	LDA.b !RAM_SMB1_Player_CurrentState
	CMP.b #$04
	BEQ.b CODE_03E577
	LDA.b #!Define_SMB1_SpriteID_NorSpr033_BulletBillLauncher
	JSR.w CODE_03A885
	JSL.l SMB1_SpawnCastleTilesWithPriority_Main
	LDA.b #!Define_SMB1_LevelMusic_StopMusicCommand
	STA.w !RAM_SMB1_Global_MusicCh1
	LDA.b #!Define_SMAS_Sound0060_GrabFlagpole
	STA.w !RAM_SMB1_Global_SoundCh1
	LSR
	STA.w $0713
	LDX.b #$04
	LDA.w !RAM_SMB1_Player_YPosLo
	STA.w $070F
CODE_03E56C:
	CMP.w DATA_03E521,x
	BCS.b CODE_03E574
	DEX
	BNE.b CODE_03E56C
CODE_03E574:
	STX.w !RAM_SMB1_Level_GoalFlagScoreAmountIndex
CODE_03E577:
	LDA.b #$04
	STA.b !RAM_SMB1_Player_CurrentState
	JMP.w CODE_03E58D

CODE_03E57E:
	CMP.b #$2A
	BNE.b CODE_03E58D
	LDA.w !RAM_SMB1_Player_YPosLo
	CMP.b #$20
	BCS.b CODE_03E58D
	LDA.b #$01
	STA.b !RAM_SMB1_Player_CurrentState
CODE_03E58D:
	LDA.b #$03
	STA.b !RAM_SMB1_Level_Player_CurrentPhysicsType
	LDA.b #$00
	STA.b !RAM_SMB1_Player_XSpeed
	STA.w $0705
	LDA.w $0398
	BEQ.b CODE_03E5CC
	LDA.w $03AE
	BPL.b CODE_03E5CC
	CMP.b #$F8
	BCC.b CODE_03E5CC
	LDA.w $0082
	STA.b !RAM_SMB1_Global_ScratchRAME5
	LDA.w $0223
	STA.b !RAM_SMB1_Global_ScratchRAME4
	REP.b #$20
	LDA.b !RAM_SMB1_Global_ScratchRAME4
	CLC
	ADC.w #$0007
	STA.b !RAM_SMB1_Global_ScratchRAME4
	SEP.b #$20
	LDA.b !RAM_SMB1_Global_ScratchRAME4
	STA.w !RAM_SMB1_Player_XPosLo
	LDA.b !RAM_SMB1_Global_ScratchRAME5
	STA.b !RAM_SMB1_Player_XPosHi
	LDA.b #$02
	STA.w !RAM_SMB1_Level_Player_FacingDirection
	BRA.b CODE_03E5F9

CODE_03E5CC:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMB1_J) != $00
	LDA.w !RAM_SMB1_NorSpr_XPosLo+$09
else
	LDA.w !RAM_SMB1_Player_XPosLo
endif
	SEC
	SBC.w $071C
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMB1_J) != $00
	BPL.b CODE_03E5DC
else
	CMP.b #$10
	BCS.b CODE_03E5DC
endif
	LDA.b #$02
	STA.w !RAM_SMB1_Level_Player_FacingDirection
CODE_03E5DC:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMB1_J) != $00
	LDA.w $03AD
	BNE.b +
	LDA.w !RAM_SMB1_Player_YPosLo
	AND.b #$F0
	STA.w !RAM_SMB1_Player_YPosLo
+:
endif
	LDY.w !RAM_SMB1_Level_Player_FacingDirection
	LDA.b $06
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC.w DATA_03E51D-$01,y
	STA.w !RAM_SMB1_Player_XPosLo
	LDA.b $06
	BNE.b CODE_03E5F9
	LDA.w $071B
	CLC
	ADC.w DATA_03E51F-$01,y
	STA.b !RAM_SMB1_Player_XPosHi
CODE_03E5F9:
	RTS

;--------------------------------------------------------------------

CODE_03E5FA:
	CMP.b #$62
	BEQ.b CODE_03E600
	CMP.b #$63
CODE_03E600:
	RTS

;--------------------------------------------------------------------

CODE_03E601:
	JSR.w CODE_03E61A
	BCC.b CODE_03E619
	LDA.b #$70
	STA.w $0709
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDA.b #$F8
else
	LDA.b #$F9
endif
	STA.w $06DB
	LDA.b #$03
	STA.w $078E
	LSR
	STA.w $070E
CODE_03E619:
	RTS

;--------------------------------------------------------------------

CODE_03E61A:
	CMP.b #$6F
	BEQ.b CODE_03E623
	CMP.b #$70
	CLC
	BNE.b CODE_03E624
CODE_03E623:
	SEC
CODE_03E624:
	RTS

;--------------------------------------------------------------------

; Note:  Something related to going down a pipe.

CODE_03E625:
	LDA.b !RAM_SMB1_Global_ControllerUpDownHeld
	AND.b #!Joypad_DPadD>>8
	BEQ.b CODE_03E624
	LDA.b $00
	CMP.b #$15
	BNE.b CODE_03E624
	LDA.b $01
	CMP.b #$14
	BNE.b CODE_03E624
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDA.b #$28
else
	LDA.b #$30
endif
	STA.w !RAM_SMB1_Player_WaitBeforeWarpingInPipe
	LDA.b #$03
	STA.b !RAM_SMB1_Player_CurrentState
	LDA.b #$04
	STA.w !RAM_SMB1_Player_HurtTimer
	STZ.w !RAM_SMB1_Player_StarPowerTimer
	LDA.b #$00
	STA.w $0256
	LDA.w !RAM_SMB1_Level_WarpZoneActiveFlag
	BEQ.b CODE_03E6AF
	CMP.b #$04
	BCS.b CODE_03E668
	LDX.b #$04
	LDA.w !RAM_SMB1_Player_CurrentWorld
	BEQ.b CODE_03E664
	INX
	LDA.b !RAM_SMB1_Level_CurrentLevelType
	DEC
	BNE.b CODE_03E664
	INX
CODE_03E664:
	TXA
	STA.w !RAM_SMB1_Level_WarpZoneActiveFlag
CODE_03E668:
	AND.b #$03
	ASL
	ASL
	TAX
	LDA.w !RAM_SMB1_Player_XPosLo
	CMP.b #$60
	BCC.b CODE_03E67A
	INX
	CMP.b #$A0
	BCC.b CODE_03E67A
	INX
CODE_03E67A:
	LDY.w DATA_0390E5,x
	DEY
	STY.w !RAM_SMB1_Player_CurrentWorld
	TYX
	LDA.l SMB1_LevelData_LevelIDRelativePtrs,x
	TAX
	LDA.l SMB1_LevelData_LevelIDsAndTileset,x
	STA.w !RAM_SMB1_Level_SublevelIDAndTileset
	LDA.b #!Define_SMB1_LevelMusic_MusicFade
	STA.w !RAM_SMB1_Global_MusicCh1
	LDA.b #$00
	STA.w !RAM_SMB1_Level_SublevelStartingScreen
	STA.w !RAM_SMB1_Player_CurrentLevel
	STA.w !RAM_SMB1_Player_CurrentLevelNumberDisplay
	STA.w !RAM_SMB1_Level_Player_TriggeredScreenExitFlag
	INC.w !RAM_SMB1_Level_CanFindHidden1upFlag
	INC.w $0757
	LDA.b #!Define_SMB1_LevelMusic_CopyOfMusicFade
	STA.w !RAM_SMB1_Global_MusicCh1
	STA.w $0E1A
CODE_03E6AF:
	LDA.b #!Define_SMAS_Sound0060_IntoPipe
	STA.w !RAM_SMB1_Global_SoundCh1
	RTS

;--------------------------------------------------------------------

CODE_03E6B5:
	LDA.b #$00
	LDY.b !RAM_SMB1_Player_XSpeed
	LDX.b $00
	DEX
	BNE.b CODE_03E6C8
	INX
	CPY.b #$00
	BMI.b CODE_03E6ED
	LDA.b #$FF
	JMP.w CODE_03E6D0

CODE_03E6C8:
	LDX.b #$02
	CPY.b #$01
	BPL.b CODE_03E6ED
	LDA.b #$01
CODE_03E6D0:
	LDY.b #$10
	STY.w $078D
	LDY.b #$00
	STY.b !RAM_SMB1_Player_XSpeed
	CMP.b #$00
	BPL.b CODE_03E6DE
	DEY
CODE_03E6DE:
	STY.b $00
	CLC
	ADC.w !RAM_SMB1_Player_XPosLo
	STA.w !RAM_SMB1_Player_XPosLo
	LDA.b !RAM_SMB1_Player_XPosHi
	ADC.b $00
	STA.b !RAM_SMB1_Player_XPosHi
CODE_03E6ED:
	TXA
	EOR.b #$FF
	AND.w $0480
	STA.w $0480
	RTS

;--------------------------------------------------------------------

DATA_03E6F7:
	db $14,$64,$8C,$FC

CODE_03E6FB:
	JSR.w CODE_03E71D
	CMP.w DATA_03E6F7,x
	RTS

;--------------------------------------------------------------------

DATA_03E702:
	db $28,$77,$8E,$FE

CODE_03E706:
	JSR.w CODE_03E71D
	CMP.w DATA_03E702,x
	RTS

;--------------------------------------------------------------------

CODE_03E70D:
	CMP.b #$E9
	BEQ.b CODE_03E717
	CMP.b #$EA
	BEQ.b CODE_03E717
	CLC
	RTS

CODE_03E717:
	LDA.b #!Define_SMAS_Sound0063_Coin
	STA.w !RAM_SMB1_Global_SoundCh3
	RTS

;--------------------------------------------------------------------

CODE_03E71D:
	TAY
	AND.b #$C0
	ASL
	ROL
	ROL
	TAX
	TYA
CODE_03E725:
	RTS

;--------------------------------------------------------------------

DATA_03E726:
	db $01,$01,$02,$02,$02,$05

DATA_03E72C:
	db $10,$F0

SMB1_HandleNormalSpriteLevelCollision:
.Main:
;$03E72E
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	AND.b #$20
	BNE.b CODE_03E725
	JSR.w CODE_03E8D8						;\ Glitch: If a koopa is at a Y position of C2-FF, this will cause it to ignore gravity when stomped.
	BCC.b CODE_03E725						;/
	LDY.b !RAM_SMB1_NorSpr_SpriteID,x
	CPY.b #!Define_SMB1_SpriteID_NorSpr012_Spiny
	BNE.b CODE_03E746
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	CMP.b #$25
	BCC.b CODE_03E725
CODE_03E746:
	CPY.b #!Define_SMB1_SpriteID_NorSpr00E_GreenBouncingParakoopa
	BNE.b CODE_03E74D
	JMP.w CODE_03E8E1

CODE_03E74D:
	CPY.b #!Define_SMB1_SpriteID_NorSpr005_HammerBro
	BNE.b CODE_03E754
	JMP.w CODE_03E903

CODE_03E754:
	CPY.b #!Define_SMB1_SpriteID_NorSpr012_Spiny
	BEQ.b CODE_03E760
	CPY.b #!Define_SMB1_SpriteID_NorSpr02E_Powerup
	BEQ.b CODE_03E760
	CPY.b #!Define_SMB1_SpriteID_NorSpr007_Blooper
	BCS.b CODE_03E7D5
CODE_03E760:
	JSR.w CODE_03E92C
	BNE.w CODE_03E768
CODE_03E765:
	JMP.w CODE_03E851

CODE_03E768:
	JSR.w CODE_03E933
	BEQ.b CODE_03E765
	CMP.b #$27
	BNE.b CODE_03E7D6
	LDY.b $02
	LDA.b #$00
	STA.b ($06),y
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr015_BowserFireGenerator
	BCS.b CODE_03E789
	CMP.b #!Define_SMB1_SpriteID_NorSpr006_Goomba
	BNE.b CODE_03E784
	JSR.w CODE_03E90C
CODE_03E784:
	LDA.b #$01
	JSR.w CODE_03E07E
CODE_03E789:										; Todo: Are some of these CMP.b actually checking !RAM_SMB1_NorSpr_SpriteID?
	CMP.b #!Define_SMB1_SpriteID_NorSpr009_StationaryYellowParakoopa
	BCC.b CODE_03E79D
	CMP.b #!Define_SMB1_SpriteID_NorSpr011_Lakitu
	BCS.b CODE_03E79D
	CMP.b #!Define_SMB1_SpriteID_NorSpr00A_GreenSwimmingCheepCheep
	BCC.b CODE_03E799
	CMP.b #!Define_SMB1_SpriteID_NorSpr00D_PiranhaPlant
	BCC.b CODE_03E79D
CODE_03E799:
	AND.b #$01
	STA.b !RAM_SMB1_NorSpr_SpriteID,x
CODE_03E79D:
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	AND.b #$F0
	ORA.b #$02
	STA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	DEC.w !RAM_SMB1_NorSpr_YPosLo,x
	DEC.w !RAM_SMB1_NorSpr_YPosLo,x
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr007_Blooper
	BEQ.b CODE_03E7B7
	LDA.b #$FD
	LDY.b !RAM_SMB1_Level_CurrentLevelType
	BNE.b CODE_03E7B9
CODE_03E7B7:
	LDA.b #$FF
CODE_03E7B9:
	STA.b !RAM_SMB1_NorSpr_YSpeed,x
	LDY.b #$01
	JSR.w SMB1_CheckPlayerPositionRelativeToSprite_X
	BPL.b CODE_03E7C3
	INY
CODE_03E7C3:
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr033_BulletBillLauncher
	BEQ.b CODE_03E7CF
	CMP.b #!Define_SMB1_SpriteID_NorSpr008_BulletBill
	BEQ.b CODE_03E7CF
	STY.b $47,x
CODE_03E7CF:
	DEY
	LDA.w DATA_03E72C,y
	STA.b !RAM_SMB1_NorSpr_XSpeed,x
CODE_03E7D5:
	RTS

CODE_03E7D6:
	LDA.b $04
	SEC
	SBC.b #$08
	CMP.b #$05
	BCS.b CODE_03E851
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	AND.b #$40
	BNE.b CODE_03E83C
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	ASL
	BCC.b CODE_03E7ED
CODE_03E7EA:
	JMP.w CODE_03E86D

CODE_03E7ED:
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	BEQ.b CODE_03E7EA
	CMP.b #$05
	BEQ.b CODE_03E814
	CMP.b #$03
	BCS.b CODE_03E813
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	CMP.b #$02
	BNE.b CODE_03E814
	LDA.b #$10
	LDY.b !RAM_SMB1_NorSpr_SpriteID,x
	CPY.b #!Define_SMB1_SpriteID_NorSpr012_Spiny
	BNE.b CODE_03E809
	LDA.b #$00
CODE_03E809:
	STA.w $07A2,x
	LDA.b #$03
	STA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	JSR.w CODE_03E8CA
CODE_03E813:
	RTS

CODE_03E814:
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr006_Goomba
	BEQ.b CODE_03E83C
	CMP.b #!Define_SMB1_SpriteID_NorSpr012_Spiny
	BNE.b CODE_03E82C
	LDA.b #$01
	STA.b $47,x
	LDA.b #$08
	STA.b !RAM_SMB1_NorSpr_XSpeed,x
	LDA.b !RAM_SMB1_Global_FrameCounter
	AND.b #$07
	BEQ.b CODE_03E83C
CODE_03E82C:
	LDY.b #$01
	JSR.w SMB1_CheckPlayerPositionRelativeToSprite_X
	BPL.b CODE_03E834
	INY
CODE_03E834:
	TYA
	CMP.b $47,x
	BNE.b CODE_03E83C
	JSR.w CODE_03E894
CODE_03E83C:
	JSR.w CODE_03E8CA
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	AND.b #$80
	BNE.b CODE_03E84A
	LDA.b #$00
	STA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	RTS

CODE_03E84A:
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	AND.b #$BF
	STA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	RTS

CODE_03E851:
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr003_RedKoopa
	BNE.b CODE_03E85B
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	BEQ.b CODE_03E894
CODE_03E85B:
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	TAY
	ASL
	BCC.b CODE_03E868
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	ORA.b #$40
	JMP.w CODE_03E86B

CODE_03E868:
	LDA.w DATA_03E726,y
CODE_03E86B:
	STA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
CODE_03E86D:
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	CMP.b #$20
	BCC.b CODE_03E893
	LDY.b #$16
	LDA.b #$02
	STA.b !RAM_SMB1_Global_ScratchRAMEB
CODE_03E87A:
	LDA.b !RAM_SMB1_Global_ScratchRAMEB
	CMP.b $47,x
	BNE.b CODE_03E88C
	LDA.b #$01
	JSR.w CODE_03EB1A
	BEQ.b CODE_03E88C
	JSR.w CODE_03E933
	BNE.b CODE_03E894
CODE_03E88C:
	DEC.b !RAM_SMB1_Global_ScratchRAMEB
	INY
	CPY.b #$18
	BCC.b CODE_03E87A
CODE_03E893:
	RTS

CODE_03E894:
	CPX.b #$09
	BEQ.b CODE_03E8AA
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	ASL
	BCC.b CODE_03E8AA
	CPX.b #$09
	BEQ.b CODE_03E8AA
	LDA.b #!Define_SMAS_Sound0060_HitHead
	STA.w !RAM_SMB1_Global_SoundCh1
	JSL.l SMB1_InitializeContactSprite_Main
CODE_03E8AA:
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr005_HammerBro
	BNE.b CODE_03E8B9
	LDA.b #$00
	STA.b $00
	LDY.b #$FA
	JMP.w CODE_03CEC7

CODE_03E8B9:
	JMP.w CODE_03E1D8

;--------------------------------------------------------------------

SMB1_CheckPlayerPositionRelativeToSprite:
.X:
;$03E8BC
	LDA.w !RAM_SMB1_NorSpr_XPosLo,x
	SEC
	SBC.w !RAM_SMB1_Player_XPosLo
	STA.b $00
	LDA.b !RAM_SMB1_NorSpr_XPosHi,x
	SBC.b !RAM_SMB1_Player_XPosHi
	RTS

;--------------------------------------------------------------------

CODE_03E8CA:
	JSR.w CODE_03C726
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	AND.b #$F0
	ORA.b #$08
	STA.w !RAM_SMB1_NorSpr_YPosLo,x
	RTS

;--------------------------------------------------------------------

CODE_03E8D8:
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	CLC
	ADC.b #$3E
	CMP.b #$44
	RTS

;--------------------------------------------------------------------

CODE_03E8E1:
	JSR.w CODE_03E8D8
	BCC.b CODE_03E900
	LDA.b !RAM_SMB1_NorSpr_YSpeed,x
	CLC
	ADC.b #$02
	CMP.b #$03
	BCC.b CODE_03E900
	JSR.w CODE_03E92C
	BEQ.b CODE_03E900
	JSR.w CODE_03E933
	BEQ.b CODE_03E900
	JSR.w CODE_03E8CA
	LDA.b #$FD
	STA.b !RAM_SMB1_NorSpr_YSpeed,x
CODE_03E900:
	JMP.w CODE_03E86D

;--------------------------------------------------------------------

CODE_03E903:
	JSR.w CODE_03E92C
	BEQ.b CODE_03E925
	CMP.b #$27
	BNE.b CODE_03E914
CODE_03E90C:
	JSR.w SMB1_KillSprite
	LDA.b #$FC
	STA.b !RAM_SMB1_NorSpr_YSpeed,x
	RTS

CODE_03E914:
	LDA.w $0792,x
	BNE.b CODE_03E925
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	AND.b #$88
	STA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	JSR.w CODE_03E8CA
	JMP.w CODE_03E86D

CODE_03E925:
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	ORA.b #$01
	STA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	RTS

;--------------------------------------------------------------------

CODE_03E92C:
	LDA.b #$00
	LDY.b #$15
	JMP.w CODE_03EB1A

;--------------------------------------------------------------------

CODE_03E933:
	CMP.b #$2A
	BEQ.b CODE_03E945
	CMP.b #$E9
	BEQ.b CODE_03E945
	CMP.b #$EA
	BEQ.b CODE_03E945
	CMP.b #$62
	BEQ.b CODE_03E945
	CMP.b #$63
CODE_03E945:
	RTS

;--------------------------------------------------------------------

CODE_03E946:
	LDA.w !RAM_SMB1_FireSpr_YPosLo,x
	CMP.b #$18
	BCC.b CODE_03E972
	JSR.w CODE_03EB2E
	BEQ.b CODE_03E972
	JSR.w CODE_03E933
	BEQ.b CODE_03E972
	LDA.b !RAM_SMB1_FireSpr_YSpeed,x
	BMI.b CODE_03E978
	LDA.w !RAM_SMB1_FireSpr_HitGroundFlag,x
	BNE.b CODE_03E978
	LDA.b #$FD
	STA.b !RAM_SMB1_FireSpr_YSpeed,x
	LDA.b #$01
	STA.w !RAM_SMB1_FireSpr_HitGroundFlag,x
	LDA.w !RAM_SMB1_FireSpr_YPosLo,x
	AND.b #$F8
	STA.w !RAM_SMB1_FireSpr_YPosLo,x
	RTS

CODE_03E972:
	LDA.b #$00
	STA.w !RAM_SMB1_FireSpr_HitGroundFlag,x
	RTS

CODE_03E978:
	LDA.b #$80
	STA.b $33,x
	LDA.b #!Define_SMAS_Sound0060_HitHead
	STA.w !RAM_SMB1_Global_SoundCh1
	RTS

;--------------------------------------------------------------------

SMB1_SpriteClippingValues:				; Info: ...
.Main:
;$03E982
	db $02,$08,$0E,$20				; $00 - Big Player hitbox
	db $03,$14,$0D,$20				; $01 - Small Player hitbox
	db $02,$14,$0E,$20
	db $02,$09,$0E,$15
	db $00,$00,$18,$06
	db $00,$00,$20,$0D
	db $00,$00,$30,$0D
	db $00,$00,$08,$08
	db $06,$04,$0A,$0C
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	db $03,$0C,$0D,$14
else
	db $03,$0E,$0D,$14
endif
	db $04,$04,$1C,$1C
	db $04,$04,$0C,$1C
	db $03,$07,$0D,$16

;--------------------------------------------------------------------

CODE_03E9B6:
	TXA
	CLC
	ADC.b #$0B
	TAX
	LDY.b #$02
	BNE.b CODE_03E9C6						; Note: This will always branch

CODE_03E9BF:
	TXA
	CLC
	ADC.b #$0D
	TAX
	LDY.b #$06
CODE_03E9C6:
	JSR.w CODE_03EA2D
	JMP.w CODE_03EA6F

;--------------------------------------------------------------------

; Note: Sprite to sprite collision routine.

CODE_03E9CC:
	LDY.b #$48
	STY.b $00
	LDY.b #$44
	JMP.w CODE_03E9DB

CODE_03E9D5:
	LDY.b #$08
	STY.b $00
	LDY.b #$04
CODE_03E9DB:
	LDA.w !RAM_SMB1_NorSpr_XPosLo,x
	SEC
	SBC.w $071C
	STA.b $01
	LDA.b !RAM_SMB1_NorSpr_XPosHi,x
	SBC.w $071A
	BMI.b CODE_03E9F1
	ORA.b $01
	BEQ.b CODE_03E9F1
	LDY.b $00
CODE_03E9F1:
	TYA
	AND.w $03D1
	STA.w $03D9,x
	CPX.b #$09
	BEQ.b CODE_03EA0D
	LDA.w $03D9,x
	BNE.b CODE_03EA1A
	JMP.w CODE_03EA0D

CODE_03EA04:
	INX
	JSR.w CODE_03FE1E
	DEX
	CMP.b #$FE
	BCS.b CODE_03EA1A
CODE_03EA0D:
	TXA
	CLC
	ADC.b #$01
	TAX
	LDY.b #$01
	JSR.w CODE_03EA2D
	JMP.w CODE_03EA6F

CODE_03EA1A:
	TXA
	ASL
	ASL
	TAY
	LDA.b #$FF
	STA.w !RAM_SMB1_NorSpr_HitboxLeftBoundary,y
	STA.w !RAM_SMB1_NorSpr_HitboxTopBoundary,y
	STA.w !RAM_SMB1_NorSpr_HitboxRightBoundary,y
	STA.w !RAM_SMB1_NorSpr_HitboxBottomBoundary,y
	RTS

CODE_03EA2D:
	STX.b $00
	LDA.w $03B8,y
	STA.b $02
	LDA.w $03AD,y
	STA.b $01
	TXA
	ASL
	ASL
	PHA
	TAY
	LDA.w !RAM_SMB1_Player_HitboxSizeIndex,x
	ASL
	ASL
	TAX
	LDA.b $01
	CLC
	ADC.w SMB1_SpriteClippingValues_Main,x
	STA.w !RAM_SMB1_Player_HitboxLeftBoundary,y
	LDA.b $01
	CLC
	ADC.w SMB1_SpriteClippingValues_Main+$02,x
	STA.w !RAM_SMB1_Player_HitboxRightBoundary,y
	INX
	INY
	LDA.b $02
	CLC
	ADC.w SMB1_SpriteClippingValues_Main,x
	STA.w !RAM_SMB1_Player_HitboxTopBoundary-$01,y
	LDA.b $02
	CLC
	ADC.w SMB1_SpriteClippingValues_Main+$02,x
	STA.w !RAM_SMB1_Player_HitboxBottomBoundary-$01,y
	PLA
	TAY
	LDX.b $00
	RTS

CODE_03EA6F:
	LDA.w $071C
	CLC
	ADC.b #$80
	STA.b $02
	LDA.w $071A
	ADC.b #$00
	STA.b $01
	LDA.w !RAM_SMB1_Player_XPosLo,x
	CMP.b $02
	LDA.b !RAM_SMB1_Player_XPosHi,x
	SBC.b $01
	BCC.b CODE_03EA9E
	LDA.w !RAM_SMB1_Player_HitboxRightBoundary,y
	BMI.b CODE_03EA9B
	LDA.b #$FF
	LDX.w !RAM_SMB1_Player_HitboxLeftBoundary,y
	BMI.b CODE_03EA98
	STA.w !RAM_SMB1_Player_HitboxLeftBoundary,y
CODE_03EA98:
	STA.w !RAM_SMB1_Player_HitboxRightBoundary,y
CODE_03EA9B:
	LDX.b $9E
	RTS

CODE_03EA9E:
	LDA.w !RAM_SMB1_Player_HitboxLeftBoundary,y
	BPL.b CODE_03EAB4
	CMP.b #$A0
	BCC.b CODE_03EAB4
	LDA.b #$00
	LDX.w !RAM_SMB1_Player_HitboxRightBoundary,y
	BPL.b CODE_03EAB1
	STA.w !RAM_SMB1_Player_HitboxRightBoundary,y
CODE_03EAB1:
	STA.w !RAM_SMB1_Player_HitboxLeftBoundary,y
CODE_03EAB4:
	LDX.b $9E
	RTS

;--------------------------------------------------------------------

SMB1_CheckForContact:
.Main:
;$03EAB7
	LDX.b #$00
CODE_03EAB9:
	STY.b $06
	LDA.b #$01
	STA.b $07
CODE_03EABF:
	LDA.w !RAM_SMB1_Player_HitboxLeftBoundary,y
	CMP.w !RAM_SMB1_Player_HitboxLeftBoundary,x
	BCS.b CODE_03EAF1
	CMP.w !RAM_SMB1_Player_HitboxRightBoundary,x
	BCC.b CODE_03EADE
	BEQ.b CODE_03EB10
	LDA.w !RAM_SMB1_Player_HitboxRightBoundary,y
	CMP.w !RAM_SMB1_Player_HitboxLeftBoundary,y
	BCC.b CODE_03EB10
	CMP.w !RAM_SMB1_Player_HitboxLeftBoundary,x
	BCS.b CODE_03EB10
	LDY.b $06
	RTS

CODE_03EADE:
	LDA.w !RAM_SMB1_Player_HitboxRightBoundary,x
	CMP.w !RAM_SMB1_Player_HitboxLeftBoundary,x
	BCC.b CODE_03EB10
	LDA.w !RAM_SMB1_Player_HitboxRightBoundary,y
	CMP.w !RAM_SMB1_Player_HitboxLeftBoundary,x
	BCS.b CODE_03EB10
	LDY.b $06
	RTS

CODE_03EAF1:
	CMP.w !RAM_SMB1_Player_HitboxLeftBoundary,x
	BEQ.b CODE_03EB10
	CMP.w !RAM_SMB1_Player_HitboxRightBoundary,x
	BCC.b CODE_03EB10
	BEQ.b CODE_03EB10
	CMP.w !RAM_SMB1_Player_HitboxRightBoundary,y
	BCC.b CODE_03EB0C
	BEQ.b CODE_03EB0C
	LDA.w !RAM_SMB1_Player_HitboxRightBoundary,y
	CMP.w !RAM_SMB1_Player_HitboxLeftBoundary,x
	BCS.b CODE_03EB10
CODE_03EB0C:
	CLC
	LDY.b $06
	RTS

CODE_03EB10:
	INX
	INY
	DEC.b $07
	BPL.b CODE_03EABF
	SEC
	LDY.b $06
	RTS

;--------------------------------------------------------------------

CODE_03EB1A:
	PHA
	TXA
	CLC
	ADC.b #$01
	TAX
	PLA
	JMP.w CODE_03EB37

CODE_03EB24:
	TXA
	CLC
	ADC.b #$11
	TAX
	LDY.b #$1B
	JMP.w CODE_03EB35

CODE_03EB2E:
	LDY.b #$1A
	TXA
	CLC
	ADC.b #$0B
	TAX
CODE_03EB35:
	LDA.b #$00
CODE_03EB37:
	JSR.w CODE_03EB83
	LDX.b $9E
	CMP.b #$00
	RTS

;--------------------------------------------------------------------

DATA_03EB3F:
	db $00,$07,$0E

;--------------------------------------------------------------------

; Note: Routine related to player collision with level data.

DATA_03EB42:
	db $08,$03,$0C,$02,$02,$0D,$0D,$08
	db $03,$0C,$02,$02,$0D,$0D,$08,$03
	db $0C,$02,$02,$0D,$0D,$08,$00,$10
	db $04,$14,$04,$04

DATA_03EB5E:
	db $04,$20,$20,$08,$18,$08,$18,$02
	db $20,$20,$08,$18,$08,$18,$12,$20
	db $20,$18,$18,$18,$18,$18,$14,$14
	db $06,$06,$08,$10

CODE_03EB7A:
	INY
CODE_03EB7B:
	LDA.b #$00
	BRA.b CODE_03EB81

CODE_03EB7F:
	LDA.b #$01
CODE_03EB81:
	LDX.b #$00
CODE_03EB83:
	PHA
	STY.b $04
	LDA.w DATA_03EB42,y
	CLC
	ADC.w !RAM_SMB1_Player_XPosLo,x
	STA.b $05
	LDA.b !RAM_SMB1_Player_XPosHi,x
	ADC.b #$00
	AND.b #$01
	LSR
	ORA.b $05
	ROR
	LSR
	LSR
	LSR
	JSR.w CODE_03ACF6
	LDY.b $04
	LDA.w !RAM_SMB1_Player_YPosLo,x
	CLC
	ADC.w DATA_03EB5E,y
	AND.b #$F0
	SEC
	SBC.b #$20
	STA.b $02
	TAY
	LDA.b ($06),y
	STA.b $03
	LDY.b $04
	PLA
	BNE.b CODE_03EBBF
	LDA.w !RAM_SMB1_Player_YPosLo,x
	JMP.w CODE_03EBC2

CODE_03EBBF:
	LDA.w !RAM_SMB1_Player_XPosLo,x
CODE_03EBC2:
	AND.b #$0F
	STA.b $04
	LDA.b !RAM_SMB1_Global_ScratchRAME4
	BNE.b CODE_03EBD6
	LDA.b $03
	CMP.b #$62
	BEQ.b CODE_03EBD4
	CMP.b #$63
	BNE.b CODE_03EBD6
CODE_03EBD4:
	STZ.b $03
CODE_03EBD6:
	LDA.b $03
	RTS

if !Define_Global_ROMToAssemble&(!ROM_SMB1_U|!ROM_SMB1_E|!ROM_SMB1_J) != $00
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMB1_J) != $00
	%FREE_BYTES(NULLROM, 28, $FF)
elseif !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E) != $00
	%FREE_BYTES(NULLROM, 4, $FF)
else
	%FREE_BYTES(NULLROM, 55, $FF)
endif

;--------------------------------------------------------------------

CODE_03EC10:
	LDX.b #$06
CODE_03EC12:
	STA.w SMB1_OAMBuffer[$00].XDisp,y
	CLC
	ADC.b #$08
	INY
	INY
	INY
	INY
	DEX
	BNE.b CODE_03EC12
	LDY.b $02
	RTS

;--------------------------------------------------------------------

CODE_03EC22:
	LDX.b #$06
CODE_03EC24:
	STA.w SMB1_OAMBuffer[$40].XDisp,y
	CLC
	ADC.b #$08
	INY
	INY
	INY
	INY
	DEX
	BNE.b CODE_03EC24
	LDY.b $02
	RTS

;--------------------------------------------------------------------

CODE_03EC34:
	LDA.b #$F0
	STA.w SMB1_OAMBuffer[$05].YDisp,y
	STA.w SMB1_OAMBuffer[$04].YDisp,y
CODE_03EC3C:
	STA.w SMB1_OAMBuffer[$03].YDisp,y
	STA.w SMB1_OAMBuffer[$02].YDisp,y
CODE_03EC42:
	STA.w SMB1_OAMBuffer[$01].YDisp,y
	STA.w SMB1_OAMBuffer[$00].YDisp,y
	RTS

;--------------------------------------------------------------------

CODE_03EC49:
	LDA.b #$F0
CODE_03EC4B:
	STA.w SMB1_OAMBuffer[$45].YDisp,y
	STA.w SMB1_OAMBuffer[$44].YDisp,y
CODE_03EC51:
	STA.w SMB1_OAMBuffer[$43].YDisp,y
CODE_03EC54:
	STA.w SMB1_OAMBuffer[$42].YDisp,y
CODE_03EC57:
	STA.w SMB1_OAMBuffer[$41].YDisp,y
	STA.w SMB1_OAMBuffer[$40].YDisp,y
	RTS

;--------------------------------------------------------------------

CODE_03EC5E:
	LDA.w $0743
	BEQ.b CODE_03EC66
	JMP.w CODE_03ECEA

CODE_03EC66:
	LDY.w !RAM_SMB1_Level_SpriteOAMIndexTable+$01,x
	STY.b $02
	LDA.w $03AE
	JSR.w CODE_03EC22
	LDX.b $9E
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	JSR.w CODE_03EC51
	LDY.b !RAM_SMB1_Level_CurrentLevelType
	CPY.b #$03
	BEQ.b CODE_03EC84
	LDY.w !RAM_SMB1_Global_UseLateStageSpriteBehaviorFlag
	BEQ.b CODE_03EC86
CODE_03EC84:
	LDA.b #$F0
CODE_03EC86:
	LDY.w !RAM_SMB1_Level_SpriteOAMIndexTable+$01,x
	STA.w SMB1_OAMBuffer[$44].YDisp,y
	STA.w SMB1_OAMBuffer[$45].YDisp,y
	LDA.b #$87
	LDX.b $9E
	INY
	JSR.w CODE_03EC4B
	LDA.b #$2C
	INY
	JSR.w CODE_03EC4B
	JSR.w CODE_03FE1E
	LDY.w !RAM_SMB1_Level_SpriteOAMIndexTable+$01,x
	JSR.w CODE_03FEAC
	JSR.w CODE_03FEC5
	PHY
	JSR.w CODE_03FF3B
	JSR.w CODE_03FEC5
	JSR.w CODE_03FF3B
	JSR.w CODE_03FEC5
	JSR.w CODE_03FF3B
	JSR.w CODE_03FEC5
	JSR.w CODE_03FF3B
	JSR.w CODE_03FEC5
	JSR.w CODE_03FF3B
	JSR.w CODE_03FEC5
	PLY
	LDA.w $03D1
	ASL
	BCC.b CODE_03ECE9
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr027_ScreenWrappingDownMovingGirderPlatform
	BEQ.b CODE_03ECE9
	CMP.b #!Define_SMB1_SpriteID_NorSpr026_ScreenWrappingUpMovingGirderPlatform
	BEQ.b CODE_03ECE9
	LDA.b !RAM_SMB1_NorSpr_YPosHi,x
	CMP.b #$01
	BNE.b CODE_03ECE6
	LDA.w $03B9
	CMP.b #$F0
	BCC.b CODE_03ECE9
CODE_03ECE6:
	JSR.w CODE_03EC49
CODE_03ECE9:
	RTS

CODE_03ECEA:
	JSL.l CODE_05CDEB
	RTS

;--------------------------------------------------------------------

; Note: Power up graphics routine

DATA_03ECEF:
	db $E9,$EA,$78,$79
	db $D6,$D6,$D9,$D9
	db $8D,$8D,$E4,$E4
	db $E9,$EA,$78,$79

DATA_03ECFF:
	db $2C,$28,$28,$2A

CODE_03ED03:
	LDA.w !RAM_SMB1_Level_SpriteOAMIndexTable+$0A
	CLC
	ADC.b #$08
	TAY
	LDA.w $03B9
	CLC
	ADC.b #$08
	STA.b $02
	LDA.w $03AE
	STA.b $05
	LDX.w !RAM_SMB1_NorSpr02E_Powerup_PowerupType
	LDA.w DATA_03ECFF,x
	EOR.w $0260
	STA.b $04
	TXA
	PHA
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.b $07
	STA.b $03
CODE_03ED2D:
	LDA.w DATA_03ECEF,x
	STA.b $00
	LDA.w DATA_03ECEF+$01,x
	JSR.w CODE_03F2FF
	DEC.b $07
	BPL.b CODE_03ED2D
	LDA.w !RAM_SMB1_Level_SpriteOAMIndexTable+$0A
	CLC
	ADC.b #$08
	TAY
	PLA
	BEQ.b CODE_03ED82
	CMP.b #$03
	BEQ.b CODE_03ED82
	STA.b $00
	LDA.b !RAM_SMB1_Global_FrameCounter
	AND.b #$06
	CMP.b #$06
	BNE.b CODE_03ED56
	LDA.b #$0E
CODE_03ED56:
	ORA.w $0260
	EOR.b #$28
	STA.w SMB1_OAMBuffer[$40].Prop,y
	STA.w SMB1_OAMBuffer[$41].Prop,y
	STA.w SMB1_OAMBuffer[$42].Prop,y
	STA.w SMB1_OAMBuffer[$43].Prop,y
	LDX.b $00
	DEX
	BEQ.b CODE_03ED72
	STA.w SMB1_OAMBuffer[$42].Prop,y
	STA.w SMB1_OAMBuffer[$43].Prop,y
CODE_03ED72:
	LDA.w SMB1_OAMBuffer[$41].Prop,y
	ORA.b #$40
	STA.w SMB1_OAMBuffer[$41].Prop,y
	LDA.w SMB1_OAMBuffer[$43].Prop,y
	ORA.b #$40
	STA.w SMB1_OAMBuffer[$43].Prop,y
CODE_03ED82:
	LDA.w !RAM_SMB1_Level_SpriteOAMIndexTable+$0A
	CLC
	ADC.b #$08
	TAY
	JMP.w CODE_03F2AF

;--------------------------------------------------------------------

; Note: Enemy sprite tile numbers?

DATA_03ED8C:
	db $FC,$FC
	db $AA,$AB
	db $AC,$AD
	db $FC,$FC
	db $AE,$AF
	db $B0,$B1
	db $FC,$A5
	db $A6,$A7
	db $A8,$A9
	db $FC,$A0
	db $A1,$A2
	db $A3,$A4
	db $69,$A5
	db $6A,$A7
	db $A8,$A9
	db $6B,$A0
	db $6C,$A2
	db $A3,$A4
	db $FC,$FC
	db $96,$97
	db $98,$99
	db $FC,$FC
	db $9A,$9B
	db $9C,$9D
	db $FC,$FC
	db $8F,$8E
	db $8E,$8F
	db $FC,$FC
	db $95,$94
	db $94,$95
	db $FC,$FC
	db $DC,$DC
	db $DF,$DF
	db $DC,$DC
	db $DD,$DD
	db $DE,$DE
	db $FC,$FC
	db $B2,$B3
	db $B4,$B5
	db $FC,$FC
	db $B6,$B3
	db $B7,$B5
	db $FC,$FC
	db $C6,$C7
	db $C8,$C9
	db $FC,$FC
	db $6E,$6E
	db $6F,$6F
	db $FC,$FC
	db $6D,$6D
	db $6F,$6F
	db $FC,$FC
	db $6F,$6F
	db $6E,$6E
	db $FC,$FC
	db $6F,$6F
	db $6D,$6D
	db $FC,$FC
	db $F4,$F4
	db $F5,$F5
	db $FC,$FC
	db $F4,$F4
	db $F5,$F5
	db $FC,$FC
	db $F5,$F5
	db $F4,$F4
	db $FC,$FC
	db $F5,$F5
	db $F4,$F4
	db $FC,$FC
	db $FC,$FC
	db $EF,$EF
	db $B9,$B8
	db $BB,$BA
	db $BC,$BC
	db $FC,$FC
	db $BD,$BD
	db $BC,$BC
	db $7A,$7B
	db $DA,$DB
	db $D8,$9E
	db $CD,$CD
	db $CE,$CE
	db $CF,$CF
	db $7D,$7C
	db $D1,$8C
	db $D3,$D2
	db $7D,$7C
	db $89,$88
	db $8B,$8A
	db $D5,$D4
	db $E3,$E2
	db $D3,$D2
	db $D5,$D4
	db $E3,$E2
	db $8B,$8A
	db $E5,$E5
	db $E6,$E6
	db $EB,$EB
	db $EC,$EC
	db $ED,$ED
	db $EB,$EB
	db $FC,$FC
	db $D0,$D0
	db $D7,$D7
	db $BF,$BE
	db $C1,$C0
	db $C2,$FC
	db $C4,$C3
	db $C6,$C5
	db $C8,$C7
	db $BF,$BE
	db $CA,$C9
	db $C2,$FC
	db $C4,$C3
	db $C6,$C5
	db $CC,$CB
	db $FC,$FC
	db $64,$65
	db $74,$75
	db $F2,$F2
	db $F3,$F3
	db $F2,$F2
	db $F1,$F1
	db $F1,$F1
	db $FC,$FC
	db $F0,$F0
	db $FC,$FC
	db $FC,$FC

DATA_03EE8E:
	db $0C,$0C,$00,$0C,$0C,$A8,$54,$3C
	db $EA,$18,$48,$48,$CC,$C0,$18,$18
	db $18,$90,$24,$FF,$48,$9C,$D2,$D8
	db $F0,$F6,$FC

DATA_03EEA9:
	db $0A,$0C,$0A,$0C,$0A,$0A,$02,$08
	db $0A,$08,$0A,$0C,$08,$2A,$0A,$0C
	db $0A,$0A,$0C,$FF,$0C,$0C,$00,$00
	db $2C,$2C,$2C

DATA_03EEC4:
	db $08,$18

DATA_03EEC6:									; Todo: Is this table really used for sprite IDs?
	db !Define_SMB1_SpriteID_NorSpr018_RemoveGenerators
	db !Define_SMB1_SpriteID_NorSpr019_UnusedSprite
	db !Define_SMB1_SpriteID_NorSpr01A_UnusedSprite
	db !Define_SMB1_SpriteID_NorSpr019_UnusedSprite
	db !Define_SMB1_SpriteID_NorSpr018_RemoveGenerators

DATA_03EECB:
	db $00,$00,$00,$00,$00,$00,$06,$06
	db $06,$06,$06,$06,$0C,$0C,$0C,$0C
	db $0C,$0C

DATA_03EEDD:
	db $FC,$FC,$D0,$D0,$D7
	db $D7,$FC,$FC,$7E,$7E
	db $7F,$7F,$FC,$FC,$E0
	db $E0,$E1,$E1

;--------------------------------------------------------------------

SMB1_GenericSpriteGraphicsRt:
.Main
;$03EEEF
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr00C_Podoboo
	BNE.b CODE_03EEFA
	JSL.l CODE_05EA89
	RTS

CODE_03EEFA:
	CMP.b #!Define_SMB1_SpriteID_NorSpr008_BulletBill
	BNE.b CODE_03EF0C
	LDA.b !RAM_SMB1_NorSpr_YPosHi,x
	CMP.b #$02
	BNE.b CODE_03EF07
	JSR.w CODE_03CDE2
CODE_03EF07:
	JSL.l CODE_05CB42
	RTS

CODE_03EF0C:
	CMP.b #!Define_SMB1_SpriteID_NorSpr033_BulletBillLauncher
	BNE.b CODE_03EF1E
	LDA.b !RAM_SMB1_NorSpr_YPosHi,x
	CMP.b #$02
	BNE.b CODE_03EF19
	JSR.w CODE_03CDE2
CODE_03EF19:
	JSL.l CODE_05CB42
	RTS

CODE_03EF1E:
	CMP.b #!Define_SMB1_SpriteID_NorSpr02D_Bowser
	BNE.b CODE_03EF27
	JSL.l SMB1_BowserGFXRt_Main
	RTS

CODE_03EF27:
	CMP.b #!Define_SMB1_SpriteID_NorSpr035_PeachAndToad
	BNE.b CODE_03EF3C
	LDA.w !RAM_SMB1_Player_CurrentWorld
	CMP.b #$07
	BEQ.b CODE_03EF37
	JSL.l SMB1_DrawToadAndRelatedSprites_Main
	RTS

CODE_03EF37:
	JSL.l CODE_04DCBB
	RTS

CODE_03EF3C:
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	STA.b $02
	LDA.w $03AE
	STA.b $05
	LDY.w !RAM_SMB1_Level_SpriteOAMIndexTable+$01,x
	STY.b !RAM_SMB1_Global_ScratchRAMEB
	LDA.b #$00
	STA.b !RAM_SMB1_Global_ScratchRAMF0
	LDA.b $47,x
	STA.b $03
	LDA.w $0257,x
	STA.b $04
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr00D_PiranhaPlant
	BNE.b CODE_03EF68
	LDY.b !RAM_SMB1_NorSpr_XSpeed,x
	BMI.b CODE_03EF68
	LDY.w $0792,x
	BEQ.b CODE_03EF68
	RTS

CODE_03EF68:
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	STA.b !RAM_SMB1_Global_ScratchRAMED
	AND.b #$1F
	TAY
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr035_PeachAndToad
	BNE.b CODE_03EF7D
	LDY.b #$00
	LDA.b #$01
	STA.b $03
	LDA.b #!Define_SMB1_SpriteID_NorSpr015_BowserFireGenerator
CODE_03EF7D:
	CMP.b #!Define_SMB1_SpriteID_NorSpr033_BulletBillLauncher
	BNE.b CODE_03EF94
	DEC.b $02
	LDA.b #$20
	LDY.w $0792,x
	BEQ.b CODE_03EF8C
	EOR.b #$30
CODE_03EF8C:
	STA.b $04
	LDY.b #$00
	STY.b !RAM_SMB1_Global_ScratchRAMED
	LDA.b #!Define_SMB1_SpriteID_NorSpr008_BulletBill
CODE_03EF94:
	CMP.b #!Define_SMB1_SpriteID_NorSpr032_RedSpringboard
	BNE.b CODE_03EFA0
	LDY.b #$03
	LDX.w $070E
	LDA.w DATA_03EEC6,x
CODE_03EFA0:
	STA.b !RAM_SMB1_Global_ScratchRAMEF
	STY.b !RAM_SMB1_Global_ScratchRAMEC
	LDX.b $9E
	CMP.b #$0C
	BNE.b CODE_03EFB0
	LDA.b !RAM_SMB1_NorSpr_YSpeed,x
	BMI.b CODE_03EFB0
	INC.b !RAM_SMB1_Global_ScratchRAMF0
CODE_03EFB0:
	LDA.w $036A
	BEQ.b CODE_03EFBE
	LDY.b #$16
	CMP.b #$01
	BEQ.b CODE_03EFBC
	INY
CODE_03EFBC:
	STY.b !RAM_SMB1_Global_ScratchRAMEF
CODE_03EFBE:
	LDY.b !RAM_SMB1_Global_ScratchRAMEF
	CPY.b #!Define_SMB1_SpriteID_NorSpr006_Goomba
	BNE.b CODE_03EFE1
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	CMP.b #$02
	BCC.b CODE_03EFCE
	LDX.b #$04
	STX.b !RAM_SMB1_Global_ScratchRAMEC
CODE_03EFCE:
	AND.b #$20
	ORA.w !RAM_SMB1_Level_FreezeSpritesTimer
	BNE.b CODE_03EFE1
	LDA.b !RAM_SMB1_Global_FrameCounter
	AND.b #$08
	BNE.b CODE_03EFE1
	LDA.b $03
	EOR.b #$03
	STA.b $03
CODE_03EFE1:
	LDA.w DATA_03EEA9,y
	CPY.b #$14
	BNE.b CODE_03EFEC
	LDA.b #$3C
	BRA.b CODE_03EFEE

CODE_03EFEC:
	EOR.b $04
CODE_03EFEE:
	STA.b $04
	CPY.b #$15
	BNE.b CODE_03F003
	LDA.w !RAM_SMB1_Player_CurrentWorld
	CMP.b #$07
	BNE.b CODE_03F003
	LDA.b $04
	AND.b #$F0
	ORA.b #$04
	STA.b $04
CODE_03F003:
	LDA.w $0E85
	BEQ.b CODE_03F011
	LDA.w DATA_03EE8E,y
	CLC
	ADC.b #$06
	TAX
	BRA.b CODE_03F015

CODE_03F011:
	LDA.w DATA_03EE8E,y
	TAX
CODE_03F015:
	LDY.b !RAM_SMB1_Global_ScratchRAMEC
	LDA.w $036A
	BEQ.b CODE_03F04A
	CMP.b #$01
	BNE.b CODE_03F032
	LDA.w $0363
	BPL.b CODE_03F027
	LDX.b #$DE
CODE_03F027:
	LDA.b !RAM_SMB1_Global_ScratchRAMED
	AND.b #$20
	BEQ.b CODE_03F02F
CODE_03F02D:
	STX.b !RAM_SMB1_Global_ScratchRAMF0
CODE_03F02F:
	JMP.w CODE_03F12D

CODE_03F032:
	LDA.w $0363
	AND.b #$01
	BEQ.b CODE_03F03B
	LDX.b #$E4
CODE_03F03B:
	LDA.b !RAM_SMB1_Global_ScratchRAMED
	AND.b #$20
	BEQ.b CODE_03F02F
	LDA.b $02
	SEC
	SBC.b #$10
	STA.b $02
	BRA.b CODE_03F02D

CODE_03F04A:
	CPX.b #$24
	BNE.b CODE_03F05E
	CPY.b #$05
	BNE.b CODE_03F05C
	LDX.b #$30
	LDA.b #$02
	STA.b $03
	LDA.b #$05
	STA.b !RAM_SMB1_Global_ScratchRAMEC
CODE_03F05C:
	BRA.b CODE_03F0AE

CODE_03F05E:
	CPX.b #$90
	BNE.b CODE_03F074
	LDA.b !RAM_SMB1_Global_ScratchRAMED
	AND.b #$20
	BNE.b CODE_03F071
	LDA.w $079B
	CMP.b #$10
	BCS.b CODE_03F071
	LDX.b #$96
CODE_03F071:
	JMP.w CODE_03F11A

CODE_03F074:
	LDA.b !RAM_SMB1_Global_ScratchRAMEF
	CMP.b #!Define_SMB1_SpriteID_NorSpr004_StationaryGreenKoopa
	BCS.b CODE_03F08A
	CPY.b #$02
	BCC.b CODE_03F08A
	LDX.b #$5A
	LDY.b !RAM_SMB1_Global_ScratchRAMEF
	CPY.b #$02
	BNE.b CODE_03F08A
	LDX.b #$7E
	INC.b $02
CODE_03F08A:
	LDA.b !RAM_SMB1_Global_ScratchRAMEC
	CMP.b #$04
	BNE.b CODE_03F0AE
	LDX.b #$72
	INC.b $02
	LDY.b !RAM_SMB1_Global_ScratchRAMEF
	CPY.b #!Define_SMB1_SpriteID_NorSpr002_BuzzyBeetle
	BEQ.b CODE_03F09E
	LDX.b #$66
	INC.b $02
CODE_03F09E:
	CPY.b #!Define_SMB1_SpriteID_NorSpr006_Goomba
	BNE.b CODE_03F0AE
	LDX.b #$54
	LDA.b !RAM_SMB1_Global_ScratchRAMED
	AND.b #$20
	BNE.b CODE_03F0AE
	LDX.b #$8A
	DEC.b $02
CODE_03F0AE:
	LDY.b $9E
	LDA.b !RAM_SMB1_Global_ScratchRAMEF
	CMP.b #!Define_SMB1_SpriteID_NorSpr005_HammerBro
	BNE.b CODE_03F0C2
	LDA.b !RAM_SMB1_Global_ScratchRAMED
	BEQ.b CODE_03F0DD
	AND.b #$08
	BEQ.b CODE_03F11A
	LDX.b #$B4
	BNE.b CODE_03F0DD						; Note: This will always branch

CODE_03F0C2:
	CPX.b #$48
	BEQ.b CODE_03F0DD
	LDA.w $07A2,y
	CMP.b #$05
	BCS.b CODE_03F11A
	CPX.b #$3C
	BNE.b CODE_03F0DD
	CMP.b #$01
	BEQ.b CODE_03F11A
	INC.b $02
	INC.b $02
	INC.b $02
	BRA.b CODE_03F10C

CODE_03F0DD:
	LDA.b !RAM_SMB1_Global_ScratchRAMEF
	CMP.b #!Define_SMB1_SpriteID_NorSpr006_Goomba
	BEQ.b CODE_03F11A
	CMP.b #!Define_SMB1_SpriteID_NorSpr008_BulletBill
	BEQ.b CODE_03F11A
	CMP.b #!Define_SMB1_SpriteID_NorSpr00C_Podoboo
	BEQ.b CODE_03F11A
	CMP.b #!Define_SMB1_SpriteID_NorSpr018_RemoveGenerators
	BCS.b CODE_03F11A
	LDY.b #$00
	CMP.b #!Define_SMB1_SpriteID_NorSpr015_BowserFireGenerator
	BNE.b CODE_03F105
	INY
	LDA.w !RAM_SMB1_Player_CurrentWorld
	CMP.b #$07
	BCS.b CODE_03F11A
	LDX.b #$A2
	LDA.b #$03
	STA.b !RAM_SMB1_Global_ScratchRAMEC
	BNE.b CODE_03F11A
CODE_03F105:
	LDA.b !RAM_SMB1_Global_FrameCounter
	AND.w DATA_03EEC4,y
	BNE.b CODE_03F11A
CODE_03F10C:
	LDA.b !RAM_SMB1_Global_ScratchRAMED
	AND.b #$A0
	ORA.w !RAM_SMB1_Level_FreezeSpritesTimer
	BNE.b CODE_03F11A
	TXA
	CLC
	ADC.b #$06
	TAX
CODE_03F11A:
	LDA.b !RAM_SMB1_Global_ScratchRAMED
	AND.b #$20
	BEQ.b CODE_03F12D
	LDA.b !RAM_SMB1_Global_ScratchRAMEF
	CMP.b #!Define_SMB1_SpriteID_NorSpr004_StationaryGreenKoopa
	BCC.b CODE_03F12D
	LDY.b #$01
	STY.b !RAM_SMB1_Global_ScratchRAMF0
	DEY
	STY.b !RAM_SMB1_Global_ScratchRAMEC
CODE_03F12D:
	LDY.b !RAM_SMB1_Global_ScratchRAMEB
	JSL.l CODE_05E8CA
	BCS.b CODE_03F142
	JSR.w CODE_03F2F7
	JSR.w CODE_03F2F7
	JSR.w CODE_03F2F7
	JSL.l CODE_05E9AB
CODE_03F142:
	LDX.b $9E
	LDY.w !RAM_SMB1_Level_SpriteOAMIndexTable+$01,x
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr00C_Podoboo
	BNE.b CODE_03F188
	INC.w $0E1B,x
	LDA.w $0E1B,x
	CMP.b #$12
	BCC.b CODE_03F15D
	STZ.w $0E1B,x
	LDA.w $0E1B,x
CODE_03F15D:
	TAX
	LDA.w DATA_03EECB,x
	TAX
	LDA.w DATA_03EEDD,x
	STA.w SMB1_OAMBuffer[$40].Tile,y
	LDA.w DATA_03EEDD+$01,x
	STA.w SMB1_OAMBuffer[$41].Tile,y
	LDA.w DATA_03EEDD+$02,x
	STA.w SMB1_OAMBuffer[$42].Tile,y
	LDA.w DATA_03EEDD+$03,x
	STA.w SMB1_OAMBuffer[$43].Tile,y
	LDA.w DATA_03EEDD+$04,x
	STA.w SMB1_OAMBuffer[$44].Tile,y
	LDA.w DATA_03EEDD+$05,x
	STA.w SMB1_OAMBuffer[$45].Tile,y
	LDX.b $9E
CODE_03F188:
	LDA.b !RAM_SMB1_Global_ScratchRAMEF
	CMP.b #!Define_SMB1_SpriteID_NorSpr008_BulletBill
	BNE.b CODE_03F191
CODE_03F18E:
	JMP.w CODE_03F295

CODE_03F191:
	LDA.b !RAM_SMB1_Global_ScratchRAMF0
	BEQ.b CODE_03F1D2
	LDA.w SMB1_OAMBuffer[$40].Prop,y
	ORA.b #$80
	INY
	INY
	JSR.w CODE_03EC4B
	DEY
	DEY
	TYA
	TAX
	LDA.b !RAM_SMB1_Global_ScratchRAMEF
	CMP.b #!Define_SMB1_SpriteID_NorSpr005_HammerBro
	BEQ.b CODE_03F1B6
	CMP.b #!Define_SMB1_SpriteID_NorSpr011_Lakitu
	BEQ.b CODE_03F1B6
	CMP.b #!Define_SMB1_SpriteID_NorSpr015_BowserFireGenerator
	BCS.b CODE_03F1B6
	TXA
	CLC
	ADC.b #$08
	TAX
CODE_03F1B6:
	LDA.w SMB1_OAMBuffer[$40].Tile,x
	PHA
	LDA.w SMB1_OAMBuffer[$41].Tile,x
	PHA
	LDA.w SMB1_OAMBuffer[$44].Tile,y
	STA.w SMB1_OAMBuffer[$40].Tile,x
	LDA.w SMB1_OAMBuffer[$45].Tile,y
	STA.w SMB1_OAMBuffer[$41].Tile,x
	PLA
	STA.w SMB1_OAMBuffer[$45].Tile,y
	PLA
	STA.w SMB1_OAMBuffer[$44].Tile,y
CODE_03F1D2:
	LDA.w $036A
	BNE.b CODE_03F18E
	LDA.b !RAM_SMB1_Global_ScratchRAMEF
	LDX.b !RAM_SMB1_Global_ScratchRAMEC
	CMP.b #!Define_SMB1_SpriteID_NorSpr005_HammerBro
	BNE.b CODE_03F1E2
	JMP.w CODE_03F295

CODE_03F1E2:
	CMP.b #!Define_SMB1_SpriteID_NorSpr007_Blooper
	BEQ.b CODE_03F1FA
	CMP.b #!Define_SMB1_SpriteID_NorSpr00D_PiranhaPlant
	BEQ.b CODE_03F1FA
	CMP.b #!Define_SMB1_SpriteID_NorSpr00C_Podoboo
	BEQ.b CODE_03F1FA
	CMP.b #!Define_SMB1_SpriteID_NorSpr012_Spiny
	BNE.b CODE_03F1F6
	CPX.b #$05
	BNE.b CODE_03F23A
CODE_03F1F6:
	CPX.b #$02
	BCC.b CODE_03F23A
CODE_03F1FA:
	LDA.w $036A
	BNE.b CODE_03F23A
	LDA.w $0F49
	BNE.b CODE_03F23A
	LDA.w SMB1_OAMBuffer[$40].Prop,y
	AND.b #$BE
	STA.w SMB1_OAMBuffer[$40].Prop,y
	STA.w SMB1_OAMBuffer[$42].Prop,y
	STA.w SMB1_OAMBuffer[$44].Prop,y
	ORA.b #$40
	CPX.b #$05
	BNE.b CODE_03F21A
	ORA.b #$80
CODE_03F21A:
	STA.w SMB1_OAMBuffer[$41].Prop,y
	STA.w SMB1_OAMBuffer[$43].Prop,y
	STA.w SMB1_OAMBuffer[$45].Prop,y
	CPX.b #$04
	BNE.b CODE_03F23A
	LDA.w SMB1_OAMBuffer[$42].Prop,y
	ORA.b #$80
	STA.w SMB1_OAMBuffer[$42].Prop,y
	STA.w SMB1_OAMBuffer[$44].Prop,y
	ORA.b #$40
	STA.w SMB1_OAMBuffer[$43].Prop,y
	STA.w SMB1_OAMBuffer[$45].Prop,y
CODE_03F23A:
	LDA.b !RAM_SMB1_Global_ScratchRAMEF
	CMP.b #!Define_SMB1_SpriteID_NorSpr011_Lakitu
	BNE.b CODE_03F275
	LDA.b !RAM_SMB1_Global_ScratchRAMF0
	BNE.b CODE_03F265
	LDA.w SMB1_OAMBuffer[$44].Prop,y
	AND.b #$BF
	STA.w SMB1_OAMBuffer[$44].Prop,y
	LDA.w SMB1_OAMBuffer[$45].Prop,y
	ORA.b #$40
	STA.w SMB1_OAMBuffer[$45].Prop,y
	LDX.w $079B
	CPX.b #$10
	BCS.b CODE_03F295
	STA.w SMB1_OAMBuffer[$43].Prop,y
	AND.b #$BF
	STA.w SMB1_OAMBuffer[$42].Prop,y
	BCC.b CODE_03F295
CODE_03F265:
	LDA.w SMB1_OAMBuffer[$40].Prop,y
	AND.b #$BF
	STA.w SMB1_OAMBuffer[$40].Prop,y
	LDA.w SMB1_OAMBuffer[$41].Prop,y
	ORA.b #$40
	STA.w SMB1_OAMBuffer[$41].Prop,y
CODE_03F275:
	LDA.b !RAM_SMB1_Global_ScratchRAMEF
	CMP.b #!Define_SMB1_SpriteID_NorSpr018_RemoveGenerators
	BCC.b CODE_03F295
	LDA.b #$AC
	STA.w SMB1_OAMBuffer[$42].Prop,y
	STA.w SMB1_OAMBuffer[$44].Prop,y
	ORA.b #$40
	STA.w SMB1_OAMBuffer[$43].Prop,y
	STA.w SMB1_OAMBuffer[$45].Prop,y
	AND.b #$3F
	STA.w SMB1_OAMBuffer[$40].Prop,y
	ORA.b #$40
	STA.w SMB1_OAMBuffer[$41].Prop,y
CODE_03F295:
	LDA.b !RAM_SMB1_Global_ScratchRAMEF
	CMP.b #!Define_SMB1_SpriteID_NorSpr00D_PiranhaPlant
	BNE.b CODE_03F2AF
	LDA.w SMB1_OAMBuffer[$44].Prop,y
	AND.b #$F0
	ORA.b #$08
	STA.w SMB1_OAMBuffer[$44].Prop,y
	LDA.w SMB1_OAMBuffer[$45].Prop,y
	AND.b #$F0
	ORA.b #$08
	STA.w SMB1_OAMBuffer[$45].Prop,y
CODE_03F2AF:
	LDX.b $9E
	JSR.w CODE_03FEAC
	STZ.b $04
	JSR.w CODE_03FEE5
	JSR.w CODE_03FF3B
	STZ.b $04
	JSR.w CODE_03FEE5
	DEY
	DEY
	DEY
	DEY
	LDA.w $03D1
	LSR
	LSR
	LSR
	LSR
	LSR
	LSR
	PHA
	BCC.b CODE_03F2D6
	LDA.b #$10
	JSR.w CODE_03F313
CODE_03F2D6:
	PLA
	LSR
	PHA
	BCC.b CODE_03F2E0
	LDA.b #$08
	JSR.w CODE_03F313
CODE_03F2E0:
	PLA
	LSR
	BCC.b CODE_03F2F6
	JSR.w CODE_03F313
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr00C_Podoboo
	BEQ.b CODE_03F2F6
	LDA.b !RAM_SMB1_NorSpr_YPosHi,x
	CMP.b #$02
	BNE.b CODE_03F2F6
	JSR.w CODE_03CDE2
CODE_03F2F6:
	RTS

;--------------------------------------------------------------------

CODE_03F2F7:
	LDA.w DATA_03ED8C,x
	STA.b $00
	LDA.w DATA_03ED8C+$01,x
CODE_03F2FF:
	STA.b $01
	LDA.b $02
	CMP.b #$F9
	BNE.b CODE_03F30B
	LDA.b #$F0
	STA.b $02
CODE_03F30B:
	JMP.w CODE_03FF96

;--------------------------------------------------------------------

CODE_03F30E:
	STA.b $01
	JMP.w CODE_03FF4E

;--------------------------------------------------------------------

CODE_03F313:
	STX.b $9E
	CPX.b #$0A
	BNE.b CODE_03F31A
	DEX
CODE_03F31A:
	CLC
	ADC.w !RAM_SMB1_Level_SpriteOAMIndexTable+$01,x
	TAY
	LDA.b #$F0
	LDX.b $9E
	JMP.w CODE_03EC57

;--------------------------------------------------------------------

CODE_03F326:
	STX.b $9E
	CPX.b #$0A
	BNE.b CODE_03F32D
	DEX
CODE_03F32D:
	CLC
	ADC.w !RAM_SMB1_Level_SpriteOAMIndexTable+$01,x
	TAY
	LDA.b #$F0
	STA.w SMB1_OAMBuffer[$40].YDisp,y
	STA.w SMB1_OAMBuffer[$42].YDisp,y
	STA.w SMB1_OAMBuffer[$44].YDisp,y
	LDX.b $9E
	RTS

;--------------------------------------------------------------------

CODE_03F340:
	LDA.b #$01
	STA.w SMB1_OAMTileSizeBuffer[$40].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$42].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$44].Slot,y
	RTS

;--------------------------------------------------------------------

CODE_03F34C:
	LDA.b #$01
	STA.w SMB1_OAMTileSizeBuffer[$41].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$43].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$45].Slot,y
	RTS

;--------------------------------------------------------------------

; Note: Some routine related to hitting a block

CODE_03F358:
	LDY.w !RAM_SMB1_Level_SpriteOAMIndexTable+$0C,x
	LDA.w $03B1
	STA.w SMB1_OAMBuffer[$00].XDisp,y
	LDA.w $03BC
	STA.w SMB1_OAMBuffer[$00].YDisp,y
	LDA.b #$2B
	STA.w SMB1_OAMBuffer[$00].Prop,y
	LDA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot,y
	LDA.w !RAM_SMB1_Level_BlockTile,x
	CMP.b #$FC
	BNE.b CODE_03F37C
	LDA.b #$00
	BRA.b CODE_03F37E

CODE_03F37C:
	LDA.b #$02
CODE_03F37E:
	STA.w SMB1_OAMBuffer[$00].Tile,y
	LDA.b !RAM_SMB1_BounceSpr_XPosHi,x
	STA.b !RAM_SMB1_Global_ScratchRAME5
	LDA.w !RAM_SMB1_BounceSpr_XPosLo,x
	STA.b !RAM_SMB1_Global_ScratchRAME4
	REP.b #$20
	LDA.b !RAM_SMB1_Global_ScratchRAME4
	SEC
	SBC.b $42
	STA.b !RAM_SMB1_Global_ScratchRAME4
	SEP.b #$20
	LDA.b !RAM_SMB1_Global_ScratchRAME5
	BEQ.b CODE_03F39E
	LDA.b #$03
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot,y
CODE_03F39E:
	RTS

;--------------------------------------------------------------------

CODE_03F39F:
	AND.b #$08
	BEQ.b CODE_03F3AB
	LDA.b #$F0
	STA.w SMB1_OAMBuffer[$00].YDisp,y
	STA.w SMB1_OAMBuffer[$02].YDisp,y
CODE_03F3AB:
	RTS

;--------------------------------------------------------------------

; Note: Something related to hitting enemies from below with a block (hit graphic?)

CODE_03F3AC:
	LDA.b #$2C
	STA.b $00
	LDA.b #$75
	LDY.b !RAM_SMB1_Player_CurrentState
	CPY.b #$05
	BEQ.b CODE_03F3BE
	LDA.b #$2A
	STA.b $00
	LDA.b #$84
CODE_03F3BE:
	LDY.w !RAM_SMB1_Level_SpriteOAMIndexTable+$0C,x
	INY
	JSR.w CODE_03EC3C
	LDA.b !RAM_SMB1_Global_FrameCounter
	ASL
	ASL
	ASL
	ASL
	AND.b #$C0
	ORA.b $00
	INY
	JSR.w CODE_03EC3C
	DEY
	DEY
	LDA.w $03BC
	CMP.b #$F0
	BCC.b CODE_03F3DE
	LDA.b #$F0
CODE_03F3DE:
	JSR.w CODE_03EC42
	LDA.w $03B1
	STA.w SMB1_OAMBuffer[$00].XDisp,y
	LDA.w $03F3,x
	SEC
	SBC.w $071C
	STA.b $00
	SEC
	SBC.w $03B1
	ADC.b $00
	ADC.b #$06
	STA.w SMB1_OAMBuffer[$01].XDisp,y
	LDA.w $03BD
	CMP.b #$F0
	BCC.b CODE_03F404
	LDA.b #$F0
CODE_03F404:
	STA.w SMB1_OAMBuffer[$02].YDisp,y
	STA.w SMB1_OAMBuffer[$03].YDisp,y
	LDA.w $03B2
	STA.w SMB1_OAMBuffer[$02].XDisp,y
	LDA.b $00
	SEC
	SBC.w $03B2
	ADC.b $00
	ADC.b #$06
	STA.w SMB1_OAMBuffer[$03].XDisp,y
	LDA.w $03D4
	ASL
	BCC.b CODE_03F428
	LDA.b #$F0
	JSR.w CODE_03EC42
CODE_03F428:
	LDA.w $03D4
	BEQ.b CODE_03F435
	LDA.b #$01
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$02].Slot,y
CODE_03F435:
	LDA.w $03D5
	BEQ.b CODE_03F442
	LDA.b #$01
	STA.w SMB1_OAMTileSizeBuffer[$01].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$03].Slot,y
CODE_03F442:
	RTS

;--------------------------------------------------------------------

SMB1_DrawBouncingPlayerFireball:
.Main:
;$03F443
	LDY.w !RAM_SMB1_Level_SpriteOAMIndexTable+$11,x
	LDA.w $03BA
	STA.w SMB1_OAMBuffer[$00].YDisp,y
	LDA.w $03AF
	STA.w SMB1_OAMBuffer[$00].XDisp,y
	LDA.b !RAM_SMB1_Global_FrameCounter
	LSR
	LSR
	PHA
	AND.b #$01
	EOR.b #$BE
	STA.w SMB1_OAMBuffer[$00].Tile,y
	PLA
	LSR
	LSR
	LDA.b #$28
	BCC.b CODE_03F467
	ORA.b #$C0
CODE_03F467:
	STA.w SMB1_OAMBuffer[$00].Prop,y
	LDA.w !RAM_SMB1_FireSpr_XSpeed,x
	BPL.b CODE_03F47B
	LDA.w $03AF
	CMP.b #$F8
	BCC.b CODE_03F47B
	LDA.b #$01
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot,y
CODE_03F47B:
	RTS

;--------------------------------------------------------------------

CODE_03F47C:
	LDY.w !RAM_SMB1_Level_SpriteOAMIndexTable+$11,x
	LDA.w $03BA
	STA.w SMB1_OAMBuffer[$40].YDisp,y
	LDA.w $03AF
	STA.w SMB1_OAMBuffer[$40].XDisp,y
CODE_03F48B:
	LDA.b !RAM_SMB1_Global_FrameCounter
	LSR
	LSR
	PHA
	AND.b #$01
	EOR.b #$BE
	STA.w SMB1_OAMBuffer[$40].Tile,y
	PLA
	LSR
	LSR
	LDA.b #$38
	BCC.b CODE_03F4A0
	ORA.b #$C0
CODE_03F4A0:
	STA.w SMB1_OAMBuffer[$40].Prop,y
	RTS

;--------------------------------------------------------------------

DATA_03F4A4:
	db $CC,$CB,$CA,$FC

SMB1_DrawExplodingPlayerFireball:
.Main:
;$03F4A8
	LDY.w !RAM_SMB1_Level_SpriteOAMIndexTable+$0C,x
	LDA.w !RAM_SMB1_FireSpr_XSpeed,x
	BMI.b CODE_03F4C7
	LDA.w $03AF
	SEC
	SBC.b #$04
	STA.w $03AF
	CMP.b #$F8
	BCC.b CODE_03F4E6
CODE_03F4BD:
	LDA.b #$01
	STA.w SMB1_OAMTileSizeBuffer[$02].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$03].Slot,y
	BRA.b CODE_03F4E6

CODE_03F4C7:
	LDA.w $03AF
	CMP.b #$F0
	BCC.b CODE_03F4E6
	CMP.b #$F8
	BCC.b CODE_03F4DC
	LDA.b #$01
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$01].Slot,y
	BRA.b CODE_03F4E6

CODE_03F4DC:
	LDA.b #$01
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$01].Slot,y
	BRA.b CODE_03F4BD

CODE_03F4E6:
	LDA.b $33,x
	INC.b $33,x
	LSR
	AND.b #$07
	CMP.b #$03
	BCS.b CODE_03F538
	TAX
	LDA.w DATA_03F4A4,x
	INY
	JSR.w CODE_03EC3C
	DEY
	LDX.b $9E
	LDA.w $03BA
	SEC
	SBC.b #$04
	STA.w SMB1_OAMBuffer[$00].YDisp,y
	STA.w SMB1_OAMBuffer[$02].YDisp,y
	CLC
	ADC.b #$08
	STA.w SMB1_OAMBuffer[$01].YDisp,y
	STA.w SMB1_OAMBuffer[$03].YDisp,y
	LDA.w $03AF
	STA.w SMB1_OAMBuffer[$00].XDisp,y
	STA.w SMB1_OAMBuffer[$01].XDisp,y
	CLC
	ADC.b #$08
	STA.w SMB1_OAMBuffer[$02].XDisp,y
	STA.w SMB1_OAMBuffer[$03].XDisp,y
	LDA.b #$28
	STA.w SMB1_OAMBuffer[$00].Prop,y
	LDA.b #$A8
	STA.w SMB1_OAMBuffer[$01].Prop,y
	LDA.b #$68
	STA.w SMB1_OAMBuffer[$02].Prop,y
	LDA.b #$E8
	STA.w SMB1_OAMBuffer[$03].Prop,y
	RTS

CODE_03F538:
	STZ.b $33,x
	RTS

;--------------------------------------------------------------------

DATA_03F53B:
	db $48,$4A,$4C,$4E

DATA_03F53F:
	db $0C,$08,$0A,$0C,$08,$0A,$0C,$08
	db $0A

CODE_03F548:
	TAX
	LDA.w DATA_03F53B,x
	INY
	JSR.w CODE_03EC51
	DEY
	LDX.b $9E
	LDA.w $03BA
	SEC
	SBC.b #$10
	STA.w SMB1_OAMBuffer[$40].YDisp,y
	STA.w SMB1_OAMBuffer[$42].YDisp,y
	CLC
	ADC.b #$10
	STA.w SMB1_OAMBuffer[$41].YDisp,y
	STA.w SMB1_OAMBuffer[$43].YDisp,y
	LDA.w $03AF
	SEC
	SBC.b #$08
	STA.w SMB1_OAMBuffer[$40].XDisp,y
	STA.w SMB1_OAMBuffer[$41].XDisp,y
	CLC
	ADC.b #$10
	STA.w SMB1_OAMBuffer[$42].XDisp,y
	STA.w SMB1_OAMBuffer[$43].XDisp,y
	LDA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$40].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$41].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$42].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$43].Slot,y
	PHX
	LDA.b !RAM_SMB1_NorSpr_YSpeed,x
	TAX
	DEX
	LDA.w DATA_03F53F,x
	ORA.b #$20
	STA.w SMB1_OAMBuffer[$40].Prop,y
	LDA.w DATA_03F53F,x
	ORA.b #$A0
	STA.w SMB1_OAMBuffer[$41].Prop,y
	LDA.w DATA_03F53F,x
	ORA.b #$60
	STA.w SMB1_OAMBuffer[$42].Prop,y
	LDA.w DATA_03F53F,x
	ORA.b #$E0
	STA.w SMB1_OAMBuffer[$43].Prop,y
	PLX
	RTS

;--------------------------------------------------------------------

CODE_03F5B2:
	LDY.w !RAM_SMB1_Level_SpriteOAMIndexTable+$01,x
	LDA.b #$87
	INY
	JSR.w CODE_03EC4B
	INY
	LDA.b #$2C
	JSR.w CODE_03EC4B
	DEY
	DEY
	LDA.w $03AE
	STA.w SMB1_OAMBuffer[$40].XDisp,y
	STA.w SMB1_OAMBuffer[$43].XDisp,y
	CLC
	ADC.b #$08
	STA.w SMB1_OAMBuffer[$41].XDisp,y
	STA.w SMB1_OAMBuffer[$44].XDisp,y
	CLC
	ADC.b #$08
	STA.w SMB1_OAMBuffer[$42].XDisp,y
	STA.w SMB1_OAMBuffer[$45].XDisp,y
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	TAX
	PHA
	CPX.b #$00
	BCS.b CODE_03F5E9
	LDA.b #$F0
CODE_03F5E9:
	JSR.w CODE_03EC54
	PLA
	CLC
	ADC.b #$80
	TAX
	CPX.b #$00
	BCS.b CODE_03F5F7
	LDA.b #$F0
CODE_03F5F7:
	STA.w SMB1_OAMBuffer[$43].YDisp,y
	STA.w SMB1_OAMBuffer[$44].YDisp,y
	STA.w SMB1_OAMBuffer[$45].YDisp,y
	LDA.w $03D1
	PHA
	AND.b #$08
	BEQ.b CODE_03F610
	LDA.b #$01
	STA.w SMB1_OAMTileSizeBuffer[$40].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$43].Slot,y
CODE_03F610:
	PLA
	PHA
	AND.b #$04
	BEQ.b CODE_03F61E
	LDA.b #$01
	STA.w SMB1_OAMTileSizeBuffer[$41].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$44].Slot,y
CODE_03F61E:
	PLA
	AND.b #$02
	BEQ.b CODE_03F62B
	LDA.b #$01
	STA.w SMB1_OAMTileSizeBuffer[$42].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$45].Slot,y
CODE_03F62B:
	LDX.b $9E
	RTS

;--------------------------------------------------------------------

DATA_03F62E:
	db $20,$28,$C8,$18,$00,$40,$50,$58
	db $80,$88,$B8,$78,$60,$A0,$B0,$B8

;--------------------------------------------------------------------

DATA_03F63E:
	db $00,$01,$02,$03,$04,$05,$06,$07,$00,$01,$02,$03,$04,$05,$06,$07
	db $00,$01,$02,$03,$04,$05,$06,$07,$00,$01,$02,$03,$04,$05,$06,$07
	db $00,$01,$02,$03,$04,$05,$06,$07,$00,$01,$02,$03,$04,$05,$06,$07
	db $00,$01,$02,$03,$04,$05,$06,$07,$00,$01,$02,$03,$04,$05,$06,$07
	db $00,$01,$02,$03,$04,$05,$06,$07,$00,$01,$02,$03,$04,$05,$06,$07
	db $00,$01,$02,$03,$04,$05,$06,$07,$00,$01,$02,$03,$04,$05,$06,$07
	db $00,$01,$02,$03,$04,$05,$06,$07,$00,$01,$02,$03,$04,$05,$06,$07
	db $00,$01,$02,$03,$04,$05,$06,$07,$00,$01,$02,$03,$04,$05,$06,$07
	db $00,$01,$02,$03,$04,$05,$06,$07,$00,$01,$02,$03,$04,$05,$06,$07
	db $00,$01,$02,$03,$04,$05,$06,$07,$00,$01,$02,$03,$04,$05,$06,$07
	db $00,$01,$02,$03,$04,$05,$06,$07,$00,$01,$02,$03,$04,$05,$06,$07
	db $00,$01,$02,$03,$04,$05,$06,$07,$00,$01,$02,$03,$04,$05,$06,$07
	db $00,$01,$02,$03,$04,$05,$06,$07,$00,$01,$02,$03,$04,$05,$06,$07

UNK_03F70E:
	db $9E,$9F

;--------------------------------------------------------------------

CODE_03F710:
	LDA.w $0E41
	BNE.b CODE_03F732
	LDA.w !RAM_SMB1_Player_CurrentPose
	CMP.b #$18
	BEQ.b CODE_03F720
	CMP.b #$78
	BNE.b CODE_03F736
CODE_03F720:
	INC.w $0E41
	BRA.b CODE_03F72F

CODE_03F725:
	LDA.w !RAM_SMB1_Level_Player_FacingDirection
	AND.b #$02
	BNE.b CODE_03F736
	INC.w $0E41
CODE_03F72F:
	STZ.w $0E40
CODE_03F732:
	JSL.l CODE_05D7A1
CODE_03F736:
	LDA.b !RAM_SMB1_Player_CurrentState
	CMP.b #$03
	BEQ.b CODE_03F746
	LDA.w !RAM_SMB1_Player_HurtTimer
	BEQ.b CODE_03F746
	LDA.b !RAM_SMB1_Global_FrameCounter
	LSR
	BCS.b CODE_03F7AE
CODE_03F746:
	LDA.b !RAM_SMB1_Player_CurrentState
	CMP.b #$0B
	BEQ.b CODE_03F7B9
	LDA.w !RAM_SMB1_Level_Player_SizeChangeAnimationFlag
	BNE.b CODE_03F7B4
	LDY.w !RAM_SMB1_Level_UnderwaterLevelFlag
	BEQ.b CODE_03F7AF
	LDA.b !RAM_SMB1_Level_Player_CurrentPhysicsType
	CMP.b #$00
	BEQ.b CODE_03F7AF
	JSR.w CODE_03F7AF
	TAX
	LDY.w !RAM_SMB1_Level_SpriteOAMIndexTable
	LDA.w !RAM_SMB1_Level_Player_FacingDirection
	LSR
	BCS.b CODE_03F76D
	INY
	INY
	INY
	INY
CODE_03F76D:
	LDA.w !RAM_SMB1_Player_CurrentSize
	BNE.b CODE_03F7AE
	PHX
	LDA.w !RAM_SMB1_Level_Player_FacingDirection
	CMP.b #$02
	BEQ.b CODE_03F789
	LDA.w SMB1_OAMBuffer[$04].XDisp,y
	SEC
	SBC.b #$08
	STA.w SMB1_OAMBuffer[$04].XDisp,y
	BCS.b CODE_03F789
	LDA.b #$03
	BRA.b CODE_03F78B

CODE_03F789:
	LDA.b #$02
CODE_03F78B:
	STA.w SMB1_OAMTileSizeBuffer[$04].Slot,y
	LDA.w !RAM_SMB1_Player_CurrentPose
	SEC
	SBC.b #$28
	LSR
	LSR
	CLC
	ADC.b #$08
	STA.w SMB1_OAMBuffer[$04].Tile,y
	LDA.w SMB1_OAMBuffer[$06].YDisp,y
	CMP.b #$F0
	BCC.b CODE_03F7A8
	LDA.b #$F0
	STA.w SMB1_OAMBuffer[$04].YDisp,y
CODE_03F7A8:
	LDA.b #$F0
	STA.w SMB1_OAMBuffer[$06].YDisp,y
	PLX
CODE_03F7AE:
	RTS

;--------------------------------------------------------------------

CODE_03F7AF:
	JSR.w CODE_03FBA2
	BRA.b CODE_03F7BE

CODE_03F7B4:
	JSR.w CODE_03FC60
	BRA.b CODE_03F7BE

CODE_03F7B9:
	LDY.b #$0E
	LDA.w DATA_03F62E,y
CODE_03F7BE:
	STA.w !RAM_SMB1_Player_CurrentPose
	LDA.w $03CE
	BNE.b CODE_03F7D9
	LDA.w $0218
	BEQ.b CODE_03F7DC
	LDA.w !RAM_SMB1_Player_CurrentSize
	BNE.b CODE_03F7D7
	LDA.b #$D8
	STA.w !RAM_SMB1_Player_CurrentPose
	BRA.b CODE_03F7DC

CODE_03F7D7:
	LDA.b #$E0
CODE_03F7D9:
	STA.w !RAM_SMB1_Player_CurrentPose
CODE_03F7DC:
	LDA.b #$04
	JSR.w CODE_03FB58
	JSR.w CODE_03FC99
	LDA.b $02
	CMP.b #$03
	BNE.b CODE_03F804
	LDA.w !RAM_SMB1_Player_XPosLo
	SEC
	SBC.b $42
	LDA.b !RAM_SMB1_Player_XPosHi
	SBC.b $43
CODE_03F7F4:
	BEQ.b CODE_03F804
	LDA.b #$01
	STA.w SMB1_OAMTileSizeBuffer[$34].Slot
	STA.w SMB1_OAMTileSizeBuffer[$36].Slot
	STA.w SMB1_OAMTileSizeBuffer[$38].Slot
	STA.w SMB1_OAMTileSizeBuffer[$3A].Slot
CODE_03F804:
	LDA.w $0711
	BEQ.b CODE_03F834
	LDY.b #$00
	LDA.w $0789
	CMP.w $0711
	STY.w $0711
	BCS.b CODE_03F834
	STA.w $0711
	LDA.b !RAM_SMB1_Level_Player_CurrentPhysicsType
	CMP.b #$01
	BEQ.b CODE_03F827
	LDY.b #$07
	LDA.w DATA_03F62E,y
	STA.w !RAM_SMB1_Player_CurrentPose
CODE_03F827:
	LDY.b #$04
	LDA.b !RAM_SMB1_Player_XSpeed
	ORA.b !RAM_SMB1_Global_ControllerLeftRightHeld
	BEQ.b CODE_03F830
	DEY
CODE_03F830:
	TYA
	JSR.w CODE_03FB58
CODE_03F834:
	LDA.w $03D0
	LSR
	LSR
	LSR
	LSR
	STA.b $00
	LDX.b #$03
	LDA.w !RAM_SMB1_Level_SpriteOAMIndexTable
	CLC
	ADC.b #$18
	TAY
CODE_03F846:
	LDA.b #$F0
	LSR.b $00
	BCC.b CODE_03F84F
	JSR.w CODE_03EC42
CODE_03F84F:
	TYA
	SEC
	SBC.b #$08
	TAY
	DEX
	BPL.b CODE_03F846
	JSR.w CODE_03FCB6
	RTS

;--------------------------------------------------------------------

DATA_03F85B:
	db $40,$01,$2E,$60,$FF,$04

SMB1_DrawLevelPreviewSprites:
.Main:
;$03F861
	JSR.w CODE_0385F3
	LDA.b #$D0
	STA.w !RAM_SMB1_Player_CurrentPose
	JSL.l CODE_04D800
	LDX.b #$05
CODE_03F86F:
	LDA.w DATA_03F85B,x
	STA.b $02,x
	DEX
	BPL.b CODE_03F86F
	LDX.b #$B8
	LDY.b #$D0
	JSR.w CODE_03FB7E
	JSR.w CODE_03F885
	JSR.w CODE_039FBD
	RTS

CODE_03F885:
	PHX
	PHY
	LDA.b #$F0
CODE_03F889:
	STA.w SMB1_OAMBuffer[$00].YDisp,y
	STA.w SMB1_OAMBuffer[$40].YDisp,y
	INY
	BNE.b CODE_03F889
	JSR.w CODE_03F98F
	LDX.b #$00
	LDA.b #$30
	STA.b !RAM_SMB1_Global_ScratchRAME2
CODE_03F89B:
	JSR.w CODE_03F922
	CMP.b #$02
	BNE.b CODE_03F8DB
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr016_FireworksGenerator
	BEQ.b CODE_03F8CD
	PHY
	PHX
	JSR.w CODE_03EF1E
	PLX
	LDA.w !RAM_SMB1_Level_SpriteOAMIndexTable+$01,x
	TAY
	LDA.b #$00
	STA.w SMB1_OAMTileSizeBuffer[$40].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$41].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$42].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$43].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$44].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$45].Slot,y
	LDA.b $43
	STA.b !RAM_SMB1_NorSpr_XPosHi,x
	PLY
	BRA.b CODE_03F8D2

CODE_03F8CD:
	JSR.w CODE_03FA6E
	BRA.b CODE_03F915

CODE_03F8D2:
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr012_Spiny
	BNE.b CODE_03F8DB
	JSR.w SMB1_DrawLakituAboveSpinyInLevelPreview_Main
CODE_03F8DB:
	INY
	INX
	CPX.b #$05
	BNE.b CODE_03F89B
	LDA.b !RAM_SMB1_Level_CurrentLevelType
	CMP.b #$03
	BEQ.b CODE_03F915
	LDX.b #$00
CODE_03F8E9:
	LDA.w SMB1_OAMBuffer[$40].Tile,x
	CMP.w SMB1_OAMBuffer[$41].Tile,x
	BNE.b CODE_03F903
	LDA.w SMB1_OAMBuffer[$40].Prop,x
	AND.b #$3F
	STA.w SMB1_OAMBuffer[$40].Prop,x
	LDA.w SMB1_OAMBuffer[$41].Prop,x
	ORA.b #$40
	STA.w SMB1_OAMBuffer[$41].Prop,x
	BRA.b CODE_03F909

CODE_03F903:
	LDA.w SMB1_OAMBuffer[$41].Prop,x
	STA.w SMB1_OAMBuffer[$40].Prop,x
CODE_03F909:
	INX
	INX
	INX
	INX
	INX
	INX
	INX
	INX
	CPX.b #$00
	BNE.b CODE_03F8E9
CODE_03F915:
	LDX.b #$04
CODE_03F917:
	STZ.b !RAM_SMB1_NorSpr_SpriteID,x
	DEX
	BPL.b CODE_03F917
	STZ.w $0E85
	PLY
	PLX
	RTS

CODE_03F922:
	STZ.w $0E85
	LDA.w !RAM_SMB1_Player_HardModeActiveFlag
	BEQ.b CODE_03F933
	PHX
	TYX
	LDA.l DATA_05EC92,x
	PLX
	BRA.b CODE_03F93A

CODE_03F933:
	PHX
	TYX
	LDA.l DATA_05EBED,x
	PLX
CODE_03F93A:
	CMP.b #$FF
	BNE.b CODE_03F948
	LDA.b !RAM_SMB1_Global_ScratchRAME2
	CLC
	ADC.b #$18
	STA.b !RAM_SMB1_Global_ScratchRAME2
	JMP.w CODE_03F98E

CODE_03F948:
	STZ.w !RAM_SMB1_NorSpr_YPosHi,x
	STA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr00E_GreenBouncingParakoopa
	BEQ.b CODE_03F965
	CMP.b #!Define_SMB1_SpriteID_NorSpr00F_RedVerticalParakoopa
	BEQ.b CODE_03F965
	CMP.b #!Define_SMB1_SpriteID_NorSpr010_GreenHorizontalParakoopa
	BEQ.b CODE_03F965
	CMP.b #!Define_SMB1_SpriteID_NorSpr014_RedFlyingCheepCheepGenerator
	BEQ.b CODE_03F965
	CMP.b #!Define_SMB1_SpriteID_NorSpr008_BulletBill
	BEQ.b CODE_03F965
	LDA.b #$98
	BRA.b CODE_03F967

CODE_03F965:
	LDA.b #$88
CODE_03F967:
	STA.w !RAM_SMB1_NorSpr_YPosLo,x
	LDA.b !RAM_SMB1_Global_ScratchRAME2
	CLC
	ADC.b #$18
	STA.b !RAM_SMB1_Global_ScratchRAME2
	STA.w $03AE
	LDA.b #$20
	STA.w $0257,x
	PHX
	TYX
	LDA.l DATA_05EBED,x
	PLX
	CMP.b #$05
	BNE.b CODE_03F98A
	STA.w $0E85
	JSR.w CODE_03FB36
CODE_03F98A:
	LDA.b #$02
	STA.b $47,x
CODE_03F98E:
	RTS

CODE_03F98F:
	LDA.w !RAM_SMB1_Player_CurrentWorld
	ASL
	ASL
	CLC
	ADC.w !RAM_SMB1_Player_CurrentWorld
	CLC
	ADC.w !RAM_SMB1_Player_CurrentLevel
	TAX
	LDA.l DATA_05ED37,x
	STA.w $0E22
	LDA.l DATA_05ED64,x
	STA.w !RAM_SMB1_Level_LevelPreviewImageToUse
	LDA.w !RAM_SMB1_Level_LevelPreviewImageToUse
	ASL
	ASL
	CLC
	ADC.w !RAM_SMB1_Level_LevelPreviewImageToUse
	TAY
	LDA.w $071C
	STA.b $9C
	LDA.w $071A
	STA.b $9D
	INC.b $9B
	STZ.w $071A
	STZ.w !RAM_SMB1_Global_CurrentLayer1XPosLo
	STZ.w !RAM_SMB1_Global_CurrentLayer2XPosLo
	STZ.w !RAM_SMB1_Global_CurrentLayer2XPosHi
	STZ.w !RAM_SMB1_Global_CurrentLayer3XPosLo
	STZ.w !RAM_SMB1_Global_CurrentLayer3XPosHi
	STZ.w !REGISTER_BG1HorizScrollOffset
	STZ.w !REGISTER_BG1HorizScrollOffset
	STZ.w !REGISTER_BG2HorizScrollOffset
	STZ.w !REGISTER_BG2HorizScrollOffset
	STZ.w !REGISTER_BG3HorizScrollOffset
	STZ.w !REGISTER_BG3HorizScrollOffset
	RTS

;--------------------------------------------------------------------

DATA_03F9E6:
	db $DC,$DC,$DD,$DD,$DE,$DE

CODE_03F9EC:
	LDA.w DATA_03F9E6
	STA.w SMB1_OAMBuffer[$58].Tile
	LDA.w DATA_03F9E6+$01
	STA.w SMB1_OAMBuffer[$59].Tile
	LDA.w DATA_03F9E6+$02
	STA.w SMB1_OAMBuffer[$5A].Tile
	LDA.w DATA_03F9E6+$03
	STA.w SMB1_OAMBuffer[$5B].Tile
	LDA.w DATA_03F9E6+$04
	STA.w SMB1_OAMBuffer[$5C].Tile
	LDA.w DATA_03F9E6+$05
	STA.w SMB1_OAMBuffer[$5D].Tile
	RTS

;--------------------------------------------------------------------

DATA_03FA11:
	db $B9,$B8,$BB,$BA,$BC,$BC

SMB1_DrawLakituAboveSpinyInLevelPreview:
.Main:
;$03FA17
	PHY
	LDA.b #$03
	STA.b $03
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	SEC
	SBC.b #$28
	STA.w !RAM_SMB1_NorSpr_YPosLo,x
	STZ.b !RAM_SMB1_Global_ScratchRAME3
	LDY.b #$00
CODE_03FA29:
	LDA.w $03AE
	STA.w SMB1_OAMBuffer[$64].XDisp,y
	CLC
	ADC.b #$08
	STA.w SMB1_OAMBuffer[$65].XDisp,y
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	STA.w SMB1_OAMBuffer[$64].YDisp,y
	STA.w SMB1_OAMBuffer[$65].YDisp,y
	CLC
	ADC.b #$08
	STA.w !RAM_SMB1_NorSpr_YPosLo,x
	LDA.b #$2A
	STA.w SMB1_OAMBuffer[$64].Prop,y
	STA.w SMB1_OAMBuffer[$65].Prop,y
	PHX
	LDX.b !RAM_SMB1_Global_ScratchRAME3
	LDA.w DATA_03FA11,x
	STA.w SMB1_OAMBuffer[$64].Tile,y
	LDA.w DATA_03FA11+$01,x
	STA.w SMB1_OAMBuffer[$65].Tile,y
	INC.b !RAM_SMB1_Global_ScratchRAME3
	INC.b !RAM_SMB1_Global_ScratchRAME3
	PLX
	INY
	INY
	INY
	INY
	INY
	INY
	INY
	INY
	DEC.b $03
	BNE.b CODE_03FA29
	PLY
	RTS

;--------------------------------------------------------------------

CODE_03FA6E:
	PHY
	PHX
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	STA.w $03B9
	SEC
	SBC.b #$08
	STA.w $03B9
	LDA.w $03AE
	SEC
	SBC.b #$10
	STA.w $03AE
	LDY.b #$90
	LDX.b #$00
	LDA.w $03AE
	STA.w SMB1_OAMBuffer[$40].XDisp,y
	STA.w SMB1_OAMBuffer[$42].XDisp,y
	CLC
	ADC.b #$08
	STA.w SMB1_OAMBuffer[$44].XDisp,y
	CLC
	ADC.b #$08
	STA.w SMB1_OAMBuffer[$41].XDisp,y
	STA.w SMB1_OAMBuffer[$43].XDisp,y
	STA.w SMB1_OAMBuffer[$45].XDisp,y
	LDA.w $03B9
	STA.w SMB1_OAMBuffer[$40].YDisp,y
	STA.w SMB1_OAMBuffer[$41].YDisp,y
	CLC
	ADC.b #$10
	STA.w SMB1_OAMBuffer[$42].YDisp,y
	STA.w SMB1_OAMBuffer[$43].YDisp,y
	SEC
	SBC.b #$18
	STA.w SMB1_OAMBuffer[$44].YDisp,y
	STA.w SMB1_OAMBuffer[$45].YDisp,y
	LDA.b #$00
	STA.w SMB1_OAMTileSizeBuffer[$04].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$05].Slot,y
	LDA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$40].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$41].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$42].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$43].Slot,y
	LDA.b #$61
	STA.w SMB1_OAMBuffer[$40].Prop,y
	STA.w SMB1_OAMBuffer[$41].Prop,y
	STA.w SMB1_OAMBuffer[$42].Prop,y
	STA.w SMB1_OAMBuffer[$43].Prop,y
	STA.w SMB1_OAMBuffer[$44].Prop,y
	STA.w SMB1_OAMBuffer[$45].Prop,y
	LDA.b #$C5
	STA.w SMB1_OAMBuffer[$44].Tile,y
	LDA.b #$C4
	STA.w SMB1_OAMBuffer[$45].Tile,y
	LDA.b #$EE
	STA.w SMB1_OAMBuffer[$40].Tile,y
	LDA.b #$C0
	STA.w SMB1_OAMBuffer[$41].Tile,y
	LDA.b #$E2
	STA.w SMB1_OAMBuffer[$42].Tile,y
	LDA.b #$E0
	STA.w SMB1_OAMBuffer[$43].Tile,y
	LDA.b #$70
	STA.w SMB1_OAMBuffer[$7C].XDisp
	LDA.b #$78
	STA.w SMB1_OAMBuffer[$7D].XDisp
	LDA.b #$98
	STA.w SMB1_OAMBuffer[$7C].YDisp
	STA.w SMB1_OAMBuffer[$7D].YDisp
	LDA.b #$86
	STA.w SMB1_OAMBuffer[$7C].Tile
	LDA.b #$87
	STA.w SMB1_OAMBuffer[$7D].Tile
	LDA.b #$21
	STA.w SMB1_OAMBuffer[$7C].Prop
	STA.w SMB1_OAMBuffer[$7D].Prop
	LDA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$7C].Slot
	STA.w SMB1_OAMTileSizeBuffer[$7D].Slot
	PLX
	PLY
	RTS

;--------------------------------------------------------------------

CODE_03FB36:
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	SEC
	SBC.b #$0A
	STA.w SMB1_OAMBuffer[$20].YDisp
	LDA.w $03AE
	CLC
	ADC.b #$03
	STA.w SMB1_OAMBuffer[$20].XDisp
	LDA.b #$2A
	STA.w SMB1_OAMBuffer[$20].Prop
	LDA.b #$44
	STA.w SMB1_OAMBuffer[$20].Tile
	LDA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$20].Slot
	RTS

;--------------------------------------------------------------------

CODE_03FB58:
	STA.b $07
	LDA.w $03AD
	STA.w $0755
	STA.b $05
	LDA.w $03B8
	STA.b $02
	LDA.w !RAM_SMB1_Level_Player_FacingDirection
	STA.b $03
	JSL.l CODE_04D800
	LDA.w !RAM_SMB1_Player_CurrentPose
	AND.b #$07
	TAX
	LDA.w $0256
	STA.b $04
	LDY.w !RAM_SMB1_Level_SpriteOAMIndexTable
CODE_03FB7E:
	LDA.w DATA_03F63E,x
	STA.b $00
	LDA.w DATA_03F63E+$01,x
	JSR.w CODE_03F30E
	DEC.b $07
	BNE.b CODE_03FB7E
	LDA.b $05
	CMP.b #$F8
	BCC.b CODE_03FBA1
	LDA.b #$01
	STA.w SMB1_OAMTileSizeBuffer[$34].Slot
	STA.w SMB1_OAMTileSizeBuffer[$36].Slot
	STA.w SMB1_OAMTileSizeBuffer[$38].Slot
	STA.w SMB1_OAMTileSizeBuffer[$3A].Slot
CODE_03FBA1:
	RTS

;--------------------------------------------------------------------

CODE_03FBA2:
	LDA.b !RAM_SMB1_Level_Player_CurrentPhysicsType
	CMP.b #$03
	BEQ.b CODE_03FBF6
	CMP.b #$02
	BEQ.b CODE_03FBE8
	CMP.b #$01
	BNE.b CODE_03FBC0
	LDA.w !RAM_SMB1_Level_UnderwaterLevelFlag
	BNE.b CODE_03FC01
	LDY.b #$06
	LDA.w !RAM_SMB1_Level_Player_IsDuckingFlag
	BNE.b CODE_03FBDE
	LDY.b #$00
	BRA.b CODE_03FBDE

CODE_03FBC0:
	LDY.b #$06
	LDA.w !RAM_SMB1_Level_Player_IsDuckingFlag
	BNE.b CODE_03FBDE
	LDY.b #$02
	LDA.b !RAM_SMB1_Player_XSpeed
	ORA.b !RAM_SMB1_Global_ControllerLeftRightHeld
	BEQ.b CODE_03FBDE
	LDA.w $0700
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	CMP.b #$0A
else
	CMP.b #$09
endif
	BCC.b CODE_03FBEF
	LDA.b $46
	AND.w !RAM_SMB1_Level_Player_FacingDirection
	BNE.b CODE_03FBEF
	INY
CODE_03FBDE:
	JSR.w CODE_03FC41
	STZ.w $070D
	LDA.w DATA_03F62E,y
	RTS

CODE_03FBE8:
	LDY.b #$04
	JSR.w CODE_03FC41
	BRA.b CODE_03FC13

CODE_03FBEF:
	LDY.b #$04
	JSR.w CODE_03FC41
	BRA.b CODE_03FC19

CODE_03FBF6:
	LDY.b #$05
	LDA.b !RAM_SMB1_Player_YSpeed
	BEQ.b CODE_03FBDE
	JSR.w CODE_03FC41
	BRA.b CODE_03FC1D

CODE_03FC01:
	LDY.b #$01
	JSR.w CODE_03FC41
	LDA.w $078A
	ORA.w $070D
	BNE.b CODE_03FC19
	LDA.b !RAM_SMB1_Global_ControllerABXYHeld
	ASL
	BCS.b CODE_03FC19					; Note: !Joypad_X|(!Joypad_Y>>8)
CODE_03FC13:
	LDA.w $070D
	JMP.w CODE_03FC80

CODE_03FC19:
	LDA.b #$03
	BRA.b CODE_03FC1F

CODE_03FC1D:
	LDA.b #$02
CODE_03FC1F:
	STA.b $00
	JSR.w CODE_03FC13
	PHA
	LDA.w $0789
	BNE.b CODE_03FC3F
	LDA.w $070C
	STA.w $0789
	LDA.w $070D
	CLC
	ADC.b #$01
	CMP.b $00
	BCC.b CODE_03FC3C
	LDA.b #$00
CODE_03FC3C:
	STA.w $070D
CODE_03FC3F:
	PLA
	RTS

CODE_03FC41:
	LDA.w !RAM_SMB1_Player_CurrentSize
	BEQ.b CODE_03FC4B
	TYA
	CLC
	ADC.b #$08
	TAY
CODE_03FC4B:
	RTS

;--------------------------------------------------------------------

DATA_03FC4C:
	db $00,$01,$00,$01,$00,$01,$02,$00
	db $01,$02

	db $02,$00,$02,$00,$02,$00,$02,$00
	db $02,$00

CODE_03FC60:
	LDY.w $070D
	LDA.b !RAM_SMB1_Global_FrameCounter
	AND.b #$03
	BNE.b CODE_03FC76
	INY
	CPY.b #$0A
	BCC.b CODE_03FC73
	LDY.b #$00
	STY.w !RAM_SMB1_Level_Player_SizeChangeAnimationFlag
CODE_03FC73:
	STY.w $070D
CODE_03FC76:
	LDA.w !RAM_SMB1_Player_CurrentSize
	BNE.b CODE_03FC87
	LDA.w DATA_03FC4C,y
	LDY.b #$0F
CODE_03FC80:
	ASL
	ASL
	ASL
	ADC.w DATA_03F62E,y
	RTS

CODE_03FC87:
	TYA
	CLC
	ADC.b #$0A
	TAX
	LDY.b #$09
	LDA.w DATA_03FC4C,x
	BNE.b CODE_03FC95
	LDY.b #$01
CODE_03FC95:
	LDA.w DATA_03F62E,y
	RTS

;--------------------------------------------------------------------

CODE_03FC99:
	LDY.w !RAM_SMB1_Level_SpriteOAMIndexTable
	LDA.b !RAM_SMB1_Player_CurrentState
	CMP.b #$0B
	BEQ.b CODE_03FCB5
	LDA.w !RAM_SMB1_Player_CurrentPose
	CMP.b #$50
	BEQ.b CODE_03FCB5
	CMP.b #$B8
	BEQ.b CODE_03FCB5
	CMP.b #$C0
	BEQ.b CODE_03FCB5
	CMP.b #$C8
	BNE.b CODE_03FCB5
CODE_03FCB5:
	RTS

;--------------------------------------------------------------------

CODE_03FCB6:
	LDA.w $0E4E
	BEQ.b CODE_03FD12
	LDX.b #$00
CODE_03FCBD:
	LDA.w SMB1_OAMBuffer[$34].XDisp,x
	STA.w SMB1_OAMBuffer[$78].XDisp,x
	INX
	CPX.b #$20
	BNE.b CODE_03FCBD
	LDA.b #$F0
	STA.w SMB1_OAMBuffer[$34].YDisp
	STA.w SMB1_OAMBuffer[$35].YDisp
	STA.w SMB1_OAMBuffer[$36].YDisp
	STA.w SMB1_OAMBuffer[$37].YDisp
	STA.w SMB1_OAMBuffer[$38].YDisp
	STA.w SMB1_OAMBuffer[$39].YDisp
	STA.w SMB1_OAMBuffer[$3A].YDisp
	STA.w SMB1_OAMBuffer[$3B].YDisp
	LDA.w SMB1_OAMTileSizeBuffer[$34].Slot
	STA.w SMB1_OAMTileSizeBuffer[$78].Slot
	LDA.w SMB1_OAMTileSizeBuffer[$35].Slot
	STA.w SMB1_OAMTileSizeBuffer[$79].Slot
	LDA.w SMB1_OAMTileSizeBuffer[$36].Slot
	STA.w SMB1_OAMTileSizeBuffer[$7A].Slot
	LDA.w SMB1_OAMTileSizeBuffer[$37].Slot
	STA.w SMB1_OAMTileSizeBuffer[$7B].Slot
	LDA.w SMB1_OAMTileSizeBuffer[$38].Slot
	STA.w SMB1_OAMTileSizeBuffer[$7C].Slot
	LDA.w SMB1_OAMTileSizeBuffer[$39].Slot
	STA.w SMB1_OAMTileSizeBuffer[$7D].Slot
	LDA.w SMB1_OAMTileSizeBuffer[$3A].Slot
	STA.w SMB1_OAMTileSizeBuffer[$7E].Slot
	LDA.w SMB1_OAMTileSizeBuffer[$3B].Slot
	STA.w SMB1_OAMTileSizeBuffer[$7F].Slot
CODE_03FD12:
	RTS

;--------------------------------------------------------------------

CODE_03FD13:
	LDX.b #$00
	LDY.b #$00
	JMP.w CODE_03FD2A

CODE_03FD1A:
	LDY.b #$01
	JSR.w CODE_03FDC4
	LDY.b #$03
	BRA.b CODE_03FD2A

CODE_03FD23:
	LDY.b #$00
	JSR.w CODE_03FDC4
	LDY.b #$02
CODE_03FD2A:
	JSR.w CODE_03FD58
	LDX.b $9E
	RTS

CODE_03FD30:
	LDY.b #$02
	JSR.w CODE_03FDC4
	LDY.b #$06
	BRA.b CODE_03FD2A

CODE_03FD39:
	LDA.b #$01
	LDY.b #$01
	JMP.w CODE_03FD4C

CODE_03FD40:
	LDA.b #$0D
	LDY.b #$04
	JSR.w CODE_03FD4C
	INX
	INX
	LDA.b #$0D
	INY
CODE_03FD4C:
	STX.b $00
	CLC
	ADC.b $00
	TAX
	JSR.w CODE_03FD58
	LDX.b $9E
	RTS

CODE_03FD58:
	LDA.w !RAM_SMB1_Player_YPosLo,x
	STA.w $03B8,y
	LDA.b $0E
	BEQ.b CODE_03FD6E
	LDA.w !RAM_SMB1_Player_XPosLo
	BNE.b CODE_03FD6E
	LDA.b #$28
	STA.w !RAM_SMB1_Player_XPosLo
	BRA.b CODE_03FD80

CODE_03FD6E:
	LDA.w !RAM_SMB1_Player_XPosLo,x
	SEC
	SBC.w $071C
	STA.w $03AD,y
	LDA.b !RAM_SMB1_Player_XPosHi,x
	SBC.w $071A
	STA.w $03C1,y
CODE_03FD80:
	PHY
	TYA
	ASL
	TAY
	LDA.w !RAM_SMB1_Player_XPosLo,x
	STA.b !RAM_SMB1_Global_ScratchRAME4
	LDA.w !RAM_SMB1_Player_XPosHi,x
	STA.b !RAM_SMB1_Global_ScratchRAME5
	REP.b #$20
	LDA.b !RAM_SMB1_Global_ScratchRAME4
	SEC
	SBC.b $42
	STA.w $0E87,y
	SEP.b #$20
	PLY
	RTS

CODE_03FD9C:
	LDX.b #$00
	LDY.b #$00
	JMP.w CODE_03FDDB

CODE_03FDA3:
	LDY.b #$00
	JSR.w CODE_03FDC4
	LDY.b #$02
	JMP.w CODE_03FDDB

CODE_03FDAD:
	LDY.b #$01
	JSR.w CODE_03FDC4
	LDY.b #$03
	JMP.w CODE_03FDDB

CODE_03FDB7:
	LDY.b #$02
	JSR.w CODE_03FDC4
	LDY.b #$06
	JMP.w CODE_03FDDB

DATA_03FDC1:
	db $0B,$1A,$11

CODE_03FDC4:
	TXA
	CLC
	ADC.w DATA_03FDC1,y
	TAX
	RTS

CODE_03FDCB:
	LDA.b #$01
	LDY.b #$01
	BRA.b CODE_03FDD5

CODE_03FDD1:
	LDA.b #$0D
	LDY.b #$04
CODE_03FDD5:
	STX.b $00
	CLC
	ADC.b $00
	TAX
CODE_03FDDB:
	TYA
	PHA
	JSR.w CODE_03FDFF
	ASL
	ASL
	ASL
	ASL
	ORA.b $00
	STA.b $00
	PLA
	TAY
	LDA.b $00
	STA.w $03D0,y
	LSR
	LSR
	PHA
	AND.b #$01
	STA.w $0E08,y
	PLA
	LSR
	STA.w $0E00,y
	LDX.b $9E
	RTS

CODE_03FDFF:
	JSR.w CODE_03FE1E
	LSR
	LSR
	LSR
	LSR
	STA.b $00
	JMP.w CODE_03FE62

;--------------------------------------------------------------------

DATA_03FE0B:
	db $7F,$3F,$1F,$0F,$07,$03,$01,$00
	db $80,$C0,$E0,$F0,$F8,$FC,$FE,$FF

DATA_03FE1B:
	db $07,$0F,$07

CODE_03FE1E:
	STX.b $04
	LDY.b #$01
CODE_03FE22:
	LDA.w $071C,y
	SEC
	SBC.w !RAM_SMB1_Player_XPosLo,x
	STA.b $07
	LDA.w $071A,y
	SBC.b !RAM_SMB1_Player_XPosHi,x
	LDX.w DATA_03FE1B,y
	CMP.b #$00
	BMI.b CODE_03FE47
	LDX.w DATA_03FE1B+$01,y
	CMP.b #$01
	BPL.b CODE_03FE47
	LDA.b #$38
	STA.b $06
	LDA.b #$08
	JSR.w CODE_03FE97
CODE_03FE47:
	LDA.w DATA_03FE0B,x
	LDX.b $04
	CMP.b #$00
	BNE.b CODE_03FE53
	DEY
	BPL.b CODE_03FE22
CODE_03FE53:
	RTS

;--------------------------------------------------------------------

DATA_03FE54:
	db $00,$08,$0C,$0E,$0F,$07,$03,$01
	db $00

DATA_03FE5D:
	db $04,$00,$04

DATA_03FE60:
	db $FF,$00

CODE_03FE62:
	STX.b $04
	LDY.b #$01
CODE_03FE66:
	LDA.w DATA_03FE60,y
	SEC
	SBC.w !RAM_SMB1_Player_YPosLo,x
	STA.b $07
	LDA.b #$01
	SBC.b !RAM_SMB1_Player_YPosHi,x
	LDX.w DATA_03FE5D,y
	CMP.b #$00
	BMI.b CODE_03FE8A
	LDX.w DATA_03FE5D+$01,y
	CMP.b #$01
	BPL.b CODE_03FE8A
	LDA.b #$20
	STA.b $06
	LDA.b #$04
	JSR.w CODE_03FE97
CODE_03FE8A:
	LDA.w DATA_03FE54,x
	LDX.b $04
	CMP.b #$00
	BNE.b CODE_03FE96
	DEY
	BPL.b CODE_03FE66
CODE_03FE96:
	RTS

;--------------------------------------------------------------------

CODE_03FE97:
	STA.b $05
	LDA.b $07
	CMP.b $06
	BCS.b CODE_03FEAB
	LSR
	LSR
	LSR
	AND.b #$07
	CPY.b #$01
	BCS.b CODE_03FEAA
	ADC.b $05
CODE_03FEAA:
	TAX
CODE_03FEAB:
	RTS

;--------------------------------------------------------------------

CODE_03FEAC:
	LDA.b !RAM_SMB1_NorSpr_XPosHi,x
	STA.w $0E15
	LDA.w !RAM_SMB1_NorSpr_XPosLo,x
	STA.w $0E14
	RTS

;--------------------------------------------------------------------

CODE_03FEB8:
	LDA.w $0E17
	STA.w $0E15
	LDA.w $0E16
	STA.w $0E14
	RTS

;--------------------------------------------------------------------

CODE_03FEC5:
	LDA.b #$06
	STA.b $04
	REP.b #$20
	LDA.w $0E14
	SEC
	SBC.b $42
	STA.w $0E12
	SEP.b #$20
	LDA.w $0E13
	BNE.b CODE_03FEDF
	LDA.b #$00
	BRA.b CODE_03FEE1

CODE_03FEDF:
	LDA.b #$01
CODE_03FEE1:
	STA.w SMB1_OAMTileSizeBuffer[$40].Slot,y
	RTS

;--------------------------------------------------------------------

CODE_03FEE5:
	REP.b #$20
	LDA.w $0E14
	SEC
	SBC.b $42
	STA.w $0E12
	SEP.b #$20
	LDA.w $0E13
	BNE.b CODE_03FEFB
	LDA.b #$00
	BRA.b CODE_03FEFD

CODE_03FEFB:
	LDA.b #$01
CODE_03FEFD:
	STA.w SMB1_OAMTileSizeBuffer[$44].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$42].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$40].Slot,y
	RTS

;--------------------------------------------------------------------

CODE_03FF07:
	REP.b #$20
	LDA.w $0E14
	SEC
	SBC.b $42
	STA.w $0E12
	SEP.b #$20
	LDA.w $0E13
	BNE.b CODE_03FF1D
	LDA.b #$00
	BRA.b CODE_03FF1F

CODE_03FF1D:
	LDA.b #$01
CODE_03FF1F:
	STA.w SMB1_OAMTileSizeBuffer[$02].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot,y
	RTS

;--------------------------------------------------------------------

CODE_03FF26:
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$02].Slot,y
	RTS

;--------------------------------------------------------------------

CODE_03FF2D:
	REP.b #$20
	PLA
	CLC
	ADC.b $04
	STA.b $04
	PHA
	SEP.b #$20
	LDA.b #$01
	RTS

;--------------------------------------------------------------------

CODE_03FF3B:
	REP.b #$20
	LDA.w $0E14
	CLC
	ADC.w #$0008
	STA.w $0E14
	SEP.b #$20
	INY
	INY
	INY
	INY
	RTS

;--------------------------------------------------------------------

; Note: Routine that draws the player?

CODE_03FF4E:
	LDA.b $03
	LSR
	LSR
	LDA.b $00
	BCC.b CODE_03FF62
	STA.w SMB1_OAMBuffer[$01].Tile,y
	LDA.b $01
	STA.w SMB1_OAMBuffer[$00].Tile,y
	LDA.b #$40
	BNE.b CODE_03FF6C

CODE_03FF62:
	STA.w SMB1_OAMBuffer[$00].Tile,y
	LDA.b $01
	STA.w SMB1_OAMBuffer[$01].Tile,y
	LDA.b #$00
CODE_03FF6C:
	ORA.b $04
	STA.w SMB1_OAMBuffer[$00].Prop,y
	STA.w SMB1_OAMBuffer[$01].Prop,y
	LDA.b $02
	STA.w SMB1_OAMBuffer[$00].YDisp,y
	STA.w SMB1_OAMBuffer[$01].YDisp,y
	LDA.b $05
	STA.w SMB1_OAMBuffer[$00].XDisp,y
	CLC
	ADC.b #$08
	STA.w SMB1_OAMBuffer[$01].XDisp,y
	LDA.b $02
	CLC
	ADC.b #$08
	STA.b $02
	TYA
	CLC
	ADC.b #$08
	TAY
	INX
	INX
	RTS

;--------------------------------------------------------------------

CODE_03FF96:
	LDA.b $03
	LSR
	LSR
	LDA.b $00
	BCC.b CODE_03FFAA
	STA.w SMB1_OAMBuffer[$41].Tile,y
	LDA.b $01
	STA.w SMB1_OAMBuffer[$40].Tile,y
	LDA.b #$40
	BNE.b CODE_03FFB4

CODE_03FFAA:
	STA.w SMB1_OAMBuffer[$40].Tile,y
	LDA.b $01
	STA.w SMB1_OAMBuffer[$41].Tile,y
	LDA.b #$00
CODE_03FFB4:
	ORA.b $04
	STA.w SMB1_OAMBuffer[$40].Prop,y
	STA.w SMB1_OAMBuffer[$41].Prop,y
	LDA.b $02
	STA.w SMB1_OAMBuffer[$40].YDisp,y
	STA.w SMB1_OAMBuffer[$41].YDisp,y
	LDA.b $05
	STA.w SMB1_OAMBuffer[$40].XDisp,y
	CLC
	ADC.b #$08
	STA.w SMB1_OAMBuffer[$41].XDisp,y
	LDA.b $02
	CLC
	ADC.b #$08
	STA.b $02
	TYA
	CLC
	ADC.b #$08
	TAY
	INX
	INX
	RTS

if !Define_Global_ROMToAssemble&(!ROM_SMB1_U) != $00
	%FREE_BYTES(NULLROM, 21, $FF)
elseif !Define_Global_ROMToAssemble&(!ROM_SMB1_E) != $00
	%FREE_BYTES(NULLROM, 6, $FF)
elseif !Define_Global_ROMToAssemble&(!ROM_SMB1_J) != $00
	%FREE_BYTES(NULLROM, 8, $FF)
elseif !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E) != $00
	%FREE_BYTES(NULLROM, 2, $FF)
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	%FREE_BYTES(NULLROM, 50, $FF)
else
	%FREE_BYTES(NULLROM, 34, $FF)
endif
%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro SMB1Bank04Macros(StartBank, EndBank)
%BANK_START(<StartBank>)

; Note: This routine is also called by SMBLL.

CODE_048000:
	PHD
	LDA.b #$24
	STA.b $00
	STZ.w !REGISTER_VRAMAddressIncrementValue
	REP.b #$20
	LDA.w #DMA[$00].Parameters
	TCD
	LDA.w #$0800
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$08
	STA.b DMA[$00].Parameters
	STZ.b DMA[$00].SourceLo
	STZ.b DMA[$00].SourceBank
	LDA.w #$0400
	STA.b DMA[$00].SizeLo
	LDY.b #$01
	STY.w !REGISTER_DMAEnable
	STA.b DMA[$00].SizeLo
	LDA.w #$0800
	STA.w !REGISTER_VRAMAddressLo
	STZ.w $0000
	LDX.b #$80
	STX.w !REGISTER_VRAMAddressIncrementValue
	LDX.b #!REGISTER_WriteToVRAMPortHi
	STX.b DMA[$00].Destination
	STY.w !REGISTER_DMAEnable
	LDX.b #$24
	STX.w $0000
	STZ.w !REGISTER_VRAMAddressIncrementValue
	LDA.w #$0000
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$08
	STA.b DMA[$00].Parameters
	STZ.b DMA[$00].SourceLo
	STZ.b DMA[$00].SourceBank
	LDA.w #$0800
	STA.b DMA[$00].SizeLo
	STY.w !REGISTER_DMAEnable
	STA.b DMA[$00].SizeLo
	LDA.w #$0000
	STA.w !REGISTER_VRAMAddressLo
	STZ.w $0000
	LDX.b #$80
	STX.w !REGISTER_VRAMAddressIncrementValue
	LDX.b #!REGISTER_WriteToVRAMPortHi
	STX.b DMA[$00].Destination
	STY.w !REGISTER_DMAEnable
	LDX.b #$28
	STX.w $0000
	STZ.w !REGISTER_VRAMAddressIncrementValue
	LDA.w #$5878
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$08
	STA.b DMA[$00].Parameters
	STZ.b DMA[$00].SourceLo
	STZ.b DMA[$00].SourceBank
	LDA.w #$0788
	STA.b DMA[$00].SizeLo
	STY.w !REGISTER_DMAEnable
	STA.b DMA[$00].SizeLo
	LDA.w #$5878
	STA.w !REGISTER_VRAMAddressLo
	STZ.w $0000
	LDX.b #$80
	STX.w !REGISTER_VRAMAddressIncrementValue
	LDX.b #!REGISTER_WriteToVRAMPortHi
	STX.b DMA[$00].Destination
	STY.w !REGISTER_DMAEnable
	SEP.b #$20
	PLD
	RTL

;--------------------------------------------------------------------

; Note: This routine is also called by SMBLL.

CODE_0480AE:
	LDA.b #$28
	STA.b $00
	STZ.w !REGISTER_VRAMAddressIncrementValue
	REP.b #$20
	LDA.w #$5800
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$08
	STA.w DMA[$00].Parameters
	STZ.w DMA[$00].SourceLo
	STZ.w DMA[$00].SourceBank
	LDA.w #$0200
	STA.w DMA[$00].SizeLo
	LDY.b #$01
	STY.w !REGISTER_DMAEnable
	STA.w DMA[$00].SizeLo
	LDA.w #$5800
	STA.w !REGISTER_VRAMAddressLo
	SEP.b #$20
	STZ.b $00
	LDA.b #$80
	STA.w !REGISTER_VRAMAddressIncrementValue
	LDA.b #!REGISTER_WriteToVRAMPortHi
	STA.w DMA[$00].Destination
	STY.w !REGISTER_DMAEnable
	RTL

;--------------------------------------------------------------------

; Note: This routine is also called by SMBLL.

CODE_0480EF:
	PHD
	LDA.b #$27
	STA.b $00
	STZ.w !REGISTER_VRAMAddressIncrementValue
	REP.b #$20
	LDA.w #DMA[$00].Parameters
	TCD
	LDA.w #$0000
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$08
	STA.b DMA[$00].Parameters
	STZ.b DMA[$00].SourceLo
	STZ.b DMA[$00].SourceBank
	LDA.w #$0400
	STA.b DMA[$00].SizeLo
	LDY.b #$01
	STY.w !REGISTER_DMAEnable
	STA.b DMA[$00].SizeLo
	LDA.w #$0000
	STA.w !REGISTER_VRAMAddressLo
	LDX.b #$0C
	STX.w $0000
	LDX.b #$80
	STX.w !REGISTER_VRAMAddressIncrementValue
	LDX.b #!REGISTER_WriteToVRAMPortHi
	STX.b DMA[$00].Destination
	STY.b !REGISTER_DMAEnable				; Glitch: This writes to open bus, not !REGISTER_DMAEnable!
	LDX.b #$24
	STX.w $0000
	STZ.w !REGISTER_VRAMAddressIncrementValue
	LDA.w #$0800
	STA.w !REGISTER_VRAMAddressLo
	STZ.b DMA[$00].SourceLo
	STZ.b DMA[$00].SourceBank
	LDA.w #$0400
	STA.b DMA[$00].SizeLo
	STY.w !REGISTER_DMAEnable
	STA.b DMA[$00].SizeLo
	LDA.w #$0800
	STA.w !REGISTER_VRAMAddressLo
	SEP.b #$20
	STZ.w $0000
	LDA.b #$80
	STA.w !REGISTER_VRAMAddressIncrementValue
	LDA.b #!REGISTER_WriteToVRAMPortHi
	STA.b DMA[$00].Destination
	STY.w !REGISTER_DMAEnable
	PLD
	RTL

;--------------------------------------------------------------------

; Note: This routine is also called by SMBLL.

CODE_048163:
	LDA.w !RAM_SMB1_Global_SoundCh1
	BNE.b CODE_04817C
	LDA.w !REGISTER_APUPort0
	CMP.w $1604
	BEQ.b CODE_04817A
	INC.w $160A
	LDA.w $160A
	CMP.b #$03
	BCC.b CODE_048185
CODE_04817A:
	LDA.b #$00
CODE_04817C:
	STA.w !REGISTER_APUPort0
	STA.w $1604
	STZ.w $160A
CODE_048185:
	LDA.w !RAM_SMB1_Global_SoundCh2
	BNE.b CODE_0481A0
	LDA.w !REGISTER_APUPort1
	AND.b #$0F
	CMP.w $1605
	BEQ.b CODE_04819E
	INC.w $160B
	LDA.w $160B
	CMP.b #$03
	BCC.b CODE_0481AB
CODE_04819E:
	LDA.b #$00
CODE_0481A0:
	STA.w !REGISTER_APUPort1
	AND.b #$0F
	STA.w $1605
	STZ.w $160B
CODE_0481AB:
	LDA.w !RAM_SMB1_Global_MusicCh1
	BEQ.b CODE_048226
	LDY.b #$04
	STY.w $160C
	STA.w !REGISTER_APUPort2
	CMP.b #!Define_SMB1_LevelMusic_StopMusicCommand
	BCS.b CODE_0481BF
	STA.w $1606
CODE_0481BF:
	LDA.w !RAM_SMB1_Global_SoundCh3
	BNE.b CODE_0481E5
	LDA.w !REGISTER_APUPort3
	AND.b #$7F
	CMP.w $1607
	BEQ.b CODE_0481D8
	INC.w $160D
	LDA.w $160D
	CMP.b #$03
	BCC.b CODE_048209
CODE_0481D8:
	LDA.b #$00
	STA.w !REGISTER_APUPort3
	STA.w $1607
	STZ.w $160D
	BRA.b CODE_048209

CODE_0481E5:
	STA.w $1607
	CMP.b #!Define_SMAS_Sound0063_Coin
	BEQ.b CODE_0481F8
	CMP.b #!Define_SMAS_Sound0063_1up
	BEQ.b CODE_0481F8
	CMP.b #!Define_SMAS_Sound0063_ShootFireball
	BEQ.b CODE_0481F8
	CMP.b #!Define_SMAS_Sound0063_CannonShoot
	BNE.b CODE_048216
CODE_0481F8:
	ORA.w $160F
	STA.w !REGISTER_APUPort3
	LDA.w $160F
	EOR.b #$80
	STA.w $160F
	STZ.w $160D
CODE_048209:
	STZ.w !RAM_SMB1_Global_SoundCh1
	STZ.w !RAM_SMB1_Global_SoundCh2
	STZ.w !RAM_SMB1_Global_MusicCh1
	STZ.w !RAM_SMB1_Global_SoundCh3
	RTL

CODE_048216:
	STA.w !REGISTER_APUPort3
	STZ.w !RAM_SMB1_Global_SoundCh1
	STZ.w !RAM_SMB1_Global_SoundCh2
	STZ.w !RAM_SMB1_Global_MusicCh1
	STZ.w !RAM_SMB1_Global_SoundCh3
	RTL

CODE_048226:
	LDY.w !REGISTER_APUPort2
	CPY.w $1606
	BNE.b CODE_0481BF
	DEC.w $160C
	LDA.w $160C
	BNE.b CODE_0481BF
	INC.w $160C
	STA.w !REGISTER_APUPort2
	BRA.b CODE_0481BF

;--------------------------------------------------------------------

; Note: This routine is also called by SMBLL.

DATA_04823E:
	dw $0000,$0000,$0031,$0000

DATA_048246:
	dw $0000,$0010,$0020,$0030

DATA_04824E:
	dw $0031,$0031,$0031,$0031

DATA_048256:
	dw $0010,$0010,$0010,$0010

SMB1_InitializeGradientHDMA:
.Main:
;$04825E
	STZ.w !REGISTER_HDMAEnable
	STZ.w !RAM_SMB1_Global_HDMAEnableMirror
	STZ.w !RAM_SMB1_Global_MainScreenWindowMaskMirror
	STZ.w !RAM_SMB1_Global_SubScreenWindowMaskMirror
	STZ.w !RAM_SMB1_Global_BG1And2WindowMaskSettingsMirror
	STZ.w !RAM_SMB1_Global_BG3And4WindowMaskSettingsMirror
	STZ.w !RAM_SMB1_Global_ObjectAndColorWindowSettingsMirror
	STZ.w !RAM_SMB1_Global_ColorMathInitialSettingsMirror
	LDX.b #$20
	STX.w !RAM_SMB1_Global_ColorMathSelectAndEnableMirror
	CMP.b #$FF
	BNE.b CODE_048280
	RTL

CODE_048280:							; Note: Something related to underwater HDMA.
	PHB
	PHK
	PLB
	STA.b $00
	ASL
	TAY
	PHY
	LDA.w DATA_04824E,y
	STA.b $01
	LDX.w DATA_04823E,y
	LDY.b #$00
CODE_048292:
	LDA.w DATA_0483AC,x
	STA.w !RAM_SMB1_Global_HDMAGradientRedChannelScanlinesAndPtrsTable,y
	LDA.w DATA_04840E,x
	STA.w !RAM_SMB1_Global_HDMAGradientGreenChannelScanlinesAndPtrsTable,y
	LDA.w DATA_048470,x
	STA.w !RAM_SMB1_Global_HDMAGradientBlueChannelScanlinesAndPtrsTable,y
	INX
	INY
	CPY.b $01
	BNE.b CODE_048292
	PLY
	LDA.w DATA_048256,y
	STA.b $01
	LDX.w DATA_048246,y
	LDY.b #$00
CODE_0482B5:
	LDA.w DATA_0484D2,x
	STA.w !RAM_SMB1_Global_HDMAGradientRedChannelData,y
	LDA.w DATA_048512,x
	STA.w !RAM_SMB1_Global_HDMAGradientGreenChannelData,y
	LDA.w DATA_048552,x
	STA.w !RAM_SMB1_Global_HDMAGradientBlueChannelData,y
	INX
	INY
	CPY.b $01
	BNE.b CODE_0482B5
	REP.b #$10
	LDX.w #(!REGISTER_FixedColorData&$0000FF<<8)+$40
	STX.w HDMA[$05].Parameters
	STX.w HDMA[$06].Parameters
	STX.w HDMA[$07].Parameters
	LDX.w #!RAM_SMB1_Global_HDMAGradientRedChannelScanlinesAndPtrsTable
	STX.w HDMA[$05].SourceLo
	LDX.w #!RAM_SMB1_Global_HDMAGradientGreenChannelScanlinesAndPtrsTable
	STX.w HDMA[$06].SourceLo
	LDX.w #!RAM_SMB1_Global_HDMAGradientBlueChannelScanlinesAndPtrsTable
	STX.w HDMA[$07].SourceLo
	LDA.b #$001520>>16
	STA.w HDMA[$05].SourceBank
	STA.w HDMA[$06].SourceBank
	STA.w HDMA[$07].SourceBank
	LDA.b #!RAM_SMB1_Global_HDMAGradientRedChannelScanlinesAndPtrsTable>>16
	STA.w HDMA[$05].IndirectSourceBank
	LDA.b #!RAM_SMB1_Global_HDMAGradientGreenChannelScanlinesAndPtrsTable>>16
	STA.w HDMA[$06].IndirectSourceBank
	LDA.b #!RAM_SMB1_Global_HDMAGradientBlueChannelScanlinesAndPtrsTable>>16
	STA.w HDMA[$07].IndirectSourceBank
	LDA.b #$01
	STA.w $15E0
	LDA.b $00
	CMP.b #$02
	BNE.b CODE_048357
	LDX.w #(!REGISTER_Window2LeftPositionDesignation&$0000FF<<8)+$41
	STX.w HDMA[$04].Parameters
	LDX.w #DATA_0483A5
	STX.w HDMA[$04].SourceLo
	LDA.b #DATA_0483A5>>16
	STA.w HDMA[$04].SourceBank
	LDA.b #DATA_0483A5>>16
	STA.w HDMA[$04].IndirectSourceBank
	LDA.b #$17
	STA.w !RAM_SMB1_Global_MainScreenWindowMaskMirror
	STZ.w !RAM_SMB1_Global_SubScreenWindowMaskMirror
	STZ.w !RAM_SMB1_Global_BG1And2WindowMaskSettingsMirror
	STZ.w !RAM_SMB1_Global_BG3And4WindowMaskSettingsMirror
	LDA.b #$80
	STA.w !RAM_SMB1_Global_ObjectAndColorWindowSettingsMirror
	LDA.b #$10
	STA.w !RAM_SMB1_Global_ColorMathInitialSettingsMirror
	LDA.b #$33
	STA.w !RAM_SMB1_Global_ColorMathSelectAndEnableMirror
	LDA.b #$F0
	STA.w !RAM_SMB1_Global_HDMAEnableMirror
	STZ.w SMB1_PaletteMirror[$00].LowByte
	STZ.w SMB1_PaletteMirror[$00].HighByte
	INC.w !RAM_SMB1_Global_UpdateEntirePaletteFlag
	SEP.b #$10
	PLB
	RTL

CODE_048357:
	LDA.b #$E0
	STA.w !RAM_SMB1_Global_HDMAEnableMirror
	SEP.b #$10
	PLB
	RTL

;--------------------------------------------------------------------

; Note: This routine is also called by SMBLL.

DATA_048360:
	db $00,$03,$06,$09,$09,$06,$03,$00

DATA_048368:
	db $0C,$0C,$0C,$1C,$0C,$0C,$0C,$1C

DATA_048370:
	db $01,$01,$01,$01,$FF,$FF,$FF,$FF

SMB1_AdjustUnderwaterHDMAGradient:
.Main:
;$048378
	PHB
	PHK
	PLB
	DEC.w $15E0
	BNE.b CODE_0483A3
	LDX.w $15E2
	LDA.w DATA_048368,x
	STA.w $15E0
	LDY.w DATA_048360,x
	LDA.w !RAM_SMB1_Global_HDMAGradientRedChannelScanlinesAndPtrsTable,y
	CLC
	ADC.w DATA_048370,x
	STA.w !RAM_SMB1_Global_HDMAGradientRedChannelScanlinesAndPtrsTable,y
	STA.w !RAM_SMB1_Global_HDMAGradientGreenChannelScanlinesAndPtrsTable,y
	STA.w !RAM_SMB1_Global_HDMAGradientBlueChannelScanlinesAndPtrsTable,y
	INX
	TXA
	AND.b #$07
	STA.w $15E2
CODE_0483A3:
	PLB
	RTL

;--------------------------------------------------------------------

DATA_0483A5:
	db $27 : dw DATA_048592
	db $02 : dw DATA_048594
	db $00

DATA_0483AC:
	db $40 : dw !RAM_SMB1_Global_HDMAGradientRedChannelData+$00
	db $08 : dw !RAM_SMB1_Global_HDMAGradientRedChannelData+$01
	db $08 : dw !RAM_SMB1_Global_HDMAGradientRedChannelData+$02
	db $08 : dw !RAM_SMB1_Global_HDMAGradientRedChannelData+$03
	db $06 : dw !RAM_SMB1_Global_HDMAGradientRedChannelData+$04
	db $06 : dw !RAM_SMB1_Global_HDMAGradientRedChannelData+$05
	db $06 : dw !RAM_SMB1_Global_HDMAGradientRedChannelData+$06
	db $06 : dw !RAM_SMB1_Global_HDMAGradientRedChannelData+$07
	db $08 : dw !RAM_SMB1_Global_HDMAGradientRedChannelData+$08
	db $04 : dw !RAM_SMB1_Global_HDMAGradientRedChannelData+$09
	db $04 : dw !RAM_SMB1_Global_HDMAGradientRedChannelData+$0A
	db $04 : dw !RAM_SMB1_Global_HDMAGradientRedChannelData+$0B
	db $04 : dw !RAM_SMB1_Global_HDMAGradientRedChannelData+$0C
	db $04 : dw !RAM_SMB1_Global_HDMAGradientRedChannelData+$0D
	db $03 : dw !RAM_SMB1_Global_HDMAGradientRedChannelData+$0E
	db $01 : dw !RAM_SMB1_Global_HDMAGradientRedChannelData+$0F
	db $00

	db $20 : dw !RAM_SMB1_Global_HDMAGradientRedChannelData+$00
	db $02 : dw !RAM_SMB1_Global_HDMAGradientRedChannelData+$01
	db $02 : dw !RAM_SMB1_Global_HDMAGradientRedChannelData+$02
	db $03 : dw !RAM_SMB1_Global_HDMAGradientRedChannelData+$03
	db $03 : dw !RAM_SMB1_Global_HDMAGradientRedChannelData+$04
	db $04 : dw !RAM_SMB1_Global_HDMAGradientRedChannelData+$05
	db $04 : dw !RAM_SMB1_Global_HDMAGradientRedChannelData+$06
	db $05 : dw !RAM_SMB1_Global_HDMAGradientRedChannelData+$07
	db $06 : dw !RAM_SMB1_Global_HDMAGradientRedChannelData+$08
	db $07 : dw !RAM_SMB1_Global_HDMAGradientRedChannelData+$09
	db $08 : dw !RAM_SMB1_Global_HDMAGradientRedChannelData+$0A
	db $09 : dw !RAM_SMB1_Global_HDMAGradientRedChannelData+$0B
	db $0A : dw !RAM_SMB1_Global_HDMAGradientRedChannelData+$0C
	db $0B : dw !RAM_SMB1_Global_HDMAGradientRedChannelData+$0D
	db $0C : dw !RAM_SMB1_Global_HDMAGradientRedChannelData+$0E
	db $01 : dw !RAM_SMB1_Global_HDMAGradientRedChannelData+$0F
	db $00

DATA_04840E:
	db $40 : dw !RAM_SMB1_Global_HDMAGradientGreenChannelData+$00
	db $08 : dw !RAM_SMB1_Global_HDMAGradientGreenChannelData+$01
	db $08 : dw !RAM_SMB1_Global_HDMAGradientGreenChannelData+$02
	db $08 : dw !RAM_SMB1_Global_HDMAGradientGreenChannelData+$03
	db $06 : dw !RAM_SMB1_Global_HDMAGradientGreenChannelData+$04
	db $06 : dw !RAM_SMB1_Global_HDMAGradientGreenChannelData+$05
	db $06 : dw !RAM_SMB1_Global_HDMAGradientGreenChannelData+$06
	db $06 : dw !RAM_SMB1_Global_HDMAGradientGreenChannelData+$07
	db $08 : dw !RAM_SMB1_Global_HDMAGradientGreenChannelData+$08
	db $04 : dw !RAM_SMB1_Global_HDMAGradientGreenChannelData+$09
	db $04 : dw !RAM_SMB1_Global_HDMAGradientGreenChannelData+$0A
	db $04 : dw !RAM_SMB1_Global_HDMAGradientGreenChannelData+$0B
	db $04 : dw !RAM_SMB1_Global_HDMAGradientGreenChannelData+$0C
	db $04 : dw !RAM_SMB1_Global_HDMAGradientGreenChannelData+$0D
	db $03 : dw !RAM_SMB1_Global_HDMAGradientGreenChannelData+$0E
	db $01 : dw !RAM_SMB1_Global_HDMAGradientGreenChannelData+$0F
	db $00

	db $20 : dw !RAM_SMB1_Global_HDMAGradientGreenChannelData+$00
	db $02 : dw !RAM_SMB1_Global_HDMAGradientGreenChannelData+$01
	db $02 : dw !RAM_SMB1_Global_HDMAGradientGreenChannelData+$02
	db $03 : dw !RAM_SMB1_Global_HDMAGradientGreenChannelData+$03
	db $03 : dw !RAM_SMB1_Global_HDMAGradientGreenChannelData+$04
	db $04 : dw !RAM_SMB1_Global_HDMAGradientGreenChannelData+$05
	db $04 : dw !RAM_SMB1_Global_HDMAGradientGreenChannelData+$06
	db $05 : dw !RAM_SMB1_Global_HDMAGradientGreenChannelData+$07
	db $06 : dw !RAM_SMB1_Global_HDMAGradientGreenChannelData+$08
	db $07 : dw !RAM_SMB1_Global_HDMAGradientGreenChannelData+$09
	db $08 : dw !RAM_SMB1_Global_HDMAGradientGreenChannelData+$0A
	db $09 : dw !RAM_SMB1_Global_HDMAGradientGreenChannelData+$0B
	db $0A : dw !RAM_SMB1_Global_HDMAGradientGreenChannelData+$0C
	db $0B : dw !RAM_SMB1_Global_HDMAGradientGreenChannelData+$0D
	db $0C : dw !RAM_SMB1_Global_HDMAGradientGreenChannelData+$0E
	db $01 : dw !RAM_SMB1_Global_HDMAGradientGreenChannelData+$0F
	db $00

DATA_048470:
	db $40 : dw !RAM_SMB1_Global_HDMAGradientBlueChannelData+$00
	db $08 : dw !RAM_SMB1_Global_HDMAGradientBlueChannelData+$01
	db $08 : dw !RAM_SMB1_Global_HDMAGradientBlueChannelData+$02
	db $08 : dw !RAM_SMB1_Global_HDMAGradientBlueChannelData+$03
	db $06 : dw !RAM_SMB1_Global_HDMAGradientBlueChannelData+$04
	db $06 : dw !RAM_SMB1_Global_HDMAGradientBlueChannelData+$05
	db $06 : dw !RAM_SMB1_Global_HDMAGradientBlueChannelData+$06
	db $06 : dw !RAM_SMB1_Global_HDMAGradientBlueChannelData+$07
	db $08 : dw !RAM_SMB1_Global_HDMAGradientBlueChannelData+$08
	db $04 : dw !RAM_SMB1_Global_HDMAGradientBlueChannelData+$09
	db $04 : dw !RAM_SMB1_Global_HDMAGradientBlueChannelData+$0A
	db $04 : dw !RAM_SMB1_Global_HDMAGradientBlueChannelData+$0B
	db $04 : dw !RAM_SMB1_Global_HDMAGradientBlueChannelData+$0C
	db $04 : dw !RAM_SMB1_Global_HDMAGradientBlueChannelData+$0D
	db $03 : dw !RAM_SMB1_Global_HDMAGradientBlueChannelData+$0E
	db $01 : dw !RAM_SMB1_Global_HDMAGradientBlueChannelData+$0F
	db $00

	db $20 : dw !RAM_SMB1_Global_HDMAGradientBlueChannelData+$00
	db $02 : dw !RAM_SMB1_Global_HDMAGradientBlueChannelData+$01
	db $02 : dw !RAM_SMB1_Global_HDMAGradientBlueChannelData+$02
	db $03 : dw !RAM_SMB1_Global_HDMAGradientBlueChannelData+$03
	db $03 : dw !RAM_SMB1_Global_HDMAGradientBlueChannelData+$04
	db $04 : dw !RAM_SMB1_Global_HDMAGradientBlueChannelData+$05
	db $04 : dw !RAM_SMB1_Global_HDMAGradientBlueChannelData+$06
	db $05 : dw !RAM_SMB1_Global_HDMAGradientBlueChannelData+$07
	db $06 : dw !RAM_SMB1_Global_HDMAGradientBlueChannelData+$08
	db $07 : dw !RAM_SMB1_Global_HDMAGradientBlueChannelData+$09
	db $08 : dw !RAM_SMB1_Global_HDMAGradientBlueChannelData+$0A
	db $09 : dw !RAM_SMB1_Global_HDMAGradientBlueChannelData+$0B
	db $0A : dw !RAM_SMB1_Global_HDMAGradientBlueChannelData+$0C
	db $0B : dw !RAM_SMB1_Global_HDMAGradientBlueChannelData+$0D
	db $0C : dw !RAM_SMB1_Global_HDMAGradientBlueChannelData+$0E
	db $01 : dw !RAM_SMB1_Global_HDMAGradientBlueChannelData+$0F
	db $00

DATA_0484D2:
	db $2A,$2B,$2C,$2D,$2E,$2F,$30,$31,$32,$33,$34,$35,$36,$37,$38,$38
	db $27,$26,$25,$24,$23,$22,$21,$20,$20,$20,$20,$20,$20,$20,$20,$20
	db $38,$2B,$2A,$29,$28,$27,$26,$25,$24,$23,$22,$21,$20,$20,$20,$20
	db $3A,$3B,$3C,$3D,$3E,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F

DATA_048512:
	db $51,$52,$53,$54,$55,$56,$57,$58,$59,$5A,$5B,$5C,$5D,$5E,$5F,$5F
	db $47,$46,$45,$44,$43,$42,$41,$40,$40,$40,$40,$40,$40,$40,$40,$40
	db $5F,$51,$50,$4F,$4E,$4D,$4C,$4B,$4A,$49,$48,$47,$46,$45,$44,$43
	db $5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F

DATA_048552:
	db $94,$95,$96,$97,$98,$99,$9A,$9B,$9C,$9D,$9E,$9F,$9F,$9F,$9F,$9F
	db $8D,$8C,$8B,$8A,$89,$88,$87,$86,$85,$84,$83,$82,$81,$80,$80,$80
	db $9F,$9C,$9B,$9A,$99,$98,$97,$96,$95,$94,$93,$92,$91,$90,$8F,$8E
	db $9F,$9F,$9F,$9F,$9F,$9F,$9F,$9F,$9F,$9F,$9F,$9F,$9F,$9F,$9F,$9F

DATA_048592:
	db $FF,$00

DATA_048594:
	db $00,$FF

;--------------------------------------------------------------------

; Note: This routine is also called by SMBLL.

CODE_048596:
	INC.w !RAM_SMB1_Player_CurrentLifeCount
	LDA.w !RAM_SMB1_Player_CurrentLifeCount
	CMP.b #$80
	BCC.b CODE_0485A5
	LDA.b #$7F
	STA.w !RAM_SMB1_Player_CurrentLifeCount
CODE_0485A5:
	RTL

	%FREE_BYTES(NULLROM, 90, $FF)

;--------------------------------------------------------------------

CODE_048600:
	LDA.w $1680
	BMI.b CODE_048629
	BNE.b CODE_048619
	LDX.w !RAM_SMB1_Player_CurrentCharacter
	LDA.w !RAM_SMB1_Global_ControllerPress1P1,x
	AND.b #!Joypad_Start>>8
	BEQ.b CODE_048629
	INC.w $1680
	LDA.b #!Define_SMAS_Sound0060_Pause1
	STA.w !RAM_SMB1_Global_SoundCh1
CODE_048619:
	DEC.w $0B9A
	DEC.w $0B9A
	LDA.w $0B9A
	BPL.b CODE_048629
	LDA.b #$0D
	STA.w $0772
CODE_048629:
	RTL

;--------------------------------------------------------------------

CODE_04862A:
	JSL.l CODE_05DE82
	JSL.l CODE_05EBAB
	LDA.b #$22
	STA.w !RAM_SMB1_Global_BG1And2WindowMaskSettingsMirror
	LDA.b #$02
	STA.w !RAM_SMB1_Global_BG3And4WindowMaskSettingsMirror
	INC.w $0772
	RTL

;--------------------------------------------------------------------

CODE_048640:
	LDA.w !REGISTER_APUPort0
	BNE.b CODE_04864F
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_J1) != $00
	LDA.b #$0C
else
	LDA.b #$0F
endif
	STA.w $0772
	LDA.b #$80
	STA.w $1680
CODE_04864F:
	RTL

;--------------------------------------------------------------------

CODE_048650:
	PHB
	PHK
	PLB
	LDY.w !RAM_SMB1_Player_CurrentCharacter
	LDA.w !RAM_SMB1_Global_ControllerPress1P1,y
	AND.b #(!Joypad_DPadU>>8)|(!Joypad_DPadD>>8)|(!Joypad_Select>>8)
	BEQ.b CODE_04866D
	LDA.b #!Define_SMAS_Sound0063_Coin
	STA.w !RAM_SMB1_Global_SoundCh3
	STZ.w !RAM_SMB1_Global_BlinkingCursorFrameCounter
	LDA.w !RAM_SMB1_GameOverScreen_BlinkingCursorPos
	EOR.b #$10
	STA.w !RAM_SMB1_GameOverScreen_BlinkingCursorPos
CODE_04866D:
	LDY.b #$03
CODE_04866F:
	LDA.w DATA_0486DB,y
	STA.w SMB1_OAMBuffer[$00].XDisp,y
	DEY
	BPL.b CODE_04866F
	LDA.w SMB1_OAMBuffer[$00].YDisp
	CLC
	ADC.w !RAM_SMB1_GameOverScreen_BlinkingCursorPos
	STA.w SMB1_OAMBuffer[$00].YDisp
	INC.w !RAM_SMB1_Global_BlinkingCursorFrameCounter
	LDA.w !RAM_SMB1_Global_BlinkingCursorFrameCounter
	AND.b #$10
	LSR
	LSR
	LSR
	LSR
	ORA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot
	LDY.w !RAM_SMB1_Player_CurrentCharacter
	LDX.b #$00
	LDA.w !RAM_SMB1_Global_ControllerPress1P1,y
	AND.b #!Joypad_Start>>8
	BEQ.b CODE_0486D7
	LDA.b #!Define_SMAS_Sound0063_Correct
	STA.w !RAM_SMB1_Global_SoundCh3
	STZ.w !RAM_SMB1_Player_CurrentStartingScreen
	STZ.w !RAM_SMB1_Player_CurrentCoinCount
	STZ.w !RAM_SMB1_Player_CurrentLevel
	STZ.w !RAM_SMB1_Player_CurrentLevelNumberDisplay
	LDA.w !RAM_SMB1_GameOverScreen_BlinkingCursorPos
	BEQ.b CODE_0486B8
	STZ.w !RAM_SMB1_Player_CurrentWorld
CODE_0486B8:
	LDA.w DATA_0486D9,y
	TAX
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_J1) != $00
	LDY.b #$07
else
	LDY.b #$06
endif
CODE_0486BE:
	STZ.w $07DA,x
	STZ.w !RAM_SMB1_Player_MariosScoreMillionsDigit,x
	INX
	DEY
	BNE.b CODE_0486BE
	LDX.b #$02
	LDA.w !RAM_SMB1_GameOverScreen_BlinkingCursorPos
	BNE.b CODE_0486D7
	LDA.b #$04
	STA.w !RAM_SMB1_Player_CurrentLifeCount
	INC.w !RAM_SMB1_Level_CanFindHidden1upFlag
CODE_0486D7:
	PLB
	RTL

DATA_0486D9:
	db $00,$06

DATA_0486DB:
	db $50,$6C,$0C,$2B

;--------------------------------------------------------------------

CODE_0486DF:
	PHB
	PHK
	PLB
	REP.b #$30
	LDX.w #$0000
CODE_0486E7:
	LDA.w DATA_0486FD,x
	STA.w SMB1_StripeImageUploadTable[$00].LowByte,y
	INY
	INY
	INX
	INX
	CMP.w #$FFFF
	BNE.b CODE_0486E7
	STY.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	SEP.b #$30
	PLB
	RTL

DATA_0486FD:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMB1_J) != $00
	db $09,$AE,$00,$01
	db $AD,$02

	db $09,$B1,$00,$01
	db $AD,$02

	db $09,$CD,$00,$0D
	db $AE,$02,$AF,$02,$24,$00,$A6,$02,$A6,$02,$A7,$02,$A8,$02

	db $0A,$0D,$00,$0B
	db $B0,$02,$B1,$02,$24,$00,$B2,$02,$B3,$02,$A8,$02
else
	db $09,$CD,$00,$0F
	db $A1,$02,$A2,$02,$A3,$02,$A4,$02,$A5,$02,$A6,$02,$A7,$02,$A8,$02

	db $0A,$0D,$00,$07
	db $A9,$02,$AA,$02,$AB,$02,$AC,$02
endif
	db $FF,$FF

;--------------------------------------------------------------------

CODE_04871F:
	LDA.w $0B9A
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMB1_J) != $00
	BMI.b CODE_048726
endif
	CMP.b #$30
	BCC.b CODE_048727
CODE_048726:
	RTL

CODE_048727:
	PHB
	PHK
	PLB
	PHD
	REP.b #$30
	LDA.w #$0B00
	TCD
	STZ.b $0B84
	STZ.b $0B8E
	STZ.b $0B90
	STZ.b $0B92
	LDA.b $0B9A
	AND.w #$00FF
	ASL
	TAX
	LDA.l SMB1_CircleHDMAData_DATA_00973E,x				; Note: Shared SMAS data
	STA.b $0B94
	LDA.w #$0078
	STA.b $0B96
	LDA.w #$00B0
	STA.b $0B98
CODE_048750:
	LDA.w #$0100
	STA.b $0B80
	STA.b $0B82
	LDA.b $0B90
	INC
	CMP.b $0B9A
	BCS.b CODE_048794
	LDA.b $0B92
	CLC
	ADC.b $0B94
	STA.b $0B92
	XBA
	AND.w #$00FF
	LSR
	SEP.b #$30
	TAX
	LDA.l SMB1_CircleHDMAData_DATA_0096BD,x				; Note: Shared SMAS data
	STA.w !REGISTER_Multiplicand
	LDA.b $0B9A
	STA.w !REGISTER_Multiplier
	NOP #4
	LDA.w $4217
	STA.b $0B88
	STZ.b $0B89
	REP.b #$30
	LDA.b $0B88
	CLC
	ADC.b $0B98
	STA.b $0B82
	LDA.b $0B98
	SEC
	SBC.b $0B88
	STA.b $0B80
CODE_048794:
	LDA.b $0B96
	SEC
	SBC.b $0B90
	DEC
	ASL
	STA.b $0B84
	TAX
	LDA.b $0B80
	TAY
	BMI.b CODE_0487B2
	AND.w #$FF00
	BEQ.b CODE_0487B5
	CMP.w #$0100
	BNE.b CODE_0487B2
	LDY.w #$00FF
	BRA.b CODE_0487B5

CODE_0487B2:
	LDY.w #$0000
CODE_0487B5:
	TYA
	AND.w #$00FF
	STA.b $0B86
	LDA.b $0B82
	TAY
	AND.w #$FF00
	BEQ.b CODE_0487C6
	LDY.w #$00FF
CODE_0487C6:
	TYA
	AND.w #$00FF
	XBA
	ORA.b $0B86
	STA.b $0B86
	CPX.w #$01C0
	BCS.b CODE_0487E0
	CMP.w #$FFFF
	BNE.b CODE_0487DC
	LDA.w #$00FF
CODE_0487DC:
	STA.l $7FF000,x
CODE_0487E0:
	LDA.b $0B96
	CLC
	ADC.b $0B90
	DEC
	ASL
	STA.b $0B8E
	CMP.w #$01C0
	BCS.b CODE_0487FD
	TAX
	LDA.b $0B86
	CMP.w #$FFFF
	BNE.b CODE_0487F9
	LDA.w #$00FF
CODE_0487F9:
	STA.l $7FF000,x
CODE_0487FD:
	INC.b $0B90
	LDA.b $0B84
	CMP.w #$01C0
	BCC.b CODE_04880D
	LDA.b $0B8E
	CMP.w #$01C0
	BCS.b CODE_048810
CODE_04880D:
	JMP.w CODE_048750

CODE_048810:
	SEP.b #$30
	INC.b $0B9A
	PLD
	PLB
	RTL

;--------------------------------------------------------------------

CODE_048817:
	SEP.b #$10
	LDX.b #$00
CODE_04881B:
	STZ.w $05D0,x
	STZ.w $05E0,x
	STZ.w $05F0,x
	STZ.w $0600,x
	STZ.w $0610,x
	STZ.w $0620,x
	STZ.w $0630,x
	STZ.w $0640,x
	STZ.w $0650,x
	STZ.w $0660,x
	STZ.w $0670,x
	STZ.w $0680,x
	STZ.w $0690,x
	INX
	TXA
	AND.b #$0F
	BNE.b CODE_04881B
	LDA.b #$68
	STA.w $0640
	STA.w $0641
	STA.w $0642
	STA.w $0673
	STA.w $0674
	STA.w $0675
	STA.w $0676
	STA.w $0649
	STA.w $064A
	STA.w $064B
	STA.w $064C
	STA.w $064D
	STA.w $064E
	LDA.b #$01
	STA.w $0EC9
	RTL

--------------------------------------------------------------------

DATA_048877:
	db $58,$43,$00,$09
	db $16,$20,$0A,$20,$1B,$20,$12,$20,$18,$20

	db $FF

DATA_048886:
	db $58,$43,$00,$09
	db $15,$20,$1E,$20,$12,$20,$10,$20,$12,$20

	db $FF

CODE_048895:
	PHB
	PHK
	PLB
	PHX
	LDA.w !RAM_SMB1_Player_CurrentCharacter
	BNE.b CODE_0488AE
	LDX.b #$00
CODE_0488A0:
	LDA.w DATA_048877,x
	STA.w SMB1_StripeImageUploadTable[$00].LowByte,y
	INY
	INX
	CMP.b #$FF
	BNE.b CODE_0488A0
	BRA.b CODE_0488BC

CODE_0488AE:
	LDX.b #$00
CODE_0488B0:
	LDA.w DATA_048886,x
	STA.w SMB1_StripeImageUploadTable[$00].LowByte,y
	INY
	INX
	CMP.b #$FF
	BNE.b CODE_0488B0
CODE_0488BC:
	PLX
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0488BF:
	STZ.b !RAM_SMB1_Global_ScratchRAMF6
	REP.b #$30
	LDA.w $0EEC
	STA.b !RAM_SMB1_Global_ScratchRAMF3
	STZ.b !RAM_SMB1_Global_ScratchRAMF7
CODE_0488CA:
	LDX.b !RAM_SMB1_Global_ScratchRAMF3
	SEP.b #$20
	LDA.l DATA_048949,x
	CLC
	ROL
	ROL
	AND.b #$01
	STA.b !RAM_SMB1_Global_ScratchRAMF5
	LDA.l DATA_048949+$01,x
	ASL
	REP.b #$21
	LDX.b !RAM_SMB1_Global_ScratchRAMF7
	ADC.b !RAM_SMB1_Global_ScratchRAMF5
	AND.w #$00FF
	CMP.w #$0080
	BCC.b CODE_0488EF
	ORA.w #$FF00
CODE_0488EF:
	CLC
	ADC.w !RAM_SMB1_Global_CurrentLayer2XPosLo
	CLC
	ADC.w #$0008
	STA.l $7F2000,x
	LDA.b !RAM_SMB1_Global_ScratchRAMF3
	CLC
	ADC.w #$0010
	AND.w #$01FF
	STA.b !RAM_SMB1_Global_ScratchRAMF3
	INC.b !RAM_SMB1_Global_ScratchRAMF7
	INC.b !RAM_SMB1_Global_ScratchRAMF7
	LDA.b !RAM_SMB1_Global_ScratchRAMF7
	CMP.w #$0040
	BNE.b CODE_0488CA
	LDA.w $0EEC
	CLC
	ADC.w #$0004
	AND.w #$01FF
	STA.w $0EEC
	SEP.b #$30
	PHB
	LDA.b #$7F2000>>16
	PHA
	PLB
	REP.b #$20
	LDY.b #$3E
CODE_048929:
	LDA.w $7F2000,y
	STA.w $7F2040,y
	STA.w $7F2080,y
	STA.w $7F20C0,y
	STA.w $7F2100,y
	STA.w $7F2140,y
	STA.w $7F2180,y
	STA.w $7F21C0,y
	DEY
	DEY
	BPL.b CODE_048929
	SEP.b #$20
	PLB
	RTL

DATA_048949:
	dw $0000,$FFFA,$FFF4,$FFEE,$FFE7,$FFE1,$FFDB,$FFD5
	dw $FFCF,$FFC8,$FFC2,$FFBC,$FFB6,$FFB0,$FFAA,$FFA4
	dw $FF9F,$FF99,$FF93,$FF8D,$FF88,$FF82,$FF7D,$FF78
	dw $FF72,$FF6D,$FF68,$FF63,$FF5E,$FF59,$FF55,$FF50
	dw $FF4B,$FF47,$FF43,$FF3F,$FF3B,$FF37,$FF33,$FF2F
	dw $FF2C,$FF28,$FF25,$FF22,$FF1F,$FF1C,$FF19,$FF16
	dw $FF14,$FF12,$FF0F,$FF0D,$FF0C,$FF0A,$FF08,$FF07
	dw $FF05,$FF04,$FF03,$FF02,$FF02,$FF01,$FF01,$FF01
	dw $FF01,$FF01,$FF01,$FF01,$FF02,$FF02,$FF03,$FF04
	dw $FF05,$FF07,$FF08,$FF0A,$FF0C,$FF0D,$FF0F,$FF12
	dw $FF14,$FF16,$FF19,$FF1C,$FF1F,$FF22,$FF25,$FF28
	dw $FF2C,$FF2F,$FF33,$FF37,$FF3B,$FF3F,$FF43,$FF47
	dw $FF4B,$FF50,$FF55,$FF59,$FF5E,$FF63,$FF68,$FF6D
	dw $FF72,$FF78,$FF7D,$FF82,$FF88,$FF8D,$FF93,$FF99
	dw $FF9F,$FFA4,$FFAA,$FFB0,$FFB6,$FFBC,$FFC2,$FFC8
	dw $FFCF,$FFD5,$FFDB,$FFE1,$FFE7,$FFEE,$FFF4,$FFFA
	dw $0000,$0006,$000C,$0012,$0019,$001F,$0025,$002B
	dw $0031,$0038,$003E,$0044,$004A,$0050,$0056,$005C
	dw $0061,$0067,$006D,$0073,$0078,$007E,$0083,$0088
	dw $008E,$0093,$0098,$009D,$00A2,$00A7,$00AB,$00B0
	dw $00B5,$00B9,$00BD,$00C1,$00C5,$00C9,$00CD,$00D1
	dw $00D4,$00D8,$00DB,$00DE,$00E1,$00E4,$00E7,$00EA
	dw $00EC,$00EE,$00F1,$00F3,$00F4,$00F6,$00F8,$00F9
	dw $00FB,$00FC,$00FD,$00FE,$00FE,$00FF,$00FF,$00FF
	dw $00FF,$00FF,$00FF,$00FF,$00FE,$00FE,$00FD,$00FC
	dw $00FB,$00F9,$00F8,$00F6,$00F4,$00F3,$00F1,$00EE
	dw $00EC,$00EA,$00E7,$00E4,$00E1,$00DE,$00DB,$00D8
	dw $00D4,$00D1,$00CD,$00C9,$00C5,$00C1,$00BD,$00B9
	dw $00B5,$00B0,$00AB,$00A7,$00A2,$009D,$0098,$0093
	dw $008E,$0088,$0083,$007E,$0078,$0073,$006D,$0067
	dw $0061,$005C,$0056,$0050,$004A,$0044,$003E,$0038
	dw $0031,$002B,$0025,$001F,$0019,$0012,$000C,$0006

;--------------------------------------------------------------------

; Note: Something to do with layer 3.

CODE_048B49:
	PHB
	PHK
	PLB
	BRA.b CODE_048B59

SMB3_BufferLayer3Tilemap:
.Main:
	PHB
	PHK
	PLB
	LDA.w !RAM_SMB1_Global_EnableLayer3BGFlag
	BEQ.b CODE_048B85
	JSR.w CODE_048C77
CODE_048B59:
	PHX
	PHY
	LDA.w $0ED6
	AND.b #$80
	STA.w $0ED6
	LDA.b !RAM_SMB1_Level_CurrentLevelType
	BNE.b CODE_048B72
	JSR.w SMB1_BufferAnimatedWaterSurfaceTiles_Main
	LDA.b #$06
	STA.w !RAM_SMB1_Global_StripeImageToUpload
	JMP.w CODE_048B7E

CODE_048B72:
	CMP.b #$01
	BNE.b CODE_048B83
	JSR.w SMB3_BufferLayer3CloudTilemap_Main
	LDA.b #$01
	STA.w $0ED4
CODE_048B7E:
	LDA.b #$01
	STA.w $0EDE
CODE_048B83:
	PLY
	PLX
CODE_048B85:
	PLB
	RTL

;--------------------------------------------------------------------

SMB3_BufferLayer3CloudTilemap:
.Main:
;$048B87
	REP.b #$30
	LDA.w #$000E
	STA.b !RAM_SMB1_Global_ScratchRAMF7
	LDA.w $0ED9
	STA.b $00
	LDA.l $7F2000
	TAX
	LDA.b !RAM_SMB1_Global_ScratchRAMF3
	XBA
	STA.l $7F2002,x
	INC
	STA.l $7F203C,x
CODE_048BA4:
	PHX
	LDX.b $00
	LDA.l $7F3000,x
	AND.w #$00FF
	ASL
	ASL
	ASL
	TAY
	PLX
	LDA.w SMB1_Layer3CloudBGTilemap_Main,y
	STA.l $7F2004,x
	LDA.w SMB1_Layer3CloudBGTilemap_Main+$02,y
	STA.l $7F2006,x
	LDA.w SMB1_Layer3CloudBGTilemap_Main+$04,y
	STA.l $7F203E,x
	LDA.w SMB1_Layer3CloudBGTilemap_Main+$06,y
	STA.l $7F2040,x
	INX
	INX
	INX
	INX
	LDA.b $00
	CLC
	ADC.w #$0010
	STA.b $00
	DEC.b !RAM_SMB1_Global_ScratchRAMF7
	BNE.b CODE_048BA4
	LDA.l $7F2000
	TAX
	LDA.w #$FFFF
	STA.l $7F2076,x
	LDA.l $7F2000
	CLC
	ADC.w #$0074
	STA.l $7F2000
	LDA.w $0ED9
	INC
	AND.w #$000F
	BNE.b CODE_048C0F
	LDA.w $0ED9
	AND.w #$FFF0
	CLC
	ADC.w #$00E0
	STA.w $0ED9
	BRA.b CODE_048C12

CODE_048C0F:
	INC.w $0ED9
CODE_048C12:
	LDA.w $0ED9
	CMP.w #$0A80
	BCC.b CODE_048C1D
	STZ.w $0ED9
CODE_048C1D:
	LDA.b !RAM_SMB1_Global_ScratchRAMF3
	CLC
	ADC.w #$0200
	STA.b !RAM_SMB1_Global_ScratchRAMF3
	SEP.b #$30
	RTS

;--------------------------------------------------------------------

SMB1_BufferAnimatedWaterSurfaceTiles:
.Main:
;$048C28
	REP.b #$30
	LDX.w $1A00
	LDA.b !RAM_SMB1_Global_ScratchRAMF3
	STA.w $1A02,x
	CLC
	ADC.w #$0100
	STA.w $1A08,x
	CLC
	ADC.w #$0100
	STA.b !RAM_SMB1_Global_ScratchRAMF3
	LDA.w #$0100
	STA.w $1A04,x
	STA.w $1A0A,x
	LDA.b !RAM_SMB1_Global_ScratchRAMF3
	AND.w #$0200
	BNE.b CODE_048C57
	LDA.w #$2C2C
	LDY.w #$2C2D
	BRA.b CODE_048C5D

CODE_048C57:
	LDA.w #$2C2E
	LDY.w #$2C2F
CODE_048C5D:
	STA.w $1A06,x
	TYA
	STA.w $1A0C,x
	LDA.w #$FFFF
	STA.w $1A0E,x
	LDA.w $1A00
	CLC
	ADC.w #$000C
	STA.w $1A00
	SEP.b #$30
	RTS

;--------------------------------------------------------------------

CODE_048C77:
	REP.b #$30
	LDA.w !RAM_SMB1_Global_CurrentLayer3XPosLo
	CLC
	ADC.w #$0120
	XBA
	STA.b !RAM_SMB1_Global_ScratchRAMF3
	SEP.b #$30
CODE_048C85:
	LDA.b !RAM_SMB1_Global_ScratchRAMF3
	AND.b #$01
	BNE.b CODE_048C8F
	LDA.b #$58
	BRA.b CODE_048C91

CODE_048C8F:
	LDA.b #$5C
CODE_048C91:
	STA.b !RAM_SMB1_Global_ScratchRAMF3
	LDA.b !RAM_SMB1_Global_ScratchRAMF4
	LSR
	LSR
	LSR
	CLC
	ADC.b #$80
	STA.b !RAM_SMB1_Global_ScratchRAMF4
	RTS

;--------------------------------------------------------------------

; Note: Routine that spawns in the castle tiles with priority after Mario grabs the flagpole.
; Putting an RTL at the start of this routine means that you can see Mario after he enters the castle.

DATA_048C9E:
	db $00,$00,$80,$07
	db $62,$2E,$72,$2E,$73,$2E,$72,$2E

	db $00,$00,$80,$07
	db $63,$2E,$73,$2E,$72,$2E,$73,$2E

	db $00,$00,$80,$07
	db $64,$2E,$74,$2E,$4E,$2E,$74,$2E

	db $FF,$FF

DATA_048CC4:
	db $00,$00,$80,$07
	db $73,$2E,$72,$2E,$73,$2E,$72,$2E

	db $00,$00,$80,$07
	db $72,$2E,$73,$2E,$72,$2E,$73,$2E

	db $00,$00,$80,$07
	db $5E,$2E,$66,$2E,$67,$6E,$66,$AE

	db $FF,$FF

DATA_048CEA:
	dw DATA_048C9E
	dw DATA_048CC4

SMB1_SpawnCastleTilesWithPriority:
.Main:
;$048CEE
	PHB
	PHK
	PLB
	LDA.b #DATA_048CEA>>16
	STA.b !RAM_SMB1_Global_ScratchRAMF5
	LDA.w $0EE6
	AND.b #$01
	ASL
	REP.b #$30
	AND.w #$0002
	TAY
	LDA.w DATA_048CEA,y
	STA.b !RAM_SMB1_Global_ScratchRAMF3
	LDX.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	LDY.w #$0000
CODE_048D0C:
	LDA.b [!RAM_SMB1_Global_ScratchRAMF3],y
	STA.w SMB1_StripeImageUploadTable[$00].LowByte,x
	INY
	INY
	INX
	INX
	CMP.w #$FFFF
	BNE.b CODE_048D0C
	LDX.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	LDA.w $0EF4
	AND.w #$0020
	BEQ.b CODE_048D31
	LDA.w $0EF4
	AND.w #$0FDF
	EOR.w #$0400
	STA.w $0EF4
CODE_048D31:
	LDA.w $0EF4
	CLC
	ADC.w #$02C1
	AND.w #$0FDF
	TAY
	XBA
	STA.w SMB1_StripeImageUploadTable[$00].LowByte,x
	TYA
	INY
	TYA
	AND.w #$0020
	BEQ.b CODE_048D50
	TYA
	AND.w #$0FDF
	EOR.w #$0400
	TAY
CODE_048D50:
	TYA
	XBA
	STA.w SMB1_StripeImageUploadTable[$06].LowByte,x
	INY
	TYA
	XBA
	STA.w SMB1_StripeImageUploadTable[$0C].LowByte,x
	LDA.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	CLC
	ADC.w #$0024
	STA.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	SEP.b #$30
	STZ.w $0EE6
	LDA.b #$06
	STA.w !RAM_SMB1_Global_StripeImageToUpload
	PLB
	RTL

;--------------------------------------------------------------------

CODE_048D71:
	LDY.w $1A00
	LDA.w $1A02-$0A,y
	CMP.w #$0024
	BEQ.b CODE_048D81
	CMP.w #$10A4
	BNE.b CODE_048DC1
CODE_048D81:
	LDA.w $0ECE
	AND.w #$00FF
	BEQ.b CODE_048D8C
	JMP.w CODE_048E14

CODE_048D8C:
	INC.w $0ECE
	LDX.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	LDA.w $0ECC
	DEC
	AND.w #$041F
	CLC
	ADC.w #$0340
	XBA
	STA.w SMB1_StripeImageUploadTable[$00].LowByte,x
	LDA.w #$0780
	STA.w SMB1_StripeImageUploadTable[$01].LowByte,x
	LDA.w #$0A0D
	STA.w SMB1_StripeImageUploadTable[$02].LowByte,x
	LDA.w #$0A1D
	STA.w SMB1_StripeImageUploadTable[$03].LowByte,x
	LDA.w #$0A0F
	STA.w SMB1_StripeImageUploadTable[$04].LowByte,x
	LDA.w #$0A1F
	STA.w SMB1_StripeImageUploadTable[$05].LowByte,x
	BRA.b CODE_048E06

CODE_048DC1:
	CMP.w #$0A08
	BNE.b CODE_048E14
	LDA.w $0ECF
	AND.w #$00FF
	BEQ.b CODE_048E14
	STZ.w $0ECE
	LDA.b $43
	BNE.b CODE_048DDA
	LDA.w $0ECC
	BEQ.b CODE_048E14

CODE_048DDA:
	LDX.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	LDA.w $0ECC
	CLC
	ADC.w #$0340
	XBA
	STA.w SMB1_StripeImageUploadTable[$00].LowByte,x
	LDA.w #$0780
	STA.w SMB1_StripeImageUploadTable[$01].LowByte,x
	LDA.w #$0A0C
	STA.w SMB1_StripeImageUploadTable[$02].LowByte,x
	LDA.w #$0A1C
	STA.w SMB1_StripeImageUploadTable[$03].LowByte,x
	LDA.w #$0A0E
	STA.w SMB1_StripeImageUploadTable[$04].LowByte,x
	LDA.w #$0A1E
	STA.w SMB1_StripeImageUploadTable[$05].LowByte,x
CODE_048E06:
	LDA.w #$FFFF
	STA.w SMB1_StripeImageUploadTable[$06].LowByte,x
	TXA
	CLC
	ADC.w #$000C
	STA.w !RAM_SMB1_Global_StripeImageUploadIndexLo
CODE_048E14:
	RTL

;--------------------------------------------------------------------

; Note: Something related to object loading

CODE_048E15:
	PHB
	PHK
	PLB
	INY
	INY
	LDA.b !RAM_SMB1_Level_LevelDataPtrLo
	STA.b !RAM_SMB1_Global_ScratchRAMF3
	LDA.b !RAM_SMB1_Level_LevelDataPtrHi
	STA.b !RAM_SMB1_Global_ScratchRAMF4
	LDA.b !RAM_SMB1_Level_LevelDataPtrBank
	STA.b !RAM_SMB1_Global_ScratchRAMF5
	LDA.b [!RAM_SMB1_Global_ScratchRAMF3],y
	REP.b #$20
	AND.w #$007F
	TAX
	SEP.b #$20
	LDA.w DATA_048E43,x
	STA.b $00
	LDA.w DATA_048E43+$01,x
	STA.b $01
	SEP.b #$10
	LDX.b $9E
	LDY.b !RAM_SMB1_Global_ScratchRAMF7
	JMP.w ($0000)

DATA_048E43:						; Note: Standard objects?
	dw CODE_048EB5
	dw CODE_048EA3
	dw CODE_048EA3
	dw CODE_048EA3
	dw CODE_048EA3
	dw CODE_048EA3
	dw CODE_048EA3
	dw CODE_048EA3
	dw CODE_048EBB
	dw CODE_048EA5
	dw CODE_048EA3
	dw CODE_048EA3
	dw CODE_048EA3
	dw CODE_048EA3
	dw CODE_048EA3
	dw CODE_048EA3
	dw CODE_048F44
	dw CODE_048EA3
	dw CODE_048EA3
	dw CODE_048EA3
	dw CODE_048FD2
	dw CODE_048EA3
	dw CODE_048EA3
	dw CODE_048EA3
	dw CODE_04901B
	dw CODE_04903E
	dw CODE_04907A
	dw CODE_0490A0
	dw CODE_0490C2
	dw CODE_0490EB
	dw CODE_049121
	dw CODE_04915C
	dw CODE_04917E
	dw CODE_048EA3
	dw CODE_048EA3
	dw CODE_048EA3
	dw CODE_048EA3
	dw CODE_048EA3
	dw CODE_048EA3
	dw CODE_048EA3
	dw CODE_0491B3
	dw CODE_048EA3
	dw CODE_048EA3
	dw CODE_048EA3
	dw CODE_048EA3
	dw CODE_048EA3
	dw CODE_048EA3
	dw CODE_048EA3

;--------------------------------------------------------------------

CODE_048EA3:
	PLB
	RTL

;--------------------------------------------------------------------

CODE_048EA5:
	JSR.w CODE_0491C0
	JSL.l CODE_03AD13
	LDX.b $07
	LDA.b #$00
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,x
	PLB
	RTL

;--------------------------------------------------------------------

CODE_048EB5:
	LDX.b #$00
	LDY.b #$0F
	BRA.b CODE_048ECE

CODE_048EBB:
	TXA
	PHA
	LDX.b #$01
	LDY.b #$0F
	LDA.b #$44
	JSL.l CODE_03AD0B
	PLA
	TAX
	JSR.w CODE_0491C0
	LDX.b #$01
CODE_048ECE:
	LDA.b #$40
	JSL.l CODE_03AD0B
	PLB
	RTL

;--------------------------------------------------------------------

DATA_048ED6:
	db $00,$00,$00,$DF,$C6,$C5,$DE,$00
	db $00,$00,$00,$00,$00,$D4,$DB,$DA
	db $D0,$00,$00,$00,$00,$00,$E3,$E2
	db $C7,$C4,$E1,$E0,$00,$00,$00,$00
	db $D4,$D3,$CD,$CC,$D1,$D0,$00,$00
	db $E6,$00,$D9,$D8,$DD,$DC,$D6,$D5
	db $E5,$E4,$CB,$CA,$C9,$C8,$C7,$C4
	db $C3,$C2,$C1,$C0,$D4,$D3,$D2,$CD
	db $CC,$CD,$CC,$D2,$D1,$D0,$D9,$D8
	db $D7,$DD,$DC,$DD,$DC,$D7,$D6,$D5
	db $D9,$D8,$D7,$D7,$D7,$D7,$D7,$D7
	db $D6,$D5,$D9,$D8,$CF,$CE,$CF,$CE
	db $CF,$CE,$D6,$D5,$D9,$D8,$DD,$DC
	db $DD,$DC,$DD,$DC,$D6,$D5

CODE_048F44:
	JSR.w CODE_0491C0
	STY.b $07
	STZ.w $0EE7
	TYA
	BNE.b CODE_048F51
	LDY.b #$08
CODE_048F51:
	INY
	JSL.l CODE_03AD13
	PHX
	LDY.w $1300,x
	LDX.b $07
	LDA.b #$16
	STA.b $06
CODE_048F60:
	LDA.w DATA_048ED6,y
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,x
	INX
	LDA.b $06
	BEQ.b CODE_048F72
	TYA
	CLC
	ADC.b #$0A
	TAY
	DEC.b $06
CODE_048F72:
	CPX.b #$0B
	BNE.b CODE_048F60
	PLX
	LDA.b $07
	BEQ.b CODE_048F83
	LDA.w $1300,x
	BNE.b CODE_048F83
	STZ.w $06AB
CODE_048F83:
	LDA.w $0725
	BEQ.b CODE_048FBF
	LDA.w $1300,x
	CMP.b #$05
	BNE.b CODE_048FBF
	JSL.l CODE_03AD1B
	PHA
	JSL.l CODE_03AD23
	PLA
	CLC
	ADC.b #$08
	STA.w !RAM_SMB1_NorSpr_XPosLo,x
	LDA.w $0725
	ADC.b #$00
	STA.b !RAM_SMB1_NorSpr_XPosHi,x
	LDA.b #$01
	STA.b !RAM_SMB1_NorSpr_YPosHi,x
	STA.b !RAM_SMB1_NorSpr_SpriteSlotExistsFlag,x
	LDA.b #$90
	STA.w !RAM_SMB1_NorSpr_YPosLo,x
	LDA.b #!Define_SMB1_SpriteID_NorSpr031_GoalObject
	STA.b !RAM_SMB1_NorSpr_SpriteID,x
	INC.w $0EE7
	LDA.b $07
	BEQ.b CODE_048FBF
	INC.w $0EE7
CODE_048FBF:
	LDA.w $0725
	BEQ.b CODE_048FD0
	LDA.w $06AC
	CMP.b #$56
	BNE.b CODE_048FD0
	LDA.b #$FB
	STA.w $06AC
CODE_048FD0:
	PLB
	RTL

;--------------------------------------------------------------------

CODE_048FD2:
	JSR.w CODE_0491C0
	JSL.l CODE_03AD13
	LDA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable
	STA.b !RAM_SMB1_Global_ScratchRAMF3
	CMP.b #$65
	BEQ.b CODE_048FE5
	DEC
	BRA.b CODE_048FE6

CODE_048FE5:
	INC
CODE_048FE6:
	STA.b !RAM_SMB1_Global_ScratchRAMF4
	LDA.b $07
	TAY
	AND.b #$01
	BEQ.b CODE_048FFA
CODE_048FEF:
	LDA.b !RAM_SMB1_Global_ScratchRAMF4
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,y
	DEC.w $1300,x
	BMI.b CODE_049007
	INY
CODE_048FFA:
	LDA.b !RAM_SMB1_Global_ScratchRAMF3
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,y
	DEC.w $1300,x
	BMI.b CODE_049007
	INY
	BRA.b CODE_048FEF

CODE_049007:
	PLB
	RTL

;--------------------------------------------------------------------

DATA_049009:
	db $07,$07,$06,$05,$04,$03,$02,$01
	db $00

DATA_049012:
	db $03,$03,$04,$05,$06,$07,$08,$09
	db $0A

CODE_04901B:
	JSR.w CODE_0491C0
	JSL.l CODE_03AD13
	BCC.b CODE_049029
	LDA.b #$09
	STA.w $0734
CODE_049029:
	DEC.w $0734
	LDY.w $0734
	LDX.w DATA_049012,y
	LDA.w DATA_049009,y
	TAY
	LDA.b #$64
	JSL.l CODE_03AD0B
	PLB
	RTL

;--------------------------------------------------------------------

CODE_04903E:
	JSR.w CODE_0491C0
	JSL.l CODE_03AD13
	LDY.b $07
	LDA.w $1300,x
	BNE.b CODE_04905F
	LDA.b #$F3
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,y
	INY
	LDA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,y
	BNE.b CODE_049069
	LDA.b #$F4
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,y
	INY
	BRA.b CODE_049069

CODE_04905F:
	LDA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,y
	BNE.b CODE_049073
	LDA.b #$F5
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,y
CODE_049069:
	LDA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,y
	BNE.b CODE_049073
	LDA.b #$F6
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,y
CODE_049073:
	INY
	CPY.b #$0D
	BNE.b CODE_049069
	PLB
	RTL

;--------------------------------------------------------------------

CODE_04907A:
	JSR.w CODE_0491C0
	JSL.l CODE_03AD13
	LDY.b $07
	LDA.b #$67
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,y
	INY
	INY
CODE_04908A:
	LDA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,y
	CMP.b #$65
	BEQ.b CODE_049095
	CMP.b #$66
	BNE.b CODE_04909E
CODE_049095:
	LDA.b #$67
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,y
	INY
	INY
	BRA.b CODE_04908A

CODE_04909E:
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0490A0:
	JSR.w CODE_0491C0
	JSL.l CODE_03AD13
	LDY.b $07
	LDA.b #$F7
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,y
	INY
CODE_0490AF:
	LDA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,y
	CMP.b #$EB
	BEQ.b CODE_0490C0
	LDA.b #$F8
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,y
	INY
	CPY.b #$0D
	BNE.b CODE_0490AF
CODE_0490C0:
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0490C2:
	JSR.w CODE_0491C0
	JSL.l CODE_03AD13
	LDY.b $07
	LDA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,y
	CMP.b #$FC
	BEQ.b CODE_0490D7
	LDA.b #$F9
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,y
CODE_0490D7:
	INY
CODE_0490D8:
	LDA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,y
	CMP.b #$F0
	BEQ.b CODE_0490E9
	LDA.b #$FA
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,y
	INY
	CPY.b #$0D
	BNE.b CODE_0490D8
CODE_0490E9:
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0490EB:
	JSR.w CODE_0491C0
	JSL.l CODE_03AD13
	LDY.b $07
	LDA.w $1300,x
	BNE.b CODE_049105
	LDA.b #$02
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,y
	LDA.b #$ED
	STA.w $06A2,y
	BRA.b CODE_04911F

CODE_049105:
	LDA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,y
	CMP.b #$68
	BNE.b CODE_049110
	LDA.b #$EE
	BRA.b CODE_049112

CODE_049110:
	LDA.b #$EB
CODE_049112:
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,y
	LDA.b #$EC
	STA.w $06A2,y
	LDA.b #$69
	STA.w $06AD
CODE_04911F:
	PLB
	RTL

;--------------------------------------------------------------------

CODE_049121:
	JSR.w CODE_0491C0
	JSL.l CODE_03AD13
	LDY.b $07
	LDA.w $1300,x
	BNE.b CODE_049150
	LDA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,y
	CMP.b #$68
	BNE.b CODE_04913A
	LDA.b #$F2
	BRA.b CODE_04913C

CODE_04913A:
	LDA.b #$F0
CODE_04913C:
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,y
	LDA.b #$F1
	STA.w $06A2,y
CODE_049144:
	INY
	CPY.b #$0C
	BEQ.b CODE_04915A
	LDA.b #$69
	STA.w $06A2,y
	BRA.b CODE_049144

CODE_049150:
	LDA.b #$03
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,y
	LDA.b #$EF
	STA.w $06A2,y
CODE_04915A:
	PLB
	RTL

;--------------------------------------------------------------------

CODE_04915C:
	JSR.w CODE_0491C0
	JSL.l CODE_03AD13
	LDY.b $07
CODE_049165:
	LDA.b #$71
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,y
	INY
	DEC.w $1300,x
	BPL.b CODE_049165
	PLB
	RTL

;--------------------------------------------------------------------

DATA_049172:
	db $19,$18,$00,$00

DATA_049176:
	db $19,$22,$21,$20

DATA_04917A:
	db $19,$25,$24,$23

CODE_04917E:
	LDY.b #$03
	JSL.l CODE_03AD13
	JSR.w CODE_0491C0
	DEY
	DEY
	STY.b $05
	LDY.w $1300,x
	STY.b $06
	LDX.b $05
	INX
	LDA.w DATA_049172,y
	CMP.b #$00
	BEQ.b CODE_0491A3
	LDX.b #$00
	LDY.b $05
	JSL.l CODE_03AD0B
	CLC
CODE_0491A3:
	LDY.b $06
	LDA.w DATA_049176,y
	STA.w !RAM_SMB1_Level_NextColumnOfLevelDataTable,x
	LDA.w DATA_04917A,y
	STA.w $06A2,x
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0491B3:
	JSR.w CODE_0491C0
	LDX.b #$02
	LDA.b #$77
	JSL.l CODE_03AD0B
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0491C0:
	PHX
	REP.b #$30
	TXA
	ASL
	TAX
	SEP.b #$20
	LDY.w $1305,x
	INY
	LDA.b [!RAM_SMB1_Global_ScratchRAMF3],y
	LSR
	LSR
	LSR
	LSR
	STA.b $07
	LDA.b [!RAM_SMB1_Global_ScratchRAMF3],y
	AND.b #$0F
	SEP.b #$10
	TAY
	PLX
	RTS

;--------------------------------------------------------------------

CODE_0491DD:
	PHB
	PHK
	PLB
	PHX
	REP.b #$30
	LDX.w #$0000
	LDY.w $1A00
	LDA.w $0EC3
	AND.w #$00FF
	BEQ.b CODE_049200
CODE_0491F1:
	LDA.w SMB1_GameOverScreenStripeImage_Luigi,x
	STA.w $1A02,y
	INC
	BEQ.b CODE_04920F
	INX
	INX
	INY
	INY
	BRA.b CODE_0491F1

CODE_049200:
	LDA.w SMB1_GameOverScreenStripeImage_Mario,x
	STA.w $1A02,y
	INC
	BEQ.b CODE_04920F
	INX
	INX
	INY
	INY
	BRA.b CODE_049200

CODE_04920F:
	LDX.w #$0000
CODE_049212:
	LDA.w SMB1_GameOverScreenStripeImage_TitleLogo,x
	STA.w $1A02,y
	INC
	BEQ.b CODE_049221
	INX
	INX
	INY
	INY
	BRA.b CODE_049212

CODE_049221:
	STY.w $1A00
	LDA.w #DATA_04B623
	STA.b $02
	LDX.w #$00A0
	LDY.w #$0000
	JSR.w CODE_049724
	JSR.w CODE_049724
	JSR.w CODE_049724
	STZ.w !RAM_SMB1_Global_CurrentLayer2XPosLo
	STZ.w !RAM_SMB1_Global_CurrentLayer3XPosLo
	SEP.b #$30
	LDA.b #$06
	STA.w !RAM_SMB1_Global_StripeImageToUpload
	STZ.w $0ED1
	STZ.w !REGISTER_BG2HorizScrollOffset
	STZ.w !REGISTER_BG2HorizScrollOffset
	STZ.w !REGISTER_BG3HorizScrollOffset
	STZ.w !REGISTER_BG3HorizScrollOffset
	LDA.b #$17
	STA.w !RAM_SMB1_Global_MainScreenLayersMirror
	LDA.b #$0A
	STA.w $0099
	STA.w $0E20
	LDA.b #$01
	STA.w !RAM_SMB1_Global_UpdateEntirePaletteFlag
	JSL.l CODE_05E702
	LDA.b #$FF
	STA.w $0E66
	STZ.w !RAM_SMB1_Global_CurrentLayer2YPosLo
	STZ.w !RAM_SMB1_Global_CurrentLayer2YPosHi
	STZ.w !REGISTER_BG2VertScrollOffset
	STZ.w !REGISTER_BG2VertScrollOffset
	PLX
	PLB
	RTL

;--------------------------------------------------------------------

DATA_04927E:
	dw SMB1_LevelPreviewStripeImages_CloudAndSmallHill-SMB1_LevelPreviewStripeImages_Main
	dw SMB1_LevelPreviewStripeImages_Underground-SMB1_LevelPreviewStripeImages_Main
	dw SMB1_LevelPreviewStripeImages_WaterfallHillsWithGrassLedges-SMB1_LevelPreviewStripeImages_Main
	dw SMB1_LevelPreviewStripeImages_StandardCastle-SMB1_LevelPreviewStripeImages_Main
	dw SMB1_LevelPreviewStripeImages_DottedHillsWithNoDecorations-SMB1_LevelPreviewStripeImages_Main
	dw SMB1_LevelPreviewStripeImages_Underwater-SMB1_LevelPreviewStripeImages_Main
	dw SMB1_LevelPreviewStripeImages_GoombaPillarAndBridge-SMB1_LevelPreviewStripeImages_Main
	dw SMB1_LevelPreviewStripeImages_StandardCastle-SMB1_LevelPreviewStripeImages_Main
	dw SMB1_LevelPreviewStripeImages_SnowyNightPlain-SMB1_LevelPreviewStripeImages_Main
	dw SMB1_LevelPreviewStripeImages_SnowyNightPlain-SMB1_LevelPreviewStripeImages_Main
	dw SMB1_LevelPreviewStripeImages_NightWithGrassLedges-SMB1_LevelPreviewStripeImages_Main
	dw SMB1_LevelPreviewStripeImages_StandardCastle-SMB1_LevelPreviewStripeImages_Main
	dw SMB1_LevelPreviewStripeImages_CloudAndSmallHill-SMB1_LevelPreviewStripeImages_Main
	dw SMB1_LevelPreviewStripeImages_Underground-SMB1_LevelPreviewStripeImages_Main
	dw SMB1_LevelPreviewStripeImages_MushroomLedges-SMB1_LevelPreviewStripeImages_Main
	dw SMB1_LevelPreviewStripeImages_StandardCastle-SMB1_LevelPreviewStripeImages_Main
	dw SMB1_LevelPreviewStripeImages_DottedHillsWithDecorations-SMB1_LevelPreviewStripeImages_Main
	dw SMB1_LevelPreviewStripeImages_DottedHillsWithDecorations-SMB1_LevelPreviewStripeImages_Main
	dw SMB1_LevelPreviewStripeImages_WaterfallHillsWithGrassLedges-SMB1_LevelPreviewStripeImages_Main
	dw SMB1_LevelPreviewStripeImages_StandardCastle-SMB1_LevelPreviewStripeImages_Main
	dw SMB1_LevelPreviewStripeImages_CloudAndSmallHill-SMB1_LevelPreviewStripeImages_Main
	dw SMB1_LevelPreviewStripeImages_CloudAndSmallHill-SMB1_LevelPreviewStripeImages_Main
	dw SMB1_LevelPreviewStripeImages_NightWithGrassLedges-SMB1_LevelPreviewStripeImages_Main
	dw SMB1_LevelPreviewStripeImages_StandardCastle-SMB1_LevelPreviewStripeImages_Main
	dw SMB1_LevelPreviewStripeImages_DottedHillsWithDecorations-SMB1_LevelPreviewStripeImages_Main
	dw SMB1_LevelPreviewStripeImages_Underwater-SMB1_LevelPreviewStripeImages_Main
	dw SMB1_LevelPreviewStripeImages_GoombaPillarAndBridge-SMB1_LevelPreviewStripeImages_Main
	dw SMB1_LevelPreviewStripeImages_StandardCastle-SMB1_LevelPreviewStripeImages_Main
	dw SMB1_LevelPreviewStripeImages_CloudAndSmallHill-SMB1_LevelPreviewStripeImages_Main
	dw SMB1_LevelPreviewStripeImages_DottedHillsWithDecorations-SMB1_LevelPreviewStripeImages_Main
	dw SMB1_LevelPreviewStripeImages_CastleWall-SMB1_LevelPreviewStripeImages_Main
	dw SMB1_LevelPreviewStripeImages_FinalCastle-SMB1_LevelPreviewStripeImages_Main
	dw $0100										;\ Note: These stripe images are located in the middle of the other ones and are invalid.
	dw $0302										;| If loaded, they won't display as the first byte has the high bit set.
	dw $0101										;|
	dw $0101										;/

CODE_0492C6:
	db $01,$02,$03,$0E,$06,$05,$08,$10
	db $06,$27,$27,$27,$06,$02,$03,$0D
	db $06,$05,$05,$0E,$06,$2B,$2B,$2B
	db $06,$05,$08,$10,$06,$02,$05,$0C
	db $04

CODE_0492E7:
	PHB
	PHK
	PLB
	PHX
	PHY
	LDA.w $0E1A
	BEQ.b CODE_0492F4
	STZ.w $0E1A
CODE_0492F4:
	LDA.b #!Define_SMB1_LevelMusic_MusicFade
	STA.w !RAM_SMB1_Global_MusicCh1
	LDY.w !RAM_SMB1_Level_LevelPreviewImageToUse
	DEY
	LDA.w CODE_0492C6+$01,y
	PHA
	AND.b #$1F
	STA.b $99
	PLA
	AND.b #$E0
	STA.w $0E23
	LDA.b #$01
	STA.w $0774
	STA.w $0ED6
	JSL.l CODE_05E702
	STZ.w $0EC9
	STZ.w $0EF0
	STZ.w $0ECA
	STZ.w $130F
	STZ.w $0EDF
	INC.w $0ECE
	STZ.w $0ECF
	STZ.w $0ED1
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMB1_J) != $00
	STZ.w $0EDB
endif
	STZ.w $0B9A
	STZ.w $1680
	STZ.w $1681
	STZ.w !RAM_SMB1_Global_EnableLayer3BGFlag
	JSL.l CODE_0480EF
	LDX.w !RAM_SMB1_Player_CurrentCharacter
	STX.w $0EC3
	LDA.l DATA_03BD32,x
	JSL.l CODE_039CFE
	LDY.w !RAM_SMB1_Global_StripeImageUploadIndexLo
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) == $00
	LDA.w SMB1_StripeImageUploadTable[$06].LowByte-$18,y
	BNE.b CODE_04935A
	LDA.b #$28
	STA.w SMB1_StripeImageUploadTable[$06].LowByte-$18,y
CODE_04935A:
endif
	LDA.w !RAM_SMB1_Level_TwoPlayerGameFlag
	BEQ.b CODE_0493B4
	LDA.w !RAM_SMB1_Player_OtherPlayersLifeCount
	BMI.b CODE_0493B4
	REP.b #$20
	LDA.w #$7258
	STA.w SMB1_StripeImageUploadTable[$0C].LowByte-$18,y
	LDA.w #$0700
	STA.w SMB1_StripeImageUploadTable[$0D].LowByte-$18,y
	LDA.w #$2028
	STA.w SMB1_StripeImageUploadTable[$0E].LowByte-$18,y
	SEP.b #$20
	LDA.w !RAM_SMB1_Player_CurrentWorld
	INC
	STA.w SMB1_StripeImageUploadTable[$0F].LowByte-$18,y
	LDA.b #$20
	STA.w SMB1_StripeImageUploadTable[$0F].HighByte-$18,y
	STA.w SMB1_StripeImageUploadTable[$10].HighByte-$18,y
	STA.w SMB1_StripeImageUploadTable[$11].HighByte-$18,y
	LDA.b #$24
	STA.w SMB1_StripeImageUploadTable[$10].LowByte-$18,y
	LDA.w !RAM_SMB1_Player_CurrentLevelNumberDisplay
	INC
	STA.w SMB1_StripeImageUploadTable[$11].LowByte-$18,y
	LDA.b #$FF
	STA.w SMB1_StripeImageUploadTable[$12].LowByte-$18,y
	REP.b #$20
	TYA
	CLC
	ADC.w #$000C
	STA.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	TAY
	SEP.b #$20
	LDA.w !RAM_SMB1_Player_HardModeActiveFlag
	BEQ.b CODE_0493B4
	LDA.b #$2A
	STA.w $16FA,y
CODE_0493B4:
	LDA.b #$06
	STA.w !RAM_SMB1_Global_StripeImageToUpload
	REP.b #$30
	STZ.w $0ECB
	STZ.w $1310
	STZ.w $1312
	LDY.w $1A00
	LDA.w #$C709
	STA.w $1A02,y
	LDA.w #$12C0
	STA.w $1A04,y
	LDA.w #$30A2
	STA.w $1A06,y
	LDA.w #$D809
	STA.w $1A08,y
	LDA.w #$12C0
	STA.w $1A0A,y
	LDA.w #$70A2
	STA.w $1A0C,y
	LDA.w #$A809
	STA.w $1A0E,y
	LDA.w #$1E40
	STA.w $1A10,y
	LDA.w #$3078
	STA.w $1A12,y
	LDA.w #$080B
	STA.w $1A14,y
	LDA.w #$1E40
	STA.w $1A16,y
	LDA.w #$B078
	STA.w $1A18,y
	TYA
	CLC
	ADC.w #$0018
	TAY
	LDX.w #$0000
CODE_049418:
	LDA.w SMB1_LevelPreviewStripeImages_FillInSkyBGTiles,x
	STA.w $1A02,y
	INX
	INX
	INY
	INY
	INC
	BNE.b CODE_049418
	DEY
	DEY
	LDA.w !RAM_SMB1_Level_LevelPreviewImageToUse
	DEC
	AND.w #$00FF
	ASL
	TAX
	LDA.w DATA_04927E,x
	TAX
CODE_049434:
	LDA.w SMB1_LevelPreviewStripeImages_Main,x
	STA.w $1A02,y
	INX
	INX
	INY
	INY
	INC
	BNE.b CODE_049434
	LDA.w $0E22
	AND.w #$00FF
	CMP.w #$0011
	BNE.b CODE_04945E
	DEY
	DEY
	LDX.w #$0000
CODE_049451:
	LDA.w DATA_04AD6F,x
	STA.w $1A02,y
	INX
	INX
	INY
	INY
	INC
	BNE.b CODE_049451
CODE_04945E:
	LDA.w $0E22
	AND.w #$00F0
	BEQ.b CODE_049483
	LDA.w $0E22
	AND.w #$00FF
	CMP.w #$0016
	BEQ.b CODE_049483
	DEY
	DEY
	LDX.w #$0000
CODE_049476:
	LDA.w DATA_04AD9B,x
	STA.w $1A02,y
	INX
	INX
	INY
	INY
	INC
	BNE.b CODE_049476
CODE_049483:
	STY.w $1A00
	SEP.b #$30
	JSR.w CODE_0495E2
	DEC.w $073C
	LDA.b #$01
	STA.w !RAM_SMB1_Global_UpdateEntirePaletteFlag
	STZ.w SMB1_PaletteMirror[$00].LowByte
	STZ.w SMB1_PaletteMirror[$00].HighByte
	LDA.w !RAM_SMB1_Player_CurrentPowerUp
	STA.b !RAM_SMB1_Global_ScratchRAMEB
	LDA.b #$01
	STA.w !RAM_SMB1_Player_CurrentPowerUp
	LDA.w $0E22
	AND.b #$F0
	BEQ.b CODE_0494AC
	LDA.b #$04
CODE_0494AC:
	STA.w $0744
	LDA.w $0E22
	CMP.b #$02
	BNE.b CODE_0494BB
	LDA.b #$03
	STA.w $0744
CODE_0494BB:
	JSL.l CODE_049A88
	DEC.w !RAM_SMB1_Global_UpdateEntirePaletteFlag
	LDA.b !RAM_SMB1_Global_ScratchRAMEB
	STA.w !RAM_SMB1_Player_CurrentPowerUp
	STZ.w $0E22
	LDA.b #$17
	STA.w !RAM_SMB1_Global_MainScreenLayersMirror
	LDA.b #$06
	STA.w !RAM_SMB1_Global_StripeImageToUpload
	STZ.w $0E20
	STZ.w $0EDE
	STZ.w !RAM_SMB1_Global_CurrentLayer2YPosLo
	STZ.w !RAM_SMB1_Global_CurrentLayer2YPosHi
	STZ.w !REGISTER_BG2VertScrollOffset
	STZ.w !REGISTER_BG2VertScrollOffset
	PLY
	PLX
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0494EA:
	LDA.b $9B
	BEQ.b CODE_049513
	STZ.b $9B
	LDA.b $9C
	STA.w $071C
	STA.w !RAM_SMB1_Global_CurrentLayer1XPosLo
	LDA.b $9D
	STA.w $071A
	REP.b #$20
	LDA.b $9C
	LSR
	STA.w !RAM_SMB1_Global_CurrentLayer2XPosLo
	LSR
	STA.w !RAM_SMB1_Global_CurrentLayer3XPosLo
	STA.w $0ED7
	SEP.b #$20
	LDA.w !RAM_SMB1_Level_CurrentLevelType					;\ Optimization: Junk
	BNE.b CODE_049513							;/
CODE_049513:
	LDA.w !RAM_SMB1_Global_CurrentLayer2XPosHi
	AND.b #$01
	STA.w $0EF6
	STZ.w $0EFC
	STZ.w $0EF8
	JSL.l CODE_058000
	JSR.w CODE_049B96
	JSR.w CODE_049BBC
	JSR.w CODE_049BBC
	JSR.w CODE_049BBC
	JSR.w CODE_049BBC
	JSR.w CODE_049BBC
	JSR.w CODE_049BBC
	LDA.b $BA
	CMP.b #$03
	BEQ.b CODE_049563
	JSR.w CODE_049BBC
	JSR.w CODE_049BBC
	JSR.w CODE_049BBC
	JSR.w CODE_049BBC
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	JSR.w CODE_049BBC
	JSR.w CODE_049BBC
	JSR.w CODE_049BBC
	JSR.w CODE_049BBC
	JSR.w CODE_049BBC
	JSR.w CODE_049BBC
	JSR.w CODE_049BBC
	JSR.w CODE_049BBC
endif
	LDA.w $0ED1
	BEQ.b CODE_049563
	JSR.w CODE_049BBC
	JSR.w CODE_049BBC
	JSR.w CODE_049BBC
	JSR.w CODE_049BBC
	JSR.w CODE_049BBC
	JSR.w CODE_049BBC
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	JSR.w CODE_049BBC
	JSR.w CODE_049BBC
	JSR.w CODE_049BBC
	JSR.w CODE_049BBC
	JSR.w CODE_049BBC
	JSR.w CODE_049BBC
	JSR.w CODE_049BBC
	JSR.w CODE_049BBC
endif
CODE_049563:
	RTS

;--------------------------------------------------------------------

DATA_049564:
	db $F8 : dw $7F2000
	db $F8 : dw $7F20F0
	db $00

CODE_04956B:
	PHB
	PHK
	PLB
	JSR.w CODE_0494EA
	STZ.w !RAM_SMB1_Global_CurrentLayer2YPosLo
	STZ.w !RAM_SMB1_Global_CurrentLayer2YPosHi
	LDA.b !RAM_SMB1_Level_CurrentLevelType
	BEQ.b CODE_049594
	CMP.b #$01
	BNE.b CODE_04958B
	LDA.w $00DB
	CMP.b #$0A
	BEQ.b CODE_04958B
	LDA.b #$F8
	STA.w !RAM_SMB1_Global_CurrentLayer2YPosLo
CODE_04958B:
	LDA.b #$06
	STA.w !RAM_SMB1_Global_ColorMathInitialSettingsMirror
	LDX.b #$11
	BRA.b CODE_0495C0

CODE_049594:
	REP.b #$20
	LDA.w #(!REGISTER_BG2HorizScrollOffset&$0000FF<<8)+$42
	STA.w HDMA[$02].Parameters
	LDA.w #DATA_049564
	STA.w HDMA[$02].SourceLo
	LDX.b #DATA_049564>>16
	STX.w HDMA[$02].SourceBank
	LDY.b #$7F2000>>16
	STY.w HDMA[$02].IndirectSourceBank
	SEP.b #$20
	STZ.w $0EEC
	STZ.w $0EF3
	LDA.w !RAM_SMB1_Global_HDMAEnableMirror
	ORA.b #$04
	STA.w !RAM_SMB1_Global_HDMAEnableMirror
	LDA.b #$00
	LDX.b #$17
CODE_0495C0:
	STX.w !RAM_SMB1_Global_MainScreenLayersMirror
	STA.w !RAM_SMB1_Global_SubScreenLayersMirror
	STZ.w $0ED9
	LDA.b #$1F
	STA.w !RAM_SMB1_Global_ScanlineToTriggerIRQ
	LDA.w $0ED1
	BEQ.b CODE_0495DD
	LDA.b #$AF
	STA.w !RAM_SMB1_Global_ScanlineToTriggerIRQ
	LDA.b #$02
	STA.w $0EDE
CODE_0495DD:
	JSR.w CODE_0495E2
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0495E2:
	LDA.w $0E65
	BEQ.b CODE_0495EE
	STA.b $DB
	STZ.w $0E65
	BRA.b CODE_04960A

CODE_0495EE:
	LDA.b $DB
	CMP.b #$0C
	BNE.b CODE_04960A
	STA.w $0E65
	LDA.w !RAM_SMB1_Player_CurrentWorld
	BEQ.b CODE_049606
	CMP.b #$03
	BEQ.b CODE_049606
	LDA.b #$01
	STA.b $DB
	BRA.b CODE_04960A

CODE_049606:
	LDA.b #$19
	STA.b $DB
CODE_04960A:
	REP.b #$30
	LDA.b $DB
	AND.w #$00FF
	ASL
	ASL
	ASL
	ASL
	TAY
	STY.b $06
	STZ.b $02
CODE_04961A:
	LDY.b $06
	LDA.w SMB1_LevelPaletteIndexes_Main,y
	AND.w #$00FF
	INY
	STY.b $06
	ASL
	TAX
	LDA.w DATA_04AE3F,x
	TAY
	LDX.b $02
	LDA.w #$0007
	STA.b $04
CODE_049632:
	LDA.w DATA_04AEC3,y
	STA.w SMB1_PaletteMirror[$00].LowByte,x
	LDA.w DATA_04AEC3+$10,y
	STA.w SMB1_PaletteMirror[$08].LowByte,x
	INX
	INX
	INY
	INY
	DEC.b $04
	BPL.b CODE_049632
	TXA
	CLC
	ADC.w #$0010
	STA.b $02
	CMP.w #$01E0
	BNE.b CODE_04961A
	LDA.w $02F8
	AND.w #$00FF
	BEQ.b CODE_049699
	LDA.w !RAM_SMB1_Player_CurrentCharacter
	AND.w #$00FF
	BEQ.b CODE_049699
	LDY.w #$0000
	LDX.w #$00E0
CODE_049668:
	LDA.w DATA_049679,y
	STA.w SMB1_PaletteMirror[$00].LowByte,x
	INX
	INX
	INY
	INY
	CPY.w #$0020
	BNE.b CODE_049668
	BRA.b CODE_049699

DATA_049679:
	dw $772F,$7FFF,$14A5,$57F0,$0340,$0200,$46BF,$365D
	dw $25BB,$04EF,$0D73,$4F7F,$7F0F,$4E06,$001E,$0012

CODE_049699:
	LDA.b $42
	LSR
	LSR
	STA.w !RAM_SMB1_Global_CurrentLayer3XPosLo
	AND.w #$FF00
	XBA
	STA.b !RAM_SMB1_Global_ScratchRAMF3
	LDA.w !RAM_SMB1_Player_CurrentWorld
	AND.w #$00FF
	ASL
	CMP.w #$000C
	BCC.b CODE_0496B5
	LDA.w #$0000
CODE_0496B5:
	CLC
	ADC.b !RAM_SMB1_Global_ScratchRAMF3
	STA.b !RAM_SMB1_Global_ScratchRAMF3
	STZ.w $0ED9
CODE_0496BD:
	LDA.b !RAM_SMB1_Global_ScratchRAMF3
	BEQ.b CODE_0496CF
	LDA.w $0ED9
	CLC
	ADC.w #$00E0
	STA.w $0ED9
	DEC.b !RAM_SMB1_Global_ScratchRAMF3
	BRA.b CODE_0496BD

CODE_0496CF:
	LDA.w !RAM_SMB1_Global_CurrentLayer3XPosLo
	AND.w #$00F0
	LSR
	LSR
	LSR
	LSR
	CLC
	ADC.w $0ED9
	STA.w $0ED9
	CMP.w #$0A80
	BCC.b CODE_0496E8
	STZ.w $0ED9
CODE_0496E8:
	SEP.b #$30
	JSR.w CODE_04973C
	LDA.w !RAM_SMB1_Global_EnableLayer3BGFlag
	BEQ.b CODE_04971B
	LDA.w !RAM_SMB1_Global_CurrentLayer3XPosHi
	STA.b !RAM_SMB1_Global_ScratchRAMF3
	LDA.w !RAM_SMB1_Global_CurrentLayer3XPosLo
	STA.b !RAM_SMB1_Global_ScratchRAMF4
	JSR.w CODE_048C85
	LDA.b #$13
	STA.b !RAM_SMB1_Global_ScratchRAMF5
CODE_049703:
	JSL.l CODE_048B49
	LDA.b !RAM_SMB1_Global_ScratchRAMF4
	CMP.b #$A0
	BCC.b CODE_049717
	LDA.b !RAM_SMB1_Global_ScratchRAMF3
	EOR.b #$04
	STA.b !RAM_SMB1_Global_ScratchRAMF3
	LDA.b #$80
	STA.b !RAM_SMB1_Global_ScratchRAMF4
CODE_049717:
	DEC.b !RAM_SMB1_Global_ScratchRAMF5
	BNE.b CODE_049703
CODE_04971B:
	LDA.b #$01
	STA.w !RAM_SMB1_Global_UpdateEntirePaletteFlag
	INC.w $073C
	RTS

;--------------------------------------------------------------------

CODE_049724:
	LDA.w #DATA_04B623>>16
	STA.b $04
	LDA.w #$0010
	STA.b $00
CODE_04972E:
	LDA.b [$02],y
	STA.w SMB1_PaletteMirror[$00].LowByte,x
	INY
	INY
	INX
	INX
	DEC.b $00
	BNE.b CODE_04972E
	RTS

;--------------------------------------------------------------------

CODE_04973C:
	PHB
	LDA.b #$7F3000>>16
	PHA
	PLB
	LDX.b #$00
CODE_049743:
	STZ.w $7F3000,x
	STZ.w $7F3100,x
	STZ.w $7F3200,x
	STZ.w $7F3300,x
	STZ.w $7F3400,x
	STZ.w $7F3500,x
	STZ.w $7F3600,x
	STZ.w $7F3700,x
	STZ.w $7F3800,x
	STZ.w $7F3900,x
	STZ.w $7F3A00,x
	DEX
	BNE.b CODE_049743
	PLB
	PHB
	PHK
	PLB
	LDA.b #$7F3000>>16
	STA.b !RAM_SMB1_Global_ScratchRAMF5
	STZ.b !RAM_SMB1_Global_ScratchRAMF6
	REP.b #$30
	LDA.w #$7F3000
	STA.b !RAM_SMB1_Global_ScratchRAMF3
	LDY.w #$0000
	STZ.b !RAM_SMB1_Global_ScratchRAMF8
CODE_04977D:
	LDX.b !RAM_SMB1_Global_ScratchRAMF8
	LDA.w DATA_04B683,x
	CMP.w #$FFFF
	BEQ.b CODE_0497C9
	BPL.b CODE_049793
	PHA
	LDA.b !RAM_SMB1_Global_ScratchRAMF3
	CLC
	ADC.w #$00E0
	STA.b !RAM_SMB1_Global_ScratchRAMF3
	PLA
CODE_049793:
	PHA
	AND.w #$00FF
	TAY
	PLA
	ASL
	ASL
	LDA.w #$0000
	ROL
	STA.b !RAM_SMB1_Global_ScratchRAMF6
	SEP.b #$20
	INX
	LDA.w DATA_04B683,x
	AND.b #$3F
	STA.b !RAM_SMB1_Global_ScratchRAMF7
CODE_0497AB:
	LDA.b !RAM_SMB1_Global_ScratchRAMF7
	STA.b [!RAM_SMB1_Global_ScratchRAMF3],y
	LDA.b !RAM_SMB1_Global_ScratchRAMF6
	BEQ.b CODE_0497C1
	TYA
	AND.b #$F0
	CMP.b #$D0
	BEQ.b CODE_0497C1
	TYA
	CLC
	ADC.b #$10
	TAY
	BRA.b CODE_0497AB

CODE_0497C1:
	REP.b #$20
	INC.b !RAM_SMB1_Global_ScratchRAMF8
	INC.b !RAM_SMB1_Global_ScratchRAMF8
	BRA.b CODE_04977D

CODE_0497C9:
	SEP.b #$30
	PLB
	RTS

;--------------------------------------------------------------------

SMB1_LevelPaletteIndexes:
.Main:
;$0497CD
	db $00,$01,$02,$03,$04,$10,$11,$12,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$10,$11,$12,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$1B,$03,$04,$39,$11,$12,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$36,$06,$37,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$05,$06,$2E,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$36,$06,$37,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$35,$41,$04,$36,$06,$37,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$05,$31,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$05,$06,$38,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$3A,$06,$3B,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$05,$06,$2B,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$34,$40,$04,$3D,$06,$2D,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$19,$06,$1A,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$26,$03,$28,$05,$29,$2A,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$36,$06,$37,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$36,$06,$37,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$26,$27,$28,$05,$29,$2A,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$34,$40,$04,$3D,$06,$2D,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$05,$06,$3C,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$35,$41,$04,$3D,$06,$2D,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$19,$06,$1A,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$35,$41,$04,$36,$06,$37,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$13,$14,$04,$15,$06,$16,$08,$17,$0A,$0B,$0C,$18,$0E,$0F
	db $00,$01,$13,$14,$04,$15,$06,$16,$08,$17,$0A,$0B,$0C,$18,$0E,$0F
	db $00,$01,$13,$14,$04,$19,$06,$1A,$08,$17,$0A,$0B,$0C,$18,$0E,$0F
	db $00,$01,$1B,$1C,$04,$1D,$1E,$1F,$08,$20,$0A,$0B,$0C,$21,$0E,$0F
	db $00,$01,$1B,$1C,$04,$1D,$1E,$1F,$08,$20,$0A,$0B,$0C,$21,$0E,$0F
	db $00,$01,$1B,$1C,$04,$1D,$1E,$1F,$08,$20,$0A,$0B,$0C,$21,$0E,$0F
	db $00,$01,$1B,$1C,$04,$1D,$1E,$1F,$08,$20,$0A,$0B,$0C,$21,$0E,$0F
	db $00,$01,$1B,$1C,$04,$1D,$1E,$1F,$08,$20,$0A,$0B,$0C,$21,$0E,$0F
	db $00,$01,$1B,$1C,$04,$2F,$1E,$30,$08,$20,$0A,$0B,$0C,$21,$0E,$0F

;--------------------------------------------------------------------

DATA_0499ED:						; Note: Back area color palettes?
	dw $7FF8,$7FF8,$0000,$0000,$3908,$7FF8,$3908,$3908

DATA_0499FD:					; Note: Player palettes
	dw $0000,$7FFF,$0C63,$0155,$1A1C,$1B3E,$2D9C,$3ABF,$0000,$152F,$0014,$0C19,$1C9F,$762E,$5D68,$44E6
	dw $0000,$7FFF,$0C63,$0155,$1A1C,$1B3E,$2D9C,$3ABF,$0000,$152F,$1E60,$3304,$4388,$7655,$7190,$58CA
	dw $0000,$7FFF,$0C63,$0155,$1A1C,$1B3E,$2D9C,$3ABF,$0000,$152F,$3ED9,$4F5D,$639F,$0D9F,$001D,$0015
	dw $0000,$7FFF,$0C63,$0155,$1A1C,$1B3E,$2D9C,$3ABF,$0000,$152F,$3ED9,$4F5D,$639F,$0352,$02AD,$0208

CODE_049A7D:
	LDA.w $0E22
	BEQ.b CODE_049A85
	JMP.w CODE_049B34

CODE_049A85:
	INC.w $073C
CODE_049A88:
	PHB
	PHK
	PLB
	PHX
	LDA.w $0744
	BNE.b CODE_049A93
	LDA.b $BA
CODE_049A93:
	REP.b #$30
	AND.w #$00FF
	ASL
	TAY
	LDA.w $0743
	AND.w #$00FF
	BEQ.b CODE_049AB7
	LDA.w $0744
	AND.w #$0004
	BNE.b CODE_049AB7
	LDA.w !RAM_SMB1_Player_CurrentLifeCount
	AND.w #$0080
	BNE.b CODE_049AB7
	LDA.w #$522A
	BRA.b CODE_049ABA

CODE_049AB7:
	LDA.w DATA_0499ED,y
CODE_049ABA:
	STA.w SMB1_PaletteMirror[$00].LowByte
	AND.w #$001F
	CLC
	ADC.w #$0020
	STA.w !RAM_SMB1_Global_FixedColorData1Mirror
	LDA.w SMB1_PaletteMirror[$00].LowByte
	AND.w #$03E0
	ASL
	ASL
	ASL
	XBA
	CLC
	ADC.w #$0040
	STA.w !RAM_SMB1_Global_FixedColorData2Mirror
	LDA.w SMB1_PaletteMirror[$00].LowByte
	AND.w #$7C00
	LSR
	LSR
	XBA
	CLC
	ADC.w #$0080
	STA.w !RAM_SMB1_Global_FixedColorData3Mirror
	STZ.w SMB1_PaletteMirror[$00].LowByte
	BRA.b CODE_049AF9

CODE_049AED:
	LDA.w #$00E0
	STA.w !RAM_SMB1_Global_FixedColorData1Mirror
	STA.w !RAM_SMB1_Global_FixedColorData2Mirror
	STA.w !RAM_SMB1_Global_FixedColorData3Mirror
CODE_049AF9:
	SEP.b #$30
	LDA.w !RAM_SMB1_Player_DisableAutoPaletteUpdate
	BNE.b CODE_049B32
	LDY.b #$00
	LDA.w !RAM_SMB1_Player_CurrentCharacter
	BEQ.b CODE_049B09
	LDY.b #$20
CODE_049B09:
	LDA.w !RAM_SMB1_Player_CurrentPowerUp
	CMP.b #$02
	BNE.b CODE_049B15
	TYA
	CLC
	ADC.b #$40
	TAY
CODE_049B15:
	REP.b #$20
	LDX.b #$00
CODE_049B19:
	LDA.w DATA_0499FD,y
	STA.w SMB1_PaletteMirror[$F0].LowByte,x
	LDA.w DATA_0499FD+$10,y
	STA.w SMB1_PaletteMirror[$F8].LowByte,x
	INX
	INX
	INY
	INY
	CPX.b #$10
	BNE.b CODE_049B19
	SEP.b #$20
	INC.w !RAM_SMB1_Global_UpdateEntirePaletteFlag
CODE_049B32:
	PLX
	PLB
CODE_049B34:
	RTL

;--------------------------------------------------------------------

CODE_049B35:
	PHB
	PHK
	PLB
	PHX
	PHY
	PHA
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDA.b #$10
else
	LDA.b #$20
endif
	STA.b $00
	LDA.b $BA
	CMP.b #$03
	BNE.b CODE_049B47
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDA.b #$40
	STA.b $00
else
	ASL.b $00
endif
CODE_049B47:
	LDA.w !RAM_SMB1_Global_CurrentLayer2XPosLo
	CLC
	ADC.b $00
	AND.b #$F0
	LSR
	LSR
	STA.w $0EF7
	LSR
	STA.b $00
	LDA.b $00
	BNE.b CODE_049B6E
	LDA.w $0EF6
	BEQ.b CODE_049B67
	STZ.w $0EF6
	LDA.b #$14
	BRA.b CODE_049B7B

CODE_049B67:
	LDA.b #$10
	STA.w $0EF6
	BRA.b CODE_049B7B

CODE_049B6E:
	LDA.w !RAM_SMB1_Global_CurrentLayer2XPosHi
	AND.b #$01
	BEQ.b CODE_049B79
	LDA.b #$10
	BRA.b CODE_049B7B

CODE_049B79:
	LDA.b #$14
CODE_049B7B:
	STA.b $01
	LDA.w !RAM_SMB1_Global_CurrentLayer2XPosHi
	AND.b #$0F
	LDX.b $00
	BNE.b CODE_049B87
	INC
CODE_049B87:
	INC
	ASL
	ASL
	ASL
	STA.w $0EF8
	JSR.w CODE_049BBC
	PLA
	PLY
	PLX
	PLB
	RTL

;--------------------------------------------------------------------

CODE_049B96:
	LDA.w !RAM_SMB1_Global_CurrentLayer2XPosLo
	AND.b #$F0
	LSR
	LSR
	STA.w $0EF7
	LSR
	STA.b $00
	LDA.w !RAM_SMB1_Global_CurrentLayer2XPosHi
	ASL
	ASL
	ASL
	STA.w $0EF8
	LDA.w !RAM_SMB1_Global_CurrentLayer2XPosHi
	AND.b #$01
	BEQ.b CODE_049BB7
	LDA.b #$14
	BRA.b CODE_049BB9

CODE_049BB7:
	LDA.b #$10
CODE_049BB9:
	STA.b $01
	RTS

;--------------------------------------------------------------------

CODE_049BBC:
	REP.b #$30
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDA.w #$0002
else
	LDA.w #$0004
endif
	STA.w $0EFA
	LDA.b $BA
	AND.w #$00FF
	CMP.w #$0003
	BNE.b CODE_049BD1
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	LDA.w #$0008
	STA.w $0EFA
else
	ASL.w $0EFA
endif
CODE_049BD1:
	LDA.l $7F0000
	TAY
CODE_049BD6:
	LDA.b $00
	AND.w #$0020
	BEQ.b CODE_049BE8
	LDA.b $00
	CLC
	ADC.w #$0400
	AND.w #$1400
	STA.b $00
CODE_049BE8:
	TYX
	LDA.b $00
	SEC
	SBC.w #$0800
	STA.l $7F0002,x
	LDA.w #$0020
	STA.b $02
	TXY
	LDA.w $0EF7
	AND.w #$0040
	BEQ.b CODE_049C0E
	LDA.w #$0800
	CLC
	ADC.w $0EF7
	AND.w #$FF00
	STA.w $0EF7
CODE_049C0E:
	LDX.w $0EF7
	STX.b $04
CODE_049C13:
	LDA.l !RAM_SMB1_Global_Layer2Map16Table,x
	TYX
	STA.l $7F0004,x
	INY
	INY
	LDA.b $04
	CLC
	ADC.w #$0040
	STA.b $04
	TAX
	DEC.b $02
	BPL.b CODE_049C13
	TYX
	LDA.w #$0024
	STA.l $7F0000,x
	INC.w $0EF7
	INC.w $0EF7
	INC.b $00
	DEC.w $0EFA
	BNE.b CODE_049BD6
	TYA
	STA.l $7F0000
	TAX
	LDA.w #$FFFF
	STA.l $7F0002,x
	SEP.b #$30
	LDA.b #$01
	STA.w $0EF9
	RTS

;--------------------------------------------------------------------

; Note: Stripe images, these ones seem related to the game over/time up screens

SMB1_GameOverScreenStripeImage:
.Mario:
;$049C55
	db $0A,$8D,$00,$0B
	db $24,$00,$24,$00,$45,$1E,$46,$1E,$47,$1E,$24,$00

	db $0A,$AD,$00,$0B
	db $4A,$1E,$4B,$1E,$48,$1E,$49,$1E,$59,$1E,$24,$00

	db $0A,$CD,$00,$0B
	db $5A,$1E,$5B,$1E,$69,$1E,$6A,$1E,$6F,$1E,$24,$00

	db $0A,$ED,$00,$0B
	db $24,$00,$6B,$1E,$4C,$1E,$4D,$1E,$4E,$1E,$4F,$1E

	db $0B,$0D,$00,$0B
	db $24,$00,$24,$00,$5C,$1E,$5D,$1E,$5E,$1E,$5F,$1E

	db $0B,$2D,$00,$0B
	db $24,$00,$7A,$1E,$6C,$1E,$6D,$1E,$6E,$1E,$24,$00

	db $0B,$4D,$00,$0B
	db $24,$00,$7B,$1E,$7C,$1E,$7D,$1E,$7E,$1E,$24,$00

	db $FF,$FF

.Luigi:
	db $0A,$4D,$00,$0B
	db $24,$00,$80,$16,$81,$16,$82,$16,$24,$00,$24,$00

	db $0A,$6D,$00,$0B
	db $24,$00,$83,$16,$84,$16,$85,$16,$24,$00,$24,$00

	db $0A,$8D,$00,$0B
	db $24,$00,$86,$16,$87,$16,$88,$16,$24,$00,$24,$00

	db $0A,$AD,$00,$0B
	db $24,$00,$89,$16,$8A,$16,$8B,$16,$8C,$16,$24,$00

	db $0A,$CD,$00,$0B
	db $24,$00,$8D,$16,$8E,$16,$8F,$16,$90,$16,$24,$00

	db $0A,$ED,$00,$0B
	db $91,$16,$92,$16,$93,$16,$94,$16,$95,$16,$24,$00

	db $0B,$0D,$00,$0B
	db $96,$16,$97,$16,$98,$16,$99,$16,$24,$00,$24,$00

	db $0B,$2D,$00,$0B
	db $24,$00,$9A,$16,$9B,$16,$9C,$16,$24,$00,$24,$00

	db $0B,$4D,$00,$0B
	db $24,$00,$9D,$16,$9E,$16,$9F,$16,$A0,$16,$24,$00

	db $FF,$FF

.TitleLogo:
	db $0A,$F3,$00,$09
	db $40,$1A,$41,$1A,$42,$1A,$43,$1A,$44,$1A

	db $0B,$13,$00,$11
	db $50,$1A,$51,$1A,$52,$1A,$53,$1A,$54,$1A,$55,$1A,$56,$1A,$57,$1A
	db $58,$1A

	db $0B,$33,$00,$11
	db $60,$1A,$61,$1A,$62,$1A,$63,$1A,$64,$1A,$65,$1A,$66,$1A,$67,$1A
	db $68,$1A

	db $0B,$53,$00,$13
	db $70,$1A,$71,$1A,$72,$1A,$73,$1A,$74,$1A,$75,$1A,$76,$1A,$77,$1A
	db $78,$1A,$79,$1A

	db $FF,$FF

;--------------------------------------------------------------------

SMB1_LevelPreviewStripeImages:
.FillInSkyBGTiles:
;$049DAD
	db $01,$C8,$40,$1E
	db $24,$00

	db $01,$E8,$40,$1E
	db $24,$00

	db $02,$08,$40,$1E
	db $24,$00

	db $02,$28,$40,$1E
	db $24,$00

	db $02,$48,$40,$1E
	db $24,$00

	db $02,$68,$40,$1E
	db $24,$00

	db $02,$88,$40,$1E
	db $24,$00

	db $02,$A8,$40,$1E
	db $24,$00

	db $02,$C8,$40,$1E
	db $24,$00

	db $02,$E8,$40,$1E
	db $24,$00

	db $FF,$FF

.Main:
.Underwater:
;$049DEB
	db $01,$E8,$00,$1F
	db $EC,$18,$ED,$18,$EE,$18,$EF,$18,$EC,$18,$ED,$18,$EE,$18,$EF,$18
	db $EC,$18,$ED,$18,$EE,$18,$EF,$18,$EC,$18,$ED,$18,$EE,$18,$EF,$18

	db $02,$4C,$80,$0B
	db $4A,$1D,$5A,$1D,$4A,$1D,$5A,$1D,$82,$10,$84,$10

	db $02,$4D,$80,$0B
	db $4B,$1D,$5B,$1D,$4B,$1D,$5B,$1D,$83,$10,$85,$10

	db $0A,$08,$40,$1E
	db $00,$19

	db $0A,$28,$40,$1E
	db $00,$19

	db $0A,$48,$40,$1E
	db $01,$19

	db $0A,$68,$40,$1E
	db $01,$19

	db $0A,$88,$40,$1E
	db $01,$19

	db $0A,$A8,$40,$1E
	db $01,$19

	db $0A,$C8,$40,$1E
	db $01,$19

	db $0A,$E8,$40,$1E
	db $01,$19

	db $FF,$FF

.DottedHillsWithNoDecorations:
	db $09,$CA,$00,$09
	db $DF,$1D,$C3,$1D,$C0,$1D,$C1,$1D,$CA,$1D

	db $09,$EA,$00,$0B
	db $DC,$1D,$D3,$1D,$D0,$1D,$D1,$1D,$DA,$1D,$DB,$1D

	db $0A,$09,$00,$0D
	db $DD,$1D,$E2,$1D,$E3,$1D,$E0,$1D,$E1,$1D,$E2,$1D,$F8,$1D

	db $0A,$29,$00,$0D
	db $DE,$1D,$F2,$1D,$F3,$1D,$F0,$1D,$F1,$1D,$F2,$1D,$F3,$1D

	db $0A,$49,$00,$1B
	db $E9,$1D,$C6,$1D,$C7,$1D,$C4,$1D,$C5,$1D,$C6,$1D,$C7,$1D,$E8,$1D
	db $24,$00,$24,$00,$E9,$1D,$EA,$1D,$EB,$1D,$E8,$1D

	db $0A,$69,$00,$1B
	db $F9,$1D,$D6,$1D,$D7,$1D,$D4,$1D,$D5,$1D,$D6,$1D,$D7,$1D,$F8,$1D
	db $24,$00,$24,$00,$F9,$1D,$FA,$1D,$FB,$1D,$F8,$1D

	db $0A,$89,$00,$1B
	db $E5,$1D,$E6,$1D,$E7,$1D,$E4,$1D,$E5,$1D,$E6,$1D,$E7,$1D,$E4,$1D
	db $24,$00,$24,$00,$E5,$1D,$E6,$1D,$E7,$1D,$E4,$1D

	db $0A,$A9,$00,$1B
	db $F5,$1D,$F6,$1D,$F7,$1D,$F4,$1D,$F5,$1D,$F6,$1D,$F7,$1D,$F4,$1D
	db $24,$00,$24,$00,$F5,$1D,$F6,$1D,$F7,$1D,$F4,$1D

	db $02,$C8,$00,$1F
	db $08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A
	db $08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A

	db $02,$E8,$00,$1F
	db $18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A
	db $18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A

	db $FF,$FF

.DottedHillsWithDecorations:
	db $09,$CA,$00,$09
	db $DF,$1D,$C3,$1D,$C0,$1D,$C1,$1D,$CA,$1D

	db $09,$EA,$00,$0B
	db $DC,$1D,$D3,$1D,$D0,$1D,$D1,$1D,$DA,$1D,$DB,$1D

	db $0A,$09,$00,$0D
	db $DD,$1D,$E2,$1D,$E3,$1D,$E0,$1D,$E1,$1D,$E2,$1D,$F8,$1D

	db $0A,$29,$00,$0D
	db $DE,$1D,$F2,$1D,$F3,$1D,$F0,$1D,$F1,$1D,$F2,$1D,$F3,$1D

	db $0A,$49,$00,$1B
	db $E9,$1D,$C6,$1D,$C7,$1D,$C4,$1D,$C5,$1D,$C6,$1D,$C7,$1D,$E8,$1D
	db $24,$00,$24,$00,$E9,$1D,$EA,$1D,$EB,$1D,$E8,$1D

	db $0A,$69,$00,$1B
	db $F9,$1D,$D6,$1D,$D7,$1D,$D4,$1D,$D5,$1D,$D6,$1D,$D7,$1D,$F8,$1D
	db $24,$00,$24,$00,$F9,$1D,$FA,$1D,$FB,$1D,$F8,$1D

	db $0A,$89,$00,$1B
	db $E5,$1D,$E6,$1D,$E7,$1D,$E4,$1D,$E5,$1D,$E6,$1D,$E7,$1D,$E4,$1D
	db $24,$00,$24,$00,$E5,$1D,$E6,$1D,$E7,$1D,$E4,$1D

	db $0A,$A9,$00,$1B
	db $F5,$1D,$F6,$1D,$F7,$1D,$F4,$1D,$F5,$1D,$F6,$1D,$F7,$1D,$F4,$1D
	db $24,$00,$24,$00,$F5,$1D,$F6,$1D,$F7,$1D,$F4,$1D

	db $02,$0A,$80,$0B
	db $B8,$08,$BA,$08,$BA,$08,$BC,$08,$BE,$0C,$BE,$0C

	db $02,$0B,$80,$0B
	db $B9,$08,$BB,$08,$BB,$08,$BD,$08,$BF,$0C,$BF,$0C

	db $02,$92,$00,$07
	db $14,$12,$15,$12,$14,$12,$15,$12

	db $02,$B2,$00,$07
	db $16,$12,$17,$12,$16,$12,$17,$12

	db $02,$C8,$00,$1F
	db $08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A
	db $08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A

	db $02,$E8,$00,$1F
	db $18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A
	db $18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A

	db $FF,$FF

.CastleWall:
	db $09,$C8,$00,$1F
	db $C2,$1D,$C3,$1D,$C0,$1D,$C1,$1D,$C2,$1D,$C3,$1D,$C0,$1D,$C1,$1D
	db $C2,$1D,$C3,$1D,$C0,$1D,$C1,$1D,$C2,$1D,$C3,$1D,$C0,$1D,$C1,$1D

	db $09,$E8,$00,$1F
	db $D2,$1D,$D3,$1D,$D0,$1D,$D1,$1D,$D2,$1D,$D3,$1D,$D0,$1D,$D1,$1D
	db $D2,$1D,$D3,$1D,$D0,$1D,$D1,$1D,$D2,$1D,$D3,$1D,$D0,$1D,$D1,$1D

	db $0A,$08,$00,$1F
	db $E2,$1D,$E1,$1D,$E2,$1D,$E1,$1D,$E2,$1D,$E1,$1D,$E2,$1D,$E1,$1D
	db $E2,$1D,$E1,$1D,$E2,$1D,$E1,$1D,$E2,$1D,$E1,$1D,$E2,$1D,$E1,$1D

	db $0A,$28,$00,$1F
	db $D2,$1D,$D1,$1D,$E4,$1D,$E5,$1D,$D2,$1D,$82,$1D,$83,$1D,$84,$1D
	db $85,$1D,$80,$1D,$81,$1D,$D1,$1D,$E4,$1D,$E5,$1D,$D2,$1D,$D1,$1D

	db $0A,$48,$00,$1F
	db $E2,$1D,$E1,$1D,$F4,$1D,$F5,$1D,$E2,$1D,$DC,$1D,$DD,$1D,$DE,$1D
	db $DF,$1D,$90,$1D,$91,$1D,$E1,$1D,$F4,$1D,$F5,$1D,$E2,$1D,$E1,$1D

	db $0A,$68,$00,$1F
	db $D2,$1D,$D1,$1D,$D8,$1D,$E8,$1D,$D2,$1D,$EC,$1D,$ED,$1D,$EE,$1D
	db $EF,$1D,$A0,$1D,$A1,$1D,$D1,$1D,$D8,$1D,$E8,$1D,$D2,$1D,$D1,$1D

	db $0A,$88,$00,$1F
	db $E2,$1D,$E1,$1D,$E2,$1D,$E1,$1D,$E2,$1D,$FC,$1D,$FD,$1D,$FE,$1D
	db $FF,$1D,$B0,$1D,$B1,$1D,$E1,$1D,$E2,$1D,$E1,$1D,$E2,$1D,$E1,$1D

	db $0A,$A8,$00,$1F
	db $F0,$1D,$F1,$1D,$F2,$1D,$F3,$1D,$F0,$1D,$F1,$1D,$F2,$1D,$F3,$1D
	db $F0,$1D,$F1,$1D,$F2,$1D,$F3,$1D,$F0,$1D,$F1,$1D,$F2,$1D,$F3,$1D

	db $02,$0A,$80,$0B
	db $B8,$08,$BA,$08,$BA,$08,$BC,$08,$BE,$0C,$BE,$0C

	db $02,$0B,$80,$0B
	db $B9,$08,$BB,$08,$BB,$08,$BD,$08,$BF,$0C,$BF,$0C

	db $02,$92,$00,$07
	db $14,$12,$15,$12,$14,$12,$15,$12

	db $02,$B2,$00,$07
	db $16,$12,$17,$12,$16,$12,$17,$12

	db $02,$C8,$00,$1F
	db $08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A
	db $08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A

	db $02,$E8,$00,$1F
	db $18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A
	db $18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A

	db $FF,$FF

.CloudAndSmallHill:
	db $01,$EB,$00,$03
	db $D6,$10,$D7,$10

	db $02,$0A,$00,$07
	db $D8,$10,$D9,$10,$DA,$10,$DB,$10

	db $02,$2A,$00,$07
	db $DC,$10,$DD,$10,$DE,$10,$DF,$10

	db $02,$53,$00,$07
	db $01,$15,$02,$15,$03,$15,$04,$15

	db $02,$72,$00,$0B

	db $10,$15,$11,$15,$0A,$15,$05,$15,$14,$15,$15,$15

	db $02,$91,$00,$0D
	db $06,$15,$16,$15,$0A,$15,$12,$15,$0A,$15,$0A,$15,$0D,$15

	db $02,$B0,$00,$0F
	db $06,$15,$16,$15,$0A,$15,$0A,$15,$12,$95,$19,$15,$0A,$15,$1D,$15

	db $02,$C8,$00,$1F
	db $08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A
	db $08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A

	db $02,$E8,$00,$1F
	db $18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A
	db $18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A

	db $FF,$FF

.Underground:
	db $01,$C8,$40,$1E
	db $47,$0C

	db $01,$CD,$00,$07
	db $68,$08,$69,$08,$97,$08,$6A,$08

	db $01,$E8,$80,$0D
	db $45,$0C,$47,$0C,$45,$0C,$47,$0C,$45,$0C,$47,$0C,$45,$0C

	db $01,$E9,$00,$1D
	db $32,$1D,$33,$1D,$30,$1D,$31,$1D,$64,$88,$65,$88,$66,$88,$67,$88
	db $32,$1D,$33,$1D,$30,$1D,$31,$1D,$32,$1D,$33,$1D,$30,$1D

	db $02,$09,$00,$1D
	db $02,$1D,$03,$1D,$00,$1D,$01,$1D,$60,$88,$61,$88,$62,$88,$63,$88
	db $02,$1D,$03,$1D,$48,$1D,$49,$1D,$4A,$1D,$4B,$1D,$00,$1D

	db $02,$29,$00,$1D
	db $3A,$15,$13,$1D,$10,$1D,$11,$1D,$12,$1D,$13,$1D,$10,$1D,$11,$1D
	db $12,$1D,$13,$1D,$58,$1D,$59,$1D,$5A,$1D,$5B,$1D,$10,$1D

	db $02,$49,$00,$1D
	db $22,$1D,$23,$1D,$20,$1D,$21,$1D,$22,$1D,$23,$1D,$20,$1D,$21,$1D
	db $22,$1D,$23,$1D,$68,$1D,$69,$1D,$6A,$1D,$6B,$1D,$20,$1D

	db $02,$69,$00,$1D
	db $32,$1D,$33,$1D,$1D,$15,$1D,$15,$32,$1D,$33,$1D,$30,$1D,$31,$1D
	db $32,$1D,$33,$1D,$78,$1D,$79,$1D,$7A,$1D,$7B,$1D,$30,$1D

	db $02,$89,$00,$1D
	db $02,$1D,$03,$1D,$28,$15,$29,$15,$02,$1D,$03,$1D,$00,$1D,$01,$1D
	db $02,$1D,$03,$1D,$00,$1D,$01,$1D,$02,$1D,$03,$1D,$00,$1D

	db $02,$A9,$00,$1D
	db $12,$1D,$13,$1D,$10,$1D,$11,$1D,$12,$1D,$13,$1D,$10,$1D,$11,$1D
	db $12,$1D,$13,$1D,$10,$1D,$11,$1D,$12,$1D,$13,$1D,$10,$1D

	db $02,$C8,$00,$1F
	db $08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A
	db $08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A

	db $02,$E8,$00,$1F
	db $18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A
	db $18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A

	db $FF,$FF

.StandardCastle:
	db $01,$C8,$00,$1F
	db $E6,$09,$E7,$09,$E8,$09,$E9,$09,$E6,$09,$E7,$09,$E8,$09,$E9,$09
	db $E6,$09,$E7,$09,$E8,$09,$E9,$09,$E6,$09,$E7,$09,$E8,$09,$E9,$09

	db $01,$E8,$00,$1F
	db $F6,$09,$F7,$09,$F8,$09,$F9,$09,$F6,$09,$F7,$09,$F8,$09,$F9,$09
	db $F6,$09,$F7,$09,$F8,$09,$F9,$09,$F6,$09,$F7,$09,$F8,$09,$F9,$09

	db $0A,$08,$40,$1E
	db $34,$15

	db $0A,$28,$40,$1E
	db $34,$15

	db $0A,$48,$40,$1E
	db $34,$15

	db $0A,$68,$40,$1E
	db $34,$15

	db $0A,$88,$40,$1E
	db $34,$15

	db $0A,$A8,$40,$1E
	db $34,$15

	db $0A,$CB,$40,$18
	db $34,$15

	db $0A,$EB,$40,$0E
	db $34,$15

	db $0A,$0B,$C0,$0E
	db $36,$15

	db $0A,$0C,$C0,$0E
	db $37,$15

	db $0A,$0D,$C0,$0E
	db $28,$15

	db $0A,$13,$C0,$0C
	db $36,$15

	db $0A,$14,$C0,$0C
	db $37,$15

	db $0A,$15,$C0,$0C
	db $28,$15

	db $02,$C8,$00,$1F
	db $CA,$09,$CB,$09,$CA,$09,$C3,$09,$24,$00,$24,$00,$24,$00,$24,$00
	db $C0,$09,$CB,$09,$CA,$09,$C3,$09,$9B,$18,$9C,$18,$9B,$18,$9C,$18

	db $02,$E8,$00,$1F
	db $DA,$09,$DB,$09,$DA,$09,$D3,$09,$E0,$18,$E1,$18,$E0,$18,$E1,$18
	db $D0,$09,$DB,$09,$DA,$09,$D3,$09,$9D,$18,$9E,$18,$9D,$18,$9E,$18

	db $FF,$FF

.FinalCastle:
	db $09,$C8,$40,$1E
	db $34,$15

	db $09,$E8,$40,$1E
	db $34,$15

	db $0A,$08,$40,$1E
	db $34,$15

	db $0A,$28,$40,$1E
	db $34,$15

	db $0A,$48,$40,$1E
	db $34,$15

	db $0A,$68,$40,$1E
	db $34,$15

	db $0A,$88,$40,$1E
	db $34,$15

	db $0A,$A8,$40,$1E
	db $34,$15

	db $0A,$CB,$40,$18
	db $34,$15

	db $0A,$EB,$40,$0E
	db $34,$15

	db $09,$CE,$C0,$09
	db $36,$15

	db $09,$CF,$C0,$09
	db $37,$15

	db $0A,$6E,$00,$03
	db $26,$95,$27,$95

	db $0A,$8D,$00,$07
	db $24,$95,$16,$95,$17,$95,$18,$95

	db $0A,$AD,$00,$07
	db $32,$15,$22,$15,$22,$15,$23,$15

	db $09,$D2,$00,$0B
	db $A8,$1D,$A9,$1D,$8A,$1D,$8B,$1D,$A9,$5D,$AC,$1D

	db $09,$F2,$00,$0B
	db $A8,$1D,$B9,$1D,$B9,$1D,$B9,$1D,$BA,$1D,$AC,$1D

	db $0A,$12,$00,$0B
	db $A8,$1D,$89,$1D,$8A,$1D,$8B,$1D,$89,$5D,$9C,$1D

	db $0A,$32,$00,$0B
	db $A8,$1D,$99,$1D,$9A,$1D,$9B,$1D,$99,$5D,$AC,$1D

	db $0A,$52,$00,$0B
	db $A8,$1D,$A9,$1D,$8A,$1D,$8B,$1D,$A9,$5D,$AC,$1D

	db $0A,$72,$00,$0B
	db $B8,$1D,$B9,$1D,$B9,$1D,$B9,$1D,$B9,$1D,$BA,$1D

	db $09,$E9,$00,$07
	db $B0,$1D,$B1,$1D,$B1,$5D,$B0,$5D

	db $0A,$09,$00,$07
	db $B2,$1D,$E8,$1C,$E9,$1C,$B2,$5D

	db $0A,$29,$00,$07
	db $B3,$1D,$EA,$1C,$EB,$1C,$B3,$5D

	db $0A,$49,$00,$07
	db $34,$1D,$8E,$1D,$8F,$1D,$34,$1D

	db $0A,$C8,$00,$1F
	db $10,$15,$11,$15,$10,$15,$11,$15,$10,$15,$11,$15,$10,$15,$11,$15
	db $10,$15,$11,$15,$10,$15,$11,$15,$10,$15,$11,$15,$10,$15,$11,$15

	db $0A,$E8,$00,$1F
	db $20,$15,$21,$15,$20,$15,$21,$15,$20,$15,$21,$15,$20,$15,$21,$15
	db $20,$15,$21,$15,$20,$15,$21,$15,$20,$15,$21,$15,$20,$15,$21,$15

	db $02,$C8,$00,$1F
	db $CA,$09,$CB,$09,$CA,$09,$C3,$09,$24,$00,$24,$00,$24,$00,$24,$00
	db $C0,$09,$CB,$09,$CA,$09,$C3,$09,$9B,$18,$9C,$18,$9B,$18,$9C,$18

	db $02,$E8,$00,$1F
	db $DA,$09,$DB,$09,$DA,$09,$D3,$09,$E0,$18,$E1,$18,$E0,$18,$E1,$18
	db $D0,$09,$DB,$09,$DA,$09,$D3,$09,$9D,$18,$9E,$18,$9D,$18,$9E,$18

	db $FF,$FF

.MushroomLedges:
	db $02,$08,$00,$0B
	db $6B,$18,$2C,$18,$6C,$18,$6D,$18,$6E,$18,$6F,$18

	db $02,$28,$00,$0B
	db $70,$18,$2D,$18,$71,$18,$72,$18,$73,$18,$74,$18

	db $02,$4A,$00,$03
	db $75,$18,$76,$18

	db $02,$6A,$C0,$09
	db $9F,$18

	db $02,$6B,$C0,$09
	db $9F,$58

	db $02,$50,$00,$0B
	db $6B,$18,$2C,$18,$6C,$18,$6D,$18,$6E,$18,$6F,$18

	db $02,$70,$00,$0B
	db $70,$18,$2D,$18,$71,$18,$72,$18,$73,$18,$74,$18

	db $02,$92,$00,$03
	db $75,$18,$76,$18

	db $02,$B2,$00,$03
	db $9F,$18,$9F,$58

	db $02,$C8,$00,$1F
	db $6B,$18,$2C,$18,$6C,$18,$6D,$18,$6E,$18,$2C,$18,$6C,$18,$6D,$18
	db $6E,$18,$2C,$18,$6C,$18,$6D,$18,$6E,$18,$2C,$18,$6C,$18,$6F,$18

	db $02,$E8,$00,$1F
	db $70,$18,$2D,$18,$71,$18,$72,$18,$73,$18,$2D,$18,$71,$18,$72,$18
	db $73,$18,$2D,$18,$71,$18,$72,$18,$73,$18,$2D,$18,$73,$18,$74,$18

	db $09,$CA,$00,$0B
	db $CA,$1D,$CB,$1D,$CC,$1D,$CD,$1D,$CE,$1D,$CF,$1D

	db $09,$EA,$00,$0B
	db $DA,$1D,$DB,$1D,$DC,$1D,$DD,$1D,$DE,$1D,$DF,$1D

	db $0A,$0C,$80,$0B
	db $F2,$1D,$E2,$1D,$E2,$1D,$E2,$1D,$E2,$1D,$E2,$1D

	db $0A,$0D,$80,$0B
	db $F3,$1D,$E3,$1D,$E3,$1D,$E3,$1D,$E3,$1D,$E3,$1D

	db $09,$F1,$00,$0B
	db $CA,$1D,$CB,$1D,$CC,$1D,$CD,$1D,$CE,$1D,$CF,$1D

	db $0A,$11,$00,$0B
	db $DA,$1D,$DB,$1D,$DC,$1D,$DD,$1D,$DE,$1D,$DF,$1D

	db $0A,$33,$80,$0B
	db $F2,$1D,$E2,$1D,$E2,$1D,$E2,$1D,$E2,$1D,$E2,$1D

	db $0A,$34,$80,$0B
	db $F3,$1D,$E3,$1D,$E3,$1D,$E3,$1D,$E3,$1D,$E3,$1D

	db $FF,$FF

.CloudLedges:									; Note: Unused. SMBLL has a copy of these data that is used however.
;$04A7F9
	db $02,$08,$00,$0B
	db $6B,$18,$2C,$18,$6C,$18,$6D,$18,$6E,$18,$6F,$18

	db $02,$28,$00,$0B
	db $70,$18,$2D,$18,$71,$18,$72,$18,$73,$18,$74,$18

	db $02,$50,$00,$0B
	db $6B,$18,$2C,$18,$6C,$18,$6D,$18,$6E,$18,$6F,$18

	db $02,$70,$00,$0B
	db $70,$18,$2D,$18,$71,$18,$72,$18,$73,$18,$74,$18

	db $02,$C8,$00,$1F
	db $6B,$18,$2C,$18,$6C,$18,$6D,$18,$6E,$18,$2C,$18,$6C,$18,$6D,$18
	db $6E,$18,$2C,$18,$6C,$18,$6D,$18,$6E,$18,$2C,$18,$6C,$18,$6F,$18

	db $02,$E8,$00,$1F
	db $70,$18,$2D,$18,$71,$18,$72,$18,$73,$18,$2D,$18,$71,$18,$72,$18
	db $73,$18,$2D,$18,$71,$18,$72,$18,$73,$18,$2D,$18,$73,$18,$74,$18

	db $09,$CA,$00,$0B
	db $CA,$1D,$CB,$1D,$CC,$1D,$CD,$1D,$CE,$1D,$CF,$1D

	db $09,$EA,$00,$0B
	db $DA,$1D,$DB,$1D,$DC,$1D,$DD,$1D,$DE,$1D,$DF,$1D

	db $0A,$0C,$80,$0B
	db $F2,$1D,$E2,$1D,$E2,$1D,$E2,$1D,$E2,$1D,$E2,$1D

	db $0A,$0D,$80,$0B
	db $F3,$1D,$E3,$1D,$E3,$1D,$E3,$1D,$E3,$1D,$E3,$1D

	db $09,$F1,$00,$0B
	db $CA,$1D,$CB,$1D,$CC,$1D,$CD,$1D,$CE,$1D,$CF,$1D

	db $0A,$11,$00,$0B
	db $DA,$1D,$DB,$1D,$DC,$1D,$DD,$1D,$DE,$1D,$DF,$1D

	db $0A,$33,$80,$0B
	db $F2,$1D,$E2,$1D,$E2,$1D,$E2,$1D,$E2,$1D,$E2,$1D

	db $0A,$34,$80,$0B
	db $F3,$1D,$E3,$1D,$E3,$1D,$E3,$1D,$E3,$1D,$E3,$1D

	db $FF,$FF

.GoombaPillarAndBridge:
	db $02,$C8,$00,$03
	db $AB,$0C,$AD,$0C

	db $02,$E8,$00,$03
	db $AC,$0C,$AE,$0C

	db $02,$CA,$40,$1B
	db $21,$32

	db $02,$AA,$00,$01
	db $81,$08

	db $02,$AB,$40,$19
	db $20,$2A

	db $0A,$0E,$80,$0F
	db $E0,$1D,$F0,$1D,$C3,$1D,$D3,$1D,$E3,$1D,$F3,$1D,$C1,$1D,$E2,$1D

	db $0A,$0F,$80,$0F
	db $E1,$1D,$F0,$5D,$C4,$1D,$D4,$1D,$E4,$1D,$F4,$1D,$D0,$1D,$F2,$1D

	db $0A,$4D,$00,$01
	db $C2,$1D

	db $0A,$50,$00,$01
	db $C5,$1D

	db $0A,$CD,$00,$01
	db $C0,$1D

	db $0A,$D0,$00,$01
	db $D1,$1D

	db $0A,$54,$80,$0B
	db $CA,$15,$F1,$15,$C6,$15,$D6,$15,$E6,$15,$F6,$15

	db $0A,$55,$80,$0B
	db $CB,$15,$F1,$55,$C7,$15,$D7,$15,$E7,$15,$F7,$15

	db $FF,$FF

.NightWithGrassLedges:
	db $02,$09,$00,$13
	db $4B,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10
	db $4D,$10,$50,$10

	db $02,$29,$00,$13
	db $4C,$10,$4E,$10,$4F,$10,$4A,$10,$4F,$10,$4A,$10,$4F,$10,$4A,$10
	db $4E,$10,$51,$10

	db $02,$4D,$80,$07
	db $04,$12,$10,$12,$00,$12,$10,$12

	db $02,$4E,$80,$07
	db $07,$12,$13,$12,$03,$12,$13,$12

	db $02,$C8,$00,$1F
	db $4B,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10
	db $4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$50,$10

	db $02,$E8,$00,$1F
	db $4C,$10,$4E,$10,$4F,$10,$4A,$10,$4F,$10,$4A,$10,$4F,$10,$4A,$10
	db $4F,$10,$4A,$10,$4F,$10,$4A,$10,$4F,$10,$4A,$10,$4E,$10,$51,$10

	db $09,$EA,$00,$01
	db $C0,$1C

	db $09,$F6,$00,$01
	db $C4,$1C

	db $09,$D5,$00,$01
	db $C1,$1C

	db $09,$CF,$00,$01
	db $C6,$1C

	db $0A,$15,$00,$01
	db $C2,$1C

	db $0A,$71,$00,$01
	db $C5,$1C

	db $0A,$36,$00,$01
	db $C5,$1C

	db $0A,$50,$00,$01
	db $C4,$1C

	db $0A,$54,$00,$01
	db $C7,$1C

	db $0A,$77,$00,$01
	db $C3,$1C

	db $0A,$6F,$00,$01
	db $C4,$1C

	db $0A,$93,$00,$01
	db $C2,$1C

	db $0A,$89,$00,$01
	db $C5,$1C

	db $0A,$6B,$00,$01
	db $C1,$1C

	db $0A,$48,$00,$01
	db $C0,$1C

	db $FF,$FF

.UnusedGrassLedges:
;$04AA73
	db $02,$09,$00,$13
	db $4B,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10
	db $4D,$10,$50,$10

	db $02,$29,$00,$13
	db $4C,$10,$4E,$10,$4F,$10,$4A,$10,$4F,$10,$4A,$10,$4F,$10,$4A,$10
	db $4E,$10,$51,$10

	db $02,$4D,$80,$07
	db $04,$12,$10,$12,$00,$12,$10,$12

	db $02,$4E,$80,$07
	db $07,$12,$13,$12,$03,$12,$13,$12

	db $02,$C8,$00,$1F
	db $4B,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10
	db $4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$50,$10

	db $02,$E8,$00,$1F
	db $4C,$10,$4E,$10,$4F,$10,$4A,$10,$4F,$10,$4A,$10,$4F,$10,$4A,$10
	db $4F,$10,$4A,$10,$4F,$10,$4A,$10,$4F,$10,$4A,$10,$4E,$10,$51,$10
	db $FF,$FF

.WaterfallHillsWithGrassLedges:
	db $02,$09,$00,$13
	db $4B,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10
	db $4D,$10,$50,$10

	db $02,$29,$00,$13
	db $4C,$10,$4E,$10,$4F,$10,$4A,$10,$4F,$10,$4A,$10,$4F,$10,$4A,$10
	db $4E,$10,$51,$10

	db $02,$4D,$80,$07
	db $04,$12,$10,$12,$00,$12,$10,$12

	db $02,$4E,$80,$07
	db $07,$12,$13,$12,$03,$12,$13,$12

	db $02,$C8,$00,$1F
	db $4B,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10
	db $4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$50,$10

	db $02,$E8,$00,$1F
	db $4C,$10,$4E,$10,$4F,$10,$4A,$10,$4F,$10,$4A,$10,$4F,$10,$4A,$10
	db $4F,$10,$4A,$10,$4F,$10,$4A,$10,$4F,$10,$4A,$10,$4E,$10,$51,$10

	db $0A,$68,$00,$1F
	db $D4,$1D,$D5,$1D,$C1,$1D,$C2,$1D,$CA,$1C,$CB,$1C,$CA,$1C,$CB,$1C
	db $CA,$1C,$CB,$1C,$CA,$1C,$CB,$1C,$C0,$1D,$D1,$1D,$D2,$1D,$D3,$1D

	db $0A,$88,$00,$1F
	db $E8,$1D,$E9,$1D,$EA,$1D,$EB,$1D,$E0,$1D,$E1,$1D,$E4,$1D,$E5,$1D
	db $E0,$1D,$E1,$1D,$E4,$1D,$E5,$1D,$E8,$1D,$E9,$1D,$EA,$1D,$EB,$1D

	db $0A,$A8,$00,$1F
	db $F8,$1D,$F9,$1D,$FA,$1D,$FB,$1D,$F0,$1D,$F1,$1D,$F4,$1D,$F5,$1D
	db $F0,$1D,$F1,$1D,$F4,$1D,$F5,$1D,$F8,$1D,$F9,$1D,$FA,$1D,$FB,$1D

	db $0A,$C8,$00,$1F
	db $C8,$1D,$C9,$1D,$CA,$1D,$CB,$1D,$E2,$1D,$E3,$1D,$E6,$1D,$E7,$1D
	db $E2,$1D,$E3,$1D,$E6,$1D,$E7,$1D,$C8,$1D,$C9,$1D,$CA,$1D,$CB,$1D

	db $0A,$E8,$00,$1F
	db $D8,$1D,$D9,$1D,$DA,$1D,$DB,$1D,$F2,$1D,$F3,$1D,$F6,$1D,$F7,$1D
	db $F2,$1D,$F3,$1D,$F6,$1D,$F7,$1D,$D8,$1D,$D9,$1D,$DA,$1D,$DB,$1D

	db $FF,$FF

.UnusedGrassPlain:
;$04AC4B
	db $02,$8A,$00,$0B
	db $14,$12,$15,$12,$14,$12,$15,$12,$14,$12,$15,$12

	db $02,$AA,$00,$0B
	db $16,$12,$17,$12,$16,$12,$17,$12,$16,$12,$17,$12

	db $02,$4C,$80,$07
	db $B8,$08,$BC,$08,$BE,$0C,$BE,$0C

	db $02,$4D,$80,$07
	db $B9,$08,$BD,$08,$BF,$0C,$BF,$0C

	db $01,$F3,$00,$03
	db $D6,$10,$D7,$10

	db $02,$12,$00,$07
	db $D8,$10,$D9,$10,$DA,$10,$DB,$10

	db $02,$32,$00,$07
	db $DC,$10,$DD,$10,$DE,$10,$DF,$10

	db $02,$C8,$00,$1F
	db $08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A
	db $08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A

	db $02,$E8,$00,$1F
	db $18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A
	db $18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A

	db $FF,$FF

.SnowyNightPlain:
	db $02,$0A,$80,$0B
	db $B8,$08,$BA,$08,$BA,$08,$BC,$08,$BE,$0C,$BE,$0C

	db $02,$0B,$80,$0B
	db $B9,$08,$BB,$08,$BB,$08,$BD,$08,$BF,$0C,$BF,$0C

	db $02,$92,$00,$07
	db $14,$12,$15,$12,$14,$12,$15,$12

	db $02,$B2,$00,$07
	db $16,$12,$17,$12,$16,$12,$17,$12

	db $02,$C8,$00,$1F
	db $08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A
	db $08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A

	db $02,$E8,$00,$1F
	db $18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A
	db $18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A

	db $FF,$FF

DATA_04AD6F:
	db $01,$EB,$40,$02
	db $24,$00

	db $02,$0A,$40,$06
	db $24,$00

	db $02,$2A,$40,$06
	db $24,$00

	db $02,$53,$40,$06
	db $24,$00

	db $02,$72,$40,$0A
	db $24,$00

	db $02,$91,$40,$0C
	db $24,$00

	db $02,$B0,$40,$0E
	db $24,$00

	db $FF,$FF

DATA_04AD9B:
	db $09,$EB,$00,$09
	db $C0,$1C,$24,$00,$C5,$1C,$24,$00,$C3,$1C

	db $0A,$0C,$00,$05
	db $C2,$1C,$24,$00,$C1,$1C

	db $0A,$29,$00,$01
	db $C2,$1C

	db $0A,$4B,$00,$01
	db $C1,$1C

	db $0A,$14,$00,$01
	db $C5,$1C

	db $0A,$53,$00,$07
	db $C3,$1C,$24,$00,$C4,$1C,$24,$00

	db $0A,$68,$00,$1F
	db $C6,$15,$C7,$15,$C8,$15,$C9,$15,$CA,$15,$CB,$15,$C6,$1C,$CD,$15
	db $C6,$15,$C7,$15,$C8,$15,$C9,$15,$CA,$15,$CB,$15,$CC,$15,$CD,$15

	db $0A,$88,$00,$1F
	db $D6,$15,$D7,$15,$D8,$15,$D9,$15,$DA,$15,$DB,$15,$DC,$15,$DD,$15
	db $D6,$15,$D7,$15,$D8,$15,$D9,$15,$DA,$15,$DB,$15,$DC,$15,$DD,$15

	db $0A,$A8,$00,$1F
	db $E6,$15,$E7,$15,$E8,$15,$E9,$15,$EA,$15,$EB,$15,$EC,$15,$ED,$15
	db $E6,$15,$E7,$15,$E8,$15,$E9,$15,$EA,$15,$EB,$15,$EC,$15,$ED,$15

	db $FF,$FF

;--------------------------------------------------------------------

DATA_04AE3F:
	dw $0000,$0020,$0040,$0060,$0080,$00A0,$00C0,$00E0
	dw $0100,$0120,$0140,$0160,$0180,$01A0,$01C0,$01E0
	dw $0200,$0220,$0240,$0260,$0280,$02A0,$02C0,$02E0
	dw $0300,$0320,$0340,$03A0,$03E0,$03C0,$03E0,$0420
	dw $0360,$0380,$02E0,$02E0,$02E0,$02E0,$0500,$0520
	dw $0540,$0560,$0580,$05C0,$05E0,$0600,$0620,$0640
	dw $0660,$0740,$0780,$07A0,$0460,$04A0,$04C0,$04E0
	dw $05A0,$0680,$06A0,$06C0,$06E0,$0700,$0400,$0720
	dw $0440,$0480

DATA_04AEC3:					; Note: Palettes
.Global_Row00:
	dw $42DD,$7FFF,$1084,$3800,$7708,$035F,$0259,$3800,$7708,$7FFF,$73B9,$6335,$7708,$7FFF,$722B,$65C8

.Global_Row01:
	dw $7708,$7FFF,$1084,$1BDF,$027F,$0139,$1ADA,$0DF3,$050D,$4F7F,$3298,$15B1,$3FFF,$45BF,$20D4,$2D3A

	dw $7BAF,$7FFF,$1084,$57F3,$0340,$01A0,$0000,$0000,$0000,$04D0,$0554,$11D8,$125C,$2BAA,$3800,$0A62

	dw $7BAF,$7FFF,$0842,$2B30,$14B8,$0D3F,$029F,$035F,$0008,$008E,$1575,$1A3A,$3F5F,$5AD6,$2529,$3DEF

	dw $7BAF,$7FFF,$1084,$7FB8,$72B0,$32FC,$2256,$11CF,$054B,$09E6,$1AAB,$2B30,$3BB4,$287F,$000E,$0015

	dw $7BAF,$376D,$1084,$22A9,$219B,$1538,$04B4,$0470,$040C,$21C2,$3246,$3EA9,$4B0C,$534E,$01C3,$1646

	dw $772F,$7FFF,$1084,$729F,$51B8,$30B0,$7E97,$6DB0,$54EA,$294A,$4210,$5EF7,$6F7B,$571F,$251C,$3E3F

	dw $7BAF,$7FFF,$1084,$778C,$6F4A,$6708,$5EC6,$5684,$4E42,$21C2,$3246,$42CA,$4F2D,$6372,$1084,$1084

.Global_Row08:
	dw $45BC,$7FFF,$14A5,$01A5,$0249,$02CD,$4631,$5AD6,$0000,$0351,$0019,$011F,$061F,$129F,$017A,$0113

	dw $45BC,$7FFF,$14A5,$008D,$0112,$19D9,$2A9E,$36FF,$0000,$7FFF,$0813,$2D9B,$465F,$539F,$1B9F,$1A5F

.Global_Row0A:
	dw $45BC,$7FFF,$14A5,$013B,$027F,$179F,$0135,$265E,$0000,$0C9B,$0135,$261D,$42DF,$6ADF,$4A1D,$28FA

.Global_Row0B:
	dw $734E,$7FFF,$14A5,$3D84,$5229,$27BF,$31BB,$3ABF,$0000,$152F,$355D,$525F,$169B,$1C9F,$0C19,$0C19

.Global_Row0C:
	dw $45BC,$7FFF,$14A5,$013B,$027F,$179F,$0135,$265E,$0000,$0C9B,$0220,$0EE0,$23A0,$6ADF,$4A1D,$28FA

	dw $45BC,$7FFF,$14A5,$0203,$0F0A,$2BF1,$0135,$265E,$0000,$3F5F,$294A,$4631,$6318,$1A3A,$1575,$008E

.Global_Row0E:
	dw $45BC,$7FFF,$14A5,$0055,$0C3E,$3D9F,$0135,$265E,$0000,$42DF,$4025,$74D2,$7EB2,$261D,$1557,$00AF

.Global_Row0F:
	dw $45BC,$7FFF,$14A5,$0111,$0DB9,$22DD,$2D9C,$3ABF,$0000,$0000,$14EC,$1DD4,$369A,$20BC,$1096,$000F

	dw $7F92,$7FFF,$1084,$5B0C,$568A,$5208,$4DA6,$4944,$44E2,$0887,$14EA,$214D,$298F,$2936,$0831,$1CD3

	dw $7F92,$7FFF,$1084,$722B,$65C8,$5D86,$7F36,$6DB0,$54EA,$294A,$4210,$5EF7,$6F7B,$52FF,$35BC,$469C

	dw $7F92,$7FFF,$0000,$0A1F,$011D,$0013,$0000,$0000,$0000,$0887,$14EA,$214D,$298F,$4280,$2940,$35E0

	dw $772F,$7FFF,$1084,$57F0,$0340,$01A0,$1BDF,$027F,$0139,$3CE1,$5186,$662B,$7AD0,$2BAA,$3800,$0A62

	dw $772F,$7FFF,$1084,$0000,$0000,$0000,$1ADA,$0DF3,$050D,$3961,$4E06,$62AB,$7750,$5AD6,$2529,$3DEF

	dw $772F,$7FFF,$0000,$264E,$49EC,$41AA,$3968,$3126,$28E4,$1C41,$28A3,$3506,$3D48,$0525,$0D88,$19EB

	dw $772F,$6739,$0000,$2CC5,$3D89,$3DCD,$4E51,$2EF8,$1E74,$1C41,$28A3,$3506,$3D48,$4210,$2108,$318C

	dw $45BC,$7FFF,$14A5,$2CE0,$41A3,$5648,$6AED,$7F71,$0000,$7FFF,$3013,$4D9B,$625F,$539F,$1B9F,$1A5F

	dw $45BC,$7FFF,$14A5,$1E22,$2F01,$3FE0,$0135,$1A9F,$0000,$7750,$294A,$4631,$6318,$62AB,$4E06,$3961

	dw $772F,$7FFF,$1084,$3B1F,$035F,$029F,$11D7,$0153,$00CF,$0000,$0000,$0000,$0000,$0000,$0000,$0000

	dw $772F,$7FFF,$14A5,$05BF,$001E,$0017,$46BF,$365D,$25BB,$04EF,$0D73,$4F7F,$7F0F,$0000,$0000,$0000

	dw $45BC,$7FFF,$14C5,$256D,$3A12,$4A96,$5B1A,$6B9E,$0000,$7FFF,$210E,$35B7,$4E79,$539F,$1B9F,$1A5F

	dw $45BC,$7FFF,$14A5,$1E22,$2F01,$3FE0,$0135,$1A9F,$0000,$5B1A,$294A,$4631,$6318,$4A96,$3A12,$256D

	dw $7708,$7FFF,$1084,$57F3,$0340,$01A0,$0000,$0000,$0000,$1D28,$2DAC,$3E30,$4EB4,$2BAA,$3800,$0A62

	dw $7708,$15EF,$114C,$012E,$00EC,$00AA,$090A,$1D63,$1521,$0864,$10A6,$18E8,$212A,$296C,$31AE,$39F0

	dw $7708,$7FFF,$1084,$097F,$005A,$000F,$7E97,$6DB0,$54EA,$256D,$3A12,$4A96,$5B1A,$571F,$251C,$3E3F

	dw $7BAF,$7FFF,$1084,$0000,$0000,$0000,$0000,$0000,$0000,$294A,$4210,$5EF7,$6F7B,$5AD6,$2529,$3DEF

	dw $7708,$7FFF,$3DAD,$314A,$24E7,$01F6,$0192,$012F,$00AC,$0864,$10A6,$18E8,$212A,$296C,$0088,$00CA

	dw $7BAF,$7FFF,$0842,$2B30,$14B8,$0D3F,$029F,$035F,$0008,$008E,$1575,$1A3A,$3F5F,$6F7B,$5AD6,$3DEF

	dw $7708,$7FFF,$1084,$77BD,$5EF7,$3DEF,$1BDF,$027F,$0139,$0492,$0D17,$25DD,$3A7F,$6F7B,$3800,$5294

	dw $3908,$7FFF,$0842,$2B30,$14B8,$0D3F,$029F,$035F,$0008,$008E,$1575,$1A3A,$3F5F,$6F7B,$5AD6,$3DEF

	dw $7708,$7FFF,$1084,$77BD,$5EF7,$3DEF,$1BDF,$027F,$0139,$0492,$0D17,$25DD,$3A7F,$6F7B,$3800,$5294

	dw $3908,$4D4B,$18C6,$4509,$4D2D,$44EB,$3CA9,$7FFF,$73B9,$21C2,$3246,$42CA,$4F2D,$6372,$30C3,$3904

	dw $3C63,$7F7B,$7E73,$5D6B,$6FFB,$4FF3,$2EEB,$0DE3,$3FFF,$1EF7,$0A52,$01CE,$6F7F,$4E7F,$2D77,$0C75

	dw $7708,$7FFF,$1084,$57F3,$0340,$01A0,$1BDF,$027F,$0139,$04D0,$0554,$11D8,$125C,$2BAA,$3800,$0A62

	dw $7708,$7FFF,$1084,$0000,$0000,$0000,$1ADA,$0DF3,$050D,$008E,$1575,$1A3A,$3F5F,$5AD6,$2529,$3DEF

	dw $7708,$7FFF,$1084,$7FB8,$72B0,$32FC,$2256,$11CF,$054B,$5AD6,$6739,$739C,$7FFF,$287F,$000E,$0015

	dw $7BAF,$7FFF,$1084,$5B5B,$46D7,$435F,$32DF,$225B,$11D7,$01B3,$0A37,$1ABB,$2F5F,$1D3C,$0034,$0CB8

	dw $7BAF,$7FFF,$1CE7,$4EFF,$42BF,$53FF,$479D,$3B3A,$2ED7,$2E7E,$3ADF,$473F,$4B9F,$0000,$0000,$0000

	dw $7BAF,$7F38,$216D,$7FBF,$7F38,$5B3B,$4AB7,$3A33,$29AF,$2A13,$3A97,$4B1B,$5B9E,$76B4,$69C9,$7230

	dw $7BAF,$7FFF,$1084,$2B96,$1713,$3B9D,$12F8,$0A74,$01F0,$2A03,$3A87,$4B0B,$576E,$6BB3,$020B,$028F

	dw $7BAF,$130F,$05C5,$0A8B,$01F8,$0172,$010D,$7FFF,$73B9,$21C2,$3246,$3EA9,$4B0C,$5FB1,$0589,$0A29

	dw $7BAF,$7FFF,$1084,$7FFF,$6FD9,$7FFF,$777B,$66F7,$5673,$4E7F,$5EFF,$6F7F,$7FFF,$6372,$4ED1,$5F55

	dw $7BAF,$7FFF,$1907,$5B57,$577C,$46F8,$3674,$25F0,$156C,$296D,$39F1,$4A75,$5AF9,$6B7D,$3A4F,$4AD3

	dw $7708,$15EF,$114C,$012E,$00EC,$00AA,$090A,$1D63,$1521,$0C63,$14A3,$1CE5,$2527,$2D69,$35AB,$3DED

	dw $7708,$0C63,$1CE5,$2D69,$2527,$1D0B,$18EA,$10A8,$0866,$0C63,$14A3,$1CE5,$2527,$2D69,$00D6,$015A

	dw $7F92,$7FFF,$0842,$4631,$3DEF,$35AD,$2D6B,$2529,$1CE7,$10EA,$1D4D,$29B0,$3613,$3208,$1942,$25A5

	dw $7F92,$7FFF,$29F8,$67FF,$4BDF,$3B7E,$331B,$26B8,$1A55,$2E79,$3ADC,$473F,$539F,$4F1F,$365B,$42BE

	dw $7F92,$7FFF,$29F8,$6BFF,$5FFC,$53B9,$4756,$3AF3,$2E90,$2E79,$3ADC,$473F,$539F,$4F1F,$365B,$42BE

	dw $7BAF,$7FFF,$1084,$29F9,$1975,$1A98,$0E15,$0191,$010D,$184D,$20D1,$2955,$31D9,$3A5D,$006E,$08F1

	dw $7BAF,$02D4,$1084,$7FFF,$3E99,$2E15,$1D91,$092E,$00AA,$21C2,$3246,$3EA9,$4B0C,$534E,$6739,$739C

	dw $45BC,$7FFF,$0C63,$40C0,$5565,$65E9,$4631,$5AD6,$0000,$766D,$0012,$101A,$311F,$367A,$21D5,$0D30

	dw $7708,$7FFF,$1084,$53BF,$033E,$025C,$4A5F,$315F,$001D,$004A,$04B2,$0A1C,$133D,$677F,$017C,$0019

;--------------------------------------------------------------------

DATA_04B623:
	dw $1084,$7FFF,$04CA,$0155,$1A1C,$1B3E,$2DFF,$471F,$56B5,$1173,$1242,$3329,$1C9F,$0C18,$79E6,$5144
	dw $7BAF,$7FFF,$1084,$53BF,$033E,$025C,$0000,$0000,$0000,$1058,$015F,$0E1F,$140E,$02BF,$017C,$0019
	dw $1084,$7FFF,$0C63,$0113,$11DA,$1B3E,$2DFF,$471F,$5EF7,$152F,$0012,$0C19,$1C9F,$762D,$7189,$5905

;--------------------------------------------------------------------

DATA_04B683:
	db $D0,$04,$B1,$20,$C1,$23,$D1,$14,$92,$04,$A2,$23,$B2,$14,$C2,$47
	db $83,$20,$93,$14,$A3,$47,$74,$04,$84,$14,$94,$47,$55,$04,$65,$09
	db $75,$06,$85,$47,$D5,$17,$46,$20,$56,$14,$66,$0C,$76,$14,$86,$47
	db $C6,$17,$D6,$14,$47,$21,$57,$01,$67,$47,$B7,$10,$C7,$14,$48,$22
	db $58,$08,$68,$1A,$78,$47,$B8,$13,$59,$15,$69,$1B,$79,$47,$A9,$10
	db $B9,$14,$4A,$20,$5A,$14,$6A,$47,$AA,$18,$4B,$22,$5B,$08,$6B,$47
	db $9B,$10,$AB,$14,$5C,$06,$6C,$47,$8C,$17,$9C,$02,$5D,$05,$6D,$08
	db $7D,$47,$8D,$19,$9D,$03,$AD,$1A,$BD,$08,$6E,$22,$7E,$08,$8E,$47
	db $9E,$19,$AE,$2F,$BE,$11,$CE,$08,$7F,$21,$8F,$47,$CF,$19,$60,$A0
	db $70,$14,$80,$47,$61,$21,$71,$2C,$81,$47,$62,$21,$72,$2D,$82,$47
	db $63,$05,$73,$08,$83,$1A,$93,$47,$74,$22,$84,$0B,$94,$22,$A4,$08
	db $B4,$47,$A5,$21,$B5,$47,$A6,$05,$B6,$08,$C6,$47,$B7,$22,$C7,$08
	db $D7,$07,$18,$20,$28,$29,$C8,$22,$D8,$08,$09,$20,$19,$14,$29,$0C
	db $39,$09,$D9,$05,$0A,$21,$1A,$2C,$2A,$07,$3A,$0A,$0B,$21,$1B,$2D
	db $2B,$07,$3B,$0A,$0C,$22,$1C,$08,$2C,$1A,$3C,$2B,$1D,$22,$2D,$0B
	db $D0,$A0,$A1,$20,$B1,$63,$D1,$14,$82,$04,$92,$23,$A2,$14,$B2,$47
	db $33,$04,$43,$23,$53,$09,$63,$20,$73,$23,$83,$14,$93,$47,$24,$20
	db $34,$02,$44,$47,$54,$0C,$64,$14,$25,$22,$35,$03,$45,$47,$36,$05
	db $46,$08,$56,$47,$37,$20,$47,$19,$57,$08,$67,$47,$28,$04,$38,$14
	db $48,$47,$29,$22,$39,$08,$49,$47,$3A,$05,$4A,$10,$5A,$14,$6A,$47
	db $8A,$1A,$9A,$10,$AA,$14,$3B,$20,$4B,$14,$5B,$47,$7B,$1A,$8B,$0B
	db $9B,$21,$9C,$10,$3C,$21,$4C,$01,$5C,$47,$7C,$0A,$8C,$00,$9C,$05
	db $AC,$08,$BC,$1A,$CC,$08,$3D,$05,$4D,$08,$5D,$07,$6D,$1A,$7D,$0B
	db $AD,$22,$BD,$0B,$CD,$06,$DD,$1A,$4E,$22,$5E,$24,$6E,$0B,$CE,$05
	db $DE,$0B,$B0,$84,$C0,$23,$D0,$29,$A1,$20,$B1,$47,$82,$20,$92,$0F
	db $A2,$14,$B2,$47,$13,$20,$23,$09,$73,$04,$83,$02,$93,$47,$04,$20
	db $14,$14,$24,$07,$34,$29,$74,$15,$84,$03,$94,$47,$05,$21,$15,$01
	db $25,$07,$35,$0A,$65,$04,$75,$47,$85,$18,$06,$05,$16,$08,$26,$1A
	db $36,$0B,$66,$06,$76,$10,$86,$11,$96,$08,$A6,$47,$17,$22,$27,$0B
	db $67,$21,$77,$18,$87,$47,$58,$20,$68,$14,$78,$19,$88,$08,$98,$47
	db $A8,$1A,$B8,$08,$39,$04,$49,$0F,$59,$14,$69,$47,$89,$11,$99,$1F
	db $A9,$1B,$B9,$19,$C9,$08,$2A,$27,$3A,$28,$4A,$47,$AA,$08,$CA,$13
	db $3B,$22,$4B,$08,$5B,$47,$6B,$1A,$7B,$08,$AB,$11,$BB,$1C,$CB,$08
	db $4C,$05,$5C,$24,$6C,$0B,$7C,$05,$8C,$08,$9C,$47,$CC,$19,$8D,$22
	db $9D,$08,$AD,$47,$9E,$05,$AE,$08,$BE,$1A,$CE,$08,$DE,$07,$AF,$22
	db $BF,$0B,$CF,$05,$DF,$0B,$D0,$A0,$91,$20,$A1,$29,$C1,$20,$D1,$14
	db $72,$04,$82,$23,$92,$14,$A2,$0C,$B2,$0F,$C2,$14,$D2,$07,$43,$20
	db $53,$09,$63,$20,$73,$14,$83,$47,$34,$04,$44,$14,$54,$0C,$64,$1D
	db $74,$14,$84,$47,$25,$20,$35,$14,$45,$2C,$55,$47,$26,$22,$36,$08
	db $46,$2D,$56,$47,$37,$05,$47,$08,$57,$47,$97,$17,$A7,$2E,$48,$22
	db $58,$08,$68,$1A,$78,$47,$88,$10,$98,$14,$A8,$0C,$59,$15,$69,$1B
	db $79,$47,$89,$18,$99,$01,$4A,$20,$5A,$14,$6A,$47,$8A,$19,$9A,$08
	db $AA,$1A,$4B,$21,$5B,$01,$6B,$47,$9B,$19,$AB,$1B,$4C,$05,$5C,$08
	db $6C,$47,$5D,$22,$6D,$25,$7D,$28,$8D,$47,$7E,$22,$8E,$08,$9E,$1A
	db $AE,$08,$BE,$07,$CE,$1A,$DE,$08,$8F,$05,$9F,$0B,$AF,$05,$BF,$24
	db $CF,$0B,$DF,$05,$A1,$84,$B1,$09,$D1,$20,$02,$04,$12,$23,$22,$29
	db $92,$20,$A2,$14,$B2,$0C,$C2,$0F,$D2,$14,$03,$21,$13,$2C,$23,$0A
	db $63,$20,$73,$23,$83,$26,$93,$28,$A3,$01,$B3,$47,$04,$21,$14,$2D
	db $24,$0A,$54,$20,$64,$14,$74,$47,$94,$11,$A4,$08,$05,$05,$15,$24
	db $25,$0B,$55,$21,$65,$01,$75,$47,$56,$22,$66,$08,$76,$47,$86,$17
	db $96,$14,$67,$05,$77,$08,$87,$19,$97,$08,$A7,$47,$68,$20,$78,$14
	db $88,$47,$98,$11,$A8,$08,$59,$04,$69,$14,$79,$2C,$89,$47,$A9,$18
	db $5A,$22,$6A,$08,$7A,$2D,$8A,$47,$AA,$19,$BA,$08,$6B,$22,$7B,$08
	db $8B,$47,$BB,$11,$CB,$1B,$DB,$08,$7C,$22,$8C,$08,$9C,$47,$AC,$1A
	db $BC,$08,$DC,$19,$8D,$05,$9D,$24,$AD,$0B,$BD,$05,$CD,$08,$DD,$07
	db $CE,$22,$DE,$08,$DF,$22,$D0,$A0,$B1,$04,$C1,$0F,$D1,$14,$A2,$20
	db $B2,$14,$C2,$47,$93,$04,$A3,$47,$94,$21,$A4,$01,$B4,$47,$95,$22
	db $A5,$08,$B5,$47,$A6,$22,$B6,$08,$C6,$47,$77,$04,$87,$09,$B7,$15
	db $C7,$08,$D7,$07,$68,$20,$78,$14,$88,$0C,$98,$09,$A8,$20,$B8,$14
	db $C8,$19,$D8,$08,$49,$20,$59,$0F,$69,$14,$79,$47,$99,$0C,$A9,$14
	db $3A,$04,$4A,$14,$5A,$47,$3B,$06,$4B,$47,$2C,$20,$3C,$14,$4C,$2C
	db $5C,$47,$2D,$22,$3D,$08,$4D,$2D,$5D,$47,$7D,$1A,$8D,$08,$3E,$05
	db $4E,$47,$6E,$1A,$7E,$0B,$8E,$15,$9E,$08,$4F,$22,$5F,$08,$6F,$0C
	db $7F,$23,$8F,$14,$9F,$19,$AF,$08,$BF,$47,$40,$A0,$50,$14,$60,$47
	db $A0,$19,$B0,$1C,$C0,$08,$D0,$07,$31,$20,$41,$14,$51,$47,$32,$21
	db $42,$47,$52,$01,$33,$22,$43,$08,$53,$47,$44,$05,$54,$08,$64,$47
	db $45,$20,$55,$14,$65,$47,$36,$04,$46,$0E,$56,$14,$66,$47,$76,$17
	db $86,$14,$27,$20,$37,$47,$67,$10,$77,$14,$28,$05,$38,$24,$48,$08
	db $58,$47,$68,$18,$49,$05,$59,$10,$69,$14,$79,$2C,$89,$47,$5A,$22
	db $6A,$08,$7A,$2D,$8A,$47,$6B,$05,$7B,$08,$8B,$47,$7C,$22,$8C,$08
	db $9C,$1A,$AC,$24,$BC,$08,$CC,$47,$8D,$05,$9D,$0B,$BD,$22,$CD,$08
	db $DD,$07,$CE,$05,$DE,$08,$DF,$22,$D2,$A0,$53,$20,$63,$09,$C3,$04
	db $D3,$14,$44,$04,$54,$14,$64,$0C,$74,$23,$84,$09,$94,$04,$A4,$09
	db $C4,$05,$D4,$08,$35,$20,$45,$14,$55,$47,$75,$10,$85,$0E,$95,$14
	db $A5,$0C,$B5,$29,$C5,$20,$D5,$14,$36,$21,$46,$47,$76,$14,$B6,$0C
	db $C6,$14,$27,$20,$37,$47,$57,$01,$28,$05,$38,$08,$48,$47,$A8,$10
	db $B8,$2E,$39,$22,$49,$08,$59,$1A,$69,$08,$79,$47,$99,$17,$A9,$14
	db $B9,$0C,$4A,$05,$5A,$0B,$6A,$22,$7A,$08,$8A,$17,$9A,$14,$AA,$47
	db $6B,$04,$7B,$14,$8B,$19,$9B,$08,$AB,$47,$6C,$05,$7C,$24,$8C,$17
	db $9C,$14,$AC,$47,$7D,$04,$8D,$14,$9D,$47,$7E,$21,$8E,$47,$9E,$2C
	db $7F,$21,$8F,$47,$9F,$2D,$70,$85,$80,$08,$90,$47,$71,$20,$81,$19
	db $91,$08,$A1,$1A,$B1,$08,$C1,$47,$52,$04,$62,$0F,$72,$14,$82,$47
	db $92,$19,$A2,$1B,$B2,$19,$C2,$08,$43,$20,$53,$02,$63,$47,$C3,$19
	db $D3,$08,$44,$05,$54,$03,$64,$47,$D4,$19,$55,$22,$65,$1B,$75,$47
	db $66,$05,$76,$08,$86,$47,$77,$22,$87,$08,$97,$1A,$A7,$08,$B7,$47
	db $88,$05,$98,$0B,$A8,$05,$B8,$08,$C8,$47,$B9,$22,$C9,$08,$D9,$07
	db $CA,$05,$DA,$0B,$20,$84,$30,$23,$40,$09,$11,$20,$21,$14,$31,$07
	db $41,$0C,$51,$09,$12,$21,$22,$01,$32,$07,$42,$07,$52,$0A,$13,$05
	db $23,$08,$33,$07,$43,$07,$53,$0B,$A3,$04,$B3,$23,$C3,$09,$24,$22
	db $34,$24,$44,$0B,$94,$20,$A4,$14,$B4,$07,$C4,$17,$D4,$0F,$85,$20
	db $95,$14,$A5,$47,$C5,$14,$86,$22,$96,$08,$A6,$47,$67,$20,$77,$09
	db $87,$04,$97,$13,$A7,$47,$58,$20,$68,$14,$78,$0C,$88,$14,$98,$13
	db $A8,$47,$49,$04,$59,$14,$69,$47,$89,$17,$99,$14,$A9,$2C,$4A,$06
	db $5A,$47,$8A,$19,$9A,$08,$AA,$2D,$3B,$20,$4B,$14,$5B,$47,$9B,$19
	db $AB,$08,$3C,$21,$4C,$47,$5C,$10,$6C,$2E,$7C,$10,$8C,$14,$9C,$10
	db $AC,$14,$3D,$05,$4D,$10,$5D,$14,$6D,$0C,$7D,$14,$8D,$47,$9D,$14
	db $4E,$06,$5E,$47,$6E,$2C,$4F,$05,$5F,$08,$6F,$2D,$7F,$47,$50,$A2
	db $60,$08,$70,$47,$61,$06,$71,$47,$52,$20,$62,$11,$72,$1F,$82,$08
	db $92,$47,$53,$21,$63,$47,$83,$19,$93,$1F,$A3,$08,$54,$05,$64,$08
	db $74,$47,$A4,$19,$B4,$08,$65,$22,$75,$08,$85,$47,$B5,$13,$76,$06
	db $86,$47,$B6,$11,$C6,$08,$67,$04,$77,$14,$87,$2C,$97,$47,$C7,$19
	db $D7,$08,$68,$22,$78,$08,$88,$2D,$98,$47,$D8,$11,$79,$05,$89,$08
	db $99,$47,$7A,$20,$8A,$14,$9A,$47,$7B,$22,$8B,$24,$9B,$08,$AB,$47
	db $9C,$21,$AC,$47,$BC,$1A,$CC,$08,$9D,$22,$AD,$24,$BD,$2B,$CD,$22
	db $DD,$08,$DE,$05,$FF,$FF

;--------------------------------------------------------------------

; Note: Layer 3 cloud tilemap.

SMB1_Layer3CloudBGTilemap:
.Main:
;$04BD09
	dw $085C,$085C,$085C,$085C
	dw $0855,$0856,$0855,$4856
	dw $0854,$0853,$0855,$0856
	dw $0855,$4856,$4854,$0853
	dw $085C,$0857,$0857,$0854
	dw $4857,$4854,$085C,$4857
	dw $4857,$4854,$0857,$0854
	dw $0853,$0853,$0853,$0853
	dw $0853,$0853,$4854,$0853
	dw $8850,$8851,$0853,$8852
	dw $0853,$C852,$0853,$8852
	dw $0853,$C852,$C850,$C851
	dw $0853,$8854,$0853,$0853
	dw $C854,$4854,$C857,$4857
	dw $8858,$0858,$0853,$0853
	dw $8857,$0857,$8854,$0854
	dw $0853,$085B,$085B,$0854
	dw $485B,$4854,$8853,$485B
	dw $0853,$8854,$4854,$0853
	dw $485B,$4854,$085B,$0854
	dw $0854,$0853,$0853,$0853
	dw $4857,$4854,$0857,$485B
	dw $4857,$085B,$0857,$0854
	dw $0859,$0858,$085A,$0853
	dw $485A,$0853,$085A,$0853
	dw $485A,$0853,$4859,$4858
	dw $0853,$0853,$0853,$C854
	dw $C854,$C85B,$C85B,$0853
	dw $C854,$4854,$C85B,$485B
	dw $885B,$085B,$8854,$0854
	dw $C854,$0853,$8854,$0853
	dw $0853,$0853,$C858,$4858
	dw $0851,$0850,$0852,$0853
	dw $4852,$0853,$0852,$0853
	dw $4852,$0853,$4851,$4850
	dw $8850,$0850,$0853,$0853
	dw $0853,$0853,$C850,$4850
	dw $C854,$085B,$C857,$4857
	dw $8857,$0857,$8854,$485B
	dw $085C,$0857,$085C,$4857
	dw $0854,$0853,$4854,$0853
	dw $8857,$085C,$8854,$8857
	dw $C854,$C857,$8854,$8857
	dw $C854,$C857,$C857,$085C
	dw $0853,$0853,$0855,$0856
	dw $0855,$4856,$0853,$0853
	dw $8858,$8859,$0853,$885A
	dw $0853,$C85A,$C858,$C859

if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	%FREE_BYTES(NULLROM, 332, $FF)
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMB1_J) != $00
	%FREE_BYTES(NULLROM, 356, $FF)
else
	%FREE_BYTES(NULLROM, 375, $FF)
endif

;--------------------------------------------------------------------

DATA_04C000:
	db $26,$AC,$26,$26,$26,$72,$72,$72
	db $13,$59,$8B

;--------------------------------------------------------------------

CODE_04C00B:
	PHB
	PHK
	PLB
	JSL.l CODE_04C01F
	STA.w !RAM_SMB1_Level_SublevelIDAndTileset
	AND.b #$60
	ASL
	ROL
	ROL
	ROL
	STA.b !RAM_SMB1_Level_CurrentLevelType
	PLB
	RTL

CODE_04C01F:
	PHB
	PHK
	PLB
	LDY.w !RAM_SMB1_Player_CurrentWorld
	CPY.b #$08
	BCC.b CODE_04C034
	STZ.w !RAM_SMB1_Player_CurrentLevel
	STZ.w !RAM_SMB1_Player_CurrentLevelNumberDisplay
	LDY.b #$00
	STY.w !RAM_SMB1_Player_CurrentWorld
CODE_04C034:
	LDA.w SMB1_LevelData_LevelIDRelativePtrs,y
	CLC
	ADC.w !RAM_SMB1_Player_CurrentLevel
	TAY
	LDA.w SMB1_LevelData_LevelIDsAndTileset,y
	PLB
	RTL

;--------------------------------------------------------------------

CODE_04C041:
	PHB
	PHK
	PLB
	STZ.b $BA
	LDA.w !RAM_SMB1_Level_SublevelIDAndTileset
	AND.b #$60
	ASL
	ROL
	ROL
	ROL
	STA.b !RAM_SMB1_Level_CurrentLevelType
	TAY
	LDA.w !RAM_SMB1_Level_SublevelIDAndTileset
	AND.b #$1F
	STA.w !RAM_SMB1_LevelLoad_ScratchRAM7E074F
	LDA.w SMB1_LevelData_SpriteDataRelativePtrs,y
	CLC
	ADC.w !RAM_SMB1_LevelLoad_ScratchRAM7E074F
	TAY
	LDA.w SMB1_LevelData_SpriteDataPtrs_Lo,y
	STA.b !RAM_SMB1_Level_SpriteListDataLo
	LDA.w SMB1_LevelData_SpriteDataPtrs_Hi,y
	STA.b !RAM_SMB1_Level_SpriteListDataHi
	LDA.b #SMB1_LevelData_SpriteDataPtrs_Lo>>16
	STA.b !RAM_SMB1_Level_SpriteListDataBank
	LDY.b !RAM_SMB1_Level_CurrentLevelType
	LDA.w SMB1_LevelData_ObjectDataRelativePtrs,y
	CLC
	ADC.w !RAM_SMB1_LevelLoad_ScratchRAM7E074F
	TAY
	STA.b $DB
	CMP.b #$1C
	BCS.b CODE_04C08C
	CMP.b #$19
	BCS.b CODE_04C08E
	CMP.b #$03
	BCS.b CODE_04C090
	CMP.b #$02
	BCC.b CODE_04C092
CODE_04C08C:
	INC.b $BA
CODE_04C08E:
	INC.b $BA
CODE_04C090:
	INC.b $BA
CODE_04C092:
	LDA.w SMB1_LevelData_ObjectDataPtrs_Lo,y
	STA.b !RAM_SMB1_Level_LevelDataPtrLo
	LDA.w SMB1_LevelData_ObjectDataPtrs_Hi,y
	STA.b !RAM_SMB1_Level_LevelDataPtrHi
	LDA.b #SMB1_LevelData_ObjectDataPtrs_Lo>>16
	STA.b !RAM_SMB1_Level_LevelDataPtrBank
	LDY.b #$00
	LDA.b [!RAM_SMB1_Level_LevelDataPtrLo],y
	PHA
	AND.b #$07
	CMP.b #$04
	BCC.b CODE_04C0B2
	AND.b #$04
	STA.w $0744
	LDA.b #$00
CODE_04C0B2:
	STA.w $0741
	PLA
	PHA
	AND.b #$38
	LSR
	LSR
	LSR
	STA.w !RAM_SMB1_Player_LevelEntrancePositionIndex
	PLA
	AND.b #$C0
	CLC
	ROL
	ROL
	ROL
	STA.w $0715
	INY
	LDA.b [!RAM_SMB1_Level_LevelDataPtrLo],y
	PHA
	AND.b #$0F
	STA.w $0727
	PLA
	PHA
	AND.b #$30
	LSR
	LSR
	LSR
	LSR
	CMP.b #$01
	BNE.b CODE_04C0E0
	LDA.b #$00
CODE_04C0E0:
	STA.w $0742
	PLA
	AND.b #$C0
	CLC
	ROL
	ROL
	ROL
	CMP.b #$03
	BNE.b CODE_04C0F3
	STA.w $0743
	LDA.b #$00
CODE_04C0F3:
	STA.w $0733
	JSR.w CODE_04C10B
	LDA.b !RAM_SMB1_Level_LevelDataPtrLo
	CLC
	ADC.b #$02
	STA.b !RAM_SMB1_Level_LevelDataPtrLo
	LDA.b !RAM_SMB1_Level_LevelDataPtrHi
	ADC.b #$00
	STA.b !RAM_SMB1_Level_LevelDataPtrHi
	STZ.w $0EE8
	PLB
	RTL

CODE_04C10B:
	LDA.w $0743
	BNE.b CODE_04C116
	LDA.b $DB
	CMP.b #$12
	BNE.b CODE_04C11B
CODE_04C116:
	LDA.b #$01
	STA.w !RAM_SMB1_Level_GrowVineAtLevelEntranceFlag
CODE_04C11B:
	RTS

;--------------------------------------------------------------------

	%DATATABLE_SMB1_LevelData(NULLROM)					; $04C11C
	%FREE_BYTES(NULLROM, 138, $FF)

;--------------------------------------------------------------------

CODE_04D800:
	LDA.w $0BA5
	BNE.b CODE_04D859
	LDA.w !RAM_SMB1_Player_CurrentPose
	CMP.b #$18
	BEQ.b CODE_04D810
	CMP.b #$78
	BNE.b CODE_04D820
CODE_04D810:
	LDA.b !RAM_SMB1_Global_FrameCounter
	AND.b #$07
	BNE.b CODE_04D820
	LDA.w !RAM_SMB1_Global_SoundCh2
	BNE.b CODE_04D820
	LDA.b #!Define_SMAS_Sound0061_TurnAround
	STA.w !RAM_SMB1_Global_SoundCh2
CODE_04D820:
	STZ.w $028E
	LDA.w !RAM_SMB1_Player_CurrentPose
	LSR
	LSR
	LSR
	INC.w $028E
	REP.b #$20
	AND.w #$00FF
	XBA
	CLC
	ADC.w #SMB1_UncompressedGFX_Player_Mario
	STA.w !RAM_SMB1_Player_GraphicsPointerLo
	LDA.w #$6000
	STA.w !RAM_SMB1_Player_VRAMAddressLo
	LDA.w #$0100
	STA.w !RAM_SMB1_Player_GraphicsUploadSizeLo
	SEP.b #$20
	LDA.w !RAM_SMB1_Global_UseLuigisPlayerGraphics					; Optimization: There is no reason why this can't just check for !RAM_SMB1_Player_CurrentCharacter.
	BEQ.b CODE_04D854
	LDA.w !RAM_SMB1_Player_GraphicsPointerHi
	ORA.b #$40
	STA.w !RAM_SMB1_Player_GraphicsPointerHi
CODE_04D854:
	LDA.b #SMB1_UncompressedGFX_Player_Mario>>16
	STA.w !RAM_SMB1_Player_GraphicsPointerBank
CODE_04D859:
	RTL

;--------------------------------------------------------------------

CODE_04D85A:
	STZ.w $0F4A
	LDA.b #$35
	RTL

;--------------------------------------------------------------------

CODE_04D860:
	REP.b #$20
	LDX.b #$1E
CODE_04D864:
	LDA.w !RAM_SMB1_Player_CurrentCharacter
	BEQ.b CODE_04D86F
	LDA.l DATA_04D8A3,x
	BRA.b CODE_04D873

CODE_04D86F:
	LDA.l DATA_04D883,x
CODE_04D873:
	STA.w SMB1_PaletteMirror[$B0].LowByte,x
	DEX
	DEX
	BPL.b CODE_04D864
	SEP.b #$20
	INC.w !RAM_SMB1_Global_UpdateEntirePaletteFlag
	JSR.w CODE_04D8C3
	RTL

DATA_04D883:
	dw $734E,$7FFF,$14A5,$5D68,$762E,$27BF,$31BB,$3ABF
	dw $0000,$152F,$355D,$525F,$169B,$1C9F,$0C19,$0C19

DATA_04D8A3:
	dw $734E,$7FFF,$14A5,$5588,$724D,$27BF,$31BB,$3ABF
	dw $0000,$152F,$355D,$525F,$169B,$3303,$1A40,$1C9F

;--------------------------------------------------------------------

; Note: Routine that writes the text in the ending.

CODE_04D8C3:
	PHB
	PHK
	PLB
	PHX
	LDA.b #$FF
	STA.w !RAM_SMB1_Global_CurrentLayer3XPosLo
	STZ.w !RAM_SMB1_Global_CurrentLayer3XPosHi
	STZ.w $0BA3
	LDA.b #$15
	STA.w !RAM_SMB1_Global_MainScreenLayersMirror
	LDA.b #$02
	STA.w !RAM_SMB1_Global_SubScreenLayersMirror
	REP.b #$10
	LDA.w !RAM_SMB1_Player_CurrentWorld
	PHA
	LDA.l !SRAM_SMB1_Cutscene_HeartEyesFlag
	BNE.b CODE_04D8F2
	LDA.w !RAM_SMB1_Player_HardModeActiveFlag
	BEQ.b CODE_04D8F2
	LDA.b #$0C
	STA.w !RAM_SMB1_Player_CurrentWorld
CODE_04D8F2:
	LDA.b #$00
	XBA
	LDA.w !RAM_SMB1_Player_CurrentCharacter
	ASL
	ASL
	STA.b $00
	LDA.w !RAM_SMB1_Player_CurrentWorld
	AND.b #$08
	LSR
	LSR
	ORA.b $00
	TAY
	PLA
	STA.w !RAM_SMB1_Player_CurrentWorld
	LDX.w DATA_04D926,y
	TXY
	LDX.w !RAM_SMB1_Global_StripeImageUploadIndexLo
CODE_04D911:
	LDA.w DATA_04D92E,y
	STA.w SMB1_StripeImageUploadTable[$00].LowByte,x
	INC
	BEQ.b CODE_04D91E
	INX
	INY
	BRA.b CODE_04D911

CODE_04D91E:
	STX.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	SEP.b #$10
	PLX
	PLB
	RTS

DATA_04D926:
	dw $0000,$00A4,$0156,$01FA

DATA_04D92E:									;\ Info: "THANK YOU"
	db $59,$05,$00,$11							;|
	db $1D,$20,$11,$20,$0A,$20,$17,$20,$14,$20,$28,$20,$22,$20,$18,$20	;|
	db $1E,$20								;|
										;|
	db $59,$45,$00,$0B							;| "MARIO!"
	db $16,$20,$0A,$20,$1B,$20,$12,$20,$18,$20,$26,$20			;|
										;|
	db $59,$85,$00,$15							;| "THE KINGDOM"
	db $1D,$20,$11,$20,$0E,$20,$28,$20,$14,$20,$12,$20,$17,$20,$10,$20	;|
	db $0D,$20,$18,$20,$16,$20						;|
										;|
	db $59,$C5,$00,$11							;| "IS SAVED!"
	db $12,$20,$1C,$20,$28,$20,$1C,$20,$0A,$20,$1F,$20,$0E,$20,$0D,$20	;|
	db $26,$20								;|
										;|
	db $5A,$05,$00,$0D							;| "NOW TRY"
	db $17,$20,$18,$20,$20,$20,$28,$20,$1D,$20,$1B,$20,$22,$20		;|
										;|
	db $5A,$45,$00,$0B							;| "A MORE"
	db $0A,$20,$28,$20,$16,$20,$18,$20,$1B,$20,$0E,$20			;|
										;|
	db $5A,$85,$00,$11							;| "DIFFICULT"
	db $0D,$20,$12,$20,$0F,$20,$0F,$20,$12,$20,$0C,$20,$1E,$20,$15,$20	;|
	db $1D,$20								;|
										;|
	db $5A,$C5,$00,$0F							;| "QUEST..."
	db $1A,$20,$1E,$20,$0E,$20,$1C,$20,$1D,$20,$29,$20,$29,$20,$29,$20	;|
										;|
	db $FF,$FF								;/

DATA_04D9D2:									;\ Info: "THANK YOU"
	db $59,$05,$00,$11							;|
	db $1D,$20,$11,$20,$0A,$20,$17,$20,$14,$20,$28,$20,$22,$20,$18,$20	;|
	db $1E,$20								;|
										;|
	db $59,$45,$00,$11							;| "MARIO FOR"
	db $16,$20,$0A,$20,$1B,$20,$12,$20,$18,$20,$28,$20,$0F,$20,$18,$20	;|
	db $1B,$20								;|
										;|
	db $59,$85,$00,$11							;| "RESTORING"
	db $1B,$20,$0E,$20,$1C,$20,$1D,$20,$18,$20,$1B,$20,$12,$20,$17,$20	;|
	db $10,$20								;|
										;|
	db $59,$C5,$00,$0F							;| "PEACE TO"
	db $19,$20,$0E,$20,$0A,$20,$0C,$20,$0E,$20,$28,$20,$1D,$20,$18,$20	;|
										;|
	db $5A,$05,$00,$05							;| "OUR"
	db $18,$20,$1E,$20,$1B,$20						;|
										;|
	db $5A,$45,$00,$0F							;| "KINGDOM."
	db $14,$20,$12,$20,$17,$20,$10,$20,$0D,$20,$18,$20,$16,$20,$29,$20	;|
										;|
	db $5A,$85,$00,$11							;| "HURRAH TO"
	db $11,$20,$1E,$20,$1B,$20,$1B,$20,$0A,$20,$11,$20,$28,$20,$1D,$20	;|
	db $18,$20								;|
										;|
	db $5A,$C5,$00,$11							;| "OUR HERO,"
	db $18,$20,$1E,$20,$1B,$20,$28,$20,$11,$20,$0E,$20,$1B,$20,$18,$20	;|
	db $2B,$20								;|
										;|
	db $5B,$05,$00,$0B							;| "MARIO!"
	db $16,$20,$0A,$20,$1B,$20,$12,$20,$18,$20,$26,$20			;|
										;|
	db $FF,$FF								;/

DATA_04DA84:									;\ Info: "THANK YOU"
	db $59,$05,$00,$11							;|
	db $1D,$20,$11,$20,$0A,$20,$17,$20,$14,$20,$28,$20,$22,$20,$18,$20	;|
	db $1E,$20								;|
										;|
	db $59,$45,$00,$0B							;| "LUIGI!"
	db $15,$20,$1E,$20,$12,$20,$10,$20,$12,$20,$26,$20			;|
										;|
	db $59,$85,$00,$15							;| "THE KINGDOM"
	db $1D,$20,$11,$20,$0E,$20,$28,$20,$14,$20,$12,$20,$17,$20,$10,$20	;|
	db $0D,$20,$18,$20,$16,$20						;|
										;|
	db $59,$C5,$00,$11							;| "IS SAVED!"
	db $12,$20,$1C,$20,$28,$20,$1C,$20,$0A,$20,$1F,$20,$0E,$20,$0D,$20	;|
	db $26,$20								;|
										;|
	db $5A,$05,$00,$0D							;| "NOW TRY"
	db $17,$20,$18,$20,$20,$20,$28,$20,$1D,$20,$1B,$20,$22,$20		;|
										;|
	db $5A,$45,$00,$0B							;| "A MORE"
	db $0A,$20,$28,$20,$16,$20,$18,$20,$1B,$20,$0E,$20			;|
										;|
	db $5A,$85,$00,$11							;| "DIFFICULT"
	db $0D,$20,$12,$20,$0F,$20,$0F,$20,$12,$20,$0C,$20,$1E,$20,$15,$20	;|
	db $1D,$20								;|
										;|
	db $5A,$C5,$00,$0F							;| "QUEST..."
	db $1A,$20,$1E,$20,$0E,$20,$1C,$20,$1D,$20,$29,$20,$29,$20,$29,$20	;|
										;|
	db $FF,$FF								;/

DATA_04DB28:									;\ Info: "THANK YOU"
	db $59,$05,$00,$11							;|
	db $1D,$20,$11,$20,$0A,$20,$17,$20,$14,$20,$28,$20,$22,$20,$18,$20	;|
	db $1E,$20								;|
										;|
	db $59,$45,$00,$11							;| "LUIGI FOR"
	db $15,$20,$1E,$20,$12,$20,$10,$20,$12,$20,$28,$20,$0F,$20,$18,$20	;|
	db $1B,$20								;|
										;|
	db $59,$85,$00,$11							;| "RESTORING"
	db $1B,$20,$0E,$20,$1C,$20,$1D,$20,$18,$20,$1B,$20,$12,$20,$17,$20	;|
	db $10,$20								;|
										;|
	db $59,$C5,$00,$0F							;| "PEACE TO"
	db $19,$20,$0E,$20,$0A,$20,$0C,$20,$0E,$20,$28,$20,$1D,$20,$18,$20	;|
										;|
	db $5A,$05,$00,$05							;| "OUR"
	db $18,$20,$1E,$20,$1B,$20						;|
										;|
	db $5A,$45,$00,$0F							;| "KINGDOM."
	db $14,$20,$12,$20,$17,$20,$10,$20,$0D,$20,$18,$20,$16,$20,$29,$20	;|
										;|
	db $5A,$85,$00,$11							;| "HURRAH TO"
	db $11,$20,$1E,$20,$1B,$20,$1B,$20,$0A,$20,$11,$20,$28,$20,$1D,$20	;|
	db $18,$20								;|
										;|
	db $5A,$C5,$00,$11							;| "OUR HERO,"
	db $18,$20,$1E,$20,$1B,$20,$28,$20,$11,$20,$0E,$20,$1B,$20,$18,$20	;|
	db $2B,$20								;|
										;|
	db $5B,$05,$00,$0B							;| "LUIGI!"
	db $15,$20,$1E,$20,$12,$20,$10,$20,$12,$20,$26,$20			;|
										;|
	db $FF,$FF								;/

;--------------------------------------------------------------------

CODE_04DBDA:
	PHX
	LDA.w $0F85
	BNE.b CODE_04DC1B
	LDA.l !SRAM_SMB1_Cutscene_HeartEyesFlag
	BEQ.b CODE_04DBE9
	LDA.w !RAM_SMB1_Player_CurrentCharacter
CODE_04DBE9:
	ASL
	ASL
	ASL
	ORA.w $0F84
	TAX
	INC.w $0F84
	LDA.w $0F84
	CMP.b #$03
	BNE.b CODE_04DC02
	LDA.b #$FF
	STA.w !RAM_SMB1_NorSpr_YSpeed
	STZ.w !RAM_SMB1_NorSpr_SubYSpeed
CODE_04DC02:
	LDA.l DATA_04DC3F,x
	BNE.b CODE_04DC11
	INC.w $0772
	STZ.w $0705
	STZ.w !RAM_SMB1_Player_XSpeed
CODE_04DC11:
	STA.w $0F85
	LDA.l DATA_04DC4F,x
	STA.w $0F86
CODE_04DC1B:
	DEC.w $0F85
	LDA.w $0F86
	AND.b #(!Joypad_A|(!Joypad_B>>8))>>4
	ASL
	ASL
	ASL
	ASL
	STA.b !RAM_SMB1_Global_CopyOfControllerABXYHeld
	LDY.w $0F86
	LDA.w !RAM_SMB1_Level_DisableScrollingFlag
	BEQ.b CODE_04DC3D
	LDA.w !RAM_SMB1_Player_XPosLo
	CMP.b #$A2
	BCC.b CODE_04DC3D
	LDA.b #$A2
	STA.w !RAM_SMB1_Player_XPosLo
CODE_04DC3D:
	PLX
	RTL

DATA_04DC3F:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	db $14,$A0,$08,$01,$1E,$10,$03,$00
	db $14,$A0,$08,$01,$14,$1E,$02,$00
else
	db $18,$A0,$08,$01,$28,$10,$03,$00
	db $10,$A0,$08,$01,$28,$1E,$02,$00
endif

DATA_04DC4F:
	db $01,$00,$41,$C1,$C9,$01,$01,$00
	db $01,$00,$41,$C1,$C9,$01,$01,$00

;--------------------------------------------------------------------

SMB1_ProcessPeachMovement:
.Main:
;$04DC5F
	DEC.w !RAM_SMB1_Cutscene_PeachStateTimer
	LDA.w !RAM_SMB1_Cutscene_PeachStateTimer
	BPL.b CODE_04DC7D
	INC.w !RAM_SMB1_Cutscene_PeachCurrentState
	LDX.w !RAM_SMB1_Cutscene_PeachCurrentState
	CPX.b #$05
	BNE.b CODE_04DC76
	LDA.b #$A0
	STA.w !RAM_SMB1_Player_XPosLo
CODE_04DC76:
	LDA.l DATA_04DCB4,x
	STA.w !RAM_SMB1_Cutscene_PeachStateTimer
CODE_04DC7D:
	LDA.w !RAM_SMB1_Cutscene_PeachCurrentState
	ASL
	TAX
	LDA.l DATA_04DC91,x
	STA.b $00
	LDA.l DATA_04DC91+$01,x
	STA.b $01
	JMP.w ($0000)

DATA_04DC91:
	dw CODE_04DC9F
	dw CODE_04DC9F
	dw CODE_04DC9F
	dw CODE_04DCB0
	dw CODE_04DCA0
	dw CODE_04DC9F
	dw CODE_04DC9F

;--------------------------------------------------------------------

CODE_04DC9F:
	RTL

;--------------------------------------------------------------------

CODE_04DCA0:
	LDA.b #$20
	STA.b $00
	LDA.b #$04
	STA.b $02
	LDA.b #$00
	LDX.b #$01
	JSL.l CODE_03C18F
CODE_04DCB0:
	DEC.w !RAM_SMB1_NorSpr_XPosLo
	RTL

;--------------------------------------------------------------------

DATA_04DCB4:
	db $00,$30,$37,$1A,$10,$60,$FF

;--------------------------------------------------------------------

CODE_04DCBB:
	PHX
	LDA.w $03AE
	CLC
	ADC.b #$07
	STA.w SMB1_OAMBuffer[$2C].XDisp
	STA.w SMB1_OAMBuffer[$2D].XDisp
	LDA.w $03B9
	STA.w SMB1_OAMBuffer[$2C].YDisp
	CLC
	ADC.b #$10
	STA.w SMB1_OAMBuffer[$2D].YDisp
	LDX.w !RAM_SMB1_Cutscene_PeachCurrentState
	CPX.b #$03
	BNE.b CODE_04DCE9
	LDA.b !RAM_SMB1_Global_FrameCounter
	AND.b #$04
	BNE.b CODE_04DCE9
	LDA.l DATA_04DD4E,x
	INC
	INC
	BRA.b CODE_04DCED

CODE_04DCE9:
	LDA.l DATA_04DD4E,x
CODE_04DCED:
	STA.w SMB1_OAMBuffer[$2C].Tile
	CLC
	ADC.b #$20
	STA.w SMB1_OAMBuffer[$2D].Tile
	LDA.b #$25
	STA.w SMB1_OAMBuffer[$2C].Prop
	STA.w SMB1_OAMBuffer[$2D].Prop
	LDA.w !RAM_SMB1_NorSpr_XPosLo
	CLC
	ADC.b #$07
	SEC
	SBC.w $0042
	LDA.w !RAM_SMB1_NorSpr_XPosHi
	SBC.w $0043
	ORA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$2C].Slot
	STA.w SMB1_OAMTileSizeBuffer[$2D].Slot
	LDX.w !RAM_SMB1_Level_SpriteOAMIndexTable+$13
	LDA.w SMB1_OAMBuffer[$00].Tile,x
	CMP.b #$F6
	BNE.b CODE_04DD28
	LDA.b #$F0
	STA.w SMB1_OAMBuffer[$00].YDisp,x
	STA.w SMB1_OAMBuffer[$01].YDisp,x
CODE_04DD28:
	LDA.b !RAM_SMB1_NorSpr_SpriteID+$09
	BEQ.b CODE_04DD4C
	LDA.b #$1C
	STA.w SMB1_OAMBuffer[$78].Prop
	STA.w SMB1_OAMBuffer[$79].Prop
	STA.w SMB1_OAMBuffer[$7A].Prop
	STA.w SMB1_OAMBuffer[$7B].Prop
	LDA.b #$80
	STA.w SMB1_OAMBuffer[$78].Tile
	INC
	STA.w SMB1_OAMBuffer[$79].Tile
	LDA.b #$90
	STA.w SMB1_OAMBuffer[$7A].Tile
	INC
	STA.w SMB1_OAMBuffer[$7B].Tile
CODE_04DD4C:
	PLX
	RTL

DATA_04DD4E:
	db $88,$88,$80,$82,$86,$86,$86

;--------------------------------------------------------------------

; Note: Routine that sets the graphics pointer to upload graphics during the ending.

CODE_04DD55:
	LDA.w $0F83
	CMP.b #$0A
	BCS.b CODE_04DD86
	PHB
	PHK
	PLB
	PHX
	ASL
	TAX
	INC.w $0F83
	LDA.w DATA_04DD87,x
	STA.w !RAM_SMB1_Global_GraphicsUploadPointerBank
	REP.b #$20
	LDA.w #$0800
	STA.w !RAM_SMB1_Global_GraphicsUploadSizeLo
	LDA.w DATA_04DDAF,x
	STA.w !RAM_SMB1_Global_GraphicsUploadVRAMAddressLo
	LDA.w DATA_04DD9B,x
	STA.w !RAM_SMB1_Global_GraphicsUploadPointerLo
	SEP.b #$20
	INC.w $0B76
	PLX
	PLB
CODE_04DD86:
	RTL

DATA_04DD87:
	dw SMB1_UncompressedGFX_BG_Castle>>16,SMB1_UncompressedGFX_Ending+$0100>>16,SMB1_UncompressedGFX_Ending+$0800>>16,SMB1_UncompressedGFX_Ending+$1000>>16
	dw SMB1_UncompressedGFX_Ending+$1800>>16,SMB1_UncompressedGFX_Ending+$2000>>16,SMB1_UncompressedGFX_Ending+$2800>>16,SMB1_UncompressedGFX_Sprite_PeachAndToad+$1000>>16
	dw SMB1_UncompressedGFX_Sprite_PeachAndToad+$1800>>16,SMB1_EndScreenTilemap>>16

DATA_04DD9B:
	dw SMB1_UncompressedGFX_BG_Castle,SMB1_UncompressedGFX_Ending+$0100,SMB1_UncompressedGFX_Ending+$0800,SMB1_UncompressedGFX_Ending+$1000
	dw SMB1_UncompressedGFX_Ending+$1800,SMB1_UncompressedGFX_Ending+$2000,SMB1_UncompressedGFX_Ending+$2800,SMB1_UncompressedGFX_Sprite_PeachAndToad+$1000
	dw SMB1_UncompressedGFX_Sprite_PeachAndToad+$1800,SMB1_EndScreenTilemap

DATA_04DDAF:
	dw $3000,$6080,$6400,$6800,$6C00,$7000,$7400,$7800
	dw $7C00,$0400

;--------------------------------------------------------------------

CODE_04DDC3:
	PHB
	PHK
	PLB
	PHX
	LDA.w $0F83
	ASL
	TAX
	INC.w $0F83
	LDA.w DATA_04DDF1,x
	STA.w !RAM_SMB1_Global_GraphicsUploadPointerBank
	REP.b #$20
	LDA.w #$0800
	STA.w !RAM_SMB1_Global_GraphicsUploadSizeLo
	LDA.w DATA_04DE19,x
	STA.w !RAM_SMB1_Global_GraphicsUploadVRAMAddressLo
	LDA.w DATA_04DE05,x
	STA.w !RAM_SMB1_Global_GraphicsUploadPointerLo
	SEP.b #$20
	INC.w $0B76
	PLX
	PLB
	RTL

DATA_04DDF1:
	dw SMB1_UncompressedGFX_BG_Castle>>16,SMB1_UncompressedGFX_Sprite_GlobalTiles+$0100>>16,SMB1_UncompressedGFX_Sprite_GlobalTiles+$0800>>16,SMB1_UncompressedGFX_Sprite_GlobalTiles+$1000>>16,SMB1_UncompressedGFX_Sprite_GlobalTiles+$1800>>16,SMB1_UncompressedGFX_Sprite_GlobalTiles+$2000>>16,SMB1_UncompressedGFX_Sprite_GlobalTiles+$2800>>16,SMB1_UncompressedGFX_Sprite_GlobalTiles+$3000>>16
	dw SMB1_UncompressedGFX_Sprite_GlobalTiles+$3800>>16,SMB1_UncompressedGFX_Sprite_GlobalTiles+$3800>>16

DATA_04DE05:
	dw SMB1_UncompressedGFX_BG_Castle,SMB1_UncompressedGFX_Sprite_GlobalTiles+$0100,SMB1_UncompressedGFX_Sprite_GlobalTiles+$0800,SMB1_UncompressedGFX_Sprite_GlobalTiles+$1000,SMB1_UncompressedGFX_Sprite_GlobalTiles+$1800,SMB1_UncompressedGFX_Sprite_GlobalTiles+$2000,SMB1_UncompressedGFX_Sprite_GlobalTiles+$2800,SMB1_UncompressedGFX_Sprite_GlobalTiles+$3000
	dw SMB1_UncompressedGFX_Sprite_GlobalTiles+$3800,SMB1_UncompressedGFX_Sprite_GlobalTiles+$3800

DATA_04DE19:
	dw $3000,$6080,$6400,$6800,$6C00,$7000,$7400,$7800
	dw $7C00,$7C00

;--------------------------------------------------------------------

SMB1_SpawnMushroomDuringPeachCutscene:
.Main:
;$04DE2D
	LDA.b #!Define_SMB1_SpriteID_NorSpr02E_Powerup
	STA.b !RAM_SMB1_NorSpr_SpriteID+$09
	LDA.b #$80
	STA.b $32
	LDA.b #$01
	STA.b $19
	LDA.b !RAM_SMB1_Player_XPosHi
	STA.b !RAM_SMB1_NorSpr_XPosHi+$09
	LDA.w !RAM_SMB1_Player_XPosLo
	STA.w !RAM_SMB1_NorSpr_XPosLo+$09
	LDA.b #$01
	STA.w !RAM_SMB1_NorSpr_YPosHi+$09				; Optimization: Unnecessary absolute addressing
	LDA.b #$18
	STA.w !RAM_SMB1_NorSpr_YPosLo+$09
	STZ.w $0067
	STZ.w !RAM_SMB1_NorSpr02E_Powerup_PowerupType
	RTL

;--------------------------------------------------------------------

CODE_04DE54:
	LDA.l !SRAM_SMB1_Cutscene_HeartEyesFlag
	BEQ.b CODE_04DE64
	LDA.w !RAM_SMB1_Player_CurrentWorld			;\ Optimization: This code does nothing.
	CMP.b #$08						;| This JMP can also be turned into a BRA
	BCC.b CODE_04DE7F					;|
	JMP.w CODE_04DE7F					;/

CODE_04DE64:
	LDA.w !RAM_SMB1_Player_CurrentWorld			;\ Optimization: This code does a whole lot of nothing.
	PHA							;|
	LDA.w $0E24						;|
	PHA							;|
	LDA.w !RAM_SMB1_Player_HardModeActiveFlag		;|
	BNE.b CODE_04DE77					;|
	STZ.w $0E24						;|
	STZ.w !RAM_SMB1_Player_CurrentWorld			;|
CODE_04DE77:							;|
	PLA							;|
	STA.w $0E24						;|
	PLA							;|
	STA.w !RAM_SMB1_Player_CurrentWorld			;/
CODE_04DE7F:
	LDA.b #$01
	STA.w $0F82
	STZ.w $0F83
	STZ.w $0717
	RTL

;--------------------------------------------------------------------

SMB1_PeachCutscene_State09_ProcessCloseupImage_Bank04:
;$04DE8B
	LDA.l !SRAM_SMB1_Cutscene_HeartEyesFlag
	BEQ.b CODE_04DE94
	JMP.w CODE_04DFBF

CODE_04DE94:
	PHB
	PHK
	PLB
	JSL.l CODE_04871F
	LDX.w !RAM_SMB1_Cutscene_PeachCloseUpAnimationFrame
	LDA.w $0F81
	CMP.w DATA_04E25D,x
	BCC.b CODE_04DEBD
	STZ.w $0F81
	INC.w !RAM_SMB1_Cutscene_PeachCloseUpAnimationFrame
	LDA.w !RAM_SMB1_Cutscene_PeachCloseUpAnimationFrame
	CMP.b #$08
	BCC.b CODE_04DEBD
	BNE.b CODE_04DEB8
	STZ.w $0F89
CODE_04DEB8:
	LDA.b #$08
	STA.w !RAM_SMB1_Cutscene_PeachCloseUpAnimationFrame
CODE_04DEBD:
	INC.w $0F81
	LDA.b #$00
	XBA
	LDA.w !RAM_SMB1_Cutscene_PeachCloseUpAnimationFrame
	ASL
	REP.b #$10
	TAY
	LDX.w DATA_04E2B4,y
	STX.b !RAM_SMB1_Global_ScratchRAMED
	LDX.w DATA_04E280,y
	LDY.w #$0004
CODE_04DED5:
	LDA.w DATA_04E2FA,x
	CMP.b #$FF
	BEQ.b CODE_04DF15
	CLC
	ADC.b #$80
	STA.w SMB1_OAMBuffer[$00].YDisp,y
	INX
	LDA.w DATA_04E2FA,x
	CLC
	ADC.b #$C0
	STA.w SMB1_OAMBuffer[$00].XDisp,y
	INX
	LDA.w DATA_04E2FA,x
	STA.w SMB1_OAMBuffer[$00].Tile,y
	INX
	STZ.b $00
	CMP.b #$80
	BCS.b CODE_04DEFF
	LDA.w !RAM_SMB1_Player_CurrentCharacter
	STA.b $00
CODE_04DEFF:
	LDA.w DATA_04E2FA,x
	ORA.b $00
	ORA.b #$20
	STA.w SMB1_OAMBuffer[$00].Prop,y
	INX
	LDA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot,y
	INY
	INY
	INY
	INY
	BRA.b CODE_04DED5

CODE_04DF15:
	LDX.b !RAM_SMB1_Global_ScratchRAMED
CODE_04DF17:
	LDA.w DATA_04E2FA,x
	CMP.b #$FF
	BEQ.b CODE_04DF64
	CLC
	ADC.b #$80
	STA.w SMB1_OAMBuffer[$00].YDisp,y
	INX
	LDA.w DATA_04E2FA,x
	CLC
	ADC.b #$C0
	CLC
	ADC.w !RAM_SMB1_Player_CurrentCharacter
	ADC.w !RAM_SMB1_Player_CurrentCharacter
	ADC.w !RAM_SMB1_Player_CurrentCharacter
	ADC.w !RAM_SMB1_Player_CurrentCharacter
	STA.w SMB1_OAMBuffer[$00].XDisp,y
	INX
	LDA.w DATA_04E2FA,x
	STA.w SMB1_OAMBuffer[$00].Tile,y
	INX
	STZ.b $00
	CMP.b #$80
	BCS.b CODE_04DF4E
	LDA.w !RAM_SMB1_Player_CurrentCharacter
	STA.b $00
CODE_04DF4E:
	LDA.w DATA_04E2FA,x
	ORA.b $00
	ORA.b #$20
	STA.w SMB1_OAMBuffer[$00].Prop,y
	INX
	LDA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot,y
	INY
	INY
	INY
	INY
	BRA.b CODE_04DF17

CODE_04DF64:
	LDA.w !RAM_SMB1_Cutscene_PeachCloseUpAnimationFrame
	CMP.b #$08
	BNE.b CODE_04DFB8
	SEP.b #$10
	JSR.w CODE_04FD43
	LDA.w $0F89
	LSR
	LSR
	LSR
	AND.b #$03
	TAX
	LDA.l DATA_04E259,x
	CLC
	ADC.b #$B0
	STA.w SMB1_OAMBuffer[$00].XDisp
	LDA.w $0F89
	LSR
	LSR
	STA.b $00
	LDA.b #$60
	SEC
	SBC.b $00
	STA.w SMB1_OAMBuffer[$00].YDisp
	LDA.w $0F89
	LSR
	LSR
	LSR
	LSR
	LSR
	AND.b #$03
	TAX
	LDA.l DATA_04E255,x
	STA.w SMB1_OAMBuffer[$00].Tile
	LDA.b #$26
	STA.w SMB1_OAMBuffer[$00].Prop
	LDA.b #$00
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot
	INC.w $0F89
	CPX.b #$03
	BNE.b CODE_04DFB8
	STZ.w $0F89
CODE_04DFB8:
	SEP.b #$10
	JSR.w CODE_04E221
	PLB
	RTL

CODE_04DFBF:
	LDA.w !RAM_SMB1_Player_CurrentWorld
	CMP.b #$08
	BCC.b CODE_04DFC9
	JMP.w CODE_04E0F6

CODE_04DFC9:
	PHB
	PHK
	PLB
	JSL.l CODE_04871F
	LDX.w !RAM_SMB1_Cutscene_PeachCloseUpAnimationFrame
	LDA.w $0F81
	CMP.w DATA_04E266,x
	BCC.b CODE_04DFF4
	STZ.w $0F81
	INC.w !RAM_SMB1_Cutscene_PeachCloseUpAnimationFrame
	LDA.w !RAM_SMB1_Cutscene_PeachCloseUpAnimationFrame
	CMP.b #$05
	BNE.b CODE_04DFEB
	STZ.w $0F89
CODE_04DFEB:
	CMP.b #$0F
	BCC.b CODE_04DFF4
	LDA.b #$06
	STA.w !RAM_SMB1_Cutscene_PeachCloseUpAnimationFrame
CODE_04DFF4:
	INC.w $0F81
	LDA.b #$00
	XBA
	LDA.w !RAM_SMB1_Cutscene_PeachCloseUpAnimationFrame
	ASL
	REP.b #$10
	TAY
	LDX.w DATA_04E2C6,y
	STX.b !RAM_SMB1_Global_ScratchRAMED
	LDX.w DATA_04E280,y
	LDY.w #$0004
CODE_04E00C:
	LDA.w DATA_04E2FA,x
	CMP.b #$FF
	BEQ.b CODE_04E04C
	CLC
	ADC.b #$80
	STA.w SMB1_OAMBuffer[$00].YDisp,y
	INX
	LDA.w DATA_04E2FA,x
	CLC
	ADC.b #$C0
	STA.w SMB1_OAMBuffer[$00].XDisp,y
	INX
	LDA.w DATA_04E2FA,x
	STA.w SMB1_OAMBuffer[$00].Tile,y
	INX
	STZ.b $00
	CMP.b #$80
	BCS.b CODE_04E036
	LDA.w !RAM_SMB1_Player_CurrentCharacter
	STA.b $00
CODE_04E036:
	LDA.w DATA_04E2FA,x
	ORA.b $00
	ORA.b #$20
	STA.w SMB1_OAMBuffer[$00].Prop,y
	INX
	LDA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot,y
	INY
	INY
	INY
	INY
	BRA.b CODE_04E00C

CODE_04E04C:
	LDX.b !RAM_SMB1_Global_ScratchRAMED
CODE_04E04E:
	LDA.w DATA_04E2FA,x
	CMP.b #$FF
	BEQ.b CODE_04E09B
	CLC
	ADC.b #$80
	STA.w SMB1_OAMBuffer[$00].YDisp,y
	INX
	LDA.w DATA_04E2FA,x
	CLC
	ADC.b #$C0
	CLC
	ADC.w !RAM_SMB1_Player_CurrentCharacter
	ADC.w !RAM_SMB1_Player_CurrentCharacter
	ADC.w !RAM_SMB1_Player_CurrentCharacter
	ADC.w !RAM_SMB1_Player_CurrentCharacter
	STA.w SMB1_OAMBuffer[$00].XDisp,y
	INX
	LDA.w DATA_04E2FA,x
	STA.w SMB1_OAMBuffer[$00].Tile,y
	INX
	STZ.b $00
	CMP.b #$80
	BCS.b CODE_04E085
	LDA.w !RAM_SMB1_Player_CurrentCharacter
	STA.b $00
CODE_04E085:
	LDA.w DATA_04E2FA,x
	ORA.b $00
	ORA.b #$20
	STA.w SMB1_OAMBuffer[$00].Prop,y
	INX
	LDA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot,y
	INY
	INY
	INY
	INY
	BRA.b CODE_04E04E

CODE_04E09B:
	LDA.w !RAM_SMB1_Cutscene_PeachCloseUpAnimationFrame
	CMP.b #$06
	BCC.b CODE_04E0EF
	SEP.b #$10
	JSR.w CODE_04FD43
	LDA.w $0F89
	LSR
	LSR
	LSR
	AND.b #$03
	TAX
	LDA.l DATA_04E259,x
	CLC
	ADC.b #$B0
	STA.w SMB1_OAMBuffer[$00].XDisp
	LDA.w $0F89
	LSR
	LSR
	STA.b $00
	LDA.b #$60
	SEC
	SBC.b $00
	STA.w SMB1_OAMBuffer[$00].YDisp
	LDA.w $0F89
	LSR
	LSR
	LSR
	LSR
	LSR
	AND.b #$03
	TAX
	LDA.l DATA_04E255,x
	STA.w SMB1_OAMBuffer[$00].Tile
	LDA.b #$26
	STA.w SMB1_OAMBuffer[$00].Prop
	LDA.b #$00
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot
	INC.w $0F89
	CPX.b #$03
	BNE.b CODE_04E0EF
	STZ.w $0F89
CODE_04E0EF:
	SEP.b #$10
	JSR.w CODE_04E221
	PLB
	RTL

CODE_04E0F6:
	PHB
	PHK
	PLB
	JSL.l CODE_04871F
	LDX.w !RAM_SMB1_Cutscene_PeachCloseUpAnimationFrame
	LDA.w $0F81
	CMP.w DATA_04E276,x
	BCC.b CODE_04E11F
	STZ.w $0F81
	INC.w !RAM_SMB1_Cutscene_PeachCloseUpAnimationFrame
	LDA.w !RAM_SMB1_Cutscene_PeachCloseUpAnimationFrame
	CMP.b #$09
	BCC.b CODE_04E11F
	BNE.b CODE_04E11A
	STZ.w $0F89
CODE_04E11A:
	LDA.b #$09
	STA.w !RAM_SMB1_Cutscene_PeachCloseUpAnimationFrame
CODE_04E11F:
	INC.w $0F81
	LDA.b #$00
	XBA
	LDA.w !RAM_SMB1_Cutscene_PeachCloseUpAnimationFrame
	ASL
	REP.b #$10
	TAY
	LDX.w DATA_04E2E6,y
	STX.b !RAM_SMB1_Global_ScratchRAMED
	LDX.w DATA_04E2A0,y
	LDY.w #$0004
CODE_04E137:
	LDA.w DATA_04E2FA,x
	CMP.b #$FF
	BEQ.b CODE_04E177
	CLC
	ADC.b #$80
	STA.w SMB1_OAMBuffer[$00].YDisp,y
	INX
	LDA.w DATA_04E2FA,x
	CLC
	ADC.b #$C0
	STA.w SMB1_OAMBuffer[$00].XDisp,y
	INX
	LDA.w DATA_04E2FA,x
	STA.w SMB1_OAMBuffer[$00].Tile,y
	INX
	STZ.b $00
	CMP.b #$80
	BCS.b CODE_04E161
	LDA.w !RAM_SMB1_Player_CurrentCharacter
	STA.b $00
CODE_04E161:
	LDA.w DATA_04E2FA,x
	ORA.b $00
	ORA.b #$20
	STA.w SMB1_OAMBuffer[$00].Prop,y
	INX
	LDA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot,y
	INY
	INY
	INY
	INY
	BRA.b CODE_04E137

CODE_04E177:
	LDX.b !RAM_SMB1_Global_ScratchRAMED
CODE_04E179:
	LDA.w DATA_04E2FA,x
	CMP.b #$FF
	BEQ.b CODE_04E1C6
	CLC
	ADC.b #$80
	STA.w SMB1_OAMBuffer[$00].YDisp,y
	INX
	LDA.w DATA_04E2FA,x
	CLC
	ADC.b #$C0
	CLC
	ADC.w !RAM_SMB1_Player_CurrentCharacter
	ADC.w !RAM_SMB1_Player_CurrentCharacter
	ADC.w !RAM_SMB1_Player_CurrentCharacter
	ADC.w !RAM_SMB1_Player_CurrentCharacter
	STA.w SMB1_OAMBuffer[$00].XDisp,y
	INX
	LDA.w DATA_04E2FA,x
	STA.w SMB1_OAMBuffer[$00].Tile,y
	INX
	STZ.b $00
	CMP.b #$80
	BCS.b CODE_04E1B0
	LDA.w !RAM_SMB1_Player_CurrentCharacter
	STA.b $00
CODE_04E1B0:
	LDA.w DATA_04E2FA,x
	ORA.b $00
	ORA.b #$20
	STA.w SMB1_OAMBuffer[$00].Prop,y
	INX
	LDA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot,y
	INY
	INY
	INY
	INY
	BRA.b CODE_04E179

CODE_04E1C6:
	LDA.w !RAM_SMB1_Cutscene_PeachCloseUpAnimationFrame
	CMP.b #$09
	BNE.b CODE_04E21A
	SEP.b #$10
	JSR.w CODE_04FD43
	LDA.w $0F89
	LSR
	LSR
	LSR
	AND.b #$03
	TAX
	LDA.l DATA_04E259,x
	CLC
	ADC.b #$B0
	STA.w SMB1_OAMBuffer[$00].XDisp
	LDA.w $0F89
	LSR
	LSR
	STA.b $00
	LDA.b #$60
	SEC
	SBC.b $00
	STA.w SMB1_OAMBuffer[$00].YDisp
	LDA.w $0F89
	LSR
	LSR
	LSR
	LSR
	LSR
	AND.b #$03
	TAX
	LDA.l DATA_04E255,x
	STA.w SMB1_OAMBuffer[$00].Tile
	LDA.b #$26
	STA.w SMB1_OAMBuffer[$00].Prop
	LDA.b #$00
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot
	INC.w $0F89
	CPX.b #$03
	BNE.b CODE_04E21A
	STZ.w $0F89
CODE_04E21A:
	SEP.b #$10
	JSR.w CODE_04E221
	PLB
	RTL

CODE_04E221:
	LDA.w !RAM_SMB1_Player_CurrentCharacter
	BEQ.b CODE_04E254
	LDA.w SMB1_OAMBuffer[$01].Tile
	CMP.b #$EE
	BNE.b CODE_04E254
	LDA.w SMB1_OAMBuffer[$01].XDisp
	DEC
	DEC
	STA.w SMB1_OAMBuffer[$01].XDisp
	STA.w SMB1_OAMBuffer[$02].XDisp
	LDA.b #$82
	STA.w SMB1_OAMBuffer[$01].Tile
	INC
	STA.w SMB1_OAMBuffer[$02].Tile
	LDA.w SMB1_OAMBuffer[$01].XDisp
	CLC
	ADC.b #$08
	STA.w SMB1_OAMBuffer[$02].XDisp
	LDA.b #$85
	STA.w SMB1_OAMBuffer[$03].Tile
	LDA.b #$89
	STA.w SMB1_OAMBuffer[$04].Tile
CODE_04E254:
	RTS

DATA_04E255:
	db $5F,$5E,$5D,$5C

DATA_04E259:
	db $00,$02,$00,$FE

DATA_04E25D:
	db $50,$30,$08,$08,$20,$20,$08,$08
	db $FF

DATA_04E266:
	db $50,$30,$08,$08,$20,$20,$08,$08
	db $0C,$08,$08,$0C,$08,$08,$0C,$FF

DATA_04E276:
	db $60,$08,$08,$10,$14,$10,$14,$10
	db $14,$FF

DATA_04E280:
	dw $0000,$008A,$011C,$01AE,$0244,$02D2,$0360,$045F
	dw $055E,$055E,$055E,$055E,$055E,$055E,$055E,$055E

DATA_04E2A0:
	dw $06BE,$0789,$07CE,$06FF,$0744,$06FF,$0744,$06FF
	dw $0744,$06FF

DATA_04E2B4:
	dw $0041,$00CB,$015D,$01F3,$0289,$0317,$03A5,$04A4
	dw $05A3

DATA_04E2C6:
	dw $0041,$00CB,$015D,$01F3,$0289,$0317,$03F6,$04F5
	dw $05F4,$03F6,$04F5,$05F4,$03F6,$04F5,$05F4,$065D

DATA_04E2E6:
	dw $0813,$091E,$0977,$086C,$08C5,$086C,$08C5,$086C
	dw $08C5,$086C

DATA_04E2FA:
.Peach_Frame00:
	db $E8,$EC,$A0,$06,$E8,$FC,$A2,$06,$E8,$0C,$A4,$06,$F8,$EC,$C0,$06
	db $F8,$FC,$C2,$06,$F8,$0C,$C4,$06,$08,$EC,$E0,$06,$08,$FC,$E2,$06
	db $08,$0C,$E4,$06,$10,$CC,$8D,$06,$10,$D4,$8E,$06,$10,$E4,$AC,$06
	db $10,$F4,$AE,$06,$18,$F4,$CC,$06,$18,$04,$CE,$06,$18,$14,$EC,$06
	db $FF

	db $D8,$D0,$0A,$06,$D8,$E0,$08,$06,$E8,$C0,$28,$06,$E8,$D0,$2A,$06
	db $E8,$E0,$2A,$46,$E8,$F0,$28,$46,$F8,$C0,$48,$06,$F8,$D0,$4A,$06
	db $F8,$E0,$4A,$46,$F8,$F0,$48,$46,$08,$C0,$68,$06,$08,$D0,$6A,$06
	db $08,$E0,$6A,$46,$08,$F0,$68,$46,$18,$C0,$6E,$46,$18,$D0,$6C,$46
	db $18,$E0,$6C,$06,$18,$F0,$6E,$06,$FF

.Peach_Frame01:
	db $E8,$EC,$A0,$06,$E8,$FC,$A2,$06,$E8,$0C,$A4,$06,$F8,$EC,$C0,$06
	db $F8,$FC,$C2,$06,$F8,$0C,$C4,$06,$08,$EC,$E0,$06,$08,$FC,$E2,$06
	db $08,$0C,$E4,$06,$10,$CC,$8D,$06,$10,$D4,$8E,$06,$10,$E4,$AC,$06
	db $10,$F4,$AE,$06,$18,$F4,$CC,$06,$18,$04,$CE,$06,$18,$14,$EC,$06
	db $FF

	db $F0,$D0,$14,$06,$F0,$E0,$16,$06,$D8,$D0,$0A,$06,$D8,$E0,$08,$06
	db $E8,$C0,$28,$06,$E8,$D0,$2A,$06,$E8,$E0,$2A,$46,$E8,$F0,$28,$46
	db $F8,$C0,$48,$06,$F8,$D0,$4A,$06,$F8,$E0,$4A,$46,$F8,$F0,$48,$46
	db $08,$C0,$68,$06,$08,$D0,$6A,$06,$08,$E0,$6A,$46,$08,$F0,$68,$46
	db $18,$C0,$6E,$46,$18,$D0,$6C,$46,$18,$E0,$6C,$06,$18,$F0,$6E,$06
	db $FF

.Peach_Frame02:
	db $E8,$EB,$A0,$06,$E8,$FB,$A2,$06,$E8,$0B,$A4,$06,$F8,$EB,$C0,$06
	db $F8,$FB,$C2,$06,$F8,$0B,$C4,$06,$08,$EB,$E0,$06,$08,$FB,$E2,$06
	db $08,$0B,$E4,$06,$10,$CB,$8D,$06,$10,$D3,$8E,$06,$10,$E3,$AC,$06
	db $10,$F3,$AE,$06,$18,$F3,$CC,$06,$18,$03,$CE,$06,$18,$13,$EC,$06
	db $FF

	db $F0,$D0,$14,$06,$F0,$E0,$16,$06,$D8,$D0,$0A,$06,$D8,$E0,$08,$06
	db $E8,$C0,$28,$06,$E8,$D0,$2A,$06,$E8,$E0,$2A,$46,$E8,$F0,$28,$46
	db $F8,$C0,$48,$06,$F8,$D0,$4A,$06,$F8,$E0,$4A,$46,$F8,$F0,$48,$46
	db $08,$C0,$68,$06,$08,$D0,$6A,$06,$08,$E0,$6A,$46,$08,$F0,$68,$46
	db $18,$C0,$6E,$46,$18,$D0,$6C,$46,$18,$E0,$6C,$06,$18,$F0,$6E,$06
	db $FF

.Peach_Frame03:
	db $00,$D5,$EE,$06,$00,$D5,$EE,$06,$10,$DB,$88,$06,$10,$E2,$89,$06
	db $E8,$EA,$A0,$06,$E8,$FA,$A2,$06,$E8,$0A,$A4,$06,$F8,$EA,$C0,$06
	db $F8,$FA,$C2,$06,$F8,$0A,$C4,$06,$08,$EA,$E0,$06,$08,$FA,$E2,$06
	db $08,$0A,$E4,$06,$10,$F2,$8B,$06,$18,$F2,$CC,$06,$18,$02,$CE,$06
	db $18,$12,$EC,$06,$FF

	db $F0,$D0,$14,$06,$F0,$E0,$16,$06,$D8,$D0,$0A,$06,$D8,$E0,$08,$06
	db $E8,$C0,$28,$06,$E8,$D0,$2A,$06,$E8,$E0,$2A,$46,$E8,$F0,$28,$46
	db $F8,$C0,$48,$06,$F8,$D0,$4A,$06,$F8,$E0,$4A,$46,$F8,$F0,$48,$46
	db $08,$C0,$68,$06,$08,$D0,$6A,$06,$08,$E0,$6A,$46,$08,$F0,$68,$46
	db $18,$C0,$6E,$46,$18,$D0,$6C,$46,$18,$E0,$6C,$06,$18,$F0,$6E,$06
	db $FF

.Peach_Frame04:
	db $00,$D4,$EE,$06,$00,$D4,$EE,$06,$10,$DA,$88,$06,$10,$E1,$89,$06
	db $E8,$E9,$A0,$06,$E8,$F9,$A2,$06,$E8,$09,$A4,$06,$F8,$E9,$C0,$06
	db $F8,$F9,$C2,$06,$F8,$09,$C4,$06,$08,$E9,$E0,$06,$08,$F9,$E2,$06
	db $08,$09,$E4,$06,$10,$F1,$8B,$06,$18,$F1,$CC,$06,$18,$01,$CE,$06
	db $18,$11,$EC,$06,$FF

	db $D8,$D0,$0A,$06,$D8,$E0,$08,$06,$E8,$C0,$28,$06,$E8,$D0,$2A,$06
	db $E8,$E0,$2A,$46,$E8,$F0,$28,$46,$F8,$C0,$48,$06,$F8,$D0,$4A,$06
	db $F8,$E0,$4A,$46,$F8,$F0,$48,$46,$08,$C0,$68,$06,$08,$D0,$6A,$06
	db $08,$E0,$6A,$46,$08,$F0,$68,$46,$18,$C0,$6E,$46,$18,$D0,$6C,$46
	db $18,$E0,$6C,$06,$18,$F0,$6E,$06,$FF

.Peach_Frame05:
	db $00,$D3,$EE,$06,$00,$D3,$EE,$06,$10,$D9,$88,$06,$10,$E0,$89,$06
	db $E8,$E8,$A6,$06,$E8,$F8,$A8,$06,$E8,$08,$AA,$06,$F8,$E8,$C6,$06
	db $F8,$F8,$C8,$06,$F8,$08,$CA,$06,$08,$E8,$E6,$06,$08,$F8,$E8,$06
	db $08,$08,$EA,$06,$10,$F0,$8B,$06,$18,$F0,$CC,$06,$18,$00,$CE,$06
	db $18,$10,$EC,$06,$FF

	db $D8,$D0,$0A,$06,$D8,$E0,$08,$06,$E8,$C0,$28,$06,$E8,$D0,$2A,$06
	db $E8,$E0,$2A,$46,$E8,$F0,$28,$46,$F8,$C0,$48,$06,$F8,$D0,$4A,$06
	db $F8,$E0,$4A,$46,$F8,$F0,$48,$46,$08,$C0,$68,$06,$08,$D0,$6A,$06
	db $08,$E0,$6A,$46,$08,$F0,$68,$46,$18,$C0,$6E,$46,$18,$D0,$6C,$46
	db $18,$E0,$6C,$06,$18,$F0,$6E,$06,$FF

.Peach_Frame06:
	db $00,$D3,$EE,$06,$00,$D3,$EE,$06,$10,$D9,$88,$06,$10,$E0,$89,$06
	db $E8,$E8,$A6,$06,$E8,$F8,$A8,$06,$E8,$08,$AA,$06,$F8,$E8,$C6,$06
	db $F8,$F8,$C8,$06,$F8,$08,$CA,$06,$08,$E8,$E6,$06,$08,$F8,$E8,$06
	db $08,$08,$EA,$06,$10,$F0,$8B,$06,$18,$F0,$CC,$06,$18,$00,$CE,$06
	db $18,$10,$EC,$06,$FF

	db $D8,$D0,$0A,$06,$D8,$E0,$08,$06,$E8,$C0,$28,$06,$E8,$D0,$0E,$06
	db $E8,$E0,$0E,$46,$00,$D0,$3E,$06,$00,$E0,$3E,$46,$E8,$F0,$28,$46
	db $F8,$C0,$48,$06,$F8,$D0,$2E,$06,$F8,$E0,$2E,$46,$F8,$F0,$48,$46
	db $08,$C0,$68,$06,$08,$D0,$6A,$06,$08,$E0,$6A,$46,$08,$F0,$68,$46
	db $18,$C0,$6E,$46,$18,$D0,$6C,$46,$18,$E0,$6C,$06,$18,$F0,$6E,$06
	db $FF

.Peach_Frame07:
	db $F0,$D0,$42,$06,$F0,$E0,$42,$46,$D8,$D0,$0A,$06,$D8,$E0,$08,$06
	db $E8,$C0,$28,$06,$E8,$D0,$0C,$06,$E8,$D0,$2A,$06,$E8,$E0,$0C,$46
	db $E8,$E0,$2A,$46,$E8,$F0,$28,$46,$F8,$C0,$48,$06,$F8,$D0,$2C,$06
	db $F8,$D0,$4A,$06,$F8,$E0,$2C,$46,$F8,$E0,$4A,$46,$F8,$F0,$48,$46
	db $00,$D0,$60,$06,$00,$E0,$60,$46,$08,$C0,$68,$06,$08,$D0,$6A,$06
	db $08,$E0,$6A,$46,$08,$F0,$68,$46,$18,$C0,$6E,$46,$18,$D0,$6C,$46
	db $18,$E0,$6C,$06,$18,$F0,$6E,$06,$FF

	db $00,$D3,$EE,$06,$00,$D3,$EE,$06,$10,$D9,$88,$06,$10,$E0,$89,$06
	db $E8,$E8,$A6,$06,$E8,$F8,$A8,$06,$E8,$08,$AA,$06,$F8,$E8,$C6,$06
	db $F8,$F8,$C8,$06,$F8,$08,$CA,$06,$08,$E8,$E6,$06,$08,$F8,$E8,$06
	db $08,$08,$EA,$06,$10,$F0,$8B,$06,$18,$F0,$CC,$06,$18,$00,$CE,$06
	db $18,$10,$EC,$06,$FF

.Peach_Frame08:
	db $D8,$D0,$0A,$06,$D8,$E0,$08,$06,$E8,$C0,$28,$06,$00,$D0,$3C,$06
	db $00,$E0,$3C,$46,$E8,$D0,$0C,$06,$E8,$E0,$0C,$46,$E8,$F0,$28,$46
	db $F8,$C0,$48,$06,$F8,$D0,$2C,$06,$F8,$E0,$2C,$46,$F8,$F0,$48,$46
	db $08,$C0,$68,$06,$08,$D0,$6A,$06,$08,$E0,$6A,$46,$08,$F0,$68,$46
	db $18,$C0,$6E,$46,$18,$D0,$6C,$46,$18,$E0,$6C,$06,$18,$F0,$6E,$06
	db $FF

	db $F0,$D0,$62,$06,$F0,$E0,$62,$46,$D8,$D0,$0A,$06,$D8,$E0,$08,$06
	db $E8,$C0,$28,$06,$E8,$D0,$0C,$06,$E8,$D0,$2A,$06,$E8,$E0,$0C,$46
	db $E8,$E0,$2A,$46,$E8,$F0,$28,$46,$F8,$C0,$48,$06,$F8,$D0,$2C,$06
	db $F8,$D0,$4A,$06,$F8,$E0,$2C,$46,$F8,$E0,$4A,$46,$F8,$F0,$48,$46
	db $00,$D0,$60,$06,$00,$E0,$60,$46,$08,$C0,$68,$06,$08,$D0,$6A,$06
	db $08,$E0,$6A,$46,$08,$F0,$68,$46,$18,$C0,$6E,$46,$18,$D0,$6C,$46
	db $18,$E0,$6C,$06,$18,$F0,$6E,$06,$FF

	db $00,$D3,$EE,$06,$00,$D3,$EE,$06,$10,$D9,$88,$06,$10,$E0,$89,$06
	db $E8,$E8,$A6,$06,$E8,$F8,$A8,$06,$E8,$08,$AA,$06,$F8,$E8,$C6,$06
	db $F8,$F8,$C8,$06,$F8,$08,$CA,$06,$08,$E8,$E6,$06,$08,$F8,$E8,$06
	db $08,$08,$EA,$06,$10,$F0,$8B,$06,$18,$F0,$CC,$06,$18,$00,$CE,$06
	db $18,$10,$EC,$06,$FF

	db $D8,$D0,$0A,$06,$D8,$E0,$08,$06,$E8,$C0,$28,$06,$E8,$D0,$0C,$06
	db $E8,$E0,$0C,$46,$00,$D0,$3C,$06,$00,$E0,$3C,$46,$E8,$F0,$28,$46
	db $F8,$C0,$48,$06,$F8,$D0,$2C,$06,$F8,$E0,$2C,$46,$F8,$F0,$48,$46
	db $08,$C0,$68,$06,$08,$D0,$6A,$06,$08,$E0,$6A,$46,$08,$F0,$68,$46
	db $18,$C0,$6E,$46,$18,$D0,$6C,$46,$18,$E0,$6C,$06,$18,$F0,$6E,$06
	db $FF

	db $F0,$D0,$40,$06,$F0,$E0,$40,$46,$D8,$D0,$0A,$06,$D8,$E0,$08,$06
	db $E8,$C0,$28,$06,$E8,$D0,$0C,$06,$E8,$D0,$2A,$06,$E8,$E0,$0C,$46
	db $E8,$E0,$2A,$46,$E8,$F0,$28,$46,$F8,$C0,$48,$06,$F8,$D0,$2C,$06
	db $F8,$D0,$4A,$06,$F8,$E0,$2C,$46,$F8,$E0,$4A,$46,$F8,$F0,$48,$46
	db $00,$D0,$60,$06,$00,$E0,$60,$46,$08,$C0,$68,$06,$08,$D0,$6A,$06
	db $08,$E0,$6A,$46,$08,$F0,$68,$46,$18,$C0,$6E,$46,$18,$D0,$6C,$46
	db $18,$E0,$6C,$06,$18,$F0,$6E,$06,$FF

	db $D8,$D0,$0A,$06,$D8,$E0,$08,$06,$E8,$C0,$28,$06,$E8,$D0,$0C,$06
	db $E8,$D0,$2A,$06,$E8,$E0,$0C,$46,$E8,$E0,$2A,$46,$E8,$F0,$28,$46
	db $F8,$C0,$48,$06,$F8,$D0,$2C,$06,$F8,$D0,$4A,$06,$F8,$E0,$2C,$46
	db $F8,$E0,$4A,$46,$F8,$F0,$48,$46,$00,$D0,$60,$06,$00,$E0,$60,$46
	db $08,$C0,$68,$06,$08,$D0,$6A,$06,$08,$E0,$6A,$46,$08,$F0,$68,$46
	db $18,$C0,$6E,$46,$18,$D0,$6C,$46,$18,$E0,$6C,$06,$18,$F0,$6E,$06
	db $FF

	db $E8,$EA,$A0,$06,$E8,$FA,$A2,$06,$E8,$0A,$A4,$06,$F8,$EA,$C0,$06
	db $F8,$FA,$C2,$06,$F8,$0A,$C4,$06,$08,$EA,$E0,$06,$08,$FA,$E2,$06
	db $08,$0A,$E4,$06,$10,$CA,$8D,$06,$10,$D2,$8E,$06,$10,$E2,$AC,$06
	db $10,$F2,$AE,$06,$18,$F2,$CC,$06,$18,$02,$CE,$06,$18,$12,$EC,$06
	db $FF

	db $00,$D2,$EE,$06,$00,$D2,$EE,$06,$10,$D8,$88,$06,$10,$E0,$89,$06
	db $E8,$E8,$A6,$06,$E8,$F8,$A8,$06,$E8,$08,$AA,$06,$F8,$E8,$C6,$06
	db $F8,$F8,$C8,$06,$F8,$08,$CA,$06,$08,$E8,$E6,$06,$08,$F8,$E8,$06
	db $08,$08,$EA,$06,$10,$F0,$8B,$06,$18,$F0,$CC,$06,$18,$00,$CE,$06
	db $18,$10,$EC,$06,$FF

	db $00,$D2,$EE,$06,$00,$D2,$EE,$06,$10,$D8,$88,$06,$10,$E0,$89,$06
	db $E8,$E8,$A0,$06,$E8,$F8,$A2,$06,$E8,$08,$A4,$06,$F8,$E8,$C0,$06
	db $F8,$F8,$C2,$06,$F8,$08,$C4,$06,$08,$E8,$E0,$06,$08,$F8,$E2,$06
	db $08,$08,$E4,$06,$10,$F0,$8B,$06,$18,$F0,$CC,$06,$18,$00,$CE,$06
	db $18,$10,$EC,$06,$FF

	db $00,$D3,$EE,$06,$00,$D3,$EE,$06,$10,$D9,$88,$06,$10,$E1,$89,$06
	db $E8,$E9,$A6,$06,$E8,$F9,$A8,$06,$E8,$09,$AA,$06,$F8,$E9,$C6,$06
	db $F8,$F9,$C8,$06,$F8,$09,$CA,$06,$08,$E9,$E6,$06,$08,$F9,$E8,$06
	db $08,$09,$EA,$06,$10,$F1,$8B,$06,$18,$F1,$CC,$06,$18,$01,$CE,$06
	db $18,$11,$EC,$06,$FF

	db $00,$D2,$EE,$06,$00,$D2,$EE,$06,$10,$D8,$88,$06,$10,$E0,$89,$06
	db $E8,$E8,$A6,$06,$E8,$F8,$A8,$06,$E8,$08,$AA,$06,$F8,$E8,$C6,$06
	db $F8,$F8,$C8,$06,$F8,$08,$CA,$06,$08,$E8,$E6,$06,$08,$F8,$E8,$06
	db $08,$08,$EA,$06,$10,$F0,$8B,$06,$18,$F0,$CC,$06,$18,$00,$CE,$06
	db $18,$10,$EC,$06,$FF

	db $D8,$D0,$0A,$06,$D8,$E0,$08,$06,$E8,$C0,$28,$06,$E8,$D0,$0C,$06
	db $E8,$E0,$34,$06,$E8,$E0,$2A,$46,$E8,$F0,$28,$46,$F0,$E0,$44,$06
	db $F8,$C0,$48,$06,$F8,$F0,$48,$46,$00,$D0,$3C,$06,$00,$E0,$64,$06
	db $F8,$D0,$2C,$06,$F8,$E0,$4A,$46,$08,$C0,$68,$06,$08,$D0,$6A,$06
	db $08,$E0,$6A,$46,$08,$F0,$68,$46,$18,$C0,$6E,$46,$18,$D0,$6C,$46
	db $18,$E0,$6C,$06,$18,$F0,$6E,$06,$FF

	db $D8,$D0,$0A,$06,$D8,$E0,$08,$06,$F0,$E0,$10,$06,$E8,$D0,$36,$06
	db $E8,$E0,$36,$46,$E8,$E0,$2A,$46,$E8,$F0,$28,$46,$F0,$D0,$46,$06
	db $E8,$C0,$28,$06,$F8,$C0,$48,$06,$00,$E0,$12,$06,$F8,$E0,$4A,$46
	db $F8,$F0,$48,$46,$00,$D0,$66,$06,$08,$C0,$68,$06,$08,$D0,$6A,$06
	db $08,$E0,$6A,$46,$08,$F0,$68,$46,$18,$C0,$6E,$46,$18,$D0,$6C,$46
	db $18,$E0,$6C,$06,$18,$F0,$6E,$06,$FF

	db $D8,$D0,$0A,$06,$D8,$E0,$08,$06,$F0,$E0,$10,$06,$E8,$C0,$28,$06
	db $E8,$D0,$36,$06,$E8,$E0,$36,$46,$E8,$E0,$2A,$46,$E8,$F0,$28,$46
	db $F0,$D0,$46,$06,$F8,$C0,$48,$06,$00,$E0,$12,$06,$F8,$E0,$4A,$46
	db $F8,$F0,$48,$46,$00,$D0,$66,$06,$08,$C0,$68,$06,$08,$D0,$6A,$06
	db $08,$E0,$6A,$46,$08,$F0,$68,$46,$18,$C0,$6E,$46,$18,$D0,$6C,$46
	db $18,$E0,$6C,$06,$18,$F0,$6E,$06,$FF

	db $D8,$D0,$0A,$06,$D8,$E0,$08,$06,$E8,$C0,$28,$06,$E8,$D0,$0C,$06
	db $E8,$E0,$34,$06,$E8,$E0,$2A,$46,$E8,$F0,$28,$46,$F0,$E0,$44,$06
	db $F8,$C0,$48,$06,$F8,$F0,$48,$46,$00,$D0,$3C,$06,$00,$E0,$64,$06
	db $F8,$D0,$2C,$06,$F8,$E0,$4A,$46,$08,$C0,$68,$06,$08,$D0,$6A,$06
	db $08,$E0,$6A,$46,$08,$F0,$68,$46,$18,$C0,$6E,$46,$18,$D0,$6C,$46
	db $18,$E0,$6C,$06,$18,$F0,$6E,$06,$FF

	db $D8,$D0,$0A,$06,$D8,$E0,$08,$06,$E8,$C0,$28,$06,$E8,$D0,$0C,$06
	db $E8,$E0,$34,$06,$E8,$E0,$2A,$46,$E8,$F0,$28,$46,$F0,$E0,$44,$06
	db $F8,$C0,$48,$06,$F8,$F0,$48,$46,$00,$D0,$3C,$06,$00,$E0,$64,$06
	db $F8,$D0,$2C,$06,$F8,$E0,$4A,$46,$08,$C0,$68,$06,$08,$D0,$6A,$06
	db $08,$E0,$6A,$46,$08,$F0,$68,$46,$18,$C0,$6E,$46,$18,$D0,$6C,$46
	db $18,$E0,$6C,$06,$18,$F0,$6E,$06,$FF

;--------------------------------------------------------------------

; Note: Something to do with the cutscene after Bowser's defeat?

CODE_04ECCA:
	LDA.b #SMB1_UncompressedGFX_Sprite_PeachAndToad>>16
	STA.w !RAM_SMB1_Global_GraphicsUploadPointerBank
	REP.b #$20
	LDA.w #$0800
	STA.w !RAM_SMB1_Global_GraphicsUploadSizeLo
	LDA.w #$7800
	STA.w !RAM_SMB1_Global_GraphicsUploadVRAMAddressLo
	LDA.w !RAM_SMB1_Player_CurrentWorld
	AND.w #$00FF
	CMP.w #$0007
	BNE.b CODE_04ECED
	LDA.w #SMB1_UncompressedGFX_Sprite_PeachAndToad+$1000
	BRA.b CODE_04ECF0

CODE_04ECED:
	LDA.w #SMB1_UncompressedGFX_Sprite_PeachAndToad
CODE_04ECF0:
	STA.w !RAM_SMB1_Global_GraphicsUploadPointerLo
	SEP.b #$20
	STZ.w !RAM_SMB1_Cutscene_RustlingBagAnimationFrame
	STZ.w !RAM_SMB1_Cutscene_ToadPoppedOutOfBagFlag
	STZ.w $0F7F
	STZ.w !RAM_SMB1_Cutscene_ToadHasBeenInitializedFlag
	LDA.b #$02
	STA.w $0B76
	RTL

;--------------------------------------------------------------------

; Note: Something to do with the cutscene after Bowser's defeat?

CODE_04ED07:
	PHX
	LDA.b #SMB1_UncompressedGFX_Sprite_PeachAndToad>>16
	STA.w !RAM_SMB1_Global_GraphicsUploadPointerBank
	REP.b #$20
	LDA.w #$0800
	STA.w !RAM_SMB1_Global_GraphicsUploadSizeLo
	LDA.w #$7C00
	STA.w !RAM_SMB1_Global_GraphicsUploadVRAMAddressLo
	LDA.w !RAM_SMB1_Player_CurrentWorld
	AND.w #$00FF
	ASL
	TAX
	LDA.l DATA_04ED5A,x
	STA.w !RAM_SMB1_Global_GraphicsUploadPointerLo
	SEP.b #$20
	PLX
	RTL

;--------------------------------------------------------------------

SMB1_UploadSpriteGFX:
.Main:
;$04ED2E
	LDA.b #$80
	STA.w !REGISTER_VRAMAddressIncrementValue
	REP.b #$20
	LDA.w #$6000
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STA.w DMA[$00].Parameters
	LDA.w #SMB1_UncompressedGFX_Sprite_GlobalTiles
	STA.w DMA[$00].SourceLo
	LDX.b #SMB1_UncompressedGFX_Sprite_GlobalTiles>>16
	STX.w DMA[$00].SourceBank
	LDA.w #SMB1_UncompressedGFX_Sprite_GlobalTiles_End-SMB1_UncompressedGFX_Sprite_GlobalTiles
	STA.w DMA[$00].SizeLo
	LDX.b #$01
	STX.w !REGISTER_DMAEnable
	SEP.b #$20
	RTL

;--------------------------------------------------------------------

DATA_04ED5A:
	dw SMB1_UncompressedGFX_Sprite_PeachAndToad+$0800,SMB1_UncompressedGFX_Sprite_PeachAndToad+$0800
	dw SMB1_UncompressedGFX_Sprite_PeachAndToad+$0800,SMB1_UncompressedGFX_Sprite_PeachAndToad+$0800
	dw SMB1_UncompressedGFX_Sprite_PeachAndToad+$2800,SMB1_UncompressedGFX_Sprite_PeachAndToad+$2000
	dw SMB1_UncompressedGFX_Sprite_PeachAndToad+$2000,SMB1_UncompressedGFX_Sprite_PeachAndToad+$1000
	dw SMB1_UncompressedGFX_Sprite_PeachAndToad+$0800,SMB1_UncompressedGFX_Sprite_PeachAndToad+$2800
	dw SMB1_UncompressedGFX_Sprite_PeachAndToad+$2000,SMB1_UncompressedGFX_Sprite_PeachAndToad+$2000
	dw SMB1_UncompressedGFX_Sprite_PeachAndToad+$1000,SMB1_UncompressedGFX_Sprite_PeachAndToad+$1000
	dw SMB1_UncompressedGFX_Sprite_PeachAndToad+$1000,SMB1_UncompressedGFX_Sprite_PeachAndToad+$1000

;--------------------------------------------------------------------

SMB1_DrawToadAndRelatedSprites:
.Main:
;$04ED7A
	LDA.w !RAM_SMB1_Cutscene_ToadPoppedOutOfBagFlag
	BEQ.b CODE_04ED82
	JMP.w CODE_04EE26

CODE_04ED82:
	LDA.b !RAM_SMB1_Global_FrameCounter
	AND.b #$07
	BEQ.b CODE_04ED8D
	LDA.w !RAM_SMB1_Cutscene_RustlingBagAnimationFrame
	BRA.b CODE_04EDAF

CODE_04ED8D:
	INC.w !RAM_SMB1_Cutscene_RustlingBagAnimationFrame
	LDA.w !RAM_SMB1_Cutscene_RustlingBagAnimationFrame
	CMP.b #$03
	BCC.b CODE_04EDAF
	LDA.w !RAM_SMB1_Global_RandomByte3
	EOR.w !RAM_SMB1_Global_RandomByte4
	AND.b #$01
	BNE.b CODE_04EDAA
	LDA.b #$03
	STA.w !RAM_SMB1_Cutscene_RustlingBagAnimationFrame
	LDA.b #$01
	BRA.b CODE_04EDAF

CODE_04EDAA:
	LDA.b #$00
	STA.w !RAM_SMB1_Cutscene_RustlingBagAnimationFrame
CODE_04EDAF:
	STA.b $00
	LDA.b !RAM_SMB1_NorSpr_XPosHi
	XBA
	LDA.w !RAM_SMB1_NorSpr_XPosLo
	LDY.b #$00
	JSR.w CODE_04FCFD
	LDA.b !RAM_SMB1_NorSpr_XPosHi
	XBA
	LDA.w !RAM_SMB1_NorSpr_XPosLo
	REP.b #$20
	CLC
	ADC.w #$0008
	SEP.b #$20
	LDY.b #$04
	JSR.w CODE_04FCFD
	LDA.b $00
	CMP.b #$02
	BEQ.b CODE_04EE02
	CMP.b #$00
	BNE.b CODE_04EDDD
	LDA.b #$83
	BRA.b CODE_04EDDF

CODE_04EDDD:
	LDA.b #$80
CODE_04EDDF:
	STA.w SMB1_OAMBuffer[$40].Tile
	INC
	STA.w SMB1_OAMBuffer[$41].Tile
	CLC
	ADC.b #$1F
	STA.w SMB1_OAMBuffer[$42].Tile
	INC
	STA.w SMB1_OAMBuffer[$43].Tile
	LDA.b #$B0
	STA.w SMB1_OAMBuffer[$40].YDisp
	STA.w SMB1_OAMBuffer[$41].YDisp
	LDA.b #$C0
	STA.w SMB1_OAMBuffer[$42].YDisp
	STA.w SMB1_OAMBuffer[$43].YDisp
	BRA.b CODE_04EE25

CODE_04EE02:
	LDA.b #$86
	STA.w SMB1_OAMBuffer[$40].Tile
	INC
	STA.w SMB1_OAMBuffer[$41].Tile
	CLC
	ADC.b #$0F
	STA.w SMB1_OAMBuffer[$42].Tile
	INC
	STA.w SMB1_OAMBuffer[$43].Tile
	LDA.b #$B8
	STA.w SMB1_OAMBuffer[$40].YDisp
	STA.w SMB1_OAMBuffer[$41].YDisp
	LDA.b #$C0
	STA.w SMB1_OAMBuffer[$42].YDisp
	STA.w SMB1_OAMBuffer[$43].YDisp
CODE_04EE25:
	RTL

CODE_04EE26:
	PHB
	PHK
	PLB
	PHX
	PHY
	LDA.w !RAM_SMB1_Player_CurrentWorld
	ASL
	TAX
	LDA.w !RAM_SMB1_Cutscene_ToadHasBeenInitializedFlag
	BNE.b CODE_04EE38
	JSR.w CODE_04FBA4
CODE_04EE38:
	LDA.w DATA_04EE45,x
	STA.b $00
	LDA.w DATA_04EE45+$01,x
	STA.b $01
	JMP.w ($0000)

DATA_04EE45:
	dw CODE_04EE61
	dw CODE_04EEE4
	dw CODE_04EF85
	dw CODE_04F15A
	dw CODE_04F3A1
	dw CODE_04F5FA
	dw CODE_04F896
	dw CODE_04EE61
	dw CODE_04EE61
	dw CODE_04F3A1
	dw CODE_04F5FA
	dw CODE_04F896
	dw CODE_04EE61

;--------------------------------------------------------------------

DATA_04EE5F:
	db $90,$00

CODE_04EE61:
	JSR.w CODE_04FA7B
	LDA.w $0F7F
	BNE.b CODE_04EE6C
	JMP.w CODE_04F9D5

CODE_04EE6C:
	CMP.b #$03
	BNE.b CODE_04EEBB
	LDA.w $0B9F
	BNE.b CODE_04EEBB
	JSR.w CODE_04FD66
	LDA.b #$20
	STA.b $00
	LDA.b #$04
	STA.b $02
	LDX.b #$01
	LDA.b #$00
	JSL.l CODE_03C18F
	LDA.w !RAM_SMB1_NorSpr_YPosLo
	CMP.b #$B0
	BCS.b CODE_04EE97
	LDA.b #$01
	STA.w $0B9D
	LDA.w !RAM_SMB1_NorSpr_YPosLo
CODE_04EE97:
	CMP.b #$B8
	BCC.b CODE_04EEBB
	LDA.b #$B8
	STA.w !RAM_SMB1_NorSpr_YPosLo
	LDA.b #$FE
	STA.w !RAM_SMB1_NorSpr_YSpeed
	STZ.w !RAM_SMB1_NorSpr_SubYSpeed
	STZ.w !RAM_SMB1_NorSpr_SubYPos
	LDA.b #$00
	STA.w $0B9E
	LDA.b #$18
	STA.w $0B9F
	STZ.w $0BA4
	JSR.w CODE_04FD29
CODE_04EEBB:
	LDA.w $0B9F
	BNE.b CODE_04EEC7
	LDA.b #$01
	STA.w $0B9E
	BRA.b CODE_04EECA

CODE_04EEC7:
	DEC.w $0B9F
CODE_04EECA:
	LDA.w $03AE
	STA.b $00
	LDA.w !RAM_SMB1_NorSpr_YPosLo
	STA.b $01
	LDY.w $0B9D
	LDA.w DATA_04EE5F,y
	TAY
	LDA.w $0B9E
	JSR.w CODE_04F9FC
	JMP.w CODE_04F9D5

;--------------------------------------------------------------------

CODE_04EEE4:
	JSR.w CODE_04FA7B
	LDA.w $0F7F
	BNE.b CODE_04EEEF
	JMP.w CODE_04F9D5

CODE_04EEEF:
	CMP.b #$03
	BNE.b CODE_04EF4F
	LDA.w $0B9F
	BNE.b CODE_04EF4C
	LDA.w $0B9C
	CMP.b #$02
	BNE.b CODE_04EF04
	STA.w $0B9E
	BRA.b CODE_04EF4F

CODE_04EF04:
	JSR.w CODE_04FD66
	LDA.b #$01
	STA.w $0B9E
	LDA.b #$20
	STA.b $00
	LDA.b #$04
	STA.b $02
	LDX.b #$01
	LDA.b #$00
	JSL.l CODE_03C18F
	LDA.w !RAM_SMB1_NorSpr_YPosLo
	CMP.b #$B0
	BCS.b CODE_04EF2B
	LDA.b #$01
	STA.w $0B9D
	LDA.w !RAM_SMB1_NorSpr_YPosLo
CODE_04EF2B:
	CMP.b #$B8
	BCC.b CODE_04EF4F
	LDA.b #$B8
	STA.w !RAM_SMB1_NorSpr_YPosLo
	STZ.w !RAM_SMB1_NorSpr_YSpeed
	STZ.w !RAM_SMB1_NorSpr_SubYSpeed
	STZ.w !RAM_SMB1_NorSpr_SubYPos
	LDA.b #$28
	STA.w $0B9F
	LDA.b #$02
	STA.w $0B9C
	LDA.b #$00
	STA.w $0B9E
CODE_04EF4C:
	DEC.w $0B9F
CODE_04EF4F:
	LDA.w $03AE
	STA.b $00
	LDA.w !RAM_SMB1_NorSpr_YPosLo
	STA.b $01
	LDY.w $0B9D
	LDA.w DATA_04EE5F,y
	TAY
	LDA.w $0B9E
	JSR.w CODE_04F9FC
	TYA
	CLC
	ADC.b #$10
	TAY
	LDA.w $03AE
	CLC
	ADC.b #$10
	STA.b $00
	LDA.w $0B9E
	CMP.b #$02
	BNE.b CODE_04EF7F
	JSR.w CODE_04FD29
	LDA.b #$03
CODE_04EF7F:
	JSR.w CODE_04F9FC
	JMP.w CODE_04F9D5

;--------------------------------------------------------------------

CODE_04EF85:
	JSR.w CODE_04FA7B
	LDA.w $0F7F
	BNE.b CODE_04EF90
	JMP.w CODE_04F9D5

CODE_04EF90:
	CMP.b #$03
	BEQ.b CODE_04EF97
	JMP.w CODE_04F017

CODE_04EF97:
	LDA.w $0BA0
	CMP.b #$28
	BCC.b CODE_04F014
	CMP.b #$50
	BCC.b CODE_04EFFD
	CMP.b #$58
	BCC.b CODE_04EFF7
	JSR.w CODE_04FD66
	LDA.b #$20
	STA.b $00
	LDA.b #$04
	STA.b $02
	LDX.b #$01
	LDA.b #$00
	JSL.l CODE_03C18F
	LDA.b #$01
	STA.w $0B9E
	LDA.w !RAM_SMB1_NorSpr_YPosLo
	CMP.b #$B0
	BCS.b CODE_04EFCC
	LDA.b #$01
	STA.w $0B9D
	BRA.b CODE_04EFE9

CODE_04EFCC:
	CMP.b #$B8
	BCC.b CODE_04EFE9
	STZ.w !RAM_SMB1_NorSpr_YSpeed
	STZ.w !RAM_SMB1_NorSpr_SubYSpeed
	STZ.w !RAM_SMB1_NorSpr_SubYPos
	LDA.b #$B8
	STA.w !RAM_SMB1_NorSpr_YPosLo
	STZ.w $0B9E
	LDA.b #$01
	STA.w $0B9F
	JSR.w CODE_04FD29
CODE_04EFE9:
	LDA.w $0B9F
	BNE.b CODE_04EFF7
	LDA.b !RAM_SMB1_Global_FrameCounter
	AND.b #$01
	BNE.b CODE_04EFF7
	INC.w $021D
CODE_04EFF7:
	JSR.w CODE_04F031
	JMP.w CODE_04F9D5

CODE_04EFFD:
	LDY.b #$A0
	CMP.b #$2C
	BCC.b CODE_04F011
	CMP.b #$30
	BCC.b CODE_04F00C
	JSR.w CODE_04F091
	BRA.b CODE_04F014

CODE_04F00C:
	JSR.w CODE_04F0ED
	BRA.b CODE_04F014

CODE_04F011:
	JSR.w CODE_04F124
CODE_04F014:
	INC.w $0BA0
CODE_04F017:
	LDA.w $03AE
	STA.b $00
	LDA.w !RAM_SMB1_NorSpr_YPosLo
	STA.b $01
	LDY.w $0B9D
	LDA.w DATA_04EE5F,y
	TAY
	LDA.w $0B9E
	JSR.w CODE_04F9FC
	JMP.w CODE_04F9D5

CODE_04F031:
	LDA.w $03AE
	STA.b $00
	LDA.w !RAM_SMB1_NorSpr_YPosLo
	STA.b $01
	LDY.w $0B9D
	LDA.w DATA_04EE5F,y
	TAY
	LDA.w $0B9E
	JSR.w CODE_04F9FC
	TYA
	CLC
	ADC.b #$10
	TAY
	LDA.w $03AE
	SEC
	SBC.w $021D
	SEC
	SBC.b #$07
	STA.b $00
	LDA.w $0B9F
	DEC
	BEQ.b CODE_04F065
	LDA.b #$04
	CLC
	ADC.w $0B9E
CODE_04F065:
	JSR.w CODE_04F9FC
	TYA
	CLC
	ADC.b #$10
	TAY
	LDA.w $03AE
	CLC
	ADC.w $021D
	CLC
	ADC.b #$07
	STA.b $00
	LDA.w $0B9F
	DEC
	BEQ.b CODE_04F085
	LDA.b #$06
	CLC
	ADC.w $0B9E
CODE_04F085:
	JSR.w CODE_04F9FC
	LDA.w $0BA0
	BMI.b CODE_04F090
	INC.w $0BA0
CODE_04F090:
	RTS

CODE_04F091:
	LDA.w !RAM_SMB1_NorSpr_YPosLo
	INC
	STA.w SMB1_OAMBuffer[$41].YDisp,y
	STA.w SMB1_OAMBuffer[$43].YDisp,y
	CLC
	ADC.b #$07
	STA.w SMB1_OAMBuffer[$40].YDisp,y
	STA.w SMB1_OAMBuffer[$42].YDisp,y
	LDA.w $03AE
	SEC
	SBC.b #$0D
	STA.w SMB1_OAMBuffer[$41].XDisp,y
	DEC
	STA.w SMB1_OAMBuffer[$40].XDisp,y
	LDA.w $03AE
	CLC
	ADC.b #$0D
	STA.w SMB1_OAMBuffer[$43].XDisp,y
	INC
	STA.w SMB1_OAMBuffer[$42].XDisp,y
	LDA.b #$E0
	STA.w SMB1_OAMBuffer[$41].Tile,y
	STA.w SMB1_OAMBuffer[$43].Tile,y
	LDA.b #$CE
	STA.w SMB1_OAMBuffer[$40].Tile,y
	STA.w SMB1_OAMBuffer[$42].Tile,y
	LDA.b #$2D
	STA.w SMB1_OAMBuffer[$42].Prop,y
	STA.w SMB1_OAMBuffer[$43].Prop,y
	LDA.b #$6D
	STA.w SMB1_OAMBuffer[$40].Prop,y
	STA.w SMB1_OAMBuffer[$41].Prop,y
	LDA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$40].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$41].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$42].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$43].Slot,y
	RTS

CODE_04F0ED:
	LDA.w $03AE
	SEC
	SBC.b #$09
	STA.w SMB1_OAMBuffer[$40].XDisp,y
	LDA.w $03AE
	CLC
	ADC.b #$09
	STA.w SMB1_OAMBuffer[$41].XDisp,y
	LDA.w !RAM_SMB1_NorSpr_YPosLo
	INC
	STA.w SMB1_OAMBuffer[$40].YDisp,y
	STA.w SMB1_OAMBuffer[$41].YDisp,y
	LDA.b #$E0
	STA.w SMB1_OAMBuffer[$40].Tile,y
	STA.w SMB1_OAMBuffer[$41].Tile,y
	LDA.b #$6D
	STA.w SMB1_OAMBuffer[$40].Prop,y
	LDA.b #$2D
	STA.w SMB1_OAMBuffer[$41].Prop,y
	LDA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$40].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$41].Slot,y
	RTS

CODE_04F124:
	LDA.w $03AE
	SEC
	SBC.b #$05
	STA.w SMB1_OAMBuffer[$40].XDisp,y
	LDA.w $03AE
	CLC
	ADC.b #$05
	STA.w SMB1_OAMBuffer[$41].XDisp,y
	LDA.w !RAM_SMB1_NorSpr_YPosLo
	STA.w SMB1_OAMBuffer[$40].YDisp,y
	STA.w SMB1_OAMBuffer[$41].YDisp,y
	LDA.b #$E0
	STA.w SMB1_OAMBuffer[$40].Tile,y
	STA.w SMB1_OAMBuffer[$41].Tile,y
	LDA.b #$6D
	STA.w SMB1_OAMBuffer[$40].Prop,y
	LDA.b #$2D
	STA.w SMB1_OAMBuffer[$41].Prop,y
	LDA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$40].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$41].Slot,y
	RTS

;--------------------------------------------------------------------

CODE_04F15A:
	JSR.w CODE_04FA7B
	LDA.w $0F7F
	BNE.b CODE_04F165
	JMP.w CODE_04F9D5

CODE_04F165:
	INC.w $0B9F
	LDA.w $0B9F
	CMP.b #$C0
	BCC.b CODE_04F187
	LDA.b #$C0
	STA.w $0B9F
	LDA.b #$02
	STA.w $0B9C
	LDA.b #$01
	STA.w $0BB8
	STA.w $0BB9
	STA.w $0BBA
	STA.w $0BBB
CODE_04F187:
	STZ.w $0E67
	LDA.w $0BB4
	BNE.b CODE_04F1A2
	LDA.w $0B9C
	CMP.b #$02
	BEQ.b CODE_04F19C
	JSR.w CODE_04F2AB
	JMP.w CODE_04F9D5

CODE_04F19C:
	JSR.w CODE_04F1D7
	JMP.w CODE_04F9D5

CODE_04F1A2:
	LDA.w $0BA1
	BEQ.b CODE_04F1AE
	DEC.w $0BA1
	LDA.b #$00
	BRA.b CODE_04F1B3

CODE_04F1AE:
	JSR.w CODE_04FD29
	LDA.b #$02
CODE_04F1B3:
	STA.w $0B9E
	LDX.b #$03
	LDY.b #$00
CODE_04F1BA:
	LDA.w $0BB0,x
	STA.b $00
	LDA.b #$B8
	STA.b $01
	LDA.w $0B9E
	JSR.w CODE_04F9FC
	TYA
	CLC
	ADC.b #$10
	TAY
	STY.w $0E67
	DEX
	BPL.b CODE_04F1BA
	JMP.w CODE_04F9D5

CODE_04F1D7:
	JSR.w CODE_04FD66
	LDA.b #$20
	STA.b $00
	LDA.b #$04
	STA.b $02
	LDX.b #$01
	LDA.b #$00
	JSL.l CODE_03C18F
	LDA.w !RAM_SMB1_NorSpr_YPosLo
	CMP.b #$B0
	BCS.b CODE_04F1F6
	LDA.b #$01
	STA.w $0B9D
CODE_04F1F6:
	LDY.w $0B9D
	LDA.w DATA_04EE5F,y
	TAY
	LDA.w $03AE
	STA.b $00
	LDA.w !RAM_SMB1_NorSpr_YPosLo
	CMP.b #$B8
	BCC.b CODE_04F20E
	LDA.b #$B8
	STZ.w $0BB8
CODE_04F20E:
	STA.b $01
	LDA.w $0BB8
	JSR.w CODE_04F9FC
	LDA.w $0BB1
	STA.b $00
	LDA.w !RAM_SMB1_NorSpr_YPosLo
	SEC
	SBC.b #$0C
	CMP.b #$B8
	BCC.b CODE_04F22C
	LDA.b #$B8
	STZ.w $0BB9
	BRA.b CODE_04F23A

CODE_04F22C:
	LDA.b !RAM_SMB1_Global_FrameCounter
	LSR
	BCC.b CODE_04F234
	INC.w $0BB1
CODE_04F234:
	LDA.w !RAM_SMB1_NorSpr_YPosLo
	SEC
	SBC.b #$0C
CODE_04F23A:
	STA.b $01
	TYA
	CLC
	ADC.b #$10
	TAY
	LDA.w $0BB9
	CLC
	ADC.b #$06
	JSR.w CODE_04F9FC
	LDA.w $0BB2
	STA.b $00
	LDA.w !RAM_SMB1_NorSpr_YPosLo
	SEC
	SBC.b #$18
	CMP.b #$B8
	BCC.b CODE_04F260
	LDA.b #$B8
	STZ.w $0BBA
	BRA.b CODE_04F263

CODE_04F260:
	DEC.w $0BB2
CODE_04F263:
	STA.b $01
	TYA
	CLC
	ADC.b #$10
	TAY
	LDA.w $0BBA
	CLC
	ADC.b #$04
	JSR.w CODE_04F9FC
	LDA.w $0BB3
	STA.b $00
	LDA.w !RAM_SMB1_NorSpr_YPosLo
	SEC
	SBC.b #$24
	CMP.b #$B8
	BCC.b CODE_04F297
	LDA.b #$B8
	STZ.w $0BBB
	INC.w $0BB4
	LDA.b #$28
	STA.w $0BA1
	LDA.w !RAM_SMB1_NorSpr_YPosLo
	SEC
	SBC.b #$24
	BRA.b CODE_04F29A

CODE_04F297:
	INC.w $0BB3
CODE_04F29A:
	STA.b $01
	TYA
	CLC
	ADC.b #$10
	TAY
	LDA.w $0BBB
	CLC
	ADC.b #$06
	JSR.w CODE_04F9FC
	RTS

CODE_04F2AB:
	LDY.b #$B0
	LDX.b #$00
CODE_04F2AF:
	LDA.w $03AE
	STA.w SMB1_OAMBuffer[$40].XDisp,y
	LDA.w DATA_04F38F,x
	STA.w SMB1_OAMBuffer[$40].YDisp,y
	LDA.w DATA_04F38F+$01,x
	STA.w SMB1_OAMBuffer[$40].Tile,y
	LDA.b #$2D
	STA.w SMB1_OAMBuffer[$40].Prop,y
	LDA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$40].Slot,y
	INY
	INY
	INY
	INY
	INX
	INX
	CPX.b #$12
	BCC.b CODE_04F2AF
	LDA.b #$6D
	STA.w SMB1_OAMBuffer[$70].Prop
	STZ.w SMB1_OAMTileSizeBuffer[$70].Slot
	STZ.w SMB1_OAMTileSizeBuffer[$6F].Slot
	LDA.w SMB1_OAMBuffer[$6F].XDisp
	CLC
	ADC.b #$08
	STA.w SMB1_OAMBuffer[$70].XDisp
	LDX.b #$00
CODE_04F2EB:
	LDA.w DATA_04F388,x
	CMP.w $0B9F
	BCS.b CODE_04F2F8
	INX
	CPX.b #$06
	BNE.b CODE_04F2EB
CODE_04F2F8:
	TXA
	ASL
	TAX
	LDA.w DATA_04F37A,x
	STA.b $00
	LDA.w DATA_04F37A+$01,x
	STA.b $01
	LDA.b #$01
	JMP.w ($0000)

CODE_04F30A:
	STA.w SMB1_OAMTileSizeBuffer[$6C].Slot
	STA.w SMB1_OAMTileSizeBuffer[$6D].Slot
	STA.w SMB1_OAMTileSizeBuffer[$6E].Slot
	STA.w SMB1_OAMTileSizeBuffer[$72].Slot
	STA.w SMB1_OAMTileSizeBuffer[$73].Slot
	STA.w SMB1_OAMTileSizeBuffer[$74].Slot
	RTS

CODE_04F31D:
	STA.w SMB1_OAMTileSizeBuffer[$6C].Slot
	STA.w SMB1_OAMTileSizeBuffer[$6D].Slot
	STA.w SMB1_OAMTileSizeBuffer[$6E].Slot
	STA.w SMB1_OAMTileSizeBuffer[$73].Slot
	STA.w SMB1_OAMTileSizeBuffer[$74].Slot
	LDA.b #!Define_SMAS_Sound0060_FlyWithCape
	STA.w !RAM_SMB1_Global_SoundCh1
	RTS

CODE_04F332:
	STA.w SMB1_OAMTileSizeBuffer[$6C].Slot
	STA.w SMB1_OAMTileSizeBuffer[$6D].Slot
	STA.w SMB1_OAMTileSizeBuffer[$72].Slot
	STA.w SMB1_OAMTileSizeBuffer[$73].Slot
	STA.w SMB1_OAMTileSizeBuffer[$74].Slot
	RTS

CODE_04F342:
	STA.w SMB1_OAMTileSizeBuffer[$6C].Slot
	STA.w SMB1_OAMTileSizeBuffer[$6D].Slot
	STA.w SMB1_OAMTileSizeBuffer[$72].Slot
	STA.w SMB1_OAMTileSizeBuffer[$74].Slot
	LDA.b #!Define_SMAS_Sound0060_FlyWithCape
	STA.w !RAM_SMB1_Global_SoundCh1
	RTS

CODE_04F354:
	STA.w SMB1_OAMTileSizeBuffer[$6C].Slot
	STA.w SMB1_OAMTileSizeBuffer[$72].Slot
	STA.w SMB1_OAMTileSizeBuffer[$73].Slot
	STA.w SMB1_OAMTileSizeBuffer[$74].Slot
	RTS

CODE_04F361:
	STA.w SMB1_OAMTileSizeBuffer[$6C].Slot
	STA.w SMB1_OAMTileSizeBuffer[$72].Slot
	STA.w SMB1_OAMTileSizeBuffer[$73].Slot
	LDA.b #!Define_SMAS_Sound0060_FlyWithCape
	STA.w !RAM_SMB1_Global_SoundCh1
	RTS

CODE_04F370:
	STA.w SMB1_OAMTileSizeBuffer[$72].Slot
	STA.w SMB1_OAMTileSizeBuffer[$73].Slot
	STA.w SMB1_OAMTileSizeBuffer[$74].Slot
	RTS

DATA_04F37A:
	dw CODE_04F30A
	dw CODE_04F31D
	dw CODE_04F332
	dw CODE_04F342
	dw CODE_04F354
	dw CODE_04F361
	dw CODE_04F370

DATA_04F388:
	db $40,$48,$58,$60,$70,$78,$BF

DATA_04F38F:
	db $97,$EA,$A2,$EA,$AD,$EA,$B8,$B6
	db $B8,$B6,$C0,$C9,$B3,$EA,$A8,$EA
	db $9D,$EA

;--------------------------------------------------------------------

CODE_04F3A1:
	JSR.w CODE_04FA7B
	LDA.w $0F7F
	BNE.b CODE_04F3AC
	JMP.w CODE_04F9D5

CODE_04F3AC:
	JSR.w CODE_04FD66
	LDA.b #$20
	STA.b $00
	LDA.b #$04
	STA.b $02
	LDX.b #$01
	LDA.b #$00
	JSL.l CODE_03C18F
	LDA.w !RAM_SMB1_NorSpr_YPosLo
	CMP.b #$A0
	BCS.b CODE_04F3CB
	LDA.b #$01
	STA.w $0B9D
CODE_04F3CB:
	LDA.w !RAM_SMB1_NorSpr_YPosLo
	CMP.b #$B0
	BCC.b CODE_04F3ED
	LDA.b #$B0
	STA.w !RAM_SMB1_NorSpr_YPosLo
	STZ.w !RAM_SMB1_NorSpr_SubYSpeed
	STZ.w !RAM_SMB1_Player_SubYPos
	INC.w $0B9E
	LDA.w $0B9E
	BMI.b CODE_04F3EA
	LDA.b #$00
	STA.w $0B9E
CODE_04F3EA:
	STA.w !RAM_SMB1_NorSpr_YSpeed
CODE_04F3ED:
	INC.w $0B9F
	LDA.w $0B9F
	CMP.b #$44
	BCC.b CODE_04F40C
	BNE.b CODE_04F3FE
	LDA.b #!Define_SMAS_Sound0060_EchoSpinJumpKill
	STA.w !RAM_SMB1_Global_SoundCh1
CODE_04F3FE:
	LDA.b #$45
	STA.w $0B9F
	JSR.w CODE_04F412
	JSR.w CODE_04FD29
	JMP.w CODE_04F9D5

CODE_04F40C:
	JSR.w CODE_04F586
	JMP.w CODE_04F9D5

CODE_04F412:
	LDA.w $03AE
	CLC
	ADC.w $0B9F
	STA.b $00
	CLC
	ADC.b #$06
	STA.w SMB1_OAMBuffer[$40].XDisp
	CLC
	ADC.b #$10
	STA.w SMB1_OAMBuffer[$41].XDisp
	LDA.b $00
	STA.w SMB1_OAMBuffer[$44].XDisp
	STA.w SMB1_OAMBuffer[$46].XDisp
	CLC
	ADC.b #$08
	STA.w SMB1_OAMBuffer[$45].XDisp
	LDA.b $00
	CLC
	ADC.b #$1C
	STA.w SMB1_OAMBuffer[$48].XDisp
	STA.w SMB1_OAMBuffer[$4A].XDisp
	CLC
	ADC.b #$08
	STA.w SMB1_OAMBuffer[$49].XDisp
	LDA.b $00
	CLC
	ADC.b #$06
	STA.w SMB1_OAMBuffer[$4C].XDisp
	STA.w SMB1_OAMBuffer[$4E].XDisp
	CLC
	ADC.b #$08
	STA.w SMB1_OAMBuffer[$4D].XDisp
	LDA.b $00
	CLC
	ADC.b #$16
	STA.w SMB1_OAMBuffer[$50].XDisp
	STA.w SMB1_OAMBuffer[$52].XDisp
	CLC
	ADC.b #$08
	STA.w SMB1_OAMBuffer[$51].XDisp
	LDA.b #$B8
	STA.w SMB1_OAMBuffer[$44].YDisp
	STA.w SMB1_OAMBuffer[$45].YDisp
	STA.w SMB1_OAMBuffer[$48].YDisp
	STA.w SMB1_OAMBuffer[$49].YDisp
	STA.w SMB1_OAMBuffer[$4C].YDisp
	STA.w SMB1_OAMBuffer[$4D].YDisp
	STA.w SMB1_OAMBuffer[$50].YDisp
	STA.w SMB1_OAMBuffer[$51].YDisp
	LDA.b #$C0
	STA.w SMB1_OAMBuffer[$40].YDisp
	STA.w SMB1_OAMBuffer[$41].YDisp
	STA.w SMB1_OAMBuffer[$46].YDisp
	STA.w SMB1_OAMBuffer[$4A].YDisp
	STA.w SMB1_OAMBuffer[$4E].YDisp
	STA.w SMB1_OAMBuffer[$52].YDisp
	LDA.b #$BE
	STA.w SMB1_OAMBuffer[$44].Tile
	STA.w SMB1_OAMBuffer[$49].Tile
	LDA.b #$BF
	STA.w SMB1_OAMBuffer[$45].Tile
	STA.w SMB1_OAMBuffer[$48].Tile
	LDA.b #$EC
	STA.w SMB1_OAMBuffer[$46].Tile
	STA.w SMB1_OAMBuffer[$4A].Tile
	LDA.b #$EA
	STA.w SMB1_OAMBuffer[$40].Tile
	STA.w SMB1_OAMBuffer[$41].Tile
	LDA.b #$B6
	STA.w SMB1_OAMBuffer[$4C].Tile
	STA.w SMB1_OAMBuffer[$4D].Tile
	STA.w SMB1_OAMBuffer[$50].Tile
	STA.w SMB1_OAMBuffer[$51].Tile
	LDA.b #$C9
	STA.w SMB1_OAMBuffer[$4E].Tile
	STA.w SMB1_OAMBuffer[$52].Tile
	LDA.b #$2D
	STA.w SMB1_OAMBuffer[$40].Prop
	STA.w SMB1_OAMBuffer[$44].Prop
	STA.w SMB1_OAMBuffer[$45].Prop
	STA.w SMB1_OAMBuffer[$46].Prop
	STA.w SMB1_OAMBuffer[$4C].Prop
	STA.w SMB1_OAMBuffer[$4E].Prop
	STA.w SMB1_OAMBuffer[$50].Prop
	STA.w SMB1_OAMBuffer[$52].Prop
	LDA.b #$6D
	STA.w SMB1_OAMBuffer[$41].Prop
	STA.w SMB1_OAMBuffer[$48].Prop
	STA.w SMB1_OAMBuffer[$49].Prop
	STA.w SMB1_OAMBuffer[$4A].Prop
	STA.w SMB1_OAMBuffer[$4D].Prop
	STA.w SMB1_OAMBuffer[$51].Prop
	LDA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$40].Slot
	STA.w SMB1_OAMTileSizeBuffer[$41].Slot
	STA.w SMB1_OAMTileSizeBuffer[$46].Slot
	STA.w SMB1_OAMTileSizeBuffer[$4A].Slot
	STA.w SMB1_OAMTileSizeBuffer[$4E].Slot
	STA.w SMB1_OAMTileSizeBuffer[$52].Slot
	LDX.b #$03
CODE_04F510:
	LDA.w $0BB8,x
	BEQ.b CODE_04F521
	CMP.b #$1E
	BCC.b CODE_04F51E
	STZ.w $0BB8,x
	BRA.b CODE_04F521

CODE_04F51E:
	INC.w $0BB8,x
CODE_04F521:
	DEX
	BPL.b CODE_04F510
	LDA.b !RAM_SMB1_Global_FrameCounter
	AND.b #$07
	BNE.b CODE_04F556
	LDX.b #$03
CODE_04F52C:
	LDA.w $0BB8,x
	BEQ.b CODE_04F534
	DEX
	BNE.b CODE_04F52C
CODE_04F534:
	LDA.b !RAM_SMB1_Global_FrameCounter
	AND.b #$03
	TAY
	LDA.w !RAM_SMB1_Global_RandomByte3,y
	EOR.b !RAM_SMB1_Global_FrameCounter
	AND.b #$1F
	CLC
	ADC.b #$CC
	STA.w $0BB0,x
	LDA.w !RAM_SMB1_Global_RandomByte4,y
	EOR.b !RAM_SMB1_Global_FrameCounter
	AND.b #$07
	CLC
	ADC.b #$B0
	STA.w $0BB4,x
	INC.w $0BB8,x
CODE_04F556:
	LDX.b #$03
CODE_04F558:
	LDA.w $0BB8,x
	LSR
	LSR
	LSR
	TAY
	LDA.w DATA_04F582,y
	STA.b $00
	TXA
	ASL
	ASL
	TAY
	LDA.w $0BB0,x
	STA.w SMB1_OAMBuffer[$00].XDisp,y
	LDA.w $0BB4,x
	STA.w SMB1_OAMBuffer[$00].YDisp,y
	LDA.b $00
	STA.w SMB1_OAMBuffer[$00].Tile,y
	LDA.b #$25
	STA.w SMB1_OAMBuffer[$00].Prop,y
	DEX
	BPL.b CODE_04F558
	RTS

DATA_04F582:
	db $F5,$E4,$F4,$E5

;--------------------------------------------------------------------

CODE_04F586:
	LDY.w $0B9D
	LDA.w DATA_04EE5F,y
	TAY
	LDA.w $03AE
	CLC
	ADC.w $0B9F
	STA.w SMB1_OAMBuffer[$40].XDisp,y
	STA.w SMB1_OAMBuffer[$42].XDisp,y
	CLC
	ADC.b #$10
	STA.w SMB1_OAMBuffer[$41].XDisp,y
	STA.w SMB1_OAMBuffer[$43].XDisp,y
	LDA.w !RAM_SMB1_NorSpr_YPosLo
	STA.w SMB1_OAMBuffer[$40].YDisp,y
	STA.w SMB1_OAMBuffer[$41].YDisp,y
	CLC
	ADC.b #$10
	STA.w SMB1_OAMBuffer[$42].YDisp,y
	STA.w SMB1_OAMBuffer[$43].YDisp,y
	LDA.w $0B9F
	AND.b #$0C
	TAX
	LDA.b #$04
	STA.b $00
CODE_04F5BF:
	LDA.w DATA_04F5DA,x
	STA.w SMB1_OAMBuffer[$40].Tile,y
	LDA.w DATA_04F5EA,x
	STA.w SMB1_OAMBuffer[$40].Prop,y
	LDA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$40].Slot,y
	INY
	INY
	INY
	INY
	INX
	DEC.b $00
	BNE.b CODE_04F5BF
	RTS

DATA_04F5DA:
	db $CE,$CE,$EE,$EE,$E0,$E2,$E0,$E2
	db $EE,$EE,$CE,$CE,$E2,$E0,$E2,$E0

DATA_04F5EA:
	db $2D,$4D,$2D,$4D,$2D,$2D,$AD,$AD
	db $AD,$CD,$AD,$CD,$4D,$4D,$CD,$CD

;--------------------------------------------------------------------

; Note: Something related to the world 6 cutscene

CODE_04F5FA:
	JSR.w CODE_04FA7B
	LDA.w $0F7F
	BNE.b CODE_04F605
	JMP.w CODE_04F9D5

CODE_04F605:
	JSR.w CODE_04FD66
	LDA.b #$20
	STA.b $00
	LDA.b #$04
	STA.b $01
if !Define_Global_ROMToAssemble&(!ROM_SMB1_U|!ROM_SMB1_E|!ROM_SMB1_J) != $00
	LDA.b #$03							;\ Glitch: This fixes a sneaky bug where this RAM address is not properly initialized
	STA.b $02							;/ $02 would get it's value from the VBlank routine, which would mess up this cutscene if modified.
endif
	LDX.b #$01
	LDA.b #$00
	JSL.l CODE_03C18F
	LDA.w !RAM_SMB1_NorSpr_YPosLo
	CMP.b #$A0
	BCS.b CODE_04F624
	LDA.b #$01
	STA.w $0B9D
CODE_04F624:
	LDA.w !RAM_SMB1_NorSpr_YPosLo
	CMP.b #$B8
	BCC.b CODE_04F64A
	LDA.b #$B8
	STA.w !RAM_SMB1_NorSpr_YPosLo
	STZ.w !RAM_SMB1_NorSpr_YSpeed
	STZ.w !RAM_SMB1_NorSpr_SubYSpeed
	STZ.w !RAM_SMB1_NorSpr_SubYPos
	LDA.w $0BA4
	CMP.b #!Define_SMAS_Sound0061_Jump						; Note: This must be the same value that's stored at $04FD6B
	BNE.b CODE_04F65A
	LDA.b #!Define_SMAS_Sound0060_YoshiSpit
	STA.w !RAM_SMB1_Global_SoundCh1
	STA.w $0BA4
	BRA.b CODE_04F65A

CODE_04F64A:
	LDY.w $0B9D
	LDA.w DATA_04EE5F,y
	TAY
	LDA.w !RAM_SMB1_NorSpr_YSpeed
	JSR.w CODE_04F6F9
	JMP.w CODE_04F9D5

CODE_04F65A:
	LDA.w $0B9C
	CMP.b #$02
	BEQ.b CODE_04F678
	INC.w $0B9C
	LDA.w $03AE
	SEC
	SBC.b #$08
	STA.w $03AE
	LDA.w !RAM_SMB1_NorSpr_XPosLo
	SEC
	SBC.b #$08
	STA.w !RAM_SMB1_NorSpr_XPosLo
	STZ.b !RAM_SMB1_Global_FrameCounter
CODE_04F678:
	LDA.w $0BA0
	BNE.b CODE_04F68C
	INC.w $0B9F
	LDA.w $0B9F
	CMP.b #$40
	BCC.b CODE_04F69B
	LDA.b #$40
	STA.w $0B9F
CODE_04F68C:
	INC.w $0BA0
	LDA.w $0BA0
	CMP.b #$88
	BCC.b CODE_04F69B
	LDA.b #$88
	STA.w $0BA0
CODE_04F69B:
	JSR.w CODE_04F74C
	JSR.w CODE_04FD29
	JMP.w CODE_04F9D5

;--------------------------------------------------------------------

CODE_04F6A4:
	LDA.w $03AE
	STA.w SMB1_OAMBuffer[$40].XDisp,y
	STA.w SMB1_OAMBuffer[$42].XDisp,y
	CLC
	ADC.b #$10
	STA.w SMB1_OAMBuffer[$41].XDisp,y
	STA.w SMB1_OAMBuffer[$43].XDisp,y
	LDA.w !RAM_SMB1_NorSpr_YPosLo
	STA.w SMB1_OAMBuffer[$40].YDisp,y
	STA.w SMB1_OAMBuffer[$41].YDisp,y
	CLC
	ADC.b #$10
	STA.w SMB1_OAMBuffer[$42].YDisp,y
	STA.w SMB1_OAMBuffer[$43].YDisp,y
	LDA.b #$CE
	STA.w SMB1_OAMBuffer[$40].Tile,y
	STA.w SMB1_OAMBuffer[$41].Tile,y
	STA.w SMB1_OAMBuffer[$42].Tile,y
	STA.w SMB1_OAMBuffer[$43].Tile,y
	LDA.b #$2D
	STA.w SMB1_OAMBuffer[$40].Prop,y
	LDA.b #$6D
	STA.w SMB1_OAMBuffer[$41].Prop,y
	LDA.b #$AD
	STA.w SMB1_OAMBuffer[$42].Prop,y
	LDA.b #$CD
	STA.w SMB1_OAMBuffer[$43].Prop,y
	LDA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$40].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$41].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$42].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$43].Slot,y
	RTS

;--------------------------------------------------------------------

CODE_04F6F9:
	LDA.w $03AE
	STA.w SMB1_OAMBuffer[$40].XDisp,y
	STA.w SMB1_OAMBuffer[$42].XDisp,y
	CLC
	ADC.b #$10
	STA.w SMB1_OAMBuffer[$41].XDisp,y
	STA.w SMB1_OAMBuffer[$43].XDisp,y
	LDA.w !RAM_SMB1_NorSpr_YPosLo
	STA.w SMB1_OAMBuffer[$42].YDisp,y
	STA.w SMB1_OAMBuffer[$43].YDisp,y
	CLC
	ADC.b #$08
	STA.w SMB1_OAMBuffer[$40].YDisp,y
	STA.w SMB1_OAMBuffer[$41].YDisp,y
	LDA.b #$CE
	STA.w SMB1_OAMBuffer[$42].Tile,y
	STA.w SMB1_OAMBuffer[$43].Tile,y
	LDA.b #$DE
	STA.w SMB1_OAMBuffer[$40].Tile,y
	STA.w SMB1_OAMBuffer[$41].Tile,y
	LDA.b #$2D
	STA.w SMB1_OAMBuffer[$40].Prop,y
	STA.w SMB1_OAMBuffer[$42].Prop,y
	LDA.b #$6D
	STA.w SMB1_OAMBuffer[$41].Prop,y
	STA.w SMB1_OAMBuffer[$43].Prop,y
	LDA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$40].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$41].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$42].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$43].Slot,y
	RTS

;--------------------------------------------------------------------

CODE_04F74C:
	LDA.w $0B9F
	SEC
	SBC.b #$28
	BPL.b CODE_04F756
	LDA.b #$00
CODE_04F756:
	LSR
	LSR
	STA.b $00
	LDA.w $0BA0
	AND.b #$08
	LSR
	LSR
	LSR
	STA.b $01
	LDA.w $03AE
	CLC
	ADC.w $0BA0
	CLC
	ADC.b $01
	STA.w SMB1_OAMBuffer[$40].XDisp
	STA.w SMB1_OAMBuffer[$44].XDisp
	CLC
	ADC.b #$10
	SEC
	SBC.b $01
	STA.w SMB1_OAMBuffer[$41].XDisp
	STA.w SMB1_OAMBuffer[$45].XDisp
	CLC
	ADC.b #$10
	SEC
	SBC.b $01
	STA.w SMB1_OAMBuffer[$42].XDisp
	STA.w SMB1_OAMBuffer[$46].XDisp
	LDA.w !RAM_SMB1_NorSpr_YPosLo
	SEC
	SBC.b $00
	CLC
	ADC.b $01
	STA.w SMB1_OAMBuffer[$44].YDisp
	STA.w SMB1_OAMBuffer[$45].YDisp
	STA.w SMB1_OAMBuffer[$46].YDisp
	CLC
	ADC.b #$08
	STA.w SMB1_OAMBuffer[$40].YDisp
	STA.w SMB1_OAMBuffer[$41].YDisp
	STA.w SMB1_OAMBuffer[$42].YDisp
	LDA.b #$DE
	STA.w SMB1_OAMBuffer[$40].Tile
	STA.w SMB1_OAMBuffer[$42].Tile
	LDA.b #$EC
	STA.w SMB1_OAMBuffer[$41].Tile
	LDA.b #$CE
	STA.w SMB1_OAMBuffer[$44].Tile
	STA.w SMB1_OAMBuffer[$46].Tile
	LDA.b #$EA
	STA.w SMB1_OAMBuffer[$45].Tile
	LDA.b #$2D
	STA.w SMB1_OAMBuffer[$40].Prop
	STA.w SMB1_OAMBuffer[$41].Prop
	STA.w SMB1_OAMBuffer[$44].Prop
	STA.w SMB1_OAMBuffer[$45].Prop
	LDA.b #$6D
	STA.w SMB1_OAMBuffer[$42].Prop
	STA.w SMB1_OAMBuffer[$46].Prop
	LDA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$40].Slot
	STA.w SMB1_OAMTileSizeBuffer[$41].Slot
	STA.w SMB1_OAMTileSizeBuffer[$42].Slot
	STA.w SMB1_OAMTileSizeBuffer[$44].Slot
	STA.w SMB1_OAMTileSizeBuffer[$45].Slot
	STA.w SMB1_OAMTileSizeBuffer[$46].Slot
	LDA.w $03AE
	CLC
	ADC.w $0BA0
	INC
	INC
	STA.w SMB1_OAMBuffer[$48].XDisp
	CLC
	ADC.b #$08
	STA.w SMB1_OAMBuffer[$49].XDisp
	INC
	STA.w SMB1_OAMBuffer[$4A].XDisp
	CLC
	ADC.b #$08
	STA.w SMB1_OAMBuffer[$4B].XDisp
	INC
	STA.w SMB1_OAMBuffer[$4C].XDisp
	CLC
	ADC.b #$08
	STA.w SMB1_OAMBuffer[$4D].XDisp
	INC
	STA.w SMB1_OAMBuffer[$4E].XDisp
	CLC
	ADC.b #$08
	STA.w SMB1_OAMBuffer[$4F].XDisp
	LDA.b #$C8
	STA.w SMB1_OAMBuffer[$48].YDisp
	STA.w SMB1_OAMBuffer[$49].YDisp
	STA.w SMB1_OAMBuffer[$4A].YDisp
	STA.w SMB1_OAMBuffer[$4B].YDisp
	STA.w SMB1_OAMBuffer[$4C].YDisp
	STA.w SMB1_OAMBuffer[$4D].YDisp
	STA.w SMB1_OAMBuffer[$4E].YDisp
	STA.w SMB1_OAMBuffer[$4F].YDisp
	LDA.w $0BA0
	AND.b #$0F
	CMP.b #$0F
	BNE.b CODE_04F846
	LDA.b #!Define_SMAS_Sound0060_Swim
	STA.w !RAM_SMB1_Global_SoundCh1
CODE_04F846:
	LDA.w $0BA0
	AND.b #$08
	ASL
	ORA.b #$CB
	STA.w SMB1_OAMBuffer[$48].Tile
	STA.w SMB1_OAMBuffer[$4A].Tile
	STA.w SMB1_OAMBuffer[$4C].Tile
	STA.w SMB1_OAMBuffer[$4E].Tile
	INC
	STA.w SMB1_OAMBuffer[$49].Tile
	STA.w SMB1_OAMBuffer[$4B].Tile
	STA.w SMB1_OAMBuffer[$4D].Tile
	STA.w SMB1_OAMBuffer[$4F].Tile
	LDA.b #$2D
	STA.w SMB1_OAMBuffer[$48].Prop
	STA.w SMB1_OAMBuffer[$49].Prop
	STA.w SMB1_OAMBuffer[$4A].Prop
	STA.w SMB1_OAMBuffer[$4B].Prop
	STA.w SMB1_OAMBuffer[$4C].Prop
	STA.w SMB1_OAMBuffer[$4D].Prop
	STA.w SMB1_OAMBuffer[$4E].Prop
	STA.w SMB1_OAMBuffer[$4F].Prop
	LDY.b #$00
CODE_04F883:
	LDA.w SMB1_OAMBuffer[$40].XDisp,y
	CMP.b #$40
	BCS.b CODE_04F88F
	LDA.b #$F0
	STA.w SMB1_OAMBuffer[$40].YDisp,y
CODE_04F88F:
	INY
	INY
	INY
	INY
	BNE.b CODE_04F883
	RTS

;--------------------------------------------------------------------

CODE_04F896:
	INC.w $0F7F
	LDA.w $0F7F
	CMP.b #$D0
	BCC.b CODE_04F8AB
	JSR.w CODE_04FD29
	LDA.b #$D0
	STA.w $0F7F
	JMP.w CODE_04F8BA

CODE_04F8AB:
	CMP.b #$20
	BCC.b CODE_04F8BA
	PHA
	AND.b #$0F
	BNE.b CODE_04F8B9
	LDA.b #!Define_SMAS_Sound0060_Swim
	STA.w !RAM_SMB1_Global_SoundCh1
CODE_04F8B9:
	PLA
CODE_04F8BA:
	LSR
	LSR
	LSR
	CMP.b #$03
	BCC.b CODE_04F8C3
	LDA.b #$03
CODE_04F8C3:
	PHA
	JSR.w CODE_04F8DC
	PLA
	CMP.b #$02
	BNE.b CODE_04F8D9
	LDA.w $0BA4
	BNE.b CODE_04F8D9
	LDA.b #!Define_SMAS_Sound0060_SMB2UPickupItem
	STA.w !RAM_SMB1_Global_SoundCh1
	STA.w $0BA4
CODE_04F8D9:
	JMP.w CODE_04F9D5

CODE_04F8DC:
	ASL
	ASL
	ASL
	TAX
	LDY.b #$08
	LDA.b #$88
	STA.w SMB1_OAMBuffer[$40].XDisp,y
	STA.w SMB1_OAMBuffer[$42].XDisp,y
	LDA.b #$90
	STA.w SMB1_OAMBuffer[$41].XDisp,y
	LDA.b #$B0
	STA.w SMB1_OAMBuffer[$40].YDisp,y
	STA.w SMB1_OAMBuffer[$41].YDisp,y
	LDA.b #$C0
	STA.w SMB1_OAMBuffer[$42].YDisp,y
	LDA.b #$80
	STA.w SMB1_OAMBuffer[$40].Tile,y
	INC
	STA.w SMB1_OAMBuffer[$41].Tile,y
	LDA.b #$A0
	STA.w SMB1_OAMBuffer[$42].Tile,y
	LDA.b #$2D
	STA.w SMB1_OAMBuffer[$40].Prop,y
	STA.w SMB1_OAMBuffer[$41].Prop,y
	STA.w SMB1_OAMBuffer[$42].Prop,y
	LDY.b #$00
CODE_04F917:
	LDA.w DATA_04F9B5,x
	STA.w SMB1_OAMBuffer[$40].XDisp,y
	INY
	INX
	CPY.b #$08
	BCC.b CODE_04F917
	LDA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$40].Slot
	STA.w SMB1_OAMTileSizeBuffer[$41].Slot
	STA.w SMB1_OAMTileSizeBuffer[$42].Slot
	STA.w SMB1_OAMTileSizeBuffer[$43].Slot
	STA.w SMB1_OAMTileSizeBuffer[$44].Slot
	LDA.b #$7E
	CLC
	ADC.w $0F7F
	STA.w SMB1_OAMBuffer[$47].XDisp
	CMP.b #$88
	BCS.b CODE_04F945
	LDA.b #$F0
	BRA.b CODE_04F947

CODE_04F945:
	LDA.b #$C0
CODE_04F947:
	STA.w SMB1_OAMBuffer[$47].YDisp
	LDA.b !RAM_SMB1_Global_FrameCounter
	LSR
	LSR
	AND.b #$02
	STA.b $01
	CLC
	ADC.b #$E6
	STA.w SMB1_OAMBuffer[$47].Tile
	LDA.b #$2D
	STA.w SMB1_OAMBuffer[$47].Prop
	LDA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$47].Slot
	LDY.b #$20
	LDX.b #$06
	LDA.b #$78
	CLC
	ADC.w $0F7F
	STA.b $00
CODE_04F96E:
	LDA.b $00
	STA.w SMB1_OAMBuffer[$40].XDisp,y
	STA.w SMB1_OAMBuffer[$41].XDisp,y
	CMP.b #$91
	BCS.b CODE_04F984
	LDA.b #$F0
	STA.w SMB1_OAMBuffer[$40].YDisp,y
	STA.w SMB1_OAMBuffer[$41].YDisp,y
	BRA.b CODE_04F98E

CODE_04F984:
	LDA.b #$C0
	STA.w SMB1_OAMBuffer[$40].YDisp,y
	LDA.b #$C8
	STA.w SMB1_OAMBuffer[$41].YDisp,y
CODE_04F98E:
	LDA.b #$BA
	CLC
	ADC.b $01
	STA.w SMB1_OAMBuffer[$40].Tile,y
	INC
	STA.w SMB1_OAMBuffer[$41].Tile,y
	LDA.b #$2D
	STA.w SMB1_OAMBuffer[$40].Prop,y
	STA.w SMB1_OAMBuffer[$41].Prop,y
	INY
	INY
	INY
	INY
	INY
	INY
	INY
	INY
	LDA.b $00
	SEC
	SBC.b #$0A
	STA.b $00
	DEX
	BNE.b CODE_04F96E
	RTS

DATA_04F9B5:
	db $98,$C0,$E4,$2D,$90,$C0,$A1,$2D
	db $99,$BF,$E4,$2D,$90,$C0,$A1,$2D
	db $9B,$BF,$E2,$2D,$90,$C0,$E0,$2D
	db $90,$C0,$E0,$2D,$90,$C0,$E0,$2D

;--------------------------------------------------------------------

CODE_04F9D5:
	LDA.w $0BA6
	BEQ.b CODE_04F9E1
	BMI.b CODE_04F9F8
	DEC.w $0BA6
	BRA.b CODE_04F9F8

CODE_04F9E1:
	LDA.w $0BA7
	BNE.b CODE_04F9F8
	INC.w $0BA7
	LDA.b #$B8
	STA.w $03CE
	LDA.w !RAM_SMB1_Player_CurrentSize
	BNE.b CODE_04F9F8
	LDA.b #$C8
	STA.w $03CE
CODE_04F9F8:
	PLY
	PLX
	PLB
	RTL

;--------------------------------------------------------------------

CODE_04F9FC:
	PHX
	STA.b $02
	ASL
	CLC
	ADC.b $02
	TAX
	LDA.b $00
	STA.w SMB1_OAMBuffer[$40].XDisp,y
	STA.w SMB1_OAMBuffer[$42].XDisp,y
	CLC
	ADC.b #$08
	STA.w SMB1_OAMBuffer[$41].XDisp,y
	LDA.b $01
	STA.w SMB1_OAMBuffer[$40].YDisp,y
	STA.w SMB1_OAMBuffer[$41].YDisp,y
	CLC
	ADC.b #$08
	STA.w SMB1_OAMBuffer[$42].YDisp,y
	LDA.w DATA_04FA4B,x
	STA.w SMB1_OAMBuffer[$40].Tile,y
	LDA.w DATA_04FA4B+$01,x
	STA.w SMB1_OAMBuffer[$41].Tile,y
	LDA.w DATA_04FA4B+$02,x
	STA.w SMB1_OAMBuffer[$42].Tile,y
	LDA.w DATA_04FA63,x
	STA.w SMB1_OAMBuffer[$40].Prop,y
	LDA.w DATA_04FA63+$01,x
	STA.w SMB1_OAMBuffer[$41].Prop,y
	LDA.w DATA_04FA63+$02,x
	STA.w SMB1_OAMBuffer[$42].Prop,y
	LDA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$42].Slot,y
	PLX
	RTS

DATA_04FA4B:
	db $B6,$B6,$C9,$B7
	db $B7,$CB,$B8,$B9
	db $EC,$B9,$B8,$EC
	db $E3,$E2,$E4,$F3
	db $F2,$E6,$E2,$E3
	db $E4,$F2,$F3,$E6

DATA_04FA63:
	db $2D,$6D,$2D,$2D
	db $6D,$2D,$2D,$2D
	db $2D,$6D,$6D,$6D
	db $6D,$6D,$6D,$6D
	db $6D,$6D,$2D,$2D
	db $2D,$2D,$2D,$2D

;--------------------------------------------------------------------

CODE_04FA7B:
	DEC.w $0F7D
	LDA.w $0F7D
	BPL.b CODE_04FA8B
	INC.w $0F7F
	LDA.b #$07
	STA.w $0F7D
CODE_04FA8B:
	LDA.w $0F7F
	CMP.b #$03
	BCC.b CODE_04FA97
	LDA.b #$03
	STA.w $0F7F
CODE_04FA97:
	PHX
	ASL
	TAX
	LDA.w DATA_04FAA7,x
	STA.b $00
	LDA.w DATA_04FAA7+$01,x
	STA.b $01
	JMP.w ($0000)

DATA_04FAA7:
	dw CODE_04FAAF
	dw CODE_04FB18
	dw CODE_04FB5E
	dw CODE_04FB77

CODE_04FAAF:
	LDA.b #$94
	STA.w SMB1_OAMBuffer[$56].XDisp
	LDA.b #$BB
	STA.w SMB1_OAMBuffer[$56].YDisp
	LDA.b #$C0
	STA.w SMB1_OAMBuffer[$56].Tile
	LDA.b #$2D
	STA.w SMB1_OAMBuffer[$56].Prop
	LDA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$56].Slot
	LDA.b #$88
	STA.w SMB1_OAMBuffer[$58].XDisp
	STA.w SMB1_OAMBuffer[$5C].XDisp
	LDA.b #$90
	STA.w SMB1_OAMBuffer[$59].XDisp
	STA.w SMB1_OAMBuffer[$5D].XDisp
	LDA.b #$C0
	STA.w SMB1_OAMBuffer[$5C].YDisp
	STA.w SMB1_OAMBuffer[$5D].YDisp
	LDA.b #$9C
	STA.w SMB1_OAMBuffer[$5C].Tile
	INC
	STA.w SMB1_OAMBuffer[$5D].Tile
	LDA.b #$B8
	STA.w SMB1_OAMBuffer[$58].YDisp
	STA.w SMB1_OAMBuffer[$59].YDisp
	LDA.b #$8C
	STA.w SMB1_OAMBuffer[$58].Tile
	INC
	STA.w SMB1_OAMBuffer[$59].Tile
	LDA.b #$2D
	STA.w SMB1_OAMBuffer[$5C].Prop
	STA.w SMB1_OAMBuffer[$5D].Prop
	STA.w SMB1_OAMBuffer[$58].Prop
	STA.w SMB1_OAMBuffer[$59].Prop
	LDA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$5C].Slot
	STA.w SMB1_OAMTileSizeBuffer[$5D].Slot
	STA.w SMB1_OAMTileSizeBuffer[$58].Slot
	STA.w SMB1_OAMTileSizeBuffer[$59].Slot
	PLX
	RTS

CODE_04FB18:
	LDA.b #$9A
	STA.w SMB1_OAMBuffer[$56].XDisp
	LDA.b #$BE
	STA.w SMB1_OAMBuffer[$56].YDisp
	LDA.b #$C2
	STA.w SMB1_OAMBuffer[$56].Tile
	LDA.b #$2D
	STA.w SMB1_OAMBuffer[$56].Prop
	LDA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$56].Slot
	LDA.b #$88
	STA.w SMB1_OAMBuffer[$5C].XDisp
	LDA.b #$90
	STA.w SMB1_OAMBuffer[$5D].XDisp
	LDA.b #$C0
	STA.w SMB1_OAMBuffer[$5C].YDisp
	STA.w SMB1_OAMBuffer[$5D].YDisp
	LDA.b #$99
	STA.w SMB1_OAMBuffer[$5C].Tile
	INC
	STA.w SMB1_OAMBuffer[$5D].Tile
	LDA.b #$2D
	STA.w SMB1_OAMBuffer[$5C].Prop
	STA.w SMB1_OAMBuffer[$5D].Prop
	LDA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$5C].Slot
	STA.w SMB1_OAMTileSizeBuffer[$5D].Slot
	PLX
	RTS

;--------------------------------------------------------------------

CODE_04FB5E:
	LDA.b #$9C
	STA.w SMB1_OAMBuffer[$56].XDisp
	LDA.b #$C1
	STA.w SMB1_OAMBuffer[$56].YDisp
	LDA.b #$C4
	STA.w SMB1_OAMBuffer[$56].Tile
	LDA.b #$2D
	STA.w SMB1_OAMBuffer[$56].Prop
	LDA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$56].Slot
CODE_04FB77:
	LDA.b #$88
	STA.w SMB1_OAMBuffer[$5C].XDisp
	LDA.b #$90
	STA.w SMB1_OAMBuffer[$5D].XDisp
	LDA.b #$C0
	STA.w SMB1_OAMBuffer[$5C].YDisp
	STA.w SMB1_OAMBuffer[$5D].YDisp
	LDA.b #$C6
	STA.w SMB1_OAMBuffer[$5C].Tile
	INC
	STA.w SMB1_OAMBuffer[$5D].Tile
	LDA.b #$2D
	STA.w SMB1_OAMBuffer[$5C].Prop
	STA.w SMB1_OAMBuffer[$5D].Prop
	LDA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$5C].Slot
	STA.w SMB1_OAMTileSizeBuffer[$5D].Slot
	PLX
	RTS

;--------------------------------------------------------------------

CODE_04FBA4:
	LDA.b #!Define_SMAS_Sound0060_HurtWhileFlying
	STA.w !RAM_SMB1_Global_SoundCh1
	LDA.w !RAM_SMB1_Player_CurrentSize
	EOR.b #$01
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC.b #$E0
	CLC
	ADC.b #$08
	STA.w $03CE
	LDY.b #$9C
	LDA.b #$0B
	STA.b $01
	STZ.b $00
	LDA.b #$00
CODE_04FBC5:
	STA.b ($00),y
	INY
	CPY.b #$BF
	BNE.b CODE_04FBC5
	INC.w !RAM_SMB1_Cutscene_ToadHasBeenInitializedFlag
	DEC.w $0BA6
	LDA.w !RAM_SMB1_Player_CurrentWorld
	ASL
	TAX
	LDA.w DATA_04FBE4,x
	STA.b $00
	LDA.w DATA_04FBE4+$01,x
	STA.b $01
	JMP.w ($0000)

DATA_04FBE4:
	dw CODE_04FBFE
	dw CODE_04FC26
	dw CODE_04FC4E
	dw CODE_04FC7C
	dw CODE_04FCAE
	dw CODE_04FCD4
	dw CODE_04FCEE
	dw CODE_04FBFE
	dw CODE_04FBFE
	dw CODE_04FCAE
	dw CODE_04FCD4
	dw CODE_04FCEE
	dw CODE_04FBFE

;--------------------------------------------------------------------

CODE_04FBFE:
	LDA.w !RAM_SMB1_NorSpr_XPosLo
	SEC
	SBC.b #$04
	STA.w !RAM_SMB1_NorSpr_XPosLo
	LDA.w $03AE
	SEC
	SBC.b #$04
	STA.w $03AE
	LDA.b #$08
	STA.w $0F7D
	LDA.b #!Define_SMAS_Sound0061_Jump
	STA.w !RAM_SMB1_Global_SoundCh2
	LDA.b #$FE
	STA.w !RAM_SMB1_NorSpr_YSpeed
	STZ.w !RAM_SMB1_NorSpr_SubYSpeed
	STZ.w !RAM_SMB1_NorSpr_SubYPos
	RTS

;--------------------------------------------------------------------

CODE_04FC26:
	LDA.w !RAM_SMB1_NorSpr_XPosLo
	SEC
	SBC.b #$0C
	STA.w !RAM_SMB1_NorSpr_XPosLo
	LDA.w $03AE
	SEC
	SBC.b #$0C
	STA.w $03AE
	LDA.b #$08
	STA.w $0F7D
	LDA.b #!Define_SMAS_Sound0061_Jump
	STA.w !RAM_SMB1_Global_SoundCh2
	LDA.b #$FE
	STA.w !RAM_SMB1_NorSpr_YSpeed
	STZ.w !RAM_SMB1_NorSpr_SubYSpeed
	STZ.w !RAM_SMB1_NorSpr_SubYPos
	RTS

;--------------------------------------------------------------------

CODE_04FC4E:
	LDA.w !RAM_SMB1_NorSpr_XPosLo
	SEC
	SBC.b #$04
	STA.w !RAM_SMB1_NorSpr_XPosLo
	LDA.w $03AE
	SEC
	SBC.b #$04
	STA.w $03AE
	LDA.b #$08
	STA.w $0F7D
	STZ.w $021D
	LDA.b #!Define_SMAS_Sound0061_Jump
	STA.w !RAM_SMB1_Global_SoundCh2
	LDA.b #$FE
	STA.w !RAM_SMB1_NorSpr_YSpeed
	STZ.w !RAM_SMB1_NorSpr_SubYSpeed
	STZ.w !RAM_SMB1_NorSpr_SubYPos
	STZ.w $0BA0
	RTS

;--------------------------------------------------------------------

CODE_04FC7C:
	LDA.w !RAM_SMB1_NorSpr_XPosLo
	SEC
	SBC.b #$04
	STA.w !RAM_SMB1_NorSpr_XPosLo
	LDA.w $03AE
	SEC
	SBC.b #$04
	STA.w $03AE
	STA.w $0BB0
	STA.w $0BB1
	STA.w $0BB2
	STA.w $0BB3
	LDA.b #!Define_SMAS_Sound0061_Jump
	STA.w !RAM_SMB1_Global_SoundCh2
	LDA.b #$FE
	STA.w !RAM_SMB1_NorSpr_YSpeed
	STZ.w !RAM_SMB1_NorSpr_SubYSpeed
	STZ.w !RAM_SMB1_NorSpr_SubYPos
	STZ.w $0E67
	RTS

;--------------------------------------------------------------------

CODE_04FCAE:
	LDA.w !RAM_SMB1_NorSpr_XPosLo
	SEC
	SBC.b #$0C
	STA.w !RAM_SMB1_NorSpr_XPosLo
	LDA.w !RAM_SMB1_NorSpr_YPosLo
	SEC
	SBC.b #$0C
	STA.w !RAM_SMB1_NorSpr_YPosLo
	LDA.b #!Define_SMAS_Sound0061_Jump
	STA.w !RAM_SMB1_Global_SoundCh2
	LDA.b #$FE
	STA.w $0B9E
	STA.w !RAM_SMB1_NorSpr_YSpeed
	STZ.w !RAM_SMB1_NorSpr_SubYSpeed
	STZ.w !RAM_SMB1_NorSpr_SubYPos
	RTS

;--------------------------------------------------------------------

CODE_04FCD4:
	LDA.w !RAM_SMB1_NorSpr_XPosLo
	SEC
	SBC.b #$0C
	STA.w !RAM_SMB1_NorSpr_XPosLo
	LDA.b #!Define_SMAS_Sound0061_Jump
	STA.w !RAM_SMB1_Global_SoundCh2
	LDA.b #$FD
	STA.w !RAM_SMB1_NorSpr_YSpeed
	STZ.w !RAM_SMB1_NorSpr_SubYSpeed
	STZ.w !RAM_SMB1_NorSpr_SubYPos
	RTS

;--------------------------------------------------------------------

CODE_04FCEE:
	STZ.w !RAM_SMB1_Global_SoundCh1
	LDA.b #$FE
	STA.w !RAM_SMB1_NorSpr_YSpeed
	STZ.w !RAM_SMB1_NorSpr_SubYSpeed
	STZ.w !RAM_SMB1_NorSpr_SubYPos
	RTS

;--------------------------------------------------------------------

; Note: Something related to the rusting bag sprite.

CODE_04FCFD:
	REP.b #$20
	SEC
	SBC.w #$0008
	SEC
	SBC.w $0042
	STA.b $01
	SEP.b #$20
	STA.w SMB1_OAMBuffer[$40].XDisp,y
	STA.w SMB1_OAMBuffer[$42].XDisp,y
	LDA.b #$2D
	STA.w SMB1_OAMBuffer[$40].Prop,y
	STA.w SMB1_OAMBuffer[$42].Prop,y
	XBA
	CMP.b #$00
	BEQ.b CODE_04FD20
	LDA.b #$01
CODE_04FD20:
	ORA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$40].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$42].Slot,y
	RTS

;--------------------------------------------------------------------

CODE_04FD29:
	LDA.w $03CE
	CMP.b #$D0
	BCC.b CODE_04FD42
	AND.b #$08
	BEQ.b CODE_04FD42
	LDA.w $03CE
	SEC
	SBC.b #$08
	STA.w $03CE
	LDA.b #$30
	STA.w $0BA6
CODE_04FD42:
	RTS

;--------------------------------------------------------------------

CODE_04FD43:
	LDA.w !RAM_SMB1_Global_CurrentLayer3XPosLo
	BEQ.b CODE_04FD4C
	DEC.w !RAM_SMB1_Global_CurrentLayer3XPosLo
	RTS

CODE_04FD4C:
	LDA.w $0BA3
	CMP.b #$C0
	BCS.b CODE_04FD61
	INC.w $0BA3
	LDA.w $0BA3
	CMP.b #$C0
	BNE.b CODE_04FD60
	JSR.w CODE_04FD74
CODE_04FD60:
	RTS

CODE_04FD61:
	JSL.l CODE_048600
	RTS

;--------------------------------------------------------------------

CODE_04FD66:
	LDA.w $0BA4
	BNE.b CODE_04FD73
	LDA.b #!Define_SMAS_Sound0061_Jump
	STA.w !RAM_SMB1_Global_SoundCh2
	STA.w $0BA4
CODE_04FD73:
	RTS

;--------------------------------------------------------------------

; Note: Something to do with displaying "Push Start" on the ending screen.

CODE_04FD74:
	REP.b #$20
	PHD
	LDA.w #!RAM_SMB1_Global_StripeImageUploadIndexLo
	TCD
	LDA.w #$F15A
	STA.b SMB1_StripeImageUploadTable[$00].LowByte
	LDA.w #$1300
	STA.b SMB1_StripeImageUploadTable[$01].LowByte
	LDA.w #$0019
	STA.b SMB1_StripeImageUploadTable[$02].LowByte
	LDA.w #$001E
	STA.b SMB1_StripeImageUploadTable[$03].LowByte
	LDA.w #$001C
	STA.b SMB1_StripeImageUploadTable[$04].LowByte
	LDA.w #$0011
	STA.b SMB1_StripeImageUploadTable[$05].LowByte
	LDA.w #$0028
	STA.b SMB1_StripeImageUploadTable[$06].LowByte
	LDA.w #$001C
	STA.b SMB1_StripeImageUploadTable[$07].LowByte
	LDA.w #$001D
	STA.b SMB1_StripeImageUploadTable[$08].LowByte
	LDA.w #$000A
	STA.b SMB1_StripeImageUploadTable[$09].LowByte
	LDA.w #$001B
	STA.b SMB1_StripeImageUploadTable[$0A].LowByte
	LDA.w #$001D
	STA.b SMB1_StripeImageUploadTable[$0B].LowByte
	SEP.b #$20
	LDA.b #$FF
	STA.b SMB1_StripeImageUploadTable[$0C].LowByte
	PLD
	LDA.b #!Define_SMAS_Sound0063_OverworldTileReveal
	STA.w !RAM_SMB1_Global_SoundCh3
	RTS

;--------------------------------------------------------------------

CODE_04FDC4:
	STZ.w !RAM_SMB1_Global_CurrentLayer1XPosLo
	STZ.w !RAM_SMB1_Global_CurrentLayer1YPosLo
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
	RTL

if !Define_Global_ROMToAssemble&(!ROM_SMB1_U|!ROM_SMB1_E|!ROM_SMB1_J) != $00
	%FREE_BYTES(NULLROM, 525, $FF)
else
	%FREE_BYTES(NULLROM, 529, $FF)
endif
%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro SMB1Bank05Macros(StartBank, EndBank)
if !Define_Global_ROMToAssemble&(!ROM_SMB1_U|!ROM_SMB1_E|!ROM_SMB1_J) != $00
%BANK_START(<StartBank>)
endif
CODE_058000:
	STZ.w !RAM_SMB1_Global_EnableLayer3BGFlag
	PHB
	LDA.b #!RAM_SMB1_Global_Layer2BGData>>16
	PHA
	PLB
	REP.b #$30
	LDX.w #$0000
	LDA.w #$0000
CODE_058010:
	STA.w !RAM_SMB1_Global_Layer2BGData,x
	STA.w !RAM_SMB1_Global_Layer2BGData+$0100,x
	STA.w !RAM_SMB1_Global_Layer2BGData+$0200,x
	STA.w !RAM_SMB1_Global_Layer2BGData+$0300,x
	STA.w !RAM_SMB1_Global_Layer2BGData+$0400,x
	STA.w !RAM_SMB1_Global_Layer2BGData+$0500,x
	STA.w !RAM_SMB1_Global_Layer2BGData+$0600,x
	STA.w !RAM_SMB1_Global_Layer2BGData+$0700,x
	STA.w !RAM_SMB1_Global_Layer2BGData+$0800,x
	STA.w !RAM_SMB1_Global_Layer2BGData+$0900,x
	STA.w !RAM_SMB1_Global_Layer2BGData+$0A00,x
	STA.w !RAM_SMB1_Global_Layer2BGData+$0B00,x
	STA.w !RAM_SMB1_Global_Layer2BGData+$0C00,x
	INX
	INX
	CPX.w #$0100
	BNE.b CODE_058010
	PLB
	PHB
	PHK
	PLB
	STZ.w $0EC0
	LDA.w $0E65
	AND.w #$00FF
	BEQ.b CODE_05804F
	STA.b $DB
CODE_05804F:
	LDA.b $DB
	AND.w #$00FF
	ASL
	TAX
	LDA.w DATA_05AD04,x
	STA.b $02
CODE_05805B:
	REP.b #$30
	LDX.b $02
	LDA.w DATA_05B557,x
	STA.b $04
	INC.b $02
	INC.b $02
	AND.w #$03F0
	LSR
	LSR
	LSR
	LSR
	STA.b !RAM_SMB1_Global_ScratchRAMEF
	LDA.b $04
	AND.w #$000F
	STA.b !RAM_SMB1_Global_ScratchRAMF1
	LDA.b $04
	AND.w #$E000
	STA.b !RAM_SMB1_Global_ScratchRAMED
	LDA.b $04
	LSR
	AND.w #$0E00
	ORA.b !RAM_SMB1_Global_ScratchRAMED
	XBA
	STA.b !RAM_SMB1_Global_ScratchRAMED
	AND.w #$00F0
	CMP.w #$00E0
	BNE.b CODE_0580B3
	LDA.b !RAM_SMB1_Global_ScratchRAMEF
	CMP.w #$003F
	BNE.b CODE_0580AE
	INC.w $0EC0
	INC.w $0EC0
	LDA.w $0EC0
	XBA
	TAX
	LDA.w #$FFFF
	STA.l !RAM_SMB1_Global_Layer2BGData,x
	JMP.w SMB1_GenerateLayer2Map16_Main

CODE_0580AE:
	JSR.w CODE_058F19
	BRA.b CODE_05805B

CODE_0580B3:
	LDA.w $0EC0
	XBA
	CLC
	ADC.b !RAM_SMB1_Global_ScratchRAMED
	STA.b !RAM_SMB1_Global_ScratchRAMEB
	LDA.b !RAM_SMB1_Global_ScratchRAMEF
	CMP.w #$0010
	BCC.b CODE_0580C9
	JSR.w CODE_058E85
	JMP.w CODE_05805B

CODE_0580C9:						; Note: Something to do with loading layer 2 BGs.
	ASL
	TAX
	LDA.b $DB
	ASL
	TAY
	LDA.w DATA_0580E1,y
	STA.b $04
	LDA.w #DATA_0580E1>>16
	STA.b $06
	TXY
	LDA.b [$04],y
	STA.b $00
	JMP.w ($0000)

DATA_0580E1:
.UnderwaterLevelBGs:
	dw DATA_058141					; $00 - Glitched?
	dw DATA_058141					; $01 - Glitched?
	dw DATA_05812B					; $02 - Underwater ruins

.OverworldLevelBGs:
	dw DATA_058149					; $03 - Starry sky
	dw DATA_05812D					; $04 - Castle wall
	dw DATA_058149					; $05 - Hills and Trees
	dw DATA_058149					; $06 - Starry Sky Hills (Grassland)
	dw DATA_058149					; $07 - Starry Sky Hills (Snowy)
	dw DATA_058149					; $08 - Small Hills
	dw DATA_0581DF					; $09 - Waterfalls
	dw DATA_058125					; $0A - Goomba Pillars
	dw DATA_0581A7					; $0B - Dotted Hills (Green)
	dw DATA_058149					; $0C - Big Hills
	dw DATA_0581A7					; $0D - Dotted Hills (Snowy)
	dw DATA_058149					; $0E - Bonus (Underground, bright sky)
	dw DATA_0581C7					; $0F - Mushroom Platforms
	dw DATA_058149					; $10 - Starry Sky
	dw DATA_058149					; $11 - Starry Sky Hills (Grassland)
	dw DATA_0581C7					; $12 - Mushroom Platforms (Glitched?)
	dw DATA_058149					; $13 - Medium Hills
	dw DATA_0581A7					; $14 - Dotted Hills (Snowy)
	dw DATA_0581A7					; $15 - Dotted Hills (Autumn)
	dw DATA_0581A7					; $16 - Dotted Hills (Snowy)
	dw DATA_058149					; $17 - Bonus (Underground, dark sky)
	dw DATA_058149					; $18 - Starry Sky Hills (Snowy)

.UndergroundLevelBGs:
	dw DATA_058169					; $19 - Underground
	dw DATA_058169					; $1A - Underground
	dw DATA_058149					; $1B - Bonus (Underground, bright sky)

.CastleLevelBGs:
	dw DATA_05818F					; $1C - Castle Interior
	dw DATA_05818F					; $1D - Castle Interior
	dw DATA_05818F					; $1E - Castle Interior
	dw DATA_05818F					; $1F - Castle Interior
	dw DATA_05818F					; $20 - Castle Interior
	dw DATA_05816F					; $21 - Final Castle

DATA_058125:
	dw CODE_05823F
	dw CODE_058244
	dw CODE_0581F5

DATA_05812B:
	dw CODE_0582E2

DATA_05812D:
	dw CODE_059004
	dw CODE_05864E
	dw CODE_05864C
	dw CODE_058643
	dw CODE_058639
	dw CODE_05864E
	dw CODE_05864E
	dw CODE_058639
	dw CODE_05864C
	dw CODE_05864E

DATA_058141:
	dw CODE_058724
	dw CODE_058726
	dw CODE_05875E
	dw CODE_058760

DATA_058149:
	dw CODE_058995
	dw CODE_0586E9
	dw CODE_0586E9
	dw CODE_0586E9
	dw CODE_058845
	dw CODE_058843
	dw CODE_05883A
	dw CODE_058838
	dw CODE_0587EA
	dw CODE_0587F4
	dw CODE_058800
	dw CODE_05880C
	dw CODE_058818
	dw CODE_058824
	dw CODE_05882C
	dw CODE_05848D

DATA_058169:
	dw CODE_0589E0
	dw CODE_0589FD
	dw CODE_058A2E

DATA_05816F:
	dw CODE_0585EE
	dw CODE_0585EC
	dw CODE_0585EE
	dw CODE_0585EC
	dw CODE_0585EE
	dw CODE_0585EC
	dw CODE_0585EE
	dw CODE_0585EC
	dw CODE_0585EE
	dw CODE_0585EC
	dw CODE_0585EE
	dw CODE_0585EC
	dw CODE_0585EE
	dw CODE_0585EC
	dw CODE_0585EE
	dw CODE_0585EC

DATA_05818F:
	dw CODE_058B51
	dw CODE_058B51
	dw CODE_058B8F
	dw CODE_058C66
	dw CODE_058CE0
	dw CODE_058D8A
	dw CODE_058B22
	dw CODE_058A68
	dw CODE_058AD5
	dw CODE_058DD3
	dw CODE_058DD1
	dw CODE_058DC5

DATA_0581A7:
	dw CODE_058699
	dw CODE_058699
	dw CODE_058699
	dw CODE_058699
	dw CODE_058699
	dw CODE_058699
	dw CODE_058699
	dw CODE_058699
	dw CODE_058699
	dw CODE_058699
	dw CODE_058699
	dw CODE_058699
	dw CODE_058699
	dw CODE_058699
	dw CODE_058699
	dw CODE_058699

DATA_0581C7:
	dw CODE_058445
	dw CODE_058443
	dw CODE_058439
	dw CODE_058437
	dw CODE_058432
	dw CODE_058430
	dw CODE_058426
	dw CODE_058424
	dw CODE_0583E9
	dw CODE_0583E7
	dw CODE_0583DD
	dw CODE_0583DB

DATA_0581DF:
	dw CODE_058307

;--------------------------------------------------------------------

DATA_0581E1:
	db $07,$0A,$0B,$12,$19
	db $29,$2A,$33,$34,$30
	db $00,$07,$0A,$1D,$19
	db $00,$29,$2A,$2D,$30

CODE_0581F5:
	LDY.b !RAM_SMB1_Global_ScratchRAMF1
	LDX.b !RAM_SMB1_Global_ScratchRAMEB
	SEP.b #$20
	LDA.w DATA_0581E1,y
	STA.l !RAM_SMB1_Global_Layer2BGData,x
	LDA.w DATA_0581E1+$01,y
	STA.l !RAM_SMB1_Global_Layer2BGData+$10,x
	LDA.w DATA_0581E1+$02,y
	STA.l !RAM_SMB1_Global_Layer2BGData+$20,x
	LDA.w DATA_0581E1+$03,y
	STA.l !RAM_SMB1_Global_Layer2BGData+$30,x
	LDA.w DATA_0581E1+$04,y
	STA.l !RAM_SMB1_Global_Layer2BGData+$40,x
	REP.b #$20
	JMP.w CODE_05805B

;--------------------------------------------------------------------

DATA_058223:
	db $01,$02,$03,$04,$08,$09,$05,$06,$10,$11,$17,$18,$1B,$1C
	db $1F,$20,$21,$22,$25,$26,$23,$24,$2B,$2C,$2E,$2F,$31,$32

CODE_05823F:
	LDY.w #$000E
	BRA.b CODE_058247

CODE_058244:
	LDY.w #$0000
CODE_058247:
	LDX.b !RAM_SMB1_Global_ScratchRAMEB
	INX
	SEP.b #$20
	LDA.w DATA_058223,y
	STA.l !RAM_SMB1_Global_Layer2BGData,x
	LDA.w DATA_058223+$01,y
	STA.l !RAM_SMB1_Global_Layer2BGData+$01,x
	LDA.w DATA_058223+$02,y
	STA.l !RAM_SMB1_Global_Layer2BGData+$10,x
	LDA.w DATA_058223+$03,y
	STA.l !RAM_SMB1_Global_Layer2BGData+$11,x
	LDA.w DATA_058223+$06,y
	STA.l !RAM_SMB1_Global_Layer2BGData+$20,x
	LDA.w DATA_058223+$07,y
	STA.l !RAM_SMB1_Global_Layer2BGData+$21,x
	LDA.b #$30
	STA.b !RAM_SMB1_Global_ScratchRAME4
	STZ.b !RAM_SMB1_Global_ScratchRAME5
CODE_05827C:
	REP.b #$20
	TXA
	CLC
	ADC.b !RAM_SMB1_Global_ScratchRAME4
	TAX
	SEP.b #$20
	CMP.b #$D0
	BCS.b CODE_0582AD
	LDA.w DATA_058223+$04,y
	STA.l !RAM_SMB1_Global_Layer2BGData,x
	LDA.w DATA_058223+$05,y
	STA.l !RAM_SMB1_Global_Layer2BGData+$01,x
	LDA.w DATA_058223+$06,y
	STA.l !RAM_SMB1_Global_Layer2BGData+$10,x
	LDA.w DATA_058223+$07,y
	STA.l !RAM_SMB1_Global_Layer2BGData+$11,x
	LDA.b #$20
	STA.b !RAM_SMB1_Global_ScratchRAME4
	STZ.b !RAM_SMB1_Global_ScratchRAME5
	BRA.b CODE_05827C

CODE_0582AD:
	LDA.w DATA_058223+$08,y
	STA.l !RAM_SMB1_Global_Layer2BGData,x
	LDA.w DATA_058223+$09,y
	STA.l !RAM_SMB1_Global_Layer2BGData+$01,x
	LDA.w DATA_058223+$0A,y
	STA.l !RAM_SMB1_Global_Layer2BGData+$10,x
	LDA.w DATA_058223+$0B,y
	STA.l !RAM_SMB1_Global_Layer2BGData+$11,x
	LDA.w DATA_058223+$0C,y
	STA.l !RAM_SMB1_Global_Layer2BGData+$20,x
	LDA.w DATA_058223+$0D,y
	STA.l !RAM_SMB1_Global_Layer2BGData+$21,x
	REP.b #$20
	JMP.w CODE_05805B

;--------------------------------------------------------------------

; Note: Routine that buffers the underwater ruins BG.

DATA_0582DC:
	dw DATA_05B494-DATA_05B494
	dw DATA_05B4D5-DATA_05B494
	dw DATA_05B516-DATA_05B494

CODE_0582E2:
	LDA.b !RAM_SMB1_Global_ScratchRAMF1
	ASL
	TAY
	LDA.w DATA_0582DC,y
	TAY
	LDA.b !RAM_SMB1_Global_ScratchRAMEB
	CLC
	ADC.w #$0010
	TAX
	SEP.b #$20
CODE_0582F3:
	LDA.w DATA_05B494,y
	CMP.b #$FF
	BEQ.b CODE_058302
	STA.l !RAM_SMB1_Global_Layer2BGData,x
	INY
	INX
	BRA.b CODE_0582F3

CODE_058302:
	REP.b #$20
	JMP.w CODE_05805B

;--------------------------------------------------------------------

CODE_058307:
	LDX.b !RAM_SMB1_Global_ScratchRAMEB
	LDA.b !RAM_SMB1_Global_ScratchRAMF1
	STA.b !RAM_SMB1_Global_ScratchRAME6
	SEP.b #$20
	STZ.b !RAM_SMB1_Global_ScratchRAME8
CODE_058311:
	LDA.b #$09
	STA.l !RAM_SMB1_Global_Layer2BGData,x
	LDA.b #$0E
	STA.l !RAM_SMB1_Global_Layer2BGData+$10,x
	STA.l !RAM_SMB1_Global_Layer2BGData+$30,x
	STA.l !RAM_SMB1_Global_Layer2BGData+$50,x
	LDA.b #$12
	STA.l !RAM_SMB1_Global_Layer2BGData+$20,x
	STA.l !RAM_SMB1_Global_Layer2BGData+$40,x
	INX
	REP.b #$20
	TXA
	AND.w #$000F
	BNE.b CODE_058340
	TXA
	CLC
	ADC.w #$00F0
	TAX
	INC.b !RAM_SMB1_Global_ScratchRAME8
CODE_058340:
	SEP.b #$20
	DEC.b !RAM_SMB1_Global_ScratchRAME6
	LDA.b !RAM_SMB1_Global_ScratchRAME6
	BMI.b CODE_05837F
	LDA.b #$09
	STA.l !RAM_SMB1_Global_Layer2BGData,x
	LDA.b #$0F
	STA.l !RAM_SMB1_Global_Layer2BGData+$10,x
	STA.l !RAM_SMB1_Global_Layer2BGData+$30,x
	STA.l !RAM_SMB1_Global_Layer2BGData+$50,x
	LDA.b #$13
	STA.l !RAM_SMB1_Global_Layer2BGData+$20,x
	STA.l !RAM_SMB1_Global_Layer2BGData+$40,x
	INX
	REP.b #$20
	TXA
	AND.w #$000F
	BNE.b CODE_058377
	TXA
	CLC
	ADC.w #$00F0
	TAX
	INC.b !RAM_SMB1_Global_ScratchRAME8
CODE_058377:
	SEP.b #$20
	DEC.b !RAM_SMB1_Global_ScratchRAME6
	LDA.b !RAM_SMB1_Global_ScratchRAME6
	BPL.b CODE_058311
CODE_05837F:
	LDX.b !RAM_SMB1_Global_ScratchRAMEB
	LDA.b !RAM_SMB1_Global_ScratchRAMF1
	CMP.b #$04
	BCC.b CODE_058389
	LDA.b #$04
CODE_058389:
	TAY
	LDA.w DATA_0583B0,y
	STA.l !RAM_SMB1_Global_Layer2BGData-$01,x
	REP.b #$20
	LDA.b !RAM_SMB1_Global_ScratchRAME8
	BEQ.b CODE_05839D
	TXA
	CLC
	ADC.w #$00F0
	TAX
CODE_05839D:
	TXA
	CLC
	ADC.b !RAM_SMB1_Global_ScratchRAMF1
	TAX
	SEP.b #$20
	LDA.w DATA_0583B5,y
	STA.l !RAM_SMB1_Global_Layer2BGData+$01,x
	REP.b #$20
	JMP.w CODE_05805B

DATA_0583B0:
	db $08,$08,$04,$04,$08

DATA_0583B5:
	db $0A,$06,$0A,$06,$0A

;--------------------------------------------------------------------

DATA_0583BA:
	db $01,$02,$03,$02
	db $04,$01,$02,$02
	db $03,$02,$02,$04
	db $07,$08,$09,$07
	db $0E,$08,$0E,$09
	db $01,$03,$04

DATA_0583D1:
	db $04,$06,$02,$04,$02

DATA_0583D6:
	db $00,$05,$0C,$0F,$14

CODE_0583DB:
	INC.b !RAM_SMB1_Global_ScratchRAMEB
CODE_0583DD:
	LDA.b !RAM_SMB1_Global_ScratchRAMEB
	CLC
	ADC.w #$0010
	STA.b !RAM_SMB1_Global_ScratchRAMEB
	BRA.b CODE_0583E9

CODE_0583E7:
	INC.b !RAM_SMB1_Global_ScratchRAMEB
CODE_0583E9:
	LDX.b !RAM_SMB1_Global_ScratchRAMEB
	LDA.b !RAM_SMB1_Global_ScratchRAMF1
	TAY
	LDA.w DATA_0583D1,y
	AND.w #$00FF
	STA.b !RAM_SMB1_Global_ScratchRAMF1
	LDA.w DATA_0583D6,y
	AND.w #$00FF
	TAY
	SEP.b #$20
CODE_0583FF:
	LDA.w DATA_0583BA,y
	STA.l !RAM_SMB1_Global_Layer2BGData,x
	INX
	INY
	TXA
	AND.b #$0F
	BNE.b CODE_058417
	REP.b #$20
	TXA
	CLC
	ADC.w #$00F0
	TAX
	SEP.b #$20
CODE_058417:
	DEC.b !RAM_SMB1_Global_ScratchRAMF1
	BPL.b CODE_0583FF
	REP.b #$20
	JMP.w CODE_05805B

;--------------------------------------------------------------------

DATA_058420:
	db $05,$0A

DATA_058422:
	db $06,$0C

CODE_058424:
	INC.b !RAM_SMB1_Global_ScratchRAMEB
CODE_058426:
	LDA.b !RAM_SMB1_Global_ScratchRAMEB
	CLC
	ADC.w #$0010
	STA.b !RAM_SMB1_Global_ScratchRAMEB
	BRA.b CODE_058432

CODE_058430:
	INC.b !RAM_SMB1_Global_ScratchRAMEB
CODE_058432:
	LDY.w #$0001
	BRA.b CODE_058448

CODE_058437:
	INC.b !RAM_SMB1_Global_ScratchRAMEB
CODE_058439:
	LDA.b !RAM_SMB1_Global_ScratchRAMEB
	CLC
	ADC.w #$0010
	STA.b !RAM_SMB1_Global_ScratchRAMEB
	BRA.b CODE_058445

CODE_058443:
	INC.b !RAM_SMB1_Global_ScratchRAMEB
CODE_058445:
	LDY.w #$0000
CODE_058448:
	LDX.b !RAM_SMB1_Global_ScratchRAMEB
	SEP.b #$20
	LDA.w DATA_058420,y
	STA.l !RAM_SMB1_Global_Layer2BGData,x
	REP.b #$20
	TXA
	CLC
	ADC.w #$0010
	TAX
	SEP.b #$20
	DEC.b !RAM_SMB1_Global_ScratchRAMF1
CODE_05845F:
	LDA.l !RAM_SMB1_Global_Layer2BGData,x
	CMP.b #$0E
	BNE.b CODE_05846B
	LDA.b #$0D
	BRA.b CODE_058476

CODE_05846B:
	CMP.b #$02
	BNE.b CODE_058473
	LDA.b #$0B
	BRA.b CODE_058476

CODE_058473:
	LDA.w DATA_058422,y
CODE_058476:
	STA.l !RAM_SMB1_Global_Layer2BGData,x
	REP.b #$20
	TXA
	CLC
	ADC.w #$0010
	TAX
	SEP.b #$20
	DEC.b !RAM_SMB1_Global_ScratchRAMF1
	BPL.b CODE_05845F
	REP.b #$20
	JMP.w CODE_05805B

;--------------------------------------------------------------------

CODE_05848D:
	LDA.b !RAM_SMB1_Global_ScratchRAMEB
	CLC
	ADC.w #$0010
	TAX
	SEP.b #$20
	LDA.b #$4E
	STA.l !RAM_SMB1_Global_Layer2BGData+$30,x
	LDA.l !RAM_SMB1_Global_Layer2BGData,x
	BEQ.b CODE_0584A6
	LDA.b #$38
	BRA.b CODE_0584A8

CODE_0584A6:
	LDA.b #$34
CODE_0584A8:
	STA.l !RAM_SMB1_Global_Layer2BGData,x
	LDA.l !RAM_SMB1_Global_Layer2BGData+$10,x
	BEQ.b CODE_0584BA
	CMP.b #$12
	BEQ.b CODE_0584BA
	LDA.b #$44
	BRA.b CODE_0584BC

CODE_0584BA:
	LDA.b #$40
CODE_0584BC:
	STA.l !RAM_SMB1_Global_Layer2BGData+$10,x
	LDA.l !RAM_SMB1_Global_Layer2BGData+$20,x
	BEQ.b CODE_0584CE
	CMP.b #$12
	BEQ.b CODE_0584CE
	LDA.b #$4D
	BRA.b CODE_0584D0

CODE_0584CE:
	LDA.b #$4C
CODE_0584D0:
	STA.l !RAM_SMB1_Global_Layer2BGData+$20,x
	INX
	LDA.l !RAM_SMB1_Global_Layer2BGData,x
	BEQ.b CODE_0584F7
	CMP.b #$12
	BEQ.b CODE_0584F7
	CMP.b #$18
	BEQ.b CODE_0584F3
	CMP.b #$07
	BEQ.b CODE_0584F3
	CMP.b #$17
	BEQ.b CODE_0584EF
	LDA.b #$39
	BRA.b CODE_0584F9

CODE_0584EF:
	LDA.b #$3D
	BRA.b CODE_0584F9

CODE_0584F3:
	LDA.b #$36
	BRA.b CODE_0584F9

CODE_0584F7:
	LDA.b #$35
CODE_0584F9:
	STA.l !RAM_SMB1_Global_Layer2BGData,x
	LDA.b #$41
	STA.l !RAM_SMB1_Global_Layer2BGData+$10,x
	LDA.b #$48
	STA.l !RAM_SMB1_Global_Layer2BGData+$20,x
	LDA.b #$4E
	STA.l !RAM_SMB1_Global_Layer2BGData+$30,x
	INX
CODE_058510:
	DEC.b !RAM_SMB1_Global_ScratchRAMF1
	LDA.b !RAM_SMB1_Global_ScratchRAMF1
	BNE.b CODE_058519
	JMP.w CODE_058599

CODE_058519:
	LDA.l !RAM_SMB1_Global_Layer2BGData,x
	BNE.b CODE_058539
	LDA.b #$36
	STA.l !RAM_SMB1_Global_Layer2BGData,x
	LDA.b #$35
	STA.l !RAM_SMB1_Global_Layer2BGData+$01,x
	LDA.b #$42
	STA.l !RAM_SMB1_Global_Layer2BGData+$10,x
	LDA.b #$41
	STA.l !RAM_SMB1_Global_Layer2BGData+$11,x
	BRA.b CODE_05856F

CODE_058539:
	CMP.b #$18
	BEQ.b CODE_058557
	LDA.b #$3A
	STA.l !RAM_SMB1_Global_Layer2BGData,x
	LDA.b #$39
	STA.l !RAM_SMB1_Global_Layer2BGData+$01,x
	LDA.b #$42
	STA.l !RAM_SMB1_Global_Layer2BGData+$10,x
	LDA.b #$41
	STA.l !RAM_SMB1_Global_Layer2BGData+$11,x
	BRA.b CODE_05856F

CODE_058557:
	LDA.b #$36
	STA.l !RAM_SMB1_Global_Layer2BGData,x
	LDA.b #$35
	STA.l !RAM_SMB1_Global_Layer2BGData+$01,x
	LDA.b #$42
	STA.l !RAM_SMB1_Global_Layer2BGData+$10,x
	LDA.b #$41
	STA.l !RAM_SMB1_Global_Layer2BGData+$11,x
CODE_05856F:
	LDA.b #$47
	STA.l !RAM_SMB1_Global_Layer2BGData+$20,x
	LDA.b #$48
	STA.l !RAM_SMB1_Global_Layer2BGData+$21,x
	LDA.b #$4E
	STA.l !RAM_SMB1_Global_Layer2BGData+$30,x
	STA.l !RAM_SMB1_Global_Layer2BGData+$31,x
	INX
	INX
	TXA
	AND.b #$0F
	BNE.b CODE_058510
	REP.b #$20
	TXA
	CLC
	ADC.w #$00F0
	TAX
	SEP.b #$20
	JMP.w CODE_058510

CODE_058599:
	LDA.b #$42
	STA.l !RAM_SMB1_Global_Layer2BGData+$10,x
	LDA.b #$47
	STA.l !RAM_SMB1_Global_Layer2BGData+$20,x
	LDA.b #$4E
	STA.l !RAM_SMB1_Global_Layer2BGData+$30,x
	STA.l !RAM_SMB1_Global_Layer2BGData+$31,x
	LDA.l !RAM_SMB1_Global_Layer2BGData,x
	BNE.b CODE_0585CF
	LDA.b #$36
	STA.l !RAM_SMB1_Global_Layer2BGData,x
	LDA.b #$37
	STA.l !RAM_SMB1_Global_Layer2BGData+$01,x
	LDA.b #$43
	STA.l !RAM_SMB1_Global_Layer2BGData+$11,x
	LDA.b #$49
	STA.l !RAM_SMB1_Global_Layer2BGData+$21,x
	BRA.b CODE_0585E7

CODE_0585CF:
	LDA.b #$3A
	STA.l !RAM_SMB1_Global_Layer2BGData,x
	LDA.b #$3B
	STA.l !RAM_SMB1_Global_Layer2BGData+$01,x
	LDA.b #$45
	STA.l !RAM_SMB1_Global_Layer2BGData+$11,x
	LDA.b #$4A
	STA.l !RAM_SMB1_Global_Layer2BGData+$21,x
CODE_0585E7:
	REP.b #$20
	JMP.w CODE_05805B

;--------------------------------------------------------------------

CODE_0585EC:
	INC.b !RAM_SMB1_Global_ScratchRAMEB
CODE_0585EE:
	LDX.b !RAM_SMB1_Global_ScratchRAMEB
	STX.b !RAM_SMB1_Global_ScratchRAME2
	LDA.b !RAM_SMB1_Global_ScratchRAMEF
	ASL
	TAY
	LDA.w DATA_05878A,y
	TAY
	SEP.b #$20
CODE_0585FC:
	LDA.w DATA_05B323,y
	BEQ.b CODE_058610
	CMP.b #$FF
	BEQ.b CODE_058634
	CMP.b #$FE
	BEQ.b CODE_058624
	LDA.w DATA_05B323,y
	STA.l !RAM_SMB1_Global_Layer2BGData,x
CODE_058610:
	INY
	INX
	REP.b #$20
	TXA
	AND.w #$000F
	BNE.b CODE_058620
	TXA
	CLC
	ADC.w #$00F0
	TAX
CODE_058620:
	SEP.b #$20
	BRA.b CODE_0585FC

CODE_058624:
	REP.b #$20
	LDA.b !RAM_SMB1_Global_ScratchRAME2
	CLC
	ADC.w #$0010
	STA.b !RAM_SMB1_Global_ScratchRAME2
	TAX
	SEP.b #$20
	INY
	BRA.b CODE_0585FC

CODE_058634:
	REP.b #$20
	JMP.w CODE_05805B

;--------------------------------------------------------------------

CODE_058639:
	LDA.b !RAM_SMB1_Global_ScratchRAMEB
	CLC
	ADC.w #$0010
	TAX
	INX
	BRA.b CODE_058650

CODE_058643:
	LDA.b !RAM_SMB1_Global_ScratchRAMEB
	CLC
	ADC.w #$0010
	TAX
	BRA.b CODE_058650

CODE_05864C:
	INC.b !RAM_SMB1_Global_ScratchRAMEB
CODE_05864E:
	LDX.b !RAM_SMB1_Global_ScratchRAMEB
CODE_058650:
	STX.b !RAM_SMB1_Global_ScratchRAME2
	LDA.b !RAM_SMB1_Global_ScratchRAMEF
	ASL
	TAY
	LDA.w DATA_0587AA,y
	TAY
	SEP.b #$20
CODE_05865C:
	LDA.w DATA_05B3E2,y
	BEQ.b CODE_058670
	CMP.b #$FF
	BEQ.b CODE_058694
	CMP.b #$FE
	BEQ.b CODE_058684
	LDA.w DATA_05B3E2,y
	STA.l !RAM_SMB1_Global_Layer2BGData,x
CODE_058670:
	INY
	INX
	REP.b #$20
	TXA
	AND.w #$000F
	BNE.b CODE_058680
	TXA
	CLC
	ADC.w #$00F0
	TAX
CODE_058680:
	SEP.b #$20
	BRA.b CODE_05865C

CODE_058684:
	REP.b #$20
	LDA.b !RAM_SMB1_Global_ScratchRAME2
	CLC
	ADC.w #$0010
	STA.b !RAM_SMB1_Global_ScratchRAME2
	TAX
	SEP.b #$20
	INY
	BRA.b CODE_05865C

CODE_058694:
	REP.b #$20
	JMP.w CODE_05805B

;--------------------------------------------------------------------

CODE_058699:
	LDX.b !RAM_SMB1_Global_ScratchRAMEB
	STX.b !RAM_SMB1_Global_ScratchRAME2
	LDA.b !RAM_SMB1_Global_ScratchRAMEF
	ASL
	TAY
	LDA.w DATA_0587BE,y
	TAY
	SEP.b #$20
CODE_0586A7:
	LDA.w DATA_05AD48,y
	BEQ.b CODE_0586B8
	CMP.b #$FF
	BEQ.b CODE_0586E4
	CMP.b #$FE
	BEQ.b CODE_0586CC
	STA.l !RAM_SMB1_Global_Layer2BGData,x
CODE_0586B8:
	INY
	INX
	REP.b #$20
	TXA
	AND.w #$000F
	BNE.b CODE_0586C8
	TXA
	CLC
	ADC.w #$00F0
	TAX
CODE_0586C8:
	SEP.b #$20
	BRA.b CODE_0586A7

CODE_0586CC:
	REP.b #$20
	LDA.b !RAM_SMB1_Global_ScratchRAME2
	CLC
	ADC.w #$0010
	STA.b !RAM_SMB1_Global_ScratchRAME2
	TAX
	AND.w #$00F0
	CMP.w #$00F0
	BEQ.b CODE_0586E4
	SEP.b #$20
	INY
	BRA.b CODE_0586A7

CODE_0586E4:
	REP.b #$20
	JMP.w CODE_05805B

;--------------------------------------------------------------------

CODE_0586E9:
	DEC.b !RAM_SMB1_Global_ScratchRAMEF
	LDA.b !RAM_SMB1_Global_ScratchRAMEF
	AND.w #$0003
	ASL
	ASL
	ASL
	ASL
	ORA.b !RAM_SMB1_Global_ScratchRAMF1
	ASL
	ASL
	TAY
	LDX.b !RAM_SMB1_Global_ScratchRAMEB
	SEP.b #$20
	LDA.w DATA_0591E4,y
	STA.l !RAM_SMB1_Global_Layer2BGData,x
	LDA.w DATA_0591E4+$01,y
	STA.l !RAM_SMB1_Global_Layer2BGData+$01,x
	LDA.w DATA_0591E4+$02,y
	STA.l !RAM_SMB1_Global_Layer2BGData+$10,x
	LDA.w DATA_0591E4+$03,y
	STA.l !RAM_SMB1_Global_Layer2BGData+$11,x
	REP.b #$20
	JMP.w CODE_05805B

;--------------------------------------------------------------------

DATA_05871E:
	db $04,$05,$0B,$0C,$0B,$0C

CODE_058724:
	INC.b !RAM_SMB1_Global_ScratchRAMEB
CODE_058726:
	LDA.b !RAM_SMB1_Global_ScratchRAMEB
	CLC
	ADC.w #$0020
	TAX
	SEP.b #$20
	LDA.w DATA_05871E
	STA.l !RAM_SMB1_Global_Layer2BGData,x
	LDA.w DATA_05871E+$01
	STA.l !RAM_SMB1_Global_Layer2BGData+$01,x
	LDA.w DATA_05871E+$02
	STA.l !RAM_SMB1_Global_Layer2BGData+$10,x
	LDA.w DATA_05871E+$03
	STA.l !RAM_SMB1_Global_Layer2BGData+$11,x
	LDA.w DATA_05871E+$04
	STA.l !RAM_SMB1_Global_Layer2BGData+$20,x
	LDA.w DATA_05871E+$05
	STA.l !RAM_SMB1_Global_Layer2BGData+$21,x
	REP.b #$20
	JMP.w CODE_05805B

;--------------------------------------------------------------------

CODE_05875E:
	INC.b !RAM_SMB1_Global_ScratchRAMEB
CODE_058760:
	LDA.b !RAM_SMB1_Global_ScratchRAMEB
	CLC
	ADC.w #$0020
	TAX
	SEP.b #$20
	LDA.w DATA_05871E
	STA.l !RAM_SMB1_Global_Layer2BGData+$10,x
	LDA.w DATA_05871E+$01
	STA.l !RAM_SMB1_Global_Layer2BGData+$11,x
	LDA.w DATA_05871E+$02
	STA.l !RAM_SMB1_Global_Layer2BGData+$20,x
	LDA.w DATA_05871E+$03
	STA.l !RAM_SMB1_Global_Layer2BGData+$21,x
	REP.b #$20
	JMP.w CODE_05805B

;--------------------------------------------------------------------

DATA_05878A:
	dw DATA_05B323-DATA_05B323
	dw DATA_05B323-DATA_05B323
	dw DATA_05B342-DATA_05B323
	dw DATA_05B342-DATA_05B323
	dw DATA_05B360-DATA_05B323
	dw DATA_05B360-DATA_05B323
	dw DATA_05B367-DATA_05B323
	dw DATA_05B367-DATA_05B323
	dw DATA_05B377-DATA_05B323
	dw DATA_05B377-DATA_05B323
	dw DATA_05B391-DATA_05B323
	dw DATA_05B323-DATA_05B323
	dw DATA_05B3D6-DATA_05B323
	dw DATA_05B3D6-DATA_05B323
	dw DATA_05B323-DATA_05B323
	dw DATA_05B323-DATA_05B323

;--------------------------------------------------------------------

DATA_0587AA:
	dw DATA_05B3E2-DATA_05B3E2
	dw DATA_05B3E2-DATA_05B3E2
	dw DATA_05B3E2-DATA_05B3E2
	dw DATA_05B3E2-DATA_05B3E2
	dw DATA_05B3E2-DATA_05B3E2
	dw DATA_05B3E6-DATA_05B3E2
	dw DATA_05B3FA-DATA_05B3E2
	dw DATA_05B40E-DATA_05B3E2
	dw DATA_05B434-DATA_05B3E2
	dw DATA_05B472-DATA_05B3E2

;--------------------------------------------------------------------

DATA_0587BE:
	dw DATA_05AD48-DATA_05AD48
	dw DATA_05AD79-DATA_05AD48
	dw DATA_05AD83-DATA_05AD48
	dw DATA_05ADCB-DATA_05AD48
	dw DATA_05AE3D-DATA_05AD48
	dw DATA_05AE93-DATA_05AD48
	dw DATA_05AE9A-DATA_05AD48
	dw DATA_05AEAA-DATA_05AD48
	dw DATA_05AEF4-DATA_05AD48
	dw DATA_05AF4E-DATA_05AD48
	dw DATA_05AFD5-DATA_05AD48
	dw DATA_05B01D-DATA_05AD48
	dw DATA_05B03A-DATA_05AD48
	dw DATA_05B0C1-DATA_05AD48
	dw DATA_05B0E8-DATA_05AD48

;--------------------------------------------------------------------

; Note: Something related to the hills BG

DATA_0587DC:
	dw DATA_05B23F-DATA_05B1A5
	dw DATA_05B24C-DATA_05B1A5
	dw DATA_05B26E-DATA_05B1A5
	dw DATA_05B275-DATA_05B1A5
	dw DATA_05B281-DATA_05B1A5
	dw DATA_05B2AB-DATA_05B1A5
	dw DATA_05B2CB-DATA_05B1A5

CODE_0587EA:
	LDY.w DATA_0587DC
	LDA.b !RAM_SMB1_Global_ScratchRAMEB
	TAX
	INX
	INX
	BRA.b CODE_05884A

CODE_0587F4:
	LDY.w DATA_0587DC+$02
	LDA.b !RAM_SMB1_Global_ScratchRAMEB
	CLC
	ADC.w #$0012
	TAX
	BRA.b CODE_05884A

CODE_058800:
	LDY.w DATA_0587DC+$04
	LDA.b !RAM_SMB1_Global_ScratchRAMEB
	CLC
	ADC.w #$0001
	TAX
	BRA.b CODE_05884A

CODE_05880C:
	LDY.w DATA_0587DC+$06
	LDA.b !RAM_SMB1_Global_ScratchRAMEB
	CLC
	ADC.w #$0011
	TAX
	BRA.b CODE_05884A

CODE_058818:
	LDY.w DATA_0587DC+$08
	LDA.b !RAM_SMB1_Global_ScratchRAMEB
	CLC
	ADC.w #$0020
	TAX
	BRA.b CODE_05884A

CODE_058824:
	LDY.w DATA_0587DC+$0A
	LDX.b !RAM_SMB1_Global_ScratchRAMEB
	INX
	BRA.b CODE_05884A

CODE_05882C:
	LDY.w DATA_0587DC+$0C
	LDA.b !RAM_SMB1_Global_ScratchRAMEB
	CLC
	ADC.w #$0012
	TAX
	BRA.b CODE_05884A

CODE_058838:
	INC.b !RAM_SMB1_Global_ScratchRAMEB
CODE_05883A:
	LDA.b !RAM_SMB1_Global_ScratchRAMEB
	CLC
	ADC.w #$0010
	TAX
	BRA.b CODE_058847

CODE_058843:
	INC.b !RAM_SMB1_Global_ScratchRAMEB
CODE_058845:
	LDX.b !RAM_SMB1_Global_ScratchRAMEB
CODE_058847:
	LDY.w #$0000
CODE_05884A:
	STX.b !RAM_SMB1_Global_ScratchRAME2
	SEP.b #$20
CODE_05884E:
	LDA.w DATA_05B1A5,y
	CMP.b #$FF
	BEQ.b CODE_0588C6
	CMP.b #$FE
	BEQ.b CODE_0588A1
	JSR.w CODE_058874
	STA.l !RAM_SMB1_Global_Layer2BGData,x
	INY
	INX
	REP.b #$20
	TXA
	AND.w #$000F
	BNE.b CODE_058870
	TXA
	CLC
	ADC.w #$00F0
	TAX
CODE_058870:
	SEP.b #$20
	BRA.b CODE_05884E

CODE_058874:
	STA.b !RAM_SMB1_Global_ScratchRAME4
	CMP.b #$12
	BNE.b CODE_05887D
	JMP.w CODE_0588CB

CODE_05887D:
	CMP.b #$03
	BNE.b CODE_058884
	JMP.w CODE_0588F8

CODE_058884:
	CMP.b #$04
	BNE.b CODE_05888B
	JMP.w CODE_058905

CODE_05888B:
	CMP.b #$05
	BNE.b CODE_058892
	JMP.w CODE_05891A

CODE_058892:
	CMP.b #$18
	BNE.b CODE_058899
	JMP.w CODE_05892F

CODE_058899:
	CMP.b #$07
	BNE.b CODE_0588A0
	JMP.w CODE_05894C

CODE_0588A0:
	RTS

CODE_0588A1:
	INY
	REP.b #$20
	LDA.b !RAM_SMB1_Global_ScratchRAME2
	CLC
	ADC.w #$0010
	TAX
	AND.w #$00F0
	BEQ.b CODE_0588C6
	DEX
	TXA
	AND.w #$000F
	CMP.w #$000F
	BNE.b CODE_0588C0
	TXA
	SEC
	SBC.w #$00F0
	TAX
CODE_0588C0:
	STX.b !RAM_SMB1_Global_ScratchRAME2
	SEP.b #$20
	BRA.b CODE_05884E

CODE_0588C6:
	REP.b #$20
	JMP.w CODE_05805B

CODE_0588CB:
	LDA.l !RAM_SMB1_Global_Layer2BGData,x
	BEQ.b CODE_0588F5
	CMP.b #$18
	BNE.b CODE_0588D9
	LDA.b #$02
	BRA.b CODE_0588F7

CODE_0588D9:
	CMP.b #$06
	BNE.b CODE_0588E1
	LDA.b #$11
	BRA.b CODE_0588F7

CODE_0588E1:
	CMP.b #$16
	BNE.b CODE_0588E9
	LDA.b #$01
	BRA.b CODE_0588F7

CODE_0588E9:
	CMP.b #$05
	BNE.b CODE_0588F1
	LDA.b #$62
	BRA.b CODE_0588F7

CODE_0588F1:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	CMP.b #$1A
	BNE.b +
	LDA.b #$11
	BRA.b CODE_0588F7

+:
endif
	LDA.b #$10
	BRA.b CODE_0588F7

CODE_0588F5:
	LDA.b !RAM_SMB1_Global_ScratchRAME4
CODE_0588F7:
	RTS

CODE_0588F8:
	LDA.l !RAM_SMB1_Global_Layer2BGData,x
	BEQ.b CODE_058902
	LDA.b #$36
	BRA.b CODE_058904

CODE_058902:
	LDA.b !RAM_SMB1_Global_ScratchRAME4
CODE_058904:
	RTS

CODE_058905:
	LDA.l !RAM_SMB1_Global_Layer2BGData,x					; Todo: X can be negative here, writing to addresses in bank 7F. Is this a bug?
	BEQ.b CODE_058917
	CMP.b #$12
	BNE.b CODE_058913
	LDA.b #$14
	BRA.b CODE_058919

CODE_058913:
	LDA.b #$37
	BRA.b CODE_058919

CODE_058917:
	LDA.b !RAM_SMB1_Global_ScratchRAME4
CODE_058919:
	RTS

CODE_05891A:
	LDA.l !RAM_SMB1_Global_Layer2BGData,x
	BEQ.b CODE_05892C
	CMP.b #$13
	BNE.b CODE_058928
	LDA.b #$15
	BRA.b CODE_05892E

CODE_058928:
	LDA.b #$38
	BRA.b CODE_05892E

CODE_05892C:
	LDA.b !RAM_SMB1_Global_ScratchRAME4
CODE_05892E:
	RTS

CODE_05892F:
	LDA.l !RAM_SMB1_Global_Layer2BGData,x
	BEQ.b CODE_058949
	CMP.b #$16
	BNE.b CODE_05893D
	LDA.b #$1E
	BRA.b CODE_05894B

CODE_05893D:
	CMP.b #$13
	BNE.b CODE_058945
	LDA.b #$1E
	BRA.b CODE_05894B

CODE_058945:
	LDA.b #$1D
	BRA.b CODE_05894B

CODE_058949:
	LDA.b !RAM_SMB1_Global_ScratchRAME4
CODE_05894B:
	RTS

CODE_05894C:
	LDA.l !RAM_SMB1_Global_Layer2BGData,x
	BEQ.b CODE_05896E
	CMP.b #$16
	BNE.b CODE_05895A
	LDA.b #$0E
	BRA.b CODE_058970

CODE_05895A:
	CMP.b #$04
	BNE.b CODE_058962
	LDA.b #$70
	BRA.b CODE_058970

CODE_058962:
	CMP.b #$0B
	BNE.b CODE_05896A
	LDA.b #$90
	BRA.b CODE_058970

CODE_05896A:
	LDA.b #$49
	BRA.b CODE_058970

CODE_05896E:
	LDA.b !RAM_SMB1_Global_ScratchRAME4
CODE_058970:
	RTS

;--------------------------------------------------------------------

DATA_058971:
	db $00,$00,$90,$91,$92,$93
	db $00,$00,$94,$95,$96,$97
	db $00,$00,$98,$99,$9A,$9B
	db $00,$9C,$9D,$9E,$9F,$A0
	db $00,$A1,$A2,$A3,$A4,$A5
	db $00,$A6,$A7,$A8,$A9,$AA

CODE_058995:
	SEP.b #$20
	LDX.b !RAM_SMB1_Global_ScratchRAMEB
	LDY.w #$0000
CODE_05899C:
	LDA.w DATA_058971,y
	STA.l !RAM_SMB1_Global_Layer2BGData+$20,x
	LDA.w DATA_058971+$01,y
	STA.l !RAM_SMB1_Global_Layer2BGData+$21,x
	LDA.w DATA_058971+$02,y
	STA.l !RAM_SMB1_Global_Layer2BGData+$22,x
	LDA.w DATA_058971+$03,y
	STA.l !RAM_SMB1_Global_Layer2BGData+$23,x
	LDA.w DATA_058971+$04,y
	STA.l !RAM_SMB1_Global_Layer2BGData+$24,x
	LDA.w DATA_058971+$05,y
	STA.l !RAM_SMB1_Global_Layer2BGData+$25,x
	REP.b #$20
	TXA
	CLC
	ADC.w #$0010
	TAX
	SEP.b #$20
	INY
	INY
	INY
	INY
	INY
	INY
	CPY.w #$0024
	BNE.b CODE_05899C
	REP.b #$20
	JMP.w CODE_05805B

;--------------------------------------------------------------------

CODE_0589E0:
	LDX.b !RAM_SMB1_Global_ScratchRAMEB
	SEP.b #$20
CODE_0589E4:
	LDA.b #$09
	STA.l !RAM_SMB1_Global_Layer2BGData+$20,x
	LDA.b #$0B
	STA.l !RAM_SMB1_Global_Layer2BGData+$21,x
	INX
	INX
	DEC.b !RAM_SMB1_Global_ScratchRAMF1
	LDA.b !RAM_SMB1_Global_ScratchRAMF1
	BPL.b CODE_0589E4
	REP.b #$20
	JMP.w CODE_05805B

;--------------------------------------------------------------------

CODE_0589FD:
	LDX.b !RAM_SMB1_Global_ScratchRAMEB
	SEP.b #$20
CODE_058A01:
	LDA.l !RAM_SMB1_Global_Layer2BGData+$20,x
	CMP.b #$09
	BNE.b CODE_058A0D
	LDA.b #$0A
	BRA.b CODE_058A0F

CODE_058A0D:
	LDA.b #$04
CODE_058A0F:
	STA.l !RAM_SMB1_Global_Layer2BGData+$20,x
	LDA.b #$01
	STA.l !RAM_SMB1_Global_Layer2BGData+$30,x
	REP.b #$20
	TXA
	CLC
	ADC.w #$0020
	TAX
	SEP.b #$20
	DEC.b !RAM_SMB1_Global_ScratchRAMF1
	LDA.b !RAM_SMB1_Global_ScratchRAMF1
	BPL.b CODE_058A01
	REP.b #$20
	JMP.w CODE_05805B

;--------------------------------------------------------------------

CODE_058A2E:
	LDX.b !RAM_SMB1_Global_ScratchRAMEB
	SEP.b #$20
CODE_058A32:
	LDA.l !RAM_SMB1_Global_Layer2BGData+$21,x
	CMP.b #$0B
	BNE.b CODE_058A3E
	LDA.b #$0A
	BRA.b CODE_058A40

CODE_058A3E:
	LDA.b #$04
CODE_058A40:
	STA.l !RAM_SMB1_Global_Layer2BGData+$21,x
	LDA.b #$01
	STA.l !RAM_SMB1_Global_Layer2BGData+$31,x
	REP.b #$20
	TXA
	CLC
	ADC.w #$0020
	TAX
	SEP.b #$20
	DEC.b !RAM_SMB1_Global_ScratchRAMF1
	LDA.b !RAM_SMB1_Global_ScratchRAMF1
	BPL.b CODE_058A32
	REP.b #$20
	JMP.w CODE_05805B

;--------------------------------------------------------------------

DATA_058A5F:
	db $7A,$7B,$61,$62,$8C,$8D,$90,$91
	db $92

CODE_058A68:
	LDX.b !RAM_SMB1_Global_ScratchRAMEB
	LDA.w #$0006
	STA.b !RAM_SMB1_Global_ScratchRAMF1
	SEP.b #$20
	LDA.w DATA_058A5F
	STA.l !RAM_SMB1_Global_Layer2BGData+$20,x
	LDA.w DATA_058A5F+$01
	STA.l !RAM_SMB1_Global_Layer2BGData+$21,x
CODE_058A7F:
	LDA.w DATA_058A5F+$02
	STA.l !RAM_SMB1_Global_Layer2BGData+$30,x
	LDA.w DATA_058A5F+$03
	STA.l !RAM_SMB1_Global_Layer2BGData+$31,x
	REP.b #$20
	TXA
	CLC
	ADC.w #$0010
	TAX
	SEP.b #$20
	DEC.b !RAM_SMB1_Global_ScratchRAMF1
	LDA.b !RAM_SMB1_Global_ScratchRAMF1
	BNE.b CODE_058A7F
	LDA.w DATA_058A5F+$04
	STA.l !RAM_SMB1_Global_Layer2BGData+$30,x
	LDA.w DATA_058A5F+$05
	STA.l !RAM_SMB1_Global_Layer2BGData+$31,x
	LDA.w DATA_058A5F+$06
	STA.l !RAM_SMB1_Global_Layer2BGData+$40,x
	LDA.w DATA_058A5F+$07
	STA.l !RAM_SMB1_Global_Layer2BGData+$41,x
	LDA.w DATA_058A5F+$08
	STA.l !RAM_SMB1_Global_Layer2BGData+$42,x
	REP.b #$20
	JMP.w CODE_05805B

;--------------------------------------------------------------------

CODE_058AC5:
	db $70,$71,$72,$73
	db $74,$75,$76,$77
	db $78,$79,$7A,$7B
	db $00,$7C,$7D,$00

CODE_058AD5:
	LDX.b !RAM_SMB1_Global_ScratchRAMEB
	INX
	SEP.b #$20
	STZ.b !RAM_SMB1_Global_ScratchRAME5
	LDY.w #$0000
CODE_058ADF:
	LDA.w CODE_058AC5,y
	STA.l !RAM_SMB1_Global_Layer2BGData,x
	LDA.w CODE_058AC5+$01,y
	STA.l !RAM_SMB1_Global_Layer2BGData+$01,x
	LDA.w CODE_058AC5+$02,y
	STA.l !RAM_SMB1_Global_Layer2BGData+$02,x
	LDA.w CODE_058AC5+$03,y
	STA.l !RAM_SMB1_Global_Layer2BGData+$03,x
	INY
	INY
	INY
	INY
	INX
	INX
	INX
	INX
	REP.b #$20
	TXA
	CLC
	ADC.w #$000C
	TAX
	SEP.b #$20
	INC.b !RAM_SMB1_Global_ScratchRAME5
	LDA.b !RAM_SMB1_Global_ScratchRAME5
	CMP.b #$04
	BNE.b CODE_058ADF
	REP.b #$20
	JMP.w CODE_05805B

;--------------------------------------------------------------------

DATA_058B1A:
	db $2F,$30
	db $31,$32
	db $35,$36
	db $3A,$3B

CODE_058B22:
	SEP.b #$20
	LDY.w #$0000
	LDX.b !RAM_SMB1_Global_ScratchRAMEB
CODE_058B29:
	LDA.w DATA_058B1A,y
	STA.l !RAM_SMB1_Global_Layer2BGData+$20,x
	LDA.w DATA_058B1A+$01,y
	STA.l !RAM_SMB1_Global_Layer2BGData+$21,x
	REP.b #$20
	TXA
	CLC
	ADC.w #$0010
	TAX
	SEP.b #$20
	INY
	INY
	CPY.w #$0008
	BNE.b CODE_058B29
	REP.b #$20
	JMP.w CODE_05805B

;--------------------------------------------------------------------

DATA_058B4D:
	db $01,$1F

DATA_058B4F:
	db $02,$20

CODE_058B51:
	SEP.b #$20
	LDX.b !RAM_SMB1_Global_ScratchRAMEB
	LDY.b !RAM_SMB1_Global_ScratchRAMEF
CODE_058B57:
	LDA.w DATA_058B4D,y
	STA.l !RAM_SMB1_Global_Layer2BGData+$20,x
	LDA.w DATA_058B4F,y
	STA.l !RAM_SMB1_Global_Layer2BGData+$21,x
	REP.b #$20
	TXA
	CLC
	ADC.w #$0010
	TAX
	SEP.b #$20
	DEC.b !RAM_SMB1_Global_ScratchRAMF1
	LDA.b !RAM_SMB1_Global_ScratchRAMF1
	BPL.b CODE_058B57
	REP.b #$20
	JMP.w CODE_05805B

;--------------------------------------------------------------------

DATA_058B7A:
	db $08,$09,$05,$06,$07,$05,$03,$04
	db $05,$0F,$10,$11,$16,$17,$12,$1D
	db $09,$1E,$06,$07,$05

CODE_058B8F:
	SEP.b #$20
	LDX.b !RAM_SMB1_Global_ScratchRAMEB
CODE_058B93:
	TXA
	AND.b #$F0
	BEQ.b CODE_058BB7
	LDA.l !RAM_SMB1_Global_Layer2BGData+$20,x
	CMP.b #$0C
	BEQ.b CODE_058BE3
	LDA.w DATA_058B7A
	STA.l !RAM_SMB1_Global_Layer2BGData+$20,x
	LDA.w DATA_058B7A+$01
	STA.l !RAM_SMB1_Global_Layer2BGData+$21,x
	LDA.w DATA_058B7A+$02
	STA.l !RAM_SMB1_Global_Layer2BGData+$22,x
	BRA.b CODE_058BCC

CODE_058BB7:
	LDA.w DATA_058B7A+$06
	STA.l !RAM_SMB1_Global_Layer2BGData+$20,x
	LDA.w DATA_058B7A+$07
	STA.l !RAM_SMB1_Global_Layer2BGData+$21,x
	LDA.w DATA_058B7A+$08
	STA.l !RAM_SMB1_Global_Layer2BGData+$22,x
CODE_058BCC:
	LDA.w DATA_058B7A+$03
	STA.l !RAM_SMB1_Global_Layer2BGData+$30,x
	LDA.w DATA_058B7A+$04
	STA.l !RAM_SMB1_Global_Layer2BGData+$31,x
	LDA.w DATA_058B7A+$05
	STA.l !RAM_SMB1_Global_Layer2BGData+$32,x
	BRA.b CODE_058C43

CODE_058BE3:
	LDA.w DATA_058B7A+$09
	STA.l !RAM_SMB1_Global_Layer2BGData+$20,x
	LDA.w DATA_058B7A+$0A
	STA.l !RAM_SMB1_Global_Layer2BGData+$21,x
	LDA.w DATA_058B7A+$0B
	STA.l !RAM_SMB1_Global_Layer2BGData+$22,x
	LDA.w DATA_058B7A+$0C
	STA.l !RAM_SMB1_Global_Layer2BGData+$30,x
	LDA.w DATA_058B7A+$0D
	STA.l !RAM_SMB1_Global_Layer2BGData+$31,x
	LDA.w DATA_058B7A+$0E
	STA.l !RAM_SMB1_Global_Layer2BGData+$32,x
	LDA.w DATA_058B7A+$0F
	STA.l !RAM_SMB1_Global_Layer2BGData+$40,x
	LDA.w DATA_058B7A+$10
	STA.l !RAM_SMB1_Global_Layer2BGData+$41,x
	LDA.w DATA_058B7A+$11
	STA.l !RAM_SMB1_Global_Layer2BGData+$42,x
	LDA.w DATA_058B7A+$12
	STA.l !RAM_SMB1_Global_Layer2BGData+$50,x
	LDA.w DATA_058B7A+$13
	STA.l !RAM_SMB1_Global_Layer2BGData+$51,x
	LDA.w DATA_058B7A+$14
	STA.l !RAM_SMB1_Global_Layer2BGData+$52,x
	REP.b #$20
	TXA
	CLC
	ADC.w #$0020
	TAX
	SEP.b #$20
	DEC.b !RAM_SMB1_Global_ScratchRAMF1
CODE_058C43:
	REP.b #$20
	TXA
	CLC
	ADC.w #$0020
	TAX
	SEP.b #$20
	DEC.b !RAM_SMB1_Global_ScratchRAMF1
	LDA.b !RAM_SMB1_Global_ScratchRAMF1
	BMI.b CODE_058C56
	JMP.w CODE_058B93

CODE_058C56:
	REP.b #$20
	JMP.w CODE_05805B

;--------------------------------------------------------------------

DATA_058C5B:
	db $0C,$18,$19,$0A,$0B,$0D,$0E,$13
	db $14,$1A,$1B

CODE_058C66:
	SEP.b #$20
	LDX.b !RAM_SMB1_Global_ScratchRAMEB
CODE_058C6A:
	LDA.l !RAM_SMB1_Global_Layer2BGData+$20,x
	CMP.b #$1F
	BNE.b CODE_058CAF
	LDA.w DATA_058C5B+$03
	STA.l !RAM_SMB1_Global_Layer2BGData+$10,x
	LDA.w DATA_058C5B+$04
	STA.l !RAM_SMB1_Global_Layer2BGData+$11,x
	LDA.w DATA_058C5B+$05
	STA.l !RAM_SMB1_Global_Layer2BGData+$20,x
	LDA.w DATA_058C5B+$06
	STA.l !RAM_SMB1_Global_Layer2BGData+$21,x
	LDA.w DATA_058C5B+$07
	STA.l !RAM_SMB1_Global_Layer2BGData+$30,x
	LDA.w DATA_058C5B+$08
	STA.l !RAM_SMB1_Global_Layer2BGData+$31,x
	LDA.w DATA_058C5B+$09
	STA.l !RAM_SMB1_Global_Layer2BGData+$40,x
	LDA.w DATA_058C5B+$0A
	STA.l !RAM_SMB1_Global_Layer2BGData+$41,x
	INX
	DEC.b !RAM_SMB1_Global_ScratchRAMF1
	BRA.b CODE_058CC4

CODE_058CAF:
	LDA.w DATA_058C5B
	STA.l !RAM_SMB1_Global_Layer2BGData+$20,x
	LDA.w DATA_058C5B+$01
	STA.l !RAM_SMB1_Global_Layer2BGData+$30,x
	LDA.w DATA_058C5B+$02
	STA.l !RAM_SMB1_Global_Layer2BGData+$40,x
CODE_058CC4:
	INX
	DEC.b !RAM_SMB1_Global_ScratchRAMF1
	LDA.b !RAM_SMB1_Global_ScratchRAMF1
	BPL.b CODE_058C6A
	REP.b #$20
	JMP.w CODE_05805B

;--------------------------------------------------------------------

DATA_058CD0:
	db $33,$34,$0D,$37,$13,$3C,$1A,$1B
	db $33,$34,$38,$39,$3D,$3E,$40,$1B

CODE_058CE0:
	LDX.b !RAM_SMB1_Global_ScratchRAMEB
	SEP.b #$20
	LDA.l !RAM_SMB1_Global_Layer2BGData+$20,x
	CMP.b #$0C
	BEQ.b CODE_058D26
	LDA.w DATA_058CD0+$08
	STA.l !RAM_SMB1_Global_Layer2BGData+$10,x
	LDA.w DATA_058CD0+$09
	STA.l !RAM_SMB1_Global_Layer2BGData+$11,x
	LDA.w DATA_058CD0+$0A
	STA.l !RAM_SMB1_Global_Layer2BGData+$20,x
	LDA.w DATA_058CD0+$0B
	STA.l !RAM_SMB1_Global_Layer2BGData+$21,x
	LDA.w DATA_058CD0+$0C
	STA.l !RAM_SMB1_Global_Layer2BGData+$30,x
	LDA.w DATA_058CD0+$0D
	STA.l !RAM_SMB1_Global_Layer2BGData+$31,x
	LDA.w DATA_058CD0+$0E
	STA.l !RAM_SMB1_Global_Layer2BGData+$40,x
	LDA.w DATA_058CD0+$0F
	STA.l !RAM_SMB1_Global_Layer2BGData+$41,x
	BRA.b CODE_058D5E

CODE_058D26:
	LDA.w DATA_058CD0
	STA.l !RAM_SMB1_Global_Layer2BGData+$10,x
	LDA.w DATA_058CD0+$01
	STA.l !RAM_SMB1_Global_Layer2BGData+$11,x
	LDA.w DATA_058CD0+$02
	STA.l !RAM_SMB1_Global_Layer2BGData+$20,x
	LDA.w DATA_058CD0+$03
	STA.l !RAM_SMB1_Global_Layer2BGData+$21,x
	LDA.w DATA_058CD0+$04
	STA.l !RAM_SMB1_Global_Layer2BGData+$30,x
	LDA.w DATA_058CD0+$05
	STA.l !RAM_SMB1_Global_Layer2BGData+$31,x
	LDA.w DATA_058CD0+$06
	STA.l !RAM_SMB1_Global_Layer2BGData+$40,x
	LDA.w DATA_058CD0+$07
	STA.l !RAM_SMB1_Global_Layer2BGData+$41,x
CODE_058D5E:
	REP.b #$20
	DEC.b !RAM_SMB1_Global_ScratchRAMF1
	DEC.b !RAM_SMB1_Global_ScratchRAMF1
	DEC.b !RAM_SMB1_Global_ScratchRAMF1
	LDA.b !RAM_SMB1_Global_ScratchRAMEB
	CLC
	ADC.w #$0030
	STA.b !RAM_SMB1_Global_ScratchRAMEB
	LDA.w #$0001
	STA.b !RAM_SMB1_Global_ScratchRAMEF
	JMP.w CODE_058B51

;--------------------------------------------------------------------

DATA_058D76:
	db $41,$42,$43,$44
	db $45,$46,$47,$48
	db $49,$4A,$4B,$4C
	db $4D,$4E,$4F,$50
	db $51,$52,$53,$54

CODE_058D8A:
	SEP.b #$20
	LDX.b !RAM_SMB1_Global_ScratchRAMEB
	LDY.w #$0000
CODE_058D91:
	LDA.w DATA_058D76,y
	STA.l !RAM_SMB1_Global_Layer2BGData+$20,x
	LDA.w DATA_058D76+$01,y
	STA.l !RAM_SMB1_Global_Layer2BGData+$21,x
	LDA.w DATA_058D76+$02,y
	STA.l !RAM_SMB1_Global_Layer2BGData+$22,x
	LDA.w DATA_058D76+$03,y
	STA.l !RAM_SMB1_Global_Layer2BGData+$23,x
	REP.b #$20
	TXA
	CLC
	ADC.w #$0010
	TAX
	SEP.b #$20
	INY
	INY
	INY
	INY
	CPY.w #$0014
	BNE.b CODE_058D91
	REP.b #$20
	JMP.w CODE_05805B

;--------------------------------------------------------------------

CODE_058DC5:
	LDX.b !RAM_SMB1_Global_ScratchRAMEB
	LDA.w #$1B1A
	STA.l !RAM_SMB1_Global_Layer2BGData,x
	JMP.w CODE_05805B

;--------------------------------------------------------------------

CODE_058DD1:
	INC.b !RAM_SMB1_Global_ScratchRAMEB
CODE_058DD3:
	LDA.b !RAM_SMB1_Global_ScratchRAMEB
	CLC
	ADC.w #$0010
	TAX
	SEP.b #$20
	LDA.b #$67
	STA.l !RAM_SMB1_Global_Layer2BGData,x
	LDA.b #$69
	STA.l !RAM_SMB1_Global_Layer2BGData+$01,x
	LDA.b #$68
	STA.l !RAM_SMB1_Global_Layer2BGData+$10,x
	LDA.b #$6A
	STA.l !RAM_SMB1_Global_Layer2BGData+$11,x
	REP.b #$20
	JMP.w CODE_05805B

;--------------------------------------------------------------------

; Note: Some routine that modifies the layer 2 cave BG

DATA_058DF9:
	dw DATA_058E01
	dw DATA_058E49
	dw DATA_058E55
	dw DATA_058E85

DATA_058E01:
	db $08,$09,$0D,$0E,$08,$23,$0D,$25,$24,$23,$26,$25,$24,$09,$26,$0E
	db $00,$08,$00,$0D,$23,$24,$25,$26,$0F,$10,$32,$33,$11,$12,$32,$33
	db $13,$00,$3C,$3B,$30,$31,$32,$33,$30,$10,$32,$33,$00,$36,$38,$37
	db $0F,$31,$32,$33,$35,$10,$39,$33,$0F,$10,$32,$33,$35,$12,$32,$33
	db $23,$24,$25,$26,$11,$12,$32,$33

DATA_058E49:
	db $21,$22,$25,$26,$23,$24,$27,$28,$00,$00,$26,$00

DATA_058E55:
	db $06,$05,$07,$02,$0E,$05,$11,$12,$0E,$05,$07,$08,$06,$05,$07,$08
	db $03,$05,$0C,$0D,$0F,$10,$1D,$02,$03,$05,$1D,$15,$03,$18,$1B,$1B
	db $03,$05,$16,$15,$19,$18,$1B,$1B,$03,$05,$16,$17,$19,$1A,$1B,$1B

DATA_058E85:
CODE_058E85:
	LDA.b !RAM_SMB1_Level_CurrentLevelType
	AND.w #$00FF
	ASL
	TAX
	LDA.w #(DATA_058DF9>>8)&$00FF00
	STA.b $D9
	LDA.w DATA_058DF9,x
	STA.b $D8
	LDA.b !RAM_SMB1_Level_CurrentLevelType
	AND.w #$00FF
	CMP.w #$0002
	BCS.b CODE_058EA9
	LDA.b !RAM_SMB1_Global_ScratchRAMEB
	CLC
	ADC.w #$0010
	TAX
	BRA.b CODE_058EAB

CODE_058EA9:
	LDX.b !RAM_SMB1_Global_ScratchRAMEB
CODE_058EAB:
	LDA.b !RAM_SMB1_Global_ScratchRAMEF
	SEC
	SBC.w #$0010
	ASL
	ASL
	TAY
	SEP.b #$20
	LDA.b [$D8],y
	STA.l !RAM_SMB1_Global_Layer2BGData+$20,x
	INY
	LDA.b [$D8],y
	STA.l !RAM_SMB1_Global_Layer2BGData+$21,x
	INY
	LDA.b [$D8],y
	STA.l !RAM_SMB1_Global_Layer2BGData+$30,x
	INY
	LDA.b [$D8],y
	STA.l !RAM_SMB1_Global_Layer2BGData+$31,x
	REP.b #$20
	INX
	INX
	DEC.b !RAM_SMB1_Global_ScratchRAMF1
	LDA.b !RAM_SMB1_Global_ScratchRAMF1
	BPL.b CODE_058EAB
	RTS

;--------------------------------------------------------------------

CODE_058EDC:
	STA.l !RAM_SMB1_Global_Layer2BGData,x
	STA.l !RAM_SMB1_Global_Layer2BGData+$0100,x
	STA.l !RAM_SMB1_Global_Layer2BGData+$0200,x
	STA.l !RAM_SMB1_Global_Layer2BGData+$0300,x
	STA.l !RAM_SMB1_Global_Layer2BGData+$0400,x
	STA.l !RAM_SMB1_Global_Layer2BGData+$0500,x
	STA.l !RAM_SMB1_Global_Layer2BGData+$0600,x
	STA.l !RAM_SMB1_Global_Layer2BGData+$0700,x
	STA.l !RAM_SMB1_Global_Layer2BGData+$0800,x
	STA.l !RAM_SMB1_Global_Layer2BGData+$0900,x
	STA.l !RAM_SMB1_Global_Layer2BGData+$0A00,x
	STA.l !RAM_SMB1_Global_Layer2BGData+$0B00,x
	STA.l !RAM_SMB1_Global_Layer2BGData+$0C00,x
	STA.l !RAM_SMB1_Global_Layer2BGData+$0D00,x
	STA.l !RAM_SMB1_Global_Layer2BGData+$0E00,x
	RTS

;--------------------------------------------------------------------

CODE_058F19:
	LDA.b !RAM_SMB1_Global_ScratchRAMEF
	ASL
	TAX
	LDA.w DATA_058F25,x
	STA.b $00
	JMP.w ($0000)

DATA_058F25:
	dw CODE_0590B6
	dw CODE_0590BA					; $01 - Add Sky HDMA gradient
	dw CODE_0590D2					; $02 - Add Underwater HDMA gradient
	dw CODE_0590E9
	dw CODE_05910D					; $04 - Upload tileset specific graphics (00-0F)
	dw CODE_059099
	dw CODE_05905F
	dw CODE_05903D
	dw CODE_059004
	dw CODE_058FFA					; $09 - Turn on layer 3
	dw CODE_058F97
	dw CODE_059116					; $0B - Upload tileset specific graphics (10-1F)
	dw CODE_058F6F					; $0C - Add sand to goomba pillar BG

;--------------------------------------------------------------------

DATA_058F3F:
	db $0C,$0D,$0E,$0F,$0C,$0D,$0E,$0F,$0C,$0D,$0E,$0F,$0C,$0D,$0E,$0F
	db $13,$14,$15,$16,$13,$14,$15,$16,$13,$14,$15,$16,$13,$14,$15,$16
	db $1A,$1A,$1A,$1A,$1A,$1A,$1A,$1A,$1A,$1A,$1A,$1A,$1A,$1A,$1A,$1A

CODE_058F6F:
	LDX.w #$00D0
	LDY.w #$0000
	SEP.b #$20
CODE_058F77:
	LDA.w DATA_058F3F,y
	JSR.w CODE_058EDC
	INX
	INY
	CPY.w #$0030
	BNE.b CODE_058F77
	REP.b #$20
	RTS

;--------------------------------------------------------------------

DATA_058F87:
	db $01,$02,$03,$07,$01,$02,$03,$07,$01,$02,$03,$07,$01,$02,$03,$07

CODE_058F97:
	STZ.b !RAM_SMB1_Global_ScratchRAME4
CODE_058F99:
	LDA.b !RAM_SMB1_Global_ScratchRAME4
	AND.w #$00FF
	XBA
	CLC
	ADC.w #$00A0
	TAX
	LDY.w #$0000
	SEP.b #$20
CODE_058FA9:
	LDA.w DATA_058F87,y
	STA.l !RAM_SMB1_Global_Layer2BGData,x
	TXA
	AND.b #$01
	BNE.b CODE_058FCF
	LDA.b #$0C
	STA.l !RAM_SMB1_Global_Layer2BGData+$10,x
	STA.l !RAM_SMB1_Global_Layer2BGData+$30,x
	STA.l !RAM_SMB1_Global_Layer2BGData+$50,x
	LDA.b #$10
	STA.l !RAM_SMB1_Global_Layer2BGData+$20,x
	STA.l !RAM_SMB1_Global_Layer2BGData+$40,x
	BRA.b CODE_058FE7

CODE_058FCF:
	LDA.b #$0D
	STA.l !RAM_SMB1_Global_Layer2BGData+$10,x
	STA.l !RAM_SMB1_Global_Layer2BGData+$30,x
	STA.l !RAM_SMB1_Global_Layer2BGData+$50,x
	LDA.b #$11
	STA.l !RAM_SMB1_Global_Layer2BGData+$20,x
	STA.l !RAM_SMB1_Global_Layer2BGData+$40,x
CODE_058FE7:
	INX
	INY
	TYA
	AND.b #$0F
	BNE.b CODE_058FA9
	REP.b #$20
	INC.b !RAM_SMB1_Global_ScratchRAME4
	LDA.b !RAM_SMB1_Global_ScratchRAME4
	CMP.w #$0006
	BNE.b CODE_058F99
	RTS

;--------------------------------------------------------------------

CODE_058FFA:
	SEP.b #$20
	LDA.b !RAM_SMB1_Global_ScratchRAMF1
	STA.w !RAM_SMB1_Global_EnableLayer3BGFlag
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_059004:
	LDX.w #$0080
CODE_059007:
	LDA.w #$0403
	STA.l !RAM_SMB1_Global_Layer2BGData,x
	LDA.w #$0909
	STA.l !RAM_SMB1_Global_Layer2BGData+$10,x
	STA.l !RAM_SMB1_Global_Layer2BGData+$20,x
	STA.l !RAM_SMB1_Global_Layer2BGData+$30,x
	STA.l !RAM_SMB1_Global_Layer2BGData+$40,x
	STA.l !RAM_SMB1_Global_Layer2BGData+$50,x
	STA.l !RAM_SMB1_Global_Layer2BGData+$60,x
	INX
	INX
	TXA
	AND.w #$000F
	BNE.b CODE_059007
	TXA
	CLC
	ADC.w #$00F0
	TAX
	CPX.w #$1000
	BCC.b CODE_059007
	RTS

;--------------------------------------------------------------------

CODE_05903D:
	LDX.w #$0000
	LDA.w #$0202
CODE_059043:
	JSR.w CODE_058EDC
	INX
	INX
	CPX.w #$0020
	BNE.b CODE_059043
	LDA.w #$0101
CODE_059050:
	JSR.w CODE_058EDC
	INX
	INX
	CPX.w #$0030
	BNE.b CODE_059050
	RTS

;--------------------------------------------------------------------

DATA_05905B:
	db $03,$05,$1D,$02

CODE_05905F:
	LDX.w #$0000
	SEP.b #$20
CODE_059064:
	LDA.w DATA_05905B
	STA.l !RAM_SMB1_Global_Layer2BGData,x
	LDA.w DATA_05905B+$01
	STA.l !RAM_SMB1_Global_Layer2BGData+$01,x
	LDA.w DATA_05905B+$02
	STA.l !RAM_SMB1_Global_Layer2BGData+$10,x
	LDA.w DATA_05905B+$03
	STA.l !RAM_SMB1_Global_Layer2BGData+$11,x
	INX
	INX
	TXA
	AND.b #$0F
	BNE.b CODE_059064
	REP.b #$20
	TXA
	CLC
	ADC.w #$0010
	TAX
	SEP.b #$20
	CPX.w #$0800
	BNE.b CODE_059064
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_059099:
	SEP.b #$20
	LDA.b !RAM_SMB1_Level_CurrentLevelType
	CMP.b #$02
	BEQ.b CODE_0590A5
	LDA.b #$5F
	BRA.b CODE_0590A7

CODE_0590A5:
	LDA.b #$00
CODE_0590A7:
	LDX.w #$0000
CODE_0590AA:
	JSR.w CODE_058EDC
	INX
	CPX.w #$0020
	BNE.b CODE_0590AA
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_0590B6:
	INC.w $0EC0
	RTS

;--------------------------------------------------------------------

CODE_0590BA:
	SEP.b #$30
	LDA.b !RAM_SMB1_Global_ScratchRAMF1
	CMP.b #$02
	BNE.b CODE_0590C4
	LDA.b #$FF
CODE_0590C4:
	CMP.b #$01
	BNE.b CODE_0590CB
	STA.w $0ED1
CODE_0590CB:
	JSL.l SMB1_InitializeGradientHDMA_Main
	REP.b #$30
	RTS

;--------------------------------------------------------------------

CODE_0590D2:
	SEP.b #$30
	LDA.b #$02
	JSL.l SMB1_InitializeGradientHDMA_Main
	REP.b #$30
	RTS

;--------------------------------------------------------------------

DATA_0590DD:
	db $0F,$20,$1B,$37,$58,$C9

DATA_0590E3:
	db $1F,$29,$1C,$38,$57,$CA

CODE_0590E9:
	LDX.w #$00D0
	LDY.b !RAM_SMB1_Global_ScratchRAMF1
	LDA.w DATA_0590DD,y
CODE_0590F1:
	JSR.w CODE_058EDC
	INX
	CPX.w #$00E0
	BNE.b CODE_0590F1
	LDA.w DATA_0590E3,y
CODE_0590FD:
	JSR.w CODE_058EDC
	INX
	CPX.w #$00F0
	BNE.b CODE_0590FD
	LDA.w #$0050
	JSR.w CODE_058EDC
	RTS

;--------------------------------------------------------------------

CODE_05910D:
	LDA.b !RAM_SMB1_Global_ScratchRAMF1
	STA.b $99
	JSL.l CODE_05E702
	RTS

;--------------------------------------------------------------------

CODE_059116:
	LDA.b !RAM_SMB1_Global_ScratchRAMF1
	ORA.w #$0010
	STA.b $99
	JSL.l CODE_05E702
	RTS

;--------------------------------------------------------------------

DATA_059122:
	dw $0000,$0000,$0009,$0004,$0006,$0001,$0004,$0004
	dw $0001,$0008,$000A,$0001,$0001,$0001,$0001,$0007
	dw $0004,$0004,$0007,$0001,$0001,$0001,$0001,$0001
	dw $0004,$0002,$0002,$0001,$0003,$0003,$0003,$0003
	dw $0003,$0005

SMB1_GenerateLayer2Map16:
.Main:
	LDA.b $DB
	ASL
	TAX
	LDA.w DATA_059122,x
	ASL
	TAX
	LDA.w DATA_0591CE,x
	STA.b $00
	LDA.w #DATA_059A2C>>16
	STA.b $02
	LDX.w #$0000
	LDY.w #$0000
CODE_05917F:
	STX.b !RAM_SMB1_Global_ScratchRAME4
	TYX
	LDA.l !RAM_SMB1_Global_Layer2BGData,x
	CMP.w #$FFFF
	BEQ.b CODE_0591CA
	PHY
	LDX.b !RAM_SMB1_Global_ScratchRAME4
	AND.w #$00FF
	ASL
	ASL
	ASL
	TAY
	LDA.b [$00],y
	STA.l !RAM_SMB1_Global_Layer2Map16Table,x
	INY
	INY
	LDA.b [$00],y
	STA.l !RAM_SMB1_Global_Layer2Map16Table+$02,x
	INY
	INY
	LDA.b [$00],y
	STA.l !RAM_SMB1_Global_Layer2Map16Table+$40,x
	INY
	INY
	LDA.b [$00],y
	STA.l !RAM_SMB1_Global_Layer2Map16Table+$42,x
	PLY
	INY
	TYA
	AND.w #$000F
	BNE.b CODE_0591C1
	TXA
	CLC
	ADC.w #$0040
	TAX
CODE_0591C1:
	INX
	INX
	INX
	INX
	CPY.w #$1000
	BNE.b CODE_05917F
CODE_0591CA:
	SEP.b #$30
	PLB
	RTL

DATA_0591CE:
	dw DATA_059A2C
	dw DATA_059C2C
	dw DATA_05AC14
	dw DATA_05A614
	dw DATA_05A364
	dw DATA_05972C
	dw DATA_059564
	dw DATA_0594EC
	dw DATA_05944C
	dw DATA_05A4C4
	dw DATA_0592A4

;--------------------------------------------------------------------

DATA_0591E4:
	db $00,$00,$00,$11,$00,$00,$00,$1F,$00,$00,$00,$0C,$00,$12,$00,$00
	db $08,$00,$00,$00,$00,$00,$04,$00,$10,$00,$00,$00,$0D,$00,$00,$00
	db $00,$00,$0A,$00,$1E,$00,$00,$00,$00,$00,$1F,$00,$17,$00,$00,$00
	db $00,$00,$00,$19,$12,$0C,$00,$00,$1B,$00,$00,$00,$00,$12,$00,$00
	db $00,$00,$00,$09,$00,$2A,$00,$00,$00,$00,$16,$00,$00,$00,$1B,$00
	db $00,$00,$00,$16,$08,$00,$00,$00,$00,$17,$00,$00,$00,$19,$00,$00
	db $00,$00,$0F,$00,$00,$14,$00,$00,$00,$1B,$00,$00,$11,$00,$00,$00
	db $00,$06,$00,$00,$0D,$00,$00,$00,$00,$07,$00,$00,$00,$00,$00,$12
	db $00,$08,$00,$00,$00,$00,$12,$00,$00,$0C,$00,$00,$16,$00,$00,$00
	db $00,$12,$00,$00,$00,$00,$00,$04,$00,$13,$00,$00,$19,$00,$00,$00
	db $00,$17,$00,$00,$00,$00,$1B,$00,$00,$00,$00,$16,$1C,$00,$00,$00
	db $00,$00,$1E,$00,$00,$15,$00,$00,$00,$00,$02,$00,$01,$00,$00,$00

;--------------------------------------------------------------------

DATA_0592A4:
	dw $0024,$0024,$0024,$0024
	dw $0024,$1DE0,$0024,$1DF0
	dw $1DE1,$0024,$5DF0,$0024
	dw $1DC2,$1DC3,$1DD2,$1DD3
	dw $1DC4,$1DC5,$1DD4,$1DD5
	dw $0024,$1DE3,$0024,$1DF3
	dw $1DE4,$0024,$1DF4,$0024
	dw $1DCA,$1DCB,$1DF1,$5DF1
	dw $1DC0,$1DC1,$0024,$1DE2
	dw $1DD0,$1DD1,$1DF2,$0024
	dw $1DC6,$1DC7,$1DD6,$1DD7
	dw $1DE6,$1DE7,$1DF6,$1DF7
	dw $1DEB,$1DEC,$1DFB,$1DFC
	dw $1DED,$0024,$1DFD,$1DFE
	dw $0024,$0024,$1DFF,$1DF8
	dw $0024,$1DEA,$1DF9,$1DFA
	dw $1DC8,$1DC1,$1DFD,$1DE2
	dw $1DD0,$1DD1,$1DF2,$1DF8
	dw $1DE5,$1DF5,$1DD9,$1DDA
	dw $1DCE,$1DCF,$1DEF,$1DEF
	dw $1DDC,$1DDD,$1DEF,$1DEF
	dw $1DDE,$1DDF,$1DEF,$1DEF
	dw $1DCC,$1DCD,$1DEF,$1DEF
	dw $1DDC,$1DE3,$1DEF,$1DF3
	dw $1DE4,$1DDF,$1DF4,$1DEF
	dw $1DE8,$1DE9,$1DDB,$1DEE
	dw $1DEF,$1DEF,$1DEF,$1DEF
	dw $1DC9,$1DC1,$1DEF,$1DE2
	dw $1DD0,$1DD8,$1DF2,$1DEF
	dw $1DE6,$1DE7,$1DD9,$1DDA
	dw $0024,$0024,$0024,$0024
	dw $0024,$15E0,$0024,$15F0
	dw $15E1,$0024,$55F0,$0024
	dw $15C2,$15C3,$15D2,$15D3
	dw $15C4,$15C5,$15D4,$15D5
	dw $0024,$15E3,$0024,$15F3
	dw $15E4,$0024,$15F4,$0024
	dw $15C0,$15C1,$0024,$15E2
	dw $15D0,$15D1,$15F2,$0024
	dw $15C2,$15C3,$0024,$15D3
	dw $15C4,$15C5,$15D4,$0024
	dw $15CA,$15CB,$15F1,$55F1
	dw $15C6,$15C7,$15D6,$15D7
	dw $15C8,$15C1,$15FD,$15E2
	dw $15D0,$15D1,$15F2,$15F8
	dw $15E6,$15E7,$15D9,$15DA
	dw $15DC,$15E3,$15EF,$15F3
	dw $15E4,$15DF,$15F4,$15EF
	dw $15E8,$15E9,$15DB,$15EE
	dw $15C9,$15C1,$15EF,$15E2
	dw $15D0,$15D8,$15F2,$15EF
	dw $15E6,$15E7,$15F6,$15F7
	dw $15E5,$15F5,$15D9,$15DA

DATA_05944C:
	dw $0024,$0024,$0024,$0024
	dw $0024,$0024,$1DD0,$1DD1
	dw $0024,$0024,$1DD2,$1DD3
	dw $0024,$1DC5,$1DD4,$1DD5
	dw $0024,$0024,$1DC1,$1DC2
	dw $0024,$0024,$1DFE,$1DFF
	dw $0024,$0024,$1DC0,$1DD1
	dw $1DC6,$1DC7,$1DD6,$1DD7
	dw $0024,$0024,$1DD2,$1DC3
	dw $0024,$0024,$1CCA,$1CCB
	dw $1DC6,$1DC7,$1DC4,$1DD7
	dw $0024,$0024,$1DFF,$1DFE
	dw $1DE8,$1DE9,$1DF8,$1DF9
	dw $1DEA,$1DEB,$1DFA,$1DFB
	dw $1DE0,$1DE1,$1DF0,$1DF1
	dw $1DE4,$1DE5,$1DF4,$1DF5
	dw $1DC8,$1DC9,$1DD8,$1DD9
	dw $1DCA,$1DCB,$1DDA,$1DDB
	dw $1DE2,$1DE3,$1DF2,$1DF3
	dw $1DE6,$1DE7,$1DF6,$1DF7

DATA_0594EC:
	dw $0024,$0024,$0024,$0024
	dw $1DC4,$1DC5,$1DD4,$1DD5
	dw $1DC0,$1DC1,$1DD0,$1DD1
	dw $1DC6,$1DC7,$1DD6,$1DD7
	dw $1DC8,$1DC9,$1DD8,$1DD9
	dw $1DD2,$1DD3,$1DC2,$1DC3
	dw $1DC2,$1DC3,$1DC2,$1DC3
	dw $1DCA,$1DCB,$1DDA,$1DDB
	dw $1DCC,$1DCD,$1DDC,$1DDD
	dw $1DCE,$1DCF,$1DDE,$1DDF
	dw $1DF2,$1DF3,$1DE2,$1DE3
	dw $1DE4,$1DE5,$1DF4,$1DF5
	dw $1DE2,$1DE3,$1DE2,$1DE3
	dw $1DE6,$1DE7,$1DF6,$1DF7
	dw $1DE0,$1DE1,$1DF0,$1DF1

DATA_059564:
	dw $0024,$0024,$0024,$0024
	dw $1DC0,$1DC1,$1DCA,$1DD1
	dw $1DC2,$1DC3,$1DD2,$1DCB
	dw $1DC2,$1DC3,$1DD2,$1DD3
	dw $1DC0,$1DC1,$1DD0,$1DD1
	dw $1DDA,$1DE1,$1DD0,$1DD1
	dw $1DE2,$1DDB,$1DD2,$1DD3
	dw $1DDA,$1DE1,$1DCA,$1DD1
	dw $1DE2,$1DE1,$1DE4,$1DE5
	dw $1DE2,$1DE1,$1DD2,$1DD1
	dw $1DE2,$1DDB,$1DD2,$1DCB
	dw $1DDA,$1DE1,$1DEA,$1DD1
	dw $1DF4,$1DF5,$1DD8,$1DE8
	dw $1DE2,$1DDB,$1DD2,$1DEB
	dw $1DC0,$1DC1,$1D92,$1DD1
	dw $1DE2,$1DE3,$1DD2,$1DD1
	dw $0024,$0024,$0024,$0024
	dw $1DFA,$1DE1,$1DCC,$1DD1
	dw $1DE2,$1DFB,$1DD2,$1DCD
	dw $1DA2,$1DE1,$1DB2,$1DD1
	dw $1DE2,$1DE1,$1DD2,$1DC6
	dw $1DC4,$1DC5,$1DC7,$1DE7
	dw $1DD4,$1DD5,$1DE7,$1DC8
	dw $1DE2,$1DE3,$1DC9,$1DD1
	dw $1DE2,$1DE1,$1DD2,$1D82
	dw $1DE2,$1DE1,$1D83,$1D84
	dw $1DE2,$1DE1,$1D85,$1D80
	dw $1DE2,$1DE1,$1D81,$1DD1
	dw $1DE2,$1DE1,$1DC9,$1DD1
	dw $1DE2,$1DD6,$1DD2,$1DE6
	dw $1DD7,$1DE7,$1DD7,$1DE7
	dw $1DE7,$5DD7,$1DE7,$5DD7
	dw $1DD9,$1DE3,$1DE9,$1DD1
	dw $1DE2,$1DDC,$1DD2,$1DEC
	dw $1DDD,$1DDE,$1DED,$1DEE
	dw $1DDF,$1D90,$1DEF,$1DA0
	dw $1D91,$1DE1,$1DA1,$1DD1
	dw $1DA2,$1DE3,$1DB2,$1DD1
	dw $1DD9,$1DE1,$1DE9,$1DD1
	dw $1DE2,$1DE1,$1DF0,$1DF1
	dw $1DE2,$1DE1,$1DF2,$1DF3
	dw $1DE2,$1DF6,$1DF0,$1DF1
	dw $1DF7,$1DCE,$1DF2,$1DF3
	dw $1DCF,$1DF8,$1DF0,$1DF1
	dw $1DF9,$1DE1,$1DF2,$1DF3
	dw $1DE2,$1DE3,$1DF0,$1DF1
	dw $1DFA,$1DE1,$1DF2,$1DF3
	dw $1DE2,$1DFC,$1DF0,$1DF1
	dw $1DFD,$1DFE,$1DF2,$1DF3
	dw $1DFF,$1DB0,$1DF0,$1DF1
	dw $1DB1,$1DE1,$1DF2,$1DF3
	dw $1DE2,$1DFB,$1DF0,$1DF1
	dw $1DA2,$1DE1,$1DF2,$1DF3
	dw $1DE2,$1DCB,$1DD2,$1DD3
	dw $1DCA,$1DE1,$1DD0,$1DD1
	dw $1586,$1586,$1587,$1587
	dw $1588,$1588,$1588,$1588

DATA_05972C:
	dw $1534,$1534,$1534,$1534
	dw $1534,$1536,$1534,$1536
	dw $1537,$1538,$1537,$1528
	dw $1534,$1D09,$1534,$1534
	dw $1D09,$1D0A,$1D19,$1D1A
	dw $1D0B,$1D0C,$1D1B,$1D1C
	dw $5D0C,$5D0B,$5D1C,$5D1B
	dw $5D0A,$5D09,$5D1A,$5D19
	dw $1509,$150A,$1519,$151A
	dw $150B,$150C,$151B,$151C
	dw $550C,$550B,$551C,$551B
	dw $550A,$5509,$551A,$5519
	dw $1500,$1501,$1510,$1511
	dw $1DBB,$1DBC,$1D34,$1D88
	dw $1DBD,$1DBC,$1D89,$1D8C
	dw $1DBD,$1DBC,$1D8D,$5D89
	dw $1DBD,$1DBE,$1D88,$1D34
	dw $1DB0,$1DB1,$1DB2,$1CE8
	dw $1520,$1521,$1530,$1531
	dw $1502,$1503,$1512,$1513
	dw $5DB1,$5DB0,$1CE9,$5DB2
	dw $1534,$1D34,$1534,$1D34
	dw $1D34,$1D98,$1D34,$1DA8
	dw $1D89,$1D8A,$1D99,$1D9A
	dw $1D8B,$5D89,$1D9B,$5D99
	dw $1D9C,$1D34,$1DAC,$1D34
	dw $1524,$1516,$1534,$1526
	dw $1517,$1518,$1527,$1528
	dw $1DB3,$1CEA,$1D34,$1D8E
	dw $1CEB,$5DB3,$1D8F,$1D34
	dw $1D34,$1DA8,$1D34,$1DA8
	dw $1DA9,$1D8A,$1DB9,$1DB9
	dw $1D8B,$5DA9,$1DB9,$1DBA
	dw $1DAC,$1D34,$1DAC,$1D34
	dw $1534,$1534,$1D0D,$1D0E
	dw $1534,$1534,$1D0F,$1534
	dw $1D1D,$1D1E,$1D2D,$1D2E
	dw $1D1F,$1D29,$1D2F,$1D39
	dw $1537,$1538,$1537,$1538
	dw $1D34,$1DA8,$1D34,$1DB8
	dw $1D8B,$5DA9,$1DB9,$1DB9
	dw $1DAC,$1D34,$1DBA,$1D34
	dw $1D3D,$1D3E,$1534,$1D15
	dw $1D3F,$1D2A,$1D25,$1D3A
	dw $1534,$9526,$9524,$9516
	dw $9527,$1538,$9517,$9518
	dw $1D80,$1D81,$1D90,$1D91
	dw $1D82,$1D83,$1D92,$1D93
	dw $1532,$1522,$1510,$1511
	dw $1522,$1523,$1510,$1511
	dw $1533,$1500,$1510,$1511
	dw $1DA0,$1DA1,$1510,$1511
	dw $1DA2,$1DA3,$1510,$1511
	dw $1533,$1534,$1510,$1511
	dw $1585,$1587,$1595,$1597
	dw $1584,$1586,$1594,$1596
	dw $1585,$1586,$1595,$1596
	dw $1584,$1587,$1594,$1597
	dw $1584,$1585,$1594,$1595
	dw $1586,$1585,$1596,$1595
	dw $15A6,$15A7,$15B6,$15B7
	dw $1594,$15A6,$15B4,$15B6
	dw $15A6,$15A6,$15B6,$15B6
	dw $1594,$15A7,$15B4,$15B7
	dw $1599,$1516,$1534,$1526
	dw $154C,$154D,$155C,$1540
	dw $154D,$154D,$1541,$1542
	dw $154D,$154D,$1543,$1544
	dw $154D,$154E,$1545,$155D
	dw $155C,$1550,$155C,$1560
	dw $1551,$1552,$1561,$1562
	dw $1553,$1554,$1563,$1564
	dw $1555,$155D,$1565,$155D
	dw $155C,$1570,$155C,$1546
	dw $1571,$1572,$1547,$1548
	dw $1573,$1574,$1549,$154A
	dw $1575,$155D,$154B,$155D
	dw $155C,$1556,$155C,$1566
	dw $1557,$1558,$1567,$1568
	dw $1559,$155A,$1569,$156A
	dw $155B,$155D,$156B,$155D
	dw $155C,$1576,$155E,$156C
	dw $1577,$1578,$156C,$156C
	dw $1579,$157A,$156C,$156C
	dw $157B,$155D,$156C,$156D
	dw $0024,$0024,$0024,$0024
	dw $0024,$0024,$0024,$0024
	dw $0024,$0024,$0024,$0024
	dw $0024,$0024,$0024,$0024
	dw $0024,$0024,$0024,$0024
	dw $0024,$0024,$0024,$0024
	dw $0024,$0024,$0024,$0024
	dw $0024,$0024,$0024,$0024
	dw $0024,$0024,$0024,$0024
	dw $0024,$0024,$0024,$0024
	dw $0024,$0024,$0024,$0024

DATA_059A2C:
	dw $0024,$0024,$0024,$0024
	dw $10A4,$10A4,$0024,$0024
	dw $10A4,$10A4,$10A4,$10A4
	dw $1572,$1571,$155E,$155F
	dw $0024,$0024,$0024,$1CF0
	dw $0024,$0024,$1CF1,$0024
	dw $1572,$1571,$155E,$155F
	dw $1572,$1571,$155E,$155F
	dw $1540,$1541,$1550,$1551
	dw $1546,$1547,$1556,$1557
	dw $1572,$1571,$155E,$155F
	dw $0024,$1CF2,$0024,$1CF4
	dw $1CF3,$0024,$1CF5,$0024
	dw $1560,$1561,$1570,$1571
	dw $1566,$1567,$1576,$1577
	dw $150A,$150B,$151A,$151B
	dw $150C,$150D,$151C,$151D
	dw $1528,$1529,$151A,$151B
	dw $1538,$1539,$151C,$151D
	dw $150E,$0024,$151E,$151F
	dw $1572,$1571,$155E,$155F
	dw $1572,$1571,$155E,$155F
	dw $1572,$1571,$155E,$155F
	dw $1572,$1571,$155E,$155F
	dw $1520,$1521,$1530,$1531
	dw $152A,$152B,$153A,$153B
	dw $152C,$152D,$153C,$153D
	dw $152E,$152F,$153E,$153F
	dw $1572,$1571,$155E,$155F
	dw $1572,$1571,$155E,$155F
	dw $1522,$1523,$1532,$1533
	dw $1572,$1571,$155E,$155F
	dw $150C,$150D,$151C,$151D
	dw $1528,$1529,$151A,$151B
	dw $1538,$1539,$151C,$151D
	dw $1542,$1543,$1552,$1553
	dw $1544,$1545,$1554,$1555
	dw $1562,$1563,$1572,$1573
	dw $1564,$1565,$1574,$1575
	dw $0024,$0024,$0024,$0024
	dw $0024,$0024,$0024,$0024
	dw $0024,$0024,$0024,$0024
	dw $0024,$0024,$0024,$0024
	dw $0024,$0024,$0024,$0024
	dw $0024,$0024,$0024,$0024
	dw $0024,$0024,$0024,$0024
	dw $0024,$0024,$0024,$0024
	dw $0024,$0024,$0024,$0024
	dw $1534,$1535,$151A,$151B
	dw $1536,$1537,$151C,$151D
	dw $152A,$152B,$1524,$1525
	dw $152C,$152D,$1526,$1527
	dw $15A4,$15A5,$15B4,$15B5
	dw $1505,$150B,$1515,$1503
	dw $0024,$1504,$0024,$1514
	dw $1510,$1511,$1513,$1527
	dw $0024,$0024,$0024,$1512
	dw $1506,$152B,$1509,$1507
	dw $152E,$152F,$153E,$1507
	dw $0024,$0024,$1508,$0024
	dw $152E,$152F,$1509,$1507
	dw $1572,$1571,$155E,$155F
	dw $1522,$1523,$1532,$1533
	dw $1572,$1571,$155E,$155F

DATA_059C2C:
	dw $1024,$1024,$1024,$1024
	dw $150A,$154A,$154A,$1516
	dw $1507,$1506,$155A,$1516
	dw $1024,$1501,$1510,$1511
	dw $1502,$1503,$150A,$150A
	dw $1504,$1024,$1514,$1515
	dw $150A,$150D,$150A,$151D
	dw $1507,$1024,$150E,$1507
	dw $150A,$151D,$150A,$150A
	dw $151F,$1517,$151E,$1555
	dw $151E,$1555,$150A,$150F
	dw $1555,$1517,$1555,$1555
	dw $1555,$1555,$151F,$1555
	dw $1507,$1506,$150E,$155B
	dw $1518,$150A,$150E,$1518
	dw $155E,$155E,$154F,$154F
	dw $150A,$154B,$154A,$1516
	dw $1555,$155A,$155A,$1516
	dw $1024,$1506,$1506,$1516
	dw $1516,$150A,$150A,$150A
	dw $1502,$1508,$150A,$150A
	dw $1509,$150A,$1514,$151A
	dw $550A,$150A,$150A,$150A
	dw $151E,$1517,$150A,$150F
	dw $1507,$1024,$1517,$1507
	dw $150A,$150F,$150A,$151D
	dw $1555,$1517,$151F,$1555
	dw $151F,$1555,$151E,$1555
	dw $1555,$1555,$1555,$1555
	dw $1507,$1506,$1517,$155B
	dw $1518,$150A,$1517,$1518
	dw $155F,$155F,$155F,$155F
	dw $1545,$150A,$150A,$150A
	dw $150A,$150A,$150A,$1519
	dw $150A,$1512,$150A,$9512
	dw $1513,$150A,$9513,$150A
	dw $1519,$550A,$550A,$D545
	dw $1547,$5547,$9547,$D547
	dw $1557,$5557,$9557,$D557
	dw $1512,$150A,$9512,$1519
	dw $150A,$150A,$1547,$5547
	dw $9547,$1554,$150A,$9557
	dw $5557,$150A,$D557,$150A
	dw $150B,$150C,$151B,$151C
	dw $150A,$150A,$150A,$150B
	dw $150A,$150A,$150C,$150A
	dw $150B,$151B,$151B,$150A
	dw $151C,$150C,$150A,$151C
	dw $5555,$5556,$5555,$D556
	dw $5555,$5546,$5555,$D546
	dw $155C,$1517,$5555,$5555
	dw $5555,$1517,$5555,$154C
	dw $1526,$1521,$1536,$1531
	dw $1522,$1523,$1532,$1533
	dw $1520,$1521,$1530,$1531
	dw $1522,$1524,$1532,$1534
	dw $1527,$1551,$1537,$1531
	dw $1552,$1553,$1532,$1533
	dw $1550,$1551,$1530,$1531
	dw $1552,$1548,$1532,$1558
	dw $1527,$1541,$1537,$1531
	dw $1542,$1543,$1532,$1533
	dw $1540,$1541,$1530,$1531
	dw $1542,$1544,$1532,$1535
	dw $152E,$1529,$153E,$1539
	dw $152A,$152B,$153A,$153B
	dw $1528,$1529,$1538,$1539
	dw $152A,$152C,$153A,$153C
	dw $152F,$1529,$153F,$1539
	dw $152A,$1549,$153A,$1559
	dw $152A,$152D,$153A,$153D
	dw $1560,$1561,$155E,$155F
	dw $1562,$1563,$1567,$1568
	dw $1562,$154D,$1567,$155D
	dw $1562,$154E,$1567,$155D
	dw $1562,$154F,$1567,$155D
	dw $1564,$1561,$1569,$155F
	dw $1565,$1561,$156A,$155F
	dw $1566,$1566,$1566,$1566
	dw $1586,$1586,$1587,$1587
	dw $1588,$1588,$1588,$1588
	dw $1512,$151F,$1512,$151F
	dw $1507,$1506,$15B0,$1516
	dw $1545,$1571,$150E,$15A2
	dw $1589,$158C,$159B,$159C
	dw $159D,$159F,$159F,$1512
	dw $1589,$158C,$159B,$159C
	dw $15FF,$15FF,$15FF,$15FF
	dw $15EE,$15EE,$15FE,$15FE
	dw $0027,$0027,$0027,$0027
	dw $0027,$0027,$0027,$0027
	dw $0027,$0027,$0027,$0027
	dw $0027,$0027,$0027,$0027
	dw $0027,$0027,$0027,$0027
	dw $0027,$0027,$0027,$0027
	dw $0027,$0027,$0027,$0027
	dw $142E,$1596,$1567,$1591
	dw $1597,$1503,$1512,$1513
	dw $154E,$1506,$1554,$1516
	dw $15A0,$15A1,$15B0,$1516
	dw $1517,$15B0,$15B0,$1516
	dw $1555,$1517,$1555,$9517
	dw $1555,$1555,$1555,$9517
	dw $1545,$1571,$1517,$15A2
	dw $1557,$1581,$1590,$1591
	dw $1582,$1583,$1592,$1593
	dw $1584,$1557,$1594,$1595
	dw $1512,$150D,$1512,$151D
	dw $1507,$1424,$150E,$1507
	dw $151E,$1517,$1512,$150F
	dw $1512,$151D,$1512,$1512
	dw $151F,$1517,$151E,$1555
	dw $1507,$154B,$150E,$1545
	dw $1518,$1519,$150E,$1518
	dw $1512,$150F,$1512,$151D
	dw $1555,$1517,$151F,$1555
	dw $151E,$1555,$1512,$150F
	dw $151F,$1555,$151E,$1555
	dw $1555,$1555,$151F,$1555
	dw $1545,$142E,$150E,$1545
	dw $1512,$1512,$1512,$1589
	dw $1512,$1512,$158C,$1512
	dw $1589,$158A,$1599,$159A
	dw $158B,$158C,$159B,$159C
	dw $158D,$158E,$1512,$158F
	dw $159D,$159E,$159F,$1512
	dw $1589,$158C,$1599,$159A
	dw $1589,$158C,$159B,$159C
	dw $15B3,$15B2,$15B2,$1516
	dw $15B3,$15A3,$15B2,$1516
	dw $1512,$1599,$1512,$158F
	dw $159D,$158E,$159F,$158F
	dw $159C,$1512,$159F,$1512
	dw $1512,$1512,$158C,$1589
	dw $1589,$158C,$159B,$159A
	dw $1512,$1512,$1589,$158C
	dw $1599,$159C,$158F,$159F
	dw $1512,$1599,$158C,$158F
	dw $1516,$1512,$1589,$158C
	dw $1516,$1512,$1512,$1589
	dw $1516,$1512,$1589,$158C
	dw $1599,$159C,$158D,$15B1
	dw $1512,$151D,$158C,$1512
	dw $1512,$151D,$158C,$1512
	dw $1562,$1563,$1572,$1573
	dw $1564,$1565,$1574,$1575
	dw $1566,$1567,$1576,$1577
	dw $1568,$1569,$1578,$1579
	dw $0024,$0024,$1D00,$1D01
	dw $0024,$0024,$1D02,$1D03
	dw $0024,$0024,$1D04,$1D05
	dw $0024,$0024,$1D06,$1D07
	dw $1D10,$1D11,$1D20,$1D21
	dw $1D12,$1D13,$1D22,$1D23
	dw $1D14,$1D15,$1D24,$1D25
	dw $1D16,$1D17,$1D26,$1D27
	dw $0024,$0024,$1D40,$1D41
	dw $1D30,$1D31,$1D08,$1D09
	dw $1D32,$1D33,$1D0A,$1D0B
	dw $1D34,$1D35,$1D0C,$1D0D
	dw $1D36,$1D37,$1D0E,$1D0F
	dw $1D50,$1D51,$1D60,$1D61
	dw $1D18,$1D19,$1D28,$1D29
	dw $1D1A,$1D1B,$1D2A,$1D2B
	dw $1D1C,$1D1D,$1D2C,$1D2D
	dw $1D1E,$1D1F,$1D2E,$1D2F
	dw $1D70,$1D71,$0024,$0024
	dw $1D38,$1D39,$0024,$0024
	dw $1D3A,$1D3B,$0024,$0024
	dw $1D3C,$1D3D,$0024,$0024
	dw $1D3E,$1D3F,$0024,$0024
	dw $1D3E,$1D3F,$0024,$0024
	dw $1D3E,$1D3F,$0024,$0024
	dw $1D3E,$1D3F,$0024,$0024
	dw $1D3E,$1D3F,$0024,$0024
	dw $1D3E,$1D3F,$0024,$0024
	dw $1DC0,$1DC1,$1DD0,$1DD1
	dw $1DC2,$1DC3,$1DD2,$1DD3
	dw $1DC4,$1DC5,$1DD4,$1DD5
	dw $1DC6,$1DC7,$1DD6,$1DD7
	dw $1DC8,$1DC9,$1DD8,$1DD9
	dw $1DCA,$0024,$1DDA,$1DDB
	dw $1DE8,$0024,$1DF8,$0024
	dw $1DE8,$1DE9,$1DF8,$1DF9
	dw $1DEA,$1DEB,$1DFA,$1DFB
	dw $0024,$1DE9,$0024,$1DF9
	dw $1DDF,$1DC3,$1DDC,$1DD3
	dw $1DE8,$1DE9,$1DF8,$1DF9
	dw $1DCC,$1DCD,$1DD0,$1DD1
	dw $1DCE,$1DCF,$1DD2,$1DD3
	dw $0024,$1DE5,$0024,$1DF5
	dw $0024,$1DDD,$0024,$1DDE
	dw $1DE0,$1DE1,$1DF0,$1DF1
	dw $1DE2,$1DE3,$1DF2,$1DF3
	dw $1DE4,$1DE5,$1DF4,$1DF5
	dw $1DE6,$1DE7,$1DF6,$1DF7
	dw $1DE2,$1DF8,$1DF2,$1DF3
	dw $1DE2,$1DE3,$1DF2,$1DF3
	dw $1DE4,$0024,$1DF4,$0024
	dw $0024,$0024,$1DEC,$1DED
	dw $1DE2,$1DF8,$1DF2,$1DF3
	dw $15EE,$15EE,$15FE,$15FE
	dw $15FF,$15FF,$15FF,$15FF
	dw $1D16,$1D12,$1D12,$1D89
	dw $1D16,$1D12,$1D89,$1D8C
	dw $1D99,$1D9C,$1D8D,$1DB1
	dw $1D12,$1D1D,$1D8C,$1D12
	dw $1D12,$1D1D,$1D8C,$1D12
	dw $1562,$1563,$1572,$1573
	dw $1564,$1565,$1574,$1575
	dw $1566,$1567,$1576,$1577
	dw $1568,$1569,$1578,$1579
	dw $1507,$1506,$15B0,$1516
	dw $1520,$1521,$1530,$1531
	dw $1522,$1523,$1532,$1533
	dw $1528,$1529,$1538,$1539
	dw $152A,$152B,$153A,$153B
	dw $1526,$1521,$1536,$1531
	dw $1522,$1524,$1532,$1534
	dw $152E,$1529,$153E,$1539
	dw $152A,$152C,$153A,$153C
	dw $1540,$1541,$1530,$1531
	dw $1542,$1543,$1532,$1533
	dw $1527,$1541,$1537,$1531
	dw $1522,$1524,$1532,$1534
	dw $152F,$1529,$153F,$1539
	dw $152A,$152D,$153A,$153D
	dw $1550,$1551,$1530,$1531
	dw $1552,$1553,$1532,$1533
	dw $1552,$1548,$1532,$1558
	dw $152A,$1549,$153A,$1559

DATA_05A364:
	dw $0024,$0024,$0024,$0024
	dw $1CC1,$0024,$0024,$0024
	dw $1CC2,$0024,$0024,$0024
	dw $1CC3,$0024,$0024,$0024
	dw $0024,$0024,$1CC0,$0024
	dw $0024,$0024,$1CC1,$0024
	dw $0024,$0024,$1CC2,$0024
	dw $0024,$0024,$1CC3,$0024
	dw $1CC4,$0024,$0024,$0024
	dw $1CC5,$0024,$0024,$0024
	dw $1CC6,$0024,$0024,$0024
	dw $1CC7,$0024,$0024,$0024
	dw $0024,$0024,$1CC4,$0024
	dw $0024,$0024,$1CC5,$0024
	dw $0024,$0024,$1CC6,$0024
	dw $0024,$0024,$1CC7,$0024
	dw $0024,$1CC0,$0024,$0024
	dw $0024,$1CC1,$0024,$0024
	dw $0024,$1CC2,$0024,$0024
	dw $0024,$1CC3,$0024,$0024
	dw $0024,$0024,$0024,$1CC0
	dw $0024,$0024,$0024,$1CC1
	dw $0024,$0024,$0024,$1CC2
	dw $0024,$0024,$0024,$1CC3
	dw $0024,$1CC4,$0024,$0024
	dw $0024,$1CC5,$0024,$0024
	dw $0024,$1CC6,$0024,$0024
	dw $0024,$1CC7,$0024,$0024
	dw $0024,$0024,$0024,$1CC4
	dw $0024,$0024,$0024,$1CC5
	dw $0024,$0024,$0024,$1CC6
	dw $0024,$0024,$0024,$1CC7
	dw $15E0,$15E0,$15E1,$15E1
	dw $15C6,$15C7,$15D6,$15D7
	dw $15C8,$15C9,$15D8,$15D9
	dw $15CA,$15CB,$15DA,$15DB
	dw $15CC,$15CD,$15DC,$15DD
	dw $15E6,$15E7,$15F6,$15F7
	dw $15E8,$15E9,$15F8,$15F9
	dw $15EA,$15EB,$15FA,$15FB
	dw $15EC,$15ED,$15FC,$15FD
	dw $15E2,$15E2,$15E2,$15E2
	dw $1CC0,$0024,$0024,$0024
	dw $1CC0,$0024,$0024,$0024

DATA_05A4C4:
	dw $0024,$0024,$0024,$0024
	dw $1504,$1505,$1516,$1517
	dw $1506,$1507,$1520,$1521
	dw $1504,$1505,$1522,$1523
	dw $1506,$1507,$1514,$1515
	dw $150C,$150D,$151C,$151D
	dw $0024,$0024,$151E,$0024
	dw $0024,$152C,$0024,$153C
	dw $150C,$152A,$1516,$153A
	dw $152B,$1507,$153B,$1521
	dw $1526,$1527,$1536,$1537
	dw $1530,$1531,$1508,$0024
	dw $1532,$1533,$0024,$150B
	dw $1524,$1525,$1534,$1535
	dw $1526,$151B,$1536,$1537
	dw $150F,$0024,$1508,$0024
	dw $0024,$0024,$0024,$153E
	dw $152E,$152F,$153F,$1535
	dw $1518,$0024,$154A,$154B
	dw $0024,$1519,$155A,$155B
	dw $0024,$1519,$155C,$1548
	dw $1524,$1525,$1544,$1545
	dw $1526,$1527,$1546,$1547
	dw $0024,$0024,$155C,$1551
	dw $0024,$0024,$1552,$1553
	dw $0024,$1519,$1550,$1548
	dw $1500,$1501,$1511,$1500
	dw $1568,$1569,$1578,$1579
	dw $156A,$156B,$157A,$157B
	dw $1510,$1511,$1501,$1510
	dw $156C,$1561,$157C,$1571
	dw $1554,$1555,$1572,$1573
	dw $1556,$1557,$1574,$1575
	dw $154C,$154D,$1576,$1577
	dw $1562,$1563,$1572,$1573
	dw $1564,$1565,$1574,$1575
	dw $1566,$1567,$1576,$1577
	dw $1560,$1561,$157C,$1571
	dw $1554,$1558,$1572,$1559
	dw $1516,$1517,$1518,$1519
	dw $1519,$1518,$1518,$1519
	dw $1506,$1506,$1514,$1515

DATA_05A614:
	dw $1534,$1534,$1534,$1534
	dw $1534,$1504,$1534,$1504
	dw $1505,$1506,$1505,$1506
	dw $1529,$152A,$1519,$151A
	dw $152B,$152C,$151B,$151C
	dw $1538,$1534,$1538,$1534
	dw $1519,$151A,$1519,$151A
	dw $151B,$151C,$151B,$151C
	dw $1509,$150A,$1519,$151A
	dw $150B,$150C,$151B,$151C
	dw $1534,$1504,$1534,$1514
	dw $1505,$1506,$1515,$1506
	dw $1500,$1501,$1510,$1511
	dw $1500,$1502,$1510,$1512
	dw $1503,$1501,$1513,$1511
	dw $150D,$150A,$151D,$151A
	dw $150B,$150E,$151B,$151E
	dw $150F,$1501,$151F,$1511
	dw $1520,$1521,$1530,$1531
	dw $1520,$1522,$1530,$1532
	dw $1523,$1521,$1533,$1531
	dw $1520,$1521,$1530,$1530
	dw $152D,$151A,$153D,$151A
	dw $151B,$152E,$151B,$153E
	dw $152F,$1521,$153F,$1531
	dw $1535,$1535,$1534,$1534
	dw $1524,$1516,$1534,$1526
	dw $1517,$1518,$1527,$1528
	dw $1525,$1535,$1534,$1534
	dw $1539,$150A,$1519,$151A
	dw $153A,$1535,$1538,$1534
	dw $1534,$1536,$1534,$1536
	dw $1537,$1528,$1537,$1528
	dw $1502,$1503,$1512,$1505
	dw $1504,$1524,$1514,$1515
	dw $1524,$1506,$1506,$1516
	dw $1512,$1512,$1512,$1512
	dw $150E,$1517,$150F,$1555
	dw $1507,$1524,$1517,$1507
	dw $1516,$151B,$150B,$151B
	dw $150C,$1512,$151C,$150C
	dw $151D,$1555,$151E,$1555
	dw $1555,$1517,$1555,$1555
	dw $1516,$150B,$1512,$1512
	dw $151B,$1512,$1512,$1512
	dw $151E,$1555,$1512,$1555
	dw $1555,$1555,$1555,$1555
	dw $1D80,$1D81,$1D90,$1D91
	dw $5D81,$5D80,$1D92,$5D90
	dw $1DA0,$1DA1,$1DB0,$1D82
	dw $1DA2,$1DB1,$5D82,$1DB2
	dw $1534,$157C,$1534,$157D
	dw $1587,$1588,$1597,$1598
	dw $1D83,$1D84,$1D93,$1D94
	dw $1D85,$1D86,$1D95,$1D96
	dw $15A7,$15A8,$15B7,$15B8
	dw $1534,$158A,$1534,$159A
	dw $1589,$158B,$1513,$159B
	dw $1DA3,$1DA4,$1530,$1530
	dw $1DA5,$1DA6,$1530,$1530
	dw $15B3,$15B4,$15B5,$15B6
	dw $15A9,$15AA,$15B9,$1532
	dw $1523,$15AB,$1533,$1531
	dw $1535,$1516,$1534,$1526
	dw $1599,$1516,$1534,$1526
	dw $154C,$154D,$155C,$1540
	dw $154D,$154D,$1541,$1542
	dw $154D,$154D,$1543,$1544
	dw $154D,$154E,$1545,$155D
	dw $155C,$1550,$155C,$1560
	dw $1551,$1552,$1561,$1562
	dw $1553,$1554,$1563,$1564
	dw $1555,$155D,$1565,$155D
	dw $155C,$1570,$155C,$1546
	dw $1571,$1572,$1547,$1548
	dw $1573,$1574,$1549,$154A
	dw $1575,$155D,$154B,$155D
	dw $155C,$1556,$155C,$1566
	dw $1557,$1558,$1567,$1568
	dw $1559,$155A,$1569,$156A
	dw $155B,$155D,$156B,$155D
	dw $155C,$1576,$155E,$156C
	dw $1577,$1578,$156C,$156C
	dw $1579,$157A,$156C,$156C
	dw $157B,$155D,$156C,$156D
	dw $1504,$1505,$1504,$1505
	dw $1506,$1534,$1506,$1534
	dw $1534,$1529,$1534,$1519
	dw $152A,$152B,$151A,$151B
	dw $152C,$1538,$151C,$1538
	dw $1534,$1519,$1534,$1519
	dw $151A,$151B,$151A,$151B
	dw $151C,$1538,$151C,$1538
	dw $1534,$1509,$1534,$1519
	dw $150A,$150B,$151A,$151B
	dw $0024,$0024,$0024,$0024
	dw $1534,$1534,$1534,$1534
	dw $1534,$1536,$1534,$1536
	dw $1537,$1538,$1537,$1528
	dw $1534,$1D09,$1534,$1534
	dw $1D09,$1D0A,$1D19,$1D1A
	dw $1D0B,$1D0C,$1D1B,$1D1C
	dw $5D0C,$5D0B,$5D1C,$5D1B
	dw $1534,$1D8D,$1D9C,$1D9D
	dw $1DAC,$1DAD,$1DBC,$1DBD
	dw $1D8C,$1D8E,$1DBB,$1D9E
	dw $5DAD,$5DAC,$5DBD,$5DBC
	dw $550A,$5509,$551A,$5519
	dw $1500,$1501,$1510,$1511
	dw $1DBB,$1DBC,$1D34,$1D88
	dw $1DBD,$1DBC,$1D89,$1D8C
	dw $1DBD,$1DBC,$1D8D,$5D89
	dw $1534,$1534,$1534,$15CE
	dw $15EC,$15ED,$15FC,$15FD
	dw $15EE,$15EF,$15FE,$15FF
	dw $1534,$1534,$15CF,$1534
	dw $15CE,$15CF,$1534,$15DE
	dw $15D8,$15D9,$15C9,$15FD
	dw $15C1,$15C2,$15FE,$15DF
	dw $15CE,$15CF,$15DE,$1534
	dw $15CE,$15CF,$1534,$15DE
	dw $15D8,$15D9,$156E,$15FD
	dw $15C1,$15C2,$15FE,$156F
	dw $15CE,$15CF,$15DE,$1534
	dw $15CE,$15CF,$1534,$1534
	dw $15CE,$15CF,$1534,$1534
	dw $1D34,$1DA8,$1D34,$1DA8
	dw $1DA9,$1D8A,$1DB9,$1DB9
	dw $1534,$15DE,$15CE,$15CF
	dw $15C9,$15FD,$15D8,$15D9
	dw $15FE,$15DF,$15C1,$15C2
	dw $15DE,$1534,$15CE,$15CF
	dw $1D1D,$1D1E,$1D2D,$1D2E
	dw $1D1F,$1D29,$1D2F,$1D39
	dw $1537,$1538,$1537,$1538
	dw $1534,$15DE,$1534,$1534
	dw $156E,$15FD,$1534,$1534
	dw $15FE,$156F,$1534,$1534
	dw $15DE,$1534,$1534,$1534
	dw $1D3F,$1D2A,$1D25,$1D3A
	dw $1534,$9526,$9524,$9516
	dw $9527,$1538,$9517,$9518
	dw $1D80,$1D81,$1D90,$1D91
	dw $1D82,$1D83,$1D92,$1D93
	dw $1DBD,$1DBE,$1D88,$1D34
	dw $1DB0,$1DB1,$1DB2,$1D2B
	dw $1520,$1521,$1530,$1531
	dw $1502,$1503,$1512,$1513
	dw $5DB1,$5DB0,$1D2C,$5DB2
	dw $1534,$1D34,$1534,$1D34
	dw $1D34,$1D98,$1D34,$1DA8
	dw $1D89,$1D8A,$1D99,$1D9A
	dw $1D8B,$5D89,$1D9B,$5D99
	dw $1D9C,$1D34,$1DAC,$1D34
	dw $1524,$1516,$1534,$1526
	dw $1517,$1518,$1527,$1528
	dw $1DB3,$1D3B,$1D34,$1D8E
	dw $1D3C,$5DB3,$1D8F,$1D34
	dw $1D34,$1DA8,$1D34,$1DA8
	dw $1DA9,$1D8A,$1DB9,$1DB9
	dw $1D8B,$5DA9,$1DB9,$1DBA
	dw $1DAC,$1D34,$1DAC,$1D34
	dw $1534,$1534,$1D0D,$1D0E
	dw $1534,$1534,$1D0F,$1534
	dw $1D1D,$1D1E,$1D2D,$1D2E
	dw $1D1F,$1D29,$1D2F,$1D39
	dw $1537,$1538,$1537,$1538
	dw $1D34,$1DA8,$1D34,$1DB8
	dw $1D8B,$5DA9,$1DB9,$1DB9
	dw $1DAC,$1D34,$1DBA,$1D34
	dw $1D3D,$1D3E,$1534,$1D15
	dw $1D3F,$1D2A,$1D25,$1D3A
	dw $1534,$9526,$9524,$9516
	dw $9527,$1538,$9517,$9518
	dw $1D80,$1D81,$1D90,$1D91
	dw $1D82,$1D83,$1D92,$1D93
	dw $1532,$1522,$1510,$1511
	dw $1522,$1523,$1510,$1511
	dw $1533,$1500,$1510,$1511
	dw $1DA0,$1DA1,$1510,$1511
	dw $1DA2,$1DA3,$1510,$1511
	dw $1533,$1534,$1510,$1511
	dw $1585,$1587,$1595,$1597
	dw $1584,$1586,$1594,$1596
	dw $1585,$1586,$1595,$1596
	dw $1584,$1587,$1594,$1597
	dw $1584,$1585,$1594,$1595
	dw $1586,$1585,$1596,$1595
	dw $15A6,$15A7,$15B6,$15B7
	dw $1594,$15A6,$15B4,$15B6
	dw $15A6,$15A6,$15B6,$15B6
	dw $1594,$15A7,$15B4,$15B7

DATA_05AC14:
	dw $1024,$1024,$1024,$1024
	dw $150E,$150F,$151E,$151F
	dw $1D02,$1D03,$1D12,$1D13
	dw $1D20,$1D21,$1D30,$1D31
	dw $152E,$152F,$153E,$153F
	dw $1D22,$1D23,$1D32,$1D33
	dw $1D20,$1D21,$151C,$151D
	dw $1528,$1529,$1D10,$1D11
	dw $152A,$152B,$1D12,$1D13
	dw $156C,$156D,$157C,$157D
	dw $154E,$154F,$155E,$155F
	dw $156E,$156F,$157E,$157F
	dw $1D48,$1D49,$1D58,$1D59
	dw $1D4A,$1D4B,$1D5A,$1D5B
	dw $150C,$150D,$151C,$151D
	dw $1D68,$1D69,$1D78,$1D79
	dw $1D6A,$1D6B,$1D7A,$1D7B
	dw $1528,$1529,$1538,$1539
	dw $152A,$152B,$153A,$153B
	dw $1508,$1509,$1518,$1519
	dw $150A,$150B,$151A,$151B
	dw $1D06,$1D07,$1D16,$1517
	dw $1504,$1D05,$1D14,$1D15
	dw $1D06,$1D03,$1D16,$1D13
	dw $1D26,$1D27,$1D36,$1D37
	dw $1D24,$1D25,$1D34,$1D35
	dw $1D26,$1D23,$1D36,$1D33
	dw $152C,$152D,$153C,$153D
	dw $153D,$153C,$153C,$153D
	dw $1D00,$1D01,$1D10,$1D11

;--------------------------------------------------------------------

DATA_05AD04:
	dw DATA_05B557-DATA_05B557
	dw DATA_05B58D-DATA_05B557
	dw DATA_05B61D-DATA_05B557

	dw DATA_05B62F-DATA_05B557
	dw DATA_05B70F-DATA_05B557
	dw DATA_05B781-DATA_05B557
	dw DATA_05B7BB-DATA_05B557
	dw DATA_05B965-DATA_05B557
	dw DATA_05BB0F-DATA_05B557
	dw DATA_05BB41-DATA_05B557
	dw DATA_05BB67-DATA_05B557
	dw DATA_05BBA3-DATA_05B557
	dw DATA_05BBD1-DATA_05B557
	dw DATA_05BBDD-DATA_05B557
	dw DATA_05BC0F-DATA_05B557
	dw DATA_05BC1D-DATA_05B557
	dw DATA_05BC81-DATA_05B557
	dw DATA_05BD61-DATA_05B557
	dw DATA_05BF0B-DATA_05B557
	dw DATA_05BF27-DATA_05B557
	dw DATA_05BF79-DATA_05B557
	dw DATA_05BFAB-DATA_05B557
	dw DATA_05BFCF-DATA_05B557
	dw DATA_05C001-DATA_05B557
	dw DATA_05C00D-DATA_05B557

	dw DATA_05C1B7-DATA_05B557
	dw DATA_05C2A7-DATA_05B557
	dw DATA_05C397-DATA_05B557

	dw DATA_05C3AF-DATA_05B557
	dw DATA_05C413-DATA_05B557
	dw DATA_05C47D-DATA_05B557
	dw DATA_05C4E1-DATA_05B557
	dw DATA_05C545-DATA_05B557
	dw DATA_05C5B7-DATA_05B557

;--------------------------------------------------------------------

if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
DATA_05AD48:
	db $FE,$00,$B9,$B8,$B6,$FE,$00,$BE,$C3,$C6,$FE,$B4,$B1,$BC,$BD,$B0
	db $B5,$FE,$C0,$C1,$C0,$C1,$C0,$C4,$FE,$B2,$B3,$B2,$B3,$B2,$B3,$B6
	db $FE,$C2,$C3,$C2,$C3,$C2,$C3,$C6,$FE,$C2,$C3,$C2,$C3,$C2,$C3,$C6
	db $FE,$C2,$C3,$C2,$C3,$C2,$C3,$C6,$FF

DATA_05AD79:
	db $FE,$B9,$B8,$FE,$BE,$C3,$FE,$BE,$C3,$FE,$BE,$C3,$FF

DATA_05AD83:
	db $FE,$00,$00,$BA,$B0,$B5,$FE,$00,$BF,$C1,$C0,$C4,$FE,$00,$B9,$B3
	db $B2,$B3,$B6,$FE,$00,$BE,$C3,$C2,$C3,$C6,$FE,$00,$BA,$BC,$BD,$BC
	db $BD,$B0,$B5,$FE,$BF,$C1,$C0,$C1,$C0,$C1,$C0,$C4,$FE,$B9,$B3,$B2
	db $B3,$B2,$B3,$B2,$B3,$FE,$BE,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$FE,$BE
	db $C3,$C2,$C3,$C2,$C3,$C2,$C3,$FE,$BE,$C3,$C2,$C3,$C2,$C3,$C2,$C3
	db $FF

DATA_05ADCB:
	db $FE,$00,$00,$00,$00,$C7,$FE,$00,$00,$00,$BF,$C4,$FE,$00,$00,$00
	db $B9,$B3,$B6,$00,$B9,$B8,$BB,$B8,$B6,$FE,$00,$00,$00,$BE,$C3,$C6
	db $00,$BE,$C3,$C2,$C3,$C6,$FE,$00,$00,$B4,$B1,$BC,$BD,$B0,$B1,$BC
	db $BD,$BC,$BD,$B0,$B5,$FE,$00,$00,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C1
	db $C0,$C1,$C0,$C4,$FE,$B9,$B8,$B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$B2
	db $B3,$B2,$B3,$FE,$BE,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3
	db $C2,$C3,$FE,$BE,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2
	db $C3,$FE,$BE,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3
	db $FF

DATA_05AE3D:
	db $FE,$00,$00,$00,$00,$C7,$FE,$00,$00,$00,$BF,$C4,$FE,$00,$B9,$B8
	db $BB,$B3,$BB,$B8,$B6,$FE,$00,$BE,$C3,$C2,$C3,$C2,$C3,$C6,$FE,$B4
	db $B1,$BC,$BD,$BC,$BD,$BC,$BD,$B0,$B5,$FE,$C0,$C1,$C0,$C1,$C0,$C1
	db $C0,$C1,$C0,$C4,$FE,$B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$FE
	db $C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$FE,$C2,$C3,$C2,$C3,$C2
	db $C3,$C2,$C3,$C2,$C3,$FE,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3
	db $FF

DATA_05AE93:
	db $FE,$B6,$FE,$C6,$FE,$C6,$FF,$C6,$FF

DATA_05AE9A:
	db $FE,$B4,$B1,$FE,$C0,$C1,$FE,$B2,$B3,$FE,$C2,$C3,$FE,$C2
	db $C3,$FE,$C2,$C3,$FF

DATA_05AEAA:
	db $FE,$00,$00,$00,$00,$00,$B9,$B8,$B6,$FE,$00,$00,$00,$00,$00,$BE
	db $C3,$C6,$FE,$00,$00,$00,$00,$B4,$B1,$BC,$BD,$B0,$B5,$FE,$00,$00
	db $00,$00,$C0,$C1,$C0,$C1,$C0,$C4,$FE,$B9,$B8,$BB,$B8,$B2,$B3,$B2
	db $B3,$B2,$B3,$FE,$BE,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$FE,$BE
	db $C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$FE,$BE,$C3,$C2,$C3,$C2,$C3
	db $C2,$C3,$C2,$C3,$FF

DATA_05AEF4:
	db $FE,$00,$00,$00,$00,$C7,$00,$C7,$FE,$00,$00,$00,$BF,$C4,$BF,$C4
	db $FE,$00,$B9,$B8,$BB,$B3,$BB,$B3,$B6,$FE,$00,$BE,$C3,$C2,$C3,$C2
	db $C3,$C6,$FE,$B4,$B1,$BC,$BD,$BC,$BD,$BC,$BD,$B0,$B5,$FE,$C0,$C1
	db $C0,$C1,$C0,$C1,$C0,$C1,$C0,$C4,$FE,$B2,$B3,$B2,$B3,$B2,$B3,$B2
	db $B3,$B2,$B3,$FE,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$FE,$C2
	db $C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$FE,$C2,$C3,$C2,$C3,$C2,$C3
	db $C2,$C3,$C2,$C3,$FF

DATA_05AF4E:
	db $FE,$00,$00,$BA,$B0,$B5,$00,$00,$00,$C7,$FE,$00,$BF,$C1,$C0,$C4
	db $00,$00,$BF,$C4,$FE,$00,$B9,$B3,$B2,$B3,$B6,$00,$B9,$B3,$BB,$B8
	db $B6,$FE,$00,$BE,$C3,$C2,$C3,$C6,$00,$BE,$C3,$C2,$C3,$C6,$FE,$B4
	db $B1,$BC,$BD,$BC,$BD,$B0,$B1,$BC,$BD,$BC,$BD,$B0,$B1,$B0,$B5,$FE
	db $C0,$C1,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C4
	db $FE,$B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$B2
	db $B3,$B6,$FE,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2
	db $C3,$C2,$C3,$C6,$FE,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2
	db $C3,$C2,$C3,$C2,$C3,$C6,$FE,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2
	db $C3,$C2,$C3,$C2,$C3,$C2,$C3,$C6,$FF

DATA_05AFD5:
	db $FE,$00,$00,$00,$00,$C7,$FE,$00,$00,$00,$BF,$C4,$FE,$00,$B9,$B8
	db $BB,$B3,$B6,$FE,$00,$BE,$C3,$C2,$C3,$C6,$FE,$B4,$B1,$BC,$BD,$BC
	db $BD,$B0,$B5,$FE,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C4,$FE,$B2,$B3,$B2
	db $B3,$B2,$B3,$B2,$B3,$FE,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$FE,$C2
	db $C3,$C2,$C3,$C2,$C3,$C2,$C3,$FE,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3
	db $FF

DATA_05B01D:
	db $FE,$B4,$B1,$B0,$B5,$FE,$C0,$C1,$C0,$C8,$FE,$B2,$B3,$B2,$B3,$B6
	db $FE,$C2,$C3,$C2,$C3,$C6,$FE,$C2,$C3,$C2,$C3,$C6,$FE,$C2,$C3,$C2
	db $C3,$C6,$FF

DATA_05B03A:
	db $FE,$00,$00,$00,$00,$00,$B4,$B5,$00,$C7,$B4,$B5,$FE,$00,$00,$00
	db $00,$00,$C0,$C8,$BF,$C8,$C0,$C8,$FE,$00,$00,$00,$B9,$B8,$B2,$B3
	db $BB,$B3,$B2,$B3,$B6,$FE,$00,$00,$00,$BE,$C3,$C2,$C3,$C2,$C3,$C2
	db $C3,$C6,$FE,$00,$BA,$B0,$B1,$BC,$BD,$BC,$BD,$BC,$BD,$BC,$BD,$B0
	db $B5,$FE,$BF,$C1,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C4
	db $FE,$B9,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$BB
	db $B8,$B6,$FE,$BE,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2
	db $C3,$C2,$C3,$C6,$FE,$BE,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2
	db $C3,$C2,$C3,$C2,$C3,$C6,$FE,$BE,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2
	db $C3,$C2,$C3,$C2,$C3,$C2,$C3,$C6,$FF

DATA_05B0C1:
	db $FE,$00,$00,$B4,$B1,$B0,$B5,$FE,$00,$00,$C0,$C1,$C0,$C4,$FE,$BB
	db $B8,$B2,$B3,$B2,$B3,$B6,$FE,$C2,$C3,$C2,$C3,$C2,$C3,$C6,$FE,$C2
	db $C3,$C2,$C3,$C2,$C3,$C6,$FE,$C2,$C3,$C2,$C3,$C2,$C3,$C6,$FF

DATA_05B0E8:
	db $FE,$00,$00,$00,$00,$00,$00,$00,$C7,$FE,$00,$00,$00,$00,$00,$00
	db $BF,$C4,$FE,$00,$00,$B9,$B8,$B6,$00,$B9,$B3,$BB,$B8,$B6,$FE,$00
	db $00,$BE,$C3,$C6,$00,$BE,$C3,$C2,$C3,$C6,$FE,$00,$00,$BA,$BC,$BD
	db $B0,$B1,$BC,$BD,$BC,$BD,$B0,$B5,$FE,$00,$BF,$C1,$C0,$C1,$C0,$C1
	db $C0,$C1,$C0,$C1,$C0,$C4,$FE,$00,$B9,$B3,$B2,$B3,$B2,$B3,$B2,$B3
	db $B2,$B3,$B2,$B3,$B6,$FE,$00,$BE,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2
	db $C3,$C2,$C3,$C6,$FE,$B4,$B1,$BC,$BD,$BC,$BD,$BC,$BD,$BC,$BD,$BC
	db $BD,$BC,$BD,$B0,$B5,$FE,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C1
	db $C0,$C1,$C0,$C1,$C0,$C4,$FE,$B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$B2
	db $B3,$B2,$B3,$B2,$B3,$B2,$B3,$B6,$FE,$C2,$C3,$C2,$C3,$C2,$C3,$C2
	db $C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C6,$FE,$C2,$C3,$C2,$C3,$C2
	db $C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C6,$FE,$C2,$C3,$C2
	db $C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C6,$FF

else

DATA_05AD48:
	db $FE,$00,$B9,$B8,$B6,$FE,$00,$BE,$C3,$C6,$FE,$B4,$B1,$BC,$BD,$B0
	db $B5,$FE,$C0,$C1,$C0,$C1,$C0,$C4,$FE,$B2,$B3,$B2,$B3,$B2,$B3,$B6
	db $FE,$C2,$C3,$C2,$C3,$C2,$C3,$C6,$FE,$C2,$C3,$C2,$C3,$C2,$C3,$C6
	db $FF

DATA_05AD79:
	db $FE,$B9,$B8,$FE,$BE,$C3,$FE,$BE,$C3,$FF

DATA_05AD83:
	db $FE,$00,$00,$BA,$B0,$B5,$FE,$00,$BF,$C1,$C0,$C4,$FE,$00,$B9,$B3
	db $B2,$B3,$B6,$FE,$00,$BE,$C3,$C2,$C3,$C6,$FE,$00,$BA,$BC,$BD,$BC
	db $BD,$B0,$B5,$FE,$BF,$C1,$C0,$C1,$C0,$C1,$C0,$C4,$FE,$B9,$B3,$B2
	db $B3,$B2,$B3,$B2,$B3,$FE,$BE,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$FE,$BE
	db $C3,$C2,$C3,$C2,$C3,$C2,$C3,$FF

DATA_05ADCB:
	db $FE,$00,$00,$00,$00,$C7,$FE,$00,$00,$00,$BF,$C4,$FE,$00,$00,$00
	db $B9,$B3,$B6,$00,$B9,$B8,$BB,$B8,$B6,$FE,$00,$00,$00,$BE,$C3,$C6
	db $00,$BE,$C3,$C2,$C3,$C6,$FE,$00,$00,$B4,$B1,$BC,$BD,$B0,$B1,$BC
	db $BD,$BC,$BD,$B0,$B5,$FE,$00,$00,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C1
	db $C0,$C1,$C0,$C4,$FE,$B9,$B8,$B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$B2
	db $B3,$B2,$B3,$FE,$BE,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3
	db $C2,$C3,$FE,$BE,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2
	db $C3,$FF

DATA_05AE3D:
	db $FE,$00,$00,$00,$00,$C7,$FE,$00,$00,$00,$BF,$C4,$FE,$00,$B9,$B8
	db $BB,$B3,$BB,$B8,$B6,$FE,$00,$BE,$C3,$C2,$C3,$C2,$C3,$C6,$FE,$B4
	db $B1,$BC,$BD,$BC,$BD,$BC,$BD,$B0,$B5,$FE,$C0,$C1,$C0,$C1,$C0,$C1
	db $C0,$C1,$C0,$C4,$FE,$B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$FE
	db $C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$FE,$C2,$C3,$C2,$C3,$C2
	db $C3,$C2,$C3,$C2,$C3,$FF

DATA_05AE93:
	db $FE,$B6,$FE,$C6,$FE,$C6,$FF

DATA_05AE9A:
	db $FE,$B4,$B1,$FE,$C0,$C1,$FE,$B2,$B3,$FE,$C2,$C3,$FE,$C2,$C3,$FF

DATA_05AEAA:
	db $FE,$00,$00,$00,$00,$00,$B9,$B8,$B6,$FE,$00,$00,$00,$00,$00,$BE
	db $C3,$C6,$FE,$00,$00,$00,$00,$B4,$B1,$BC,$BD,$B0,$B5,$FE,$00,$00
	db $00,$00,$C0,$C1,$C0,$C1,$C0,$C4,$FE,$B9,$B8,$BB,$B8,$B2,$B3,$B2
	db $B3,$B2,$B3,$FE,$BE,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$FE,$BE
	db $C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$FF

DATA_05AEF4:
	db $FE,$00,$00,$00,$00,$C7,$00,$C7,$FE,$00,$00,$00,$BF,$C4,$BF,$C4
	db $FE,$00,$B9,$B8,$BB,$B3,$BB,$B3,$B6,$FE,$00,$BE,$C3,$C2,$C3,$C2
	db $C3,$C6,$FE,$B4,$B1,$BC,$BD,$BC,$BD,$BC,$BD,$B0,$B5,$FE,$C0,$C1
	db $C0,$C1,$C0,$C1,$C0,$C1,$C0,$C4,$FE,$B2,$B3,$B2,$B3,$B2,$B3,$B2
	db $B3,$B2,$B3,$FE,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$FE,$C2
	db $C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$FF

DATA_05AF4E:
	db $FE,$00,$00,$BA,$B0,$B5,$00,$00,$00,$C7,$FE,$00,$BF,$C1,$C0,$C4
	db $00,$00,$BF,$C4,$FE,$00,$B9,$B3,$B2,$B3,$B6,$00,$B9,$B3,$BB,$B8
	db $B6,$FE,$00,$BE,$C3,$C2,$C3,$C6,$00,$BE,$C3,$C2,$C3,$C6,$FE,$B4
	db $B1,$BC,$BD,$BC,$BD,$B0,$B1,$BC,$BD,$BC,$BD,$B0,$B1,$B0,$B5,$FE
	db $C0,$C1,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C4
	db $FE,$B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$B2
	db $B3,$B6,$FE,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2
	db $C3,$C2,$C3,$C6,$FE,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2
	db $C3,$C2,$C3,$C2,$C3,$C6,$FF

DATA_05AFD5:
	db $FE,$00,$00,$00,$00,$C7,$FE,$00,$00,$00,$BF,$C4,$FE,$00,$B9,$B8
	db $BB,$B3,$B6,$FE,$00,$BE,$C3,$C2,$C3,$C6,$FE,$B4,$B1,$BC,$BD,$BC
	db $BD,$B0,$B5,$FE,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C4,$FE,$B2,$B3,$B2
	db $B3,$B2,$B3,$B2,$B3,$FE,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$FE,$C2
	db $C3,$C2,$C3,$C2,$C3,$C2,$C3,$FF

DATA_05B01D:
	db $FE,$B4,$B1,$B0,$B5,$FE,$C0,$C1,$C0,$C8,$FE,$B2,$B3,$B2,$B3,$B6
	db $FE,$C2,$C3,$C2,$C3,$C6,$FE,$C2,$C3,$C2,$C3,$C6,$FF

DATA_05B03A:
	db $FE,$00,$00,$00,$00,$00,$B4,$B5,$00,$C7,$B4,$B5,$FE,$00,$00,$00
	db $00,$00,$C0,$C8,$BF,$C8,$C0,$C8,$FE,$00,$00,$00,$B9,$B8,$B2,$B3
	db $BB,$B3,$B2,$B3,$B6,$FE,$00,$00,$00,$BE,$C3,$C2,$C3,$C2,$C3,$C2
	db $C3,$C6,$FE,$00,$BA,$B0,$B1,$BC,$BD,$BC,$BD,$BC,$BD,$BC,$BD,$B0
	db $B5,$FE,$BF,$C1,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C4
	db $FE,$B9,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$BB
	db $B8,$B6,$FE,$BE,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2
	db $C3,$C2,$C3,$C6,$FE,$BE,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2
	db $C3,$C2,$C3,$C2,$C3,$C6,$FF

DATA_05B0C1:
	db $FE,$00,$00,$B4,$B1,$B0,$B5,$FE,$00,$00,$C0,$C1,$C0,$C4,$FE,$BB
	db $B8,$B2,$B3,$B2,$B3,$B6,$FE,$C2,$C3,$C2,$C3,$C2,$C3,$C6,$FE,$C2
	db $C3,$C2,$C3,$C2,$C3,$C6,$FF

DATA_05B0E8:
	db $FE,$00,$00,$00,$00,$00,$00,$00,$C7,$FE,$00,$00,$00,$00,$00,$00
	db $BF,$C4,$FE,$00,$00,$B9,$B8,$B6,$00,$B9,$B3,$BB,$B8,$B6,$FE,$00
	db $00,$BE,$C3,$C6,$00,$BE,$C3,$C2,$C3,$C6,$FE,$00,$00,$BA,$BC,$BD
	db $B0,$B1,$BC,$BD,$BC,$BD,$B0,$B5,$FE,$00,$BF,$C1,$C0,$C1,$C0,$C1
	db $C0,$C1,$C0,$C1,$C0,$C4,$FE,$00,$B9,$B3,$B2,$B3,$B2,$B3,$B2,$B3
	db $B2,$B3,$B2,$B3,$B6,$FE,$00,$BE,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2
	db $C3,$C2,$C3,$C6,$FE,$B4,$B1,$BC,$BD,$BC,$BD,$BC,$BD,$BC,$BD,$BC
	db $BD,$BC,$BD,$B0,$B5,$FE,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C1
	db $C0,$C1,$C0,$C1,$C0,$C4,$FE,$B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$B2
	db $B3,$B2,$B3,$B2,$B3,$B2,$B3,$B6,$FE,$C2,$C3,$C2,$C3,$C2,$C3,$C2
	db $C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C6,$FE,$C2,$C3,$C2,$C3,$C2
	db $C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C6,$FF
endif

;--------------------------------------------------------------------

if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
DATA_05B1A5:
	db $03,$04,$05,$FE,$12,$13,$16,$06,$07,$FE,$12,$13,$16,$16,$16,$17
	db $18,$FE,$12,$13,$16,$16,$16,$16,$08,$09,$18,$FE,$12,$13,$16,$16
	db $16,$16,$16,$16,$19,$1A,$18,$FE,$12,$13,$16,$16,$16,$16,$16,$16
	db $16,$16,$0A,$1C,$18,$FE,$12,$13,$16,$16,$16,$16,$16,$16,$16,$16
	db $16,$08,$1B,$1C,$18,$FE,$12,$13,$16,$16,$16,$16,$16,$16,$16,$16
	db $16,$16,$16,$19,$0C,$0B,$18,$FE,$12,$13,$16,$16,$16,$16,$16,$16
	db $16,$16,$16,$16,$16,$16,$16,$0A,$1C,$0B,$18,$FE,$12,$13,$16,$16
	db $16,$16,$16,$16,$16,$16,$16,$16,$16,$16,$16,$16,$08,$1B,$1C,$0B
	db $18,$FE,$12,$13,$16,$16,$16,$16,$16,$16,$16,$16,$16,$16,$16,$16
	db $16,$16,$16,$16,$19,$0C,$1C,$0B,$18,$FE,$12,$13,$16,$16,$16,$16
	db $16,$16,$16,$16,$16,$16,$16,$16,$16,$16,$16,$16,$16,$16,$0A,$1C
	db $1C,$0B,$18,$FF

DATA_05B23F:
	db $FE,$13,$24,$FE,$FE,$13,$23,$16,$16,$16,$FF

DATA_05B24C:
	db $FE,$13,$27,$FE,$13,$2C,$2D,$26,$FE,$13,$20,$2E,$2F,$FE,$13,$16
	db $16,$16,$16,$16,$24,$FE,$13,$16,$16,$16,$16,$16,$16,$16,$16,$0A
	db $32,$FF

DATA_05B26E:
	db $FE,$13,$23,$FE,$13,$20,$FF

DATA_05B275:
	db $FE,$13,$24,$FE,$FE,$13,$27,$16,$16,$26,$FE,$FF

DATA_05B281:
	db $FE,$FE,$13,$24,$FE,$13,$16,$16,$16,$2B,$FE,$FE,$13,$16,$16,$16
	db $25,$16,$16,$16,$26,$FE,$13,$16,$23,$16,$24,$16,$16,$16,$24,$FE
	db $13,$16,$20,$16,$16,$16,$16,$16,$27,$FF

DATA_05B2AB:
	db $FE,$13,$24,$FE,$13,$16,$16,$25,$FE,$13,$26,$FE,$13,$16,$16,$16
	db $24,$16,$27,$FE,$13,$16,$16,$16,$16,$16,$2C,$2D,$16,$0A,$32,$FF

DATA_05B2CB:
	db $FE,$FE,$13,$16,$16,$25,$FE,$13,$16,$16,$27,$FE,$13,$16,$16,$16
	db $16,$2C,$2D,$FE,$13,$24,$23,$16,$16,$16,$2E,$2F,$16,$0A,$32,$FE
	db $13,$16,$16,$16,$16,$16,$16,$16,$16,$16,$08,$1B,$33,$FE,$13,$16
	db $16,$16,$16,$28,$20,$22,$FE,$13,$16,$16,$16,$16,$16,$29,$2A,$16
	db $16,$16,$16,$26,$21,$0A,$30,$FE,$13,$16,$16,$16,$16,$16,$16,$16
	db $16,$16,$16,$16,$16,$16,$20,$FF

else

DATA_05B1A5:
	db $03,$04,$05,$FE,$12,$13,$16,$06,$07,$FE,$12,$13,$16,$16,$16,$17
	db $18,$FE,$12,$13,$16,$16,$16,$16,$08,$09,$18,$FE,$12,$13,$16,$16
	db $16,$16,$16,$16,$19,$1A,$18,$FE,$12,$13,$16,$16,$16,$16,$16,$16
	db $16,$16,$0A,$1C,$18,$FE,$12,$13,$16,$16,$16,$16,$16,$16,$16,$16
	db $16,$08,$1B,$1C,$18,$FE,$12,$13,$16,$16,$16,$16,$16,$16,$16,$16
	db $16,$16,$16,$19,$0C,$0B,$18,$FE,$12,$13,$16,$16,$16,$16,$16,$16
	db $16,$16,$16,$16,$16,$16,$16,$0A,$1C,$0B,$18,$FE,$12,$13,$16,$16
	db $16,$16,$16,$16,$16,$16,$16,$16,$16,$16,$16,$16,$08,$1B,$1C,$0B
	db $18,$FE,$12,$13,$16,$16,$16,$16,$16,$16,$16,$16,$16,$16,$16,$16
	db $16,$16,$16,$16,$19,$1C,$1C,$0B,$18,$FF

DATA_05B23F:
	db $FE,$13,$24,$FE,$FE,$13,$23,$16,$16,$16,$16,$32,$FF

DATA_05B24C:
	db $FE,$13,$27,$FE,$13,$2C,$2D,$26,$FE,$13,$20,$2E,$2F,$FE,$13,$16
	db $16,$16,$16,$16,$24,$FE,$13,$16,$16,$16,$16,$16,$16,$16,$16,$0A
	db $32,$FF

DATA_05B26E:
	db $FE,$13,$23,$FE,$13,$20,$FF

DATA_05B275:
	db $FE,$13,$24,$FE,$FE,$13,$27,$16,$16,$26,$FE,$FF

DATA_05B281:
	db $FE,$FE,$13,$24,$FE,$13,$16,$16,$16,$2B,$FE,$FE,$13,$16,$16,$16
	db $25,$16,$16,$16,$26,$FE,$13,$16,$23,$16,$24,$16,$16,$16,$24,$FE
	db $13,$16,$20,$16,$16,$16,$16,$16,$27,$FF

DATA_05B2AB:
	db $FE,$13,$24,$FE,$13,$16,$16,$25,$FE,$13,$26,$FE,$13,$16,$16,$16
	db $24,$16,$27,$FE,$13,$16,$16,$16,$16,$16,$2C,$2D,$16,$0A,$32,$FF

DATA_05B2CB:
	db $FE,$FE,$13,$16,$16,$25,$FE,$13,$16,$16,$27,$FE,$13,$16,$16,$16
	db $16,$2C,$2D,$FE,$13,$24,$23,$16,$16,$16,$2E,$2F,$16,$0A,$32,$FE
	db $13,$16,$16,$16,$16,$16,$16,$16,$16,$16,$08,$1B,$33,$FE,$13,$16
	db $16,$16,$16,$28,$20,$22,$FE,$13,$16,$16,$16,$16,$16,$29,$2A,$16
	db $16,$16,$16,$26,$21,$0A,$30,$FE,$13,$16,$16,$16,$16,$16,$16,$16
	db $16,$16,$16,$16,$16,$16,$20,$FF
endif

;--------------------------------------------------------------------

DATA_05B323:
	db $1A,$1B,$FE,$01,$02,$FE,$01,$02,$FE,$01,$02,$FE,$01,$02,$FE,$01
	db $02,$FE,$01,$02,$FE,$01,$26,$FE,$2C,$2D,$FE,$30,$31,$32,$FF

DATA_05B342:
	db $04,$05,$06,$07,$FE,$0D,$0E,$0F,$10,$FE,$16,$17,$18,$19,$FE,$1E
	db $1F,$20,$21,$FE,$1E,$17,$18,$21,$FE,$27,$1F,$28,$29,$FF

DATA_05B360:
	db $FE,$11,$14,$FE,$1C,$1D,$FF

DATA_05B367:
	db $FE,$22,$23,$FE,$24,$25,$FE,$2A,$2B,$FE,$2E,$2F,$FE,$33,$34,$FF

DATA_05B377:
	db $FE,$41,$42,$43,$44,$FE,$45,$46,$47,$48,$FE,$49,$4A,$4B,$4C,$FE
	db $4D,$4E,$4F,$50,$FE,$51,$52,$53,$54,$FF

DATA_05B391:
	db $FE,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C
	db $0C,$FE,$12,$13,$12,$13,$12,$13,$12,$13,$12,$13,$12,$13,$12,$13
	db $12,$13,$FE,$36,$37,$38,$36,$39,$3A,$3B,$3B,$36,$3A,$3B,$3B,$3B
	db $36,$3A,$38,$FE,$3C,$3D,$3E,$3C,$3F,$3D,$3E,$3E,$3C,$3D,$3E,$3E
	db $3E,$3C,$3D,$3E,$FF

DATA_05B3D6:
	db $22,$23,$FE,$24,$25,$FE,$2A,$2B,$FE,$33,$34,$FF

;--------------------------------------------------------------------

DATA_05B3E2:
	db $08,$FE,$0C,$FF

DATA_05B3E6:
	db $14,$15,$16,$17,$FE,$1D,$1E,$1F,$20,$FE,$1D,$1E,$1F,$20,$FE,$1D
	db $2A,$2B,$20,$FF

DATA_05B3FA:
	db $18,$19,$1A,$1B,$FE,$21,$22,$23,$24,$FE,$21,$22,$23,$24,$FE,$21
	db $22,$23,$24,$FF

DATA_05B40E:
	db $00,$00,$00,$00,$01,$02,$FE,$00,$00,$01,$03,$05,$06,$04,$02,$FE
	db $01,$03,$05,$09,$09,$09,$09,$06,$04,$02,$FE,$05,$09,$09,$09,$09
	db $09,$09,$09,$09,$06,$FF

DATA_05B434:
	db $01,$03,$04,$03,$04,$02,$FE,$07,$08,$09,$09,$08,$0A,$FE,$0B,$0C
	db $09,$09,$0C,$0D,$0E,$FE,$11,$09,$09,$09,$09,$12,$13,$FE,$11,$18
	db $19,$1A,$1B,$12,$13,$FE,$11,$21,$22,$23,$24,$12,$13,$FE,$11,$21
	db $22,$23,$24,$12,$13,$FE,$11,$21,$22,$23,$24,$12,$13,$FF

DATA_05B472:
	db $02,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$01
	db $FE,$35,$04,$03,$04,$03,$04,$03,$04,$03,$04,$03,$04,$03,$04,$03
	db $36,$FF

;--------------------------------------------------------------------

DATA_05B494:
	db $00,$00,$00,$00,$00,$00,$00,$07,$01,$02,$03,$04,$01,$02,$03,$04
	db $00,$00,$00,$00,$00,$00,$10,$11,$0A,$0B,$0C,$0D,$0A,$0B,$0C,$0D
	db $00,$00,$17,$18,$00,$00,$19,$15,$16,$12,$14,$15,$16,$12,$14,$15
	db $23,$24,$25,$22,$23,$24,$25,$1F,$20,$21,$1E,$1F,$20,$21,$1E,$1F
	db $FF

DATA_05B4D5:
	db $08,$09,$03,$04,$05,$06,$00,$00,$00,$00,$00,$07,$08,$09,$03,$04
	db $0A,$0B,$0C,$0D,$0E,$0F,$00,$00,$00,$00,$10,$11,$0A,$0B,$0C,$0D
	db $16,$12,$14,$15,$16,$12,$17,$18,$00,$00,$19,$15,$16,$12,$14,$15
	db $20,$21,$1E,$1F,$20,$21,$1E,$22,$23,$24,$25,$1F,$20,$21,$1E,$26
	db $FF

DATA_05B516:
	db $01,$02,$03,$04,$08,$09,$03,$04,$05,$06,$00,$07,$08,$09,$03,$29
	db $0A,$0B,$0C,$0D,$0A,$0B,$0C,$0D,$0E,$0F,$10,$11,$0A,$0B,$0C,$0D
	db $0A,$12,$13,$0D,$0A,$12,$14,$15,$16,$12,$14,$15,$16,$12,$14,$15
	db $1A,$1B,$1C,$1D,$1A,$1B,$1E,$1F,$20,$21,$1E,$1F,$20,$21,$1E,$1F
	db $FF

;--------------------------------------------------------------------

DATA_05B557:
	dw $E091,$E070,$E048,$E020,$6900,$8163,$8970,$9180,$9510,$9920,$9D30,$A193,$B1A0,$B572,$E000,$81B0
	dw $85D0,$8962,$9580,$A1C0,$A593,$B5A0,$B961,$6830,$7010,$9830,$E3F0

DATA_05B58D:
	dw $E091,$E070,$E048,$E020,$6900,$8163,$8970,$9180,$9510,$9920,$9D30,$A193,$B1A0,$B572,$E000,$81B0
	dw $85D0,$8962,$9580,$A1C0,$A593,$B5A0,$B961,$6830,$7010,$9830,$E000,$6910,$6D21,$7530,$79B0,$7DD0
	dw $81B0,$85D0,$8973,$99C0,$9D90,$A1C0,$A596,$5C30,$E000,$6160,$6580,$6910,$6D22,$7930,$8190,$85A0
	dw $8974,$9D60,$A197,$4010,$E000,$8160,$8580,$9940,$9D50,$A190,$A5A0,$A980,$B5B0,$B9F0,$BD70,$6010
	dw $AC10,$E000,$8207,$A177,$E000,$8207,$A177,$E3F0

DATA_05B61D:
	dw $E091,$E04F,$E020,$8000,$E000,$8001,$E000,$8002,$E3F0

DATA_05B62F:
	dw $E04B,$E011,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016,$4C16,$5417,$5C18,$6019,$641A,$681B,$6C1C
	dw $7816,$801D,$901E,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29
	dw $742A,$782B,$882C,$902D,$982F,$E000,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016,$4C16,$5417,$5C18
	dw $6019,$641A,$681B,$6C1C,$7816,$801D,$901E,$E000,$0030,$1831,$2020,$2432,$2C1B,$3023,$3833,$4034
	dw $4835,$5436,$5837,$5C38,$6439,$683A,$6C3B,$703C,$743D,$783E,$943F,$E000,$181F,$2020,$2421,$2C22
	dw $3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$E000,$181F,$2020
	dw $2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$E3F0

DATA_05B70F:
	dw $E091,$E010,$E04C,$E080,$A010,$A420,$B010,$B420,$BC10,$A850,$E000,$A020,$A810,$AC20,$B810,$BC20
	dw $B050,$4870,$E000,$A020,$A810,$AC20,$B410,$B820,$7C80,$E000,$AC10,$B020,$B810,$BC20,$E000,$A410
	dw $A820,$B010,$B420,$BC50,$9090,$E000,$A810,$AC20,$B410,$B820,$E000,$A010,$A420,$B010,$B420,$BC10
	dw $A860,$E000,$A020,$AC10,$B020,$B810,$BC20,$A460,$E3F0

DATA_05B781:
	dw $E091,$E042,$E010,$B050,$B080,$E000,$6C70,$6C90,$A0F3,$E000,$7460,$74B0,$AC40,$ACA0,$E000,$8060
	dw $80B0,$A4F9,$E000,$E000,$9060,$4060,$40C0,$B4F2,$E000,$3870,$38E0,$A4F4,$E3F0

DATA_05B7BB:
	dw $E011,$E04B,$E031,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016,$4C16,$5417,$5C18,$6019,$641A,$681B
	dw $6C1C,$7816,$801D,$901E,$8107,$8510,$9911,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025
	dw $5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$8107,$8510,$9910,$E000,$0010,$0C11,$1012
	dw $1C13,$2414,$2815,$3016,$4C16,$5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D,$901E,$8107,$8510
	dw $9911,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B
	dw $882C,$902D,$982F,$8107,$8510,$9910,$E000,$0030,$1831,$2020,$2432,$2C1B,$3023,$3833,$4034,$4835
	dw $5436,$5837,$5C38,$6439,$683A,$6C3B,$703C,$743D,$783E,$943F,$8107,$8911,$9910,$E000,$181F,$2020
	dw $2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$8107
	dw $8510,$9910,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016,$4C16,$5417,$5C18,$6019,$641A,$681B,$6C1C
	dw $7816,$801D,$901E,$8107,$8510,$9911,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826
	dw $5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$8107,$8510,$9910,$0010,$0C11,$1012,$1C13,$2414
	dw $2815,$3016,$4C16,$5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D,$901E,$8107,$8510,$9911,$E000
	dw $181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D
	dw $982F,$8107,$8510,$9910,$E3F0

DATA_05B965:
	dw $E011,$E047,$E031,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016,$4C16,$5417,$5C18,$6019,$641A,$681B
	dw $6C1C,$7816,$801D,$901E,$8107,$8510,$9911,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025
	dw $5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$8107,$8510,$9910,$E000,$0010,$0C11,$1012
	dw $1C13,$2414,$2815,$3016,$4C16,$5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D,$901E,$8107,$8510
	dw $9911,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B
	dw $882C,$902D,$982F,$8107,$8510,$9910,$E000,$0030,$1831,$2020,$2432,$2C1B,$3023,$3833,$4034,$4835
	dw $5436,$5837,$5C38,$6439,$683A,$6C3B,$703C,$743D,$783E,$943F,$8107,$8911,$9910,$E000,$181F,$2020
	dw $2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$8107
	dw $8510,$9910,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016,$4C16,$5417,$5C18,$6019,$641A,$681B,$6C1C
	dw $7816,$801D,$901E,$8107,$8510,$9911,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826
	dw $5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$8107,$8510,$9910,$0010,$0C11,$1012,$1C13,$2414
	dw $2815,$3016,$4C16,$5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D,$901E,$8107,$8510,$9911,$E000
	dw $181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D
	dw $982F,$8107,$8510,$9910,$E3F0

DATA_05BB0F:
	dw $E091,$E042,$E010,$A850,$A880,$E000,$8C60,$8CB0,$E000,$A850,$A880,$E000,$7070,$7090,$A850,$A8B0
	dw $9C70,$E000,$E000,$A840,$A8A0,$E000,$2470,$24E0,$E3F0

DATA_05BB41:
	dw $E091,$E04E,$E010,$E0A0,$A803,$BC00,$E000,$A802,$E000,$A400,$AC01,$E000,$A803,$E000,$A401,$AC01
	dw $BC08,$E000,$E3F0

DATA_05BB67:
	dw $E091,$E010,$E0B0,$E0C0,$9010,$E000,$8800,$B010,$A425,$E000,$6810,$B420,$BC2F,$E000,$8810,$B800
	dw $E000,$A800,$9810,$A420,$E000,$6800,$A420,$B420,$BC2F,$E000,$6810,$BC20,$E000,$E3F0

DATA_05BBA3:
	dw $E091,$E010,$E045,$A410,$6800,$5C20,$E000,$6C00,$E000,$4030,$5C40,$E000,$5020,$9060,$E000,$A050
	dw $8420,$7870,$E000,$4C80,$E000,$4090,$E3F0

DATA_05BBD1:
	dw $E091,$E042,$E010,$2470,$24E0,$E3F0

DATA_05BBDD:
	dw $E091,$E045,$E010,$8820,$B810,$7C00,$E000,$5890,$48A0,$E000,$98B0,$E000,$A410,$6800,$5CC0,$E000
	dw $E000,$A010,$6400,$90D0,$E000,$8820,$B810,$7C00,$E3F0

DATA_05BC0F:
	dw $E010,$E041,$2800,$E000,$E000,$2800,$E3F0

DATA_05BC1D:
	dw $E091,$E042,$E013,$E04D,$A880,$AC24,$ACB2,$D043,$9090,$9436,$D890,$DC32,$BC92,$E000,$A064,$ACA0
	dw $D003,$94A1,$B815,$E000,$C093,$C472,$B081,$B434,$9082,$9076,$E000,$C084,$C032,$8890,$ACA3,$D043
	dw $8C36,$E000,$80A0,$A405,$ACB2,$D043,$98A3,$BC45,$7490,$7838,$E000,$C480,$C822,$B0A0,$D403,$9482
	dw $9476,$E3F0

DATA_05BC81:
	dw $E04B,$E011,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016,$4C16,$5417,$5C18,$6019,$641A,$681B,$6C1C
	dw $7816,$801D,$901E,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29
	dw $742A,$782B,$882C,$902D,$982F,$E000,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016,$4C16,$5417,$5C18
	dw $6019,$641A,$681B,$6C1C,$7816,$801D,$901E,$E000,$0030,$1831,$2020,$2432,$2C1B,$3023,$3833,$4034
	dw $4835,$5436,$5837,$5C38,$6439,$683A,$6C3B,$703C,$743D,$783E,$943F,$E000,$181F,$2020,$2421,$2C22
	dw $3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$E000,$181F,$2020
	dw $2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$E3F0

DATA_05BD61:
	dw $E011,$E04B,$E031,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016,$4C16,$5417,$5C18,$6019,$641A,$681B
	dw $6C1C,$7816,$801D,$901E,$8107,$8510,$9911,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025
	dw $5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$8107,$8510,$9910,$E000,$0010,$0C11,$1012
	dw $1C13,$2414,$2815,$3016,$4C16,$5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D,$901E,$8107,$8510
	dw $9911,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B
	dw $882C,$902D,$982F,$8107,$8510,$9910,$E000,$0030,$1831,$2020,$2432,$2C1B,$3023,$3833,$4034,$4835
	dw $5436,$5837,$5C38,$6439,$683A,$6C3B,$703C,$743D,$783E,$943F,$8107,$8911,$9910,$E000,$181F,$2020
	dw $2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$8107
	dw $8510,$9910,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016,$4C16,$5417,$5C18,$6019,$641A,$681B,$6C1C
	dw $7816,$801D,$901E,$8107,$8510,$9911,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826
	dw $5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$8107,$8510,$9910,$0010,$0C11,$1012,$1C13,$2414
	dw $2815,$3016,$4C16,$5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D,$901E,$8107,$8510,$9911,$E000
	dw $181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D
	dw $982F,$8107,$8510,$9910,$E3F0

DATA_05BF0B:
	dw $E091,$E013,$E042,$E04D,$C080,$C422,$B0A0,$D403,$9482,$9476,$E000,$80A0,$A405,$E3F0

DATA_05BF27:
	dw $E091,$E042,$E010,$6C70,$6C90,$E000,$8C60,$8CB0,$E000,$7470,$7490,$AC50,$AC80,$E000,$8070,$80E0
	dw $E000,$6070,$60E0,$E000,$8840,$88D0,$A060,$A0B0,$E000,$5470,$74A0,$E000,$6070,$60E0,$E000,$8870
	dw $8890,$E000,$5070,$5090,$E000,$E000,$2870,$28E0,$E3F0

DATA_05BF79:
	dw $E091,$E045,$E010,$8820,$B810,$7C00,$E000,$5890,$48A0,$E000,$98B0,$E000,$A410,$6800,$5CC0,$E000
	dw $E000,$A010,$6400,$90D0,$E000,$8820,$B810,$7C00,$E3F0

DATA_05BFAB:
	dw $E091,$E010,$E045,$8420,$7470,$E000,$4880,$5C90,$E000,$E000,$40C0,$E000,$4090,$E000,$4830,$E000
	dw $04E0,$E3F0

DATA_05BFCF:
	dw $E091,$E045,$E010,$8820,$B810,$7C00,$E000,$5890,$48A0,$E000,$98B0,$E000,$A410,$6800,$5CC0,$E000
	dw $E000,$A010,$6400,$90D0,$E000,$8820,$B810,$7C00,$E3F0

DATA_05C001:
	dw $E011,$E041,$2800,$E000,$2C00,$E3F0

DATA_05C00D:
	dw $E011,$E047,$E031,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016,$4C16,$5417,$5C18,$6019,$641A,$681B
	dw $6C1C,$7816,$801D,$901E,$8107,$8510,$9911,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025
	dw $5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$8107,$8510,$9910,$E000,$0010,$0C11,$1012
	dw $1C13,$2414,$2815,$3016,$4C16,$5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D,$901E,$8107,$8510
	dw $9911,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B
	dw $882C,$902D,$982F,$8107,$8510,$9910,$E000,$0030,$1831,$2020,$2432,$2C1B,$3023,$3833,$4034,$4835
	dw $5436,$5837,$5C38,$6439,$683A,$6C3B,$703C,$743D,$783E,$943F,$8107,$8911,$9910,$E000,$181F,$2020
	dw $2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$8107
	dw $8510,$9910,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016,$4C16,$5417,$5C18,$6019,$641A,$681B,$6C1C
	dw $7816,$801D,$901E,$8107,$8510,$9911,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826
	dw $5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$8107,$8510,$9910,$0010,$0C11,$1012,$1C13,$2414
	dw $2815,$3016,$4C16,$5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D,$901E,$8107,$8510,$9911,$E000
	dw $181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D
	dw $982F,$8107,$8510,$9910,$E3F0

if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
DATA_05C1B7:
	dw $E012,$E060,$E050,$E043,$4510,$6D10,$6100,$1530,$5520,$2900,$A960,$C970,$AD82,$CD92,$B9A0,$D9B0
	dw $2D40,$4D50,$2007,$0026,$1C16,$E000,$4510,$6D10,$1530,$5520,$2900,$2D40,$4D50,$2007,$0026,$1C16
	dw $E000,$4510,$6D10,$6100,$1530,$5520,$2900,$A960,$C970,$AD82,$CD92,$B9A0,$D9B0,$2D40,$4D50,$2007
	dw $0026,$1C16,$E000,$4510,$6D10,$1530,$5520,$2900,$2D40,$4D50,$2007,$0026,$1C16,$E000,$4510,$6D10
	dw $6100,$1530,$5520,$2900,$A960,$C970,$AD82,$CD92,$B9A0,$D9B0,$2D40,$4D50,$2007,$0026,$1C16,$E000
	dw $4510,$6D10,$1530,$5520,$2900,$2D40,$4D50,$2007,$0026,$1C16,$E000,$4510,$6D10,$6100,$1530,$5520
	dw $2900,$A960,$C970,$AD82,$CD92,$B9A0,$D9B0,$2D40,$4D50,$2007,$0026,$1C16,$E000,$4510,$6D10,$1530
	dw $5520,$2900,$2D40,$4D50,$2007,$0026,$1C16,$E3F0

DATA_05C2A7:
	dw $E012,$E060,$E050,$E043,$4510,$6D10,$6100,$1530,$5520,$2900,$A960,$C970,$AD82,$CD92,$B9A0,$D9B0
	dw $2D40,$4D50,$2007,$0026,$1C16,$E000,$4510,$6D10,$1530,$5520,$2900,$2D40,$4D50,$2007,$0026,$1C16
	dw $E000,$4510,$6D10,$6100,$1530,$5520,$2900,$A960,$C970,$AD82,$CD92,$B9A0,$D9B0,$2D40,$4D50,$2007
	dw $0026,$1C16,$E000,$4510,$6D10,$1530,$5520,$2900,$2D40,$4D50,$2007,$0026,$1C16,$E000,$4510,$6D10
	dw $6100,$1530,$5520,$2900,$A960,$C970,$AD82,$CD92,$B9A0,$D9B0,$2D40,$4D50,$2007,$0026,$1C16,$E000
	dw $4510,$6D10,$1530,$5520,$2900,$2D40,$4D50,$2007,$0026,$1C16,$E000,$4510,$6D10,$6100,$1530,$5520
	dw $2900,$A960,$C970,$AD82,$CD92,$B9A0,$D9B0,$2D40,$4D50,$2007,$0026,$1C16,$E000,$4510,$6D10,$1530
	dw $5520,$2900,$2D40,$4D50,$2007,$0026,$1C16,$E3F0

else
DATA_05C1B7:
	dw $E012,$E060,$E050,$E043,$4510,$6D10,$6100,$1530,$5520,$2900,$A960,$C970,$AD82,$CD92,$B9A0,$D9B0
	dw $2D40,$4D50,$2007,$0025,$1C15,$E000,$4510,$6D10,$1530,$5520,$2900,$2D40,$4D50,$2007,$0025,$1C15
	dw $E000,$4510,$6D10,$6100,$1530,$5520,$2900,$A960,$C970,$AD82,$CD92,$B9A0,$D9B0,$2D40,$4D50,$2007
	dw $0025,$1C15,$E000,$4510,$6D10,$1530,$5520,$2900,$2D40,$4D50,$2007,$0025,$1C15,$E000,$4510,$6D10
	dw $6100,$1530,$5520,$2900,$A960,$C970,$AD82,$CD92,$B9A0,$D9B0,$2D40,$4D50,$2007,$0025,$1C15,$E000
	dw $4510,$6D10,$1530,$5520,$2900,$2D40,$4D50,$2007,$0025,$1C15,$E000,$4510,$6D10,$6100,$1530,$5520
	dw $2900,$A960,$C970,$AD82,$CD92,$B9A0,$D9B0,$2D40,$4D50,$2007,$0025,$1C15,$E000,$4510,$6D10,$1530
	dw $5520,$2900,$2D40,$4D50,$2007,$0025,$1C15,$E3F0

DATA_05C2A7:
	dw $E012,$E060,$E050,$E043,$4510,$6D10,$6100,$1530,$5520,$2900,$A960,$C970,$AD82,$CD92,$B9A0,$D9B0
	dw $2D40,$4D50,$2007,$0025,$1C15,$E000,$4510,$6D10,$1530,$5520,$2900,$2D40,$4D50,$2007,$0025,$1C15
	dw $E000,$4510,$6D10,$6100,$1530,$5520,$2900,$A960,$C970,$AD82,$CD92,$B9A0,$D9B0,$2D40,$4D50,$2007
	dw $0025,$1C15,$E000,$4510,$6D10,$1530,$5520,$2900,$2D40,$4D50,$2007,$0025,$1C15,$E000,$4510,$6D10
	dw $6100,$1530,$5520,$2900,$A960,$C970,$AD82,$CD92,$B9A0,$D9B0,$2D40,$4D50,$2007,$0025,$1C15,$E000
	dw $4510,$6D10,$1530,$5520,$2900,$2D40,$4D50,$2007,$0025,$1C15,$E000,$4510,$6D10,$6100,$1530,$5520
	dw $2900,$A960,$C970,$AD82,$CD92,$B9A0,$D9B0,$2D40,$4D50,$2007,$0025,$1C15,$E000,$4510,$6D10,$1530
	dw $5520,$2900,$2D40,$4D50,$2007,$0025,$1C15,$E3F0
endif

DATA_05C397:
	dw $E041,$E012,$2800,$E000,$2800,$E000,$2800,$E000,$2800,$E000,$2800,$E3F0

DATA_05C3AF:
	dw $E046,$E050,$0003,$1003,$4019,$5019,$403F,$0826,$1826,$E000,$0C03,$4C19,$1C03,$5C19,$403F,$0426
	dw $1426,$E000,$0803,$4819,$403A,$0026,$5449,$9C45,$3060,$E000,$0C07,$8C13,$1807,$9813,$803F,$0426
	dw $3050,$6060,$E000,$2850,$0007,$8013,$1007,$9013,$803F,$5480,$E000,$0007,$8013,$1407,$9413,$803F
	dw $4480,$E3F0

DATA_05C413:
	dw $E046,$E050,$0007,$1007,$6017,$7017,$603F,$0826,$B890,$E000,$0005,$1005,$6017,$7017,$603F,$0826
	dw $B4A0,$E000,$0005,$6017,$6039,$7047,$4860,$A890,$3850,$E000,$1005,$7017,$683B,$6447,$5860,$E000
	dw $0005,$6017,$1005,$7017,$603F,$0826,$5860,$B890,$E000,$0005,$6017,$1005,$7017,$603F,$0826,$5480
	dw $E000,$603F,$4480,$5080,$E3F0

DATA_05C47D:
	dw $E046,$E050,$0003,$1003,$4019,$5019,$403F,$0826,$1826,$E000,$0C03,$4C19,$1C03,$5C19,$403F,$0426
	dw $1426,$E000,$0803,$4819,$403A,$0026,$5449,$9C45,$3060,$E000,$0C07,$8C13,$1807,$9813,$803F,$0426
	dw $3050,$6060,$E000,$2850,$0007,$8013,$1007,$9013,$803F,$5480,$E000,$0007,$8013,$1407,$9413,$803F
	dw $4480,$E3F0

DATA_05C4E1:
	dw $E046,$E050,$0003,$1003,$4019,$5019,$403F,$0826,$1826,$E000,$0C03,$4C19,$1C03,$5C19,$403F,$0426
	dw $1426,$E000,$0803,$4819,$403A,$0026,$5449,$9C45,$3060,$E000,$0C07,$8C13,$1807,$9813,$803F,$0426
	dw $3050,$6060,$E000,$2850,$0007,$8013,$1007,$9013,$803F,$5480,$E000,$0007,$8013,$1407,$9413,$803F
	dw $4480,$E3F0

DATA_05C545:
	dw $E050,$E046,$0005,$1405,$6017,$7417,$603F,$0826,$5C60,$E000,$0807,$1C07,$6817,$7C17,$603F,$1026
	dw $E000,$1007,$7017,$603F,$7C47,$0426,$E000,$0426,$7435,$7047,$5860,$B890,$E000,$0C07,$1C07,$6C17
	dw $7C17,$603F,$0426,$5080,$B490,$E000,$603F,$7C47,$0426,$4C80,$E000,$7435,$7047,$2450,$5480,$E000
	dw $7017,$8017,$603F,$4090,$5090,$4480,$5480,$A0B0,$E3F0
	  
DATA_05C5B7:
	dw $E012,$E050,$E044,$A0A0,$2010,$2800,$4C30,$5830,$E000,$A0A0,$4430,$3010,$3800,$5C30,$E000,$A0A0
	dw $4830,$5430,$E000,$A0A0,$2010,$2800,$5020,$5850,$E000,$A0A0,$4820,$5050,$5820,$E000,$A0A0,$4450
	dw $2C00,$94D0,$E000,$A0A0,$2000,$4840,$5440,$3C00,$E000,$A0A0,$2010,$4830,$7470,$5C20,$E000,$A0A0
	dw $2410,$8CC0,$3010,$5820,$E000,$A0A0,$4050,$5050,$4880,$5820,$E000,$A0A0,$2400,$4C20,$5820,$E3F0

if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	%FREE_BYTES(NULLROM, 275, $FF)
else
	%FREE_BYTES(NULLROM, 457, $FF)
endif

;--------------------------------------------------------------------

SMB1_PollJoypadInputs:
.Main:
;$05C800
	LDA.w !REGISTER_HVBlankFlagsAndJoypadStatus
	LSR
	BCS.b .Main
	STZ.w !REGISTER_JoypadSerialPort1
	LDA.l !SRAM_SMAS_Global_Controller1PluggedInFlag
	TAX
	LDA.w !REGISTER_Joypad1Lo,x
	STA.w !RAM_SMB1_Global_ControllerHold2P1
	TAY
	EOR.w !RAM_SMB1_Global_P1CtrlDisableHi
	AND.w !RAM_SMB1_Global_ControllerHold2P1
	STA.w !RAM_SMB1_Global_ControllerPress2P1
	STY.w !RAM_SMB1_Global_P1CtrlDisableHi
	LDA.w !REGISTER_Joypad1Hi,x
	STA.w !RAM_SMB1_Global_ControllerHold1P1
	TAY
	EOR.w !RAM_SMB1_Global_P1CtrlDisableLo
	AND.w !RAM_SMB1_Global_ControllerHold1P1
	STA.w !RAM_SMB1_Global_ControllerPress1P1
	STY.w !RAM_SMB1_Global_P1CtrlDisableLo
	LDA.l !SRAM_SMAS_Global_Controller2PluggedInFlag
	TAX
	LDA.w !REGISTER_Joypad1Lo,x
	STA.w !RAM_SMB1_Global_ControllerHold2P2
	TAY
	EOR.w !RAM_SMB1_Global_P2CtrlDisableHi
	AND.w !RAM_SMB1_Global_ControllerHold2P2
	STA.w !RAM_SMB1_Global_ControllerPress2P2
	STY.w !RAM_SMB1_Global_P2CtrlDisableHi
	LDA.w !REGISTER_Joypad1Hi,x
	STA.w !RAM_SMB1_Global_ControllerHold1P2
	TAY
	EOR.w !RAM_SMB1_Global_P2CtrlDisableLo
	AND.w !RAM_SMB1_Global_ControllerHold1P2
	STA.w !RAM_SMB1_Global_ControllerPress1P2
	STY.w !RAM_SMB1_Global_P2CtrlDisableLo
	RTL

;--------------------------------------------------------------------

CODE_05C860:
	PHB
	PHK
	PLB
	LDA.l !SRAM_SMAS_Global_ControllerTypeX
	BNE.b CODE_05C88B
	LDA.w !RAM_SMB1_Global_ControllerHold2P1
	AND.b #$C0
	TSB.w !RAM_SMB1_Global_ControllerHold1P1
	LDA.w !RAM_SMB1_Global_ControllerPress2P1
	AND.b #$C0
	TSB.w !RAM_SMB1_Global_ControllerPress1P1
	LDA.w !RAM_SMB1_Global_ControllerHold2P2
	AND.b #$C0
	TSB.w !RAM_SMB1_Global_ControllerHold1P2
	LDA.w !RAM_SMB1_Global_ControllerPress2P2
	AND.b #$C0
	TSB.w !RAM_SMB1_Global_ControllerPress1P2
	BRA.b CODE_05C8F3

CODE_05C88B:
	LDA.w !RAM_SMB1_Global_ControllerHold1P1
	AND.b #$80
	LSR
	TSB.w !RAM_SMB1_Global_ControllerHold1P1
	LDA.w !RAM_SMB1_Global_ControllerHold2P1
	AND.b #$C0
	STA.b $00
	LDA.w !RAM_SMB1_Global_ControllerHold1P1
	AND.b #$7F
	ORA.b $00
	STA.w !RAM_SMB1_Global_ControllerHold1P1
	LDA.w !RAM_SMB1_Global_ControllerPress1P1
	AND.b #$80
	LSR
	TSB.w !RAM_SMB1_Global_ControllerPress1P1
	LDA.w !RAM_SMB1_Global_ControllerPress2P1
	AND.b #$C0
	STA.b $00
	LDA.w !RAM_SMB1_Global_ControllerPress1P1
	AND.b #$7F
	ORA.b $00
	STA.w !RAM_SMB1_Global_ControllerPress1P1
	LDA.w !RAM_SMB1_Global_ControllerHold1P2
	AND.b #$80
	LSR
	TSB.w !RAM_SMB1_Global_ControllerHold1P2
	LDA.w !RAM_SMB1_Global_ControllerHold2P2
	AND.b #$C0
	STA.b $00
	LDA.w !RAM_SMB1_Global_ControllerHold1P2
	AND.b #$7F
	ORA.b $00
	STA.w !RAM_SMB1_Global_ControllerHold1P2
	LDA.w !RAM_SMB1_Global_ControllerPress1P2
	AND.b #$80
	LSR
	TSB.w !RAM_SMB1_Global_ControllerPress1P2
	LDA.w !RAM_SMB1_Global_ControllerPress2P2
	AND.b #$C0
	STA.b $00
	LDA.w !RAM_SMB1_Global_ControllerPress1P2
	AND.b #$7F
	ORA.b $00
	STA.w !RAM_SMB1_Global_ControllerPress1P2
CODE_05C8F3:
	PLB
	RTL

;--------------------------------------------------------------------

DATA_05C8F5:
	db !Define_SMB1_LevelMusic_Underwater
	db !Define_SMB1_LevelMusic_Overworld
	db !Define_SMB1_LevelMusic_Underground
	db !Define_SMB1_LevelMusic_Castle
	db !Define_SMB1_LevelMusic_BonusRoom
	db !Define_SMB1_LevelMusic_EnterPipeCutscene

SMB1_SetLevelMusic:
.Main:
	PHB
	PHK
	PLB
	PHX
	LDA.w !RAM_SMB1_Global_GameMode
	BEQ.b CODE_05C94D
	LDA.w !RAM_SMB1_Level_Player_TriggeredScreenExitFlag
	CMP.b #$02
	BEQ.b CODE_05C91C
	LDY.b #$05
	LDA.w !RAM_SMB1_Player_LevelEntrancePositionIndex
	CMP.b #$06
	BEQ.b CODE_05C918
	CMP.b #$07
	BNE.b CODE_05C91C
CODE_05C918:
	LDY.b #$05
	BRA.b CODE_05C925

CODE_05C91C:
	LDY.b $BA
	LDA.w $0743
	BEQ.b CODE_05C925
	LDY.b #$04
CODE_05C925:
	LDA.b !RAM_SMB1_Player_CurrentState
	CMP.b #$04
	BEQ.b CODE_05C944
	CMP.b #$05
	BEQ.b CODE_05C944
	LDA.b $DB
	CMP.b #$1B
	BNE.b CODE_05C939
	LDA.b #!Define_SMB1_LevelMusic_BonusRoom
	BRA.b CODE_05C93C

CODE_05C939:
	LDA.w DATA_05C8F5,y
CODE_05C93C:
	LDX.w $0EDF
	BNE.b CODE_05C944
	STA.w !RAM_SMB1_Global_MusicCh1
CODE_05C944:
	LDX.b $DB
	CPX.b #$21
	BNE.b CODE_05C94D
	STA.w $0EDF
CODE_05C94D:
	PLX
	PLB
	RTL

;--------------------------------------------------------------------

CODE_05C950:
	LDA.l !RAM_SMB1_Global_SaveBuffer_2PlayerFlag
	BPL.b CODE_05C958
	LDA.b #$00
CODE_05C958:
	STA.w !RAM_SMB1_Level_TwoPlayerGameFlag
CODE_05C95B:
	LDA.l !RAM_SMB1_Global_SaveBuffer_CurrentWorld
	STA.w !RAM_SMB1_Player_CurrentWorld
	STA.w !RAM_SMB1_Player_OtherPlayersWorld
	LDA.l !RAM_SMB1_Global_SaveBuffer_CurrentLevel
	STA.w !RAM_SMB1_Player_CurrentLevelNumberDisplay
	STA.w !RAM_SMB1_Player_OtherPlayersLevelNumberDisplay
	LDA.l $7FFB02
	BPL.b CODE_05C976
	INC
CODE_05C976:
	STA.w !RAM_SMB1_Player_CurrentLevel
	STA.w !RAM_SMB1_Player_OtherPlayersLevel
	LDA.l !RAM_SMB1_Global_SaveBuffer_CurrentLifeCount
	STA.w !RAM_SMB1_Player_CurrentLifeCount
	LDA.l !RAM_SMB1_Global_SaveBuffer_OtherPlayersLifeCount
	STA.w !RAM_SMB1_Player_OtherPlayersLifeCount
	LDA.l !RAM_SMB1_Global_SaveBuffer_HardModeActiveFlag
	STA.w !RAM_SMB1_Player_HardModeActiveFlag
	STA.w $0781
CODE_05C994:
	PHX
	LDX.b #$00
CODE_05C997:
	LDA.l !SRAM_SMB1_Global_TopScoreMillionsDigit,x
	STA.w !RAM_SMB1_TitleScreen_TopScoreMillionsDigit,x
	INX
	CPX.b #$06
	BNE.b CODE_05C997
	PLX
	RTL

;--------------------------------------------------------------------

CODE_05C9A5:
	LDA.l !SRAM_SMAS_Global_InitialSelectedLevel
	STA.w !RAM_SMB1_Player_CurrentLevel
	STA.w !RAM_SMB1_Player_OtherPlayersLevel
	LDA.w $0E24
	STA.w !RAM_SMB1_Player_CurrentLevelNumberDisplay
	STA.w !RAM_SMB1_Player_OtherPlayersLevelNumberDisplay
	LDA.b #$02
	STA.w !RAM_SMB1_Player_CurrentLifeCount
	STA.w !RAM_SMB1_Player_OtherPlayersLifeCount
	STZ.w !RAM_SMB1_Player_CurrentCoinCount
	STZ.w !RAM_SMB1_Player_OtherPlayersCoinCount
	PHX
	LDX.b #$00
CODE_05C9C9:
	STZ.w !RAM_SMB1_Player_MariosScoreMillionsDigit,x
	INX
	CPX.b #$0C
	BNE.b CODE_05C9C9
	PLX
	RTL

;--------------------------------------------------------------------

SMB1_DrawCrumblingBridgeSegment:
.Main:
;$05C9D3
	PHX
	PHY
	LDA.w !RAM_SMB1_NorSpr02D_Bowser_NumberOfBrokenBridgeSegments
	BEQ.b CODE_05CA13
	LDY.w !RAM_SMB1_Level_SpriteOAMIndexTable+$01,x
	LDX.b #$00
CODE_05C9DF:
	LDA.w SMB1_OAMBuffer[$40].XDisp,y
	STA.w SMB1_OAMBuffer[$00].XDisp,x
	TYA
	AND.b #$03
	CMP.b #$01
	BNE.b CODE_05C9FD
	LDA.w SMB1_OAMBuffer[$00].XDisp,x
	CMP.b #$F0
	BCC.b CODE_05C9FD
	LDA.b #$F0
	STA.w SMB1_OAMBuffer[$00].XDisp,x
	LDA.b #$00
	STA.w SMB1_OAMTileSizeBuffer[$40].Slot,y
CODE_05C9FD:
	LDA.w SMB1_OAMTileSizeBuffer[$40].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot,x
	LDA.b #$00
	STA.w SMB1_OAMTileSizeBuffer[$40].Slot,y
	LDA.b #$F0
	STA.w SMB1_OAMBuffer[$40].XDisp,y
	INY
	INX
	CPX.b #$20
	BNE.b CODE_05C9DF
CODE_05CA13:
	LDX.b #$00
	STZ.b !RAM_SMB1_Global_ScratchRAME7
CODE_05CA17:
	LDA.w !RAM_SMB1_Level_BridgeSpr_SpriteSlotExistsFlag,x
	BEQ.b CODE_05CA26
	JSR.w CODE_05CA2E
	LDA.b !RAM_SMB1_Global_ScratchRAME7
	CLC
	ADC.b #$20
	STA.b !RAM_SMB1_Global_ScratchRAME7
CODE_05CA26:
	INX
	CPX.b #$0D
	BCC.b CODE_05CA17
	PLY
	PLX
	RTS

CODE_05CA2E:
	LDA.b $9E
	INC
	STA.w $02FC
	PHX
	LDY.w !RAM_SMB1_Level_BridgeSpr_AnimationFrame,x
	STY.b !RAM_SMB1_Global_ScratchRAME6
	LDA.w DATA_05CB2D,y
	CLC
	ADC.b #$A0
	STA.b !RAM_SMB1_Global_ScratchRAME4
	LDA.w DATA_05CB2D+$01,y
	CLC
	ADC.b #$A0
	STA.b !RAM_SMB1_Global_ScratchRAME5
	LDY.b !RAM_SMB1_Global_ScratchRAME7
	LDA.w !RAM_SMB1_Level_BridgeSpr_XPosLo,x
	JSR.w CODE_05CAD3
	LDA.w !RAM_SMB1_Level_BridgeSpr_XPosLo,x
	CLC
	ADC.b #$08
	JSR.w CODE_05CAD3
	LDY.b !RAM_SMB1_Global_ScratchRAME7
	LDA.b !RAM_SMB1_Global_ScratchRAME4
	JSR.w CODE_05CABD
	TYA
	CLC
	ADC.b #$10
	TAY
	LDA.b !RAM_SMB1_Global_ScratchRAME5
	JSR.w CODE_05CABD
	LDX.b !RAM_SMB1_Global_ScratchRAME6
	CPX.b #$04
	BCS.b CODE_05CA76
	LDA.b #$22
	BRA.b CODE_05CA78

CODE_05CA76:
	LDA.b #$23
CODE_05CA78:
	LDY.b !RAM_SMB1_Global_ScratchRAME7
	INY
	INY
	INY
	PHA
	JSR.w CODE_05CAD3
	PLA
	JSR.w CODE_05CAD3
	LDY.b !RAM_SMB1_Global_ScratchRAME7
	TXA
	ASL
	ASL
	ASL
	TAX
	LDA.b #$08
	STA.b !RAM_SMB1_Global_ScratchRAME8
CODE_05CA90:
	LDA.w DATA_05CAE5,x
	STA.w SMB1_OAMBuffer[$40].Tile,y
	INY
	INY
	INY
	INY
	INX
	DEC.b !RAM_SMB1_Global_ScratchRAME8
	BNE.b CODE_05CA90
	PLX
	DEC.w !RAM_SMB1_Level_BridgeSpr_AnimationFrameTimer,x
	LDA.w !RAM_SMB1_Level_BridgeSpr_AnimationFrameTimer,x
	BNE.b CODE_05CABC
	LDA.b #$03
	STA.w !RAM_SMB1_Level_BridgeSpr_AnimationFrameTimer,x
	INC.w !RAM_SMB1_Level_BridgeSpr_AnimationFrame,x
	LDA.w !RAM_SMB1_Level_BridgeSpr_AnimationFrame,x
	AND.b #$0F
	CMP.b #$09
	BNE.b CODE_05CABC
	STZ.w !RAM_SMB1_Level_BridgeSpr_SpriteSlotExistsFlag,x
CODE_05CABC:
	RTS

CODE_05CABD:
	STA.w SMB1_OAMBuffer[$40].YDisp,y
	CLC
	ADC.b #$08
	STA.w SMB1_OAMBuffer[$41].YDisp,y
	CLC
	ADC.b #$08
	STA.w SMB1_OAMBuffer[$42].YDisp,y
	CLC
	ADC.b #$08
	STA.w SMB1_OAMBuffer[$43].YDisp,y
	RTS

CODE_05CAD3:
	STA.w SMB1_OAMBuffer[$40].XDisp,y
	STA.w SMB1_OAMBuffer[$41].XDisp,y
	STA.w SMB1_OAMBuffer[$42].XDisp,y
	STA.w SMB1_OAMBuffer[$43].XDisp,y
	TYA
	CLC
	ADC.b #$10
	TAY
	RTS

DATA_05CAE5:
	db $10,$20,$FC,$FC,$11,$21,$FC,$FC
	db $10,$20,$FC,$FC,$11,$21,$FC,$FC
	db $12,$22,$FC,$FC,$13,$23,$FC,$FC
	db $14,$24,$16,$FC,$15,$25,$17,$FC
	db $4C,$5C,$4E,$5E,$4D,$5D,$4F,$5F
	db $8C,$9C,$8E,$9E,$8D,$9D,$8F,$9F
	db $AC,$BC,$AE,$BE,$AD,$BD,$AF,$BF
	db $AC,$BC,$AE,$BE,$AD,$BD,$AF,$BF
	db $AC,$BC,$AE,$BE,$AD,$BD,$AF,$BF

DATA_05CB2D:
	db $00,$00,$01,$03,$06,$0A,$0F,$14
	db $1C,$24,$3C

;--------------------------------------------------------------------

DATA_05CB38:
	db $0E,$0E,$0E,$66,$66,$64,$64,$64
	db $66,$66

CODE_05CB42:
	PHB
	PHK
	PLB
	PHY
	LDA.w !RAM_SMB1_Level_SpriteOAMIndexTable+$01,x
	CLC
	ADC.b #$04
	TAY
	LDA.b $47,x
	CMP.b #$02
	BNE.b CODE_05CB55
	LDA.b #$41
CODE_05CB55:
	EOR.b #$2B
	STA.w SMB1_OAMBuffer[$40].Prop,y
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr008_BulletBill
	BEQ.b CODE_05CB6F
	LDA.w $0EA2,x
	CMP.b #$0A
	BCS.b CODE_05CB6F
	LDA.w SMB1_OAMBuffer[$40].Prop,y
	EOR.b #$20
	STA.w SMB1_OAMBuffer[$40].Prop,y
CODE_05CB6F:
	LDA.w $0F4F,x
	LSR
	LSR
	AND.b #$0F
	STA.b !RAM_SMB1_Global_ScratchRAME4
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	AND.b #$20
	BNE.b CODE_05CB84
	LDA.b !RAM_SMB1_Global_ScratchRAME4
	CMP.b #$09
	BCC.b CODE_05CB87
CODE_05CB84:
	STZ.w $0F4F,x
CODE_05CB87:
	LDA.b !RAM_SMB1_Player_CurrentState
	CMP.b #$09
	BCS.b CODE_05CB95
	LDA.w $0E67
	BNE.b CODE_05CB95
	INC.w $0F4F,x
CODE_05CB95:
	LDX.b !RAM_SMB1_Global_ScratchRAME4
	LDA.w $03AE
	STA.w SMB1_OAMBuffer[$40].XDisp,y
	LDA.w $03B9
	CLC
	ADC.b #$08
	STA.w SMB1_OAMBuffer[$40].YDisp,y
	LDA.w DATA_05CB38,x
	STA.w SMB1_OAMBuffer[$40].Tile,y
	LDA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$40].Slot,y
	LDX.b $9E
	LDA.w !RAM_SMB1_NorSpr_XPosLo,x
	STA.b !RAM_SMB1_Global_ScratchRAME4
	LDA.b !RAM_SMB1_NorSpr_XPosHi,x
	STA.b !RAM_SMB1_Global_ScratchRAME5
	REP.b #$20
	LDA.b !RAM_SMB1_Global_ScratchRAME4
	SEC
	SBC.b $42
	STA.b !RAM_SMB1_Global_ScratchRAME4
	SEP.b #$20
	LDA.b !RAM_SMB1_Global_ScratchRAME5
	BEQ.b CODE_05CBD0
	LDA.b #$03
	STA.w SMB1_OAMTileSizeBuffer[$40].Slot,y
CODE_05CBD0:
	LDA.w $03B9
	CMP.b #$E0
	BCS.b CODE_05CBDD
	LDA.b !RAM_SMB1_NorSpr_YPosHi,x
	CMP.b #$01
	BEQ.b CODE_05CBE2
CODE_05CBDD:
	LDA.b #$F0
	STA.w SMB1_OAMBuffer[$40].YDisp,y
CODE_05CBE2:
	PLY
	PLB
	RTL

;--------------------------------------------------------------------

; Note: Routine related to Mario's goal walk?

CODE_05CBE5:
	LDA.w $03FA
	BEQ.b CODE_05CC16
	LDA.w !RAM_SMB1_Player_XPosLo
	STA.b !RAM_SMB1_Global_ScratchRAME4
	LDA.w !RAM_SMB1_Player_XPosHi
	STA.b !RAM_SMB1_Global_ScratchRAME5
	STZ.w $02FE
	REP.b #$20
	LDA.w $02FD
	CLC
	ADC.w $03CC
	CMP.b !RAM_SMB1_Global_ScratchRAME4
	BCC.b CODE_05CC09
	SEP.b #$20
	LDA.b #$01
	RTL

CODE_05CC09:
	SEP.b #$20
	STZ.w $03FA
	LDA.b #$34
	STA.w $02F7
	STA.w $03CF
CODE_05CC16:
	LDA.w $03CF
	BEQ.b CODE_05CC46
	CMP.b #$28
	BCC.b CODE_05CC23
	LDA.b #$F8
	BRA.b CODE_05CC25

CODE_05CC23:
	LDA.b #$F0
CODE_05CC25:
	STA.w $03CE
	LDA.w !RAM_SMB1_Player_CurrentSize
	BEQ.b CODE_05CC36
	LDA.w $03CE
	SEC
	SBC.b #$10
	STA.w $03CE
CODE_05CC36:
	DEC.w $03CF
	LDA.w $03CF
	BNE.b CODE_05CC3E
CODE_05CC3E:
	STZ.b !RAM_SMB1_Player_XSpeed
	STZ.w $0705
	LDA.b #$00
	RTL

CODE_05CC46:
	LDA.b #$01
	STA.w !RAM_SMB1_Level_DisableScrollingFlag
	STA.w !RAM_SMB1_Player_DisableAutoPaletteUpdate
	JSR.w CODE_05CC6C
	STZ.w $03CE
	LDA.w $03FB
	BEQ.b CODE_05CC5F
	DEC.w $03FB
	LDA.b #$01
	RTL

CODE_05CC5F:
	LDA.w $0746
	CMP.b #$01
	BCS.b CODE_05CC69
	INC.w $0746
CODE_05CC69:
	LDA.b #$00
	RTL

;--------------------------------------------------------------------

CODE_05CC6C:
	LDX.b #$00
	REP.b #$20
CODE_05CC70:
	LDA.w SMB1_PaletteMirror[$F0].LowByte,x
	STA.b !RAM_SMB1_Global_ScratchRAME4
	AND.w #$7C00
	BEQ.b CODE_05CC82
	LDA.b !RAM_SMB1_Global_ScratchRAME4
	SEC
	SBC.w #$0400
	STA.b !RAM_SMB1_Global_ScratchRAME4
CODE_05CC82:
	LDA.b !RAM_SMB1_Global_ScratchRAME4
	AND.w #$03E0
	BEQ.b CODE_05CC91
	LDA.b !RAM_SMB1_Global_ScratchRAME4
	SEC
	SBC.w #$0020
	STA.b !RAM_SMB1_Global_ScratchRAME4
CODE_05CC91:
	LDA.b !RAM_SMB1_Global_ScratchRAME4
	AND.w #$001F
	BEQ.b CODE_05CC9A
	DEC.b !RAM_SMB1_Global_ScratchRAME4
CODE_05CC9A:
	LDA.b !RAM_SMB1_Global_ScratchRAME4
	STA.w SMB1_PaletteMirror[$F0].LowByte,x
	INX
	INX
	CPX.b #$20
	BNE.b CODE_05CC70
	SEP.b #$20
	INC.w !RAM_SMB1_Global_UpdateEntirePaletteFlag
	RTS

;--------------------------------------------------------------------

DATA_05CCAB:
	db $90,$80,$70,$90

DATA_05CCAF:
	db $FF,$01

CODE_05CCB1:
	PHX
	PHY
	LDY.w $0368
	LDX.w $0F4E
	LDA.w !RAM_SMB1_NorSpr_XPosLo,y
	SEC
	SBC.b #$0E
	STA.w !RAM_SMB1_NorSpr_XPosLo,x
	LDA.w !RAM_SMB1_NorSpr_XPosHi,y
	STA.b !RAM_SMB1_NorSpr_XPosHi,x
	LDA.w !RAM_SMB1_NorSpr_YPosLo,y
	CLC
	ADC.b #$08
	STA.w !RAM_SMB1_NorSpr_YPosLo,x
	LDA.w !RAM_SMB1_Global_RandomByte1,x
	AND.b #$03
	STA.w !RAM_SMB1_NorSpr_SubYPos,x
	TAY
	LDA.w DATA_05CCAB,y
	LDY.b #$00
	CMP.w !RAM_SMB1_NorSpr_YPosLo,x
	BCC.b CODE_05CCE4
	INY
CODE_05CCE4:
	LDA.w DATA_05CCAF,y
	STA.w !RAM_SMB1_NorSpr_SubYSpeed,x
	STZ.w !RAM_SMB1_Level_SpriteToRandomlyGenerate
	LDA.b #$08
	STA.w !RAM_SMB1_NorSpr_HitboxSizeIndex,x
	LDA.b #$01
	STA.b !RAM_SMB1_NorSpr_YPosHi,x
	STA.b !RAM_SMB1_NorSpr_SpriteSlotExistsFlag,x
	LSR
	STA.w $0402,x
	STA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	PLY
	PLX
	RTS

;--------------------------------------------------------------------

; Note: Bowser Fire graphics routine

CODE_05CD01:
	PHB
	PHK
	PLB
	LDY.w !RAM_SMB1_Level_SpriteOAMIndexTable+$01,x
	LDA.w $03AE
	STA.w SMB1_OAMBuffer[$40].XDisp,y
	CLC
	ADC.b #$08
	STA.w SMB1_OAMBuffer[$41].XDisp,y
	LDA.w $03B9
	STA.w SMB1_OAMBuffer[$40].YDisp,y
	STA.w SMB1_OAMBuffer[$41].YDisp,y
	LDA.b #$21
	STA.w SMB1_OAMBuffer[$40].Prop,y
	STA.w SMB1_OAMBuffer[$41].Prop,y
	LDA.w $0F58,x
	LSR
	LSR
	LSR
	CMP.b #$03
	BNE.b CODE_05CD51
	STZ.w $0F36,x
	LDA.b #$01
	STA.w $0F36,x
	LDA.w !RAM_SMB1_NorSpr_XPosLo,x
	CLC
	ADC.b #$10
	STA.w $0F62,x
	LDA.b !RAM_SMB1_NorSpr_XPosHi,x
	ADC.b #$00
	STA.w $0F6B,x
	LDA.w $03B9
	STA.w $0F74,x
	LDA.b #$00
	STA.w $0F58,x
CODE_05CD51:
	TAX
	LDA.w DATA_05CDE2,x
	STA.w SMB1_OAMBuffer[$40].Tile,y
	INC
	STA.w SMB1_OAMBuffer[$41].Tile,y
	STX.b !RAM_SMB1_Global_ScratchRAME4
	LDX.b $9E
	LDA.w !RAM_SMB1_NorSpr_XPosLo,x
	STA.b !RAM_SMB1_Global_ScratchRAME5
	LDA.b !RAM_SMB1_NorSpr_XPosHi,x
	STA.b !RAM_SMB1_Global_ScratchRAME6
	REP.b #$20
	LDA.b !RAM_SMB1_Global_ScratchRAME5
	SEC
	SBC.b $42
	STA.b !RAM_SMB1_Global_ScratchRAME5
	CLC
	ADC.w #$0008
	STA.b !RAM_SMB1_Global_ScratchRAME7
	SEP.b #$20
	LDA.b #$02
	STA.b !RAM_SMB1_Global_ScratchRAME9
	LDA.b !RAM_SMB1_Global_ScratchRAME6
	BEQ.b CODE_05CD84
	LDA.b #$01
CODE_05CD84:
	ORA.b !RAM_SMB1_Global_ScratchRAME9
	STA.w SMB1_OAMTileSizeBuffer[$40].Slot,y
	LDA.b !RAM_SMB1_Global_ScratchRAME8
	BEQ.b CODE_05CD8F
	LDA.b #$01
CODE_05CD8F:
	ORA.b !RAM_SMB1_Global_ScratchRAME9
	STA.w SMB1_OAMTileSizeBuffer[$41].Slot,y
	LDA.w $0F36,x
	BEQ.b CODE_05CDDB
	LDA.w $0F62,x
	STA.b !RAM_SMB1_Global_ScratchRAME5
	LDA.w $0F6B,x
	STA.b !RAM_SMB1_Global_ScratchRAME6
	REP.b #$20
	LDA.b !RAM_SMB1_Global_ScratchRAME5
	SEC
	SBC.b $42
	STA.b !RAM_SMB1_Global_ScratchRAME5
	SEP.b #$20
	LDA.b !RAM_SMB1_Global_ScratchRAME5
	STA.w SMB1_OAMBuffer[$42].XDisp,y
	LDA.w $0F58,x
	LSR
	CLC
	ADC.b #$04
	CLC
	ADC.w $0F74,x
	STA.w SMB1_OAMBuffer[$42].YDisp,y
	LDX.b !RAM_SMB1_Global_ScratchRAME4
	LDA.w DATA_05CDE5,x
	STA.w SMB1_OAMBuffer[$42].Tile,y
	LDA.b #$28
	STA.w SMB1_OAMBuffer[$42].Prop,y
	STZ.b !RAM_SMB1_Global_ScratchRAME9
	LDA.b !RAM_SMB1_Global_ScratchRAME6
	BEQ.b CODE_05CDD6
	LDA.b #$01
CODE_05CDD6:
	ORA.b !RAM_SMB1_Global_ScratchRAME9
	STA.w SMB1_OAMTileSizeBuffer[$42].Slot,y
CODE_05CDDB:
	LDX.b $9E
	INC.w $0F58,x
	PLB
	RTL

DATA_05CDE2:
	db $86,$A6,$89

DATA_05CDE5:
	db $30,$31,$32,$06,$0A,$0E

;--------------------------------------------------------------------

; Note: Something related to a vine growing in a bonus room?

CODE_05CDEB:
	PHB
	PHK
	PLB
	LDY.b #$04
	STY.w !RAM_SMB1_Player_PlayerEnteredCoinHeavenFlag
	LDA.w $03AE
	SEC
	SBC.b #$08
	STA.b !RAM_SMB1_Global_ScratchRAME4
	LDX.b #$00
CODE_05CDFD:
	LDA.w DATA_05CF1B,x
	CLC
	ADC.b !RAM_SMB1_Global_ScratchRAME4
	STA.w SMB1_OAMBuffer[$00].XDisp,y
	LDA.w $03B9
	SEC
	SBC.b #$04
	STA.w SMB1_OAMBuffer[$00].YDisp,y
	PHX
	LDA.b !RAM_SMB1_Global_FrameCounter
	AND.b #$18
	STX.b !RAM_SMB1_Global_ScratchRAME5
	CLC
	ADC.b !RAM_SMB1_Global_ScratchRAME5
	TAX
	LDA.w DATA_05CEFB,x
	STA.w SMB1_OAMBuffer[$00].Prop,y
	LDA.w DATA_05CEDB,x
	STA.w SMB1_OAMBuffer[$00].Tile,y
	PLX
	INY
	INY
	INY
	INY
	INX
	CPX.b #$05
	BNE.b CODE_05CDFD
	LDX.b $9E
	LDA.w !RAM_SMB1_NorSpr_XPosLo,x
	STA.b !RAM_SMB1_Global_ScratchRAME5
	LDA.b !RAM_SMB1_NorSpr_XPosHi,x
	STA.b !RAM_SMB1_Global_ScratchRAME6
	REP.b #$20
	LDA.b !RAM_SMB1_Global_ScratchRAME5
	SEC
	SBC.w #$0008
	SEC
	SBC.b $42
	STA.b !RAM_SMB1_Global_ScratchRAME9
	CLC
	ADC.w #$0010
	STA.b !RAM_SMB1_Global_ScratchRAME8
	CLC
	ADC.w #$0004
	STA.b !RAM_SMB1_Global_ScratchRAMDF
	CLC
	ADC.w #$0008
	STA.b !RAM_SMB1_Global_ScratchRAMDD
	CLC
	ADC.w #$0004
	STA.b !RAM_SMB1_Global_ScratchRAME7
	CLC
	ADC.w #$0010
	STA.b !RAM_SMB1_Global_ScratchRAME6
	SEC
	SBC.w #$0010
	STA.b !RAM_SMB1_Global_ScratchRAME5
	SEP.b #$20
	LDA.b #$02
	STA.b !RAM_SMB1_Global_ScratchRAME4
	LDY.b #$04
	LDX.b #$05
CODE_05CE76:
	LDA.b !RAM_SMB1_Global_ScratchRAME5,x
	BEQ.b CODE_05CE7C
	LDA.b #$01
CODE_05CE7C:
	ORA.b !RAM_SMB1_Global_ScratchRAME4
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot,y
	INY
	INY
	INY
	INY
	DEX
	BNE.b CODE_05CE76
	STZ.b !RAM_SMB1_Global_ScratchRAME4
	LDA.w !RAM_SMB1_Global_UseLateStageSpriteBehaviorFlag
	BNE.b CODE_05CEA6
	LDA.b #$F0
	STA.w SMB1_OAMBuffer[$05].YDisp
	LDA.b !RAM_SMB1_Global_ScratchRAMDE
	BEQ.b CODE_05CE9A
	LDA.b #$01
CODE_05CE9A:
	ORA.b !RAM_SMB1_Global_ScratchRAME4
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot
	LDA.b !RAM_SMB1_Global_ScratchRAMDD
	STA.w SMB1_OAMBuffer[$00].XDisp
	BRA.b CODE_05CEBE

CODE_05CEA6:
	LDA.b #$F0
	STA.w SMB1_OAMBuffer[$03].YDisp
	STA.w SMB1_OAMBuffer[$04].YDisp
	LDA.b !RAM_SMB1_Global_ScratchRAME0
	BEQ.b CODE_05CEB4
	LDA.b #$01
CODE_05CEB4:
	ORA.b !RAM_SMB1_Global_ScratchRAME4
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot
	LDA.b !RAM_SMB1_Global_ScratchRAMDF
	STA.w SMB1_OAMBuffer[$00].XDisp
CODE_05CEBE:
	LDA.b !RAM_SMB1_Global_FrameCounter
	AND.b #$10
	LSR
	LSR
	LSR
	LSR
	CLC
	ADC.w $03B9
	STA.w SMB1_OAMBuffer[$00].YDisp
	LDA.b #$E7
	STA.w SMB1_OAMBuffer[$00].Tile
	LDA.b #$2C
	STA.w SMB1_OAMBuffer[$00].Prop
	LDX.b $9E
	PLB
	RTL

DATA_05CEDB:
	db $40,$41,$41,$42,$42,$00,$00,$00
	db $60,$61,$61,$62,$62,$00,$00,$00
	db $42,$41,$41,$40,$40,$00,$00,$00
	db $62,$61,$61,$60,$60,$00,$00,$00

DATA_05CEFB:
	db $2A,$6A,$6A,$2A,$2A,$00,$00,$00
	db $2A,$6A,$6A,$2A,$2A,$00,$00,$00
	db $6A,$2A,$2A,$6A,$6A,$00,$00,$00
	db $6A,$2A,$2A,$6A,$6A,$00,$00,$00

DATA_05CF1B:
	db $00,$10,$20,$30,$20

;--------------------------------------------------------------------

DATA_05CF20:
	db $C0,$E0,$C4,$C2,$E2,$C5,$C6,$E6,$D4,$C8,$E8,$D5,$CA,$EA,$E4,$C8
	db $EC,$E5,$CC,$E0,$F4,$CE,$E2,$F5,$C0,$E0,$C4,$EE,$E2,$C5,$CC,$E0
	db $94,$A4,$E2,$95,$80,$A0,$84,$82,$A2,$85,$C2,$E2,$C5,$C0,$E0,$C4
	db $C8,$E8,$D5,$C6,$E6,$D4,$C8,$EC,$E5,$CA,$EA,$E4,$CE,$E2,$F5,$CC
	db $E0,$F4,$EE,$E2,$C5,$C0,$E0,$C4,$A4,$E2,$95,$CC,$E0,$94,$82,$A2
	db $85,$80,$A0,$84

DATA_05CF74:
	db $00,$01,$01,$00,$02,$02,$03,$04,$05,$06

DATA_05CF7E:
	db $08,$09

DATA_05CF80:
	db $EE,$EE,$EE,$00,$F6,$F6,$F6,$00,$EC,$EC,$EC,$00,$00

DATA_05CF8D:
	db $00,$00,$E8,$E8,$E8,$00,$F2,$F2,$F2,$00,$FA,$FA,$FA

DATA_05CF9A:
	db $EA,$EA,$EA,$00,$E5,$E5,$E5,$00,$E4,$E4,$E4,$00,$00

DATA_05CFA7:
	db $00,$00,$E8,$E8,$E8,$00,$ED,$ED,$ED,$00,$E5,$E5,$E5

DATA_05CFB4:
	db $A9,$B9,$E8,$00,$A9,$B9,$E8,$00,$A9,$B9,$E8,$00,$00

DATA_05CFC1:
	db $00,$00,$A9,$B9,$E8,$00,$A9,$B9,$E8,$00,$A9,$B9,$E8

DATA_05CFCE:
	db $27,$27,$26,$27,$27,$27,$26,$27,$27,$27,$26,$27,$27

DATA_05CFDB:
	db $27,$27,$27,$27,$26,$27,$27,$27,$26,$27,$27,$27,$26

CODE_05CFE8:
	PHX
	INC.w !RAM_SMB1_NorSpr02D_Bowser_WoozyEffectAnimationFrame
	LDA.w !RAM_SMB1_NorSpr02D_Bowser_WoozyEffectAnimationFrame
	CMP.b #$34
	BCS.b CODE_05D050
	LSR
	LSR
	TAX
	LDA.w DATA_05CF80,x
	CLC
	ADC.w $03AE
	CLC
	ADC.b #$18
	STA.w SMB1_OAMBuffer[$3E].XDisp
	LDA.w DATA_05CF8D,x
	CLC
	ADC.w $03AE
	CLC
	ADC.b #$18
	STA.w SMB1_OAMBuffer[$3F].XDisp
	LDA.w DATA_05CF9A,x
	BNE.b CODE_05D019
	LDA.b #$F0
	BRA.b CODE_05D020

CODE_05D019:
	CLC
	ADC.w $03B9
	CLC
	ADC.b #$10
CODE_05D020:
	STA.w SMB1_OAMBuffer[$3E].YDisp
	LDA.w DATA_05CFA7,x
	BNE.b CODE_05D02C
	LDA.b #$F0
	BRA.b CODE_05D033

CODE_05D02C:
	CLC
	ADC.b #$10
	CLC
	ADC.w $03B9
CODE_05D033:
	STA.w SMB1_OAMBuffer[$3F].YDisp
	LDA.w DATA_05CFB4,x
	STA.w SMB1_OAMBuffer[$3E].Tile
	LDA.w DATA_05CFC1,x
	STA.w SMB1_OAMBuffer[$3F].Tile
	LDA.w DATA_05CFCE,x
	STA.w SMB1_OAMBuffer[$3E].Prop
	LDA.w DATA_05CFDB,x
	STA.w SMB1_OAMBuffer[$3F].Prop
	BRA.b CODE_05D053

CODE_05D050:
	STZ.w !RAM_SMB1_NorSpr02D_Bowser_FeelingWoozyFlag
CODE_05D053:
	PLX
	RTS

SMB1_BowserGFXRt:
.Main:
	PHB
	PHK
	PLB
	LDA.w !RAM_SMB1_NorSpr02D_Bowser_FeelingWoozyFlag
	BEQ.b CODE_05D060
	JSR.w CODE_05CFE8
CODE_05D060:
	LDA.w $0F4C
	BEQ.b CODE_05D07A
	LDY.w $014B
	CPY.b #$08
	BNE.b CODE_05D089
	LDA.w $0F4C
	LSR
	LSR
	AND.b #$01
	TAY
	LDA.w DATA_05CF7E,y
	TAY
	BRA.b CODE_05D089

CODE_05D07A:
	LDA.w $0792,x
	BNE.b CODE_05D082
	STZ.w $014B
CODE_05D082:
	LDA.w $014B
	LSR
	LSR
	LSR
	TAY
CODE_05D089:
	LDA.w DATA_05CF74,y
	STA.w $014C
	LDA.w !RAM_SMB1_Level_SpriteOAMIndexTable+$01,x
	TAY
	LDA.w $03AE
	STA.w SMB1_OAMBuffer[$40].XDisp,y
	STA.w SMB1_OAMBuffer[$41].XDisp,y
	CLC
	ADC.b #$08
	STA.w SMB1_OAMBuffer[$42].XDisp,y
	CLC
	ADC.b #$08
	STA.w SMB1_OAMBuffer[$43].XDisp,y
	STA.w SMB1_OAMBuffer[$44].XDisp,y
	STA.w SMB1_OAMBuffer[$45].XDisp,y
	LDA.w $03B9
	STA.w SMB1_OAMBuffer[$40].YDisp,y
	STA.w SMB1_OAMBuffer[$43].YDisp,y
	CLC
	ADC.b #$10
	STA.w SMB1_OAMBuffer[$41].YDisp,y
	STA.w SMB1_OAMBuffer[$44].YDisp,y
	SEC
	SBC.b #$18
	STA.w SMB1_OAMBuffer[$42].YDisp,y
	STA.w SMB1_OAMBuffer[$45].YDisp,y
	LDA.b $47,x
	STA.b !RAM_SMB1_Global_ScratchRAMDE
	CMP.b #$01
	BEQ.b CODE_05D0D5
	LDA.b #$61
	BRA.b CODE_05D0D7

CODE_05D0D5:
	LDA.b #$21
CODE_05D0D7:
	STA.w SMB1_OAMBuffer[$40].Prop,y
	STA.w SMB1_OAMBuffer[$41].Prop,y
	STA.w SMB1_OAMBuffer[$42].Prop,y
	STA.w SMB1_OAMBuffer[$43].Prop,y
	STA.w SMB1_OAMBuffer[$44].Prop,y
	STA.w SMB1_OAMBuffer[$45].Prop,y
	STX.b $9E
	LDA.w $014C
	ASL
	STA.b !RAM_SMB1_Global_ScratchRAMDD
	ASL
	CLC
	ADC.b !RAM_SMB1_Global_ScratchRAMDD
	TAX
	CLC
	ADC.b #$06
	STA.b !RAM_SMB1_Global_ScratchRAMDD
	LDA.b !RAM_SMB1_Global_ScratchRAMDE
	CMP.b #$01
	BEQ.b CODE_05D10C
	LDA.b !RAM_SMB1_Global_ScratchRAMDD
	CLC
	ADC.b #$2A
	STA.b !RAM_SMB1_Global_ScratchRAMDD
	SEC
	SBC.b #$06
	TAX
CODE_05D10C:
	LDA.w DATA_05CF20,x
	STA.w SMB1_OAMBuffer[$40].Tile,y
	LDA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$40].Slot,y
	INY
	INY
	INY
	INY
	INX
	CPX.b !RAM_SMB1_Global_ScratchRAMDD
	BNE.b CODE_05D10C
	LDA.b #$00
	STA.w SMB1_OAMTileSizeBuffer[$3F].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$3C].Slot,y
	LDX.b $9E
	LDA.w !RAM_SMB1_NorSpr_XPosLo,x
	STA.b !RAM_SMB1_Global_ScratchRAME4
	LDA.b !RAM_SMB1_NorSpr_XPosHi,x
	STA.b !RAM_SMB1_Global_ScratchRAME5
	REP.b #$20
	LDA.b !RAM_SMB1_Global_ScratchRAME4
	SEC
	SBC.b $42
	STA.b !RAM_SMB1_Global_ScratchRAME4
	CLC
	ADC.w #$0008
	STA.b !RAM_SMB1_Global_ScratchRAME6
	CLC
	ADC.w #$0008
	STA.b !RAM_SMB1_Global_ScratchRAME8
	SEP.b #$20
	LDA.w !RAM_SMB1_Level_SpriteOAMIndexTable+$01,x
	TAY
	LDA.b !RAM_SMB1_Global_ScratchRAME5
	BEQ.b CODE_05D15A
	LDA.b #$03
	STA.w SMB1_OAMTileSizeBuffer[$40].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$41].Slot,y
CODE_05D15A:
	LDA.b !RAM_SMB1_Global_ScratchRAME7
	BEQ.b CODE_05D163
	LDA.b #$01
	STA.w SMB1_OAMTileSizeBuffer[$42].Slot,y
CODE_05D163:
	LDA.b !RAM_SMB1_Global_ScratchRAME9
	BEQ.b CODE_05D172
	LDA.b #$01
	STA.w SMB1_OAMTileSizeBuffer[$43].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$44].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$45].Slot,y
CODE_05D172:
	LDA.w $0F4C
	BNE.b CODE_05D189
	STZ.w $0F4C
	INC.w $014B
	LDA.w $014B
	CMP.b #$30
	BCC.b CODE_05D1AD
	STZ.w $014B
	BRA.b CODE_05D1AD

CODE_05D189:
	DEC.w $0F4C
	LDA.w $0F4C
	BNE.b CODE_05D1AD
	LDA.w $014B
	CMP.b #$06
	BNE.b CODE_05D1AA
	INC.w $014B
	LDA.b #$28
	STA.w $0F4C
	LDA.b #!Define_SMAS_Sound0060_BowserBreathFire
	STA.w !RAM_SMB1_Global_SoundCh1
	JSR.w CODE_05CCB1
	BRA.b CODE_05D1AD

CODE_05D1AA:
	STZ.w $014B
CODE_05D1AD:
	LDA.w !RAM_SMB1_NorSpr02D_Bowser_CurrentHP
	BNE.b CODE_05D1F1
	LDX.b $9E
	LDY.w !RAM_SMB1_Level_SpriteOAMIndexTable+$01,x
	LDX.b #$06
CODE_05D1B9:
	LDA.w SMB1_OAMBuffer[$40].Prop,y
	ORA.b #$80
	STA.w SMB1_OAMBuffer[$40].Prop,y
	INY
	INY
	INY
	INY
	DEX
	BNE.b CODE_05D1B9
	LDX.b $9E
	LDY.w !RAM_SMB1_Level_SpriteOAMIndexTable+$01,x
	LDA.w SMB1_OAMBuffer[$40].YDisp,y
	CLC
	ADC.b #$08
	STA.w SMB1_OAMBuffer[$40].YDisp,y
	STA.w SMB1_OAMBuffer[$43].YDisp,y
	LDA.w SMB1_OAMBuffer[$41].YDisp,y
	SEC
	SBC.b #$18
	STA.w SMB1_OAMBuffer[$41].YDisp,y
	STA.w SMB1_OAMBuffer[$44].YDisp,y
	LDA.w SMB1_OAMBuffer[$42].YDisp,y
	CLC
	ADC.b #$20
	STA.w SMB1_OAMBuffer[$42].YDisp,y
	STA.w SMB1_OAMBuffer[$45].YDisp,y
CODE_05D1F1:
	JSR.w SMB1_DrawCrumblingBridgeSegment_Main
	PLB
	RTL

;--------------------------------------------------------------------

; Note: Unreferenced routine.

ADDR_05D1F6:
	PHA
	PHB
	PHK
	PLB
	LDA.w !RAM_SMB1_TitleScreen_WaitBeforePlayingDemo
	BEQ.b ADDR_05D26F
	LDA.w !RAM_SMB1_Global_ControllerHold1P1
	STA.b !RAM_SMB1_Global_ScratchRAME4
	AND.b #(!Joypad_B>>8)|(!Joypad_Y>>8)
	BEQ.b ADDR_05D26F
	LDA.b !RAM_SMB1_Global_FrameCounter
	AND.b #$07
	BNE.b ADDR_05D26F
	LDA.b !RAM_SMB1_Global_ScratchRAME4
	CMP.b #!Joypad_Y>>8
	BNE.b ADDR_05D226
	LDA.b #$17
	STA.w !RAM_SMB1_TitleScreen_WaitBeforePlayingDemo
	INC.w !RAM_SMB1_Player_CurrentWorld
	LDA.w !RAM_SMB1_Player_CurrentWorld
	CMP.b #$08
	BCC.b ADDR_05D226
	STZ.w !RAM_SMB1_Player_CurrentWorld
ADDR_05D226:
	LDA.b !RAM_SMB1_Global_ScratchRAME4
	CMP.b #!Joypad_B>>8
	BNE.b ADDR_05D23E
	LDA.b #$17
	STA.w !RAM_SMB1_TitleScreen_WaitBeforePlayingDemo
	INC.w !RAM_SMB1_Player_CurrentLevelNumberDisplay
	LDA.w !RAM_SMB1_Player_CurrentLevelNumberDisplay
	CMP.b #$04
	BCC.b ADDR_05D23E
	STZ.w !RAM_SMB1_Player_CurrentLevelNumberDisplay
ADDR_05D23E:
	LDX.b #$00
ADDR_05D240:
	LDA.w UNK_05D2A6,x
	STA.l SMB1_StripeImageUploadTable[$00].LowByte,x
	INX
	CPX.b #$0B
	BCC.b ADDR_05D240
	LDA.w !RAM_SMB1_Player_CurrentWorld
	CLC
	ADC.b #$01
	STA.l SMB1_StripeImageUploadTable[$02].LowByte
	LDA.w !RAM_SMB1_Player_CurrentLevelNumberDisplay
	CLC
	ADC.b #$01
	STA.l SMB1_StripeImageUploadTable[$04].LowByte
	LDA.w !RAM_SMB1_Player_CurrentWorld
	ASL
	ASL
	ORA.w !RAM_SMB1_Player_CurrentLevelNumberDisplay
	TAX
	LDA.w UNK_05D272,x
	STA.w !RAM_SMB1_Player_CurrentLevel
ADDR_05D26F:
	PLB
	PLA
	RTL

UNK_05D272:
	db $00,$02,$03,$04,$00,$02,$03,$04
	db $00,$01,$02,$03,$00,$02,$03,$04
	db $00,$01,$02,$03,$00,$01,$02,$03
	db $00,$02,$03,$04,$00,$01,$02,$03
	db $00,$01,$02,$03,$00,$02,$03,$04
	db $00,$02,$03,$04,$00,$01,$02,$03
	db $00,$01,$02,$03

UNK_05D2A6:
	db $58,$73,$00,$05
	db $24,$20,$24,$20,$24,$20

	db $FF

;--------------------------------------------------------------------

SMB1_InitializeContactSprite:
.Main:
;$05D2B1
	PHY
	LDY.b #$00
CODE_05D2B4:
	LDA.w !RAM_Level_ContactSpr_AnimationFrame,y
	BEQ.b CODE_05D2C0
	INY
	CPY.b #$05
	BNE.b CODE_05D2B4
	LDY.b #$00
CODE_05D2C0:
	LDA.b #$01
	STA.w !RAM_Level_ContactSpr_AnimationFrame,y
	LDA.b !RAM_SMB1_NorSpr_XSpeed,x
	BPL.b CODE_05D2E0
	LDA.b !RAM_SMB1_NorSpr_XPosHi,x
	XBA
	LDA.w !RAM_SMB1_NorSpr_XPosLo,x
	REP.b #$20
	SEC
	SBC.w #$0008
	SEP.b #$20
	STA.w !RAM_Level_ContactSpr_XPosLo,y
	XBA
	STA.w !RAM_Level_ContactSpr_XPosHi,y
	BRA.b CODE_05D2F5

CODE_05D2E0:
	LDA.b !RAM_SMB1_NorSpr_XPosHi,x
	XBA
	LDA.w !RAM_SMB1_NorSpr_XPosLo,x
	REP.b #$20
	CLC
	ADC.w #$0008
	SEP.b #$20
	STA.w !RAM_Level_ContactSpr_XPosLo,y
	XBA
	STA.w !RAM_Level_ContactSpr_XPosHi,y
CODE_05D2F5:
	LDA.w $03B9
	CLC
	ADC.b #$0C
	STA.w !RAM_Level_ContactSpr_YPosLo,y
	PLY
	RTL

;--------------------------------------------------------------------

SMB1_ProcessContactSprites:
.Main:
;$05D300
	PHB
	PHK
	PLB
	PHX
	PHY
	LDX.b #$00
CODE_05D307:
	LDA.w DATA_05D46D,x
	TAY
	LDA.w !RAM_Level_ContactSpr_AnimationFrame,x
	BEQ.b CODE_05D330
	AND.b #$0C
	STA.b !RAM_SMB1_Global_ScratchRAME4
	BNE.b CODE_05D31B
	JSR.w CODE_05D339
	BRA.b CODE_05D330

CODE_05D31B:
	CMP.b #$04
	BNE.b CODE_05D324
	JSR.w CODE_05D374
	BRA.b CODE_05D330

CODE_05D324:
	CMP.b #$08
	BNE.b CODE_05D32D
	JSR.w CODE_05D3B4
	BRA.b CODE_05D330

CODE_05D32D:
	STZ.w !RAM_Level_ContactSpr_AnimationFrame,x
CODE_05D330:
	INX
	CPX.b #$05
	BNE.b CODE_05D307
	PLY
	PLX
	PLB
	RTL

CODE_05D339:
	JSR.w CODE_05D458
	LDA.w $0B3B
	CLC
	ADC.b #$04
	STA.w SMB1_OAMBuffer[$00].YDisp,y
	LDA.b #$26
	STA.w SMB1_OAMBuffer[$00].Tile,y
	LDA.b #$25
	STA.w SMB1_OAMBuffer[$00].Prop,y
	REP.b #$20
	LDA.w $0B39
	CLC
	ADC.w #$0004
	SEC
	SBC.b $42
	STA.w $0B39
	SEP.b #$20
	LDA.w $0B39
	STA.w SMB1_OAMBuffer[$00].XDisp,y
	LDA.w $0B3A
	BEQ.b CODE_05D36D
	LDA.b #$01
CODE_05D36D:
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot,y
	INC.w !RAM_Level_ContactSpr_AnimationFrame,x
	RTS

CODE_05D374:
	JSR.w CODE_05D458
	LDA.w $0B3B
	STA.w SMB1_OAMBuffer[$00].YDisp,y
	LDA.b #$60
	STA.w SMB1_OAMBuffer[$00].Tile,y
	LDA.b #$25
	STA.w SMB1_OAMBuffer[$00].Prop,y
	REP.b #$20
	LDA.w $0B39
	SEC
	SBC.b $42
	STA.w $0B39
	SEP.b #$20
	LDA.w $0B39
	STA.w SMB1_OAMBuffer[$00].XDisp,y
	LDA.w $0B3A
	BEQ.b CODE_05D3A3
	LDA.b #$03
	BRA.b CODE_05D3A5

CODE_05D3A3:
	LDA #$02

CODE_05D3A5:
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot,y
	INC.w !RAM_Level_ContactSpr_AnimationFrame,x
	RTS

DATA_05D3AC:
	db $FF,$FE,$FC,$F9

DATA_05D3B0:
	db $01,$02,$04,$07

CODE_05D3B4:
	STX.b !RAM_SMB1_Global_ScratchRAMF1
	JSR.w CODE_05D458
	LDA.w !RAM_Level_ContactSpr_AnimationFrame,x
	AND.b #$03
	TAX
	LDA.w $0B3B
	CLC
	ADC.w DATA_05D3AC,x
	STA.w SMB1_OAMBuffer[$00].YDisp,y
	STA.w SMB1_OAMBuffer[$01].YDisp,y
	LDA.w $0B3B
	CLC
	ADC.w DATA_05D3B0,x
	CLC
	ADC.b #$08
	STA.w SMB1_OAMBuffer[$02].YDisp,y
	STA.w SMB1_OAMBuffer[$03].YDisp,y
	LDA.b #$39
	STA.w SMB1_OAMBuffer[$00].Tile,y
	STA.w SMB1_OAMBuffer[$01].Tile,y
	STA.w SMB1_OAMBuffer[$02].Tile,y
	STA.w SMB1_OAMBuffer[$03].Tile,y
	LDA.b #$25
	STA.w SMB1_OAMBuffer[$00].Prop,y
	STA.w SMB1_OAMBuffer[$01].Prop,y
	STA.w SMB1_OAMBuffer[$02].Prop,y
	STA.w SMB1_OAMBuffer[$03].Prop,y
	LDA.w DATA_05D3AC,x
	STA.b !RAM_SMB1_Global_ScratchRAMEF
	LDA.b #$FF
	STA.b !RAM_SMB1_Global_ScratchRAMF0
	REP.b #$20
	LDA.w $0B39
	SEC
	SBC.b $42
	CLC
	ADC.b !RAM_SMB1_Global_ScratchRAMEF
	STA.b !RAM_SMB1_Global_ScratchRAMED
	SEP.b #$20
	LDA.b !RAM_SMB1_Global_ScratchRAMED
	STA.w SMB1_OAMBuffer[$00].XDisp,y
	STA.w SMB1_OAMBuffer[$02].XDisp,y
	LDA.b !RAM_SMB1_Global_ScratchRAMEE
	BEQ.b CODE_05D41E
	LDA.b #$01
CODE_05D41E:
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$02].Slot,y
	LDA.w DATA_05D3B0,x
	STA.b !RAM_SMB1_Global_ScratchRAMEF
	STZ.b !RAM_SMB1_Global_ScratchRAMF0
	REP.b #$20
	LDA.w $0B39
	CLC
	ADC.w #$0008
	SEC
	SBC.b $42
	CLC
	ADC.b !RAM_SMB1_Global_ScratchRAMEF
	STA.b !RAM_SMB1_Global_ScratchRAMED
	SEP.b #$20
	LDA.b !RAM_SMB1_Global_ScratchRAMED
	STA.w SMB1_OAMBuffer[$01].XDisp,y
	STA.w SMB1_OAMBuffer[$03].XDisp,y
	LDA.b !RAM_SMB1_Global_ScratchRAMEE
	BEQ.b CODE_05D44C
	LDA.b #$01
CODE_05D44C:
	STA.w SMB1_OAMTileSizeBuffer[$01].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$03].Slot,y
	LDX.b !RAM_SMB1_Global_ScratchRAMF1
	INC.w !RAM_Level_ContactSpr_AnimationFrame,x
	RTS

CODE_05D458:
	LDA.w !RAM_Level_ContactSpr_YPosLo,x
	STA.w $0B3B
	LDA.w !RAM_Level_ContactSpr_XPosHi,x
	XBA
	LDA.w !RAM_Level_ContactSpr_XPosLo,x
	REP.b #$20
	STA.w $0B39
	SEP.b #$20
	RTS

DATA_05D46D:
	db $00,$10,$20,$40,$50

;--------------------------------------------------------------------

SMB1_CheckIfBowserTouchedLava:
.Main:
;$05D472
	PHB
	PHK
	PLB
	LDA.w !RAM_SMB1_NorSpr02D_Bowser_UnknownRAM
	CMP.b #$01
	BEQ.b CODE_05D4EE
	LDA.w !RAM_SMB1_Player_CurrentWorld				;\ Note: World 9?
	CMP.b #$08							;|
	BEQ.b CODE_05D4EE						;/
	LDA.b $BA
	CMP.b #$03
	BNE.b CODE_05D4EE
	LDA.b $96
	BNE.b CODE_05D4EB
	LDA.w $02FC
	BEQ.b CODE_05D4EE
	LDX.b #$08
CODE_05D494:
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr02D_Bowser
	BEQ.b CODE_05D49F
CODE_05D49A:
	DEX
	BPL.b CODE_05D494
	BRA.b CODE_05D4C2

CODE_05D49F:
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	CMP.b #$B8
	BCC.b CODE_05D4EE
	LDA.b !RAM_SMB1_NorSpr_SpriteSlotExistsFlag,x
	AND.b #$80
	BNE.b CODE_05D49A
	LDA.w !RAM_SMB1_NorSpr_XPosLo,x
	CLC
	ADC.b #$10
	STA.w $02FA
	LDA.b !RAM_SMB1_NorSpr_XPosHi,x
	ADC.b #$00
	STA.w $02FB
	LDA.b #$08
	STA.b $96
	BRA.b CODE_05D4E1

CODE_05D4C2:
	LDX.w $02FC
	DEX
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	CMP.b #$B8
	BCC.b CODE_05D4EE
	LDA.w !RAM_SMB1_NorSpr_XPosLo,x
	CLC
	ADC.b #$04
	STA.w $02FA
	LDA.b !RAM_SMB1_NorSpr_XPosHi,x
	ADC.b #$00
	STA.w $02FB
	LDA.b #$04
	STA.b $96
CODE_05D4E1:
	LDA.b #!Define_SMAS_Sound0060_BlarggRoar
	STA.w !RAM_SMB1_Global_SoundCh1
	LDA.b #!Define_SMAS_Sound0063_LemmyWendyLandInLava
	STA.w !RAM_SMB1_Global_SoundCh3
CODE_05D4EB:
	JSR.w CODE_05D4F2
CODE_05D4EE:
	JMP.w SMB1_HandlePaletteAnimations_Main

CODE_05D4EF:
	RTL

CODE_05D4F2:
	LDA.b $96
	STA.b !RAM_SMB1_Global_ScratchRAME4
	INC.w $02F9
	LDA.w $02F9
	LSR
	LSR
	CMP.b #$06
	BCS.b CODE_05D55D
	STA.b !RAM_SMB1_Global_ScratchRAMDD
	ASL
	ASL
	ASL
	TAX
	LDY.b #$20
	STZ.b !RAM_SMB1_Global_ScratchRAME9
CODE_05D50C:
	TXA
	AND.b #$01
	CLC
	ADC.b #$FF
	STA.b !RAM_SMB1_Global_ScratchRAME8
	LDA.w DATA_05D563,x
	STA.b !RAM_SMB1_Global_ScratchRAME7
	REP.b #$20
	LDA.b !RAM_SMB1_Global_ScratchRAME7
	CLC
	ADC.w $02FA
	SEC
	SBC.b $42
	STA.b !RAM_SMB1_Global_ScratchRAME7
	SEP.b #$20
	LDA.b !RAM_SMB1_Global_ScratchRAME7
	STA.w SMB1_OAMBuffer[$00].XDisp,y
	LDA.b !RAM_SMB1_Global_ScratchRAME8
	BEQ.b CODE_05D533
	LDA.b #$00
CODE_05D533:
	ORA.b !RAM_SMB1_Global_ScratchRAME9
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot,y
	LDA.w DATA_05D58B,x
	CLC
	ADC.b #$D8
	STA.w SMB1_OAMBuffer[$00].YDisp,y
	PHX
	LDX.b !RAM_SMB1_Global_ScratchRAMDD
	LDA.w DATA_05D5BC,x
	STA.w SMB1_OAMBuffer[$00].Tile,y
	LDX.b !RAM_SMB1_Global_ScratchRAME4
	LDA.w DATA_05D5B3,x
	STA.w SMB1_OAMBuffer[$00].Prop,y
	PLX
	INY
	INY
	INY
	INY
	INX
	DEC.b !RAM_SMB1_Global_ScratchRAME4
	BNE.b CODE_05D50C
	RTS

CODE_05D55D:
	STZ.w $02FC
	STZ.b $96
	RTS

DATA_05D563:
	db $F6,$02,$F1,$07,$F2,$06,$ED,$0B
	db $F3,$05,$EE,$0A,$EF,$09,$EA,$0E
	db $F1,$07,$EC,$0C,$ED,$0B,$E8,$10
	db $F0,$08,$EB,$0D,$EC,$0C,$E7,$11
	db $EF,$09,$EA,$0E,$EB,$0D,$E6,$12

DATA_05D58B:
	db $F5,$F5,$F8,$F8,$F1,$F1,$F4,$F4
	db $F4,$F4,$F7,$F7,$F0,$F0,$F3,$F3
	db $F2,$F2,$F5,$F5,$EE,$EE,$F1,$F1
	db $F1,$F1,$F4,$F4,$ED,$ED,$F0,$F0
	db $F0,$F0,$F3,$F3,$EC,$EC,$EF,$EF

DATA_05D5B3:
	db $28,$68,$28,$68,$28,$68,$28,$68
	db $28

DATA_05D5BC:
	db $33,$33,$34,$35,$36,$37

;--------------------------------------------------------------------

DATA_05D5C2:
	db $F1,$FF,$F6,$FF,$02,$00,$07,$00
	db $EE,$FF,$F3,$FF,$05,$00,$0A,$00
	db $EC,$FF,$F1,$FF,$07,$00,$0C,$00
	db $EB,$FF,$F0,$FF,$08,$00,$0D,$00
	db $EA,$FF,$EF,$FF,$09,$00,$0E,$00
	db $EA,$FF,$EF,$FF,$09,$00,$0E,$00

DATA_05D5F2:
	db $F8,$F5,$F5,$F8,$F7,$F4,$F4,$F7
	db $F5,$F2,$F2,$F5,$F4,$F1,$F1,$F4
	db $F3,$F0,$F0,$F3,$F3,$F0,$F0,$F3

DATA_05D60A:
	db $33,$33,$34,$35,$36,$37

DATA_05D610:
	db $28,$28,$68,$68

CODE_05D614:
	PHB
	PHK
	PLB
	PHX
	PHY
	LDA.w $0B00,x
	CMP.b #$02
	BEQ.b CODE_05D657
	LSR
	BCC.b CODE_05D66C
	LDA.w $0B09,x
	LSR
	LSR
	CMP.b #$06
	BEQ.b CODE_05D659
	TAY
	LDA.w DATA_05D60A,y
	STA.b !RAM_SMB1_Global_ScratchRAMED
	LDA.w !RAM_SMB1_NorSpr_XPosLo,x
	STA.b $00
	LDA.b !RAM_SMB1_NorSpr_XPosHi,x
	STA.b $01
	REP.b #$20
	LDA.b $00
	CLC
	ADC.w #$0008
	SEC
	SBC.b $42
	STA.b $00
	SEP.b #$20
	LDA.w !RAM_SMB1_Level_SpriteOAMIndexTable+$01,x
	CLC
	ADC.b #$04
	STA.b !RAM_SMB1_Global_ScratchRAMF2
	JSR.w CODE_05D73C
	BRA.b CODE_05D66C

CODE_05D657:
	BRA.b CODE_05D69D

CODE_05D659:
	INC.w $0B00,x
	STZ.w $0B09,x
	LDA.w $0B00,x
	CMP.b #$02
	BNE.b CODE_05D66C
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	STA.w $0B12,x
CODE_05D66C:
	PLY
	PLX
	PLB
	RTL

DATA_05D670:
	db $FF,$FF,$FA,$FF,$FA,$FF,$FA,$FF
	db $FF,$FF

DATA_05D67A:
	db $00,$00,$00,$00,$00,$00,$FE,$FF
	db $FE,$FF

DATA_05D684:
	db $FF,$00,$00,$00,$FF

DATA_05D689:
	db $12,$12,$12,$10,$10

DATA_05D68E:
	db $FC,$30,$31,$32,$FC

DATA_05D693:
	db $30,$31,$32,$FC,$FC

DATA_05D698:
	db $FF,$FF,$FF,$00,$00

CODE_05D69D:
	LDA.w $0B09,x
	LSR
	LSR
	LSR
	CMP.b #$05
	BCC.b CODE_05D6AF
	LDA.b #$30
	STA.w $0B09,x
	JMP.w CODE_05D739

CODE_05D6AF:
	STA.b !RAM_SMB1_Global_ScratchRAMEB
	ASL
	TAY
	LDA.w !RAM_SMB1_NorSpr_XPosLo,x
	STA.b $00
	LDA.b !RAM_SMB1_NorSpr_XPosHi,x
	STA.b $01
	REP.b #$20
	LDA.b $00
	CLC
	ADC.w #$0008
	SEC
	SBC.b $42
	PHA
	CLC
	ADC.w DATA_05D670,y
	STA.b $00
	PLA
	CLC
	ADC.w DATA_05D67A,y
	STA.b $02
	SEP.b #$20
	LDY.b !RAM_SMB1_Global_ScratchRAMEB
	LDA.w DATA_05D698,y
	CLC
	ADC.w $0B12,x
	STA.w $0B12,x
	LDA.w DATA_05D684,y
	CLC
	ADC.w $0B12,x
	STA.b $04
	LDA.w DATA_05D689,y
	CLC
	ADC.w $0B12,x
	STA.b !RAM_SMB1_Global_ScratchRAMED
	LDA.w !RAM_SMB1_Level_SpriteOAMIndexTable+$01,x
	TAY
	INY
	INY
	INY
	INY
	LDX.b !RAM_SMB1_Global_ScratchRAMEB
	LDA.b $00
	STA.w SMB1_OAMBuffer[$40].XDisp,y
	LDA.b $02
	STA.w SMB1_OAMBuffer[$41].XDisp,y
	LDA.b $04
	STA.w SMB1_OAMBuffer[$40].YDisp,y
	LDA.b !RAM_SMB1_Global_ScratchRAMED
	STA.w SMB1_OAMBuffer[$41].YDisp,y
	LDA.w DATA_05D68E,x
	STA.w SMB1_OAMBuffer[$40].Tile,y
	LDA.w DATA_05D693,x
	STA.w SMB1_OAMBuffer[$41].Tile,y
	LDA.b #$28
	STA.w SMB1_OAMBuffer[$40].Prop,y
	STA.w SMB1_OAMBuffer[$41].Prop,y
	LDA.b $01
	BEQ.b CODE_05D730
	LDA.b #$01
	STA.w SMB1_OAMTileSizeBuffer[$40].Slot,y
CODE_05D730:
	LDA.b $03
	BEQ.b CODE_05D739
	LDA.b #$01
	STA.w SMB1_OAMTileSizeBuffer[$41].Slot,y
CODE_05D739:
	JMP.w CODE_05D66C

CODE_05D73C:
	STY.b !RAM_SMB1_Global_ScratchRAMEC
	LDX.b #$00
CODE_05D740:
	LDA.b !RAM_SMB1_Global_ScratchRAMEC
	ASL
	ASL
	STA.b !RAM_SMB1_Global_ScratchRAMEB
	TXA
	CLC
	ADC.b !RAM_SMB1_Global_ScratchRAMEB
	TAY
	LDA.b #$D8
	CLC
	ADC.w DATA_05D5F2,y
	STA.b !RAM_SMB1_Global_ScratchRAMEE
	LDA.w DATA_05D610,x
	STA.b !RAM_SMB1_Global_ScratchRAMEF
	TYA
	ASL
	TAY
	REP.b #$20
	LDA.w DATA_05D5C2,y
	CLC
	ADC.b $00
	STA.b !RAM_SMB1_Global_ScratchRAMF0
	SEP.b #$20
	TXA
	ASL
	ASL
	CLC
	ADC.b !RAM_SMB1_Global_ScratchRAMF2
	TAY
	LDA.b !RAM_SMB1_Global_ScratchRAMF0
	STA.w SMB1_OAMBuffer[$40].XDisp,y
	LDA.b !RAM_SMB1_Global_ScratchRAMEE
	STA.w SMB1_OAMBuffer[$40].YDisp,y
	LDA.b !RAM_SMB1_Global_ScratchRAMED
	STA.w SMB1_OAMBuffer[$40].Tile,y
	LDA.b !RAM_SMB1_Global_ScratchRAMEF
	STA.w SMB1_OAMBuffer[$40].Prop,y
	LDA.b !RAM_SMB1_Global_ScratchRAMF1
	BEQ.b CODE_05D78B
	LDA.b #$01
	STA.w SMB1_OAMTileSizeBuffer[$40].Slot,y
CODE_05D78B:
	INX
	CPX.b #$04
	BNE.b CODE_05D740
	RTS

;--------------------------------------------------------------------

UNK_05D791:
	db $1C,$0E,$06,$08

;--------------------------------------------------------------------

; Note: Turn around smoke routine

DATA_05D795:
	db $18
	db $16,$1A,$14

DATA_05D799:
	db $D0,$E0,$E1,$FC

DATA_05D79D:
	db $00,$FC,$F8,$F4

CODE_05D7A1:
	PHB
	PHK
	PLB
	PHX
	PHY
	LDA.w $0E40
	BNE.b CODE_05D7AE
	JSR.w CODE_05D7C2
CODE_05D7AE:
	JSR.w CODE_05D7D1
	LDA.w $0E42
	AND.b #$20
	BEQ.b CODE_05D7BE
	STZ.w $0E40
	STZ.w $0E41
CODE_05D7BE:
	PLY
	PLX
	PLB
	RTL

CODE_05D7C2:
	LDX.b #$03
CODE_05D7C4:
	LDA.w DATA_05D79D,x
	STA.w $0E42,x
	DEX
	BPL.b CODE_05D7C4
	INC.w $0E40
	RTS

CODE_05D7D1:
	LDX.b #$03
	LDY.b #$30
CODE_05D7D5:
	LDA.w $0E42,x
	BMI.b CODE_05D805
	BNE.b CODE_05D7DF
	JSR.w CODE_05D815
CODE_05D7DF:
	LSR
	LSR
	CMP.b #$03
	BCS.b CODE_05D805
	PHX
	TAX
	LDA.w DATA_05D799,x
	STA.w SMB1_OAMBuffer[$00].Tile,y
	LDA.b #$38
	STA.w SMB1_OAMBuffer[$00].Prop,y
	PLX
	LDA.w $0E46,x
	SEC
	SBC.w $071C
	STA.w SMB1_OAMBuffer[$00].XDisp,y
	LDA.w $0E4A,x
	STA.w SMB1_OAMBuffer[$00].YDisp,y
	BRA.b CODE_05D80A

CODE_05D805:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMB1_J) != $00
	LDA.b #$F8
else
	LDA.b #$F0
endif
	STA.w SMB1_OAMBuffer[$00].YDisp,y
CODE_05D80A:
	INY
	INY
	INY
	INY
	INC.w $0E42,x
	DEX
	BPL.b CODE_05D7D5
	RTS

CODE_05D815:
	LDA.w !RAM_SMB1_Level_Player_FacingDirection
	LSR
	BCC.b CODE_05D823
	LDA.w !RAM_SMB1_Player_XPosLo
	CLC
	ADC.b #$06
	BRA.b CODE_05D829

CODE_05D823:
	LDA.w !RAM_SMB1_Player_XPosLo
	CLC
	ADC.b #$02
CODE_05D829:
	STA.w $0E46,x
	LDA.w !RAM_SMB1_Player_CurrentPose
	CMP.b #$18
	BEQ.b CODE_05D837
	CMP.b #$78
	BNE.b CODE_05D84A
CODE_05D837:
	LDA.w !RAM_SMB1_Global_RandomByte2
	AND.b #$04
	SEC
	SBC.b #$02
	CLC
	ADC.w $03B8
	ADC.w DATA_05D795
	STA.w $0E4A,x
	RTS

CODE_05D84A:
	LDA.b #$F8
	STA.w $0E4A,x
	RTS

;--------------------------------------------------------------------

TitleScreenLogoAndMenuStripeImage:
;$05D850
	db $00,$A5,$40,$28
	db $C4,$39

	db $00,$D0,$40,$12
	db $C8,$39

	db $00,$F0,$40,$12
	db $C8,$39

	db $01,$10,$40,$12
	db $C8,$39

	db $01,$30,$40,$12
	db $C8,$39

	db $00,$C5,$C0,$10
	db $C5,$39

	db $01,$59,$C0,$06
	db $C8,$39

	db $00,$DA,$C0,$10
	db $C6,$39

	db $00,$A5,$00,$01
	db $C0,$39

	db $00,$BA,$00,$01
	db $C1,$39

	db $01,$E5,$00,$01
	db $C2,$39

	db $01,$FA,$00,$01
	db $C3,$39

	db $00,$C6,$00,$13
	db $C9,$39,$CA,$39,$D1,$39,$D1,$39,$D5,$39,$C9,$79,$C9,$39,$F5,$39
	db $D5,$39,$C9,$79

	db $00,$E6,$00,$13
	db $CB,$39,$CC,$39,$D2,$39,$D2,$39,$D2,$39,$D6,$39,$DA,$39,$DC,$39
	db $D2,$39,$DE,$39

	db $01,$06,$00,$13
	db $CD,$39,$CE,$39,$D3,$39,$D4,$39,$D7,$39,$D8,$39,$D3,$39,$DB,$39
	db $D7,$39,$DF,$39

	db $01,$26,$00,$13
	db $CF,$39,$D0,$39,$CF,$39,$D0,$39,$D9,$39,$C8,$39,$CF,$39,$DD,$39
	db $D9,$39,$DD,$39

if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMB1_J) != $00
	db $01,$46,$00,$25
	db $C9,$39,$E0,$39,$C9,$79,$C9,$39,$C9,$79,$D5,$39,$C9,$79,$D1,$39
	db $C9,$39,$C9,$79,$C8,$39,$D5,$39,$C9,$79,$D5,$39,$C9,$79,$C9,$39
	db $C9,$79,$C9,$39,$C9,$79

	db $01,$66,$00,$25
	db $E3,$39,$E1,$39,$E1,$39,$E3,$39,$E1,$39,$E3,$39,$F4,$39,$E3,$39
	db $E3,$39,$F4,$39,$C8,$39,$E3,$39,$F4,$39,$E3,$39,$F4,$19,$E3,$39
	db $F4,$39,$E3,$39,$EE,$39

	db $01,$86,$00,$25
	db $E3,$39,$E3,$39,$E3,$39,$E3,$39,$E3,$39,$E3,$39,$E8,$39,$E3,$39
	db $E3,$39,$E3,$39,$C8,$39,$E3,$39,$E8,$39,$E3,$39,$E8,$39,$E3,$39
	db $E3,$39,$EF,$39,$F0,$39

	db $01,$A6,$00,$25
	db $D2,$39,$D2,$39,$D2,$39,$E5,$39,$E6,$39,$D2,$39,$F3,$39,$D2,$39
	db $D2,$39,$D2,$39,$C8,$39,$D2,$39,$F3,$39,$D2,$39,$F3,$39,$D2,$39
	db $D2,$39,$F1,$39,$F6,$39

	db $01,$C6,$00,$27
	db $D7,$39,$D7,$39,$D7,$39,$D7,$39,$E7,$39,$D7,$39,$D7,$39,$D7,$39
	db $D3,$39,$D4,$39,$C8,$39,$D7,$39,$EC,$39,$D7,$39,$D7,$39,$D3,$39
	db $D4,$39,$D3,$39,$D4,$39,$F2,$39

	db $01,$E6,$40,$0E
	db $E4,$39

	db $01,$EE,$00,$17
	db $EA,$39,$EB,$39,$C7,$39,$E4,$39,$ED,$39,$E4,$39,$E4,$39,$EA,$39
	db $EB,$39,$EA,$39,$EB,$39,$E4,$39

	db $02,$08,$00,$25
	db $2F,$06,$01,$04,$09,$04,$08,$04,$05,$04,$24,$04,$01,$04,$09,$04
	db $09,$04,$03,$04,$24,$04,$17,$04,$12,$04,$17,$04,$1D,$04,$0E,$04
	db $17,$04,$0D,$04,$18,$04

if !Define_Global_ROMToAssemble&(!ROM_SMB1_J) == $00
	db $02,$4A,$00,$19
	db $01,$08,$24,$00,$19,$08,$15,$08,$0A,$08,$22,$08,$0E,$08,$1B,$08
	db $24,$00,$10,$08,$0A,$08,$16,$08,$0E,$08

	db $02,$8A,$00,$19
	db $02,$08,$24,$00,$19,$08,$15,$08,$0A,$08,$22,$08,$0E,$08,$1B,$08
	db $24,$00,$10,$08,$0A,$08,$16,$08,$0E,$08

	db $02,$EB,$00,$07
	db $1D,$08,$18,$08,$19,$08,$28,$08

	db $02,$F5,$00,$01
	db $00,$08
endif
else
	db $01,$38,$00,$03
	db $5F,$38,$7A,$38

	db $01,$46,$00,$25
	db $C9,$39,$E0,$39,$C9,$79,$C9,$39,$C9,$79,$D5,$39,$C9,$79,$D1,$39
	db $C9,$39,$C9,$79,$C8,$39,$D5,$39,$C9,$79,$D5,$39,$C9,$79,$C9,$39
	db $C9,$79,$C9,$39,$C9,$79

	db $01,$66,$00,$25
	db $E3,$39,$E1,$39,$E1,$39,$E3,$39,$E1,$39,$E3,$39,$F4,$39,$E3,$39
	db $E3,$39,$F4,$39,$C8,$39,$E3,$39,$F4,$39,$E3,$39,$F4,$19,$E3,$39
	db $F4,$39,$E3,$39,$EE,$39

	db $01,$86,$00,$25
	db $E3,$39,$E3,$39,$E3,$39,$E3,$39,$E3,$39,$E3,$39,$E8,$39,$E3,$39
	db $E3,$39,$E3,$39,$C8,$39,$E3,$39,$E8,$39,$E3,$39,$E8,$39,$E3,$39
	db $E3,$39,$EF,$39,$F0,$39

	db $01,$A6,$00,$25
	db $D2,$39,$D2,$39,$D2,$39,$E5,$39,$E6,$39,$D2,$39,$F3,$39,$D2,$39
	db $D2,$39,$D2,$39,$C8,$39,$D2,$39,$F3,$39,$D2,$39,$F3,$39,$D2,$39
	db $D2,$39,$F1,$39,$F6,$39

	db $01,$C6,$00,$27
	db $D7,$39,$D7,$39,$D7,$39,$D7,$39,$E7,$39,$D7,$39,$D7,$39,$D7,$39
	db $D3,$39,$D4,$39,$C8,$39,$D7,$39,$EC,$39,$D7,$39,$D7,$39,$D3,$39
	db $D4,$39,$D3,$39,$D4,$39,$F2,$39

	db $01,$E6,$40,$0E
	db $E4,$39

	db $01,$EE,$00,$17
	db $EA,$39,$EB,$39,$C7,$39,$E4,$39,$ED,$39,$E4,$39,$E4,$39,$EA,$39
	db $EB,$39,$EA,$39,$EB,$39,$E4,$39

	db $02,$08,$00,$25
	db $2F,$06,$01,$04,$09,$04,$08,$04,$05,$04,$24,$04,$01,$04,$09,$04
	db $09,$04,$03,$04,$24,$04,$17,$04,$12,$04,$17,$04,$1D,$04,$0E,$04
	db $17,$04,$0D,$04,$18,$04
if !Define_Global_ROMToAssemble&(!ROM_SMB1_U|!ROM_SMB1_E) == $00
	db $02,$4A,$00,$19
	db $01,$08,$24,$00,$19,$08,$15,$08,$0A,$08,$22,$08,$0E,$08,$1B,$08
	db $24,$00,$10,$08,$0A,$08,$16,$08,$0E,$08

	db $02,$8A,$00,$19
	db $02,$08,$24,$00,$19,$08,$15,$08,$0A,$08,$22,$08,$0E,$08,$1B,$08
	db $24,$00,$10,$08,$0A,$08,$16,$08,$0E,$08

	db $02,$EB,$00,$07
	db $1D,$08,$18,$08,$19,$08,$28,$08

	db $02,$F5,$00,$01
	db $00,$08
endif
endif

	db $FF,$FF

;--------------------------------------------------------------------

UNK_05DA70:
	db $00,$30

CODE_05DA72:
	PHB
	PHK
	PLB
	STY.b $00
	LDA.w $03B9
	LDX.w $039A,y
	LDY.w !RAM_SMB1_Level_SpriteOAMIndexTable+$01,x
	STY.b $02
	DEC
	JSR.w CODE_05DAFF
	LDA.w $03AE
	STA.w SMB1_OAMBuffer[$40].XDisp,y
	STA.w SMB1_OAMBuffer[$42].XDisp,y
	STA.w SMB1_OAMBuffer[$44].XDisp,y
	STA.w SMB1_OAMBuffer[$41].XDisp,y
	STA.w SMB1_OAMBuffer[$43].XDisp,y
	STA.w SMB1_OAMBuffer[$45].XDisp,y
	STA.w SMB1_OAMBuffer[$46].XDisp,y
	STA.w SMB1_OAMBuffer[$47].XDisp,y
	STA.w SMB1_OAMBuffer[$48].XDisp,y
	LDA.b #$1B
	STA.w SMB1_OAMBuffer[$40].Prop,y
	STA.w SMB1_OAMBuffer[$42].Prop,y
	STA.w SMB1_OAMBuffer[$44].Prop,y
	STA.w SMB1_OAMBuffer[$41].Prop,y
	STA.w SMB1_OAMBuffer[$43].Prop,y
	STA.w SMB1_OAMBuffer[$45].Prop,y
	STA.w SMB1_OAMBuffer[$46].Prop,y
	STA.w SMB1_OAMBuffer[$47].Prop,y
	STA.w SMB1_OAMBuffer[$48].Prop,y
	LDX.b #$08
CODE_05DAC3:
	LDA.b #$2C
	STA.w SMB1_OAMBuffer[$40].Tile,y
	INY
	INY
	INY
	INY
	DEX
	BPL.b CODE_05DAC3
	LDY.b $02
	LDA.w $0000
	BNE.b CODE_05DADB
	LDA.b #$2A
	STA.w SMB1_OAMBuffer[$40].Tile,y
CODE_05DADB:
	LDA.w $0399
	LSR
	LSR
	LSR
	LSR
	INC
	TAX
	ASL
	ASL
	CLC
	ADC.b $02
	TAY
CODE_05DAEA:
	CPX.b #$09
	BCS.b CODE_05DAFA
	LDA.b #$F0
	STA.w SMB1_OAMBuffer[$40].YDisp,y
	INY
	INY
	INY
	INY
	INX
	BRA.b CODE_05DAEA

CODE_05DAFA:
	LDY.w $0000
	PLB
	RTL

CODE_05DAFF:
	LDX.b #$09
CODE_05DB01:
	STA.w SMB1_OAMBuffer[$40].YDisp,y
	PHA
	LDA.w $0223
	STA.b !RAM_SMB1_Global_ScratchRAME4
	LDA.b $82
	STA.b !RAM_SMB1_Global_ScratchRAME5
	REP.b #$20
	LDA.b !RAM_SMB1_Global_ScratchRAME4
	SEC
	SBC.b $42
	STA.b !RAM_SMB1_Global_ScratchRAME4
	SEP.b #$20
	LDA.b #$02
	STA.b !RAM_SMB1_Global_ScratchRAMDD
	LDA.b !RAM_SMB1_Global_ScratchRAME5
	BEQ.b CODE_05DB23
	LDA.b #$01
CODE_05DB23:
	ORA.b !RAM_SMB1_Global_ScratchRAMDD
	STA.w SMB1_OAMTileSizeBuffer[$40].Slot,y
	LDA.w !RAM_SMB1_Level_GrowVineAtLevelEntranceFlag
	BNE.b CODE_05DB3B
	LDA.w SMB1_OAMBuffer[$40].YDisp,y
	BPL.b CODE_05DB3B
	CMP.b #$F0
	BCS.b CODE_05DB3B
	LDA.b #$F0
	STA.w SMB1_OAMBuffer[$40].YDisp,y
CODE_05DB3B:
	PLA
	CLC
	ADC.b #$10
	INY
	INY
	INY
	INY
	DEX
	BNE.b CODE_05DB01
	LDY.b $02
	RTS

;--------------------------------------------------------------------

; Note: Some routine related to score sprites?

CODE_05DB49:
	LDY.w !RAM_SMB1_Level_SpriteOAMIndexTable+$0E
	REP.b #$20
	LDA.w $0E70
	SEC
	SBC.b $42
	STA.w $0E6B
	SEP.b #$20
	LDA.w $0E6F
	BNE.b CODE_05DB89
	LDA.w $0E6D
	STA.w SMB1_OAMBuffer[$00].YDisp,y
	LDA.w $0E6B
	JSR.w CODE_05DCBA
	STA.w SMB1_OAMBuffer[$00].XDisp,y
	LDA.b #$26
	STA.w SMB1_OAMBuffer[$00].Tile,y
	LDA.b #$29
	STA.w SMB1_OAMBuffer[$00].Prop,y
	DEC.w $0E6E
	BEQ.b CODE_05DB7F
	JMP.w CODE_05DBC3

CODE_05DB7F:
	LDA.b #$06
	STA.w $0E6E
	INC.w $0E6F
	BRA.b CODE_05DBC3

CODE_05DB89:
	LDA.w $0E6F
	CMP.b #$06
	BCS.b CODE_05DBC3
	PHX
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_J1) != $00
	LDX.w $0E6F
	LDA.w DATA_05DC80,x
	CLC
	ADC.w $0E6B
	STA.w SMB1_OAMBuffer[$00].XDisp,y
	STA.w SMB1_OAMBuffer[$01].XDisp,y
	JSR.w CODE_05DCBA
	LDA.w DATA_05DC8C,x
	CLC
	ADC.w $0E6D
	STA.w SMB1_OAMBuffer[$00].YDisp,y
	CLC
	ADC.b #$08
	STA.w SMB1_OAMBuffer[$01].YDisp,y
	LDA.w DATA_05DC86,x
	CLC
	ADC.w $0E6B
	STA.w SMB1_OAMBuffer[$02].XDisp,y
	STA.w SMB1_OAMBuffer[$03].XDisp,y
	JSR.w CODE_05DCBA
	LDA.w DATA_05DC8C,x
	CLC
	ADC.w $0E6D
	STA.w SMB1_OAMBuffer[$02].YDisp,y
	CLC
	ADC.b #$08
	STA.w SMB1_OAMBuffer[$03].YDisp,y
else
	JSR.w CODE_05DBF5
endif
	LDX.w $0E6F
	DEX
	TXA
	ASL
	ASL
	TAX
	LDA.b #$03
	STA.b $04
CODE_05DBA0:
	LDA.w DATA_05DC92,x
	STA.w SMB1_OAMBuffer[$00].Tile,y
	LDA.w DATA_05DCA6,x
	STA.w SMB1_OAMBuffer[$00].Prop,y
	INY
	INY
	INY
	INY
	INX
	DEC.b $04
	BPL.b CODE_05DBA0
	DEC.w $0E6E
	BNE.b CODE_05DBC2
	LDA.b #$06
	STA.w $0E6E
	INC.w $0E6F
CODE_05DBC2:
	PLX
CODE_05DBC3:
	JMP.w CODE_05DD3A

CODE_05DBC6:
	LDA.b !RAM_SMB1_Global_FrameCounter
	LSR
	BCS.b CODE_05DBCE
	DEC.w !RAM_SMB1_HammerSpr_YPosLo,x
CODE_05DBCE:
	LDA.w !RAM_SMB1_HammerSpr_YPosLo,x
	STA.w SMB1_OAMBuffer[$00].YDisp,y
	LDA.w $03B3
	STA.w SMB1_OAMBuffer[$00].XDisp,y
	LDA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot,y
	CMP.b #$F8
	BCC.b CODE_05DBE8
	LDA.b #$03
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot,y
CODE_05DBE8:
	LDA.b #$23
	STA.w SMB1_OAMBuffer[$00].Prop,y
	LDA.b #$2E
	STA.w SMB1_OAMBuffer[$00].Tile,y
	JMP.w CODE_05DB49

if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_J1) == $00
CODE_05DBF5:
	LDX.w $0E6F
	REP.b #$20
	LDA.w DATA_05DC80,x
	AND.w #$00FF
	ORA.w #$FF00
	CLC
	ADC.w $0E6B
	SEP.b #$20
	STA.w SMB1_OAMBuffer[$00].XDisp,y
	STA.w SMB1_OAMBuffer[$01].XDisp,y
	JSR.w CODE_05DCBA
	XBA
	BEQ.b CODE_05DC1D
	LDA.b #$01
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$01].Slot,y
CODE_05DC1D:
	LDA.w DATA_05DC8C,x
	CLC
	ADC.w $0E6D
	STA.w SMB1_OAMBuffer[$00].YDisp,y
	CLC
	ADC.b #$08
	STA.w SMB1_OAMBuffer[$01].YDisp,y
	CMP.b #$F8
	BCS.b CODE_05DC3D
	CMP.b #$B0
	BCC.b CODE_05DC3D
	LDA.b #$F0
	STA.w SMB1_OAMBuffer[$00].YDisp,y
	STA.w SMB1_OAMBuffer[$01].YDisp,y
CODE_05DC3D:
	REP.b #$20
	LDA.w DATA_05DC86,x
	AND.w #$00FF
	CLC
	ADC.w $0E6B
	SEP.b #$20
	STA.w SMB1_OAMBuffer[$02].XDisp,y
	STA.w SMB1_OAMBuffer[$03].XDisp,y
	JSR.w CODE_05DCBA
	XBA
	BEQ.b CODE_05DC5F
	LDA.b #$01
	STA.w SMB1_OAMTileSizeBuffer[$02].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$03].Slot,y
CODE_05DC5F:
	LDA.w DATA_05DC8C,x
	CLC
	ADC.w $0E6D
	STA.w SMB1_OAMBuffer[$02].YDisp,y
	CLC
	ADC.b #$08
	STA.w SMB1_OAMBuffer[$03].YDisp,y
	CMP.b #$F8
	BCS.b CODE_05DC7F
	CMP.b #$B0
	BCC.b CODE_05DC7F
	LDA.b #$F0
	STA.w SMB1_OAMBuffer[$02].YDisp,y
	STA.w SMB1_OAMBuffer[$03].YDisp,y
CODE_05DC7F:
	RTS
endif

DATA_05DC80:
	db $00,$FC,$FB,$FA,$FA,$FA

DATA_05DC86:
	db $00,$04,$05,$06,$06,$06

DATA_05DC8C:
	db $00,$FC,$FC,$FE,$FE,$FF

DATA_05DC92:
	db $27,$27,$28,$28,$36,$37,$36,$37
	db $36,$37,$36,$37,$38,$29,$38,$29
	db $38,$29,$38,$29

DATA_05DCA6:
	db $29,$A9,$29,$A9,$29,$29,$69,$69
	db $29,$29,$69,$69,$29,$29,$69,$69
	db $29,$29,$69,$69

;--------------------------------------------------------------------

CODE_05DCBA:
	PHA
	CMP.b #$F8
	BCC.b CODE_05DCC7
	LDA.b #$01
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot,y
	STA.w SMB1_OAMTileSizeBuffer[$01].Slot,y
CODE_05DCC7:
	PLA
	RTS

;--------------------------------------------------------------------

CODE_05DCC9:
	LDA.w !RAM_SMB1_HammerSpr_YPosLo,x
	CLC
	ADC.b #$04
	STA.w $0E6D
	LDA.w !RAM_SMB1_HammerSpr_XPosLo,x
	STA.w $0E70
	LDA.w !RAM_SMB1_HammerSpr_XPosHi,x
	STA.w $0E71
	LDA.b #$06
	STA.w $0E6E
	STZ.w $0E6F
	RTL

;--------------------------------------------------------------------

DATA_05DCE7:
	db $28,$2A,$2C,$2E

SMB1_DrawSpinningCoinSprite:
.Main:
;$05DCEB
	PHB
	PHK
	PLB
	LDY.w !RAM_SMB1_Level_SpriteOAMIndexTable+$1D,x
	LDA.b $39,x
	CMP.b #$02
	BCC.b CODE_05DCFA
	JMP.w CODE_05DBC6

CODE_05DCFA:
	LDA.b !RAM_SMB1_CoinSpr_YSpeed,x
	BMI.b CODE_05DD01
	JMP.w CODE_05DB49

CODE_05DD01:
	LDA.w !RAM_SMB1_CoinSpr_YPosLo,x
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_J1) == $00
	CMP.b #$B0
	BCC.b CODE_05DD0A
	LDA.b #$F0
endif
CODE_05DD0A:
	STA.w SMB1_OAMBuffer[$00].YDisp,y
	LDA.w $03B3
	SEC
	SBC.b #$04
	STA.b !RAM_SMB1_Global_ScratchRAME4
	CMP.b #$F0
	BCS.b CODE_05DD1D
	LDA.b #$02
	BRA.b CODE_05DD1F

CODE_05DD1D:
	LDA.b #$03
CODE_05DD1F:
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot,y
	LDA.b !RAM_SMB1_Global_ScratchRAME4
	STA.w SMB1_OAMBuffer[$00].XDisp,y
	LDA.b !RAM_SMB1_Global_FrameCounter
	LSR
	AND.b #$03
	TAX
	LDA.w DATA_05DCE7,x
	STA.w SMB1_OAMBuffer[$00].Tile,y
	LDA.b #$28
	STA.w SMB1_OAMBuffer[$00].Prop,y
	LDX.b $9E
CODE_05DD3A:
	PLB
	RTL

;--------------------------------------------------------------------

DATA_05DD3C:
	db $04,$00,$04,$00

DATA_05DD40:
	db $00,$04,$00,$04,$00,$08,$00,$08
	db $08,$00,$08,$00

DATA_05DD4C:
	db $44,$46,$44,$46,$81,$83,$80,$82

DATA_05DD54:
	db $2A,$2A,$EA,$EA

SMB1_DrawHammerSprite:
.Main:
;$05DD58
	PHB
	PHK
	PLB
	LDY.w !RAM_SMB1_Level_SpriteOAMIndexTable+$1D,x
	LDA.w !RAM_SMB1_Level_FreezeSpritesTimer
	BNE.b CODE_05DD6B
	LDA.b $39,x
	AND.b #$7F
	CMP.b #$01
	BEQ.b CODE_05DD6F
CODE_05DD6B:
	LDX.b #$00
	BEQ.b CODE_05DD76

CODE_05DD6F:
	LDA.b !RAM_SMB1_Global_FrameCounter
	LSR
	LSR
	AND.b #$03
	TAX
CODE_05DD76:
	LDA.w $03BE
	CLC
	ADC.w DATA_05DD40,x
	STA.w SMB1_OAMBuffer[$00].YDisp,y
	REP.b #$20
	LDA.w DATA_05DD3C,x
	AND.w #$00FF
	CLC
	ADC.w $0E93
	SEC
	SBC.w #$0008
	STA.b !RAM_SMB1_Global_ScratchRAME4
	SEP.b #$20
	LDA.b !RAM_SMB1_Global_ScratchRAME4
	STA.w SMB1_OAMBuffer[$00].XDisp,y
	LDA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot,y
	LDA.b !RAM_SMB1_Global_ScratchRAME5
	BEQ.b CODE_05DDA7
	LDA.b #$03
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot,y
CODE_05DDA7:
	LDA.w DATA_05DD4C,x
	STA.w SMB1_OAMBuffer[$00].Tile,y
	LDA.w DATA_05DD54,x
	STA.w SMB1_OAMBuffer[$00].Prop,y
	LDA.w $03D6
	AND.b #$0F
	CMP.b #$0F
	BEQ.b CODE_05DDC3
	LDA.w $03D6
	AND.b #$F0
	BEQ.b CODE_05DDC7
CODE_05DDC3:
	LDX.b $9E
	STZ.b $39,x
CODE_05DDC7:
	LDX.b $9E
	PLB
	RTL

;--------------------------------------------------------------------

	%ROUTINE_SMB1_CompressOAMTileSizeBuffer(NULLROM)			; $05DDCB

;--------------------------------------------------------------------

CODE_05DE25:
	INC.w $0B76
	LDA.b #SMB1_PauseMenuGFX_Main>>16
	STA.w !RAM_SMB1_Global_GraphicsUploadPointerBank
	REP.b #$20
	LDA.w #SMB1_PauseMenuGFX_Main
	STA.w !RAM_SMB1_Global_GraphicsUploadPointerLo
	LDA.w #SMB1_PauseMenuGFX_End-SMB1_PauseMenuGFX_Main
	STA.w !RAM_SMB1_Global_GraphicsUploadSizeLo
	LDA.w #$7C00
	STA.w !RAM_SMB1_Global_GraphicsUploadVRAMAddressLo
	SEP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_05DE44:
	INC.w $0B76
	LDA.b #SMBLL_UncompressedGFX_Sprite_GlobalTiles+$3800>>16
	STA.w !RAM_SMB1_Global_GraphicsUploadPointerBank
	REP.b #$20
	LDA.w #SMBLL_UncompressedGFX_Sprite_GlobalTiles+$3800
	STA.w !RAM_SMB1_Global_GraphicsUploadPointerLo
	LDA.w #$0800
	STA.w !RAM_SMB1_Global_GraphicsUploadSizeLo
	LDA.w #$7C00
	STA.w !RAM_SMB1_Global_GraphicsUploadVRAMAddressLo
	SEP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_05DE63:
	PHX
	PHY
	JSR.w CODE_05E282
	JSR.w CODE_05E21F
	LDA.b #$22
	STA.w !RAM_SMB1_Global_BG1And2WindowMaskSettingsMirror
	LDA.b #$02
	STA.w !RAM_SMB1_Global_BG3And4WindowMaskSettingsMirror
	LDA.b #$15
	STA.w !RAM_SMB1_Global_MainScreenWindowMaskMirror
	LDA.b #$02
	STA.w !RAM_SMB1_Global_SubScreenWindowMaskMirror
	PLY
	PLX
	RTL

;--------------------------------------------------------------------

CODE_05DE82:
	JSR.w CODE_05E282
	JSR.w CODE_05E21F
	JSR.w CODE_05DEB6
	JSR.w CODE_05DE25
	LDA.b #$01
	STA.w !RAM_SMB1_Global_DisplayPauseMenuFlag
	STZ.w $0B77
	STZ.w !RAM_SMB1_Global_BlinkingCursorFrameCounter
	STZ.w $0F8A
	RTL

;--------------------------------------------------------------------

; Note: Seems to be related to the pause menu

CODE_05DE9D:
	PHB
	PHK
	PLB
	PHX
	PHY
	LDA.w $0B75
	ASL
	TAX
	JSR.w (DATA_05DEAE,x)
	PLY
	PLX
	PLB
	RTL

DATA_05DEAE:
	dw CODE_05E104
	dw CODE_05DEE8
	dw CODE_05E200
	dw CODE_05E16E

;--------------------------------------------------------------------

CODE_05DEB6:
	REP.b #$20
	LDA.w #$0010
	STA.w $0B6B
	LDA.w #$0064
	STA.w $0B6D
	LDA.w #$00A4
	STA.w $0B6F
	LDA.w #$00C4
	STA.w $0B71
	LDA.w #$00D0
	STA.w $0B73
	SEP.b #$20
	LDA.w $1680
	BEQ.b CODE_05DEE7
	LDA.w !RAM_SMB1_Level_TwoPlayerGameFlag
	BEQ.b CODE_05DEE7
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMB1_J) != $00
	LDA.b #$9E
	STA.w $0B6F
	LDA.b #$C8
	STA.w $0B71
else
	LDA.b #$0E
	STA.w $0B6B
endif
CODE_05DEE7:
	RTS

;--------------------------------------------------------------------

CODE_05DEE8:
	JSR.w SMB1_DrawPauseMenuLetters_Main
	LDX.w !RAM_SMB1_Player_CurrentCharacter
	LDA.w $1680
	BEQ.b CODE_05DF01
	LDA.w !RAM_SMB1_Level_TwoPlayerGameFlag
	BEQ.b CODE_05DF01
	LDA.w !RAM_SMB1_Player_OtherPlayersLifeCount
	BMI.b CODE_05DF01
	TXA
	EOR.b #$01
	TAX
CODE_05DF01:
	LDA.w !RAM_SMB1_Global_ControllerPress1P1,x
	STA.b !RAM_SMB1_Global_ScratchRAMF2
	AND.b #(!Joypad_DPadU>>8)|(!Joypad_DPadD>>8)|(!Joypad_Select>>8)
	BNE.b CODE_05DF0D
	JMP.w CODE_05DF5E

CODE_05DF0D:
	LDA.b !RAM_SMB1_Global_ScratchRAMF2
	AND.b #!Joypad_Select>>8
	BNE.b CODE_05DF49
	LDA.b !RAM_SMB1_Global_ScratchRAMF2
	AND.b #!Joypad_DPadU>>8
	BNE.b CODE_05DF32
	INC.w $0B77
	LDA.w $0B77
	CMP.b #$03
	BCC.b CODE_05DF28
	DEC.w $0B77
	BRA.b CODE_05DF5E

CODE_05DF28:
	LDA.b #!Define_SMAS_Sound0063_Coin
	STA.w !RAM_SMB1_Global_SoundCh3
	STZ.w !RAM_SMB1_Global_BlinkingCursorFrameCounter
	BRA.b CODE_05DF5E

CODE_05DF32:
	DEC.w $0B77
	LDA.w $0B77
	BPL.b CODE_05DF3F
	INC.w $0B77
	BRA.b CODE_05DF5E

CODE_05DF3F:
	LDA.b #!Define_SMAS_Sound0063_Coin
	STA.w !RAM_SMB1_Global_SoundCh3
	STZ.w !RAM_SMB1_Global_BlinkingCursorFrameCounter
	BRA.b CODE_05DF5E

CODE_05DF49:
	INC.w $0B77
	LDA.w $0B77
	CMP.b #$03
	BCC.b CODE_05DF56
	STZ.w $0B77
CODE_05DF56:
	LDA.b #!Define_SMAS_Sound0063_Coin
	STA.w !RAM_SMB1_Global_SoundCh3
	STZ.w !RAM_SMB1_Global_BlinkingCursorFrameCounter
CODE_05DF5E:
	LDA.b #$4C
	STA.w SMB1_OAMBuffer[$00].XDisp
	LDX.w $0B77
	LDA.w DATA_05DFFA,x
	STA.w SMB1_OAMBuffer[$00].YDisp
	LDA.w !RAM_SMB1_Global_BlinkingCursorFrameCounter
	AND.b #$10
	LSR
	LSR
	LSR
	LSR
	TAX
	LDA.w DATA_05DFFD,x
	STA.w SMB1_OAMBuffer[$00].Tile
	LDA.b #$21
	STA.w SMB1_OAMBuffer[$00].Prop
	LDA.b #$00
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot
	INC.w !RAM_SMB1_Global_BlinkingCursorFrameCounter
	LDA.b !RAM_SMB1_Global_ScratchRAMF2
	AND.b #!Joypad_Start>>8
	BEQ.b CODE_05DFF9
	LDA.b #!Define_SMB1_LevelMusic_RestoreVolumeCommand
	STA.w !RAM_SMB1_Global_MusicCh1
	STZ.w !RAM_SMB1_Global_BlinkingCursorFrameCounter
	LDA.w $0B77
	BEQ.b CODE_05DFB9
	LDA.b #$30
	STA.w $0F8A
	LDA.b #$02
	STA.w $0B75
	LDA.b #!Define_SMAS_Sound0060_SaveGame
	STA.w !RAM_SMB1_Global_SoundCh1
	LDA.w $0B77
	CMP.b #$02
	BNE.b CODE_05DFCD
	LDA.b #!Define_SMB1_LevelMusic_CopyOfMusicFade
	STA.w !RAM_SMB1_Global_MusicCh1
	BRA.b CODE_05DFCD

CODE_05DFB9:
	LDA.b #$10
	STA.w $0F8A
	LDA.b #$10
	STA.w $0B6B
	LDA.b #$02
	STA.w $0B75
	LDA.b #!Define_SMAS_Sound0060_Pause1
	STA.w !RAM_SMB1_Global_SoundCh1
CODE_05DFCD:
	LDA.w $1680
	BEQ.b CODE_05DFEB
	LDA.w $0B77
	CMP.b #$02
	BEQ.b CODE_05DFEB
	STZ.w !RAM_SMB1_Global_DisplayPauseMenuFlag
	LDA.b #$0E
	STA.w $0772
	LDX.w $0B77
	BEQ.b CODE_05DFEA
	JSL.l SMB1_SaveGame_Main
CODE_05DFEA:
	RTS

CODE_05DFEB:
	LDA.b #$20
	STA.w $0F8A
	LDA.w $0B77
	BEQ.b CODE_05DFF9
	JSL.l SMB1_SaveGame_Main
CODE_05DFF9:
	RTS

;--------------------------------------------------------------------

DATA_05DFFA:
	db $50,$60,$70

DATA_05DFFD:
	db $D0,$DE

DATA_05DFFF:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMB1_J) != $00
	db $AA,$AA,$0C,$AA,$AA,$AA,$0C,$AA,$AA,$0C,$AA,$AA,$00,$01,$02,$03
	db $0A,$0B,$04,$AA,$05,$05,$06,$07,$AA,$AA,$0C,$AA,$AA,$AA,$AA,$0C
	db $AA,$AA,$AA,$AA,$00,$01,$02,$03,$04,$AA,$05,$05,$06,$07,$AA,$AA
	db $AA,$AA,$0C,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$00,$01,$02,$03
	db $04,$AA,$08,$09,$07,$AA,$AA,$AA,$FF
else
	db $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$14,$15,$16
	db $17,$18,$19,$1A,$1B,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	db $AA,$AA,$AA,$AA,$AA,$AA,$AA,$28,$29,$2A,$2B,$1C,$14,$15,$16,$17
	db $18,$19,$1A,$1B,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	db $AA,$28,$29,$2A,$2B,$1C,$24,$25,$26,$27,$AA,$AA,$AA,$AA,$FF
endif

SMB1_DrawPauseMenuLetters:
.Main:
;$05E04E
	REP.b #$10
	LDY.w #$0010
	LDX.w #$0000
	LDA.b #$48
	STA.b $01
CODE_05E05A:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMB1_J) != $00
	LDA.b #$58
else
	LDA.b #$54
endif
	STA.b $00
CODE_05E05E:
	LDA.w DATA_05DFFF,x
	BPL.b CODE_05E07B
	INX
	INC
	BEQ.b CODE_05E09C
CODE_05E067:
	LDA.b $00
	CLC
	ADC.b #$08
	STA.b $00
	CMP.b #$B8
	BCC.b CODE_05E05E
	LDA.b $01
	CLC
	ADC.b #$08
	STA.b $01
	BRA.b CODE_05E05A

CODE_05E07B:
	CLC
	ADC.b #$C0
	STA.w SMB1_OAMBuffer[$00].Tile,y
	LDA.b $00
	STA.w SMB1_OAMBuffer[$00].XDisp,y
	LDA.b $01
	STA.w SMB1_OAMBuffer[$00].YDisp,y
	LDA.b #$21
	STA.w SMB1_OAMBuffer[$00].Prop,y
	LDA.b #$00
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot,y
	INX
	INY
	INY
	INY
	INY
	BRA.b CODE_05E067

CODE_05E09C:
	LDA.b #$40
	STA.b $01
CODE_05E0A0:
	LDA.b #$40
	STA.b $00
CODE_05E0A4:
	LDA.b $00
	STA.w SMB1_OAMBuffer[$00].XDisp,y
	CLC
	ADC.b #$10
	STA.b $00
	LDA.b $01
	STA.w SMB1_OAMBuffer[$00].YDisp,y
	LDA.b #$CD
	STA.w SMB1_OAMBuffer[$00].Tile,y
	LDA.b #$21
	STA.w SMB1_OAMBuffer[$00].Prop,y
	LDA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot,y
	INY
	INY
	INY
	INY
	LDA.b $00
	CMP.b #$C0
	BCC.b CODE_05E0A4
	LDA.b $01
	CMP.b #$80
	BCS.b CODE_05E0D9
	CLC
	ADC.b #$10
	STA.b $01
	BRA.b CODE_05E0A0

CODE_05E0D9:
	SEP.b #$10
	LDA.b #$4C
	STA.w SMB1_OAMBuffer[$00].XDisp
	LDX.w $0B77
	LDA.w DATA_05DFFA,x
	STA.w SMB1_OAMBuffer[$00].YDisp
	LDA.w !RAM_SMB1_Global_BlinkingCursorFrameCounter
	AND.b #$10
	LSR
	LSR
	LSR
	LSR
	TAX
	LDA.w DATA_05DFFD,x
	STA.w SMB1_OAMBuffer[$00].Tile
	LDA.b #$21
	STA.w SMB1_OAMBuffer[$00].Prop
	LDA.b #$00
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot
	RTS

;--------------------------------------------------------------------

CODE_05E104:
	LDA.w $0B6B
	BEQ.b CODE_05E167
	BMI.b CODE_05E167
	REP.b #$30
	DEC.w $0B6B
	DEC.w $0B6D
	DEC.w $0B6D
	INC.w $0B6F
	INC.w $0B6F
	DEC.w $0B71
	DEC.w $0B71
	DEC.w $0B71
	DEC.w $0B71
	INC.w $0B73
	INC.w $0B73
	INC.w $0B73
	INC.w $0B73
	LDX.w #$007E
	LDA.w #$00FF
CODE_05E13A:
	STA.l $7FF000,x
	STA.l $7FF080,x
	STA.l $7FF100,x
	STA.l $7FF180,x
	DEX
	DEX
	BPL.b CODE_05E13A
	LDA.w $0B6F
	XBA
	ORA.w $0B6D
	LDX.w $0B71
CODE_05E158:
	STA.l $7FF000,x
	INX
	INX
	CPX.w $0B73
	BNE.b CODE_05E158
	SEP.b #$30
	BRA.b CODE_05E16A

CODE_05E167:
	INC.w $0B75
CODE_05E16A:
	JSR.w SMB1_DrawPauseMenuLetters_Main
	RTS

;--------------------------------------------------------------------

CODE_05E16E:
	LDA.w $0B6B
	BEQ.b CODE_05E1D1
	BMI.b CODE_05E1D1
	REP.b #$30
	INC.w $0B6D
	INC.w $0B6D
	DEC.w $0B6F
	DEC.w $0B6F
	INC.w $0B71
	INC.w $0B71
	INC.w $0B71
	INC.w $0B71
	DEC.w $0B73
	DEC.w $0B73
	DEC.w $0B73
	DEC.w $0B73
	DEC.w $0B6B
	LDX.w #$007E
	LDA.w #$00FF
CODE_05E1A4:
	STA.l $7FF000,x
	STA.l $7FF080,x
	STA.l $7FF100,x
	STA.l $7FF180,x
	DEX
	DEX
	BPL.b CODE_05E1A4
	LDA.w $0B6F
	XBA
	ORA.w $0B6D
	LDX.w $0B71
CODE_05E1C2:
	STA.l $7FF000,x
	INX
	INX
	CPX.w $0B73
	BNE.b CODE_05E1C2
	SEP.b #$30
	BRA.b CODE_05E1FC

CODE_05E1D1:
	STZ.w $0B75
	LDA.b #$0F
	STA.w !RAM_SMB1_Global_ScreenDisplayRegisterMirror
	STZ.w !RAM_SMB1_Global_DisplayPauseMenuFlag
	LDA.w !RAM_SMB1_Global_ObjectAndColorWindowSettingsMirror
	EOR.b #$03
	STA.w !RAM_SMB1_Global_ObjectAndColorWindowSettingsMirror
	LDA.w !RAM_SMB1_Global_MainScreenWindowMaskMirror
	EOR.b #$10
	STA.w !RAM_SMB1_Global_MainScreenWindowMaskMirror
	JSR.w CODE_05DE44
	JSL.l CODE_0385BF
	LDA.w !RAM_SMB1_Global_HDMAEnableMirror
	AND.b #$F7
	STA.w !RAM_SMB1_Global_HDMAEnableMirror
	RTS

CODE_05E1FC:
	JSR.w SMB1_DrawPauseMenuLetters_Main
	RTS

;--------------------------------------------------------------------

CODE_05E200:
	DEC.w $0F8A
	BNE.b CODE_05E21B
	INC.w $0B75
	LDA.b #$10
	STA.w $0B6B
	STA.w $0F8A
	LDA.w $0B77
	CMP.b #$02
	BNE.b CODE_05E21B
if !Define_Global_ROMToAssemble&(!ROM_SMB1_U|!ROM_SMB1_E|!ROM_SMB1_J) != $00
	JML.l SMB1_ResetGame_Main
else
	JML.l SMAS_ResetToSMASTitleScreen_Main				; Note: Call to SMAS function
endif

CODE_05E21B:
	JSR.w SMB1_DrawPauseMenuLetters_Main
	RTS

;--------------------------------------------------------------------

CODE_05E21F:
	PHB
	LDA.b #$7FF000>>16
	PHA
	PLB
	REP.b #$30
	LDX.w #$007E
	LDA.w #$0000
CODE_05E22C:
	STA.w $7FF000,x
	STA.w $7FF080,x
	STA.w $7FF100,x
	STA.w $7FF180,x
	DEX
	DEX
	BPL.b CODE_05E22C
	PLB
	SEP.b #$20
	LDX.w #(!REGISTER_Window1LeftPositionDesignation&$0000FF<<8)+$41
	STX.w HDMA[$03].Parameters
	LDX.w #DATA_05E27B
	STX.w HDMA[$03].SourceLo
	LDA.b #DATA_05E27B>>16
	STA.w HDMA[$03].SourceBank
	LDA.b #$7FF000>>16
	STA.w HDMA[$03].IndirectSourceBank
	LDA.b #$00
	STA.w !RAM_SMB1_Global_BG1And2WindowMaskSettingsMirror
	STZ.w !RAM_SMB1_Global_BG3And4WindowMaskSettingsMirror
	LDA.w !RAM_SMB1_Global_ObjectAndColorWindowSettingsMirror
	ORA.b #$03
	STA.w !RAM_SMB1_Global_ObjectAndColorWindowSettingsMirror
	LDA.w !RAM_SMB1_Global_MainScreenWindowMaskMirror
	ORA.b #$10
	STA.w !RAM_SMB1_Global_MainScreenWindowMaskMirror
	STZ.w !RAM_SMB1_Global_SubScreenWindowMaskMirror
	SEP.b #$10
	LDA.w !RAM_SMB1_Global_HDMAEnableMirror
	ORA.b #$08
	STA.w !RAM_SMB1_Global_HDMAEnableMirror
	RTS

DATA_05E27B:
	db $F8 : dw $7FF000
	db $F8 : dw $7FF0F0
	db $00

;--------------------------------------------------------------------

CODE_05E282:
	PHB
	LDA.b #$7FF000>>16
	PHA
	PLB
	REP.b #$30
	LDX.w #$01A0
CODE_05E28C:
	LDA.w #$00FF
	STA.w $7FF000,x
	STA.w $7FF002,x
	STA.w $7FF004,x
	STA.w $7FF006,x
	STA.w $7FF008,x
	STA.w $7FF00A,x
	STA.w $7FF00C,x
	STA.w $7FF00E,x
	STA.w $7FF010,x
	STA.w $7FF012,x
	STA.w $7FF014,x
	STA.w $7FF016,x
	STA.w $7FF018,x
	STA.w $7FF01A,x
	STA.w $7FF01C,x
	STA.w $7FF01E,x
	STA.w $7FF200,x
	STA.w $7FF202,x
	STA.w $7FF204,x
	STA.w $7FF206,x
	STA.w $7FF208,x
	STA.w $7FF20A,x
	STA.w $7FF20C,x
	STA.w $7FF20E,x
	STA.w $7FF210,x
	STA.w $7FF212,x
	STA.w $7FF214,x
	STA.w $7FF216,x
	STA.w $7FF218,x
	STA.w $7FF21A,x
	STA.w $7FF21C,x
	STA.w $7FF21E,x
	TXA
	SEC
	SBC.w #$0020
	TAX
	BPL.b CODE_05E28C
	SEP.b #$30
	PLB
	RTS

;--------------------------------------------------------------------

SMB1_DrawPlayerBreathBubbleSprite:
.Main:
;$05E2FB
	LDA.w $02F7
	BNE.b CODE_05E32F
	LDY.b !RAM_SMB1_Player_YPosHi
	DEY
	BNE.b CODE_05E32F
	LDA.w $03D3
	AND.b #$08
	BNE.b CODE_05E32F
	LDY.w !RAM_SMB1_Level_SpriteOAMIndexTable+$0E,x
	LDA.w $03B0
	STA.w SMB1_OAMBuffer[$00].XDisp,y
	LDA.w $03BB
	STA.w SMB1_OAMBuffer[$00].YDisp,y
	LDA.b #$9F
	STA.w SMB1_OAMBuffer[$00].Tile,y
	LDA.b !RAM_SMB1_Player_CurrentState
	CMP.b #$07
	BNE.b CODE_05E32A
	LDA.b #$0A
	BRA.b CODE_05E32C

CODE_05E32A:
	LDA.b #$2A
CODE_05E32C:
	STA.w SMB1_OAMBuffer[$00].Prop,y
CODE_05E32F:
	RTL

;--------------------------------------------------------------------

; Note: Palette animation routine.

DATA_05E330:
	dw $1BDF,$027F,$0139
	dw $0000,$4BFF,$1F5F
	dw $0D9C,$0000,$7FFF
	dw $4BFF,$19FF,$0000

DATA_05E348:
	dw $1ADA,$0DF3,$050D
	dw $0000,$2B5E,$1E77
	dw $1170,$0000,$3BDF
	dw $2EFB,$1DD3,$0000

DATA_05E360:
	dw $477F,$3298,$15B1
	dw $0000,$671B,$4A34
	dw $2D4D,$0000,$7E97
	dw $6DB0,$54EA,$0000

DATA_05E378:
	dw $035F,$0259,$3800
	dw $0000,$03FF,$02BC
	dw $0016,$0000,$7FFF
	dw $47FF,$00DF,$0000

DATA_05E390:									; Note: The last 4 bytes of each row aren't used.
	dw $2CC5,$3D89,$3DCD,$4E51,$2EF8,$1E74,$1C41,$28A3
	dw $28A4,$3548,$3D8B,$4A0F,$32D6,$1E31,$1C41,$28A3
	dw $2062,$2CC6,$3927,$418B,$3250,$21AB,$1C41,$28A3
	dw $2483,$3107,$3949,$45CD,$3293,$1DEE,$1C41,$28A3
	dw $2062,$2CC6,$3927,$418B,$3250,$21AB,$1C41,$28A3
	dw $2483,$3107,$3949,$45CD,$3293,$1DEE,$1C41,$28A3
	dw $28A4,$3548,$3D8B,$4A0F,$32D6,$1E31,$1C41,$28A3
	dw $2CC5,$3D89,$3DCD,$4E51,$2EF8,$1E74,$1C41,$28A3

SMB1_HandlePaletteAnimations:
.Main:
;$05E410
	INC.w !RAM_SMB1_Global_PaletteAnimationFrameCounter
	LDA.w !RAM_SMB1_Global_PaletteAnimationFrameCounter
	AND.b #$07
	BEQ.b CODE_05E41D
	JMP.w CODE_05E492

CODE_05E41D:
	INC.w !RAM_SMB1_Global_CoinPaletteAnimationFrameCounter
	LDA.w !RAM_SMB1_Global_CoinPaletteAnimationFrameCounter
	CMP.b #$03
	BNE.b CODE_05E42C
	STZ.w !RAM_SMB1_Global_CoinPaletteAnimationFrameCounter
	LDA.b #$00
CODE_05E42C:
	ASL
	ASL
	ASL
	TAX
	REP.b #$20
	LDA.w DATA_05E330,x
	STA.w SMB1_PaletteMirror[$13].LowByte
	LDA.w DATA_05E378,x
	STA.w SMB1_PaletteMirror[$05].LowByte
	LDA.w DATA_05E348,x
	STA.w SMB1_PaletteMirror[$16].LowByte
	LDA.w DATA_05E330+$02,x
	STA.w SMB1_PaletteMirror[$14].LowByte
	LDA.w DATA_05E378+$02,x
	STA.w SMB1_PaletteMirror[$06].LowByte
	LDA.w DATA_05E348+$02,x
	STA.w SMB1_PaletteMirror[$17].LowByte
	LDA.w DATA_05E330+$04,x
	STA.w SMB1_PaletteMirror[$15].LowByte
	LDA.w DATA_05E378+$04,x
	STA.w SMB1_PaletteMirror[$07].LowByte
	LDA.w DATA_05E348+$04,x
	STA.w SMB1_PaletteMirror[$18].LowByte
	SEP.b #$20
	LDA.w $0E20
	BNE.b CODE_05E492
	LDA.b $DB
	BEQ.b CODE_05E4C7
	CMP.b #$1B
	BEQ.b CODE_05E4C7
	CMP.b #$21
	BNE.b CODE_05E47E
	JMP.w CODE_05E5D8

CODE_05E47E:
	CMP.b #$09
	BEQ.b CODE_05E4C9
	CMP.b #$19
	BEQ.b CODE_05E48A
	CMP.b #$1A
	BNE.b CODE_05E48D
CODE_05E48A:
	JMP.w CODE_05E4F6

CODE_05E48D:
	LDA.b #$01
	STA.w !RAM_SMB1_Global_UpdateEntirePaletteFlag
CODE_05E492:
	LDA.w !RAM_SMB1_Global_PaletteAnimationFrameCounter
	AND.b #$03
	BNE.b CODE_05E4C7
	INC.w $0E76
	LDA.w $0E76
	CMP.b #$03
	BNE.b CODE_05E4A8
	STZ.w $0E76
	LDA.b #$00
CODE_05E4A8:
	ASL
	ASL
	ASL
	TAX
	REP.b #$20
	LDA.w DATA_05E360,x
	STA.w SMB1_PaletteMirror[$19].LowByte
	LDA.w DATA_05E360+$02,x
	STA.w SMB1_PaletteMirror[$1A].LowByte
	LDA.w DATA_05E360+$04,x
	STA.w SMB1_PaletteMirror[$1B].LowByte
	SEP.b #$20
	LDA.b #$01
	STA.w !RAM_SMB1_Global_UpdateEntirePaletteFlag
CODE_05E4C7:
	PLB
	RTL

CODE_05E4C9:
	LDA.w !RAM_SMB1_Global_PaletteAnimationFrameCounter
	AND.b #$38
	LSR
	LSR
	TAX
	REP.b #$20
	LDA.w DATA_05E528,x
	STA.w SMB1_PaletteMirror[$73].LowByte
	LDA.w DATA_05E538,x
	STA.w SMB1_PaletteMirror[$74].LowByte
	LDA.w DATA_05E548,x
	STA.w SMB1_PaletteMirror[$7D].LowByte
	LDA.w DATA_05E558,x
	STA.w SMB1_PaletteMirror[$7E].LowByte
	LDA.w DATA_05E568,x
	STA.w SMB1_PaletteMirror[$7F].LowByte
	SEP.b #$20
	JMP.w CODE_05E48D

CODE_05E4F6:								; Note: Underground palette animation
	LDA.w !RAM_SMB1_Global_PaletteAnimationFrameCounter
	AND.b #$38
	ASL
	TAX
	REP.b #$20
	LDA.w DATA_05E390,x
	STA.w SMB1_PaletteMirror[$73].LowByte
	LDA.w DATA_05E390+$02,x
	STA.w SMB1_PaletteMirror[$74].LowByte
	LDA.w DATA_05E390+$04,x
	STA.w SMB1_PaletteMirror[$75].LowByte
	LDA.w DATA_05E390+$06,x
	STA.w SMB1_PaletteMirror[$76].LowByte
	LDA.w DATA_05E390+$08,x
	STA.w SMB1_PaletteMirror[$77].LowByte
	LDA.w DATA_05E390+$0A,x
	STA.w SMB1_PaletteMirror[$78].LowByte
	SEP.b #$20
	JMP.w CODE_05E48D

DATA_05E528:
	dw $7FBF,$7F38,$76B4,$7230,$7FBF,$7F38,$76B4,$7230

DATA_05E538:
	dw $7F38,$76B4,$7230,$7FBF,$7F38,$76B4,$7230,$7FBF

DATA_05E548:
	dw $76B4,$7230,$7FBF,$7F38,$76B4,$7230,$7FBF,$7F38

DATA_05E558:
	dw $69C9,$6187,$5945,$5103,$69C9,$69C9,$69C9,$5946

DATA_05E568:
	dw $7230,$7FBF,$7F38,$76B4,$7230,$7FBF,$7F38,$76B4

DATA_05E578:
	dw $0C63,$1CE5,$2927,$2506
	dw $0C63,$1D07,$252A,$2109
	dw $0C63,$1929,$212C,$1D2B
	dw $0C63,$1D07,$252A,$2109
	dw $0C63,$1CE5,$2927,$2506
	dw $0C63,$1D07,$252A,$2109
	dw $0C63,$1929,$212C,$1D2B
	dw $0C63,$1D07,$252A,$2109

DATA_05E5B8:
	dw $0077,$017A,$0098,$019B
	dw $00B9,$01BC,$00FB,$01FE
	dw $00DA,$01DD,$00B9,$01BC
	dw $0098,$019B,$0077,$017A

CODE_05E5D8:						; Note: Routine that creates the thunder effect in 8-4
	LDA.w !RAM_SMB1_Global_PaletteAnimationFrameCounter
	AND.b #$38
	TAX
	LSR
	TAY
	REP.b #$20
	LDA.w DATA_05E578,x
	STA.w SMB1_PaletteMirror[$71].LowByte
	LDA.w DATA_05E578+$02,x
	STA.w SMB1_PaletteMirror[$72].LowByte
	LDA.w DATA_05E578+$04,x
	STA.w SMB1_PaletteMirror[$73].LowByte
	LDA.w DATA_05E578+$06,x
	STA.w SMB1_PaletteMirror[$74].LowByte
	LDA.w DATA_05E5B8,y
	STA.w SMB1_PaletteMirror[$7E].LowByte
	LDA.w DATA_05E5B8+$02,y
	STA.w SMB1_PaletteMirror[$7F].LowByte
	SEP.b #$20
	LDA.b !RAM_SMB1_NorSpr_SpriteID
	CMP.b #!Define_SMB1_SpriteID_NorSpr035_PeachAndToad
	BEQ.b CODE_05E682
	LDA.w $0EB7
	BNE.b CODE_05E637
	LDA.w !RAM_SMB1_Global_RandomByte2
	AND.b #$0F
	BNE.b CODE_05E682
	LDA.b !RAM_SMB1_Player_CurrentState
	CMP.b #$08
	BNE.b CODE_05E625
	LDA.b #!Define_SMAS_Sound0063_Thunder
	STA.w !RAM_SMB1_Global_SoundCh3
CODE_05E625:
	LDA.b #$11
	STA.w $0EB8
	LDA.b #$1F
	STA.w $0EB9
	STA.w $0EBA
	INC.w $0EB7
	BRA.b CODE_05E65F

CODE_05E637:
	DEC.w $0EB8
	DEC.w $0EB9
	DEC.w $0EB9
	DEC.w $0EBA
	DEC.w $0EBA
	DEC.w $0EB8
	DEC.w $0EB9
	DEC.w $0EB9
	DEC.w $0EBA
	DEC.w $0EBA
	LDA.w $0EB8
	CMP.b #$03
	BNE.b CODE_05E65F
	STZ.w $0EB7
CODE_05E65F:
	REP.b #$20
	LDA.w $0EB8
	AND.w #$00FF
	XBA
	ASL
	ASL
	STA.b !RAM_SMB1_Global_ScratchRAME4
	LDA.w $0EB9
	AND.w #$00FF
	XBA
	LSR
	LSR
	LSR
	ORA.b !RAM_SMB1_Global_ScratchRAME4
	ORA.w $0EBA
	STA.b !RAM_SMB1_Global_ScratchRAME4
	STA.w SMB1_PaletteMirror[$71].LowByte
	SEP.b #$20
CODE_05E682:
	JMP.w CODE_05E48D

;--------------------------------------------------------------------

SMB1_LevelTileAnimations:
.Main:
;$05E685
	LDA.w $0B76
	BNE.b CODE_05E6FF
	STZ.w $028D
	LDA.b !RAM_SMB1_Global_FrameCounter
	AND.b #$07
	BNE.b CODE_05E6CB
	LDA.b !RAM_SMB1_Global_FrameCounter
	AND.b #$38
	LSR
	LSR
	LSR
	STA.b $04
	LDA.b #SMB1_UncompressedGFX_AnimatedTiles>>16
	STA.w !RAM_SMB1_Global_GraphicsUploadPointerBank
	REP.b #$20
	LDA.w #SMB1_UncompressedGFX_AnimatedTiles&$8000
	LDY.b $04
CODE_05E6A8:
	DEY
	BMI.b CODE_05E6B1
	CLC
	ADC.w #$0800
	BRA.b CODE_05E6A8

CODE_05E6B1:
	CLC
	ADC.w #SMB1_UncompressedGFX_AnimatedTiles-$8000
	STA.w !RAM_SMB1_Global_GraphicsUploadPointerLo
	LDA.w #$1C00
	STA.w !RAM_SMB1_Global_GraphicsUploadVRAMAddressLo
	LDA.w #$0600
	STA.w !RAM_SMB1_Global_GraphicsUploadSizeLo
	SEP.b #$20
	INC.w $028D
	BRA.b CODE_05E6FF

CODE_05E6CB:
	LDA.b !RAM_SMB1_Global_FrameCounter
	CLC
	ADC.b #$04
	STA.w !RAM_SMB1_Global_GraphicsUploadPointerLo
	AND.b #$07
	BNE.b CODE_05E6FF
	LDA.b #SMB1_UncompressedGFX_Layer3>>16
	STA.w !RAM_SMB1_Global_GraphicsUploadPointerBank
	REP.b #$20
	LDA.w !RAM_SMB1_Global_GraphicsUploadPointerLo
	AND.w #$0038
	ASL
	ASL
	ASL
	CLC
	ADC.w #SMB1_UncompressedGFX_Layer3+$0300
	STA.w !RAM_SMB1_Global_GraphicsUploadPointerLo
	LDA.w #$5160
	STA.w !RAM_SMB1_Global_GraphicsUploadVRAMAddressLo
	LDA.w #$0040
	STA.w !RAM_SMB1_Global_GraphicsUploadSizeLo
	SEP.b #$20
	INC.w $028D
CODE_05E6FF:
	RTL

;--------------------------------------------------------------------

DATA_05E700:
	db $01,$18

CODE_05E702:
	SEP.b #$30
	PHB
	PHK
	PLB
	LDA.b $99
	CMP.b #$01
	BNE.b CODE_05E718
	STA.w $02F8
	LDX.w !RAM_SMB1_Player_CurrentCharacter
	LDA.w DATA_05E700,x
	STA.b $99
CODE_05E718:
	JSR.w SMB1_UploadTilesetGraphicsRt_Main
	LDA.b $99
	ASL
	TAX
	LDA.w DATA_05E72C,x
	STA.b $00
	LDA.w DATA_05E72C+$01,x
	STA.b $01
	JMP.w ($0000)

DATA_05E72C:
	dw CODE_05E76C
	dw CODE_05E78D
	dw CODE_05E778
	dw CODE_05E78D
	dw CODE_05E7A0
	dw CODE_05E778
	dw CODE_05E76C
	dw CODE_05E794
	dw CODE_05E76C
	dw CODE_05E794
	dw CODE_05E7AC
	dw CODE_05E778
	dw CODE_05E778
	dw CODE_05E76C
	dw CODE_05E778
	dw CODE_05E76C
	dw CODE_05E778
	dw CODE_05E76C
	dw CODE_05E76C
	dw CODE_05E76C
	dw CODE_05E76C
	dw CODE_05E76C
	dw CODE_05E76C
	dw CODE_05E76C
	dw CODE_05E78D
	dw CODE_05E76C
	dw CODE_05E76C
	dw CODE_05E76C
	dw CODE_05E76C
	dw CODE_05E76C
	dw CODE_05E76C
	dw CODE_05E76C

;--------------------------------------------------------------------

CODE_05E76C:
	STZ.b $99
	PLB
	STZ.w $028D
	LDA.b #$01
	STA.w $028C
	RTL

;--------------------------------------------------------------------

CODE_05E778:
	LDA.b $DB
	CMP.b #$16
	BEQ.b CODE_05E799
	CMP.b #$14
	BEQ.b CODE_05E799
	CMP.b #$0D
	BEQ.b CODE_05E799
	LDA.b #$17
	JSR.w SMB1_UploadTilesetGraphicsRt_Main
	BRA.b CODE_05E76C

CODE_05E78D:
	LDA.b #$11
	JSR.w SMB1_UploadTilesetGraphicsRt_Main
	BRA.b CODE_05E76C

CODE_05E794:
	LDA.b #$16
	JSR.w SMB1_UploadTilesetGraphicsRt_Main
CODE_05E799:
	LDA.b #$12
	JSR.w SMB1_UploadTilesetGraphicsRt_Main
	BRA.b CODE_05E76C

CODE_05E7A0:
	LDA.b #$13
	JSR.w SMB1_UploadTilesetGraphicsRt_Main
	LDA.b #$14
	JSR.w SMB1_UploadTilesetGraphicsRt_Main
	BRA.b CODE_05E76C

CODE_05E7AC:
	LDA.b #$15
	JSR.w SMB1_UploadTilesetGraphicsRt_Main
	BRA.b CODE_05E76C

;--------------------------------------------------------------------

DATA_05E7B3:
	dw $000000>>16,SMB1_UncompressedGFX_BG_BonusRoom_Mario>>16,SMB1_UncompressedGFX_BG_HillsAndTrees>>16,SMB1_UncompressedGFX_BG_Cave>>16,SMB1_UncompressedGFX_FG_BG_Castle>>16,SMB1_UncompressedGFX_BG_DottedHills>>16,SMB1_UncompressedGFX_FG_BG_Castle>>16,SMB1_UncompressedGFX_BG_HillsAndTrees>>16
	dw SMB1_UncompressedGFX_BG_Underwater>>16,SMB1_UncompressedGFX_BG_HillsAndTrees>>16,SMB1_UncompressedGFX_BG_DeathScreen1>>16,SMB1_UncompressedGFX_BG_Night>>16,SMB1_UncompressedGFX_BG_Castle>>16,SMB1_UncompressedGFX_BG_Mushrooms>>16,SMB1_UncompressedGFX_BG_Waterfalls>>16,SMB1_UncompressedGFX_BG_UnderwaterCastle>>16
	dw SMB1_UncompressedGFX_BG_Pillars>>16,SMB1_UncompressedGFX_FG_Cave>>16,SMB1_UncompressedGFX_FG_Snow>>16,SMB1_UncompressedGFX_BG_FinalCastle1>>16,SMB1_UncompressedGFX_BG_FinalCastle2>>16,SMB1_UncompressedGFX_BG_DeathScreen2>>16,SMB1_UncompressedGFX_BG_Night>>16,SMB1_UncompressedGFX_FG_Grassland>>16
	dw SMB1_UncompressedGFX_BG_BonusRoom_Luigi>>16

DATA_05E7E5:
	dw $000000,SMB1_UncompressedGFX_BG_BonusRoom_Mario,SMB1_UncompressedGFX_BG_HillsAndTrees,SMB1_UncompressedGFX_BG_Cave,SMB1_UncompressedGFX_FG_BG_Castle,SMB1_UncompressedGFX_BG_DottedHills,SMB1_UncompressedGFX_FG_BG_Castle,SMB1_UncompressedGFX_BG_HillsAndTrees
	dw SMB1_UncompressedGFX_BG_Underwater,SMB1_UncompressedGFX_BG_HillsAndTrees,SMB1_UncompressedGFX_BG_DeathScreen1,SMB1_UncompressedGFX_BG_Night,SMB1_UncompressedGFX_BG_Castle,SMB1_UncompressedGFX_BG_Mushrooms,SMB1_UncompressedGFX_BG_Waterfalls,SMB1_UncompressedGFX_BG_UnderwaterCastle
	dw SMB1_UncompressedGFX_BG_Pillars,SMB1_UncompressedGFX_FG_Cave,SMB1_UncompressedGFX_FG_Snow,SMB1_UncompressedGFX_BG_FinalCastle1,SMB1_UncompressedGFX_BG_FinalCastle2,SMB1_UncompressedGFX_BG_DeathScreen2,SMB1_UncompressedGFX_BG_Night,SMB1_UncompressedGFX_FG_Grassland
	dw SMB1_UncompressedGFX_BG_BonusRoom_Luigi

DATA_05E817:
	dw $0000,$2000,$2000,$2000,$2000,$2C00,$2000,$2000
	dw $2000,$2000,$3400,$2C00,$2800,$2C00,$2C00,$2000
	dw $2C00,$3000,$3000,$2000,$2800,$2C00,$2C00,$3000
	dw $2000

DATA_05E849:
	dw $1000,$1000,$2000,$1000,$2000,$0800,$2000,$1000
	dw $1000,$2000,$2000,$0800,$1000,$0800,$0800,$1000
	dw $1000,$1000,$1000,$0800,$0800,$0800,$0800,$1000
	dw $1000

SMB1_UploadTilesetGraphicsRt:
.Main:
;$05E87B
	ASL
	TAX
	LDA.w DATA_05E7B3,x
	STA.w !RAM_SMB1_Global_GraphicsUploadPointerBank
	REP.b #$20
	LDA.w DATA_05E7E5,x
	STA.w !RAM_SMB1_Global_GraphicsUploadPointerLo
	LDA.w DATA_05E817,x
	STA.w !RAM_SMB1_Global_GraphicsUploadVRAMAddressLo
	LDA.w DATA_05E849,x
	STA.w !RAM_SMB1_Global_GraphicsUploadSizeLo
	SEP.b #$20
	JSR.w CODE_05E89D
	RTS

CODE_05E89D:
	LDA.b #$80
	STA.w !REGISTER_VRAMAddressIncrementValue
	REP.b #$20
	LDA.w !RAM_SMB1_Global_GraphicsUploadVRAMAddressLo
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STA.w DMA[$00].Parameters
	LDA.w !RAM_SMB1_Global_GraphicsUploadPointerLo
	STA.w DMA[$00].SourceLo
	LDX.w !RAM_SMB1_Global_GraphicsUploadPointerBank
	STX.w DMA[$00].SourceBank
	LDA.w !RAM_SMB1_Global_GraphicsUploadSizeLo
	STA.w DMA[$00].SizeLo
	LDX.b #$01
	STX.w !REGISTER_DMAEnable
	SEP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_05E8CA:
	PHB
	PHK
	PLB
	STZ.w $0F49
	PHX
	LDX.b $9E
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr004_StationaryGreenKoopa
	BCS.b CODE_05E8E1
	LDA.b !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	BMI.b CODE_05E8E5
	AND.b #$06
	BEQ.b CODE_05E8E5
CODE_05E8E1:
	PLX
	PLB
	CLC
	RTL

CODE_05E8E5:
	LDA.w !RAM_SMB1_NorSpr_SpriteStatusFlags,x
	STA.b !RAM_SMB1_Global_ScratchRAME0
	CMP.b #$02
	BEQ.b CODE_05E8F6
	CMP.b #$03
	BEQ.b CODE_05E8F6
	CMP.b #$04
	BNE.b CODE_05E8FB
CODE_05E8F6:
	STZ.w $0F40,x
	BRA.b CODE_05E908

CODE_05E8FB:
	AND.b #$80
	BEQ.b CODE_05E8E1
	LDA.b !RAM_SMB1_Player_CurrentState
	CMP.b #$0A
	BCS.b CODE_05E908
	INC.w $0F40,x
CODE_05E908:
	LDA.w $0F40,x
	AND.b #$0C
	STA.b !RAM_SMB1_Global_ScratchRAME4
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	LDX.b !RAM_SMB1_Global_ScratchRAME4
	CMP.b #!Define_SMB1_SpriteID_NorSpr002_BuzzyBeetle
	BNE.b CODE_05E91C
	TXA
	CLC
	ADC.b #$10
	TAX
CODE_05E91C:
	LDA.b !RAM_SMB1_Global_ScratchRAME0
	AND.b #$0F
	CMP.b #$04
	BNE.b CODE_05E92D
	TXA
	CLC
	ADC.b #$20
	TAX
	LDA.b #$80
	TSB.b $04
CODE_05E92D:
	TYA
	CLC
	ADC.b #$08
	TAY
	LDA.w $03B9
	CLC
	ADC.b #$08
	CMP.b #$F0
	BCC.b CODE_05E93E
	LDA.b #$F0
CODE_05E93E:
	PHA
	LDA.b $04
	BPL.b CODE_05E949
	PLA
	CLC
	ADC.b #$02
	BRA.b CODE_05E94A

CODE_05E949:
	PLA
CODE_05E94A:
	JSR.w CODE_05EA10
	LDA.b $04
	BPL.b CODE_05E959
	LDA.w $03B9
	CLC
	ADC.b #$12
	BRA.b CODE_05E95F

CODE_05E959:
	LDA.w $03B9
	CLC
	ADC.b #$10
CODE_05E95F:
	JSR.w CODE_05EA10
	LDX.b !RAM_SMB1_Global_ScratchRAME4
	LDA.w DATA_05EA79,x
	ORA.b $04
	STA.w SMB1_OAMBuffer[$3C].Prop,y
	LDA.w DATA_05EA79+$01,x
	ORA.b $04
	STA.w SMB1_OAMBuffer[$3D].Prop,y
	LDA.w DATA_05EA79+$02,x
	ORA.b $04
	STA.w SMB1_OAMBuffer[$3E].Prop,y
	LDA.w DATA_05EA79+$03,x
	ORA.b $04
	STA.w SMB1_OAMBuffer[$3F].Prop,y
	INC.w $0F49
	PLX
	PLB
	SEC
	RTL

;--------------------------------------------------------------------

DATA_05E98B:
	db $00,$FC,$F9,$F7,$F5,$F4,$F3,$F2
	db $F2,$F2,$F3,$F4,$F5,$F7,$F9,$FC
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00

CODE_05E9AB:
	PHB
	PHK
	PLB
	PHX
	LDX.b $9E
	LDA.b !RAM_SMB1_NorSpr_SpriteID,x
	CMP.b #!Define_SMB1_SpriteID_NorSpr035_PeachAndToad
	BNE.b CODE_05E9FF
	LDA.w !RAM_SMB1_Player_CurrentWorld
	CMP.b #$07
	BEQ.b CODE_05E9FF
	LDA.w $0F4A
	AND.b #$1F
	LDY.w !RAM_SMB1_Level_SpriteOAMIndexTable+$01,x
	PHY
	TAX
	LDA.w DATA_05E98B,x
	STA.b !RAM_SMB1_Global_ScratchRAMDD
	JSR.w CODE_05EA02
	JSR.w CODE_05EA02
	JSR.w CODE_05EA02
	JSR.w CODE_05EA02
	JSR.w CODE_05EA02
	JSR.w CODE_05EA02
	PLY
	CPX.b #$10
	BCS.b CODE_05E9FC
	LDA.b #$FF
	STA.w SMB1_OAMBuffer[$40].Tile,y
	STA.w SMB1_OAMBuffer[$41].Tile,y
	LDA.b #$D7
	STA.w SMB1_OAMBuffer[$42].Tile,y
	STA.w SMB1_OAMBuffer[$43].Tile,y
	LDA.b #$EE
	STA.w SMB1_OAMBuffer[$44].Tile,y
	STA.w SMB1_OAMBuffer[$45].Tile,y
CODE_05E9FC:
	INC.w $0F4A
CODE_05E9FF:
	PLX
	PLB
	RTL

;--------------------------------------------------------------------

CODE_05EA02:
	LDA.w SMB1_OAMBuffer[$40].YDisp,y
	CLC
	ADC.b !RAM_SMB1_Global_ScratchRAMDD
	STA.w SMB1_OAMBuffer[$40].YDisp,y
	INY
	INY
	INY
	INY
	RTS

;--------------------------------------------------------------------

CODE_05EA10:
	STA.w SMB1_OAMBuffer[$40].YDisp,y
	STA.w SMB1_OAMBuffer[$41].YDisp,y
	LDA.w $03AE
	STA.w SMB1_OAMBuffer[$40].XDisp,y
	CLC
	ADC.b #$08
	STA.w SMB1_OAMBuffer[$41].XDisp,y
	LDA.w DATA_05EA39,x
	STA.w SMB1_OAMBuffer[$40].Tile,y
	LDA.w DATA_05EA39+$01,x
	STA.w SMB1_OAMBuffer[$41].Tile,y
	INY
	INY
	INY
	INY
	INY
	INY
	INY
	INY
	INX
	INX
	RTS

DATA_05EA39:
	db $6E,$6E,$6F,$6F
	db $C2,$C4,$C3,$C5
	db $C0,$C0,$C1,$C1
	db $C4,$C2,$C5,$C3
	db $F5,$F5,$F4,$F4
	db $80,$82,$81,$83
	db $68,$68,$90,$90
	db $82,$80,$83,$81
	db $6F,$6F,$6E,$6E
	db $C3,$C5,$C2,$C4
	db $C1,$C1,$C0,$C0
	db $C5,$C3,$C4,$C2
	db $F4,$F4,$F5,$F5
	db $81,$83,$80,$82
	db $90,$90,$68,$68
	db $83,$81,$82,$80

DATA_05EA79:
	db $00,$40,$00,$40
	db $00,$00,$00,$00
	db $00,$40,$00,$40
	db $40,$40,$40,$40

;--------------------------------------------------------------------

; Note: Something podoboo related

CODE_05EA89:
	LDA.w !RAM_SMB1_Level_SpriteOAMIndexTable+$01,x
	TAY
	LDA.w $03AE
	STA.w SMB1_OAMBuffer[$40].XDisp,y
	LDA.w !RAM_SMB1_NorSpr_YPosHi,x
	CMP.b #$02
	BCS.b CODE_05EAA1
	LDA.w $03B9
	CMP.b #$E8
	BCC.b CODE_05EAA3
CODE_05EAA1:
	LDA.b #$F0
CODE_05EAA3:
	STA.w SMB1_OAMBuffer[$40].YDisp,y
	LDA.w !RAM_SMB1_NorSpr_YSpeed,x
	BMI.b CODE_05EAAF
	LDA.b #$A9
	BRA.b CODE_05EAB1

CODE_05EAAF:
	LDA.b #$29
CODE_05EAB1:
	STA.w SMB1_OAMBuffer[$40].Prop,y
	LDA.w !RAM_SMB1_NorSpr00C_Podoboo_AnimationFrameCounter
	AND.b #$18
	LSR
	LSR
	CLC
	ADC.b #$62
	STA.w SMB1_OAMBuffer[$40].Tile,y
	LDA.w !RAM_SMB1_NorSpr_XPosLo,x
	STA.b !RAM_SMB1_Global_ScratchRAME4
	LDA.b !RAM_SMB1_NorSpr_XPosHi,x
	STA.b !RAM_SMB1_Global_ScratchRAME5
	REP.b #$20
	LDA.b !RAM_SMB1_Global_ScratchRAME4
	SEC
	SBC.b $42
	STA.b !RAM_SMB1_Global_ScratchRAME6
	SEP.b #$20
	LDA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$40].Slot,y
	LDA.b !RAM_SMB1_Global_ScratchRAME7
	BEQ.b CODE_05EAE3
	LDA.b #$03
	STA.w SMB1_OAMTileSizeBuffer[$40].Slot,y
CODE_05EAE3:
	RTL

;--------------------------------------------------------------------

DATA_05EAE4:
	db $F9,$0E,$F7,$0E,$FA,$FB,$F8,$FB
	db $F6,$FB

DATA_05EAEE:
	db $20,$22,$24

SMB1_DrawFlagSpriteTile:
.Main:
;$05EAF1
	PHB
	PHK
	PLB
	LDY.b #$F0
	LDA.w !RAM_SMB1_NorSpr_XPosLo,x
	STA.b !RAM_SMB1_Global_ScratchRAME4
	LDA.b !RAM_SMB1_NorSpr_XPosHi,x
	STA.b !RAM_SMB1_Global_ScratchRAME5
	REP.b #$20
	LDA.b !RAM_SMB1_Global_ScratchRAME4
	CLC
	ADC.w #$0010
	SEC
	SBC.b $42
	STA.b !RAM_SMB1_Global_ScratchRAME4
	CLC
	ADC.w #$0004
	STA.b !RAM_SMB1_Global_ScratchRAME6
	CLC
	ADC.w #$0008
	STA.b !RAM_SMB1_Global_ScratchRAME8
	SEP.b #$20
	LDA.b !RAM_SMB1_Global_ScratchRAME4
	STA.w SMB1_OAMBuffer[$00].XDisp,y
	LDA.w !RAM_SMB1_NorSpr_YPosLo,x
	STA.w SMB1_OAMBuffer[$00].YDisp,y
	LDA.b #$2B
	STA.w SMB1_OAMBuffer[$00].Prop,y
	LDA.b !RAM_SMB1_Global_FrameCounter
	AND.b #$18
	LSR
	LSR
	LSR
	PHX
	TAX
	CPX.b #$03
	BNE.b CODE_05EB39
	LDX.b #$01
CODE_05EB39:
	LDA.w DATA_05EAEE,x
	STA.w SMB1_OAMBuffer[$00].Tile,y
	PLX
	LDA.w $070F
	BEQ.b CODE_05EB7A
	LDA.w !RAM_SMB1_Level_GoalFlagScoreAmountIndex
	ASL
	TAX
	LDA.b !RAM_SMB1_Global_ScratchRAME6
	STA.w SMB1_OAMBuffer[$01].XDisp,y
	LDA.b !RAM_SMB1_Global_ScratchRAME8
	STA.w SMB1_OAMBuffer[$02].XDisp,y
	LDA.w !RAM_SMB1_Level_GoalFlagScoreYPosLo
	STA.w SMB1_OAMBuffer[$01].YDisp,y
	STA.w SMB1_OAMBuffer[$02].YDisp,y
	LDA.w DATA_05EAE4,x
	STA.w SMB1_OAMBuffer[$01].Tile,y
	LDA.w DATA_05EAE4+$01,x
	STA.w SMB1_OAMBuffer[$02].Tile,y
	LDA.b #$22
	STA.w SMB1_OAMBuffer[$01].Prop,y
	STA.w SMB1_OAMBuffer[$02].Prop,y
	CPX.b #$04
	BCS.b CODE_05EB7A
	LDA.b #$23
	STA.w SMB1_OAMBuffer[$02].Prop,y
CODE_05EB7A:
	LDA.b #$02
	STA.b !RAM_SMB1_Global_ScratchRAMDD
	LDA.b !RAM_SMB1_Global_ScratchRAME5
	BEQ.b CODE_05EB84
	LDA.b #$01
CODE_05EB84:
	ORA.b !RAM_SMB1_Global_ScratchRAMDD
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot,y
	STZ.b !RAM_SMB1_Global_ScratchRAMDD
	LDA.b !RAM_SMB1_Global_ScratchRAME7
	BEQ.b CODE_05EB91
	LDA.b #$01
CODE_05EB91:
	ORA.b !RAM_SMB1_Global_ScratchRAMDD
	STA.w SMB1_OAMTileSizeBuffer[$01].Slot,y
	CPX.b #$04
	BCS.b CODE_05EB9E
	LDA.b #$02
	STA.b !RAM_SMB1_Global_ScratchRAMDD
CODE_05EB9E:
	LDA.b !RAM_SMB1_Global_ScratchRAME9
	BEQ.b CODE_05EBA4
	LDA.b #$01
CODE_05EBA4:
	ORA.b !RAM_SMB1_Global_ScratchRAMDD
	STA.w SMB1_OAMTileSizeBuffer[$02].Slot,y
	PLB
	RTL

;--------------------------------------------------------------------

CODE_05EBAB:
	PHB
	PHK
	PLB
	LDA.w !RAM_SMB1_Player_HardModeActiveFlag
	STA.l !SRAM_SMB1_Global_CopyOfHardModeActiveFlag
	LDA.w !RAM_SMB1_Player_CurrentWorld
	STA.l !SRAM_SMB1_Global_CopyOfCurrentWorld
	LDA.b #$01
	STA.w $0F0B
	LDA.b #$01
	STA.w !RAM_SMB1_Player_HardModeActiveFlag
	STA.w !RAM_SMB1_Level_CanFindHidden1upFlag
	STA.w $07FB
	STA.w !RAM_SMB1_Global_UseHardModeEnemyBehaviorFlag
	STA.l !RAM_SMB1_Global_SaveBuffer_HardModeActiveFlag
	LDA.b #!Define_SMB1_LevelMusic_MusicFade
	STA.w !RAM_SMB1_Global_MusicCh1
	STZ.w !RAM_SMB1_Player_CurrentWorld
	STZ.w !RAM_SMB1_Player_CurrentLevel
	STZ.w !RAM_SMB1_Player_CurrentLevelNumberDisplay
	STZ.w !RAM_SMB1_Player_CurrentStartingScreen
	STZ.w $0F0B
	PLB
	JSL.l CODE_03A287
	RTL

;--------------------------------------------------------------------

; Note: Level intro sprite data?

DATA_05EBED:							; Info:
	db $FF,$FF,$FF,$FF,$FF					; Null
	db $FF,$06,$FF,$00,$FF
	db $FF,$06,$00,$01,$FF
	db $06,$FF,$0F,$FF,$01
	db $FF,$FF,$FF,$FF,$16
	db $06,$FF,$0E,$FF,$00
	db $0A,$FF,$0B,$FF,$07
	db $FF,$FF,$14,$FF,$FF
	db $FF,$FF,$FF,$FF,$16
	db $06,$00,$FF,$0E,$05
	db $00,$FF,$0E,$FF,$06
	db $06,$FF,$0F,$FF,$00
	db $FF,$FF,$FF,$FF,$16
	db $FF,$FF,$12,$FF,$FF
	db $FF,$00,$02,$06,$FF
	db $FF,$03,$FF,$0F,$FF
	db $FF,$FF,$FF,$FF,$16
	db $00,$06,$FF,$0E,$08
	db $00,$02,$08,$04,$05
	db $03,$08,$FF,$0F,$06
	db $FF,$FF,$FF,$FF,$16
	db $FF,$FF,$12,$FF,$FF
	db $00,$02,$FF,$0E,$06
	db $FF,$FF,$08,$FF,$FF
	db $FF,$FF,$FF,$FF,$16
	db $00,$0E,$05,$08,$02
	db $0A,$FF,$0B,$FF,$07
	db $00,$0E,$FF,$14,$03
	db $FF,$FF,$FF,$FF,$16
	db $00,$02,$FF,$0E,$06
	db $02,$0E,$12,$08,$06
	db $00,$08,$FF,$0E,$05
	db $FF,$FF,$FF,$FF,$16

DATA_05EC92:
	db $FF,$FF,$FF,$FF,$FF
	db $FF,$02,$FF,$00,$FF
	db $FF,$02,$00,$01,$FF
	db $03,$08,$FF,$0F,$02
	db $FF,$FF,$FF,$FF,$16
	db $02,$FF,$0E,$FF,$00
	db $0A,$FF,$0B,$FF,$07
	db $00,$0E,$FF,$14,$03
	db $FF,$FF,$FF,$FF,$16
	db $02,$00,$FF,$0E,$05
	db $00,$FF,$0E,$FF,$02
	db $02,$FF,$0F,$FF,$00
	db $FF,$FF,$FF,$FF,$16
	db $FF,$FF,$12,$FF,$FF
	db $FF,$00,$FF,$02,$FF
	db $FF,$03,$FF,$0F,$FF
	db $FF,$FF,$FF,$FF,$16
	db $00,$02,$FF,$0E,$08
	db $00,$02,$08,$04,$05
	db $03,$08,$FF,$0F,$02
	db $FF,$FF,$FF,$FF,$16
	db $FF,$FF,$12,$FF,$FF
	db $00,$02,$FF,$0E,$06
	db $FF,$FF,$08,$FF,$FF
	db $FF,$FF,$FF,$FF,$16
	db $00,$0E,$05,$08,$02
	db $0A,$FF,$0B,$FF,$07
	db $00,$0E,$FF,$14,$03
	db $FF,$FF,$FF,$FF,$16
	db $FF,$02,$00,$0E,$FF
	db $02,$0E,$12,$08,$FF
	db $00,$08,$FF,$0E,$05
	db $FF,$FF,$FF,$FF,$16

DATA_05ED37:							; Info:
	db $01,$02,$02,$06,$03					; World 1
	db $07,$00,$00,$05,$03					; World 2
	db $18,$18,$16,$03,$03					; World 3
	db $01,$02,$02,$04,$03					; World 4
	db $08,$08,$06,$03,$03					; World 5
	db $11,$11,$16,$03,$03					; World 6
	db $08,$00,$00,$05,$03					; World 7
	db $07,$07,$07,$03,$03					; World 8
	db $00,$00,$00,$00,$00					; World 9?

DATA_05ED64:		; Note: Indexes for which image to load for the level intros?
	db $01,$02,$02,$03,$04					; World 1
	db $05,$06,$06,$07,$08					; World 2
	db $09,$0A,$0B,$0C,$00					; World 3
	db $0D,$0E,$0E,$0F,$10					; World 4
	db $11,$12,$13,$14,$00					; World 5
	db $15,$16,$17,$18,$00					; World 6
	db $19,$1A,$1A,$1B,$1C					; World 7
	db $1D,$1E,$1F,$20,$00					; World 8
	db $21,$22,$23,$24,$00					; World 9?

;--------------------------------------------------------------------

DATA_05ED91:					; Note: Player palettes
	dw $0000,$7FFF,$0C63,$0155,$1A1C,$1B3E,$2D9C,$3ABF,$0000,$152F,$0014,$0C19,$1C9F,$762E,$5D68,$44E6
	dw $45BC,$14A5,$7FFF,$023F,$01DB,$0136,$3ABF,$2D9C,$0000,$5B3F,$6976,$50F0,$3C8B,$0136,$01DB,$023F
	dw $45BC,$7FFF,$14A5,$0092,$0098,$009F,$2D9C,$3ABF,$0000,$152F,$2C95,$413A,$55DF,$031F,$027A,$01D5
	dw $45BC,$14A5,$7FFF,$55DF,$413A,$2C95,$3ABF,$2D9C,$0000,$5B3F,$217F,$14D9,$0453,$0200,$02E0,$03E0
	dw $0000,$7FFF,$0C63,$0155,$1A1C,$1B3E,$2D9C,$3ABF,$0000,$152F,$1E60,$3304,$4388,$7655,$7190
	db $CA

;--------------------------------------------------------------------

DATA_05EE30:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	db $58,$01,$80,$01,$80,$01,$80,$41,$42,$C2,$42,$81,$41,$81,$01,$81
	db $01,$81,$01,$02,$82

DATA_05EE45:
	db $00,$7A,$10,$10,$05,$28,$0C,$1C,$10,$50,$10,$10,$18,$20,$20,$30
	db $50,$40,$30,$10,$0C

DATA_05EE5B:
	db $FF,$01,$80,$01,$02,$01,$80,$01,$80,$01,$02,$80,$02,$80,$01,$80
	db $01,$80,$01,$80,$01,$02,$01

DATA_05EE72:
	db $00,$A0,$08,$08,$40,$30,$10,$08,$10,$18,$1C,$20,$58,$10,$40,$38
	db $40,$20,$50,$30,$30,$48,$80,$FF,$00
else
	db $58,$01,$80,$02,$81,$41,$80,$01,$42,$C2,$02,$80,$41,$C1,$41,$C1
	db $01,$C1,$01,$02,$80

DATA_05EE45:
	db $00,$9B,$10,$18,$05,$2C,$20,$1C,$0E,$60,$10,$20,$28,$30,$20,$10
	db $80,$20,$30,$2C,$01,$FF

DATA_05EE5B:
	db $00,$01,$80,$01,$02,$01,$80,$01,$80,$01,$02,$80,$02,$80,$01,$80
	db $01,$80,$01,$80,$01,$02,$01

DATA_05EE72:
	db $00,$A0,$08,$08,$40,$30,$10,$08,$10,$18,$1C,$20,$58,$10,$40,$38
	db $40,$20,$50,$30,$30,$48,$80,$FF,$00
endif

;--------------------------------------------------------------------

CODE_05EE8B:
	PHD
	LDA.b #$0700>>8
	XBA
	LDA.b #$0700
	TCD
	LDX.b #$05
	LDA.b !RAM_SMB1_Player_CurrentCharacter
	BEQ.b CODE_05EE9A
	LDX.b #$0B
CODE_05EE9A:
	LDY.b #$05
	SEC
CODE_05EE9D:
	LDA.b !RAM_SMB1_Player_MariosScoreMillionsDigit,x
	SBC.w !RAM_SMB1_TitleScreen_TopScoreMillionsDigit,y
	DEX
	DEY
	BPL.b CODE_05EE9D
	BCC.b CODE_05EEB5
	INX
	INY
CODE_05EEAA:
	LDA.b !RAM_SMB1_Player_MariosScoreMillionsDigit,x
	STA.w !RAM_SMB1_TitleScreen_TopScoreMillionsDigit,y
	INX
	INY
	CPY.b #$06
	BCC.b CODE_05EEAA
CODE_05EEB5:
	PLD
	RTL

if !Define_Global_ROMToAssemble&(!ROM_SMAS_U) != $00
	%FREE_BYTES(NULLROM, 4506, $FF)
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_E) != $00
	%FREE_BYTES(NULLROM, 4426, $FF)
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1) != $00
	%FREE_BYTES(NULLROM, 4515, $FF)
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J2) != $00
	%FREE_BYTES(NULLROM, 4434, $FF)
elseif !Define_Global_ROMToAssemble&(!ROM_SMB1_U) != $00
	%FREE_BYTES(NULLROM, 4503, $FF)
%BANK_END(<EndBank>)
elseif !Define_Global_ROMToAssemble&(!ROM_SMB1_E) != $00
	%FREE_BYTES(NULLROM, 4504, $FF)
%BANK_END(<EndBank>)
elseif !Define_Global_ROMToAssemble&(!ROM_SMB1_J) != $00
	%FREE_BYTES(NULLROM, 4512, $FF)
%BANK_END(<EndBank>)
elseif !Define_Global_ROMToAssemble&(!ROM_SMASW_E) != $00
	%FREE_BYTES(NULLROM, 330, $FF)
else
	%FREE_BYTES(NULLROM, 329, $FF)
endif
endmacro

;#############################################################################################################
;#############################################################################################################

macro SMB1Bank06Macros(StartBank, EndBank)
%BANK_START(<StartBank>)
SMB1_UncompressedGFX_FG_GlobalTiles:
;$068000
if !Define_Global_ROMToAssemble&(!ROM_SMB1_U|!ROM_SMB1_E|!ROM_SMB1_J) != $00
	%InsertVersionExclusiveFile(incbin, ../SMB1/Graphics/GFX_FG_SMB1_GlobalTiles_, USA.bin, )
else
	%InsertVersionExclusiveFile(incbin, ../SMB1/Graphics/GFX_FG_SMB1_GlobalTiles_, SMASU.bin, )
endif

SMB1_UncompressedGFX_BG_HillsAndTrees:
;$06A000
	incbin "Graphics/GFX_BG_HillsAndTrees.bin"

SMB1_UncompressedGFX_FG_TitleLogo:
;$06B000
	incbin "Graphics/GFX_FG_SMB1_TitleLogo.bin"
.End:

SMB1_UncompressedGFX_AnimatedTiles:
;$06C000
	incbin "Graphics/GFX_SMB1_AnimatedTiles.bin"
%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro SMB1Bank07Macros(StartBank, EndBank)
;%BANK_START(<StartBank>)
SMB1_UncompressedGFX_Sprite_GlobalTiles:
;$078000
	incbin "Graphics/GFX_Sprite_GlobalTiles.bin"
.End:

	%SetDuplicateOrNullPointer(SMB1_UncompressedGFX_Sprite_GlobalTiles, SMBLL_UncompressedGFX_Sprite_GlobalTiles)
;%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro SMB1Bank08Macros(StartBank, EndBank)
%BANK_START(<StartBank>)
SMB1_UncompressedGFX_BG_Underwater:
;$088000
	incbin "Graphics/GFX_BG_Underwater.bin"

SMB1_UncompressedGFX_BG_Mushrooms:
;$089000
	incbin "Graphics/GFX_BG_Mushrooms.bin"

SMB1_UncompressedGFX_BG_DottedHills:
;$089800
	incbin "Graphics/GFX_BG_DottedHills.bin"

SMB1_UncompressedGFX_BG_Castle:
;$08A000
	incbin "Graphics/GFX_BG_Castle.bin"

SMB1_UncompressedGFX_BG_Waterfalls:
;$08B000
	incbin "Graphics/GFX_BG_Waterfalls.bin"

SMB1_UncompressedGFX_BG_Pillars:
;$08B800
	incbin "Graphics/GFX_BG_Pillars.bin"

SMB1_UncompressedGFX_FG_Snow:
;$08C000
	incbin "Graphics/GFX_FG_Snow.bin"

SMB1_UncompressedGFX_BG_DeathScreen1:
;$08D000
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMB1_J) != $00
	incbin "Graphics/GFX_BG_DeathScreen1_SMAS_J.bin"
else
	incbin "Graphics/GFX_BG_DeathScreen1_SMAS_U.bin"
endif

SMB1_UncompressedGFX_BG_BonusRoom:
.Mario:
;$08E000
	incbin "Graphics/GFX_BG_BonusRoomMario.bin"
.Luigi:
;$08F000
	incbin "Graphics/GFX_BG_BonusRoomLuigi.bin"

	%SetDuplicateOrNullPointer(SMB1_UncompressedGFX_BG_Underwater, SMBLL_UncompressedGFX_BG_Underwater)
	%SetDuplicateOrNullPointer(SMB1_UncompressedGFX_BG_Mushrooms, SMBLL_UncompressedGFX_BG_Mushrooms)
	%SetDuplicateOrNullPointer(SMB1_UncompressedGFX_BG_DottedHills, SMBLL_UncompressedGFX_BG_DottedHills)
	%SetDuplicateOrNullPointer(SMB1_UncompressedGFX_BG_Castle, SMBLL_UncompressedGFX_BG_Castle)
	%SetDuplicateOrNullPointer(SMB1_UncompressedGFX_BG_Waterfalls, SMBLL_UncompressedGFX_BG_Waterfalls)
	%SetDuplicateOrNullPointer(SMB1_UncompressedGFX_BG_Pillars, SMBLL_UncompressedGFX_BG_Pillars)
	%SetDuplicateOrNullPointer(SMB1_UncompressedGFX_FG_Snow, SMBLL_UncompressedGFX_FG_Snow)
	%SetDuplicateOrNullPointer(SMB1_UncompressedGFX_BG_DeathScreen1, SMBLL_UncompressedGFX_BG_DeathScreen1)
	%SetDuplicateOrNullPointer(SMB1_UncompressedGFX_BG_BonusRoom_Mario, SMBLL_UncompressedGFX_BG_BonusRoom_Mario)
	%SetDuplicateOrNullPointer(SMB1_UncompressedGFX_BG_BonusRoom_Luigi, SMBLL_UncompressedGFX_BG_BonusRoom_Luigi)
%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro SMB1Bank09Macros(StartBank, EndBank)
%BANK_START(<StartBank>)

SMB1_UncompressedGFX_BG_Cave:
;$098000
	incbin "Graphics/GFX_BG_Cave.bin"

SMB1_UncompressedGFX_BG_UnderwaterCastle:
;$099000
	incbin "Graphics/GFX_BG_UnderwaterCastle.bin"

SMB1_UncompressedGFX_FG_BG_Castle:
;$09A000
	incbin "Graphics/GFX_FG_BG_Castle.bin"

SMB1_UncompressedGFX_FG_Grassland:
;$09C000
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMB1_J) != $00
	incbin "Graphics/GFX_FG_Grassland_SMAS_J.bin"
else
	incbin "Graphics/GFX_FG_Grassland_SMAS_U.bin"
endif

SMB1_UncompressedGFX_FG_Cave:
;$09D000
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMB1_J) != $00
	incbin "Graphics/GFX_FG_Cave_SMAS_J.bin"
else
	incbin "Graphics/GFX_FG_Cave_SMAS_U.bin"
endif

SMB1_UncompressedGFX_BG_Night:
;$09E000
	incbin "Graphics/GFX_BG_Night.bin"

SMB1_UncompressedGFX_BG_FinalCastle1:
;$09E800
	incbin "Graphics/GFX_BG_FinalCastle1.bin"

SMB1_UncompressedGFX_BG_FinalCastle2:
;$09F000
	incbin "Graphics/GFX_BG_FinalCastle2.bin"

SMB1_UncompressedGFX_BG_DeathScreen2:
;$09F800
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMB1_J) != $00
	incbin "Graphics/GFX_BG_DeathScreen2_SMAS_J.bin"
else
	incbin "Graphics/GFX_BG_DeathScreen2_SMAS_U.bin"
endif

	%SetDuplicateOrNullPointer(SMB1_UncompressedGFX_BG_Cave, SMBLL_UncompressedGFX_BG_Cave)
	%SetDuplicateOrNullPointer(SMB1_UncompressedGFX_BG_UnderwaterCastle, SMBLL_UncompressedGFX_BG_UnderwaterCastle)
	%SetDuplicateOrNullPointer(SMB1_UncompressedGFX_FG_BG_Castle, SMBLL_UncompressedGFX_FG_BG_Castle)
	%SetDuplicateOrNullPointer(SMB1_UncompressedGFX_FG_Grassland, SMBLL_UncompressedGFX_FG_Grassland)
	%SetDuplicateOrNullPointer(SMB1_UncompressedGFX_FG_Cave, SMBLL_UncompressedGFX_FG_Cave)
	%SetDuplicateOrNullPointer(SMB1_UncompressedGFX_BG_Night, SMBLL_UncompressedGFX_BG_Night)
	%SetDuplicateOrNullPointer(SMB1_UncompressedGFX_BG_FinalCastle1, SMBLL_UncompressedGFX_BG_FinalCastle1)
	%SetDuplicateOrNullPointer(SMB1_UncompressedGFX_BG_FinalCastle2, SMBLL_UncompressedGFX_BG_FinalCastle2)
	%SetDuplicateOrNullPointer(SMB1_UncompressedGFX_BG_DeathScreen2, SMBLL_UncompressedGFX_BG_DeathScreen2)
%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro SMB1Bank0AMacros(StartBank, EndBank)
%BANK_START(<StartBank>)

SMB1_UncompressedGFX_Player:
;$0A8000
.Mario:
	incbin "Graphics/GFX_Player_Mario.bin"
.Luigi:
	incbin "Graphics/GFX_Player_Luigi.bin"

	%SetDuplicateOrNullPointer(SMB1_UncompressedGFX_Player_Mario, SMBLL_UncompressedGFX_Player_Mario)
	%SetDuplicateOrNullPointer(SMB1_UncompressedGFX_Player_Luigi, SMBLL_UncompressedGFX_Player_Luigi)
%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro SMB1Bank0CMacros(StartBank, EndBank)
;%BANK_START(<StartBank>)
SMB1_UncompressedGFX_Layer3:
;$0CF800
	incbin "Graphics/GFX_Layer3.bin"

	%SetDuplicateOrNullPointer(SMB1_UncompressedGFX_Layer3, SMBLL_UncompressedGFX_Layer3)
;%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro SMB1Bank1AMacros(StartBank, EndBank)
;%BANK_START(<StartBank>)
SMB1_EndScreenTilemap:
;$1AE800
	incbin "Tilemaps/Tilemap_1AE800.bin"

	%SetDuplicateOrNullPointer(SMB1_EndScreenTilemap, SMBLL_EndScreenTilemap)
;%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro SMB1Bank1EMacros(StartBank, EndBank)
;%BANK_START(<StartBank>)
SMB1_UncompressedGFX_Sprite_PeachAndToad:
;$1EC000
	incbin "Graphics/GFX_Sprite_PeachAndToad.bin"

	%SetDuplicateOrNullPointer(SMB1_UncompressedGFX_Sprite_PeachAndToad, SMBLL_UncompressedGFX_Sprite_PeachAndToad)
;%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro SMB1Bank1FMacros(StartBank, EndBank)
;%BANK_START(<StartBank>)
SMB1MusicBank:
	incbin "SPC700/SMB1_MusicBank.bin"
;%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro SMB1Bank2FMacros(StartBank, EndBank)
;%BANK_START(<StartBank>)
SMB1_UncompressedGFX_Ending:
;$2FD000
	incbin "Graphics/GFX_Ending.bin"

	%SetDuplicateOrNullPointer(SMB1_UncompressedGFX_Ending, SMBLL_UncompressedGFX_Ending)
;%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMB1_CompressOAMTileSizeBuffer(Address)
namespace SMB1_CompressOAMTileSizeBuffer
%InsertMacroAtXPosition(<Address>)

Main:
	PHD
	LDA.b #SMB1_OAMTileSizeBuffer[$00].Slot>>8
	XBA
	LDA.b #SMB1_OAMTileSizeBuffer[$00].Slot
	TCD
	REP.b #$10
	LDX.w #$0000
	TXY
-:
	LDA.b SMB1_OAMTileSizeBuffer[$03].Slot,x
	LSR
	ROR
	ROR
	STA.b !RAM_SMB1_ScratchRAM7E0C01
	LDA.b SMB1_OAMTileSizeBuffer[$02].Slot,x
	ASL
	ASL
	ASL
	ASL
	TSB.b !RAM_SMB1_ScratchRAM7E0C01
	LDA.b SMB1_OAMTileSizeBuffer[$01].Slot,x
	ASL
	ASL
	TSB.b !RAM_SMB1_ScratchRAM7E0C01
	LDA.b SMB1_OAMTileSizeBuffer[$00].Slot,x
	ORA.b !RAM_SMB1_ScratchRAM7E0C01
	STA.w SMB1_UpperOAMBuffer[$00].Slot,y
	INY
	LDA.b SMB1_OAMTileSizeBuffer[$07].Slot,x
	LSR
	ROR
	ROR
	STA.b !RAM_SMB1_ScratchRAM7E0C01
	LDA.b SMB1_OAMTileSizeBuffer[$06].Slot,x
	ASL
	ASL
	ASL
	ASL
	TSB.b !RAM_SMB1_ScratchRAM7E0C01
	LDA.b SMB1_OAMTileSizeBuffer[$05].Slot,x
	ASL
	ASL
	TSB.b !RAM_SMB1_ScratchRAM7E0C01
	LDA.b SMB1_OAMTileSizeBuffer[$04].Slot,x
	ORA.b !RAM_SMB1_ScratchRAM7E0C01
	STA.w SMB1_UpperOAMBuffer[$00].Slot,y
	INY
	REP.b #$20
	TXA
	CLC
	ADC.w #$0020
	TAX
	SEP.b #$20
	CPX.w #$0200
	BCC.b -
	SEP.b #$10
	PLD
	RTL
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMB1_SaveGame(Address)
namespace SMB1_SaveGame
%InsertMacroAtXPosition(<Address>)

Main:
	PHX
	PHY
	PHB
	PHK
	PLB
	LDA.l !SRAM_SMB1_Global_CopyOfHardModeActiveFlag
	BEQ.b CODE_008ECF
	JMP.w CODE_008FCA

CODE_008ECF:
	REP.b #$30
	STZ.b $00
	LDA.l !SRAM_SMAS_Global_SaveFileIndexLo
	TAX
	SEP.b #$20
	LDA.w !RAM_SMB1_Level_TwoPlayerGameFlag
	BEQ.b CODE_008EF6
	LDA.w !RAM_SMB1_Player_HardModeActiveFlag
	CMP.w $0781
	BEQ.b CODE_008EEE
	CMP.b #$01
	BEQ.b CODE_008EF6
	JMP.w CODE_008F35

CODE_008EEE:
	LDA.w !RAM_SMB1_Player_CurrentWorld
	CMP.w !RAM_SMB1_Player_OtherPlayersWorld
	BCC.b CODE_008F35
CODE_008EF6:
	LDA.w !RAM_SMB1_Player_HardModeActiveFlag
	STA.b $02
	CMP.l !SRAM_SMAS_Global_SaveFileBaseOffset+$05,x
	BEQ.b CODE_008F07
	CMP.b #$01
	BEQ.b CODE_008F26
	BRA.b CODE_008F12

CODE_008F07:
	LDA.l !SRAM_SMAS_Global_SaveFileBaseOffset,x
	BMI.b CODE_008F26
	CMP.w !RAM_SMB1_Player_CurrentWorld
	BCC.b CODE_008F26
CODE_008F12:
	LDA.l !SRAM_SMAS_Global_SaveFileBaseOffset,x
	JSR.w SMB1_StoreDataToSaveFileAndUpdateTempChecksum_Main
	LDA.l !SRAM_SMAS_Global_SaveFileBaseOffset,x
	JSR.w SMB1_StoreDataToSaveFileAndUpdateTempChecksum_Main
	LDA.l !SRAM_SMAS_Global_SaveFileBaseOffset,x
	BRA.b CODE_008F33

CODE_008F26:
	LDA.w !RAM_SMB1_Player_CurrentWorld
	JSR.w SMB1_StoreDataToSaveFileAndUpdateTempChecksum_Main
	LDA.b #$00
	JSR.w SMB1_StoreDataToSaveFileAndUpdateTempChecksum_Main
	LDA.b #$00
CODE_008F33:
	BRA.b CODE_008F74

CODE_008F35:
	LDA.w $0781
	STA.b $02
	CMP.l !SRAM_SMAS_Global_SaveFileBaseOffset+$05,x
	BEQ.b CODE_008F46
	CMP.b #$01
	BEQ.b CODE_008F65
	BRA.b CODE_008F51

CODE_008F46:
	LDA.l !SRAM_SMAS_Global_SaveFileBaseOffset,x
	BMI.b CODE_008F65
	CMP.w !RAM_SMB1_Player_OtherPlayersWorld
	BCC.b CODE_008F65
CODE_008F51:
	LDA.l !SRAM_SMAS_Global_SaveFileBaseOffset,x
	JSR.w SMB1_StoreDataToSaveFileAndUpdateTempChecksum_Main
	LDA.l !SRAM_SMAS_Global_SaveFileBaseOffset,x
	JSR.w SMB1_StoreDataToSaveFileAndUpdateTempChecksum_Main
	LDA.l !SRAM_SMAS_Global_SaveFileBaseOffset,x
	BRA.b CODE_008F74

CODE_008F65:
	LDA.w !RAM_SMB1_Player_OtherPlayersWorld
	JSR.w SMB1_StoreDataToSaveFileAndUpdateTempChecksum_Main
	LDA.w !RAM_SMB1_Player_OtherPlayersLevelNumberDisplay
	JSR.w SMB1_StoreDataToSaveFileAndUpdateTempChecksum_Main
	LDA.w !RAM_SMB1_Player_OtherPlayersLevel
CODE_008F74:
	JSR.w SMB1_StoreDataToSaveFileAndUpdateTempChecksum_Main
	LDA.w !RAM_SMB1_Player_CurrentLifeCount
	STA.b $04
	LDA.w !RAM_SMB1_Player_OtherPlayersLifeCount
	STA.b $05
	REP.b #$20
	LDA.w !RAM_SMB1_Player_CurrentCharacter
	AND.w #$00FF
	TAY
	SEP.b #$20
	LDA.w $04,y
	BPL.b CODE_008F93
	LDA.b #$04
CODE_008F93:
	JSR.w SMB1_StoreDataToSaveFileAndUpdateTempChecksum_Main
	TYA
	EOR.b #$01
	TAY
	LDA.w $04,y
	BPL.b CODE_008FA1
	LDA.b #$04
CODE_008FA1:
	JSR.w SMB1_StoreDataToSaveFileAndUpdateTempChecksum_Main
	PHX
	JSR.w CODE_009041
	PLX
	LDA.l !SRAM_SMAS_Global_SaveFileBaseOffset,x
	ORA.b $02
	JSR.w SMB1_StoreDataToSaveFileAndUpdateTempChecksum_Main
	LDA.w !RAM_SMB1_Level_TwoPlayerGameFlag
	JSR.w SMB1_StoreDataToSaveFileAndUpdateTempChecksum_Main
	REP.b #$20
	LDA.w #$0000
	SEC
	SBC.b $00
	STA.l !SRAM_SMAS_Global_SaveFileBaseOffset,x
	SEP.b #$30
	PLB
	PLY
	PLX
	RTL

CODE_008FCA:
	REP.b #$30
	STZ.b $00
	LDA.l !SRAM_SMAS_Global_SaveFileIndexLo
	TAX
	SEP.b #$20
	LDA.l !SRAM_SMB1_Global_CopyOfCurrentWorld
	JSR.w SMB1_StoreDataToSaveFileAndUpdateTempChecksum_Main
	LDA.b #$00
	JSR.w SMB1_StoreDataToSaveFileAndUpdateTempChecksum_Main
	LDA.b #$00
	JSR.w SMB1_StoreDataToSaveFileAndUpdateTempChecksum_Main
	LDA.w !RAM_SMB1_Player_CurrentLifeCount
	STA.b $04
	LDA.w !RAM_SMB1_Player_OtherPlayersLifeCount
	STA.b $05
	REP.b #$20
	LDA.w !RAM_SMB1_Player_CurrentCharacter
	AND.w #$00FF
	TAY
	SEP.b #$20
	LDA.w $04,y
	BPL.b CODE_009002
	LDA.b #$04
CODE_009002:
	JSR.w SMB1_StoreDataToSaveFileAndUpdateTempChecksum_Main
	TYA
	EOR.b #$01
	TAY
	LDA.w $04,y
	BPL.b CODE_009010
	LDA.b #$04
CODE_009010:
	JSR.w SMB1_StoreDataToSaveFileAndUpdateTempChecksum_Main
	PHX
	JSR.w CODE_009041
	PLX
	LDA.l !SRAM_SMB1_Global_CopyOfHardModeActiveFlag
	JSR.w SMB1_StoreDataToSaveFileAndUpdateTempChecksum_Main
	LDA.w !RAM_SMB1_Level_TwoPlayerGameFlag
	JSR.w SMB1_StoreDataToSaveFileAndUpdateTempChecksum_Main
	REP.b #$20
	LDA.w #$0000
	SEC
	SBC.b $00
	STA.l !SRAM_SMAS_Global_SaveFileBaseOffset,x
	SEP.b #$30
	LDA.b #$00
	STA.l !SRAM_SMB1_Global_CopyOfHardModeActiveFlag
	STA.l !SRAM_SMB1_Global_CopyOfCurrentWorld
	PLB
	PLY
	PLX
	RTL

CODE_009041:
	PHB
	LDA.b #!SRAMBankBaseAddress>>16
	PHA
	PLB
	PHD
	LDA.b #$0700>>8
	XBA
	LDA.b #$0700
	TCD
	LDX.w #$0005
	SEC
CODE_009051:
	LDA.b !RAM_SMB1_TitleScreen_TopScoreMillionsDigit,x
	SBC.w !SRAM_SMB1_Global_TopScoreMillionsDigit,x
	DEX
	BPL.b CODE_009051
	BCC.b CODE_009067
	INX
CODE_00905C:
	LDA.b !RAM_SMB1_TitleScreen_TopScoreMillionsDigit,x
	STA.w !SRAM_SMB1_Global_TopScoreMillionsDigit,x
	INX
	CPX.w #$0006
	BCC.b CODE_00905C
CODE_009067:
	PLD
	PLB
	RTS
namespace off
endmacro


;#############################################################################################################
;#############################################################################################################

macro DATATABLE_SMB1_LevelData(Address)
namespace SMB1_LevelData
%InsertMacroAtXPosition(<Address>)

LevelIDRelativePtrs:
;$04C11C
	db LevelIDsAndTileset_World1-LevelIDsAndTileset
	db LevelIDsAndTileset_World2-LevelIDsAndTileset
	db LevelIDsAndTileset_World3-LevelIDsAndTileset
	db LevelIDsAndTileset_World4-LevelIDsAndTileset
	db LevelIDsAndTileset_World5-LevelIDsAndTileset
	db LevelIDsAndTileset_World6-LevelIDsAndTileset
	db LevelIDsAndTileset_World7-LevelIDsAndTileset
	db LevelIDsAndTileset_World8-LevelIDsAndTileset

LevelIDsAndTileset:
.World1:
	db $25,$29,$C0,$26,$60

.World2:
	db $28,$29,$01,$27,$62

.World3:
	db $24,$35,$20,$63

.World4:
	db $22,$29,$41,$2C,$61

.World5:
	db $2A,$31,$26,$62

.World6:
	db $2E,$23,$2D,$60

.World7:
	db $33,$29,$01,$27,$64

.World8:
	db $30,$32,$21,$65

SpriteDataRelativePtrs:
	db SpriteDataPtrs_Lo_Underwater-SpriteDataPtrs_Lo
	db SpriteDataPtrs_Lo_Overworld-SpriteDataPtrs_Lo
	db SpriteDataPtrs_Lo_Underground-SpriteDataPtrs_Lo
	db SpriteDataPtrs_Lo_Castle-SpriteDataPtrs_Lo

SpriteDataPtrs:
.Lo:
..Castle:
	db DATA_04C1D8
	db DATA_04C1FF
	db DATA_04C218
	db DATA_04C247
	db DATA_04C272
	db DATA_04C287

..Overworld:
	db DATA_04C2C1
	db DATA_04C2E6
	db DATA_04C303
	db DATA_04C311
	db DATA_04C338
	db SpriteData_1_1
	db DATA_04C387
	db DATA_04C3A4
	db DATA_04C3B9
	db DATA_04C3E3
	db DATA_04C3E4
	db DATA_04C408
	db DATA_04C411
	db DATA_04C436
	db DATA_04C459
	db DATA_04C462
	db DATA_04C463
	db DATA_04C49D
	db DATA_04C4C8
	db DATA_04C4F6
	db DATA_04C512
	db DATA_04C51B

..Underground:
	db DATA_04C540
	db DATA_04C56D
	db DATA_04C59B

..Underwater:
	db DATA_04C5C8
	db DATA_04C5D9
	db DATA_04C603

.Hi:
..Castle:
	db DATA_04C1D8>>8
	db DATA_04C1FF>>8
	db DATA_04C218>>8
	db DATA_04C247>>8
	db DATA_04C272>>8
	db DATA_04C287>>8

..Overworld:
	db DATA_04C2C1>>8
	db DATA_04C2E6>>8
	db DATA_04C303>>8
	db DATA_04C311>>8
	db DATA_04C338>>8
	db SpriteData_1_1>>8
	db DATA_04C387>>8
	db DATA_04C3A4>>8
	db DATA_04C3B9>>8
	db DATA_04C3E3>>8
	db DATA_04C3E4>>8
	db DATA_04C408>>8
	db DATA_04C411>>8
	db DATA_04C436>>8
	db DATA_04C459>>8
	db DATA_04C462>>8
	db DATA_04C463>>8
	db DATA_04C49D>>8
	db DATA_04C4C8>>8
	db DATA_04C4F6>>8
	db DATA_04C512>>8
	db DATA_04C51B>>8

..Underground:
	db DATA_04C540>>8
	db DATA_04C56D>>8
	db DATA_04C59B>>8

..Underwater:
	db DATA_04C5C8>>8
	db DATA_04C5D9>>8
	db DATA_04C603>>8

ObjectDataRelativePtrs:
	db ObjectDataPtrs_Lo_Underwater-ObjectDataPtrs_Lo
	db ObjectDataPtrs_Lo_Overworld-ObjectDataPtrs_Lo
	db ObjectDataPtrs_Lo_Underground-ObjectDataPtrs_Lo
	db ObjectDataPtrs_Lo_Castle-ObjectDataPtrs_Lo

ObjectDataPtrs:
.Lo:
..Underwater:
	db DATA_04D608
	db DATA_04D671
	db DATA_04D70D

..Overworld:
	db DATA_04CC0B
	db DATA_04CC74
	db DATA_04CCC3
	db DATA_04CD1B
	db DATA_04CDB0
	db ObjectData_1_1
	db DATA_04CE9A
	db DATA_04CEF1
	db DATA_04CF7A
	db DATA_04CFE7
	db DATA_04CFF1
	db DATA_04D035
	db DATA_04D04A
	db DATA_04D0BB
	db DATA_04D128
	db DATA_04D1A3
	db DATA_04D1D5
	db DATA_04D26D
	db DATA_04D2EB
	db DATA_04D36B
	db DATA_04D3CA
	db DATA_04D3F5

..Underground:
	db DATA_04D42D
	db DATA_04D4D2
	db DATA_04D576

..Castle:
	db DATA_04C617
	db DATA_04C6D2
	db DATA_04C7FA
	db DATA_04C8D8
	db DATA_04C9D4
	db DATA_04CB01

.Hi:
..Underwater:
	db DATA_04D608>>8
	db DATA_04D671>>8
	db DATA_04D70D>>8

..Overworld:
	db DATA_04CC0B>>8
	db DATA_04CC74>>8
	db DATA_04CCC3>>8
	db DATA_04CD1B>>8
	db DATA_04CDB0>>8
	db ObjectData_1_1>>8
	db DATA_04CE9A>>8
	db DATA_04CEF1>>8
	db DATA_04CF7A>>8
	db DATA_04CFE7>>8
	db DATA_04CFF1>>8
	db DATA_04D035>>8
	db DATA_04D04A>>8
	db DATA_04D0BB>>8
	db DATA_04D128>>8
	db DATA_04D1A3>>8
	db DATA_04D1D5>>8
	db DATA_04D26D>>8
	db DATA_04D2EB>>8
	db DATA_04D36B>>8
	db DATA_04D3CA>>8
	db DATA_04D3F5>>8

..Underground:
	db DATA_04D42D>>8
	db DATA_04D4D2>>8
	db DATA_04D576>>8

..Castle:
	db DATA_04C617>>8
	db DATA_04C6D2>>8
	db DATA_04C7FA>>8
	db DATA_04C8D8>>8
	db DATA_04C9D4>>8
	db DATA_04CB01>>8

; Info: Sprite data format:
; WWWWXXXX Y-ZZZZZZ
; WWWW = X Position
; XXXX = Y Position
;	= $0E = Screen Exit command
;	= $0F = Some sort of command
; Y = Spawn sprite on next screen flag
; ZZZZZZ = Sprite number
;	 = $37 - Spawn two goombas
;	 = $38 - Spawn three goombas
;	 = $39 - Spawn two goombas (higher up?)
;	 = $3A - Spawn three goombas (higher up?)
;	 = $3B - Spawn two koopas
;	 = $3C - Spawn three koopas
;	 = $3D - Spawn two koopas (higher up?)
;	 = $3E - Spawn three koopas (higher up?)
;
; If XXXX = $0E
; WWWW---- XXXXXXXX YYYZZZZZ
; WWWW = ????
; -XXXXXXX = Level ID and tileset
; YYY = World number
; ZZZZZ = High X position to spawn player at
;
; $FF (first byte of new data) = End of sprite data
;
; Info:
; UUUUVVVV WWWWWWWW XYYYZZZZZ
; UUUU = X position
; VVVV = Y Position
;	= $0C - Hardcoded position object command
;	= $0D - Load object 22-2D
;	= $0E - Load Object 2E (Change scenery command)
;	= $0F - Three byte object flag
; WWWWWWWW = Used only if object is 3 bytes. Ignored otherwise
; X = Spawn object on next screen flag
; YYY = If bits are not set, add #$16 to ZZZZZ for the object number
; If set, YYY is the object number - 1. (To get object zero, this byte must be #$78/#$F8)
; If VVVV is #$0C, then the object number will be (YYY / 16) + #$08.
;
; $FD (first byte of new data) = End of object data

DATA_04C1D8:
	db $76,$DD,$BB,$4C,$EA,$1D,$1B,$CC,$56,$5D,$16,$9D,$C6,$1D,$36,$9D
	db $C9,$1D,$04,$DB,$49,$1D,$84,$1B,$C9,$5D,$88,$95,$0F,$08,$30,$4C
	db $78,$2D,$A6,$28,$90,$B5,$FF

DATA_04C1FF:
	db $0F,$03,$56,$1B,$C9,$1B,$0F,$07,$36,$1B,$AA,$1B,$48,$95,$0F,$0A
	db $2A,$1B,$5B,$0C,$78,$2D,$90,$B5,$FF

DATA_04C218:
	db $0B,$8C,$4B,$4C,$77,$5F,$EB,$0C,$BD,$DB,$19,$9D,$75,$1D,$7D,$5B
	db $D9,$1D,$3D,$DD,$99,$1D,$26,$9D,$5A,$2B,$8A,$2C,$CA,$1B,$20,$95
	db $7B,$5C,$DB,$4C,$1B,$CC,$3B,$CC,$78,$2D,$A6,$28,$90,$B5,$FF

DATA_04C247:
	db $0B,$8C,$3B,$1D,$8B,$1D,$AB,$0C,$DB,$1D,$0F,$03,$65,$1D,$6B,$1B
	db $05,$9D,$0B,$1B,$05,$9B,$0B,$1D,$8B,$0C,$1B,$8C,$70,$15,$7B,$0C
	db $DB,$0C,$0F,$08,$78,$2D,$A6,$28,$90,$B5,$FF

DATA_04C272:
	db $27,$A9,$4B,$0C,$68,$29,$0F,$06,$77,$1B,$0F,$0B,$60,$15,$4B,$8C
	db $78,$2D,$90,$B5,$FF

DATA_04C287:
	db $0F,$03,$8E,$65,$E1,$BB,$38,$6C,$A8,$3E,$E5,$E7,$0F,$08,$0B,$02
	db $2B,$02,$5E,$65,$E1,$BB,$0E,$DB,$0E,$BB,$8E,$DB,$0E,$FE,$65,$EC
	db $0F,$0D,$4E,$65,$E1,$0F,$0E,$4E,$02,$E0,$0F,$10,$FE,$E5,$E1,$1B
	db $85,$7B,$0C,$5B,$95,$78,$2D,$D0,$B5,$FF

DATA_04C2C1:
	db $A5,$86,$E4,$28,$18,$A8,$45,$83,$69,$03,$C6,$29,$9B,$83,$16,$A4
	db $88,$24,$E9,$28,$05,$A8,$7B,$28,$24,$8F,$C8,$03,$E8,$03,$46,$A8
	db $85,$24,$C8,$24,$FF

DATA_04C2E6:
	db $EB,$8E,$0F,$03,$FB,$05,$17,$85,$DB,$8E,$0F,$07,$57,$05,$7B,$05
	db $9B,$80,$2B,$85,$FB,$05,$0F,$0B,$1B,$05,$9B,$05,$FF

DATA_04C303:
	db $2E,$C2,$66,$E2,$11,$0F,$07,$02,$11,$0F,$0C,$12,$11,$FF

DATA_04C311:
	db $0E,$C2,$A8,$AB,$00,$BB,$8E,$6B,$82,$DE,$00,$A0,$33,$86,$43,$06
	db $3E,$B4,$A0,$CB,$02,$0F,$07,$7E,$42,$A6,$83,$02,$0F,$0A,$3B,$02
	db $CB,$37,$0F,$0C,$E3,$0E,$FF

DATA_04C338:
	db $9B,$8E,$CA,$0E,$EE,$42,$44,$5B,$86,$80,$B8,$1B,$80,$50,$BA,$10
	db $B7,$5B,$00,$17,$85,$4B,$05,$FE,$34,$40,$B7,$86,$C6,$06,$5B,$80
	db $83,$00,$D0,$38,$5B,$8E,$8A,$0E,$A6,$00,$BB,$0E,$C5,$80,$F3,$00
	db $FF

SpriteData_1_1:
	db $1E,$C2,$00,$6B,$06,$8B,$86,$63,$B7,$0F,$05,$03,$06,$23,$06,$4B
	db $B7,$BB,$00,$5B,$B7,$FB,$37,$3B,$B7,$0F,$0B,$1B,$37,$FF

DATA_04C387:
	db $2B,$D7,$E3,$03,$C2,$86,$E2,$06,$76,$A5,$A3,$8F,$03,$86,$2B,$57
	db $68,$28,$E9,$28,$E5,$83,$24,$8F,$36,$A8,$5B,$03,$FF

DATA_04C3A4:
	db $0F,$02,$78,$40,$48,$CE,$F8,$C3,$F8,$C3,$0F,$07,$7B,$43,$C6,$D0
	db $0F,$8A,$C8,$50,$FF

DATA_04C3B9:
	db $85,$86,$0B,$80,$1B,$00,$DB,$37,$77,$80,$EB,$37,$FE,$2B,$20,$2B
	db $80,$7B,$38,$AB,$B8,$77,$86,$FE,$42,$20,$49,$86,$8B,$06,$9B,$80
	db $7B,$8E,$5B,$B7,$9B,$0E,$BB,$0E,$9B,$80
DATA_04C3E3:
	db $FF

DATA_04C3E4:
	db $0B,$80,$60,$38,$10,$B8,$C0,$3B,$DB,$8E,$40,$B8,$F0,$38,$7B,$8E
	db $A0,$B8,$C0,$B8,$FB,$00,$A0,$B8,$30,$BB,$EE,$42,$88,$0F,$0B,$2B
	db $0E,$67,$0E,$FF

DATA_04C408:
	db $0A,$AA,$0E,$28,$2A,$0E,$31,$88,$FF

DATA_04C411:
	db $C7,$83,$D7,$03,$42,$8F,$7A,$03,$05,$A4,$78,$24,$A6,$25,$E4,$25
	db $4B,$83,$E3,$03,$05,$A4,$89,$24,$B5,$24,$09,$A4,$65,$24,$C9,$24
	db $0F,$08,$85,$25,$FF

DATA_04C436:
	db $CC,$A5,$B5,$A8,$07,$A8,$76,$28,$CC,$25,$65,$A4,$A9,$24,$E5,$24
	db $19,$A4,$0F,$07,$95,$28,$E6,$24,$19,$A4,$D7,$29,$16,$A9,$58,$29
	db $97,$29,$FF

DATA_04C459:
	db $0F,$02,$02,$11,$0F,$07,$02,$11,$FF

DATA_04C462:
	db $FF

DATA_04C463:
	db $2B,$82,$AB,$38,$DE,$42,$E2,$1B,$86,$EB,$3B,$DB,$80,$8B,$B8,$1B
	db $82,$FB,$B8,$7B,$80,$FB,$3C,$5B,$80,$7B,$B8,$1B,$8E,$CB,$0E,$1B
	db $8E,$0F,$0D,$2B,$3B,$BB,$B8,$EB,$82,$4B,$B8,$BB,$38,$3B,$B7,$BB
	db $02,$0F,$13,$1B,$00,$CB,$80,$6B,$BC,$FF

DATA_04C49D:
	db $7B,$80,$AE,$00,$80,$8B,$8E,$E8,$05,$F9,$86,$17,$86,$16,$85,$4E
	db $2B,$80,$AB,$8E,$87,$85,$C3,$05,$8B,$82,$9B,$02,$AB,$02,$BB,$86
	db $CB,$06,$D3,$03,$3B,$8E,$6B,$0E,$A7,$8E,$FF

DATA_04C4C8:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMB1_E) != $00
	db $19,$8E,$52,$11,$93,$0E,$0F,$03,$9B,$0E,$2B,$8E,$5B,$0E,$CB,$8E
	db $FB,$0E,$FB,$82,$9B,$82,$BB,$02,$FE,$42,$E8,$BB,$8E,$0F,$0A,$AB
	db $0E,$CB,$0E,$F9,$0E,$88,$86,$A6,$06,$DB,$02,$B6,$8E,$FF
else
	db $29,$8E,$52,$11,$83,$0E,$0F,$03,$9B,$0E,$2B,$8E,$5B,$0E,$CB,$8E
	db $FB,$0E,$FB,$82,$9B,$82,$BB,$02,$FE,$42,$E8,$BB,$8E,$0F,$0A,$AB
	db $0E,$CB,$0E,$F9,$0E,$88,$86,$A6,$06,$DB,$02,$B6,$8E,$FF
endif

DATA_04C4F6:
	db $AB,$CE,$DE,$42,$C0,$CB,$CE,$5B,$8E,$1B,$CE,$4B,$85,$67,$45,$0F
	db $07,$2B,$00,$7B,$85,$97,$05,$0F,$0A,$92,$02,$FF

DATA_04C512:
	db $0A,$AA,$0E,$24,$4A,$1E,$23,$AA,$FF

DATA_04C51B:
	db $1B,$80,$BB,$38,$4B,$BC,$EB,$3B,$0F,$04,$2B,$00,$AB,$38,$EB,$00
	db $CB,$8E,$FB,$80,$AB,$B8,$6B,$80,$FB,$3C,$9B,$BB,$5B,$BC,$FB,$00
	db $6B,$B8,$FB,$38,$FF

DATA_04C540:
	db $0B,$86,$1A,$06,$DB,$06,$DE,$C2,$02,$F0,$3B,$BB,$80,$EB,$06,$0B
	db $86,$93,$06,$F0,$39,$0F,$06,$60,$B8,$1B,$86,$A0,$B9,$B7,$27,$BD
	db $27,$2B,$83,$A1,$26,$A9,$26,$EE,$25,$0B,$27,$B4,$FF

DATA_04C56D:
	db $0F,$02,$1E,$2F,$60,$E0,$3A,$A5,$A7,$DB,$80,$3B,$82,$8B,$02,$FE
	db $42,$68,$70,$BB,$25,$A7,$2C,$27,$B2,$26,$B9,$26,$9B,$80,$A8,$82
	db $B5,$27,$BC,$27,$B0,$BB,$3B,$82,$87,$34,$EE,$25,$6B,$FF

DATA_04C59B:
	db $1E,$A5,$0A,$2E,$28,$27,$2E,$33,$C7,$0F,$03,$1E,$40,$07,$2E,$30
	db $E7,$0F,$05,$1E,$24,$44,$0F,$07,$1E,$22,$6A,$2E,$23,$AB,$0F,$09
	db $1E,$41,$68,$1E,$2A,$8A,$2E,$23,$A2,$2E,$32,$EA,$FF

DATA_04C5C8:
	db $3B,$87,$66,$27,$CC,$27,$EE,$31,$87,$EE,$23,$A7,$3B,$87,$DB,$07
	db $FF

DATA_04C5D9:
	db $0F,$01,$2E,$25,$2B,$2E,$25,$4B,$4E,$25,$CB,$6B,$07,$97,$47,$E9
	db $87,$47,$C7,$7A,$07,$D6,$C7,$78,$07,$38,$87,$AB,$47,$E3,$07,$9B
	db $87,$0F,$09,$68,$47,$DB,$C7,$3B,$C7,$FF

DATA_04C603:
	db $47,$9B,$CB,$07,$FA,$1D,$86,$9B,$3A,$87,$56,$07,$88,$1B,$07,$9D
	db $2E,$65,$F0,$FF

DATA_04C617:
	db $9B,$07,$0F,$52,$32,$0F,$63,$32,$0F,$74,$32,$CF,$80,$36,$CE,$03
	db $DC,$51,$EE,$07,$FF,$80,$38,$7F,$30,$B4,$74,$0A,$7E,$06,$7F,$20
	db $34,$9F,$80,$36,$9E,$0A,$CE,$06,$DF,$80,$38,$E4,$00,$E8,$0A,$FF
	db $80,$36,$FE,$0A,$2E,$89,$3F,$70,$38,$4E,$0B,$5F,$10,$34,$54,$0A
	db $14,$8A,$C4,$0A,$34,$8A,$7F,$71,$3A,$7F,$20,$34,$7E,$06,$C7,$0A
	db $0F,$10,$B4,$02,$0A,$47,$0A,$8F,$10,$34,$82,$0A,$C7,$0A,$0E,$87
	db $1F,$10,$34,$7F,$20,$34,$7F,$A1,$3A,$7F,$80,$36,$7E,$02,$A7,$02
	db $B3,$02,$D7,$02,$E3,$02,$07,$82,$13,$02,$3E,$06,$3F,$A1,$3C,$4F
	db $80,$38,$7F,$A1,$3A,$7F,$80,$36,$7E,$02,$AE,$07,$AF,$A1,$3C,$BF
	db $80,$38,$BF,$10,$34,$FE,$0A,$FF,$20,$34,$FF,$80,$36,$0D,$C4,$CD
	db $43,$CE,$09,$DE,$0B,$DF,$70,$38,$DD,$42,$EF,$20,$34,$FF,$20,$34
	db $FF,$A1,$3A,$FF,$70,$36,$FE,$02,$5D,$C7,$FD

DATA_04C6D2:
	db $5B,$07,$0F,$52,$32,$0F,$63,$32,$0F,$74,$32,$5E,$0A,$5F,$20,$34
	db $6F,$80,$36,$68,$64,$9F,$80,$38,$AF,$80,$36,$CE,$06,$DF,$80,$38
	db $FF,$A1,$3A,$FF,$80,$36,$FE,$02,$0D,$01,$1E,$0E,$24,$63,$34,$63
	db $44,$63,$54,$63,$64,$63,$74,$63,$7E,$02,$94,$63,$B4,$63,$D4,$63
	db $F4,$63,$14,$E3,$2E,$0E,$34,$63,$44,$63,$54,$63,$5E,$02,$64,$35
	db $88,$72,$BE,$0E,$C4,$63,$D4,$63,$E4,$63,$F4,$63,$04,$E3,$14,$63
	db $24,$63,$34,$63,$44,$63,$54,$63,$64,$63,$74,$63,$84,$63,$94,$63
	db $A4,$63,$B4,$63,$C4,$63,$D4,$63,$E4,$63,$F4,$63,$0D,$04,$04,$63
	db $14,$63,$24,$63,$34,$63,$44,$63,$54,$63,$64,$63,$74,$63,$84,$63
	db $94,$63,$A4,$63,$AE,$02,$CE,$08,$CF,$A1,$3C,$CD,$4B,$DF,$10,$34
	db $DF,$80,$38,$FF,$A1,$3A,$FF,$80,$36,$FF,$20,$34,$FE,$02,$0D,$05
	db $68,$31,$7E,$0A,$7F,$B0,$36,$96,$31,$A9,$63,$A8,$33,$D5,$30,$EE
	db $02,$E6,$62,$F4,$61,$FF,$B0,$38,$04,$B1,$08,$3F,$44,$33,$94,$63
	db $A4,$31,$E4,$31,$04,$BF,$08,$3F,$04,$BF,$08,$3F,$CD,$4B,$03,$E4
	db $0E,$03,$1F,$10,$34,$2E,$01,$2F,$10,$34,$7E,$06,$7F,$A1,$3C,$8F
	db $00,$34,$8F,$80,$38,$BE,$02,$BF,$A1,$3A,$BF,$80,$36,$DE,$06,$DF
	db $A1,$3C,$EF,$80,$38,$FE,$0A,$FF,$80,$36,$0D,$C4,$CD,$43,$CE,$09
	db $DF,$70,$38,$DE,$0B,$DD,$42,$EF,$20,$34,$FF,$20,$34,$FE,$02,$FF
	db $A1,$3A,$FF,$70,$36,$5D,$C7,$FD

DATA_04C7FA:
	db $9B,$07,$0F,$52,$32,$0F,$63,$32,$0F,$74,$32,$FF,$80,$36,$FF,$00
	db $34,$FE,$00,$27,$B1,$65,$32,$75,$0A,$71,$00,$B7,$31,$0F,$80,$B8
	db $1F,$A1,$3A,$1F,$80,$36,$1E,$04,$2F,$00,$34,$57,$3B,$BB,$0A,$17
	db $8A,$27,$3A,$6F,$30,$34,$73,$0A,$7B,$0A,$D7,$0A,$E7,$3A,$3B,$8A
	db $97,$0A,$FE,$08,$FF,$A1,$3C,$0F,$80,$B8,$24,$0A,$2E,$00,$2F,$10
	db $34,$3E,$40,$3F,$80,$36,$38,$64,$6F,$F0,$00,$9F,$F0,$00,$BE,$43
	db $C8,$0A,$CF,$80,$38,$CE,$07,$DF,$10,$34,$FE,$07,$2E,$81,$2F,$10
	db $34,$2F,$A1,$3A,$2F,$80,$36,$66,$42,$6A,$42,$79,$0A,$BE,$00,$BF
	db $B0,$36,$C8,$64,$F8,$64,$FF,$80,$38,$0F,$80,$B6,$08,$64,$2E,$07
	db $3F,$10,$34,$3F,$80,$38,$7F,$A1,$3A,$7F,$80,$36,$7E,$03,$9E,$07
	db $9F,$A1,$3C,$AF,$80,$38,$BF,$A1,$3A,$BF,$80,$36,$BE,$03,$DE,$07
	db $DF,$A1,$3C,$EF,$80,$38,$FE,$0A,$FF,$20,$34,$FF,$80,$36,$03,$A5
	db $0D,$44,$CD,$43,$CE,$09,$DF,$70,$38,$DD,$42,$DE,$0B,$EF,$20,$34
	db $FE,$02,$FF,$20,$34,$FF,$A1,$3A,$FF,$70,$36,$5D,$C7,$FD

DATA_04C8D8:
	db $9B,$07,$0F,$52,$32,$0F,$63,$32,$0F,$74,$32,$FF,$20,$34,$FF,$80
	db $36,$FE,$06,$0C,$81,$0C,$51,$2F,$80,$38,$39,$0A,$4F,$80,$36,$5C
	db $01,$5C,$51,$7F,$80,$38,$89,$0A,$9F,$80,$36,$AC,$01,$AC,$51,$CF
	db $80,$38,$D9,$0A,$EF,$80,$36,$FC,$01,$FC,$51,$1F,$80,$B8,$2E,$03
	db $3F,$10,$34,$3F,$A1,$3A,$3F,$80,$36,$A7,$01,$B7,$00,$C7,$01,$DF
	db $20,$34,$DF,$B0,$36,$DE,$0A,$FE,$02,$0F,$B0,$B8,$4E,$03,$5F,$10
	db $34,$5F,$A2,$34,$63,$0A,$69,$0A,$7E,$02,$7F,$20,$34,$EE,$03,$FF
	db $10,$34,$FF,$A2,$34,$03,$8A,$09,$0A,$1E,$02,$1F,$20,$34,$EE,$03
	db $FF,$10,$34,$FF,$A2,$34,$03,$8A,$09,$0A,$14,$42,$1E,$02,$1F,$20
	db $34,$7F,$B0,$36,$7E,$0A,$9E,$07,$AF,$20,$34,$AF,$80,$38,$FE,$0A
	db $FF,$20,$34,$FF,$80,$36,$2E,$86,$3F,$80,$38,$5E,$0A,$5F,$80,$36
	db $8E,$06,$9F,$80,$38,$BE,$0A,$BF,$80,$36,$EE,$07,$EF,$80,$38,$FF
	db $10,$34,$3E,$83,$3F,$A1,$3A,$3F,$80,$36,$5E,$07,$5F,$A1,$3C,$6F
	db $80,$38,$FE,$0A,$FF,$20,$34,$FF,$80,$36,$0D,$C4,$41,$52,$51,$52
	db $CD,$43,$CE,$09,$DF,$70,$38,$DE,$0B,$DD,$42,$EF,$20,$34,$FE,$02
	db $FF,$20,$34,$FF,$A1,$3A,$FF,$70,$36,$5D,$C7,$FD

DATA_04C9D4:
	db $5B,$07,$0F,$52,$32,$0F,$63,$32,$0F,$74,$32,$FE,$0A,$FF,$20,$34
	db $FF,$80,$36,$AE,$86,$BF,$80,$38,$BE,$07,$CF,$20,$34,$FF,$20,$34
	db $FF,$A1,$3A,$FF,$80,$36,$FE,$02,$0D,$02,$27,$32,$46,$61,$55,$62
	db $5E,$0E,$64,$39,$65,$39,$66,$39,$67,$39,$04,$E3,$1E,$02,$14,$63
	db $68,$3C,$74,$3A,$7D,$4B,$5E,$8E,$64,$39,$65,$39,$66,$39,$67,$39
	db $7D,$4B,$04,$B7,$05,$37,$06,$37,$07,$37,$7E,$02,$84,$62,$94,$61
	db $A4,$31,$BD,$4B,$CE,$06,$CF,$A1,$3C,$DF,$80,$38,$FF,$A1,$3A,$FF
	db $80,$36,$FE,$02,$0D,$06,$34,$31,$3E,$0A,$3F,$B0,$36,$64,$32,$75
	db $0A,$7B,$61,$A4,$33,$AE,$02,$BF,$B0,$38,$DE,$0E,$E4,$35,$E5,$35
	db $E6,$35,$E7,$35,$3E,$82,$64,$32,$78,$32,$B4,$36,$C8,$36,$DD,$4B
	db $44,$B2,$58,$32,$94,$63,$A4,$3E,$BA,$30,$C9,$61,$CE,$06,$CF,$A1
	db $3C,$DF,$80,$38,$DD,$4B,$CE,$86,$DD,$4B,$FE,$02,$FF,$A1,$3A,$FF
	db $80,$36,$2E,$86,$2F,$A1,$3C,$3F,$80,$38,$5E,$02,$5F,$A1,$3A,$5F
	db $80,$36,$7E,$06,$7F,$A1,$3C,$8F,$80,$38,$FE,$02,$FF,$A1,$3A,$FF
	db $80,$36,$1E,$86,$1F,$A1,$3C,$2F,$80,$38,$3E,$02,$3F,$A1,$3A,$3F
	db $80,$36,$5E,$06,$5F,$A1,$3C,$6F,$80,$38,$7E,$02,$7F,$A1,$3A,$7F
	db $80,$36,$9E,$06,$9F,$A1,$3C,$AF,$80,$38,$FE,$0A,$FF,$80,$36,$0D
	db $C4,$CD,$43,$CE,$09,$DE,$0B,$DD,$42,$DF,$70,$38,$EF,$20,$34,$FE
	db $02,$FF,$20,$34,$FF,$A1,$3A,$FF,$70,$36,$5D,$C7,$FD

DATA_04CB01:
	db $5B,$06,$0F,$52,$32,$0F,$63,$32,$0F,$74,$32,$5F,$80,$36,$5E,$0A
	db $BF,$B0,$38,$BE,$02,$0D,$01,$2F,$B0,$36,$39,$73,$5F,$B0,$38,$0D
	db $03,$2F,$B0,$36,$39,$7B,$4D,$4B,$5F,$B0,$38,$DE,$06,$DF,$A1,$3C
	db $EF,$80,$38,$1F,$80,$B6,$1E,$0A,$AE,$06,$BF,$80,$38,$C4,$33,$0F
	db $80,$B6,$16,$7E,$3F,$80,$38,$9F,$80,$36,$A5,$77,$CF,$80,$38,$FF
	db $A1,$3A,$FF,$80,$36,$FE,$02,$FE,$82,$0D,$07,$2F,$B0,$36,$39,$73
	db $5F,$B0,$38,$9F,$B0,$36,$A8,$74,$CF,$B0,$38,$ED,$4B,$3F,$B0,$B6
	db $49,$7B,$6F,$B0,$38,$DF,$B0,$36,$E8,$74,$FE,$0A,$2E,$82,$2F,$B0
	db $38,$67,$02,$84,$7A,$87,$31,$0D,$0B,$FE,$02,$0D,$0C,$2F,$B0,$36
	db $39,$73,$5E,$06,$5F,$A1,$3C,$5F,$B0,$38,$6F,$80,$38,$BF,$80,$36
	db $C6,$76,$EF,$80,$38,$3F,$80,$B6,$45,$7F,$6F,$80,$38,$BF,$80,$36
	db $BE,$0A,$DD,$48,$FE,$06,$0F,$80,$B8,$3D,$4B,$3F,$80,$36,$46,$7E
	db $6F,$80,$38,$AD,$4A,$FF,$A1,$BA,$FF,$80,$36,$FE,$02,$2F,$B0,$B6
	db $39,$73,$5F,$B0,$38,$9F,$B0,$36,$A9,$7B,$CF,$B0,$38,$4E,$8A,$4F
	db $B0,$36,$9E,$07,$AF,$20,$34,$AF,$80,$38,$FE,$0A,$FF,$20,$34,$FF
	db $80,$36,$0D,$C4,$CD,$43,$CE,$09,$DF,$70,$38,$DE,$0B,$DD,$42,$EF
	db $20,$34,$FE,$02,$FF,$20,$34,$5D,$C7,$FD

DATA_04CC0B:
	db $94,$11,$0F,$F6,$20,$FE,$10,$28,$94,$65,$15,$EB,$12,$FA,$41,$4A
	db $96,$54,$40,$A4,$42,$B7,$13,$E9,$19,$F5,$15,$11,$80,$47,$42,$71
	db $13,$80,$41,$15,$92,$1B,$1F,$24,$40,$55,$12,$64,$40,$95,$12,$A4
	db $40,$D2,$12,$E1,$40,$13,$C0,$2C,$17,$2F,$F2,$10,$49,$13,$83,$40
	db $9F,$F4,$10,$A3,$40,$17,$92,$83,$13,$92,$41,$B9,$14,$C5,$12,$C8
	db $40,$D4,$40,$4B,$92,$78,$1B,$9C,$94,$9F,$F1,$10,$DF,$F4,$10,$FE
	db $11,$7D,$C1,$9F,$F0,$20,$9D,$C7,$FD

DATA_04CC74:
	db $90,$B1,$0F,$F6,$20,$29,$91,$28,$92,$57,$F3,$C3,$25,$C7,$27,$23
	db $84,$33,$20,$5C,$01,$77,$63,$88,$62,$99,$61,$AA,$60,$BC,$01,$69
	db $91,$F8,$62,$D7,$E3,$E7,$63,$33,$A7,$37,$27,$43,$04,$CC,$01,$E7
	db $73,$0C,$81,$0D,$0A,$88,$72,$E7,$87,$39,$E1,$4E,$00,$69,$60,$87
	db $60,$A5,$60,$C3,$31,$FE,$31,$6D,$C1,$8F,$F0,$20,$8D,$C7,$FD

DATA_04CCC3:
	db $52,$21,$0F,$F0,$20,$6E,$40,$58,$F2,$93,$01,$97,$00,$0C,$81,$97
	db $40,$A6,$41,$C7,$40,$0D,$04,$03,$01,$07,$01,$23,$01,$27,$01,$EC
	db $03,$AC,$F3,$C3,$03,$78,$E2,$94,$43,$47,$F3,$74,$43,$47,$FB,$74
	db $43,$2C,$F1,$4C,$63,$47,$00,$57,$21,$5C,$01,$7C,$72,$39,$F1,$EC
	db $02,$4C,$81,$D8,$62,$EC,$01,$0D,$0D,$0F,$F8,$30,$C7,$07,$ED,$4A
	db $1D,$C1,$5F,$F6,$20,$1D,$C7,$FD

DATA_04CD1B:
	db $54,$21,$0F,$F6,$20,$A7,$22,$37,$FB,$73,$20,$83,$07,$87,$02,$93
	db $20,$C7,$73,$04,$F1,$06,$31,$39,$71,$59,$71,$E7,$73,$37,$A0,$47
	db $04,$86,$7C,$E5,$71,$E7,$31,$33,$A4,$39,$71,$A9,$71,$D3,$23,$08
	db $F2,$13,$05,$27,$02,$49,$71,$75,$75,$E8,$72,$67,$F3,$99,$71,$E7
	db $20,$F4,$72,$F7,$31,$17,$A0,$33,$20,$39,$71,$73,$28,$BC,$05,$39
	db $F1,$79,$71,$A6,$21,$C3,$06,$D3,$20,$DC,$00,$FC,$00,$07,$A2,$13
	db $21,$5F,$F2,$30,$8C,$00,$98,$7A,$C7,$63,$D9,$61,$03,$A2,$07,$22
	db $74,$72,$77,$31,$E7,$73,$39,$F1,$58,$72,$77,$73,$D8,$72,$7F,$F6
	db $B0,$97,$73,$B6,$64,$C5,$65,$D4,$66,$E3,$67,$F3,$67,$8D,$C1,$CF
	db $F6,$20,$9D,$C7,$FD

DATA_04CDB0:
	db $52,$31,$0F,$F0,$20,$6E,$66,$07,$81,$36,$01,$66,$00,$A7,$22,$08
	db $F2,$67,$7B,$DC,$02,$98,$F2,$D7,$20,$39,$F1,$9F,$F3,$30,$DC,$27
	db $DC,$57,$23,$83,$57,$64,$6C,$51,$87,$63,$99,$61,$A3,$06,$B3,$21
	db $77,$F3,$F3,$21,$F7,$2A,$13,$81,$23,$22,$53,$00,$63,$22,$E9,$0B
	db $0C,$83,$13,$21,$16,$22,$33,$05,$8F,$F5,$30,$8F,$90,$12,$EC,$01
	db $63,$A0,$67,$20,$73,$01,$77,$01,$83,$20,$87,$20,$B3,$20,$B7,$20
	db $C3,$01,$C7,$00,$D3,$20,$D7,$20,$67,$A0,$77,$07,$87,$22,$E8,$62
	db $F5,$65,$1C,$82,$7F,$F8,$30,$8D,$C1,$CF,$F6,$20,$8D,$C7,$FD

ObjectData_1_1:
	db $50,$21,$07,$81,$47,$24,$57,$00,$63,$01,$77,$01,$C9,$71,$68,$F2
	db $E7,$73,$97,$FB,$06,$83,$5C,$01,$D7,$22,$E7,$00,$03,$A7,$6C,$02
	db $B3,$22,$E3,$01,$E7,$07,$47,$A0,$57,$06,$A7,$01,$D3,$00,$D7,$01
	db $07,$81,$67,$20,$93,$22,$03,$A3,$1C,$61,$17,$21,$6F,$F3,$30,$C7
	db $63,$D8,$62,$E9,$61,$FA,$60,$4F,$F3,$B0,$87,$63,$9C,$01,$B7,$63
	db $C8,$62,$D9,$61,$EA,$60,$39,$F1,$87,$21,$A7,$01,$B7,$20,$39,$F1
	db $5F,$F8,$30,$6D,$C1,$AF,$F6,$20,$7D,$C7,$FD

DATA_04CE9A:
	db $90,$11,$0F,$F6,$20,$FE,$10,$2A,$93,$87,$17,$A3,$14,$B2,$42,$0A
	db $92,$19,$40,$36,$14,$50,$41,$82,$16,$2B,$93,$24,$41,$BB,$14,$B8
	db $00,$C2,$43,$C3,$13,$1B,$94,$67,$12,$C4,$15,$53,$C1,$D2,$41,$12
	db $C1,$29,$13,$85,$17,$1B,$92,$1A,$42,$47,$13,$83,$41,$A7,$13,$0E
	db $91,$A7,$63,$B7,$63,$C5,$65,$D5,$65,$DD,$4A,$E3,$67,$F3,$67,$8D
	db $C1,$AF,$F0,$20,$AD,$C7,$FD

DATA_04CEF1:
	db $90,$11,$0F,$F6,$20,$6E,$10,$8B,$17,$AF,$F2,$30,$D8,$62,$E8,$62
	db $FC,$3F,$AD,$C8,$F8,$64,$0C,$BE,$43,$43,$F8,$64,$0C,$BE,$73,$40
	db $84,$40,$93,$40,$A4,$40,$B3,$40,$F8,$64,$48,$E4,$5C,$39,$83,$40
	db $92,$41,$B3,$40,$F8,$64,$48,$E4,$5C,$39,$F8,$64,$13,$C2,$37,$65
	db $4C,$24,$63,$00,$97,$65,$C3,$42,$0B,$97,$AC,$32,$F8,$64,$0C,$BE
	db $53,$45,$9D,$48,$F8,$64,$2A,$E2,$3C,$47,$56,$43,$BA,$62,$F8,$64
	db $0C,$B7,$88,$64,$BC,$31,$D4,$45,$FC,$31,$3C,$B1,$78,$64,$8C,$38
	db $0B,$9C,$1A,$33,$18,$61,$28,$61,$39,$60,$5D,$4A,$EE,$11,$0F,$F8
	db $B0,$1D,$C1,$3F,$F0,$20,$3D,$C7,$FD

DATA_04CF7A:
	db $52,$31,$0F,$F0,$20,$6E,$40,$F7,$20,$07,$84,$17,$20,$4F,$F4,$30
	db $5F,$80,$12,$C3,$03,$C7,$02,$D3,$22,$27,$E3,$39,$61,$E7,$73,$5C
	db $E4,$57,$00,$6C,$73,$47,$A0,$53,$06,$63,$22,$A7,$73,$FC,$73,$13
	db $A1,$33,$05,$43,$21,$5C,$72,$C3,$23,$CC,$03,$77,$FB,$AC,$02,$39
	db $F1,$A7,$73,$D3,$04,$E8,$72,$E3,$22,$26,$F4,$BC,$02,$8C,$81,$A8
	db $62,$17,$87,$43,$24,$A7,$01,$C3,$04,$08,$F2,$97,$21,$A3,$02,$C9
	db $0B,$E1,$69,$F1,$69,$8D,$C1,$CF,$F6,$20,$9D,$C7,$FD

DATA_04CFE7:
	db $38,$11,$0F,$F6,$20,$AD,$40,$3D,$C7,$FD

DATA_04CFF1:
	db $95,$B1,$0F,$F6,$20,$0D,$02,$C8,$72,$1C,$81,$38,$72,$0D,$05,$97
	db $34,$98,$62,$A3,$20,$B3,$06,$C3,$20,$CC,$03,$F9,$91,$2C,$81,$48
	db $62,$0D,$09,$37,$63,$47,$03,$57,$21,$8C,$02,$C5,$79,$C7,$31,$F9
	db $11,$39,$F1,$A9,$11,$6F,$F4,$B0,$D3,$65,$E3,$65,$7D,$C1,$BF,$F6
	db $20,$8D,$C7,$FD

DATA_04D035:
	db $00,$C1,$4C,$00,$F4,$4F,$0D,$02,$02,$42,$43,$4F,$52,$C2,$DE,$00
	db $5A,$C2,$4D,$C7,$FD

DATA_04D04A:
	db $90,$51,$0F,$F6,$20,$EE,$10,$0B,$94,$33,$14,$42,$42,$77,$16,$86
	db $44,$02,$92,$4A,$16,$69,$42,$73,$14,$B0,$00,$C7,$12,$05,$C0,$1C
	db $17,$1F,$F1,$10,$36,$12,$8F,$F4,$10,$91,$40,$1B,$94,$35,$12,$34
	db $42,$60,$42,$61,$12,$87,$12,$96,$40,$A3,$14,$1C,$98,$1F,$F1,$10
	db $47,$12,$9F,$F5,$10,$CC,$15,$CF,$F1,$10,$05,$C0,$1F,$F5,$10,$39
	db $12,$7C,$16,$7F,$F1,$10,$82,$40,$98,$12,$DF,$F5,$10,$16,$C4,$17
	db $14,$54,$12,$9B,$16,$28,$94,$CE,$01,$3D,$C1,$5F,$F0,$20,$5D,$C7
	db $FD

DATA_04D0BB:
	db $97,$11,$0F,$F6,$20,$FE,$10,$2B,$92,$57,$12,$8B,$12,$C0,$41,$F7
	db $13,$5B,$92,$69,$0B,$BB,$12,$B2,$46,$19,$93,$71,$00,$17,$94,$7C
	db $14,$7F,$F1,$10,$93,$41,$BF,$F5,$10,$FC,$13,$FF,$F1,$10,$2F,$F5
	db $90,$50,$42,$51,$12,$58,$14,$A6,$12,$DB,$12,$1B,$93,$46,$43,$7B
	db $12,$8D,$49,$B7,$14,$1B,$94,$49,$0B,$BB,$12,$FC,$13,$FF,$F2,$10
	db $03,$C1,$2F,$F5,$10,$43,$12,$4B,$13,$77,$13,$9D,$4A,$15,$C1,$A1
	db $41,$C3,$12,$FE,$01,$7D,$C1,$9F,$F0,$20,$9D,$C7,$FD

DATA_04D128:
	db $52,$21,$0F,$F0,$20,$6E,$44,$0C,$F1,$4C,$01,$AA,$35,$D9,$34,$EE
	db $20,$08,$B3,$37,$32,$43,$04,$4E,$21,$53,$20,$7C,$01,$97,$21,$B7
	db $07,$9C,$81,$E7,$42,$5F,$F3,$B0,$97,$63,$AC,$02,$C5,$41,$49,$E0
	db $58,$61,$76,$64,$85,$65,$94,$66,$A4,$22,$A6,$03,$C8,$22,$DC,$02
	db $68,$F2,$96,$42,$13,$82,$17,$02,$AF,$F4,$30,$F6,$21,$FC,$06,$26
	db $80,$2A,$24,$36,$01,$8C,$00,$FF,$F5,$30,$4E,$A0,$55,$21,$77,$20
	db $87,$07,$89,$22,$AE,$21,$4C,$82,$9F,$F4,$30,$EC,$01,$03,$E7,$13
	db $67,$8D,$4A,$AD,$41,$EF,$F6,$20,$BD,$C7,$FD

DATA_04D1A3:
	db $10,$51,$4C,$00,$C7,$12,$C6,$42,$03,$92,$02,$42,$29,$12,$63,$12
	db $62,$42,$69,$14,$A5,$12,$A4,$42,$E2,$14,$E1,$44,$F8,$16,$37,$C1
	db $8F,$F8,$30,$02,$BB,$28,$7A,$68,$7A,$A8,$7A,$E0,$6A,$F0,$6A,$6D
	db $C5,$FD

DATA_04D1D5:
	db $92,$31,$0F,$F0,$20,$6E,$40,$0D,$02,$37,$73,$EC,$00,$0C,$80,$3C
	db $00,$6C,$00,$9C,$00,$06,$C0,$C7,$73,$06,$83,$28,$72,$96,$40,$E7
	db $73,$26,$C0,$87,$7B,$D2,$41,$39,$F1,$C8,$F2,$97,$E3,$A3,$23,$E7
	db $02,$E3,$07,$F3,$22,$37,$E3,$9C,$00,$BC,$00,$EC,$00,$0C,$80,$3C
	db $00,$86,$21,$A6,$06,$B6,$24,$5C,$80,$7C,$00,$9C,$00,$29,$E1,$DC
	db $05,$F6,$41,$DC,$80,$E8,$72,$0C,$81,$27,$73,$4C,$01,$66,$74,$0D
	db $11,$3F,$F5,$30,$B6,$41,$2C,$82,$36,$40,$7C,$02,$86,$40,$F9,$61
	db $39,$E1,$AC,$04,$C6,$41,$0C,$83,$16,$41,$88,$F2,$39,$F1,$7C,$00
	db $89,$61,$9C,$00,$A7,$63,$BC,$00,$C5,$65,$DC,$00,$E3,$67,$F3,$67
	db $8D,$C1,$CF,$F6,$20,$8D,$C7,$FD

DATA_04D26D:
	db $55,$B1,$0F,$F6,$20,$CF,$F3,$30,$DF,$80,$12,$07,$B2,$15,$11,$52
	db $42,$99,$0B,$AC,$02,$D3,$24,$D6,$42,$D7,$25,$23,$84,$CF,$F3,$30
	db $07,$E3,$19,$61,$78,$7A,$EF,$F3,$30,$2C,$81,$46,$64,$55,$65,$65
	db $65,$EC,$74,$47,$82,$53,$05,$63,$21,$62,$41,$96,$22,$9A,$41,$CC
	db $03,$B9,$91,$39,$F1,$63,$26,$67,$27,$D3,$06,$FC,$01,$18,$E2,$D9
	db $07,$E9,$04,$0C,$86,$37,$22,$93,$24,$87,$84,$AC,$02,$C2,$41,$C3
	db $23,$D9,$71,$FC,$01,$7F,$F1,$B0,$9C,$00,$A7,$63,$B6,$64,$CC,$00
	db $D4,$66,$E3,$67,$F3,$67,$8D,$C1,$CF,$F6,$20,$9D,$C7,$FD

DATA_04D2EB:
	db $50,$B1,$0F,$F6,$20,$FC,$00,$1F,$F3,$B0,$5C,$00,$65,$65,$74,$66
	db $83,$67,$93,$67,$DC,$73,$4C,$80,$B3,$20,$C9,$0B,$C3,$08,$D3,$2F
	db $DC,$00,$2C,$80,$4C,$00,$8C,$00,$D3,$2E,$ED,$4A,$FC,$00,$D7,$A1
	db $EC,$01,$4C,$80,$59,$11,$D8,$11,$DA,$10,$37,$A0,$47,$04,$99,$11
	db $E7,$21,$3A,$90,$67,$20,$76,$10,$77,$60,$87,$07,$D8,$12,$39,$F1
	db $AC,$00,$E9,$71,$0C,$80,$2C,$00,$4C,$05,$C7,$7B,$39,$F1,$EC,$00
	db $F9,$11,$0C,$82,$6F,$F4,$30,$F8,$11,$FA,$10,$7F,$F2,$B0,$AC,$00
	db $B6,$64,$CC,$01,$E3,$67,$F3,$67,$8D,$C1,$CF,$F6,$20,$8D,$C7,$FD

DATA_04D36B:
	db $52,$B1,$0F,$F0,$20,$6E,$45,$39,$91,$B3,$04,$C3,$21,$C8,$11,$CA
	db $10,$49,$91,$7C,$73,$E8,$12,$88,$91,$8A,$10,$E7,$21,$05,$91,$07
	db $30,$17,$07,$27,$20,$49,$11,$9C,$01,$C8,$72,$23,$A6,$27,$26,$D3
	db $03,$D8,$7A,$89,$91,$D8,$72,$39,$F1,$A9,$11,$09,$F1,$63,$24,$67
	db $24,$D8,$62,$28,$91,$2A,$10,$56,$21,$70,$04,$79,$0B,$8C,$00,$94
	db $21,$9F,$F5,$30,$2F,$F8,$B0,$3D,$C1,$7F,$F6,$20,$3D,$C7,$FD

DATA_04D3CA:
	db $06,$C1,$4C,$00,$F4,$4F,$0D,$02,$06,$20,$24,$4F,$35,$A0,$36,$20
	db $53,$46,$D5,$20,$D6,$20,$34,$A1,$73,$49,$74,$20,$94,$20,$B4,$20
	db $D4,$20,$F4,$20,$2E,$80,$59,$42,$4D,$C7,$FD

DATA_04D3F5:
	db $96,$31,$0F,$F6,$20,$0D,$03,$1A,$60,$77,$42,$C4,$00,$C8,$62,$B9
	db $E1,$D3,$06,$D7,$07,$F9,$61,$0C,$81,$4E,$B1,$8E,$B1,$BC,$01,$E4
	db $50,$E9,$61,$0C,$81,$0D,$0A,$84,$43,$98,$72,$0D,$0C,$0F,$F8,$30
	db $1D,$C1,$5F,$F6,$20,$1D,$C7,$FD

DATA_04D42D:
	db $48,$0F,$0E,$01,$5E,$02,$A7,$00,$BC,$73,$1A,$E0,$39,$61,$58,$62
	db $77,$63,$97,$63,$B8,$62,$D6,$07,$F8,$62,$19,$E1,$75,$52,$86,$40
	db $87,$50,$95,$52,$93,$43,$A5,$21,$C5,$52,$D6,$40,$D7,$20,$E5,$06
	db $E6,$51,$3E,$8D,$5E,$03,$67,$52,$77,$52,$7E,$02,$9E,$03,$A6,$43
	db $A7,$23,$DE,$05,$FE,$02,$1E,$83,$33,$54,$46,$40,$47,$21,$56,$04
	db $5E,$02,$83,$54,$93,$52,$96,$07,$97,$50,$BE,$03,$C7,$23,$FE,$02
	db $0C,$82,$43,$45,$45,$24,$46,$24,$90,$08,$95,$51,$78,$FA,$D7,$73
	db $39,$F1,$8C,$01,$A8,$52,$B8,$52,$CC,$01,$5F,$F3,$B0,$97,$63,$9E
	db $00,$0E,$81,$16,$24,$66,$04,$8E,$00,$FE,$01,$08,$D2,$0E,$06,$6F
	db $F7,$40,$9E,$0F,$0E,$82,$2D,$47,$28,$7A,$68,$7A,$A8,$7A,$AE,$01
	db $DE,$0F,$6D,$C5,$FD

DATA_04D4D2:
	db $48,$0F,$0E,$01,$5E,$02,$BC,$01,$FC,$01,$2C,$82,$41,$52,$4E,$04
	db $67,$25,$68,$24,$69,$24,$BA,$42,$C7,$04,$DE,$0B,$B2,$87,$FE,$02
	db $2C,$E1,$2C,$71,$67,$01,$77,$00,$87,$01,$8E,$00,$EE,$01,$F6,$02
	db $03,$85,$05,$02,$13,$21,$16,$02,$27,$02,$2E,$02,$88,$72,$C7,$20
	db $D7,$07,$E4,$76,$07,$A0,$17,$06,$48,$7A,$76,$20,$98,$72,$79,$E1
	db $88,$62,$9C,$01,$B7,$73,$DC,$01,$F8,$62,$FE,$01,$08,$E2,$0E,$00
	db $6E,$02,$73,$20,$77,$23,$83,$04,$93,$20,$AE,$00,$FE,$0A,$0E,$82
	db $39,$71,$A8,$72,$E7,$73,$0C,$81,$8F,$F2,$30,$AE,$00,$FE,$04,$04
	db $D1,$17,$04,$26,$49,$27,$29,$DF,$F3,$30,$FE,$02,$44,$F6,$7C,$01
	db $8E,$06,$BF,$F7,$40,$EE,$0F,$4D,$C7,$0E,$82,$68,$7A,$AE,$01,$DE
	db $0F,$6D,$C5,$FD

DATA_04D576:
	db $48,$01,$0E,$01,$00,$5A,$3E,$06,$45,$46,$47,$46,$53,$44,$AE,$01
	db $DF,$FA,$40,$4D,$C7,$0E,$81,$00,$5A,$2E,$04,$37,$28,$3A,$48,$46
	db $47,$C7,$07,$CE,$0F,$DF,$FA,$40,$4D,$C7,$0E,$81,$00,$5A,$33,$53
	db $43,$51,$46,$40,$47,$50,$53,$04,$55,$40,$56,$50,$62,$43,$64,$40
	db $65,$50,$71,$41,$73,$51,$83,$51,$94,$40,$95,$50,$A3,$50,$A5,$40
	db $A6,$50,$B3,$51,$B6,$40,$B7,$50,$C3,$53,$DF,$FA,$40,$4D,$C7,$0E
	db $81,$00,$5A,$2E,$02,$36,$47,$37,$52,$3A,$49,$47,$25,$A7,$52,$D7
	db $04,$DF,$FA,$40,$4D,$C7,$0E,$81,$00,$5A,$3E,$02,$44,$51,$53,$44
	db $54,$44,$55,$24,$A1,$54,$AE,$01,$B4,$21,$DF,$FA,$40,$E5,$07,$4D
	db $C7,$FD

DATA_04D608:
	db $41,$01,$B4,$34,$C8,$52,$F2,$51,$47,$D3,$6C,$03,$65,$49,$9E,$07
	db $AF,$02,$3E,$AF,$82,$3E,$BE,$01,$BF,$02,$3E,$BF,$82,$3E,$CC,$03
	db $FE,$07,$0D,$C9,$0F,$02,$3E,$0F,$82,$3E,$1E,$01,$1F,$02,$3E,$1F
	db $82,$3E,$6C,$01,$62,$35,$63,$53,$8A,$41,$AC,$01,$B3,$53,$E9,$51
	db $26,$C3,$27,$33,$63,$43,$64,$33,$BA,$60,$C9,$61,$CE,$0B,$DE,$0F
	db $DF,$03,$3E,$DF,$73,$3E,$E5,$09,$EF,$04,$3E,$EF,$73,$3E,$FF,$0A
	db $3E,$0F,$0A,$BE,$7D,$4A,$7D,$47,$FD

DATA_04D671:
	db $41,$01,$B8,$52,$EA,$41,$27,$B2,$B3,$42,$16,$D4,$4A,$42,$A5,$51
	db $A7,$31,$27,$D3,$08,$E2,$16,$64,$2C,$04,$38,$42,$76,$64,$88,$62
	db $DE,$07,$EF,$02,$3E,$EF,$82,$3E,$FE,$01,$FF,$02,$3E,$FF,$82,$3E
	db $0D,$C9,$23,$32,$31,$51,$98,$52,$0D,$C9,$59,$42,$63,$53,$67,$31
	db $14,$C2,$36,$31,$87,$53,$17,$E3,$29,$61,$30,$62,$3C,$08,$42,$37
	db $59,$40,$6A,$42,$99,$40,$C9,$61,$D7,$63,$39,$D1,$58,$52,$C3,$67
	db $D3,$31,$DC,$06,$F7,$42,$FA,$42,$23,$B1,$43,$67,$C3,$34,$C7,$34
	db $D1,$51,$43,$B3,$47,$33,$9A,$30,$A9,$61,$B8,$62,$BE,$0B,$CE,$0F
	db $CF,$03,$3E,$CF,$73,$3E,$D5,$09,$DF,$04,$3E,$DF,$73,$3E,$EF,$0A
	db $3E,$FF,$0A,$3E,$0F,$0A,$BE,$0D,$4A,$7D,$47,$FD

DATA_04D70D:
	db $49,$0F,$1E,$01,$1F,$00,$34,$2F,$B0,$34,$2F,$C0,$34,$39,$73,$5E
	db $07,$5F,$A1,$3C,$5F,$B0,$38,$6F,$80,$38,$6F,$00,$34,$AE,$0B,$AF
	db $71,$3C,$BF,$30,$34,$1E,$82,$1F,$20,$34,$1F,$A1,$3A,$1F,$70,$36
	db $6E,$88,$6F,$A1,$3C,$7F,$10,$34,$7F,$80,$38,$9E,$02,$9F,$20,$34
	db $9F,$A1,$3A,$9F,$80,$36,$0D,$04,$2E,$0B,$2F,$A1,$3C,$3F,$10,$34
	db $3F,$70,$38,$3E,$0B,$4F,$40,$34,$45,$09,$5F,$42,$28,$5F,$50,$34
	db $6F,$42,$28,$7F,$42,$28,$ED,$47,$FD
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################
;#############################################################################################################
;#############################################################################################################
;#############################################################################################################
;#############################################################################################################
;#############################################################################################################
;#############################################################################################################
;#############################################################################################################
;#############################################################################################################
;#############################################################################################################
;#############################################################################################################
;#############################################################################################################
;#############################################################################################################
;#############################################################################################################
;#############################################################################################################
;#############################################################################################################
;#############################################################################################################

macro DATATABLE_CUSTOM_SMB1_PauseMenuGFX(Address)
namespace SMB1_PauseMenuGFX
%InsertMacroAtXPosition(<Address>)

Main:
	incbin "../SMAS/Graphics/PauseMenuGFX.bin"
End:
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_RT00_SMB1_UploadMainSampleData(Address)
namespace SMB1_UploadMainSampleData
%InsertMacroAtXPosition(<Address>)

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
	LDA.b #SampleData
	STA.b !RAM_SMB1_Global_ScratchRAM00
	LDA.b #SampleData>>8
	STA.b !RAM_SMB1_Global_ScratchRAM01
	LDA.b #SampleData>>16
	STA.b !RAM_SMB1_Global_ScratchRAM02
	JSR.w SMB1_HandleSPCUploads_Main
	RTL
namespace off
endmacro

macro ROUTINE_CUSTOM_RT01_SMB1_UploadMainSampleData(Address)
namespace SMB1_UploadMainSampleData
%InsertMacroAtXPosition(<Address>)

SampleData:
	incbin "../SMAS/SPC700/MainSamples.bin"
SampleDataEnd:
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_RT00_SMB1_UploadSPCEngine(Address)
namespace SMB1_UploadSPCEngine
%InsertMacroAtXPosition(<Address>)

Main:
	LDA.b #SPCEngine
	STA.b !RAM_SMB1_Global_ScratchRAM00
	LDA.b #SPCEngine>>8
	STA.b !RAM_SMB1_Global_ScratchRAM01
	LDA.b #SPCEngine>>16
	STA.b !RAM_SMB1_Global_ScratchRAM02
	JSR.w SMB1_HandleSPCUploads_Main
	RTL
namespace off
endmacro

macro ROUTINE_CUSTOM_RT01_SMB1_UploadSPCEngine(Address)
namespace SMB1_UploadSPCEngine
%InsertMacroAtXPosition(<Address>)

SPCEngine:
	incbin "../SMAS/SPC700/Engine.bin"
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro DATATABLE_CUSTOM_SMB1_SplashScreenGFX(Address)
namespace SMB1_SplashScreenGFX
%InsertMacroAtXPosition(<Address>)

Main:
	incbin "../SMAS/Graphics/SplashScreenGFX.bin"
End:
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_SMB1_HandleSPCUploads(Address)
namespace SMB1_HandleSPCUploads
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
	LDA.b [!RAM_SMB1_Global_ScratchRAM00],y
	INY
	XBA
	LDA.b #$00
	BRA.b CODE_008C24

CODE_008C19:
	XBA
	LDA.b [!RAM_SMB1_Global_ScratchRAM00],y
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
	LDA.b [!RAM_SMB1_Global_ScratchRAM00],y
	INY
	INY
	TAX
	LDA.b [!RAM_SMB1_Global_ScratchRAM00],y
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
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_SMB1_ResetGame(Address)
namespace SMB1_ResetGame
%InsertMacroAtXPosition(<Address>)

Main:
	LDA.b #!ScreenDisplayRegister_SetForceBlank|!ScreenDisplayRegister_MinBrightness00
	STA.w !REGISTER_ScreenDisplayRegister
	STZ.w !REGISTER_HDMAEnable
	STZ.w !RAM_SMB1_Global_HDMAEnableMirror
	STZ.w !REGISTER_IRQNMIAndJoypadEnableFlags
	LDA.b #SMB1_InitAndMainLoop_Main>>16
	PHA
	PLB
	SEI
	STZ.w !REGISTER_IRQNMIAndJoypadEnableFlags
	STZ.w !REGISTER_HDMAEnable
	REP.b #$20
	LDA.w #!RAM_SMB1_Global_StartOfStack
	TCS
	SEP.b #$20
	STZ.w !RAM_SMB1_Global_SoundCh1
	STZ.w !RAM_SMB1_Global_SoundCh2
	STZ.w !RAM_SMB1_Global_MusicCh1
	STZ.w !RAM_SMB1_Global_SoundCh3
	STZ.w !REGISTER_APUPort0
	STZ.w !REGISTER_APUPort1
	STZ.w !REGISTER_APUPort2
	STZ.w !REGISTER_APUPort3
	LDA.b #$F0
	STA.w !REGISTER_APUPort1
	JML.l SMB1_InitAndMainLoop_Main
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_SMB1_DisplayRegionErrorMessage(Address)
namespace SMB1_DisplayRegionErrorMessage
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
	JSL.l SMB1_InitializeRAMOnStartup_Main
	SEP.b #$20
	PHD
	STZ.w !REGISTER_CGRAMAddress
	REP.b #$20
	LDA.w #$3B3B
	STA.b !RAM_SMB1_Global_ScratchRAM02
	LDA.w #!RAM_SMB1_ErrorScreen_TextTilemap
	STA.b !RAM_SMB1_Global_ScratchRAM00
	LDY.b #!RAM_SMB1_ErrorScreen_TextTilemap>>16
	JSL.l SMB1_InitializeSelectedRAM_Entry2
	LDA.w #DMA[$00].Parameters
	TCD
	LDY.b #$80
	STY.w !REGISTER_VRAMAddressIncrementValue
	LDA.w #$7FFF
	STA.w SMB1_ErrorScreen_PaletteMirror[$0C].LowByte
	LDA.w #$7FF9
	STA.w SMB1_ErrorScreen_PaletteMirror[$0D].LowByte
	LDA.w #$7FD0
	STA.w SMB1_ErrorScreen_PaletteMirror[$0E].LowByte
	LDA.w #$6AE9
	STA.w SMB1_ErrorScreen_PaletteMirror[$0F].LowByte
	LDA.w #(!REGISTER_WriteToCGRAMPort&$0000FF<<8)+$00
	STA.b DMA[$00].Parameters
	LDA.w #!RAM_SMB1_ErrorScreen_PaletteMirror
	STA.b DMA[$00].SourceLo
	LDX.b #!RAM_SMB1_ErrorScreen_PaletteMirror>>16
	STX.b DMA[$00].SourceBank
	STA.b DMA[$00].SizeLo
	LDY.b #$01
	STY.w !REGISTER_DMAEnable
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STA.b DMA[$00].Parameters
	LDA.w #$0000
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #SMB1_ErrorMessageFontGFX_Main
	STA.b DMA[$00].SourceLo
	LDX.b #SMB1_ErrorMessageFontGFX_Main>>16
	STX.b DMA[$00].SourceBank
	LDA.w #SMB1_ErrorMessageFontGFX_End-SMB1_ErrorMessageFontGFX_Main
	STA.b DMA[$00].SizeLo
	STY.w !REGISTER_DMAEnable
	PHB
	LDX.b #RegionErrorText>>16
	PHX
	PLB
	LDX.b #$00
CODE_0093F9:
	LDA.w RegionErrorText_Line1,x
	STA.w SMB1_ErrorScreen_TextTilemap[$07].Row+$0A,x
	LDA.w RegionErrorText_Line2,x
	STA.w SMB1_ErrorScreen_TextTilemap[$09].Row+$0A,x
	LDA.w RegionErrorText_Line3,x
	STA.w SMB1_ErrorScreen_TextTilemap[$0B].Row+$0A,x
	LDA.w RegionErrorText_Line4,x
	STA.w SMB1_ErrorScreen_TextTilemap[$11].Row+$0A,x
	INX
	INX
	CPX.b #RegionErrorText_Line2-RegionErrorText_Line1
	BNE.b CODE_0093F9
CODE_009417:
	PLB
	LDA.w #$1000
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #SMB1_OAMBuffer[$00].XDisp
	STA.b DMA[$00].SourceLo
	LDX.b #(SMB1_OAMBuffer[$00].XDisp>>16)&$00
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
	INC.b !RAM_SMB1_Global_FrameCounter
	LDA.b !RAM_SMB1_Global_FrameCounter
	CMP.b #$18
	BNE.b CODE_0094BF
	STZ.b !RAM_SMB1_Global_FrameCounter
	STZ.w !REGISTER_CGRAMAddress
	REP.b #$20
	LDA.w #DMA[$00].Parameters
	TCD
	LDY.b #$80
	STY.w !REGISTER_VRAMAddressIncrementValue
	LDA.w SMB1_ErrorScreen_PaletteMirror[$0D].LowByte
	PHA
	LDA.w SMB1_ErrorScreen_PaletteMirror[$0E].LowByte
	STA.w SMB1_ErrorScreen_PaletteMirror[$0D].LowByte
	LDA.w SMB1_ErrorScreen_PaletteMirror[$0F].LowByte
	STA.w SMB1_ErrorScreen_PaletteMirror[$0E].LowByte
	PLA
	STA.w SMB1_ErrorScreen_PaletteMirror[$0F].LowByte
	LDA.w #(!REGISTER_WriteToCGRAMPort&$0000FF<<8)+$00
	STA.b DMA[$00].Parameters
	LDA.w #!RAM_SMB1_ErrorScreen_PaletteMirror
	STA.b DMA[$00].SourceLo
	LDX.b #!RAM_SMB1_ErrorScreen_PaletteMirror>>16
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

macro ROUTINE_CUSTOM_SMB1_DisplayCopyDetectionErrorMessage(Address)
namespace SMB1_DisplayCopyDetectionErrorMessage
%InsertMacroAtXPosition(<Address>)

table "Tables/Fonts/ErrorScreen.txt"

CopyDetectionText:
if !Define_Global_ROMToAssemble&(!ROM_SMB1_E) != $00
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
	LDA.b #!Define_SMB1_LevelMusic_StopMusicCommand
	STA.w !REGISTER_APUPort2
	JSL.l SMB1_InitializeRAMOnStartup_Main
	SEP.b #$20
	PHD
	STZ.w !REGISTER_CGRAMAddress
	REP.b #$20
	LDA.w #$3B3B
	STA.b !RAM_SMB1_Global_ScratchRAM02
	LDA.w #!RAM_SMB1_ErrorScreen_TextTilemap
	STA.b !RAM_SMB1_Global_ScratchRAM00
	LDY.b #!RAM_SMB1_ErrorScreen_TextTilemap>>16
	JSL.l SMB1_InitializeSelectedRAM_Entry2
	LDA.w #DMA[$00].Parameters
	TCD
	LDY.b #$80
	STY.w !REGISTER_VRAMAddressIncrementValue
	LDA.w #$7FFF
	STA.w SMB1_ErrorScreen_PaletteMirror[$0C].LowByte
	LDA.w #$7FF9
	STA.w SMB1_ErrorScreen_PaletteMirror[$0D].LowByte
	LDA.w #$7FD0
	STA.w SMB1_ErrorScreen_PaletteMirror[$0E].LowByte
	LDA.w #$6AE9
	STA.w SMB1_ErrorScreen_PaletteMirror[$0F].LowByte
	LDA.w #(!REGISTER_WriteToCGRAMPort&$0000FF<<8)+$00
	STA.b DMA[$00].Parameters
	LDA.w #!RAM_SMB1_ErrorScreen_PaletteMirror
	STA.b DMA[$00].SourceLo
	LDX.b #!RAM_SMB1_ErrorScreen_PaletteMirror>>16
	STX.b DMA[$00].SourceBank
	STA.b DMA[$00].SizeLo
	LDY.b #$01
	STY.w !REGISTER_DMAEnable
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STA.b DMA[$00].Parameters
	LDA.w #$0000
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #SMB1_ErrorMessageFontGFX_Main
	STA.b DMA[$00].SourceLo
	LDX.b #SMB1_ErrorMessageFontGFX_Main>>16
	STX.b DMA[$00].SourceBank
	LDA.w #SMB1_ErrorMessageFontGFX_End-SMB1_ErrorMessageFontGFX_Main
	STA.b DMA[$00].SizeLo
	STY.w !REGISTER_DMAEnable
	PHB
	LDX.b #CopyDetectionText>>16
	PHX
	PLB
	LDX.b #$00
CODE_009690:
if !Define_Global_ROMToAssemble&(!ROM_SMB1_E) != $00
	LDA.w CopyDetectionText_Line1,x
	STA.w SMB1_ErrorScreen_TextTilemap[$07].Row+$06,x
	LDA.w CopyDetectionText_Line2,x
	STA.w SMB1_ErrorScreen_TextTilemap[$09].Row+$06,x
	LDA.w CopyDetectionText_Line3,x
	STA.w SMB1_ErrorScreen_TextTilemap[$0B].Row+$06,x
	LDA.w CopyDetectionText_Line4,x
	STA.w SMB1_ErrorScreen_TextTilemap[$0D].Row+$06,x
	LDA.w CopyDetectionText_Line5,x
	STA.w SMB1_ErrorScreen_TextTilemap[$0F].Row+$06,x
	LDA.w CopyDetectionText_Line6,x
	STA.w SMB1_ErrorScreen_TextTilemap[$11].Row+$06,x
	LDA.w CopyDetectionText_Line7,x
	STA.w SMB1_ErrorScreen_TextTilemap[$13].Row+$06,x
else
	LDA.w CopyDetectionText_Line1,x
	STA.w SMB1_ErrorScreen_TextTilemap[$07].Row+$06,x
	LDA.w CopyDetectionText_Line2,x
	STA.w SMB1_ErrorScreen_TextTilemap[$09].Row+$06,x
	LDA.w CopyDetectionText_Line3,x
	STA.w SMB1_ErrorScreen_TextTilemap[$0D].Row+$06,x
	LDA.w CopyDetectionText_Line4,x
	STA.w SMB1_ErrorScreen_TextTilemap[$0F].Row+$06,x
	LDA.w CopyDetectionText_Line5,x
	STA.w SMB1_ErrorScreen_TextTilemap[$11].Row+$06,x
	LDA.w CopyDetectionText_Line6,x
	STA.w SMB1_ErrorScreen_TextTilemap[$13].Row+$06,x
endif
	INX
	INX
	CPX.b #CopyDetectionText_Line2-CopyDetectionText_Line1
	BNE CODE_009690
	JMP.w SMB1_DisplayRegionErrorMessage_CODE_009417
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_SMB1_ErrorMessageFontGFX(Address)
namespace SMB1_ErrorMessageFontGFX
%InsertMacroAtXPosition(<Address>)

Main:
if !Define_Global_ROMToAssemble&(!ROM_SMB1_J) != $00
	incbin "../SMAS/Graphics/ErrorMessageFontGFX_SMAS_J.bin"
else
	incbin "../SMAS/Graphics/ErrorMessageFontGFX_SMAS_U.bin"
endif
End:
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_SMB1_InitializeSelectedRAM(Address)
namespace SMB1_InitializeSelectedRAM
%InsertMacroAtXPosition(<Address>)

Main:
	STZ.b !RAM_SMB1_Global_ScratchRAM02
Entry2:
	STA.w DMA[$00].SourceLo
	STY.w DMA[$00].SourceBank
	LDA.w #(!REGISTER_PPUMultiplicationProductLo&$0000FF<<8)+$80
	STA.w DMA[$00].Parameters
	LDA.b !RAM_SMB1_Global_ScratchRAM00
	STA.w DMA[$00].SizeLo
	LDY.b #$01
	STY.w !REGISTER_Mode7MatrixParameterA
	DEY
	STY.w !REGISTER_Mode7MatrixParameterA
	LDY.b !RAM_SMB1_Global_ScratchRAM02
	STY.w !REGISTER_Mode7MatrixParameterB
	LDY.b #$01
	STY.w !REGISTER_DMAEnable
	RTL
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_SMB1_InitializeRAMOnStartup(Address)
namespace SMB1_InitializeRAMOnStartup
%InsertMacroAtXPosition(<Address>)

Main:
	REP.b #$20
	LDA.w #!RAM_SMB1_Global_StartOfStack-$AF
	STA.b !RAM_SMB1_Global_ScratchRAM00
	LDA.w #$000000
	TAY
	JSL.l SMB1_InitializeSelectedRAM_Main
	LDA.w #$002000-(!RAM_SMB1_Global_StartOfStack+$01)
	STA.b !RAM_SMB1_Global_ScratchRAM00
	LDA.w #!RAM_SMB1_Global_StartOfStack+$01
	TAY
	JSL.l SMB1_InitializeSelectedRAM_Main
	LDA.w #$E000
	STA.b !RAM_SMB1_Global_ScratchRAM00
	LDA.w #$7E2000
	LDY.b #$7E2000>>16
	JSL.l SMB1_InitializeSelectedRAM_Main
	LDA.w #$0000
	STA.b !RAM_SMB1_Global_ScratchRAM00
	LDA.w #$7F0000
	LDY.b #$7F0000>>16
	JSL.l SMB1_InitializeSelectedRAM_Main
	LDA.w #$0000
	STA.l !RAM_SMB1_Global_StripeImageUploadIndexLo
	DEC
	STA.l SMB1_StripeImageUploadTable[$00].LowByte
if !Define_Global_ROMToAssemble&(!ROM_SMB1_E) != $00
	STA.w $1620
endif
	SEP.b #$20
	STA.l !RAM_SMB1_Global_SaveBuffer_2PlayerFlag
	LDA.b #$00
	STA.l !SRAM_SMB1_Global_CopyOfHardModeActiveFlag
	STA.l !SRAM_SMB1_Global_CopyOfCurrentWorld
	STA.l !SRAM_SMAS_Global_InitialSelectedWorld
	REP.b #$20
	PHD
	LDA.w #!REGISTER_ScreenDisplayRegister
	TCD
	SEP.b #$30
	LDA.b #$09
	STA.b !REGISTER_BGModeAndTileSizeSetting
	STA.w !RAM_SMB1_Global_BGModeAndTileSizeSettingMirror
	STZ.b !REGISTER_MosaicSizeAndBGEnable
	STZ.b !REGISTER_BG1And2WindowMaskSettings
	STZ.b !REGISTER_BG3And4WindowMaskSettings
	STZ.b !REGISTER_MainScreenWindowMask
	STZ.b !REGISTER_SubScreenWindowMask
	LDA.b #$03
	STA.b !REGISTER_BG1AddressAndSize
	LDA.b #$13
	STA.b !REGISTER_BG2AddressAndSize
	LDA.b #$51
	STA.b !REGISTER_BG3AddressAndSize
	STZ.b !REGISTER_BG4AddressAndSize
	LDA.b #$22
	STA.b !REGISTER_BG1And2TileDataDesignation
	LDA.b #$05
	STA.b !REGISTER_BG3And4TileDataDesignation
	LDA.b #$15
	STA.b !REGISTER_MainScreenLayers
	STA.w !RAM_SMB1_Global_MainScreenLayersMirror
	LDA.b #$02
	STA.b !REGISTER_SubScreenLayers
	STA.w !RAM_SMB1_Global_SubScreenLayersMirror
	LDA.b #$00
	STA.b !REGISTER_ColorMathInitialSettings
	STA.b !REGISTER_ObjectAndColorWindowSettings
	STA.b !REGISTER_ColorMathSelectAndEnable
	LDA.b #$20
	STA.b !REGISTER_FixedColorData
	ASL
	STA.b !REGISTER_FixedColorData
	ASL
	STA.b !REGISTER_FixedColorData
if !Define_Global_ROMToAssemble&(!ROM_SMB1_E) != $00
	LDA.b #$04
	STA.b !REGISTER_InitialScreenSettings
else
	STZ.b !REGISTER_InitialScreenSettings
endif
	PLD
	RTL
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_SMB1_CheckWhichControllersArePluggedIn(Address)
namespace SMB1_CheckWhichControllersArePluggedIn
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
endmacro

;#############################################################################################################
;#############################################################################################################

macro DATATABLE_CUSTOM_SMB1_CircleHDMAData(Address)
namespace SMB1_CircleHDMAData
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
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_SMB1_LoadSplashScreen(Address)
namespace SMB1_LoadSplashScreen
%InsertMacroAtXPosition(<Address>)

Main:
	PHB
	PHK
	PLB
	REP.b #$20
	LDY.b #$80
	STY.w !REGISTER_VRAMAddressIncrementValue
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STA.w DMA[$00].Parameters
	LDA.w #$0000
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #SMB1_SplashScreenGFX_Main
	STA.w DMA[$00].SourceLo
	LDX.b #SMB1_SplashScreenGFX_Main>>16
	STX.w DMA[$00].SourceBank
	LDA.w #SMB1_SplashScreenGFX_End-SMB1_SplashScreenGFX_Main
	STA.w DMA[$00].SizeLo
	LDY.b #$01
	STY.w !REGISTER_DMAEnable
	LDX.b #$1E
-:
	LDA.w SplashScreenPalette,x
	STA.w SMB1_PaletteMirror[$F0].LowByte,x
	DEX
	DEX
	BPL.b -
	SEP.b #$20
	LDA.b #$20
	STA.w !RAM_SMB1_Global_FixedColorData1Mirror
	ASL
	STA.w !RAM_SMB1_Global_FixedColorData2Mirror
	ASL
	STA.w !RAM_SMB1_Global_FixedColorData3Mirror
	LDA.b #$10
	STA.w !REGISTER_MainScreenLayers
	STA.w !RAM_SMB1_Global_MainScreenLayersMirror
	LDA.b #$00
	STA.w !REGISTER_OAMSizeAndDataAreaDesignation
	STA.w !RAM_SMB1_Global_ScreenDisplayRegisterMirror
	STA.w !REGISTER_ScreenDisplayRegister
	STA.b !RAM_SMB1_SplashScreen_DisplayMarioCoinShineFlag
	STA.b !RAM_SMB1_SplashScreen_PaletteAnimationIndex
	INC.w !RAM_SMB1_Global_UpdateEntirePaletteFlag
	STZ.b !RAM_SMB1_Level_Player_CurrentPhysicsType
	LDA.b #$81
	STA.b !RAM_SMB1_SplashScreen_DisplayTimer
	STA.w !REGISTER_IRQNMIAndJoypadEnableFlags
-:
	JSR.w FadeIn
	LDA.w !RAM_SMB1_Global_ScreenDisplayRegisterMirror
	CMP.b #$0F
	BNE.b -
Loop:
	LDA.b !RAM_SMB1_SplashScreen_DisplayTimer
	CMP.b #$61
	BNE.b CODE_009A9B
	LDA.b #!Define_SMAS_Sound0063_Coin
	STA.w !REGISTER_APUPort3						; Note: SPC stuff is not handled in V-Blank, so it's necessary to write to this register directly.
	STA.b !RAM_SMB1_SplashScreen_DisplayMarioCoinShineFlag
	LDA.b #$02
	STA.b !RAM_SMB1_SplashScreen_PaletteAnimationTimer
	STZ.b !RAM_SMB1_SplashScreen_PaletteAnimationIndex
CODE_009A9B:
	JSR.w SMB1_SplashScreenGFXRt_Main
	LDA.b !RAM_SMB1_SplashScreen_DisplayMarioCoinShineFlag
	BEQ.b CODE_009AA5
	JSR.w SMB1_HandleSplashScreenMarioCoinShine_Main
CODE_009AA5:
	JSR.w WaitForVBlank
	DEC.b !RAM_SMB1_SplashScreen_DisplayTimer
	BNE.b Loop
-:
	JSR.w FadeOut
	LDA.w !RAM_SMB1_Global_ScreenDisplayRegisterMirror
	BNE.b -
	LDA.b #$80
	STA.w !RAM_SMB1_Global_ScreenDisplayRegisterMirror
	STZ.w !REGISTER_IRQNMIAndJoypadEnableFlags
	PLB
	RTL

FadeIn:
	INC.w !RAM_SMB1_Global_ScreenDisplayRegisterMirror
	BRA.b +

FadeOut:
	DEC.w !RAM_SMB1_Global_ScreenDisplayRegisterMirror
+:
	STZ.b !RAM_SMB1_SplashScreen_PaletteAnimationTimer
	JSR.w SMB1_SplashScreenGFXRt_Main
	JSR.w WaitForVBlank
	RTS

WaitForVBlank:
	STZ.w $0154
-:
	LDA.w $0154
	BEQ.b -
	CLI
	RTS

SplashScreenPalette:
	dw $0000,$7FFF,$0048,$012F,$0192,$01F5,$0A59,$171C,$2BBC,$00CC,$0A59,$171C,$2BBC,$53FF,$171C,$0A59
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_SMB1_SplashScreenGFXRt(Address)
namespace SMB1_SplashScreenGFXRt
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
	STA.b !RAM_SMB1_Global_ScratchRAM00
CODE_009E35:
	LDA.b #$60
	STA.b !RAM_SMB1_Global_ScratchRAM01
CODE_009E39:
	LDA.b !RAM_SMB1_Global_ScratchRAM01
	STA.w SMB1_OAMBuffer[$00].XDisp,y
	LDA.b !RAM_SMB1_Global_ScratchRAM00
	STA.w SMB1_OAMBuffer[$00].YDisp,y
	LDA.w Tiles,x
	STA.w SMB1_OAMBuffer[$00].Tile,y
	INX
	LDA.b #$2E
	STA.w SMB1_OAMBuffer[$00].Prop,y
	;PHY
	;TYA
	;LSR
	;LSR
	;TAY
	LDA.b #$02
	STA.w SMB1_OAMTileSizeBuffer[$00].Slot,y
	;PLY
	INY
	INY
	INY
	INY
	LDA.b !RAM_SMB1_Global_ScratchRAM01
	CLC
	ADC.b #$10
	STA.b !RAM_SMB1_Global_ScratchRAM01
	CMP.b #$A0
	BCC.b CODE_009E39
	LDA.b !RAM_SMB1_Global_ScratchRAM00
	CLC
	ADC.b #$10
	STA.b !RAM_SMB1_Global_ScratchRAM00
	CMP.b #$A0
	BCC.b CODE_009E35
	JSL.l SMB1_CompressOAMTileSizeBuffer_Main
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_SMB1_HandleSplashScreenMarioCoinShine(Address)
namespace SMB1_HandleSplashScreenMarioCoinShine
%InsertMacroAtXPosition(<Address>)

DATA_009E75:
	dw $7FFF,$2BBC,$43FF,$171C
	dw $7FFF,$2BBC,$171C,$2BBC
	dw $7FFF,$0A59,$171C,$2BBC

DATA_009E8D:
	dw $53FF,$171C,$0A59,$53FF
	dw $171C,$0A59,$53FF,$7FFF
	dw $2BBC,$53FF,$171C,$0A59

Main:
	LDA.b !RAM_SMB1_SplashScreen_PaletteAnimationIndex
	ASL
	STA.b !RAM_SMB1_Global_ScratchRAM00
	ASL
	CLC
	ADC.b !RAM_SMB1_Global_ScratchRAM00
	TAY
	LDX.b #$00
CODE_009EB1:
	LDA.w DATA_009E75,y
	STA.l SMB1_PaletteMirror[$F6].LowByte,x
	LDA.w DATA_009E8D,y
	STA.l SMB1_PaletteMirror[$FD].LowByte,x
	INY
	INX
	CPX.b #$06
	BCC.b CODE_009EB1
	INC.w !RAM_SMB1_Global_UpdateEntirePaletteFlag
	DEC.b !RAM_SMB1_SplashScreen_PaletteAnimationTimer
	BNE.b CODE_009EE0
	INC.b !RAM_SMB1_SplashScreen_PaletteAnimationIndex
	LDX.b !RAM_SMB1_SplashScreen_PaletteAnimationIndex
	CPX.b #$04
	BCC.b CODE_009EDC
	STZ.b !RAM_SMB1_SplashScreen_PaletteAnimationIndex
	STZ.b !RAM_SMB1_SplashScreen_PaletteAnimationTimer
	STZ.b !RAM_SMB1_SplashScreen_DisplayMarioCoinShineFlag
	BRA.b CODE_009EE0

CODE_009EDC:
	LDA.b #$02
	STA.b !RAM_SMB1_SplashScreen_PaletteAnimationTimer
CODE_009EE0:
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_SMB1_LoadFileSelectMenu(Address)
namespace SMB1_LoadFileSelectMenu
%InsertMacroAtXPosition(<Address>)

Main:
	STZ.b !RAM_SMB1_Global_ScratchRAM06
	JSR.w Sub
	LDA.b !RAM_SMB1_TitleScreen_FileAMaxWorld
	STA.b !RAM_SMB1_TitleScreen_FileASelectedWorld
	LDA.b !RAM_SMB1_TitleScreen_FileBMaxWorld
	STA.b !RAM_SMB1_TitleScreen_FileBSelectedWorld
	LDA.b !RAM_SMB1_TitleScreen_FileCMaxWorld
	STA.b !RAM_SMB1_TitleScreen_FileCSelectedWorld
	RTL

Entry2:
	LDA.b #$01
	STA.b !RAM_SMB1_Global_ScratchRAM06
	JSR.w Sub
	RTL

Sub:
	PHB
	PHK
	PLB
	REP.b #$10
	LDX.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	LDY.w #$0000
--:
	STY.b !RAM_SMB1_Global_ScratchRAM02
	REP.b #$20
	LDA.w FileSelectTextPtrs,y
	JSR.w BufferStripeImage
	LDY.b !RAM_SMB1_Global_ScratchRAM02
	REP.b #$20
	PHX
	LDX.w SMB1_SaveFileLocations_Main,y
	LDA.l !SRAM_SMAS_Global_SaveFileBaseOffset,x
	PHA
	AND.w #$00FF
	STA.b !RAM_SMB1_Global_ScratchRAM00
	LDA.l !SRAM_SMAS_Global_SaveFileBaseOffset+$05,x
	AND.w #$00FF
	ASL
	ASL
	ASL
	CLC
	ADC.b !RAM_SMB1_Global_ScratchRAM00
	STA.b !RAM_SMB1_Global_ScratchRAM04
	PLA
	PLX
	CMP.w #$FFFF
	BEQ.b .NewFile
	LDA.w #FileSelectText_World
	BRA.b .UsedFile

.NewFile:
	LDA.w #FileSelectText_New
.UsedFile:
	JSR.w BufferStripeImage
	LDA.b #$00
	XBA
	LDA.b !RAM_SMB1_Global_ScratchRAM02
	LSR
	TAY
	LDA.b !RAM_SMB1_Global_ScratchRAM04
	BMI.b +
	LDA.b !RAM_SMB1_Global_ScratchRAM06
	BEQ.b ++
	LDA.w !RAM_SMB1_TitleScreen_FileASelectedWorld,y
	AND.b #$07
	BRA.b +++	

++:
	LDA.b !RAM_SMB1_Global_ScratchRAM04
	STA.w !RAM_SMB1_TitleScreen_FileAMaxWorld,y
	STA.w !RAM_SMB1_TitleScreen_FileASelectedWorld,y
	AND.b #$07
+++:
	PHY
	ASL
	TAY
	LDA.w WorldNumberTiles,y
	STA.w SMB1_StripeImageUploadTable[$00].LowByte-$06,x
	LDA.w WorldNumberTiles+$01,y
	STA.w SMB1_StripeImageUploadTable[$00].HighByte-$06,x
	PLY
	LDA.w !RAM_SMB1_TitleScreen_FileASelectedWorld,y
	CMP.b #$08
	BCC.b ++++
	LDA.b #$FE
	STA.w SMB1_StripeImageUploadTable[$00].LowByte-$08,x
	LDA.b #$08
	STA.w SMB1_StripeImageUploadTable[$00].HighByte-$08,x
++++:
	BRA.b ++

+:
	LDA.b #$00
	STA.w !RAM_SMB1_TitleScreen_FileAMaxWorld,y
++:
	LDY.b !RAM_SMB1_Global_ScratchRAM02
	INY
	INY
	CPY.w #$0006
	BEQ.b +
	JMP.w --

+:
	LDY.w #FileSelectText_Erase
	LDA.b !RAM_SMB1_TitleScreen_EraseFileProcess
	BEQ.b +
	LDY.w #FileSelectText_End
+:

	REP.b #$20
	TYA
	JSR.w BufferStripeImage
	STA.w SMB1_StripeImageUploadTable[$00].LowByte,x
	REP.b #$20
	TXA
	STA.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	SEP.b #$30
	PLB
	RTS

FileSelectTextPtrs:
	dw FileSelectText_FileA
	dw FileSelectText_FileB
	dw FileSelectText_FileC
	dw FileSelectText_Erase

WorldNumberTiles:
	db $01,$08
	db $02,$08
	db $03,$08
	db $04,$08
	db $05,$08
	db $06,$08
	db $07,$08
	db $08,$08
	db $09,$08

FileSelectText:
.FileA:
	db $02,$4A,$00,$21
	db $0F,$08,$12,$08,$15,$08,$0E,$08,$24,$00,$0A,$08,$24,$00,$FF

.FileB:
	db $02,$8A,$00,$21
	db $0F,$08,$12,$08,$15,$08,$0E,$08,$24,$00,$0B,$08,$24,$00,$FF

.FileC:
	db $02,$CA,$00,$21
	db $0F,$08,$12,$08,$15,$08,$0E,$08,$24,$00,$0C,$08,$24,$00,$FF

.New:
	db $24,$00,$17,$08,$0E,$08,$20,$08,$24,$00,$24,$00,$24,$00,$24,$00
	db $24,$00,$24,$00,$FF

.World:
	db $24,$00,$20,$08,$18,$08,$1B,$08,$15,$08,$0D,$08,$24,$00,$01,$08
	db $28,$08,$01,$08,$FF

.Erase:
	db $03,$0A,$00,$15
	db $0E,$08,$1B,$08,$0A,$08,$1C,$08,$0E,$08,$24,$00,$0D,$08,$0A,$08
	db $1D,$08,$0A,$08,$24,$00,$FF

.End:
	db $03,$0A,$00,$15
	db $0E,$08,$17,$08,$0D,$08,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00
	db $24,$00,$24,$00,$24,$00,$FF

BufferStripeImage:
	STA.b !RAM_SMB1_Global_ScratchRAM00
	SEP.b #$20
	LDY.w #$0000
-:
	LDA.b (!RAM_SMB1_Global_ScratchRAM00),y
	CMP.b #$FF
	BEQ.b +
	STA.w SMB1_StripeImageUploadTable[$00].LowByte,x
	INX
	INY
	BRA.b -

+:
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_SMB1_LoadPlayerSelectMenu(Address)
namespace SMB1_LoadPlayerSelectMenu
%InsertMacroAtXPosition(<Address>)

Main:
	STZ.b !RAM_SMB1_Global_ScratchRAM06
	JSR.w Sub
	RTL

Entry2:
	LDA.b #$01
	STA.b !RAM_SMB1_Global_ScratchRAM06
	JSR.w Sub
	RTL

Sub:
	PHB
	PHK
	PLB
	LDA.l !RAM_SMB1_Global_SaveBuffer_2PlayerFlag
	INC
	TAX
	LDA.w ShowLineFlags,x
	STA.b !RAM_SMB1_Global_ScratchRAM04
	LDA.b !RAM_SMB1_Global_ScratchRAM06
	BNE.b +
	LDA.w NewCursorPos,x
	STA.w !RAM_SMB1_TitleScreen_MenuSelectionIndex
+:
	REP.b #$10
	LDX.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	LDY.w #$0000
--:
	STY.b !RAM_SMB1_Global_ScratchRAM02
	REP.b #$20
	LDA.w PlayerSelectTextPtrs,y
	STA.b !RAM_SMB1_Global_ScratchRAM00
	LDY.w #$0000
-:
	LDA.b (!RAM_SMB1_Global_ScratchRAM00),y
	STA.w SMB1_StripeImageUploadTable[$00].LowByte,x
	INX
	INX
	INY
	INY
	CPY.w #$0004
	BNE.b -
	LSR.b !RAM_SMB1_Global_ScratchRAM04
	BCS.b .ShowLine
	LDY.w #$0000
	LDA.w #PlayerSelectText_BlankLine
	STA.b !RAM_SMB1_Global_ScratchRAM00
.ShowLine:
	SEP.b #$20
-:
	LDA.b (!RAM_SMB1_Global_ScratchRAM00),y
	CMP.b #$FF
	BEQ.b +
	STA.w SMB1_StripeImageUploadTable[$00].LowByte,x
	INX
	INY
	BRA.b -

+:
	LDY.b !RAM_SMB1_Global_ScratchRAM02
	INY
	INY
	CPY.w #$0004
	BNE.b --
	LDY.w #PlayerSelectText_ControllerType_Jump
	LDA.l !SRAM_SMAS_Global_ControllerTypeX
	REP.b #$20
	BEQ.b +
	LDY.w #PlayerSelectText_ControllerType_Dash
+:
	TYA
	JSR.w SMB1_LoadFileSelectMenu_BufferStripeImage
	STA.w SMB1_StripeImageUploadTable[$00].LowByte,x
	REP.b #$20
	LDA.w #PlayerSelectText_TopScore
	JSR.w SMB1_LoadFileSelectMenu_BufferStripeImage
	STA.w SMB1_StripeImageUploadTable[$00].LowByte,x
	LDA.w !RAM_SMB1_TitleScreen_TopScoreMillionsDigit
	BEQ.b +
	STA.w SMB1_StripeImageUploadTable[$00].LowByte-$0E,x
+:
	LDA.w !RAM_SMB1_TitleScreen_TopScoreHundredThousandsDigit
	STA.w SMB1_StripeImageUploadTable[$00].LowByte-$0C,x
	LDA.w !RAM_SMB1_TitleScreen_TopScoreTenThousandsDigit
	STA.w SMB1_StripeImageUploadTable[$00].LowByte-$0A,x
	LDA.w !RAM_SMB1_TitleScreen_TopScoreThousandsDigit
	STA.w SMB1_StripeImageUploadTable[$00].LowByte-$08,x
	LDA.w !RAM_SMB1_TitleScreen_TopScoreHundredsDigit
	STA.w SMB1_StripeImageUploadTable[$00].LowByte-$06,x
	LDA.w !RAM_SMB1_TitleScreen_TopScoreTensDigit
	STA.w SMB1_StripeImageUploadTable[$00].LowByte-$04,x
	TXA
	STA.w !RAM_SMB1_Global_StripeImageUploadIndexLo
	SEP.b #$30
	PLB
	RTS

ShowLineFlags:
	db $03,$01,$02

NewCursorPos:
	db $00,$00,$01

PlayerSelectTextPtrs:
	dw PlayerSelectText_OnePlayerGame
	dw PlayerSelectText_TwoPlayerGame

PlayerSelectText:
.OnePlayerGame:
	db $02,$4A,$00,$23
	db $01,$08,$24,$00,$19,$08,$15,$08,$0A,$08,$22,$08,$0E,$08,$1B,$08
	db $24,$00,$10,$08,$0A,$08,$16,$08,$0E,$08,$24,$00,$24,$00,$24,$00
	db $24,$00,$24,$00,$FF

.TwoPlayerGame:
	db $02,$8A,$00,$23
	db $02,$08,$24,$00,$19,$08,$15,$08,$0A,$08,$22,$08,$0E,$08,$1B,$08
	db $24,$00,$10,$08,$0A,$08,$16,$08,$0E,$08,$24,$00,$24,$00,$24,$00
	db $24,$00,$24,$00,$FF

.BlankLine:
	db $24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00
	db $24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00
	db $24,$00,$24,$00,$FF

.ControllerType:
..Jump:
	db $02,$CA,$00,$23
	db $0B,$08,$28,$08,$24,$00,$13,$08,$1E,$08,$16,$08,$19,$08,$24,$00
	db $24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00
	db $24,$00,$24,$00,$FF

..Dash:
	db $02,$CA,$00,$23
	db $0B,$08,$28,$08,$24,$00,$0D,$08,$0A,$08,$1C,$08,$11,$08,$24,$00
	db $24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00
	db $24,$00,$24,$00,$FF

.TopScore:
	db $03,$0A,$00,$15
	db $1D,$08,$18,$08,$19,$08,$28,$08,$24,$08,$24,$08,$24,$08,$24,$08
	db $24,$08,$24,$08,$00,$08

	db $FF
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_SMB1_ClearSaveData(Address)
namespace SMB1_ClearSaveData
%InsertMacroAtXPosition(<Address>)

Main:
	LDA.w !RAM_SMB1_TitleScreen_MenuSelectionIndex
	TAY
	ASL
	TAX
	LDA.b #$00
	STA.w !RAM_SMB1_TitleScreen_FileASelectedWorld,y
	STA.w !RAM_SMB1_TitleScreen_FileAMaxWorld,y
	REP.b #$20
	LDA.l SMB1_SaveFileLocations_Main,x
	REP.b #$10
	TAX
	LDA.w #$FFFF
	STA.l !SRAM_SMAS_Global_SaveFileBaseOffset,x
	SEP.b #$30
	JML.l SMB1_VerifySaveDataIsValid_Main
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_SMB1_ChangeSelectedWorld(Address)
namespace SMB1_ChangeSelectedWorld
%InsertMacroAtXPosition(<Address>)

Main:
	PHA
	LDY.w !RAM_SMB1_TitleScreen_MenuSelectionIndex
	LDA.w !RAM_SMB1_TitleScreen_FileAMaxWorld,y
	CMP.b #$01
	BCS.b +
	PLA
	LDA.b #!Define_SMAS_Sound0063_Wrong
	STA.w !RAM_SMB1_Global_SoundCh3
	RTL

+:
	LDA.w !RAM_SMB1_TitleScreen_FileAMaxWorld,y
	INC
	STA.b !RAM_SMB1_Global_ScratchRAM00
	PLA
	BIT.b #$03
	BEQ.b .NoLeftOrRight
	AND.b #$03
	DEC
	TAX
	LDA.l .AdditionTable,x
	BRA.b +

.NoLeftOrRight:
	LDA.b #$01
+:
	CLC
	ADC.w !RAM_SMB1_TitleScreen_FileASelectedWorld,y
	CMP.b #$FF
	BEQ.b .FixUnderflow
	CMP.w !RAM_SMB1_Global_ScratchRAM00
	BCC.b +
	LDA.b #$00
	BRA.b .FixOverflow

.FixUnderflow:
	LDA.w !RAM_SMB1_TitleScreen_FileAMaxWorld,y
+:
.FixOverflow:
	STA.w !RAM_SMB1_TitleScreen_FileASelectedWorld,y
	LDA.b #!Define_SMAS_Sound0063_FinishAddTimerToScore
	STA.w !RAM_SMB1_Global_SoundCh3
	JSL.l SMB1_LoadFileSelectMenu_Entry2
	RTL

.AdditionTable:
	db $01,$FF,$01
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_SMB1_MoveTitleScreenMenuCursor(Address)
namespace SMB1_MoveTitleScreenMenuCursor
%InsertMacroAtXPosition(<Address>)

Main:
	STZ.b !RAM_SMB1_Global_ScratchRAM00
	STA.b !RAM_SMB1_Global_ScratchRAM01
-:
	BIT.b #$0C
	BEQ.b .NoUpOrDown
	AND.b #$0C
	LSR
	LSR
	LSR
	TAX
	LDA.l AdditionTable,x
	BRA.b +

.NoUpOrDown:
	LDA.b #$01
+:
	LDX.b !RAM_SMB1_TitleScreen_FileSelectProcess
	CLC
	ADC.w !RAM_SMB1_TitleScreen_MenuSelectionIndex
	CMP.b #$FF
	BEQ.b .FixUnderflow
	CMP.l NumberOfMenuItems,x
	BCC.b +
	LDA.b #$00
	BRA.b .FixOverflow

.FixUnderflow:
	LDA.l NumberOfMenuItems,x
	DEC
+:
.FixOverflow:
	STA.w !RAM_SMB1_TitleScreen_MenuSelectionIndex
	LDA.b !RAM_SMB1_Global_ScratchRAM00
	BNE.b .Return
	LDA.b !RAM_SMB1_TitleScreen_FileSelectProcess
	BEQ.b .Return
	INC.b !RAM_SMB1_Global_ScratchRAM00
	LDA.l !RAM_SMB1_Global_SaveBuffer_2PlayerFlag
	BMI.b .Return
	;DEC
	TAX
	LDA.l BlankSettingLoc,x
	CMP.w !RAM_SMB1_TitleScreen_MenuSelectionIndex
	BNE.b .Return
	LDA.b !RAM_SMB1_Global_ScratchRAM01
	JMP.w -

.Return:
	LDA.b #!Define_SMAS_Sound0063_Coin
	STA.w !RAM_SMB1_Global_SoundCh3
	RTL

AdditionTable:
	db $01,$FF,$01

BlankSettingLoc:
	db $01,$00

NumberOfMenuItems:
	db $04,$03
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_SMB1_LoadSaveFileData(Address)
namespace SMB1_LoadSaveFileData
%InsertMacroAtXPosition(<Address>)

Main:
	PHB
	LDA.b #!SRAMBankBaseAddress>>16
	PHA
	PLB
	REP.b #$10
	LDY.w #$0007
	STY.b !RAM_SMB1_Global_ScratchRAM04
	LDA.b #$00
	XBA
	LDA.l !RAM_SMB1_TitleScreen_MenuSelectionIndex
	STA.w !SRAM_SMAS_Global_CurrentSaveFile
	ASL
	TAX
	REP.b #$20
	LDA.l SMB1_SaveFileLocations_Main,x
	TAY
	STA.w !SRAM_SMAS_Global_SaveFileIndexLo
	SEP.b #$20
	LDX.w #$0000
CODE_00A61C:
	LDA.w !SRAM_SMAS_Global_SaveFileBaseOffset,y
	STA.l !RAM_SMB1_Global_SaveBuffer_CurrentWorld,x
	INY
	INX
	CPX.b !RAM_SMB1_Global_ScratchRAM04
	BNE.b CODE_00A61C
	SEP.b #$10
	PLB
	LDA.l !SRAM_SMAS_Global_InitialSelectedLevel
	STA.w $0E24
	STA.l !RAM_SMB1_Global_SaveBuffer_CurrentLevel
	LDA.l !SRAM_SMAS_Global_InitialSelectedWorld
	CMP.b #$08
	PHP
	AND.b #$07
	STA.w !RAM_SMB1_Player_CurrentWorld
	STA.l !RAM_SMB1_Global_SaveBuffer_CurrentWorld
	ASL
	ASL
	CLC
	ADC.l !SRAM_SMAS_Global_InitialSelectedLevel
	TAX
	LDA.l UNK_05D272,x
	STA.l !SRAM_SMAS_Global_InitialSelectedLevel
	STA.l $7FFB02
	STA.w !RAM_SMB1_Player_CurrentLevel
	PLP
	LDA.b #$00
	ROL
	STA.l !RAM_SMB1_Global_SaveBuffer_HardModeActiveFlag
	RTL
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_SMB1_VerifySaveDataIsValid(Address)
namespace SMB1_VerifySaveDataIsValid
%InsertMacroAtXPosition(<Address>)

Main:
	PHB
	PHK
	PLB
Loop:
	SEP.b #$20
	LDA.b #$00
	STA.l !SRAM_SMAS_Global_EnableSMASDebugModeFlag
 	STA.l !SRAM_SMAS_Global_ControllerTypeX
	REP.b #$30
	LDA.l !SRAM_SMAS_Global_ValidSaveData1Lo
	CMP.w #$9743
	BNE.b CODE_008C88
	LDA.l !SRAM_SMAS_Global_ValidSaveData2Lo
	CMP.w #$5321
	BEQ.b CODE_008CBF
CODE_008C88:
	SEP.b #$10
	LDA.w #$2000
	STA.b !RAM_SMB1_Global_ScratchRAM00
	LDA.w #!SRAMBankBaseAddress
	LDY.b #!SRAMBankBaseAddress>>16
	JSL.l SMB1_InitializeSelectedRAM_Main
	REP.b #$10
	LDX.w #$0000
CODE_008C9D:
	JSR.w CODE_008D41
	LDA.l !SRAM_SMAS_Global_SaveFileIndexLo
	INC
	STA.l !SRAM_SMAS_Global_SaveFileIndexLo
	CMP.w #$0003
	BCC.b CODE_008C9D
	LDA.w #$9743
	STA.l !SRAM_SMAS_Global_ValidSaveData1Lo
	LDA.w #$5321
	STA.l !SRAM_SMAS_Global_ValidSaveData2Lo
	JMP.w Loop

CODE_008CBF:
	LDA.w #$0000
	STA.l !SRAM_SMAS_Global_SaveFileIndexLo
	TAX
CODE_008CC7:
	LDY.w #$0007
	STZ.b !RAM_SMB1_Global_ScratchRAM00
	STX.b !RAM_SMB1_Global_ScratchRAM02
	SEP.b #$20
CODE_008CD8:
	LDA.l !SRAM_SMAS_Global_SaveFileBaseOffset,x
	CLC
	ADC.b !RAM_SMB1_Global_ScratchRAM00
	STA.b !RAM_SMB1_Global_ScratchRAM00
	LDA.b !RAM_SMB1_Global_ScratchRAM01
	ADC.b #$00
	STA.b !RAM_SMB1_Global_ScratchRAM01
	INX
	DEY
	BNE.b CODE_008CD8
	REP.b #$21
	LDA.b !RAM_SMB1_Global_ScratchRAM00
	ADC.l !SRAM_SMAS_Global_SaveFileBaseOffset,x
	BNE.b CODE_008D07
	INX
	INX
CODE_008CF7:
	LDA.l !SRAM_SMAS_Global_SaveFileIndexLo
	INC
	STA.l !SRAM_SMAS_Global_SaveFileIndexLo
	CMP.w #$0003
	BCS.b CODE_008D12
	BRA.b CODE_008CC7

CODE_008D07:
	REP.b #$30
	LDX.b !RAM_SMB1_Global_ScratchRAM02
	JSR.w CODE_008D41
	STX.b !RAM_SMB1_Global_ScratchRAM02
	BRA.b CODE_008CF7

CODE_008D12:
	SEP.b #$30
	PLB
	RTL

CODE_008D41:
	LDA.w #$0007
	STA.b !RAM_SMB1_Global_ScratchRAM04
	LDY.w #$0000
	STZ.b !RAM_SMB1_Global_ScratchRAM00
	SEP.b #$20
CODE_008D59:
	LDA.w PremadeSaveFileData,y
	STA.l !SRAM_SMAS_Global_SaveFileBaseOffset,x
	CLC
	ADC.b !RAM_SMB1_Global_ScratchRAM00
	STA.b !RAM_SMB1_Global_ScratchRAM00
	LDA.b !RAM_SMB1_Global_ScratchRAM01
	ADC.b #$00
	STA.b !RAM_SMB1_Global_ScratchRAM01
	LDA.w PremadeSaveFileData,y
	INX
	INY
	DEC.b !RAM_SMB1_Global_ScratchRAM04
	BNE.b CODE_008D59
	DEC.b !RAM_SMB1_Global_ScratchRAM05
	BPL.b CODE_008D59
	REP.b #$20
	LDA.w #$0000
	SEC
	SBC.b !RAM_SMB1_Global_ScratchRAM00
	STA.l !SRAM_SMAS_Global_SaveFileBaseOffset,x
	INX
	INX
	RTS

PremadeSaveFileData:
	db $FF,$FF,$FF,$04,$04,$00,$FF,$00,$00
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro DATATABLE_CUSTOM_SMB1_SaveFileLocations(Address)
namespace SMB1_SaveFileLocations
%InsertMacroAtXPosition(<Address>)

Main:
	dw $0000,$0009,$0012
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_SMB1_UploadMusicBank(Address)
namespace SMB1_UploadMusicBank
%InsertMacroAtXPosition(<Address>)

Main:
	SEI
	STZ.w !REGISTER_IRQNMIAndJoypadEnableFlags
	STZ.w !REGISTER_HDMAEnable
	LDA.b #$FF
	STA.w !REGISTER_APUPort1
	LDA.b #SMB1MusicBank
	STA.b !RAM_SMB1_Global_ScratchRAM00
	LDA.b #SMB1MusicBank>>8
	STA.b !RAM_SMB1_Global_ScratchRAM01
	LDA.b #SMB1MusicBank>>16
	STA.b !RAM_SMB1_Global_ScratchRAM02
	JSR.w SMB1_HandleSPCUploads_Main
	RTL
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_SMB1_StoreDataToSaveFileAndUpdateTempChecksum(Address)
namespace SMB1_StoreDataToSaveFileAndUpdateTempChecksum
%InsertMacroAtXPosition(<Address>)

Main:
	STA.l !SRAM_SMAS_Global_SaveFileBaseOffset,x
	INX
	CLC
	ADC.b !RAM_SMB1_Global_ScratchRAM00
	STA.b !RAM_SMB1_Global_ScratchRAM00
	LDA.b !RAM_SMB1_Global_ScratchRAM01
	ADC.b #$00
	STA.b !RAM_SMB1_Global_ScratchRAM01
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################
