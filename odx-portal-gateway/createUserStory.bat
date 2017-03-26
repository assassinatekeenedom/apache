@ECHO OFF
rem need sub-process to determine that svn and git repos are clean and up to date;
rem this check needs to be performed at the start of this routine. If the svn and git \
rem repos are both clean then this script can execute.
setlocal
echo initializing new svn and git repositories.
set /p userstory="What is the Rally User Story Id? "
if not exist ".userstory" (
	echo creating directory .userstory.
)
echo cd .userstory
echo checking for %userstory%
if exist "%userstory%" (
	echo Story already exists, exit /b 0 
)
echo echo %userstory%^>^>.userstory
echo type .userstory
echo mkdir %userstory%
echo cd %userstory%
echo svn copy trunk svn-odx-portal-%userstory%
echo svn co svn-odx-portal-%userstory%
echo git clone master git-odx-portal-%userstory%
echo cd git-odx-portal-%userstory%
echo git checkout -b %userstory%
echo git push origin %userstory%
echo move .git ..\svn-odx-portal-%userstory%\
echo cd ..\svn-odx-portal-%userstory%
rem run sub-process to determine that svn and git are in synch.
echo git status
echo svn status
echo rmdir /s /q ..\git-odx-portal-%userstory%
echo echo details^>^>README ^(with svn and git repo information.^)
echo svn commit -m '%userstory% - initialized synchronized git and svn repositories.'
echo git add -A
echo git commit -a -m '%userstory% - initialized synchronized git and svn repositories.'
echo git push -u origin HEAD:%userstory%
echo %userstory% is ready at %cd%
endlocal