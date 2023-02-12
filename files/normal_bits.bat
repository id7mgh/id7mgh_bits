@echo off
Normal_Bits.bat
for /f "tokens=3" %%a in ('sc queryex "BITS" ^| findstr "PID"') do (set pid=%%a)
wmic process where ProcessId=%pid% CALL setpriority "realtime"  >nul

:bitsendless
PING -n 5 127.0.0.1 >nul
sc query BITS | find /I "STATE" | find "STOPPED" >nul
sc start BITS >nul
goto bitsendless
