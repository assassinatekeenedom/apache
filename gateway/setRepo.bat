@ECHO OFF
setlocal
set origin=%cd%
if not "%1%"=="" (
	set named=%1
	goto:initq
)
:initName
set /p named="What is the name of the branch? "
if "%named%" == "" goto:initName
:initq
set /p clone="Do you need to create this branch [Y/N]? "
if /i "%clone%" == "Y" (
	call .branch.bat %named%
	set repo=%cd%\.branch\%named%
	goto:doneq
) else (
	if /i not "%clone%" == "N" (
		goto:initq
	)
)
:cloneq
set /p clone="Do you need a new copy [Y/N]? "
if /i "%clone%" == "Y" (
	goto:getLocalRepo
) else (
	if /i not "%clone%" == "N" (
		goto:cloneq
	)
	goto:hasLocalRepo
)
:doneq
cd %origin%
echo %repo%>.repo
echo The repository ^(%repo%^) is now the active.
endlocal

exit /b 0
:hasLocalRepo
set /p repo="Where is your local repository located (file-path)? "
goto:doneq
:getLocalRepo
if not exist ".branch" mkdir .branch
cd .branch
if exist "%named%" (
	echo that branch already exists!  delete it, and try again if you like.
	exit /b 0
)
set repo=%cd%^\%named%
:scmq
if exist "..\.scm-git" (
	goto:scmgitq
)
:svnstartq
if exist "..\.scm-svn-branch" (
	goto:scmbranchq
)
if "%scm%" == "" (
	cd ..
	call setSCM.bat
	cd .branch
	goto:scmq
)
:scmgitq
cd ..
set /p scm=<.scm-git
cd .branch
git clone %scm% git-%named%>nul
goto:svnstartq

:scmbranchq
cd ..
set /p scm=<.scm-svn-branch
set /p trunk=<.named
cd .branch
svn co %scm%/%trunk%-%named% %named%>nul

:scmresolveq
if exist "git-%named%" (
	if exist "%named%" (
		cd git-%named%
		git checkout %named%>nul
		xcopy .git ..\%named%\.git /s /i /h /q>nul
		xcopy .gitignore ..\%named%\.gitignore*>nul
		cd ..
		rmdir /s /q git-%named%
		goto:doneq
	) else (
		xcopy git-%named% %named% /s /i /h /q>nul
		rmdir /s /q git-%named%
		cd %named%
		git checkout %named%>nul
		cd ..
		goto:doneq
	)
) 
cd %origin%
echo there was an error processing your repository.
if exist ".repo" (
	del .repo
)
set /p named="Please try again with a new name: "
call setRepo.bat %named%
exit /b 0


	