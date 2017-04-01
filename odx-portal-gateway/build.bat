@ECHO OFF
setlocal
set /p domain=<.domain
set /p repo=<.repo
set odxp=%cd%
cd %repo%
git fetch -avp
cd %odxp%
set /p userstory="What is the [USXXXXXX] (User Story Rally Id) do you want to build? "
echo Domain: %domain%
echo Repository Location: %repo%
cd %repo%
git checkout %userstory%
git pull
git status
:testappq
set /p testappbuild="Do you want to build the login web-application, context=/odxploginapp/ [Y/N]? "
if /i "%testappbuild%" == "Y" (
	cd testapp
	goto:skiptestsq
) else (
	if /i "%testappbuild%" == "N" ( 
		goto:moduleq
	)
	goto:testappq
)
:moduleq
cd src
dir
set /p module="What module do you want to build? "
if exist "%module%" (
	cd %module%
)
:skiptestsq
set /p skipTests="Do you want to skip tests [Y/N]? " 
if /i "%skipTests%" == "Y" (
	echo mvn clean install -DskipTests>.build.bat
	call .build.bat
	del .build.bat
) else (
	if /i "%skipTests%" == "N" (
		echo mvn clean org.jacoco:jacoco-maven-plugin:0.7.2.201409121644:prepare-agent install>.build.bat
		call .build.bat
		del .build.bat
	) else (
		goto:skiptestsq
	)
)
cd %repo%
set /p another="Do you want to do another build [Y/N]? " 
if /i "%another%" == "Y" (
	goto:testappq
)
cd %odxp%
call .cleanAS.bat
endlocal
