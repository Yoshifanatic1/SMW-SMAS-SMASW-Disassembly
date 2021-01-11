if !Define_Global_ROMToAssemble&(!ROM_SMASW_U|!ROM_SMASW_E) != $00
else
!SRAM_SMW_MarioA_StartLocation = !SRAMBankBaseAddress
!SRAM_SMW_MarioB_StartLocation = !SRAM_SMW_MarioA_StartLocation+(!Define_SMW_Misc_SaveFileSize*$01)
!SRAM_SMW_MarioC_StartLocation = !SRAM_SMW_MarioA_StartLocation+(!Define_SMW_Misc_SaveFileSize*$02)
!SRAM_SMW_MarioA_Backup = !SRAM_SMW_MarioA_StartLocation+(!Define_SMW_Misc_SaveFileSize*$03)
!SRAM_SMW_MarioB_Backup = !SRAM_SMW_MarioA_StartLocation+(!Define_SMW_Misc_SaveFileSize*$04)
!SRAM_SMW_MarioC_Backup = !SRAM_SMW_MarioA_StartLocation+(!Define_SMW_Misc_SaveFileSize*$05)
endif