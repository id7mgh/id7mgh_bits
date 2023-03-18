@echo off
title id7mgh client
set green=[32m
set red=[91m
set white=[97m
set gray=[90m
set on=%green%ON%white% 
set off=%red%OFF%white%
mode con lines=8 cols=35

::Check if not administrator
net session >nul 2>&1
    if %errorLevel% == 0 (
goto clientmenu
    ) else (
echo.
echo.
echo.            %red%   /!\
echo.      please run this program
echo       as an administrator%white%
pause >nul
exit
	)

:clientmenu
cls
echo loading
PING -n 2 127.0.0.1 >nul
IF not exist %tmp%\id7mgh_Bits mkdir %tmp%\id7mgh_Bits >nul
IF not exist %tmp%\id7mgh_Bits\smart.bat set smart=1 >nul

::download smart packets
if "%smart%" == "1" (
set smart=0
echo Downloading Smart packets
curl -g -L -# -o "%tmp%\id7mgh_Bits\smart.bat" "https://raw.githubusercontent.com/id7mgh/id7mgh_bits/main/files/smart.bat" >nul 2>&1
)


set smartScore=0
set smartstatus=%off%

::check if smart packets enable
tasklist /FI "WINDOWTITLE eq Administrator:  smart.bat"2>NUL | find /I /N "cmd.exe"2>NUL
IF %ErrorLevel% EQU 0 (
set smartstatus=%on%
set smartScore=1
)

::check autotuning level
for /f "tokens=6 delims= " %%a in ('netsh interface tcp show global  ^| find "Receive Window Auto-Tuning Level    :"') do set "tuningLevel=%%a"

::main ui
cls
mode con lines=8 cols=35
echo.
echo.                        
echo  1- SmartPackets: %smartstatus%
echo  2- Auto Tuning : %tuningLevel%        
echo  3- info
choice /C:123 /N 
if '%errorlevel%' == '1' GOTO smart
if '%errorlevel%' == '2' GOTO tuning
if '%errorlevel%' == '3' GOTO info
goto clientmenu








:smart
if "%smartScore%" == "1" (
taskkill /fi "WINDOWTITLE eq Administrator:  smart.bat" >nul

) else start /min %tmp%\id7mgh_Bits\smart.bat >nul
goto clientmenu


:: autotuning ui
:tuning
set Disable=
set Highly=
set Restricted=
set Normal=
if '%tuningLevel%' == 'disabled' set Disable=%gray%
if '%tuningLevel%' == 'highlyrestricted' set Highly=%gray%
if '%tuningLevel%' == 'restricted' set Restricted=%gray%
if '%tuningLevel%' == 'normal' set Normal=%gray%
cls
mode con lines=9 cols=35
echo.
echo   1- %Disable%Disabled%white%
echo   2- %Highly%Highly restricted%white%
echo   3- %Restricted%Restricted%white%  
echo   4- %Normal%Normal%white%

echo   5- back to main menu
choice /C:12345 /N 
if '%errorlevel%' == '1' GOTO tuningDisable
if '%errorlevel%' == '2' GOTO tuningHighly
if '%errorlevel%' == '3' GOTO tuningRestricted
if '%errorlevel%' == '4' GOTO tuningNormal
if '%errorlevel%' == '5' GOTO clientmenu
goto tuning


:tuningDisable
netsh interface tcp set global autotuning=disabled
goto clientmenu
:tuningHighly
netsh interface tcp set global autotuning=highlyrestricted
goto clientmenu
:tuningRestricted
netsh interface tcp set global autotuning=restricted
goto clientmenu
:tuningNormal
netsh interface tcp set global autotuning=normal
goto clientmenu


:info
cls
echo.
echo.                        
echo    id7mgh/id7mgh_bits  
echo    at Github
echo. 
echo  press any key to back

pause >nul
cls
goto clientmenu

