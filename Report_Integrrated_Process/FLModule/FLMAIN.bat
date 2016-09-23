call FLCMDCREATE
sqlplus -s sp102532/XXXXXXX@CADSSP.MITCHELL.COM @"FLSQL.sql"
echo -----END----- >> LSDB.txt
plink -ssh aimuser@cadssp -pw XXXXXXXX -t -m FLCMD.sh > LSUNIX.txt
findstr /V /G:LSDB.txt LSUNIX.txt >LSDIFF.txt

::mail

for /F "tokens=1-4 delims=/ " %%i in ('date /t') do (
set Year=%%l
set Temp=%%i
set Month=%%j
set Day=%%k
)
for /F "tokens=1-4 delims=: " %%i in ('time /t') do (
set Min=%%j
set /a Hour=1%%i-100
)
set Date=%Year%%Month%%Day%
set /a Houry= %Hour%-1
set MDay=%Month%%Day%

if %Houry% LSS 10 (
set Houry=0%Houry%
)
if %Hour% EQU 0 (
set Houry=24
for /f %%i in ('CALL yesterday') do set Date=%%i
)
call CRLSDL LSDIFF.txt

echo Location: /prod/remote/mis/%Date%.h%Houry% >> LSDIFF.txt

LSDNLD

exit /b
