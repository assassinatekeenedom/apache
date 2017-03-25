@ECHO OFF
setlocal
set origin=%cd%
if "%1%"=="" (
	set named=odx-portal
) else (
	set named=%1%
)
set /p clone="Do you need a new clone of the odx-portal repository [Y/N]? "
if /i "%clone%" == "Y" (
	call:getLocalRepo
	git clone https://codehub.optum.com/odx-portal/odx-portal.git %named%
	cd %origin%
)
if /i "%clone%" == "N" (
	set /p repo="Where is your odx-portal repository located (file-path)? "
)
echo %repo%>.repo
echo /odxp/js/ %repo%\src\odxp_ui\src\main\webapp\js 1337>.static-contexts
echo /odxp/templates/ %repo%\src\odxp_ui\src\main\webapp\templates 1338>>.static-contexts
echo /odxp/css/ %repo%\src\odxp_ui\src\main\webapp\css 1339>>.static-contexts
echo /odxp/uitk-lib-custom/ %repo%\src\odxp_ui\src\main\webapp\uitk-lib-custom 1340>>.static-contexts
echo Your repository ^(%repo%^) is now the active source of static resources; instead of the JBoss container.
endlocal
exit /b 0
:getLocalRepo
	set /p local="Where do you want the cloned repository located (file-path)? "
	cd %local%
	set repo=%local%^\%named%
	exit /b 0