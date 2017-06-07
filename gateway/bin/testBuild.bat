@ECHO OFF
setlocal
cd src
set JAVA_HOME=C:\Program Files\Java\jdk1.7.0_80
echo @ECHO OFF>.testBuild.bat
echo call mvn clean org.jacoco:jacoco-maven-plugin:0.7.2.201409121644:prepare-agent install>>.testBuild.bat
echo del .testBuild.bat>>.testBuild.bat
echo exit /b 0 >>.testBuild.bat
start .testBuild.bat
cd ..
endlocal
