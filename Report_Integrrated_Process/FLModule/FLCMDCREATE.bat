
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
set /a Hourx= %Hour%-1
set MDay=%Month%%Day%

if %Hourx% LSS 10 (
set Hourx=0%Hourx%
)
if %Hour% EQU 0 (
set Hourx=24
for /f %%i in ('CALL yesterday') do set Date=%%i
)
if %Hour% EQU 0 (
set MDay=%Date:~-4%
)
echo ls -1 /prod/remote/mis/%Date%.h%Hourx% > FLCMD.sh

echo SET HEADING OFF FEEDBACK OFF ECHO OFF TRIMSPOOL ON PAGESIZE 0 > FLSQL.sql
echo SPOOL LSDB.txt >> FLSQL.sql
echo select filename from ief_claim where full_filename like '/prod/mis/iinfo/dat/load/%MDay%/%Date%.h%Hourx%%%'; >> FLSQL.sql
echo SPOOL OFF >> FLSQL.sql
echo exit >> FLSQL.sql