!LevelNum = $025

org SMW_SpecifySublevelToLoad_Layer1DataPtrs+(!LevelNum*$03)
	dl SMW_GetLayer1And2PointersForEnemyRollcall_Screen01
	dl SMW_GetLayer1And2PointersForEnemyRollcall_Screen02
	dl SMW_GetLayer1And2PointersForEnemyRollcall_Screen03
	dl SMW_GetLayer1And2PointersForEnemyRollcall_Screen04
	dl SMW_GetLayer1And2PointersForEnemyRollcall_Screen05
	dl SMW_GetLayer1And2PointersForEnemyRollcall_Screen06
	dl SMW_GetLayer1And2PointersForEnemyRollcall_Screen07
	dl SMW_GetLayer1And2PointersForEnemyRollcall_Screen08
	dl SMW_GetLayer1And2PointersForEnemyRollcall_Screen09
	dl SMW_GetLayer1And2PointersForEnemyRollcall_Screen10
	dl SMW_GetLayer1And2PointersForEnemyRollcall_Screen11
	dl SMW_GetLayer1And2PointersForEnemyRollcall_Screen12
	dl SMW_GetLayer1And2PointersForEnemyRollcall_Screen13
	dl SMW_LEVEL_L1_GhostHouseEntrance
	dl SMW_LEVEL_L1_CastleEntrance
	dl SMW_LEVEL_L1_NoYoshiEntrance1
	dl SMW_LEVEL_L1_NoYoshiEntrance2
	dl SMW_LEVEL_L1_NoYoshiEntrance3
	dl SMW_LEVEL_L1_CastleEntrance2
	dl SMW_LEVEL_L1_024_1
	dl SMW_LEVEL_L1_024_2
	dl SMW_LEVEL_L1_024_3
	dl SMW_LEVEL_L1_024_4
	dl SMW_LEVEL_L1_024_5
	dl SMW_UnusedLevelData_RideAmongTheCloudsL1
	dl SMW_UnusedLevelData_MushroomScalesL1
	dl SMW_UnusedLevelData_BossTestL1
	dl SMW_UnusedLevelData_LavaCaveL1
	dl SMW_UnusedLevelData_FollowTestL1
	dl SMW_UnusedLevelData_OldWendysCastleL1
	dl SMW_UnusedLevelData_GhostGroundL1
	dl SMW_UnusedLevelData_GhostHouseExitL1
	dl SMW_UnusedLevelData_GhostHouseExit2L1
	dl SMW_UnusedLevelData_BushTestL1

org SMW_SpecifySublevelToLoad_Layer2DataPtrs+(!LevelNum*$03)
	dw SMW_Backgrounds_Layer2_Forest		:	db $FF
	dw SMW_Backgrounds_Layer2_Clouds		:	db $FF
	dw SMW_Backgrounds_Layer2_Rocks2		:	db $FF
	dw SMW_Backgrounds_Layer2_Mountains		:	db $FF
	dw SMW_Backgrounds_Layer2_SmallHills		:	db $FF
	dw SMW_Backgrounds_Layer2_Cave			:	db $FF
	dw SMW_Backgrounds_Layer2_Water			:	db $FF
	dw SMW_Backgrounds_Layer2_GhostHouse		:	db $FF
	dw SMW_Backgrounds_Layer2_Castle		:	db $FF
	dw SMW_Backgrounds_Layer2_Castle2		:	db $FF
	dw SMW_Backgrounds_Layer2_Castle		:	db $FF
	dw SMW_Backgrounds_Layer2_Castle2		:	db $FF
	dw SMW_Backgrounds_Layer2_Black			:	db $FF
	dl SMW_LEVEL_L1_BlankEntrance
	dw SMW_Backgrounds_Layer2_Mountains		:	db $FF
	dw SMW_Backgrounds_Layer2_Mountains		:	db $FF
	dw SMW_Backgrounds_Layer2_Stars			:	db $FF
	dw SMW_Backgrounds_Layer2_Rocks2		:	db $FF
	dw SMW_Backgrounds_Layer2_Black			:	db $FF
	dw SMW_Backgrounds_Layer2_Rocks2		:	db $FF
	dw SMW_Backgrounds_Layer2_Rocks2		:	db $FF
	dw SMW_Backgrounds_Layer2_Rocks2		:	db $FF
	dw SMW_Backgrounds_Layer2_Rocks2		:	db $FF
	dw SMW_Backgrounds_Layer2_Rocks2		:	db $FF
	dw SMW_Backgrounds_Layer2_Black			:	db $FF
	dw SMW_Backgrounds_Layer2_Black			:	db $FF
	dw SMW_Backgrounds_Layer2_Black			:	db $FF
	dl SMW_UnusedLevelData_LavaCaveL2
	dw SMW_Backgrounds_Layer2_Black			:	db $FF
	dl SMW_UnusedLevelData_OldWendysCastleL2
	dw SMW_Backgrounds_Layer2_Black			:	db $FF
	dl SMW_LEVEL_L2_0C4
	dl SMW_LEVEL_L2_0C4
	dl SMW_LEVEL_L2_0C4

org SMW_SpecifySublevelToLoad_SpriteDataPtrs+(!LevelNum*$02)
	dw SMW_LEVEL_SP_Test
	dw SMW_LEVEL_SP_Test
	dw SMW_LEVEL_SP_Test
	dw SMW_LEVEL_SP_Test
	dw SMW_LEVEL_SP_Test
	dw SMW_LEVEL_SP_Test
	dw SMW_LEVEL_SP_Test
	dw SMW_LEVEL_SP_Test
	dw SMW_LEVEL_SP_Test
	dw SMW_LEVEL_SP_Test
	dw SMW_LEVEL_SP_Test
	dw SMW_LEVEL_SP_Test
	dw SMW_LEVEL_SP_Test
	dw SMW_LEVEL_SP_Test
	dw SMW_LEVEL_SP_Test
	dw SMW_LEVEL_SP_Test
	dw SMW_LEVEL_SP_Test
	dw SMW_LEVEL_SP_Test
	dw SMW_LEVEL_SP_Test
	dw SMW_LEVEL_SP_024_1
	dw SMW_LEVEL_SP_024_2
	dw SMW_LEVEL_SP_024_3
	dw SMW_LEVEL_SP_024_4
	dw SMW_LEVEL_SP_024_5
	dw SMW_UnusedLevelData_RideAmongTheCloudsSpr
	dw SMW_UnusedLevelData_MushroomScalesSpr
	dw SMW_LEVEL_SP_Test
	dw SMW_UnusedLevelData_LavaCaveSpr
	dw SMW_UnusedLevelData_FollowTestSpr
	dw SMW_UnusedLevelData_OldWendysCastleSpr
	dw SMW_LEVEL_SP_Test
	dw SMW_UnusedLevelData_GoalTape
	dw SMW_UnusedLevelData_GoalTape2
	dw SMW_LEVEL_SP_Test