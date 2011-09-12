#! /bin/sh
reldir=`dirname $0`
export ANT_HOME="$reldir/cfdistro/ant/"
props=""
target=$1
shift
for var in "$@"
do
    props="$props -D$var"
done
echo $reldir/cfdistro/ant/bin/ant -f $reldir/build.xml $target $props
/bin/sh $reldir/cfdistro/ant/bin/ant -f $reldir/build.xml $target $props
		