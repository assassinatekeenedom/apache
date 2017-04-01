@ECHO OFF
setlocal
if not exist .repo (
	call setRepo.bat
)
if not exist .as (
	call setAS.bat
)
set /p repo=<.repo
set /p jboss=<.as
if "%login%" == "" (
	goto:loginqb
)
:resumes
if /i "%login%" == "Y" (
	copy %repo%\testapp\OdxpLoginApp\target\odxp_login_app*.war %jboss%\standalone\deployments\
)
if "%service%" == "" (
	goto:serviceqb
)
:resumeu
if /i "%service%" == "Y" (
	copy %repo%\src\odxp_services\target\odxp-services*.war %jboss%\standalone\deployments\
)
if "%ui%" == "" (
	goto:uiqb
)
:finish
if /i "%ui%" == "Y" (
	copy %repo%\src\odxp_ui\target\odxp-ui*.war %jboss%\standalone\deployments\
)
del %jboss%\standalone\deployments\odxp-*.undeployed
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