
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
	!ROM_SMB3_J = $0004							;/

!Define_Global_SMASGames = !SMASGames_SMB1|!SMASGames_SMBLL|!SMASGames_SMB2U|!SMASGames_SMB3		; Which games to assemble when generating a SMAS ROM.
	!SMASGames_None = $00
	!SMASGames_SMB1 = $01
	!SMASGames_SMBLL = $02
	!SMASGames_SMB2U = $04
	!SMASGames_SMB3 = $08
	!SMASGames_SMW = $00

!Define_SMAS_Global_DisableCopyDetection = !FALSE

	%SetROMToAssembleForHack(SMAS_J1, !ROMID)
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
endmacro

macro SMAS_LoadGameSpecificMainSPC700Files()
	incsrc ../SPC700/ARAM_Map_SMAS.asm
	incsrc ../Misc_Defines_SMAS.asm
	incsrc ../SPC700/SPC700_Macros_SMAS.asm
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
	!Define_Global_CartridgeHeaderVersion = $00
	!Define_Global_FixIncorrectChecksumHack = !FALSE
	!Define_Global_ROMFrameworkVer = 1
	!Define_Global_ROMFrameworkSubVer = 0
	!Define_Global_ROMFrameworkSubSubVer = 0
	!Define_Global_AsarChecksum = $0000
	!Define_Global_LicenseeName = "Nintendo"
	!Define_Global_DeveloperName = "Nintendo EAD"
	!Define_Global_ReleaseDate = "July 14, 1993"
	!Define_Global_BaseROMMD5Hash = "0b6d70d07523a8804cbbb94b154510a2"

	!Define_Global_MakerCode = "01"
	!Define_Global_GameCode = "5M  "
	!Define_Global_ReservedSpace = $00,$00,$00,$00,$00,$00
	!Define_Global_ExpansionFlashSize = !ExpansionMemorySize_0KB
	!Define_Global_ExpansionRAMSize = !ExpansionMemorySize_0KB
	!Define_Global_IsSpecialVersion = $00
	!Define_Global_InternalName = "SUPERMARIO COLLECTION"
	!Define_Global_ROMLayout = !ROMLayout_LoROM
	!Define_Global_ROMType = !ROMType_ROM_RAM_SRAM
	!Define_Global_CustomChip = !Chip_None
	!Define_Global_ROMSize = !ROMSize_2MB
	!Define_Global_SRAMSize = !SRAMSize_8KB
	!Define_Global_Region = !Region_Japan
	!Define_Global_LicenseeID = $01
	!Define_Global_VersionNumber = $00
	!Define_Global_ChecksumCompliment = !Define_Global_Checksum^$FFFF
	!Define_Global_Checksum = $4BCA
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
	%ROUTINE_SMAS_InitAndMainLoop($008000)
	%ROUTINE_SMAS_ResetToSMASTitleScreen(NULLROM)
	%ROUTINE_SMAS_CopyOfResetToSMASTitleScreen(NULLROM)
	%DATATABLE_SMAS_GameInitAndMainPointers(NULLROM)
	%ROUTINE_SMAS_GameMode08_LoadSelectedGame(NULLROM)
	%ROUTINE_SMAS_GameMode09_LoadGameDemo(NULLROM)
	%ROUTINE_SMAS_VBlankRoutine(NULLROM)
	%ROUTINE_SMAS_IRQRoutine(NULLROM)
	%ROUTINE_SMAS_InitializeMostRAM(NULLROM)
	%ROUTINE_SMAS_UpdateVariousRegisters(NULLROM)
	%ROUTINE_SMAS_InitializeCurrentGamemode(NULLROM)
	%ROUTINE_SMAS_DMADataBlockToRAM(NULLROM)
	%ROUTINE_SMAS_InitializeSelectedRAM(NULLROM)
if !Define_Global_SMASGames&(!SMASGames_SMB1|!SMASGames_SMBLL|!SMASGames_SMB2U|!SMASGames_SMB3) != $00
	%ROUTINE_SMAS_CheckWhichControllersArePluggedIn(NULLROM)
endif
	%ROUTINE_SMAS_PollJoypadInputs(NULLROM)
	%ROUTINE_SMAS_ResetSpriteOAMRt(NULLROM)
	%ROUTINE_SMAS_CompressOAMTileSizeBuffer(NULLROM)
	%ROUTINE_SMAS_PlaySoundEffectsAndMusic(NULLROM)
	%ROUTINE_SMAS_TurnOffIO(NULLROM)
	%DATATABLE_SMAS_GameModeSettings(NULLROM)
	%ROUTINE_SMAS_UploadDataDuringVBlank(NULLROM)
	%ROUTINE_SMAS_LoadStripeImage(NULLROM)
	%ROUTINE_SMAS_GameMode07_InitializeSelectedGame(NULLROM)
	%ROUTINE_SMAS_UploadSMASSPCEngine(NULLROM)
	%ROUTINE_RT00_SMAS_UploadMainSampleData(NULLROM)
	%ROUTINE_SMAS_UploadRandomTitleScreenChatteringSample(NULLROM)
if !Define_Global_SMASGames&(!SMASGames_SMB1|!SMASGames_SMBLL) != $00
	%ROUTINE_SMAS_UploadSMB1MusicBank(NULLROM)
endif
if !Define_Global_SMASGames&(!SMASGames_SMB2U) != $00
	%ROUTINE_SMAS_UploadSMB2UMusicBank(NULLROM)
endif
if !Define_Global_SMASGames&(!SMASGames_SMB3) != $00
	%ROUTINE_SMAS_UploadSMB3LevelMusicBank(NULLROM)
	%ROUTINE_RT00_SMB3_UploadMusicBank(NULLROM)
	%ROUTINE_RT01_SMB3_UploadMusicBank(NULLROM)
endif
	%ROUTINE_SMAS_HandleSPCUploads(NULLROM)
	%ROUTINE_SMAS_VerifySaveDataIsValid(NULLROM)
	%DATATABLE_SMAS_PremadeSaveFileDataOffsets(NULLROM)
	%DATATABLE_SMAS_PremadeSaveFileData(NULLROM)
if !Define_Global_SMASGames&(!SMASGames_SMB1) != $00
	%ROUTINE_SMB1_SaveGame(NULLROM)
endif
if !Define_Global_SMASGames&(!SMASGames_SMBLL) != $00
	%ROUTINE_SMBLL_SaveGame(NULLROM)
endif
if !Define_Global_SMASGames&(!SMASGames_SMB2U) != $00
	%ROUTINE_SMB2U_SaveGame(NULLROM)
	%ROUTINE_SMB2U_UnknownRoutine(NULLROM)
endif
if !Define_Global_SMASGames&(!SMASGames_SMB3) != $00
	%ROUTINE_SMB3_SaveGame(NULLROM)
endif
if !Define_Global_SMASGames&(!SMASGames_SMB1|!SMASGames_SMBLL|!SMASGames_SMB2U) != $00
	%ROUTINE_SMAS_StoreDataToSaveFileAndUpdateTempChecksum(NULLROM)
endif
	%ROUTINE_SMAS_DisplayRegionErrorMessage(NULLROM)
	%ROUTINE_SMAS_DisplayCopyDetectionErrorMessage(NULLROM)
if !Define_Global_SMASGames&(!SMASGames_SMB1|!SMASGames_SMBLL|!SMASGames_SMB3) != $00
	%DATATABLE_SMAS_CircleHDMAData(NULLROM)
endif
	%FREE_BYTES($0099E5, 411, $FF)
	%ROUTINE_SMAS_GameMode00_SplashAndTitleScreen(NULLROM)
	%ROUTINE_SMAS_IntroProcessXX_InitializeAndFadeIntoSplashScreen(NULLROM)
	%ROUTINE_SMAS_IntroProcess02_ShowSplashScreen(NULLROM)
	%ROUTINE_SMAS_IntroProcessXX_FadeOutToAndInitializeTitleScreen(NULLROM)
	%ROUTINE_SMAS_IntroProcess05_CharacterChatterOnTitleScreen(NULLROM)
	%ROUTINE_SMAS_IntroProcess0B_Unknown(NULLROM)
	%ROUTINE_SMAS_IntroProcessXX_TurnOnTitleScreenLights(NULLROM)
	%ROUTINE_SMAS_IntroProcess1A_CharacterChatterOnTitleScreenAgain(NULLROM)
	%ROUTINE_SMAS_IntroProcessXX_TurnOffTitleScreenLights(NULLROM)
	%ROUTINE_SMAS_IntroProcessXX_PlayTitleScreenMusicOrPause(NULLROM)
	%ROUTINE_SMAS_IntroProcess19_ResumeChattering(NULLROM)
	%ROUTINE_SMAS_IntroProcess1B_CharactersForgetToPause(NULLROM)
	%ROUTINE_SMAS_IntroProcess1C_CharactersRealizeLightsAreOn(NULLROM)
	%ROUTINE_SMAS_IntroProcess1D_FadeOutToDemo(NULLROM)
	%DATATABLE_SMAS_TriangleTransitionEffectGFXPointers(NULLROM)
	%ROUTINE_SMAS_IntroProcess1F_FadeOutToGameSelectionScreen(NULLROM)
	%ROUTINE_SMAS_SplashScreenGFXRt(NULLROM)
	%ROUTINE_SMAS_HandleSplashScreenMarioCoinShine(NULLROM)
	%ROUTINE_SMAS_TitleScreenLogoGFXRt(NULLROM)
	%ROUTINE_SMAS_GameMode06_FadeOutAfterGameSelect(NULLROM)
	%ROUTINE_SMAS_GameMode01_InitializeGameSelectScreen(NULLROM)
	%ROUTINE_RT00_SMAS_GameMode02_GameSelectScreen(NULLROM)
	%DATATABLE_SMAS_SaveFileLocations(NULLROM)
	%ROUTINE_SMAS_ClearSaveData(NULLROM)
	%ROUTINE_SMAS_LoadSaveFileData(NULLROM)
	%ROUTINE_RT01_SMAS_GameMode02_GameSelectScreen(NULLROM)
	%ROUTINE_SMAS_InitializeFileSelectMenuWindowBuffer(NULLROM)
	%ROUTINE_SMAS_DisplaySMB1FileSelectWindow(NULLROM)
	%ROUTINE_SMAS_DisplaySMBLLFileSelectWindow(NULLROM)
	%ROUTINE_SMAS_DisplaySMB2UFileSelectWindow(NULLROM)
	%ROUTINE_SMAS_DisplaySMB3FileSelectWindow(NULLROM)
	%ROUTINE_SMAS_BufferSaveFileDisplayInformation(NULLROM)
	%ROUTINE_SMAS_BufferPlayerCountOnFile(NULLROM)
	%ROUTINE_SMAS_BufferFileSelectWindow(NULLROM)
	%ROUTINE_SMAS_ClearFileSelectWindow(NULLROM)
	%ROUTINE_SMAS_UpdateControllerTypeDisplay(NULLROM)
	%ROUTINE_SMAS_UpdateFileSelectCursorPosition(NULLROM)
	%ROUTINE_SMAS_UpdateStartingAreaDisplay(NULLROM)
	%ROUTINE_SMAS_GameMode03_InitializeEraseFileMenu(NULLROM)
	%ROUTINE_SMAS_UpdateEraseFileMenuDisplay(NULLROM)
	%ROUTINE_SMAS_GameMode05_CloseEraseFileMenu(NULLROM)
	%DATATABLE_RT00_SMAS_FileSelectMenuData(NULLROM)
	%ROUTINE_SMAS_GameMode04_ShowEraseFileMenu(NULLROM)
	%DATATABLE_RT01_SMAS_FileSelectMenuData(NULLROM)
	%ROUTINE_SMAS_HandleTitleScreenCharactersAnimation(NULLROM)
	%ROUTINE_SMAS_HandleExtaTitleScreenMarioAndYoshiAnimation(NULLROM)
	%ROUTINE_SMAS_InitializeTitleScreenTilemap(NULLROM)
	%ROUTINE_SMAS_AnimateTitleScreenLuigi(NULLROM)
	%ROUTINE_SMAS_AnimateTitleScreenPeach(NULLROM)
	%ROUTINE_SMAS_AnimateTitleScreenToad(NULLROM)
	%ROUTINE_SMAS_AnimateTitleScreenBirdo(NULLROM)
	%ROUTINE_SMAS_AnimateTitleScreenGoomba(NULLROM)
	%ROUTINE_SMAS_AnimateTitleScreenBobOmb(NULLROM)
	%ROUTINE_SMAS_AnimateTitleScreenPidgit(NULLROM)
	%ROUTINE_SMAS_AnimateTitleScreenMario(NULLROM)
	%ROUTINE_SMAS_AnimateTitleScreenBowser(NULLROM)
	%ROUTINE_SMAS_WriteToTitleScreenBuffer(NULLROM)
	%DATATABLE_SMAS_TitleScreenAnimationData(NULLROM)
	%ROUTINE_SMAS_HandlTitleLogoShineAnimation(NULLROM)
	%FREE_BYTES($00BEA6, 346, $FF)
if !Define_Global_SMASGames&(!SMASGames_SMBLL) != $00
	%SMBLLBank00Macros(!BANK_00, !BANK_00)
endif
	%FREE_BYTES($00E5C4, 6652, $FF)
%BANK_END(!BANK_00)

;#############################################################################################################
;#############################################################################################################

%BANK_START(!BANK_01)
	%DATATABLE_RT00_SMAS_TitleScreenGFX($018000)
%BANK_END(!BANK_01)

;#############################################################################################################
;#############################################################################################################

%BANK_START(!BANK_02)
	%DATATABLE_SMAS_SplashScreenGFX($028000)
	%DATATABLE_SMAS_TriangleTransitionalEffectGFX($029000)
	%FREE_BYTES($029800, 2048, $00)
	%DATATABLE_SMAS_TitleScreenTextGFX($02A000)
	%DATATABLE_SMAS_TriangleTransitionalEffectTilemap($02C000)
	%DATATABLE_SMAS_TitleScreenPalettes($02C800)
	%FREE_BYTES($02CC00, 9216, $FF)
	%DATATABLE_SMAS_GameSelectScreenTilemap($02F000)
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
	%ROUTINE_RT02_SMB3_UploadMusicBank($07C000)
endif
	%FREE_BYTES(NULLROM, 5120, $FF)
	%DATATABLE_RT00_SMAS_SPCEngine($07FC00)
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
	%ROUTINE_RT01_SMAS_UploadMainSampleData($0B8000)
	%FREE_BYTES($0BFC9C, 868, $FF)
%BANK_END(!BANK_0B)

;#############################################################################################################
;#############################################################################################################

%BANK_START(!BANK_0C)
if !Define_Global_SMASGames&(!SMASGames_SMB3) != $00
	%ROUTINE_RT03_SMB3_UploadMusicBank($0C8000)
endif
	%FREE_BYTES($0CB475, 7051, $FF)
if !Define_Global_SMASGames&(!SMASGames_SMB3) != $00
	%DATATABLE_SMB3_Bank0CGraphics($0CD000)
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
	%DATATABLE_SMAS_ErrorMessageFontGFX($199800)
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
		%FREE_BYTES($1FB769, 2199, $FF)
	elseif !Define_Global_SMASGames&(!SMASGames_SMBLL) != $00
		%SMBLLBank1FMacros(!BANK_1F, !BANK_1F)
		%FREE_BYTES(NULLROM, 2199, $FF)
	endif
	if !Define_Global_SMASGames&(!SMASGames_SMB2U) != $00
		%ROUTINE_RT01_SMB2U_UploadMusicBank($1FC000)
	endif
	%FREE_BYTES($1FECD6, 4906, $FF)
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

%BANK_START(!BANK_2B)
	%DATATABLE_RT00_SMAS_BoxArtGFX($2B8000)
%BANK_END(!BANK_2B)

;#############################################################################################################
;#############################################################################################################

%BANK_START(!BANK_2C)
	%DATATABLE_RT01_SMAS_BoxArtGFX($2C8000)
	%DATATABLE_SMAS_FileSelectGFX($2CD800)
%BANK_END(!BANK_2C)

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

if !Define_Global_SMASGames&(!SMASGames_SMB3) != $00
%BANK_START(!BANK_30)
	%DATATABLE_SMB3_Bank40Graphics($308000)
%BANK_END(!BANK_30)

%BANK_START(!BANK_31)
	%DATATABLE_SMB3_Bank41Graphics($318000)
%BANK_END(!BANK_31)

%BANK_START(!BANK_32)
	%DATATABLE_SMB3_Bank42Graphics($328000)
%BANK_END(!BANK_32)

%BANK_START(!BANK_33)
	%DATATABLE_SMB3_Bank43Graphics($338000)
%BANK_END(!BANK_33)

%BANK_START(!BANK_34)
	%DATATABLE_SMB3_Bank44Graphics($348000)
%BANK_END(!BANK_34)

%BANK_START(!BANK_35)
	%DATATABLE_SMB3_Bank45Graphics($358000)
%BANK_END(!BANK_35)

%BANK_START(!BANK_36)
	%DATATABLE_SMB3_Bank46Graphics($368000)
%BANK_END(!BANK_36)

%BANK_START(!BANK_37)
	%DATATABLE_SMB3_Bank47Graphics($378000)
%BANK_END(!BANK_37)
endif

%BANK_START(!BANK_38)
if !Define_Global_SMASGames&(!SMASGames_SMB3) != $00
	%DATATABLE_RT00_SMB3_Bank38Graphics($388000)
endif
if !Define_Global_SMASGames&(!SMASGames_SMB1|!SMASGames_SMBLL|!SMASGames_SMB3) != $00
	%DATATABLE_SMAS_PauseMenuGFX($38B000)
endif
if !Define_Global_SMASGames&(!SMASGames_SMB3) != $00
	%DATATABLE_SMB3_BattleModeResultsScreenTilemap($38B800)
	%DATATABLE_RT01_SMB3_Bank38Graphics($38C000)
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
	%DATATABLE_RT01_SMAS_SPCEngine($3B8000)
%BANK_END(!BANK_3B)

;#############################################################################################################
;#############################################################################################################

%BANK_START(!BANK_3C)
	%DATATABLE_SMAS_TitleScreenTilemap($3C8000)
if !Define_Global_SMASGames&(!SMASGames_SMB3) != $00
	%DATATABLE_RT00_SMB3_Palettes($3C8800)
endif
	%DATATABLE_SMAS_BlankPalette($3C8E00)
if !Define_Global_SMASGames&(!SMASGames_SMB3) != $00
	%DATATABLE_RT01_SMB3_Palettes($3C9000)
endif
	%DATATABLE_SMAS_GameSelectScreenPalette($3CB400)
	%FREE_BYTES(NULLROM, 4096, $FF)
if !Define_Global_SMASGames&(!SMASGames_SMB3) != $00
	%DATATABLE_RT00_SMB3_CompressedTilemaps($3CC600)
	%FREE_BYTES(NULLROM, 192, $FF)
	%DATATABLE_RT01_SMB3_CompressedTilemaps($3CD000)
	%FREE_BYTES(NULLROM, 173, $FF)
	%DATATABLE_RT02_SMB3_CompressedTilemaps($3CD800)
	%FREE_BYTES(NULLROM, 43, $FF)
	%DATATABLE_RT03_SMB3_CompressedTilemaps($3CE100)
	%FREE_BYTES(NULLROM, 86, $FF)
	%DATATABLE_RT04_SMB3_CompressedTilemaps($3CE600)
	%FREE_BYTES(NULLROM, 102, $FF)
	%DATATABLE_RT05_SMB3_CompressedTilemaps($3CEA00)
	%FREE_BYTES(NULLROM, 218, $FF)
	%DATATABLE_RT06_SMB3_CompressedTilemaps($3CED00)
	%FREE_BYTES(NULLROM, 148, $FF)
	%DATATABLE_RT07_SMB3_CompressedTilemaps($3CEF00)
	%FREE_BYTES(NULLROM, 1630, $FF)
endif
%BANK_END(!BANK_3C)

;#############################################################################################################
;#############################################################################################################

%BANK_START(!BANK_3D)
if !Define_Global_SMASGames&(!SMASGames_SMB3) != $00
	%DATATABLE_RT00_SMB3_Bank3DGraphics($3D8000)
endif
	%DATATABLE_SMAS_BlankGameSelectScreenGFXFile($3DA800)
if !Define_Global_SMASGames&(!SMASGames_SMB3) != $00
	%DATATABLE_RT01_SMB3_Bank3DGraphics($3DB000)
endif
	%FREE_BYTES($3DC000, 3072, $FF)
	%DATATABLE_RT01_SMAS_TitleScreenGFX($3DCC00)
if !Define_Global_SMASGames&(!SMASGames_SMB3) != $00
	%DATATABLE_RT02_SMB3_Bank3DGraphics($3DE000)
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
endif

;#############################################################################################################
;#############################################################################################################
endmacro
