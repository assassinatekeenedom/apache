@ECHO OFF
rem need sub-process to determine that svn and git repos are clean and up to date;
rem this check needs to be performed at the start of this routine. If the svn and git \
rem repos are both clean then this script can execute.
setlocal
set /p branch="What is the NEW Branch name you will use? "
if not exist ".branch" (
	mkdir .branch
)
cd .branch
if exist "%branch%" (
	echo ERROR - %branch% already exists.
	exit /b 0
)
mkdir %branch%
cd %branch%
svn copy https://svn.uhg.com/optum-hie/hie2/trunk/odx-portal https://svn.uhg.com/optum-hie/hie2/branches/odx-portal-%branch% -m "%branch% - initializing branch repository."
svn co https://svn.uhg.com/optum-hie/hie2/branches/odx-portal-%branch% svn-%branch%
git clone https://codehub.optum.com/odx-portal/odx-portal.git git-%branch%
cd git-%branch%
git checkout -b %branch%
git push origin %branch%
xcopy .git ..\svn-%branch%\.git /s /i /h
xcopy .gitignore ..\svn-%branch%\.gitignore*
cd ..
move svn-%branch% ..\
cd ..\
rmdir /s /q %branch%
move svn-%branch% %branch%
endlocal