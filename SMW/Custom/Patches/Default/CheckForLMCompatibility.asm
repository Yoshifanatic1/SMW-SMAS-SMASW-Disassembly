; Note: This patch checks to see if certain labels are at locations that Lunar Magic reads/writes.
; Latest version of Lunar Magic at the time of this writing is 2.53.

macro PrintLMLabelOffset(Namespace, Label)
org <Namespace>_<Label>
	print "#<Label> located at $",pc
	print "#<Label> must be at !{!{ROMID}OrgLoc}"
	print ""
endmacro

if !Define_Global_ROMToAssemble&$F6 == $00
{
	; Info: Check if the RTL used by certain ASM hacks that JSL to an RTS routine in bank 00 is at the original location. If not, this can cause crashes.
	; Note that the actual RTL is found 1 byte further, but in order for the ASM to work as intended, the label needs to be located at the byte before the RTL.
	!USAOrgLoc = $00804C : !JAPANOrgLoc = $00804C : !SMASUOrgLoc = NULLROM
		%PrintLMLabelOffset(SMW_InitAndMainLoop, LM000Hijack_Bank00RTL)

;---------------------------------------------------------------------------

	; Info: Check for the block offset locations. If these aren't where LM expects them to be, then block collision becomes broken.
	; Note that if you want to modify the ASM that checks for these labels, you need to add $02 to them or they won't work.
	!USAOrgLoc = $00EC24 : !JAPANOrgLoc = NULLROM : !SMASUOrgLoc = NULLROM
		%PrintLMLabelOffset(SMW_RunPlayerBlockCode, LMBlockOffset_MarioSide)

	!USAOrgLoc = $00EC3A : !JAPANOrgLoc = NULLROM : !SMASUOrgLoc = NULLROM
		%PrintLMLabelOffset(SMW_RunPlayerBlockCode, LMBlockOffset_BodyInside)

	!USAOrgLoc = $00EC8A : !JAPANOrgLoc = NULLROM : !SMASUOrgLoc = NULLROM
		%PrintLMLabelOffset(SMW_RunPlayerBlockCode, LMBlockOffset_MarioBelow)

	!USAOrgLoc = $00ED4A : !JAPANOrgLoc = NULLROM : !SMASUOrgLoc = NULLROM
		%PrintLMLabelOffset(SMW_RunPlayerBlockCode, LMBlockOffset_MarioAbove)

	!USAOrgLoc = $00EDE9 : !JAPANOrgLoc = NULLROM : !SMASUOrgLoc = NULLROM
		%PrintLMLabelOffset(SMW_RunPlayerBlockCode, LMBlockOffset_TopCorner)

	!USAOrgLoc = $029507 : !JAPANOrgLoc = NULLROM : !SMASUOrgLoc = NULLROM
		%PrintLMLabelOffset(SMW_HandleCapeInteraction, LMBlockOffset_MarioCape)

	;!USAOrgLoc = $029FD8 : !JAPANOrgLoc = NULLROM : !SMASUOrgLoc = NULLROM
	;	%PrintLMLabelOffset(SMW_ExtSpr05_MarioFireball, LMBlockOffset_MarioFireball)

;---------------------------------------------------------------------------

	; Info: I have yet to determine what the routine at $05DD00 is for.
	;!USAOrgLoc = $00A6CC : !JAPANOrgLoc = NULLROM : !SMASUOrgLoc = NULLROM
	;	%PrintLMLabelOffset(SMW_InitializeLevelRAM, LM000Hijack_JSLTo05DD00)

;---------------------------------------------------------------------------

	; Info: Some hijacks related to LM's fade fix patch. I haven't done much reseach yet on this however.
	;!USAOrgLoc = $00AF4B : !JAPANOrgLoc = NULLROM : !SMASUOrgLoc = NULLROM
	;	%PrintLMLabelOffset(SMW_, LM170Hijack_FadeFix1)

	;!USAOrgLoc = $00AF4E : !JAPANOrgLoc = NULLROM : !SMASUOrgLoc = NULLROM
	;	%PrintLMLabelOffset(SMW_, LM170Hijack_FadeFix2)

	;!USAOrgLoc = $00AF6B : !JAPANOrgLoc = NULLROM : !SMASUOrgLoc = NULLROM
	;	%PrintLMLabelOffset(SMW_, LM170Hijack_FadeFix3)

	;!USAOrgLoc = $00AF74 : !JAPANOrgLoc = NULLROM : !SMASUOrgLoc = NULLROM
	;	%PrintLMLabelOffset(SMW_, LM170Hijack_FadeFix4)

;---------------------------------------------------------------------------

	; Info: This hijack changes the timing of the player showing their victory pose during the goal walk so it's synced up to the music again. Does not apply if using the SA-1.
	;!USAOrgLoc = $00C976 : !JAPANOrgLoc = NULLROM : !SMASUOrgLoc = NULLROM
	;	%PrintLMLabelOffset(SMW_, LM253Hijack_VictoryPoseTimingFix)

;---------------------------------------------------------------------------

	; Info: This hijack modifies the init pointer of normal sprite 052 to fix a bug.
	!USAOrgLoc = $018221 : !JAPANOrgLoc = NULLROM : !SMASUOrgLoc = NULLROM
		%PrintLMLabelOffset(SMW_NorSprStatus01_Init, LM253Hijack_MovingLedgeHoleInitFix)

;---------------------------------------------------------------------------

	; Info: These hijacks let you set the locations the overworld koopa kids teleport you to.
	;!USAOrgLoc = $048E49 : !JAPANOrgLoc = NULLROM : !SMASUOrgLoc = NULLROM
	;	%PrintLMLabelOffset(SMW_, GameMode0C_LoadOverworld_LM220Hijack_SetKoopaTeleportHere1)

	;!USAOrgLoc = $048E4F : !JAPANOrgLoc = NULLROM : !SMASUOrgLoc = NULLROM
	;	%PrintLMLabelOffset(SMW_, GameMode0C_LoadOverworld_LM220Hijack_SetKoopaTeleportHere2)

;---------------------------------------------------------------------------

	; Info: These hijacks allow you to have custom level names that are more easily customizable.
	;!USAOrgLoc = $048E81 : !JAPANOrgLoc = NULLROM : !SMASUOrgLoc = NULLROM
	;	%PrintLMLabelOffset(SMW_, LM000Hijack_CustomLevelNames1)

	;!USAOrgLoc = $049549 : !JAPANOrgLoc = NULLROM : !SMASUOrgLoc = NULLROM
	;	%PrintLMLabelOffset(SMW_, LM000Hijack_CustomLevelNames2)

	;!USAOrgLoc = $03BB20 : !JAPANOrgLoc = NULLROM : !SMASUOrgLoc = NULLROM
	;	%PrintLMLabelOffset(SMW_, LM000Routine_CustomLevelNames)

;---------------------------------------------------------------------------

	; Info: These hijacks allow you to place levels anywhere on the overworld and not be limited by SMW's more hardcoded system.
	;!USAOrgLoc = $04D7F9 : !JAPANOrgLoc = NULLROM : !SMASUOrgLoc = NULLROM
	;	%PrintLMLabelOffset(SMW_, LM000Hijack_PlaceOverworldLevelAnywhere)

;---------------------------------------------------------------------------

	; Info: This hijack lets you have custom palettes on the overworld
	!USAOrgLoc = $00AD32 : !JAPANOrgLoc = NULLROM : !SMASUOrgLoc = NULLROM
		%PrintLMLabelOffset(SMW_BufferPalettesRoutines, LM180Hijack_CustomOverworldPalettes)

;---------------------------------------------------------------------------

	; Info: This hijack changes one of the unused tile animation entries so that the animated water can be used in more tilesets.
	!USAOrgLoc = $05BAA9 : !JAPANOrgLoc = NULLROM : !SMASUOrgLoc = NULLROM
		%PrintLMLabelOffset(SMW_LevelTileAnimations, LM120Hijack_AnimatedWaterInMoreTilesets)

;---------------------------------------------------------------------------

	; Info: These hijacks allow you to have custom animations on a per level/submap basis.
	!USAOrgLoc = $00A390 : !JAPANOrgLoc = NULLROM : !SMASUOrgLoc = NULLROM
		%PrintLMLabelOffset(SMW_UploadLevelAnimations, LM160Hijack_UploadLevelExAnimationData)

	!USAOrgLoc = $00A4E3 : !JAPANOrgLoc = NULLROM : !SMASUOrgLoc = NULLROM
		%PrintLMLabelOffset(SMW_UploadOverworldAnimations, LM240Hijack_UploadOverworldExAnimationData)

;---------------------------------------------------------------------------

	; Info: These hijacks disable some ASM used to backup part of SP1 after displaying the loading letters.
	; LM forces all graphics to reload on level load, rendering this code useless (and it was already almost useless to begin with, only mattering when entering the bonus game).
	!USAOrgLoc = $00A436 : !JAPANOrgLoc = NULLROM : !SMASUOrgLoc = NULLROM
		%PrintLMLabelOffset(SMW_RestoreSP1AfterMarioStart, LM221Hijack_DisableSP1VRAMBackup1)

;---------------------------------------------------------------------------

	; Info: This pointer is hijacked to allow you to have a custom layer 3 title screen image.
	!USAOrgLoc = $0084D3 : !JAPANOrgLoc = NULLROM : !SMASUOrgLoc = NULLROM
		%PrintLMLabelOffset(SMW_LoadStripeImage, LM000Hijack_CustomTitleScreen)

;---------------------------------------------------------------------------

	; Info: Lunar Magic hijacks all the pointers to the castle destruction text so you can have custom text for these cutscenes
	; Note that these hijacks don't apply to the Japanese version.
	!USAOrgLoc = $0084F1 : !JAPANOrgLoc = NULLROM : !SMASUOrgLoc = NULLROM
		%PrintLMLabelOffset(SMW_LoadStripeImage, LM000Hijack_CustomCastleDestructionText)

;---------------------------------------------------------------------------

	; Info: This hijack disables Chocolate Island 2's gimmick if the appropriate setting is toggled
	!USAOrgLoc = $05DAE6 : !JAPANOrgLoc = NULLROM : !SMASUOrgLoc = NULLROM
		%PrintLMLabelOffset(SMW_SpecifySublevelToLoad, LM000Hijack_DisableChocolateIsland2Gimmick)
}
else
{
}
endif