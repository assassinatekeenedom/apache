@ECHO OFF
setlocal
if "%1%" == "" (
	goto:manualq
) else (
	echo %1>.named
	echo %2>.scm-git
	echo %3/%1>.scm-svn-trunk
	echo %4>.scm-svn-branch
)
:donescm
endlocal
exit /b 0

:manualq
set /p git="What is the URL for the remote git repository (press enter for none)? "
if "%git%" == "" (
	if exist ".scm-git" del .scm-git
) else (
	echo %git%>.scm-git
)
set /p svnTrunk="What is the base URL for svn Trunk repositories, do NOT include the project name (press enter for none)? "
if "%svnTrunk%" == "" (
	if exist ".scm-svn-trunk" del .scm-svn-trunk
	if exist ".scm-svn-branch" del .scm-svn-branch
	if not exist ".scm-git" del .named
	goto:donescm
) else (
	goto:trunkName
)

:trunkName
set /p svnName="What is the name of the target project in Trunk? "
if "%svnName%" == "" (
	goto:trunkName
) else (
	echo %svnName%>.named
)
echo %svnTrunk%/%svnName%>.scm-svn-trunk
goto:branchq

:branchq
set /p svnBranch="What is the base URL for branches from %svnTrunk%? "
if "%svnBranch%" == "" (
	if exist ".scm-svn-branch" del .scm-svn-branch
) else (
	echo %svnBranch%>.scm-svn-branch
)
goto:donescm