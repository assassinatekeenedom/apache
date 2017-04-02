@ECHO OFF
setlocal
if not "%1%"=="" (
	set branch=%1
	goto:initqb
)
:initName
set /p branch="What is the New Branch name you will use? "
if "%branch%" == "" goto:initName
:initqb
if not exist ".branch" mkdir .branch
cd .branch
if exist "%branch%" (
	echo ERROR - %branch% already exists.
	exit /b 0
)
:scmq
if exist "..\.scm-git" (
	cd ..
	set /p scm=<.scm-git
	cd .branch
	git clone %scm% git-%branch%>nul
	cd git-%branch%
	git checkout -b %branch%>nul
	git push origin %branch%>nul
	cd ..
)
if exist "..\.scm-svn-trunk" (
	cd ..
	set /p scm=<.scm-svn-trunk
	set /p branch=<.scm-svn-branch
	set /p named=<.named
	cd .branch
	svn copy %scm% %branch%/%named%-%branch% -m "%branch% - initializing branch repository.">nul
	svn co %branch%/%named%-%branch% %branch%>nul
)
if "%scm%" == "" (
	call setSCM.bat
	goto:scmq
)
if exist "git-%branch%" (
	if exist "%branch%" (
		cd git-%branch%
		xcopy .git ..\%branch%\.git /s /i /h /q>nul
		xcopy .gitignore ..\%branch%\.gitignore*>nul
		cd ..
		rmdir /s /q git-%branch%
		goto:doneqb
	)
	xcopy git-%branch% %branch%\ /s /i /h /q>nul
	rmdir /s /q git-%branch%
	goto:doneqb
)
:doneqb
if not exist "%branch%" (
	echo There was an ERROR of some kind; no Branch named %branch% created!!
)
cd ..
endlocal