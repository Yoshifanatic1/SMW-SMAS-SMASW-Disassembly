@echo off

set PATH="../../Global"
set Input1=
set ROMName=SMAS.sfc
set MemMap=lorom

setlocal EnableDelayedExpansion

echo To fully extract all files for supported ROMs, you'll need one of the following ROMs in each group:
echo - Graphics: All international versions and one Japanese version
echo - International Random Chatter Sample: SMAS (USA)/SMAS (PAL)/SMAS+W (USA)/SMAS+W (PAL)
echo - Japanese Random Chatter Sample: SMAS (Japan)/SMAS (Japan Rev. 1)
echo - Main Samples: Any
echo - Music: Any
echo - SMW assets: SMAS+W (USA)/SMAS+W (PAL)
echo - Standalone Games Hack Assets: SMAS+W (USA)/SMAS+W (PAL)
echo.

:Start
echo Place a headerless SMAS ROM named %ROMName% in this folder, then type the number representing what version %ROMName% is.
echo 0 = SMAS (USA)
echo 1 = SMAS (PAL)
echo 2 = SMAS (Japan)
echo 3 = SMAS (Japan Rev. 1)
echo 4 = SMAS+W (USA)
echo 5 = SMAS+W (PAL)

:Mode
set /p Input1=""
if exist %ROMName% goto :ROMExists

echo You need to place a SMAS ROM named %ROMName% in this folder before you can extract any assets^^!
goto :Mode

:ROMExists
if "%Input1%" equ "0" goto :SMASU
if "%Input1%" equ "1" goto :SMASE
if "%Input1%" equ "2" goto :SMASJ1
if "%Input1%" equ "3" goto :SMASJ2
if "%Input1%" equ "4" goto :SMASWU
if "%Input1%" equ "5" goto :SMASWE

echo %Input1% is not a valid mode.
goto :Mode

:SMASU
set SMASGFXLoc="../Graphics"
set MainBrrLoc="../SPC700/Samples/Main"
set RCBrrLoc="../SPC700/Samples/RandomChatter"
set SMASMusicLoc="../SPC700/Music"
set SMB1GFXLoc="../../SMB1/Graphics"
set SMB1MusicLoc="../../SMB1/SPC700/Music"
set SMB2UGFXLoc="../../SMB2U/Graphics"
set SMB2UMusicLoc="../../SMB2U/SPC700/Music"
set SMB3BGGFXLoc="../../SMB3/Graphics/Layer2"
set SMB3GFXLoc="../../SMB3/Graphics"
set SMB3LMusicLoc="../../SMB3/SPC700/Music/Levels"
set SMB3OMusicLoc="../../SMB3/SPC700/Music/Overworld"
set ROMBit=$0001
goto :BeginExtract

:SMASE
set SMASGFXLoc="../Graphics"
set MainBrrLoc="../SPC700/Samples/Main"
set RCBrrLoc="../SPC700/Samples/RandomChatter"
set SMASMusicLoc="../SPC700/Music"
set SMB1GFXLoc="../../SMB1/Graphics"
set SMB1MusicLoc="../../SMB1/SPC700/Music"
set SMB2UGFXLoc="../../SMB2U/Graphics"
set SMB2UMusicLoc="../../SMB2U/SPC700/Music"
set SMB3BGGFXLoc="../../SMB3/Graphics/Layer2"
set SMB3GFXLoc="../../SMB3/Graphics"
set SMB3LMusicLoc="../../SMB3/SPC700/Music/Levels"
set SMB3OMusicLoc="../../SMB3/SPC700/Music/Overworld"
set ROMBit=$0002
goto :BeginExtract

:SMASJ1
set SMASGFXLoc="../Graphics"
set MainBrrLoc="../SPC700/Samples/Main"
set RCBrrLoc="../SPC700/Samples/RandomChatter"
set SMASMusicLoc="../SPC700/Music"
set SMB1GFXLoc="../../SMB1/Graphics"
set SMB1MusicLoc="../../SMB1/SPC700/Music"
set SMB2UGFXLoc="../../SMB2U/Graphics"
set SMB2UMusicLoc="../../SMB2U/SPC700/Music"
set SMB3BGGFXLoc="../../SMB3/Graphics/Layer2"
set SMB3GFXLoc="../../SMB3/Graphics"
set SMB3LMusicLoc="../../SMB3/SPC700/Music/Levels"
set SMB3OMusicLoc="../../SMB3/SPC700/Music/Overworld"
set ROMBit=$0004
goto :BeginExtract

:SMASJ2
set SMASGFXLoc="../Graphics"
set MainBrrLoc="../SPC700/Samples/Main"
set RCBrrLoc="../SPC700/Samples/RandomChatter"
set SMASMusicLoc="../SPC700/Music"
set SMB1GFXLoc="../../SMB1/Graphics"
set SMB1MusicLoc="../../SMB1/SPC700/Music"
set SMB2UGFXLoc="../../SMB2U/Graphics"
set SMB2UMusicLoc="../../SMB2U/SPC700/Music"
set SMB3BGGFXLoc="../../SMB3/Graphics/Layer2"
set SMB3GFXLoc="../../SMB3/Graphics"
set SMB3LMusicLoc="../../SMB3/SPC700/Music/Levels"
set SMB3OMusicLoc="../../SMB3/SPC700/Music/Overworld"
set ROMBit=$0008
goto :BeginExtract

:SMASWU
set SMASGFXLoc="../Graphics"
set MainBrrLoc="../SPC700/Samples/Main"
set RCBrrLoc="../SPC700/Samples/RandomChatter"
set SMASMusicLoc="../SPC700/Music"
set SMB1GFXLoc="../../SMB1/Graphics"
set SMB1MusicLoc="../../SMB1/SPC700/Music"
set SMB2UGFXLoc="../../SMB2U/Graphics"
set SMB2UMusicLoc="../../SMB2U/SPC700/Music"
set SMB3BGGFXLoc="../../SMB3/Graphics/Layer2"
set SMB3GFXLoc="../../SMB3/Graphics"
set SMB3LMusicLoc="../../SMB3/SPC700/Music/Levels"
set SMB3OMusicLoc="../../SMB3/SPC700/Music/Overworld"
set SMWCGFXLoc="../../SMW/GFX/SMW_U"
set SMWUGFXLoc="../../SMW/GFX"
set SMWLMusicLoc="../../SMW/SPC700/Music/Levels"
set SMWOMusicLoc="../../SMW/SPC700/Music/Overworld"
set SMWCMusicLoc="../../SMW/SPC700/Music/Credits"
set SMWBrrLoc="../../SMW/SPC700/Samples"
set ROMBit=$0010
goto :BeginExtract

:SMASWE
set SMASGFXLoc="../Graphics"
set MainBrrLoc="../SPC700/Samples/Main"
set RCBrrLoc="../SPC700/Samples/RandomChatter"
set SMASMusicLoc="../SPC700/Music"
set SMB1GFXLoc="../../SMB1/Graphics"
set SMB1MusicLoc="../../SMB1/SPC700/Music"
set SMB2UGFXLoc="../../SMB2U/Graphics"
set SMB2UMusicLoc="../../SMB2U/SPC700/Music"
set SMB3BGGFXLoc="../../SMB3/Graphics/Layer2"
set SMB3GFXLoc="../../SMB3/Graphics"
set SMB3LMusicLoc="../../SMB3/SPC700/Music/Levels"
set SMB3OMusicLoc="../../SMB3/SPC700/Music/Overworld"
set SMWCGFXLoc="../../SMW/GFX/SMW_E2"
set SMWUGFXLoc="../../SMW/GFX"
set SMWLMusicLoc="../../SMW/SPC700/Music/Levels"
set SMWOMusicLoc="../../SMW/SPC700/Music/Overworld"
set SMWCMusicLoc="../../SMW/SPC700/Music/Credits"
set SMWBrrLoc="../../SMW/SPC700/Samples"
set ROMBit=$0020
goto :BeginExtract

:BeginExtract
set i=0
set PointerSet=0

echo Generating temporary ROM
asar --fix-checksum=off --no-title-check --define ROMVer="%ROMBit%" "AssetPointersAndFiles.asm" TEMP.sfc

CALL :GetLoopIndex
set MaxFileTypes=%Length%
set PointerSet=6

:GetNewLoopIndex
CALL :GetLoopIndex

:ExtractLoop
if %i% equ %Length% goto :NewFileType

CALL :GetGFXFileName
CALL :ExtractFile
set /a i = %i%+1
if exist TEMP1.asm del TEMP1.asm
if exist TEMP2.asm del TEMP2.asm
if exist TEMP3.txt del TEMP3.txt
goto :ExtractLoop

:NewFileType
echo Moving extracted files to appropriate locations
if %PointerSet% equ 6 goto :MoveSMASGFX
if %PointerSet% equ 12 goto :MoveSMASMusic
if %PointerSet% equ 18 goto :MoveMainBRR
if %PointerSet% equ 24 goto :MoveRCBRR
if %PointerSet% equ 30 goto :MoveSMB1GFX
if %PointerSet% equ 36 goto :MoveSMB1Music
if %PointerSet% equ 42 goto :MoveSMB2UGFX
if %PointerSet% equ 48 goto :MoveSMB2UMusic
if %PointerSet% equ 54 goto :MoveSMB3BGGFX
if %PointerSet% equ 60 goto :MoveSMB3GFX
if %PointerSet% equ 66 goto :MoveSMB3LMusic
if %PointerSet% equ 72 goto :MoveSMB3OMusic
if %PointerSet% equ 78 goto :MoveSMWCGFX
if %PointerSet% equ 84 goto :MoveSMWUGFX
if %PointerSet% equ 90 goto :MoveSMWLMusic
if %PointerSet% equ 96 goto :MoveSMWOMusic
if %PointerSet% equ 102 goto :MoveSMWCMusic
if %PointerSet% equ 108 goto :MoveSMWBRR
goto :MoveNothing

:MoveSMASGFX
move "*.bin" %SMASGFXLoc%
goto :MoveNothing

:MoveSMASMusic
move "*.bin" %SMASMusicLoc%
goto :MoveNothing

:MoveMainBRR
move "*.brr" %MainBrrLoc%
goto :MoveNothing

:MoveRCBRR
move "*.brr" %RCBrrLoc%
goto :MoveNothing

:MoveSMB1GFX
CALL :GenHackSMB1Files
move "*.bin" %SMB1GFXLoc%
goto :MoveNothing

:MoveSMB1Music
move "*.bin" %SMB1MusicLoc%
goto :MoveNothing

:MoveSMB2UGFX
move "*.bin" %SMB2UGFXLoc%
goto :MoveNothing

:MoveSMB2UMusic
move "*.bin" %SMB2UMusicLoc%
goto :MoveNothing

:MoveSMB3BGGFX
CALL :GenHackSMB3Files
move "*.bin" %SMB3BGGFXLoc%
goto :MoveNothing

:MoveSMB3GFX
CALL :GenHackSMB3Files
move "*.bin" %SMB3GFXLoc%
goto :MoveNothing

:MoveSMB3LMusic
move "*.bin" %SMB3LMusicLoc%
goto :MoveNothing

:MoveSMB3OMusic
move "*.bin" %SMB3OMusicLoc%
goto :MoveNothing

:MoveSMWCGFX
if "%Input1%" equ "5" goto :LZ1
move "*.lz2" %SMWCGFXLoc%
goto :MoveNothing

:LZ1
move "*.lz1" %SMWCGFXLoc%
goto :MoveNothing

:MoveSMWUGFX
move "*.bin" %SMWUGFXLoc%
goto :MoveNothing

:MoveSMWLMusic
move "*.bin" %SMWLMusicLoc%
goto :MoveNothing

:MoveSMWOMusic
move "*.bin" %SMWOMusicLoc%
goto :MoveNothing

:MoveSMWCMusic
move "*.bin" %SMWCMusicLoc%
goto :MoveNothing

:MoveSMWBRR
move "*.brr" %SMWBrrLoc%
goto :MoveNothing

:MoveNothing
set i=0
set /a PointerSet = %PointerSet%+6
if %PointerSet% neq %MaxFileTypes% goto :GetNewLoopIndex
if exist TEMP.sfc del TEMP.sfc

echo Done^^!
goto :Start

EXIT /B %ERRORLEVEL% 

:ExtractFile
echo:%MemMap% >> TEMP1.asm
echo:org $008000 >> TEMP1.asm
echo:check bankcross off >> TEMP1.asm
echo:^^!OffsetStart #= snestopc(readfile3("TEMP.sfc", snestopc(readfile3("TEMP.sfc", snestopc($008000+%PointerSet%))+$00+(%i%*$0C)))) >> TEMP1.asm
echo:^^!OffsetEnd #= snestopc(readfile3("TEMP.sfc", snestopc(readfile3("TEMP.sfc", snestopc($008000+%PointerSet%))+$03+(%i%*$0C)))) >> TEMP1.asm
echo:incbin %ROMName%:(^^!OffsetStart)-(^^!OffsetEnd) >> TEMP1.asm

echo Extracting %FileName%
asar --fix-checksum=off --no-title-check "TEMP1.asm" %FileName%
EXIT /B 0

:GetGFXFileName
echo:%MemMap% >> TEMP2.asm
echo:org $008000 >> TEMP2.asm
echo:^^!FileNameStart #= snestopc(readfile3("TEMP.sfc", snestopc(readfile3("TEMP.sfc", snestopc($008000+%PointerSet%))+$06+(%i%*$0C)))) >> TEMP2.asm
echo:^^!FileNameEnd #= snestopc(readfile3("TEMP.sfc", snestopc(readfile3("TEMP.sfc", snestopc($008000+%PointerSet%))+$09+(%i%*$0C)))) >> TEMP2.asm
echo:incbin TEMP.sfc:(^^!FileNameStart)-(^^!FileNameEnd) >> TEMP2.asm
asar --fix-checksum=off --no-title-check "TEMP2.asm" TEMP3.txt

for /f "delims=" %%x in (TEMP3.txt) do set FileName=%%x

EXIT /B 0

:GetLoopIndex
echo:%MemMap% >> TEMP4.asm
echo:org $008000 >> TEMP4.asm
echo:^^!OnesDigit = 0 >> TEMP4.asm
echo:^^!TensDigit = 0 >> TEMP4.asm
echo:^^!HundredsDigit = 0 >> TEMP4.asm
echo:^^!ThousandsDigit = 0 >> TEMP4.asm
echo:^^!TensDigitSet = 0 >> TEMP4.asm
echo:^^!HundredsDigitSet = 0 >> TEMP4.asm
echo:^^!ThousandsDigitSet = 0 >> TEMP4.asm
echo:^^!Offset #= readfile3("TEMP.sfc", snestopc($008000+%PointerSet%+$03)) >> TEMP4.asm
echo:while ^^!Offset ^> 0 >> TEMP4.asm
::echo:print hex(^^!Offset) >> TEMP4.asm
echo:^^!OnesDigit #= ^^!OnesDigit+1 >> TEMP4.asm
echo:if ^^!OnesDigit == 10 >> TEMP4.asm
echo:^^!OnesDigit #= 0 >> TEMP4.asm
echo:^^!TensDigit #= ^^!TensDigit+1 >> TEMP4.asm
echo:^^!TensDigitSet #= 1 >> TEMP4.asm
echo:endif >> TEMP4.asm
echo:if ^^!TensDigit == 10 >> TEMP4.asm
echo:^^!TensDigit #= 0 >> TEMP4.asm
echo:^^!HundredsDigit #= ^^!HundredsDigit+1 >> TEMP4.asm
echo:^^!HundredsDigitSet #= 1 >> TEMP4.asm
echo:endif >> TEMP4.asm
echo:if ^^!HundredsDigit == 10 >> TEMP4.asm
echo:^^!HundredsDigit #= 0 >> TEMP4.asm
echo:^^!ThousandsDigit #= ^^!ThousandsDigit+1 >> TEMP4.asm
echo:^^!ThousandsDigitSet #= 1 >> TEMP4.asm
echo:endif >> TEMP4.asm
echo:^^!Offset #= ^^!Offset-1 >> TEMP4.asm
echo:endif >> TEMP4.asm
echo:if ^^!ThousandsDigitSet == 1 >> TEMP4.asm
echo:db ^^!ThousandsDigit+$30 >> TEMP4.asm
echo:endif >> TEMP4.asm
echo:if ^^!HundredsDigitSet == 1 >> TEMP4.asm
echo:db ^^!HundredsDigit+$30 >> TEMP4.asm
echo:endif >> TEMP4.asm
echo:if ^^!TensDigitSet == 1 >> TEMP4.asm
echo:db ^^!TensDigit+$30 >> TEMP4.asm
echo:endif >> TEMP4.asm
echo:db ^^!OnesDigit+$30 >> TEMP4.asm
asar --fix-checksum=off --no-title-check "TEMP4.asm" TEMP5.txt

for /f "delims=" %%x in (TEMP5.txt) do set Length=%%x

if exist TEMP4.asm del TEMP4.asm
if exist TEMP5.txt del TEMP5.txt

EXIT /B 0

:GenHackSMB1Files
if not exist "GFX_FG_SMB1_GlobalTiles_USA.bin" goto :NoSMB1HackFile
echo: Applying patch for GFX_FG_SMB1_GlobalTiles_USA.bin
echo:%MemMap% >> TEMP1.asm
echo:org $009FC0 >> TEMP1.asm
echo:db $00,$08,$08,$36,$3E,$41,$1C,$22,$1C,$22,$36,$49,$22,$55,$00,$22 >> TEMP1.asm
echo:db $08,$08,$36,$36,$41,$41,$22,$22,$22,$22,$49,$49,$55,$55,$22,$22 >> TEMP1.asm
asar --fix-checksum=off --no-title-check "TEMP1.asm" "GFX_FG_SMB1_GlobalTiles_USA.bin"
if exist TEMP1.asm del TEMP1.asm
:NoSMB1HackFile

EXIT /B 0

:GenHackSMB3Files
if not exist "GFX_TitleScreen_USA.bin" goto :NoSMB3HackFile1
echo: Applying patch for GFX_TitleScreen_USA.bin
echo:%MemMap% >> TEMP1.asm
echo:org $008300 >> TEMP1.asm
echo:db $00,$00,$00,$00,$00,$7E,$3C,$42,$00,$7E,$00,$00,$00,$00,$00,$00 >> TEMP1.asm
echo:org $008500 >> TEMP1.asm
echo:db $00,$F8,$78,$84,$6C,$92,$66,$99,$66,$99,$66,$99,$7C,$82,$00,$FC >> TEMP1.asm
echo:org $008520 >> TEMP1.asm
echo:db $00,$E7,$66,$99,$66,$99,$66,$99,$7E,$81,$66,$99,$66,$99,$00,$E7 >> TEMP1.asm
echo:org $008CA0 >> TEMP1.asm
echo:db $00,$FF,$66,$99,$66,$99,$66,$99,$66,$99,$66,$99,$3C,$42,$00,$3C >> TEMP1.asm
echo:org $008F40 >> TEMP1.asm
echo:db $00,$7E,$3C,$42,$18,$66,$18,$24,$18,$24,$18,$64,$38,$44,$00,$78 >> TEMP1.asm
asar --fix-checksum=off --no-title-check "TEMP1.asm" "GFX_TitleScreen_USA.bin"
if exist TEMP1.asm del TEMP1.asm
:NoSMB3HackFile1

if not exist "GFX_BG_ToadHouse_USA.bin" goto :NoSMB3HackFile2
echo: Applying patch for GFX_BG_ToadHouse_USA.bin
echo:%MemMap% >> TEMP1.asm
echo:org $008420 >> TEMP1.asm
echo:db $00,$64,$64,$9A,$64,$9A,$64,$9A,$7E,$81,$04,$7A,$04,$0A,$00,$04 >> TEMP1.asm
echo:org $008440 >> TEMP1.asm
echo:db $00,$7C,$7C,$82,$60,$9C,$7C,$82,$06,$79,$06,$79,$7C,$82,$00,$7C >> TEMP1.asm
echo:org $008460 >> TEMP1.asm
echo:db $00,$3C,$3C,$42,$60,$9C,$7C,$82,$66,$99,$66,$99,$3C,$42,$00,$3C >> TEMP1.asm
echo:org $008480 >> TEMP1.asm
echo:db $00,$7E,$7E,$81,$06,$79,$0C,$12,$18,$24,$30,$48,$60,$90,$00,$60 >> TEMP1.asm
echo:org $0084A0 >> TEMP1.asm
echo:db $00,$73,$73,$8C,$DB,$24,$DB,$24,$DB,$24,$DB,$24,$73,$8C,$00,$73 >> TEMP1.asm
echo:org $0084C0 >> TEMP1.asm
echo:db $00,$3C,$3C,$42,$66,$99,$66,$99,$3E,$41,$06,$39,$3C,$42,$00,$3C >> TEMP1.asm
echo:org $0084E0 >> TEMP1.asm
echo:db $00,$FF,$7E,$81,$60,$9E,$7C,$82,$60,$9C,$60,$90,$60,$90,$00,$F0 >> TEMP1.asm
echo:org $008500 >> TEMP1.asm
echo:db $00,$7E,$3C,$42,$18,$66,$18,$24,$18,$24,$18,$66,$3C,$42,$00,$7E >> TEMP1.asm
echo:org $008520 >> TEMP1.asm
echo:db $00,$EB,$6A,$95,$6A,$95,$6A,$95,$6A,$95,$6A,$95,$3E,$41,$00,$3F >> TEMP1.asm
echo:org $008540 >> TEMP1.asm
echo:db $00,$3C,$3C,$42,$66,$99,$66,$99,$66,$99,$66,$99,$3C,$42,$00,$3C >> TEMP1.asm
echo:org $008560 >> TEMP1.asm
echo:db $00,$CC,$CC,$32,$6C,$92,$6C,$92,$CC,$32,$EC,$13,$6F,$90,$00,$EF >> TEMP1.asm
echo:org $008580 >> TEMP1.asm
echo:db $00,$3C,$3C,$42,$66,$99,$60,$9F,$60,$9F,$66,$99,$3C,$42,$00,$3C >> TEMP1.asm
echo:org $0085A0 >> TEMP1.asm
echo:db $00,$E7,$62,$95,$62,$95,$72,$8D,$5A,$A5,$4E,$B1,$46,$A9,$00,$E7 >> TEMP1.asm
echo:org $0085C0 >> TEMP1.asm
echo:db $00,$F8,$78,$84,$6C,$92,$6C,$92,$6C,$92,$6C,$92,$78,$84,$00,$F8 >> TEMP1.asm
echo:org $0085E0 >> TEMP1.asm
echo:db $00,$3C,$3C,$42,$70,$8E,$3C,$42,$06,$79,$66,$99,$3C,$42,$00,$3C >> TEMP1.asm
asar --fix-checksum=off --no-title-check "TEMP1.asm" "GFX_BG_ToadHouse_USA.bin"
if exist TEMP1.asm del TEMP1.asm
:NoSMB3HackFile2

EXIT /B 0
