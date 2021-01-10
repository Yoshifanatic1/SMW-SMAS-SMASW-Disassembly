
%SPCDataBlockStart(!ARAM_SMAS_SampleBankPtrTableLoc)
	dw SPC700_Sample00	:	dw SPC700_Sample00+$1B
	dw SPC700_Sample01	:	dw SPC700_Sample01+$E1
	dw SPC700_Sample02	:	dw SPC700_Sample02+$E1
	dw SPC700_Sample03	:	dw SPC700_Sample03+$E1
	dw SPC700_Sample04	:	dw SPC700_Sample04+$0120
	dw SPC700_Sample05	:	dw SPC700_Sample05+$0465
	dw SPC700_Sample06	:	dw SPC700_Sample06+$0465
	dw SPC700_Sample07	:	dw SPC700_Sample07+$0465
	dw SPC700_Sample08	:	dw SPC700_Sample08+$0465
	dw SPC700_Sample09	:	dw SPC700_Sample09+$0465
	dw $FFFF	:	dw $FFFF
	dw $FFFF	:	dw $FFFF
%SPCDataBlockEnd(!ARAM_SMAS_SampleBankPtrTableLoc)

%SPCDataBlockStart(!ARAM_SMAS_SampleBankLoc)
SPC700_Sample00:
;$4000
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	incbin "Samples/RandomChatter/00_SMAS_J.brr"
else
	incbin "Samples/RandomChatter/00_SMAS_U.brr"
endif

SPC700_Sample01:
SPC700_Sample02:
SPC700_Sample03:
;$8899
	incbin "Samples/RandomChatter/01.brr"

SPC700_Sample04:
;$8995
	incbin "Samples/RandomChatter/04.brr"

SPC700_Sample05:
SPC700_Sample06:
SPC700_Sample07:
SPC700_Sample08:
SPC700_Sample09:
;$8AD0
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	incbin "Samples/RandomChatter/05_SMAS_J.brr"
else
	incbin "Samples/RandomChatter/05_SMAS_U.brr"
endif
%SPCDataBlockEnd(!ARAM_SMAS_SampleBankLoc)

%EndSPCUploadAndJumpToEngine($!ARAM_SMAS_EngineLoc)
