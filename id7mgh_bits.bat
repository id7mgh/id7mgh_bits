@echo off
title id7mgh Bits
set green=[32m
set red=[91m
set white=[97m
set on=%green%ON%white% 
set off=%red%OFF%white%

mode con lines=8 cols=25
net session >nul 2>&1
    if %errorLevel% == 0 (
goto bitsmenu
    ) else (
echo ------=id7mgh Bits=------
echo.
echo  %red%please run this program
echo  as an administrator%white%
pause >nul
exit
	)

:bitsmenu
PING -n 2 127.0.0.1 >nul
IF not exist %temp%\id7mgh_Bits mkdir %temp%\id7mgh_Bits
IF not exist %temp%\id7mgh_Bits\Normal_Bits.bat set normal_bat=1
IF not exist %temp%\id7mgh_Bits\Final_bits.bat  set final_bat=1


if "%normal_bat%" == "1" (
set normal_bat=0
echo Downloading packages 1/2
curl -g -L -# -o "%temp%\id7mgh_Bits\Normal_Bits.bat" "https://raw.githubusercontent.com/id7mgh/id7mgh_bits/main/files/normal_bits.bat" >nul 2>&1
)

if "%final_bat%" == "1" (
set final_bat=0
curl -g -L -# -o "%temp%\id7mgh_Bits\Final_Bits.bat" "https://raw.githubusercontent.com/id7mgh/id7mgh_bits/main/files/Final_bits.bat" >nul 2>&1
echo Downloading packages 2/2
)










set normalScore=0
set finalScore=0
set normalbits=%off%
set finalbits=%off%

tasklist /FI "WINDOWTITLE eq Administrator:  Final_Bits.bat"2>NUL | find /I /N "cmd.exe"2>NUL
IF %ErrorLevel% EQU 0 (
set finalbits=%on%
set finalScore=1
)
tasklist /FI "WINDOWTITLE eq Administrator:  Normal_Bits.bat"2>NUL | find /I /N "cmd.exe"2>NUL
IF %ErrorLevel% EQU 0 (
set normalbits=%on%
set normalScore=1
)








cls
mode con lines=8 cols=25
echo ------=id7mgh Bits=------
echo.                        
echo   1- Normal Bits : %normalbits%
echo   2- Final bits  : %finalbits%        
echo   3- info
choice /C:123 /N 
if '%errorlevel%' == '1' GOTO normal
if '%errorlevel%' == '2' GOTO final
if '%errorlevel%' == '3' GOTO info
goto bitsmenu







:normal
if "%normalScore%" == "1" (
taskkill /fi "WINDOWTITLE eq Administrator:  Normal_Bits.bat" >nul

) else start /min %temp%\id7mgh_Bits\Normal_Bits.bat >nul
goto bitsmenu

:final
if "%finalScore%" == "1" (
taskkill /fi "WINDOWTITLE eq Administrator:  Final_Bits.bat" >nul

sc stop BITS >nul
sc stop Dnscache >nul
wmic process where name="mqsvc.exe" CALL setpriority "normal" >nul
wmic process where name="mqtgsvc.exe" CALL setpriority "normal" >nul
wmic process where name="javaw.exe" CALL setpriority "normal" >nul


)else start /min %temp%\id7mgh_Bits\Final_Bits.bat >nul

s
goto bitsmenu












:bitsstop
cls
echo    stoping bits
sc stop BITS >nul
sc stop Dnscache >nul
wmic process where name="mqsvc.exe" CALL setpriority "normal" >nul
wmic process where name="mqtgsvc.exe" CALL setpriority "normal" >nul
wmic process where name="javaw.exe" CALL setpriority "normal" >nul
goto bitsmenu












:info
cls
echo ------=id7mgh Bits=------
echo.                        
echo    id7mgh/id7mgh_bits  
echo    at Github
echo. 
echo  press any key to back

pause >nul
cls
goto bitsmenu

