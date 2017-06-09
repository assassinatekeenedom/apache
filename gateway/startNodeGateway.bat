@ECHO OFF
setlocal
if not "%1"=="" goto:apply
:initName
set /p portnum="What is the AS port number (8080 typically)? "
if "%portnum%"=="" goto:initName
goto:resume
:apply
set portnum=%1%
:resume
echo .start.bat 127.0.0.1 %portnum%
.start.bat 127.0.0.1 %portnum%
endlocal