@ECHO OFF

CHOICE /C ED /M "Encode or decode?"

SET PATH="../../../Global"

IF %ERRORLEVEL% == 1 GOTO ENCODE
IF %ERRORLEVEL% == 2 GOTO DECODE

:ENCODE
SET program=brr_encoder
SET intype=wav
SET outtype=brr
GOTO MAIN

:DECODE
SET program=brr_decoder
SET intype=brr
SET outtype=wav
GOTO MAIN

:MAIN
ECHO Sample 00
%program% 00.%intype% 00.%outtype%
ECHO Sample 01
%program% 01.%intype% 01.%outtype%
ECHO Sample 02
%program% 02.%intype% 02.%outtype%
ECHO Sample 03
%program% 03.%intype% 03.%outtype%
ECHO Sample 04
%program% 04.%intype% 04.%outtype%
ECHO Sample 05
%program% 05.%intype% 05.%outtype%
ECHO Sample 06
%program% 06.%intype% 06.%outtype%
ECHO Sample 07
%program% 07.%intype% 07.%outtype%
ECHO Sample 08
%program% 08.%intype% 08.%outtype%
ECHO Sample 09
%program% 09.%intype% 09.%outtype%
ECHO Sample 0A
%program% 0A.%intype% 0A.%outtype%
ECHO Sample 0B
%program% 0B.%intype% 0B.%outtype%
ECHO Sample 0C
%program% 0C.%intype% 0C.%outtype%
ECHO Sample 0D
%program% 0D.%intype% 0D.%outtype%
ECHO Sample 0E
%program% 0E.%intype% 0E.%outtype%
ECHO Sample 0F
%program% 0F.%intype% 0F.%outtype%
ECHO Sample 10
%program% 10.%intype% 10.%outtype%
ECHO Sample 11
%program% 11.%intype% 11.%outtype%
ECHO Sample 12
%program% 12.%intype% 12.%outtype%
ECHO Sample 13
%program% 13.%intype% 13.%outtype%

DEL *.%intype%

PAUSE
