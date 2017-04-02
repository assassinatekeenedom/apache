@ECHO OFF
setlocal
set jboss = ""
if not exist ".as" (
	call setAS.bat
)
set /p jboss=<.as
set odxp=%cd%
cd %jboss%\standalone\deployments

:loginq
set /p login="Delete the login app [Y/N]? "
if /i "%login%" == "Y" (
	del odxp_login*.war*
) else (
	if /i not "%login%" == "N" ( 		
		goto:loginq
	)
)

:serviceq
set /p service="Delete the services app [Y/N]? "
if /i "%service%" == "Y" (
	del odxp-services*.war*
) else (
	if /i not "%service%" == "N" ( 		
		goto:serviceq
	)
)

:uiq
set /p ui="Delete the ui app [Y/N]? "
if /i "%ui%" == "Y" (
	del odxp-ui*.war*
) else (
	if /i not "%ui%" == "N" (	
		goto:uiq
	)
)

:asq
set /p startup="Startup the AS [Y/N]? "
if /i "%startup%" == "Y" (
	cd %jboss%\bin
	start standalone.bat -b 0.0.0.0 --debug 8797 --server-config=standalone-full.xml
) else (
	if /i not "%startup%" == "N" (	
		goto:asq
	)
)
cd %odxp%
call .deploy.bat
endlocal
exit /b 0