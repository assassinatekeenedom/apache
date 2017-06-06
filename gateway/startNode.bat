@ECHO OFF
setlocal
if "%1" == "" goto:initName
set named=%1
:resume
if not exist ".farm\%named%\jboss\bin\startJBoss.bat" goto:dne
cd .farm\%named%\jboss\bin
start startJBoss.bat
cd ..\..\..\..\
endlocal
goto:done
:initName
set /p named="What is the name of the node on the farm? "
if "%named%" == "" goto:initName
goto:resume
:dne
echo There is no startJBoss.bat script associated with that JBoss node; or that node does not exist.
:done