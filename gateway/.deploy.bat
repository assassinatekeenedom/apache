@ECHO OFF
setlocal

:deployrepoq
if not exist .repo (
	call setRepo.bat
	goto:deployrepoq
)
:deployasq
if not exist .as (
	call setAS.bat
	goto:deployasq
)
set origin=%cd%
set /p repo=<.repo
set /p jboss=<.as
cd %repo%
if not "%1%" == "" (
	copy %1\target\*.war %jboss%\
	goto:deployfinishq
) 
dir /d
:deployaskq
set /p deploy="Do you have an artifact that needs to be deployed [Y/N]? "
if /i "%deploy%" == "Y" (
	goto:deployappq
) else (
	if /i not "%deploy%" == "N" ( 
		goto:deployaskq
	)
	goto:deployfinishq
)
:deployappq
set /p module="Provide the relative (from repo) path to the root of the application you want to deploy (leave empty if done): "
if not "%module%" == "" (
	if not exist "%repo%\%module%" echo could not find the application. && goto:deployappq
	if not exist "%repo%\%module%\target" echo the application needs to be built. && goto:deployappq
	copy %module%\target\*.war %jboss%\
	goto:deployaskq
)
:deployfinishq
cd %odxp%
endlocal
exit /b 0