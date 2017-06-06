@ECHO OFF
if "%1" == "" goto:initName
set named = %1
:resume
echo new node for farm will be: %named%
if not exist ".farm" mkdir .farm
cd .farm
if exist "%named%" goto:collision
mkdir %named%\jboss
cd %named%\jboss
copy C:\jboss\*.* .
mklink /d appclient C:\jboss\appclient
mklink /d bundles C:\jboss\bundles
mklink /d modules C:\jboss\modules
mklink /d docs C:\jboss\docs
mklink /d icons C:\jboss\icons
mklink /d welcome-content C:\jboss\welcome-content
mkdir bin
cd bin
mklink /d client C:\jboss\bin\client
mklink /d FFDC C:\jboss\bin\FFDC
copy C:\jboss\bin\*.* .
cd ..
mkdir standalone
cd standalone
xcopy C:\jboss\standalone\configuration configuration\ /e /h
xcopy C:\jboss\standalone\deployments deployments\ /e /h
cd ..\..\
echo @ECHO OFF>clone.bat
echo git clone https://codehub.optum.com/odx-portal/odx-portal.git>>clone.bat
call clone.bat
del clone.bat
cd ..\..\
goto:skip
:collision
echo That node (name) already exists; please remove it or pick a new name.
goto:skip
:initName
set /p named="What is the name of the node for the farm? "
if "%named%" == "" goto:initName
goto:resume
:skip