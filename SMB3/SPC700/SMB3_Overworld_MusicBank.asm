
; Note: If you want to edit the music and you're editing the USA version of SMAS+W, consider using the SMAS+W version of Addmusick: https://www.dropbox.com/s/ev3o1myylr7aaaw/SMAS%2BW%20AddmusicK.zip?dl=0
; If you'd rather not use that tool, someone will need to write a script that can turn the raw hex from the original ROM into a music file.

%SPCDataBlockStart(!ARAM_SMAS_MusicBankLoc)
MusicPtrs:
	dw MUSIC_PeachRescued		; $01
	dw MUSIC_World1			; $02
	dw MUSIC_World2			; $03
	dw MUSIC_World3			; $04
	dw MUSIC_World4			; $05
	dw MUSIC_World5			; $06
	dw MUSIC_Victory		; $07
	dw MUSIC_World6			; $08
	dw MUSIC_World7			; $09
	dw MUSIC_World8			; $0A
	dw MUSIC_WarpWhistle		; $0B
	dw MUSIC_ToadHouse		; $0C
	dw MUSIC_Minigame		; $0D
	dw MUSIC_MusicBox		; $0E
	dw MUSIC_Underground		; $0F (Note: This song is slightly different from the one in the level music bank)
	dw MUSIC_CloudBonusRoom		; $10

MUSIC_Victory:
;$C020
	dw DATA_C026,DATA_C036,$0000

DATA_C026:
	dw DATA_C046,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000

DATA_C036:
	dw $C059,$C06F,$C082,$C095
	dw $0000,$C0A8,$0000,$C0BB

DATA_C046:	incbin "Music/Overworld/Victory.bin"

MUSIC_PeachRescued:
;$C0CF
	dw DATA_C0F5,DATA_C105,DATA_C115,DATA_C105
	dw DATA_C125,DATA_C105,DATA_C135,DATA_C145
	dw DATA_C145,DATA_C175,DATA_C175,DATA_C155
	dw DATA_C165,DATA_C185,DATA_C165,DATA_C195
	dw $00FF,MUSIC_PeachRescued+$0E,$0000

DATA_C0F5:
	dw DATA_C1A5,$C1C5,$0000,$0000
	dw $0000,$0000,$0000,$0000

DATA_C105:
	dw $C1D2,$C1F2,$C20A,$C225
	dw $C242,$C25D,$0000,$0000

DATA_C115:
	dw $C27F,$C289,$C291,$C297
	dw $C29D,$C2A3,$0000,$0000

DATA_C125:
	dw $C2AC,$C2C3,$C2EA,$C30F
	dw $C330,$C342,$0000,$C357

DATA_C135:
	dw $C36F,$C3A1,$C3B6,$C3D1
	dw $C402,$C410,$0000,$C422

DATA_C145:
	dw $C448,$C46E,$C495,$C4BA
	dw $0000,$0000,$0000,$C4D7

DATA_C155:
	dw $C4DF,$C4FC,$C51E,$C533
	dw $0000,$C54E,$0000,$C564

DATA_C165:
	dw $C56C,$C5A5,$C5F9,$C656
	dw $0000,$C671,$C686,$C69B

DATA_C175:
	dw $C6AB,$C6B4,$C6C6,$C6CE
	dw $0000,$C6FA,$0000,$C702

DATA_C185:
	dw $C711,$C717,$C721,$C733
	dw $0000,$C74A,$C74D,$C750

DATA_C195:
	dw $C754,$C75E,$C768,$C775
	dw $0000,$C786,$C791,$C798

DATA_C1A5:	incbin "Music/Overworld/PeachRescued.bin"

MUSIC_World1:
;$C836
	dw DATA_C852,DATA_C862,DATA_C842,$00FF
	dw MUSIC_World1,$0000

DATA_C842:
	dw DATA_C872,$C89B,$C8BF,$C8E7
	dw $C911,$0000,$0000,$C925

DATA_C852:
	dw $C942,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000

DATA_C862:
	dw $C955,$C99D,$C9DD,$CA43
	dw $0000,$0000,$0000,$CA53

DATA_C872:	incbin "Music/Overworld/World1.bin"

MUSIC_World2:
;$CAF8
	dw DATA_CB12,DATA_CB02,$00FF,MUSIC_World2
	dw $0000

DATA_CB02:
	dw DATA_CB22,$CB3A,$CB51,$CB68
	dw $0000,$0000,$0000,$CBCC

DATA_CB12:
	dw $CBEF,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000

DATA_CB22:	incbin "Music/Overworld/World2.bin"

MUSIC_World3:
;$CC03
	dw DATA_CC1D,DATA_CC0D,$00FF,MUSIC_World3
	dw $0000

DATA_CC0D:
	dw DATA_CC2D,$CC72,$CCB3,$CCDF
	dw $CCF9,$CD33,$0000,$CD74

DATA_CC1D:
	dw $CD90,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000

DATA_CC2D:	incbin "Music/Overworld/World3.bin"

MUSIC_World4:
;$CE37
	dw DATA_CE51,DATA_CE41,$00FF,MUSIC_World4
	dw $0000

DATA_CE41:
	dw DATA_CE61,$CEA2,$CEE1,$CEF7
	dw $0000,$CF15,$0000,$CF38

DATA_CE51:
	dw $CF68,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000

DATA_CE61:	incbin "Music/Overworld/World4.bin"

MUSIC_World5:
;$CFFD
	dw DATA_D017,DATA_D007,$00FF,MUSIC_World5+$02
	dw $0000

DATA_D007:
	dw DATA_D027,$D04D,$D074,$D086
	dw $D0AB,$D0D0,$0000,$D0E5

DATA_D017:
	dw $D107,$D11C,$D124,$D135
	dw $D13F,$0000,$0000,$0000

DATA_D027:	incbin "Music/Overworld/World5.bin"

MUSIC_CloudBonusRoom:
;$D16C
	dw DATA_D186,DATA_D176,$00FF,MUSIC_CloudBonusRoom+$02
	dw $0000

DATA_D176:
	dw DATA_D196,$D1E7,$D216,$D243
	dw $0000,$D26F,$0000,$0000

DATA_D186:
	dw $D29D,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000

DATA_D196:	incbin "Music/Overworld/CloudBonusRoom.bin"

MUSIC_World6:
;$D2B1
	dw DATA_D2CB,DATA_D2BB,$00FF,MUSIC_World6+$02
	dw $0000

DATA_D2BB:
	dw DATA_D2DB,$D2FA,$D319,$D336
	dw $D355,$0000,$0000,$D37C

DATA_D2CB:
	dw $D3A9,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000

DATA_D2DB:	incbin "Music/Overworld/World6.bin"

MUSIC_World7:
;$D3BD
	dw DATA_D3D7,DATA_D3C7,$00FF,MUSIC_World7+$02
	dw $0000

DATA_D3C7:
	dw DATA_D3E7,$D427,$D464,$D480
	dw $0000,$D49C,$0000,$0000

DATA_D3D7:
	dw $D4B9,$D4D4,$D4E0,$0000
	dw $0000,$0000,$0000,$0000

DATA_D3E7:	incbin "Music/Overworld/World7.bin"

MUSIC_World8:
;$D4FC
	dw DATA_D516,DATA_D506,$00FF,MUSIC_World8+$02
	dw $0000

DATA_D506:
	dw $D526,$D52B,$D52F,$D533
	dw $0000,$D537,$0000,$0000

DATA_D516:
	dw $D53B,$D556,$D562,$0000
	dw $0000,$0000,$0000,$0000

DATA_D526:	incbin "Music/Overworld/World8.bin"

MUSIC_WarpWhistle:
;$D5C6
	dw DATA_D5E2,DATA_D5F2,DATA_D5D2,$00FF
	dw MUSIC_WarpWhistle+$04,$0000

DATA_D5D2:
	dw DATA_D602,$D653,$D682,$D6AF
	dw $0000,$D6DB,$0000,$0000

DATA_D5E2:
	dw $D709,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000

DATA_D5F2:
	dw $D71C,$D736,$0000,$0000
	dw $0000,$0000,$0000,$0000

DATA_D602:	incbin "Music/Overworld/WarpWhistle.bin"

MUSIC_ToadHouse:
;$D752
	dw DATA_D780,DATA_D770,DATA_D770,DATA_D760
	dw $00FF,MUSIC_ToadHouse+$02,$0000

DATA_D760:
	dw DATA_D790,$D7B0,$D7D1,$D7E9
	dw $0000,$D7F5,$0000,$D7F9

DATA_D770:
	dw $D7FD,$D814,$D818,$D830
	dw $0000,$D84F,$0000,$D870

DATA_D780:
	dw $D874,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000

DATA_D790:	incbin "Music/Overworld/ToadHouse.bin"

MUSIC_Minigame:
;$D8C3
	dw DATA_D8CB,$00FF,MUSIC_Minigame,$0000

DATA_D8CB:
	dw DATA_D8DB,$D8FE,$D912,$0000
	dw $0000,$0000,$D936,$0000

DATA_D8DB:	incbin "Music/Overworld/Minigame.bin"

MUSIC_MusicBox:
;$D942
	dw DATA_D94A,$00FF,MUSIC_MusicBox,$0000

DATA_D94A:
	dw DATA_D95A,$D979,$D996,$D9B5
	dw $0000,$D9D6,$0000,$0000

DATA_D95A:	incbin "Music/Overworld/MusicBox.bin"

MUSIC_Underground:
;$DA6F
	dw DATA_DA8B,DATA_DA9B,DATA_DA7B,$00FF
	dw MUSIC_Underground+$02,$0000

DATA_DA7B:
	dw DATA_DAAB,$DAD9,$DAE1,$DAFD
	dw $0000,$DB49,$0000,$DB7F

DATA_DA8B:
	dw $DBAE,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000

DATA_DA9B:
	dw $DBB5,$DBCF,$DBD3,$0000
	dw $0000,$DBFB,$0000,$0000

DATA_DAAB:	incbin "Music/Overworld/Underground.bin"
%SPCDataBlockEnd(!ARAM_SMAS_MusicBankLoc)

%EndSPCUploadAndJumpToEngine($!ARAM_SMAS_EngineLoc)
