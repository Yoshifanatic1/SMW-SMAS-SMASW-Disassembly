@echo off

set PATH="../Global"
set Input1=
set asarVer=asar
set GAMDID="SMAS"
set ROMVer=
set ROMExt=.sfc
set HackCheck=""
set HackName=""

setlocal EnableDelayedExpansion

echo Enter the ROM version you want to assemble.
echo Valid options: "SMAS_U" "SMAS_E" "SMAS_J1" "SMAS_J2" "SMASW_U" "SMASW_E"
echo For custom ROM versions, use "HACK_<HackName>, where <HackName> is the rest of the custom ROM Map file's name before the extension."

:Input
set /p Input1="%Input1%"
set HackCheck=%Input1:~0,5%
if "%Input1%" equ "" goto :Exit
if "%HackCheck%" equ "HACK_" goto :Hack
if "%Input1%" equ "SMAS_U" goto :USA
if "%Input1%" equ "SMAS_E" goto :PAL
if "%Input1%" equ "SMAS_J1" goto :Japan1
if "%Input1%" equ "SMAS_J2" goto :Japan2
if "%Input1%" equ "SMASW_U" goto :WUSA
if "%Input1%" equ "SMASW_E" goto :WPAL

echo. "%Input1%" is not a valid ROM version.
set Input1=
goto :Input

:Hack
set ROMNAME=%Input1:~5,100%
set ROMVer=(Hack)
goto :Assemble

:USA
set ROMVer=(U)
set ROMNAME=Super Mario All-Stars
goto :Assemble

:PAL
set ROMVer=(E)
set ROMNAME=Super Mario All-Stars
goto :Assemble

:Japan1
set ROMVer=(J)
set ROMNAME=Super Mario Collection
goto :Assemble

:Japan2
set ROMVer=(J) (Rev.1)
set ROMNAME=Super Mario Collection
goto :Assemble

:WUSA
set ROMVer=(U)
set ROMNAME=Super Mario All-Stars + World
goto :Assemble

:WPAL
set ROMVer=(E)
set ROMNAME=Super Mario All-Stars + World

:Assemble

set output="%ROMNAME% %ROMVer%%ROMExt%"

if exist %output% del %output%
echo Assembling %ROMNAME% %ROMVer%%ROMExt% ... this may take a minute.
echo.

%asarVer% --fix-checksum=on --define GameID="%GAMDID%" --define ROMID="%Input1%" --define FileType=0 ..\Global\AssembleFile.asm %output%

echo Assembling SMAS SPC700 engine...
%asarVer% --define GameID="%GAMDID%" --define ROMID="%Input1%" --define FileType=4 --define PathToFile="SPC700/Engine.asm" ..\Global\AssembleFile.asm SPC700\Engine.bin

echo Assembling SMAS SPC700 main samples...
%asarVer% --define GameID="%GAMDID%" --define ROMID="%Input1%" --define FileType=4 --define PathToFile="SPC700/MainSamples.asm" ..\Global\AssembleFile.asm SPC700\MainSamples.bin

echo Assembling SMAS SPC700 random chatter samples...
%asarVer% --define GameID="%GAMDID%" --define ROMID="%Input1%" --define FileType=4 --define PathToFile="SPC700/RandomChatterSamples.asm" ..\Global\AssembleFile.asm SPC700\RandomChatterSamples.bin

echo Assembling SMAS SPC700 music bank...
%asarVer% --define GameID="%GAMDID%" --define ROMID="%Input1%" --define FileType=4 --define PathToFile="SPC700/SMAS_MusicBank.asm" ..\Global\AssembleFile.asm SPC700\SMAS_MusicBank.bin

echo Assembling SMB1/SMBLL SPC700 music bank...
%asarVer% --define GameID="%GAMDID%" --define ROMID="%Input1%" --define FileType=4 --define PathToFile="../SMB1/SPC700/SMB1_MusicBank.asm" ..\Global\AssembleFile.asm ..\SMB1\SPC700\SMB1_MusicBank.bin

echo Assembling SMB2U SPC700 music bank...
%asarVer% --define GameID="%GAMDID%" --define ROMID="%Input1%" --define FileType=4 --define PathToFile="../SMB2U/SPC700/SMB2U_MusicBank.asm" ..\Global\AssembleFile.asm ..\SMB2U\SPC700\SMB2U_MusicBank.bin

echo Assembling SMB3 SPC700 level music bank...
%asarVer% --define GameID="%GAMDID%" --define ROMID="%Input1%" --define FileType=4 --define PathToFile="../SMB3/SPC700/SMB3_Level_MusicBank.asm" ..\Global\AssembleFile.asm ..\SMB3\SPC700\SMB3_Level_MusicBank.bin

echo Assembling SMB3 SPC700 overworld music bank...
%asarVer% --define GameID="%GAMDID%" --define ROMID="%Input1%" --define FileType=4 --define PathToFile="../SMB3/SPC700/SMB3_Overworld_MusicBank.asm" ..\Global\AssembleFile.asm ..\SMB3\SPC700\SMB3_Overworld_MusicBank.bin

if "%Input1%" equ "SMAS_U" goto :NoSMW1
if "%Input1%" equ "SMAS_E" goto :NoSMW1
if "%Input1%" equ "SMAS_J1" goto :NoSMW1
if "%Input1%" equ "SMAS_J2" goto :NoSMW1

echo Assembling SMW SPC700 engine...
%asarVer% --define GameID="%GAMDID%" --define ROMID="%Input1%" --define FileType=4 --define PathToFile="../SMW/SPC700/Engine.asm" ..\Global\AssembleFile.asm ..\SMW\SPC700\Engine.bin

echo Assembling SMW SPC700 samples...
%asarVer% --define GameID="%GAMDID%" --define ROMID="%Input1%" --define FileType=4 --define PathToFile="../SMW/SPC700/samples.asm" ..\Global\AssembleFile.asm ..\SMW\SPC700\samples.bin

echo Assembling SMW SPC700 overworld music bank...
%asarVer% --define GameID="%GAMDID%" --define ROMID="%Input1%" --define FileType=4 --define PathToFile="../SMW/SPC700/overworld_music.asm" ..\Global\AssembleFile.asm ..\SMW\SPC700\overworld_music.bin

echo Assembling SMW SPC700 levels music bank...
%asarVer% --define GameID="%GAMDID%" --define ROMID="%Input1%" --define FileType=4 --define PathToFile="../SMW/SPC700/level_music.asm" ..\Global\AssembleFile.asm ..\SMW\SPC700\level_music.bin

echo Assembling SMW SPC700 credits music bank...
%asarVer% --define GameID="%GAMDID%" --define ROMID="%Input1%" --define FileType=4 --define PathToFile="../SMW/SPC700/credits_music.asm" ..\Global\AssembleFile.asm ..\SMW\SPC700\credits_music.bin

:NoSMW1
echo Assembling ROM...
%asarVer% --define GameID="%GAMDID%" --define ROMID="%Input1%" --define FileType=1 ..\Global\AssembleFile.asm %output%

if exist ..\%GAMDID%\Temp.txt del ..\%GAMDID%\Temp.txt
%asarVer% --define GameID="%GAMDID%" --define ROMID="%Input1%" --define FileType=6 ..\Global\AssembleFile.asm Temp.txt
for /f "delims=" %%x in (Temp.txt) do set Firmware=%%x
if "%Firmware%" equ "NULL" goto :NoFirmware
if exist %Firmware% goto :NoFirmware
if exist ..\Firmware\%Firmware% goto :CopyFirmware
goto :NoFirmware

:CopyFirmware
echo Copied %Firmware% to the disassembly folder
copy ..\Firmware\%Firmware% %Firmware%
:NoFirmware
if exist ..\%GAMDID%\Temp.txt del ..\%GAMDID%\Temp.txt

%asarVer% --define GameID="%GAMDID%" --define ROMID="%Input1%" --define FileType=2 ..\Global\AssembleFile.asm %output%

%asarVer% --fix-checksum=off --define GameID="%GAMDID%" --define ROMID="%Input1%" --define FileType=3 ..\Global\AssembleFile.asm %output%

echo Cleaning up...
if exist ..\%GAMDID%\SPC700\Engine.bin del ..\%GAMDID%\SPC700\Engine.bin
if exist ..\%GAMDID%\SPC700\MainSamples.bin del ..\%GAMDID%\SPC700\MainSamples.bin
if exist ..\%GAMDID%\SPC700\RandomChatterSamples.bin del ..\%GAMDID%\SPC700\RandomChatterSamples.bin
if exist ..\%GAMDID%\SPC700\SMAS_MusicBank.bin del ..\%GAMDID%\SPC700\SMAS_MusicBank.bin
if exist ..\SMB1\SPC700\SMB1_MusicBank.bin del ..\SMB1\SPC700\SMB1_MusicBank.bin
if exist ..\SMB2U\SPC700\SMB2U_MusicBank.bin del ..\SMB2U\SPC700\SMB2U_MusicBank.bin
if exist ..\SMB3\SPC700\SMB3_Level_MusicBank.bin del ..\SMB3\SPC700\SMB3_Level_MusicBank.bin
if exist ..\SMB3\SPC700\SMB3_Overworld_MusicBank.bin del ..\SMB3\SPC700\SMB3_Overworld_MusicBank.bin

if "%Input1%" equ "SMAS_U" goto :NoSMW2
if "%Input1%" equ "SMAS_E" goto :NoSMW2
if "%Input1%" equ "SMAS_J1" goto :NoSMW2
if "%Input1%" equ "SMAS_J2" goto :NoSMW2

if exist ..\SMW\SPC700\engine.bin del ..\SMW\SPC700\engine.bin
if exist ..\SMW\SPC700\samples.bin del ..\SMW\SPC700\samples.bin
if exist ..\SMW\SPC700\overworld_music.bin del ..\SMW\SPC700\overworld_music.bin
if exist ..\SMW\SPC700\level_music.bin del ..\SMW\SPC700\level_music.bin
if exist ..\SMW\SPC700\credits_music.bin del ..\SMW\SPC700\credits_music.bin
:NoSMW2

echo.
echo Done^^!
echo.
echo Press Enter to re-assemble the chosen ROM.
goto :Input

:Exit
exit
