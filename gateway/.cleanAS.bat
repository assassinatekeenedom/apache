@ECHO OFF
setlocal
set jboss = ""
if not exist ".as" (
	call setAS.bat
)
set /p jboss=<.as
set odxp=%cd%
cd %jboss%
if not "%1%"=="" (
	del %1
	goto:cleanfinishq
)
:cleanmoreq
dir /d
set /p more="Do you have more files to delete? "
if /i "%more%" == "Y" (
	goto:cleanpatternq
) else (
	if /i not "%more%" == "N" ( 		
		goto:cleanmoreq
	)
	goto:cleanfinishq
)
:cleanpatternq
set /p clean="What file pattern do you want to delete? "
if "%clean%" == "" goto:cleanmoreq
echo deleting "%clean%" at "%cd%"
del %clean%
goto:cleanmoreq

:cleanfinishq
cd %odxp%
endlocal
exit /b 0