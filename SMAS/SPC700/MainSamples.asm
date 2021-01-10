
%SPCDataBlockStart(!ARAM_SMAS_SampleBankPtrTableLoc)
SamplePtrs:
	dw SPC700_Sample00	:	dw SPC700_Sample00+$1B
	dw SPC700_Sample01	:	dw SPC700_Sample01+$1B
	dw SPC700_Sample02	:	dw SPC700_Sample02+$1B
	dw SPC700_Sample03	:	dw SPC700_Sample03+$E1
	dw SPC700_Sample04	:	dw SPC700_Sample04+$0120
	dw SPC700_Sample05	:	dw SPC700_Sample05+$1B
	dw SPC700_Sample06	:	dw SPC700_Sample06+$1B
	dw SPC700_Sample07	:	dw SPC700_Sample07+$0120
	dw SPC700_Sample08	:	dw SPC700_Sample0A
	dw SPC700_Sample09	:	dw SPC700_Sample0A
	dw SPC700_Sample0A	:	dw SPC700_Sample0A+$061E
	dw SPC700_Sample0B	:	dw SPC700_Sample0B+$1B
	dw SPC700_Sample0C	:	dw SPC700_Sample0C+$0C21
	dw SPC700_Sample0D	:	dw SPC700_Sample0E
	dw SPC700_Sample0E	:	dw SPC700_Sample0F
	dw SPC700_Sample0F	:	dw SPC700_Sample0F+$2D
	dw SPC700_Sample10	:	dw SPC700_Sample10+$0291
	dw SPC700_Sample11	:	dw SPC700_Sample11+$0A68
	dw SPC700_Sample12	:	dw SPC700_Sample13
	dw SPC700_Sample13	:	dw SPC700_Sample14
	dw SPC700_Sample14	:	dw SPC700_Sample14+$0507
	dw SPC700_Sample15	:	dw SPC700_Sample16
	dw SPC700_Sample16	:	dw SPC700_Sample17
	dw SPC700_Sample17	:	dw SPC700_Sample18
	dw SPC700_Sample18	:	dw SPC700_Sample18+$01E6
	dw SPC700_Sample19	:	dw SPC700_Sample19+$01E6
	dw $FFFF	:	dw $FFFF
	dw $FFFF	:	dw $FFFF
%SPCDataBlockEnd(!ARAM_SMAS_SampleBankPtrTableLoc)

%SPCDataBlockStart(!ARAM_SMAS_SampleBankLoc)
SPC700_Sample00:
;$4000
	incbin "Samples/Main/00.brr"

SPC700_Sample01:
SPC700_Sample02:
;$4036
	incbin "Samples/Main/01.brr"

SPC700_Sample03:
;$406C
	incbin "Samples/Main/03.brr"

SPC700_Sample04:
;$4168
	incbin "Samples/Main/04.brr"

SPC700_Sample05:
SPC700_Sample06:
;$42A3
	incbin "Samples/Main/05.brr"

SPC700_Sample07:
;$42D9
	incbin "Samples/Main/07.brr"

SPC700_Sample08:
SPC700_Sample09:
;$4507
	incbin "Samples/Main/08.brr"

SPC700_Sample0A:
;$496C
	incbin "Samples/Main/0A.brr"

SPC700_Sample0B:
;$4FC9
	incbin "Samples/Main/0B.brr"

SPC700_Sample0C:
;$4FFF
	incbin "Samples/Main/0C.brr"

SPC700_Sample0D:
;$5C3B
	incbin "Samples/Main/0D.brr"

SPC700_Sample0E:
;$6EB0
	incbin "Samples/Main/0E.brr"

SPC700_Sample0F:
;$7543
	incbin "Samples/Main/0F.brr"

SPC700_Sample10:
;$758B
	incbin "Samples/Main/10.brr"

SPC700_Sample11:
;$785B
	incbin "Samples/Main/11.brr"

SPC700_Sample12:
;$82DE
	incbin "Samples/Main/12.brr"

SPC700_Sample13:
;$8554
	incbin "Samples/Main/13.brr"

SPC700_Sample14:
;$8E30
	incbin "Samples/Main/14.brr"

SPC700_Sample15:
;$9391
	incbin "Samples/Main/15.brr"

SPC700_Sample16:
;$9CE2
	incbin "Samples/Main/16.brr"

SPC700_Sample17:
;$AE76
	incbin "Samples/Main/17.brr"

SPC700_Sample18:
SPC700_Sample19:
;$BA19
	incbin "Samples/Main/18.brr"
%SPCDataBlockEnd(!ARAM_SMAS_SampleBankLoc)

%EndSPCUploadAndJumpToEngine($!ARAM_SMAS_EngineLoc)
