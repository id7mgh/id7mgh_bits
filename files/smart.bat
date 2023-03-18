:loop
sc start BITS >nul
sc query BITS | find /I "STATE" | find "STOPPED" >nul
wmic process where name="svchost.exe" CALL setpriority "realtime" >nul
ipconfig /flushdns >nul
timeout /t 10 >nul
goto :loop >nul


:: credits goes to ghast.io


