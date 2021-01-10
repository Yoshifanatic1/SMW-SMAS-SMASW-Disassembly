; Note: See the RAM map file for info about the tag system.
@includeonce

!SRAM_SMAS_Global_CopyDetectionCheck1 = $000000|!SRAMBankBaseAddress
;$700001 = Empty
!SRAM_SMAS_Global_ValidSaveData1Lo = $000002|!SRAMBankBaseAddress
!SRAM_SMAS_Global_ValidSaveData1Hi = !SRAM_SMAS_Global_ValidSaveData1Lo+$01
!SRAM_SMAS_Global_SaveFileIndexLo = $000004|!SRAMBankBaseAddress
!SRAM_SMAS_Global_SaveFileIndexHi = !SRAM_SMAS_Global_SaveFileIndexLo+$01
!SRAM_SMAS_Global_ControllerTypeX = $000006|!SRAMBankBaseAddress
!SRAM_SMAS_Global_EnableSMASDebugModeFlag = $000007|!SRAMBankBaseAddress
!SRAM_SMAS_Global_InitialSelectedWorld = $000008|!SRAMBankBaseAddress
!SRAM_SMAS_Global_InitialSelectedLevel = $000009|!SRAMBankBaseAddress
;$70000A-$70000D = Empty
!SRAM_SMAS_Global_CurrentSaveFile = $00000E|!SRAMBankBaseAddress
!SRAM_SMAS_Global_LastPlayedGame = $00000F|!SRAMBankBaseAddress
	!SRAM_SMB1_Cutscene_HeartEyesFlag = $00000F|!SRAMBankBaseAddress
!SRAM_SMAS_Global_SaveFileBaseOffset = $000010|!SRAMBankBaseAddress
	!SRAM_SMAS_Global_UnknownSRAM700370 = $000370|!SRAMBankBaseAddress
	!SRAM_SMAS_Global_UnknownSRAM700371 = !SRAM_SMAS_Global_UnknownSRAM700370+$01
	!SRAM_SMAS_Global_UnknownSRAM700379 = $000379|!SRAMBankBaseAddress
	!SRAM_SMAS_Global_UnknownSRAM70037A = !SRAM_SMAS_Global_UnknownSRAM700379+$01
	!SRAM_SMAS_Global_UnknownSRAM700381 = $000381|!SRAMBankBaseAddress
	!SRAM_SMAS_Global_UnknownSRAM700382 = !SRAM_SMAS_Global_UnknownSRAM700381+$01
	!SRAM_SMAS_Global_UnknownSRAM700388 = $000388|!SRAMBankBaseAddress
	!SRAM_SMAS_Global_UnknownSRAM700389 = !SRAM_SMAS_Global_UnknownSRAM700388+$01
	!SRAM_SMAS_Global_UnknownSRAM70038A = !SRAM_SMAS_Global_UnknownSRAM700389+$01
	!SRAM_SMAS_Global_UnknownSRAM70038B = !SRAM_SMAS_Global_UnknownSRAM700389+$02
	!SRAM_SMAS_Global_UnknownSRAM70038C = !SRAM_SMAS_Global_UnknownSRAM70038B+$01
!SRAM_SMAS_GameSelect_CanSelectHardModeWorldTable = $000490|!SRAMBankBaseAddress
!SRAM_SMAS_Global_UnknownSRAM7004A0 = $0004A0|!SRAMBankBaseAddress
!SRAM_SMAS_Global_UnknownSRAM7004A1 = !SRAM_SMAS_Global_UnknownSRAM7004A0+$01
;$7004A2-$700FFF = Empty
!SRAM_SMW_MarioA_StartLocation = $001000+!SRAMBankBaseAddress
!SRAM_SMW_MarioB_StartLocation = !SRAM_SMW_MarioA_StartLocation+(!Define_SMW_Misc_SaveFileSize*$01)
!SRAM_SMW_MarioC_StartLocation = !SRAM_SMW_MarioA_StartLocation+(!Define_SMW_Misc_SaveFileSize*$02)
!SRAM_SMW_MarioD_StartLocation = !SRAM_SMW_MarioA_StartLocation+(!Define_SMW_Misc_SaveFileSize*$03)
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E) != $00
	!SRAM_SMW_MarioA_Backup = !SRAM_SMW_MarioA_StartLocation+(!Define_SMW_Misc_SaveFileSize*$04)
	!SRAM_SMW_MarioB_Backup = !SRAM_SMW_MarioA_StartLocation+(!Define_SMW_Misc_SaveFileSize*$05)
	!SRAM_SMW_MarioC_Backup = !SRAM_SMW_MarioA_StartLocation+(!Define_SMW_Misc_SaveFileSize*$06)
	!SRAM_SMW_MarioD_Backup = !SRAM_SMW_MarioA_StartLocation+(!Define_SMW_Misc_SaveFileSize*$07)
else
	!SRAM_SMW_MarioA_Backup = !SRAM_SMW_MarioA_StartLocation+(!Define_SMW_Misc_SaveFileSize*$03)
	!SRAM_SMW_MarioB_Backup = !SRAM_SMW_MarioA_StartLocation+(!Define_SMW_Misc_SaveFileSize*$04)
	!SRAM_SMW_MarioC_Backup = !SRAM_SMW_MarioA_StartLocation+(!Define_SMW_Misc_SaveFileSize*$05)
	!SRAM_SMW_MarioD_Backup = !SRAM_SMW_MarioA_StartLocation+(!Define_SMW_Misc_SaveFileSize*$06)
endif
;$7013EA-$701FDF = Empty
!SRAM_SMB1_Global_TopScoreMillionsDigit = $001FE0|!SRAMBankBaseAddress
!SRAM_SMB1_Global_TopScoreHundredThousandsDigit = !SRAM_SMB1_Global_TopScoreMillionsDigit+$01
!SRAM_SMB1_Global_TopScoreTenThousandsDigit = !SRAM_SMB1_Global_TopScoreMillionsDigit+$02
!SRAM_SMB1_Global_TopScoreThousandsDigit = !SRAM_SMB1_Global_TopScoreMillionsDigit+$03
!SRAM_SMB1_Global_TopScoreHundredsDigit = !SRAM_SMB1_Global_TopScoreMillionsDigit+$04
!SRAM_SMB1_Global_TopScoreTensDigit = !SRAM_SMB1_Global_TopScoreMillionsDigit+$05
;$701FE6-$701FE7 = Empty
!SRAM_SMBLL_Global_TopScoreMillionsDigit = $001FE8|!SRAMBankBaseAddress
!SRAM_SMBLL_Global_TopScoreHundredThousandsDigit = !SRAM_SMBLL_Global_TopScoreMillionsDigit+$01
!SRAM_SMBLL_Global_TopScoreTenThousandsDigit = !SRAM_SMBLL_Global_TopScoreMillionsDigit+$02
!SRAM_SMBLL_Global_TopScoreThousandsDigit = !SRAM_SMBLL_Global_TopScoreMillionsDigit+$03
!SRAM_SMBLL_Global_TopScoreHundredsDigit = !SRAM_SMBLL_Global_TopScoreMillionsDigit+$04
!SRAM_SMBLL_Global_TopScoreTensDigit = !SRAM_SMBLL_Global_TopScoreMillionsDigit+$05
;$701FEE-$701FEF = Empty
!SRAM_SMAS_TitleScreen_CurrentGameDemo = $001FF0|!SRAMBankBaseAddress
;$701FF1 = Empty
!SRAM_SMAS_Global_RunningDemoFlag = $001FF2|!SRAMBankBaseAddress
;$701FF3 = Empty
!SRAM_SMAS_Global_Controller1PluggedInFlag = $001FF4|!SRAMBankBaseAddress
;$701FF5 = Empty
!SRAM_SMAS_Global_Controller2PluggedInFlag = $001FF6|!SRAMBankBaseAddress
;$701FF7 = Empty
!SRAM_SMAS_Global_UnusedRAM701FF8 = $701FF8
	!SRAM_SMB1_Global_CopyOfHardModeActiveFlag = !SRAM_SMAS_Global_UnusedRAM701FF8
!SRAM_SMAS_Global_UnusedRAM701FF9 = $701FF9
	!SRAM_SMB1_Global_CopyOfCurrentWorld = !SRAM_SMAS_Global_UnusedRAM701FF9
;$701FFA-$701FFB = Empty
!SRAM_SMAS_Global_ValidSaveData2Lo = $001FFC|!SRAMBankBaseAddress
!SRAM_SMAS_Global_ValidSaveData2Hi = !SRAM_SMAS_Global_ValidSaveData2Lo+$01
;$701FFE-$701FFF = Empty

!SRAM_SMAS_Global_CopyDetectionCheck2 = !SRAMBankEnd|(!SRAMBankBaseAddress&$FF0000)