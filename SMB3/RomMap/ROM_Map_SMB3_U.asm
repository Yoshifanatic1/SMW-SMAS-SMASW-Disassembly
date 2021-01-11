
macro SMB3_GameSpecificAssemblySettings()
	!ROM_SMB3_U = $0001							;\ These defines assign each ROM version with a different bit so version difference checks will work. Do not touch them!
	!ROM_SMB3_E = $0002							;|
	!ROM_SMB3_J = $0004							;|
	!ROM_SMASW_U = $0100							;|
	!ROM_SMASW_E = $0200							;|
	!ROM_SMAS_U = $0400							;|
	!ROM_SMAS_E = $0800							;|
	!ROM_SMAS_J1 = $1000							;|
	!ROM_SMAS_J2 = $2000							;/

!Define_SMAS_Global_DisableCopyDetection = !FALSE

	%SetROMToAssembleForHack(SMB3_U, !ROMID)
endmacro

macro SMB3_LoadGameSpecificMainSNESFiles()
	incsrc ../Misc_Defines_SMB3.asm
	incsrc ../RAM_Map_SMB3.asm
	incsrc ../Routine_Macros_SMB3.asm
	incsrc ../SNES_Macros_SMB3.asm
endmacro

macro SMB3_LoadGameSpecificMainSPC700Files()
	incsrc ../../SMAS/SPC700/ARAM_Map_SMAS.asm
	incsrc ../../SMAS/Misc_Defines_SMAS.asm
	incsrc ../../SMAS/SPC700/SPC700_Macros_SMAS.asm
endmacro

macro SMB3_LoadGameSpecificMainExtraHardwareFiles()
endmacro

macro SMB3_LoadGameSpecificMSU1Files()
endmacro

macro SMB3_GlobalAssemblySettings()
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
	!Define_Global_ReleaseDate = "July 7, 2019"
	!Define_Global_BaseROMMD5Hash = "e9f34e23641fe89582591105788ebd47"

	!Define_Global_MakerCode = "01"
	!Define_Global_GameCode = "Axxx"
	!Define_Global_ReservedSpace = $00,$00,$00,$00,$00,$00
	!Define_Global_ExpansionFlashSize = !ExpansionMemorySize_0KB
	!Define_Global_ExpansionRAMSize = !ExpansionMemorySize_0KB
	!Define_Global_IsSpecialVersion = $00
	!Define_Global_InternalName = "Super Mario Bros. 3  "
	!Define_Global_ROMLayout = !ROMLayout_LoROM
	!Define_Global_ROMType = !ROMType_ROM_RAM_SRAM
	!Define_Global_CustomChip = !Chip_None
	!Define_Global_ROMSize = !ROMSize_1MB
	!Define_Global_SRAMSize = !SRAMSize_8KB
	!Define_Global_Region = !Region_NorthAmerica
	!Define_Global_LicenseeID = $01
	!Define_Global_VersionNumber = $00
	!Define_Global_ChecksumCompliment = !Define_Global_Checksum^$FFFF
	!Define_Global_Checksum = $0E79
	!UnusedNativeModeVector1 = $FFFF
	!UnusedNativeModeVector2 = $FFFF
	!NativeModeCOPVector = SMB3_VBlankRoutine_EndofVBlank
	!NativeModeBRKVector = $FFFF						; Crash: Dangerous! This will cause unpredictable things to happen if a BRK executes.
	!NativeModeAbortVector = SMB3_VBlankRoutine_EndofVBlank
	!NativeModeNMIVector = SMB3_VBlankRoutine_Main
	!NativeModeResetVector = SMB3_InitAndMainLoop_Main
	!NativeModeIRQVector = SMB3_IRQRoutine_Main
	!UnusedEmulationModeVector1 = $FFFF
	!UnusedEmulationModeVector2 = $FFFF
	!EmulationModeCOPVector = SMB3_VBlankRoutine_EndofVBlank
	!EmulationModeBRKVector = SMB3_VBlankRoutine_EndofVBlank
	!EmulationModeAbortVector = SMB3_VBlankRoutine_EndofVBlank
	!EmulationModeNMIVector = SMB3_VBlankRoutine_EndofVBlank
	!EmulationModeResetVector = SMB3_InitAndMainLoop_Main
	!EmulationModeIRQVector = SMB3_IRQRoutine_Main
	%LoadExtraRAMFile("../SMAS/SRAM_Map_SMAS.asm")
endmacro

macro SMB3_LoadROMMap()
	%SMB3Bank20Macros(!BANK_00, !BANK_00)
	%SMB3Bank21Macros(!BANK_01, !BANK_01)
	%SMB3Bank22Macros(!BANK_02, !BANK_02)
	%SMB3Bank23Macros(!BANK_03, !BANK_03)
	%SMB3Bank24Macros(!BANK_04, !BANK_04)
	%SMB3Bank25Macros(!BANK_05, !BANK_05)
	%SMB3Bank26Macros(!BANK_06, !BANK_06)
	%SMB3Bank27Macros(!BANK_07, !BANK_07)
	%SMB3Bank28Macros(!BANK_08, !BANK_08)
	%SMB3Bank29Macros(!BANK_09, !BANK_09)
	%SMB3Bank2AMacros(!BANK_0A, !BANK_0A)

%BANK_START(!BANK_0B)
	%ROUTINE_RT02_SMB3_UploadMusicBank(NULLROM)
	%ROUTINE_RT00_SMB3_UploadMusicBank(NULLROM)
	%ROUTINE_RT01_SMB3_UploadMusicBank(NULLROM)
	%ROUTINE_CUSTOM_RT00_SMB3_UploadSPCEngine(NULLROM)
	%ROUTINE_RT03_SMB3_UploadMusicBank(NULLROM)
	%ROUTINE_CUSTOM_RT00_SMB3_UploadMainSampleData(NULLROM)
	%ROUTINE_CUSTOM_SMB3_HandleSPCUploads(NULLROM)
	%ROUTINE_SMB3_SaveGame(NULLROM)
	%ROUTINE_CUSTOM_SMB3_DMADataBlockToRAM(NULLROM)
	%ROUTINE_CUSTOM_SMB3_ResetGame(NULLROM)
	%ROUTINE_CUSTOM_SMB3_DisplayRegionErrorMessage(NULLROM)
	%ROUTINE_CUSTOM_SMB3_DisplayCopyDetectionErrorMessage(NULLROM)
	%ROUTINE_CUSTOM_SMB3_InitializeSelectedRAM(NULLROM)
	%ROUTINE_CUSTOM_SMB3_InitializeRAMOnStartup(NULLROM)
	%ROUTINE_CUSTOM_SMB3_CheckWhichControllersArePluggedIn(NULLROM)
	%DATATABLE_CUSTOM_SMB3_CircleHDMAData(NULLROM)
	%ROUTINE_CUSTOM_SMB3_LoadSplashScreen(NULLROM)
	%ROUTINE_CUSTOM_SMB3_SplashScreenGFXRt(NULLROM)
	%ROUTINE_CUSTOM_SMB3_HandleSplashScreenMarioCoinShine(NULLROM)
	%ROUTINE_CUSTOM_SMB3_LoadFileSelectMenu(NULLROM)
	%ROUTINE_CUSTOM_SMB3_LoadPlayerSelectMenu(NULLROM)
	%ROUTINE_CUSTOM_SMB3_ChangeSelectedWorld(NULLROM)
	%ROUTINE_CUSTOM_SMB3_LoadSaveFileData(NULLROM)
	%DATATABLE_CUSTOM_SMB3_SaveFileLocations(NULLROM)
	%ROUTINE_CUSTOM_SMB3_VerifySaveDataIsValid(NULLROM)
	%ROUTINE_CUSTOM_SMB3_ClearSaveData(NULLROM)
	%ROUTINE_CUSTOM_SMB3_MoveTitleScreenMenuCursor(NULLROM)
	%DATATABLE_CUSTOM_SMB3_SplashScreenGFX(NULLROM)
	%FREE_BYTES(NULLROM, 689, $FF)
%BANK_END(!BANK_0B)

%BANK_START(!BANK_0C)
	%DATATABLE_SMB3_Bank2DGraphics(NULLROM)
%BANK_END(!BANK_0C)

%BANK_START(!BANK_0D)
	%DATATABLE_SMB3_Bank2EGraphics(NULLROM)
%BANK_END(!BANK_0D)

%BANK_START(!BANK_0E)
	%DATATABLE_SMB3_Bank39Graphics(NULLROM)
%BANK_END(!BANK_0E)

%BANK_START(!BANK_0F)
	%DATATABLE_SMB3_Bank3AGraphics(NULLROM)
%BANK_END(!BANK_0F)

%BANK_START(!BANK_10)
	%DATATABLE_SMB3_Bank3EGraphics(NULLROM)
%BANK_END(!BANK_10)

%BANK_START(!BANK_11)
	%DATATABLE_SMB3_Bank3FGraphics(NULLROM)
%BANK_END(!BANK_11)

%BANK_START(!BANK_12)
	%DATATABLE_SMB3_Bank40Graphics(NULLROM)
%BANK_END(!BANK_12)

%BANK_START(!BANK_13)
	%DATATABLE_SMB3_Bank41Graphics(NULLROM)
%BANK_END(!BANK_13)

%BANK_START(!BANK_14)
	%DATATABLE_SMB3_Bank42Graphics(NULLROM)
%BANK_END(!BANK_14)

%BANK_START(!BANK_15)
	%DATATABLE_SMB3_Bank43Graphics(NULLROM)
%BANK_END(!BANK_15)

%BANK_START(!BANK_16)
	%DATATABLE_SMB3_Bank44Graphics(NULLROM)
%BANK_END(!BANK_16)

%BANK_START(!BANK_17)
	%DATATABLE_SMB3_Bank45Graphics(NULLROM)
%BANK_END(!BANK_17)

%BANK_START(!BANK_18)
	%DATATABLE_SMB3_Bank46Graphics(NULLROM)
%BANK_END(!BANK_18)

%BANK_START(!BANK_19)
	%DATATABLE_SMB3_Bank47Graphics(NULLROM)
%BANK_END(!BANK_19)

%BANK_START(!BANK_1A)
	%DATATABLE_RT00_SMB3_Bank38Graphics(NULLROM)
	%DATATABLE_CUSTOM_SMB3_PauseMenuGFX(NULLROM)
	%DATATABLE_SMB3_BattleModeResultsScreenTilemap(NULLROM)
	%DATATABLE_RT01_SMB3_Bank38Graphics(NULLROM)
%BANK_END(!BANK_1A)

%BANK_START(!BANK_1B)
	%ROUTINE_CUSTOM_RT01_SMB3_UploadMainSampleData(NULLROM)
	%FREE_BYTES(NULLROM, 868, $FF)
%BANK_END(!BANK_1B)

%BANK_START(!BANK_1C)
	%DATATABLE_SMB3_Bank0CGraphics(NULLROM)
	%DATATABLE_RT00_SMB3_Bank3DGraphics(NULLROM)
	%DATATABLE_RT01_SMB3_Bank3DGraphics(NULLROM)
	%DATATABLE_RT02_SMB3_Bank3DGraphics(NULLROM)
	%ROUTINE_CUSTOM_SMB3_ErrorMessageFontGFX(NULLROM)
%BANK_END(!BANK_1C)

%BANK_START(!BANK_1D)
	%DATATABLE_RT00_SMB3_Palettes(NULLROM)
	%DATATABLE_RT01_SMB3_Palettes(NULLROM)
	%DATATABLE_RT00_SMB3_CompressedTilemaps(NULLROM)
	%DATATABLE_RT01_SMB3_CompressedTilemaps(NULLROM)
	%DATATABLE_RT02_SMB3_CompressedTilemaps(NULLROM)
	%DATATABLE_RT03_SMB3_CompressedTilemaps(NULLROM)
	%DATATABLE_RT04_SMB3_CompressedTilemaps(NULLROM)
	%DATATABLE_RT05_SMB3_CompressedTilemaps(NULLROM)
	%DATATABLE_RT06_SMB3_CompressedTilemaps(NULLROM)
	%DATATABLE_RT07_SMB3_CompressedTilemaps(NULLROM)
	%ROUTINE_CUSTOM_RT01_SMB3_UploadSPCEngine(NULLROM)
	%FREE_BYTES(NULLROM, 1101, $FF)
%BANK_END(!BANK_1D)

%BANK_START(!BANK_1E)
	%FREE_BYTES(NULLROM, 32768, $FF)
%BANK_END(!BANK_1E)

%BANK_START(!BANK_1F)
	%FREE_BYTES(NULLROM, 32768, $FF)
%BANK_END(!BANK_1F)
endmacro
