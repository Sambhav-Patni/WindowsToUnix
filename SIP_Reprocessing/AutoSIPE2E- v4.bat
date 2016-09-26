
ECHO Welcome to SIP Reprocessing script, Pls. check as it's a BETA Version.
ECHO off

PAUSE
putty -ssh sp10228@papp01lxv -pw XXXXXXXX -t -m c:\sidd\SIP_reprocessing\Unix2Windows\sh_scripts\fas.sh
ECHO Importing "timelogs"
pscp -sftp -pw XXXXXXXX sp10228@papp01lxv:"/home/sp10228/fasdir/timelogs" "c:\sidd\SIP_reprocessing\Unix2Windows\log\timelogs"
ECHO (B) Generate list of failed HZ estimate MCF files uploaded from the list of reported failed MCFs (timelogs)
ECHO TO Move forward press Enter
PAUSE

putty -ssh sp10228@papp01lxv -pw XXXXXXXX -t -m c:\sidd\SIP_reprocessing\Unix2Windows\sh_scripts\HZ_BS_MCF_list_CS.sh
pscp -l sp10228 -pw XXXXXXXX "papp01lxv:/home/sp10228/fasdir/HZ_BodyShop_MCF_list.txt" "c:\sidd\SIP_reprocessing\Unix2Windows\log\HZ_BodyShop_MCF_list.txt"
pscp -l sp10228 -pw XXXXXXXX "papp01lxv:/home/sp10228/fasdir/CARR_STD_SUCCESS.sql" "c:\sidd\SIP_reprocessing\Unix2Windows\log\CARR_STD_SUCCESS.sql"
ECHO Check whether SQL Result correct or not.
::
PAUSE
for /f "" %%a in ('sqlplus -s at101233/XXXXXXXX@BILLP.MITCHELL.COM @c:\sidd\SIP_reprocessing\Unix2Windows\log\CARR_STD_SUCCESS.sql') do set rowcount=%%a
ECHO Rowcount SQL is "%ROWCOUNT%"
set "str=#"
set file="c:\sidd\SIP_reprocessing\Unix2Windows\log\HZ_BodyShop_MCF_list.txt"
set cnt=0
for /f ^"eol^=^

delims^=^" %%b in ('"findstr /i "/c:%str%" %file%"') do set "ln=%%b"&call :countStr

goto :loopExit
::exit /b

:countStr
  setlocal enableDelayedExpansion
  :loop
  set "ln2=!ln:*%str%=!"
  if "!ln2!" neq "!ln!" (
    set "ln=!ln2!"
    set /a "cnt+=1"
    goto :loop
  )
  endlocal & set cnt=%cnt%
::exit /b
echo Count of HZ BodyShop MCF estimates = %cnt% 
:loopExit
::set t1=61
if %cnt% NEQ %ROWCOUNT% exit/b
::Echo Count Not equal: probably Unprocessed Hertz Estimates.
echo SUCCESS
pause

ECHO (C) Remove already processed HZ estimate MCF files from NAS path \\prod03nas\ECDsharePROD\...
ECHO TO Move forward press Enter
PAUSE

putty -ssh sp10228@papp01lxv -pw XXXXXXXX -t -m c:\sidd\SIP_reprocessing\Unix2Windows\sh_scripts\delWinFailedHZEstFileListcmd.sh
pscp -sftp -pw XXXXXXXX sp10228@papp01lxv:"/home/sp10228/fasdir/delFailedHZEstfile.bat" "c:\sidd\SIP_Reprocessing\Unix2Windows\sip_batch\delFailedHZEstfile.bat"

ECHO TO Move forward press Enter (delFailedHZEstfile.bat)
PAUSE
CALL c:\sidd\SIP_reprocessing\Unix2Windows\sip_batch\delFailedHZEstfile.bat
ECHO (D) Remove already processed HZ estimate MCFs uploaded from the list of reported failed MCFs (timelogs)
ECHO TO Move forward press Enter
PAUSE
putty -ssh sp10228@papp01lxv -pw XXXXXXXX -t -m c:\sidd\SIP_reprocessing\Unix2Windows\sh_scripts\removeHZ_MCF.sh
pscp -l sp10228 -pw XXXXXXXX "papp01lxv:/home/sp10228/fasdir/timelogs_HZ_removed" "c:\sidd\SIP_Reprocessing\Unix2Windows\log\timelogs_HZ_removed"

ECHO (E) Move the failed estimate MCFs from filecapture_outgoing to drop folder for further reprocessing.
ECHO TO Move forward press Enter
PAUSE
putty -ssh sp10228@papp01lxv -pw XXXXXXXX -t -m c:\sidd\SIP_reprocessing\Unix2Windows\sh_scripts\moveWinFailedEstFileListcmd_httpiosubmit_drop.sh
pscp -sftp -pw XXXXXXXX sp10228@papp01lxv:"/home/sp10228/fasdir/moveFailedEstProd3Nas.bat" "c:\sidd\SIP_Reprocessing\Unix2Windows\sip_batch\moveFailedEstProd3Nas.bat"
ECHO TO Move forward press Enter (moveFailedEstProd3Nas.bat)
PAUSE
CALL c:\sidd\SIP_reprocessing\Unix2Windows\sip_batch\moveFailedEstProd3Nas.bat

ECHO Script PART1 finished (Press enter) waiting 2 hour
PAUSE
timeout 7200
ECHO Begining PART2...FAS/MOVE_FAILED

putty -ssh sp10228@papp01lxv -pw XXXXXXXX -t -m c:\sidd\SIP_reprocessing\Unix2Windows\sh_scripts\fas.sh
ECHO Importing "timelogs"
pscp -sftp -pw XXXXXXXX sp10228@papp01lxv:"/home/sp10228/fasdir/timelogs" "c:\sidd\SIP_reprocessing\Unix2Windows\log\timelogs"

ECHO (B) Generate list of failed HZ estimate MCF files uploaded from the list of reported failed MCFs (timelogs)
ECHO TO Move forward press Enter
PAUSE

putty -ssh sp10228@papp01lxv -pw XXXXXXXX -t -m c:\sidd\SIP_reprocessing\Unix2Windows\sh_scripts\HZ_BS_MCF_list_CS.sh
pscp -l sp10228 -pw XXXXXXXX "papp01lxv:/home/sp10228/fasdir/HZ_BodyShop_MCF_list.txt" "c:\sidd\SIP_reprocessing\Unix2Windows\log\HZ_BodyShop_MCF_list.txt"
pscp -l sp10228 -pw XXXXXXXX "papp01lxv:/home/sp10228/fasdir/CARR_STD_SUCCESS.sql" "c:\sidd\SIP_reprocessing\Unix2Windows\log\CARR_STD_SUCCESS.sql"
::ECHO Check whether SQL Result correct or not.
::
::PAUSE
::for /f "" %%a in ('sqlplus -s sp10228/Gloat#7@BILLP.MITCHELL.COM @c:\sidd\SIP_reprocessing\Unix2Windows\log\CARR_STD_SUCCESS.sql') do set rowcount=%%a
::echo.rowcount SQL is "%ROWCOUNT%"
::

::set "str=+"
::set file="c:\sidd\SIP_reprocessing\Unix2Windows\log\HZ_BodyShop_MCF_list.txt"
::set cnt=0
::for /f ^"eol^=^

::delims^=^" %%b in ('"findstr /i "/c:%str%" %file%"') do set "ln=%%b"&call :countStr

::echo %%b
::echo %str%
::echo %file%
::exit /b

:::countStr
::  setlocal enableDelayedExpansion
::  :loop
::  set "ln2=!ln:*%str%=!"
::  if "!ln2!" neq "!ln!" (
::    set "ln=!ln2!"
::    set /a "cnt+=1"
::    goto :loop
::  )
::  endlocal & set cnt=%cnt%
::exit /b
::echo Count of HZ BodyShop MCF estimates = %cnt% 
::set t1=61

::set /a varCheck = %ROWCOUNT%
::if %varCheck% == %ROWCOUNT% (echo Continue to Step "C") else (goto :NoHZ)

::if %cnt% NEQ %ROWCOUNT% exit /b
::echo SUCCESS
::pause

::ECHO (C) Remove already processed HZ estimate MCF files from NAS path \\prod03nas\ECDsharePROD\...
::ECHO TO Move forward press Enter
::PAUSE
::putty -ssh sp10228@papp01lxv -pw XXXXXXXX -t -m c:\sidd\SIP_reprocessing\Unix2Windows\sh_scripts\delWinFailedHZEstFileListcmd.sh
::pscp -sftp -pw XXXXXXXX sp10228@papp01lxv:"/home/sp10228/fasdir/moveWinfailedHZEstfileList.bat" "c:\sidd\SIP_Reprocessing\Unix2Windows\sip_batch\moveWinfailedHZEstfileList.bat"

::ECHO TO Move forward press Enter (moveWinfailedHZEstfileList.bat)
::PAUSE
::CALL c:\sidd\SIP_reprocessing\Unix2Windows\sip_batch\moveWinfailedHZEstfileList.bat
:NoHz
ECHO (D) Remove already processed HZ estimate MCFs uploaded from the list of reported failed MCFs (timelogs)
ECHO TO Move forward press Enter
PAUSE
putty -ssh sp10228@papp01lxv -pw XXXXXXXX -t -m c:\sidd\SIP_reprocessing\Unix2Windows\sh_scripts\removeHZ_MCF.sh
pscp -l sp10228 -pw XXXXXXXX "papp01lxv:/home/sp10228/fasdir/timelogs_HZ_removed" "c:\sidd\SIP_Reprocessing\Unix2Windows\log\timelogs_HZ_removed"
::
ECHO (E2) Move the failed estimate MCFs from filecapture_outgoing to User1Nas today's Date folder for Determination of Processing Problem.
ECHO TO Move forward press Enter
PAUSE
putty -ssh sp10228@papp01lxv -pw XXXXXXXX -t -m c:\sidd\SIP_reprocessing\Unix2Windows\sh_scripts\moveFailedEstUser1Nas.sh
pscp -sftp -pw XXXXXXXX sp10228@papp01lxv:"/home/sp10228/fasdir/moveFailedEstUser1Nas.bat" "c:\sidd\SIP_Reprocessing\Unix2Windows\sip_batch\moveFailedEstUser1Nas.bat"
ECHO TO Move forward press Enter (moveFailedEstUser1Nas.bat)
PAUSE
CALL c:\sidd\SIP_reprocessing\Unix2Windows\sh_scripts\CreateEstHeirarchyUser1Nas.bat
ECHO Directory Heirarchy...
PAUSE
CALL c:\sidd\SIP_reprocessing\Unix2Windows\sip_batch\moveFailedEstUser1Nas.bat

ECHO Script Part:2 finished... (Press enter)
PAUSE
