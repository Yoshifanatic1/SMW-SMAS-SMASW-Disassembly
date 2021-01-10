; Note: This file contains all the defines that aren't for the different kinds of RAM.
; Note: SMAS has all the sound effects used in SMW. The names for those sound effects will be the same as the ones in SMW for consistency.

!Define_SMB2U_MaxNormalSpriteSlot = $08

if !Define_Global_ROMToAssemble&(!ROM_SMB2U_U|!ROM_SMB2U_E|!ROM_SMB2U_J) != $00
!Define_SMAS_Sound0060_HitHead = $01
!Define_SMAS_Sound0060_Contact = $02
!Define_SMAS_Sound0060_KickShell = $03
!Define_SMAS_Sound0060_IntoPipe = $04
!Define_SMAS_Sound0060_MidwayPoint = $05

!Define_SMAS_Sound0060_DryBonesCollapse = $07
!Define_SMAS_Sound0060_EchoSpinJumpKill = $08
!Define_SMAS_Sound0060_FlyWithCape = $09
!Define_SMAS_Sound0060_GetPowerup = $0A
!Define_SMAS_Sound0060_ONOFFSwitch = $0B
!Define_SMAS_Sound0060_CarryItemToGoal = $0C
!Define_SMAS_Sound0060_GetCape = $0D
!Define_SMAS_Sound0060_Swim = $0E
!Define_SMAS_Sound0060_HurtWhileFlying = $0F
!Define_SMAS_Sound0060_MagicShoot = $10
!Define_SMAS_Sound0060_TurnOffMusic = $11
!Define_SMAS_Sound0060_ResumeMusic = $12
!Define_SMAS_Sound0060_Stomp1 = $13
!Define_SMAS_Sound0060_Stomp2 = $14
!Define_SMAS_Sound0060_Stomp3 = $15
!Define_SMAS_Sound0060_Stomp4 = $16
!Define_SMAS_Sound0060_Stomp5 = $17
!Define_SMAS_Sound0060_Stomp6 = $18
!Define_SMAS_Sound0060_Stomp7 = $19
!Define_SMAS_Sound0060_Stomp8 = $1A
!Define_SMAS_Sound0060_Grinder = $1B
!Define_SMAS_Sound0060_YoshiCoin = $1C
!Define_SMAS_Sound0060_RunningOutOfTime = $1D
!Define_SMAS_Sound0060_PBalloon = $1E
!Define_SMAS_Sound0060_KoopalingDead = $1F
!Define_SMAS_Sound0060_YoshiSpit = $20
!Define_SMAS_Sound0060_ValleyOfBowserAppears = $21
!Define_SMAS_Sound0060_EndValleyOfBowserAppears = $22
!Define_SMAS_Sound0060_FallIntoSubcon = $23

!Define_SMAS_Sound0060_BlarggRoar = $25
!Define_SMAS_Sound0060_FireworksWhistle = $26
!Define_SMAS_Sound0060_FireworksBang = $27
!Define_SMAS_Sound0060_LouderFireworksWhistle = $28
!Define_SMAS_Sound0060_LouderFireworksBang = $29
!Define_SMAS_Sound0060_PeachPoppingOutOfClownCar = $2A
!Define_SMAS_Sound0060_SMB2UPickupItem = $2B
!Define_SMAS_Sound0060_HawkmouthOpen = $2C
!Define_SMAS_Sound0060_HawkmouthClose = $2D
!Define_SMAS_Sound0060_PhantoRumble = $2E
!Define_SMAS_Sound0060_StopwatchTick = $2F
!Define_SMAS_Sound0060_ClimbVine = $30
!Define_SMAS_Sound0060_SMB2UThrow = $31
!Define_SMAS_Sound0060_UnknownSound00 = $32
!Define_SMAS_Sound0060_SMB2UHurt = $33
!Define_SMAS_Sound0060_SMB2UKillEnemy = $34
!Define_SMAS_Sound0060_GotItemTweet = $35
!Define_SMAS_Sound0060_HammerBroMarch = $36
!Define_SMAS_Sound0060_EnemyProjectileThrow = $37
!Define_SMAS_Sound0060_WandDrop = $38
!Define_SMAS_Sound0060_PeachDoorOpen = $39
!Define_SMAS_Sound0060_BowserBreathFire = $3A
!Define_SMAS_Sound0060_SaveGame = $3B
!Define_SMAS_Sound0060_ChooseCharacter = $3C
!Define_SMAS_Sound0060_UnknownSound01 = $3D
!Define_SMAS_Sound0060_RandomChatter = $3E
!Define_SMAS_Sound0060_UnknownSound02 = $3F
!Define_SMAS_Sound0060_FrogHop = $40
!Define_SMAS_Sound0060_SelectCard = $41
!Define_SMAS_Sound0060_StepOnLevelTile = $42
!Define_SMAS_Sound0060_Pause1 = $43
!Define_SMAS_Sound0060_Pause2 = $44
!Define_SMAS_Sound0060_Thunder = $45
!Define_SMAS_Sound0060_GrabFlagpole = $46
!Define_SMAS_Sound0060_DoubleYoshiCoinSound = $47
!Define_SMAS_Sound0060_IncreaseMusicTempo = $FF

!Define_SMAS_Sound0061_Jump = $01

!Define_SMAS_Sound0061_TurnAround = $04
!Define_SMAS_Sound0061_TurnOnWind = $10
!Define_SMAS_Sound0061_TurnOffWind = $20

!Define_SMAS_Sound0063_Coin = $01
!Define_SMAS_Sound0063_HitItemBlock = $02
!Define_SMAS_Sound0063_HitVineBlock = $03
!Define_SMAS_Sound0063_SpinJump = $04
!Define_SMAS_Sound0063_1up = $05
!Define_SMAS_Sound0063_ShootFireball = $06
!Define_SMAS_Sound0063_BreakBlock = $07
!Define_SMAS_Sound0063_Springboard = $08
!Define_SMAS_Sound0063_BulletShoot = $09
!Define_SMAS_Sound0063_EggHatch = $0A
!Define_SMAS_Sound0063_PutItemInReserve = $0B
!Define_SMAS_Sound0063_DropItemInReserve1 = $0C
!Define_SMAS_Sound0063_DropItemInReserve2 = $0D
!Define_SMAS_Sound0063_LRScroll = $0E
!Define_SMAS_Sound0063_Door1 = $0F
!Define_SMAS_Sound0063_Door2 = $10
!Define_SMAS_Sound0063_DrumrollStart = $11
!Define_SMAS_Sound0063_DrumrollEnd = $12

!Define_SMAS_Sound0063_BooAppears = $14
!Define_SMAS_Sound0063_OverworldTileReveal = $15
!Define_SMAS_Sound0063_CastleCollapse = $16
!Define_SMAS_Sound0063_FireSpit = $17
!Define_SMAS_Sound0063_Thunder = $18
!Define_SMAS_Sound0063_Clap = $19
!Define_SMAS_Sound0063_Explosion = $1A
!Define_SMAS_Sound0063_TNTFuse = $1B
!Define_SMAS_Sound0063_OverworldSwitchBlockEjection = $1C
!Define_SMAS_Sound0063_RunningOutOfTime = $1D
!Define_SMAS_Sound0063_ChuckWhistle = $1E
!Define_SMAS_Sound0063_MountYoshi = $1F
!Define_SMAS_Sound0063_LemmyWendyLandInLava = $20
!Define_SMAS_Sound0063_YoshiTongue = $21
!Define_SMAS_Sound0063_MessageBox = $22
!Define_SMAS_Sound0063_StepOnLevelTile = $23
!Define_SMAS_Sound0063_PSwitchRunningOut = $24
!Define_SMAS_Sound0063_YoshiStompsEnemy = $25
!Define_SMAS_Sound0063_Swooper = $26
!Define_SMAS_Sound0063_Podoboo = $27
!Define_SMAS_Sound0063_StunEnemy = $28
!Define_SMAS_Sound0063_Correct = $29
!Define_SMAS_Sound0063_Wrong = !Define_SMAS_Sound0063_Correct+$01

!Define_SMAS_Sound0063_FireworksBang = $2C
!Define_SMAS_Sound0063_ChargeJump = $2D
!Define_SMAS_Sound0063_PodobooPan2 = $2E
!Define_SMAS_Sound0063_PodobooPan3 = $2F
!Define_SMAS_Sound0063_PodobooPan4 = $30
!Define_SMAS_Sound0063_PodobooPan5 = $31
!Define_SMAS_Sound0063_PodobooPan6 = $32
!Define_SMAS_Sound0063_PodobooPan7 = $33
!Define_SMAS_Sound0063_PodobooPan8 = $34
!Define_SMAS_Sound0063_Rumble = $35
!Define_SMAS_Sound0063_OpenBox1 = $36
!Define_SMAS_Sound0063_UnknownSound00 = $37
!Define_SMAS_Sound0063_RisingItem = $38
!Define_SMAS_Sound0063_GotItemTweet = $39
!Define_SMAS_Sound0063_GrabMysteryMushroom = $3A
!Define_SMAS_Sound0063_CollectCherry = $3B
!Define_SMAS_Sound0063_SMB2UPickupItem = $3C
!Define_SMAS_Sound0063_UnknownSound01 = $3D
!Define_SMAS_Sound0063_OpenBox2 = $3E
!Define_SMAS_Sound0063_ToggleFileWindow = $3F
!Define_SMAS_Sound0063_SMASMenuFadeOut = $40
!Define_SMAS_Sound0063_SMASMenuFadeIn = $41
!Define_SMAS_Sound0063_PhantoDroning = $42
!Define_SMAS_Sound0063_EnterLevel = $43
!Define_SMAS_Sound0063_UnknownSound02 = $44
!Define_SMAS_Sound0063_RocketTakeoff = $45
!Define_SMAS_Sound0063_WartRoar = $46
!Define_SMAS_Sound0063_BossDefeat = $47
!Define_SMAS_Sound0063_Boomerang = $48
!Define_SMAS_Sound0063_WhaleSpout = $49
!Define_SMAS_Sound0063_CannonShoot = $4A
!Define_SMAS_Sound0063_AddTimerToScore = $4B
!Define_SMAS_Sound0063_FinishAddTimerToScore = $4C
!Define_SMAS_Sound0063_EnterVase = $4D
!Define_SMAS_Sound0063_ExitVase = $4E
endif

!Define_SMB2U_LevelMusic_Overworld = $01
!Define_SMB2U_LevelMusic_CharacterSelect = $04
!Define_SMB2U_LevelMusic_Subspace = $05
!Define_SMB2U_LevelMusic_Underground = $06
!Define_SMB2U_LevelMusic_WartBattle = $07
!Define_SMB2U_LevelMusic_Danger = $08
!Define_SMB2U_LevelMusic_Death = $09
!Define_SMB2U_LevelMusic_GameOver = $0A
!Define_SMB2U_LevelMusic_WorldClear = $0B
!Define_SMB2U_LevelMusic_Fanfare1 = $0C
!Define_SMB2U_LevelMusic_HaveStar = $0D
!Define_SMB2U_LevelMusic_Ending = $0E
!Define_SMB2U_LevelMusic_Fanfare2 = $0F
!Define_SMB2U_LevelMusic_WonSlots = $10
!Define_SMB2U_LevelMusic_TitleScreen = $11
!Define_SMB2U_LevelMusic_UnknownFanfare = $12
!Define_SMB2U_LevelMusic_WarpZone = $13
!Define_SMB2U_LevelMusic_MusicFade = $80
!Define_SMB2U_LevelMusic_StopMusicCommand = $F0
!Define_SMB2U_LevelMusic_LowerVolumeCommand = $F1
!Define_SMB2U_LevelMusic_RestoreVolumeCommand = $F2
!Define_SMB2U_LevelMusic_CopyOfMusicFade = $F3

!Define_SMB2U_SpriteID_NorSpr00_RecoveryHeart = $00
!Define_SMB2U_SpriteID_NorSpr01_RedShyGuy = $01
!Define_SMB2U_SpriteID_NorSpr02_Tweeter = $02
!Define_SMB2U_SpriteID_NorSpr03_BlueShyGuy = $03
!Define_SMB2U_SpriteID_NorSpr04_Porcupo = $04
!Define_SMB2U_SpriteID_NorSpr05_RedSnifit = $05
!Define_SMB2U_SpriteID_NorSpr06_GreySnifit = $06
!Define_SMB2U_SpriteID_NorSpr07_BlueSnifit = $07
!Define_SMB2U_SpriteID_NorSpr08_Ostro = $08
!Define_SMB2U_SpriteID_NorSpr09_BobOmb = $09
!Define_SMB2U_SpriteID_NorSpr0A_AlbatossCarryingBobomb = $0A
!Define_SMB2U_SpriteID_NorSpr0B_RightFlyingAlbatoss = $0B
!Define_SMB2U_SpriteID_NorSpr0C_LeftFlyingAlbatoss = $0C
!Define_SMB2U_SpriteID_NorSpr0D_FollowingNinji = $0D
!Define_SMB2U_SpriteID_NorSpr0E_JumpingNinji = $0E
!Define_SMB2U_SpriteID_NorSpr0F_YellowBeezo = $0F
!Define_SMB2U_SpriteID_NorSpr10_RedBeezo = $10
!Define_SMB2U_SpriteID_NorSpr11_WartBubble = $11
!Define_SMB2U_SpriteID_NorSpr12_Pidgit = $12
!Define_SMB2U_SpriteID_NorSpr13_Trouter = $13
!Define_SMB2U_SpriteID_NorSpr14_Hoopster = $14
!Define_SMB2U_SpriteID_NorSpr15_VaseRedShyGuySpawner = $15
!Define_SMB2U_SpriteID_NorSpr16_VaseBobOmbSpawner = $16
!Define_SMB2U_SpriteID_NorSpr17_Phanto = $17
!Define_SMB2U_SpriteID_NorSpr18_VaseDwellingCobrat = $18
!Define_SMB2U_SpriteID_NorSpr19_GroundDwellingCobrat = $19
!Define_SMB2U_SpriteID_NorSpr1A_Pokey = $1A
!Define_SMB2U_SpriteID_NorSpr1B_Bullet = $1B
!Define_SMB2U_SpriteID_NorSpr1C_Birdo = $1C
!Define_SMB2U_SpriteID_NorSpr1D_Mouser = $1D
!Define_SMB2U_SpriteID_NorSpr1E_BirdoEgg = $1E
!Define_SMB2U_SpriteID_NorSpr1F_Tryclyde = $1F
!Define_SMB2U_SpriteID_NorSpr20_Fireball = $20
!Define_SMB2U_SpriteID_NorSpr21_Clawgrip = $21
!Define_SMB2U_SpriteID_NorSpr22_ClawgripRock = $22
!Define_SMB2U_SpriteID_NorSpr23_RedPanser = $23
!Define_SMB2U_SpriteID_NorSpr24_BluePanser = $24
!Define_SMB2U_SpriteID_NorSpr25_GreenPanser = $25
!Define_SMB2U_SpriteID_NorSpr26_Autobomb = $26
!Define_SMB2U_SpriteID_NorSpr27_AutombombFireball = $27
!Define_SMB2U_SpriteID_NorSpr28_WaterSpout = $28
!Define_SMB2U_SpriteID_NorSpr29_Flurry = $29
!Define_SMB2U_SpriteID_NorSpr2A_Fryguy = $2A
!Define_SMB2U_SpriteID_NorSpr2B_MiniFryGuy = $2B
!Define_SMB2U_SpriteID_NorSpr2C_Wart = $2C
!Define_SMB2U_SpriteID_NorSpr2D_HawkmouthBoss = $2D
!Define_SMB2U_SpriteID_NorSpr2E_SlowCounterclockwiseSpark = $2E
!Define_SMB2U_SpriteID_NorSpr2F_FastCounterclockwiseSpark = $2F
!Define_SMB2U_SpriteID_NorSpr30_SlowClockwiseSpark = $30
!Define_SMB2U_SpriteID_NorSpr31_FastClockwiseSpark = $31
!Define_SMB2U_SpriteID_NorSpr32_SmallVeggie = $32
!Define_SMB2U_SpriteID_NorSpr33_LargeVeggie = $33
!Define_SMB2U_SpriteID_NorSpr34_UnusedSprite = $34
!Define_SMB2U_SpriteID_NorSpr35_KoopaShell = $35
!Define_SMB2U_SpriteID_NorSpr36_Coin = $36
!Define_SMB2U_SpriteID_NorSpr37_PurpleBomb = $37
!Define_SMB2U_SpriteID_NorSpr38_RocketShip = $38
!Define_SMB2U_SpriteID_NorSpr39_MushroomBlock = $39
!Define_SMB2U_SpriteID_NorSpr3A_POWBlock = $3A
!Define_SMB2U_SpriteID_NorSpr3B_FallingLog = $3B
!Define_SMB2U_SpriteID_NorSpr3C_Door = $3C
!Define_SMB2U_SpriteID_NorSpr3D_Key = $3D
!Define_SMB2U_SpriteID_NorSpr3E_Potion = $3E
!Define_SMB2U_SpriteID_NorSpr3F_Mushroom = $3F
!Define_SMB2U_SpriteID_NorSpr40_1Up = $40
!Define_SMB2U_SpriteID_NorSpr41_MagicCarpet = $41
!Define_SMB2U_SpriteID_NorSpr42_RightFacingHawkmouth = $42
!Define_SMB2U_SpriteID_NorSpr43_LeftFacingHawkmouth = $43
!Define_SMB2U_SpriteID_NorSpr44_Crystal = $44
!Define_SMB2U_SpriteID_NorSpr45_Star = $45
!Define_SMB2U_SpriteID_NorSpr46_Stopwatch = $46
!Define_SMB2U_SpriteID_NorSpr47_AlbatossGenerator = $47
!Define_SMB2U_SpriteID_NorSpr48_YellowBeezoGenerator = $48
!Define_SMB2U_SpriteID_NorSpr49_TurnOffGenerators = $49
!Define_SMB2U_SpriteID_NorSpr4A_VeggieGenerator = $4A

!Define_SMB2U_NorSprStatus00_EmptySlot = $00
!Define_SMB2U_NorSprStatus01_Normal = $01
!Define_SMB2U_NorSprStatus02_Dead = $02
!Define_SMB2U_NorSprStatus03_DrawCrumblingRock = $03
!Define_SMB2U_NorSprStatus04_Explosion = $04
!Define_SMB2U_NorSprStatus05_SmokePuff = $05
!Define_SMB2U_NorSprStatus06_DrawDugUpSand = $06
!Define_SMB2U_NorSprStatus07_SinkInQuicksand = $07
!Define_SMB2U_NorSprStatus08_DrawPOWBlockSmoke = $08
!Define_SMB2U_NorSprStatus09_DrawDeadMiniFryguy = $09

!Define_SMB2U_PlayerState00_Normal = $00
!Define_SMB2U_PlayerState01_Climbing = $01
!Define_SMB2U_PlayerState02_PickupSomething = $02
!Define_SMB2U_PlayerState03_ClimbingScreenExit = $03
!Define_SMB2U_PlayerState04_EnterVase = $04
!Define_SMB2U_PlayerState05_ExitVase = $05
!Define_SMB2U_PlayerState06_InHawkmouth = $06
!Define_SMB2U_PlayerState07_Dead = $07
!Define_SMB2U_PlayerState08_HasBeenHurt = $08

!Define_SMB2U_SublevelID_X_X_LevelEntrance = $00
!Define_SMB2U_SublevelID_X_X_GenericVase = $04

!Define_SMB2U_LevelID_1_1 = $00
	!Define_SMB2U_SublevelID_1_1_LevelEntrance = !Define_SMB2U_SublevelID_X_X_LevelEntrance
	!Define_SMB2U_SublevelID_1_1_AscentToBirdo = $01
	!Define_SMB2U_SublevelID_1_1_Plains = $02
	!Define_SMB2U_SublevelID_1_1_CaveUpperFloor = $03
	!Define_SMB2U_SublevelID_1_1_CaveLowerFloor = $04
	!Define_SMB2U_SublevelID_1_1_BirdosRoom = $05
	!Define_SMB2U_SublevelID_1_1_Sub06 = $06
	!Define_SMB2U_SublevelID_1_1_Sub07 = $07
	!Define_SMB2U_SublevelID_1_1_Sub08 = $08
	!Define_SMB2U_SublevelID_1_1_Sub09 = $09
!Define_SMB2U_LevelID_1_2 = $01
	!Define_SMB2U_SublevelID_1_2_LevelEntrance = !Define_SMB2U_SublevelID_X_X_LevelEntrance
	!Define_SMB2U_SublevelID_1_2_Cave = $01
	!Define_SMB2U_SublevelID_1_2_BirdosRoom = $02
	!Define_SMB2U_SublevelID_1_2_VaseWithPhanto = $03
	!Define_SMB2U_SublevelID_1_2_VaseWith1up = $04
	!Define_SMB2U_SublevelID_1_2_Sub05 = $05
	!Define_SMB2U_SublevelID_1_2_Sub06 = $06
	!Define_SMB2U_SublevelID_1_2_Sub07 = $07
	!Define_SMB2U_SublevelID_1_2_Sub08 = $08
	!Define_SMB2U_SublevelID_1_2_Sub09 = $09
!Define_SMB2U_LevelID_1_3 = $02
	!Define_SMB2U_SublevelID_1_3_LevelEntrance = !Define_SMB2U_SublevelID_X_X_LevelEntrance
	!Define_SMB2U_SublevelID_1_3_PhantoRoom = $01
	!Define_SMB2U_SublevelID_1_3_TowerVerticalShaft = $02
	!Define_SMB2U_SublevelID_1_3_TowerBasement = $03
	!Define_SMB2U_SublevelID_1_3_MousersRoom = $04
	!Define_SMB2U_SublevelID_1_3_Sub05 = $05
	!Define_SMB2U_SublevelID_1_3_Sub06 = $06
	!Define_SMB2U_SublevelID_1_3_Sub07 = $07
	!Define_SMB2U_SublevelID_1_3_Sub08 = $08
	!Define_SMB2U_SublevelID_1_3_Sub09 = $09
!Define_SMB2U_LevelID_2_1 = $03
	!Define_SMB2U_SublevelID_2_1_LevelEntrance = !Define_SMB2U_SublevelID_X_X_LevelEntrance
	!Define_SMB2U_SublevelID_2_1_SandyPyramidInterior = $01
	!Define_SMB2U_SublevelID_2_1_BirdosRoom = $02
	!Define_SMB2U_SublevelID_2_1_Sub03 = $03
	!Define_SMB2U_SublevelID_2_1_GenericVase = $04
	!Define_SMB2U_SublevelID_2_1_Sub05 = $05
	!Define_SMB2U_SublevelID_2_1_Sub06 = $06
	!Define_SMB2U_SublevelID_2_1_Sub07 = $07
	!Define_SMB2U_SublevelID_2_1_Sub08 = $08
	!Define_SMB2U_SublevelID_2_1_Sub09 = $09
!Define_SMB2U_LevelID_2_2 = $04
	!Define_SMB2U_SublevelID_2_2_LevelEntrance = !Define_SMB2U_SublevelID_X_X_LevelEntrance
	!Define_SMB2U_SublevelID_2_2_AboveGround = $01
	!Define_SMB2U_SublevelID_2_2_PotionCave = $02
	!Define_SMB2U_SublevelID_2_2_SandCave = $03
	!Define_SMB2U_SublevelID_2_2_GenericVase = $04
	!Define_SMB2U_SublevelID_2_2_BirdosRoom = $05
	!Define_SMB2U_SublevelID_2_2_Sub06 = $06
	!Define_SMB2U_SublevelID_2_2_Sub07 = $07
	!Define_SMB2U_SublevelID_2_2_Sub08 = $08
	!Define_SMB2U_SublevelID_2_2_Sub09 = $09
!Define_SMB2U_LevelID_2_3 = $05
	!Define_SMB2U_SublevelID_2_3_LevelEntrance = !Define_SMB2U_SublevelID_X_X_LevelEntrance
	!Define_SMB2U_SublevelID_2_3_Outdoors = $01
	!Define_SMB2U_SublevelID_2_3_SmallCave = $02
	!Define_SMB2U_SublevelID_2_3_PyramidShaft = $03
	!Define_SMB2U_SublevelID_2_3_GenericVase = $04
	!Define_SMB2U_SublevelID_2_3_PyramidHallway = $05
	!Define_SMB2U_SublevelID_2_3_TryclydesRoom = $06
	!Define_SMB2U_SublevelID_2_3_PhantoRoom = $07
	!Define_SMB2U_SublevelID_2_3_Sub08 = $08
	!Define_SMB2U_SublevelID_2_3_Sub09 = $09
!Define_SMB2U_LevelID_3_1 = $06
	!Define_SMB2U_SublevelID_3_1_LevelEntrance = !Define_SMB2U_SublevelID_X_X_LevelEntrance
	!Define_SMB2U_SublevelID_3_1_WaterfallCliff = $01
	!Define_SMB2U_SublevelID_3_1_WaterfallBaseCave = $02
	!Define_SMB2U_SublevelID_3_1_SkyCliff = $03
	!Define_SMB2U_SublevelID_3_1_BirdosRoom = $04
	!Define_SMB2U_SublevelID_3_1_Sub05 = $05
	!Define_SMB2U_SublevelID_3_1_Sub06 = $06
	!Define_SMB2U_SublevelID_3_1_Sub07 = $07
	!Define_SMB2U_SublevelID_3_1_Sub08 = $08
	!Define_SMB2U_SublevelID_3_1_Sub09 = $09
!Define_SMB2U_LevelID_3_2 = $07
	!Define_SMB2U_SublevelID_3_2_LevelEntrance = !Define_SMB2U_SublevelID_X_X_LevelEntrance
	!Define_SMB2U_SublevelID_3_2_Cave = $01
	!Define_SMB2U_SublevelID_3_2_BirdosRoom = $02
	!Define_SMB2U_SublevelID_3_2_Sub03 = $03
	!Define_SMB2U_SublevelID_3_2_Sub04 = $04
	!Define_SMB2U_SublevelID_3_2_Sub05 = $05
	!Define_SMB2U_SublevelID_3_2_Sub06 = $06
	!Define_SMB2U_SublevelID_3_2_Sub07 = $07
	!Define_SMB2U_SublevelID_3_2_Sub08 = $08
	!Define_SMB2U_SublevelID_3_2_Sub09 = $09
!Define_SMB2U_LevelID_3_3 = $08
	!Define_SMB2U_SublevelID_3_3_LevelEntrance = !Define_SMB2U_SublevelID_X_X_LevelEntrance
	!Define_SMB2U_SublevelID_3_3_PathToFortress = $01
	!Define_SMB2U_SublevelID_3_3_FortressEntryway = $02
	!Define_SMB2U_SublevelID_3_3_LeftTower = $03
	!Define_SMB2U_SublevelID_3_3_MiddleTower = $04
	!Define_SMB2U_SublevelID_3_3_RightTower = $05
	!Define_SMB2U_SublevelID_3_3_PhantoRoom = $06
	!Define_SMB2U_SublevelID_3_3_FortressRoof = $07
	!Define_SMB2U_SublevelID_3_3_MousersRoom = $08
	!Define_SMB2U_SublevelID_3_3_Sub09 = $09
!Define_SMB2U_LevelID_4_1 = $09
	!Define_SMB2U_SublevelID_4_1_LevelEntrance = !Define_SMB2U_SublevelID_X_X_LevelEntrance
	!Define_SMB2U_SublevelID_4_1_AutobombWarPath = $01
	!Define_SMB2U_SublevelID_4_1_Sub02 = $02
	!Define_SMB2U_SublevelID_4_1_Sub03 = $03
	!Define_SMB2U_SublevelID_4_1_Sub04 = $04
	!Define_SMB2U_SublevelID_4_1_Sub05 = $05
	!Define_SMB2U_SublevelID_4_1_Sub06 = $06
	!Define_SMB2U_SublevelID_4_1_Sub07 = $07
	!Define_SMB2U_SublevelID_4_1_Sub08 = $08
	!Define_SMB2U_SublevelID_4_1_Sub09 = $09
!Define_SMB2U_LevelID_4_2 = $0A
	!Define_SMB2U_SublevelID_4_2_LevelEntrance = !Define_SMB2U_SublevelID_X_X_LevelEntrance
	!Define_SMB2U_SublevelID_4_2_BeezoRoom = $01
	!Define_SMB2U_SublevelID_4_2_WhaleRoom = $02
	!Define_SMB2U_SublevelID_4_2_SpikeCorridor = $03
	!Define_SMB2U_SublevelID_4_2_BirdosRoom = $04
	!Define_SMB2U_SublevelID_4_2_Sub05 = $05
	!Define_SMB2U_SublevelID_4_2_Sub06 = $06
	!Define_SMB2U_SublevelID_4_2_Sub07 = $07
	!Define_SMB2U_SublevelID_4_2_Sub08 = $08
	!Define_SMB2U_SublevelID_4_2_Sub09 = $09
!Define_SMB2U_LevelID_4_3 = $0B
	!Define_SMB2U_SublevelID_4_3_LevelEntrance = !Define_SMB2U_SublevelID_X_X_LevelEntrance
	!Define_SMB2U_SublevelID_4_3_ColdLake = $01
	!Define_SMB2U_SublevelID_4_3_LeftTower = $02
	!Define_SMB2U_SublevelID_4_3_RightTower = $03
	!Define_SMB2U_SublevelID_4_3_TowerRoof = $04
	!Define_SMB2U_SublevelID_4_3_PhantoRoom = $05
	!Define_SMB2U_SublevelID_4_3_EntryToFryguysRoom = $06
	!Define_SMB2U_SublevelID_4_3_FryguysRoom = $07
	!Define_SMB2U_SublevelID_4_3_Sub08 = $08
	!Define_SMB2U_SublevelID_4_3_Sub09 = $09
!Define_SMB2U_LevelID_5_1 = $0C
	!Define_SMB2U_SublevelID_5_1_LevelEntrance = !Define_SMB2U_SublevelID_X_X_LevelEntrance
	!Define_SMB2U_SublevelID_5_1_WaterfallCave = $01
	!Define_SMB2U_SublevelID_5_1_BirdosRoom = $02
	!Define_SMB2U_SublevelID_5_1_Sub03 = $03
	!Define_SMB2U_SublevelID_5_1_Sub04 = $04
	!Define_SMB2U_SublevelID_5_1_Sub05 = $05
	!Define_SMB2U_SublevelID_5_1_Sub06 = $06
	!Define_SMB2U_SublevelID_5_1_Sub07 = $07
	!Define_SMB2U_SublevelID_5_1_Sub08 = $08
	!Define_SMB2U_SublevelID_5_1_Sub09 = $09
!Define_SMB2U_LevelID_5_2 = $0D
	!Define_SMB2U_SublevelID_5_2_LevelEntrance = !Define_SMB2U_SublevelID_X_X_LevelEntrance
	!Define_SMB2U_SublevelID_5_2_NightPlain = $01
	!Define_SMB2U_SublevelID_5_2_Cliff = $02
	!Define_SMB2U_SublevelID_5_2_POWBlockShaft = $03
	!Define_SMB2U_SublevelID_5_2_Vase = $04
	!Define_SMB2U_SublevelID_5_2_BirdosRoom = $05
	!Define_SMB2U_SublevelID_5_2_Sub06 = $06
	!Define_SMB2U_SublevelID_5_2_Sub07 = $07
	!Define_SMB2U_SublevelID_5_2_Sub08 = $08
	!Define_SMB2U_SublevelID_5_2_Sub09 = $09
!Define_SMB2U_LevelID_5_3 = $0E
	!Define_SMB2U_SublevelID_5_3_LevelEntrance = !Define_SMB2U_SublevelID_X_X_LevelEntrance
	!Define_SMB2U_SublevelID_5_3_BigTreePlain = $01
	!Define_SMB2U_SublevelID_5_3_Cave = $02
	!Define_SMB2U_SublevelID_5_3_TreeInterior = $03
	!Define_SMB2U_SublevelID_5_3_Treetops = $04
	!Define_SMB2U_SublevelID_5_3_ClawgripsRoom = $05
	!Define_SMB2U_SublevelID_5_3_Sub06 = $06
	!Define_SMB2U_SublevelID_5_3_Sub07 = $07
	!Define_SMB2U_SublevelID_5_3_Sub08 = $08
	!Define_SMB2U_SublevelID_5_3_Sub09 = $09
!Define_SMB2U_LevelID_6_1 = $0F
	!Define_SMB2U_SublevelID_6_1_LevelEntrance = !Define_SMB2U_SublevelID_X_X_LevelEntrance
	!Define_SMB2U_SublevelID_6_1_Cave = $01
	!Define_SMB2U_SublevelID_6_1_BirdosRoom = $02
	!Define_SMB2U_SublevelID_6_1_SandyVaseWithPhanto = $03
	!Define_SMB2U_SublevelID_6_1_GenericVase = $04
	!Define_SMB2U_SublevelID_6_1_SandyVase = $05
	!Define_SMB2U_SublevelID_6_1_Vase = $06
	!Define_SMB2U_SublevelID_6_1_Sub07 = $07
	!Define_SMB2U_SublevelID_6_1_Sub08 = $08
	!Define_SMB2U_SublevelID_6_1_Sub09 = $09
!Define_SMB2U_LevelID_6_2 = $10
	!Define_SMB2U_SublevelID_6_2_LevelEntrance = !Define_SMB2U_SublevelID_X_X_LevelEntrance
	!Define_SMB2U_SublevelID_6_2_AlbatossRoom = $01
	!Define_SMB2U_SublevelID_6_2_BirdosRoom = $02
	!Define_SMB2U_SublevelID_6_2_Sub03 = $03
	!Define_SMB2U_SublevelID_6_2_Sub04 = $04
	!Define_SMB2U_SublevelID_6_2_Sub05 = $05
	!Define_SMB2U_SublevelID_6_2_Sub06 = $06
	!Define_SMB2U_SublevelID_6_2_Sub07 = $07
	!Define_SMB2U_SublevelID_6_2_Sub08 = $08
	!Define_SMB2U_SublevelID_6_2_Sub09 = $09
!Define_SMB2U_LevelID_6_3 = $11
	!Define_SMB2U_SublevelID_6_3_LevelEntrance = !Define_SMB2U_SublevelID_X_X_LevelEntrance
	!Define_SMB2U_SublevelID_6_3_OutsideBobOmbCaveEntrance = $01
	!Define_SMB2U_SublevelID_6_3_BobOmbCave = $02
	!Define_SMB2U_SublevelID_6_3_Cliff = $03
	!Define_SMB2U_SublevelID_6_3_SkyPyramid = $04
	!Define_SMB2U_SublevelID_6_3_BirdosRoom = $05
	!Define_SMB2U_SublevelID_6_3_TryclydesRoom = $06
	!Define_SMB2U_SublevelID_6_3_Sub07 = $07
	!Define_SMB2U_SublevelID_6_3_Sub08 = $08
	!Define_SMB2U_SublevelID_6_3_Sub09 = $09
!Define_SMB2U_LevelID_7_1 = $12
	!Define_SMB2U_SublevelID_7_1_LevelEntrance = !Define_SMB2U_SublevelID_X_X_LevelEntrance
	!Define_SMB2U_SublevelID_7_1_SkyPath1 = $01
	!Define_SMB2U_SublevelID_7_1_SkyPath2 = $02
	!Define_SMB2U_SublevelID_7_1_CloudyClimb = $03
	!Define_SMB2U_SublevelID_7_1_BirdosRoom = $04
	!Define_SMB2U_SublevelID_7_1_PotionBuilding = $05
	!Define_SMB2U_SublevelID_7_1_Sub06 = $06
	!Define_SMB2U_SublevelID_7_1_Sub07 = $07
	!Define_SMB2U_SublevelID_7_1_Sub08 = $08
	!Define_SMB2U_SublevelID_7_1_Sub09 = $09
!Define_SMB2U_LevelID_7_2 = $13
	!Define_SMB2U_SublevelID_7_2_LevelEntrance = !Define_SMB2U_SublevelID_X_X_LevelEntrance
	!Define_SMB2U_SublevelID_7_2_FortressLobby = $01
	!Define_SMB2U_SublevelID_7_2_VariousSmallRooms = $02
	!Define_SMB2U_SublevelID_7_2_Basement = $03
	!Define_SMB2U_SublevelID_7_2_HawkmouthBossRoom = $04
	!Define_SMB2U_SublevelID_7_2_WartsRoom = $05
	!Define_SMB2U_SublevelID_7_2_MushroomBlockAndCentralChainShaft = $06
	!Define_SMB2U_SublevelID_7_2_ConveyorShaft = $07
	!Define_SMB2U_SublevelID_7_2_ChainTower = $08
	!Define_SMB2U_SublevelID_7_2_ExteriorSideOfTower = $09
!Define_SMB2U_LevelID_7_3 = $14