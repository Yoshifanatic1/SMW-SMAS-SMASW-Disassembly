
; Todo: $3C80, $3EF0, $FE00 are addresses referenced in the code beyond the engine. I don't know what they do.

%SPCDataBlockStart(3D00)
DATA_3D00:
	db $00,$FE,$6A,$B8,$05,$F0,$01,$FA,$6A,$B8,$02,$F0,$02,$FA,$6A,$B8
	db $02,$F0,$03,$AE,$2F,$B8,$02,$EF,$04,$FE,$10,$B8,$05,$F0,$05,$A9
	db $6A,$B8,$03,$00,$06,$BE,$1A,$B8,$03,$00,$07,$AE,$26,$B8,$1D,$F0
	db $08,$8C,$E0,$70,$07,$A0,$09,$0E,$6A,$40,$07,$A0,$0A,$AE,$26,$B8
	db $07,$00,$0B,$FA,$6A,$B8,$03,$00,$0C,$9E,$1F,$B8,$02,$F0,$0D,$EE
	db $6A,$B8,$05,$40,$0E,$FE,$6A,$B8,$07,$A0,$0F,$FE,$70,$B8,$03,$00
	db $10,$AE,$26,$B8,$06,$F0,$11,$8F,$E0,$B8,$04,$70,$12,$8F,$ED,$B8
	db $07,$A0,$13,$0E,$6A,$7F,$07,$A0,$14,$FE,$6A,$B8,$09,$F0,$15,$8E
	db $E0,$B8,$06,$55,$16,$8F,$E0,$B8,$07,$A0,$17,$FF,$E0,$B8,$02,$50
	db $18,$FF,$E0,$B8,$03,$C0,$19,$FF,$E0,$B8,$03,$00
%SPCDataBlockEnd(3D00)

%SPCDataBlockStart(3EE8)
DATA_3EE8:
	db $32,$65,$7F,$98,$B2,$CB,$E5,$FC,$19,$32,$4C,$65,$72,$7F,$8C,$98
	db $A5,$B2,$BF,$CB,$D8,$E5,$F2,$FC
%SPCDataBlockEnd(3EE8)

%SPCDataBlockStart(!ARAM_SMAS_EngineLoc)
SPC700_Engine:
	CLRP
	MOV X,#$CF
	MOV SP,X
	MOV A,#$00
	MOV X,A
CODE_0507:
	MOV (X+),A
	CMP X,#$E0
	BNE CODE_0507
	MOV X,#$00
CODE_050E:
	MOV $0200+X,A
	INC X
	BNE CODE_050E
CODE_0514:
	MOV $0300+X,A
	INC X
	BNE CODE_0514
	INC A
	CALL CODE_0C11
	SET5 $48
	CALL CODE_0736
	MOV A,#$60
	MOV Y,#$0C
	CALL CODE_06FC
	MOV Y,#$1C
	CALL CODE_06FC
	MOV A,#$3C
	MOV Y,#$5D
	CALL CODE_06FC
	MOV A,#$F0
	MOV !REGISTER_SPC700_ControlRegister,A
	MOV A,#$10
	MOV !REGISTER_SPC700_Timer0,A
	MOV $53,A
	MOV A,#$01
	MOV !REGISTER_SPC700_ControlRegister,A
CODE_0547:
	MOV Y,#$0A
CODE_0549:
	CMP Y,#$05
	BEQ CODE_0554
	BCS CODE_0557
	CMP $4C,$4D
	BNE CODE_0565
CODE_0554:
	BBS7 $4C,CODE_0565
CODE_0557:
	MOV A,DATA_0F98+Y
	MOV !REGISTER_SPC700_DSPRegisterIndex,A
	MOV A,DATA_0FA2+Y
	MOV X,A
	MOV A,(X)
	MOV !REGISTER_SPC700_ReadWriteToDSPRegister,A
CODE_0565:
	DBNZ Y,CODE_0549
	MOV $45,Y
	MOV $46,Y
	MOV A,$18
	EOR A,$19
	LSR A
	LSR A
	NOTC
	ROR $18
	ROR $19
CODE_0576:
	MOV Y,!REGISTER_SPC700_Counter0
	BEQ CODE_0576
	PUSH Y
	MOV A,#$38
	MUL YA
	CLRC
	ADC A,$43
	MOV $43,A
	BCC CODE_05B1
	CALL CODE_102E
	MOV X,#$00
	CALL CODE_05ED
	CALL CODE_14C1
	CALL CODE_13E4
	MOV X,#$01
	CALL CODE_05E7
	CALL CODE_11D6
	MOV X,#$03
	CALL CODE_05ED
	CMP $4C,$4D
	BEQ CODE_05B1
	INC $03C7
	MOV A,$03C7
	LSR A
	BCS CODE_05B1
	INC $4C
CODE_05B1:
	MOV A,$53
	POP Y
	MUL YA
	CLRC
	ADC A,$51
	MOV $51,A
	BCC CODE_05C7
	CALL CODE_08BB
	MOV X,#$02
	CALL CODE_05ED
	JMP CODE_0547

CODE_05C7:
	MOV A,$06
	BEQ CODE_05DD
	MOV X,#$00
	MOV $47,#$01
CODE_05D0:
	MOV A,$31+X
	BEQ CODE_05D7
	CALL CODE_0EC1
CODE_05D7:
	INC X
	INC X
	ASL $47
	BNE CODE_05D0
CODE_05DD:
	MOV A,$26
	BEQ CODE_05E4
	CALL CODE_0703
CODE_05E4:
	JMP CODE_0547

;--------------------------------------------------------------------

CODE_05E7:
	MOV A,$05
	OR A,$26
	BRA CODE_05EF

CODE_05ED:
	MOV A,$D2+X
CODE_05EF:
	MOV !REGISTER_SPC700_APUPort0+X,A
CODE_05F2:
	MOV A,!REGISTER_SPC700_APUPort0+X
	CMP A,!REGISTER_SPC700_APUPort0+X
	BNE CODE_05F2
	MOV Y,A
	MOV A,$08+X
	MOV $08+X,Y
	CBNE $08+X,CODE_0604
	MOV Y,#$00
CODE_0604:
	MOV $00+X,Y
CODE_0606:
	RET

;--------------------------------------------------------------------

CODE_0607:
	CMP Y,#$CA
	BCC CODE_0610
	CALL CODE_0A22
	MOV Y,#$A4
CODE_0610:
	CMP Y,#$C8
	BCS CODE_0606
	MOV A,$1A
	AND A,$47
	BNE CODE_0606
	MOV A,Y
	AND A,#$7F
	CLRC
	ADC A,$50
	CLRC
	ADC A,$02F0+X
	MOV $0361+X,A
	MOV A,$0381+X
	MOV $0360+X,A
	MOV A,$02B1+X
	LSR A
	MOV A,#$00
	ROR A
	MOV $02A0+X,A
	MOV A,#$00
	MOV $B0+X,A
	MOV $0100+X,A
	MOV $02D0+X,A
	MOV $C0+X,A
	OR $5E,$47
	OR $45,$47
	MOV A,$0280+X
	MOV $A0+X,A
	BEQ CODE_066E
	MOV A,$0281+X
	MOV $A1+X,A
	MOV A,$0290+X
	BNE CODE_0664
	MOV A,$0361+X
	SETC
	SBC A,$0291+X
	MOV $0361+X,A
CODE_0664:
	MOV A,$0291+X
	CLRC
	ADC A,$0361+X
	CALL CODE_0C98
CODE_066E:
	CALL CODE_0CB0
CODE_0671:
	MOV Y,#$00
	MOV A,$11
	SETC
	SBC A,#$34
	BCS CODE_0683
	MOV A,$11
	SETC
	SBC A,#$13
	BCS CODE_0687
	DEC Y
	ASL A
CODE_0683:
	ADDW YA,$10
	MOVW $10,YA
CODE_0687:
	PUSH X
	MOV A,$11
	ASL A
	MOV Y,#$00
	MOV X,#$18
	DIV YA,X
	MOV X,A
	MOV A,DATA_0FAD+$01+Y
	MOV $15,A
	MOV A,DATA_0FAD+Y
	MOV $14,A
	MOV A,DATA_0FAD+$03+Y
	PUSH A
	MOV A,DATA_0FAD+$02+Y
	POP Y
	SUBW YA,$14
	MOV Y,$10
	MUL YA
	MOV A,Y
	MOV Y,#$00
	ADDW YA,$14
	MOV $15,Y
	ASL A
	ROL $15
	MOV $14,A
	BRA CODE_06BA

CODE_06B6:
	LSR $15
	ROR A
	INC X
CODE_06BA:
	CMP X,#$06
	BNE CODE_06B6
	MOV $14,A
	POP X
	MOV A,$0220+X
	MOV Y,$15
	MUL YA
	MOVW $16,YA
	MOV A,$0220+X
	MOV Y,$14
	MUL YA
	PUSH Y
	MOV A,$0221+X
	MOV Y,$14
	MUL YA
	ADDW YA,$16
	MOVW $16,YA
	MOV A,$0221+X
	MOV Y,$15
	MUL YA
	MOV Y,A
	POP A
	ADDW YA,$16
	MOVW $16,YA
	MOV A,X
	XCN A
	LSR A
	OR A,#$02
	MOV Y,A
	MOV A,$16
	CALL CODE_06F4
	INC Y
	MOV A,$17
CODE_06F4:
	PUSH A
	MOV A,$47
	AND A,$1A
	POP A
	BNE CODE_0702
CODE_06FC:
	MOV !REGISTER_SPC700_DSPRegisterIndex,Y
	MOV !REGISTER_SPC700_ReadWriteToDSPRegister,A
CODE_0702:
	RET

;--------------------------------------------------------------------

CODE_0703:
	DEC $24
	MOV A,$24
	AND A,#$03
	MOV Y,#$3F
	MUL YA
	MOV Y,A
	MOV $12,#$07
CODE_0710:
	INC Y
	MOV X,#$04
CODE_0713:
	MOV1 C,$0019.6
	EOR1 C,$0019.5
	ROL $18
	ROL $19
	MOV A,$19
	AND A,#$FF
	OR A,#$11
	MOV $FE00+Y,A
	INC Y
	MOV A,$18
	OR A,#$11
	MOV $FE00+Y,A
	INC Y
	DEC X
	BNE CODE_0713
	DBNZ $12,CODE_0710
	RET

;--------------------------------------------------------------------

CODE_0736:
	MOV Y,#$00
	MOV X,#$1B
	MOV A,#$96
CODE_073C:
	MOV $FE00+Y,A
	INC Y
	INC Y
	INC Y
	INC Y
	INC Y
	INC Y
	INC Y
	INC Y
	INC Y
	DEC X
	BNE CODE_073C
	INC A
	MOV $FE00+Y,A
	MOV Y,#$FE
	MOV A,#$00
	MOV $3C80,A
	MOV $3C80+$01,Y
	MOV $3C80+$02,A
	MOV $3C80+$03,Y
	MOV A,$18
	OR A,$19
	BNE CODE_0767
	INC $18
CODE_0767:
	RET

;--------------------------------------------------------------------

CODE_0768:
	MOV A,#$00
	MOV Y,#$2C
	CALL CODE_06FC
	MOV Y,#$3C
	CALL CODE_06FC
	MOV A,#$FF
	MOV Y,#$5C
	CALL CODE_06FC
	CALL CODE_0FD2
	MOV A,#$00
	MOV $03CA,A
	MOV $04,A
	MOV $05,A
	MOV $07,A
	MOV $26,A
	MOV $1A,A
	MOV $03C8,A
	MOV A,$03F8
	BNE CODE_0799
	MOV A,#$00
	MOV $06,A
CODE_0799:
	RET

;--------------------------------------------------------------------

CODE_079A:
	MOV Y,#$00
	MOV $03C8,Y
CODE_079F:
	MOV Y,$26
	BEQ CODE_07A6
	CALL CODE_13A9
CODE_07A6:
	MOV X,#$90
	MOV $5A,X
	MOV $03CA,X
	MOV A,#$00
	MOV $5B,A
	SETC
	SBC A,$59
	CALL CODE_0CBB
	MOVW $5C,YA
	JMP CODE_08C9

CODE_07BC:
	MOV A,#$00
	MOV $03CA,A
	MOV $5A,A
	MOV A,$03F1
	BNE CODE_07E6
	MOV A,$59
	MOV $03F1,A
	MOV A,#$70
	MOV $59,A
	JMP CODE_08C9

CODE_07D4:
	MOV A,$03F1
	BEQ CODE_07E6
	MOV A,$03F1
	MOV $59,A
	MOV A,#$00
	MOV $03F1,A
	JMP CODE_08C9

CODE_07E6:
	RET

CODE_07E7:
	CMP A,#$F1
	BEQ CODE_07BC
	CMP A,#$F2
	BEQ CODE_07D4
	CMP A,#$F0
	BEQ CODE_0806
	CMP A,#$F3
	BEQ CODE_079A
	BMI CODE_079F
	CMP A,#$19
	BCC CODE_0825
	RET

CODE_07FE:
	DEC $03CA
	BEQ CODE_0806
	JMP CODE_08DA

CODE_0806:
	MOV A,$1A
	EOR A,#$FF
	TSET $0046,A
	MOV $06,#$00
	MOV $D4,#$00
	MOV $47,#$00
	RET

CODE_0817:
	MOV Y,#$00
	MOV A,($40)+Y
	INCW $40
	PUSH A
	MOV A,($40)+Y
	INCW $40
	MOV Y,A
	POP A
	RET

CODE_0825:
	CLRC
	CMP A,#$12
	BEQ CODE_084C
	CMP A,#$07
	BEQ CODE_083E
	CMP A,#$09
	BCC CODE_084C
	CMP A,#$0D
	BEQ CODE_084C
	CMP A,#$11
	BEQ CODE_084C
	CMP A,#$14
	BEQ CODE_084C
CODE_083E:
	MOV Y,#$00				; Note: This is where the SPC engine is split.
	MOV $03C8,Y
	MOV Y,$26
	BEQ CODE_084C
	PUSH A
	CALL CODE_13A9
	POP A
CODE_084C:
	MOV X,#$00
	MOV $03CA,X
	MOV $03F1,X
	MOV $06,A
	CLRC
	ASL A
	MOV X,A
	MOV A,MusicPtrs-$01+X
	MOV Y,A
	BNE CODE_0862
	MOV $06,A
	RET

CODE_0862:
	MOV A,MusicPtrs-$02+X
	MOVW $40,YA
	MOV $0D,#$02
	MOV A,$1A
	EOR A,#$FF
	TSET $0046,A
	RET

;--------------------------------------------------------------------

CODE_0872:
	MOV X,#$0E
	MOV $47,#$80
CODE_0877:
	MOV A,$47
	AND A,$1A
	AND A,#$20
	BNE CODE_08A2
	MOV A,#$FF
	MOV $0301+X,A
	MOV A,#$0A
	CALL CODE_0A7B
	MOV $0211+X,A
	MOV $0381+X,A
	MOV $02F0+X,A
	MOV $0280+X,A
	MOV $03E1+X,A
	MOV $03E0+X,A
	MOV $03A1+X,A
	MOV $B1+X,A
	MOV $C1+X,A
CODE_08A2:
	DEC X
	DEC X
	LSR $47
	BNE CODE_0877
	MOV $5A,A
	MOV $68,A
	MOV $54,A
	MOV $50,A
	MOV $42,A
	MOV $5F,A
	MOV $59,#$C0
	MOV $53,#$20
CODE_08BA:
	RET

;--------------------------------------------------------------------

CODE_08BB:
	MOV A,$02
	BEQ CODE_08C9
	MOV X,#$00
	MOV $03F8,X
	MOV $D4,A
	JMP CODE_07E7

CODE_08C9:
	MOV A,$03F8
	BNE CODE_08BA
	MOV A,$06
	BEQ CODE_08BA
	MOV A,$03CA
	BEQ CODE_08DA
	JMP CODE_07FE

CODE_08DA:
	MOV A,$0D
	BEQ CODE_0935
	DBNZ $0D,CODE_0872
CODE_08E1:
	CALL CODE_0817
	BNE CODE_08FD
	MOV Y,A
	BNE CODE_08EC
	JMP CODE_0806

CODE_08EC:
	DEC $42
	BPL CODE_08F2
	MOV $42,A
CODE_08F2:
	CALL CODE_0817
	MOV X,$42
	BEQ CODE_08E1
	MOVW $40,YA
	BRA CODE_08E1

CODE_08FD:
	MOVW $16,YA
	MOV Y,#$0F
CODE_0901:
	MOV A,($16)+Y
	MOV $0030+Y,A
	DEC Y
	BPL CODE_0901
	MOV X,#$00
	MOV $47,#$01
CODE_090E:
	MOV A,$31+X
	BEQ CODE_091C
	MOV A,$0211+X
	BNE CODE_091C
	MOV A,#$00
	CALL CODE_0A22
CODE_091C:
	MOV A,#$00
	MOV $80+X,A
	PUSH A
	MOV A,$47
	AND A,$1A
	POP A
	BNE CODE_092C
	MOV $91+X,A
	MOV $90+X,A
CODE_092C:
	INC A
	MOV $70+X,A
	INC X
	INC X
	ASL $47
	BNE CODE_090E
CODE_0935:
	MOV X,#$00
	MOV $5E,X
	MOV $47,#$01
CODE_093C:
	MOV $44,X
	MOV A,$31+X
	BEQ CODE_09B0
	DEC $70+X
	BNE CODE_09AA
CODE_0946:
	CALL CODE_0A18
	BNE CODE_0962
	MOV A,$80+X
	BEQ CODE_08E1
	CALL CODE_0BA6
	DEC $80+X
	BNE CODE_0946
	MOV A,$0230+X
	MOV $30+X,A
	MOV A,$0231+X
	MOV $31+X,A
	BRA CODE_0946

CODE_0962:
	BMI CODE_0984
	MOV $0200+X,A
	CALL CODE_0A18
	BMI CODE_0984
	PUSH A
	XCN A
	AND A,#$07
	MOV Y,A
	MOV A,DATA_3EE8+Y
	MOV $0201+X,A
	POP A
	AND A,#$0F
	MOV Y,A
	MOV A,$3EF0+Y
	MOV $0210+X,A
	CALL CODE_0A18
CODE_0984:
	CMP A,#$E0
	BCC CODE_098D
	CALL CODE_0A06
	BRA CODE_0946

CODE_098D:
	PUSH A
	MOV A,$47
	AND A,$1A
	POP A
	BNE CODE_0998
	CALL CODE_0607
CODE_0998:
	MOV A,$0200+x
	MOV $70+X,A
	MOV Y,A
	MOV A,$0201+x
	MUL YA
	MOV A,Y
	BNE CODE_09A6
	INC A
CODE_09A6:
	MOV $71+X,A
	BRA CODE_09AD

CODE_09AA:
	CALL CODE_0DE2
CODE_09AD:
	CALL CODE_0C67
CODE_09B0:
	INC X
	INC X
	ASL $47
	BEQ CODE_09B9
	JMP CODE_093C

CODE_09B9:
	MOV A,$54
	BEQ CODE_09C8
	MOVW YA,$56
	ADDW YA,$52
	DBNZ $54,CODE_09C6
	MOVW YA,$54
CODE_09C6:
	MOVW $52,YA
CODE_09C8:
	MOV A,$68
	BEQ CODE_09E1
	MOVW YA,$64
	ADDW YA,$60
	MOVW $60,YA
	MOVW YA,$66
	ADDW YA,$62
	DBNZ $68,CODE_09DF
	MOVW YA,$68
	MOVW $60,YA
	MOV Y,$6A
CODE_09DF:
	MOVW $62,YA
CODE_09E1:
	MOV A,$5A
	BEQ CODE_09F3
	MOVW YA,$5C
	ADDW YA,$58
	DBNZ $5A,CODE_09EE
	MOVW YA,$5A
CODE_09EE:
	MOVW $58,YA
	MOV $5E,#$FF
CODE_09F3:
	MOV X,#$00
	MOV $47,#$01
CODE_09F8:
	MOV A,$31+X
	BEQ CODE_09FF
	CALL CODE_0D28
CODE_09FF:
	INC X
	INC X
	ASL $47
	BNE CODE_09F8
	RET

;--------------------------------------------------------------------

CODE_0A06:
	ASL A
	MOV Y,A
	MOV A,DATA_0CD7-$BF+Y
	PUSH A
	MOV A,DATA_0CD7-$C0+Y
	PUSH A
	MOV A,Y
	LSR A
	MOV Y,A
	MOV A,DATA_0D0D-$60+Y
	BEQ CODE_0A20
CODE_0A18:
	MOV A,($30+X)
CODE_0A1A:
	INC $30+X
	BNE CODE_0A20
	INC $31+X
CODE_0A20:
	MOV Y,A
	RET

;--------------------------------------------------------------------

CODE_0A22:
	MOV $0211+X,A
	MOV Y,A
	BPL CODE_0A2E
	SETC
	SBC A,#$CA
	CLRC
	ADC A,$5F
CODE_0A2E:
	MOV Y,#$06
	MUL YA
	MOVW $14,YA
	CLRC
	ADC.b $14,#DATA_3D00
	ADC.b $15,#DATA_3D00>>8
	MOV A,$1A
	AND A,$47
	BNE CODE_0A7A
	PUSH X
	MOV A,X
	XCN A
	LSR A
	OR A,#$04
	MOV X,A
	MOV Y,#$00
	MOV A,($14)+Y
	BPL CODE_0A5B
	AND A,#$1F
	AND $48,#$20
	TSET $0048,A
	OR $49,$47
	MOV A,Y
	BRA CODE_0A62

CODE_0A5B:
	MOV A,$47
	TCLR $0049,A
CODE_0A60:
	MOV A,($14)+Y
CODE_0A62:
	MOV !REGISTER_SPC700_DSPRegisterIndex,X
	MOV !REGISTER_SPC700_ReadWriteToDSPRegister,A
	INC X
	INC Y
	CMP Y,#$04
	BNE CODE_0A60
	POP X
	MOV A,($14)+Y
	MOV $0221+X,A
	INC Y
	MOV A,($14)+Y
	MOV $0220+X,A
CODE_0A7A:
	RET

;--------------------------------------------------------------------

CODE_0A7B:
	MOV $0351+X,A
	AND A,#$1F
	MOV $0331+X,A
	MOV A,#$00
	MOV $0330+X,A
	RET

;--------------------------------------------------------------------

CODE_0A89:
	MOV $91+X,A
	PUSH A
	CALL CODE_0A18
	MOV $0350+X,A
	SETC
	SBC A,$0331+X
	POP X
	CALL CODE_0CBB
	MOV $0340+X,A
	MOV A,Y
	MOV $0341+X,A
	RET

;--------------------------------------------------------------------

CODE_0AA2:
	MOV $02B0+X,A
	CALL CODE_0A18
	MOV $02A1+X,A
	CALL CODE_0A18
CODE_0AAE:
	MOV $B1+X,A
	MOV $02C1+X,A
	MOV A,#$00
	MOV $02B1+X,A
	RET

;--------------------------------------------------------------------

CODE_0AB9:
	MOV $02B1+X,A
	PUSH A
	MOV Y,#$00
	MOV A,$B1+X
	POP X
	DIV YA,X
	MOV X,$44
	MOV $02C0+X,A
	RET

;--------------------------------------------------------------------

CODE_0AC9:
	MOV A,$03CA
	BNE CODE_0AD7
	MOV A,$03F1
	BNE CODE_0AD7
	MOV A,#$00
	MOVW $58,YA
CODE_0AD7:
	RET

;--------------------------------------------------------------------

CODE_0AD8:
	MOV $5A,A
	CALL CODE_0A18
	MOV $5B,A
	SETC
	SBC A,$59
	MOV X,$5A
	CALL CODE_0CBB
	MOVW $5C,YA
	RET

;--------------------------------------------------------------------

CODE_0AEA:
	ADC A,$03C8
	MOV Y,A
	MOV A,#$00
	MOVW $52,YA
	RET

;--------------------------------------------------------------------

CODE_0AF3:
	MOV $54,A
	CALL CODE_0A18
	ADC A,$03C8
	MOV $55,A
	SETC
	SBC A,$53
	MOV X,$54
	CALL CODE_0CBB
	MOVW $56,YA
	RET

;--------------------------------------------------------------------

CODE_0B08:
	MOV $50,A
	RET

;--------------------------------------------------------------------

CODE_0B0B:
	MOV $03A1+X,A
	PUSH A
	MOV A,$47
	AND A,$1A
	POP A
	BNE CODE_0B1C
	MOV A,$03A1+X
	MOV $02F0+X,A
CODE_0B1C:
	RET

;--------------------------------------------------------------------

CODE_0B1D:
	MOV $02E0+X,A
	CALL CODE_0A18
	MOV $02D1+X,A
	CALL CODE_0A18
CODE_0B29:
	MOV $C1+X,A
	RET

;--------------------------------------------------------------------

CODE_0B2C:
	MOV A,#$01
	BRA CODE_0B32

CODE_0B30:
	MOV A,#$00
CODE_0B32:
	MOV $0290+X,A
	MOV A,Y
	MOV $0281+X,A
	CALL CODE_0A18
	MOV $03E1+X,A
	PUSH A
	MOV A,$47
	AND A,$1A
	POP A
	BEQ CODE_0B49
	MOV A,#$00
CODE_0B49:
	MOV $0280+X,A
	CALL CODE_0A18
	MOV $0291+X,A
	RET

;--------------------------------------------------------------------

CODE_0B53:
	MOV $0280+X,A
	MOV $03E1+X,A
	RET

;--------------------------------------------------------------------

CODE_0B5A:
	MOV $0301+X,A
	MOV A,#$00
	MOV $0300+X,A
	RET

;--------------------------------------------------------------------

CODE_0B63:
	MOV $90+X,A
	PUSH A
	CALL CODE_0A18
	MOV $0320+X,A
	SETC
	SBC A,$0301+X
	POP X
	CALL CODE_0CBB
	MOV $0310+X,A
	MOV A,Y
	MOV $0311+X,A
	RET

;--------------------------------------------------------------------

CODE_0B7C:
	MOV $03E0+X,A
	PUSH A
	MOV A,$47
	AND A,$1A
	POP A
	BNE CODE_0B8D
	MOV A,$03E0+X
	MOV $0381+X,A
CODE_0B8D:
	RET

;--------------------------------------------------------------------

CODE_0B8E:
	MOV $0240+X,A
	CALL CODE_0A18
	MOV $0241+X,A
	CALL CODE_0A18
	MOV $80+X,A
	MOV A,$30+X
	MOV $0230+X,A
	MOV A,$31+X
	MOV $0231+X,A
CODE_0BA6:
	MOV A,$0240+X
	MOV $30+X,A
	MOV A,$0241+X
	MOV $31+X,A
	RET

;--------------------------------------------------------------------

CODE_0BB1:
	MOV $03C3,A
	MOV $4A,A
	CALL CODE_0A18
	MOV A,#$00
	MOVW $60,YA
	CALL CODE_0A18
	MOV A,#$00
	MOVW $62,YA
	CLR5 $48
	RET

;--------------------------------------------------------------------

CODE_0BC7:
	MOV $68,A
	CALL CODE_0A18
	MOV $69,A
	SETC
	SBC A,$61
	MOV X,$68
	CALL CODE_0CBB
	MOVW $64,YA
	CALL CODE_0A18
	MOV $6A,A
	SETC
	SBC A,$63
	MOV X,$68
	CALL CODE_0CBB
	MOVW $66,YA
	RET

;--------------------------------------------------------------------

CODE_0BE8:
	MOVW $60,YA
	MOVW $62,YA
	SET5 $48
	RET

;--------------------------------------------------------------------

CODE_0BEF:
	CALL CODE_0C11
	CALL CODE_0A18
	MOV $4E,A
	CALL CODE_0A18
	MOV Y,#$08
	MUL YA
	MOV X,A
	MOV Y,#$0F
CODE_0C00:
	MOV A,DATA_0F79+X
	CALL CODE_06FC
	INC X
	MOV A,Y
	CLRC
	ADC A,#$10
	MOV Y,A
	BPL CODE_0C00
	MOV X,$44
	RET

;--------------------------------------------------------------------

CODE_0C11:
	MOV $4D,A
	MOV Y,#$7D
	MOV !REGISTER_SPC700_DSPRegisterIndex,Y
	MOV A,!REGISTER_SPC700_ReadWriteToDSPRegister
	CMP A,$4D
	BEQ CODE_0C4A
	AND A,#$0F
	EOR A,#$FF
	BBC7 $4C,CODE_0C29
	CLRC
	ADC A,$4C
CODE_0C29:
	MOV $4C,A
	MOV Y,#$04
CODE_0C2D:
	MOV A,DATA_0F98+Y
	MOV !REGISTER_SPC700_DSPRegisterIndex,A
	MOV A,#$00
	MOV !REGISTER_SPC700_ReadWriteToDSPRegister,A
	DBNZ Y,CODE_0C2D
	MOV A,$48
	OR A,#$20
	MOV Y,#$6C
	CALL CODE_06FC
	MOV A,$4D
	MOV Y,#$7D
	CALL CODE_06FC
CODE_0C4A:
	ASL A
	ASL A
	ASL A
	EOR A,#$FF
	SETC
	ADC A,#$3C
	MOV Y,#$6D
	JMP CODE_06FC

;--------------------------------------------------------------------

CODE_0C57:
	MOV $5F,A
	RET

;--------------------------------------------------------------------

CODE_0C5A:
	PUSH A
	MOV A,$47
	AND A,$1A
	POP A
	BEQ CODE_0C88
	MOV $10,#$02
	BRA CODE_0C7A

CODE_0C67:
	MOV A,$A0+X
	BNE CODE_0CAF
	MOV A,($30+X)
	CMP A,#$F9
	BNE CODE_0CAF
	MOV A,$47
	AND A,$1A
	BEQ CODE_0C82
	MOV $10,#$04
CODE_0C7A:
	CALL CODE_0A1A
	DBNZ $10,CODE_0C7A
	BRA CODE_0CAF

CODE_0C82:
	CALL CODE_0A1A
	CALL CODE_0A18
CODE_0C88:
	MOV $A1+X,A
	CALL CODE_0A18
	MOV $A0+X,A
	CALL CODE_0A18
	CLRC
	ADC A,$50
	ADC A,$02F0+X
CODE_0C98:
	AND A,#$7F
	MOV $0380+X,A
	SETC
	SBC A,$0361+X
	MOV Y,$A0+X
	PUSH Y
	POP X
	CALL CODE_0CBB
	MOV $0370+X,A
	MOV A,Y
	MOV $0371+X,A
CODE_0CAF:
	RET

;--------------------------------------------------------------------

CODE_0CB0:
	MOV A,$0361+X
	MOV $11,A
	MOV A,$0360+X
	MOV $10,A
	RET

;--------------------------------------------------------------------

CODE_0CBB:
	NOTC
	ROR $12
	BPL CODE_0CC3
	EOR A,#$FF
	INC A
CODE_0CC3:
	MOV Y,#$00
	DIV YA,X
	PUSH A
	MOV A,#$00
	DIV YA,X
	POP Y
	MOV X,$44
CODE_0CCD:
	BBC7 $12,CODE_0CD6
	MOVW $14,YA
	MOVW YA,$0E
	SUBW YA,$14
CODE_0CD6:
	RET

;--------------------------------------------------------------------

DATA_0CD7:
	dw CODE_0A22
	dw CODE_0A7B
	dw CODE_0A89
	dw CODE_0AA2
	dw CODE_0AAE
	dw CODE_0AC9
	dw CODE_0AD8
	dw CODE_0AEA
	dw CODE_0AF3
	dw CODE_0B08
	dw CODE_0B0B
	dw CODE_0B1D
	dw CODE_0B29
	dw CODE_0B5A
	dw CODE_0B63
	dw CODE_0B8E
	dw CODE_0AB9
	dw CODE_0B2C
	dw CODE_0B30
	dw CODE_0B53
	dw CODE_0B7C
	dw CODE_0BB1
	dw CODE_0BE8
	dw CODE_0BEF
	dw CODE_0BC7
	dw CODE_0C5A
	dw CODE_0C57

DATA_0D0D:
	db $01,$01,$02,$03,$00,$01,$02,$01
	db $02,$01,$01,$03,$00,$01,$02,$03
	db $01,$03,$03,$00,$01,$03,$00,$03
	db $03,$03,$01

;--------------------------------------------------------------------

CODE_0D28:
	MOV A,$90+X
	BEQ CODE_0D35
	MOV A,#$00
	MOV Y,#$03
	DEC $90+X
	CALL CODE_0DBE
CODE_0D35:
	MOV Y,$C1+X
	BEQ CODE_0D5C
	MOV A,$02E0+X
	CBNE $C0+X,CODE_0D5A
	OR $5E,$47
	MOV A,$02D0+X
	BPL CODE_0D4E
	INC Y
	BNE CODE_0D4E
	MOV A,#$80
	BRA CODE_0D52

CODE_0D4E:
	CLRC
	ADC A,$02D1+X
CODE_0D52:
	MOV $02D0+X,A
	CALL CODE_0F47
	BRA CODE_0D61

CODE_0D5A:
	INC $C0+X
CODE_0D5C:
	MOV A,#$FF
	CALL CODE_0F52
CODE_0D61:
	MOV A,$91+X
	BEQ CODE_0D6E
	MOV A,#$30
	MOV Y,#$03
	DEC $91+X
	CALL CODE_0DBE
CODE_0D6E:
	MOV A,$47
	AND A,$5E
	BEQ CODE_0DBD
	MOV A,$0331+X
	MOV Y,A
	MOV A,$0330+X
	MOVW $10,YA
CODE_0D7D:
	MOV A,X
	XCN A
	LSR A
	MOV $12,A
CODE_0D82:
	MOV Y,$11
	MOV A,DATA_0F64+$01+Y
	SETC
	SBC A,DATA_0F64+Y
	MOV Y,$10
	MUL YA
	MOV A,Y
	MOV Y,$11
	CLRC
	ADC A,DATA_0F64+Y
	MOV Y,A
	MOV $0250+X,A
	MOV A,$0321+X
	MUL YA
	MOV A,$0351+X
	ASL A
	BBC0 $12,CODE_0DA5
	ASL A
CODE_0DA5:
	MOV A,Y
	BCC CODE_0DAB
	EOR A,#$FF
	INC A
CODE_0DAB:
	MOV Y,$12
	CALL CODE_06F4
	MOV Y,#$14
	MOV A,#$00
	SUBW YA,$10
	MOVW $10,YA
	INC $12
	BBC1 $12,CODE_0D82
CODE_0DBD:
	RET

;--------------------------------------------------------------------

CODE_0DBE:
	OR $5E,$47
CODE_0DC1:
	MOVW $14,YA
	MOVW $16,YA
	PUSH X
	POP Y
	CLRC
	BNE CODE_0DD4
	ADC $16,#$1F
	MOV A,#$00
	MOV ($14)+Y,A
	INC Y
	BRA CODE_0DDD

CODE_0DD4:
	ADC $16,#$10
	CALL CODE_0DDB
	INC Y
CODE_0DDB:
	MOV A,($14)+Y
CODE_0DDD:
	ADC A,($16)+Y
	MOV ($14)+Y,A
	RET

;--------------------------------------------------------------------

CODE_0DE2:
	MOV A,$71+X
	BEQ CODE_0E4B
	DEC $71+X
	BEQ CODE_0DEF
	MOV A,#$02
	CBNE $70+X,CODE_0E4B
CODE_0DEF:
	MOV A,$80+X
	MOV $17,A
	MOV A,$30+X
	MOV Y,$31+X
CODE_0DF7:
	MOVW $14,YA
	MOV Y,#$00
CODE_0DFB:
	MOV A,($14)+Y
	BEQ CODE_0E1D
	BMI CODE_0E08
CODE_0E01:
	INC Y
	BMI CODE_0E44
	MOV A,($14)+Y
	BPL CODE_0E01
CODE_0E08:
	CMP A,#$C8
	BEQ CODE_0E4B
	CMP A,#$EF
	BEQ CODE_0E39
	CMP A,#$E0
	BCC CODE_0E44
	PUSH Y
	MOV Y,A
	POP A
	ADC A,$0C2D+Y
	MOV Y,A
	BRA CODE_0DFB

CODE_0E1D:
	MOV A,$17
	BEQ CODE_0E44
	DEC $17
	BNE CODE_0E2F
	MOV A,$0231+X
	PUSH A
	MOV A,$0230+X
	POP Y
	BRA CODE_0DF7

CODE_0E2F:
	MOV A,$0241+X
	PUSH A
	MOV A,$0240+X
	POP Y
	BRA CODE_0DF7

CODE_0E39:
	INC Y
	MOV A,($14)+Y
	PUSH A
	INC Y
	MOV A,($14)+Y
	MOV Y,A
	POP A
	BRA CODE_0DF7

CODE_0E44:
	MOV A,$47
	MOV Y,#$5C
	CALL CODE_06F4
CODE_0E4B:
	CLR7 $13
	MOV A,$A0+X
	BEQ CODE_0E6A
	MOV A,$A1+X
	BEQ CODE_0E59
	DEC $A1+X
	BRA CODE_0E6A

CODE_0E59:
	MOV A,$1A
	AND A,$47
	BNE CODE_0E6A
	SET7 $13
	MOV A,#$60
	MOV Y,#$03
	DEC $A0+X
	CALL CODE_0DC1
CODE_0E6A:
	CALL CODE_0CB0
	MOV A,$B1+X
	BEQ CODE_0EBD
	MOV A,$02B0+X
	CBNE $B0+X,CODE_0EBB
	MOV A,$0100+X
	CMP A,$02B1+X
	BNE CODE_0E84
	MOV A,$02C1+X
	BRA CODE_0E91

CODE_0E84:
	SETP
	INC $00+X
	CLRP
	MOV Y,A
	BEQ CODE_0E8D
	MOV A,$B1+X
CODE_0E8D:
	CLRC
	ADC A,$02C0+X
CODE_0E91:
	MOV $B1+X,A
	MOV A,$02A0+X
	CLRC
	ADC A,$02A1+X
	MOV $02A0+X,A
CODE_0E9D:
	MOV $12,A
	ASL A
	ASL A
	BCC CODE_0EA5
	EOR A,#$FF
CODE_0EA5:
	MOV Y,A
	MOV A,$B1+X
	CMP A,#$F1
	BCC CODE_0EB1
	AND A,#$0F
	MUL YA
	BRA CODE_0EB5

CODE_0EB1:
	MUL YA
	MOV A,Y
	MOV Y,#$00
CODE_0EB5:
	CALL CODE_0F32
CODE_0EB8:
	JMP CODE_0671

CODE_0EBB:
	INC $B0+X
CODE_0EBD:
	BBS7 $13,CODE_0EB8
	RET

;--------------------------------------------------------------------

CODE_0EC1:
	CLR7 $13
	MOV A,$C1+X
	BEQ CODE_0ED0
	MOV A,$02E0+X
	CBNE $C0+X,CODE_0ED0
	CALL CODE_0F3A
CODE_0ED0:
	MOV A,$0331+X
	MOV Y,A
	MOV A,$0330+X
	MOVW $10,YA
	MOV A,$91+X
	BEQ CODE_0EE7
	MOV A,$0341+X
	MOV Y,A
	MOV A,$0340+X
	CALL CODE_0F1C
CODE_0EE7:
	BBC7 $13,CODE_0EED
	CALL CODE_0D7D
CODE_0EED:
	CLR7 $13
	CALL CODE_0CB0
	MOV A,$A0+X
	BEQ CODE_0F04
	MOV A,$A1+X
	BNE CODE_0F04
	MOV A,$0371+X
	MOV Y,A
	MOV A,$0370+X
	CALL CODE_0F1C
CODE_0F04:
	MOV A,$B1+X
	BEQ CODE_0EBD
	MOV A,$02B0+X
	CBNE $B0+X,CODE_0EBD
	MOV Y,$51
	MOV A,$02A1+X
	MUL YA
	MOV A,Y
	CLRC
	ADC A,$02A0+X
	JMP CODE_0E9D

;--------------------------------------------------------------------

CODE_0F1C:
	SET7 $13
	MOV $12,Y
	CALL CODE_0CCD
	PUSH Y
	MOV Y,$51
	MUL YA
	MOV $14,Y
	MOV $15,#$00
	MOV Y,$51
	POP A
	MUL YA
	ADDW YA,$14
CODE_0F32:
	CALL CODE_0CCD
	ADDW YA,$10
	MOVW $10,YA
	RET

;--------------------------------------------------------------------

CODE_0F3A:
	SET7 $13
	MOV Y,$51
	MOV A,$02D1+X
	MUL YA
	MOV A,Y
	CLRC
	ADC A,$02D0+X
CODE_0F47:
	ASL A
	BCC CODE_0F4C
	EOR A,#$FF
CODE_0F4C:
	MOV Y,$C1+X
	MUL YA
	MOV A,Y
	EOR A,#$FF
CODE_0F52:
	MOV Y,$59
	MUL YA
	MOV A,$0210+X
	MUL YA
	MOV A,$0301+X
	MUL YA
	MOV A,Y
	MUL YA
	MOV A,Y
	MOV $0321+X,A
	RET

;--------------------------------------------------------------------

DATA_0F64:
	db $00,$01,$03,$07,$0D,$15,$1E,$29
	db $34,$42,$51,$5E,$67,$6E,$73,$77
	db $7A,$7C,$7D,$7E,$7F

DATA_0F79:
	db $7F,$00,$00,$00,$00,$00,$00,$00
	db $58,$BF,$DB,$F0,$FE,$07,$0C,$0C
	db $0C,$21,$2B,$2B,$13,$FE,$F3,$F9
	db $34,$33,$00,$D9,$E5,$01,$FC

DATA_0F98:
	db $EB,$2C,$3C,$0D,$4D,$6C,$4C,$5C
	db $3D,$2D

DATA_0FA2:
	db $5C,$61,$63,$4E,$4A,$48,$45,$0E
	db $49,$4B,$46

DATA_0FAD:
	db $5F,$08,$DE,$08
	db $65,$09,$F4,$09
	db $8C,$0A,$2C,$0B
	db $D6,$0B,$8B,$0C
	db $4A,$0D,$14,$0E
	db $EA,$0E,$CD,$0F
	db $BE,$10,$2A,$56
	db $65,$72,$20,$53
	db $31,$2E,$32,$30
	db $2A

;--------------------------------------------------------------------

CODE_0FD2:
	MOV A,#$AA
	MOV !REGISTER_SPC700_APUPort0,A
	MOV A,#$BB
	MOV !REGISTER_SPC700_APUPort1,A
CODE_0FDC:
	MOV A,!REGISTER_SPC700_APUPort0
	CMP A,#$CC
	BNE CODE_0FDC
	BRA CODE_1005

CODE_0FE5:
	MOV Y,!REGISTER_SPC700_APUPort0
	BNE CODE_0FE5
CODE_0FEA:
	CMP Y,!REGISTER_SPC700_APUPort0
	BNE CODE_0FFE
	MOV A,!REGISTER_SPC700_APUPort1
	MOV !REGISTER_SPC700_APUPort0,Y
	MOV ($14)+Y,A
	INC Y
	BNE CODE_0FEA
	INC $15
	BRA CODE_0FEA

CODE_0FFE:
	BPL CODE_0FEA
	CMP Y,!REGISTER_SPC700_APUPort0
	BPL CODE_0FEA
CODE_1005:
	MOV A,!REGISTER_SPC700_APUPort2
	MOV Y,!REGISTER_SPC700_APUPort3
	MOVW $14,YA
	MOV Y,!REGISTER_SPC700_APUPort0
	MOV A,!REGISTER_SPC700_APUPort1
	MOV !REGISTER_SPC700_APUPort0,Y
	BNE CODE_0FE5
	MOV X,#$31
	MOV !REGISTER_SPC700_ControlRegister,X
	RET

;--------------------------------------------------------------------

CODE_101E:
	MOV A,#$0A
	MOV $03C8,A
	MOV A,$53
	CALL CODE_0AEA
	MOV A,#$1D
	MOV $03,A
	BRA CODE_1067

CODE_102E:
	MOV A,$00
	BEQ CODE_1038
	MOV $D2,A
	AND A,#$7F
	MOV $00,A
CODE_1038:
	CMP $00,#$43
	BEQ CODE_1051
	CMP $00,#$12
	BEQ CODE_1051
	CMP $00,#$11
	BEQ CODE_1051
	CMP $04,#$11
	BEQ CODE_105A
	CMP $04,#$1D
	BEQ CODE_105A
CODE_1051:
	CMP $00,#$7F
	BEQ CODE_101E
	MOV A,$00
	BNE CODE_1067
CODE_105A:
	MOV A,$000C
	BNE CODE_10A8
	MOV A,$04
	BNE CODE_1064
CODE_1063:
	RET

CODE_1064:
	JMP CODE_1103

CODE_1067:
	MOV $04,A
	MOV A,$03F8
	BEQ CODE_1079
	MOV A,$04
	CMP A,#$12
	BNE CODE_1079
	MOV A,#$00
	MOV $03F8,A
CODE_1079:
	MOV A,#$02
	MOV $000C,A
	MOV A,#$10
	MOV Y,#$5C
	CALL CODE_06FC
	SET4 $1A
	MOV A,#$00
	MOV $0288,A
	MOV $A8,A
	MOV $0389,A
	MOV $02F8,A
	CMP $04,#$3B
	BEQ CODE_109E
	CMP $04,#$43
	BNE CODE_10A7
CODE_109E:
	CLR4 $4A
	MOV A,$4A
	MOV Y,#$4D
	CALL CODE_06FC
CODE_10A7:
	RET

CODE_10A8:
	DEC $000C
	BNE CODE_1063
CODE_10AD:
	MOV A,$04
	ASL A
	MOV Y,A
	MOV A,DATA_17D8-$02+Y
	MOV $2C,A
	MOV A,DATA_17D8-$01+Y
	MOV $2D,A
	BRA CODE_110A

CODE_10BD:
	CMP $04,#$11
	BNE CODE_10CC
	MOV A,#$FF
	MOV $03F8,A
	MOV Y,#$5C
	CALL CODE_06FC
CODE_10CC:
	MOV $04,#$00
	MOV $D2,#$00
	CLR4 $1A
	MOV A,$03C3
	AND A,#$10
	BEQ CODE_10E4
	SET4 $4A
	MOV A,$4A
	MOV Y,#$4D
	CALL CODE_06FC
CODE_10E4:
	MOV A,#$00
	MOV $A8,A
	MOV A,$03A9
	MOV $02F8,A
	MOV A,$03E8
	MOV $0389,A
	MOV A,$03E9
	MOV $0288,A
	MOV X,#$08
	MOV A,$0219
	JMP CODE_0A22

CODE_1102:
	RET

CODE_1103:
	DEC $002E
	BNE CODE_1160
CODE_1108:
	INCW $2C
CODE_110A:
	MOV X,#$00
	MOV A,($2C+X)
	BEQ CODE_10BD
	BMI CODE_113C
	MOV $002F,A
	INCW $2C
	MOV A,($2C+X)
	MOV $10,A
	BMI CODE_113C
	MOV Y,#$40
	CALL CODE_06FC
	INCW $2C
	MOV A,($2C+X)
	BPL CODE_1133
	MOV X,A
	MOV A,$10
	MOV Y,#$41
	CALL CODE_06FC
	MOV A,X
	BRA CODE_113C

CODE_1133:
	MOV Y,#$41
	CALL CODE_06FC
	INCW $2C
	MOV A,($2C+X)
CODE_113C:
	CMP A,#$E0
	BEQ CODE_11AE
	CMP A,#$F9
	BEQ CODE_117C
	CMP A,#$F1
	BEQ CODE_1190
	CMP A,#$FF
	BNE CODE_114F
	JMP CODE_10AD

CODE_114F:
	MOV X,#$08
	MOV Y,A
	CALL CODE_0607
	MOV A,#$10
	CALL CODE_1372
CODE_115A:
	MOV A,$002F
	MOV $002E,A
CODE_1160:
	CLR7 $13
	MOV X,#$08
	MOV A,$A0+X
	BEQ CODE_116D
	CALL CODE_14A9
	BRA CODE_117B

CODE_116D:
	MOV A,#$02
	CMP A,$002E
	BNE CODE_117B
	MOV A,#$10
	MOV Y,#$5C
	CALL CODE_06FC
CODE_117B:
	RET

CODE_117C:
	MOV X,#$00
	INCW $2C
	MOV A,($2C+X)
	MOV $44,#$08
	MOV X,#$08
	MOV Y,A
	CALL CODE_0607
	MOV A,#$10
	CALL CODE_1372
CODE_1190:
	MOV X,#$00
	INCW $2C
	MOV A,($2C+X)
	MOV $A9,A
	INCW $2C
	MOV A,($2C+X)
	MOV $A8,A
	PUSH A
	INCW $2C
	MOV A,($2C+X)
	POP Y
	MOV $44,#$08
	MOV X,#$08
	CALL CODE_0C98
	BRA CODE_115A

CODE_11AE:
	MOV X,#$00
	INCW $2C
	MOV A,($2C+X)
	MOV Y,#$09
	MUL YA
	MOV X,A
	MOV Y,#$40
	MOV $12,#$08
CODE_11BD:
	MOV A,SFXInstrumentTable+X
	CALL CODE_06FC
	INC X
	INC Y
	DBNZ $12,CODE_11BD
	MOV A,SFXInstrumentTable+X
	MOV $0229,A
	MOV A,#$00
	MOV $0228,A
	JMP CODE_1108

;--------------------------------------------------------------------

CODE_11D6:
	MOV A,$03
	BEQ CODE_11E0
	MOV $D5,A
	AND A,#$7F
	MOV $03,A
CODE_11E0:
	CMP $07,#$1D
	BEQ CODE_11F3
	CMP $03,#$05
	BEQ CODE_11EF
	CMP $07,#$05
	BEQ CODE_11F3
CODE_11EF:
	MOV A,$03
	BNE CODE_11FC
CODE_11F3:
	MOV A,$23
	BNE CODE_1218
	MOV A,$07
	BNE CODE_125B
CODE_11FB:
	RET

CODE_11FC:
	MOV $07,A
	MOV $23,#$02
	MOV A,#$40
	MOV Y,#$5C
	CALL CODE_06FC
	SET6 $1A
	MOV A,#$00
	MOV $028C,A
	MOV $AC,A
	MOV $038D,A
	MOV $02FC,A
	RET

CODE_1218:
	DBNZ $23,CODE_11FB
	MOV A,$07
	ASL A
	MOV Y,A
	MOV A,DATA_173C-$02+Y
	MOV $D0,A
	MOV A,DATA_173C-$01+Y
	MOV $D1,A
	BRA CODE_1262

CODE_122B:
	MOV $07,#$00
	MOV $D5,#$00
	CLR6 $1A
	MOV A,#$00
	MOV $49,A
	MOV Y,#$3D
	CALL CODE_06FC
	MOV A,#$00
	MOV $AC,A
	MOV A,$03AD
	MOV $02FC,A
	MOV A,$03EC
	MOV $038D,A
	MOV A,$03ED
	MOV $028C,A
	MOV X,#$0C
	MOV A,$021D
	JMP CODE_0A22

CODE_125A:
	RET

CODE_125B:
	DEC $03D1
	BNE CODE_12B9
CODE_1260:
	INCW $D0
CODE_1262:
	MOV X,#$00
	MOV A,($D0+X)
	BEQ CODE_122B
	BMI CODE_1294
	MOV $03D3,A
	INCW $D0
	MOV A,($D0+X)
	MOV $10,A
	BMI CODE_1294
	MOV Y,#$60
	CALL CODE_06FC
	INCW $D0
	MOV A,($D0+X)
	BPL CODE_128B
	MOV X,A
	MOV A,$10
	MOV Y,#$61
	CALL CODE_06FC
	MOV A,X
	BRA CODE_1294

CODE_128B:
	MOV Y,#$61
	CALL CODE_06FC
	INCW $D0
	MOV A,($D0+X)
CODE_1294:
	CMP A,#$E0
	BEQ CODE_1307
	CMP A,#$F9
	BEQ CODE_12D5
	CMP A,#$F1
	BEQ CODE_12E9
	CMP A,#$FF
	BNE CODE_12A8
	DECW $D0
	BRA CODE_1262

CODE_12A8:
	MOV X,#$0C
	MOV Y,A
	CALL CODE_0607
	MOV A,#$40
	CALL CODE_1372
CODE_12B3:
	MOV A,$03D3
	MOV $03D1,A
CODE_12B9:
	CLR7 $13
	MOV X,#$0C
	MOV A,$A0+X
	BEQ CODE_12C6
	CALL CODE_14A9
	BRA CODE_12D4

CODE_12C6:
	MOV A,#$02
	CMP A,$03D1
	BNE CODE_12D4
	MOV A,#$40
	MOV Y,#$5C
	CALL CODE_06FC
CODE_12D4:
	RET

CODE_12D5:
	MOV X,#$00
	INCW $D0
	MOV A,($D0+X)
	MOV $44,#$0C
	MOV X,#$0C
	MOV Y,A
	CALL CODE_0607
	MOV A,#$40
	CALL CODE_1372
CODE_12E9:
	MOV X,#$00
	INCW $D0
	MOV A,($D0+X)
	MOV $AD,A
	INCW $D0
	MOV A,($D0+X)
	MOV $AC,A
	PUSH A
	INCW $D0
	MOV A,($D0+X)
	POP Y
	MOV $44,#$0C
	MOV X,#$0C
	CALL CODE_0C98
	BRA CODE_12B3

CODE_1307:
	MOV A,#$00
	MOV $49,A
	MOV Y,#$3D
	CALL CODE_06FC
CODE_1310:
	MOV X,#$00
	INCW $D0
	MOV A,($D0+X)
	BMI CODE_133A
	MOV Y,#$09
	MUL YA
	MOV X,A
	MOV Y,#$60
	MOV $12,#$08
CODE_1321:
	MOV A,SFXInstrumentTable+X
	CALL CODE_06FC
	INC X
	INC Y
	DBNZ $12,CODE_1321
	MOV A,SFXInstrumentTable+X
	MOV $022D,A
	MOV A,#$00
	MOV $022C,A
	JMP CODE_1260

CODE_133A:
	AND A,#$1F
	AND $48,#$20
	TSET $0048,A
	MOV Y,#$6C
	CALL CODE_06FC
	MOV A,#$40
	MOV $49,A
	MOV Y,#$3D
	CALL CODE_06FC
	BRA CODE_1310

;--------------------------------------------------------------------

CODE_1352:
	MOV Y,#$09
	MUL YA
	MOV X,A
	MOV Y,#$50
	MOV $12,#$08
CODE_135B:
	MOV A,SFXInstrumentTable+X
	CALL CODE_06FC
	INC X
	INC Y
	DBNZ $12,CODE_135B
	MOV A,SFXInstrumentTable+X
	MOV $022B,A
	MOV A,#$00
	MOV $022A,A
	RET

;--------------------------------------------------------------------

CODE_1372:
	PUSH A
	MOV Y,#$5C
	MOV A,#$00
	CALL CODE_06FC
	POP A
	MOV Y,#$4C
	JMP CODE_06FC

;--------------------------------------------------------------------

CODE_1380:
	MOV X,A
	MOV Y,#$06
	MUL YA
	MOV X,A
	MOV Y,#$54
	MOV $12,#$04
CODE_138A:
	MOV A,DATA_13A3+X
	CALL CODE_06FC
	INC X
	INC Y
	DBNZ $12,CODE_138A
	MOV A,DATA_13A3+X
	MOV $022B,A
	INC X
	MOV A,DATA_13A3+X
	MOV $022A,A
	RET

DATA_13A3:
	db $20,$00,$00,$E8,$04,$00

;--------------------------------------------------------------------

CODE_13A9:						; Note: Something to do with the turn off wind sound.
	MOV A,#$20
	MOV Y,#$5C
	CALL CODE_06FC
	MOV A,$03C3
	AND A,#$20
	BEQ CODE_13BE
	SET5 $4A
	MOV Y,#$4D
	CALL CODE_06FC
CODE_13BE:
	MOV $26,#$00
	CLR5 $1A
	MOV X,#$0A
	MOV A,$021B
	CALL CODE_0A22
	MOV A,#$00
	MOV $27,A
	MOV $AA,A
	MOV A,$03EA
	MOV $038B,A
	MOV A,$03EB
	MOV $028A,A
	MOV A,$03AB
	MOV $02FA,A
	RET

;--------------------------------------------------------------------

CODE_13E4:
	MOV A,$25
	CMP A,#$10
	BEQ CODE_13F9
	CMP A,#$20
	BEQ CODE_13A9
	MOV A,$27
	BNE CODE_1417
	MOV A,$26
	CMP A,#$10
	BEQ CODE_1440
	RET

CODE_13F9:						; Note: Something to do with the activate wind sound.
	MOV $26,A
	MOV A,#$03
	MOV $0027,A
	MOV A,#$20
	MOV Y,#$5C
	CALL CODE_06FC
	SET5 $1A
	MOV A,#$00
	MOV $028A,A
	MOV $AA,A
	MOV $038B,A
	MOV $02FA,A
CODE_1416:
	RET

CODE_1417:
	DEC $0027
	BNE CODE_1416
	MOV A,#$00
	CALL CODE_1380
	MOV A,#$20
	CALL CODE_1372
	CLR5 $4A
	MOV A,$4A
	MOV Y,#$4D
	CALL CODE_06FC
	MOV A,#$01
	MOV $AA,A
	MOV $AB,#$00
	MOV A,#$A4
	MOV X,#$0A
	MOV $44,X
	CALL CODE_0C98
	RET

CODE_1440:
	CLR7 $13
	MOV A,$AA
	BEQ CODE_1465
	MOV X,#$0A
	CALL CODE_14A9
	MOV A,$03F1
	BEQ CODE_1454
	MOV A,#$0A
	BRA CODE_1456

CODE_1454:
	MOV A,#$18
CODE_1456:
	MOV $10,A
	MOV Y,#$50
	CALL CODE_06FC
	MOV $10,A
	MOV Y,#$51
	CALL CODE_06FC
	RET

CODE_1465:
	MOV A,#$80
	MOV $AA,A
	MOV $AB,#$00
	MOV A,$18
	AND A,#$03
	OR A,#$A4
	MOV X,#$0A
	MOV $44,X
	CALL CODE_0C98
	RET

;--------------------------------------------------------------------

CODE_147A:
	MOV A,#$00
	MOV Y,#$2C
	CALL CODE_06FC
	MOV Y,#$3C
	CALL CODE_06FC
	MOV A,#$FF
	MOV Y,#$5C
	CALL CODE_06FC
	MOV A,#$00
	MOV $03CA,A
	MOV $04,A
	MOV $05,A
	MOV $06,A
	MOV $07,A
	MOV $26,A
	MOV $1A,A
	MOV $03C8,A
	MOV A,#$80
	MOV !REGISTER_SPC700_ControlRegister,A
	JMP !REGISTER_SPC700_IPLROMLoc

;--------------------------------------------------------------------

CODE_14A9:
	MOV A,#$60
	MOV Y,#$03
	DEC $A0+X
	CALL CODE_0DC1
	MOV A,$0361+X
	MOV Y,A
	MOV A,$0360+X
	MOVW $10,YA
	MOV $47,#$00
	JMP CODE_0671

;--------------------------------------------------------------------

CODE_14C1:
	MOV A,$01
	CMP A,#$FF
	BNE CODE_14CA
	JMP CODE_0768

CODE_14CA:
	CMP A,#$F0
	BNE CODE_14D1
	JMP CODE_147A

CODE_14D1:
	MOV A,$01
	AND A,#$F0
	MOV $25,A
	MOV A,$01
	AND A,#$0F
	MOV $01,A
	CMP A,#$01
	BEQ CODE_14FE
	MOV A,$05
	CMP A,#$01
	BEQ CODE_14ED
	MOV A,$01
	CMP A,#$04
	BEQ CODE_14F8
CODE_14ED:
	MOV A,$05
	CMP A,#$01
	BEQ CODE_153F
	CMP A,#$04
	BEQ CODE_14FB
	RET

CODE_14F8:
	JMP CODE_15D6

CODE_14FB:
	JMP CODE_1605

CODE_14FE:					; Note: Something related to the jump sound.
	MOV $05,A
	MOV A,#$04
	MOV $03C6,A
	MOV A,#$80
	MOV Y,#$5C
	CALL CODE_06FC
	SET7 $1A
	MOV A,#$00
	MOV $028E,A
	MOV $AE,A
	MOV $038F,A
	MOV $02FE,A
CODE_151B:
	RET

;--------------------------------------------------------------------

CODE_151C:
	DEC $03C6
	BNE CODE_151B
	MOV $20,#$30
	BRA CODE_156B

CODE_1526:
	CMP $20,#$2A
	BNE CODE_159C
	MOV $44,#$0E
	MOV X,#$0E
	MOV Y,#$00
	MOV $AF,Y
	MOV Y,#$12
	MOV $AE,Y
	MOV A,#$B9
	CALL CODE_0C98
	BRA CODE_159C

CODE_153F:
	MOV A,$03C6
	BNE CODE_151C
	DBNZ $20,CODE_1526
	MOV $05,#$00
	CLR7 $1A
	MOV A,#$00
	MOV $AE,A
	MOV A,$03AF
	MOV $02FE,A
	MOV A,$03EE
	MOV $038F,A
	MOV A,$03EF
	MOV $028E,A
	MOV X,#$0E
	MOV A,$021F
	JMP CODE_0A22

CODE_156A:
	RET

CODE_156B:
	CALL CODE_15B4
	MOV Y,#$B2
	MOV $44,#$0E
	MOV X,#$0E
	CALL CODE_0607
	MOV Y,#$00
	MOV $AF,Y
	MOV Y,#$05
	MOV $AE,Y
	MOV A,#$B5
	CALL CODE_0C98
	MOV A,#$38
	MOV $10,A
	MOV Y,#$70
	CALL CODE_06FC
	MOV A,#$38
	MOV $10,A
	MOV Y,#$71
	CALL CODE_06FC
	MOV A,#$80
	CALL CODE_1372
CODE_159C:
	MOV A,#$02
	CBNE $20,CODE_15A8
	MOV A,#$80
	MOV Y,#$5C
	CALL CODE_06FC
CODE_15A8:
	CLR7 $13
	MOV A,$AE
	BEQ CODE_15B3
	MOV X,#$0E
	CALL CODE_14A9
CODE_15B3:
	RET

;--------------------------------------------------------------------

CODE_15B4:
	MOV A,#$08
CODE_15B6:
	MOV Y,#$09
	MUL YA
	MOV X,A
	MOV Y,#$70
	MOV $12,#$08
CODE_15BF:
	MOV A,SFXInstrumentTable+X
	CALL CODE_06FC
	INC X
	INC Y
	DBNZ $12,CODE_15BF
	MOV A,SFXInstrumentTable+X
	MOV $022F,A
	MOV A,#$00
	MOV $022E,A
	RET

;--------------------------------------------------------------------

CODE_15D6:
	MOV $05,A
	MOV A,#$02
	MOV $03C6,A
	MOV A,#$80
	MOV Y,#$5C
	CALL CODE_06FC
	SET7 $1A
	MOV A,#$00
	MOV $028E,A
	MOV $AE,A
	MOV $038F,A
	MOV $02FE,A
CODE_15F3:
	RET

;--------------------------------------------------------------------

CODE_15F4:
	DEC $03C6
	BNE CODE_15F3
	MOV $22,#$05
	MOV $20,#$01
	MOV A,#$01
	CALL CODE_15B6
	RET

CODE_1605:
	MOV A,$03C6
	BNE CODE_15F4
	DBNZ $20,CODE_165C
	MOV $20,#$04
	DEC $22
	BEQ CODE_1624
	MOV X,$22
	MOV A,DATA_1669+X
	MOV Y,A
	MOV $44,#$0E
	MOV X,#$0E
	CALL CODE_0607
	BRA CODE_1647

CODE_1624:
	MOV $05,#$00
	CLR7 $1A
	MOV A,#$00
	MOV $AE,A
	MOV A,$03AF
	MOV $02FE,A
	MOV A,$03EE
	MOV $038F,A
	MOV A,$03EF
	MOV $028E,A
	MOV X,#$0E
	MOV A,$021F
	JMP CODE_0A22

CODE_1647:
	MOV A,#$14
	MOV $10,A
	MOV Y,#$70
	CALL CODE_06FC
	MOV A,$10
	MOV Y,#$71
	CALL CODE_06FC
	MOV A,#$80
	CALL CODE_1372
CODE_165C:
	MOV A,#$02
	CBNE $20,CODE_1668
	MOV A,#$80
	MOV Y,#$5C
	CALL CODE_06FC
CODE_1668:
	RET

;--------------------------------------------------------------------

DATA_1669:
	db $B7,$B5,$B8,$B5

SFXInstrumentTable:
;$166D
	db $70,$70,$00,$10,$09,$DF,$E0,$B8,$02
	db $70,$70,$00,$10,$00,$FE,$0A,$B8,$03
	db $70,$70,$00,$10,$04,$FE,$11,$B8,$03
	db $70,$70,$00,$10,$06,$FE,$6A,$B8,$03
	db $70,$70,$00,$10,$00,$FE,$11,$B8,$03
	db $70,$70,$00,$10,$0B,$FE,$6A,$B8,$03
	db $70,$70,$00,$10,$03,$FE,$6A,$B8,$06
	db $70,$70,$00,$10,$09,$FE,$6A,$B8,$05
	db $70,$70,$00,$10,$00,$CA,$D7,$B8,$03
	db $70,$70,$00,$10,$13,$0E,$6A,$7F,$04
	db $70,$70,$00,$10,$0E,$FE,$6A,$B8,$02
	db $70,$70,$00,$10,$0E,$FF,$E0,$B8,$05
	db $70,$70,$00,$10,$11,$FE,$00,$7F,$06
	db $70,$70,$00,$10,$00,$B6,$30,$30,$06
	db $70,$70,$00,$10,$15,$0E,$6A,$70,$03
	db $70,$70,$00,$10,$02,$FA,$6A,$70,$03
	db $70,$70,$00,$10,$03,$FE,$16,$70,$03
	db $70,$70,$00,$10,$16,$0E,$16,$7F,$03
	db $70,$70,$00,$10,$03,$FE,$33,$7F,$03
	db $70,$70,$00,$10,$20,$8A,$E0,$7F,$03
	db $70,$70,$00,$10,$00,$FD,$E0,$00,$03
	db $70,$70,$00,$10,$03,$F4,$F4,$70,$02
	db $70,$70,$00,$10,$14,$FA,$6A,$70,$03

DATA_173C:				; Note: Sound effect table 7E0063
	dw SOUND_Coin			; 01 - Coin
	dw SOUND_HitPrizeBlock		; 02 - Hit Item Block
	dw DATA_2358			; 03 - Hit Vine Block
	dw DATA_24F8			; 04 - Spin Jump
	dw DATA_2464			; 05 - 1up
	dw DATA_22E4			; 06 - Shoot Fireball
	dw DATA_251A			; 07 - Break Block
	dw DATA_2182			; 08 - Springboard
	dw DATA_2571			; 09 - Bullet Shoot (SMAS)
	dw DATA_21FF			; 0A - Egg Hatch
	dw DATA_21EE			; 0B - Put Item In Reserve
	dw DATA_237B			; 0C - Drop Item In Reserve
	dw DATA_237B			; 0D - Drop Item In Reserve (Duplicate)
	dw DATA_21B3			; 0E - L/R Scroll
	dw DATA_2545			; 0F - Door (SMAS)
	dw DATA_2581			; 10 - Door Close (SMAS)
	dw DATA_2591			; 11 - Drumroll Start
	dw DATA_2600			; 12 - Drumroll End
	dw $0000			; 13 - N/A (Lose Yoshi in SMW)
	dw DATA_241A			; 14 - Battle Mode Boo Appears (Unused Sound in SMW)
	dw DATA_20BC			; 15 - Overworld Tile Reveal
	dw DATA_2089			; 16 - Castle Collpse
	dw DATA_2082			; 17 - Fire Spit
	dw DATA_205B			; 18 - Thunder
	dw DATA_204F			; 19 - Clap
	dw DATA_1FFF			; 1A - Explosion
	dw DATA_1FD1			; 1B - TNT Fuse
	dw DATA_1F77			; 1C - Overworld Switch Block Ejection
	dw DATA_224E			; 1D - Running Out of Time
	dw DATA_1F63			; 1E - Chuck Whistle
	dw DATA_1F4E			; 1F - Mount Yoshi
	dw DATA_2006			; 20 - Lemmy Wendy Land In Lava
	dw DATA_233E			; 21 - Yoshi Tongue
	dw DATA_1F3A			; 22 - Message Box
	dw DATA_1F44			; 23 - Step On Level Tile
	dw DATA_1EF5			; 24 - P-Switch Running Out
	dw DATA_1EEB			; 25 - Yoshi Stomps Enemy
	dw DATA_1EC6			; 26 - Swooper
	dw DATA_1EBF			; 27 - Podoboo
	dw DATA_1E72			; 28 - Stun Enemy
	dw DATA_1E5B			; 29 - Correct
	dw DATA_1E53			; 2A - Wrong
	dw $0000			; 2B - N/A (Fireworks Whistle in SMW)
	dw DATA_1DDF			; 2C - Fireworks Bang
	dw DATA_1896			; 2D - Charge Jump (Podoboo Pan1 in SMW)
	dw DATA_1D6E			; 2E - Podoboo Pan2
	dw DATA_1D6E			; 2F - Podoboo Pan3
	dw DATA_1D76			; 30 - Podoboo Pan4
	dw DATA_1D7E			; 31 - Podoboo Pan5
	dw DATA_1D86			; 32 - Podoboo Pan6
	dw DATA_1D8E			; 33 - Podoboo Pan7
	dw DATA_1D96			; 34 - Podoboo Pan8
	dw DATA_1CB1			; 35 - Rumble 
	dw DATA_1BE8			; 36 - Open Box 1
	dw DATA_1BD9			; 37 - Unknown Sound 1
	dw DATA_1BC9			; 38 - Rising Item
	dw DATA_1BBE			; 39 - Got Item Tweet
	dw DATA_1B6E			; 3A - Grab Mystery Mushroom
	dw DATA_1AD2			; 3B - Collect Cherry
	dw DATA_1AC2			; 3C - Pickup Enemy (SMB2U)
	dw DATA_1AB9			; 3D - Unknown Sound 2
	dw DATA_1AA6			; 3E - Open Box 2
	dw DATA_19DB			; 3F - Toggle File Window
	dw DATA_19E3			; 40 - SMAS Menu Fade Out
	dw DATA_1A0A			; 41 - SMAS Menu Fade In
	dw DATA_199E			; 42 - Phanto Droning
	dw DATA_19A4			; 43 - Enter Level
	dw DATA_1A50			; 44 - Unknown Sound 3
	dw DATA_1D08			; 45 - Rocket Takeoff
	dw DATA_1956			; 46 - Wart Roar
	dw DATA_191B			; 47 - Airship Moving
	dw DATA_193D			; 48 - Boomerang
	dw DATA_1946			; 49 - Whale Spout
	dw DATA_18FA			; 4A - Cannon Shoot
	dw DATA_18B2			; 4B - Add Timer To Score
	dw DATA_18B9			; 4C - Finish Adding Timer To Score
	dw DATA_1866			; 4D - Enter Vase
	dw DATA_1877			; 4E - Exit Vase

DATA_17D8:				; Note: Sound effect table 7E0060
	dw DATA_234E			; 01 - Hit Head
	dw DATA_232B			; 02 - Contact
	dw DATA_22EC			; 03 - Kick Shell
	dw DATA_228D			; 04 - Into Pipe
	dw DATA_2274			; 05 - Midway Point
	dw $0000			; 06 - N/A (Yoshi Gulp in SMW)
	dw DATA_23AE			; 07 - Dry Bones Collapse
	dw DATA_215A			; 08 - Spin Jump Kill
	dw DATA_21C8			; 09 - Fly With Cape
	dw DATA_2441			; 0A - Get Powerup
	dw DATA_22CC			; 0B - On/Off Switch
	dw DATA_2497			; 0C - Carry Item To Goal
	dw DATA_23C9			; 0D - Get Cape
	dw DATA_21DE			; 0E - Swim
	dw DATA_24DF			; 0F - Hurt While Flying
	dw DATA_2470			; 10 - Magic Shoot
	dw DATA_21A8			; 11 - Turn Off Music (Pause in SMW)
	dw DATA_21A8			; 12 - Turn On Music (Unpause in SMW)
	dw DATA_22F3			; 13 - Stomp 1
	dw DATA_22FA			; 14 - Stomp 2
	dw DATA_2301			; 15 - Stomp 3
	dw DATA_2308			; 16 - Stomp 4
	dw DATA_230F			; 17 - Stomp 5
	dw DATA_2316			; 18 - Stomp 6
	dw DATA_231D			; 19 - Stomp 7
	dw DATA_2324			; 1A - Stomp 8 (Grinder 1 in SMW)
	dw DATA_214B			; 1B - Grinder 2
	dw DATA_220F			; 1C - Yoshi Coin
	dw DATA_2228			; 1D - Running Out Of Time
	dw DATA_2141			; 1E - P-Balloon
	dw DATA_20D8			; 1F - Koopaling Dead
	dw DATA_20C9			; 20 - Yoshi Spit
	dw DATA_1F9E			; 21 - Valley Of Bowser Appears
	dw DATA_21A8			; 22 - End Of Valley Of Bowser Appears
	dw DATA_1E63			; 23 - Fall into Subcon
	dw DATA_21A8			; 24 - Silence
	dw DATA_1E86			; 25 - Blargg Roar
	dw DATA_1E41			; 26 - Fireworks Whistle
	dw DATA_1E10			; 27 - Fireworks Bang
	dw DATA_1DCF			; 28 - Louder Fireworks Whistle
	dw DATA_1D9E			; 29 - Louder Fireworks Bang
	dw DATA_1D52			; 2A - Peach Popping Out Of Clown Car
	dw DATA_1D42			; 2B - Pickup Item (SMB2U)
	dw DATA_1D2E			; 2C - Hawkmouth Open
	dw DATA_1D38			; 2D - Hawkmouth Close
	dw DATA_1C3B			; 2E - Phanto Shaking
	dw DATA_1D1F			; 2F - Stopwatch Tick
	dw DATA_18F0			; 30 - Climb Vine
	dw DATA_1CA7			; 31 - SMB2U Throw
	dw DATA_1C56			; 32 - Unknown Sound 4
	dw DATA_1C08			; 33 - Hurt (SMB2U)
	dw DATA_1888			; 34 - Kill Enemy (SMB2U)
	dw DATA_1BBE			; 35 - Got Item Tweet
	dw DATA_1BAF			; 36 - Hammer Bro March
	dw DATA_1B9F			; 37 - Enemy Projectile Throw
	dw DATA_1B92			; 38 - Wand Drop
	dw DATA_1B7D			; 39 - Peach Door Open
	dw DATA_1AE4			; 3A - Bowser Breath Fire
	dw DATA_1ADA			; 3B - Save Game
	dw DATA_1A99			; 3C - Choose Character
	dw DATA_1A91			; 3D - Unknown Sound 5
	dw DATA_1A5A			; 3E - Random Chatter
	dw DATA_1A42			; 3F - Unknown Sound 6
	dw DATA_1A38			; 40 - Frog Hop
	dw DATA_1A31			; 41 - Select Card
	dw DATA_1F44			; 42 - Step On Level Tile
	dw DATA_21A9			; 43 - Pause
	dw DATA_21A9			; 44 - Pause (echo)
	dw DATA_205B			; 45 - Thunder
	dw DATA_190C			; 46 - Grab Flagpole
	dw DATA_18C1			; 47 - Coin leaves pipe

DATA_1866:
	db $E0,$02,$03,$46,$9F,$A1,$A4,$9D
	db $9F,$A2,$9B,$9D,$A0,$99,$9B,$9E
	db $00

DATA_1877:
	db $E0,$02,$03,$46,$99,$9B,$9E,$9B
	db $9D,$A0,$9D,$9F,$A2,$9F,$A1,$A4
	db $00

DATA_1888:
	db $E0,$03,$03,$32,$9F,$A0,$A1,$03
	db $46,$9F,$A5,$9B,$AB,$00

DATA_1896:
	db $E0,$02,$03,$32,$A1,$A2,$04,$00
	db $98,$03,$32,$A4,$A5,$04,$00,$98
	db $03,$32,$A7,$A8,$04,$00,$98,$03
	db $32,$AA,$AB,$00

DATA_18B2:
	db $E0,$0F,$04,$50,$BB,$BB,$FF

DATA_18B9:
	db $E0,$0F,$06,$14,$BB,$BE,$C3,$00

DATA_18C1:
	db $E0,$06,$03,$54,$B5,$B4,$B5,$B4
	db $03,$46,$B5,$B4,$03,$38,$B5,$B4
	db $03,$2A,$B5,$B4,$03,$15,$B5,$B4
	db $03,$54,$B5,$B4,$B5,$B4,$03,$46
	db $B5,$B4,$03,$38,$B5,$B4,$03,$2A
	db $B5,$B4,$03,$15,$B5,$B4,$00

DATA_18F0:
	db $E0,$12,$0C,$32,$F9,$A4,$00,$06
	db $A6,$00

DATA_18FA:
	db $E0,$11,$0C,$50,$97,$0C,$50,$A3
	db $06,$3A,$9F,$06,$2C,$9D,$30,$16
	db $9C,$00

DATA_190C:
	db $E0,$0F,$7F,$3C,$F9,$98,$00,$7F
	db $B0,$0F,$F1,$00,$0C,$B2,$00

DATA_191B:
	db $E0,$16,$60,$46,$F9,$93,$00,$60
	db $AF,$0C,$32,$F1,$00,$0C,$AB,$0C
	db $1E,$F1,$00,$0C,$AF,$0C,$14,$F1
	db $00,$0C,$AB,$0C,$0A,$F1,$00,$09
	db $AF,$00

DATA_193D:
	db $E0,$9E,$0F,$04,$0F,$9D,$06,$9D
	db $00

DATA_1946:
	db $E0,$9E,$0F,$7F,$0F,$F9,$9D,$00
	db $7F,$9D,$6F,$F1,$00,$6C,$9D,$00

DATA_1956:
	db $E0,$0E,$04,$32,$9D,$04,$2D,$98
	db $04,$2B,$9F,$04,$28,$A2,$04,$26
	db $A1,$04,$24,$A0,$04,$21,$9F,$04
	db $1E,$9E,$04,$1C,$9D,$04,$1E,$A1
	db $04,$1E,$A0,$04,$1E,$9F,$04,$1E
	db $9E,$04,$1E,$9D,$04,$24,$A0,$04
	db $21,$9F,$04,$1E,$9E,$04,$1C,$9D
	db $04,$1E,$A1,$04,$1A,$A0,$04,$14
	db $9F,$04,$0F,$9E,$04,$0A,$9D,$00

DATA_199E:
	db $E0,$15,$7F,$64,$86,$00

DATA_19A4:
	db $E0,$06,$07,$38,$38,$B9,$07,$3F
	db $31,$B7,$07,$29,$46,$B4,$07,$4D
	db $23,$B1,$07,$38,$38,$AD,$07,$3F
	db $31,$AB,$07,$2A,$46,$A8,$07,$38
	db $38,$A5,$07,$3F,$31,$A1,$07,$29
	db $46,$9F,$07,$4D,$23,$9C,$07,$4D
	db $23,$99,$18,$38,$38,$95,$00

DATA_19DB:
	db $E0,$02,$08,$50,$B4,$B7,$BC,$00

DATA_19E3:
	db $E0,$12,$09,$38,$38,$C0,$09,$3F
	db $31,$BC,$09,$29,$46,$B7,$09,$4D
	db $23,$B5,$09,$38,$38,$B4,$09,$3F
	db $31,$B0,$09,$2A,$46,$AB,$09,$2A
	db $46,$A9,$30,$46,$1C,$A8,$00

DATA_1A0A:
	db $E0,$12,$09,$38,$38,$A8,$09,$3F
	db $31,$A9,$09,$29,$46,$AB,$09,$4D
	db $23,$B0,$09,$38,$38,$B4,$09,$3F
	db $31,$B5,$09,$2A,$46,$B7,$09,$2A
	db $46,$BC,$30,$46,$1C,$C0,$00

DATA_1A31:
	db $E0,$04,$06,$46,$C3,$C5,$00

DATA_1A38:
	db $E0,$05,$0B,$37,$F9,$93,$00,$08
	db $AF,$00

DATA_1A42:
	db $E0,$0A,$06,$54,$98,$06,$00,$8B
	db $E0,$07,$06,$46,$90,$00

DATA_1A50:
	db $E0,$07,$02,$50,$9D,$18,$A4,$04
	db $9C,$00

DATA_1A5A:
	db $E0,$14,$60,$19,$F9,$9D,$00,$60
	db $9D,$60,$F1,$00,$60,$9D,$60,$F1
	db $00,$60,$9D,$60,$F1,$00,$60,$9D
	db $60,$F1,$00,$60,$9D,$60,$F1,$00
	db $60,$9D,$60,$F1,$00,$60,$9D,$60
	db $F1,$00,$60,$9D,$60,$F1,$00,$60
	db $9D,$60,$F1,$00,$5D,$9D,$00

DATA_1A91:
	db $E0,$09,$09,$63,$C3,$18,$C7,$00

DATA_1A99:
	db $E0,$02,$06,$5A,$BC,$B8,$BC,$B8
	db $BC,$18,$5A,$B8,$00

DATA_1AA6:
	db $E0,$07,$09,$5A,$F9,$A4,$00,$06
	db $B7,$E0,$0C,$27,$63,$F9,$AD,$00
	db $0C,$B9,$00

DATA_1AB9:
	db $E0,$07,$06,$50,$9D,$18,$50,$A4
	db $00

DATA_1AC2:
	db $E0,$03,$0C,$20,$F9,$93,$00,$0C
	db $91,$0F,$46,$F1,$00,$0C,$A1,$00

DATA_1AD2:
	db $E0,$02,$03,$41,$B9,$B8,$B4,$00

DATA_1ADA:
	db $E0,$06,$09,$50,$98,$9D,$A2,$A1
	db $A4,$00

DATA_1AE4:
	db $E0,$0E,$04,$28,$AA,$04,$32,$A1
	db $04,$3C,$98,$04,$46,$9B,$04,$50
	db $9E,$04,$4A,$9D,$04,$46,$9C,$04
	db $50,$9B,$04,$5A,$9A,$04,$64,$99
	db $04,$5A,$98,$04,$55,$9C,$04,$50
	db $A2,$04,$4B,$A1,$04,$49,$A0,$04
	db $46,$9F,$04,$44,$9E,$04,$42,$9D
	db $04,$40,$A1,$04,$3E,$A0,$04,$3C
	db $9F,$04,$37,$9E,$04,$32,$9D,$04
	db $2D,$98,$04,$2B,$9F,$04,$28,$A2
	db $04,$26,$A1,$04,$24,$A0,$04,$21
	db $9F,$04,$1E,$9E,$04,$1C,$9D,$04
	db $1E,$A1,$04,$1E,$A0,$04,$1E,$9F
	db $04,$1E,$9E,$04,$1E,$9D,$04,$24
	db $A0,$04,$21,$9F,$04,$1E,$9E,$04
	db $1C,$9D,$04,$1E,$A1,$04,$1A,$A0
	db $04,$14,$9F,$04,$0F,$9E,$04,$0A
	db $9D,$00

DATA_1B6E:
	db $E0,$06,$09,$3C,$87,$8C,$90,$93
	db $98,$9C,$98,$9C,$9F,$A4,$00

DATA_1B7D:
	db $E0,$12,$08,$3C,$9C,$9F,$A3,$A6
	db $AB,$AF,$B2,$A1,$A8,$AB,$AF,$B2
	db $B7,$30,$46,$B9,$00

DATA_1B92:
	db $E0,$10,$09,$46,$BC,$B7,$BB,$B2
	db $B9,$B8,$B4,$AF,$00

DATA_1B9F:
	db $E0,$08,$06,$16,$F9,$AB,$00,$06
	db $C5,$0F,$1E,$F1,$00,$0C,$A9,$00

DATA_1BAF:
	db $E0,$07,$06,$46,$A8,$A6,$A8,$A6
	db $A8,$A6,$A8,$A6,$A8,$A6,$00

DATA_1BBE:
	db $E0,$02,$06,$3C,$C3,$C0,$C3,$C0
	db $C3,$C0,$00

DATA_1BC9:
	db $E0,$0D,$30,$3C,$F9,$A6,$00,$30
	db $BC,$1B,$11,$F1,$00,$18,$BB,$00

DATA_1BD9:
	db $E0,$02,$03,$46,$8C,$90,$93,$98
	db $93,$98,$9C,$9F,$A4,$9F,$00

DATA_1BE8:
	db $E0,$07,$09,$31,$F9,$A4,$00,$06
	db $AB,$E0,$0C,$1B,$54,$F9,$B0,$00
	db $0C,$A4,$00,$E0,$01,$0F,$59,$F9
	db $A2,$00,$0C,$9F,$0C,$50,$8C,$00

DATA_1C08:
	db $E0,$03,$03,$00,$38,$A1,$03,$0E
	db $23,$9C,$03,$15,$15,$97,$03,$1C
	db $00,$91,$03,$38,$00,$A1,$03,$23
	db $0E,$9C,$03,$15,$15,$97,$03,$00
	db $1C,$91,$03,$00,$38,$A1,$03,$0E
	db $23,$9C,$03,$15,$15,$97,$03,$1C
	db $00,$91,$00

DATA_1C3B:
	db $E0,$0B,$04,$38,$93,$96,$03,$28
	db $95,$96,$06,$95,$0C,$00,$95,$04
	db $38,$93,$94,$93,$94,$06,$93,$09
	db $00,$93,$00

DATA_1C56:
	db $E0,$01,$06,$2A,$F9,$AD,$00,$06
	db $AB,$09,$78,$F1,$00,$06,$C7,$06
	db $2A,$F9,$AD,$00,$06,$AB,$09,$78
	db $F1,$00,$06,$C7,$06,$2A,$F9,$AD
	db $00,$06,$AB,$09,$78,$F1,$00,$06
	db $C7,$06,$2A,$F9,$AD,$00,$06,$AB
	db $09,$78,$F1,$00,$06,$C7,$06,$2A
	db $F9,$AD,$00,$06,$AB,$09,$78,$F1
	db $00,$06,$C7,$06,$2A,$F9,$AD,$00
	db $06,$AB,$09,$78,$F1,$00,$06,$C7
	db $00

DATA_1CA7:
	db $E0,$02,$06,$46,$BC,$BE,$C0,$C1
	db $C3,$00

DATA_1CB1:
	db $E0,$11,$0C,$1E,$8C,$06,$26,$90
	db $06,$22,$91,$0C,$20,$8E,$12,$24
	db $8C,$18,$21,$8D,$0C,$1E,$8B,$12
	db $22,$8C,$18,$27,$89,$18,$22,$94
	db $24,$26,$93,$0C,$22,$92,$12,$20
	db $90,$0C,$1E,$91,$12,$22,$8C,$18
	db $27,$89,$18,$22,$94,$24,$26,$93
	db $0C,$22,$92,$12,$20,$90,$0C,$1E
	db $91,$12,$22,$8C,$18,$27,$89,$18
	db $22,$94,$24,$26,$93,$0C,$22,$92
	db $12,$20,$90,$0C,$1E,$91,$00

DATA_1D08:
	db $E0,$98,$0F,$7F,$14,$F9,$BC,$00
	db $7F,$BC,$4F,$F1,$00,$4C,$BC,$00
	db $E0,$07,$0C,$4B,$A8,$A6,$00

DATA_1D1F:
	db $E0,$02,$0F,$46,$B4,$09,$46,$B0
	db $0F,$46,$B2,$09,$46,$AB,$00

DATA_1D2E:
	db $E0,$0E,$33,$54,$F9,$8C,$00,$30
	db $90,$00

DATA_1D38:
	db $E0,$0E,$33,$54,$F9,$90,$00,$30
	db $8C,$00

DATA_1D42:
	db $E0,$0E,$0C,$20,$F9,$93,$00,$0C
	db $91,$0F,$46,$F1,$00,$0C,$A1,$00

DATA_1D52:
	db $E0,$12,$0C,$3C,$A4,$A7,$AA,$AD
	db $B0,$30,$B3,$00,$E0,$92,$0D,$12
	db $50,$00,$A4,$00,$E0,$92,$0D,$12
	db $46,$0A,$A4,$00

DATA_1D6E:
	db $E0,$92,$0D,$12,$3C,$14,$A4,$00

DATA_1D76:
	db $E0,$92,$0D,$12,$32,$1E,$A4,$00

DATA_1D7E:
	db $E0,$92,$0D,$12,$1E,$32,$A4,$00

DATA_1D86:
	db $E0,$92,$0D,$12,$14,$3C,$A4,$00

DATA_1D8E:
	db $E0,$92,$0D,$12,$0A,$46,$A4,$00

DATA_1D96:
	db $E0,$92,$0D,$12,$00,$50,$A4,$00

DATA_1D9E:
	db $E0,$0A,$0C,$46,$46,$9C,$24,$0E
	db $08,$9C,$E0,$11,$24,$00,$00,$A4
	db $06,$08,$08,$A1,$12,$0C,$0C,$9F
	db $06,$0E,$10,$9C,$0C,$14,$15,$9B
	db $06,$18,$17,$99,$12,$0C,$11,$97
	db $12,$0B,$08,$93,$0C,$04,$02,$92
	db $00

DATA_1DCF:
	db $E0,$0D,$30,$0F,$F9,$BE,$00,$30
	db $BC,$1B,$0B,$F1,$00,$18,$BB,$00

DATA_1DDF:
	db $E0,$0A,$0C,$00,$72,$9C,$24,$0E
	db $08,$9C,$E0,$11,$24,$00,$00,$A4
	db $06,$00,$0C,$A1,$12,$02,$10,$9F
	db $06,$04,$16,$9C,$0C,$00,$1A,$9B
	db $06,$04,$21,$99,$12,$02,$14,$97
	db $12,$01,$12,$93,$0C,$04,$02,$92
	db $00

DATA_1E10:
	db $E0,$0A,$0C,$72,$00,$9A,$24,$08
	db $0E,$9A,$E0,$11,$24,$00,$00,$A4
	db $06,$0C,$00,$A1,$12,$10,$02,$9F
	db $06,$16,$04,$9C,$0C,$1A,$00,$9B
	db $06,$21,$04,$99,$12,$14,$02,$97
	db $12,$12,$01,$93,$0C,$04,$02,$92
	db $00

DATA_1E41:
	db $E0,$0D,$30,$14,$00,$F9,$BE,$00
	db $30,$BC,$1B,$11,$00,$F1,$00,$18
	db $BB,$00

DATA_1E53:
	db $E0,$05,$06,$54,$93,$18,$93,$00

DATA_1E5B:
	db $E0,$12,$08,$3C,$B4,$24,$B0,$00

DATA_1E63:
	db $E0,$0D,$7F,$3C,$F9,$BC,$00,$7C
	db $9F,$1F,$F1,$00,$1C,$9F,$00

DATA_1E72:
	db $E0,$05,$08,$54,$F9,$98,$00,$08
	db $90,$08,$F1,$00,$08,$A8,$15,$F1
	db $00,$12,$95,$00

DATA_1E86:
	db $E0,$11,$04,$28,$92,$04,$32,$95
	db $04,$3C,$98,$04,$46,$9B,$04,$50
	db $9E,$04,$4A,$9D,$04,$46,$9C,$04
	db $41,$9B,$04,$3C,$9A,$04,$37,$99
	db $04,$32,$98,$04,$2D,$97,$04,$28
	db $96,$04,$23,$95,$04,$1E,$94,$04
	db $19,$93,$04,$14,$92,$04,$0F,$91
	db $00

DATA_1EBF:
	db $E0,$92,$0D,$0E,$1E,$A4,$00

DATA_1EC6:
	db $E0,$98,$0F,$03,$32,$BC,$03,$00
	db $BC,$03,$50,$BC,$03,$00,$BC,$03
	db $3C,$BC,$03,$00,$BC,$03,$28,$BC
	db $03,$00,$BC,$03,$1E,$BC,$03,$00
	db $BC,$03,$14,$BC,$00

DATA_1EEB:
	db $E0,$0A,$0F,$54,$F9,$A4,$00,$0C
	db $9F,$00

DATA_1EF5:
	db $E0,$06,$03,$54,$AB,$A6,$03,$46
	db $AD,$A8,$03,$38,$AF,$A9,$03,$2A
	db $B0,$AB,$03,$00,$B0,$03,$54,$AB
	db $A6,$03,$46,$AD,$A8,$03,$38,$AF
	db $A9,$03,$2A,$B0,$AB,$03,$00,$B0
	db $03,$54,$AB,$A6,$03,$46,$AD,$A8
	db $03,$38,$AF,$A9,$03,$2A,$B0,$AB
	db $03,$20,$B2,$AD,$03,$16,$B4,$AF
	db $03,$0C,$B5,$B0,$00

DATA_1F3A:
	db $E0,$12,$0C,$32,$AB,$AF,$B2,$30
	db $B7,$00

DATA_1F44:
	db $E0,$12,$0C,$28,$F9,$B5,$00,$06
	db $B7,$00

DATA_1F4E:
	db $E0,$0E,$0F,$32,$F9,$9A,$00,$0C
	db $AB,$0F,$00,$00,$8C,$1B,$32,$F9
	db $A4,$00,$18,$A1,$00

DATA_1F63:
	db $E0,$06,$08,$32,$F9,$A4,$00,$08
	db $B7,$08,$F1,$00,$08,$AB,$16,$F1
	db $00,$12,$B7,$00

DATA_1F77:
	db $E0,$12,$06,$38,$38,$B7,$06,$3F
	db $31,$B5,$06,$29,$46,$B2,$06,$4D
	db $23,$AF,$06,$38,$38,$B5,$06,$3F
	db $31,$B2,$06,$2A,$46,$BB,$06,$46
	db $1C,$AD,$30,$23,$4D,$AB,$00

DATA_1F9E:
	db $E0,$11,$0C,$00,$54,$8C,$08,$1C
	db $0E,$8C,$0C,$46,$38,$8C,$12,$38
	db $54,$8D,$0C,$0E,$1C,$8B,$12,$2A
	db $1C,$89,$18,$1C,$0E,$8B,$08,$0E
	db $1C,$8C,$0C,$1C,$0E,$89,$06,$2A
	db $15,$8B,$08,$0E,$1C,$8C,$30,$1C
	db $1C,$8B,$FF

DATA_1FD1:
	db $E0,$8E,$03,$06,$23,$00,$98,$98
	db $06,$1C,$07,$98,$98,$08,$19,$0A
	db $98,$06,$15,$0E,$98,$98,$08,$11
	db $11,$98,$98,$06,$0E,$1F,$98,$06
	db $09,$18,$98,$98,$08,$07,$1C,$98
	db $06,$00,$23,$98,$98,$00

DATA_1FFF:
	db $E0,$11,$60,$00,$54,$98,$00

DATA_2006:
	db $E0,$8F,$08,$06,$28,$93,$E0,$91
	db $08,$06,$32,$C3,$06,$00,$93,$E0
	db $8E,$08,$06,$26,$C3,$E0,$90,$08
	db $06,$2D,$C3,$06,$00,$93,$E0,$8D
	db $08,$06,$18,$C3,$E0,$8F,$08,$06
	db $1E,$C3,$06,$00,$93,$E0,$8C,$08
	db $06,$14,$C3,$E0,$8E,$08,$06,$19
	db $C3,$06,$00,$93,$E0,$8B,$08,$06
	db $14,$C3,$E0,$8D,$08,$06,$19,$C3
	db $00

DATA_204F:
	db $E0,$0C,$04,$46,$B5,$E0,$9C,$10
	db $18,$2A,$C3,$00

DATA_205B:
	db $E0,$11,$0C,$3C,$A4,$06,$26,$A3
	db $06,$0E,$A1,$0C,$20,$9D,$12,$2E
	db $9A,$18,$35,$99,$0C,$3C,$9A,$12
	db $4A,$97,$18,$4F,$95,$18,$36,$94
	db $24,$12,$93,$30,$0E,$92,$00

DATA_2082:
	db $E0,$91,$0D,$60,$15,$AB,$00

DATA_2089:
	db $E0,$0B,$04,$46,$3F,$AB,$9A,$A8
	db $04,$3F,$46,$95,$8B,$A6,$04,$2A
	db $3F,$9D,$A6,$90,$04,$38,$1C,$A4
	db $89,$9C,$04,$0E,$31,$9F,$8B,$95
	db $04,$31,$07,$8C,$82,$90,$04,$07
	db $23,$8E,$84,$85,$04,$1C,$00,$82
	db $87,$84,$00

DATA_20BC:
	db $E0,$02,$06,$38,$B7,$B2,$B7,$B9
	db $BB,$BE,$18,$C3,$00

DATA_20C9:
	db $E0,$05,$0C,$54,$F9,$9C,$00,$0C
	db $9F,$0F,$F1,$00,$0C,$90,$00

DATA_20D8:
	db $E0,$03,$10,$15,$3F,$F9,$A1,$00
	db $10,$B7,$18,$F1,$00,$18,$AD,$12
	db $38,$15,$F9,$A8,$00,$12,$AB,$0C
	db $F1,$00,$0C,$9F,$08,$0E,$31,$F9
	db $A4,$00,$08,$A8,$06,$F1,$00,$06
	db $9C,$0C,$2A,$0E,$F9,$A1,$00,$0C
	db $A4,$06,$F1,$00,$06,$98,$0C,$07
	db $23,$F9,$9C,$00,$0C,$9F,$06,$F1
	db $00,$06,$93,$0C,$1B,$04,$F9,$98
	db $00,$0C,$9C,$06,$F1,$00,$06,$90
	db $0C,$04,$18,$F9,$95,$00,$0C,$98
	db $06,$F1,$00,$06,$8C,$6C,$00,$A5
	db $15,$38,$38,$F9,$AB,$00,$12,$BC
	db $00

DATA_2141:
	db $E0,$06,$4B,$46,$F9,$90,$00,$48
	db $9F,$00

DATA_214B:
	db $E0,$07,$06,$46,$A9,$06,$00,$B5
	db $06,$46,$A8,$06,$00,$B5,$00

DATA_215A:
	db $E0,$0A,$1B,$54,$F9,$A4,$00,$18
	db $9F,$E0,$02,$06,$50,$B4,$B7,$B9
	db $0C,$BB,$06,$3C,$B4,$B7,$B9,$0C
	db $BB,$06,$28,$B4,$B7,$B9,$0C,$BB
	db $06,$14,$B4,$B7,$B9,$0C,$BB,$00

DATA_2182:
	db $E0,$05,$08,$54,$F9,$9F,$00,$08
	db $A3,$12,$F1,$00,$12,$AB,$06,$3F
	db $F1,$00,$06,$A8,$11,$31,$F1,$00
	db $11,$AB,$08,$23,$F1,$00,$08,$A8
	db $0F,$15,$F1,$00,$0C,$AB
DATA_21A8:
	db $00

DATA_21A9:
	db $E0,$02,$0C,$54,$B4,$B0,$B4,$18
	db $B0,$00

DATA_21B3:
	db $E0,$03,$03,$23,$9F,$93,$A0,$94
	db $A1,$95,$A2,$96,$A3,$97,$A4,$98
	db $A5,$99,$A6,$9A,$00

DATA_21C8:
	db $E0,$05,$0C,$1C,$F9,$A1,$00,$0C
	db $9F,$18,$2A,$F1,$00,$18,$BC,$0F
	db $15,$F1,$00,$0C,$B0,$00

DATA_21DE:
	db $E0,$01,$0C,$2A,$F9,$A1,$00,$0C
	db $9F,$15,$59,$F1,$00,$12,$C1,$00

DATA_21EE:
	db $E0,$06,$0F,$31,$F9,$A4,$00,$0C
	db $B7,$0F,$00,$00,$8C,$18,$31,$B4
	db $00

DATA_21FF:
	db $E0,$02,$06,$38,$B4,$B7,$12,$00
	db $C8,$06,$38,$B4,$B7,$B6,$BA,$00

DATA_220F:
	db $E0,$06,$03,$54,$B5,$B4,$B5,$B4
	db $03,$46,$B5,$B4,$03,$38,$B5,$B4
	db $03,$2A,$B5,$B4,$03,$15,$B5,$B4
	db $00

DATA_2228:
	db $E0,$0F,$0C,$2A,$AE,$B8,$0C,$00
	db $B8,$0C,$2A,$B8,$18,$2A,$B8,$0C
	db $31,$AF,$B9,$0C,$00,$B9,$0C,$31
	db $B9,$18,$31,$B9,$0C,$38,$BA,$0C
	db $00,$BA,$30,$38,$BA,$00

DATA_224E:
	db $E0,$0F,$0C,$2A,$A9,$B2,$0C,$00
	db $B2,$0C,$2A,$B2,$18,$2A,$B2,$0C
	db $31,$AA,$B3,$0C,$00,$B3,$0C,$31
	db $B3,$18,$31,$B3,$0C,$38,$B4,$0C
	db $00,$B4,$30,$38,$B4,$00

DATA_2274:
	db $E0,$06,$0C,$38,$0E,$F9,$A4,$00
	db $0C,$B7,$18,$1C,$1C,$F1,$00,$18
	db $B0,$34,$0E,$38,$F1,$00,$30,$A4
	db $00

DATA_228D:
	db $E0,$03,$03,$00,$38,$AD,$AB,$03
	db $0E,$23,$A8,$A4,$03,$15,$15,$A3
	db $9F,$03,$1C,$00,$9D,$9A,$03,$38
	db $00,$AD,$AB,$03,$23,$0E,$A8,$A4
	db $03,$15,$15,$A3,$9F,$03,$00,$1C
	db $9D,$9A,$03,$00,$38,$AD,$AB,$03
	db $0E,$23,$A8,$A4,$03,$15,$15,$A3
	db $9F,$03,$1C,$00,$9D,$9A,$00

DATA_22CC:
	db $E0,$06,$09,$38,$F9,$9F,$00,$06
	db $AF,$09,$38,$F9,$9F,$00,$06,$AF
	db $09,$38,$F9,$9F,$00,$06,$AF,$00

DATA_22E4:
	db $E0,$02,$03,$4D,$AC,$B0,$B6,$00

DATA_22EC:
	db $E0,$04,$06,$59,$AE,$B5,$00

DATA_22F3:
	db $E0,$04,$06,$59,$B0,$B7,$00

DATA_22FA:
	db $E0,$04,$06,$59,$B2,$B9,$00

DATA_2301:
	db $E0,$04,$06,$59,$B4,$BB,$00

DATA_2308:
	db $E0,$04,$06,$59,$B6,$BD,$00

DATA_230F:
	db $E0,$04,$06,$59,$B8,$BF,$00

DATA_2316:
	db $E0,$04,$06,$59,$BA,$C1,$00

DATA_231D:
	db $E0,$04,$06,$59,$BC,$C3,$00

DATA_2324:
	db $E0,$04,$06,$59,$BE,$C5,$00

DATA_232B:
	db $E0,$07,$09,$31,$F9,$98,$00,$06
	db $9F,$E0,$0C,$1B,$54,$F9,$A4,$00
	db $0C,$98,$00

DATA_233E:
	db $E0,$06,$0F,$23,$F9,$98,$00,$0C
	db $93,$0F,$F9,$9C,$00,$0C,$9E,$00

DATA_234E:
	db $E0,$0A,$07,$41,$F9,$93,$00,$04
	db $B7,$00

DATA_2358:
	db $E0,$04,$06,$3F,$A4,$03,$AB,$AC
	db $A5,$AC,$AD,$A6,$AD,$AE

SOUND_HitPrizeBlock:
;$2366
	incsrc "SFX_63/HitPrizeBlock.asm"

DATA_237B:
	db $E0,$02,$0F,$46,$1C,$F9,$98,$00
	db $0C,$9F,$0F,$1C,$46,$F9,$A4,$00
	db $0C,$AB,$0F,$46,$1C,$F9,$A0,$00
	db $0C,$A7,$0F,$1C,$46,$F9,$AC,$00
	db $0C,$B3,$0F,$46,$1C,$F9,$A2,$00
	db $0C,$A9,$0F,$1C,$46,$F9,$AE,$00
	db $0C,$B5,$00

DATA_23AE:
	db $E0,$02,$09,$1C,$1C,$B0,$08,$19
	db $1F,$AE,$07,$1F,$19,$AC,$06,$15
	db $23,$AA,$05,$23,$15,$A8,$04,$0E
	db $2A,$A6,$00

DATA_23C9:
	db $E0,$03,$0C,$15,$07,$F9,$95,$00
	db $0C,$A4,$06,$F1,$00,$06,$97,$0C
	db $07,$1C,$F9,$99,$00,$0C,$A8,$06
	db $F1,$00,$06,$9A,$0C,$23,$0E,$F9
	db $9D,$00,$0C,$AD,$06,$F1,$00,$06
	db $9D,$0C,$0E,$31,$F9,$A1,$00,$0C
	db $B0,$06,$F1,$00,$06,$A0,$0C,$38
	db $15,$F9,$A5,$00,$0C,$B4,$06,$F1
	db $00,$06,$A3,$0C,$15,$3F,$F9,$A9
	db $00,$0C,$B9,$09,$F1,$00,$06,$AD
	db $00

DATA_241A:
	db $E0,$05,$0C,$3E,$F9,$AD,$00,$0C
	db $A4,$06,$F1,$00,$06,$AF,$0C,$3E
	db $F9,$B0,$00,$0C,$A7,$06,$F1,$00
	db $06,$B2,$0C,$53,$F9,$B3,$00,$0C
	db $AA,$09,$F1,$00,$06,$B4,$00

DATA_2441:
	db $E0,$02,$03,$46,$98,$9C,$9F,$A4
	db $9F,$A4,$A8,$AB,$B0,$AB,$A0,$A4
	db $A7,$AC,$A7,$AC,$B0,$B3,$B8,$B3
	db $A2,$A6,$A9,$AE,$A9,$AE,$B2,$B5
	db $BA,$B5,$00

DATA_2464:
	db $E0,$02,$08,$59,$B4,$B7,$C0,$BC
	db $BE,$0C,$C3,$00

DATA_2470:
	db $E0,$01,$03,$59,$A4,$A6,$A7,$A8
	db $03,$59,$A9,$AA,$AB,$AC,$03,$4D
	db $A9,$AA,$AB,$AC,$03,$46,$A9,$AA
	db $AB,$AC,$03,$3F,$A9,$AA,$AB,$AC
	db $03,$38,$A9,$AA,$AB,$AC,$00

DATA_2497:
	db $E0,$03,$03,$1C,$1C,$A3,$A1,$9F
	db $9D,$A3,$06,$A1,$03,$1C,$1C,$A4
	db $A3,$A1,$A0,$A4,$06,$A3,$03,$2A
	db $0E,$A8,$A6,$A5,$A4,$03,$0E,$23
	db $A8,$A6,$A5,$A4,$03,$23,$0E,$A8
	db $A6,$A5,$A4,$03,$0E,$1C,$A8,$A6
	db $A5,$A4,$03,$1C,$0E,$A8,$A6,$A5
	db $A4,$03,$07,$15,$A8,$A6,$A5,$A4
	db $03,$15,$07,$A8,$A6,$A5,$A4,$00

DATA_24DF:
	db $E0,$04,$03,$46,$AD,$08,$AC,$03
	db $46,$AF,$08,$B0,$03,$3F,$B1,$B3
	db $B4,$B5,$03,$38,$B3,$B5,$B6,$B7
	db $00

DATA_24F8:
	db $E0,$01,$03,$3F,$B2,$08,$B3,$03
	db $3F,$B5,$B6,$B7,$B8,$03,$38,$B5
	db $B6,$B7,$B8,$03,$31,$B5,$B6,$B7
	db $B8,$00

SOUND_Coin:
;$2512
	incsrc "SFX_63/Coin.asm"

DATA_251A:
	db $E0,$07,$04,$2A,$2A,$BB,$C0,$04
	db $31,$23,$AB,$A6,$04,$23,$31,$98
	db $9A,$04,$38,$1C,$9C,$91,$04,$1C
	db $38,$95,$97,$04,$3F,$15,$90,$8C
	db $04,$15,$3F,$8B,$82,$04,$46,$0E
	db $85,$87,$00

DATA_2545:
	db $E0,$0A,$03,$38,$9D,$9E,$9F,$A0
	db $A1,$A2,$A3,$A4,$0C,$00,$9C,$03
	db $38,$9F,$A0,$9F,$A0,$06,$9F,$0C
	db $00,$AB,$03,$38,$A3,$A4,$A3,$A4
	db $0C,$00,$AB,$03,$38,$A6,$A7,$A6
	db $A7,$06,$A6,$00

DATA_2571:
	db $E0,$0A,$06,$6E,$98,$06,$00,$8B
	db $27,$6E,$F9,$9F,$00,$24,$98,$00

DATA_2581:
	db $E0,$0A,$06,$64,$9C,$06,$00,$8B
	db $18,$64,$F9,$9F,$00,$15,$A1,$00

DATA_2591:
	db $E0,$0B,$08,$38,$A4,$06,$23,$A4
	db $06,$1C,$A4,$06,$15,$A4,$06,$07
	db $A4,$06,$07,$A4,$06,$07,$A4,$06
	db $07,$A4,$06,$07,$A4,$06,$07,$A4
	db $06,$07,$A4,$06,$07,$A4,$06,$07
	db $A4,$06,$07,$A4,$06,$07,$A4,$06
	db $07,$A4,$06,$07,$A4,$06,$07,$A4
	db $06,$07,$A4,$06,$07,$A4,$06,$07
	db $A4,$06,$07,$A4,$06,$07,$A4,$06
	db $07,$A4,$06,$07,$A4,$06,$07,$A4
	db $06,$07,$A4,$06,$07,$A4,$06,$07
	db $A4,$06,$07,$A4,$06,$07,$A4,$06
	db $07,$A4,$06,$07,$A4,$06,$07,$A4
	db $06,$07,$A4,$06,$07,$A4,$00

DATA_2600:
	db $E0,$0B,$06,$15,$A4,$06,$1C,$A4
	db $08,$2A,$A4,$18,$38,$A4,$00
%SPCDataBlockEnd(!ARAM_SMAS_EngineLoc)

if not(stringsequal("!GameID", "SMAS"))
	%EndSPCUploadAndJumpToEngine($!ARAM_SMAS_EngineLoc)
endif

base $!ARAM_SMAS_SampleBankPtrTableLoc
SamplePtrs:

base $!ARAM_SMAS_MusicBankLoc
MusicPtrs:
