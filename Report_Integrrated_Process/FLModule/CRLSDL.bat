@echo off

set file=%1     

Del LSDNLD.bat

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

setlocal EnableDelayedExpansion

mkdir %Date%.h%Houry%
for /f "delims=|" %%i in (%file%) do (
  echo pscp -l aimuser -pw XXXXXXXXX "cadssp:/prod/remote/mis/%Date%.h%Houry%/%%i" "./%Date%.h%Houry%/%%i" >>LSDNLD.bat
)

exit /b