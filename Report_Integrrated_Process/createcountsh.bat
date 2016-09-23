
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

if %Hour% equ 0 (
for /f %%i in ('CALL yesterday') do set Date1=%%i
set /a Hour1=24
set /a Hour2=23
set /a Hour3=22
set /a Hour4=21
echo find /prod/remote/mis/!Date1!.h!Hour1! -type f ^| wc -l > ctcmd/ctcmd1.sh
echo find /prod/remote/mis/!Date1!.h!Hour2! -type f ^| wc -l > ctcmd/ctcmd2.sh
echo find /prod/remote/mis/!Date1!.h!Hour3! -type f ^| wc -l > ctcmd/ctcmd3.sh
echo find /prod/remote/mis/!Date1!.h!Hour4! -type f ^| wc -l > ctcmd/ctcmd4.sh
) else if %Hour% equ 01 (
for /f %%i in ('CALL yesterday') do set Date1=%%i
set /a Hour1=0
set /a Hour2=23
set /a Hour3=22
set /a Hour4=21
echo find /prod/remote/mis/%Date%.h0!Hour1! -type f ^| wc -l > ctcmd/ctcmd1.sh
echo find /prod/remote/mis/!Date1!.h!Hour2! -type f ^| wc -l > ctcmd/ctcmd2.sh
echo find /prod/remote/mis/!Date1!.h!Hour3! -type f ^| wc -l > ctcmd/ctcmd3.sh
echo find /prod/remote/mis/!Date1!.h!Hour4! -type f ^| wc -l > ctcmd/ctcmd4.sh
) else if %Hour% equ 02 (
for /f %%i in ('CALL yesterday') do set Date1=%%i
set /a Hour1=1
set /a Hour2=00
set /a Hour3=23
set /a Hour4=22
echo find /prod/remote/mis/%Date%.h0!Hour1! -type f ^| wc -l > ctcmd/ctcmd1.sh
echo find /prod/remote/mis/%Date%.h0!Hour2! -type f ^| wc -l > ctcmd/ctcmd2.sh
echo find /prod/remote/mis/!Date1!.h!Hour3! -type f ^| wc -l > ctcmd/ctcmd3.sh
echo find /prod/remote/mis/!Date1!.h!Hour4! -type f ^| wc -l > ctcmd/ctcmd4.sh
) else if %Hour% equ 03 (
for /f %%i in ('CALL yesterday') do set Date1=%%i
set /a Hour1=2
set /a Hour2=1
set /a Hour3=00
set /a Hour4=23
echo find /prod/remote/mis/%Date%.h0!Hour1! -type f ^| wc -l > ctcmd/ctcmd1.sh
echo find /prod/remote/mis/%Date%.h0!Hour2! -type f ^| wc -l > ctcmd/ctcmd2.sh
echo find /prod/remote/mis/%Date%.h0!Hour3! -type f ^| wc -l > ctcmd/ctcmd3.sh
echo find /prod/remote/mis/!Date1!.h!Hour4! -type f ^| wc -l > ctcmd/ctcmd4.sh
) else if %Hour% equ 04 (
for /f %%i in ('CALL yesterday') do set Date1=%%i
set /a Hour1=3
set /a Hour2=2
set /a Hour3=1
set /a Hour4=00
echo find /prod/remote/mis/%Date%.h0!Hour1! -type f ^| wc -l > ctcmd/ctcmd1.sh
echo find /prod/remote/mis/%Date%.h0!Hour2! -type f ^| wc -l > ctcmd/ctcmd2.sh
echo find /prod/remote/mis/%Date%.h0!Hour3! -type f ^| wc -l > ctcmd/ctcmd3.sh
echo find /prod/remote/mis/%Date%.h0!Hour4! -type f ^| wc -l > ctcmd/ctcmd4.sh
) ELSE (
set /a Hour1= %Hour%-1
set /a Hour2= %Hour%-2
set /a Hour3= %Hour%-3
set /a Hour4= %Hour%-4
	if !Hour1! LSS 10 (
		echo find /prod/remote/mis/%Date%.h0!Hour1! -type f ^| wc -l > ctcmd/ctcmd1.sh
	) ELSE (
		echo find /prod/remote/mis/%Date%.h!Hour1! -type f ^| wc -l > ctcmd/ctcmd1.sh
	)
	if !Hour2! LSS 10 (
		echo find /prod/remote/mis/%Date%.h0!Hour2! -type f ^| wc -l > ctcmd/ctcmd2.sh
	) ELSE (
		echo find /prod/remote/mis/%Date%.h!Hour2! -type f ^| wc -l > ctcmd/ctcmd2.sh
	)
	if !Hour3! LSS 10 (
		echo find /prod/remote/mis/%Date%.h0!Hour3! -type f ^| wc -l > ctcmd/ctcmd3.sh
	) ELSE (
		echo find /prod/remote/mis/%Date%.h!Hour3! -type f ^| wc -l > ctcmd/ctcmd3.sh
	)
	if !Hour4! LSS 10 (
		echo find /prod/remote/mis/%Date%.h0!Hour4! -type f ^| wc -l > ctcmd/ctcmd4.sh
	) ELSE (
		echo find /prod/remote/mis/%Date%.h!Hour4! -type f ^| wc -l > ctcmd/ctcmd4.sh
	)
)