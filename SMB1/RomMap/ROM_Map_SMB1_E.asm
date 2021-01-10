
macro SMB1_GameSpecificAssemblySettings()
	!ROM_SMB1_U = $0001							;\ These defines assign each ROM version with a different bit so version difference checks will work. Do not touch them!
	!ROM_SMB1_E = $0002							;|
	!ROM_SMB1_J = $0004							;|
	!ROM_SMASW_U = $0100							;|
	!ROM_SMASW_E = $0200							;|
	!ROM_SMAS_U = $0400							;|
	!ROM_SMAS_E = $0800							;|
	!ROM_SMAS_J1 = $1000							;|
	!ROM_SMAS_J2 = $2000							;/

!Define_SMAS_Global_DisableCopyDetection = !FALSE

	%SetROMToAssembleForHack(SMB1_E, !ROMID)
endmacro

macro SMB1_LoadGameSpecificMainSNESFiles()
	incsrc ../Misc_Defines_SMB1.asm
	incsrc ../RAM_Map_SMB1.asm
	incsrc ../Routine_Macros_SMB1.asm
	incsrc ../SNES_Macros_SMB1.asm
endmacro

macro SMB1_LoadGameSpecificMainSPC700Files()
	incsrc ../../SMAS/SPC700/ARAM_Map_SMAS.asm
	incsrc ../../SMAS/Misc_Defines_SMAS.asm
	incsrc ../../SMAS/SPC700/SPC700_Macros_SMAS.asm
endmacro

macro SMB1_LoadGameSpecificMainExtraHardwareFiles()
endmacro

macro SMB1_LoadGameSpecificMSU1Files()
endmacro

macro SMB1_GlobalAssemblySettings()
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
	!Define_Global_ReleaseDate = "January 3, 2020"
	!Define_Global_BaseROMMD5Hash = "7dd499779a2488031f6509ff8bd650fb"

	!Define_Global_MakerCode = "01"
	!Define_Global_GameCode = "Axxx"
	!Define_Global_ReservedSpace = $00,$00,$00,$00,$00,$00
	!Define_Global_ExpansionFlashSize = !ExpansionMemorySize_0KB
	!Define_Global_ExpansionRAMSize = !ExpansionMemorySize_0KB
	!Define_Global_IsSpecialVersion = $00
	!Define_Global_InternalName = "Super Mario Bros. 1  "
	!Define_Global_ROMLayout = !ROMLayout_LoROM
	!Define_Global_ROMType = !ROMType_ROM_RAM_SRAM
	!Define_Global_CustomChip = !Chip_None
	!Define_Global_ROMSize = !ROMSize_512KB
	!Define_Global_SRAMSize = !SRAMSize_8KB
	!Define_Global_Region = !Region_Europe
	!Define_Global_LicenseeID = $01
	!Define_Global_VersionNumber = $00
	!Define_Global_ChecksumCompliment = !Define_Global_Checksum^$FFFF
	!Define_Global_Checksum = $FABE
	!UnusedNativeModeVector1 = $FFFF
	!UnusedNativeModeVector2 = $FFFF
	!NativeModeCOPVector = SMB1_VBlankRoutine_EndofVBlank
	!NativeModeBRKVector = $FFFF						; Crash: Dangerous! This will cause unpredictable things to happen if a BRK executes.
	!NativeModeAbortVector = SMB1_VBlankRoutine_EndofVBlank
	!NativeModeNMIVector = SMB1_VBlankRoutine_Main
	!NativeModeResetVector = SMB1_InitAndMainLoop_Main
	!NativeModeIRQVector = SMB1_IRQRoutine_Main
	!UnusedEmulationModeVector1 = $FFFF
	!UnusedEmulationModeVector2 = $FFFF
	!EmulationModeCOPVector = SMB1_VBlankRoutine_EndofVBlank
	!EmulationModeBRKVector = SMB1_VBlankRoutine_EndofVBlank
	!EmulationModeAbortVector = SMB1_VBlankRoutine_EndofVBlank
	!EmulationModeNMIVector = SMB1_VBlankRoutine_EndofVBlank
	!EmulationModeResetVector = SMB1_InitAndMainLoop_Main
	!EmulationModeIRQVector = SMB1_IRQRoutine_Main
	%LoadExtraRAMFile("../SMAS/SRAM_Map_SMAS.asm")
endmacro

macro SMB1_LoadROMMap()
	%SMB1Bank03Macros(!BANK_00, !BANK_00)
	%SMB1Bank04Macros(!BANK_01, !BANK_01)
	%SMB1Bank05Macros(!BANK_02, !BANK_02)
	%SMB1Bank06Macros(!BANK_03, !BANK_03)

%BANK_START(!BANK_04)
	%SMB1Bank07Macros(!BANK_04, !BANK_04)
	%SMB1Bank1EMacros(!BANK_04, !BANK_04)
%BANK_END(!BANK_04)

	%SMB1Bank08Macros(!BANK_05, !BANK_05)
	%SMB1Bank09Macros(!BANK_06, !BANK_06)
	%SMB1Bank0AMacros(!BANK_07, !BANK_07)

%BANK_START(!BANK_08)
	%ROUTINE_CUSTOM_SMB1_UploadMusicBank(NULLROM)
	%ROUTINE_CUSTOM_RT00_SMB1_UploadSPCEngine(NULLROM)
	%ROUTINE_CUSTOM_RT00_SMB1_UploadMainSampleData(NULLROM)
	%ROUTINE_CUSTOM_SMB1_HandleSPCUploads(NULLROM)
	%ROUTINE_SMB1_SaveGame(NULLROM)
	%ROUTINE_CUSTOM_SMB1_StoreDataToSaveFileAndUpdateTempChecksum(NULLROM)
	%ROUTINE_CUSTOM_SMB1_ResetGame(NULLROM)
	%ROUTINE_CUSTOM_SMB1_DisplayRegionErrorMessage(NULLROM)
	%ROUTINE_CUSTOM_SMB1_DisplayCopyDetectionErrorMessage(NULLROM)
	%ROUTINE_CUSTOM_SMB1_InitializeSelectedRAM(NULLROM)
	%ROUTINE_CUSTOM_SMB1_InitializeRAMOnStartup(NULLROM)
	%ROUTINE_CUSTOM_SMB1_CheckWhichControllersArePluggedIn(NULLROM)
	%DATATABLE_CUSTOM_SMB1_CircleHDMAData(NULLROM)
	%ROUTINE_CUSTOM_SMB1_LoadSplashScreen(NULLROM)
	%ROUTINE_CUSTOM_SMB1_SplashScreenGFXRt(NULLROM)
	%ROUTINE_CUSTOM_SMB1_HandleSplashScreenMarioCoinShine(NULLROM)
	%ROUTINE_CUSTOM_SMB1_LoadFileSelectMenu(NULLROM)
	%ROUTINE_CUSTOM_SMB1_LoadPlayerSelectMenu(NULLROM)
	%ROUTINE_CUSTOM_SMB1_ChangeSelectedWorld(NULLROM)
	%ROUTINE_CUSTOM_SMB1_LoadSaveFileData(NULLROM)
	%DATATABLE_CUSTOM_SMB1_SaveFileLocations(NULLROM)
	%ROUTINE_CUSTOM_SMB1_VerifySaveDataIsValid(NULLROM)
	%ROUTINE_CUSTOM_SMB1_ClearSaveData(NULLROM)
	%ROUTINE_CUSTOM_SMB1_MoveTitleScreenMenuCursor(NULLROM)
	%DATATABLE_CUSTOM_SMB1_SplashScreenGFX(NULLROM)
	%SMB1Bank1FMacros(!BANK_08, !BANK_08)
	%FREE_BYTES(NULLROM, 10002, $FF)
%BANK_END(!BANK_08)

%BANK_START(!BANK_09)
	%SMB1Bank2FMacros(!BANK_09, !BANK_09)
	%SMB1Bank0CMacros(!BANK_09, !BANK_09)
	%SMB1Bank1AMacros(!BANK_09, !BANK_09)
	%DATATABLE_CUSTOM_SMB1_PauseMenuGFX(NULLROM)
	%ROUTINE_CUSTOM_SMB1_ErrorMessageFontGFX(NULLROM)
	%ROUTINE_CUSTOM_RT01_SMB1_UploadSPCEngine(NULLROM)
	%FREE_BYTES(NULLROM, 3629, $FF)
%BANK_END(!BANK_09)

%BANK_START(!BANK_0A)
	%ROUTINE_CUSTOM_RT01_SMB1_UploadMainSampleData(NULLROM)
	%FREE_BYTES(NULLROM, 868, $FF)
%BANK_END(!BANK_0A)

%BANK_START(!BANK_0B)
	%FREE_BYTES(NULLROM, 32768, $FF)
%BANK_END(!BANK_0B)

%BANK_START(!BANK_0C)
	%FREE_BYTES(NULLROM, 32768, $FF)
%BANK_END(!BANK_0C)

%BANK_START(!BANK_0D)
	%FREE_BYTES(NULLROM, 32768, $FF)
%BANK_END(!BANK_0D)

%BANK_START(!BANK_0E)
	%FREE_BYTES(NULLROM, 32768, $FF)
%BANK_END(!BANK_0E)

%BANK_START(!BANK_0F)
	%FREE_BYTES(NULLROM, 32768, $FF)
%BANK_END(!BANK_0F)
endmacro
