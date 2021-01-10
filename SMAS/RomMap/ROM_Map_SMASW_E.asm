
macro SMAS_GameSpecificAssemblySettings()
	!ROM_SMASW_U = $0100							;\ These defines assign each ROM version with a different bit so version difference checks will work. Do not touch them!
	!ROM_SMASW_E = $0200							;|
	!ROM_SMAS_U = $0400							;|
	!ROM_SMAS_E = $0800							;|
	!ROM_SMAS_J1 = $1000							;|
	!ROM_SMAS_J2 = $2000							;/
	!ROM_SMB1_U = $0001							;\ These defines should match the component ROM versions from the respective games' ROM Map files.
	!ROM_SMB1_E = $0002							;|
	!ROM_SMB1_J = $0004							;|
	!ROM_SMBLL_U = $0001							;|
	!ROM_SMBLL_E = $0002							;|
	!ROM_SMBLL_J = $0004							;|
	!ROM_SMB2U_U = $0001							;|
	!ROM_SMB2U_E = $0002							;|
	!ROM_SMB2U_J = $0004							;|
	!ROM_SMB3_U = $0001							;|
	!ROM_SMB3_E = $0002							;|
	!ROM_SMB3_J = $0004							;|
	!ROM_SMW_U = $0001							;|
	!ROM_SMW_J = $0002							;|
	!ROM_SMW_E1 = $0004							;|
	!ROM_SMW_E2 = $0008							;|
	!ROM_SMW_ARCADE = $0010							;/

!Define_Global_SMASGames = !SMASGames_SMB1|!SMASGames_SMBLL|!SMASGames_SMB2U|!SMASGames_SMB3|!SMASGames_SMW		; Which games to assemble when generating a SMAS ROM.
	!SMASGames_None = $00
	!SMASGames_SMB1 = $01
	!SMASGames_SMBLL = $02
	!SMASGames_SMB2U = $04
	!SMASGames_SMB3 = $08
	!SMASGames_SMW = $10

!Define_SMAS_Global_DisableCopyDetection = !FALSE

	%SetROMToAssembleForHack(SMASW_E, !ROMID)
endmacro

macro SMAS_LoadGameSpecificMainSNESFiles()
	incsrc ../Misc_Defines_SMAS.asm
	incsrc ../RAM_Map_SMAS.asm
	incsrc ../Routine_Macros_SMAS.asm
	incsrc ../SNES_Macros_SMAS.asm

if !Define_Global_SMASGames&(!SMASGames_SMB1) != $00
	incsrc ../../SMB1/Misc_Defines_SMB1.asm
	incsrc ../../SMB1/RAM_Map_SMB1.asm
	incsrc ../../SMB1/Routine_Macros_SMB1.asm
	incsrc ../../SMB1/SNES_Macros_SMB1.asm
endif
if !Define_Global_SMASGames&(!SMASGames_SMBLL) != $00
	incsrc ../../SMBLL/Misc_Defines_SMBLL.asm
	incsrc ../../SMBLL/RAM_Map_SMBLL.asm
	incsrc ../../SMBLL/Routine_Macros_SMBLL.asm
	incsrc ../../SMBLL/SNES_Macros_SMBLL.asm
endif
if !Define_Global_SMASGames&(!SMASGames_SMB2U) != $00
	incsrc ../../SMB2U/Misc_Defines_SMB2U.asm
	incsrc ../../SMB2U/RAM_Map_SMB2U.asm
	incsrc ../../SMB2U/Routine_Macros_SMB2U.asm
	incsrc ../../SMB2U/SNES_Macros_SMB2U.asm
endif
if !Define_Global_SMASGames&(!SMASGames_SMB3) != $00
	incsrc ../../SMB3/Misc_Defines_SMB3.asm
	incsrc ../../SMB3/RAM_Map_SMB3.asm
	incsrc ../../SMB3/Routine_Macros_SMB3.asm
	incsrc ../../SMB3/SNES_Macros_SMB3.asm
endif
if !Define_Global_SMASGames&(!SMASGames_SMW) != $00

	!Define_SMW_Global_UseIndividualPaletteFiles = !FALSE			; Set to !TRUE to use individual .tpl files for the global palettes. Otherwise, smw.pal will be inserted.

	incsrc ../../SMW/Misc_Defines_SMW.asm
	incsrc ../../SMW/RAM_Map_SMW.asm
	incsrc ../../SMW/Routine_Macros_SMW.asm
	incsrc ../../SMW/SNES_Macros_SMW.asm
endif
endmacro

macro SMAS_LoadGameSpecificMainSPC700Files()
	incsrc ../SPC700/ARAM_Map_SMAS.asm
	incsrc ../Misc_Defines_SMAS.asm
	incsrc ../SPC700/SPC700_Macros_SMAS.asm

if !Define_Global_SMASGames&(!SMASGames_SMW) != $00
	incsrc ../../SMW/SPC700/ARAM_Map_SMW.asm
	incsrc ../../SMW/Misc_Defines_SMW.asm
	incsrc ../../SMW/SPC700/SPC700_Macros_SMW.asm
endif
endmacro

macro SMAS_LoadGameSpecificMainExtraHardwareFiles()
endmacro

macro SMAS_LoadGameSpecificMSU1Files()
endmacro

macro SMAS_GlobalAssemblySettings()
	!Define_Global_ApplyAsarPatches = !FALSE
	!Define_Global_InsertRATSTags = !TRUE
	!Define_Global_IgnoreCodeAlignments = !FALSE
	!Define_Global_IgnoreOriginalFreespace = !FALSE
	!Define_Global_CompatibleControllers = !Controller_StandardJoypad
	!Define_Global_DisableROMMirroring = !FALSE
	!Define_Global_CartridgeHeaderVersion = $02
	!Define_Global_FixIncorrectChecksumHack = !TRUE
	!Define_Global_ROMFrameworkVer = 1
	!Define_Global_ROMFrameworkSubVer = 0
	!Define_Global_ROMFrameworkSubSubVer = 0
	!Define_Global_AsarChecksum = $A892
	!Define_Global_LicenseeName = "Nintendo"
	!Define_Global_DeveloperName = "Nintendo EAD"
	!Define_Global_ReleaseDate = "1995"
	!Define_Global_BaseROMMD5Hash = "4941387e96ed2841ee3c2de6d1899509"

	!Define_Global_MakerCode = "01"
	!Define_Global_GameCode = "5M  "
	!Define_Global_ReservedSpace = $00,$00,$00,$00,$00,$00
	!Define_Global_ExpansionFlashSize = !ExpansionMemorySize_0KB
	!Define_Global_ExpansionRAMSize = !ExpansionMemorySize_0KB
	!Define_Global_IsSpecialVersion = $00
	!Define_Global_InternalName = "MARIO_ALLSTARS+WORLD "
	!Define_Global_ROMLayout = !ROMLayout_LoROM
	!Define_Global_ROMType = !ROMType_ROM_RAM_SRAM
	!Define_Global_CustomChip = !Chip_None
	!Define_Global_ROMSize = !ROMSize_2_5MB
	!Define_Global_SRAMSize = !SRAMSize_8KB
	!Define_Global_Region = !Region_Europe
	!Define_Global_LicenseeID = $33
	!Define_Global_VersionNumber = $00
	!Define_Global_ChecksumCompliment = !Define_Global_Checksum^$FFFF
	!Define_Global_Checksum = $E9E0
	!UnusedNativeModeVector1 = $FFFF
	!UnusedNativeModeVector2 = $FFFF
	!NativeModeCOPVector = SMAS_VBlankRoutine_EndofVBlank
	!NativeModeBRKVector = $FFFF						; Crash: Dangerous! This will cause unpredictable things to happen if a BRK executes.
	!NativeModeAbortVector = SMAS_VBlankRoutine_EndofVBlank
	!NativeModeNMIVector = SMAS_VBlankRoutine_Main
	!NativeModeResetVector = SMAS_InitAndMainLoop_Main
	!NativeModeIRQVector = SMAS_IRQRoutine_Main
	!UnusedEmulationModeVector1 = $FFFF
	!UnusedEmulationModeVector2 = $FFFF
	!EmulationModeCOPVector = SMAS_VBlankRoutine_EndofVBlank
	!EmulationModeBRKVector = SMAS_VBlankRoutine_EndofVBlank
	!EmulationModeAbortVector = SMAS_VBlankRoutine_EndofVBlank
	!EmulationModeNMIVector = SMAS_VBlankRoutine_EndofVBlank
	!EmulationModeResetVector = SMAS_InitAndMainLoop_Main
	!EmulationModeIRQVector = SMAS_IRQRoutine_Main
	%LoadExtraRAMFile("SRAM_Map_SMAS.asm")
endmacro

macro SMAS_LoadROMMap()
%BANK_START(!BANK_00)
	%ROUTINE_SMAS_InitAndMainLoop(NULLROM)						; $008000
	%ROUTINE_SMAS_ResetToSMASTitleScreen(NULLROM)					; $0080DE
	%ROUTINE_SMAS_CopyOfResetToSMASTitleScreen(NULLROM)				; $008139
	%DATATABLE_SMAS_GameInitAndMainPointers(NULLROM)				; $008194
	%ROUTINE_SMAS_GameMode08_LoadSelectedGame(NULLROM)				; $0081A3
	%ROUTINE_SMAS_GameMode09_LoadGameDemo(NULLROM)					; $00822E
	%ROUTINE_SMAS_VBlankRoutine(NULLROM)						; $008302
	%ROUTINE_SMAS_IRQRoutine(NULLROM)						; $00839D
	%ROUTINE_SMAS_InitializeMostRAM(NULLROM)					; $0083F8
	%ROUTINE_SMAS_UpdateVariousRegisters(NULLROM)					; $00845C
	%ROUTINE_SMAS_InitializeCurrentGamemode(NULLROM)				; $0084DE
	%ROUTINE_SMAS_DMADataBlockToRAM(NULLROM)					; $0086B1
	%ROUTINE_SMAS_InitializeSelectedRAM(NULLROM)					; $0086D2
if !Define_Global_SMASGames&(!SMASGames_SMB1|!SMASGames_SMBLL|!SMASGames_SMB2U|!SMASGames_SMB3|!SMASGames_SMW) != $00
	%ROUTINE_SMAS_CheckWhichControllersArePluggedIn(NULLROM)			; $0086F9
endif
	%ROUTINE_SMAS_PollJoypadInputs(NULLROM)					; $008710
	%ROUTINE_SMAS_ResetSpriteOAMRt(NULLROM)					; $00875D
	%ROUTINE_SMAS_CompressOAMTileSizeBuffer(NULLROM)				; $0087B7
	%ROUTINE_SMAS_PlaySoundEffectsAndMusic(NULLROM)				; $008810
	%ROUTINE_SMAS_TurnOffIO(NULLROM)						; $008872
	%DATATABLE_SMAS_GameModeSettings(NULLROM)					; $008881
	%ROUTINE_SMAS_UploadDataDuringVBlank(NULLROM)					; $008907
	%ROUTINE_SMAS_LoadStripeImage(NULLROM)						; $0089F6
	%ROUTINE_SMAS_GameMode07_InitializeSelectedGame(NULLROM)			; $008A2D
	%ROUTINE_SMAS_UploadSMASSPCEngine(NULLROM)					; $008A8D
	%ROUTINE_RT00_SMAS_UploadMainSampleData(NULLROM)				; $008ACC
	%ROUTINE_SMAS_UploadRandomTitleScreenChatteringSample(NULLROM)			; $008B25
if !Define_Global_SMASGames&(!SMASGames_SMB1|!SMASGames_SMBLL) != $00
	%ROUTINE_SMAS_UploadSMB1MusicBank(NULLROM)					; $008B55
endif
if !Define_Global_SMASGames&(!SMASGames_SMB2U) != $00
	%ROUTINE_SMAS_UploadSMB2UMusicBank(NULLROM)					; $008B65
endif
if !Define_Global_SMASGames&(!SMASGames_SMB3) != $00
	%ROUTINE_SMAS_UploadSMB3LevelMusicBank(NULLROM)				; $008B75
endif
if !Define_Global_SMASGames&(!SMASGames_SMW) != $00
	%ROUTINE_SMAS_UploadSMWSPCEngine(NULLROM)					; $008B85
endif
if !Define_Global_SMASGames&(!SMASGames_SMB3) != $00
	%ROUTINE_RT00_SMB3_UploadMusicBank(NULLROM)					; $008B98
	%ROUTINE_RT01_SMB3_UploadMusicBank(NULLROM)					; $008BB4
endif
	%ROUTINE_SMAS_HandleSPCUploads(NULLROM)					; $008BFD
	%ROUTINE_SMAS_VerifySaveDataIsValid(NULLROM)					; $008C6C
	%DATATABLE_SMAS_PremadeSaveFileDataOffsets(NULLROM)				; $008D91
	%DATATABLE_SMAS_PremadeSaveFileData(NULLROM)					; $008DA1
if !Define_Global_SMASGames&(!SMASGames_SMB1) != $00
	%ROUTINE_SMB1_SaveGame(NULLROM)						; $008EC1
endif
if !Define_Global_SMASGames&(!SMASGames_SMBLL) != $00
	%ROUTINE_SMBLL_SaveGame(NULLROM)						; $00906A
endif
if !Define_Global_SMASGames&(!SMASGames_SMB2U) != $00
	%ROUTINE_SMB2U_SaveGame(NULLROM)						; $009110
	%ROUTINE_SMB2U_UnknownRoutine(NULLROM)						; $0091B7
endif
if !Define_Global_SMASGames&(!SMASGames_SMB3) != $00
	%ROUTINE_SMB3_SaveGame(NULLROM)						; $0091EB
endif
if !Define_Global_SMASGames&(!SMASGames_SMB1|!SMASGames_SMBLL|!SMASGames_SMB2U) != $00
	%ROUTINE_SMAS_StoreDataToSaveFileAndUpdateTempChecksum(NULLROM)		; $0092B4
endif
	%ROUTINE_SMAS_DisplayRegionErrorMessage(NULLROM)				; $0092C5
	%ROUTINE_SMAS_DisplayCopyDetectionErrorMessage(NULLROM)			; $0094C7
if !Define_Global_SMASGames&(!SMASGames_SMB1|!SMASGames_SMBLL|!SMASGames_SMB3) != $00
	%DATATABLE_SMAS_CircleHDMAData(NULLROM)					; $0096BD
endif
	%ROUTINE_SMAS_GameMode00_SplashAndTitleScreen(NULLROM)				; $009980
	%ROUTINE_SMAS_IntroProcessXX_InitializeAndFadeIntoSplashScreen(NULLROM)	; $009A39
	%ROUTINE_SMAS_IntroProcess02_ShowSplashScreen(NULLROM)				; $009A89
	%ROUTINE_SMAS_IntroProcessXX_FadeOutToAndInitializeTitleScreen(NULLROM)	; $009AB3
	%ROUTINE_SMAS_IntroProcess05_CharacterChatterOnTitleScreen(NULLROM)		; $009B5C
	%ROUTINE_SMAS_IntroProcess0B_Unknown(NULLROM)					; $009BC4
	%ROUTINE_SMAS_IntroProcessXX_TurnOnTitleScreenLights(NULLROM)			; $009C14
	%ROUTINE_SMAS_IntroProcess1A_CharacterChatterOnTitleScreenAgain(NULLROM)	; $009C5A
	%ROUTINE_SMAS_IntroProcessXX_TurnOffTitleScreenLights(NULLROM)			; $009CAA
	%ROUTINE_SMAS_IntroProcessXX_PlayTitleScreenMusicOrPause(NULLROM)		; $009CF7
	%ROUTINE_SMAS_IntroProcess19_ResumeChattering(NULLROM)				; $009D02
	%ROUTINE_SMAS_IntroProcess1B_CharactersForgetToPause(NULLROM)			; $009D12
	%ROUTINE_SMAS_IntroProcess1C_CharactersRealizeLightsAreOn(NULLROM)		; $009D71
	%ROUTINE_SMAS_IntroProcess1D_FadeOutToDemo(NULLROM)				; $009D89
	%ROUTINE_SMAS_IntroProcess1E_PlayerPressedStart(NULLROM)			; $009DA0
	%DATATABLE_SMAS_TriangleTransitionEffectGFXPointers(NULLROM)			; $009DAE
	%ROUTINE_SMAS_IntroProcess1F_FadeOutToGameSelectionScreen(NULLROM)		; $009DF4
	%ROUTINE_SMAS_SplashScreenGFXRt(NULLROM)					; $009E2E
	%ROUTINE_SMAS_HandleSplashScreenMarioCoinShine(NULLROM)			; $009E75
	%ROUTINE_SMAS_TitleScreenLogoGFXRt(NULLROM)					; $009EE1
	%ROUTINE_SMAS_GameMode06_FadeOutAfterGameSelect(NULLROM)			; $00A0F5
	%ROUTINE_SMAS_GameMode01_InitializeGameSelectScreen(NULLROM)			; $00A108
	%ROUTINE_RT00_SMAS_GameMode02_GameSelectScreen(NULLROM)			; $00A196
	%DATATABLE_SMAS_SaveFileLocations(NULLROM)					; $00A5CA
	%ROUTINE_SMAS_ClearSaveData(NULLROM)						; $00A5EA
	%ROUTINE_SMAS_LoadSaveFileData(NULLROM)					; $00A607
	%ROUTINE_RT01_SMAS_GameMode02_GameSelectScreen(NULLROM)			; $00A664
	%ROUTINE_SMAS_InitializeFileSelectMenuWindowBuffer(NULLROM)			; $00A66E
	%ROUTINE_SMAS_MakeFileSelectYoshiBlink(NULLROM)				; $00A867
	%ROUTINE_SMAS_MakeFileSelectYoshiLick(NULLROM)					; $00A8C3
	%ROUTINE_SMAS_DisplaySMB1FileSelectWindow(NULLROM)				; $00A99A
	%ROUTINE_SMAS_DisplaySMBLLFileSelectWindow(NULLROM)				; $00AA34
	%ROUTINE_SMAS_DisplaySMB2UFileSelectWindow(NULLROM)				; $00AB05
	%ROUTINE_SMAS_DisplaySMB3FileSelectWindow(NULLROM)				; $00ABD4
	%ROUTINE_SMAS_DisplaySMWFileSelectWindow(NULLROM)				; $00AC80
	%ROUTINE_SMAS_BufferSaveFileDisplayInformation(NULLROM)			; $00ADCB
	%ROUTINE_SMAS_BufferPlayerCountOnFile(NULLROM)					; $00AE86
	%ROUTINE_SMAS_BufferFileSelectWindow(NULLROM)					; $00AED3
	%ROUTINE_SMAS_ClearFileSelectWindow(NULLROM)					; $00AFA4
	%ROUTINE_SMAS_UpdateControllerTypeDisplay(NULLROM)				; $00B0C7
	%ROUTINE_SMAS_UpdateFileSelectCursorPosition(NULLROM)				; $00B14C
	%ROUTINE_SMAS_UpdateStartingAreaDisplay(NULLROM)				; $00B1B7
	%ROUTINE_SMAS_GameMode03_InitializeEraseFileMenu(NULLROM)			; $00B2AB
	%ROUTINE_SMAS_UpdateEraseFileMenuDisplay(NULLROM)				; $00B355
	%ROUTINE_SMAS_GameMode05_CloseEraseFileMenu(NULLROM)				; $00B37E
	%DATATABLE_RT00_SMAS_FileSelectMenuData(NULLROM)				; $00B421
	%ROUTINE_SMAS_GameMode04_ShowEraseFileMenu(NULLROM)				; $00B51F
	%ROUTINE_SMAS_ClearSMWSaveData(NULLROM)					; $00B6A8
	%DATATABLE_RT01_SMAS_FileSelectMenuData(NULLROM)				; $00B6D6
	%ROUTINE_SMAS_HandleExtaTitleScreenMarioAndYoshiAnimation(NULLROM)		; $00B717
	%ROUTINE_SMAS_HandleTitleScreenCharactersAnimation(NULLROM)			; $00B73F
	%ROUTINE_SMAS_InitializeTitleScreenTilemap(NULLROM)				; $00B783
	%ROUTINE_SMAS_AnimateTitleScreenLuigi(NULLROM)					; $00B7B9
	%ROUTINE_SMAS_AnimateTitleScreenPeach(NULLROM)					; $00B81B
	%ROUTINE_SMAS_AnimateTitleScreenToad(NULLROM)					; $00B83C
	%ROUTINE_SMAS_AnimateTitleScreenBirdo(NULLROM)					; $00B87E
	%ROUTINE_SMAS_AnimateTitleScreenGoomba(NULLROM)				; $00B8C9
	%ROUTINE_SMAS_AnimateTitleScreenPidgit(NULLROM)				; $00B8FA			
	%ROUTINE_SMAS_AnimateTitleScreenMario(NULLROM)					; $00B91F
	%ROUTINE_SMAS_AnimateTitleScreenBowser(NULLROM)				; $00B9D6
	%ROUTINE_SMAS_AnimateTitleScreenYoshi(NULLROM)					; $00BA0D
	%ROUTINE_SMAS_WriteToTitleScreenBuffer(NULLROM)				; $00BA72
	%DATATABLE_SMAS_TitleScreenAnimationData(NULLROM)				; $00BA98
	%ROUTINE_SMAS_HandlTitleLogoShineAnimation(NULLROM)				; $00BED2
	%FREE_BYTES(NULLROM, 2, $FF)
if !Define_Global_SMASGames&(!SMASGames_SMBLL) != $00
	%SMBLLBank00Macros(!BANK_00, !BANK_00)
endif
	%FREE_BYTES(NULLROM, 6636, $FF)
%BANK_END(!BANK_00)

;#############################################################################################################
;#############################################################################################################

%BANK_START(!BANK_01)
	%DATATABLE_RT00_SMAS_TitleScreenGFX(NULLROM)					; $018000
%BANK_END(!BANK_01)

;#############################################################################################################
;#############################################################################################################

%BANK_START(!BANK_02)
	%DATATABLE_SMAS_TitleScreenTextGFX(NULLROM)					; $028000
if !Define_Global_SMASGames&(!SMASGames_SMW) != $00
	%ROUTINE_RT01_SMW_UploadPlayerGFX(NULLROM)					; $02A000
endif
%BANK_END(!BANK_02)

;#############################################################################################################
;#############################################################################################################

if !Define_Global_SMASGames&(!SMASGames_SMB1) != $00
	%SMB1Bank03Macros(!BANK_03, !BANK_03)
	%SMB1Bank04Macros(!BANK_04, !BANK_04)
else
%BANK_START(!BANK_03)
SMB1_InitAndMainLoop_Main:
	JMP.w ++

SMB1_InitAndMainLoop_NMIVector:
	JMP.w +

SMB1_InitAndMainLoop_IRQVector:
+:
	RTL

++:
	JML.l SMAS_ResetToSMASTitleScreen_Main

%BANK_END(!BANK_03)
	if !Define_Global_SMASGames&(!SMASGames_SMBLL) != $00
		%BANK_START(!BANK_04)
			%SMBLLBank04Macros(!BANK_04, !BANK_04)
		%BANK_END(!BANK_04)
	endif
endif

;#############################################################################################################
;#############################################################################################################

%BANK_START(!BANK_05)
if !Define_Global_SMASGames&(!SMASGames_SMB1) != $00
	%SMB1Bank05Macros(!BANK_05, !BANK_05)
endif
	%DATATABLE_SMAS_SplashScreenGFX(NULLROM)					; $05F000
%BANK_END(!BANK_05)

;#############################################################################################################
;#############################################################################################################

if !Define_Global_SMASGames&(!SMASGames_SMB1) != $00
	%SMB1Bank06Macros(!BANK_06, !BANK_06)
endif

;#############################################################################################################
;#############################################################################################################

%BANK_START(!BANK_07)
if !Define_Global_SMASGames&(!SMASGames_SMB1) != $00
	%SMB1Bank07Macros(!BANK_07, !BANK_07)
elseif !Define_Global_SMASGames&(!SMASGames_SMBLL) != $00
	%SMBLLBank07Macros(!BANK_07, !BANK_07)
endif
if !Define_Global_SMASGames&(!SMASGames_SMB3) != $00
	%ROUTINE_RT02_SMB3_UploadMusicBank(NULLROM)					; $07C000
endif
	%DATATABLE_SMAS_TriangleTransitionalEffectGFX(NULLROM)				; $07E800
	%DATATABLE_SMAS_TriangleTransitionalEffectTilemap(NULLROM)			; $07F000
	%DATATABLE_SMAS_TitleScreenPalettes(NULLROM)					; $07F800
	%DATATABLE_RT00_SMAS_SPCEngine(NULLROM)						; $07FC00
%BANK_END(!BANK_07)

;#############################################################################################################
;#############################################################################################################

if !Define_Global_SMASGames&(!SMASGames_SMB1) != $00
	%SMB1Bank08Macros(!BANK_08, !BANK_08)
	%SMB1Bank09Macros(!BANK_09, !BANK_09)
	%SMB1Bank0AMacros(!BANK_0A, !BANK_0A)
elseif !Define_Global_SMASGames&(!SMASGames_SMBLL) != $00
	%SMBLLBank08Macros(!BANK_08, !BANK_08)
	%SMBLLBank09Macros(!BANK_09, !BANK_09)
	%SMBLLBank0AMacros(!BANK_0A, !BANK_0A)
endif

;#############################################################################################################
;#############################################################################################################

%BANK_START(!BANK_0B)
	%ROUTINE_RT01_SMAS_UploadMainSampleData(NULLROM)				; $0B8000
	%FREE_BYTES($0BFC9C, 868, $FF)
%BANK_END(!BANK_0B)

;#############################################################################################################
;#############################################################################################################

%BANK_START(!BANK_0C)
if !Define_Global_SMASGames&(!SMASGames_SMB3) != $00
	%ROUTINE_RT03_SMB3_UploadMusicBank(NULLROM)					; $0C8000
endif
	%FREE_BYTES(NULLROM, 2955, $FF)
	%DATATABLE_SMAS_GameSelectScreenTilemap(NULLROM)				; $0CC000
if !Define_Global_SMASGames&(!SMASGames_SMB3) != $00
	%DATATABLE_SMB3_Bank0CGraphics(NULLROM)					; $0CD000
endif
if !Define_Global_SMASGames&(!SMASGames_SMB1) != $00
	%SMB1Bank0CMacros(!BANK_0C, !BANK_0C)
elseif !Define_Global_SMASGames&(!SMASGames_SMBLL) != $00
	%SMBLLBank0CMacros(!BANK_0C, !BANK_0C)
endif
%BANK_END(!BANK_0C)

;#############################################################################################################
;#############################################################################################################

if !Define_Global_SMASGames&(!SMASGames_SMBLL) != $00
	%SMBLLBank0DMacros(!BANK_0D, !BANK_0D)
	%SMBLLBank0EMacros(!BANK_0E, !BANK_0E)
	%SMBLLBank0FMacros(!BANK_0F, !BANK_0F)
	%SMBLLBank10Macros(!BANK_10, !BANK_10)
else
%BANK_START(!BANK_0D)
SMBLL_InitAndMainLoop_Main:
	JMP.w ++

SMBLL_InitAndMainLoop_NMIVector:
	JMP.w +

SMBLL_InitAndMainLoop_IRQVector:
+:
	RTL

++:
	JML.l SMAS_ResetToSMASTitleScreen_Main
%BANK_END(!BANK_0D)
endif

;#############################################################################################################
;#############################################################################################################

if !Define_Global_SMASGames&(!SMASGames_SMB2U) != $00
	%SMB2UBank11Macros(!BANK_11, !BANK_11)
	%SMB2UBank12Macros(!BANK_12, !BANK_12)
	%SMB2UBank13Macros(!BANK_13, !BANK_13)
	%SMB2UBank14Macros(!BANK_14, !BANK_14)
	%SMB2UBank15Macros(!BANK_15, !BANK_15)
	%SMB2UBank16Macros(!BANK_16, !BANK_16)
	%SMB2UBank17Macros(!BANK_17, !BANK_17)
	%SMB2UBank18Macros(!BANK_18, !BANK_18)
else
%BANK_START(!BANK_11)
SMB2U_InitAndMainLoop_Main:
	JMP.w ++

SMB2U_InitAndMainLoop_NMIVector:
	JMP.w +

SMB2U_InitAndMainLoop_IRQVector:
+:
	RTL

++:
	JML.l SMAS_ResetToSMASTitleScreen_Main
%BANK_END(!BANK_11)
endif

;#############################################################################################################
;#############################################################################################################

%BANK_START(!BANK_19)
if !Define_Global_SMASGames&(!SMASGames_SMB2U) != $00
	%SMB2UBank19_00Macros(!BANK_19, !BANK_19)
endif
	%DATATABLE_SMAS_ErrorMessageFontGFX(NULLROM)					; $199800
if !Define_Global_SMASGames&(!SMASGames_SMB2U) != $00
	%SMB2UBank19_01Macros(!BANK_19, !BANK_19)
endif
%BANK_END(!BANK_19)

;#############################################################################################################
;#############################################################################################################

if !Define_Global_SMASGames&(!SMASGames_SMB1|!SMASGames_SMBLL|!SMASGames_SMB2U) != $00
%BANK_START(!BANK_1A)
	if !Define_Global_SMASGames&(!SMASGames_SMB2U) != $00
		%DATATABLE_SMB2U_Bank1AGraphics($1A8000)
	endif
	if !Define_Global_SMASGames&(!SMASGames_SMB1) != $00
		%SMB1Bank1AMacros(!BANK_1A, !BANK_1A)
		%FREE_BYTES(NULLROM, 4096, $FF)
	elseif !Define_Global_SMASGames&(!SMASGames_SMBLL) != $00
		%SMBLLBank1AMacros(!BANK_1A, !BANK_1A)
		%FREE_BYTES(NULLROM, 4096, $FF)
	endif
%BANK_END(!BANK_1A)
endif

;#############################################################################################################
;#############################################################################################################

if !Define_Global_SMASGames&(!SMASGames_SMB2U) != $00
	%SMB2UBank1BMacros(!BANK_1B, !BANK_1B)
	%SMB2UBank1CMacros(!BANK_1C, !BANK_1C)
	%SMB2UBank1DMacros(!BANK_1D, !BANK_1D)
endif

;#############################################################################################################
;#############################################################################################################

if !Define_Global_SMASGames&(!SMASGames_SMB1|!SMASGames_SMBLL|!SMASGames_SMB2U) != $00
%BANK_START(!BANK_1E)
	if !Define_Global_SMASGames&(!SMASGames_SMB2U) != $00
		%SMB2UBank1EMacros(!BANK_1E, !BANK_1E)
	endif
	if !Define_Global_SMASGames&(!SMASGames_SMB1) != $00
		%SMB1Bank1EMacros(!BANK_1E, !BANK_1E)
	elseif !Define_Global_SMASGames&(!SMASGames_SMBLL) != $00
		%SMBLLBank1EMacros(!BANK_1E, !BANK_1E)
	endif
%BANK_END(!BANK_1E)
endif

;#############################################################################################################
;#############################################################################################################

if !Define_Global_SMASGames&(!SMASGames_SMB1|!SMASGames_SMBLL|!SMASGames_SMB2U) != $00
%BANK_START(!BANK_1F)
	if !Define_Global_SMASGames&(!SMASGames_SMB1) != $00
		%SMB1Bank1FMacros(!BANK_1F, !BANK_1F)
		%FREE_BYTES(NULLROM, 2199, $FF)
	elseif !Define_Global_SMASGames&(!SMASGames_SMBLL) != $00
		%SMBLLBank1FMacros(!BANK_1F, !BANK_1F)
		%FREE_BYTES(NULLROM, 2199, $FF)
	endif
	if !Define_Global_SMASGames&(!SMASGames_SMB2U) != $00
		%ROUTINE_RT01_SMB2U_UploadMusicBank($1FC000)
	endif
	%FREE_BYTES(NULLROM, 4906, $FF)
%BANK_END(!BANK_1F)
endif

;#############################################################################################################
;#############################################################################################################

if !Define_Global_SMASGames&(!SMASGames_SMB3) != $00
	%SMB3Bank20Macros(!BANK_20, !BANK_20)
	%SMB3Bank21Macros(!BANK_21, !BANK_21)
	%SMB3Bank22Macros(!BANK_22, !BANK_22)
	%SMB3Bank23Macros(!BANK_23, !BANK_23)
	%SMB3Bank24Macros(!BANK_24, !BANK_24)
	%SMB3Bank25Macros(!BANK_25, !BANK_25)
	%SMB3Bank26Macros(!BANK_26, !BANK_26)
	%SMB3Bank27Macros(!BANK_27, !BANK_27)
	%SMB3Bank28Macros(!BANK_28, !BANK_28)
	%SMB3Bank29Macros(!BANK_29, !BANK_29)
	%SMB3Bank2AMacros(!BANK_2A, !BANK_2A)
else
%BANK_START(!BANK_20)
SMB3_InitAndMainLoop_Main:
	JMP.w ++

SMB3_InitAndMainLoop_NMIVector:
	JMP.w +

SMB3_InitAndMainLoop_IRQVector:
+:
	RTL

++:
	JML.l SMAS_ResetToSMASTitleScreen_Main
%BANK_END(!BANK_20)
endif

;#############################################################################################################
;#############################################################################################################

if !Define_Global_SMASGames&(!SMASGames_SMW) != $00
	%SMWBank0CMacros(!BANK_2B, !BANK_2B)
	%SMWBank0DMacros(!BANK_2C, !BANK_2C)
endif

;#############################################################################################################
;#############################################################################################################

if !Define_Global_SMASGames&(!SMASGames_SMB3) != $00
%BANK_START(!BANK_2D)
	%DATATABLE_SMB3_Bank2DGraphics($2D8000)
%BANK_END(!BANK_2D)

%BANK_START(!BANK_2E)
	%DATATABLE_SMB3_Bank2EGraphics($2E8000)
%BANK_END(!BANK_2E)
endif

;#############################################################################################################
;#############################################################################################################

if !Define_Global_SMASGames&(!SMASGames_SMB1|!SMASGames_SMBLL|!SMASGames_SMB2U) != $00
	%BANK_START(!BANK_2F)
	if !Define_Global_SMASGames&(!SMASGames_SMB2U) != $00
		%SMB2UBank2FMacros(!BANK_2F, !BANK_2F)
	endif
	if !Define_Global_SMASGames&(!SMASGames_SMB1) != $00
		%SMB1Bank2FMacros(!BANK_2F, !BANK_2F)
	elseif !Define_Global_SMASGames&(!SMASGames_SMBLL) != $00
		%SMBLLBank2FMacros(!BANK_2F, !BANK_2F)
	endif
	%BANK_END(!BANK_2F)
endif

;#############################################################################################################
;#############################################################################################################

if !Define_Global_SMASGames&(!SMASGames_SMW) != $00
	%SMWBank00Macros(!BANK_30, !BANK_30)
	%SMWBank01Macros(!BANK_31, !BANK_31)
	%SMWBank02Macros(!BANK_32, !BANK_32)
	%SMWBank03Macros(!BANK_33, !BANK_33)
	%SMWBank04Macros(!BANK_34, !BANK_34)
	%SMWBank05Macros(!BANK_35, !BANK_35)
	%SMWBank06Macros(!BANK_36, !BANK_36)
	%SMWBank07Macros(!BANK_37, !BANK_37)
else
%BANK_START(!BANK_30)
SMW_InitAndMainLoop_Main:
	JMP.w ++

SMW_InitAndMainLoop_NMIVector:
	JMP.w +

SMW_InitAndMainLoop_IRQVector:
+:
	RTL

++:
	JML.l SMAS_ResetToSMASTitleScreen_Main
%BANK_END(!BANK_30)
endif

;#############################################################################################################
;#############################################################################################################

%BANK_START(!BANK_38)
if !Define_Global_SMASGames&(!SMASGames_SMB3) != $00
	%DATATABLE_RT00_SMB3_Bank38Graphics(NULLROM)					; $388000
endif
if !Define_Global_SMASGames&(!SMASGames_SMB1|!SMASGames_SMBLL|!SMASGames_SMB3) != $00
	%DATATABLE_SMAS_PauseMenuGFX(NULLROM)						; $38B000
endif
if !Define_Global_SMASGames&(!SMASGames_SMB3) != $00
	%DATATABLE_SMB3_BattleModeResultsScreenTilemap(NULLROM)			; $38B800
	%DATATABLE_RT01_SMB3_Bank38Graphics(NULLROM)					; $38C000
endif
%BANK_END(!BANK_38)

;#############################################################################################################
;#############################################################################################################

if !Define_Global_SMASGames&(!SMASGames_SMB3) != $00
%BANK_START(!BANK_39)
	%DATATABLE_SMB3_Bank39Graphics($398000)
%BANK_END(!BANK_39)

%BANK_START(!BANK_3A)
	%DATATABLE_SMB3_Bank3AGraphics($3A8000)
%BANK_END(!BANK_3A)
endif

;#############################################################################################################
;#############################################################################################################

%BANK_START(!BANK_3B)
	%DATATABLE_RT01_SMAS_SPCEngine(NULLROM)					; $3B8000
%BANK_END(!BANK_3B)

;#############################################################################################################
;#############################################################################################################

%BANK_START(!BANK_3C)
	%DATATABLE_SMAS_TitleScreenTilemap(NULLROM)					; $3C8000
if !Define_Global_SMASGames&(!SMASGames_SMB3) != $00
	%DATATABLE_RT00_SMB3_Palettes(NULLROM)						; $3C8800
endif
	%DATATABLE_SMAS_BlankPalette(NULLROM)						; $3C8E00
if !Define_Global_SMASGames&(!SMASGames_SMB3) != $00
	%DATATABLE_RT01_SMB3_Palettes(NULLROM)						; $3C9000
endif
	%DATATABLE_SMAS_GameSelectScreenPalette(NULLROM)				; $3CB400
	%FREE_BYTES(NULLROM, 4096, $FF)
if !Define_Global_SMASGames&(!SMASGames_SMB3) != $00
	%DATATABLE_RT00_SMB3_CompressedTilemaps(NULLROM)				; $3CC600
	%FREE_BYTES(NULLROM, 192, $FF)							;
	%DATATABLE_RT01_SMB3_CompressedTilemaps(NULLROM)				; $3CD000
	%FREE_BYTES(NULLROM, 173, $FF)							;
	%DATATABLE_RT02_SMB3_CompressedTilemaps(NULLROM)				; $3CD800
	%FREE_BYTES(NULLROM, 43, $FF)								;
	%DATATABLE_RT03_SMB3_CompressedTilemaps(NULLROM)				; $3CE100
	%FREE_BYTES(NULLROM, 86, $FF)								;
	%DATATABLE_RT04_SMB3_CompressedTilemaps(NULLROM)				; $3CE600
	%FREE_BYTES(NULLROM, 102, $FF)							;
	%DATATABLE_RT05_SMB3_CompressedTilemaps(NULLROM)				; $3CEA00
	%FREE_BYTES(NULLROM, 218, $FF)							;
	%DATATABLE_RT06_SMB3_CompressedTilemaps(NULLROM)				; $3CED00
	%FREE_BYTES(NULLROM, 148, $FF)							;
	%DATATABLE_RT07_SMB3_CompressedTilemaps(NULLROM)				; $3CEF00
	%FREE_BYTES(NULLROM, 1630, $FF)							;
endif
%BANK_END(!BANK_3C)

;#############################################################################################################
;#############################################################################################################

%BANK_START(!BANK_3D)
if !Define_Global_SMASGames&(!SMASGames_SMB3) != $00
	%DATATABLE_RT00_SMB3_Bank3DGraphics(NULLROM)					; $3D8000
endif
	%DATATABLE_SMAS_BlankGameSelectScreenGFXFile($3DA800)
if !Define_Global_SMASGames&(!SMASGames_SMB3) != $00
	%DATATABLE_RT01_SMB3_Bank3DGraphics(NULLROM)					; $3DB000
endif
	%DATATABLE_RT01_SMAS_TitleScreenGFX(NULLROM)					; $3DC000
if !Define_Global_SMASGames&(!SMASGames_SMB3) != $00
	%DATATABLE_RT02_SMB3_Bank3DGraphics(NULLROM)					; $3DE000
endif
	%FREE_BYTES(NULLROM, 2048, $FF)
%BANK_END(!BANK_3D)

;#############################################################################################################
;#############################################################################################################

if !Define_Global_SMASGames&(!SMASGames_SMB3) != $00
%BANK_START(!BANK_3E)
	%DATATABLE_SMB3_Bank3EGraphics($3E8000)
%BANK_END(!BANK_3E)

%BANK_START(!BANK_3F)
	%DATATABLE_SMB3_Bank3FGraphics($3F8000)
%BANK_END(!BANK_3F)

%BANK_START(!BANK_40)
	%DATATABLE_SMB3_Bank40Graphics($408000)
%BANK_END(!BANK_40)

%BANK_START(!BANK_41)
	%DATATABLE_SMB3_Bank41Graphics($418000)
%BANK_END(!BANK_41)

%BANK_START(!BANK_42)
	%DATATABLE_SMB3_Bank42Graphics($428000)
%BANK_END(!BANK_42)

%BANK_START(!BANK_43)
	%DATATABLE_SMB3_Bank43Graphics($438000)
%BANK_END(!BANK_43)

%BANK_START(!BANK_44)
	%DATATABLE_SMB3_Bank44Graphics($448000)
%BANK_END(!BANK_44)

%BANK_START(!BANK_45)
	%DATATABLE_SMB3_Bank45Graphics($458000)
%BANK_END(!BANK_45)

%BANK_START(!BANK_46)
	%DATATABLE_SMB3_Bank46Graphics($468000)
%BANK_END(!BANK_46)

%BANK_START(!BANK_47)
	%DATATABLE_SMB3_Bank47Graphics($478000)
%BANK_END(!BANK_47)
endif

;#############################################################################################################
;#############################################################################################################

%BANK_START(!BANK_48)
	%DATATABLE_RT00_SMAS_BoxArtGFX(NULLROM)					; $488000
%BANK_END(!BANK_48)

;#############################################################################################################
;#############################################################################################################

%BANK_START(!BANK_49)
	%DATATABLE_RT01_SMAS_BoxArtGFX(NULLROM)					; $498000
	%DATATABLE_SMAS_FileSelectGFX(NULLROM)						; $49D800
%BANK_END(!BANK_49)

;#############################################################################################################
;#############################################################################################################

if !Define_Global_SMASGames&(!SMASGames_SMW) != $00
	%SMWBank08Macros(!BANK_4A, !BANK_4D)
	%SMWBank0EMacros(!BANK_4E, !BANK_4E)
	%SMWBank0FMacros(!BANK_4F, !BANK_4F)
endif

;#############################################################################################################
;#############################################################################################################
endmacro
