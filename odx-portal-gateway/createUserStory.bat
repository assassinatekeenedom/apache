@ECHO OFF
rem need sub-process to determine that svn and git repos are clean and up to date;
rem this check needs to be performed at the start of this routine. If the svn and git \
rem repos are both clean then this script can execute.
setlocal
set /p userstory="What is the Rally User Story Id? "
if not exist ".userstory" (
	mkdir .userstory
)
cd .userstory
if exist "odx-portal-%userstory%" (
	echo ERROR - %userstory% already exists.
	exit /b 0
)
mkdir %userstory%
cd %userstory%
svn copy https://svn.uhg.com/optum-hie/hie2/trunk/odx-portal https://svn.uhg.com/optum-hie/hie2/branches/odx-portal-%userstory% -m "%userstory% - initializing branch repository."
svn co https://svn.uhg.com/optum-hie/hie2/branches/odx-portal-%userstory%
git clone https://codehub.optum.com/odx-portal/odx-portal.git git-odx-portal-%userstory%
cd git-odx-portal-%userstory%
git checkout -b %userstory%
git push origin %userstory%
xcopy .git ..\odx-portal-%userstory%\.git /s /i /h
xcopy .gitignore ..\odx-portal-%userstory%\.gitignore*
cd ..
move odx-portal-%userstory% ..\
cd ..\
rmdir /s /q %userstory%
endlocal