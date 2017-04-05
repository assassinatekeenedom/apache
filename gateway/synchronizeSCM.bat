@ECHO OFF
setlocal
:synchrepoq
if not exist ".repo" call setRepo.bat && goto:synchrepoq
:synchscmq
if exist ".scm-git" (
set git=Y
)else if not exist ".scm-svn-branch" call setSCM.bat && goto:synchscmq
if exist ".scm-svn-trunk" set svn=Y
set /p repo=<.repo
set origin=%cd%
set /p named=<.us
cd %repo%
:svnupdateq
if "%svn%"=="Y" (
	goto:svncontrolq
)
:gitstartq
if "%git%"=="Y" (
	goto:gitcontrolq
)
:synchfinishq
set /p reask="Anything to add/commit to svn now [Y/N]? "
if /i "%reask%" == "Y" (
	goto:svnandquit
) else if /i not "%reask%" == "N" goto:synchfinishq
:synchstopq
cd %origin%
endlocal
exit /b 0
:svncontrolq
svn status
set /p svnupdate="svn update [Y/N]? "
if /i "%svnupdate%" == "Y" (
	svn update
	svn status
) else if /i not "%commit%" == "N" goto:svncontrolq
:svncommitq
set /p commit="svn add and commit [Y/N]? "
if /i "%commit%" == "Y" goto:svnmsgq
if /i not "%commit% == "N" goto:svncommitq
goto:gitstartq
:svnandquit
set stop=Y
:svnmsgq
set /p svnmessage="log message: %named% - "
if "%svnmessage%" == "" goto:svnmsgq
	svn add --force * --auto-props --parents --depth infinity -q
	svn commit -m "%named% - %svnmessage%"
	svn status
if not defined stop goto:gitstartq
goto:synchstopq
:gitcontrolq
git status
:gitpullq
set /p gitpull="git pull [Y/N]? "
if /i "%gitpull%" == "Y" (
	git pull
) else if /i not "%gitpull%" == "N" goto:gitpullq
:gitpushq
set /p push="git [add -A|commit -a -m|push -u] [Y/N]? "
if /i "%push%" == "Y" (
	goto:gitmsgq
)  else if /i not "%push%" == "N" goto:gitpushq
goto:synchfinishq
:gitmsgq
set /p gitmessage="%named% - "
if "%gitmessage%" == "" goto:gitmsgq
git add -A
get commit -a -m "%named% - %gitmessage%"
git push
goto:synchfinishq