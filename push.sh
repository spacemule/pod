#!/bin/bash

SERVER_ROOT=${HOME}/Development/configs/pod/server-files/
rsync -rlptDvz $SERVER_ROOT root@pod.local:/

ssh root@pod.local "echo \"Files owned by root in /home:\" &&  find /home/ -user root -maxdepth 4"

exit 0
