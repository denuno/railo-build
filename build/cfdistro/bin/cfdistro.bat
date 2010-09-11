CD /D %~dp0
SET ANT_HOME=..\ant\
call ..\ant\bin\ant.bat -f ..\..\build.xml -Dbasedir="..\..\" %1
REM @ping 127.0.0.1 -n 21 -w 1000 > nul