
%SPCDataBlockStart(!ARAM_SMAS_MusicBankLoc)
MusicPtrs:
	dw MUSIC_Overworld		; $01
	dw MUSIC_Overworld		; $02 (Duplicate of $01)
	dw MUSIC_Overworld		; $03 (Duplicate of $01)
	dw MUSIC_CharacterSelect	; $04
	dw MUSIC_Subspace		; $05
	dw MUSIC_Underground		; $06
	dw MUSIC_WartBattle		; $07
	dw MUSIC_Danger			; $08
	dw MUSIC_Death			; $09
	dw MUSIC_GameOver		; $0A
	dw MUSIC_WorldClear		; $0B
	dw MUSIC_Fanfare		; $0C
	dw MUSIC_HaveStar		; $0D
	dw MUSIC_Ending			; $0E
	dw MUSIC_Fanfare		; $0F (Duplicate of $0C)
	dw MUSIC_WonSlots		; $10
	dw MUSIC_TitleScreen		; $11
	dw MUSIC_UnusedFanfare		; $12
	dw MUSIC_WarpZone		; $13

MUSIC_WarpZone:
;$C026
	dw DATA_C02A,$0000

DATA_C02A:
	dw DATA_C03A,$C0A5,$C0D8,$C109
	dw $C129,$C13B,$C14D,$0000

DATA_C03A:	incbin "Music/WarpZone.bin"

MUSIC_Fanfare:
;$C1A2
	dw DATA_C1A6,$0000

DATA_C1A6:
	dw DATA_C1B6,$C1D7,$C1E9,$C1FB
	dw $0000,$0000,$0000,$0000

DATA_C1B6:	incbin "Music/Fanfare.bin"

MUSIC_WorldClear:
;$C20E
	dw DATA_C212,$0000

DATA_C212:
	dw DATA_C222,$C262,$C28D,$C2BE
	dw $0000,$C2F1,$0000,$0000

DATA_C222:	incbin "Music/WorldClear.bin"

MUSIC_Ending:
;$C301
	dw DATA_C311,DATA_C321,DATA_C341,DATA_C331
	dw DATA_C351,$00FF,MUSIC_Ending+$06,$0000

DATA_C311:
	dw DATA_C361,$C3A8,$C3FB,$C42A
	dw $C47C,$C4CE,$C4F5,$C51C

DATA_C321:
	dw $C55A,$C586,$C5F3,$C628
	dw $C687,$C6E6,$C74A,$C7AF

DATA_C331:
	dw $C7D7,$C7E9,$C837,$0000
	dw $0000,$0000,$0000,$0000

DATA_C341:
	dw $C84A,$C868,$C87D,$0000
	dw $0000,$0000,$0000,$0000

DATA_C351:
	dw $C897,$C8AA,$C8BA,$0000
	dw $0000,$0000,$0000,$0000

DATA_C361:	incbin "Music/Ending.bin"

MUSIC_Death:
;$CA5D
	dw DATA_CA61,$0000

DATA_CA61:
	dw DATA_CA71,$CA96,$CAAC,$CABA
	dw $0000,$0000,$0000,$0000

DATA_CA71:	incbin "Music/Death.bin"

MUSIC_GameOver:
;$CAD9
	dw DATA_CADD,$0000

DATA_CADD:
	dw DATA_CAED,$CB06,$CB0A,$CB0E
	dw $CB18,$CB1C,$0000,$0000

DATA_CAED:	incbin "Music/GameOver.bin"

MUSIC_WonSlots:
;$CB63
	dw DATA_CB67,$0000

DATA_CB67:
	dw DATA_CB77,$CB9A,$CBB9,$CBD4
	dw $0000,$CBE8,$0000,$CC10

DATA_CB77:	incbin "Music/WonSlots.bin"

MUSIC_Overworld:
;$CC3F
	dw DATA_CCA5,DATA_CC55,DATA_CC65,DATA_CC85
	dw DATA_CC75,DATA_CC85,DATA_CC95,DATA_CCB5
	dw $00FF,MUSIC_Overworld+$04,$0000

DATA_CC55:
	dw DATA_CCC5,$CCF0,$CD0A,$CD1B
	dw $CD37,$CD55,$0000,$CD68

DATA_CC65:
	dw $CD88,$CDB0,$CDE2,$CE03
	dw $CE63,$CE89,$CEAF,$CED4

DATA_CC75:
	dw $CEEF,$CF24,$CF3D,$CF55
	dw $CF89,$CF95,$0000,$CFA1

DATA_CC85:
	dw $CFC2,$D00E,$D02D,$D042
	dw $D08F,$D0B7,$0000,$D0DF

DATA_CC95:
	dw $D108,$D12F,$D147,$D15F
	dw $D180,$D18F,$0000,$D19E

DATA_CCA5:
	dw $D1A9,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000

DATA_CCB5:
	dw $D1B0,$D200,$D222,$D23F
	dw $D298,$D2EE,$0000,$0000

DATA_CCC5:	incbin "Music/Overworld.bin"

MUSIC_CharacterSelect:
;$D4A3
	dw DATA_D4D9,DATA_D4B9,DATA_D4C9,DATA_D4F9
	dw DATA_D4C9,DATA_D509,DATA_D4E9,DATA_D519
	dw $00FF,MUSIC_CharacterSelect+$04,$0000

DATA_D4B9:
	dw DATA_D529,$0000,$D554,$D574
	dw $0000,$0000,$0000,$D5B2

DATA_D4C9:
	dw $D5C0,$D605,$D61A,$D640
	dw $0000,$0000,$0000,$D684

DATA_D4D9:
	dw $D692,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000

DATA_D4E9:
	dw $D699,$D69E,$D6B4,$D6B8
	dw $0000,$0000,$0000,$D6CE

DATA_D4F9:
	dw $D6E0,$D6E3,$0000,$0000
	dw $0000,$0000,$0000,$D6F4

DATA_D509:
	dw $D705,$D713,$0000,$D724
	dw $0000,$0000,$0000,$D731

DATA_D519:
	dw $D742,$D7CC,$D7E2,$D7E6
	dw $0000,$D7EA,$0000,$D806

DATA_D529:	incbin "Music/CharacterSelect.bin"

MUSIC_Underground:
;$D8F5
	dw DATA_D90F,DATA_D8FF,$00FF,MUSIC_Underground+$02
	dw $0000

DATA_D8FF:
	dw DATA_D91F,$D93A,$D958,$D97A
	dw $0000,$D9B2,$D9D7,$0000

DATA_D90F:
	dw $D9E1,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000

DATA_D91F:	incbin "Music/Underground.bin"

MUSIC_Danger:
;$DA35
	dw DATA_DA4F,DATA_DA3F,$00FF,MUSIC_Danger+$02
	dw $0000

DATA_DA3F:
	dw DATA_DA5F,$DA82,$DAA7,$DAB7
	dw $0000,$DAE7,$0000,$DAF9

DATA_DA4F:
	dw $DB17,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000

DATA_DA5F:	incbin "Music/Danger.bin"

MUSIC_Subspace:
;$DB9A
	dw DATA_DC0A,DATA_DBBA,DATA_DBCA,DATA_DBDA
	dw DATA_DBDA,DATA_DBEA,DATA_DC1A,DATA_DBCA
	dw DATA_DBFA,DATA_DBFA,DATA_DBEA,DATA_DC1A
	dw DATA_DBFA,$00FF,MUSIC_Subspace+$04,$0000

DATA_DBBA:
	dw DATA_DC2A,$0000,$0000,$DC33
	dw $0000,$0000,$0000,$0000

DATA_DBCA:
	dw $DC35,$DC62,$DC98,$DCA0
	dw $0000,$DCCC,$DCFD,$DD29

DATA_DBDA:
	dw $DD42,$DD8A,$DDD9,$DDE5
	dw $0000,$DE2C,$DE57,$DE80

DATA_DBEA:
	dw $DE99,$DEBF,$DF0B,$DF13
	dw $DF69,$DF7B,$DFCE,$DFE0

DATA_DBFA:
	dw $DFF9,$E03B,$E07F,$E09A
	dw $E0E6,$E116,$0000,$E14A

DATA_DC0A:
	dw $E163,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000

DATA_DC1A:
	dw $E16A,$E183,$E1A1,$E1C1
	dw $0000,$E1E1,$0000,$E1F8

DATA_DC2A:	incbin "Music/Subspace.bin"

MUSIC_WartBattle:
;$E2B5
	dw DATA_E2CF,DATA_E2BF,$00FF,MUSIC_WartBattle+$02
	dw $0000

DATA_E2BF:
	dw DATA_E2DF,$E327,$E35D,$E3E3
	dw $0000,$E45E,$0000,$E49E

DATA_E2CF:
	dw $E4DD,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000

DATA_E2DF:	incbin "Music/WartBattle.bin"

MUSIC_TitleScreen:
;$E586
	dw DATA_E58E,DATA_E59E,DATA_E5AE,$0000

DATA_E58E:
	dw DATA_E5BE,$E5FD,$E60D,$E632
	dw $0000,$E648,$0000,$0000

DATA_E59E:
	dw $E668,$E6CD,$E6EC,$E72D
	dw $E749,$E785,$0000,$E7C0

DATA_E5AE:
	dw $E7D9,$E827,$E85F,$E8A1
	dw $E909,$E954,$0000,$E9AE

DATA_E5BE:	incbin "Music/TitleScreen.bin"

MUSIC_UnusedFanfare:
;$EAA9
	dw DATA_EAAD,$0000

DATA_EAAD:
	dw DATA_EABD,$EAE1,$EAFC,$EB17
	dw $0000,$EB39,$0000,$0000

DATA_EABD:	incbin "Music/UnusedFanfare.bin"

MUSIC_HaveStar:
;$EB53
	dw DATA_EB5B,$00FF,MUSIC_HaveStar,$0000

DATA_EB5B:
	dw DATA_EB6B,$EB9D,$EBDB,$EBF8
	dw $EC32,$EC6E,$0000,$EC8B

DATA_EB6B:	incbin "Music/HaveStar.bin"
%SPCDataBlockEnd(!ARAM_SMAS_MusicBankLoc)

%EndSPCUploadAndJumpToEngine($!ARAM_SMAS_EngineLoc)
