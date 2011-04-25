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
exec $JAVA_EXE -Xmx200m -jar /workspace/cfdistro/src/cfdistro/lib/jetty-runner-7.2.2.v20101205.jar --port 8088 --path /${distro.name} $* /workspace/cfdistro/src/cfdistro/dist/${distro.name}.war
			