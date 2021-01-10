
macro SMB2U_GameSpecificAssemblySettings()
	!ROM_SMB2U_U = $0001							;\ These defines assign each ROM version with a different bit so version difference checks will work. Do not touch them!
	!ROM_SMB2U_E = $0002							;|
	!ROM_SMB2U_J = $0004							;|
	!ROM_SMASW_U = $0100							;|
	!ROM_SMASW_E = $0200							;|
	!ROM_SMAS_U = $0400							;|
	!ROM_SMAS_E = $0800							;|
	!ROM_SMAS_J1 = $1000							;|
	!ROM_SMAS_J2 = $2000							;/

!Define_SMAS_Global_DisableCopyDetection = !FALSE

	%SetROMToAssembleForHack(SMB2U_J, !ROMID)
endmacro

macro SMB2U_LoadGameSpecificMainSNESFiles()
	incsrc ../Misc_Defines_SMB2U.asm
	incsrc ../RAM_Map_SMB2U.asm
	incsrc ../Routine_Macros_SMB2U.asm
	incsrc ../SNES_Macros_SMB2U.asm
endmacro

macro SMB2U_LoadGameSpecificMainSPC700Files()
	incsrc ../../SMAS/SPC700/ARAM_Map_SMAS.asm
	incsrc ../../SMAS/Misc_Defines_SMAS.asm
	incsrc ../../SMAS/SPC700/SPC700_Macros_SMAS.asm
endmacro

macro SMB2U_LoadGameSpecificMainExtraHardwareFiles()
endmacro

macro SMB2U_LoadGameSpecificMSU1Files()
endmacro

macro SMB2U_GlobalAssemblySettings()
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
	!Define_Global_LicenseeName = "Yoshifanatic"
	!Define_Global_DeveloperName = "Yoshifanatic"
	!Define_Global_ReleaseDate = "January 3, 2021"
	!Define_Global_BaseROMMD5Hash = "a56b8f6e397b8fceeb3a6beec93523e7"

	!Define_Global_MakerCode = "01"
	!Define_Global_GameCode = "Axxx"
	!Define_Global_ReservedSpace = $00,$00,$00,$00,$00,$00
	!Define_Global_ExpansionFlashSize = !ExpansionMemorySize_0KB
	!Define_Global_ExpansionRAMSize = !ExpansionMemorySize_0KB
	!Define_Global_IsSpecialVersion = $00
	!Define_Global_InternalName = "Super Mario USA      "
	!Define_Global_ROMLayout = !ROMLayout_LoROM
	!Define_Global_ROMType = !ROMType_ROM_RAM_SRAM
	!Define_Global_CustomChip = !Chip_None
	!Define_Global_ROMSize = !ROMSize_512KB
	!Define_Global_SRAMSize = !SRAMSize_8KB
	!Define_Global_Region = !Region_Japan
	!Define_Global_LicenseeID = $01
	!Define_Global_VersionNumber = $00
	!Define_Global_ChecksumCompliment = !Define_Global_Checksum^$FFFF
	!Define_Global_Checksum = $F23C
	!UnusedNativeModeVector1 = $FFFF
	!UnusedNativeModeVector2 = $FFFF
	!NativeModeCOPVector = SMB2U_VBlankRoutine_EndofVBlank
	!NativeModeBRKVector = $FFFF						; Crash: Dangerous! This will cause unpredictable things to happen if a BRK executes.
	!NativeModeAbortVector = SMB2U_VBlankRoutine_EndofVBlank
	!NativeModeNMIVector = SMB2U_VBlankRoutine_Main
	!NativeModeResetVector = SMB2U_InitAndMainLoop_Main
	!NativeModeIRQVector = SMB2U_IRQRoutine_Main
	!UnusedEmulationModeVector1 = $FFFF
	!UnusedEmulationModeVector2 = $FFFF
	!EmulationModeCOPVector = SMB2U_VBlankRoutine_EndofVBlank
	!EmulationModeBRKVector = SMB2U_VBlankRoutine_EndofVBlank
	!EmulationModeAbortVector = SMB2U_VBlankRoutine_EndofVBlank
	!EmulationModeNMIVector = SMB2U_VBlankRoutine_EndofVBlank
	!EmulationModeResetVector = SMB2U_InitAndMainLoop_Main
	!EmulationModeIRQVector = SMB2U_IRQRoutine_Main
	%LoadExtraRAMFile("../SMAS/SRAM_Map_SMAS.asm")
endmacro

macro SMB2U_LoadROMMap()
	%SMB2UBank11Macros(!BANK_00, !BANK_00)
	%SMB2UBank12Macros(!BANK_01, !BANK_01)
	%SMB2UBank13Macros(!BANK_02, !BANK_02)
	%SMB2UBank14Macros(!BANK_03, !BANK_03)
	%SMB2UBank15Macros(!BANK_04, !BANK_04)
	%SMB2UBank16Macros(!BANK_05, !BANK_05)
	%SMB2UBank17Macros(!BANK_06, !BANK_06)
	%SMB2UBank18Macros(!BANK_07, !BANK_07)
	%SMB2UBank1BMacros(!BANK_08, !BANK_08)
	%SMB2UBank1CMacros(!BANK_09, !BANK_09)
	%SMB2UBank1DMacros(!BANK_0A, !BANK_0A)

%BANK_START(!BANK_0B)
	%DATATABLE_SMB2U_Bank1AGraphics($0B8000)
	%DATATABLE_CUSTOM_SMB2U_SplashScreenGFX(NULLROM)
	%FREE_BYTES(NULLROM, 2048, $FF)
%BANK_END(!BANK_0B)

%BANK_START(!BANK_0C)
	%SMB2UBank1EMacros(!BANK_0C, !BANK_0C)
	%ROUTINE_CUSTOM_RT01_SMB2U_UploadSPCEngine(NULLROM)
	%ROUTINE_RT00_SMB2U_UploadMusicBank(NULLROM)
	%ROUTINE_CUSTOM_RT00_SMB2U_UploadSPCEngine(NULLROM)
	%ROUTINE_CUSTOM_RT00_SMB2U_UploadMainSampleData(NULLROM)
	%ROUTINE_CUSTOM_SMB2U_HandleSPCUploads(NULLROM)
	%ROUTINE_SMB2U_SaveGame(NULLROM)
	%ROUTINE_SMB2U_StoreDataToSaveFileAndUpdateTempChecksum(NULLROM)
	%ROUTINE_CUSTOM_SMB2U_ResetGame(NULLROM)
	%ROUTINE_CUSTOM_SMB2U_DisplayRegionErrorMessage(NULLROM)
	%ROUTINE_CUSTOM_SMB2U_DisplayCopyDetectionErrorMessage(NULLROM)
	%ROUTINE_CUSTOM_SMB2U_InitializeSelectedRAM(NULLROM)
	%ROUTINE_CUSTOM_SMB2U_InitializeRAMOnStartup(NULLROM)
	%ROUTINE_CUSTOM_SMB2U_CheckWhichControllersArePluggedIn(NULLROM)
	%ROUTINE_CUSTOM_SMB2U_LoadSplashScreen(NULLROM)
	%ROUTINE_CUSTOM_SMB2U_SplashScreenGFXRt(NULLROM)
	%ROUTINE_CUSTOM_SMB2U_HandleSplashScreenMarioCoinShine(NULLROM)
	%ROUTINE_CUSTOM_SMB2U_LoadFileSelectMenu(NULLROM)
	%ROUTINE_CUSTOM_SMB2U_ChangeSelectedWorld(NULLROM)
	%ROUTINE_CUSTOM_SMB2U_LoadSaveFileData(NULLROM)
	%DATATABLE_CUSTOM_SMB2U_SaveFileLocations(NULLROM)
	%ROUTINE_CUSTOM_SMB2U_VerifySaveDataIsValid(NULLROM)
	%ROUTINE_CUSTOM_SMB2U_ClearSaveData(NULLROM)
	%ROUTINE_CUSTOM_SMB2U_MoveTitleScreenMenuCursor(NULLROM)
	%ROUTINE_CUSTOM_SMB2U_ProcessFileSelect(NULLROM)
	%ROUTINE_CUSTOM_SMB2U_BufferLevelPreviewLevelTilemapAsStripeImage(NULLROM)
	%FREE_BYTES(NULLROM, 3964, $FF)
%BANK_END(!BANK_0C)

%BANK_START(!BANK_0D)
	%ROUTINE_RT01_SMB2U_UploadMusicBank(NULLROM)
	%SMB2UBank2FMacros(!BANK_0E, !BANK_0E)
	%FREE_BYTES(NULLROM, 810, $FF)
%BANK_END(!BANK_0D)

%BANK_START(!BANK_0E)
	%ROUTINE_CUSTOM_RT01_SMB2U_UploadMainSampleData(NULLROM)
	%FREE_BYTES(NULLROM, 868, $FF)
%BANK_END(!BANK_0E)

%BANK_START(!BANK_0F)
	%SMB2UBank19_00Macros(!BANK_0B, !BANK_0B)
	%ROUTINE_CUSTOM_SMB2U_ErrorMessageFontGFX(NULLROM)
	%SMB2UBank19_01Macros(!BANK_0B, !BANK_0B)
%BANK_END(!BANK_0F)
endmacro
