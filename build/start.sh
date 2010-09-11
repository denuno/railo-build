#start script
if test -n "${JAVA_HOME}"; then
  if test -z "${JAVA_EXE}"; then
    JAVA_EXE=$JAVA_HOME/bin/java
  fi
fi
 
if test -z "${JAVA_EXE}"; then
  JAVA_EXE=java
fi
cd $(dirname $0)
#exec $JAVA_EXE -jar ./lib/jetty-runner-7.0.0.RC5.jar $* > /dev/null 2>&1 &
exec $JAVA_EXE -Xmx200m -jar /workspace/railo-build/build/cfdistro/lib/jetty-runner-7.1.0.v20100505.jar --port 8181 --path / $* /workspace/railo-build/build/temp/railo-build.war
	