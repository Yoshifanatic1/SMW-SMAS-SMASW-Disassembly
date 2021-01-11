@echo off

set PATH="../Global"
set Input1=
set asarVer=asar
set GAMDID="SMW"
set ROMVer=
set ROMExt=.sfc
set HackCheck=""
set HackName=""

setlocal EnableDelayedExpansion

echo Enter the ROM version you want to assemble.
echo Valid options: "SMW_U" "SMW_J" "SMW_E1" "SMW_E2" "SMW_ARCADE"
echo For custom ROM versions, use "HACK_<HackName>, where <HackName> is the rest of the custom ROM Map file's name before the extension."

:Input
set /p Input1="%Input1%"
set HackCheck=%Input1:~0,5%
if "%Input1%" equ "" goto :Exit
if "%HackCheck%" equ "HACK_" goto :Hack
if "%Input1%" equ "SMW_U" goto :USA
if "%Input1%" equ "SMW_J" goto :Japan
if "%Input1%" equ "SMW_E1" goto :PAL1
if "%Input1%" equ "SMW_E2" goto :PAL2
if "%Input1%" equ "SMW_ARCADE" goto :Arcade

echo. "%Input1%" is not a valid ROM version.
set Input1=
goto :Input

:Hack
set ROMNAME=%Input1:~5,100%
set ROMVer=(Hack)
goto :Assemble

:USA
set ROMVer=(U)
set ROMNAME=Super Mario World
goto :Assemble

:Japan
set ROMVer=(J)
set ROMNAME=Super Mario World
goto :Assemble

:PAL1
set ROMVer=(E)
set ROMNAME=Super Mario World
goto :Assemble

:PAL2
set ROMVer=(E) (Rev.1)
set ROMNAME=Super Mario World
goto :Assemble

:Arcade
set ROMVer=(J) (Arcade)
set ROMNAME=Super Mario World

:Assemble

set output="%ROMNAME% %ROMVer%%ROMExt%"

if exist %output% del %output%
echo Assembling %ROMNAME% %ROMVer%%ROMExt% ... this may take a minute.
echo.

%asarVer% --fix-checksum=on --define GameID="%GAMDID%" --define ROMID="%Input1%" --define FileType=0 ..\Global\AssembleFile.asm %output%

echo Assembling SPC700 engine...
%asarVer% --no-title-check --define GameID="%GAMDID%" --define ROMID="%Input1%" --define FileType=4 --define PathToFile="SPC700/Engine.asm" ..\Global\AssembleFile.asm SPC700\Engine.bin

echo Assembling SPC700 samples...
%asarVer% --no-title-check --define GameID="%GAMDID%" --define ROMID="%Input1%" --define FileType=4 --define PathToFile="SPC700/samples.asm" ..\Global\AssembleFile.asm SPC700\samples.bin

echo Assembling SPC700 overworld music bank...
%asarVer% --no-title-check --define GameID="%GAMDID%" --define ROMID="%Input1%" --define FileType=4 --define PathToFile="SPC700/overworld_music.asm" ..\Global\AssembleFile.asm SPC700\overworld_music.bin

echo Assembling SPC700 levels music bank...
%asarVer% --no-title-check --define GameID="%GAMDID%" --define ROMID="%Input1%" --define FileType=4 --define PathToFile="SPC700/level_music.asm" ..\Global\AssembleFile.asm SPC700\level_music.bin

echo Assembling SPC700 credits music bank...
%asarVer% --no-title-check --define GameID="%GAMDID%" --define ROMID="%Input1%" --define FileType=4 --define PathToFile="SPC700/credits_music.asm" ..\Global\AssembleFile.asm SPC700\credits_music.bin

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

::"Lunar Magic.exe" -ImportAllGraphics "%output%"
::"Lunar Magic.exe" -ImportLevel "%output%" "%GAMDID%\levels\105.mwl"

echo Cleaning up...
if exist ..\%GAMDID%\SPC700\engine.bin del ..\%GAMDID%\SPC700\engine.bin
if exist ..\%GAMDID%\SPC700\samples.bin del ..\%GAMDID%\SPC700\samples.bin
if exist ..\%GAMDID%\SPC700\overworld_music.bin del ..\%GAMDID%\SPC700\overworld_music.bin
if exist ..\%GAMDID%\SPC700\level_music.bin del ..\%GAMDID%\SPC700\level_music.bin
if exist ..\%GAMDID%\SPC700\credits_music.bin del ..\%GAMDID%\SPC700\credits_music.bin

echo.
echo Done^^!
echo.
echo Press Enter to re-assemble the chosen ROM.
goto :Input

:Exit
exit
