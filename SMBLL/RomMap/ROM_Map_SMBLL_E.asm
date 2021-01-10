
macro SMBLL_GameSpecificAssemblySettings()
	!ROM_SMBLL_U = $0001							;\ These defines assign each ROM version with a different bit so version difference checks will work. Do not touch them!
	!ROM_SMBLL_E = $0002							;|
	!ROM_SMBLL_J = $0004							;|
	!ROM_SMASW_U = $0100							;|
	!ROM_SMASW_E = $0200							;|
	!ROM_SMAS_U = $0400							;|
	!ROM_SMAS_E = $0800							;|
	!ROM_SMAS_J1 = $1000							;|
	!ROM_SMAS_J2 = $2000							;/

!Define_SMAS_Global_DisableCopyDetection = !FALSE

	%SetROMToAssembleForHack(SMBLL_E, !ROMID)
endmacro

macro SMBLL_LoadGameSpecificMainSNESFiles()
	incsrc ../Misc_Defines_SMBLL.asm
	incsrc ../RAM_Map_SMBLL.asm
	incsrc ../Routine_Macros_SMBLL.asm
	incsrc ../SNES_Macros_SMBLL.asm
endmacro

macro SMBLL_LoadGameSpecificMainSPC700Files()
	incsrc ../../SMAS/SPC700/ARAM_Map_SMAS.asm
	incsrc ../../SMAS/Misc_Defines_SMAS.asm
	incsrc ../../SMAS/SPC700/SPC700_Macros_SMAS.asm
endmacro

macro SMBLL_LoadGameSpecificMainExtraHardwareFiles()
endmacro

macro SMBLL_LoadGameSpecificMSU1Files()
endmacro

macro SMBLL_GlobalAssemblySettings()
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
	!Define_Global_BaseROMMD5Hash = "e041861e7d9bf0be3d4b0e3448a8940f"

	!Define_Global_MakerCode = "01"
	!Define_Global_GameCode = "Axxx"
	!Define_Global_ReservedSpace = $00,$00,$00,$00,$00,$00
	!Define_Global_ExpansionFlashSize = !ExpansionMemorySize_0KB
	!Define_Global_ExpansionRAMSize = !ExpansionMemorySize_0KB
	!Define_Global_IsSpecialVersion = $00
	!Define_Global_InternalName = "Super Mario Bros. LL "
	!Define_Global_ROMLayout = !ROMLayout_LoROM
	!Define_Global_ROMType = !ROMType_ROM_RAM_SRAM
	!Define_Global_CustomChip = !Chip_None
	!Define_Global_ROMSize = !ROMSize_512KB
	!Define_Global_SRAMSize = !SRAMSize_8KB
	!Define_Global_Region = !Region_Europe
	!Define_Global_LicenseeID = $01
	!Define_Global_VersionNumber = $00
	!Define_Global_ChecksumCompliment = !Define_Global_Checksum^$FFFF
	!Define_Global_Checksum = $C9F9
	!UnusedNativeModeVector1 = $FFFF
	!UnusedNativeModeVector2 = $FFFF
	!NativeModeCOPVector = SMBLL_VBlankRoutine_EndofVBlank
	!NativeModeBRKVector = $FFFF						; Crash: Dangerous! This will cause unpredictable things to happen if a BRK executes.
	!NativeModeAbortVector = SMBLL_VBlankRoutine_EndofVBlank
	!NativeModeNMIVector = SMBLL_VBlankRoutine_Main
	!NativeModeResetVector = SMBLL_InitAndMainLoop_Main
	!NativeModeIRQVector = SMBLL_IRQRoutine_Main
	!UnusedEmulationModeVector1 = $FFFF
	!UnusedEmulationModeVector2 = $FFFF
	!EmulationModeCOPVector = SMBLL_VBlankRoutine_EndofVBlank
	!EmulationModeBRKVector = SMBLL_VBlankRoutine_EndofVBlank
	!EmulationModeAbortVector = SMBLL_VBlankRoutine_EndofVBlank
	!EmulationModeNMIVector = SMBLL_VBlankRoutine_EndofVBlank
	!EmulationModeResetVector = SMBLL_InitAndMainLoop_Main
	!EmulationModeIRQVector = SMBLL_IRQRoutine_Main
	%LoadExtraRAMFile("../SMAS/SRAM_Map_SMAS.asm")
endmacro

macro SMBLL_LoadROMMap()
	%SMBLLBank0DMacros(!BANK_00, !BANK_00)
	%SMBLLBank0EMacros(!BANK_01, !BANK_01)
	%SMBLLBank0FMacros(!BANK_02, !BANK_02)
	%SMBLLBank10Macros(!BANK_03, !BANK_03)

%BANK_START(!BANK_04)
	%SMBLLBank07Macros(!BANK_04, !BANK_04)
	%SMBLLBank1EMacros(!BANK_04, !BANK_04)
%BANK_END(!BANK_04)

	%SMBLLBank08Macros(!BANK_05, !BANK_05)
	%SMBLLBank09Macros(!BANK_06, !BANK_06)
	%SMBLLBank0AMacros(!BANK_07, !BANK_07)

%BANK_START(!BANK_08)
	%ROUTINE_CUSTOM_SMBLL_UploadMusicBank(NULLROM)
	%ROUTINE_CUSTOM_RT00_SMBLL_UploadSPCEngine(NULLROM)
	%ROUTINE_CUSTOM_RT00_SMBLL_UploadMainSampleData(NULLROM)
	%ROUTINE_CUSTOM_SMBLL_HandleSPCUploads(NULLROM)
	%ROUTINE_SMBLL_SaveGame(NULLROM)
	%ROUTINE_CUSTOM_SMBLL_StoreDataToSaveFileAndUpdateTempChecksum(NULLROM)
	%ROUTINE_CUSTOM_SMBLL_ResetGame(NULLROM)
	%ROUTINE_CUSTOM_SMBLL_DisplayRegionErrorMessage(NULLROM)
	%ROUTINE_CUSTOM_SMBLL_DisplayCopyDetectionErrorMessage(NULLROM)
	%ROUTINE_CUSTOM_SMBLL_InitializeSelectedRAM(NULLROM)
	%ROUTINE_CUSTOM_SMBLL_InitializeRAMOnStartup(NULLROM)
	%ROUTINE_CUSTOM_SMBLL_CheckWhichControllersArePluggedIn(NULLROM)
	%DATATABLE_CUSTOM_SMBLL_CircleHDMAData(NULLROM)
	%ROUTINE_CUSTOM_SMBLL_LoadSplashScreen(NULLROM)
	%ROUTINE_CUSTOM_SMBLL_SplashScreenGFXRt(NULLROM)
	%ROUTINE_CUSTOM_SMBLL_HandleSplashScreenMarioCoinShine(NULLROM)
	%ROUTINE_CUSTOM_SMBLL_LoadFileSelectMenu(NULLROM)
	%ROUTINE_CUSTOM_SMBLL_LoadPlayerSelectMenu(NULLROM)
	%ROUTINE_CUSTOM_SMBLL_ChangeSelectedWorld(NULLROM)
	%ROUTINE_CUSTOM_SMBLL_LoadSaveFileData(NULLROM)
	%DATATABLE_CUSTOM_SMBLL_SaveFileLocations(NULLROM)
	%ROUTINE_CUSTOM_SMBLL_VerifySaveDataIsValid(NULLROM)
	%ROUTINE_CUSTOM_SMBLL_ClearSaveData(NULLROM)
	%ROUTINE_CUSTOM_SMBLL_MoveTitleScreenMenuCursor(NULLROM)
	%DATATABLE_CUSTOM_SMBLL_SplashScreenGFX(NULLROM)
	%SMBLLBank1FMacros(!BANK_08, !BANK_08)
	%FREE_BYTES(NULLROM, 10261, $FF)
%BANK_END(!BANK_08)

%BANK_START(!BANK_09)
	%SMBLLBank2FMacros(!BANK_09, !BANK_09)
	%SMBLLBank0CMacros(!BANK_09, !BANK_09)
	%SMBLLBank1AMacros(!BANK_09, !BANK_09)
	%DATATABLE_CUSTOM_SMBLL_PauseMenuGFX(NULLROM)
	%ROUTINE_CUSTOM_SMBLL_ErrorMessageFontGFX(NULLROM)
	%ROUTINE_CUSTOM_RT01_SMBLL_UploadSPCEngine(NULLROM)
	%FREE_BYTES(NULLROM, 3629, $FF)
%BANK_END(!BANK_09)

%BANK_START(!BANK_0A)
	%ROUTINE_CUSTOM_RT01_SMBLL_UploadMainSampleData(NULLROM)
	%FREE_BYTES(NULLROM, 868, $FF)
%BANK_END(!BANK_0A)

%BANK_START(!BANK_0B)
	%SMBLLBank00Macros(!BANK_0B, !BANK_0B)
	%SMBLLBank04Macros(!BANK_0B, !BANK_0B)
	%FREE_BYTES(NULLROM, 21654, $FF)
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
