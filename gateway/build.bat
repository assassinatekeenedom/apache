@ECHO OFF
setlocal
:buildrepoq
if not exist ".repo" (
	call setRepo.bat
	goto:buildrepoq
)
set /p repo=<.repo
set odxp=%cd%
call .cleanAS.bat
:testappq
cd %repo%
dir /d
set /p build="Do you want to build an application [Y/N]? "
if /i "%build%" == "Y" (
	goto:deployappq
) else (
	if /i "%build%" == "N" ( 
		goto:buildfinishq
	)
	goto:testappq
)
:deployappq
set /p module="Provide the relative (from repo) path to the root of the application you want to deploy (leave empty if done): "
if not "%module%" == "" (
	if not exist "%repo%\%module%" echo could not find the application. && goto:deployappq
	cd %module%
	goto:skiptestsq
) 
goto:testappq


:skiptestsq
set /p skipTests="Do you want to skip tests [Y/N]? " 
if /i "%skipTests%" == "Y" (
	echo mvn clean install -DskipTests>.build.bat
	call .build.bat
	if exist ".build.bat" del .build.bat
	goto:testappq
) 
if /i "%skipTests%" == "N" (
	echo mvn clean org.jacoco:jacoco-maven-plugin:0.7.2.201409121644:prepare-agent install>.build.bat
	call .build.bat
	if exist ".build.bat" del .build.bat
	goto:testappq
)
goto:skiptestsq

:buildfinishq
call .cleanAS.bat
call .deploy.bat
cd %odxp%
endlocal
exit /b 0