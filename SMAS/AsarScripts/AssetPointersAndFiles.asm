; Note: This file is used by the ExtractAssets.bat batch script to define where each file is, how large they are, and their filenames.

lorom
;!ROMVer = $0000						; Note: This is set within the batch script
!ROM_SMAS_U = $0001
!ROM_SMAS_E = $0002
!ROM_SMAS_J1 = $0004
!ROM_SMAS_J2 = $0008
!ROM_SMASW_U = $0010
!ROM_SMASW_E = $0020

org $008000
MainPointerTableStart:
	dl MainPointerTableStart,MainPointerTableEnd-MainPointerTableStart
	dl SMAS_GFXPointersStart,(SMAS_GFXPointersEnd-SMAS_GFXPointersStart)/$0C
	dl SMAS_MusicPointersStart,(SMAS_MusicPointersEnd-SMAS_MusicPointersStart)/$0C
	dl MainBRRPointersStart,(MainBRRPointersEnd-MainBRRPointersStart)/$0C
	dl RCBRRPointersStart,(RCBRRPointersEnd-RCBRRPointersStart)/$0C
	dl SMB1_GFXPointersStart,(SMB1_GFXPointersEnd-SMB1_GFXPointersStart)/$0C
	dl SMB1_MusicPointersStart,(SMB1_MusicPointersEnd-SMB1_MusicPointersStart)/$0C
	dl SMB2U_GFXPointersStart,(SMB2U_GFXPointersEnd-SMB2U_GFXPointersStart)/$0C
	dl SMB2U_MusicPointersStart,(SMB2U_MusicPointersEnd-SMB2U_MusicPointersStart)/$0C
	dl SMB3_BGGFXPointersStart,(SMB3_BGGFXPointersEnd-SMB3_BGGFXPointersStart)/$0C
	dl SMB3_GFXPointersStart,(SMB3_GFXPointersEnd-SMB3_GFXPointersStart)/$0C
	dl SMB3_LevelMusicPointersStart,(SMB3_LevelMusicPointersEnd-SMB3_LevelMusicPointersStart)/$0C
	dl SMB3_OverworldMusicPointersStart,(SMB3_OverworldMusicPointersEnd-SMB3_OverworldMusicPointersStart)/$0C
	dl SMW_CompressedGFXPointersStart,(SMW_CompressedGFXPointersEnd-SMW_CompressedGFXPointersStart)/$0C
	dl SMW_UncompressedGFXPointersStart,(SMW_UncompressedGFXPointersEnd-SMW_UncompressedGFXPointersStart)/$0C
	dl SMW_LevelMusicPointersStart,(SMW_LevelMusicPointersEnd-SMW_LevelMusicPointersStart)/$0C
	dl SMW_OverworldMusicPointersStart,(SMW_OverworldMusicPointersEnd-SMW_OverworldMusicPointersStart)/$0C
	dl SMW_CreditsMusicPointersStart,(SMW_CreditsMusicPointersEnd-SMW_CreditsMusicPointersStart)/$0C
	dl SMW_BRRPointersStart,(SMW_BRRPointersEnd-SMW_BRRPointersStart)/$0C
MainPointerTableEnd:

;--------------------------------------------------------------------

SMAS_GFXPointersStart:
if !ROMVer&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	dl $2CE800,$2D8000,BlankFileSelectControllerGFX,BlankFileSelectControllerGFXEnd
elseif !ROMVer&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	dl $2CE800,$2D8000,BlankFileSelectControllerGFX,BlankFileSelectControllerGFXEnd
else
	dl $49F800,$4A8000,BlankFileSelectControllerGFX,BlankFileSelectControllerGFXEnd
endif
if !ROMVer&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	dl $2B8000,$2C8000,BoxArtGFX1,BoxArtGFX1End
else
	dl $488000,$498000,BoxArtGFX1,BoxArtGFX1End
endif
if !ROMVer&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	dl $2C8000,$2CD800,BoxArtGFX2,BoxArtGFX2End
else
	dl $498000,$49D800,BoxArtGFX2,BoxArtGFX2End
endif
	dl $199800,$19A000,ErrorMessageFontGFX,ErrorMessageFontGFXEnd
if !ROMVer&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	dl $2CD800,$2CE800,FileSelectControllerGFX,FileSelectControllerGFXEnd
else
	dl $49D800,$49E800,FileSelectControllerGFX,FileSelectControllerGFXEnd
	dl $49E800,$49F800,FileSelectYoshiGFX,FileSelectYoshiGFXEnd
endif
	dl $38B000,$38B800,PauseMenuGFX,PauseMenuGFXEnd
if !ROMVer&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	dl $028000,$029000,SplashScreenGFX,SplashScreenGFXEnd
else
	dl $05F000,$068000,SplashScreenGFX,SplashScreenGFXEnd
endif
	dl $018000,$028000,TitleScreenCharactersGFX1,TitleScreenCharactersGFX1End
if !ROMVer&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	dl $3DCC00,$3DE000,TitleScreenCharactersGFX2,TitleScreenCharactersGFX2End
	dl $029000,$029800,TriangleTransitionalEffectGFX,TriangleTransitionalEffectGFXEnd
	dl $02A000,$02C000,TitleScreenTextGFX,TitleScreenTextGFXEnd
else
	dl $3DC000,$3DE000,TitleScreenCharactersGFX2,TitleScreenCharactersGFX2End
	dl $07E800,$07F000,TriangleTransitionalEffectGFX,TriangleTransitionalEffectGFXEnd
	dl $028000,$02A000,TitleScreenTextGFX,TitleScreenTextGFXEnd
endif
SMAS_GFXPointersEnd:

;--------------------------------------------------------------------

SMAS_MusicPointersStart:
	dl $3BA093,$3BA251,SMAS_Music_GameSelect,SMAS_Music_GameSelectEnd
	dl $3B9E01,$3BA069,SMAS_Music_TitleScreen,SMAS_Music_TitleScreenEnd
SMAS_MusicPointersEnd:

;--------------------------------------------------------------------

MainBRRPointersStart:
	dl $0B8078,$0B80AE,MainBRRFile00,MainBRRFile00End
	dl $0B80AE,$0B80E4,MainBRRFile01,MainBRRFile01End
	dl $0B80E4,$0B81E0,MainBRRFile03,MainBRRFile03End
	dl $0B81E0,$0B831B,MainBRRFile04,MainBRRFile04End
	dl $0B831B,$0B8351,MainBRRFile05,MainBRRFile05End
	dl $0B8351,$0B857F,MainBRRFile07,MainBRRFile07End
	dl $0B857F,$0B89E4,MainBRRFile08,MainBRRFile08End
	dl $0B89E4,$0B9041,MainBRRFile0A,MainBRRFile0AEnd
	dl $0B9041,$0B9077,MainBRRFile0B,MainBRRFile0BEnd
	dl $0B9077,$0B9CB3,MainBRRFile0C,MainBRRFile0CEnd
	dl $0B9CB3,$0BAF28,MainBRRFile0D,MainBRRFile0DEnd
	dl $0BAF28,$0BB5BB,MainBRRFile0E,MainBRRFile0EEnd
	dl $0BB5BB,$0BB603,MainBRRFile0F,MainBRRFile0FEnd
	dl $0BB603,$0BB8D3,MainBRRFile10,MainBRRFile10End
	dl $0BB8D3,$0BC356,MainBRRFile11,MainBRRFile11End
	dl $0BC356,$0BC5CC,MainBRRFile12,MainBRRFile12End
	dl $0BC5CC,$0BCEA8,MainBRRFile13,MainBRRFile13End
	dl $0BCEA8,$0BD409,MainBRRFile14,MainBRRFile14End
	dl $0BD409,$0BDD5A,MainBRRFile15,MainBRRFile15End
	dl $0BDD5A,$0BEEEE,MainBRRFile16,MainBRRFile16End
	dl $0BEEEE,$0BFA91,MainBRRFile17,MainBRRFile17End
	dl $0BFA91,$0BFC98,MainBRRFile18,MainBRRFile18End
MainBRRPointersEnd:

;--------------------------------------------------------------------

RCBRRPointersStart:
if !ROMVer&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	dl $3BA289,$3BF1BE,RCBRRFile00,RCBRRFile00End
	dl $3BF1BE,$3BF2BA,RCBRRFile01,RCBRRFile01End
	dl $3BF2BA,$3BF3F5,RCBRRFile04,RCBRRFile04End
	dl $3BF3F5,$3BF869,RCBRRFile05,RCBRRFile05End
else
	dl $3BA289,$3BEB22,RCBRRFile00,RCBRRFile00End
	dl $3BEB22,$3BEC1E,RCBRRFile01,RCBRRFile01End
	dl $3BEC1E,$3BED59,RCBRRFile04,RCBRRFile04End
	dl $3BED59,$3BF1C9,RCBRRFile05,RCBRRFile05End
endif
RCBRRPointersEnd:

;--------------------------------------------------------------------

SMB1_GFXPointersStart:
	dl $08F000,$098000,SMB1_GFX_BG_BonusRoomLuigi,SMB1_GFX_BG_BonusRoomLuigiEnd
	dl $08E000,$08F000,SMB1_GFX_BG_BonusRoomMario,SMB1_GFX_BG_BonusRoomMarioEnd
	dl $08A000,$08B000,SMB1_GFX_BG_Castle,SMB1_GFX_BG_CastleEnd
	dl $098000,$099000,SMB1_GFX_BG_Cave,SMB1_GFX_BG_CaveEnd
	dl $08D000,$08E000,SMB1_GFX_BG_DeathScreen1,SMB1_GFX_BG_DeathScreen1End
	dl $09F800,$0A8000,SMB1_GFX_BG_DeathScreen2,SMB1_GFX_BG_DeathScreen2End
	dl $089800,$08A000,SMB1_GFX_BG_DottedHills,SMB1_GFX_BG_DottedHillsEnd
	dl $09E800,$09F000,SMB1_GFX_BG_FinalCastle1,SMB1_GFX_BG_FinalCastle1End
	dl $09F000,$09F800,SMB1_GFX_BG_FinalCastle2,SMB1_GFX_BG_FinalCastle2End
	dl $06A000,$06B000,SMB1_GFX_BG_HillsAndTrees,SMB1_GFX_BG_HillsAndTreesEnd
	dl $089000,$089800,SMB1_GFX_BG_Mushrooms,SMB1_GFX_BG_MushroomsEnd
	dl $09E000,$09E800,SMB1_GFX_BG_Night,SMB1_GFX_BG_NightEnd
	dl $08B800,$08C000,SMB1_GFX_BG_Pillars,SMB1_GFX_BG_PillarsEnd
	dl $088000,$089000,SMB1_GFX_BG_Underwater,SMB1_GFX_BG_UnderwaterEnd
	dl $099000,$09A000,SMB1_GFX_BG_UnderwaterCastle,SMB1_GFX_BG_UnderwaterCastleEnd
	dl $08B000,$08B800,SMB1_GFX_BG_Waterfalls,SMB1_GFX_BG_WaterfallsEnd
	dl $2FD000,$308000,SMB1_GFX_Ending,SMB1_GFX_EndingEnd
	dl $09A000,$09C000,SMB1_GFX_FG_BG_Castle,SMB1_GFX_FG_BG_CastleEnd
	dl $09D000,$09E000,SMB1_GFX_FG_Cave,SMB1_GFX_FG_CaveEnd
	dl $09C000,$09D000,SMB1_GFX_FG_Grassland,SMB1_GFX_FG_GrasslandEnd
	dl $068000,$06A000,SMB1_GFX_FG_SMB1_GlobalTiles_SMASU,SMB1_GFX_FG_SMB1_GlobalTiles_SMASUEnd
	dl $068000,$06A000,SMB1_GFX_FG_SMB1_GlobalTiles_USA,SMB1_GFX_FG_SMB1_GlobalTiles_USAEnd
	dl $06B000,$06C000,SMB1_GFX_FG_SMB1_TitleLogo,SMB1_GFX_FG_SMB1_TitleLogoEnd
	dl $108000,$10A000,SMB1_GFX_FG_SMBLL_GlobalTiles,SMB1_GFX_FG_SMBLL_GlobalTilesEnd
	dl $10B000,$10C000,SMB1_GFX_FG_SMBLL_TitleLogo,SMB1_GFX_FG_SMBLL_TitleLogoEnd
	dl $08C000,$08D000,SMB1_GFX_FG_Snow,SMB1_GFX_FG_SnowEnd
	dl $0CF800,$0D8000,SMB1_GFX_Layer3,SMB1_GFX_Layer3End
	dl $0AC000,$0B8000,SMB1_GFX_Player_Luigi,SMB1_GFX_Player_LuigiEnd
	dl $0A8000,$0AC000,SMB1_GFX_Player_Mario,SMB1_GFX_Player_MarioEnd
	dl $06C000,$078000,SMB1_GFX_SMB1_AnimatedTiles,SMB1_GFX_SMB1_AnimatedTilesEnd
	dl $10C000,$118000,SMB1_GFX_SMBLL_AnimatedTiles,SMB1_GFX_SMBLL_AnimatedTilesEnd
	dl $078000,$07C000,SMB1_GFX_Sprite_GlobalTiles,SMB1_GFX_Sprite_GlobalTilesEnd
	dl $1EC000,$1F8000,SMB1_GFX_Sprite_PeachAndToad,SMB1_GFX_Sprite_PeachAndToadEnd
SMB1_GFXPointersEnd:

;--------------------------------------------------------------------

SMB1_MusicPointersStart:
	dl $1FA1EC,$1FA596,SMB1_Music_BonusRoom,SMB1_Music_BonusRoomEnd
	dl $1FA5D2,$1FA846,SMB1_Music_BowserBattle,SMB1_Music_BowserBattleEnd
	dl $1F8F40,$1F90BB,SMB1_Music_Castle,SMB1_Music_CastleEnd
	dl $1F9562,$1F9899,SMB1_Music_CopyOfPeachRescued,SMB1_Music_CopyOfPeachRescuedEnd
	dl $1F9D77,$1F9E0D,SMB1_Music_Death,SMB1_Music_DeathEnd
	dl $1F9CA2,$1F9D51,SMB1_Music_EnterPipeCutscene,SMB1_Music_EnterPipeCutsceneEnd
	dl $1FA882,$1FAC72,SMB1_Music_FinalBowserBattle,SMB1_Music_FinalBowserBattleEnd
	dl $1F9E21,$1F9ED8,SMB1_Music_GameOver,SMB1_Music_GameOverEnd
	dl $1F90D3,$1F9236,SMB1_Music_HaveStar,SMB1_Music_HaveStarEnd
	dl $1F80BE,$1F8863,SMB1_Music_Overworld,SMB1_Music_OverworldEnd
	dl $1F9EEC,$1FA083,SMB1_Music_PassedBoss,SMB1_Music_PassedBossEnd
	dl $1FA097,$1FA1B0,SMB1_Music_PassedLevel,SMB1_Music_PassedLevelEnd
	dl $1F929A,$1F94A4,SMB1_Music_SMB1PeachRescued,SMB1_Music_SMB1PeachRescuedEnd
	dl $1F995B,$1F9C7C,SMB1_Music_SMBLLPeachRescued,SMB1_Music_SMBLLPeachRescuedEnd
	dl $1FACC0,$1FB1BE,SMB1_Music_SMB1TitleScreen,SMB1_Music_SMB1TitleScreenEnd
	dl $1FB230,$1FB765,SMB1_Music_SMBLLTitleScreen,SMB1_Music_SMBLLTitleScreenEnd
	dl $1F8CCB,$1F8F16,SMB1_Music_Underground,SMB1_Music_UndergroundEnd
	dl $1F889F,$1F8C8F,SMB1_Music_Underwater,SMB1_Music_UnderwaterEnd
SMB1_MusicPointersEnd:

;--------------------------------------------------------------------

SMB2U_GFXPointersStart:
	dl $1A8000,$1AE000,SMB2U_GFX_AnimatedSleepingMario,SMB2U_GFX_AnimatedSleepingMarioEnd
	dl $1BF000,$1BF800,SMB2U_GFX_BG_Desert1,SMB2U_GFX_BG_Desert1End
	dl $1BF800,$1C8000,SMB2U_GFX_BG_Desert2,SMB2U_GFX_BG_Desert2End
	dl $1C9000,$1C9800,SMB2U_GFX_BG_DesertCliff,SMB2U_GFX_BG_DesertCliffEnd
	dl $17B000,$17B800,SMB2U_GFX_BG_EndingScreen1,SMB2U_GFX_BG_EndingScreen1End
	dl $1CE800,$1CF000,SMB2U_GFX_BG_GentleHills,SMB2U_GFX_BG_GentleHillsEnd
	dl $1DB800,$1DC000,SMB2U_GFX_BG_GiantPhanto1,SMB2U_GFX_BG_GiantPhanto1End
	dl $1DC000,$1DC800,SMB2U_GFX_BG_GiantPhanto2,SMB2U_GFX_BG_GiantPhanto2End
	dl $1DC800,$1DD000,SMB2U_GFX_BG_GiantPhanto3,SMB2U_GFX_BG_GiantPhanto3End
	dl $1CB000,$1CB800,SMB2U_GFX_BG_IceCrystalCave,SMB2U_GFX_BG_IceCrystalCaveEnd
	dl $1BC800,$1BD000,SMB2U_GFX_BG_Jungle1,SMB2U_GFX_BG_Jungle1End
	dl $1BD000,$1BD800,SMB2U_GFX_BG_Jungle2,SMB2U_GFX_BG_Jungle2End
	dl $1CB800,$1CC000,SMB2U_GFX_BG_NightGrassyHills,SMB2U_GFX_BG_NightGrassyHillsEnd
	dl $1C8000,$1C8800,SMB2U_GFX_BG_PyramidInterior1,SMB2U_GFX_BG_PyramidInterior1End
	dl $1C8800,$1C9000,SMB2U_GFX_BG_PyramidInterior2,SMB2U_GFX_BG_PyramidInterior2End
	dl $1CC000,$1CC800,SMB2U_GFX_BG_SkyStructures1,SMB2U_GFX_BG_SkyStructures1End
	dl $1CC800,$1CD000,SMB2U_GFX_BG_SkyStructures2,SMB2U_GFX_BG_SkyStructures2End
	dl $1CF800,$1D8000,SMB2U_GFX_BG_SkyStructures3,SMB2U_GFX_BG_SkyStructures3End
	dl $1CA000,$1CA800,SMB2U_GFX_BG_SnowHills1,SMB2U_GFX_BG_SnowHills1End
	dl $1CA800,$1CB000,SMB2U_GFX_BG_SnowHills2,SMB2U_GFX_BG_SnowHills2End
	dl $1C9800,$1CA000,SMB2U_GFX_BG_StripedHills,SMB2U_GFX_BG_StripedHillsEnd
	dl $1BD800,$1BE000,SMB2U_GFX_BG_Underground,SMB2U_GFX_BG_UndergroundEnd
	dl $1BE000,$1BE800,SMB2U_GFX_BG_Warehouse1,SMB2U_GFX_BG_Warehouse1End
	dl $1BE800,$1BF000,SMB2U_GFX_BG_Warehouse2,SMB2U_GFX_BG_Warehouse2End
	dl $1CD000,$1CD800,SMB2U_GFX_BG_WartsFortress1,SMB2U_GFX_BG_WartsFortress1End
	dl $1CD800,$1CE000,SMB2U_GFX_BG_WartsFortress2,SMB2U_GFX_BG_WartsFortress2End
	dl $1CE000,$1CE800,SMB2U_GFX_BG_WartsFortress3,SMB2U_GFX_BG_WartsFortress3End
	dl $198800,$199000,SMB2U_GFX_BonusChanceText,SMB2U_GFX_BonusChanceTextEnd
	dl $19A800,$19B000,SMB2U_GFX_CharacterSelectCharacters,SMB2U_GFX_CharacterSelectCharactersEnd
	dl $19B000,$19C000,SMB2U_GFX_Curtain,SMB2U_GFX_CurtainEnd
	dl $19C000,$19C800,SMB2U_GFX_EndingScreen2Tiles,SMB2U_GFX_EndingScreen2TilesEnd
	dl $1DD000,$1E8000,SMB2U_GFX_FG_AnimatedTilesBank1D,SMB2U_GFX_FG_AnimatedTilesBank1DEnd
	dl $18D000,$198000,SMB2U_GFX_FG_AnimatedTilesBank18,SMB2U_GFX_FG_AnimatedTilesBank18End
	dl $1D9000,$1D9800,SMB2U_GFX_FG_BrickBuilding,SMB2U_GFX_FG_BrickBuildingEnd
	dl $1D9800,$1DA000,SMB2U_GFX_FG_GiantTree,SMB2U_GFX_FG_GiantTreeEnd
	dl $18C000,$18C800,SMB2U_GFX_FG_GlobalTiles1,SMB2U_GFX_FG_GlobalTiles1End
	dl $18C800,$18D000,SMB2U_GFX_FG_GlobalTiles2,SMB2U_GFX_FG_GlobalTiles2End
	dl $1D8000,$1D8800,SMB2U_GFX_FG_IceRock,SMB2U_GFX_FG_IceRockEnd
	dl $1DA800,$1DB000,SMB2U_GFX_FG_PyramidInterior,SMB2U_GFX_FG_PyramidInteriorEnd
	dl $1BC000,$1BC800,SMB2U_GFX_FG_RockyGround,SMB2U_GFX_FG_RockyGroundEnd
	dl $1DB000,$1DB800,SMB2U_GFX_FG_SkyFortressInterior,SMB2U_GFX_FG_SkyFortressInteriorEnd
	dl $189000,$18A000,SMB2U_GFX_FG_StandardDesertTiles,SMB2U_GFX_FG_StandardDesertTilesEnd
	dl $188000,$189000,SMB2U_GFX_FG_StandardGrasslandTiles,SMB2U_GFX_FG_StandardGrasslandTilesEnd
	dl $18B000,$18C000,SMB2U_GFX_FG_StandardSkyTiles,SMB2U_GFX_FG_StandardSkyTilesEnd
	dl $18A000,$18B000,SMB2U_GFX_FG_StandardSnowTiles,SMB2U_GFX_FG_StandardSnowTilesEnd
	dl $1DA000,$1DA800,SMB2U_GFX_FG_VeggieMachine,SMB2U_GFX_FG_VeggieMachineEnd
	dl $19F000,$19F800,SMB2U_GFX_GameOverTiles,SMB2U_GFX_GameOverTilesEnd
	dl $1E8000,$1E9000,SMB2U_GFX_Layer3,SMB2U_GFX_Layer3End
	dl $1BB000,$1BB800,SMB2U_GFX_LevelPreviewBorder,SMB2U_GFX_LevelPreviewBorderEnd
	dl $1CF000,$1CF800,SMB2U_GFX_LevelPreviewTiles,SMB2U_GFX_LevelPreviewTilesEnd
	dl $1AE000,$1AE800,SMB2U_GFX_PauseMenu,SMB2U_GFX_PauseMenuEnd
	dl $2F9400,$2FA800,SMB2U_GFX_Player_Luigi,SMB2U_GFX_Player_LuigiEnd
	dl $2F8000,$2F9400,SMB2U_GFX_Player_Mario,SMB2U_GFX_Player_MarioEnd
	dl $2FA800,$2FBC00,SMB2U_GFX_Player_Peach,SMB2U_GFX_Player_PeachEnd
	dl $2FBC00,$2FD000,SMB2U_GFX_Player_Toad,SMB2U_GFX_Player_ToadEnd
	dl $168000,$16C000,SMB2U_GFX_Player_UnusedDuplicates,SMB2U_GFX_Player_UnusedDuplicatesEnd
	dl $19F800,$1A8000,SMB2U_GFX_ShadedFont,SMB2U_GFX_ShadedFontEnd
	dl $1BB800,$1BC000,SMB2U_GFX_SlotMachineReels,SMB2U_GFX_SlotMachineReelsEnd
	dl $179000,$179800,SMB2U_GFX_Sprite_Albatoss,SMB2U_GFX_Sprite_AlbatossEnd
	dl $16F800,$178000,SMB2U_GFX_Sprite_BirdoSparkBobOmbAndDesertObjects,SMB2U_GFX_Sprite_BirdoSparkBobOmbAndDesertObjectsEnd
	dl $16F000,$16F800,SMB2U_GFX_Sprite_BirdoSparkBobOmbAndGrasslandObjects,SMB2U_GFX_Sprite_BirdoSparkBobOmbAndGrasslandObjectsEnd
	dl $178800,$179000,SMB2U_GFX_Sprite_BirdoSparkBobOmbAndSkyObjects,SMB2U_GFX_Sprite_BirdoSparkBobOmbAndSkyObjectsEnd
	dl $178000,$178800,SMB2U_GFX_Sprite_BirdoSparkBobOmbAndSnowObjects,SMB2U_GFX_Sprite_BirdoSparkBobOmbAndSnowObjectsEnd
	dl $17E800,$17F000,SMB2U_GFX_Sprite_Clawgrip,SMB2U_GFX_Sprite_ClawgripEnd
	dl $179800,$17A000,SMB2U_GFX_Sprite_DesertEnemies,SMB2U_GFX_Sprite_DesertEnemiesEnd
	dl $16E000,$16F000,SMB2U_GFX_Sprite_DynamicSprites,SMB2U_GFX_Sprite_DynamicSpritesEnd
	dl $17B800,$17C000,SMB2U_GFX_Sprite_EndingScreen2_1,SMB2U_GFX_Sprite_EndingScreen2_1End
	dl $17C000,$17C800,SMB2U_GFX_Sprite_EndingScreen2_2,SMB2U_GFX_Sprite_EndingScreen2_2End
	dl $1B8000,$1BB000,SMB2U_GFX_Sprite_EndingScreen3,SMB2U_GFX_Sprite_EndingScreen3End
	dl $17E000,$17E800,SMB2U_GFX_Sprite_Fryguy,SMB2U_GFX_Sprite_FryguyEnd
	dl $19E000,$19F000,SMB2U_GFX_Sprite_Global1,SMB2U_GFX_Sprite_Global1End
	dl $16C000,$16D000,SMB2U_GFX_Sprite_Global2,SMB2U_GFX_Sprite_Global2End
	dl $16D800,$16E000,SMB2U_GFX_Sprite_GrasslandEnemies,SMB2U_GFX_Sprite_GrasslandEnemiesEnd
	dl $17D000,$17D800,SMB2U_GFX_Sprite_Mouser,SMB2U_GFX_Sprite_MouserEnd
	dl $17A800,$17B000,SMB2U_GFX_Sprite_SkyEnemies,SMB2U_GFX_Sprite_SkyEnemiesEnd
	dl $17A000,$17A800,SMB2U_GFX_Sprite_SnowEnemies,SMB2U_GFX_Sprite_SnowEnemiesEnd
	dl $16D000,$16D800,SMB2U_GFX_Sprite_StandardEnemies,SMB2U_GFX_Sprite_StandardEnemiesEnd
	dl $17D800,$17E000,SMB2U_GFX_Sprite_Tryclyde,SMB2U_GFX_Sprite_TryclydeEnd
	dl $17F000,$17F800,SMB2U_GFX_Sprite_Wart1,SMB2U_GFX_Sprite_Wart1End
	dl $17F800,$188000,SMB2U_GFX_Sprite_Wart2,SMB2U_GFX_Sprite_Wart2End
	dl $19C800,$19E000,SMB2U_GFX_StaticSleepingMario,SMB2U_GFX_StaticSleepingMarioEnd
	dl $198000,$198800,SMB2U_GFX_TitleScreenBorder,SMB2U_GFX_TitleScreenBorderEnd
	dl $199000,$199800,SMB2U_GFX_TitleScreenCharacters,SMB2U_GFX_TitleScreenCharactersEnd
	dl $19A000,$19A800,SMB2U_GFX_TitleScreenLogo,SMB2U_GFX_TitleScreenLogoEnd
	dl $17C800,$17D000,SMB2U_GFX_UnusedCharacterSelectCharacterTiles,SMB2U_GFX_UnusedCharacterSelectCharacterTilesEnd
	dl $1D8800,$1D9000,SMB2U_GFX_WarpZoneTiles,SMB2U_GFX_WarpZoneTilesEnd
SMB2U_GFXPointersEnd:

;--------------------------------------------------------------------

SMB2U_MusicPointersStart:
	dl $1FD52D,$1FD8F9,SMB2U_Music_CharacterSelect,SMB2U_Music_CharacterSelectEnd
	dl $1FDA63,$1FDB9E,SMB2U_Music_Danger,SMB2U_Music_DangerEnd
	dl $1FCA75,$1FCADD,SMB2U_Music_Death,SMB2U_Music_DeathEnd
	dl $1FC365,$1FCA61,SMB2U_Music_Ending,SMB2U_Music_EndingEnd
	dl $1FC1BA,$1FC212,SMB2U_Music_Fanfare,SMB2U_Music_FanfareEnd
	dl $1FCAF1,$1FCB67,SMB2U_Music_GameOver,SMB2U_Music_GameOverEnd
	dl $1FEB6F,$1FECD2,SMB2U_Music_HaveStar,SMB2U_Music_HaveStarEnd
	dl $1FCCC9,$1FD4A7,SMB2U_Music_Overworld,SMB2U_Music_OverworldEnd
	dl $1FDC2E,$1FE2B9,SMB2U_Music_Subspace,SMB2U_Music_SubspaceEnd
	dl $1FE5C2,$1FEAAD,SMB2U_Music_TitleScreen,SMB2U_Music_TitleScreenEnd
	dl $1FD923,$1FDA39,SMB2U_Music_Underground,SMB2U_Music_UndergroundEnd
	dl $1FEAC1,$1FEB57,SMB2U_Music_UnusedFanfare,SMB2U_Music_UnusedFanfareEnd
	dl $1FC03E,$1FC1A6,SMB2U_Music_WarpZone,SMB2U_Music_WarpZoneEnd
	dl $1FE2E3,$1FE58A,SMB2U_Music_WartBattle,SMB2U_Music_WartBattleEnd
	dl $1FCB7B,$1FCC43,SMB2U_Music_WonSlots,SMB2U_Music_WonSlotsEnd
	dl $1FC226,$1FC305,SMB2U_Music_WorldClear,SMB2U_Music_WorldClearEnd
SMB2U_MusicPointersEnd:

;--------------------------------------------------------------------

SMB3_BGGFXPointersStart:
	dl $2D8000,$2D8800,SMB3_GFX_BG_Fortress1,SMB3_GFX_BG_Fortress1End
	dl $2D8800,$2D9000,SMB3_GFX_BG_Fortress2,SMB3_GFX_BG_Fortress2End
	dl $2D9000,$2D9800,SMB3_GFX_BG_SnowTrees1,SMB3_GFX_BG_SnowTrees1End
	dl $2D9800,$2DA000,SMB3_GFX_BG_SnowTrees2,SMB3_GFX_BG_SnowTrees2End
	dl $2DA000,$2DA800,SMB3_GFX_BG_Pipes1,SMB3_GFX_BG_Pipes1End
	dl $2DA800,$2DB000,SMB3_GFX_BG_Pipes2,SMB3_GFX_BG_Pipes2End
	dl $2DB000,$2DB800,SMB3_GFX_BG_CastleWall,SMB3_GFX_BG_CastleWallEnd
	dl $2DB800,$2DC000,SMB3_GFX_BG_HillsAndTrees,SMB3_GFX_BG_HillsAndTreesEnd
	dl $2DC000,$2DC800,SMB3_GFX_BG_DottedHills1,SMB3_GFX_BG_DottedHills1End
	dl $2DC800,$2DD000,SMB3_GFX_BG_DottedHills2,SMB3_GFX_BG_DottedHills2End
	dl $2DD000,$2DD800,SMB3_GFX_BG_Desert1,SMB3_GFX_BG_Desert1End
	dl $2DD800,$2DE000,SMB3_GFX_BG_Desert2,SMB3_GFX_BG_Desert2End
	dl $2DE000,$2DE800,SMB3_GFX_BG_CheckeredHills1,SMB3_GFX_BG_CheckeredHills1End
	dl $2DE800,$2DF000,SMB3_GFX_BG_CheckeredHills2,SMB3_GFX_BG_CheckeredHills2End
	dl $2DF000,$2DF800,SMB3_GFX_BG_SnowyCheckeredHills1,SMB3_GFX_BG_SnowyCheckeredHills1End
	dl $2DF800,$2E8000,SMB3_GFX_BG_SnowyCheckeredHills2,SMB3_GFX_BG_SnowyCheckeredHills2End
	dl $3AB000,$3AB800,SMB3_GFX_BG_ToadHouse_SMASU,SMB3_GFX_BG_ToadHouse_SMASUEnd
	dl $3AB000,$3AB800,SMB3_GFX_BG_ToadHouse_USA,SMB3_GFX_BG_ToadHouse_USAEnd
	dl $3AB800,$3AC000,SMB3_GFX_BG_TitleScreen,SMB3_GFX_BG_TitleScreenEnd
	dl $3AC000,$3AC800,SMB3_GFX_BG_Underwater1,SMB3_GFX_BG_Underwater1End
	dl $3AC800,$3AD000,SMB3_GFX_BG_Underwater2,SMB3_GFX_BG_Underwater2End
	dl $3AD000,$3AD800,SMB3_GFX_BG_StormClouds,SMB3_GFX_BG_StormCloudsEnd
	dl $3AD800,$3AE000,SMB3_GFX_BG_AirshipInterior,SMB3_GFX_BG_AirshipInteriorEnd
	dl $3AE000,$3AE800,SMB3_GFX_BG_ConstructedPlain,SMB3_GFX_BG_ConstructedPlainEnd
	dl $3AE800,$3AF000,SMB3_GFX_BG_BonusRoom,SMB3_GFX_BG_BonusRoomEnd
	dl $3AF000,$3AF800,SMB3_GFX_BG_CavePillar1,SMB3_GFX_BG_CavePillar1End
	dl $3AF800,$3B8000,SMB3_GFX_BG_CavePillar2,SMB3_GFX_BG_CavePillar2End
if !ROMVer&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	dl $30B000,$30B800,SMB3_GFX_BG_Prison,SMB3_GFX_BG_PrisonEnd
	dl $30B800,$30C000,SMB3_GFX_BG_BattleMode,SMB3_GFX_BG_BattleModeEnd
	dl $31F000,$31F800,SMB3_GFX_BG_Volcano1,SMB3_GFX_BG_Volcano1End
	dl $31F800,$328000,SMB3_GFX_BG_Volcano2,SMB3_GFX_BG_Volcano2End
	dl $329000,$329800,SMB3_GFX_BG_PeachsRoom1,SMB3_GFX_BG_PeachsRoom1End
	dl $329800,$32A000,SMB3_GFX_BG_PeachsRoom2,SMB3_GFX_BG_PeachsRoom2End
	dl $32B000,$32B800,SMB3_GFX_BG_Clouds,SMB3_GFX_BG_CloudsEnd
	dl $339000,$339800,SMB3_GFX_BG_CrystalCave,SMB3_GFX_BG_CrystalCaveEnd
	dl $33D000,$33D800,SMB3_GFX_BG_WaterfallCliff,SMB3_GFX_BG_WaterfallCliffEnd
	dl $34C000,$34C800,SMB3_GFX_BG_BowsersCastle1,SMB3_GFX_BG_BowsersCastle1End
	dl $34C800,$34D000,SMB3_GFX_BG_BowsersCastle2,SMB3_GFX_BG_BowsersCastle2End
	dl $35A000,$35A800,SMB3_GFX_BG_Leaves1,SMB3_GFX_BG_Leaves1End
	dl $35A800,$35B000,SMB3_GFX_BG_Leaves2,SMB3_GFX_BG_Leaves2End
else
	dl $40B000,$40B800,SMB3_GFX_BG_Prison,SMB3_GFX_BG_PrisonEnd
	dl $40B800,$40C000,SMB3_GFX_BG_BattleMode,SMB3_GFX_BG_BattleModeEnd
	dl $41F000,$41F800,SMB3_GFX_BG_Volcano1,SMB3_GFX_BG_Volcano1End
	dl $41F800,$428000,SMB3_GFX_BG_Volcano2,SMB3_GFX_BG_Volcano2End
	dl $429000,$429800,SMB3_GFX_BG_PeachsRoom1,SMB3_GFX_BG_PeachsRoom1End
	dl $429800,$42A000,SMB3_GFX_BG_PeachsRoom2,SMB3_GFX_BG_PeachsRoom2End
	dl $42B000,$42B800,SMB3_GFX_BG_Clouds,SMB3_GFX_BG_CloudsEnd
	dl $439000,$439800,SMB3_GFX_BG_CrystalCave,SMB3_GFX_BG_CrystalCaveEnd
	dl $43D000,$43D800,SMB3_GFX_BG_WaterfallCliff,SMB3_GFX_BG_WaterfallCliffEnd
	dl $44C000,$44C800,SMB3_GFX_BG_BowsersCastle1,SMB3_GFX_BG_BowsersCastle1End
	dl $44C800,$44D000,SMB3_GFX_BG_BowsersCastle2,SMB3_GFX_BG_BowsersCastle2End
	dl $45A000,$45A800,SMB3_GFX_BG_Leaves1,SMB3_GFX_BG_Leaves1End
	dl $45A800,$45B000,SMB3_GFX_BG_Leaves2,SMB3_GFX_BG_Leaves2End
endif
SMB3_BGGFXPointersEnd:

;--------------------------------------------------------------------

SMB3_GFXPointersStart:
	dl $0CD000,$0CF800,SMB3_GFX_WorldRollcallSpritesAndMario,SMB3_GFX_WorldRollcallSpritesAndMarioEnd
	dl $2E8000,$2EA000,SMB3_GFX_Luigi_Raccoon,SMB3_GFX_Luigi_RaccoonEnd
	dl $2EA000,$2EC000,SMB3_GFX_Luigi_Tanooki,SMB3_GFX_Luigi_TanookiEnd
	dl $2EC000,$2EE000,SMB3_GFX_Luigi_Hammer,SMB3_GFX_Luigi_HammerEnd
	dl $2EE000,$2F8000,SMB3_GFX_Luigi_SmallAndFrog,SMB3_GFX_Luigi_SmallAndFrogEnd
	dl $388000,$389000,SMB3_GFX_Layer3_Letters,SMB3_GFX_Layer3_LettersEnd
	dl $389000,$389800,SMB3_GFX_Layer3_Water,SMB3_GFX_Layer3_WaterEnd
	dl $38A000,$38A400,SMB3_GFX_Layer3_Clouds,SMB3_GFX_Layer3_CloudsEnd
	dl $38A400,$38A800,SMB3_GFX_Layer3_Pillars,SMB3_GFX_Layer3_PillarsEnd
	dl $38A800,$38AC00,SMB3_GFX_Layer3_Cave,SMB3_GFX_Layer3_CaveEnd
	dl $38AC00,$38B000,SMB3_GFX_Layer3_AirshipClouds,SMB3_GFX_Layer3_AirshipCloudsEnd
	dl $38C000,$398000,SMB3_GFX_Sprite_Overworld,SMB3_GFX_Sprite_OverworldEnd
	dl $398000,$39C000,SMB3_GFX_Sprite_ThroneRoom,SMB3_GFX_Sprite_ThroneRoomEnd
	dl $39C000,$39D000,SMB3_GFX_FG_AnimatedOverworldTiles5,SMB3_GFX_FG_AnimatedOverworldTiles5End
	dl $39D000,$39E000,SMB3_GFX_FG_AnimatedOverworldTiles6,SMB3_GFX_FG_AnimatedOverworldTiles6End
	dl $39E000,$39F000,SMB3_GFX_FG_AnimatedOverworldTiles7,SMB3_GFX_FG_AnimatedOverworldTiles7End
	dl $39F000,$3A8000,SMB3_GFX_FG_AnimatedOverworldTiles8,SMB3_GFX_FG_AnimatedOverworldTiles8End
	dl $3A8000,$3A9000,SMB3_GFX_FG_SpadeGamePowerUps4,SMB3_GFX_FG_SpadeGamePowerUps4End
	dl $3A9000,$3A9800,SMB3_GFX_FG_SkyPlain2,SMB3_GFX_FG_SkyPlain2End
	dl $3A9800,$3AA000,SMB3_GFX_FG_GrassPlain2,SMB3_GFX_FG_GrassPlain2End
	dl $3AA000,$3AA800,SMB3_GFX_FG_Cave2,SMB3_GFX_FG_Cave2End
	dl $3AA800,$3AB000,SMB3_GFX_FG_EndOfLevelDecor,SMB3_GFX_FG_EndOfLevelDecorEnd
	dl $3D8000,$3DA000,SMB3_GFX_BattleModePlayer,SMB3_GFX_BattleModePlayerEnd
	dl $3DA000,$3DA800,SMB3_GFX_Sprite_BattleMode2,SMB3_GFX_Sprite_BattleMode2End
	dl $3DB000,$3DC000,SMB3_GFX_UnusedSMWKoopa,SMB3_GFX_UnusedSMWKoopaEnd
	dl $3DE000,$3DF800,SMB3_GFX_WorldRollcallSpritesAndLuigi,SMB3_GFX_WorldRollcallSpritesAndLuigiEnd
	dl $3E8000,$3EA000,SMB3_GFX_Mario_Raccoon,SMB3_GFX_Mario_RaccoonEnd
	dl $3EA000,$3EC000,SMB3_GFX_Mario_Tanooki,SMB3_GFX_Mario_TanookiEnd
	dl $3EC000,$3EE000,SMB3_GFX_Mario_Hammer,SMB3_GFX_Mario_HammerEnd
	dl $3EE000,$3F8000,SMB3_GFX_Mario_SmallAndFrog,SMB3_GFX_Mario_SmallAndFrogEnd
	dl $3F8000,$3FA000,SMB3_GFX_Mario_Big,SMB3_GFX_Mario_BigEnd
	dl $3FA000,$3FB000,SMB3_GFX_Sprite_TitleScreen2,SMB3_GFX_Sprite_TitleScreen2End
	dl $3FB000,$3FB800,SMB3_GFX_Sprite_Global1,SMB3_GFX_Sprite_Global1End
	dl $3FB800,$3FC000,SMB3_GFX_Sprite_Global3,SMB3_GFX_Sprite_Global3End
	dl $3FC000,$3FE000,SMB3_GFX_Luigi_Big,SMB3_GFX_Luigi_BigEnd
	dl $3FE000,$408000,SMB3_GFX_Sprite_BattleMode1,SMB3_GFX_Sprite_BattleMode1End
if !ROMVer&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	dl $308000,$308800,SMB3_GFX_Sprite_AirshipSprites1,SMB3_GFX_Sprite_AirshipSprites1End
	dl $308800,$309000,SMB3_GFX_Sprite_AirshipSprites2,SMB3_GFX_Sprite_AirshipSprites2End
	dl $309000,$309800,SMB3_GFX_Sprite_AirshipSprites3,SMB3_GFX_Sprite_AirshipSprites3End
	dl $309800,$30A000,SMB3_GFX_Sprite_DesertEnemies,SMB3_GFX_Sprite_DesertEnemiesEnd
	dl $30A000,$30A800,SMB3_GFX_Sprite_Global2,SMB3_GFX_Sprite_Global2End
	dl $30A800,$30B000,SMB3_GFX_Sprite_ChestItems,SMB3_GFX_Sprite_ChestItemsEnd
	dl $30C000,$30D000,SMB3_GFX_FG_ConstructedPlains,SMB3_GFX_FG_ConstructedPlainsEnd
	dl $30D000,$30D800,SMB3_GFX_Sprite_SpikeAndMunchers,SMB3_GFX_Sprite_SpikeAndMunchersEnd
	dl $30D800,$30E000,SMB3_GFX_Sprite_LakituSpinyAndBuzzyBeetle,SMB3_GFX_Sprite_LakituSpinyAndBuzzyBeetleEnd
	dl $30E000,$30F000,SMB3_GFX_FG_SkyPlain1,SMB3_GFX_FG_SkyPlain1End
	dl $30F000,$30F800,SMB3_GFX_Sprite_SkySprites,SMB3_GFX_Sprite_SkySpritesEnd
	dl $30F800,$318000,SMB3_GFX_Sprite_Empty2,SMB3_GFX_Sprite_Empty2End
	dl $318000,$319000,SMB3_GFX_FG_Fortress,SMB3_GFX_FG_FortressEnd
	dl $319000,$319800,SMB3_GFX_Sprite_Fortress1,SMB3_GFX_Sprite_Fortress1End
	dl $319800,$31A000,SMB3_GFX_Sprite_Fortress2,SMB3_GFX_Sprite_Fortress2End
	dl $31A000,$31B000,SMB3_GFX_FG_AnimatedOverworldTiles1,SMB3_GFX_FG_AnimatedOverworldTiles1End
	dl $31B000,$31C000,SMB3_GFX_FG_StaticOverworldTiles,SMB3_GFX_FG_StaticOverworldTilesEnd
	dl $31C000,$31D000,SMB3_GFX_FG_SnowAndIce,SMB3_GFX_FG_SnowAndIceEnd
	dl $31D000,$31D800,SMB3_GFX_Sprite_UnderwaterEnemies,SMB3_GFX_Sprite_UnderwaterEnemiesEnd
	dl $31D800,$31E000,SMB3_GFX_Sprite_LavaLotus,SMB3_GFX_Sprite_LavaLotusEnd
	dl $31E000,$31F000,SMB3_GFX_FG_Cave1,SMB3_GFX_FG_Cave1End
	dl $328000,$328800,SMB3_GFX_FG_MinigameIntroLuigi,SMB3_GFX_FG_MinigameIntroLuigiEnd
	dl $328800,$329000,SMB3_GFX_FG_Bowser,SMB3_GFX_FG_BowserEnd
	dl $32A000,$32B000,SMB3_GFX_FG_MinigameIntro,SMB3_GFX_FG_MinigameIntroEnd
	dl $32B800,$32C000,SMB3_GFX_FG_StandardTiles,SMB3_GFX_FG_StandardTilesEnd
	dl $32C000,$32D000,SMB3_GFX_FG_ThroneRoom,SMB3_GFX_FG_ThroneRoomEnd
	dl $32D000,$32D800,SMB3_GFX_Sprite_DynamicDoorAndLetters,SMB3_GFX_Sprite_DynamicDoorAndLettersEnd
	dl $32D800,$32E000,SMB3_GFX_Sprite_MiniGameHost,SMB3_GFX_Sprite_MiniGameHostEnd
	dl $32E000,$32F000,SMB3_GFX_FG_SpadeGamePowerUps1,SMB3_GFX_FG_SpadeGamePowerUps1End
	dl $32F000,$32F800,SMB3_GFX_FG_SpadeGamePowerUps2,SMB3_GFX_FG_SpadeGamePowerUps2End
	dl $32F800,$338000,SMB3_GFX_FG_SpadeGamePowerUps3,SMB3_GFX_FG_SpadeGamePowerUps3End
	dl $338000,$338800,SMB3_GFX_FG_Desert1,SMB3_GFX_FG_Desert1End
	dl $338800,$339000,SMB3_GFX_FG_Desert2,SMB3_GFX_FG_Desert2End
	dl $339800,$33A000,SMB3_GFX_Sprite_BoomBoom,SMB3_GFX_Sprite_BoomBoomEnd
	dl $33A000,$33A800,SMB3_GFX_FG_Airship1,SMB3_GFX_FG_Airship1End
	dl $33A800,$33B000,SMB3_GFX_FG_Airship2,SMB3_GFX_FG_Airship2End
	dl $33B000,$33C000,SMB3_GFX_FG_PeachLetterFont,SMB3_GFX_FG_PeachLetterFontEnd
	dl $33C000,$33C800,SMB3_GFX_FG_Cloud1,SMB3_GFX_FG_Cloud1End
	dl $33C800,$33D000,SMB3_GFX_FG_Cloud2,SMB3_GFX_FG_Cloud2End
	dl $33D800,$33E000,SMB3_GFX_FG_AnimatedStripeNSpadeTiles,SMB3_GFX_FG_AnimatedStripeNSpadeTilesEnd
	dl $33E000,$33E800,SMB3_GFX_Sprite_AltGlobal2,SMB3_GFX_Sprite_AltGlobal2End
	dl $33E800,$33F000,SMB3_GFX_Sprite_GiantEnemies,SMB3_GFX_Sprite_GiantEnemiesEnd
	dl $33F000,$348000,SMB3_GFX_FG_AnimatedLevelTiles1,SMB3_GFX_FG_AnimatedLevelTiles1End
	dl $348000,$348800,SMB3_GFX_Sprite_KoopaKids1,SMB3_GFX_Sprite_KoopaKids1End
	dl $348800,$349000,SMB3_GFX_Sprite_KoopaKids2,SMB3_GFX_Sprite_KoopaKids2End
	dl $349000,$349800,SMB3_GFX_Sprite_KoopaKids3,SMB3_GFX_Sprite_KoopaKids3End
	dl $349800,$34A000,SMB3_GFX_Sprite_KoopaKids4,SMB3_GFX_Sprite_KoopaKids4End
	dl $34A000,$34A800,SMB3_GFX_Sprite_BossBass,SMB3_GFX_Sprite_BossBassEnd
	dl $34A800,$34C000,SMB3_GFX_FG_BattleMode1,SMB3_GFX_FG_BattleMode1End
	dl $34D000,$34D800,SMB3_GFX_FG_BattleMode2,SMB3_GFX_FG_BattleMode2End
	dl $34D800,$34E000,SMB3_GFX_Sprite_KoopaKidsShell,SMB3_GFX_Sprite_KoopaKidsShellEnd
	dl $34E000,$34E800,SMB3_GFX_Sprite_GiantBlocks,SMB3_GFX_Sprite_GiantBlocksEnd
	dl $34E800,$34F000,SMB3_GFX_Sprite_FlyingBoomBoom,SMB3_GFX_Sprite_FlyingBoomBoomEnd
	dl $34F000,$34F800,SMB3_GFX_Sprite_BroEnemies,SMB3_GFX_Sprite_BroEnemiesEnd
	dl $34F800,$358000,SMB3_GFX_Sprite_StandardEnemies,SMB3_GFX_Sprite_StandardEnemiesEnd
	dl $358000,$358800,SMB3_GFX_Sprite_Bowser1,SMB3_GFX_Sprite_Bowser1End
	dl $358800,$359000,SMB3_GFX_Sprite_Bowser2,SMB3_GFX_Sprite_Bowser2End
	dl $359000,$359800,SMB3_GFX_Sprite_Bowser3,SMB3_GFX_Sprite_Bowser3End
	dl $359800,$35A000,SMB3_GFX_Sprite_AltStandardEnemies,SMB3_GFX_Sprite_AltStandardEnemiesEnd
	dl $35B000,$35C000,SMB3_GFX_StatusBar,SMB3_GFX_StatusBarEnd
	dl $35C000,$35D000,SMB3_GFX_FG_Pipe,SMB3_GFX_FG_PipeEnd
	dl $35D000,$35D800,SMB3_GFX_Sprite_Pipe,SMB3_GFX_Sprite_PipeEnd
	dl $35D800,$35E000,SMB3_GFX_Sprite_CopyOfMiniGameHost,SMB3_GFX_Sprite_CopyOfMiniGameHostEnd
	dl $35E000,$35F000,SMB3_GFX_FG_ToadHouse1,SMB3_GFX_FG_ToadHouse1End
	dl $35F000,$35F800,SMB3_GFX_FG_ToadHouse2,SMB3_GFX_FG_ToadHouse2End
	dl $35F800,$368000,SMB3_GFX_Sprite_Empty1,SMB3_GFX_Sprite_Empty1End
	dl $368000,$369000,SMB3_GFX_FG_AnimatedLevelTiles2,SMB3_GFX_FG_AnimatedLevelTiles2End
	dl $369000,$36A000,SMB3_GFX_FG_AnimatedLevelTiles3,SMB3_GFX_FG_AnimatedLevelTiles3End
	dl $36A000,$36B000,SMB3_GFX_FG_AnimatedLevelTiles4,SMB3_GFX_FG_AnimatedLevelTiles4End
	dl $36B000,$36C000,SMB3_GFX_FG_AnimatedLevelTiles5,SMB3_GFX_FG_AnimatedLevelTiles5End
	dl $36C000,$36D000,SMB3_GFX_FG_GrassyConstructedPlains,SMB3_GFX_FG_GrassyConstructedPlainsEnd
	dl $36D000,$36D800,SMB3_GFX_FG_Airship3,SMB3_GFX_FG_Airship3End
	dl $36D800,$36E000,SMB3_GFX_FG_Airship4,SMB3_GFX_FG_Airship4End
	dl $36E000,$36F000,SMB3_GFX_FG_GrassPlain1,SMB3_GFX_FG_GrassPlain1End
	dl $36F000,$36F800,SMB3_GFX_FG_Giant1,SMB3_GFX_FG_Giant1End
	dl $36F800,$378000,SMB3_GFX_FG_Giant2,SMB3_GFX_FG_Giant2End
	dl $378000,$379000,SMB3_GFX_FG_AnimatedOverworldTiles2,SMB3_GFX_FG_AnimatedOverworldTiles2End
	dl $379000,$37A000,SMB3_GFX_FG_AnimatedOverworldTiles3,SMB3_GFX_FG_AnimatedOverworldTiles3End
	dl $37A000,$37B000,SMB3_GFX_FG_AnimatedOverworldTiles4,SMB3_GFX_FG_AnimatedOverworldTiles4End
	dl $37B000,$37C000,SMB3_GFX_UnknownEndingGraphics,SMB3_GFX_UnknownEndingGraphicsEnd
	dl $37C000,$37E000,SMB3_GFX_TitleScreen_SMASU,SMB3_GFX_TitleScreen_SMASUEnd
	dl $37C000,$37E000,SMB3_GFX_TitleScreen_USA,SMB3_GFX_TitleScreen_USAEnd
	dl $37E000,$37F000,SMB3_GFX_FG_WorldRollCallMiniMap,SMB3_GFX_FG_WorldRollCallMiniMapEnd
	dl $37F000,$37F800,SMB3_GFX_Sprite_LoadingLetters,SMB3_GFX_Sprite_LoadingLettersEnd
	dl $37F800,$388000,SMB3_GFX_Sprite_TitleScreen1,SMB3_GFX_Sprite_TitleScreen1End
else
	dl $408000,$408800,SMB3_GFX_Sprite_AirshipSprites1,SMB3_GFX_Sprite_AirshipSprites1End
	dl $408800,$409000,SMB3_GFX_Sprite_AirshipSprites2,SMB3_GFX_Sprite_AirshipSprites2End
	dl $409000,$409800,SMB3_GFX_Sprite_AirshipSprites3,SMB3_GFX_Sprite_AirshipSprites3End
	dl $409800,$40A000,SMB3_GFX_Sprite_DesertEnemies,SMB3_GFX_Sprite_DesertEnemiesEnd
	dl $40A000,$40A800,SMB3_GFX_Sprite_Global2,SMB3_GFX_Sprite_Global2End
	dl $40A800,$40B000,SMB3_GFX_Sprite_ChestItems,SMB3_GFX_Sprite_ChestItemsEnd
	dl $40C000,$40D000,SMB3_GFX_FG_ConstructedPlains,SMB3_GFX_FG_ConstructedPlainsEnd
	dl $40D000,$40D800,SMB3_GFX_Sprite_SpikeAndMunchers,SMB3_GFX_Sprite_SpikeAndMunchersEnd
	dl $40D800,$40E000,SMB3_GFX_Sprite_LakituSpinyAndBuzzyBeetle,SMB3_GFX_Sprite_LakituSpinyAndBuzzyBeetleEnd
	dl $40E000,$40F000,SMB3_GFX_FG_SkyPlain1,SMB3_GFX_FG_SkyPlain1End
	dl $40F000,$40F800,SMB3_GFX_Sprite_SkySprites,SMB3_GFX_Sprite_SkySpritesEnd
	dl $40F800,$418000,SMB3_GFX_Sprite_Empty2,SMB3_GFX_Sprite_Empty2End
	dl $418000,$419000,SMB3_GFX_FG_Fortress,SMB3_GFX_FG_FortressEnd
	dl $419000,$419800,SMB3_GFX_Sprite_Fortress1,SMB3_GFX_Sprite_Fortress1End
	dl $419800,$41A000,SMB3_GFX_Sprite_Fortress2,SMB3_GFX_Sprite_Fortress2End
	dl $41A000,$41B000,SMB3_GFX_FG_AnimatedOverworldTiles1,SMB3_GFX_FG_AnimatedOverworldTiles1End
	dl $41B000,$41C000,SMB3_GFX_FG_StaticOverworldTiles,SMB3_GFX_FG_StaticOverworldTilesEnd
	dl $41C000,$41D000,SMB3_GFX_FG_SnowAndIce,SMB3_GFX_FG_SnowAndIceEnd
	dl $41D000,$41D800,SMB3_GFX_Sprite_UnderwaterEnemies,SMB3_GFX_Sprite_UnderwaterEnemiesEnd
	dl $41D800,$41E000,SMB3_GFX_Sprite_LavaLotus,SMB3_GFX_Sprite_LavaLotusEnd
	dl $41E000,$41F000,SMB3_GFX_FG_Cave1,SMB3_GFX_FG_Cave1End
	dl $428000,$428800,SMB3_GFX_FG_MinigameIntroLuigi,SMB3_GFX_FG_MinigameIntroLuigiEnd
	dl $428800,$429000,SMB3_GFX_FG_Bowser,SMB3_GFX_FG_BowserEnd
	dl $42A000,$42B000,SMB3_GFX_FG_MinigameIntro,SMB3_GFX_FG_MinigameIntroEnd
	dl $42B800,$42C000,SMB3_GFX_FG_StandardTiles,SMB3_GFX_FG_StandardTilesEnd
	dl $42C000,$42D000,SMB3_GFX_FG_ThroneRoom,SMB3_GFX_FG_ThroneRoomEnd
	dl $42D000,$42D800,SMB3_GFX_Sprite_DynamicDoorAndLetters,SMB3_GFX_Sprite_DynamicDoorAndLettersEnd
	dl $42D800,$42E000,SMB3_GFX_Sprite_MiniGameHost,SMB3_GFX_Sprite_MiniGameHostEnd
	dl $42E000,$42F000,SMB3_GFX_FG_SpadeGamePowerUps1,SMB3_GFX_FG_SpadeGamePowerUps1End
	dl $42F000,$42F800,SMB3_GFX_FG_SpadeGamePowerUps2,SMB3_GFX_FG_SpadeGamePowerUps2End
	dl $42F800,$438000,SMB3_GFX_FG_SpadeGamePowerUps3,SMB3_GFX_FG_SpadeGamePowerUps3End
	dl $438000,$438800,SMB3_GFX_FG_Desert1,SMB3_GFX_FG_Desert1End
	dl $438800,$439000,SMB3_GFX_FG_Desert2,SMB3_GFX_FG_Desert2End
	dl $439800,$43A000,SMB3_GFX_Sprite_BoomBoom,SMB3_GFX_Sprite_BoomBoomEnd
	dl $43A000,$43A800,SMB3_GFX_FG_Airship1,SMB3_GFX_FG_Airship1End
	dl $43A800,$43B000,SMB3_GFX_FG_Airship2,SMB3_GFX_FG_Airship2End
	dl $43B000,$43C000,SMB3_GFX_FG_PeachLetterFont,SMB3_GFX_FG_PeachLetterFontEnd
	dl $43C000,$43C800,SMB3_GFX_FG_Cloud1,SMB3_GFX_FG_Cloud1End
	dl $43C800,$43D000,SMB3_GFX_FG_Cloud2,SMB3_GFX_FG_Cloud2End
	dl $43D800,$43E000,SMB3_GFX_FG_AnimatedStripeNSpadeTiles,SMB3_GFX_FG_AnimatedStripeNSpadeTilesEnd
	dl $43E000,$43E800,SMB3_GFX_Sprite_AltGlobal2,SMB3_GFX_Sprite_AltGlobal2End
	dl $43E800,$43F000,SMB3_GFX_Sprite_GiantEnemies,SMB3_GFX_Sprite_GiantEnemiesEnd
	dl $43F000,$448000,SMB3_GFX_FG_AnimatedLevelTiles1,SMB3_GFX_FG_AnimatedLevelTiles1End
	dl $448000,$448800,SMB3_GFX_Sprite_KoopaKids1,SMB3_GFX_Sprite_KoopaKids1End
	dl $448800,$449000,SMB3_GFX_Sprite_KoopaKids2,SMB3_GFX_Sprite_KoopaKids2End
	dl $449000,$449800,SMB3_GFX_Sprite_KoopaKids3,SMB3_GFX_Sprite_KoopaKids3End
	dl $449800,$44A000,SMB3_GFX_Sprite_KoopaKids4,SMB3_GFX_Sprite_KoopaKids4End
	dl $44A000,$44A800,SMB3_GFX_Sprite_BossBass,SMB3_GFX_Sprite_BossBassEnd
	dl $44A800,$44C000,SMB3_GFX_FG_BattleMode1,SMB3_GFX_FG_BattleMode1End
	dl $44D000,$44D800,SMB3_GFX_FG_BattleMode2,SMB3_GFX_FG_BattleMode2End
	dl $44D800,$44E000,SMB3_GFX_Sprite_KoopaKidsShell,SMB3_GFX_Sprite_KoopaKidsShellEnd
	dl $44E000,$44E800,SMB3_GFX_Sprite_GiantBlocks,SMB3_GFX_Sprite_GiantBlocksEnd
	dl $44E800,$44F000,SMB3_GFX_Sprite_FlyingBoomBoom,SMB3_GFX_Sprite_FlyingBoomBoomEnd
	dl $44F000,$44F800,SMB3_GFX_Sprite_BroEnemies,SMB3_GFX_Sprite_BroEnemiesEnd
	dl $44F800,$458000,SMB3_GFX_Sprite_StandardEnemies,SMB3_GFX_Sprite_StandardEnemiesEnd
	dl $458000,$458800,SMB3_GFX_Sprite_Bowser1,SMB3_GFX_Sprite_Bowser1End
	dl $458800,$459000,SMB3_GFX_Sprite_Bowser2,SMB3_GFX_Sprite_Bowser2End
	dl $459000,$459800,SMB3_GFX_Sprite_Bowser3,SMB3_GFX_Sprite_Bowser3End
	dl $459800,$45A000,SMB3_GFX_Sprite_AltStandardEnemies,SMB3_GFX_Sprite_AltStandardEnemiesEnd
	dl $45B000,$45C000,SMB3_GFX_StatusBar,SMB3_GFX_StatusBarEnd
	dl $45C000,$45D000,SMB3_GFX_FG_Pipe,SMB3_GFX_FG_PipeEnd
	dl $45D000,$45D800,SMB3_GFX_Sprite_Pipe,SMB3_GFX_Sprite_PipeEnd
	dl $45D800,$45E000,SMB3_GFX_Sprite_CopyOfMiniGameHost,SMB3_GFX_Sprite_CopyOfMiniGameHostEnd
	dl $45E000,$45F000,SMB3_GFX_FG_ToadHouse1,SMB3_GFX_FG_ToadHouse1End
	dl $45F000,$45F800,SMB3_GFX_FG_ToadHouse2,SMB3_GFX_FG_ToadHouse2End
	dl $45F800,$468000,SMB3_GFX_Sprite_Empty1,SMB3_GFX_Sprite_Empty1End
	dl $468000,$469000,SMB3_GFX_FG_AnimatedLevelTiles2,SMB3_GFX_FG_AnimatedLevelTiles2End
	dl $469000,$46A000,SMB3_GFX_FG_AnimatedLevelTiles3,SMB3_GFX_FG_AnimatedLevelTiles3End
	dl $46A000,$46B000,SMB3_GFX_FG_AnimatedLevelTiles4,SMB3_GFX_FG_AnimatedLevelTiles4End
	dl $46B000,$46C000,SMB3_GFX_FG_AnimatedLevelTiles5,SMB3_GFX_FG_AnimatedLevelTiles5End
	dl $46C000,$46D000,SMB3_GFX_FG_GrassyConstructedPlains,SMB3_GFX_FG_GrassyConstructedPlainsEnd
	dl $46D000,$46D800,SMB3_GFX_FG_Airship3,SMB3_GFX_FG_Airship3End
	dl $46D800,$46E000,SMB3_GFX_FG_Airship4,SMB3_GFX_FG_Airship4End
	dl $46E000,$46F000,SMB3_GFX_FG_GrassPlain1,SMB3_GFX_FG_GrassPlain1End
	dl $46F000,$46F800,SMB3_GFX_FG_Giant1,SMB3_GFX_FG_Giant1End
	dl $46F800,$478000,SMB3_GFX_FG_Giant2,SMB3_GFX_FG_Giant2End
	dl $478000,$479000,SMB3_GFX_FG_AnimatedOverworldTiles2,SMB3_GFX_FG_AnimatedOverworldTiles2End
	dl $479000,$47A000,SMB3_GFX_FG_AnimatedOverworldTiles3,SMB3_GFX_FG_AnimatedOverworldTiles3End
	dl $47A000,$47B000,SMB3_GFX_FG_AnimatedOverworldTiles4,SMB3_GFX_FG_AnimatedOverworldTiles4End
	dl $47B000,$47C000,SMB3_GFX_UnknownEndingGraphics,SMB3_GFX_UnknownEndingGraphicsEnd
	dl $47C000,$47E000,SMB3_GFX_TitleScreen_SMASU,SMB3_GFX_TitleScreen_SMASUEnd
	dl $47C000,$47E000,SMB3_GFX_TitleScreen_USA,SMB3_GFX_TitleScreen_USAEnd
	dl $47E000,$47F000,SMB3_GFX_FG_WorldRollCallMiniMap,SMB3_GFX_FG_WorldRollCallMiniMapEnd
	dl $47F000,$47F800,SMB3_GFX_Sprite_LoadingLetters,SMB3_GFX_Sprite_LoadingLettersEnd
	dl $47F800,$488000,SMB3_GFX_Sprite_TitleScreen1,SMB3_GFX_Sprite_TitleScreen1End
endif
SMB3_GFXPointersEnd:

;--------------------------------------------------------------------

SMB3_LevelMusicPointersStart:
	dl $0C9CDC,$0C9E58,SMB3_LevelMusic_Airship,SMB3_LevelMusic_AirshipEnd
	dl $0C8264,$0C86C9,SMB3_LevelMusic_Athletic,SMB3_LevelMusic_AthleticEnd
	dl $0CAFF7,$0CB302,SMB3_LevelMusic_BattleMode,SMB3_LevelMusic_BattleModeEnd
	dl $0CA4B0,$0CA82C,SMB3_LevelMusic_BossBattle,SMB3_LevelMusic_BossBattleEnd
	dl $0C8F3A,$0C9382,SMB3_LevelMusic_BowserBattle,SMB3_LevelMusic_BowserBattleEnd
	dl $0CA840,$0CA8E8,SMB3_LevelMusic_BowserFell,SMB3_LevelMusic_BowserFellEnd
	dl $0CB316,$0CB3B4,SMB3_LevelMusic_BowserLetter,SMB3_LevelMusic_BowserLetterEnd
	dl $0C805E,$0C8179,SMB3_LevelMusic_CloudBonusRoom,SMB3_LevelMusic_CloudBonusRoomEnd
	dl $0C97CF,$0C988C,SMB3_LevelMusic_Death,SMB3_LevelMusic_DeathEnd
	dl $0C9647,$0C97BB,SMB3_LevelMusic_Fortress,SMB3_LevelMusic_FortressEnd
	dl $0C98A0,$0C9909,SMB3_LevelMusic_GameOver,SMB3_LevelMusic_GameOverEnd
	dl $0CA160,$0CA472,SMB3_LevelMusic_HammerBroEncounter,SMB3_LevelMusic_HammerBroEncounterEnd
	dl $0C9A66,$0C9BC9,SMB3_LevelMusic_HaveStar,SMB3_LevelMusic_HaveStarEnd
	dl $0C8705,$0C8C04,SMB3_LevelMusic_Overworld,SMB3_LevelMusic_OverworldEnd
	dl $0C991D,$0C99C0,SMB3_LevelMusic_PassedBoss,SMB3_LevelMusic_PassedBossEnd
	dl $0C99D4,$0C9A4E,SMB3_LevelMusic_PassedLevel,SMB3_LevelMusic_PassedLevelEnd
	dl $0CB3C8,$0CB471,SMB3_LevelMusic_PeachLetter,SMB3_LevelMusic_PeachLetterEnd
	dl $0C9BF3,$0C9C9E,SMB3_LevelMusic_ThroneRoom,SMB3_LevelMusic_ThroneRoomEnd
	dl $0CA948,$0CAFCD,SMB3_LevelMusic_TitleScreen,SMB3_LevelMusic_TitleScreenEnd
	dl $0C9E96,$0C9FC9,SMB3_LevelMusic_ToadHouse,SMB3_LevelMusic_ToadHouseEnd
	dl $0C93BE,$0C9609,SMB3_LevelMusic_Underground,SMB3_LevelMusic_UndergroundEnd
	dl $0C8C54,$0C8EEC,SMB3_LevelMusic_Underwater,SMB3_LevelMusic_UnderwaterEnd
	dl $0C819F,$0C8228,SMB3_LevelMusic_Victory,SMB3_LevelMusic_VictoryEnd
	dl $0C9FDD,$0CA136,SMB3_LevelMusic_WorldClear,SMB3_LevelMusic_WorldClearEnd
SMB3_LevelMusicPointersEnd:

;--------------------------------------------------------------------

SMB3_OverworldMusicPointersStart:
	dl $07D19A,$07D2B5,SMB3_OverworldMusic_CloudBonusRoom,SMB3_OverworldMusic_CloudBonusRoomEnd
	dl $07D8DF,$07D946,SMB3_OverworldMusic_Minigame,SMB3_OverworldMusic_MinigameEnd
	dl $07D95E,$07DA73,SMB3_OverworldMusic_MusicBox,SMB3_OverworldMusic_MusicBoxEnd
	dl $07C1A9,$07C83A,SMB3_OverworldMusic_PeachRescued,SMB3_OverworldMusic_PeachRescuedEnd
	dl $07D794,$07D8C7,SMB3_OverworldMusic_ToadHouse,SMB3_OverworldMusic_ToadHouseEnd
	dl $07DAAF,$07DCFA,SMB3_OverworldMusic_Underground,SMB3_OverworldMusic_UndergroundEnd
	dl $07C04A,$07C0D3,SMB3_OverworldMusic_Victory,SMB3_OverworldMusic_VictoryEnd
	dl $07D606,$07D756,SMB3_OverworldMusic_WarpWhistle,SMB3_OverworldMusic_WarpWhistleEnd
	dl $07C876,$07CAFC,SMB3_OverworldMusic_World1,SMB3_OverworldMusic_World1End
	dl $07CB26,$07CC07,SMB3_OverworldMusic_World2,SMB3_OverworldMusic_World2End
	dl $07CC31,$07CE3B,SMB3_OverworldMusic_World3,SMB3_OverworldMusic_World3End
	dl $07CE65,$07D001,SMB3_OverworldMusic_World4,SMB3_OverworldMusic_World4End
	dl $07D02B,$07D170,SMB3_OverworldMusic_World5,SMB3_OverworldMusic_World5End
	dl $07D2DF,$07D3C1,SMB3_OverworldMusic_World6,SMB3_OverworldMusic_World6End
	dl $07D3EB,$07D500,SMB3_OverworldMusic_World7,SMB3_OverworldMusic_World7End
	dl $07D52A,$07D5CA,SMB3_OverworldMusic_World8,SMB3_OverworldMusic_World8End
SMB3_OverworldMusicPointersEnd:

;--------------------------------------------------------------------

SMW_CompressedGFXPointersStart:
if !ROMVer&(!ROM_SMASW_U|!ROM_SMASW_E) != $00
if !ROMVer&(!ROM_SMASW_E) != $00
	dl $4AD9FC,$4AE234,SMW_CompressedGFXFile00,SMW_CompressedGFXFile00End
	dl $4AE234,$4AECBF,SMW_CompressedGFXFile01,SMW_CompressedGFXFile01End
	dl $4AECBF,$4AF559,SMW_CompressedGFXFile02,SMW_CompressedGFXFile02End
	dl $4AF559,$4AFF8D,SMW_CompressedGFXFile03,SMW_CompressedGFXFile03End
	dl $4AFF8D,$4B8976,SMW_CompressedGFXFile04,SMW_CompressedGFXFile04End
	dl $4B8976,$4B9386,SMW_CompressedGFXFile05,SMW_CompressedGFXFile05End
	dl $4B9386,$4B9D28,SMW_CompressedGFXFile06,SMW_CompressedGFXFile06End
	dl $4B9D28,$4BA672,SMW_CompressedGFXFile07,SMW_CompressedGFXFile07End
	dl $4BA672,$4BAFBF,SMW_CompressedGFXFile08,SMW_CompressedGFXFile08End
	dl $4BAFBF,$4BBA33,SMW_CompressedGFXFile09,SMW_CompressedGFXFile09End
	dl $4BBA33,$4BC3B9,SMW_CompressedGFXFile0A,SMW_CompressedGFXFile0AEnd
	dl $4BC3B9,$4BCD80,SMW_CompressedGFXFile0B,SMW_CompressedGFXFile0BEnd
	dl $4BCD80,$4BD5F1,SMW_CompressedGFXFile0C,SMW_CompressedGFXFile0CEnd
	dl $4BD5F1,$4BDDE9,SMW_CompressedGFXFile0D,SMW_CompressedGFXFile0DEnd
	dl $4BDDE9,$4BE705,SMW_CompressedGFXFile0E,SMW_CompressedGFXFile0EEnd
	dl $4BE705,$4BEF46,SMW_CompressedGFXFile0F,SMW_CompressedGFXFile0FEnd
	dl $4BEF46,$4BF7D7,SMW_CompressedGFXFile10,SMW_CompressedGFXFile10End
	dl $4BF7D7,$4BFFE5,SMW_CompressedGFXFile11,SMW_CompressedGFXFile11End
	dl $4BFFE5,$4C8939,SMW_CompressedGFXFile12,SMW_CompressedGFXFile12End
	dl $4C8939,$4C9374,SMW_CompressedGFXFile13,SMW_CompressedGFXFile13End
	dl $4C9374,$4C9B1A,SMW_CompressedGFXFile14,SMW_CompressedGFXFile14End
	dl $4C9B1A,$4CA3A6,SMW_CompressedGFXFile15,SMW_CompressedGFXFile15End
	dl $4CA3A6,$4CA9F1,SMW_CompressedGFXFile16,SMW_CompressedGFXFile16End
	dl $4CA9F1,$4CB2EF,SMW_CompressedGFXFile17,SMW_CompressedGFXFile17End
	dl $4CB2EF,$4CBC26,SMW_CompressedGFXFile18,SMW_CompressedGFXFile18End
	dl $4CBC26,$4CC3CE,SMW_CompressedGFXFile19,SMW_CompressedGFXFile19End
	dl $4CC3CE,$4CCCB4,SMW_CompressedGFXFile1A,SMW_CompressedGFXFile1AEnd
	dl $4CCCB4,$4CD4CC,SMW_CompressedGFXFile1B,SMW_CompressedGFXFile1BEnd
	dl $4CD4CC,$4CDCD6,SMW_CompressedGFXFile1C,SMW_CompressedGFXFile1CEnd
	dl $4CDCD6,$4CE6CC,SMW_CompressedGFXFile1D,SMW_CompressedGFXFile1DEnd
	dl $4CE6CC,$4CEE90,SMW_CompressedGFXFile1E,SMW_CompressedGFXFile1EEnd
	dl $4CEE90,$4CF6FA,SMW_CompressedGFXFile1F,SMW_CompressedGFXFile1FEnd
	dl $4CF6FA,$4CFFC4,SMW_CompressedGFXFile20,SMW_CompressedGFXFile20End
	dl $4CFFC4,$4D892E,SMW_CompressedGFXFile21,SMW_CompressedGFXFile21End
	dl $4D892E,$4D922C,SMW_CompressedGFXFile22,SMW_CompressedGFXFile22End
	dl $4D922C,$4D9B49,SMW_CompressedGFXFile23,SMW_CompressedGFXFile23End
	dl $4D9B49,$4DA419,SMW_CompressedGFXFile24,SMW_CompressedGFXFile24End
	dl $4DA419,$4DAE85,SMW_CompressedGFXFile25,SMW_CompressedGFXFile25End
	dl $4DAE85,$4DB7AB,SMW_CompressedGFXFile26,SMW_CompressedGFXFile26End
	dl $4DB7AB,$4DC0DD,SMW_CompressedGFXFile27,SMW_CompressedGFXFile27End
	dl $4DC0DD,$4DC714,SMW_CompressedGFXFile28,SMW_CompressedGFXFile28End
	dl $4DC714,$4DCBEA,SMW_CompressedGFXFile29,SMW_CompressedGFXFile29End
	dl $4DCBEA,$4DD16E,SMW_CompressedGFXFile2A,SMW_CompressedGFXFile2AEnd
	dl $4DD16E,$4DD843,SMW_CompressedGFXFile2B,SMW_CompressedGFXFile2BEnd
	dl $4DD843,$4DE094,SMW_CompressedGFXFile2C,SMW_CompressedGFXFile2CEnd
	dl $4DE094,$4DE9C4,SMW_CompressedGFXFile2D,SMW_CompressedGFXFile2DEnd
	dl $4DE9C4,$4DF213,SMW_CompressedGFXFile2E,SMW_CompressedGFXFile2EEnd
	dl $4DF213,$4DF449,SMW_CompressedGFXFile2F,SMW_CompressedGFXFile2FEnd
	dl $4DF449,$4DF88E,SMW_CompressedGFXFile30,SMW_CompressedGFXFile30End
	dl $4DF88E,$4DFD9B,SMW_CompressedGFXFile31,SMW_CompressedGFXFile31End
	dl $4A8000,$4ABFC0,SMW_CompressedGFXFile32,SMW_CompressedGFXFile32End
	dl $4ABFC0,$4AD9FC,SMW_CompressedGFXFile33,SMW_CompressedGFXFile33End
else
	dl $4AD9F9,$4AE231,SMW_CompressedGFXFile00,SMW_CompressedGFXFile00End
	dl $4AE231,$4AECBB,SMW_CompressedGFXFile01,SMW_CompressedGFXFile01End
	dl $4AECBB,$4AF552,SMW_CompressedGFXFile02,SMW_CompressedGFXFile02End
	dl $4AF552,$4AFF7D,SMW_CompressedGFXFile03,SMW_CompressedGFXFile03End
	dl $4AFF7D,$4B8963,SMW_CompressedGFXFile04,SMW_CompressedGFXFile04End
	dl $4B8963,$4B936C,SMW_CompressedGFXFile05,SMW_CompressedGFXFile05End
	dl $4B936C,$4B9D10,SMW_CompressedGFXFile06,SMW_CompressedGFXFile06End
	dl $4B9D10,$4BA657,SMW_CompressedGFXFile07,SMW_CompressedGFXFile07End
	dl $4BA657,$4BAFA1,SMW_CompressedGFXFile08,SMW_CompressedGFXFile08End
	dl $4BAFA1,$4BBA15,SMW_CompressedGFXFile09,SMW_CompressedGFXFile09End
	dl $4BBA15,$4BC39C,SMW_CompressedGFXFile0A,SMW_CompressedGFXFile0AEnd
	dl $4BC39C,$4BCD63,SMW_CompressedGFXFile0B,SMW_CompressedGFXFile0BEnd
	dl $4BCD63,$4BD5D2,SMW_CompressedGFXFile0C,SMW_CompressedGFXFile0CEnd
	dl $4BD5D2,$4BDDCB,SMW_CompressedGFXFile0D,SMW_CompressedGFXFile0DEnd
	dl $4BDDCB,$4BE6E5,SMW_CompressedGFXFile0E,SMW_CompressedGFXFile0EEnd
	dl $4BE6E5,$4BEF1E,SMW_CompressedGFXFile0F,SMW_CompressedGFXFile0FEnd
	dl $4BEF1E,$4BF7AF,SMW_CompressedGFXFile10,SMW_CompressedGFXFile10End
	dl $4BF7AF,$4BFFBD,SMW_CompressedGFXFile11,SMW_CompressedGFXFile11End
	dl $4BFFBD,$4C8910,SMW_CompressedGFXFile12,SMW_CompressedGFXFile12End
	dl $4C8910,$4C9348,SMW_CompressedGFXFile13,SMW_CompressedGFXFile13End
	dl $4C9348,$4C9AE8,SMW_CompressedGFXFile14,SMW_CompressedGFXFile14End
	dl $4C9AE8,$4CA374,SMW_CompressedGFXFile15,SMW_CompressedGFXFile15End
	dl $4CA374,$4CA9B4,SMW_CompressedGFXFile16,SMW_CompressedGFXFile16End
	dl $4CA9B4,$4CB2AD,SMW_CompressedGFXFile17,SMW_CompressedGFXFile17End
	dl $4CB2AD,$4CBBE4,SMW_CompressedGFXFile18,SMW_CompressedGFXFile18End
	dl $4CBBE4,$4CC380,SMW_CompressedGFXFile19,SMW_CompressedGFXFile19End
	dl $4CC380,$4CCC66,SMW_CompressedGFXFile1A,SMW_CompressedGFXFile1AEnd
	dl $4CCC66,$4CD47E,SMW_CompressedGFXFile1B,SMW_CompressedGFXFile1BEnd
	dl $4CD47E,$4CDC88,SMW_CompressedGFXFile1C,SMW_CompressedGFXFile1CEnd
	dl $4CDC88,$4CE67F,SMW_CompressedGFXFile1D,SMW_CompressedGFXFile1DEnd
	dl $4CE67F,$4CEE43,SMW_CompressedGFXFile1E,SMW_CompressedGFXFile1EEnd
	dl $4CEE43,$4CF6A1,SMW_CompressedGFXFile1F,SMW_CompressedGFXFile1FEnd
	dl $4CF6A1,$4CFF65,SMW_CompressedGFXFile20,SMW_CompressedGFXFile20End
	dl $4CFF65,$4D88CD,SMW_CompressedGFXFile21,SMW_CompressedGFXFile21End
	dl $4D88CD,$4D91CA,SMW_CompressedGFXFile22,SMW_CompressedGFXFile22End
	dl $4D91CA,$4D9AE5,SMW_CompressedGFXFile23,SMW_CompressedGFXFile23End
	dl $4D9AE5,$4DA3B5,SMW_CompressedGFXFile24,SMW_CompressedGFXFile24End
	dl $4DA3B5,$4DAE21,SMW_CompressedGFXFile25,SMW_CompressedGFXFile25End
	dl $4DAE21,$4DB744,SMW_CompressedGFXFile26,SMW_CompressedGFXFile26End
	dl $4DB744,$4DC06C,SMW_CompressedGFXFile27,SMW_CompressedGFXFile27End
	dl $4DC06C,$4DC6A3,SMW_CompressedGFXFile28,SMW_CompressedGFXFile28End
	dl $4DC6A3,$4DCB7B,SMW_CompressedGFXFile29,SMW_CompressedGFXFile29End
	dl $4DCB7B,$4DD0F0,SMW_CompressedGFXFile2A,SMW_CompressedGFXFile2AEnd
	dl $4DD0F0,$4DD7B9,SMW_CompressedGFXFile2B,SMW_CompressedGFXFile2BEnd
	dl $4DD7B9,$4DE006,SMW_CompressedGFXFile2C,SMW_CompressedGFXFile2CEnd
	dl $4DE006,$4DE936,SMW_CompressedGFXFile2D,SMW_CompressedGFXFile2DEnd
	dl $4DE936,$4DF185,SMW_CompressedGFXFile2E,SMW_CompressedGFXFile2EEnd
	dl $4DF185,$4DF3BB,SMW_CompressedGFXFile2F,SMW_CompressedGFXFile2FEnd
	dl $4DF3BB,$4DF800,SMW_CompressedGFXFile30,SMW_CompressedGFXFile30End
	dl $4DF800,$4DFD0D,SMW_CompressedGFXFile31,SMW_CompressedGFXFile31End
	dl $4A8000,$4ABFC0,SMW_CompressedGFXFile32,SMW_CompressedGFXFile32End
	dl $4ABFC0,$4AD9F9,SMW_CompressedGFXFile33,SMW_CompressedGFXFile33End
endif
endif
SMW_CompressedGFXPointersEnd:

;--------------------------------------------------------------------

SMW_UncompressedGFXPointersStart:
if !ROMVer&(!ROM_SMASW_U|!ROM_SMASW_E) != $00
	dl $02A000,$02FCF0,LuigiGFX,LuigiGFXEnd
	dl $02FCF0,$038000,BlankLuigiTilesGFX,BlankLuigiTilesGFXEnd
endif
SMW_UncompressedGFXPointersEnd:

;--------------------------------------------------------------------

SMW_LevelMusicPointersStart:
if !ROMVer&(!ROM_SMASW_U|!ROM_SMASW_E) != $00
	dl $4ED02C,$4ED3F7,SMW_Music_Boss_Battle,SMW_Music_Boss_BattleEnd
	dl $4EB902,$4EBAFD,SMW_Music_Bowser_Died,SMW_Music_Bowser_DiedEnd
	dl $4EBE07,$4EC221,SMW_Music_Bowser_Fight,SMW_Music_Bowser_FightEnd
	dl $4EBD2D,$4EBE07,SMW_Music_Bowser_Zoom_In,SMW_Music_Bowser_Zoom_InEnd
	dl $4EBAFD,$4EBD2D,SMW_Music_Bowser_Zoom_Out,SMW_Music_Bowser_Zoom_OutEnd
	dl $4EC95D,$4ED02C,SMW_Music_Castle,SMW_Music_CastleEnd
	dl $4EDDF8,$4EDF84,SMW_Music_Cave,SMW_Music_CaveEnd
	dl $4ED4A7,$4ED512,SMW_Music_Directional_Coins,SMW_Music_Directional_CoinsEnd
	dl $4EC72A,$4EC7E0,SMW_Music_Done_Bonus_Game,SMW_Music_Done_Bonus_GameEnd
	dl $4ED784,$4ED85C,SMW_Music_Game_Over,SMW_Music_Game_OverEnd
	dl $4EDF84,$4EE547,SMW_Music_Ghost_House,SMW_Music_Ghost_HouseEnd
	dl $4EE547,$4EED92,SMW_Music_Here_We_Go,SMW_Music_Here_We_GoEnd
	dl $4ED427,$4ED4A7,SMW_Music_Into_Keyhole,SMW_Music_Into_KeyholeEnd
	dl $4EC7E0,$4EC95D,SMW_Music_Passed_Boss,SMW_Music_Passed_BossEnd
	dl $4ED5B2,$4ED784,SMW_Music_Passed_Level,SMW_Music_Passed_LevelEnd
	dl $4ED8BD,$4EDDF8,SMW_Music_Piano,SMW_Music_PianoEnd
	dl $4ED85C,$4ED8BD,SMW_Music_Player_Died,SMW_Music_Player_DiedEnd
	dl $4EB7CE,$4EB902,SMW_Music_Princess_Kiss,SMW_Music_Princess_KissEnd
	dl $4EC221,$4EC28E,SMW_Music_Rescue_Egg,SMW_Music_Rescue_EggEnd
	dl $4ED512,$4ED5B2,SMW_Music_Star,SMW_Music_StarEnd
	dl $4EC4E8,$4EC72A,SMW_Music_Switch_Palace,SMW_Music_Switch_PalaceEnd
	dl $4EED92,$4EF10F,SMW_Music_Water,SMW_Music_WaterEnd
	dl $4EC28E,$4EC4E8,SMW_Music_Welcome,SMW_Music_WelcomeEnd
	dl $4ED3F7,$4ED427,SMW_Music_Zoom_In,SMW_Music_Zoom_InEnd
endif
SMW_LevelMusicPointersEnd:

;--------------------------------------------------------------------

SMW_OverworldMusicPointersStart:
if !ROMVer&(!ROM_SMASW_U|!ROM_SMASW_E) != $00
	dl $4EA1DE,$4EA296,SMW_Music_Bowser_Reveals,SMW_Music_Bowser_RevealsEnd
	dl $4EA296,$4EA37B,SMW_Music_Forest_Of_Illusion,SMW_Music_Forest_Of_IllusionEnd
	dl $4EA68F,$4EA7DF,SMW_Music_Main_Area,SMW_Music_Main_AreaEnd
	dl $4E9C2B,$4EA1DE,SMW_Music_Special_World,SMW_Music_Special_WorldEnd
	dl $4EA37B,$4EA47B,SMW_Music_Star_Road,SMW_Music_Star_RoadEnd
	dl $4EA9D5,$4EAF0A,SMW_Music_Title_Screen,SMW_Music_Title_ScreenEnd
	dl $4EA47B,$4EA563,SMW_Music_Valley_Of_Bowser,SMW_Music_Valley_Of_BowserEnd
	dl $4EA7DF,$4EA9D5,SMW_Music_Vanilla_Dome,SMW_Music_Vanilla_DomeEnd
	dl $4EA563,$4EA68F,SMW_Music_Yoshis_Island,SMW_Music_Yoshis_IslandEnd
endif
SMW_OverworldMusicPointersEnd:

;--------------------------------------------------------------------

SMW_CreditsMusicPointersStart:
if !ROMVer&(!ROM_SMASW_U|!ROM_SMASW_E) != $00
	dl $33E6D6,$33FDCA,SMW_Music_Credits,SMW_Music_CreditsEnd
endif
SMW_CreditsMusicPointersEnd:

;--------------------------------------------------------------------

SMW_BRRPointersStart:
if !ROMVer&(!ROM_SMASW_U|!ROM_SMASW_E) != $00
	dl $4F8058,$4F8097,SMW_BRRFile00,SMW_BRRFile00End
	dl $4F8097,$4F80D6,SMW_BRRFile01,SMW_BRRFile01End
	dl $4F80D6,$4F81DB,SMW_BRRFile02,SMW_BRRFile02End
	dl $4F81DB,$4F831F,SMW_BRRFile03,SMW_BRRFile03End
	dl $4F831F,$4F835E,SMW_BRRFile04,SMW_BRRFile04End
	dl $4F835E,$4F8595,SMW_BRRFile05,SMW_BRRFile05End
	dl $4F8595,$4F8A03,SMW_BRRFile06,SMW_BRRFile06End
	dl $4F8A03,$4F9069,SMW_BRRFile07,SMW_BRRFile07End
	dl $4F9069,$4F90A8,SMW_BRRFile08,SMW_BRRFile08End
	dl $4F90A8,$4F9CED,SMW_BRRFile09,SMW_BRRFile09End
	dl $4F9CED,$4FAF6B,SMW_BRRFile0A,SMW_BRRFile0AEnd
	dl $4FAF6B,$4FB607,SMW_BRRFile0B,SMW_BRRFile0BEnd
	dl $4FB607,$4FB646,SMW_BRRFile0C,SMW_BRRFile0CEnd
	dl $4FB646,$4FB91F,SMW_BRRFile0D,SMW_BRRFile0DEnd
	dl $4FB91F,$4FC3AB,SMW_BRRFile0E,SMW_BRRFile0EEnd
	dl $4FC3AB,$4FC62A,SMW_BRRFile0F,SMW_BRRFile0FEnd
	dl $4FC62A,$4FCF0F,SMW_BRRFile10,SMW_BRRFile10End
	dl $4FCF0F,$4FD479,SMW_BRRFile11,SMW_BRRFile11End
	dl $4FD479,$4FDDD3,SMW_BRRFile12,SMW_BRRFile12End
	dl $4FDDD3,$4FEF70,SMW_BRRFile13,SMW_BRRFile13End
endif
SMW_BRRPointersEnd:

;--------------------------------------------------------------------

BlankFileSelectControllerGFX:
if !ROMVer&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	db "BlankFileSelectControllerGFX_SMAS_U.bin"
elseif !ROMVer&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	db "BlankFileSelectControllerGFX_SMAS_J.bin"
else
	db "BlankFileSelectControllerGFX_SMASW.bin"
endif
BlankFileSelectControllerGFXEnd:
BoxArtGFX1:
if !ROMVer&(!ROM_SMAS_E) != $00
	db "BoxArtGFX1_SMAS_E.bin"
elseif !ROMVer&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	db "BoxArtGFX1_SMAS_J.bin"
elseif !ROMVer&(!ROM_SMAS_U) != $00
	db "BoxArtGFX1_SMAS_U.bin"
elseif !ROMVer&(!ROM_SMASW_E) != $00
	db "BoxArtGFX1_SMASW_E.bin"
else
	db "BoxArtGFX1_SMASW_U.bin"
endif
BoxArtGFX1End:
BoxArtGFX2:
if !ROMVer&(!ROM_SMAS_E) != $00
	db "BoxArtGFX2_SMAS_E.bin"
elseif !ROMVer&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	db "BoxArtGFX2_SMAS_J.bin"
elseif !ROMVer&(!ROM_SMAS_U) != $00
	db "BoxArtGFX2_SMAS_U.bin"
elseif !ROMVer&(!ROM_SMASW_E) != $00
	db "BoxArtGFX2_SMASW_E.bin"
else
	db "BoxArtGFX2_SMASW_U.bin"
endif
BoxArtGFX2End:
ErrorMessageFontGFX:
if !ROMVer&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	db "ErrorMessageFontGFX_SMAS_J.bin"
else
	db "ErrorMessageFontGFX_SMAS_U.bin"
endif
ErrorMessageFontGFXEnd:
FileSelectControllerGFX:
if !ROMVer&(!ROM_SMAS_E) != $00
	db "FileSelectControllerGFX_SMAS_E.bin"
elseif !ROMVer&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	db "FileSelectControllerGFX_SMAS_J.bin"
elseif !ROMVer&(!ROM_SMAS_U) != $00
	db "FileSelectControllerGFX_SMAS_U.bin"
elseif !ROMVer&(!ROM_SMASW_E) != $00
	db "FileSelectControllerGFX_SMASW_E.bin"
else
	db "FileSelectControllerGFX_SMASW_U.bin"
endif
FileSelectControllerGFXEnd:
if !ROMVer&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
else
FileSelectYoshiGFX:
	db "FileSelectYoshiGFX.bin"
FileSelectYoshiGFXEnd:
endif
PauseMenuGFX:
	db "PauseMenuGFX.bin"
PauseMenuGFXEnd:
SplashScreenGFX:
	db "SplashScreenGFX.bin"
SplashScreenGFXEnd:
TitleScreenCharactersGFX1:
if !ROMVer&(!ROM_SMAS_U|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	db "TitleScreenCharactersGFX1_SMAS.bin"
elseif !ROMVer&(!ROM_SMAS_E) != $00
	db "TitleScreenCharactersGFX1_SMAS_E.bin"
else
	db "TitleScreenCharactersGFX1_SMASW.bin"
endif
TitleScreenCharactersGFX1End:
TitleScreenCharactersGFX2:
if !ROMVer&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	db "TitleScreenCharactersGFX2_SMAS.bin"
else
	db "TitleScreenCharactersGFX2_SMASW.bin"
endif
TitleScreenCharactersGFX2End:
TitleScreenTextGFX:
if !ROMVer&(!ROM_SMAS_U|!ROM_SMAS_E) != $00
	db "TitleScreenTextGFX_SMAS_U.bin"
elseif !ROMVer&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	db "TitleScreenTextGFX_SMAS_J.bin"
elseif !ROMVer&(!ROM_SMASW_E) != $00
	db "TitleScreenTextGFX_SMASW_E.bin"
else
	db "TitleScreenTextGFX_SMASW_U.bin"
endif
TitleScreenTextGFXEnd:
TriangleTransitionalEffectGFX:
	db "TriangleTransitionalEffectGFX.bin"
TriangleTransitionalEffectGFXEnd:

;--------------------------------------------------------------------

SMAS_Music_GameSelect:
	db "GameSelect.bin"
SMAS_Music_GameSelectEnd:
SMAS_Music_TitleScreen:
	db "TitleScreen.bin"
SMAS_Music_TitleScreenEnd:

;--------------------------------------------------------------------

MainBRRFile00:
	db "00.brr"
MainBRRFile00End:
MainBRRFile01:
	db "01.brr"
MainBRRFile01End:
MainBRRFile03:
	db "03.brr"
MainBRRFile03End:
MainBRRFile04:
	db "04.brr"
MainBRRFile04End:
MainBRRFile05:
	db "05.brr"
MainBRRFile05End:
MainBRRFile07:
	db "07.brr"
MainBRRFile07End:
MainBRRFile08:
	db "08.brr"
MainBRRFile08End:
MainBRRFile0A:
	db "0A.brr"
MainBRRFile0AEnd:
MainBRRFile0B:
	db "0B.brr"
MainBRRFile0BEnd:
MainBRRFile0C:
	db "0C.brr"
MainBRRFile0CEnd:
MainBRRFile0D:
	db "0D.brr"
MainBRRFile0DEnd:
MainBRRFile0E:
	db "0E.brr"
MainBRRFile0EEnd:
MainBRRFile0F:
	db "0F.brr"
MainBRRFile0FEnd:
MainBRRFile10:
	db "10.brr"
MainBRRFile10End:
MainBRRFile11:
	db "11.brr"
MainBRRFile11End:
MainBRRFile12:
	db "12.brr"
MainBRRFile12End:
MainBRRFile13:
	db "13.brr"
MainBRRFile13End:
MainBRRFile14:
	db "14.brr"
MainBRRFile14End:
MainBRRFile15:
	db "15.brr"
MainBRRFile15End:
MainBRRFile16:
	db "16.brr"
MainBRRFile16End:
MainBRRFile17:
	db "17.brr"
MainBRRFile17End:
MainBRRFile18:
	db "18.brr"
MainBRRFile18End:

;--------------------------------------------------------------------

if !ROMVer&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
RCBRRFile00:
	db "00_SMAS_J.brr"
RCBRRFile00End:
RCBRRFile05:
	db "05_SMAS_J.brr"
RCBRRFile05End:
else
RCBRRFile00:
	db "00_SMAS_U.brr"
RCBRRFile00End:
RCBRRFile05:
	db "05_SMAS_U.brr"
RCBRRFile05End:
endif
RCBRRFile01:
	db "01.brr"
RCBRRFile01End:
RCBRRFile04:
	db "04.brr"
RCBRRFile04End:

;--------------------------------------------------------------------

SMB1_GFX_BG_BonusRoomLuigi:
	db "GFX_BG_BonusRoomLuigi.bin"
SMB1_GFX_BG_BonusRoomLuigiEnd:
SMB1_GFX_BG_BonusRoomMario:
	db "GFX_BG_BonusRoomMario.bin"
SMB1_GFX_BG_BonusRoomMarioEnd:
SMB1_GFX_BG_Castle:
	db "GFX_BG_Castle.bin"
SMB1_GFX_BG_CastleEnd:
SMB1_GFX_BG_Cave:
	db "GFX_BG_Cave.bin"
SMB1_GFX_BG_CaveEnd:
SMB1_GFX_BG_DeathScreen1:
if !ROMVer&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	db "GFX_BG_DeathScreen1_SMAS_J.bin"
else
	db "GFX_BG_DeathScreen1_SMAS_U.bin"
endif
SMB1_GFX_BG_DeathScreen1End:
SMB1_GFX_BG_DeathScreen2:
if !ROMVer&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	db "GFX_BG_DeathScreen2_SMAS_J.bin"
else
	db "GFX_BG_DeathScreen2_SMAS_U.bin"
endif
SMB1_GFX_BG_DeathScreen2End:
SMB1_GFX_BG_DottedHills:
	db "GFX_BG_DottedHills.bin"
SMB1_GFX_BG_DottedHillsEnd:
SMB1_GFX_BG_FinalCastle1:
	db "GFX_BG_FinalCastle1.bin"
SMB1_GFX_BG_FinalCastle1End:
SMB1_GFX_BG_FinalCastle2:
	db "GFX_BG_FinalCastle2.bin"
SMB1_GFX_BG_FinalCastle2End:
SMB1_GFX_BG_HillsAndTrees:
	db "GFX_BG_HillsAndTrees.bin"
SMB1_GFX_BG_HillsAndTreesEnd:
SMB1_GFX_BG_Mushrooms:
	db "GFX_BG_Mushrooms.bin"
SMB1_GFX_BG_MushroomsEnd:
SMB1_GFX_BG_Night:
	db "GFX_BG_Night.bin"
SMB1_GFX_BG_NightEnd:
SMB1_GFX_BG_Pillars:
	db "GFX_BG_Pillars.bin"
SMB1_GFX_BG_PillarsEnd:
SMB1_GFX_BG_Underwater:
	db "GFX_BG_Underwater.bin"
SMB1_GFX_BG_UnderwaterEnd:
SMB1_GFX_BG_UnderwaterCastle:
	db "GFX_BG_UnderwaterCastle.bin"
SMB1_GFX_BG_UnderwaterCastleEnd:
SMB1_GFX_BG_Waterfalls:
	db "GFX_BG_Waterfalls.bin"
SMB1_GFX_BG_WaterfallsEnd:
SMB1_GFX_Ending:
	db "GFX_Ending.bin"
SMB1_GFX_EndingEnd:
SMB1_GFX_FG_BG_Castle:
	db "GFX_FG_BG_Castle.bin"
SMB1_GFX_FG_BG_CastleEnd:
SMB1_GFX_FG_Cave:
if !ROMVer&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	db "GFX_FG_Cave_SMAS_J.bin"
else
	db "GFX_FG_Cave_SMAS_U.bin"
endif
SMB1_GFX_FG_CaveEnd:
SMB1_GFX_FG_Grassland:
if !ROMVer&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	db "GFX_FG_Grassland_SMAS_J.bin"
else
	db "GFX_FG_Grassland_SMAS_U.bin"
endif
SMB1_GFX_FG_GrasslandEnd:
SMB1_GFX_FG_SMB1_GlobalTiles_SMASU:
	db "GFX_FG_SMB1_GlobalTiles_SMASU.bin"
SMB1_GFX_FG_SMB1_GlobalTiles_SMASUEnd:
SMB1_GFX_FG_SMB1_GlobalTiles_USA:
	db "GFX_FG_SMB1_GlobalTiles_USA.bin"
SMB1_GFX_FG_SMB1_GlobalTiles_USAEnd:
SMB1_GFX_FG_SMB1_TitleLogo:
	db "GFX_FG_SMB1_TitleLogo.bin"
SMB1_GFX_FG_SMB1_TitleLogoEnd:
SMB1_GFX_FG_SMBLL_GlobalTiles:
	db "GFX_FG_SMBLL_GlobalTiles.bin"
SMB1_GFX_FG_SMBLL_GlobalTilesEnd:
SMB1_GFX_FG_SMBLL_TitleLogo:
if !ROMVer&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	db "GFX_FG_SMBLL_TitleLogo_SMAS_J.bin"
else
	db "GFX_FG_SMBLL_TitleLogo_SMAS_U.bin"
endif
SMB1_GFX_FG_SMBLL_TitleLogoEnd:
SMB1_GFX_FG_Snow:
	db "GFX_FG_Snow.bin"
SMB1_GFX_FG_SnowEnd:
SMB1_GFX_Layer3:
	db "GFX_Layer3.bin"
SMB1_GFX_Layer3End:
SMB1_GFX_Player_Luigi:
	db "GFX_Player_Luigi.bin"
SMB1_GFX_Player_LuigiEnd:
SMB1_GFX_Player_Mario:
	db "GFX_Player_Mario.bin"
SMB1_GFX_Player_MarioEnd:
SMB1_GFX_SMB1_AnimatedTiles:
	db "GFX_SMB1_AnimatedTiles.bin"
SMB1_GFX_SMB1_AnimatedTilesEnd:
SMB1_GFX_SMBLL_AnimatedTiles:
	db "GFX_SMBLL_AnimatedTiles.bin"
SMB1_GFX_SMBLL_AnimatedTilesEnd:
SMB1_GFX_Sprite_GlobalTiles:
	db "GFX_Sprite_GlobalTiles.bin"
SMB1_GFX_Sprite_GlobalTilesEnd:
SMB1_GFX_Sprite_PeachAndToad:
	db "GFX_Sprite_PeachAndToad.bin"
SMB1_GFX_Sprite_PeachAndToadEnd:

;--------------------------------------------------------------------

SMB1_Music_BonusRoom:
	db "BonusRoom.bin"
SMB1_Music_BonusRoomEnd:
SMB1_Music_BowserBattle:
	db "BowserBattle.bin"
SMB1_Music_BowserBattleEnd:
SMB1_Music_Castle:
	db "Castle.bin"
SMB1_Music_CastleEnd:
SMB1_Music_CopyOfPeachRescued:
	db "CopyOfPeachRescued.bin"
SMB1_Music_CopyOfPeachRescuedEnd:
SMB1_Music_Death:
	db "Death.bin"
SMB1_Music_DeathEnd:
SMB1_Music_EnterPipeCutscene:
	db "EnterPipeCutscene.bin"
SMB1_Music_EnterPipeCutsceneEnd:
SMB1_Music_FinalBowserBattle:
	db "FinalBowserBattle.bin"
SMB1_Music_FinalBowserBattleEnd:
SMB1_Music_GameOver:
	db "GameOver.bin"
SMB1_Music_GameOverEnd:
SMB1_Music_HaveStar:
	db "HaveStar.bin"
SMB1_Music_HaveStarEnd:
SMB1_Music_Overworld:
	db "Overworld.bin"
SMB1_Music_OverworldEnd:
SMB1_Music_PassedBoss:
	db "PassedBoss.bin"
SMB1_Music_PassedBossEnd:
SMB1_Music_PassedLevel:
	db "PassedLevel.bin"
SMB1_Music_PassedLevelEnd:
SMB1_Music_SMB1PeachRescued:
	db "SMB1PeachRescued.bin"
SMB1_Music_SMB1PeachRescuedEnd:
SMB1_Music_SMBLLPeachRescued:
	db "SMBLLPeachRescued.bin"
SMB1_Music_SMBLLPeachRescuedEnd:
SMB1_Music_SMB1TitleScreen:
	db "SMB1TitleScreen.bin"
SMB1_Music_SMB1TitleScreenEnd:
SMB1_Music_SMBLLTitleScreen:
	db "SMBLLTitleScreen.bin"
SMB1_Music_SMBLLTitleScreenEnd:
SMB1_Music_Underground:
	db "Underground.bin"
SMB1_Music_UndergroundEnd:
SMB1_Music_Underwater:
	db "Underwater.bin"
SMB1_Music_UnderwaterEnd:

;--------------------------------------------------------------------

SMB2U_GFX_AnimatedSleepingMario:
	db "GFX_AnimatedSleepingMario.bin"
SMB2U_GFX_AnimatedSleepingMarioEnd:
SMB2U_GFX_BG_Desert1:
	db "GFX_BG_Desert1.bin"
SMB2U_GFX_BG_Desert1End:
SMB2U_GFX_BG_Desert2:
	db "GFX_BG_Desert2.bin"
SMB2U_GFX_BG_Desert2End:
SMB2U_GFX_BG_DesertCliff:
	db "GFX_BG_DesertCliff.bin"
SMB2U_GFX_BG_DesertCliffEnd:
SMB2U_GFX_BG_EndingScreen1:
	db "GFX_BG_EndingScreen1.bin"
SMB2U_GFX_BG_EndingScreen1End:
SMB2U_GFX_BG_GentleHills:
	db "GFX_BG_GentleHills.bin"
SMB2U_GFX_BG_GentleHillsEnd:
SMB2U_GFX_BG_GiantPhanto1:
	db "GFX_BG_GiantPhanto1.bin"
SMB2U_GFX_BG_GiantPhanto1End:
SMB2U_GFX_BG_GiantPhanto2:
	db "GFX_BG_GiantPhanto2.bin"
SMB2U_GFX_BG_GiantPhanto2End:
SMB2U_GFX_BG_GiantPhanto3:
	db "GFX_BG_GiantPhanto3.bin"
SMB2U_GFX_BG_GiantPhanto3End:
SMB2U_GFX_BG_IceCrystalCave:
	db "GFX_BG_IceCrystalCave.bin"
SMB2U_GFX_BG_IceCrystalCaveEnd:
SMB2U_GFX_BG_Jungle1:
	db "GFX_BG_Jungle1.bin"
SMB2U_GFX_BG_Jungle1End:
SMB2U_GFX_BG_Jungle2:
	db "GFX_BG_Jungle2.bin"
SMB2U_GFX_BG_Jungle2End:
SMB2U_GFX_BG_NightGrassyHills:
	db "GFX_BG_NightGrassyHills.bin"
SMB2U_GFX_BG_NightGrassyHillsEnd:
SMB2U_GFX_BG_PyramidInterior1:
	db "GFX_BG_PyramidInterior1.bin"
SMB2U_GFX_BG_PyramidInterior1End:
SMB2U_GFX_BG_PyramidInterior2:
	db "GFX_BG_PyramidInterior2.bin"
SMB2U_GFX_BG_PyramidInterior2End:
SMB2U_GFX_BG_SkyStructures1:
	db "GFX_BG_SkyStructures1.bin"
SMB2U_GFX_BG_SkyStructures1End:
SMB2U_GFX_BG_SkyStructures2:
	db "GFX_BG_SkyStructures2.bin"
SMB2U_GFX_BG_SkyStructures2End:
SMB2U_GFX_BG_SkyStructures3:
	db "GFX_BG_SkyStructures3.bin"
SMB2U_GFX_BG_SkyStructures3End:
SMB2U_GFX_BG_SnowHills1:
	db "GFX_BG_SnowHills1.bin"
SMB2U_GFX_BG_SnowHills1End:
SMB2U_GFX_BG_SnowHills2:
	db "GFX_BG_SnowHills2.bin"
SMB2U_GFX_BG_SnowHills2End:
SMB2U_GFX_BG_StripedHills:
	db "GFX_BG_StripedHills.bin"
SMB2U_GFX_BG_StripedHillsEnd:
SMB2U_GFX_BG_Underground:
	db "GFX_BG_Underground.bin"
SMB2U_GFX_BG_UndergroundEnd:
SMB2U_GFX_BG_Warehouse1:
	db "GFX_BG_Warehouse1.bin"
SMB2U_GFX_BG_Warehouse1End:
SMB2U_GFX_BG_Warehouse2:
	db "GFX_BG_Warehouse2.bin"
SMB2U_GFX_BG_Warehouse2End:
SMB2U_GFX_BG_WartsFortress1:
	db "GFX_BG_WartsFortress1.bin"
SMB2U_GFX_BG_WartsFortress1End:
SMB2U_GFX_BG_WartsFortress2:
	db "GFX_BG_WartsFortress2.bin"
SMB2U_GFX_BG_WartsFortress2End:
SMB2U_GFX_BG_WartsFortress3:
	db "GFX_BG_WartsFortress3.bin"
SMB2U_GFX_BG_WartsFortress3End:
SMB2U_GFX_BonusChanceText:
	db "GFX_BonusChanceText.bin"
SMB2U_GFX_BonusChanceTextEnd:
SMB2U_GFX_CharacterSelectCharacters:
	db "GFX_CharacterSelectCharacters.bin"
SMB2U_GFX_CharacterSelectCharactersEnd:
SMB2U_GFX_Curtain:
	db "GFX_Curtain.bin"
SMB2U_GFX_CurtainEnd:
SMB2U_GFX_EndingScreen2Tiles:
	db "GFX_EndingScreen2Tiles.bin"
SMB2U_GFX_EndingScreen2TilesEnd:
SMB2U_GFX_FG_AnimatedTilesBank1D:
	db "GFX_FG_AnimatedTilesBank1D.bin"
SMB2U_GFX_FG_AnimatedTilesBank1DEnd:
SMB2U_GFX_FG_AnimatedTilesBank18:
	db "GFX_FG_AnimatedTilesBank18.bin"
SMB2U_GFX_FG_AnimatedTilesBank18End:
SMB2U_GFX_FG_BrickBuilding:
	db "GFX_FG_BrickBuilding.bin"
SMB2U_GFX_FG_BrickBuildingEnd:
SMB2U_GFX_FG_GiantTree:
	db "GFX_FG_GiantTree.bin"
SMB2U_GFX_FG_GiantTreeEnd:
SMB2U_GFX_FG_GlobalTiles1:
	db "GFX_FG_GlobalTiles1.bin"
SMB2U_GFX_FG_GlobalTiles1End:
SMB2U_GFX_FG_GlobalTiles2:
	db "GFX_FG_GlobalTiles2.bin"
SMB2U_GFX_FG_GlobalTiles2End:
SMB2U_GFX_FG_IceRock:
	db "GFX_FG_IceRock.bin"
SMB2U_GFX_FG_IceRockEnd:
SMB2U_GFX_FG_PyramidInterior:
	db "GFX_FG_PyramidInterior.bin"
SMB2U_GFX_FG_PyramidInteriorEnd:
SMB2U_GFX_FG_RockyGround:
	db "GFX_FG_RockyGround.bin"
SMB2U_GFX_FG_RockyGroundEnd:
SMB2U_GFX_FG_SkyFortressInterior:
	db "GFX_FG_SkyFortressInterior.bin"
SMB2U_GFX_FG_SkyFortressInteriorEnd:
SMB2U_GFX_FG_StandardDesertTiles:
	db "GFX_FG_StandardDesertTiles.bin"
SMB2U_GFX_FG_StandardDesertTilesEnd:
SMB2U_GFX_FG_StandardGrasslandTiles:
	db "GFX_FG_StandardGrasslandTiles.bin"
SMB2U_GFX_FG_StandardGrasslandTilesEnd:
SMB2U_GFX_FG_StandardSkyTiles:
	db "GFX_FG_StandardSkyTiles.bin"
SMB2U_GFX_FG_StandardSkyTilesEnd:
SMB2U_GFX_FG_StandardSnowTiles:
	db "GFX_FG_StandardSnowTiles.bin"
SMB2U_GFX_FG_StandardSnowTilesEnd:
SMB2U_GFX_FG_VeggieMachine:
	db "GFX_FG_VeggieMachine.bin"
SMB2U_GFX_FG_VeggieMachineEnd:
SMB2U_GFX_GameOverTiles:
	db "GFX_GameOverTiles.bin"
SMB2U_GFX_GameOverTilesEnd:
SMB2U_GFX_Layer3:
	db "GFX_Layer3.bin"
SMB2U_GFX_Layer3End:
SMB2U_GFX_LevelPreviewBorder:
if !ROMVer&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	db "GFX_LevelPreviewBorder_SMAS_J.bin"
else
	db "GFX_LevelPreviewBorder_SMAS_U.bin"
endif
SMB2U_GFX_LevelPreviewBorderEnd:
SMB2U_GFX_LevelPreviewTiles:
	db "GFX_LevelPreviewTiles.bin"
SMB2U_GFX_LevelPreviewTilesEnd:
SMB2U_GFX_PauseMenu:
if !ROMVer&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	db "GFX_PauseMenu_SMAS_J.bin"
else
	db "GFX_PauseMenu_SMAS_U.bin"
endif
SMB2U_GFX_PauseMenuEnd:
SMB2U_GFX_Player_Luigi:
	db "GFX_Player_Luigi.bin"
SMB2U_GFX_Player_LuigiEnd:
SMB2U_GFX_Player_Mario:
	db "GFX_Player_Mario.bin"
SMB2U_GFX_Player_MarioEnd:
SMB2U_GFX_Player_Peach:
	db "GFX_Player_Peach.bin"
SMB2U_GFX_Player_PeachEnd:
SMB2U_GFX_Player_Toad:
	db "GFX_Player_Toad.bin"
SMB2U_GFX_Player_ToadEnd:
SMB2U_GFX_Player_UnusedDuplicates:
	db "GFX_Player_UnusedDuplicates.bin"
SMB2U_GFX_Player_UnusedDuplicatesEnd:
SMB2U_GFX_ShadedFont:
	db "GFX_ShadedFont.bin"
SMB2U_GFX_ShadedFontEnd:
SMB2U_GFX_SlotMachineReels:
	db "GFX_SlotMachineReels.bin"
SMB2U_GFX_SlotMachineReelsEnd:
SMB2U_GFX_Sprite_Albatoss:
	db "GFX_Sprite_Albatoss.bin"
SMB2U_GFX_Sprite_AlbatossEnd:
SMB2U_GFX_Sprite_BirdoSparkBobOmbAndDesertObjects:
	db "GFX_Sprite_BirdoSparkBobOmbAndDesertObjects.bin"
SMB2U_GFX_Sprite_BirdoSparkBobOmbAndDesertObjectsEnd:
SMB2U_GFX_Sprite_BirdoSparkBobOmbAndGrasslandObjects:
	db "GFX_Sprite_BirdoSparkBobOmbAndGrasslandObjects.bin"
SMB2U_GFX_Sprite_BirdoSparkBobOmbAndGrasslandObjectsEnd:
SMB2U_GFX_Sprite_BirdoSparkBobOmbAndSkyObjects:
	db "GFX_Sprite_BirdoSparkBobOmbAndSkyObjects.bin"
SMB2U_GFX_Sprite_BirdoSparkBobOmbAndSkyObjectsEnd:
SMB2U_GFX_Sprite_BirdoSparkBobOmbAndSnowObjects:
	db "GFX_Sprite_BirdoSparkBobOmbAndSnowObjects.bin"
SMB2U_GFX_Sprite_BirdoSparkBobOmbAndSnowObjectsEnd:
SMB2U_GFX_Sprite_Clawgrip:
	db "GFX_Sprite_Clawgrip.bin"
SMB2U_GFX_Sprite_ClawgripEnd:
SMB2U_GFX_Sprite_DesertEnemies:
	db "GFX_Sprite_DesertEnemies.bin"
SMB2U_GFX_Sprite_DesertEnemiesEnd:
SMB2U_GFX_Sprite_DynamicSprites:
	db "GFX_Sprite_DynamicSprites.bin"
SMB2U_GFX_Sprite_DynamicSpritesEnd:
SMB2U_GFX_Sprite_EndingScreen2_1:
	db "GFX_Sprite_EndingScreen2_1.bin"
SMB2U_GFX_Sprite_EndingScreen2_1End:
SMB2U_GFX_Sprite_EndingScreen2_2:
	db "GFX_Sprite_EndingScreen2_2.bin"
SMB2U_GFX_Sprite_EndingScreen2_2End:
SMB2U_GFX_Sprite_EndingScreen3:
if !ROMVer&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	db "GFX_Sprite_EndingScreen3_SMAS_J.bin"
else
	db "GFX_Sprite_EndingScreen3_SMAS_U.bin"
endif
SMB2U_GFX_Sprite_EndingScreen3End:
SMB2U_GFX_Sprite_Fryguy:
	db "GFX_Sprite_Fryguy.bin"
SMB2U_GFX_Sprite_FryguyEnd:
SMB2U_GFX_Sprite_Global1:
	db "GFX_Sprite_Global1.bin"
SMB2U_GFX_Sprite_Global1End:
SMB2U_GFX_Sprite_Global2:
	db "GFX_Sprite_Global2.bin"
SMB2U_GFX_Sprite_Global2End:
SMB2U_GFX_Sprite_GrasslandEnemies:
	db "GFX_Sprite_GrasslandEnemies.bin"
SMB2U_GFX_Sprite_GrasslandEnemiesEnd:
SMB2U_GFX_Sprite_Mouser:
	db "GFX_Sprite_Mouser.bin"
SMB2U_GFX_Sprite_MouserEnd:
SMB2U_GFX_Sprite_SkyEnemies:
	db "GFX_Sprite_SkyEnemies.bin"
SMB2U_GFX_Sprite_SkyEnemiesEnd:
SMB2U_GFX_Sprite_SnowEnemies:
	db "GFX_Sprite_SnowEnemies.bin"
SMB2U_GFX_Sprite_SnowEnemiesEnd:
SMB2U_GFX_Sprite_StandardEnemies:
	db "GFX_Sprite_StandardEnemies.bin"
SMB2U_GFX_Sprite_StandardEnemiesEnd:
SMB2U_GFX_Sprite_Tryclyde:
	db "GFX_Sprite_Tryclyde.bin"
SMB2U_GFX_Sprite_TryclydeEnd:
SMB2U_GFX_Sprite_Wart1:
	db "GFX_Sprite_Wart1.bin"
SMB2U_GFX_Sprite_Wart1End:
SMB2U_GFX_Sprite_Wart2:
	db "GFX_Sprite_Wart2.bin"
SMB2U_GFX_Sprite_Wart2End:
SMB2U_GFX_StaticSleepingMario:
	db "GFX_StaticSleepingMario.bin"
SMB2U_GFX_StaticSleepingMarioEnd:
SMB2U_GFX_TitleScreenBorder:
	db "GFX_TitleScreenBorder.bin"
SMB2U_GFX_TitleScreenBorderEnd:
SMB2U_GFX_TitleScreenCharacters:
if !ROMVer&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	db "GFX_TitleScreenCharacters_SMAS_J.bin"
else
	db "GFX_TitleScreenCharacters_SMAS_U.bin"
endif
SMB2U_GFX_TitleScreenCharactersEnd:
SMB2U_GFX_TitleScreenLogo:
if !ROMVer&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	db "GFX_TitleScreenLogo_SMAS_J.bin"
else
	db "GFX_TitleScreenLogo_SMAS_U.bin"
endif
SMB2U_GFX_TitleScreenLogoEnd:
SMB2U_GFX_UnusedCharacterSelectCharacterTiles:
	db "GFX_UnusedCharacterSelectCharacterTiles.bin"
SMB2U_GFX_UnusedCharacterSelectCharacterTilesEnd:
SMB2U_GFX_WarpZoneTiles:
	db "GFX_WarpZoneTiles.bin"
SMB2U_GFX_WarpZoneTilesEnd:

;--------------------------------------------------------------------

SMB2U_Music_CharacterSelect:
	db "CharacterSelect.bin"
SMB2U_Music_CharacterSelectEnd:
SMB2U_Music_Danger:
	db "Danger.bin"
SMB2U_Music_DangerEnd:
SMB2U_Music_Death:
	db "Death.bin"
SMB2U_Music_DeathEnd:
SMB2U_Music_Ending:
	db "Ending.bin"
SMB2U_Music_EndingEnd:
SMB2U_Music_Fanfare:
	db "Fanfare.bin"
SMB2U_Music_FanfareEnd:
SMB2U_Music_GameOver:
	db "GameOver.bin"
SMB2U_Music_GameOverEnd:
SMB2U_Music_HaveStar:
	db "HaveStar.bin"
SMB2U_Music_HaveStarEnd:
SMB2U_Music_Overworld:
	db "Overworld.bin"
SMB2U_Music_OverworldEnd:
SMB2U_Music_Subspace:
	db "Subspace.bin"
SMB2U_Music_SubspaceEnd:
SMB2U_Music_TitleScreen:
	db "TitleScreen.bin"
SMB2U_Music_TitleScreenEnd:
SMB2U_Music_Underground:
	db "Underground.bin"
SMB2U_Music_UndergroundEnd:
SMB2U_Music_UnusedFanfare:
	db "UnusedFanfare.bin"
SMB2U_Music_UnusedFanfareEnd:
SMB2U_Music_WarpZone:
	db "WarpZone.bin"
SMB2U_Music_WarpZoneEnd:
SMB2U_Music_WartBattle:
	db "WartBattle.bin"
SMB2U_Music_WartBattleEnd:
SMB2U_Music_WonSlots:
	db "WonSlots.bin"
SMB2U_Music_WonSlotsEnd:
SMB2U_Music_WorldClear:
	db "WorldClear.bin"
SMB2U_Music_WorldClearEnd:

;--------------------------------------------------------------------

SMB3_GFX_BG_Fortress1:
	db "GFX_BG_Fortress1.bin"
SMB3_GFX_BG_Fortress1End:
SMB3_GFX_BG_Fortress2:
	db "GFX_BG_Fortress2.bin"
SMB3_GFX_BG_Fortress2End:
SMB3_GFX_BG_SnowTrees1:
	db "GFX_BG_SnowTrees1.bin"
SMB3_GFX_BG_SnowTrees1End:
SMB3_GFX_BG_SnowTrees2:
	db "GFX_BG_SnowTrees2.bin"
SMB3_GFX_BG_SnowTrees2End:
SMB3_GFX_BG_Pipes1:
	db "GFX_BG_Pipes1.bin"
SMB3_GFX_BG_Pipes1End:
SMB3_GFX_BG_Pipes2:
	db "GFX_BG_Pipes2.bin"
SMB3_GFX_BG_Pipes2End:
SMB3_GFX_BG_CastleWall:
	db "GFX_BG_CastleWall.bin"
SMB3_GFX_BG_CastleWallEnd:
SMB3_GFX_BG_HillsAndTrees:
	db "GFX_BG_HillsAndTrees.bin"
SMB3_GFX_BG_HillsAndTreesEnd:
SMB3_GFX_BG_DottedHills1:
	db "GFX_BG_DottedHills1.bin"
SMB3_GFX_BG_DottedHills1End:
SMB3_GFX_BG_DottedHills2:
	db "GFX_BG_DottedHills2.bin"
SMB3_GFX_BG_DottedHills2End:
SMB3_GFX_BG_Desert1:
	db "GFX_BG_Desert1.bin"
SMB3_GFX_BG_Desert1End:
SMB3_GFX_BG_Desert2:
	db "GFX_BG_Desert2.bin"
SMB3_GFX_BG_Desert2End:
SMB3_GFX_BG_CheckeredHills1:
	db "GFX_BG_CheckeredHills1.bin"
SMB3_GFX_BG_CheckeredHills1End:
SMB3_GFX_BG_CheckeredHills2:
	db "GFX_BG_CheckeredHills2.bin"
SMB3_GFX_BG_CheckeredHills2End:
SMB3_GFX_BG_SnowyCheckeredHills1:
	db "GFX_BG_SnowyCheckeredHills1.bin"
SMB3_GFX_BG_SnowyCheckeredHills1End:
SMB3_GFX_BG_SnowyCheckeredHills2:
	db "GFX_BG_SnowyCheckeredHills2.bin"
SMB3_GFX_BG_SnowyCheckeredHills2End:
SMB3_GFX_BG_ToadHouse_SMASU:
	db "GFX_BG_ToadHouse_SMASU.bin"
SMB3_GFX_BG_ToadHouse_SMASUEnd:
SMB3_GFX_BG_ToadHouse_USA:
	db "GFX_BG_ToadHouse_USA.bin"
SMB3_GFX_BG_ToadHouse_USAEnd:
SMB3_GFX_BG_TitleScreen:
	db "GFX_BG_TitleScreen.bin"
SMB3_GFX_BG_TitleScreenEnd:
SMB3_GFX_BG_Underwater1:
	db "GFX_BG_Underwater1.bin"
SMB3_GFX_BG_Underwater1End:
SMB3_GFX_BG_Underwater2:
	db "GFX_BG_Underwater2.bin"
SMB3_GFX_BG_Underwater2End:
SMB3_GFX_BG_StormClouds:
	db "GFX_BG_StormClouds.bin"
SMB3_GFX_BG_StormCloudsEnd:
SMB3_GFX_BG_AirshipInterior:
	db "GFX_BG_AirshipInterior.bin"
SMB3_GFX_BG_AirshipInteriorEnd:
SMB3_GFX_BG_ConstructedPlain:
	db "GFX_BG_ConstructedPlain.bin"
SMB3_GFX_BG_ConstructedPlainEnd:
SMB3_GFX_BG_BonusRoom:
	db "GFX_BG_BonusRoom.bin"
SMB3_GFX_BG_BonusRoomEnd:
SMB3_GFX_BG_CavePillar1:
	db "GFX_BG_CavePillar1.bin"
SMB3_GFX_BG_CavePillar1End:
SMB3_GFX_BG_CavePillar2:
	db "GFX_BG_CavePillar2.bin"
SMB3_GFX_BG_CavePillar2End:
SMB3_GFX_BG_Prison:
	db "GFX_BG_Prison.bin"
SMB3_GFX_BG_PrisonEnd:
SMB3_GFX_BG_BattleMode:
	db "GFX_BG_BattleMode.bin"
SMB3_GFX_BG_BattleModeEnd:
SMB3_GFX_BG_Volcano1:
	db "GFX_BG_Volcano1.bin"
SMB3_GFX_BG_Volcano1End:
SMB3_GFX_BG_Volcano2:
	db "GFX_BG_Volcano2.bin"
SMB3_GFX_BG_Volcano2End:
SMB3_GFX_BG_PeachsRoom1:
	db "GFX_BG_PeachsRoom1.bin"
SMB3_GFX_BG_PeachsRoom1End:
SMB3_GFX_BG_PeachsRoom2:
	db "GFX_BG_PeachsRoom2.bin"
SMB3_GFX_BG_PeachsRoom2End:
SMB3_GFX_BG_Clouds:
	db "GFX_BG_Clouds.bin"
SMB3_GFX_BG_CloudsEnd:
SMB3_GFX_BG_CrystalCave:
	db "GFX_BG_CrystalCave.bin"
SMB3_GFX_BG_CrystalCaveEnd:
SMB3_GFX_BG_WaterfallCliff:
	db "GFX_BG_WaterfallCliff.bin"
SMB3_GFX_BG_WaterfallCliffEnd:
SMB3_GFX_BG_BowsersCastle1:
	db "GFX_BG_BowsersCastle1.bin"
SMB3_GFX_BG_BowsersCastle1End:
SMB3_GFX_BG_BowsersCastle2:
	db "GFX_BG_BowsersCastle2.bin"
SMB3_GFX_BG_BowsersCastle2End:
SMB3_GFX_BG_Leaves1:
	db "GFX_BG_Leaves1.bin"
SMB3_GFX_BG_Leaves1End:
SMB3_GFX_BG_Leaves2:
	db "GFX_BG_Leaves2.bin"
SMB3_GFX_BG_Leaves2End:

;--------------------------------------------------------------------

SMB3_GFX_WorldRollcallSpritesAndMario:
	db "GFX_WorldRollcallSpritesAndMario.bin"
SMB3_GFX_WorldRollcallSpritesAndMarioEnd:
SMB3_GFX_Luigi_Raccoon:
	db "GFX_Luigi_Raccoon.bin"
SMB3_GFX_Luigi_RaccoonEnd:
SMB3_GFX_Luigi_Tanooki:
	db "GFX_Luigi_Tanooki.bin"
SMB3_GFX_Luigi_TanookiEnd:
SMB3_GFX_Luigi_Hammer:
	db "GFX_Luigi_Hammer.bin"
SMB3_GFX_Luigi_HammerEnd:
SMB3_GFX_Luigi_SmallAndFrog:
	db "GFX_Luigi_SmallAndFrog.bin"
SMB3_GFX_Luigi_SmallAndFrogEnd:
SMB3_GFX_Layer3_Letters:
if !ROMVer&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	db "GFX_Layer3_Letters_SMAS_J.bin"
else
	db "GFX_Layer3_Letters_SMAS_U.bin"
endif
SMB3_GFX_Layer3_LettersEnd:
SMB3_GFX_Layer3_Water:
	db "GFX_Layer3_Water.bin"
SMB3_GFX_Layer3_WaterEnd:
SMB3_GFX_Layer3_Clouds:
	db "GFX_Layer3_Clouds.bin"
SMB3_GFX_Layer3_CloudsEnd:
SMB3_GFX_Layer3_Pillars:
	db "GFX_Layer3_Pillars.bin"
SMB3_GFX_Layer3_PillarsEnd:
SMB3_GFX_Layer3_Cave:
	db "GFX_Layer3_Cave.bin"
SMB3_GFX_Layer3_CaveEnd:
SMB3_GFX_Layer3_AirshipClouds:
	db "GFX_Layer3_AirshipClouds.bin"
SMB3_GFX_Layer3_AirshipCloudsEnd:
SMB3_GFX_Sprite_Overworld:
	db "GFX_Sprite_Overworld.bin"
SMB3_GFX_Sprite_OverworldEnd:
SMB3_GFX_Sprite_ThroneRoom:
	db "GFX_Sprite_ThroneRoom.bin"
SMB3_GFX_Sprite_ThroneRoomEnd:
SMB3_GFX_FG_AnimatedOverworldTiles5:
	db "GFX_FG_AnimatedOverworldTiles5.bin"
SMB3_GFX_FG_AnimatedOverworldTiles5End:
SMB3_GFX_FG_AnimatedOverworldTiles6:
	db "GFX_FG_AnimatedOverworldTiles6.bin"
SMB3_GFX_FG_AnimatedOverworldTiles6End:
SMB3_GFX_FG_AnimatedOverworldTiles7:
	db "GFX_FG_AnimatedOverworldTiles7.bin"
SMB3_GFX_FG_AnimatedOverworldTiles7End:
SMB3_GFX_FG_AnimatedOverworldTiles8:
	db "GFX_FG_AnimatedOverworldTiles8.bin"
SMB3_GFX_FG_AnimatedOverworldTiles8End:
SMB3_GFX_FG_SpadeGamePowerUps4:
	db "GFX_FG_SpadeGamePowerUps4.bin"
SMB3_GFX_FG_SpadeGamePowerUps4End:
SMB3_GFX_FG_SkyPlain2:
	db "GFX_FG_SkyPlain2.bin"
SMB3_GFX_FG_SkyPlain2End:
SMB3_GFX_FG_GrassPlain2:
	db "GFX_FG_GrassPlain2.bin"
SMB3_GFX_FG_GrassPlain2End:
SMB3_GFX_FG_Cave2:
	db "GFX_FG_Cave2.bin"
SMB3_GFX_FG_Cave2End:
SMB3_GFX_FG_EndOfLevelDecor:
	db "GFX_FG_EndOfLevelDecor.bin"
SMB3_GFX_FG_EndOfLevelDecorEnd:
SMB3_GFX_BattleModePlayer:
	db "GFX_BattleModePlayer.bin"
SMB3_GFX_BattleModePlayerEnd:
SMB3_GFX_Sprite_BattleMode2:
	db "GFX_Sprite_BattleMode2.bin"
SMB3_GFX_Sprite_BattleMode2End:
SMB3_GFX_UnusedSMWKoopa:
	db "GFX_UnusedSMWKoopa.bin"
SMB3_GFX_UnusedSMWKoopaEnd:
SMB3_GFX_WorldRollcallSpritesAndLuigi:
	db "GFX_WorldRollcallSpritesAndLuigi.bin"
SMB3_GFX_WorldRollcallSpritesAndLuigiEnd:
SMB3_GFX_Mario_Raccoon:
	db "GFX_Mario_Raccoon.bin"
SMB3_GFX_Mario_RaccoonEnd:
SMB3_GFX_Mario_Tanooki:
	db "GFX_Mario_Tanooki.bin"
SMB3_GFX_Mario_TanookiEnd:
SMB3_GFX_Mario_Hammer:
	db "GFX_Mario_Hammer.bin"
SMB3_GFX_Mario_HammerEnd:
SMB3_GFX_Mario_SmallAndFrog:
	db "GFX_Mario_SmallAndFrog.bin"
SMB3_GFX_Mario_SmallAndFrogEnd:
SMB3_GFX_Mario_Big:
	db "GFX_Mario_Big.bin"
SMB3_GFX_Mario_BigEnd:
SMB3_GFX_Sprite_TitleScreen2:
	db "GFX_Sprite_TitleScreen2.bin"
SMB3_GFX_Sprite_TitleScreen2End:
SMB3_GFX_Sprite_Global1:
	db "GFX_Sprite_Global1.bin"
SMB3_GFX_Sprite_Global1End:
SMB3_GFX_Sprite_Global3:
	db "GFX_Sprite_Global3.bin"
SMB3_GFX_Sprite_Global3End:
SMB3_GFX_Luigi_Big:
	db "GFX_Luigi_Big.bin"
SMB3_GFX_Luigi_BigEnd:
SMB3_GFX_Sprite_BattleMode1:
	db "GFX_Sprite_BattleMode1.bin"
SMB3_GFX_Sprite_BattleMode1End:
SMB3_GFX_Sprite_AirshipSprites1:
	db "GFX_Sprite_AirshipSprites1.bin"
SMB3_GFX_Sprite_AirshipSprites1End:
SMB3_GFX_Sprite_AirshipSprites2:
	db "GFX_Sprite_AirshipSprites2.bin"
SMB3_GFX_Sprite_AirshipSprites2End:
SMB3_GFX_Sprite_AirshipSprites3:
	db "GFX_Sprite_AirshipSprites3.bin"
SMB3_GFX_Sprite_AirshipSprites3End:
SMB3_GFX_Sprite_DesertEnemies:
	db "GFX_Sprite_DesertEnemies.bin"
SMB3_GFX_Sprite_DesertEnemiesEnd:
SMB3_GFX_Sprite_Global2:
	db "GFX_Sprite_Global2.bin"
SMB3_GFX_Sprite_Global2End:
SMB3_GFX_Sprite_ChestItems:
	db "GFX_Sprite_ChestItems.bin"
SMB3_GFX_Sprite_ChestItemsEnd:
SMB3_GFX_FG_ConstructedPlains:
	db "GFX_FG_ConstructedPlains.bin"
SMB3_GFX_FG_ConstructedPlainsEnd:
SMB3_GFX_Sprite_SpikeAndMunchers:
	db "GFX_Sprite_SpikeAndMunchers.bin"
SMB3_GFX_Sprite_SpikeAndMunchersEnd:
SMB3_GFX_Sprite_LakituSpinyAndBuzzyBeetle:
	db "GFX_Sprite_LakituSpinyAndBuzzyBeetle.bin"
SMB3_GFX_Sprite_LakituSpinyAndBuzzyBeetleEnd:
SMB3_GFX_FG_SkyPlain1:
	db "GFX_FG_SkyPlain1.bin"
SMB3_GFX_FG_SkyPlain1End:
SMB3_GFX_Sprite_SkySprites:
	db "GFX_Sprite_SkySprites.bin"
SMB3_GFX_Sprite_SkySpritesEnd:
SMB3_GFX_Sprite_Empty2:
	db "GFX_Sprite_Empty2.bin"
SMB3_GFX_Sprite_Empty2End:
SMB3_GFX_FG_Fortress:
	db "GFX_FG_Fortress.bin"
SMB3_GFX_FG_FortressEnd:
SMB3_GFX_Sprite_Fortress1:
	db "GFX_Sprite_Fortress1.bin"
SMB3_GFX_Sprite_Fortress1End:
SMB3_GFX_Sprite_Fortress2:
	db "GFX_Sprite_Fortress2.bin"
SMB3_GFX_Sprite_Fortress2End:
SMB3_GFX_FG_AnimatedOverworldTiles1:
	db "GFX_FG_AnimatedOverworldTiles1.bin"
SMB3_GFX_FG_AnimatedOverworldTiles1End:
SMB3_GFX_FG_StaticOverworldTiles:
	db "GFX_FG_StaticOverworldTiles.bin"
SMB3_GFX_FG_StaticOverworldTilesEnd:
SMB3_GFX_FG_SnowAndIce:
	db "GFX_FG_SnowAndIce.bin"
SMB3_GFX_FG_SnowAndIceEnd:
SMB3_GFX_Sprite_UnderwaterEnemies:
	db "GFX_Sprite_UnderwaterEnemies.bin"
SMB3_GFX_Sprite_UnderwaterEnemiesEnd:
SMB3_GFX_Sprite_LavaLotus:
	db "GFX_Sprite_LavaLotus.bin"
SMB3_GFX_Sprite_LavaLotusEnd:
SMB3_GFX_FG_Cave1:
	db "GFX_FG_Cave1.bin"
SMB3_GFX_FG_Cave1End:
SMB3_GFX_FG_MinigameIntroLuigi:
	db "GFX_FG_MinigameIntroLuigi.bin"
SMB3_GFX_FG_MinigameIntroLuigiEnd:
SMB3_GFX_FG_Bowser:
	db "GFX_FG_Bowser.bin"
SMB3_GFX_FG_BowserEnd:
SMB3_GFX_FG_MinigameIntro:
	db "GFX_FG_MinigameIntro.bin"
SMB3_GFX_FG_MinigameIntroEnd:
SMB3_GFX_FG_StandardTiles:
	db "GFX_FG_StandardTiles.bin"
SMB3_GFX_FG_StandardTilesEnd:
SMB3_GFX_FG_ThroneRoom:
	db "GFX_FG_ThroneRoom.bin"
SMB3_GFX_FG_ThroneRoomEnd:
SMB3_GFX_Sprite_DynamicDoorAndLetters:
	db "GFX_Sprite_DynamicDoorAndLetters.bin"
SMB3_GFX_Sprite_DynamicDoorAndLettersEnd:
SMB3_GFX_Sprite_MiniGameHost:
	db "GFX_Sprite_MiniGameHost.bin"
SMB3_GFX_Sprite_MiniGameHostEnd:
SMB3_GFX_FG_SpadeGamePowerUps1:
	db "GFX_FG_SpadeGamePowerUps1.bin"
SMB3_GFX_FG_SpadeGamePowerUps1End:
SMB3_GFX_FG_SpadeGamePowerUps2:
	db "GFX_FG_SpadeGamePowerUps2.bin"
SMB3_GFX_FG_SpadeGamePowerUps2End:
SMB3_GFX_FG_SpadeGamePowerUps3:
	db "GFX_FG_SpadeGamePowerUps3.bin"
SMB3_GFX_FG_SpadeGamePowerUps3End:
SMB3_GFX_FG_Desert1:
	db "GFX_FG_Desert1.bin"
SMB3_GFX_FG_Desert1End:
SMB3_GFX_FG_Desert2:
	db "GFX_FG_Desert2.bin"
SMB3_GFX_FG_Desert2End:
SMB3_GFX_Sprite_BoomBoom:
	db "GFX_Sprite_BoomBoom.bin"
SMB3_GFX_Sprite_BoomBoomEnd:
SMB3_GFX_FG_Airship1:
	db "GFX_FG_Airship1.bin"
SMB3_GFX_FG_Airship1End:
SMB3_GFX_FG_Airship2:
	db "GFX_FG_Airship2.bin"
SMB3_GFX_FG_Airship2End:
SMB3_GFX_FG_PeachLetterFont:
if !ROMVer&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	db "GFX_FG_PeachLetterFont_SMAS_J.bin"
else
	db "GFX_FG_PeachLetterFont_SMAS_U.bin"
endif
SMB3_GFX_FG_PeachLetterFontEnd:
SMB3_GFX_FG_Cloud1:
	db "GFX_FG_Cloud1.bin"
SMB3_GFX_FG_Cloud1End:
SMB3_GFX_FG_Cloud2:
	db "GFX_FG_Cloud2.bin"
SMB3_GFX_FG_Cloud2End:
SMB3_GFX_FG_AnimatedStripeNSpadeTiles:
	db "GFX_FG_AnimatedStripeNSpadeTiles.bin"
SMB3_GFX_FG_AnimatedStripeNSpadeTilesEnd:
SMB3_GFX_Sprite_AltGlobal2:
	db "GFX_Sprite_AltGlobal2.bin"
SMB3_GFX_Sprite_AltGlobal2End:
SMB3_GFX_Sprite_GiantEnemies:
	db "GFX_Sprite_GiantEnemies.bin"
SMB3_GFX_Sprite_GiantEnemiesEnd:
SMB3_GFX_FG_AnimatedLevelTiles1:
	db "GFX_FG_AnimatedLevelTiles1.bin"
SMB3_GFX_FG_AnimatedLevelTiles1End:
SMB3_GFX_Sprite_KoopaKids1:
	db "GFX_Sprite_KoopaKids1.bin"
SMB3_GFX_Sprite_KoopaKids1End:
SMB3_GFX_Sprite_KoopaKids2:
	db "GFX_Sprite_KoopaKids2.bin"
SMB3_GFX_Sprite_KoopaKids2End:
SMB3_GFX_Sprite_KoopaKids3:
	db "GFX_Sprite_KoopaKids3.bin"
SMB3_GFX_Sprite_KoopaKids3End:
SMB3_GFX_Sprite_KoopaKids4:
	db "GFX_Sprite_KoopaKids4.bin"
SMB3_GFX_Sprite_KoopaKids4End:
SMB3_GFX_Sprite_BossBass:
	db "GFX_Sprite_BossBass.bin"
SMB3_GFX_Sprite_BossBassEnd:
SMB3_GFX_FG_BattleMode1:
if !ROMVer&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	db "GFX_FG_BattleMode1_SMAS_J.bin"
else
	db "GFX_FG_BattleMode1_SMAS_U.bin"
endif
SMB3_GFX_FG_BattleMode1End:
SMB3_GFX_FG_BattleMode2:
if !ROMVer&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	db "GFX_FG_BattleMode2_SMAS_J.bin"
else
	db "GFX_FG_BattleMode2_SMAS_U.bin"
endif
SMB3_GFX_FG_BattleMode2End:
SMB3_GFX_Sprite_KoopaKidsShell:
	db "GFX_Sprite_KoopaKidsShell.bin"
SMB3_GFX_Sprite_KoopaKidsShellEnd:
SMB3_GFX_Sprite_GiantBlocks:
	db "GFX_Sprite_GiantBlocks.bin"
SMB3_GFX_Sprite_GiantBlocksEnd:
SMB3_GFX_Sprite_FlyingBoomBoom:
	db "GFX_Sprite_FlyingBoomBoom.bin"
SMB3_GFX_Sprite_FlyingBoomBoomEnd:
SMB3_GFX_Sprite_BroEnemies:
	db "GFX_Sprite_BroEnemies.bin"
SMB3_GFX_Sprite_BroEnemiesEnd:
SMB3_GFX_Sprite_StandardEnemies:
	db "GFX_Sprite_StandardEnemies.bin"
SMB3_GFX_Sprite_StandardEnemiesEnd:
SMB3_GFX_Sprite_Bowser1:
	db "GFX_Sprite_Bowser1.bin"
SMB3_GFX_Sprite_Bowser1End:
SMB3_GFX_Sprite_Bowser2:
	db "GFX_Sprite_Bowser2.bin"
SMB3_GFX_Sprite_Bowser2End:
SMB3_GFX_Sprite_Bowser3:
	db "GFX_Sprite_Bowser3.bin"
SMB3_GFX_Sprite_Bowser3End:
SMB3_GFX_Sprite_AltStandardEnemies:
	db "GFX_Sprite_AltStandardEnemies.bin"
SMB3_GFX_Sprite_AltStandardEnemiesEnd:
SMB3_GFX_StatusBar:
	db "GFX_StatusBar.bin"
SMB3_GFX_StatusBarEnd:
SMB3_GFX_FG_Pipe:
	db "GFX_FG_Pipe.bin"
SMB3_GFX_FG_PipeEnd:
SMB3_GFX_Sprite_Pipe:
	db "GFX_Sprite_Pipe.bin"
SMB3_GFX_Sprite_PipeEnd:
SMB3_GFX_Sprite_CopyOfMiniGameHost:
	db "GFX_Sprite_CopyOfMiniGameHost.bin"
SMB3_GFX_Sprite_CopyOfMiniGameHostEnd:
SMB3_GFX_FG_ToadHouse1:
	db "GFX_FG_ToadHouse1.bin"
SMB3_GFX_FG_ToadHouse1End:
SMB3_GFX_FG_ToadHouse2:
	db "GFX_FG_ToadHouse2.bin"
SMB3_GFX_FG_ToadHouse2End:
SMB3_GFX_Sprite_Empty1:
	db "GFX_Sprite_Empty1.bin"
SMB3_GFX_Sprite_Empty1End:
SMB3_GFX_FG_AnimatedLevelTiles2:
	db "GFX_FG_AnimatedLevelTiles2.bin"
SMB3_GFX_FG_AnimatedLevelTiles2End:
SMB3_GFX_FG_AnimatedLevelTiles3:
	db "GFX_FG_AnimatedLevelTiles3.bin"
SMB3_GFX_FG_AnimatedLevelTiles3End:
SMB3_GFX_FG_AnimatedLevelTiles4:
	db "GFX_FG_AnimatedLevelTiles4.bin"
SMB3_GFX_FG_AnimatedLevelTiles4End:
SMB3_GFX_FG_AnimatedLevelTiles5:
	db "GFX_FG_AnimatedLevelTiles5.bin"
SMB3_GFX_FG_AnimatedLevelTiles5End:
SMB3_GFX_FG_GrassyConstructedPlains:
	db "GFX_FG_GrassyConstructedPlains.bin"
SMB3_GFX_FG_GrassyConstructedPlainsEnd:
SMB3_GFX_FG_Airship3:
	db "GFX_FG_Airship3.bin"
SMB3_GFX_FG_Airship3End:
SMB3_GFX_FG_Airship4:
	db "GFX_FG_Airship4.bin"
SMB3_GFX_FG_Airship4End:
SMB3_GFX_FG_GrassPlain1:
	db "GFX_FG_GrassPlain1.bin"
SMB3_GFX_FG_GrassPlain1End:
SMB3_GFX_FG_Giant1:
	db "GFX_FG_Giant1.bin"
SMB3_GFX_FG_Giant1End:
SMB3_GFX_FG_Giant2:
	db "GFX_FG_Giant2.bin"
SMB3_GFX_FG_Giant2End:
SMB3_GFX_FG_AnimatedOverworldTiles2:
	db "GFX_FG_AnimatedOverworldTiles2.bin"
SMB3_GFX_FG_AnimatedOverworldTiles2End:
SMB3_GFX_FG_AnimatedOverworldTiles3:
	db "GFX_FG_AnimatedOverworldTiles3.bin"
SMB3_GFX_FG_AnimatedOverworldTiles3End:
SMB3_GFX_FG_AnimatedOverworldTiles4:
	db "GFX_FG_AnimatedOverworldTiles4.bin"
SMB3_GFX_FG_AnimatedOverworldTiles4End:
SMB3_GFX_UnknownEndingGraphics:
	db "GFX_UnknownEndingGraphics.bin"
SMB3_GFX_UnknownEndingGraphicsEnd:
SMB3_GFX_TitleScreen_SMASU:
	db "GFX_TitleScreen_SMASU.bin"
SMB3_GFX_TitleScreen_SMASUEnd:
SMB3_GFX_TitleScreen_USA:
	db "GFX_TitleScreen_USA.bin"
SMB3_GFX_TitleScreen_USAEnd:
SMB3_GFX_FG_WorldRollCallMiniMap:
	db "GFX_FG_WorldRollCallMiniMap.bin"
SMB3_GFX_FG_WorldRollCallMiniMapEnd:
SMB3_GFX_Sprite_LoadingLetters:
	db "GFX_Sprite_LoadingLetters.bin"
SMB3_GFX_Sprite_LoadingLettersEnd:
SMB3_GFX_Sprite_TitleScreen1:
	db "GFX_Sprite_TitleScreen1.bin"
SMB3_GFX_Sprite_TitleScreen1End:

;--------------------------------------------------------------------

SMB3_LevelMusic_Airship:
	db "Airship.bin"
SMB3_LevelMusic_AirshipEnd:
SMB3_LevelMusic_Athletic:
	db "Athletic.bin"
SMB3_LevelMusic_AthleticEnd:
SMB3_LevelMusic_BattleMode:
	db "BattleMode.bin"
SMB3_LevelMusic_BattleModeEnd:
SMB3_LevelMusic_BossBattle:
	db "BossBattle.bin"
SMB3_LevelMusic_BossBattleEnd:
SMB3_LevelMusic_BowserBattle:
	db "BowserBattle.bin"
SMB3_LevelMusic_BowserBattleEnd:
SMB3_LevelMusic_BowserFell:
	db "BowserFell.bin"
SMB3_LevelMusic_BowserFellEnd:
SMB3_LevelMusic_BowserLetter:
	db "BowserLetter.bin"
SMB3_LevelMusic_BowserLetterEnd:
SMB3_LevelMusic_CloudBonusRoom:
	db "CloudBonusRoom.bin"
SMB3_LevelMusic_CloudBonusRoomEnd:
SMB3_LevelMusic_Death:
	db "Death.bin"
SMB3_LevelMusic_DeathEnd:
SMB3_LevelMusic_Fortress:
	db "Fortress.bin"
SMB3_LevelMusic_FortressEnd:
SMB3_LevelMusic_GameOver:
	db "GameOver.bin"
SMB3_LevelMusic_GameOverEnd:
SMB3_LevelMusic_HammerBroEncounter:
	db "HammerBroEncounter.bin"
SMB3_LevelMusic_HammerBroEncounterEnd:
SMB3_LevelMusic_HaveStar:
	db "HaveStar.bin"
SMB3_LevelMusic_HaveStarEnd:
SMB3_LevelMusic_Overworld:
	db "Overworld.bin"
SMB3_LevelMusic_OverworldEnd:
SMB3_LevelMusic_PassedBoss:
	db "PassedBoss.bin"
SMB3_LevelMusic_PassedBossEnd:
SMB3_LevelMusic_PassedLevel:
	db "PassedLevel.bin"
SMB3_LevelMusic_PassedLevelEnd:
SMB3_LevelMusic_PeachLetter:
	db "PeachLetter.bin"
SMB3_LevelMusic_PeachLetterEnd:
SMB3_LevelMusic_ThroneRoom:
	db "ThroneRoom.bin"
SMB3_LevelMusic_ThroneRoomEnd:
SMB3_LevelMusic_TitleScreen:
	db "TitleScreen.bin"
SMB3_LevelMusic_TitleScreenEnd:
SMB3_LevelMusic_ToadHouse:
	db "ToadHouse.bin"
SMB3_LevelMusic_ToadHouseEnd:
SMB3_LevelMusic_Underground:
	db "Underground.bin"
SMB3_LevelMusic_UndergroundEnd:
SMB3_LevelMusic_Underwater:
	db "Underwater.bin"
SMB3_LevelMusic_UnderwaterEnd:
SMB3_LevelMusic_Victory:
	db "Victory.bin"
SMB3_LevelMusic_VictoryEnd:
SMB3_LevelMusic_WorldClear:
	db "WorldClear.bin"
SMB3_LevelMusic_WorldClearEnd:

;--------------------------------------------------------------------

SMB3_OverworldMusic_CloudBonusRoom:
	db "CloudBonusRoom.bin"
SMB3_OverworldMusic_CloudBonusRoomEnd:
SMB3_OverworldMusic_Minigame:
	db "Minigame.bin"
SMB3_OverworldMusic_MinigameEnd:
SMB3_OverworldMusic_MusicBox:
	db "MusicBox.bin"
SMB3_OverworldMusic_MusicBoxEnd:
SMB3_OverworldMusic_PeachRescued:
	db "PeachRescued.bin"
SMB3_OverworldMusic_PeachRescuedEnd:
SMB3_OverworldMusic_ToadHouse:
	db "ToadHouse.bin"
SMB3_OverworldMusic_ToadHouseEnd:
SMB3_OverworldMusic_Underground:
	db "Underground.bin"
SMB3_OverworldMusic_UndergroundEnd:
SMB3_OverworldMusic_Victory:
	db "Victory.bin"
SMB3_OverworldMusic_VictoryEnd:
SMB3_OverworldMusic_WarpWhistle:
	db "WarpWhistle.bin"
SMB3_OverworldMusic_WarpWhistleEnd:
SMB3_OverworldMusic_World1:
	db "World1.bin"
SMB3_OverworldMusic_World1End:
SMB3_OverworldMusic_World2:
	db "World2.bin"
SMB3_OverworldMusic_World2End:
SMB3_OverworldMusic_World3:
	db "World3.bin"
SMB3_OverworldMusic_World3End:
SMB3_OverworldMusic_World4:
	db "World4.bin"
SMB3_OverworldMusic_World4End:
SMB3_OverworldMusic_World5:
	db "World5.bin"
SMB3_OverworldMusic_World5End:
SMB3_OverworldMusic_World6:
	db "World6.bin"
SMB3_OverworldMusic_World6End:
SMB3_OverworldMusic_World7:
	db "World7.bin"
SMB3_OverworldMusic_World7End:
SMB3_OverworldMusic_World8:
	db "World8.bin"
SMB3_OverworldMusic_World8End:

;--------------------------------------------------------------------

if !ROMVer&(!ROM_SMASW_U|!ROM_SMASW_E) != $00
if !ROMVer&(!ROM_SMASW_E) != $00
SMW_CompressedGFXFile00:
	db "GFX00.lz1"
SMW_CompressedGFXFile00End:
SMW_CompressedGFXFile01:
	db "GFX01.lz1"
SMW_CompressedGFXFile01End:
SMW_CompressedGFXFile02:
	db "GFX02.lz1"
SMW_CompressedGFXFile02End:
SMW_CompressedGFXFile03:
	db "GFX03.lz1"
SMW_CompressedGFXFile03End:
SMW_CompressedGFXFile04:
	db "GFX04.lz1"
SMW_CompressedGFXFile04End:
SMW_CompressedGFXFile05:
	db "GFX05.lz1"
SMW_CompressedGFXFile05End:
SMW_CompressedGFXFile06:
	db "GFX06.lz1"
SMW_CompressedGFXFile06End:
SMW_CompressedGFXFile07:
	db "GFX07.lz1"
SMW_CompressedGFXFile07End:
SMW_CompressedGFXFile08:
	db "GFX08.lz1"
SMW_CompressedGFXFile08End:
SMW_CompressedGFXFile09:
	db "GFX09.lz1"
SMW_CompressedGFXFile09End:
SMW_CompressedGFXFile0A:
	db "GFX0A.lz1"
SMW_CompressedGFXFile0AEnd:
SMW_CompressedGFXFile0B:
	db "GFX0B.lz1"
SMW_CompressedGFXFile0BEnd:
SMW_CompressedGFXFile0C:
	db "GFX0C.lz1"
SMW_CompressedGFXFile0CEnd:
SMW_CompressedGFXFile0D:
	db "GFX0D.lz1"
SMW_CompressedGFXFile0DEnd:
SMW_CompressedGFXFile0E:
	db "GFX0E.lz1"
SMW_CompressedGFXFile0EEnd:
SMW_CompressedGFXFile0F:
	db "GFX0F.lz1"
SMW_CompressedGFXFile0FEnd:
SMW_CompressedGFXFile10:
	db "GFX10.lz1"
SMW_CompressedGFXFile10End:
SMW_CompressedGFXFile11:
	db "GFX11.lz1"
SMW_CompressedGFXFile11End:
SMW_CompressedGFXFile12:
	db "GFX12.lz1"
SMW_CompressedGFXFile12End:
SMW_CompressedGFXFile13:
	db "GFX13.lz1"
SMW_CompressedGFXFile13End:
SMW_CompressedGFXFile14:
	db "GFX14.lz1"
SMW_CompressedGFXFile14End:
SMW_CompressedGFXFile15:
	db "GFX15.lz1"
SMW_CompressedGFXFile15End:
SMW_CompressedGFXFile16:
	db "GFX16.lz1"
SMW_CompressedGFXFile16End:
SMW_CompressedGFXFile17:
	db "GFX17.lz1"
SMW_CompressedGFXFile17End:
SMW_CompressedGFXFile18:
	db "GFX18.lz1"
SMW_CompressedGFXFile18End:
SMW_CompressedGFXFile19:
	db "GFX19.lz1"
SMW_CompressedGFXFile19End:
SMW_CompressedGFXFile1A:
	db "GFX1A.lz1"
SMW_CompressedGFXFile1AEnd:
SMW_CompressedGFXFile1B:
	db "GFX1B.lz1"
SMW_CompressedGFXFile1BEnd:
SMW_CompressedGFXFile1C:
	db "GFX1C.lz1"
SMW_CompressedGFXFile1CEnd:
SMW_CompressedGFXFile1D:
	db "GFX1D.lz1"
SMW_CompressedGFXFile1DEnd:
SMW_CompressedGFXFile1E:
	db "GFX1E.lz1"
SMW_CompressedGFXFile1EEnd:
SMW_CompressedGFXFile1F:
	db "GFX1F.lz1"
SMW_CompressedGFXFile1FEnd:
SMW_CompressedGFXFile20:
	db "GFX20.lz1"
SMW_CompressedGFXFile20End:
SMW_CompressedGFXFile21:
	db "GFX21.lz1"
SMW_CompressedGFXFile21End:
SMW_CompressedGFXFile22:
	db "GFX22.lz1"
SMW_CompressedGFXFile22End:
SMW_CompressedGFXFile23:
	db "GFX23.lz1"
SMW_CompressedGFXFile23End:
SMW_CompressedGFXFile24:
	db "GFX24.lz1"
SMW_CompressedGFXFile24End:
SMW_CompressedGFXFile25:
	db "GFX25.lz1"
SMW_CompressedGFXFile25End:
SMW_CompressedGFXFile26:
	db "GFX26.lz1"
SMW_CompressedGFXFile26End:
SMW_CompressedGFXFile27:
	db "GFX27.lz1"
SMW_CompressedGFXFile27End:
SMW_CompressedGFXFile28:
	db "GFX28.lz1"
SMW_CompressedGFXFile28End:
SMW_CompressedGFXFile29:
	db "GFX29.lz1"
SMW_CompressedGFXFile29End:
SMW_CompressedGFXFile2A:
	db "GFX2A.lz1"
SMW_CompressedGFXFile2AEnd:
SMW_CompressedGFXFile2B:
	db "GFX2B.lz1"
SMW_CompressedGFXFile2BEnd:
SMW_CompressedGFXFile2C:
	db "GFX2C.lz1"
SMW_CompressedGFXFile2CEnd:
SMW_CompressedGFXFile2D:
	db "GFX2D.lz1"
SMW_CompressedGFXFile2DEnd:
SMW_CompressedGFXFile2E:
	db "GFX2E.lz1"
SMW_CompressedGFXFile2EEnd:
SMW_CompressedGFXFile2F:
	db "GFX2F.lz1"
SMW_CompressedGFXFile2FEnd:
SMW_CompressedGFXFile30:
	db "GFX30.lz1"
SMW_CompressedGFXFile30End:
SMW_CompressedGFXFile31:
	db "GFX31.lz1"
SMW_CompressedGFXFile31End:
SMW_CompressedGFXFile32:
	db "GFX32.lz1"
SMW_CompressedGFXFile32End:
SMW_CompressedGFXFile33:
	db "GFX33.lz1"
SMW_CompressedGFXFile33End:
else
SMW_CompressedGFXFile00:
	db "GFX00.lz2"
SMW_CompressedGFXFile00End:
SMW_CompressedGFXFile01:
	db "GFX01.lz2"
SMW_CompressedGFXFile01End:
SMW_CompressedGFXFile02:
	db "GFX02.lz2"
SMW_CompressedGFXFile02End:
SMW_CompressedGFXFile03:
	db "GFX03.lz2"
SMW_CompressedGFXFile03End:
SMW_CompressedGFXFile04:
	db "GFX04.lz2"
SMW_CompressedGFXFile04End:
SMW_CompressedGFXFile05:
	db "GFX05.lz2"
SMW_CompressedGFXFile05End:
SMW_CompressedGFXFile06:
	db "GFX06.lz2"
SMW_CompressedGFXFile06End:
SMW_CompressedGFXFile07:
	db "GFX07.lz2"
SMW_CompressedGFXFile07End:
SMW_CompressedGFXFile08:
	db "GFX08.lz2"
SMW_CompressedGFXFile08End:
SMW_CompressedGFXFile09:
	db "GFX09.lz2"
SMW_CompressedGFXFile09End:
SMW_CompressedGFXFile0A:
	db "GFX0A.lz2"
SMW_CompressedGFXFile0AEnd:
SMW_CompressedGFXFile0B:
	db "GFX0B.lz2"
SMW_CompressedGFXFile0BEnd:
SMW_CompressedGFXFile0C:
	db "GFX0C.lz2"
SMW_CompressedGFXFile0CEnd:
SMW_CompressedGFXFile0D:
	db "GFX0D.lz2"
SMW_CompressedGFXFile0DEnd:
SMW_CompressedGFXFile0E:
	db "GFX0E.lz2"
SMW_CompressedGFXFile0EEnd:
SMW_CompressedGFXFile0F:
	db "GFX0F.lz2"
SMW_CompressedGFXFile0FEnd:
SMW_CompressedGFXFile10:
	db "GFX10.lz2"
SMW_CompressedGFXFile10End:
SMW_CompressedGFXFile11:
	db "GFX11.lz2"
SMW_CompressedGFXFile11End:
SMW_CompressedGFXFile12:
	db "GFX12.lz2"
SMW_CompressedGFXFile12End:
SMW_CompressedGFXFile13:
	db "GFX13.lz2"
SMW_CompressedGFXFile13End:
SMW_CompressedGFXFile14:
	db "GFX14.lz2"
SMW_CompressedGFXFile14End:
SMW_CompressedGFXFile15:
	db "GFX15.lz2"
SMW_CompressedGFXFile15End:
SMW_CompressedGFXFile16:
	db "GFX16.lz2"
SMW_CompressedGFXFile16End:
SMW_CompressedGFXFile17:
	db "GFX17.lz2"
SMW_CompressedGFXFile17End:
SMW_CompressedGFXFile18:
	db "GFX18.lz2"
SMW_CompressedGFXFile18End:
SMW_CompressedGFXFile19:
	db "GFX19.lz2"
SMW_CompressedGFXFile19End:
SMW_CompressedGFXFile1A:
	db "GFX1A.lz2"
SMW_CompressedGFXFile1AEnd:
SMW_CompressedGFXFile1B:
	db "GFX1B.lz2"
SMW_CompressedGFXFile1BEnd:
SMW_CompressedGFXFile1C:
	db "GFX1C.lz2"
SMW_CompressedGFXFile1CEnd:
SMW_CompressedGFXFile1D:
	db "GFX1D.lz2"
SMW_CompressedGFXFile1DEnd:
SMW_CompressedGFXFile1E:
	db "GFX1E.lz2"
SMW_CompressedGFXFile1EEnd:
SMW_CompressedGFXFile1F:
	db "GFX1F.lz2"
SMW_CompressedGFXFile1FEnd:
SMW_CompressedGFXFile20:
	db "GFX20.lz2"
SMW_CompressedGFXFile20End:
SMW_CompressedGFXFile21:
	db "GFX21.lz2"
SMW_CompressedGFXFile21End:
SMW_CompressedGFXFile22:
	db "GFX22.lz2"
SMW_CompressedGFXFile22End:
SMW_CompressedGFXFile23:
	db "GFX23.lz2"
SMW_CompressedGFXFile23End:
SMW_CompressedGFXFile24:
	db "GFX24.lz2"
SMW_CompressedGFXFile24End:
SMW_CompressedGFXFile25:
	db "GFX25.lz2"
SMW_CompressedGFXFile25End:
SMW_CompressedGFXFile26:
	db "GFX26.lz2"
SMW_CompressedGFXFile26End:
SMW_CompressedGFXFile27:
	db "GFX27.lz2"
SMW_CompressedGFXFile27End:
SMW_CompressedGFXFile28:
	db "GFX28.lz2"
SMW_CompressedGFXFile28End:
SMW_CompressedGFXFile29:
	db "GFX29.lz2"
SMW_CompressedGFXFile29End:
SMW_CompressedGFXFile2A:
	db "GFX2A.lz2"
SMW_CompressedGFXFile2AEnd:
SMW_CompressedGFXFile2B:
	db "GFX2B.lz2"
SMW_CompressedGFXFile2BEnd:
SMW_CompressedGFXFile2C:
	db "GFX2C.lz2"
SMW_CompressedGFXFile2CEnd:
SMW_CompressedGFXFile2D:
	db "GFX2D.lz2"
SMW_CompressedGFXFile2DEnd:
SMW_CompressedGFXFile2E:
	db "GFX2E.lz2"
SMW_CompressedGFXFile2EEnd:
SMW_CompressedGFXFile2F:
	db "GFX2F.lz2"
SMW_CompressedGFXFile2FEnd:
SMW_CompressedGFXFile30:
	db "GFX30.lz2"
SMW_CompressedGFXFile30End:
SMW_CompressedGFXFile31:
	db "GFX31.lz2"
SMW_CompressedGFXFile31End:
SMW_CompressedGFXFile32:
	db "GFX32.lz2"
SMW_CompressedGFXFile32End:
SMW_CompressedGFXFile33:
	db "GFX33.lz2"
SMW_CompressedGFXFile33End:
endif

;--------------------------------------------------------------------

LuigiGFX:
	db "Luigi.bin"
LuigiGFXEnd:
BlankLuigiTilesGFX:
	db "BlankLuigiTiles.bin"
BlankLuigiTilesGFXEnd:

;--------------------------------------------------------------------

SMW_Music_Boss_Battle:
	db "Boss_Battle.bin"
SMW_Music_Boss_BattleEnd:
SMW_Music_Bowser_Died:
	db "Bowser_Died.bin"
SMW_Music_Bowser_DiedEnd:
SMW_Music_Bowser_Fight:
	db "Bowser_Fight.bin"
SMW_Music_Bowser_FightEnd:
SMW_Music_Bowser_Zoom_In:
	db "Bowser_Zoom_In.bin"
SMW_Music_Bowser_Zoom_InEnd:
SMW_Music_Bowser_Zoom_Out:
	db "Bowser_Zoom_Out.bin"
SMW_Music_Bowser_Zoom_OutEnd:
SMW_Music_Castle:
	db "Castle.bin"
SMW_Music_CastleEnd:
SMW_Music_Cave:
	db "Cave.bin"
SMW_Music_CaveEnd:
SMW_Music_Directional_Coins:
	db "Directional_Coins.bin"
SMW_Music_Directional_CoinsEnd:
SMW_Music_Done_Bonus_Game:
	db "Done_Bonus_Game.bin"
SMW_Music_Done_Bonus_GameEnd:
SMW_Music_Game_Over:
	db "Game_Over.bin"
SMW_Music_Game_OverEnd:
SMW_Music_Ghost_House:
	db "Ghost_House.bin"
SMW_Music_Ghost_HouseEnd:
SMW_Music_Here_We_Go:
	db "Here_We_Go.bin"
SMW_Music_Here_We_GoEnd:
SMW_Music_Into_Keyhole:
	db "Into_Keyhole.bin"
SMW_Music_Into_KeyholeEnd:
SMW_Music_Passed_Boss:
	db "Passed_Boss.bin"
SMW_Music_Passed_BossEnd:
SMW_Music_Passed_Level:
	db "Passed_Level.bin"
SMW_Music_Passed_LevelEnd:
SMW_Music_Piano:
	db "Piano.bin"
SMW_Music_PianoEnd:
SMW_Music_Player_Died:
	db "Player_Died.bin"
SMW_Music_Player_DiedEnd:
SMW_Music_Princess_Kiss:
	db "Princess_Kiss.bin"
SMW_Music_Princess_KissEnd:
SMW_Music_Rescue_Egg:
	db "Rescue_Egg.bin"
SMW_Music_Rescue_EggEnd:
SMW_Music_Star:
	db "Star.bin"
SMW_Music_StarEnd:
SMW_Music_Switch_Palace:
	db "Switch_Palace.bin"
SMW_Music_Switch_PalaceEnd:
SMW_Music_Water:
	db "Water.bin"
SMW_Music_WaterEnd:
SMW_Music_Welcome:
	db "Welcome.bin"
SMW_Music_WelcomeEnd:
SMW_Music_Zoom_In:
	db "Zoom_In.bin"
SMW_Music_Zoom_InEnd:

;--------------------------------------------------------------------

SMW_Music_Bowser_Reveals:
	db "Bowser_Reveals.bin"
SMW_Music_Bowser_RevealsEnd:
SMW_Music_Forest_Of_Illusion:
	db "Forest_Of_Illusion.bin"
SMW_Music_Forest_Of_IllusionEnd:
SMW_Music_Main_Area:
	db "Main_Area.bin"
SMW_Music_Main_AreaEnd:
SMW_Music_Special_World:
	db "Special_World.bin"
SMW_Music_Special_WorldEnd:
SMW_Music_Star_Road:
	db "Star_Road.bin"
SMW_Music_Star_RoadEnd:
SMW_Music_Title_Screen:
	db "Title_Screen.bin"
SMW_Music_Title_ScreenEnd:
SMW_Music_Valley_Of_Bowser:
	db "Valley_Of_Bowser.bin"
SMW_Music_Valley_Of_BowserEnd:
SMW_Music_Vanilla_Dome:
	db "Vanilla_Dome.bin"
SMW_Music_Vanilla_DomeEnd:
SMW_Music_Yoshis_Island:
	db "Yoshis_Island.bin"
SMW_Music_Yoshis_IslandEnd:

;--------------------------------------------------------------------

SMW_Music_Credits:
	db "Credits.bin"
SMW_Music_CreditsEnd:

;--------------------------------------------------------------------

SMW_BRRFile00:
	db "00.brr"
SMW_BRRFile00End:
SMW_BRRFile01:
	db "01.brr"
SMW_BRRFile01End:
SMW_BRRFile02:
	db "02.brr"
SMW_BRRFile02End:
SMW_BRRFile03:
	db "03.brr"
SMW_BRRFile03End:
SMW_BRRFile04:
	db "04.brr"
SMW_BRRFile04End:
SMW_BRRFile05:
	db "05.brr"
SMW_BRRFile05End:
SMW_BRRFile06:
	db "06.brr"
SMW_BRRFile06End:
SMW_BRRFile07:
	db "07.brr"
SMW_BRRFile07End:
SMW_BRRFile08:
	db "08.brr"
SMW_BRRFile08End:
SMW_BRRFile09:
	db "09.brr"
SMW_BRRFile09End:
SMW_BRRFile0A:
	db "0A.brr"
SMW_BRRFile0AEnd:
SMW_BRRFile0B:
	db "0B.brr"
SMW_BRRFile0BEnd:
SMW_BRRFile0C:
	db "0C.brr"
SMW_BRRFile0CEnd:
SMW_BRRFile0D:
	db "0D.brr"
SMW_BRRFile0DEnd:
SMW_BRRFile0E:
	db "0E.brr"
SMW_BRRFile0EEnd:
SMW_BRRFile0F:
	db "0F.brr"
SMW_BRRFile0FEnd:
SMW_BRRFile10:
	db "10.brr"
SMW_BRRFile10End:
SMW_BRRFile11:
	db "11.brr"
SMW_BRRFile11End:
SMW_BRRFile12:
	db "12.brr"
SMW_BRRFile12End:
SMW_BRRFile13:
	db "13.brr"
SMW_BRRFile13End:
endif

;--------------------------------------------------------------------
