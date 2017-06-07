@ECHO OFF
setlocal
cd src
set JAVA_HOME=C:\Program Files\Java\jdk1.8.0_91
echo @ECHO OFF>sonarBuild.bat
echo echo mvn sonar:sonar^>.sonarBuild.bat>>sonarBuild.bat
echo call .sonarBuild.bat>>sonarBuild.bat
echo del .sonarBuild.bat>>sonarBuild.bat
echo exit /q 0 >>sonarBuild.bat
start sonarBuild.bat
cd ..
endlocal
