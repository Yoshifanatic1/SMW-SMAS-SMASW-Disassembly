; Note: Put your custom routine/data macros, references to them, and defines in this file from within the SMAS_InsertIntegratedPatches and SMAS_ApplyPatchesPostAssembly macros below.
; By doing this:
; 1). All the changes you make for your hack will all be in one place
; 2). It will be easier to revert things if needed.
; 3). Porting things over to a newer version of the source code will be easier.
; Note that all custom code macros must have a "Custom_" appended to the start of it (minus the region specific tags if necessary) so asar will know to look for it.
; Also, you can redfine existing defines/RAM addresses here.
; Note that if you plan on using asar patches, you'll need to make a few changes to them so they will work optimially. I'll list them out once I know what needs to be done.

;---------------------------------------------------------------------------

if !Define_Global_ApplyAsarPatches == !TRUE
macro SMAS_InsertIntegratedPatches()
; Insert your patch references here that will be assembled during ROM assembly
; Use this macro for patches that you have integrated into this disassembly


if !Define_Global_SMASGames&(!SMASGames_SMB1) != $00
	incsrc "../../SMB1/Custom/Asar_Patches_SMB1.asm"
	%SMB1_InsertIntegratedPatches()
endif
if !Define_Global_SMASGames&(!SMASGames_SMBLL) != $00
	incsrc "../../SMBLL/Custom/Asar_Patches_SMBLL.asm"
	%SMBLL_InsertIntegratedPatches()
endif
if !Define_Global_SMASGames&(!SMASGames_SMB2U) != $00
	incsrc "../../SMB2U/Custom/Asar_Patches_SMB2U.asm"
	%SMB2U_InsertIntegratedPatches()
endif
if !Define_Global_SMASGames&(!SMASGames_SMB3) != $00
	incsrc "../../SMB3/Custom/Asar_Patches_SMB3.asm"
	%SMB3_InsertIntegratedPatches()
endif
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2)
else
	if !Define_Global_SMASGames&(!SMASGames_SMW) != $00
		incsrc "../../SMW/Custom/Asar_Patches_SMW.asm"
		%SMW_InsertIntegratedPatches()
	endif
endif
endmacro

macro SMAS_ApplyPatchesPostAssembly()
; Insert your patch references here that will be assembled after the ROM has been assembled.
; Use this macro for patches that don't work correctly while the ROM is assembling, like ones that use the readX commands or haven't been integrated into this disassembly.


endmacro
endif

;---------------------------------------------------------------------------