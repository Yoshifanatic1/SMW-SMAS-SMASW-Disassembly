; RAM Define tags:
; "Player" = RAM address associated with the player sprite in levels.
; "NorSpr" = RAM address associated with normal sprites.
; "NorSprZZ_Y" = RAM address associated with normal sprite Y of ID ZZ. Can also refer to a group of sprites if ZZ is XX.
; "GenSpr" = RAM address associated with a generator sprite.
; "FireSpr" = RAM address associated with player fireball sprites.
; "BounceSpr" = RAM address associated with bounce sprites
; "HammerSpr" = RAM address associated with hammer sprites
; "CoinSpr" = RAM address associated with spinning coin sprites
; "BreathSpr" = RAM address associated with breath sprites
; "BridgeSpr" = RAM address associated with crumbling bridge sprites
; "ContactSpr" = RAM address associated with contact effect sprites
; "Level" = RAM address associated with a level function
; "LevelLoad" = RAM address associated with a level loading function
; "Cutscene" = RAM address associated with a cutscene
; "ErrorScreen" "SplashScreen" "TitleScreen" "GameOver" = Used on that specific screen.
; "Global" = Used anywhere or close to everywhere.

!RAM_SMB1_Global_ScratchRAM00 = $000000
!RAM_SMB1_Global_ScratchRAM01 = $000001
!RAM_SMB1_Global_ScratchRAM02 = $000002
!RAM_SMB1_Global_ScratchRAM03 = $000003
!RAM_SMB1_Global_ScratchRAM04 = $000004
!RAM_SMB1_Global_ScratchRAM05 = $000005
!RAM_SMB1_Global_ScratchRAM06 = $000006
!RAM_SMB1_Global_ScratchRAM07 = $000007

!RAM_SMB1_Global_FrameCounter = $000009
!RAM_SMB1_Global_ControllerABXYHeld = $00000A
!RAM_SMB1_Global_ControllerUpDownHeld = $00000B
!RAM_SMB1_Global_ControllerLeftRightHeld = $00000C
!RAM_SMB1_Global_CopyOfControllerABXYHeld = $00000D

!RAM_SMB1_Player_CurrentState = $00000F
!RAM_SMB1_NorSpr_SpriteSlotExistsFlag = $000010
!RAM_SMB1_Global_DisableSpriteOAMResetFlag = $00001B
!RAM_SMB1_NorSpr_SpriteID = $00001C
!RAM_SMB1_Level_Player_CurrentPhysicsType = $000028
!RAM_SMB1_NorSpr_SpriteStatusFlags = $000029
; Info:
; $01 = In air
;
; $04 = Stunned
;
;
; $20 = Dead
;
; $80 = Kicked

; $000047 - Normal sprite facing direction?

!RAM_SMB1_Level_CurrentLevelType = $00005C
	; Info:
	; $00 = Underwater
	; $01 = Grassland
	; $02 = Underground
	; $03 = Castle
!RAM_SMB1_Player_XSpeed = $00005D
!RAM_SMB1_NorSpr_XSpeed = !RAM_SMB1_Player_XSpeed+$01
!RAM_SMB1_FireSpr_XSpeed = $000068
!RAM_SMB1_BounceSpr_XSpeed = $00006A
!RAM_SMB1_HammerSpr_XSpeed = $00006E
!RAM_SMB1_CoinSpr_XSpeed = !RAM_SMB1_HammerSpr_XSpeed
!RAM_SMB1_Player_XPosHi = $000078
!RAM_SMB1_NorSpr_XPosHi = !RAM_SMB1_Player_XPosHi+$01
!RAM_SMB1_FireSpr_XPosHi = $000083
!RAM_SMB1_BounceSpr_XPosHi = $000085
!RAM_SMB1_HammerSpr_XPosHi = $000089
!RAM_SMB1_CoinSpr_XPosHi = !RAM_SMB1_HammerSpr_XPosHi
!RAM_SMB1_BreathSpr_XPosHi = $000092

!RAM_SMB1_Player_YSpeed = $0000A0
!RAM_SMB1_NorSpr_YSpeed = !RAM_SMB1_Player_YSpeed+$01
!RAM_SMB1_FireSpr_YSpeed = $0000AB
!RAM_SMB1_BounceSpr_YSpeed = $0000AD
!RAM_SMB1_HammerSpr_YSpeed = $0000B1
!RAM_SMB1_CoinSpr_YSpeed = !RAM_SMB1_HammerSpr_YSpeed

!RAM_SMB1_Player_YPosHi = $0000BB
!RAM_SMB1_NorSpr_YPosHi = !RAM_SMB1_Player_YPosHi+$01
!RAM_SMB1_FireSpr_YPosHi = $0000C6
!RAM_SMB1_BounceSpr_YPosHi = $0000C8
!RAM_SMB1_HammerSpr_YPosHi = $0000CC
!RAM_SMB1_CoinSpr_YPosHi = !RAM_SMB1_HammerSpr_YPosHi
!RAM_SMB1_BreathSpr_YPosHi = $0000D5

; $0000DB - Something to do with the layer 2 BG and palette.

!RAM_SMB1_Global_ScratchRAMDD = $0000DD
!RAM_SMB1_Global_ScratchRAMDE = $0000DE
!RAM_SMB1_Global_ScratchRAMDF = $0000DF
!RAM_SMB1_Global_ScratchRAME0 = $0000E0
!RAM_SMB1_Global_ScratchRAME1 = $0000E1
!RAM_SMB1_Global_ScratchRAME2 = $0000E2
!RAM_SMB1_Global_ScratchRAME3 = $0000E3
!RAM_SMB1_Global_ScratchRAME4 = $0000E4
!RAM_SMB1_Global_ScratchRAME5 = $0000E5
!RAM_SMB1_Global_ScratchRAME6 = $0000E6
!RAM_SMB1_Global_ScratchRAME7 = $0000E7
!RAM_SMB1_Global_ScratchRAME8 = $0000E8
!RAM_SMB1_Global_ScratchRAME9 = $0000E9
!RAM_SMB1_Global_ScratchRAMEA = $0000EA
!RAM_SMB1_Global_ScratchRAMEB = $0000EB
!RAM_SMB1_Global_ScratchRAMEC = $0000EC
!RAM_SMB1_Global_ScratchRAMED = $0000ED
!RAM_SMB1_Global_ScratchRAMEE = $0000EE
!RAM_SMB1_Global_ScratchRAMEF = $0000EF
!RAM_SMB1_Global_ScratchRAMF0 = $0000F0
!RAM_SMB1_Global_ScratchRAMF1 = $0000F1
!RAM_SMB1_Global_ScratchRAMF2 = $0000F2
!RAM_SMB1_Global_ScratchRAMF3 = $0000F3
!RAM_SMB1_Global_ScratchRAMF4 = $0000F4
!RAM_SMB1_Global_ScratchRAMF5 = $0000F5
!RAM_SMB1_Global_ScratchRAMF6 = $0000F6
	!RAM_SMB1_Level_UseAlternateObjectsFlag = $0000F6
!RAM_SMB1_Global_ScratchRAMF7 = $0000F7
!RAM_SMB1_Global_ScratchRAMF8 = $0000F8
!RAM_SMB1_Global_ScratchRAMF9 = $0000F9
!RAM_SMB1_Level_LevelDataPtrLo = $0000FA
!RAM_SMB1_Level_LevelDataPtrHi = !RAM_SMB1_Level_LevelDataPtrLo+$01
!RAM_SMB1_Level_LevelDataPtrBank = !RAM_SMB1_Level_LevelDataPtrLo+$02
!RAM_SMB1_Level_SpriteListDataLo = $0000FD
!RAM_SMB1_Level_SpriteListDataHi = !RAM_SMB1_Level_SpriteListDataLo+$01
!RAM_SMB1_Level_SpriteListDataBank = !RAM_SMB1_Level_SpriteListDataLo+$02
!RAM_SMB1_Global_EndOfStack = !RAM_SMB1_Global_StartOfStack-$FF
	!RAM_SMB1_Level_3ByteObjectFlag = $00010B
	!RAM_SMB1_Level_GoalFlagScoreYPosHi = $00010B
	!RAM_SMB1_Level_GoalFlagScoreYPosLo = $00010D
	!RAM_SMB1_Level_GoalFlagScoreSubYPos = $00010E
	!RAM_SMB1_Level_GoalFlagScoreAmountIndex = $00010F
	!RAM_SMB1_Level_ScoreSpr_SpriteID = $000110
	!RAM_SMB1_Level_ScoreSpr_XPosLo = $00011A
	!RAM_SMB1_Level_ScoreSpr_YPosLo = $000124
	!RAM_SMB1_Level_NorSpr_KillCounter = $00012E
	!RAM_SMB1_Level_ScoreSpr_DisplayTimer = $000138
	!RAM_SMB1_Level_ScoreSpr_AddToScoreBuffer = $000145
!RAM_SMB1_Global_StartOfStack = $0001FF

!RAM_SMB1_NorSpr02D_Bowser_UnknownRAM = $000201					; Note: This is used in SMBLL
!RAM_SMB1_Level_Player_FacingDirection = $000202
!RAM_SMB1_NorSpr_Table7E0203 = $000203
	!RAM_SMB1_Cutscene_MaxXPosHi = $000203
	!RAM_SMB1_Cutscene_CanScrollFlag = $000204
!RAM_SMB1_FireSpr_HitGroundFlag = !RAM_SMB1_NorSpr_Table7E0203+$0A
!RAM_SMB1_NorSpr_Table7E020F = $00020F
!RAM_SMB1_Player_XPosLo = $000219
!RAM_SMB1_NorSpr_XPosLo = !RAM_SMB1_Player_XPosLo+$01
!RAM_SMB1_FireSpr_XPosLo = $000224
!RAM_SMB1_BounceSpr_XPosLo = $000226
!RAM_SMB1_HammerSpr_XPosLo = $00022A
!RAM_SMB1_CoinSpr_XPosLo = !RAM_SMB1_HammerSpr_XPosLo
!RAM_SMB1_BreathSpr_XPosLo = $000233

!RAM_SMB1_Level_GrowVineAtLevelEntranceFlag = $000236

!RAM_SMB1_Player_YPosLo = $000237
!RAM_SMB1_NorSpr_YPosLo = !RAM_SMB1_Player_YPosLo+$01
!RAM_SMB1_FireSpr_YPosLo = $000242
!RAM_SMB1_BounceSpr_YPosLo = $000244
!RAM_SMB1_HammerSpr_YPosLo = $000248
!RAM_SMB1_CoinSpr_YPosLo = !RAM_SMB1_HammerSpr_YPosLo
!RAM_SMB1_BreathSpr_YPosLo = $000251

!RAM_SMB1_Player_DisableAutoPaletteUpdate = $000254

!RAM_SMB1_Level_BulletShooterXPosHi = $00026B
	!RAM_SMB1_Level_WhirlpoolXPosHi = !RAM_SMB1_Level_BulletShooterXPosHi
!RAM_SMB1_Level_BulletShooterXPosLo = $000271
	!RAM_SMB1_Level_WhirlpoolXPosLoLeftBoundary = !RAM_SMB1_Level_BulletShooterXPosLo
!RAM_SMB1_Level_BulletShooterYPosLo = $000277
	!RAM_SMB1_Level_WhirlpoolXPosLoRightBoundary = !RAM_SMB1_Level_BulletShooterYPosLo
!RAM_SMB1_Level_BulletShooterTimer = $00027D
	!RAM_SMB1_Level_PlayerIsAboveWhirlpoolFlag = !RAM_SMB1_Level_BulletShooterTimer
!RAM_SMB1_NorSpr02D_Bowser_CurrentHP = $000283

!RAM_SMB1_Global_GraphicsUploadPointerLo = $000285
!RAM_SMB1_Global_GraphicsUploadPointerHi = !RAM_SMB1_Global_GraphicsUploadPointerLo+$01
!RAM_SMB1_Global_GraphicsUploadPointerBank = $000287
!RAM_SMB1_Global_GraphicsUploadSizeLo = $000288
!RAM_SMB1_Global_GraphicsUploadSizeHi = !RAM_SMB1_Global_GraphicsUploadSizeLo+$01
!RAM_SMB1_Global_GraphicsUploadVRAMAddressLo = $00028A
!RAM_SMB1_Global_GraphicsUploadVRAMAddressHi = !RAM_SMB1_Global_GraphicsUploadVRAMAddressLo+$01

!RAM_SMB1_Player_GraphicsPointerLo = $00028F
!RAM_SMB1_Player_GraphicsPointerHi = !RAM_SMB1_Player_GraphicsPointerLo+$01
!RAM_SMB1_Player_GraphicsPointerBank = !RAM_SMB1_Player_GraphicsPointerLo+$02

!RAM_SMB1_Player_GraphicsUploadSizeLo = $000293
!RAM_SMB1_Player_GraphicsUploadSizeHi = !RAM_SMB1_Player_GraphicsUploadSizeLo+$01
!RAM_SMB1_Player_VRAMAddressLo = $000295
!RAM_SMB1_Player_VRAMAddressHi = !RAM_SMB1_Player_VRAMAddressLo+$01

!RAM_SMB1_Player_PlayerEnteredCoinHeavenFlag = $0002FF
!RAM_SMB1_Level_BridgeSpr_SpriteSlotExistsFlag = $000300
!RAM_SMB1_Level_BridgeSpr_AnimationFrame = $00030D
!RAM_SMB1_Level_BridgeSpr_XPosLo = $00031A
!RAM_SMB1_Level_BridgeSpr_AnimationFrameTimer = $000327

!RAM_SMB1_NorSpr02D_Bowser_UnusedBridgeSegmentIndex = $000334

!RAM_SMB1_NorSpr02D_Bowser_WaitBeforeBreakingNextBridgeSegment = $000364
!RAM_SMB1_NorSpr02D_Bowser_XAcceleration = $000365
!RAM_SMB1_NorSpr02D_Bowser_InitialXPosLo = $000366
!RAM_SMB1_NorSpr02D_Bowser_NumberOfBrokenBridgeSegments = $000369

!RAM_SMB1_NorSpr02D_Bowser_WoozyEffectAnimationFrame = $0003CA
!RAM_SMB1_NorSpr02D_Bowser_FeelingWoozyFlag = $0003CB

!RAM_SMB1_Level_BlockYPosIndex = $0003E6
!RAM_SMB1_Level_BlockXPosIndex = $0003E8
!RAM_SMB1_Level_BlockTile = $0003EA
!RAM_SMB1_CoinSpr_BlockPosXHi = $0003EC
!RAM_SMB1_Level_RevertBlockStateFlag = $0003EE
!RAM_SMB1_Level_BlockSlotIndex = $0003F0
; $0003F1 = Empty?
!RAM_SMB1_Level_BlocksThatChangedStateCounter = $0003F2

!RAM_SMB1_Player_SubYPos = $00041C
!RAM_SMB1_NorSpr_SubYPos = !RAM_SMB1_Player_SubYPos+$01
!RAM_SMB1_FireSpr_SubYPos = $000427
!RAM_SMB1_BounceSpr_SubYPos = $000429
!RAM_SMB1_HammerSpr_SubYPos = $00042D
!RAM_SMB1_CoinSpr_SubYPos = !RAM_SMB1_HammerSpr_YPos

!RAM_SMB1_Player_SubYSpeed = $00043C
!RAM_SMB1_NorSpr_SubYSpeed = !RAM_SMB1_Player_SubYSpeed+$01
!RAM_SMB1_FireSpr_SubYSpeed = $000447
!RAM_SMB1_BounceSpr_SubYSpeed = $000449
!RAM_SMB1_HammerSpr_SubYSpeed = $00044D
!RAM_SMB1_CoinSpr_SubYSpeed = !RAM_SMB1_HammerSpr_YSpeed

!RAM_SMB1_Player_HitboxSizeIndex = $00048F
!RAM_SMB1_NorSpr_HitboxSizeIndex = !RAM_SMB1_Player_HitboxSizeIndex+$01		; $000490
!RAM_SMB1_FireSpr_HitboxSizeIndex = !RAM_SMB1_Player_HitboxSizeIndex+$0B
!RAM_SMB1_HammerSpr_HitboxSizeIndex = !RAM_SMB1_Player_HitboxSizeIndex+$0D

!RAM_SMB1_Level_LevelDataMap16Lo = $000500

!RAM_SMB1_Level_NextColumnOfLevelDataTable = $0006A1

!RAM_SMB1_Level_10CoinBlockHasBeenHitFlag = $0006BC

!RAM_SMB1_Level_SpriteToRandomlyGenerate = $0006CB
!RAM_SMB1_Global_UseLateStageSpriteBehaviorFlag = $0006CC
!RAM_SMB1_Level_SpriteToSpawnFromGeneratorObject = $0006CD

!RAM_SMB1_Player_CurrentPose = $0006D5

!RAM_SMB1_Level_WarpZoneActiveFlag = $0006D6

!RAM_SMB1_Player_WaitBeforeWarpingInPipe = $0006DE

; $000701 = Set when the player is turning around

!RAM_SMB1_Level_UnderwaterLevelFlag = $000704

!RAM_SMB1_Level_Player_SizeChangeAnimationFlag = $00070B

!RAM_SMB1_Player_LevelEntrancePositionIndex = $000710

!RAM_SMB1_Level_Player_IsDuckingFlag = $000714

!RAM_SMB1_Level_Player_DisableObjectInteractionFlag = $000716

!RAM_SMB1_Cutscene_ToadLineToDisplay = $000719

!RAM_SMB1_Global_CurrentLayer1XPosHi = $00071A

!RAM_SMB1_Global_CopyOfDisableSpriteOAMResetFlag = $000722
!RAM_SMB1_Level_DisableScrollingFlag = $000723

; $000727 = Index for what generic ground position to use?

!RAM_SMB1_Level_LevelDataIndex = $00072C

!RAM_SMB1_Level_SpriteListDataIndex = $000739
!RAM_SMB1_Level_InitialXposHiOfSpriteListSprite = $00073A
; $00073B = Some sort of sprite list data flag

!RAM_SMB1_Global_CurrentLayer1XPosLo = $00073F
!RAM_SMB1_Global_CurrentLayer1YPosLo = $000740

; $000742 = Index for what decorations to use?
; $000743 = Level is bonus room flag?

!RAM_SMB1_Level_FreezeSpritesTimer = $000747

!RAM_SMB1_Cutscene_ToadTextTimer = $000749

!RAM_SMB1_LevelLoad_ScratchRAM7E074F = $00074F
!RAM_SMB1_Level_SublevelIDAndTileset = $000750
!RAM_SMB1_Level_SublevelStartingScreen = $000751
!RAM_SMB1_Level_Player_TriggeredScreenExitFlag = $000752
!RAM_SMB1_Player_CurrentCharacter = $000753
!RAM_SMB1_Player_CurrentSize = $000754

!RAM_SMB1_Player_CurrentPowerUp = $000756

!RAM_SMB1_Player_VineScreenExitFlag = $000758

!RAM_SMB1_Player_CurrentLifeCount = $00075A
!RAM_SMB1_Player_CurrentStartingScreen = !RAM_SMB1_Player_CurrentLifeCount+$01
!RAM_SMB1_Player_CurrentLevelNumberDisplay = !RAM_SMB1_Player_CurrentLifeCount+$02
!RAM_SMB1_Level_CanFindHidden1upFlag = $00075D
!RAM_SMB1_Player_CurrentCoinCount = !RAM_SMB1_Player_CurrentLifeCount+$04
!RAM_SMB1_Player_CurrentWorld = !RAM_SMB1_Player_CurrentLifeCount+$05
!RAM_SMB1_Player_CurrentLevel = !RAM_SMB1_Player_CurrentLifeCount+$06
!RAM_SMB1_Player_OtherPlayersLifeCount = $000761
!RAM_SMB1_Player_OtherPlayersStartingScreen = !RAM_SMB1_Player_OtherPlayersLifeCount+$01
!RAM_SMB1_Player_OtherPlayersLevelNumberDisplay = !RAM_SMB1_Player_OtherPlayersLifeCount+$02

!RAM_SMB1_Player_OtherPlayersCoinCount = !RAM_SMB1_Player_OtherPlayersLifeCount+$04
!RAM_SMB1_Player_OtherPlayersWorld = !RAM_SMB1_Player_OtherPlayersLifeCount+$05
!RAM_SMB1_Player_OtherPlayersLevel = !RAM_SMB1_Player_OtherPlayersLifeCount+$06

!RAM_SMB1_Global_UseHardModeEnemyBehaviorFlag = $00076A

!RAM_SMB1_Global_GameMode = $000770

!RAM_SMB1_TitleScreen_CurrentState = $000772
	!RAM_SMB1_Level_CurrentState = $000772
	!RAM_SMB1_Cutscene_CurrentState = $000772
	!RAM_SMB1_GameOver_CurrentState = $000772
!RAM_SMB1_Global_StripeImageToUpload = $000773

!RAM_SMB1_Global_DisplayPauseMenuFlag = $000776

!RAM_SMB1_Level_TwoPlayerGameFlag = $00077A
	!RAM_SMB1_TitleScreen_MenuSelectionIndex = !RAM_SMB1_Level_TwoPlayerGameFlag

!RAM_SMB1_Global_GenericTimer = $000787

!RAM_SMB1_Global_RAM7E0788 = $000788

; $00078A = Timer, set to #$20 when the player jumps

!RAM_SMB1_Level_WaitBeforeDecrementingTimer = !RAM_SMB1_Global_RAM7E0788+$07		; $00078F

!RAM_SMB1_NorSpr_DecrementingTable7E0792 = !RAM_SMB1_Global_RAM7E0788+$0A

!RAM_SMB1_NorSpr_DecrementingTable7E07A2 = !RAM_SMB1_Global_RAM7E0788+$1A

!RAM_SMB1_Player_10CoinBlockGivesCoinsTimer = !RAM_SMB1_Global_RAM7E0788+$25
!RAM_SMB1_Player_HurtTimer = !RAM_SMB1_Global_RAM7E0788+$26				; $0007AE
!RAM_SMB1_Player_StarPowerTimer = !RAM_SMB1_Global_RAM7E0788+$27				; $0007AF

!RAM_SMB1_TitleScreen_WaitBeforePlayingDemo = !RAM_SMB1_Global_RAM7E0788+$2A

!RAM_SMB1_Global_RandomByte1 = $0007B7
!RAM_SMB1_Global_RandomByte2 = !RAM_SMB1_Global_RandomByte1+$01
!RAM_SMB1_Global_RandomByte3 = !RAM_SMB1_Global_RandomByte1+$02
!RAM_SMB1_Global_RandomByte4 = !RAM_SMB1_Global_RandomByte1+$03
!RAM_SMB1_Global_RandomByte5 = !RAM_SMB1_Global_RandomByte1+$04
!RAM_SMB1_Global_RandomByte6 = !RAM_SMB1_Global_RandomByte1+$05
!RAM_SMB1_Global_RandomByte7 = !RAM_SMB1_Global_RandomByte1+$06

!RAM_SMB1_Global_RNGRoutineScratchRAM07C7 = $0007C7
!RAM_SMB1_TitleScreen_TopScoreMillionsDigit = $0007C8
!RAM_SMB1_TitleScreen_TopScoreHundredThousandsDigit = !RAM_SMB1_TitleScreen_TopScoreMillionsDigit+$01
!RAM_SMB1_TitleScreen_TopScoreTenThousandsDigit = !RAM_SMB1_TitleScreen_TopScoreMillionsDigit+$02
!RAM_SMB1_TitleScreen_TopScoreThousandsDigit = !RAM_SMB1_TitleScreen_TopScoreMillionsDigit+$03
!RAM_SMB1_TitleScreen_TopScoreHundredsDigit = !RAM_SMB1_TitleScreen_TopScoreMillionsDigit+$04
!RAM_SMB1_TitleScreen_TopScoreTensDigit = !RAM_SMB1_TitleScreen_TopScoreMillionsDigit+$05
!RAM_SMB1_Player_MariosScoreMillionsDigit = $0007CE
!RAM_SMB1_Player_MariosScoreHundredThousandsDigit = !RAM_SMB1_Player_MariosScoreMillionsDigit+$01
!RAM_SMB1_Player_MariosScoreTenThousandsDigit = !RAM_SMB1_Player_MariosScoreMillionsDigit+$02
!RAM_SMB1_Player_MariosScoreThousandsDigit = !RAM_SMB1_Player_MariosScoreMillionsDigit+$03
!RAM_SMB1_Player_MariosScoreHundredsDigit = !RAM_SMB1_Player_MariosScoreMillionsDigit+$04
!RAM_SMB1_Player_MariosScoreTensDigit = !RAM_SMB1_Player_MariosScoreMillionsDigit+$05
!RAM_SMB1_Player_LuigisScoreMillionsDigit = !RAM_SMB1_Player_MariosScoreMillionsDigit+$06
!RAM_SMB1_Player_LuigisScoreHundredThousandsDigit = !RAM_SMB1_Player_LuigisScoreMillionsDigit+$01
!RAM_SMB1_Player_LuigisScoreTenThousandsDigit = !RAM_SMB1_Player_LuigisScoreMillionsDigit+$02
!RAM_SMB1_Player_LuigisScoreThousandsDigit = !RAM_SMB1_Player_LuigisScoreMillionsDigit+$03
!RAM_SMB1_Player_LuigisScoreHundredsDigit = !RAM_SMB1_Player_LuigisScoreMillionsDigit+$04
!RAM_SMB1_Player_LuigisScoreTensDigit = !RAM_SMB1_Player_LuigisScoreMillionsDigit+$05

!RAM_SMB1_Level_TimerHundreds = $0007E9
!RAM_SMB1_Level_TimerTens = !RAM_SMB1_Level_TimerHundreds+$01
!RAM_SMB1_Level_TimerOnes = !RAM_SMB1_Level_TimerHundreds+$02

!RAM_SMB1_Player_HardModeActiveFlag = $0007FC

!RAM_SMB1_Global_OAMBuffer = $000800

!RAM_Level_ContactSpr_AnimationFrame = $000B25
!RAM_Level_ContactSpr_XPosHi = $000B2A
!RAM_Level_ContactSpr_XPosLo = $000B2F
!RAM_Level_ContactSpr_YPosLo = $000B34

!RAM_SMB1_Level_SpriteOAMIndexTable = $000B45

; $000B51 = OAM index table
; $000B77 = Pause menu cursor index
!RAM_SMB1_Global_BlinkingCursorFrameCounter = $000B78
!RAM_SMB1_Cutscene_ToadHasBeenInitializedFlag = $000B9C
!RAM_SMB1_Global_OAMTileSizeBuffer = $000C00
!RAM_SMB1_ScratchRAM7E0C01 = !RAM_SMB1_Global_OAMTileSizeBuffer+$01

!RAM_SMB1_Level_LevelPreviewImageToUse = $000E21

; $000E4E = Some sort of OAM flag, set/reset during the pipe exiting animation
!RAM_SMB1_Global_EnableMosaicFadesFlag = $000E4F

!RAM_SMB1_NorSpr00C_Podoboo_AnimationFrameCounter = $000E68

!RAM_SMB1_Level_FreeMovementDebugFlag = $000E73
!RAM_SMB1_Global_PaletteAnimationFrameCounter = $000E74
!RAM_SMB1_Global_CoinPaletteAnimationFrameCounter = $000E75
!RAM_SMB1_Global_MosaicSizeAndBGEnableMirror = $000E7E
!RAM_SMB1_Global_FadeDirection = $000E7F

!RAM_SMB2U_Level_ProcessSmokeSpriteFlag = $000E9D

; $000EC0 = Something related to the position of the BG as its being loaded

!RAM_SMB1_Global_UseLuigisPlayerGraphics = $000EC2				; Optimization: Waste of RAM. Can be merged with !RAM_SMB1_Player_CurrentCharacter

!RAM_SMB1_Global_CurrentLayer2YPosLo = $000ED2
!RAM_SMB1_Global_CurrentLayer2YPosHi = $000ED3

!RAM_SMB1_Global_EnableLayer3BGFlag = $000EDC

!RAM_SMB1_Global_FixedColorData1Mirror = $000EE0
!RAM_SMB1_Global_FixedColorData2Mirror = $000EE1
!RAM_SMB1_Global_FixedColorData3Mirror = $000EE2

!RAM_SMB1_Global_CurrentLayer3XPosLo = $000EEE
!RAM_SMB1_Global_CurrentLayer3XPosHi = !RAM_SMB1_Global_CurrentLayer3XPosLo+$01

!RAM_SMB1_Global_ScanlineToTriggerIRQ = $000EF2

!RAM_SMB1_Global_CurrentLayer2XPosLo = $000EFD
!RAM_SMB1_Global_CurrentLayer2XPosHi = !RAM_SMB1_Global_CurrentLayer2XPosLo+$01

!RAM_SMB1_GameOverScreen_BlinkingCursorPos = $000F06

!RAM_SMB1_Cutscene_RustlingBagAnimationFrame = $000F7D
!RAM_SMB1_Cutscene_ToadPoppedOutOfBagFlag = $000F7E
!RAM_SMB1_Cutscene_WaitBeforeToadBreaksOutOfBag = $000F7F

!RAM_SMB1_Cutscene_PeachCloseUpAnimationFrame = $000F80

!RAM_SMB1_Cutscene_PeachCurrentState = $000F87
!RAM_SMB1_Cutscene_PeachStateTimer = $000F88

!RAM_SMB1_Player_HitboxLeftBoundary = $000F9C
!RAM_SMB1_Player_HitboxTopBoundary = !RAM_SMB1_Player_HitboxLeftBoundary+$01
!RAM_SMB1_Player_HitboxRightBoundary = $000F9E
!RAM_SMB1_Player_HitboxBottomBoundary = !RAM_SMB1_Player_HitboxRightBoundary+$01
!RAM_SMB1_NorSpr_HitboxLeftBoundary = $000FA0
!RAM_SMB1_NorSpr_HitboxTopBoundary = !RAM_SMB1_NorSpr_HitboxLeftBoundary+$01
!RAM_SMB1_NorSpr_HitboxRightBoundary = $000FA2
!RAM_SMB1_NorSpr_HitboxBottomBoundary = !RAM_SMB1_NorSpr_HitboxRightBoundary+$01

!RAM_SMB1_Global_ControllerHold1P1 = $000FF4
!RAM_SMB1_Global_ControllerHold1P2 = $000FF5
!RAM_SMB1_Global_ControllerPress1P1 = $000FF6
!RAM_SMB1_Global_ControllerPress1P2 = !RAM_SMB1_Global_ControllerPress1P1+$01
!RAM_SMB1_Global_ControllerHold2P1 = $000FF8
!RAM_SMB1_Global_ControllerHold2P2 = !RAM_SMB1_Global_ControllerHold2P1+$01
!RAM_SMB1_Global_ControllerPress2P1 = $000FFA
!RAM_SMB1_Global_ControllerPress2P2 = !RAM_SMB1_Global_ControllerPress2P1+$01
!RAM_SMB1_Global_P1CtrlDisableLo = $000FFC
!RAM_SMB1_Global_P1CtrlDisableHi = $000FFD
!RAM_SMB1_Global_P2CtrlDisableHi = $000FFE
!RAM_SMB1_Global_P2CtrlDisableLo = $000FFF
!RAM_SMB1_Global_PaletteMirror = $001000
!RAM_SMB1_Global_UpdateEntirePaletteFlag = $001200
!RAM_SMB1_Global_ScreenDisplayRegisterMirror = $001201
!RAM_SMB1_Global_HDMAEnableMirror = $001203
!RAM_SMB1_Global_BG1And2WindowMaskSettingsMirror = $001204
!RAM_SMB1_Global_BG3And4WindowMaskSettingsMirror = $001205
!RAM_SMB1_Global_ObjectAndColorWindowSettingsMirror = $001206
!RAM_SMB1_Global_MainScreenWindowMaskMirror = $001207
!RAM_SMB1_Global_SubScreenWindowMaskMirror = $001208
!RAM_SMB1_Global_ColorMathInitialSettingsMirror = $001209
!RAM_SMB1_Global_ColorMathSelectAndEnableMirror = $00120A
!RAM_SMB1_Global_MainScreenLayersMirror = $00120B
!RAM_SMB1_Global_SubScreenLayersMirror = $00120C
!RAM_SMB1_Global_BGModeAndTileSizeSettingMirror = $00120D
!RAM_SMB1_Global_Window2LeftPositionDesignationirror = $00120E
!RAM_SMB1_Global_Window2RightPositionDesignationMirror = $00120F

; $001300-$001304 = Something level data related. Causes objects to increase in size horizontally or not spawn

!RAM_SMB1_Global_HDMAGradientRedChannelData = $001400
!RAM_SMB1_Global_HDMAGradientGreenChannelData = $001460
!RAM_SMB1_Global_HDMAGradientBlueChannelData = $0014C0
!RAM_SMB1_Global_HDMAGradientRedChannelScanlinesAndPtrsTable = $001520
!RAM_SMB1_Global_HDMAGradientGreenChannelScanlinesAndPtrsTable = $001560
!RAM_SMB1_Global_HDMAGradientBlueChannelScanlinesAndPtrsTable = $0015A0

!RAM_SMB1_Global_FrameAdvanceDebugActiveFlag = $0015E5

!RAM_SMB1_Global_SoundCh1 = $001600
!RAM_SMB1_Global_SoundCh2 = !RAM_SMB1_Global_SoundCh1+$01
!RAM_SMB1_Global_MusicCh1 = !RAM_SMB1_Global_SoundCh1+$02
!RAM_SMB1_Global_SoundCh3 = !RAM_SMB1_Global_SoundCh1+$03
!RAM_SMB1_Global_StripeImageUploadIndexLo = $001700
!RAM_SMB1_Global_StripeImageUploadIndexHi = !RAM_SMB1_Global_StripeImageUploadIndexLo+$01
!RAM_SMB1_Global_StripeImageUploadTable = !RAM_SMB1_Global_StripeImageUploadIndexLo+$02

!RAM_SMB1_Global_Layer2Map16Table = $7E2000

!RAM_SMB1_Global_Layer2BGData = $7ED000

; $7F0002 = Layer 2 tilemap VRAM address
; $7F0004 = Layer 2 tilemap buffer
; $7F2002 = Layer 3 tilemap VRAM address
; $7F2004 = Layer 3 tilemap buffer

!RAM_SMB1_Global_SaveBuffer = $7FFB00
	!RAM_SMB1_Global_SaveBuffer_CurrentWorld = !RAM_SMB1_Global_SaveBuffer+$00
	!RAM_SMB1_Global_SaveBuffer_CurrentLevel = !RAM_SMB1_Global_SaveBuffer+$01
	!RAM_SMB1_Global_SaveBuffer_CurrentLifeCount = !RAM_SMB1_Global_SaveBuffer+$03
	!RAM_SMB1_Global_SaveBuffer_OtherPlayersLifeCount = !RAM_SMB1_Global_SaveBuffer+$04
	!RAM_SMB1_Global_SaveBuffer_HardModeActiveFlag = !RAM_SMB1_Global_SaveBuffer+$05
	!RAM_SMB1_Global_SaveBuffer_2PlayerFlag = !RAM_SMB1_Global_SaveBuffer+$06
	!RAM_SMB1_Global_SaveBuffer_ChecksumLo = !RAM_SMB1_Global_SaveBuffer+$07
	!RAM_SMB1_Global_SaveBuffer_ChecksumHi = !RAM_SMB1_Global_SaveBuffer_ChecksumLo+$01

struct SMB1_OAMBuffer !RAM_SMB1_Global_OAMBuffer
	.XDisp: skip $01
	.YDisp: skip $01
	.Tile: skip $01
	.Prop: skip $01
endstruct align $04

struct SMB1_UpperOAMBuffer !RAM_SMB1_Global_OAMBuffer+$0200
	.Slot: skip $01
endstruct align $01

struct SMB1_OAMTileSizeBuffer !RAM_SMB1_Global_OAMTileSizeBuffer
	.Slot: skip $04
endstruct align $04

struct SMB1_PaletteMirror !RAM_SMB1_Global_PaletteMirror
	.LowByte: skip $01
	.HighByte: skip $01
endstruct align $02

struct SMB1_StripeImageUploadTable !RAM_SMB1_Global_StripeImageUploadTable
	.LowByte: skip $01
	.HighByte: skip $01
endstruct align $02

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr007_Blooper_DescendTimer = !RAM_SMB1_NorSpr_DecrementingTable7E07A2

;---------------------------------------------------------------------------

!RAM_SMB3_NorSpr00C_Podoboo_WaitBeforeJumpingTimer = !RAM_SMB1_NorSpr_DecrementingTable7E07A2

;---------------------------------------------------------------------------

!RAM_SMB1_NorSpr02D_Bowser_WaitBeforeNextJump = !RAM_SMB1_NorSpr_DecrementingTable7E0792

;---------------------------------------------------------------------------

!RAM_SMB1_NorSpr02E_Powerup_PowerupType = !RAM_SMB1_NorSpr_Table7E0203+$09

;---------------------------------------------------------------------------

;Standalone ROM specific RAM addresses
!RAM_SMB1_TitleScreen_EraseFileProcess = $000051
!RAM_SMB1_SplashScreen_DisplayTimer = $000052
	!RAM_SMB1_TitleScreen_FileAMaxWorld = $000052
!RAM_SMB1_SplashScreen_PaletteAnimationTimer = $000053
	!RAM_SMB1_TitleScreen_FileBMaxWorld = !RAM_SMB1_TitleScreen_FileAMaxWorld+$01
!RAM_SMB1_SplashScreen_PaletteAnimationIndex =  !RAM_SMB1_SplashScreen_PaletteAnimationTimer+$01
	!RAM_SMB1_TitleScreen_FileCMaxWorld = !RAM_SMB1_TitleScreen_FileAMaxWorld+$02
!RAM_SMB1_SplashScreen_DisplayMarioCoinShineFlag = $000055
	!RAM_SMB1_TitleScreen_FileSelectProcess = $000055
!RAM_SMB1_TitleScreen_FileASelectedWorld = $000056
!RAM_SMB1_TitleScreen_FileBSelectedWorld = !RAM_SMB1_TitleScreen_FileASelectedWorld+$01
!RAM_SMB1_TitleScreen_FileCSelectedWorld = !RAM_SMB1_TitleScreen_FileASelectedWorld+$02
!RAM_SMB1_ErrorScreen_PaletteMirror = $000200						; Note: This must be set to $000200 or else problems may occur
!RAM_SMB1_ErrorScreen_TextTilemap = $000800

struct SMB1_ErrorScreen_TextTilemap !RAM_SMB1_ErrorScreen_TextTilemap
	.Row: skip $40
endstruct

struct SMB1_ErrorScreen_PaletteMirror !RAM_SMB1_ErrorScreen_PaletteMirror
	.LowByte: skip $01
	.HighByte: skip $01
endstruct align $02
