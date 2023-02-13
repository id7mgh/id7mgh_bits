@echo off
mode con lines=1 cols=15
title Final_Bits.bat
sc config "BITS" start= auto >nul
sc start "BITS" >nul
for /f "tokens=3" %%a in ('sc queryex "BITS" ^| findstr "PID"') do (set pid=%%a)
wmic process where ProcessId=%pid% CALL setpriority "realtime" >nul
sc config "Dnscache" start= demand >nul
sc start "Dnscache" >nul
for /f "tokens=3" %%a in ('sc queryex "Dnscache" ^| findstr "PID"') do (set pid=%%a)
wmic process where ProcessId=%pid% CALL setpriority "realtime" >nul
wmic process where name="mqsvc.exe" CALL setpriority "high priority" >nul
wmic process where name="mqtgsvc.exe" CALL setpriority "high priority" >nul
wmic process where name="javaw.exe" CALL setpriority "realtime" >nul

:finalendless1
PING -n 5 127.0.0.1 >nul
sc query BITS | find /I "STATE" | find "STOPPED" >nul
sc start BITS >nul
goto finalendless1
