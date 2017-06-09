@ECHO OFF
if "%1"=="" (
	goto:retry
)
echo setting initial folder for the command prompt: %1%
reg add "HKEY_CURRENT_USER\Software\Microsoft\Command Processor" /v AutoRun /t REG_SZ /d "IF x"C:\Windows\system32\cmd.exe"==x"C:\Windows\system32\cmd.exe"  (cd /D %1%)"
goto:fin
:retry
echo ERROR: Please provide the full path, e.g.: setCmdHome.bat C:\path\to\folder
:fin