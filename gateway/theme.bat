@ECHO OFF
setlocal
if not "%1%"=="" (
	set theme=%1%
	goto:theme
)
:retry
set /p theme="What is the [name].bat of the theme (e.g. [cloud|error|build|scripts|server|snow][Invert])? "
:theme
call skin\context\%theme%.bat
if not "%1%" == "" ( 
	goto:qtheme 
)
set /p retry="Would you like to start over [Y/N]? "
if /i "%retry%" == "Y" goto:retry
:qtheme
endlocal
