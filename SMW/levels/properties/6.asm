; Part of the Secondary Entrance information; each byte is one of the secondary entrances. The low 4 bits are the Y position for Mario
; offsets into a table at SNES addresses $05:D730 and $05:D740. The next two bits are the FG initial position, indexing into
; the table at SNES address $05:D708. The highest 2 bits are the BG initial position, indexing into the table at SNES address $05:D70C.

db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 000-007
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 008-00F
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 010-017
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 018-01F
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 020-027
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 028-02F
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 030-037
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 038-03F
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 040-047
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 048-04F
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 050-057
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 058-05F
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 060-067
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 068-06F
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 070-077
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 078-07F
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 080-087
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 088-08F
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 090-097
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 098-09F
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 0A0-0A7
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 0A8-0AF
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 0B0-0B7
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%10101011 ; 0B8-0BF
db %10101001,%11000010,%10100110,%10101010,%00000000,%00000000,%00000000,%00000000 ; 0C0-0C7
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%10101010,%00000010 ; 0C8-0CF
db %10101010,%00000000,%10101000,%00000000,%00000000,%00000000,%00000000,%10101000 ; 0D0-0D7
db %10101000,%10101010,%00000000,%10101010,%00000000,%10101011,%10101001,%00000000 ; 0D8-0DF
db %00000000,%10101011,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 0E0-0E7
db %00000000,%00000000,%00000010,%00000000,%00000000,%00000000,%00000000,%10101011 ; 0E8-0EF
db %10101010,%00000000,%00000000,%00000000,%10101001,%00000000,%10101010,%10101011 ; 0F0-0F7
db %00000000,%00000000,%00000000,%00000000,%00000000,%10101001,%00000000,%10101011 ; 0F8-0FF
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 100-107
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 108-10F
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 110-117
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 118-11F
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 120-127
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 128-12F
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 130-137
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 138-13F
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 140-147
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 148-14F
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 150-157
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 158-15F
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 160-167
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 168-16F
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 170-177
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 178-17F
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 180-187
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 188-18F
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 190-197
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 198-19F
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 1A0-1A7
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 1A8-1AF
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 1B0-1B7
db %00000000,%00000000,%00000000,%10101000,%10101010,%00000000,%10101011,%10101001 ; 1B8-1BF
db %10100111,%10101010,%00000000,%10101010,%00000000,%00000000,%10100111,%00000000 ; 1C0-1C7
db %00000000,%10101011,%10101011,%10101001,%00000000,%00000000,%00000000,%00000000 ; 1C8-1CF
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 1D0-1D7
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 1D8-1DF
db %10101010,%00000000,%00000000,%00000000,%10101000,%00000000,%00000000,%00000000 ; 1E0-1E7
db %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%10100111 ; 1E8-1EF
db %00000000,%00000000,%00000000,%00000000,%00000000,%10101011,%00000000,%10101011 ; 1F0-1F7
db %10101010,%00000000,%00000000,%00000000,%00000000,%10101001,%00000000,%00000000 ; 1F8-1FF
