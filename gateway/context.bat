@ECHO OFF
setlocal
if not exist ".repo" (
	echo the .repo needs to be set; but not necessarily .scm-svn or .scm-git.
	call setRepo.bat
)
echo context: %1
echo repo-based-path: %2
echo proxy port: %3
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
endlocal
exit /b 0
echo /odxp/js/ %repo%\src\odxp_ui\src\main\webapp\js 1337>.static-contexts
echo /odxp/templates/ %repo%\src\odxp_ui\src\main\webapp\templates 1338>>.static-contexts
echo /odxp/css/ %repo%\src\odxp_ui\src\main\webapp\css 1339>>.static-contexts
echo /odxp/uitk-lib-custom/ %repo%\src\odxp_ui\src\main\webapp\uitk-lib-custom 1340>>.static-contexts