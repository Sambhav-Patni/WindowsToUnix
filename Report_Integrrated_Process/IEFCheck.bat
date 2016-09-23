@echo off
setlocal EnableExtensions EnableDelayedExpansion

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
set Stamp=%Year%%Month%%Day%_%Hour%.log

ECHO -------- Welcome Now we'll Check whether IEF File Miss Occured or not --------- >logs\%Stamp%


for /f "tokens=1-4 delims=: " %%i in ('time /t') do set Hour=%%i

IF %Hour% equ 04 (
:dbSet
for /f "" %%a in ('sqlplus -s sp102532/XXXXXXX@CADSSP.MITCHELL.COM @C:\SAM\Report_Integrrated_Process\ctSql\ctSql2.sql') do set dbcount=%%a
if not defined DBCOUNT goto :dbSet
echo.DBCOUNT SQL is "!DBCOUNT!" >>logs\%Stamp%

CALL createcountsh.bat

for /f "" %%a in ('plink -ssh aimuser@cadssp -pw 2861n2J12232 -t -m C:\SAM\Report_Integrrated_Process\ctCmd\ctcmd1.sh') do set unixcount1=%%a
for /f "" %%a in ('plink -ssh aimuser@cadssp -pw 2861n2J12232 -t -m C:\SAM\Report_Integrrated_Process\ctCmd\ctcmd2.sh') do set unixcount2=%%a
for /f "" %%a in ('plink -ssh aimuser@cadssp -pw 2861n2J12232 -t -m C:\SAM\Report_Integrrated_Process\ctCmd\ctcmd3.sh') do set unixcount3=%%a
for /f "" %%a in ('plink -ssh aimuser@cadssp -pw 2861n2J12232 -t -m C:\SAM\Report_Integrrated_Process\ctCmd\ctcmd4.sh') do set unixcount4=%%a
:uxSet
set /a unixcount=!unixcount1! + !unixcount2! + !unixcount3! + !unixcount4!
if not defined UNIXCOUNT goto :uxSet
echo.UNIXCOUNT is "!UNIXCOUNT!" >>logs\%Stamp%
IF !DBCOUNT! NEQ !UNIXCOUNT! (
cd FLModule
call FLMAIN
mail
exit /b
)
success_mail
exit /b

) ELSE (
:dbSet1
for /f "" %%a in ('sqlplus -s sp102532/XXXXXXX@CADSSP.MITCHELL.COM @C:\SAM\Report_Integrrated_Process\ctSql\ctSql1.sql') do set dbcount=%%a
if not defined DBCOUNT goto :dbSet1
echo.DBCOUNT SQL is "!DBCOUNT!"  >>logs\%Stamp%

CALL createcountsh.bat

:uxSet1
for /f "" %%a in ('plink -ssh aimuser@cadssp -pw 2861n2J12232 -t -m C:\SAM\Report_Integrrated_Process\ctCmd\ctcmd1.sh') do set unixcount=%%a
if not defined UNIXCOUNT goto :uxSet1
echo.UNIXCOUNT is "!UNIXCOUNT!"  >>logs\%Stamp%
IF !DBCOUNT! NEQ !UNIXCOUNT! (
cd FLModule
call FLMAIN
mail
exit /b
)
success_mail
exit /b
)