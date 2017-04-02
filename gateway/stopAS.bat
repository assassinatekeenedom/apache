@ECHO OFF
setlocal
FOR /F "tokens=5 delims= " %%P IN ('netstat -a -n -o ^| findstr :8080') DO TaskKill.exe /f /PID %%P
echo Find the command window that was running the server and verify it has terminated.  Close the window if you like.
endlocal
exit /b 0