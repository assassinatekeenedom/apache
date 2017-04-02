@ECHO OFF
setlocal
FOR /F "tokens=2 delims= " %%P IN ('tasklist ^| findstr httpd.exe') DO TaskKill.exe /f /PID %%P
endlocal
exit /b 0