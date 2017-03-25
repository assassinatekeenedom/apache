@ECHO OFF
setlocal
IF NOT EXIST ".static-contexts" (
    call setRepo.bat
)
cd ..\conf\
del httpd.conf
copy original\httpd.conf .
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
for /f "tokens=1,2,3 delims= " %%a in (..\bin\.static-contexts) do (
	echo    ProxyPass %%a http://localhost:%%c/>>httpd.conf
)
echo    ProxyPass / http://%1:8080/>>httpd.conf
echo ^</VirtualHost^>>>httpd.conf
for /f "tokens=1,2,3 delims= " %%a in (..\bin\.static-contexts) do (
	echo Listen %%c>>httpd.conf
	echo NameVirtualHost *:%%c>>httpd.conf
	echo ^<VirtualHost *:%%c^>>>httpd.conf
	echo    ServerName *>>httpd.conf
	echo    DocumentRoot "%%b">>httpd.conf
	echo    ^<Directory "%%b"^>>>httpd.conf
	echo        Options Indexes FollowSymLinks>>httpd.conf
	echo        AllowOverride None>>httpd.conf
	echo        Order allow,deny>>httpd.conf
	echo        Allow from all>>httpd.conf
	echo    ^</Directory^>>>httpd.conf
	echo ^</VirtualHost^>>>httpd.conf
)
cd ..\bin
start httpd.exe
endlocal
        