
%SPCDataBlockStart(!ARAM_SMW_SampleBankPtrTableLoc)
SamplePtrs:
dw SPC700_Sample00	:	dw SPC700_Sample00+$24
dw SPC700_Sample01	:	dw SPC700_Sample01+$24
dw SPC700_Sample02	:	dw SPC700_Sample02+$EA
dw SPC700_Sample03	:	dw SPC700_Sample03+$0129
dw SPC700_Sample04	:	dw SPC700_Sample04+$24
dw SPC700_Sample05	:	dw SPC700_Sample05+$0129
dw SPC700_Sample06	:	dw SPC700_Sample06
dw SPC700_Sample07	:	dw SPC700_Sample07+$0627
dw SPC700_Sample08	:	dw SPC700_Sample08+$24
dw SPC700_Sample09	:	dw SPC700_Sample09+$0C2A
dw SPC700_Sample0A	:	dw SPC700_Sample0A
dw SPC700_Sample0B	:	dw SPC700_Sample0B
dw SPC700_Sample0C	:	dw SPC700_Sample0C+$24
dw SPC700_Sample0D	:	dw SPC700_Sample0D+$029A
dw SPC700_Sample0E	:	dw SPC700_Sample0E+$0A71
dw SPC700_Sample0F	:	dw SPC700_Sample0F
dw SPC700_Sample10	:	dw SPC700_Sample10
dw SPC700_Sample11	:	dw SPC700_Sample11+$0510
dw SPC700_Sample12	:	dw SPC700_Sample12
dw SPC700_Sample13	:	dw SPC700_Sample13

%SPCDataBlockEnd(!ARAM_SMW_SampleBankPtrTableLoc)

%SPCDataBlockStart(!ARAM_SMW_SampleBankLoc)

SPC700_Sample00:	incbin "Samples/00.brr"
SPC700_Sample01:	incbin "Samples/01.brr"
SPC700_Sample02:	incbin "Samples/02.brr"
SPC700_Sample03:	incbin "Samples/03.brr"
SPC700_Sample04:	incbin "Samples/04.brr"
SPC700_Sample05:	incbin "Samples/05.brr"
SPC700_Sample06:	incbin "Samples/06.brr"
SPC700_Sample07:	incbin "Samples/07.brr"
SPC700_Sample08:	incbin "Samples/08.brr"
SPC700_Sample09:	incbin "Samples/09.brr"
SPC700_Sample0A:	incbin "Samples/0A.brr"
SPC700_Sample0B:	incbin "Samples/0B.brr"
SPC700_Sample0C:	incbin "Samples/0C.brr"
SPC700_Sample0D:	incbin "Samples/0D.brr"
SPC700_Sample0E:	incbin "Samples/0E.brr"
SPC700_Sample0F:	incbin "Samples/0F.brr"
SPC700_Sample10:	incbin "Samples/10.brr"
SPC700_Sample11:	incbin "Samples/11.brr"
SPC700_Sample12:	incbin "Samples/12.brr"
SPC700_Sample13:	incbin "Samples/13.brr"

db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

%SPCDataBlockEnd(!ARAM_SMW_SampleBankLoc)

%EndSPCUploadAndJumpToEngine($!ARAM_SMW_EngineLoc)
