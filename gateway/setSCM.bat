@ECHO OFF
setlocal
echo .scm-git
set /p git="What is the URL for the remote git repository (press enter for none)? "
if "%git%" == "" (
	if exist ".scm-git" (
		del .scm-git
	)
) else (
	echo %git%>.scm-git
)
set /p svnTrunk="What is the URL for the svn Trunk repository (press enter for none)? "
if "%svnTrunk%" == "" (
	if exist ".scm-svn-trunk" (
		del .scm-svn-trunk
	)
	if exist ".scm-svn-branch" (
		del .scm-svn-branch
	)
	goto:donescm
) else (
	echo %svnTrunk%>.scm-svn-trunk
)
set /p svnBranch="What is the base URL for branches from %svnTrunk%? "
if "%svnBranch%" == "" (
	if exist ".scm-svn-branch" (
		del .scm-svn-branch
	)
) else (
	echo %svnBranch%>.scm-svn-branch
)
:donescm
exit /b 0
endlocal