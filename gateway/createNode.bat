@ECHO OFF
setlocal
if "%1" == "" goto:initName
set named=%1%
:resume
if not exist ".scm-git" goto:norepo
if not exist ".named" goto:norepo
set /p scm=<.scm-git
set /p repo=<.named
set origin=%cd%
echo cloning a generic C:/jboss for this script as an example, jboss and clone of %scm% at %cd%\.farm\%named%
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
echo git clone %scm%>>clone.bat
call clone.bat
del clone.bat
if not exist "%repo%" goto:failedscm
cd %repo%
copy %origin%\bin\build.bat .
copy %origin%\bin\push.bat .
copy %origin%\bin\sonar.bat .
copy %origin%\bin\testBuild.bat .
cd ..\..\..\
goto:skip
:collision
echo That node (name) already exists, or your repo name isn't set (.named file); please retry after updating.
goto:skip
:initName
set /p named="What is the name of the node for the farm? "
if "%named%" == "" goto:initName
goto:resume
:failedscm
echo The repo name provided (from .named file) does not exist after checking out %scm%; please do this part manually.
goto:skip
:norepo
echo You need to have the repo set in the .repo file; or run the appropriate script.
:skip
endlocal