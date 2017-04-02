@ECHO OFF
rem need sub-process to determine that svn and git repos are clean and up to date;
rem this check needs to be performed at the start of this routine. If the svn and git \
rem repos are both clean then this script can execute.
setlocal
if "%1%"=="" (
	set /p branch="What is the NEW Branch name you will use? "
) else (
	set branch=%1%
)
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
:scmq
if exist ".scm-git" (
	set /p scm=<.scm-git
	git clone %scm% git-%named%
	cd git-%branch%
	git checkout -b %branch%
	git push origin %branch%
)
if exist ".scm-svn-trunk" (
	set /p scm=<.scm-svn-branch
	svn co %scm% svn-%named%
)
if "%scm%" == "" (
	call setSCM.bat
	goto:scmq
)
if exist "git-%named%" (
	if exist "svn-%named%" (
		cd git-%named%		
		xcopy .git ..\svn-%named%\.git /s /i /h
		xcopy .gitignore ..\svn-%named%\.gitignore*
		cd ..
		move svn-%named% %named%
		rmdir /s /q git-%named%
		goto:doneqb
	) else (
		cd git-%named%
		git checkout %named%
		cd ..
		move git-%named% %named%
		goto:doneqb
	)
) 
if exist "svn-%named%" (
	move svn-%named %named%
	goto:doneqb
)
:doneqb
if not exist "%named%" (
	echo There was an ERROR of some kind; no Branch named %named% created!!
)
endlocal