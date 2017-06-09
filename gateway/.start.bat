@ECHO OFF
setlocal
IF NOT EXIST ".static-contexts" (
    call context.bat
)
if not exist ".repo" (
	call setRepo.bat
)
echo %1>.domain
set /p repo=<.repo
cd ..\conf\
del httpd.conf
copy original\httpd.conf .>nul
echo ####>>httpd.conf
echo ####>>httpd.conf
echo #DYNAMIC PORTAL GATEWAY>>httpd.conf
echo ####>>httpd.conf
echo ####>>httpd.conf
echo Listen 80>>httpd.conf
echo NameVirtualHost *:80>>httpd.conf
echo ^<VirtualHost *:80^>>>httpd.conf
echo    ServerName %1>>httpd.conf
echo    ProxyPreserveHost On>>httpd.conf
for /f "tokens=1,2,3 delims= " %%a in (..\gateway\.static-contexts) do (
	echo    ProxyPass %%a http://localhost:%%c/>>httpd.conf
)
if "%2"=="" goto:initport
set port=%2
:middleman
echo    ProxyPass / http://%1:%port%/>>httpd.conf
echo ^</VirtualHost^>>>httpd.conf
for /f "tokens=1,2,3 delims= " %%a in (..\gateway\.static-contexts) do (
	echo Listen %%c>>httpd.conf
	echo NameVirtualHost *:%%c>>httpd.conf
	echo ^<VirtualHost *:%%c^>>>httpd.conf
	echo    ServerName *>>httpd.conf
	echo    DocumentRoot "%repo%%%b">>httpd.conf
	echo    ^<Directory "%repo%%%b"^>>>httpd.conf
	echo        Options Indexes FollowSymLinks>>httpd.conf
	echo        AllowOverride None>>httpd.conf
	echo        Order allow,deny>>httpd.conf
	echo        Allow from all>>httpd.conf
	echo    ^</Directory^>>>httpd.conf
	echo ^</VirtualHost^>>>httpd.conf
)
endlocal
cd ..\bin
start httpd.exe
cd ..\gateway
exit /b 0
:initport
set /p port="What port will the AS run on? "
if "%port%" == "" goto:initport
goto:middleman