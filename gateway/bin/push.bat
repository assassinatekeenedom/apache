@ECHO OFF
setlocal
echo message: %1

if '%1%' == '' (
	echo Please provide a message in "quotes" for this commit.
	exit /b 0
)
git status

:pushq
set /p push="Are you sure [Y/N]? "
if /i "%push%"=="Y" (
	git add -A
	git commit -a -m %1%
	git push
) else (
	if /i not "%push%" == "N" ( 		
		goto:pushq
	)
)
endlocal