; Debug Functions

; Select cut-scene.
!DEBUG_BossSceneSelect = !FALSE

; Advance game frame-by-frame.
; Usage: Pause then on controller 2 press Y to advance one frame, or hold B to keep advancing.
!DEBUG_SlowMotion = !FALSE

; Beat any level.
; Usage: Pause then press Select for regular exit or Select+A/B for secret exit.
!DEBUG_BeatLevel = !FALSE

; Select any power-up. (Comined with FreeMovement in SMASE)
; Usage: Press Up+Select to cycle through power-ups.
!DEBUG_PowerUpSelect = !FALSE

; Free movement through anything. (Comined with PowerUpSelect in SMASE)
; Usage: Press L+A to toggle free movement, d-pad to control, X/Y to speed up.
!DEBUG_FreeMovement = !FALSE

; Select any Yoshi.
; Usage: Press Select on the overworld to cycle through Yoshi colors.
!DEBUG_CycleYoshiColors = !FALSE

; Warp to Star Road.
; Usage: Press Select while on "YOSHI'S HOUSE" to warp to Star Road.
!DEBUG_StarRoadWarp = !FALSE

; Walk freely on the overworld.
; Usage: Use the d-pad to move freely on the overworld.
!DEBUG_WalkOnUnrevealedOWPaths = !FALSE

;---------------------------------------------------------------------------

; Note: The below defines add custom debug functions that aren't built into the game already.

; Gives the player infinite star power
!DEBUG_InfiniteStar = !FALSE

; Makes goal tapes/spheres trigger cutscenes
!DEBUG_TriggerCutsceneOnGoal = !FALSE

;---------------------------------------------------------------------------


if !DEBUG_BossSceneSelect == !TRUE
org SMW_GAMEMODE19_Cutscene_Debug_BossSceneSelect
	AND.b #!BUTTON_L|!BUTTON_R
endif

if !DEBUG_SlowMotion == !TRUE
org SMW_GAMEMODE14_InLevel_Debug_SlowMotion
	NOP #2
endif

if !DEBUG_BeatLevel == !TRUE
org SMW_GAMEMODE14_InLevel_Debug_BeatLevel1
	NOP #2

org SMW_GAMEMODE14_InLevel_Debug_BeatLevel2
	NOP #2
endif

if !Define_Global_ROMToAssemble&(!ROM_SMASE) != $00
if (!DEBUG_PowerUpSelect|!DEBUG_FreeMovement) == !TRUE
org SMW_#Debug_FreeMovementAndPowerUpSelect
	NOP #2
endif

else
if !DEBUG_PowerUpSelect == !TRUE
org SMW_Debug_PowerUpSelect
	BEQ.b CODE_00C585
endif

if !DEBUG_FreeMovement == !TRUE
org SMW_Debug_FreeMovement
	BEQ.b CODE_00CCBB
endif
endif

if !DEBUG_CycleYoshiColors == !TRUE
org SMW_GAMEMODE0E_ShowOverworld_Debug_CycleYoshiColors
	BEQ.b .CODE_048261
endif

if !DEBUG_StarRoadWarp == !TRUE
org SMW_OverworldProcess03_StandingStill_Debug_StarRoadWarp
	BEQ.b .OW_Player_Update
endif

if !DEBUG_WalkOnUnrevealedOWPaths == !TRUE
org SMW_Debug_WalkOnUnrevealedOWPaths
	JMP.w CODE_0492B2
endif

if !DEBUG_InfiniteStar == !TRUE
org SMW_PlayerGFXRt_Debug_InfiniteStar
	NOP #2
endif

if !DEBUG_TriggerCutsceneOnGoal == !TRUE
org SMW_NorSpr07B_GoalTape_Status08_Debug_TriggerCutsceneOnGoal
autoclean SMW_TriggerCutsceneOnGoal_Main

org SMW_NorSpr07B_GoalTape_Status08_Debug_TriggerCutsceneOnGoal
autoclean JSL.l SMW_TriggerCutsceneOnGoal_Main
	NOP

org SMW_NorSpr04A_GoalSphere_Status08_Debug_TriggerCutsceneOnGoal
	JSL SMW_TriggerCutsceneOnGoal_Main
	NOP
freecode
SMW_TriggerCutsceneOnGoal_Main:
	LDA.b #$FF
	STA.w !RAM_SMW_Timer_EndLevel
	INC.w !RAM_SMW_Misc_CurrentlyActiveBossEndCutscene
	RTL
endif