#! /bin/bash
export ANT_HOME="build/cfdistro/ant/"
if [ -z "$1" ]; then
echo "railo-build control script"
OPTIONS="build build-and-test stop-test-server exit"
select opt in $OPTIONS; do
if [ "$opt" = "start" ]; then
	build/cfdistro/ant/bin/ant -f build/build.xml build.start.launch
	exit
elif [ "$opt" = "stop" ]; then
	build/cfdistro/ant/bin/ant -f build/build.xml server.stop
	exit
elif [ "$opt" = "help" ]; then
	echo "usage (skips this prompt): railo-build.sh [start|stop|{target}]"
elif [ "$opt" = "build" ]; then
	/bin/sh build/cfdistro/ant/bin/ant -f build/build.xml build
elif [ "$opt" = "build-and-test" ]; then
	/bin/sh build/cfdistro/ant/bin/ant -f build/build.xml build.and.test
elif [ "$opt" = "stop-test-server" ]; then
	/bin/sh build/cfdistro/ant/bin/ant -f build/build.xml runwar.stop
elif [ "$opt" = "list-targets" ]; then
	build/cfdistro/ant/bin/ant -f build/build.xml help
elif [ "$opt" = "update" ]; then
	build/cfdistro/ant/bin/ant -f build/build.xml project.update
elif [ "$opt" = "exit" ]; then
	exit
else
	#clear
	echo bad option
fi
done
fi
reldir=`dirname $0`
sh $reldir/build/cfdistro/ant/bin/ant -f $reldir/build/build.xml $*
	
	