

sc config "BITS" start= auto >nul
sc start "BITS" >nul
for /f "tokens=3" %%a in ('sc queryex "BITS" ^| findstr "PID"') do (set pid=%%a)
wmic process where ProcessId=%pid% CALL setpriority "realtime" 
sc config "Dnscache" start= demand 
sc start "Dnscache" >nul
for /f "tokens=3" %%a in ('sc queryex "Dnscache" ^| findstr "PID"') do (set pid=%%a)
wmic process where ProcessId=%pid% CALL setpriority "realtime" 
wmic process where name="mqsvc.exe" CALL setpriority "high priority" 
wmic process where name="mqtgsvc.exe" CALL setpriority "high priority" 
wmic process where name="javaw.exe" CALL setpriority "realtime" 

:finalendless1
PING -n 5 127.0.0.1 >nul
sc query BITS | find /I "STATE" | find "STOPPED" 
sc start BITS 
goto finalendless1
