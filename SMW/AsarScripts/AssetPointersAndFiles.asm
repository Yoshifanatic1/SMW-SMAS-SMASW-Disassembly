; Note: This file is used by the ExtractAssets.bat batch script to define where each file is, how large they are, and their filenames.

lorom
;!ROMVer = $0000						; Note: This is set within the batch script
!SMW_U = $0001
!SMW_J = $0002
!SMW_E1 = $0004
!SMW_E2 = $0008
!SMW_A = $0010

org $008000
MainPointerTableStart:
	dl MainPointerTableStart,MainPointerTableEnd-MainPointerTableStart
	dl GFXPointersStart,(GFXPointersEnd-GFXPointersStart)/$0C
	dl LevelMusicPointersStart,(LevelMusicPointersEnd-LevelMusicPointersStart)/$0C
	dl OverworldMusicPointersStart,(OverworldMusicPointersEnd-OverworldMusicPointersStart)/$0C
	dl CreditsMusicPointersStart,(CreditsMusicPointersEnd-CreditsMusicPointersStart)/$0C
	dl BRRPointersStart,(BRRPointersEnd-BRRPointersStart)/$0C
MainPointerTableEnd:

;--------------------------------------------------------------------

GFXPointersStart:
if !ROMVer&(!SMW_J) != $00
	dl $08D9FC,$08E234,GFXFile00,GFXFile00End
	dl $08E234,$08ECBF,GFXFile01,GFXFile01End
	dl $08ECBF,$08F559,GFXFile02,GFXFile02End
	dl $08F559,$08FF8D,GFXFile03,GFXFile03End
	dl $08FF8D,$098976,GFXFile04,GFXFile04End
	dl $098976,$099386,GFXFile05,GFXFile05End
	dl $099386,$099D28,GFXFile06,GFXFile06End
	dl $099D28,$09A672,GFXFile07,GFXFile07End
	dl $09A672,$09AFB6,GFXFile08,GFXFile08End
	dl $09AFB6,$09BA2A,GFXFile09,GFXFile09End
	dl $09BA2A,$09C3B0,GFXFile0A,GFXFile0AEnd
	dl $09C3B0,$09CD77,GFXFile0B,GFXFile0BEnd
	dl $09CD77,$09D5E8,GFXFile0C,GFXFile0CEnd
	dl $09D5E8,$09DDAB,GFXFile0D,GFXFile0DEnd
	dl $09DDAB,$09E6C7,GFXFile0E,GFXFile0EEnd
	dl $09E6C7,$09EF08,GFXFile0F,GFXFile0FEnd
	dl $09EF08,$09F79C,GFXFile10,GFXFile10End
	dl $09F79C,$09FFAA,GFXFile11,GFXFile11End
	dl $09FFAA,$0A88FE,GFXFile12,GFXFile12End
	dl $0A88FE,$0A9339,GFXFile13,GFXFile13End
	dl $0A9339,$0A9ADF,GFXFile14,GFXFile14End
	dl $0A9ADF,$0AA36B,GFXFile15,GFXFile15End
	dl $0AA36B,$0AA9B6,GFXFile16,GFXFile16End
	dl $0AA9B6,$0AB2B4,GFXFile17,GFXFile17End
	dl $0AB2B4,$0ABBEB,GFXFile18,GFXFile18End
	dl $0ABBEB,$0AC393,GFXFile19,GFXFile19End
	dl $0AC393,$0ACC79,GFXFile1A,GFXFile1AEnd
	dl $0ACC79,$0AD491,GFXFile1B,GFXFile1BEnd
	dl $0AD491,$0ADC9B,GFXFile1C,GFXFile1CEnd
	dl $0ADC9B,$0AE691,GFXFile1D,GFXFile1DEnd
	dl $0AE691,$0AEE55,GFXFile1E,GFXFile1EEnd
	dl $0AEE55,$0AF6BF,GFXFile1F,GFXFile1FEnd
	dl $0AF6BF,$0AFF89,GFXFile20,GFXFile20End
	dl $0AFF89,$0B88F3,GFXFile21,GFXFile21End
	dl $0B88F3,$0B91F1,GFXFile22,GFXFile22End
	dl $0B91F1,$0B9B0E,GFXFile23,GFXFile23End
	dl $0B9B0E,$0BA3DE,GFXFile24,GFXFile24End
	dl $0BA3DE,$0BAE4A,GFXFile25,GFXFile25End
	dl $0BAE4A,$0BB770,GFXFile26,GFXFile26End
	dl $0BB770,$0BC09D,GFXFile27,GFXFile27End
	dl $0BC09D,$0BC6E4,GFXFile28,GFXFile28End
	dl $0BC6E4,$0BCC2E,GFXFile29,GFXFile29End
	dl $0BCC2E,$0BD27F,GFXFile2A,GFXFile2AEnd
	dl $0BD27F,$0BD92A,GFXFile2B,GFXFile2BEnd
	dl $0BD92A,$0BE17B,GFXFile2C,GFXFile2CEnd
	dl $0BE17B,$0BEAAB,GFXFile2D,GFXFile2DEnd
	dl $0BEAAB,$0BF2FA,GFXFile2E,GFXFile2EEnd
	dl $0BF2FA,$0BF530,GFXFile2F,GFXFile2FEnd
	dl $0BF530,$0BF975,GFXFile30,GFXFile30End
	dl $0BF975,$0BFE82,GFXFile31,GFXFile31End
	dl $088000,$08BFC0,GFXFile32,GFXFile32End
	dl $08BFC0,$08D9FC,GFXFile33,GFXFile33End
elseif !ROMVer&(!SMW_E2) != $00
	dl $08D9FC,$08E234,GFXFile00,GFXFile00End
	dl $08E234,$08ECBF,GFXFile01,GFXFile01End
	dl $08ECBF,$08F559,GFXFile02,GFXFile02End
	dl $08F559,$08FF8D,GFXFile03,GFXFile03End
	dl $08FF8D,$098976,GFXFile04,GFXFile04End
	dl $098976,$099386,GFXFile05,GFXFile05End
	dl $099386,$099D28,GFXFile06,GFXFile06End
	dl $099D28,$09A672,GFXFile07,GFXFile07End
	dl $09A672,$09AFBF,GFXFile08,GFXFile08End
	dl $09AFBF,$09BA33,GFXFile09,GFXFile09End
	dl $09BA33,$09C3B9,GFXFile0A,GFXFile0AEnd
	dl $09C3B9,$09CD80,GFXFile0B,GFXFile0BEnd
	dl $09CD80,$09D5F1,GFXFile0C,GFXFile0CEnd
	dl $09D5F1,$09DDE9,GFXFile0D,GFXFile0DEnd
	dl $09DDE9,$09E705,GFXFile0E,GFXFile0EEnd
	dl $09E705,$09EF46,GFXFile0F,GFXFile0FEnd
	dl $09EF46,$09F7D7,GFXFile10,GFXFile10End
	dl $09F7D7,$09FFE5,GFXFile11,GFXFile11End
	dl $09FFE5,$0A8939,GFXFile12,GFXFile12End
	dl $0A8939,$0A9374,GFXFile13,GFXFile13End
	dl $0A9374,$0A9B1A,GFXFile14,GFXFile14End
	dl $0A9B1A,$0AA3A6,GFXFile15,GFXFile15End
	dl $0AA3A6,$0AA9F1,GFXFile16,GFXFile16End
	dl $0AA9F1,$0AB2EF,GFXFile17,GFXFile17End
	dl $0AB2EF,$0ABC26,GFXFile18,GFXFile18End
	dl $0ABC26,$0AC3CE,GFXFile19,GFXFile19End
	dl $0AC3CE,$0ACCB4,GFXFile1A,GFXFile1AEnd
	dl $0ACCB4,$0AD4CC,GFXFile1B,GFXFile1BEnd
	dl $0AD4CC,$0ADCD6,GFXFile1C,GFXFile1CEnd
	dl $0ADCD6,$0AE6CC,GFXFile1D,GFXFile1DEnd
	dl $0AE6CC,$0AEE90,GFXFile1E,GFXFile1EEnd
	dl $0AEE90,$0AF6FA,GFXFile1F,GFXFile1FEnd
	dl $0AF6FA,$0AFFC4,GFXFile20,GFXFile20End
	dl $0AFFC4,$0B892E,GFXFile21,GFXFile21End
	dl $0B892E,$0B922C,GFXFile22,GFXFile22End
	dl $0B922C,$0B9B49,GFXFile23,GFXFile23End
	dl $0B9B49,$0BA419,GFXFile24,GFXFile24End
	dl $0BA419,$0BAE85,GFXFile25,GFXFile25End
	dl $0BAE85,$0BB7AB,GFXFile26,GFXFile26End
	dl $0BB7AB,$0BC0DD,GFXFile27,GFXFile27End
	dl $0BC0DD,$0BC714,GFXFile28,GFXFile28End
	dl $0BC714,$0BCBEA,GFXFile29,GFXFile29End
	dl $0BCBEA,$0BD16E,GFXFile2A,GFXFile2AEnd
	dl $0BD16E,$0BD843,GFXFile2B,GFXFile2BEnd
	dl $0BD843,$0BE094,GFXFile2C,GFXFile2CEnd
	dl $0BE094,$0BE9C4,GFXFile2D,GFXFile2DEnd
	dl $0BE9C4,$0BF213,GFXFile2E,GFXFile2EEnd
	dl $0BF213,$0BF449,GFXFile2F,GFXFile2FEnd
	dl $0BF449,$0BF88E,GFXFile30,GFXFile30End
	dl $0BF88E,$0BFD9B,GFXFile31,GFXFile31End
	dl $088000,$08BFC0,GFXFile32,GFXFile32End
	dl $08BFC0,$08D9FC,GFXFile33,GFXFile33End
else
	dl $08D9F9,$08E231,GFXFile00,GFXFile00End
	dl $08E231,$08ECBB,GFXFile01,GFXFile01End
	dl $08ECBB,$08F552,GFXFile02,GFXFile02End
	dl $08F552,$08FF7D,GFXFile03,GFXFile03End
	dl $08FF7D,$098963,GFXFile04,GFXFile04End
	dl $098963,$09936C,GFXFile05,GFXFile05End
	dl $09936C,$099D10,GFXFile06,GFXFile06End
	dl $099D10,$09A657,GFXFile07,GFXFile07End
	dl $09A657,$09AFA1,GFXFile08,GFXFile08End
	dl $09AFA1,$09BA15,GFXFile09,GFXFile09End
	dl $09BA15,$09C39C,GFXFile0A,GFXFile0AEnd
	dl $09C39C,$09CD63,GFXFile0B,GFXFile0BEnd
	dl $09CD63,$09D5D2,GFXFile0C,GFXFile0CEnd
	dl $09D5D2,$09DDCB,GFXFile0D,GFXFile0DEnd
	dl $09DDCB,$09E6E5,GFXFile0E,GFXFile0EEnd
	dl $09E6E5,$09EF1E,GFXFile0F,GFXFile0FEnd
	dl $09EF1E,$09F7AF,GFXFile10,GFXFile10End
	dl $09F7AF,$09FFBD,GFXFile11,GFXFile11End
	dl $09FFBD,$0A8910,GFXFile12,GFXFile12End
	dl $0A8910,$0A9348,GFXFile13,GFXFile13End
	dl $0A9348,$0A9AE8,GFXFile14,GFXFile14End
	dl $0A9AE8,$0AA374,GFXFile15,GFXFile15End
	dl $0AA374,$0AA9B4,GFXFile16,GFXFile16End
	dl $0AA9B4,$0AB2AD,GFXFile17,GFXFile17End
	dl $0AB2AD,$0ABBE4,GFXFile18,GFXFile18End
	dl $0ABBE4,$0AC380,GFXFile19,GFXFile19End
	dl $0AC380,$0ACC66,GFXFile1A,GFXFile1AEnd
	dl $0ACC66,$0AD47E,GFXFile1B,GFXFile1BEnd
	dl $0AD47E,$0ADC88,GFXFile1C,GFXFile1CEnd
	dl $0ADC88,$0AE67F,GFXFile1D,GFXFile1DEnd
	dl $0AE67F,$0AEE43,GFXFile1E,GFXFile1EEnd
	dl $0AEE43,$0AF6A1,GFXFile1F,GFXFile1FEnd
	dl $0AF6A1,$0AFF65,GFXFile20,GFXFile20End
	dl $0AFF65,$0B88CD,GFXFile21,GFXFile21End
	dl $0B88CD,$0B91CA,GFXFile22,GFXFile22End
	dl $0B91CA,$0B9AE5,GFXFile23,GFXFile23End
	dl $0B9AE5,$0BA3B5,GFXFile24,GFXFile24End
	dl $0BA3B5,$0BAE21,GFXFile25,GFXFile25End
	dl $0BAE21,$0BB744,GFXFile26,GFXFile26End
	dl $0BB744,$0BC06C,GFXFile27,GFXFile27End
	dl $0BC06C,$0BC6A3,GFXFile28,GFXFile28End
	dl $0BC6A3,$0BCB7B,GFXFile29,GFXFile29End
	dl $0BCB7B,$0BD0F0,GFXFile2A,GFXFile2AEnd
	dl $0BD0F0,$0BD7B9,GFXFile2B,GFXFile2BEnd
	dl $0BD7B9,$0BE006,GFXFile2C,GFXFile2CEnd
	dl $0BE006,$0BE936,GFXFile2D,GFXFile2DEnd
	dl $0BE936,$0BF185,GFXFile2E,GFXFile2EEnd
	dl $0BF185,$0BF3BB,GFXFile2F,GFXFile2FEnd
	dl $0BF3BB,$0BF800,GFXFile30,GFXFile30End
	dl $0BF800,$0BFD0D,GFXFile31,GFXFile31End
	dl $088000,$08BFC0,GFXFile32,GFXFile32End
	dl $08BFC0,$08D9F9,GFXFile33,GFXFile33End
endif
GFXPointersEnd:

;--------------------------------------------------------------------

LevelMusicPointersStart:
if !ROMVer&(!SMW_J) != $00
	dl $0ED00C,$0ED3D7,Music_Boss_Battle,Music_Boss_BattleEnd
	dl $0EB8E2,$0EBADD,Music_Bowser_Died,Music_Bowser_DiedEnd
	dl $0EBDE7,$0EC201,Music_Bowser_Fight,Music_Bowser_FightEnd
	dl $0EBD0D,$0EBDE7,Music_Bowser_Zoom_In,Music_Bowser_Zoom_InEnd
	dl $0EBADD,$0EBD0D,Music_Bowser_Zoom_Out,Music_Bowser_Zoom_OutEnd
	dl $0EC93D,$0ED00C,Music_Castle,Music_CastleEnd
	dl $0EDDD8,$0EDF64,Music_Cave,Music_CaveEnd
	dl $0ED487,$0ED4F2,Music_Directional_Coins,Music_Directional_CoinsEnd
	dl $0EC70A,$0EC7C0,Music_Done_Bonus_Game,Music_Done_Bonus_GameEnd
	dl $0ED764,$0ED83C,Music_Game_Over,Music_Game_OverEnd
	dl $0EDF64,$0EE527,Music_Ghost_House,Music_Ghost_HouseEnd
	dl $0EE527,$0EED72,Music_Here_We_Go,Music_Here_We_GoEnd
	dl $0ED407,$0ED487,Music_Into_Keyhole,Music_Into_KeyholeEnd
	dl $0EC7C0,$0EC93D,Music_Passed_Boss,Music_Passed_BossEnd
	dl $0ED592,$0ED764,Music_Passed_Level,Music_Passed_LevelEnd
	dl $0ED89D,$0EDDD8,Music_Piano,Music_PianoEnd
	dl $0ED83C,$0ED89D,Music_Player_Died,Music_Player_DiedEnd
	dl $0EB7AE,$0EB8E2,Music_Princess_Kiss,Music_Princess_KissEnd
	dl $0EC201,$0EC26E,Music_Rescue_Egg,Music_Rescue_EggEnd
	dl $0ED4F2,$0ED592,Music_Star,Music_StarEnd
	dl $0EC4C8,$0EC70A,Music_Switch_Palace,Music_Switch_PalaceEnd
	dl $0EED72,$0EF0EF,Music_Water,Music_WaterEnd
	dl $0EC26E,$0EC4C8,Music_Welcome,Music_WelcomeEnd
	dl $0ED3D7,$0ED407,Music_Zoom_In,Music_Zoom_InEnd
else
	dl $0ECFF4,$0ED3BF,Music_Boss_Battle,Music_Boss_BattleEnd
	dl $0EB8CA,$0EBAC5,Music_Bowser_Died,Music_Bowser_DiedEnd
	dl $0EBDCF,$0EC1E9,Music_Bowser_Fight,Music_Bowser_FightEnd
	dl $0EBCF5,$0EBDCF,Music_Bowser_Zoom_In,Music_Bowser_Zoom_InEnd
	dl $0EBAC5,$0EBCF5,Music_Bowser_Zoom_Out,Music_Bowser_Zoom_OutEnd
	dl $0EC925,$0ECFF4,Music_Castle,Music_CastleEnd
	dl $0EDDC0,$0EDF4C,Music_Cave,Music_CaveEnd
	dl $0ED46F,$0ED4DA,Music_Directional_Coins,Music_Directional_CoinsEnd
	dl $0EC6F2,$0EC7A8,Music_Done_Bonus_Game,Music_Done_Bonus_GameEnd
	dl $0ED74C,$0ED824,Music_Game_Over,Music_Game_OverEnd
	dl $0EDF4C,$0EE50F,Music_Ghost_House,Music_Ghost_HouseEnd
	dl $0EE50F,$0EED5A,Music_Here_We_Go,Music_Here_We_GoEnd
	dl $0ED3EF,$0ED46F,Music_Into_Keyhole,Music_Into_KeyholeEnd
	dl $0EC7A8,$0EC925,Music_Passed_Boss,Music_Passed_BossEnd
	dl $0ED57A,$0ED74C,Music_Passed_Level,Music_Passed_LevelEnd
	dl $0ED885,$0EDDC0,Music_Piano,Music_PianoEnd
	dl $0ED824,$0ED885,Music_Player_Died,Music_Player_DiedEnd
	dl $0EB796,$0EB8CA,Music_Princess_Kiss,Music_Princess_KissEnd
	dl $0EC1E9,$0EC256,Music_Rescue_Egg,Music_Rescue_EggEnd
	dl $0ED4DA,$0ED57A,Music_Star,Music_StarEnd
	dl $0EC4B0,$0EC6F2,Music_Switch_Palace,Music_Switch_PalaceEnd
	dl $0EED5A,$0EF0D7,Music_Water,Music_WaterEnd
	dl $0EC256,$0EC4B0,Music_Welcome,Music_WelcomeEnd
	dl $0ED3BF,$0ED3EF,Music_Zoom_In,Music_Zoom_InEnd
endif
LevelMusicPointersEnd:

;--------------------------------------------------------------------

OverworldMusicPointersStart:
if !ROMVer&(!SMW_J) != $00
	dl $0EA1BE,$0EA276,Music_Bowser_Reveals,Music_Bowser_RevealsEnd
	dl $0EA276,$0EA35B,Music_Forest_Of_Illusion,Music_Forest_Of_IllusionEnd
	dl $0EA66F,$0EA7BF,Music_Main_Area,Music_Main_AreaEnd
	dl $0E9C0B,$0EA1BE,Music_Special_World,Music_Special_WorldEnd
	dl $0EA35B,$0EA45B,Music_Star_Road,Music_Star_RoadEnd
	dl $0EA9B5,$0EAEEA,Music_Title_Screen,Music_Title_ScreenEnd
	dl $0EA45B,$0EA543,Music_Valley_Of_Bowser,Music_Valley_Of_BowserEnd
	dl $0EA7BF,$0EA9B5,Music_Vanilla_Dome,Music_Vanilla_DomeEnd
	dl $0EA543,$0EA66F,Music_Yoshis_Island,Music_Yoshis_IslandEnd
else
	dl $0EA1A6,$0EA25E,Music_Bowser_Reveals,Music_Bowser_RevealsEnd
	dl $0EA25E,$0EA343,Music_Forest_Of_Illusion,Music_Forest_Of_IllusionEnd
	dl $0EA657,$0EA7A7,Music_Main_Area,Music_Main_AreaEnd
	dl $0E9BF3,$0EA1A6,Music_Special_World,Music_Special_WorldEnd
	dl $0EA343,$0EA443,Music_Star_Road,Music_Star_RoadEnd
	dl $0EA99D,$0EAED2,Music_Title_Screen,Music_Title_ScreenEnd
	dl $0EA443,$0EA52B,Music_Valley_Of_Bowser,Music_Valley_Of_BowserEnd
	dl $0EA7A7,$0EA99D,Music_Vanilla_Dome,Music_Vanilla_DomeEnd
	dl $0EA52B,$0EA657,Music_Yoshis_Island,Music_Yoshis_IslandEnd
endif
OverworldMusicPointersEnd:

;--------------------------------------------------------------------

CreditsMusicPointersStart:
	dl $03E6D6,$03FDCA,Music_Credits,Music_CreditsEnd
CreditsMusicPointersEnd:

;--------------------------------------------------------------------

BRRPointersStart:
	dl $0F8058,$0F8097,BRRFile00,BRRFile00End
	dl $0F8097,$0F80D6,BRRFile01,BRRFile01End
	dl $0F80D6,$0F81DB,BRRFile02,BRRFile02End
	dl $0F81DB,$0F831F,BRRFile03,BRRFile03End
	dl $0F831F,$0F835E,BRRFile04,BRRFile04End
	dl $0F835E,$0F8595,BRRFile05,BRRFile05End
	dl $0F8595,$0F8A03,BRRFile06,BRRFile06End
	dl $0F8A03,$0F9069,BRRFile07,BRRFile07End
	dl $0F9069,$0F90A8,BRRFile08,BRRFile08End
	dl $0F90A8,$0F9CED,BRRFile09,BRRFile09End
	dl $0F9CED,$0FAF6B,BRRFile0A,BRRFile0AEnd
	dl $0FAF6B,$0FB607,BRRFile0B,BRRFile0BEnd
	dl $0FB607,$0FB646,BRRFile0C,BRRFile0CEnd
	dl $0FB646,$0FB91F,BRRFile0D,BRRFile0DEnd
	dl $0FB91F,$0FC3AB,BRRFile0E,BRRFile0EEnd
	dl $0FC3AB,$0FC62A,BRRFile0F,BRRFile0FEnd
	dl $0FC62A,$0FCF0F,BRRFile10,BRRFile10End
	dl $0FCF0F,$0FD479,BRRFile11,BRRFile11End
	dl $0FD479,$0FDDD3,BRRFile12,BRRFile12End
	dl $0FDDD3,$0FEF70,BRRFile13,BRRFile13End
BRRPointersEnd:

;--------------------------------------------------------------------

if !ROMVer&(!SMW_J|!SMW_E2) != $00
GFXFile00:
	db "GFX00.lz1"
GFXFile00End:
GFXFile01:
	db "GFX01.lz1"
GFXFile01End:
GFXFile02:
	db "GFX02.lz1"
GFXFile02End:
GFXFile03:
	db "GFX03.lz1"
GFXFile03End:
GFXFile04:
	db "GFX04.lz1"
GFXFile04End:
GFXFile05:
	db "GFX05.lz1"
GFXFile05End:
GFXFile06:
	db "GFX06.lz1"
GFXFile06End:
GFXFile07:
	db "GFX07.lz1"
GFXFile07End:
GFXFile08:
	db "GFX08.lz1"
GFXFile08End:
GFXFile09:
	db "GFX09.lz1"
GFXFile09End:
GFXFile0A:
	db "GFX0A.lz1"
GFXFile0AEnd:
GFXFile0B:
	db "GFX0B.lz1"
GFXFile0BEnd:
GFXFile0C:
	db "GFX0C.lz1"
GFXFile0CEnd:
GFXFile0D:
	db "GFX0D.lz1"
GFXFile0DEnd:
GFXFile0E:
	db "GFX0E.lz1"
GFXFile0EEnd:
GFXFile0F:
	db "GFX0F.lz1"
GFXFile0FEnd:
GFXFile10:
	db "GFX10.lz1"
GFXFile10End:
GFXFile11:
	db "GFX11.lz1"
GFXFile11End:
GFXFile12:
	db "GFX12.lz1"
GFXFile12End:
GFXFile13:
	db "GFX13.lz1"
GFXFile13End:
GFXFile14:
	db "GFX14.lz1"
GFXFile14End:
GFXFile15:
	db "GFX15.lz1"
GFXFile15End:
GFXFile16:
	db "GFX16.lz1"
GFXFile16End:
GFXFile17:
	db "GFX17.lz1"
GFXFile17End:
GFXFile18:
	db "GFX18.lz1"
GFXFile18End:
GFXFile19:
	db "GFX19.lz1"
GFXFile19End:
GFXFile1A:
	db "GFX1A.lz1"
GFXFile1AEnd:
GFXFile1B:
	db "GFX1B.lz1"
GFXFile1BEnd:
GFXFile1C:
	db "GFX1C.lz1"
GFXFile1CEnd:
GFXFile1D:
	db "GFX1D.lz1"
GFXFile1DEnd:
GFXFile1E:
	db "GFX1E.lz1"
GFXFile1EEnd:
GFXFile1F:
	db "GFX1F.lz1"
GFXFile1FEnd:
GFXFile20:
	db "GFX20.lz1"
GFXFile20End:
GFXFile21:
	db "GFX21.lz1"
GFXFile21End:
GFXFile22:
	db "GFX22.lz1"
GFXFile22End:
GFXFile23:
	db "GFX23.lz1"
GFXFile23End:
GFXFile24:
	db "GFX24.lz1"
GFXFile24End:
GFXFile25:
	db "GFX25.lz1"
GFXFile25End:
GFXFile26:
	db "GFX26.lz1"
GFXFile26End:
GFXFile27:
	db "GFX27.lz1"
GFXFile27End:
GFXFile28:
	db "GFX28.lz1"
GFXFile28End:
GFXFile29:
	db "GFX29.lz1"
GFXFile29End:
GFXFile2A:
	db "GFX2A.lz1"
GFXFile2AEnd:
GFXFile2B:
	db "GFX2B.lz1"
GFXFile2BEnd:
GFXFile2C:
	db "GFX2C.lz1"
GFXFile2CEnd:
GFXFile2D:
	db "GFX2D.lz1"
GFXFile2DEnd:
GFXFile2E:
	db "GFX2E.lz1"
GFXFile2EEnd:
GFXFile2F:
	db "GFX2F.lz1"
GFXFile2FEnd:
GFXFile30:
	db "GFX30.lz1"
GFXFile30End:
GFXFile31:
	db "GFX31.lz1"
GFXFile31End:
GFXFile32:
	db "GFX32.lz1"
GFXFile32End:
GFXFile33:
	db "GFX33.lz1"
GFXFile33End:
else
GFXFile00:
	db "GFX00.lz2"
GFXFile00End:
GFXFile01:
	db "GFX01.lz2"
GFXFile01End:
GFXFile02:
	db "GFX02.lz2"
GFXFile02End:
GFXFile03:
	db "GFX03.lz2"
GFXFile03End:
GFXFile04:
	db "GFX04.lz2"
GFXFile04End:
GFXFile05:
	db "GFX05.lz2"
GFXFile05End:
GFXFile06:
	db "GFX06.lz2"
GFXFile06End:
GFXFile07:
	db "GFX07.lz2"
GFXFile07End:
GFXFile08:
	db "GFX08.lz2"
GFXFile08End:
GFXFile09:
	db "GFX09.lz2"
GFXFile09End:
GFXFile0A:
	db "GFX0A.lz2"
GFXFile0AEnd:
GFXFile0B:
	db "GFX0B.lz2"
GFXFile0BEnd:
GFXFile0C:
	db "GFX0C.lz2"
GFXFile0CEnd:
GFXFile0D:
	db "GFX0D.lz2"
GFXFile0DEnd:
GFXFile0E:
	db "GFX0E.lz2"
GFXFile0EEnd:
GFXFile0F:
	db "GFX0F.lz2"
GFXFile0FEnd:
GFXFile10:
	db "GFX10.lz2"
GFXFile10End:
GFXFile11:
	db "GFX11.lz2"
GFXFile11End:
GFXFile12:
	db "GFX12.lz2"
GFXFile12End:
GFXFile13:
	db "GFX13.lz2"
GFXFile13End:
GFXFile14:
	db "GFX14.lz2"
GFXFile14End:
GFXFile15:
	db "GFX15.lz2"
GFXFile15End:
GFXFile16:
	db "GFX16.lz2"
GFXFile16End:
GFXFile17:
	db "GFX17.lz2"
GFXFile17End:
GFXFile18:
	db "GFX18.lz2"
GFXFile18End:
GFXFile19:
	db "GFX19.lz2"
GFXFile19End:
GFXFile1A:
	db "GFX1A.lz2"
GFXFile1AEnd:
GFXFile1B:
	db "GFX1B.lz2"
GFXFile1BEnd:
GFXFile1C:
	db "GFX1C.lz2"
GFXFile1CEnd:
GFXFile1D:
	db "GFX1D.lz2"
GFXFile1DEnd:
GFXFile1E:
	db "GFX1E.lz2"
GFXFile1EEnd:
GFXFile1F:
	db "GFX1F.lz2"
GFXFile1FEnd:
GFXFile20:
	db "GFX20.lz2"
GFXFile20End:
GFXFile21:
	db "GFX21.lz2"
GFXFile21End:
GFXFile22:
	db "GFX22.lz2"
GFXFile22End:
GFXFile23:
	db "GFX23.lz2"
GFXFile23End:
GFXFile24:
	db "GFX24.lz2"
GFXFile24End:
GFXFile25:
	db "GFX25.lz2"
GFXFile25End:
GFXFile26:
	db "GFX26.lz2"
GFXFile26End:
GFXFile27:
	db "GFX27.lz2"
GFXFile27End:
GFXFile28:
	db "GFX28.lz2"
GFXFile28End:
GFXFile29:
	db "GFX29.lz2"
GFXFile29End:
GFXFile2A:
	db "GFX2A.lz2"
GFXFile2AEnd:
GFXFile2B:
	db "GFX2B.lz2"
GFXFile2BEnd:
GFXFile2C:
	db "GFX2C.lz2"
GFXFile2CEnd:
GFXFile2D:
	db "GFX2D.lz2"
GFXFile2DEnd:
GFXFile2E:
	db "GFX2E.lz2"
GFXFile2EEnd:
GFXFile2F:
	db "GFX2F.lz2"
GFXFile2FEnd:
GFXFile30:
	db "GFX30.lz2"
GFXFile30End:
GFXFile31:
	db "GFX31.lz2"
GFXFile31End:
GFXFile32:
	db "GFX32.lz2"
GFXFile32End:
GFXFile33:
	db "GFX33.lz2"
GFXFile33End:
endif

;--------------------------------------------------------------------

Music_Boss_Battle:
	db "Boss_Battle.bin"
Music_Boss_BattleEnd:
Music_Bowser_Died:
	db "Bowser_Died.bin"
Music_Bowser_DiedEnd:
Music_Bowser_Fight:
	db "Bowser_Fight.bin"
Music_Bowser_FightEnd:
Music_Bowser_Zoom_In:
	db "Bowser_Zoom_In.bin"
Music_Bowser_Zoom_InEnd:
Music_Bowser_Zoom_Out:
	db "Bowser_Zoom_Out.bin"
Music_Bowser_Zoom_OutEnd:
Music_Castle:
	db "Castle.bin"
Music_CastleEnd:
Music_Cave:
	db "Cave.bin"
Music_CaveEnd:
Music_Directional_Coins:
	db "Directional_Coins.bin"
Music_Directional_CoinsEnd:
Music_Done_Bonus_Game:
	db "Done_Bonus_Game.bin"
Music_Done_Bonus_GameEnd:
Music_Game_Over:
	db "Game_Over.bin"
Music_Game_OverEnd:
Music_Ghost_House:
	db "Ghost_House.bin"
Music_Ghost_HouseEnd:
Music_Here_We_Go:
	db "Here_We_Go.bin"
Music_Here_We_GoEnd:
Music_Into_Keyhole:
	db "Into_Keyhole.bin"
Music_Into_KeyholeEnd:
Music_Passed_Boss:
	db "Passed_Boss.bin"
Music_Passed_BossEnd:
Music_Passed_Level:
	db "Passed_Level.bin"
Music_Passed_LevelEnd:
Music_Piano:
	db "Piano.bin"
Music_PianoEnd:
Music_Player_Died:
	db "Player_Died.bin"
Music_Player_DiedEnd:
Music_Princess_Kiss:
	db "Princess_Kiss.bin"
Music_Princess_KissEnd:
Music_Rescue_Egg:
	db "Rescue_Egg.bin"
Music_Rescue_EggEnd:
Music_Star:
	db "Star.bin"
Music_StarEnd:
Music_Switch_Palace:
	db "Switch_Palace.bin"
Music_Switch_PalaceEnd:
Music_Water:
	db "Water.bin"
Music_WaterEnd:
Music_Welcome:
	db "Welcome.bin"
Music_WelcomeEnd:
Music_Zoom_In:
	db "Zoom_In.bin"
Music_Zoom_InEnd:

;--------------------------------------------------------------------

Music_Bowser_Reveals:
	db "Bowser_Reveals.bin"
Music_Bowser_RevealsEnd:
Music_Forest_Of_Illusion:
	db "Forest_Of_Illusion.bin"
Music_Forest_Of_IllusionEnd:
Music_Main_Area:
	db "Main_Area.bin"
Music_Main_AreaEnd:
Music_Special_World:
	db "Special_World.bin"
Music_Special_WorldEnd:
Music_Star_Road:
	db "Star_Road.bin"
Music_Star_RoadEnd:
Music_Title_Screen:
	db "Title_Screen.bin"
Music_Title_ScreenEnd:
Music_Valley_Of_Bowser:
	db "Valley_Of_Bowser.bin"
Music_Valley_Of_BowserEnd:
Music_Vanilla_Dome:
	db "Vanilla_Dome.bin"
Music_Vanilla_DomeEnd:
Music_Yoshis_Island:
	db "Yoshis_Island.bin"
Music_Yoshis_IslandEnd:

;--------------------------------------------------------------------

Music_Credits:
	db "Credits.bin"
Music_CreditsEnd:

;--------------------------------------------------------------------

BRRFile00:
	db "00.brr"
BRRFile00End:
BRRFile01:
	db "01.brr"
BRRFile01End:
BRRFile02:
	db "02.brr"
BRRFile02End:
BRRFile03:
	db "03.brr"
BRRFile03End:
BRRFile04:
	db "04.brr"
BRRFile04End:
BRRFile05:
	db "05.brr"
BRRFile05End:
BRRFile06:
	db "06.brr"
BRRFile06End:
BRRFile07:
	db "07.brr"
BRRFile07End:
BRRFile08:
	db "08.brr"
BRRFile08End:
BRRFile09:
	db "09.brr"
BRRFile09End:
BRRFile0A:
	db "0A.brr"
BRRFile0AEnd:
BRRFile0B:
	db "0B.brr"
BRRFile0BEnd:
BRRFile0C:
	db "0C.brr"
BRRFile0CEnd:
BRRFile0D:
	db "0D.brr"
BRRFile0DEnd:
BRRFile0E:
	db "0E.brr"
BRRFile0EEnd:
BRRFile0F:
	db "0F.brr"
BRRFile0FEnd:
BRRFile10:
	db "10.brr"
BRRFile10End:
BRRFile11:
	db "11.brr"
BRRFile11End:
BRRFile12:
	db "12.brr"
BRRFile12End:
BRRFile13:
	db "13.brr"
BRRFile13End:

;--------------------------------------------------------------------
