@ECHO OFF
if "%1"=="" (
	goto:retry
)
echo command prompt title: %1%
title %1%
goto:fin
:retry
echo ERROR: Please provide name you'd like to appear in the title bar of the command prompt (e.g. C:\path\to\standard\this; or "Spaces require quotes; and the quotes do appear, for now...").
:fin