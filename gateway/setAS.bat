@ECHO OFF
setlocal
if not "%1" == "" (
	echo %1>.as
	echo %2>.as-bin
	echo %~3>.as-exe
	exit /b 0
)
:asqabc
set /p as="Where is your application server's deployment directory; where .war files live (absolute path)? "
if not exist "%as%" do echo That folder does not exist && goto:asqabc
:asqdef
set /p asbin="Where is your application server's bin or executable directory; where the startup script is run (absolute path)? "
if not exist "%asbin%" do echo That folder does not exist && goto:asqdef
:asqghi
set /p asexe="What is the full executable statement you want to run to start your application server? "
if "%asexe%" == "" do goto:asqghi
echo %as%>.as
echo %asbin%>.as-bin
echo %asexe%>.as-exe
endlocal
exit /b 0