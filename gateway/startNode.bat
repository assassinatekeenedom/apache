@ECHO OFF
setlocal
if "%1" == "" goto:nonode
start .startNode.bat "%1" %cd%
goto:nodedone
:nonode
echo Please retry running the script using the following example: startNode.bat [.farm\instance], e.g. startNode.bat A.
:nodedone
endlocal


