@echo off
set ANT_HOME=%CD%\build\cfdistro\ant\
if "%1" == "" goto MENU
call build\cfdistro\ant\bin\ant.bat -f build/build.xml %*
goto end
:MENU
cls
echo.
echo       railo-build menu
REM echo       usage: ${disstro.name}.bat [start|stop|{target}]
echo.
echo       1. Build Railo from Source in GitHub
echo       2. Build and launch
echo       3. Run a specific target
echo       4. Exit
echo.
set choice=
set /p choice=      Enter option 1, 2, 3 or 4: 
echo.
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' goto buildRailo
if '%choice%'=='2' goto buildRailoRun
if '%choice%'=='3' goto runTarget
if '%choice%'=='4' goto end
::
echo.
echo.
echo "%choice%" is not a valid option - try again
echo.
pause
goto MENU
::
:buildRailo
cls
call build\cfdistro\ant\bin\ant.bat -f build/build.xml build
goto end
::
:buildRailoRun
cls
call build\cfdistro\ant\bin\ant.bat -f build/build.xml build.and.test
goto end
::
:listTargets
call build\cfdistro\ant\bin\ant.bat -f build/build.xml help
echo       press any key ...
pause > nul
goto MENU
::
:updateProject
call build\cfdistro\ant\bin\ant.bat -f build/build.xml project.update
echo       press any key ...
pause > nul
goto MENU
::
:runTarget
set target=
set /p target=      Enter target name:
if not '%target%'=='' call build\cfdistro\ant\bin\ant.bat -f build/build.xml %target%
echo       press any key ...
pause > nul
goto MENU
::
:end
set choice=
echo       press any key ...
pause
REM EXIT
	
	
