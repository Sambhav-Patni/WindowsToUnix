for /F "tokens=1-4 delims=/ " %%i in ('date /t') do (
set Year=%%l
set Temp=%%i
set Month=%%j
set Day=%%k
)
if "%Month%" =="01" set Month1=January
if "%Month%" =="02" set Month1=February
if "%Month%" =="03" set Month1=March
if "%Month%" =="04" set Month1=April
if "%Month%" =="05" set Month1=May
if "%Month%" =="06" set Month1=June
if "%Month%" =="07" set Month1=July
if "%Month%" =="08" set Month1=August
if "%Month%" =="09" set Month1=September
if "%Month%" =="10" set Month1=October
if "%Month%" =="11" set Month1=November
if "%Month%" =="12" set Month1=December
if "%Day%" =="01" set Day=1
if "%Day%" =="02" set Day=2
if "%Day%" =="03" set Day=3
if "%Day%" =="04" set Day=4
if "%Day%" =="05" set Day=5
if "%Day%" =="06" set Day=6
if "%Day%" =="07" set Day=7
if "%Day%" =="08" set Day=8
if "%Day%" =="09" set Day=9

set Path=\\user01nas\usrtmp\SIP_Reprocessing\%Year%\%Month1%\%Day%
md %Path%