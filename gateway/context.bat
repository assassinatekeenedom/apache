@ECHO OFF
setlocal
if "%1%" == "" (
	goto:manualcq
) else (
	echo %1 %2 %3>>.static-contexts
	goto:finishq
)
:manualcq
set /p context="What is the URL context you want to intercept? " 
if "%context%" == "" (
	goto:manualcq
)
:routeq
set /p route="Where (relative to the repo root) should this intercept route to (folder path)? " 
if "%route%" == "" (
	goto:routeq
)
:portq
set /p port="What port will you use for this intercept routing? "
if "%port%" == "" (
	goto:portq
)
echo %context% %route% %port%>>.static-contexts
:finishq
endlocal
exit /b 0