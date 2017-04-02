@ECHO OFF
setlocal
set origin=%cd%
if "%1%"=="" (
	echo please provide the name of the repository.
	exit /b 0
)
set named=%1%
:initq
set /p clone="Do you need to initialize (create) this branch [Y/N]? "
if /i "%clone%" == "Y" (
	call branch.bat %named%
	set repo=%cd%\.branch\%named%
	goto:doneq
) else (
	if /i not "%clone%" == "N" (
		goto:initq
	)
)
:cloneq
set /p clone="Do you need a new repository [Y/N]? "
if /i "%clone%" == "Y" (
	goto:getLocalRepo
) else (
	if /i not "%clone%" == "N" (
		goto:cloneq
	)
	goto:hasLocalRepo
)
:doneq
echo %repo%>.repo
echo The repository ^(%repo%^) is now the active.
endlocal
cd %origin%
exit /b 0
:hasLocalRepo
set /p repo="Where is your repository located (file-path)? "
goto:doneq
:getLocalRepo
set /p local="Where do you want the repository located (file-path)? "
if not exist "%local%" (
	echo That folder (%local%) does not exist.
	goto:getLocalRepo
)
cd %local%
set repo=%local%^\%named%
echo assuming success ... repo is %repo%.
:scmq
if exist ".scm-git" (
	set /p scm=<.scm-git
	git clone %scm% git-%named%
)
if exist ".scm-svn-branch" (
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
		git checkout %named%
		xcopy .git ..\svn-%named%\.git /s /i /h
		xcopy .gitignore ..\svn-%named%\.gitignore*
		cd ..
		move svn-%named% %named%
		rmdir /s /q git-%named%
		goto:doneq
	) else (
		cd git-%named%
		git checkout %named%
		cd ..
		move git-%named% %named%
		goto:doneq
	)
) 
if exist "svn-%named%" (
	move svn-%named %named%
	goto:doneq
)
echo there was an error processing your repository.
if exist ".repo" (
	del .repo
)
set /p named="Please try again with a new name: "
call setRepo.bat %named%
exit /b 0


	