
; Note: If you want to edit the music and you're editing the USA version of SMAS+W, consider using the SMAS+W version of Addmusick: https://www.dropbox.com/s/ev3o1myylr7aaaw/SMAS%2BW%20AddmusicK.zip?dl=0
; If you'd rather not use that tool, someone will need to write a script that can turn the raw hex from the original ROM into a music file.

%SPCDataBlockStart(!ARAM_SMAS_MusicBankLoc)
MusicPtrs:
	dw MUSIC_Athletic		; $01
	dw MUSIC_Overworld		; $02
	dw MUSIC_Underwater		; $03
	dw MUSIC_ToadHouse		; $04
	dw MUSIC_BowserBattle		; $05
	dw MUSIC_Underground		; $06
	dw MUSIC_Victory		; $07
	dw MUSIC_Fortress		; $08
	dw MUSIC_Death			; $09
	dw MUSIC_GameOver		; $0A
	dw MUSIC_PassedBoss		; $0B
	dw MUSIC_PassedLevel		; $0C
	dw MUSIC_HaveStar		; $0D
	dw MUSIC_BowserFell		; $0E
	dw MUSIC_ThroneRoom		; $0F
	dw MUSIC_Airship		; $10
	dw MUSIC_HammerBroEncounter	; $11
	dw MUSIC_BossBattle		; $12
	dw MUSIC_WorldClear		; $13
	dw MUSIC_CloudBonusRoom		; $14
	dw MUSIC_TitleScreen		; $15
	dw MUSIC_BattleMode		; $16
	dw MUSIC_BowserLetter		; $17
	dw MUSIC_PeachLetter		; $18

MUSIC_CloudBonusRoom:
;$C030
	dw DATA_C04A,DATA_C03A,$00FF,MUSIC_CloudBonusRoom+$02
	dw $0000

DATA_C03A:
	dw DATA_C05A,$C0AB,$C0DA,$C107
	dw $0000,$C133,$0000,$0000

DATA_C04A:
	dw $C161,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000

DATA_C05A:	incbin "Music/Levels/CloudBonusRoom.bin"

MUSIC_Victory:
;$C175
	dw DATA_C17B,DATA_C18B,$0000

DATA_C17B:
	dw DATA_C19B,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000

DATA_C18B:
	dw $C1AE,$C1C4,$C1D7,$C1EA
	dw $0000,$C1FD,$0000,$C210

DATA_C19B:	incbin "Music/Levels/Victory.bin"

MUSIC_Athletic:
;$C224
	dw DATA_C230,DATA_C240,DATA_C250,$00FF
	dw MUSIC_Athletic+$02,$0000

DATA_C230:
	dw DATA_C260,$C28C,$C294,$C2A3
	dw $C2C0,$0000,$0000,$0000

DATA_C240:
	dw $C2C8,$C36A,$C38A,$C3E1
	dw $0000,$C484,$0000,$C4A3

DATA_C250:
	dw $C4CD,$C52E,$C55D,$C57D
	dw $0000,$C5E1,$0000,$0000

DATA_C260:	incbin "Music/Levels/Athletic.bin"

MUSIC_Overworld:
;$C6C5
	dw DATA_C6D1,DATA_C6E1,DATA_C6F1,$00FF
	dw MUSIC_Overworld+$02,$0000

DATA_C6D1:
	dw DATA_C701,$C737,$C756,$C76F
	dw $0000,$C78E,$0000,$C7B3

DATA_C6E1:
	dw $C7C6,$C820,$C847,$C87D
	dw $0000,$C8D6,$0000,$C8F6

DATA_C6F1:
	dw $C925,$C9CD,$CA02,$CA30
	dw $0000,$CADB,$CB11,$CB5B

DATA_C701:	incbin "Music/Levels/Overworld.bin"

MUSIC_Underwater:
;$CC00
	dw DATA_CC20,DATA_CC10,DATA_CC30,DATA_CC30
	dw DATA_CC40,$00FF,MUSIC_Underwater+$04,$0000

DATA_CC10:
	dw DATA_CC50,$CC76,$CC8A,$0000
	dw $0000,$CCAD,$0000,$0000

DATA_CC20:
	dw $CCD2,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000

DATA_CC30:
	dw $CCDF,$CCFE,$CD14,$CD52
	dw $0000,$CD67,$0000,$CD87

DATA_CC40:
	dw $CDA1,$CDC3,$CDED,$CE2C
	dw $0000,$CE41,$0000,$CE64

DATA_CC50:	incbin "Music/Levels/Underwater.bin"

MUSIC_BowserBattle:
;$CEE8
	dw DATA_CF06,DATA_CF16,DATA_CF26,DATA_CEF6
	dw $00FF,MUSIC_BowserBattle+$02,$0000

DATA_CEF6:
	dw DATA_CF36,$CF50,$CF99,$CFBD
	dw $CFD3,$CFF9,$D01D,$D02C

DATA_CF06:
	dw $D046,$D06F,$D081,$D09B
	dw $0000,$D0B5,$D0CE,$D0E8

DATA_CF16:
	dw $D102,$D118,$D142,$D16C
	dw $D176,$D1BC,$D1FE,$0000

DATA_CF26:
	dw $D205,$D21B,$D23D,$D241
	dw $D245,$D287,$D2C5,$D2CC

DATA_CF36:	incbin "Music/Levels/BowserBattle.bin"

MUSIC_Underground:
;$D37E
	dw DATA_D39A,DATA_D3AA,DATA_D38A,$00FF
	dw MUSIC_Underground+$02,$0000

DATA_D38A:
	dw DATA_D3BA,$D3E8,$D3F0,$D40C
	dw $0000,$D458,$0000,$D48E

DATA_D39A:
	dw $D4BD,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000

DATA_D3AA:
	dw $D4C4,$D4DE,$D4E2,$0000
	dw $0000,$D50A,$0000,$0000

DATA_D3BA:	incbin "Music/Levels/Underground.bin"

MUSIC_Fortress:
;$D605
	dw DATA_D633,DATA_D613,DATA_D613,DATA_D623
	dw $00FF,MUSIC_Fortress+$02,$0000

DATA_D613:
	dw DATA_D643,$D661,$D68D,$D6A6
	dw $0000,$D6BF,$0000,$D6D4

DATA_D623:
	dw $D700,$D71F,$D734,$D74B
	dw $D764,$D77B,$0000,$0000

DATA_D633:
	dw $D793,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000

DATA_D643:	incbin "Music/Levels/Fortress.bin"

MUSIC_Death:
;$D7B7
	dw DATA_D7BB,$0000

DATA_D7BB:
	dw DATA_D7CB,$D7EA,$D809,$D826
	dw $0000,$D848,$0000,$D867

DATA_D7CB:	incbin "Music/Levels/Death.bin"

MUSIC_GameOver:
;$D888
	dw DATA_D88C,$0000

DATA_D88C:
	dw DATA_D89C,$D8CC,$D8ED,$0000
	dw $0000,$0000,$0000,$0000

DATA_D89C:	incbin "Music/Levels/GameOver.bin"

MUSIC_PassedBoss:
;$D905
	dw DATA_D909,$0000

DATA_D909:
	dw DATA_D919,$D944,$D966,$D988
	dw $0000,$D9A5,$0000,$0000

DATA_D919:	incbin "Music/Levels/PassedBoss.bin"

MUSIC_PassedLevel:
;$D9BC
	dw DATA_D9C0,$0000

DATA_D9C0:
	dw DATA_D9D0,$D9F7,$DA0F,$DA25
	dw $0000,$DA39,$0000,$0000

DATA_D9D0:	incbin "Music/Levels/PassedLevel.bin"

MUSIC_HaveStar:
;$DA4A
	dw DATA_DA52,$00FF,MUSIC_HaveStar,$0000

DATA_DA52:
	dw DATA_DA62,$DA94,$DAD2,$DAEF
	dw $DB29,$DB65,$0000,$DB82

DATA_DA62:	incbin "Music/Levels/HaveStar.bin"

MUSIC_ThroneRoom:
;$DBC5
	dw DATA_DBCF,DATA_DBDF,$00FF,MUSIC_ThroneRoom+$02
	dw $0000

DATA_DBCF:
	dw DATA_DBEF,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000

DATA_DBDF:
	dw $DC02,$DC19,$DC38,$DC57
	dw $0000,$DC71,$0000,$0000

DATA_DBEF:	incbin "Music/Levels/ThroneRoom.bin"

MUSIC_Airship:
;$DC9A
	dw DATA_DCA8,DATA_DCB8,DATA_DCB8,DATA_DCC8
	dw $00FF,MUSIC_Airship+$02,$0000

DATA_DCA8:
	dw DATA_DCD8,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000

DATA_DCB8:
	dw $DCF5,$DD11,$DD2A,$DD43
	dw $0000,$0000,$0000,$0000

DATA_DCC8:
	dw $DD5C,$DD78,$DD9C,$DDC0
	dw $0000,$DDE4,$0000,$0000

DATA_DCD8:	incbin "Music/Levels/Airship.bin"

MUSIC_ToadHouse:
;$DE54
	dw DATA_DE82,DATA_DE72,DATA_DE72,DATA_DE62
	dw $00FF,MUSIC_ToadHouse+$02,$0000

DATA_DE62:
	dw DATA_DE92,$DEB2,$DED3,$DEEB
	dw $0000,$DEF7,$0000,$DEFB

DATA_DE72:
	dw $DEFF,$DF16,$DF1A,$DF32
	dw $0000,$DF51,$0000,$DF72

DATA_DE82:
	dw $DF76,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000

DATA_DE92:	incbin "Music/Levels/ToadHouse.bin"

MUSIC_WorldClear:
;$DFC5
	dw DATA_DFC9,$0000

DATA_DFC9:
	dw DATA_DFD9,$DFF8,$E010,$E043
	dw $E053,$E06F,$E0A1,$E0C5

DATA_DFD9:	incbin "Music/Levels/WorldClear.bin"

MUSIC_HammerBroEncounter:
;$E132
	dw DATA_E13C,DATA_E14C,$00FF,MUSIC_HammerBroEncounter+$02
	dw $0000

DATA_E13C:
	dw DATA_E15C,$E18A,$E1A4,$E1AC
	dw $E1C6,$E1E3,$E1FF,$E231

DATA_E14C:
	dw $E23F,$E290,$E2F8,$E310
	dw $E37C,$E3A3,$0000,$E3D4

DATA_E15C:	incbin "Music/Levels/HammerBroEncounter.bin"

MUSIC_BossBattle:
;$E46E
	dw DATA_E47C,DATA_E48C,DATA_E48C,DATA_E49C
	dw $00FF,MUSIC_BossBattle+$02,$0000

DATA_E47C:
	dw DATA_E4AC,$E512,$E565,$E57D
	dw $E5D2,$E5F0,$E5FC,$E60F

DATA_E48C:
	dw $E62F,$E64A,$E674,$E67C
	dw $E68B,$E6A0,$E6A4,$E6A8

DATA_E49C:
	dw $E6BD,$E6E0,$E712,$E71A
	dw $E729,$E738,$E73C,$E740

DATA_E4AC:	incbin "Music/Levels/BossBattle.bin"

MUSIC_BowserFell:
;$E828
	dw DATA_E82C,$0000

DATA_E82C:
	dw DATA_E83C,$E85F,$E873,$E889
	dw $E89F,$E8B5,$E8CB,$0000

DATA_E83C:	incbin "Music/Levels/BowserFell.bin"

MUSIC_TitleScreen:
;$E8E4
	dw DATA_E904,DATA_E914,DATA_E924,DATA_E8F4
	dw DATA_E934,$00FF,MUSIC_TitleScreen+$06,$0000

DATA_E8F4:
	dw DATA_E944,$E9CB,$EA2B,$EA75
	dw $EAEF,$EB8F,$EC12,$EC81

DATA_E904:
	dw $EC9A,$ECB5,$0000,$0000
	dw $0000,$0000,$0000,$0000

DATA_E914:
	dw $ECCB,$ED0B,$ED19,$ED46
	dw $ED73,$EDA0,$EDD2,$EE01

DATA_E924:
	dw $EE0F,$EE26,$EE2A,$EE2E
	dw $EE3C,$EE4D,$EE61,$EE72

DATA_E934:
	dw $EE76,$EE8D,$EE91,$EE95
	dw $EEAE,$EEBF,$EED3,$EED7

DATA_E944:	incbin "Music/Levels/TitleScreen.bin"

MUSIC_BattleMode:
;$EFC9
	dw DATA_EFD3,DATA_EFE3,$00FF,MUSIC_BattleMode+$02
	dw $0000

DATA_EFD3:
	dw DATA_EFF3,$F020,$F040,$F049
	dw $F069,$F084,$F0B6,$F0BF

DATA_EFE3:
	dw $F0E8,$F129,$F192,$F1AA
	dw $F217,$F249,$0000,$F286

DATA_EFF3:	incbin "Music/Levels/BattleMode.bin"

MUSIC_BowserLetter:
;$F2FE
	dw DATA_F302,$0000

DATA_F302:
	dw DATA_F312,$F338,$F34F,$F364
	dw $F374,$F381,$F390,$F3A7

DATA_F312:	incbin "Music/Levels/BowserLetter.bin"

MUSIC_PeachLetter:
;$F3B0
	dw DATA_F3B4,$0000

DATA_F3B4:
	dw DATA_F3C4,$F3F7,$F413,$F43C
	dw $0000,$0000,$0000,$0000

DATA_F3C4:	incbin "Music/Levels/PeachLetter.bin"
%SPCDataBlockEnd(!ARAM_SMAS_MusicBankLoc)

%EndSPCUploadAndJumpToEngine($!ARAM_SMAS_EngineLoc)
