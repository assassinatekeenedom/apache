@ECHO OFF
setlocal
:makesureq
if not exist ".as" (
	call setAS.bat
	goto:makesureq
)
set origin=%cd%
set /p asbin=<.as-bin
set /p asexe=<.as-exe
cd %asbin%
start %asexe%
cd %origin%
endlocal
exit /b 0