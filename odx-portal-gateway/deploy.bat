@ECHO OFF
setlocal
if not exist .as (
	call setAS.bat
)
set jboss=<.as
if "%login%" == "" (
	goto:loginqb
)
:resumes
if /i "%login%" == "Y" (
	echo copy login app to %jboss%\standalone\deployments.
)
if "%services%" == "" (
	goto:serviceqb
)
:resumeu
if /i "%service%" == "Y" (
	echo copy services app to %jboss%\standalone\deployments
)
if "%ui%" == "" (
	goto:uiqb
)
:finish
if /i "%ui%" == "Y" (
	echo copy ui app to %jboss%\standalone\deployments
)
echo login? %login%
echo service? %service%
echo ui? %ui%
endlocal
exit /b 0

:loginqb
set /p login="Deploy the login app [Y/N]? "
goto:resumes

:serviceqb
set /p service="Deploy the services app [Y/N]? "
goto:resumeu

:uiqb
set /p ui="Deploy the ui app [Y/N]? "
goto:finish