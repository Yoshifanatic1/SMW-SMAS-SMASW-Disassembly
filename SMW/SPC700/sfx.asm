%SPCDataBlockStart(!ARAM_SMW_SoundEffectBankLoc)

SFXInstrumentTable:
	db $70,$70,$00,$10,$06,$DF,$E0,$B8,$02
	db $70,$70,$00,$10,$00,$FE,$0A,$B8,$03
	db $70,$70,$00,$10,$03,$FE,$11,$B8,$03
	db $70,$70,$00,$10,$04,$FE,$6A,$B8,$03
	db $70,$70,$00,$10,$00,$FE,$11,$B8,$03
	db $70,$70,$00,$10,$08,$FE,$6A,$B8,$03
	db $70,$70,$00,$10,$02,$FE,$6A,$B8,$06
	db $70,$70,$00,$10,$06,$FE,$6A,$B8,$05
	db $70,$70,$00,$10,$00,$CA,$D7,$B8,$03
	db $70,$70,$00,$10,$10,$0E,$6A,$7F,$04
	db $70,$70,$00,$10,$0B,$FE,$6A,$B8,$02
	db $70,$70,$00,$10,$0B,$FF,$E0,$B8,$05
	db $70,$70,$00,$10,$0E,$FE,$00,$7F,$06
	db $70,$70,$00,$10,$00,$B6,$30,$30,$06
	db $70,$70,$00,$10,$12,$0E,$6A,$70,$03
	db $70,$70,$00,$10,$01,$FA,$6A,$70,$03
	db $70,$70,$00,$10,$02,$FE,$16,$70,$03
	db $70,$70,$00,$10,$13,$0E,$16,$7F,$03
	db $70,$70,$00,$10,$02,$FE,$33,$7F,$03

;1DFC
SFXTable0:
	dw SOUND_Coin
	dw SOUND_HitPrizeBlock
	dw SOUND_HitVineBlock
	dw SOUND_SpinJump
	dw SOUND_1Up
	dw SOUND_ShootFireball
	dw SOUND_Shatter
	dw SOUND_SpringBoard
	dw SOUND_BulletBill
	dw SOUND_EggHatch
	dw SOUND_ItemIntoReserve
	dw SOUND_ItemFromReserve
	dw SOUND_ItemFromReserve ;Clone 0C
	dw SOUND_ScrollScreen
	dw SOUND_Door
	dw SOUND_BulletBill ;Clone 09
	dw SOUND_DrumRoll
	dw SOUND_DrumRollEnd
	dw SOUND_LoseYoshi
	dw SOUND_UnusedCape
	dw SOUND_OWTileAppears
	dw SOUND_OWCastleCollapse
	dw SOUND_FireSpit
	dw SOUND_Thunder
	dw SOUND_ClapPop
	dw SOUND_CastleBomb
	dw SOUND_CastleFuse
	dw SOUND_SwitchPalaceEject
	dw SOUND_TimeRunningLow2
	dw SOUND_Whistle
	dw SOUND_Yoshi
	dw SOUND_KoopalingHitsLava
	dw SOUND_YoshiTongue
	dw SOUND_MessageBox
	dw SOUND_MoveOnOW
	dw SOUND_PSwitchTimeLow
	dw SOUND_YoshiEnemyStomp
	dw SOUND_Swooper
	dw SOUND_Podoboo
	dw SOUND_EnemyStunned
	dw SOUND_Correct
	dw SOUND_Incorrect
	dw SOUND_FireworkWhistle
	dw SOUND_FireworkBang
	dw SOUND_PodobooMinus100
	dw SOUND_PodobooMinus71
	dw SOUND_PodobooMinus43
	dw SOUND_PodobooMinus14
	dw SOUND_PodobooPlus14
	dw SOUND_PodobooPlus43
	dw SOUND_PodobooPlus71
	dw SOUND_PodobooPlus100

;1DF9
SFXTable1:
	dw SOUND_HitHead
	dw SOUND_Contact
	dw SOUND_KickShell
	dw SOUND_PipeHurt
	dw SOUND_MidwayPoint
	dw SOUND_YoshiGulp
	dw SOUND_DryBonesCollapse
	dw SOUND_SpinJumpKill
	dw SOUND_FlyWithCape
	dw SOUND_GetPowerup
	dw SOUND_OnOffSwitch
	dw SOUND_ItemPastGoal
	dw SOUND_GetCape
	dw SOUND_Swim
	dw SOUND_HurtWhileFlying
	dw SOUND_MagikoopaMagic
	dw SOUND_Pause
	dw SOUND_Pause
	dw SOUND_EnemyStomp1
	dw SOUND_EnemyStomp2
	dw SOUND_EnemyStomp3
	dw SOUND_EnemyStomp4
	dw SOUND_EnemyStomp5
	dw SOUND_EnemyStomp6
	dw SOUND_EnemyStomp7
	dw SOUND_GrinderClick1
	dw SOUND_GrinderClick2
	dw SOUND_YoshiCoin
	dw SOUND_TimeRunningLow1
	dw SOUND_PBalloon
	dw SOUND_KoopalingDefeated
	dw SOUND_YoshiSpit
	dw SOUND_ValleyofBowserAppears
	dw $5B26 ;Removed?
	dw SOUND_LemmyWendyFall
	dw $5B26 ;Removed?
	dw SOUND_BlarggRoar
	dw SOUND_FireworkWhistle1
	dw SOUND_FireworkBang1
	dw SOUND_FireworkWhistle2
	dw SOUND_FireworkBang2
	dw SOUND_PeachPopsUp

SOUND_PeachPopsUp:	incsrc "SFX_1DF9/peachpopsup.asm"
SOUND_PodobooMinus100:	incsrc "SFX_1DFC/podoboo-100.asm"
SOUND_PodobooMinus71:	incsrc "SFX_1DFC/podoboo-71.asm"
SOUND_PodobooMinus43:	incsrc "SFX_1DFC/podoboo-43.asm"
SOUND_PodobooMinus14:	incsrc "SFX_1DFC/podoboo-14.asm"
SOUND_PodobooPlus14:	incsrc "SFX_1DFC/podoboo+14.asm"
SOUND_PodobooPlus43:	incsrc "SFX_1DFC/podoboo+43.asm"
SOUND_PodobooPlus71:	incsrc "SFX_1DFC/podoboo+71.asm"
SOUND_PodobooPlus100:	incsrc "SFX_1DFC/podoboo+100.asm"
SOUND_FireworkBang2:	incsrc "SFX_1DF9/fireworkbang2.asm"
SOUND_FireworkWhistle2:	incsrc "SFX_1DF9/fireworkwhistle2.asm"
SOUND_FireworkBang:	incsrc "SFX_1DFC/fireworkbang.asm"
SOUND_FireworkWhistle:	incsrc "SFX_1DFC/fireworkwhistle.asm"
SOUND_FireworkBang1:	incsrc "SFX_1DF9/fireworkbang1.asm"
SOUND_FireworkWhistle1:	incsrc "SFX_1DF9/fireworkwhistle1.asm"
SOUND_Incorrect:	incsrc "SFX_1DFC/incorrect.asm"
SOUND_Correct:	incsrc "SFX_1DFC/correct.asm"
SOUND_LemmyWendyFall:	incsrc "SFX_1DF9/lemmywendyfall.asm"
SOUND_EnemyStunned:	incsrc "SFX_1DFC/enemystunned.asm"
SOUND_BlarggRoar:	incsrc "SFX_1DF9/blarggroar.asm"
SOUND_Podoboo:	incsrc "SFX_1DFC/podoboo.asm"
SOUND_Swooper:	incsrc "SFX_1DFC/swooper.asm"
SOUND_YoshiEnemyStomp:	incsrc "SFX_1DFC/yoshienemystomp.asm"
SOUND_PSwitchTimeLow:	incsrc "SFX_1DFC/pswitchtimelow.asm"
SOUND_MessageBox:	incsrc "SFX_1DFC/messagebox.asm"
SOUND_MoveOnOW:	incsrc "SFX_1DFC/moveonow.asm"
SOUND_Yoshi:	incsrc "SFX_1DFC/yoshi.asm"
SOUND_Whistle:	incsrc "SFX_1DFC/whistle.asm"
SOUND_SwitchPalaceEject:	incsrc "SFX_1DFC/switchpalaceeject.asm"
SOUND_ValleyofBowserAppears:	incsrc "SFX_1DF9/valleyofbowserappears.asm"
SOUND_CastleFuse:	incsrc "SFX_1DFC/castlefuse.asm"
SOUND_CastleBomb:	incsrc "SFX_1DFC/castlebomb.asm"
SOUND_KoopalingHitsLava:	incsrc "SFX_1DFC/koopalinghitslava.asm"
SOUND_ClapPop:	incsrc "SFX_1DFC/clappop.asm"
SOUND_Thunder:	incsrc "SFX_1DFC/thunder.asm"
SOUND_FireSpit:	incsrc "SFX_1DFC/firespit.asm"
SOUND_OWCastleCollapse:	incsrc "SFX_1DFC/owcastlecollapse.asm"
SOUND_OWTileAppears:	incsrc "SFX_1DFC/owtileappears.asm"
SOUND_YoshiSpit:	incsrc "SFX_1DF9/yoshispit.asm"
SOUND_KoopalingDefeated:	incsrc "SFX_1DF9/koopalingdefeated.asm"
SOUND_PBalloon:	incsrc "SFX_1DF9/pballoon.asm"
SOUND_GrinderClick1:	incsrc "SFX_1DF9/grinderclick1.asm"
SOUND_GrinderClick2:	incsrc "SFX_1DF9/grinderclick2.asm"
SOUND_SpinJumpKill:	incsrc "SFX_1DF9/spinjumpkill.asm"
SOUND_SpringBoard:	incsrc "SFX_1DFC/springboard.asm"
SOUND_Pause:	incsrc "SFX_1DF9/pause.asm"
SOUND_ScrollScreen:	incsrc "SFX_1DFC/scrollscreen.asm"
SOUND_FlyWithCape:	incsrc "SFX_1DF9/flywithcape.asm"
SOUND_Swim:	incsrc "SFX_1DF9/swim.asm"
SOUND_ItemIntoReserve:	incsrc "SFX_1DFC/itemintoreserve.asm"
SOUND_EggHatch:	incsrc "SFX_1DFC/egghatch.asm"
SOUND_YoshiGulp:	incsrc "SFX_1DF9/yoshigulp.asm"
SOUND_LoseYoshi:	incsrc "SFX_1DFC/loseyoshi.asm"
SOUND_YoshiCoin:	incsrc "SFX_1DF9/yoshicoin.asm"
SOUND_TimeRunningLow1:	incsrc "SFX_1DF9/timerunninglow1.asm"
SOUND_TimeRunningLow2:	incsrc "SFX_1DFC/timerunninglow2.asm"
SOUND_MidwayPoint:	incsrc "SFX_1DF9/midwaypoint.asm"
SOUND_PipeHurt:	incsrc "SFX_1DF9/pipehurt.asm"
SOUND_OnOffSwitch:	incsrc "SFX_1DF9/onoffswitch.asm"
SOUND_ShootFireball:	incsrc "SFX_1DFC/shootfireball.asm"
SOUND_KickShell:	incsrc "SFX_1DF9/kickshell.asm"
SOUND_EnemyStomp1:	incsrc "SFX_1DF9/enemystomp1.asm"
SOUND_EnemyStomp2:	incsrc "SFX_1DF9/enemystomp2.asm"
SOUND_EnemyStomp3:	incsrc "SFX_1DF9/enemystomp3.asm"
SOUND_EnemyStomp4:	incsrc "SFX_1DF9/enemystomp4.asm"
SOUND_EnemyStomp5:	incsrc "SFX_1DF9/enemystomp5.asm"
SOUND_EnemyStomp6:	incsrc "SFX_1DF9/enemystomp6.asm"
SOUND_EnemyStomp7:	incsrc "SFX_1DF9/enemystomp7.asm"
SOUND_Contact:	incsrc "SFX_1DF9/contact.asm"
SOUND_YoshiTongue:	incsrc "SFX_1DFC/yoshitongue.asm"
SOUND_HitHead:	incsrc "SFX_1DF9/hithead.asm"
SOUND_HitVineBlock:	incsrc "SFX_1DFC/hitvineblock.asm"
SOUND_HitPrizeBlock:	incsrc "SFX_1DFC/hitprizeblock.asm"
SOUND_ItemFromReserve:	incsrc "SFX_1DFC/itemfromreserve.asm"
SOUND_DryBonesCollapse:	incsrc "SFX_1DF9/drybonescollapse.asm"
SOUND_GetCape:	incsrc "SFX_1DF9/getcape.asm"
SOUND_UnusedCape:	incsrc "SFX_1DFC/unusedcape.asm"
SOUND_GetPowerup:	incsrc "SFX_1DF9/getpowerup.asm"
SOUND_1Up:	incsrc "SFX_1DFC/1up.asm"
SOUND_MagikoopaMagic:	incsrc "SFX_1DF9/magikoopamagic.asm"
SOUND_ItemPastGoal:	incsrc "SFX_1DF9/itempastgoal.asm"
SOUND_HurtWhileFlying:	incsrc "SFX_1DF9/hurtwhileflying.asm"
SOUND_SpinJump:	incsrc "SFX_1DFC/spinjump.asm"
SOUND_Coin:	incsrc "SFX_1DFC/coin.asm"
SOUND_Shatter:	incsrc "SFX_1DFC/shatter.asm"
SOUND_Door:	incsrc "SFX_1DFC/door.asm"
SOUND_BulletBill:	incsrc "SFX_1DFC/bulletbill.asm"
SOUND_DrumRoll:	incsrc "SFX_1DFC/drumroll.asm"
SOUND_DrumRollEnd:	incsrc "SFX_1DFC/drumrollend.asm"

InstrumentTable:
	db $00,$FE,$6A,$B8,$06
	db $01,$FA,$6A,$B8,$03
	db $02,$AE,$2F,$B8,$04
	db $03,$FE,$6A,$B8,$03
	db $04,$A9,$6A,$B8,$03
	db $07,$AE,$26,$B8,$07
	db $08,$FA,$6A,$B8,$03
	db $09,$9E,$1F,$B8,$03
	db $05,$AE,$26,$B8,$1E
	db $0A,$EE,$6A,$B8,$02
	db $0B,$FE,$6A,$B8,$08
	db $01,$F7,$6A,$B8,$03
	db $10,$0E,$6A,$7F,$04
	db $0C,$FE,$6A,$B8,$03
	db $0D,$AE,$26,$B8,$07
	db $12,$8E,$E0,$B8,$03
	db $0C,$FE,$70,$B8,$03
	db $11,$FE,$6A,$B8,$05
	db $01,$E9,$6A,$B8,$03

PercussionTable:
	db $0F,$0F,$6A,$7F,$03,$A8
	db $06,$0E,$6A,$40,$07,$A4
	db $06,$8C,$E0,$70,$07,$A1
	db $0E,$FE,$6A,$B8,$07,$A4
	db $0E,$FE,$6A,$B8,$08,$A4
	db $0B,$FE,$6A,$B8,$02,$9C
	db $0B,$7E,$6A,$7F,$08,$A6
	db $0B,$7E,$6A,$30,$08,$A6
	db $0E,$0E,$6A,$7F,$03,$A1
%SPCDataBlockEnd(!ARAM_SMW_SoundEffectBankLoc)
