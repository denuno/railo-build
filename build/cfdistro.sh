#! /bin/sh
reldir=`dirname $0`
export ANT_HOME="$reldir/cfdistro/ant/"
/bin/sh $reldir/cfdistro/ant/bin/ant -f $reldir/build.xml $*
		
		