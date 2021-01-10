
macro SMBLLBank00Macros(StartBank, EndBank)
;%BANK_START(<StartBank>)
CODE_00C000:
	LDA.w $0BA5
	BNE.b CODE_00C059
	LDA.w $06D5
	CMP.b #$18
	BEQ.b CODE_00C010
	CMP.b #$78
	BNE.b CODE_00C020
CODE_00C010:
	LDA.b $09
	AND.b #$07
	BNE.b CODE_00C020
	LDA.w !RAM_SMBLL_Global_SoundCh2
	BNE.b CODE_00C020
	LDA.b #!Define_SMAS_Sound0061_TurnAround
	STA.w !RAM_SMBLL_Global_SoundCh2
CODE_00C020:
	STZ.w $028E
	LDA.w $06D5
	LSR
	LSR
	LSR
	INC.w $028E
	REP.b #$20
	AND.w #$00FF
	XBA
	CLC
	ADC.w #SMBLL_UncompressedGFX_Player_Mario
	STA.w $028F
	LDA.w #$6000
	STA.w $0295
	LDA.w #$0100
	STA.w $0293
	SEP.b #$20
	LDA.w $0EC2
	BEQ.b CODE_00C054
	LDA.w $0290
	ORA.b #$40
	STA.w $0290
CODE_00C054:
	LDA.b #SMBLL_UncompressedGFX_Player_Mario>>16
	STA.w $0291
CODE_00C059:
	RTL

;--------------------------------------------------------------------

CODE_00C05A:
	STZ.w $0F4A
	LDA.b #$35
	RTL

;--------------------------------------------------------------------

CODE_00C060:
	REP.b #$20
	LDX.b #$1E
CODE_00C064:
	LDA.w $0753
	BEQ.b CODE_00C06F
	LDA.l DATA_00C0A3,x
	BRA.b CODE_00C073

CODE_00C06F:
	LDA.l DATA_00C083,x
CODE_00C073:
	STA.w $1160,x
	DEX
	DEX
	BPL.b CODE_00C064
	SEP.b #$20
	INC.w !RAM_SMBLL_Global_UpdateEntirePaletteFlag
	JSR.w CODE_00C0C3
	RTL

DATA_00C083:
	dw $734E,$7FFF,$14A5,$5D68,$762E,$27BF,$31BB,$3ABF
	dw $0000,$152F,$355D,$525F,$169B,$1C9F,$0C19,$0C19

DATA_00C0A3:
	dw $734E,$7FFF,$14A5,$5588,$724D,$27BF,$31BB,$3ABF
	dw $0000,$152F,$355D,$525F,$169B,$3303,$1A40,$1C9F

;--------------------------------------------------------------------

CODE_00C0C3:
	PHB
	PHK
	PLB
	PHX
	LDA.b #$FF
	STA.w $0EEE
	STZ.w $0EEF
	STZ.w $0BA3
	LDA.b #$15
	STA.w !RAM_SMBLL_Global_MainScreenLayersMirror
	LDA.b #$02
	STA.w !RAM_SMBLL_Global_SubScreenLayersMirror
	REP.b #$10
	LDA.w $075F
	PHA
	LDA.l !SRAM_SMB1_Cutscene_HeartEyesFlag
	BNE.b CODE_00C0F2
	LDA.w $07FC
	BEQ.b CODE_00C0F2
	LDA.b #$0C
	STA.w $075F
CODE_00C0F2:
	LDA.b #$00
	XBA
	LDA.w $0753
	ASL
	ASL
	STA.b $00
	LDA.w $075F
	AND.b #$08
	LSR
	LSR
	ORA.b $00
	TAY
	PLA
	STA.w $075F
	LDX.w DATA_00C126,y
	TXY
	LDX.w $1700
CODE_00C111:
	LDA.w DATA_00C12E,y
	STA.w $1702,x
	INC
	BEQ.b CODE_00C11E
	INX
	INY
	BRA.b CODE_00C111

CODE_00C11E:
	STX.w $1700
	SEP.b #$10
	PLX
	PLB
	RTS

DATA_00C126:
	dw $0000,$00A4,$0156,$01FA

DATA_00C12E:									;\ Info: "THANK YOU"
	db $59,$05,$00,$11							;|
	db $1D,$20,$11,$20,$0A,$20,$17,$20,$14,$20,$28,$20,$22,$20,$18,$20	;|
	db $1E,$20								;|
										;|
	db $59,$45,$00,$0B							;| "MARIO!"
	db $16,$20,$0A,$20,$1B,$20,$12,$20,$18,$20,$26,$20			;|
										;|
	db $59,$85,$00,$15							;| "THE KINGDOM"
	db $1D,$20,$11,$20,$0E,$20,$28,$20,$14,$20,$12,$20,$17,$20,$10,$20	;|
	db $0D,$20,$18,$20,$16,$20						;|
										;|
	db $59,$C5,$00,$11							;| "IS SAVED!"
	db $12,$20,$1C,$20,$28,$20,$1C,$20,$0A,$20,$1F,$20,$0E,$20,$0D,$20	;|
	db $26,$20								;|
										;|
	db $5A,$05,$00,$0D							;| "NOW TRY"
	db $17,$20,$18,$20,$20,$20,$28,$20,$1D,$20,$1B,$20,$22,$20		;|
										;|
	db $5A,$45,$00,$0B							;| "A MORE"
	db $0A,$20,$28,$20,$16,$20,$18,$20,$1B,$20,$0E,$20			;|
										;|
	db $5A,$85,$00,$11							;| "DIFFICULT"
	db $0D,$20,$12,$20,$0F,$20,$0F,$20,$12,$20,$0C,$20,$1E,$20,$15,$20	;|
	db $1D,$20								;|
										;|
	db $5A,$C5,$00,$0F							;| "QUEST..."
	db $1A,$20,$1E,$20,$0E,$20,$1C,$20,$1D,$20,$29,$20,$29,$20,$29,$20	;|
										;|
	db $FF,$FF								;/

DATA_00C1D2:									;\ Info: "THANK YOU"
	db $59,$05,$00,$11							;|
	db $1D,$20,$11,$20,$0A,$20,$17,$20,$14,$20,$28,$20,$22,$20,$18,$20	;|
	db $1E,$20								;|
										;|
	db $59,$45,$00,$11							;| "MARIO FOR"
	db $16,$20,$0A,$20,$1B,$20,$12,$20,$18,$20,$28,$20,$0F,$20,$18,$20	;|
	db $1B,$20								;|
										;|
	db $59,$85,$00,$11							;| "RESTORING"
	db $1B,$20,$0E,$20,$1C,$20,$1D,$20,$18,$20,$1B,$20,$12,$20,$17,$20	;|
	db $10,$20								;|
										;|
	db $59,$C5,$00,$0F							;| "PEACE TO"
	db $19,$20,$0E,$20,$0A,$20,$0C,$20,$0E,$20,$28,$20,$1D,$20,$18,$20	;|
										;|
	db $5A,$05,$00,$05							;| "OUR"
	db $18,$20,$1E,$20,$1B,$20						;|
										;|
	db $5A,$45,$00,$0F							;| "KINGDOM."
	db $14,$20,$12,$20,$17,$20,$10,$20,$0D,$20,$18,$20,$16,$20,$29,$20	;|
										;|
	db $5A,$85,$00,$11							;| "HURRAH TO"
	db $11,$20,$1E,$20,$1B,$20,$1B,$20,$0A,$20,$11,$20,$28,$20,$1D,$20	;|
	db $18,$20								;|
										;|
	db $5A,$C5,$00,$11							;| "OUR HERO,"
	db $18,$20,$1E,$20,$1B,$20,$28,$20,$11,$20,$0E,$20,$1B,$20,$18,$20	;|
	db $2B,$20								;|
										;|
	db $5B,$05,$00,$0B							;| "MARIO!"
	db $16,$20,$0A,$20,$1B,$20,$12,$20,$18,$20,$26,$20			;|
										;|
	db $FF,$FF								;/

DATA_00C284:									;\ Info: "THANK YOU"
	db $59,$05,$00,$11							;|
	db $1D,$20,$11,$20,$0A,$20,$17,$20,$14,$20,$28,$20,$22,$20,$18,$20	;|
	db $1E,$20								;|
										;|
	db $59,$45,$00,$0B							;| "LUIGI!"
	db $15,$20,$1E,$20,$12,$20,$10,$20,$12,$20,$26,$20			;|
										;|
	db $59,$85,$00,$15							;| "THE KINGDOM"
	db $1D,$20,$11,$20,$0E,$20,$28,$20,$14,$20,$12,$20,$17,$20,$10,$20	;|
	db $0D,$20,$18,$20,$16,$20						;|
										;|
	db $59,$C5,$00,$11							;| "IS SAVED!"
	db $12,$20,$1C,$20,$28,$20,$1C,$20,$0A,$20,$1F,$20,$0E,$20,$0D,$20	;|
	db $26,$20								;|
										;|
	db $5A,$05,$00,$0D							;| "NOW TRY"
	db $17,$20,$18,$20,$20,$20,$28,$20,$1D,$20,$1B,$20,$22,$20		;|
										;|
	db $5A,$45,$00,$0B							;| "A MORE"
	db $0A,$20,$28,$20,$16,$20,$18,$20,$1B,$20,$0E,$20			;|
										;|
	db $5A,$85,$00,$11							;| "DIFFICULT"
	db $0D,$20,$12,$20,$0F,$20,$0F,$20,$12,$20,$0C,$20,$1E,$20,$15,$20	;|
	db $1D,$20								;|
										;|
	db $5A,$C5,$00,$0F							;| "QUEST..."
	db $1A,$20,$1E,$20,$0E,$20,$1C,$20,$1D,$20,$29,$20,$29,$20,$29,$20	;|
										;|
	db $FF,$FF								;/

DATA_00C328:									;\ Info: "THANK YOU"
	db $59,$05,$00,$11							;|
	db $1D,$20,$11,$20,$0A,$20,$17,$20,$14,$20,$28,$20,$22,$20,$18,$20	;|
	db $1E,$20								;|
										;|
	db $59,$45,$00,$11							;| "LUIGI FOR"
	db $15,$20,$1E,$20,$12,$20,$10,$20,$12,$20,$28,$20,$0F,$20,$18,$20	;|
	db $1B,$20								;|
										;|
	db $59,$85,$00,$11							;| "RESTORING"
	db $1B,$20,$0E,$20,$1C,$20,$1D,$20,$18,$20,$1B,$20,$12,$20,$17,$20	;|
	db $10,$20								;|
										;|
	db $59,$C5,$00,$0F							;| "PEACE TO"
	db $19,$20,$0E,$20,$0A,$20,$0C,$20,$0E,$20,$28,$20,$1D,$20,$18,$20	;|
										;|
	db $5A,$05,$00,$05							;| "OUR"
	db $18,$20,$1E,$20,$1B,$20						;|
										;|
	db $5A,$45,$00,$0F							;| "KINGDOM."
	db $14,$20,$12,$20,$17,$20,$10,$20,$0D,$20,$18,$20,$16,$20,$29,$20	;|
										;|
	db $5A,$85,$00,$11							;| "HURRAH TO"
	db $11,$20,$1E,$20,$1B,$20,$1B,$20,$0A,$20,$11,$20,$28,$20,$1D,$20	;|
	db $18,$20								;|
										;|
	db $5A,$C5,$00,$11							;| "OUR HERO,"
	db $18,$20,$1E,$20,$1B,$20,$28,$20,$11,$20,$0E,$20,$1B,$20,$18,$20	;|
	db $2B,$20								;|
										;|
	db $5B,$05,$00,$0B							;| "LUIGI!"
	db $15,$20,$1E,$20,$12,$20,$10,$20,$12,$20,$26,$20			;|
										;|
	db $FF,$FF								;/

;--------------------------------------------------------------------

CODE_00C3DA:
	PHX
	LDA.w $0F85
	BNE.b CODE_00C41B
	LDA.l !SRAM_SMB1_Cutscene_HeartEyesFlag
	BEQ.b CODE_00C3E9
	LDA.w $0753
CODE_00C3E9:
	ASL
	ASL
	ASL
	ORA.w $0F84
	TAX
	INC.w $0F84
	LDA.w $0F84
	CMP.b #$03
	BNE.b CODE_00C402
	LDA.b #$FF
	STA.w $00A1
	STZ.w $043D
CODE_00C402:
	LDA.l DATA_00C43F,x
	BNE.b CODE_00C411
	INC.w $0772
	STZ.w $0705
	STZ.w $005D
CODE_00C411:
	STA.w $0F85
	LDA.l DATA_00C44F,x
	STA.w $0F86
CODE_00C41B:
	DEC.w $0F85
	LDA.w $0F86
	AND.b #$08
	ASL
	ASL
	ASL
	ASL
	STA.b $0D
	LDY.w $0F86
	LDA.w $0723
	BEQ.b CODE_00C43D
	LDA.w $0219
	CMP.b #$A2
	BCC.b CODE_00C43D
	LDA.b #$A2
	STA.w $0219
CODE_00C43D:
	PLX
	RTL

DATA_00C43F:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	db $14,$A0,$08,$01,$1E,$10,$03,$00
	db $14,$A0,$08,$01,$14,$1E,$02,$00
else
	db $18,$A0,$08,$01,$28,$10,$03,$00
	db $10,$A0,$08,$01,$28,$1E,$02,$00
endif

DATA_00C44F:
	db $01,$00,$41,$C1,$C9,$01,$01,$00
	db $01,$00,$41,$C1,$C9,$01,$01,$00

;--------------------------------------------------------------------

CODE_00C45F:
	DEC.w $0F88
	LDA.w $0F88
	BPL.b CODE_00C47D
	INC.w $0F87
	LDX.w $0F87
	CPX.b #$05
	BNE.b CODE_00C476
	LDA.b #$A0
	STA.w $0219
CODE_00C476:
	LDA.l DATA_00C4B4,x
	STA.w $0F88
CODE_00C47D:
	LDA.w $0F87
	ASL
	TAX
	LDA.l DATA_00C491,x
	STA.b $00
	LDA.l DATA_00C491+$01,x
	STA.b $01
	JMP.w ($0000)

DATA_00C491:
	dw CODE_00C49F
	dw CODE_00C49F
	dw CODE_00C49F
	dw CODE_00C4B0
	dw CODE_00C4A0
	dw CODE_00C49F
	dw CODE_00C49F

;--------------------------------------------------------------------

CODE_00C49F:
	RTL

;--------------------------------------------------------------------

CODE_00C4A0:
	LDA.b #$20
	STA.b $00
	LDA.b #$04
	STA.b $02
	LDA.b #$00
	LDX.b #$01
	JSL.l CODE_0DBF7A
CODE_00C4B0:
	DEC.w $021A
	RTL

;--------------------------------------------------------------------

DATA_00C4B4:
	db $00,$30,$37,$1A,$10,$60,$FF

;--------------------------------------------------------------------

CODE_00C4BB:
	PHX
	LDA.w $03AE
	CLC
	ADC.b #$07
	STA.w $08B0
	STA.w $08B4
	LDA.w $03B9
	STA.w $08B1
	CLC
	ADC.b #$10
	STA.w $08B5
	LDX.w $0F87
	CPX.b #$03
	BNE.b CODE_00C4E9
	LDA.b $09
	AND.b #$04
	BNE.b CODE_00C4E9
	LDA.l DATA_00C54E,x
	INC
	INC
	BRA.b CODE_00C4ED

CODE_00C4E9:
	LDA.l DATA_00C54E,x
CODE_00C4ED:
	STA.w $08B2
	CLC
	ADC.b #$20
	STA.w $08B6
	LDA.b #$25
	STA.w $08B3
	STA.w $08B7
	LDA.w $021A
	CLC
	ADC.b #$07
	SEC
	SBC.w $0042
	LDA.w $0079
	SBC.w $0043
	ORA.b #$02
	STA.w $0CB0
	STA.w $0CB4
	LDX.w $0B58
	LDA.w $0802,x
	CMP.b #$F6
	BNE.b CODE_00C528
	LDA.b #$F0
	STA.w $0801,x
	STA.w $0805,x
CODE_00C528:
	LDA.b $25
	BEQ.b CODE_00C54C
	LDA.b #$1C
	STA.w $09E3
	STA.w $09E7
	STA.w $09EB
	STA.w $09EF
	LDA.b #$80
	STA.w $09E2
	INC
	STA.w $09E6
	LDA.b #$90
	STA.w $09EA
	INC
	STA.w $09EE
CODE_00C54C:
	PLX
	RTL

DATA_00C54E:
	db $88,$88,$80,$82,$86,$86,$86

;--------------------------------------------------------------------

CODE_00C555:
	LDA.w $0F83
	CMP.b #$0A
	BCS.b CODE_00C586
	PHB
	PHK
	PLB
	PHX
	ASL
	TAX
	INC.w $0F83
	LDA.w DATA_00C587,x
	STA.w $0287
	REP.b #$20
	LDA.w #$0800
	STA.w $0288
	LDA.w DATA_00C5AF,x
	STA.w $028A
	LDA.w DATA_00C59B,x
	STA.w $0285
	SEP.b #$20
	INC.w $0B76
	PLX
	PLB
CODE_00C586:
	RTL

DATA_00C587:
	dw SMBLL_UncompressedGFX_BG_Castle>>16,SMBLL_UncompressedGFX_Ending+$0100>>16,SMBLL_UncompressedGFX_Ending+$0800>>16,SMBLL_UncompressedGFX_Ending+$1000>>16
	dw SMBLL_UncompressedGFX_Ending+$1800>>16,SMBLL_UncompressedGFX_Ending+$2000>>16,SMBLL_UncompressedGFX_Ending+$2800>>16,SMBLL_UncompressedGFX_Sprite_PeachAndToad+$1000>>16
	dw SMBLL_UncompressedGFX_Sprite_PeachAndToad+$1800>>16,SMBLL_EndScreenTilemap>>16

DATA_00C59B:
	dw SMBLL_UncompressedGFX_BG_Castle,SMBLL_UncompressedGFX_Ending+$0100,SMBLL_UncompressedGFX_Ending+$0800,SMBLL_UncompressedGFX_Ending+$1000
	dw SMBLL_UncompressedGFX_Ending+$1800,SMBLL_UncompressedGFX_Ending+$2000,SMBLL_UncompressedGFX_Ending+$2800,SMBLL_UncompressedGFX_Sprite_PeachAndToad+$1000
	dw SMBLL_UncompressedGFX_Sprite_PeachAndToad+$1800,SMBLL_EndScreenTilemap

DATA_00C5AF:
	dw $3000,$6080,$6400,$6800
	dw $6C00,$7000,$7400,$7800
	dw $7C00,$0400

;--------------------------------------------------------------------

CODE_00C5C3:
	PHB
	PHK
	PLB
	PHX
	LDA.w $0F83
	ASL
	TAX
	INC.w $0F83
	LDA.w DATA_00C5F1,x
	STA.w $0287
	REP.b #$20
	LDA.w #$0800
	STA.w $0288
	LDA.w DATA_00C619,x
	STA.w $028A
	LDA.w DATA_00C605,x
	STA.w $0285
	SEP.b #$20
	INC.w $0B76
	PLX
	PLB
	RTL

DATA_00C5F1:
	dw $0008,$0007,$0007,$0007
	dw $0007,$0007,$0007,$0007
	dw $0007,$0007

DATA_00C605:
	dw $A000,$8100,$8800,$9000
	dw $9800,$A000,$A800,$B000
	dw $B800,$B800

DATA_00C619:
	dw $3000,$6080,$6400,$6800
	dw $6C00,$7000,$7400,$7800
	dw $7C00,$7C00

;--------------------------------------------------------------------

CODE_00C62D:
	LDA.b #$2E
	STA.b $25
	LDA.b #$80
	STA.b $32
	LDA.b #$01
	STA.b $19
	LDA.b $78
	STA.b $82
	LDA.w $0219
	STA.w $0223
	LDA.b #$01
	STA.w $00C5
	LDA.b #$18
	STA.w $0241
	STZ.w $0067
	STZ.w $020C
	RTL

;--------------------------------------------------------------------

CODE_00C654:
	LDA.l !SRAM_SMB1_Cutscene_HeartEyesFlag
	BEQ.b CODE_00C664
	LDA.w $075F
	CMP.b #$08
	BCC.b CODE_00C67F
	JMP.w CODE_00C67F

CODE_00C664:
	LDA.w $075F
	PHA
	LDA.w $0E24
	PHA
	LDA.w $07FC
	BNE.b CODE_00C677
	STZ.w $0E24
	STZ.w $075F
CODE_00C677:
	PLA
	STA.w $0E24
	PLA
	STA.w $075F
CODE_00C67F:
	LDA.b #$01
	STA.w $0F82
	STZ.w $0F83
	STZ.w $0717
	RTL

;--------------------------------------------------------------------

CODE_00C68B:
	LDA.l !SRAM_SMB1_Cutscene_HeartEyesFlag
	BEQ.b CODE_00C694
	JMP.w CODE_00C7BF

CODE_00C694:
	PHB
	PHK
	PLB
	JSL.l CODE_0E81F6
	LDX.w $0F80
	LDA.w $0F81
	CMP.w DATA_00CA5D,x
	BCC.b CODE_00C6BD
	STZ.w $0F81
	INC.w $0F80
	LDA.w $0F80
	CMP.b #$08
	BCC.b CODE_00C6BD
	BNE.b CODE_00C6B8
	STZ.w $0F89
CODE_00C6B8:
	LDA.b #$08
	STA.w $0F80
CODE_00C6BD:
	INC.w $0F81
	LDA.b #$00
	XBA
	LDA.w $0F80
	ASL
	REP.b #$10
	TAY
	LDX.w DATA_00CAB4,y
	STX.b $ED
	LDX.w DATA_00CA80,y
	LDY.w #$0004
CODE_00C6D5:
	LDA.w DATA_00CAFA,x
	CMP.b #$FF
	BEQ.b CODE_00C715
	CLC
	ADC.b #$80
	STA.w $0801,y
	INX
	LDA.w DATA_00CAFA,x
	CLC
	ADC.b #$C0
	STA.w $0800,y
	INX
	LDA.w DATA_00CAFA,x
	STA.w $0802,y
	INX
	STZ.b $00
	CMP.b #$80
	BCS.b CODE_00C6FF
	LDA.w $0753
	STA.b $00
CODE_00C6FF:
	LDA.w DATA_00CAFA,x
	ORA.b $00
	ORA.b #$20
	STA.w $0803,y
	INX
	LDA.b #$02
	STA.w $0C00,y
	INY
	INY
	INY
	INY
	BRA.b CODE_00C6D5

CODE_00C715:
	LDX.b $ED
CODE_00C717:
	LDA.w DATA_00CAFA,x
	CMP.b #$FF
	BEQ.b CODE_00C764
	CLC
	ADC.b #$80
	STA.w $0801,y
	INX
	LDA.w DATA_00CAFA,x
	CLC
	ADC.b #$C0
	CLC
	ADC.w $0753
	ADC.w $0753
	ADC.w $0753
	ADC.w $0753
	STA.w $0800,y
	INX
	LDA.w DATA_00CAFA,x
	STA.w $0802,y
	INX
	STZ.b $00
	CMP.b #$80
	BCS.b CODE_00C74E
	LDA.w $0753
	STA.b $00
CODE_00C74E:
	LDA.w DATA_00CAFA,x
	ORA.b $00
	ORA.b #$20
	STA.w $0803,y
	INX
	LDA.b #$02
	STA.w $0C00,y
	INY
	INY
	INY
	INY
	BRA.b CODE_00C717

CODE_00C764:
	LDA.w $0F80
	CMP.b #$08
	BNE.b CODE_00C7B8
	SEP.b #$10
	JSR.w CODE_00E543
	LDA.w $0F89
	LSR
	LSR
	LSR
	AND.b #$03
	TAX
	LDA.l DATA_00CA59,x
	CLC
	ADC.b #$B0
	STA.w $0800
	LDA.w $0F89
	LSR
	LSR
	STA.b $00
	LDA.b #$60
	SEC
	SBC.b $00
	STA.w $0801
	LDA.w $0F89
	LSR
	LSR
	LSR
	LSR
	LSR
	AND.b #$03
	TAX
	LDA.l DATA_00CA55,x
	STA.w $0802
	LDA.b #$26
	STA.w $0803
	LDA.b #$00
	STA.w $0C00
	INC.w $0F89
	CPX.b #$03
	BNE.b CODE_00C7B8
	STZ.w $0F89
CODE_00C7B8:
	SEP.b #$10
	JSR.w CODE_00CA21
	PLB
	RTL

CODE_00C7BF:
	LDA.w $075F
	CMP.b #$08
	BCC.b CODE_00C7C9
	JMP.w CODE_00C8F6

CODE_00C7C9:
	PHB
	PHK
	PLB
	JSL.l CODE_0E81F6
	LDX.w $0F80
	LDA.w $0F81
	CMP.w DATA_00CA66,x
	BCC.b CODE_00C7F4
	STZ.w $0F81
	INC.w $0F80
	LDA.w $0F80
	CMP.b #$05
	BNE.b CODE_00C7EB
	STZ.w $0F89
CODE_00C7EB:
	CMP.b #$0F
	BCC.b CODE_00C7F4
	LDA.b #$06
	STA.w $0F80
CODE_00C7F4:
	INC.w $0F81
	LDA.b #$00
	XBA
	LDA.w $0F80
	ASL
	REP.b #$10
	TAY
	LDX.w DATA_00CAC6,y
	STX.b $ED
	LDX.w DATA_00CA80,y
	LDY.w #$0004
CODE_00C80C:
	LDA.w DATA_00CAFA,x
	CMP.b #$FF
	BEQ.b CODE_00C84C
	CLC
	ADC.b #$80
	STA.w $0801,y
	INX
	LDA.w DATA_00CAFA,x
	CLC
	ADC.b #$C0
	STA.w $0800,y
	INX
	LDA.w DATA_00CAFA,x
	STA.w $0802,y
	INX
	STZ.b $00
	CMP.b #$80
	BCS.b CODE_00C836
	LDA.w $0753
	STA.b $00
CODE_00C836:
	LDA.w DATA_00CAFA,x
	ORA.b $00
	ORA.b #$20
	STA.w $0803,y
	INX
	LDA.b #$02
	STA.w $0C00,y
	INY
	INY
	INY
	INY
	BRA.b CODE_00C80C

CODE_00C84C:
	LDX.b $ED
CODE_00C84E:
	LDA.w DATA_00CAFA,x
	CMP.b #$FF
	BEQ.b CODE_00C89B
	CLC
	ADC.b #$80
	STA.w $0801,y
	INX
	LDA.w DATA_00CAFA,x
	CLC
	ADC.b #$C0
	CLC
	ADC.w $0753
	ADC.w $0753
	ADC.w $0753
	ADC.w $0753
	STA.w $0800,y
	INX
	LDA.w DATA_00CAFA,x
	STA.w $0802,y
	INX
	STZ.b $00
	CMP.b #$80
	BCS.b CODE_00C885
	LDA.w $0753
	STA.b $00
CODE_00C885:
	LDA.w DATA_00CAFA,x
	ORA.b $00
	ORA.b #$20
	STA.w $0803,y
	INX
	LDA.b #$02
	STA.w $0C00,y
	INY
	INY
	INY
	INY
	BRA.b CODE_00C84E

CODE_00C89B:
	LDA.w $0F80
	CMP.b #$06
	BCC.b CODE_00C8EF
	SEP.b #$10
	JSR.w CODE_00E543
	LDA.w $0F89
	LSR
	LSR
	LSR
	AND.b #$03
	TAX
	LDA.l DATA_00CA59,x
	CLC
	ADC.b #$B0
	STA.w $0800
	LDA.w $0F89
	LSR
	LSR
	STA.b $00
	LDA.b #$60
	SEC
	SBC.b $00
	STA.w $0801
	LDA.w $0F89
	LSR
	LSR
	LSR
	LSR
	LSR
	AND.b #$03
	TAX
	LDA.l DATA_00CA55,x
	STA.w $0802
	LDA.b #$26
	STA.w $0803
	LDA.b #$00
	STA.w $0C00
	INC.w $0F89
	CPX.b #$03
	BNE.b CODE_00C8EF
	STZ.w $0F89
CODE_00C8EF:
	SEP.b #$10
	JSR.w CODE_00CA21
	PLB
	RTL

CODE_00C8F6:
	PHB
	PHK
	PLB
	JSL.l CODE_0E81F6
	LDX.w $0F80
	LDA.w $0F81
	CMP.w DATA_00CA76,x
	BCC.b CODE_00C91F
	STZ.w $0F81
	INC.w $0F80
	LDA.w $0F80
	CMP.b #$09
	BCC.b CODE_00C91F
	BNE.b CODE_00C91A
	STZ.w $0F89
CODE_00C91A:
	LDA.b #$09
	STA.w $0F80
CODE_00C91F:
	INC.w $0F81
	LDA.b #$00
	XBA
	LDA.w $0F80
	ASL
	REP.b #$10
	TAY
	LDX.w DATA_00CAE6,y
	STX.b $ED
	LDX.w DATA_00CAA0,y
	LDY.w #$0004
CODE_00C937:
	LDA.w DATA_00CAFA,x
	CMP.b #$FF
	BEQ.b CODE_00C977
	CLC
	ADC.b #$80
	STA.w $0801,y
	INX
	LDA.w DATA_00CAFA,x
	CLC
	ADC.b #$C0
	STA.w $0800,y
	INX
	LDA.w DATA_00CAFA,x
	STA.w $0802,y
	INX
	STZ.b $00
	CMP.b #$80
	BCS.b CODE_00C961
	LDA.w $0753
	STA.b $00
CODE_00C961:
	LDA.w DATA_00CAFA,x
	ORA.b $00
	ORA.b #$20
	STA.w $0803,y
	INX
	LDA.b #$02
	STA.w $0C00,y
	INY
	INY
	INY
	INY
	BRA.b CODE_00C937

CODE_00C977:
	LDX.b $ED
CODE_00C979:
	LDA.w DATA_00CAFA,x
	CMP.b #$FF
	BEQ.b CODE_00C9C6
	CLC
	ADC.b #$80
	STA.w $0801,y
	INX
	LDA.w DATA_00CAFA,x
	CLC
	ADC.b #$C0
	CLC
	ADC.w $0753
	ADC.w $0753
	ADC.w $0753
	ADC.w $0753
	STA.w $0800,y
	INX
	LDA.w DATA_00CAFA,x
	STA.w $0802,y
	INX
	STZ.b $00
	CMP.b #$80
	BCS.b CODE_00C9B0
	LDA.w $0753
	STA.b $00
CODE_00C9B0:
	LDA.w DATA_00CAFA,x
	ORA.b $00
	ORA.b #$20
	STA.w $0803,y
	INX
	LDA.b #$02
	STA.w $0C00,y
	INY
	INY
	INY
	INY
	BRA.b CODE_00C979

CODE_00C9C6:
	LDA.w $0F80
	CMP.b #$09
	BNE.b CODE_00CA1A
	SEP.b #$10
	JSR.w CODE_00E543
	LDA.w $0F89
	LSR
	LSR
	LSR
	AND.b #$03
	TAX
	LDA.l DATA_00CA59,x
	CLC
	ADC.b #$B0
	STA.w $0800
	LDA.w $0F89
	LSR
	LSR
	STA.b $00
	LDA.b #$60
	SEC
	SBC.b $00
	STA.w $0801
	LDA.w $0F89
	LSR
	LSR
	LSR
	LSR
	LSR
	AND.b #$03
	TAX
	LDA.l DATA_00CA55,x
	STA.w $0802
	LDA.b #$26
	STA.w $0803
	LDA.b #$00
	STA.w $0C00
	INC.w $0F89
	CPX.b #$03
	BNE.b CODE_00CA1A
	STZ.w $0F89
CODE_00CA1A:
	SEP.b #$10
	JSR.w CODE_00CA21
	PLB
	RTL

CODE_00CA21:
	LDA.w $0753
	BEQ.b CODE_00CA54
	LDA.w $0806
	CMP.b #$EE
	BNE.b CODE_00CA54
	LDA.w $0804
	DEC
	DEC
	STA.w $0804
	STA.w $0808
	LDA.b #$82
	STA.w $0806
	INC
	STA.w $080A
	LDA.w $0804
	CLC
	ADC.b #$08
	STA.w $0808
	LDA.b #$85
	STA.w $080E
	LDA.b #$89
	STA.w $0812
CODE_00CA54:
	RTS

DATA_00CA55:
	db $5F,$5E,$5D,$5C

DATA_00CA59:
	db $00,$02,$00,$FE

DATA_00CA5D:
	db $50,$30,$08,$08,$20,$20,$08,$08
	db $FF

DATA_00CA66:
	db $50,$30,$08,$08,$20,$20,$08,$08
	db $0C,$08,$08,$0C,$08,$08,$0C,$FF

DATA_00CA76:
	db $60,$08,$08,$10,$14,$10,$14,$10
	db $14,$FF

DATA_00CA80:
	dw $0000,$008A,$011C,$01AE,$0244,$02D2,$0360,$045F
	dw $055E,$055E,$055E,$055E,$055E,$055E,$055E,$055E

DATA_00CAA0:
	db $BE,$06,$89,$07,$CE,$07,$FF,$06
	db $44,$07,$FF,$06,$44,$07,$FF,$06
	db $44,$07,$FF,$06

DATA_00CAB4:
	db $41,$00,$CB,$00,$5D,$01,$F3,$01
	db $89,$02,$17,$03,$A5,$03,$A4,$04
	db $A3,$05

DATA_00CAC6:
	dw $0041,$00CB,$015D,$01F3,$0289,$0317,$03F6,$04F5
	dw $05F4,$03F6,$04F5,$05F4,$03F6,$04F5,$05F4,$065D

DATA_00CAE6:
	dw $0813,$091E,$0977,$086C,$08C5,$086C,$08C5,$086C
	dw $08C5,$086C

DATA_00CAFA:
	db $E8,$EC,$A0,$06,$E8,$FC,$A2,$06,$E8,$0C,$A4,$06,$F8,$EC,$C0,$06
	db $F8,$FC,$C2,$06,$F8,$0C,$C4,$06,$08,$EC,$E0,$06,$08,$FC,$E2,$06
	db $08,$0C,$E4,$06,$10,$CC,$8D,$06,$10,$D4,$8E,$06,$10,$E4,$AC,$06
	db $10,$F4,$AE,$06,$18,$F4,$CC,$06,$18,$04,$CE,$06,$18,$14,$EC,$06
	db $FF,$D8,$D0,$0A,$06,$D8,$E0,$08,$06,$E8,$C0,$28,$06,$E8,$D0,$2A
	db $06,$E8,$E0,$2A,$46,$E8,$F0,$28,$46,$F8,$C0,$48,$06,$F8,$D0,$4A
	db $06,$F8,$E0,$4A,$46,$F8,$F0,$48,$46,$08,$C0,$68,$06,$08,$D0,$6A
	db $06,$08,$E0,$6A,$46,$08,$F0,$68,$46,$18,$C0,$6E,$46,$18,$D0,$6C
	db $46,$18,$E0,$6C,$06,$18,$F0,$6E,$06,$FF,$E8,$EC,$A0,$06,$E8,$FC
	db $A2,$06,$E8,$0C,$A4,$06,$F8,$EC,$C0,$06,$F8,$FC,$C2,$06,$F8,$0C
	db $C4,$06,$08,$EC,$E0,$06,$08,$FC,$E2,$06,$08,$0C,$E4,$06,$10,$CC
	db $8D,$06,$10,$D4,$8E,$06,$10,$E4,$AC,$06,$10,$F4,$AE,$06,$18,$F4
	db $CC,$06,$18,$04,$CE,$06,$18,$14,$EC,$06,$FF,$F0,$D0,$14,$06,$F0
	db $E0,$16,$06,$D8,$D0,$0A,$06,$D8,$E0,$08,$06,$E8,$C0,$28,$06,$E8
	db $D0,$2A,$06,$E8,$E0,$2A,$46,$E8,$F0,$28,$46,$F8,$C0,$48,$06,$F8
	db $D0,$4A,$06,$F8,$E0,$4A,$46,$F8,$F0,$48,$46,$08,$C0,$68,$06,$08
	db $D0,$6A,$06,$08,$E0,$6A,$46,$08,$F0,$68,$46,$18,$C0,$6E,$46,$18
	db $D0,$6C,$46,$18,$E0,$6C,$06,$18,$F0,$6E,$06,$FF,$E8,$EB,$A0,$06
	db $E8,$FB,$A2,$06,$E8,$0B,$A4,$06,$F8,$EB,$C0,$06,$F8,$FB,$C2,$06
	db $F8,$0B,$C4,$06,$08,$EB,$E0,$06,$08,$FB,$E2,$06,$08,$0B,$E4,$06
	db $10,$CB,$8D,$06,$10,$D3,$8E,$06,$10,$E3,$AC,$06,$10,$F3,$AE,$06
	db $18,$F3,$CC,$06,$18,$03,$CE,$06,$18,$13,$EC,$06,$FF,$F0,$D0,$14
	db $06,$F0,$E0,$16,$06,$D8,$D0,$0A,$06,$D8,$E0,$08,$06,$E8,$C0,$28
	db $06,$E8,$D0,$2A,$06,$E8,$E0,$2A,$46,$E8,$F0,$28,$46,$F8,$C0,$48
	db $06,$F8,$D0,$4A,$06,$F8,$E0,$4A,$46,$F8,$F0,$48,$46,$08,$C0,$68
	db $06,$08,$D0,$6A,$06,$08,$E0,$6A,$46,$08,$F0,$68,$46,$18,$C0,$6E
	db $46,$18,$D0,$6C,$46,$18,$E0,$6C,$06,$18,$F0,$6E,$06,$FF,$00,$D5
	db $EE,$06,$00,$D5,$EE,$06,$10,$DB,$88,$06,$10,$E2,$89,$06,$E8,$EA
	db $A0,$06,$E8,$FA,$A2,$06,$E8,$0A,$A4,$06,$F8,$EA,$C0,$06,$F8,$FA
	db $C2,$06,$F8,$0A,$C4,$06,$08,$EA,$E0,$06,$08,$FA,$E2,$06,$08,$0A
	db $E4,$06,$10,$F2,$8B,$06,$18,$F2,$CC,$06,$18,$02,$CE,$06,$18,$12
	db $EC,$06,$FF,$F0,$D0,$14,$06,$F0,$E0,$16,$06,$D8,$D0,$0A,$06,$D8
	db $E0,$08,$06,$E8,$C0,$28,$06,$E8,$D0,$2A,$06,$E8,$E0,$2A,$46,$E8
	db $F0,$28,$46,$F8,$C0,$48,$06,$F8,$D0,$4A,$06,$F8,$E0,$4A,$46,$F8
	db $F0,$48,$46,$08,$C0,$68,$06,$08,$D0,$6A,$06,$08,$E0,$6A,$46,$08
	db $F0,$68,$46,$18,$C0,$6E,$46,$18,$D0,$6C,$46,$18,$E0,$6C,$06,$18
	db $F0,$6E,$06,$FF,$00,$D4,$EE,$06,$00,$D4,$EE,$06,$10,$DA,$88,$06
	db $10,$E1,$89,$06,$E8,$E9,$A0,$06,$E8,$F9,$A2,$06,$E8,$09,$A4,$06
	db $F8,$E9,$C0,$06,$F8,$F9,$C2,$06,$F8,$09,$C4,$06,$08,$E9,$E0,$06
	db $08,$F9,$E2,$06,$08,$09,$E4,$06,$10,$F1,$8B,$06,$18,$F1,$CC,$06
	db $18,$01,$CE,$06,$18,$11,$EC,$06,$FF,$D8,$D0,$0A,$06,$D8,$E0,$08
	db $06,$E8,$C0,$28,$06,$E8,$D0,$2A,$06,$E8,$E0,$2A,$46,$E8,$F0,$28
	db $46,$F8,$C0,$48,$06,$F8,$D0,$4A,$06,$F8,$E0,$4A,$46,$F8,$F0,$48
	db $46,$08,$C0,$68,$06,$08,$D0,$6A,$06,$08,$E0,$6A,$46,$08,$F0,$68
	db $46,$18,$C0,$6E,$46,$18,$D0,$6C,$46,$18,$E0,$6C,$06,$18,$F0,$6E
	db $06,$FF,$00,$D3,$EE,$06,$00,$D3,$EE,$06,$10,$D9,$88,$06,$10,$E0
	db $89,$06,$E8,$E8,$A6,$06,$E8,$F8,$A8,$06,$E8,$08,$AA,$06,$F8,$E8
	db $C6,$06,$F8,$F8,$C8,$06,$F8,$08,$CA,$06,$08,$E8,$E6,$06,$08,$F8
	db $E8,$06,$08,$08,$EA,$06,$10,$F0,$8B,$06,$18,$F0,$CC,$06,$18,$00
	db $CE,$06,$18,$10,$EC,$06,$FF,$D8,$D0,$0A,$06,$D8,$E0,$08,$06,$E8
	db $C0,$28,$06,$E8,$D0,$2A,$06,$E8,$E0,$2A,$46,$E8,$F0,$28,$46,$F8
	db $C0,$48,$06,$F8,$D0,$4A,$06,$F8,$E0,$4A,$46,$F8,$F0,$48,$46,$08
	db $C0,$68,$06,$08,$D0,$6A,$06,$08,$E0,$6A,$46,$08,$F0,$68,$46,$18
	db $C0,$6E,$46,$18,$D0,$6C,$46,$18,$E0,$6C,$06,$18,$F0,$6E,$06,$FF
	db $00,$D3,$EE,$06,$00,$D3,$EE,$06,$10,$D9,$88,$06,$10,$E0,$89,$06
	db $E8,$E8,$A6,$06,$E8,$F8,$A8,$06,$E8,$08,$AA,$06,$F8,$E8,$C6,$06
	db $F8,$F8,$C8,$06,$F8,$08,$CA,$06,$08,$E8,$E6,$06,$08,$F8,$E8,$06
	db $08,$08,$EA,$06,$10,$F0,$8B,$06,$18,$F0,$CC,$06,$18,$00,$CE,$06
	db $18,$10,$EC,$06,$FF,$D8,$D0,$0A,$06,$D8,$E0,$08,$06,$E8,$C0,$28
	db $06,$E8,$D0,$0E,$06,$E8,$E0,$0E,$46,$00,$D0,$3E,$06,$00,$E0,$3E
	db $46,$E8,$F0,$28,$46,$F8,$C0,$48,$06,$F8,$D0,$2E,$06,$F8,$E0,$2E
	db $46,$F8,$F0,$48,$46,$08,$C0,$68,$06,$08,$D0,$6A,$06,$08,$E0,$6A
	db $46,$08,$F0,$68,$46,$18,$C0,$6E,$46,$18,$D0,$6C,$46,$18,$E0,$6C
	db $06,$18,$F0,$6E,$06,$FF,$F0,$D0,$42,$06,$F0,$E0,$42,$46,$D8,$D0
	db $0A,$06,$D8,$E0,$08,$06,$E8,$C0,$28,$06,$E8,$D0,$0C,$06,$E8,$D0
	db $2A,$06,$E8,$E0,$0C,$46,$E8,$E0,$2A,$46,$E8,$F0,$28,$46,$F8,$C0
	db $48,$06,$F8,$D0,$2C,$06,$F8,$D0,$4A,$06,$F8,$E0,$2C,$46,$F8,$E0
	db $4A,$46,$F8,$F0,$48,$46,$00,$D0,$60,$06,$00,$E0,$60,$46,$08,$C0
	db $68,$06,$08,$D0,$6A,$06,$08,$E0,$6A,$46,$08,$F0,$68,$46,$18,$C0
	db $6E,$46,$18,$D0,$6C,$46,$18,$E0,$6C,$06,$18,$F0,$6E,$06,$FF,$00
	db $D3,$EE,$06,$00,$D3,$EE,$06,$10,$D9,$88,$06,$10,$E0,$89,$06,$E8
	db $E8,$A6,$06,$E8,$F8,$A8,$06,$E8,$08,$AA,$06,$F8,$E8,$C6,$06,$F8
	db $F8,$C8,$06,$F8,$08,$CA,$06,$08,$E8,$E6,$06,$08,$F8,$E8,$06,$08
	db $08,$EA,$06,$10,$F0,$8B,$06,$18,$F0,$CC,$06,$18,$00,$CE,$06,$18
	db $10,$EC,$06,$FF,$D8,$D0,$0A,$06,$D8,$E0,$08,$06,$E8,$C0,$28,$06
	db $00,$D0,$3C,$06,$00,$E0,$3C,$46,$E8,$D0,$0C,$06,$E8,$E0,$0C,$46
	db $E8,$F0,$28,$46,$F8,$C0,$48,$06,$F8,$D0,$2C,$06,$F8,$E0,$2C,$46
	db $F8,$F0,$48,$46,$08,$C0,$68,$06,$08,$D0,$6A,$06,$08,$E0,$6A,$46
	db $08,$F0,$68,$46,$18,$C0,$6E,$46,$18,$D0,$6C,$46,$18,$E0,$6C,$06
	db $18,$F0,$6E,$06,$FF,$F0,$D0,$62,$06,$F0,$E0,$62,$46,$D8,$D0,$0A
	db $06,$D8,$E0,$08,$06,$E8,$C0,$28,$06,$E8,$D0,$0C,$06,$E8,$D0,$2A
	db $06,$E8,$E0,$0C,$46,$E8,$E0,$2A,$46,$E8,$F0,$28,$46,$F8,$C0,$48
	db $06,$F8,$D0,$2C,$06,$F8,$D0,$4A,$06,$F8,$E0,$2C,$46,$F8,$E0,$4A
	db $46,$F8,$F0,$48,$46,$00,$D0,$60,$06,$00,$E0,$60,$46,$08,$C0,$68
	db $06,$08,$D0,$6A,$06,$08,$E0,$6A,$46,$08,$F0,$68,$46,$18,$C0,$6E
	db $46,$18,$D0,$6C,$46,$18,$E0,$6C,$06,$18,$F0,$6E,$06,$FF,$00,$D3
	db $EE,$06,$00,$D3,$EE,$06,$10,$D9,$88,$06,$10,$E0,$89,$06,$E8,$E8
	db $A6,$06,$E8,$F8,$A8,$06,$E8,$08,$AA,$06,$F8,$E8,$C6,$06,$F8,$F8
	db $C8,$06,$F8,$08,$CA,$06,$08,$E8,$E6,$06,$08,$F8,$E8,$06,$08,$08
	db $EA,$06,$10,$F0,$8B,$06,$18,$F0,$CC,$06,$18,$00,$CE,$06,$18,$10
	db $EC,$06,$FF,$D8,$D0,$0A,$06,$D8,$E0,$08,$06,$E8,$C0,$28,$06,$E8
	db $D0,$0C,$06,$E8,$E0,$0C,$46,$00,$D0,$3C,$06,$00,$E0,$3C,$46,$E8
	db $F0,$28,$46,$F8,$C0,$48,$06,$F8,$D0,$2C,$06,$F8,$E0,$2C,$46,$F8
	db $F0,$48,$46,$08,$C0,$68,$06,$08,$D0,$6A,$06,$08,$E0,$6A,$46,$08
	db $F0,$68,$46,$18,$C0,$6E,$46,$18,$D0,$6C,$46,$18,$E0,$6C,$06,$18
	db $F0,$6E,$06,$FF,$F0,$D0,$40,$06,$F0,$E0,$40,$46,$D8,$D0,$0A,$06
	db $D8,$E0,$08,$06,$E8,$C0,$28,$06,$E8,$D0,$0C,$06,$E8,$D0,$2A,$06
	db $E8,$E0,$0C,$46,$E8,$E0,$2A,$46,$E8,$F0,$28,$46,$F8,$C0,$48,$06
	db $F8,$D0,$2C,$06,$F8,$D0,$4A,$06,$F8,$E0,$2C,$46,$F8,$E0,$4A,$46
	db $F8,$F0,$48,$46,$00,$D0,$60,$06,$00,$E0,$60,$46,$08,$C0,$68,$06
	db $08,$D0,$6A,$06,$08,$E0,$6A,$46,$08,$F0,$68,$46,$18,$C0,$6E,$46
	db $18,$D0,$6C,$46,$18,$E0,$6C,$06,$18,$F0,$6E,$06,$FF,$D8,$D0,$0A
	db $06,$D8,$E0,$08,$06,$E8,$C0,$28,$06,$E8,$D0,$0C,$06,$E8,$D0,$2A
	db $06,$E8,$E0,$0C,$46,$E8,$E0,$2A,$46,$E8,$F0,$28,$46,$F8,$C0,$48
	db $06,$F8,$D0,$2C,$06,$F8,$D0,$4A,$06,$F8,$E0,$2C,$46,$F8,$E0,$4A
	db $46,$F8,$F0,$48,$46,$00,$D0,$60,$06,$00,$E0,$60,$46,$08,$C0,$68
	db $06,$08,$D0,$6A,$06,$08,$E0,$6A,$46,$08,$F0,$68,$46,$18,$C0,$6E
	db $46,$18,$D0,$6C,$46,$18,$E0,$6C,$06,$18,$F0,$6E,$06,$FF,$E8,$EA
	db $A0,$06,$E8,$FA,$A2,$06,$E8,$0A,$A4,$06,$F8,$EA,$C0,$06,$F8,$FA
	db $C2,$06,$F8,$0A,$C4,$06,$08,$EA,$E0,$06,$08,$FA,$E2,$06,$08,$0A
	db $E4,$06,$10,$CA,$8D,$06,$10,$D2,$8E,$06,$10,$E2,$AC,$06,$10,$F2
	db $AE,$06,$18,$F2,$CC,$06,$18,$02,$CE,$06,$18,$12,$EC,$06,$FF,$00
	db $D2,$EE,$06,$00,$D2,$EE,$06,$10,$D8,$88,$06,$10,$E0,$89,$06,$E8
	db $E8,$A6,$06,$E8,$F8,$A8,$06,$E8,$08,$AA,$06,$F8,$E8,$C6,$06,$F8
	db $F8,$C8,$06,$F8,$08,$CA,$06,$08,$E8,$E6,$06,$08,$F8,$E8,$06,$08
	db $08,$EA,$06,$10,$F0,$8B,$06,$18,$F0,$CC,$06,$18,$00,$CE,$06,$18
	db $10,$EC,$06,$FF,$00,$D2,$EE,$06,$00,$D2,$EE,$06,$10,$D8,$88,$06
	db $10,$E0,$89,$06,$E8,$E8,$A0,$06,$E8,$F8,$A2,$06,$E8,$08,$A4,$06
	db $F8,$E8,$C0,$06,$F8,$F8,$C2,$06,$F8,$08,$C4,$06,$08,$E8,$E0,$06
	db $08,$F8,$E2,$06,$08,$08,$E4,$06,$10,$F0,$8B,$06,$18,$F0,$CC,$06
	db $18,$00,$CE,$06,$18,$10,$EC,$06,$FF,$00,$D3,$EE,$06,$00,$D3,$EE
	db $06,$10,$D9,$88,$06,$10,$E1,$89,$06,$E8,$E9,$A6,$06,$E8,$F9,$A8
	db $06,$E8,$09,$AA,$06,$F8,$E9,$C6,$06,$F8,$F9,$C8,$06,$F8,$09,$CA
	db $06,$08,$E9,$E6,$06,$08,$F9,$E8,$06,$08,$09,$EA,$06,$10,$F1,$8B
	db $06,$18,$F1,$CC,$06,$18,$01,$CE,$06,$18,$11,$EC,$06,$FF,$00,$D2
	db $EE,$06,$00,$D2,$EE,$06,$10,$D8,$88,$06,$10,$E0,$89,$06,$E8,$E8
	db $A6,$06,$E8,$F8,$A8,$06,$E8,$08,$AA,$06,$F8,$E8,$C6,$06,$F8,$F8
	db $C8,$06,$F8,$08,$CA,$06,$08,$E8,$E6,$06,$08,$F8,$E8,$06,$08,$08
	db $EA,$06,$10,$F0,$8B,$06,$18,$F0,$CC,$06,$18,$00,$CE,$06,$18,$10
	db $EC,$06,$FF,$D8,$D0,$0A,$06,$D8,$E0,$08,$06,$E8,$C0,$28,$06,$E8
	db $D0,$0C,$06,$E8,$E0,$34,$06,$E8,$E0,$2A,$46,$E8,$F0,$28,$46,$F0
	db $E0,$44,$06,$F8,$C0,$48,$06,$F8,$F0,$48,$46,$00,$D0,$3C,$06,$00
	db $E0,$64,$06,$F8,$D0,$2C,$06,$F8,$E0,$4A,$46,$08,$C0,$68,$06,$08
	db $D0,$6A,$06,$08,$E0,$6A,$46,$08,$F0,$68,$46,$18,$C0,$6E,$46,$18
	db $D0,$6C,$46,$18,$E0,$6C,$06,$18,$F0,$6E,$06,$FF,$D8,$D0,$0A,$06
	db $D8,$E0,$08,$06,$F0,$E0,$10,$06,$E8,$D0,$36,$06,$E8,$E0,$36,$46
	db $E8,$E0,$2A,$46,$E8,$F0,$28,$46,$F0,$D0,$46,$06,$E8,$C0,$28,$06
	db $F8,$C0,$48,$06,$00,$E0,$12,$06,$F8,$E0,$4A,$46,$F8,$F0,$48,$46
	db $00,$D0,$66,$06,$08,$C0,$68,$06,$08,$D0,$6A,$06,$08,$E0,$6A,$46
	db $08,$F0,$68,$46,$18,$C0,$6E,$46,$18,$D0,$6C,$46,$18,$E0,$6C,$06
	db $18,$F0,$6E,$06,$FF,$D8,$D0,$0A,$06,$D8,$E0,$08,$06,$F0,$E0,$10
	db $06,$E8,$C0,$28,$06,$E8,$D0,$36,$06,$E8,$E0,$36,$46,$E8,$E0,$2A
	db $46,$E8,$F0,$28,$46,$F0,$D0,$46,$06,$F8,$C0,$48,$06,$00,$E0,$12
	db $06,$F8,$E0,$4A,$46,$F8,$F0,$48,$46,$00,$D0,$66,$06,$08,$C0,$68
	db $06,$08,$D0,$6A,$06,$08,$E0,$6A,$46,$08,$F0,$68,$46,$18,$C0,$6E
	db $46,$18,$D0,$6C,$46,$18,$E0,$6C,$06,$18,$F0,$6E,$06,$FF,$D8,$D0
	db $0A,$06,$D8,$E0,$08,$06,$E8,$C0,$28,$06,$E8,$D0,$0C,$06,$E8,$E0
	db $34,$06,$E8,$E0,$2A,$46,$E8,$F0,$28,$46,$F0,$E0,$44,$06,$F8,$C0
	db $48,$06,$F8,$F0,$48,$46,$00,$D0,$3C,$06,$00,$E0,$64,$06,$F8,$D0
	db $2C,$06,$F8,$E0,$4A,$46,$08,$C0,$68,$06,$08,$D0,$6A,$06,$08,$E0
	db $6A,$46,$08,$F0,$68,$46,$18,$C0,$6E,$46,$18,$D0,$6C,$46,$18,$E0
	db $6C,$06,$18,$F0,$6E,$06,$FF,$D8,$D0,$0A,$06,$D8,$E0,$08,$06,$E8
	db $C0,$28,$06,$E8,$D0,$0C,$06,$E8,$E0,$34,$06,$E8,$E0,$2A,$46,$E8
	db $F0,$28,$46,$F0,$E0,$44,$06,$F8,$C0,$48,$06,$F8,$F0,$48,$46,$00
	db $D0,$3C,$06,$00,$E0,$64,$06,$F8,$D0,$2C,$06,$F8,$E0,$4A,$46,$08
	db $C0,$68,$06,$08,$D0,$6A,$06,$08,$E0,$6A,$46,$08,$F0,$68,$46,$18
	db $C0,$6E,$46,$18,$D0,$6C,$46,$18,$E0,$6C,$06,$18,$F0,$6E,$06,$FF

;--------------------------------------------------------------------

CODE_00D4CA:
	LDA.b #SMBLL_UncompressedGFX_Sprite_PeachAndToad>>16
	STA.w $0287
	REP.b #$20
	LDA.w #$0800
	STA.w $0288
	LDA.w #$7800
	STA.w $028A
	LDA.w $075F
	AND.w #$00FF
	CMP.w #$0007
	BNE.b CODE_00D4ED
	LDA.w #SMBLL_UncompressedGFX_Sprite_PeachAndToad+$1000
	BRA.b CODE_00D4F0

CODE_00D4ED:
	LDA.w #SMBLL_UncompressedGFX_Sprite_PeachAndToad
CODE_00D4F0:
	STA.w $0285
	SEP.b #$20
	STZ.w $0F7D
	STZ.w $0F7E
	STZ.w $0F7F
	STZ.w $0B9C
	LDA.b #$02
	STA.w $0B76
	RTL

;--------------------------------------------------------------------

CODE_00D507:
	PHX
	LDA.b #SMBLL_UncompressedGFX_Sprite_PeachAndToad>>16
	STA.w $0287
	REP.b #$20
	LDA.w #$0800
	STA.w $0288
	LDA.w #$7C00
	STA.w $028A
	LDA.w $075F
	AND.w #$00FF
	ASL
	TAX
	LDA.l DATA_00D55A,x
	STA.w $0285
	SEP.b #$20
	PLX
	RTL

;--------------------------------------------------------------------

CODE_00D52E:
	LDA.b #$80
	STA.w !REGISTER_VRAMAddressIncrementValue
	REP.b #$20
	LDA.w #$6000
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STA.w DMA[$00].Parameters
	LDA.w #SMBLL_UncompressedGFX_Sprite_GlobalTiles
	STA.w DMA[$00].SourceLo
	LDX.b #SMBLL_UncompressedGFX_Sprite_GlobalTiles>>16
	STX.w DMA[$00].SourceBank
	LDA.w #$4000
	STA.w DMA[$00].SizeLo
	LDX.b #$01
	STX.w !REGISTER_DMAEnable
	SEP.b #$20
	RTL

;--------------------------------------------------------------------

DATA_00D55A:
	dw SMBLL_UncompressedGFX_Sprite_PeachAndToad+$0800,SMBLL_UncompressedGFX_Sprite_PeachAndToad+$0800
	dw SMBLL_UncompressedGFX_Sprite_PeachAndToad+$0800,SMBLL_UncompressedGFX_Sprite_PeachAndToad+$0800
	dw SMBLL_UncompressedGFX_Sprite_PeachAndToad+$2800,SMBLL_UncompressedGFX_Sprite_PeachAndToad+$2000
	dw SMBLL_UncompressedGFX_Sprite_PeachAndToad+$2000,SMBLL_UncompressedGFX_Sprite_PeachAndToad+$1000
	dw SMBLL_UncompressedGFX_Sprite_PeachAndToad+$0800,SMBLL_UncompressedGFX_Sprite_PeachAndToad+$2800
	dw SMBLL_UncompressedGFX_Sprite_PeachAndToad+$2000,SMBLL_UncompressedGFX_Sprite_PeachAndToad+$2000
	dw SMBLL_UncompressedGFX_Sprite_PeachAndToad+$1000,SMBLL_UncompressedGFX_Sprite_PeachAndToad+$1000
	dw SMBLL_UncompressedGFX_Sprite_PeachAndToad+$1000,SMBLL_UncompressedGFX_Sprite_PeachAndToad+$1000

;--------------------------------------------------------------------

CODE_00D57A:
	LDA.w $0F7E
	BEQ.b CODE_00D582
	JMP.w CODE_00D626

CODE_00D582:
	LDA.b $09
	AND.b #$07
	BEQ.b CODE_00D58D
	LDA.w $0F7D
	BRA.b CODE_00D5AF

CODE_00D58D:
	INC.w $0F7D
	LDA.w $0F7D
	CMP.b #$03
	BCC.b CODE_00D5AF
	LDA.w $07B9
	EOR.w $07BA
	AND.b #$01
	BNE.b CODE_00D5AA
	LDA.b #$03
	STA.w $0F7D
	LDA.b #$01
	BRA.b CODE_00D5AF

CODE_00D5AA:
	LDA.b #$00
	STA.w $0F7D
CODE_00D5AF:
	STA.b $00
	LDA.b $79
	XBA
	LDA.w $021A
	LDY.b #$00
	JSR.w CODE_00E4FD
	LDA.b $79
	XBA
	LDA.w $021A
	REP.b #$20
	CLC
	ADC.w #$0008
	SEP.b #$20
	LDY.b #$04
	JSR.w CODE_00E4FD
	LDA.b $00
	CMP.b #$02
	BEQ.b CODE_00D602
	CMP.b #$00
	BNE.b CODE_00D5DD
	LDA.b #$83
	BRA.b CODE_00D5DF

CODE_00D5DD:
	LDA.b #$80
CODE_00D5DF:
	STA.w $0902
	INC
	STA.w $0906
	CLC
	ADC.b #$1F
	STA.w $090A
	INC
	STA.w $090E
	LDA.b #$B0
	STA.w $0901
	STA.w $0905
	LDA.b #$C0
	STA.w $0909
	STA.w $090D
	BRA.b CODE_00D625

CODE_00D602:
	LDA.b #$86
	STA.w $0902
	INC
	STA.w $0906
	CLC
	ADC.b #$0F
	STA.w $090A
	INC
	STA.w $090E
	LDA.b #$B8
	STA.w $0901
	STA.w $0905
	LDA.b #$C0
	STA.w $0909
	STA.w $090D
CODE_00D625:
	RTL

CODE_00D626:
	PHB
	PHK
	PLB
	PHX
	PHY
	LDA.w $075F
	ASL
	TAX
	LDA.w $0B9C
	BNE.b CODE_00D638
	JSR.w CODE_00E3A4
CODE_00D638:
	LDA.w DATA_00D645,x
	STA.b $00
	LDA.w DATA_00D645+$01,x
	STA.b $01
	JMP.w ($0000)

DATA_00D645:
	dw CODE_00D661
	dw CODE_00D6E4
	dw CODE_00D785
	dw CODE_00D95A
	dw CODE_00DBA1
	dw CODE_00DDFA
	dw CODE_00E096
	dw CODE_00D661
	dw CODE_00D661
	dw CODE_00DBA1
	dw CODE_00DDFA
	dw CODE_00E096
	dw CODE_00D661

;--------------------------------------------------------------------

DATA_00D65F:
	db $90,$00

CODE_00D661:
	JSR.w CODE_00E27B
	LDA.w $0F7F
	BNE.b CODE_00D66C
	JMP.w CODE_00E1D5

CODE_00D66C:
	CMP.b #$03
	BNE.b CODE_00D6BB
	LDA.w $0B9F
	BNE.b CODE_00D6BB
	JSR.w CODE_00E566
	LDA.b #$20
	STA.b $00
	LDA.b #$04
	STA.b $02
	LDX.b #$01
	LDA.b #$00
	JSL.l CODE_0DBF7A
	LDA.w $0238
	CMP.b #$B0
	BCS.b CODE_00D697
	LDA.b #$01
	STA.w $0B9D
	LDA.w $0238
CODE_00D697:
	CMP.b #$B8
	BCC.b CODE_00D6BB
	LDA.b #$B8
	STA.w $0238
	LDA.b #$FE
	STA.w $00A1
	STZ.w $043D
	STZ.w $041D
	LDA.b #$00
	STA.w $0B9E
	LDA.b #$18
	STA.w $0B9F
	STZ.w $0BA4
	JSR.w CODE_00E529
CODE_00D6BB:
	LDA.w $0B9F
	BNE.b CODE_00D6C7
	LDA.b #$01
	STA.w $0B9E
	BRA.b CODE_00D6CA

CODE_00D6C7:
	DEC.w $0B9F
CODE_00D6CA:
	LDA.w $03AE
	STA.b $00
	LDA.w $0238
	STA.b $01
	LDY.w $0B9D
	LDA.w DATA_00D65F,y
	TAY
	LDA.w $0B9E
	JSR.w CODE_00E1FC
	JMP.w CODE_00E1D5

;--------------------------------------------------------------------

CODE_00D6E4:
	JSR.w CODE_00E27B
	LDA.w $0F7F
	BNE.b CODE_00D6EF
	JMP.w CODE_00E1D5

CODE_00D6EF:
	CMP.b #$03
	BNE.b CODE_00D74F
	LDA.w $0B9F
	BNE.b CODE_00D74C
	LDA.w $0B9C
	CMP.b #$02
	BNE.b CODE_00D704
	STA.w $0B9E
	BRA.b CODE_00D74F

CODE_00D704:
	JSR.w CODE_00E566
	LDA.b #$01
	STA.w $0B9E
	LDA.b #$20
	STA.b $00
	LDA.b #$04
	STA.b $02
	LDX.b #$01
	LDA.b #$00
	JSL.l CODE_0DBF7A
	LDA.w $0238
	CMP.b #$B0
	BCS.b CODE_00D72B
	LDA.b #$01
	STA.w $0B9D
	LDA.w $0238
CODE_00D72B:
	CMP.b #$B8
	BCC.b CODE_00D74F
	LDA.b #$B8
	STA.w $0238
	STZ.w $00A1
	STZ.w $043D
	STZ.w $041D
	LDA.b #$28
	STA.w $0B9F
	LDA.b #$02
	STA.w $0B9C
	LDA.b #$00
	STA.w $0B9E
CODE_00D74C:
	DEC.w $0B9F
CODE_00D74F:
	LDA.w $03AE
	STA.b $00
	LDA.w $0238
	STA.b $01
	LDY.w $0B9D
	LDA.w DATA_00D65F,y
	TAY
	LDA.w $0B9E
	JSR.w CODE_00E1FC
	TYA
	CLC
	ADC.b #$10
	TAY
	LDA.w $03AE
	CLC
	ADC.b #$10
	STA.b $00
	LDA.w $0B9E
	CMP.b #$02
	BNE.b CODE_00D77F
	JSR.w CODE_00E529
	LDA.b #$03
CODE_00D77F:
	JSR.w CODE_00E1FC
	JMP.w CODE_00E1D5

;--------------------------------------------------------------------

CODE_00D785:
	JSR.w CODE_00E27B
	LDA.w $0F7F
	BNE.b CODE_00D790
	JMP.w CODE_00E1D5

CODE_00D790:
	CMP.b #$03
	BEQ.b CODE_00D797
	JMP.w CODE_00D817

CODE_00D797:
	LDA.w $0BA0
	CMP.b #$28
	BCC.b CODE_00D814
	CMP.b #$50
	BCC.b CODE_00D7FD
	CMP.b #$58
	BCC.b CODE_00D7F7
	JSR.w CODE_00E566
	LDA.b #$20
	STA.b $00
	LDA.b #$04
	STA.b $02
	LDX.b #$01
	LDA.b #$00
	JSL.l CODE_0DBF7A
	LDA.b #$01
	STA.w $0B9E
	LDA.w $0238
	CMP.b #$B0
	BCS.b CODE_00D7CC
	LDA.b #$01
	STA.w $0B9D
	BRA.b CODE_00D7E9

CODE_00D7CC:
	CMP.b #$B8
	BCC.b CODE_00D7E9
	STZ.w $00A1
	STZ.w $043D
	STZ.w $041D
	LDA.b #$B8
	STA.w $0238
	STZ.w $0B9E
	LDA.b #$01
	STA.w $0B9F
	JSR.w CODE_00E529
CODE_00D7E9:
	LDA.w $0B9F
	BNE.b CODE_00D7F7
	LDA.b $09
	AND.b #$01
	BNE.b CODE_00D7F7
	INC.w $021D
CODE_00D7F7:
	JSR.w CODE_00D831
	JMP.w CODE_00E1D5

CODE_00D7FD:
	LDY.b #$A0
	CMP.b #$2C
	BCC.b CODE_00D811
	CMP.b #$30
	BCC.b CODE_00D80C
	JSR.w CODE_00D891
	BRA.b CODE_00D814

CODE_00D80C:
	JSR.w CODE_00D8ED
	BRA.b CODE_00D814

CODE_00D811:
	JSR.w CODE_00D924
CODE_00D814:
	INC.w $0BA0
CODE_00D817:
	LDA.w $03AE
	STA.b $00
	LDA.w $0238
	STA.b $01
	LDY.w $0B9D
	LDA.w DATA_00D65F,y
	TAY
	LDA.w $0B9E
	JSR.w CODE_00E1FC
	JMP.w CODE_00E1D5

;--------------------------------------------------------------------

CODE_00D831:
	LDA.w $03AE
	STA.b $00
	LDA.w $0238
	STA.b $01
	LDY.w $0B9D
	LDA.w DATA_00D65F,y
	TAY
	LDA.w $0B9E
	JSR.w CODE_00E1FC
	TYA
	CLC
	ADC.b #$10
	TAY
	LDA.w $03AE
	SEC
	SBC.w $021D
	SEC
	SBC.b #$07
	STA.b $00
	LDA.w $0B9F
	DEC
	BEQ.b CODE_00D865
	LDA.b #$04
	CLC
	ADC.w $0B9E
CODE_00D865:
	JSR.w CODE_00E1FC
	TYA
	CLC
	ADC.b #$10
	TAY
	LDA.w $03AE
	CLC
	ADC.w $021D
	CLC
	ADC.b #$07
	STA.b $00
	LDA.w $0B9F
	DEC
	BEQ.b CODE_00D885
	LDA.b #$06
	CLC
	ADC.w $0B9E
CODE_00D885:
	JSR.w CODE_00E1FC
	LDA.w $0BA0
	BMI.b CODE_00D890
	INC.w $0BA0
CODE_00D890:
	RTS

;--------------------------------------------------------------------

CODE_00D891:
	LDA.w $0238
	INC
	STA.w $0905,y
	STA.w $090D,y
	CLC
	ADC.b #$07
	STA.w $0901,y
	STA.w $0909,y
	LDA.w $03AE
	SEC
	SBC.b #$0D
	STA.w $0904,y
	DEC
	STA.w $0900,y
	LDA.w $03AE
	CLC
	ADC.b #$0D
	STA.w $090C,y
	INC
	STA.w $0908,y
	LDA.b #$E0
	STA.w $0906,y
	STA.w $090E,y
	LDA.b #$CE
	STA.w $0902,y
	STA.w $090A,y
	LDA.b #$2D
	STA.w $090B,y
	STA.w $090F,y
	LDA.b #$6D
	STA.w $0903,y
	STA.w $0907,y
	LDA.b #$02
	STA.w $0D00,y
	STA.w $0D04,y
	STA.w $0D08,y
	STA.w $0D0C,y
	RTS

;--------------------------------------------------------------------

CODE_00D8ED:
	LDA.w $03AE
	SEC
	SBC.b #$09
	STA.w $0900,y
	LDA.w $03AE
	CLC
	ADC.b #$09
	STA.w $0904,y
	LDA.w $0238
	INC
	STA.w $0901,y
	STA.w $0905,y
	LDA.b #$E0
	STA.w $0902,y
	STA.w $0906,y
	LDA.b #$6D
	STA.w $0903,y
	LDA.b #$2D
	STA.w $0907,y
	LDA.b #$02
	STA.w $0D00,y
	STA.w $0D04,y
	RTS

;--------------------------------------------------------------------

CODE_00D924:
	LDA.w $03AE
	SEC
	SBC.b #$05
	STA.w $0900,y
	LDA.w $03AE
	CLC
	ADC.b #$05
	STA.w $0904,y
	LDA.w $0238
	STA.w $0901,y
	STA.w $0905,y
	LDA.b #$E0
	STA.w $0902,y
	STA.w $0906,y
	LDA.b #$6D
	STA.w $0903,y
	LDA.b #$2D
	STA.w $0907,y
	LDA.b #$02
	STA.w $0D00,y
	STA.w $0D04,y
	RTS

;--------------------------------------------------------------------

CODE_00D95A:
	JSR.w CODE_00E27B
	LDA.w $0F7F
	BNE.b CODE_00D965
	JMP.w CODE_00E1D5

CODE_00D965:
	INC.w $0B9F
	LDA.w $0B9F
	CMP.b #$C0
	BCC.b CODE_00D987
	LDA.b #$C0
	STA.w $0B9F
	LDA.b #$02
	STA.w $0B9C
	LDA.b #$01
	STA.w $0BB8
	STA.w $0BB9
	STA.w $0BBA
	STA.w $0BBB
CODE_00D987:
	STZ.w $0E67
	LDA.w $0BB4
	BNE.b CODE_00D9A2
	LDA.w $0B9C
	CMP.b #$02
	BEQ.b CODE_00D99C
	JSR.w CODE_00DAAB
	JMP.w CODE_00E1D5

CODE_00D99C:
	JSR.w CODE_00D9D7
	JMP.w CODE_00E1D5

CODE_00D9A2:
	LDA.w $0BA1
	BEQ.b CODE_00D9AE
	DEC.w $0BA1
	LDA.b #$00
	BRA.b CODE_00D9B3

CODE_00D9AE:
	JSR.w CODE_00E529
	LDA.b #$02
CODE_00D9B3:
	STA.w $0B9E
	LDX.b #$03
	LDY.b #$00
CODE_00D9BA:
	LDA.w $0BB0,x
	STA.b $00
	LDA.b #$B8
	STA.b $01
	LDA.w $0B9E
	JSR.w CODE_00E1FC
	TYA
	CLC
	ADC.b #$10
	TAY
	STY.w $0E67
	DEX
	BPL.b CODE_00D9BA
	JMP.w CODE_00E1D5

CODE_00D9D7:
	JSR.w CODE_00E566
	LDA.b #$20
	STA.b $00
	LDA.b #$04
	STA.b $02
	LDX.b #$01
	LDA.b #$00
	JSL.l CODE_0DBF7A
	LDA.w $0238
	CMP.b #$B0
	BCS.b CODE_00D9F6
	LDA.b #$01
	STA.w $0B9D
CODE_00D9F6:
	LDY.w $0B9D
	LDA.w DATA_00D65F,y
	TAY
	LDA.w $03AE
	STA.b $00
	LDA.w $0238
	CMP.b #$B8
	BCC.b CODE_00DA0E
	LDA.b #$B8
	STZ.w $0BB8
CODE_00DA0E:
	STA.b $01
	LDA.w $0BB8
	JSR.w CODE_00E1FC
	LDA.w $0BB1
	STA.b $00
	LDA.w $0238
	SEC
	SBC.b #$0C
	CMP.b #$B8
	BCC.b CODE_00DA2C
	LDA.b #$B8
	STZ.w $0BB9
	BRA.b CODE_00DA3A

CODE_00DA2C:
	LDA.b $09
	LSR
	BCC.b CODE_00DA34
	INC.w $0BB1
CODE_00DA34:
	LDA.w $0238
	SEC
	SBC.b #$0C
CODE_00DA3A:
	STA.b $01
	TYA
	CLC
	ADC.b #$10
	TAY
	LDA.w $0BB9
	CLC
	ADC.b #$06
	JSR.w CODE_00E1FC
	LDA.w $0BB2
	STA.b $00
	LDA.w $0238
	SEC
	SBC.b #$18
	CMP.b #$B8
	BCC.b CODE_00DA60
	LDA.b #$B8
	STZ.w $0BBA
	BRA.b CODE_00DA63

CODE_00DA60:
	DEC.w $0BB2
CODE_00DA63:
	STA.b $01
	TYA
	CLC
	ADC.b #$10
	TAY
	LDA.w $0BBA
	CLC
	ADC.b #$04
	JSR.w CODE_00E1FC
	LDA.w $0BB3
	STA.b $00
	LDA.w $0238
	SEC
	SBC.b #$24
	CMP.b #$B8
	BCC.b CODE_00DA97
	LDA.b #$B8
	STZ.w $0BBB
	INC.w $0BB4
	LDA.b #$28
	STA.w $0BA1
	LDA.w $0238
	SEC
	SBC.b #$24
	BRA.b CODE_00DA9A

CODE_00DA97:
	INC.w $0BB3
CODE_00DA9A:
	STA.b $01
	TYA
	CLC
	ADC.b #$10
	TAY
	LDA.w $0BBB
	CLC
	ADC.b #$06
	JSR.w CODE_00E1FC
	RTS

;--------------------------------------------------------------------

CODE_00DAAB:
	LDY.b #$B0
	LDX.b #$00
CODE_00DAAF:
	LDA.w $03AE
	STA.w $0900,y
	LDA.w DATA_00DB8F,x
	STA.w $0901,y
	LDA.w DATA_00DB8F+$01,x
	STA.w $0902,y
	LDA.b #$2D
	STA.w $0903,y
	LDA.b #$02
	STA.w $0D00,y
	INY
	INY
	INY
	INY
	INX
	INX
	CPX.b #$12
	BCC.b CODE_00DAAF
	LDA.b #$6D
	STA.w $09C3
	STZ.w $0DC0
	STZ.w $0DBC
	LDA.w $09BC
	CLC
	ADC.b #$08
	STA.w $09C0
	LDX.b #$00
CODE_00DAEB:
	LDA.w DATA_00DB88,x
	CMP.w $0B9F
	BCS.b CODE_00DAF8
	INX
	CPX.b #$06
	BNE.b CODE_00DAEB
CODE_00DAF8:
	TXA
	ASL
	TAX
	LDA.w DATA_00DB7A,x
	STA.b $00
	LDA.w DATA_00DB7A+$01,x
	STA.b $01
	LDA.b #$01
	JMP.w ($0000)

CODE_00DB0A:
	STA.w $0DB0
	STA.w $0DB4
	STA.w $0DB8
	STA.w $0DC8
	STA.w $0DCC
	STA.w $0DD0
	RTS

CODE_00DB1D:
	STA.w $0DB0
	STA.w $0DB4
	STA.w $0DB8
	STA.w $0DCC
	STA.w $0DD0
	LDA.b #!Define_SMAS_Sound0060_FlyWithCape
	STA.w !RAM_SMBLL_Global_SoundCh1
	RTS

CODE_00DB32:
	STA.w $0DB0
	STA.w $0DB4
	STA.w $0DC8
	STA.w $0DCC
	STA.w $0DD0
	RTS

CODE_00DB42:
	STA.w $0DB0
	STA.w $0DB4
	STA.w $0DC8
	STA.w $0DD0
	LDA.b #!Define_SMAS_Sound0060_FlyWithCape
	STA.w !RAM_SMBLL_Global_SoundCh1
	RTS

CODE_00DB54:
	STA.w $0DB0
	STA.w $0DC8
	STA.w $0DCC
	STA.w $0DD0
	RTS

CODE_00DB61:
	STA.w $0DB0
	STA.w $0DC8
	STA.w $0DCC
	LDA.b #!Define_SMAS_Sound0060_FlyWithCape
	STA.w !RAM_SMBLL_Global_SoundCh1
	RTS

CODE_00DB70:
	STA.w $0DC8
	STA.w $0DCC
	STA.w $0DD0
	RTS

DATA_00DB7A:
	dw CODE_00DB0A
	dw CODE_00DB1D
	dw CODE_00DB32
	dw CODE_00DB42
	dw CODE_00DB54
	dw CODE_00DB61
	dw CODE_00DB70

DATA_00DB88:
	db $40,$48,$58,$60,$70,$78,$BF

DATA_00DB8F:
	db $97,$EA,$A2,$EA,$AD,$EA,$B8,$B6
	db $B8,$B6,$C0,$C9,$B3,$EA,$A8,$EA
	db $9D,$EA

;--------------------------------------------------------------------

CODE_00DBA1:
	JSR.w CODE_00E27B
	LDA.w $0F7F
	BNE.b CODE_00DBAC
	JMP.w CODE_00E1D5

CODE_00DBAC:
	JSR.w CODE_00E566
	LDA.b #$20
	STA.b $00
	LDA.b #$04
	STA.b $02
	LDX.b #$01
	LDA.b #$00
	JSL.l CODE_0DBF7A
	LDA.w $0238
	CMP.b #$A0
	BCS.b CODE_00DBCB
	LDA.b #$01
	STA.w $0B9D
CODE_00DBCB:
	LDA.w $0238
	CMP.b #$B0
	BCC.b CODE_00DBED
	LDA.b #$B0
	STA.w $0238
	STZ.w $043D
	STZ.w $041C
	INC.w $0B9E
	LDA.w $0B9E
	BMI.b CODE_00DBEA
	LDA.b #$00
	STA.w $0B9E
CODE_00DBEA:
	STA.w $00A1
CODE_00DBED:
	INC.w $0B9F
	LDA.w $0B9F
	CMP.b #$44
	BCC.b CODE_00DC0C
	BNE.b CODE_00DBFE
	LDA.b #!Define_SMAS_Sound0060_EchoSpinJumpKill
	STA.w !RAM_SMBLL_Global_SoundCh1
CODE_00DBFE:
	LDA.b #$45
	STA.w $0B9F
	JSR.w CODE_00DC12
	JSR.w CODE_00E529
	JMP.w CODE_00E1D5

CODE_00DC0C:
	JSR.w CODE_00DD86
	JMP.w CODE_00E1D5

CODE_00DC12:
	LDA.w $03AE
	CLC
	ADC.w $0B9F
	STA.b $00
	CLC
	ADC.b #$06
	STA.w $0900
	CLC
	ADC.b #$10
	STA.w $0904
	LDA.b $00
	STA.w $0910
	STA.w $0918
	CLC
	ADC.b #$08
	STA.w $0914
	LDA.b $00
	CLC
	ADC.b #$1C
	STA.w $0920
	STA.w $0928
	CLC
	ADC.b #$08
	STA.w $0924
	LDA.b $00
	CLC
	ADC.b #$06
	STA.w $0930
	STA.w $0938
	CLC
	ADC.b #$08
	STA.w $0934
	LDA.b $00
	CLC
	ADC.b #$16
	STA.w $0940
	STA.w $0948
	CLC
	ADC.b #$08
	STA.w $0944
	LDA.b #$B8
	STA.w $0911
	STA.w $0915
	STA.w $0921
	STA.w $0925
	STA.w $0931
	STA.w $0935
	STA.w $0941
	STA.w $0945
	LDA.b #$C0
	STA.w $0901
	STA.w $0905
	STA.w $0919
	STA.w $0929
	STA.w $0939
	STA.w $0949
	LDA.b #$BE
	STA.w $0912
	STA.w $0926
	LDA.b #$BF
	STA.w $0916
	STA.w $0922
	LDA.b #$EC
	STA.w $091A
	STA.w $092A
	LDA.b #$EA
	STA.w $0902
	STA.w $0906
	LDA.b #$B6
	STA.w $0932
	STA.w $0936
	STA.w $0942
	STA.w $0946
	LDA.b #$C9
	STA.w $093A
	STA.w $094A
	LDA.b #$2D
	STA.w $0903
	STA.w $0913
	STA.w $0917
	STA.w $091B
	STA.w $0933
	STA.w $093B
	STA.w $0943
	STA.w $094B
	LDA.b #$6D
	STA.w $0907
	STA.w $0923
	STA.w $0927
	STA.w $092B
	STA.w $0937
	STA.w $0947
	LDA.b #$02
	STA.w $0D00
	STA.w $0D04
	STA.w $0D18
	STA.w $0D28
	STA.w $0D38
	STA.w $0D48
	LDX.b #$03
CODE_00DD10:
	LDA.w $0BB8,x
	BEQ.b CODE_00DD21
	CMP.b #$1E
	BCC.b CODE_00DD1E
	STZ.w $0BB8,x
	BRA.b CODE_00DD21

CODE_00DD1E:
	INC.w $0BB8,x
CODE_00DD21:
	DEX
	BPL.b CODE_00DD10
	LDA.b $09
	AND.b #$07
	BNE.b CODE_00DD56
	LDX.b #$03
CODE_00DD2C:
	LDA.w $0BB8,x
	BEQ.b CODE_00DD34
	DEX
	BNE.b CODE_00DD2C
CODE_00DD34:
	LDA.b $09
	AND.b #$03
	TAY
	LDA.w $07B9,y
	EOR.b $09
	AND.b #$1F
	CLC
	ADC.b #$CC
	STA.w $0BB0,x
	LDA.w $07BA,y
	EOR.b $09
	AND.b #$07
	CLC
	ADC.b #$B0
	STA.w $0BB4,x
	INC.w $0BB8,x
CODE_00DD56:
	LDX.b #$03
CODE_00DD58:
	LDA.w $0BB8,x
	LSR
	LSR
	LSR
	TAY
	LDA.w DATA_00DD82,y
	STA.b $00
	TXA
	ASL
	ASL
	TAY
	LDA.w $0BB0,x
	STA.w $0800,y
	LDA.w $0BB4,x
	STA.w $0801,y
	LDA.b $00
	STA.w $0802,y
	LDA.b #$25
	STA.w $0803,y
	DEX
	BPL.b CODE_00DD58
	RTS

DATA_00DD82:
	db $F5,$E4,$F4,$E5

CODE_00DD86:
	LDY.w $0B9D
	LDA.w DATA_00D65F,y
	TAY
	LDA.w $03AE
	CLC
	ADC.w $0B9F
	STA.w $0900,y
	STA.w $0908,y
	CLC
	ADC.b #$10
	STA.w $0904,y
	STA.w $090C,y
	LDA.w $0238
	STA.w $0901,y
	STA.w $0905,y
	CLC
	ADC.b #$10
	STA.w $0909,y
	STA.w $090D,y
	LDA.w $0B9F
	AND.b #$0C
	TAX
	LDA.b #$04
	STA.b $00
CODE_00DDBF:
	LDA.w DATA_00DDDA,x
	STA.w $0902,y
	LDA.w DATA_00DDEA,x
	STA.w $0903,y
	LDA.b #$02
	STA.w $0D00,y
	INY
	INY
	INY
	INY
	INX
	DEC.b $00
	BNE.b CODE_00DDBF
	RTS

DATA_00DDDA:
	db $CE,$CE,$EE,$EE,$E0,$E2,$E0,$E2
	db $EE,$EE,$CE,$CE,$E2,$E0,$E2,$E0
DATA_00DDEA:
	db $2D,$4D,$2D,$4D,$2D,$2D,$AD,$AD
	db $AD,$CD,$AD,$CD,$4D,$4D,$CD,$CD

;--------------------------------------------------------------------

CODE_00DDFA:
	JSR.w CODE_00E27B
	LDA.w $0F7F
	BNE.b CODE_00DE05
	JMP.w CODE_00E1D5

CODE_00DE05:
	JSR.w CODE_00E566
	LDA.b #$20
	STA.b $00
	LDA.b #$04
	STA.b $01
	LDX.b #$01
	LDA.b #$00
	JSL.l CODE_0DBF7A
	LDA.w $0238
	CMP.b #$A0
	BCS.b CODE_00DE24
	LDA.b #$01
	STA.w $0B9D
CODE_00DE24:
	LDA.w $0238
	CMP.b #$B8
	BCC.b CODE_00DE4A
	LDA.b #$B8
	STA.w $0238
	STZ.w $00A1
	STZ.w $043D
	STZ.w $041D
	LDA.w $0BA4
	CMP.b #!Define_SMAS_Sound0061_Jump						; Note: This must be the same value that's stored at $00E56B
	BNE.b CODE_00DE5A
	LDA.b #!Define_SMAS_Sound0060_YoshiSpit
	STA.w !RAM_SMBLL_Global_SoundCh1
	STA.w $0BA4
	BRA.b CODE_00DE5A

CODE_00DE4A:
	LDY.w $0B9D
	LDA.w DATA_00D65F,y
	TAY
	LDA.w $00A1
	JSR.w CODE_00DEF9
	JMP.w CODE_00E1D5

CODE_00DE5A:
	LDA.w $0B9C
	CMP.b #$02
	BEQ.b CODE_00DE78
	INC.w $0B9C
	LDA.w $03AE
	SEC
	SBC.b #$08
	STA.w $03AE
	LDA.w $021A
	SEC
	SBC.b #$08
	STA.w $021A
	STZ.b $09
CODE_00DE78:
	LDA.w $0BA0
	BNE.b CODE_00DE8C
	INC.w $0B9F
	LDA.w $0B9F
	CMP.b #$40
	BCC.b CODE_00DE9B
	LDA.b #$40
	STA.w $0B9F
CODE_00DE8C:
	INC.w $0BA0
	LDA.w $0BA0
	CMP.b #$88
	BCC.b CODE_00DE9B
	LDA.b #$88
	STA.w $0BA0
CODE_00DE9B:
	JSR.w CODE_00DF4C
	JSR.w CODE_00E529
	JMP.w CODE_00E1D5

;--------------------------------------------------------------------

CODE_00DEA4:
	LDA.w $03AE
	STA.w $0900,y
	STA.w $0908,y
	CLC
	ADC.b #$10
	STA.w $0904,y
	STA.w $090C,y
	LDA.w $0238
	STA.w $0901,y
	STA.w $0905,y
	CLC
	ADC.b #$10
	STA.w $0909,y
	STA.w $090D,y
	LDA.b #$CE
	STA.w $0902,y
	STA.w $0906,y
	STA.w $090A,y
	STA.w $090E,y
	LDA.b #$2D
	STA.w $0903,y
	LDA.b #$6D
	STA.w $0907,y
	LDA.b #$AD
	STA.w $090B,y
	LDA.b #$CD
	STA.w $090F,y
	LDA.b #$02
	STA.w $0D00,y
	STA.w $0D04,y
	STA.w $0D08,y
	STA.w $0D0C,y
	RTS

;--------------------------------------------------------------------

CODE_00DEF9:
	LDA.w $03AE
	STA.w $0900,y
	STA.w $0908,y
	CLC
	ADC.b #$10
	STA.w $0904,y
	STA.w $090C,y
	LDA.w $0238
	STA.w $0909,y
	STA.w $090D,y
	CLC
	ADC.b #$08
	STA.w $0901,y
	STA.w $0905,y
	LDA.b #$CE
	STA.w $090A,y
	STA.w $090E,y
	LDA.b #$DE
	STA.w $0902,y
	STA.w $0906,y
	LDA.b #$2D
	STA.w $0903,y
	STA.w $090B,y
	LDA.b #$6D
	STA.w $0907,y
	STA.w $090F,y
	LDA.b #$02
	STA.w $0D00,y
	STA.w $0D04,y
	STA.w $0D08,y
	STA.w $0D0C,y
	RTS

;--------------------------------------------------------------------

CODE_00DF4C:
	LDA.w $0B9F
	SEC
	SBC.b #$28
	BPL.b CODE_00DF56
	LDA.b #$00
CODE_00DF56:
	LSR
	LSR
	STA.b $00
	LDA.w $0BA0
	AND.b #$08
	LSR
	LSR
	LSR
	STA.b $01
	LDA.w $03AE
	CLC
	ADC.w $0BA0
	CLC
	ADC.b $01
	STA.w $0900
	STA.w $0910
	CLC
	ADC.b #$10
	SEC
	SBC.b $01
	STA.w $0904
	STA.w $0914
	CLC
	ADC.b #$10
	SEC
	SBC.b $01
	STA.w $0908
	STA.w $0918
	LDA.w $0238
	SEC
	SBC.b $00
	CLC
	ADC.b $01
	STA.w $0911
	STA.w $0915
	STA.w $0919
	CLC
	ADC.b #$08
	STA.w $0901
	STA.w $0905
	STA.w $0909
	LDA.b #$DE
	STA.w $0902
	STA.w $090A
	LDA.b #$EC
	STA.w $0906
	LDA.b #$CE
	STA.w $0912
	STA.w $091A
	LDA.b #$EA
	STA.w $0916
	LDA.b #$2D
	STA.w $0903
	STA.w $0907
	STA.w $0913
	STA.w $0917
	LDA.b #$6D
	STA.w $090B
	STA.w $091B
	LDA.b #$02
	STA.w $0D00
	STA.w $0D04
	STA.w $0D08
	STA.w $0D10
	STA.w $0D14
	STA.w $0D18
	LDA.w $03AE
	CLC
	ADC.w $0BA0
	INC
	INC
	STA.w $0920
	CLC
	ADC.b #$08
	STA.w $0924
	INC
	STA.w $0928
	CLC
	ADC.b #$08
	STA.w $092C
	INC
	STA.w $0930
	CLC
	ADC.b #$08
	STA.w $0934
	INC
	STA.w $0938
	CLC
	ADC.b #$08
	STA.w $093C
	LDA.b #$C8
	STA.w $0921
	STA.w $0925
	STA.w $0929
	STA.w $092D
	STA.w $0931
	STA.w $0935
	STA.w $0939
	STA.w $093D
	LDA.w $0BA0
	AND.b #$0F
	CMP.b #$0F
	BNE.b CODE_00E046
	LDA.b #!Define_SMAS_Sound0060_Swim
	STA.w !RAM_SMBLL_Global_SoundCh1
CODE_00E046:
	LDA.w $0BA0
	AND.b #$08
	ASL
	ORA.b #$CB
	STA.w $0922
	STA.w $092A
	STA.w $0932
	STA.w $093A
	INC
	STA.w $0926
	STA.w $092E
	STA.w $0936
	STA.w $093E
	LDA.b #$2D
	STA.w $0923
	STA.w $0927
	STA.w $092B
	STA.w $092F
	STA.w $0933
	STA.w $0937
	STA.w $093B
	STA.w $093F
	LDY.b #$00
CODE_00E083:
	LDA.w $0900,y
	CMP.b #$40
	BCS.b CODE_00E08F
	LDA.b #$F0
	STA.w $0901,y
CODE_00E08F:
	INY
	INY
	INY
	INY
	BNE.b CODE_00E083
	RTS

;--------------------------------------------------------------------

CODE_00E096:
	INC.w $0F7F
	LDA.w $0F7F
	CMP.b #$D0
	BCC.b CODE_00E0AB
	JSR.w CODE_00E529
	LDA.b #$D0
	STA.w $0F7F
	JMP.w CODE_00E0BA

CODE_00E0AB:
	CMP.b #$20
	BCC.b CODE_00E0BA
	PHA
	AND.b #$0F
	BNE.b CODE_00E0B9
	LDA.b #!Define_SMAS_Sound0060_Swim
	STA.w !RAM_SMBLL_Global_SoundCh1
CODE_00E0B9:
	PLA
CODE_00E0BA:
	LSR
	LSR
	LSR
	CMP.b #$03
	BCC.b CODE_00E0C3
	LDA.b #$03
CODE_00E0C3:
	PHA
	JSR.w CODE_00E0DC
	PLA
	CMP.b #$02
	BNE.b CODE_00E0D9
	LDA.w $0BA4
	BNE.b CODE_00E0D9
	LDA.b #!Define_SMAS_Sound0060_SMB2UPickupItem
	STA.w !RAM_SMBLL_Global_SoundCh1
	STA.w $0BA4
CODE_00E0D9:
	JMP.w CODE_00E1D5

CODE_00E0DC:
	ASL
	ASL
	ASL
	TAX
	LDY.b #$08
	LDA.b #$88
	STA.w $0900,y
	STA.w $0908,y
	LDA.b #$90
	STA.w $0904,y
	LDA.b #$B0
	STA.w $0901,y
	STA.w $0905,y
	LDA.b #$C0
	STA.w $0909,y
	LDA.b #$80
	STA.w $0902,y
	INC
	STA.w $0906,y
	LDA.b #$A0
	STA.w $090A,y
	LDA.b #$2D
	STA.w $0903,y
	STA.w $0907,y
	STA.w $090B,y
	LDY.b #$00
CODE_00E117:
	LDA.w DATA_00E1B5,x
	STA.w $0900,y
	INY
	INX
	CPY.b #$08
	BCC.b CODE_00E117
	LDA.b #$02
	STA.w $0D00
	STA.w $0D04
	STA.w $0D08
	STA.w $0D0C
	STA.w $0D10
	LDA.b #$7E
	CLC
	ADC.w $0F7F
	STA.w $091C
	CMP.b #$88
	BCS.b CODE_00E145
	LDA.b #$F0
	BRA.b CODE_00E147

CODE_00E145:
	LDA.b #$C0
CODE_00E147:
	STA.w $091D
	LDA.b $09
	LSR
	LSR
	AND.b #$02
	STA.b $01
	CLC
	ADC.b #$E6
	STA.w $091E
	LDA.b #$2D
	STA.w $091F
	LDA.b #$02
	STA.w $0D1C
	LDY.b #$20
	LDX.b #$06
	LDA.b #$78
	CLC
	ADC.w $0F7F
	STA.b $00
CODE_00E16E:
	LDA.b $00
	STA.w $0900,y
	STA.w $0904,y
	CMP.b #$91
	BCS.b CODE_00E184
	LDA.b #$F0
	STA.w $0901,y
	STA.w $0905,y
	BRA.b CODE_00E18E

CODE_00E184:
	LDA.b #$C0
	STA.w $0901,y
	LDA.b #$C8
	STA.w $0905,y
CODE_00E18E:
	LDA.b #$BA
	CLC
	ADC.b $01
	STA.w $0902,y
	INC
	STA.w $0906,y
	LDA.b #$2D
	STA.w $0903,y
	STA.w $0907,y
	INY
	INY
	INY
	INY
	INY
	INY
	INY
	INY
	LDA.b $00
	SEC
	SBC.b #$0A
	STA.b $00
	DEX
	BNE.b CODE_00E16E
	RTS

DATA_00E1B5:
	db $98,$C0,$E4,$2D,$90,$C0,$A1,$2D
	db $99,$BF,$E4,$2D,$90,$C0,$A1,$2D
	db $9B,$BF,$E2,$2D,$90,$C0,$E0,$2D
	db $90,$C0,$E0,$2D,$90,$C0,$E0,$2D

;--------------------------------------------------------------------

CODE_00E1D5:
	LDA.w $0BA6
	BEQ.b CODE_00E1E1
	BMI.b CODE_00E1F8
	DEC.w $0BA6
	BRA.b CODE_00E1F8

CODE_00E1E1:
	LDA.w $0BA7
	BNE.b CODE_00E1F8
	INC.w $0BA7
	LDA.b #$B8
	STA.w $03CE
	LDA.w $0754
	BNE.b CODE_00E1F8
	LDA.b #$C8
	STA.w $03CE
CODE_00E1F8:
	PLY
	PLX
	PLB
	RTL

;--------------------------------------------------------------------

CODE_00E1FC:
	PHX
	STA.b $02
	ASL
	CLC
	ADC.b $02
	TAX
	LDA.b $00
	STA.w $0900,y
	STA.w $0908,y
	CLC
	ADC.b #$08
	STA.w $0904,y
	LDA.b $01
	STA.w $0901,y
	STA.w $0905,y
	CLC
	ADC.b #$08
	STA.w $0909,y
	LDA.w DATA_00E24B,x
	STA.w $0902,y
	LDA.w DATA_00E24B+$01,x
	STA.w $0906,y
	LDA.w DATA_00E24B+$02,x
	STA.w $090A,y
	LDA.w DATA_00E263,x
	STA.w $0903,y
	LDA.w DATA_00E263+$01,x
	STA.w $0907,y
	LDA.w DATA_00E263+$02,x
	STA.w $090B,y
	LDA.b #$02
	STA.w $0D08,y
	PLX
	RTS

DATA_00E24B:
	db $B6,$B6,$C9,$B7,$B7,$CB,$B8,$B9
	db $EC,$B9,$B8,$EC,$E3,$E2,$E4,$F3
	db $F2,$E6,$E2,$E3,$E4,$F2,$F3,$E6

DATA_00E263:
	db $2D,$6D,$2D,$2D,$6D,$2D,$2D,$2D
	db $2D,$6D,$6D,$6D,$6D,$6D,$6D,$6D
	db $6D,$6D,$2D,$2D,$2D,$2D,$2D,$2D

;--------------------------------------------------------------------

CODE_00E27B:
	DEC.w $0F7D
	LDA.w $0F7D
	BPL.b CODE_00E28B
	INC.w $0F7F
	LDA.b #$07
	STA.w $0F7D
CODE_00E28B:
	LDA.w $0F7F
	CMP.b #$03
	BCC.b CODE_00E297
	LDA.b #$03
	STA.w $0F7F
CODE_00E297:
	PHX
	ASL
	TAX
	LDA.w DATA_00E2A7,x
	STA.b $00
	LDA.w DATA_00E2A7+$01,x
	STA.b $01
	JMP.w ($0000)

DATA_00E2A7:
	dw CODE_00E2AF
	dw CODE_00E318
	dw CODE_00E35E
	dw CODE_00E377

;--------------------------------------------------------------------

CODE_00E2AF:
	LDA.b #$94
	STA.w $0958
	LDA.b #$BB
	STA.w $0959
	LDA.b #$C0
	STA.w $095A
	LDA.b #$2D
	STA.w $095B
	LDA.b #$02
	STA.w $0D58
	LDA.b #$88
	STA.w $0960
	STA.w $0970
	LDA.b #$90
	STA.w $0964
	STA.w $0974
	LDA.b #$C0
	STA.w $0971
	STA.w $0975
	LDA.b #$9C
	STA.w $0972
	INC
	STA.w $0976
	LDA.b #$B8
	STA.w $0961
	STA.w $0965
	LDA.b #$8C
	STA.w $0962
	INC
	STA.w $0966
	LDA.b #$2D
	STA.w $0973
	STA.w $0977
	STA.w $0963
	STA.w $0967
	LDA.b #$02
	STA.w $0D70
	STA.w $0D74
	STA.w $0D60
	STA.w $0D64
	PLX
	RTS

;--------------------------------------------------------------------

CODE_00E318:
	LDA.b #$9A
	STA.w $0958
	LDA.b #$BE
	STA.w $0959
	LDA.b #$C2
	STA.w $095A
	LDA.b #$2D
	STA.w $095B
	LDA.b #$02
	STA.w $0D58
	LDA.b #$88
	STA.w $0970
	LDA.b #$90
	STA.w $0974
	LDA.b #$C0
	STA.w $0971
	STA.w $0975
	LDA.b #$99
	STA.w $0972
	INC
	STA.w $0976
	LDA.b #$2D
	STA.w $0973
	STA.w $0977
	LDA.b #$02
	STA.w $0D70
	STA.w $0D74
	PLX
	RTS

;--------------------------------------------------------------------

CODE_00E35E:
	LDA.b #$9C
	STA.w $0958
	LDA.b #$C1
	STA.w $0959
	LDA.b #$C4
	STA.w $095A
	LDA.b #$2D
	STA.w $095B
	LDA.b #$02
	STA.w $0D58
CODE_00E377:
	LDA.b #$88
	STA.w $0970
	LDA.b #$90
	STA.w $0974
	LDA.b #$C0
	STA.w $0971
	STA.w $0975
	LDA.b #$C6
	STA.w $0972
	INC
	STA.w $0976
	LDA.b #$2D
	STA.w $0973
	STA.w $0977
	LDA.b #$02
	STA.w $0D70
	STA.w $0D74
	PLX
	RTS

;--------------------------------------------------------------------

CODE_00E3A4:
	LDA.b #!Define_SMAS_Sound0060_HurtWhileFlying
	STA.w !RAM_SMBLL_Global_SoundCh1
	LDA.w $0754
	EOR.b #$01
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC.b #$E0
	CLC
	ADC.b #$08
	STA.w $03CE
	LDY.b #$9C
	LDA.b #$000B00>>8
	STA.b $01
	STZ.b $00
	LDA.b #$00
CODE_00E3C5:
	STA.b ($00),y
	INY
	CPY.b #$BF
	BNE.b CODE_00E3C5
	INC.w $0B9C
	DEC.w $0BA6
	LDA.w $075F
	ASL
	TAX
	LDA.w DATA_00E3E4,x
	STA.b $00
	LDA.w DATA_00E3E4+$01,x
	STA.b $01
	JMP.w ($0000)

DATA_00E3E4:
	dw CODE_00E3FE
	dw CODE_00E426
	dw CODE_00E44E
	dw CODE_00E47C
	dw CODE_00E4AE
	dw CODE_00E4D4
	dw CODE_00E4EE
	dw CODE_00E3FE
	dw CODE_00E3FE
	dw CODE_00E4AE
	dw CODE_00E4D4
	dw CODE_00E4EE
	dw CODE_00E3FE

;--------------------------------------------------------------------

CODE_00E3FE:
	LDA.w $021A
	SEC
	SBC.b #$04
	STA.w $021A
	LDA.w $03AE
	SEC
	SBC.b #$04
	STA.w $03AE
	LDA.b #$08
	STA.w $0F7D
	LDA.b #!Define_SMAS_Sound0061_Jump
	STA.w !RAM_SMBLL_Global_SoundCh2
	LDA.b #$FE
	STA.w $00A1
	STZ.w $043D
	STZ.w $041D
	RTS

;--------------------------------------------------------------------

CODE_00E426:
	LDA.w $021A
	SEC
	SBC.b #$0C
	STA.w $021A
	LDA.w $03AE
	SEC
	SBC.b #$0C
	STA.w $03AE
	LDA.b #$08
	STA.w $0F7D
	LDA.b #!Define_SMAS_Sound0061_Jump
	STA.w !RAM_SMBLL_Global_SoundCh2
	LDA.b #$FE
	STA.w $00A1
	STZ.w $043D
	STZ.w $041D
	RTS

;--------------------------------------------------------------------

CODE_00E44E:
	LDA.w $021A
	SEC
	SBC.b #$04
	STA.w $021A
	LDA.w $03AE
	SEC
	SBC.b #$04
	STA.w $03AE
	LDA.b #$08
	STA.w $0F7D
	STZ.w $021D
	LDA.b #!Define_SMAS_Sound0061_Jump
	STA.w !RAM_SMBLL_Global_SoundCh2
	LDA.b #$FE
	STA.w $00A1
	STZ.w $043D
	STZ.w $041D
	STZ.w $0BA0
	RTS

;--------------------------------------------------------------------

CODE_00E47C:
	LDA.w $021A
	SEC
	SBC.b #$04
	STA.w $021A
	LDA.w $03AE
	SEC
	SBC.b #$04
	STA.w $03AE
	STA.w $0BB0
	STA.w $0BB1
	STA.w $0BB2
	STA.w $0BB3
	LDA.b #!Define_SMAS_Sound0061_Jump
	STA.w !RAM_SMBLL_Global_SoundCh2
	LDA.b #$FE
	STA.w $00A1
	STZ.w $043D
	STZ.w $041D
	STZ.w $0E67
	RTS

;--------------------------------------------------------------------

CODE_00E4AE:
	LDA.w $021A
	SEC
	SBC.b #$0C
	STA.w $021A
	LDA.w $0238
	SEC
	SBC.b #$0C
	STA.w $0238
	LDA.b #!Define_SMAS_Sound0061_Jump
	STA.w !RAM_SMBLL_Global_SoundCh2
	LDA.b #$FE
	STA.w $0B9E
	STA.w $00A1
	STZ.w $043D
	STZ.w $041D
	RTS

;--------------------------------------------------------------------

CODE_00E4D4:
	LDA.w $021A
	SEC
	SBC.b #$0C
	STA.w $021A
	LDA.b #!Define_SMAS_Sound0061_Jump
	STA.w !RAM_SMBLL_Global_SoundCh2
	LDA.b #$FD
	STA.w $00A1
	STZ.w $043D
	STZ.w $041D
	RTS

;--------------------------------------------------------------------

CODE_00E4EE:
	STZ.w !RAM_SMBLL_Global_SoundCh1
	LDA.b #$FE
	STA.w $00A1
	STZ.w $043D
	STZ.w $041D
	RTS

;--------------------------------------------------------------------

CODE_00E4FD:
	REP.b #$20
	SEC
	SBC.w #$0008
	SEC
	SBC.w $0042
	STA.b $01
	SEP.b #$20
	STA.w $0900,y
	STA.w $0908,y
	LDA.b #$2D
	STA.w $0903,y
	STA.w $090B,y
	XBA
	CMP.b #$00
	BEQ.b CODE_00E520
	LDA.b #$01
CODE_00E520:
	ORA.b #$02
	STA.w $0D00,y
	STA.w $0D08,y
	RTS

;--------------------------------------------------------------------

CODE_00E529:
	LDA.w $03CE
	CMP.b #$D0
	BCC.b CODE_00E542
	AND.b #$08
	BEQ.b CODE_00E542
	LDA.w $03CE
	SEC
	SBC.b #$08
	STA.w $03CE
	LDA.b #$30
	STA.w $0BA6
CODE_00E542:
	RTS

;--------------------------------------------------------------------

CODE_00E543:
	LDA.w $0EEE
	BEQ.b CODE_00E54C
	DEC.w $0EEE
	RTS

CODE_00E54C:
	LDA.w $0BA3
	CMP.b #$C0
	BCS.b CODE_00E561
	INC.w $0BA3
	LDA.w $0BA3
	CMP.b #$C0
	BNE.b CODE_00E560
	JSR.w CODE_00E574
CODE_00E560:
	RTS

CODE_00E561:
	JSL.l CODE_0E8171
	RTS

;--------------------------------------------------------------------

CODE_00E566:
	LDA.w $0BA4
	BNE.b CODE_00E573
	LDA.b #!Define_SMAS_Sound0061_Jump
	STA.w !RAM_SMBLL_Global_SoundCh2
	STA.w $0BA4
CODE_00E573:
	RTS

;--------------------------------------------------------------------

CODE_00E574:
	REP.b #$20
	PHD
	LDA.w #$1700
	TCD
	LDA.w #$F15A
	STA.b $1702
	LDA.w #$1300
	STA.b $1704
	LDA.w #$0019
	STA.b $1706
	LDA.w #$001E
	STA.b $1708
	LDA.w #$001C
	STA.b $170A
	LDA.w #$0011
	STA.b $170C
	LDA.w #$0028
	STA.b $170E
	LDA.w #$001C
	STA.b $1710
	LDA.w #$001D
	STA.b $1712
	LDA.w #$000A
	STA.b $1714
	LDA.w #$001B
	STA.b $1716
	LDA.w #$001D
	STA.b $1718
	SEP.b #$20
	LDA.b #$FF
	STA.b $171A
	PLD
	LDA.b #!Define_SMAS_Sound0063_OverworldTileReveal
	STA.w !RAM_SMBLL_Global_SoundCh3
	RTS
;%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro SMBLLBank04Macros(StartBank, EndBank)
;%BANK_START(<StartBank>)
CODE_048000:
	PHD
	LDA.b #$24
	STA.b $00
	STZ.w !REGISTER_VRAMAddressIncrementValue
	REP.b #$20
	LDA.w #DMA[$00].Parameters
	TCD
	LDA.w #$0800
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$08
	STA.b DMA[$00].Parameters
	STZ.b DMA[$00].SourceLo
	STZ.b DMA[$00].SourceBank
	LDA.w #$0400
	STA.b DMA[$00].SizeLo
	LDY.b #$01
	STY.w !REGISTER_DMAEnable
	STA.b DMA[$00].SizeLo
	LDA.w #$0800
	STA.w !REGISTER_VRAMAddressLo
	STZ.w $0000
	LDX.b #$80
	STX.w !REGISTER_VRAMAddressIncrementValue
	LDX.b #!REGISTER_WriteToVRAMPortHi
	STX.b DMA[$00].Destination
	STY.w !REGISTER_DMAEnable
	LDX.b #$24
	STX.w $0000
	STZ.w !REGISTER_VRAMAddressIncrementValue
	LDA.w #$0000
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$08
	STA.b DMA[$00].Parameters
	STZ.b DMA[$00].SourceLo
	STZ.b DMA[$00].SourceBank
	LDA.w #$0800
	STA.b DMA[$00].SizeLo
	STY.w !REGISTER_DMAEnable
	STA.b DMA[$00].SizeLo
	LDA.w #$0000
	STA.w !REGISTER_VRAMAddressLo
	STZ.w $0000
	LDX.b #$80
	STX.w !REGISTER_VRAMAddressIncrementValue
	LDX.b #!REGISTER_WriteToVRAMPortHi
	STX.b DMA[$00].Destination
	STY.w !REGISTER_DMAEnable
	LDX.b #$28
	STX.w $0000
	STZ.w !REGISTER_VRAMAddressIncrementValue
	LDA.w #$5878
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$08
	STA.b DMA[$00].Parameters
	STZ.b DMA[$00].SourceLo
	STZ.b DMA[$00].SourceBank
	LDA.w #$0788
	STA.b DMA[$00].SizeLo
	STY.w !REGISTER_DMAEnable
	STA.b DMA[$00].SizeLo
	LDA.w #$5878
	STA.w !REGISTER_VRAMAddressLo
	STZ.w $0000
	LDX.b #$80
	STX.w !REGISTER_VRAMAddressIncrementValue
	LDX.b #!REGISTER_WriteToVRAMPortHi
	STX.b DMA[$00].Destination
	STY.w !REGISTER_DMAEnable
	SEP.b #$20
	PLD
	RTL

;--------------------------------------------------------------------

CODE_0480AE:
	LDA.b #$28
	STA.b $00
	STZ.w !REGISTER_VRAMAddressIncrementValue
	REP.b #$20
	LDA.w #$5800
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$08
	STA.w DMA[$00].Parameters
	STZ.w DMA[$00].SourceLo
	STZ.w DMA[$00].SourceBank
	LDA.w #$0200
	STA.w DMA[$00].SizeLo
	LDY.b #$01
	STY.w !REGISTER_DMAEnable
	STA.w DMA[$00].SizeLo
	LDA.w #$5800
	STA.w !REGISTER_VRAMAddressLo
	SEP.b #$20
	STZ.b $00
	LDA.b #$80
	STA.w !REGISTER_VRAMAddressIncrementValue
	LDA.b #!REGISTER_WriteToVRAMPortHi
	STA.w DMA[$00].Destination
	STY.w !REGISTER_DMAEnable
	RTL

;--------------------------------------------------------------------

CODE_0480EF:
	PHD
	LDA.b #$27
	STA.b $00
	STZ.w !REGISTER_VRAMAddressIncrementValue
	REP.b #$20
	LDA.w #DMA[$00].Parameters
	TCD
	LDA.w #$0000
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$08
	STA.b DMA[$00].Parameters
	STZ.b DMA[$00].SourceLo
	STZ.b DMA[$00].SourceBank
	LDA.w #$0400
	STA.b DMA[$00].SizeLo
	LDY.b #$01
	STY.w !REGISTER_DMAEnable
	STA.b DMA[$00].SizeLo
	LDA.w #$0000
	STA.w !REGISTER_VRAMAddressLo
	LDX.b #$0C
	STX.w $0000
	LDX.b #$80
	STX.w !REGISTER_VRAMAddressIncrementValue
	LDX.b #!REGISTER_WriteToVRAMPortHi
	STX.b DMA[$00].Destination
	STY.b !REGISTER_DMAEnable				; Glitch: This writes to open bus, not !REGISTER_DMAEnable!
	LDX.b #$24
	STX.w $0000
	STZ.w !REGISTER_VRAMAddressIncrementValue
	LDA.w #$0800
	STA.w !REGISTER_VRAMAddressLo
	STZ.b DMA[$00].SourceLo
	STZ.b DMA[$00].SourceBank
	LDA.w #$0400
	STA.b DMA[$00].SizeLo
	STY.w !REGISTER_DMAEnable
	STA.b DMA[$00].SizeLo
	LDA.w #$0800
	STA.w !REGISTER_VRAMAddressLo
	SEP.b #$20
	STZ.w $0000
	LDA.b #$80
	STA.w !REGISTER_VRAMAddressIncrementValue
	LDA.b #!REGISTER_WriteToVRAMPortHi
	STA.b DMA[$00].Destination
	STY.w !REGISTER_DMAEnable
	PLD
	RTL

;--------------------------------------------------------------------

CODE_048163:
	LDA.w !RAM_SMBLL_Global_SoundCh1
	BNE.b CODE_04817C
	LDA.w !REGISTER_APUPort0
	CMP.w $1604
	BEQ.b CODE_04817A
	INC.w $160A
	LDA.w $160A
	CMP.b #$03
	BCC.b CODE_048185
CODE_04817A:
	LDA.b #$00
CODE_04817C:
	STA.w !REGISTER_APUPort0
	STA.w $1604
	STZ.w $160A
CODE_048185:
	LDA.w !RAM_SMBLL_Global_SoundCh2
	BNE.b CODE_0481A0
	LDA.w !REGISTER_APUPort1
	AND.b #$0F
	CMP.w $1605
	BEQ.b CODE_04819E
	INC.w $160B
	LDA.w $160B
	CMP.b #$03
	BCC.b CODE_0481AB
CODE_04819E:
	LDA.b #$00
CODE_0481A0:
	STA.w !REGISTER_APUPort1
	AND.b #$0F
	STA.w $1605
	STZ.w $160B
CODE_0481AB:
	LDA.w !RAM_SMBLL_Global_MusicCh1
	BEQ.b CODE_048226
	LDY.b #$04
	STY.w $160C
	STA.w !REGISTER_APUPort2
	CMP.b #!Define_SMBLL_LevelMusic_StopMusicCommand
	BCS.b CODE_0481BF
	STA.w $1606
CODE_0481BF:
	LDA.w !RAM_SMBLL_Global_SoundCh3
	BNE.b CODE_0481E5
	LDA.w !REGISTER_APUPort3
	AND.b #$7F
	CMP.w $1607
	BEQ.b CODE_0481D8
	INC.w $160D
	LDA.w $160D
	CMP.b #$03
	BCC.b CODE_048209
CODE_0481D8:
	LDA.b #$00
	STA.w !REGISTER_APUPort3
	STA.w $1607
	STZ.w $160D
	BRA.b CODE_048209

CODE_0481E5:
	STA.w $1607
	CMP.b #!Define_SMAS_Sound0063_Coin
	BEQ.b CODE_0481F8
	CMP.b #!Define_SMAS_Sound0063_1up
	BEQ.b CODE_0481F8
	CMP.b #!Define_SMAS_Sound0063_ShootFireball
	BEQ.b CODE_0481F8
	CMP.b #!Define_SMAS_Sound0063_CannonShoot
	BNE.b CODE_048216
CODE_0481F8:
	ORA.w $160F
	STA.w !REGISTER_APUPort3
	LDA.w $160F
	EOR.b #$80
	STA.w $160F
	STZ.w $160D
CODE_048209:
	STZ.w !RAM_SMBLL_Global_SoundCh1
	STZ.w !RAM_SMBLL_Global_SoundCh2
	STZ.w !RAM_SMBLL_Global_MusicCh1
	STZ.w !RAM_SMBLL_Global_SoundCh3
	RTL

CODE_048216:
	STA.w !REGISTER_APUPort3
	STZ.w !RAM_SMBLL_Global_SoundCh1
	STZ.w !RAM_SMBLL_Global_SoundCh2
	STZ.w !RAM_SMBLL_Global_MusicCh1
	STZ.w !RAM_SMBLL_Global_SoundCh3
	RTL

CODE_048226:
	LDY.w !REGISTER_APUPort2
	CPY.w $1606
	BNE.b CODE_0481BF
	DEC.w $160C
	LDA.w $160C
	BNE.b CODE_0481BF
	INC.w $160C
	STA.w !REGISTER_APUPort2
	BRA.b CODE_0481BF

;--------------------------------------------------------------------

DATA_04823E:
	dw $0000,$0000,$0031,$0000

DATA_048246:
	dw $0000,$0010,$0020,$0030

DATA_04824E:
	dw $0031,$0031,$0031,$0031

DATA_048256:
	dw $0010,$0010,$0010,$0010

SMB1_InitializeGradientHDMA:
.Main:
;$04825E
	STZ.w !REGISTER_HDMAEnable
	STZ.w !RAM_SMBLL_Global_HDMAEnableMirror
	STZ.w $1207
	STZ.w $1208
	STZ.w $1204
	STZ.w $1205
	STZ.w $1206
	STZ.w $1209
	LDX.b #$20
	STX.w $120A
	CMP.b #$FF
	BNE.b CODE_048280
	RTL

CODE_048280:
	PHB
	PHK
	PLB
	STA.b $00
	ASL
	TAY
	PHY
	LDA.w DATA_04824E,y
	STA.b $01
	LDX.w DATA_04823E,y
	LDY.b #$00
CODE_048292:
	LDA.w DATA_0483AC,x
	STA.w $1520,y
	LDA.w DATA_04840E,x
	STA.w $1560,y
	LDA.w DATA_048470,x
	STA.w $15A0,y
	INX
	INY
	CPY.b $01
	BNE.b CODE_048292
	PLY
	LDA.w DATA_048256,y
	STA.b $01
	LDX.w DATA_048246,y
	LDY.b #$00
CODE_0482B5:
	LDA.w DATA_0484D2,x
	STA.w $1400,y
	LDA.w DATA_048512,x
	STA.w $1460,y
	LDA.w DATA_048552,x
	STA.w $14C0,y
	INX
	INY
	CPY.b $01
	BNE.b CODE_0482B5
	REP.b #$10
	LDX.w #(!REGISTER_FixedColorData&$0000FF<<8)+$40
	STX.w HDMA[$05].Parameters
	STX.w HDMA[$06].Parameters
	STX.w HDMA[$07].Parameters
	LDX.w #$1520
	STX.w HDMA[$05].SourceLo
	LDX.w #$1560
	STX.w HDMA[$06].SourceLo
	LDX.w #$15A0
	STX.w HDMA[$07].SourceLo
	LDA.b #$00
	STA.w HDMA[$05].SourceBank
	STA.w HDMA[$06].SourceBank
	STA.w HDMA[$07].SourceBank
	LDA.b #$00
	STA.w HDMA[$05].IndirectSourceBank
	LDA.b #$00
	STA.w HDMA[$06].IndirectSourceBank
	LDA.b #$00
	STA.w HDMA[$07].IndirectSourceBank
	LDA.b #$01
	STA.w $15E0
	LDA.b $00
	CMP.b #$02
	BNE.b CODE_048357
	LDX.w #(!REGISTER_Window2LeftPositionDesignation&$0000FF<<8)+$41
	STX.w HDMA[$04].Parameters
	LDX.w #DATA_0483A5
	STX.w HDMA[$04].SourceLo
	LDA.b #DATA_0483A5>>16
	STA.w HDMA[$04].SourceBank
	LDA.b #DATA_0483A5>>16
	STA.w HDMA[$04].IndirectSourceBank
	LDA.b #$17
	STA.w $1207
	STZ.w $1208
	STZ.w $1204
	STZ.w $1205
	LDA.b #$80
	STA.w $1206
	LDA.b #$10
	STA.w $1209
	LDA.b #$33
	STA.w $120A
	LDA.b #$F0
	STA.w !RAM_SMBLL_Global_HDMAEnableMirror
	STZ.w $1000
	STZ.w $1001
	INC.w !RAM_SMBLL_Global_UpdateEntirePaletteFlag
	SEP.b #$10
	PLB
	RTL

CODE_048357:
	LDA.b #$E0
	STA.w !RAM_SMBLL_Global_HDMAEnableMirror
	SEP.b #$10
	PLB
	RTL

;--------------------------------------------------------------------

DATA_048360:
	db $00,$03,$06,$09,$09,$06,$03,$00

DATA_048368:
	db $0C,$0C,$0C,$1C,$0C,$0C,$0C,$1C

DATA_048370:
	db $01,$01,$01,$01,$FF,$FF,$FF,$FF

SMB1_AdjustUnderwaterHDMAGradient:
.Main:
;$048378
	PHB
	PHK
	PLB
	DEC.w $15E0
	BNE.b CODE_0483A3
	LDX.w $15E2
	LDA.w DATA_048368,x
	STA.w $15E0
	LDY.w DATA_048360,x
	LDA.w $1520,y
	CLC
	ADC.w DATA_048370,x
	STA.w $1520,y
	STA.w $1560,y
	STA.w $15A0,y
	INX
	TXA
	AND.b #$07
	STA.w $15E2
CODE_0483A3:
	PLB
	RTL

;--------------------------------------------------------------------

DATA_0483A5:
	db $27 : dw DATA_048592
	db $02 : dw DATA_048594
	db $00

DATA_0483AC:
	db $40,$00,$14,$08,$01,$14,$08,$02,$14,$08,$03,$14,$06,$04,$14,$06
	db $05,$14,$06,$06,$14,$06,$07,$14,$08,$08,$14,$04,$09,$14,$04,$0A
	db $14,$04,$0B,$14,$04,$0C,$14,$04,$0D,$14,$03,$0E,$14,$01,$0F,$14
	db $00,$20,$00,$14,$02,$01,$14,$02,$02,$14,$03,$03,$14,$03,$04,$14
	db $04,$05,$14,$04,$06,$14,$05,$07,$14,$06,$08,$14,$07,$09,$14,$08
	db $0A,$14,$09,$0B,$14,$0A,$0C,$14,$0B,$0D,$14,$0C,$0E,$14,$01,$0F
	db $14,$00

DATA_04840E:
	db $40,$60,$14,$08,$61,$14,$08,$62,$14,$08,$63,$14,$06,$64,$14,$06
	db $65,$14,$06,$66,$14,$06,$67,$14,$08,$68,$14,$04,$69,$14,$04,$6A
	db $14,$04,$6B,$14,$04,$6C,$14,$04,$6D,$14,$03,$6E,$14,$01,$6F,$14
	db $00,$20,$60,$14,$02,$61,$14,$02,$62,$14,$03,$63,$14,$03,$64,$14
	db $04,$65,$14,$04,$66,$14,$05,$67,$14,$06,$68,$14,$07,$69,$14,$08
	db $6A,$14,$09,$6B,$14,$0A,$6C,$14,$0B,$6D,$14,$0C,$6E,$14,$01,$6F
	db $14,$00

DATA_048470:
	db $40,$C0,$14,$08,$C1,$14,$08,$C2,$14,$08,$C3,$14,$06,$C4,$14,$06
	db $C5,$14,$06,$C6,$14,$06,$C7,$14,$08,$C8,$14,$04,$C9,$14,$04,$CA
	db $14,$04,$CB,$14,$04,$CC,$14,$04,$CD,$14,$03,$CE,$14,$01,$CF,$14
	db $00,$20,$C0,$14,$02,$C1,$14,$02,$C2,$14,$03,$C3,$14,$03,$C4,$14
	db $04,$C5,$14,$04,$C6,$14,$05,$C7,$14,$06,$C8,$14,$07,$C9,$14,$08
	db $CA,$14,$09,$CB,$14,$0A,$CC,$14,$0B,$CD,$14,$0C,$CE,$14,$01,$CF
	db $14,$00

DATA_0484D2:
	db $2A,$2B,$2C,$2D,$2E,$2F,$30,$31,$32,$33,$34,$35,$36,$37,$38,$38
	db $27,$26,$25,$24,$23,$22,$21,$20,$20,$20,$20,$20,$20,$20,$20,$20
	db $38,$2B,$2A,$29,$28,$27,$26,$25,$24,$23,$22,$21,$20,$20,$20,$20
	db $3A,$3B,$3C,$3D,$3E,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F

DATA_048512:
	db $51,$52,$53,$54,$55,$56,$57,$58,$59,$5A,$5B,$5C,$5D,$5E,$5F,$5F
	db $47,$46,$45,$44,$43,$42,$41,$40,$40,$40,$40,$40,$40,$40,$40,$40
	db $5F,$51,$50,$4F,$4E,$4D,$4C,$4B,$4A,$49,$48,$47,$46,$45,$44,$43
	db $5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F,$5F

DATA_048552:
	db $94,$95,$96,$97,$98,$99,$9A,$9B,$9C,$9D,$9E,$9F,$9F,$9F,$9F,$9F
	db $8D,$8C,$8B,$8A,$89,$88,$87,$86,$85,$84,$83,$82,$81,$80,$80,$80
	db $9F,$9C,$9B,$9A,$99,$98,$97,$96,$95,$94,$93,$92,$91,$90,$8F,$8E
	db $9F,$9F,$9F,$9F,$9F,$9F,$9F,$9F,$9F,$9F,$9F,$9F,$9F,$9F,$9F,$9F

DATA_048592:
	db $FF,$00

DATA_048594:
	db $00,$FF

;--------------------------------------------------------------------

CODE_048596:
	INC.w $075A
	LDA.w $075A
	CMP.b #$80
	BCC.b CODE_0485A5
	LDA.b #$7F
	STA.w $075A
CODE_0485A5:
	RTL
;%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro SMBLLBank07Macros(StartBank, EndBank)
;%BANK_START(<StartBank>)
SMBLL_UncompressedGFX_Sprite_GlobalTiles:
;$078000
	incbin "../SMB1/Graphics/GFX_Sprite_GlobalTiles.bin"
;%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro SMBLLBank08Macros(StartBank, EndBank)
%BANK_START(<StartBank>)
SMBLL_UncompressedGFX_BG_Underwater:
;$088000
	incbin "../SMB1/Graphics/GFX_BG_Underwater.bin"

SMBLL_UncompressedGFX_BG_Mushrooms:
;$089000
	incbin "../SMB1/Graphics/GFX_BG_Mushrooms.bin"

SMBLL_UncompressedGFX_BG_DottedHills:
;$089800
	incbin "../SMB1/Graphics/GFX_BG_DottedHills.bin"

SMBLL_UncompressedGFX_BG_Castle:
;$08A000
	incbin "../SMB1/Graphics/GFX_BG_Castle.bin"

SMBLL_UncompressedGFX_BG_Waterfalls:
;$08B000
	incbin "../SMB1/Graphics/GFX_BG_Waterfalls.bin"

SMBLL_UncompressedGFX_BG_Pillars:
;$08B800
	incbin "../SMB1/Graphics/GFX_BG_Pillars.bin"

SMBLL_UncompressedGFX_FG_Snow:
;$08C000
	incbin "../SMB1/Graphics/GFX_FG_Snow.bin"

SMBLL_UncompressedGFX_BG_DeathScreen1:
;$08D000
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMBLL_J) != $00
	incbin "../SMB1/Graphics/GFX_BG_DeathScreen1_SMAS_J.bin"
else
	incbin "../SMB1/Graphics/GFX_BG_DeathScreen1_SMAS_U.bin"
endif

SMBLL_UncompressedGFX_BG_BonusRoom:
.Mario:
;$08E000
	incbin "../SMB1/Graphics/GFX_BG_BonusRoomMario.bin"
.Luigi:
;$08F000
	incbin "../SMB1/Graphics/GFX_BG_BonusRoomLuigi.bin"
%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro SMBLLBank09Macros(StartBank, EndBank)
%BANK_START(<StartBank>)
SMBLL_UncompressedGFX_BG_Cave:
;$098000
	incbin "../SMB1/Graphics/GFX_BG_Cave.bin"

SMBLL_UncompressedGFX_BG_UnderwaterCastle:
;$099000
	incbin "../SMB1/Graphics/GFX_BG_UnderwaterCastle.bin"

SMBLL_UncompressedGFX_FG_BG_Castle:
;$09A000
	incbin "../SMB1/Graphics/GFX_FG_BG_Castle.bin"

SMBLL_UncompressedGFX_FG_Grassland:
;$09C000
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMBLL_J) != $00
	incbin "../SMB1/Graphics/GFX_FG_Grassland_SMAS_J.bin"
else
	incbin "../SMB1/Graphics/GFX_FG_Grassland_SMAS_U.bin"
endif

SMBLL_UncompressedGFX_FG_Cave:
;$09D000
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMBLL_J) != $00
	incbin "../SMB1/Graphics/GFX_FG_Cave_SMAS_J.bin"
else
	incbin "../SMB1/Graphics/GFX_FG_Cave_SMAS_U.bin"
endif

SMBLL_UncompressedGFX_BG_Night:
;$09E000
	incbin "../SMB1/Graphics/GFX_BG_Night.bin"

SMBLL_UncompressedGFX_BG_FinalCastle1:
;$09E800
	incbin "../SMB1/Graphics/GFX_BG_FinalCastle1.bin"

SMBLL_UncompressedGFX_BG_FinalCastle2:
;$09F000
	incbin "../SMB1/Graphics/GFX_BG_FinalCastle2.bin"

SMBLL_UncompressedGFX_BG_DeathScreen2:
;$09F800
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMBLL_J) != $00
	incbin "../SMB1/Graphics/GFX_BG_DeathScreen2_SMAS_J.bin"
else
	incbin "../SMB1/Graphics/GFX_BG_DeathScreen2_SMAS_U.bin"
endif
%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro SMBLLBank0AMacros(StartBank, EndBank)
%BANK_START(<StartBank>)

SMBLL_UncompressedGFX_Player:
;$0A8000
.Mario:
	incbin "../SMB1/Graphics/GFX_Player_Mario.bin"
.Luigi:
	incbin "../SMB1/Graphics/GFX_Player_Luigi.bin"
%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro SMBLLBank0CMacros(StartBank, EndBank)
;%BANK_START(<StartBank>)
SMBLL_UncompressedGFX_Layer3:
;$0CF800
	incbin "../SMB1/Graphics/GFX_Layer3.bin"
;%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro SMBLLBank0DMacros(StartBank, EndBank)
%BANK_START(<StartBank>)
SMBLL_InitAndMainLoop_Main:
	JMP.w SMASSMBLLReset

SMBLL_InitAndMainLoop_NMIVector:
	JMP.w SMBLL_VBlankRoutine_Main

SMBLL_InitAndMainLoop_IRQVector:
	JMP.w SMBLL_IRQRoutine_Main

CODE_0D8009:
	JML.l SMBLL_DisplayCopyDetectionErrorMessage_Main				; Note: Call to SMAS function

SMASSMBLLReset:
if !Define_Global_ROMToAssemble&(!ROM_SMBLL_U|!ROM_SMBLL_E|!ROM_SMBLL_J) != $00
	SEI
	CLC
	XCE
	STZ.w !REGISTER_IRQNMIAndJoypadEnableFlags
	STZ.w !REGISTER_DMAEnable
	STZ.w !REGISTER_HDMAEnable
	LDA.b #$80
	STA.w !REGISTER_ScreenDisplayRegister
	REP.b #$20
	LDA.w #!RAM_SMBLL_Global_StartOfStack
	TCS
	LDA.w #!RAM_SMBLL_Global_ScratchRAM00
	TCD
	SEP.b #$20
endif
if !Define_SMAS_Global_DisableCopyDetection == !FALSE
	NOP #2
	LDA.b #$AA
	STA.l !SRAM_SMAS_Global_CopyDetectionCheck2
	CMP.l !SRAM_SMAS_Global_CopyDetectionCheck1
	BNE.b CODE_0D8009
	LDA.b #$55
	STA.l !SRAM_SMAS_Global_CopyDetectionCheck2
	CMP.l !SRAM_SMAS_Global_CopyDetectionCheck1
	BNE.b CODE_0D8009
endif
if !Define_Global_ROMToAssemble&(!ROM_SMBLL_U|!ROM_SMBLL_E|!ROM_SMBLL_J) != $00
	LDA.w !REGISTER_PPUStatusFlag2
	BIT.b #!PPUStatusFlag2_ConsoleRegion
if !Define_Global_ROMToAssemble&(!ROM_SMBLL_E) != $00
	BNE.b +
else
	BEQ.b +
endif
	JML.l SMBLL_DisplayRegionErrorMessage_Main

+:
	JSL.l SMBLL_UploadSPCEngine_Main
	JSL.l SMBLL_InitializeRAMOnStartup_Main
	JSL.l SMBLL_VerifySaveDataIsValid_Main
	JSL.l SMBLL_UploadMainSampleData_Main
	JSL.l SMBLL_LoadSplashScreen_Main
	JSL.l SMBLL_UploadMusicBank_Main
else
	SEI
	STZ.w !REGISTER_IRQNMIAndJoypadEnableFlags
	STZ.w !REGISTER_DMAEnable
	STZ.w !REGISTER_HDMAEnable
	LDA.b #!ScreenDisplayRegister_SetForceBlank|!ScreenDisplayRegister_MinBrightness00
	STA.w !REGISTER_ScreenDisplayRegister
endif
	PHK
	PLB
	JSL.l CODE_0E8000
	JSL.l CODE_0480AE				; Note: Call to SMB1 function
	JSR.w CODE_0D841C
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) == $00
	STZ.w $1608
	STZ.w $1609
	STZ.w $160F
	STZ.w $160E
	STZ.w $160A
	STA.w $160D
	LDA.b #$01
	STA.w $160C
endif
	LDA.b #$81
	STA.b $09
	STA.w !REGISTER_IRQNMIAndJoypadEnableFlags
	CLI
CODE_0D8062:
	LDA.w $0154
	BEQ.b CODE_0D8062
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMBLL_J) != $00
	JSL.l CODE_0D96A8
else
	JSR.w CODE_0D96A8
endif
	LDA.w $07B7
	AND.b #$02
	STA.w $07C7
	LDA.w $07B8
	AND.b #$02
	EOR.w $07C7
	CLC
	BEQ.b CODE_0D807E
	SEC
CODE_0D807E:
	ROR.w $07B7
	ROR.w $07B8
	ROR.w $07B9
	ROR.w $07BA
	ROR.w $07BB
	ROR.w $07BC
	ROR.w $07BD
	JSL.l CODE_048163				; Note: Call to SMB1 function
	LDA.l !SRAM_SMAS_Global_EnableSMASDebugModeFlag
	BEQ.b CODE_0D80B8
	LDA.w $0FFA
	AND.b #$20
	BEQ.b CODE_0D80A7
	INC.w $15E5
CODE_0D80A7:
	LDA.w $0FFA
	AND.b #$10
	BNE.b CODE_0D80B8
	LDA.w $15E5
	AND.b #$01
	BEQ.b CODE_0D80B8
	JMP.w CODE_0D817F

CODE_0D80B8:
	LDA.w $0B76
	BNE.b CODE_0D80C1
	JSL.l CODE_0FF000
CODE_0D80C1:
	JSL.l CODE_0FD94F
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMBLL_J) != $00
	JSL.l CODE_0D98F2
else
	JSR.w CODE_0D98F2
endif
	LDA.b $5C
	BNE.b CODE_0D80D0
	JSL.l CODE_0E834E
CODE_0D80D0:
	LDA.w $0ED6
	BMI.b CODE_0D80F0
	BEQ.b CODE_0D810A
	LDA.w $07B0
	BEQ.b CODE_0D810A
	LDA.w $0FFA
	BMI.b CODE_0D80E8
	LDA.w $0FF6
	AND.b #$90
	BEQ.b CODE_0D810A
CODE_0D80E8:
	STZ.w $07B0
	STZ.w $0ED6
	BRA.b CODE_0D810A

CODE_0D80F0:
if !Define_Global_ROMToAssemble&(!ROM_SMBLL_U|!ROM_SMBLL_E|!ROM_SMBLL_J) == $00
	LDA.w $0FFA
	ORA.w $0FF6
	AND.b #$40
	BEQ.b CODE_0D810A
	LDA.w !RAM_SMBLL_Global_ScreenDisplayRegisterMirror
	CMP.b #$0F
	BNE.b CODE_0D810A
	LDA.b #!Define_SMBLL_LevelMusic_MusicFade
	STA.w !RAM_SMBLL_Global_MusicCh1
	JML.l SMAS_ResetToSMASTitleScreen_Main				; Note: Call to SMAS function
endif

CODE_0D810A:
	LDA.w $0E7F
	BEQ.b CODE_0D8114
	JSR.w CODE_0DC089
	BRA.b CODE_0D817F

CODE_0D8114:
	LDA.w $0776
	LSR
	BCS.b CODE_0D8178
	PHD
	LDA.b #$0700>>8
	XBA
	LDA.b #$0700
	TCD
	LDA.b $0747
	BEQ.b CODE_0D8129
	DEC.b $0747
	BNE.b CODE_0D813E
CODE_0D8129:
	LDX.b #$18
	DEC.b $0787
	BPL.b CODE_0D8135
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDA.b #$11
else
	LDA.b #$14
endif
	STA.b $0787
	LDX.b #$2B
CODE_0D8135:
	LDA.b $0788,x
	BEQ.b CODE_0D813B
	DEC.b $0788,x
CODE_0D813B:
	DEX
	BPL.b CODE_0D8135
CODE_0D813E:
	PLD
	LDA.w $07B0
	BNE.b CODE_0D814C
	LDA.w $0ED6
	AND.b #$80
	STA.w $0ED6
CODE_0D814C:
	INC.b $09
	INC.w $0E68
	LDA.w $0E68
	AND.b #$18
	CMP.b #$18
	BNE.b CODE_0D815D
	STZ.w $0E68
CODE_0D815D:
	JSL.l CODE_0FE26D
	LDA.w $0722
	BEQ.b CODE_0D816E
	LDA.b $1B
	LSR
	BCS.b CODE_0D816E
	JSR.w CODE_0D83EC
CODE_0D816E:
	JSR.w CODE_0D83D8
	LDA.w $1680
	BMI.b CODE_0D8178
	BRA.b CODE_0D817F

CODE_0D8178:
	JSR.w CODE_0D841C
	JSL.l CODE_0FDA33
CODE_0D817F:
	JSL.l SMBLL_CompressOAMTileSizeBuffer_Main
	STZ.w $0154
	JMP.w CODE_0D8062

;--------------------------------------------------------------------

DATA_0D8189:
	dw $0000,$0300

SMBLL_VBlankRoutine:
.Main:
;$0D818D
if !Define_Global_ROMToAssemble&(!ROM_SMBLL_U|!ROM_SMBLL_E|!ROM_SMBLL_J) != $00
	SEI
	REP.b #$30
	PHA
	PHX
	PHY
	PHD
	LDA.w #!RAM_SMBLL_Global_ScratchRAM00
	TCD
	LDA.b !RAM_SMBLL_Global_ScratchRAM00
	PHA
	SEP.b #$30
endif
	PHB
	PHK
	PLB
	LDA.w !REGISTER_NMIEnable
	LDA.w !RAM_SMBLL_Global_ScreenDisplayRegisterMirror
	BNE.b CODE_0D819A
	LDA.b #!ScreenDisplayRegister_SetForceBlank|!ScreenDisplayRegister_MinBrightness00
CODE_0D819A:
	STA.w !REGISTER_ScreenDisplayRegister
	STZ.w !REGISTER_HDMAEnable
	LDA.w $0154
	BEQ.b CODE_0D81A8
	JMP.w CODE_0D82EA

CODE_0D81A8:
	INC.w $0154
	LDX.w $0773
	LDA.w $0753
	BEQ.b CODE_0D81C5
	CPX.b #$0C
	BNE.b CODE_0D81B9
	LDX.b #$1F
CODE_0D81B9:
	CPX.b #$10
	BNE.b CODE_0D81BF
	LDX.b #$20
CODE_0D81BF:
	CPX.b #$13
	BNE.b CODE_0D81C5
	LDX.b #$21
CODE_0D81C5:
	LDA.l DATA_0FF391,x
	STA.b $00
	LDA.l DATA_0FF3B3,x
	STA.b $01
	LDA.b #DATA_0FF69F>>16
	STA.w DMA[$01].SourceBank
	STA.b $02
	JSR.w CODE_0D977C
	LDX.w $0773
	CPX.b #$06
	BNE.b CODE_0D81F8
	LDA.l DATA_0FF391
	STA.b $00
	LDA.l DATA_0FF3B3
	STA.b $01
	LDA.b #DATA_0FF69F>>16
	STA.w DMA[$01].SourceBank
	STA.b $02
	JSR.w CODE_0D977C
CODE_0D81F8:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	JSR.w CODE_0D98E3
endif
	PHD
	LDA.b #DMA[$00].Parameters>>8
	XBA
	LDA.b #DMA[$00].Parameters
	TCD
	REP.b #$10
	LDA.b #$81
	STA.w !REGISTER_VRAMAddressIncrementValue
	LDY.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STY.b DMA[$00].Parameters
	LDA.w $0EF9
	BEQ.b CODE_0D8243
	LDA.b #$7F
	STA.b DMA[$00].SourceBank
	REP.b #$20
	LDY.w #$0040
	LDX.w #$0000
	LDA.l $7F0002,x
CODE_0D8220:
	STA.w !REGISTER_VRAMAddressLo
	TXA
	CLC
	ADC.w #$0004
	STA.b DMA[$00].SourceLo
	STY.b DMA[$00].SizeLo
	TXA
	CLC
	ADC.w #$0042
	TAX
	LDA.w #$0001
	STA.w !REGISTER_DMAEnable
	LDA.l $7F0002,x
	BPL.b CODE_0D8220
	SEP.b #$20
	STZ.w $0EF9
CODE_0D8243:
	LDA.w $0ED4
	BEQ.b CODE_0D8276
	LDA.b #$7F
	STA.b DMA[$00].SourceBank
	REP.b #$20
	LDY.w #$0038
	LDX.w #$0000
	LDA.l $7F2002,x
CODE_0D8258:
	STA.w !REGISTER_VRAMAddressLo
	TXA
	CLC
	ADC.w #$2004
	STA.b DMA[$00].SourceLo
	STY.b DMA[$00].SizeLo
	TXA
	CLC
	ADC.w #$003A
	TAX
	LDA.w #$0001
	STA.w !REGISTER_DMAEnable
	LDA.l $7F2002,x
	BPL.b CODE_0D8258
CODE_0D8276:
	SEP.b #$30
	STZ.w $0ED4
	LDA.b #$80
	STA.w !REGISTER_VRAMAddressIncrementValue
	JSR.w CODE_0D96DD
	LDA.w !RAM_SMBLL_Global_UpdateEntirePaletteFlag
	BEQ.b CODE_0D82B3
	BMI.b CODE_0D82AE
	REP.b #$10
	STZ.w !REGISTER_CGRAMAddress
	LDY.w #(!REGISTER_WriteToCGRAMPort&$0000FF<<8)+$00
	STY.b DMA[$00].Parameters
	LDY.w #$001000
	STY.b DMA[$00].SourceLo
	LDA.b #$001000>>16
	STA.b DMA[$00].SourceBank
	LDY.w #$0200
	STY.b DMA[$00].SizeLo
	LDA.b #$01
	STA.w !REGISTER_DMAEnable
	SEP.b #$10
	STZ.w !RAM_SMBLL_Global_UpdateEntirePaletteFlag
	BRA.b CODE_0D82B3

CODE_0D82AE:
	LDA.b #$01
	STA.w !RAM_SMBLL_Global_UpdateEntirePaletteFlag
CODE_0D82B3:
	PLD
	LDY.b #$00
	LDX.w $0773
	CPX.b #$06
	BNE.b CODE_0D82BF
	INY
	INY
CODE_0D82BF:
	REP.b #$20
	LDA.w DATA_0D8189,y
	REP.b #$10
	TAX
	STZ.w $1700,x
	LDA.w #$FFFF
	STA.w $1702,x
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	STA.w $1620
endif
	LDA.w #$0000
	STA.l $7F0000
	LDA.b $5C
	AND.w #$00FF
	BEQ.b CODE_0D82E5
	LDA.w #$0000
	STA.l $7F2000
CODE_0D82E5:
	SEP.b #$30
	STZ.w $0773
CODE_0D82EA:
	LDA.w !RAM_SMBLL_Global_HDMAEnableMirror
	STA.w !REGISTER_HDMAEnable
	PHD
	LDA.b #!REGISTER_ScreenDisplayRegister>>8
	XBA
	LDA.b #!REGISTER_ScreenDisplayRegister
	TCD
	LDA.w $1209
	STA.b !REGISTER_ColorMathInitialSettings
	LDA.w $120A
	STA.b !REGISTER_ColorMathSelectAndEnable
	LDA.w $1204
	STA.b !REGISTER_BG1And2WindowMaskSettings
	LDA.w $1205
	STA.b !REGISTER_BG3And4WindowMaskSettings
	LDA.w $1206
	STA.b !REGISTER_ObjectAndColorWindowSettings
	LDA.w !RAM_SMBLL_Global_MainScreenLayersMirror
	STA.b !REGISTER_MainScreenLayers
	LDA.w !RAM_SMBLL_Global_SubScreenLayersMirror
	STA.b !REGISTER_SubScreenLayers
	LDA.w $1207
	STA.b !REGISTER_MainScreenWindowMask
	LDA.w $1208
	STA.b !REGISTER_SubScreenWindowMask
	LDA.w !RAM_SMBLL_Global_FixedColorData1Mirror
	STA.b !REGISTER_FixedColorData
	LDA.w !RAM_SMBLL_Global_FixedColorData2Mirror
	STA.b !REGISTER_FixedColorData
	LDA.w !RAM_SMBLL_Global_FixedColorData3Mirror
	STA.b !REGISTER_FixedColorData
	LDA.w !RAM_SMBLL_Global_BGModeAndTileSizeSettingMirror
	STA.b !REGISTER_BGModeAndTileSizeSetting
	LDA.w $0E7E
	STA.b !REGISTER_MosaicSizeAndBGEnable
	STZ.b !REGISTER_BG3HorizScrollOffset
	STZ.b !REGISTER_BG3HorizScrollOffset
	LDA.w $0ED1
	BEQ.b CODE_0D8350
	LDA.w $0EEE
	STA.b !REGISTER_BG2HorizScrollOffset
	LDA.w $0EEF
	STA.b !REGISTER_BG2HorizScrollOffset
CODE_0D8350:
	LDA.w $0E7F
	BNE.b CODE_0D837F
	LDA.w $073F
	STA.b !REGISTER_BG1HorizScrollOffset
	LDA.w $071A
	STA.b !REGISTER_BG1HorizScrollOffset
	LDA.w $0ED1
	BNE.b CODE_0D836E
	LDA.w $0EFD
	STA.b !REGISTER_BG2HorizScrollOffset
	LDA.w $0EFE
	STA.b !REGISTER_BG2HorizScrollOffset
CODE_0D836E:
	LDA.w $0740
	STA.b !REGISTER_BG1VertScrollOffset
	STZ.b !REGISTER_BG1VertScrollOffset
	LDA.w $0ED2
	STA.b !REGISTER_BG2VertScrollOffset
	LDA.w $0ED3
	STA.b !REGISTER_BG2VertScrollOffset
CODE_0D837F:
	PLD
	LDX.b #$81
	LDA.w $0EDE
	BEQ.b CODE_0D839B
	LDA.w !REGISTER_IRQEnable
	LDA.w $0EF2
	STA.w !REGISTER_VCountTimerLo
	STZ.w !REGISTER_VCountTimerHi
	STZ.w !REGISTER_HCountTimerLo
	STZ.w !REGISTER_HCountTimerHi
	LDX.b #$A1
CODE_0D839B:
	STX.w !REGISTER_IRQNMIAndJoypadEnableFlags
	PLB
if !Define_Global_ROMToAssemble&(!ROM_SMBLL_U|!ROM_SMBLL_E|!ROM_SMBLL_J) != $00
	REP.b #$30
	PLA
	STA.w !RAM_SMBLL_Global_ScratchRAM00
	PLD
	PLY
	PLX
	PLA
SMBLL_VBlankRoutine_EndofVBlank:
	RTI
else
	RTL
endif

;--------------------------------------------------------------------

SMBLL_IRQRoutine:
.Main:
if !Define_Global_ROMToAssemble&(!ROM_SMBLL_U|!ROM_SMBLL_E|!ROM_SMBLL_J) != $00
	SEI
	REP.b #$30
	PHA
	PHX
	PHY
	PHD
	LDA.w #!RAM_SMBLL_Global_ScratchRAM00
	TCD
	SEP.b #$30
endif
	PHB
	PHK
	PLB
	LDA.w !REGISTER_IRQEnable
	BPL.b CODE_0D83D6
	LDA.w $0EDE
	BEQ.b CODE_0D83D6
	LDA.w $0ED1
	BEQ.b CODE_0D83C5
CODE_0D83B2:
	BIT.w !REGISTER_HVBlankFlagsAndJoypadStatus
	BVC.b CODE_0D83B2
	LDA.w $0EFD
	STA.w !REGISTER_BG2HorizScrollOffset
	LDA.w $0EFE
	STA.w !REGISTER_BG2HorizScrollOffset
	BRA.b CODE_0D83D6

CODE_0D83C5:
	BIT.w !REGISTER_HVBlankFlagsAndJoypadStatus
	BVC.b CODE_0D83C5
	LDA.w $0EEE
	STA.w !REGISTER_BG3HorizScrollOffset
	LDA.w $0EEF
	STA.w !REGISTER_BG3HorizScrollOffset
CODE_0D83D6:
	PLB
if !Define_Global_ROMToAssemble&(!ROM_SMBLL_U|!ROM_SMBLL_E|!ROM_SMBLL_J) != $00
	REP.b #$30
	PLD
	PLY
	PLX
	PLA
	RTI
else
	RTL
endif

;--------------------------------------------------------------------

CODE_0D83D8:
	LDA.w $0770
	ASL
	TAX
	JMP.w (DATA_0D83E0,x)

DATA_0D83E0:
	dw CODE_0D84B6
	dw CODE_0DAB70
	dw CODE_0D8667
	dw CODE_0D9FC6

;--------------------------------------------------------------------

CODE_0D83E8:
	JSR.w CODE_0D8421
	RTL

CODE_0D83EC:
	PHD
	LDA.b #$0B00>>8
	XBA
	LDA.b #$0B00
	TCD
	LDA.b #$90
	STA.b $0B62
	LDA.b #$94
	STA.b $0B63
	LDA.b #$98
	STA.b $0B64
	LDA.b #$9C
	STA.b $0B65
	LDA.b #$A0
	STA.b $0B66
	LDA.b #$A4
	STA.b $0B67
	LDA.b #$A8
	STA.b $0B68
	LDA.b #$AC
	STA.b $0B69
	LDA.b #$58
	STA.b $0B6A
	PLD
CODE_0D8418:
	LDA.b $96
	BNE.b CODE_0D845E
CODE_0D841C:
	LDA.w $0E67
	BNE.b CODE_0D8495
CODE_0D8421:
	LDX.b #$00
	LDA.b #$F0
CODE_0D8425:
	STA.w $0801,x
	STA.w $0841,x
	STA.w $0881,x
	STA.w $08C1,x
	STA.w $0901,x
	STA.w $0941,x
	STA.w $0981,x
	STA.w $09C1,x
	STZ.w $0C00,x
	STZ.w $0C40,x
	STZ.w $0C80,x
	STZ.w $0CC0,x
	STZ.w $0D00,x
	STZ.w $0D40,x
	STZ.w $0D80,x
	STZ.w $0DC0,x
	INX
	INX
	INX
	INX
	CPX.b #$40
	BNE.b CODE_0D8425
	RTS

CODE_0D845E:
	LDX.b #$00
	LDA.b #$F0
CODE_0D8462:
	STA.w $0841,x
	STA.w $0881,x
	STA.w $08C1,x
	STA.w $0901,x
	STA.w $0941,x
	STA.w $0981,x
	STA.w $09C1,x
	STZ.w $0C40,x
	STZ.w $0C80,x
	STZ.w $0CC0,x
	STZ.w $0D00,x
	STZ.w $0D40,x
	STZ.w $0D80,x
	STZ.w $0DC0,x
	INX
	INX
	INX
	INX
	CPX.b #$40
	BNE.b CODE_0D8462
	RTS

CODE_0D8495:
	LDA.b #$F0
	STA.w $0851
	STA.w $0855
	STA.w $08B1
	STA.w $08B5
	STA.w $08B9
	STA.w $08BD
	STA.w $08C1
	STA.w $08C5
	STA.w $08C9
	STA.w $08CD
	RTS

;--------------------------------------------------------------------

CODE_0D84B6:
	LDA.w $0772
	ASL
	TAX
	JSR.w (DATA_0D84D5,x)
if !Define_Global_ROMToAssemble&(!ROM_SMBLL_U|!ROM_SMBLL_E|!ROM_SMBLL_J) == $00
	LDA.l !SRAM_SMAS_Global_RunningDemoFlag
	BEQ.b CODE_0D84D1
	STZ.w !RAM_SMBLL_Global_SoundCh1
	STZ.w !RAM_SMBLL_Global_SoundCh2
	STZ.w !RAM_SMBLL_Global_MusicCh1
	STZ.w !RAM_SMBLL_Global_SoundCh3
	RTS

CODE_0D84D1:
endif
	STZ.w !RAM_SMBLL_Global_MusicCh1
	RTS

DATA_0D84D5:
	dw CODE_0D9D11
	dw CODE_0D89BD
	dw CODE_0D9E3F
	dw CODE_0D84DD

;--------------------------------------------------------------------

CODE_0D84DD:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMBLL_U|!ROM_SMBLL_E|!ROM_SMBLL_J) != $00
	LDA.w !RAM_SMBLL_Global_ControllerPress1
else
	LDA.w !RAM_SMBLL_Global_ControllerHold1
endif
	AND.b #$10
	BEQ.b CODE_0D8558
if !Define_Global_ROMToAssemble&(!ROM_SMBLL_U|!ROM_SMBLL_E|!ROM_SMBLL_J) != $00
	JSR.w CODE_0DAB80
else
	LDA.w $077A
	STA.w $0EC2
	STA.w $0753
	STZ.w $077A
	STZ.w $0F08
	STZ.w $0F09
	STZ.w $07FB
	LDA.l !SRAM_SMAS_Global_InitialSelectedWorld
	STA.w $075F
	LDA.l !SRAM_SMAS_Global_InitialSelectedLevel
	STA.w $0760
	LDA.w $0E24
	STA.w $075C
	JSL.l CODE_0FD051
	LDA.w $075F
	CMP.b #$09
	BCC.b CODE_0D851B
	INC.w $07FB
CODE_0D851B:
	LDA.b #$00
	STA.l !RAM_SMBLL_Global_DisplayTitleScreenMenuOptionsIndex
endif
	JMP.w CODE_0D85FE

CODE_0D8524:
	LDA.b #$00
	STA.l !SRAM_SMBLL_Global_TopScoreMillionsDigit
	STA.l !SRAM_SMBLL_Global_TopScoreHundredThousandsDigit
	STA.l !SRAM_SMBLL_Global_TopScoreTenThousandsDigit
	STA.l !SRAM_SMBLL_Global_TopScoreThousandsDigit
	STA.l !SRAM_SMBLL_Global_TopScoreHundredsDigit
	STA.l !SRAM_SMBLL_Global_TopScoreTensDigit
	STA.w !RAM_SMBLL_TitleScreen_TopScoreMillionsDigit
	STA.w $07C9
	STA.w $07CA
	STA.w $07CB
	STA.w $07CC
	STA.w $07CD
	LDA.b #!Define_SMAS_Sound0060_EchoSpinJumpKill
	STA.w !RAM_SMBLL_Global_SoundCh1
	JMP.w CODE_0D85EC

CODE_0D8558:
	JSL.l CODE_0FFB9A
if !Define_Global_ROMToAssemble&(!ROM_SMBLL_U|!ROM_SMBLL_E|!ROM_SMBLL_J) == $00
	LDA.l !SRAM_SMAS_Global_RunningDemoFlag
	BNE.b CODE_0D8582
endif
	LDA.w $0FF8
	CMP.b #$B0
	BNE.b CODE_0D8570
	LDA.w $0FF4
	CMP.b #$80
	BEQ.b CODE_0D8524
CODE_0D8570:
	LDA.l !RAM_SMBLL_Global_DisplayTitleScreenMenuOptionsIndex
	BMI.b CODE_0D857B
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDA.b #$38
else
	LDA.b #$40
endif
	STA.w $07B2
CODE_0D857B:
if !Define_Global_ROMToAssemble&(!ROM_SMBLL_U|!ROM_SMBLL_E|!ROM_SMBLL_J) != $00
	LDX.w $07B2
	BEQ.b +
	JSL.l CODE_0FF368
+:
endif
	LDA.w $0FF6
	AND.b #$2C
	BNE.b CODE_0D858F
CODE_0D8582:
	LDX.w $07B2
	BNE.b CODE_0D85CF
	JSL.l CODE_0FF760
	BCC.b CODE_0D85D2
	BCS.b CODE_0D85EC

CODE_0D858F:
if !Define_Global_ROMToAssemble&(!ROM_SMBLL_U|!ROM_SMBLL_E|!ROM_SMBLL_J) != $00
	LDY.w $07B2
	BEQ.b CODE_0D85EC
	LDY.b #$18
	STY.w $07B2
	JSL.l SMBLL_MoveTitleScreenMenuCursor_Main
else
	LDA.w $07B2
	BEQ.b CODE_0D85EC
	LDA.b #$18
	STA.w $07B2
	LDA.w $0009
	AND.b #$FE
	STA.w $0009
	LDA.l !SRAM_SMAS_Global_RunningDemoFlag
	BNE.b CODE_0D85CF
	LDA.w $0FF6
	BIT.b #$20
	BEQ.b CODE_0D85B5
	LDA.w $077A
	EOR.b #$01
	BRA.b CODE_0D85C3

CODE_0D85B5:
	AND.b #$0C
	BEQ.b CODE_0D85CB
	EOR.b #$08
	LSR
	LSR
	LSR
	CMP.w $077A
	BEQ.b CODE_0D85CB
CODE_0D85C3:
	STA.w $077A
	LDA.b #!Define_SMAS_Sound0063_Coin
	STA.w !RAM_SMBLL_Global_SoundCh3
endif
CODE_0D85CB:
if !Define_Global_ROMToAssemble&(!ROM_SMBLL_U|!ROM_SMBLL_E|!ROM_SMBLL_J) == $00
	JSL.l CODE_0FF368
endif
CODE_0D85CF:
	STZ.w $0FF4
CODE_0D85D2:
if !Define_Global_ROMToAssemble&(!ROM_SMBLL_U|!ROM_SMBLL_E|!ROM_SMBLL_J) != $00
	LDA.w !RAM_SMBLL_Global_ControllerPress1
	ORA.w !RAM_SMBLL_Global_ControllerPress2
	PHA
	LDA.b !RAM_SMBLL_TitleScreen_FileSelectProcess
	ORA.b !RAM_SMBLL_TitleScreen_EraseFileProcess
	BNE.b +
	PLA
	AND.b #(!Joypad_DPadL>>8)|(!Joypad_DPadR>>8)|(!Joypad_B>>8)
	BEQ.b ++
	JSL.l SMBLL_ChangeSelectedWorld_Main
	LDY.b #$18
	STY.w $07B2
	BRA.b ++

+:
	PLA
	AND.b #$40
	BEQ.b +++
	LDY.b #$18
	STY.w $07B2
	LDA.b !RAM_SMBLL_TitleScreen_FileSelectProcess
	BNE.b +
+++:
	BRA.b ++

+:
	STZ.b !RAM_SMBLL_TitleScreen_FileSelectProcess
	JSL.l SMBLL_LoadFileSelectMenu_Main
	STZ.w !RAM_SMBLL_TitleScreen_MenuSelectionIndex
	LDA.b #$FF
	STA.l !RAM_SMBLL_Global_DisplayTitleScreenMenuOptionsIndex
++:
endif
	LDA.w !RAM_SMBLL_Global_SoundCh3
	PHA
	JSR.w CODE_0DAB80
	STZ.w !RAM_SMBLL_Global_SoundCh1
	STZ.w !RAM_SMBLL_Global_SoundCh2
	PLA
	STA.w !RAM_SMBLL_Global_SoundCh3
	LDA.b $0F
	CMP.b #$06
if !Define_Global_ROMToAssemble&(!ROM_SMBLL_U|!ROM_SMBLL_E|!ROM_SMBLL_J) != $00
	BEQ.b +
	RTS

+:
else
	BNE.b CODE_0D8656
endif
	STZ.w $0EC8
CODE_0D85EC:
	STZ.w $0770
	STZ.w $0772
	STZ.w $0722
	LDA.b #$01
	STA.w $0E7F
	INC.w $0774
	RTS

CODE_0D85FE:
	LDY.w $07B2
	BEQ.b CODE_0D85EC
	ASL
	BCC.b CODE_0D860B
	LDA.b #$09
	JSR.w CODE_0D8663
CODE_0D860B:
	LDA.b #!Define_SMAS_Sound0063_Correct
	STA.w !RAM_SMBLL_Global_SoundCh3
if !Define_Global_ROMToAssemble&(!ROM_SMBLL_U|!ROM_SMBLL_E|!ROM_SMBLL_J) != $00
	LDY.b #$18
	STY.w $07B2
	LDA.b !RAM_SMBLL_TitleScreen_FileSelectProcess
	BNE.b +
	LDA.w !RAM_SMBLL_TitleScreen_MenuSelectionIndex
	CMP.b #$03
	BNE.b ++
	LDA.b !RAM_SMBLL_TitleScreen_EraseFileProcess
	EOR.b #$01
	STA.b !RAM_SMBLL_TitleScreen_EraseFileProcess
	JSL.l SMBLL_LoadFileSelectMenu_Entry2
	RTS

++:
	LDA.b !RAM_SMBLL_TitleScreen_EraseFileProcess
	BEQ.b +++
	JSL.l SMBLL_ClearSaveData_Main
	JSL.l SMBLL_LoadFileSelectMenu_Entry2
	LDA.b #!Define_SMAS_Sound0063_1up
	STA.w !RAM_SMBLL_Global_SoundCh3
	RTS

+++:
	INC.b !RAM_SMBLL_TitleScreen_FileSelectProcess
	LDX.w !RAM_SMBLL_TitleScreen_MenuSelectionIndex
	LDA.b !RAM_SMBLL_TitleScreen_FileASelectedWorld,x
	LSR
	LSR
	STA.l !SRAM_SMAS_Global_InitialSelectedWorld
	LDA.b !RAM_SMBLL_TitleScreen_FileASelectedWorld,x
	AND.b #$03
	STA.l !SRAM_SMAS_Global_InitialSelectedLevel
	JSL.l SMBLL_LoadSaveFileData_Main
-:
	LDA.b !RAM_SMBLL_TitleScreen_FileSelectProcess
	BNE.b ++
	JSL.l SMBLL_LoadFileSelectMenu_Main
	RTS

++:
	JSL.l SMBLL_LoadPlayerSelectMenu_Main
	RTS

+:
	LDX.w !RAM_SMBLL_TitleScreen_MenuSelectionIndex
	CPX.b #$02
	BNE.b +
	LDA.l !SRAM_SMAS_Global_ControllerTypeX
	EOR.b #$01
	AND.b #$01
	STA.l !SRAM_SMAS_Global_ControllerTypeX
	LDA.b #!Define_SMAS_Sound0063_Coin
	STA.w !RAM_SMBLL_Global_SoundCh3
	JSL.l SMBLL_LoadPlayerSelectMenu_Entry2
	RTS

+:
	LDA.w $077A
	STA.w $0EC2
	STA.w $0753
	STZ.w $0F08
	STZ.w $0F09
	STZ.w $07FB
	JSL.l CODE_0FD051
	STZ.w $077A					; Note: Necessary to prevent a glitch with Luigi during the ending.
	LDA.w $075F
	CMP.b #$09
	BCC.b +
	INC.w $07FB
+:
endif
	LDA.b #$01
	STA.w $0E67
	STA.w $0BA5
	JSR.w CODE_0DF700
	JSL.l CODE_0EC34C
	INC.w $075D
	INC.w $0764
	INC.w $0757
	INC.w $0770
	LDA.w $07FB
	STA.w $076A
	STZ.w $0772
	STZ.w $07B2
	LDX.b #$0B
CODE_0D8639:
	STZ.w $07DA,x
	DEX
	BPL.b CODE_0D8639
	PHX
	STZ.b $E4
	LDA.w $075E
	JSR.w CODE_0D8657
	STA.w $07DF
	LDA.b $E4
	STA.w $07DE
	LDA.b #$01
	STA.w $0E1A
	PLX
CODE_0D8656:
	RTS

CODE_0D8657:
	CMP.b #$0A
	BCC.b CODE_0D8662
	INC.b $E4
	SEC
	SBC.b #$0A
	BRA.b CODE_0D8657

CODE_0D8662:
	RTS

CODE_0D8663:
	STA.w $075F
	RTS

;--------------------------------------------------------------------

CODE_0D8667:
	JSR.w CODE_0D867C
	LDA.w $0772
	BEQ.b CODE_0D8676
	LDX.b #$00
	STX.b $9E
	JSR.w CODE_0DC250
CODE_0D8676:
	JSR.w CODE_0DFD29
	JMP.w CODE_0DF700

CODE_0D867C:
	LDA.w $0EC4
	BNE.b CODE_0D8695
	LDA.w $0772
	JSR.w CODE_0D9693

DATA_0D8667:
	dw CODE_0DD3BA
	dw CODE_0D8773
	dw CODE_0D878B
	dw CODE_0D87FA
	dw CODE_0D8810
	dw CODE_0D8734
	dw CODE_0D8857

CODE_0D8695:
	LDA.w $0772
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMBLL_J) != $00
	ASL
	TAX
	JMP.w (DATA_0D869B,x)
else
	JSR.w CODE_0D9693
endif

DATA_0D869B:
	dw CODE_0DD3BA
	dw CODE_0D876D
	dw CODE_0D878B
	dw CODE_0D86B9
	dw CODE_0D86CD
	dw CODE_0D8734
	dw CODE_0D86F6
	dw CODE_0D86FD
	dw CODE_0D870C
	dw CODE_0D871D
	dw CODE_0D8722
	dw CODE_0D8726
	dw CODE_0D8857
	dw CODE_0D872A
	dw CODE_0D872F

;--------------------------------------------------------------------

CODE_0D86B9:
	LDA.w $0754
	BEQ.b CODE_0D86C6
	JSL.l CODE_00C62D
	INC.w $0772
	RTS

CODE_0D86C6:
	INC.w $0772
	INC.w $0772
	RTS

;--------------------------------------------------------------------

CODE_0D86CD:
	STZ.w $0FF4
	STZ.w $0FF6
	STZ.w $0FF5
	STZ.w $0FF7
	STZ.w $0FF8
	STZ.w $0FF9
	STZ.w $0FFA
	STZ.w $0FFB
	LDA.b #$02
	STA.w $078F
	JSR.w CODE_0DAB99
	LDA.w $0754
	BNE.b CODE_0D86F5
	INC.w $0772
CODE_0D86F5:
	RTS

;--------------------------------------------------------------------

CODE_0D86F6:
	INC.w $0772
	INC.w $0F87
	RTS

;--------------------------------------------------------------------

CODE_0D86FD:
	JSL.l CODE_00C45F
	LDA.w $0F87
	CMP.b #$06
	BCC.b CODE_0D870B
	INC.w $0772
CODE_0D870B:
	RTS

;--------------------------------------------------------------------

CODE_0D870C:
	LDA.b #!Define_SMBLL_LevelMusic_SMBLLPeachRescued
	STA.w !RAM_SMBLL_Global_MusicCh1
	JSL.l CODE_00C060
	JSL.l CODE_0FD9F9
	INC.w $0772
	RTS

;--------------------------------------------------------------------

CODE_0D871D:
	JSL.l CODE_00C68B
	RTS

;--------------------------------------------------------------------

CODE_0D8722:
	INC.w $0772
	RTS

;--------------------------------------------------------------------

CODE_0D8726:
	INC.w $0772
	RTS

;--------------------------------------------------------------------

CODE_0D872A:
	JSL.l CODE_0E819D
	RTS

;--------------------------------------------------------------------

CODE_0D872F:
	JSL.l CODE_0E81E3
	RTS

;--------------------------------------------------------------------

CODE_0D8734:
	LDA.w $07B1
	CMP.b #$06
	BCS.b CODE_0D876C
	LDA.w !REGISTER_APUPort3
	AND.b #$7F
	CMP.b #!Define_SMAS_Sound0063_AddTimerToScore
	BEQ.b CODE_0D8749
	LDA.b #!Define_SMAS_Sound0063_AddTimerToScore
	STA.w !RAM_SMBLL_Global_SoundCh3
CODE_0D8749:
	JSR.w CODE_0DD6FF
	LDA.w $07E9
	ORA.w $07EA
	ORA.w $07EB
	BNE.b CODE_0D876C
	LDA.b #!Define_SMAS_Sound0063_FinishAddTimerToScore
	STA.w !RAM_SMBLL_Global_SoundCh3
	STA.w $0E1A
	LDA.b #$30
	STA.w $0788
	LDA.b #$06
	STA.w $07B1
	INC.w $0772
CODE_0D876C:
	RTS

;--------------------------------------------------------------------

CODE_0D876D:
	JSL.l CODE_00C654
	BRA.b CODE_0D877C

;--------------------------------------------------------------------

CODE_0D8773:
	LDA.w $0B76
	BEQ.b CODE_0D8786
	JSL.l CODE_00D507
CODE_0D877C:
	LDX.w $071B
	INX
	STX.w $0203
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	STZ.w $0705
	STZ.w $005D
endif
	JMP.w CODE_0D8BD0

CODE_0D8786:
	JSL.l CODE_00D4CA
	RTS

;--------------------------------------------------------------------

CODE_0D878B:
	LDA.b $96
	BEQ.b CODE_0D8790
	RTS

CODE_0D8790:
	LDA.w $0F82
	BEQ.b CODE_0D8799
	JSL.l CODE_00C555
CODE_0D8799:
	LDY.b #$00
	STY.w $0204
	LDA.b $78
	CMP.w $0203
	BNE.b CODE_0D87CD
	LDA.w $075F
	CMP.b #$07
	BEQ.b CODE_0D87B0
	CMP.b #$0C
	BNE.b CODE_0D87B9
CODE_0D87B0:
	INC.w $0204
	JSL.l CODE_00C3DA
	BRA.b CODE_0D87D1

CODE_0D87B9:
	CMP.b #$02
	BNE.b CODE_0D87C6
	LDA.w $0219
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	CMP.b #$4C
else
	CMP.b #$44
endif
	BCS.b CODE_0D87D1
	BRA.b CODE_0D87CD

CODE_0D87C6:
	LDA.w $0219
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	CMP.b #$5C
else
	CMP.b #$54
endif
	BCS.b CODE_0D87D1
CODE_0D87CD:
	INC.w $0204
	INY
CODE_0D87D1:
	TYA
	JSR.w CODE_0DAE12
	LDA.w $071A
	CMP.w $0203
	BEQ.b CODE_0D87F4
	LDA.w $0768
	CLC
	ADC.b #$80
	STA.w $0768
	LDA.b #$01
	ADC.b #$00
	TAY
	JSR.w CODE_0DACAA
	JSR.w CODE_0DAC52
	INC.w $0204
CODE_0D87F4:
	LDA.w $0204
	BEQ.b CODE_0D8853
	RTS

;--------------------------------------------------------------------

CODE_0D87FA:
	INC.w $0F7F
	LDA.w $0F7F
	CMP.b #$70
	BNE.b CODE_0D880F
	LDA.b #$01
	STA.w $0F7E
	STZ.w $0F7F
	INC.w $0772
CODE_0D880F:
	RTS

;--------------------------------------------------------------------

CODE_0D8810:
	LDA.w $0749
	BNE.b CODE_0D8834
	LDA.w $0719
	BEQ.b CODE_0D8822
	CMP.b #$08
	BCS.b CODE_0D8834
	CMP.b #$01
	BCC.b CODE_0D8834
CODE_0D8822:
	TAY
	BEQ.b CODE_0D882D
	CPY.b #$03
	BCS.b CODE_0D8847
	CPY.b #$02
	BCS.b CODE_0D8834
CODE_0D882D:
	TYA
	CLC
	ADC.b #$0C
	STA.w $0773
CODE_0D8834:
	LDA.w $0749
	CLC
	ADC.b #$04
	STA.w $0749
	LDA.w $0719
	ADC.b #$00
	STA.w $0719
	CMP.b #$06
CODE_0D8847:
	BCC.b CODE_0D8856
	LDA.b #$06
	LDA.b #$08
	STA.w $07B1
	STA.w $0E67
CODE_0D8853:
	INC.w $0772
CODE_0D8856:
	RTS

;--------------------------------------------------------------------

CODE_0D8857:
	LDA.w $07B1
	BNE.b CODE_0D8898
CODE_0D885C:
	STZ.w $0760
	STZ.w $075C
	STZ.w $0772
	LDA.w $1680
	CMP.b #$90
	BEQ.b CODE_0D888C
	LDA.w $075F
	CLC
	ADC.b #$01
	CMP.b #$0C
	BCC.b CODE_0D8878
	LDA.b #$0C
CODE_0D8878:
	CMP.b #$08
	BNE.b CODE_0D8889
	LDA.w !RAM_SMBLL_Level_NoWorld9Flag
	BEQ.b CODE_0D8889
	LDA.b #$01
	STA.w $07FB
	INC.w $075F
CODE_0D8889:
	INC.w $075F
CODE_0D888C:
	JSL.l CODE_0EC34C
	INC.w $0757
	LDA.b #$01
	STA.w $0770
CODE_0D8898:
	RTS

;--------------------------------------------------------------------

CODE_0D8899:
	LDA.w $0FF4
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMBLL_J) == $00
	ORA.w $0FF5
endif
	AND.b #$40
	BEQ.b CODE_0D88B0
	LDA.b #$01
	STA.w $07FB
	LDA.b #$FF
	STA.w $075A
	JSR.w CODE_0D9FF4
CODE_0D88B0:
	RTS

;--------------------------------------------------------------------

DATA_0D88B1:
	db $FF,$FF,$F6,$FB,$F7,$FB,$F8,$FB
	db $F9,$FB,$FA,$FB,$F6,$0E,$F7,$0E
	db $F8,$0E,$F9,$0E,$FA,$0E,$FD,$FE

DATA_0D88C9:
	db $FF,$41,$42,$44,$45,$48,$31,$32
	db $34,$35,$38,$00

CODE_0D88D5:
	LDA.w $0110,x
	BEQ.b CODE_0D8898
	CMP.b #$0B
	BCC.b CODE_0D88EA
	LDA.b #$0B
	STA.w $0110,x
	CPX.b #$09
	BEQ.b CODE_0D88EA
	STA.w $0284
CODE_0D88EA:
	TAY
	LDA.w $0138,x
	BNE.b CODE_0D88F4
	STA.w $0110,x
	RTS

CODE_0D88F4:
	DEC.w $0138,x
	CMP.b #$2B
	BNE.b CODE_0D891B
	CPY.b #$0B
	BNE.b CODE_0D8908
	JSL.l CODE_048596				; Note: Call to SMB1 function
	LDA.b #!Define_SMAS_Sound0063_1up
	STA.w !RAM_SMBLL_Global_SoundCh3
CODE_0D8908:
	LDA.w DATA_0D88C9,y
	LSR
	LSR
	LSR
	LSR
	TAX
	LDA.w DATA_0D88C9,y
	AND.b #$0F
	STA.w $0145,x
	JSR.w CODE_0DBB27
CODE_0D891B:
	LDX.b $9E
	LDY.w $0B58
CODE_0D8920:
	LDA.w $0801,y
	CMP.b #$F0
	BEQ.b CODE_0D8936
	INY
	INY
	INY
	INY
	INY
	INY
	INY
	INY
	CPY.b #$90
	BNE.b CODE_0D8920
	LDY.w $0B58
CODE_0D8936:
	LDA.w $0124,x
	CMP.b #$18
	BCC.b CODE_0D8942
	SBC.b #$01
	STA.w $0124,x
CODE_0D8942:
	LDA.w $0124,x
	JSR.w CODE_0DEB8A
	STX.b $E0
	TXA
	ASL
	TAX
	REP.b #$20
	LDA.w $0E50,x
	STA.b $E2
	CLC
	ADC.w #$0008
	STA.b $DE
	SEP.b #$20
	LDX.b $E0
	STZ.b $DD
	LDA.b $E3
	BEQ.b CODE_0D896A
	LDA.b $DD
	ORA.b #$01
	STA.b $DD
CODE_0D896A:
	LDA.b $DD
	STA.w $0C00,y
	LDA.w $0110,x
	CMP.b #$06
	BCS.b CODE_0D897A
CODE_0D8976:
	STZ.b $DD
	BRA.b CODE_0D8982

CODE_0D897A:
	CMP.b #$0B
	BEQ.b CODE_0D8976
	LDA.b #$02
	STA.b $DD
CODE_0D8982:
	LDA.b $DF
	BEQ.b CODE_0D898C
	LDA.b $DD
	ORA.b #$01
	STA.b $DD
CODE_0D898C:
	LDA.b $DD
	STA.w $0C04,y
	LDA.b $E2
	STA.w $0800,y
	LDA.b $DE
	STA.w $0804,y
	LDA.w $0110,x
	ASL
	TAX
	LDA.w DATA_0D88B1,x
	STA.w $0802,y
	LDA.w DATA_0D88B1+$01,x
	STA.w $0806,y
	TAX
	LDA.b #$32
	STA.w $0803,y
	CPX.b #$0E
	BNE.b CODE_0D89B7
	INC
CODE_0D89B7:
	STA.w $0807,y
	LDX.b $9E
	RTS

;--------------------------------------------------------------------

CODE_0D89BD:
	LDA.w $073C
	ASL
	TAX
	JMP.w (DATA_0D89C5,x)

DATA_0D89C5:
	dw CODE_0D89E5
	dw CODE_0D89EE
	dw CODE_0D8A32
	dw CODE_0D8A56
	dw CODE_0D8ABF
	dw CODE_0D8ED6
	dw CODE_0D8AE0
	dw CODE_0D9A4C
	dw CODE_0D8ED6
	dw CODE_0D8B6F
	dw CODE_0D8A0D
	dw CODE_0D8A23
	dw CODE_0D8A28
	dw CODE_0D8B9D
	dw CODE_0D8BB3
	dw CODE_0D8BCB

;--------------------------------------------------------------------

CODE_0D89E5:
	LDA.w $0770
	BEQ.b CODE_0D8A20
	LDX.b #$03
	BRA.b CODE_0D8A18

;--------------------------------------------------------------------

CODE_0D89EE:
	LDA.w $0744
	PHA
	LDA.w $0756
	PHA
	STZ.w $0756
	LDA.b #$02
	STA.w $0744
	JSL.l CODE_0E98C3
	PLA
	STA.w $0756
	PLA
	STA.w $0744
	JMP.w CODE_0D8BC7

;--------------------------------------------------------------------

CODE_0D8A0D:
	LDA.b $5C
	JSL.l CODE_0FD8F6
	JSL.l CODE_0E9147
	RTS

;--------------------------------------------------------------------

CODE_0D8A18:
	STZ.w $0773
	LDA.b #$01
	STA.w !RAM_SMBLL_Global_UpdateEntirePaletteFlag
CODE_0D8A20:
	JMP.w CODE_0D8BC7

;--------------------------------------------------------------------

CODE_0D8A23:
	JSL.l CODE_0E98B8
	RTS

;--------------------------------------------------------------------

CODE_0D8A28:
	INC.w $073C
	RTS

;--------------------------------------------------------------------

CODE_0D8A2C:
	STA.w $0773
	JMP.w CODE_0D8BC7

;--------------------------------------------------------------------

CODE_0D8A32:
	LDA.b #$00
	JSR.w CODE_0D8DBF
	LDA.w $0753
	BEQ.b CODE_0D8A53
	LDA.b #$15
	STA.w $1706
	LDA.b #$1E
	STA.w $1708
	LDA.b #$12
	STA.w $170A
	STA.w $170E
	LDA.b #$10
	STA.w $170C
CODE_0D8A53:
	JMP.w CODE_0D8BC7

;--------------------------------------------------------------------

CODE_0D8A56:
	JSR.w CODE_0DBB2D
	REP.b #$30
	LDX.w $1700
	LDA.w #$7358
	STA.w $1702,x
	LDA.w #$0500
	STA.w $1704,x
	SEP.b #$20
	LDA.w $075F
	INC
	STA.w $1706,x
	LDA.b #$20
	STA.w $1707,x
	STA.w $1709,x
	STA.w $170B,x
	LDA.b #$24
	STA.w $1708,x
	LDA.w $075C
	INC
	STA.w $170A,x
	LDA.b #$FF
	STA.w $170C,x
	LDA.w $0770
	BNE.b CODE_0D8AB0
if !Define_Global_ROMToAssemble&(!ROM_SMBLL_U|!ROM_SMBLL_E|!ROM_SMBLL_J) == $00
	LDA.l !SRAM_SMAS_Global_RunningDemoFlag
	BNE.b CODE_0D8AB0
endif
	LDA.l !RAM_SMBLL_Global_DisplayTitleScreenMenuOptionsIndex
	BMI.b CODE_0D8AB0
	LDA.l $7FFB00
	INC
	STA.w $1706,x
	LDA.l $7FFB01
	INC
	STA.w $170A,x
CODE_0D8AB0:
	REP.b #$20
	TXA
	CLC
	ADC.w #$000A
	STA.w $1700
	SEP.b #$30
	JMP.w CODE_0D8BC7

;--------------------------------------------------------------------

CODE_0D8ABF:
	LDA.w $0759
	BEQ.b CODE_0D8ADA
	STZ.w $0759
	LDY.b #$00
	JSR.w CODE_0D841C
	JSL.l CODE_0E8D2E
	LDA.b #$01
	STA.w $0ED6
	LDA.b #$02
	JMP.w CODE_0D8B02

CODE_0D8ADA:
	INC.w $073C
	JMP.w CODE_0D8BC7

;--------------------------------------------------------------------

CODE_0D8AE0:
	LDA.w $0770
	BEQ.b CODE_0D8B2E
	CMP.b #$03
	BEQ.b CODE_0D8B34
	LDA.w $0752
	BNE.b CODE_0D8B2E
	LDY.b $5C
	CPY.b #$03
	BEQ.b CODE_0D8AF9
	LDA.w $0769
	BNE.b CODE_0D8B2E
CODE_0D8AF9:
	JSR.w CODE_0DF85F
	JSL.l CODE_0E8F43
	LDA.b #$01
CODE_0D8B02:
	JSR.w CODE_0D8DBF
	JSR.w CODE_0D8EE7
	STZ.w $1204
	STZ.w $1205
	STZ.w $1206
	STZ.w $1209
	LDA.b #$20
	STA.w $120A
	STZ.w !RAM_SMBLL_Global_HDMAEnableMirror
	LDA.b #$02
	STA.w $0E7F
	STZ.w $0E4F
	STZ.w !RAM_SMBLL_Global_ScreenDisplayRegisterMirror
	STZ.w $0E7E
	STZ.w $0774
	RTS

CODE_0D8B2E:
	LDA.b #$09
	STA.w $073C
	RTS

CODE_0D8B34:
	STZ.w $1204
	STZ.w $1205
	STZ.w $1206
	STZ.w $1209
	LDA.b #$20
	STA.w $120A
	STZ.w !RAM_SMBLL_Global_HDMAEnableMirror
	LDA.w $0774
	BEQ.b CODE_0D8B5F
	STZ.w $0E4F
	STZ.w $0774
	STZ.w !RAM_SMBLL_Global_ScreenDisplayRegisterMirror
	LDA.b #$02
	STA.w $0E7F
	JSL.l CODE_0E8D2E
CODE_0D8B5F:
	JSR.w CODE_0D99CA
	LDA.b #$09
	STA.w $07B0
	LDA.b #$03
	JSR.w CODE_0D8DBF
	JMP.w CODE_0D8BD0

;--------------------------------------------------------------------

CODE_0D8B6F:
	LDA.w $0774
	BEQ.b CODE_0D8B7A
	CMP.b #$01
	BEQ.b CODE_0D8B87
	BRA.b CODE_0D8B84

CODE_0D8B7A:
	LDA.b #$01
	STA.w $0E7F
	STZ.w $0E4F
	BRA.b CODE_0D8B9C

CODE_0D8B84:
	INC.w $0774
CODE_0D8B87:
	JSR.w CODE_0DA054
	LDA.w $071F
	BNE.b CODE_0D8B87
	DEC.w $071E
	BPL.b CODE_0D8B97
	INC.w $073C
CODE_0D8B97:
	LDA.b #$06
	STA.w $0773
CODE_0D8B9C:
	RTS

;--------------------------------------------------------------------

CODE_0D8B9D:
	LDA.w $0770
	BNE.b CODE_0D8BD0
	JSL.l CODE_0FE893
	STZ.w $0EC2
	LDA.b #$80
	STA.w $0ED6
	LDA.b #$05
	JMP.w CODE_0D8A2C

;--------------------------------------------------------------------

CODE_0D8BB3:
	LDA.w $0770
	BNE.b CODE_0D8BD0
	LDX.b #$00
CODE_0D8BBA:
	STA.w $0300,x
	STA.w $0400,x
	DEX
	BNE.b CODE_0D8BBA
	JSL.l CODE_0FF368
CODE_0D8BC7:
	INC.w $073C
	RTS

;--------------------------------------------------------------------

CODE_0D8BCB:
	LDA.b #$FA
	JSR.w CODE_0DBB30
CODE_0D8BD0:
	INC.w $0772
	RTS

;--------------------------------------------------------------------

CODE_0D8BD4:
	db $58,$43,$00,$09
	db $16,$20,$0A,$20,$1B,$20,$12,$20,$18,$20

	db $58,$52,$00,$15
	db $20,$20,$18,$20,$1B,$20,$15,$20,$0D,$20,$28,$20,$28,$20,$1D,$20
	db $12,$20,$16,$20,$0E,$20

	db $58,$68,$00,$09
	db $00,$20,$28,$20,$28,$20,$27,$24,$25,$20

	db $FF

	db $58,$43,$00,$09
	db $15,$20,$1E,$20,$12,$20,$10,$20,$12,$20

	db $58,$52,$00,$15
	db $20,$20,$18,$20,$1B,$20,$15,$20,$0D,$20,$28,$20,$28,$20,$1D,$20
	db $12,$20,$16,$20,$0E,$20

	db $58,$68,$00,$09
	db $00,$20,$28,$20,$28,$20,$27,$24,$25,$20

	db $FF

	db $59,$6D,$00,$0F
	db $28,$20,$28,$20,$28,$20,$25,$20,$28,$20,$28,$20,$28,$20,$28,$20

	db $59,$E0,$40,$FE
	db $28,$00

	db $59,$0B,$00,$11
	db $20,$20,$18,$20,$1B,$20,$15,$20,$0D,$20,$28,$20,$28,$20,$24,$20
	db $28,$20

	db $58,$AC,$40,$0D
	db $28,$20

	db $FF

	db $09,$6D,$00,$09
	db $E0,$19,$E1,$19,$E2,$19,$E3,$19,$E4,$19

	db $09,$8D,$00,$09
	db $F0,$19,$F1,$19,$F2,$19,$F3,$19,$F4,$19

	db $09,$AC,$00,$0D
	db $CA,$19,$CB,$19,$CC,$19,$CD,$19,$24,$00,$CE,$19,$CF,$19

	db $09,$CC,$00,$0D
	db $DA,$19,$DB,$19,$DC,$19,$DD,$19,$24,$00,$DE,$19,$DF,$19

	db $FF

if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMBLL_J) != $00
	db $09,$CC,$40,$0C
	db $24,$00

	db $09,$91,$00,$07
	db $AD,$02,$24,$00,$24,$00,$AD,$02

	db $09,$D2,$00,$01
	db $AD,$02

	db $09,$8D,$C0,$08
	db $AD,$02

	db $09,$AB,$00,$17
	db $A1,$02,$A2,$02,$A3,$02,$A4,$02,$AB,$02,$AC,$02,$A5,$02,$24,$00
	db $A6,$02,$A6,$02,$A7,$02,$A8,$02

	db $09,$EB,$00,$13
	db $A1,$02,$A2,$02,$A3,$02,$A4,$02,$A5,$02,$24,$00,$A6,$02,$A6,$02
	db $A7,$02,$A8,$02

	db $0A,$2B,$00,$11
	db $A1,$02,$A2,$02,$A3,$02,$A4,$02,$A5,$02,$24,$00,$A9,$02,$AA,$02
	db $A8,$02

	db $09,$0B,$00,$13
	db $C0,$19,$C1,$19,$C2,$19,$C3,$19,$C4,$19,$C5,$19,$C6,$19,$C7,$19
	db $C8,$19,$C9,$19

	db $09,$2B,$00,$13
	db $D0,$19,$D1,$19,$D2,$19,$D3,$19,$D4,$19,$D5,$19,$D6,$19,$D7,$19
	db $D8,$19,$D9,$19
else
	db $09,$CC,$40,$0C
	db $24,$00

	db $09,$AB,$00,$0F
	db $A1,$02,$A2,$02,$A3,$02,$A4,$02,$A5,$02,$A6,$02,$A7,$02,$A8,$02

	db $09,$EB,$00,$19
	db $AE,$02,$AF,$02,$B0,$02,$B1,$02,$AD,$02,$A1,$02,$A2,$02,$A3,$02
	db $A4,$02,$A5,$02,$A6,$02,$A7,$02,$A8,$02

	db $0A,$2B,$00,$11
	db $AE,$02,$AF,$02,$B0,$02,$B1,$02,$AD,$02,$A9,$02,$AA,$02,$AB,$02
	db $AC,$02

	db $09,$0B,$00,$13
	db $C0,$19,$C1,$19,$C2,$19,$C3,$19,$C4,$19,$C5,$19,$C6,$19,$C7,$19
	db $C8,$19,$C9,$19

	db $09,$2B,$00,$13
	db $D0,$19,$D1,$19,$D2,$19,$D3,$19,$D4,$19,$D5,$19,$D6,$19,$D7,$19
	db $D8,$19,$D9,$19
endif
	db $FF

DATA_0D8D39:
	db $05,$84,$00,$29
	db $20,$08,$0E,$08,$15,$08,$0C,$08,$18,$08,$16,$08,$0E,$08,$24,$00
	db $1D,$08,$18,$08,$24,$00,$20,$08,$0A,$08,$1B,$08,$19,$08,$24,$00
	db $23,$08,$18,$08,$17,$08,$0E,$08,$2B,$08

	db $05,$E5,$00,$01
	db $24,$08

	db $05,$ED,$00,$01
	db $24,$08

	db $05,$F5,$00,$01
	db $24,$08

	db $FF

DATA_0D8D7A:
	db $E5,$19,$E6,$19,$E7,$19,$E8,$19
	db $E9,$19

DATA_0D8D84:
	db $F5,$19,$F6,$19,$F7,$19,$F8,$19
	db $F9,$19

DATA_0D8D8E:
	db $15,$20,$1E,$20,$12,$20,$10,$20
	db $12,$20

DATA_0D8D98:
	db $02,$03,$04,$01,$06,$07,$08,$05
	db $0B,$0C,$0D

DATA_0D8DA3:
	db $00,$37,$6E,$6E,$A5,$C1,$E6,$E6
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMBLL_J) != $00
	db $7F,$7F
else
	db $65,$65
endif

DATA_0D8DAD:
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $01,$01

CODE_0D8DB7:
	LDA.w $077A
	BEQ.b CODE_0D8DD4
	INY
	BRA.b CODE_0D8DD4

CODE_0D8DBF:
	PHA
	ASL
	TAY
	BEQ.b CODE_0D8DB7
	CPY.b #$04
	BCC.b CODE_0D8DD4
	CPY.b #$08
	BCC.b CODE_0D8DCE
	LDY.b #$08
CODE_0D8DCE:
	LDA.w $077A
	BNE.b CODE_0D8DD4
	INY
CODE_0D8DD4:
	STY.b $F3
	LDX.w DATA_0D8DA3,y
	LDA.w $075F
	CMP.b #$08
	BNE.b CODE_0D8DEA
	CPY.b #$07
	BNE.b CODE_0D8DEA
	DEY
	LDX.w DATA_0D8DA3,y
	STY.b $F3
CODE_0D8DEA:
	REP.b #$30
	LDA.w DATA_0D8DAD,y
	AND.w #$00FF
	XBA
	STA.b $DE
	TXA
	AND.w #$00FF
	ORA.b $DE
	TAX
	LDY.w #$0000
	SEP.b #$20
CODE_0D8E01:
	LDA.w CODE_0D8BD4,x
	CMP.b #$FF
	BEQ.b CODE_0D8E0F
	STA.w $1702,y
	INX
	INY
	BRA.b CODE_0D8E01

CODE_0D8E0F:
	LDA.b #$FF
	STA.w $1702,y
	SEP.b #$10
	PLA
	TAX
	CMP.b #$04
	BCC.b CODE_0D8E1F
	JMP.w CODE_0D8EB3

CODE_0D8E1F:
	DEX
	BNE.b CODE_0D8E68
	LDA.w $075A
	INC
	CMP.b #$0A
	BCC.b CODE_0D8E56
	STZ.b $E4
	STZ.b $E5
CODE_0D8E2E:
	SEC
	SBC.b #$64
	BCC.b CODE_0D8E37
	INC.b $E4
	BRA.b CODE_0D8E2E

CODE_0D8E37:
	CLC
	ADC.b #$64
CODE_0D8E3A:
	SEC
	SBC.b #$0A
	BCC.b CODE_0D8E43
	INC.b $E5
	BRA.b CODE_0D8E3A

CODE_0D8E43:
	CLC
	ADC.b #$0A
	STA.b $E6
	LDY.b $E4
	BEQ.b CODE_0D8E4F
	STY.w $170E
CODE_0D8E4F:
	LDA.b $E5
	STA.w $1710
	LDA.b $E6
CODE_0D8E56:
	STA.w $1712
	LDY.w $075F
	INY
	STY.w $172C
	LDY.w $075C
	INY
	STY.w $1730
	RTS

CODE_0D8E68:
	LDA.w $077A
	BEQ.b CODE_0D8EB2
	LDA.w $0753
	DEX
	BNE.b CODE_0D8E89
	LDY.w $0770
	CPY.b #$03
	BEQ.b CODE_0D8E89
	LDA.w $0761
	BMI.b CODE_0D8E86
	LDA.w $0753
	EOR.b #$01
	BRA.b CODE_0D8E89

CODE_0D8E86:
	LDA.w $0753
CODE_0D8E89:
	LSR
	BCC.b CODE_0D8EB2
	LDY.b #$09
	LDA.b $F3
	CMP.b #$04
	BEQ.b CODE_0D8E98
	CMP.b #$06
	BNE.b CODE_0D8EA9
CODE_0D8E98:
	LDA.w DATA_0D8D7A,y
	STA.w $1706,y
	LDA.w DATA_0D8D84,y
	STA.w $1714,y
	DEY
	BPL.b CODE_0D8E98
	BRA.b CODE_0D8EB2

CODE_0D8EA9:
	LDA.w DATA_0D8D8E,y
	STA.w $1706,y
	DEY
	BPL.b CODE_0D8EA9
CODE_0D8EB2:
	RTS

CODE_0D8EB3:
	PHA
	LDY.w $1700
	PHX
	LDX.b #$00
CODE_0D8EBA:
	LDA.w DATA_0D8D39,x
	STA.w $1702,y
	INX
	INY
	CMP.b #$FF
	BNE.b CODE_0D8EBA
	PLX
	PLA
	SEC
	SBC.b #$80
	TAX
	STY.w $1700
	LDA.w DATA_0D8D98,x
	STA.w $16F9,y
	RTS

;--------------------------------------------------------------------

CODE_0D8ED6:
	LDA.w $07B0
	BNE.b CODE_0D8EEF
	LDA.w $0770
	CMP.b #$03
	BEQ.b CODE_0D8EE7
	LDA.b #$01
	STA.w $0E7F
CODE_0D8EE7:
	LDA.b #$07
	STA.w $07B0
	INC.w $073C
CODE_0D8EEF:
	RTS

;--------------------------------------------------------------------

CODE_0D8EF0:
	LDA.w $0EC9
	BNE.b CODE_0D8EEF
	REP.b #$30
	LDY.w $1A00
	STY.b $00
	LDA.w $0720
	STA.w $1A02,y
	XBA
	STA.w $0ECC
	LDA.w #$3D80
	STA.w $1A04,y
	LDA.w #$0024
	STA.w $1A06,y
	STA.w $1A08,y
	STA.w $1A0A,y
	STA.w $1A0C,y
	SEP.b #$30
	LDX.b #$00
	LDA.w $0EE7
	BEQ.b CODE_0D8F34
	STA.w $0EE6
	LDA.w $0720
	STA.w $0EF5
	LDA.w $0721
	INC
	STA.w $0EF4
CODE_0D8F34:
	STX.b $02
	LDA.w $06A1,x
	AND.b #$C0
	ASL
	ROL
	ROL
	TAY
	LDA.w DATA_0D910B,y
	STA.b $06
	LDA.w DATA_0D910F,y
	STA.b $07
	REP.b #$30
	TXA
	AND.w #$00FF
	TAX
	LDA.w $06A1,x
	AND.w #$003F
	ASL
	ASL
	ASL
	STA.b $03
	LDA.w $071F
	AND.w #$0001
	EOR.w #$0001
	ASL
	ASL
	ADC.b $03
	TAY
	LDX.b $00
	LDA.b ($06),y
	STA.w $1A0E,x
	INY
	INY
	LDA.b ($06),y
	STA.w $1A10,x
	INC.b $00
	INC.b $00
	INC.b $00
	INC.b $00
	SEP.b #$30
	LDX.b $02
	INX
	CPX.b #$0D
	BCS.b CODE_0D8F8B
	JMP.w CODE_0D8F34

CODE_0D8F8B:
	REP.b #$30
	LDY.w $1A00
	LDA.w $1A0E,y
	CMP.w #$18A2
	BEQ.b CODE_0D8F9D
	CMP.w #$18A3
	BNE.b CODE_0D8FA9
CODE_0D8F9D:
	STA.w $1A06,y
	STA.w $1A08,y
	STA.w $1A0A,y
	STA.w $1A0C,y
CODE_0D8FA9:
	LDA.b $00
	CLC
	ADC.w #$000E
	TAY
	LDA.w #$FFFF
	STA.w $1A02,y
	STY.w $1A00
	LDA.w $0743
	AND.w #$00FF
	BNE.b CODE_0D9007
	LDA.b $5C
	AND.w #$00FF
	BEQ.b CODE_0D9007
	CMP.w #$0003
	BEQ.b CODE_0D9007
	LDA.w $19F8,y
	CMP.w #$086A
	BEQ.b CODE_0D8FDA
	CMP.w #$0863
	BNE.b CODE_0D8FDD
CODE_0D8FDA:
	INC.w $0ECE
CODE_0D8FDD:
	LDA.w $19F8,y
	CMP.w #$0024
	BEQ.b CODE_0D8FFA
	CMP.w #$10A4
	BEQ.b CODE_0D8FFA
	CMP.w #$0A08
	BNE.b CODE_0D9003
	LDA.w $0ECE
	AND.w #$FF00
	STA.w $0ECE
	BRA.b CODE_0D9003

CODE_0D8FFA:
	LDA.w $0ECE
	ORA.w #$0100
	STA.w $0ECE
CODE_0D9003:
	JSL.l CODE_0E87FF
CODE_0D9007:
	SEP.b #$30
	INC.w $0721
	LDA.w $0721
	AND.b #$1F
	BNE.b CODE_0D901E
	STZ.w $0721
	LDA.w $0720
	EOR.b #$04
	STA.w $0720
CODE_0D901E:
	LDA.b #$06
	STA.w $0773
	RTS

;--------------------------------------------------------------------

CODE_0D9024:
	RTS

;--------------------------------------------------------------------

CODE_0D9025:
	RTS

;--------------------------------------------------------------------

DATA_0D9026:
	db $45,$0C,$45,$0C,$47,$0C,$47,$0C
	db $47,$0C,$47,$0C,$47,$0C,$47,$0C
	db $57,$0C,$58,$0C,$59,$0C,$5A,$0C
	db $24,$00,$24,$00,$24,$00,$24,$00

;--------------------------------------------------------------------

CODE_0D9046:
	LDY.w $1700
	INY
	LDA.b #$03
	JSR.w CODE_0D9094
	LDA.b #$06
	STA.w $0773
	JMP.w CODE_0D9085

;--------------------------------------------------------------------

CODE_0D9057:
	JSR.w CODE_0D9063
	INC.w $03F2
	DEC.w $03EE,x
	RTS

;--------------------------------------------------------------------

CODE_0D9061:
	LDA.b #$00
CODE_0D9063:
	LDY.b #$03
	CMP.b #$00
	BEQ.b CODE_0D907D
	LDY.b #$00
	CMP.b #$54
	BEQ.b CODE_0D907D
	CMP.b #$49
	BEQ.b CODE_0D907D
	INY
	CMP.b #$5A
	BEQ.b CODE_0D907D
	CMP.b #$4A
	BEQ.b CODE_0D907D
	INY
CODE_0D907D:
	TYA
	LDY.w $1700
	INY
	JSR.w CODE_0D9094
CODE_0D9085:
	REP.b #$20
	LDA.w $1700
	CLC
	ADC.w #$0010
	STA.w $1700
	SEP.b #$20
	RTS

CODE_0D9094:
	STX.b $00
	STY.b $01
	ASL
	ASL
	ASL
	TAX
	LDY.b #$00
	LDA.b $06
	CMP.b #$D0
	BCC.b CODE_0D90A6
	LDY.b #$04
CODE_0D90A6:
	STY.b $03
	AND.b #$0F
	ASL
	STA.b $04
	STZ.b $05
	LDA.b $02
	CLC
	ADC.b #$20
	ASL
	ROL.b $05
	ASL
	ROL.b $05
	ADC.b $04
	STA.b $04
	LDA.b $05
	ADC.b $03
	STA.b $05
	LDY.b $01
CODE_0D90C6:
	REP.b #$30
	TYA
	AND.w #$00FF
	TAY
	TXA
	AND.w #$00FF
	TAX
	LDA.b $04
	XBA
	STA.w $1701,y
	CLC
	ADC.w #$2000
	STA.w $1709,y
	LDA.w #$0300
	STA.w $1703,y
	STA.w $170B,y
	LDA.w DATA_0D9026,x
	STA.w $1705,y
	LDA.w DATA_0D9026+$02,x
	STA.w $1707,y
	LDA.w DATA_0D9026+$04,x
	STA.w $170D,y
	LDA.w DATA_0D9026+$06,x
	STA.w $170F,y
	LDA.w #$FFFF
	STA.w $1711,y
	SEP.b #$30
	LDX.b $00
	RTS

;--------------------------------------------------------------------

DATA_0D910B:
	db DATA_0D9113,DATA_0D9293,DATA_0D945B,DATA_0D949B

DATA_0D910F:
	db DATA_0D9113>>8,DATA_0D9293>>8,DATA_0D945B>>8,DATA_0D949B>>8

DATA_0D9113:
	db $24,$00,$24,$00,$24,$00,$24,$00,$27,$00,$27,$00,$27,$00,$27,$00
	db $24,$00,$E3,$09,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$E0,$09
	db $24,$00,$24,$00,$24,$00,$D2,$08,$D0,$08,$D3,$08,$D1,$08,$D4,$08
	db $24,$00,$D5,$08,$24,$00,$24,$00,$24,$00,$20,$2A,$24,$00,$20,$2A
	db $24,$00,$81,$28,$24,$00,$20,$2A,$24,$00,$20,$2A,$24,$00,$80,$28
	db $24,$00,$7F,$18,$7F,$18,$24,$00,$B8,$08,$BA,$08,$B9,$08,$BB,$08
	db $B8,$08,$BC,$08,$B9,$08,$BD,$08,$BA,$08,$BC,$08,$BB,$08,$BD,$08
	db $04,$12,$10,$12,$05,$12,$11,$12,$06,$12,$12,$12,$05,$12,$11,$12
	db $06,$12,$12,$12,$07,$12,$13,$12,$04,$12,$10,$12,$07,$12,$13,$12
	db $00,$12,$10,$12,$01,$12,$11,$12,$02,$12,$12,$12,$01,$12,$11,$12
	db $02,$12,$12,$12,$03,$12,$13,$12,$00,$12,$10,$12,$03,$12,$13,$12
	db $60,$08,$64,$08,$61,$08,$65,$08,$62,$08,$66,$08,$63,$08,$67,$08
	db $60,$08,$64,$08,$61,$08,$65,$08,$62,$08,$66,$08,$63,$08,$67,$08
	db $68,$08,$68,$08,$69,$08,$69,$08,$97,$08,$97,$08,$6A,$08,$6A,$08
	db $64,$88,$60,$88,$65,$88,$61,$88,$66,$88,$62,$88,$67,$88,$63,$88
	db $4B,$10,$4C,$10,$4D,$10,$4E,$10,$4D,$10,$4F,$10,$4D,$10,$4A,$10
	db $4D,$10,$4E,$10,$50,$10,$51,$10,$6B,$18,$70,$18,$2C,$18,$2D,$18
	db $6C,$18,$71,$18,$6D,$18,$72,$18,$6E,$18,$73,$18,$6F,$18,$74,$18
	db $6C,$38,$71,$38,$6D,$38,$72,$38,$86,$08,$8A,$08,$87,$08,$8B,$08
	db $88,$08,$8C,$08,$88,$08,$8C,$08,$89,$08,$8D,$08,$69,$08,$69,$08
	db $8E,$08,$91,$08,$8F,$08,$92,$08,$98,$08,$93,$08,$98,$08,$93,$08
	db $90,$08,$94,$08,$69,$08,$69,$08,$4A,$1D,$5A,$1D,$4B,$1D,$5B,$1D
	db $24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$2F,$08,$24,$00,$3D,$08
	db $A2,$18,$A2,$18,$A3,$18,$A3,$18,$24,$00,$24,$00,$24,$00,$24,$00

DATA_0D9293:
	db $A2,$18,$A2,$18,$A3,$18,$A3,$18,$99,$18,$24,$00,$99,$18,$24,$00
	db $24,$00,$A2,$18,$3E,$18,$3F,$18,$5B,$18,$5C,$18,$24,$00,$A3,$18
	db $24,$10,$24,$10,$24,$10,$24,$10,$14,$12,$16,$12,$15,$12,$17,$12
	db $BE,$0C,$BE,$0C,$BF,$0C,$BF,$0C,$75,$18,$9F,$18,$76,$18,$9F,$58
	db $9F,$18,$9F,$18,$9F,$58,$9F,$58,$45,$0C,$47,$0C,$45,$0C,$47,$0C
	db $47,$0C,$47,$0C,$47,$0C,$47,$0C,$27,$0C,$27,$0C,$27,$0C,$27,$0C
	db $47,$0C,$47,$0C,$47,$0C,$47,$0C,$45,$0C,$47,$0C,$45,$0C,$47,$0C
	db $08,$0A,$18,$0A,$09,$0A,$19,$0A,$0A,$0A,$1A,$0A,$0B,$0A,$1B,$0A
	db $45,$0C,$47,$0C,$45,$0C,$47,$0C,$45,$0C,$47,$0C,$45,$0C,$47,$0C
	db $45,$0C,$47,$0C,$45,$0C,$47,$0C,$45,$0C,$47,$0C,$45,$0C,$47,$0C
	db $45,$0C,$47,$0C,$45,$0C,$47,$0C,$45,$0C,$47,$0C,$45,$0C,$47,$0C
	db $47,$0C,$47,$0C,$47,$0C,$47,$0C,$47,$0C,$47,$0C,$47,$0C,$47,$0C
	db $47,$0C,$47,$0C,$47,$0C,$47,$0C,$47,$0C,$47,$0C,$47,$0C,$47,$0C
	db $47,$0C,$47,$0C,$47,$0C,$47,$0C,$47,$0C,$47,$0C,$47,$0C,$47,$0C
	db $24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00
	db $24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00
	db $24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00
	db $AB,$0C,$AC,$0C,$AD,$0C,$AE,$0C,$E6,$09,$F6,$09,$E7,$09,$F7,$09
	db $E8,$09,$F8,$09,$E9,$09,$F9,$09,$E6,$09,$F6,$09,$E9,$09,$F9,$09
	db $CA,$09,$DA,$09,$CB,$09,$DB,$09,$EA,$09,$FA,$09,$EB,$09,$FB,$09
	db $C6,$09,$D6,$09,$C7,$09,$D7,$09,$CA,$29,$DA,$29,$CB,$29,$DB,$29
	db $21,$32,$24,$00,$21,$32,$24,$00,$26,$0E,$28,$0E,$27,$0E,$29,$0E
	db $2A,$0E,$2C,$0E,$2B,$0E,$2D,$0E,$2A,$0C,$2A,$0C,$40,$0C,$40,$0C
	db $24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$47,$0C,$24,$00,$47,$0C
	db $82,$10,$84,$10,$83,$10,$85,$10,$16,$09,$18,$09,$17,$09,$19,$09
	db $18,$09,$19,$09,$18,$09,$19,$09,$82,$30,$84,$30,$83,$30,$85,$30
	db $16,$29,$18,$29,$17,$29,$19,$29,$24,$0C,$47,$0C,$24,$0C,$47,$0C
	db $86,$08,$8A,$08,$87,$08,$8B,$08,$8E,$08,$91,$08,$8F,$08,$92,$08
	db $24,$00,$2F,$00,$24,$00,$3D,$00

DATA_0D945B:
	db $EC,$18,$24,$00,$ED,$18,$24,$00,$C8,$10,$A4,$10,$C9,$10,$A4,$10
	db $E0,$38,$E2,$38,$E1,$38,$E3,$38,$EE,$18,$24,$00,$EF,$18,$24,$00
	db $A4,$10,$A4,$10,$A4,$10,$A4,$10,$96,$38,$96,$38,$96,$38,$96,$38
	db $B0,$10,$B1,$10,$B2,$10,$B3,$10,$9B,$0C,$9D,$0C,$9C,$0C,$9E,$0C

DATA_0D949B:
	db $40,$0E,$50,$0E,$41,$0E,$51,$0E,$42,$0E,$52,$0E,$43,$0E,$53,$0E
	db $44,$0E,$54,$0E,$45,$0E,$55,$0E,$46,$0E,$56,$0E,$47,$0E,$57,$0E
	db $48,$0E,$58,$0E,$49,$0E,$59,$0E,$4A,$0E,$5A,$0E,$4B,$0E,$5B,$0E
	db $4B,$4E,$5B,$4E,$4A,$4E,$5A,$4E,$49,$4E,$59,$4E,$48,$4E,$58,$4E
	db $47,$4E,$57,$4E,$46,$4E,$56,$4E,$45,$4E,$55,$4E,$44,$4E,$54,$4E
	db $43,$4E,$53,$4E,$42,$4E,$52,$4E,$41,$4E,$51,$4E,$40,$4E,$50,$4E
	db $63,$0E,$73,$0E,$5C,$0E,$66,$0E,$5D,$0E,$67,$0E,$62,$0E,$72,$0E
	db $72,$0E,$73,$0E,$5E,$0E,$66,$0E,$5F,$0E,$67,$0E,$73,$0E,$72,$0E
	db $24,$00,$24,$00,$60,$0E,$70,$0E,$61,$0E,$71,$0E,$62,$0E,$72,$0E
	db $63,$0E,$73,$0E,$62,$0E,$72,$0E,$63,$0E,$73,$0E,$64,$0E,$74,$0E
	db $65,$0E,$75,$0E,$24,$00,$24,$00,$24,$00,$24,$00,$4C,$0E,$70,$0E
	db $4D,$0E,$71,$0E,$73,$0E,$72,$0E,$72,$0E,$73,$0E,$73,$0E,$72,$0E
	db $72,$0E,$73,$0E,$4E,$0E,$74,$0E,$4F,$0E,$75,$0E,$24,$00,$24,$00
	db $61,$0E,$66,$0E,$62,$0E,$72,$0E,$63,$0E,$73,$0E,$64,$0E,$67,$0E
	db $72,$0E,$73,$0E,$67,$4E,$66,$8E,$66,$4E,$67,$8E,$73,$0E,$72,$0E
	db $40,$0E,$50,$0E,$44,$0E,$54,$0E,$44,$4E,$54,$4E,$40,$4E,$50,$4E
	db $40,$0E,$50,$0E,$42,$0E,$52,$0E,$43,$0E,$53,$0E,$44,$0E,$54,$0E
	db $44,$4E,$54,$4E,$43,$4E,$53,$4E,$42,$4E,$52,$4E,$40,$4E,$50,$4E
	db $24,$00,$24,$00,$CC,$0C,$CE,$0C,$CD,$0C,$CF,$0C,$24,$00,$24,$00
	db $CC,$0C,$CE,$0C,$CD,$0C,$CF,$0C,$53,$04,$55,$04,$54,$04,$56,$04
	db $53,$04,$55,$04,$54,$04,$56,$04,$53,$04,$55,$04,$54,$04,$56,$04
	db $A5,$04,$A7,$04,$A6,$04,$A8,$04,$A5,$04,$A7,$04,$A6,$04,$A8,$04
	db $EA,$09,$FA,$09,$D2,$09,$E2,$09,$EA,$09,$FA,$09,$F2,$09,$FB,$09
	db $F3,$09,$DA,$09,$CB,$09,$DB,$09,$CA,$09,$DA,$09,$C3,$09,$E2,$09
	db $CA,$09,$DA,$09,$F0,$09,$DB,$09,$D2,$09,$E1,$09,$EB,$09,$FB,$09
	db $F1,$09,$FA,$09,$EB,$09,$FB,$09,$C0,$09,$E1,$09,$CB,$09,$DB,$09
	db $C8,$09,$D4,$09,$C5,$09,$D5,$09,$E4,$09,$F4,$09,$E5,$09,$F5,$09
	db $C8,$09,$D4,$09,$C8,$09,$D4,$09,$E4,$09,$F4,$09,$F4,$09,$E4,$09
	db $CA,$09,$DA,$09,$C3,$09,$D3,$09,$EA,$09,$FA,$09,$D2,$09,$D2,$09
	db $C0,$09,$D0,$09,$CB,$09,$DB,$09,$D2,$09,$D2,$09,$EB,$09,$FB,$09
	db $08,$2A,$18,$2A,$09,$2A,$19,$2A,$57,$0C,$59,$0C,$58,$0C,$5A,$0C
	db $7B,$04,$7D,$04,$7C,$04,$7E,$04

;--------------------------------------------------------------------

CODE_0D9693:
	ASL
	TAY
	PLA
	STA.b $04
	PLA
	STA.b $05
	INY
	LDA.b ($04),y
	STA.b $06
	INY
	LDA.b ($04),y
	STA.b $07
	JMP.w ($0006)

;--------------------------------------------------------------------

if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMBLL_J) == $00
CODE_0D96A8:
	LDA.w !REGISTER_HVBlankFlagsAndJoypadStatus
	LSR
	BCS.b CODE_0D96A8
	STZ.w !REGISTER_JoypadSerialPort1
	LDA.l !SRAM_SMAS_Global_Controller1PluggedInFlag
	TAX
	LDA.w !REGISTER_Joypad1Lo,x
	STA.w !RAM_SMBLL_Global_ControllerHold2
	TAY
	EOR.w !RAM_SMBLL_Global_P1CtrlDisableHi
	AND.w !RAM_SMBLL_Global_ControllerHold2
	STA.w !RAM_SMBLL_Global_ControllerPress2
	STY.w !RAM_SMBLL_Global_P1CtrlDisableHi
	LDA.w !REGISTER_Joypad1Hi,x
	STA.w !RAM_SMBLL_Global_ControllerHold1
	TAY
	EOR.w !RAM_SMBLL_Global_P1CtrlDisableLo
	AND.w !RAM_SMBLL_Global_ControllerHold1
	STA.w !RAM_SMBLL_Global_ControllerPress1
	STY.w !RAM_SMBLL_Global_P1CtrlDisableLo
	RTS
endif

;--------------------------------------------------------------------

CODE_0D96DD:
	STZ.b DMA[$00].Parameters
	REP.b #$20
	STZ.w !REGISTER_OAMAddressLo
	LDA.w #$0004
	STA.b DMA[$00].Destination
	LDA.w #$0008
	STA.b DMA[$00].SourceHi
	LDA.w #$0220
	STA.b DMA[$00].SizeLo
	LDX.b #$01
	STX.w !REGISTER_DMAEnable
	SEP.b #$20
	LDA.b #$80
	STA.w !REGISTER_OAMAddressHi
	STZ.w !REGISTER_OAMAddressLo
	LDA.w $0B76
	BNE.b CODE_0D9714
	JSR.w CODE_0D9755
	LDA.w $028C
	BNE.b CODE_0D9751
	LDA.w $028D
	BEQ.b CODE_0D9751
CODE_0D9714:
	REP.b #$20
	LDA.w $028A
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STA.b DMA[$00].Parameters
	LDA.w $0285
	STA.b DMA[$00].SourceLo
	LDY.w $0287
	STY.b DMA[$00].SourceBank
	LDA.w $0288
	STA.b DMA[$00].SizeLo
	STX.w !REGISTER_DMAEnable
	SEP.b #$20
	LDA.w $0B76
	BEQ.b CODE_0D9751
	DEC.w $0B76
	BEQ.b CODE_0D9751
	LDA.w $0286
	CLC
	ADC.b #$08
	STA.w $0286
	LDA.w $028B
	CLC
	ADC.b #$04
	STA.w $028B
CODE_0D9751:
	STZ.w $028C
	RTS

CODE_0D9755:
	LDA.w $028E
	BEQ.b CODE_0D977B
	REP.b #$20
	LDA.w $0295
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STA.b DMA[$00].Parameters
	LDA.w $028F
	STA.b DMA[$00].SourceLo
	LDY.w $0291
	STY.b DMA[$00].SourceBank
	LDA.w $0293
	STA.b DMA[$00].SizeLo
	STX.w !REGISTER_DMAEnable
	SEP.b #$20
CODE_0D977B:
	RTS

;--------------------------------------------------------------------

; Note: Stripe image upload routine

CODE_0D977C:
	REP.b #$10
	STZ.b $06
	LDY.w #$0000
	LDA.b [$00],y
	BPL.b CODE_0D978A
	SEP.b #$30
	RTS

CODE_0D978A:
	STA.b $04
	INY
	LDA.b [$00],y
	STA.b $03
	INY
	LDA.b [$00],y
	AND.b #$80
	ASL
	ROL
	STA.b $07
	LDA.b [$00],y
	AND.b #$40
	STA.b $05
	LSR
	LSR
	LSR
	ORA.b #$01
	STA.w DMA[$01].Parameters
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$01].Destination
	REP.b #$20
	LDA.b $03
	STA.w !REGISTER_VRAMAddressLo
	LDA.b [$00],y
	XBA
	AND.w #$3FFF
	TAX
	INX
	STX.w DMA[$01].SizeLo
	INY
	INY
	TYA
	CLC
	ADC.b $00
	STA.w DMA[$01].SourceLo
	LDA.b $05
	BEQ.b CODE_0D9800
	INX
	TXA
	LSR
	TAX
	STX.w DMA[$01].SizeLo
	SEP.b #$20
	LDA.b $05
	LSR
	LSR
	LSR
	STA.w DMA[$01].Parameters
	LDA.b $07
	STA.w !REGISTER_VRAMAddressIncrementValue
	LDA.b #$02
	STA.w !REGISTER_DMAEnable
	LDA.b #!REGISTER_WriteToVRAMPortHi
	STA.w DMA[$01].Destination
	REP.b #$21
	TYA
	ADC.b $00
	INC
	STA.w DMA[$01].SourceLo
	LDA.b $03
	STA.w !REGISTER_VRAMAddressLo
	STX.w DMA[$01].SizeLo
	LDX.w #$0002
CODE_0D9800:
	STX.b $03
	TYA
	CLC
	ADC.b $03
	TAY
	SEP.b #$20
	LDA.b $07
	ORA.b #$80
	STA.w !REGISTER_VRAMAddressIncrementValue
	LDA.b #$02
	STA.w !REGISTER_DMAEnable
	LDA.b [$00],y
	BMI.b CODE_0D981C
	JMP.w CODE_0D978A

CODE_0D981C:
	SEP.b #$30
	RTS

;--------------------------------------------------------------------

; Note: Routine that updates the status bar/TOP score.

DATA_0D981F:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	db $58,$6D,$04,$00,$00,$20,$00,$20
	db $58,$62,$0C,$00,$00,$20,$00,$20
	db $00,$20,$00,$20,$00,$20,$00,$20
	db $FF,$7A,$06,$00,$00,$20,$00,$20
	db $00,$20,$FF

DATA_0D9837:
	db $06,$0C,$0C,$04,$04,$1C

DATA_0D983D:
	db $00,$06,$0C,$16,$1C,$21
else
	db $EF,$00,$06,$00,$62,$00,$06,$00
	db $62,$00,$06,$00,$6D,$00,$02,$00
	db $6D,$00,$02,$00,$7A,$00,$03,$00

DATA_0D9837:
	db $06,$0C,$0C,$18,$18,$24
endif

CODE_0D983D:
	STA.b $00
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	CMP.b #$FA
	BEQ.b +++
	LDX.b #$22
-:
	LDA.w DATA_0D981F,x
	STA.w $1620,x
	DEX
	BPL.b -
	LDA.w DATA_0DBAFD
	AND.b #$0F
	JSR.w ++
	LDA.w DATA_0DBAFD
	LSR
	LSR
	LSR
	LSR
	JSR.w ++
	LDA.w $162C
	BNE.b +
	LDA.b #$28
	STA.w $162C
+:
	LDA.b $00
	AND.b #$0F
	CMP.b #$04
	BNE.b +
	LDA.b #$58
	STA.w $1638
	LDA.b #$04
++:
	INC
	TAY
	LDA.w DATA_0D9837,y
	TAX
	LDA.w DATA_0D981F-$02,x
	LSR
	STA.b $02
	LDA.w DATA_0D983D,y
	TAY
-:
	LDA.w !RAM_SMBLL_TitleScreen_TopScoreMillionsDigit,y
	STA.w $1620,x
	INY
	INX
	INX
	DEC.b $02
	BNE.b -
+:
if !Define_Global_ROMToAssemble&(!ROM_SMBLL_E) != $00
+++:
	RTS
else
	RTS

+++:
	LDX.w $1700
	LDA.b #$02
	STA.w $1702,x
	LDA.b #$EF
	STA.w $1703,x
	LDA.b #$00
	STA.w $1704,x
	LDA.b #$0B
	STA.w $1705,x
	LDA.b #$06
	STA.b $02
	LDY.b #$00
-:
	LDA.w !RAM_SMBLL_TitleScreen_TopScoreMillionsDigit,y
	STA.w $1706,x
	LDA.b #$28
	STA.w $1707,x
	INY
	INX
	INX
	DEC.b $02
	BNE.b -
	LDA.b #$FF
	STA.w $1706,x
	INX
	INX
	INX
	INX
	STX.w $1700
	LDA.w $16F6,x
	BNE.b CODE_0D98A9
	LDA.b #$24
	STA.w $16F6,x
endif
else
	JSR.w CODE_0D9848
	LDA.b $00
	LSR
	LSR
	LSR
	LSR
CODE_0D9848:
	INC
	AND.b #$0F
	CMP.b #$06
	BCS.b CODE_0D98A9
	PHA
	ASL
	ASL
	TAY
	LDA.b #$58
	LDX.b #$20
	CPY.b #$00
	BNE.b CODE_0D985F
if !Define_Global_ROMToAssemble&(!ROM_SMBLL_U|!ROM_SMBLL_E|!ROM_SMBLL_J) != $00
	PLA
	RTS
else
	LDA.b #$02
	LDX.b #$08
endif
CODE_0D985F:
	STX.b $F9
	LDX.w $1700
	STA.w $1702,x
	LDA.w DATA_0D981F,y
	STA.w $1703,x
	LDA.w DATA_0D981F+$01,y
	STA.w $1704,x
	LDA.w DATA_0D981F+$02,y
	STA.b $03
	ASL
	DEC
	STA.w $1705,x
	STX.b $02
	PLA
	TAX
	LDA.w DATA_0D9837,x
	SEC
	SBC.w DATA_0D981F+$02,y
	TAY
	LDX.b $02
CODE_0D988B:
	LDA.w !RAM_SMBLL_TitleScreen_TopScoreMillionsDigit,y
	STA.w $1706,x
	LDA.b $F9
	STA.w $1707,x
	INX
	INX
	INY
	DEC.b $03
	BNE.b CODE_0D988B
	LDA.b #$FF
	STA.w $1706,x
	INX
	INX
	INX
	INX
	STX.w $1700
endif
CODE_0D98A9:
	RTS

;--------------------------------------------------------------------

; Note: PAL exclusive routine.

if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
CODE_0D98E3:
	LDA.w $1620
	BMI.b CODE_0D992F
	LDA.b #$00
	STA.w DMA[$00].SourceBank
	LDA.b #$01
	STA.w DMA[$00].Parameters
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination
	LDA.b #$80
	STA.w !REGISTER_VRAMAddressIncrementValue
	LDY.b #$00
	LDA.w $1620,y
CODE_0D9901:
	STA.w !REGISTER_VRAMAddressHi
	INY
	LDA.w $1620,y
	STA.w !REGISTER_VRAMAddressLo
	INY
	REP.b #$21
	LDA.w $1620,y
	STA.w DMA[$00].SizeLo
	STA.b $00
	INY
	INY
	TYA
	ADC.w #$001620
	STA.w DMA[$00].SourceLo
	TYA
	ADC.b $00
	TAY
	SEP.b #$20
	LDA.b #$01
	STA.w !REGISTER_DMAEnable
	LDA.w $1620,y
	BPL.b CODE_0D9901
CODE_0D992F:
	RTS
endif

;--------------------------------------------------------------------

CODE_0D98AA:
	LDA.w $0770
	CMP.b #$00
	BEQ.b CODE_0D98C7
	LDX.b #$05
CODE_0D98B3:
	LDA.w $0145,x
	CLC
	ADC.w !RAM_SMBLL_TitleScreen_TopScoreMillionsDigit,y
	BMI.b CODE_0D98D2
	CMP.b #$0A
	BCS.b CODE_0D98D9
CODE_0D98C0:
	STA.w !RAM_SMBLL_TitleScreen_TopScoreMillionsDigit,y
	DEY
	DEX
	BPL.b CODE_0D98B3
CODE_0D98C7:
	LDA.b #$00
	LDX.b #$06
CODE_0D98CB:
	STA.w $0144,x
	DEX
	BPL.b CODE_0D98CB
	RTS

CODE_0D98D2:
	DEC.w $0144,x
	LDA.b #$09
	BNE.b CODE_0D98C0

CODE_0D98D9:
	CPX.b #$00
	BNE.b CODE_0D98E9
	LDX.b #$05
	LDA.b #$09
CODE_0D98E1:
	STA.w $07CE,x
	DEX
	BNE.b CODE_0D98E1
	LDA.b #$13
CODE_0D98E9:
	SEC
	SBC.b #$0A
	INC.w $0144,x
	JMP.w CODE_0D98C0

;--------------------------------------------------------------------

if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMBLL_J) == $00
CODE_0D98F2:
	PHD
	LDA.b #$0700>>8
	XBA
	LDA.b #$0700
	TCD
	LDX.b #$05
	LDY.b #$05
	SEC
CODE_0D98FE:
	LDA.b $07CE,x
	SBC.w !RAM_SMBLL_TitleScreen_TopScoreMillionsDigit,y
	DEX
	DEY
	BPL.b CODE_0D98FE
	BCC.b CODE_0D9916
	INX
	INY
CODE_0D990B:
	LDA.b $07CE,x
	STA.w !RAM_SMBLL_TitleScreen_TopScoreMillionsDigit,y
	INX
	INY
	CPY.b #$06
	BCC.b CODE_0D990B
CODE_0D9916:
	PLD
	RTS
endif

if !Define_Global_ROMToAssemble&(!ROM_SMBLL_U|!ROM_SMBLL_E|!ROM_SMBLL_J) != $00
elseif !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E) != $00
	%FREE_BYTES(NULLROM, 10, $FF)
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	%FREE_BYTES(NULLROM, 88, $FF)
else
	%FREE_BYTES(NULLROM, 80, $FF)
endif

;--------------------------------------------------------------------

CODE_0D9968:
	LDA.b #$10
	STA.w $07B1
	BNE.b CODE_0D9975
	LDA.w $07B1
	BEQ.b CODE_0D9975
	RTS

CODE_0D9975:
	INC.w $0772
	RTS

;--------------------------------------------------------------------

DATA_0D9979:
	db $42,$73,$0C,$2B

DATA_0D997D:
	db $63,$73,$83

CODE_0D9980:
	LDA.w $0FF6
	AND.b #$0C
	BEQ.b CODE_0D99A5
	LDY.b #!Define_SMAS_Sound0063_Coin
	STY.w !RAM_SMBLL_Global_SoundCh3
	LDY.w $0F06
	AND.b #$08
	BEQ.b CODE_0D9999
	DEY
	BPL.b CODE_0D99A2
	INY
	BRA.b CODE_0D999F

CODE_0D9999:
	INY
	CPY.b #$03
	BNE.b CODE_0D99A2
	DEY
CODE_0D999F:
	STZ.w !RAM_SMBLL_Global_SoundCh3
CODE_0D99A2:
	STY.w $0F06
CODE_0D99A5:
	LDA.w $0F8A
	BNE.b CODE_0D9A11
	LDA.w $0FF6
	AND.b #$10
	BNE.b CODE_0D99F8
	LDA.w $0FF6
	AND.b #$20
	BEQ.b CODE_0D99CA
	LDA.b #!Define_SMAS_Sound0063_Coin
	STA.w !RAM_SMBLL_Global_SoundCh3
	INC.w $0F06
	LDA.w $0F06
	CMP.b #$03
	BNE.b CODE_0D99CA
	STZ.w $0F06
CODE_0D99CA:
	LDA.w !RAM_SMBLL_Global_SoundCh3
	BEQ.b CODE_0D99D2
	STZ.w $0B78
CODE_0D99D2:
	INC.w $0B78
	LDA.w $0B78
	AND.b #$10
	LSR
	LSR
	LSR
	LSR
	ORA.b #$02
	STA.w $0C00
	LDY.b #$03
CODE_0D99E5:
	LDA.w DATA_0D9979,y
	STA.w $0800,y
	DEY
	BPL.b CODE_0D99E5
	LDY.w $0F06
	LDA.w DATA_0D997D,y
	STA.w $0801
	RTS

CODE_0D99F8:
	LDA.b #$20
	STA.w $0F8A
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMBLL_J) == $00
	LDA.b #!Define_SMAS_Sound0060_Pause1
	STA.w !RAM_SMBLL_Global_SoundCh1
endif
	LDA.b #!Define_SMBLL_LevelMusic_CopyOfMusicFade
	STA.w !RAM_SMBLL_Global_MusicCh1
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMBLL_J) != $00
	LDA.b #!Define_SMAS_Sound0060_Pause1
	STA.w !RAM_SMBLL_Global_SoundCh1
endif
	LDA.w $0F06
	BEQ.b CODE_0D9A11
	LDA.b #!Define_SMAS_Sound0060_SaveGame
	STA.w !RAM_SMBLL_Global_SoundCh1
CODE_0D9A11:
	JSR.w CODE_0D99D2
	DEC.w $0F8A
	LDA.w $0F8A
	BEQ.b CODE_0D9A1D
	RTS

CODE_0D9A1D:
	STZ.w $0B78
	LDY.b #$04
	STY.w $075A
	STZ.w $075E
	LDA.b #$00
	LDY.b #$11
CODE_0D9A2C:
	STA.w $07CE,y
	DEY
	BPL.b CODE_0D9A2C
	INC.w $075D
	LDA.w $0F06
	BEQ.b CODE_0D9A49
	JSL.l SMBLL_SaveGame_Main
	LDA.w $0F06
	CMP.b #$01
	BEQ.b CODE_0D9A49
if !Define_Global_ROMToAssemble&(!ROM_SMBLL_U|!ROM_SMBLL_E|!ROM_SMBLL_J) != $00
	JML.l SMBLL_ResetGame_Main
else
	JML.l SMAS_ResetToSMASTitleScreen_Main				; Note: Call to SMAS function
endif

CODE_0D9A49:
	JMP.w CODE_0DA009

;--------------------------------------------------------------------

CODE_0D9A4C:
	LDA.w $0770
	CMP.b #$03
	BEQ.b CODE_0D9A69
	LDA.w $0F07
	BNE.b CODE_0D9A60
	LDA.b #$1D
	STA.w $0773
	INC.w $0F07
CODE_0D9A60:
	LDA.b #$00
	STA.w $0774
	INC.w $073C
	RTS

CODE_0D9A69:
	LDA.b #$20
	STA.w $07B0
	LDA.b #$1E
	STA.w $0773
	INC.w $0772
	RTS

;--------------------------------------------------------------------

DATA_0D9A77:
	db $20,$20,$1E,$28,$28,$0D,$04,$70
	db $70,$60,$90,$90,$0A,$09,$E4,$98
	db $D0,$18,$18,$18,$22,$22,$0D,$04
	db $42,$42,$3E,$5D,$5D,$0A,$09

CODE_0D9A96:
	LDY.b $68,x
	LDY.b #$A2
	RTS

CODE_0D9A9B:
	LDY.b #$21
	LDA.w $0753
	BNE.b CODE_0D9AA6
CODE_0D9AA2:
	LDX.b #$0E
	LDY.b #$10
CODE_0D9AA6:
	STX.w DATA_0DB38E				; Glitch: This is writing to ROM.
	LDX.b #$10
CODE_0D9AAB:
	LDA.w DATA_0D9A77,y
	STA.l DATA_0DB1F9,x				; Glitch: This is writing to ROM.
	DEY
	DEX
	BPL.b CODE_0D9AAB
	RTS

;--------------------------------------------------------------------

CODE_0D9AB7:
	LDA.w $0749
	BNE.b CODE_0D9AD6
	LDY.w $0719
	CPY.b #$0A
	BCS.b CODE_0D9AE8
	INY
	INY
	INY
	CPY.b #$05
	BNE.b CODE_0D9ACF
	LDA.b #$04
	STA.w $00FC
CODE_0D9ACF:
	TYA
	CLC
	ADC.b #$0C
	STA.w $0773
CODE_0D9AD6:
	LDA.w $0749
	CLC
	ADC.b #$04
	STA.w $0749
	LDA.w $0719
	ADC.b #$00
	STA.w $0719
	RTS

CODE_0D9AE8:
	LDA.b #$0C
	STA.w $07B1
CODE_0D9AED:
	INC.w $0772
CODE_0D9AF0:
	LDA.b #$00
	STA.w $0F27
	STA.w $0F28
	STA.w $0F29
CODE_0D9AFB:
	RTS

;--------------------------------------------------------------------

; Note: Unreferenced routine?

ADDR_0D9AFC:
	LDA.w $07B1
	BNE.b CODE_0D9AFB
	LDA.w $075A
	BMI.b ADDR_0D9B20
	LDA.w $0788
	BNE.b CODE_0D9AFB
	LDA.b #$30
	STA.w $0788
	LDA.b #!Define_SMAS_Sound0063_Coin
	STA.w !RAM_SMBLL_Global_SoundCh3
	DEC.w $075A
	LDA.b #$01
	STA.w $0146
	JMP.w CODE_0DD70E

ADDR_0D9B20:
	LDA.b #$05
	STA.w $0F2D
	LDA.b #$00
	STA.w $0F2C
	STZ.w $0F2E
	STZ.w $0F2F
	BRA.b CODE_0D9AED

;--------------------------------------------------------------------

CODE_0D9B32:
	INC.w $0772
	JSR.w CODE_0D9AF0
	LDA.b #$60
	STA.w $0F2A
	RTS

;--------------------------------------------------------------------

; Note: Unreferenced routine?

ADDR_0D9B3E:
	JSR.w CODE_0D9C2B
	LDA.w $0F2D
	BEQ.b ADDR_0D9B65
	REP.b #$20
	LDA.w $0F2C
	XBA
	STA.w $1702
	LDA.w #$7E43
	STA.w $1704
	LDA.w #$0024
	STA.w $1706
	LDA.w #$FFFF
	STA.w $1708
	SEP.b #$20
	BRA.b ADDR_0D9B8E

ADDR_0D9B65:
	LDA.w $0EB8
	BNE.b ADDR_0D9B84
	INC.w $0F2E
	LDA.w $0F2E
	BNE.b ADDR_0D9B8E
	INC.w $0F2F
	LDA.w $0F2F
	CMP.b #$02
	BNE.b ADDR_0D9B8E
	STZ.w $07FA
	LDA.b #$01
	STA.w $07FB
ADDR_0D9B84:
	LDA.w $075F
	CMP.b #$0C
	BEQ.b ADDR_0D9B94
	JMP.w CODE_0D9CC7

ADDR_0D9B8E:
	STZ.w $0EB8
	STZ.w $0F2D
ADDR_0D9B94:
	RTS

;--------------------------------------------------------------------

if !Define_Global_ROMToAssemble&(!ROM_SMBLL_U|!ROM_SMBLL_E|!ROM_SMBLL_J) == $00
UNK_0D9B95:
	db $01,$00,$01,$02,$03,$00,$00,$00,$00,$00

UNK_0D9B9F:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E) != $00
	db $E7,$EB,$ED,$F1,$9B,$9B,$9B,$9B
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	db $6F,$73,$75,$79,$9B,$9B,$9B,$9B
else
	db $A7,$AB,$AD,$B1,$9B,$9B,$9B,$9B
endif
	db $01,$05,$0F,$FF,$20,$FF,$10,$30
	db $0F,$FF,$40,$FF,$03,$01,$03,$01
	db $0F,$20,$20,$20,$20,$20,$20,$20
	db $20,$9F,$D2,$01,$00,$00

if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E) != $00
	db $9F,$D2,$00,$A9,$07,$D5,$9B,$F7
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	db $9F,$D2,$00,$A9,$07,$5D,$9B,$7F
else
	db $9F,$D2,$00,$A9,$07,$95,$9B,$B7
endif
endif

ADDR_0D9BCD:
	TXY
	BEQ.b CODE_0D9BD4
	INC.w $0F09
	RTS

CODE_0D9BD4:
	LDA.b #$00
	STA.w $0F09
	STA.w $0772
	LDA.w $075F
	CMP.b #$0C
	BEQ.b CODE_0D9BF6
	LDA.w !RAM_SMBLL_Level_NoWorld9Flag
	BEQ.b CODE_0D9C01
	LDA.b #$00
	STA.w $0F08
	STA.w $075A
	INC.w $075F
	JMP.w CODE_0D885C

CODE_0D9BF6:
	LDA.b #$00
	STA.w $0F08
	STA.w $0770
	JMP.w CODE_0D84B6

CODE_0D9C01:
	LDA.b #$00
	STA.w $0F08
	STA.w $075A
	STA.w $0F07
	JMP.w CODE_0D885C

;--------------------------------------------------------------------

; Note: Unreferenced routine? (Kind of, it's called in a routine that itself is unreferenced)

DATA_0D9C0F:
	db $50,$B0,$E0,$68,$98,$C8

DATA_0D9C15:
	db $80,$50,$68,$80,$98,$B0,$C8

DATA_0D9C1C:
	db $E0,$B8,$90,$70,$68,$70,$90

DATA_0D9C23:
	db $B8,$38,$48,$60,$80,$A0,$B8,$C8

CODE_0D9C2B:
	LDA.w $0F2A
	BEQ.b CODE_0D9C34
	DEC.w $0F2A
	RTS

CODE_0D9C34:
	JSR.w CODE_0D8418
	LDX.w $0F28
	CPX.b #$07
	BEQ.b CODE_0D9C50
	LDA.w $0F27
	AND.b #$1F
	BNE.b CODE_0D9C66
	INC.w $0F28
	LDA.b #!Define_SMAS_Sound0063_Coin
	STA.w !RAM_SMBLL_Global_SoundCh3
	JMP.w CODE_0D9C66

CODE_0D9C50:
	LDA.w $0F27
	AND.b #$1F
	BNE.b CODE_0D9C66
	INC.w $0F29
	LDA.w $0F29
	CMP.b #$0B
	BCC.b CODE_0D9C66
	LDA.b #$04
	STA.w $0F29
CODE_0D9C66:
	INC.w $0F27
	LDA.w $075F
	PHA
	LDA.w $0F28
	PHA
	TAX
CODE_0D9C72:
	LDA.w $0F29
	CMP.b #$04
	BCC.b CODE_0D9C84
	SBC.b #$04
	TAY
	LDA.w DATA_0D9C0F,y
	CMP.w DATA_0D9C15,x
	BEQ.b CODE_0D9CA9
CODE_0D9C84:
	LDY.w DATA_0D9C15,x
	STY.w $0B46
	LDA.b #$35
	STA.w !RAM_SMBLL_NorSpr_SpriteID
	LDA.w DATA_0D9C1C,x
	STA.w $0238
	LDA.w DATA_0D9C23,x
	STA.w $03AE
	LDX.b #$00
	STX.w $075F
	STX.w $009E
	JSR.w CODE_0DEE40
	DEC.w $0F4A
CODE_0D9CA9:
	DEC.w $0F28
	LDX.w $0F28
	BNE.b CODE_0D9C72
	INC.w $0F4A
	PLA
	STA.w $0F28
	PLA
	STA.w $075F
	LDA.b #$30
	STA.w $0B46
	LDA.b #$B8
	STA.w $0238
	RTS

;--------------------------------------------------------------------

CODE_0D9CC7:
	JSL.l CODE_0FFBC5
	BCS.b CODE_0D9CCE
	RTS

CODE_0D9CCE:
	LDA.b #$01
	STA.w $0E1A
	JMP.w CODE_0D9BD4

if !Define_Global_ROMToAssemble&(!ROM_SMBLL_U|!ROM_SMBLL_E|!ROM_SMBLL_J) != $00
elseif !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E) != $00
	%FREE_BYTES(NULLROM, 10, $FF)
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	%FREE_BYTES(NULLROM, 34, $FF)
else
	%FREE_BYTES(NULLROM, 26, $FF)
endif

;--------------------------------------------------------------------

DATA_0D9CF0:
	db $D0,$00,$18,$30,$48,$60,$78,$90
	db $A8,$C0,$D8,$D8,$B0,$C0,$40,$44
	db $48,$50,$54,$60,$68,$70,$78,$80
	db $88,$00,$08,$10,$18,$18,$FF,$23
	db $58

;--------------------------------------------------------------------

CODE_0D9D11:
	LDA.b #$80
	STA.w !RAM_SMBLL_Global_ScreenDisplayRegisterMirror
	LDA.b #$FF
	STA.l $001102						;\ Optimization: Unnecessary long addressing
	LDA.b #$7F						;|
	STA.l $001103						;/
	INC.w !RAM_SMBLL_Global_UpdateEntirePaletteFlag
	LDA.b #$FF
	STA.w $1702
	STA.w $1703
	LDA.b #$09
	STA.w !RAM_SMBLL_Global_BGModeAndTileSizeSettingMirror
	LDA.b #$10
	STA.w !RAM_SMBLL_Global_MainScreenLayersMirror
	LDA.b #$20
	STA.w $120A
	LDA.b #$20
	STA.w !RAM_SMBLL_Global_FixedColorData1Mirror
	LDA.b #$40
	STA.w !RAM_SMBLL_Global_FixedColorData2Mirror
	LDA.b #$80
	STA.w !RAM_SMBLL_Global_FixedColorData3Mirror
	LDY.b #$FE
	LDX.b #$05
CODE_0D9D4F:
	LDA.w !RAM_SMBLL_TitleScreen_TopScoreMillionsDigit,x
	CMP.b #$0A
	BCS.b CODE_0D9D62
	DEX
	BPL.b CODE_0D9D4F
	LDA.w $07FF
	CMP.b #$A5
	BNE.b CODE_0D9D62
	LDY.b #$C7
CODE_0D9D62:
	JSL.l CODE_0FF784
	LDA.b #$A5
	STA.w $07FF
	STA.w $07B7
	STZ.w $0EF6
	STZ.w $0EF9
	STZ.w $0EF7
	STZ.w $0EF8
	LDY.b #$6F
	JSL.l CODE_0FF784
	LDA.b #$18
	STA.w $07B2
	JSL.l CODE_0EC34C
	JSR.w CODE_0D9D90
	STZ.w $0E7F
	RTS

;--------------------------------------------------------------------

CODE_0D9D90:
	LDY.w $075F
	CPY.b #$0D
	BCC.b CODE_0D9D9B
	JSL.l CODE_0EC34C
CODE_0D9D9B:
	LDY.b #$4B
	JSL.l CODE_0FF784
	LDX.b #$29
	LDA.b #$00
CODE_0D9DA5:
	STA.w $0788,x
	DEX
	BPL.b CODE_0D9DA5
	LDA.w $075B
	LDY.w $0752
	BEQ.b CODE_0D9DB6
	LDA.w $0751
CODE_0D9DB6:
	STA.w $071A
	STA.w $0725
	STA.w $0728
	PHY
	REP.b #$20
	XBA
	AND.w #$FF00
	STA.b $42
	LSR
	STA.w $0EFD
	LSR
	STA.w $0EEE
	SEP.b #$20
	PLY
	JSR.w CODE_0DAD3E
	LDY.b #$00
	AND.b #$01
	BEQ.b CODE_0D9DDE
	LDY.b #$04
CODE_0D9DDE:
	STY.w $0720
	STZ.w $0721
	ASL
	ASL
	ASL
	ASL
	STA.w $06A0
	LDA.b #$FF
	STA.w $1300
	STA.w $1301
	STA.w $1302
	STA.w $1303
	STA.w $1304
	LDA.b #$0B
	STA.w $071E
	JSL.l CODE_0EC3BD
	LDA.w $07FB
	BNE.b CODE_0D9E1A
	LDA.w $075F
	CMP.b #$03
	BCC.b CODE_0D9E1D
	BNE.b CODE_0D9E1A
	LDA.w $075C
	CMP.b #$03
	BCC.b CODE_0D9E1D
CODE_0D9E1A:
	INC.w $06CC
CODE_0D9E1D:
	LDA.w $075B
	BEQ.b CODE_0D9E27
	LDA.b #$02
	STA.w $0710
CODE_0D9E27:
	LDA.b $DB
	CMP.b #$07
	BEQ.b CODE_0D9E36
	CMP.b #$41
	BEQ.b CODE_0D9E36
	LDA.b #!Define_SMBLL_LevelMusic_MusicFade
	STA.w !RAM_SMBLL_Global_MusicCh1
CODE_0D9E36:
	LDA.b #$01
	STA.w $0E7F
	INC.w $0772
	RTS

;--------------------------------------------------------------------

CODE_0D9E3F:
	LDA.w !REGISTER_APUPort2
	CMP.b #!Define_SMBLL_LevelMusic_SMBLLTitleScreen
	BEQ.b CODE_0D9E4F
	JSL.l SMBLL_CheckWhichControllersArePluggedIn_Main				; Note: Call to SMAS function
	LDA.b #!Define_SMBLL_LevelMusic_SMBLLTitleScreen
	STA.w !REGISTER_APUPort2
if !Define_Global_ROMToAssemble&(!ROM_SMBLL_U|!ROM_SMBLL_E|!ROM_SMBLL_J) != $00
	LDA.b #$04									;\ Note: This is needed to give the title screen music a chance to play
	STA.w $160C									;/ A value of #$02 is good enough, but I set it to #$04 just to be safe
endif
CODE_0D9E4F:
	LDA.b #$01
	STA.w $0757
	STA.w $0754
	STZ.w $0E73
CODE_0D9E5A:
	LDA.b #$02
	STA.w $0E7F
	LDA.b #!Define_SMAS_Sound0061_TurnOffWind
	TSB.w !RAM_SMBLL_Global_SoundCh2
	LDA.b #$00
	STA.w !RAM_SMBLL_Global_ScreenDisplayRegisterMirror
	STA.w $0774
	STA.w $0F04
	STA.w $0F02
	TAY
CODE_0D9E73:
	STA.w $0300,y
CODE_0D9E74:
	INY
	BNE.b CODE_0D9E73
	STA.w $0759
	STA.w $0769
	STA.w $0728
	LDA.b #$FF
	STA.w $03A0
	STA.w $1702
	LDA.w $071A
	AND.b #$01
	STA.w $0F05
	LDA.b #$38
	STA.w $0B43
	LDA.b #$48
	STA.w $0B42
	LDA.b #$58
	STA.w $0B41
	LDX.b #$1C
CODE_0D9EA3:
	LDA.w DATA_0D9CF0,x
	STA.w $0B45,x
	DEX
	BPL.b CODE_0D9EA3
	JSR.w CODE_0DA04E
	INC.w $0722
	INC.w $0772
	RTS

;--------------------------------------------------------------------

DATA_0D9EB6:
	db $28,$18

DATA_0D9EB8:
	db $38,$28,$08,$00

DATA_0D9EBC:
	db $00,$20,$B0,$50,$00,$00,$B0,$B0
	db $F0

DATA_0D9EC5:
	db $2E,$0E,$2E,$2E,$2E,$2E,$2E,$2E

DATA_0D9ECD:
	db $0E,$04,$03,$02

CODE_0D9ED1:
	LDA.w $071A
	STA.b $78
	LDA.b #$28
	STA.w $070A
	LDA.b #$01
	STA.w $0202
	STA.b $BB
	LDA.b #$00
	STA.b $28
	DEC.w $0480
	LDY.b #$00
	STY.w $075B
	LDA.b $5C
	BNE.b CODE_0D9EF3
	INY
CODE_0D9EF3:
	STY.w $0704
	LDX.w $0710
	LDY.w $0752
	BEQ.b CODE_0D9F05
	CPY.b #$01
	BEQ.b CODE_0D9F05
	LDX.w DATA_0D9EB8,y
CODE_0D9F05:
	LDA.w DATA_0D9EB6,y
	STA.w $0219
	LDA.w DATA_0D9EBC,x
	STA.w $0237
	LDA.w DATA_0D9EC5,x
	STA.w $0256
	LDX.b #$00
	JSR.w CODE_0DE9A9
	JSL.l CODE_0E98C3
	LDY.w $0715
	BEQ.b CODE_0D9F3F
	LDA.w $0757
	BEQ.b CODE_0D9F3F
	LDA.w DATA_0D9ECD,y
	STA.w $07E9
	LDA.b #$01
	STA.w $07EB
	LSR
	STA.w $07EA
	STA.w $0757
	STA.w $07AF
CODE_0D9F3F:
	LDY.w $0758
	BEQ.b CODE_0D9F58
	LDA.b #$03
	STA.b $28
	LDX.b #$00
	JSR.w CODE_0DBCE2
	LDA.b #$F0
	STA.b $44
	LDX.b #$09
	LDY.b #$00
	JSR.w CODE_0DB7C9
CODE_0D9F58:
	LDY.b $5C
	BNE.b CODE_0D9F5F
	JSR.w CODE_0DB542
CODE_0D9F5F:
	LDA.b #$07
	STA.b $0F
	RTS

;--------------------------------------------------------------------

DATA_0D9F64:
	db $66,$60,$88,$60,$66,$70,$77,$60
	db $D6,$00,$77,$80,$70,$B0,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00

CODE_0D9F7E:
	LDA.b #$01
	STA.w $0E7F
	STA.w $0E67
	STZ.w $0722
	DEC.w $075A
	BPL.b CODE_0D9F97
	STZ.w $0772
	LDA.b #$03
	STA.w $0770
	RTS

CODE_0D9F97:
	LDA.w $075F
	ASL
	TAX
	LDA.w $075C
	AND.b #$02
	BEQ.b CODE_0D9FA4
	INX
CODE_0D9FA4:
	LDY.w DATA_0D9F64,x
	LDA.w $075C
	LSR
	TYA
	BCS.b CODE_0D9FB2
	LSR
	LSR
	LSR
	LSR
CODE_0D9FB2:
	AND.b #$0F
	CMP.w $071A
	BEQ.b CODE_0D9FBD
	BCC.b CODE_0D9FBD
	LDA.b #$00
CODE_0D9FBD:
	STA.w $075B
	JSR.w CODE_0DA026
	JMP.w CODE_0DA009

;--------------------------------------------------------------------

CODE_0D9FC6:
	LDA.w $0772
	ASL
	TAX
	JMP.w (DATA_0D9FCE,x)

DATA_0D9FCE:
	dw CODE_0D9FD4
	dw CODE_0D89BD
	dw CODE_0D9FEC

;--------------------------------------------------------------------

CODE_0D9FD4:
	STZ.w $073C
	STZ.w $0722
	STZ.w $0F06
	STZ.w $0B78
	LDA.b #!Define_SMBLL_LevelMusic_GameOver
	STA.w !RAM_SMBLL_Global_MusicCh1
	INC.w $0774
	INC.w $0772
	RTS

;--------------------------------------------------------------------

CODE_0D9FEC:
	JMP.w CODE_0D9980

;--------------------------------------------------------------------

CODE_0D9FEF:
	LDA.w $07B0
	BNE.b CODE_0DA008
CODE_0D9FF4:
	JSR.w CODE_0DA026
	BCC.b CODE_0DA009
	LDA.w $075F
	STA.w $07FD
	STZ.w $0772
	STZ.w $07B0
	STZ.w $0770
CODE_0DA008:
	RTS

CODE_0DA009:
	JSL.l CODE_0EC34C
	LDA.b #$01
	STA.w $0754
	INC.w $0757
	STZ.w $0747
	STZ.w $0756
	STZ.b $0F
	STZ.w $0772
	LDA.b #$01
	STA.w $0770
	RTS

;--------------------------------------------------------------------

CODE_0DA026:
	SEC
	LDA.w $077A
	BEQ.b CODE_0DA04D
	LDA.w $0761
	BMI.b CODE_0DA04D
	LDA.w $0753
	EOR.b #$01
	STA.w $0753
	LDX.b #$06
CODE_0DA03B:
	LDA.w $075A,x
	PHA
	LDA.w $0761,x
	STA.w $075A,x
	PLA
	STA.w $0761,x
	DEX
	BPL.b CODE_0DA03B
	CLC
CODE_0DA04D:
	RTS

;--------------------------------------------------------------------

CODE_0DA04E:
	LDA.b #$FF
	STA.w $06C9
	RTS

;--------------------------------------------------------------------

CODE_0DA054:
	LDY.w $071F
	BNE.b CODE_0DA05E
	LDY.b #$08
	STY.w $071F
CODE_0DA05E:
	DEY
	TYA
	JSR.w CODE_0DA0BF
	DEC.w $071F
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDA.b #$10
else
	BNE.b CODE_0DA09D
	LDA.b #$20
endif
	STA.b $00
	LDA.b $BA
	CMP.b #$03
	BNE.b CODE_0DA074
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDA.b #$40
	STA.b $00
else
	ASL.b $00
endif
CODE_0DA074:
	LDA.w $0ED1
	BNE.b CODE_0DA09D
	LDA.w $0EFD
	AND.b $00
	BEQ.b CODE_0DA087
	LDA.w $0EFC
	BEQ.b CODE_0DA091
	BRA.b CODE_0DA09D

CODE_0DA087:
	LDA.w $0EFC
	BEQ.b CODE_0DA09D
	STZ.w $0EFC
	BRA.b CODE_0DA096

CODE_0DA091:
	LDA.b #$01
	STA.w $0EFC
CODE_0DA096:
	JSL.l CODE_0E9970
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) == $00
	JSR.w CODE_0D9024
endif
CODE_0DA09D:
	LDA.w $0EEE
	AND.b #$10
	BEQ.b CODE_0DA0AB
	LDA.w $0EDD
	BEQ.b CODE_0DA0B5
	BRA.b CODE_0DA0BE

CODE_0DA0AB:
	LDA.w $0EDD
	BEQ.b CODE_0DA0BE
	STZ.w $0EDD
	BRA.b CODE_0DA0BA

CODE_0DA0B5:
	LDA.b #$01
	STA.w $0EDD
CODE_0DA0BA:
	JSL.l CODE_0E85DD
CODE_0DA0BE:
	RTS

CODE_0DA0BF:
	ASL
	TAX
	JMP.w (DATA_0DA0C4,x)

DATA_0DA0C4:
	dw CODE_0DA0D4
	dw CODE_0D8EF0
	dw CODE_0D8EF0
	dw CODE_0DA165
	dw CODE_0DA0D4
	dw CODE_0D8EF0
	dw CODE_0D8EF0
	dw CODE_0DA165

;--------------------------------------------------------------------

CODE_0DA0D4:
	INC.w $0726
	LDA.w $0726
	AND.b #$0F
	BNE.b CODE_0DA0E4
	STA.w $0726
	INC.w $0725
CODE_0DA0E4:
	INC.w $06A0
	LDA.w $06A0
	AND.b #$1F
	STA.w $06A0
	RTS

;--------------------------------------------------------------------

DATA_0DA0F0:
	db $00,$30,$60

DATA_0DA0F3:
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$04,$00,$00,$05,$00,$00,$06
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$45,$00,$00,$0B,$0D
	db $46,$0C,$46

DATA_0DA116:
	db $46,$00,$0D,$1A

DATA_0DA11A:
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$70,$70,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$82,$85

DATA_0DA141:
	db $71,$4E,$4A,$63

DATA_0DA145:
	db $00,$00,$00,$18,$01,$18,$07,$18
	db $0F,$18,$FF,$18,$01,$1F,$07,$1F
	db $0F,$1F,$81,$1F,$01,$00,$8F,$1F
	db $F1,$1F,$F9,$18,$F1,$18,$FF,$1F

CODE_0DA165:
	LDA.w $0728
	BEQ.b CODE_0DA16D
	JSR.w CODE_0DA316
CODE_0DA16D:
	LDX.b #$0C
	LDA.b #$00
CODE_0DA171:
	STA.w $06A1,x
	DEX
	BPL.b CODE_0DA171
	LDY.w $0742
	BEQ.b CODE_0DA1BF
	LDA.w $0725
CODE_0DA17F:
	CMP.b #$03
	BMI.b CODE_0DA188
	SEC
	SBC.b #$03
	BPL.b CODE_0DA17F
CODE_0DA188:
	ASL
	ASL
	ASL
	ASL
	ADC.w DATA_0DA0F0-$01,y
	ADC.w $0726
	TAX
	LDA.l DATA_0FF7CB,x
	BEQ.b CODE_0DA1BF
	PHA
	AND.b #$0F
	SEC
	SBC.b #$01
	STA.b $00
	ASL
	ADC.b $00
	TAX
	PLA
	LSR
	LSR
	LSR
	LSR
	TAY
	LDA.b #$03
	STA.b $00
CODE_0DA1AF:
	LDA.w DATA_0DA0F3,x
	STA.w $06A1,y
	INX
	INY
	CPY.b #$0B
	BEQ.b CODE_0DA1BF
	DEC.b $00
	BNE.b CODE_0DA1AF
CODE_0DA1BF:
	LDX.w $0741
	BEQ.b CODE_0DA1FD
	LDY.w DATA_0DA116,x
	LDX.b #$00
CODE_0DA1C9:
	LDA.w DATA_0DA11A,y
	BEQ.b CODE_0DA1F7
	PHY
	LDY.b $5C
	BNE.b CODE_0DA1E9
	LDY.b $DB
	CPY.b #$45
	BEQ.b CODE_0DA1F3
	LDY.w $0EF0
	BNE.b CODE_0DA1E4
	INC.w $0EF0
	INC
	BRA.b CODE_0DA1F1

CODE_0DA1E4:
	STZ.w $0EF0
	BRA.b CODE_0DA1F3

CODE_0DA1E9:
	CPY.b #$03
	BNE.b CODE_0DA1F3
	CMP.b #$86
	BNE.b CODE_0DA1F3
CODE_0DA1F1:
	INC
	INC
CODE_0DA1F3:
	PLY
	STA.w $06A1,x
CODE_0DA1F7:
	INY
	INX
	CPX.b #$0D
	BNE.b CODE_0DA1C9
CODE_0DA1FD:
	STZ.w $0109
	STZ.b $F9
	LDA.w $0EE8
	STA.w $0EE9
	INC.w $0EE8
	LDY.b $5C
	BNE.b CODE_0DA219
	LDA.b $DB
	CMP.b #$41
	BNE.b CODE_0DA219
	LDA.b #$63
	BRA.b CODE_0DA223

CODE_0DA219:
	LDA.w DATA_0DA141,y
	LDY.w $0743
	BEQ.b CODE_0DA223
	LDA.b #$86
CODE_0DA223:
	STA.b $07
	LDX.b #$00
	LDA.w $0727
	ASL
	TAY
CODE_0DA22C:
	LDA.w DATA_0DA145,y
	STA.b $00
	INY
	STY.b $01
	LDA.w $0743
	BEQ.b CODE_0DA243
	CPX.b #$00
	BEQ.b CODE_0DA243
	LDA.b $00
	AND.b #$08
	STA.b $00
CODE_0DA243:
	LDY.b #$00
CODE_0DA245:
	LDA.w DATA_0DC97F,y
	BIT.b $00
	BEQ.b CODE_0DA29C
	LDA.w $00DB
	CMP.b #$09
	BEQ.b CODE_0DA263
	LDA.b $BA
	CMP.b #$03
	BNE.b CODE_0DA263
	LDA.b $F9
	BEQ.b CODE_0DA263
	LDA.b #$66
	STA.b $07
	BRA.b CODE_0DA265

CODE_0DA263:
	LDA.b $07
CODE_0DA265:
	STA.w $06A1,x
	LDA.b $F9
	BEQ.b CODE_0DA280
	LDA.b $BA
	CMP.b #$03
	BNE.b CODE_0DA280
	LDA.b $F9
	INC.b $F9
	INC
	BNE.b CODE_0DA2A3
	INC.w $06A1,x
	INC.b $07
	BRA.b CODE_0DA2A3

CODE_0DA280:
	LDA.b $BA
	CMP.b #$03
	BNE.b CODE_0DA2A3
	LDA.w $0743
	BNE.b CODE_0DA2A3
	LDA.w $0109
	BNE.b CODE_0DA2A3
	LDA.w $0EE9
	AND.b #$01
	BNE.b CODE_0DA2A3
	INC.w $06A1,x
	BRA.b CODE_0DA2A3

CODE_0DA29C:
	LDA.b #$FE
	STA.b $F9
	INC.w $0109
CODE_0DA2A3:
	INX
	CPX.b #$0D
	BEQ.b CODE_0DA2C5
	LDA.b $5C
	CMP.b #$02
	BNE.b CODE_0DA2B6
	CPX.b #$0B
	BNE.b CODE_0DA2B6
	LDA.b #$4E
	STA.b $07
CODE_0DA2B6:
	INC.w $0EE9
	INY
	CPY.b #$08
	BNE.b CODE_0DA245
	LDY.b $01
	BEQ.b CODE_0DA2C5
	JMP.w CODE_0DA22C

CODE_0DA2C5:
	LDA.w $06AD
	CMP.b #$4E
	BEQ.b CODE_0DA2D0
	CMP.b #$71
	BNE.b CODE_0DA2D3
CODE_0DA2D0:
	INC.w $06AD
CODE_0DA2D3:
	JSR.w CODE_0DA316
	LDA.w $06A0
	JSR.w CODE_0DAA8F
	LDA.w $06AC
	CMP.b #$70
	BNE.b CODE_0DA2E6
	STA.w $06AD
CODE_0DA2E6:
	LDX.b #$00
	TXY
CODE_0DA2E9:
	STY.b $00
	LDA.w $0EC9
	BNE.b CODE_0DA311
	LDA.w $06A1,x
	AND.b #$C0
	ASL
	ROL
	ROL
	TAY
	LDA.w $06A1,x
	CMP.w DATA_0DA312,y
	BCS.b CODE_0DA303
	LDA.b #$00
CODE_0DA303:
	LDY.b $00
	STA.b ($06),y
	TYA
	CLC
	ADC.b #$10
	TAY
	INX
	CPX.b #$0D
	BCC.b CODE_0DA2E9
CODE_0DA311:
	RTS

DATA_0DA312:
	db $16,$49,$86,$E7

;--------------------------------------------------------------------

CODE_0DA316:
	REP.b #$10
	LDX.w #$0004
CODE_0DA31B:
	STZ.w $010B
	STX.b $9E
	STZ.w $0729
	LDY.w $072C
	LDA.b [$FA],y
	CMP.b #$FD
	BEQ.b CODE_0DA38F
	AND.b #$0F
	CMP.b #$0F
	BNE.b CODE_0DA335
	INC.w $010B
CODE_0DA335:
	LDA.w $1300,x
	BPL.b CODE_0DA38F
	LDA.w $010B
	BEQ.b CODE_0DA340
	INY
CODE_0DA340:
	INY
	LDA.b [$FA],y
	ASL
	BCC.b CODE_0DA351
	LDA.w $072B
	BNE.b CODE_0DA351
	INC.w $072B
	INC.w $072A
CODE_0DA351:
	LDY.w $072C
	LDA.b [$FA],y
	AND.b #$0F
	CMP.b #$0D
	BNE.b CODE_0DA37E
	INY
	LDA.b [$FA],y
	LDY.w $072C
	AND.b #$40
	BNE.b CODE_0DA387
	LDA.w $072B
	BNE.b CODE_0DA387
	LDA.w $010B
	BEQ.b CODE_0DA371
	INY
CODE_0DA371:
	INY
	LDA.b [$FA],y
	AND.b #$1F
	STA.w $072A
	INC.w $072B
	BRA.b CODE_0DA399

CODE_0DA37E:
	CMP.b #$0E
	BNE.b CODE_0DA387
	LDA.w $0728
	BNE.b CODE_0DA38F
CODE_0DA387:
	LDA.w $072A
	CMP.w $0725
	BCC.b CODE_0DA396
CODE_0DA38F:
	JSR.w CODE_0DA3DD
	REP.b #$10
	BRA.b CODE_0DA39C

CODE_0DA396:
	INC.w $0729
CODE_0DA399:
	JSR.w CODE_0DA3BF
CODE_0DA39C:
	LDX.b $9E
	LDA.w $1300,x
	BMI.b CODE_0DA3A6
	DEC.w $1300,x
CODE_0DA3A6:
	DEX
	BMI.b CODE_0DA3AC
	JMP.w CODE_0DA31B

CODE_0DA3AC:
	LDA.w $0729
	BEQ.b CODE_0DA3B4
	JMP.w CODE_0DA316

CODE_0DA3B4:
	LDA.w $0728
	BEQ.b CODE_0DA3BC
	JMP.w CODE_0DA316

CODE_0DA3BC:
	SEP.b #$10
	RTS

CODE_0DA3BF:
	REP.b #$20
	INC.w $072C
	INC.w $072C
	LDA.w $010B
	AND.w #$00FF
	BEQ.b CODE_0DA3D2
	INC.w $072C
CODE_0DA3D2:
	SEP.b #$20
	LDA.b #$00
	STA.w $072B
	STA.w $010B
	RTS

CODE_0DA3DD:
	REP.b #$30
	TXA
	AND.w #$00FF
	TAX
	SEP.b #$20
	LDA.w $1300,x
	BMI.b CODE_0DA3F5
	REP.b #$20
	TXA
	ASL
	TAX
	LDY.w $1305,x
	SEP.b #$20
CODE_0DA3F5:
	LDA.w $0F82
	BEQ.b CODE_0DA402
	JSL.l CODE_0E82EE
	STZ.w $0F82
	RTS

CODE_0DA402:
	STY.b $F7
	STZ.b $F6
	STZ.w $010B
	LDX.w #$0010
	LDA.b [$FA],y
	CMP.b #$FD
	BEQ.b CODE_0DA3BC
	AND.b #$0F
	CMP.b #$0F
	BNE.b CODE_0DA41C
	INC.b $F6
	BRA.b CODE_0DA426

CODE_0DA41C:
	LDX.w #$0008
	CMP.b #$0C
	BEQ.b CODE_0DA426
	LDX.w #$0000
CODE_0DA426:
	STX.b $07
	LDX.b $9E
	CMP.b #$0E
	BNE.b CODE_0DA434
	STZ.b $07
	LDA.b #$36
	BNE.b CODE_0DA491

CODE_0DA434:
	CMP.b #$0D
	BNE.b CODE_0DA457
	LDA.b #$28
	STA.b $07
	LDA.b $F6
	BEQ.b CODE_0DA441
	INY
CODE_0DA441:
	INY
	LDA.b [$FA],y
	AND.b #$40
	BEQ.b CODE_0DA4B0
	LDA.b [$FA],y
	AND.b #$7F
	CMP.b #$4B
	BNE.b CODE_0DA453
	INC.w $0745
CODE_0DA453:
	AND.b #$3F
	BRA.b CODE_0DA491

CODE_0DA457:
	CMP.b #$0C
	BCS.b CODE_0DA483
	LDA.b $F6
	BEQ.b CODE_0DA460
	INY
CODE_0DA460:
	INY
	LDA.b [$FA],y
	AND.b #$70
	BNE.b CODE_0DA471
	LDA.b #$18
	STA.b $07
	LDA.b [$FA],y
	AND.b #$0F
	BRA.b CODE_0DA491

CODE_0DA471:
	STA.b $00
	CMP.b #$70
	BNE.b CODE_0DA47F
	LDA.b [$FA],y
	AND.b #$08
	BEQ.b CODE_0DA47F
	STZ.b $00
CODE_0DA47F:
	LDA.b $00
	BRA.b CODE_0DA48D

CODE_0DA483:
	LDA.b $F6
	BEQ.b CODE_0DA488
	INY
CODE_0DA488:
	INY
	LDA.b [$FA],y
	AND.b #$70
CODE_0DA48D:
	LSR
	LSR
	LSR
	LSR
CODE_0DA491:
	STA.b $00
	LDA.w $1300,x
	BPL.b CODE_0DA4F0
	LDA.w $072A
	CMP.w $0725
	BEQ.b CODE_0DA4B3
	LDY.w $072C
	LDA.b [$FA],y
	AND.b #$0F
	CMP.b #$0E
	BNE.b CODE_0DA4B0
	LDA.w $0728
	BNE.b CODE_0DA4D7
CODE_0DA4B0:
	SEP.b #$10
	RTS

CODE_0DA4B3:
	LDA.w $0728
	BEQ.b CODE_0DA4C7
	LDA.b #$00
	STA.w $0728
	STA.w $0729
	STA.b $9E
	STA.b $9F
CODE_0DA4C4:
	SEP.b #$10
	RTS

CODE_0DA4C7:
	LDY.w $072C
	LDA.b [$FA],y
	AND.b #$F0
	LSR
	LSR
	LSR
	LSR
	CMP.w $0726
	BNE.b CODE_0DA4B0
CODE_0DA4D7:
	PHX
	REP.b #$20
	TXA
	ASL
	TAX
	LDA.w $072C
	STA.w $1305,x
	SEP.b #$20
	PLX
	LDA.b $F6
	BEQ.b CODE_0DA4ED
	INC.w $010B
CODE_0DA4ED:
	JSR.w CODE_0DA3BF
CODE_0DA4F0:
	LDA.b $F6
	BEQ.b CODE_0DA4FD
	LDY.b $F7
	JSL.l CODE_0E88C0
	SEP.b #$10
	RTS

CODE_0DA4FD:
	SEP.b #$10
	LDA.b $00
	CLC
	ADC.b $07
	ASL
	TAY
	LDA.w DATA_0DA513,y
	STA.b $04
	LDA.w DATA_0DA513+$01,y
	STA.b $05
	JMP.w ($0004)

DATA_0DA513:
	dw CODE_0DA76E
	dw CODE_0DA644
	dw CODE_0DA8F6
	dw CODE_0DA904
	dw CODE_0DA8BD
	dw CODE_0DA915
	dw CODE_0DA91C
	dw CODE_0DA76E
	dw CODE_0DA9DC
	dw CODE_0DA6FF
	dw CODE_0DA843
	dw CODE_0DA847
	dw CODE_0DA84B
	dw CODE_0DA811
	dw CODE_0DA831
	dw CODE_0DA835
	dw CODE_0DA58B
	dw CODE_0DA58B
	dw CODE_0DA58B
	dw CODE_0DA58B
	dw CODE_0DA58B
	dw CODE_0DA58B
	dw CODE_0DA58B
	dw CODE_0DA58B
	dw CODE_0DA9AC
	dw CODE_0DA9AC
	dw CODE_0DA9AC
	dw CODE_0DA9AC
	dw CODE_0DA9A2
	dw CODE_0DA9AC
	dw CODE_0DA9AC
	dw CODE_0DA9B5
	dw CODE_0DA9B5
	dw CODE_0DA9B5
	dw CODE_0DA9B5
	dw CODE_0DA9B2
	dw CODE_0DA9B5
	dw CODE_0DA704
	dw CODE_0DA8E1
	dw CODE_0DA967
	dw CODE_0DA717
	dw CODE_0DA877
	dw CODE_0DA8D2
	dw CODE_0DA8D7
	dw CODE_0DA8CB
	dw CODE_0DA5C4
	dw CODE_0DA611
	dw CODE_0DA611
	dw CODE_0DA62F
	dw CODE_0DA62F
	dw CODE_0DA62F
	dw CODE_0DA4C4
	dw CODE_0DA581
	dw CODE_0DA586
	dw CODE_0DA58C

;--------------------------------------------------------------------

CODE_0DA581:
	JSL.l CODE_0FF32A
	RTS

;--------------------------------------------------------------------

CODE_0DA586:
	JSL.l CODE_0FF34D
	RTS

;--------------------------------------------------------------------

CODE_0DA58B:
	RTS

;--------------------------------------------------------------------

CODE_0DA58C:
	PHX
	REP.b #$30
	TXA
	ASL
	TAX
	LDY.w $1305,x
	SEP.b #$20
	INY
	LDA.b [$FA],y
	SEP.b #$10
	PLX
	PHA
	AND.b #$40
	BNE.b CODE_0DA5B4
	PLA
	PHA
	AND.b #$0F
	STA.w $0727
	PLA
	AND.b #$30
	LSR
	LSR
	LSR
	LSR
	STA.w $0742
	RTS

CODE_0DA5B4:
	PLA
	AND.b #$07
	CMP.b #$04
	BCC.b CODE_0DA5C0
	STA.w $0744
	LDA.b #$00
CODE_0DA5C0:
	STA.w $0741
	RTS

;--------------------------------------------------------------------

CODE_0DA5C4:
	LDX.b #$80
	LDA.w $07FB
	BNE.b CODE_0DA5DE
	LDA.w $075F
	BNE.b CODE_0DA5E6
	LDY.b $5C
	DEY
	BEQ.b CODE_0DA5DB
	LDA.w $074F
	BEQ.b CODE_0DA5DC
	INX
CODE_0DA5DB:
	INX
CODE_0DA5DC:
	BRA.b CODE_0DA605

CODE_0DA5DE:
	LDA.b #$87
	CLC
	ADC.w $075C
	BNE.b CODE_0DA606
CODE_0DA5E6:
	LDX.b #$83
	LDA.w $075F
	CMP.b #$02
	BEQ.b CODE_0DA605
	INX
	CMP.b #$04
	BNE.b CODE_0DA602
	LDA.w $074F
	CMP.b #$0B
	BEQ.b CODE_0DA605
	LDY.b $5C
	DEY
	BEQ.b CODE_0DA603
	BRA.b CODE_0DA604

CODE_0DA602:
	INX
CODE_0DA603:
	INX
CODE_0DA604:
	INX
CODE_0DA605:
	TXA
CODE_0DA606:
	STA.w $06D6
	JSR.w CODE_0D8EB3
	LDA.b #$0D
	JSR.w CODE_0DA61A
CODE_0DA611:
	LDA.w $0723
	EOR.b #$01
	STA.w $0723
	RTS

CODE_0DA61A:
	STA.b $00
	LDA.b #$00
	LDX.b #$08
CODE_0DA620:
	LDY.b !RAM_SMBLL_NorSpr_SpriteID,x
	CPY.b $00
	BNE.b CODE_0DA628
	STA.b $10,x
CODE_0DA628:
	DEX
	BPL.b CODE_0DA620
	RTS

;--------------------------------------------------------------------

DATA_0DA62C:
	db $14,$17,$18

CODE_0DA62F:
	LDX.b $00
	LDA.w DATA_0DA62C-$08,x
	LDY.b #$09
CODE_0DA636:
	DEY
	BMI.b CODE_0DA640
	CMP.w !RAM_SMBLL_NorSpr_SpriteID,y
	BNE.b CODE_0DA636
	LDA.b #$00
CODE_0DA640:
	STA.w $06CD
	RTS

;--------------------------------------------------------------------

CODE_0DA644:
	LDA.w $0733
	ASL
	TAY
	LDA.w DATA_0DA656,y
	STA.b $04
	LDA.w DATA_0DA656+$01,y
	STA.b $05
	JMP.w ($0004)

DATA_0DA656:
	dw CODE_0DA65C
	dw CODE_0DA6CC
	dw CODE_0DA92B

;--------------------------------------------------------------------

CODE_0DA65C:
	JSR.w CODE_0DAA5B
	STX.w $0ECA
	LDA.w $1300,x
	BEQ.b CODE_0DA6C7
	BPL.b CODE_0DA67A
	TYA
	STA.w $1300,x
	LDA.w $0725
	ORA.w $0726
	BEQ.b CODE_0DA67A
	LDA.b #$1E
	JMP.w CODE_0DA6F8

CODE_0DA67A:
	STA.w $0ECB
	LDX.b $07
	LDA.b #$1F
	STA.w $06A1,x
	TXY
	INY
	LDX.w $0ECA
	DEC.w $0ECB
	BEQ.b CODE_0DA6A8
	LDA.w $130F,x
	BNE.b CODE_0DA69F
	INC.w $130F,x
	LDA.b #$0E
	STA.w $06A1,y
	LDA.b #$12
	BRA.b CODE_0DA6C3

CODE_0DA69F:
	LDA.b #$0F
	STA.w $06A1,y
	LDA.b #$13
	BRA.b CODE_0DA6C3

CODE_0DA6A8:
	LDA.w $130F,x
	BEQ.b CODE_0DA6B9
	STZ.w $130F,x
	LDA.b #$10
	STA.w $06A1,y
	LDA.b #$14
	BRA.b CODE_0DA6C3

CODE_0DA6B9:
	STZ.w $130F,x
	LDA.b #$11
	STA.w $06A1,y
	LDA.b #$15
CODE_0DA6C3:
	TYX
	JMP.w CODE_0DA6F2

CODE_0DA6C7:
	LDA.b #$20
	JMP.w CODE_0DA6F8

;--------------------------------------------------------------------

CODE_0DA6CC:
	JSR.w CODE_0DAA4C
	STY.b $06
	BCC.b CODE_0DA6DE
	LDA.w $1300,x
	LSR
	STA.w $1314,x
	LDA.b #$21
	BRA.b CODE_0DA6F8

CODE_0DA6DE:
	LDA.b #$23
	LDY.w $1300,x
	BEQ.b CODE_0DA6F8
	LDA.w $1314,x
	STA.b $06
	LDX.b $07
	LDA.b #$22
	STA.w $06A1,x
	RTS

;--------------------------------------------------------------------

CODE_0DA6F2:
	INX
	LDY.b #$0F
	JMP.w CODE_0DAA15

;--------------------------------------------------------------------

CODE_0DA6F8:
	LDX.b $07
	LDY.b #$00
	JMP.w CODE_0DAA15

;--------------------------------------------------------------------

CODE_0DA6FF:
	JSL.l CODE_0E88A6
	RTS

;--------------------------------------------------------------------

CODE_0DA704:
	JSR.w CODE_0DAA5B
	LDY.w $1300,x
	LDX.b $07
	LDA.b #$76
	STA.w $06A1,x
	LDA.b #$77
	STA.w $06A2,x
	RTS

;--------------------------------------------------------------------

CODE_0DA717:
	LDY.b #$03
	JSR.w CODE_0DAA4F
	LDY.b #$0A
	DEY
	DEY
	STY.b $05
	LDY.w $1300,x
	STY.b $06
	LDX.b $05
	INX
	LDA.w DATA_0DA75A,y
	CMP.b #$00
	BEQ.b CODE_0DA739
	LDX.b #$00
	LDY.b $05
	JSR.w CODE_0DAA15
	CLC
CODE_0DA739:
	LDY.b $06
	LDA.w DATA_0DA75E,y
	STA.w $06A1,x
	LDA.w DATA_0DA762,y
	STA.w $06A2,x
	BCS.b CODE_0DA759
	LDX.b #$06
CODE_0DA74B:
	LDA.b #$00
	STA.w $06A1,x
	DEX
	BPL.b CODE_0DA74B
	LDA.w DATA_0DA766,y
	STA.w $06A8
CODE_0DA759:
	RTS

DATA_0DA75A:
	db $1B,$1A,$00,$00

DATA_0DA75E:
	db $1B,$27,$26,$25

DATA_0DA762:
	db $1B,$2A,$29,$28

DATA_0DA766:
	db $17,$16,$1B,$1A
	db $19,$18,$1B,$1A

;--------------------------------------------------------------------

CODE_0DA76E:
	JSR.w CODE_0DA7BC
	LDA.b $00
	BEQ.b CODE_0DA779
	INY
	INY
	INY
	INY
CODE_0DA779:
	TYA
	PHA
	LDY.w $1300,x
	BEQ.b CODE_0DA7A8
	JSR.w CODE_0DA7FE
	BCS.b CODE_0DA7A8
	JSR.w CODE_0DAA79
	CLC
	ADC.b #$08
	STA.w $021A,x
	LDA.w $0725
	ADC.b #$00
	STA.b $79,x
	LDA.b #$01
	STA.b $BC,x
	STA.b $10,x
	JSR.w CODE_0DAA81
	STA.w $0238,x
	LDA.b #$0D
	STA.b !RAM_SMBLL_NorSpr_SpriteID,x
	JSR.w CODE_0DCA79
CODE_0DA7A8:
	PLA
	TAY
	LDX.b $07
	LDA.w DATA_0DA766,y
	STA.w $06A1,x
	INX
	LDA.w DATA_0DA766+$02,y
	LDY.b $06
	DEY
	JMP.w CODE_0DAA15

CODE_0DA7BC:
	LDY.b #$01
	JSR.w CODE_0DAA4F
	JSR.w CODE_0DAA5B
	TYA
	AND.b #$07
	STA.b $06
	LDY.w $1300,x
	RTS

;--------------------------------------------------------------------

CODE_0DA7CD:
	STA.w !RAM_SMBLL_NorSpr_SpriteID,x
	JSR.w CODE_0DAA79
	CLC
	ADC.b #$08
	STA.w $021A,x
	LDA.w $0725
	ADC.b #$00
	STA.w $0079,x
	LDA.b #$01
	STA.b $BC,x
	STA.w $0010,x
	JSR.w CODE_0DAA81
	STA.w $0238,x
	JMP.w CODE_0DCA79

;--------------------------------------------------------------------

CODE_0DA7F1:
	LDX.b #$00
CODE_0DA7F3:
	CLC
	LDA.b $10,x
	BEQ.b CODE_0DA7FD
	INX
	CPX.b #$08
	BNE.b CODE_0DA7F3
CODE_0DA7FD:
	RTS

;--------------------------------------------------------------------

CODE_0DA7FE:
	LDX.b #$08
CODE_0DA800:
	CLC
	LDA.b $10,x
	BEQ.b CODE_0DA80A
	DEX
	CPX.b #$FF
	BNE.b CODE_0DA800
CODE_0DA80A:
	RTS

;--------------------------------------------------------------------

DATA_0DA80B:
	db $80,$81,$81,$82

DATA_0DA80F:
	db $84,$85

CODE_0DA811:
	JSR.w CODE_0DAA4C
	LDX.b #$0A
	LDA.b $5C
	CMP.b #$03
	BNE.b CODE_0DA81D
	INX
CODE_0DA81D:
	LDY.b $5C
	LDA.w DATA_0DA80B,y
	STA.w $06A1,x
	INX
	TYA
	LSR
	TAY
	LDA.w DATA_0DA80F,y
	LDY.b #$01
	JMP.w CODE_0DAA15

;--------------------------------------------------------------------

CODE_0DA831:
	LDA.b #$03
	BRA.b CODE_0DA837

CODE_0DA835:
	LDA.b #$07
CODE_0DA837:
	PHA
	JSR.w CODE_0DAA4C
	PLA
	TAX
	LDA.b #$E7
	STA.w $06A1,x
	RTS

;--------------------------------------------------------------------

CODE_0DA843:
	LDA.b #$06
	BRA.b CODE_0DA84D

CODE_0DA847:
	LDA.b #$07
	BRA.b CODE_0DA84D

CODE_0DA84B:
	LDA.b #$09
CODE_0DA84D:
	PHA
	JSR.w CODE_0DAA4C
	LDA.w $1300,x
	BEQ.b CODE_0DA866
	LDA.w $130F,x
	BNE.b CODE_0DA862
	INC.w $130F,x
	LDA.b #$08
	BRA.b CODE_0DA86B

CODE_0DA862:
	LDA.b #$07
	BRA.b CODE_0DA86B

CODE_0DA866:
	STZ.w $130F,x
	LDA.b #$09
CODE_0DA86B:
	PLX
	STA.w $06A1,x
	INX
	LDY.b #$00
	LDA.b #$6A
	JMP.w CODE_0DAA15

;--------------------------------------------------------------------

CODE_0DA877:
	LDA.b #$2D
	STA.w $06A1
	LDX.b #$01
	LDY.b #$08
	LDA.b #$2E
	JSR.w CODE_0DAA15
	LDA.b #$62
	STA.w $06AB
	JSR.w CODE_0DAA79
	CLC
	ADC.b #$08
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	STA.w $0223
else
	STA.w $021F
endif
	LDA.w $0725
	ADC.b #$00
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	STA.b $82
else
	STA.b $7E
endif
	LDA.b #$30
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	STA.w $0241
else
	STA.w $023D
endif
	LDA.b #$B0
	STA.w $010D
	LDA.b #$30
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	STA.b $25
	INC.b $19
else
	STA.b $21
	INC.b $15
endif
	LDA.b #$FF
	STA.w $0FB4
	STA.w $0FB5
	STA.w $0FB6
	STA.w $0FB7
	RTS

;--------------------------------------------------------------------

DATA_0DA8B9:
	db $EB,$EA,$EA,$EA

CODE_0DA8BD:
	LDY.b $5C
	LDA.w DATA_0DA8B9,y
	JMP.w CODE_0DA909

;--------------------------------------------------------------------

DATA_0DA8C5:
	db $06,$07,$08

DATA_0DA8C8:
	db $FE,$0A,$87

CODE_0DA8CB:
	LDY.b #$0C
	JSR.w CODE_0DAA4F
	BRA.b CODE_0DA8D7

CODE_0DA8D2:
	LDA.b #$08
	STA.w $0773
CODE_0DA8D7:
	LDY.b $00
	LDX.w DATA_0DA8C5-$02,y
	LDA.w DATA_0DA8C8-$02,y
	BRA.b CODE_0DA8E8

CODE_0DA8E1:
	JSR.w CODE_0DAA5B
	LDX.b $07
	LDA.b #$FD
CODE_0DA8E8:
	LDY.b #$00
	JMP.w CODE_0DAA15

;--------------------------------------------------------------------

DATA_0DA8ED:
	db $70,$62,$62,$68

DATA_0DA8F1:
	db $2B,$49,$4A,$4A,$86

CODE_0DA8F6:
	LDY.b $5C
	LDA.w $0743
	BEQ.b CODE_0DA8FF
	LDY.b #$04
CODE_0DA8FF:
	LDA.w DATA_0DA8F1,y
	BRA.b CODE_0DA909

CODE_0DA904:
	LDY.b $5C
	LDA.w DATA_0DA8ED,y
CODE_0DA909:
	PHA
	JSR.w CODE_0DAA4C
	LDX.b $07
	LDY.b #$00
	PLA
	JMP.w CODE_0DAA15

;--------------------------------------------------------------------

CODE_0DA915:
	LDY.b $5C
	LDA.w DATA_0DA8F1,y
	BRA.b CODE_0DA921

CODE_0DA91C:
	LDY.b $5C
	LDA.w DATA_0DA8ED,y
CODE_0DA921:
	PHA
	JSR.w CODE_0DAA5B
	PLA
	LDX.b $07
	JMP.w CODE_0DAA15

;--------------------------------------------------------------------

CODE_0DA92B:
	JSR.w CODE_0DAA5B
	LDX.b $07
	LDA.b #$6B
	STA.w $06A1,x
	INX
	DEY
	BMI.b CODE_0DA947
	LDA.b #$6C
	STA.w $06A1,x
	INX
	DEY
	BMI.b CODE_0DA947
	LDA.b #$6D
	JSR.w CODE_0DAA15
CODE_0DA947:
	LDX.w $026A
	JSR.w CODE_0DAA81
	STA.w $0277,x
	LDA.w $0725
	STA.w $026B,x
	JSR.w CODE_0DAA79
	STA.w $0271,x
	INX
	CPX.b #$06
	BCC.b CODE_0DA963
	LDX.b #$00
CODE_0DA963:
	STX.w $026A
	RTS

;--------------------------------------------------------------------

CODE_0DA967:
	JSR.w CODE_0DAA5B
	LDX.b #$00
CODE_0DA96C:
	CLC
	LDA.b $10,x
	BEQ.b CODE_0DA976
	INX
	CPX.b #$07
	BNE.b CODE_0DA96C
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	BCS.b CODE_0DA9A1
endif
CODE_0DA976:
	JSR.w CODE_0DAA79
	STA.w $021A,x
	LDA.w $0725
	STA.b $79,x
	JSR.w CODE_0DAA81
	STA.w $0238,x
	STA.b $5E,x
	LDA.b #$32
	STA.b !RAM_SMBLL_NorSpr_SpriteID,x
	LDY.b #$01
	STY.b $BC,x
	LDA.b #$01
	STA.b $10,x
	LDX.b $07
	LDA.b #$6E
	STA.w $06A1,x
	LDA.b #$6F
	STA.w $06A2,x
CODE_0DA9A1:
	RTS

;--------------------------------------------------------------------

CODE_0DA9A2:
	LDA.w $075D
	BEQ.b CODE_0DA9DB
	STZ.w $075D
	BRA.b CODE_0DA9B5

CODE_0DA9AC:
	JSR.w CODE_0DA9D5
	JMP.w CODE_0DA9C7

CODE_0DA9B2:
	STZ.w $06BC
CODE_0DA9B5:
	JSR.w CODE_0DA9D5
	STY.b $07
	LDA.b #$00
	LDY.b $5C
	DEY
	BEQ.b CODE_0DA9C3
	LDA.b #$06
CODE_0DA9C3:
	CLC
	ADC.b $07
	TAY
CODE_0DA9C7:
	LDA.w DATA_0DBD6E,y
	PHA
	JSR.w CODE_0DAA5B
	LDX.b $07
	PLA
	STA.w $06A1,x
	RTS

CODE_0DA9D5:
	LDA.b $00
	SEC
	SBC.b #$00
	TAY
CODE_0DA9DB:
	RTS

;--------------------------------------------------------------------

CODE_0DA9DC:
	JSR.w CODE_0DAA4C
	BCC.b CODE_0DAA0D
	LDA.b $5C
	BNE.b CODE_0DAA0D
	LDX.w $026A
	JSR.w CODE_0DAA79
	SEC
	SBC.b #$10
	STA.w $0271,x
	LDA.w $0725
	SBC.b #$00
	STA.w $026B,x
	INY
	INY
	TYA
	ASL
	ASL
	ASL
	ASL
	STA.w $0277,x
	INX
	CPX.b #$05
	BCC.b CODE_0DAA0A
	LDX.b #$00
CODE_0DAA0A:
	STX.w $026A
CODE_0DAA0D:
	LDX.b $5C
	LDA.b #$00
	LDX.b #$08
	LDY.b #$0F
CODE_0DAA15:
	STY.w $0735
	LDY.w $06A1,x
	BEQ.b CODE_0DAA3D
	CPY.b #$1F
	BEQ.b CODE_0DAA40
	CPY.b #$22
	BEQ.b CODE_0DAA40
	CPY.b #$E7
	BEQ.b CODE_0DAA3D
	CPY.b #$0F
	BEQ.b CODE_0DAA40
	CPY.b #$13
	BEQ.b CODE_0DAA40
	CPY.b #$E7
	BCS.b CODE_0DAA40
	CPY.b #$4E
	BNE.b CODE_0DAA3D
	CMP.b #$48
	BEQ.b CODE_0DAA40
CODE_0DAA3D:
	STA.w $06A1,x
CODE_0DAA40:
	INX
	CPX.b #$0D
	BCS.b CODE_0DAA4B
	LDY.w $0735
	DEY
	BPL.b CODE_0DAA15
CODE_0DAA4B:
	RTS

;--------------------------------------------------------------------

CODE_0DAA4C:
	JSR.w CODE_0DAA5B
CODE_0DAA4F:
	LDA.w $1300,x
	CLC
	BPL.b CODE_0DAA5A
	TYA
	STA.w $1300,x
	SEC
CODE_0DAA5A:
	RTS

;--------------------------------------------------------------------

CODE_0DAA5B:
	PHX
	REP.b #$30
	TXA
	AND.w #$00FF
	ASL
	TAX
	LDY.w $1305,x
	SEP.b #$20
	LDA.b [$FA],y
	AND.b #$0F
	STA.b $07
	INY
	LDA.b [$FA],y
	AND.b #$0F
	SEP.b #$10
	TAY
	PLX
	RTS

;--------------------------------------------------------------------

CODE_0DAA79:
	LDA.w $0726
	ASL
	ASL
	ASL
	ASL
	RTS

;--------------------------------------------------------------------

CODE_0DAA81:
	LDA.b $07
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC.b #$20
	RTS

;--------------------------------------------------------------------

DATA_0DAA8B:
	db $000500,$0005D0

DATA_0DAA8D:
	db $000500>>8,$0005D0>>8

CODE_0DAA8F:
	PHA
	LSR
	LSR
	LSR
	LSR
	TAY
	LDA.w DATA_0DAA8D,y
	STA.b $07
	PLA
	AND.b #$0F
	CLC
	ADC.w DATA_0DAA8B,y
	STA.b $06
	RTS

;--------------------------------------------------------------------

CODE_0DAAA4:
	PHB
	PHK
	PLB
	JSR.w CODE_0DAA4C
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0DAAAC:
	PHB
	PHK
	PLB
	JSR.w CODE_0DAA15
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0DAAB4:
	PHB
	PHK
	PLB
	JSR.w CODE_0DAA4F
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0DAABC:
	PHB
	PHK
	PLB
	JSR.w CODE_0DAA79
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0DAAC4:
	PHB
	PHK
	PLB
	JSR.w CODE_0DA7F1
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0DAACC:
	PHB
	PHK
	PLB
	PHA
	JSR.w CODE_0DA7BC
	PLA
	STA.w $0007
	TYA
	PHA
	LDY.w $1300,x
	BEQ.b CODE_0DAB05
	JSR.w CODE_0DA7F1
	BCS.b CODE_0DAB05
	LDA.b #$04
	JSR.w CODE_0DA7CD
	LDA.w $0006
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC.w $0238,x
	SEC
	SBC.b #$0A
	STA.w $0238,x
	STA.w $043D,x
	CLC
	ADC.b #$18
	STA.w $041D,x
	INC.w $00A1,x
CODE_0DAB05:
	PLA
	TAY
	PHA
	LDX.w $0007
	LDA.w DATA_0DA766+$02,y
	LDY.w $0006
	DEY
	JSR.w CODE_0DAA15
	PLA
	TAY
	LDA.w DATA_0DA766,y
	STA.w $06A1,x
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0DAB1F:
	LDA.b $29,x
	BNE.b CODE_0DAB63
	LDA.w $0792,x
	BNE.b CODE_0DAB63
	LDA.w $00A1,x
	BNE.b CODE_0DAB39
	LDA.b $5E,x
	EOR.b #$FF
	CLC
	ADC.b #$01
	STA.b $5E,x
	INC.w $00A1,x
CODE_0DAB39:
	LDA.w $041D,x
	LDY.b $5E,x
	BPL.b CODE_0DAB43
	LDA.w $043D,x
CODE_0DAB43:
	STA.w $0000
	LDA.w $0747
	BNE.b CODE_0DAB63
	LDA.w $0238,x
	CLC
	ADC.b $5E,x
	STA.w $0238,x
	CMP.w $0000
	BNE.b CODE_0DAB63
	LDA.b #$00
	STA.w $00A1,x
	LDA.b #$20
	STA.w $0792,x
CODE_0DAB63:
	RTS

if !Define_Global_ROMToAssemble&(!ROM_SMBLL_U|!ROM_SMBLL_E|!ROM_SMBLL_J) != $00
elseif !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	%FREE_BYTES(NULLROM, 13, $FF)
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	%FREE_BYTES(NULLROM, 28, $FF)
else
	%FREE_BYTES(NULLROM, 12, $FF)
endif

;--------------------------------------------------------------------

CODE_0DAB70:
	LDA.w $0772
	ASL
	TAX
	JMP.w (DATA_0DAB78,x)

DATA_0DAB78:
	dw CODE_0D9D90
	dw CODE_0D89BD
	dw CODE_0D9E5A
	dw CODE_0DAB99

;--------------------------------------------------------------------

CODE_0DAB80:
if !Define_Global_ROMToAssemble&(!ROM_SMBLL_U|!ROM_SMBLL_E|!ROM_SMBLL_J) == $00
	LDA.l !SRAM_SMAS_Global_RunningDemoFlag
	BNE.b CODE_0DAB9D
endif
	LDA.l !RAM_SMBLL_Global_DisplayTitleScreenMenuOptionsIndex
	BMI.b CODE_0DAB9D
	JSR.w CODE_0DAD50
	JSR.w CODE_0DFDB2
	JSR.w CODE_0DFD29
	JSR.w CODE_0DF700
	RTS

;--------------------------------------------------------------------

CODE_0DAB99:
	JSL.l CODE_0FD000
CODE_0DAB9D:
	LDA.b $28
	BNE.b CODE_0DABA1
CODE_0DABA1:
	JSR.w CODE_0DAD50
	LDA.w $0772
	CMP.b #$03
	BCS.b CODE_0DABAC
	RTS

CODE_0DABAC:
	JSR.w CODE_0DB42F
	LDX.b #$00
CODE_0DABB1:
	STX.b $9E
	LDA.w $0E67
	BEQ.b CODE_0DABBC
	CMP.b #$7F
	BEQ.b CODE_0DABDA
CODE_0DABBC:
	JSR.w CODE_0DC250
	LDA.w $0E67
	BNE.b CODE_0DABC7
	JSR.w CODE_0D88D5
CODE_0DABC7:
	INX
	CPX.b #$0A
	BNE.b CODE_0DABB1
	JSL.l CODE_0FE0FB
	LDA.w $0E67
	BEQ.b CODE_0DABDA
	LDA.b #$7F
	STA.w $0E67
CODE_0DABDA:
	JSR.w CODE_0DFDB2
	JSR.w CODE_0DFD29
	JSR.w CODE_0DF700
	LDX.b #$01
	STX.b $9E
	JSR.w CODE_0DBE0F
	DEX
	STX.b $9E
	JSR.w CODE_0DBE0F
	JSR.w CODE_0DBE77
	JSR.w CODE_0DBA8C
	JSR.w CODE_0DB875
	JSR.w CODE_0DB5FA
	JSR.w CODE_0DB6A1
	JSR.w CODE_0DB58D
	JSR.w CODE_0D9025
	LDA.w $0F04
	BEQ.b CODE_0DAC0E
	JSL.l CODE_0FF2A8
CODE_0DAC0E:
	LDA.b $BB
	CMP.b #$02
	BPL.b CODE_0DAC26
	LDA.w $07AF
	BEQ.b CODE_0DAC38
	CMP.b #$04
	BNE.b CODE_0DAC26
	LDA.w $0787
	BNE.b CODE_0DAC26
	JSL.l CODE_0FD8F6
CODE_0DAC26:
	LDA.b $09
	PHY
	LDY.w $07AF
	CPY.b #$08
	BCS.b CODE_0DAC32
	LSR
	LSR
CODE_0DAC32:
	PLY
	JSR.w CODE_0DB018
	BRA.b CODE_0DAC4C

CODE_0DAC38:
	LDA.w $0787
	CMP.b #$01
	BNE.b CODE_0DAC49
	LDA.b $0F
	CMP.b #$0C
	BEQ.b CODE_0DAC49
	JSL.l CODE_0E98C3
CODE_0DAC49:
	JSR.w CODE_0DB050
CODE_0DAC4C:
	LDA.b $0A
	STA.b $0D
	STZ.b $0C
CODE_0DAC52:
	LDA.w $0773
	CMP.b #$06
	BEQ.b CODE_0DAC75
	LDA.w $071F
	BNE.b CODE_0DAC72
	LDA.w $073D
	CMP.b #$20
	BMI.b CODE_0DAC75
	LDA.w $073D
	SBC.b #$20
	STA.w $073D
	LDA.b #$00
	STA.w $1A00
CODE_0DAC72:
	JSR.w CODE_0DA054
CODE_0DAC75:
	RTS

;--------------------------------------------------------------------

CODE_0DAC76:
	LDA.w $06FF
	CLC
	ADC.w $03A1
	STA.w $06FF
	LDA.w $0723
	BEQ.b CODE_0DAC88
	JMP.w CODE_0DAD02

CODE_0DAC88:
	LDA.w $0755
	CMP.b #$50
	BCC.b CODE_0DAD02
	LDA.w $078D
	BNE.b CODE_0DAD02
	LDY.w $06FF
	DEY
	BMI.b CODE_0DAD02
	INY
	CPY.b #$02
	BCC.b CODE_0DACA0
	DEY
CODE_0DACA0:
	LDA.w $0755
	CMP.b #$70
	BCC.b CODE_0DACAA
	LDY.w $06FF
CODE_0DACAA:
	LDA.w $0F01
	BNE.b CODE_0DACAA
	TYA
	STA.w $0775
	CLC
	ADC.w $073D
	STA.w $073D
	LDA.w $071C
	STA.b $00
	LDA.w $071A
	STA.b $01
	REP.b #$30
	TYA
	AND.w #$00FF
	CLC
	ADC.b $00
	STA.b $00
	LSR
	STA.w $0EFD
	LSR
	STA.w $0EEE
	SEP.b #$30
	LDA.b $00
	STA.w $071C
	STA.w $073F
	STA.b $42
	LDA.b $01
	STA.w $071A
	STA.b $43
	AND.b #$01
	STA.b $00
	LDA.w $0778
	AND.b #$FE
	ORA.b $00
	STA.w $0778
	JSR.w CODE_0DAD3E
	LDA.b #$08
	STA.w $07A1
	BRA.b CODE_0DAD07

CODE_0DAD02:
	LDA.b #$00
	STA.w $0775
CODE_0DAD07:
	LDX.b #$00
	JSR.w CODE_0DFE34
	STA.b $00
	LDY.b #$00
	ASL
	BCS.b CODE_0DAD1A
	INY
	LDA.b $00
	AND.b #$20
	BEQ.b CODE_0DAD34
CODE_0DAD1A:
	LDA.w $071C,y
	SEC
	SBC.w DATA_0DAD3A,y
	STA.w $0219
	LDA.w $071A,y
	SBC.b #$00
	STA.b $78
	LDA.b $0C
	CMP.w DATA_0DAD3C,y
	BEQ.b CODE_0DAD34
	STZ.b $5D
CODE_0DAD34:
	LDA.b #$00
	STA.w $03A1
	RTS

DATA_0DAD3A:
	db $00,$10

DATA_0DAD3C:
	db $01,$02

;--------------------------------------------------------------------

CODE_0DAD3E:
	LDA.w $071C
	CLC
	ADC.b #$FF
	STA.w $071D
	LDA.w $071A
	ADC.b #$00
	STA.w $071B
	RTS

;--------------------------------------------------------------------

CODE_0DAD50:
	LDA.b $0F
	ASL
	TAX
	JMP.w (DATA_0DAD57,x)

DATA_0DAD57:
	dw CODE_0D9ED1
	dw CODE_0DAF29
	dw CODE_0DAF7A
	dw CODE_0DAF4B
	dw CODE_0DB05B
	dw CODE_0DB07D
	dw CODE_0D9F7E
	dw CODE_0DAD71
	dw CODE_0DAE1C
	dw CODE_0DAFC2
	dw CODE_0DAFD4
	dw CODE_0DAFF8
	dw CODE_0DB00E

;--------------------------------------------------------------------

CODE_0DAD71:
	LDA.w $0752
	CMP.b #$02
	BEQ.b CODE_0DADB1
	LDA.b #$00
	LDY.w $0237
	CPY.b #$30
	BCS.b CODE_0DAD84
	JMP.w CODE_0DAE12

CODE_0DAD84:
	LDA.w $0710
	CMP.b #$06
	BEQ.b CODE_0DAD8F
	CMP.b #$07
	BNE.b CODE_0DADFB
CODE_0DAD8F:
	LDA.w $0256
	AND.b #$F0
	BEQ.b CODE_0DAD9B
	LDA.b #$01
	JMP.w CODE_0DAE12

CODE_0DAD9B:
	JSR.w CODE_0DAFAD
	DEC.w $06DE
	BNE.b CODE_0DAE11
	LDA.b #$01
	STA.w $0E7F
	STA.w $0E4F
	INC.w $0769
	JMP.w CODE_0DB0B0

CODE_0DADB1:
	LDA.w $0758
	BNE.b CODE_0DADD2
	LDA.w $0237
	CMP.b #$B0
	BNE.b CODE_0DADC2
	LDA.b #!Define_SMAS_Sound0060_IntoPipe
	STA.w !RAM_SMBLL_Global_SoundCh1
CODE_0DADC2:
	STA.w $0E4E
	LDA.b #$FF
	JSR.w CODE_0DAF72
	LDA.w $0237
	CMP.b #$91
	BCC.b CODE_0DADFB
	RTS

CODE_0DADD2:
	LDA.w $0399
	CMP.b #$60
	BNE.b CODE_0DAE11
	LDA.w $0237
	CMP.b #$99
	LDY.b #$00
	LDA.b #$01
	BCC.b CODE_0DADEE
	LDA.b #$03
	STA.b $28
	INY
	LDA.b #$08
	STA.w $05B4
CODE_0DADEE:
	STY.w $0716
	JSR.w CODE_0DAE12
	LDA.w $0219
	CMP.b #$48
	BCC.b CODE_0DAE11
CODE_0DADFB:
	STZ.w $0E4E
	LDA.b #$08
	STA.b $0F
	LDA.b #$01
	STA.w $0202
	LSR
	STA.w $0752
	STA.w $0716
	STA.w $0758
CODE_0DAE11:
	RTS

;--------------------------------------------------------------------

CODE_0DAE12:
	STA.w $0FF4
	LDA.b #$01
	STA.w $0B7A
	BRA.b CODE_0DAE1F

CODE_0DAE1C:
	STZ.w $0B7A
CODE_0DAE1F:
	LDA.b $0F
	CMP.b #$0B
	BEQ.b CODE_0DAE5F
	LDA.b $5C
	BNE.b CODE_0DAE38
	LDY.b $BB
	DEY
	BNE.b CODE_0DAE35
	LDA.w $0237
	CMP.b #$D0
	BCC.b CODE_0DAE38
CODE_0DAE35:
	STZ.w $0FF4
CODE_0DAE38:
	LDA.w $0FF4
	AND.b #$C0
	STA.b $0A
	LDA.w $0FF4
	AND.b #$03
	STA.b $0C
	LDA.w $0FF4
	AND.b #$0C
	STA.b $0B
	AND.b #$04
	BEQ.b CODE_0DAE5F
	LDA.b $28
	BNE.b CODE_0DAE5F
	LDY.b $0C
	BEQ.b CODE_0DAE5F
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMBLL_J) != $00
	STZ.b $0C
	STZ.b $0B
else
	LDA.b #$00
	STA.b $0C
	STA.b $0B
endif
CODE_0DAE5F:
	LDA.l !SRAM_SMAS_Global_EnableSMASDebugModeFlag
	BEQ.b CODE_0DAE6B
	JSL.l CODE_0FDEFE
	BCC.b CODE_0DAE6E
CODE_0DAE6B:
	JSR.w CODE_0DB0E5
CODE_0DAE6E:
	LDY.b #$01
	LDA.w $0754
	BNE.b CODE_0DAE7E
	LDY.b #$00
	LDA.w $0714
	BEQ.b CODE_0DAE7E
	LDY.b #$02
CODE_0DAE7E:
	STY.w $048F
	LDA.b #$01
	LDY.b $5D
	BEQ.b CODE_0DAE8C
	BPL.b CODE_0DAE8A
	ASL
CODE_0DAE8A:
	STA.b $46
CODE_0DAE8C:
	JSR.w CODE_0DAC76
	JSR.w CODE_0DFDB2
	JSR.w CODE_0DFD29
	LDX.b #$00
	JSR.w CODE_0DE9A9
	JSR.w CODE_0DE263
	LDA.w $0237
	CMP.b #$40
	BCC.b CODE_0DAECE
	LDA.b $0F
	CMP.b #$05
	BEQ.b CODE_0DAECE
	CMP.b #$07
	BEQ.b CODE_0DAECE
	CMP.b #$04
	BCC.b CODE_0DAECE
	LDA.b $0F
	CMP.b #$0B
	BNE.b CODE_0DAEC4
	STZ.w $0F04
	LDA.w $0256
	AND.b #$CE
	ORA.b #$30
	BRA.b CODE_0DAECB

CODE_0DAEC4:
	LDA.w $0256
	AND.b #$CE
	ORA.b #$20
CODE_0DAECB:
	STA.w $0256
CODE_0DAECE:
	LDA.b $BB
	CMP.b #$02
	BMI.b CODE_0DAF1C
	LDX.b #$01
	STX.w $0723
	LDY.b #$04
	STY.b $07
	LDX.b #$00
	LDY.w $0759
	BNE.b CODE_0DAEE9
	LDY.w $0743
	BNE.b CODE_0DAF0C
CODE_0DAEE9:
	INX
	LDY.b $0F
	CPY.b #$0B
	BEQ.b CODE_0DAF0C
	LDY.w $0712
	BNE.b CODE_0DAF08
	INY
	STY.w $0712
	LDY.b #!Define_SMBLL_LevelMusic_MarioDied
	STY.w !RAM_SMBLL_Global_MusicCh1
	PHA
	LDA.b #!Define_SMAS_Sound0061_TurnOffWind
	TSB.w !RAM_SMBLL_Global_SoundCh2
	PLA
	STA.w $0E67
CODE_0DAF08:
	LDY.b #$06
	STY.b $07
CODE_0DAF0C:
	CMP.b $07
	BMI.b CODE_0DAF1C
	DEX
	BMI.b CODE_0DAF1D
	LDY.w $07B1
	BNE.b CODE_0DAF1C
	LDA.b #$06
	STA.b $0F
CODE_0DAF1C:
	RTS

CODE_0DAF1D:
	LDA.b #$00
	STA.w $0758
	JSR.w CODE_0DAF43
	INC.w $0752
	RTS

;--------------------------------------------------------------------

CODE_0DAF29:
	LDA.b $BB
	BNE.b CODE_0DAF34
	LDA.w $0237
	CMP.b #$E4
	BCC.b CODE_0DAF43
CODE_0DAF34:
	LDA.b #$08
	STA.w $0758
	STA.w $0E67
	LDY.b #$03
	STY.b $28
	JMP.w CODE_0DAE12

CODE_0DAF43:
	LDA.b #$02
	STA.w $0752
	JMP.w CODE_0DAF8F

;--------------------------------------------------------------------

CODE_0DAF4B:
	LDA.b #$01
	STA.w $0E4F
	STA.w $0218
	LDA.b $09
	LSR
	BCC.b CODE_0DAF5D
	LDA.b #$01
	JSR.w CODE_0DAF72
CODE_0DAF5D:
	JSR.w CODE_0DAC76
	LDY.b #$00
	LDA.w $06D6
	BNE.b CODE_0DAF87
	INY
	LDA.b $5C
	CMP.b #$03
	BNE.b CODE_0DAF87
	INY
	JMP.w CODE_0DAF87

;--------------------------------------------------------------------

CODE_0DAF72:
	CLC
	ADC.w $0237
	STA.w $0237
	RTS

;--------------------------------------------------------------------

CODE_0DAF7A:
	LDA.b #$01
	STA.w $0E4F
	STA.w $0E67
	JSR.w CODE_0DAFAD
	LDY.b #$02
CODE_0DAF87:
	DEC.w $06DE
	BNE.b CODE_0DAFAC
	STY.w $0752
CODE_0DAF8F:
	LDA.b #$01
	STA.w $0E7F
	STA.w $0E67
	LDA.w $02FF
	BEQ.b CODE_0DAFA4
	LDX.b #$00
	JSL.l CODE_0FD4D3
	LDX.b $9E
CODE_0DAFA4:
	LDA.b #$00
	STA.w $0772
	STA.w $0722
CODE_0DAFAC:
	RTS

;--------------------------------------------------------------------

CODE_0DAFAD:
	LDA.b #$08
	STA.b $5D
	LDY.b #$01
	LDA.w $0219
	AND.b #$0F
	BNE.b CODE_0DAFBD
	STA.b $5D
	TAY
CODE_0DAFBD:
	TYA
	JSR.w CODE_0DAE12
	RTS

;--------------------------------------------------------------------

CODE_0DAFC2:
	LDA.w $0747
	CMP.b #$F8
	BNE.b CODE_0DAFCC
	JMP.w CODE_0DAFE4

CODE_0DAFCC:
	CMP.b #$C4
	BNE.b CODE_0DAFD3
	JSR.w CODE_0DB002
CODE_0DAFD3:
	RTS

CODE_0DAFD4:
	LDA.w $0747
	CMP.b #$F0
	BCS.b CODE_0DAFE2
	CMP.b #$C8
	BEQ.b CODE_0DB002
	JMP.w CODE_0DAE1C

CODE_0DAFE2:
	BNE.b CODE_0DAFF7
CODE_0DAFE4:
	LDY.w $070B
	BNE.b CODE_0DAFF7
	STY.w $070D
	INC.w $070B
	LDA.w $0754
	EOR.b #$01
	STA.w $0754
CODE_0DAFF7:
	RTS

;--------------------------------------------------------------------

CODE_0DAFF8:
	LDA.w $0747
	CMP.b #$F0
	BCS.b CODE_0DB05A
	JMP.w CODE_0DAE1C

;--------------------------------------------------------------------

CODE_0DB002:
	STZ.w $0747
	JSL.l CODE_0E98C3
	LDA.b #$08
	STA.b $0F
	RTS

;--------------------------------------------------------------------

CODE_0DB00E:
	LDA.w $0747
	CMP.b #$C0
	BEQ.b CODE_0DB04D
	EOR.b #$FF
	ASL
CODE_0DB018:
	ASL
	ASL
	ASL
	PHY
	PHX
	REP.b #$30
	AND.w #$0060
	TAX
	LDA.w $0753
	AND.w #$00FF
	BEQ.b CODE_0DB031
	TXA
	CLC
	ADC.w #$0020
	TAX
CODE_0DB031:
	LDY.w #$01E0
CODE_0DB034:
	LDA.w DATA_0DC19C,x
	STA.w $1000,y
	INX
	INX
	INY
	INY
	CPY.w #$0200
	BNE.b CODE_0DB034
	SEP.b #$30
	PLX
	PLY
	LDA.b #$01
	STA.w !RAM_SMBLL_Global_UpdateEntirePaletteFlag
	RTS

CODE_0DB04D:
	JSR.w CODE_0DB002
CODE_0DB050:
	LDA.w $0256
	AND.b #$F1
	ORA.b #$0E
	STA.w $0256
CODE_0DB05A:
	RTS

;--------------------------------------------------------------------

CODE_0DB05B:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDA.b $25
else
	LDA.b $21
endif
	CMP.b #$30
	BNE.b CODE_0DB072
	LDA.b #$00
	STA.w $0713
	LDY.w $0237
	CPY.b #$9E
	BCS.b CODE_0DB06F
	LDA.b #$04
CODE_0DB06F:
	JMP.w CODE_0DAE12

CODE_0DB072:
	INC.b $0F
	RTS

;--------------------------------------------------------------------

DATA_0FB075:
	db $15,$23,$16,$1B,$17,$18,$23,$63

;--------------------------------------------------------------------

CODE_0DB07D:
	JSL.l CODE_0FD2CD
	BEQ.b CODE_0DB092
	LDA.b #$01
	JSR.w CODE_0DAE12
	LDA.w $0237
	CMP.b #$AE
	BCC.b CODE_0DB092
	STZ.w $0723
CODE_0DB092:
	LDA.w $0746
	CMP.b #$05
	BNE.b CODE_0DB0E4
	INC.w $075C
	LDA.w $075C
	CMP.b #$03
	BNE.b CODE_0DB0B0
	LDY.w $075F
	LDA.w $0748
	CMP.b #$10
	BCC.b CODE_0DB0B0
	INC.w $075D
CODE_0DB0B0:
	INC.w $0760
	LDA.w $075F
	CMP.b #$08
	BNE.b CODE_0DB0D7
	LDA.w $075C
	CMP.b #$04
	BNE.b CODE_0DB0D7
	STZ.w $075C
	STZ.w $0760
	INC.w $075F
	LDA.b #$FF
	STA.w $07FA
	LDA.b #$01
	STA.w $07FB
	STA.w $076A
CODE_0DB0D7:
	JSL.l CODE_0EC34C
	INC.w $0757
	JSR.w CODE_0DAF8F
	STA.w $075B
CODE_0DB0E4:
	RTS

;--------------------------------------------------------------------

CODE_0DB0E5:
	LDA.b #$00
	LDY.w $0754
	BNE.b CODE_0DB0F4
	LDA.b $28
	BNE.b CODE_0DB0F7
	LDA.b $0B
	AND.b #$04
CODE_0DB0F4:
	STA.w $0714
CODE_0DB0F7:
	JSR.w CODE_0DB236
	LDA.w $070B
	BNE.b CODE_0DB117
	LDA.b $28
	CMP.b #$03
	BEQ.b CODE_0DB10A
	LDY.b #$18
	STY.w $0791
CODE_0DB10A:
	ASL
	TAX
	JMP.w (DATA_0DB10F,x)

DATA_0DB10F:
	dw CODE_0DB118
	dw CODE_0DB13E
	dw CODE_0DB135
	dw CODE_0DB197

CODE_0DB117:
	RTS

;--------------------------------------------------------------------

CODE_0DB118:
	JSR.w CODE_0DB39D
	LDA.b $0C
	BEQ.b CODE_0DB122
	STA.w $0202
CODE_0DB122:
	JSR.w CODE_0DB3D8
CODE_0DB125:
	JSR.w CODE_0DBEA7
	STA.w $06FF
	LDA.w $0F04
	BEQ.b CODE_0DB134
	JSL.l CODE_0FF24F
CODE_0DB134:
	RTS

;--------------------------------------------------------------------

CODE_0DB135:
	LDA.w $070A
	STA.w $0709
	JMP.w CODE_0DB177

;--------------------------------------------------------------------

CODE_0DB13E:
	LDY.b $A0
	BPL.b CODE_0DB156
	LDA.b $0A
	AND.b #$80
	AND.b $0D
	BNE.b CODE_0DB15C
	LDA.w $0708
	SEC
	SBC.w $0237
	CMP.w $0706
	BCC.b CODE_0DB15C
CODE_0DB156:
	LDA.w $070A
	STA.w $0709
CODE_0DB15C:
	LDA.w $0704
	BEQ.b CODE_0DB177
	JSR.w CODE_0DB39D
	LDA.w $0237
	CMP.b #$14
	BCS.b CODE_0DB170
	LDA.b #$18
	STA.w $0709
CODE_0DB170:
	LDA.b $0C
	BEQ.b CODE_0DB177
	STA.w $0202
CODE_0DB177:
	LDA.b $0C
	BEQ.b CODE_0DB17E
	JSR.w CODE_0DB3D8
CODE_0DB17E:
	JSR.w CODE_0DB125
	LDA.b $0F
	CMP.b #$0B
	BNE.b CODE_0DB18C
	LDA.b #$28
	STA.w $0709
CODE_0DB18C:
	JMP.w CODE_0DBEF0

;--------------------------------------------------------------------

DATA_0DB18F:
	db $0E,$04,$FC,$F2

DATA_0DB193:
	db $00,$00,$FF,$FF

CODE_0DB197:
	LDA.w $041C
	CLC
	ADC.w $043C
	STA.w $041C
	LDY.b #$00
	LDA.b $A0
	BPL.b CODE_0DB1A8
	DEY
CODE_0DB1A8:
	STY.b $00
	ADC.w $0237
	STA.w $0237
	LDA.b $BB
	ADC.b $00
	STA.b $BB
	LDA.b $0C
	AND.w $0480
	BEQ.b CODE_0DB1F5
	LDY.w $0791
	BNE.b CODE_0DB1F4
	LDY.b #$18
	STY.w $0791
	LDX.b #$00
	LDY.w $0202
	LSR
	BCS.b CODE_0DB1D8
	LDA.w $03AD
	CMP.b #$10
	BCC.b CODE_0DB1F4
	INX
	INX
CODE_0DB1D8:
	DEY
	BEQ.b CODE_0DB1DC
	INX
CODE_0DB1DC:
	LDA.w $0219
	CLC
	ADC.w DATA_0DB18F,x
	STA.w $0219
	LDA.b $78
	ADC.w DATA_0DB193,x
	STA.b $78
	LDA.b $0C
	EOR.b #$03
	STA.w $0202
CODE_0DB1F4:
	RTS

CODE_0DB1F5:
	STA.w $0791
	RTS

;--------------------------------------------------------------------

if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
DATA_0DB1F9:
	db $30,$30,$2D,$38,$38,$0D,$04

DATA_0DB200:
	db $A6,$A6,$8E,$CE,$CE,$0A,$09

DATA_0DB207:
	db $C0,$00,$80

DATA_0DB20A:
	db $22,$22,$22,$30,$30,$0D,$04

DATA_0DB211:
	db $63,$63,$5D,$86,$86,$0A,$09

DATA_0DB218:
	db $00,$00,$00

DATA_0DB21B:
	db $FB,$FB,$FB,$FA,$FA,$FE,$FF

DATA_0DB222:
	db $34,$34,$34,$00,$00,$80,$00

DATA_0DB229:
	db $D0,$E4,$ED

DATA_0DB22C:
	db $30,$1C,$13,$0E
else
DATA_0DB1F9:
	db $20,$20,$1E,$28,$28,$0D,$04

DATA_0DB200:
	db $70,$70,$60,$90,$90,$0A,$09

DATA_0DB207:
	db $E4,$98,$D0

DATA_0DB20A:
	db $18,$18,$18,$22,$22,$0D,$04

DATA_0DB211:
	db $42,$42,$3E,$5D,$5D,$0A,$09

DATA_0DB218:
	db $B4,$68,$A0

DATA_0DB21B:
	db $FC,$FC,$FC,$FB,$FB,$FE,$FF

DATA_0DB222:
	db $00,$00,$00,$00,$00,$80,$00

DATA_0DB229:
	db $D8,$E8,$F0

DATA_0DB22C:
	db $28,$18,$10,$0C
endif

DATA_0DB230:
	db $00,$FF,$01

DATA_0DB233:
	db $00,$20,$FF

CODE_0DB236:
	LDA.b $28
	CMP.b #$03
	BNE.b CODE_0DB26C
	LDY.b #$00
	LDA.b $0B
	AND.w $0480
	BEQ.b CODE_0DB258
	INY
	AND.b #$08
	BEQ.b CODE_0DB257
	LDA.b $09
	AND.b #$07
	BNE.b CODE_0DB258
	LDA.b #!Define_SMAS_Sound0060_ClimbVine
	STA.w !RAM_SMBLL_Global_SoundCh1
	BRA.b CODE_0DB258

CODE_0DB257:
	INY
CODE_0DB258:
	LDX.w DATA_0DB233,y
	STX.w $043C
	LDA.b #$08
	LDX.w DATA_0DB230,y
	STX.b $A0
	BMI.b CODE_0DB268
	LSR
CODE_0DB268:
	STA.w $070C
	RTS

CODE_0DB26C:
	LDA.w $070E
	BNE.b CODE_0DB27B
	LDA.b $0A
	AND.b #$80
	BEQ.b CODE_0DB27B
	AND.b $0D
	BEQ.b CODE_0DB27E
CODE_0DB27B:
	JMP.w CODE_0DB327

CODE_0DB27E:
	LDA.b $28
	BEQ.b CODE_0DB293
	LDA.w $0704
	BEQ.b CODE_0DB27B
	LDA.w $078A
	BNE.b CODE_0DB293
	LDA.b $A0
	BPL.b CODE_0DB293
	JMP.w CODE_0DB327

CODE_0DB293:
	LDA.b #$20
	STA.w $078A
	LDY.b #$00
	STY.w $041C
	STY.w $043C
	LDA.b $BB
	STA.w $0707
	LDA.w $0237
	STA.w $0708
	LDA.b #$01
	STA.b $28
	LDA.w $0700
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	CMP.b #$0A
else
	CMP.b #$09
endif
	BCC.b CODE_0DB2C6
	INY
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	CMP.b #$12
else
	CMP.b #$10
endif
	BCC.b CODE_0DB2C6
	INY
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	CMP.b #$1D
else
	CMP.b #$19
endif
	BCC.b CODE_0DB2C6
	INY
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	CMP.b #$22
else
	CMP.b #$1C
endif
	BCC.b CODE_0DB2C6
	INY
CODE_0DB2C6:
	LDA.b #$01
	STA.w $0706
	LDA.w $0704
	BEQ.b CODE_0DB2D8
	LDY.b #$05
	LDA.w $027D
	BEQ.b CODE_0DB2D8
	INY
CODE_0DB2D8:
	LDA.w $0753
	BNE.b CODE_0DB2F6
	LDA.w DATA_0DB1F9,y
	STA.w $0709
	LDA.w DATA_0DB200,y
	STA.w $070A
	LDA.w DATA_0DB222,y
	STA.w $043C
	LDA.w DATA_0DB21B,y
	STA.b $A0
	BRA.b CODE_0DB30D

CODE_0DB2F6:
	LDA.w DATA_0DB20A,y
	STA.w $0709
	LDA.w DATA_0DB211,y
	STA.w $070A
	LDA.w DATA_0DB222,y
	STA.w $043C
	LDA.w DATA_0DB21B,y
	STA.b $A0
CODE_0DB30D:
	LDA.w $0704
	BEQ.b CODE_0DB322
	LDA.b #!Define_SMAS_Sound0060_Swim
	STA.w !RAM_SMBLL_Global_SoundCh1
	LDA.w $0237
	CMP.b #$14
	BCS.b CODE_0DB327
	STZ.b $A0
	BRA.b CODE_0DB327

CODE_0DB322:
	LDA.b #!Define_SMAS_Sound0061_Jump
	TSB.w !RAM_SMBLL_Global_SoundCh2
CODE_0DB327:
	LDY.b #$00
	STY.b $00
	LDA.b $28
	BEQ.b CODE_0DB338
	LDA.w $0700
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	CMP.b #$1D
else
	CMP.b #$19
endif
	BCS.b CODE_0DB368
	BCC.b CODE_0DB34F							; Note: This will always branch.

CODE_0DB338:
	INY
	LDA.b $5C
	BEQ.b CODE_0DB34F
	DEY
	LDA.b $0C
	CMP.b $46
	BNE.b CODE_0DB34F
	LDA.b $0A
	AND.b #$40
	BNE.b CODE_0DB363
	LDA.w $078B
	BNE.b CODE_0DB368
CODE_0DB34F:
	INY
	INC.b $00
	LDA.w $0703
	BNE.b CODE_0DB35E
	LDA.w $0700
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	CMP.b #$27
else
	CMP.b #$21
endif
	BCC.b CODE_0DB368
CODE_0DB35E:
	INC.b $00
	JMP.w CODE_0DB368

CODE_0DB363:
	LDA.b #$0A
	STA.w $078B
CODE_0DB368:
	LDA.w DATA_0DB229,y
	STA.w $045D
	LDA.b $0F
	CMP.b #$07
	BNE.b CODE_0DB376
	LDY.b #$03
CODE_0DB376:
	LDA.w DATA_0DB22C,y
	STA.w $0463
	LDY.b $00
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDA.w $0753
	BEQ.b +
	LDA.w DATA_0DB218,y
	BRA.b CODE_0DB381

+:
endif
	LDA.w DATA_0DB207,y
CODE_0DB381:
	STA.w $0702
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDA.b #$01
	STA.w $0701
else
	STZ.w $0701
endif
	LDA.w $0202
	CMP.b $46
	BEQ.b CODE_0DB399
DATA_0DB38E:
	LDA.w $0EC2
	BNE.b CODE_0DB399
	ASL.w $0702
	ROL.w $0701
CODE_0DB399:
	RTS

;--------------------------------------------------------------------

DATA_0DB39A:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	db $02,$03,$05
else
	db $02,$04,$07
endif

CODE_0DB39D:
	LDY.b #$00
	LDA.w $0700
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	CMP.b #$20
else
	CMP.b #$1C
endif
	BCS.b CODE_0DB3BB
	INY
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	CMP.b #$10
else
	CMP.b #$0E
endif
	BCS.b CODE_0DB3AC
	INY
CODE_0DB3AC:
	LDA.w $0FF4
	AND.b #$7F
	BEQ.b CODE_0DB3D1
	AND.b #$03
	CMP.b $46
	BNE.b CODE_0DB3C0
	LDA.b #$00
CODE_0DB3BB:
	STA.w $0703
	BRA.b CODE_0DB3D1

CODE_0DB3C0:
	LDA.w $0700
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	CMP.b #$0D
else
	CMP.b #$0B
endif
	BCS.b CODE_0DB3D1
	LDA.w $0202
	STA.b $46
	STZ.b $5D
	STZ.w $0705
CODE_0DB3D1:
	LDA.w DATA_0DB39A,y
	STA.w $070C
	RTS

;--------------------------------------------------------------------

CODE_0DB3D8:
	AND.w $0480
	CMP.b #$00
	BNE.b CODE_0DB3E7
	LDA.b $5D
	BEQ.b CODE_0DB42B
	BPL.b CODE_0DB407
	BMI.b CODE_0DB3EA

CODE_0DB3E7:
	LSR
	BCC.b CODE_0DB407
CODE_0DB3EA:
	LDA.w $0705
	CLC
	ADC.w $0702
	STA.w $0705
	LDA.b $5D
	ADC.w $0701
	STA.b $5D
	CMP.w $0463
	BMI.b CODE_0DB422
	LDA.w $0463
	STA.b $5D
	BRA.b CODE_0DB42B

CODE_0DB407:
	LDA.w $0705
	SEC
	SBC.w $0702
	STA.w $0705
	LDA.b $5D
	SBC.w $0701
	STA.b $5D
	CMP.w $045D
	BPL.b CODE_0DB422
	LDA.w $045D
	STA.b $5D
CODE_0DB422:
	CMP.b #$00
	BPL.b CODE_0DB42B
	EOR.b #$FF
	CLC
	ADC.b #$01
CODE_0DB42B:
	STA.w $0700
	RTS

;--------------------------------------------------------------------

CODE_0DB42F:
	LDA.w $0756
	CMP.b #$02
	BCC.b CODE_0DB47A
	LDA.b $0A
	AND.b #$40
	BEQ.b CODE_0DB470
	AND.b $0D
	BNE.b CODE_0DB470
	LDA.w $06CE
	AND.b #$01
	TAX
	LDA.b $33,x
	BNE.b CODE_0DB470
	LDY.b $BB
	DEY
	BNE.b CODE_0DB470
	LDA.w $0714
	BNE.b CODE_0DB470
	LDA.b $28
	CMP.b #$03
	BEQ.b CODE_0DB470
	LDA.b #!Define_SMAS_Sound0063_ShootFireball
	STA.w !RAM_SMBLL_Global_SoundCh3
	LDA.b #$02
	STA.b $33,x
	LDY.w $070C
	STY.w $0711
	DEY
	STY.w $0789
	INC.w $06CE
CODE_0DB470:
	LDX.b #$00
	JSR.w CODE_0DB495
	LDX.b #$01
	JSR.w CODE_0DB495
CODE_0DB47A:
	LDA.b $5C
	BNE.b CODE_0DB492
	LDX.b #$02
CODE_0DB480:
	STX.b $9E
	JSR.w CODE_0DB52F
	JSR.w CODE_0DFD30
	JSR.w CODE_0DFDC3
	JSL.l CODE_0FEC71
	DEX
	BPL.b CODE_0DB480
CODE_0DB492:
	RTS

;--------------------------------------------------------------------

DATA_0DB493:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	db $4C,$B4
else
	db $40,$C0
endif

CODE_0DB495:
	STX.b $9E
	LDA.b $33,x
	ASL
	BCC.b CODE_0DB49F
	JMP.w CODE_0DB529

CODE_0DB49F:
	LDY.b $33,x
	BNE.b CODE_0DB4A6
	JMP.w CODE_0DB528

CODE_0DB4A6:
	DEY
	BEQ.b CODE_0DB4D5
	LDA.w $0219
	ADC.b #$04
	STA.w $0224,x
	LDA.b $78
	ADC.b #$00
	STA.b $83,x
	LDA.w $0237
	STA.w $0242,x
	LDA.b #$01
	STA.b $C6,x
	LDY.w $0202
	DEY
	LDA.w DATA_0DB493,y
	STA.b $68,x
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDA.b #$05
else
	LDA.b #$04
endif
	STA.b $AB,x
	LDA.b #$07
	STA.w $049A,x
	DEC.b $33,x
CODE_0DB4D5:
	TXA
	CLC
	ADC.b #$0B
	TAX
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDA.b #$60
else
	LDA.b #$50
endif
	STA.b $00
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDA.b #$05
else
	LDA.b #$03
endif
	STA.b $02
	LDA.b #$00
	JSR.w CODE_0DBF7E
	JSR.w CODE_0DBEAD
	LDX.b $9E
	JSR.w CODE_0DFD39
	JSR.w CODE_0DFDB9
	JSR.w CODE_0DE932
	JSR.w CODE_0DE8C2
	LDA.w $03D2
	AND.b #$FC
	BEQ.b CODE_0DB51E
	AND.b #$F0
	BNE.b CODE_0DB524
	LDA.w $0068,x
	BMI.b CODE_0DB513
	LDA.w $03D2
	AND.b #$0F
	CMP.b #$0F
	BEQ.b CODE_0DB524
	BRA.b CODE_0DB521

CODE_0DB513:
	LDA.w $03D2
	AND.b #$0C
	CMP.b #$0C
	BEQ.b CODE_0DB524
	BRA.b CODE_0DB521

CODE_0DB51E:
	JSR.w CODE_0DDB80
CODE_0DB521:
	JMP.w CODE_0DF433

CODE_0DB524:
	LDA.b #$00
	STA.b $33,x
CODE_0DB528:
	RTS

CODE_0DB529:
	JSR.w CODE_0DFD39
	JMP.w CODE_0DF498

;--------------------------------------------------------------------

CODE_0DB52F:
	LDA.w $07B8,x
	AND.b #$01
	STA.b $07
	LDA.w $0251,x
	CMP.b #$F8
	BNE.b CODE_0DB56E
	LDA.w $079E
	BNE.b CODE_0DB588
CODE_0DB542:
	LDY.b #$00
	LDA.w $0202
	LSR
	BCC.b CODE_0DB54C
	LDY.b #$08
CODE_0DB54C:
	TYA
	ADC.w $0219
	STA.w $0233,x
	LDA.b $78
	ADC.b #$00
	STA.b $92,x
	LDA.w $0237
	CLC
	ADC.b #$08
	STA.w $0251,x
	LDA.b #$01
	STA.b $D5,x
	LDY.b $07
	LDA.w DATA_0DB58B,y
	STA.w $079E
CODE_0DB56E:
	LDY.b $07
	LDA.w $0436,x
	SEC
	SBC.w DATA_0DB589,y
	STA.w $0436,x
	LDA.w $0251,x
	SBC.b #$00
	CMP.b #$20
	BCS.b CODE_0DB585
	LDA.b #$F8
CODE_0DB585:
	STA.w $0251,x
CODE_0DB588:
	RTS

DATA_0DB589:
	db $FF,$50

DATA_0DB58B:
	db $40,$20

;--------------------------------------------------------------------

CODE_0DB58D:
	LDA.w $0770
	BEQ.b CODE_0DB5E7
	LDA.b $0F
	CMP.b #$08
	BCC.b CODE_0DB5E7
	CMP.b #$0B
	BEQ.b CODE_0DB5E7
	LDA.b $BB
	CMP.b #$02
	BPL.b CODE_0DB5E7
	LDA.w $078F
	BNE.b CODE_0DB5E7
	LDA.w $07E9
	ORA.w $07EA
	ORA.w $07EB
	BEQ.b CODE_0DB5DE
	LDY.w $07E9
	DEY
	BNE.b CODE_0DB5C5
	LDA.w $07EA
	ORA.w $07EB
	BNE.b CODE_0DB5C5
	LDA.b #!Define_SMAS_Sound0060_IncreaseMusicTempo
	STA.w !RAM_SMBLL_Global_SoundCh1
CODE_0DB5C5:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDA.b #$14
else
	LDA.b #$18
endif
	STA.w $078F
	LDY.b #$23
	LDA.b #$FF
	STA.w $014A
	LDA.w $0E73
	BNE.b CODE_0DB5D9
	JSR.w CODE_0D98AA
CODE_0DB5D9:
	LDA.b #$A4
	JMP.w CODE_0D983D

CODE_0DB5DE:
	STA.w $0756
	JSR.w CODE_0DDE8A
	INC.w $0759
CODE_0DB5E7:
	RTS

;--------------------------------------------------------------------

CODE_0DB5E8:
	LDA.w $0723
	BEQ.b CODE_0DB5E7
	LDA.w $0237
	AND.b $BB
	BNE.b CODE_0DB5E7
	STA.w $0723
	JMP.w CODE_0DCCEA

;--------------------------------------------------------------------

CODE_0DB5FA:
	LDA.b $5C
	BNE.b CODE_0DB63B
	STA.w $027D
	JSL.l SMB1_AdjustUnderwaterHDMAGradient_Main				; Note: Call to SMB1 function
	LDA.w $0747
	BNE.b CODE_0DB63B
	LDY.b #$04
CODE_0DB60C:
	LDA.w $0271,y
	CLC
	ADC.w $0277,y
	STA.b $02
	LDA.w $026B,y
	BEQ.b CODE_0DB638
	ADC.b #$00
	STA.b $01
	LDA.w $0219
	SEC
	SBC.w $0271,y
	LDA.b $78
	SBC.w $026B,y
	BMI.b CODE_0DB638
	LDA.b $02
	SEC
	SBC.w $0219
	LDA.b $01
	SBC.b $78
	BPL.b CODE_0DB63C
CODE_0DB638:
	DEY
	BPL.b CODE_0DB60C
CODE_0DB63B:
	RTS

CODE_0DB63C:
	LDA.w $0277,y
	LSR
	STA.b $00
	LDA.w $0271,y
	CLC
	ADC.b $00
	STA.b $01
	LDA.w $026B,y
	ADC.b #$00
	STA.b $00
	LDA.b $09
	LSR
	BCC.b CODE_0DB687
	LDA.b $01
	SEC
	SBC.w $0219
	LDA.b $00
	SBC.b $78
	BPL.b CODE_0DB672
	LDA.w $0219
	SEC
	SBC.b #$01
	STA.w $0219
	LDA.b $78
	SBC.b #$00
	JMP.w CODE_0DB685

CODE_0DB672:
	LDA.w $0480
	LSR
	BCC.b CODE_0DB687
	LDA.w $0219
	CLC
	ADC.b #$01
	STA.w $0219
	LDA.b $78
	ADC.b #$00
CODE_0DB685:
	STA.b $78
CODE_0DB687:
	LDA.b #$10
	STA.b $00
	LDA.b #$01
	STA.w $027D
	STA.b $02
	LSR
	TAX
	JMP.w CODE_0DBF7E

;--------------------------------------------------------------------

DATA_0DB697:
	db $05,$02,$08,$04,$01

DATA_0DB69C:
	db $03,$03,$04,$04,$04

CODE_0DB6A1:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDX.b #$09
else
	LDX.b #$05
endif
	STX.b $9E
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$30
	BEQ.b CODE_0DB6AC
	RTS

CODE_0DB6AC:
	LDA.b $0F
	CMP.b #$04
	BNE.b CODE_0DB6E7
	LDA.b $28
	CMP.b #$03
	BNE.b CODE_0DB6E7
	LDA.w $0238,x
	CMP.b #$AA
	BCS.b CODE_0DB6EA
	LDA.w $0237
	CMP.b #$A2
	BCS.b CODE_0DB6EA
	LDA.w $041D,x
	ADC.b #$FF
	STA.w $041D,x
	LDA.w $0238,x
	ADC.b #$01
	STA.w $0238,x
	LDA.w $010E
	SEC
	SBC.b #$FF
	STA.w $010E
	LDA.w $010D
	SBC.b #$01
	STA.w $010D
CODE_0DB6E7:
	JMP.w CODE_0DB735

CODE_0DB6EA:
	LDY.w $010F
	CPY.b #$05
	BNE.b CODE_0DB6FD
	JSL.l CODE_048596				; Note: Call to SMB1 function
	LDA.b #!Define_SMAS_Sound0063_1up
	STA.w !RAM_SMBLL_Global_SoundCh3
	JMP.w CODE_0DB709

CODE_0DB6FD:
	LDA.w DATA_0DB697,y
	LDX.w DATA_0DB69C,y
	STA.w $0145,x
	JSR.w CODE_0DBB27
CODE_0DB709:
	LDA.b #$05
	STA.b $0F
	LDA.b #!Define_SMBLL_LevelMusic_PassedLevel
	STA.w !RAM_SMBLL_Global_MusicCh1
	LDA.w $0202
	AND.b #$02
	BNE.b CODE_0DB71D
	LDA.b #$6E
	BRA.b CODE_0DB71F

CODE_0DB71D:
	LDA.b #$60
CODE_0DB71F:
	STA.w $02FD
	LDA.w $0219
	STA.w $03CC
	LDA.b $78
	STA.w $03CD
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDA.b #$18
else
	LDA.b #$20
endif
	STA.w $03FB
	STA.w $03FA
CODE_0DB735:
	JSR.w CODE_0DFDE1
	JSR.w CODE_0DFD4F
	JSL.l CODE_0FFC91
	RTS

;--------------------------------------------------------------------

DATA_0DB740:
	db $08,$10,$08,$00

CODE_0DB744:
	JSR.w CODE_0DFDE1
	LDA.w $0747
	BNE.b CODE_0DB7AD
	LDA.w $070E
	BEQ.b CODE_0DB7AD
	TAY
	DEY
	TYA
	AND.b #$02
	BNE.b CODE_0DB761
	INC.w $0237
	INC.w $0237
	JMP.w CODE_0DB767

CODE_0DB761:
	DEC.w $0237
	DEC.w $0237
CODE_0DB767:
	LDA.b $5E,x
	CLC
	ADC.w DATA_0DB740,y
	STA.w $0238,x
	CPY.b #$01
	BCC.b CODE_0DB79C
	LDA.b $0A
	AND.b #$80
	BEQ.b CODE_0DB79C
	AND.b $0D
	BNE.b CODE_0DB79C
	TYA
	PHA
	LDA.b #$F4
	LDY.w $075F
	CPY.b #$0B
	BEQ.b CODE_0DB795
	CPY.b #$01
	BEQ.b CODE_0DB795
	CPY.b #$02
	BEQ.b CODE_0DB795
	CPY.b #$06
	BNE.b CODE_0DB797
CODE_0DB795:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDA.b #$E1
else
	LDA.b #$E0
endif
CODE_0DB797:
	STA.w $06DB
	PLA
	TAY
CODE_0DB79C:
	CPY.b #$03
	BNE.b CODE_0DB7AD
	LDA.w $06DB
	STA.b $A0
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDA.b #$40
	STA.w $0709
endif
	STZ.w $070E
	LDA.b #!Define_SMAS_Sound0063_Springboard
	STA.w !RAM_SMBLL_Global_SoundCh3
CODE_0DB7AD:
	JSR.w CODE_0DFD4F
	JSR.w CODE_0DEE40
	JSR.w CODE_0DDAFC
	LDA.w $070E
	BEQ.b CODE_0DB7C8
	LDA.w $078E
	BNE.b CODE_0DB7C8
	LDA.b #$04
	STA.w $078E
	INC.w $070E
CODE_0DB7C8:
	RTS

;--------------------------------------------------------------------

CODE_0DB7C9:
	LDA.b #$2F
	STA.b !RAM_SMBLL_NorSpr_SpriteID,x
	LDA.b #$01
	STA.b $10,x
	LDA.w $0085,y
	STA.b $79,x
	LDA.w $0226,y
	STA.w $021A,x
	LDA.w $0244,y
	BNE.b CODE_0DB7E3
	LDA.b #$F0
CODE_0DB7E3:
	STA.w $0238,x
	LDY.w $0398
	BNE.b CODE_0DB7EE
	STA.w $039D
CODE_0DB7EE:
	TXA
	STA.w $039A,y
	INC.w $0398
	LDA.b #!Define_SMAS_Sound0063_HitVineBlock
	STA.w !RAM_SMBLL_Global_SoundCh3
	RTS

;--------------------------------------------------------------------

CODE_0DB7FB:
	CPX.b #$09
	BEQ.b CODE_0DB800
	RTS

CODE_0DB800:
	LDA.w $0236
	BNE.b CODE_0DB809
	LDA.b #$90
	BRA.b CODE_0DB80B

CODE_0DB809:
	LDA.b #$60
CODE_0DB80B:
	CMP.w $0399
	BEQ.b CODE_0DB81B
	LDA.b $09
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	AND.b #$03
	BEQ.b CODE_0DB81B
	DEC.w $0241
else
	LSR
	BCC.b CODE_0DB81B
	DEC.w $0241
endif
	INC.w $0399
CODE_0DB81B:
	LDA.w $0399
	CMP.b #$08
	BCC.b CODE_0DB86E
	JSR.w CODE_0DFD4F
	JSR.w CODE_0DFDE1
	LDY.b #$00
	JSL.l CODE_0FE8BE
	LDA.w $03D1
	AND.b #$0F
	CMP.b #$0F
	BNE.b CODE_0DB842
	LDX.b #$09
	JSR.w CODE_0DCCEA
	STA.w $0398
	STA.w $0399
CODE_0DB842:
	LDX.b #$0A
	LDA.b #$01
	LDY.b #$1B
	JSR.w CODE_0DEAFF
	LDY.b $02
	CPY.b #$D0
	BCS.b CODE_0DB86E
	LDA.w $0236
	BNE.b CODE_0DB859
	TYA
	BMI.b CODE_0DB86E
CODE_0DB859:
	LDA.b ($06),y
	BNE.b CODE_0DB86E
	LDA.b #$2F
	STA.b ($06),y
	TYA
	BMI.b CODE_0DB86E
	SEC
	SBC.b #$10
	BEQ.b CODE_0DB86E
	BMI.b CODE_0DB86E
	TAY
	BRA.b CODE_0DB859

CODE_0DB86E:
	LDY.b $02
	LDX.b $9E
	RTS

;--------------------------------------------------------------------

DATA_0DB873:
	db $0F,$07

CODE_0DB875:
	LDA.b $5C
	BEQ.b CODE_0DB8E8
	LDX.b #$02
CODE_0DB87B:
	STX.b $9E
	LDA.b $10,x
	BNE.b CODE_0DB8D2
	LDA.w $07B8,x
	LDY.w $06CC
	AND.w DATA_0DB873,y
	CMP.b #$06
	BCS.b CODE_0DB8D2
	TAY
	LDA.w $026B,y
	BEQ.b CODE_0DB8D2
	LDA.w $027D,y
	BEQ.b CODE_0DB8A0
	SBC.b #$00
	STA.w $027D,y
	BRA.b CODE_0DB8D2

CODE_0DB8A0:
	LDA.w $0747
	BNE.b CODE_0DB8D2
	LDA.b #$0E
	STA.w $027D,y
	LDA.w $026B,y
	STA.b $79,x
	LDA.w $0271,y
	STA.w $021A,x
	LDA.w $0277,y
	SEC
	SBC.b #$08
	STA.w $0238,x
	LDA.b #$01
	STA.b $BC,x
	STA.b $10,x
	LSR
	STA.b $29,x
	LDA.b #$09
	STA.w $0490,x
	LDA.b #$33
	STA.b !RAM_SMBLL_NorSpr_SpriteID,x
	BRA.b CODE_0DB8E5

CODE_0DB8D2:
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$33
	BNE.b CODE_0DB8E5
	JSR.w CODE_0DDAFC
	LDA.b $10,x
	BEQ.b CODE_0DB8E5
	JSR.w CODE_0DFDE1
	JSR.w CODE_0DB8EB
CODE_0DB8E5:
	DEX
	BPL.b CODE_0DB87B
CODE_0DB8E8:
	RTS

;--------------------------------------------------------------------

DATA_0DB8E9:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	db $1C,$E4
else
	db $18,$E8
endif

CODE_0DB8EB:
	LDA.w $0747
	BNE.b CODE_0DB943
	LDA.b $29,x
	BNE.b CODE_0DB926
	LDA.w $03D1
	AND.b #$0C
	CMP.b #$0C
	BEQ.b CODE_0DB952
	LDY.b #$01
	JSR.w CODE_0DE828
	BMI.b CODE_0DB905
	INY
CODE_0DB905:
	STY.b $47,x
	DEY
	LDA.w DATA_0DB8E9,y
	STA.b $5E,x
	LDA.b $00
	ADC.b #$28
	CMP.b #$50
	BCC.b CODE_0DB952
	LDA.b #$01
	STA.b $29,x
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDA.b #$09
else
	LDA.b #$0A
endif
	STA.w $0792,x
	LDA.b #!Define_SMAS_Sound0063_CannonShoot
	STA.w !RAM_SMBLL_Global_SoundCh3
	JSR.w CODE_0DC06E
CODE_0DB926:
	LDA.w $03D1
	AND.b #$F0
	CMP.b #$F0
	BEQ.b CODE_0DB952
	LDA.b $29,x
	AND.b #$20
	BEQ.b CODE_0DB938
	JSR.w CODE_0DBF06
CODE_0DB938:
	LDA.w $0E67
	BNE.b CODE_0DB943
	JSR.w CODE_0DBEA0
	JSR.w CODE_0DBFED
CODE_0DB943:
	JSR.w CODE_0DFDE1
	JSR.w CODE_0DFD4F
	JSR.w CODE_0DE948
	JSR.w CODE_0DDD7D
	JMP.w CODE_0DEE40

CODE_0DB952:
	JSR.w CODE_0DCCEA
	RTS

;--------------------------------------------------------------------

DATA_0DB956:
	db $04,$04,$04,$05,$05,$05,$06,$06
	db $06

DATA_0DB95F:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	db $14,$EC
else
	db $10,$F0
endif

CODE_0DB961:
	LDA.w $07B8
	AND.b #$07
	BNE.b CODE_0DB96D
	LDA.w $07B8
	AND.b #$08
CODE_0DB96D:
	TAY
	LDA.w $0039,y
	BNE.b CODE_0DB98C
	LDX.w DATA_0DB956,y
	LDA.b $10,x
	BNE.b CODE_0DB98C
	LDX.b $9E
	TXA
	STA.w $06AE,y
	LDA.b #$90
	STA.w $0039,y
	LDA.b #$07
	STA.w $049C,y
	SEC
	RTS

CODE_0DB98C:
	LDX.b $9E
	CLC
	RTS

;--------------------------------------------------------------------

CODE_0DB990:
	LDA.w $0747
	BEQ.b CODE_0DB998
	JMP.w CODE_0DBA1E

CODE_0DB998:
	LDA.b $39,x
	AND.b #$7F
	LDY.w $06AE,x
	CMP.b #$02
	BEQ.b CODE_0DB9C3
	BCS.b CODE_0DB9D9
	TXA
	CLC
	ADC.b #$11
	TAX
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDA.b #$23
else
	LDA.b #$10
endif
	STA.b $00
	LDA.b #$0F
	STA.b $01
	LDA.b #$04
	STA.b $02
	LDA.b #$00
	JSR.w CODE_0DBF7E
	JSR.w CODE_0DBEAD
	LDX.b $9E
	JMP.w CODE_0DBA1B

CODE_0DB9C3:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDA.b #$FD
else
	LDA.b #$FE
endif
	STA.b $B1,x
	LDA.w $0029,y
	AND.b #$F7
	STA.w $0029,y
	LDX.b $47,y
	DEX
	LDA.w DATA_0DB95F,x
	LDX.b $9E
	STA.b $6E,x
CODE_0DB9D9:
	DEC.b $39,x
	LDA.b $39,x
	CMP.b #$81
	BNE.b CODE_0DB9E6
	LDA.b #!Define_SMAS_Sound0060_EnemyProjectileThrow
	STA.w !RAM_SMBLL_Global_SoundCh1
CODE_0DB9E6:
	LDA.w !RAM_SMBLL_NorSpr_SpriteID,y
	CMP.b #$2D
	BNE.b CODE_0DB9F1
	LDA.b #$08
	BRA.b CODE_0DB9FE

CODE_0DB9F1:
	LDA.w $0047,y
	CMP.b #$02
	BNE.b CODE_0DB9FC
	LDA.b #$06
	BRA.b CODE_0DB9FE

CODE_0DB9FC:
	LDA.b #$02
CODE_0DB9FE:
	CLC
	ADC.w $021A,y
	STA.w $022A,x
	LDA.w $0079,y
	ADC.b #$00
	STA.b $89,x
	LDA.w $0238,y
	SEC
	SBC.b #$0A
	STA.w $0248,x
	LDA.b #$01
	STA.b $CC,x
	BNE.b CODE_0DBA1E

CODE_0DBA1B:
	JSR.w CODE_0DDCD9
CODE_0DBA1E:
	JSR.w CODE_0DFDCD
	JSR.w CODE_0DFD46
	JSR.w CODE_0DE93B
	JSL.l CODE_0FEBA4
	RTS

;--------------------------------------------------------------------

CODE_0DBA2C:
	JSR.w CODE_0DBA7A
	LDA.b $85,x
	STA.w $0089,y
	LDA.w $0226,x
	ORA.b #$05
	STA.w $022A,y
	LDA.w $0244,x
	SBC.b #$10
	STA.w $0248,y
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMBLL_J) != $00
	JMP.w CODE_0DBA61
else
	BRA.b CODE_0DBA61
endif

CODE_0DBA46:
	JSR.w CODE_0DBA7A
	LDA.w $03EC,x
	STA.w $0089,y
	LDA.b $06
	ASL
	ASL
	ASL
	ASL
	ORA.b #$05
	STA.w $022A,y
	LDA.b $02
	ADC.b #$20
	STA.w $0248,y
CODE_0DBA61:
	LDA.b #$FB
	STA.w $00B1,y
	LDA.b #$01
	STA.w $00CC,y
	STA.w $0039,y
	STA.w !RAM_SMBLL_Global_SoundCh3					; Note: !Define_SMAS_Sound0063_Coin
	STX.b $9E
	JSR.w CODE_0DBAFF
	INC.w $0748
	RTS

;--------------------------------------------------------------------

CODE_0DBA7A:
	LDY.b #$08
CODE_0DBA7C:
	LDA.w $0039,y
	BEQ.b CODE_0DBA88
	DEY
	CPY.b #$05
	BNE.b CODE_0DBA7C
	LDY.b #$08
CODE_0DBA88:
	STY.w $06B7
	RTS

;--------------------------------------------------------------------

CODE_0DBA8C:
	LDX.b #$08
CODE_0DBA8E:
	STX.b $9E
	LDA.b $39,x
	BEQ.b CODE_0DBAF5
	ASL
	BCC.b CODE_0DBA9D
	JSR.w CODE_0DB990
	JMP.w CODE_0DBAF5

CODE_0DBA9D:
	LDY.b $39,x
	DEY
	BEQ.b CODE_0DBAC1
	INC.b $39,x
	LDA.w $022A,x
	CLC
	ADC.w $0775
	STA.w $022A,x
	LDA.b $89,x
	ADC.b #$00
	STA.b $89,x
	LDA.b $39,x
	CMP.b #$30
	BNE.b CODE_0DBAE0
	LDA.b #$00
	STA.b $39,x
	JMP.w CODE_0DBAF5

CODE_0DBAC1:
	TXA
	CLC
	ADC.b #$11
	TAX
	LDA.b #$50
	STA.b $00
	LDA.b #$06
	STA.b $02
	LSR
	STA.b $01
	LDA.b #$00
	JSR.w CODE_0DBF7E
	LDX.b $9E
	LDA.b $B1,x
	CMP.b #$05
	BNE.b CODE_0DBAE0
	INC.b $39,x
CODE_0DBAE0:
	LDA.b $B1,x
	BNE.b CODE_0DBAE8
	JSL.l CODE_0FEB15
CODE_0DBAE8:
	JSR.w CODE_0DFD46
	JSR.w CODE_0DFDCD
	JSR.w CODE_0DE93B
	JSL.l CODE_0FEB37
CODE_0DBAF5:
	DEX
	BPL.b CODE_0DBA8E
	RTS

;--------------------------------------------------------------------

DATA_0DBAF9:
	db $17,$1D

DATA_0DBAFB:
	db $0B,$11

DATA_0DBAFD:
	db $02,$13

CODE_0DBAFF:
	LDA.b #$01
	STA.w $014A
	LDY.w DATA_0DBAF9
	JSR.w CODE_0D98AA
	INC.w $075E
	LDA.w $075E
	CMP.b #$64
	BNE.b CODE_0DBB22
	LDA.b #$00
	STA.w $075E
	JSL.l CODE_048596				; Note: Call to SMB1 function
	LDA.b #!Define_SMAS_Sound0063_1up
	STA.w !RAM_SMBLL_Global_SoundCh3
CODE_0DBB22:
	LDA.b #$02
	STA.w $0149
CODE_0DBB27:
	LDY.w DATA_0DBAFB
	JSR.w CODE_0D98AA
CODE_0DBB2D:
	LDA.w DATA_0DBAFD
CODE_0DBB30:
	JSR.w CODE_0D983D
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) == $00
	LDY.w $1700
	LDA.w $16F6,y
	BNE.b CODE_0DBB49
	LDA.b #$28
	LDX.w $16F2,y
	CPX.b #$02
	BNE.b CODE_0DBB46
	LDA.b #$24
CODE_0DBB46:
	STA.w $16F6,y
CODE_0DBB49:
endif
	LDX.b $9E
	RTS

;--------------------------------------------------------------------

CODE_0DBB4C:
	LDA.b #$2E
	STA.b $25
	LDA.b $85,x
	STA.b $82
	LDA.w $0226,x
	STA.w $0223
	LDA.b #$01
	STA.b $C5
	LDA.w $0244,x
	SEC
	SBC.b #$08
	STA.w $0241
CODE_0DBB67:
	LDA.b #$01
	STA.b $32
	STA.b $19
	LDA.b #$03
	STA.w $0499
	LDA.w $020C
	CMP.b #$02
	BCS.b CODE_0DBB84
	LDA.w $0756
	CMP.b #$02
	BCC.b CODE_0DBB81
	LSR
CODE_0DBB81:
	STA.w $020C
CODE_0DBB84:
	LDA.b #$30
	STA.w $0260
	LDA.b #!Define_SMAS_Sound0063_HitItemBlock
	STA.w !RAM_SMBLL_Global_SoundCh3
	RTS

;--------------------------------------------------------------------

CODE_0DBB8F:
	LDX.b #$09
	STX.b $9E
	LDA.b $32
	BNE.b CODE_0DBB9A
	JMP.w CODE_0DBC46

CODE_0DBB9A:
	ASL
	BCC.b CODE_0DBBC9
	LDA.w $0747
	BNE.b CODE_0DBBF2
	LDA.w $020C
	BEQ.b CODE_0DBBC0
	CMP.b #$03
	BEQ.b CODE_0DBBC0
	CMP.b #$04
	BEQ.b CODE_0DBBC0
	CMP.b #$05
	BEQ.b CODE_0DBBC0
	CMP.b #$02
	BNE.b CODE_0DBBF2
	JSR.w CODE_0DCE92
	JSR.w CODE_0DE84D
	JMP.w CODE_0DBBF2

CODE_0DBBC0:
	JSR.w CODE_0DCE10
	JSR.w CODE_0DE68D
	JMP.w CODE_0DBBF2

CODE_0DBBC9:
	LDA.b $09
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	AND.b #$07
	BEQ.b +
	CMP.b #$03
	BEQ.b +
	CMP.b #$06
	BEQ.b +
	BRA.b CODE_0DBBE9

+:
else
	AND.b #$03
	BNE.b CODE_0DBBE9
endif
	DEC.w $0241
	LDA.b $32
	INC.b $32
	CMP.b #$11
	BCC.b CODE_0DBBE9
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDA.b #$13
else
	LDA.b #$10
endif
	STA.b $5E,x
	LDA.b #$80
	STA.b $32
	ASL
	STA.w $0260
	ROL
	STA.b $47,x
CODE_0DBBE9:
	LDA.b $32
	CMP.b #$06
	BCS.b CODE_0DBBF2
	JMP.w CODE_0DBC46

CODE_0DBBF2:
	JMP.w CODE_0DBC34

;--------------------------------------------------------------------

CODE_0DBBF5:
	LDA.b $79,x
	STA.b $E9
	LDA.w $021A,x
	STA.b $E8
	REP.b #$20
	LDA.b $E8
	CMP.b $42
	BCS.b CODE_0DBC17
	CLC
	ADC.w #$000C
	STA.b $E6
	SEP.b #$20
	LDA.b $E6
	STA.w $021A,x
	LDA.b $E7
	STA.b $79,x
CODE_0DBC17:
	SEP.b #$20
	JSR.w CODE_0DFD4F
	JSR.w CODE_0DFDE1
	JSR.w CODE_0DE948
	JSR.w CODE_0DEC50
	JSR.w CODE_0DDD7D
	JSR.w CODE_0DDAFC
	LDA.b $E8
	STA.w $021A,x
	LDA.b $E9
	STA.b $79,x
CODE_0DBC34:
	JSR.w CODE_0DFD4F
	JSR.w CODE_0DFDE1
	JSR.w CODE_0DE948
	JSR.w CODE_0DEC50
	JSR.w CODE_0DDD7D
	JSR.w CODE_0DDAFC
CODE_0DBC46:
	RTS

;--------------------------------------------------------------------

DATA_0DBC47:
	db $04,$12

CODE_0DBC49:
	PHA
	LDA.b #$11
	LDX.w $03F0
	LDY.w $0754
	BNE.b CODE_0DBC56
	LDA.b #$12
CODE_0DBC56:
	STA.b $35,x
	JSR.w CODE_0D9061
	LDX.w $03F0
	LDA.b $02
	STA.w $03E6,x
	TAY
	LDA.b $06
	STA.w $03E8,x
	LDA.b ($06),y
	JSR.w CODE_0DBD83
	STA.b $00
	LDY.w $0754
	BNE.b CODE_0DBC76
	TYA
CODE_0DBC76:
	BCC.b CODE_0DBC9D
	LDY.b #$11
	STY.b $35,x
	LDA.b #$FD
	LDY.b $00
	CPY.b #$54
	BEQ.b CODE_0DBC88
	CPY.b #$5A
	BNE.b CODE_0DBC9D
CODE_0DBC88:
	LDA.w $06BC
	BNE.b CODE_0DBC95
	LDA.b #$0B
	STA.w $07AD
	INC.w $06BC
CODE_0DBC95:
	LDA.w $07AD
	BNE.b CODE_0DBC9C
	LDY.b #$FD
CODE_0DBC9C:
	TYA
CODE_0DBC9D:
	STA.w $03EA,x
	JSR.w CODE_0DBCE2
	LDY.b $02
	LDA.b #$2C
	STA.b ($06),y
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDA.b #$0C
else
	LDA.b #$10
endif
	STA.w $078C
	PLA
	STA.b $05
	LDY.b #$00
	LDA.w $0714
	BNE.b CODE_0DBCBD
	LDA.w $0754
	BEQ.b CODE_0DBCBE
CODE_0DBCBD:
	INY
CODE_0DBCBE:
	LDA.w $0237
	CLC
	ADC.w DATA_0DBC47,y
	AND.b #$F0
	STA.w $0244,x
	LDY.b $35,x
	CPY.b #$11
	BEQ.b CODE_0DBCD6
	JSR.w CODE_0DBD8F
	JMP.w CODE_0DBCD9

CODE_0DBCD6:
	JSR.w CODE_0DBD01
CODE_0DBCD9:
	LDA.w $03F0
	EOR.b #$01
	STA.w $03F0
	RTS

;--------------------------------------------------------------------

CODE_0DBCE2:
	LDA.w $0219
	CLC
	ADC.b #$08
	AND.b #$F0
	STA.w $0226,x
	STA.w $0E16
	LDA.b $78
	ADC.b #$00
	STA.b $85,x
	STA.w $03EC,x
	STA.w $0E17
	LDA.b $BB
	STA.b $C8,x
	RTS

;--------------------------------------------------------------------

CODE_0DBD01:
	JSR.w CODE_0DBDB4
	LDA.b #!Define_SMAS_Sound0060_HitHead
	STA.w !RAM_SMBLL_Global_SoundCh1
	LDA.b #$00
	STA.b $6A,x
	STA.w $0449,x
	STA.b $A0
	LDA.b #$FE
	STA.b $AD,x
	LDA.b $05
	JSR.w CODE_0DBD83
	BCC.b CODE_0DBD6D
	TYA
	CMP.b #$0D
	BCC.b CODE_0DBD24
	SBC.b #$06
CODE_0DBD24:
	ASL
	TAY
	LDA.w DATA_0DBD33,y
	STA.b $04
	LDA.w DATA_0DBD33+$01,y
	STA.b $05
	JMP.w ($0004)

DATA_0DBD33:
	dw CODE_0DBD51
	dw CODE_0DBD59
	dw CODE_0DBA2C
	dw CODE_0DBA2C
	dw CODE_0DBD5D
	dw CODE_0DBD59
	dw CODE_0DBD51
	dw CODE_0DBD51
	dw CODE_0DBD59
	dw CODE_0DBD65
	dw CODE_0DBD55
	dw CODE_0DBA2C
	dw CODE_0DBD5D
	dw CODE_0DBD65
	dw CODE_0DBD55

;--------------------------------------------------------------------

CODE_0DBD51:
	LDA.b #$00
	BRA.b CODE_0DBD5F

CODE_0DBD55:
	LDA.b #$02
	BRA.b CODE_0DBD5F

CODE_0DBD59:
	LDA.b #$04
	BRA.b CODE_0DBD5F

CODE_0DBD5D:
	LDA.b #$03
CODE_0DBD5F:
	STA.w $020C
	JMP.w CODE_0DBB4C

;--------------------------------------------------------------------

CODE_0DBD65:
	LDX.b #$09
	LDY.w $03F0
	JSR.w CODE_0DB7C9
CODE_0DBD6D:
	RTS

;--------------------------------------------------------------------

DATA_0DBD6E:
	db $E8,$E9,$E7,$5C,$5D,$5E,$5F,$50
	db $51,$52,$53,$54,$55,$56,$57,$58
	db $59,$5A,$5B,$60,$61

CODE_0DBD83:
	LDY.b #$14
CODE_0DBD85:
	CMP.w DATA_0DBD6E,y
	BEQ.b CODE_0DBD8E
	DEY
	BPL.b CODE_0DBD85
	CLC
CODE_0DBD8E:
	RTS

;--------------------------------------------------------------------

CODE_0DBD8F:
	JSR.w CODE_0DBDB4
	LDA.b #$01
	STA.w $03EE,x
	LDA.w !RAM_SMBLL_Global_SoundCh3
	BNE.b CODE_0DBDA1
	LDA.b #!Define_SMAS_Sound0063_BreakBlock
	STA.w !RAM_SMBLL_Global_SoundCh3
CODE_0DBDA1:
	JSR.w CODE_0DBDDB
	LDA.b #$FE					; Glitch: This should be #$01, because this value results in Mario rising when breaking a brick.
	STA.b $A0
	LDA.b #$05
	STA.w $014A
	JSR.w CODE_0DBB27
	LDX.w $03F0
	RTS

;--------------------------------------------------------------------

CODE_0DBDB4:
	LDX.w $03F0
	LDY.b $02
	BEQ.b CODE_0DBDDA
	TYA
	SEC
	SBC.b #$10
	STA.b $02
	TAY
	LDA.b ($06),y
	CMP.b #$EA
	BNE.b CODE_0DBDDA
	LDA.b #$00
	STA.b ($06),y
	LDA.b #!Define_SMAS_Sound0063_Coin
	STA.w !RAM_SMBLL_Global_SoundCh3
	JSR.w CODE_0D9046
	LDX.w $03F0
	JSR.w CODE_0DBA46
CODE_0DBDDA:
	RTS

;--------------------------------------------------------------------

CODE_0DBDDB:
	LDA.w $0226,x
	STA.w $03F3,x
	LDA.b #$F0
	STA.b $6A,x
	STA.b $6C,x
	LDA.b #$FA
	STA.b $AD,x
	LDA.b #$FC
	STA.b $AF,x
	LDA.b #$00
	STA.w $0449,x
	STA.w $044B,x
	LDA.b $85,x
	STA.b $87,x
	LDA.w $0226,x
	STA.w $0228,x
	LDA.w $0244,x
	CLC
	ADC.b #$08
	STA.w $0246,x
	LDA.b #$FA
	STA.b $AD,x
	RTS

;--------------------------------------------------------------------

CODE_0DBE0F:
	LDA.b $35,x
	BEQ.b CODE_0DBE76
	AND.b #$0F
	PHA
	TAY
	TXA
	CLC
	ADC.b #$0D
	TAX
	DEY
	BEQ.b CODE_0DBE55
	JSR.w CODE_0DBF46
	JSR.w CODE_0DBEAD
	TXA
	CLC
	ADC.b #$02
	TAX
	JSR.w CODE_0DBF46
	JSR.w CODE_0DBEAD
	LDX.b $9E
	JSR.w CODE_0DFD56
	JSR.w CODE_0DFDE7
	JSR.w CODE_0DF39C
	PLA
	LDY.b $C8,x
	BEQ.b CODE_0DBE76
	PHA
	LDA.b #$F0
	CMP.w $0246,x
	BCS.b CODE_0DBE4B
	STA.w $0246,x
CODE_0DBE4B:
	LDA.w $0244,x
	CMP.b #$F0
	PLA
	BCC.b CODE_0DBE76
	BCS.b CODE_0DBE74

CODE_0DBE55:
	JSR.w CODE_0DBF46
	LDX.b $9E
	JSR.w CODE_0DFD56
	JSR.w CODE_0DFDE7
	JSR.w CODE_0DF348
	PLA
	STA.b $35,x
	LDA.w $0244,x
	AND.b #$0F
	CMP.b #$05
	BCS.b CODE_0DBE76
	LDA.b #$01
	STA.w $03EE,x
CODE_0DBE74:
	STZ.b $35,x
CODE_0DBE76:
	RTS

;--------------------------------------------------------------------

CODE_0DBE77:
	LDX.b #$01
CODE_0DBE79:
	STX.b $9E
	LDA.w $03EE,x
	BEQ.b CODE_0DBE9C
	LDA.w $03E8,x
	STA.b $06
	LDA.b #$05
	STA.b $07
	LDA.w $03E6,x
	STA.b $02
	TAY
	LDA.w $03EA,x
	STA.b ($06),y
	JSR.w CODE_0D9057
	LDA.b #$00
	STA.w $03EE,x
CODE_0DBE9C:
	DEX
	BPL.b CODE_0DBE79
	RTS

;--------------------------------------------------------------------

CODE_0DBEA0:
	INX
	JSR.w CODE_0DBEAD
	LDX.b $9E
	RTS

CODE_0DBEA7:
	LDA.w $070E
	BNE.b CODE_0DBEEF
	TAX
CODE_0DBEAD:
	LDA.b $5D,x
	ASL
	ASL
	ASL
	ASL
	STA.b $01
	LDA.b $5D,x
	LSR
	LSR
	LSR
	LSR
	CMP.b #$08
	BCC.b CODE_0DBEC1
	ORA.b #$F0
CODE_0DBEC1:
	STA.b $00
	STA.w $0EB6
	LDY.b #$00
	CMP.b #$00
	BPL.b CODE_0DBECD
	DEY
CODE_0DBECD:
	STY.b $02
	LDA.w $0401,x
	CLC
	ADC.b $01
	STA.w $0401,x
	LDA.b #$00
	ROL
	PHA
	ROR
	LDA.w $0219,x
	ADC.b $00
	STA.w $0219,x
	LDA.b $78,x
	ADC.b $02
	STA.b $78,x
	PLA
	CLC
	ADC.b $00
CODE_0DBEEF:
	RTS

;--------------------------------------------------------------------

CODE_0DBEF0:
	LDX.b #$00
	LDA.w $0747
	BNE.b CODE_0DBEFC
	LDA.w $070E
	BNE.b CODE_0DBEEF
CODE_0DBEFC:
	LDA.w $0709
	STA.b $00
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDA.b #$05
else
	LDA.b #$04
endif
	JMP.w CODE_0DBF4F

;--------------------------------------------------------------------

CODE_0DBF06:
	LDY.b #$3D
	LDA.b $29,x
	CMP.b #$05
	BNE.b CODE_0DBF35

CODE_0DBF0E:
	LDY.b #$20
	BRA.b CODE_0DBF35

CODE_0DBF12:
	LDY.b #$00
	BRA.b CODE_0DBF18

CODE_0DBF16:
	LDY.b #$01
CODE_0DBF18:
	INX
	LDA.b #$03
	STA.b $00
	LDA.b #$06
	STA.b $01
	LDA.b #$02
	STA.b $02
	TYA
	JMP.w CODE_0DBF74

;--------------------------------------------------------------------

CODE_0DBF29:
	LDY.b #$7F
	BNE.b CODE_0DBF2F

CODE_0DBF2D:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDY.b #$12
else
	LDY.b #$0F
endif
CODE_0DBF2F:
	LDA.b #$02
	BNE.b CODE_0DBF37

CODE_0DBF33:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDY.b #$1F
else
	LDY.b #$1C
endif
CODE_0DBF35:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDA.b #$04
else
	LDA.b #$03
endif
CODE_0DBF37:
	STY.b $00
	INX
	JSR.w CODE_0DBF4F
	LDX.b $9E
	RTS

;--------------------------------------------------------------------

DATA_0DBF40:
	db $06,$08

CODE_0DBF42:
	LDY.b #$00
	BRA.b CODE_0DBF46				; Optimization: Unnecessary BRA.

CODE_0DBF46:
	LDY.b #$01
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDA.b #$58
else
	LDA.b #$50
endif
	STA.b $00
	LDA.w DATA_0DBF40,y
CODE_0DBF4F:
	STA.b $02
	LDA.b #$00
	JMP.w CODE_0DBF7E

;--------------------------------------------------------------------

CODE_0DBF56:
	LDA.b #$00
	BRA.b CODE_0DBF5C

CODE_0DBF5A:
	LDA.b #$01
CODE_0DBF5C:
	PHA
	LDY.b !RAM_SMBLL_NorSpr_SpriteID,x
	INX
	LDA.b #$05
	CPY.b #$29
	BNE.b CODE_0DBF68
	LDA.b #$09
CODE_0DBF68:
	STA.b $00
	LDA.b #$0A
	STA.b $01
	LDA.b #$03
	STA.b $02
	PLA
	TAY
CODE_0DBF74:
	JSR.w CODE_0DBF7E
	LDX.b $9E
	RTS

;--------------------------------------------------------------------

CODE_0DBF7A:
	JSR.w CODE_0DBF7E
	RTL

CODE_0DBF7E:
	PHA
	LDA.w $041C,x
	CLC
	ADC.w $043C,x
	STA.w $041C,x
	LDY.b #$00
	LDA.b $A0,x
	BPL.b CODE_0DBF90
	DEY
CODE_0DBF90:
	STY.b $07
	ADC.w $0237,x
	STA.w $0237,x
	LDA.b $BB,x
	ADC.b $07
	STA.b $BB,x
	LDA.w $043C,x
	CLC
	ADC.b $00
	STA.w $043C,x
	LDA.b $A0,x
	ADC.b #$00
	STA.b $A0,x
	CMP.b $02
	BMI.b CODE_0DBFBF
	LDA.w $043C,x
	CMP.b #$80
	BCC.b CODE_0DBFBF
	LDA.b $02
	STA.b $A0,x
	STZ.w $043C,x
CODE_0DBFBF:
	PLA
	BEQ.b CODE_0DBFEC
	LDA.b $02
	EOR.b #$FF
	INC
	STA.b $07
	LDA.w $043C,x
	SEC
	SBC.b $01
	STA.w $043C,x
	LDA.b $A0,x
	SBC.b #$00
	STA.b $A0,x
	CMP.b $07
	BPL.b CODE_0DBFEC
	LDA.w $043C,x
	CMP.b #$80
	BCS.b CODE_0DBFEC
	LDA.b $07
	STA.b $A0,x
	LDA.b #$FF
	STA.w $043C,x
CODE_0DBFEC:
	RTS

;--------------------------------------------------------------------

CODE_0DBFED:
	LDA.w $0E9D,x
	BEQ.b CODE_0DC054
	INC.w $0EA2,x
	LDA.w $0EA2,x
	LSR
	LSR
	LSR
	CMP.b #$03
	BEQ.b CODE_0DC055
	ASL
	CLC
	ADC.b #$40
	STA.b $E4
	LDA.w $0EAC,x
	STA.b $E5
	LDA.w $0EA7,x
	STA.b $E6
	REP.b #$20
	LDA.b $E5
	SEC
	SBC.b $42
	PHA
	LDA.w $0EB5
	BMI.b CODE_0DC023
	PLA
	CLC
	ADC.w #$000C
	BRA.b CODE_0DC028

CODE_0DC023:
	PLA
	SEC
	SBC.w #$000C
CODE_0DC028:
	STA.b $E5
	SEP.b #$20
	PHY
	LDY.w $0B46,x
	LDA.b $E5
	STA.w $0900,y
	LDA.w $0EB1,x
	STA.w $0901,y
	LDA.b $E4
	STA.w $0902,y
	LDA.b #$2D
	STA.w $0903,y
	LDA.b #$02
	STA.w $0D00,y
	LDA.b $E6
	BEQ.b CODE_0DC053
	LDA.b #$03
	STA.w $0D00,y
CODE_0DC053:
	PLY
CODE_0DC054:
	RTS

CODE_0DC055:
	STZ.w $0E9D,x
	TXA
	ASL
	ASL
	ASL
	STA.b $E8
	ASL
	CLC
	ADC.b $E8
	PHX
	TAX
	LDA.b #$F0
	STA.w $0901,x
	STZ.w $0D00,x
	PLX
	RTS

;--------------------------------------------------------------------

CODE_0DC06E:
	STA.w $0E9D,x
	STZ.w $0EA2,x
	LDA.w $021A,x
	STA.w $0EAC,x
	LDA.b $79,x
	STA.w $0EA7,x
	LDA.w $0238,x
	CLC
	ADC.b #$08
	STA.w $0EB1,x
	RTS

;--------------------------------------------------------------------

CODE_0DC089:
	LDA.w $0E7F
	LSR
	BCC.b CODE_0DC0D4
	LDA.w !RAM_SMBLL_Global_ScreenDisplayRegisterMirror
	BMI.b CODE_0DC0CA
	DEC.w !RAM_SMBLL_Global_ScreenDisplayRegisterMirror
	BNE.b CODE_0DC100
	LDA.b #!ScreenDisplayRegister_SetForceBlank|!ScreenDisplayRegister_MinBrightness00
	STA.w !REGISTER_ScreenDisplayRegister
	STA.w !RAM_SMBLL_Global_ScreenDisplayRegisterMirror
	STZ.w !REGISTER_HDMAEnable
	STZ.w !RAM_SMBLL_Global_HDMAEnableMirror
	STZ.w $0B75
	STZ.w $1680
if !Define_Global_ROMToAssemble&(!ROM_SMBLL_U|!ROM_SMBLL_E|!ROM_SMBLL_J) == $00
	LDA.l !SRAM_SMAS_Global_RunningDemoFlag
	BEQ.b CODE_0DC0C0
	LDA.w $0EC8
	BNE.b CODE_0DC0BC
	JML.l SMAS_CopyOfResetToSMASTitleScreen_Main				; Note: Call to SMAS function

CODE_0DC0BC:
	JML.l SMAS_ResetToSMASTitleScreen_Main				; Note: Call to SMAS function
endif

CODE_0DC0C0:
	JSL.l CODE_048000				; Note: Call to SMB1 function
	JSR.w CODE_0DC124
	JSR.w CODE_0DC14F
CODE_0DC0CA:
	STZ.w $0E7F
	LDA.b #$01
	STA.w $0774
	BRA.b CODE_0DC100

CODE_0DC0D4:
	LDA.w $0E66
	BNE.b CODE_0DC0E4
	LDA.b $0E
	BNE.b CODE_0DC0E4
	LDA.b #$01
	STA.b $0E
	JSR.w CODE_0DAB99
CODE_0DC0E4:
	STZ.w $0E67
	LDA.w !RAM_SMBLL_Global_ScreenDisplayRegisterMirror
	CMP.b #$0F
	BEQ.b CODE_0DC0F8
	INC.w !RAM_SMBLL_Global_ScreenDisplayRegisterMirror
	LDA.w !RAM_SMBLL_Global_ScreenDisplayRegisterMirror
	CMP.b #$0F
	BNE.b CODE_0DC100
CODE_0DC0F8:
	STZ.w $0E7F
	STZ.w $0774
	STZ.b $0E
CODE_0DC100:
	LDA.w $0E4F
	BEQ.b CODE_0DC123
	JSR.w CODE_0DC124
	LDA.w !RAM_SMBLL_Global_ScreenDisplayRegisterMirror
	EOR.b #$0F
	ASL
	ASL
	ASL
	ASL
	ORA.b #$0F
	STA.w $0E7E
	JSR.w CODE_0DC13D
	LDA.w !RAM_SMBLL_Global_ScreenDisplayRegisterMirror
	CMP.b #$0F
	BNE.b CODE_0DC123
	STZ.w $0E4F
CODE_0DC123:
	RTS

;--------------------------------------------------------------------

CODE_0DC124:
	PHX
	LDX.b #$00
	LDA.b #$F0
CODE_0DC129:
	STA.w $0801,x
	STA.w $0901,x
	STZ.w $0C00,x
	STZ.w $0D00,x
	INX
	INX
	INX
	INX
	BNE.b CODE_0DC129
	PLX
	RTS

;--------------------------------------------------------------------

CODE_0DC13D:
	PHY
	LDY.b #$D0
	LDA.b #$F0
CODE_0DC142:
	STA.w $0801,y
	INY
	INY
	INY
	INY
	CPY.b #$F0
	BNE.b CODE_0DC142
	PLY
	RTS

;--------------------------------------------------------------------

CODE_0DC14F:
	JSL.l CODE_00D52E
	STZ.w $0BA5
	STZ.w $0F06
	STZ.w $0EC4
	LDA.w $075F
	CMP.b #$07
	BEQ.b CODE_0DC167
	CMP.b #$0C
	BNE.b CODE_0DC16C
CODE_0DC167:
	LDA.b #$01
	STA.w $0EC4
CODE_0DC16C:
	STZ.w $0ED1
	STZ.w $0E40
	STZ.w $0E41
	STZ.w $0E42
	STZ.w $0EDC
	STZ.w $0ECF
	LDA.b #$01
	STA.w $0ECE
	LDA.w $0E66
	BNE.b CODE_0DC196
	LDA.w $0237
	STA.w $03B8
	LDA.w $0219
	STA.w $03AD
	BRA.b CODE_0DC199

CODE_0DC196:
	STZ.w $0E66
CODE_0DC199:
	STZ.b $0E
	RTS

;--------------------------------------------------------------------

DATA_0DC19C:
	dw $0000,$7FFF,$0C63,$0155,$1A1C,$1B3E,$2D9C,$3ABF,$0000,$152F,$0014,$0C19,$1C9F,$762E,$5D68,$44E6
	dw $45BC,$14A5,$7FFF,$023F,$01DB,$0136,$3ABF,$2D9C,$0000,$5B3F,$6976,$50F0,$3C8B,$0136,$01DB,$023F
	dw $45BC,$7FFF,$14A5,$0092,$0098,$009F,$2D9C,$3ABF,$0000,$152F,$2C95,$413A,$55DF,$031F,$027A,$01D5
	dw $45BC,$14A5,$7FFF,$55DF,$413A,$2C95,$3ABF,$2D9C,$0000,$5B3F,$217F,$14D9,$0453,$0200,$02E0,$03E0
	dw $0000,$7FFF,$0C63,$0155,$1A1C,$1B3E,$2D9C,$3ABF,$0000,$152F,$1E60,$3304,$4388,$7655,$7190,$58CA

if !Define_Global_ROMToAssemble&(!ROM_SMBLL_U|!ROM_SMBLL_E|!ROM_SMBLL_J) != $00
elseif !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E) != $00
	%FREE_BYTES(NULLROM, 14, $FF)
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
	%FREE_BYTES(NULLROM, 21, $FF)
else
	%FREE_BYTES(NULLROM, 20, $FF)
endif

;--------------------------------------------------------------------

CODE_0DC250:
	BIT.b $10,x
	BMI.b CODE_0DC267
	LDA.b $10,x
	BEQ.b CODE_0DC25B
	JMP.w CODE_0DCBB0

CODE_0DC25B:
	LDA.w $071F
	AND.b #$07
	CMP.b #$07
	BEQ.b CODE_0DC273
	JMP.w CODE_0DC2E9

CODE_0DC267:
	LDA.b $10,x
	AND.b #$0F
	TAY
	LDA.w $0010,y
	BNE.b CODE_0DC273
	STA.b $10,x
CODE_0DC273:
	RTS

;--------------------------------------------------------------------

DATA_0DC274:
	db $02,$02,$02,$02,$05,$05,$05,$05
	db $06,$07,$07,$04

DATA_0DC280:
	db $03,$05,$08,$09,$03,$06,$07,$0A
	db $05,$05,$0B,$05

DATA_0DC28C:
	db $B0,$B0,$40,$30,$B0,$30,$B0,$B0
	db $F0,$F0,$B0,$F0

DATA_0DC298:
	db $02,$02,$02,$02,$02,$02,$02,$02
	db $01,$01,$01,$01

;--------------------------------------------------------------------

CODE_0DC2A4:
	LDA.b $78
	SEC
	SBC.b #$04
	STA.b $78
	LDA.w $0725
	SEC
	SBC.b #$04
	STA.w $0725
	LDA.w $071A
	SEC
	SBC.b #$04
	STA.w $071A
	LDA.w $071B
	SEC
	SBC.b #$04
	STA.w $071B
	LDA.w $072A
	SEC
	SBC.b #$04
	STA.w $072A
	STZ.w $073B
	STZ.w $072B
	STZ.w $0739
	STZ.w $073A
	PHX
	TYX
	LDA.l DATA_0EC4E0,x
	STA.w $072C
	STZ.w $0EDB
	PLX
	RTS

;--------------------------------------------------------------------

CODE_0DC2E9:
	LDA.w $0745
	BEQ.b CODE_0DC354
	LDA.w $0726
	BNE.b CODE_0DC354
	LDY.b #$0C
CODE_0DC2F5:
	DEY
	BMI.b CODE_0DC354
	LDA.w $075F
	CMP.w DATA_0DC274,y
	BNE.b CODE_0DC2F5
	LDA.w $0725
	CMP.w DATA_0DC280,y
	BNE.b CODE_0DC2F5
	LDA.w $0237
	CMP.w DATA_0DC28C,y
	BNE.b CODE_0DC325
	LDA.b $28
	CMP.b #$00
	BNE.b CODE_0DC325
	INC.w $06D9
	LDA.w $0EDB
	BNE.b CODE_0DC332
	LDA.b #!Define_SMAS_Sound0063_Correct
	STA.w !RAM_SMBLL_Global_SoundCh3
	BRA.b CODE_0DC332

CODE_0DC325:
	LDA.w $0EDB
	BNE.b CODE_0DC332
	LDA.b #!Define_SMAS_Sound0063_Wrong
	STA.w !RAM_SMBLL_Global_SoundCh3
	STA.w $0EDB
CODE_0DC332:
	INC.w $06DA
	LDA.w $06DA
	CMP.w DATA_0DC298,y
	BNE.b CODE_0DC351
	LDA.w $06D9
	CMP.w DATA_0DC298,y
	BEQ.b CODE_0DC34B
	JSR.w CODE_0DC2A4
	JSR.w CODE_0DD462
CODE_0DC34B:
	STZ.w $06DA
	STZ.w $06D9
CODE_0DC351:
	STZ.w $0745
CODE_0DC354:
	LDA.w $06CD
	BEQ.b CODE_0DC367
	STA.b !RAM_SMBLL_NorSpr_SpriteID,x
	LDA.b #$01
	STA.b $10,x
	STZ.b $29,x
	STZ.w $06CD
	JMP.w CODE_0DC461

CODE_0DC367:
	LDY.w $0739
	LDA.b [$FD],y
	CMP.b #$FF
	BNE.b CODE_0DC373
	JMP.w CODE_0DC44D

CODE_0DC373:
	AND.b #$0F
	CMP.b #$0E
	BEQ.b CODE_0DC387
	CPX.b #$05
	BCC.b CODE_0DC387
	INY
	LDA.b [$FD],y
	AND.b #$3F
	CMP.b #$2E
	BEQ.b CODE_0DC387
	RTS

CODE_0DC387:
	LDA.w $071D
	CLC
	ADC.b #$30
	AND.b #$F0
	STA.b $07
	LDA.w $071B
	ADC.b #$00
	STA.b $06
	LDY.w $0739
	INY
	LDA.b [$FD],y
	ASL
	BCC.b CODE_0DC3AC
	LDA.w $073B
	BNE.b CODE_0DC3AC
	INC.w $073B
	INC.w $073A
CODE_0DC3AC:
	DEY
	LDA.b [$FD],y
	AND.b #$0F
	CMP.b #$0F
	BNE.b CODE_0DC3CE
	LDA.w $073B
	BNE.b CODE_0DC3CE
	INY
	LDA.b [$FD],y
	AND.b #$3F
	STA.w $073A
	INC.w $0739
	INC.w $0739
	INC.w $073B
	JMP.w CODE_0DC2E9

CODE_0DC3CE:
	LDA.w $073A
	STA.b $79,x
	LDA.b [$FD],y
	AND.b #$F0
	STA.w $021A,x
	CMP.w $071D
	LDA.b $79,x
	SBC.w $071B
	BCS.b CODE_0DC3EF
	LDA.b [$FD],y
	AND.b #$0F
	CMP.b #$0E
	BEQ.b CODE_0DC46A
	JMP.w CODE_0DC48D

CODE_0DC3EF:
	LDA.b $07
	CMP.w $021A,x
	LDA.b $06
	SBC.b $79,x
	BCC.b CODE_0DC44D
	LDA.b #$01
	STA.b $BC,x
	LDA.b [$FD],y
	ASL
	ASL
	ASL
	ASL
	STA.w $0238,x
	CMP.b #$E0
	BEQ.b CODE_0DC46A
	INY
	LDA.b [$FD],y
	AND.b #$40
	BEQ.b CODE_0DC41A
	LDA.w $06CC
	BNE.b CODE_0DC41A
	JMP.w CODE_0DC49B

CODE_0DC41A:
	LDA.b [$FD],y
	AND.b #$3F
	CMP.b #$37
	BCC.b CODE_0DC426
	CMP.b #$3F
	BCC.b CODE_0DC467
CODE_0DC426:
	CMP.b #$06
	BNE.b CODE_0DC431
	LDY.w $076A
	BEQ.b CODE_0DC431
	LDA.b #$02
CODE_0DC431:
	CMP.b #$2D
	BNE.b CODE_0DC438
	JSR.w CODE_0DDB63
CODE_0DC438:
	CMP.b #$35
	BNE.b CODE_0DC43F
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMBLL_J) != $00
	JSL.l CODE_00C05A
else
	STZ.w $0F4A
endif
CODE_0DC43F:
	STA.b !RAM_SMBLL_NorSpr_SpriteID,x
	LDA.b #$01
	STA.b $10,x
	JSR.w CODE_0DC461
	LDA.b $10,x
	BNE.b CODE_0DC49B
	RTS

CODE_0DC44D:
	LDA.w $06CB
	BNE.b CODE_0DC45B
	LDA.w $0398
	CMP.b #$01
	BNE.b CODE_0DC466
	LDA.b #$00
CODE_0DC45B:
	CPX.b #$09
	BEQ.b CODE_0DC461
	STA.b !RAM_SMBLL_NorSpr_SpriteID,x
CODE_0DC461:
	STZ.b $29,x
	JSR.w CODE_0DC4B9
CODE_0DC466:
	RTS

CODE_0DC467:
	JMP.w CODE_0DCA0B

CODE_0DC46A:
	INY
	INY
	LDA.w $075F
	CMP.b #$08
	BEQ.b CODE_0DC47D
	LDA.b [$FD],y
	JSR.w CODE_0DC4A7
	CMP.w $075F
	BNE.b CODE_0DC48B
CODE_0DC47D:
	DEY
	LDA.b [$FD],y
	STA.w $0750
	INY
	LDA.b [$FD],y
	AND.b #$1F
	STA.w $0751
CODE_0DC48B:
	BRA.b CODE_0DC498

CODE_0DC48D:
	LDY.w $0739
	LDA.b [$FD],y
	AND.b #$0F
	CMP.b #$0E
	BNE.b CODE_0DC49B
CODE_0DC498:
	INC.w $0739
CODE_0DC49B:
	INC.w $0739
	INC.w $0739
	STZ.w $073B
	LDX.b $9E
	RTS

CODE_0DC4A7:
	LSR
	LSR
	LSR
	LSR
	LSR
	PHA
	LDA.w $07FB
	BEQ.b CODE_0DC4B7
	PLA
	CLC
	ADC.b #$09
	PHA
CODE_0DC4B7:
	PLA
	RTS

CODE_0DC4B9:
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$15
	BCS.b CODE_0DC4CE
	TAY
	LDA.w $0238,x
	ADC.b #$08
	STA.w $0238,x
	LDA.b #$01
	STA.w $03D9,x
	TYA
CODE_0DC4CE:
	ASL
	TAY
	LDA.w DATA_0DC4DD,y
	STA.b $04
	LDA.w DATA_0DC4DD+$01,y
	STA.b $05
	JMP.w ($0004)

DATA_0DC4DD:
	dw CODE_0DC587
	dw CODE_0DC587
	dw CODE_0DC587
	dw CODE_0DC597
	dw CODE_0DCA79
	dw CODE_0DC5A1
	dw CODE_0DC54C
	dw CODE_0DC5C0
	dw CODE_0DC5E7
	dw CODE_0DC54B
	dw CODE_0DC5F1
	dw CODE_0DC5F1
	dw CODE_0DC552
	dw CODE_0DCA79
	dw CODE_0DCAFE
	dw CODE_0DC5C6
	dw CODE_0DC5BB
	dw CODE_0DC602
	dw CODE_0DCAC3
	dw CODE_0DC54B
	dw CODE_0DCAC3
	dw CODE_0DCAC3
	dw CODE_0DCAC3
	dw CODE_0DCAC3
	dw CODE_0DCAE7
	dw CODE_0DC54B
	dw CODE_0DC54B
	dw CODE_0DC6E7
	dw CODE_0DC6E7
	dw CODE_0DC6E7
	dw CODE_0DC6E7
	dw CODE_0DC6E4
	dw CODE_0DC54B
	dw CODE_0DC54B
	dw CODE_0DC54B
	dw CODE_0DC54B
	dw CODE_0DCB0C
	dw CODE_0DCB40
	dw CODE_0DCB6E
	dw CODE_0DCB74
	dw CODE_0DCB39
	dw CODE_0DCB31
	dw CODE_0DCB39
	dw CODE_0DCB7A
	dw CODE_0DCB86
	dw CODE_0DC7DE
	dw CODE_0DBB67
	dw CODE_0DB7C9
	dw CODE_0DC54B
	dw CODE_0DC54B
	dw CODE_0DC54B
	dw CODE_0DC54B
	dw CODE_0DC54B
	dw CODE_0DC56E
	dw CODE_0DCBAF

;--------------------------------------------------------------------

CODE_0DC54B:
	RTS

;--------------------------------------------------------------------

CODE_0DC54C:
	JSR.w CODE_0DC587
	JMP.w CODE_0DC5C2

;--------------------------------------------------------------------

CODE_0DC552:
	LDA.b #$D0
	STA.w $0238,x
	LDA.b #$01
	STA.b $BC,x
	STA.w $07A2,x
	STZ.b $29,x
	STA.w $0B00,x
	STZ.w $0B09,x
	LDA.b #!Define_SMAS_Sound0063_Podoboo
	STA.w !RAM_SMBLL_Global_SoundCh3
	JMP.w CODE_0DC5C2

;--------------------------------------------------------------------

CODE_0DC56E:
	LDA.w $075F
	CMP.b #$07
	BEQ.b CODE_0DC57F
	CMP.b #$0C
	BEQ.b CODE_0DC57F
	LDA.b #$B8
	STA.w $0238,x
	RTS

CODE_0DC57F:
	LDA.b #$70
	STA.w $0238,x
	RTS

;--------------------------------------------------------------------

DATA_0DC585:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	db $F6,$F1
else
	db $F8,$F4
endif

CODE_0DC587:
	LDY.b #$01
	LDA.w $076A
	BNE.b CODE_0DC58F
	DEY
CODE_0DC58F:
	LDA.w DATA_0DC585,y
CODE_0DC592:
	STA.b $5E,x
	JMP.w CODE_0DC5D8

;--------------------------------------------------------------------

CODE_0DC597:
	JSR.w CODE_0DC587
	LDA.b #$01
	STA.b $29,x
	RTS

;--------------------------------------------------------------------

DATA_0DC59F:
	db $80,$50

CODE_0DC5A1:
	STZ.w $03A2,x
	STZ.b $5E,x
	LDA.w $075F
	CMP.b #$06
	BCS.b CODE_0DC5B6
	LDY.w $06CC
	LDA.w DATA_0DC59F,y
	STA.w $07A2,x
CODE_0DC5B6:
	LDA.b #$0B
	JMP.w CODE_0DC5DA

;--------------------------------------------------------------------

CODE_0DC5BB:
	LDA.b #$00
	JMP.w CODE_0DC592

;--------------------------------------------------------------------

CODE_0DC5C0:
	STZ.b $5E,x
CODE_0DC5C2:
	LDA.b #$09
	BNE.b CODE_0DC5DA

CODE_0DC5C6:
	LDY.b #$30
	LDA.w $0238,x
	STA.w $0402,x
	BPL.b CODE_0DC5D2
	LDY.b #$E0
CODE_0DC5D2:
	TYA
	ADC.w $0238,x
	STA.b $5E,x
CODE_0DC5D8:
	LDA.b #$03
CODE_0DC5DA:
	STA.w $0490,x
	LDA.b #$02
	STA.b $47,x
CODE_0DC5E1:
	STZ.b $A1,x
	STZ.w $043D,x
	RTS

;--------------------------------------------------------------------

CODE_0DC5E7:
	LDA.b #$02
	STA.b $47,x
	LDA.b #$09
	STA.w $0490,x
	RTS

;--------------------------------------------------------------------

CODE_0DC5F1:
	JSR.w CODE_0DC5C2
	LDA.w $07B7,x
	AND.b #$10
	STA.b $5E,x
	LDA.w $0238,x
	STA.w $043D,x
	RTS

;--------------------------------------------------------------------

CODE_0DC602:
	LDA.w $06CB
	BNE.b CODE_0DC610
CODE_0DC607:
	STZ.w $06D1
	JSR.w CODE_0DC5BB
	JMP.w CODE_0DCB06

CODE_0DC610:
	JMP.w CODE_0DCCEA

;--------------------------------------------------------------------

DATA_0DC613:
	db $26,$2C,$32,$38

DATA_0DC617:
	db $20,$22,$24,$26

DATA_0DC61B:
	db $13,$14,$15,$16

CODE_0DC61F:
	LDA.w $079B
	BNE.b CODE_0DC66C
	CPX.b #$09
	BCS.b CODE_0DC66C
	LDA.b #$80
	STA.w $079B
	LDY.b #$08
CODE_0DC62F:
	LDA.w !RAM_SMBLL_NorSpr_SpriteID,y
	CMP.b #$11
	BEQ.b CODE_0DC66D
	DEY
	BPL.b CODE_0DC62F
	INC.w $06D1
	LDA.w $06D1
	CMP.b #$03
	BCC.b CODE_0DC66C
	LDX.b #$08
CODE_0DC645:
	LDA.b $10,x
	BEQ.b CODE_0DC64E
	DEX
	BPL.b CODE_0DC645
	BMI.b CODE_0DC66A

CODE_0DC64E:
	STZ.b $29,x
	LDA.b #$11
	STA.b !RAM_SMBLL_NorSpr_SpriteID,x
	JSR.w CODE_0DC607
	LDA.b #$20
	LDY.w $07FB
	BNE.b CODE_0DC665
	LDY.w $075F
	CPY.b #$06
	BCC.b CODE_0DC667
CODE_0DC665:
	LDA.b #$60
CODE_0DC667:
	JSR.w CODE_0DC8C9
CODE_0DC66A:
	LDX.b $9E
CODE_0DC66C:
	RTS

CODE_0DC66D:
	LDA.w $0237
	CMP.b #$2C
	BCC.b CODE_0DC66C
	LDA.w $0029,y
	BNE.b CODE_0DC66C
	LDA.w $0079,y
	STA.b $79,x
	LDA.w $021A,y
	STA.w $021A,x
	LDA.b #$01
	STA.b $BC,x
	LDA.w $0238,y
	SEC
	SBC.b #$08
	STA.w $0238,x
	LDA.w $07B7,x
	AND.b #$03
	TAY
	LDA.w DATA_0DC613,y
	STA.b $03
	LDA.w DATA_0DC617,y
	STA.b $02
	LDA.w DATA_0DC61B,y
	STA.b $01
	LDX.b $9E
	JSR.w CODE_0DD30E
	LDY.b $5D
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	CPY.b #$0C
else
	CPY.b #$08
endif
	BCS.b CODE_0DC6BF
	TAY
	LDA.w $07B8,x
	AND.b #$03
	BEQ.b CODE_0DC6BE
	TYA
	EOR.b #$FF
	TAY
	INY
CODE_0DC6BE:
	TYA
CODE_0DC6BF:
	JSR.w CODE_0DC5C2
	LDY.b #$02
	STA.b $5E,x
	CMP.b #$00
	BMI.b CODE_0DC6CB
	DEY
CODE_0DC6CB:
	STY.b $47,x
	LDA.b #$FD
	STA.b $A1,x
	LDA.b #$01
	STA.b $10,x
	LDA.b #$05
	STA.b $29,x
CODE_0DC6D9:
	RTS

;--------------------------------------------------------------------

DATA_0DC6DA:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	db $30,$43,$30,$43,$30
else
	db $28,$38,$28,$38,$28
endif

DATA_0DC6DF:
	db $00,$00,$10,$10,$00

CODE_0DC6E4:
	JSR.w CODE_0DC827
CODE_0DC6E7:
	STZ.b $5E,x
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	SEC
	SBC.b #$1B
	TAY
	LDA.w DATA_0DC6DA,y
	STA.w $0388,x
	LDA.w DATA_0DC6DF,y
	STA.w $0203,x
	LDA.w $0238,x
	CLC
	ADC.b #$04
	STA.w $0238,x
	LDA.w $021A,x
	CLC
	ADC.b #$04
	STA.w $021A,x
	LDA.b $79,x
	ADC.b #$00
	STA.b $79,x
	JMP.w CODE_0DCB06

;--------------------------------------------------------------------

DATA_0DC716:
	db $80,$30,$40,$80,$30,$50,$50,$70
	db $20,$40,$80,$A0,$70,$40,$90,$68

DATA_0DC726:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	db $11,$07,$08,$0A,$23,$28,$15,$10
	db $22,$2C,$1F,$1B
else
	db $0E,$05,$06,$0E,$1C,$20,$10,$0C
	db $1E,$22,$18,$14
endif

DATA_0DC732:
	db $10,$60,$20,$48

CODE_0DC736:
	LDA.w $079B
	BNE.b CODE_0DC6D9
	JSR.w CODE_0DC5C2
	LDA.w $07B8,x
	AND.b #$03
	TAY
	LDA.w DATA_0DC732,y
	STA.w $079B
	LDY.b #$03
	LDA.w $06CC
	BEQ.b CODE_0DC752
	INY
CODE_0DC752:
	STY.b $00
	CPX.b $00
	BCC.b CODE_0DC75B
	JMP.w CODE_0DC6D9

CODE_0DC75B:
	LDA.w $07B7,x
	AND.b #$03
	STA.b $00
	STA.b $01
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDA.b #$FA
else
	LDA.b #$FB
endif
	STA.b $A1,x
	LDA.b #$00
	LDY.b $5D
	BEQ.b CODE_0DC775
	LDA.b #$04
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	CPY.b #$1D
else
	CPY.b #$19
endif
	BCC.b CODE_0DC775
	ASL
CODE_0DC775:
	PHA
	CLC
	ADC.b $00
	STA.b $00
	LDA.w $07B8,x
	AND.b #$03
	BEQ.b CODE_0DC789
	LDA.w $07B9,x
	AND.b #$0F
	STA.b $00
CODE_0DC789:
	PLA
	CLC
	ADC.b $01
	TAY
	LDA.w DATA_0DC726,y
	STA.b $5E,x
	LDA.b #$01
	STA.b $47,x
	LDA.b $5D
	BNE.b CODE_0DC7AD
	LDY.b $00
	TYA
	AND.b #$02
	BEQ.b CODE_0DC7AD
	LDA.b $5E,x
	EOR.b #$FF
	CLC
	ADC.b #$01
	STA.b $5E,x
	INC.b $47,x
CODE_0DC7AD:
	TYA
	AND.b #$02
	BEQ.b CODE_0DC7C2
	LDA.w $0219
	CLC
	ADC.w DATA_0DC716,y
	STA.w $021A,x
	LDA.b $78
	ADC.b #$00
	BRA.b CODE_0DC7D0

CODE_0DC7C2:
	LDA.w $0219
	SEC
	SBC.w DATA_0DC716,y
	STA.w $021A,x
	LDA.b $78
	SBC.b #$00
CODE_0DC7D0:
	STA.b $79,x
	LDA.b #$01
	STA.b $10,x
	STA.b $BC,x
	LDA.b #$F8
	STA.w $0238,x
	RTS

;--------------------------------------------------------------------

CODE_0DC7DE:
	LDY.b #$04
CODE_0DC7E0:
	CPY.w $009E
	BEQ.b CODE_0DC7F4
	LDA.w !RAM_SMBLL_NorSpr_SpriteID,y
	CMP.b #$2D
	BNE.b CODE_0DC7F4
	LDA.b #$00
	STA.w !RAM_SMBLL_NorSpr_SpriteID,y
	STA.w $0010,y
CODE_0DC7F4:
	DEY
	BPL.b CODE_0DC7E0
	JSR.w CODE_0DC827
	STX.w $0368
	STZ.w $0363
	STZ.w $0369
	LDA.w $021A,x
	STA.w $0366
	LDA.b #$DF
	STA.w $079C
	STA.b $47,x
	LDA.b #$20
	STA.w $0364
	STA.w $0792,x
	STA.w $0257,x
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	LDA.b #$05
	STA.w $0283
	LSR
	STA.w $0365
	RTS

CODE_0DC827:
	LDY.b #$FF
CODE_0DC829:
	INY
	LDA.w $0010,y
	BNE.b CODE_0DC829
	STY.w $06CF
	TXA
	ORA.b #$80
	STA.w $0010,y
	LDA.b $79,x
	STA.w $0079,y
	LDA.w $021A,x
	STA.w $021A,y
	LDA.b #$01
	STA.b $10,x
	STA.w $00BC,y
	LDA.w $0238,x
	STA.w $0238,y
CODE_0DC850:
	RTS

;--------------------------------------------------------------------

DATA_0DC851:
	db $90,$80,$70,$90

DATA_0DC855:
	db $FF,$01

CODE_0DC857:
	LDA.w $079B
	BNE.b CODE_0DC850
	STA.w $043D,x
	LDA.b #$06
	STA.w $014B
	LDA.b #$18
	STA.w $0F4C
	STX.w $0F4D
	LDY.w $0368
	LDA.w !RAM_SMBLL_NorSpr_SpriteID,y
	CMP.b #$2D
	BEQ.b CODE_0DC8C5
	JSR.w CODE_0DD5EA
	CLC
	ADC.b #$20
	LDY.w $06CC
	BEQ.b CODE_0DC884
	SEC
	SBC.b #$10
CODE_0DC884:
	STA.w $079B
	LDA.w $07B7,x
	AND.b #$03
	STA.w $041D,x
	TAY
	LDA.w DATA_0DC851,y
	STA.w $0238,x
	LDA.w $071D
	CLC
	ADC.b #$20
	STA.w $021A,x
	LDA.w $071B
	ADC.b #$00
	STA.b $79,x
	STZ.w $0F4C
	STZ.w $0F4D
	STZ.w $014B
	LDA.b #!Define_SMAS_Sound0063_FireSpit
	STA.w !RAM_SMBLL_Global_SoundCh3
	LDA.b #$08
	STA.w $0490,x
	LDA.b #$01
	STA.b $BC,x
	STA.b $10,x
	LSR
	STA.w $0402,x
	STA.b $29,x
CODE_0DC8C5:
	STX.w $0F4E
	RTS

;--------------------------------------------------------------------

CODE_0DC8C9:
	STA.w $0238,x
	LDA.w $071D
	CLC
	ADC.b #$20
	STA.w $021A,x
	LDA.w $071B
	ADC.b #$00
	STA.b $79,x
	BRA.b CODE_0DC912

CODE_0DC8DE:
	LDA.w $021A,y
	SEC
	SBC.b #$0E
	STA.w $021A,x
	LDA.w $0079,y
	STA.b $79,x
	LDA.w $0238,y
	CLC
	ADC.b #$08
	STA.w $0238,x
	LDA.w $07B7,x
	AND.b #$03
	STA.w $041D,x
	TAY
	LDA.w DATA_0DC851,y
	LDY.b #$00
	CMP.w $0238,x
	BCC.b CODE_0DC909
	INY
CODE_0DC909:
	LDA.w DATA_0DC855,y
	STA.w $043D,x
	STZ.w $06CB
CODE_0DC912:
	LDA.b #$08
	STA.w $0490,x
	LDA.b #$01
	STA.b $BC,x
	STA.b $10,x
	LSR
	STA.w $0402,x
	STA.b $29,x
	RTS

;--------------------------------------------------------------------

DATA_0DC924:
	db $00,$30,$60,$60,$00,$20

DATA_0DC92A:
	db $60,$40,$70,$40,$60,$30

CODE_0DC930:
	LDA.w $079B
	BNE.b CODE_0DC97E
	LDA.b #$20
	STA.w $079B
	DEC.w $06D7
	LDY.b #$0A
CODE_0DC93F:
	DEY
	LDA.w !RAM_SMBLL_NorSpr_SpriteID,y
	CMP.b #$31
	BNE.b CODE_0DC93F
	LDA.w $021A,y
	SEC
	SBC.b #$30
	PHA
	LDA.w $0079,y
	SBC.b #$00
	STA.b $00
	LDA.w $06D7
	CLC
	ADC.w $0029,y
	TAY
	PLA
	CLC
	ADC.w DATA_0DC924,y
	STA.w $021A,x
	LDA.b $00
	ADC.b #$00
	STA.b $79,x
	LDA.w DATA_0DC92A,y
	STA.w $0238,x
	LDA.b #$01
	STA.b $BC,x
	STA.b $10,x
	LSR
	STA.b $5E,x
	LDA.b #$08
	STA.b $A1,x
CODE_0DC97E:
	RTS

;--------------------------------------------------------------------

DATA_0DC97F:
	db $01,$02,$04,$08,$10,$20,$40,$80

DATA_0DC987:
	db $40,$30,$90,$50,$20,$60,$A0,$70

DATA_0DC98F:
	db $0A,$0B

CODE_0DC991:
	LDA.w $079B
	BNE.b CODE_0DCA01
	LDA.b $5C
	BNE.b CODE_0DC9EE
	CPX.b #$03
	BCS.b CODE_0DCA01
	LDY.b #$00
	LDA.w $07B7,x
	CMP.b #$AA
	BCC.b CODE_0DC9A8
	INY
CODE_0DC9A8:
	LDA.w $075F
	CMP.b #$01
	BEQ.b CODE_0DC9B0
	INY
CODE_0DC9B0:
	TYA
	AND.b #$01
	TAY
	LDA.w DATA_0DC98F,y
CODE_0DC9B7:
	STA.b !RAM_SMBLL_NorSpr_SpriteID,x
	LDA.w $06DD
	CMP.b #$FF
	BNE.b CODE_0DC9C3
	STZ.w $06DD
CODE_0DC9C3:
	LDA.w $07B7,x
	AND.b #$07
CODE_0DC9C8:
	TAY
	LDA.w DATA_0DC97F,y
	BIT.w $06DD
	BEQ.b CODE_0DC9D7
	INY
	TYA
	AND.b #$07
	BRA.b CODE_0DC9C8

CODE_0DC9D7:
	ORA.w $06DD
	STA.w $06DD
	LDA.w DATA_0DC987,y
	JSR.w CODE_0DC8C9
	STA.w $041D,x
	LDA.b #$20
	STA.w $079B
	JMP.w CODE_0DC4B9

CODE_0DC9EE:
	LDY.b #$FF
CODE_0DC9F0:
	INY
	CPY.b #$09
	BCS.b CODE_0DCA02
	LDA.w $0010,y
	BEQ.b CODE_0DC9F0
	LDA.w !RAM_SMBLL_NorSpr_SpriteID,y
	CMP.b #$08
	BNE.b CODE_0DC9F0
CODE_0DCA01:
	RTS

CODE_0DCA02:
	LDA.b #!Define_SMAS_Sound0063_BulletShoot
	STA.w !RAM_SMBLL_Global_SoundCh3
	LDA.b #$08
	BNE.b CODE_0DC9B7

;--------------------------------------------------------------------

CODE_0DCA0B:
	LDY.b #$00
	SEC
	SBC.b #$37
	PHA
	CMP.b #$04
	BCS.b CODE_0DCA20
	PHA
	LDY.b #$06
	LDA.w $076A
	BEQ.b CODE_0DCA1F
	LDY.b #$02
CODE_0DCA1F:
	PLA
CODE_0DCA20:
	STY.b $01
	LDY.b #$B0
	AND.b #$02
	BEQ.b CODE_0DCA2A
	LDY.b #$70
CODE_0DCA2A:
	STY.b $00
	LDA.w $071B
	STA.b $02
	LDA.w $071D
	STA.b $03
	LDY.b #$02
	PLA
	LSR
	BCC.b CODE_0DCA3D
	INY
CODE_0DCA3D:
	STY.w $06D3
CODE_0DCA40:
	LDX.b #$FF
CODE_0DCA42:
	INX
	CPX.b #$09
	BCS.b CODE_0DCA76
	LDA.b $10,x
	BNE.b CODE_0DCA42
	LDA.b $01
	STA.b !RAM_SMBLL_NorSpr_SpriteID,x
	LDA.b $02
	STA.b $79,x
	LDA.b $03
	STA.w $021A,x
	CLC
	ADC.b #$18
	STA.b $03
	LDA.b $02
	ADC.b #$00
	STA.b $02
	LDA.b $00
	STA.w $0238,x
	LDA.b #$01
	STA.b $BC,x
	STA.b $10,x
	JSR.w CODE_0DC4B9
	DEC.w $06D3
	BNE.b CODE_0DCA40
CODE_0DCA76:
	JMP.w CODE_0DC49B

;--------------------------------------------------------------------

CODE_0DCA79:
	LDA.b #$2C
	STA.w $0000
	LDA.b #$13
	STA.w $0001
	STA.w $0F25
	LDA.w $07FB
	BNE.b CODE_0DCAA0
	LDA.w $075F
	CMP.b #$03
	BCS.b CODE_0DCAA0
	DEC.w $0000
	DEC.w $0000
	LDA.b #$21
	STA.w $0001
	STA.w $0F25
CODE_0DCAA0:
	LDA.w $0000
	STA.w $0F24
	LDA.b #$01
	STA.b $5E,x
	LSR
	STA.b $29,x
	STA.w $00A1,x
	LDA.w $0238,x
	STA.w $043D,x
	SEC
	SBC.b #$18
	STA.w $041D,x
	LDA.b #$09
	LDA.b #$0C
	JMP.w CODE_0DCB08

;--------------------------------------------------------------------

CODE_0DCAC3:
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	STA.w $06CB
	SEC
	SBC.b #$12
	ASL
	TAY
	LDA.w DATA_0DCADA,y
	STA.b $04
	LDA.w DATA_0DCADA+$01,y
	STA.b $05
	JMP.w ($0004)

DATA_0DCADA:
	dw CODE_0DC61F
	dw CODE_0DCAE6
	dw CODE_0DC736
	dw CODE_0DC857
	dw CODE_0DC930
	dw CODE_0DC991

;--------------------------------------------------------------------

CODE_0DCAE6:
	RTS

;--------------------------------------------------------------------

CODE_0DCAE7:
	LDY.b #$09
CODE_0DCAE9:
	LDA.w !RAM_SMBLL_NorSpr_SpriteID,y
	CMP.b #$11
	BNE.b CODE_0DCAF5
	LDA.b #$01
	STA.w $0029,y
CODE_0DCAF5:
	DEY
	BPL.b CODE_0DCAE9
	STZ.w $06CB
	STZ.b $10,x
	RTS

;--------------------------------------------------------------------

CODE_0DCAFE:
	LDA.b #$02
	STA.b $47,x
	LDA.b #$F4
	STA.b $5E,x
CODE_0DCB06:
	LDA.b #$03
CODE_0DCB08:
	STA.w $0490,x
	RTS

;--------------------------------------------------------------------

CODE_0DCB0C:
	DEC.w $0238,x
	DEC.w $0238,x
	LDY.w $06CC
	BNE.b CODE_0DCB1C
	LDY.b #$02
	JSR.w CODE_0DCB9E
CODE_0DCB1C:
	LDY.b #$FF
	LDA.w $03A0
	STA.b $29,x
	BPL.b CODE_0DCB26
	TXY
CODE_0DCB26:
	STY.w $03A0
	LDA.b #$00
	STA.b $47,x
	TAY
	JSR.w CODE_0DCB9E
CODE_0DCB31:
	LDA.b #$FF
	STA.w $03A2,x
	JMP.w CODE_0DCB58

CODE_0DCB39:
	LDA.b #$00
	STA.b $5E,x
	JMP.w CODE_0DCB58

CODE_0DCB40:
	LDY.b #$40
	LDA.w $0238,x
	BPL.b CODE_0DCB4E
	EOR.b #$FF
	CLC
	ADC.b #$01
	LDY.b #$C0
CODE_0DCB4E:
	STA.w $0402,x
	TYA
	CLC
	ADC.w $0238,x
	STA.b $5E,x
CODE_0DCB58:
	JSR.w CODE_0DC5E1
CODE_0DCB5B:
	LDA.b #$05
	LDY.b $5C
	CPY.b #$03
	BEQ.b CODE_0DCB6A
	LDY.w $06CC
	BNE.b CODE_0DCB6A
	LDA.b #$06
CODE_0DCB6A:
	STA.w $0490,x
	RTS

;--------------------------------------------------------------------

CODE_0DCB6E:
	JSR.w CODE_0DCB7A
	JMP.w CODE_0DCB77

CODE_0DCB74:
	JSR.w CODE_0DCB86
CODE_0DCB77:
	JMP.w CODE_0DCB5B

CODE_0DCB7A:
	LDA.b #$10
	STA.w $043D,x
	LDA.b #$FF
	STA.b $A1,x
	JMP.w CODE_0DCB8D

CODE_0DCB86:
	LDA.b #$F0
	STA.w $043D,x
	STZ.b $A1,x
CODE_0DCB8D:
	LDY.b #$01
	JSR.w CODE_0DCB9E
	LDA.b #$04
	STA.w $0490,x
	RTS

;--------------------------------------------------------------------

DATA_0DCB98:
	db $08,$0C,$F8

DATA_0DCB9B:
	db $00,$00,$FF

CODE_0DCB9E:
	LDA.w $021A,x
	CLC
	ADC.w DATA_0DCB98,y
	STA.w $021A,x
	LDA.b $79,x
	ADC.w DATA_0DCB9B,y
	STA.b $79,x
CODE_0DCBAF:
	RTS

;--------------------------------------------------------------------

CODE_0DCBB0:
	LDX.b $9E
	LDA.b #$00
	LDY.b !RAM_SMBLL_NorSpr_SpriteID,x
	CPY.b #$15
	BCC.b CODE_0DCBBD
	TYA
	SBC.b #$14
CODE_0DCBBD:
	ASL
	TAY
	LDA.w DATA_0DCBCC,y
	STA.b $04
	LDA.w DATA_0DCBCC+$01,y
	STA.b $05
	JMP.w ($0004)

DATA_0DCBCC:
	dw CODE_0DCC1A
	dw CODE_0DCC7B
	dw CODE_0DD652
	dw CODE_0DCC10
	dw CODE_0DCC10
	dw CODE_0DCC10
	dw CODE_0DCC10
	dw CODE_0DCC8D
	dw CODE_0DCC8D
	dw CODE_0DCC8D
	dw CODE_0DCC8D
	dw CODE_0DCC8D
	dw CODE_0DCC8D
	dw CODE_0DCC8D
	dw CODE_0DCC8D
	dw CODE_0DCC10
	dw CODE_0DCCAB
	dw CODE_0DCCAB
	dw CODE_0DCCAB
	dw CODE_0DCCAB
	dw CODE_0DCCAB
	dw CODE_0DCCAB
	dw CODE_0DCCAB
	dw CODE_0DCC93
	dw CODE_0DCC93
	dw CODE_0DD448
	dw CODE_0DBB8F
	dw CODE_0DB7FB
	dw CODE_0DCC10
	dw CODE_0DD6A0
	dw CODE_0DB744
	dw CODE_0DCC10
	dw CODE_0DB5E8
	dw CODE_0DCC11

;--------------------------------------------------------------------

CODE_0DCC10:
	RTS

;--------------------------------------------------------------------

CODE_0DCC11:
	JSR.w CODE_0DFDE1
	JSR.w CODE_0DFD4F
	JMP.w CODE_0DEE40

;--------------------------------------------------------------------

CODE_0DCC1A:
	LDA.b #$20
	STA.w $0257,x
	JSR.w CODE_0DFDE1
	JSR.w CODE_0DFD4F
	JSR.w CODE_0DEE40
	JSR.w CODE_0DE948
	JSR.w CODE_0DE68D
	JSR.w CODE_0DE003
	JSR.w CODE_0DDD7D
	LDY.w $0747
	BNE.b CODE_0DCC3C
	JSR.w CODE_0DCC3F
CODE_0DCC3C:
	JMP.w CODE_0DDAFC

CODE_0DCC3F:
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	ASL
	TAY
	LDA.w DATA_0DCC50,y
	STA.b $04
	LDA.w DATA_0DCC50+$01,y
	STA.b $05
	JMP.w ($0004)

DATA_0DCC50:
	dw CODE_0DCE10
	dw CODE_0DCE10
	dw CODE_0DCE10
	dw CODE_0DCE10
	dw CODE_0DAB1F
	dw CODE_0DCD6F
	dw CODE_0DCE10
	dw CODE_0DCF25
	dw CODE_0DCFD5
	dw CODE_0DCC7A
	dw CODE_0DCFE9
	dw CODE_0DCFE9
	dw CODE_0DCD22
	dw CODE_0DD780
	dw CODE_0DCE92
	dw CODE_0DCE98
	dw CODE_0DCEC1
	dw CODE_0DD2CE
	dw CODE_0DCE10
	dw CODE_0DCC7A
	dw CODE_0DD289

;--------------------------------------------------------------------

CODE_0DCC7A:
	RTS

;--------------------------------------------------------------------

CODE_0DCC7B:
	JSR.w CODE_0DD5FC
	JSR.w CODE_0DFDE1
	JSR.w CODE_0DFD4F
	JSR.w CODE_0DE948
	JSR.w CODE_0DDD7D
	JMP.w CODE_0DDAFC

;--------------------------------------------------------------------

CODE_0DCC8D:
	JSR.w CODE_0DD0DF
	JMP.w CODE_0DDAFC

;--------------------------------------------------------------------

CODE_0DCC93:
	JSR.w CODE_0DFDE1
	JSR.w CODE_0DFD4F
	JSR.w CODE_0DE951
	JSR.w CODE_0DE16E
	JSR.w CODE_0DFD4F
	JSR.w CODE_0DF5A2
	JSR.w CODE_0DDAD1
	JMP.w CODE_0DDAFC

;--------------------------------------------------------------------

CODE_0DCCAB:
	JSR.w CODE_0DFDE1
	JSR.w CODE_0DFD4F
	JSR.w CODE_0DE980
	JSR.w CODE_0DE137
	LDA.w $0747
	BNE.b CODE_0DCCBF
	JSR.w CODE_0DCCC8
CODE_0DCCBF:
	JSR.w CODE_0DFD4F
	JSR.w CODE_0DEBA6
	JMP.w CODE_0DDAFC

CODE_0DCCC8:
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	SEC
	SBC.b #$24
	ASL
	TAY
	LDA.w DATA_0DCCDC,y
	STA.b $04
	LDA.w DATA_0DCCDC+$01,y
	STA.b $05
	JMP.w ($0004)

DATA_0DCCDC:
	dw CODE_0DD807
	dw CODE_0DDA4C
	dw CODE_0DDACB
	dw CODE_0DDACB
	dw CODE_0DDA82
	dw CODE_0DDAAD
	dw CODE_0DDAB9

;--------------------------------------------------------------------

CODE_0DCCEA:
	STZ.w $07A2,x
CODE_0DCCED:
	CPX.b #$09
	BNE.b CODE_0DCD08
	LDA.b #$F0
	STA.w $09E1
	STA.w $09E5
	STA.w $09E9
	STA.w $09ED
	LDA.b $DB
	CMP.b #$22
	BNE.b CODE_0DCD08
	STZ.w $0743
CODE_0DCD08:
	STZ.b $10,x
	STZ.b !RAM_SMBLL_NorSpr_SpriteID,x
	STZ.b $29,x
	STZ.w $0110,x
	STZ.w $012E,x
	STZ.w $0792,x
	STZ.w $03A2,x
	LDA.b #$20
	STA.w $0257,x
	LDA.b #$00
	RTS

;--------------------------------------------------------------------

CODE_0DCD22:
	LDA.w $07A2,x
	BNE.b CODE_0DCD3D
	JSR.w CODE_0DC552
	LDA.w $07B8,x
	ORA.b #$80
	STA.w $043D,x
	AND.b #$0F
	ORA.b #$06
	STA.w $07A2,x
	LDA.b #$F9
	STA.b $A1,x
CODE_0DCD3D:
	LDA.w $00A1,x
	BMI.b CODE_0DCD5B
	LDA.w $0238,x
	CMP.b #$C0
	BCC.b CODE_0DCD5B
	LDA.w $0B00,x
	CMP.b #$02
	BNE.b CODE_0DCD5B
	INC.w $0B00,x
	STZ.w $0B09,x
	LDA.b #!Define_SMAS_Sound0063_Podoboo
	STA.w !RAM_SMBLL_Global_SoundCh3
CODE_0DCD5B:
	INC.w $0B09,x
	JSL.l CODE_0FE40F
	JMP.w CODE_0DBF33

;--------------------------------------------------------------------

DATA_0DCD65:
	db $30,$1C

DATA_0DCD67:
	db $00,$E8,$00,$18

DATA_0DCD6B:
	db $08,$F8,$0C,$F4

CODE_0DCD6F:
	LDA.b $29,x
	AND.b #$20
	BEQ.b CODE_0DCD78
	JMP.w CODE_0DCE7E

CODE_0DCD78:
	LDA.w $020F,x
	BEQ.b CODE_0DCDAB
	DEC.w $020F,x
	LDA.w $03D1
	AND.b #$0C
	BNE.b CODE_0DCDF1
	LDA.w $03A2,x
	BNE.b CODE_0DCDA3
	LDY.w $06CC
	LDA.w DATA_0DCD65,y
	STA.w $03A2,x
	JSR.w CODE_0DB961
	BCC.b CODE_0DCDA3
	LDA.b $29,x
	ORA.b #$08
	STA.b $29,x
	JMP.w CODE_0DCDF1

CODE_0DCDA3:
	DEC.w $03A2,x
	JMP.w CODE_0DCDF1

;--------------------------------------------------------------------

DATA_0DCDA9:
	db $20,$37

CODE_0DCDAB:
	LDA.b $29,x
	AND.b #$07
	CMP.b #$01
	BEQ.b CODE_0DCDF1
	STZ.b $00
	LDY.b #$FA
	LDA.w $0238,x
	BMI.b CODE_0DCDCF
	LDY.b #$FD
	CMP.b #$70
	INC.b $00
	BCC.b CODE_0DCDCF
	DEC.b $00
	LDA.w $07B8,x
	AND.b #$01
	BNE.b CODE_0DCDCF
	LDY.b #$FA
CODE_0DCDCF:
	STY.b $A1,x
	LDA.b $29,x
	ORA.b #$01
	STA.b $29,x
	LDA.b $00
	AND.w $07B9,x
	TAY
	LDA.w $06CC
	BNE.b CODE_0DCDE3
	TAY
CODE_0DCDE3:
	LDA.w DATA_0DCDA9,y
	STA.w $0792,x
	LDA.w $07B8,x
	ORA.b #$C0
	STA.w $020F,x
CODE_0DCDF1:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDY.b #$FB
else
	LDY.b #$FC
endif
	LDA.b $09
	AND.b #$40
	BNE.b CODE_0DCDFB
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDY.b #$05
else
	LDY.b #$04
endif
CODE_0DCDFB:
	STY.b $5E,x
	LDY.b #$01
	JSR.w CODE_0DE828
	BMI.b CODE_0DCE0E
	INY
	LDA.w $07A2,x
	BNE.b CODE_0DCE0E
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDA.b #$F6
else
	LDA.b #$F8
endif
	STA.b $5E,x
CODE_0DCE0E:
	STY.b $47,x
CODE_0DCE10:
	LDY.b #$00
	LDA.b $29,x
	AND.b #$40
	BNE.b CODE_0DCE31
	LDA.b $29,x
	ASL
	BCS.b CODE_0DCE4D
	LDA.b $29,x
	AND.b #$20
	BNE.b CODE_0DCE7E
	LDA.b $29,x
	AND.b #$07
	BEQ.b CODE_0DCE4D
	CMP.b #$05
	BEQ.b CODE_0DCE31
	CMP.b #$03
	BCS.b CODE_0DCE61
CODE_0DCE31:
	JSR.w CODE_0DBF06
	LDY.b #$00
	LDA.b $29,x
	CMP.b #$02
	BEQ.b CODE_0DCE48
	AND.b #$40
	BEQ.b CODE_0DCE4D
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$2E
	BEQ.b CODE_0DCE4D
	BNE.b CODE_0DCE4B
CODE_0DCE48:
	JMP.w CODE_0DBEA0

CODE_0DCE4B:
	LDY.b #$01
CODE_0DCE4D:
	LDA.b $5E,x
	PHA
	BPL.b CODE_0DCE54
	INY
	INY
CODE_0DCE54:
	CLC
	ADC.w DATA_0DCD67,y
	STA.b $5E,x
	JSR.w CODE_0DBEA0
	PLA
	STA.b $5E,x
	RTS

CODE_0DCE61:
	LDA.w $07A2,x
	BNE.b CODE_0DCE84
	STA.b $29,x
	LDA.b $09
	AND.b #$01
	TAY
	INY
	STY.b $47,x
	DEY
	LDA.w $076A
	BEQ.b CODE_0DCE78
	INY
	INY
CODE_0DCE78:
	LDA.w DATA_0DCD6B,y
	STA.b $5E,x
	RTS

CODE_0DCE7E:
	JSR.w CODE_0DBF06
	JMP.w CODE_0DBEA0

CODE_0DCE84:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	CMP.b #$0B
else
	CMP.b #$0E
endif
	BNE.b CODE_0DCE91
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$06
	BNE.b CODE_0DCE91
	JSR.w CODE_0DCCEA
CODE_0DCE91:
	RTS

;--------------------------------------------------------------------

CODE_0DCE92:
	JSR.w CODE_0DBF33
	JMP.w CODE_0DBEA0

;--------------------------------------------------------------------

CODE_0DCE98:
	LDA.b $A1,x
	ORA.w $043D,x
	BNE.b CODE_0DCEB4
	STA.w $041D,x
	LDA.w $0238,x
	CMP.w $0402,x
	BCS.b CODE_0DCEB4
	LDA.b $09
	AND.b #$07
	BNE.b CODE_0DCEB3
	INC.w $0238,x
CODE_0DCEB3:
	RTS

CODE_0DCEB4:
	LDA.w $0238,x
	CMP.b $5E,x
	BCC.b CODE_0DCEBE
	JMP.w CODE_0DBF16

CODE_0DCEBE:
	JMP.w CODE_0DBF12

;--------------------------------------------------------------------

CODE_0DCEC1:
	JSR.w CODE_0DCEE3
	JSR.w CODE_0DCF04
	LDY.b #$01
	LDA.b $09
	AND.b #$03
	BNE.b CODE_0DCEE2
	LDA.b $09
	AND.b #$40
	BNE.b CODE_0DCED7
	LDY.b #$FF
CODE_0DCED7:
	STY.b $00
	LDA.w $0238,x
	CLC
	ADC.b $00
	STA.w $0238,x
CODE_0DCEE2:
	RTS

;--------------------------------------------------------------------

CODE_0DCEE3:
	LDA.b #$13
CODE_0DCEE5:
	STA.b $01
	LDA.b $09
	AND.b #$03
	BNE.b CODE_0DCEFA
	LDY.b $5E,x
	LDA.b $A1,x
	LSR
	BCS.b CODE_0DCEFE
	CPY.b $01
	BEQ.b CODE_0DCEFB
	INC.b $5E,x
CODE_0DCEFA:
	RTS

CODE_0DCEFB:
	INC.b $A1,x
	RTS

CODE_0DCEFE:
	TYA
	BEQ.b CODE_0DCEFB
	DEC.b $5E,x
	RTS

;--------------------------------------------------------------------

CODE_0DCF04:
	LDA.b $5E,x
	PHA
	LDY.b #$01
	LDA.b $A1,x
	AND.b #$02
	BNE.b CODE_0DCF18
	LDA.b $5E,x
	EOR.b #$FF
	INC
	STA.b $5E,x
	LDY.b #$02
CODE_0DCF18:
	STY.b $47,x
	JSR.w CODE_0DBEA0
	STA.b $00
	PLA
	STA.b $5E,x
	RTS

;--------------------------------------------------------------------

DATA_0DCF23:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	db $07,$01
else
	db $3F,$03
endif

CODE_0DCF25:
	LDA.b $29,x
	AND.b #$20
	BNE.b CODE_0DCF7E
	LDY.w $06CC
	LDA.w $07B8,x
	AND.w DATA_0DCF23,y
	BNE.b CODE_0DCF48
	TXA
	LSR
	BCC.b CODE_0DCF3E
	LDY.b $46
	BCS.b CODE_0DCF46
CODE_0DCF3E:
	LDY.b #$02
	JSR.w CODE_0DE828
	BPL.b CODE_0DCF46
	DEY
CODE_0DCF46:
	STY.b $47,x
CODE_0DCF48:
	JSR.w CODE_0DCF81
	LDA.w $0238,x
	SEC
	SBC.w $043D,x
	CMP.b #$20
	BCC.b CODE_0DCF59
	STA.w $0238,x
CODE_0DCF59:
	LDY.b $47,x
	DEY
	BNE.b CODE_0DCF6E
	LDA.w $021A,x
	CLC
	ADC.b $5E,x
	STA.w $021A,x
	LDA.b $79,x
	ADC.b #$00
	STA.b $79,x
	RTS

CODE_0DCF6E:
	LDA.w $021A,x
	SEC
	SBC.b $5E,x
	STA.w $021A,x
	LDA.b $79,x
	SBC.b #$00
	STA.b $79,x
	RTS

CODE_0DCF7E:
	JMP.w CODE_0DBF2D

CODE_0DCF81:
	LDA.b $A1,x
	AND.b #$02
	BNE.b CODE_0DCFB8
	LDA.b $09
	AND.b #$07
	PHA
	LDA.b $A1,x
	LSR
	BCS.b CODE_0DCFA3
	PLA
	BNE.b CODE_0DCFA2
	INC.w $043D,x
	LDA.w $043D,x
	STA.b $5E,x
	CMP.b #$02
	BNE.b CODE_0DCFA2
	INC.b $A1,x
CODE_0DCFA2:
	RTS

CODE_0DCFA3:
	PLA
	BNE.b CODE_0DCFB7
	DEC.w $043D,x
	LDA.w $043D,x
	STA.b $5E,x
	BNE.b CODE_0DCFB7
	INC.b $A1,x
	LDA.b #$02
	STA.w $07A2,x
CODE_0DCFB7:
	RTS

CODE_0DCFB8:
	LDA.w $07A2,x
	BEQ.b CODE_0DCFC6
CODE_0DCFBD:
	LDA.b $09
	LSR
	BCS.b CODE_0DCFC5
	INC.w $0238,x
CODE_0DCFC5:
	RTS

CODE_0DCFC6:
	LDA.w $0238,x
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	ADC.b #$0C
else
	ADC.b #$10
endif
	CMP.w $0237
	BCC.b CODE_0DCFBD
	LDA.b #$00
	STA.b $A1,x
	RTS

;--------------------------------------------------------------------

CODE_0DCFD5:
	LDA.b $29,x
	AND.b #$20
	BEQ.b CODE_0DCFDE
	JMP.w CODE_0DBF33

CODE_0DCFDE:
	LDA.b #$E8
	STA.b $5E,x
	JMP.w CODE_0DBEA0

;--------------------------------------------------------------------

DATA_0DCFE5:
	db $40,$80,$04,$04

CODE_0DCFE9:
	LDA.b $29,x
	AND.b #$20
	BEQ.b CODE_0DCFF2
	JMP.w CODE_0DBF2D

CODE_0DCFF2:
	STA.b $03
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	SEC
	SBC.b #$0A
	TAY
	LDA.w DATA_0DCFE5,y
	STA.b $02
	LDA.w $0402,x
	SEC
	SBC.b $02
	STA.w $0402,x
	LDA.w $021A,x
	SBC.b #$00
	STA.w $021A,x
	LDA.b $79,x
	SBC.b #$00
	STA.b $79,x
	LDA.b #$40
	STA.b $02
	CPX.b #$02
	BCC.b CODE_0DD069
	LDA.b $5E,x
	CMP.b #$10
	BCC.b CODE_0DD03B
	LDA.w $041D,x
	CLC
	ADC.b $02
	STA.w $041D,x
	LDA.w $0238,x
	ADC.b $03
	STA.w $0238,x
	LDA.b $BC,x
	ADC.b #$00
	BRA.b CODE_0DD050

CODE_0DD03B:
	LDA.w $041D,x
	SEC
	SBC.b $02
	STA.w $041D,x
	LDA.w $0238,x
	SBC.b $03
	STA.w $0238,x
	LDA.b $BC,x
	SBC.b #$00
CODE_0DD050:
	STA.b $BC,x
	LDY.b #$00
	LDA.w $0238,x
	SEC
	SBC.w $043D,x
	BPL.b CODE_0DD062
	LDY.b #$10
	EOR.b #$FF
	INC
CODE_0DD062:
	CMP.b #$0F
	BCC.b CODE_0DD069
	TYA
	STA.b $5E,x
CODE_0DD069:
	RTS

;--------------------------------------------------------------------

DATA_0DD06A:
	db $00,$01,$03,$04,$05,$06,$07,$07
	db $08,$00,$03,$06,$09,$0B,$0D,$0E
	db $0F,$10,$00,$04,$09,$0D,$10,$13
	db $16,$17,$18,$00,$06,$0C,$12,$16
	db $1A,$1D,$1F,$20,$00,$07,$0F,$16
	db $1C,$21,$25,$27,$28,$00,$09,$12
	db $1B,$21,$27,$2C,$2F,$30,$00,$0B
	db $15,$1F,$27,$2E,$33,$37,$38,$00
	db $0C,$18,$24,$2D,$35,$3B,$3E,$40
	db $00,$0E,$1B,$28,$32,$3B,$42,$46
	db $48,$00,$0F,$1F,$2D,$38,$42,$4A
	db $4E,$50,$00,$11,$22,$31,$3E,$49
	db $51,$56,$58

DATA_0DD0CD:
	db $01,$03,$02,$00

DATA_0DD0D1:
	db $00,$09,$12,$1B,$24,$2D,$36,$3F
	db $48,$51,$5A,$63

DATA_0DD0DD:
	db $0C,$18

CODE_0DD0DF:
	JSR.w CODE_0DFDE1
	LDA.w $03D1
	AND.b #$08
	BNE.b CODE_0DD159
	LDA.w $0747
	BNE.b CODE_0DD0F8
	LDA.w $0388,x
	JSR.w CODE_0DD7E4
	AND.b #$1F
	STA.b $A1,x
CODE_0DD0F8:
	LDA.b $A1,x
	LDY.b !RAM_SMBLL_NorSpr_SpriteID,x
	CPY.b #$1F
	BCC.b CODE_0DD10B
	CMP.b #$08
	BEQ.b CODE_0DD108
	CMP.b #$18
	BNE.b CODE_0DD10B
CODE_0DD108:
	INC
	STA.b $A1,x
CODE_0DD10B:
	STA.b $EF
	JSR.w CODE_0DFD4F
	JSR.w CODE_0DD23C
	LDY.w $0B46,x
	LDA.w $03B9
	STA.w $0901,y
	STA.b $07
	LDA.w $03AE
	STA.w $0900,y
	STA.b $06
	LDA.b #$01
	STA.b $00
	JSR.w CODE_0DD1B5
	LDY.b #$05
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$1F
	BCC.b CODE_0DD137
	LDY.b #$0B
CODE_0DD137:
	STY.b $ED
	STZ.b $00
CODE_0DD13B:
	LDA.b $EF
	JSR.w CODE_0DD23C
	JSR.w CODE_0DD15A
	LDA.b $00
	CMP.b #$04
	BNE.b CODE_0DD151
	LDY.w $06CF
	LDA.w $0B46,y
	STA.b $06
CODE_0DD151:
	INC.b $00
	LDA.b $00
	CMP.b $ED
	BCC.b CODE_0DD13B
CODE_0DD159:
	RTS

CODE_0DD15A:
	LDA.b $03
	STA.b $05
	LDY.b $06
	LDA.b $01
	LSR.b $05
	BCS.b CODE_0DD169
	EOR.b #$FF
	INC
CODE_0DD169:
	CLC
	ADC.w $03AE
	STA.w $0900,y
	STA.b $06
	CMP.w $03AE
	BCS.b CODE_0DD180
	LDA.w $03AE
	SEC
	SBC.b $06
	JMP.w CODE_0DD184

CODE_0DD180:
	SEC
	SBC.w $03AE
CODE_0DD184:
	CMP.b #$59
	BCC.b CODE_0DD18C
	LDA.b #$F8
	BNE.b CODE_0DD1A0

CODE_0DD18C:
	LDA.w $03B9
	CMP.b #$F8
	BEQ.b CODE_0DD1A0
	LDA.b $02
	LSR.b $05
	BCS.b CODE_0DD19C
	EOR.b #$FF
	INC
CODE_0DD19C:
	CLC
	ADC.w $03B9
CODE_0DD1A0:
	STA.w $0901,y
	STA.b $07
	CMP.b #$F0
	BCC.b CODE_0DD1B0
	LDA.b #$01
	STA.w $0D00,y
	BRA.b CODE_0DD1B5

CODE_0DD1B0:
	LDA.b #$00
	STA.w $0D00,y
CODE_0DD1B5:
	JSR.w CODE_0DF47B
	TYA
	PHA
	LDA.w $07AF
	ORA.w $0747
	BNE.b CODE_0DD233
	STA.b $05
	LDY.b $BB
	DEY
	BNE.b CODE_0DD233
	LDY.w $0237
	LDA.w $0754
	BNE.b CODE_0DD1D6
	LDA.w $0714
	BEQ.b CODE_0DD1DF
CODE_0DD1D6:
	INC.b $05
	INC.b $05
	TYA
	CLC
	ADC.b #$18
	TAY
CODE_0DD1DF:
	TYA
CODE_0DD1E0:
	SEC
	SBC.b $07
	BPL.b CODE_0DD1E8
	EOR.b #$FF
	INC
CODE_0DD1E8:
	CMP.b #$08
	BCS.b CODE_0DD206
	LDA.b $06
	CMP.b #$F0
	BCS.b CODE_0DD206
	LDA.w $03AD
	CLC
	ADC.b #$04
	STA.b $04
	SEC
	SBC.b $06
	BPL.b CODE_0DD202
	EOR.b #$FF
	INC
CODE_0DD202:
	CMP.b #$08
	BCC.b CODE_0DD21A
CODE_0DD206:
	LDA.b $05
	CMP.b #$02
	BEQ.b CODE_0DD233
	LDY.b $05
	LDA.w $0237
	CLC
	ADC.w DATA_0DD0DD,y
	INC.b $05
	JMP.w CODE_0DD1E0

CODE_0DD21A:
	LDX.b #$01
	LDA.b $04
	CMP.b $06
	BCS.b CODE_0DD223
	INX
CODE_0DD223:
	TXA
	LDX.b $9E
	STA.b $47,x
	LDX.b #$00
	LDA.b $00
	PHA
	JSR.w CODE_0DDE82
	PLA
	STA.b $00
CODE_0DD233:
	PLA
	CLC
	ADC.b #$04
	STA.b $06
	LDX.b $9E
	RTS

CODE_0DD23C:
	PHA
	AND.b #$0F
	CMP.b #$09
	BCC.b CODE_0DD246
	EOR.b #$0F
	INC
CODE_0DD246:
	STA.b $01
	LDY.b $00
	LDA.w DATA_0DD0D1,y
	CLC
	ADC.b $01
	TAY
	LDA.w DATA_0DD06A,y
	STA.b $01
	PLA
	PHA
	CLC
	ADC.b #$08
	AND.b #$0F
	CMP.b #$09
	BCC.b CODE_0DD264
	EOR.b #$0F
	INC
CODE_0DD264:
	STA.b $02
	LDY.b $00
	LDA.w DATA_0DD0D1,y
	CLC
	ADC.b $02
	TAY
	LDA.w DATA_0DD06A,y
	STA.b $02
	PLA
	LSR
	LSR
	LSR
	TAY
	LDA.w DATA_0DD0CD,y
	STA.b $03
	RTS

;--------------------------------------------------------------------

if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) == $00
DATA_0DD27F:
	db $F8,$A0,$70,$BD,$00

DATA_0DD284:
	db $00,$00,$00,$20,$20
endif

CODE_0DD289:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDY.b #$20
endif
	LDA.b $29,x
	AND.b #$20
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	BNE.b +
	JSR.w CODE_0DBEA0
	LDY.b #$17
+:
	LDA.b #$05
	JMP.w CODE_0DBF37
else
	BEQ.b CODE_0DD297
	LDA.b #$20
	STA.w $0257,x
	JMP.w CODE_0DBF33

CODE_0DD297:
	JSR.w CODE_0DBEA0
	LDY.b #$0D
	LDA.b #$05
	JSR.w CODE_0DBF37
	LDA.w $043D,x
	LSR
	LSR
	LSR
	LSR
	TAY
	LDA.w $0238,x
	SEC
	SBC.w DATA_0DD27F,y
	BPL.b CODE_0DD2B5
	EOR.b #$FF
	INC
CODE_0DD2B5:
	CMP.b #$08
	BCS.b CODE_0DD2C4
	LDA.w $043D,x
	CLC
	ADC.b #$10
	LSR
	LSR
	LSR
	LSR
	TAY
CODE_0DD2C4:
	LDA.w DATA_0DD284,y
	STA.w $0257,x
	RTS
endif

;--------------------------------------------------------------------

DATA_0DD2CB:
	db $15,$30,$40

CODE_0DD2CE:
	LDA.b $29,x
	AND.b #$20
	BEQ.b CODE_0DD2D7
	JMP.w CODE_0DBF06

CODE_0DD2D7:
	LDA.b $29,x
	BEQ.b CODE_0DD2E4
	STZ.b $A1,x
	STZ.w $06CB
	LDA.b #$10
	BNE.b CODE_0DD2F7

CODE_0DD2E4:
	LDA.b #$12
	STA.w $06CB
	LDY.b #$02
CODE_0DD2EB:
	LDA.w DATA_0DD2CB,y
	STA.w $0001,y
	DEY
	BPL.b CODE_0DD2EB
	JSR.w CODE_0DD30E
CODE_0DD2F7:
	STA.b $5E,x
	LDY.b #$01
	LDA.b $A1,x
	AND.b #$01
	BNE.b CODE_0DD309
	LDA.b $5E,x
	EOR.b #$FF
	INC
	STA.b $5E,x
	INY
CODE_0DD309:
	STY.b $47,x
	JMP.w CODE_0DBEA0

CODE_0DD30E:
	LDY.b #$00
	JSR.w CODE_0DE828
	BPL.b CODE_0DD31D
	INY
	LDA.b $00
	EOR.b #$FF
	INC
	STA.b $00
CODE_0DD31D:
	LDA.b $00
	CMP.b #$3C
	BCC.b CODE_0DD33F
	LDA.b #$3C
	STA.b $00
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$11
	BNE.b CODE_0DD33F
	TYA
	CMP.b $A1,x
	BEQ.b CODE_0DD33F
	LDA.b $A1,x
	BEQ.b CODE_0DD33C
	DEC.b $5E,x
	LDA.b $5E,x
	BNE.b CODE_0DD37A
CODE_0DD33C:
	TYA
	STA.b $A1,x
CODE_0DD33F:
	LDA.b $00
	AND.b #$3C
	LSR
	LSR
	STA.b $00
	LDY.b #$00
	LDA.b $5D
	BEQ.b CODE_0DD371
	LDA.w $0775
	BEQ.b CODE_0DD371
	INY
	LDA.b $5D
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	CMP.b #$1D
else
	CMP.b #$19
endif
	BCC.b CODE_0DD361
	LDA.w $0775
	CMP.b #$02
	BCC.b CODE_0DD361
	INY
CODE_0DD361:
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$12
	BNE.b CODE_0DD36B
	LDA.b $5D
	BNE.b CODE_0DD371
CODE_0DD36B:
	LDA.b $A1,x
	BNE.b CODE_0DD371
	LDY.b #$00
CODE_0DD371:
	LDA.w $0001,y
	LDY.b $00
CODE_0DD376:
	DEC
	DEY
	BPL.b CODE_0DD376
CODE_0DD37A:
	RTS

;--------------------------------------------------------------------

DATA_0DD37B:
	db $1A,$58,$98,$96,$94,$92,$90,$8E
	db $8C,$8A,$88,$86,$84,$82,$80

CODE_0DD38A:
	PHX
	LDX.w $0369
	DEX
	DEX
	STX.w $0334
	AND.b #$80
	BEQ.b CODE_0DD3B8
	STZ.w $030D,x
	LDA.b #$01
	STA.w $0300,x
	LDA.b $04
	AND.b #$1F
	ASL
	ASL
	ASL
	STA.b $E4
	LDA.b #$00
	SEC
	SBC.b $42
	CLC
	ADC.b $E4
	STA.w $031A,x
	LDA.b #$03
	STA.w $0327,x
CODE_0DD3B8:
	PLX
	RTS

CODE_0DD3BA:
	LDX.w $0368
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$2D
	BNE.b CODE_0DD3D4
	STX.b $9E
	LDA.b $29,x
	BEQ.b CODE_0DD3ED
	AND.b #$40
	BEQ.b CODE_0DD3D4
	LDA.w $0238,x
	CMP.b #$E0
	BCC.b CODE_0DD3E7
CODE_0DD3D4:
	LDA.w $0095
	BNE.b CODE_0DD3E1
	LDA.b #!Define_SMBLL_LevelMusic_PassedBoss
	STA.w !RAM_SMBLL_Global_MusicCh1
	STA.w $0095
CODE_0DD3E1:
	INC.w $0772
	JMP.w CODE_0DD462

CODE_0DD3E7:
	JSR.w CODE_0DBF2D
	JMP.w CODE_0DD56E

CODE_0DD3ED:
	DEC.w $0364
	BNE.b CODE_0DD441
	LDA.b #$04
	STA.w $0364
	LDA.w $0363
	EOR.b #$01
	STA.w $0363
	LDA.b #$02
	STA.b $05
	LDY.w $0369
	LDA.w DATA_0DD37B,y
	STA.b $04
	JSR.w CODE_0DD38A
	LDY.w $1700
	INY
	LDX.b #$18
	JSR.w CODE_0D90C6
	LDX.b $9E
	JSR.w CODE_0D9085
	LDA.b #!Define_SMAS_Sound0063_CastleCollapse
	STA.w !RAM_SMBLL_Global_SoundCh3
	LDA.w $0369
	BNE.b CODE_0DD430
	LDA.b #$08
	STA.w $014B
	LDA.b #$FF
	STA.w $0F4C
CODE_0DD430:
	INC.w $0369
	LDA.w $0369
	CMP.b #$0F
	BNE.b CODE_0DD441
	JSR.w CODE_0DC5E1
	LDA.b #$40
	STA.b $29,x
CODE_0DD441:
	JMP.w CODE_0DD56E

;--------------------------------------------------------------------

DATA_0DD444:
	db $21,$41,$11,$31

CODE_0DD448:
	LDA.b $29,x
	AND.b #$20
	BEQ.b CODE_0DD470
	LDA.w $0238,x
	CMP.b #$E0
	BCC.b CODE_0DD3E7
	LDA.w $0EC4
	BNE.b CODE_0DD462
	LDA.w $0201
	CMP.b #$02
	BEQ.b CODE_0DD462
	RTS

CODE_0DD462:
	LDX.b #$08
CODE_0DD464:
	JSR.w CODE_0DCCEA
	DEX
	BPL.b CODE_0DD464
	STA.w $06CB
	LDX.b $9E
	RTS

CODE_0DD470:
	STZ.w $06CB
	LDA.w $0747
	BEQ.b CODE_0DD47B
	JMP.w CODE_0DD52B

CODE_0DD47B:
	LDA.w $0363
	BPL.b CODE_0DD483
	JMP.w CODE_0DD500

CODE_0DD483:
	DEC.w $0364
	BNE.b CODE_0DD495
	LDA.b #$20
	STA.w $0364
	LDA.w $0363
	EOR.b #$01
	STA.w $0363
CODE_0DD495:
	LDA.b $09
	AND.b #$0F
	BNE.b CODE_0DD49F
	LDA.b #$02
	STA.b $47,x
CODE_0DD49F:
	LDA.w $0792,x
	BEQ.b CODE_0DD4C1
	JSR.w CODE_0DE828
	BPL.b CODE_0DD4C1
	LDA.b #$01
	STA.b $47,x
	LDA.b #$02
	STA.w $0365
	LDA.b #$20
	STA.w $0792,x
	STA.w $079C
	LDA.w $021A,x
	CMP.b #$B0
	BCS.b CODE_0DD500
CODE_0DD4C1:
	LDA.b $09
	AND.b #$03
	BNE.b CODE_0DD500
	LDA.w $021A,x
	CMP.w $0366
	BNE.b CODE_0DD4DB
	LDA.w $07B7,x
	AND.b #$03
	TAY
	LDA.w DATA_0DD444,y
	STA.w $06DC
CODE_0DD4DB:
	LDA.w $021A,x
	CLC
	ADC.w $0365
	STA.w $021A,x
	LDY.b $47,x
	CPY.b #$01
	BEQ.b CODE_0DD500
	LDY.b #$FF
	SEC
	SBC.w $0366
	BPL.b CODE_0DD4F8
	EOR.b #$FF
	INC
	LDY.b #$01
CODE_0DD4F8:
	CMP.w $06DC
	BCC.b CODE_0DD500
	STY.w $0365
CODE_0DD500:
	LDA.w $0792,x
	BNE.b CODE_0DD52E
	JSR.w CODE_0DBF2D
	LDA.w $075F
	CMP.b #$05
	BCC.b CODE_0DD518
	LDA.b $09
	AND.b #$03
	BNE.b CODE_0DD518
	JSR.w CODE_0DB961
CODE_0DD518:
	LDA.w $0238,x
	CMP.b #$80
	BCC.b CODE_0DD53C
	LDA.w $07B7,x
	AND.b #$03
	TAY
	LDA.w DATA_0DD444,y
	STA.w $0792,x
CODE_0DD52B:
	JMP.w CODE_0DD53C

CODE_0DD52E:
	CMP.b #$01
	BNE.b CODE_0DD53C
	DEC.w $0238,x
	JSR.w CODE_0DC5E1
	LDA.b #$FE
	STA.b $A1,x
CODE_0DD53C:
	LDA.w $075F
	CMP.b #$07
	BEQ.b CODE_0DD547
	CMP.b #$05
	BCS.b CODE_0DD56E
CODE_0DD547:
	LDA.w $079C
	BNE.b CODE_0DD56E
	LDA.b #$20
	STA.w $079C
	LDA.w $0363
	EOR.b #$80
	STA.w $0363
	BMI.b CODE_0DD53C
	JSR.w CODE_0DD5EA
	LDY.w $06CC
	BEQ.b CODE_0DD566
	SEC
	SBC.b #$10
CODE_0DD566:
	STA.w $079C
	LDA.b #$15
	STA.w $06CB
CODE_0DD56E:
	JSR.w CODE_0DD5C5
	LDY.b #$10
	LDA.b $47,x
	LSR
	BCC.b CODE_0DD57A
	LDY.b #$F0
CODE_0DD57A:
	TYA
	CLC
	ADC.w $021A,x
	LDY.w $06CF
	STA.w $021A,y
	LDA.w $0238,x
	CLC
	ADC.b #$08
	STA.w $0238,y
	LDA.b $29,x
	STA.w $0029,y
	LDA.b $47,x
	STA.w $0047,y
	LDA.b $9E
	PHA
	LDX.w $06CF
	STX.b $9E
	LDA.b $97
	BNE.b CODE_0DD5B4
	LDA.w $0EC4
	BEQ.b CODE_0DD5AD
	LDA.b #!Define_SMBLL_LevelMusic_FinalBowserBattle
	BRA.b CODE_0DD5AF

CODE_0DD5AD:
	LDA.b #!Define_SMBLL_LevelMusic_BowserBattle
CODE_0DD5AF:
	STA.w !RAM_SMBLL_Global_MusicCh1
	STA.b $97
CODE_0DD5B4:
	LDA.b #$2D
	STA.b !RAM_SMBLL_NorSpr_SpriteID,x
	LDA.b #$20
	STA.w $0257,x
	PLA
	STA.b $9E
	TAX
	STZ.w $036A
CODE_0DD5C4:
	RTS

CODE_0DD5C5:
	INC.w $036A
	JSR.w CODE_0DCC11
	LDA.b $29,x
	BNE.b CODE_0DD5C4
	LDA.b #$0A
	STA.w $0490,x
	JSR.w CODE_0DE948
	LDA.w $0770
	CMP.b #$02
	BEQ.b CODE_0DD5E1
	JMP.w CODE_0DDD7D

CODE_0DD5E1:
	RTS

;--------------------------------------------------------------------

DATA_0DD5E2:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	db $80,$30,$30,$80,$80,$80,$30,$50
else
	db $BF,$40,$BF,$BF,$BF,$40,$40,$BF
endif

CODE_0DD5EA:
	LDY.w $0367
	INC.w $0367
	LDA.w $0367
	AND.b #$07
	STA.w $0367
	LDA.w DATA_0DD5E2,y
CODE_0DD5FB:
	RTS

;--------------------------------------------------------------------

CODE_0DD5FC:
	CPX.w $0F4D
	BNE.b CODE_0DD60D
	LDA.w $0F4C
	BEQ.b CODE_0DD60D
	LDA.w $014B
	CMP.b #$06
	BEQ.b CODE_0DD651
CODE_0DD60D:
	LDA.w $0747
	BNE.b CODE_0DD646
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDA.b #$70
else
	LDA.b #$40
endif
	LDY.w $06CC
	BEQ.b CODE_0DD61B
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDA.b #$90
else
	LDA.b #$60
endif
CODE_0DD61B:
	STA.b $00
	LDA.w $0402,x
	SEC
	SBC.b $00
	STA.w $0402,x
	LDA.w $021A,x
	SBC.b #$01
	STA.w $021A,x
	LDA.b $79,x
	SBC.b #$00
	STA.b $79,x
	LDY.w $041D,x
	LDA.w $0238,x
	CMP.w DATA_0DC851,y
	BEQ.b CODE_0DD646
	CLC
	ADC.w $043D,x
	STA.w $0238,x
CODE_0DD646:
	JSR.w CODE_0DFD4F
	LDA.b $29,x
	BNE.b CODE_0DD5FB
	JSL.l CODE_0FD3E9
CODE_0DD651:
	RTS

;--------------------------------------------------------------------

CODE_0DD652:
	DEC.b $A1,x
	BNE.b CODE_0DD66D
	LDA.b #$08
	STA.b $A1,x
	INC.b $5E,x
	LDA.b $5E,x
	CMP.b #$01
	BNE.b CODE_0DD669
	LDA.b #!Define_SMAS_Sound0060_LouderFireworksBang
	STA.w !RAM_SMBLL_Global_SoundCh1
	BRA.b CODE_0DD66D

CODE_0DD669:
	CMP.b #$04
	BCS.b CODE_0DD685
CODE_0DD66D:
	JSR.w CODE_0DFD4F
	LDA.w $03B9
	STA.w $03BA
	LDA.w $03AE
	STA.w $03AF
	LDY.w $0B46,x
	LDA.b $5E,x
	JSR.w CODE_0DF538
	RTS

CODE_0DD685:
	STZ.b $10,x
	LDY.w $0B46,x
	LDA.b #$03
	STA.w $0D00,y
	STA.w $0D04,y
	STA.w $0D08,y
	STA.w $0D0C,y
	LDA.b #$05
	STA.w $0149
	JMP.w CODE_0DD70E

;--------------------------------------------------------------------

CODE_0DD6A0:
	STZ.w $06CB
	LDA.w $0746
	CMP.b #$05
	BCS.b CODE_0DD6E9
	JSR.w CODE_0D9693

DATA_0DD6AD:
	dw CODE_0DD6E9
	dw CODE_0DD6B7
	dw CODE_0DD6F4
	dw CODE_0DD71F
	dw CODE_0DD772

;--------------------------------------------------------------------

CODE_0DD6B7:
	LDA.w $07EB
	CMP.w $07DF
	BNE.b CODE_0DD6CF
	AND.b #$01
	BEQ.b CODE_0DD6C9
	LDY.b #$03
	LDA.b #$03
	BNE.b CODE_0DD6D3

CODE_0DD6C9:
	LDY.b #$00
	LDA.b #$06
	BNE.b CODE_0DD6D3

CODE_0DD6CF:
	LDY.b #$00
	LDA.b #$FF
CODE_0DD6D3:
	STA.w $06D7
	STY.b $29,x
	LDA.w !REGISTER_APUPort3
	AND.b #$7F
	CMP.b #!Define_SMAS_Sound0063_AddTimerToScore
	BEQ.b CODE_0DD6E6
	LDA.b #!Define_SMAS_Sound0063_AddTimerToScore
	STA.w !RAM_SMBLL_Global_SoundCh3
CODE_0DD6E6:
	INC.w $0746
CODE_0DD6E9:
	RTS

;--------------------------------------------------------------------

CODE_0DD6EA:
	LDA.b #!Define_SMAS_Sound0063_FinishAddTimerToScore
	STA.w !RAM_SMBLL_Global_SoundCh3
	STA.w $0E1A
	BRA.b CODE_0DD6E6

CODE_0DD6F4:
	LDA.w $07E9
	ORA.w $07EA
	ORA.w $07EB
	BEQ.b CODE_0DD6EA
CODE_0DD6FF:
	LDY.b #$23
	LDA.b #$FF
	STA.w $014A
	JSR.w CODE_0D98AA
	LDA.b #$05
	STA.w $014A
CODE_0DD70E:
	LDY.b #$0B
	JSR.w CODE_0D98AA
	LDA.w $0753
	ASL
	ASL
	ASL
	ASL
	ORA.b #$04
	JMP.w CODE_0DBB30

;--------------------------------------------------------------------

CODE_0DD71F:
	LDA.b #$01
	STA.b $1B
	LDA.w $0238,x
	CMP.b #$72
	BCC.b CODE_0DD72F
	DEC.w $0238,x
	BRA.b CODE_0DD73B

CODE_0DD72F:
	LDA.w $06D7
	BEQ.b CODE_0DD766
	BMI.b CODE_0DD766
	LDA.b #$16
	STA.w $06CB
CODE_0DD73B:
	JSR.w CODE_0DFD4F
	LDY.w $0B46,x
	LDA.w $03B9
	STA.w $0901,y
	LDA.b $09
	AND.b #$18
	LSR
	LSR
	CLC
	ADC.b #$04
	STA.w $0902,y
	LDA.b #$0B
	STA.w $0903,y
	LDA.w $03AE
	STA.w $0900,y
	LDA.b #$02
	STA.w $0D00,y
	LDX.b $9E
	RTS

CODE_0DD766:
	JSR.w CODE_0DD73B
	LDA.b #$06
	STA.w $07A2,x
CODE_0DD76E:
	INC.w $0746
	RTS

;--------------------------------------------------------------------

CODE_0DD772:
	JSR.w CODE_0DD73B
	LDA.w $07A2,x
	BNE.b CODE_0DD77F
	LDA.w $07B1
	BEQ.b CODE_0DD76E
CODE_0DD77F:
	RTS

;--------------------------------------------------------------------

CODE_0DD780:
	LDA.b $29,x
	BNE.b CODE_0DD7DE
	LDA.w $0792,x
	BNE.b CODE_0DD7DE
	LDA.b $A1,x
	BNE.b CODE_0DD7AD
	LDA.b $5E,x
	BMI.b CODE_0DD7A4
	JSR.w CODE_0DE828
	BPL.b CODE_0DD79D
	LDA.b $00
	EOR.b #$FF
	INC
	STA.b $00
CODE_0DD79D:
	LDA.b $00
	CMP.w $0F25
	BCC.b CODE_0DD7DE
CODE_0DD7A4:
	LDA.b $5E,x
	EOR.b #$FF
	INC
	STA.b $5E,x
	INC.b $A1,x
CODE_0DD7AD:
	LDA.w $043D,x
	LDY.b $5E,x
	BPL.b CODE_0DD7B7
	LDA.w $041D,x
CODE_0DD7B7:
	STA.b $00
	LDA.w $0F24
	CMP.b #$2C
	BEQ.b CODE_0DD7C5
	LDA.b $09
	LSR
	BCC.b CODE_0DD7DE
CODE_0DD7C5:
	LDA.w $0747
	BNE.b CODE_0DD7DE
	LDA.w $0238,x
	CLC
	ADC.b $5E,x
	STA.w $0238,x
	CMP.b $00
	BNE.b CODE_0DD7DE
	STZ.b $A1,x
	LDA.b #$40
	STA.w $0792,x
CODE_0DD7DE:
	LDA.b #$00
	STA.w $0257,x
	RTS

;--------------------------------------------------------------------

CODE_0DD7E4:
	STA.b $07
	LDA.w $0203,x
	BNE.b CODE_0DD7F9
	LDY.b #$18
	LDA.b $5E,x
	CLC
	ADC.b $07
	STA.b $5E,x
	LDA.b $A1,x
	ADC.b #$00
	RTS

CODE_0DD7F9:
	LDY.b #$08
	LDA.b $5E,x
	SEC
	SBC.b $07
	STA.b $5E,x
	LDA.b $A1,x
	SBC.b #$00
	RTS

;--------------------------------------------------------------------

CODE_0DD807:
	LDA.b $BC,x
	CMP.b #$03
	BNE.b CODE_0DD810
	JMP.w CODE_0DCCEA

CODE_0DD810:
	LDA.b $29,x
	BPL.b CODE_0DD815
CODE_0DD814:
	RTS

CODE_0DD815:
	TAY
	LDA.w !RAM_SMBLL_NorSpr_SpriteID,y
	CMP.b #$24
	BNE.b CODE_0DD814
	LDA.w $03A2,x
	STA.b $00
	LDA.b $47,x
	BEQ.b CODE_0DD829
	JMP.w CODE_0DDA34

CODE_0DD829:
	LDA.b #$2D
	CMP.w $0238,x
	BCC.b CODE_0DD840
	CPY.b $00
	BEQ.b CODE_0DD83D
	CLC
	ADC.b #$02
	STA.w $0238,x
	JMP.w CODE_0DDA2A

CODE_0DD83D:
	JMP.w CODE_0DDA11

CODE_0DD840:
	CMP.w $0238,y
	BCC.b CODE_0DD852
	CPX.b $00
	BEQ.b CODE_0DD83D
	CLC
	ADC.b #$02
	STA.w $0238,y
	JMP.w CODE_0DDA2A

CODE_0DD852:
	LDA.w $0238,x
	PHA
	LDA.w $03A2,x
	BPL.b CODE_0DD873
	LDA.w $043D,x
	CLC
	ADC.b #$05
	STA.b $00
	LDA.b $A1,x
	ADC.b #$00
	BMI.b CODE_0DD883
	BNE.b CODE_0DD877
	LDA.b $00
	CMP.b #$0B
	BCC.b CODE_0DD87D
	BCS.b CODE_0DD877

CODE_0DD873:
	CMP.b $9E
	BEQ.b CODE_0DD883
CODE_0DD877:
	JSR.w CODE_0DBF5A
	JMP.w CODE_0DD886

CODE_0DD87D:
	JSR.w CODE_0DDA2A
	JMP.w CODE_0DD886

CODE_0DD883:
	JSR.w CODE_0DBF56
CODE_0DD886:
	LDY.b $29,x
	PLA
	SEC
	SBC.w $0238,x
	CLC
	ADC.w $0238,y
	STA.w $0238,y
	LDA.w $03A2,x
	BMI.b CODE_0DD89D
	TAX
	JSR.w CODE_0DE21B
CODE_0DD89D:
	LDY.b $9E
	LDA.w $00A1,y
	ORA.w $043D,y
	BNE.b CODE_0DD8AA
	JMP.w CODE_0DD9B9

CODE_0DD8AA:
	LDA.w $00A1,y
	PHA
	PHA
	PHA
	JSR.w CODE_0DD9BC
	LDA.b $42
	LSR
	LSR
	LSR
	STA.b $F3
	LDA.b $43
	AND.b #$01
	ASL
	ASL
	ORA.b #$20
	STA.b $F4
	LDA.b $F3
	CLC
	ADC.b #$1F
	TAX
	AND.b #$1F
	STA.b $F5
	TXA
	AND.b #$20
	BEQ.b CODE_0DD8D9
	LDA.b $F4
	EOR.b #$04
	STA.b $F6
CODE_0DD8D9:
	REP.b #$30
	LDA.b $00
	AND.w #$241F
	CMP.b $F3
	BCS.b CODE_0DD8EB
	CMP.b $F5
	BCC.b CODE_0DD8EB
	JMP.w CODE_0DD944

CODE_0DD8EB:
	TYA
	AND.w #$00FF
	TAY
	LDX.w $1700
	LDA.b $00
	AND.w #$1FFF
	XBA
	STA.w $1702,x
	LDA.w #$0300
	STA.w $1704,x
	LDA.w $00A1,y
	AND.w #$0080
	BNE.b CODE_0DD92D
	LDA.w $1702,x
	AND.w #$F003
	CMP.w #$A000
	BEQ.b CODE_0DD91A
	CMP.w #$B000
	BNE.b CODE_0DD91F
CODE_0DD91A:
	LDA.w #$185C
	BRA.b CODE_0DD922

CODE_0DD91F:
	LDA.w #$10A2
CODE_0DD922:
	STA.w $1706,x
	LDA.w #$18A3
	STA.w $1708,x
	BRA.b CODE_0DD936

CODE_0DD92D:
	LDA.w #$0024
	STA.w $1706,x
	STA.w $1708,x
CODE_0DD936:
	LDA.w #$FFFF
	STA.w $170A,x
	TXA
	CLC
	ADC.w #$0008
	STA.w $1700
CODE_0DD944:
	SEP.b #$30
	LDA.w $0029,y
	TAY
	PLA
	EOR.b #$FF
	JSR.w CODE_0DD9BC
	REP.b #$30
	LDA.b $00
	AND.w #$241F
	CMP.b $F3
	BCS.b CODE_0DD962
	CMP.b $F5
	BCC.b CODE_0DD962
	JMP.w CODE_0DD9B6

CODE_0DD962:
	LDX.w $1700
	LDA.b $00
	AND.w #$1FFF
	XBA
	STA.w $1702,x
	LDA.w #$0300
	STA.w $1704,x
	PLA
	AND.w #$0080
	BEQ.b CODE_0DD99D
	LDA.w #$10A2
	STA.w $1706,x
	LDA.w $1702,x
	AND.w #$F003
	CMP.w #$A000
	BEQ.b CODE_0DD990
	CMP.w #$B000
	BNE.b CODE_0DD995
CODE_0DD990:
	LDA.w #$183F
	BRA.b CODE_0DD998

CODE_0DD995:
	LDA.w #$18A3
CODE_0DD998:
	STA.w $1708,x
	BRA.b CODE_0DD9A6

CODE_0DD99D:
	LDA.w #$0024
	STA.w $1706,x
	STA.w $1708,x
CODE_0DD9A6:
	LDA.w #$FFFF
	STA.w $170A,x
	TXA
	CLC
	ADC.w #$0008
	STA.w $1700
	BRA.b CODE_0DD9B7

CODE_0DD9B6:
	PLA
CODE_0DD9B7:
	SEP.b #$30
CODE_0DD9B9:
	LDX.b $9E
	RTS

CODE_0DD9BC:
	PHA
	LDA.w $021A,y
	CLC
	ADC.b #$08
	LDX.w $06CC
	BNE.b CODE_0DD9CB
	CLC
	ADC.b #$10
CODE_0DD9CB:
	PHA
	LDA.w $0079,y
	ADC.b #$00
	STA.b $02
	PLA
	AND.b #$F0
	LSR
	LSR
	LSR
	STA.b $00
	LDX.w $0238,y
	PLA
	BPL.b CODE_0DD9E6
	TXA
	CLC
	ADC.b #$08
	TAX
CODE_0DD9E6:
	TXA
	ASL
	ROL
	PHA
	ROL
	AND.b #$03
	ORA.b #$20
	STA.b $01
	LDA.b $02
	AND.b #$01
	ASL
	ASL
	ORA.b $01
	STA.b $01
	PLA
	AND.b #$E0
	CLC
	ADC.b $00
	STA.b $00
	LDA.w $0238,y
	CMP.b #$E8
	BCC.b CODE_0DDA10
	LDA.b $00
	AND.b #$BF
	STA.b $00
CODE_0DDA10:
	RTS

CODE_0DDA11:
	TYX
	JSR.w CODE_0DFDE1
	LDA.b #$06
	JSR.w CODE_0DDFC3
	LDA.w $03AD
	STA.w $011A,x
	LDA.w $0237
	STA.w $0124,x
	LDA.b #$01
	STA.b $47,x
CODE_0DDA2A:
	JSR.w CODE_0DC5E1
	STA.w $00A1,y
	STA.w $043D,y
	RTS

CODE_0DDA34:
	TYA
	PHA
	JSR.w CODE_0DBF0E
	PLA
	TAX
	JSR.w CODE_0DBF0E
	LDX.b $9E
	LDA.w $03A2,x
	BMI.b CODE_0DDA49
	TAX
	JSR.w CODE_0DE21B
CODE_0DDA49:
	LDX.b $9E
	RTS

;--------------------------------------------------------------------

CODE_0DDA4C:
	LDA.b $A1,x
	ORA.w $043D,x
	BNE.b CODE_0DDA69
	STA.w $041D,x
	LDA.w $0238,x
	CMP.w $0402,x
	BCS.b CODE_0DDA69
	LDA.b $09
	AND.b #$07
	BNE.b CODE_0DDA67
	INC.w $0238,x
CODE_0DDA67:
	BRA.b CODE_0DDA79

CODE_0DDA69:
	LDA.w $0238,x
	CMP.b $5E,x
	BCC.b CODE_0DDA76
	JSR.w CODE_0DBF5A
	JMP.w CODE_0DDA79

CODE_0DDA76:
	JSR.w CODE_0DBF56
CODE_0DDA79:
	LDA.w $03A2,x
	BMI.b CODE_0DDA81
	JSR.w CODE_0DE21B
CODE_0DDA81:
	RTS

;--------------------------------------------------------------------

CODE_0DDA82:
	LDA.b #$0E
	JSR.w CODE_0DCEE5
	JSR.w CODE_0DCF04
	LDA.w $03A2,x
	BMI.b CODE_0DDAAC
CODE_0DDA8F:
	LDA.w $0219
	CLC
	ADC.b $00
	STA.w $0219
	LDA.b $78
	LDY.b $00
	BMI.b CODE_0DDAA2
	ADC.b #$00
	BRA.b CODE_0DDAA4

CODE_0DDAA2:
	SBC.b #$00
CODE_0DDAA4:
	STA.b $78
	STY.w $03A1
	JSR.w CODE_0DE21B
CODE_0DDAAC:
	RTS

;--------------------------------------------------------------------

CODE_0DDAAD:
	LDA.w $03A2,x
	BMI.b CODE_0DDAB8
	JSR.w CODE_0DBF29
	JSR.w CODE_0DE21B
CODE_0DDAB8:
	RTS

;--------------------------------------------------------------------

CODE_0DDAB9:
	JSR.w CODE_0DBEA0
	STA.b $00
	LDA.w $03A2,x
	BMI.b CODE_0DDACA
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDA.b #$13
else
	LDA.b #$10
endif
	STA.b $5E,x
	JSR.w CODE_0DDA8F
CODE_0DDACA:
	RTS

;--------------------------------------------------------------------

CODE_0DDACB:
	JSR.w CODE_0DDAD6
	JMP.w CODE_0DDA79

;--------------------------------------------------------------------

CODE_0DDAD1:
	JSR.w CODE_0DDAD6
	BRA.b CODE_0DDAEE

CODE_0DDAD6:
	LDA.w $0747
	BNE.b CODE_0DDAFB
	LDA.w $041D,x
	CLC
	ADC.w $043D,x
	STA.w $041D,x
	LDA.w $0238,x
	ADC.b $A1,x
	STA.w $0238,x
	RTS

CODE_0DDAEE:
	LDA.w $03A2,x
	BEQ.b CODE_0DDAFB
	CMP.b #$FF
	BNE.b CODE_0DDAF8
	RTS

CODE_0DDAF8:
	JSR.w CODE_0DE20C
CODE_0DDAFB:
	RTS

;--------------------------------------------------------------------

CODE_0DDAFC:
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$14
	BEQ.b CODE_0DDB62
	LDA.w $071C
	LDY.b !RAM_SMBLL_NorSpr_SpriteID,x
	CPY.b #$05
	BEQ.b CODE_0DDB13
	CPY.b #$04
	BEQ.b CODE_0DDB13
	CPY.b #$0D
	BNE.b CODE_0DDB15
CODE_0DDB13:
	ADC.b #$38
CODE_0DDB15:
	SBC.b #$48
	STA.b $01
	LDA.w $071A
	SBC.b #$00
	STA.b $00
	LDA.w $071D
	CLC
	ADC.b #$48
	STA.b $03
	LDA.w $071B
	ADC.b #$00
	STA.b $02
	LDA.w $021A,x
	CMP.b $01
	LDA.b $79,x
	SBC.b $00
	BMI.b CODE_0DDB5F
	LDA.w $021A,x
	CMP.b $03
	LDA.b $79,x
	SBC.b $02
	BMI.b CODE_0DDB62
	LDA.b $29,x
	CMP.b #$05
	BEQ.b CODE_0DDB62
	CPY.b #$0D
	BEQ.b CODE_0DDB62
	CPY.b #$04
	BEQ.b CODE_0DDB62
	CPY.b #$30
	BEQ.b CODE_0DDB62
	CPY.b #$31
	BEQ.b CODE_0DDB62
	CPY.b #$32
	BEQ.b CODE_0DDB62
CODE_0DDB5F:
	JSR.w CODE_0DCCEA
CODE_0DDB62:
	RTS

;--------------------------------------------------------------------

CODE_0DDB63:
	LDA.w $0EC4
	BEQ.b CODE_0DDB6E
	INC.w $0201
	STZ.w $0F4C
CODE_0DDB6E:
	LDA.b #$2D
	RTS

if !Define_Global_ROMToAssemble&(!ROM_SMBLL_E) != $00
elseif !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E) != $00
	%FREE_BYTES(NULLROM, 9, $FF)
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMBLL_J) != $00
	%FREE_BYTES(NULLROM, 6, $FF)
else
	%FREE_BYTES(NULLROM, 15, $FF)
endif

;--------------------------------------------------------------------

CODE_0DDB80:
	LDA.b $33,x
	BEQ.b CODE_0DDBDC
	ASL
	BCS.b CODE_0DDBDC
	LDA.b $09
	LSR
	BCS.b CODE_0DDBDC
	TXA
	ASL
	ASL
	CLC
	ADC.b #$2C
	TAY
	LDX.b #$08
CODE_0DDB95:
	STX.b $01
	TYA
	PHA
	LDA.b $29,x
	AND.b #$20
	BNE.b CODE_0DDBD5
	LDA.b $10,x
	BEQ.b CODE_0DDBD5
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$24
	BCC.b CODE_0DDBAD
	CMP.b #$2B
	BCC.b CODE_0DDBD5
CODE_0DDBAD:
	CMP.b #$06
	BNE.b CODE_0DDBB7
	LDA.b $29,x
	CMP.b #$02
	BCS.b CODE_0DDBD5
CODE_0DDBB7:
	LDA.w $03D9,x
	BNE.b CODE_0DDBD5
	STX.b $E4
	TXA
	ASL
	ASL
	CLC
	ADC.b #$04
	TAX
	JSR.w CODE_0DEA35
	LDX.b $9E
	BCC.b CODE_0DDBD5
	LDA.b #$80
	STA.b $33,x
	LDX.b $01
	JSR.w CODE_0DDBEC
CODE_0DDBD5:
	PLA
	TAY
	LDX.b $01
	DEX
	BPL.b CODE_0DDB95
CODE_0DDBDC:
	LDX.b $9E
	RTS

;--------------------------------------------------------------------

DATA_0DDBDF:
	db $06,$00,$02,$12,$11,$07,$05,$2D
	db $2D,$01,$0A,$08,$2D

CODE_0DDBEC:
	JSR.w CODE_0DFD4F
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_J1) != $00
	LDA.b #!Define_SMAS_Sound0060_KickShell
else
	LDA.b #!Define_SMAS_Sound0060_HitHead
endif
	STA.w !RAM_SMBLL_Global_SoundCh1
	LDX.b $01
	LDA.b $10,x
	BPL.b CODE_0DDC05
	AND.b #$0F
	TAX
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$2D
	BEQ.b CODE_0DDC12
	LDX.b $01
CODE_0DDC05:
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$02
	BNE.b CODE_0DDC0E
	JMP.w CODE_0DDCD8

CODE_0DDC0E:
	CMP.b #$2D
	BNE.b CODE_0DDC8C
CODE_0DDC12:
	LDA.b #$08
	STA.w $014B
	LDA.b #$18
	STA.w $0F4C
	DEC.w $0283
	BEQ.b CODE_0DDC36
	LDA.w $0283
	CMP.b #$01
	BEQ.b CODE_0DDC2B
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	JMP.w CODE_0DDCD3
else
	JMP.w CODE_0DDCD8
endif

CODE_0DDC2B:
	STZ.w $03CA
	LDA.b #$01
	STA.w $03CB
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	JMP.w CODE_0DDCD3
else
	JMP.w CODE_0DDCD8
endif

CODE_0DDC36:
	LDA.b #$08
	STA.w $014B
	LDA.b #$FF
	STA.w $0F4C
	JSR.w CODE_0DC5E1
	STA.b $5E,x
	STZ.w $06CB
	LDA.b #$FE
	STA.b $A1,x
	LDY.w $075F
	LDA.w DATA_0DDBDF,y
	STA.b !RAM_SMBLL_NorSpr_SpriteID,x
	STX.w $02FC
	INC.w $02FC
	CMP.b #$2D
	BEQ.b CODE_0DDC7C
	PHX
	LDA.b $DB
	CMP.b #$21
	BEQ.b CODE_0DDC7B
	STX.w $0077
	INC.w $0077
	LDX.b #$08
CODE_0DDC6D:
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	DEX
	BMI.b CODE_0DDC7B
	CMP.b #$2D
	BNE.b CODE_0DDC6D
	INX
	STZ.b $10,x
	STZ.b !RAM_SMBLL_NorSpr_SpriteID,x
CODE_0DDC7B:
	PLX
CODE_0DDC7C:
	LDA.b #$20
	CPY.b #$03
	BCS.b CODE_0DDC84
	ORA.b #$03
CODE_0DDC84:
	STA.b $29,x
	LDX.b $01
	LDA.b #$09
	BNE.b CODE_0DDCCC

CODE_0DDC8C:
	CMP.b #$08
	BEQ.b CODE_0DDCD8
	CMP.b #$0C
	BEQ.b CODE_0DDCD8
	CMP.b #$15
	BCS.b CODE_0DDCD8
CODE_0DDC98:
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$04
	BEQ.b CODE_0DDCA2
	CMP.b #$0D
	BNE.b CODE_0DDCB1
CODE_0DDCA2:
	TAY
	LDA.w $0238,x
	ADC.b #$18
	CPY.b #$04
	BNE.b CODE_0DDCAE
	SBC.b #$31
CODE_0DDCAE:
	STA.w $0238,x
CODE_0DDCB1:
	JSR.w CODE_0DE6E7
	LDA.b $29,x
	AND.b #$1F
	ORA.b #$20
	STA.b $29,x
	LDA.b #$02
	LDY.b !RAM_SMBLL_NorSpr_SpriteID,x
	CPY.b #$05
	BNE.b CODE_0DDCC6
	LDA.b #$06
CODE_0DDCC6:
	CPY.b #$06
	BNE.b CODE_0DDCCC
	LDA.b #$01
CODE_0DDCCC:
	JSR.w CODE_0DDFC3
	CMP.b #!Define_SMAS_Sound0060_KickShell							; Glitch: In the SMB1 version of this code, !RAM_SMBLL_Global_SoundCh1 is loaded into A before this instruction. Was it's removal intended?
	BEQ.b CODE_0DDCD8
CODE_0DDCD3:
	LDA.b #!Define_SMAS_Sound0060_KickShell
	STA.w !RAM_SMBLL_Global_SoundCh1
CODE_0DDCD8:
	RTS

;--------------------------------------------------------------------

CODE_0DDCD9:
	LDA.b $09
	LSR
	BCC.b CODE_0DDD17
	LDA.w $03D0
	ORA.w $0747
	ORA.w $03D6
	BNE.b CODE_0DDD17
	TXA
	ASL
	ASL
	CLC
	ADC.b #$34
	TAY
	JSR.w CODE_0DEA33
	LDX.b $9E
	BCC.b CODE_0DDD12
	LDA.w $06BE,x
	BNE.b CODE_0DDD17
	LDA.b #$01
	STA.w $06BE,x
	LDA.b $6E,x
	EOR.b #$FF
	CLC
	ADC.b #$01
	STA.b $6E,x
	LDA.w $07AF
	BNE.b CODE_0DDD17
	JMP.w CODE_0DDE82

CODE_0DDD12:
	LDA.b #$00
	STA.w $06BE,x
CODE_0DDD17:
	RTS

;--------------------------------------------------------------------

CODE_0DDD18:
	JSR.w CODE_0DCCED
	LDA.w $020C
	CMP.b #$04
	BNE.b CODE_0DDD25
	JMP.w CODE_0DDE82

CODE_0DDD25:
	LDA.b #$06
	JSR.w CODE_0DDF94
	LDA.b #!Define_SMAS_Sound0060_GetPowerup
	STA.w !RAM_SMBLL_Global_SoundCh1
	LDA.w $020C
	CMP.b #$02
	BCC.b CODE_0DDD45
	CMP.b #$03
	BEQ.b CODE_0DDD5F
	LDA.b #$23
	STA.w $07AF
	LDA.b #!Define_SMBLL_LevelMusic_HaveStar
	STA.w !RAM_SMBLL_Global_MusicCh1
	RTS

CODE_0DDD45:
	LDA.w $0756
	BEQ.b CODE_0DDD6A
	CMP.b #$01
	BNE.b CODE_0DDD76
	LDX.b $9E
	LDA.b #$02
	STA.w $0756
	JSL.l CODE_0E98C3
	LDX.b $9E
	LDA.b #$0C
	BRA.b CODE_0DDD71

CODE_0DDD5F:
	LDA.b #$0B
	STA.w $0110,x
	LDA.b #$00						;\ Optimization: STZ.w !RAM_SMBLL_Global_SoundCh1
	STA.w !RAM_SMBLL_Global_SoundCh1			;/
	RTS

CODE_0DDD6A:
	LDA.b #$01
	STA.w $0756
	LDA.b #$09
CODE_0DDD71:
	LDY.b #$00
	JSR.w CODE_0DDEA4
CODE_0DDD76:
	RTS

;--------------------------------------------------------------------

DATA_0DDD77:
	db $18,$E8

DATA_0DDD79:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	db $38,$C8
else
	db $30,$D0
endif

DATA_0DDD7B:
	db $08,$F8

CODE_0DDD7D:
	LDA.b $09
	LSR
	BCS.b CODE_0DDD76
	JSR.w CODE_0DE247
	BCS.b CODE_0DDDBD
	CPX.b #$09
	BNE.b CODE_0DDD94
	LDA.w $03AE
	BPL.b CODE_0DDD94
	CMP.b #$F4
	BCS.b CODE_0DDD99
CODE_0DDD94:
	LDA.w $03D9,x
	BNE.b CODE_0DDDBD
CODE_0DDD99:
	LDA.b $0F
	CMP.b #$08
	BNE.b CODE_0DDDBD
	LDA.b $29,x
	AND.b #$20
	BNE.b CODE_0DDDBD
	LDA.b $29,x
	AND.b #$20
	BNE.b CODE_0DDDBD
	JSR.w CODE_0DE251
	JSR.w CODE_0DEA33
	LDX.b $9E
	BCS.b CODE_0DDDBE
	LDA.w $0481,x
	AND.b #$FE
	STA.w $0481,x
CODE_0DDDBD:
	RTS

CODE_0DDDBE:
	LDY.b !RAM_SMBLL_NorSpr_SpriteID,x
	CPY.b #$2E
	BNE.b CODE_0DDDC7
	JMP.w CODE_0DDD18

CODE_0DDDC7:
	LDA.w $07AF
	BEQ.b CODE_0DDDD2
	JMP.w CODE_0DDC98

DATA_0DDDCF:
	db $0A,$06,$04

CODE_0DDDD2:
	LDA.w $0481,x
	AND.b #$01
	ORA.w $03D9,x
	BNE.b CODE_0DDE49
	LDA.b #$01
	ORA.w $0481,x
	STA.w $0481,x
	CPY.b #$12
	BEQ.b CODE_0DDE4A
	CPY.b #$33
	BEQ.b CODE_0DDE4A
	CPY.b #$0D
	BNE.b CODE_0DDDF3
	JMP.w CODE_0DDE82

CODE_0DDDF3:
	CPY.b #$04
	BNE.b CODE_0DDDFA
	JMP.w CODE_0DDE82

CODE_0DDDFA:
	CPY.b #$0C
	BNE.b CODE_0DDE01
	JMP.w CODE_0DDE82

CODE_0DDE01:
	CPY.b #$15
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	BCC.b +
	JMP.w CODE_0DDE82
+:
else
	BCS.b CODE_0DDE82
endif
	LDA.b $5C
	BEQ.b CODE_0DDE82
	LDA.b $29,x
	ASL
	BCS.b CODE_0DDE4A
	LDA.b $29,x
	AND.b #$07
	CMP.b #$02
	BCC.b CODE_0DDE4A
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$06
	BEQ.b CODE_0DDE49
	LDA.b #!Define_SMAS_Sound0060_KickShell
	STA.w !RAM_SMBLL_Global_SoundCh1
	JSL.l CODE_0FE0AC
	STZ.w $0F40,x
	LDA.b $29,x
	ORA.b #$80
	STA.b $29,x
	JSR.w CODE_0DDF88
	LDA.w DATA_0DDD79,y
	STA.b $5E,x
	LDA.b #$03
	CLC
	ADC.w $0284
	LDY.w $07A2,x
	CPY.b #$03
	BCS.b CODE_0DDE46
	LDA.w DATA_0DDDCF,y
CODE_0DDE46:
	JSR.w CODE_0DDFC3
CODE_0DDE49:
	RTS

CODE_0DDE4A:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDA.w $00A0
	BMI.b CODE_0DDE53
	BEQ.b CODE_0DDE53
else
	LDY.w $00A0
	DEY
	BMI.b CODE_0DDE53
endif
	JMP.w CODE_0DDEDE

CODE_0DDE53:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDA.b #$14
	LDY.w !RAM_SMBLL_NorSpr_SpriteID,x
	CPY.b #$14
	BNE.b +
	LDA.b #$07
+:
	ADC.w $0237
else
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$07
	BCC.b CODE_0DDE64
	LDA.w $0237
	CLC
	ADC.b #$0C
endif
	CMP.w $0238,x
	BCC.b CODE_0DDEDE
CODE_0DDE64:
	LDA.w $079D
	BNE.b CODE_0DDEDE
	LDA.w $07AE
	BNE.b CODE_0DDEB1
	LDA.w $03AD
	CMP.w $03AE
	BCC.b CODE_0DDE79
	JMP.w CODE_0DDF79

CODE_0DDE79:
	LDA.b $47,x
	CMP.b #$01
	BNE.b CODE_0DDE82
	JMP.w CODE_0DDF82

CODE_0DDE82:
	LDA.w $07AE
	ORA.w $07AF
	BNE.b CODE_0DDEB1
CODE_0DDE8A:
	LDX.w $0756
	BEQ.b CODE_0DDEB4
	STA.w $0756
	LDA.b #$08
	STA.w $07AE
	LDA.b #!Define_SMAS_Sound0060_IntoPipe
	STA.w !RAM_SMBLL_Global_SoundCh1
	JSL.l CODE_0E98C3
	LDA.b #$0A
CODE_0DDEA2:
	LDY.b #$01
CODE_0DDEA4:
	STA.b $0F
	STY.b $28
	LDY.b #$FF
	STY.w $0747
	INY
	STY.w $0775
CODE_0DDEB1:
	LDX.b $9E
	RTS

CODE_0DDEB4:
	STX.b $5D
	PHX
	LDA.b #$01
	STA.w $0754
	JSL.l CODE_0E98C3
	PLX
	INX
	LDA.b #!Define_SMAS_Sound0061_TurnOffWind
	TSB.w !RAM_SMBLL_Global_SoundCh2
	LDA.b #!Define_SMBLL_LevelMusic_MarioDied
	STA.w !RAM_SMBLL_Global_MusicCh1
	STA.w $0E67
	STA.w $0723
	LDA.b #$FC
	STA.b $A0
	LDA.b #$0B
	BNE.b CODE_0DDEA2

DATA_0DDEDA:
	db $02,$06,$05,$06

CODE_0DDEDE:
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$12
	BEQ.b CODE_0DDE82
	LDA.b #!Define_SMAS_Sound0060_Contact
	STA.w !RAM_SMBLL_Global_SoundCh1
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	LDY.b #$00
	CMP.b #$14
	BEQ.b CODE_0DDF0C
	CMP.b #$08
	BEQ.b CODE_0DDF0C
	CMP.b #$33
	BEQ.b CODE_0DDF0C
	CMP.b #$0C
	BEQ.b CODE_0DDF0C
	INY
	CMP.b #$05
	BEQ.b CODE_0DDF0C
	INY
	CMP.b #$11
	BEQ.b CODE_0DDF0C
	INY
	CMP.b #$07
	BNE.b CODE_0DDF27
CODE_0DDF0C:
	LDA.w DATA_0DDEDA,y
	JSR.w CODE_0DDFC3
	LDA.b $47,x
	PHA
	JSR.w CODE_0DE706
	PLA
	STA.b $47,x
	LDA.b #$20
	STA.b $29,x
	JSR.w CODE_0DC5E1
	STZ.b $5E,x
	JMP.w CODE_0DDF66

CODE_0DDF27:
	CMP.b #$09
	BCC.b CODE_0DDF49
	JSR.w CODE_0DDF66
	AND.b #$01
	STA.b !RAM_SMBLL_NorSpr_SpriteID,x
	LDA.b #$00
	STA.b $29,x
	LDA.b #$03
	JSR.w CODE_0DDFC3
	JSR.w CODE_0DC5E1
	JSR.w CODE_0DDF88
	LDA.w DATA_0DDD7B,y
	STA.b $5E,x
	RTS

DATA_0DDF47:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	db $0D,$09
else
	db $10,$0B
endif

CODE_0DDF49:
	LDA.b #$04
	STA.b $29,x
	INC.w $0284
	LDA.w $0284
	CLC
	ADC.w $079D
	JSR.w CODE_0DDFC3
	INC.w $079D
	LDY.w $076A
	LDA.w DATA_0DDF47,y
	STA.w $07A2,x
CODE_0DDF66:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDY.b #$F9
else
	LDY.b #$FA
endif
	LDA.w !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$0F
	BEQ.b CODE_0DDF73
	CMP.b #$10
	BNE.b CODE_0DDF75
CODE_0DDF73:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDY.b #$F7
else
	LDY.b #$F8
endif
CODE_0DDF75:
	STY.w $00A0
	RTS

;--------------------------------------------------------------------

CODE_0DDF79:
	LDA.b $47,x
	CMP.b #$01
	BNE.b CODE_0DDF82
	JMP.w CODE_0DDE82

CODE_0DDF82:
	JSR.w CODE_0DE10A
	JMP.w CODE_0DDE82

;--------------------------------------------------------------------

CODE_0DDF88:
	LDY.b #$01
	JSR.w CODE_0DE828
	BPL.b CODE_0DDF90
	INY
CODE_0DDF90:
	STY.b $47,x
	DEY
	RTS

;--------------------------------------------------------------------

CODE_0DDF94:
	STA.w $0110,x
	LDA.b #$30
	STA.w $0138,x
	LDA.w $0238,x
	STA.w $0124,x
	LDA.w $03AE
	STA.w $011A,x
	LDA.w $021A,x
	STA.b $ED
	LDA.b $79,x
	STA.b $EE
	PHX
	TXA
	ASL
	TAX
	REP.b #$20
	LDA.b $ED
	SEC
	SBC.b $42
	STA.w $0E50,x
	SEP.b #$20
	PLX
CODE_0DDFC2:
	RTS

;--------------------------------------------------------------------

CODE_0DDFC3:
	CMP.w $0110,x
	BCS.b CODE_0DDFC9
	RTS

CODE_0DDFC9:
	STA.w $0110,x
	LDA.b #$30
	STA.w $0138,x
	LDA.w $0238,x
	STA.w $0124,x
	PHY
	TXA
	ASL
	TAY
	LDA.w $021A,x
	STA.b $E4
	LDA.b $79,x
	STA.b $E5
	REP.b #$20
	LDA.b $E4
	SEC
	SBC.b $42
	STA.w $0E50,y
	SEP.b #$20
	STA.w $011A,x
	PLY
	RTS

;--------------------------------------------------------------------

DATA_0DDFF5:
	db $80,$40,$20,$10,$08,$04,$02

DATA_0DDFFC:
	db $7F,$BF,$DF,$EF,$F7,$FB,$FD

CODE_0DE003:
	LDA.b $09
	LSR
	BCC.b CODE_0DDFC2
	LDA.b $5C
	BEQ.b CODE_0DDFC2
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$15
	BCS.b CODE_0DE088
	CMP.b #$11
	BEQ.b CODE_0DE088
	CMP.b #$0D
	BEQ.b CODE_0DE088
	CMP.b #$04
	BEQ.b CODE_0DE088
	LDA.w $03D9,x
	BNE.b CODE_0DE088
	JSR.w CODE_0DE251
	DEX
	BMI.b CODE_0DE088
CODE_0DE029:
	STX.b $01
	TYA
	PHA
	LDA.b $10,x
	BEQ.b CODE_0DE081
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$15
	BCS.b CODE_0DE081
	CMP.b #$11
	BEQ.b CODE_0DE081
	CMP.b #$0D
	BEQ.b CODE_0DE081
	CMP.b #$04
	BEQ.b CODE_0DE081
	LDA.w $03D9,x
	BNE.b CODE_0DE081
	TXA
	ASL
	ASL
	CLC
	ADC.b #$04
	TAX
	JSR.w CODE_0DEA35
	LDX.b $9E
	LDY.b $01
	BCC.b CODE_0DE078
	LDA.b $29,x
	ORA.w $0029,y
	AND.b #$80
	BNE.b CODE_0DE072
	LDA.w $0481,y
	AND.w DATA_0DDFF5,x
	BNE.b CODE_0DE081
	LDA.w $0481,y
	ORA.w DATA_0DDFF5,x
	STA.w $0481,y
CODE_0DE072:
	JSR.w CODE_0DE08B
	JMP.w CODE_0DE081

CODE_0DE078:
	LDA.w $0481,y
	AND.w DATA_0DDFFC,x
	STA.w $0481,y
CODE_0DE081:
	PLA
	TAY
	LDX.b $01
	DEX
	BPL.b CODE_0DE029
CODE_0DE088:
	LDX.b $9E
	RTS

CODE_0DE08B:
	LDA.w $0029,y
	ORA.b $29,x
	AND.b #$20
	BNE.b CODE_0DE0CB
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$05
	BNE.b CODE_0DE09C
	STZ.b $29,x
CODE_0DE09C:
	LDA.b $29,x
	CMP.b #$06
	BCC.b CODE_0DE0CC
	LDA.w $0029,y
	ASL
	BCC.b CODE_0DE0B2
	LDA.b #$06
	JSR.w CODE_0DDFC3
	JSR.w CODE_0DDC98
	LDY.b $01
CODE_0DE0B2:
	TYA
	TAX
	JSR.w CODE_0DDC98
	LDX.b $9E
	LDA.w $012E,x
	CLC
	ADC.b #$04
	LDX.b $01
	JSR.w CODE_0DDFC3
	LDX.b $9E
	INC.w $012E,x
	BRA.b CODE_0DE0F3

CODE_0DE0CB:
	RTS

CODE_0DE0CC:
	LDA.w $0029,y
	CMP.b #$06
	BCC.b CODE_0DE103
	LDA.w !RAM_SMBLL_NorSpr_SpriteID,y
	CMP.b #$05
	BEQ.b CODE_0DE0CB
	JSR.w CODE_0DDC98
	JSL.l CODE_0FE0AC
	LDY.b $01
	LDA.w $012E,y
	CLC
	ADC.b #$04
	LDX.b $9E
	JSR.w CODE_0DDFC3
	LDX.b $01
	INC.w $012E,x
CODE_0DE0F3:
	LDA.w $012E,x
	CLC
	ADC.b #!Define_SMAS_Sound0060_Stomp1-$01
	CMP.b #!Define_SMAS_Sound0060_Stomp7+$01
	BCC.b CODE_0DE0FF
	LDA.b #$00
CODE_0DE0FF:
	STA.w !RAM_SMBLL_Global_SoundCh1
	RTS

CODE_0DE103:
	TYA
	TAX
	JSR.w CODE_0DE10A
	LDX.b $9E
CODE_0DE10A:
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$0D
	BEQ.b CODE_0DE136
	CMP.b #$04
	BEQ.b CODE_0DE136
	CMP.b #$11
	BEQ.b CODE_0DE136
	CMP.b #$05
	BEQ.b CODE_0DE136
	CMP.b #$12
	BEQ.b CODE_0DE128
	CMP.b #$0E
	BEQ.b CODE_0DE128
	CMP.b #$07
	BCS.b CODE_0DE136
CODE_0DE128:
	LDA.b $5E,x
	EOR.b #$FF
	TAY
	INY
	STY.b $5E,x
	LDA.b $47,x
	EOR.b #$03
	STA.b $47,x
CODE_0DE136:
	RTS

;--------------------------------------------------------------------

CODE_0DE137:
	LDA.b #$FF
	STA.w $03A2,x
	LDA.w $0747
	BNE.b CODE_0DE16B
	LDA.b $29,x
	BMI.b CODE_0DE16B
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$24
	BNE.b CODE_0DE151
	LDA.b $29,x
	TAX
	JSR.w CODE_0DE151
CODE_0DE151:
	JSR.w CODE_0DE247
	BCS.b CODE_0DE16B
	TXA
	JSR.w CODE_0DE253
	LDA.w $0238,x
	STA.b $00
	TXA
	PHA
	JSR.w CODE_0DEA33
	PLA
	TAX
	BCC.b CODE_0DE16B
	JSR.w CODE_0DE1AF
CODE_0DE16B:
	LDX.b $9E
	RTS

;--------------------------------------------------------------------

CODE_0DE16E:
	LDA.w $0747
	BNE.b CODE_0DE1AA
	STA.w $03A2,x
	JSR.w CODE_0DE247
	BCS.b CODE_0DE1AA
	LDA.b #$02
	STA.b $00
CODE_0DE17F:
	LDX.b $9E
	JSR.w CODE_0DE251
	AND.b #$02
	BNE.b CODE_0DE1AA
	LDA.w $0F9D,y
	CMP.b #$20
	BCC.b CODE_0DE194
	JSR.w CODE_0DEA33
	BCS.b CODE_0DE1AD
CODE_0DE194:
	LDA.w $0F9D,y
	CLC
	ADC.b #$80
	STA.w $0F9D,y
	LDA.w $0F9F,y
	CLC
	ADC.b #$80
	STA.w $0F9F,y
	DEC.b $00
	BNE.b CODE_0DE17F
CODE_0DE1AA:
	LDX.b $9E
	RTS

CODE_0DE1AD:
	LDX.b $9E
CODE_0DE1AF:
	LDA.w $0F9F,y
	SEC
	SBC.w $0F9D
	CMP.b #$04
	BCS.b CODE_0DE1C2
	LDA.b $A0
	BPL.b CODE_0DE1C2
	LDA.b #$01
	STA.b $A0
CODE_0DE1C2:
	LDA.w $0F9F
	SEC
	SBC.w $0F9D,y
	CMP.b #$06
	BCS.b CODE_0DE1E8
	LDA.b $A0
	BMI.b CODE_0DE1E8
	LDA.b $00
	LDY.b !RAM_SMBLL_NorSpr_SpriteID,x
	CPY.b #$2B
	BEQ.b CODE_0DE1DE
	CPY.b #$2C
	BEQ.b CODE_0DE1DE
	TXA
CODE_0DE1DE:
	LDX.b $9E
	STA.w $03A2,x
	LDA.b #$00
	STA.b $28
	RTS

CODE_0DE1E8:
	LDA.b #$01
	STA.b $00
	LDA.w $0F9E
	SEC
	SBC.w $0F9C,y
	CMP.b #$08
	BCC.b CODE_0DE204
	INC.b $00
	LDA.w $0F9E,y
	CLC
	SBC.w $0F9C
	CMP.b #$09
	BCS.b CODE_0DE207
CODE_0DE204:
	JSR.w CODE_0DE614
CODE_0DE207:
	LDX.b $9E
	RTS

;--------------------------------------------------------------------

DATA_0DE20A:
	db $80,$00

CODE_0DE20C:
	TAY
	LDA.w $0238,x
	CLC
	ADC.w DATA_0DE20A-$01,y
	BNE.b CODE_0DE21E
	LDA.b #$02
	STA.b $BB
	RTS

;--------------------------------------------------------------------

CODE_0DE21B:
	LDA.w $0238,x
CODE_0DE21E:
	LDY.b $0F
	CPY.b #$0B
	BEQ.b CODE_0DE246
	LDY.b $BC,x
	CPY.b #$01
	BNE.b CODE_0DE246
	SEC
	SBC.b #$20
	STA.w $0237
	TYA
	SBC.b #$00
	STA.b $BB
	BNE.b CODE_0DE23F
	STZ.w $03A2,x
	LDA.b #$01
	STA.w $0028
CODE_0DE23F:
	LDA.b #$00
	STA.b $A0
	STA.w $043C
CODE_0DE246:
	RTS

;--------------------------------------------------------------------

CODE_0DE247:
	LDA.w $03D0
	AND.b #$F0
	CLC
	BEQ.b CODE_0DE250
	SEC
CODE_0DE250:
	RTS

;--------------------------------------------------------------------

CODE_0DE251:
	LDA.b $9E
CODE_0DE253:
	ASL
	ASL
	CLC
	ADC.b #$04
	TAY
	LDA.w $03D1
	AND.b #$0F
	CMP.b #$0F
	RTS

;--------------------------------------------------------------------

DATA_0DE261:
	db $20,$10

CODE_0DE263:
	LDA.w $0716
	BNE.b CODE_0DE297
	LDA.b $0F
	CMP.b #$0B
	BEQ.b CODE_0DE297
	CMP.b #$04
	BCC.b CODE_0DE297
	LDA.b #$01
	LDY.w $0704
	BNE.b CODE_0DE283
	LDA.b $28
	BEQ.b CODE_0DE281
	CMP.b #$03
	BNE.b CODE_0DE285
CODE_0DE281:
	LDA.b #$02
CODE_0DE283:
	STA.b $28
CODE_0DE285:
	LDA.b $BB
	CMP.b #$01
	BNE.b CODE_0DE297
	LDA.b #$FF
	STA.w $0480
	LDA.w $0237
	CMP.b #$CF
	BCC.b CODE_0DE298
CODE_0DE297:
	RTS

CODE_0DE298:
	LDY.b #$02
	LDA.w $0714
	BNE.b CODE_0DE2AB
	LDA.w $0754
	BNE.b CODE_0DE2AB
	DEY
	LDA.w $0704
	BNE.b CODE_0DE2AB
	DEY
CODE_0DE2AB:
	LDA.w DATA_0DEABB,y
	STA.b $EB
	TAY
	LDX.w $0754
	LDA.w $0714
	BEQ.b CODE_0DE2BA
	INX
CODE_0DE2BA:
	LDA.w $0237
	CMP.w DATA_0DE261,x
	BCC.b CODE_0DE2FA
	LDA.b #$01
	STA.b $E4
	JSR.w CODE_0DEAF7
	BEQ.b CODE_0DE2FA
	JSR.w CODE_0DE66C
	BCS.b CODE_0DE323
	LDY.b $A0
	BPL.b CODE_0DE2FA
	LDY.b $04
	CPY.b #$04
	BCC.b CODE_0DE2FA
	JSR.w CODE_0DE65A
	BCS.b CODE_0DE2ED
	LDY.b $5C
	BEQ.b CODE_0DE2F6
	LDY.w $078C
	BNE.b CODE_0DE2F6
	JSR.w CODE_0DBC49
	BRA.b CODE_0DE2FA

CODE_0DE2ED:
	CMP.b #$2F
	BEQ.b CODE_0DE2F6
	LDA.b #!Define_SMAS_Sound0060_HitHead
	STA.w !RAM_SMBLL_Global_SoundCh1
CODE_0DE2F6:

if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDY.b #$01
	LDA.w $005C
	BNE.b +
	DEY
+:
	STY.w $00A0
else
	LDA.b #$01
	STA.b $A0
endif
CODE_0DE2FA:
	LDY.b $EB
	LDA.w $0237
	CMP.b #$CF
	BCS.b CODE_0DE367
	STZ.b $E4
	JSR.w CODE_0DEAF6
	JSR.w CODE_0DE66C
	BCS.b CODE_0DE323
	PHA
	STZ.b $E4
	JSR.w CODE_0DEAF6
	STA.b $00
	PLA
	STA.b $01
	BNE.b CODE_0DE326
	LDA.b $00
	BEQ.b CODE_0DE367
	JSR.w CODE_0DE66C
	BCC.b CODE_0DE326
CODE_0DE323:
	JMP.w CODE_0DE420

CODE_0DE326:
	JSR.w CODE_0DE665
	BCS.b CODE_0DE367
	LDY.b $A0
	BMI.b CODE_0DE367
	CMP.b #$FE
	BNE.b CODE_0DE336
	JMP.w CODE_0DE429

CODE_0DE336:
	JSR.w CODE_0DE55A
	BEQ.b CODE_0DE367
	LDY.w $070E
	BNE.b CODE_0DE363
	LDY.b $04
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	CPY.b #$06
else
	CPY.b #$05
endif
	BCC.b CODE_0DE34D
	LDA.b $46
	STA.b $00
	JMP.w CODE_0DE614

CODE_0DE34D:
	JSR.w CODE_0DE571
	LDA.b #$F0
	AND.w $0237
	STA.w $0237
	JSR.w CODE_0DE598
	STZ.b $A0
	STZ.w $043C
	STZ.w $0284
CODE_0DE363:
	LDA.b #$00
	STA.b $28
CODE_0DE367:
	LDY.b $EB
	INY
	INY
	LDA.b #$02
	STA.b $00
CODE_0DE36F:
	INY
	STY.b $EB
	LDA.w $0237
	CMP.b #$20
	BCC.b CODE_0DE391
	CMP.b #$E4
	BCS.b CODE_0DE3AA
	STZ.b $E4
	JSR.w CODE_0DEAFB
	BEQ.b CODE_0DE391
	CMP.b #$25
	BEQ.b CODE_0DE391
	CMP.b #$76
	BEQ.b CODE_0DE391
	JSR.w CODE_0DE665
	BCC.b CODE_0DE3AB
CODE_0DE391:
	LDY.b $EB
	INY
	LDA.w $0237
	CMP.b #$08
	BCC.b CODE_0DE3AA
	CMP.b #$D0
	BCS.b CODE_0DE3AA
	STZ.b $E4
	JSR.w CODE_0DEAFB
	BNE.b CODE_0DE3AB
	DEC.b $00
	BNE.b CODE_0DE36F
CODE_0DE3AA:
	RTS

CODE_0DE3AB:
	JSR.w CODE_0DE55A
	BEQ.b CODE_0DE41D
	JSR.w CODE_0DE665
	BCC.b CODE_0DE3B8
	JMP.w CODE_0DE47C

CODE_0DE3B8:
	JSR.w CODE_0DE66C
	BCS.b CODE_0DE420
	JSR.w CODE_0DE58D
	BCC.b CODE_0DE3CA
	LDA.w $070E
	BNE.b CODE_0DE41D
	JMP.w CODE_0DE41A

CODE_0DE3CA:
	LDY.b $28
	CPY.b #$00
	BNE.b CODE_0DE41A
	LDY.w $0202
	DEY
	BNE.b CODE_0DE41A
	CMP.b #$77
	BEQ.b CODE_0DE3DE
	CMP.b #$28
	BNE.b CODE_0DE41A
CODE_0DE3DE:
	LDA.w $0256
	BEQ.b CODE_0DE3F1
	LDY.b $9A
	BNE.b CODE_0DE3F1
	LDY.b #!Define_SMAS_Sound0060_IntoPipe
	STY.w !RAM_SMBLL_Global_SoundCh1
	STY.b $9A
	STZ.w $07AF
CODE_0DE3F1:
	AND.b #$CF
	STA.w $0256
	LDA.w $0219
	AND.b #$0F
	BEQ.b CODE_0DE40B
	LDY.b #$00
	LDA.w $071A
	BEQ.b CODE_0DE405
	INY
CODE_0DE405:
	LDA.w DATA_0DE41E,y
	STA.w $06DE
CODE_0DE40B:
	LDA.b $0F
	CMP.b #$07
	BEQ.b CODE_0DE41D
	CMP.b #$08
	BNE.b CODE_0DE41D
	LDA.b #$02
	STA.b $0F
	RTS

CODE_0DE41A:
	JSR.w CODE_0DE614
CODE_0DE41D:
	RTS

DATA_0DE41E:
	db $34,$34

CODE_0DE420:
	JSR.w CODE_0DE46A
	INC.w $0748
	JMP.w CODE_0DBAFF

CODE_0DE429:
	STZ.w $0772
	LDA.b #$02
	STA.w $0770
	LDA.w !REGISTER_APUPort2
	CMP.b #!Define_SMBLL_LevelMusic_PassedBoss
	BEQ.b CODE_0DE43D
	LDA.b #!Define_SMBLL_LevelMusic_StopMusicCommand
	STA.w !RAM_SMBLL_Global_MusicCh1
CODE_0DE43D:
	LDA.b #$18
	STA.b $5D
	PHX
	LDX.b #$00
CODE_0DE444:
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$2D
	BNE.b CODE_0DE464
	LDA.b $10,x
	CMP.b #$01
	BNE.b CODE_0DE464
	LDA.w $021A,x
	SEC
	SBC.w $073F
	STA.w $03AE
	LDA.w $0238,x
	STA.w $03B9
	JSL.l CODE_0FD73D
CODE_0DE464:
	INX
	CPX.b #$09
	BNE.b CODE_0DE444
	PLX
CODE_0DE46A:
	LDY.b $02
	LDA.b #$00
	STA.b ($06),y
	JMP.w CODE_0D9046

;--------------------------------------------------------------------

DATA_0DE473:
	db $F9,$07

DATA_0DE475:
	db $FF,$00

DATA_0DE477:
	db $18,$22,$50,$68,$90

CODE_0DE47C:
	LDY.b $04
	CPY.b #$06
	BCC.b CODE_0DE486
	CPY.b #$0A
	BCC.b CODE_0DE487
CODE_0DE486:
	RTS

CODE_0DE487:
	CMP.b #$2D
	BEQ.b CODE_0DE48F
	CMP.b #$2E
	BNE.b CODE_0DE4E0
CODE_0DE48F:
	LDA.b $0F
	CMP.b #$05
	BEQ.b CODE_0DE4EF
	INC.w $0723
	LDA.b $0F
	CMP.b #$04
	BEQ.b CODE_0DE4DA
	LDA.b #$33
	JSR.w CODE_0DA61A
	JSL.l CODE_0E877D
	LDA.b #!Define_SMBLL_LevelMusic_StopMusicCommand
	STA.w !RAM_SMBLL_Global_MusicCh1
	LDA.b #!Define_SMAS_Sound0060_GrabFlagpole
	STA.w !RAM_SMBLL_Global_SoundCh1
	LSR
	STA.w $0713
	LDX.b #$04
	LDA.w $0237
	STA.w $070F
CODE_0DE4BD:
	CMP.w DATA_0DE477,x
	BCS.b CODE_0DE4C5
	DEX
	BNE.b CODE_0DE4BD
CODE_0DE4C5:
	STX.w $010F
	LDA.w $07DE
	CMP.w $07DF
	BNE.b CODE_0DE4DA
	CMP.w $07EB
	BNE.b CODE_0DE4DA
	LDA.b #$05
	STA.w $010F
CODE_0DE4DA:
	LDA.b #$04
	STA.b $0F
	BRA.b CODE_0DE4EF

CODE_0DE4E0:
	CMP.b #$2F
	BNE.b CODE_0DE4EF
	LDA.w $0237
	CMP.b #$20
	BCS.b CODE_0DE4EF
	LDA.b #$01
	STA.b $0F
CODE_0DE4EF:
	LDA.b #$03
	STA.b $28
	STZ.b $5D
	STZ.w $0705
	LDA.w $0398
	BEQ.b CODE_0DE52C
	LDA.w $03AE
	BPL.b CODE_0DE52C
	CMP.b #$F8
	BCC.b CODE_0DE52C
	LDA.w $0082
	STA.b $E5
	LDA.w $0223
	STA.b $E4
	REP.b #$20
	LDA.b $E4
	CLC
	ADC.w #$0007
	STA.b $E4
	SEP.b #$20
	LDA.b $E4
	STA.w $0219
	LDA.b $E5
	STA.b $78
	LDA.b #$02
	STA.w $0202
	BRA.b CODE_0DE559

CODE_0DE52C:
	LDA.w $0219
	SEC
	SBC.w $071C
	CMP.b #$10
	BCS.b CODE_0DE53C
	LDA.b #$02
	STA.w $0202
CODE_0DE53C:
	LDY.w $0202
	LDA.b $06
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC.w DATA_0DE473-$01,y
	STA.w $0219
	LDA.b $06
	BNE.b CODE_0DE559
	LDA.w $071B
	CLC
	ADC.w DATA_0DE475-$01,y
	STA.b $78
CODE_0DE559:
	RTS

;--------------------------------------------------------------------

CODE_0DE55A:
	CMP.b #$5C
	BEQ.b CODE_0DE570
	CMP.b #$5D
	BEQ.b CODE_0DE570
	CMP.b #$5E
	BEQ.b CODE_0DE570
	CMP.b #$60
	BEQ.b CODE_0DE570
	CMP.b #$61
	BEQ.b CODE_0DE570
	CMP.b #$5F
CODE_0DE570:
	RTS

;--------------------------------------------------------------------

CODE_0DE571:
	JSR.w CODE_0DE58D
	BCC.b CODE_0DE58C
	LDA.b #$70
	STA.w $0709
	STA.w $070A
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDA.b #$F8
else
	LDA.b #$F9
endif
	STA.w $06DB
	LDA.b #$03
	STA.w $078E
	LSR
	STA.w $070E
CODE_0DE58C:
	RTS

;--------------------------------------------------------------------

CODE_0DE58D:
	CMP.b #$6E
	BEQ.b CODE_0DE596
	CMP.b #$6F
	CLC
	BNE.b CODE_0DE597
CODE_0DE596:
	SEC
CODE_0DE597:
	RTS

;--------------------------------------------------------------------

CODE_0DE598:
	LDA.b $0B
	AND.b #$04
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMBLL_J) != $00
	BNE.b +
	JMP.w CODE_0DE613

+:
else
	BEQ.b CODE_0DE613
endif
	LDA.b $00
	CMP.b #$17
	BNE.b CODE_0DE613
	LDA.b $01
	CMP.b #$16
	BNE.b CODE_0DE613
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDA.b #$28
else
	LDA.b #$30
endif
	STA.w $06DE
	LDA.b #$03
	STA.b $0F
	LDA.b #$04
	STA.w $07AE
	STZ.w $07AF
	LDA.b #$00
	STA.w $0256
	LDA.w $06D6
	BEQ.b CODE_0DE60D
	AND.b #$0F
	TAX
	LDA.w $075F
	CMP.b #$08
	BCS.b CODE_0DE5D4
	LDA.b #$01
	STA.w !RAM_SMBLL_Level_NoWorld9Flag
CODE_0DE5D4:
	LDA.w DATA_0D8D98,x
	TAY
	DEY
	STY.w $075F
	LDX.w DATA_0EC499,y				; Glitch: This instruction is useless. It also reads from bank 0D due to what the DBR is set to.
	TYX
	LDA.l DATA_0EC499,x
	TAX
	LDA.l SMBLL_LevelIDsAndTileset,x
	STA.w $0750
	LDA.b #!Define_SMBLL_LevelMusic_MusicFade
	STA.w !RAM_SMBLL_Global_MusicCh1
	LDA.b #$00
	STA.w $0751
	STA.w $0760
	STA.w $075C
	STA.w $0752
	INC.w $075D
	INC.w $0757
	LDA.b #!Define_SMBLL_LevelMusic_CopyOfMusicFade
	STA.w !RAM_SMBLL_Global_MusicCh1
	STA.w $0E1A
CODE_0DE60D:
	LDA.b #!Define_SMAS_Sound0060_IntoPipe
	STA.w !RAM_SMBLL_Global_SoundCh1
	RTS

CODE_0DE613:
	RTS

;--------------------------------------------------------------------

CODE_0DE614:
	LDA.b #$00
	LDY.b $5D
	LDX.b $00
	DEX
	BNE.b CODE_0DE627
	INX
	CPY.b #$00
	BMI.b CODE_0DE64C
	LDA.b #$FF
	JMP.w CODE_0DE62F

CODE_0DE627:
	LDX.b #$02
	CPY.b #$01
	BPL.b CODE_0DE64C
	LDA.b #$01
CODE_0DE62F:
	LDY.b #$10
	STY.w $078D
	LDY.b #$00
	STY.b $5D
	CMP.b #$00
	BPL.b CODE_0DE63D
	DEY
CODE_0DE63D:
	STY.b $00
	CLC
	ADC.w $0219
	STA.w $0219
	LDA.b $78
	ADC.b $00
	STA.b $78
CODE_0DE64C:
	TXA
	EOR.b #$FF
	AND.w $0480
	STA.w $0480
	RTS

;--------------------------------------------------------------------

DATA_0DE656:
	db $16,$62,$86,$FD

CODE_0DE65A:
	JSR.w CODE_0DE67C
	CMP.w DATA_0DE656,x
	RTS

;--------------------------------------------------------------------

DATA_0DE661:
	db $2D,$78,$88,$FF

CODE_0DE665:
	JSR.w CODE_0DE67C
	CMP.w DATA_0DE661,x
	RTS

;--------------------------------------------------------------------

CODE_0DE66C:
	CMP.b #$EA
	BEQ.b CODE_0DE676
	CMP.b #$EB
	BEQ.b CODE_0DE676
	CLC
	RTS

CODE_0DE676:
	LDA.b #!Define_SMAS_Sound0063_Coin
	STA.w !RAM_SMBLL_Global_SoundCh3
	RTS

;--------------------------------------------------------------------

CODE_0DE67C:
	TAY
	AND.b #$C0
	ASL
	ROL
	ROL
	TAX
	TYA
CODE_0DE684:
	RTS

;--------------------------------------------------------------------

DATA_0DE685:
	db $01,$01,$02,$02,$02,$05

DATA_0DE68B:
	db $10,$F0

CODE_0DE68D:
	LDA.b $29,x
	AND.b #$20
	BNE.b CODE_0DE684
	JSR.w CODE_0DE844
	BCC.b CODE_0DE684
	LDY.b !RAM_SMBLL_NorSpr_SpriteID,x
	CPY.b #$12
	BNE.b CODE_0DE6A5
	LDA.w $0238,x
	CMP.b #$25
	BCC.b CODE_0DE684
CODE_0DE6A5:
	CPY.b #$0E
	BNE.b CODE_0DE6AC
	JMP.w CODE_0DE84D

CODE_0DE6AC:
	CPY.b #$05
	BNE.b CODE_0DE6B4
	JMP.w CODE_0DE86F

CODE_0DE6B3:
	RTS

CODE_0DE6B4:
	CPY.b #$12
	BEQ.b CODE_0DE6C4
	CPY.b #$2E
	BEQ.b CODE_0DE6C4
	CPY.b #$04
	BEQ.b CODE_0DE6B3
	CPY.b #$07
	BCS.b CODE_0DE6B3
CODE_0DE6C4:
	JSR.w CODE_0DE898
	BNE.b CODE_0DE6CC
CODE_0DE6C9:
	JMP.w CODE_0DE7BE

CODE_0DE6CC:
	JSR.w CODE_0DE89F
	BEQ.b CODE_0DE6C9
	CMP.b #$2C
	BNE.b CODE_0DE743
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$15
	BCS.b CODE_0DE6E7
	CMP.b #$06
	BNE.b CODE_0DE6E2
	JSR.w CODE_0DE878
CODE_0DE6E2:
	LDA.b #$01
	JSR.w CODE_0DDFC3
CODE_0DE6E7:
	LDA.w !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$09
	BCC.b CODE_0DE706
	CMP.b #$11
	BCS.b CODE_0DE706
	CMP.b #$0D
	BEQ.b CODE_0DE706
	CMP.b #$04
	BEQ.b CODE_0DE706
	CMP.b #$0A
	BCC.b CODE_0DE702
	CMP.b #$0D
	BCC.b CODE_0DE706
CODE_0DE702:
	AND.b #$01
	STA.b !RAM_SMBLL_NorSpr_SpriteID,x
CODE_0DE706:
	CMP.b #$2E
	BEQ.b CODE_0DE712
	CMP.b #$06
	BEQ.b CODE_0DE712
	LDA.b #$02
	STA.b $29,x
CODE_0DE712:
	DEC.w $0238,x
	DEC.w $0238,x
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$07
	BEQ.b CODE_0DE724
	LDA.b #$FD
	LDY.b $5C
	BNE.b CODE_0DE726
CODE_0DE724:
	LDA.b #$FF
CODE_0DE726:
	STA.b $A1,x
	LDY.b #$01
	JSR.w CODE_0DE828
	BPL.b CODE_0DE730
	INY

CODE_0DE730:
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$33
	BEQ.b CODE_0DE73C
	CMP.b #$08
	BEQ.b CODE_0DE73C
	STY.b $47,x
CODE_0DE73C:
	DEY
	LDA.w DATA_0DE68B,y
	STA.b $5E,x
	RTS

CODE_0DE743:
	LDA.b $04
	SEC
	SBC.b #$08
	CMP.b #$05
	BCS.b CODE_0DE7BE
	LDA.b $29,x
	AND.b #$40
	BNE.b CODE_0DE7A9
	LDA.b $29,x
	ASL
	BCC.b CODE_0DE75A
CODE_0DE757:
	JMP.w CODE_0DE7D9

CODE_0DE75A:
	LDA.b $29,x
	BEQ.b CODE_0DE757
	CMP.b #$05
	BEQ.b CODE_0DE781
	CMP.b #$03
	BCS.b CODE_0DE780
	LDA.b $29,x
	CMP.b #$02
	BNE.b CODE_0DE781
	LDA.b #$10
	LDY.b !RAM_SMBLL_NorSpr_SpriteID,x
	CPY.b #$12
	BNE.b CODE_0DE776
	LDA.b #$00
CODE_0DE776:
	STA.w $07A2,x
	LDA.b #$03
	STA.b $29,x
	JSR.w CODE_0DE836
CODE_0DE780:
	RTS

CODE_0DE781:
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$06
	BEQ.b CODE_0DE7A9
	CMP.b #$12
	BNE.b CODE_0DE799
	LDA.b #$01
	STA.b $47,x
	LDA.b #$08
	STA.b $5E,x
	LDA.b $09
	AND.b #$07
	BEQ.b CODE_0DE7A9
CODE_0DE799:
	LDY.b #$01
	JSR.w CODE_0DE828
	BPL.b CODE_0DE7A1
	INY
CODE_0DE7A1:
	TYA
	CMP.b $47,x
	BNE.b CODE_0DE7A9
	JSR.w CODE_0DE800
CODE_0DE7A9:
	JSR.w CODE_0DE836
	LDA.b $29,x
	AND.b #$80
	BNE.b CODE_0DE7B7
	LDA.b #$00
	STA.b $29,x
	RTS

CODE_0DE7B7:
	LDA.b $29,x
	AND.b #$BF
	STA.b $29,x
	RTS

CODE_0DE7BE:
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$03
	BNE.b CODE_0DE7C8
	LDA.b $29,x
	BEQ.b CODE_0DE800
CODE_0DE7C8:
	LDA.b $29,x
	TAY
	ASL
	BCC.b CODE_0DE7D4
	LDA.b $29,x
	ORA.b #$40
	BRA.b CODE_0DE7D7

CODE_0DE7D4:
	LDA.w DATA_0DE685,y
CODE_0DE7D7:
	STA.b $29,x
CODE_0DE7D9:
	LDA.w $0238,x
	CMP.b #$20
	BCC.b CODE_0DE7FF
	LDY.b #$16
	LDA.b #$02
	STA.b $EB
CODE_0DE7E6:
	LDA.b $EB
	CMP.b $47,x
	BNE.b CODE_0DE7F8
	LDA.b #$01
	JSR.w CODE_0DEA96
	BEQ.b CODE_0DE7F8
	JSR.w CODE_0DE89F
	BNE.b CODE_0DE800
CODE_0DE7F8:
	DEC.b $EB
	INY
	CPY.b #$18
	BCC.b CODE_0DE7E6
CODE_0DE7FF:
	RTS

CODE_0DE800:
	CPX.b #$09
	BEQ.b CODE_0DE816
	LDA.b $29,x
	ASL
	BCC.b CODE_0DE816
	CPX.b #$09
	BEQ.b CODE_0DE816
	LDA.b #!Define_SMAS_Sound0060_HitHead
	STA.w !RAM_SMBLL_Global_SoundCh1
	JSL.l CODE_0FE0AC
CODE_0DE816:
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$05
	BNE.b CODE_0DE825
	LDA.b #$00
	STA.b $00
	LDY.b #$FA
	JMP.w CODE_0DCDCF

CODE_0DE825:
	JMP.w CODE_0DE128

CODE_0DE828:
	LDA.w $021A,x
	SEC
	SBC.w $0219
	STA.b $00
	LDA.b $79,x
	SBC.b $78
	RTS

CODE_0DE836:
	JSR.w CODE_0DC5E1
	LDA.w $0238,x
	AND.b #$F0
	ORA.b #$08
	STA.w $0238,x
	RTS

;--------------------------------------------------------------------

CODE_0DE844:
	LDA.w $0238,x
	CLC
	ADC.b #$3E
	CMP.b #$44
	RTS

;--------------------------------------------------------------------

CODE_0DE84D:
	JSR.w CODE_0DE844
	BCC.b CODE_0DE86C
	LDA.b $A1,x
	CLC
	ADC.b #$02
	CMP.b #$03
	BCC.b CODE_0DE86C
	JSR.w CODE_0DE898
	BEQ.b CODE_0DE86C
	JSR.w CODE_0DE89F
	BEQ.b CODE_0DE86C
	JSR.w CODE_0DE836
	LDA.b #$FD
	STA.b $A1,x
CODE_0DE86C:
	JMP.w CODE_0DE7D9

CODE_0DE86F:
	JSR.w CODE_0DE898
	BEQ.b CODE_0DE891
	CMP.b #$2C
	BNE.b CODE_0DE880
CODE_0DE878:
	JSR.w CODE_0DDC98
	LDA.b #$FC
	STA.b $A1,x
	RTS

CODE_0DE880:
	LDA.w $0792,x
	BNE.b CODE_0DE891
	LDA.b $29,x
	AND.b #$88
	STA.b $29,x
	JSR.w CODE_0DE836
	JMP.w CODE_0DE7D9

CODE_0DE891:
	LDA.b $29,x
	ORA.b #$01
	STA.b $29,x
	RTS

CODE_0DE898:
	LDA.b #$00
	LDY.b #$15
	JMP.w CODE_0DEA96

CODE_0DE89F:
	CMP.b #$2F
	BEQ.b CODE_0DE8C1
	CMP.b #$EA
	BEQ.b CODE_0DE8C1
	CMP.b #$EB
	BEQ.b CODE_0DE8C1
	CMP.b #$5C
	BEQ.b CODE_0DE8C1
	CMP.b #$5D
	BEQ.b CODE_0DE8C1
	CMP.b #$5E
	BEQ.b CODE_0DE8C1
	CMP.b #$60
	BEQ.b CODE_0DE8C1
	CMP.b #$61
	BEQ.b CODE_0DE8C1
	CMP.b #$5F
CODE_0DE8C1:
	RTS

;--------------------------------------------------------------------

CODE_0DE8C2:
	LDA.w $0242,x
	CMP.b #$18
	BCC.b CODE_0DE8EE
	JSR.w CODE_0DEAAA
	BEQ.b CODE_0DE8EE
	JSR.w CODE_0DE89F
	BEQ.b CODE_0DE8EE
	LDA.b $AB,x
	BMI.b CODE_0DE8F4
	LDA.w $020D,x
	BNE.b CODE_0DE8F4
	LDA.b #$FD
	STA.b $AB,x
	LDA.b #$01
	STA.w $020D,x
	LDA.w $0242,x
	AND.b #$F8
	STA.w $0242,x
	RTS

CODE_0DE8EE:
	LDA.b #$00
	STA.w $020D,x
	RTS

CODE_0DE8F4:
	LDA.b #$80
	STA.b $33,x
	LDA.b #!Define_SMAS_Sound0060_HitHead
	STA.w !RAM_SMBLL_Global_SoundCh1
	RTS

;--------------------------------------------------------------------

DATA_0DE8FE:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	db $02,$08,$0E,$20,$03,$14,$0D,$20
	db $02,$14,$0E,$20,$02,$09,$0E,$15
	db $00,$00,$18,$06,$00,$00,$20,$0D
	db $00,$00,$30,$0D,$00,$00,$08,$08
	db $06,$04,$0A,$0C,$03,$0C,$0D,$14
	db $04,$04,$1C,$1C,$04,$04,$0C,$1C
	db $03,$07,$0D,$16
else
	db $02,$08,$0E,$20,$03,$14,$0D,$20
	db $02,$14,$0E,$20,$02,$09,$0E,$15
	db $00,$00,$18,$06,$00,$00,$20,$0D
	db $00,$00,$30,$0D,$00,$00,$08,$08
	db $06,$04,$0A,$0C,$03,$0E,$0D,$14
	db $04,$04,$1C,$1C,$04,$04,$0C,$1C
	db $03,$07,$0D,$16
endif

;--------------------------------------------------------------------

CODE_0DE932:
	TXA
	CLC
	ADC.b #$0B
	TAX
	LDY.b #$02
	BNE.b CODE_0DE942

CODE_0DE93B:
	TXA
	CLC
	ADC.b #$0D
	TAX
	LDY.b #$06
CODE_0DE942:
	JSR.w CODE_0DE9A9
	JMP.w CODE_0DE9EB

;--------------------------------------------------------------------

CODE_0DE948:
	LDY.b #$48
	STY.b $00
	LDY.b #$44
	JMP.w CODE_0DE957

CODE_0DE951:
	LDY.b #$08
	STY.b $00
	LDY.b #$04
CODE_0DE957:
	LDA.w $021A,x
	SEC
	SBC.w $071C
	STA.b $01
	LDA.b $79,x
	SBC.w $071A
	BMI.b CODE_0DE96D
	ORA.b $01
	BEQ.b CODE_0DE96D
	LDY.b $00
CODE_0DE96D:
	TYA
	AND.w $03D1
	STA.w $03D9,x
	CPX.b #$09
	BEQ.b CODE_0DE989
	LDA.w $03D9,x
	BNE.b CODE_0DE996
	JMP.w CODE_0DE989

CODE_0DE980:
	INX
	JSR.w CODE_0DFE34
	DEX
	CMP.b #$FE
	BCS.b CODE_0DE996
CODE_0DE989:
	TXA
	CLC
	ADC.b #$01
	TAX
	LDY.b #$01
	JSR.w CODE_0DE9A9
	JMP.w CODE_0DE9EB

CODE_0DE996:
	TXA
	ASL
	ASL
	TAY
	LDA.b #$FF
	STA.w $0FA0,y
	STA.w $0FA1,y
	STA.w $0FA2,y
	STA.w $0FA3,y
	RTS

;--------------------------------------------------------------------

CODE_0DE9A9:
	STX.b $00
	LDA.w $03B8,y
	STA.b $02
	LDA.w $03AD,y
	STA.b $01
	TXA
	ASL
	ASL
	PHA
	TAY
	LDA.w $048F,x
	ASL
	ASL
	TAX
	LDA.b $01
	CLC
	ADC.w DATA_0DE8FE,x
	STA.w $0F9C,y
	LDA.b $01
	CLC
	ADC.w DATA_0DE8FE+$02,x
	STA.w $0F9E,y
	INX
	INY
	LDA.b $02
	CLC
	ADC.w DATA_0DE8FE,x
	STA.w $0F9C,y
	LDA.b $02
	CLC
	ADC.w DATA_0DE8FE+$02,x
	STA.w $0F9E,y
	PLA
	TAY
	LDX.b $00
	RTS

;--------------------------------------------------------------------

CODE_0DE9EB:
	LDA.w $071C
	CLC
	ADC.b #$80
	STA.b $02
	LDA.w $071A
	ADC.b #$00
	STA.b $01
	LDA.w $0219,x
	CMP.b $02
	LDA.b $78,x
	SBC.b $01
	BCC.b CODE_0DEA1A
	LDA.w $0F9E,y
	BMI.b CODE_0DEA17
	LDA.b #$FF
	LDX.w $0F9C,y
	BMI.b CODE_0DEA14
	STA.w $0F9C,y
CODE_0DEA14:
	STA.w $0F9E,y
CODE_0DEA17:
	LDX.b $9E
	RTS

CODE_0DEA1A:
	LDA.w $0F9C,y
	BPL.b CODE_0DEA30
	CMP.b #$A0
	BCC.b CODE_0DEA30
	LDA.b #$00
	LDX.w $0F9E,y
	BPL.b CODE_0DEA2D
	STA.w $0F9E,y
CODE_0DEA2D:
	STA.w $0F9C,y
CODE_0DEA30:
	LDX.b $9E
	RTS

;--------------------------------------------------------------------

CODE_0DEA33:
	LDX.b #$00
CODE_0DEA35:
	STY.b $06
	LDA.b #$01
	STA.b $07
CODE_0DEA3B:
	LDA.w $0F9C,y
	CMP.w $0F9C,x
	BCS.b CODE_0DEA6D
	CMP.w $0F9E,x
	BCC.b CODE_0DEA5A
	BEQ.b CODE_0DEA8C
	LDA.w $0F9E,y
	CMP.w $0F9C,y
	BCC.b CODE_0DEA8C
	CMP.w $0F9C,x
	BCS.b CODE_0DEA8C
	LDY.b $06
	RTS

CODE_0DEA5A:
	LDA.w $0F9E,x
	CMP.w $0F9C,x
	BCC.b CODE_0DEA8C
	LDA.w $0F9E,y
	CMP.w $0F9C,x
	BCS.b CODE_0DEA8C
	LDY.b $06
	RTS

CODE_0DEA6D:
	CMP.w $0F9C,x
	BEQ.b CODE_0DEA8C
	CMP.w $0F9E,x
	BCC.b CODE_0DEA8C
	BEQ.b CODE_0DEA8C
	CMP.w $0F9E,y
	BCC.b CODE_0DEA88
	BEQ.b CODE_0DEA88
	LDA.w $0F9E,y
	CMP.w $0F9C,x
	BCS.b CODE_0DEA8C
CODE_0DEA88:
	CLC
	LDY.b $06
	RTS

CODE_0DEA8C:
	INX
	INY
	DEC.b $07
	BPL.b CODE_0DEA3B
	SEC
	LDY.b $06
	RTS

;--------------------------------------------------------------------

CODE_0DEA96:
	PHA
	TXA
	CLC
	ADC.b #$01
	TAX
	PLA
	JMP.w CODE_0DEAB3

CODE_0DEAA0:
	TXA
	CLC
	ADC.b #$11
	TAX
	LDY.b #$1B
	JMP.w CODE_0DEAB1

CODE_0DEAAA:
	LDY.b #$1A
	TXA
	CLC
	ADC.b #$0B
	TAX
CODE_0DEAB1:
	LDA.b #$00
CODE_0DEAB3:
	JSR.w CODE_0DEAFF
	LDX.b $9E
	CMP.b #$00
	RTS

;--------------------------------------------------------------------

DATA_0DEABB:
	db $00,$07,$0E

;--------------------------------------------------------------------

DATA_0DEABE:
	db $08,$03,$0C,$02,$02,$0D,$0D,$08
	db $03,$0C,$02,$02,$0D,$0D,$08,$03
	db $0C,$02,$02,$0D,$0D,$08,$00,$10
	db $04,$14,$04,$04

DATA_0DEADA:
	db $04,$20,$20,$08,$18,$08,$18,$02
	db $20,$20,$08,$18,$08,$18,$12,$20
	db $20,$18,$18,$18,$18,$18,$14,$14
	db $06,$06,$08,$10

CODE_0DEAF6:
	INY
CODE_0DEAF7:
	LDA.b #$00
	BRA.b CODE_0DEAFD

CODE_0DEAFB:
	LDA.b #$01
CODE_0DEAFD:
	LDX.b #$00
CODE_0DEAFF:
	PHA
	STY.b $04
	LDA.w DATA_0DEABE,y
	CLC
	ADC.w $0219,x
	STA.b $05
	LDA.b $78,x
	ADC.b #$00
	AND.b #$01
	LSR
	ORA.b $05
	ROR
	LSR
	LSR
	LSR
	JSR.w CODE_0DAA8F
	LDY.b $04
	LDA.w $0237,x
	CLC
	ADC.w DATA_0DEADA,y
	AND.b #$F0
	SEC
	SBC.b #$20
	STA.b $02
	TAY
	LDA.b ($06),y
	STA.b $03
	LDY.b $04
	PLA
	BNE.b CODE_0DEB3B
	LDA.w $0237,x
	JMP.w CODE_0DEB3E

CODE_0DEB3B:
	LDA.w $0219,x
CODE_0DEB3E:
	AND.b #$0F
	STA.b $04
	LDA.b $E4
	BNE.b CODE_0DEB52
	LDA.b $03
	CMP.b #$5C
	BCC.b CODE_0DEB52
	CMP.b #$62
	BCS.b CODE_0DEB52
	STZ.b $03
CODE_0DEB52:
	LDA.b $03
	RTS

if !Define_Global_ROMToAssemble&(!ROM_SMBLL_E) != $00
elseif !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E) != $00
	%FREE_BYTES(NULLROM, 6, $FF)
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMBLL_J) != $00
	%FREE_BYTES(NULLROM, 32, $FF)
else
	%FREE_BYTES(NULLROM, 3, $FF)
endif

;--------------------------------------------------------------------

CODE_0DEB58:
	LDX.b #$06
CODE_0DEB5A:
	STA.w $0800,y
	CLC
	ADC.b #$08
	INY
	INY
	INY
	INY
	DEX
	BNE.b CODE_0DEB5A
	LDY.b $02
	RTS

;--------------------------------------------------------------------

CODE_0DEB6A:
	LDX.b #$06
CODE_0DEB6C:
	STA.w $0900,y
	CLC
	ADC.b #$08
	INY
	INY
	INY
	INY
	DEX
	BNE.b CODE_0DEB6C
	LDY.b $02
	RTS

;--------------------------------------------------------------------

CODE_0DEB7C:
	LDA.b #$F0
	STA.w $0815,y
	STA.w $0811,y
CODE_0DEB84:
	STA.w $080D,y
	STA.w $0809,y
CODE_0DEB8A:
	STA.w $0805,y
	STA.w $0801,y
	RTS

;--------------------------------------------------------------------

CODE_0DEB91:
	LDA.b #$F0
CODE_0DEB93:
	STA.w $0915,y
	STA.w $0911,y
CODE_0DEB99:
	STA.w $090D,y
CODE_0DEB9C:
	STA.w $0909,y
CODE_0DEB9F:
	STA.w $0905,y
	STA.w $0901,y
	RTS

;--------------------------------------------------------------------

CODE_0DEBA6:
	LDA.w $0743
	BEQ.b CODE_0DEBAE
	JMP.w CODE_0DEC32

CODE_0DEBAE:
	LDY.w $0B46,x
	STY.b $02
	LDA.w $03AE
	JSR.w CODE_0DEB6A
	LDX.b $9E
	LDA.w $0238,x
	JSR.w CODE_0DEB99
	LDY.b $5C
	CPY.b #$03
	BEQ.b CODE_0DEBCC
	LDY.w $06CC
	BEQ.b CODE_0DEBCE
CODE_0DEBCC:
	LDA.b #$F0
CODE_0DEBCE:
	LDY.w $0B46,x
	STA.w $0911,y
	STA.w $0915,y
	LDA.b #$87
	LDX.b $9E
	INY
	JSR.w CODE_0DEB93
	LDA.b #$2C
	INY
	JSR.w CODE_0DEB93
	JSR.w CODE_0DFE34
	LDY.w $0B46,x
	JSR.w CODE_0DFEC2
	JSR.w CODE_0DFEDB
	PHY
	JSR.w CODE_0DFF51
	JSR.w CODE_0DFEDB
	JSR.w CODE_0DFF51
	JSR.w CODE_0DFEDB
	JSR.w CODE_0DFF51
	JSR.w CODE_0DFEDB
	JSR.w CODE_0DFF51
	JSR.w CODE_0DFEDB
	JSR.w CODE_0DFF51
	JSR.w CODE_0DFEDB
	PLY
	LDA.w $03D1
	ASL
	BCC.b CODE_0DEC31
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$27
	BEQ.b CODE_0DEC31
	CMP.b #$26
	BEQ.b CODE_0DEC31
	LDA.b $BC,x
	CMP.b #$01
	BNE.b CODE_0DEC2E
	LDA.w $03B9
	CMP.b #$F0
	BCC.b CODE_0DEC31
CODE_0DEC2E:
	JSR.w CODE_0DEB91
CODE_0DEC31:
	RTS

CODE_0DEC32:
	JSL.l CODE_0FD4D3
	RTS

;--------------------------------------------------------------------

DATA_0DEC37:
	db $E9,$EA
	db $78,$79
	db $D6,$D6
	db $D9,$D9
	db $8D,$8D
	db $E4,$E4
	db $E9,$EA
	db $78,$79
	db $7E,$7F
	db $85,$86

DATA_0DEC4B:
	db $2C,$28,$28,$2A,$2C

CODE_0DEC50:
	LDA.w $0B4F
	CLC
	ADC.b #$08
	TAY
	LDA.w $03B9
	CLC
	ADC.b #$08
	STA.b $02
	LDA.w $03AE
	STA.b $05
	LDX.w $020C
	LDA.w DATA_0DEC4B,x
	EOR.w $0260
	STA.b $04
	TXA
	PHA
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.b $07
	STA.b $03
CODE_0DEC7A:
	LDA.w DATA_0DEC37,x
	STA.b $00
	LDA.w DATA_0DEC37+$01,x
	JSR.w CODE_0DF2EF
	DEC.b $07
	BPL.b CODE_0DEC7A
	LDA.w $0B4F
	CLC
	ADC.b #$08
	TAY
	PLA
	BEQ.b CODE_0DECD3
	CMP.b #$03
	BEQ.b CODE_0DECD3
	CMP.b #$04
	BEQ.b CODE_0DECD3
	STA.b $00
	LDA.b $09
	AND.b #$06
	CMP.b #$06
	BNE.b CODE_0DECA7
	LDA.b #$0E
CODE_0DECA7:
	ORA.w $0260
	EOR.b #$28
	STA.w $0903,y
	STA.w $0907,y
	STA.w $090B,y
	STA.w $090F,y
	LDX.b $00
	DEX
	BEQ.b CODE_0DECC3
	STA.w $090B,y
	STA.w $090F,y
CODE_0DECC3:
	LDA.w $0907,y
	ORA.b #$40
	STA.w $0907,y
	LDA.w $090F,y
	ORA.b #$40
	STA.w $090F,y
CODE_0DECD3:
	LDA.w $0B4F
	CLC
	ADC.b #$08
	TAY
	JMP.w CODE_0DF29F

;--------------------------------------------------------------------

DATA_0DECDD:
	db $FC,$FC
	db $AA,$AB
	db $AC,$AD
	db $FC,$FC
	db $AE,$AF
	db $B0,$B1
	db $FC,$A5
	db $A6,$A7
	db $A8,$A9
	db $FC,$A0
	db $A1,$A2
	db $A3,$A4
	db $69,$A5
	db $6A,$A7
	db $A8,$A9
	db $6B,$A0
	db $6C,$A2
	db $A3,$A4
	db $FC,$FC
	db $96,$97
	db $98,$99
	db $FC,$FC
	db $9A,$9B
	db $9C,$9D
	db $FC,$FC
	db $8F,$8E
	db $8E,$8F
	db $FC,$FC
	db $95,$94
	db $94,$95
	db $FC,$FC
	db $DC,$DC
	db $DF,$DF
	db $DC,$DC
	db $DD,$DD
	db $DE,$DE
	db $FC,$FC
	db $B2,$B3
	db $B4,$B5
	db $FC,$FC
	db $B6,$B3
	db $B7,$B5
	db $FC,$FC
	db $C6,$C7
	db $C8,$C9
	db $FC,$FC
	db $6E,$6E
	db $6F,$6F
	db $FC,$FC
	db $6D,$6D
	db $6F,$6F
	db $FC,$FC
	db $6F,$6F
	db $6E,$6E
	db $FC,$FC
	db $6F,$6F
	db $6D,$6D
	db $FC,$FC
	db $F4,$F4
	db $F5,$F5
	db $FC,$FC
	db $F4,$F4
	db $F5,$F5
	db $FC,$FC
	db $F5,$F5
	db $F4,$F4
	db $FC,$FC
	db $F5,$F5
	db $F4,$F4
	db $FC,$FC
	db $FC,$FC
	db $EF,$EF
	db $B9,$B8
	db $BB,$BA
	db $BC,$BC
	db $FC,$FC
	db $BD,$BD
	db $BC,$BC
	db $7A,$7B
	db $DA,$DB
	db $D8,$9E
	db $CD,$CD
	db $CE,$CE
	db $CF,$CF
	db $7D,$7C
	db $D1,$8C
	db $D3,$D2
	db $7D,$7C
	db $89,$88
	db $8B,$8A
	db $D5,$D4
	db $E3,$E2
	db $D3,$D2
	db $D5,$D4
	db $E3,$E2
	db $8B,$8A
	db $E5,$E5
	db $E6,$E6
	db $EB,$EB
	db $EC,$EC
	db $ED,$ED
	db $EB,$EB
	db $FC,$FC
	db $D0,$D0
	db $D7,$D7
	db $C8,$C9
	db $D8,$D9
	db $E8,$E9
	db $D6,$D7
	db $E6,$E7
	db $F8,$F7
	db $EE,$EF
	db $FE,$FF
	db $E2,$E3
	db $DA,$DB
	db $EA,$EB
	db $FA,$FB
	db $FC,$FC
	db $64,$65
	db $74,$75
	db $F2,$F2
	db $F3,$F3
	db $F2,$F2
	db $F1,$F1
	db $F1,$F1
	db $FC,$FC
	db $F0,$F0
	db $FC,$FC
	db $FC,$FC

DATA_0DEDDF:
	db $0C,$0C,$00,$0C,$C0,$A8,$54,$3C
	db $EA,$18,$48,$48,$CC,$C0,$18,$18
	db $18,$90,$24,$FF,$48,$9C,$D2,$D8
	db $F0,$F6,$FC

DATA_0DEDFA:
	db $0A,$0C,$0A,$0C,$2C,$0A,$02,$08
	db $0A,$08,$0A,$0C,$08,$2A,$0A,$0C
	db $0A,$0A,$0C,$FF,$0C,$0C,$00,$00
	db $2C,$2C,$2C

DATA_0DEE15:
	db $08,$18

DATA_0DEE17:
	db $18,$19,$1A,$19,$18

DATA_0DEE1C:
	db $00,$00,$00,$00,$00,$00,$06,$06
	db $06,$06,$06,$06,$0C,$0C,$0C,$0C
	db $0C,$0C

DATA_0DEE2E:
	db $FC,$FC,$D0,$D0,$D7,$D7
	db $FC,$FC,$7E,$7E,$7F,$7F
	db $FC,$FC,$E0,$E0,$E1,$E1

;--------------------------------------------------------------------

CODE_0DEE40:
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$0C
	BNE.b CODE_0DEE4B
	JSL.l CODE_0FF964
	RTS

CODE_0DEE4B:
	CMP.b #$08
	BNE.b CODE_0DEE5D
	LDA.b $BC,x
	CMP.b #$02
	BNE.b CODE_0DEE58
	JSR.w CODE_0DCCEA
CODE_0DEE58:
	JSL.l CODE_0FD22A
	RTS

CODE_0DEE5D:
	CMP.b #$33
	BNE.b CODE_0DEE6F
	LDA.b $BC,x
	CMP.b #$02
	BNE.b CODE_0DEE6A
	JSR.w CODE_0DCCEA
CODE_0DEE6A:
	JSL.l CODE_0FD22A
	RTS

CODE_0DEE6F:
	CMP.b #$2D
	BNE.b CODE_0DEE78
	JSL.l CODE_0FD73D
	RTS

CODE_0DEE78:
	CMP.b #$35
	BNE.b CODE_0DEE91
	LDA.w $075F
	CMP.b #$07
	BEQ.b CODE_0DEE8C
	CMP.b #$0C
	BEQ.b CODE_0DEE8C
	JSL.l CODE_00D57A
	RTS

CODE_0DEE8C:
	JSL.l CODE_00C4BB
	RTS

CODE_0DEE91:
	LDA.b #$02
	LDY.w $075F
	CPY.b #$01
	BEQ.b CODE_0DEEA6
	CPY.b #$02
	BEQ.b CODE_0DEEA6
	CPY.b #$06
	BEQ.b CODE_0DEEA6
	CPY.b #$0B
	BNE.b CODE_0DEEA7
CODE_0DEEA6:
	LSR
CODE_0DEEA7:
	STA.w $0F30
	STA.w $0F31
	STA.w $0F32
	LDA.w $0238,x
	STA.b $02
	LDA.w $03AE
	STA.b $05
	LDY.w $0B46,x
	STY.b $EB
	LDA.b #$00
	STA.b $F0
	LDA.b $47,x
	STA.b $03
	LDA.w $0257,x
	STA.b $04
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$0D
	BNE.b CODE_0DEEDC
	LDY.b $5E,x
	BMI.b CODE_0DEEDC
	LDY.w $0792,x
	BEQ.b CODE_0DEEDC
	RTS

CODE_0DEEDC:
	LDA.b $29,x
	STA.b $ED
	AND.b #$1F
	TAY
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$35
	BNE.b CODE_0DEEF1
	LDY.b #$00
	LDA.b #$01
	STA.b $03
	LDA.b #$15
CODE_0DEEF1:
	CMP.b #$33
	BNE.b CODE_0DEF08
	DEC.b $02
	LDA.b #$20
	LDY.w $0792,x
	BEQ.b CODE_0DEF00
	EOR.b #$30
CODE_0DEF00:
	STA.b $04
	LDY.b #$00
	STY.b $ED
	LDA.b #$08
CODE_0DEF08:
	CMP.b #$32
	BNE.b CODE_0DEF14
	LDY.b #$03
	LDX.w $070E
	LDA.w DATA_0DEE17,x
CODE_0DEF14:
	STA.b $EF
	STY.b $EC
	LDX.b $9E
	CMP.b #$0C
	BNE.b CODE_0DEF24
	LDA.b $A1,x
	BMI.b CODE_0DEF24
	INC.b $F0
CODE_0DEF24:
	LDA.w $036A
	BEQ.b CODE_0DEF32
	LDY.b #$16
	CMP.b #$01
	BEQ.b CODE_0DEF30
	INY
CODE_0DEF30:
	STY.b $EF
CODE_0DEF32:
	LDY.b $EF
	CPY.b #$06
	BNE.b CODE_0DEF55
	LDA.b $29,x
	CMP.b #$02
	BCC.b CODE_0DEF42
	LDX.b #$04
	STX.b $EC
CODE_0DEF42:
	AND.b #$20
	ORA.w $0747
	BNE.b CODE_0DEF55
	LDA.b $09
	AND.b #$08
	BNE.b CODE_0DEF55
	LDA.b $03
	EOR.b #$03
	STA.b $03
CODE_0DEF55:
	CPY.b #$0D
	BNE.b CODE_0DEF5E
	LDA.w $0F24
	BRA.b CODE_0DEF7D

CODE_0DEF5E:
	LDA.w DATA_0DEDFA,y
	CPY.b #$14
	BNE.b CODE_0DEF69
	LDA.b #$3C
	BRA.b CODE_0DEF7F

CODE_0DEF69:
	CPY.b #$16
	BEQ.b CODE_0DEF71
	CPY.b #$17
	BNE.b CODE_0DEF7D
CODE_0DEF71:
	LDA.w $0201
	LSR
	BCC.b CODE_0DEF7B
	LDA.b #$06
	BRA.b CODE_0DEF7D

CODE_0DEF7B:
	LDA.b #$00
CODE_0DEF7D:
	EOR.b $04
CODE_0DEF7F:
	STA.b $04
	CPY.b #$15
	BNE.b CODE_0DEF98
	LDA.w $075F
	CMP.b #$07
	BEQ.b CODE_0DEF90
	CMP.b #$0C
	BNE.b CODE_0DEF98
CODE_0DEF90:
	LDA.b $04
	AND.b #$F0
	ORA.b #$04
	STA.b $04
CODE_0DEF98:
	LDA.w $0E85
	BEQ.b CODE_0DEFA6
	LDA.w DATA_0DEDDF,y
	CLC
	ADC.b #$06
	TAX
	BRA.b CODE_0DEFAA

CODE_0DEFA6:
	LDA.w DATA_0DEDDF,y
	TAX
CODE_0DEFAA:
	LDY.b $EC
	LDA.w $036A
	BEQ.b CODE_0DEFDF
	CMP.b #$01
	BNE.b CODE_0DEFC7
	LDA.w $0363
	BPL.b CODE_0DEFBC
	LDX.b #$DE
CODE_0DEFBC:
	LDA.b $ED
	AND.b #$20
	BEQ.b CODE_0DEFC4
CODE_0DEFC2:
	STX.b $F0
CODE_0DEFC4:
	JMP.w CODE_0DF0CD

CODE_0DEFC7:
	LDA.w $0363
	AND.b #$01
	BEQ.b CODE_0DEFD0
	LDX.b #$E4
CODE_0DEFD0:
	LDA.b $ED
	AND.b #$20
	BEQ.b CODE_0DEFC4
	LDA.b $02
	SEC
	SBC.b #$10
	STA.b $02
	BRA.b CODE_0DEFC2

CODE_0DEFDF:
	CPX.b #$24
	BNE.b CODE_0DEFF3
	CPY.b #$05
	BNE.b CODE_0DEFF1
	LDX.b #$30
	LDA.b #$02
	STA.b $03
	LDA.b #$05
	STA.b $EC
CODE_0DEFF1:
	BRA.b CODE_0DF043

CODE_0DEFF3:
	CPX.b #$90
	BNE.b CODE_0DF009
	LDA.b $ED
	AND.b #$20
	BNE.b CODE_0DF006
	LDA.w $079B
	CMP.b #$10
	BCS.b CODE_0DF006
	LDX.b #$96
CODE_0DF006:
	JMP.w CODE_0DF0B3

CODE_0DF009:
	LDA.b $EF
	CMP.b #$04
	BCS.b CODE_0DF01F
	CPY.b #$02
	BCC.b CODE_0DF01F
	LDX.b #$5A
	LDY.b $EF
	CPY.b #$02
	BNE.b CODE_0DF01F
	LDX.b #$7E
	INC.b $02
CODE_0DF01F:
	LDA.b $EC
	CMP.b #$04
	BNE.b CODE_0DF043
	LDX.b #$72
	INC.b $02
	LDY.b $EF
	CPY.b #$02
	BEQ.b CODE_0DF033
	LDX.b #$66
	INC.b $02
CODE_0DF033:
	CPY.b #$06
	BNE.b CODE_0DF043
	LDX.b #$54
	LDA.b $ED
	AND.b #$20
	BNE.b CODE_0DF043
	LDX.b #$8A
	DEC.b $02
CODE_0DF043:
	LDY.b $9E
	LDA.b $EF
	CMP.b #$05
	BNE.b CODE_0DF057
	LDA.b $ED
	BEQ.b CODE_0DF072
	AND.b #$08
	BEQ.b CODE_0DF0B3
	LDX.b #$B4
	BNE.b CODE_0DF072

CODE_0DF057:
	CPX.b #$48
	BEQ.b CODE_0DF072
	LDA.w $07A2,y
	CMP.b #$05
	BCS.b CODE_0DF0B3
	CPX.b #$3C
	BNE.b CODE_0DF072
	CMP.b #$01
	BEQ.b CODE_0DF0B3
	INC.b $02
	INC.b $02
	INC.b $02
	BRA.b CODE_0DF0A5

CODE_0DF072:
	LDA.b $EF
	CMP.b #$06
	BEQ.b CODE_0DF0B3
	CMP.b #$08
	BEQ.b CODE_0DF0B3
	CMP.b #$0C
	BEQ.b CODE_0DF0B3
	CMP.b #$18
	BCS.b CODE_0DF0B3
	LDY.b #$00
	CMP.b #$15
	BNE.b CODE_0DF09E
	INY
	LDA.w $075F
	CMP.b #$07
	BEQ.b CODE_0DF0B3
	CMP.b #$0C
	BEQ.b CODE_0DF0B3
	LDX.b #$A2
	LDA.b #$03
	STA.b $EC
	BNE.b CODE_0DF0B3

CODE_0DF09E:
	LDA.b $09
	AND.w DATA_0DEE15,y
	BNE.b CODE_0DF0B3
CODE_0DF0A5:
	LDA.b $ED
	AND.b #$A0
	ORA.w $0747
	BNE.b CODE_0DF0B3
	TXA
	CLC
	ADC.b #$06
	TAX
CODE_0DF0B3:
	LDA.w $00EF
	CMP.b #$04
	BEQ.b CODE_0DF0C6
	LDA.b $ED
	AND.b #$20
	BEQ.b CODE_0DF0CD
	LDA.b $EF
	CMP.b #$04
	BCC.b CODE_0DF0CD
CODE_0DF0C6:
	LDY.b #$01
	STY.b $F0
	DEY
	STY.b $EC
CODE_0DF0CD:
	LDY.b $EB
	JSL.l CODE_0FF9BD
	BCS.b CODE_0DF0E2
	JSR.w CODE_0DF2E7
	JSR.w CODE_0DF2E7
	JSR.w CODE_0DF2E7
	JSL.l CODE_0FFA9E
CODE_0DF0E2:
	LDX.b $9E
	LDY.w $0B46,x
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$0C
	BNE.b CODE_0DF128
	INC.w $0E1B,x
	LDA.w $0E1B,x
	CMP.b #$12
	BCC.b CODE_0DF0FD
	STZ.w $0E1B,x
	LDA.w $0E1B,x
CODE_0DF0FD:
	TAX
	LDA.w DATA_0DEE1C,x
	TAX
	LDA.w DATA_0DEE2E,x
	STA.w $0902,y
	LDA.w DATA_0DEE2E+$01,x
	STA.w $0906,y
	LDA.w DATA_0DEE2E+$02,x
	STA.w $090A,y
	LDA.w DATA_0DEE2E+$03,x
	STA.w $090E,y
	LDA.w DATA_0DEE2E+$04,x
	STA.w $0912,y
	LDA.w DATA_0DEE2E+$05,x
	STA.w $0916,y
	LDX.b $9E
CODE_0DF128:
	LDA.b $EF
	CMP.b #$08
	BNE.b CODE_0DF131
CODE_0DF12E:
	JMP.w CODE_0DF247

CODE_0DF131:
	LDA.b $F0
	BEQ.b CODE_0DF176
	LDA.w $0903,y
	ORA.b #$80
	INY
	INY
	JSR.w CODE_0DEB93
	DEY
	DEY
	TYA
	TAX
	LDA.b $EF
	CMP.b #$05
	BEQ.b CODE_0DF15A
	CMP.b #$04
	BEQ.b CODE_0DF15A
	CMP.b #$11
	BEQ.b CODE_0DF15A
	CMP.b #$15
	BCS.b CODE_0DF15A
	TXA
	CLC
	ADC.b #$08
	TAX
CODE_0DF15A:
	LDA.w $0902,x
	PHA
	LDA.w $0906,x
	PHA
	LDA.w $0912,y
	STA.w $0902,x
	LDA.w $0916,y
	STA.w $0906,x
	PLA
	STA.w $0916,y
	PLA
	STA.w $0912,y
CODE_0DF176:
	LDA.w $036A
	BNE.b CODE_0DF12E
	LDA.b $EF
	LDX.b $EC
	CMP.b #$05
	BNE.b CODE_0DF186
	JMP.w CODE_0DF247

CODE_0DF186:
	CMP.b #$07
	BEQ.b CODE_0DF1A2
	CMP.b #$0D
	BEQ.b CODE_0DF1A2
	CMP.b #$04
	BEQ.b CODE_0DF1A2
	CMP.b #$0C
	BEQ.b CODE_0DF1A2
	CMP.b #$12
	BNE.b CODE_0DF19E
	CPX.b #$05
	BNE.b CODE_0DF1E2
CODE_0DF19E:
	CPX.b #$02
	BCC.b CODE_0DF1E2
CODE_0DF1A2:
	LDA.w $036A
	BNE.b CODE_0DF1E2
	LDA.w $0F49
	BNE.b CODE_0DF1E2
	LDA.w $0903,y
	AND.b #$BE
	STA.w $0903,y
	STA.w $090B,y
	STA.w $0913,y
	ORA.b #$40
	CPX.b #$05
	BNE.b CODE_0DF1C2
	ORA.b #$80
CODE_0DF1C2:
	STA.w $0907,y
	STA.w $090F,y
	STA.w $0917,y
	CPX.b #$04
	BNE.b CODE_0DF1E2
	LDA.w $090B,y
	ORA.b #$80
	STA.w $090B,y
	STA.w $0913,y
	ORA.b #$40
	STA.w $090F,y
	STA.w $0917,y
CODE_0DF1E2:
	LDA.b $EF
	CMP.b #$11
	BNE.b CODE_0DF21D
	LDA.b $F0
	BNE.b CODE_0DF20D
	LDA.w $0913,y
	AND.b #$BF
	STA.w $0913,y
	LDA.w $0917,y
	ORA.b #$40
	STA.w $0917,y
	LDX.w $079B
	CPX.b #$10
	BCS.b CODE_0DF247
	STA.w $090F,y
	AND.b #$BF
	STA.w $090B,y
	BCC.b CODE_0DF247
CODE_0DF20D:
	LDA.w $0903,y
	AND.b #$BF
	STA.w $0903,y
	LDA.w $0907,y
	ORA.b #$40
	STA.w $0907,y
CODE_0DF21D:
	LDA.b $EF
	CMP.b #$18
	BCC.b CODE_0DF247
	LDA.w $0F30
	LSR
	BCC.b CODE_0DF22D
	LDA.b #$AA
	BRA.b CODE_0DF22F

CODE_0DF22D:
	LDA.b #$AC
CODE_0DF22F:
	STA.w $090B,y
	STA.w $0913,y
	ORA.b #$40
	STA.w $090F,y
	STA.w $0917,y
	AND.b #$3F
	STA.w $0903,y
	ORA.b #$40
	STA.w $0907,y
CODE_0DF247:
	LDX.b $9E
	LDA.b $EF
	CMP.b #$0D
	BNE.b CODE_0DF26B
	LDA.b $29,x
	AND.b #$20
	BNE.b CODE_0DF28B
	LDA.w $0913,y
	AND.b #$F0
	ORA.b #$08
	STA.w $0913,y
	LDA.w $0917,y
	AND.b #$F0
	ORA.b #$08
	STA.w $0917,y
	BRA.b CODE_0DF29F

CODE_0DF26B:
	CMP.b #$04
	BNE.b CODE_0DF29F
	LDA.b $29,x
	AND.b #$20
	BNE.b CODE_0DF28B
	LDA.w $0903,y
	AND.b #$F0
	ORA.b #$08
	STA.w $0903,y
	LDA.w $0907,y
	AND.b #$F0
	ORA.b #$08
	STA.w $0907,y
	BRA.b CODE_0DF29F

CODE_0DF28B:
	LDA.b #$F0
	STA.w $0901,y
	STA.w $0905,y
	STA.w $0909,y
	STA.w $090D,y
	STA.w $0911,y
	STA.w $0915,y
CODE_0DF29F:
	LDX.b $9E
	JSR.w CODE_0DFEC2
	STZ.b $04
	JSR.w CODE_0DFEFB
	JSR.w CODE_0DFF51
	STZ.b $04
	JSR.w CODE_0DFEFB
	DEY
	DEY
	DEY
	DEY
	LDA.w $03D1
	LSR
	LSR
	LSR
	LSR
	LSR
	LSR
	PHA
	BCC.b CODE_0DF2C6
	LDA.b #$10
	JSR.w CODE_0DF303
CODE_0DF2C6:
	PLA
	LSR
	PHA
	BCC.b CODE_0DF2D0
	LDA.b #$08
	JSR.w CODE_0DF303
CODE_0DF2D0:
	PLA
	LSR
	BCC.b CODE_0DF2E6
	JSR.w CODE_0DF303
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$0C
	BEQ.b CODE_0DF2E6
	LDA.b $BC,x
	CMP.b #$02
	BNE.b CODE_0DF2E6
	JSR.w CODE_0DCCEA
CODE_0DF2E6:
	RTS

CODE_0DF2E7:
	LDA.w DATA_0DECDD,x
	STA.b $00
	LDA.w DATA_0DECDD+$01,x
CODE_0DF2EF:
	STA.b $01
	LDA.b $02
	CMP.b #$F9
	BNE.b CODE_0DF2FB
	LDA.b #$F0
	STA.b $02
CODE_0DF2FB:
	JMP.w CODE_0DFFAC

;--------------------------------------------------------------------

CODE_0DF2FE:
	STA.b $01
	JMP.w CODE_0DFF64

;--------------------------------------------------------------------

CODE_0DF303:
	STX.b $9E
	CPX.b #$0A
	BNE.b CODE_0DF30A
	DEX
CODE_0DF30A:
	CLC
	ADC.w $0B46,x
	TAY
	LDA.b #$F0
	LDX.b $9E
	JMP.w CODE_0DEB9F

;--------------------------------------------------------------------

CODE_0DF316:
	STX.b $9E
	CPX.b #$0A
	BNE.b CODE_0DF31D
	DEX
CODE_0DF31D:
	CLC
	ADC.w $0B46,x
	TAY
	LDA.b #$F0
	STA.w $0901,y
	STA.w $0909,y
	STA.w $0911,y
	LDX.b $9E
	RTS

;--------------------------------------------------------------------

CODE_0DF330:
	LDA.b #$01
	STA.w $0D00,y
	STA.w $0D08,y
	STA.w $0D10,y
	RTS

;--------------------------------------------------------------------

CODE_0DF33C:
	LDA.b #$01
	STA.w $0D04,y
	STA.w $0D0C,y
	STA.w $0D14,y
	RTS

;--------------------------------------------------------------------

CODE_0DF348:
	LDY.w $0B51,x
	LDA.w $03B1
	STA.w $0800,y
	LDA.w $03BC
	STA.w $0801,y
	LDA.b #$2B
	STA.w $0803,y
	LDA.b #$02
	STA.w $0C00,y
	LDA.w $03EA,x
	CMP.b #$FD
	BNE.b CODE_0DF36C
	LDA.b #$00
	BRA.b CODE_0DF36E

CODE_0DF36C:
	LDA.b #$02
CODE_0DF36E:
	STA.w $0802,y
	LDA.b $85,x
	STA.b $E5
	LDA.w $0226,x
	STA.b $E4
	REP.b #$20
	LDA.b $E4
	SEC
	SBC.b $42
	STA.b $E4
	SEP.b #$20
	LDA.b $E5
	BEQ.b CODE_0DF38E
	LDA.b #$03
	STA.w $0C00,y
CODE_0DF38E:
	RTS

;--------------------------------------------------------------------

CODE_0DF38F:
	AND.b #$08
	BEQ.b CODE_0DF39B
	LDA.b #$F0
	STA.w $0801,y
	STA.w $0809,y
CODE_0DF39B:
	RTS

;--------------------------------------------------------------------

CODE_0DF39C:
	LDA.b #$2C
	STA.b $00
	LDA.b #$75
	LDY.b $0F
	CPY.b #$05
	BEQ.b CODE_0DF3AE
	LDA.b #$2A
	STA.b $00
	LDA.b #$84
CODE_0DF3AE:
	LDY.w $0B51,x
	INY
	JSR.w CODE_0DEB84
	LDA.b $09
	ASL
	ASL
	ASL
	ASL
	AND.b #$C0
	ORA.b $00
	INY
	JSR.w CODE_0DEB84
	DEY
	DEY
	LDA.w $03BC
	CMP.b #$F0
	BCC.b CODE_0DF3CE
	LDA.b #$F0
CODE_0DF3CE:
	JSR.w CODE_0DEB8A
	LDA.w $03B1
	STA.w $0800,y
	LDA.w $03F3,x
	SEC
	SBC.w $071C
	STA.b $00
	SEC
	SBC.w $03B1
	ADC.b $00
	ADC.b #$06
	STA.w $0804,y
	LDA.w $03BD
	CMP.b #$F0
	BCC.b CODE_0DF3F4
	LDA.b #$F0
CODE_0DF3F4:
	STA.w $0809,y
	STA.w $080D,y
	LDA.w $03B2
	STA.w $0808,y
	LDA.b $00
	SEC
	SBC.w $03B2
	ADC.b $00
	ADC.b #$06
	STA.w $080C,y
	LDA.w $03D4
	ASL
	BCC.b CODE_0DF418
	LDA.b #$F0
	JSR.w CODE_0DEB8A
CODE_0DF418:
	LDA.w $03D4
	BEQ.b CODE_0DF425
	LDA.b #$01
	STA.w $0C00,y
	STA.w $0C08,y
CODE_0DF425:
	LDA.w $03D5
	BEQ.b CODE_0DF432
	LDA.b #$01
	STA.w $0C04,y
	STA.w $0C0C,y
CODE_0DF432:
	RTS

;--------------------------------------------------------------------

CODE_0DF433:
	LDY.w $0B56,x
	LDA.w $03BA
	STA.w $0801,y
	LDA.w $03AF
	STA.w $0800,y
	LDA.b $09
	LSR
	LSR
	PHA
	AND.b #$01
	EOR.b #$BE
	STA.w $0802,y
	PLA
	LSR
	LSR
	LDA.b #$28
	BCC.b CODE_0DF457
	ORA.b #$C0
CODE_0DF457:
	STA.w $0803,y
	LDA.w $0068,x
	BPL.b CODE_0DF46B
	LDA.w $03AF
	CMP.b #$F8
	BCC.b CODE_0DF46B
	LDA.b #$01
	STA.w $0C00,y
CODE_0DF46B:
	RTS

;--------------------------------------------------------------------

CODE_0DF46C:
	LDY.w $0B56,x
	LDA.w $03BA
	STA.w $0901,y
	LDA.w $03AF
	STA.w $0900,y
CODE_0DF47B:
	LDA.b $09
	LSR
	LSR
	PHA
	AND.b #$01
	EOR.b #$BE
	STA.w $0902,y
	PLA
	LSR
	LSR
	LDA.b #$38
	BCC.b CODE_0DF490
	ORA.b #$C0
CODE_0DF490:
	STA.w $0903,y
	RTS

;--------------------------------------------------------------------

DATA_0DF494:
	db $CC,$CB,$CA,$FC

CODE_0DF498:
	LDY.w $0B51,x
	LDA.w $0068,x
	BMI.b CODE_0DF4B7
	LDA.w $03AF
	SEC
	SBC.b #$04
	STA.w $03AF
	CMP.b #$F8
	BCC.b CODE_0DF4D6
CODE_0DF4AD:
	LDA.b #$01
	STA.w $0C08,y
	STA.w $0C0C,y
	BRA.b CODE_0DF4D6

CODE_0DF4B7:
	LDA.w $03AF
	CMP.b #$F0
	BCC.b CODE_0DF4D6
	CMP.b #$F8
	BCC.b CODE_0DF4CC
	LDA.b #$01
	STA.w $0C00,y
	STA.w $0C04,y
	BRA.b CODE_0DF4D6

CODE_0DF4CC:
	LDA.b #$01
	STA.w $0C00,y
	STA.w $0C04,y
	BRA.b CODE_0DF4AD

CODE_0DF4D6:
	LDA.b $33,x
	INC.b $33,x
	LSR
	AND.b #$07
	CMP.b #$03
	BCS.b CODE_0DF528
	TAX
	LDA.w DATA_0DF494,x
	INY
	JSR.w CODE_0DEB84
	DEY
	LDX.b $9E
	LDA.w $03BA
	SEC
	SBC.b #$04
	STA.w $0801,y
	STA.w $0809,y
	CLC
	ADC.b #$08
	STA.w $0805,y
	STA.w $080D,y
	LDA.w $03AF
	STA.w $0800,y
	STA.w $0804,y
	CLC
	ADC.b #$08
	STA.w $0808,y
	STA.w $080C,y
	LDA.b #$28
	STA.w $0803,y
	LDA.b #$A8
	STA.w $0807,y
	LDA.b #$68
	STA.w $080B,y
	LDA.b #$E8
	STA.w $080F,y
	RTS

CODE_0DF528:
	STZ.b $33,x
	RTS

;--------------------------------------------------------------------

DATA_0DF52B:
	db $48,$4A,$4C,$4E

DATA_0DF52F:
	db $0C,$08,$0A,$0C,$08,$0A,$0C,$08
	db $0A

CODE_0DF538:
	TAX
	LDA.w DATA_0DF52B,x
	INY
	JSR.w CODE_0DEB99
	DEY
	LDX.b $9E
	LDA.w $03BA
	SEC
	SBC.b #$10
	STA.w $0901,y
	STA.w $0909,y
	CLC
	ADC.b #$10
	STA.w $0905,y
	STA.w $090D,y
	LDA.w $03AF
	SEC
	SBC.b #$08
	STA.w $0900,y
	STA.w $0904,y
	CLC
	ADC.b #$10
	STA.w $0908,y
	STA.w $090C,y
	LDA.b #$02
	STA.w $0D00,y
	STA.w $0D04,y
	STA.w $0D08,y
	STA.w $0D0C,y
	PHX
	LDA.b $A1,x
	TAX
	DEX
	LDA.w DATA_0DF52F,x
	ORA.b #$20
	STA.w $0903,y
	LDA.w DATA_0DF52F,x
	ORA.b #$A0
	STA.w $0907,y
	LDA.w DATA_0DF52F,x
	ORA.b #$60
	STA.w $090B,y
	LDA.w DATA_0DF52F,x
	ORA.b #$E0
	STA.w $090F,y
	PLX
	RTS

;--------------------------------------------------------------------

CODE_0DF5A2:
	LDY.w $0B46,x
	LDA.b #$87
	INY
	JSR.w CODE_0DEB93
	INY
	LDA.b #$2C
	JSR.w CODE_0DEB93
	DEY
	DEY
	LDA.w $03AE
	STA.w $0900,y
	STA.w $090C,y
	CLC
	ADC.b #$08
	STA.w $0904,y
	STA.w $0910,y
	CLC
	ADC.b #$08
	STA.w $0908,y
	STA.w $0914,y
	LDA.w $0238,x
	TAX
	PHA
	CPX.b #$00
	BCS.b CODE_0DF5D9
	LDA.b #$F0
CODE_0DF5D9:
	JSR.w CODE_0DEB9C
	PLA
	CLC
	ADC.b #$80
	TAX
	CPX.b #$00
	BCS.b CODE_0DF5E7
	LDA.b #$F0
CODE_0DF5E7:
	STA.w $090D,y
	STA.w $0911,y
	STA.w $0915,y
	LDA.w $03D1
	PHA
	AND.b #$08
	BEQ.b CODE_0DF600
	LDA.b #$01
	STA.w $0D00,y
	STA.w $0D0C,y
CODE_0DF600:
	PLA
	PHA
	AND.b #$04
	BEQ.b CODE_0DF60E
	LDA.b #$01
	STA.w $0D04,y
	STA.w $0D10,y
CODE_0DF60E:
	PLA
	AND.b #$02
	BEQ.b CODE_0DF61B
	LDA.b #$01
	STA.w $0D08,y
	STA.w $0D14,y
CODE_0DF61B:
	LDX.b $9E
	RTS

;--------------------------------------------------------------------

DATA_0DF61E:
	db $20,$28,$C8,$18,$00,$40,$50,$58
	db $80,$88,$B8,$78,$60,$A0,$B0,$B8

DATA_0DF62E:
	db $00,$01,$02,$03,$04,$05,$06,$07
	db $00,$01,$02,$03,$04,$05,$06,$07
	db $00,$01,$02,$03,$04,$05,$06,$07
	db $00,$01,$02,$03,$04,$05,$06,$07
	db $00,$01,$02,$03,$04,$05,$06,$07
	db $00,$01,$02,$03,$04,$05,$06,$07
	db $00,$01,$02,$03,$04,$05,$06,$07
	db $00,$01,$02,$03,$04,$05,$06,$07
	db $00,$01,$02,$03,$04,$05,$06,$07
	db $00,$01,$02,$03,$04,$05,$06,$07
	db $00,$01,$02,$03,$04,$05,$06,$07
	db $00,$01,$02,$03,$04,$05,$06,$07
	db $00,$01,$02,$03,$04,$05,$06,$07
	db $00,$01,$02,$03,$04,$05,$06,$07
	db $00,$01,$02,$03,$04,$05,$06,$07
	db $00,$01,$02,$03,$04,$05,$06,$07
	db $00,$01,$02,$03,$04,$05,$06,$07
	db $00,$01,$02,$03,$04,$05,$06,$07
	db $00,$01,$02,$03,$04,$05,$06,$07
	db $00,$01,$02,$03,$04,$05,$06,$07
	db $00,$01,$02,$03,$04,$05,$06,$07
	db $00,$01,$02,$03,$04,$05,$06,$07
	db $00,$01,$02,$03,$04,$05,$06,$07
	db $00,$01,$02,$03,$04,$05,$06,$07
	db $00,$01,$02,$03,$04,$05,$06,$07
	db $00,$01,$02,$03,$04,$05,$06,$07

UNK_0DF6FE:
	db $9E,$9F

;--------------------------------------------------------------------

CODE_0DF700:
	LDA.w $0E41
	BNE.b CODE_0DF722
	LDA.w $06D5
	CMP.b #$18
	BEQ.b CODE_0DF710
	CMP.b #$78
	BNE.b CODE_0DF726
CODE_0DF710:
	INC.w $0E41
	BRA.b CODE_0DF71F

CODE_0DF715:
	LDA.w $0202
	AND.b #$02
	BNE.b CODE_0DF726
	INC.w $0E41
CODE_0DF71F:
	STZ.w $0E40
CODE_0DF722:
	JSL.l CODE_0FE5A4
CODE_0DF726:
	LDA.b $0F
	CMP.b #$03
	BEQ.b CODE_0DF736
	LDA.w $07AE
	BEQ.b CODE_0DF736
	LDA.b $09
	LSR
	BCS.b CODE_0DF7AC
CODE_0DF736:
	LDA.b $0F
	CMP.b #$0B
	BEQ.b CODE_0DF7B7
	LDA.w $070B
	BNE.b CODE_0DF7B2
	LDY.w $0704
	BEQ.b CODE_0DF7AD
	LDA.b $28
	CMP.b #$00
	BEQ.b CODE_0DF7AD
	JSR.w CODE_0DF7AD
	TAX
	LDY.w $0B45
	LDA.w $0202
	LSR
	BCS.b CODE_0DF75D
	INY
	INY
	INY
	INY
CODE_0DF75D:
	LDA.w $0754
	BNE.b CODE_0DF7AC
	LDA.w $0028
	CMP.b #$03
	BEQ.b CODE_0DF7AC
	LDA.w $000F
	CMP.b #$0B
	BEQ.b CODE_0DF7AC
	PHX
	LDA.w $0202
	CMP.b #$02
	BEQ.b CODE_0DF787
	LDA.w $0810,y
	SEC
	SBC.b #$08
	STA.w $0810,y
	BCS.b CODE_0DF787
	LDA.b #$03
	BRA.b CODE_0DF789

CODE_0DF787:
	LDA.b #$02
CODE_0DF789:
	STA.w $0C10,y
	LDA.w $06D5
	SEC
	SBC.b #$28
	LSR
	LSR
	CLC
	ADC.b #$08
	STA.w $0812,y
	LDA.w $0819,y
	CMP.b #$F0
	BCC.b CODE_0DF7A6
	LDA.b #$F0
	STA.w $0811,y
CODE_0DF7A6:
	LDA.b #$F0
	STA.w $0819,y
	PLX
CODE_0DF7AC:
	RTS

;--------------------------------------------------------------------

CODE_0DF7AD:
	JSR.w CODE_0DFBB8
	BRA.b CODE_0DF7BC

CODE_0DF7B2:
	JSR.w CODE_0DFC76
	BRA.b CODE_0DF7BC

CODE_0DF7B7:
	LDY.b #$0E
	LDA.w DATA_0DF61E,y
CODE_0DF7BC:
	STA.w $06D5
	LDA.w $03CE
	BNE.b CODE_0DF7D7
	LDA.w $0218
	BEQ.b CODE_0DF7DA
	LDA.w $0754
	BNE.b CODE_0DF7D5
	LDA.b #$D8
	STA.w $06D5
	BRA.b CODE_0DF7DA

CODE_0DF7D5:
	LDA.b #$E0
CODE_0DF7D7:
	STA.w $06D5
CODE_0DF7DA:
	LDA.b #$04
	JSR.w CODE_0DFB6E
	JSR.w CODE_0DFCAF
	LDA.b $02
	CMP.b #$03
	BNE.b CODE_0DF802
	LDA.w $0219
	SEC
	SBC.b $42
	LDA.b $78
	SBC.b $43
	BEQ.b CODE_0DF802
	LDA.b #$01
	STA.w $0CD0
	STA.w $0CD8
	STA.w $0CE0
	STA.w $0CE8
CODE_0DF802:
	LDA.w $0711
	BEQ.b CODE_0DF832
	LDY.b #$00
	LDA.w $0789
	CMP.w $0711
	STY.w $0711
	BCS.b CODE_0DF832
	STA.w $0711
	LDA.b $28
	CMP.b #$01
	BEQ.b CODE_0DF825
	LDY.b #$07
	LDA.w DATA_0DF61E,y
	STA.w $06D5
CODE_0DF825:
	LDY.b #$04
	LDA.b $5D
	ORA.b $0C
	BEQ.b CODE_0DF82E
	DEY
CODE_0DF82E:
	TYA
	JSR.w CODE_0DFB6E
CODE_0DF832:
	LDA.w $03D0
	LSR
	LSR
	LSR
	LSR
	STA.b $00
	LDX.b #$03
	LDA.w $0B45
	CLC
	ADC.b #$18
	TAY
CODE_0DF844:
	LDA.b #$F0
	LSR.b $00
	BCC.b CODE_0DF84D
	JSR.w CODE_0DEB8A
CODE_0DF84D:
	TYA
	SEC
	SBC.b #$08
	TAY
	DEX
	BPL.b CODE_0DF844
	JSR.w CODE_0DFCCC
	RTS

;--------------------------------------------------------------------

DATA_0DF859:
	db $40,$01,$2E,$60,$FF,$04

CODE_0DF85F:
	JSR.w CODE_0D841C
	LDA.b #$D0
	STA.w $06D5
	JSL.l CODE_00C000
	LDX.b #$05
CODE_0DF86D:
	LDA.w DATA_0DF859,x
	STA.b $02,x
	DEX
	BPL.b CODE_0DF86D
	LDX.b #$B8
	LDY.b #$D0
	JSR.w CODE_0DFB94
	JSR.w CODE_0DF883
	JSR.w CODE_0D9ED1
	RTS

CODE_0DF883:
	PHX
	PHY
	LDA.b #$F0
CODE_0DF887:
	STA.w $0801,y
	STA.w $0901,y
	INY
	BNE.b CODE_0DF887
	JSR.w CODE_0DF999
	LDX.b #$00
	LDA.b #$30
	STA.b $E2
CODE_0DF899:
	JSR.w CODE_0DF920
	CMP.b #$02
	BNE.b CODE_0DF8D9
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$16
	BEQ.b CODE_0DF8CB
	PHY
	PHX
	JSR.w CODE_0DEE6F
	PLX
	LDA.w $0B46,x
	TAY
	LDA.b #$00
	STA.w $0D00,y
	STA.w $0D04,y
	STA.w $0D08,y
	STA.w $0D0C,y
	STA.w $0D10,y
	STA.w $0D14,y
	LDA.b $43
	STA.b $79,x
	PLY
	BRA.b CODE_0DF8D0

CODE_0DF8CB:
	JSR.w CODE_0DFA84
	BRA.b CODE_0DF913

CODE_0DF8D0:
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$12
	BNE.b CODE_0DF8D9
	JSR.w CODE_0DFA2D
CODE_0DF8D9:
	INY
	INX
	CPX.b #$05
	BNE.b CODE_0DF899
	LDA.b $5C
	CMP.b #$03
	BEQ.b CODE_0DF913
	LDX.b #$00
CODE_0DF8E7:
	LDA.w $0902,x
	CMP.w $0906,x
	BNE.b CODE_0DF901
	LDA.w $0903,x
	AND.b #$3F
	STA.w $0903,x
	LDA.w $0907,x
	ORA.b #$40
	STA.w $0907,x
	BRA.b CODE_0DF907

CODE_0DF901:
	LDA.w $0907,x
	STA.w $0903,x
CODE_0DF907:
	INX
	INX
	INX
	INX
	INX
	INX
	INX
	INX
	CPX.b #$00
	BNE.b CODE_0DF8E7
CODE_0DF913:
	LDX.b #$04
CODE_0DF915:
	STZ.b !RAM_SMBLL_NorSpr_SpriteID,x
	DEX
	BPL.b CODE_0DF915
	STZ.w $0E85
	PLY
	PLX
	RTS

CODE_0DF920:
	STZ.w $0E85
	PHX
	TYX
	LDA.w $075F
	CMP.b #$08
	BCC.b CODE_0DF932
	LDA.l DATA_0FF900,x
	BRA.b CODE_0DF936

CODE_0DF932:
	LDA.l DATA_0FF85B,x
CODE_0DF936:
	PLX
	CMP.b #$FF
	BNE.b CODE_0DF945
	LDA.b $E2
	CLC
	ADC.b #$18
	STA.b $E2
	JMP.w CODE_0DF998

CODE_0DF945:
	STZ.w $00BC,x
	STA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$0E
	BEQ.b CODE_0DF962
	CMP.b #$0F
	BEQ.b CODE_0DF962
	CMP.b #$10
	BEQ.b CODE_0DF962
	CMP.b #$14
	BEQ.b CODE_0DF962
	CMP.b #$08
	BEQ.b CODE_0DF962
	LDA.b #$98
	BRA.b CODE_0DF964

CODE_0DF962:
	LDA.b #$88
CODE_0DF964:
	STA.w $0238,x
	LDA.b $E2
	CLC
	ADC.b #$18
	STA.b $E2
	STA.w $03AE
	LDA.b #$20
	STA.w $0257,x
	PHX
	TYX
	LDA.w $075F
	CMP.b #$08
	BCC.b CODE_0DF985
	LDA.l DATA_0FF900,x
	BRA.b CODE_0DF989

CODE_0DF985:
	LDA.l DATA_0FF85B,x
CODE_0DF989:
	PLX
	CMP.b #$05
	BNE.b CODE_0DF994
	STA.w $0E85
	JSR.w CODE_0DFB4C
CODE_0DF994:
	LDA.b #$02
	STA.b $47,x
CODE_0DF998:
	RTS

;--------------------------------------------------------------------

CODE_0DF999:
	LDA.w $075F
	ASL
	ASL
	CLC
	ADC.w $075F
	CLC
	ADC.w $0760
	TAX
	LDA.l DATA_0E8EB3,x
	STA.w $0E22
	LDA.l DATA_0E8EF4,x
	STA.w $0E21
	PHA
	CMP.b #$21
	BCC.b CODE_0DF9C0
	SEC
	SBC.b #$21
	STA.w $0E21
CODE_0DF9C0:
	ASL
	ASL
	CLC
	ADC.w $0E21
	TAY
	PLA
	STA.w $0E21
	LDA.w $071C
	STA.b $9C
	LDA.w $071A
	STA.b $9D
	INC.b $9B
	STZ.w $071A
	STZ.w $073F
	STZ.w $0EFD
	STZ.w $0EFE
	STZ.w $0EEE
	STZ.w $0EEF
	STZ.w !REGISTER_BG1HorizScrollOffset
	STZ.w !REGISTER_BG1HorizScrollOffset
	STZ.w !REGISTER_BG2HorizScrollOffset
	STZ.w !REGISTER_BG2HorizScrollOffset
	STZ.w !REGISTER_BG3HorizScrollOffset
	STZ.w !REGISTER_BG3HorizScrollOffset
	RTS

;--------------------------------------------------------------------

DATA_0DF9FC:
	db $DC,$DC,$DD,$DD,$DE,$DE

CODE_0DFA02:
	LDA.w DATA_0DF9FC
	STA.w $0962
	LDA.w DATA_0DF9FC+$01
	STA.w $0966
	LDA.w DATA_0DF9FC+$02
	STA.w $096A
	LDA.w DATA_0DF9FC+$03
	STA.w $096E
	LDA.w DATA_0DF9FC+$04
	STA.w $0972
	LDA.w DATA_0DF9FC+$05
	STA.w $0976
	RTS

;--------------------------------------------------------------------

DATA_0DFA27:
	db $B9,$B8,$BB,$BA,$BC,$BC

CODE_0DFA2D:
	PHY
	LDA.b #$03
	STA.b $03
	LDA.w $0238,x
	SEC
	SBC.b #$28
	STA.w $0238,x
	STZ.b $E3
	LDY.b #$00
CODE_0DFA3F:
	LDA.w $03AE
	STA.w $0990,y
	CLC
	ADC.b #$08
	STA.w $0994,y
	LDA.w $0238,x
	STA.w $0991,y
	STA.w $0995,y
	CLC
	ADC.b #$08
	STA.w $0238,x
	LDA.b #$2A
	STA.w $0993,y
	STA.w $0997,y
	PHX
	LDX.b $E3
	LDA.w DATA_0DFA27,x
	STA.w $0992,y
	LDA.w DATA_0DFA27+$01,x
	STA.w $0996,y
	INC.b $E3
	INC.b $E3
	PLX
	INY
	INY
	INY
	INY
	INY
	INY
	INY
	INY
	DEC.b $03
	BNE.b CODE_0DFA3F
	PLY
	RTS

;--------------------------------------------------------------------

CODE_0DFA84:
	PHY
	PHX
	LDA.w $0238,x
	STA.w $03B9
	SEC
	SBC.b #$08
	STA.w $03B9
	LDA.w $03AE
	SEC
	SBC.b #$10
	STA.w $03AE
	LDY.b #$90
	LDX.b #$00
	LDA.w $03AE
	STA.w $0900,y
	STA.w $0908,y
	CLC
	ADC.b #$08
	STA.w $0910,y
	CLC
	ADC.b #$08
	STA.w $0904,y
	STA.w $090C,y
	STA.w $0914,y
	LDA.w $03B9
	STA.w $0901,y
	STA.w $0905,y
	CLC
	ADC.b #$10
	STA.w $0909,y
	STA.w $090D,y
	SEC
	SBC.b #$18
	STA.w $0911,y
	STA.w $0915,y
	LDA.b #$00
	STA.w $0C10,y
	STA.w $0C14,y
	LDA.b #$02
	STA.w $0D00,y
	STA.w $0D04,y
	STA.w $0D08,y
	STA.w $0D0C,y
	LDA.b #$61
	STA.w $0903,y
	STA.w $0907,y
	STA.w $090B,y
	STA.w $090F,y
	STA.w $0913,y
	STA.w $0917,y
	LDA.b #$C5
	STA.w $0912,y
	LDA.b #$C4
	STA.w $0916,y
	LDA.b #$EE
	STA.w $0902,y
	LDA.b #$C0
	STA.w $0906,y
	LDA.b #$E2
	STA.w $090A,y
	LDA.b #$E0
	STA.w $090E,y
	LDA.b #$70
	STA.w $09F0
	LDA.b #$78
	STA.w $09F4
	LDA.b #$98
	STA.w $09F1
	STA.w $09F5
	LDA.b #$86
	STA.w $09F2
	LDA.b #$87
	STA.w $09F6
	LDA.b #$21
	STA.w $09F3
	STA.w $09F7
	LDA.b #$02
	STA.w $0DF0
	STA.w $0DF4
	PLX
	PLY
	RTS

;--------------------------------------------------------------------

CODE_0DFB4C:
	LDA.w $0238,x
	SEC
	SBC.b #$0A
	STA.w $0881
	LDA.w $03AE
	CLC
	ADC.b #$03
	STA.w $0880
	LDA.b #$2A
	STA.w $0883
	LDA.b #$44
	STA.w $0882
	LDA.b #$02
	STA.w $0C80
	RTS

;--------------------------------------------------------------------

CODE_0DFB6E:
	STA.b $07
	LDA.w $03AD
	STA.w $0755
	STA.b $05
	LDA.w $03B8
	STA.b $02
	LDA.w $0202
	STA.b $03
	JSL.l CODE_00C000
	LDA.w $06D5
	AND.b #$07
	TAX
	LDA.w $0256
	STA.b $04
	LDY.w $0B45
CODE_0DFB94:
	LDA.w DATA_0DF62E,x
	STA.b $00
	LDA.w DATA_0DF62E+$01,x
	JSR.w CODE_0DF2FE
	DEC.b $07
	BNE.b CODE_0DFB94
	LDA.b $05
	CMP.b #$F8
	BCC.b CODE_0DFBB7
	LDA.b #$01
	STA.w $0CD0
	STA.w $0CD8
	STA.w $0CE0
	STA.w $0CE8
CODE_0DFBB7:
	RTS

;--------------------------------------------------------------------

CODE_0DFBB8:
	LDA.b $28
	CMP.b #$03
	BEQ.b CODE_0DFC0C
	CMP.b #$02
	BEQ.b CODE_0DFBFE
	CMP.b #$01
	BNE.b CODE_0DFBD6
	LDA.w $0704
	BNE.b CODE_0DFC17
	LDY.b #$06
	LDA.w $0714
	BNE.b CODE_0DFBF4
	LDY.b #$00
	BRA.b CODE_0DFBF4

CODE_0DFBD6:
	LDY.b #$06
	LDA.w $0714
	BNE.b CODE_0DFBF4
	LDY.b #$02
	LDA.b $5D
	ORA.b $0C
	BEQ.b CODE_0DFBF4
	LDA.w $0700
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	CMP.b #$0A
else
	CMP.b #$09
endif
	BCC.b CODE_0DFC05
	LDA.b $46
	AND.w $0202
	BNE.b CODE_0DFC05
	INY
CODE_0DFBF4:
	JSR.w CODE_0DFC57
	STZ.w $070D
	LDA.w DATA_0DF61E,y
	RTS

CODE_0DFBFE:
	LDY.b #$04
	JSR.w CODE_0DFC57
	BRA.b CODE_0DFC29

CODE_0DFC05:
	LDY.b #$04
	JSR.w CODE_0DFC57
	BRA.b CODE_0DFC2F

CODE_0DFC0C:
	LDY.b #$05
	LDA.b $A0
	BEQ.b CODE_0DFBF4
	JSR.w CODE_0DFC57
	BRA.b CODE_0DFC33

CODE_0DFC17:
	LDY.b #$01
	JSR.w CODE_0DFC57
	LDA.w $078A
	ORA.w $070D
	BNE.b CODE_0DFC2F
	LDA.b $0A
	ASL
	BCS.b CODE_0DFC2F
CODE_0DFC29:
	LDA.w $070D
	JMP.w CODE_0DFC96

CODE_0DFC2F:
	LDA.b #$03
	BRA.b CODE_0DFC35

CODE_0DFC33:
	LDA.b #$02
CODE_0DFC35:
	STA.b $00
	JSR.w CODE_0DFC29
	PHA
	LDA.w $0789
	BNE.b CODE_0DFC55
	LDA.w $070C
	STA.w $0789
	LDA.w $070D
	CLC
	ADC.b #$01
	CMP.b $00
	BCC.b CODE_0DFC52
	LDA.b #$00
CODE_0DFC52:
	STA.w $070D
CODE_0DFC55:
	PLA
	RTS

CODE_0DFC57:
	LDA.w $0754
	BEQ.b CODE_0DFC61
	TYA
	CLC
	ADC.b #$08
	TAY
CODE_0DFC61:
	RTS

;--------------------------------------------------------------------

DATA_0DFC62:
	db $00,$01,$00,$01,$00,$01,$02,$00
	db $01,$02,$02,$00,$02,$00,$02,$00
	db $02,$00,$02,$00

CODE_0DFC76:
	LDY.w $070D
	LDA.b $09
	AND.b #$03
	BNE.b CODE_0DFC8C
	INY
	CPY.b #$0A
	BCC.b CODE_0DFC89
	LDY.b #$00
	STY.w $070B
CODE_0DFC89:
	STY.w $070D
CODE_0DFC8C:
	LDA.w $0754
	BNE.b CODE_0DFC9D
	LDA.w DATA_0DFC62,y
	LDY.b #$0F
CODE_0DFC96:
	ASL
	ASL
	ASL
	ADC.w DATA_0DF61E,y
	RTS

CODE_0DFC9D:
	TYA
	CLC
	ADC.b #$0A
	TAX
	LDY.b #$09
	LDA.w DATA_0DFC62,x
	BNE.b CODE_0DFCAB
	LDY.b #$01
CODE_0DFCAB:
	LDA.w DATA_0DF61E,y
	RTS

;--------------------------------------------------------------------

CODE_0DFCAF:
	LDY.w $0B45
	LDA.b $0F
	CMP.b #$0B
	BEQ.b CODE_0DFCCB
	LDA.w $06D5
	CMP.b #$50
	BEQ.b CODE_0DFCCB
	CMP.b #$B8
	BEQ.b CODE_0DFCCB
	CMP.b #$C0
	BEQ.b CODE_0DFCCB
	CMP.b #$C8
	BNE.b CODE_0DFCCB
CODE_0DFCCB:
	RTS

;--------------------------------------------------------------------

CODE_0DFCCC:
	LDA.w $0E4E
	BEQ.b CODE_0DFD28
	LDX.b #$00
CODE_0DFCD3:
	LDA.w $08D0,x
	STA.w $09E0,x
	INX
	CPX.b #$20
	BNE.b CODE_0DFCD3
	LDA.b #$F0
	STA.w $08D1
	STA.w $08D5
	STA.w $08D9
	STA.w $08DD
	STA.w $08E1
	STA.w $08E5
	STA.w $08E9
	STA.w $08ED
	LDA.w $0CD0
	STA.w $0DE0
	LDA.w $0CD4
	STA.w $0DE4
	LDA.w $0CD8
	STA.w $0DE8
	LDA.w $0CDC
	STA.w $0DEC
	LDA.w $0CE0
	STA.w $0DF0
	LDA.w $0CE4
	STA.w $0DF4
	LDA.w $0CE8
	STA.w $0DF8
	LDA.w $0CEC
	STA.w $0DFC
CODE_0DFD28:
	RTS

;--------------------------------------------------------------------

CODE_0DFD29:
	LDX.b #$00
	LDY.b #$00
	JMP.w CODE_0DFD40

CODE_0DFD30:
	LDY.b #$01
	JSR.w CODE_0DFDDA
	LDY.b #$03
	BRA.b CODE_0DFD40

CODE_0DFD39:
	LDY.b #$00
	JSR.w CODE_0DFDDA
	LDY.b #$02
CODE_0DFD40:
	JSR.w CODE_0DFD6E
	LDX.b $9E
	RTS

;--------------------------------------------------------------------

CODE_0DFD46:
	LDY.b #$02
	JSR.w CODE_0DFDDA
	LDY.b #$06
	BRA.b CODE_0DFD40

;--------------------------------------------------------------------

CODE_0DFD4F:
	LDA.b #$01
	LDY.b #$01
	JMP.w CODE_0DFD62

;--------------------------------------------------------------------

CODE_0DFD56:
	LDA.b #$0D
	LDY.b #$04
	JSR.w CODE_0DFD62
	INX
	INX
	LDA.b #$0D
	INY
CODE_0DFD62:
	STX.b $00
	CLC
	ADC.b $00
	TAX
	JSR.w CODE_0DFD6E
	LDX.b $9E
	RTS

;--------------------------------------------------------------------

CODE_0DFD6E:
	LDA.w $0237,x
	STA.w $03B8,y
	LDA.b $0E
	BEQ.b CODE_0DFD84
	LDA.w $0219
	BNE.b CODE_0DFD84
	LDA.b #$28
	STA.w $0219
	BRA.b CODE_0DFD96

CODE_0DFD84:
	LDA.w $0219,x
	SEC
	SBC.w $071C
	STA.w $03AD,y
	LDA.b $78,x
	SBC.w $071A
	STA.w $03C1,y
CODE_0DFD96:
	PHY
	TYA
	ASL
	TAY
	LDA.w $0219,x
	STA.b $E4
	LDA.w $0078,x
	STA.b $E5
	REP.b #$20
	LDA.b $E4
	SEC
	SBC.b $42
	STA.w $0E87,y
	SEP.b #$20
	PLY
	RTS

;--------------------------------------------------------------------

CODE_0DFDB2:
	LDX.b #$00
	LDY.b #$00
	JMP.w CODE_0DFDF1

CODE_0DFDB9:
	LDY.b #$00
	JSR.w CODE_0DFDDA
	LDY.b #$02
	JMP.w CODE_0DFDF1

CODE_0DFDC3:
	LDY.b #$01
	JSR.w CODE_0DFDDA
	LDY.b #$03
	JMP.w CODE_0DFDF1

CODE_0DFDCD:
	LDY.b #$02
	JSR.w CODE_0DFDDA
	LDY.b #$06
	JMP.w CODE_0DFDF1

DATA_0DFDD7:
	db $0B,$1A,$11

CODE_0DFDDA:
	TXA
	CLC
	ADC.w DATA_0DFDD7,y
	TAX
	RTS

CODE_0DFDE1:
	LDA.b #$01
	LDY.b #$01
	BRA.b CODE_0DFDEB

CODE_0DFDE7:
	LDA.b #$0D
	LDY.b #$04
CODE_0DFDEB:
	STX.b $00
	CLC
	ADC.b $00
	TAX
CODE_0DFDF1:
	TYA
	PHA
	JSR.w CODE_0DFE15
	ASL
	ASL
	ASL
	ASL
	ORA.b $00
	STA.b $00
	PLA
	TAY
	LDA.b $00
	STA.w $03D0,y
	LSR
	LSR
	PHA
	AND.b #$01
	STA.w $0E08,y
	PLA
	LSR
	STA.w $0E00,y
	LDX.b $9E
	RTS

;--------------------------------------------------------------------

CODE_0DFE15:
	JSR.w CODE_0DFE34
	LSR
	LSR
	LSR
	LSR
	STA.b $00
	JMP.w CODE_0DFE78

;--------------------------------------------------------------------

DATA_0DFE21:
	db $7F,$3F,$1F,$0F,$07,$03,$01,$00
	db $80,$C0,$E0,$F0,$F8,$FC,$FE,$FF

DATA_0DFE31:
	db $07,$0F,$07

CODE_0DFE34:
	STX.b $04
	LDY.b #$01
CODE_0DFE38:
	LDA.w $071C,y
	SEC
	SBC.w $0219,x
	STA.b $07
	LDA.w $071A,y
	SBC.b $78,x
	LDX.w DATA_0DFE31,y
	CMP.b #$00
	BMI.b CODE_0DFE5D
	LDX.w DATA_0DFE31+$01,y
	CMP.b #$01
	BPL.b CODE_0DFE5D
	LDA.b #$38
	STA.b $06
	LDA.b #$08
	JSR.w CODE_0DFEAD
CODE_0DFE5D:
	LDA.w DATA_0DFE21,x
	LDX.b $04
	CMP.b #$00
	BNE.b CODE_0DFE69
	DEY
	BPL.b CODE_0DFE38
CODE_0DFE69:
	RTS

;--------------------------------------------------------------------

DATA_0DFE6A:
	db $00,$08,$0C,$0E,$0F,$07,$03,$01
	db $00

DATA_0DFE73:
	db $04,$00,$04

DATA_0DFE76:
	db $FF,$00

CODE_0DFE78:
	STX.b $04
	LDY.b #$01
CODE_0DFE7C:
	LDA.w DATA_0DFE76,y
	SEC
	SBC.w $0237,x
	STA.b $07
	LDA.b #$01
	SBC.b $BB,x
	LDX.w DATA_0DFE73,y
	CMP.b #$00
	BMI.b CODE_0DFEA0
	LDX.w DATA_0DFE73+$01,y
	CMP.b #$01
	BPL.b CODE_0DFEA0
	LDA.b #$20
	STA.b $06
	LDA.b #$04
	JSR.w CODE_0DFEAD
CODE_0DFEA0:
	LDA.w DATA_0DFE6A,x
	LDX.b $04
	CMP.b #$00
	BNE.b CODE_0DFEAC
	DEY
	BPL.b CODE_0DFE7C
CODE_0DFEAC:
	RTS

;--------------------------------------------------------------------

CODE_0DFEAD:
	STA.b $05
	LDA.b $07
	CMP.b $06
	BCS.b CODE_0DFEC1
	LSR
	LSR
	LSR
	AND.b #$07
	CPY.b #$01
	BCS.b CODE_0DFEC0
	ADC.b $05
CODE_0DFEC0:
	TAX
CODE_0DFEC1:
	RTS

;--------------------------------------------------------------------

CODE_0DFEC2:
	LDA.b $79,x
	STA.w $0E15
	LDA.w $021A,x
	STA.w $0E14
	RTS

;--------------------------------------------------------------------

CODE_0DFECE:
	LDA.w $0E17
	STA.w $0E15
	LDA.w $0E16
	STA.w $0E14
	RTS

;--------------------------------------------------------------------

CODE_0DFEDB:
	LDA.b #$06
	STA.b $04
	REP.b #$20
	LDA.w $0E14
	SEC
	SBC.b $42
	STA.w $0E12
	SEP.b #$20
	LDA.w $0E13
	BNE.b CODE_0DFEF5
	LDA.b #$00
	BRA.b CODE_0DFEF7

CODE_0DFEF5:
	LDA.b #$01
CODE_0DFEF7:
	STA.w $0D00,y
	RTS

;--------------------------------------------------------------------

CODE_0DFEFB:
	REP.b #$20
	LDA.w $0E14
	SEC
	SBC.b $42
	STA.w $0E12
	SEP.b #$20
	LDA.w $0E13
	BNE.b CODE_0DFF11
	LDA.b #$00
	BRA.b CODE_0DFF13

CODE_0DFF11:
	LDA.b #$01
CODE_0DFF13:
	STA.w $0D10,y
	STA.w $0D08,y
	STA.w $0D00,y
	RTS

;--------------------------------------------------------------------

CODE_0DFF1D:
	REP.b #$20
	LDA.w $0E14
	SEC
	SBC.b $42
	STA.w $0E12
	SEP.b #$20
	LDA.w $0E13
	BNE.b CODE_0DFF33
	LDA.b #$00
	BRA.b CODE_0DFF35

CODE_0DFF33:
	LDA.b #$01
CODE_0DFF35:
	STA.w $0C08,y
	STA.w $0C00,y
	RTS


;--------------------------------------------------------------------

CODE_0DFF3C:
	STA.w $0C00,y
	STA.w $0C08,y
	RTS

;--------------------------------------------------------------------

CODE_0DFF43:
	REP.b #$20
	PLA
	CLC
	ADC.b $04
	STA.b $04
	PHA
	SEP.b #$20
	LDA.b #$01
	RTS

;--------------------------------------------------------------------

CODE_0DFF51:
	REP.b #$20
	LDA.w $0E14
	CLC
	ADC.w #$0008
	STA.w $0E14
	SEP.b #$20
	INY
	INY
	INY
	INY
	RTS

;--------------------------------------------------------------------

CODE_0DFF64:
	LDA.b $03
	LSR
	LSR
	LDA.b $00
	BCC.b CODE_0DFF78
	STA.w $0806,y
	LDA.b $01
	STA.w $0802,y
	LDA.b #$40
	BNE.b CODE_0DFF82
CODE_0DFF78:
	STA.w $0802,y
	LDA.b $01
	STA.w $0806,y
	LDA.b #$00
CODE_0DFF82:
	ORA.b $04
	STA.w $0803,y
	STA.w $0807,y
	LDA.b $02
	STA.w $0801,y
	STA.w $0805,y
	LDA.b $05
	STA.w $0800,y
	CLC
	ADC.b #$08
	STA.w $0804,y
	LDA.b $02
	CLC
	ADC.b #$08
	STA.b $02
	TYA
	CLC
	ADC.b #$08
	TAY
	INX
	INX
	RTS

;--------------------------------------------------------------------

CODE_0DFFAC:
	LDA.b $03
	LSR
	LSR
	LDA.b $00
	BCC.b CODE_0DFFC0
	STA.w $0906,y
	LDA.b $01
	STA.w $0902,y
	LDA.b #$40
	BNE.b CODE_0DFFCA

CODE_0DFFC0:
	STA.w $0902,y
	LDA.b $01
	STA.w $0906,y
	LDA.b #$00
CODE_0DFFCA:
	ORA.b $04
	STA.w $0903,y
	STA.w $0907,y
	LDA.b $02
	STA.w $0901,y
	STA.w $0905,y
	LDA.b $05
	STA.w $0900,y
	CLC
	ADC.b #$08
	STA.w $0904,y
	LDA.b $02
	CLC
	ADC.b #$08
	STA.b $02
	TYA
	CLC
	ADC.b #$08
	TAY
	INX
	INX
	RTS

if !Define_Global_ROMToAssemble&(!ROM_SMBLL_U) != $00
%FREE_BYTES(NULLROM, 17, $FF)
elseif !Define_Global_ROMToAssemble&(!ROM_SMBLL_E) != $00
%FREE_BYTES(NULLROM, 8, $FF)
elseif !Define_Global_ROMToAssemble&(!ROM_SMBLL_J) != $00
%FREE_BYTES(NULLROM, 58, $FF)
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
%FREE_BYTES(NULLROM, 20, $FF)
else
%FREE_BYTES(NULLROM, 12, $FF)
endif
%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro SMBLLBank0EMacros(StartBank, EndBank)
%BANK_START(<StartBank>)
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMBLL_J) != $00
	%FREE_BYTES(NULLROM, 1792, $FF)
endif

CODE_0E8000:
	LDA.b #$01
	STA.w $028C
	LDA.b #$03
	STA.w $0F0B
	STZ.w $028E
	STZ.w $0E67
if !Define_Global_ROMToAssemble&(!ROM_SMBLL_U|!ROM_SMBLL_E|!ROM_SMBLL_J) == $00
	LDA.l !SRAM_SMAS_Global_InitialSelectedLevel
	STA.w $0E24
	STA.l $7FFB01
	LDA.l !SRAM_SMAS_Global_InitialSelectedWorld
	STA.w $075F
	STA.l $7FFB00
	ASL
	ASL
	CLC
	ADC.l !SRAM_SMAS_Global_InitialSelectedLevel
	TAX
	LDA.l DATA_0FE06D,x
	STA.l !SRAM_SMAS_Global_InitialSelectedLevel
	STA.l $7FFB02
	STA.w $0760
endif
	LDA.b #$03
	STA.w !REGISTER_OAMSizeAndDataAreaDesignation
	LDA.b #$01
	STA.w !REGISTER_BG1AddressAndSize
	LDA.b #$09
	STA.w !REGISTER_BG2AddressAndSize
	LDA.b #$59
	STA.w !REGISTER_BG3AddressAndSize
	STZ.w !REGISTER_BG4AddressAndSize
	LDA.b #$11
	STA.w !REGISTER_BG1And2TileDataDesignation
	LDA.b #$05
	STA.w !REGISTER_BG3And4TileDataDesignation
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDA.b #!InitialScreenSettings_EnableOverscanFlag
	STA.w !REGISTER_InitialScreenSettings
else
	STZ.w !REGISTER_InitialScreenSettings
endif
	STZ.w $0770
	STZ.w $0772
	LDA.b #$00
	STA.l $7FFFFF
	STZ.w $073F
	STZ.w $0740
	STZ.w !REGISTER_BG1HorizScrollOffset
	STZ.w !REGISTER_BG1HorizScrollOffset
	STZ.w !REGISTER_BG1VertScrollOffset
	STZ.w !REGISTER_BG1VertScrollOffset
	STZ.w !REGISTER_BG2HorizScrollOffset
	STZ.w !REGISTER_BG2HorizScrollOffset
	STZ.w !REGISTER_BG2VertScrollOffset
	STZ.w !REGISTER_BG2VertScrollOffset
	STZ.w !REGISTER_BG3HorizScrollOffset
	STZ.w !REGISTER_BG3HorizScrollOffset
	STZ.w !REGISTER_BG3VertScrollOffset
	STZ.w !REGISTER_BG3VertScrollOffset
	LDA.b #$09
	STA.w !RAM_SMBLL_Global_BGModeAndTileSizeSettingMirror
	STZ.w $0E7E
	LDA.b #$10
	STA.w !RAM_SMBLL_Global_MainScreenLayersMirror
	STZ.w !RAM_SMBLL_Global_SubScreenLayersMirror
	STZ.w $1204
	STZ.w $1205
	STZ.w $1206
	STZ.w $1209
	LDA.b #$20
	STA.w $120A
	LDA.b #$20
	STA.w !RAM_SMBLL_Global_FixedColorData1Mirror
	LDA.b #$40
	STA.w !RAM_SMBLL_Global_FixedColorData2Mirror
	LDA.b #$80
	STA.w !RAM_SMBLL_Global_FixedColorData3Mirror
	STZ.w !RAM_SMBLL_Global_HDMAEnableMirror
	LDA.b #$80
	STA.w !RAM_SMBLL_Global_ScreenDisplayRegisterMirror
	STZ.w $0154
	STZ.w $15E5
	STZ.w $0E7F
	STZ.w $0776
	STA.w $0722
	STZ.w $0E67
	STZ.b $BA
	STZ.w $0EC9
	STZ.w $0ED6
	STZ.w $0EF9
	STZ.w $0ED4
	STZ.w !RAM_SMBLL_Global_UpdateEntirePaletteFlag
	STZ.w $0773
	STZ.w $028D
	REP.b #$20
	LDA.w #$0000
	STA.l $001000					;\ Optimization: Unnecessary long addressing.
	STA.l $001100					;/
	LDA.w #$FFFF
	STA.w $1702
	STA.l $7F0002
	STA.l $7F2002
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	STA.w $1620
endif
	PHD
	LDA.w #DMA[$00].Parameters
	TCD
	LDX.b #$80
	STX.w !REGISTER_VRAMAddressIncrementValue
	REP.b #$20
	LDA.w #$1000
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STA.b DMA[$00].Parameters
	LDA.w #SMBLL_UncompressedGFX_FG_GlobalTiles
	STA.b DMA[$00].SourceLo
	LDY.b #SMBLL_UncompressedGFX_FG_GlobalTiles>>16
	STY.b DMA[$00].SourceBank
	LDA.w #SMBLL_UncompressedGFX_FG_TitleLogo_End-SMBLL_UncompressedGFX_FG_GlobalTiles
	STA.b DMA[$00].SizeLo
	LDX.b #$01
	STX.w !REGISTER_DMAEnable
	REP.b #$20
	LDA.w #$6000
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #SMBLL_UncompressedGFX_Sprite_GlobalTiles
	STA.b DMA[$00].SourceLo
	LDY.b #SMBLL_UncompressedGFX_Sprite_GlobalTiles>>16
	STY.b DMA[$00].SourceBank
	LDA.w #$4000
	STA.b DMA[$00].SizeLo
	STX.w !REGISTER_DMAEnable
	LDA.w #$5000
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #SMBLL_UncompressedGFX_Layer3
	STA.b DMA[$00].SourceLo
	LDY.b #SMBLL_UncompressedGFX_Layer3>>16
	STY.b DMA[$00].SourceBank
	LDA.w #$0800
	STA.b DMA[$00].SizeLo
	STX.w !REGISTER_DMAEnable
	PLD
	SEP.b #$20
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	STZ.w $1608
	STZ.w $1609
	STZ.w $160F
	STZ.w $160E
	STZ.w $160A
	STA.w $160D
	LDA.b #$01
	STA.w $160C
endif
	RTL

;--------------------------------------------------------------------

CODE_0E8171:
	LDA.w $1680
	BMI.b CODE_0E819C
	BNE.b CODE_0E8187
	LDA.w $0FF6
	AND.b #$10
	BEQ.b CODE_0E819C
	INC.w $1680
	LDA.b #!Define_SMAS_Sound0060_Pause1
	STA.w !RAM_SMBLL_Global_SoundCh1
CODE_0E8187:
	DEC.w $0B9A
	DEC.w $0B9A
	LDA.w $0B9A
	BPL.b CODE_0E819C
	LDA.b #$0D
	STA.w $0772
	LDA.b #$01
	STA.w $07FC
CODE_0E819C:
	RTL

;--------------------------------------------------------------------

CODE_0E819D:
	JSL.l CODE_0FDA18
	LDA.w $075F
	CMP.b #$08
	BCS.b CODE_0E81C3
	LDA.b #$10
	STA.w $1680
	STZ.w $0760
	STZ.w $075C
	LDA.w !RAM_SMBLL_Level_NoWorld9Flag
	BEQ.b CODE_0E81C0
	LDA.b #$01
	STA.w $07FB
	INC.w $075F
CODE_0E81C0:
	INC.w $075F
CODE_0E81C3:
	LDA.b #$22
	STA.w $1204
	LDA.b #$02
	STA.w $1205
	INC.w $0772
	LDA.w $077A
	BEQ.b CODE_0E81E2
	LDA.b #$02
	STA.w $1208
	STZ.w $0776
	LDA.b #$04
	STA.w $1680
CODE_0E81E2:
	RTL

;--------------------------------------------------------------------

CODE_0E81E3:
	LDA.w !REGISTER_APUPort0
	BNE.b CODE_0E81F5
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMBLL_J) != $00
	LDA.b #$0C
else
	LDA.b #$0A
endif
	STA.w $0772
	LDA.w $1680
	ORA.b #$80
	STA.w $1680
CODE_0E81F5:
	RTL

;--------------------------------------------------------------------

CODE_0E81F6:
	LDA.w $0B9A
	CMP.b #$30
	BCC.b CODE_0E81FE
	RTL

CODE_0E81FE:
	PHB
	PHK
	PLB
	PHD
	REP.b #$30
	LDA.w #$0B00
	TCD
	STZ.b $0B84
	STZ.b $0B8E
	STZ.b $0B90
	STZ.b $0B92
	LDA.b $0B9A
	AND.w #$00FF
	ASL
	TAX
	LDA.l SMBLL_CircleHDMAData_DATA_00973E,x				; Note: Shared SMAS data
	STA.b $0B94
	LDA.w #$0078
	STA.b $0B96
	LDA.w #$00B0
	STA.b $0B98
CODE_0E8227:
	LDA.w #$0100
	STA.b $0B80
	STA.b $0B82
	LDA.b $0B90
	INC
	CMP.b $0B9A
	BCS.b CODE_0E826B
	LDA.b $0B92
	CLC
	ADC.b $0B94
	STA.b $0B92
	XBA
	AND.w #$00FF
	LSR
	SEP.b #$30
	TAX
	LDA.l SMBLL_CircleHDMAData_DATA_0096BD,x				; Note: Shared SMAS data
	STA.w !REGISTER_Multiplicand
	LDA.b $0B9A
	STA.w !REGISTER_Multiplier
	NOP #4
	LDA.w !REGISTER_ProductOrRemainderHi
	STA.b $0B88
	STZ.b $0B89
	REP.b #$30
	LDA.b $0B88
	CLC
	ADC.b $0B98
	STA.b $0B82
	LDA.b $0B98
	SEC
	SBC.b $0B88
	STA.b $0B80
CODE_0E826B:
	LDA.b $0B96
	SEC
	SBC.b $0B90
	DEC
	ASL
	STA.b $0B84
	TAX
	LDA.b $0B80
	TAY
	BMI.b CODE_0E8289
	AND.w #$FF00
	BEQ.b CODE_0E828C
	CMP.w #$0100
	BNE.b CODE_0E8289
	LDY.w #$00FF
	BRA.b CODE_0E828C

CODE_0E8289:
	LDY.w #$0000
CODE_0E828C:
	TYA
	AND.w #$00FF
	STA.b $0B86
	LDA.b $0B82
	TAY
	AND.w #$FF00
	BEQ.b CODE_0E829D
	LDY.w #$00FF
CODE_0E829D:
	TYA
	AND.w #$00FF
	XBA
	ORA.b $0B86
	STA.b $0B86
	CPX.w #$01C0
	BCS.b CODE_0E82B7
	CMP.w #$FFFF
	BNE.b CODE_0E82B3
	LDA.w #$00FF
CODE_0E82B3:
	STA.l $7FF000,x
CODE_0E82B7:
	LDA.b $0B96
	CLC
	ADC.b $0B90
	DEC
	ASL
	STA.b $0B8E
	CMP.w #$01C0
	BCS.b CODE_0E82D4
	TAX
	LDA.b $0B86
	CMP.w #$FFFF
	BNE.b CODE_0E82D0
	LDA.w #$00FF
CODE_0E82D0:
	STA.l $7FF000,x
CODE_0E82D4:
	INC.b $0B90
	LDA.b $0B84
	CMP.w #$01C0
	BCC.b CODE_0E82E4
	LDA.b $0B8E
	CMP.w #$01C0
	BCS.b CODE_0E82E7
CODE_0E82E4:
	JMP.w CODE_0E8227

CODE_0E82E7:
	SEP.b #$30
	INC.b $0B9A
	PLD
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0E82EE:
	SEP.b #$10
	LDX.b #$00
CODE_0E82F2:
	STZ.w $05D0,x
	STZ.w $05E0,x
	STZ.w $05F0,x
	STZ.w $0600,x
	STZ.w $0610,x
	STZ.w $0620,x
	STZ.w $0630,x
	STZ.w $0640,x
	STZ.w $0650,x
	STZ.w $0660,x
	STZ.w $0670,x
	STZ.w $0680,x
	STZ.w $0690,x
	INX
	TXA
	AND.b #$0F
	BNE.b CODE_0E82F2
	LDA.b #$66
	STA.w $0640
	STA.w $0641
	STA.w $0642
	STA.w $0673
	STA.w $0674
	STA.w $0675
	STA.w $0676
	STA.w $0649
	STA.w $064A
	STA.w $064B
	STA.w $064C
	STA.w $064D
	STA.w $064E
	LDA.b #$01
	STA.w $0EC9
	RTL

;--------------------------------------------------------------------

CODE_0E834E:
	STZ.b $F6
	REP.b #$30
	LDA.w $0EEC
	STA.b $F3
	STZ.b $F7
CODE_0E8359:
	LDX.b $F3
	SEP.b #$20
	LDA.l DATA_0E83D8,x
	CLC
	ROL
	ROL
	AND.b #$01
	STA.b $F5
	LDA.l DATA_0E83D8+$01,x
	ASL
	REP.b #$21
	LDX.b $F7
	ADC.b $F5
	AND.w #$00FF
	CMP.w #$0080
	BCC.b CODE_0E837E
	ORA.w #$FF00
CODE_0E837E:
	CLC
	ADC.w $0EFD
	CLC
	ADC.w #$0008
	STA.l $7F2000,x
	LDA.b $F3
	CLC
	ADC.w #$0010
	AND.w #$01FF
	STA.b $F3
	INC.b $F7
	INC.b $F7
	LDA.b $F7
	CMP.w #$0040
	BNE.b CODE_0E8359
	LDA.w $0EEC
	CLC
	ADC.w #$0004
	AND.w #$01FF
	STA.w $0EEC
	SEP.b #$30
	PHB
	LDA.b #$7F2000>>16
	PHA
	PLB
	REP.b #$20
	LDY.b #$3E
CODE_0E83B8:
	LDA.w $7F2000,y
	STA.w $7F2040,y
	STA.w $7F2080,y
	STA.w $7F20C0,y
	STA.w $7F2100,y
	STA.w $7F2140,y
	STA.w $7F2180,y
	STA.w $7F21C0,y
	DEY
	DEY
	BPL.b CODE_0E83B8
	SEP.b #$20
	PLB
	RTL

DATA_0E83D8:
	dw $0000,$FFFA,$FFF4,$FFEE,$FFE7,$FFE1,$FFDB,$FFD5
	dw $FFCF,$FFC8,$FFC2,$FFBC,$FFB6,$FFB0,$FFAA,$FFA4
	dw $FF9F,$FF99,$FF93,$FF8D,$FF88,$FF82,$FF7D,$FF78
	dw $FF72,$FF6D,$FF68,$FF63,$FF5E,$FF59,$FF55,$FF50
	dw $FF4B,$FF47,$FF43,$FF3F,$FF3B,$FF37,$FF33,$FF2F
	dw $FF2C,$FF28,$FF25,$FF22,$FF1F,$FF1C,$FF19,$FF16
	dw $FF14,$FF12,$FF0F,$FF0D,$FF0C,$FF0A,$FF08,$FF07
	dw $FF05,$FF04,$FF03,$FF02,$FF02,$FF01,$FF01,$FF01
	dw $FF01,$FF01,$FF01,$FF01,$FF02,$FF02,$FF03,$FF04
	dw $FF05,$FF07,$FF08,$FF0A,$FF0C,$FF0D,$FF0F,$FF12
	dw $FF14,$FF16,$FF19,$FF1C,$FF1F,$FF22,$FF25,$FF28
	dw $FF2C,$FF2F,$FF33,$FF37,$FF3B,$FF3F,$FF43,$FF47
	dw $FF4B,$FF50,$FF55,$FF59,$FF5E,$FF63,$FF68,$FF6D
	dw $FF72,$FF78,$FF7D,$FF82,$FF88,$FF8D,$FF93,$FF99
	dw $FF9F,$FFA4,$FFAA,$FFB0,$FFB6,$FFBC,$FFC2,$FFC8
	dw $FFCF,$FFD5,$FFDB,$FFE1,$FFE7,$FFEE,$FFF4,$FFFA
	dw $0000,$0006,$000C,$0012,$0019,$001F,$0025,$002B
	dw $0031,$0038,$003E,$0044,$004A,$0050,$0056,$005C
	dw $0061,$0067,$006D,$0073,$0078,$007E,$0083,$0088
	dw $008E,$0093,$0098,$009D,$00A2,$00A7,$00AB,$00B0
	dw $00B5,$00B9,$00BD,$00C1,$00C5,$00C9,$00CD,$00D1
	dw $00D4,$00D8,$00DB,$00DE,$00E1,$00E4,$00E7,$00EA
	dw $00EC,$00EE,$00F1,$00F3,$00F4,$00F6,$00F8,$00F9
	dw $00FB,$00FC,$00FD,$00FE,$00FE,$00FF,$00FF,$00FF
	dw $00FF,$00FF,$00FF,$00FF,$00FE,$00FE,$00FD,$00FC
	dw $00FB,$00F9,$00F8,$00F6,$00F4,$00F3,$00F1,$00EE
	dw $00EC,$00EA,$00E7,$00E4,$00E1,$00DE,$00DB,$00D8
	dw $00D4,$00D1,$00CD,$00C9,$00C5,$00C1,$00BD,$00B9
	dw $00B5,$00B0,$00AB,$00A7,$00A2,$009D,$0098,$0093
	dw $008E,$0088,$0083,$007E,$0078,$0073,$006D,$0067
	dw $0061,$005C,$0056,$0050,$004A,$0044,$003E,$0038
	dw $0031,$002B,$0025,$001F,$0019,$0012,$000C,$0006

;--------------------------------------------------------------------

CODE_0E85D8:
	PHB
	PHK
	PLB
	BRA.b CODE_0E85E8

CODE_0E85DD:
	PHB
	PHK
	PLB
	LDA.w $0EDC
	BEQ.b CODE_0E8614
	JSR.w CODE_0E8706
CODE_0E85E8:
	PHX
	PHY
	LDA.w $0ED6
	AND.b #$80
	STA.w $0ED6
	LDA.b $5C
	BNE.b CODE_0E8601
	JSR.w CODE_0E86B7
	LDA.b #$06
	STA.w $0773
	JMP.w CODE_0E860D

CODE_0E8601:
	CMP.b #$01
	BNE.b CODE_0E8612
	JSR.w CODE_0E8616
	LDA.b #$01
	STA.w $0ED4
CODE_0E860D:
	LDA.b #$01
	STA.w $0EDE
CODE_0E8612:
	PLY
	PLX
CODE_0E8614:
	PLB
	RTL

CODE_0E8616:
	REP.b #$30
	LDA.w #$000E
	STA.b $F7
	LDA.w $0ED9
	STA.b $00
	LDA.l $7F2000
	TAX
	LDA.b $F3
	XBA
	STA.l $7F2002,x
	INC
	STA.l $7F203C,x
CODE_0E8633:
	PHX
	LDX.b $00
	LDA.l $7F3000,x
	AND.w #$00FF
	ASL
	ASL
	ASL
	TAY
	PLX
	LDA.w DATA_0EBB6D,y
	STA.l $7F2004,x
	LDA.w DATA_0EBB6D+$02,y
	STA.l $7F2006,x
	LDA.w DATA_0EBB6D+$04,y
	STA.l $7F203E,x
	LDA.w DATA_0EBB6D+$06,y
	STA.l $7F2040,x
	INX
	INX
	INX
	INX
	LDA.b $00
	CLC
	ADC.w #$0010
	STA.b $00
	DEC.b $F7
	BNE.b CODE_0E8633
	LDA.l $7F2000
	TAX
	LDA.w #$FFFF
	STA.l $7F2076,x
	LDA.l $7F2000
	CLC
	ADC.w #$0074
	STA.l $7F2000
	LDA.w $0ED9
	INC
	AND.w #$000F
	BNE.b CODE_0E869E
	LDA.w $0ED9
	AND.w #$FFF0
	CLC
	ADC.w #$00E0
	STA.w $0ED9
	BRA.b CODE_0E86A1

CODE_0E869E:
	INC.w $0ED9
CODE_0E86A1:
	LDA.w $0ED9
	CMP.w #$0A80
	BCC.b CODE_0E86AC
	STZ.w $0ED9
CODE_0E86AC:
	LDA.b $F3
	CLC
	ADC.w #$0200
	STA.b $F3
	SEP.b #$30
	RTS

;--------------------------------------------------------------------

CODE_0E86B7:
	REP.b #$30
	LDX.w $1A00
	LDA.b $F3
	STA.w $1A02,x
	CLC
	ADC.w #$0100
	STA.w $1A08,x
	CLC
	ADC.w #$0100
	STA.b $F3
	LDA.w #$0100
	STA.w $1A04,x
	STA.w $1A0A,x
	LDA.b $F3
	AND.w #$0200
	BNE.b CODE_0E86E6
	LDA.w #$2C2C
	LDY.w #$2C2D
	BRA.b CODE_0E86EC

CODE_0E86E6:
	LDA.w #$2C2E
	LDY.w #$2C2F
CODE_0E86EC:
	STA.w $1A06,x
	TYA
	STA.w $1A0C,x
	LDA.w #$FFFF
	STA.w $1A0E,x
	LDA.w $1A00
	CLC
	ADC.w #$000C
	STA.w $1A00
	SEP.b #$30
	RTS

;--------------------------------------------------------------------

CODE_0E8706:
	REP.b #$30
	LDA.w $0EEE
	CLC
	ADC.w #$0120
	XBA
	STA.b $F3
	SEP.b #$30
CODE_0E8714:
	LDA.b $F3
	AND.b #$01
	BNE.b CODE_0E871E
	LDA.b #$58
	BRA.b CODE_0E8720

CODE_0E871E:
	LDA.b #$5C
CODE_0E8720:
	STA.b $F3
	LDA.b $F4
	LSR
	LSR
	LSR
	CLC
	ADC.b #$80
	STA.b $F4
	RTS

;--------------------------------------------------------------------

DATA_0E872D:
	db $00,$00,$80,$07
	db $62,$2E,$72,$2E,$73,$2E,$72,$2E

	db $00,$00,$80,$07
	db $63,$2E,$73,$2E,$72,$2E,$73,$2E

	db $00,$00,$80,$07
	db $64,$2E,$74,$2E,$4E,$2E,$74,$2E

	db $FF,$FF

DATA_0E8753:
	db $00,$00,$80,$07
	db $73,$2E,$72,$2E,$73,$2E,$72,$2E

	db $00,$00,$80,$07
	db $72,$2E,$73,$2E,$72,$2E,$73,$2E

	db $00,$00,$80,$07
	db $5E,$2E,$66,$2E,$67,$6E,$66,$AE

	db $FF,$FF

DATA_0E8779:
	dw DATA_0E872D
	dw DATA_0E8753

CODE_0E877D:
	PHB
	PHK
	PLB
	LDA.b #DATA_0E872D>>16
	STA.b $F5
	LDA.w $0EE6
	AND.b #$01
	ASL
	REP.b #$30
	AND.w #$0002
	TAY
	LDA.w DATA_0E8779,y
	STA.b $F3
	LDX.w $1700
	LDY.w #$0000
CODE_0E879B:
	LDA.b [$F3],y
	STA.w $1702,x
	INY
	INY
	INX
	INX
	CMP.w #$FFFF
	BNE.b CODE_0E879B
	LDX.w $1700
	LDA.w $0EF4
	AND.w #$0020
	BEQ.b CODE_0E87C0
	LDA.w $0EF4
	AND.w #$0FDF
	EOR.w #$0400
	STA.w $0EF4
CODE_0E87C0:
	LDA.w $0EF4
	CLC
	ADC.w #$02C1
	AND.w #$0FDF
	TAY
	XBA
	STA.w $1702,x
	INY
	TYA
	AND.w #$0020
	BEQ.b CODE_0E87DE
	TYA
	AND.w #$0FDF
	EOR.w #$0400
	TAY
CODE_0E87DE:
	TYA
	XBA
	STA.w $170E,x
	INY
	TYA
	XBA
	STA.w $171A,x
	LDA.w $1700
	CLC
	ADC.w #$0024
	STA.w $1700
	SEP.b #$30
	STZ.w $0EE6
	LDA.b #$06
	STA.w $0773
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0E87FF:
	LDY.w $1A00
	LDA.w $19F8,y
	CMP.w #$0024
	BEQ.b CODE_0E880F
	CMP.w #$10A4
	BNE.b CODE_0E884F
CODE_0E880F:
	LDA.w $0ECE
	AND.w #$00FF
	BEQ.b CODE_0E881A
	JMP.w CODE_0E88A2

CODE_0E881A:
	INC.w $0ECE
	LDX.w $1700
	LDA.w $0ECC
	DEC
	AND.w #$041F
	CLC
	ADC.w #$0340
	XBA
	STA.w $1702,x
	LDA.w #$0780
	STA.w $1704,x
	LDA.w #$0A0D
	STA.w $1706,x
	LDA.w #$0A1D
	STA.w $1708,x
	LDA.w #$0A0F
	STA.w $170A,x
	LDA.w #$0A1F
	STA.w $170C,x
	BRA.b CODE_0E8894

CODE_0E884F:
	CMP.w #$0A08
	BNE.b CODE_0E88A2
	LDA.w $0ECF
	AND.w #$00FF
	BEQ.b CODE_0E88A2
	STZ.w $0ECE
	LDA.b $43
	BNE.b CODE_0E8868
	LDA.w $0ECC
	BEQ.b CODE_0E88A2
CODE_0E8868:
	LDX.w $1700
	LDA.w $0ECC
	CLC
	ADC.w #$0340
	XBA
	STA.w $1702,x
	LDA.w #$0780
	STA.w $1704,x
	LDA.w #$0A0C
	STA.w $1706,x
	LDA.w #$0A1C
	STA.w $1708,x
	LDA.w #$0A0E
	STA.w $170A,x
	LDA.w #$0A1E
	STA.w $170C,x
CODE_0E8894:
	LDA.w #$FFFF
	STA.w $170E,x
	TXA
	CLC
	ADC.w #$000C
	STA.w $1700
CODE_0E88A2:
	RTL

;--------------------------------------------------------------------

DATA_0E88A3:
	db $42,$41,$43

CODE_0E88A6:
	JSL.l CODE_0DAAA4
	LDY.b #$00
	BCS.b CODE_0E88B5
	INY
	LDA.w $1300,x
	BNE.b CODE_0E88B5
	INY
CODE_0E88B5:
	PHB
	PHK
	PLB
	LDA.w DATA_0E88A3,y
	STA.w $06A1
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0E88C0:
	PHB
	PHK
	PLB
	INY
	INY
	LDA.b $FA
	STA.b $F3
	LDA.b $FB
	STA.b $F4
	LDA.b $FC
	STA.b $F5
	LDA.b [$F3],y
	REP.b #$20
	AND.w #$007F
	TAX
	SEP.b #$20
	LDA.w DATA_0E88EE,x
	STA.b $00
	LDA.w DATA_0E88EE+$01,x
	STA.b $01
	SEP.b #$10
	LDX.b $9E
	LDY.b $F7
	JMP.w ($0000)

DATA_0E88EE:
	dw CODE_0E89BB
	dw CODE_0E896E
	dw CODE_0E896E
	dw CODE_0E896E
	dw CODE_0E896E
	dw CODE_0E896E
	dw CODE_0E896E
	dw CODE_0E896E
	dw CODE_0E89C1
	dw CODE_0E8970
	dw CODE_0E896E
	dw CODE_0E8980
	dw CODE_0E8990
	dw CODE_0E896E
	dw CODE_0E896E
	dw CODE_0E896E
	dw CODE_0E8A4A
	dw CODE_0E8AF7
	dw CODE_0E8AFB
	dw CODE_0E8AFF
	dw CODE_0E8B11
	dw CODE_0E896E
	dw CODE_0E896E
	dw CODE_0E896E
	dw CODE_0E8B5A
	dw CODE_0E8B7D
	dw CODE_0E8BB9
	dw CODE_0E8BDF
	dw CODE_0E8C01
	dw CODE_0E8C2A
	dw CODE_0E8C67
	dw CODE_0E8CAD
	dw CODE_0E8CCF
	dw CODE_0E896E
	dw CODE_0E896E
	dw CODE_0E896E
	dw CODE_0E896E
	dw CODE_0E896E
	dw CODE_0E896E
	dw CODE_0E896E
	dw CODE_0E8D04
	dw CODE_0E896E
	dw CODE_0E896E
	dw CODE_0E896E
	dw CODE_0E896E
	dw CODE_0E896E
	dw CODE_0E896E
	dw CODE_0E896E
	dw CODE_0E89A0
	dw CODE_0E896E
	dw CODE_0E896E
	dw CODE_0E896E
	dw CODE_0E896E
	dw CODE_0E896E
	dw CODE_0E896E
	dw CODE_0E896E
	dw CODE_0E89A4
	dw CODE_0E896E
	dw CODE_0E896E
	dw CODE_0E896E
	dw CODE_0E896E
	dw CODE_0E896E
	dw CODE_0E896E
	dw CODE_0E896E

;--------------------------------------------------------------------

CODE_0E896E:
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0E8970:
	JSR.w CODE_0E8D11
	JSL.l CODE_0DAAB4
	LDX.b $07
	LDA.b #$00
	STA.w $06A1,x
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0E8980:
	JSR.w CODE_0E8D11
	JSL.l CODE_0DAAB4
	LDX.b $07
	LDA.b #$60
	STA.w $06A1,x
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0E8990:
	JSR.w CODE_0E8D11
	JSL.l CODE_0DAAB4
	LDX.b $07
	LDA.b #$61
	STA.w $06A1,x
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0E89A0:
	LDA.b #$01
	BNE.b CODE_0E89A6

CODE_0E89A4:
	LDA.b #$04
CODE_0E89A6:
	JSL.l CODE_0DAACC
	LDA.b #$1C
	STA.w $06A1,x
	LDA.w $06A0,x
	CMP.b #$1B
	BNE.b CODE_0E89B9
	INC.w $06A1,x
CODE_0E89B9:
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0E89BB:
	LDX.b #$00
	LDY.b #$0F
	BRA.b CODE_0E89D4

CODE_0E89C1:
	TXA
	PHA
	LDX.b #$01
	LDY.b #$0F
	LDA.b #$44
	JSL.l CODE_0DAAAC
	PLA
	TAX
	JSR.w CODE_0E8D11
	LDX.b #$01
CODE_0E89D4:
	LDA.b #$40
	JSL.l CODE_0DAAAC
	PLB
	RTL

;--------------------------------------------------------------------

DATA_0E89DC:
	db $00,$00,$00,$DF,$C6,$C5,$DE,$00
	db $00,$00,$00,$00,$00,$D4,$DB,$DA
	db $D0,$00,$00,$00,$00,$00,$E3,$E2
	db $C7,$C4,$E1,$E0,$00,$00,$00,$00
	db $D4,$D3,$CD,$CC,$D1,$D0,$00,$00
	db $E6,$00,$D9,$D8,$DD,$DC,$D6,$D5
	db $E5,$E4,$CB,$CA,$C9,$C8,$C7,$C4
	db $C3,$C2,$C1,$C0,$D4,$D3,$D2,$CD
	db $CC,$CD,$CC,$D2,$D1,$D0,$D9,$D8
	db $D7,$DD,$DC,$DD,$DC,$D7,$D6,$D5
	db $D9,$D8,$D7,$D7,$D7,$D7,$D7,$D7
	db $D6,$D5,$D9,$D8,$CF,$CE,$CF,$CE
	db $CF,$CE,$D6,$D5,$D9,$D8,$DD,$DC
	db $DD,$DC,$DD,$DC,$D6,$D5

;--------------------------------------------------------------------

CODE_0E8A4A:
	JSR.w CODE_0E8D11
	STY.b $07
	STZ.w $0EE7
	TYA
	BNE.b CODE_0E8A57
	LDY.b #$08
CODE_0E8A57:
	INY
	JSL.l CODE_0DAAB4
	PHX
	LDY.w $1300,x
	LDX.b $07
	LDA.b #$16
	STA.b $06
CODE_0E8A66:
	LDA.w DATA_0E89DC,y
	STA.w $06A1,x
	INX
	LDA.b $06
	BEQ.b CODE_0E8A78
	TYA
	CLC
	ADC.b #$0A
	TAY
	DEC.b $06
CODE_0E8A78:
	CPX.b #$0B
	BNE.b CODE_0E8A66
	PLX
	LDA.b $07
	BEQ.b CODE_0E8A89
	LDA.w $1300,x
	BNE.b CODE_0E8A89
	STZ.w $06AB
CODE_0E8A89:
	LDA.w $0725
	BEQ.b CODE_0E8AC5
	LDA.w $1300,x
	CMP.b #$05
	BNE.b CODE_0E8AC5
	JSL.l CODE_0DAABC
	PHA
	JSL.l CODE_0DAAC4
	PLA
	CLC
	ADC.b #$08
	STA.w $021A,x
	LDA.w $0725
	ADC.b #$00
	STA.b $79,x
	LDA.b #$01
	STA.b $BC,x
	STA.b $10,x
	LDA.b #$90
	STA.w $0238,x
	LDA.b #$31
	STA.b !RAM_SMBLL_NorSpr_SpriteID,x
	INC.w $0EE7
	LDA.b $07
	BEQ.b CODE_0E8AC5
	INC.w $0EE7
CODE_0E8AC5:
	LDA.w $0725
	BEQ.b CODE_0E8AF5
	LDA.w $06AC
	CMP.b #$4E
	BEQ.b CODE_0E8AE5
	CMP.b #$22
	BEQ.b CODE_0E8AF0
	CMP.b #$70
	BEQ.b CODE_0E8AE9
	CMP.b #$66
	BEQ.b CODE_0E8AE1
	LDA.b #$74
	BRA.b CODE_0E8AF2

CODE_0E8AE1:
	LDA.b #$69
	BRA.b CODE_0E8AF2

CODE_0E8AE5:
	LDA.b #$FC
	BRA.b CODE_0E8AF2

CODE_0E8AE9:
	LDA.b #$73
	STA.w $06AD
	BRA.b CODE_0E8AF2

CODE_0E8AF0:
	LDA.b #$24
CODE_0E8AF2:
	STA.w $06AC
CODE_0E8AF5:
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0E8AF7:
	LDA.b #$06
	BRA.b CODE_0E8B01

CODE_0E8AFB:
	LDA.b #$07
	BRA.b CODE_0E8B01

CODE_0E8AFF:
	LDA.b #$09
CODE_0E8B01:
	PHA
	JSR.w CODE_0E8D11
	JSL.l CODE_0DAAB4
	LDA.b #$07
	PLX
	STA.w $06A1,x
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0E8B11:
	JSR.w CODE_0E8D11
	JSL.l CODE_0DAAB4
	LDA.w $06A1
	STA.b $F3
	CMP.b #$63
	BEQ.b CODE_0E8B24
	DEC
	BRA.b CODE_0E8B25

CODE_0E8B24:
	INC
CODE_0E8B25:
	STA.b $F4
	LDA.b $07
	TAY
	AND.b #$01
	BEQ.b CODE_0E8B39
CODE_0E8B2E:
	LDA.b $F4
	STA.w $06A1,y
	DEC.w $1300,x
	BMI.b CODE_0E8B46
	INY
CODE_0E8B39:
	LDA.b $F3
	STA.w $06A1,y
	DEC.w $1300,x
	BMI.b CODE_0E8B46
	INY
	BRA.b CODE_0E8B2E

CODE_0E8B46:
	PLB
	RTL

;--------------------------------------------------------------------

DATA_0E8B48:
	db $07,$07,$06,$05,$04,$03,$02,$01
	db $00

DATA_0E8B51:
	db $03,$03,$04,$05,$06,$07,$08,$09
	db $0A

CODE_0E8B5A:
	JSR.w CODE_0E8D11
	JSL.l CODE_0DAAB4
	BCC.b CODE_0E8B68
	LDA.b #$09
	STA.w $0734
CODE_0E8B68:
	DEC.w $0734
	LDY.w $0734
	LDX.w DATA_0E8B51,y
	LDA.w DATA_0E8B48,y
	TAY
	LDA.b #$62
	JSL.l CODE_0DAAAC
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0E8B7D:
	JSR.w CODE_0E8D11
	JSL.l CODE_0DAAB4
	LDY.b $07
	LDA.w $1300,x
	BNE.b CODE_0E8B9E
	LDA.b #$F4
	STA.w $06A1,y
	INY
	LDA.w $06A1,y
	BNE.b CODE_0E8BA8
	LDA.b #$F5
	STA.w $06A1,y
	INY
	BRA.b CODE_0E8BA8

CODE_0E8B9E:
	LDA.w $06A1,y
	BNE.b CODE_0E8BB2
	LDA.b #$F6
	STA.w $06A1,y
CODE_0E8BA8:
	LDA.w $06A1,y
	BNE.b CODE_0E8BB2
	LDA.b #$F7
	STA.w $06A1,y
CODE_0E8BB2:
	INY
	CPY.b #$0D
	BNE.b CODE_0E8BA8
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0E8BB9:
	JSR.w CODE_0E8D11
	JSL.l CODE_0DAAB4
	LDY.b $07
	LDA.b #$65
	STA.w $06A1,y
	INY
	INY
CODE_0E8BC9:
	LDA.w $06A1,y
	CMP.b #$63
	BEQ.b CODE_0E8BD4
	CMP.b #$64
	BNE.b CODE_0E8BDD
CODE_0E8BD4:
	LDA.b #$65
	STA.w $06A1,y
	INY
	INY
	BRA.b CODE_0E8BC9

CODE_0E8BDD:
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0E8BDF:
	JSR.w CODE_0E8D11
	JSL.l CODE_0DAAB4
	LDY.b $07
	LDA.b #$F8
	STA.w $06A1,y
	INY
CODE_0E8BEE:
	LDA.w $06A1,y
	CMP.b #$EC
	BEQ.b CODE_0E8BFF
	LDA.b #$F9
	STA.w $06A1,y
	INY
	CPY.b #$0D
	BNE.b CODE_0E8BEE
CODE_0E8BFF:
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0E8C01:
	JSR.w CODE_0E8D11
	JSL.l CODE_0DAAB4
	LDY.b $07
	LDA.w $06A1,y
	CMP.b #$FD
	BEQ.b CODE_0E8C16
	LDA.b #$FA
	STA.w $06A1,y
CODE_0E8C16:
	INY
CODE_0E8C17:
	LDA.w $06A1,y
	CMP.b #$F1
	BEQ.b CODE_0E8C28
	LDA.b #$FB
	STA.w $06A1,y
	INY
	CPY.b #$0D
	BNE.b CODE_0E8C17
CODE_0E8C28:
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0E8C2A:
	JSR.w CODE_0E8D11
	JSL.l CODE_0DAAB4
	LDY.b $07
	LDA.w $1300,x
	BNE.b CODE_0E8C4B
	LDA.w $06A1,y
	CMP.b #$68
	BEQ.b CODE_0E8C44
	LDA.b #$02
	STA.w $06A1,y
CODE_0E8C44:
	LDA.b #$EE
	STA.w $06A2,y
	BRA.b CODE_0E8C65

CODE_0E8C4B:
	LDA.w $06A1,y
	CMP.b #$66
	BNE.b CODE_0E8C56
	LDA.b #$EF
	BRA.b CODE_0E8C58

CODE_0E8C56:
	LDA.b #$EC
CODE_0E8C58:
	STA.w $06A1,y
	LDA.b #$ED
	STA.w $06A2,y
	LDA.b #$67
	STA.w $06AD
CODE_0E8C65:
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0E8C67:
	JSR.w CODE_0E8D11
	JSL.l CODE_0DAAB4
	LDY.b $07
	LDA.w $1300,x
	BNE.b CODE_0E8C9A
	LDA.w $06A1,y
	CMP.b #$66
	BNE.b CODE_0E8C80
	LDA.b #$F3
	BRA.b CODE_0E8C90

CODE_0E8C80:
	LDA.b #$67
	INY
	INY
CODE_0E8C84:
	STA.w $06A1,y
	INY
	CPY.b #$0D
	BNE.b CODE_0E8C84
	LDY.b $07
	LDA.b #$F1
CODE_0E8C90:
	STA.w $06A1,y
	LDA.b #$F2
	STA.w $06A2,y
	BRA.b CODE_0E8CAB

CODE_0E8C9A:
	LDA.w $06A1,y
	CMP.b #$68
	BEQ.b CODE_0E8CA6
	LDA.b #$03
	STA.w $06A1,y
CODE_0E8CA6:
	LDA.b #$F0
	STA.w $06A2,y
CODE_0E8CAB:
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0E8CAD:
	JSR.w CODE_0E8D11
	JSL.l CODE_0DAAB4
	LDY.b $07
CODE_0E8CB6:
	LDA.b #$70
	STA.w $06A1,y
	INY
	DEC.w $1300,x
	BPL.b CODE_0E8CB6
	PLB
	RTL

;--------------------------------------------------------------------

DATA_0E8CC3:
	db $1B,$1A,$00,$00

DATA_0E8CC7:
	db $1B,$27,$26,$25

DATA_0E8CCB:
	db $1B,$2A,$29,$28

CODE_0E8CCF:
	LDY.b #$03
	JSL.l CODE_0DAAB4
	JSR.w CODE_0E8D11
	DEY
	DEY
	STY.b $05
	LDY.w $1300,x
	STY.b $06
	LDX.b $05
	INX
	LDA.w DATA_0E8CC3,y
	CMP.b #$00
	BEQ.b CODE_0E8CF4
	LDX.b #$00
	LDY.b $05
	JSL.l CODE_0DAAAC
	CLC
CODE_0E8CF4:
	LDY.b $06
	LDA.w DATA_0E8CC7,y
	STA.w $06A1,x
	LDA.w DATA_0E8CCB,y
	STA.w $06A2,x
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0E8D04:
	JSR.w CODE_0E8D11
	LDX.b #$02
	LDA.b #$78
	JSL.l CODE_0DAAAC
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0E8D11:
	PHX
	REP.b #$30
	TXA
	ASL
	TAX
	SEP.b #$20
	LDY.w $1305,x
	INY
	LDA.b [$F3],y
	LSR
	LSR
	LSR
	LSR
	STA.b $07
	LDA.b [$F3],y
	AND.b #$0F
	SEP.b #$10
	TAY
	PLX
	RTS

;--------------------------------------------------------------------

CODE_0E8D2E:
	PHB
	PHK
	PLB
	PHX
	REP.b #$30
	LDX.w #$0000
	LDY.w $1A00
	LDA.w $0753
	AND.w #$00FF
	BEQ.b CODE_0E8D51
CODE_0E8D42:
	LDA.w DATA_0E9B11,x
	STA.w $1A02,y
	INC
	BEQ.b CODE_0E8D60
	INX
	INX
	INY
	INY
	BRA.b CODE_0E8D42

CODE_0E8D51:
	LDA.w DATA_0E9A9F,x
	STA.w $1A02,y
	INC
	BEQ.b CODE_0E8D60
	INX
	INX
	INY
	INY
	BRA.b CODE_0E8D51

CODE_0E8D60:
	LDX.w #$0000
CODE_0E8D63:
	LDA.w DATA_0E9BA3,x
	STA.w $1A02,y
	INC
	BEQ.b CODE_0E8D72
	INX
	INX
	INY
	INY
	BRA.b CODE_0E8D63

CODE_0E8D72:
	STY.w $1A00
	LDA.w #DATA_0EB487
	STA.b $02
	LDX.w #$00A0
	LDY.w #$0000
	JSR.w CODE_0E930F
	JSR.w CODE_0E930F
	JSR.w CODE_0E930F
	STZ.w $0EFD
	STZ.w $0EEE
	SEP.b #$30
	LDA.b #$06
	STA.w $0773
	STZ.w $0ED1
	STZ.w !REGISTER_BG2HorizScrollOffset
	STZ.w !REGISTER_BG2HorizScrollOffset
	STZ.w !REGISTER_BG3HorizScrollOffset
	STZ.w !REGISTER_BG3HorizScrollOffset
	LDA.b #$17
	STA.w !RAM_SMBLL_Global_MainScreenLayersMirror
	LDA.b #$0A
	STA.w $0099
	LDA.b #$01
	STA.w !RAM_SMBLL_Global_UpdateEntirePaletteFlag
	JSL.l CODE_0FF078
	LDA.b #$FF
	STA.w $0E66
	STZ.w $0F26
	STZ.w $0ED2
	STZ.w $0ED3
	STZ.w !REGISTER_BG2VertScrollOffset
	STZ.w !REGISTER_BG2VertScrollOffset
	PLX
	PLB
	RTL

;--------------------------------------------------------------------

DATA_0E8DCF:
	dw SMBLL_LevelPreviewStripeImages_CloudAndSmallHill-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_Underground-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_WaterfallHillsWithGrassLedges-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_StandardCastle-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_CloudAndSmallHill-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_CloudAndSmallHill-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_NightWithGrassLedges-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_StandardCastle-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_DottedHillsWithDecorations-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_Underwater-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_WaterfallHillsWithGrassLedges-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_StandardCastle-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_CloudAndSmallHill-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_CloudAndSmallHill-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_WaterfallHillsWithGrassLedges-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_StandardCastle-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_DottedHillsWithDecorations-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_Underground-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_WaterfallHillsWithGrassLedges-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_StandardCastle-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_DottedHillsWithNoDecorations-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_Underwater-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_GoombaPillarAndBridge-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_StandardCastle-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_CloudAndSmallHill-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_CloudAndSmallHill-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_NightWithGrassLedges-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_StandardCastle-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_DottedHillsWithNoDecorations-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_DottedHillsWithDecorations-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_CloudLedges-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_FinalCastle-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_Underwater-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_Underwater-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_OutdoorCastle-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_Underwater-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_CloudAndSmallHill-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_Underground-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_GoombaPillarAndBridge-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_StandardCastle-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_CloudAndSmallHill-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_Underwater-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_WaterfallHillsWithGrassLedges-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_StandardCastle-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_CloudAndSmallHill-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_CloudAndSmallHill-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_NightWithGrassLedges-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_StandardCastle-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_DottedHillsWithNoDecorations-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_DottedHillsWithNoDecorations-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_CastleWall-SMBLL_LevelPreviewStripeImages
	dw SMBLL_LevelPreviewStripeImages_FinalCastle-SMBLL_LevelPreviewStripeImages

;--------------------------------------------------------------------

DATA_0E8E37:
	db $00,$00,$00,$00,$00,$00,$00,$04,$00,$00,$00,$00,$00,$04,$00,$01
	db $02,$02,$02,$00,$01,$00,$00,$00,$01,$00,$01,$00,$00,$02,$02,$02
	db $00,$00,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$02
	db $02,$02,$00,$00,$00,$00,$00,$03,$03,$00,$03,$00,$03,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00

DATA_0E8E7F:
	db $02,$03,$0E,$06,$2B,$2B,$2B,$06,$05,$08,$0E,$06,$02,$02,$0E,$06
	db $05,$03,$0E,$06,$05,$08,$10,$06,$2B,$2B,$2B,$06,$05,$05,$0D,$04
	db $08,$08,$06,$08,$02,$03,$10,$06,$02,$08,$0E,$06,$2B,$2B,$2B,$06
	db $05,$05,$0C,$04

DATA_0E8EB3:
	db $01,$02,$02,$06,$03
	db $11,$11,$16,$03,$03
	db $08,$00,$00,$06,$03
	db $01,$01,$06,$03,$03
	db $08,$02,$02,$06,$03
	db $07,$00,$00,$05,$03
	db $11,$11,$16,$03,$03
	db $07,$07,$07,$03,$03
	db $00,$00,$03,$00,$00
	db $01,$02,$02,$05,$03
	db $08,$00,$00,$06,$03
	db $11,$11,$16,$03,$03
	db $07,$07,$07,$03,$03

DATA_0E8EF4:
	db $01,$02,$02,$03,$04
	db $05,$06,$07,$08,$08
	db $09,$0A,$0A,$0B,$0C
	db $0D,$0E,$0F,$10,$10
	db $11,$12,$12,$13,$14
	db $15,$16,$16,$17,$18
	db $19,$1A,$1B,$1C,$1C
	db $1D,$1E,$1F,$20,$20
	db $21,$22,$23,$24,$24
	db $25,$26,$26,$27,$28
	db $29,$2A,$2A,$2B,$2C
	db $2D,$2E,$2F,$30,$30
	db $31,$32,$33,$34,$34

CODE_0E8F35:
	PHB
	PHK
	PLB
	LDY.w $00DB
	LDA.w DATA_0E8E37,y
	STA.w $0F26
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0E8F43:
	PHB
	PHK
	PLB
	PHX
	PHY
	LDA.w $0E1A
	BEQ.b CODE_0E8F50
	STZ.w $0E1A
CODE_0E8F50:
	JSL.l CODE_0E8F35
	LDA.b #!Define_SMBLL_LevelMusic_MusicFade
	STA.w !RAM_SMBLL_Global_MusicCh1
	LDY.w $0E21
	DEY
	LDA.w DATA_0E8E7F,y
	AND.b #$1F
	STA.b $99
	LDA.b #$01
	STA.w $0774
	STA.w $0ED6
	JSL.l CODE_0FF078
	STZ.w $0EF0
	STZ.w $0ECA
	STZ.w $130F
	STZ.w $0EDF
	STZ.w $0ED1
	STZ.w $0EC9
	STZ.w $0EDB
	STZ.w $0B9A
	STZ.w $1680
	STZ.w $0EDC
	JSL.l CODE_0480EF				; Note: Call to SMB1 function
	REP.b #$30
	STZ.w $0ECB
	STZ.w $1310
	STZ.w $1312
	LDY.w $1A00
	LDA.w #$C709
	STA.w $1A02,y
	LDA.w #$12C0
	STA.w $1A04,y
	LDA.w #$30A2
	STA.w $1A06,y
	LDA.w #$D809
	STA.w $1A08,y
	LDA.w #$12C0
	STA.w $1A0A,y
	LDA.w #$70A2
	STA.w $1A0C,y
	LDA.w #$A809
	STA.w $1A0E,y
	LDA.w #$1E40
	STA.w $1A10,y
	LDA.w #$3078
	STA.w $1A12,y
	LDA.w #$080B
	STA.w $1A14,y
	LDA.w #$1E40
	STA.w $1A16,y
	LDA.w #$B078
	STA.w $1A18,y
	TYA
	CLC
	ADC.w #$0018
	TAY
	LDX.w #$0000
CODE_0E8FF1:
	LDA.w DATA_0E9C0F,x
	STA.w $1A02,y
	INX
	INX
	INY
	INY
	INC
	BNE.b CODE_0E8FF1
	DEY
	DEY
	LDA.w $0E21
	DEC
	AND.w #$00FF
	ASL
	TAX
	LDA.w DATA_0E8DCF,x
	TAX
CODE_0E900D:
	LDA.w SMBLL_LevelPreviewStripeImages,x
	STA.w $1A02,y
	INX
	INX
	INY
	INY
	INC
	BNE.b CODE_0E900D
	LDA.w $0E22
	AND.w #$00FF
	CMP.w #$0011
	BNE.b CODE_0E9037
	DEY
	DEY
	LDX.w #$0000
CODE_0E902A:
	LDA.w DATA_0EABD3,x
	STA.w $1A02,y
	INX
	INX
	INY
	INY
	INC
	BNE.b CODE_0E902A
CODE_0E9037:
	LDA.w $0E22
	AND.w #$00F0
	BEQ.b CODE_0E905C
	LDA.w $0E22
	AND.w #$00FF
	CMP.w #$0016
	BEQ.b CODE_0E905C
	DEY
	DEY
	LDX.w #$0000
CODE_0E904F:
	LDA.w DATA_0EABFF,x
	STA.w $1A02,y
	INX
	INX
	INY
	INY
	INC
	BNE.b CODE_0E904F
CODE_0E905C:
	STY.w $1A00
	SEP.b #$30
	JSR.w CODE_0E91C1
	DEC.w $073C
	LDA.b #$01
	STA.w !RAM_SMBLL_Global_UpdateEntirePaletteFlag
	STZ.w $1000
	STZ.w $1001
	LDA.w $0756
	STA.b $EB
	LDA.b #$01
	STA.w $0756
	LDA.w $0E22
	AND.b #$F0
	BEQ.b CODE_0E9085
	LDA.b #$04
CODE_0E9085:
	STA.w $0744
	LDA.w $0E22
	CMP.b #$02
	BNE.b CODE_0E9094
	LDA.b #$03
	STA.w $0744
CODE_0E9094:
	LDA.b $DB
	CMP.b #$08
	BNE.b CODE_0E909F
	LDA.b #$01
	STA.w $0744
CODE_0E909F:
	JSL.l CODE_0E98C3
	DEC.w !RAM_SMBLL_Global_UpdateEntirePaletteFlag
	LDA.b $EB
	STA.w $0756
	STZ.w $0E22
	LDA.b #$17
	STA.w !RAM_SMBLL_Global_MainScreenLayersMirror
	LDA.b #$06
	STA.w $0773
	STZ.w $0EDE
	STZ.w $0ED2
	STZ.w $0ED3
	STZ.w !REGISTER_BG2VertScrollOffset
	STZ.w !REGISTER_BG2VertScrollOffset
	PLY
	PLX
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0E90CB:
	LDA.b $9B
	BEQ.b CODE_0E90EF
	STZ.b $9B
	LDA.b $9C
	STA.w $071C
	STA.w $073F
	LDA.b $9D
	STA.w $071A
	REP.b #$20
	LDA.b $9C
	LSR
	STA.w $0EFD
	LSR
	STA.w $0EEE
	STA.w $0ED7
	SEP.b #$20
CODE_0E90EF:
	LDA.w $0EFE
	AND.b #$01
	STA.w $0EF6
	STZ.w $0EFC
	STZ.w $0EF8
	JSL.l CODE_0F8000
	JSR.w CODE_0E99E0
	JSR.w CODE_0E9A06
	JSR.w CODE_0E9A06
	JSR.w CODE_0E9A06
	JSR.w CODE_0E9A06
	JSR.w CODE_0E9A06
	JSR.w CODE_0E9A06
	LDA.b $BA
	CMP.b #$03
	BEQ.b CODE_0E913F
	JSR.w CODE_0E9A06
	JSR.w CODE_0E9A06
	JSR.w CODE_0E9A06
	JSR.w CODE_0E9A06
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	JSR.w CODE_0E9A06
	JSR.w CODE_0E9A06
	JSR.w CODE_0E9A06
	JSR.w CODE_0E9A06
	JSR.w CODE_0E9A06
	JSR.w CODE_0E9A06
	JSR.w CODE_0E9A06
	JSR.w CODE_0E9A06
endif
	LDA.w $0ED1
	BEQ.b CODE_0E913F
	JSR.w CODE_0E9A06
	JSR.w CODE_0E9A06
	JSR.w CODE_0E9A06
	JSR.w CODE_0E9A06
	JSR.w CODE_0E9A06
	JSR.w CODE_0E9A06
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	JSR.w CODE_0E9A06
	JSR.w CODE_0E9A06
	JSR.w CODE_0E9A06
	JSR.w CODE_0E9A06
	JSR.w CODE_0E9A06
	JSR.w CODE_0E9A06
	JSR.w CODE_0E9A06
	JSR.w CODE_0E9A06
endif
CODE_0E913F:
	RTS

;--------------------------------------------------------------------

DATA_0E9140:
	db $F8 : dw $7F2000
	db $F8 : dw $7F20F0
	db $00

CODE_0E9147:
	PHB
	PHK
	PLB
	JSR.w CODE_0E90CB
	STZ.w $0ED2
	STZ.w $0ED3
	LDA.b $5C
	BEQ.b CODE_0E9169
	CMP.b #$01
	BNE.b CODE_0E9160
	LDA.b #$F8
	STA.w $0ED2
CODE_0E9160:
	LDA.b #$06
	STA.w $1209
	LDX.b #$11
	BRA.b CODE_0E9195

CODE_0E9169:
	REP.b #$20
	LDA.w #(!REGISTER_BG2HorizScrollOffset&$0000FF<<8)+$42
	STA.w HDMA[$02].Parameters
	LDA.w #DATA_0E9140
	STA.w HDMA[$02].SourceLo
	LDX.b #DATA_0E9140>>16
	STX.w HDMA[$02].SourceBank
	LDY.b #$7F2000>>16
	STY.w HDMA[$02].IndirectSourceBank
	SEP.b #$20
	STZ.w $0EEC
	STZ.w $0EF3
	LDA.w !RAM_SMBLL_Global_HDMAEnableMirror
	ORA.b #$04
	STA.w !RAM_SMBLL_Global_HDMAEnableMirror
	LDA.b #$00
	LDX.b #$17
CODE_0E9195:
	STX.w !RAM_SMBLL_Global_MainScreenLayersMirror
	STA.w !RAM_SMBLL_Global_SubScreenLayersMirror
	STZ.w $0ED9
	LDA.b #$1F
	STA.w $0EF2
	LDA.w $0ED1
	BEQ.b CODE_0E91BC
	LDA.w $0743
	BEQ.b CODE_0E91B2
	STZ.w $0ED1
	BRA.b CODE_0E91BC

CODE_0E91B2:
	LDA.b #$AF
	STA.w $0EF2
	LDA.b #$01
	STA.w $0EDE
CODE_0E91BC:
	JSR.w CODE_0E91C1
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0E91C1:
	LDA.w $0E65
	BEQ.b CODE_0E91CD
	STA.b $DB
	STZ.w $0E65
	BRA.b CODE_0E91F8

CODE_0E91CD:
	LDA.b $DB
	CMP.b #$17
	BEQ.b CODE_0E91D9
	CMP.b #$26
	BEQ.b CODE_0E91D9
	BRA.b CODE_0E91F8

CODE_0E91D9:
	STA.w $0E65
	LDA.w $075F
	BEQ.b CODE_0E91EF
	CMP.b #$04
	BEQ.b CODE_0E91EF
	CMP.b #$09
	BEQ.b CODE_0E91EF
	LDA.b #$3E
	STA.b $DB
	BRA.b CODE_0E91F8

CODE_0E91EF:
	LDA.b #$37
	STA.b $DB
	LDA.b #$03
	STA.w $0F26
CODE_0E91F8:
	REP.b #$30
	LDA.b $DB
	AND.w #$00FF
	ASL
	ASL
	ASL
	ASL
	TAY
	STY.b $06
	STZ.b $02
CODE_0E9208:
	LDY.b $06
	LDA.w DATA_0E93B8,y
	AND.w #$00FF
	INY
	STY.b $06
	ASL
	TAX
	LDA.w DATA_0EACA3,x
	TAY
	LDX.b $02
	LDA.w #$0007
	STA.b $04
CODE_0E9220:
	LDA.w DATA_0EAD27,y
	STA.w $1000,x
	LDA.w DATA_0EAD27+$10,y
	STA.w $1010,x
	INX
	INX
	INY
	INY
	DEC.b $04
	BPL.b CODE_0E9220
	TXA
	CLC
	ADC.w #$0010
	STA.b $02
	CMP.w #$01E0
	BNE.b CODE_0E9208
	LDA.w $02F8
	BEQ.b CODE_0E9284
	LDA.w $0753
	AND.w #$00FF
	BEQ.b CODE_0E9284
	LDY.w #$0000
	LDX.w #$00E0
CODE_0E9253:
	LDA.w DATA_0E9264,y
	STA.w $1000,x
	INX
	INX
	INY
	INY
	CPY.w #$0020
	BNE.b CODE_0E9253
	BRA.b CODE_0E9284

DATA_0E9264:
	dw $772F,$7FFF,$14A5,$57F0,$0340,$0200,$46BF,$365D,$25BB,$04EF,$0D73,$4F7F,$7F0F,$4E06,$001E,$0012

CODE_0E9284:
	LDA.b $42
	LSR
	LSR
	STA.w $0EEE
	AND.w #$FF00
	XBA
	STA.b $F3
	LDA.w $075F
	AND.w #$00FF
	ASL
	CMP.w #$000C
	BCC.b CODE_0E92A0
	LDA.w #$0000
CODE_0E92A0:
	CLC
	ADC.b $F3
	STA.b $F3
	STZ.w $0ED9
CODE_0E92A8:
	LDA.b $F3
	BEQ.b CODE_0E92BA
	LDA.w $0ED9
	CLC
	ADC.w #$00E0
	STA.w $0ED9
	DEC.b $F3
	BRA.b CODE_0E92A8

CODE_0E92BA:
	LDA.w $0EEE
	AND.w #$00F0
	LSR
	LSR
	LSR
	LSR
	CLC
	ADC.w $0ED9
	STA.w $0ED9
	CMP.w #$0A80
	BCC.b CODE_0E92D3
	STZ.w $0ED9
CODE_0E92D3:
	SEP.b #$30
	JSR.w CODE_0E9327
	LDA.w $0EDC
	BEQ.b CODE_0E9306
	LDA.w $0EEF
	STA.b $F3
	LDA.w $0EEE
	STA.b $F4
	JSR.w CODE_0E8714
	LDA.b #$13
	STA.b $F5
CODE_0E92EE:
	JSL.l CODE_0E85D8
	LDA.b $F4
	CMP.b #$A0
	BCC.b CODE_0E9302
	LDA.b $F3
	EOR.b #$04
	STA.b $F3
	LDA.b #$80
	STA.b $F4
CODE_0E9302:
	DEC.b $F5
	BNE.b CODE_0E92EE
CODE_0E9306:
	LDA.b #$01
	STA.w !RAM_SMBLL_Global_UpdateEntirePaletteFlag
	INC.w $073C
	RTS

;--------------------------------------------------------------------

CODE_0E930F:
	LDA.w #DATA_0EB487>>16
	STA.b $04
	LDA.w #$0010
	STA.b $00
CODE_0E9319:
	LDA.b [$02],y
	STA.w $1000,x
	INY
	INY
	INX
	INX
	DEC.b $00
	BNE.b CODE_0E9319
	RTS

;--------------------------------------------------------------------

CODE_0E9327:
	PHB
	LDA.b #$7F3000>>16
	PHA
	PLB
	LDX.b #$00
CODE_0E932E:
	STZ.w $7F3000,x
	STZ.w $7F3100,x
	STZ.w $7F3200,x
	STZ.w $7F3300,x
	STZ.w $7F3400,x
	STZ.w $7F3500,x
	STZ.w $7F3600,x
	STZ.w $7F3700,x
	STZ.w $7F3800,x
	STZ.w $7F3900,x
	STZ.w $7F3A00,x
	DEX
	BNE.b CODE_0E932E
	PLB
	PHB
	PHK
	PLB
	LDA.b #$7F3000>>16
	STA.b $F5
	STZ.b $F6
	REP.b #$30
	LDA.w #$7F3000
	STA.b $F3
	LDY.w #$0000
	STZ.b $F8
CODE_0E9368:
	LDX.b $F8
	LDA.w DATA_0EB4E7,x
	CMP.w #$FFFF
	BEQ.b CODE_0E93B4
	BPL.b CODE_0E937E
	PHA
	LDA.b $F3
	CLC
	ADC.w #$00E0
	STA.b $F3
	PLA
CODE_0E937E:
	PHA
	AND.w #$00FF
	TAY
	PLA
	ASL
	ASL
	LDA.w #$0000
	ROL
	STA.b $F6
	SEP.b #$20
	INX
	LDA.w DATA_0EB4E7,x
	AND.b #$3F
	STA.b $F7
CODE_0E9396:
	LDA.b $F7
	STA.b [$F3],y
	LDA.b $F6
	BEQ.b CODE_0E93AC
	TYA
	AND.b #$F0
	CMP.b #$D0
	BEQ.b CODE_0E93AC
	TYA
	CLC
	ADC.b #$10
	TAY
	BRA.b CODE_0E9396

CODE_0E93AC:
	REP.b #$20
	INC.b $F8
	INC.b $F8
	BRA.b CODE_0E9368

CODE_0E93B4:
	SEP.b #$30
	PLB
	RTS

;--------------------------------------------------------------------

DATA_0E93B8:
	db $00,$01,$1B,$1C,$04,$1D,$1E,$1F,$08,$20,$0A,$0B,$0C,$21,$0E,$0F
	db $00,$01,$1B,$1C,$04,$1D,$1E,$1F,$08,$20,$0A,$0B,$0C,$21,$0E,$0F
	db $00,$01,$1B,$1C,$04,$1D,$1E,$1F,$08,$20,$0A,$0B,$0C,$21,$0E,$0F
	db $00,$01,$1B,$1C,$04,$1D,$1E,$1F,$08,$20,$0A,$0B,$0C,$21,$0E,$0F
	db $00,$01,$1B,$1C,$04,$1D,$1E,$1F,$08,$20,$0A,$0B,$0C,$21,$0E,$0F
	db $00,$01,$1B,$1C,$04,$1D,$1E,$1F,$08,$20,$0A,$0B,$0C,$21,$0E,$0F
	db $00,$01,$1B,$1C,$04,$1D,$1E,$1F,$08,$20,$0A,$0B,$0C,$21,$0E,$0F
	db $00,$01,$1B,$1C,$04,$2F,$1E,$30,$08,$20,$0A,$3F,$0C,$21,$0E,$0F
	db $00,$01,$02,$03,$04,$19,$1E,$1A,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$19,$06,$1A,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$1B,$3E,$04,$1D,$1E,$1F,$08,$20,$0A,$0B,$0C,$21,$0E,$0F
	db $00,$01,$1B,$1C,$04,$1D,$1E,$1F,$08,$20,$0A,$0B,$0C,$21,$0E,$0F
	db $00,$01,$1B,$1C,$04,$1D,$1E,$1F,$08,$20,$0A,$0B,$0C,$21,$0E,$0F
	db $00,$01,$1B,$1C,$04,$2F,$1E,$30,$08,$20,$0A,$3F,$0C,$21,$0E,$0F
	db $00,$01,$02,$03,$04,$05,$31,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$05,$06,$38,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$36,$06,$37,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$36,$06,$37,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$36,$06,$37,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$35,$41,$04,$3D,$06,$2D,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$05,$06,$38,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$05,$31,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$05,$06,$38,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$35,$41,$04,$3D,$06,$2D,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$05,$06,$38,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$05,$06,$2B,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$3A,$06,$3B,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$36,$06,$37,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$36,$06,$37,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$36,$06,$37,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$05,$06,$2B,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$19,$06,$1A,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$05,$06,$38,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$05,$29,$3C,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$26,$03,$28,$05,$29,$2A,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$05,$31,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$05,$31,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$05,$31,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$05,$31,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$05,$31,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$19,$06,$1A,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$05,$31,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$3A,$29,$3B,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$05,$31,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$05,$06,$38,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$35,$41,$04,$36,$06,$37,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$36,$06,$37,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$36,$06,$37,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$05,$06,$2B,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$05,$06,$2B,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$05,$06,$2E,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$05,$31,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$19,$06,$1A,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$13,$14,$04,$15,$06,$16,$08,$17,$0A,$0B,$0C,$18,$0E,$0F
	db $00,$01,$13,$14,$04,$15,$1E,$16,$08,$17,$0A,$0B,$0C,$18,$0E,$0F
	db $00,$01,$13,$14,$04,$19,$06,$1A,$08,$17,$0A,$0B,$0C,$18,$0E,$0F
	db $00,$01,$13,$14,$04,$15,$06,$16,$08,$17,$0A,$0B,$0C,$18,$0E,$0F
	db $00,$01,$13,$14,$04,$19,$06,$1A,$08,$17,$0A,$0B,$0C,$18,$0E,$0F
	db $00,$01,$13,$14,$04,$15,$06,$16,$08,$17,$0A,$0B,$0C,$18,$0E,$0F
	db $00,$01,$13,$14,$04,$19,$06,$1A,$08,$17,$0A,$0B,$0C,$18,$0E,$0F
	db $00,$01,$02,$03,$04,$10,$11,$12,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$10,$11,$12,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$10,$11,$12,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$1B,$03,$04,$39,$11,$12,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$10,$11,$12,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$10,$11,$12,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$10,$11,$12,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$10,$11,$12,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$01,$02,$03,$04,$10,$11,$12,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F

;--------------------------------------------------------------------

DATA_0E9828:
	dw $7FF8,$7FF8,$0000,$0000,$3908,$7FF8,$3908,$3908

DATA_0E9838:
	dw $0000,$7FFF,$0C63,$0155,$1A1C,$1B3E,$2D9C,$3ABF,$0000,$152F,$0014,$0C19,$1C9F,$762E,$5D68,$44E6
	dw $0000,$7FFF,$0C63,$0155,$1A1C,$1B3E,$2D9C,$3ABF,$0000,$152F,$1E60,$3304,$4388,$7655,$7190,$58CA
	dw $0000,$7FFF,$0C63,$0155,$1A1C,$1B3E,$2D9C,$3ABF,$0000,$152F,$3ED9,$4F5D,$639F,$0D9F,$001D,$0015
	dw $0000,$7FFF,$0C63,$0155,$1A1C,$1B3E,$2D9C,$3ABF,$0000,$152F,$3ED9,$4F5D,$639F,$0352,$02AD,$0208

CODE_0E98B8:
	LDA.w $0E22
	BEQ.b CODE_0E98C0
	JMP.w CODE_0E996F

CODE_0E98C0:
	INC.w $073C
CODE_0E98C3:
	PHB
	PHK
	PLB
	PHX
	LDA.w $0744
	BNE.b CODE_0E98CE
	LDA.b $BA
CODE_0E98CE:
	REP.b #$30
	AND.w #$00FF
	ASL
	TAY
	LDA.w $0743
	AND.w #$00FF
	BEQ.b CODE_0E98F2
	LDA.w $0744
	AND.w #$0004
	BNE.b CODE_0E98F2
	LDA.w $075A
	AND.w #$0080
	BNE.b CODE_0E98F2
	LDA.w #$522A
	BRA.b CODE_0E98F5

CODE_0E98F2:
	LDA.w DATA_0E9828,y
CODE_0E98F5:
	STA.w $1000
	AND.w #$001F
	CLC
	ADC.w #$0020
	STA.w !RAM_SMBLL_Global_FixedColorData1Mirror
	LDA.w $1000
	AND.w #$03E0
	ASL
	ASL
	ASL
	XBA
	CLC
	ADC.w #$0040
	STA.w !RAM_SMBLL_Global_FixedColorData2Mirror
	LDA.w $1000
	AND.w #$7C00
	LSR
	LSR
	XBA
	CLC
	ADC.w #$0080
	STA.w !RAM_SMBLL_Global_FixedColorData3Mirror
	STZ.w $1000
	BRA.b CODE_0E9934

CODE_0E9928:
	LDA.w #$00E0
	STA.w !RAM_SMBLL_Global_FixedColorData1Mirror
	STA.w !RAM_SMBLL_Global_FixedColorData2Mirror
	STA.w !RAM_SMBLL_Global_FixedColorData3Mirror
CODE_0E9934:
	SEP.b #$30
	LDA.w $0254
	BNE.b CODE_0E996D
	LDY.b #$00
	LDA.w $0753
	BEQ.b CODE_0E9944
	LDY.b #$20
CODE_0E9944:
	LDA.w $0756
	CMP.b #$02
	BNE.b CODE_0E9950
	TYA
	CLC
	ADC.b #$40
	TAY
CODE_0E9950:
	REP.b #$20
	LDX.b #$00
CODE_0E9954:
	LDA.w DATA_0E9838,y
	STA.w $11E0,x
	LDA.w DATA_0E9838+$10,y
	STA.w $11F0,x
	INX
	INX
	INY
	INY
	CPX.b #$10
	BNE.b CODE_0E9954
	SEP.b #$20
	INC.w !RAM_SMBLL_Global_UpdateEntirePaletteFlag
CODE_0E996D:
	PLX
	PLB
CODE_0E996F:
	RTL

;--------------------------------------------------------------------

CODE_0E9970:
	PHB
	PHK
	PLB
	PHX
	PHY
	PHA
	LDA.w $0EFE
	CMP.b #$7F
	BNE.b CODE_0E9982
	LDA.w $0ED0
	BRA.b CODE_0E9985

CODE_0E9982:
	STA.w $0ED0
CODE_0E9985:
	STA.b $F3
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDA.b #$10
else
	LDA.b #$20
endif
	STA.b $00
	LDA.b $BA
	CMP.b #$03
	BNE.b CODE_0E9993
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDA.b #$40
	STA.b $00
else
	ASL.b $00
endif
CODE_0E9993:
	LDA.w $0EFD
	CLC
	ADC.b $00
	AND.b #$F0
	LSR
	LSR
	STA.w $0EF7
	LSR
	STA.b $00
	LDA.b $00
	BNE.b CODE_0E99BA
	LDA.w $0EF6
	BEQ.b CODE_0E99B3
	STZ.w $0EF6
	LDA.b #$14
	BRA.b CODE_0E99C6

CODE_0E99B3:
	LDA.b #$10
	STA.w $0EF6
	BRA.b CODE_0E99C6

CODE_0E99BA:
	LDA.b $F3
	AND.b #$01
	BEQ.b CODE_0E99C4
	LDA.b #$10
	BRA.b CODE_0E99C6

CODE_0E99C4:
	LDA.b #$14
CODE_0E99C6:
	STA.b $01
	LDA.b $F3
	AND.b #$0F
	LDX.b $00
	BNE.b CODE_0E99D1
	INC
CODE_0E99D1:
	INC
	ASL
	ASL
	ASL
	STA.w $0EF8
	JSR.w CODE_0E9A06
	PLA
	PLY
	PLX
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0E99E0:
	LDA.w $0EFD
	AND.b #$F0
	LSR
	LSR
	STA.w $0EF7
	LSR
	STA.b $00
	LDA.w $0EFE
	ASL
	ASL
	ASL
	STA.w $0EF8
	LDA.w $0EFE
	AND.b #$01
	BEQ.b CODE_0E9A01
	LDA.b #$14
	BRA.b CODE_0E9A03

CODE_0E9A01:
	LDA.b #$10
CODE_0E9A03:
	STA.b $01
	RTS

;--------------------------------------------------------------------

CODE_0E9A06:
	REP.b #$30
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDA.w #$0002
else
	LDA.w #$0004
endif
	STA.w $0EFA
	LDA.b $BA
	AND.w #$00FF
	CMP.w #$0003
	BNE.b CODE_0E9A1B
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	LDA.w #$0008
	STA.w $0EFA
else
	ASL.w $0EFA
endif
CODE_0E9A1B:
	LDA.l $7F0000
	TAY
CODE_0E9A20:
	LDA.b $00
	AND.w #$0020
	BEQ.b CODE_0E9A32
	LDA.b $00
	CLC
	ADC.w #$0400
	AND.w #$16C0
	STA.b $00
CODE_0E9A32:
	TYX
	LDA.b $00
	SEC
	SBC.w #$0800
	STA.l $7F0002,x
	LDA.w #$0020
	STA.b $02
	TXY
	LDA.w $0EF7
	AND.w #$0040
	BEQ.b CODE_0E9A58
	LDA.w #$0800
	CLC
	ADC.w $0EF7
	AND.w #$FF00
	STA.w $0EF7
CODE_0E9A58:
	LDX.w $0EF7
	STX.b $04
CODE_0E9A5D:
	LDA.l $7E2000,x
	TYX
	STA.l $7F0004,x
	INY
	INY
	LDA.b $04
	CLC
	ADC.w #$0040
	STA.b $04
	TAX
	DEC.b $02
	BPL.b CODE_0E9A5D
	TYX
	LDA.w #$0024
	STA.l $7F0000,x
	INC.w $0EF7
	INC.w $0EF7
	INC.b $00
	DEC.w $0EFA
	BNE.b CODE_0E9A20
	TYA
	STA.l $7F0000
	TAX
	LDA.w #$FFFF
	STA.l $7F0002,x
	SEP.b #$30
	LDA.b #$01
	STA.w $0EF9
	RTS

;--------------------------------------------------------------------

DATA_0E9A9F:
	db $0A,$8D,$00,$0B
	db $24,$00,$24,$00,$45,$1E,$46,$1E,$47,$1E,$24,$00

	db $0A,$AD,$00,$0B
	db $4A,$1E,$4B,$1E,$48,$1E,$49,$1E,$59,$1E,$24,$00

	db $0A,$CD,$00,$0B
	db $5A,$1E,$5B,$1E,$69,$1E,$6A,$1E,$6F,$1E,$24,$00

	db $0A,$ED,$00,$0B
	db $24,$00,$6B,$1E,$4C,$1E,$4D,$1E,$4E,$1E,$4F,$1E

	db $0B,$0D,$00,$0B
	db $24,$00,$24,$00,$5C,$1E,$5D,$1E,$5E,$1E,$5F,$1E

	db $0B,$2D,$00,$0B
	db $24,$00,$7A,$1E,$6C,$1E,$6D,$1E,$6E,$1E,$24,$00

	db $0B,$4D,$00,$0B
	db $24,$00,$7B,$1E,$7C,$1E,$7D,$1E,$7E,$1E,$24,$00

	db $FF,$FF

DATA_0E9B11:
	db $0A,$4D,$00,$0B
	db $24,$00,$80,$16,$81,$16,$82,$16,$24,$00,$24,$00

	db $0A,$6D,$00,$0B
	db $24,$00,$83,$16,$84,$16,$85,$16,$24,$00,$24,$00

	db $0A,$8D,$00,$0B
	db $24,$00,$86,$16,$87,$16,$88,$16,$24,$00,$24,$00

	db $0A,$AD,$00,$0B
	db $24,$00,$89,$16,$8A,$16,$8B,$16,$8C,$16,$24,$00

	db $0A,$CD,$00,$0B
	db $24,$00,$8D,$16,$8E,$16,$8F,$16,$90,$16,$24,$00

	db $0A,$ED,$00,$0B
	db $91,$16,$92,$16,$93,$16,$94,$16,$95,$16,$24,$00

	db $0B,$0D,$00,$0B
	db $96,$16,$97,$16,$98,$16,$99,$16,$24,$00,$24,$00

	db $0B,$2D,$00,$0B
	db $24,$00,$9A,$16,$9B,$16,$9C,$16,$24,$00,$24,$00

	db $0B,$4D,$00,$0B
	db $24,$00,$9D,$16,$9E,$16,$9F,$16,$A0,$16,$24,$00

	db $FF,$FF

DATA_0E9BA3:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMBLL_J) != $00
	db $0A,$F3,$00,$09
	db $40,$1A,$41,$1A,$42,$1A,$43,$1A,$44,$1A

	db $0B,$13,$00,$15
	db $50,$1A,$51,$1A,$52,$1A,$53,$1A,$54,$1A,$55,$1A,$56,$1A,$57,$1A
	db $58,$1A,$FC,$19,$FD,$19

	db $0B,$33,$00,$15
	db $60,$1A,$61,$1A,$62,$1A,$63,$1A,$64,$1A,$65,$1A,$66,$1A,$67,$1A
	db $68,$1A,$EA,$19,$EB,$19

	db $0B,$53,$00,$15
	db $70,$1A,$71,$1A,$72,$1A,$73,$1A,$74,$1A,$75,$1A,$76,$1A,$77,$1A
	db $78,$1A,$FA,$19,$FB,$19
else
	db $0A,$D3,$00,$09
	db $40,$1A,$41,$1A,$42,$1A,$43,$1A,$44,$1A

	db $0A,$F3,$00,$11
	db $50,$1A,$51,$1A,$52,$1A,$53,$1A,$54,$1A,$55,$1A,$56,$1A,$57,$1A
	db $58,$1A

	db $0B,$13,$00,$13
	db $60,$1A,$61,$1A,$62,$1A,$63,$1A,$64,$1A,$65,$1A,$66,$1A,$67,$1A
	db $68,$1A,$FD,$19

	db $0B,$33,$00,$13
	db $B2,$1A,$B3,$1A,$B4,$1A,$B5,$1A,$B6,$1A,$B7,$1A,$B8,$1A,$B9,$1A
	db $BA,$1A,$79,$1A

	db $0B,$53,$00,$11
	db $EA,$19,$EB,$19,$EC,$19,$ED,$19,$EE,$19,$EF,$19,$FA,$19,$FB,$19
	db $FC,$19
endif
	db $FF,$FF

;--------------------------------------------------------------------

DATA_0E9C0F:
	db $01,$C8,$40,$1E
	db $24,$00

	db $01,$E8,$40,$1E
	db $24,$00

	db $02,$08,$40,$1E
	db $24,$00

	db $02,$28,$40,$1E
	db $24,$00

	db $02,$48,$40,$1E
	db $24,$00

	db $02,$68,$40,$1E
	db $24,$00

	db $02,$88,$40,$1E
	db $24,$00

	db $02,$A8,$40,$1E
	db $24,$00

	db $02,$C8,$40,$1E
	db $24,$00

	db $02,$E8,$40,$1E
	db $24,$00

	db $FF,$FF

SMBLL_LevelPreviewStripeImages:
;$0E9C4D
.Underwater:
	db $01,$E8,$00,$1F
	db $EC,$18,$ED,$18,$EE,$18,$EF,$18,$EC,$18,$ED,$18,$EE,$18,$EF,$18
	db $EC,$18,$ED,$18,$EE,$18,$EF,$18,$EC,$18,$ED,$18,$EE,$18,$EF,$18

	db $02,$4C,$80,$0B
	db $4A,$1D,$5A,$1D,$4A,$1D,$5A,$1D,$82,$10,$84,$10

	db $02,$4D,$80,$0B
	db $4B,$1D,$5B,$1D,$4B,$1D,$5B,$1D,$83,$10,$85,$10

	db $0A,$08,$40,$1E
	db $00,$19

	db $0A,$28,$40,$1E
	db $00,$19

	db $0A,$48,$40,$1E
	db $01,$19

	db $0A,$68,$40,$1E
	db $01,$19

	db $0A,$88,$40,$1E
	db $01,$19

	db $0A,$A8,$40,$1E
	db $01,$19

	db $0A,$C8,$40,$1E
	db $01,$19

	db $0A,$E8,$40,$1E
	db $01,$19

	db $FF,$FF

.DottedHillsWithNoDecorations:
	db $09,$CA,$00,$09
	db $DF,$1D,$C3,$1D,$C0,$1D,$C1,$1D,$CA,$1D

	db $09,$EA,$00,$0B
	db $DC,$1D,$D3,$1D,$D0,$1D,$D1,$1D,$DA,$1D,$DB,$1D

	db $0A,$09,$00,$0D
	db $DD,$1D,$E2,$1D,$E3,$1D,$E0,$1D,$E1,$1D,$E2,$1D,$F8,$1D

	db $0A,$29,$00,$0D
	db $DE,$1D,$F2,$1D,$F3,$1D,$F0,$1D,$F1,$1D,$F2,$1D,$F3,$1D

	db $0A,$49,$00,$1B
	db $E9,$1D,$C6,$1D,$C7,$1D,$C4,$1D,$C5,$1D,$C6,$1D,$C7,$1D,$E8,$1D
	db $24,$00,$24,$00,$E9,$1D,$EA,$1D,$EB,$1D,$E8,$1D

	db $0A,$69,$00,$1B
	db $F9,$1D,$D6,$1D,$D7,$1D,$D4,$1D,$D5,$1D,$D6,$1D,$D7,$1D,$F8,$1D
	db $24,$00,$24,$00,$F9,$1D,$FA,$1D,$FB,$1D,$F8,$1D

	db $0A,$89,$00,$1B
	db $E5,$1D,$E6,$1D,$E7,$1D,$E4,$1D,$E5,$1D,$E6,$1D,$E7,$1D,$E4,$1D
	db $24,$00,$24,$00,$E5,$1D,$E6,$1D,$E7,$1D,$E4,$1D

	db $0A,$A9,$00,$1B
	db $F5,$1D,$F6,$1D,$F7,$1D,$F4,$1D,$F5,$1D,$F6,$1D,$F7,$1D,$F4,$1D
	db $24,$00,$24,$00,$F5,$1D,$F6,$1D,$F7,$1D,$F4,$1D

	db $02,$C8,$00,$1F
	db $08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A
	db $08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A

	db $02,$E8,$00,$1F
	db $18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A
	db $18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A

	db $FF,$FF

.DottedHillsWithDecorations:
	db $09,$CA,$00,$09
	db $DF,$1D,$C3,$1D,$C0,$1D,$C1,$1D,$CA,$1D

	db $09,$EA,$00,$0B
	db $DC,$1D,$D3,$1D,$D0,$1D,$D1,$1D,$DA,$1D,$DB,$1D

	db $0A,$09,$00,$0D
	db $DD,$1D,$E2,$1D,$E3,$1D,$E0,$1D,$E1,$1D,$E2,$1D,$F8,$1D

	db $0A,$29,$00,$0D
	db $DE,$1D,$F2,$1D,$F3,$1D,$F0,$1D,$F1,$1D,$F2,$1D,$F3,$1D

	db $0A,$49,$00,$1B
	db $E9,$1D,$C6,$1D,$C7,$1D,$C4,$1D,$C5,$1D,$C6,$1D,$C7,$1D,$E8,$1D
	db $24,$00,$24,$00,$E9,$1D,$EA,$1D,$EB,$1D,$E8,$1D

	db $0A,$69,$00,$1B
	db $F9,$1D,$D6,$1D,$D7,$1D,$D4,$1D,$D5,$1D,$D6,$1D,$D7,$1D,$F8,$1D
	db $24,$00,$24,$00,$F9,$1D,$FA,$1D,$FB,$1D,$F8,$1D

	db $0A,$89,$00,$1B
	db $E5,$1D,$E6,$1D,$E7,$1D,$E4,$1D,$E5,$1D,$E6,$1D,$E7,$1D,$E4,$1D
	db $24,$00,$24,$00,$E5,$1D,$E6,$1D,$E7,$1D,$E4,$1D

	db $0A,$A9,$00,$1B
	db $F5,$1D,$F6,$1D,$F7,$1D,$F4,$1D,$F5,$1D,$F6,$1D,$F7,$1D,$F4,$1D
	db $24,$00,$24,$00,$F5,$1D,$F6,$1D,$F7,$1D,$F4,$1D

	db $02,$0A,$80,$0B
	db $B8,$08,$BA,$08,$BA,$08,$BC,$08,$BE,$0C,$BE,$0C

	db $02,$0B,$80,$0B
	db $B9,$08,$BB,$08,$BB,$08,$BD,$08,$BF,$0C,$BF,$0C

	db $02,$92,$00,$07
	db $14,$12,$15,$12,$14,$12,$15,$12

	db $02,$B2,$00,$07
	db $16,$12,$17,$12,$16,$12,$17,$12

	db $02,$C8,$00,$1F
	db $08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A
	db $08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A

	db $02,$E8,$00,$1F
	db $18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A
	db $18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A

	db $FF,$FF

.OutdoorCastle:
	db $02,$0A,$80,$0B
	db $B8,$08,$BA,$08,$BA,$08,$BC,$08,$BE,$0C,$BE,$0C

	db $02,$0B,$80,$0B
	db $B9,$08,$BB,$08,$BB,$08,$BD,$08,$BF,$0C,$BF,$0C

	db $02,$92,$00,$07
	db $14,$12,$15,$12,$14,$12,$15,$12

	db $02,$B2,$00,$07
	db $16,$12,$17,$12,$16,$12,$17,$12

	db $02,$C8,$00,$1F
	db $CA,$09,$CB,$09,$CA,$09,$CB,$09,$CA,$09,$CB,$09,$CA,$09,$CB,$09
	db $CA,$09,$CB,$09,$CA,$09,$CB,$09,$CA,$09,$CB,$09,$CA,$09,$CB,$09

	db $02,$E8,$00,$1F
	db $DA,$09,$DB,$09,$DA,$09,$DB,$09,$DA,$09,$DB,$09,$DA,$09,$DB,$09
	db $DA,$09,$DB,$09,$DA,$09,$DB,$09,$DA,$09,$DB,$09,$DA,$09,$DB,$09

	db $FF,$FF

.CastleWall:
	db $09,$C8,$00,$1F
	db $C2,$1D,$C3,$1D,$C0,$1D,$C1,$1D,$C2,$1D,$C3,$1D,$C0,$1D,$C1,$1D
	db $C2,$1D,$C3,$1D,$C0,$1D,$C1,$1D,$C2,$1D,$C3,$1D,$C0,$1D,$C1,$1D

	db $09,$E8,$00,$1F
	db $D2,$1D,$D3,$1D,$D0,$1D,$D1,$1D,$D2,$1D,$D3,$1D,$D0,$1D,$D1,$1D
	db $D2,$1D,$D3,$1D,$D0,$1D,$D1,$1D,$D2,$1D,$D3,$1D,$D0,$1D,$D1,$1D

	db $0A,$08,$00,$1F
	db $E2,$1D,$E1,$1D,$E2,$1D,$E1,$1D,$E2,$1D,$E1,$1D,$E2,$1D,$E1,$1D
	db $E2,$1D,$E1,$1D,$E2,$1D,$E1,$1D,$E2,$1D,$E1,$1D,$E2,$1D,$E1,$1D

	db $0A,$28,$00,$1F
	db $D2,$1D,$D1,$1D,$E4,$1D,$E5,$1D,$D2,$1D,$82,$1D,$83,$1D,$84,$1D
	db $85,$1D,$80,$1D,$81,$1D,$D1,$1D,$E4,$1D,$E5,$1D,$D2,$1D,$D1,$1D

	db $0A,$48,$00,$1F
	db $E2,$1D,$E1,$1D,$F4,$1D,$F5,$1D,$E2,$1D,$DC,$1D,$DD,$1D,$DE,$1D
	db $DF,$1D,$90,$1D,$91,$1D,$E1,$1D,$F4,$1D,$F5,$1D,$E2,$1D,$E1,$1D

	db $0A,$68,$00,$1F
	db $D2,$1D,$D1,$1D,$D8,$1D,$E8,$1D,$D2,$1D,$EC,$1D,$ED,$1D,$EE,$1D
	db $EF,$1D,$A0,$1D,$A1,$1D,$D1,$1D,$D8,$1D,$E8,$1D,$D2,$1D,$D1,$1D

	db $0A,$88,$00,$1F
	db $E2,$1D,$E1,$1D,$E2,$1D,$E1,$1D,$E2,$1D,$FC,$1D,$FD,$1D,$FE,$1D
	db $FF,$1D,$B0,$1D,$B1,$1D,$E1,$1D,$E2,$1D,$E1,$1D,$E2,$1D,$E1,$1D

	db $0A,$A8,$00,$1F
	db $F0,$1D,$F1,$1D,$F2,$1D,$F3,$1D,$F0,$1D,$F1,$1D,$F2,$1D,$F3,$1D
	db $F0,$1D,$F1,$1D,$F2,$1D,$F3,$1D,$F0,$1D,$F1,$1D,$F2,$1D,$F3,$1D

	db $02,$0A,$80,$0B
	db $B8,$08,$BA,$08,$BA,$08,$BC,$08,$BE,$0C,$BE,$0C

	db $02,$0B,$80,$0B
	db $B9,$08,$BB,$08,$BB,$08,$BD,$08,$BF,$0C,$BF,$0C

	db $02,$92,$00,$07
	db $14,$12,$15,$12,$14,$12,$15,$12

	db $02,$B2,$00,$07
	db $16,$12,$17,$12,$16,$12,$17,$12

	db $02,$C8,$00,$1F
	db $08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A
	db $08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A

	db $02,$E8,$00,$1F
	db $18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A
	db $18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A

	db $FF,$FF

.CloudAndSmallHill:
	db $01,$EB,$00,$03
	db $D6,$10,$D7,$10

	db $02,$0A,$00,$07
	db $D8,$10,$D9,$10,$DA,$10,$DB,$10

	db $02,$2A,$00,$07
	db $DC,$10,$DD,$10,$DE,$10,$DF,$10

	db $02,$53,$00,$07
	db $01,$15,$02,$15,$03,$15,$04,$15

	db $02,$72,$00,$0B
	db $10,$15,$11,$15,$0A,$15,$05,$15,$14,$15,$15,$15

	db $02,$91,$00,$0D
	db $06,$15,$16,$15,$0A,$15,$12,$15,$0A,$15,$0A,$15,$0D,$15

	db $02,$B0,$00,$0F
	db $06,$15,$16,$15,$0A,$15,$0A,$15,$12,$95,$19,$15,$0A,$15,$1D,$15

	db $02,$C8,$00,$1F
	db $08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A
	db $08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A

	db $02,$E8,$00,$1F
	db $18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A
	db $18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A

	db $FF,$FF

.Underground:
	db $01,$C8,$40,$1E
	db $47,$0C

	db $01,$CD,$00,$07
	db $68,$08,$69,$08,$97,$08,$6A,$08

	db $01,$E8,$80,$0D
	db $45,$0C,$47,$0C,$45,$0C,$47,$0C,$45,$0C,$47,$0C,$45,$0C

	db $01,$E9,$00,$1D
	db $32,$1D,$33,$1D,$30,$1D,$31,$1D,$64,$88,$65,$88,$66,$88,$67,$88
	db $32,$1D,$33,$1D,$30,$1D,$31,$1D,$32,$1D,$33,$1D,$30,$1D

	db $02,$09,$00,$1D
	db $02,$1D,$03,$1D,$00,$1D,$01,$1D,$60,$88,$61,$88,$62,$88,$63,$88
	db $02,$1D,$03,$1D,$48,$1D,$49,$1D,$4A,$1D,$4B,$1D,$00,$1D

	db $02,$29,$00,$1D
	db $3A,$15,$13,$1D,$10,$1D,$11,$1D,$12,$1D,$13,$1D,$10,$1D,$11,$1D
	db $12,$1D,$13,$1D,$58,$1D,$59,$1D,$5A,$1D,$5B,$1D,$10,$1D

	db $02,$49,$00,$1D
	db $22,$1D,$23,$1D,$20,$1D,$21,$1D,$22,$1D,$23,$1D,$20,$1D,$21,$1D
	db $22,$1D,$23,$1D,$68,$1D,$69,$1D,$6A,$1D,$6B,$1D,$20,$1D

	db $02,$69,$00,$1D
	db $32,$1D,$33,$1D,$1D,$15,$1D,$15,$32,$1D,$33,$1D,$30,$1D,$31,$1D
	db $32,$1D,$33,$1D,$78,$1D,$79,$1D,$7A,$1D,$7B,$1D,$30,$1D

	db $02,$89,$00,$1D
	db $02,$1D,$03,$1D,$28,$15,$29,$15,$02,$1D,$03,$1D,$00,$1D,$01,$1D
	db $02,$1D,$03,$1D,$00,$1D,$01,$1D,$02,$1D,$03,$1D,$00,$1D

	db $02,$A9,$00,$1D
	db $12,$1D,$13,$1D,$10,$1D,$11,$1D,$12,$1D,$13,$1D,$10,$1D,$11,$1D
	db $12,$1D,$13,$1D,$10,$1D,$11,$1D,$12,$1D,$13,$1D,$10,$1D

	db $02,$C8,$00,$1F
	db $08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A
	db $08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A

	db $02,$E8,$00,$1F
	db $18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A
	db $18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A

	db $FF,$FF

.StandardCastle:
	db $01,$C8,$00,$1F
	db $E6,$09,$E7,$09,$E8,$09,$E9,$09,$E6,$09,$E7,$09,$E8,$09,$E9,$09
	db $E6,$09,$E7,$09,$E8,$09,$E9,$09,$E6,$09,$E7,$09,$E8,$09,$E9,$09

	db $01,$E8,$00,$1F
	db $F6,$09,$F7,$09,$F8,$09,$F9,$09,$F6,$09,$F7,$09,$F8,$09,$F9,$09
	db $F6,$09,$F7,$09,$F8,$09,$F9,$09,$F6,$09,$F7,$09,$F8,$09,$F9,$09

	db $0A,$08,$40,$1E
	db $34,$15

	db $0A,$28,$40,$1E
	db $34,$15

	db $0A,$48,$40,$1E
	db $34,$15

	db $0A,$68,$40,$1E
	db $34,$15

	db $0A,$88,$40,$1E
	db $34,$15

	db $0A,$A8,$40,$1E
	db $34,$15

	db $0A,$CB,$40,$18
	db $34,$15

	db $0A,$EB,$40,$0E
	db $34,$15

	db $0A,$0B,$C0,$0E
	db $36,$15

	db $0A,$0C,$C0,$0E
	db $37,$15

	db $0A,$0D,$C0,$0E
	db $28,$15

	db $0A,$13,$C0,$0C
	db $36,$15

	db $0A,$14,$C0,$0C
	db $37,$15

	db $0A,$15,$C0,$0C
	db $28,$15

	db $02,$C8,$00,$1F
	db $CA,$09,$CB,$09,$CA,$09,$C3,$09,$24,$00,$24,$00,$24,$00,$24,$00
	db $C0,$09,$CB,$09,$CA,$09,$C3,$09,$9B,$18,$9C,$18,$9B,$18,$9C,$18

	db $02,$E8,$00,$1F
	db $DA,$09,$DB,$09,$DA,$09,$D3,$09,$E0,$18,$E1,$18,$E0,$18,$E1,$18
	db $D0,$09,$DB,$09,$DA,$09,$D3,$09,$9D,$18,$9E,$18,$9D,$18,$9E,$18

	db $FF,$FF

.FinalCastle:
	db $09,$C8,$40,$1E
	db $34,$15

	db $09,$E8,$40,$1E
	db $34,$15

	db $0A,$08,$40,$1E
	db $34,$15

	db $0A,$28,$40,$1E
	db $34,$15

	db $0A,$48,$40,$1E
	db $34,$15

	db $0A,$68,$40,$1E
	db $34,$15

	db $0A,$88,$40,$1E
	db $34,$15

	db $0A,$A8,$40,$1E
	db $34,$15

	db $0A,$CB,$40,$18
	db $34,$15

	db $0A,$EB,$40,$0E
	db $34,$15

	db $09,$CE,$C0,$09
	db $36,$15

	db $09,$CF,$C0,$09
	db $37,$15

	db $0A,$6E,$00,$03
	db $26,$95,$27,$95

	db $0A,$8D,$00,$07
	db $24,$95,$16,$95,$17,$95,$18,$95

	db $0A,$AD,$00,$07
	db $32,$15,$22,$15,$22,$15,$23,$15

	db $09,$D2,$00,$0B
	db $A8,$1D,$A9,$1D,$8A,$1D,$8B,$1D,$A9,$5D,$AC,$1D

	db $09,$F2,$00,$0B
	db $A8,$1D,$B9,$1D,$B9,$1D,$B9,$1D,$BA,$1D,$AC,$1D

	db $0A,$12,$00,$0B
	db $A8,$1D,$89,$1D,$8A,$1D,$8B,$1D,$89,$5D,$9C,$1D

	db $0A,$32,$00,$0B
	db $A8,$1D,$99,$1D,$9A,$1D,$9B,$1D,$99,$5D,$AC,$1D

	db $0A,$52,$00,$0B
	db $A8,$1D,$A9,$1D,$8A,$1D,$8B,$1D,$A9,$5D,$AC,$1D

	db $0A,$72,$00,$0B
	db $B8,$1D,$B9,$1D,$B9,$1D,$B9,$1D,$B9,$1D,$BA,$1D

	db $09,$E9,$00,$07
	db $B0,$1D,$B1,$1D,$B1,$5D,$B0,$5D

	db $0A,$09,$00,$07
	db $B2,$1D,$E8,$1C,$E9,$1C,$B2,$5D

	db $0A,$29,$00,$07
	db $B3,$1D,$EA,$1C,$EB,$1C,$B3,$5D

	db $0A,$49,$00,$07
	db $34,$1D,$8E,$1D,$8F,$1D,$34,$1D

	db $0A,$C8,$00,$1F
	db $10,$15,$11,$15,$10,$15,$11,$15,$10,$15,$11,$15,$10,$15,$11,$15
	db $10,$15,$11,$15,$10,$15,$11,$15,$10,$15,$11,$15,$10,$15,$11,$15

	db $0A,$E8,$00,$1F
	db $20,$15,$21,$15,$20,$15,$21,$15,$20,$15,$21,$15,$20,$15,$21,$15
	db $20,$15,$21,$15,$20,$15,$21,$15,$20,$15,$21,$15,$20,$15,$21,$15

	db $02,$C8,$00,$1F
	db $CA,$09,$CB,$09,$CA,$09,$C3,$09,$24,$00,$24,$00,$24,$00,$24,$00
	db $C0,$09,$CB,$09,$CA,$09,$C3,$09,$9B,$18,$9C,$18,$9B,$18,$9C,$18

	db $02,$E8,$00,$1F
	db $DA,$09,$DB,$09,$DA,$09,$D3,$09,$E0,$18,$E1,$18,$E0,$18,$E1,$18
	db $D0,$09,$DB,$09,$DA,$09,$D3,$09,$9D,$18,$9E,$18,$9D,$18,$9E,$18

	db $FF,$FF

.MushroomLedges:									; Note: Unused. SMB1 has a copy of these data that is used however.
;$0EA5AF
	db $02,$08,$00,$0B
	db $6B,$18,$2C,$18,$6C,$18,$6D,$18,$6E,$18,$6F,$18

	db $02,$28,$00,$0B
	db $70,$18,$2D,$18,$71,$18,$72,$18,$73,$18,$74,$18

	db $02,$4A,$00,$03
	db $75,$18,$76,$18

	db $02,$6A,$C0,$09
	db $9F,$18

	db $02,$6B,$C0,$09
	db $9F,$58

	db $02,$50,$00,$0B
	db $6B,$18,$2C,$18,$6C,$18,$6D,$18,$6E,$18,$6F,$18

	db $02,$70,$00,$0B
	db $70,$18,$2D,$18,$71,$18,$72,$18,$73,$18,$74,$18

	db $02,$92,$00,$03
	db $75,$18,$76,$18

	db $02,$B2,$00,$03
	db $9F,$18,$9F,$58

	db $02,$C8,$00,$1F
	db $6B,$18,$2C,$18,$6C,$18,$6D,$18,$6E,$18,$2C,$18,$6C,$18,$6D,$18
	db $6E,$18,$2C,$18,$6C,$18,$6D,$18,$6E,$18,$2C,$18,$6C,$18,$6F,$18

	db $02,$E8,$00,$1F
	db $70,$18,$2D,$18,$71,$18,$72,$18,$73,$18,$2D,$18,$71,$18,$72,$18
	db $73,$18,$2D,$18,$71,$18,$72,$18,$73,$18,$2D,$18,$73,$18,$74,$18

	db $09,$CA,$00,$0B
	db $CA,$1D,$CB,$1D,$CC,$1D,$CD,$1D,$CE,$1D,$CF,$1D

	db $09,$EA,$00,$0B
	db $DA,$1D,$DB,$1D,$DC,$1D,$DD,$1D,$DE,$1D,$DF,$1D

	db $0A,$0C,$80,$0B
	db $F2,$1D,$E2,$1D,$E2,$1D,$E2,$1D,$E2,$1D,$E2,$1D

	db $0A,$0D,$80,$0B
	db $F3,$1D,$E3,$1D,$E3,$1D,$E3,$1D,$E3,$1D,$E3,$1D

	db $09,$F1,$00,$0B
	db $CA,$1D,$CB,$1D,$CC,$1D,$CD,$1D,$CE,$1D,$CF,$1D

	db $0A,$11,$00,$0B
	db $DA,$1D,$DB,$1D,$DC,$1D,$DD,$1D,$DE,$1D,$DF,$1D

	db $0A,$33,$80,$0B
	db $F2,$1D,$E2,$1D,$E2,$1D,$E2,$1D,$E2,$1D,$E2,$1D

	db $0A,$34,$80,$0B
	db $F3,$1D,$E3,$1D,$E3,$1D,$E3,$1D,$E3,$1D,$E3,$1D

	db $FF,$FF

.CloudLedges:
	db $02,$08,$00,$0B
	db $6B,$18,$2C,$18,$6C,$18,$6D,$18,$6E,$18,$6F,$18

	db $02,$28,$00,$0B
	db $70,$18,$2D,$18,$71,$18,$72,$18,$73,$18,$74,$18

	db $02,$50,$00,$0B
	db $6B,$18,$2C,$18,$6C,$18,$6D,$18,$6E,$18,$6F,$18

	db $02,$70,$00,$0B
	db $70,$18,$2D,$18,$71,$18,$72,$18,$73,$18,$74,$18

	db $02,$C8,$00,$1F
	db $6B,$18,$2C,$18,$6C,$18,$6D,$18,$6E,$18,$2C,$18,$6C,$18,$6D,$18
	db $6E,$18,$2C,$18,$6C,$18,$6D,$18,$6E,$18,$2C,$18,$6C,$18,$6F,$18

	db $02,$E8,$00,$1F
	db $70,$18,$2D,$18,$71,$18,$72,$18,$73,$18,$2D,$18,$71,$18,$72,$18
	db $73,$18,$2D,$18,$71,$18,$72,$18,$73,$18,$2D,$18,$73,$18,$74,$18

	db $FF,$FF

.GoombaPillarAndBridge:
	db $02,$C8,$00,$03
	db $AB,$0C,$AD,$0C

	db $02,$E8,$00,$03
	db $AC,$0C,$AE,$0C

	db $02,$CA,$40,$1B
	db $21,$32

	db $02,$AA,$00,$01
	db $81,$08

	db $02,$AB,$40,$19
	db $20,$2A

	db $0A,$0E,$80,$0F
	db $E0,$1D,$F0,$1D,$C3,$1D,$D3,$1D,$E3,$1D,$F3,$1D,$C1,$1D,$E2,$1D

	db $0A,$0F,$80,$0F
	db $E1,$1D,$F0,$5D,$C4,$1D,$D4,$1D,$E4,$1D,$F4,$1D,$D0,$1D,$F2,$1D

	db $0A,$4D,$00,$01
	db $C2,$1D

	db $0A,$50,$00,$01
	db $C5,$1D

	db $0A,$CD,$00,$01
	db $C0,$1D

	db $0A,$D0,$00,$01
	db $D1,$1D

	db $0A,$54,$80,$0B
	db $CA,$15,$F1,$15,$C6,$15,$D6,$15,$E6,$15,$F6,$15

	db $0A,$55,$80,$0B
	db $CB,$15,$F1,$55,$C7,$15,$D7,$15,$E7,$15,$F7,$15

	db $FF,$FF

.NightWithGrassLedges:
	db $02,$09,$00,$13
	db $4B,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10
	db $4D,$10,$50,$10

	db $02,$29,$00,$13
	db $4C,$10,$4E,$10,$4F,$10,$4A,$10,$4F,$10,$4A,$10,$4F,$10,$4A,$10
	db $4E,$10,$51,$10

	db $02,$4D,$80,$07
	db $04,$12,$10,$12,$00,$12,$10,$12

	db $02,$4E,$80,$07
	db $07,$12,$13,$12,$03,$12,$13,$12

	db $02,$C8,$00,$1F
	db $4B,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10
	db $4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$50,$10

	db $02,$E8,$00,$1F
	db $4C,$10,$4E,$10,$4F,$10,$4A,$10,$4F,$10,$4A,$10,$4F,$10,$4A,$10
	db $4F,$10,$4A,$10,$4F,$10,$4A,$10,$4F,$10,$4A,$10,$4E,$10,$51,$10

	db $09,$EA,$00,$01
	db $C0,$1C

	db $09,$F6,$00,$01
	db $C4,$1C

	db $09,$D5,$00,$01
	db $C1,$1C

	db $09,$CF,$00,$01
	db $C6,$1C

	db $0A,$15,$00,$01
	db $C2,$1C

	db $0A,$71,$00,$01
	db $C5,$1C

	db $0A,$36,$00,$01
	db $C5,$1C

	db $0A,$50,$00,$01
	db $C4,$1C

	db $0A,$54,$00,$01
	db $C7,$1C

	db $0A,$77,$00,$01
	db $C3,$1C

	db $0A,$6F,$00,$01
	db $C4,$1C

	db $0A,$93,$00,$01
	db $C2,$1C

	db $0A,$89,$00,$01
	db $C5,$1C

	db $0A,$6B,$00,$01
	db $C1,$1C

	db $0A,$48,$00,$01
	db $C0,$1C

	db $FF,$FF

.UnusedGrassLedges:
;$0EA8D7
	db $02,$09,$00,$13
	db $4B,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10
	db $4D,$10,$50,$10

	db $02,$29,$00,$13
	db $4C,$10,$4E,$10,$4F,$10,$4A,$10,$4F,$10,$4A,$10,$4F,$10,$4A,$10
	db $4E,$10,$51,$10

	db $02,$4D,$80,$07
	db $04,$12,$10,$12,$00,$12,$10,$12

	db $02,$4E,$80,$07
	db $07,$12,$13,$12,$03,$12,$13,$12

	db $02,$C8,$00,$1F
	db $4B,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10
	db $4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$50,$10

	db $02,$E8,$00,$1F
	db $4C,$10,$4E,$10,$4F,$10,$4A,$10,$4F,$10,$4A,$10,$4F,$10,$4A,$10
	db $4F,$10,$4A,$10,$4F,$10,$4A,$10,$4F,$10,$4A,$10,$4E,$10,$51,$10

	db $FF,$FF

.WaterfallHillsWithGrassLedges:
	db $02,$09,$00,$13
	db $4B,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10
	db $4D,$10,$50,$10

	db $02,$29,$00,$13
	db $4C,$10,$4E,$10,$4F,$10,$4A,$10,$4F,$10,$4A,$10,$4F,$10,$4A,$10
	db $4E,$10,$51,$10

	db $02,$4D,$80,$07
	db $04,$12,$10,$12,$00,$12,$10,$12

	db $02,$4E,$80,$07
	db $07,$12,$13,$12,$03,$12,$13,$12

	db $02,$C8,$00,$1F
	db $4B,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10
	db $4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$4D,$10,$50,$10

	db $02,$E8,$00,$1F
	db $4C,$10,$4E,$10,$4F,$10,$4A,$10,$4F,$10,$4A,$10,$4F,$10,$4A,$10
	db $4F,$10,$4A,$10,$4F,$10,$4A,$10,$4F,$10,$4A,$10,$4E,$10,$51,$10

	db $0A,$68,$00,$1F
	db $D4,$1D,$D5,$1D,$C1,$1D,$C2,$1D,$CA,$1C,$CB,$1C,$CA,$1C,$CB,$1C
	db $CA,$1C,$CB,$1C,$CA,$1C,$CB,$1C,$C0,$1D,$D1,$1D,$D2,$1D,$D3,$1D

	db $0A,$88,$00,$1F
	db $E8,$1D,$E9,$1D,$EA,$1D,$EB,$1D,$E0,$1D,$E1,$1D,$E4,$1D,$E5,$1D
	db $E0,$1D,$E1,$1D,$E4,$1D,$E5,$1D,$E8,$1D,$E9,$1D,$EA,$1D,$EB,$1D

	db $0A,$A8,$00,$1F
	db $F8,$1D,$F9,$1D,$FA,$1D,$FB,$1D,$F0,$1D,$F1,$1D,$F4,$1D,$F5,$1D
	db $F0,$1D,$F1,$1D,$F4,$1D,$F5,$1D,$F8,$1D,$F9,$1D,$FA,$1D,$FB,$1D

	db $0A,$C8,$00,$1F
	db $C8,$1D,$C9,$1D,$CA,$1D,$CB,$1D,$E2,$1D,$E3,$1D,$E6,$1D,$E7,$1D
	db $E2,$1D,$E3,$1D,$E6,$1D,$E7,$1D,$C8,$1D,$C9,$1D,$CA,$1D,$CB,$1D

	db $0A,$E8,$00,$1F
	db $D8,$1D,$D9,$1D,$DA,$1D,$DB,$1D,$F2,$1D,$F3,$1D,$F6,$1D,$F7,$1D
	db $F2,$1D,$F3,$1D,$F6,$1D,$F7,$1D,$D8,$1D,$D9,$1D,$DA,$1D,$DB,$1D

	db $FF,$FF

.UnusedGrassPlain:
;$0EAAAF
	db $02,$8A,$00,$0B
	db $14,$12,$15,$12,$14,$12,$15,$12,$14,$12,$15,$12

	db $02,$AA,$00,$0B
	db $16,$12,$17,$12,$16,$12,$17,$12,$16,$12,$17,$12

	db $02,$4C,$80,$07
	db $B8,$08,$BC,$08,$BE,$0C,$BE,$0C

	db $02,$4D,$80,$07
	db $B9,$08,$BD,$08,$BF,$0C,$BF,$0C

	db $01,$F3,$00,$03
	db $D6,$10,$D7,$10

	db $02,$12,$00,$07
	db $D8,$10,$D9,$10,$DA,$10,$DB,$10

	db $02,$32,$00,$07
	db $DC,$10,$DD,$10,$DE,$10,$DF,$10

	db $02,$C8,$00,$1F
	db $08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A
	db $08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A

	db $02,$E8,$00,$1F
	db $18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A
	db $18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A

	db $FF,$FF

.SnowyNightPlain:									; Note: Unused. SMB1 has a copy of these data that is used however.
;$0EAB51
	db $02,$0A,$80,$0B
	db $B8,$08,$BA,$08,$BA,$08,$BC,$08,$BE,$0C,$BE,$0C

	db $02,$0B,$80,$0B
	db $B9,$08,$BB,$08,$BB,$08,$BD,$08,$BF,$0C,$BF,$0C

	db $02,$92,$00,$07
	db $14,$12,$15,$12,$14,$12,$15,$12

	db $02,$B2,$00,$07
	db $16,$12,$17,$12,$16,$12,$17,$12

	db $02,$C8,$00,$1F
	db $08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A
	db $08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A,$08,$0A,$09,$0A

	db $02,$E8,$00,$1F
	db $18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A
	db $18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A,$18,$0A,$19,$0A

	db $FF,$FF

DATA_0EABD3:
	db $01,$EB,$40,$02
	db $24,$00

	db $02,$0A,$40,$06
	db $24,$00

	db $02,$2A,$40,$06
	db $24,$00

	db $02,$53,$40,$06
	db $24,$00

	db $02,$72,$40,$0A
	db $24,$00

	db $02,$91,$40,$0C
	db $24,$00

	db $02,$B0,$40,$0E
	db $24,$00

	db $FF,$FF

DATA_0EABFF:
	db $09,$EB,$00,$09
	db $C0,$1C,$24,$00,$C5,$1C,$24,$00,$C3,$1C

	db $0A,$0C,$00,$05
	db $C2,$1C,$24,$00,$C1,$1C

	db $0A,$29,$00,$01
	db $C2,$1C

	db $0A,$4B,$00,$01
	db $C1,$1C

	db $0A,$14,$00,$01
	db $C5,$1C

	db $0A,$53,$00,$07
	db $C3,$1C,$24,$00,$C4,$1C,$24,$00

	db $0A,$68,$00,$1F
	db $C6,$15,$C7,$15,$C8,$15,$C9,$15,$CA,$15,$CB,$15,$C6,$1C,$CD,$15
	db $C6,$15,$C7,$15,$C8,$15,$C9,$15,$CA,$15,$CB,$15,$CC,$15,$CD,$15

	db $0A,$88,$00,$1F
	db $D6,$15,$D7,$15,$D8,$15,$D9,$15,$DA,$15,$DB,$15,$DC,$15,$DD,$15
	db $D6,$15,$D7,$15,$D8,$15,$D9,$15,$DA,$15,$DB,$15,$DC,$15,$DD,$15

	db $0A,$A8,$00,$1F
	db $E6,$15,$E7,$15,$E8,$15,$E9,$15,$EA,$15,$EB,$15,$EC,$15,$ED,$15
	db $E6,$15,$E7,$15,$E8,$15,$E9,$15,$EA,$15,$EB,$15,$EC,$15,$ED,$15

	db $FF,$FF

;--------------------------------------------------------------------

DATA_0EACA3:
	dw $0000,$0020,$0040,$0060,$0080,$00A0
	dw $00C0,$00E0,$0100,$0120,$0140,$0160
	dw $0180,$01A0,$01C0,$01E0,$0200,$0220
	dw $0240,$0260,$0280,$02A0,$02C0,$02E0
	dw $0300,$0320,$0340,$03A0,$03E0,$03C0
	dw $03E0,$0420,$0360,$0380,$02E0,$02E0
	dw $02E0,$02E0,$0500,$0520,$0540,$0560
	dw $0580,$05C0,$05E0,$0600,$0620,$0640
	dw $0660,$0740,$0780,$07A0,$0460,$04A0
	dw $04C0,$04E0,$05A0,$0680,$06A0,$06C0
	dw $06E0,$0700,$0400,$0720,$0440,$0480

DATA_0EAD27:
	dw $42DD,$7FFF,$1084,$3800,$7708,$035F,$0259,$3800,$7708,$7FFF,$73B9,$6335,$7708,$7FFF,$722B,$65C8
	dw $7708,$7FFF,$1084,$1BDF,$027F,$0139,$1ADA,$0DF3,$050D,$4F7F,$3298,$15B1,$3FFF,$45BF,$20D4,$2D3A
	dw $7BAF,$7FFF,$1084,$57F3,$0340,$01A0,$0000,$0000,$0000,$04D0,$0554,$11D8,$125C,$2BAA,$3800,$0A62
	dw $7BAF,$7FFF,$0842,$2B30,$14B8,$0D3F,$029F,$035F,$0008,$008E,$1575,$1A3A,$3F5F,$5AD6,$2529,$3DEF
	dw $7BAF,$7FFF,$1084,$7FB8,$72B0,$32FC,$2256,$11CF,$054B,$09E6,$1AAB,$2B30,$3BB4,$287F,$000E,$0015
	dw $7BAF,$376D,$1084,$22A9,$219B,$1538,$04B4,$0470,$040C,$21C2,$3246,$3EA9,$4B0C,$534E,$01C3,$1646
	dw $772F,$7FFF,$1084,$729F,$51B8,$30B0,$7E97,$6DB0,$54EA,$294A,$4210,$5EF7,$6F7B,$571F,$251C,$3E3F
	dw $7BAF,$7FFF,$1084,$778C,$6F4A,$6708,$5EC6,$5684,$4E42,$21C2,$3246,$42CA,$4F2D,$6372,$1084,$1084
	dw $45BC,$7FFF,$14A5,$01A5,$0249,$02CD,$4631,$5AD6,$0000,$0351,$0019,$011F,$061F,$129F,$017A,$0113
	dw $45BC,$7FFF,$14A5,$008D,$0112,$19D9,$2A9E,$36FF,$0000,$7FFF,$0813,$2D9B,$465F,$539F,$1B9F,$1A5F
	dw $45BC,$7FFF,$14A5,$013B,$027F,$179F,$0135,$265E,$0000,$0C9B,$0135,$261D,$42DF,$6ADF,$4A1D,$28FA
	dw $734E,$7FFF,$14A5,$3D84,$5229,$27BF,$31BB,$3ABF,$0000,$152F,$355D,$525F,$169B,$1C9F,$0C19,$0C19
	dw $45BC,$7FFF,$14A5,$013B,$027F,$179F,$0135,$265E,$0000,$0C9B,$0220,$0EE0,$23A0,$6ADF,$4A1D,$28FA
	dw $45BC,$7FFF,$14A5,$0203,$0F0A,$2BF1,$0135,$265E,$0000,$3F5F,$294A,$4631,$6318,$1A3A,$1575,$008E
	dw $45BC,$7FFF,$14A5,$0055,$0C3E,$3D9F,$0135,$265E,$0000,$42DF,$4025,$74D2,$7EB2,$261D,$1557,$00AF
	dw $45BC,$7FFF,$14A5,$0111,$0DB9,$22DD,$2D9C,$3ABF,$0000,$0000,$14EC,$1DD4,$369A,$20BC,$1096,$000F
	dw $7F92,$7FFF,$1084,$5B0C,$568A,$5208,$4DA6,$4944,$44E2,$0887,$14EA,$214D,$298F,$2936,$0831,$1CD3
	dw $7F92,$7FFF,$1084,$722B,$65C8,$5D86,$7F36,$6DB0,$54EA,$294A,$4210,$5EF7,$6F7B,$52FF,$35BC,$469C
	dw $7F92,$7FFF,$0000,$0A1F,$011D,$0013,$0000,$0000,$0000,$0887,$14EA,$214D,$298F,$4280,$2940,$35E0
	dw $772F,$7FFF,$1084,$57F0,$0340,$01A0,$1BDF,$027F,$0139,$3CE1,$5186,$662B,$7AD0,$2BAA,$3800,$0A62
	dw $772F,$7FFF,$1084,$0000,$0000,$0000,$1ADA,$0DF3,$050D,$3961,$4E06,$62AB,$7750,$5AD6,$2529,$3DEF
	dw $772F,$7FFF,$0000,$264E,$49EC,$41AA,$3968,$3126,$28E4,$1C41,$28A3,$3506,$3D48,$0525,$0D88,$19EB
	dw $772F,$6739,$0000,$2CC5,$3D89,$3DCD,$4E51,$2EF8,$1E74,$1C41,$28A3,$3506,$3D48,$4210,$2108,$318C
	dw $45BC,$7FFF,$14A5,$2CE0,$41A3,$5648,$6AED,$7F71,$0000,$7FFF,$3013,$4D9B,$625F,$539F,$1B9F,$1A5F
	dw $45BC,$7FFF,$14A5,$1E22,$2F01,$3FE0,$0135,$1A9F,$0000,$7750,$294A,$4631,$6318,$62AB,$4E06,$3961
	dw $772F,$7FFF,$1084,$3B1F,$035F,$029F,$11D7,$0153,$00CF,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dw $772F,$7FFF,$14A5,$05BF,$001E,$0017,$46BF,$365D,$25BB,$04EF,$0D73,$4F7F,$7F0F,$0000,$0000,$0000
	dw $45BC,$7FFF,$14C5,$256D,$3A12,$4A96,$5B1A,$6B9E,$0000,$7FFF,$210E,$35B7,$4E79,$539F,$1B9F,$1A5F
	dw $45BC,$7FFF,$14A5,$1E22,$2F01,$3FE0,$0135,$1A9F,$0000,$5B1A,$294A,$4631,$6318,$4A96,$3A12,$256D
	dw $7708,$7FFF,$1084,$57F3,$0340,$01A0,$0000,$0000,$0000,$1D28,$2DAC,$3E30,$4EB4,$2BAA,$3800,$0A62
	dw $7708,$15EF,$114C,$012E,$00EC,$00AA,$090A,$1D63,$1521,$0864,$10A6,$18E8,$212A,$296C,$31AE,$39F0
	dw $7708,$7FFF,$1084,$097F,$005A,$000F,$7E97,$6DB0,$54EA,$256D,$3A12,$4A96,$5B1A,$571F,$251C,$3E3F
	dw $7708,$7FFF,$1084,$097F,$005A,$000F,$7E97,$6DB0,$54EA,$256D,$3A12,$4A96,$5B1A,$5AD6,$2529,$3DEF
	dw $7708,$7FFF,$3DAD,$314A,$24E7,$01F6,$0192,$012F,$00AC,$0864,$10A6,$18E8,$212A,$296C,$0088,$00CA
	dw $7BAF,$7FFF,$0842,$2B30,$14B8,$0D3F,$029F,$035F,$0008,$008E,$1575,$1A3A,$3F5F,$6F7B,$5AD6,$3DEF
	dw $7708,$7FFF,$1084,$77BD,$5EF7,$3DEF,$1BDF,$027F,$0139,$0492,$0D17,$25DD,$3A7F,$6F7B,$3800,$5294
	dw $3908,$7FFF,$0842,$2B30,$14B8,$0D3F,$029F,$035F,$0008,$008E,$1575,$1A3A,$3F5F,$6F7B,$5AD6,$3DEF
	dw $7708,$7FFF,$1084,$77BD,$5EF7,$3DEF,$1BDF,$027F,$0139,$0492,$0D17,$25DD,$3A7F,$6F7B,$3800,$5294
	dw $3908,$4D4B,$18C6,$4509,$4D2D,$44EB,$3CA9,$7FFF,$73B9,$21C2,$3246,$42CA,$4F2D,$6372,$30C3,$3904
	dw $3C63,$7F7B,$7E73,$5D6B,$6FFB,$4FF3,$2EEB,$0DE3,$3FFF,$1EF7,$0A52,$01CE,$6F7F,$4E7F,$2D77,$0C75
	dw $7708,$7FFF,$1084,$57F3,$0340,$01A0,$1BDF,$027F,$0139,$04D0,$0554,$11D8,$125C,$2BAA,$3800,$0A62
	dw $7708,$7FFF,$1084,$0000,$0000,$0000,$1ADA,$0DF3,$050D,$008E,$1575,$1A3A,$3F5F,$5AD6,$2529,$3DEF
	dw $7708,$7FFF,$1084,$7FB8,$72B0,$32FC,$2256,$11CF,$054B,$5AD6,$6739,$739C,$7FFF,$287F,$000E,$0015
	dw $7BAF,$7FFF,$1CE7,$7FF9,$7F93,$770F,$32DF,$225B,$11D7,$01B3,$0A37,$1ABB,$2F5F,$1D3C,$0034,$0CB8
	dw $7BAF,$7FFF,$1CE7,$4EFF,$42BF,$53FF,$479D,$3B3A,$2ED7,$2E7E,$3ADF,$473F,$4B9F,$0000,$0000,$0000
	dw $7BAF,$7F38,$216D,$7FBF,$7F38,$5B3B,$4AB7,$3A33,$29AF,$2A13,$3A97,$4B1B,$5B9E,$76B4,$69C9,$7230
	dw $7BAF,$7FFF,$1084,$2B96,$1713,$3B9D,$12F8,$0A74,$01F0,$2A03,$3A87,$4B0B,$576E,$6BB3,$020B,$028F
	dw $7BAF,$130F,$05C5,$0A8B,$01F8,$0172,$010D,$7FFF,$73B9,$21C2,$3246,$3EA9,$4B0C,$5FB1,$0589,$0A29
	dw $7BAF,$7FFF,$1084,$7FFF,$6FD9,$7FFF,$777B,$66F7,$5673,$4E7F,$5EFF,$6F7F,$7FFF,$6372,$4ED1,$5F55
	dw $7BAF,$7FFF,$0883,$4EF4,$4B19,$3A95,$2A11,$198D,$0909,$10A7,$212B,$31AF,$4233,$52B7,$2DEC,$3E70
	dw $7708,$15EF,$114C,$012E,$00EC,$00AA,$090A,$1D63,$1521,$0C63,$14A3,$1CE5,$2527,$2D69,$35AB,$3DED
	dw $7708,$0C63,$1CE5,$2D69,$2527,$1D0B,$18EA,$10A8,$0866,$0C63,$14A3,$1CE5,$2527,$2D69,$00D6,$015A
	dw $7F92,$7FFF,$0842,$4631,$3DEF,$35AD,$2D6B,$2529,$1CE7,$10EA,$1D4D,$29B0,$3613,$3208,$1942,$25A5
	dw $7F92,$7FFF,$29F8,$67FF,$4BDF,$3B7E,$331B,$26B8,$1A55,$2E79,$3ADC,$473F,$539F,$4F1F,$365B,$42BE
	dw $7F92,$7FFF,$29F8,$6BFF,$5FFC,$53B9,$4756,$3AF3,$2E90,$2E79,$3ADC,$473F,$539F,$4F1F,$365B,$42BE
	dw $7BAF,$7FFF,$1084,$29F9,$1975,$1A98,$0E15,$0191,$010D,$184D,$20D1,$2955,$31D9,$3A5D,$006E,$08F1
	dw $7BAF,$02D4,$1084,$7FFF,$3E99,$2E15,$1D91,$092E,$00AA,$21C2,$3246,$3EA9,$4B0C,$534E,$6739,$739C
	dw $45BC,$7FFF,$0C63,$40C0,$5565,$65E9,$4631,$5AD6,$0000,$766D,$0012,$101A,$311F,$367A,$21D5,$0D30
	dw $7708,$7FFF,$1084,$53BF,$033E,$025C,$4A5F,$315F,$001D,$004A,$04B2,$0A1C,$133D,$677F,$017C,$0019

;--------------------------------------------------------------------

DATA_0EB487:
	dw $1084,$7FFF,$04CA,$0155,$1A1C,$1B3E,$2DFF,$471F,$56B5,$1173,$1242,$3329,$1C9F,$0C18,$79E6,$5144
	dw $7BAF,$7FFF,$1084,$53BF,$033E,$025C,$0000,$0000,$0000,$1058,$015F,$0E1F,$140E,$02BF,$017C,$0019
	dw $1084,$7FFF,$0C63,$0113,$11DA,$1B3E,$2DFF,$471F,$5EF7,$152F,$0012,$0C19,$1C9F,$762D,$7189,$5905

;--------------------------------------------------------------------

DATA_0EB4E7:
	db $D0,$04,$B1,$20,$C1,$23,$D1,$14,$92,$04,$A2,$23,$B2,$14,$C2,$47
	db $83,$20,$93,$14,$A3,$47,$74,$04,$84,$14,$94,$47,$55,$04,$65,$09
	db $75,$06,$85,$47,$D5,$17,$46,$20,$56,$14,$66,$0C,$76,$14,$86,$47
	db $C6,$17,$D6,$14,$47,$21,$57,$01,$67,$47,$B7,$10,$C7,$14,$48,$22
	db $58,$08,$68,$1A,$78,$47,$B8,$13,$59,$15,$69,$1B,$79,$47,$A9,$10
	db $B9,$14,$4A,$20,$5A,$14,$6A,$47,$AA,$18,$4B,$22,$5B,$08,$6B,$47
	db $9B,$10,$AB,$14,$5C,$06,$6C,$47,$8C,$17,$9C,$02,$5D,$05,$6D,$08
	db $7D,$47,$8D,$19,$9D,$03,$AD,$1A,$BD,$08,$6E,$22,$7E,$08,$8E,$47
	db $9E,$19,$AE,$2F,$BE,$11,$CE,$08,$7F,$21,$8F,$47,$CF,$19,$60,$A0
	db $70,$14,$80,$47,$61,$21,$71,$2C,$81,$47,$62,$21,$72,$2D,$82,$47
	db $63,$05,$73,$08,$83,$1A,$93,$47,$74,$22,$84,$0B,$94,$22,$A4,$08
	db $B4,$47,$A5,$21,$B5,$47,$A6,$05,$B6,$08,$C6,$47,$B7,$22,$C7,$08
	db $D7,$07,$18,$20,$28,$29,$C8,$22,$D8,$08,$09,$20,$19,$14,$29,$0C
	db $39,$09,$D9,$05,$0A,$21,$1A,$2C,$2A,$07,$3A,$0A,$0B,$21,$1B,$2D
	db $2B,$07,$3B,$0A,$0C,$22,$1C,$08,$2C,$1A,$3C,$2B,$1D,$22,$2D,$0B
	db $D0,$A0,$A1,$20,$B1,$63,$D1,$14,$82,$04,$92,$23,$A2,$14,$B2,$47
	db $33,$04,$43,$23,$53,$09,$63,$20,$73,$23,$83,$14,$93,$47,$24,$20
	db $34,$02,$44,$47,$54,$0C,$64,$14,$25,$22,$35,$03,$45,$47,$36,$05
	db $46,$08,$56,$47,$37,$20,$47,$19,$57,$08,$67,$47,$28,$04,$38,$14
	db $48,$47,$29,$22,$39,$08,$49,$47,$3A,$05,$4A,$10,$5A,$14,$6A,$47
	db $8A,$1A,$9A,$10,$AA,$14,$3B,$20,$4B,$14,$5B,$47,$7B,$1A,$8B,$0B
	db $9B,$21,$9C,$10,$3C,$21,$4C,$01,$5C,$47,$7C,$0A,$8C,$00,$9C,$05
	db $AC,$08,$BC,$1A,$CC,$08,$3D,$05,$4D,$08,$5D,$07,$6D,$1A,$7D,$0B
	db $AD,$22,$BD,$0B,$CD,$06,$DD,$1A,$4E,$22,$5E,$24,$6E,$0B,$CE,$05
	db $DE,$0B,$B0,$84,$C0,$23,$D0,$29,$A1,$20,$B1,$47,$82,$20,$92,$0F
	db $A2,$14,$B2,$47,$13,$20,$23,$09,$73,$04,$83,$02,$93,$47,$04,$20
	db $14,$14,$24,$07,$34,$29,$74,$15,$84,$03,$94,$47,$05,$21,$15,$01
	db $25,$07,$35,$0A,$65,$04,$75,$47,$85,$18,$06,$05,$16,$08,$26,$1A
	db $36,$0B,$66,$06,$76,$10,$86,$11,$96,$08,$A6,$47,$17,$22,$27,$0B
	db $67,$21,$77,$18,$87,$47,$58,$20,$68,$14,$78,$19,$88,$08,$98,$47
	db $A8,$1A,$B8,$08,$39,$04,$49,$0F,$59,$14,$69,$47,$89,$11,$99,$1F
	db $A9,$1B,$B9,$19,$C9,$08,$2A,$27,$3A,$28,$4A,$47,$AA,$08,$CA,$13
	db $3B,$22,$4B,$08,$5B,$47,$6B,$1A,$7B,$08,$AB,$11,$BB,$1C,$CB,$08
	db $4C,$05,$5C,$24,$6C,$0B,$7C,$05,$8C,$08,$9C,$47,$CC,$19,$8D,$22
	db $9D,$08,$AD,$47,$9E,$05,$AE,$08,$BE,$1A,$CE,$08,$DE,$07,$AF,$22
	db $BF,$0B,$CF,$05,$DF,$0B,$D0,$A0,$91,$20,$A1,$29,$C1,$20,$D1,$14
	db $72,$04,$82,$23,$92,$14,$A2,$0C,$B2,$0F,$C2,$14,$D2,$07,$43,$20
	db $53,$09,$63,$20,$73,$14,$83,$47,$34,$04,$44,$14,$54,$0C,$64,$1D
	db $74,$14,$84,$47,$25,$20,$35,$14,$45,$2C,$55,$47,$26,$22,$36,$08
	db $46,$2D,$56,$47,$37,$05,$47,$08,$57,$47,$97,$17,$A7,$2E,$48,$22
	db $58,$08,$68,$1A,$78,$47,$88,$10,$98,$14,$A8,$0C,$59,$15,$69,$1B
	db $79,$47,$89,$18,$99,$01,$4A,$20,$5A,$14,$6A,$47,$8A,$19,$9A,$08
	db $AA,$1A,$4B,$21,$5B,$01,$6B,$47,$9B,$19,$AB,$1B,$4C,$05,$5C,$08
	db $6C,$47,$5D,$22,$6D,$25,$7D,$28,$8D,$47,$7E,$22,$8E,$08,$9E,$1A
	db $AE,$08,$BE,$07,$CE,$1A,$DE,$08,$8F,$05,$9F,$0B,$AF,$05,$BF,$24
	db $CF,$0B,$DF,$05,$A1,$84,$B1,$09,$D1,$20,$02,$04,$12,$23,$22,$29
	db $92,$20,$A2,$14,$B2,$0C,$C2,$0F,$D2,$14,$03,$21,$13,$2C,$23,$0A
	db $63,$20,$73,$23,$83,$26,$93,$28,$A3,$01,$B3,$47,$04,$21,$14,$2D
	db $24,$0A,$54,$20,$64,$14,$74,$47,$94,$11,$A4,$08,$05,$05,$15,$24
	db $25,$0B,$55,$21,$65,$01,$75,$47,$56,$22,$66,$08,$76,$47,$86,$17
	db $96,$14,$67,$05,$77,$08,$87,$19,$97,$08,$A7,$47,$68,$20,$78,$14
	db $88,$47,$98,$11,$A8,$08,$59,$04,$69,$14,$79,$2C,$89,$47,$A9,$18
	db $5A,$22,$6A,$08,$7A,$2D,$8A,$47,$AA,$19,$BA,$08,$6B,$22,$7B,$08
	db $8B,$47,$BB,$11,$CB,$1B,$DB,$08,$7C,$22,$8C,$08,$9C,$47,$AC,$1A
	db $BC,$08,$DC,$19,$8D,$05,$9D,$24,$AD,$0B,$BD,$05,$CD,$08,$DD,$07
	db $CE,$22,$DE,$08,$DF,$22,$D0,$A0,$B1,$04,$C1,$0F,$D1,$14,$A2,$20
	db $B2,$14,$C2,$47,$93,$04,$A3,$47,$94,$21,$A4,$01,$B4,$47,$95,$22
	db $A5,$08,$B5,$47,$A6,$22,$B6,$08,$C6,$47,$77,$04,$87,$09,$B7,$15
	db $C7,$08,$D7,$07,$68,$20,$78,$14,$88,$0C,$98,$09,$A8,$20,$B8,$14
	db $C8,$19,$D8,$08,$49,$20,$59,$0F,$69,$14,$79,$47,$99,$0C,$A9,$14
	db $3A,$04,$4A,$14,$5A,$47,$3B,$06,$4B,$47,$2C,$20,$3C,$14,$4C,$2C
	db $5C,$47,$2D,$22,$3D,$08,$4D,$2D,$5D,$47,$7D,$1A,$8D,$08,$3E,$05
	db $4E,$47,$6E,$1A,$7E,$0B,$8E,$15,$9E,$08,$4F,$22,$5F,$08,$6F,$0C
	db $7F,$23,$8F,$14,$9F,$19,$AF,$08,$BF,$47,$40,$A0,$50,$14,$60,$47
	db $A0,$19,$B0,$1C,$C0,$08,$D0,$07,$31,$20,$41,$14,$51,$47,$32,$21
	db $42,$47,$52,$01,$33,$22,$43,$08,$53,$47,$44,$05,$54,$08,$64,$47
	db $45,$20,$55,$14,$65,$47,$36,$04,$46,$0E,$56,$14,$66,$47,$76,$17
	db $86,$14,$27,$20,$37,$47,$67,$10,$77,$14,$28,$05,$38,$24,$48,$08
	db $58,$47,$68,$18,$49,$05,$59,$10,$69,$14,$79,$2C,$89,$47,$5A,$22
	db $6A,$08,$7A,$2D,$8A,$47,$6B,$05,$7B,$08,$8B,$47,$7C,$22,$8C,$08
	db $9C,$1A,$AC,$24,$BC,$08,$CC,$47,$8D,$05,$9D,$0B,$BD,$22,$CD,$08
	db $DD,$07,$CE,$05,$DE,$08,$DF,$22,$D2,$A0,$53,$20,$63,$09,$C3,$04
	db $D3,$14,$44,$04,$54,$14,$64,$0C,$74,$23,$84,$09,$94,$04,$A4,$09
	db $C4,$05,$D4,$08,$35,$20,$45,$14,$55,$47,$75,$10,$85,$0E,$95,$14
	db $A5,$0C,$B5,$29,$C5,$20,$D5,$14,$36,$21,$46,$47,$76,$14,$B6,$0C
	db $C6,$14,$27,$20,$37,$47,$57,$01,$28,$05,$38,$08,$48,$47,$A8,$10
	db $B8,$2E,$39,$22,$49,$08,$59,$1A,$69,$08,$79,$47,$99,$17,$A9,$14
	db $B9,$0C,$4A,$05,$5A,$0B,$6A,$22,$7A,$08,$8A,$17,$9A,$14,$AA,$47
	db $6B,$04,$7B,$14,$8B,$19,$9B,$08,$AB,$47,$6C,$05,$7C,$24,$8C,$17
	db $9C,$14,$AC,$47,$7D,$04,$8D,$14,$9D,$47,$7E,$21,$8E,$47,$9E,$2C
	db $7F,$21,$8F,$47,$9F,$2D,$70,$85,$80,$08,$90,$47,$71,$20,$81,$19
	db $91,$08,$A1,$1A,$B1,$08,$C1,$47,$52,$04,$62,$0F,$72,$14,$82,$47
	db $92,$19,$A2,$1B,$B2,$19,$C2,$08,$43,$20,$53,$02,$63,$47,$C3,$19
	db $D3,$08,$44,$05,$54,$03,$64,$47,$D4,$19,$55,$22,$65,$1B,$75,$47
	db $66,$05,$76,$08,$86,$47,$77,$22,$87,$08,$97,$1A,$A7,$08,$B7,$47
	db $88,$05,$98,$0B,$A8,$05,$B8,$08,$C8,$47,$B9,$22,$C9,$08,$D9,$07
	db $CA,$05,$DA,$0B,$20,$84,$30,$23,$40,$09,$11,$20,$21,$14,$31,$07
	db $41,$0C,$51,$09,$12,$21,$22,$01,$32,$07,$42,$07,$52,$0A,$13,$05
	db $23,$08,$33,$07,$43,$07,$53,$0B,$A3,$04,$B3,$23,$C3,$09,$24,$22
	db $34,$24,$44,$0B,$94,$20,$A4,$14,$B4,$07,$C4,$17,$D4,$0F,$85,$20
	db $95,$14,$A5,$47,$C5,$14,$86,$22,$96,$08,$A6,$47,$67,$20,$77,$09
	db $87,$04,$97,$13,$A7,$47,$58,$20,$68,$14,$78,$0C,$88,$14,$98,$13
	db $A8,$47,$49,$04,$59,$14,$69,$47,$89,$17,$99,$14,$A9,$2C,$4A,$06
	db $5A,$47,$8A,$19,$9A,$08,$AA,$2D,$3B,$20,$4B,$14,$5B,$47,$9B,$19
	db $AB,$08,$3C,$21,$4C,$47,$5C,$10,$6C,$2E,$7C,$10,$8C,$14,$9C,$10
	db $AC,$14,$3D,$05,$4D,$10,$5D,$14,$6D,$0C,$7D,$14,$8D,$47,$9D,$14
	db $4E,$06,$5E,$47,$6E,$2C,$4F,$05,$5F,$08,$6F,$2D,$7F,$47,$50,$A2
	db $60,$08,$70,$47,$61,$06,$71,$47,$52,$20,$62,$11,$72,$1F,$82,$08
	db $92,$47,$53,$21,$63,$47,$83,$19,$93,$1F,$A3,$08,$54,$05,$64,$08
	db $74,$47,$A4,$19,$B4,$08,$65,$22,$75,$08,$85,$47,$B5,$13,$76,$06
	db $86,$47,$B6,$11,$C6,$08,$67,$04,$77,$14,$87,$2C,$97,$47,$C7,$19
	db $D7,$08,$68,$22,$78,$08,$88,$2D,$98,$47,$D8,$11,$79,$05,$89,$08
	db $99,$47,$7A,$20,$8A,$14,$9A,$47,$7B,$22,$8B,$24,$9B,$08,$AB,$47
	db $9C,$21,$AC,$47,$BC,$1A,$CC,$08,$9D,$22,$AD,$24,$BD,$2B,$CD,$22
	db $DD,$08,$DE,$05,$FF,$FF

;--------------------------------------------------------------------

; Note: Layer 3 cloud tilemap.

DATA_0EBB6D:
	db $5C,$08,$5C,$08,$5C,$08,$5C,$08,$55,$08,$56,$08,$55,$08,$56,$48
	db $54,$08,$53,$08,$55,$08,$56,$08,$55,$08,$56,$48,$54,$48,$53,$08
	db $5C,$08,$57,$08,$57,$08,$54,$08,$57,$48,$54,$48,$5C,$08,$57,$48
	db $57,$48,$54,$48,$57,$08,$54,$08,$53,$08,$53,$08,$53,$08,$53,$08
	db $53,$08,$53,$08,$54,$48,$53,$08,$50,$88,$51,$88,$53,$08,$52,$88
	db $53,$08,$52,$C8,$53,$08,$52,$88,$53,$08,$52,$C8,$50,$C8,$51,$C8
	db $53,$08,$54,$88,$53,$08,$53,$08,$54,$C8,$54,$48,$57,$C8,$57,$48
	db $58,$88,$58,$08,$53,$08,$53,$08,$57,$88,$57,$08,$54,$88,$54,$08
	db $53,$08,$5B,$08,$5B,$08,$54,$08,$5B,$48,$54,$48,$53,$88,$5B,$48
	db $53,$08,$54,$88,$54,$48,$53,$08,$5B,$48,$54,$48,$5B,$08,$54,$08
	db $54,$08,$53,$08,$53,$08,$53,$08,$57,$48,$54,$48,$57,$08,$5B,$48
	db $57,$48,$5B,$08,$57,$08,$54,$08,$59,$08,$58,$08,$5A,$08,$53,$08
	db $5A,$48,$53,$08,$5A,$08,$53,$08,$5A,$48,$53,$08,$59,$48,$58,$48
	db $53,$08,$53,$08,$53,$08,$54,$C8,$54,$C8,$5B,$C8,$5B,$C8,$53,$08
	db $54,$C8,$54,$48,$5B,$C8,$5B,$48,$5B,$88,$5B,$08,$54,$88,$54,$08
	db $54,$C8,$53,$08,$54,$88,$53,$08,$53,$08,$53,$08,$58,$C8,$58,$48
	db $51,$08,$50,$08,$52,$08,$53,$08,$52,$48,$53,$08,$52,$08,$53,$08
	db $52,$48,$53,$08,$51,$48,$50,$48,$50,$88,$50,$08,$53,$08,$53,$08
	db $53,$08,$53,$08,$50,$C8,$50,$48,$54,$C8,$5B,$08,$57,$C8,$57,$48
	db $57,$88,$57,$08,$54,$88,$5B,$48,$5C,$08,$57,$08,$5C,$08,$57,$48
	db $54,$08,$53,$08,$54,$48,$53,$08,$57,$88,$5C,$08,$54,$88,$57,$88
	db $54,$C8,$57,$C8,$54,$88,$57,$88,$54,$C8,$57,$C8,$57,$C8,$5C,$08
	db $53,$08,$53,$08,$55,$08,$56,$08,$55,$08,$56,$48,$53,$08,$53,$08
	db $58,$88,$59,$88,$53,$08,$5A,$88,$53,$08,$5A,$C8,$58,$C8,$59,$C8

if !Define_Global_ROMToAssemble&(!ROM_SMBLL_U) != $00
%FREE_BYTES(NULLROM, 1600, $FF)
elseif !Define_Global_ROMToAssemble&(!ROM_SMBLL_E) != $00
%FREE_BYTES(NULLROM, 1519, $FF)
elseif !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E) != $00
%FREE_BYTES(NULLROM, 1474, $FF)
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2) != $00
%FREE_BYTES(NULLROM, 289, $FF)
elseif !Define_Global_ROMToAssemble&(!ROM_SMBLL_J) != $00
%FREE_BYTES(NULLROM, 334, $FF)
else
%FREE_BYTES(NULLROM, 1555, $FF)
endif

;--------------------------------------------------------------------

DATA_0EC300:
	db $FF

DATA_0EC301:
	db $90,$31,$39,$F1,$BF,$F7,$30,$33,$E7,$A3,$03,$A7,$03,$CD,$41,$0F
	db $F6,$A0,$ED,$47,$FD

DATA_0EC316:
	db $38,$11,$0F,$F6,$20,$AD,$40,$3D,$C7,$FD

DATA_0EC320:
	db $10,$00,$0B,$13,$5B,$14,$6A,$42,$C7,$12,$C6,$42,$1B,$94,$2A,$42
	db $53,$13,$62,$41,$97,$17,$A6,$45,$6E,$81,$8F,$F7,$30,$02,$E8,$12
	db $3A,$68,$7A,$E0,$6A,$F0,$6A,$6D,$C5,$00,$6A,$FD

;--------------------------------------------------------------------

CODE_0EC34C:
	PHB
	PHK
	PLB
	JSL.l CODE_0EC374
	STA.w $0750
	AND.b #$60
	ASL
	ROL
	ROL
	ROL
	STA.b $5C
	STA.b $BA
	LDA.w $075F
	CMP.b #$07
	BNE.b CODE_0EC372
	LDA.w $0760
	CMP.b #$03
	BNE.b CODE_0EC372
	LDA.b #$03
	STA.b $BA
CODE_0EC372:
	PLB
	RTL

CODE_0EC374:
	PHB
	PHK
	PLB
	LDY.w $075F
	CPY.b #$0D
	BCC.b CODE_0EC389
	STZ.w $0760
	STZ.w $075C
	LDY.b #$00
	STY.w $075F
CODE_0EC389:
	LDA.w DATA_0EC499,y
	CLC
	ADC.w $0760
	TAY
	LDA.w SMBLL_LevelIDsAndTileset,y
	PLB
	RTL

;--------------------------------------------------------------------

SMBLL_LoadWorldAToDOverworldLevelHack:
.Main:
;$0EC396
	PHA
	LDA.w !RAM_SMBLL_Player_CurrentWorld
	CMP.b #$09
	BCC.b CODE_0EC3B5
	LDA.w $0750
	AND.b #$60
	CMP.b #$20
	BNE.b CODE_0EC3B5
	PLA
	CMP.b #$1F
	BEQ.b CODE_0EC3B7
	CMP.b #$1E
	BEQ.b CODE_0EC3BA
	CLC
	ADC.b #$1D
	BRA.b CODE_0EC3B6

CODE_0EC3B5:
	PLA
CODE_0EC3B6:
	RTS

CODE_0EC3B7:
	LDA.b #$09
	RTS

CODE_0EC3BA:
	LDA.b #$1B
	RTS

;--------------------------------------------------------------------

CODE_0EC3BD:
	PHB
	PHK
	PLB
	LDA.w $0750
	AND.b #$60
	ASL
	ROL
	ROL
	ROL
	STA.b $5C
	STA.b $BA
	TAY
	LDA.w !RAM_SMBLL_Player_CurrentWorld
	CMP.b #$07
	BNE.b CODE_0EC3E0
	LDA.w $0760
	CMP.b #$03
	BNE.b CODE_0EC3E0
	LDA.b #$03
	STA.b $BA
CODE_0EC3E0:
	LDA.w $0750
	AND.b #$1F
	JSR.w SMBLL_LoadWorldAToDOverworldLevelHack_Main
	STA.w $074F
	LDA.w DATA_0EC4EC,y
	CLC
	ADC.w $074F
	TAY
	LDA.w DATA_0EC4F0,y
	STA.b $FD
	LDA.w DATA_0EC537,y
	STA.b $FE
	LDA.b #DATA_0EC537>>16
	STA.b $FF
	LDY.b $5C
	LDA.w DATA_0EC57E,y
	CLC
	ADC.w $074F
	TAY
	STA.b $DB
	LDA.w DATA_0EC582,y
	STA.b $FA
	LDA.w DATA_0EC5C9,y
	STA.b $FB
	LDA.b #DATA_0EC5C9>>16
	STA.b $FC
	LDY.b #$00
	LDA.b [$FA],y
	PHA
	AND.b #$07
	CMP.b #$04
	BCC.b CODE_0EC42B
	STA.w $0744
	LDA.b #$00
CODE_0EC42B:
	STA.w $0741
	PLA
	PHA
	AND.b #$38
	LSR
	LSR
	LSR
	STA.w $0710
	PLA
	AND.b #$C0
	CLC
	ROL
	ROL
	ROL
	STA.w $0715
	INY
	LDA.b [$FA],y
	PHA
	AND.b #$0F
	STA.w $0727
	PLA
	PHA
	AND.b #$30
	LSR
	LSR
	LSR
	LSR
	STA.w $0742
	PLA
	AND.b #$C0
	CLC
	ROL
	ROL
	ROL
	CMP.b #$03
	BNE.b CODE_0EC466
	STA.w $0743
	LDA.b #$00
CODE_0EC466:
	STA.w $0733
	JSR.w CODE_0EC47E
	LDA.b $FA
	CLC
	ADC.b #$02
	STA.b $FA
	LDA.b $FB
	ADC.b #$00
	STA.b $FB
	STZ.w $0EE8
	PLB
	RTL

CODE_0EC47E:
	LDA.w $0743
	BNE.b CODE_0EC493
	LDA.b $DB
	CMP.b #$23
	BEQ.b CODE_0EC48F
	CMP.b #$22
	BEQ.b CODE_0EC493
	BRA.b CODE_0EC498

CODE_0EC48F:
	LDA.b $42
	BNE.b CODE_0EC498
CODE_0EC493:
	LDA.b #$01
	STA.w $0236
CODE_0EC498:
	RTS

;--------------------------------------------------------------------

DATA_0EC499:
	db SMBLL_LevelIDsAndTileset_World1-SMBLL_LevelIDsAndTileset
	db SMBLL_LevelIDsAndTileset_World2-SMBLL_LevelIDsAndTileset
	db SMBLL_LevelIDsAndTileset_World3-SMBLL_LevelIDsAndTileset
	db SMBLL_LevelIDsAndTileset_World4-SMBLL_LevelIDsAndTileset
	db SMBLL_LevelIDsAndTileset_World5-SMBLL_LevelIDsAndTileset
	db SMBLL_LevelIDsAndTileset_World6-SMBLL_LevelIDsAndTileset
	db SMBLL_LevelIDsAndTileset_World7-SMBLL_LevelIDsAndTileset
	db SMBLL_LevelIDsAndTileset_World8-SMBLL_LevelIDsAndTileset
	db SMBLL_LevelIDsAndTileset_World9-SMBLL_LevelIDsAndTileset
	db SMBLL_LevelIDsAndTileset_WorldA-SMBLL_LevelIDsAndTileset
	db SMBLL_LevelIDsAndTileset_WorldB-SMBLL_LevelIDsAndTileset
	db SMBLL_LevelIDsAndTileset_WorldC-SMBLL_LevelIDsAndTileset
	db SMBLL_LevelIDsAndTileset_WorldD-SMBLL_LevelIDsAndTileset

SMBLL_LevelIDsAndTileset:
;$0EC4A6
.World1:
	db $20,$29,$40,$21,$60

.World2:
	db $22,$23,$24,$61

.World3:
	db $25,$29,$00,$26,$62

.World4:
	db $27,$28,$2A,$63

.World5:
	db $2B,$29,$43,$2C,$64

.World6:
	db $2D,$29,$01,$2E,$65

.World7:
	db $2F,$30,$31,$66

.World8:
	db $32,$35,$36,$67

.World9:
	db $38,$06,$68,$07

.WorldA:
	db $20,$3F,$45,$21,$6A

.WorldB:
	db $22,$3F,$08,$23,$6B

.WorldC:
	db $24,$25,$26,$6C

.WorldD:
	db $27,$28,$29,$6D

;--------------------------------------------------------------------

DATA_0EC4E0:
	db $15,$15,$6F,$6F,$18,$18,$45,$45
	db $08,$1A,$83,$08

;--------------------------------------------------------------------

DATA_0EC4EC:
	db $3E,$0E,$37,$00

DATA_0EC4F0:				; Note: Sprite list data pointers
.Castle:
	db DATA_0EC624			; 1-4
	db DATA_0EC643			; 2-4
	db DATA_0EC66A			; 3-4
	db DATA_0EC67D			; 4-4
	db DATA_0ED399			; 5-4
	db DATA_0ED3D2			; 6-4
	db DATA_0ED3F9			; 7-4
	db DATA_0ED438			; 8-4
	db DATA_0EE3CF			; 9-3 (Main)
	db DATA_0EE3D9			; 9-3 (Cloud bonus room)
	db DATA_0EE66A			; A-4
	db DATA_0EE68F			; B-4
	db DATA_0EE6B6			; C-4
	db DATA_0EE6F7			; D-4

.Overworld:
	db DATA_0EC6B2			; 1-1
	db DATA_0EC6D8			; 1-3
	db DATA_0EC6FB			; 2-1
	db DATA_0EC724			; 2-2
	db DATA_0EC75A			; 2-3
	db DATA_0EC771			; 3-1
	db DATA_0EC79B			; 3-3
	db DATA_0EC7C0			; 4-1
	db DATA_0EC7D7			; 4-2
	db DATA_0EC300			; Enter pipe cutscene
	db DATA_0EC7F9			; 4-3
	db DATA_0ED478			; 5-1, 8-1 (Warp zone)
	db DATA_0ED4A9			; 5-3
	db DATA_0ED4D1			; 6-1
	db DATA_0ED4F5			; 6-3
	db DATA_0ED512			; 7-1
	db DATA_0ED543			; 7-2
	db DATA_0ED56F			; 7-3
	db DATA_0ED588			; 8-1
	db DATA_0EC81C			; Sky bonus room 1 (Worlds 1-9)
	db DATA_0EC300			; 1-2/5-2 (Vine bonus/warp zone)
	db DATA_0ED5B0			; 8-2
	db DATA_0ED5D3			; 8-3 (Main and cloud exit)
	db DATA_0ED5FA			; Unused
	db DATA_0EE3DF			; 9-1
	db DATA_0EE3E3			; Unused
	db DATA_0EE3E3			; Unused
	db DATA_0EC300			; Exit sublevel
	db DATA_0ED5FB			; Sky bonus room 2 (Worlds 1-9)
..WorldAToD:
	db DATA_0EE726			; A-1
	db DATA_0EE761			; A-3, B-4 (Warp zone)
	db DATA_0EE770			; B-1
	db DATA_0EE79E			; B-3
	db DATA_0EE7C3			; C-1
	db DATA_0EE7E6			; C-2
	db DATA_0EE805			; C-3
	db DATA_0EE824			; D-1
	db DATA_0EE844			; D-2
	db DATA_0EE865			; D-3
	db DATA_0EE87C			; D-4
	db DATA_0EE88C			; Sky bonus room (Worlds A-D)

.Underground:
	db DATA_0EC828			; 1-2 (Main)
	db DATA_0EC84E			; 1-2 (Lava room)
	db DATA_0EC858			; Bonus areas 1 (Worlds 1-9)
	db DATA_0ED604			; 5-2
	db DATA_0ED625			; Bonus areas 2 (Worlds 1-9)
	db DATA_0EE89B			; A-2
	db DATA_0EE8B5			; Bonus areas (Worlds A-D)

.Underwater:
	db DATA_0EC872			; 3-2
	db DATA_0ED63F			; 6-2
	db DATA_0EC898			; 4-1
	db DATA_0ED66F			; 8-4
	db DATA_0ED67D			; 6-1/8-1
	db DATA_0EE3E3			; 9-1
	db DATA_0EE404			; 9-2
	db DATA_0EE409			; 9-4
	db DATA_0EE8C9			; B-2

DATA_0EC537:				; Note: Sprite list data pointers
.Castle:
	db DATA_0EC624>>8
	db DATA_0EC643>>8
	db DATA_0EC66A>>8
	db DATA_0EC67D>>8
	db DATA_0ED399>>8
	db DATA_0ED3D2>>8
	db DATA_0ED3F9>>8
	db DATA_0ED438>>8
	db DATA_0EE3CF>>8
	db DATA_0EE3D9>>8
	db DATA_0EE66A>>8
	db DATA_0EE68F>>8
	db DATA_0EE6B6>>8
	db DATA_0EE6F7>>8

.Overworld:
	db DATA_0EC6B2>>8
	db DATA_0EC6D8>>8
	db DATA_0EC6FB>>8
	db DATA_0EC724>>8
	db DATA_0EC75A>>8
	db DATA_0EC771>>8
	db DATA_0EC79B>>8
	db DATA_0EC7C0>>8
	db DATA_0EC7D7>>8
	db DATA_0EC300>>8
	db DATA_0EC7F9>>8
	db DATA_0ED478>>8
	db DATA_0ED4A9>>8
	db DATA_0ED4D1>>8
	db DATA_0ED4F5>>8
	db DATA_0ED512>>8
	db DATA_0ED543>>8
	db DATA_0ED56F>>8
	db DATA_0ED588>>8
	db DATA_0EC81C>>8
	db DATA_0EC300>>8
	db DATA_0ED5B0>>8
	db DATA_0ED5D3>>8
	db DATA_0ED5FA>>8
	db DATA_0EE3DF>>8
	db DATA_0EE3E3>>8
	db DATA_0EE3E3>>8
	db DATA_0EC300>>8
	db DATA_0ED5FB>>8
	db DATA_0EE726>>8
	db DATA_0EE761>>8
	db DATA_0EE770>>8
	db DATA_0EE79E>>8
	db DATA_0EE7C3>>8
	db DATA_0EE7E6>>8
	db DATA_0EE805>>8
	db DATA_0EE824>>8
	db DATA_0EE844>>8
	db DATA_0EE865>>8
	db DATA_0EE87C>>8
	db DATA_0EE88C>>8

.Underground:
	db DATA_0EC828>>8
	db DATA_0EC84E>>8
	db DATA_0EC858>>8
	db DATA_0ED604>>8
	db DATA_0ED625>>8
	db DATA_0EE89B>>8
	db DATA_0EE8B5>>8

.Underwater:
	db DATA_0EC872>>8
	db DATA_0ED63F>>8
	db DATA_0EC898>>8
	db DATA_0ED66F>>8
	db DATA_0ED67D>>8
	db DATA_0EE3E3>>8
	db DATA_0EE404>>8
	db DATA_0EE409>>8
	db DATA_0EE8C9>>8

DATA_0EC57E:
	db $3E,$0E,$37,$00

DATA_0EC582:				; Note: Level data pointers
.Castle:
	db DATA_0EC8A8
	db DATA_0EC96A
	db DATA_0ECA90
	db DATA_0ECB92
	db DATA_0ED692
	db DATA_0ED7F3
	db DATA_0ED8E8
	db DATA_0EDA8F
	db DATA_0EE41A
	db DATA_0EE4DB
	db DATA_0EE8ED
	db DATA_0EE9C6
	db DATA_0EEB6A
	db DATA_0EED15

.Overworld:
	db DATA_0ECC84
	db DATA_0ECCE7
	db DATA_0ECD3E
	db DATA_0ECDC1
	db DATA_0ECE41
	db DATA_0ECEA3
	db DATA_0ECF32
	db DATA_0ECF97
	db DATA_0ED012
	db DATA_0EC316
	db DATA_0ED075
	db DATA_0EDC06
	db DATA_0EDCEF
	db DATA_0EDD53
	db DATA_0EDDDB
	db DATA_0EDE4B
	db DATA_0EDED5
	db DATA_0EDF36
	db DATA_0EDFB3
	db DATA_0ED0C4
	db DATA_0EC320
	db DATA_0EE02F
	db DATA_0EE0A1
	db DATA_0EE10B
	db DATA_0EE560
	db DATA_0EE576
	db DATA_0EE577
	db DATA_0EC301
	db DATA_0EE10C
	db DATA_0EEE20
	db DATA_0EEEBA
	db DATA_0EEF18
	db DATA_0EEFAB
	db DATA_0EF00C
	db DATA_0EF08E
	db DATA_0EF0EE
	db DATA_0EF16D
	db DATA_0EF1F1
	db DATA_0EF245
	db DATA_0EF2C0
	db DATA_0EF2F6

.Underground:
	db DATA_0ED0DD
	db DATA_0ED1A2
	db DATA_0ED1DD
	db DATA_0EE143
	db DATA_0EE219
	db DATA_0EF313
	db DATA_0EF38D

.Underwater:
	db DATA_0ED22B
	db DATA_0EE261
	db DATA_0ED2EA
	db DATA_0EE332
	db DATA_0EE37E
	db DATA_0EE578
	db DATA_0EE5C4
	db DATA_0EE619
	db DATA_0EF3EF

DATA_0EC5C9:				; Note: Level data pointers
.Castle:
	db DATA_0EC8A8>>8
	db DATA_0EC96A>>8
	db DATA_0ECA90>>8
	db DATA_0ECB92>>8
	db DATA_0ED692>>8
	db DATA_0ED7F3>>8
	db DATA_0ED8E8>>8
	db DATA_0EDA8F>>8
	db DATA_0EE41A>>8
	db DATA_0EE4DB>>8
	db DATA_0EE8ED>>8
	db DATA_0EE9C6>>8
	db DATA_0EEB6A>>8
	db DATA_0EED15>>8

.Overworld:
	db DATA_0ECC84>>8
	db DATA_0ECCE7>>8
	db DATA_0ECD3E>>8
	db DATA_0ECDC1>>8
	db DATA_0ECE41>>8
	db DATA_0ECEA3>>8
	db DATA_0ECF32>>8
	db DATA_0ECF97>>8
	db DATA_0ED012>>8
	db DATA_0EC316>>8
	db DATA_0ED075>>8
	db DATA_0EDC06>>8
	db DATA_0EDCEF>>8
	db DATA_0EDD53>>8
	db DATA_0EDDDB>>8
	db DATA_0EDE4B>>8
	db DATA_0EDED5>>8
	db DATA_0EDF36>>8
	db DATA_0EDFB3>>8
	db DATA_0ED0C4>>8
	db DATA_0EC320>>8
	db DATA_0EE02F>>8
	db DATA_0EE0A1>>8
	db DATA_0EE10B>>8
	db DATA_0EE560>>8
	db DATA_0EE576>>8
	db DATA_0EE577>>8
	db DATA_0EC301>>8
	db DATA_0EE10C>>8
	db DATA_0EEE20>>8
	db DATA_0EEEBA>>8
	db DATA_0EEF18>>8
	db DATA_0EEFAB>>8
	db DATA_0EF00C>>8
	db DATA_0EF08E>>8
	db DATA_0EF0EE>>8
	db DATA_0EF16D>>8
	db DATA_0EF1F1>>8
	db DATA_0EF245>>8
	db DATA_0EF2C0>>8
	db DATA_0EF2F6>>8

.Underground:
	db DATA_0ED0DD>>8
	db DATA_0ED1A2>>8
	db DATA_0ED1DD>>8
	db DATA_0EE143>>8
	db DATA_0EE219>>8
	db DATA_0EF313>>8
	db DATA_0EF38D>>8

.Underwater:
	db DATA_0ED22B>>8
	db DATA_0EE261>>8
	db DATA_0ED2EA>>8
	db DATA_0EE332>>8
	db DATA_0EE37E>>8
	db DATA_0EE578>>8
	db DATA_0EE5C4>>8
	db DATA_0EE619>>8
	db DATA_0EF3EF>>8

;--------------------------------------------------------------------

DATA_0EC610:
	db $76,$50,$65,$50,$75,$B0,$00,$00

CODE_0EC618:
	LDY.b #$07
CODE_0EC61A:
	LDA.w DATA_0EC610,y
	STA.w DATA_0D9F64,y						; Glitch: This writes to ROM.
	DEY
	BPL.b CODE_0EC61A
	RTS

;--------------------------------------------------------------------

DATA_0EC624:
	db $35,$9D,$55,$9B,$C9,$1B,$59,$9D,$45,$9B,$C5,$1B,$26,$80,$45,$1B
	db $B9,$1D,$F0,$15,$59,$9D,$0F,$08,$78,$2D,$96,$28,$90,$B5,$FF

DATA_0EC643:
	db $74,$80,$F0,$38,$A0,$BB,$40,$BC,$8C,$1D,$C9,$9D,$05,$9B,$1C,$0C
	db $59,$1B,$B5,$1D,$2C,$8C,$40,$15,$7C,$1B,$DC,$1D,$6C,$8C,$BC,$0C
	db $78,$AD,$A5,$28,$90,$B5,$FF

DATA_0EC66A:
	db $0F,$04,$9C,$0C,$0F,$07,$C5,$1B,$65,$9D,$49,$9D,$5C,$8C,$78,$2D
	db $90,$B5,$FF

DATA_0EC67D:
	db $49,$9F,$67,$03,$79,$9D,$A0,$3A,$57,$9F,$BB,$1D,$D5,$25,$0F,$05
	db $18,$1D,$74,$00,$84,$00,$94,$00,$C6,$29,$49,$9D,$DB,$05,$0F,$08
	db $05,$9B,$09,$1D,$B0,$38,$80,$95,$C0,$3C,$EC,$A8,$CC,$8C,$4A,$9B
	db $78,$2D,$90,$B5,$FF

DATA_0EC6B2:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	db $19,$8E,$47,$03,$0F,$03,$10,$38,$1B,$80,$53,$06,$77,$0E,$83,$83
	db $A0,$3D,$90,$3B,$90,$B7,$60,$BC,$B7,$0E,$EE,$42,$00,$F7,$80,$6B
	db $83,$1B,$83,$AB,$06,$FF
else
	db $07,$8E,$47,$03,$0F,$03,$10,$38,$1B,$80,$53,$06,$77,$0E,$83,$83
	db $A0,$3D,$90,$3B,$90,$B7,$60,$BC,$B7,$0E,$EE,$42,$00,$F7,$80,$6B
	db $83,$1B,$83,$AB,$06,$FF
endif

DATA_0EC6D8:
	db $96,$A4,$F9,$24,$D3,$83,$3A,$83,$5A,$03,$95,$07,$F4,$0F,$69,$A8
	db $33,$87,$86,$24,$C9,$24,$4B,$83,$67,$83,$17,$83,$56,$28,$95,$24
	db $0A,$A4,$FF

DATA_0EC6FB:
	db $0F,$02,$47,$0E,$87,$0E,$C7,$0E,$F7,$0E,$27,$8E,$EE,$42,$25,$0F
	db $06,$AC,$28,$8C,$A8,$4E,$B3,$20,$8B,$8E,$F7,$90,$36,$90,$E5,$8E
	db $32,$8E,$C2,$06,$D2,$06,$E2,$06,$FF

DATA_0EC724:
	db $15,$8E,$9B,$06,$E0,$37,$80,$BC,$0F,$04,$2B,$3B,$AB,$0E,$EB,$0E
	db $0F,$06,$F0,$37,$4B,$8E,$6B,$80,$BB,$3C,$4B,$BB,$EE,$42,$20,$1B
	db $BC,$CB,$00,$AB,$83,$EB,$BB,$0F,$0E,$1B,$03,$9B,$37,$D4,$0E,$A3
	db $86,$B3,$06,$C3,$06,$FF

DATA_0EC75A:
	db $C0,$BE,$0F,$03,$38,$0E,$15,$8F,$AA,$83,$F8,$07,$0F,$07,$96,$10
	db $0F,$09,$48,$10,$BA,$03,$FF

DATA_0EC771:
	db $87,$85,$A3,$05,$DB,$83,$FB,$03,$93,$8F,$BB,$03,$CE,$42,$42,$9B
	db $83,$AE,$B3,$40,$DB,$00,$F4,$0F,$33,$8F,$74,$0F,$10,$BC,$F5,$0F
	db $2E,$C2,$45,$B7,$03,$F7,$03,$C8,$90,$FF

DATA_0EC79B:
	db $80,$BE,$83,$03,$92,$10,$4B,$80,$B0,$3C,$07,$80,$B7,$24,$0C,$A4
	db $96,$A9,$1B,$83,$7B,$24,$B7,$24,$97,$83,$E2,$0F,$A9,$A9,$38,$A9
	db $0F,$0B,$74,$8F,$FF

DATA_0EC7C0:
	db $E2,$91,$0F,$03,$42,$11,$0F,$06,$72,$11,$0F,$08,$EE,$02,$60,$02
	db $91,$EE,$B3,$60,$D3,$86,$FF

DATA_0EC7D7:
	db $0F,$02,$9B,$02,$AB,$02,$0F,$04,$13,$03,$92,$11,$60,$B7,$00,$BC
	db $00,$BB,$0B,$83,$CB,$03,$7B,$85,$9E,$C2,$60,$E6,$05,$0F,$0C,$62
	db $10,$FF

DATA_0EC7F9:
	db $E6,$A9,$57,$A8,$B5,$24,$19,$A4,$76,$28,$A2,$0F,$95,$8F,$9D,$A8
	db $0F,$07,$09,$29,$55,$24,$8B,$17,$A9,$24,$DB,$83,$04,$A9,$24,$8F
	db $65,$0F,$FF

DATA_0EC81C:
	db $0A,$AA,$1E,$22,$29,$1E,$25,$49,$2E,$27,$66,$FF

DATA_0EC828:
	db $0A,$8E,$DE,$B4,$00,$E0,$37,$5B,$82,$2B,$A9,$AA,$29,$29,$A9,$A8
	db $29,$0F,$08,$F0,$3C,$79,$A9,$C5,$26,$CD,$26,$EE,$3B,$01,$67,$B4
	db $0F,$0C,$2E,$C1,$00,$FF

DATA_0EC84E:
	db $09,$A9,$19,$A9,$DE,$42,$02,$7B,$83,$FF

DATA_0EC858:
	db $1E,$A0,$0A,$1E,$23,$2B,$1E,$28,$6B,$0F,$03,$1E,$40,$08,$1E,$25
	db $4E,$0F,$06,$1E,$22,$25,$1E,$25,$45,$FF

DATA_0EC872:
	db $0F,$01,$2A,$07,$2E,$3B,$41,$E9,$07,$0F,$03,$6B,$07,$F9,$07,$B8
	db $80,$2A,$87,$4A,$87,$B3,$0F,$84,$87,$47,$83,$87,$07,$0A,$87,$42
	db $87,$1B,$87,$6B,$03,$FF

DATA_0EC898:
	db $1E,$A7,$6A,$5B,$82,$74,$07,$D8,$07,$E8,$02,$0F,$04,$26,$07,$FF

DATA_0EC8A8:
	db $9B,$07,$0F,$52,$32,$0F,$63,$32,$0F,$74,$32,$33,$8E,$4F,$10,$34
	db $4F,$80,$36,$4E,$0A,$7E,$06,$8F,$80,$38,$9F,$80,$36,$9E,$0A,$CE
	db $06,$DF,$80,$38,$E3,$00,$EF,$80,$36,$EE,$0A,$1E,$87,$2F,$20,$34
	db $2F,$80,$38,$53,$0E,$8F,$10,$34,$8F,$80,$36,$8E,$02,$9C,$00,$AF
	db $B0,$38,$C7,$0E,$D7,$37,$57,$8E,$5F,$B0,$36,$6C,$05,$CF,$B0,$38
	db $DA,$60,$E9,$61,$FF,$A1,$3C,$F8,$62,$FE,$0B,$0F,$20,$B4,$0F,$70
	db $38,$43,$0E,$C3,$0E,$43,$8E,$B7,$0E,$EE,$09,$EF,$10,$34,$EF,$30
	db $34,$FE,$0A,$0F,$70,$B6,$3E,$06,$4F,$80,$38,$57,$0E,$6E,$0A,$6F
	db $80,$36,$7E,$06,$8F,$80,$38,$AE,$0A,$AF,$80,$36,$BE,$06,$CF,$80
	db $38,$FE,$07,$0F,$20,$B4,$15,$62,$55,$62,$95,$62,$FF,$20,$34,$FF
	db $80,$36,$FE,$0A,$0D,$C4,$CD,$43,$CE,$09,$DF,$70,$38,$DE,$0B,$DD
	db $42,$EF,$20,$34,$FF,$A1,$3A,$FF,$20,$34,$FF,$70,$36,$FE,$02,$5D
	db $C7,$FD

DATA_0EC96A:
	db $9B,$07,$0F,$52,$32,$0F,$63,$32,$0F,$74,$32,$03,$E2,$0F,$10,$34
	db $0E,$06,$1E,$0C,$1F,$71,$3C,$2F,$40,$38,$7E,$0A,$7F,$40,$36,$8E
	db $05,$9F,$10,$34,$9F,$30,$34,$9F,$50,$34,$9F,$70,$34,$9F,$B0,$38
	db $8E,$82,$8F,$10,$34,$8F,$30,$34,$8F,$50,$34,$8F,$70,$34,$8A,$8E
	db $8F,$B0,$36,$8E,$0A,$EE,$02,$FF,$B0,$38,$0A,$E0,$19,$61,$2F,$A1
	db $3C,$23,$06,$28,$62,$2E,$0B,$3F,$10,$34,$3F,$30,$34,$3F,$70,$38
	db $7F,$70,$36,$7E,$0A,$8F,$12,$28,$87,$30,$8E,$04,$9F,$B0,$38,$A7
	db $31,$C7,$0E,$D7,$33,$FE,$03,$03,$8E,$0F,$B0,$36,$0E,$0A,$1F,$12
	db $28,$1E,$04,$2F,$B0,$38,$27,$32,$4E,$0A,$4F,$B0,$36,$57,$0E,$5F
	db $12,$28,$5E,$04,$6F,$B0,$38,$67,$34,$9F,$B0,$36,$9E,$0A,$AF,$12
	db $28,$AE,$03,$B3,$0E,$BF,$A1,$3C,$BF,$B0,$38,$BE,$0B,$CF,$70,$38
	db $EE,$09,$EF,$10,$34,$EF,$30,$34,$FF,$70,$36,$FE,$0A,$2E,$82,$3F
	db $B0,$38,$7A,$0E,$7F,$B0,$36,$7E,$0A,$97,$31,$BE,$04,$CF,$20,$34
	db $CF,$B0,$38,$DA,$0E,$EE,$0A,$EF,$B0,$36,$FF,$12,$28,$FF,$20,$34
	db $FE,$02,$0F,$B0,$B8,$3F,$B0,$36,$3E,$0A,$7E,$06,$8F,$80,$38,$AF
	db $80,$36,$AE,$0A,$CE,$06,$DF,$80,$38,$FF,$80,$36,$FE,$0A,$0D,$C4
	db $11,$53,$21,$52,$24,$0B,$51,$52,$61,$52,$CD,$43,$CE,$09,$DF,$70
	db $38,$DD,$42,$DE,$0B,$EF,$20,$34,$FF,$20,$34,$FF,$A1,$3A,$FF,$70
	db $36,$FE,$02,$5D,$C7,$FD

DATA_0ECA90:
	db $5B,$06,$0F,$54,$32,$0F,$65,$32,$0F,$76,$32,$7E,$0A,$7F,$80,$36
	db $AE,$02,$BF,$B0,$38,$FE,$02,$0D,$01,$14,$63,$24,$63,$2F,$B0,$36
	db $2E,$0A,$6E,$09,$7F,$70,$38,$BF,$70,$36,$BE,$0A,$ED,$4B,$E4,$30
	db $EE,$02,$F3,$64,$FF,$B0,$38,$03,$E4,$13,$64,$23,$64,$33,$64,$43
	db $64,$53,$64,$5E,$02,$78,$72,$A4,$3D,$A5,$3E,$A6,$3F,$A3,$BE,$A6
	db $3E,$A9,$32,$E9,$3A,$8F,$B0,$B6,$8E,$0A,$AE,$02,$AF,$B0,$38,$A3
	db $33,$A6,$33,$A9,$33,$E5,$06,$ED,$4B,$F3,$30,$F6,$30,$F9,$30,$FE
	db $02,$0D,$05,$2F,$B0,$36,$3C,$01,$57,$73,$5F,$B0,$38,$6F,$B0,$36
	db $7C,$02,$93,$30,$A7,$73,$AF,$B0,$38,$BF,$B0,$36,$B3,$37,$CC,$01
	db $EF,$B0,$38,$07,$83,$17,$03,$27,$03,$37,$03,$64,$3B,$77,$3A,$FF
	db $B0,$36,$0C,$80,$1F,$B0,$38,$34,$36,$35,$37,$36,$38,$37,$38,$9E
	db $02,$BF,$B0,$36,$CC,$02,$C3,$33,$ED,$4B,$FF,$B0,$38,$03,$B7,$07
	db $37,$83,$37,$87,$37,$DD,$4B,$03,$B5,$07,$35,$5F,$B0,$36,$5E,$0A
	db $8E,$02,$9F,$B0,$38,$AF,$B0,$36,$AE,$0A,$DE,$06,$EF,$80,$38,$FF
	db $80,$36,$FE,$0A,$0D,$C4,$CD,$43,$CE,$09,$DD,$42,$DE,$0B,$DF,$70
	db $38,$EF,$20,$34,$FF,$20,$34,$FF,$A1,$3A,$FF,$70,$36,$FE,$02,$5D
	db $C7,$FD

DATA_0ECB92:
	db $9B,$07,$0F,$52,$32,$0F,$63,$32,$0F,$74,$32,$4F,$80,$36,$4E,$03
	db $5C,$02,$8F,$B0,$38,$0C,$F1,$27,$00,$3C,$74,$47,$0E,$EF,$B0,$36
	db $FC,$00,$FE,$0B,$0F,$70,$B8,$77,$0E,$EE,$09,$EF,$10,$34,$EF,$30
	db $34,$FF,$70,$36,$FE,$0A,$45,$B2,$55,$0E,$99,$32,$B9,$0E,$FE,$02
	db $0E,$85,$0F,$B0,$38,$1F,$10,$34,$1F,$30,$34,$1F,$50,$34,$1F,$70
	db $34,$FF,$20,$34,$FF,$40,$34,$FF,$60,$34,$FE,$02,$16,$8E,$2E,$0C
	db $2F,$A1,$3C,$3F,$40,$38,$AF,$40,$36,$AE,$0A,$EE,$05,$FF,$10,$34
	db $FF,$30,$34,$FF,$50,$34,$FF,$70,$34,$FF,$B0,$38,$1E,$82,$1F,$20
	db $34,$1F,$40,$34,$1F,$60,$34,$47,$0E,$07,$BD,$C4,$72,$DE,$0A,$DF
	db $B0,$36,$FE,$02,$03,$8E,$07,$0E,$0F,$B0,$38,$13,$3C,$17,$3D,$E3
	db $03,$EE,$0A,$EF,$B0,$36,$F3,$06,$F7,$03,$FE,$02,$04,$BE,$05,$3E
	db $06,$3E,$07,$3E,$0F,$B0,$38,$FE,$0A,$F4,$63,$FF,$B0,$36,$38,$E4
	db $4A,$72,$68,$64,$37,$B0,$9F,$80,$38,$AF,$80,$36,$EF,$80,$38,$FF
	db $80,$36,$0D,$C4,$71,$64,$CD,$43,$CE,$09,$DD,$42,$DE,$0B,$DF,$70
	db $38,$EF,$20,$34,$FF,$20,$34,$FF,$A1,$3A,$FF,$70,$36,$FE,$02,$5D
	db $C7,$FD

DATA_0ECC84:
	db $50,$31,$0F,$F6,$20,$13,$E4,$23,$24,$27,$23,$37,$07,$66,$61,$AC
	db $74,$C7,$01,$0B,$F1,$77,$73,$B6,$04,$DB,$71,$5C,$82,$83,$2D,$A2
	db $47,$A7,$0A,$B7,$29,$4F,$F3,$B0,$4E,$01,$5E,$31,$87,$0B,$93,$23
	db $CC,$06,$E3,$2C,$3A,$E0,$7C,$71,$97,$01,$AC,$73,$E6,$61,$0E,$B1
	db $B7,$F3,$DC,$02,$D3,$25,$07,$FB,$2C,$01,$E7,$73,$2C,$F2,$34,$72
	db $57,$00,$7C,$02,$39,$F1,$BF,$F7,$30,$33,$E7,$CD,$41,$0F,$F6,$A0
	db $ED,$47,$FD

DATA_0ECCE7:
	db $50,$11,$0F,$F6,$20,$FE,$10,$47,$92,$56,$40,$AC,$16,$AF,$F2,$10
	db $0F,$F5,$90,$73,$16,$82,$44,$EC,$48,$BC,$C2,$1C,$B1,$B3,$16,$C2
	db $44,$86,$C0,$9C,$14,$9F,$F2,$10,$A6,$40,$DF,$F5,$10,$0B,$96,$43
	db $12,$97,$31,$D3,$12,$03,$92,$27,$14,$63,$00,$C7,$15,$D6,$43,$AC
	db $97,$AF,$F1,$10,$1F,$F6,$90,$64,$13,$E3,$12,$2E,$91,$9D,$41,$AE
	db $42,$BF,$F0,$20,$AD,$C7,$FD

DATA_0ECD3E:
	db $52,$21,$0F,$F0,$20,$6E,$64,$4F,$F2,$B0,$7C,$5F,$7C,$3F,$6F,$F1
	db $A4,$7C,$58,$7C,$38,$83,$02,$A3,$00,$C3,$02,$F7,$16,$5C,$D6,$CF
	db $F5,$30,$D3,$20,$E3,$0A,$F3,$20,$25,$B5,$2C,$53,$6A,$7A,$8C,$54
	db $DA,$72,$FC,$50,$0C,$D2,$39,$73,$5C,$54,$AA,$72,$CC,$53,$F7,$16
	db $33,$83,$40,$06,$5C,$5B,$09,$93,$27,$0F,$3C,$5C,$0A,$B0,$63,$27
	db $78,$72,$93,$09,$97,$03,$A7,$03,$B7,$22,$47,$81,$5C,$72,$2A,$B0
	db $28,$0F,$3C,$5F,$58,$31,$B8,$31,$28,$B1,$3C,$5B,$98,$31,$FA,$30
	db $03,$B2,$20,$04,$7F,$F7,$B0,$F3,$67,$8D,$C1,$8E,$01,$CF,$F6,$20
	db $BD,$C7,$FD

DATA_0ECDC1:
	db $54,$11,$0F,$F6,$20,$38,$F2,$AB,$71,$0B,$F1,$96,$42,$CE,$10,$1E
	db $91,$29,$61,$3A,$60,$4E,$10,$78,$74,$8E,$11,$06,$C3,$1A,$E0,$1E
	db $10,$5E,$11,$67,$63,$77,$63,$88,$62,$99,$61,$AA,$60,$BE,$10,$0A
	db $F2,$15,$45,$7E,$11,$7A,$31,$9A,$E0,$AC,$02,$D9,$61,$D4,$0A,$EC
	db $01,$D6,$C2,$84,$C3,$98,$FA,$D3,$07,$D7,$0B,$E9,$61,$EE,$10,$2E
	db $91,$39,$71,$93,$03,$A6,$03,$BE,$10,$E1,$71,$E3,$31,$5E,$91,$69
	db $61,$E6,$41,$28,$E2,$99,$71,$AE,$10,$CE,$11,$BE,$90,$D6,$32,$3E
	db $91,$5F,$F7,$30,$66,$60,$D3,$67,$6D,$C1,$AF,$F6,$20,$9D,$C7,$FD

DATA_0ECE41:
	db $54,$11,$0F,$F6,$20,$AF,$F2,$30,$D8,$62,$E8,$62,$F8,$62,$FE,$10
	db $0C,$BE,$F8,$64,$0D,$C8,$2C,$43,$98,$64,$AC,$39,$48,$E4,$6A,$62
	db $7C,$47,$FA,$62,$3C,$B7,$EA,$62,$FC,$4D,$F6,$02,$03,$80,$06,$02
	db $13,$02,$DA,$62,$0D,$C8,$0B,$17,$97,$16,$2C,$B1,$33,$43,$6C,$31
	db $AC,$31,$17,$93,$73,$12,$CC,$31,$1A,$E2,$2C,$4B,$67,$48,$EA,$62
	db $0D,$CA,$17,$12,$53,$12,$BE,$11,$1D,$C1,$3E,$42,$3F,$F0,$20,$1D
	db $C7,$FD

DATA_0ECEA3:
	db $52,$B1,$0F,$F0,$20,$6E,$75,$53,$AA,$57,$25,$B7,$0A,$C7,$23,$0C
	db $83,$5C,$72,$87,$01,$C3,$00,$C7,$20,$DC,$65,$0C,$87,$C3,$22,$F3
	db $03,$03,$A2,$27,$7B,$33,$03,$43,$23,$52,$42,$9C,$06,$A7,$20,$C3
	db $23,$03,$A2,$0C,$02,$33,$09,$39,$71,$43,$23,$77,$06,$83,$67,$A7
	db $73,$5C,$82,$AE,$01,$C9,$11,$DE,$31,$07,$80,$1C,$71,$7E,$01,$98
	db $11,$9A,$10,$F3,$04,$16,$F4,$3C,$02,$68,$7A,$8C,$01,$A7,$73,$DE
	db $31,$E7,$73,$AC,$83,$09,$8F,$1C,$03,$9F,$F7,$30,$13,$E7,$7C,$02
	db $AD,$41,$EF,$F6,$20,$0D,$0E,$39,$71,$7F,$F7,$30,$F2,$68,$02,$E8
	db $12,$3A,$1C,$00,$68,$7A,$E0,$6A,$F0,$6A,$00,$6A,$6D,$C5,$FD

DATA_0ECF32:
	db $55,$10,$0B,$1F,$0F,$F6,$20,$D6,$12,$07,$9F,$33,$1A,$FB,$1F,$F7
	db $94,$53,$94,$71,$71,$CC,$15,$CF,$F3,$10,$1F,$F8,$90,$63,$12,$9B
	db $13,$A9,$71,$FB,$17,$09,$F1,$13,$13,$21,$42,$59,$0F,$EB,$13,$33
	db $93,$40,$06,$8C,$14,$8F,$F7,$10,$93,$40,$CF,$F3,$10,$0B,$94,$57
	db $15,$07,$93,$19,$F3,$C6,$43,$C7,$13,$D3,$03,$E3,$03,$33,$B0,$4A
	db $72,$55,$46,$73,$31,$A8,$74,$E3,$12,$8E,$91,$AD,$41,$CE,$42,$CF
	db $F0,$20,$BD,$C7,$FD

DATA_0ECF97:
	db $52,$21,$0F,$F0,$20,$6E,$63,$A9,$F1,$FB,$71,$22,$83,$37,$0B,$36
	db $50,$39,$51,$B8,$62,$57,$F3,$E8,$02,$F8,$02,$08,$82,$18,$02,$2D
	db $4A,$28,$02,$38,$02,$48,$00,$A8,$0F,$AA,$30,$BC,$5A,$6A,$B0,$4F
	db $F6,$B0,$B7,$04,$9A,$B0,$AC,$71,$C7,$01,$E6,$74,$0D,$09,$46,$02
	db $56,$00,$6C,$01,$84,$79,$86,$02,$96,$02,$A4,$71,$A6,$02,$B6,$02
	db $C4,$71,$C6,$02,$D6,$02,$39,$F1,$6C,$00,$77,$02,$A3,$09,$AC,$00
	db $B8,$72,$DC,$01,$07,$F3,$4C,$00,$6F,$F7,$30,$E3,$03,$E6,$03,$5D
	db $CA,$6C,$00,$7D,$41,$BF,$F6,$20,$8D,$C7,$FD

DATA_0ED012:
	db $50,$A1,$0F,$F6,$20,$17,$91,$19,$11,$48,$00,$68,$11,$6A,$10,$96
	db $14,$D8,$0A,$E8,$02,$F8,$02,$DC,$81,$6C,$81,$89,$0F,$9C,$00,$C3
	db $29,$F8,$62,$47,$A7,$C6,$61,$0D,$07,$56,$74,$B7,$00,$B9,$11,$CC
	db $76,$ED,$4A,$1C,$80,$37,$01,$3A,$10,$DE,$20,$E9,$0B,$EE,$21,$C8
	db $BC,$9C,$F6,$BC,$00,$CB,$7A,$EB,$72,$0C,$82,$39,$71,$B7,$63,$CC
	db $03,$E6,$60,$26,$E0,$4A,$30,$53,$31,$5C,$58,$ED,$41,$2F,$F6,$A0
	db $1D,$C7,$FD

DATA_0ED075:
	db $50,$11,$0F,$F6,$20,$FE,$10,$8B,$93,$A9,$0F,$14,$C1,$CC,$16,$CF
	db $F1,$10,$2F,$F5,$90,$B7,$14,$C7,$96,$D6,$44,$2B,$92,$39,$0F,$72
	db $41,$A7,$00,$1B,$95,$97,$13,$6C,$95,$6F,$F1,$10,$A2,$40,$BF,$F5
	db $10,$C2,$40,$0B,$9F,$53,$16,$62,$44,$72,$C2,$9B,$1D,$B7,$E0,$ED
	db $4A,$03,$E0,$8E,$11,$9D,$41,$BE,$42,$BF,$F0,$20,$9D,$C7,$FD

DATA_0ED0C4:
	db $00,$C1,$4C,$00,$03,$CF,$00,$D7,$23,$4D,$07,$AF,$2A,$4C,$03,$CF
	db $3E,$80,$F3,$4A,$BB,$C2,$BD,$C7,$FD

DATA_0ED0DD:
	db $48,$0F,$0E,$01,$5E,$02,$0A,$B0,$1C,$04,$6A,$30,$7F,$F4,$30,$C6
	db $64,$D6,$64,$E6,$64,$F6,$64,$FE,$00,$F0,$07,$00,$A1,$1E,$02,$47
	db $73,$7E,$04,$84,$52,$94,$50,$95,$0B,$96,$50,$A4,$52,$AE,$05,$B8
	db $51,$C8,$51,$CE,$01,$17,$F3,$45,$03,$52,$09,$62,$21,$6F,$F4,$30
	db $81,$21,$9E,$02,$B6,$64,$C6,$64,$C0,$0C,$D6,$64,$D0,$07,$E6,$64
	db $E0,$0C,$F0,$07,$FE,$0A,$0D,$06,$0E,$01,$4E,$04,$67,$73,$8E,$02
	db $B7,$0A,$BC,$03,$C4,$72,$C7,$22,$08,$F2,$2C,$02,$59,$71,$7C,$01
	db $96,$74,$BC,$01,$D8,$72,$FC,$01,$39,$F1,$4E,$01,$9E,$04,$A7,$52
	db $B7,$0B,$B8,$51,$C7,$51,$D7,$50,$DE,$02,$3A,$E0,$3E,$0A,$9E,$00
	db $08,$D4,$18,$54,$28,$54,$48,$54,$6E,$06,$9E,$01,$A8,$52,$AF,$F7
	db $40,$B8,$52,$C8,$52,$D8,$52,$DE,$0F,$4D,$C7,$CE,$01,$DC,$01,$F9
	db $79,$1C,$82,$48,$72,$7F,$F7,$30,$F2,$68,$01,$E9,$11,$3A,$68,$7A
	db $DE,$0F,$6D,$C5,$FD

DATA_0ED1A2:
	db $0B,$0F,$0E,$01,$9C,$71,$B7,$00,$BE,$00,$3E,$81,$47,$73,$5E,$00
	db $63,$42,$8E,$01,$A7,$73,$BE,$00,$7E,$81,$88,$72,$F0,$59,$FE,$00
	db $00,$D9,$0E,$01,$39,$79,$A7,$03,$AE,$00,$B4,$03,$DE,$0F,$0D,$05
	db $0E,$02,$68,$7A,$BE,$01,$DE,$0F,$6D,$C5,$FD

DATA_0ED1DD:
	db $08,$8F,$0E,$01,$17,$05,$2E,$02,$30,$07,$37,$03,$3A,$49,$44,$03
	db $58,$47,$DF,$FA,$40,$6D,$C7,$0E,$81,$00,$5A,$2E,$02,$87,$52,$97
	db $2F,$99,$4F,$0A,$90,$93,$56,$A3,$0B,$A7,$50,$B3,$55,$DF,$FA,$40
	db $6D,$C7,$0E,$81,$00,$5A,$2E,$00,$3E,$02,$41,$56,$57,$25,$56,$45
	db $68,$51,$7A,$43,$B7,$0B,$B8,$51,$DF,$FA,$40,$6D,$C7,$FD

DATA_0ED22B:
	db $41,$01,$03,$B4,$04,$34,$05,$34,$5C,$02,$83,$37,$84,$37,$85,$37
	db $09,$C2,$0C,$02,$1D,$49,$FA,$60,$09,$E1,$18,$62,$20,$63,$27,$63
	db $33,$37,$37,$63,$47,$63,$5C,$05,$79,$43,$00,$BF,$08,$3F,$09,$3F
	db $0A,$3F,$35,$52,$46,$48,$91,$53,$D6,$51,$FE,$01,$0C,$83,$6C,$04
	db $B4,$62,$C4,$62,$D4,$62,$E4,$62,$F4,$62,$18,$D2,$79,$51,$F4,$66
	db $00,$BF,$0C,$0A,$1D,$49,$31,$55,$56,$41,$77,$41,$98,$41,$C5,$55
	db $07,$E3,$17,$63,$27,$63,$37,$63,$47,$63,$57,$63,$67,$63,$78,$62
	db $89,$61,$9A,$60,$BC,$07,$CA,$42,$3A,$B3,$46,$53,$63,$34,$66,$44
	db $7C,$01,$9A,$33,$B7,$52,$DC,$01,$FA,$32,$05,$D4,$2C,$0D,$43,$37
	db $47,$35,$B7,$30,$C3,$64,$23,$E4,$29,$45,$33,$64,$43,$64,$53,$64
	db $63,$64,$73,$64,$9A,$60,$A9,$61,$B8,$62,$C0,$63,$C7,$63,$D0,$64
	db $D5,$0D,$D7,$63,$E0,$6A,$F0,$6A,$00,$EA,$0D,$4A,$7D,$47,$FD

DATA_0ED2EA:
	db $01,$01,$78,$52,$B5,$55,$DA,$60,$E9,$61,$F8,$62,$00,$E3,$07,$63
	db $10,$63,$17,$63,$20,$63,$27,$63,$30,$63,$37,$63,$40,$63,$47,$63
	db $50,$63,$57,$63,$60,$63,$67,$63,$70,$63,$77,$63,$80,$63,$87,$63
	db $90,$63,$97,$63,$A0,$63,$A7,$63,$B0,$63,$B7,$63,$C0,$63,$C7,$63
	db $D0,$63,$D7,$63,$E0,$63,$E7,$63,$F0,$63,$F7,$63,$0A,$CF,$36,$49
	db $62,$43,$00,$E2,$08,$62,$10,$62,$18,$62,$20,$62,$28,$62,$30,$62
	db $38,$62,$36,$49,$40,$62,$48,$62,$50,$62,$58,$62,$60,$62,$68,$62
	db $70,$62,$78,$62,$80,$62,$88,$62,$90,$62,$98,$62,$A0,$62,$A8,$62
	db $B0,$62,$B8,$62,$C0,$62,$C8,$62,$D0,$62,$D8,$62,$E0,$62,$E8,$62
	db $F0,$62,$F8,$62,$0C,$84,$65,$55,$97,$52,$9A,$32,$A9,$31,$B8,$30
	db $C7,$63,$D0,$6A,$D5,$0D,$E0,$6A,$F0,$6A,$00,$EA,$7D,$47,$FD

DATA_0ED399:
	db $2A,$A9,$6B,$0C,$CB,$0C,$15,$9C,$89,$1C,$CC,$1D,$09,$9D,$F5,$1C
	db $6B,$A9,$AB,$0C,$DB,$29,$48,$9D,$9B,$0C,$5B,$8C,$A5,$1C,$49,$9D
	db $79,$1D,$09,$9D,$6B,$0C,$C9,$1F,$3B,$8C,$88,$95,$B9,$1C,$19,$9D
	db $30,$CC,$78,$2D,$A6,$28,$90,$B5,$FF

DATA_0ED3D2:
	db $0F,$02,$09,$1F,$8B,$85,$2B,$8C,$E9,$1B,$25,$9D,$0F,$07,$09,$1D
	db $6D,$28,$99,$1B,$B5,$2C,$4B,$8C,$09,$9F,$FB,$15,$9D,$A8,$0F,$0C
	db $2B,$0C,$78,$2D,$90,$B5,$FF

DATA_0ED3F9:
	db $05,$9D,$0D,$A8,$DD,$1D,$07,$AC,$54,$2C,$A2,$2C,$F4,$2C,$42,$AC
	db $26,$9D,$D4,$03,$24,$83,$64,$03,$2B,$82,$4B,$02,$7B,$02,$9B,$02
	db $5B,$82,$7B,$02,$0B,$82,$2B,$02,$C6,$1B,$28,$82,$48,$02,$A6,$1B
	db $7B,$95,$85,$0C,$9D,$9B,$0F,$0E,$78,$2D,$7A,$1D,$90,$B5,$FF

DATA_0ED438:
	db $19,$9B,$99,$1B,$2C,$8C,$59,$1B,$C5,$0F,$0E,$83,$E0,$0F,$06,$2E
	db $67,$E7,$0F,$08,$9B,$07,$0E,$83,$E0,$39,$0E,$87,$10,$BD,$28,$59
	db $9F,$0F,$0F,$34,$0F,$77,$10,$9E,$67,$F1,$0F,$12,$0E,$67,$E3,$78
	db $2D,$0F,$15,$3B,$29,$57,$82,$0F,$18,$55,$1D,$78,$2D,$D0,$B5,$FF

DATA_0ED478:
	db $1B,$82,$4B,$02,$7B,$02,$AB,$02,$0F,$03,$F9,$0E,$D0,$BE,$8E,$C4
	db $86,$F8,$0E,$C0,$BA,$0F,$0D,$3A,$0E,$BB,$02,$30,$B7,$80,$BC,$C0
	db $BC,$0F,$12,$24,$0F,$54,$0F,$CE,$3C,$80,$D3,$0F,$CB,$8E,$F9,$0E
	db $FF

DATA_0ED4A9:
	db $0A,$AA,$15,$8F,$44,$0F,$4E,$44,$80,$D8,$07,$57,$90,$0F,$06,$67
	db $24,$8B,$17,$B9,$24,$AB,$97,$16,$87,$2A,$28,$84,$0F,$57,$A9,$A5
	db $29,$F5,$29,$A7,$A4,$0A,$A4,$FF

DATA_0ED4D1:
	db $07,$82,$67,$0E,$40,$BD,$E0,$38,$D0,$BC,$6E,$84,$A0,$9B,$05,$0F
	db $06,$BB,$05,$0F,$08,$0B,$0E,$4B,$0E,$0F,$0A,$05,$29,$85,$29,$0F
	db $0C,$DD,$28,$FF

DATA_0ED4F5:
	db $0F,$02,$28,$10,$E6,$03,$D8,$90,$0F,$05,$85,$0F,$78,$83,$C8,$10
	db $18,$83,$58,$83,$F7,$90,$0F,$0C,$43,$0F,$73,$8F,$FF

DATA_0ED512:
	db $A7,$83,$D7,$03,$0F,$03,$6B,$00,$0F,$06,$E3,$0F,$14,$8F,$3E,$44
	db $C3,$0B,$80,$87,$05,$AB,$05,$DB,$83,$0F,$0B,$07,$05,$13,$0E,$2B
	db $02,$4B,$02,$0F,$10,$0B,$0E,$B0,$37,$90,$BC,$80,$BC,$AE,$44,$C0
	db $FF

DATA_0ED543:
	db $0A,$AA,$D5,$8F,$03,$8F,$3E,$44,$C6,$D8,$83,$0F,$06,$A6,$11,$B9
	db $0E,$39,$9D,$79,$1B,$A6,$11,$E8,$03,$87,$83,$16,$90,$A6,$11,$B9
	db $1D,$05,$8F,$38,$29,$89,$29,$26,$8F,$46,$29,$FF

DATA_0ED56F:
	db $0F,$04,$A3,$10,$0F,$09,$E3,$29,$0F,$0D,$55,$24,$A9,$24,$0F,$11
	db $59,$1D,$A9,$1B,$23,$8F,$15,$9B,$FF

DATA_0ED588:
	db $0F,$01,$DB,$02,$30,$B7,$80,$3B,$1B,$8E,$4A,$0E,$EB,$03,$3B,$82
	db $5B,$02,$E5,$0F,$14,$8F,$44,$0F,$5B,$82,$0C,$85,$35,$8F,$06,$85
	db $E3,$05,$DB,$83,$3E,$84,$E0,$FF

DATA_0ED5B0:
	db $0F,$02,$0A,$29,$F7,$02,$80,$BC,$6B,$82,$7B,$02,$9B,$02,$AB,$02
	db $39,$8E,$0F,$07,$CE,$35,$EC,$F5,$0F,$FB,$85,$FB,$85,$3E,$C4,$E3
	db $A7,$02,$FF

DATA_0ED5D3:
	db $09,$A9,$86,$11,$D5,$10,$A3,$8F,$D5,$29,$86,$91,$2B,$83,$58,$03
	db $5B,$85,$EB,$05,$3E,$BC,$E0,$0F,$09,$43,$0F,$74,$0F,$6B,$85,$DB
	db $05,$C6,$A4,$19,$A4,$12,$8F

DATA_0ED5FA:
	db $FF

DATA_0ED5FB:
	db $0A,$AA,$2E,$2B,$98,$2E,$36,$E7,$FF

DATA_0ED604:
	db $0B,$83,$B7,$03,$D7,$03,$0F,$05,$67,$03,$7B,$02,$9B,$02,$80,$B9
	db $3B,$83,$4E,$B4,$80,$86,$2B,$C9,$2C,$16,$AC,$67,$B4,$DE,$3B,$81
	db $FF

DATA_0ED625:
	db $1E,$AF,$CA,$1E,$2C,$85,$0F,$04,$1E,$2D,$A7,$1E,$2F,$CE,$1E,$35
	db $E5,$0F,$07,$1E,$2B,$87,$1E,$30,$C5,$FF

DATA_0ED63F:
	db $0F,$01,$2E,$3B,$A1,$5B,$07,$AB,$07,$69,$87,$BA,$07,$FB,$87,$65
	db $A7,$6A,$27,$A6,$A7,$AC,$27,$1B,$87,$88,$07,$2B,$83,$7B,$07,$A7
	db $90,$E5,$83,$14,$A7,$19,$27,$77,$07,$F8,$07,$47,$8F,$B9,$07,$FF

DATA_0ED66F:
	db $07,$9B,$0A,$07,$B9,$1B,$66,$9B,$78,$07,$AE,$67,$E5,$FF

DATA_0ED67D:
	db $97,$87,$CB,$00,$EE,$2B,$F8,$FE,$2D,$AD,$75,$87,$D3,$27,$D9,$27
	db $0F,$04,$56,$0F,$FF

DATA_0ED692:
	db $9B,$09,$0F,$52,$32,$0F,$63,$32,$0F,$11,$28,$1F,$11,$28,$2F,$11
	db $28,$3F,$11,$28,$3E,$03,$3F,$70,$36,$4C,$50,$4E,$07,$5F,$70,$38
	db $6F,$70,$36,$6E,$03,$7C,$52,$9E,$07,$AF,$80,$38,$FE,$0A,$FF,$20
	db $34,$FF,$80,$36,$7E,$89,$8F,$70,$38,$9F,$70,$36,$9E,$0A,$EE,$09
	db $FF,$70,$38,$FE,$0B,$0F,$20,$B4,$1F,$20,$34,$13,$0E,$1E,$09,$3F
	db $70,$36,$3E,$0A,$6E,$09,$7F,$70,$38,$87,$0E,$9F,$A1,$3A,$9F,$70
	db $36,$9E,$02,$C6,$07,$CA,$0E,$F7,$62,$07,$8E,$08,$61,$1F,$B0,$36
	db $17,$62,$1E,$0A,$4E,$06,$5E,$0A,$58,$64,$7E,$06,$88,$64,$8E,$0A
	db $AE,$06,$BF,$80,$38,$BE,$07,$CF,$20,$34,$F3,$0E,$1E,$86,$1F,$20
	db $34,$2F,$80,$36,$2E,$0A,$84,$37,$93,$36,$A2,$45,$1E,$89,$2F,$70
	db $38,$46,$0E,$6E,$0A,$6F,$70,$36,$A7,$31,$DB,$61,$F7,$60,$1B,$E1
	db $37,$31,$7E,$09,$8E,$0B,$8F,$70,$38,$9F,$10,$34,$9F,$30,$34,$A3
	db $0E,$FF,$A1,$3A,$FF,$70,$36,$FE,$04,$17,$BB,$47,$0E,$77,$0E,$BE
	db $02,$BF,$20,$34,$CF,$B0,$36,$CE,$0A,$07,$8E,$17,$31,$63,$31,$A7
	db $34,$C7,$0E,$13,$B1,$4E,$09,$5F,$70,$38,$1E,$8A,$1F,$70,$36,$7E
	db $02,$8F,$B0,$38,$97,$34,$B7,$0E,$CF,$B0,$36,$CE,$0A,$DE,$02,$D8
	db $61,$EF,$B0,$38,$F7,$62,$FE,$03,$0F,$20,$B4,$07,$34,$17,$0E,$47
	db $62,$4F,$B0,$36,$4E,$0A,$5E,$03,$5F,$11,$28,$67,$62,$6F,$B0,$38
	db $77,$34,$B7,$62,$CF,$11,$28,$DA,$60,$E9,$61,$F8,$62,$FF,$B0,$36
	db $FF,$20,$34,$FE,$0A,$0D,$C4,$01,$52,$11,$52,$21,$52,$31,$52,$41
	db $52,$51,$52,$61,$52,$CD,$43,$CE,$09,$DE,$0B,$DD,$42,$DF,$70,$38
	db $EF,$20,$34,$FF,$20,$34,$FF,$A1,$3A,$FF,$70,$36,$FE,$02,$5D,$C7
	db $FD

DATA_0ED7F3:
	db $5B,$09,$0F,$52,$32,$0F,$63,$32,$4F,$70,$36,$4E,$0A,$87,$31,$FE
	db $02,$0F,$B0,$B8,$88,$72,$C7,$33,$0D,$02,$07,$0E,$17,$34,$6E,$0A
	db $6F,$B0,$36,$8E,$02,$9F,$B0,$38,$BF,$F7,$60,$ED,$4B,$B7,$B6,$C3
	db $35,$1E,$8A,$1F,$B0,$36,$2E,$02,$3F,$B0,$38,$33,$3F,$37,$3F,$88
	db $F2,$C7,$33,$ED,$4B,$0D,$06,$03,$33,$0F,$F4,$70,$47,$73,$67,$73
	db $7F,$B0,$36,$87,$65,$97,$65,$9E,$0A,$ED,$4B,$F7,$32,$07,$8E,$97
	db $0E,$AE,$00,$DE,$02,$EF,$00,$34,$EF,$B0,$38,$E3,$35,$E7,$35,$3E
	db $8A,$3F,$B0,$36,$4E,$02,$5F,$B0,$38,$53,$3E,$57,$3E,$07,$8E,$A7
	db $34,$BF,$F3,$60,$ED,$4B,$2E,$8A,$2F,$B0,$36,$FE,$06,$0F,$80,$B8
	db $2E,$08,$3F,$41,$28,$3F,$10,$34,$3F,$30,$34,$3F,$50,$34,$4F,$41
	db $28,$5F,$41,$28,$6F,$41,$28,$6F,$10,$34,$6F,$30,$34,$6F,$50,$34
	db $6E,$06,$8F,$71,$3C,$8E,$0C,$9F,$40,$38,$BF,$71,$3A,$BF,$40,$36
	db $BE,$06,$FF,$80,$36,$FE,$0A,$01,$D2,$0D,$44,$11,$52,$21,$52,$31
	db $52,$41,$52,$42,$0B,$51,$52,$61,$52,$CD,$43,$CE,$09,$DD,$42,$DE
	db $0B,$DF,$70,$38,$EF,$20,$34,$FF,$20,$34,$FF,$A1,$3A,$FF,$70,$36
	db $FE,$02,$5D,$C7,$FD

DATA_0ED8E8:
	db $58,$09,$0F,$55,$32,$0F,$6D,$32,$0F,$11,$28,$1F,$11,$28,$2F,$11
	db $28,$3F,$11,$28,$4F,$11,$28,$5F,$11,$28,$6F,$11,$28,$7F,$11,$28
	db $8F,$11,$28,$9F,$11,$28,$AF,$11,$28,$BF,$11,$28,$BF,$20,$34,$DE
	db $0C,$EF,$60,$3C,$EF,$40,$38,$F3,$3D,$03,$8E,$6E,$43,$CE,$0A,$CF
	db $40,$36,$EF,$17,$28,$EF,$20,$34,$EF,$80,$34,$FF,$17,$28,$0F,$17
	db $A8,$1F,$17,$28,$1E,$05,$2F,$80,$28,$2F,$B0,$38,$3F,$80,$28,$4F
	db $80,$28,$5F,$80,$28,$6F,$80,$28,$6E,$40,$7F,$80,$28,$8F,$80,$28
	db $9F,$80,$28,$AF,$80,$28,$BE,$01,$BF,$00,$34,$BF,$80,$34,$C7,$06
	db $DB,$0E,$DE,$00,$1F,$F0,$80,$6F,$F0,$00,$BF,$F0,$00,$0F,$F0,$80
	db $5F,$F0,$00,$7E,$05,$8F,$00,$34,$8F,$B0,$38,$A8,$37,$AF,$80,$34
	db $BF,$80,$28,$CF,$80,$28,$DF,$80,$28,$EF,$80,$28,$FF,$20,$34,$FF
	db $80,$28,$FE,$02,$0F,$80,$A8,$1F,$80,$34,$24,$0E,$34,$30,$3E,$0C
	db $3F,$A1,$3C,$4F,$40,$38,$4E,$43,$AE,$0A,$AF,$40,$36,$BE,$0C,$CF
	db $40,$38,$EE,$0A,$EF,$40,$36,$FE,$0C,$0F,$40,$B8,$2E,$0A,$2F,$40
	db $36,$3E,$0C,$4F,$40,$38,$7E,$02,$7F,$A1,$3A,$7F,$40,$36,$8E,$0E
	db $94,$64,$A4,$64,$B4,$65,$C4,$65,$D4,$65,$E4,$65,$F4,$65,$04,$E5
	db $14,$65,$24,$65,$34,$65,$44,$65,$54,$65,$64,$65,$74,$65,$84,$65
	db $94,$65,$A4,$65,$B4,$65,$C4,$65,$D4,$65,$E4,$65,$F4,$65,$0E,$82
	db $04,$63,$2E,$86,$2F,$A1,$3C,$3F,$80,$38,$4E,$0C,$4F,$71,$3C,$5F
	db $40,$38,$9E,$09,$9F,$61,$3A,$9F,$40,$36,$C1,$62,$C4,$0E,$EE,$0C
	db $EF,$61,$3C,$FF,$40,$38,$0E,$86,$0F,$71,$3A,$0F,$40,$36,$5E,$0C
	db $5F,$71,$3C,$6F,$40,$38,$7E,$09,$7F,$61,$3A,$7F,$40,$36,$A1,$62
	db $A4,$0E,$CF,$61,$3C,$DF,$40,$38,$DE,$0C,$FE,$0A,$FF,$40,$36,$28
	db $B4,$A6,$31,$E8,$34,$8B,$B2,$9B,$0E,$FE,$07,$0F,$20,$B4,$0F,$80
	db $38,$FF,$20,$34,$FF,$80,$36,$FE,$0A,$0D,$C4,$CD,$43,$CE,$09,$DD
	db $42,$DE,$0B,$DF,$70,$38,$EF,$20,$34,$FF,$20,$34,$FF,$A1,$3A,$FF
	db $70,$36,$FE,$02,$5D,$C7,$FD

DATA_0EDA8F:
	db $5B,$03,$05,$34,$06,$35,$07,$36,$6E,$0A,$6F,$10,$34,$6F,$B0,$36
	db $EE,$02,$FF,$B0,$38,$FE,$05,$0F,$20,$B4,$0E,$05,$0D,$01,$17,$0E
	db $97,$0E,$9F,$20,$34,$9E,$02,$C6,$05,$FA,$30,$FE,$0A,$FF,$B0,$36
	db $4E,$82,$5F,$B0,$38,$57,$0E,$58,$62,$68,$62,$79,$61,$8A,$60,$8E
	db $0A,$8F,$B0,$36,$F5,$31,$F9,$7B,$39,$F3,$97,$33,$B5,$71,$39,$F3
	db $4D,$48,$9E,$02,$AE,$05,$AF,$B0,$38,$BF,$10,$34,$CD,$4A,$ED,$4B
	db $FF,$24,$28,$0E,$81,$0F,$10,$34,$17,$06,$2F,$B0,$36,$39,$73,$5C
	db $02,$85,$65,$8F,$B0,$38,$9F,$B0,$36,$95,$32,$A9,$7B,$CC,$03,$5E
	db $8F,$6D,$47,$FE,$02,$0D,$07,$2F,$B0,$36,$39,$73,$4E,$0A,$AE,$02
	db $BF,$B0,$38,$EC,$71,$07,$81,$17,$02,$2F,$B0,$36,$39,$73,$5F,$B0
	db $38,$E6,$05,$2F,$B0,$B6,$39,$7B,$4E,$0A,$C4,$31,$EB,$61,$FE,$02
	db $07,$B0,$0F,$B0,$38,$1F,$B0,$36,$1E,$0A,$4E,$06,$5F,$80,$38,$57
	db $0E,$BE,$02,$BF,$A1,$3A,$BF,$80,$36,$C9,$61,$DA,$60,$ED,$4B,$0E
	db $85,$1F,$10,$34,$0D,$0E,$FF,$20,$34,$FF,$B0,$36,$FE,$0A,$78,$E4
	db $8E,$06,$9F,$80,$38,$B3,$06,$BF,$F7,$40,$EE,$0F,$EF,$80,$36,$FF
	db $10,$34,$6D,$C7,$0E,$82,$0F,$10,$34,$1F,$B0,$38,$2F,$B0,$36,$39
	db $73,$5F,$B0,$38,$9A,$60,$AF,$A1,$3C,$A9,$61,$AE,$06,$BF,$80,$38
	db $DF,$80,$36,$DE,$0A,$E7,$03,$EB,$79,$F7,$03,$FE,$06,$0F,$80,$B8
	db $0D,$14,$FF,$80,$36,$FE,$0A,$5E,$82,$6F,$B0,$38,$7F,$F6,$60,$9E
	db $0A,$9F,$B0,$36,$F8,$64,$FE,$0B,$0F,$20,$B4,$0F,$70,$38,$9F,$A1
	db $3A,$9F,$70,$36,$9E,$04,$BE,$05,$CF,$40,$34,$BE,$82,$BF,$20,$34
	db $DA,$60,$E9,$61,$F8,$62,$FF,$B0,$36,$FE,$0A,$0D,$C4,$11,$64,$51
	db $62,$CD,$43,$CE,$09,$DD,$42,$DE,$0B,$DF,$70,$38,$EF,$20,$34,$FF
	db $20,$34,$FE,$02,$5D,$C7,$FD

DATA_0EDC06:
	db $52,$B1,$0F,$F0,$20,$6E,$75,$CC,$73,$A3,$B3,$BF,$F4,$70,$0C,$84
	db $83,$3F,$8E,$01,$9F,$F4,$70,$AE,$31,$EF,$F1,$70,$EC,$01,$2F,$F1
	db $F0,$2C,$01,$6F,$F1,$70,$6C,$01,$A8,$91,$AA,$10,$77,$FB,$56,$F4
	db $39,$F1,$BF,$F7,$30,$33,$E7,$43,$04,$47,$03,$6C,$05,$C3,$67,$D3
	db $67,$E3,$67,$ED,$4C,$FC,$07,$73,$E7,$83,$67,$93,$67,$A3,$67,$BC
	db $08,$43,$E7,$53,$67,$DC,$02,$59,$91,$C3,$33,$D9,$71,$DF,$F2,$70
	db $2D,$CD,$5B,$71,$9B,$71,$3B,$F1,$A7,$C2,$DB,$71,$0D,$10,$9B,$71
	db $0A,$B0,$1C,$04,$67,$63,$76,$64,$85,$65,$94,$66,$A3,$67,$B3,$67
	db $CC,$09,$73,$A3,$87,$22,$B3,$09,$D6,$83,$E3,$03,$00,$EA,$10,$6A
	db $20,$6A,$30,$6A,$40,$6A,$50,$6A,$60,$6A,$70,$6A,$80,$6A,$90,$6A
	db $A0,$6A,$B0,$6A,$C0,$6A,$D0,$6A,$E0,$6A,$F0,$6A,$00,$EA,$10,$6A
	db $20,$6A,$30,$6A,$40,$6A,$50,$6A,$60,$6A,$70,$6A,$80,$6A,$90,$6A
	db $A0,$6A,$B0,$6A,$C0,$6A,$D0,$6A,$EC,$01,$03,$F7,$9D,$41,$DF,$F6
	db $20,$0D,$18,$39,$71,$7F,$F7,$30,$F2,$68,$01,$E9,$11,$39,$68,$7A
	db $E0,$6A,$F0,$6A,$00,$EA,$6D,$45,$FD

DATA_0EDCEF:
	db $50,$11,$0F,$F6,$20,$DF,$F2,$30,$FE,$10,$0D,$01,$98,$74,$C8,$13
	db $52,$E1,$63,$31,$61,$79,$C6,$61,$06,$E1,$8B,$71,$AB,$71,$E4,$19
	db $EB,$19,$60,$86,$C8,$13,$CD,$4B,$39,$F3,$98,$13,$17,$F5,$7C,$15
	db $7F,$F3,$10,$CF,$F5,$10,$D4,$40,$0B,$9A,$23,$16,$32,$44,$A3,$95
	db $B2,$43,$0D,$0A,$27,$14,$3D,$4A,$A4,$40,$BC,$16,$BF,$F3,$10,$C4
	db $40,$04,$C0,$1F,$F6,$10,$24,$40,$43,$31,$CE,$11,$DD,$41,$FF,$F0
	db $20,$ED,$C7,$FD

DATA_0EDD53:
	db $52,$A1,$0F,$F0,$20,$6E,$40,$D6,$61,$E7,$07,$F7,$21,$16,$E1,$34
	db $63,$47,$21,$54,$04,$67,$0A,$74,$63,$DC,$01,$06,$E1,$17,$26,$86
	db $61,$66,$C2,$58,$C1,$F7,$03,$04,$F6,$8A,$10,$9C,$04,$E8,$62,$F9
	db $61,$0A,$E0,$53,$31,$5F,$F3,$70,$7B,$71,$77,$25,$FC,$E2,$17,$AA
	db $23,$00,$3C,$67,$B3,$01,$CC,$63,$DB,$71,$DF,$F3,$70,$FC,$00,$4F
	db $F7,$B0,$CA,$7A,$C5,$31,$EC,$54,$3C,$DC,$5D,$4C,$0F,$F3,$B0,$47
	db $63,$6B,$F1,$8C,$0A,$39,$F1,$EC,$03,$F0,$33,$0F,$F2,$E0,$29,$73
	db $49,$61,$58,$62,$67,$73,$85,$65,$94,$66,$A3,$77,$AD,$4D,$AE,$01
	db $4D,$C1,$8F,$F6,$20,$7D,$C7,$FD

DATA_0EDDDB:
	db $50,$11,$0F,$F6,$20,$AF,$F2,$30,$D8,$62,$DE,$10,$08,$E4,$5A,$62
	db $6C,$4C,$86,$43,$AD,$48,$3A,$E2,$53,$42,$88,$64,$9C,$36,$08,$E4
	db $4A,$62,$5C,$4D,$3A,$E2,$9C,$32,$FC,$41,$3C,$B1,$83,$00,$AC,$42
	db $2A,$E2,$3C,$46,$AA,$62,$BC,$4E,$C6,$43,$46,$C3,$AA,$62,$BD,$48
	db $0B,$96,$47,$07,$C7,$12,$3C,$C2,$9C,$41,$CD,$48,$DC,$32,$4C,$C2
	db $BC,$32,$1C,$B1,$5A,$62,$6C,$44,$76,$43,$BA,$62,$DC,$32,$5D,$CA
	db $73,$12,$E3,$12,$8E,$91,$9D,$41,$BE,$42,$BF,$F0,$20,$9D,$C7,$FD

DATA_0EDE4B:
	db $52,$B1,$0F,$F0,$20,$6E,$76,$03,$B1,$09,$71,$0F,$F1,$70,$6F,$F3
	db $30,$A7,$63,$B7,$34,$BC,$0E,$4D,$CC,$03,$A6,$08,$72,$3F,$F2,$70
	db $6D,$4C,$73,$07,$77,$73,$83,$27,$AC,$00,$BF,$F3,$70,$3C,$80,$9A
	db $30,$AC,$5B,$C6,$3C,$6A,$B0,$75,$10,$96,$74,$B6,$0A,$DA,$30,$E3
	db $28,$EC,$5B,$ED,$48,$AA,$B0,$33,$B4,$51,$79,$AD,$4A,$DD,$4D,$E3
	db $2C,$0C,$FA,$73,$07,$B3,$04,$CB,$71,$EC,$07,$0D,$0A,$39,$71,$DF
	db $F3,$30,$CA,$B0,$D6,$10,$D7,$30,$DC,$0C,$03,$B1,$AD,$41,$EF,$F6
	db $20,$ED,$C7,$39,$F1,$0D,$10,$7D,$4C,$0D,$13,$A8,$11,$AA,$10,$1C
	db $83,$D7,$7B,$F3,$67,$5D,$CD,$6D,$47,$FD

DATA_0EDED5:
	db $56,$11,$0F,$F6,$20,$DF,$F2,$30,$FE,$11,$0D,$01,$0C,$5F,$03,$80
	db $0C,$52,$29,$15,$7C,$5B,$23,$B2,$29,$1F,$31,$79,$1C,$DE,$48,$3B
	db $ED,$4B,$39,$F1,$CF,$F3,$B0,$FE,$10,$37,$8E,$77,$0E,$9E,$11,$A8
	db $34,$A9,$34,$AA,$34,$F8,$62,$FE,$10,$37,$B6,$DE,$11,$E7,$63,$F8
	db $62,$09,$E1,$0E,$10,$47,$36,$B7,$0E,$BE,$91,$CA,$32,$EE,$10,$1D
	db $CA,$7E,$11,$83,$77,$9E,$10,$1E,$91,$2D,$41,$6F,$F6,$20,$6D,$C7
	db $FD

DATA_0EDF36:
	db $57,$11,$0F,$F6,$20,$FE,$10,$4B,$92,$59,$0F,$AD,$4C,$D3,$93,$0B
	db $94,$29,$0F,$7B,$93,$99,$0F,$0D,$06,$27,$12,$35,$0F,$23,$B1,$57
	db $75,$A3,$31,$AB,$71,$F7,$75,$23,$B1,$87,$13,$95,$0F,$0D,$0A,$23
	db $35,$38,$13,$55,$00,$9B,$16,$0B,$96,$C7,$75,$3B,$92,$49,$0F,$AD
	db $4C,$29,$92,$52,$40,$6C,$15,$6F,$F1,$10,$72,$40,$BF,$F5,$10,$03
	db $93,$0A,$13,$12,$41,$8B,$12,$99,$0F,$0D,$10,$47,$16,$46,$45,$B3
	db $32,$13,$B1,$57,$0E,$A7,$0E,$D3,$31,$53,$B1,$A6,$31,$03,$B2,$13
	db $0E,$8D,$4D,$AE,$11,$BD,$41,$DF,$F0,$20,$AD,$C7,$FD

DATA_0EDFB3:
	db $52,$A1,$0F,$F0,$20,$6E,$65,$57,$F3,$60,$21,$6F,$F2,$60,$AC,$75
	db $07,$80,$1C,$76,$87,$01,$9C,$70,$B0,$33,$CF,$F6,$60,$57,$E3,$6C
	db $04,$CD,$4C,$9A,$B0,$AC,$0C,$83,$B1,$8F,$F4,$70,$BD,$4D,$F8,$11
	db $FA,$10,$83,$87,$93,$22,$9F,$F4,$70,$59,$F1,$89,$61,$A9,$61,$BC
	db $0C,$67,$A0,$EB,$71,$77,$87,$7A,$10,$86,$51,$95,$52,$A4,$53,$B6
	db $04,$B3,$24,$26,$85,$4A,$10,$53,$23,$5C,$00,$6F,$F3,$70,$93,$08
	db $07,$FB,$2C,$04,$33,$30,$74,$76,$EB,$71,$57,$8B,$6C,$02,$96,$74
	db $E3,$30,$0C,$86,$7D,$41,$BF,$F6,$20,$BD,$C7,$FD

DATA_0EE02F:
	db $50,$61,$0F,$F6,$20,$BB,$F1,$DC,$06,$23,$87,$B5,$71,$B7,$31,$D7
	db $28,$06,$C5,$67,$08,$0D,$05,$39,$71,$7C,$00,$9E,$62,$B6,$03,$E6
	db $05,$4E,$E0,$5D,$4C,$59,$0F,$6C,$02,$93,$67,$AC,$56,$AD,$4C,$1F
	db $F1,$B0,$3C,$01,$98,$0A,$9E,$20,$A8,$21,$F3,$09,$0E,$A1,$27,$20
	db $3E,$62,$56,$05,$7D,$4D,$C6,$05,$3E,$E0,$9E,$62,$B6,$05,$1E,$E0
	db $4C,$00,$6C,$00,$A7,$7B,$E0,$6A,$F0,$6A,$00,$EA,$6D,$47,$FE,$10
	db $0B,$93,$5B,$15,$B7,$12,$03,$91,$AB,$1F,$BD,$41,$FF,$F6,$20,$BD
	db $C7,$FD

DATA_0EE0A1:
	db $50,$50,$0F,$F6,$20,$0B,$1F,$57,$92,$8B,$12,$D2,$14,$4B,$92,$59
	db $0F,$0B,$95,$BB,$1F,$BE,$52,$58,$E2,$9E,$50,$97,$05,$BB,$1F,$AE
	db $D2,$B6,$05,$BB,$1F,$DD,$4A,$F6,$06,$2F,$60,$96,$8E,$50,$98,$62
	db $EB,$11,$07,$F3,$0B,$1D,$2E,$52,$4F,$70,$18,$CE,$50,$EB,$1F,$EE
	db $52,$5E,$D0,$D9,$0F,$AB,$9F,$BE,$52,$8E,$D0,$AB,$1D,$AE,$52,$36
	db $83,$56,$05,$5E,$50,$DC,$15,$DF,$F2,$10,$2F,$F5,$90,$C3,$31,$5B
	db $9F,$6D,$41,$8E,$52,$8F,$F0,$20,$8D,$C7

DATA_0EE10B:
	db $FD

DATA_0EE10C:
	db $00,$C1,$4C,$00,$F3,$4F,$FA,$C6,$68,$A0,$69,$20,$6A,$20,$7A,$47
	db $F8,$20,$F9,$20,$FA,$20,$0A,$CF,$B4,$49,$55,$A0,$56,$20,$73,$47
	db $F5,$20,$F6,$20,$22,$A1,$41,$48,$52,$20,$72,$20,$92,$20,$B2,$20
	db $FE,$00,$9B,$C2,$AD,$C7,$FD

DATA_0EE143:
	db $48,$0F,$1E,$01,$27,$06,$5E,$02,$8F,$F3,$60,$8C,$01,$EF,$F7,$60
	db $1C,$81,$2E,$09,$3C,$63,$73,$01,$8C,$60,$FE,$02,$1E,$8E,$3E,$02
	db $44,$07,$45,$52,$4E,$0E,$8E,$02,$99,$71,$B5,$24,$B6,$24,$B7,$24
	db $FE,$02,$07,$87,$17,$22,$37,$52,$37,$0B,$47,$52,$4E,$0A,$57,$52
	db $5E,$02,$67,$52,$77,$52,$7E,$0A,$87,$52,$8E,$02,$96,$46,$97,$52
	db $A7,$52,$B7,$52,$C7,$52,$D7,$52,$E7,$52,$F7,$52,$FE,$04,$07,$A3
	db $47,$08,$57,$26,$C7,$0A,$E9,$71,$17,$A7,$97,$08,$9E,$01,$A0,$24
	db $C6,$74,$F0,$0C,$FE,$04,$0C,$80,$6F,$F2,$30,$98,$62,$A8,$62,$BC
	db $00,$C7,$73,$E7,$73,$FE,$02,$7F,$F7,$E0,$8E,$01,$9E,$00,$DE,$02
	db $F7,$0B,$FE,$0E,$4E,$82,$54,$52,$64,$51,$6E,$00,$74,$09,$9F,$F0
	db $00,$DF,$F0,$00,$2F,$F0,$80,$4E,$02,$59,$47,$CE,$0A,$07,$F5,$68
	db $54,$7F,$F4,$60,$88,$54,$A8,$54,$AE,$01,$B8,$52,$BF,$F7,$40,$C8
	db $52,$D8,$52,$E8,$52,$EE,$0F,$4D,$C7,$0D,$0D,$0E,$02,$68,$7A,$BE
	db $01,$EE,$0F,$6D,$C5,$FD

DATA_0EE219:
	db $08,$0F,$0E,$01,$2E,$05,$38,$2C,$3A,$4F,$08,$AC,$C7,$0B,$CE,$01
	db $DF,$FA,$40,$6D,$C7,$0E,$81,$00,$5A,$2E,$02,$B8,$4F,$CF,$F5,$60
	db $0F,$F5,$E0,$4F,$F5,$60,$8F,$F5,$60,$DF,$FA,$40,$6D,$C7,$0E,$81
	db $00,$5A,$30,$07,$34,$52,$3E,$02,$42,$47,$44,$47,$46,$27,$C0,$0B
	db $C4,$52,$DF,$FA,$40,$6D,$C7,$FD

DATA_0EE261:
	db $41,$01,$27,$D3,$79,$51,$C4,$56,$00,$E2,$03,$53,$0C,$0F,$12,$3B
	db $1A,$42,$43,$54,$6D,$49,$83,$53,$99,$53,$C3,$54,$DA,$52,$0C,$84
	db $09,$53,$53,$64,$63,$31,$67,$34,$86,$41,$8C,$01,$A3,$30,$B3,$64
	db $CC,$03,$D9,$42,$5C,$84,$A0,$62,$A8,$62,$B0,$62,$B8,$62,$C0,$62
	db $C8,$62,$D0,$62,$D8,$62,$E0,$62,$E8,$62,$16,$C2,$58,$52,$8C,$04
	db $A7,$55,$D0,$63,$D7,$63,$E2,$61,$E7,$63,$F2,$61,$F7,$63,$13,$B8
	db $17,$38,$8C,$03,$1D,$C9,$50,$62,$5C,$0B,$62,$3E,$63,$52,$8A,$52
	db $93,$54,$AA,$42,$D3,$51,$EA,$41,$03,$D3,$1C,$04,$1A,$52,$33,$55
	db $73,$44,$77,$44,$16,$D2,$19,$31,$1A,$32,$5C,$0F,$9A,$47,$95,$64
	db $A5,$64,$B5,$64,$C5,$64,$D5,$64,$E5,$64,$F5,$64,$05,$E4,$40,$61
	db $42,$35,$56,$34,$5C,$09,$A2,$61,$A6,$61,$B3,$34,$B7,$34,$FC,$08
	db $0C,$87,$28,$54,$59,$53,$9A,$30,$A9,$61,$B8,$62,$C0,$63,$C7,$63
	db $D0,$64,$D5,$0D,$D7,$63,$E0,$6A,$F0,$6A,$00,$EA,$0D,$4A,$7D,$47
	db $FD

DATA_0EE332:
	db $07,$0F,$0F,$10,$34,$0E,$02,$1F,$B0,$38,$2F,$B0,$36,$39,$73,$5F
	db $B0,$38,$05,$8E,$2E,$0B,$2F,$A1,$3C,$3F,$70,$38,$3F,$10,$34,$B7
	db $0E,$64,$8E,$6E,$02,$6F,$10,$34,$6F,$A1,$3A,$6F,$70,$36,$CE,$06
	db $CF,$A1,$3C,$DF,$80,$38,$DE,$08,$EF,$41,$28,$EF,$20,$34,$E6,$0D
	db $FF,$43,$28,$FF,$70,$34,$0F,$43,$A8,$7D,$47,$FD

DATA_0EE37E:
	db $01,$01,$77,$39,$A3,$43,$00,$BF,$29,$51,$39,$48,$61,$55,$D6,$54
	db $D2,$44,$0C,$82,$30,$39,$31,$66,$44,$47,$47,$32,$4A,$47,$97,$32
	db $C1,$66,$CE,$01,$DC,$02,$00,$BF,$04,$3F,$05,$3F,$06,$3F,$07,$3F
	db $0C,$0F,$08,$4F,$FE,$01,$27,$D3,$5C,$02,$9A,$60,$A9,$61,$B8,$62
	db $C7,$63,$D0,$64,$D5,$0D,$D7,$63,$E0,$6A,$F0,$6A,$00,$EA,$7D,$47
	db $FD

DATA_0EE3CF:
	db $1F,$01,$0E,$69,$00,$1F,$0B,$78,$2D,$FF

DATA_0EE3D9:
	db $1F,$01,$1E,$68,$06,$FF

DATA_0EE3DF:
	db $1E,$05,$00,$FF

DATA_0EE3E3:
	db $26,$8F,$05,$AC,$46,$0F,$1F,$04,$E8,$10,$38,$90,$66,$11,$FB,$3C
	db $9B,$B7,$CB,$85,$29,$87,$95,$07,$EB,$02,$0B,$82,$96,$0E,$C3,$0E
	db $FF

DATA_0EE404:
	db $1F,$01,$E6,$11,$FF

DATA_0EE409:
	db $3B,$86,$7B,$00,$BB,$02,$2B,$8E,$7A,$05,$57,$87,$27,$8F,$9A,$0C
	db $FF

DATA_0EE41A:
	db $55,$31,$0D,$01,$CF,$F3,$30,$FE,$39,$0F,$A0,$BC,$0F,$70,$38,$0F
	db $00,$34,$FE,$32,$FF,$A1,$3A,$FF,$70,$36,$2E,$82,$34,$3B,$35,$3B
	db $36,$3B,$37,$3B,$F4,$63,$FF,$00,$34,$FE,$31,$29,$8F,$9E,$43,$FE
	db $30,$FF,$B0,$36,$16,$B1,$23,$09,$4E,$31,$4E,$40,$5F,$B0,$38,$D7
	db $E0,$E6,$61,$FE,$02,$F5,$62,$FA,$60,$FF,$B0,$36,$0C,$DF,$0F,$00
	db $34,$04,$63,$14,$3E,$15,$3E,$16,$3E,$17,$3E,$0C,$DF,$04,$3F,$05
	db $3F,$06,$3F,$07,$3F,$0C,$D1,$04,$63,$14,$63,$1E,$32,$2F,$B0,$38
	db $24,$64,$2D,$40,$3F,$00,$34,$34,$64,$4E,$32,$5E,$36,$5E,$42,$6F
	db $A0,$3C,$6F,$80,$38,$6F,$00,$34,$CE,$38,$DF,$10,$34,$0D,$0B,$8E
	db $36,$8E,$40,$8F,$10,$34,$87,$37,$96,$36,$EE,$3A,$EF,$80,$36,$FC
	db $5A,$06,$BD,$07,$3E,$9E,$06,$AF,$80,$38,$FF,$A1,$3A,$FF,$80,$36
	db $FE,$31,$FF,$00,$34,$09,$E1,$1A,$60,$6D,$41,$AF,$F6,$20,$8D,$C7
	db $FD

DATA_0EE4DB:
	db $00,$F1,$FE,$B5,$0D,$02,$FE,$34,$07,$CF,$CE,$00,$0D,$05,$8D,$47
	db $FD,$00,$C1,$3F,$B0,$36,$4C,$00,$5F,$B0,$38,$00,$E7,$10,$67,$20
	db $67,$30,$67,$40,$67,$50,$67,$60,$67,$70,$67,$80,$67,$90,$67,$A0
	db $67,$B0,$67,$C0,$67,$D0,$67,$E0,$67,$F0,$67,$00,$E7,$0D,$02,$10
	db $67,$20,$67,$30,$67,$40,$67,$50,$67,$60,$67,$70,$67,$80,$67,$90
	db $67,$A0,$67,$B0,$67,$C0,$67,$D0,$67,$E0,$67,$F0,$67,$FE,$04,$07
	db $CF,$00,$63,$10,$63,$20,$63,$30,$63,$40,$63,$50,$63,$60,$63,$70
	db $63,$80,$63,$90,$63,$A0,$63,$B0,$63,$C0,$63,$CE,$00,$CF,$B0,$36
	db $0D,$05,$8D,$47,$FD

DATA_0EE560:
	db $50,$31,$00,$39,$9F,$F8,$30,$EE,$01,$12,$B9,$77,$7B,$E0,$6A,$F0
	db $6A,$00,$6A,$6D,$C7,$FD

DATA_0EE576:
	db $FD

DATA_0EE577:
	db $FD

DATA_0EE578:
	db $00,$A1,$0A,$60,$19,$61,$28,$62,$39,$71,$58,$62,$69,$61,$7A,$60
	db $7C,$F5,$A5,$11,$FE,$20,$1F,$F0,$80,$5E,$21,$80,$3F,$8F,$F5,$60
	db $D6,$74,$5E,$A0,$6F,$F6,$60,$9E,$21,$C3,$37,$47,$F3,$9E,$20,$FE
	db $21,$0D,$06,$57,$32,$64,$11,$66,$10,$83,$A7,$87,$27,$0D,$09,$1D
	db $4A,$5F,$F8,$30,$6D,$C1,$AF,$F6,$20,$6D,$C7,$FD

DATA_0EE5C4:
	db $50,$11,$00,$3F,$D7,$73,$FE,$1A,$00,$BF,$6F,$F2,$60,$00,$BF,$1F
	db $F5,$60,$BF,$F3,$60,$00,$BF,$C7,$28,$DF,$F1,$60,$00,$BF,$15,$71
	db $7F,$F2,$60,$9B,$2F,$A8,$72,$FE,$10,$69,$F1,$B7,$25,$C5,$71,$33
	db $AC,$5F,$F1,$70,$8D,$4A,$AA,$14,$D1,$71,$17,$95,$26,$42,$72,$42
	db $73,$12,$7A,$14,$C6,$14,$D5,$42,$FE,$11,$7F,$F8,$B0,$8D,$C1,$CF
	db $F6,$20,$6D,$C7,$FD

DATA_0EE619:
	db $57,$00,$0B,$3F,$0B,$BF,$0B,$BF,$73,$36,$9A,$30,$A5,$64,$B6,$31
	db $D4,$61,$0B,$BF,$13,$63,$4A,$60,$53,$66,$A5,$34,$B3,$67,$E5,$65
	db $F4,$60,$0B,$BF,$14,$60,$53,$67,$67,$32,$C4,$62,$D4,$31,$F3,$61
	db $FA,$60,$0B,$BF,$04,$30,$09,$61,$14,$65,$63,$65,$6A,$60,$0B,$BF
	db $0F,$F8,$30,$0B,$BF,$1D,$41,$3E,$42,$3F,$F0,$20,$0B,$BF,$3D,$47
	db $FD

DATA_0EE66A:
	db $2A,$9E,$6B,$0C,$8D,$1C,$EA,$1F,$1B,$8C,$E6,$1C,$8C,$9C,$BB,$0C
	db $F3,$83,$9B,$8C,$DB,$0C,$1B,$8C,$6B,$0C,$BB,$0C,$0F,$09,$40,$15
	db $78,$AD,$90,$B5,$FF

DATA_0EE68F:
	db $0F,$02,$38,$1D,$D9,$1B,$6E,$EB,$21,$3A,$A8,$18,$9D,$0F,$07,$18
	db $1D,$0F,$09,$18,$1D,$0F,$0B,$18,$1D,$7B,$15,$8E,$21,$2E,$B9,$9D
	db $0F,$0E,$78,$2D,$90,$B5,$FF

DATA_0EE6B6:
	db $05,$9D,$65,$1D,$0D,$A8,$DD,$1D,$07,$AC,$54,$2C,$A2,$2C,$F4,$2C
	db $42,$AC,$26,$9D,$D4,$03,$24,$83,$64,$03,$2B,$82,$4B,$02,$7B,$02
	db $9B,$02,$5B,$82,$7B,$02,$0B,$82,$2B,$02,$C6,$1B,$28,$82,$48,$02
	db $A6,$1B,$7B,$95,$85,$0C,$9D,$9B,$0F,$0E,$78,$2D,$7A,$1D,$90,$B5
	db $FF

DATA_0EE6F7:
	db $19,$9F,$99,$1B,$2C,$8C,$59,$1B,$C5,$0F,$0F,$04,$09,$29,$BD,$1D
	db $0F,$06,$6E,$2A,$61,$0F,$09,$48,$2D,$46,$87,$79,$07,$8E,$6D,$60
	db $A5,$07,$B8,$85,$57,$A5,$8C,$8C,$76,$9D,$78,$2D,$D0,$B5,$FF

DATA_0EE726:
	db $07,$83,$37,$03,$6B,$0E,$E0,$3D,$20,$BE,$6E,$2B,$00,$A7,$85,$D3
	db $05,$E7,$83,$24,$83,$27,$03,$49,$00,$59,$00,$10,$BB,$B0,$3B,$6E
	db $C6,$00,$17,$85,$53,$05,$36,$8E,$76,$0E,$B6,$0E,$E7,$83,$63,$83
	db $68,$03,$29,$83,$57,$03,$85,$03,$B5,$29,$FF

DATA_0EE761:
	db $0F,$04,$66,$07,$0F,$06,$86,$10,$0F,$08,$55,$0F,$E5,$8F,$FF

DATA_0EE770:
	db $70,$B7,$CA,$00,$66,$80,$0F,$04,$79,$0E,$AB,$0E,$EE,$2B,$20,$EB
	db $80,$40,$BB,$FB,$00,$40,$B7,$CB,$0E,$0F,$09,$4B,$00,$76,$00,$D8
	db $00,$6B,$8E,$73,$06,$83,$06,$C7,$0E,$36,$90,$C5,$06,$FF

DATA_0EE79E:
	db $84,$8F,$A7,$24,$D3,$0F,$EA,$24,$45,$A9,$D5,$28,$45,$A9,$84,$25
	db $B4,$8F,$09,$90,$B5,$A8,$5B,$97,$CD,$28,$B5,$A4,$09,$A4,$65,$28
	db $92,$90,$E3,$83,$FF

DATA_0EE7C3:
	db $3A,$8E,$5B,$0E,$C3,$8E,$CA,$8E,$0B,$8E,$4A,$0E,$DE,$C6,$44,$0F
	db $08,$49,$0E,$EB,$0E,$8A,$90,$AB,$85,$0F,$0C,$03,$0F,$2E,$2B,$40
	db $67,$86,$FF

DATA_0EE7E6:
	db $15,$8F,$54,$07,$AA,$83,$F8,$07,$0F,$04,$14,$07,$96,$10,$0F,$07
	db $95,$0F,$9D,$A8,$0B,$97,$09,$A9,$55,$24,$A9,$24,$BB,$17,$FF

DATA_0EE805:
	db $0F,$03,$A6,$11,$A3,$90,$A6,$91,$0F,$08,$A6,$11,$E3,$A9,$0F,$0D
	db $55,$24,$A9,$24,$0F,$11,$59,$1D,$A9,$1B,$23,$8F,$15,$9B,$FF

DATA_0EE824:
	db $87,$85,$9B,$05,$18,$90,$A4,$8F,$6E,$C6,$60,$9B,$02,$D0,$3B,$80
	db $B8,$03,$8E,$1B,$02,$3B,$02,$0F,$08,$03,$10,$F7,$05,$6B,$85,$FF

DATA_0EE844:
	db $DB,$82,$F3,$03,$10,$B7,$80,$37,$1A,$8E,$4B,$0E,$7A,$0E,$AB,$0E
	db $0F,$05,$F9,$0E,$D0,$BE,$2E,$C6,$62,$D4,$8F,$64,$8F,$7E,$2B,$60
	db $FF

DATA_0EE865:
	db $0F,$03,$AB,$05,$1B,$85,$A3,$85,$D7,$05,$0F,$08,$33,$03,$0B,$85
	db $FB,$85,$8B,$85,$3A,$8E,$FF

DATA_0EE87C:
	db $0F,$02,$09,$05,$3E,$46,$64,$2B,$8E,$58,$0E,$CA,$07,$34,$87,$FF

DATA_0EE88C:
	db $0A,$AA,$1E,$20,$03,$1E,$22,$27,$2E,$24,$48,$2E,$28,$67,$FF

DATA_0EE89B:
	db $BB,$A9,$1B,$A9,$69,$29,$B8,$29,$59,$A9,$8D,$A8,$0F,$07,$15,$29
	db $55,$AC,$6B,$85,$0E,$BE,$01,$67,$34,$FF

DATA_0EE8B5:
	db $1E,$A0,$09,$1E,$27,$67,$0F,$03,$1E,$28,$68,$0F,$05,$1E,$24,$48
	db $1E,$6D,$68,$FF

DATA_0EE8C9:
	db $EE,$BE,$21,$26,$87,$F3,$0E,$66,$87,$CB,$00,$65,$87,$0F,$06,$06
	db $0E,$97,$07,$CB,$00,$75,$87,$D3,$27,$D9,$27,$0F,$09,$77,$1F,$46
	db $87,$B1,$0F,$FF

DATA_0EE8ED:
	db $9B,$87,$0F,$52,$32,$0F,$63,$32,$0F,$74,$32,$EE,$0A,$EF,$10,$34
	db $EF,$80,$36,$0E,$86,$1F,$80,$38,$28,$0E,$3F,$80,$36,$3E,$0A,$6E
	db $02,$7F,$B0,$38,$8B,$0E,$97,$00,$9F,$B0,$36,$9E,$0A,$CE,$06,$DF
	db $80,$38,$E8,$0E,$FF,$80,$36,$FE,$0A,$2E,$86,$3F,$80,$38,$6F,$80
	db $36,$6E,$0A,$8E,$08,$9F,$10,$34,$9F,$80,$38,$E4,$0E,$1E,$82,$1F
	db $20,$34,$1F,$A1,$3A,$1F,$80,$36,$8A,$0E,$8F,$B0,$36,$8E,$0A,$FE
	db $02,$0F,$B0,$B8,$1A,$60,$2F,$A1,$3C,$29,$61,$2E,$06,$3F,$80,$38
	db $47,$60,$56,$61,$6F,$71,$3C,$65,$62,$6E,$0C,$7F,$40,$38,$83,$60
	db $7E,$8A,$7F,$40,$36,$BB,$61,$F9,$63,$27,$E5,$88,$64,$EB,$61,$FE
	db $05,$0F,$20,$B4,$0F,$B0,$38,$68,$10,$0A,$90,$FF,$20,$34,$FE,$02
	db $3A,$90,$3F,$B0,$36,$3E,$0A,$AE,$02,$BF,$B0,$38,$DA,$60,$E9,$61
	db $F8,$62,$FF,$B0,$36,$FE,$0A,$0D,$C4,$A1,$62,$B1,$62,$CD,$43,$CE
	db $09,$DE,$0B,$DD,$42,$DF,$70,$38,$EF,$20,$34,$FF,$A1,$3A,$FF,$20
	db $34,$FF,$70,$36,$FE,$02,$5D,$C7,$FD

DATA_0EE9C6:
	db $9B,$09,$0F,$52,$32,$0F,$63,$32,$0F,$11,$28,$1F,$11,$28,$2F,$11
	db $28,$3F,$11,$28,$3E,$0A,$3F,$70,$36,$41,$3B,$42,$3B,$4F,$11,$28
	db $5F,$11,$28,$58,$64,$6F,$11,$28,$7F,$11,$28,$7A,$62,$8F,$11,$28
	db $9F,$11,$28,$AF,$11,$28,$BF,$11,$28,$CF,$11,$28,$C8,$31,$DF,$11
	db $28,$EF,$11,$28,$FF,$11,$28,$FF,$20,$34,$18,$E4,$39,$73,$5E,$09
	db $5F,$70,$38,$66,$3C,$0E,$82,$0F,$A1,$3A,$0F,$70,$36,$28,$07,$36
	db $0E,$3F,$B0,$36,$3E,$0A,$AE,$02,$AF,$B0,$38,$D7,$0E,$EF,$A1,$3C
	db $FF,$40,$38,$FE,$0C,$FF,$40,$B6,$FE,$0A,$11,$E5,$21,$65,$31,$65
	db $4E,$0C,$5F,$40,$38,$FE,$02,$FF,$A1,$3A,$FF,$40,$36,$16,$8E,$2E
	db $0E,$34,$63,$44,$63,$54,$63,$64,$63,$74,$63,$84,$63,$94,$63,$A4
	db $63,$B4,$63,$C4,$63,$D4,$63,$E4,$63,$F4,$63,$FE,$02,$18,$FA,$3E
	db $0E,$44,$63,$54,$63,$64,$63,$74,$63,$84,$63,$94,$63,$A4,$63,$B4
	db $63,$C4,$63,$D4,$63,$E4,$63,$F4,$63,$FE,$02,$16,$8E,$2E,$0E,$34
	db $63,$44,$63,$54,$63,$64,$63,$74,$63,$84,$63,$94,$63,$A4,$63,$B4
	db $63,$C4,$63,$D4,$63,$E4,$63,$F4,$63,$FE,$02,$18,$FA,$3E,$0E,$44
	db $63,$54,$63,$64,$63,$74,$63,$84,$63,$94,$63,$A4,$63,$B4,$63,$C4
	db $63,$D4,$63,$E4,$63,$F4,$63,$FE,$02,$16,$8E,$2E,$0E,$34,$63,$44
	db $63,$54,$63,$64,$63,$74,$63,$84,$63,$94,$63,$A4,$63,$B4,$63,$C4
	db $63,$D4,$63,$E4,$63,$F4,$63,$FE,$02,$18,$FA,$3E,$0E,$44,$63,$54
	db $63,$64,$63,$74,$63,$84,$63,$94,$63,$A4,$63,$B4,$63,$C4,$63,$D4
	db $63,$E4,$63,$F4,$63,$FE,$02,$16,$8E,$2E,$0E,$34,$63,$44,$63,$54
	db $63,$64,$63,$74,$63,$84,$63,$94,$63,$A4,$63,$B4,$63,$C4,$63,$D4
	db $63,$E4,$63,$F4,$63,$FE,$02,$18,$FA,$5E,$0A,$5F,$B0,$36,$6E,$02
	db $7B,$61,$7E,$0A,$B7,$0E,$EE,$07,$FF,$10,$34,$FF,$80,$38,$FE,$8A
	db $FF,$20,$34,$FF,$80,$36,$0D,$C4,$CD,$43,$CE,$09,$DD,$42,$DE,$0B
	db $DF,$70,$38,$EF,$20,$34,$FF,$A1,$3A,$FF,$20,$34,$FF,$70,$36,$FE
	db $02,$5D,$C7,$FD

DATA_0EEB6A:
	db $58,$09,$0F,$55,$32,$0F,$6D,$32,$0F,$11,$28,$1F,$11,$28,$2F,$11
	db $28,$3F,$11,$28,$4F,$11,$28,$5F,$11,$28,$6F,$11,$28,$7F,$11,$28
	db $8F,$11,$28,$9F,$11,$28,$AF,$11,$28,$BF,$11,$28,$BF,$20,$34,$DE
	db $0C,$EF,$60,$3C,$EF,$40,$38,$F3,$3D,$03,$8E,$6E,$43,$CE,$0A,$CF
	db $40,$36,$EF,$17,$28,$EF,$20,$34,$EF,$80,$34,$FF,$17,$28,$0F,$17
	db $A8,$1F,$17,$28,$1E,$05,$2F,$80,$28,$2F,$B0,$38,$3F,$80,$28,$4F
	db $80,$28,$5F,$80,$28,$6F,$80,$28,$6E,$40,$7F,$80,$28,$8F,$80,$28
	db $9F,$80,$28,$AF,$80,$28,$BE,$01,$BF,$00,$34,$BF,$80,$34,$C7,$06
	db $DB,$0E,$DE,$00,$1F,$F0,$80,$6F,$F0,$00,$BF,$F0,$00,$0F,$F0,$80
	db $5F,$F0,$00,$7E,$05,$8F,$00,$34,$8F,$B0,$38,$AF,$80,$34,$BF,$80
	db $28,$CF,$80,$28,$DF,$80,$28,$EF,$80,$28,$FF,$20,$34,$FF,$80,$28
	db $FE,$02,$0F,$80,$A8,$1F,$80,$34,$24,$0E,$34,$30,$3E,$0C,$3F,$A1
	db $3C,$4F,$40,$38,$4E,$43,$AE,$0A,$AF,$40,$36,$BE,$0C,$CF,$40,$38
	db $EF,$40,$36,$EE,$0A,$FE,$0C,$0F,$40,$B8,$2F,$40,$36,$2E,$0A,$3E
	db $0C,$4F,$40,$38,$7F,$A1,$3A,$7F,$40,$36,$7E,$02,$8E,$0E,$94,$64
	db $A4,$64,$B4,$65,$C4,$65,$D4,$65,$E4,$65,$F4,$65,$04,$E5,$14,$65
	db $24,$65,$34,$65,$44,$65,$54,$65,$64,$65,$74,$65,$84,$65,$94,$65
	db $A4,$65,$B4,$65,$C4,$65,$D4,$65,$E4,$65,$F4,$65,$0E,$82,$04,$64
	db $2E,$86,$2F,$A1,$3C,$3F,$80,$38,$4E,$0C,$4F,$71,$3C,$5F,$40,$38
	db $9E,$09,$9F,$61,$3A,$9F,$40,$36,$A6,$60,$C1,$62,$C4,$0E,$EE,$0C
	db $EF,$61,$3C,$FF,$40,$38,$0E,$86,$1F,$71,$3A,$1F,$40,$36,$5E,$0C
	db $5F,$71,$3C,$6F,$40,$38,$7E,$09,$7F,$61,$3A,$7F,$40,$36,$86,$60
	db $A1,$62,$A4,$0E,$C6,$60,$CE,$0C,$CF,$61,$3C,$DF,$40,$38,$FE,$0A
	db $FF,$40,$36,$28,$B4,$A6,$31,$E8,$34,$8B,$B2,$9B,$0E,$FE,$07,$0F
	db $20,$B4,$0F,$80,$38,$FF,$20,$34,$FF,$80,$36,$FE,$0A,$0D,$C4,$CD
	db $43,$CE,$09,$DD,$42,$DE,$0B,$DF,$70,$38,$EF,$20,$34,$FF,$A1,$3A
	db $FF,$20,$34,$FF,$70,$36,$FE,$02,$5D,$C7,$FD

DATA_0EED15:
	db $5B,$03,$05,$34,$06,$35,$39,$71,$6E,$02,$6F,$10,$34,$AE,$0A,$AF
	db $B0,$36,$FE,$05,$0F,$B0,$B8,$0F,$20,$34,$17,$0E,$97,$0E,$9E,$02
	db $9F,$20,$34,$A6,$06,$FA,$30,$FE,$0A,$FF,$B0,$36,$4E,$82,$5F,$B0
	db $38,$57,$0E,$58,$62,$68,$62,$79,$61,$8A,$60,$8E,$0A,$8F,$B0,$36
	db $F5,$31,$F9,$73,$39,$F3,$B5,$71,$B7,$31,$4D,$C8,$8A,$62,$9A,$62
	db $AE,$05,$BB,$0E,$BF,$10,$34,$CD,$4A,$FE,$82,$FF,$00,$34,$FE,$01
	db $77,$FB,$DE,$0F,$DF,$B0,$36,$EF,$00,$34,$4E,$82,$6D,$47,$2F,$B0
	db $B6,$39,$73,$5F,$B0,$38,$0C,$EA,$08,$3F,$B3,$00,$CC,$63,$F9,$30
	db $69,$F9,$EA,$60,$FE,$07,$FF,$A1,$3C,$F9,$61,$0F,$80,$B8,$0F,$20
	db $34,$DE,$04,$DF,$A1,$3A,$DF,$80,$36,$E9,$61,$EF,$42,$28,$EF,$40
	db $34,$F4,$61,$FA,$60,$FF,$42,$28,$0F,$42,$A8,$1F,$42,$28,$2F,$42
	db $28,$3F,$42,$28,$3E,$0A,$3F,$B0,$36,$3F,$20,$34,$7E,$0C,$8F,$40
	db $38,$7E,$8A,$7F,$40,$36,$8E,$08,$94,$36,$9F,$10,$34,$9F,$80,$38
	db $9F,$40,$28,$AF,$40,$28,$BF,$40,$28,$CF,$40,$28,$DF,$40,$28,$EF
	db $40,$28,$FF,$40,$28,$FF,$80,$36,$FF,$20,$34,$FE,$0A,$0D,$C4,$61
	db $64,$71,$64,$81,$64,$CD,$43,$CE,$09,$DD,$42,$DE,$0B,$DF,$70,$38
	db $EF,$20,$34,$FF,$20,$34,$FE,$02,$5D,$C7,$FD

DATA_0EEE20:
	db $52,$71,$0F,$F0,$20,$6E,$70,$E3,$64,$FC,$61,$FC,$71,$13,$86,$2C
	db $61,$2C,$71,$43,$64,$B2,$22,$B5,$62,$C7,$28,$22,$A2,$52,$09,$56
	db $61,$6C,$03,$DB,$71,$FC,$03,$F3,$20,$03,$A4,$0F,$F1,$70,$40,$0C
	db $8C,$74,$9C,$66,$D7,$01,$EC,$71,$89,$E1,$B6,$61,$B9,$2A,$C7,$26
	db $F4,$23,$67,$E2,$E8,$F2,$78,$82,$88,$01,$98,$02,$A8,$02,$B8,$02
	db $03,$A1,$07,$26,$23,$31,$21,$79,$4B,$71,$43,$22,$CF,$F3,$30,$06
	db $E4,$16,$2A,$39,$71,$58,$45,$5A,$45,$C6,$07,$DC,$04,$3F,$F7,$E0
	db $3B,$71,$30,$31,$8C,$71,$AC,$01,$E7,$63,$39,$8F,$63,$20,$65,$0B
	db $68,$62,$8C,$00,$0C,$81,$29,$63,$3C,$01,$57,$65,$6C,$01,$85,$67
	db $9C,$04,$1D,$C1,$5F,$F6,$20,$3D,$C7,$FD

DATA_0EEEBA:
	db $50,$50,$0B,$1F,$0F,$F6,$20,$19,$96,$84,$43,$B7,$1F,$5D,$CC,$6D
	db $48,$E0,$42,$E3,$12,$39,$9C,$56,$43,$47,$9B,$A4,$12,$C1,$06,$ED
	db $4D,$F4,$42,$1B,$98,$B7,$13,$02,$C2,$03,$12,$47,$1F,$AD,$48,$63
	db $9C,$82,$48,$76,$93,$08,$94,$8E,$11,$B0,$03,$C9,$0F,$1D,$C1,$2D
	db $4A,$3F,$F0,$20,$0D,$0E,$0E,$40,$39,$71,$7F,$F7,$30,$F2,$68,$01
	db $E9,$11,$39,$68,$7A,$E0,$6A,$F0,$6A,$00,$6A,$6D,$C5,$FD

DATA_0EEF18:
	db $52,$21,$0F,$F0,$20,$6E,$60,$6C,$F6,$CA,$30,$DC,$02,$08,$F2,$37
	db $04,$56,$74,$7C,$00,$DC,$01,$E7,$25,$47,$8B,$49,$20,$6C,$02,$96
	db $74,$06,$82,$36,$02,$66,$00,$A7,$22,$DC,$02,$0A,$E0,$63,$22,$78
	db $72,$93,$09,$97,$03,$A3,$25,$A7,$03,$B6,$24,$03,$A2,$5C,$75,$65
	db $71,$7C,$00,$9C,$00,$63,$A2,$67,$20,$77,$03,$87,$20,$93,$0A,$97
	db $03,$A3,$22,$A7,$20,$B7,$03,$BC,$00,$C7,$20,$DC,$00,$FC,$01,$19
	db $8F,$1E,$20,$46,$22,$4C,$61,$63,$00,$8E,$21,$D7,$73,$46,$A6,$4C
	db $62,$68,$62,$73,$01,$8C,$62,$D8,$62,$43,$A9,$C7,$73,$EC,$06,$57
	db $F3,$7C,$00,$B5,$65,$C5,$65,$DC,$00,$E3,$67,$7D,$C1,$BF,$F6,$20
	db $AD,$C7,$FD

DATA_0EEFAB:
	db $90,$10,$0B,$1B,$0F,$F6,$20,$07,$94,$BC,$14,$BF,$F3,$10,$C7,$40
	db $FF,$F6,$10,$D1,$80,$C3,$94,$CB,$17,$C2,$44,$29,$8F,$77,$31,$0B
	db $96,$76,$32,$C7,$75,$13,$F7,$1B,$61,$2B,$61,$4B,$12,$59,$0F,$3B
	db $B0,$3A,$40,$43,$12,$7A,$40,$7B,$30,$B5,$41,$B6,$20,$C6,$07,$F3
	db $13,$6B,$92,$79,$0F,$CC,$15,$CF,$F1,$10,$1F,$F5,$90,$C3,$14,$B3
	db $95,$A3,$95,$4D,$CA,$6B,$61,$7E,$11,$8D,$41,$AF,$F0,$20,$8D,$C7
	db $FD

DATA_0EF00C:
	db $52,$31,$0F,$F0,$20,$6E,$74,$0D,$02,$03,$33,$1F,$F2,$70,$39,$71
	db $65,$04,$6C,$70,$77,$01,$84,$72,$8C,$72,$B3,$34,$EC,$01,$EF,$F2
	db $70,$0D,$04,$AC,$67,$CC,$01,$CF,$F1,$70,$E7,$22,$17,$88,$23,$00
	db $27,$23,$3C,$62,$65,$71,$67,$33,$8C,$61,$DC,$01,$08,$FA,$45,$75
	db $63,$0A,$73,$23,$7C,$02,$8F,$F2,$70,$73,$A9,$9F,$F4,$70,$BF,$F4
	db $70,$EF,$F3,$70,$39,$F1,$FC,$0A,$0D,$0B,$13,$25,$4C,$01,$4F,$F2
	db $70,$73,$0B,$77,$03,$DC,$08,$23,$A2,$53,$09,$56,$03,$63,$24,$8C
	db $02,$3F,$F3,$B0,$77,$63,$96,$74,$B3,$77,$5D,$C1,$9F,$F6,$20,$8D
	db $C7,$FD

DATA_0EF08E:
	db $54,$11,$0F,$F6,$20,$CF,$F2,$30,$F8,$62,$FE,$10,$3C,$B2,$BD,$48
	db $EA,$62,$FC,$4D,$FC,$4D,$17,$C9,$DA,$62,$0B,$97,$B7,$12,$2C,$B1
	db $33,$43,$6C,$31,$AC,$41,$0B,$98,$AD,$4A,$DB,$30,$27,$B0,$B7,$14
	db $C6,$42,$C7,$96,$D6,$44,$2B,$92,$39,$0F,$72,$41,$A7,$00,$1B,$95
	db $97,$13,$6C,$95,$6F,$F1,$10,$A2,$40,$BF,$F5,$10,$C2,$40,$0B,$9A
	db $62,$42,$63,$12,$AD,$4A,$0E,$91,$1D,$41,$5F,$F6,$20,$5D,$C7,$FD

DATA_0EF0EE:
	db $57,$11,$0F,$F6,$20,$FE,$10,$4B,$92,$59,$0F,$AD,$4C,$D3,$93,$0B
	db $94,$29,$0F,$7B,$93,$99,$0F,$0D,$06,$27,$12,$35,$0F,$23,$B1,$57
	db $75,$A3,$31,$AB,$71,$F7,$75,$23,$B1,$87,$13,$95,$0F,$0D,$0A,$23
	db $35,$38,$13,$55,$00,$9B,$16,$0B,$96,$C7,$75,$DD,$4A,$3B,$92,$49
	db $0F,$AD,$4C,$29,$92,$52,$40,$6C,$15,$6F,$F1,$10,$72,$40,$BF,$F5
	db $10,$03,$93,$0A,$13,$12,$41,$8B,$12,$99,$0F,$0D,$10,$47,$16,$46
	db $45,$B3,$32,$13,$B1,$57,$0E,$A7,$0E,$D3,$31,$53,$B1,$A6,$31,$03
	db $B2,$13,$0E,$8D,$4D,$AE,$11,$BD,$41,$DF,$F0,$20,$AD,$C7,$FD

DATA_0EF16D:
	db $52,$A1,$0F,$F0,$20,$6E,$65,$04,$A0,$14,$07,$24,$2D,$57,$25,$BC
	db $09,$4C,$80,$6F,$F3,$30,$A5,$11,$A7,$63,$B7,$63,$E7,$20,$35,$A0
	db $59,$11,$B4,$08,$C0,$04,$05,$82,$15,$02,$25,$02,$3A,$10,$4C,$01
	db $6C,$79,$95,$79,$73,$A7,$8F,$F4,$70,$F3,$0A,$03,$A0,$93,$08,$97
	db $73,$E3,$20,$39,$F1,$94,$07,$AA,$30,$BC,$5C,$C7,$30,$24,$F2,$27
	db $31,$8F,$F3,$30,$C6,$10,$C7,$63,$D7,$63,$E7,$63,$F7,$63,$03,$A5
	db $07,$25,$AA,$10,$03,$BF,$4F,$F4,$70,$6C,$00,$DF,$F4,$70,$FC,$00
	db $5C,$81,$77,$73,$9D,$4C,$C5,$30,$E3,$30,$7D,$C1,$BD,$4D,$BF,$F6
	db $20,$AD,$C7,$FD

DATA_0EF1F1:
	db $55,$A1,$0F,$F6,$20,$9C,$01,$4F,$F6,$B0,$B3,$34,$C9,$3F,$13,$BA
	db $A3,$B3,$BF,$F4,$70,$0C,$84,$83,$3F,$9F,$F4,$70,$EF,$F2,$70,$EC
	db $01,$2F,$F2,$F0,$2C,$01,$6F,$F2,$70,$6C,$01,$A8,$91,$AA,$10,$03
	db $B7,$61,$79,$6F,$F5,$70,$39,$F1,$DB,$71,$03,$A2,$17,$22,$33,$09
	db $43,$20,$5B,$71,$48,$8F,$4A,$30,$5C,$5C,$A3,$30,$2D,$C1,$6F,$06
	db $20,$4D,$C7,$FD

DATA_0EF245:
	db $55,$A1,$0F,$F6,$20,$39,$91,$68,$12,$A7,$12,$AA,$10,$C7,$07,$E8
	db $12,$19,$91,$6C,$00,$78,$74,$0E,$C2,$76,$83,$86,$03,$96,$03,$A6
	db $03,$B6,$03,$C6,$03,$D6,$03,$E6,$03,$F6,$03,$FE,$40,$29,$91,$73
	db $29,$77,$53,$8C,$77,$59,$91,$87,$13,$B6,$14,$BA,$10,$E8,$12,$38
	db $92,$19,$8F,$2C,$00,$33,$67,$4E,$42,$68,$03,$2E,$C0,$38,$72,$A8
	db $11,$AA,$10,$49,$91,$6E,$42,$DE,$40,$E7,$22,$0E,$C2,$4E,$C0,$6C
	db $00,$79,$11,$8C,$01,$A7,$13,$BC,$01,$D5,$15,$EC,$01,$03,$97,$0E
	db $00,$6E,$01,$9D,$41,$BF,$F0,$20,$AD,$C7,$FD

DATA_0EF2C0:
	db $10,$21,$39,$F1,$09,$F1,$AD,$4C,$7C,$83,$96,$30,$5B,$F1,$C8,$05
	db $1F,$F7,$B0,$93,$67,$A3,$67,$B3,$67,$BD,$4D,$CC,$08,$54,$FE,$70
	db $6A,$80,$6A,$90,$6A,$A0,$6A,$B0,$6A,$C0,$6A,$D0,$6A,$E0,$6A,$F0
	db $6A,$00,$EA,$6D,$47,$FD

DATA_0EF2F6:
	db $00,$C1,$4C,$00,$02,$C9,$BA,$49,$62,$C9,$A4,$20,$A5,$20,$1A,$C9
	db $A3,$2C,$B2,$49,$56,$C2,$6E,$00,$95,$41,$AD,$C7,$FD

DATA_0EF313:
	db $48,$8F,$1E,$01,$4E,$02,$00,$8C,$09,$0F,$6E,$0A,$EE,$82,$2E,$80
	db $30,$20,$7E,$01,$87,$27,$07,$87,$17,$23,$3E,$00,$9E,$05,$5B,$F1
	db $8B,$71,$BB,$71,$EB,$71,$3E,$82,$7F,$F8,$30,$FE,$0A,$3E,$84,$47
	db $29,$48,$2E,$AF,$F1,$70,$CB,$71,$E7,$0A,$F7,$23,$2B,$F1,$37,$51
	db $3E,$00,$6F,$F0,$00,$8E,$04,$DF,$F2,$30,$9C,$82,$CA,$12,$DC,$00
	db $E8,$14,$FC,$00,$FE,$08,$4E,$8A,$88,$74,$9E,$01,$A8,$52,$BF,$F7
	db $40,$B8,$52,$C8,$52,$D8,$52,$E8,$52,$EE,$0F,$4D,$C7,$0D,$0D,$0E
	db $02,$68,$7A,$BE,$01,$EE,$0F,$6D,$C5,$FD

DATA_0EF38D:
	db $08,$0F,$0E,$01,$2E,$05,$38,$20,$3E,$04,$48,$07,$55,$45,$57,$45
	db $58,$25,$B8,$08,$BE,$05,$C8,$20,$CE,$01,$DF,$FA,$40,$6D,$C7,$0E
	db $81,$00,$5A,$2E,$02,$34,$42,$36,$42,$37,$22,$73,$54,$83,$0B,$87
	db $20,$93,$54,$90,$07,$B4,$41,$B6,$41,$B7,$21,$DF,$FA,$40,$6D,$C7
	db $0E,$81,$00,$5A,$14,$56,$24,$56,$2E,$0C,$33,$43,$6E,$09,$8E,$0B
	db $96,$48,$1E,$84,$3E,$05,$4A,$48,$47,$0B,$CE,$01,$DF,$FA,$40,$6D
	db $C7,$FD

DATA_0EF3EF:
	db $41,$01,$DA,$60,$E9,$61,$F8,$62,$00,$E3,$07,$63,$10,$63,$17,$63
	db $20,$63,$27,$63,$30,$63,$37,$63,$40,$63,$47,$63,$50,$63,$57,$63
	db $60,$63,$67,$63,$70,$63,$77,$63,$80,$63,$87,$63,$90,$63,$97,$63
	db $A0,$63,$A7,$63,$B0,$63,$B7,$63,$C0,$63,$C7,$63,$D0,$63,$D7,$63
	db $E0,$63,$E7,$63,$F0,$63,$F7,$63,$47,$D3,$8A,$60,$99,$61,$A8,$62
	db $B7,$63,$C6,$64,$D5,$65,$E4,$66,$ED,$49,$F3,$67,$1A,$CB,$E3,$67
	db $F3,$67,$00,$BF,$31,$56,$3C,$02,$77,$53,$AC,$02,$B1,$56,$E7,$53
	db $FE,$01,$77,$B9,$A3,$43,$00,$BF,$29,$51,$39,$48,$61,$55,$D2,$44
	db $D6,$54,$0C,$82,$30,$39,$31,$66,$44,$47,$47,$32,$4A,$47,$97,$32
	db $C1,$66,$DC,$02,$00,$BF,$0C,$0F,$08,$4F,$04,$63,$14,$63,$24,$63
	db $34,$63,$44,$63,$54,$63,$64,$63,$74,$63,$84,$63,$94,$63,$A4,$63
	db $B4,$63,$C4,$63,$D4,$63,$E4,$63,$F4,$63,$00,$BF,$75,$60,$FE,$01
	db $0C,$87,$9A,$60,$A9,$61,$B8,$62,$C7,$63,$D0,$6A,$D5,$0D,$E0,$6A
	db $F0,$6A,$00,$EA,$6D,$4A,$7D,$47,$FD

if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMBLL_J) != $00
%FREE_BYTES(NULLROM, 2360, $FF)
else
%FREE_BYTES(NULLROM, 2872, $FF)
endif
%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro SMBLLBank0FMacros(StartBank, EndBank)
%BANK_START(<StartBank>)
CODE_0F8000:
	JSL.l CODE_0E8F35
	STZ.w $0EDC
	PHB
	LDA.b #$7ED000>>16
	PHA
	PLB
	LDA.b $DB
	STA.w $0F35
	CMP.b #$23
	BNE.b CODE_0F801F
	LDX.b $43
	CPX.b #$0C
	BNE.b CODE_0F801F
	LDX.b #$47
	STX.b $DB
CODE_0F801F:
	REP.b #$30
	LDX.w #$0000
	LDA.w #$0000
CODE_0F8027:
	STA.w $7ED000,x
	STA.w $7ED100,x
	STA.w $7ED200,x
	STA.w $7ED300,x
	STA.w $7ED400,x
	STA.w $7ED500,x
	STA.w $7ED600,x
	STA.w $7ED700,x
	STA.w $7ED800,x
	STA.w $7ED900,x
	STA.w $7EDA00,x
	STA.w $7EDB00,x
	STA.w $7EDC00,x
	STA.w $7EDD00,x
	STA.w $7EDE00,x
	STA.w $7EDF00,x
	STA.w $7EE000,x
	STA.w $7EE100,x
	STA.w $7EE200,x
	INX
	INX
	CPX.w #$0100
	BNE.b CODE_0F8027
	PLB
	PHB
	PHK
	PLB
	STZ.w $0EC0
	LDA.w $0E65
	AND.w #$00FF
	BEQ.b CODE_0F8078
	STA.b $DB
CODE_0F8078:
	LDA.b $DB
	AND.w #$00FF
	ASL
	TAX
	LDA.w DATA_0FAE02,x
	STA.b $02
CODE_0F8084:
	REP.b #$30
	LDX.b $02
	LDA.w DATA_0FB6A1,x
	STA.b $04
	INC.b $02
	INC.b $02
	AND.w #$03F0
	LSR
	LSR
	LSR
	LSR
	STA.b $EF
	LDA.b $04
	AND.w #$000F
	STA.b $F1
	LDA.b $04
	AND.w #$E000
	STA.b $ED
	LDA.b $04
	LSR
	AND.w #$0E00
	ORA.b $ED
	XBA
	STA.b $ED
	AND.w #$00F0
	CMP.w #$00E0
	BNE.b CODE_0F80DC
	LDA.b $EF
	CMP.w #$003F
	BNE.b CODE_0F80D7
	INC.w $0EC0
	INC.w $0EC0
	LDA.w $0EC0
	XBA
	TAX
	LDA.w #$FFFF
	STA.l $7ED000,x
	JMP.w CODE_0F91CF

CODE_0F80D7:
	JSR.w CODE_0F8FB5
	BRA.b CODE_0F8084

CODE_0F80DC:
	LDA.w $0EC0
	XBA
	CLC
	ADC.b $ED
	STA.b $EB
	LDA.b $EF
	CMP.w #$0010
	BCC.b CODE_0F80F2
	JSR.w CODE_0F8F1D
	JMP.w CODE_0F8084

CODE_0F80F2:
	ASL
	TAX
	LDA.b $DB
	ASL
	TAY
	LDA.w DATA_0F810A,y
	STA.b $04
	LDA.w #DATA_0F8204>>16
	STA.b $06
	TXY
	LDA.b [$04],y
	STA.b $00
	JMP.w ($0000)

DATA_0F810A:
	dw DATA_0F8204
	dw DATA_0F8204
	dw DATA_0F8204
	dw DATA_0F8204
	dw DATA_0F8204
	dw DATA_0F8204
	dw DATA_0F8204
	dw DATA_0F81E4
	dw DATA_0F81BE
	dw DATA_0F81BE
	dw DATA_0F8204
	dw DATA_0F8204
	dw DATA_0F8204
	dw DATA_0F81E4
	dw DATA_0F81BE
	dw DATA_0F8254
	dw DATA_0F81BE
	dw DATA_0F81BE
	dw DATA_0F81BE
	dw DATA_0F821C
	dw DATA_0F8254
	dw DATA_0F81BE
	dw DATA_0F81BE
	dw DATA_0F81BE
	dw DATA_0F8254
	dw DATA_0F821C
	dw DATA_0F8254
	dw DATA_0F821C
	dw DATA_0F819A
	dw DATA_0F81BE
	dw DATA_0F81BE
	dw DATA_0F81BE
	dw DATA_0F821C
	dw DATA_0F81BE
	dw DATA_0F8254
	dw DATA_0F821C
	dw DATA_0F823C
	dw DATA_0F81BE
	dw DATA_0F81BE
	dw DATA_0F81BE
	dw DATA_0F81BE
	dw DATA_0F81BE
	dw DATA_0F81BE
	dw DATA_0F81BE
	dw DATA_0F819A
	dw DATA_0F81BE
	dw DATA_0F8254
	dw DATA_0F81BE
	dw DATA_0F81BE
	dw DATA_0F81BE
	dw DATA_0F821C
	dw DATA_0F821C
	dw DATA_0F81A2
	dw DATA_0F81BE
	dw DATA_0F81BE
	dw DATA_0F81DE
	dw DATA_0F81DE
	dw DATA_0F81BE
	dw DATA_0F81DE
	dw DATA_0F81BE
	dw DATA_0F81DE
	dw DATA_0F81BE
	dw DATA_0F81B6
	dw DATA_0F81B6
	dw DATA_0F81B6
	dw DATA_0F81A0
	dw DATA_0F81B6
	dw DATA_0F81B6
	dw DATA_0F81B6
	dw DATA_0F81B6
	dw DATA_0F81B6
	dw DATA_0F81BE

DATA_0F819A:
	dw CODE_0F82B4
	dw CODE_0F82B9
	dw CODE_0F826A

DATA_0F81A0:
	dw CODE_0F8357

DATA_0F81A2:
	dw CODE_0F90A0
	dw CODE_0F86C3
	dw CODE_0F86C1
	dw CODE_0F86B8
	dw CODE_0F86AE
	dw CODE_0F86C3
	dw CODE_0F86C3
	dw CODE_0F86AE
	dw CODE_0F86C1
	dw CODE_0F86C3

DATA_0F81B6:
	dw CODE_0F8799
	dw CODE_0F879B
	dw CODE_0F87D3
	dw CODE_0F87D5

DATA_0F81BE:
	dw CODE_0F8A0A
	dw CODE_0F875E
	dw CODE_0F875E
	dw CODE_0F875E
	dw CODE_0F88BA
	dw CODE_0F88B8
	dw CODE_0F88AF
	dw CODE_0F88AD
	dw CODE_0F885F
	dw CODE_0F8869
	dw CODE_0F8875
	dw CODE_0F8881
	dw CODE_0F888D
	dw CODE_0F8899
	dw CODE_0F88A1
	dw CODE_0F8502

DATA_0F81DE:
	dw CODE_0F8A78
	dw CODE_0F8A95
	dw CODE_0F8AC6

DATA_0F81E4:
	dw CODE_0F8663
	dw CODE_0F8661
	dw CODE_0F8663
	dw CODE_0F8661
	dw CODE_0F8663
	dw CODE_0F8661
	dw CODE_0F8663
	dw CODE_0F8661
	dw CODE_0F8663
	dw CODE_0F8661
	dw CODE_0F8663
	dw CODE_0F8661
	dw CODE_0F8663
	dw CODE_0F8661
	dw CODE_0F8663
	dw CODE_0F8661

DATA_0F8204:
	dw CODE_0F8BE9
	dw CODE_0F8BE9
	dw CODE_0F8C27
	dw CODE_0F8CFE
	dw CODE_0F8D78
	dw CODE_0F8E22
	dw CODE_0F8BBA
	dw CODE_0F8B00
	dw CODE_0F8B6D
	dw CODE_0F8E6B
	dw CODE_0F8E69
	dw CODE_0F8E5D

DATA_0F821C:
	dw CODE_0F870E
	dw CODE_0F870E
	dw CODE_0F870E
	dw CODE_0F870E
	dw CODE_0F870E
	dw CODE_0F870E
	dw CODE_0F870E
	dw CODE_0F870E
	dw CODE_0F870E
	dw CODE_0F870E
	dw CODE_0F870E
	dw CODE_0F870E
	dw CODE_0F870E
	dw CODE_0F870E
	dw CODE_0F870E
	dw CODE_0F870E

DATA_0F823C:
	dw CODE_0F84BA
	dw CODE_0F84B8
	dw CODE_0F84AE
	dw CODE_0F84AC
	dw CODE_0F84A7
	dw CODE_0F84A5
	dw CODE_0F849B
	dw CODE_0F8499
	dw CODE_0F845E
	dw CODE_0F845C
	dw CODE_0F8452
	dw CODE_0F8450

DATA_0F8254:
	dw CODE_0F837C

;--------------------------------------------------------------------

DATA_0F8256:
	db $07,$0A,$0B,$12,$19
	db $29,$2A,$33,$34,$30
	db $00,$07,$0A,$1D,$19
	db $00,$29,$2A,$2D,$30

CODE_0F826A:
	LDY.b $F1
	LDX.b $EB
	SEP.b #$20
	LDA.w DATA_0F8256,y
	STA.l $7ED000,x
	LDA.w DATA_0F8256+$01,y
	STA.l $7ED010,x
	LDA.w DATA_0F8256+$02,y
	STA.l $7ED020,x
	LDA.w DATA_0F8256+$03,y
	STA.l $7ED030,x
	LDA.w DATA_0F8256+$04,y
	STA.l $7ED040,x
	REP.b #$20
	JMP.w CODE_0F8084

;--------------------------------------------------------------------

DATA_0F8298:
	db $01,$02,$03,$04,$08,$09,$05,$06,$10,$11,$17,$18,$1B,$1C
	db $1F,$20,$21,$22,$25,$26,$23,$24,$2B,$2C,$2E,$2F,$31,$32

CODE_0F82B4:
	LDY.w #$000E
	BRA.b CODE_0F82BC

CODE_0F82B9:
	LDY.w #$0000
CODE_0F82BC:
	LDX.b $EB
	INX
	SEP.b #$20
	LDA.w DATA_0F8298,y
	STA.l $7ED000,x
	LDA.w DATA_0F8298+$01,y
	STA.l $7ED001,x
	LDA.w DATA_0F8298+$02,y
	STA.l $7ED010,x
	LDA.w DATA_0F8298+$03,y
	STA.l $7ED011,x
	LDA.w DATA_0F8298+$06,y
	STA.l $7ED020,x
	LDA.w DATA_0F8298+$07,y
	STA.l $7ED021,x
	LDA.b #$30
	STA.b $E4
	STZ.b $E5
CODE_0F82F1:
	REP.b #$20
	TXA
	CLC
	ADC.b $E4
	TAX
	SEP.b #$20
	CMP.b #$D0
	BCS.b CODE_0F8322
	LDA.w DATA_0F8298+$04,y
	STA.l $7ED000,x
	LDA.w DATA_0F8298+$05,y
	STA.l $7ED001,x
	LDA.w DATA_0F8298+$06,y
	STA.l $7ED010,x
	LDA.w DATA_0F8298+$07,y
	STA.l $7ED011,x
	LDA.b #$20
	STA.b $E4
	STZ.b $E5
	BRA.b CODE_0F82F1

CODE_0F8322:
	LDA.w DATA_0F8298+$08,y
	STA.l $7ED000,x
	LDA.w DATA_0F8298+$09,y
	STA.l $7ED001,x
	LDA.w DATA_0F8298+$0A,y
	STA.l $7ED010,x
	LDA.w DATA_0F8298+$0B,y
	STA.l $7ED011,x
	LDA.w DATA_0F8298+$0C,y
	STA.l $7ED020,x
	LDA.w DATA_0F8298+$0D,y
	STA.l $7ED021,x
	REP.b #$20
	JMP.w CODE_0F8084

;--------------------------------------------------------------------

DATA_0F8351:
	dw $0000,$0041,$0082

CODE_0F8357:
	LDA.b $F1
	ASL
	TAY
	LDA.w DATA_0F8351,y
	TAY
	LDA.b $EB
	CLC
	ADC.w #$0010
	TAX
	SEP.b #$20
CODE_0F8368:
	LDA.w DATA_0FB5DE,y
	CMP.b #$FF
	BEQ.b CODE_0F8377
	STA.l $7ED000,x
	INY
	INX
	BRA.b CODE_0F8368

CODE_0F8377:
	REP.b #$20
	JMP.w CODE_0F8084

;--------------------------------------------------------------------

CODE_0F837C:
	LDX.b $EB
	LDA.b $F1
	STA.b $E6
	SEP.b #$20
	STZ.b $E8
CODE_0F8386:
	LDA.b #$09
	STA.l $7ED000,x
	LDA.b #$0E
	STA.l $7ED010,x
	STA.l $7ED030,x
	STA.l $7ED050,x
	LDA.b #$12
	STA.l $7ED020,x
	STA.l $7ED040,x
	INX
	REP.b #$20
	TXA
	AND.w #$000F
	BNE.b CODE_0F83B5
	TXA
	CLC
	ADC.w #$00F0
	TAX
	INC.b $E8
CODE_0F83B5:
	SEP.b #$20
	DEC.b $E6
	LDA.b $E6
	BMI.b CODE_0F83F4
	LDA.b #$09
	STA.l $7ED000,x
	LDA.b #$0F
	STA.l $7ED010,x
	STA.l $7ED030,x
	STA.l $7ED050,x
	LDA.b #$13
	STA.l $7ED020,x
	STA.l $7ED040,x
	INX
	REP.b #$20
	TXA
	AND.w #$000F
	BNE.b CODE_0F83EC
	TXA
	CLC
	ADC.w #$00F0
	TAX
	INC.b $E8
CODE_0F83EC:
	SEP.b #$20
	DEC.b $E6
	LDA.b $E6
	BPL.b CODE_0F8386
CODE_0F83F4:
	LDX.b $EB
	LDA.b $F1
	CMP.b #$04
	BCC.b CODE_0F83FE
	LDA.b #$04
CODE_0F83FE:
	TAY
	LDA.w DATA_0F8425,y
	STA.l $7ECFFF,x
	REP.b #$20
	LDA.b $E8
	BEQ.b CODE_0F8412
	TXA
	CLC
	ADC.w #$00F0
	TAX
CODE_0F8412:
	TXA
	CLC
	ADC.b $F1
	TAX
	SEP.b #$20
	LDA.w DATA_0F842A,y
	STA.l $7ED001,x
	REP.b #$20
	JMP.w CODE_0F8084

DATA_0F8425:
	db $08,$08,$04,$04,$08

DATA_0F842A:
	db $0A,$06,$0A,$06,$0A

;--------------------------------------------------------------------

DATA_0F842F:
	db $01,$02,$03,$02,$04,$01,$02,$02
	db $03,$02,$02,$04,$07,$08,$09,$07
	db $0E,$08,$0E,$09,$01,$03,$04

DATA_0F8446:
	db $04,$06,$02,$04,$02

DATA_0F844B:
	db $00,$05,$0C,$0F,$14

CODE_0F8450:
	INC.b $EB
CODE_0F8452:
	LDA.b $EB
	CLC
	ADC.w #$0010
	STA.b $EB
	BRA.b CODE_0F845E

CODE_0F845C:
	INC.b $EB
CODE_0F845E:
	LDX.b $EB
	LDA.b $F1
	TAY
	LDA.w DATA_0F8446,y
	AND.w #$00FF
	STA.b $F1
	LDA.w DATA_0F844B,y
	AND.w #$00FF
	TAY
	SEP.b #$20
CODE_0F8474:
	LDA.w DATA_0F842F,y
	STA.l $7ED000,x
	INX
	INY
	TXA
	AND.b #$0F
	BNE.b CODE_0F848C
	REP.b #$20
	TXA
	CLC
	ADC.w #$00F0
	TAX
	SEP.b #$20
CODE_0F848C:
	DEC.b $F1
	BPL.b CODE_0F8474
	REP.b #$20
	JMP.w CODE_0F8084

;--------------------------------------------------------------------

DATA_0F8495:
	db $05,$0A

DATA_0F8497:
	db $06,$0C

CODE_0F8499:
	INC.b $EB
CODE_0F849B:
	LDA.b $EB
	CLC
	ADC.w #$0010
	STA.b $EB
	BRA.b CODE_0F84A7

CODE_0F84A5:
	INC.b $EB
CODE_0F84A7:
	LDY.w #$0001
	BRA.b CODE_0F84BD

CODE_0F84AC:
	INC.b $EB
CODE_0F84AE:
	LDA.b $EB
	CLC
	ADC.w #$0010
	STA.b $EB
	BRA.b CODE_0F84BA

CODE_0F84B8:
	INC.b $EB
CODE_0F84BA:
	LDY.w #$0000
CODE_0F84BD:
	LDX.b $EB
	SEP.b #$20
	LDA.w DATA_0F8495,y
	STA.l $7ED000,x
	REP.b #$20
	TXA
	CLC
	ADC.w #$0010
	TAX
	SEP.b #$20
	DEC.b $F1
CODE_0F84D4:
	LDA.l $7ED000,x
	CMP.b #$0E
	BNE.b CODE_0F84E0
	LDA.b #$0D
	BRA.b CODE_0F84EB

CODE_0F84E0:
	CMP.b #$02
	BNE.b CODE_0F84E8
	LDA.b #$0B
	BRA.b CODE_0F84EB

CODE_0F84E8:
	LDA.w DATA_0F8497,y
CODE_0F84EB:
	STA.l $7ED000,x
	REP.b #$20
	TXA
	CLC
	ADC.w #$0010
	TAX
	SEP.b #$20
	DEC.b $F1
	BPL.b CODE_0F84D4
	REP.b #$20
	JMP.w CODE_0F8084

;--------------------------------------------------------------------

CODE_0F8502:
	LDA.b $EB
	CLC
	ADC.w #$0010
	TAX
	SEP.b #$20
	LDA.b #$4E
	STA.l $7ED030,x
	LDA.l $7ED000,x
	BEQ.b CODE_0F851B
	LDA.b #$38
	BRA.b CODE_0F851D

CODE_0F851B:
	LDA.b #$34
CODE_0F851D:
	STA.l $7ED000,x
	LDA.l $7ED010,x
	BEQ.b CODE_0F852F
	CMP.b #$12
	BEQ.b CODE_0F852F
	LDA.b #$44
	BRA.b CODE_0F8531

CODE_0F852F:
	LDA.b #$40
CODE_0F8531:
	STA.l $7ED010,x
	LDA.l $7ED020,x
	BEQ.b CODE_0F8543
	CMP.b #$12
	BEQ.b CODE_0F8543
	LDA.b #$4D
	BRA.b CODE_0F8545

CODE_0F8543:
	LDA.b #$4C
CODE_0F8545:
	STA.l $7ED020,x
	INX
	LDA.l $7ED000,x
	BEQ.b CODE_0F856C
	CMP.b #$12
	BEQ.b CODE_0F856C
	CMP.b #$18
	BEQ.b CODE_0F8568
	CMP.b #$07
	BEQ.b CODE_0F8568
	CMP.b #$17
	BEQ.b CODE_0F8564
	LDA.b #$39
	BRA.b CODE_0F856E

CODE_0F8564:
	LDA.b #$3D
	BRA.b CODE_0F856E

CODE_0F8568:
	LDA.b #$36
	BRA.b CODE_0F856E

CODE_0F856C:
	LDA.b #$35
CODE_0F856E:
	STA.l $7ED000,x
	LDA.b #$41
	STA.l $7ED010,x
	LDA.b #$48
	STA.l $7ED020,x
	LDA.b #$4E
	STA.l $7ED030,x
	INX
CODE_0F8585:
	DEC.b $F1
	LDA.b $F1
	BNE.b CODE_0F858E
	JMP.w CODE_0F860E

CODE_0F858E:
	LDA.l $7ED000,x
	BNE.b CODE_0F85AE
	LDA.b #$36
	STA.l $7ED000,x
	LDA.b #$35
	STA.l $7ED001,x
	LDA.b #$42
	STA.l $7ED010,x
	LDA.b #$41
	STA.l $7ED011,x
	BRA.b CODE_0F85E4

CODE_0F85AE:
	CMP.b #$18
	BEQ.b CODE_0F85CC
	LDA.b #$3A
	STA.l $7ED000,x
	LDA.b #$39
	STA.l $7ED001,x
	LDA.b #$42
	STA.l $7ED010,x
	LDA.b #$41
	STA.l $7ED011,x
	BRA.b CODE_0F85E4

CODE_0F85CC:
	LDA.b #$36
	STA.l $7ED000,x
	LDA.b #$35
	STA.l $7ED001,x
	LDA.b #$42
	STA.l $7ED010,x
	LDA.b #$41
	STA.l $7ED011,x
CODE_0F85E4:
	LDA.b #$47
	STA.l $7ED020,x
	LDA.b #$48
	STA.l $7ED021,x
	LDA.b #$4E
	STA.l $7ED030,x
	STA.l $7ED031,x
	INX
	INX
	TXA
	AND.b #$0F
	BNE.b CODE_0F8585
	REP.b #$20
	TXA
	CLC
	ADC.w #$00F0
	TAX
	SEP.b #$20
	JMP.w CODE_0F8585

CODE_0F860E:
	LDA.b #$42
	STA.l $7ED010,x
	LDA.b #$47
	STA.l $7ED020,x
	LDA.b #$4E
	STA.l $7ED030,x
	STA.l $7ED031,x
	LDA.l $7ED000,x
	BNE.b CODE_0F8644
	LDA.b #$36
	STA.l $7ED000,x
	LDA.b #$37
	STA.l $7ED001,x
	LDA.b #$43
	STA.l $7ED011,x
	LDA.b #$49
	STA.l $7ED021,x
	BRA.b CODE_0F865C

CODE_0F8644:
	LDA.b #$3A
	STA.l $7ED000,x
	LDA.b #$3B
	STA.l $7ED001,x
	LDA.b #$45
	STA.l $7ED011,x
	LDA.b #$4A
	STA.l $7ED021,x
CODE_0F865C:
	REP.b #$20
	JMP.w CODE_0F8084

;--------------------------------------------------------------------

CODE_0F8661:
	INC.b $EB
CODE_0F8663:
	LDX.b $EB
	STX.b $E2
	LDA.b $EF
	ASL
	TAY
	LDA.w DATA_0F87FF,y
	TAY
	SEP.b #$20
CODE_0F8671:
	LDA.w DATA_0FB46D,y
	BEQ.b CODE_0F8685
	CMP.b #$FF
	BEQ.b CODE_0F86A9
	CMP.b #$FE
	BEQ.b CODE_0F8699
	LDA.w DATA_0FB46D,y
	STA.l $7ED000,x
CODE_0F8685:
	INY
	INX
	REP.b #$20
	TXA
	AND.w #$000F
	BNE.b CODE_0F8695
	TXA
	CLC
	ADC.w #$00F0
	TAX
CODE_0F8695:
	SEP.b #$20
	BRA.b CODE_0F8671

CODE_0F8699:
	REP.b #$20
	LDA.b $E2
	CLC
	ADC.w #$0010
	STA.b $E2
	TAX
	SEP.b #$20
	INY
	BRA.b CODE_0F8671

CODE_0F86A9:
	REP.b #$20
	JMP.w CODE_0F8084

;--------------------------------------------------------------------

CODE_0F86AE:
	LDA.b $EB
	CLC
	ADC.w #$0010
	TAX
	INX
	BRA.b CODE_0F86C5

CODE_0F86B8:
	LDA.b $EB
	CLC
	ADC.w #$0010
	TAX
	BRA.b CODE_0F86C5

CODE_0F86C1:
	INC.b $EB
CODE_0F86C3:
	LDX.b $EB
CODE_0F86C5:
	STX.b $E2
	LDA.b $EF
	ASL
	TAY
	LDA.w DATA_0F881F,y
	TAY
	SEP.b #$20
CODE_0F86D1:
	LDA.w DATA_0FB52C,y
	BEQ.b CODE_0F86E5
	CMP.b #$FF
	BEQ.b CODE_0F8709
	CMP.b #$FE
	BEQ.b CODE_0F86F9
	LDA.w DATA_0FB52C,y
	STA.l $7ED000,x
CODE_0F86E5:
	INY
	INX
	REP.b #$20
	TXA
	AND.w #$000F
	BNE.b CODE_0F86F5
	TXA
	CLC
	ADC.w #$00F0
	TAX
CODE_0F86F5:
	SEP.b #$20
	BRA.b CODE_0F86D1

CODE_0F86F9:
	REP.b #$20
	LDA.b $E2
	CLC
	ADC.w #$0010
	STA.b $E2
	TAX
	SEP.b #$20
	INY
	BRA.b CODE_0F86D1

CODE_0F8709:
	REP.b #$20
	JMP.w CODE_0F8084

;--------------------------------------------------------------------

CODE_0F870E:
	LDX.b $EB
	STX.b $E2
	LDA.b $EF
	ASL
	TAY
	LDA.w DATA_0F8833,y
	TAY
	SEP.b #$20
CODE_0F871C:
	LDA.w DATA_0FAE92,y
	BEQ.b CODE_0F872D
	CMP.b #$FF
	BEQ.b CODE_0F8759
	CMP.b #$FE
	BEQ.b CODE_0F8741
	STA.l $7ED000,x
CODE_0F872D:
	INY
	INX
	REP.b #$20
	TXA
	AND.w #$000F
	BNE.b CODE_0F873D
	TXA
	CLC
	ADC.w #$00F0
	TAX
CODE_0F873D:
	SEP.b #$20
	BRA.b CODE_0F871C

CODE_0F8741:
	REP.b #$20
	LDA.b $E2
	CLC
	ADC.w #$0010
	STA.b $E2
	TAX
	AND.w #$00F0
	CMP.w #$00F0
	BEQ.b CODE_0F8759
	SEP.b #$20
	INY
	BRA.b CODE_0F871C

CODE_0F8759:
	REP.b #$20
	JMP.w CODE_0F8084

;--------------------------------------------------------------------

CODE_0F875E:
	DEC.b $EF
	LDA.b $EF
	AND.w #$0003
	ASL
	ASL
	ASL
	ASL
	ORA.b $F1
	ASL
	ASL
	TAY
	LDX.b $EB
	SEP.b #$20
	LDA.w DATA_0F92E2,y
	STA.l $7ED000,x
	LDA.w DATA_0F92E2+$01,y
	STA.l $7ED001,x
	LDA.w DATA_0F92E2+$02,y
	STA.l $7ED010,x
	LDA.w DATA_0F92E2+$03,y
	STA.l $7ED011,x
	REP.b #$20
	JMP.w CODE_0F8084

;--------------------------------------------------------------------

DATA_0F8793:
	db $04,$05,$0B,$0C,$0B,$0C

CODE_0F8799:
	INC.b $EB
CODE_0F879B:
	LDA.b $EB
	CLC
	ADC.w #$0020
	TAX
	SEP.b #$20
	LDA.w DATA_0F8793
	STA.l $7ED000,x
	LDA.w DATA_0F8793+$01
	STA.l $7ED001,x
	LDA.w DATA_0F8793+$02
	STA.l $7ED010,x
	LDA.w DATA_0F8793+$03
	STA.l $7ED011,x
	LDA.w DATA_0F8793+$04
	STA.l $7ED020,x
	LDA.w DATA_0F8793+$05
	STA.l $7ED021,x
	REP.b #$20
	JMP.w CODE_0F8084

;--------------------------------------------------------------------

CODE_0F87D3:
	INC.b $EB
CODE_0F87D5:
	LDA.b $EB
	CLC
	ADC.w #$0020
	TAX
	SEP.b #$20
	LDA.w DATA_0F8793
	STA.l $7ED010,x
	LDA.w DATA_0F8793+$01
	STA.l $7ED011,x
	LDA.w DATA_0F8793+$02
	STA.l $7ED020,x
	LDA.w DATA_0F8793+$03
	STA.l $7ED021,x
	REP.b #$20
	JMP.w CODE_0F8084

;--------------------------------------------------------------------

DATA_0F87FF:
	dw $0000,$0000,$001F,$001F,$003D,$003D,$0044,$0044
	dw $0054,$0054,$006E,$0000,$00B3,$00B3,$0000,$0000

DATA_0F881F:
	dw $0000,$0000,$0000,$0000,$0000,$0004,$0018,$002C
	dw $0052,$0090

DATA_0F8833:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	dw $0000,$0039,$0046,$0097,$0118,$0179,$0182,$0195
	dw $01EA,$024F,$02E8,$0339,$035C,$03F5,$0424
else
	dw $0000,$0031,$003B,$0083,$00F5,$014B,$0152,$0162
	dw $01AC,$0206,$028D,$02D5,$02F2,$0379,$03A0
endif

;--------------------------------------------------------------------

DATA_0F8851:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	dw $00B4,$00BF,$00E1,$00E8,$00F4,$011E,$013E
else
	dw $009A,$00A7,$00C9,$00D0,$00DC,$0106,$0126
endif

CODE_0F885F:
	LDY.w DATA_0F8851
	LDA.b $EB
	TAX
	INX
	INX
	BRA.b CODE_0F88BF

CODE_0F8869:
	LDY.w DATA_0F8851+$02
	LDA.b $EB
	CLC
	ADC.w #$0012
	TAX
	BRA.b CODE_0F88BF

CODE_0F8875:
	LDY.w DATA_0F8851+$04
	LDA.b $EB
	CLC
	ADC.w #$0001
	TAX
	BRA.b CODE_0F88BF

CODE_0F8881:
	LDY.w DATA_0F8851+$06
	LDA.b $EB
	CLC
	ADC.w #$0011
	TAX
	BRA.b CODE_0F88BF

CODE_0F888D:
	LDY.w DATA_0F8851+$08
	LDA.b $EB
	CLC
	ADC.w #$0020
	TAX
	BRA.b CODE_0F88BF

CODE_0F8899:
	LDY.w DATA_0F8851+$0A
	LDX.b $EB
	INX
	BRA.b CODE_0F88BF

CODE_0F88A1:
	LDY.w DATA_0F8851+$0C
	LDA.b $EB
	CLC
	ADC.w #$0012
	TAX
	BRA.b CODE_0F88BF

CODE_0F88AD:
	INC.b $EB
CODE_0F88AF:
	LDA.b $EB
	CLC
	ADC.w #$0010
	TAX
	BRA.b CODE_0F88BC

CODE_0F88B8:
	INC.b $EB
CODE_0F88BA:
	LDX.b $EB
CODE_0F88BC:
	LDY.w #$0000
CODE_0F88BF:
	STX.b $E2
	SEP.b #$20
CODE_0F88C3:
	LDA.w DATA_0FB2EF,y
	CMP.b #$FF
	BEQ.b CODE_0F893B
	CMP.b #$FE
	BEQ.b CODE_0F8916
	JSR.w CODE_0F88E9
	STA.l $7ED000,x
	INY
	INX
	REP.b #$20
	TXA
	AND.w #$000F
	BNE.b CODE_0F88E5
	TXA
	CLC
	ADC.w #$00F0
	TAX
CODE_0F88E5:
	SEP.b #$20
	BRA.b CODE_0F88C3

CODE_0F88E9:
	STA.b $E4
	CMP.b #$12
	BNE.b CODE_0F88F2
	JMP.w CODE_0F8940

CODE_0F88F2:
	CMP.b #$03
	BNE.b CODE_0F88F9
	JMP.w CODE_0F896D

CODE_0F88F9:
	CMP.b #$04
	BNE.b CODE_0F8900
	JMP.w CODE_0F897A

CODE_0F8900:
	CMP.b #$05
	BNE.b CODE_0F8907
	JMP.w CODE_0F898F

CODE_0F8907:
	CMP.b #$18
	BNE.b CODE_0F890E
	JMP.w CODE_0F89A4

CODE_0F890E:
	CMP.b #$07
	BNE.b CODE_0F8915
	JMP.w CODE_0F89C1

CODE_0F8915:
	RTS

CODE_0F8916:
	INY
	REP.b #$20
	LDA.b $E2
	CLC
	ADC.w #$0010
	TAX
	AND.w #$00F0
	BEQ.b CODE_0F893B
	DEX
	TXA
	AND.w #$000F
	CMP.w #$000F
	BNE.b CODE_0F8935
	TXA
	SEC
	SBC.w #$00F0
	TAX
CODE_0F8935:
	STX.b $E2
	SEP.b #$20
	BRA.b CODE_0F88C3

CODE_0F893B:
	REP.b #$20
	JMP.w CODE_0F8084

CODE_0F8940:
	LDA.l $7ED000,x
	BEQ.b CODE_0F896A
	CMP.b #$18
	BNE.b CODE_0F894E
	LDA.b #$02
	BRA.b CODE_0F896C

CODE_0F894E:
	CMP.b #$06
	BNE.b CODE_0F8956
	LDA.b #$11
	BRA.b CODE_0F896C

CODE_0F8956:
	CMP.b #$16
	BNE.b CODE_0F895E
	LDA.b #$01
	BRA.b CODE_0F896C

CODE_0F895E:
	CMP.b #$05
	BNE.b CODE_0F8966
	LDA.b #$62
	BRA.b CODE_0F896C

CODE_0F8966:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	CMP.b #$1A
	BNE.b +
	LDA.b #$11
	BRA.b CODE_0F896C

+:
endif
	LDA.b #$10
	BRA.b CODE_0F896C

CODE_0F896A:
	LDA.b $E4
CODE_0F896C:
	RTS

CODE_0F896D:
	LDA.l $7ED000,x
	BEQ.b CODE_0F8977
	LDA.b #$36
	BRA.b CODE_0F8979

CODE_0F8977:
	LDA.b $E4
CODE_0F8979:
	RTS

CODE_0F897A:
	LDA.l $7ED000,x
	BEQ.b CODE_0F898C
	CMP.b #$12
	BNE.b CODE_0F8988
	LDA.b #$14
	BRA.b CODE_0F898E

CODE_0F8988:
	LDA.b #$37
	BRA.b CODE_0F898E

CODE_0F898C:
	LDA.b $E4
CODE_0F898E:
	RTS

CODE_0F898F:
	LDA.l $7ED000,x
	BEQ.b CODE_0F89A1
	CMP.b #$13
	BNE.b CODE_0F899D
	LDA.b #$15
	BRA.b CODE_0F89A3

CODE_0F899D:
	LDA.b #$38
	BRA.b CODE_0F89A3

CODE_0F89A1:
	LDA.b $E4
CODE_0F89A3:
	RTS

CODE_0F89A4:
	LDA.l $7ED000,x
	BEQ.b CODE_0F89BE
	CMP.b #$16
	BNE.b CODE_0F89B2
	LDA.b #$1E
	BRA.b CODE_0F89C0

CODE_0F89B2:
	CMP.b #$13
	BNE.b CODE_0F89BA
	LDA.b #$1E
	BRA.b CODE_0F89C0

CODE_0F89BA:
	LDA.b #$1D
	BRA.b CODE_0F89C0

CODE_0F89BE:
	LDA.b $E4
CODE_0F89C0:
	RTS

CODE_0F89C1:
	LDA.l $7ED000,x
	BEQ.b CODE_0F89E3
	CMP.b #$16
	BNE.b CODE_0F89CF
	LDA.b #$0E
	BRA.b CODE_0F89E5

CODE_0F89CF:
	CMP.b #$04
	BNE.b CODE_0F89D7
	LDA.b #$70
	BRA.b CODE_0F89E5

CODE_0F89D7:
	CMP.b #$0B
	BNE.b CODE_0F89DF
	LDA.b #$90
	BRA.b CODE_0F89E5

CODE_0F89DF:
	LDA.b #$49
	BRA.b CODE_0F89E5

CODE_0F89E3:
	LDA.b $E4
CODE_0F89E5:
	RTS

;--------------------------------------------------------------------

DATA_0F89E6:
	db $00,$00,$90,$91,$92,$93
	db $00,$00,$94,$95,$96,$97
	db $00,$00,$98,$99,$9A,$9B
	db $00,$9C,$9D,$9E,$9F,$A0
	db $00,$A1,$A2,$A3,$A4,$A5
	db $00,$A6,$A7,$A8,$A9,$AA

CODE_0F8A0A:
	SEP.b #$20
	LDX.b $EB
	LDY.w #$0000
CODE_0F8A11:
	PHX
	LDA.w DATA_0F89E6,y
	STA.l $7ED020,x
	JSR.w CODE_0F8A66
	LDA.w DATA_0F89E6+$01,y
	STA.l $7ED020,x
	JSR.w CODE_0F8A66
	LDA.w DATA_0F89E6+$02,y
	STA.l $7ED020,x
	JSR.w CODE_0F8A66
	LDA.w DATA_0F89E6+$03,y
	STA.l $7ED020,x
	JSR.w CODE_0F8A66
	LDA.w DATA_0F89E6+$04,y
	STA.l $7ED020,x
	JSR.w CODE_0F8A66
	LDA.w DATA_0F89E6+$05,y
	STA.l $7ED020,x
	PLX
	REP.b #$20
	TXA
	CLC
	ADC.w #$0010
	TAX
	SEP.b #$20
	INY
	INY
	INY
	INY
	INY
	INY
	CPY.w #$0024
	BNE.b CODE_0F8A11
	REP.b #$20
	JMP.w CODE_0F8084

;--------------------------------------------------------------------

CODE_0F8A66:
	REP.b #$20
	INX
	TXA
	AND.w #$000F
	BNE.b CODE_0F8A75
	TXA
	CLC
	ADC.w #$00F0
	TAX
CODE_0F8A75:
	SEP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_0F8A78:
	LDX.b $EB
	SEP.b #$20
CODE_0F8A7C:
	LDA.b #$09
	STA.l $7ED020,x
	LDA.b #$0B
	STA.l $7ED021,x
	INX
	INX
	DEC.b $F1
	LDA.b $F1
	BPL.b CODE_0F8A7C
	REP.b #$20
	JMP.w CODE_0F8084

;--------------------------------------------------------------------

CODE_0F8A95:
	LDX.b $EB
	SEP.b #$20
CODE_0F8A99:
	LDA.l $7ED020,x
	CMP.b #$09
	BNE.b CODE_0F8AA5
	LDA.b #$0A
	BRA.b CODE_0F8AA7

CODE_0F8AA5:
	LDA.b #$04
CODE_0F8AA7:
	STA.l $7ED020,x
	LDA.b #$01
	STA.l $7ED030,x
	REP.b #$20
	TXA
	CLC
	ADC.w #$0020
	TAX
	SEP.b #$20
	DEC.b $F1
	LDA.b $F1
	BPL.b CODE_0F8A99
	REP.b #$20
	JMP.w CODE_0F8084

;--------------------------------------------------------------------

CODE_0F8AC6:
	LDX.b $EB
	SEP.b #$20
CODE_0F8ACA:
	LDA.l $7ED021,x
	CMP.b #$0B
	BNE.b CODE_0F8AD6
	LDA.b #$0A
	BRA.b CODE_0F8AD8

CODE_0F8AD6:
	LDA.b #$04
CODE_0F8AD8:
	STA.l $7ED021,x
	LDA.b #$01
	STA.l $7ED031,x
	REP.b #$20
	TXA
	CLC
	ADC.w #$0020
	TAX
	SEP.b #$20
	DEC.b $F1
	LDA.b $F1
	BPL.b CODE_0F8ACA
	REP.b #$20
	JMP.w CODE_0F8084

;--------------------------------------------------------------------

DATA_0F8AF7:
	db $7A,$7B,$61,$62,$8C,$8D,$90,$91
	db $92

CODE_0F8B00:
	LDX.b $EB
	LDA.w #$0006
	STA.b $F1
	SEP.b #$20
	LDA.w DATA_0F8AF7
	STA.l $7ED020,x
	LDA.w DATA_0F8AF7+$01
	STA.l $7ED021,x
CODE_0F8B17:
	LDA.w DATA_0F8AF7+$02
	STA.l $7ED030,x
	LDA.w DATA_0F8AF7+$03
	STA.l $7ED031,x
	REP.b #$20
	TXA
	CLC
	ADC.w #$0010
	TAX
	SEP.b #$20
	DEC.b $F1
	LDA.b $F1
	BNE.b CODE_0F8B17
	LDA.w DATA_0F8AF7+$04
	STA.l $7ED030,x
	LDA.w DATA_0F8AF7+$05
	STA.l $7ED031,x
	LDA.w DATA_0F8AF7+$06
	STA.l $7ED040,x
	LDA.w DATA_0F8AF7+$07
	STA.l $7ED041,x
	LDA.w DATA_0F8AF7+$08
	STA.l $7ED042,x
	REP.b #$20
	JMP.w CODE_0F8084

;--------------------------------------------------------------------

DATA_0F8B5D:
	db $70,$71,$72,$73
	db $74,$75,$76,$77
	db $78,$79,$7A,$7B
	db $00,$7C,$7D,$00

CODE_0F8B6D:
	LDX.b $EB
	INX
	SEP.b #$20
	STZ.b $E5
	LDY.w #$0000
CODE_0F8B77:
	LDA.w DATA_0F8B5D,y
	STA.l $7ED000,x
	LDA.w DATA_0F8B5D+$01,y
	STA.l $7ED001,x
	LDA.w DATA_0F8B5D+$02,y
	STA.l $7ED002,x
	LDA.w DATA_0F8B5D+$03,y
	STA.l $7ED003,x
	INY
	INY
	INY
	INY
	INX
	INX
	INX
	INX
	REP.b #$20
	TXA
	CLC
	ADC.w #$000C
	TAX
	SEP.b #$20
	INC.b $E5
	LDA.b $E5
	CMP.b #$04
	BNE.b CODE_0F8B77
	REP.b #$20
	JMP.w CODE_0F8084

;--------------------------------------------------------------------

DATA_0F8BB2:
	db $2F,$30
	db $31,$32
	db $35,$36
	db $3A,$3B

CODE_0F8BBA:
	SEP.b #$20
	LDY.w #$0000
	LDX.b $EB
CODE_0F8BC1:
	LDA.w DATA_0F8BB2,y
	STA.l $7ED020,x
	LDA.w DATA_0F8BB2+$01,y
	STA.l $7ED021,x
	REP.b #$20
	TXA
	CLC
	ADC.w #$0010
	TAX
	SEP.b #$20
	INY
	INY
	CPY.w #$0008
	BNE.b CODE_0F8BC1
	REP.b #$20
	JMP.w CODE_0F8084

;--------------------------------------------------------------------

DATA_0F8BE5:
	db $01,$1F

DATA_0F8BE7:
	db $02,$20

CODE_0F8BE9:
	SEP.b #$20
	LDX.b $EB
	LDY.b $EF
CODE_0F8BEF:
	LDA.w DATA_0F8BE5,y
	STA.l $7ED020,x
	LDA.w DATA_0F8BE7,y
	STA.l $7ED021,x
	REP.b #$20
	TXA
	CLC
	ADC.w #$0010
	TAX
	SEP.b #$20
	DEC.b $F1
	LDA.b $F1
	BPL.b CODE_0F8BEF
	REP.b #$20
	JMP.w CODE_0F8084

;--------------------------------------------------------------------

DATA_0F8C12:
	db $08,$09,$05,$06,$07,$05,$03,$04
	db $05,$0F,$10,$11,$16,$17,$12,$1D
	db $09,$1E,$06,$07,$05

CODE_0F8C27:
	SEP.b #$20
	LDX.b $EB
CODE_0F8C2B:
	TXA
	AND.b #$F0
	BEQ.b CODE_0F8C4F
	LDA.l $7ED020,x
	CMP.b #$0C
	BEQ.b CODE_0F8C7B
	LDA.w DATA_0F8C12
	STA.l $7ED020,x
	LDA.w DATA_0F8C12+$01
	STA.l $7ED021,x
	LDA.w DATA_0F8C12+$02
	STA.l $7ED022,x
	BRA.b CODE_0F8C64

CODE_0F8C4F:
	LDA.w DATA_0F8C12+$06
	STA.l $7ED020,x
	LDA.w DATA_0F8C12+$07
	STA.l $7ED021,x
	LDA.w DATA_0F8C12+$08
	STA.l $7ED022,x
CODE_0F8C64:
	LDA.w DATA_0F8C12+$03
	STA.l $7ED030,x
	LDA.w DATA_0F8C12+$04
	STA.l $7ED031,x
	LDA.w DATA_0F8C12+$05
	STA.l $7ED032,x
	BRA.b CODE_0F8CDB

CODE_0F8C7B:
	LDA.w DATA_0F8C12+$09
	STA.l $7ED020,x
	LDA.w DATA_0F8C12+$0A
	STA.l $7ED021,x
	LDA.w DATA_0F8C12+$0B
	STA.l $7ED022,x
	LDA.w DATA_0F8C12+$0C
	STA.l $7ED030,x
	LDA.w DATA_0F8C12+$0D
	STA.l $7ED031,x
	LDA.w DATA_0F8C12+$0E
	STA.l $7ED032,x
	LDA.w DATA_0F8C12+$0F
	STA.l $7ED040,x
	LDA.w DATA_0F8C12+$10
	STA.l $7ED041,x
	LDA.w DATA_0F8C12+$11
	STA.l $7ED042,x
	LDA.w DATA_0F8C12+$12
	STA.l $7ED050,x
	LDA.w DATA_0F8C12+$13
	STA.l $7ED051,x
	LDA.w DATA_0F8C12+$14
	STA.l $7ED052,x
	REP.b #$20
	TXA
	CLC
	ADC.w #$0020
	TAX
	SEP.b #$20
	DEC.b $F1
CODE_0F8CDB:
	REP.b #$20
	TXA
	CLC
	ADC.w #$0020
	TAX
	SEP.b #$20
	DEC.b $F1
	LDA.b $F1
	BMI.b CODE_0F8CEE
	JMP.w CODE_0F8C2B

CODE_0F8CEE:
	REP.b #$20
	JMP.w CODE_0F8084

;--------------------------------------------------------------------

DATA_0F8CF3:
	db $0C,$18,$19,$0A,$0B,$0D,$0E,$13
	db $14,$1A,$1B

CODE_0F8CFE:
	SEP.b #$20
	LDX.b $EB
CODE_0F8D02:
	LDA.l $7ED020,x
	CMP.b #$1F
	BNE.b CODE_0F8D47
	LDA.w DATA_0F8CF3+$03
	STA.l $7ED010,x
	LDA.w DATA_0F8CF3+$04
	STA.l $7ED011,x
	LDA.w DATA_0F8CF3+$05
	STA.l $7ED020,x
	LDA.w DATA_0F8CF3+$06
	STA.l $7ED021,x
	LDA.w DATA_0F8CF3+$07
	STA.l $7ED030,x
	LDA.w DATA_0F8CF3+$08
	STA.l $7ED031,x
	LDA.w DATA_0F8CF3+$09
	STA.l $7ED040,x
	LDA.w DATA_0F8CF3+$0A
	STA.l $7ED041,x
	INX
	DEC.b $F1
	BRA.b CODE_0F8D5C

CODE_0F8D47:
	LDA.w DATA_0F8CF3
	STA.l $7ED020,x
	LDA.w DATA_0F8CF3+$01
	STA.l $7ED030,x
	LDA.w DATA_0F8CF3+$02
	STA.l $7ED040,x
CODE_0F8D5C:
	INX
	DEC.b $F1
	LDA.b $F1
	BPL.b CODE_0F8D02
	REP.b #$20
	JMP.w CODE_0F8084

;--------------------------------------------------------------------

DATA_0F8D68:
	db $33,$34,$0D,$37,$13,$3C,$1A,$1B
	db $33,$34,$38,$39,$3D,$3E,$40,$1B

CODE_0F8D78:
	LDX.b $EB
	SEP.b #$20
	LDA.l $7ED020,x
	CMP.b #$0C
	BEQ.b CODE_0F8DBE
	LDA.w DATA_0F8D68+$08
	STA.l $7ED010,x
	LDA.w DATA_0F8D68+$09
	STA.l $7ED011,x
	LDA.w DATA_0F8D68+$0A
	STA.l $7ED020,x
	LDA.w DATA_0F8D68+$0B
	STA.l $7ED021,x
	LDA.w DATA_0F8D68+$0C
	STA.l $7ED030,x
	LDA.w DATA_0F8D68+$0D
	STA.l $7ED031,x
	LDA.w DATA_0F8D68+$0E
	STA.l $7ED040,x
	LDA.w DATA_0F8D68+$0F
	STA.l $7ED041,x
	BRA.b CODE_0F8DF6

CODE_0F8DBE:
	LDA.w DATA_0F8D68
	STA.l $7ED010,x
	LDA.w DATA_0F8D68+$01
	STA.l $7ED011,x
	LDA.w DATA_0F8D68+$02
	STA.l $7ED020,x
	LDA.w DATA_0F8D68+$03
	STA.l $7ED021,x
	LDA.w DATA_0F8D68+$04
	STA.l $7ED030,x
	LDA.w DATA_0F8D68+$05
	STA.l $7ED031,x
	LDA.w DATA_0F8D68+$06
	STA.l $7ED040,x
	LDA.w DATA_0F8D68+$07
	STA.l $7ED041,x
CODE_0F8DF6:
	REP.b #$20
	DEC.b $F1
	DEC.b $F1
	DEC.b $F1
	LDA.b $EB
	CLC
	ADC.w #$0030
	STA.b $EB
	LDA.w #$0001
	STA.b $EF
	JMP.w CODE_0F8BE9

;--------------------------------------------------------------------

DATA_0F8E0E:
	db $41,$42,$43,$44
	db $45,$46,$47,$48
	db $49,$4A,$4B,$4C
	db $4D,$4E,$4F,$50
	db $51,$52,$53,$54

CODE_0F8E22:
	SEP.b #$20
	LDX.b $EB
	LDY.w #$0000
CODE_0F8E29:
	LDA.w DATA_0F8E0E,y
	STA.l $7ED020,x
	LDA.w DATA_0F8E0E+$01,y
	STA.l $7ED021,x
	LDA.w DATA_0F8E0E+$02,y
	STA.l $7ED022,x
	LDA.w DATA_0F8E0E+$03,y
	STA.l $7ED023,x
	REP.b #$20
	TXA
	CLC
	ADC.w #$0010
	TAX
	SEP.b #$20
	INY
	INY
	INY
	INY
	CPY.w #$0014
	BNE.b CODE_0F8E29
	REP.b #$20
	JMP.w CODE_0F8084

;--------------------------------------------------------------------

CODE_0F8E5D:
	LDX.b $EB
	LDA.w #$1B1A
	STA.l $7ED000,x
	JMP.w CODE_0F8084

;--------------------------------------------------------------------

CODE_0F8E69:
	INC.b $EB
CODE_0F8E6B:
	LDA.b $EB
	CLC
	ADC.w #$0010
	TAX
	SEP.b #$20
	LDA.b #$67
	STA.l $7ED000,x
	LDA.b #$69
	STA.l $7ED001,x
	LDA.b #$68
	STA.l $7ED010,x
	LDA.b #$6A
	STA.l $7ED011,x
	REP.b #$20
	JMP.w CODE_0F8084

;--------------------------------------------------------------------

DATA_0F8E91:
	dw DATA_0F8E99
	dw DATA_0F8EE1
	dw DATA_0F8EED
	dw DATA_0F8F1D

DATA_0F8E99:
	db $08,$09,$0D,$0E,$08,$23,$0D,$25,$24,$23,$26,$25,$24,$09,$26,$0E
	db $00,$08,$00,$0D,$23,$24,$25,$26,$0F,$10,$32,$33,$11,$12,$32,$33
	db $13,$00,$3C,$3B,$30,$31,$32,$33,$30,$10,$32,$33,$00,$36,$38,$37
	db $0F,$31,$32,$33,$35,$10,$39,$33,$0F,$10,$32,$33,$35,$12,$32,$33
	db $23,$24,$25,$26,$11,$12,$32,$33

DATA_0F8EE1:
	db $21,$22,$25,$26,$23,$24,$27,$28,$00,$00,$26,$00

DATA_0F8EED:
	db $06,$05,$07,$02,$0E,$05,$11,$12,$0E,$05,$07,$08,$06,$05,$07,$08
	db $03,$05,$0C,$0D,$0F,$10,$1D,$02,$03,$05,$1D,$15,$03,$18,$1B,$1B
	db $03,$05,$16,$15,$19,$18,$1B,$1B,$03,$05,$16,$17,$19,$1A,$1B,$1B

DATA_0F8F1D:
CODE_0F8F1D:
	LDA.b $5C
	AND.w #$00FF
	ASL
	TAX
	LDA.w #(DATA_0F8E99>>8)&$00FF00
	STA.b $D9
	LDA.w DATA_0F8E91,x
	STA.b $D8
	LDA.b $5C
	AND.w #$00FF
	CMP.w #$0002
	BCS.b CODE_0F8F41
	LDA.b $EB
	CLC
	ADC.w #$0010
	TAX
	BRA.b CODE_0F8F43

CODE_0F8F41:
	LDX.b $EB
CODE_0F8F43:
	LDA.b $EF
	SEC
	SBC.w #$0010
	ASL
	ASL
	TAY
	SEP.b #$20
	LDA.b [$D8],y
	STA.l $7ED020,x
	INY
	LDA.b [$D8],y
	STA.l $7ED021,x
	INY
	LDA.b [$D8],y
	STA.l $7ED030,x
	INY
	LDA.b [$D8],y
	STA.l $7ED031,x
	REP.b #$20
	INX
	INX
	DEC.b $F1
	LDA.b $F1
	BPL.b CODE_0F8F43
	RTS

;--------------------------------------------------------------------

CODE_0F8F74:
	STA.l $7ED000,x
	STA.l $7ED100,x
	STA.l $7ED200,x
	STA.l $7ED300,x
	STA.l $7ED400,x
	STA.l $7ED500,x
	STA.l $7ED600,x
	STA.l $7ED700,x
	STA.l $7ED800,x
	STA.l $7ED900,x
	STA.l $7EDA00,x
	STA.l $7EDB00,x
	STA.l $7EDC00,x
	STA.l $7EDD00,x
	STA.l $7EDE00,x
	STA.l $7EDF00,x
	RTS

;--------------------------------------------------------------------

CODE_0F8FB5:
	LDA.b $EF
	ASL
	TAX
	LDA.w DATA_0F8FC1,x
	STA.b $00
	JMP.w ($0000)

DATA_0F8FC1:
	dw CODE_0F9152
	dw CODE_0F9156
	dw CODE_0F917F
	dw CODE_0F9196
	dw CODE_0F91BA
	dw CODE_0F9135
	dw CODE_0F90FB
	dw CODE_0F90D9
	dw CODE_0F90A0
	dw CODE_0F9096
	dw CODE_0F9033
	dw CODE_0F91C3
	dw CODE_0F900B

;--------------------------------------------------------------------

DATA_0F8FDB:
	db $0C,$0D,$0E,$0F,$0C,$0D,$0E,$0F
	db $0C,$0D,$0E,$0F,$0C,$0D,$0E,$0F
	db $13,$14,$15,$16,$13,$14,$15,$16
	db $13,$14,$15,$16,$13,$14,$15,$16
	db $1A,$1A,$1A,$1A,$1A,$1A,$1A,$1A
	db $1A,$1A,$1A,$1A,$1A,$1A,$1A,$1A

CODE_0F900B:
	LDX.w #$00D0
	LDY.w #$0000
	SEP.b #$20
CODE_0F9013:
	LDA.w DATA_0F8FDB,y
	JSR.w CODE_0F8F74
	INX
	INY
	CPY.w #$0030
	BNE.b CODE_0F9013
	REP.b #$20
	RTS

;--------------------------------------------------------------------

DATA_0F9023:
	db $01,$02,$03,$07,$01,$02,$03,$07
	db $01,$02,$03,$07,$01,$02,$03,$07

CODE_0F9033:
	STZ.b $E4
CODE_0F9035:
	LDA.b $E4
	AND.w #$00FF
	XBA
	CLC
	ADC.w #$00A0
	TAX
	LDY.w #$0000
	SEP.b #$20
CODE_0F9045:
	LDA.w DATA_0F9023,y
	STA.l $7ED000,x
	TXA
	AND.b #$01
	BNE.b CODE_0F906B
	LDA.b #$0C
	STA.l $7ED010,x
	STA.l $7ED030,x
	STA.l $7ED050,x
	LDA.b #$10
	STA.l $7ED020,x
	STA.l $7ED040,x
	BRA.b CODE_0F9083

CODE_0F906B:
	LDA.b #$0D
	STA.l $7ED010,x
	STA.l $7ED030,x
	STA.l $7ED050,x
	LDA.b #$11
	STA.l $7ED020,x
	STA.l $7ED040,x
CODE_0F9083:
	INX
	INY
	TYA
	AND.b #$0F
	BNE.b CODE_0F9045
	REP.b #$20
	INC.b $E4
	LDA.b $E4
	CMP.w #$0008
	BNE.b CODE_0F9035
	RTS

;--------------------------------------------------------------------

CODE_0F9096:
	SEP.b #$20
	LDA.b $F1
	STA.w $0EDC
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_0F90A0:
	LDX.w #$0080
CODE_0F90A3:
	LDA.w #$0403
	STA.l $7ED000,x
	LDA.w #$0909
	STA.l $7ED010,x
	STA.l $7ED020,x
	STA.l $7ED030,x
	STA.l $7ED040,x
	STA.l $7ED050,x
	STA.l $7ED060,x
	INX
	INX
	TXA
	AND.w #$000F
	BNE.b CODE_0F90A3
	TXA
	CLC
	ADC.w #$00F0
	TAX
	CPX.w #$1000
	BCC.b CODE_0F90A3
	RTS

;--------------------------------------------------------------------

CODE_0F90D9:
	LDX.w #$0000
	LDA.w #$0202
CODE_0F90DF:
	JSR.w CODE_0F8F74
	INX
	INX
	CPX.w #$0020
	BNE.b CODE_0F90DF
	LDA.w #$0101
CODE_0F90EC:
	JSR.w CODE_0F8F74
	INX
	INX
	CPX.w #$0030
	BNE.b CODE_0F90EC
	RTS

;--------------------------------------------------------------------

DATA_0F90F7:
	db $03,$05,$1D,$02

CODE_0F90FB:
	LDX.w #$0000
	SEP.b #$20
CODE_0F9100:
	LDA.w DATA_0F90F7
	STA.l $7ED000,x
	LDA.w DATA_0F90F7+$01
	STA.l $7ED001,x
	LDA.w DATA_0F90F7+$02
	STA.l $7ED010,x
	LDA.w DATA_0F90F7+$03
	STA.l $7ED011,x
	INX
	INX
	TXA
	AND.b #$0F
	BNE.b CODE_0F9100
	REP.b #$20
	TXA
	CLC
	ADC.w #$0010
	TAX
	SEP.b #$20
	CPX.w #$0800
	BNE.b CODE_0F9100
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_0F9135:
	SEP.b #$20
	LDA.b $5C
	CMP.b #$02
	BEQ.b CODE_0F9141
	LDA.b #$5F
	BRA.b CODE_0F9143

CODE_0F9141:
	LDA.b #$00
CODE_0F9143:
	LDX.w #$0000
CODE_0F9146:
	JSR.w CODE_0F8F74
	INX
	CPX.w #$0020
	BNE.b CODE_0F9146
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_0F9152:
	INC.w $0EC0
	RTS

;--------------------------------------------------------------------

CODE_0F9156:
	SEP.b #$30
	LDA.w $075F
	CMP.b #$01
	BNE.b CODE_0F9169
	LDA.b $5C
	CMP.b #$02
	BEQ.b CODE_0F9169
	LDA.b #$01
	BRA.b CODE_0F9171

CODE_0F9169:
	LDA.b $F1
	CMP.b #$02
	BNE.b CODE_0F9171
	LDA.b #$FF
CODE_0F9171:
	CMP.b #$01
	BNE.b CODE_0F9178
	STA.w $0ED1
CODE_0F9178:
	JSL.l SMB1_InitializeGradientHDMA_Main				; Note: Call to SMB1 function
	REP.b #$30
	RTS

;--------------------------------------------------------------------

CODE_0F917F:
	SEP.b #$30
	LDA.b #$02
	JSL.l SMB1_InitializeGradientHDMA_Main				; Note: Call to SMB1 function
	REP.b #$30
	RTS

;--------------------------------------------------------------------

DATA_0F918A:
	db $0F,$20,$1B,$37,$58,$C9

DATA_0F9190:
	db $1F,$29,$1C,$38,$57,$CA

CODE_0F9196:
	LDX.w #$00D0
	LDY.b $F1
	LDA.w DATA_0F918A,y
CODE_0F919E:
	JSR.w CODE_0F8F74
	INX
	CPX.w #$00E0
	BNE.b CODE_0F919E
	LDA.w DATA_0F9190,y
CODE_0F91AA:
	JSR.w CODE_0F8F74
	INX
	CPX.w #$00F0
	BNE.b CODE_0F91AA
	LDA.w #$0050
	JSR.w CODE_0F8F74
	RTS

;--------------------------------------------------------------------

CODE_0F91BA:
	LDA.b $F1
	STA.b $99
	JSL.l CODE_0FF078
	RTS

;--------------------------------------------------------------------

CODE_0F91C3:
	LDA.b $F1
	ORA.w #$0010
	STA.b $99
	JSL.l CODE_0FF078
	RTS

;--------------------------------------------------------------------

CODE_0F91CF:
	LDA.b $DB
	ASL
	TAX
	LDA.w DATA_0F923C,x
	ASL
	TAX
	LDA.w DATA_0F92CC,x
	STA.b $00
	LDA.w #DATA_0F9B2A>>16
	STA.b $02
	LDX.w #$0000
	LDY.w #$0000
CODE_0F91E8:
	STX.b $E4
	TYX
	LDA.l $7ED000,x
	CMP.w #$FFFF
	BEQ.b CODE_0F9233
	PHY
	LDX.b $E4
	AND.w #$00FF
	ASL
	ASL
	ASL
	TAY
	LDA.b [$00],y
	STA.l $7E2000,x
	INY
	INY
	LDA.b [$00],y
	STA.l $7E2002,x
	INY
	INY
	LDA.b [$00],y
	STA.l $7E2040,x
	INY
	INY
	LDA.b [$00],y
	STA.l $7E2042,x
	PLY
	INY
	TYA
	AND.w #$000F
	BNE.b CODE_0F922A
	TXA
	CLC
	ADC.w #$0040
	TAX
CODE_0F922A:
	INX
	INX
	INX
	INX
	CPY.w #$1200
	BNE.b CODE_0F91E8
CODE_0F9233:
	SEP.b #$30
	PLB
	LDA.w $0F35
	STA.b $DB
	RTL

DATA_0F923C:
	db $03,$00,$03,$00,$03,$00,$03,$00,$03,$00,$03,$00,$03,$00,$05,$00
	db $01,$00,$01,$00,$03,$00,$03,$00,$03,$00,$05,$00,$01,$00,$08,$00
	db $04,$00,$04,$00,$04,$00,$01,$00,$08,$00,$01,$00,$01,$00,$01,$00
	db $08,$00,$01,$00,$08,$00,$01,$00,$0A,$00,$04,$00,$04,$00,$04,$00
	db $01,$00,$01,$00,$08,$00,$01,$00,$07,$00,$01,$00,$01,$00,$01,$00
	db $01,$00,$01,$00,$01,$00,$01,$00,$0A,$00,$01,$00,$08,$00,$04,$00
	db $04,$00,$04,$00,$01,$00,$01,$00,$06,$00,$01,$00,$01,$00,$02,$00
	db $02,$00,$01,$00,$02,$00,$01,$00,$02,$00,$01,$00,$00,$00,$00,$00
	db $00,$00,$09,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$00

DATA_0F92CC:
	dw DATA_0F9B2A
	dw DATA_0F9D2A
	dw DATA_0FAD12
	dw DATA_0FA712
	dw DATA_0FA462
	dw DATA_0F982A
	dw DATA_0F9662
	dw DATA_0F95EA
	dw DATA_0F954A
	dw DATA_0FA5C2
	dw DATA_0F93A2

;--------------------------------------------------------------------

DATA_0F92E2:
	db $00,$00,$00,$11
	db $00,$00,$00,$1F
	db $00,$00,$00,$0C
	db $00,$12,$00,$00
	db $08,$00,$00,$00
	db $00,$00,$04,$00
	db $10,$00,$00,$00
	db $0D,$00,$00,$00
	db $00,$00,$0A,$00
	db $1E,$00,$00,$00
	db $00,$00,$1F,$00
	db $17,$00,$00,$00
	db $00,$00,$00,$19
	db $12,$0C,$00,$00
	db $1B,$00,$00,$00
	db $00,$12,$00,$00
	db $00,$00,$00,$09
	db $00,$2A,$00,$00
	db $00,$00,$16,$00
	db $00,$00,$1B,$00
	db $00,$00,$00,$16
	db $08,$00,$00,$00
	db $00,$17,$00,$00
	db $00,$19,$00,$00
	db $00,$00,$0F,$00
	db $00,$14,$00,$00
	db $00,$1B,$00,$00
	db $11,$00,$00,$00
	db $00,$06,$00,$00
	db $0D,$00,$00,$00
	db $00,$07,$00,$00
	db $00,$00,$00,$12
	db $00,$08,$00,$00
	db $00,$00,$12,$00
	db $00,$0C,$00,$00
	db $16,$00,$00,$00
	db $00,$12,$00,$00
	db $00,$00,$00,$04
	db $00,$13,$00,$00
	db $19,$00,$00,$00
	db $00,$17,$00,$00
	db $00,$00,$1B,$00
	db $00,$00,$00,$16
	db $1C,$00,$00,$00
	db $00,$00,$1E,$00
	db $00,$15,$00,$00
	db $00,$00,$02,$00
	db $01,$00,$00,$00

;--------------------------------------------------------------------

DATA_0F93A2:
	db $24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$E0,$1D,$24,$00,$F0,$1D
	db $E1,$1D,$24,$00,$F0,$5D,$24,$00,$C2,$1D,$C3,$1D,$D2,$1D,$D3,$1D
	db $C4,$1D,$C5,$1D,$D4,$1D,$D5,$1D,$24,$00,$E3,$1D,$24,$00,$F3,$1D
	db $E4,$1D,$24,$00,$F4,$1D,$24,$00,$CA,$1D,$CB,$1D,$F1,$1D,$F1,$5D
	db $C0,$1D,$C1,$1D,$24,$00,$E2,$1D,$D0,$1D,$D1,$1D,$F2,$1D,$24,$00
	db $C6,$1D,$C7,$1D,$D6,$1D,$D7,$1D,$E6,$1D,$E7,$1D,$F6,$1D,$F7,$1D
	db $EB,$1D,$EC,$1D,$FB,$1D,$FC,$1D,$ED,$1D,$24,$00,$FD,$1D,$FE,$1D
	db $24,$00,$24,$00,$FF,$1D,$F8,$1D,$24,$00,$EA,$1D,$F9,$1D,$FA,$1D
	db $C8,$1D,$C1,$1D,$FD,$1D,$E2,$1D,$D0,$1D,$D1,$1D,$F2,$1D,$F8,$1D
	db $E5,$1D,$F5,$1D,$D9,$1D,$DA,$1D,$CE,$1D,$CF,$1D,$EF,$1D,$EF,$1D
	db $DC,$1D,$DD,$1D,$EF,$1D,$EF,$1D,$DE,$1D,$DF,$1D,$EF,$1D,$EF,$1D
	db $CC,$1D,$CD,$1D,$EF,$1D,$EF,$1D,$DC,$1D,$E3,$1D,$EF,$1D,$F3,$1D
	db $E4,$1D,$DF,$1D,$F4,$1D,$EF,$1D,$E8,$1D,$E9,$1D,$DB,$1D,$EE,$1D
	db $EF,$1D,$EF,$1D,$EF,$1D,$EF,$1D,$C9,$1D,$C1,$1D,$EF,$1D,$E2,$1D
	db $D0,$1D,$D8,$1D,$F2,$1D,$EF,$1D,$E6,$1D,$E7,$1D,$D9,$1D,$DA,$1D
	db $24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$E0,$15,$24,$00,$F0,$15
	db $E1,$15,$24,$00,$F0,$55,$24,$00,$C2,$15,$C3,$15,$D2,$15,$D3,$15
	db $C4,$15,$C5,$15,$D4,$15,$D5,$15,$24,$00,$E3,$15,$24,$00,$F3,$15
	db $E4,$15,$24,$00,$F4,$15,$24,$00,$C0,$15,$C1,$15,$24,$00,$E2,$15
	db $D0,$15,$D1,$15,$F2,$15,$24,$00,$C2,$15,$C3,$15,$24,$00,$D3,$15
	db $C4,$15,$C5,$15,$D4,$15,$24,$00,$CA,$15,$CB,$15,$F1,$15,$F1,$55
	db $C6,$15,$C7,$15,$D6,$15,$D7,$15,$C8,$15,$C1,$15,$FD,$15,$E2,$15
	db $D0,$15,$D1,$15,$F2,$15,$F8,$15,$E6,$15,$E7,$15,$D9,$15,$DA,$15
	db $DC,$15,$E3,$15,$EF,$15,$F3,$15,$E4,$15,$DF,$15,$F4,$15,$EF,$15
	db $E8,$15,$E9,$15,$DB,$15,$EE,$15,$C9,$15,$C1,$15,$EF,$15,$E2,$15
	db $D0,$15,$D8,$15,$F2,$15,$EF,$15,$E6,$15,$E7,$15,$F6,$15,$F7,$15
	db $E5,$15,$F5,$15,$D9,$15,$DA,$15

DATA_0F954A:
	db $24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$D0,$1D,$D1,$1D
	db $24,$00,$24,$00,$D2,$1D,$D3,$1D,$24,$00,$C5,$1D,$D4,$1D,$D5,$1D
	db $24,$00,$24,$00,$C1,$1D,$C2,$1D,$24,$00,$24,$00,$FE,$1D,$FF,$1D
	db $24,$00,$24,$00,$C0,$1D,$D1,$1D,$C6,$1D,$C7,$1D,$D6,$1D,$D7,$1D
	db $24,$00,$24,$00,$D2,$1D,$C3,$1D,$24,$00,$24,$00,$CA,$1C,$CB,$1C
	db $C6,$1D,$C7,$1D,$C4,$1D,$D7,$1D,$24,$00,$24,$00,$FF,$1D,$FE,$1D
	db $E8,$1D,$E9,$1D,$F8,$1D,$F9,$1D,$EA,$1D,$EB,$1D,$FA,$1D,$FB,$1D
	db $E0,$1D,$E1,$1D,$F0,$1D,$F1,$1D,$E4,$1D,$E5,$1D,$F4,$1D,$F5,$1D
	db $C8,$1D,$C9,$1D,$D8,$1D,$D9,$1D,$CA,$1D,$CB,$1D,$DA,$1D,$DB,$1D
	db $E2,$1D,$E3,$1D,$F2,$1D,$F3,$1D,$E6,$1D,$E7,$1D,$F6,$1D,$F7,$1D

DATA_0F95EA:
	db $24,$00,$24,$00,$24,$00,$24,$00,$C4,$1D,$C5,$1D,$D4,$1D,$D5,$1D
	db $C0,$1D,$C1,$1D,$D0,$1D,$D1,$1D,$C6,$1D,$C7,$1D,$D6,$1D,$D7,$1D
	db $C8,$1D,$C9,$1D,$D8,$1D,$D9,$1D,$D2,$1D,$D3,$1D,$C2,$1D,$C3,$1D
	db $C2,$1D,$C3,$1D,$C2,$1D,$C3,$1D,$CA,$1D,$CB,$1D,$DA,$1D,$DB,$1D
	db $CC,$1D,$CD,$1D,$DC,$1D,$DD,$1D,$CE,$1D,$CF,$1D,$DE,$1D,$DF,$1D
	db $F2,$1D,$F3,$1D,$E2,$1D,$E3,$1D,$E4,$1D,$E5,$1D,$F4,$1D,$F5,$1D
	db $E2,$1D,$E3,$1D,$E2,$1D,$E3,$1D,$E6,$1D,$E7,$1D,$F6,$1D,$F7,$1D
	db $E0,$1D,$E1,$1D,$F0,$1D,$F1,$1D

DATA_0F9662:
	db $24,$00,$24,$00,$24,$00,$24,$00,$C0,$1D,$C1,$1D,$CA,$1D,$D1,$1D
	db $C2,$1D,$C3,$1D,$D2,$1D,$CB,$1D,$C2,$1D,$C3,$1D,$D2,$1D,$D3,$1D
	db $C0,$1D,$C1,$1D,$D0,$1D,$D1,$1D,$DA,$1D,$E1,$1D,$D0,$1D,$D1,$1D
	db $E2,$1D,$DB,$1D,$D2,$1D,$D3,$1D,$DA,$1D,$E1,$1D,$CA,$1D,$D1,$1D
	db $E2,$1D,$E1,$1D,$E4,$1D,$E5,$1D,$E2,$1D,$E1,$1D,$D2,$1D,$D1,$1D
	db $E2,$1D,$DB,$1D,$D2,$1D,$CB,$1D,$DA,$1D,$E1,$1D,$EA,$1D,$D1,$1D
	db $F4,$1D,$F5,$1D,$D8,$1D,$E8,$1D,$E2,$1D,$DB,$1D,$D2,$1D,$EB,$1D
	db $C0,$1D,$C1,$1D,$92,$1D,$D1,$1D,$E2,$1D,$E3,$1D,$D2,$1D,$D1,$1D
	db $24,$00,$24,$00,$24,$00,$24,$00,$FA,$1D,$E1,$1D,$CC,$1D,$D1,$1D
	db $E2,$1D,$FB,$1D,$D2,$1D,$CD,$1D,$A2,$1D,$E1,$1D,$B2,$1D,$D1,$1D
	db $E2,$1D,$E1,$1D,$D2,$1D,$C6,$1D,$C4,$1D,$C5,$1D,$C7,$1D,$E7,$1D
	db $D4,$1D,$D5,$1D,$E7,$1D,$C8,$1D,$E2,$1D,$E3,$1D,$C9,$1D,$D1,$1D
	db $E2,$1D,$E1,$1D,$D2,$1D,$82,$1D,$E2,$1D,$E1,$1D,$83,$1D,$84,$1D
	db $E2,$1D,$E1,$1D,$85,$1D,$80,$1D,$E2,$1D,$E1,$1D,$81,$1D,$D1,$1D
	db $E2,$1D,$E1,$1D,$C9,$1D,$D1,$1D,$E2,$1D,$D6,$1D,$D2,$1D,$E6,$1D
	db $D7,$1D,$E7,$1D,$D7,$1D,$E7,$1D,$E7,$1D,$D7,$5D,$E7,$1D,$D7,$5D
	db $D9,$1D,$E3,$1D,$E9,$1D,$D1,$1D,$E2,$1D,$DC,$1D,$D2,$1D,$EC,$1D
	db $DD,$1D,$DE,$1D,$ED,$1D,$EE,$1D,$DF,$1D,$90,$1D,$EF,$1D,$A0,$1D
	db $91,$1D,$E1,$1D,$A1,$1D,$D1,$1D,$A2,$1D,$E3,$1D,$B2,$1D,$D1,$1D
	db $D9,$1D,$E1,$1D,$E9,$1D,$D1,$1D,$E2,$1D,$E1,$1D,$F0,$1D,$F1,$1D
	db $E2,$1D,$E1,$1D,$F2,$1D,$F3,$1D,$E2,$1D,$F6,$1D,$F0,$1D,$F1,$1D
	db $F7,$1D,$CE,$1D,$F2,$1D,$F3,$1D,$CF,$1D,$F8,$1D,$F0,$1D,$F1,$1D
	db $F9,$1D,$E1,$1D,$F2,$1D,$F3,$1D,$E2,$1D,$E3,$1D,$F0,$1D,$F1,$1D
	db $FA,$1D,$E1,$1D,$F2,$1D,$F3,$1D,$E2,$1D,$FC,$1D,$F0,$1D,$F1,$1D
	db $FD,$1D,$FE,$1D,$F2,$1D,$F3,$1D,$FF,$1D,$B0,$1D,$F0,$1D,$F1,$1D
	db $B1,$1D,$E1,$1D,$F2,$1D,$F3,$1D,$E2,$1D,$FB,$1D,$F0,$1D,$F1,$1D
	db $A2,$1D,$E1,$1D,$F2,$1D,$F3,$1D,$E2,$1D,$CB,$1D,$D2,$1D,$D3,$1D
	db $CA,$1D,$E1,$1D,$D0,$1D,$D1,$1D,$86,$15,$86,$15,$87,$15,$87,$15
	db $88,$15,$88,$15,$88,$15,$88,$15

DATA_0F982A:
	db $34,$15,$34,$15,$34,$15,$34,$15,$34,$15,$36,$15,$34,$15,$36,$15
	db $37,$15,$38,$15,$37,$15,$28,$15,$34,$15,$09,$1D,$34,$15,$34,$15
	db $09,$1D,$0A,$1D,$19,$1D,$1A,$1D,$0B,$1D,$0C,$1D,$1B,$1D,$1C,$1D
	db $0C,$5D,$0B,$5D,$1C,$5D,$1B,$5D,$0A,$5D,$09,$5D,$1A,$5D,$19,$5D
	db $09,$15,$0A,$15,$19,$15,$1A,$15,$0B,$15,$0C,$15,$1B,$15,$1C,$15
	db $0C,$55,$0B,$55,$1C,$55,$1B,$55,$0A,$55,$09,$55,$1A,$55,$19,$55
	db $00,$15,$01,$15,$10,$15,$11,$15,$BB,$1D,$BC,$1D,$34,$1D,$88,$1D
	db $BD,$1D,$BC,$1D,$89,$1D,$8C,$1D,$BD,$1D,$BC,$1D,$8D,$1D,$89,$5D
	db $BD,$1D,$BE,$1D,$88,$1D,$34,$1D,$B0,$1D,$B1,$1D,$B2,$1D,$E8,$1C
	db $20,$15,$21,$15,$30,$15,$31,$15,$02,$15,$03,$15,$12,$15,$13,$15
	db $B1,$5D,$B0,$5D,$E9,$1C,$B2,$5D,$34,$15,$34,$1D,$34,$15,$34,$1D
	db $34,$1D,$98,$1D,$34,$1D,$A8,$1D,$89,$1D,$8A,$1D,$99,$1D,$9A,$1D
	db $8B,$1D,$89,$5D,$9B,$1D,$99,$5D,$9C,$1D,$34,$1D,$AC,$1D,$34,$1D
	db $24,$15,$16,$15,$34,$15,$26,$15,$17,$15,$18,$15,$27,$15,$28,$15
	db $B3,$1D,$EA,$1C,$34,$1D,$8E,$1D,$EB,$1C,$B3,$5D,$8F,$1D,$34,$1D
	db $34,$1D,$A8,$1D,$34,$1D,$A8,$1D,$A9,$1D,$8A,$1D,$B9,$1D,$B9,$1D
	db $8B,$1D,$A9,$5D,$B9,$1D,$BA,$1D,$AC,$1D,$34,$1D,$AC,$1D,$34,$1D
	db $34,$15,$34,$15,$0D,$1D,$0E,$1D,$34,$15,$34,$15,$0F,$1D,$34,$15
	db $1D,$1D,$1E,$1D,$2D,$1D,$2E,$1D,$1F,$1D,$29,$1D,$2F,$1D,$39,$1D
	db $37,$15,$38,$15,$37,$15,$38,$15,$34,$1D,$A8,$1D,$34,$1D,$B8,$1D
	db $8B,$1D,$A9,$5D,$B9,$1D,$B9,$1D,$AC,$1D,$34,$1D,$BA,$1D,$34,$1D
	db $3D,$1D,$3E,$1D,$34,$15,$15,$1D,$3F,$1D,$2A,$1D,$25,$1D,$3A,$1D
	db $34,$15,$26,$95,$24,$95,$16,$95,$27,$95,$38,$15,$17,$95,$18,$95
	db $80,$1D,$81,$1D,$90,$1D,$91,$1D,$82,$1D,$83,$1D,$92,$1D,$93,$1D
	db $32,$15,$22,$15,$10,$15,$11,$15,$22,$15,$23,$15,$10,$15,$11,$15
	db $33,$15,$00,$15,$10,$15,$11,$15,$A0,$1D,$A1,$1D,$10,$15,$11,$15
	db $A2,$1D,$A3,$1D,$10,$15,$11,$15,$33,$15,$34,$15,$10,$15,$11,$15
	db $85,$15,$87,$15,$95,$15,$97,$15,$84,$15,$86,$15,$94,$15,$96,$15
	db $85,$15,$86,$15,$95,$15,$96,$15,$84,$15,$87,$15,$94,$15,$97,$15
	db $84,$15,$85,$15,$94,$15,$95,$15,$86,$15,$85,$15,$96,$15,$95,$15
	db $A6,$15,$A7,$15,$B6,$15,$B7,$15,$94,$15,$A6,$15,$B4,$15,$B6,$15
	db $A6,$15,$A6,$15,$B6,$15,$B6,$15,$94,$15,$A7,$15,$B4,$15,$B7,$15
	db $99,$15,$16,$15,$34,$15,$26,$15,$4C,$15,$4D,$15,$5C,$15,$40,$15
	db $4D,$15,$4D,$15,$41,$15,$42,$15,$4D,$15,$4D,$15,$43,$15,$44,$15
	db $4D,$15,$4E,$15,$45,$15,$5D,$15,$5C,$15,$50,$15,$5C,$15,$60,$15
	db $51,$15,$52,$15,$61,$15,$62,$15,$53,$15,$54,$15,$63,$15,$64,$15
	db $55,$15,$5D,$15,$65,$15,$5D,$15,$5C,$15,$70,$15,$5C,$15,$46,$15
	db $71,$15,$72,$15,$47,$15,$48,$15,$73,$15,$74,$15,$49,$15,$4A,$15
	db $75,$15,$5D,$15,$4B,$15,$5D,$15,$5C,$15,$56,$15,$5C,$15,$66,$15
	db $57,$15,$58,$15,$67,$15,$68,$15,$59,$15,$5A,$15,$69,$15,$6A,$15
	db $5B,$15,$5D,$15,$6B,$15,$5D,$15,$5C,$15,$76,$15,$5E,$15,$6C,$15
	db $77,$15,$78,$15,$6C,$15,$6C,$15,$79,$15,$7A,$15,$6C,$15,$6C,$15
	db $7B,$15,$5D,$15,$6C,$15,$6D,$15,$24,$00,$24,$00,$24,$00,$24,$00
	db $24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00
	db $24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00
	db $24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00
	db $24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00
	db $24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00

DATA_0F9B2A:
	db $24,$00,$24,$00,$24,$00,$24,$00,$A4,$10,$A4,$10,$24,$00,$24,$00
	db $A4,$10,$A4,$10,$A4,$10,$A4,$10,$72,$15,$71,$15,$5E,$15,$5F,$15
	db $24,$00,$24,$00,$24,$00,$F0,$1C,$24,$00,$24,$00,$F1,$1C,$24,$00
	db $72,$15,$71,$15,$5E,$15,$5F,$15,$72,$15,$71,$15,$5E,$15,$5F,$15
	db $40,$15,$41,$15,$50,$15,$51,$15,$46,$15,$47,$15,$56,$15,$57,$15
	db $72,$15,$71,$15,$5E,$15,$5F,$15,$24,$00,$F2,$1C,$24,$00,$F4,$1C
	db $F3,$1C,$24,$00,$F5,$1C,$24,$00,$60,$15,$61,$15,$70,$15,$71,$15
	db $66,$15,$67,$15,$76,$15,$77,$15,$0A,$15,$0B,$15,$1A,$15,$1B,$15
	db $0C,$15,$0D,$15,$1C,$15,$1D,$15,$28,$15,$29,$15,$1A,$15,$1B,$15
	db $38,$15,$39,$15,$1C,$15,$1D,$15,$0E,$15,$24,$00,$1E,$15,$1F,$15
	db $72,$15,$71,$15,$5E,$15,$5F,$15,$72,$15,$71,$15,$5E,$15,$5F,$15
	db $72,$15,$71,$15,$5E,$15,$5F,$15,$72,$15,$71,$15,$5E,$15,$5F,$15
	db $20,$15,$21,$15,$30,$15,$31,$15,$2A,$15,$2B,$15,$3A,$15,$3B,$15
	db $2C,$15,$2D,$15,$3C,$15,$3D,$15,$2E,$15,$2F,$15,$3E,$15,$3F,$15
	db $72,$15,$71,$15,$5E,$15,$5F,$15,$72,$15,$71,$15,$5E,$15,$5F,$15
	db $22,$15,$23,$15,$32,$15,$33,$15,$72,$15,$71,$15,$5E,$15,$5F,$15
	db $0C,$15,$0D,$15,$1C,$15,$1D,$15,$28,$15,$29,$15,$1A,$15,$1B,$15
	db $38,$15,$39,$15,$1C,$15,$1D,$15,$42,$15,$43,$15,$52,$15,$53,$15
	db $44,$15,$45,$15,$54,$15,$55,$15,$62,$15,$63,$15,$72,$15,$73,$15
	db $64,$15,$65,$15,$74,$15,$75,$15,$24,$00,$24,$00,$24,$00,$24,$00
	db $24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00
	db $24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00
	db $24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00
	db $24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00
	db $34,$15,$35,$15,$1A,$15,$1B,$15,$36,$15,$37,$15,$1C,$15,$1D,$15
	db $2A,$15,$2B,$15,$24,$15,$25,$15,$2C,$15,$2D,$15,$26,$15,$27,$15
	db $A4,$15,$A5,$15,$B4,$15,$B5,$15,$05,$15,$0B,$15,$15,$15,$03,$15
	db $24,$00,$04,$15,$24,$00,$14,$15,$10,$15,$11,$15,$13,$15,$27,$15
	db $24,$00,$24,$00,$24,$00,$12,$15,$06,$15,$2B,$15,$09,$15,$07,$15
	db $2E,$15,$2F,$15,$3E,$15,$07,$15,$24,$00,$24,$00,$08,$15,$24,$00
	db $2E,$15,$2F,$15,$09,$15,$07,$15,$72,$15,$71,$15,$5E,$15,$5F,$15
	db $22,$15,$23,$15,$32,$15,$33,$15,$72,$15,$71,$15,$5E,$15,$5F,$15

DATA_0F9D2A:
	db $24,$10,$24,$10,$24,$10,$24,$10,$0A,$15,$4A,$15,$4A,$15,$16,$15
	db $07,$15,$06,$15,$5A,$15,$16,$15,$24,$10,$01,$15,$10,$15,$11,$15
	db $02,$15,$03,$15,$0A,$15,$0A,$15,$04,$15,$24,$10,$14,$15,$15,$15
	db $0A,$15,$0D,$15,$0A,$15,$1D,$15,$07,$15,$24,$10,$0E,$15,$07,$15
	db $0A,$15,$1D,$15,$0A,$15,$0A,$15,$1F,$15,$17,$15,$1E,$15,$55,$15
	db $1E,$15,$55,$15,$0A,$15,$0F,$15,$55,$15,$17,$15,$55,$15,$55,$15
	db $55,$15,$55,$15,$1F,$15,$55,$15,$07,$15,$06,$15,$0E,$15,$5B,$15
	db $18,$15,$0A,$15,$0E,$15,$18,$15,$5E,$15,$5E,$15,$4F,$15,$4F,$15
	db $0A,$15,$4B,$15,$4A,$15,$16,$15,$55,$15,$5A,$15,$5A,$15,$16,$15
	db $24,$10,$06,$15,$06,$15,$16,$15,$16,$15,$0A,$15,$0A,$15,$0A,$15
	db $02,$15,$08,$15,$0A,$15,$0A,$15,$09,$15,$0A,$15,$14,$15,$1A,$15
	db $0A,$55,$0A,$15,$0A,$15,$0A,$15,$1E,$15,$17,$15,$0A,$15,$0F,$15
	db $07,$15,$24,$10,$17,$15,$07,$15,$0A,$15,$0F,$15,$0A,$15,$1D,$15
	db $55,$15,$17,$15,$1F,$15,$55,$15,$1F,$15,$55,$15,$1E,$15,$55,$15
	db $55,$15,$55,$15,$55,$15,$55,$15,$07,$15,$06,$15,$17,$15,$5B,$15
	db $18,$15,$0A,$15,$17,$15,$18,$15,$5F,$15,$5F,$15,$5F,$15,$5F,$15
	db $45,$15,$0A,$15,$0A,$15,$0A,$15,$0A,$15,$0A,$15,$0A,$15,$19,$15
	db $0A,$15,$12,$15,$0A,$15,$12,$95,$13,$15,$0A,$15,$13,$95,$0A,$15
	db $19,$15,$0A,$55,$0A,$55,$45,$D5,$47,$15,$47,$55,$47,$95,$47,$D5
	db $57,$15,$57,$55,$57,$95,$57,$D5,$12,$15,$0A,$15,$12,$95,$19,$15
	db $0A,$15,$0A,$15,$47,$15,$47,$55,$47,$95,$54,$15,$0A,$15,$57,$95
	db $57,$55,$0A,$15,$57,$D5,$0A,$15,$0B,$15,$0C,$15,$1B,$15,$1C,$15
	db $0A,$15,$0A,$15,$0A,$15,$0B,$15,$0A,$15,$0A,$15,$0C,$15,$0A,$15
	db $0B,$15,$1B,$15,$1B,$15,$0A,$15,$1C,$15,$0C,$15,$0A,$15,$1C,$15
	db $55,$55,$56,$55,$55,$55,$56,$D5,$55,$55,$46,$55,$55,$55,$46,$D5
	db $5C,$15,$17,$15,$55,$55,$55,$55,$55,$55,$17,$15,$55,$55,$4C,$15
	db $26,$15,$21,$15,$36,$15,$31,$15,$22,$15,$23,$15,$32,$15,$33,$15
	db $20,$15,$21,$15,$30,$15,$31,$15,$22,$15,$24,$15,$32,$15,$34,$15
	db $27,$15,$51,$15,$37,$15,$31,$15,$52,$15,$53,$15,$32,$15,$33,$15
	db $50,$15,$51,$15,$30,$15,$31,$15,$52,$15,$48,$15,$32,$15,$58,$15
	db $27,$15,$41,$15,$37,$15,$31,$15,$42,$15,$43,$15,$32,$15,$33,$15
	db $40,$15,$41,$15,$30,$15,$31,$15,$42,$15,$44,$15,$32,$15,$35,$15
	db $2E,$15,$29,$15,$3E,$15,$39,$15,$2A,$15,$2B,$15,$3A,$15,$3B,$15
	db $28,$15,$29,$15,$38,$15,$39,$15,$2A,$15,$2C,$15,$3A,$15,$3C,$15
	db $2F,$15,$29,$15,$3F,$15,$39,$15,$2A,$15,$49,$15,$3A,$15,$59,$15
	db $2A,$15,$2D,$15,$3A,$15,$3D,$15,$60,$15,$61,$15,$5E,$15,$5F,$15
	db $62,$15,$63,$15,$67,$15,$68,$15,$62,$15,$4D,$15,$67,$15,$5D,$15
	db $62,$15,$4E,$15,$67,$15,$5D,$15,$62,$15,$4F,$15,$67,$15,$5D,$15
	db $64,$15,$61,$15,$69,$15,$5F,$15,$65,$15,$61,$15,$6A,$15,$5F,$15
	db $66,$15,$66,$15,$66,$15,$66,$15,$86,$15,$86,$15,$87,$15,$87,$15
	db $88,$15,$88,$15,$88,$15,$88,$15,$12,$15,$1F,$15,$12,$15,$1F,$15
	db $07,$15,$06,$15,$B0,$15,$16,$15,$45,$15,$71,$15,$0E,$15,$A2,$15
	db $89,$15,$8C,$15,$9B,$15,$9C,$15,$9D,$15,$9F,$15,$9F,$15,$12,$15
	db $89,$15,$8C,$15,$9B,$15,$9C,$15,$FF,$15,$FF,$15,$FF,$15,$FF,$15
	db $EE,$15,$EE,$15,$FE,$15,$FE,$15,$27,$00,$27,$00,$27,$00,$27,$00
	db $27,$00,$27,$00,$27,$00,$27,$00,$27,$00,$27,$00,$27,$00,$27,$00
	db $27,$00,$27,$00,$27,$00,$27,$00,$27,$00,$27,$00,$27,$00,$27,$00
	db $27,$00,$27,$00,$27,$00,$27,$00,$27,$00,$27,$00,$27,$00,$27,$00
	db $2E,$14,$96,$15,$67,$15,$91,$15,$97,$15,$03,$15,$12,$15,$13,$15
	db $4E,$15,$06,$15,$54,$15,$16,$15,$A0,$15,$A1,$15,$B0,$15,$16,$15
	db $17,$15,$B0,$15,$B0,$15,$16,$15,$55,$15,$17,$15,$55,$15,$17,$95
	db $55,$15,$55,$15,$55,$15,$17,$95,$45,$15,$71,$15,$17,$15,$A2,$15
	db $57,$15,$81,$15,$90,$15,$91,$15,$82,$15,$83,$15,$92,$15,$93,$15
	db $84,$15,$57,$15,$94,$15,$95,$15,$12,$15,$0D,$15,$12,$15,$1D,$15
	db $07,$15,$24,$14,$0E,$15,$07,$15,$1E,$15,$17,$15,$12,$15,$0F,$15
	db $12,$15,$1D,$15,$12,$15,$12,$15,$1F,$15,$17,$15,$1E,$15,$55,$15
	db $07,$15,$4B,$15,$0E,$15,$45,$15,$18,$15,$19,$15,$0E,$15,$18,$15
	db $12,$15,$0F,$15,$12,$15,$1D,$15,$55,$15,$17,$15,$1F,$15,$55,$15
	db $1E,$15,$55,$15,$12,$15,$0F,$15,$1F,$15,$55,$15,$1E,$15,$55,$15
	db $55,$15,$55,$15,$1F,$15,$55,$15,$45,$15,$2E,$14,$0E,$15,$45,$15
	db $12,$15,$12,$15,$12,$15,$89,$15,$12,$15,$12,$15,$8C,$15,$12,$15
	db $89,$15,$8A,$15,$99,$15,$9A,$15,$8B,$15,$8C,$15,$9B,$15,$9C,$15
	db $8D,$15,$8E,$15,$12,$15,$8F,$15,$9D,$15,$9E,$15,$9F,$15,$12,$15
	db $89,$15,$8C,$15,$99,$15,$9A,$15,$89,$15,$8C,$15,$9B,$15,$9C,$15
	db $B3,$15,$B2,$15,$B2,$15,$16,$15,$B3,$15,$A3,$15,$B2,$15,$16,$15
	db $12,$15,$99,$15,$12,$15,$8F,$15,$9D,$15,$8E,$15,$9F,$15,$8F,$15
	db $9C,$15,$12,$15,$9F,$15,$12,$15,$12,$15,$12,$15,$8C,$15,$89,$15
	db $89,$15,$8C,$15,$9B,$15,$9A,$15,$12,$15,$12,$15,$89,$15,$8C,$15
	db $99,$15,$9C,$15,$8F,$15,$9F,$15,$12,$15,$99,$15,$8C,$15,$8F,$15
	db $16,$15,$12,$15,$89,$15,$8C,$15,$16,$15,$12,$15,$12,$15,$89,$15
	db $16,$15,$12,$15,$89,$15,$8C,$15,$99,$15,$9C,$15,$8D,$15,$B1,$15
	db $12,$15,$1D,$15,$8C,$15,$12,$15,$12,$15,$1D,$15,$8C,$15,$12,$15
	db $62,$15,$63,$15,$72,$15,$73,$15,$64,$15,$65,$15,$74,$15,$75,$15
	db $66,$15,$67,$15,$76,$15,$77,$15,$68,$15,$69,$15,$78,$15,$79,$15
	db $24,$00,$24,$00,$00,$1D,$01,$1D,$24,$00,$24,$00,$02,$1D,$03,$1D
	db $24,$00,$24,$00,$04,$1D,$05,$1D,$24,$00,$24,$00,$06,$1D,$07,$1D
	db $10,$1D,$11,$1D,$20,$1D,$21,$1D,$12,$1D,$13,$1D,$22,$1D,$23,$1D
	db $14,$1D,$15,$1D,$24,$1D,$25,$1D,$16,$1D,$17,$1D,$26,$1D,$27,$1D
	db $24,$00,$24,$00,$40,$1D,$41,$1D,$30,$1D,$31,$1D,$08,$1D,$09,$1D
	db $32,$1D,$33,$1D,$0A,$1D,$0B,$1D,$34,$1D,$35,$1D,$0C,$1D,$0D,$1D
	db $36,$1D,$37,$1D,$0E,$1D,$0F,$1D,$50,$1D,$51,$1D,$60,$1D,$61,$1D
	db $18,$1D,$19,$1D,$28,$1D,$29,$1D,$1A,$1D,$1B,$1D,$2A,$1D,$2B,$1D
	db $1C,$1D,$1D,$1D,$2C,$1D,$2D,$1D,$1E,$1D,$1F,$1D,$2E,$1D,$2F,$1D
	db $70,$1D,$71,$1D,$24,$00,$24,$00,$38,$1D,$39,$1D,$24,$00,$24,$00
	db $3A,$1D,$3B,$1D,$24,$00,$24,$00,$3C,$1D,$3D,$1D,$24,$00,$24,$00
	db $3E,$1D,$3F,$1D,$24,$00,$24,$00,$3E,$1D,$3F,$1D,$24,$00,$24,$00
	db $3E,$1D,$3F,$1D,$24,$00,$24,$00,$3E,$1D,$3F,$1D,$24,$00,$24,$00
	db $3E,$1D,$3F,$1D,$24,$00,$24,$00,$3E,$1D,$3F,$1D,$24,$00,$24,$00
	db $C0,$1D,$C1,$1D,$D0,$1D,$D1,$1D,$C2,$1D,$C3,$1D,$D2,$1D,$D3,$1D
	db $C4,$1D,$C5,$1D,$D4,$1D,$D5,$1D,$C6,$1D,$C7,$1D,$D6,$1D,$D7,$1D
	db $C8,$1D,$C9,$1D,$D8,$1D,$D9,$1D,$CA,$1D,$24,$00,$DA,$1D,$DB,$1D
	db $E8,$1D,$24,$00,$F8,$1D,$24,$00,$E8,$1D,$E9,$1D,$F8,$1D,$F9,$1D
	db $EA,$1D,$EB,$1D,$FA,$1D,$FB,$1D,$24,$00,$E9,$1D,$24,$00,$F9,$1D
	db $DF,$1D,$C3,$1D,$DC,$1D,$D3,$1D,$E8,$1D,$E9,$1D,$F8,$1D,$F9,$1D
	db $CC,$1D,$CD,$1D,$D0,$1D,$D1,$1D,$CE,$1D,$CF,$1D,$D2,$1D,$D3,$1D
	db $24,$00,$E5,$1D,$24,$00,$F5,$1D,$24,$00,$DD,$1D,$24,$00,$DE,$1D
	db $E0,$1D,$E1,$1D,$F0,$1D,$F1,$1D,$E2,$1D,$E3,$1D,$F2,$1D,$F3,$1D
	db $E4,$1D,$E5,$1D,$F4,$1D,$F5,$1D,$E6,$1D,$E7,$1D,$F6,$1D,$F7,$1D
	db $E2,$1D,$F8,$1D,$F2,$1D,$F3,$1D,$E2,$1D,$E3,$1D,$F2,$1D,$F3,$1D
	db $E4,$1D,$24,$00,$F4,$1D,$24,$00,$24,$00,$24,$00,$EC,$1D,$ED,$1D
	db $E2,$1D,$F8,$1D,$F2,$1D,$F3,$1D,$EE,$15,$EE,$15,$FE,$15,$FE,$15
	db $FF,$15,$FF,$15,$FF,$15,$FF,$15,$16,$1D,$12,$1D,$12,$1D,$89,$1D
	db $16,$1D,$12,$1D,$89,$1D,$8C,$1D,$99,$1D,$9C,$1D,$8D,$1D,$B1,$1D
	db $12,$1D,$1D,$1D,$8C,$1D,$12,$1D,$12,$1D,$1D,$1D,$8C,$1D,$12,$1D
	db $62,$15,$63,$15,$72,$15,$73,$15,$64,$15,$65,$15,$74,$15,$75,$15
	db $66,$15,$67,$15,$76,$15,$77,$15,$68,$15,$69,$15,$78,$15,$79,$15
	db $07,$15,$06,$15,$B0,$15,$16,$15,$20,$15,$21,$15,$30,$15,$31,$15
	db $22,$15,$23,$15,$32,$15,$33,$15,$28,$15,$29,$15,$38,$15,$39,$15
	db $2A,$15,$2B,$15,$3A,$15,$3B,$15,$26,$15,$21,$15,$36,$15,$31,$15
	db $22,$15,$24,$15,$32,$15,$34,$15,$2E,$15,$29,$15,$3E,$15,$39,$15
	db $2A,$15,$2C,$15,$3A,$15,$3C,$15,$40,$15,$41,$15,$30,$15,$31,$15
	db $42,$15,$43,$15,$32,$15,$33,$15,$27,$15,$41,$15,$37,$15,$31,$15
	db $22,$15,$24,$15,$32,$15,$34,$15,$2F,$15,$29,$15,$3F,$15,$39,$15
	db $2A,$15,$2D,$15,$3A,$15,$3D,$15,$50,$15,$51,$15,$30,$15,$31,$15
	db $52,$15,$53,$15,$32,$15,$33,$15,$52,$15,$48,$15,$32,$15,$58,$15
	db $2A,$15,$49,$15,$3A,$15,$59,$15

DATA_0FA462:
	db $24,$00,$24,$00,$24,$00,$24,$00,$C1,$1C,$24,$00,$24,$00,$24,$00
	db $C2,$1C,$24,$00,$24,$00,$24,$00,$C3,$1C,$24,$00,$24,$00,$24,$00
	db $24,$00,$24,$00,$C0,$1C,$24,$00,$24,$00,$24,$00,$C1,$1C,$24,$00
	db $24,$00,$24,$00,$C2,$1C,$24,$00,$24,$00,$24,$00,$C3,$1C,$24,$00
	db $C4,$1C,$24,$00,$24,$00,$24,$00,$C5,$1C,$24,$00,$24,$00,$24,$00
	db $C6,$1C,$24,$00,$24,$00,$24,$00,$C7,$1C,$24,$00,$24,$00,$24,$00
	db $24,$00,$24,$00,$C4,$1C,$24,$00,$24,$00,$24,$00,$C5,$1C,$24,$00
	db $24,$00,$24,$00,$C6,$1C,$24,$00,$24,$00,$24,$00,$C7,$1C,$24,$00
	db $24,$00,$C0,$1C,$24,$00,$24,$00,$24,$00,$C1,$1C,$24,$00,$24,$00
	db $24,$00,$C2,$1C,$24,$00,$24,$00,$24,$00,$C3,$1C,$24,$00,$24,$00
	db $24,$00,$24,$00,$24,$00,$C0,$1C,$24,$00,$24,$00,$24,$00,$C1,$1C
	db $24,$00,$24,$00,$24,$00,$C2,$1C,$24,$00,$24,$00,$24,$00,$C3,$1C
	db $24,$00,$C4,$1C,$24,$00,$24,$00,$24,$00,$C5,$1C,$24,$00,$24,$00
	db $24,$00,$C6,$1C,$24,$00,$24,$00,$24,$00,$C7,$1C,$24,$00,$24,$00
	db $24,$00,$24,$00,$24,$00,$C4,$1C,$24,$00,$24,$00,$24,$00,$C5,$1C
	db $24,$00,$24,$00,$24,$00,$C6,$1C,$24,$00,$24,$00,$24,$00,$C7,$1C
	db $E0,$15,$E0,$15,$E1,$15,$E1,$15,$C6,$15,$C7,$15,$D6,$15,$D7,$15
	db $C8,$15,$C9,$15,$D8,$15,$D9,$15,$CA,$15,$CB,$15,$DA,$15,$DB,$15
	db $CC,$15,$CD,$15,$DC,$15,$DD,$15,$E6,$15,$E7,$15,$F6,$15,$F7,$15
	db $E8,$15,$E9,$15,$F8,$15,$F9,$15,$EA,$15,$EB,$15,$FA,$15,$FB,$15
	db $EC,$15,$ED,$15,$FC,$15,$FD,$15,$E2,$15,$E2,$15,$E2,$15,$E2,$15
	db $C0,$1C,$24,$00,$24,$00,$24,$00,$C0,$1C,$24,$00,$24,$00,$24,$00

DATA_0FA5C2:
	db $24,$00,$24,$00,$24,$00,$24,$00,$04,$15,$05,$15,$16,$15,$17,$15
	db $06,$15,$07,$15,$20,$15,$21,$15,$04,$15,$05,$15,$22,$15,$23,$15
	db $06,$15,$07,$15,$14,$15,$15,$15,$0C,$15,$0D,$15,$1C,$15,$1D,$15
	db $24,$00,$24,$00,$1E,$15,$24,$00,$24,$00,$2C,$15,$24,$00,$3C,$15
	db $0C,$15,$2A,$15,$16,$15,$3A,$15,$2B,$15,$07,$15,$3B,$15,$21,$15
	db $26,$15,$27,$15,$36,$15,$37,$15,$30,$15,$31,$15,$08,$15,$24,$00
	db $32,$15,$33,$15,$24,$00,$0B,$15,$24,$15,$25,$15,$34,$15,$35,$15
	db $26,$15,$1B,$15,$36,$15,$37,$15,$0F,$15,$24,$00,$08,$15,$24,$00
	db $24,$00,$24,$00,$24,$00,$3E,$15,$2E,$15,$2F,$15,$3F,$15,$35,$15
	db $18,$15,$24,$00,$4A,$15,$4B,$15,$24,$00,$19,$15,$5A,$15,$5B,$15
	db $24,$00,$19,$15,$5C,$15,$48,$15,$24,$15,$25,$15,$44,$15,$45,$15
	db $26,$15,$27,$15,$46,$15,$47,$15,$24,$00,$24,$00,$5C,$15,$51,$15
	db $24,$00,$24,$00,$52,$15,$53,$15,$24,$00,$19,$15,$50,$15,$48,$15
	db $00,$15,$01,$15,$11,$15,$00,$15,$68,$15,$69,$15,$78,$15,$79,$15
	db $6A,$15,$6B,$15,$7A,$15,$7B,$15,$10,$15,$11,$15,$01,$15,$10,$15
	db $6C,$15,$61,$15,$7C,$15,$71,$15,$54,$15,$55,$15,$72,$15,$73,$15
	db $56,$15,$57,$15,$74,$15,$75,$15,$4C,$15,$4D,$15,$76,$15,$77,$15
	db $62,$15,$63,$15,$72,$15,$73,$15,$64,$15,$65,$15,$74,$15,$75,$15
	db $66,$15,$67,$15,$76,$15,$77,$15,$60,$15,$61,$15,$7C,$15,$71,$15
	db $54,$15,$58,$15,$72,$15,$59,$15,$16,$15,$17,$15,$18,$15,$19,$15
	db $19,$15,$18,$15,$18,$15,$19,$15,$06,$15,$06,$15,$14,$15,$15,$15

DATA_0FA712:
	db $34,$15,$34,$15,$34,$15,$34,$15,$34,$15,$04,$15,$34,$15,$04,$15
	db $05,$15,$06,$15,$05,$15,$06,$15,$29,$15,$2A,$15,$19,$15,$1A,$15
	db $2B,$15,$2C,$15,$1B,$15,$1C,$15,$38,$15,$34,$15,$38,$15,$34,$15
	db $19,$15,$1A,$15,$19,$15,$1A,$15,$1B,$15,$1C,$15,$1B,$15,$1C,$15
	db $09,$15,$0A,$15,$19,$15,$1A,$15,$0B,$15,$0C,$15,$1B,$15,$1C,$15
	db $34,$15,$04,$15,$34,$15,$14,$15,$05,$15,$06,$15,$15,$15,$06,$15
	db $00,$15,$01,$15,$10,$15,$11,$15,$00,$15,$02,$15,$10,$15,$12,$15
	db $03,$15,$01,$15,$13,$15,$11,$15,$0D,$15,$0A,$15,$1D,$15,$1A,$15
	db $0B,$15,$0E,$15,$1B,$15,$1E,$15,$0F,$15,$01,$15,$1F,$15,$11,$15
	db $20,$15,$21,$15,$30,$15,$31,$15,$20,$15,$22,$15,$30,$15,$32,$15
	db $23,$15,$21,$15,$33,$15,$31,$15,$20,$15,$21,$15,$30,$15,$30,$15
	db $2D,$15,$1A,$15,$3D,$15,$1A,$15,$1B,$15,$2E,$15,$1B,$15,$3E,$15
	db $2F,$15,$21,$15,$3F,$15,$31,$15,$35,$15,$35,$15,$34,$15,$34,$15
	db $24,$15,$16,$15,$34,$15,$26,$15,$17,$15,$18,$15,$27,$15,$28,$15
	db $25,$15,$35,$15,$34,$15,$34,$15,$39,$15,$0A,$15,$19,$15,$1A,$15
	db $3A,$15,$35,$15,$38,$15,$34,$15,$34,$15,$36,$15,$34,$15,$36,$15
	db $37,$15,$28,$15,$37,$15,$28,$15,$02,$15,$03,$15,$12,$15,$05,$15
	db $04,$15,$24,$15,$14,$15,$15,$15,$24,$15,$06,$15,$06,$15,$16,$15
	db $12,$15,$12,$15,$12,$15,$12,$15,$0E,$15,$17,$15,$0F,$15,$55,$15
	db $07,$15,$24,$15,$17,$15,$07,$15,$16,$15,$1B,$15,$0B,$15,$1B,$15
	db $0C,$15,$12,$15,$1C,$15,$0C,$15,$1D,$15,$55,$15,$1E,$15,$55,$15
	db $55,$15,$17,$15,$55,$15,$55,$15,$16,$15,$0B,$15,$12,$15,$12,$15
	db $1B,$15,$12,$15,$12,$15,$12,$15,$1E,$15,$55,$15,$12,$15,$55,$15
	db $55,$15,$55,$15,$55,$15,$55,$15,$80,$1D,$81,$1D,$90,$1D,$91,$1D
	db $81,$5D,$80,$5D,$92,$1D,$90,$5D,$A0,$1D,$A1,$1D,$B0,$1D,$82,$1D
	db $A2,$1D,$B1,$1D,$82,$5D,$B2,$1D,$34,$15,$7C,$15,$34,$15,$7D,$15
	db $87,$15,$88,$15,$97,$15,$98,$15,$83,$1D,$84,$1D,$93,$1D,$94,$1D
	db $85,$1D,$86,$1D,$95,$1D,$96,$1D,$A7,$15,$A8,$15,$B7,$15,$B8,$15
	db $34,$15,$8A,$15,$34,$15,$9A,$15,$89,$15,$8B,$15,$13,$15,$9B,$15
	db $A3,$1D,$A4,$1D,$30,$15,$30,$15,$A5,$1D,$A6,$1D,$30,$15,$30,$15
	db $B3,$15,$B4,$15,$B5,$15,$B6,$15,$A9,$15,$AA,$15,$B9,$15,$32,$15
	db $23,$15,$AB,$15,$33,$15,$31,$15,$35,$15,$16,$15,$34,$15,$26,$15
	db $99,$15,$16,$15,$34,$15,$26,$15,$4C,$15,$4D,$15,$5C,$15,$40,$15
	db $4D,$15,$4D,$15,$41,$15,$42,$15,$4D,$15,$4D,$15,$43,$15,$44,$15
	db $4D,$15,$4E,$15,$45,$15,$5D,$15,$5C,$15,$50,$15,$5C,$15,$60,$15
	db $51,$15,$52,$15,$61,$15,$62,$15,$53,$15,$54,$15,$63,$15,$64,$15
	db $55,$15,$5D,$15,$65,$15,$5D,$15,$5C,$15,$70,$15,$5C,$15,$46,$15
	db $71,$15,$72,$15,$47,$15,$48,$15,$73,$15,$74,$15,$49,$15,$4A,$15
	db $75,$15,$5D,$15,$4B,$15,$5D,$15,$5C,$15,$56,$15,$5C,$15,$66,$15
	db $57,$15,$58,$15,$67,$15,$68,$15,$59,$15,$5A,$15,$69,$15,$6A,$15
	db $5B,$15,$5D,$15,$6B,$15,$5D,$15,$5C,$15,$76,$15,$5E,$15,$6C,$15
	db $77,$15,$78,$15,$6C,$15,$6C,$15,$79,$15,$7A,$15,$6C,$15,$6C,$15
	db $7B,$15,$5D,$15,$6C,$15,$6D,$15,$04,$15,$05,$15,$04,$15,$05,$15
	db $06,$15,$34,$15,$06,$15,$34,$15,$34,$15,$29,$15,$34,$15,$19,$15
	db $2A,$15,$2B,$15,$1A,$15,$1B,$15,$2C,$15,$38,$15,$1C,$15,$38,$15
	db $34,$15,$19,$15,$34,$15,$19,$15,$1A,$15,$1B,$15,$1A,$15,$1B,$15
	db $1C,$15,$38,$15,$1C,$15,$38,$15,$34,$15,$09,$15,$34,$15,$19,$15
	db $0A,$15,$0B,$15,$1A,$15,$1B,$15,$24,$00,$24,$00,$24,$00,$24,$00
	db $34,$15,$34,$15,$34,$15,$34,$15,$34,$15,$36,$15,$34,$15,$36,$15
	db $37,$15,$38,$15,$37,$15,$28,$15,$34,$15,$09,$1D,$34,$15,$34,$15
	db $09,$1D,$0A,$1D,$19,$1D,$1A,$1D,$0B,$1D,$0C,$1D,$1B,$1D,$1C,$1D
	db $0C,$5D,$0B,$5D,$1C,$5D,$1B,$5D,$34,$15,$8D,$1D,$9C,$1D,$9D,$1D
	db $AC,$1D,$AD,$1D,$BC,$1D,$BD,$1D,$8C,$1D,$8E,$1D,$BB,$1D,$9E,$1D
	db $AD,$5D,$AC,$5D,$BD,$5D,$BC,$5D,$0A,$55,$09,$55,$1A,$55,$19,$55
	db $00,$15,$01,$15,$10,$15,$11,$15,$BB,$1D,$BC,$1D,$34,$1D,$88,$1D
	db $BD,$1D,$BC,$1D,$89,$1D,$8C,$1D,$BD,$1D,$BC,$1D,$8D,$1D,$89,$5D
	db $34,$15,$34,$15,$34,$15,$CE,$15,$EC,$15,$ED,$15,$FC,$15,$FD,$15
	db $EE,$15,$EF,$15,$FE,$15,$FF,$15,$34,$15,$34,$15,$CF,$15,$34,$15
	db $CE,$15,$CF,$15,$34,$15,$DE,$15,$D8,$15,$D9,$15,$C9,$15,$FD,$15
	db $C1,$15,$C2,$15,$FE,$15,$DF,$15,$CE,$15,$CF,$15,$DE,$15,$34,$15
	db $CE,$15,$CF,$15,$34,$15,$DE,$15,$D8,$15,$D9,$15,$6E,$15,$FD,$15
	db $C1,$15,$C2,$15,$FE,$15,$6F,$15,$CE,$15,$CF,$15,$DE,$15,$34,$15
	db $CE,$15,$CF,$15,$34,$15,$34,$15,$CE,$15,$CF,$15,$34,$15,$34,$15
	db $34,$1D,$A8,$1D,$34,$1D,$A8,$1D,$A9,$1D,$8A,$1D,$B9,$1D,$B9,$1D
	db $34,$15,$DE,$15,$CE,$15,$CF,$15,$C9,$15,$FD,$15,$D8,$15,$D9,$15
	db $FE,$15,$DF,$15,$C1,$15,$C2,$15,$DE,$15,$34,$15,$CE,$15,$CF,$15
	db $1D,$1D,$1E,$1D,$2D,$1D,$2E,$1D,$1F,$1D,$29,$1D,$2F,$1D,$39,$1D
	db $37,$15,$38,$15,$37,$15,$38,$15,$34,$15,$DE,$15,$34,$15,$34,$15
	db $6E,$15,$FD,$15,$34,$15,$34,$15,$FE,$15,$6F,$15,$34,$15,$34,$15
	db $DE,$15,$34,$15,$34,$15,$34,$15,$3F,$1D,$2A,$1D,$25,$1D,$3A,$1D
	db $34,$15,$26,$95,$24,$95,$16,$95,$27,$95,$38,$15,$17,$95,$18,$95
	db $80,$1D,$81,$1D,$90,$1D,$91,$1D,$82,$1D,$83,$1D,$92,$1D,$93,$1D
	db $BD,$1D,$BE,$1D,$88,$1D,$34,$1D,$B0,$1D,$B1,$1D,$B2,$1D,$2B,$1D
	db $20,$15,$21,$15,$30,$15,$31,$15,$02,$15,$03,$15,$12,$15,$13,$15
	db $B1,$5D,$B0,$5D,$2C,$1D,$B2,$5D,$34,$15,$34,$1D,$34,$15,$34,$1D
	db $34,$1D,$98,$1D,$34,$1D,$A8,$1D,$89,$1D,$8A,$1D,$99,$1D,$9A,$1D
	db $8B,$1D,$89,$5D,$9B,$1D,$99,$5D,$9C,$1D,$34,$1D,$AC,$1D,$34,$1D
	db $24,$15,$16,$15,$34,$15,$26,$15,$17,$15,$18,$15,$27,$15,$28,$15
	db $B3,$1D,$3B,$1D,$34,$1D,$8E,$1D,$3C,$1D,$B3,$5D,$8F,$1D,$34,$1D
	db $34,$1D,$A8,$1D,$34,$1D,$A8,$1D,$A9,$1D,$8A,$1D,$B9,$1D,$B9,$1D
	db $8B,$1D,$A9,$5D,$B9,$1D,$BA,$1D,$AC,$1D,$34,$1D,$AC,$1D,$34,$1D
	db $34,$15,$34,$15,$0D,$1D,$0E,$1D,$34,$15,$34,$15,$0F,$1D,$34,$15
	db $1D,$1D,$1E,$1D,$2D,$1D,$2E,$1D,$1F,$1D,$29,$1D,$2F,$1D,$39,$1D
	db $37,$15,$38,$15,$37,$15,$38,$15,$34,$1D,$A8,$1D,$34,$1D,$B8,$1D
	db $8B,$1D,$A9,$5D,$B9,$1D,$B9,$1D,$AC,$1D,$34,$1D,$BA,$1D,$34,$1D
	db $3D,$1D,$3E,$1D,$34,$15,$15,$1D,$3F,$1D,$2A,$1D,$25,$1D,$3A,$1D
	db $34,$15,$26,$95,$24,$95,$16,$95,$27,$95,$38,$15,$17,$95,$18,$95
	db $80,$1D,$81,$1D,$90,$1D,$91,$1D,$82,$1D,$83,$1D,$92,$1D,$93,$1D
	db $32,$15,$22,$15,$10,$15,$11,$15,$22,$15,$23,$15,$10,$15,$11,$15
	db $33,$15,$00,$15,$10,$15,$11,$15,$A0,$1D,$A1,$1D,$10,$15,$11,$15
	db $A2,$1D,$A3,$1D,$10,$15,$11,$15,$33,$15,$34,$15,$10,$15,$11,$15
	db $85,$15,$87,$15,$95,$15,$97,$15,$84,$15,$86,$15,$94,$15,$96,$15
	db $85,$15,$86,$15,$95,$15,$96,$15,$84,$15,$87,$15,$94,$15,$97,$15
	db $84,$15,$85,$15,$94,$15,$95,$15,$86,$15,$85,$15,$96,$15,$95,$15
	db $A6,$15,$A7,$15,$B6,$15,$B7,$15,$94,$15,$A6,$15,$B4,$15,$B6,$15
	db $A6,$15,$A6,$15,$B6,$15,$B6,$15,$94,$15,$A7,$15,$B4,$15,$B7,$15

DATA_0FAD12:
	db $24,$10,$24,$10,$24,$10,$24,$10,$0E,$15,$0F,$15,$1E,$15,$1F,$15
	db $02,$1D,$03,$1D,$12,$1D,$13,$1D,$20,$1D,$21,$1D,$30,$1D,$31,$1D
	db $2E,$15,$2F,$15,$3E,$15,$3F,$15,$22,$1D,$23,$1D,$32,$1D,$33,$1D
	db $20,$1D,$21,$1D,$1C,$15,$1D,$15,$28,$15,$29,$15,$10,$1D,$11,$1D
	db $2A,$15,$2B,$15,$12,$1D,$13,$1D,$6C,$15,$6D,$15,$7C,$15,$7D,$15
	db $4E,$15,$4F,$15,$5E,$15,$5F,$15,$6E,$15,$6F,$15,$7E,$15,$7F,$15
	db $48,$1D,$49,$1D,$58,$1D,$59,$1D,$4A,$1D,$4B,$1D,$5A,$1D,$5B,$1D
	db $0C,$15,$0D,$15,$1C,$15,$1D,$15,$68,$1D,$69,$1D,$78,$1D,$79,$1D
	db $6A,$1D,$6B,$1D,$7A,$1D,$7B,$1D,$28,$15,$29,$15,$38,$15,$39,$15
	db $2A,$15,$2B,$15,$3A,$15,$3B,$15,$08,$15,$09,$15,$18,$15,$19,$15
	db $0A,$15,$0B,$15,$1A,$15,$1B,$15,$06,$1D,$07,$1D,$16,$1D,$17,$15
	db $04,$15,$05,$1D,$14,$1D,$15,$1D,$06,$1D,$03,$1D,$16,$1D,$13,$1D
	db $26,$1D,$27,$1D,$36,$1D,$37,$1D,$24,$1D,$25,$1D,$34,$1D,$35,$1D
	db $26,$1D,$23,$1D,$36,$1D,$33,$1D,$2C,$15,$2D,$15,$3C,$15,$3D,$15
	db $3D,$15,$3C,$15,$3C,$15,$3D,$15,$00,$1D,$01,$1D,$10,$1D,$11,$1D

;--------------------------------------------------------------------

DATA_0FAE02:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMBLL_J) != $00
	dw $0148,$0148,$0722,$082E,$0A26,$0BB2,$113A,$1280
	dw $1430,$1576,$113A,$113A,$113A,$1280,$0000,$0122
	dw $01AC,$01AC,$0504,$062C,$06F8,$0794,$07CE,$153E
	dw $0808,$08A0,$0A00,$0AA8,$0B76,$0C22,$0DFA,$0FA4
	dw $11BC,$1558,$0122,$11EA,$15AA,$15E0,$153E,$15E0
	dw $15E0,$154A,$1558,$0000,$0B76,$0794,$06F8,$01AC
	dw $0504,$0FA4,$11BC,$11EA,$120E,$0794,$1568,$0032
	dw $0032,$14F4,$0910,$1528,$0032,$150E,$0668,$0668
	dw $0668,$15CE,$0668,$13A0,$1336,$0668,$0668,$1584
else
	dw $0148,$0148,$0722,$082E,$0A26,$0BB2,$113A,$1280
	dw $1430,$1576,$113A,$113A,$113A,$1280,$0000,$0122
	dw $01AC,$01AC,$0504,$062C,$06F8,$0794,$07CE,$153E
	dw $0808,$08A0,$0A00,$0AA8,$0B76,$0C22,$0DFA,$0FA4
	dw $11BC,$1558,$0122,$11EA,$15AA,$15DA,$153E,$15DA
	dw $15DA,$154A,$1558,$0000,$0B76,$0794,$06F8,$01AC
	dw $0504,$0FA4,$11BC,$11EA,$120E,$0794,$1568,$0032
	dw $0032,$14F4,$0910,$1528,$0032,$150E,$0668,$0668
	dw $0668,$15C8,$0668,$13A0,$1336,$0668,$0668,$1584
endif

;--------------------------------------------------------------------

DATA_0FAE92:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	db $FE,$00,$B9,$B8,$B6,$FE,$00,$BE,$C3,$C6,$FE,$B4,$B1,$BC,$BD,$B0
	db $B5,$FE,$C0,$C1,$C0,$C1,$C0,$C4,$FE,$B2,$B3,$B2,$B3,$B2,$B3,$B6
	db $FE,$C2,$C3,$C2,$C3,$C2,$C3,$C6,$FE,$C2,$C3,$C2,$C3,$C2,$C3,$C6
	db $FE,$C2,$C3,$C2,$C3,$C2,$C3,$C6,$FF,$FE,$B9,$B8,$FE,$BE,$C3,$FE
	db $BE,$C3,$FE,$BE,$C3,$FF,$FE,$00,$00,$BA,$B0,$B5,$FE,$00,$BF,$C1
	db $C0,$C4,$FE,$00,$B9,$B3,$B2,$B3,$B6,$FE,$00,$BE,$C3,$C2,$C3,$C6
	db $FE,$00,$BA,$BC,$BD,$BC,$BD,$B0,$B5,$FE,$BF,$C1,$C0,$C1,$C0,$C1
	db $C0,$C4,$FE,$B9,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$FE,$BE,$C3,$C2,$C3
	db $C2,$C3,$C2,$C3,$FE,$BE,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$FE,$BE,$C3
	db $C2,$C3,$C2,$C3,$C2,$C3,$FF,$FE,$00,$00,$00,$00,$C7,$FE,$00,$00
	db $00,$BF,$C4,$FE,$00,$00,$00,$B9,$B3,$B6,$00,$B9,$B8,$BB,$B8,$B6
	db $FE,$00,$00,$00,$BE,$C3,$C6,$00,$BE,$C3,$C2,$C3,$C6,$FE,$00,$00
	db $B4,$B1,$BC,$BD,$B0,$B1,$BC,$BD,$BC,$BD,$B0,$B5,$FE,$00,$00,$C0
	db $C1,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C4,$FE,$B9,$B8,$B2,$B3
	db $B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$FE,$BE,$C3,$C2,$C3,$C2
	db $C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$FE,$BE,$C3,$C2,$C3,$C2,$C3
	db $C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$FE,$BE,$C3,$C2,$C3,$C2,$C3,$C2
	db $C3,$C2,$C3,$C2,$C3,$C2,$C3,$FF,$FE,$00,$00,$00,$00,$C7,$FE,$00
	db $00,$00,$BF,$C4,$FE,$00,$B9,$B8,$BB,$B3,$BB,$B8,$B6,$FE,$00,$BE
	db $C3,$C2,$C3,$C2,$C3,$C6,$FE,$B4,$B1,$BC,$BD,$BC,$BD,$BC,$BD,$B0
	db $B5,$FE,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C4,$FE,$B2,$B3,$B2
	db $B3,$B2,$B3,$B2,$B3,$B2,$B3,$FE,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3
	db $C2,$C3,$FE,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$FE,$C2,$C3
	db $C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$FF,$FE,$B6,$FE,$C6,$FE,$C6,$FE
	db $C6,$FF,$FE,$B4,$B1,$FE,$C0,$C1,$FE,$B2,$B3,$FE,$C2,$C3,$FE,$C2
	db $C3,$FE,$C2,$C3,$FF,$FE,$00,$00,$00,$00,$00,$B9,$B8,$B6,$FE,$00
	db $00,$00,$00,$00,$BE,$C3,$C6,$FE,$00,$00,$00,$00,$B4,$B1,$BC,$BD
	db $B0,$B5,$FE,$00,$00,$00,$00,$C0,$C1,$C0,$C1,$C0,$C4,$FE,$B9,$B8
	db $BB,$B8,$B2,$B3,$B2,$B3,$B2,$B3,$FE,$BE,$C3,$C2,$C3,$C2,$C3,$C2
	db $C3,$C2,$C3,$FE,$BE,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$FE,$BE
	db $C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$FF,$FE,$00,$00,$00,$00,$C7
	db $00,$C7,$FE,$00,$00,$00,$BF,$C4,$BF,$C4,$FE,$00,$B9,$B8,$BB,$B3
	db $BB,$B3,$B6,$FE,$00,$BE,$C3,$C2,$C3,$C2,$C3,$C6,$FE,$B4,$B1,$BC
	db $BD,$BC,$BD,$BC,$BD,$B0,$B5,$FE,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C1
	db $C0,$C4,$FE,$B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$FE,$C2,$C3
	db $C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$FE,$C2,$C3,$C2,$C3,$C2,$C3,$C2
	db $C3,$C2,$C3,$FE,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$FF,$FE
	db $00,$00,$BA,$B0,$B5,$00,$00,$00,$C7,$FE,$00,$BF,$C1,$C0,$C4,$00
	db $00,$BF,$C4,$FE,$00,$B9,$B3,$B2,$B3,$B6,$00,$B9,$B3,$BB,$B8,$B6
	db $FE,$00,$BE,$C3,$C2,$C3,$C6,$00,$BE,$C3,$C2,$C3,$C6,$FE,$B4,$B1
	db $BC,$BD,$BC,$BD,$B0,$B1,$BC,$BD,$BC,$BD,$B0,$B1,$B0,$B5,$FE,$C0
	db $C1,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C4,$FE
	db $B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3
	db $B6,$FE,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3
	db $C2,$C3,$C6,$FE,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3
	db $C2,$C3,$C2,$C3,$C6,$FE,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3
	db $C2,$C3,$C2,$C3,$C2,$C3,$C6,$FF,$FE,$00,$00,$00,$00,$C7,$FE,$00
	db $00,$00,$BF,$C4,$FE,$00,$B9,$B8,$BB,$B3,$B6,$FE,$00,$BE,$C3,$C2
	db $C3,$C6,$FE,$B4,$B1,$BC,$BD,$BC,$BD,$B0,$B5,$FE,$C0,$C1,$C0,$C1
	db $C0,$C1,$C0,$C4,$FE,$B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$FE,$C2,$C3
	db $C2,$C3,$C2,$C3,$C2,$C3,$FE,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$FE
	db $C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$FF,$FE,$B4,$B1,$B0,$B5,$FE,$C0
	db $C1,$C0,$C8,$FE,$B2,$B3,$B2,$B3,$B6,$FE,$C2,$C3,$C2,$C3,$C6,$FE
	db $C2,$C3,$C2,$C3,$C6,$FE,$C2,$C3,$C2,$C3,$C6,$FF,$FE,$00,$00,$00
	db $00,$00,$B4,$B5,$00,$C7,$B4,$B5,$FE,$00,$00,$00,$00,$00,$C0,$C8
	db $BF,$C8,$C0,$C8,$FE,$00,$00,$00,$B9,$B8,$B2,$B3,$BB,$B3,$B2,$B3
	db $B6,$FE,$00,$00,$00,$BE,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C6,$FE,$00
	db $BA,$B0,$B1,$BC,$BD,$BC,$BD,$BC,$BD,$BC,$BD,$B0,$B5,$FE,$BF,$C1
	db $C0,$C1,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C4,$FE,$B9,$B3,$B2
	db $B3,$B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$BB,$B8,$B6,$FE,$BE
	db $C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C6
	db $FE,$BE,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2
	db $C3,$C6,$FE,$BE,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2
	db $C3,$C2,$C3,$C6,$FF,$FE,$00,$00,$B4,$B1,$B0,$B5,$FE,$00,$00,$C0
	db $C1,$C0,$C4,$FE,$BB,$B8,$B2,$B3,$B2,$B3,$B6,$FE,$C2,$C3,$C2,$C3
	db $C2,$C3,$C6,$FE,$C2,$C3,$C2,$C3,$C2,$C3,$C6,$FE,$C2,$C3,$C2,$C3
	db $C2,$C3,$C6,$FF
else
	db $FE,$00,$B9,$B8,$B6,$FE,$00,$BE,$C3,$C6,$FE,$B4,$B1,$BC,$BD,$B0
	db $B5,$FE,$C0,$C1,$C0,$C1,$C0,$C4,$FE,$B2,$B3,$B2,$B3,$B2,$B3,$B6
	db $FE,$C2,$C3,$C2,$C3,$C2,$C3,$C6,$FE,$C2,$C3,$C2,$C3,$C2,$C3,$C6
	db $FF,$FE,$B9,$B8,$FE,$BE,$C3,$FE,$BE,$C3,$FF,$FE,$00,$00,$BA,$B0
	db $B5,$FE,$00,$BF,$C1,$C0,$C4,$FE,$00,$B9,$B3,$B2,$B3,$B6,$FE,$00
	db $BE,$C3,$C2,$C3,$C6,$FE,$00,$BA,$BC,$BD,$BC,$BD,$B0,$B5,$FE,$BF
	db $C1,$C0,$C1,$C0,$C1,$C0,$C4,$FE,$B9,$B3,$B2,$B3,$B2,$B3,$B2,$B3
	db $FE,$BE,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$FE,$BE,$C3,$C2,$C3,$C2,$C3
	db $C2,$C3,$FF,$FE,$00,$00,$00,$00,$C7,$FE,$00,$00,$00,$BF,$C4,$FE
	db $00,$00,$00,$B9,$B3,$B6,$00,$B9,$B8,$BB,$B8,$B6,$FE,$00,$00,$00
	db $BE,$C3,$C6,$00,$BE,$C3,$C2,$C3,$C6,$FE,$00,$00,$B4,$B1,$BC,$BD
	db $B0,$B1,$BC,$BD,$BC,$BD,$B0,$B5,$FE,$00,$00,$C0,$C1,$C0,$C1,$C0
	db $C1,$C0,$C1,$C0,$C1,$C0,$C4,$FE,$B9,$B8,$B2,$B3,$B2,$B3,$B2,$B3
	db $B2,$B3,$B2,$B3,$B2,$B3,$FE,$BE,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2
	db $C3,$C2,$C3,$C2,$C3,$FE,$BE,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3
	db $C2,$C3,$C2,$C3,$FF,$FE,$00,$00,$00,$00,$C7,$FE,$00,$00,$00,$BF
	db $C4,$FE,$00,$B9,$B8,$BB,$B3,$BB,$B8,$B6,$FE,$00,$BE,$C3,$C2,$C3
	db $C2,$C3,$C6,$FE,$B4,$B1,$BC,$BD,$BC,$BD,$BC,$BD,$B0,$B5,$FE,$C0
	db $C1,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C4,$FE,$B2,$B3,$B2,$B3,$B2,$B3
	db $B2,$B3,$B2,$B3,$FE,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$FE
	db $C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$FF,$FE,$B6,$FE,$C6,$FE
	db $C6,$FF,$FE,$B4,$B1,$FE,$C0,$C1,$FE,$B2,$B3,$FE,$C2,$C3,$FE,$C2
	db $C3,$FF,$FE,$00,$00,$00,$00,$00,$B9,$B8,$B6,$FE,$00,$00,$00,$00
	db $00,$BE,$C3,$C6,$FE,$00,$00,$00,$00,$B4,$B1,$BC,$BD,$B0,$B5,$FE
	db $00,$00,$00,$00,$C0,$C1,$C0,$C1,$C0,$C4,$FE,$B9,$B8,$BB,$B8,$B2
	db $B3,$B2,$B3,$B2,$B3,$FE,$BE,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3
	db $FE,$BE,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$FF,$FE,$00,$00,$00
	db $00,$C7,$00,$C7,$FE,$00,$00,$00,$BF,$C4,$BF,$C4,$FE,$00,$B9,$B8
	db $BB,$B3,$BB,$B3,$B6,$FE,$00,$BE,$C3,$C2,$C3,$C2,$C3,$C6,$FE,$B4
	db $B1,$BC,$BD,$BC,$BD,$BC,$BD,$B0,$B5,$FE,$C0,$C1,$C0,$C1,$C0,$C1
	db $C0,$C1,$C0,$C4,$FE,$B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$FE
	db $C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$FE,$C2,$C3,$C2,$C3,$C2
	db $C3,$C2,$C3,$C2,$C3,$FF,$FE,$00,$00,$BA,$B0,$B5,$00,$00,$00,$C7
	db $FE,$00,$BF,$C1,$C0,$C4,$00,$00,$BF,$C4,$FE,$00,$B9,$B3,$B2,$B3
	db $B6,$00,$B9,$B3,$BB,$B8,$B6,$FE,$00,$BE,$C3,$C2,$C3,$C6,$00,$BE
	db $C3,$C2,$C3,$C6,$FE,$B4,$B1,$BC,$BD,$BC,$BD,$B0,$B1,$BC,$BD,$BC
	db $BD,$B0,$B1,$B0,$B5,$FE,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C1
	db $C0,$C1,$C0,$C1,$C0,$C4,$FE,$B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$B2
	db $B3,$B2,$B3,$B2,$B3,$B2,$B3,$B6,$FE,$C2,$C3,$C2,$C3,$C2,$C3,$C2
	db $C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C6,$FE,$C2,$C3,$C2,$C3,$C2
	db $C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C6,$FF,$FE,$00,$00
	db $00,$00,$C7,$FE,$00,$00,$00,$BF,$C4,$FE,$00,$B9,$B8,$BB,$B3,$B6
	db $FE,$00,$BE,$C3,$C2,$C3,$C6,$FE,$B4,$B1,$BC,$BD,$BC,$BD,$B0,$B5
	db $FE,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C4,$FE,$B2,$B3,$B2,$B3,$B2,$B3
	db $B2,$B3,$FE,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$FE,$C2,$C3,$C2,$C3
	db $C2,$C3,$C2,$C3,$FF,$FE,$B4,$B1,$B0,$B5,$FE,$C0,$C1,$C0,$C8,$FE
	db $B2,$B3,$B2,$B3,$B6,$FE,$C2,$C3,$C2,$C3,$C6,$FE,$C2,$C3,$C2,$C3
	db $C6,$FF,$FE,$00,$00,$00,$00,$00,$B4,$B5,$00,$C7,$B4,$B5,$FE,$00
	db $00,$00,$00,$00,$C0,$C8,$BF,$C8,$C0,$C8,$FE,$00,$00,$00,$B9,$B8
	db $B2,$B3,$BB,$B3,$B2,$B3,$B6,$FE,$00,$00,$00,$BE,$C3,$C2,$C3,$C2
	db $C3,$C2,$C3,$C6,$FE,$00,$BA,$B0,$B1,$BC,$BD,$BC,$BD,$BC,$BD,$BC
	db $BD,$B0,$B5,$FE,$BF,$C1,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C1
	db $C0,$C4,$FE,$B9,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$B2
	db $B3,$BB,$B8,$B6,$FE,$BE,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2
	db $C3,$C2,$C3,$C2,$C3,$C6,$FE,$BE,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2
	db $C3,$C2,$C3,$C2,$C3,$C2,$C3,$C6,$FF,$FE,$00,$00,$B4,$B1,$B0,$B5
	db $FE,$00,$00,$C0,$C1,$C0,$C4,$FE,$BB,$B8,$B2,$B3,$B2,$B3,$B6,$FE
	db $C2,$C3,$C2,$C3,$C2,$C3,$C6,$FE,$C2,$C3,$C2,$C3,$C2,$C3,$C6,$FF
	db $FE,$00,$00,$00,$00,$00,$00,$00,$C7,$FE,$00,$00,$00,$00,$00,$00
	db $BF,$C4,$FE,$00,$00,$B9,$B8,$B6,$00,$B9,$B3,$BB,$B8,$B6,$FE,$00
	db $00,$BE,$C3,$C6,$00,$BE,$C3,$C2,$C3,$C6,$FE,$00,$00,$BA,$BC,$BD
	db $B0,$B1,$BC,$BD,$BC,$BD,$B0,$B5,$FE,$00,$BF,$C1,$C0,$C1,$C0,$C1
	db $C0,$C1,$C0,$C1,$C0,$C4,$FE,$00,$B9,$B3,$B2,$B3,$B2,$B3,$B2,$B3
	db $B2,$B3,$B2,$B3,$B6,$FE,$00,$BE,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2
	db $C3,$C2,$C3,$C6,$FE,$B4,$B1,$BC,$BD,$BC,$BD,$BC,$BD,$BC,$BD,$BC
	db $BD,$BC,$BD,$B0,$B5,$FE,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C1
	db $C0,$C1,$C0,$C1,$C0,$C4,$FE,$B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$B2
	db $B3,$B2,$B3,$B2,$B3,$B2,$B3,$B6,$FE,$C2,$C3,$C2,$C3,$C2,$C3,$C2
	db $C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C6,$FE,$C2,$C3,$C2,$C3,$C2
	db $C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C6,$FF
endif

;--------------------------------------------------------------------

if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
UNK_0FB2BE:
	db $FE,$00,$00,$00,$00,$00,$00,$00,$C7,$FE,$00,$00,$00,$00,$00,$00
	db $BF,$C4,$FE,$00,$00,$B9,$B8,$B6,$00,$B9,$B3,$BB,$B8,$B6,$FE,$00
	db $00,$BE,$C3,$C6,$00,$BE,$C3,$C2,$C3,$C6,$FE,$00,$00,$BA,$BC,$BD
	db $B0,$B1,$BC,$BD,$BC,$BD,$B0,$B5,$FE,$00,$BF,$C1,$C0,$C1,$C0,$C1
	db $C0,$C1,$C0,$C1,$C0,$C4,$FE,$00,$B9,$B3,$B2,$B3,$B2,$B3,$B2,$B3
	db $B2,$B3,$B2,$B3,$B6,$FE,$00,$BE,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2
	db $C3,$C2,$C3,$C6,$FE,$B4,$B1,$BC,$BD,$BC,$BD,$BC,$BD,$BC,$BD,$BC
	db $BD,$BC,$BD,$B0,$B5,$FE,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C1,$C0,$C1
	db $C0,$C1,$C0,$C1,$C0,$C4,$FE,$B2,$B3,$B2,$B3,$B2,$B3,$B2,$B3,$B2
	db $B3,$B2,$B3,$B2,$B3,$B2,$B3,$B6,$FE,$C2,$C3,$C2,$C3,$C2,$C3,$C2
	db $C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C6,$FE,$C2,$C3,$C2,$C3,$C2
	db $C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C6,$FE,$C2,$C3,$C2
	db $C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C2,$C3,$C6,$FF
endif

;--------------------------------------------------------------------

DATA_0FB2EF:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	db $03,$04,$05,$FE,$12,$13,$16,$06,$07,$FE,$12,$13,$16,$16,$16,$17
	db $18,$FE,$12,$13,$16,$16,$16,$16,$08,$09,$18,$FE,$12,$13,$16,$16
	db $16,$16,$16,$16,$19,$1A,$18,$FE,$12,$13,$16,$16,$16,$16,$16,$16
	db $16,$16,$0A,$1C,$18,$FE,$12,$13,$16,$16,$16,$16,$16,$16,$16,$16
	db $16,$08,$1B,$1C,$18,$FE,$12,$13,$16,$16,$16,$16,$16,$16,$16,$16
	db $16,$16,$16,$19,$0C,$0B,$18,$FE,$12,$13,$16,$16,$16,$16,$16,$16
	db $16,$16,$16,$16,$16,$16,$16,$0A,$1C,$0B,$18,$FE,$12,$13,$16,$16
	db $16,$16,$16,$16,$16,$16,$16,$16,$16,$16,$16,$16,$08,$1B,$1C,$0B
	db $18,$FE,$12,$13,$16,$16,$16,$16,$16,$16,$16,$16,$16,$16,$16,$16
	db $16,$16,$16,$16,$19,$0C,$1C,$0B,$18,$FE,$12,$13,$16,$16,$16,$16
	db $16,$16,$16,$16,$16,$16,$16,$16,$16,$16,$16,$16,$16,$16,$0A,$1C
	db $1C,$0B,$18,$FF,$FE,$13,$24,$FE,$FE,$13,$23,$16,$16,$16,$FF,$FE
	db $13,$27,$FE,$13,$2C,$2D,$26,$FE,$13,$20,$2E,$2F,$FE,$13,$16,$16
	db $16,$16,$16,$24,$FE,$13,$16,$16,$16,$16,$16,$16,$16,$16,$0A,$32
	db $FF,$FE,$13,$23,$FE,$13,$20,$FF,$FE,$13,$24,$FE,$FE,$13,$27,$16
	db $16,$26,$FE,$FF,$FE,$FE,$13,$24,$FE,$13,$16,$16,$16,$2B,$FE,$FE
	db $13,$16,$16,$16,$25,$16,$16,$16,$26,$FE,$13,$16,$23,$16,$24,$16
	db $16,$16,$24,$FE,$13,$16,$20,$16,$16,$16,$16,$16,$27,$FF,$FE,$13
	db $24,$FE,$13,$16,$16,$25,$FE,$13,$26,$FE,$13,$16,$16,$16,$24,$16
	db $27,$FE,$13,$16,$16,$16,$16,$16,$2C,$2D,$16,$0A,$32,$FF,$FE,$FE
	db $13,$16,$16,$25,$FE,$13,$16,$16,$27,$FE,$13,$16,$16,$16,$16,$2C
	db $2D,$FE,$13,$24,$23,$16,$16,$16,$2E,$2F,$16,$0A,$32,$FE,$13,$16
	db $16,$16,$16,$16,$16,$16,$16,$16,$08,$1B,$33,$FE,$13,$16,$16,$16
	db $16,$28,$20,$22,$FE,$13,$16,$16,$16,$16,$16,$29,$2A,$16,$16,$16
	db $16,$26,$21,$0A,$30,$FE,$13,$16,$16,$16,$16,$16,$16,$16,$16,$16
	db $16,$16,$16,$16,$20,$FF
else
	db $03,$04,$05,$FE,$12,$13,$16,$06,$07,$FE,$12,$13,$16,$16,$16,$17
	db $18,$FE,$12,$13,$16,$16,$16,$16,$08,$09,$18,$FE,$12,$13,$16,$16
	db $16,$16,$16,$16,$19,$1A,$18,$FE,$12,$13,$16,$16,$16,$16,$16,$16
	db $16,$16,$0A,$1C,$18,$FE,$12,$13,$16,$16,$16,$16,$16,$16,$16,$16
	db $16,$08,$1B,$1C,$18,$FE,$12,$13,$16,$16,$16,$16,$16,$16,$16,$16
	db $16,$16,$16,$19,$0C,$0B,$18,$FE,$12,$13,$16,$16,$16,$16,$16,$16
	db $16,$16,$16,$16,$16,$16,$16,$0A,$1C,$0B,$18,$FE,$12,$13,$16,$16
	db $16,$16,$16,$16,$16,$16,$16,$16,$16,$16,$16,$16,$08,$1B,$1C,$0B
	db $18,$FE,$12,$13,$16,$16,$16,$16,$16,$16,$16,$16,$16,$16,$16,$16
	db $16,$16,$16,$16,$19,$1C,$1C,$0B,$18,$FF,$FE,$13,$24,$FE,$FE,$13
	db $23,$16,$16,$16,$16,$32,$FF,$FE,$13,$27,$FE,$13,$2C,$2D,$26,$FE
	db $13,$20,$2E,$2F,$FE,$13,$16,$16,$16,$16,$16,$24,$FE,$13,$16,$16
	db $16,$16,$16,$16,$16,$16,$0A,$32,$FF,$FE,$13,$23,$FE,$13,$20,$FF
	db $FE,$13,$24,$FE,$FE,$13,$27,$16,$16,$26,$FE,$FF,$FE,$FE,$13,$24
	db $FE,$13,$16,$16,$16,$2B,$FE,$FE,$13,$16,$16,$16,$25,$16,$16,$16
	db $26,$FE,$13,$16,$23,$16,$24,$16,$16,$16,$24,$FE,$13,$16,$20,$16
	db $16,$16,$16,$16,$27,$FF,$FE,$13,$24,$FE,$13,$16,$16,$25,$FE,$13
	db $26,$FE,$13,$16,$16,$16,$24,$16,$27,$FE,$13,$16,$16,$16,$16,$16
	db $2C,$2D,$16,$0A,$32,$FF,$FE,$FE,$13,$16,$16,$25,$FE,$13,$16,$16
	db $27,$FE,$13,$16,$16,$16,$16,$2C,$2D,$FE,$13,$24,$23,$16,$16,$16
	db $2E,$2F,$16,$0A,$32,$FE,$13,$16,$16,$16,$16,$16,$16,$16,$16,$16
	db $08,$1B,$33,$FE,$13,$16,$16,$16,$16,$28,$20,$22,$FE,$13,$16,$16
	db $16,$16,$16,$29,$2A,$16,$16,$16,$16,$26,$21,$0A,$30,$FE,$13,$16
	db $16,$16,$16,$16,$16,$16,$16,$16,$16,$16,$16,$16,$20,$FF
endif

;--------------------------------------------------------------------

DATA_0FB46D:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	db $1A,$1B,$FE,$01,$02,$FE,$01,$02,$FE,$01,$02,$FE,$01,$02,$FE,$01
	db $02,$FE,$01,$02,$FE,$01,$26,$FE,$2C,$2D,$FE,$30,$31,$32,$FF,$04
	db $05,$06,$07,$FE,$0D,$0E,$0F,$10,$FE,$16,$17,$18,$19,$FE,$1E,$1F
	db $20,$21,$FE,$1E,$17,$18,$21,$FE,$27,$1F,$28,$29,$FF,$FE,$11,$14
	db $FE,$1C,$1D,$FF,$FE,$22,$23,$FE,$24,$25,$FE,$2A,$2B,$FE,$2E,$2F
	db $FE,$33,$34,$FF,$FE,$41,$42,$43,$44,$FE,$45,$46,$47,$48,$FE,$49
	db $4A,$4B,$4C,$FE,$4D,$4E,$4F,$50,$FE,$51,$52,$53,$54,$FF,$FE,$0C
	db $0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$FE
	db $12,$13,$12,$13,$12,$13,$12,$13,$12,$13,$12,$13,$12,$13,$12,$13
	db $FE,$36,$37,$38,$36,$39,$3A,$3B,$3B,$36,$3A,$3B,$3B,$3B,$36,$3A
	db $38,$FE,$3C,$3D,$3E,$3C,$3F,$3D,$3E,$3E,$3C,$3D,$3E,$3E,$3E,$3C
	db $3D,$3E,$FF,$22,$23,$FE,$24,$25,$FE,$2A,$2B,$FE,$33,$34,$FF
else
	db $1A,$1B,$FE,$01,$02,$FE,$01,$02,$FE,$01,$02,$FE,$01,$02,$FE,$01
	db $02,$FE,$01,$02,$FE,$01,$26,$FE,$2C,$2D,$FE,$30,$31,$32,$FF,$04
	db $05,$06,$07,$FE,$0D,$0E,$0F,$10,$FE,$16,$17,$18,$19,$FE,$1E,$1F
	db $20,$21,$FE,$1E,$17,$18,$21,$FE,$27,$1F,$28,$29,$FF,$FE,$11,$14
	db $FE,$1C,$1D,$FF,$FE,$22,$23,$FE,$24,$25,$FE,$2A,$2B,$FE,$2E,$2F
	db $FE,$33,$34,$FF,$FE,$41,$42,$43,$44,$FE,$45,$46,$47,$48,$FE,$49
	db $4A,$4B,$4C,$FE,$4D,$4E,$4F,$50,$FE,$51,$52,$53,$54,$FF,$FE,$0C
	db $0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$FE
	db $12,$13,$12,$13,$12,$13,$12,$13,$12,$13,$12,$13,$12,$13,$12,$13
	db $FE,$36,$37,$38,$36,$39,$3A,$3B,$3B,$36,$3A,$3B,$3B,$3B,$36,$3A
	db $38,$FE,$3C,$3D,$3E,$3C,$3F,$3D,$3E,$3E,$3C,$3D,$3E,$3E,$3E,$3C
	db $3D,$3E,$FF,$22,$23,$FE,$24,$25,$FE,$2A,$2B,$FE,$33,$34,$FF
endif

;--------------------------------------------------------------------

DATA_0FB52C:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	db $08,$FE,$0C,$FF,$14,$15,$16,$17,$FE,$1D,$1E,$1F,$20,$FE,$1D,$1E
	db $1F,$20,$FE,$1D,$2A,$2B,$20,$FF,$18,$19,$1A,$1B,$FE,$21,$22,$23
	db $24,$FE,$21,$22,$23,$24,$FE,$21,$22,$23,$24,$FF,$00,$00,$00,$00
	db $01,$02,$FE,$00,$00,$01,$03,$05,$06,$04,$02,$FE,$01,$03,$05,$09
	db $09,$09,$09,$06,$04,$02,$FE,$05,$09,$09,$09,$09,$09,$09,$09,$09
	db $06,$FF,$01,$03,$04,$03,$04,$02,$FE,$07,$08,$09,$09,$08,$0A,$FE
	db $0B,$0C,$09,$09,$0C,$0D,$0E,$FE,$11,$09,$09,$09,$09,$12,$13,$FE
	db $11,$18,$19,$1A,$1B,$12,$13,$FE,$11,$21,$22,$23,$24,$12,$13,$FE
	db $11,$21,$22,$23,$24,$12,$13,$FE,$11,$21,$22,$23,$24,$12,$13,$FF
	db $02,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$01
	db $FE,$35,$04,$03,$04,$03,$04,$03,$04,$03,$04,$03,$04,$03,$04,$03
	db $36,$FF
else
	db $08,$FE,$0C,$FF,$14,$15,$16,$17,$FE,$1D,$1E,$1F,$20,$FE,$1D,$1E
	db $1F,$20,$FE,$1D,$2A,$2B,$20,$FF,$18,$19,$1A,$1B,$FE,$21,$22,$23
	db $24,$FE,$21,$22,$23,$24,$FE,$21,$22,$23,$24,$FF,$00,$00,$00,$00
	db $01,$02,$FE,$00,$00,$01,$03,$05,$06,$04,$02,$FE,$01,$03,$05,$09
	db $09,$09,$09,$06,$04,$02,$FE,$05,$09,$09,$09,$09,$09,$09,$09,$09
	db $06,$FF,$01,$03,$04,$03,$04,$02,$FE,$07,$08,$09,$09,$08,$0A,$FE
	db $0B,$0C,$09,$09,$0C,$0D,$0E,$FE,$11,$09,$09,$09,$09,$12,$13,$FE
	db $11,$18,$19,$1A,$1B,$12,$13,$FE,$11,$21,$22,$23,$24,$12,$13,$FE
	db $11,$21,$22,$23,$24,$12,$13,$FE,$11,$21,$22,$23,$24,$12,$13,$FF
	db $02,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$01
	db $FE,$35,$04,$03,$04,$03,$04,$03,$04,$03,$04,$03,$04,$03,$04,$03
	db $36,$FF
endif

;--------------------------------------------------------------------

DATA_0FB5DE:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	db $00,$00,$00,$00,$00,$00,$00,$07,$01,$02,$03,$04,$01,$02,$03,$04
	db $00,$00,$00,$00,$00,$00,$10,$11,$0A,$0B,$0C,$0D,$0A,$0B,$0C,$0D
	db $00,$00,$17,$18,$00,$00,$19,$15,$16,$12,$14,$15,$16,$12,$14,$15
	db $23,$24,$25,$22,$23,$24,$25,$1F,$20,$21,$1E,$1F,$20,$21,$1E,$1F
	db $FF,$08,$09,$03,$04,$05,$06,$00,$00,$00,$00,$00,$07,$08,$09,$03
	db $04,$0A,$0B,$0C,$0D,$0E,$0F,$00,$00,$00,$00,$10,$11,$0A,$0B,$0C
	db $0D,$16,$12,$14,$15,$16,$12,$17,$18,$00,$00,$19,$15,$16,$12,$14
	db $15,$20,$21,$1E,$1F,$20,$21,$1E,$22,$23,$24,$25,$1F,$20,$21,$1E
	db $26,$FF,$01,$02,$03,$04,$08,$09,$03,$04,$08,$09,$03,$04,$05,$06
	db $00,$00,$0A,$0B,$0C,$0D,$0A,$0B,$0C,$0D,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$00,$0A,$12,$13,$0D,$0A,$12,$13,$0D,$0A,$12,$14,$15,$16,$12
	db $17,$18,$1A,$1B,$1C,$1D,$1A,$1B,$1C,$1D,$1A,$1B,$1E,$1F,$20,$21
	db $1E,$22,$FF
else
	db $00,$00,$00,$00,$00,$00,$00,$07,$01,$02,$03,$04,$01,$02,$03,$04
	db $00,$00,$00,$00,$00,$00,$10,$11,$0A,$0B,$0C,$0D,$0A,$0B,$0C,$0D
	db $00,$00,$17,$18,$00,$00,$19,$15,$16,$12,$14,$15,$16,$12,$14,$15
	db $23,$24,$25,$22,$23,$24,$25,$1F,$20,$21,$1E,$1F,$20,$21,$1E,$1F
	db $FF,$08,$09,$03,$04,$05,$06,$00,$00,$00,$00,$00,$07,$08,$09,$03
	db $04,$0A,$0B,$0C,$0D,$0E,$0F,$00,$00,$00,$00,$10,$11,$0A,$0B,$0C
	db $0D,$16,$12,$14,$15,$16,$12,$17,$18,$00,$00,$19,$15,$16,$12,$14
	db $15,$20,$21,$1E,$1F,$20,$21,$1E,$22,$23,$24,$25,$1F,$20,$21,$1E
	db $26,$FF,$01,$02,$03,$04,$08,$09,$03,$04,$08,$09,$03,$04,$05,$06
	db $00,$00,$0A,$0B,$0C,$0D,$0A,$0B,$0C,$0D,$0A,$0B,$0C,$0D,$0E,$0F
	db $00,$00,$0A,$12,$13,$0D,$0A,$12,$13,$0D,$0A,$12,$14,$15,$16,$12
	db $17,$18,$1A,$1B,$1C,$1D,$1A,$1B,$1C,$1D,$1A,$1B,$1E,$1F,$20,$21
	db $1E,$22,$FF
endif

;--------------------------------------------------------------------

DATA_0FB6A1:
	dw $E091,$E042,$E010,$A850,$A880,$E000,$8C60,$8CB0,$E000,$A850,$A880,$E000,$7070,$7090,$A850,$A8B0
	dw $9C70,$E000,$E000,$A840,$A8A0,$E000,$2470,$24E0,$E3F0,$E012,$E060,$E050,$E043,$4510,$6D10,$6100
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	dw $1530,$5520,$2900,$A960,$C970,$AD82,$CD92,$B9A0,$D9B0,$2D40,$4D50,$2007,$0026,$1C16,$E000,$4510
	dw $6D10,$1530,$5520,$2900,$2D40,$4D50,$2007,$0026,$1C16,$E000,$4510,$6D10,$6100,$1530,$5520,$2900
	dw $A960,$C970,$AD82,$CD92,$B9A0,$D9B0,$2D40,$4D50,$2007,$0026,$1C16,$E000,$4510,$6D10,$1530,$5520
	dw $2900,$2D40,$4D50,$2007,$0026,$1C16,$E000,$4510,$6D10,$6100,$1530,$5520,$2900,$A960,$C970,$AD82
	dw $CD92,$B9A0,$D9B0,$2D40,$4D50,$2007,$0026,$1C16,$E000,$4510,$6D10,$1530,$5520,$2900,$2D40,$4D50
	dw $2007,$0026,$1C16,$E000,$4510,$6D10,$6100,$1530,$5520,$2900,$A960,$C970,$AD82,$CD92,$B9A0,$D9B0
	dw $2D40,$4D50,$2007,$0026,$1C16,$E000,$4510,$6D10,$1530,$5520,$2900,$2D40,$4D50,$2007,$0026,$1C16
	dw $E3F0,$E091,$E04E,$E010,$E0A0,$A803,$BC00,$E000,$A802,$E000,$A400,$AC01,$E000,$A803,$E000,$A401
	dw $AC01,$BC08,$E000,$E3F0,$E046,$E050,$0003,$1003,$4019,$5019,$403F,$0826,$1826,$E000,$0C03,$4C19
	dw $1C03,$5C19,$403F,$0426,$1426,$E000,$0803,$4819,$403A,$0026,$5449,$9C45,$3060,$E000,$0C07,$8C13
	dw $1807,$9813,$803F,$0426,$3050,$6060,$E000,$2850,$0007,$8013,$1007,$9013,$803F,$5480,$E000,$0007
	dw $8013,$1407,$9413,$803F,$4480,$E3F0,$E011,$E04B,$E031,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016
	dw $4C16,$5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D,$901E,$8107,$8510,$9911,$E000,$181F,$2020
	dw $2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$8107
	dw $8510,$9910,$E000,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016,$4C16,$5417,$5C18,$6019,$641A,$681B
	dw $6C1C,$7816,$801D,$901E,$8107,$8510,$9911,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025
	dw $5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$8107,$8510,$9910,$E000,$0030,$1831,$2020
	dw $2432,$2C1B,$3023,$3833,$4034,$4835,$5436,$5837,$5C38,$6439,$683A,$6C3B,$703C,$743D,$783E,$943F
	dw $8107,$8911,$9910,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29
	dw $742A,$782B,$882C,$902D,$982F,$8107,$8510,$9910,$E000,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016
	dw $4C16,$5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D,$901E,$8107,$8510,$9911,$E000,$181F,$2020
	dw $2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$8107
	dw $8510,$9910,$E000,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016,$4C16,$5417,$5C18,$6019,$641A,$681B
	dw $6C1C,$7816,$801D,$901E,$8107,$8510,$9911,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025
	dw $5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$8107,$8510,$9910,$E3F0,$E011,$E04B,$E031
	dw $0010,$0C11,$1012,$1C13,$2414,$2815,$3016,$4C16,$5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D
	dw $901E,$8107,$8510,$9911,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428
	dw $6C29,$742A,$782B,$882C,$902D,$982F,$8107,$8510,$9910,$E000,$0010,$0C11,$1012,$1C13,$2414,$2815
	dw $3016,$4C16,$5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D,$901E,$8107,$8510,$9911,$E000,$181F
	dw $2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F
	dw $8107,$8510,$9910,$E000,$0030,$1831,$2020,$2432,$2C1B,$3023,$3833,$4034,$4835,$5436,$5837,$5C38
	dw $6439,$683A,$6C3B,$703C,$743D,$783E,$943F,$8107,$8911,$9910,$E000,$181F,$2020,$2421,$2C22,$3023
	dw $3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$8107,$8510,$9910,$0010
	dw $0C11,$1012,$1C13,$2414,$2815,$3016,$4C16,$5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D,$901E
	dw $8107,$8510,$9911,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29
	dw $742A,$782B,$882C,$902D,$982F,$8107,$8510,$9910,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016,$4C16
	dw $5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D,$901E,$8107,$8510,$9911,$E000,$181F,$2020,$2421
	dw $2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$8107,$8510
	dw $9910,$E3F0,$E04B,$E011,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016,$4C16,$5417,$5C18,$6019,$641A
	dw $681B,$6C1C,$7816,$801D,$901E,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27
	dw $6428,$6C29,$742A,$782B,$882C,$902D,$982F,$E000,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016,$4C16
	dw $5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D,$901E,$E000,$0030,$1831,$2020,$2432,$2C1B,$3023
	dw $3833,$4034,$4835,$5436,$5837,$5C38,$6439,$683A,$6C3B,$703C,$743D,$783E,$943F,$E000,$181F,$2020
	dw $2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$E000
	dw $181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D
	dw $982F,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B
	dw $882C,$902D,$982F,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29
	dw $742A,$782B,$882C,$902D,$982F,$E3F0,$E091,$E045,$E010,$8820,$B810,$7C00,$E000,$5890,$48A0,$E000
	dw $98B0,$E000,$A410,$6800,$5CC0,$E000,$E000,$A010,$6400,$90D0,$E000,$A410,$6800,$5CC0,$E000,$E000
	dw $A010,$6400,$90D0,$E3F0,$E091,$E070,$E048,$E020,$6900,$8163,$8970,$9180,$9510,$9920,$9D30,$A193
	dw $B1A0,$B572,$E000,$81B0,$85D0,$8962,$9580,$A1C0,$A593,$B5A0,$B961,$6830,$7010,$9830,$E000,$6910
	dw $6D21,$7530,$79B0,$7DD0,$81B0,$85D0,$8973,$99C0,$9D90,$A1C0,$A596,$5C30,$E000,$6160,$6580,$6910
	dw $6D22,$7930,$8190,$85A0,$8974,$9D60,$A197,$4010,$E000,$8160,$8580,$9940,$9D50,$A190,$A5A0,$A980
	dw $B5B0,$B9F0,$BD70,$6010,$AC10,$E000,$8207,$A177,$E000,$8207,$A177,$E3F0,$E091,$E04E,$E010,$E0A0
	dw $A803,$BC00,$E000,$A802,$E000,$A400,$AC01,$E000,$A803,$E000,$A401,$E000,$A401,$AC01,$BC08,$E000
	dw $E3F0,$E046,$E050,$0007,$1007,$6017,$7017,$603F,$0826,$B890,$E000,$0005,$1005,$6017,$7017,$603F
	dw $0826,$B4A0,$E000,$0005,$6017,$6039,$7047,$4860,$A890,$3850,$E000,$1005,$7017,$683B,$6447,$5860
	dw $E000,$0005,$6017,$1005,$7017,$603F,$0826,$5860,$B890,$E000,$0005,$6017,$1005,$7017,$603F,$0826
	dw $5480,$E000,$603F,$4480,$5080,$E000,$603F,$4480,$5080,$E3F0,$E091,$E042,$E010,$B050,$B080,$E000
	dw $6C70,$6C90,$A4F3,$E000,$7460,$74B0,$AC40,$ACA0,$E000,$8060,$80B0,$A4F9,$E000,$E000,$9060,$4060
	dw $40C0,$B4F2,$E000,$3870,$38E0,$A4F4,$E3F0,$E091,$E042,$E010,$B050,$B080,$E000,$6C70,$6C90,$A4F3
	dw $E000,$7460,$74B0,$AC40,$ACA0,$E000,$8060,$80B0,$A4F9,$E000,$E000,$9060,$4060,$40C0,$B4F2,$E000
	dw $3870,$38E0,$A4F4,$E3F0,$E091,$E04E,$E010,$E0A0,$A803,$BC00,$E000,$A802,$E000,$A400,$AC01,$E000
	dw $A803,$E000,$A401,$AC01,$BC08,$E000,$E3F0,$E046,$E050,$0007,$1007,$6017,$7017,$603F,$0826,$B890
	dw $E000,$0005,$1005,$6017,$7017,$603F,$0826,$B4A0,$E000,$0005,$6017,$6039,$7047,$4860,$A890,$3850
	dw $E000,$1005,$7017,$683B,$6447,$5860,$E000,$0005,$6017,$1005,$7017,$603F,$0826,$5860,$B890,$E000
	dw $0005,$6017,$1005,$7017,$603F,$0826,$5480,$E000,$603F,$4480,$5080,$E000,$603F,$4480,$5080,$E3F0
	dw $E091,$E045,$E010,$8820,$B810,$7C00,$E000,$5890,$48A0,$E000,$98B0,$E000,$A410,$6800,$5CC0,$E000
	dw $E000,$A010,$6400,$90D0,$E000,$8820,$B810,$7C00,$E000,$5890,$48A0,$E000,$98B0,$E000,$A410,$6800
	dw $5CC0,$E000,$E000,$A010,$6400,$90D0,$E000,$A010,$6400,$90D0,$E000,$8820,$B810,$7C00,$E000,$5890
	dw $48A0,$E000,$98B0,$E000,$A410,$6800,$5CC0,$E3F0,$E012,$E060,$E050,$E043,$4510,$6D10,$6100,$1530
	dw $5520,$2900,$A960,$C970,$AD82,$CD92,$B9A0,$D9B0,$2D40,$4D50,$2007,$0026,$1C16,$E000,$4510,$6D10
	dw $1530,$5520,$2900,$2D40,$4D50,$2007,$0026,$1C16,$E000,$4510,$6D10,$6100,$1530,$5520,$2900,$A960
	dw $C970,$AD82,$CD92,$B9A0,$D9B0,$2D40,$4D50,$2007,$0026,$1C16,$E000,$4510,$6D10,$1530,$5520,$2900
	dw $2D40,$4D50,$2007,$0026,$1C16,$E000,$4510,$6D10,$6100,$1530,$5520,$2900,$A960,$C970,$AD82,$CD92
	dw $B9A0,$D9B0,$2D40,$4D50,$2007,$0026,$1C16,$E000,$4510,$6D10,$1530,$5520,$2900,$2D40,$4D50,$2007
	dw $0026,$1C16,$E000,$4510,$6D10,$6100,$1530,$5520,$2900,$A960,$C970,$AD82,$CD92,$B9A0,$D9B0,$2D40
	dw $4D50,$2007,$0026,$1C16,$E000,$4510,$6D10,$1530,$5520,$2900,$2D40,$4D50,$2007,$0026,$1C16,$E3F0
	dw $E090,$E04E,$E010,$E0A0,$A803,$BC00,$E000,$A802,$E000,$A400,$AC01,$E000,$A803,$E000,$A401,$AC01
	dw $BC08,$E000,$E3F0,$E046,$E050,$0003,$1003,$4019,$5019,$403F,$0826,$1826,$E000,$0003,$1003,$4019
	dw $5019,$403F,$0826,$1826,$E000,$0C03,$4C19,$1C03,$5C19,$403F,$0426,$1426,$E000,$0803,$4819,$403A
	dw $0026,$5449,$9C45,$3060,$E000,$0C07,$8C13,$1807,$9813,$803F,$0426,$3050,$6060,$E000,$2850,$0007
	dw $8013,$1007,$9013,$803F,$5480,$E000,$0007,$8013,$1407,$9413,$803F,$4480,$E000,$0007,$8013,$1407
	dw $9413,$803F,$4480,$E3F0,$E091,$E010,$E045,$A410,$6800,$5C20,$E000,$6C00,$E000,$4030,$5C40,$E000
	dw $5020,$9060,$E000,$A050,$8420,$7870,$E000,$4C80,$E000,$4090,$E000,$A050,$8420,$7870,$E000,$4C80
	dw $E000,$4090,$E3F0,$E091,$E070,$E048,$E020,$6900,$8163,$8970,$9180,$9510,$9920,$9D30,$A193,$B1A0
	dw $B572,$E000,$81B0,$85D0,$8962,$9580,$A1C0,$A593,$B5A0,$B961,$6830,$7010,$9830,$E000,$6910,$6D21
	dw $7530,$79B0,$7DD0,$81B0,$85D0,$8973,$99C0,$9D90,$A1C0,$A596,$5C30,$E000,$6160,$6580,$6910,$6D22
	dw $7930,$8190,$85A0,$8974,$9D60,$A197,$4010,$E000,$8160,$8580,$9940,$9D50,$A190,$A5A0,$A980,$B5B0
	dw $B9F0,$BD70,$6010,$AC10,$E000,$8207,$A177,$E000,$8207,$A177,$E3F0,$E091,$E010,$E0B0,$E0C0,$9010
	dw $E000,$8800,$B010,$A425,$E000,$6810,$B420,$BC2F,$E000,$8810,$B800,$E000,$A800,$9810,$A420,$E000
	dw $6800,$A420,$B420,$BC2F,$E000,$6810,$BC20,$E000,$E3F0,$E046,$E050,$0007,$1007,$6017,$7017,$603F
	dw $0826,$B890,$E000,$0005,$1005,$6017,$7017,$603F,$0826,$B490,$E000,$0005,$6017,$6039,$7047,$4860
	dw $A890,$3850,$E000,$1005,$7017,$683B,$6447,$5860,$E000,$0005,$6017,$1005,$7017,$603F,$0826,$5860
	dw $B890,$E000,$0005,$6017,$1005,$7017,$603F,$0826,$E000,$603F,$4480,$5080,$E000,$603F,$4480,$5080
	dw $E3F0,$E011,$E04B,$E031,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016,$4C16,$5417,$5C18,$6019,$641A
	dw $681B,$6C1C,$7816,$801D,$901E,$8107,$8510,$9911,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024
	dw $5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$8107,$8510,$9910,$E000,$0010,$0C11
	dw $1012,$1C13,$2414,$2815,$3016,$4C16,$5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D,$901E,$8107
	dw $8510,$9911,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A
	dw $782B,$882C,$902D,$982F,$8107,$8510,$9910,$E000,$0030,$1831,$2020,$2432,$2C1B,$3023,$3833,$4034
	dw $4835,$5436,$5837,$5C38,$6439,$683A,$6C3B,$703C,$743D,$783E,$943F,$8107,$8911,$9910,$E000,$181F
	dw $2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F
	dw $8107,$8510,$9910,$E000,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016,$4C16,$5417,$5C18,$6019,$641A
	dw $681B,$6C1C,$7816,$801D,$901E,$8107,$8510,$9911,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024
	dw $5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$8107,$8510,$9910,$E000,$0010,$0C11
	dw $1012,$1C13,$2414,$2815,$3016,$4C16,$5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D,$901E,$8107
	dw $8510,$9911,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A
	dw $782B,$882C,$902D,$982F,$8107,$8510,$9910,$E000,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016,$4C16
	dw $5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D,$901E,$8107,$8510,$9911,$E3F0,$E011,$E04B,$E031
	dw $0010,$0C11,$1012,$1C13,$2414,$2815,$3016,$4C16,$5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D
	dw $901E,$8107,$8510,$9911,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428
	dw $6C29,$742A,$782B,$882C,$902D,$982F,$8107,$8510,$9910,$E000,$0010,$0C11,$1012,$1C13,$2414,$2815
	dw $3016,$4C16,$5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D,$901E,$8107,$8510,$9911,$E000,$181F
	dw $2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F
	dw $8107,$8510,$9910,$E000,$0030,$1831,$2020,$2432,$2C1B,$3023,$3833,$4034,$4835,$5436,$5837,$5C38
	dw $6439,$683A,$6C3B,$703C,$743D,$783E,$943F,$8107,$8911,$9910,$E000,$181F,$2020,$2421,$2C22,$3023
	dw $3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$8107,$8510,$9910,$0010
	dw $0C11,$1012,$1C13,$2414,$2815,$3016,$4C16,$5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D,$901E
	dw $8107,$8510,$9911,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29
	dw $742A,$782B,$882C,$902D,$982F,$8107,$8510,$9910,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016,$4C16
	dw $5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D,$901E,$8107,$8510,$9911,$E000,$181F,$2020,$2421
	dw $2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$8107,$8510
	dw $9910,$E3F0,$E04B,$E011,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016,$4C16,$5417,$5C18,$6019,$641A
	dw $681B,$6C1C,$7816,$801D,$901E,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27
	dw $6428,$6C29,$742A,$782B,$882C,$902D,$982F,$E000,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016,$4C16
	dw $5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D,$901E,$E000,$0030,$1831,$2020,$2432,$2C1B,$3023
	dw $3833,$4034,$4835,$5436,$5837,$5C38,$6439,$683A,$6C3B,$703C,$743D,$783E,$943F,$E000,$181F,$2020
	dw $2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$E000
	dw $181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D
	dw $982F,$E000,$0030,$1831,$2020,$2432,$2C1B,$3023,$3833,$4034,$4835,$5436,$5837,$5C38,$6439,$683A
	dw $6C3B,$703C,$743D,$783E,$943F,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27
	dw $6428,$6C29,$742A,$782B,$882C,$902D,$982F,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025
	dw $5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016
	dw $4C16,$5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D,$901E,$E000,$181F,$2020,$2421,$2C22,$3023
	dw $3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$E3F0,$E050,$E046,$0005
	dw $1405,$6017,$7417,$603F,$0826,$5C60,$E000,$0005,$1405,$6017,$7417,$603F,$0826,$5C60,$E000,$0807
	dw $1C07,$6817,$7C17,$603F,$1026,$E000,$1007,$7017,$603F,$7C47,$0426,$E000,$0426,$7435,$7047,$5860
	dw $B890,$E000,$0C07,$1C07,$6C17,$7C17,$603F,$0426,$5080,$B490,$E000,$603F,$7C47,$0426,$4C80,$E000
	dw $7435,$7047,$2450,$5480,$E000,$7017,$8017,$603F,$4090,$5090,$4480,$5480,$A0B0,$E3F0,$E091,$E010
	dw $E045,$A410,$6800,$5C20,$E000,$6C00,$E000,$4030,$5C40,$E000,$5020,$9060,$E000,$A050,$8420,$7870
	dw $E000,$4C80,$E000,$4090,$E3F0,$E091,$E010,$E045,$8420,$7470,$E000,$4880,$5C90,$E000,$E000,$40C0
	dw $E000,$4090,$E000,$4830,$E000,$04E0,$E3F0,$E091,$E010,$E04C,$E080,$A010,$A420,$B010,$B420,$BC10
	dw $A850,$E000,$A020,$A810,$AC20,$B810,$BC20,$B050,$4870,$E000,$A020,$A810,$AC20,$B410,$B820,$7C80
	dw $E000,$AC10,$B020,$B810,$BC20,$E000,$A410,$A820,$B010,$B420,$BC50,$9090,$E000,$A810,$AC20,$B410
	dw $B820,$E000,$A010,$A420,$B010,$B420,$BC10,$A860,$E000,$A020,$AC10,$B020,$B810,$BC20,$A460,$E3F0
	dw $E012,$E050,$E044,$A0A0,$2010,$2800,$4C30,$5830,$A0A0,$2010,$2800,$4C30,$5830,$E000,$A0A0,$4830
	dw $3010,$3800,$5C30,$E000,$A0A0,$4830,$5430,$E000,$A0A0,$2010,$2800,$5020,$5850,$E000,$A0A0,$4820
	dw $5050,$5820,$E000,$A0A0,$4450,$2C00,$94D0,$E000,$A0A0,$2000,$4840,$5440,$3C00,$E000,$A0A0,$2010
	dw $4830,$7470,$5C20,$E000,$A0A0,$2410,$8CC0,$3010,$5820,$E000,$A0A0,$4050,$5050,$4880,$5820,$E000
	dw $A0A0,$2400,$4C20,$5820,$E000,$A0A0,$4050,$5050,$4880,$5820,$E000,$A0A0,$2400,$4C20,$5820,$E000
	dw $A0A0,$4450,$2C00,$94D0,$E000,$A0A0,$2000,$4840,$5440,$3C00,$E3F0,$E091,$E070,$E048,$E020,$6900
	dw $8163,$8970,$9180,$9510,$9920,$9D30,$A193,$B1A0,$B572,$E000,$81B0,$85D0,$8962,$9580,$A1C0,$A593
	dw $B5A0,$B961,$9830,$E000,$81B0,$85D0,$8965,$A1C0,$A596,$E000,$8167,$A197,$E000,$8160,$8580,$9940
	dw $9D50,$A190,$A5A0,$A980,$B5B0,$B9F0,$BD70,$6010,$AC10,$E000,$8207,$A177,$E000,$8207,$A177,$E3F0
	dw $E091,$E070,$E048,$E020,$6100,$8562,$8170,$9180,$9510,$9920,$9D30,$A193,$B1A0,$B572,$E000,$81B0
	dw $85D0,$8962,$9580,$A1C0,$A593,$B5A0,$B961,$6430,$9830,$E000,$6D10,$7120,$7530,$79B0,$7DD0,$85B0
	dw $89D0,$8D72,$99C0,$9D90,$A160,$A5C0,$A995,$5C30,$E000,$6160,$6580,$6910,$6D22,$7930,$8190,$85A0
	dw $8974,$9D60,$A197,$4010,$E000,$8160,$8580,$9940,$9D50,$A190,$A5A0,$A980,$B5B0,$B9F0,$BD70,$6010
	dw $AC10,$E000,$8207,$A177,$E000,$8207,$A177,$E3F0,$E091,$E046,$E010,$E000,$E000,$E000,$E000,$E000
	dw $E000,$E3F0,$E091,$E070,$E048,$E020,$6900,$8163,$8970,$9180,$9510,$9920,$9D30,$A193,$B1A0,$B572
	dw $E000,$81B0,$85D0,$8962,$9580,$A1C0,$A593,$B5A0,$B961,$6830,$7010,$9830,$E000,$6910,$6D21,$7530
	dw $79B0,$7DD0,$81B0,$85D0,$8973,$99C0,$9D90,$A1C0,$A596,$5C30,$E000,$6160,$6580,$6910,$6D22,$7930
	dw $8190,$85A0,$8974,$9D60,$A197,$4010,$E000,$8160,$8580,$9940,$9D50,$A190,$A5A0,$A980,$B5B0,$B9F0
	dw $BD70,$6010,$AC10,$E000,$8207,$A177,$E000,$8207,$A177,$E3F0,$E3F0,$E3F0,$E3F0,$E3F0,$E3F0,$E3F0
	dw $E3F0,$E3F0,$E3F0,$E3F0,$E3F0,$E3F0,$E3F0,$E3F0,$E3F0,$E3F0,$E041,$E012,$2800,$E000,$3000,$E000
	dw $3800,$E000,$E000,$2800,$E000,$2800,$E3F0,$E041,$E012,$2800,$E000,$2800,$E000,$3800,$E000,$E000
	dw $2800,$E000,$2800,$E3F0,$E041,$E012,$3800,$E000,$3800,$E000,$E000,$2800,$E000,$E000,$E3F0,$E091
	dw $E042,$E010,$2470,$24E0,$E3F0,$E091,$E042,$E010,$E000,$2470,$24E0,$E3F0,$E010,$E041,$2800,$E000
	dw $E000,$E000,$2C00,$E3F0,$E010,$E041,$2800,$E000,$E000,$2C00,$E3F0,$E010,$E041,$2800,$E000,$E000
	dw $2C00,$E3F0,$E091,$E010,$E041,$E000,$E000,$E000,$E000,$E000,$E000,$E000,$E000,$E000,$E000,$E000
	dw $E000,$E000,$E000,$E000,$E3F0,$E091,$E042,$E013,$E04D,$E000,$E000,$E000,$E000,$E000,$E000,$E000
	dw $E000,$E000,$E000,$E3F0,$E091,$E04F,$E020,$8000,$E000,$8002,$E000,$8002,$E3F0,$E3F0

%FREE_BYTES(NULLROM, 717, $FF)
else
	dw $1530,$5520,$2900,$A960,$C970,$AD82,$CD92,$B9A0,$D9B0,$2D40,$4D50,$2007,$0025,$1C15,$E000,$4510
	dw $6D10,$1530,$5520,$2900,$2D40,$4D50,$2007,$0025,$1C15,$E000,$4510,$6D10,$6100,$1530,$5520,$2900
	dw $A960,$C970,$AD82,$CD92,$B9A0,$D9B0,$2D40,$4D50,$2007,$0025,$1C15,$E000,$4510,$6D10,$1530,$5520
	dw $2900,$2D40,$4D50,$2007,$0025,$1C15,$E000,$4510,$6D10,$6100,$1530,$5520,$2900,$A960,$C970,$AD82
	dw $CD92,$B9A0,$D9B0,$2D40,$4D50,$2007,$0025,$1C15,$E000,$4510,$6D10,$1530,$5520,$2900,$2D40,$4D50
	dw $2007,$0025,$1C15,$E000,$4510,$6D10,$6100,$1530,$5520,$2900,$A960,$C970,$AD82,$CD92,$B9A0,$D9B0
	dw $2D40,$4D50,$2007,$0025,$1C15,$E000,$4510,$6D10,$1530,$5520,$2900,$2D40,$4D50,$2007,$0025,$1C15
	dw $E3F0,$E091,$E04E,$E010,$E0A0,$A803,$BC00,$E000,$A802,$E000,$A400,$AC01,$E000,$A803,$E000,$A401
	dw $AC01,$BC08,$E000,$E3F0,$E046,$E050,$0003,$1003,$4019,$5019,$403F,$0826,$1826,$E000,$0C03,$4C19
	dw $1C03,$5C19,$403F,$0426,$1426,$E000,$0803,$4819,$403A,$0026,$5449,$9C45,$3060,$E000,$0C07,$8C13
	dw $1807,$9813,$803F,$0426,$3050,$6060,$E000,$2850,$0007,$8013,$1007,$9013,$803F,$5480,$E000,$0007
	dw $8013,$1407,$9413,$803F,$4480,$E3F0,$E011,$E04B,$E031,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016
	dw $4C16,$5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D,$901E,$8107,$8510,$9911,$E000,$181F,$2020
	dw $2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$8107
	dw $8510,$9910,$E000,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016,$4C16,$5417,$5C18,$6019,$641A,$681B
	dw $6C1C,$7816,$801D,$901E,$8107,$8510,$9911,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025
	dw $5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$8107,$8510,$9910,$E000,$0030,$1831,$2020
	dw $2432,$2C1B,$3023,$3833,$4034,$4835,$5436,$5837,$5C38,$6439,$683A,$6C3B,$703C,$743D,$783E,$943F
	dw $8107,$8911,$9910,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29
	dw $742A,$782B,$882C,$902D,$982F,$8107,$8510,$9910,$E000,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016
	dw $4C16,$5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D,$901E,$8107,$8510,$9911,$E000,$181F,$2020
	dw $2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$8107
	dw $8510,$9910,$E000,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016,$4C16,$5417,$5C18,$6019,$641A,$681B
	dw $6C1C,$7816,$801D,$901E,$8107,$8510,$9911,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025
	dw $5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$8107,$8510,$9910,$E3F0,$E011,$E04B,$E031
	dw $0010,$0C11,$1012,$1C13,$2414,$2815,$3016,$4C16,$5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D
	dw $901E,$8107,$8510,$9911,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428
	dw $6C29,$742A,$782B,$882C,$902D,$982F,$8107,$8510,$9910,$E000,$0010,$0C11,$1012,$1C13,$2414,$2815
	dw $3016,$4C16,$5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D,$901E,$8107,$8510,$9911,$E000,$181F
	dw $2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F
	dw $8107,$8510,$9910,$E000,$0030,$1831,$2020,$2432,$2C1B,$3023,$3833,$4034,$4835,$5436,$5837,$5C38
	dw $6439,$683A,$6C3B,$703C,$743D,$783E,$943F,$8107,$8911,$9910,$E000,$181F,$2020,$2421,$2C22,$3023
	dw $3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$8107,$8510,$9910,$0010
	dw $0C11,$1012,$1C13,$2414,$2815,$3016,$4C16,$5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D,$901E
	dw $8107,$8510,$9911,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29
	dw $742A,$782B,$882C,$902D,$982F,$8107,$8510,$9910,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016,$4C16
	dw $5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D,$901E,$8107,$8510,$9911,$E000,$181F,$2020,$2421
	dw $2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$8107,$8510
	dw $9910,$E3F0,$E04B,$E011,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016,$4C16,$5417,$5C18,$6019,$641A
	dw $681B,$6C1C,$7816,$801D,$901E,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27
	dw $6428,$6C29,$742A,$782B,$882C,$902D,$982F,$E000,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016,$4C16
	dw $5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D,$901E,$E000,$0030,$1831,$2020,$2432,$2C1B,$3023
	dw $3833,$4034,$4835,$5436,$5837,$5C38,$6439,$683A,$6C3B,$703C,$743D,$783E,$943F,$E000,$181F,$2020
	dw $2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$E000
	dw $181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D
	dw $982F,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B
	dw $882C,$902D,$982F,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29
	dw $742A,$782B,$882C,$902D,$982F,$E3F0,$E091,$E045,$E010,$8820,$B810,$7C00,$E000,$5890,$48A0,$E000
	dw $98B0,$E000,$A410,$6800,$5CC0,$E000,$E000,$A010,$6400,$90D0,$E000,$A410,$6800,$5CC0,$E000,$E000
	dw $A010,$6400,$90D0,$E3F0,$E091,$E070,$E048,$E020,$6900,$8163,$8970,$9180,$9510,$9920,$9D30,$A193
	dw $B1A0,$B572,$E000,$81B0,$85D0,$8962,$9580,$A1C0,$A593,$B5A0,$B961,$6830,$7010,$9830,$E000,$6910
	dw $6D21,$7530,$79B0,$7DD0,$81B0,$85D0,$8973,$99C0,$9D90,$A1C0,$A596,$5C30,$E000,$6160,$6580,$6910
	dw $6D22,$7930,$8190,$85A0,$8974,$9D60,$A197,$4010,$E000,$8160,$8580,$9940,$9D50,$A190,$A5A0,$A980
	dw $B5B0,$B9F0,$BD70,$6010,$AC10,$E000,$8207,$A177,$E000,$8207,$A177,$E3F0,$E091,$E04E,$E010,$E0A0
	dw $A803,$BC00,$E000,$A802,$E000,$A400,$AC01,$E000,$A803,$E000,$A401,$E000,$A401,$AC01,$BC08,$E000
	dw $E3F0,$E046,$E050,$0007,$1007,$6017,$7017,$603F,$0826,$B890,$E000,$0005,$1005,$6017,$7017,$603F
	dw $0826,$B4A0,$E000,$0005,$6017,$6039,$7047,$4860,$A890,$3850,$E000,$1005,$7017,$683B,$6447,$5860
	dw $E000,$0005,$6017,$1005,$7017,$603F,$0826,$5860,$B890,$E000,$0005,$6017,$1005,$7017,$603F,$0826
	dw $5480,$E000,$603F,$4480,$5080,$E000,$603F,$4480,$5080,$E3F0,$E091,$E042,$E010,$B050,$B080,$E000
	dw $6C70,$6C90,$A4F3,$E000,$7460,$74B0,$AC40,$ACA0,$E000,$8060,$80B0,$A4F9,$E000,$E000,$9060,$4060
	dw $40C0,$B4F2,$E000,$3870,$38E0,$A4F4,$E3F0,$E091,$E042,$E010,$B050,$B080,$E000,$6C70,$6C90,$A4F3
	dw $E000,$7460,$74B0,$AC40,$ACA0,$E000,$8060,$80B0,$A4F9,$E000,$E000,$9060,$4060,$40C0,$B4F2,$E000
	dw $3870,$38E0,$A4F4,$E3F0,$E091,$E04E,$E010,$E0A0,$A803,$BC00,$E000,$A802,$E000,$A400,$AC01,$E000
	dw $A803,$E000,$A401,$AC01,$BC08,$E000,$E3F0,$E046,$E050,$0007,$1007,$6017,$7017,$603F,$0826,$B890
	dw $E000,$0005,$1005,$6017,$7017,$603F,$0826,$B4A0,$E000,$0005,$6017,$6039,$7047,$4860,$A890,$3850
	dw $E000,$1005,$7017,$683B,$6447,$5860,$E000,$0005,$6017,$1005,$7017,$603F,$0826,$5860,$B890,$E000
	dw $0005,$6017,$1005,$7017,$603F,$0826,$5480,$E000,$603F,$4480,$5080,$E000,$603F,$4480,$5080,$E3F0
	dw $E091,$E045,$E010,$8820,$B810,$7C00,$E000,$5890,$48A0,$E000,$98B0,$E000,$A410,$6800,$5CC0,$E000
	dw $E000,$A010,$6400,$90D0,$E000,$8820,$B810,$7C00,$E000,$5890,$48A0,$E000,$98B0,$E000,$A410,$6800
	dw $5CC0,$E000,$E000,$A010,$6400,$90D0,$E000,$A010,$6400,$90D0,$E000,$8820,$B810,$7C00,$E000,$5890
	dw $48A0,$E000,$98B0,$E000,$A410,$6800,$5CC0,$E3F0,$E012,$E060,$E050,$E043,$4510,$6D10,$6100,$1530
	dw $5520,$2900,$A960,$C970,$AD82,$CD92,$B9A0,$D9B0,$2D40,$4D50,$2007,$0025,$1C15,$E000,$4510,$6D10
	dw $1530,$5520,$2900,$2D40,$4D50,$2007,$0025,$1C15,$E000,$4510,$6D10,$6100,$1530,$5520,$2900,$A960
	dw $C970,$AD82,$CD92,$B9A0,$D9B0,$2D40,$4D50,$2007,$0025,$1C15,$E000,$4510,$6D10,$1530,$5520,$2900
	dw $2D40,$4D50,$2007,$0025,$1C15,$E000,$4510,$6D10,$6100,$1530,$5520,$2900,$A960,$C970,$AD82,$CD92
	dw $B9A0,$D9B0,$2D40,$4D50,$2007,$0025,$1C15,$E000,$4510,$6D10,$1530,$5520,$2900,$2D40,$4D50,$2007
	dw $0025,$1C15,$E000,$4510,$6D10,$6100,$1530,$5520,$2900,$A960,$C970,$AD82,$CD92,$B9A0,$D9B0,$2D40
	dw $4D50,$2007,$0025,$1C15,$E000,$4510,$6D10,$1530,$5520,$2900,$2D40,$4D50,$2007,$0025,$1C15,$E3F0
	dw $E090,$E04E,$E010,$E0A0,$A803,$BC00,$E000,$A802,$E000,$A400,$AC01,$E000,$A803,$E000,$A401,$AC01
	dw $BC08,$E000,$E3F0,$E046,$E050,$0003,$1003,$4019,$5019,$403F,$0826,$1826,$E000,$0003,$1003,$4019
	dw $5019,$403F,$0826,$1826,$E000,$0C03,$4C19,$1C03,$5C19,$403F,$0426,$1426,$E000,$0803,$4819,$403A
	dw $0026,$5449,$9C45,$3060,$E000,$0C07,$8C13,$1807,$9813,$803F,$0426,$3050,$6060,$E000,$2850,$0007
	dw $8013,$1007,$9013,$803F,$5480,$E000,$0007,$8013,$1407,$9413,$803F,$4480,$E000,$0007,$8013,$1407
	dw $9413,$803F,$4480,$E3F0,$E091,$E010,$E045,$A410,$6800,$5C20,$E000,$6C00,$E000,$4030,$5C40,$E000
	dw $5020,$9060,$E000,$A050,$8420,$7870,$E000,$4C80,$E000,$4090,$E000,$A050,$8420,$7870,$E000,$4C80
	dw $E000,$4090,$E3F0,$E091,$E070,$E048,$E020,$6900,$8163,$8970,$9180,$9510,$9920,$9D30,$A193,$B1A0
	dw $B572,$E000,$81B0,$85D0,$8962,$9580,$A1C0,$A593,$B5A0,$B961,$6830,$7010,$9830,$E000,$6910,$6D21
	dw $7530,$79B0,$7DD0,$81B0,$85D0,$8973,$99C0,$9D90,$A1C0,$A596,$5C30,$E000,$6160,$6580,$6910,$6D22
	dw $7930,$8190,$85A0,$8974,$9D60,$A197,$4010,$E000,$8160,$8580,$9940,$9D50,$A190,$A5A0,$A980,$B5B0
	dw $B9F0,$BD70,$6010,$AC10,$E000,$8207,$A177,$E000,$8207,$A177,$E3F0,$E091,$E010,$E0B0,$E0C0,$9010
	dw $E000,$8800,$B010,$A425,$E000,$6810,$B420,$BC2F,$E000,$8810,$B800,$E000,$A800,$9810,$A420,$E000
	dw $6800,$A420,$B420,$BC2F,$E000,$6810,$BC20,$E000,$E3F0,$E046,$E050,$0007,$1007,$6017,$7017,$603F
	dw $0826,$B890,$E000,$0005,$1005,$6017,$7017,$603F,$0826,$B490,$E000,$0005,$6017,$6039,$7047,$4860
	dw $A890,$3850,$E000,$1005,$7017,$683B,$6447,$5860,$E000,$0005,$6017,$1005,$7017,$603F,$0826,$5860
	dw $B890,$E000,$0005,$6017,$1005,$7017,$603F,$0826,$E000,$603F,$4480,$5080,$E000,$603F,$4480,$5080
	dw $E3F0,$E011,$E04B,$E031,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016,$4C16,$5417,$5C18,$6019,$641A
	dw $681B,$6C1C,$7816,$801D,$901E,$8107,$8510,$9911,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024
	dw $5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$8107,$8510,$9910,$E000,$0010,$0C11
	dw $1012,$1C13,$2414,$2815,$3016,$4C16,$5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D,$901E,$8107
	dw $8510,$9911,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A
	dw $782B,$882C,$902D,$982F,$8107,$8510,$9910,$E000,$0030,$1831,$2020,$2432,$2C1B,$3023,$3833,$4034
	dw $4835,$5436,$5837,$5C38,$6439,$683A,$6C3B,$703C,$743D,$783E,$943F,$8107,$8911,$9910,$E000,$181F
	dw $2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F
	dw $8107,$8510,$9910,$E000,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016,$4C16,$5417,$5C18,$6019,$641A
	dw $681B,$6C1C,$7816,$801D,$901E,$8107,$8510,$9911,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024
	dw $5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$8107,$8510,$9910,$E000,$0010,$0C11
	dw $1012,$1C13,$2414,$2815,$3016,$4C16,$5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D,$901E,$8107
	dw $8510,$9911,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A
	dw $782B,$882C,$902D,$982F,$8107,$8510,$9910,$E000,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016,$4C16
	dw $5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D,$901E,$8107,$8510,$9911,$E3F0,$E011,$E04B,$E031
	dw $0010,$0C11,$1012,$1C13,$2414,$2815,$3016,$4C16,$5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D
	dw $901E,$8107,$8510,$9911,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428
	dw $6C29,$742A,$782B,$882C,$902D,$982F,$8107,$8510,$9910,$E000,$0010,$0C11,$1012,$1C13,$2414,$2815
	dw $3016,$4C16,$5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D,$901E,$8107,$8510,$9911,$E000,$181F
	dw $2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F
	dw $8107,$8510,$9910,$E000,$0030,$1831,$2020,$2432,$2C1B,$3023,$3833,$4034,$4835,$5436,$5837,$5C38
	dw $6439,$683A,$6C3B,$703C,$743D,$783E,$943F,$8107,$8911,$9910,$E000,$181F,$2020,$2421,$2C22,$3023
	dw $3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$8107,$8510,$9910,$0010
	dw $0C11,$1012,$1C13,$2414,$2815,$3016,$4C16,$5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D,$901E
	dw $8107,$8510,$9911,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29
	dw $742A,$782B,$882C,$902D,$982F,$8107,$8510,$9910,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016,$4C16
	dw $5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D,$901E,$8107,$8510,$9911,$E000,$181F,$2020,$2421
	dw $2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$8107,$8510
	dw $9910,$E3F0,$E04B,$E011,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016,$4C16,$5417,$5C18,$6019,$641A
	dw $681B,$6C1C,$7816,$801D,$901E,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27
	dw $6428,$6C29,$742A,$782B,$882C,$902D,$982F,$E000,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016,$4C16
	dw $5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D,$901E,$E000,$0030,$1831,$2020,$2432,$2C1B,$3023
	dw $3833,$4034,$4835,$5436,$5837,$5C38,$6439,$683A,$6C3B,$703C,$743D,$783E,$943F,$E000,$181F,$2020
	dw $2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$E000
	dw $181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D
	dw $982F,$E000,$0030,$1831,$2020,$2432,$2C1B,$3023,$3833,$4034,$4835,$5436,$5837,$5C38,$6439,$683A
	dw $6C3B,$703C,$743D,$783E,$943F,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025,$5826,$5C27
	dw $6428,$6C29,$742A,$782B,$882C,$902D,$982F,$E000,$181F,$2020,$2421,$2C22,$3023,$3820,$4024,$5025
	dw $5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$0010,$0C11,$1012,$1C13,$2414,$2815,$3016
	dw $4C16,$5417,$5C18,$6019,$641A,$681B,$6C1C,$7816,$801D,$901E,$E000,$181F,$2020,$2421,$2C22,$3023
	dw $3820,$4024,$5025,$5826,$5C27,$6428,$6C29,$742A,$782B,$882C,$902D,$982F,$E3F0,$E050,$E046,$0005
	dw $1405,$6017,$7417,$603F,$0826,$5C60,$E000,$0005,$1405,$6017,$7417,$603F,$0826,$5C60,$E000,$0807
	dw $1C07,$6817,$7C17,$603F,$1026,$E000,$1007,$7017,$603F,$7C47,$0426,$E000,$0426,$7435,$7047,$5860
	dw $B890,$E000,$0C07,$1C07,$6C17,$7C17,$603F,$0426,$5080,$B490,$E000,$603F,$7C47,$0426,$4C80,$E000
	dw $7435,$7047,$2450,$5480,$E000,$7017,$8017,$603F,$4090,$5090,$4480,$5480,$A0B0,$E3F0,$E091,$E010
	dw $E045,$A410,$6800,$5C20,$E000,$6C00,$E000,$4030,$5C40,$E000,$5020,$9060,$E000,$A050,$8420,$7870
	dw $E000,$4C80,$E000,$4090,$E3F0,$E091,$E010,$E045,$8420,$7470,$E000,$4880,$5C90,$E000,$E000,$40C0
	dw $E000,$4090,$E000,$4830,$E000,$04E0,$E3F0,$E091,$E010,$E04C,$E080,$A010,$A420,$B010,$B420,$BC10
	dw $A850,$E000,$A020,$A810,$AC20,$B810,$BC20,$B050,$4870,$E000,$A020,$A810,$AC20,$B410,$B820,$7C80
	dw $E000,$AC10,$B020,$B810,$BC20,$E000,$A410,$A820,$B010,$B420,$BC50,$9090,$E000,$A810,$AC20,$B410
	dw $B820,$E000,$A010,$A420,$B010,$B420,$BC10,$A860,$E000,$A020,$AC10,$B020,$B810,$BC20,$A460,$E3F0
	dw $E012,$E050,$E044,$A0A0,$2010,$2800,$4C30,$5830,$A0A0,$2010,$2800,$4C30,$5830,$E000,$A0A0
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_E|!ROM_SMAS_J1) != $00
	dw $4430
else
	dw $4830
endif
	dw $3010,$3800,$5C30,$E000,$A0A0,$4830,$5430,$E000,$A0A0,$2010,$2800,$5020,$5850,$E000,$A0A0,$4820
	dw $5050,$5820,$E000,$A0A0,$4450,$2C00,$94D0,$E000,$A0A0,$2000,$4840,$5440,$3C00,$E000,$A0A0,$2010
	dw $4830,$7470,$5C20,$E000,$A0A0,$2410,$8CC0,$3010,$5820,$E000,$A0A0,$4050,$5050,$4880,$5820,$E000
	dw $A0A0,$2400,$4C20,$5820,$E000,$A0A0,$4050,$5050,$4880,$5820,$E000,$A0A0,$2400,$4C20,$5820,$E000
	dw $A0A0,$4450,$2C00,$94D0,$E000,$A0A0,$2000,$4840,$5440,$3C00,$E3F0,$E091,$E070,$E048,$E020,$6900
	dw $8163,$8970,$9180,$9510,$9920,$9D30,$A193,$B1A0,$B572,$E000,$81B0,$85D0,$8962,$9580,$A1C0,$A593
	dw $B5A0,$B961,$9830,$E000,$81B0,$85D0,$8965,$A1C0,$A596,$E000,$8167,$A197,$E000,$8160,$8580,$9940
	dw $9D50,$A190,$A5A0,$A980,$B5B0,$B9F0,$BD70,$6010,$AC10,$E000,$8207,$A177,$E000,$8207,$A177,$E3F0
	dw $E091,$E070,$E048,$E020,$6100,$8562,$8170,$9180,$9510,$9920,$9D30,$A193,$B1A0,$B572,$E000,$81B0
	dw $85D0,$8962,$9580,$A1C0,$A593,$B5A0,$B961,$6430,$9830,$E000,$6D10,$7120,$7530,$79B0,$7DD0,$85B0
	dw $89D0,$8D72,$99C0,$9D90,$A160,$A5C0,$A995,$5C30,$E000,$6160,$6580,$6910,$6D22,$7930,$8190,$85A0
	dw $8974,$9D60,$A197,$4010,$E000,$8160,$8580,$9940,$9D50,$A190,$A5A0,$A980,$B5B0,$B9F0,$BD70,$6010
	dw $AC10,$E000,$8207,$A177,$E000,$8207,$A177,$E3F0,$E091,$E046,$E010,$E000,$E000,$E000,$E000,$E000
	dw $E000,$E3F0,$E091,$E070,$E048,$E020,$6900,$8163,$8970,$9180,$9510,$9920,$9D30,$A193,$B1A0,$B572
	dw $E000,$81B0,$85D0,$8962,$9580,$A1C0,$A593,$B5A0,$B961,$6830,$7010,$9830,$E000,$6910,$6D21,$7530
	dw $79B0,$7DD0,$81B0,$85D0,$8973,$99C0,$9D90,$A1C0,$A596,$5C30,$E000,$6160,$6580,$6910,$6D22,$7930
	dw $8190,$85A0,$8974,$9D60,$A197,$4010,$E000,$8160,$8580,$9940,$9D50,$A190,$A5A0,$A980,$B5B0,$B9F0
	dw $BD70,$6010,$AC10,$E000,$8207,$A177,$E000,$8207,$A177,$E3F0,$E3F0,$E3F0,$E3F0,$E3F0,$E3F0,$E3F0
	dw $E3F0,$E3F0,$E3F0,$E3F0,$E3F0,$E3F0,$E3F0,$E3F0,$E3F0,$E3F0,$E041,$E012,$2800,$E000,$3000,$E000
	dw $3800,$E000,$E000,$2800,$E000,$2800,$E3F0,$E041,$E012,$2800,$E000,$2800,$E000,$3800,$E000,$E000
	dw $2800,$E000,$2800,$E3F0,$E041,$E012,$3800,$E000,$3800,$E000,$E000,$2800,$E000,$E000,$E3F0,$E091
	dw $E042,$E010,$2470,$24E0,$E3F0,$E091,$E042,$E010,$E000,$2470,$24E0,$E3F0,$E010,$E041,$2800,$E000
	dw $E000,$E000,$2C00,$E3F0,$E010,$E041,$2800,$E000,$E000,$2C00,$E3F0,$E010,$E041,$2800,$E000,$E000
	dw $2C00,$E3F0,$E091,$E010,$E041,$E000,$E000,$E000,$E000,$E000,$E000,$E000,$E000,$E000,$E000,$E000
	dw $E000,$E000,$E000,$E000

if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMBLL_J) != $00
	dw $E3F0,$E091,$E042,$E013,$E04D,$E000,$E000,$E000,$E000,$E000,$E000,$E000,$E000,$E000,$E000,$E000
	dw $E000,$E000,$E3F0,$E091,$E04F,$E020,$8000,$E000,$8002,$E000,$8002,$E3F0,$E3F0

%FREE_BYTES(NULLROM, 893, $FF)
else
	dw $E3F0,$E091,$E042,$E013,$E04D,$E000,$E000,$E000,$E000,$E000,$E000,$E000,$E000,$E000,$E000,$E3F0
	dw $E091,$E04F,$E020,$8000,$E000,$8002,$E000,$8002,$E3F0,$E3F0

%FREE_BYTES(NULLROM, 899, $FF)
endif
endif

;--------------------------------------------------------------------

if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMBLL_J) != $00
CODE_0D96A8:
	LDA.w !REGISTER_HVBlankFlagsAndJoypadStatus
	LSR
	BCS.b CODE_0D96A8
	STZ.w !REGISTER_JoypadSerialPort1
	LDA.l !SRAM_SMAS_Global_Controller1PluggedInFlag
	TAX
	LDA.w !REGISTER_Joypad1Lo,x
	STA.w !RAM_SMBLL_Global_ControllerHold2
	TAY
	EOR.w !RAM_SMBLL_Global_P1CtrlDisableHi
	AND.w !RAM_SMBLL_Global_ControllerHold2
	STA.w !RAM_SMBLL_Global_ControllerPress2
	STY.w !RAM_SMBLL_Global_P1CtrlDisableHi
	LDA.w !REGISTER_Joypad1Hi,x
	STA.w !RAM_SMBLL_Global_ControllerHold1
	TAY
	EOR.w !RAM_SMBLL_Global_P1CtrlDisableLo
	AND.w !RAM_SMBLL_Global_ControllerHold1
	STA.w !RAM_SMBLL_Global_ControllerPress1
	STY.w !RAM_SMBLL_Global_P1CtrlDisableLo
	RTL
endif

;--------------------------------------------------------------------

CODE_0FD000:
	PHB
	PHK
	PLB
	LDA.l !SRAM_SMAS_Global_ControllerTypeX
	BNE.b CODE_0FD01B
	LDA.w $0FF8
	AND.b #$C0
	TSB.w $0FF4
	LDA.w $0FFA
	AND.b #$C0
	TSB.w $0FF6
	BRA.b CODE_0FD04F

CODE_0FD01B:
	LDA.w $0FF4
	AND.b #$80
	LSR
	TSB.w $0FF4
	LDA.w $0FF8
	AND.b #$C0
	STA.b $00
	LDA.w $0FF4
	AND.b #$7F
	ORA.b $00
	STA.w $0FF4
	LDA.w $0FF6
	AND.b #$80
	LSR
	TSB.w $0FF6
	LDA.w $0FFA
	AND.b #$C0
	STA.b $00
	LDA.w $0FF6
	AND.b #$7F
	ORA.b $00
	STA.w $0FF6
CODE_0FD04F:
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0FD051:
	LDA.w $0F03
	BNE.b CODE_0FD096
	LDA.l $7FFB00
	STA.w $075F
	STA.w $0766
	LDA.l $7FFB01
	STA.w $075C
	STA.w $0763
	LDA.l $7FFB02
	BPL.b CODE_0FD071
	INC
CODE_0FD071:
	STA.w $0760
	STA.w $0767
	LDA.l $7FFB03
	STA.w $075A
	LDA.l $7FFB04
	STA.w !RAM_SMBLL_Level_NoWorld9Flag
CODE_0FD085:
	PHX
	LDX.b #$00
CODE_0FD088:
	LDA.l !SRAM_SMBLL_Global_TopScoreMillionsDigit,x
	STA.w !RAM_SMBLL_TitleScreen_TopScoreMillionsDigit,x
	INX
	CPX.b #$06
	BNE.b CODE_0FD088
	PLX
	RTL

CODE_0FD096:
	LDA.l !SRAM_SMAS_Global_InitialSelectedLevel
	STA.w $0760
	LDA.w $0E24
	STA.w $075C
	LDA.b #$02
	STA.w $075A
	STZ.w $075E
	STZ.w !RAM_SMBLL_Level_NoWorld9Flag
	PHX
	LDX.b #$00
CODE_0FD0B1:
	STZ.w $07CE,x
	INX
	CPX.b #$06
	BNE.b CODE_0FD0B1
	PLX
	RTL

;--------------------------------------------------------------------

CODE_0FD0BB:
	PHX
	PHY
	LDA.w $0369
	BEQ.b CODE_0FD0FB
	LDY.w $0B46,x
	LDX.b #$00
CODE_0FD0C7:
	LDA.w $0900,y
	STA.w $0800,x
	TYA
	AND.b #$03
	CMP.b #$01
	BNE.b CODE_0FD0E5
	LDA.w $0800,x
	CMP.b #$F0
	BCC.b CODE_0FD0E5
	LDA.b #$F0
	STA.w $0800,x
	LDA.b #$00
	STA.w $0D00,y
CODE_0FD0E5:
	LDA.w $0D00,y
	STA.w $0C00,x
	LDA.b #$00
	STA.w $0D00,y
	LDA.b #$F0
	STA.w $0900,y
	INY
	INX
	CPX.b #$20
	BNE.b CODE_0FD0C7
CODE_0FD0FB:
	LDX.b #$00
	STZ.b $E7
CODE_0FD0FF:
	LDA.w $0300,x
	BEQ.b CODE_0FD10E
	JSR.w CODE_0FD116
	LDA.b $E7
	CLC
	ADC.b #$20
	STA.b $E7
CODE_0FD10E:
	INX
	CPX.b #$0D
	BCC.b CODE_0FD0FF
	PLY
	PLX
	RTS

;--------------------------------------------------------------------

CODE_0FD116:
	LDA.b $9E
	INC
	STA.w $02FC
	PHX
	LDY.w $030D,x
	STY.b $E6
	LDA.w DATA_0FD215,y
	CLC
	ADC.b #$A0
	STA.b $E4
	LDA.w DATA_0FD215+$01,y
	CLC
	ADC.b #$A0
	STA.b $E5
	LDY.b $E7
	LDA.w $031A,x
	JSR.w CODE_0FD1BB
	LDA.w $031A,x
	CLC
	ADC.b #$08
	JSR.w CODE_0FD1BB
	LDY.b $E7
	LDA.b $E4
	JSR.w CODE_0FD1A5
	TYA
	CLC
	ADC.b #$10
	TAY
	LDA.b $E5
	JSR.w CODE_0FD1A5
	LDX.b $E6
	CPX.b #$04
	BCS.b CODE_0FD15E
	LDA.b #$22
	BRA.b CODE_0FD160

CODE_0FD15E:
	LDA.b #$23
CODE_0FD160:
	LDY.b $E7
	INY
	INY
	INY
	PHA
	JSR.w CODE_0FD1BB
	PLA
	JSR.w CODE_0FD1BB
	LDY.b $E7
	TXA
	ASL
	ASL
	ASL
	TAX
	LDA.b #$08
	STA.b $E8
CODE_0FD178:
	LDA.w DATA_0FD1CD,x
	STA.w $0902,y
	INY
	INY
	INY
	INY
	INX
	DEC.b $E8
	BNE.b CODE_0FD178
	PLX
	DEC.w $0327,x
	LDA.w $0327,x
	BNE.b CODE_0FD1A4
	LDA.b #$03
	STA.w $0327,x
	INC.w $030D,x
	LDA.w $030D,x
	AND.b #$0F
	CMP.b #$09
	BNE.b CODE_0FD1A4
	STZ.w $0300,x
CODE_0FD1A4:
	RTS

CODE_0FD1A5:
	STA.w $0901,y
	CLC
	ADC.b #$08
	STA.w $0905,y
	CLC
	ADC.b #$08
	STA.w $0909,y
	CLC
	ADC.b #$08
	STA.w $090D,y
	RTS

CODE_0FD1BB:
	STA.w $0900,y
	STA.w $0904,y
	STA.w $0908,y
	STA.w $090C,y
	TYA
	CLC
	ADC.b #$10
	TAY
	RTS

DATA_0FD1CD:
	db $10,$20,$FC,$FC,$11,$21,$FC,$FC
	db $10,$20,$FC,$FC,$11,$21,$FC,$FC
	db $12,$22,$FC,$FC,$13,$23,$FC,$FC
	db $14,$24,$16,$FC,$15,$25,$17,$FC
	db $4C,$5C,$4E,$5E,$4D,$5D,$4F,$5F
	db $8C,$9C,$8E,$9E,$8D,$9D,$8F,$9F
	db $AC,$BC,$AE,$BE,$AD,$BD,$AF,$BF
	db $AC,$BC,$AE,$BE,$AD,$BD,$AF,$BF
	db $AC,$BC,$AE,$BE,$AD,$BD,$AF,$BF

DATA_0FD215:
	db $00,$00,$01,$03,$06,$0A,$0F,$14
	db $1C,$24,$3C

;--------------------------------------------------------------------

DATA_0FD220:
	db $0E,$0E,$0E,$66,$66,$64,$64,$64
	db $66,$66

CODE_0FD22A:
	PHB
	PHK
	PLB
	PHY
	LDA.w $0B46,x
	CLC
	ADC.b #$04
	TAY
	LDA.b $47,x
	CMP.b #$02
	BNE.b CODE_0FD23D
	LDA.b #$41
CODE_0FD23D:
	EOR.b #$2B
	STA.w $0903,y
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$08
	BEQ.b CODE_0FD257
	LDA.w $0EA2,x
	CMP.b #$0A
	BCS.b CODE_0FD257
	LDA.w $0903,y
	EOR.b #$20
	STA.w $0903,y
CODE_0FD257:
	LDA.w $0F4F,x
	LSR
	LSR
	AND.b #$0F
	STA.b $E4
	LDA.b $29,x
	AND.b #$20
	BNE.b CODE_0FD26C
	LDA.b $E4
	CMP.b #$09
	BCC.b CODE_0FD26F
CODE_0FD26C:
	STZ.w $0F4F,x
CODE_0FD26F:
	LDA.b $0F
	CMP.b #$09
	BCS.b CODE_0FD27D
	LDA.w $0E67
	BNE.b CODE_0FD27D
	INC.w $0F4F,x
CODE_0FD27D:
	LDX.b $E4
	LDA.w $03AE
	STA.w $0900,y
	LDA.w $03B9
	CLC
	ADC.b #$08
	STA.w $0901,y
	LDA.w DATA_0FD220,x
	STA.w $0902,y
	LDA.b #$02
	STA.w $0D00,y
	LDX.b $9E
	LDA.w $021A,x
	STA.b $E4
	LDA.b $79,x
	STA.b $E5
	REP.b #$20
	LDA.b $E4
	SEC
	SBC.b $42
	STA.b $E4
	SEP.b #$20
	LDA.b $E5
	BEQ.b CODE_0FD2B8
	LDA.b #$03
	STA.w $0D00,y
CODE_0FD2B8:
	LDA.w $03B9
	CMP.b #$E0
	BCS.b CODE_0FD2C5
	LDA.b $BC,x
	CMP.b #$01
	BEQ.b CODE_0FD2CA
CODE_0FD2C5:
	LDA.b #$F0
	STA.w $0901,y
CODE_0FD2CA:
	PLY
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0FD2CD:
	LDA.w $03FA
	BEQ.b CODE_0FD2FE
	LDA.w $0219
	STA.b $E4
	LDA.w $0078
	STA.b $E5
	STZ.w $02FE
	REP.b #$20
	LDA.w $02FD
	CLC
	ADC.w $03CC
	CMP.b $E4
	BCC.b CODE_0FD2F1
	SEP.b #$20
	LDA.b #$01
	RTL

CODE_0FD2F1:
	SEP.b #$20
	STZ.w $03FA
	LDA.b #$34
	STA.w $02F7
	STA.w $03CF
CODE_0FD2FE:
	LDA.w $03CF
	BEQ.b CODE_0FD32E
	CMP.b #$28
	BCC.b CODE_0FD30B
	LDA.b #$F8
	BRA.b CODE_0FD30D

CODE_0FD30B:
	LDA.b #$F0
CODE_0FD30D:
	STA.w $03CE
	LDA.w $0754
	BEQ.b CODE_0FD31E
	LDA.w $03CE
	SEC
	SBC.b #$10
	STA.w $03CE
CODE_0FD31E:
	DEC.w $03CF
	LDA.w $03CF
	BNE.b CODE_0FD326
CODE_0FD326:
	STZ.b $5D
	STZ.w $0705
	LDA.b #$00
	RTL

CODE_0FD32E:
	LDA.b #$01
	STA.w $0723
	STA.w $0254
	JSR.w CODE_0FD354
	STZ.w $03CE
	LDA.w $03FB
	BEQ.b CODE_0FD347
	DEC.w $03FB
	LDA.b #$01
	RTL

CODE_0FD347:
	LDA.w $0746
	CMP.b #$01
	BCS.b CODE_0FD351
	INC.w $0746
CODE_0FD351:
	LDA.b #$00
	RTL

;--------------------------------------------------------------------

CODE_0FD354:
	LDX.b #$00
	REP.b #$20
CODE_0FD358:
	LDA.w $11E0,x
	STA.b $E4
	AND.w #$7C00
	BEQ.b CODE_0FD36A
	LDA.b $E4
	SEC
	SBC.w #$0400
	STA.b $E4
CODE_0FD36A:
	LDA.b $E4
	AND.w #$03E0
	BEQ.b CODE_0FD379
	LDA.b $E4
	SEC
	SBC.w #$0020
	STA.b $E4
CODE_0FD379:
	LDA.b $E4
	AND.w #$001F
	BEQ.b CODE_0FD382
	DEC.b $E4
CODE_0FD382:
	LDA.b $E4
	STA.w $11E0,x
	INX
	INX
	CPX.b #$20
	BNE.b CODE_0FD358
	SEP.b #$20
	INC.w !RAM_SMBLL_Global_UpdateEntirePaletteFlag
	RTS

;--------------------------------------------------------------------

DATA_0FD393:
	db $90,$80,$70,$90

DATA_0FD397:
	db $FF,$01

CODE_0FD399:
	PHX
	PHY
	LDY.w $0368
	LDX.w $0F4E
	LDA.w $021A,y
	SEC
	SBC.b #$0E
	STA.w $021A,x
	LDA.w $0079,y
	STA.b $79,x
	LDA.w $0238,y
	CLC
	ADC.b #$08
	STA.w $0238,x
	LDA.w $07B7,x
	AND.b #$03
	STA.w $041D,x
	TAY
	LDA.w DATA_0FD393,y
	LDY.b #$00
	CMP.w $0238,x
	BCC.b CODE_0FD3CC
	INY
CODE_0FD3CC:
	LDA.w DATA_0FD397,y
	STA.w $043D,x
	STZ.w $06CB
	LDA.b #$08
	STA.w $0490,x
	LDA.b #$01
	STA.b $BC,x
	STA.b $10,x
	LSR
	STA.w $0402,x
	STA.b $29,x
	PLY
	PLX
	RTS

;--------------------------------------------------------------------

CODE_0FD3E9:
	PHB
	PHK
	PLB
	LDY.w $0B46,x
	LDA.w $03AE
	STA.w $0900,y
	CLC
	ADC.b #$08
	STA.w $0904,y
	LDA.w $03B9
	STA.w $0901,y
	STA.w $0905,y
	LDA.b #$21
	STA.w $0903,y
	STA.w $0907,y
	LDA.w $0F58,x
	LSR
	LSR
	LSR
	CMP.b #$03
	BNE.b CODE_0FD439
	STZ.w $0F36,x
	LDA.b #$01
	STA.w $0F36,x
	LDA.w $021A,x
	CLC
	ADC.b #$10
	STA.w $0F62,x
	LDA.b $79,x
	ADC.b #$00
	STA.w $0F6B,x
	LDA.w $03B9
	STA.w $0F74,x
	LDA.b #$00
	STA.w $0F58,x
CODE_0FD439:
	TAX
	LDA.w DATA_0FD4CA,x
	STA.w $0902,y
	INC
	STA.w $0906,y
	STX.b $E4
	LDX.b $9E
	LDA.w $021A,x
	STA.b $E5
	LDA.b $79,x
	STA.b $E6
	REP.b #$20
	LDA.b $E5
	SEC
	SBC.b $42
	STA.b $E5
	CLC
	ADC.w #$0008
	STA.b $E7
	SEP.b #$20
	LDA.b #$02
	STA.b $E9
	LDA.b $E6
	BEQ.b CODE_0FD46C
	LDA.b #$01
CODE_0FD46C:
	ORA.b $E9
	STA.w $0D00,y
	LDA.b $E8
	BEQ.b CODE_0FD477
	LDA.b #$01
CODE_0FD477:
	ORA.b $E9
	STA.w $0D04,y
	LDA.w $0F36,x
	BEQ.b CODE_0FD4C3
	LDA.w $0F62,x
	STA.b $E5
	LDA.w $0F6B,x
	STA.b $E6
	REP.b #$20
	LDA.b $E5
	SEC
	SBC.b $42
	STA.b $E5
	SEP.b #$20
	LDA.b $E5
	STA.w $0908,y
	LDA.w $0F58,x
	LSR
	CLC
	ADC.b #$04
	CLC
	ADC.w $0F74,x
	STA.w $0909,y
	LDX.b $E4
	LDA.w DATA_0FD4CD,x
	STA.w $090A,y
	LDA.b #$28
	STA.w $090B,y
	STZ.b $E9
	LDA.b $E6
	BEQ.b CODE_0FD4BE
	LDA.b #$01
CODE_0FD4BE:
	ORA.b $E9
	STA.w $0D08,y
CODE_0FD4C3:
	LDX.b $9E
	INC.w $0F58,x
	PLB
	RTL

DATA_0FD4CA:
	db $86,$A6,$89

DATA_0FD4CD:
	db $30,$31,$32,$06,$0A,$0E

;--------------------------------------------------------------------

CODE_0FD4D3:
	PHB
	PHK
	PLB
	LDY.b #$04
	STY.w $02FF
	LDA.w $03AE
	SEC
	SBC.b #$08
	STA.b $E4
	LDX.b #$00
CODE_0FD4E5:
	LDA.w DATA_0FD603,x
	CLC
	ADC.b $E4
	STA.w $0800,y
	LDA.w $03B9
	SEC
	SBC.b #$04
	STA.w $0801,y
	PHX
	LDA.b $09
	AND.b #$18
	STX.b $E5
	CLC
	ADC.b $E5
	TAX
	LDA.w DATA_0FD5E3,x
	STA.w $0803,y
	LDA.w DATA_0FD5C3,x
	STA.w $0802,y
	PLX
	INY
	INY
	INY
	INY
	INX
	CPX.b #$05
	BNE.b CODE_0FD4E5
	LDX.b $9E
	LDA.w $021A,x
	STA.b $E5
	LDA.b $79,x
	STA.b $E6
	REP.b #$20
	LDA.b $E5
	SEC
	SBC.w #$0008
	SEC
	SBC.b $42
	STA.b $E9
	CLC
	ADC.w #$0010
	STA.b $E8
	CLC
	ADC.w #$0004
	STA.b $DF
	CLC
	ADC.w #$0008
	STA.b $DD
	CLC
	ADC.w #$0004
	STA.b $E7
	CLC
	ADC.w #$0010
	STA.b $E6
	SEC
	SBC.w #$0010
	STA.b $E5
	SEP.b #$20
	LDA.b #$02
	STA.b $E4
	LDY.b #$04
	LDX.b #$05
CODE_0FD55E:
	LDA.b $E5,x
	BEQ.b CODE_0FD564
	LDA.b #$01
CODE_0FD564:
	ORA.b $E4
	STA.w $0C00,y
	INY
	INY
	INY
	INY
	DEX
	BNE.b CODE_0FD55E
	STZ.b $E4
	LDA.w $06CC
	BNE.b CODE_0FD58E
	LDA.b #$F0
	STA.w $0815
	LDA.b $DE
	BEQ.b CODE_0FD582
	LDA.b #$01
CODE_0FD582:
	ORA.b $E4
	STA.w $0C00
	LDA.b $DD
	STA.w $0800
	BRA.b CODE_0FD5A6

CODE_0FD58E:
	LDA.b #$F0
	STA.w $080D
	STA.w $0811
	LDA.b $E0
	BEQ.b CODE_0FD59C
	LDA.b #$01
CODE_0FD59C:
	ORA.b $E4
	STA.w $0C00
	LDA.b $DF
	STA.w $0800
CODE_0FD5A6:
	LDA.b $09
	AND.b #$10
	LSR
	LSR
	LSR
	LSR
	CLC
	ADC.w $03B9
	STA.w $0801
	LDA.b #$E7
	STA.w $0802
	LDA.b #$2C
	STA.w $0803
	LDX.b $9E
	PLB
	RTL

DATA_0FD5C3:
	db $40,$41,$41,$42,$42,$00,$00,$00
	db $60,$61,$61,$62,$62,$00,$00,$00
	db $42,$41,$41,$40,$40,$00,$00,$00
	db $62,$61,$61,$60,$60,$00,$00,$00

DATA_0FD5E3:
	db $2A,$6A,$6A,$2A,$2A,$00,$00,$00
	db $2A,$6A,$6A,$2A,$2A,$00,$00,$00
	db $6A,$2A,$2A,$6A,$6A,$00,$00,$00
	db $6A,$2A,$2A,$6A,$6A,$00,$00,$00

DATA_0FD603:
	db $00,$10,$20,$30,$20

;--------------------------------------------------------------------

DATA_0FD608:
	db $C0,$E0,$C4,$C2,$E2,$C5,$C6,$E6
	db $D4,$C8,$E8,$D5,$CA,$EA,$E4,$C8
	db $EC,$E5,$CC,$E0,$F4,$CE,$E2,$F5
	db $C0,$E0,$C4,$EE,$E2,$C5,$CC,$E0
	db $94,$A4,$E2,$95,$80,$A0,$84,$82
	db $A2,$85,$C2,$E2,$C5,$C0,$E0,$C4
	db $C8,$E8,$D5,$C6,$E6,$D4,$C8,$EC
	db $E5,$CA,$EA,$E4,$CE,$E2,$F5,$CC
	db $E0,$F4,$EE,$E2,$C5,$C0,$E0,$C4
	db $A4,$E2,$95,$CC,$E0,$94,$82,$A2
	db $85,$80,$A0,$84

DATA_0FD65C:
	db $00,$01,$01,$00,$02,$02,$03,$04
	db $05,$06

DATA_0FD666:
	db $08,$09

DATA_0FD668:
	db $EE,$EE,$EE,$00,$F6,$F6,$F6,$00
	db $EC,$EC,$EC,$00,$00

DATA_0FD675:
	db $00,$00,$E8,$E8,$E8,$00,$F2,$F2
	db $F2,$00,$FA,$FA,$FA

DATA_0FD682:
	db $EA,$EA,$EA,$00,$E5,$E5,$E5,$00
	db $E4,$E4,$E4,$00,$00

DATA_0FD68F:
	db $00,$00,$E8,$E8,$E8,$00,$ED,$ED
	db $ED,$00,$E5,$E5,$E5

DATA_0FD69C:
	db $A9,$B9,$E8,$00,$A9,$B9,$E8,$00
	db $A9,$B9,$E8,$00,$00

DATA_0FD6A9:
	db $00,$00,$A9,$B9,$E8,$00,$A9,$B9
	db $E8,$00,$A9,$B9,$E8

DATA_0FD6B6:
	db $27,$27,$26,$27,$27,$27,$26,$27
	db $27,$27,$26,$27,$27

DATA_0FD6C3:
	db $27,$27,$27,$27,$26,$27,$27,$27
	db $26,$27,$27,$27,$26

CODE_0FD6D0:
	PHX
	INC.w $03CA
	LDA.w $03CA
	CMP.b #$34
	BCS.b CODE_0FD738
	LSR
	LSR
	TAX
	LDA.w DATA_0FD668,x
	CLC
	ADC.w $03AE
	CLC
	ADC.b #$18
	STA.w $08F8
	LDA.w DATA_0FD675,x
	CLC
	ADC.w $03AE
	CLC
	ADC.b #$18
	STA.w $08FC
	LDA.w DATA_0FD682,x
	BNE.b CODE_0FD701
	LDA.b #$F0
	BRA.b CODE_0FD708

CODE_0FD701:
	CLC
	ADC.w $03B9
	CLC
	ADC.b #$10
CODE_0FD708:
	STA.w $08F9
	LDA.w DATA_0FD68F,x
	BNE.b CODE_0FD714
	LDA.b #$F0
	BRA.b CODE_0FD71B

CODE_0FD714:
	CLC
	ADC.b #$10
	CLC
	ADC.w $03B9
CODE_0FD71B:
	STA.w $08FD
	LDA.w DATA_0FD69C,x
	STA.w $08FA
	LDA.w DATA_0FD6A9,x
	STA.w $08FE
	LDA.w DATA_0FD6B6,x
	STA.w $08FB
	LDA.w DATA_0FD6C3,x
	STA.w $08FF
	BRA.b CODE_0FD73B

CODE_0FD738:
	STZ.w $03CB
CODE_0FD73B:
	PLX
	RTS

CODE_0FD73D:
	PHB
	PHK
	PLB
	LDA.w $03CB
	BEQ.b CODE_0FD748
	JSR.w CODE_0FD6D0
CODE_0FD748:
	LDA.w $0F4C
	BEQ.b CODE_0FD762
	LDY.w $014B
	CPY.b #$08
	BNE.b CODE_0FD771
	LDA.w $0F4C
	LSR
	LSR
	AND.b #$01
	TAY
	LDA.w DATA_0FD666,y
	TAY
	BRA.b CODE_0FD771

CODE_0FD762:
	LDA.w $0792,x
	BNE.b CODE_0FD76A
	STZ.w $014B
CODE_0FD76A:
	LDA.w $014B
	LSR
	LSR
	LSR
	TAY
CODE_0FD771:
	LDA.w DATA_0FD65C,y
	STA.w $014C
	LDA.w $0B46,x
	TAY
	LDA.w $03AE
	STA.w $0900,y
	STA.w $0904,y
	CLC
	ADC.b #$08
	STA.w $0908,y
	CLC
	ADC.b #$08
	STA.w $090C,y
	STA.w $0910,y
	STA.w $0914,y
	LDA.w $03B9
	STA.w $0901,y
	STA.w $090D,y
	CLC
	ADC.b #$10
	STA.w $0905,y
	STA.w $0911,y
	SEC
	SBC.b #$18
	STA.w $0909,y
	STA.w $0915,y
	LDA.b $47,x
	STA.b $DE
	CMP.b #$01
	BEQ.b CODE_0FD7BD
	LDA.b #$61
	BRA.b CODE_0FD7BF

CODE_0FD7BD:
	LDA.b #$21
CODE_0FD7BF:
	STA.w $0903,y
	STA.w $0907,y
	STA.w $090B,y
	STA.w $090F,y
	STA.w $0913,y
	STA.w $0917,y
	STX.b $9E
	LDA.w $014C
	ASL
	STA.b $DD
	ASL
	CLC
	ADC.b $DD
	TAX
	CLC
	ADC.b #$06
	STA.b $DD
	LDA.b $DE
	CMP.b #$01
	BEQ.b CODE_0FD7F4
	LDA.b $DD
	CLC
	ADC.b #$2A
	STA.b $DD
	SEC
	SBC.b #$06
	TAX
CODE_0FD7F4:
	LDA.w DATA_0FD608,x
	STA.w $0902,y
	LDA.b #$02
	STA.w $0D00,y
	INY
	INY
	INY
	INY
	INX
	CPX.b $DD
	BNE.b CODE_0FD7F4
	LDA.b #$00
	STA.w $0CFC,y
	STA.w $0CF0,y
	LDX.b $9E
	LDA.w $021A,x
	STA.b $E4
	LDA.b $79,x
	STA.b $E5
	REP.b #$20
	LDA.b $E4
	SEC
	SBC.b $42
	STA.b $E4
	CLC
	ADC.w #$0008
	STA.b $E6
	CLC
	ADC.w #$0008
	STA.b $E8
	CLC
	ADC.w #$0030
	STA.b $E2
	SEP.b #$20
	LDA.w $0B46,x
	TAY
	LDA.b $E3
	CMP.b #$FF
	BNE.b CODE_0FD848
	STZ.b $10,x
	STZ.b $29,x
	STZ.b !RAM_SMBLL_NorSpr_SpriteID,x
CODE_0FD848:
	LDA.b $E5
	BEQ.b CODE_0FD854
	LDA.b #$03
	STA.w $0D00,y
	STA.w $0D04,y
CODE_0FD854:
	LDA.b $E7
	BEQ.b CODE_0FD85D
	LDA.b #$01
	STA.w $0D08,y
CODE_0FD85D:
	LDA.b $E9
	BEQ.b CODE_0FD86C
	LDA.b #$01
	STA.w $0D0C,y
	STA.w $0D10,y
	STA.w $0D14,y
CODE_0FD86C:
	LDA.w $0F4C
	BNE.b CODE_0FD883
	STZ.w $0F4C
	INC.w $014B
	LDA.w $014B
	CMP.b #$30
	BCC.b CODE_0FD8A7
	STZ.w $014B
	BRA.b CODE_0FD8A7

CODE_0FD883:
	DEC.w $0F4C
	LDA.w $0F4C
	BNE.b CODE_0FD8A7
	LDA.w $014B
	CMP.b #$06
	BNE.b CODE_0FD8A4
	INC.w $014B
	LDA.b #$28
	STA.w $0F4C
	LDA.b #!Define_SMAS_Sound0060_BowserBreathFire
	STA.w !RAM_SMBLL_Global_SoundCh1
	JSR.w CODE_0FD399
	BRA.b CODE_0FD8A7

CODE_0FD8A4:
	STZ.w $014B
CODE_0FD8A7:
	LDA.w $0283
	BNE.b CODE_0FD8EB
	LDX.b $9E
	LDY.w $0B46,x
	LDX.b #$06
CODE_0FD8B3:
	LDA.w $0903,y
	ORA.b #$80
	STA.w $0903,y
	INY
	INY
	INY
	INY
	DEX
	BNE.b CODE_0FD8B3
	LDX.b $9E
	LDY.w $0B46,x
	LDA.w $0901,y
	CLC
	ADC.b #$08
	STA.w $0901,y
	STA.w $090D,y
	LDA.w $0905,y
	SEC
	SBC.b #$18
	STA.w $0905,y
	STA.w $0911,y
	LDA.w $0909,y
	CLC
	ADC.b #$20
	STA.w $0909,y
	STA.w $0915,y
CODE_0FD8EB:
	JSR.w CODE_0FD0BB
	PLB
	RTL

;--------------------------------------------------------------------

DATA_0FD8F0:
	db !Define_SMBLL_LevelMusic_Underwater
	db !Define_SMBLL_LevelMusic_Overworld
	db !Define_SMBLL_LevelMusic_Underground
	db !Define_SMBLL_LevelMusic_Castle
	db !Define_SMBLL_LevelMusic_BonusRoom
	db !Define_SMBLL_LevelMusic_EnterPipeCutscene

CODE_0FD8F6:
	PHB
	PHK
	PLB
	PHX
	LDA.w $0770
	BEQ.b CODE_0FD94C
	LDA.w $0752
	CMP.b #$02
	BEQ.b CODE_0FD913
	LDY.b #$05
	LDA.w $0710
	CMP.b #$06
	BEQ.b CODE_0FD91C
	CMP.b #$07
	BEQ.b CODE_0FD91C
CODE_0FD913:
	LDY.b $BA
	LDA.w $0743
	BEQ.b CODE_0FD91C
	LDY.b #$04
CODE_0FD91C:
	LDA.b $0F
	CMP.b #$04
	BEQ.b CODE_0FD943
	CMP.b #$05
	BEQ.b CODE_0FD943
	LDA.b $DB
	CMP.b #$39
	BEQ.b CODE_0FD939
	CMP.b #$3B
	BEQ.b CODE_0FD939
	CMP.b #$3D
	BEQ.b CODE_0FD939
	LDA.w DATA_0FD8F0,y
	BRA.b CODE_0FD93B

CODE_0FD939:
	LDA.b #!Define_SMBLL_LevelMusic_BonusRoom
CODE_0FD93B:
	LDX.w $0EDF
	BNE.b CODE_0FD943
	STA.w !RAM_SMBLL_Global_MusicCh1
CODE_0FD943:
	LDX.b $DB
	CPX.b #$07
	BNE.b CODE_0FD94C
	STA.w $0EDF
CODE_0FD94C:
	PLX
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0FD94F:
	PHB
	PHK
	PLB
	LDA.w $0770
	CMP.b #$02
	BEQ.b CODE_0FD978
	CMP.b #$01
	BNE.b CODE_0FD9B9
	LDA.w $0772
	CMP.b #$03
	BNE.b CODE_0FD9B9
	LDA.w $0E67
	BNE.b CODE_0FD9B9
	LDA.w !RAM_SMBLL_Global_ScreenDisplayRegisterMirror
	CMP.b #$0F
	BNE.b CODE_0FD9B9
	LDA.w $0777
	BEQ.b CODE_0FD97A
	DEC.w $0777
CODE_0FD978:
	PLB
	RTL

CODE_0FD97A:
	LDA.b $0F
	CMP.b #$02
	BEQ.b CODE_0FD9B9
	CMP.b #$03
	BEQ.b CODE_0FD9B9
	LDA.w $0B7A
	BNE.b CODE_0FD9B9
	LDA.w $0B75
	CMP.b #$02
	BCS.b CODE_0FD9B9
	LDA.w $0F8A
	BEQ.b CODE_0FD99A
	DEC.w $0F8A
	BRA.b CODE_0FD9B9

CODE_0FD99A:
	LDA.w $0B75
	BNE.b CODE_0FD9B9
	LDA.w $0FF6
	AND.b #$10
	BEQ.b CODE_0FD9B9
	LDA.b #$11
	STA.w $0777
	LDA.b #!Define_SMBLL_LevelMusic_LowerVolumeCommand
	STA.w !RAM_SMBLL_Global_MusicCh1
	LDA.b #!Define_SMAS_Sound0060_Pause1
	STA.w !RAM_SMBLL_Global_SoundCh1
	JSL.l CODE_0FDA18
CODE_0FD9B9:
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0FD9BB:
	INC.w $0B76
	LDA.b #SMBLL_PauseMenuGFX_Main>>16
	STA.w $0287
	REP.b #$20
	LDA.w #SMBLL_PauseMenuGFX_Main
	STA.w $0285
	LDA.w #SMBLL_PauseMenuGFX_End-SMBLL_PauseMenuGFX_Main
	STA.w $0288
	LDA.w #$7C00
	STA.w $028A
	SEP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_0FD9DA:
	INC.w $0B76
	LDA.b #SMBLL_UncompressedGFX_Sprite_GlobalTiles+$3800>>16
	STA.w $0287
	REP.b #$20
	LDA.w #SMBLL_UncompressedGFX_Sprite_GlobalTiles+$3800
	STA.w $0285
	LDA.w #$0800
	STA.w $0288
	LDA.w #$7C00
	STA.w $028A
	SEP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_0FD9F9:
	PHX
	PHY
	JSR.w CODE_0FDE85
	JSR.w CODE_0FDE22
	LDA.b #$22
	STA.w $1204
	LDA.b #$02
	STA.w $1205
	LDA.b #$15
	STA.w $1207
	LDA.b #$02
	STA.w $1208
	PLY
	PLX
	RTL

;--------------------------------------------------------------------

CODE_0FDA18:
	JSR.w CODE_0FDE85
	JSR.w CODE_0FDE22
	JSR.w CODE_0FDA4C
	JSR.w CODE_0FD9BB
	LDA.b #$01
	STA.w $0776
	STZ.w $0B77
	STZ.w $0B78
	STZ.w $0F8A
	RTL

;--------------------------------------------------------------------

CODE_0FDA33:
	PHB
	PHK
	PLB
	PHX
	PHY
	LDA.w $0B75
	ASL
	TAX
	JSR.w (DATA_0FDA44,x)
	PLY
	PLX
	PLB
	RTL

DATA_0FDA44:
	dw CODE_0FDD00
	dw CODE_0FDA6F
	dw CODE_0FDDFC
	dw CODE_0FDD6A

;--------------------------------------------------------------------

CODE_0FDA4C:
	REP.b #$20
	LDA.w #$0010
	STA.w $0B6B
	LDA.w #$0064
	STA.w $0B6D
	LDA.w #$00A4
	STA.w $0B6F
	LDA.w #$00C4
	STA.w $0B71
	LDA.w #$00D0
	STA.w $0B73
	SEP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_0FDA6F:
	JSR.w CODE_0FDC34
	LDA.w $0FF6
	STA.b $F2
	AND.b #$2C
	BEQ.b CODE_0FDAF3
	LDA.w $1680
	BEQ.b CODE_0FDAA2
	AND.b #$10
	CMP.b #$10
	BEQ.b CODE_0FDAA2
	LDA.b $F2
	AND.b #$20
	BEQ.b CODE_0FDA96
	LDA.w $0B77
	EOR.b #$02
CODE_0FDA91:
	STA.w $0B77
	BRA.b CODE_0FDABD

CODE_0FDA96:
	LDA.b $F2
	AND.b #$04
	LSR
	CMP.w $0B77
	BNE.b CODE_0FDA91
	BRA.b CODE_0FDAF3

CODE_0FDAA2:
	LDA.b $F2
	AND.b #$20
	BNE.b CODE_0FDADE
	LDA.b $F2
	AND.b #$08
	BNE.b CODE_0FDAC7
	INC.w $0B77
	LDA.w $0B77
	CMP.b #$03
	BCC.b CODE_0FDABD
	DEC.w $0B77
	BRA.b CODE_0FDAF3

CODE_0FDABD:
	LDA.b #!Define_SMAS_Sound0063_Coin
	STA.w !RAM_SMBLL_Global_SoundCh3
	STZ.w $0B78
	BRA.b CODE_0FDAF3

CODE_0FDAC7:
	DEC.w $0B77
	LDA.w $0B77
	BPL.b CODE_0FDAD4
	INC.w $0B77
	BRA.b CODE_0FDAF3

CODE_0FDAD4:
	LDA.b #!Define_SMAS_Sound0063_Coin
	STA.w !RAM_SMBLL_Global_SoundCh3
	STZ.w $0B78
	BRA.b CODE_0FDAF3

CODE_0FDADE:
	INC.w $0B77
	LDA.w $0B77
	CMP.b #$03
	BCC.b CODE_0FDAEB
	STZ.w $0B77
CODE_0FDAEB:
	LDA.b #!Define_SMAS_Sound0063_Coin
	STA.w !RAM_SMBLL_Global_SoundCh3
	STZ.w $0B78
CODE_0FDAF3:
	LDA.b #$4C
	STA.w $0800
	LDX.w $0B77
	LDA.w DATA_0FDB91,x
	STA.w $0801
	LDA.w $0B78
	AND.b #$10
	LSR
	LSR
	LSR
	LSR
	TAX
	LDA.w DATA_0FDB94,x
	STA.w $0802
	LDA.b #$21
	STA.w $0803
	LDA.b #$00
	STA.w $0C00
	INC.w $0B78
	LDA.b $F2
	AND.b #$10
	BEQ.b CODE_0FDB90
	LDA.b #!Define_SMBLL_LevelMusic_RestoreVolumeCommand
	STA.w !RAM_SMBLL_Global_MusicCh1
	STZ.w $0B78
	LDA.w $0B77
	BEQ.b CODE_0FDB4E
	LDA.b #$30
	STA.w $0F8A
	LDA.b #$02
	STA.w $0B75
	LDA.b #!Define_SMAS_Sound0060_SaveGame
	STA.w !RAM_SMBLL_Global_SoundCh1
	LDA.w $0B77
	CMP.b #$02
	BNE.b CODE_0FDB62
	LDA.b #!Define_SMBLL_LevelMusic_CopyOfMusicFade
	STA.w !RAM_SMBLL_Global_MusicCh1
	BRA.b CODE_0FDB62

CODE_0FDB4E:
	LDA.b #$10
	STA.w $0F8A
	LDA.b #$10
	STA.w $0B6B
	LDA.b #$02
	STA.w $0B75
	LDA.b #!Define_SMAS_Sound0060_Pause1
	STA.w !RAM_SMBLL_Global_SoundCh1
CODE_0FDB62:
	LDA.w $1680
	CMP.b #$10
	BNE.b CODE_0FDB82
	LDA.w $0B77
	CMP.b #$02
	BEQ.b CODE_0FDB82
	STZ.w $0776
	LDA.b #$0E
	STA.w $0772
	LDX.w $0B77
	BEQ.b CODE_0FDB81
	JSL.l SMBLL_SaveGame_Main
CODE_0FDB81:
	RTS

CODE_0FDB82:
	LDA.b #$20
	STA.w $0F8A
	LDA.w $0B77
	BEQ.b CODE_0FDB90
	JSL.l SMBLL_SaveGame_Main
CODE_0FDB90:
	RTS

;--------------------------------------------------------------------

DATA_0FDB91:
	db $50,$60,$70

DATA_0FDB94:
	db $D0,$DE

DATA_0FDB96:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMBLL_J) != $00
	db $AA,$AA,$0C,$AA,$AA,$AA,$0C,$AA
	db $AA,$0C,$AA,$AA,$00,$01,$02,$03
	db $0A,$0B,$04,$AA,$05,$05,$06,$07
	db $AA,$AA,$0C,$AA,$AA,$AA,$AA,$0C
	db $AA,$AA,$AA,$AA,$00,$01,$02,$03
	db $04,$AA,$05,$05,$06,$07,$AA,$AA
	db $AA,$AA,$0C,$AA,$AA,$AA,$AA,$AA
	db $AA,$AA,$AA,$AA,$00,$01,$02,$03
	db $04,$AA,$08,$09,$07,$AA,$AA,$AA
	db $FF
else
	db $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	db $AA,$AA,$AA,$AA,$AA,$14,$15,$16
	db $17,$18,$19,$1A,$1B,$AA,$AA,$AA
	db $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	db $AA,$AA,$AA,$AA,$AA,$AA,$AA,$28
	db $29,$2A,$2B,$1C,$14,$15,$16,$17
	db $18,$19,$1A,$1B,$AA,$AA,$AA,$AA
	db $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	db $AA,$28,$29,$2A,$2B,$1C,$24,$25
	db $26,$27,$AA,$AA,$AA,$AA,$FF
endif

DATA_0FDBE5:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMBLL_J) != $00
	db $AA,$AA,$0C,$AA,$AA,$AA,$0C,$AA
	db $AA,$AA,$AA,$AA,$00,$01,$02,$03
	db $0A,$0B,$04,$AA,$08,$09,$07,$AA
	db $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	db $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	db $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	db $AA,$AA,$0C,$AA,$AA,$AA,$AA,$AA
	db $AA,$AA,$AA,$AA,$00,$01,$02,$03
	db $04,$AA,$08,$09,$07,$AA,$AA,$AA
	db $FF
else
	db $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	db $AA,$AA,$AA,$AA,$AA,$24,$25,$26
	db $27,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	db $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	db $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	db $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	db $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	db $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	db $AA,$28,$29,$2A,$2B,$1C,$24,$25
	db $26,$27,$AA,$AA,$AA,$AA,$FF
endif

CODE_0FDC34:
	REP.b #$10
	LDY.w #$0010
	LDX.w #$0000
	LDA.b #$48
	STA.b $01
CODE_0FDC40:
	LDA.b #$58
	STA.b $00
CODE_0FDC44:
	LDA.w $1680
	BEQ.b CODE_0FDC5A
	AND.b #$10
	CMP.b #$10
	BEQ.b CODE_0FDC5A
	LDA.w DATA_0FDBE5,x
	BPL.b CODE_0FDC77
	INX
	INC
	BEQ.b CODE_0FDC98
	BRA.b CODE_0FDC63

CODE_0FDC5A:
	LDA.w DATA_0FDB96,x
	BPL.b CODE_0FDC77
	INX
	INC
	BEQ.b CODE_0FDC98
CODE_0FDC63:
	LDA.b $00
	CLC
	ADC.b #$08
	STA.b $00
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMBLL_J) != $00
	CMP.b #$B8
else
	CMP.b #$C0
endif
	BCC.b CODE_0FDC44
	LDA.b $01
	CLC
	ADC.b #$08
	STA.b $01
	BRA.b CODE_0FDC40

CODE_0FDC77:
	CLC
	ADC.b #$C0
	STA.w $0802,y
	LDA.b $00
	STA.w $0800,y
	LDA.b $01
	STA.w $0801,y
	LDA.b #$21
	STA.w $0803,y
	LDA.b #$00
	STA.w $0C00,y
	INX
	INY
	INY
	INY
	INY
	BRA.b CODE_0FDC63

CODE_0FDC98:
	LDA.b #$40
	STA.b $01
CODE_0FDC9C:
	LDA.b #$40
	STA.b $00
CODE_0FDCA0:
	LDA.b $00
	STA.w $0800,y
	CLC
	ADC.b #$10
	STA.b $00
	LDA.b $01
	STA.w $0801,y
	LDA.b #$CD
	STA.w $0802,y
	LDA.b #$21
	STA.w $0803,y
	LDA.b #$02
	STA.w $0C00,y
	INY
	INY
	INY
	INY
	LDA.b $00
	CMP.b #$C0
	BCC.b CODE_0FDCA0
	LDA.b $01
	CMP.b #$80
	BCS.b CODE_0FDCD5
	CLC
	ADC.b #$10
	STA.b $01
	BRA.b CODE_0FDC9C

CODE_0FDCD5:
	SEP.b #$10
	LDA.b #$4C
	STA.w $0800
	LDX.w $0B77
	LDA.w DATA_0FDB91,x
	STA.w $0801
	LDA.w $0B78
	AND.b #$10
	LSR
	LSR
	LSR
	LSR
	TAX
	LDA.w DATA_0FDB94,x
	STA.w $0802
	LDA.b #$21
	STA.w $0803
	LDA.b #$00
	STA.w $0C00
	RTS

;--------------------------------------------------------------------

CODE_0FDD00:
	LDA.w $0B6B
	BEQ.b CODE_0FDD63
	BMI.b CODE_0FDD63
	REP.b #$30
	DEC.w $0B6B
	DEC.w $0B6D
	DEC.w $0B6D
	INC.w $0B6F
	INC.w $0B6F
	DEC.w $0B71
	DEC.w $0B71
	DEC.w $0B71
	DEC.w $0B71
	INC.w $0B73
	INC.w $0B73
	INC.w $0B73
	INC.w $0B73
	LDX.w #$007E
	LDA.w #$00FF
CODE_0FDD36:
	STA.l $7FF000,x
	STA.l $7FF080,x
	STA.l $7FF100,x
	STA.l $7FF180,x
	DEX
	DEX
	BPL.b CODE_0FDD36
	LDA.w $0B6F
	XBA
	ORA.w $0B6D
	LDX.w $0B71
CODE_0FDD54:
	STA.l $7FF000,x
	INX
	INX
	CPX.w $0B73
	BNE.b CODE_0FDD54
	SEP.b #$30
	BRA.b CODE_0FDD66

CODE_0FDD63:
	INC.w $0B75
CODE_0FDD66:
	JSR.w CODE_0FDC34
	RTS

;--------------------------------------------------------------------

CODE_0FDD6A:
	LDA.w $0B6B
	BEQ.b CODE_0FDDCD
	BMI.b CODE_0FDDCD
	REP.b #$30
	INC.w $0B6D
	INC.w $0B6D
	DEC.w $0B6F
	DEC.w $0B6F
	INC.w $0B71
	INC.w $0B71
	INC.w $0B71
	INC.w $0B71
	DEC.w $0B73
	DEC.w $0B73
	DEC.w $0B73
	DEC.w $0B73
	DEC.w $0B6B
	LDX.w #$007E
	LDA.w #$00FF
CODE_0FDDA0:
	STA.l $7FF000,x
	STA.l $7FF080,x
	STA.l $7FF100,x
	STA.l $7FF180,x
	DEX
	DEX
	BPL.b CODE_0FDDA0
	LDA.w $0B6F
	XBA
	ORA.w $0B6D
	LDX.w $0B71
CODE_0FDDBE:
	STA.l $7FF000,x
	INX
	INX
	CPX.w $0B73
	BNE.b CODE_0FDDBE
	SEP.b #$30
	BRA.b CODE_0FDDF8

CODE_0FDDCD:
	STZ.w $0B75
	LDA.b #$0F
	STA.w !RAM_SMBLL_Global_ScreenDisplayRegisterMirror
	STZ.w $0776
	LDA.w $1206
	EOR.b #$03
	STA.w $1206
	LDA.w $1207
	EOR.b #$10
	STA.w $1207
	JSR.w CODE_0FD9DA
	JSL.l CODE_0D83E8
	LDA.w !RAM_SMBLL_Global_HDMAEnableMirror
	AND.b #$F7
	STA.w !RAM_SMBLL_Global_HDMAEnableMirror
	RTS

CODE_0FDDF8:
	JSR.w CODE_0FDC34
	RTS

;--------------------------------------------------------------------

CODE_0FDDFC:
	DEC.w $0F8A
	BNE.b CODE_0FDE1E
	INC.w $0B75
	LDA.b #$10
	STA.w $0B6B
	STA.w $0F8A
	LDA.w $1680
	CMP.b #$01
	BEQ.b CODE_0FDE1A
	LDA.w $0B77
	CMP.b #$02
	BNE.b CODE_0FDE1E
CODE_0FDE1A:
if !Define_Global_ROMToAssemble&(!ROM_SMBLL_U|!ROM_SMBLL_E|!ROM_SMBLL_J) != $00
	JML.l SMBLL_ResetGame_Main
else
	JML.l SMAS_ResetToSMASTitleScreen_Main				; Note: Call to SMAS function
endif

CODE_0FDE1E:
	JSR.w CODE_0FDC34
	RTS

;--------------------------------------------------------------------

CODE_0FDE22:
	PHB
	LDA.b #$7FF000>>16
	PHA
	PLB
	REP.b #$30
	LDX.w #$007E
	LDA.w #$0000
CODE_0FDE2F:
	STA.w $7FF000,x
	STA.w $7FF080,x
	STA.w $7FF100,x
	STA.w $7FF180,x
	DEX
	DEX
	BPL.b CODE_0FDE2F
	PLB
	SEP.b #$20
	LDX.w #(!REGISTER_Window1LeftPositionDesignation&$0000FF<<8)+$41
	STX.w DMA[$03].Parameters
	LDX.w #DATA_0FDE7E
	STX.w DMA[$03].SourceLo
	LDA.b #DATA_0FDE7E>>16
	STA.w DMA[$03].SourceBank
	LDA.b #$7FF000>>16
	STA.w HDMA[$03].IndirectSourceBank
	LDA.b #$00
	STA.w $1204
	STZ.w $1205
	LDA.w $1206
	ORA.b #$03
	STA.w $1206
	LDA.w $1207
	ORA.b #$10
	STA.w $1207
	STZ.w $1208
	SEP.b #$10
	LDA.w !RAM_SMBLL_Global_HDMAEnableMirror
	ORA.b #$08
	STA.w !RAM_SMBLL_Global_HDMAEnableMirror
	RTS

DATA_0FDE7E:
	db $F8 : dw $7FF000
	db $F8 : dw $7FF0F0
	db $00

;--------------------------------------------------------------------

CODE_0FDE85:
	PHB
	LDA.b #$7FF000>>16
	PHA
	PLB
	REP.b #$30
	LDX.w #$01A0
CODE_0FDE8F:
	LDA.w #$00FF
	STA.w $7FF000,x
	STA.w $7FF002,x
	STA.w $7FF004,x
	STA.w $7FF006,x
	STA.w $7FF008,x
	STA.w $7FF00A,x
	STA.w $7FF00C,x
	STA.w $7FF00E,x
	STA.w $7FF010,x
	STA.w $7FF012,x
	STA.w $7FF014,x
	STA.w $7FF016,x
	STA.w $7FF018,x
	STA.w $7FF01A,x
	STA.w $7FF01C,x
	STA.w $7FF01E,x
	STA.w $7FF200,x
	STA.w $7FF202,x
	STA.w $7FF204,x
	STA.w $7FF206,x
	STA.w $7FF208,x
	STA.w $7FF20A,x
	STA.w $7FF20C,x
	STA.w $7FF20E,x
	STA.w $7FF210,x
	STA.w $7FF212,x
	STA.w $7FF214,x
	STA.w $7FF216,x
	STA.w $7FF218,x
	STA.w $7FF21A,x
	STA.w $7FF21C,x
	STA.w $7FF21E,x
	TXA
	SEC
	SBC.w #$0020
	TAX
	BPL.b CODE_0FDE8F
	SEP.b #$30
	PLB
	RTS

;--------------------------------------------------------------------

CODE_0FDEFE:
	PHB
	PHK
	PLB
	PHX
	LDX.w $0EC3
	LDA.w $0FFA,x
	PLX
	AND.b #$C0
	BEQ.b CODE_0FDF23
	AND.b #$80
	BEQ.b CODE_0FDF1B
	STZ.w $0754
	LDA.b #$01
	STA.w $0756
	BRA.b CODE_0FDF23

CODE_0FDF1B:
	STZ.w $0754
	LDA.b #$02
	STA.w $0756
CODE_0FDF23:
	LDA.w $0FF6
	AND.b #$20
	BEQ.b CODE_0FDF38
	EOR.w $0E73
	STA.w $0E73
	LSR
	LSR
	LSR
	LSR
	LSR
	STA.w $0716
CODE_0FDF38:
	LDA.w $0E73
	BNE.b CODE_0FDF40
	JMP.w CODE_0FDFE7

CODE_0FDF40:
	LDA.b #$10
	STA.w $07AF
	LDA.w $0FF8
	AND.b #$10
	BEQ.b CODE_0FDF8B
	LDA.b $09
	AND.b #$07
	BNE.b CODE_0FDF8B
	LDA.w $0FF4
	LSR
	BCS.b CODE_0FDF64
	LSR
	BCS.b CODE_0FDF72
	LSR
	BCS.b CODE_0FDF88
	LSR
	BCS.b CODE_0FDF81
	JMP.w CODE_0FDFEA

CODE_0FDF64:
	LDA.b #$09
	STA.w $07EA
	STA.w $07EB
	STA.w $07E9
	JMP.w CODE_0FDFEA

CODE_0FDF72:
	STZ.w $07EA
	STZ.w $07EB
	STZ.w $07E9
	STZ.w $0E73
	JMP.w CODE_0FDFEA

CODE_0FDF81:
	JSL.l CODE_048596				; Note: Call to SMB1 function
	JMP.w CODE_0FDFEA

CODE_0FDF88:
	JMP.w CODE_0FDFEA

CODE_0FDF8B:
	LDA.b $09
	AND.b #$07
	BNE.b CODE_0FDFAC
	LDA.w $0FF6
	AND.b #$80
	BEQ.b CODE_0FDFAC
	LDA.w $0754
	EOR.b #$01
	STA.w $0754
	LDA.w $0756
	EOR.b #$02
	STA.w $0756
	JSL.l CODE_0E98C3
CODE_0FDFAC:
	LDA.w $0FF4
	AND.b #$03
	BEQ.b CODE_0FDFCA
	TAY
	LDA.b $0C
	STA.w $0202
	LDA.w $0219
	CLC
	ADC.w DATA_0FDFED-$01,y
	STA.w $0219
	LDA.b $78
	ADC.w DATA_0FDFEF-$01,y
	STA.b $78
CODE_0FDFCA:
	LDA.w $0FF4
	AND.b #$0C
	BEQ.b CODE_0FDFEA
	LSR
	LSR
	TAY
	LDA.w $0237
	CLC
	ADC.w DATA_0FDFED-$01,y
	STA.w $0237
	LDA.b $BB
	ADC.w DATA_0FDFEF-$01,y
	STA.b $BB
	BRA.b CODE_0FDFEA

CODE_0FDFE7:
	SEC
	PLB
	RTL

CODE_0FDFEA:
	CLC
	PLB
	RTL

DATA_0FDFED:
	db $03,$FD

DATA_0FDFEF:
	db $00,$FF

;--------------------------------------------------------------------

CODE_0FDEF1:
	PHA
	PHB
	PHK
	PLB
	LDA.w $07B2
	BEQ.b CODE_0FE06A
	LDA.w $0FF4
	STA.b $E4
	AND.b #$C0
	BEQ.b CODE_0FE06A
	LDA.b $09
	AND.b #$07
	BNE.b CODE_0FE06A
	LDA.b $E4
	CMP.b #$40
	BNE.b CODE_0FE021
	LDA.b #$17
	STA.w $07B2
	INC.w $075F
	LDA.w $075F
	CMP.b #$0D
	BCC.b CODE_0FE021
	STZ.w $075F
CODE_0FE021:
	LDA.b $E4
	CMP.b #$80
	BNE.b CODE_0FE039
	LDA.b #$17
	STA.w $07B2
	INC.w $075C
	LDA.w $075C
	CMP.b #$04
	BCC.b CODE_0FE039
	STZ.w $075C
CODE_0FE039:
	LDX.b #$00
CODE_0FE03B:
	LDA.w DATA_0FE0A1,x
	STA.l $001702,x
	INX
	CPX.b #$0B
	BCC.b CODE_0FE03B
	LDA.w $075F
	CLC
	ADC.b #$01
	STA.l $001706
	LDA.w $075C
	CLC
	ADC.b #$01
	STA.l $00170A
	LDA.w $075F
	ASL
	ASL
	ORA.w $075C
	TAX
	LDA.w DATA_0FE06D,x
	STA.w $0760
CODE_0FE06A:
	PLB
	PLA
	RTL

DATA_0FE06D:
	db $00,$02,$03,$04
	db $00,$01,$02,$03
	db $00,$02,$03,$04
	db $00,$01,$02,$03
	db $00,$02,$03,$04
	db $00,$02,$03,$04
	db $00,$01,$02,$03
	db $00,$01,$02,$03
	db $00,$01,$02,$03
	db $00,$02,$03,$04
	db $00,$02,$03,$04
	db $00,$01,$02,$03
	db $00,$01,$02,$03

;--------------------------------------------------------------------

DATA_0FE0A1:
	db $58,$73,$00,$05
	db $24,$20,$24,$20,$24,$20

	db $FF

;--------------------------------------------------------------------

CODE_0FE0AC:
	PHY
	LDY.b #$00
CODE_0FE0AF:
	LDA.w $0B25,y
	BEQ.b CODE_0FE0BB
	INY
	CPY.b #$05
	BNE.b CODE_0FE0AF
	LDY.b #$00
CODE_0FE0BB:
	LDA.b #$01
	STA.w $0B25,y
	LDA.b $5E,x
	BPL.b CODE_0FE0DB
	LDA.b $79,x
	XBA
	LDA.w $021A,x
	REP.b #$20
	SEC
	SBC.w #$0008
	SEP.b #$20
	STA.w $0B2F,y
	XBA
	STA.w $0B2A,y
	BRA.b CODE_0FE0F0

CODE_0FE0DB:
	LDA.b $79,x
	XBA
	LDA.w $021A,x
	REP.b #$20
	CLC
	ADC.w #$0008
	SEP.b #$20
	STA.w $0B2F,y
	XBA
	STA.w $0B2A,y
CODE_0FE0F0:
	LDA.w $03B9
	CLC
	ADC.b #$0C
	STA.w $0B34,y
	PLY
	RTL

;--------------------------------------------------------------------

CODE_0FE0FB:
	PHB
	PHK
	PLB
	PHX
	PHY
	LDX.b #$00
CODE_0FE102:
	LDA.w DATA_0FE268,x
	TAY
	LDA.w $0B25,x
	BEQ.b CODE_0FE12B
	AND.b #$0C
	STA.b $E4
	BNE.b CODE_0FE116
	JSR.w CODE_0FE134
	BRA.b CODE_0FE12B

CODE_0FE116:
	CMP.b #$04
	BNE.b CODE_0FE11F
	JSR.w CODE_0FE16F
	BRA.b CODE_0FE12B

CODE_0FE11F:
	CMP.b #$08
	BNE.b CODE_0FE128
	JSR.w CODE_0FE1AF
	BRA.b CODE_0FE12B

CODE_0FE128:
	STZ.w $0B25,x
CODE_0FE12B:
	INX
	CPX.b #$05
	BNE.b CODE_0FE102
	PLY
	PLX
	PLB
	RTL

CODE_0FE134:
	JSR.w CODE_0FE253
	LDA.w $0B3B
	CLC
	ADC.b #$04
	STA.w $0801,y
	LDA.b #$26
	STA.w $0802,y
	LDA.b #$25
	STA.w $0803,y
	REP.b #$20
	LDA.w $0B39
	CLC
	ADC.w #$0004
	SEC
	SBC.b $42
	STA.w $0B39
	SEP.b #$20
	LDA.w $0B39
	STA.w $0800,y
	LDA.w $0B3A
	BEQ.b CODE_0FE168
	LDA.b #$01
CODE_0FE168:
	STA.w $0C00,y
	INC.w $0B25,x
	RTS

CODE_0FE16F:
	JSR.w CODE_0FE253
	LDA.w $0B3B
	STA.w $0801,y
	LDA.b #$60
	STA.w $0802,y
	LDA.b #$25
	STA.w $0803,y
	REP.b #$20
	LDA.w $0B39
	SEC
	SBC.b $42
	STA.w $0B39
	SEP.b #$20
	LDA.w $0B39
	STA.w $0800,y
	LDA.w $0B3A
	BEQ.b CODE_0FE19E
	LDA.b #$03
	BRA.b CODE_0FE1A0

CODE_0FE19E:
	LDA.b #$02
CODE_0FE1A0:
	STA.w $0C00,y
	INC.w $0B25,x
	RTS

DATA_0FE1A7:
	db $FF,$FE,$FC,$F9

DATA_0FE1AB:
	db $01,$02,$04,$07

CODE_0FE1AF:
	STX.b $F1
	JSR.w CODE_0FE253
	LDA.w $0B25,x
	AND.b #$03
	TAX
	LDA.w $0B3B
	CLC
	ADC.w DATA_0FE1A7,x
	STA.w $0801,y
	STA.w $0805,y
	LDA.w $0B3B
	CLC
	ADC.w DATA_0FE1AB,x
	CLC
	ADC.b #$08
	STA.w $0809,y
	STA.w $080D,y
	LDA.b #$39
	STA.w $0802,y
	STA.w $0806,y
	STA.w $080A,y
	STA.w $080E,y
	LDA.b #$25
	STA.w $0803,y
	STA.w $0807,y
	STA.w $080B,y
	STA.w $080F,y
	LDA.w DATA_0FE1A7,x
	STA.b $EF
	LDA.b #$FF
	STA.b $F0
	REP.b #$20
	LDA.w $0B39
	SEC
	SBC.b $42
	CLC
	ADC.b $EF
	STA.b $ED
	SEP.b #$20
	LDA.b $ED
	STA.w $0800,y
	STA.w $0808,y
	LDA.b $EE
	BEQ.b CODE_0FE219
	LDA.b #$01
CODE_0FE219:
	STA.w $0C00,y
	STA.w $0C08,y
	LDA.w DATA_0FE1AB,x
	STA.b $EF
	STZ.b $F0
	REP.b #$20
	LDA.w $0B39
	CLC
	ADC.w #$0008
	SEC
	SBC.b $42
	CLC
	ADC.b $EF
	STA.b $ED
	SEP.b #$20
	LDA.b $ED
	STA.w $0804,y
	STA.w $080C,y
	LDA.b $EE
	BEQ.b CODE_0FE247
	LDA.b #$01
CODE_0FE247:
	STA.w $0C04,y
	STA.w $0C0C,y
	LDX.b $F1
	INC.w $0B25,x
	RTS

CODE_0FE253:
	LDA.w $0B34,x
	STA.w $0B3B
	LDA.w $0B2A,x
	XBA
	LDA.w $0B2F,x
	REP.b #$20
	STA.w $0B39
	SEP.b #$20
	RTS

DATA_0FE268:
	db $00,$10,$20,$40,$50

;--------------------------------------------------------------------

CODE_0FE26D:
	PHB
	PHK
	PLB
	LDA.w $0201
	CMP.b #$01
	BEQ.b CODE_0FE2E9
	LDA.w $075F
	CMP.b #$08
	BEQ.b CODE_0FE2E9
	LDA.b $BA
	CMP.b #$03
	BNE.b CODE_0FE2E9
	LDA.b $96
	BNE.b CODE_0FE2E6
	LDA.w $02FC
	BEQ.b CODE_0FE2E9
	LDX.b #$08
CODE_0FE28F:
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$2D
	BEQ.b CODE_0FE29A
CODE_0FE295:
	DEX
	BPL.b CODE_0FE28F
	BRA.b CODE_0FE2BD

CODE_0FE29A:
	LDA.w $0238,x
	CMP.b #$B8
	BCC.b CODE_0FE2E9
	LDA.b $10,x
	AND.b #$80
	BNE.b CODE_0FE295
	LDA.w $021A,x
	CLC
	ADC.b #$10
	STA.w $02FA
	LDA.b $79,x
	ADC.b #$00
	STA.w $02FB
	LDA.b #$08
	STA.b $96
	BRA.b CODE_0FE2DC

CODE_0FE2BD:
	LDX.w $02FC
	DEX
	LDA.w $0238,x
	CMP.b #$B8
	BCC.b CODE_0FE2E9
	LDA.w $021A,x
	CLC
	ADC.b #$04
	STA.w $02FA
	LDA.b $79,x
	ADC.b #$00
	STA.w $02FB
	LDA.b #$04
	STA.b $96
CODE_0FE2DC:
	LDA.b #!Define_SMAS_Sound0060_BlarggRoar
	STA.w !RAM_SMBLL_Global_SoundCh1
	LDA.b #!Define_SMAS_Sound0063_LemmyWendyLandInLava
	STA.w !RAM_SMBLL_Global_SoundCh3
CODE_0FE2E6:
	JSR.w CODE_0FE2ED
CODE_0FE2E9:
	JMP.w CODE_0FED86

CODE_0FE2EC:
	RTL

CODE_0FE2ED:
	LDA.b $96
	STA.b $E4
	INC.w $02F9
	LDA.w $02F9
	LSR
	LSR
	CMP.b #$06
	BCS.b CODE_0FE358
	STA.b $DD
	ASL
	ASL
	ASL
	TAX
	LDY.b #$20
	STZ.b $E9
CODE_0FE307:
	TXA
	AND.b #$01
	CLC
	ADC.b #$FF
	STA.b $E8
	LDA.w DATA_0FE35E,x
	STA.b $E7
	REP.b #$20
	LDA.b $E7
	CLC
	ADC.w $02FA
	SEC
	SBC.b $42
	STA.b $E7
	SEP.b #$20
	LDA.b $E7
	STA.w $0800,y
	LDA.b $E8
	BEQ.b CODE_0FE32E
	LDA.b #$00
CODE_0FE32E:
	ORA.b $E9
	STA.w $0C00,y
	LDA.w DATA_0FE386,x
	CLC
	ADC.b #$D8
	STA.w $0801,y
	PHX
	LDX.b $DD
	LDA.w DATA_0FE3B7,x
	STA.w $0802,y
	LDX.b $E4
	LDA.w DATA_0FE3AE,x
	STA.w $0803,y
	PLX
	INY
	INY
	INY
	INY
	INX
	DEC.b $E4
	BNE.b CODE_0FE307
	RTS

CODE_0FE358:
	STZ.w $02FC
	STZ.b $96
	RTS

DATA_0FE35E:
	db $F6,$02,$F1,$07,$F2,$06,$ED,$0B
	db $F3,$05,$EE,$0A,$EF,$09,$EA,$0E
	db $F1,$07,$EC,$0C,$ED,$0B,$E8,$10
	db $F0,$08,$EB,$0D,$EC,$0C,$E7,$11
	db $EF,$09,$EA,$0E,$EB,$0D,$E6,$12

DATA_0FE386:
	db $F5,$F5,$F8,$F8,$F1,$F1,$F4,$F4
	db $F4,$F4,$F7,$F7,$F0,$F0,$F3,$F3
	db $F2,$F2,$F5,$F5,$EE,$EE,$F1,$F1
	db $F1,$F1,$F4,$F4,$ED,$ED,$F0,$F0
	db $F0,$F0,$F3,$F3,$EC,$EC,$EF,$EF

DATA_0FE3AE:
	db $28,$68,$28,$68,$28,$68,$28,$68
	db $28

DATA_0FE3B7:
	db $33,$33,$34,$35,$36,$37

;--------------------------------------------------------------------

DATA_0FE3BD:
	db $F1,$FF,$F6,$FF,$02,$00,$07,$00
	db $EE,$FF,$F3,$FF,$05,$00,$0A,$00
	db $EC,$FF,$F1,$FF,$07,$00,$0C,$00
	db $EB,$FF,$F0,$FF,$08,$00,$0D,$00
	db $EA,$FF,$EF,$FF,$09,$00,$0E,$00
	db $EA,$FF,$EF,$FF,$09,$00,$0E,$00

DATA_0FE3ED:
	db $F8,$F5,$F5,$F8,$F7,$F4,$F4,$F7
	db $F5,$F2,$F2,$F5,$F4,$F1,$F1,$F4
	db $F3,$F0,$F0,$F3,$F3,$F0,$F0,$F3

DATA_0FE405:
	db $33,$33,$34,$35,$36,$37

DATA_0FE40B:
	db $28,$28,$68,$68

CODE_0FE40F:
	PHB
	PHK
	PLB
	PHX
	PHY
	LDA.w $0B00,x
	CMP.b #$02
	BEQ.b CODE_0FE452
	LSR
	BCC.b CODE_0FE467
	LDA.w $0B09,x
	LSR
	LSR
	CMP.b #$06
	BEQ.b CODE_0FE454
	TAY
	LDA.w DATA_0FE405,y
	STA.b $ED
	LDA.w $021A,x
	STA.b $00
	LDA.b $79,x
	STA.b $01
	REP.b #$20
	LDA.b $00
	CLC
	ADC.w #$0008
	SEC
	SBC.b $42
	STA.b $00
	SEP.b #$20
	LDA.w $0B46,x
	CLC
	ADC.b #$04
	STA.b $F2
	JSR.w CODE_0FE537
	BRA.b CODE_0FE467

CODE_0FE452:
	BRA.b CODE_0FE498

CODE_0FE454:
	INC.w $0B00,x
	STZ.w $0B09,x
	LDA.w $0B00,x
	CMP.b #$02
	BNE.b CODE_0FE467
	LDA.w $0238,x
	STA.w $0B12,x
CODE_0FE467:
	PLY
	PLX
	PLB
	RTL

DATA_0FE46B:
	db $FF,$FF,$FA,$FF,$FA,$FF,$FA,$FF
	db $FF,$FF

DATA_0FE475:
	db $00,$00,$00,$00,$00,$00,$FE,$FF
	db $FE,$FF

DATA_0FE47F:
	db $FF,$00,$00,$00,$FF

DATA_0FE484:
	db $12,$12,$12,$10,$10

DATA_0FE489:
	db $FC,$30,$31,$32,$FC

DATA_0FE48E:
	db $30,$31,$32,$FC,$FC

DATA_0FE493:
	db $FF,$FF,$FF,$00,$00

CODE_0FE498:
	LDA.w $0B09,x
	LSR
	LSR
	LSR
	CMP.b #$05
	BCC.b CODE_0FE4AA
	LDA.b #$30
	STA.w $0B09,x
	JMP.w CODE_0FE534

CODE_0FE4AA:
	STA.b $EB
	ASL
	TAY
	LDA.w $021A,x
	STA.b $00
	LDA.b $79,x
	STA.b $01
	REP.b #$20
	LDA.b $00
	CLC
	ADC.w #$0008
	SEC
	SBC.b $42
	PHA
	CLC
	ADC.w DATA_0FE46B,y
	STA.b $00
	PLA
	CLC
	ADC.w DATA_0FE475,y
	STA.b $02
	SEP.b #$20
	LDY.b $EB
	LDA.w DATA_0FE493,y
	CLC
	ADC.w $0B12,x
	STA.w $0B12,x
	LDA.w DATA_0FE47F,y
	CLC
	ADC.w $0B12,x
	STA.b $04
	LDA.w DATA_0FE484,y
	CLC
	ADC.w $0B12,x
	STA.b $ED
	LDA.w $0B46,x
	TAY
	INY
	INY
	INY
	INY
	LDX.b $EB
	LDA.b $00
	STA.w $0900,y
	LDA.b $02
	STA.w $0904,y
	LDA.b $04
	STA.w $0901,y
	LDA.b $ED
	STA.w $0905,y
	LDA.w DATA_0FE489,x
	STA.w $0902,y
	LDA.w DATA_0FE48E,x
	STA.w $0906,y
	LDA.b #$28
	STA.w $0903,y
	STA.w $0907,y
	LDA.b $01
	BEQ.b CODE_0FE52B
	LDA.b #$01
	STA.w $0D00,y
CODE_0FE52B:
	LDA.b $03
	BEQ.b CODE_0FE534
	LDA.b #$01
	STA.w $0D04,y
CODE_0FE534:
	JMP.w CODE_0FE467

CODE_0FE537:
	STY.b $EC
	LDX.b #$00
CODE_0FE53B:
	LDA.b $EC
	ASL
	ASL
	STA.b $EB
	TXA
	CLC
	ADC.b $EB
	TAY
	LDA.b #$D8
	CLC
	ADC.w DATA_0FE3ED,y
	STA.b $EE
	LDA.b $5C
	BNE.b CODE_0FE556
	LDA.b #$F0
	STA.b $EE
CODE_0FE556:
	LDA.w DATA_0FE40B,x
	STA.b $EF
	TYA
	ASL
	TAY
	REP.b #$20
	LDA.w DATA_0FE3BD,y
	CLC
	ADC.b $00
	STA.b $F0
	SEP.b #$20
	TXA
	ASL
	ASL
	CLC
	ADC.b $F2
	TAY
	LDA.b $F0
	STA.w $0900,y
	LDA.b $EE
	STA.w $0901,y
	LDA.b $ED
	STA.w $0902,y
	LDA.b $EF
	STA.w $0903,y
	LDA.b $F1
	BEQ.b CODE_0FE58E
	LDA.b #$01
	STA.w $0D00,y
CODE_0FE58E:
	INX
	CPX.b #$04
	BNE.b CODE_0FE53B
	RTS

;--------------------------------------------------------------------

UNK_0FE594:
	db $1C,$0E,$06,$08

DATA_0FE598:
	db $18,$16,$1A,$14

DATA_0FE59C:
	db $D0,$E0,$E1,$FC

DATA_0FE5A0:
	db $00,$FC,$F8,$F4

CODE_0FE5A4:
	PHB
	PHK
	PLB
	PHX
	PHY
	LDA.w $0E40
	BNE.b CODE_0FE5B1
	JSR.w CODE_0FE5C5
CODE_0FE5B1:
	JSR.w CODE_0FE5D4
	LDA.w $0E42
	AND.b #$20
	BEQ.b CODE_0FE5C1
	STZ.w $0E40
	STZ.w $0E41
CODE_0FE5C1:
	PLY
	PLX
	PLB
	RTL

CODE_0FE5C5:
	LDX.b #$03
CODE_0FE5C7:
	LDA.w DATA_0FE5A0,x
	STA.w $0E42,x
	DEX
	BPL.b CODE_0FE5C7
	INC.w $0E40
	RTS

CODE_0FE5D4:
	LDX.b #$03
	LDY.b #$30
CODE_0FE5D8:
	LDA.w $0E42,x
	BMI.b CODE_0FE608
	BNE.b CODE_0FE5E2
	JSR.w CODE_0FE618
CODE_0FE5E2:
	LSR
	LSR
	CMP.b #$03
	BCS.b CODE_0FE608
	PHX
	TAX
	LDA.w DATA_0FE59C,x
	STA.w $0802,y
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMBLL_J) != $00
	LDA.b #$08
else
	LDA.b #$38
endif
	STA.w $0803,y
	PLX
	LDA.w $0E46,x
	SEC
	SBC.w $071C
	STA.w $0800,y
	LDA.w $0E4A,x
	STA.w $0801,y
	BRA.b CODE_0FE60D

CODE_0FE608:
	LDA.b #$F8
	STA.w $0801,y
CODE_0FE60D:
	INY
	INY
	INY
	INY
	INC.w $0E42,x
	DEX
	BPL.b CODE_0FE5D8
	RTS

CODE_0FE618:
	LDA.w $0202
	LSR
	BCC.b CODE_0FE626
	LDA.w $0219
	CLC
	ADC.b #$06
	BRA.b CODE_0FE62C

CODE_0FE626:
	LDA.w $0219
	CLC
	ADC.b #$02
CODE_0FE62C:
	STA.w $0E46,x
	LDA.w $06D5
	CMP.b #$18
	BEQ.b CODE_0FE63A
	CMP.b #$78
	BNE.b CODE_0FE64D
CODE_0FE63A:
	LDA.w $07B8
	AND.b #$04
	SEC
	SBC.b #$02
	CLC
	ADC.w $03B8
	ADC.w DATA_0FE598
	STA.w $0E4A,x
	RTS

CODE_0FE64D:
	LDA.b #$F8
	STA.w $0E4A,x
	RTS

;--------------------------------------------------------------------

DATA_0FE653:
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMBLL_J) != $00
	db $00,$A4,$40,$2C
	db $82,$39

	db $00,$CE,$40,$18
	db $84,$39

	db $00,$EE,$40,$18
	db $84,$39

	db $01,$0E,$40,$18
	db $84,$39

	db $00,$C3,$C0,$10
	db $83,$39

	db $00,$C4,$00,$13
	db $85,$39,$86,$39,$87,$39,$87,$39,$88,$39,$89,$39,$8A,$39,$8B,$39
	db $88,$39,$89,$39

	db $00,$E4,$00,$13
	db $8C,$39,$8D,$39,$8E,$39,$8F,$39,$90,$39,$91,$39,$92,$39,$93,$39
	db $90,$39,$94,$39

	db $01,$04,$00,$13
	db $95,$39,$96,$39,$95,$39,$96,$39,$97,$39,$84,$39,$95,$39,$98,$39
	db $97,$39,$99,$39

	db $01,$24,$00,$2D
	db $8A,$39,$9A,$39,$8A,$79,$8A,$39,$8A,$79,$88,$39,$8A,$79,$9B,$39
	db $8A,$39,$8A,$79,$84,$39,$88,$39,$8A,$79,$88,$39,$8A,$79,$8A,$39
	db $8A,$79,$8A,$39,$8A,$79,$84,$39,$84,$39,$AA,$39,$AB,$39

	db $01,$44,$00,$2D
	db $9C,$39,$9D,$39,$9D,$39,$9C,$39,$9D,$39,$9C,$39,$9E,$39,$9C,$39
	db $9C,$39,$9D,$39,$84,$39,$9C,$39,$C7,$39,$9C,$39,$C7,$39,$9C,$39
	db $9D,$39,$C8,$39,$C9,$39,$84,$39,$84,$39,$AC,$39,$AD,$39

	db $01,$64,$00,$2D
	db $9F,$39,$9F,$39,$9F,$39,$A0,$39,$A1,$39,$9F,$39,$A2,$39,$9F,$39
	db $9F,$39,$9F,$39,$84,$39,$9F,$39,$A2,$39,$9F,$39,$A2,$39,$9F,$39
	db $9F,$39,$CA,$39,$CB,$39,$84,$39,$84,$39,$AE,$39,$AF,$39

	db $01,$84,$00,$2D
	db $A3,$39,$A3,$39,$A3,$39,$A4,$39,$A5,$39,$A3,$39,$A3,$39,$A3,$39
	db $A6,$39,$A7,$39,$84,$39,$A3,$39,$CC,$39,$A3,$39,$A3,$39,$A6,$39
	db $A7,$39,$A6,$39,$A7,$39,$CD,$39,$84,$39,$B0,$39,$B1,$39

	db $01,$A4,$00,$2D
	db $D9,$39,$DA,$39,$DB,$39,$DC,$39,$DD,$39,$DE,$39,$DF,$39,$E0,$39
	db $E1,$39,$E2,$39,$E3,$39,$DC,$39,$B2,$39,$B3,$39,$B4,$39,$B5,$39
	db $B6,$39,$B7,$39,$B8,$39,$B9,$39,$BA,$39,$BB,$39,$BC,$39

	db $01,$C4,$00,$2D
	db $E4,$39,$E5,$39,$E6,$39,$E7,$39,$84,$39,$E8,$39,$E9,$39,$EA,$39
	db $EB,$39,$EC,$39,$ED,$39,$E7,$39,$84,$39,$BD,$39,$BE,$39,$BF,$39
	db $C0,$39,$C1,$39,$C2,$39,$C3,$39,$C4,$39,$CE,$39,$CF,$39

	db $00,$DB,$C0,$10
	db $C6,$39

	db $01,$E3,$00,$31
	db $80,$39,$EE,$39,$EF,$39,$F0,$39,$F1,$39,$A9,$39,$EF,$39,$F0,$39
	db $F2,$39,$EE,$39,$F3,$39,$F4,$39,$F1,$39,$A9,$39,$D0,$39,$D1,$39
	db $D2,$39,$D3,$39,$D4,$39,$D0,$79,$D5,$39,$D6,$39,$D7,$39,$D8,$39
	db $A8,$39

	db $00,$A3,$00,$01
	db $81,$39

	db $00,$BB,$00,$01
	db $C5,$39

	db $02,$0A,$00,$25
	db $2F,$06,$01,$04,$09,$04,$08,$04,$06,$04,$24,$04,$01,$04,$09,$04
	db $09,$04,$03,$04,$24,$04,$17,$04,$12,$04,$17,$04,$1D,$04,$0E,$04
	db $17,$04,$0D,$04,$18,$04

if !Define_Global_ROMToAssemble&(!ROM_SMBLL_J) != $00
	db $02,$D6,$C0,$06
	db $24,$08

	db $02,$D7,$C0,$06
	db $24,$08

	db $02,$9A,$C0,$0A
	db $24,$08

	db $02,$9B,$C0,$0A
	db $24,$08
else
	db $02,$4E,$00,$15
	db $16,$08,$0A,$08,$1B,$08,$12,$08,$18,$08,$24,$08,$10,$08,$0A,$08
	db $16,$08,$0E,$08,$24,$08

	db $02,$8E,$00,$15
	db $15,$08,$1E,$08,$12,$08,$10,$08,$12,$08,$24,$08,$10,$08,$0A,$08
	db $16,$08,$0E,$08,$24,$08

	db $02,$EB,$00,$07
	db $1D,$08,$18,$08,$19,$08,$28,$08

	db $02,$F5,$00,$01
	db $00,$08
endif
else
	db $00,$A5,$40,$2A
	db $82,$39

	db $00,$D0,$40,$14
	db $84,$39

	db $00,$F0,$40,$14
	db $84,$39

	db $01,$10,$40,$14
	db $84,$39

	db $00,$C4,$C0,$10
	db $83,$39

	db $00,$C5,$C0,$10
	db $84,$39

	db $00,$C6,$00,$13
	db $85,$39,$86,$39,$87,$39,$87,$39,$88,$39,$89,$39,$8A,$39,$8B,$39
	db $88,$39,$89,$39

	db $00,$E6,$00,$13
	db $8C,$39,$8D,$39,$8E,$39,$8F,$39,$90,$39,$91,$39,$92,$39,$93,$39
	db $90,$39,$94,$39

	db $01,$06,$00,$13
	db $95,$39,$96,$39,$95,$39,$96,$39,$97,$39,$84,$39,$95,$39,$98,$39
	db $97,$39,$99,$39

	db $01,$26,$00,$29
	db $8A,$39,$9A,$39,$8A,$79,$8A,$39,$8A,$79,$88,$39,$8A,$79,$9B,$39
	db $8A,$39,$8A,$79,$84,$39,$88,$39,$8A,$79,$88,$39,$8A,$79,$8A,$39
	db $8A,$79,$8A,$39,$8A,$79,$84,$39,$84,$39

	db $01,$46,$00,$29
	db $9C,$39,$9D,$39,$9D,$39,$9C,$39,$9D,$39,$9C,$39,$9E,$39,$9C,$39
	db $9C,$39,$9D,$39,$84,$39,$9C,$39,$C7,$39,$9C,$39,$C7,$39,$9C,$39
	db $9D,$39,$C8,$39,$C9,$39,$84,$39,$84,$39

	db $01,$66,$00,$29
	db $9F,$39,$9F,$39,$9F,$39,$A0,$39,$A1,$39,$9F,$39,$A2,$39,$9F,$39
	db $9F,$39,$9F,$39,$84,$39,$9F,$39,$A2,$39,$9F,$39,$A2,$39,$9F,$39
	db $9F,$39,$CA,$39,$CB,$39,$84,$39,$84,$39

	db $01,$19,$00,$03
	db $E4,$39,$E5,$39

	db $01,$86,$00,$29
	db $A3,$39,$A3,$39,$A3,$39,$A4,$39,$A5,$39,$A3,$39,$A3,$39,$A3,$39
	db $A6,$39,$A7,$39,$84,$39,$A3,$39,$CC,$39,$A3,$39,$A3,$39,$A6,$39
	db $A7,$39,$A6,$39,$A7,$39,$CD,$39,$84,$39

	db $01,$A6,$00,$29
	db $A8,$39,$A9,$39,$AA,$39,$AB,$39,$AC,$39,$AD,$39,$AE,$39,$AF,$39
	db $B0,$39,$B1,$39,$CE,$39,$AC,$39,$CF,$39,$AD,$39,$D0,$39,$D1,$39
	db $D2,$39,$D3,$39,$D4,$39,$D5,$39,$84,$39

	db $01,$C6,$00,$29
	db $B2,$39,$B3,$39,$B4,$39,$B5,$39,$84,$39,$B6,$39,$B7,$39,$B8,$39
	db $B9,$39,$BA,$39,$D6,$39,$84,$39,$D7,$39,$D8,$39,$D9,$39,$DA,$39
	db $DB,$39,$DC,$39,$DD,$39,$DE,$39,$84,$39

	db $00,$DB,$C0,$10
	db $C6,$39

	db $01,$E4,$00,$2F
	db $BB,$39,$BC,$39,$BD,$39,$BE,$39,$BF,$39,$C0,$39,$BC,$39,$C1,$39
	db $C2,$39,$C3,$39,$C4,$39,$C4,$79,$BF,$39,$BC,$39,$DF,$39,$E0,$39
	db $C2,$39,$BF,$79,$E1,$39,$E1,$79,$E2,$39,$E3,$39,$BC,$39,$80,$39

	db $00,$A4,$00,$01
	db $81,$39

	db $00,$BB,$00,$01
	db $C5,$39

	db $02,$0A,$00,$25
	db $2F,$06,$01,$04,$09,$04,$08,$04,$06,$04,$24,$04,$01,$04,$09,$04
	db $09,$04,$03,$04,$24,$04,$17,$04,$12,$04,$17,$04,$1D,$04,$0E,$04
	db $17,$04,$0D,$04,$18,$04

if !Define_Global_ROMToAssemble&(!ROM_SMBLL_U|!ROM_SMBLL_E) != $00
	db $02,$D6,$C0,$06
	db $24,$08

	db $02,$D7,$C0,$06
	db $24,$08

	db $02,$9A,$C0,$0A
	db $24,$08

	db $02,$9B,$C0,$0A
	db $24,$08
else
	db $02,$4E,$00,$15
	db $16,$08,$0A,$08,$1B,$08,$12,$08,$18,$08,$24,$08,$10,$08,$0A,$08
	db $16,$08,$0E,$08,$24,$08

	db $02,$8E,$00,$15
	db $15,$08,$1E,$08,$12,$08,$10,$08,$12,$08,$24,$08,$10,$08,$0A,$08
	db $16,$08,$0E,$08,$24,$08

	db $02,$EB,$00,$07
	db $1D,$08,$18,$08,$19,$08,$28,$08

	db $02,$F5,$00,$01
	db $00,$08
endif
endif
	db $FF,$FF

CODE_0FE893:
	PHB
	PHK
	PLB
	LDA.b #$01
	STA.w $0EC8
	REP.b #$30
	LDX.w $1700
	LDY.w #$0000
CODE_0FE8A3:
	LDA.w DATA_0FE653,y
	STA.w $1702,x
	INC
	BEQ.b CODE_0FE8B2
	INX
	INX
	INY
	INY
	BRA.b CODE_0FE8A3

CODE_0FE8B2:
	STX.w $1700
	SEP.b #$30
	STZ.w !RAM_SMBLL_Level_NoWorld9Flag
if !Define_Global_ROMToAssemble&(!ROM_SMBLL_U|!ROM_SMBLL_E|!ROM_SMBLL_J) != $00
	PHX
	PHY
	JSL.l SMBLL_LoadFileSelectMenu_Main
	PLY
	PLX
endif
	PLB
	RTL

;--------------------------------------------------------------------

DATA_0FE8BC:
	db $00,$30

CODE_0FE8BE:
	PHB
	PHK
	PLB
	STY.b $00
	LDA.w $03B9
	LDX.w $039A,y
	LDY.w $0B46,x
	STY.b $02
	DEC
	JSR.w CODE_0FE94B
	LDA.w $03AE
	STA.w $0900,y
	STA.w $0908,y
	STA.w $0910,y
	STA.w $0904,y
	STA.w $090C,y
	STA.w $0914,y
	STA.w $0918,y
	STA.w $091C,y
	STA.w $0920,y
	LDA.b #$1B
	STA.w $0903,y
	STA.w $090B,y
	STA.w $0913,y
	STA.w $0907,y
	STA.w $090F,y
	STA.w $0917,y
	STA.w $091B,y
	STA.w $091F,y
	STA.w $0923,y
	LDX.b #$08
CODE_0FE90F:
	LDA.b #$2C
	STA.w $0902,y
	INY
	INY
	INY
	INY
	DEX
	BPL.b CODE_0FE90F
	LDY.b $02
	LDA.w $0000
	BNE.b CODE_0FE927
	LDA.b #$2A
	STA.w $0902,y
CODE_0FE927:
	LDA.w $0399
	LSR
	LSR
	LSR
	LSR
	INC
	TAX
	ASL
	ASL
	CLC
	ADC.b $02
	TAY
CODE_0FE936:
	CPX.b #$09
	BCS.b CODE_0FE946
	LDA.b #$F0
	STA.w $0901,y
	INY
	INY
	INY
	INY
	INX
	BRA.b CODE_0FE936

CODE_0FE946:
	LDY.w $0000
	PLB
	RTL

CODE_0FE94B:
	LDX.b #$09
CODE_0FE94D:
	STA.w $0901,y
	PHA
	LDA.w $0223
	STA.b $E4
	LDA.b $82
	STA.b $E5
	REP.b #$20
	LDA.b $E4
	SEC
	SBC.b $42
	STA.b $E4
	SEP.b #$20
	LDA.b #$02
	STA.b $DD
	LDA.b $E5
	BEQ.b CODE_0FE96F
	LDA.b #$01
CODE_0FE96F:
	ORA.b $DD
	STA.w $0D00,y
	LDA.w $0236
	BNE.b CODE_0FE987
	LDA.w $0901,y
	BPL.b CODE_0FE987
	CMP.b #$F0
	BCS.b CODE_0FE987
	LDA.b #$F0
	STA.w $0901,y
CODE_0FE987:
	PLA
	CLC
	ADC.b #$10
	INY
	INY
	INY
	INY
	DEX
	BNE.b CODE_0FE94D
	LDY.b $02
	RTS

;--------------------------------------------------------------------

CODE_0FE995:
	LDY.w $0B53
	REP.b #$20
	LDA.w $0E70
	SEC
	SBC.b $42
	STA.w $0E6B
	SEP.b #$20
	LDA.w $0E6F
	BNE.b CODE_0FE9D5
	LDA.w $0E6D
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	CMP.b #$B0
	BCC.b +
	LDA.b #$F0
+:
endif
	STA.w $0801,y
	LDA.w $0E6B
	JSR.w CODE_0FEB06
	STA.w $0800,y
	LDA.b #$26
	STA.w $0802,y
	LDA.b #$29
	STA.w $0803,y
	DEC.w $0E6E
	BEQ.b CODE_0FE9CB
	JMP.w CODE_0FEA0F

CODE_0FE9CB:
	LDA.b #$06
	STA.w $0E6E
	INC.w $0E6F
	BRA.b CODE_0FEA0F

CODE_0FE9D5:
	LDA.w $0E6F
	CMP.b #$06
	BCS.b CODE_0FEA0F
	PHX
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_J1) != $00
	LDX.w $0E6F
	LDA.w DATA_0FEACC,x
	CLC
	ADC.w $0E6B
	STA.w SMBLL_OAMBuffer[$00].XDisp,y
	STA.w SMBLL_OAMBuffer[$01].XDisp,y
	JSR.w CODE_0FEB06
	LDA.w DATA_0FEAD8,x
	CLC
	ADC.w $0E6D
	STA.w SMBLL_OAMBuffer[$00].YDisp,y
	CLC
	ADC.b #$08
	STA.w SMBLL_OAMBuffer[$01].YDisp,y
	LDA.w DATA_0FEAD2,x
	CLC
	ADC.w $0E6B
	STA.w SMBLL_OAMBuffer[$02].XDisp,y
	STA.w SMBLL_OAMBuffer[$03].XDisp,y
	JSR.w CODE_0FEB06
	LDA.w DATA_0FEAD8,x
	CLC
	ADC.w $0E6D
	STA.w SMBLL_OAMBuffer[$02].YDisp,y
	CLC
	ADC.b #$08
	STA.w SMBLL_OAMBuffer[$03].YDisp,y
else
	JSR.w CODE_0FEA41
endif
	LDX.w $0E6F
	DEX
	TXA
	ASL
	ASL
	TAX
	LDA.b #$03
	STA.b $04
CODE_0FE9EC:
	LDA.w DATA_0FEADE,x
	STA.w $0802,y
	LDA.w DATA_0FEAF2,x
	STA.w $0803,y
	INY
	INY
	INY
	INY
	INX
	DEC.b $04
	BPL.b CODE_0FE9EC
	DEC.w $0E6E
	BNE.b CODE_0FEA0E
	LDA.b #$06
	STA.w $0E6E
	INC.w $0E6F
CODE_0FEA0E:
	PLX
CODE_0FEA0F:
	JMP.w CODE_0FEB86

;--------------------------------------------------------------------

CODE_0FEA12:
	LDA.b $09
	LSR
	BCS.b CODE_0FEA1A
	DEC.w $0248,x
CODE_0FEA1A:
	LDA.w $0248,x
	STA.w $0801,y
	LDA.w $03B3
	STA.w $0800,y
	LDA.b #$02
	STA.w $0C00,y
	CMP.b #$F8
	BCC.b CODE_0FEA34
	LDA.b #$03
	STA.w $0C00,y
CODE_0FEA34:
	LDA.b #$23
	STA.w $0803,y
	LDA.b #$2E
	STA.w $0802,y
	JMP.w CODE_0FE995

;--------------------------------------------------------------------

if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_J1) == $00
CODE_0FEA41:
	LDX.w $0E6F
	REP.b #$20
	LDA.w DATA_0FEACC,x
	AND.w #$00FF
	ORA.w #$FF00
	CLC
	ADC.w $0E6B
	SEP.b #$20
	STA.w $0800,y
	STA.w $0804,y
	JSR.w CODE_0FEB06
	XBA
	BEQ.b CODE_0FEA69
	LDA.b #$01
	STA.w $0C00,y
	STA.w $0C04,y
CODE_0FEA69:
	LDA.w DATA_0FEAD8,x
	CLC
	ADC.w $0E6D
	STA.w $0801,y
	CLC
	ADC.b #$08
	STA.w $0805,y
	CMP.b #$F8
	BCS.b CODE_0FEA89
	CMP.b #$B0
	BCC.b CODE_0FEA89
	LDA.b #$F0
	STA.w $0801,y
	STA.w $0805,y
CODE_0FEA89:
	REP.b #$20
	LDA.w DATA_0FEAD2,x
	AND.w #$00FF
	CLC
	ADC.w $0E6B
	SEP.b #$20
	STA.w $0808,y
	STA.w $080C,y
	JSR.w CODE_0FEB06
	XBA
	BEQ.b CODE_0FEAAB
	LDA.b #$01
	STA.w $0C08,y
	STA.w $0C0C,y
CODE_0FEAAB:
	LDA.w DATA_0FEAD8,x
	CLC
	ADC.w $0E6D
	STA.w $0809,y
	CLC
	ADC.b #$08
	STA.w $080D,y
	CMP.b #$F8
	BCS.b CODE_0FEACB
	CMP.b #$B0
	BCC.b CODE_0FEACB
	LDA.b #$F0
	STA.w $0809,y
	STA.w $080D,y
CODE_0FEACB:
	RTS
endif

DATA_0FEACC:
	db $00,$FC,$FB,$FA,$FA,$FA

DATA_0FEAD2:
	db $00,$04,$05,$06,$06,$06

DATA_0FEAD8:
	db $00,$FC,$FC,$FE,$FE,$FF

;--------------------------------------------------------------------

DATA_0FEADE:
	db $27,$27,$28,$28,$36,$37,$36,$37
	db $36,$37,$36,$37,$38,$29,$38,$29
	db $38,$29,$38,$29

DATA_0FEAF2:
	db $29,$A9,$29,$A9,$29,$29,$69,$69
	db $29,$29,$69,$69,$29,$29,$69,$69
	db $29,$29,$69,$69

;--------------------------------------------------------------------

CODE_0FEB06:
	PHA
	CMP.b #$F8
	BCC.b CODE_0FEB13
	LDA.b #$01
	STA.w $0C00,y
	STA.w $0C04,y
CODE_0FEB13:
	PLA
	RTS

;--------------------------------------------------------------------

CODE_0FEB15:
	LDA.w $0248,x
	CLC
	ADC.b #$04
	STA.w $0E6D
	LDA.w $022A,x
	STA.w $0E70
	LDA.w $0089,x
	STA.w $0E71
	LDA.b #$06
	STA.w $0E6E
	STZ.w $0E6F
	RTL

;--------------------------------------------------------------------

DATA_0FEB33:
	db $28,$2A,$2C,$2E

CODE_0FEB37:
	PHB
	PHK
	PLB
	LDY.w $0B62,x
	LDA.b $39,x
	CMP.b #$02
	BCC.b CODE_0FEB46
	JMP.w CODE_0FEA12

CODE_0FEB46:
	LDA.b $B1,x
	BMI.b CODE_0FEB4D
	JMP.w CODE_0FE995

CODE_0FEB4D:
	LDA.w $0248,x
if !Define_Global_ROMToAssemble&(!ROM_SMAS_U|!ROM_SMAS_J1) == $00
	CMP.b #$B0
	BCC.b CODE_0FEB56
	LDA.b #$F0
endif
CODE_0FEB56:
	STA.w $0801,y
	LDA.w $03B3
	SEC
	SBC.b #$04
	STA.b $E4
	CMP.b #$F0
	BCS.b CODE_0FEB69
	LDA.b #$02
	BRA.b CODE_0FEB6B

CODE_0FEB69:
	LDA.b #$03
CODE_0FEB6B:
	STA.w $0C00,y
	LDA.b $E4
	STA.w $0800,y
	LDA.b $09
	LSR
	AND.b #$03
	TAX
	LDA.w DATA_0FEB33,x
	STA.w $0802,y
	LDA.b #$28
	STA.w $0803,y
	LDX.b $9E
CODE_0FEB86:
	PLB
	RTL

;--------------------------------------------------------------------

DATA_0FEB88:
	db $04,$00,$04,$00

DATA_0FEB8C:
	db $00,$04,$00,$04,$00,$08,$00,$08
	db $08,$00,$08,$00

DATA_0FEB98:
	db $44,$46,$44,$46,$81,$83,$80,$82

DATA_0FEBA0:
	db $2A,$2A,$AA,$6A

CODE_0FEBA4:
	PHB
	PHK
	PLB
	LDY.w $0B62,x
	LDA.w $0747
	BNE.b CODE_0FEBB7
	LDA.b $39,x
	AND.b #$7F
	CMP.b #$01
	BEQ.b CODE_0FEBBB
CODE_0FEBB7:
	LDX.b #$00
	BEQ.b CODE_0FEBC2

CODE_0FEBBB:
	LDA.b $09
	LSR
	LSR
	AND.b #$03
	TAX
CODE_0FEBC2:
	LDA.w $03BE
	CLC
	ADC.w DATA_0FEB8C,x
	STA.w $0801,y
	REP.b #$20
	LDA.w DATA_0FEB88,x
	AND.w #$00FF
	CLC
	ADC.w $0E93
	SEC
	SBC.w #$0008
	STA.b $E4
	SEP.b #$20
	LDA.b $E4
	STA.w $0800,y
	LDA.b #$02
	STA.w $0C00,y
	LDA.b $E5
	BEQ.b CODE_0FEBF3
	LDA.b #$03
	STA.w $0C00,y
CODE_0FEBF3:
	LDA.w DATA_0FEB98,x
	STA.w $0802,y
	LDA.w DATA_0FEBA0,x
	STA.w $0803,y
	LDA.w $03D6
	AND.b #$0F
	CMP.b #$0F
	BEQ.b CODE_0FEC0F
	LDA.w $03D6
	AND.b #$F0
	BEQ.b CODE_0FEC13
CODE_0FEC0F:
	LDX.b $9E
	STZ.b $39,x
CODE_0FEC13:
	LDX.b $9E
	PLB
	RTL

;--------------------------------------------------------------------

SMBLL_CompressOAMTileSizeBuffer_Main:
;$0FEC17
	PHD
	LDA.b #$0C00>>8
	XBA
	LDA.b #$0C00
	TCD
	REP.b #$10
	LDX.w #$0000
	TXY
CODE_0FEC24:
	LDA.b $0C0C,x
	LSR
	ROR
	ROR
	STA.b $0C01
	LDA.b $0C08,x
	ASL
	ASL
	ASL
	ASL
	TSB.b $0C01
	LDA.b $0C04,x
	ASL
	ASL
	TSB.b $0C01
	LDA.b $0C00,x
	ORA.b $0C01
	STA.w $0A00,y
	INY
	LDA.b $0C1C,x
	LSR
	ROR
	ROR
	STA.b $0C01
	LDA.b $0C18,x
	ASL
	ASL
	ASL
	ASL
	TSB.b $0C01
	LDA.b $0C14,x
	ASL
	ASL
	TSB.b $0C01
	LDA.b $0C10,x
	ORA.b $0C01
	STA.w $0A00,y
	INY
	REP.b #$20
	TXA
	CLC
	ADC.w #$0020
	TAX
	SEP.b #$20
	CPX.w #$0200
	BCC.b CODE_0FEC24
	SEP.b #$10
	PLD
	RTL

;--------------------------------------------------------------------

CODE_0FEC71:
	LDA.w $02F7
	BNE.b CODE_0FECA5
	LDY.b $BB
	DEY
	BNE.b CODE_0FECA5
	LDA.w $03D3
	AND.b #$08
	BNE.b CODE_0FECA5
	LDY.w $0B53,x
	LDA.w $03B0
	STA.w $0800,y
	LDA.w $03BB
	STA.w $0801,y
	LDA.b #$9F
	STA.w $0802,y
	LDA.b $0F
	CMP.b #$07
	BNE.b CODE_0FECA0
	LDA.b #$0A
	BRA.b CODE_0FECA2

CODE_0FECA0:
	LDA.b #$2A
CODE_0FECA2:
	STA.w $0803,y
CODE_0FECA5:
	RTL

;--------------------------------------------------------------------

DATA_0FECA6:
	dw $1BDF,$027F,$0139
	dw $0000,$4BFF,$1F5F
	dw $0D9C,$0000,$7FFF
	dw $4BFF,$19FF,$0000

DATA_0FECBE:
	dw $1ADA,$0DF3,$050D
	dw $0000,$2B5E,$1E77
	dw $1170,$0000,$3BDF
	dw $2EFB,$1DD3,$0000

DATA_0FECD6:
	dw $477F,$3298,$15B1
	dw $0000,$671B,$4A34
	dw $2D4D,$0000,$7E97
	dw $6DB0,$54EA,$0000

DATA_0FECEE:
	dw $035F,$0259,$3800
	dw $0000,$03FF,$02BC
	dw $0016,$0000,$7FFF
	dw $47FF,$00DF,$0000

DATA_0FED06:
	dw $2CC5,$3D89,$3DCD,$4E51,$2EF8,$1E74
	dw $1C41,$28A3,$28A4,$3548,$3D8B,$4A0F
	dw $32D6,$1E31,$1C41,$28A3,$2062,$2CC6
	dw $3927,$418B,$3250,$21AB,$1C41,$28A3
	dw $2483,$3107,$3949,$45CD,$3293,$1DEE
	dw $1C41,$28A3,$2062,$2CC6,$3927,$418B
	dw $3250,$21AB,$1C41,$28A3,$2483,$3107
	dw $3949,$45CD,$3293,$1DEE,$1C41,$28A3
	dw $28A4,$3548,$3D8B,$4A0F,$32D6,$1E31
	dw $1C41,$28A3,$2CC5,$3D89,$3DCD,$4E51
	dw $2EF8,$1E74,$1C41,$28A3

CODE_0FED86:
	LDA.w $0200
	BEQ.b CODE_0FED8D
	PLB
	RTL

CODE_0FED8D:
	INC.w $0E74
	LDA.w $0E74
	AND.b #$07
	BEQ.b CODE_0FED9A
	JMP.w CODE_0FEE0D

CODE_0FED9A:
	INC.w $0E75
	LDA.w $0E75
	CMP.b #$03
	BNE.b CODE_0FEDA9
	STZ.w $0E75
	LDA.b #$00
CODE_0FEDA9:
	ASL
	ASL
	ASL
	TAX
	REP.b #$20
	LDA.w DATA_0FECA6,x
	STA.w $1026
	LDA.w DATA_0FECEE,x
	STA.w $100A
	LDA.w DATA_0FECBE,x
	STA.w $102C
	LDA.w DATA_0FECA6+$02,x
	STA.w $1028
	LDA.w DATA_0FECEE+$02,x
	STA.w $100C
	LDA.w DATA_0FECBE+$02,x
	STA.w $102E
	LDA.w DATA_0FECA6+$04,x
	STA.w $102A
	LDA.w DATA_0FECEE+$04,x
	STA.w $100E
	LDA.w DATA_0FECBE+$04,x
	STA.w $1030
	SEP.b #$20
	LDA.w $0F26
	BEQ.b CODE_0FEE08
	DEC
	ASL
	TAX
	LDA.w DATA_0FEE00,x
	STA.b $E4
	LDA.w DATA_0FEE00+$01,x
	STA.b $E5
	LDA.b #$05
	STA.b $E6
	JMP.w ($00E4)

DATA_0FEE00:
	dw CODE_0FEE44
	dw CODE_0FEE08
	dw CODE_0FEE71
	dw CODE_0FEF53

CODE_0FEE08:
	LDA.b #$01
	STA.w !RAM_SMBLL_Global_UpdateEntirePaletteFlag
CODE_0FEE0D:
	LDA.w $0E74
	AND.b #$03
	BNE.b CODE_0FEE42
	INC.w $0E76
	LDA.w $0E76
	CMP.b #$03
	BNE.b CODE_0FEE23
	STZ.w $0E76
	LDA.b #$00
CODE_0FEE23:
	ASL
	ASL
	ASL
	TAX
	REP.b #$20
	LDA.w DATA_0FECD6,x
	STA.w $1032
	LDA.w DATA_0FECD6+$02,x
	STA.w $1034
	LDA.w DATA_0FECD6+$04,x
	STA.w $1036
	SEP.b #$20
	LDA.b #$01
	STA.w !RAM_SMBLL_Global_UpdateEntirePaletteFlag
CODE_0FEE42:
	PLB
	RTL

CODE_0FEE44:
	LDA.w $0E74
	AND.b #$38
	LSR
	LSR
	TAX
	REP.b #$20
	LDA.w DATA_0FEEA3,x
	STA.w $10E6
	LDA.w DATA_0FEEB3,x
	STA.w $10E8
	LDA.w DATA_0FEEC3,x
	STA.w $10FA
	LDA.w DATA_0FEED3,x
	STA.w $10FC
	LDA.w DATA_0FEEE3,x
	STA.w $10FE
	SEP.b #$20
	JMP.w CODE_0FEE08

CODE_0FEE71:
	LDA.w $0E74
	AND.b #$38
	ASL
	TAX
	REP.b #$20
	LDA.w DATA_0FED06,x
	STA.w $10E6
	LDA.w DATA_0FED06+$02,x
	STA.w $10E8
	LDA.w DATA_0FED06+$04,x
	STA.w $10EA
	LDA.w DATA_0FED06+$06,x
	STA.w $10EC
	LDA.w DATA_0FED06+$08,x
	STA.w $10EE
	LDA.w DATA_0FED06+$0A,x
	STA.w $10F0
	SEP.b #$20
	JMP.w CODE_0FEE08

DATA_0FEEA3:
	dw $7FBF,$7F38,$76B4,$7230,$7FBF,$7F38,$76B4,$7230

DATA_0FEEB3:
	dw $7F38,$76B4,$7230,$7FBF,$7F38,$76B4,$7230,$7FBF

DATA_0FEEC3:
	dw $76B4,$7230,$7FBF,$7F38,$76B4,$7230,$7FBF,$7F38

DATA_0FEED3:
	dw $69C9,$6187,$5945,$5103,$69C9,$69C9,$69C9,$5946

DATA_0FEEE3:
	dw $7230,$7FBF,$7F38,$76B4,$7230,$7FBF,$7F38,$76B4

DATA_0FEEF3:
	dw $0C63,$1CE5,$2927,$2506
	dw $0C63,$1D07,$252A,$2109
	dw $0C63,$1929,$212C,$1D2B
	dw $0C63,$1D07,$252A,$2109
	dw $0C63,$1CE5,$2927,$2506
	dw $0C63,$1D07,$252A,$2109
	dw $0C63,$1929,$212C,$1D2B
	dw $0C63,$1D07,$252A,$2109

DATA_0FEF33:
	dw $0077,$017A,$0098,$019B
	dw $00B9,$01BC,$00FB,$01FE
	dw $00DA,$01DD,$00B9,$01BC
	dw $0098,$019B,$0077,$017A

CODE_0FEF53:
	LDA.w $0E74
	AND.b #$38
	TAX
	LSR
	TAY
	REP.b #$20
	LDA.w DATA_0FEEF3,x
	STA.w $10E2
	LDA.w DATA_0FEEF3+$02,x
	STA.w $10E4
	LDA.w DATA_0FEEF3+$04,x
	STA.w $10E6
	LDA.w DATA_0FEEF3+$06,x
	STA.w $10E8
	LDA.w DATA_0FEF33,y
	STA.w $10FC
	LDA.w DATA_0FEF33+$02,y
	STA.w $10FE
	SEP.b #$20
	LDA.b !RAM_SMBLL_NorSpr_SpriteID
	CMP.b #$35
	BEQ.b CODE_0FEFFD
	LDA.w $0EB7
	BNE.b CODE_0FEFB2
	LDA.w $07B8
	AND.b #$0F
	BNE.b CODE_0FEFFD
	LDA.b $0F
	CMP.b #$08
	BNE.b CODE_0FEFA0
	LDA.b #!Define_SMAS_Sound0063_Thunder
	STA.w !RAM_SMBLL_Global_SoundCh3
CODE_0FEFA0:
	LDA.b #$11
	STA.w $0EB8
	LDA.b #$1F
	STA.w $0EB9
	STA.w $0EBA
	INC.w $0EB7
	BRA.b CODE_0FEFDA

CODE_0FEFB2:
	DEC.w $0EB8
	DEC.w $0EB9
	DEC.w $0EB9
	DEC.w $0EBA
	DEC.w $0EBA
	DEC.w $0EB8
	DEC.w $0EB9
	DEC.w $0EB9
	DEC.w $0EBA
	DEC.w $0EBA
	LDA.w $0EB8
	CMP.b #$03
	BNE.b CODE_0FEFDA
	STZ.w $0EB7
CODE_0FEFDA:
	REP.b #$20
	LDA.w $0EB8
	AND.w #$00FF
	XBA
	ASL
	ASL
	STA.b $E4
	LDA.w $0EB9
	AND.w #$00FF
	XBA
	LSR
	LSR
	LSR
	ORA.b $E4
	ORA.w $0EBA
	STA.b $E4
	STA.w $10E2
	SEP.b #$20
CODE_0FEFFD:
	JMP.w CODE_0FEE08

;--------------------------------------------------------------------

CODE_0FF000:
	STZ.w $028D
	LDA.b $09
	AND.b #$07
	BNE.b CODE_0FF041
	LDA.b $09
	AND.b #$38
	LSR
	LSR
	LSR
	STA.b $04
	LDA.b #SMBLL_UncompressedGFX_AnimatedTiles>>16
	STA.w $0287
	REP.b #$20
	LDA.w #$8000
	LDY.b $04
CODE_0FF01E:
	DEY
	BMI.b CODE_0FF027
	CLC
	ADC.w #$0800
	BRA.b CODE_0FF01E

CODE_0FF027:
	CLC
	ADC.w #$4000
	STA.w $0285
	LDA.w #$1C00
	STA.w $028A
	LDA.w #$0600
	STA.w $0288
	SEP.b #$20
	INC.w $028D
	BRA.b CODE_0FF075

CODE_0FF041:
	LDA.b $09
	CLC
	ADC.b #$04
	STA.w $0285
	AND.b #$07
	BNE.b CODE_0FF075
	LDA.b #SMBLL_UncompressedGFX_Layer3>>16
	STA.w $0287
	REP.b #$20
	LDA.w $0285
	AND.w #$0038
	ASL
	ASL
	ASL
	CLC
	ADC.w #SMBLL_UncompressedGFX_Layer3+$0300
	STA.w $0285
	LDA.w #$5160
	STA.w $028A
	LDA.w #$0040
	STA.w $0288
	SEP.b #$20
	INC.w $028D
CODE_0FF075:
	RTL

;--------------------------------------------------------------------

DATA_0FF076:
	db $01,$18

CODE_0FF078:
	SEP.b #$30
	PHB
	PHK
	PLB
	LDA.b $99
	CMP.b #$01
	BNE.b CODE_0FF08E
	STA.w $02F8
	LDX.w $0753
	LDA.w DATA_0FF076,x
	STA.b $99
CODE_0FF08E:
	JSR.w CODE_0FF200
	LDA.b $99
	ASL
	TAX
	LDA.w DATA_0FF0A2,x
	STA.b $00
	LDA.w DATA_0FF0A2+$01,x
	STA.b $01
	JMP.w ($0000)

DATA_0FF0A2:
	dw CODE_0FF0F1
	dw CODE_0FF112
	dw CODE_0FF0FD
	dw CODE_0FF112
	dw CODE_0FF125
	dw CODE_0FF0FD
	dw CODE_0FF0F1
	dw CODE_0FF119
	dw CODE_0FF0E2
	dw CODE_0FF119
	dw CODE_0FF131
	dw CODE_0FF0FD
	dw CODE_0FF0FD
	dw CODE_0FF0F1
	dw CODE_0FF0FD
	dw CODE_0FF0F1
	dw CODE_0FF0FD
	dw CODE_0FF0F1
	dw CODE_0FF0F1
	dw CODE_0FF0F1
	dw CODE_0FF0F1
	dw CODE_0FF0F1
	dw CODE_0FF0F1
	dw CODE_0FF0F1
	dw CODE_0FF112
	dw CODE_0FF0F1
	dw CODE_0FF0F1
	dw CODE_0FF0F1
	dw CODE_0FF0F1
	dw CODE_0FF0F1
	dw CODE_0FF0F1
	dw CODE_0FF0F1

CODE_0FF0E2:
	LDA.w $075F
	CMP.b #$08
	BNE.b CODE_0FF0F1
	LDA.b #$11
	STA.w $0099
	JSR.w CODE_0FF200
CODE_0FF0F1:
	STZ.b $99
	PLB
	STZ.w $028D
	LDA.b #$01
	STA.w $028C
	RTL

CODE_0FF0FD:
	LDA.b $DB
	CMP.b #$13
	BEQ.b CODE_0FF11E
	CMP.b #$19
	BEQ.b CODE_0FF11E
	CMP.b #$2F
	BEQ.b CODE_0FF11E
	LDA.b #$17
	JSR.w CODE_0FF200
	BRA.b CODE_0FF0F1

CODE_0FF112:
	LDA.b #$11
	JSR.w CODE_0FF200
	BRA.b CODE_0FF0F1

CODE_0FF119:
	LDA.b #$16
	JSR.w CODE_0FF200
CODE_0FF11E:
	LDA.b #$12
	JSR.w CODE_0FF200
	BRA.b CODE_0FF0F1

CODE_0FF125:
	LDA.b #$13
	JSR.w CODE_0FF200
	LDA.b #$14
	JSR.w CODE_0FF200
	BRA.b CODE_0FF0F1

CODE_0FF131:
	LDA.b #$15
	JSR.w CODE_0FF200
	BRA.b CODE_0FF0F1

;--------------------------------------------------------------------

DATA_0FF138:
	dw $000000>>16,SMBLL_UncompressedGFX_BG_BonusRoom_Mario>>16,SMBLL_UncompressedGFX_BG_HillsAndTrees>>16,SMBLL_UncompressedGFX_BG_Cave>>16,SMBLL_UncompressedGFX_FG_BG_Castle>>16,SMBLL_UncompressedGFX_BG_DottedHills>>16,SMBLL_UncompressedGFX_FG_BG_Castle>>16,SMBLL_UncompressedGFX_BG_HillsAndTrees>>16
	dw SMBLL_UncompressedGFX_BG_Underwater>>16,SMBLL_UncompressedGFX_BG_HillsAndTrees>>16,SMBLL_UncompressedGFX_BG_DeathScreen1>>16,SMBLL_UncompressedGFX_BG_Night>>16,SMBLL_UncompressedGFX_BG_Castle>>16,SMBLL_UncompressedGFX_BG_Mushrooms>>16,SMBLL_UncompressedGFX_BG_Waterfalls>>16,SMBLL_UncompressedGFX_BG_UnderwaterCastle>>16
	dw SMBLL_UncompressedGFX_BG_Pillars>>16,SMBLL_UncompressedGFX_FG_Cave>>16,SMBLL_UncompressedGFX_FG_Snow>>16,SMBLL_UncompressedGFX_BG_FinalCastle1>>16,SMBLL_UncompressedGFX_BG_FinalCastle2>>16,SMBLL_UncompressedGFX_BG_DeathScreen2>>16,SMBLL_UncompressedGFX_BG_Night>>16,SMBLL_UncompressedGFX_FG_Grassland>>16
	dw SMBLL_UncompressedGFX_BG_BonusRoom_Luigi>>16

DATA_0FF16A:
	dw $000000,SMBLL_UncompressedGFX_BG_BonusRoom_Mario,SMBLL_UncompressedGFX_BG_HillsAndTrees,SMBLL_UncompressedGFX_BG_Cave,SMBLL_UncompressedGFX_FG_BG_Castle,SMBLL_UncompressedGFX_BG_DottedHills,SMBLL_UncompressedGFX_FG_BG_Castle,SMBLL_UncompressedGFX_BG_HillsAndTrees
	dw SMBLL_UncompressedGFX_BG_Underwater,SMBLL_UncompressedGFX_BG_HillsAndTrees,SMBLL_UncompressedGFX_BG_DeathScreen1,SMBLL_UncompressedGFX_BG_Night,SMBLL_UncompressedGFX_BG_Castle,SMBLL_UncompressedGFX_BG_Mushrooms,SMBLL_UncompressedGFX_BG_Waterfalls,SMBLL_UncompressedGFX_BG_UnderwaterCastle
	dw SMBLL_UncompressedGFX_BG_Pillars,SMBLL_UncompressedGFX_FG_Cave,SMBLL_UncompressedGFX_FG_Snow,SMBLL_UncompressedGFX_BG_FinalCastle1,SMBLL_UncompressedGFX_BG_FinalCastle2,SMBLL_UncompressedGFX_BG_DeathScreen2,SMBLL_UncompressedGFX_BG_Night,SMBLL_UncompressedGFX_FG_Grassland
	dw SMBLL_UncompressedGFX_BG_BonusRoom_Luigi

DATA_0FF19C:
	dw $0000,$2000,$2000,$2000,$2000,$2C00,$2000,$2000
	dw $2000,$2000,$3400,$2C00,$2800,$2C00,$2C00,$2000
	dw $2C00,$3000,$3000,$2000,$2800,$2C00,$2C00,$3000
	dw $2000

DATA_0FF1CE:
	dw $1000,$1000,$2000,$1000,$2000,$0800,$2000,$1000
	dw $1000,$2000,$2000,$0800,$1000,$0800,$0800,$1000
	dw $1000,$1000,$1000,$0800,$0800,$0800,$0800,$1000
	dw $1000

CODE_0FF200:
	ASL
	TAX
	LDA.w DATA_0FF138,x
	STA.w $0287
	REP.b #$20
	LDA.w DATA_0FF16A,x
	STA.w $0285
	LDA.w DATA_0FF19C,x
	STA.w $028A
	LDA.w DATA_0FF1CE,x
	STA.w $0288
	SEP.b #$20
	JSR.w CODE_0FF222
CODE_0FF221:
	RTS

CODE_0FF222:
	LDA.b #$80
	STA.w !REGISTER_VRAMAddressIncrementValue
CODE_0FF226:
	REP.b #$20
	LDA.w $028A
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STA.w DMA[$00].Parameters
	LDA.w $0285
	STA.w DMA[$00].SourceLo
	LDX.w $0287
	STX.w DMA[$00].SourceBank
	LDA.w $0288
	STA.w DMA[$00].SizeLo
	LDX.b #$01
	STX.w !REGISTER_DMAEnable
	SEP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_0FF24F:
	LDA.w $0F04
	BEQ.b CODE_0FF283
	LDA.b $5C
	CMP.b #$01
	BNE.b CODE_0FF283
	LDY.b #$01
	LDA.w $0009
	ASL
	BCS.b CODE_0FF264
	LDY.b #$03
CODE_0FF264:
	STY.w $0000
	LDA.w $0009
	AND.w $0000
	BNE.b CODE_0FF283
	LDA.w $0219
	CLC
	ADC.b #$01
	STA.w $0219
	LDA.w $0078
	ADC.b #$00
	STA.w $0078
	INC.w $06FF
CODE_0FF283:
	RTL

;--------------------------------------------------------------------

DATA_0FF284:
	db $30,$70,$B8,$50,$98,$30,$70,$B8
	db $50,$98,$30,$70

DATA_0FF290:
	db $30,$30,$30,$60,$60,$A0,$A0,$A0
	db $D0,$D0,$D0,$60

;--------------------------------------------------------------------

DATA_0FF29C:
	db $91,$91,$91,$91,$92,$92,$91,$91
	db $91,$92,$91,$92

CODE_0FF2A8:
	PHB
	PHK
	PLB
	LDA.w $0E67
	BNE.b CODE_0FF2F3
	LDA.w $0F04
	BEQ.b CODE_0FF2F3
	JSR.w CODE_0FF30D
	LDX.b #$00
	LDY.b #$00
CODE_0FF2BC:
	LDA.w $0901,y
	CMP.b #$F0
	BEQ.b CODE_0FF2CE
	INY
	INY
	INY
	INY
	TYA
	AND.b #$FF
	BEQ.b CODE_0FF2F3
	BRA.b CODE_0FF2BC

CODE_0FF2CE:
	LDA.w $0F18,x
	STA.w $0901,y
	LDA.w DATA_0FF29C,x
	STA.w $0902,y
	LDA.b #$2A
	STA.w $0903,y
	LDA.w $0F0C,x
	STA.w $0900,y
	LDA.b #$00
	STA.w $0D00,y
	INY
	INY
	INY
	INY
	INX
	CPX.b #$0C
	BNE.b CODE_0FF2BC
CODE_0FF2F3:
	PLB
	RTL

;--------------------------------------------------------------------

DATA_0FF2F5:
	db $57,$57,$56,$56,$58,$58,$56,$56
	db $57,$58,$57,$58,$59,$59,$58,$58
	db $5A,$5A,$58,$58,$59,$5A,$59,$5A

CODE_0FF30D:
	LDX.b #$0B
CODE_0FF30F:
	LDA.w $0F0C,x
	CLC
	ADC.w DATA_0FF2F5,x
	ADC.w DATA_0FF2F5,x
	STA.w $0F0C,x
	LDA.w $0F18,x
	CLC
	ADC.w DATA_0FF2F5,x
	STA.w $0F18,x
	DEX
	BPL.b CODE_0FF30F
	RTS

;--------------------------------------------------------------------

CODE_0FF32A:
	PHB
	PHK
	PLB
	PHX
	LDX.b #$0B
CODE_0FF330:
	LDA.w DATA_0FF290,x
	STA.w $0F0C,x
	LDA.w DATA_0FF284,x
	STA.w $0F18,x
	DEX
	BPL.b CODE_0FF330
	PLX
	PLB
	LDA.b #!Define_SMAS_Sound0061_TurnOnWind
	STA.w $0F4B
	TSB.w !RAM_SMBLL_Global_SoundCh2
	LDA.b #$01
	BNE.b CODE_0FF357						; Note: This will always branch.

CODE_0FF34D:
	STZ.w $0F4B
	LDA.b #!Define_SMAS_Sound0061_TurnOffWind
	TSB.w !RAM_SMBLL_Global_SoundCh2
	LDA.b #$00
CODE_0FF357:
	STA.w $0F04
	RTL

;--------------------------------------------------------------------

SMBLL_TitleScreenMenuCursorStripeImage:
;$0FF35B
	dw SMBLL_TitleScreenMenuCursorStripeImage_End-SMBLL_TitleScreenMenuCursorStripeImage
if !Define_Global_ROMToAssemble&(!ROM_SMBLL_U|!ROM_SMBLL_E|!ROM_SMBLL_J) != $00
	db $02,$4C,$80,$0D
	db $24,$10,$24,$10,$24,$10,$24,$10,$24,$10,$24,$10,$24,$10

else
	db $02,$4C,$80,$05,$2E,$12,$24,$10
	db $24,$10
endif
.End:
	db $FF

CODE_0FF368:
	PHB
	PHK
	PLB
	LDY.b #SMBLL_TitleScreenMenuCursorStripeImage_End-SMBLL_TitleScreenMenuCursorStripeImage
CODE_0FF36D:
	LDA.w SMBLL_TitleScreenMenuCursorStripeImage,y
	STA.w $1700,y
	DEY
	BPL.b CODE_0FF36D
	LDA.w $077A
if !Define_Global_ROMToAssemble&(!ROM_SMBLL_U|!ROM_SMBLL_E|!ROM_SMBLL_J) != $00
	ASL
	ASL
	TAY
	LDA.b #$2E
	STA.w SMBLL_StripeImageUploadTable[$02].LowByte,y
	LDA.b #$12
	STA.w SMBLL_StripeImageUploadTable[$02].HighByte,y
	DEC.w $1700
	DEC.w $1700
else
	BEQ.b CODE_0FF38F
	LDA.b #$24
	STA.w $1706
	LDA.b #$10
	STA.w $1707
	LDA.b #$2E
	STA.w $170A
	LDA.b #$12
	STA.w $170B
endif
CODE_0FF38F:
	PLB
	RTL

;--------------------------------------------------------------------

; Note: Stripe image pointers and data

DATA_0FF391:
	db $001702,DATA_0FF69F,DATA_0FF69F,DATA_0FF69F,DATA_0FF69F,$001702,$001A02,$001A02
	db DATA_0FF69F,DATA_0FF69F,DATA_0FF69F,DATA_0FF69F,DATA_0FF6A0,DATA_0FF6EA,DATA_0FF3D5,DATA_0FF3D6
	db DATA_0FF3D7,DATA_0FF421,DATA_0FF442,DATA_0FF46B,DATA_0FF4B5,DATA_0FF4D4,DATA_0FF4FF,DATA_0FF52C
	db DATA_0FF551,DATA_0FF580,DATA_0FF580,DATA_0FF58D,SMBLL_TitleScreenMenuCursorStripeImage,DATA_0FF58D,DATA_0FF60C,DATA_0FF6C5
	db DATA_0FF3FC,DATA_0FF490

DATA_0FF3B3:
	db $001702>>8,DATA_0FF69F>>8,DATA_0FF69F>>8,DATA_0FF69F>>8,DATA_0FF69F>>8,$001702>>8,$001A02>>8,$001A02>>8
	db DATA_0FF69F>>8,DATA_0FF69F>>8,DATA_0FF69F>>8,DATA_0FF69F>>8,DATA_0FF6A0>>8,DATA_0FF6EA>>8,DATA_0FF3D5>>8,DATA_0FF3D6>>8
	db DATA_0FF3D7>>8,DATA_0FF421>>8,DATA_0FF442>>8,DATA_0FF46B>>8,DATA_0FF4B5>>8,DATA_0FF4D4>>8,DATA_0FF4FF>>8,DATA_0FF52C>>8
	db DATA_0FF551>>8,DATA_0FF580>>8,DATA_0FF580>>8,DATA_0FF58D>>8,SMBLL_TitleScreenMenuCursorStripeImage>>8,DATA_0FF58D>>8,DATA_0FF60C>>8,DATA_0FF6C5>>8
	db DATA_0FF3FC>>8,DATA_0FF490>>8

DATA_0FF3D5:
	db $FF

DATA_0FF3D6:
	db $FF

DATA_0FF3D7:
	db $04,$E8,$00,$1F
	db $1D,$08,$11,$08,$0A,$08,$17,$08,$14,$08,$24,$08,$22,$08,$18,$08
	db $1E,$08,$24,$08,$16,$08,$0A,$08,$1B,$08,$12,$08,$18,$08,$2B,$08

	db $FF

DATA_0FF3FC:
	db $04,$E8,$00,$1F
	db $1D,$08,$11,$08,$0A,$08,$17,$08,$14,$08,$24,$08,$22,$08,$18,$08
	db $1E,$08,$24,$08,$15,$08,$1E,$08,$12,$08,$10,$08,$12,$08,$2B,$08

	db $FF

DATA_0FF421:
	db $05,$09,$00,$1B
	db $19,$08,$0E,$08,$0A,$08,$0C,$08,$0E,$08,$24,$08,$12,$08,$1C,$08
	db $24,$08,$19,$08,$0A,$08,$1F,$08,$0E,$08,$0D,$08

	db $FF

DATA_0FF442:
	db $05,$47,$00,$23
	db $20,$08,$12,$08,$1D,$08,$11,$08,$24,$08,$14,$08,$12,$08,$17,$08
	db $10,$08,$0D,$08,$18,$08,$16,$08,$24,$08,$1C,$08,$0A,$08,$1F,$08
	db $0E,$08,$0D,$08

	db $FF

DATA_0FF46B:
	db $05,$89,$00,$1F
	db $11,$08,$1E,$08,$1B,$08,$1B,$08,$0A,$08,$11,$08,$24,$08,$1D,$08
	db $18,$08,$24,$08,$24,$08,$16,$08,$0A,$08,$1B,$08,$12,$08,$18,$08

	db $FF

DATA_0FF490:
	db $05,$89,$00,$1F
	db $11,$08,$1E,$08,$1B,$08,$1B,$08,$0A,$08,$11,$08,$24,$08,$1D,$08
	db $18,$08,$24,$08,$24,$08,$15,$08,$1E,$08,$12,$08,$10,$08,$12,$08

	db $FF

DATA_0FF4B5:
	db $05,$CA,$00,$19
	db $18,$08,$1E,$08,$1B,$08,$24,$08,$18,$08,$17,$08,$15,$08,$22,$08
	db $24,$08,$11,$08,$0E,$08,$1B,$08,$18,$08

	db $FF

DATA_0FF4D4:
	db $06,$07,$00,$25
	db $1D,$08,$11,$08,$12,$08,$1C,$08,$24,$08,$0E,$08,$17,$08,$0D,$08
	db $1C,$08,$24,$08,$22,$08,$18,$08,$1E,$08,$1B,$08,$24,$08,$1D,$08
	db $1B,$08,$12,$08,$19,$08

	db $FF

DATA_0FF4FF:
	db $06,$46,$00,$27
	db $18,$08,$0F,$08,$24,$08,$0A,$08,$24,$08,$15,$08,$18,$08,$17,$08
	db $10,$08,$24,$08,$0F,$08,$1B,$08,$12,$08,$0E,$08,$17,$08,$0D,$08
	db $1C,$08,$11,$08,$12,$08,$19,$08

	db $FF

DATA_0FF52C:
	db $06,$88,$00,$1F
	db $01,$04,$00,$04,$00,$04,$00,$04,$00,$04,$00,$04,$24,$04,$19,$04
	db $1D,$04,$1C,$04,$AF,$04,$0A,$04,$0D,$04,$0D,$04,$0E,$04,$0D,$04

	db $FF

DATA_0FF551:
	db $06,$A6,$00,$29
	db $0F,$04,$18,$04,$1B,$04,$24,$04,$0E,$04,$0A,$04,$0C,$04,$11,$04
	db $24,$04,$19,$04,$15,$04,$0A,$04,$22,$04,$0E,$04,$1B,$04,$24,$04
	db $15,$04,$0E,$04,$0F,$04,$1D,$04,$AF,$04

	db $FF

DATA_0FF580:
	db $3F,$00,$00,$07
	db $0F,$08,$30,$08,$30,$08,$0F,$08

	db $FF

DATA_0FF58D:
	db $06,$24,$00,$2F
	db $20,$08,$0E,$08,$24,$08,$19,$08,$1B,$08,$0E,$08,$1C,$08,$0E,$08
	db $17,$08,$1D,$08,$24,$08,$0F,$08,$0A,$08,$17,$08,$1D,$08,$0A,$08
	db $1C,$08,$22,$08,$24,$08,$20,$08,$18,$08,$1B,$08,$15,$08,$0D,$08

	db $06,$66,$00,$25
	db $15,$08,$0E,$08,$1D,$08,$F2,$08,$1C,$08,$24,$08,$1D,$08,$1B,$08
	db $22,$08,$24,$08,$76,$08,$09,$08,$24,$08,$20,$08,$18,$08,$1B,$08
	db $15,$08,$0D,$08,$75,$08

	db $06,$A9,$00,$1B
	db $20,$08,$12,$08,$1D,$08,$11,$08,$24,$08,$18,$08,$17,$08,$0E,$08
	db $24,$08,$10,$08,$0A,$08,$16,$08,$0E,$08,$AF,$08

	db $FF

DATA_0FF60C:
	db $06,$25,$00,$2B
	db $22,$08,$18,$08,$1E,$08,$F2,$08,$1B,$08,$0E,$08,$24,$08,$0A,$08
	db $24,$08,$1C,$08,$1E,$08,$19,$08,$0E,$08,$1B,$08,$24,$08,$19,$08
	db $15,$08,$0A,$08,$22,$08,$0E,$08,$1B,$08,$2B,$08

	db $06,$69,$00,$19
	db $20,$08,$0E,$08,$24,$08,$11,$08,$18,$08,$19,$08,$0E,$08,$24,$08
	db $20,$08,$0E,$08,$F2,$08,$15,$08,$15,$08

	db $06,$A9,$00,$1B
	db $1C,$08,$0E,$08,$0E,$08,$24,$08,$22,$08,$18,$08,$1E,$08,$24,$08
	db $0A,$08,$10,$08,$0A,$08,$12,$08,$87,$10,$AF,$08

	db $06,$E8,$00,$1F
	db $16,$08,$0A,$08,$1B,$08,$12,$08,$18,$08,$24,$08,$0A,$08,$17,$08
	db $0D,$08,$24,$08,$1C,$08,$1D,$08,$0A,$08,$0F,$08,$0F,$08,$AF,$08

	db $FF

DATA_0FF69F:
	db $FF

DATA_0FF6A0:
	db $05,$48,$00,$1F
	db $1D,$08,$11,$08,$0A,$08,$17,$08,$14,$08,$24,$00,$22,$08,$18,$08
	db $1E,$08,$24,$00,$16,$08,$0A,$08,$1B,$08,$12,$08,$18,$08,$2B,$08

	db $FF

DATA_0FF6C5:
	db $05,$48,$00,$1F
	db $1D,$08,$11,$08,$0A,$08,$17,$08,$14,$08,$24,$00,$22,$08,$18,$08
	db $1E,$08,$24,$00,$15,$08,$1E,$08,$12,$08,$10,$08,$12,$08,$2B,$08

	db $FF

DATA_0FF6EA:
	db $05,$C5,$00,$2B
	db $0B,$08,$1E,$08,$1D,$08,$24,$00,$18,$08,$1E,$08,$1B,$08,$24,$00
	db $19,$08,$1B,$08,$12,$08,$17,$08,$0C,$08,$0E,$08,$1C,$08,$1C,$08
	db $24,$00,$12,$08,$1C,$08,$24,$00,$12,$08,$17,$08

	db $06,$05,$00,$1D
	db $0A,$08,$17,$08,$18,$08,$1D,$08,$11,$08,$0E,$08,$1B,$08,$24,$00
	db $0C,$08,$0A,$08,$1C,$08,$1D,$08,$15,$08,$0E,$08,$2B,$08

	db $FF

;--------------------------------------------------------------------

DATA_0FF73D:
	db $01,$81,$01,$81,$01,$81,$02,$01
	db $81,$00,$81,$00,$80,$01,$81,$01

DATA_0FF74D:
if !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E|!ROM_SMBLL_E) != $00
	db $00,$90,$10,$10,$10,$18,$10,$1C
	db $05,$10,$10,$0C,$80,$10,$18,$08
	db $90,$FF,$00
else
	db $00,$B0,$10,$10,$10,$28,$10,$28
	db $06,$10,$10,$0C,$80,$10,$28,$08
	db $90,$FF,$00
endif

CODE_0FF760:
	PHB
	PHK
	PLB
	LDX.w $0717
	LDA.w $0718
	BNE.b CODE_0FF778
	INX
	INC.w $0717
	SEC
	LDA.w DATA_0FF74D,x
	STA.w $0718
	BEQ.b CODE_0FF782
CODE_0FF778:
	LDA.w DATA_0FF73D-$01,x
	STA.w $0FF4
	DEC.w $0718
	CLC
CODE_0FF782:
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0FF784:
	LDX.b #$07
	LDA.b #$00
	STA.b $06
CODE_0FF78A:
	STX.b $07
CODE_0FF78C:
	CPX.b #$01
	BNE.b CODE_0FF794
	CPY.b #$50
	BCS.b CODE_0FF796
CODE_0FF794:
	STA.b ($06),y
CODE_0FF796:
	DEY
	CPY.b #$FF
	BNE.b CODE_0FF78C
	DEX
	BPL.b CODE_0FF78A
	LDA.b #$FF
	STA.w $1702
	INC
	STZ.w $0B25
	STZ.w $0B26
	STZ.w $0B27
	STZ.w $0B28
	STZ.w $0B29
	LDX.b #$40
CODE_0FF7B5:
	STZ.w $0F00,x
	INX
	BNE.b CODE_0FF7B5
	LDA.w $0F0B
	BEQ.b CODE_0FF7CA
	DEC
	STA.w $0F0B
	BNE.b CODE_0FF7CA
	JSL.l CODE_0FD085
CODE_0FF7CA:
	RTL

;--------------------------------------------------------------------

DATA_0FF7CB:
	db $93,$00,$00,$11,$12,$12,$13,$00,$00,$51,$52,$53,$00,$00,$00,$00
	db $00,$00,$01,$02,$02,$03,$00,$00,$00,$00,$00,$00,$91,$92,$93,$00
	db $00,$00,$00,$51,$52,$53,$41,$42,$43,$00,$00,$00,$00,$00,$91,$92
	db $97,$87,$88,$89,$99,$00,$00,$00,$11,$12,$13,$A4,$A5,$A5,$A5,$A6
	db $97,$98,$99,$01,$02,$03,$00,$A4,$A5,$A6,$00,$11,$12,$12,$12,$13
	db $00,$00,$00,$00,$01,$02,$02,$03,$00,$A4,$A5,$A5,$A6,$00,$00,$00
	db $11,$12,$12,$13,$00,$00,$00,$00,$00,$00,$00,$9C,$00,$8B,$AA,$AA
	db $AA,$AA,$11,$12,$13,$8B,$00,$9C,$9C,$00,$00,$01,$02,$03,$11,$12
	db $12,$13,$00,$00,$00,$00,$AA,$AA,$9C,$AA,$00,$8B,$00,$01,$02,$03

;--------------------------------------------------------------------

; Note: Level intro sprite data?

DATA_0FF85B:
	db $FF,$FF,$FF,$FF,$FF
	db $06,$00,$FF,$01,$0E
	db $06,$00,$FF,$02,$0E
	db $FF,$01,$07,$0F,$FF
	db $FF,$FF,$FF,$FF,$16
	db $FF,$06,$FF,$0E,$FF
	db $06,$00,$FF,$0E,$01
	db $00,$0E,$14,$0F,$01
	db $FF,$FF,$FF,$FF,$16
	db $01,$0F,$05,$0E,$00
	db $0A,$0B,$07,$00,$01
	db $00,$0E,$FF,$0F,$01
	db $FF,$FF,$FF,$FF,$16
	db $FF,$06,$FF,$12,$FF
	db $00,$08,$12,$05,$01
	db $FF,$03,$08,$0F,$FF
	db $FF,$FF,$FF,$FF,$16
	db $06,$08,$00,$0F,$02
	db $FF,$02,$01,$06,$FF
	db $FF,$0E,$07,$0F,$08
	db $FF,$FF,$FF,$FF,$16
	db $02,$0E,$05,$08,$06
	db $01,$0A,$07,$0B,$0E
	db $01,$0E,$14,$0F,$FF
	db $FF,$FF,$FF,$FF,$16
	db $02,$0E,$14,$08,$05
	db $01,$0E,$12,$0F,$FF
	db $FF,$0E,$FF,$0F,$FF
	db $FF,$FF,$FF,$FF,$16
	db $00,$02,$0F,$05,$06
	db $02,$05,$0F,$00,$FF
	db $01,$0E,$12,$0F,$05
	db $FF,$FF,$FF,$FF,$16

DATA_0FF900:
	db $02,$07,$12,$0E,$05
	db $FF,$FF,$12,$FF,$FF
	db $FF,$FF,$FF,$FF,$16
	db $02,$06,$0E,$07,$05
	db $00,$0E,$FF,$0F,$01
	db $FF,$05,$FF,$08,$FF
	db $07,$0E,$0F,$14,$FF
	db $FF,$FF,$FF,$FF,$16
	db $FF,$00,$0E,$02,$FF
	db $0A,$00,$07,$0E,$0B
	db $01,$0E,$08,$0F,$FF
	db $FF,$FF,$FF,$FF,$16
	db $02,$0E,$05,$0F,$FF
	db $01,$0E,$14,$08,$07
	db $FF,$0E,$12,$0F,$FF
	db $FF,$FF,$FF,$FF,$16
	db $00,$05,$0F,$08,$02
	db $01,$0E,$02,$0F,$00
	db $01,$0E,$05,$08,$00
	db $FF,$FF,$FF,$FF,$16

;--------------------------------------------------------------------

CODE_0FF964:
	LDA.w $0B46,x
	TAY
	LDA.w $03AE
	STA.w $0900,y
	LDA.b $BC,x
	CMP.b #$02
	BCS.b CODE_0FF97B
	LDA.w $03B9
	CMP.b #$E8
	BCC.b CODE_0FF97D
CODE_0FF97B:
	LDA.b #$F0
CODE_0FF97D:
	STA.w $0901,y
	LDA.b $A1,x
	BMI.b CODE_0FF988
	LDA.b #$A9
	BRA.b CODE_0FF98A

CODE_0FF988:
	LDA.b #$29
CODE_0FF98A:
	STA.w $0903,y
	LDA.w $0E68
	AND.b #$18
	LSR
	LSR
	CLC
	ADC.b #$62
	STA.w $0902,y
	LDA.w $021A,x
	STA.b $E4
	LDA.b $79,x
	STA.b $E5
	REP.b #$20
	LDA.b $E4
	SEC
	SBC.b $42
	STA.b $E6
	SEP.b #$20
	LDA.b #$02
	STA.w $0D00,y
	LDA.b $E7
	BEQ.b CODE_0FF9BC
	LDA.b #$03
	STA.w $0D00,y
CODE_0FF9BC:
	RTL

;--------------------------------------------------------------------

CODE_0FF9BD:
	PHB
	PHK
	PLB
	STZ.w $0F49
	PHX
	LDX.b $9E
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$04
	BCS.b CODE_0FF9D4
	LDA.b $29,x
	BMI.b CODE_0FF9D8
	AND.b #$06
	BEQ.b CODE_0FF9D8
CODE_0FF9D4:
	PLX
	PLB
	CLC
	RTL

CODE_0FF9D8:
	LDA.w $0029,x
	STA.b $E0
	CMP.b #$02
	BEQ.b CODE_0FF9E9
	CMP.b #$03
	BEQ.b CODE_0FF9E9
	CMP.b #$04
	BNE.b CODE_0FF9EE
CODE_0FF9E9:
	STZ.w $0F40,x
	BRA.b CODE_0FF9FB

CODE_0FF9EE:
	AND.b #$80
	BEQ.b CODE_0FF9D4
	LDA.b $0F
	CMP.b #$0A
	BCS.b CODE_0FF9FB
	INC.w $0F40,x
CODE_0FF9FB:
	LDA.w $0F40,x
	AND.b #$0C
	STA.b $E4
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	LDX.b $E4
	CMP.b #$02
	BNE.b CODE_0FFA0F
	TXA
	CLC
	ADC.b #$10
	TAX
CODE_0FFA0F:
	LDA.b $E0
	AND.b #$0F
	CMP.b #$04
	BNE.b CODE_0FFA20
	TXA
	CLC
	ADC.b #$20
	TAX
	LDA.b #$80
	TSB.b $04
CODE_0FFA20:
	TYA
	CLC
	ADC.b #$08
	TAY
	LDA.w $03B9
	CLC
	ADC.b #$08
	CMP.b #$F0
	BCC.b CODE_0FFA31
	LDA.b #$F0
CODE_0FFA31:
	PHA
	LDA.b $04
	BPL.b CODE_0FFA3C
	PLA
	CLC
	ADC.b #$02
	BRA.b CODE_0FFA3D

CODE_0FFA3C:
	PLA
CODE_0FFA3D:
	JSR.w CODE_0FFB01
	LDA.b $04
	BPL.b CODE_0FFA4C
	LDA.w $03B9
	CLC
	ADC.b #$12
	BRA.b CODE_0FFA52

CODE_0FFA4C:
	LDA.w $03B9
	CLC
	ADC.b #$10
CODE_0FFA52:
	JSR.w CODE_0FFB01
	LDX.b $E4
	LDA.w DATA_0FFB6A,x
	ORA.b $04
	STA.w $08F3,y
	LDA.w DATA_0FFB6A+$01,x
	ORA.b $04
	STA.w $08F7,y
	LDA.w DATA_0FFB6A+$02,x
	ORA.b $04
	STA.w $08FB,y
	LDA.w DATA_0FFB6A+$03,x
	ORA.b $04
	STA.w $08FF,y
	INC.w $0F49
	PLX
	PLB
	SEC
	RTL

;--------------------------------------------------------------------

DATA_0FFA7E:
	db $00,$FC,$F9,$F7,$F5,$F4,$F3,$F2
	db $F2,$F2,$F3,$F4,$F5,$F7,$F9,$FC
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00

CODE_0FFA9E:
	PHB
	PHK
	PLB
	PHX
	LDX.b $9E
	LDA.b !RAM_SMBLL_NorSpr_SpriteID,x
	CMP.b #$35
	BNE.b CODE_0FFAF0
	LDA.w $0EC4
	BNE.b CODE_0FFAF0
	LDA.w $0F4A
	AND.b #$1F
	LDY.w $0B46,x
	PHY
	TAX
	LDA.w DATA_0FFA7E,x
	STA.b $DD
	JSR.w CODE_0FFAF3
	JSR.w CODE_0FFAF3
	JSR.w CODE_0FFAF3
	JSR.w CODE_0FFAF3
	JSR.w CODE_0FFAF3
	JSR.w CODE_0FFAF3
	PLY
	CPX.b #$10
	BCS.b CODE_0FFAED
	LDA.b #$FF
	STA.w $0902,y
	STA.w $0906,y
	LDA.b #$D7
	STA.w $090A,y
	STA.w $090E,y
	LDA.b #$EE
	STA.w $0912,y
	STA.w $0916,y
CODE_0FFAED:
	INC.w $0F4A
CODE_0FFAF0:
	PLX
	PLB
	RTL

CODE_0FFAF3:
	LDA.w $0901,y
	CLC
	ADC.b $DD
	STA.w $0901,y
	INY
	INY
	INY
	INY
	RTS

;--------------------------------------------------------------------

CODE_0FFB01:
	STA.w $0901,y
	STA.w $0905,y
	LDA.w $03AE
	STA.w $0900,y
	CLC
	ADC.b #$08
	STA.w $0904,y
	LDA.w DATA_0FFB2A,x
	STA.w $0902,y
	LDA.w DATA_0FFB2A+$01,x
	STA.w $0906,y
	INY
	INY
	INY
	INY
	INY
	INY
	INY
	INY
	INX
	INX
	RTS

DATA_0FFB2A:
	db $6E,$6E,$6F,$6F,$C2,$C4,$C3,$C5
	db $C0,$C0,$C1,$C1,$C4,$C2,$C5,$C3
	db $F5,$F5,$F4,$F4,$80,$82,$81,$83
	db $68,$68,$90,$90,$82,$80,$83,$81
	db $6F,$6F,$6E,$6E,$C3,$C5,$C2,$C4
	db $C1,$C1,$C0,$C0,$C5,$C3,$C4,$C2
	db $F4,$F4,$F5,$F5,$81,$83,$80,$82
	db $90,$90,$68,$68,$83,$81,$82,$80

DATA_0FFB6A:
	db $00,$40,$00,$40,$00,$00,$00,$00
	db $00,$40,$00,$40,$40,$40,$40,$40

;--------------------------------------------------------------------

DATA_0FFB7A:
	dw $27BF,$7FFF,$3F1F,$4A5F

DATA_0FFB82:
	dw $033E,$77FF,$2A7F,$315F

DATA_0FFB8A:
	dw $029E,$6FBF,$15DF,$001D

DATA_0FFB92:
	dw $53FF,$677F,$4F9F,$677F

CODE_0FFB9A:
	PHB
	PHK
	PLB
	LDA.b $09
	AND.b #$18
	LSR
	LSR
	TAX
	REP.b #$20
	LDA.w DATA_0FFB7A,x
	STA.w $10CC
	LDA.w DATA_0FFB82,x
	STA.w $10CE
	LDA.w DATA_0FFB8A,x
	STA.w $10D0
	LDA.w DATA_0FFB92,x
	STA.w $10DA
	SEP.b #$20
	INC.w !RAM_SMBLL_Global_UpdateEntirePaletteFlag
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0FFBC5:
	REP.b #$30
	LDX.w #$0000
	STZ.b $E6
CODE_0FFBCC:
	LDA.w $1000,x
	STA.b $E4
	AND.w #$7C00
	BEQ.b CODE_0FFBDE
	LDA.b $E4
	SEC
	SBC.w #$0400
	STA.b $E4
CODE_0FFBDE:
	LDA.b $E4
	AND.w #$03E0
	BEQ.b CODE_0FFBED
	LDA.b $E4
	SEC
	SBC.w #$0020
	STA.b $E4
CODE_0FFBED:
	LDA.b $E4
	AND.w #$001F
	BEQ.b CODE_0FFBF6
	DEC.b $E4
CODE_0FFBF6:
	LDA.b $E4
	STA.w $1000,x
	ORA.b $E6
	STA.b $E6
	INX
	INX
	CPX.w #$0200
	BCC.b CODE_0FFBCC
	LDA.b $E6
	BEQ.b CODE_0FFC19
	SEP.b #$30
	STA.w $0EB8
	STA.w $0200
	LDA.b #$01
	STA.w !RAM_SMBLL_Global_UpdateEntirePaletteFlag
	CLC
	RTL

CODE_0FFC19:
	SEP.b #$30
	STZ.w $0EB8
	STZ.w $0200
	SEC
	RTL

;--------------------------------------------------------------------

CODE_0FFC23:
	LDA.b $5E,x
	BMI.b CODE_0FFC30
	LDA.b $00
	SEC
	SBC.b #$18
	STA.b $E4
	BRA.b CODE_0FFC34

CODE_0FFC30:
	LDA.b $00
	STA.b $E4
CODE_0FFC34:
	LDA.w $0238,x
	SEC
	SBC.b $E4
	STA.b $E4
	PHY
	LDY.w $0B46,x
	CMP.b #$18
	BCC.b CODE_0FFC54
	LDA.w $0913,y
	ORA.b #$20
	STA.w $0913,y
	LDA.w $0917,y
	ORA.b #$20
	STA.w $0917,y
CODE_0FFC54:
	LDA.b $E4
	CMP.b #$10
	BCC.b CODE_0FFC6A
	LDA.w $090B,y
	ORA.b #$20
	STA.w $090B,y
	LDA.w $090F,y
	ORA.b #$20
	STA.w $090F,y
CODE_0FFC6A:
	LDA.b $E4
	CMP.b #$08
	BCC.b CODE_0FFC80
	LDA.w $0903,y
	ORA.b #$20
	STA.w $0903,y
	LDA.w $0907,y
	ORA.b #$20
	STA.w $0907,y
CODE_0FFC80:
	PLY
	RTL

;--------------------------------------------------------------------

DATA_0FFC82:
	db $F9,$0E,$F7,$0E,$FA,$FB,$F8,$FB
	db $F6,$FB,$FD,$FE

DATA_0FFC8E:
	db $20,$22,$24

CODE_0FFC91:
	PHB
	PHK
	PLB
	LDY.b #$F0
	LDA.w $021A,x
	STA.b $E4
	LDA.b $79,x
	STA.b $E5
	REP.b #$20
	LDA.b $E4
	SEC
	SBC.b $42
	STA.b $E4
	CLC
	ADC.w #$0004
	STA.b $E6
	CLC
	ADC.w #$0008
	STA.b $E8
	BPL.b CODE_0FFCBF
	CMP.w #$FF80
	BCS.b CODE_0FFCBF
	SEP.b #$30
	PLB
	RTL

CODE_0FFCBF:
	SEP.b #$20
	LDA.b $E4
	STA.w $0800,y
	LDA.w $0238,x
	STA.w $0801,y
	LDA.b #$2B
	STA.w $0803,y
	LDA.b $09
	AND.b #$18
	LSR
	LSR
	LSR
	PHX
	TAX
	CPX.b #$03
	BNE.b CODE_0FFCE0
	LDX.b #$01
CODE_0FFCE0:
	LDA.w DATA_0FFC8E,x
	STA.w $0802,y
	PLX
	LDA.w $070F
	BEQ.b CODE_0FFD21
	LDA.w $010F
	ASL
	TAX
	LDA.b $E6
	STA.w $0804,y
	LDA.b $E8
	STA.w $0808,y
	LDA.w $010D
	STA.w $0805,y
	STA.w $0809,y
	LDA.w DATA_0FFC82,x
	STA.w $0806,y
	LDA.w DATA_0FFC82+$01,x
	STA.w $080A,y
	LDA.b #$22
	STA.w $0807,y
	STA.w $080B,y
	CPX.b #$04
	BCS.b CODE_0FFD21
	LDA.b #$23
	STA.w $080B,y
CODE_0FFD21:
	LDA.b #$02
	STA.b $DD
	LDA.b $E5
	BEQ.b CODE_0FFD2B
	LDA.b #$01
CODE_0FFD2B:
	ORA.b $DD
	STA.w $0C00,y
	STZ.b $DD
	LDA.b $E7
	BEQ.b CODE_0FFD38
	LDA.b #$01
CODE_0FFD38:
	ORA.b $DD
	STA.w $0C04,y
	CPX.b #$04
	BCS.b CODE_0FFD45
	LDA.b #$02
	STA.b $DD
CODE_0FFD45:
	LDA.b $E9
	BEQ.b CODE_0FFD4B
	LDA.b #$01
CODE_0FFD4B:
	ORA.b $DD
	STA.w $0C08,y
	PLB
	RTL

;--------------------------------------------------------------------

if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMBLL_J) != $00
CODE_0D98F2:
	PHD
	LDA.b #$0700>>8
	XBA
	LDA.b #$0700
	TCD
	LDX.b #$05
	LDY.b #$05
	SEC
CODE_0D98FE:
	LDA.b $07CE,x
	SBC.w !RAM_SMBLL_TitleScreen_TopScoreMillionsDigit,y
	DEX
	DEY
	BPL.b CODE_0D98FE
	BCC.b CODE_0D9916
	INX
	INY
CODE_0D990B:
	LDA.b $07CE,x
	STA.w !RAM_SMBLL_TitleScreen_TopScoreMillionsDigit,y
	INX
	INY
	CPY.b #$06
	BCC.b CODE_0D990B
CODE_0D9916:
	PLD
	RTL
endif

if !Define_Global_ROMToAssemble&(!ROM_SMAS_U) != $00
%FREE_BYTES(NULLROM, 767, $FF)
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J1) != $00
%FREE_BYTES(NULLROM, 676, $FF)
elseif !Define_Global_ROMToAssemble&(!ROM_SMAS_J2) != $00
%FREE_BYTES(NULLROM, 595, $FF)
elseif !Define_Global_ROMToAssemble&(!ROM_SMBLL_U) != $00
%FREE_BYTES(NULLROM, 719, $FF)
elseif !Define_Global_ROMToAssemble&(!ROM_SMBLL_E) != $00
%FREE_BYTES(NULLROM, 713, $FF)
elseif !Define_Global_ROMToAssemble&(!ROM_SMBLL_J) != $00
%FREE_BYTES(NULLROM, 628, $FF)
elseif !Define_Global_ROMToAssemble&(!ROM_SMASW_E|!ROM_SMAS_E) != $00
%FREE_BYTES(NULLROM, 680, $FF)
else
%FREE_BYTES(NULLROM, 686, $FF)
endif
%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro SMBLLBank10Macros(StartBank, EndBank)
%BANK_START(<StartBank>)
SMBLL_UncompressedGFX_FG_GlobalTiles:
;$108000
	incbin "../SMB1/Graphics/GFX_FG_SMBLL_GlobalTiles.bin"

SMBLL_UncompressedGFX_BG_HillsAndTrees:
;$10A000
	incbin "../SMB1/Graphics/GFX_BG_HillsAndTrees.bin"

SMBLL_UncompressedGFX_FG_TitleLogo:
;$10B000
if !Define_Global_ROMToAssemble&(!ROM_SMAS_J1|!ROM_SMAS_J2|!ROM_SMBLL_J) != $00
	incbin "../SMB1/Graphics/GFX_FG_SMBLL_TitleLogo_SMAS_J.bin"
else
	incbin "../SMB1/Graphics/GFX_FG_SMBLL_TitleLogo_SMAS_U.bin"
endif
.End:

SMBLL_UncompressedGFX_AnimatedTiles:
;$10C000
	incbin "../SMB1/Graphics/GFX_SMBLL_AnimatedTiles.bin"
%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro SMBLLBank1AMacros(StartBank, EndBank)
;%BANK_START(<StartBank>)
SMBLL_EndScreenTilemap:
;$1AE800
	incbin "../SMB1/Tilemaps/Tilemap_1AE800.bin"
;%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro SMBLLBank1EMacros(StartBank, EndBank)
;%BANK_START(<StartBank>)
SMBLL_UncompressedGFX_Sprite_PeachAndToad:
;$1EC000
	incbin "../SMB1/Graphics/GFX_Sprite_PeachAndToad.bin"
;%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro SMBLLBank1FMacros(StartBank, EndBank)
;%BANK_START(<StartBank>)
SMB1MusicBank:
	incbin "../SMB1/SPC700/SMB1_MusicBank.bin"
;%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro SMBLLBank2FMacros(StartBank, EndBank)
;%BANK_START(<StartBank>)
SMBLL_UncompressedGFX_Ending:
;$2FD000
	incbin "../SMB1/Graphics/GFX_Ending.bin"
;%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_SMBLL_SaveGame(Address)
namespace SMBLL_SaveGame
%InsertMacroAtXPosition(<Address>)

Main:
	PHX
	PHY
	PHB
	PHK
	PLB
	REP.b #$30
	STZ.b $00
	LDA.l !SRAM_SMAS_Global_SaveFileIndexLo
	TAX
	SEP.b #$20
	LDA.l !SRAM_SMAS_Global_SaveFileBaseOffset,x
	BMI.b CODE_0090A7
	CMP.w $075F
	BCC.b CODE_0090A7
	BNE.b CODE_009090
	LDA.l !SRAM_SMAS_Global_SaveFileBaseOffset+$01,x
	CMP.w $075C
	BCC.b CODE_0090A7
CODE_009090:
	LDA.l !SRAM_SMAS_Global_SaveFileBaseOffset,x
	JSR.w SMBLL_StoreDataToSaveFileAndUpdateTempChecksum_Main
	LDA.l !SRAM_SMAS_Global_SaveFileBaseOffset,x
	JSR.w SMBLL_StoreDataToSaveFileAndUpdateTempChecksum_Main
	LDA.l !SRAM_SMAS_Global_SaveFileBaseOffset,x
	JSR.w SMBLL_StoreDataToSaveFileAndUpdateTempChecksum_Main
	BRA.b CODE_0090B9

CODE_0090A7:
	LDA.w $075F
	JSR.w SMBLL_StoreDataToSaveFileAndUpdateTempChecksum_Main
	LDA.w $075C
	JSR.w SMBLL_StoreDataToSaveFileAndUpdateTempChecksum_Main
	LDA.w $0760
	JSR.w SMBLL_StoreDataToSaveFileAndUpdateTempChecksum_Main
CODE_0090B9:
	LDA.w $075A
	BPL.b CODE_0090C0
	LDA.b #$04
CODE_0090C0:
	JSR.w SMBLL_StoreDataToSaveFileAndUpdateTempChecksum_Main
	PHX
	JSR.w CODE_0090E7
	PLX
	LDA.w !RAM_SMBLL_Level_NoWorld9Flag
	JSR.w SMBLL_StoreDataToSaveFileAndUpdateTempChecksum_Main
	LDA.l !RAM_SMBLL_Global_DisplayTitleScreenMenuOptionsIndex
	JSR.w SMBLL_StoreDataToSaveFileAndUpdateTempChecksum_Main
	REP.b #$20
	LDA.w #$0000
	SEC
	SBC.b $00
	STA.l !SRAM_SMAS_Global_SaveFileBaseOffset,x
	SEP.b #$30
	PLB
	PLY
	PLX
	RTL

CODE_0090E7:
	PHB
	LDA.b #!SRAMBankBaseAddress>>16
	PHA
	PLB
	PHD
	LDA.b #$0700>>8
	XBA
	LDA.b #$7000
	TCD
	LDX.w #$0005
	SEC
CODE_0090F7:
	LDA.b !RAM_SMBLL_TitleScreen_TopScoreMillionsDigit,x
	SBC.w $701FE8,x
	DEX
	BPL.b CODE_0090F7
	BCC.b CODE_00910D
	INX
CODE_009102:
	LDA.b !RAM_SMBLL_TitleScreen_TopScoreMillionsDigit,x
	STA.w $701FE8,x
	INX
	CPX.w #$0006
	BCC.b CODE_009102
CODE_00910D:
	PLD
	PLB
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################
;#############################################################################################################
;#############################################################################################################
;#############################################################################################################
;#############################################################################################################
;#############################################################################################################
;#############################################################################################################
;#############################################################################################################
;#############################################################################################################
;#############################################################################################################
;#############################################################################################################
;#############################################################################################################
;#############################################################################################################
;#############################################################################################################
;#############################################################################################################
;#############################################################################################################
;#############################################################################################################

macro DATATABLE_CUSTOM_SMBLL_PauseMenuGFX(Address)
namespace SMBLL_PauseMenuGFX
%InsertMacroAtXPosition(<Address>)

Main:
	incbin "../SMAS/Graphics/PauseMenuGFX.bin"
End:
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_RT00_SMBLL_UploadMainSampleData(Address)
namespace SMBLL_UploadMainSampleData
%InsertMacroAtXPosition(<Address>)

Main:
	SEI
	STZ.w !REGISTER_IRQNMIAndJoypadEnableFlags
	STZ.w !REGISTER_HDMAEnable
	STZ.w !REGISTER_DMAEnable
	STZ.w !REGISTER_APUPort0
	LDA.b #$FF
	STA.w !REGISTER_APUPort1
	STZ.w !REGISTER_APUPort2
	STZ.w !REGISTER_APUPort3
	LDA.b #SampleData
	STA.b !RAM_SMBLL_Global_ScratchRAM00
	LDA.b #SampleData>>8
	STA.b !RAM_SMBLL_Global_ScratchRAM01
	LDA.b #SampleData>>16
	STA.b !RAM_SMBLL_Global_ScratchRAM02
	JSR.w SMBLL_HandleSPCUploads_Main
	RTL
namespace off
endmacro

macro ROUTINE_CUSTOM_RT01_SMBLL_UploadMainSampleData(Address)
namespace SMBLL_UploadMainSampleData
%InsertMacroAtXPosition(<Address>)

SampleData:
	incbin "../SMAS/SPC700/MainSamples.bin"
SampleDataEnd:
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_RT00_SMBLL_UploadSPCEngine(Address)
namespace SMBLL_UploadSPCEngine
%InsertMacroAtXPosition(<Address>)

Main:
	LDA.b #SPCEngine
	STA.b !RAM_SMBLL_Global_ScratchRAM00
	LDA.b #SPCEngine>>8
	STA.b !RAM_SMBLL_Global_ScratchRAM01
	LDA.b #SPCEngine>>16
	STA.b !RAM_SMBLL_Global_ScratchRAM02
	JSR.w SMBLL_HandleSPCUploads_Main
	RTL
namespace off
endmacro

macro ROUTINE_CUSTOM_RT01_SMBLL_UploadSPCEngine(Address)
namespace SMBLL_UploadSPCEngine
%InsertMacroAtXPosition(<Address>)

SPCEngine:
	incbin "../SMAS/SPC700/Engine.bin"
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro DATATABLE_CUSTOM_SMBLL_SplashScreenGFX(Address)
namespace SMBLL_SplashScreenGFX
%InsertMacroAtXPosition(<Address>)

Main:
	incbin "../SMAS/Graphics/SplashScreenGFX.bin"
End:
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_SMBLL_HandleSPCUploads(Address)
namespace SMBLL_HandleSPCUploads
%InsertMacroAtXPosition(<Address>)

Main:
	PHP
	REP.b #$30
	LDY.w #$0000
	LDA.w #$BBAA
CODE_008C06:
	CMP.w !REGISTER_APUPort0
	BNE.b CODE_008C06
	SEP.b #$20
	LDA.b #$CC
	BRA.b CODE_008C37

CODE_008C11:
	LDA.b [!RAM_SMBLL_Global_ScratchRAM00],y
	INY
	XBA
	LDA.b #$00
	BRA.b CODE_008C24

CODE_008C19:
	XBA
	LDA.b [!RAM_SMBLL_Global_ScratchRAM00],y
	INY
	XBA
CODE_008C1E:
	CMP.w !REGISTER_APUPort0
	BNE.b CODE_008C1E
	INC
CODE_008C24:
	REP.b #$20
	STA.w !REGISTER_APUPort0
	SEP.b #$20
	DEX
	BNE.b CODE_008C19
CODE_008C2E:
	CMP.w !REGISTER_APUPort0
	BNE.b CODE_008C2E
CODE_008C33:
	ADC.b #$03
	BEQ.b CODE_008C33
CODE_008C37:
	PHA
	REP.b #$20
	LDA.b [!RAM_SMBLL_Global_ScratchRAM00],y
	INY
	INY
	TAX
	LDA.b [!RAM_SMBLL_Global_ScratchRAM00],y
	INY
	INY
	STA.w !REGISTER_APUPort2
	SEP.b #$20
	CPX.w #$0001
	LDA.b #$00
	ROL
	STA.w !REGISTER_APUPort1
	ADC.b #$7F
	PLA
	STA.w !REGISTER_APUPort0
CODE_008C57:
	CMP.w !REGISTER_APUPort0
	BNE.b CODE_008C57
	BVS.b CODE_008C11
	STZ.w !REGISTER_APUPort0
	STZ.w !REGISTER_APUPort1
	STZ.w !REGISTER_APUPort2
	STZ.w !REGISTER_APUPort3
	PLP
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_SMBLL_ResetGame(Address)
namespace SMBLL_ResetGame
%InsertMacroAtXPosition(<Address>)

Main:
	LDA.b #!ScreenDisplayRegister_SetForceBlank|!ScreenDisplayRegister_MinBrightness00
	STA.w !REGISTER_ScreenDisplayRegister
	STZ.w !REGISTER_HDMAEnable
	STZ.w !RAM_SMBLL_Global_HDMAEnableMirror
	STZ.w !REGISTER_IRQNMIAndJoypadEnableFlags
	LDA.b #SMBLL_InitAndMainLoop_Main>>16
	PHA
	PLB
	SEI
	STZ.w !REGISTER_IRQNMIAndJoypadEnableFlags
	STZ.w !REGISTER_HDMAEnable
	REP.b #$20
	LDA.w #!RAM_SMBLL_Global_StartOfStack
	TCS
	SEP.b #$20
	STZ.w !RAM_SMBLL_Global_SoundCh1
	STZ.w !RAM_SMBLL_Global_SoundCh2
	STZ.w !RAM_SMBLL_Global_MusicCh1
	STZ.w !RAM_SMBLL_Global_SoundCh3
	STZ.w !REGISTER_APUPort0
	STZ.w !REGISTER_APUPort1
	STZ.w !REGISTER_APUPort2
	STZ.w !REGISTER_APUPort3
	LDA.b #$F0
	STA.w !REGISTER_APUPort1
	JML.l SMBLL_InitAndMainLoop_Main
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_SMBLL_DisplayRegionErrorMessage(Address)
namespace SMBLL_DisplayRegionErrorMessage
%InsertMacroAtXPosition(<Address>)

table "Tables/Fonts/ErrorScreen.txt"

RegionErrorText:
.Line1:
	dw " THIS GAME PAK IS NOT   "

.Line2:
	dw "DESIGINED FOR YOUR SUPER"

.Line3:
	dw "FAMICOM OR SUPER NES.   "

.Line4:
	dw "   NINTENDO CO.,LTD.    "

cleartable

Main:
	JSL.l SMBLL_InitializeRAMOnStartup_Main
	SEP.b #$20
	PHD
	STZ.w !REGISTER_CGRAMAddress
	REP.b #$20
	LDA.w #$3B3B
	STA.b !RAM_SMBLL_Global_ScratchRAM02
	LDA.w #!RAM_SMBLL_ErrorScreen_TextTilemap
	STA.b !RAM_SMBLL_Global_ScratchRAM00
	LDY.b #!RAM_SMBLL_ErrorScreen_TextTilemap>>16
	JSL.l SMBLL_InitializeSelectedRAM_Entry2
	LDA.w #DMA[$00].Parameters
	TCD
	LDY.b #$80
	STY.w !REGISTER_VRAMAddressIncrementValue
	LDA.w #$7FFF
	STA.w SMBLL_ErrorScreen_PaletteMirror[$0C].LowByte
	LDA.w #$7FF9
	STA.w SMBLL_ErrorScreen_PaletteMirror[$0D].LowByte
	LDA.w #$7FD0
	STA.w SMBLL_ErrorScreen_PaletteMirror[$0E].LowByte
	LDA.w #$6AE9
	STA.w SMBLL_ErrorScreen_PaletteMirror[$0F].LowByte
	LDA.w #(!REGISTER_WriteToCGRAMPort&$0000FF<<8)+$00
	STA.b DMA[$00].Parameters
	LDA.w #!RAM_SMBLL_ErrorScreen_PaletteMirror
	STA.b DMA[$00].SourceLo
	LDX.b #!RAM_SMBLL_ErrorScreen_PaletteMirror>>16
	STX.b DMA[$00].SourceBank
	STA.b DMA[$00].SizeLo
	LDY.b #$01
	STY.w !REGISTER_DMAEnable
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STA.b DMA[$00].Parameters
	LDA.w #$0000
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #SMBLL_ErrorMessageFontGFX_Main
	STA.b DMA[$00].SourceLo
	LDX.b #SMBLL_ErrorMessageFontGFX_Main>>16
	STX.b DMA[$00].SourceBank
	LDA.w #SMBLL_ErrorMessageFontGFX_End-SMBLL_ErrorMessageFontGFX_Main
	STA.b DMA[$00].SizeLo
	STY.w !REGISTER_DMAEnable
	PHB
	LDX.b #RegionErrorText>>16
	PHX
	PLB
	LDX.b #$00
CODE_0093F9:
	LDA.w RegionErrorText_Line1,x
	STA.w SMBLL_ErrorScreen_TextTilemap[$07].Row+$0A,x
	LDA.w RegionErrorText_Line2,x
	STA.w SMBLL_ErrorScreen_TextTilemap[$09].Row+$0A,x
	LDA.w RegionErrorText_Line3,x
	STA.w SMBLL_ErrorScreen_TextTilemap[$0B].Row+$0A,x
	LDA.w RegionErrorText_Line4,x
	STA.w SMBLL_ErrorScreen_TextTilemap[$11].Row+$0A,x
	INX
	INX
	CPX.b #RegionErrorText_Line2-RegionErrorText_Line1
	BNE.b CODE_0093F9
CODE_009417:
	PLB
	LDA.w #$1000
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #SMBLL_OAMBuffer[$00].XDisp
	STA.b DMA[$00].SourceLo
	LDX.b #(SMBLL_OAMBuffer[$00].XDisp>>16)&$00
	STX.b DMA[$00].SourceBank
	STA.b DMA[$00].SizeLo
	STY.w !REGISTER_DMAEnable
	SEP.b #$20
	PLD
	LDA.b #$10
	STA.w !REGISTER_BG1AddressAndSize
	STZ.w !REGISTER_BG1And2TileDataDesignation
	LDA.b #$01
	STA.w !REGISTER_MainScreenLayers
	STZ.w !REGISTER_SubScreenLayers
	LDA.b #$01
	STA.w !REGISTER_BGModeAndTileSizeSetting
	STZ.w !REGISTER_ColorMathInitialSettings
	STZ.w !REGISTER_ColorMathSelectAndEnable
	STZ.w !REGISTER_BG1HorizScrollOffset
	STZ.w !REGISTER_BG1HorizScrollOffset
	STZ.w !REGISTER_BG1VertScrollOffset
	STZ.w !REGISTER_BG1VertScrollOffset
	STZ.w !REGISTER_BG2HorizScrollOffset
	STZ.w !REGISTER_BG2HorizScrollOffset
	STZ.w !REGISTER_BG2VertScrollOffset
	STZ.w !REGISTER_BG2VertScrollOffset
	STZ.w !REGISTER_BG3HorizScrollOffset
	STZ.w !REGISTER_BG3HorizScrollOffset
	STZ.w !REGISTER_BG3VertScrollOffset
	STZ.w !REGISTER_BG3VertScrollOffset
	LDA.b #!ScreenDisplayRegister_MaxBrightness0F
	STA.w !REGISTER_ScreenDisplayRegister
CODE_009473:
	BIT.w !REGISTER_HVBlankFlagsAndJoypadStatus
	BPL.b CODE_009473
	INC.b !RAM_SMBLL_Global_FrameCounter
	LDA.b !RAM_SMBLL_Global_FrameCounter
	CMP.b #$18
	BNE.b CODE_0094BF
	STZ.b !RAM_SMBLL_Global_FrameCounter
	STZ.w !REGISTER_CGRAMAddress
	REP.b #$20
	LDA.w #DMA[$00].Parameters
	TCD
	LDY.b #$80
	STY.w !REGISTER_VRAMAddressIncrementValue
	LDA.w SMBLL_ErrorScreen_PaletteMirror[$0D].LowByte
	PHA
	LDA.w SMBLL_ErrorScreen_PaletteMirror[$0E].LowByte
	STA.w SMBLL_ErrorScreen_PaletteMirror[$0D].LowByte
	LDA.w SMBLL_ErrorScreen_PaletteMirror[$0F].LowByte
	STA.w SMBLL_ErrorScreen_PaletteMirror[$0E].LowByte
	PLA
	STA.w SMBLL_ErrorScreen_PaletteMirror[$0F].LowByte
	LDA.w #(!REGISTER_WriteToCGRAMPort&$0000FF<<8)+$00
	STA.b DMA[$00].Parameters
	LDA.w #!RAM_SMBLL_ErrorScreen_PaletteMirror
	STA.b DMA[$00].SourceLo
	LDX.b #!RAM_SMBLL_ErrorScreen_PaletteMirror>>16
	STX.b DMA[$00].SourceBank
	STA.b DMA[$00].SizeLo
	LDY.b #$01
	STY.w !REGISTER_DMAEnable
	LDA.w #$0000
	TCD
	SEP.b #$20
CODE_0094BF:
	BIT.w !REGISTER_HVBlankFlagsAndJoypadStatus
	BMI.b CODE_0094BF
	JMP.w CODE_009473
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_SMBLL_DisplayCopyDetectionErrorMessage(Address)
namespace SMBLL_DisplayCopyDetectionErrorMessage
%InsertMacroAtXPosition(<Address>)

table "Tables/Fonts/ErrorScreen.txt"

CopyDetectionText:
if !Define_Global_ROMToAssemble&(!ROM_SMBLL_E) != $00
.Line1:
	dw "         WARNING          "

.Line2:
	dw "IT IS A SERIOUS CRIME TO  "

.Line3:
	dw "COPY VIDEO GAMES ACCORDING"

.Line4:
	dw "TO COPYRIGHT LAW.  PLEASE "

.Line5:
	dw "REFER TO YOUR NINTENDO    "

.Line6:
	dw "GAME INSTRUCTION BOOKLET  "

.Line7:
	dw "FOR FURTHER INFORMATION.  "

else
.Line1:
	dw "WARNING: IT IS A SERIOUS  "

.Line2:
	dw "CRIME TO COPY VIDEO GAMES."

.Line3:
	dw "18 USC 2319 PLEASE REFER  "

.Line4:
	dw "TO YOUR NINTENDO GAME     "

.Line5:
	dw "INSTRUCTION BOOKLET FOR   "

.Line6:
	dw "FURTHER INFORMATION.      "
endif

cleartable

Main:
	SEI
	STZ.w !REGISTER_IRQNMIAndJoypadEnableFlags
	STZ.w !REGISTER_HDMAEnable
	STZ.w !REGISTER_DMAEnable
	LDA.b #!ScreenDisplayRegister_SetForceBlank|!ScreenDisplayRegister_MinBrightness00
	STA.w !REGISTER_ScreenDisplayRegister
	STZ.w !REGISTER_APUPort0
	STZ.w !REGISTER_APUPort1
	STZ.w !REGISTER_APUPort3
	LDA.b #!Define_SMBLL_LevelMusic_StopMusicCommand
	STA.w !REGISTER_APUPort2
	JSL.l SMBLL_InitializeRAMOnStartup_Main
	SEP.b #$20
	PHD
	STZ.w !REGISTER_CGRAMAddress
	REP.b #$20
	LDA.w #$3B3B
	STA.b !RAM_SMBLL_Global_ScratchRAM02
	LDA.w #!RAM_SMBLL_ErrorScreen_TextTilemap
	STA.b !RAM_SMBLL_Global_ScratchRAM00
	LDY.b #!RAM_SMBLL_ErrorScreen_TextTilemap>>16
	JSL.l SMBLL_InitializeSelectedRAM_Entry2
	LDA.w #DMA[$00].Parameters
	TCD
	LDY.b #$80
	STY.w !REGISTER_VRAMAddressIncrementValue
	LDA.w #$7FFF
	STA.w SMBLL_ErrorScreen_PaletteMirror[$0C].LowByte
	LDA.w #$7FF9
	STA.w SMBLL_ErrorScreen_PaletteMirror[$0D].LowByte
	LDA.w #$7FD0
	STA.w SMBLL_ErrorScreen_PaletteMirror[$0E].LowByte
	LDA.w #$6AE9
	STA.w SMBLL_ErrorScreen_PaletteMirror[$0F].LowByte
	LDA.w #(!REGISTER_WriteToCGRAMPort&$0000FF<<8)+$00
	STA.b DMA[$00].Parameters
	LDA.w #!RAM_SMBLL_ErrorScreen_PaletteMirror
	STA.b DMA[$00].SourceLo
	LDX.b #!RAM_SMBLL_ErrorScreen_PaletteMirror>>16
	STX.b DMA[$00].SourceBank
	STA.b DMA[$00].SizeLo
	LDY.b #$01
	STY.w !REGISTER_DMAEnable
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STA.b DMA[$00].Parameters
	LDA.w #$0000
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #SMBLL_ErrorMessageFontGFX_Main
	STA.b DMA[$00].SourceLo
	LDX.b #SMBLL_ErrorMessageFontGFX_Main>>16
	STX.b DMA[$00].SourceBank
	LDA.w #SMBLL_ErrorMessageFontGFX_End-SMBLL_ErrorMessageFontGFX_Main
	STA.b DMA[$00].SizeLo
	STY.w !REGISTER_DMAEnable
	PHB
	LDX.b #CopyDetectionText>>16
	PHX
	PLB
	LDX.b #$00
CODE_009690:
if !Define_Global_ROMToAssemble&(!ROM_SMBLL_E) != $00
	LDA.w CopyDetectionText_Line1,x
	STA.w SMBLL_ErrorScreen_TextTilemap[$07].Row+$06,x
	LDA.w CopyDetectionText_Line2,x
	STA.w SMBLL_ErrorScreen_TextTilemap[$09].Row+$06,x
	LDA.w CopyDetectionText_Line3,x
	STA.w SMBLL_ErrorScreen_TextTilemap[$0B].Row+$06,x
	LDA.w CopyDetectionText_Line4,x
	STA.w SMBLL_ErrorScreen_TextTilemap[$0D].Row+$06,x
	LDA.w CopyDetectionText_Line5,x
	STA.w SMBLL_ErrorScreen_TextTilemap[$0F].Row+$06,x
	LDA.w CopyDetectionText_Line6,x
	STA.w SMBLL_ErrorScreen_TextTilemap[$11].Row+$06,x
	LDA.w CopyDetectionText_Line7,x
	STA.w SMBLL_ErrorScreen_TextTilemap[$13].Row+$06,x
else
	LDA.w CopyDetectionText_Line1,x
	STA.w SMBLL_ErrorScreen_TextTilemap[$07].Row+$06,x
	LDA.w CopyDetectionText_Line2,x
	STA.w SMBLL_ErrorScreen_TextTilemap[$09].Row+$06,x
	LDA.w CopyDetectionText_Line3,x
	STA.w SMBLL_ErrorScreen_TextTilemap[$0D].Row+$06,x
	LDA.w CopyDetectionText_Line4,x
	STA.w SMBLL_ErrorScreen_TextTilemap[$0F].Row+$06,x
	LDA.w CopyDetectionText_Line5,x
	STA.w SMBLL_ErrorScreen_TextTilemap[$11].Row+$06,x
	LDA.w CopyDetectionText_Line6,x
	STA.w SMBLL_ErrorScreen_TextTilemap[$13].Row+$06,x
endif
	INX
	INX
	CPX.b #CopyDetectionText_Line2-CopyDetectionText_Line1
	BNE CODE_009690
	JMP.w SMBLL_DisplayRegionErrorMessage_CODE_009417
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_SMBLL_ErrorMessageFontGFX(Address)
namespace SMBLL_ErrorMessageFontGFX
%InsertMacroAtXPosition(<Address>)

Main:
if !Define_Global_ROMToAssemble&(!ROM_SMBLL_J) != $00
	incbin "../SMAS/Graphics/ErrorMessageFontGFX_SMAS_J.bin"
else
	incbin "../SMAS/Graphics/ErrorMessageFontGFX_SMAS_U.bin"
endif
End:
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_SMBLL_InitializeSelectedRAM(Address)
namespace SMBLL_InitializeSelectedRAM
%InsertMacroAtXPosition(<Address>)

Main:
	STZ.b !RAM_SMBLL_Global_ScratchRAM02
Entry2:
	STA.w DMA[$00].SourceLo
	STY.w DMA[$00].SourceBank
	LDA.w #(!REGISTER_PPUMultiplicationProductLo&$0000FF<<8)+$80
	STA.w DMA[$00].Parameters
	LDA.b !RAM_SMBLL_Global_ScratchRAM00
	STA.w DMA[$00].SizeLo
	LDY.b #$01
	STY.w !REGISTER_Mode7MatrixParameterA
	DEY
	STY.w !REGISTER_Mode7MatrixParameterA
	LDY.b !RAM_SMBLL_Global_ScratchRAM02
	STY.w !REGISTER_Mode7MatrixParameterB
	LDY.b #$01
	STY.w !REGISTER_DMAEnable
	RTL
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_SMBLL_InitializeRAMOnStartup(Address)
namespace SMBLL_InitializeRAMOnStartup
%InsertMacroAtXPosition(<Address>)

Main:
	REP.b #$20
	LDA.w #!RAM_SMBLL_Global_StartOfStack-$AF
	STA.b !RAM_SMBLL_Global_ScratchRAM00
	LDA.w #$000000
	TAY
	JSL.l SMBLL_InitializeSelectedRAM_Main
	LDA.w #$002000-(!RAM_SMBLL_Global_StartOfStack+$01)
	STA.b !RAM_SMBLL_Global_ScratchRAM00
	LDA.w #!RAM_SMBLL_Global_StartOfStack+$01
	TAY
	JSL.l SMBLL_InitializeSelectedRAM_Main
	LDA.w #$E000
	STA.b !RAM_SMBLL_Global_ScratchRAM00
	LDA.w #$7E2000
	LDY.b #$7E2000>>16
	JSL.l SMBLL_InitializeSelectedRAM_Main
	LDA.w #$0000
	STA.b !RAM_SMBLL_Global_ScratchRAM00
	LDA.w #$7F0000
	LDY.b #$7F0000>>16
	JSL.l SMBLL_InitializeSelectedRAM_Main
	LDA.w #$0000
	STA.l !RAM_SMBLL_Global_StripeImageUploadIndexLo
	DEC
	STA.l SMBLL_StripeImageUploadTable[$00].LowByte
if !Define_Global_ROMToAssemble&(!ROM_SMBLL_E) != $00
	STA.w $1620
endif
	SEP.b #$20
	STA.l !RAM_SMBLL_Global_DisplayTitleScreenMenuOptionsIndex
	LDA.b #$00
	STA.l !SRAM_SMAS_Global_UnusedRAM701FF8
	STA.l !SRAM_SMAS_Global_UnusedRAM701FF9
	STA.l !SRAM_SMAS_Global_InitialSelectedWorld
	REP.b #$20
	PHD
	LDA.w #!REGISTER_ScreenDisplayRegister
	TCD
	SEP.b #$30
	LDA.b #$09
	STA.b !REGISTER_BGModeAndTileSizeSetting
	STA.w !RAM_SMBLL_Global_BGModeAndTileSizeSettingMirror
	STZ.b !REGISTER_MosaicSizeAndBGEnable
	STZ.b !REGISTER_BG1And2WindowMaskSettings
	STZ.b !REGISTER_BG3And4WindowMaskSettings
	STZ.b !REGISTER_MainScreenWindowMask
	STZ.b !REGISTER_SubScreenWindowMask
	LDA.b #$03
	STA.b !REGISTER_BG1AddressAndSize
	LDA.b #$13
	STA.b !REGISTER_BG2AddressAndSize
	LDA.b #$51
	STA.b !REGISTER_BG3AddressAndSize
	STZ.b !REGISTER_BG4AddressAndSize
	LDA.b #$22
	STA.b !REGISTER_BG1And2TileDataDesignation
	LDA.b #$05
	STA.b !REGISTER_BG3And4TileDataDesignation
	LDA.b #$15
	STA.b !REGISTER_MainScreenLayers
	STA.w !RAM_SMBLL_Global_MainScreenLayersMirror
	LDA.b #$02
	STA.b !REGISTER_SubScreenLayers
	STA.w !RAM_SMBLL_Global_SubScreenLayersMirror
	LDA.b #$00
	STA.b !REGISTER_ColorMathInitialSettings
	STA.b !REGISTER_ObjectAndColorWindowSettings
	STA.b !REGISTER_ColorMathSelectAndEnable
	LDA.b #$20
	STA.b !REGISTER_FixedColorData
	ASL
	STA.b !REGISTER_FixedColorData
	ASL
	STA.b !REGISTER_FixedColorData
if !Define_Global_ROMToAssemble&(!ROM_SMBLL_E) != $00
	LDA.b #$04
	STA.b !REGISTER_InitialScreenSettings
else
	STZ.b !REGISTER_InitialScreenSettings
endif
	PLD
	RTL
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_SMBLL_CheckWhichControllersArePluggedIn(Address)
namespace SMBLL_CheckWhichControllersArePluggedIn
%InsertMacroAtXPosition(<Address>)

Main:
	LDA.w !REGISTER_JoypadSerialPort1
	AND.b #$01
	EOR.b #$01
	ASL
	STA.l !SRAM_SMAS_Global_Controller1PluggedInFlag
	LDA.w !REGISTER_JoypadSerialPort2
	AND.b #$01
	ASL
	STA.l !SRAM_SMAS_Global_Controller2PluggedInFlag
	RTL
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro DATATABLE_CUSTOM_SMBLL_CircleHDMAData(Address)
namespace SMBLL_CircleHDMAData
%InsertMacroAtXPosition(<Address>)

DATA_0096BD:
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF,$FE,$FE,$FE,$FE
	db $FD,$FD,$FD,$FD,$FC,$FC,$FC,$FB
	db $FB,$FB,$FA,$FA,$F9,$F9,$F8,$F8
	db $F7,$F7,$F6,$F6,$F5,$F5,$F4,$F3
	db $F3,$F2,$F1,$F1,$F0,$EF,$EE,$EE
	db $ED,$EC,$EB,$EA,$E9,$E9,$E8,$E7
	db $E6,$E5,$E4,$E3,$E2,$E1,$DF,$DE
	db $DD,$DC,$DB,$DA,$D8,$D7,$D6,$D5
	db $D3,$D2,$D0,$CF,$CD,$CC,$CA,$C9
	db $C7,$C6,$C4,$C2,$C1,$BF,$BD,$BB
	db $B9,$B7,$B6,$B4,$B1,$AF,$AD,$AB
	db $A9,$A7,$A4,$A2,$9F,$9D,$9A,$97
	db $95,$92,$8F,$8C,$89,$86,$82,$7F
	db $7B,$78,$74,$70,$6C,$67,$63,$5E
	db $59,$53,$4D,$46,$3F,$37,$2D,$1F
	db $00

DATA_00973E:
	dw $FFFF,$FFFF,$8000,$5555
	dw $4000,$3333,$2AAA,$2492
	dw $2000,$1C71,$1999,$1745
	dw $1555,$13B1,$1249,$1111
	dw $1000,$0F0F,$0E38,$0D79
	dw $0CCC,$0C30,$0BA2,$0B21
	dw $0AAA,$0A3D,$09D8,$097B
	dw $0924,$08D3,$0888,$0842
	dw $0800,$07C1,$0787,$0750
	dw $071C,$06EB,$06BC,$0690
	dw $0666,$063E,$0618,$05F4
	dw $05D1,$05B0,$0590,$0572
	dw $0555,$0539,$051E,$0505
	dw $04EC,$04D4,$04BD,$04A7
	dw $0492,$047D,$0469,$0456
	dw $0444,$0432,$0421,$0410
	dw $0400,$03F0,$03E0,$03D2
	dw $03C3,$03B5,$03A8,$039B
	dw $038E,$0381,$0375,$0369
	dw $035E,$0353,$0348,$033D
	dw $0333,$0329,$031F,$0315
	dw $030C,$0303,$02FA,$02F1
	dw $02E8,$02E0,$02D8,$02D0
	dw $02C8,$02C0,$02B9,$02B1
	dw $02AA,$02A3,$029C,$0295
	dw $028F,$0288,$0282,$027C
	dw $0276,$0270,$026A,$0264
	dw $025E,$0259,$0253,$024E
	dw $0249,$0243,$023E,$0239
	dw $0234,$0230,$022B,$0226
	dw $0222,$021D,$0219,$0214
	dw $0210,$020C,$0208,$0204
	dw $0200,$01FC,$01F8,$01F4
	dw $01F0,$01EC,$01E9,$01E5
	dw $01E1,$01DE,$01DA,$01D7
	dw $01D4,$01D0,$01CD,$01CA
	dw $01C7,$01C3,$01C0,$01BD
	dw $01BA,$01B7,$01B4,$01B2
	dw $01AF,$01AC,$01A9,$01A6
	dw $01A4,$01A1,$019E,$019C
	dw $0199,$0197,$0194,$0192
	dw $018F,$018D,$018A,$0188
	dw $0186,$0183,$0181,$017F
	dw $017D,$017A,$0178,$0176
	dw $0174,$0172,$0170,$016E
	dw $016C,$016A,$0168,$0166
	dw $0164,$0162,$0160,$015E
	dw $015C,$015A,$0158,$0157
	dw $0155,$0153,$0151,$0150
	dw $014E,$014C,$014A,$0149
	dw $0147,$0146,$0144,$0142
	dw $0141,$013F,$013E,$013C
	dw $013B,$0139,$0138,$0136
	dw $0135,$0133,$0132,$0130
	dw $012F,$012E,$012C,$012B
	dw $0129,$0128,$0127,$0125
	dw $0124,$0123,$0121,$0120
	dw $011F,$011E,$011C,$011B
	dw $011A,$0119,$0118,$0116
	dw $0115,$0114,$0113,$0112
	dw $0111,$010F,$010E,$010D
	dw $010C,$010B,$010A,$0109
	dw $0108,$0107,$0106,$0105
	dw $0104,$0103,$0102,$0101
	dw $0100
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_SMBLL_LoadSplashScreen(Address)
namespace SMBLL_LoadSplashScreen
%InsertMacroAtXPosition(<Address>)

Main:
	PHB
	PHK
	PLB
	REP.b #$20
	LDY.b #$80
	STY.w !REGISTER_VRAMAddressIncrementValue
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STA.w DMA[$00].Parameters
	LDA.w #$0000
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #SMBLL_SplashScreenGFX_Main
	STA.w DMA[$00].SourceLo
	LDX.b #SMBLL_SplashScreenGFX_Main>>16
	STX.w DMA[$00].SourceBank
	LDA.w #SMBLL_SplashScreenGFX_End-SMBLL_SplashScreenGFX_Main
	STA.w DMA[$00].SizeLo
	LDY.b #$01
	STY.w !REGISTER_DMAEnable
	LDX.b #$1E
-:
	LDA.w SplashScreenPalette,x
	STA.w SMBLL_PaletteMirror[$F0].LowByte,x
	DEX
	DEX
	BPL.b -
	SEP.b #$20
	LDA.b #$20
	STA.w !RAM_SMBLL_Global_FixedColorData1Mirror
	ASL
	STA.w !RAM_SMBLL_Global_FixedColorData2Mirror
	ASL
	STA.w !RAM_SMBLL_Global_FixedColorData3Mirror
	LDA.b #$10
	STA.w !REGISTER_MainScreenLayers
	STA.w !RAM_SMBLL_Global_MainScreenLayersMirror
	LDA.b #$00
	STA.w !REGISTER_OAMSizeAndDataAreaDesignation
	STA.w !RAM_SMBLL_Global_ScreenDisplayRegisterMirror
	STA.w !REGISTER_ScreenDisplayRegister
	STA.b !RAM_SMBLL_SplashScreen_DisplayMarioCoinShineFlag
	STA.b !RAM_SMBLL_SplashScreen_PaletteAnimationIndex
	INC.w !RAM_SMBLL_Global_UpdateEntirePaletteFlag
	STZ.b $28
	LDA.b #$81
	STA.b !RAM_SMBLL_SplashScreen_DisplayTimer
	STA.w !REGISTER_IRQNMIAndJoypadEnableFlags
-:
	JSR.w FadeIn
	LDA.w !RAM_SMBLL_Global_ScreenDisplayRegisterMirror
	CMP.b #$0F
	BNE.b -
Loop:
	LDA.b !RAM_SMBLL_SplashScreen_DisplayTimer
	CMP.b #$61
	BNE.b CODE_009A9B
	LDA.b #!Define_SMAS_Sound0063_Coin
	STA.w !REGISTER_APUPort3						; Note: SPC stuff is not handled in V-Blank, so it's necessary to write to this register directly.
	STA.b !RAM_SMBLL_SplashScreen_DisplayMarioCoinShineFlag
	LDA.b #$02
	STA.b !RAM_SMBLL_SplashScreen_PaletteAnimationTimer
	STZ.b !RAM_SMBLL_SplashScreen_PaletteAnimationIndex
CODE_009A9B:
	JSR.w SMBLL_SplashScreenGFXRt_Main
	LDA.b !RAM_SMBLL_SplashScreen_DisplayMarioCoinShineFlag
	BEQ.b CODE_009AA5
	JSR.w SMBLL_HandleSplashScreenMarioCoinShine_Main
CODE_009AA5:
	JSR.w WaitForVBlank
	DEC.b !RAM_SMBLL_SplashScreen_DisplayTimer
	BNE.b Loop
-:
	JSR.w FadeOut
	LDA.w !RAM_SMBLL_Global_ScreenDisplayRegisterMirror
	BNE.b -
	LDA.b #$80
	STA.w !RAM_SMBLL_Global_ScreenDisplayRegisterMirror
	STZ.w !REGISTER_IRQNMIAndJoypadEnableFlags
	PLB
	RTL

FadeIn:
	INC.w !RAM_SMBLL_Global_ScreenDisplayRegisterMirror
	BRA.b +

FadeOut:
	DEC.w !RAM_SMBLL_Global_ScreenDisplayRegisterMirror
+:
	STZ.b !RAM_SMBLL_SplashScreen_PaletteAnimationTimer
	JSR.w SMBLL_SplashScreenGFXRt_Main
	JSR.w WaitForVBlank
	RTS

WaitForVBlank:
	STZ.w $0154
-:
	LDA.w $0154
	BEQ.b -
	CLI
	RTS

SplashScreenPalette:
	dw $0000,$7FFF,$0048,$012F,$0192,$01F5,$0A59,$171C,$2BBC,$00CC,$0A59,$171C,$2BBC,$53FF,$171C,$0A59
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_SMBLL_SplashScreenGFXRt(Address)
namespace SMBLL_SplashScreenGFXRt
%InsertMacroAtXPosition(<Address>)

Tiles:
	db $00,$02,$04,$06,$20,$22,$24,$26
	db $08,$0A,$0C,$0E,$28,$2A,$2C,$2E
	db $40,$42,$44,$46

Main:
	LDY.b #$00
	TYX
CODE_009E31:
	LDA.b #$50
	STA.b !RAM_SMBLL_Global_ScratchRAM00
CODE_009E35:
	LDA.b #$60
	STA.b !RAM_SMBLL_Global_ScratchRAM01
CODE_009E39:
	LDA.b !RAM_SMBLL_Global_ScratchRAM01
	STA.w SMBLL_OAMBuffer[$00].XDisp,y
	LDA.b !RAM_SMBLL_Global_ScratchRAM00
	STA.w SMBLL_OAMBuffer[$00].YDisp,y
	LDA.w Tiles,x
	STA.w SMBLL_OAMBuffer[$00].Tile,y
	INX
	LDA.b #$2E
	STA.w SMBLL_OAMBuffer[$00].Prop,y
	;PHY
	;TYA
	;LSR
	;LSR
	;TAY
	LDA.b #$02
	STA.w SMBLL_OAMTileSizeBuffer[$00].Slot,y
	;PLY
	INY
	INY
	INY
	INY
	LDA.b !RAM_SMBLL_Global_ScratchRAM01
	CLC
	ADC.b #$10
	STA.b !RAM_SMBLL_Global_ScratchRAM01
	CMP.b #$A0
	BCC.b CODE_009E39
	LDA.b !RAM_SMBLL_Global_ScratchRAM00
	CLC
	ADC.b #$10
	STA.b !RAM_SMBLL_Global_ScratchRAM00
	CMP.b #$A0
	BCC.b CODE_009E35
	JSL.l SMBLL_CompressOAMTileSizeBuffer_Main
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_SMBLL_HandleSplashScreenMarioCoinShine(Address)
namespace SMBLL_HandleSplashScreenMarioCoinShine
%InsertMacroAtXPosition(<Address>)

DATA_009E75:
	dw $7FFF,$2BBC,$43FF,$171C
	dw $7FFF,$2BBC,$171C,$2BBC
	dw $7FFF,$0A59,$171C,$2BBC

DATA_009E8D:
	dw $53FF,$171C,$0A59,$53FF
	dw $171C,$0A59,$53FF,$7FFF
	dw $2BBC,$53FF,$171C,$0A59

Main:
	LDA.b !RAM_SMBLL_SplashScreen_PaletteAnimationIndex
	ASL
	STA.b !RAM_SMBLL_Global_ScratchRAM00
	ASL
	CLC
	ADC.b !RAM_SMBLL_Global_ScratchRAM00
	TAY
	LDX.b #$00
CODE_009EB1:
	LDA.w DATA_009E75,y
	STA.l SMBLL_PaletteMirror[$F6].LowByte,x
	LDA.w DATA_009E8D,y
	STA.l SMBLL_PaletteMirror[$FD].LowByte,x
	INY
	INX
	CPX.b #$06
	BCC.b CODE_009EB1
	INC.w !RAM_SMBLL_Global_UpdateEntirePaletteFlag
	DEC.b !RAM_SMBLL_SplashScreen_PaletteAnimationTimer
	BNE.b CODE_009EE0
	INC.b !RAM_SMBLL_SplashScreen_PaletteAnimationIndex
	LDX.b !RAM_SMBLL_SplashScreen_PaletteAnimationIndex
	CPX.b #$04
	BCC.b CODE_009EDC
	STZ.b !RAM_SMBLL_SplashScreen_PaletteAnimationIndex
	STZ.b !RAM_SMBLL_SplashScreen_PaletteAnimationTimer
	STZ.b !RAM_SMBLL_SplashScreen_DisplayMarioCoinShineFlag
	BRA.b CODE_009EE0

CODE_009EDC:
	LDA.b #$02
	STA.b !RAM_SMBLL_SplashScreen_PaletteAnimationTimer
CODE_009EE0:
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_SMBLL_LoadFileSelectMenu(Address)
namespace SMBLL_LoadFileSelectMenu
%InsertMacroAtXPosition(<Address>)

Main:
	STZ.b !RAM_SMBLL_Global_ScratchRAM06
	JSR.w Sub
	LDA.b !RAM_SMBLL_TitleScreen_FileAMaxWorld
	STA.b !RAM_SMBLL_TitleScreen_FileASelectedWorld
	LDA.b !RAM_SMBLL_TitleScreen_FileBMaxWorld
	STA.b !RAM_SMBLL_TitleScreen_FileBSelectedWorld
	LDA.b !RAM_SMBLL_TitleScreen_FileCMaxWorld
	STA.b !RAM_SMBLL_TitleScreen_FileCSelectedWorld
	RTL

Entry2:
	LDA.b #$01
	STA.b !RAM_SMBLL_Global_ScratchRAM06
	JSR.w Sub
	RTL

Sub:
	PHB
	PHK
	PLB
	REP.b #$10
	LDX.w !RAM_SMBLL_Global_StripeImageUploadIndexLo
	LDY.w #$0000
--:
	STY.b !RAM_SMBLL_Global_ScratchRAM02
	REP.b #$20
	LDA.w FileSelectTextPtrs,y
	JSR.w BufferStripeImage
	LDY.b !RAM_SMBLL_Global_ScratchRAM02
	REP.b #$20
	PHX
	LDX.w SMBLL_SaveFileLocations_Main,y
	LDA.l !SRAM_SMAS_Global_SaveFileBaseOffset+$01,x
	AND.w #$00FF
	STA.b !RAM_SMBLL_Global_ScratchRAM00
	LDA.l !SRAM_SMAS_Global_SaveFileBaseOffset,x
	PHA
	AND.w #$00FF
	ASL
	ASL
	CLC
	ADC.b !RAM_SMBLL_Global_ScratchRAM00
	STA.b !RAM_SMBLL_Global_ScratchRAM04
	PLA
	PLX
	CMP.w #$FFFF
	BEQ.b .NewFile
	LDA.w #FileSelectText_World
	BRA.b .UsedFile

.NewFile:
	LDA.w #FileSelectText_New
.UsedFile:
	JSR.w BufferStripeImage
	LDA.b #$00
	XBA
	LDA.b !RAM_SMBLL_Global_ScratchRAM02
	LSR
	TAY
	LDA.b !RAM_SMBLL_Global_ScratchRAM04
	BMI.b +
	LDA.b !RAM_SMBLL_Global_ScratchRAM06
	BEQ.b ++
	LDA.w !RAM_SMBLL_TitleScreen_FileASelectedWorld,y
	BRA.b +++	

++:
	LDA.b !RAM_SMBLL_Global_ScratchRAM04
	STA.w !RAM_SMBLL_TitleScreen_FileAMaxWorld,y
	STA.w !RAM_SMBLL_TitleScreen_FileASelectedWorld,y
+++:
	PHY
	AND.b #$FC
	LSR
	TAY
	LDA.w WorldNumberTiles,y
	STA.w SMBLL_StripeImageUploadTable[$00].LowByte-$06,x
	LDA.w WorldNumberTiles+$01,y
	STA.w SMBLL_StripeImageUploadTable[$00].HighByte-$06,x
	PLY
	LDA.w !RAM_SMBLL_TitleScreen_FileASelectedWorld,y
	AND.b #$03
	ASL
	TAY
	LDA.w WorldNumberTiles,y
	STA.w SMBLL_StripeImageUploadTable[$00].LowByte-$02,x
	LDA.w WorldNumberTiles+$01,y
	STA.w SMBLL_StripeImageUploadTable[$00].HighByte-$02,x
	BRA.b ++

+:
	LDA.b #$00
	STA.w !RAM_SMBLL_TitleScreen_FileAMaxWorld,y
++:
	LDY.b !RAM_SMBLL_Global_ScratchRAM02
	INY
	INY
	CPY.w #$0006
	BEQ.b +
	JMP.w --

+:
	LDY.w #FileSelectText_Erase
	LDA.b !RAM_SMBLL_TitleScreen_EraseFileProcess
	BEQ.b +
	LDY.w #FileSelectText_End
+:

	REP.b #$20
	TYA
	JSR.w BufferStripeImage
	STA.w SMBLL_StripeImageUploadTable[$00].LowByte,x
	REP.b #$20
	TXA
	STA.w !RAM_SMBLL_Global_StripeImageUploadIndexLo
	SEP.b #$30
	PLB
	RTS

FileSelectTextPtrs:
	dw FileSelectText_FileA
	dw FileSelectText_FileB
	dw FileSelectText_FileC
	dw FileSelectText_Erase

WorldNumberTiles:
	db $01,$08
	db $02,$08
	db $03,$08
	db $04,$08
	db $05,$08
	db $06,$08
	db $07,$08
	db $08,$08
	db $09,$08
	db $0A,$08
	db $0B,$08
	db $0C,$08
	db $0D,$08

FileSelectText:
.FileA:
	db $02,$4D,$00,$21
	db $0F,$08,$12,$08,$15,$08,$0E,$08,$24,$00,$0A,$08,$24,$00,$FF

.FileB:
	db $02,$8D,$00,$21
	db $0F,$08,$12,$08,$15,$08,$0E,$08,$24,$00,$0B,$08,$24,$00,$FF

.FileC:
	db $02,$CD,$00,$21
	db $0F,$08,$12,$08,$15,$08,$0E,$08,$24,$00,$0C,$08,$24,$00,$FF

.New:
	db $24,$00,$17,$08,$0E,$08,$20,$08,$24,$00,$24,$00,$24,$00,$24,$00
	db $24,$00,$24,$00,$FF

.World:
	db $24,$00,$20,$08,$18,$08,$1B,$08,$15,$08,$0D,$08,$24,$00,$01,$08
	db $28,$08,$01,$08,$FF

.Erase:
	db $03,$0D,$00,$15
	db $0E,$08,$1B,$08,$0A,$08,$1C,$08,$0E,$08,$24,$00,$0D,$08,$0A,$08
	db $1D,$08,$0A,$08,$24,$00,$FF

.End:
	db $03,$0D,$00,$15
	db $0E,$08,$17,$08,$0D,$08,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00
	db $24,$00,$24,$00,$24,$00,$FF

BufferStripeImage:
	STA.b !RAM_SMBLL_Global_ScratchRAM00
	SEP.b #$20
	LDY.w #$0000
-:
	LDA.b (!RAM_SMBLL_Global_ScratchRAM00),y
	CMP.b #$FF
	BEQ.b +
	STA.w SMBLL_StripeImageUploadTable[$00].LowByte,x
	INX
	INY
	BRA.b -

+:
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_SMBLL_LoadPlayerSelectMenu(Address)
namespace SMBLL_LoadPlayerSelectMenu
%InsertMacroAtXPosition(<Address>)

Main:
	STZ.b !RAM_SMBLL_Global_ScratchRAM06
	JSR.w Sub
	RTL

Entry2:
	LDA.b #$01
	STA.b !RAM_SMBLL_Global_ScratchRAM06
	JSR.w Sub
	RTL

Sub:
	PHB
	PHK
	PLB
	LDX.b #$00
	LDA.w ShowLineFlags,x
	STA.b !RAM_SMBLL_Global_ScratchRAM04
	LDA.b !RAM_SMBLL_Global_ScratchRAM06
	BNE.b +
	LDA.w NewCursorPos,x
	STA.w !RAM_SMBLL_TitleScreen_MenuSelectionIndex
+:
	REP.b #$10
	LDX.w !RAM_SMBLL_Global_StripeImageUploadIndexLo
	LDY.w #$0000
--:
	STY.b !RAM_SMBLL_Global_ScratchRAM02
	REP.b #$20
	LDA.w PlayerSelectTextPtrs,y
	STA.b !RAM_SMBLL_Global_ScratchRAM00
	LDY.w #$0000
-:
	LDA.b (!RAM_SMBLL_Global_ScratchRAM00),y
	STA.w SMBLL_StripeImageUploadTable[$00].LowByte,x
	INX
	INX
	INY
	INY
	CPY.w #$0004
	BNE.b -
	LSR.b !RAM_SMBLL_Global_ScratchRAM04
	BCS.b .ShowLine
	LDY.w #$0000
	LDA.w #PlayerSelectText_BlankLine
	STA.b !RAM_SMBLL_Global_ScratchRAM00
.ShowLine:
	SEP.b #$20
-:
	LDA.b (!RAM_SMBLL_Global_ScratchRAM00),y
	CMP.b #$FF
	BEQ.b +
	STA.w SMBLL_StripeImageUploadTable[$00].LowByte,x
	INX
	INY
	BRA.b -

+:
	LDY.b !RAM_SMBLL_Global_ScratchRAM02
	INY
	INY
	CPY.w #$0004
	BNE.b --
	LDY.w #PlayerSelectText_ControllerType_Jump
	LDA.l !SRAM_SMAS_Global_ControllerTypeX
	REP.b #$20
	BEQ.b +
	LDY.w #PlayerSelectText_ControllerType_Dash
+:
	TYA
	JSR.w SMBLL_LoadFileSelectMenu_BufferStripeImage
	STA.w SMBLL_StripeImageUploadTable[$00].LowByte,x
	REP.b #$20
	LDA.w #PlayerSelectText_TopScore
	JSR.w SMBLL_LoadFileSelectMenu_BufferStripeImage
	STA.w SMBLL_StripeImageUploadTable[$00].LowByte,x
	LDA.w !RAM_SMBLL_TitleScreen_TopScoreMillionsDigit
	BEQ.b +
	STA.w SMBLL_StripeImageUploadTable[$00].LowByte-$0E,x
+:
	LDA.w !RAM_SMBLL_TitleScreen_TopScoreHundredThousandsDigit
	STA.w SMBLL_StripeImageUploadTable[$00].LowByte-$0C,x
	LDA.w !RAM_SMBLL_TitleScreen_TopScoreTenThousandsDigit
	STA.w SMBLL_StripeImageUploadTable[$00].LowByte-$0A,x
	LDA.w !RAM_SMBLL_TitleScreen_TopScoreThousandsDigit
	STA.w SMBLL_StripeImageUploadTable[$00].LowByte-$08,x
	LDA.w !RAM_SMBLL_TitleScreen_TopScoreHundredsDigit
	STA.w SMBLL_StripeImageUploadTable[$00].LowByte-$06,x
	LDA.w !RAM_SMBLL_TitleScreen_TopScoreTensDigit
	STA.w SMBLL_StripeImageUploadTable[$00].LowByte-$04,x
	TXA
	STA.w !RAM_SMBLL_Global_StripeImageUploadIndexLo
	SEP.b #$30
	PLB
	RTS

ShowLineFlags:
	db $07,$05,$06

NewCursorPos:
	db $00,$00,$01

PlayerSelectTextPtrs:
	dw PlayerSelectText_MarioGame
	dw PlayerSelectText_LuigiGame

PlayerSelectText:
.MarioGame:
	db $02,$4D,$00,$23
	db $16,$08,$0A,$08,$1B,$08,$12,$08,$18,$08,$24,$08,$10,$08,$0A,$08
	db $16,$08,$0E,$08,$24,$08,$24,$08,$24,$08,$24,$08,$24,$08,$24,$08
	db $24,$08,$24,$08,$FF

.LuigiGame:
	db $02,$8D,$00,$23
	db $15,$08,$1E,$08,$12,$08,$10,$08,$12,$08,$24,$08,$10,$08,$0A,$08
	db $16,$08,$0E,$08,$24,$08,$24,$08,$24,$08,$24,$08,$24,$08,$24,$08
	db $24,$08,$24,$08,$FF

.BlankLine:
	db $24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00
	db $24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00
	db $24,$00,$24,$00,$FF

.ControllerType:
..Jump:
	db $02,$CD,$00,$23
	db $0B,$08,$28,$08,$24,$00,$13,$08,$1E,$08,$16,$08,$19,$08,$24,$00
	db $24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00
	db $24,$00,$24,$00,$FF

..Dash:
	db $02,$CD,$00,$23
	db $0B,$08,$28,$08,$24,$00,$0D,$08,$0A,$08,$1C,$08,$11,$08,$24,$00
	db $24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00,$24,$00
	db $24,$00,$24,$00,$FF

.TopScore:
	db $03,$0D,$00,$15
	db $1D,$08,$18,$08,$19,$08,$28,$08,$24,$08,$24,$08,$24,$08,$24,$08
	db $24,$08,$24,$08,$00,$08

	db $FF
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_SMBLL_ClearSaveData(Address)
namespace SMBLL_ClearSaveData
%InsertMacroAtXPosition(<Address>)

Main:
	LDA.w !RAM_SMBLL_TitleScreen_MenuSelectionIndex
	TAY
	ASL
	TAX
	LDA.b #$00
	STA.w !RAM_SMBLL_TitleScreen_FileASelectedWorld,y
	STA.w !RAM_SMBLL_TitleScreen_FileAMaxWorld,y
	REP.b #$20
	LDA.l SMBLL_SaveFileLocations_Main,x
	REP.b #$10
	TAX
	LDA.w #$FFFF
	STA.l !SRAM_SMAS_Global_SaveFileBaseOffset,x
	SEP.b #$30
	JML.l SMBLL_VerifySaveDataIsValid_Main
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_SMBLL_ChangeSelectedWorld(Address)
namespace SMBLL_ChangeSelectedWorld
%InsertMacroAtXPosition(<Address>)

Main:
	PHA
	LDY.w !RAM_SMBLL_TitleScreen_MenuSelectionIndex
	LDA.w !RAM_SMBLL_TitleScreen_FileAMaxWorld,y
	CMP.b #$01
	BCS.b +
	PLA
	LDA.b #!Define_SMAS_Sound0063_Wrong
	STA.w !RAM_SMBLL_Global_SoundCh3
	RTL

+:
	PHY
	TYA
	ASL
	TAY
	PHB
	PHK
	PLB
	LDX.w SMBLL_SaveFileLocations_Main,y
	PLB
	PLY
	LDA.l !SRAM_SMAS_Global_SaveFileBaseOffset+$04,x
	STA.b !RAM_SMBLL_Global_ScratchRAM02
	LDA.w !RAM_SMBLL_TitleScreen_FileAMaxWorld,y
	INC
	STA.b !RAM_SMBLL_Global_ScratchRAM00
	PLA
-:
	BIT.b #$03
	BEQ.b .NoLeftOrRight
	AND.b #$03
	DEC
	TAX
	LDA.l .AdditionTable,x
	BRA.b +

.NoLeftOrRight:
	LDA.b #$01
+:
	CLC
	ADC.w !RAM_SMBLL_TitleScreen_FileASelectedWorld,y
	CMP.b #$FF
	BEQ.b .FixUnderflow
	CMP.w !RAM_SMBLL_Global_ScratchRAM00
	BCC.b +
	LDA.b #$00
	BRA.b .FixOverflow

.FixUnderflow:
	LDA.w !RAM_SMBLL_TitleScreen_FileAMaxWorld,y
+:
.FixOverflow:
	STA.w !RAM_SMBLL_TitleScreen_FileASelectedWorld,y
	CMP.b #$20
	BCC.b +
	CMP.b #$24
	BCS.b +
	LDX.b !RAM_SMBLL_Global_ScratchRAM02
	BEQ.b +
	LDA.w !RAM_SMBLL_Global_ControllerPress1
	ORA.w !RAM_SMBLL_Global_ControllerPress2
	JMP.w -

+:
	LDA.b #!Define_SMAS_Sound0063_FinishAddTimerToScore
	STA.w !RAM_SMBLL_Global_SoundCh3
	JSL.l SMBLL_LoadFileSelectMenu_Entry2
	RTL

.AdditionTable:
	db $01,$FF,$01
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_SMBLL_MoveTitleScreenMenuCursor(Address)
namespace SMBLL_MoveTitleScreenMenuCursor
%InsertMacroAtXPosition(<Address>)

Main:
	STZ.b !RAM_SMBLL_Global_ScratchRAM00
	STA.b !RAM_SMBLL_Global_ScratchRAM01
-:
	BIT.b #$0C
	BEQ.b .NoUpOrDown
	AND.b #$0C
	LSR
	LSR
	LSR
	TAX
	LDA.l AdditionTable,x
	BRA.b +

.NoUpOrDown:
	LDA.b #$01
+:
	LDX.b !RAM_SMBLL_TitleScreen_FileSelectProcess
	CLC
	ADC.w !RAM_SMBLL_TitleScreen_MenuSelectionIndex
	CMP.b #$FF
	BEQ.b .FixUnderflow
	CMP.l NumberOfMenuItems,x
	BCC.b +
	LDA.b #$00
	BRA.b .FixOverflow

.FixUnderflow:
	LDA.l NumberOfMenuItems,x
	DEC
+:
.FixOverflow:
	STA.w !RAM_SMBLL_TitleScreen_MenuSelectionIndex
	;LDA.b !RAM_SMBLL_Global_ScratchRAM00
	;BNE.b .Return
	;LDA.b !RAM_SMBLL_TitleScreen_FileSelectProcess
	;BEQ.b .Return
	;INC.b !RAM_SMBLL_Global_ScratchRAM00
	;LDA.l !RAM_SMBLL_Global_DisplayTitleScreenMenuOptionsIndex
	;BMI.b .Return
	;DEC
	;TAX
	;LDA.l BlankSettingLoc,x
	;CMP.w !RAM_SMBLL_TitleScreen_MenuSelectionIndex
	;BNE.b .Return
	;LDA.b !RAM_SMBLL_Global_ScratchRAM01
	;JMP.w -

.Return:
	LDA.b #!Define_SMAS_Sound0063_Coin
	STA.w !RAM_SMBLL_Global_SoundCh3
	RTL

AdditionTable:
	db $01,$FF,$01

BlankSettingLoc:
	db $01,$00

NumberOfMenuItems:
	db $04,$03
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_SMBLL_LoadSaveFileData(Address)
namespace SMBLL_LoadSaveFileData
%InsertMacroAtXPosition(<Address>)

Main:
	PHB
	LDA.b #!SRAMBankBaseAddress>>16
	PHA
	PLB
	REP.b #$10
	LDY.w #$0006
	STY.b !RAM_SMBLL_Global_ScratchRAM04
	LDA.b #$00
	XBA
	LDA.l !RAM_SMBLL_TitleScreen_MenuSelectionIndex
	STA.w !SRAM_SMAS_Global_CurrentSaveFile
	ASL
	TAX
	REP.b #$20
	LDA.l SMBLL_SaveFileLocations_Main,x
	TAY
	STA.w $700004
	SEP.b #$20
	LDX.w #$0000
CODE_00A61C:
	LDA.w !SRAM_SMAS_Global_SaveFileBaseOffset,y
	STA.l !RAM_SMBLL_Global_InitialWorld,x
	INY
	INX
	CPX.b !RAM_SMBLL_Global_ScratchRAM04
	BNE.b CODE_00A61C
	SEP.b #$10
	PLB
	LDA.l !SRAM_SMAS_Global_InitialSelectedLevel
	STA.w $0E24
	STA.w $075C
	STA.l !RAM_SMBLL_Global_InitialLevel
	LDA.l !SRAM_SMAS_Global_InitialSelectedWorld
	STA.w !RAM_SMBLL_Player_CurrentWorld
	STA.l !RAM_SMBLL_Global_InitialWorld
	ASL
	ASL
	CLC
	ADC.l !SRAM_SMAS_Global_InitialSelectedLevel
	TAX
	LDA.l DATA_0FE06D,x
	STA.l !SRAM_SMAS_Global_InitialSelectedLevel
	STA.l $7FFB02
	STA.w !RAM_SMBLL_Player_CurrentLevel
	RTL
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_SMBLL_VerifySaveDataIsValid(Address)
namespace SMBLL_VerifySaveDataIsValid
%InsertMacroAtXPosition(<Address>)

Main:
	PHB
	PHK
	PLB
Loop:
	SEP.b #$20
	LDA.b #$00
	STA.l !SRAM_SMAS_Global_EnableSMASDebugModeFlag
 	STA.l !SRAM_SMAS_Global_ControllerTypeX
	REP.b #$30
	LDA.l !SRAM_SMAS_Global_ValidSaveData1Lo
	CMP.w #$9743
	BNE.b CODE_008C88
	LDA.l !SRAM_SMAS_Global_ValidSaveData2Lo
	CMP.w #$5321
	BEQ.b CODE_008CBF
CODE_008C88:
	SEP.b #$10
	LDA.w #$2000
	STA.b !RAM_SMBLL_Global_ScratchRAM00
	LDA.w #!SRAMBankBaseAddress
	LDY.b #!SRAMBankBaseAddress>>16
	JSL.l SMBLL_InitializeSelectedRAM_Main
	REP.b #$10
	LDX.w #$0000
CODE_008C9D:
	JSR.w CODE_008D41
	LDA.l !SRAM_SMAS_Global_SaveFileIndexLo
	INC
	STA.l !SRAM_SMAS_Global_SaveFileIndexLo
	CMP.w #$0003
	BCC.b CODE_008C9D
	LDA.w #$9743
	STA.l !SRAM_SMAS_Global_ValidSaveData1Lo
	LDA.w #$5321
	STA.l !SRAM_SMAS_Global_ValidSaveData2Lo
	JMP.w Loop

CODE_008CBF:
	LDA.w #$0000
	STA.l !SRAM_SMAS_Global_SaveFileIndexLo
	TAX
CODE_008CC7:
	LDY.w #$0006
	STZ.b !RAM_SMBLL_Global_ScratchRAM00
	STX.b !RAM_SMBLL_Global_ScratchRAM02
	SEP.b #$20
CODE_008CD8:
	LDA.l !SRAM_SMAS_Global_SaveFileBaseOffset,x
	CLC
	ADC.b !RAM_SMBLL_Global_ScratchRAM00
	STA.b !RAM_SMBLL_Global_ScratchRAM00
	LDA.b !RAM_SMBLL_Global_ScratchRAM01
	ADC.b #$00
	STA.b !RAM_SMBLL_Global_ScratchRAM01
	INX
	DEY
	BNE.b CODE_008CD8
	REP.b #$21
	LDA.b !RAM_SMBLL_Global_ScratchRAM00
	ADC.l !SRAM_SMAS_Global_SaveFileBaseOffset,x
	BNE.b CODE_008D07
	INX
	INX
CODE_008CF7:
	LDA.l !SRAM_SMAS_Global_SaveFileIndexLo
	INC
	STA.l !SRAM_SMAS_Global_SaveFileIndexLo
	CMP.w #$0003
	BCS.b CODE_008D12
	BRA.b CODE_008CC7

CODE_008D07:
	REP.b #$30
	LDX.b !RAM_SMBLL_Global_ScratchRAM02
	JSR.w CODE_008D41
	STX.b !RAM_SMBLL_Global_ScratchRAM02
	BRA.b CODE_008CF7

CODE_008D12:
	SEP.b #$30
	PLB
	RTL

CODE_008D41:
	LDA.w #$0006
	STA.b !RAM_SMBLL_Global_ScratchRAM04
	LDY.w #$0000
	STZ.b !RAM_SMBLL_Global_ScratchRAM00
	SEP.b #$20
CODE_008D59:
	LDA.w PremadeSaveFileData,y
	STA.l !SRAM_SMAS_Global_SaveFileBaseOffset,x
	CLC
	ADC.b !RAM_SMBLL_Global_ScratchRAM00
	STA.b !RAM_SMBLL_Global_ScratchRAM00
	LDA.b !RAM_SMBLL_Global_ScratchRAM01
	ADC.b #$00
	STA.b !RAM_SMBLL_Global_ScratchRAM01
	LDA.w PremadeSaveFileData,y
	INX
	INY
	DEC.b !RAM_SMBLL_Global_ScratchRAM04
	BNE.b CODE_008D59
	DEC.b !RAM_SMBLL_Global_ScratchRAM05
	BPL.b CODE_008D59
	REP.b #$20
	LDA.w #$0000
	SEC
	SBC.b !RAM_SMBLL_Global_ScratchRAM00
	STA.l !SRAM_SMAS_Global_SaveFileBaseOffset,x
	INX
	INX
	RTS

PremadeSaveFileData:
	db $FF,$FF,$FF,$04,$00,$FF,$00,$00
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro DATATABLE_CUSTOM_SMBLL_SaveFileLocations(Address)
namespace SMBLL_SaveFileLocations
%InsertMacroAtXPosition(<Address>)

Main:
	dw $0000,$0008,$0010
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_SMBLL_UploadMusicBank(Address)
namespace SMBLL_UploadMusicBank
%InsertMacroAtXPosition(<Address>)

Main:
	SEI
	STZ.w !REGISTER_IRQNMIAndJoypadEnableFlags
	STZ.w !REGISTER_HDMAEnable
	LDA.b #$FF
	STA.w !REGISTER_APUPort1
	LDA.b #SMB1MusicBank
	STA.b !RAM_SMBLL_Global_ScratchRAM00
	LDA.b #SMB1MusicBank>>8
	STA.b !RAM_SMBLL_Global_ScratchRAM01
	LDA.b #SMB1MusicBank>>16
	STA.b !RAM_SMBLL_Global_ScratchRAM02
	JSR.w SMBLL_HandleSPCUploads_Main
	RTL
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################

macro ROUTINE_CUSTOM_SMBLL_StoreDataToSaveFileAndUpdateTempChecksum(Address)
namespace SMBLL_StoreDataToSaveFileAndUpdateTempChecksum
%InsertMacroAtXPosition(<Address>)

Main:
	STA.l !SRAM_SMAS_Global_SaveFileBaseOffset,x
	INX
	CLC
	ADC.b !RAM_SMBLL_Global_ScratchRAM00
	STA.b !RAM_SMBLL_Global_ScratchRAM00
	LDA.b !RAM_SMBLL_Global_ScratchRAM01
	ADC.b #$00
	STA.b !RAM_SMBLL_Global_ScratchRAM01
	RTS
namespace off
endmacro

;#############################################################################################################
;#############################################################################################################
