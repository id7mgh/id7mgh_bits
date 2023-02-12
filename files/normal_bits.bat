for /f "tokens=3" %%a in ('sc queryex "BITS" ^| findstr "PID"') do (set pid=%%a)
wmic process where ProcessId=%pid% CALL setpriority "realtime" 

:bitsendless
PING -n 5 127.0.0.1 
sc query BITS | find /I "STATE" | find "STOPPED"
sc start BITS
goto bitsendless1
