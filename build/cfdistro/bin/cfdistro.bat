@echo off
if "%1" == "" goto error
set ANT_HOME=%CD%\..\ant\
call %CD%\..\ant\bin\ant.bat -f %CD%\build.xml %1
goto end
:error
echo usage:
echo cfdistro.bat start
echo cfdistro.bat stop
:end
		
		