@echo off

set PATH="../../Global"
set Input1=
set ROMName=SMW.sfc
set MemMap=lorom

setlocal EnableDelayedExpansion

echo To fully extract all files for supported ROMs, you'll need one of the following ROMs in each group:
echo - SMAS exclusive: SMAS+W (USA)/SMAS+W (PAL)
echo - Japan LZ1 GFX: SMW (Japan)
echo - PAL LZ1 GFX: SMW (PAL Rev. 1)/SMAS+W (PAL)
echo - LZ2 GFX: SMW (USA)/SMW (PAL)/SMW (Arcade)/SMAS+W (USA)
echo - Samples: Any
echo - Music: Any
echo.

:Start
echo Place a headerless SMW ROM named %ROMName% in this folder, then type the number representing what version %ROMName% is.
echo 0 = SMW (USA)
echo 1 = SMW (Japan)
echo 2 = SMW (PAL)
echo 3 = SMW (PAL Rev. 1)
echo 4 = SMW (Arcade)

:Mode
set /p Input1=""
if exist %ROMName% goto :ROMExists

echo You need to place a SMW ROM named %ROMName% in this folder before you can extract any assets^^!
goto :Mode

:ROMExists
if "%Input1%" equ "0" goto :USA
if "%Input1%" equ "1" goto :JAPAN
if "%Input1%" equ "2" goto :PAL1
if "%Input1%" equ "3" goto :PAL2
if "%Input1%" equ "4" goto :ARCADE

echo %Input1% is not a valid mode.
goto :Mode

:USA
set GFXLoc="../GFX/SMW_U"
set LMusicLoc="../SPC700/Music/Levels"
set OMusicLoc="../SPC700/Music/Overworld"
set CMusicLoc="../SPC700/Music/Credits"
set BrrLoc="../SPC700/Samples"
set ROMBit=$0001
goto :BeginExtract

:JAPAN
set GFXLoc="../GFX/SMW_J"
set LMusicLoc="../SPC700/Music/Levels"
set OMusicLoc="../SPC700/Music/Overworld"
set CMusicLoc="../SPC700/Music/Credits"
set BrrLoc="../SPC700/Samples"
set ROMBit=$0002
goto :BeginExtract

:PAL1
set GFXLoc="../GFX/SMW_U"
set LMusicLoc="../SPC700/Music/Levels"
set OMusicLoc="../SPC700/Music/Overworld"
set CMusicLoc="../SPC700/Music/Credits"
set BrrLoc="../SPC700/Samples"
set ROMBit=$0004
goto :BeginExtract

:PAL2
set GFXLoc="../GFX/SMW_E2"
set LMusicLoc="../SPC700/Music/Levels"
set OMusicLoc="../SPC700/Music/Overworld"
set CMusicLoc="../SPC700/Music/Credits"
set BrrLoc="../SPC700/Samples"
set ROMBit=$0008
goto :BeginExtract

:ARCADE
set GFXLoc="../GFX/SMW_U"
set LMusicLoc="../SPC700/Music/Levels"
set OMusicLoc="../SPC700/Music/Overworld"
set CMusicLoc="../SPC700/Music/Credits"
set BrrLoc="../SPC700/Samples"
set ROMBit=$0010
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
if %PointerSet% equ 6 goto :MoveGFX
if %PointerSet% equ 12 goto :MoveLMusic
if %PointerSet% equ 18 goto :MoveOMusic
if %PointerSet% equ 24 goto :MoveCMusic
if %PointerSet% equ 30 goto :MoveBRR
goto :MoveNothing

:MoveGFX
if "%Input1%" equ "1" goto :LZ1
if "%Input1%" equ "3" goto :LZ1
move "*.lz2" %GFXLoc%
goto :MoveNothing

:LZ1
move "*.lz1" %GFXLoc%
goto :MoveNothing

:MoveLMusic
move "*.bin" %LMusicLoc%
goto :MoveNothing

:MoveOMusic
move "*.bin" %OMusicLoc%
goto :MoveNothing

:MoveCMusic
move "*.bin" %CMusicLoc%
goto :MoveNothing

:MoveBRR
move "*.brr" %BrrLoc%
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
