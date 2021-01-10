
%SPCDataBlockStart(!ARAM_SMAS_MusicBankLoc)
MusicPtrs:
	dw MUSIC_TitleScreen		; $01
	dw MUSIC_GameSelect		; $02

MUSIC_TitleScreen:
;$C004
	dw DATA_C01E,DATA_C00E,$00FF,MUSIC_TitleScreen+$02
	dw $0000

DATA_C00E:
	dw DATA_C02E,$C0E1,$C119,$C17F
	dw $C1E6,$C208,$C239,$C260

DATA_C01E:
	dw $C287,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000

DATA_C02E:	incbin "Music/TitleScreen.bin"

MUSIC_GameSelect:
;$C296
	dw DATA_C2A0,DATA_C2B0,$00FF,MUSIC_GameSelect+$02
	dw $0000

DATA_C2A0:
	dw DATA_C2C0,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000

DATA_C2B0:
	dw $C2D3,$C2E6,$C31E,$C35A
	dw $C36A,$C3AA,$C3E8,$0000

DATA_C2C0:	incbin "Music/GameSelect.bin"
%SPCDataBlockEnd(!ARAM_SMAS_MusicBankLoc)

;%EndSPCUploadAndJumpToEngine($!ARAM_SMAS_EngineLoc)
