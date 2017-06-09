@ECHO OFF
setlocal
echo 1=%1 and 2=%2
if "%1" == "" goto:initName
set named=%1
:resume
if "%2" == "" goto:initPath
:resumeb
set asPath=%2
if not exist "%asPath%" goto:nopath
cd %2
if not exist ".farm\%named%\jboss\bin\startJBoss.bat" goto:dne
cd .farm\%named%\jboss\bin
call startJBoss.bat
goto:done
:initName
set /p named="What is the name of the node on the farm? "
if "%named%" == "" goto:initName
goto:resume
:initPath
set /p farm="What is the path to the parent directory of .farm? "
if "%farm%" == "" goto:initPath
goto:resumeb
:nopath
echo There was no .farm directory passed into the script; e.g. .startNode.bat A C:\apache\gateway.
goto:done
:dne
echo There is no startJBoss.bat script associated with that JBoss node; or that node does not exist.
:done
endlocal