#!/bin/bash

SERVER_ROOT=${HOME}/Development/configs/pod/server-files/
rsync -rlptDvz --exclude "**/home" $SERVER_ROOT root@pod.local:/

while IFS= read -r SERVER_USER
do
	rsync -rlptDvz --exclude "**/nginx/ssl" ${SERVER_ROOT}home/${SERVER_USER}/ ${SERVER_USER}@pod.local:/home/${SERVER_USER}
done < ${HOME}/Development/configs/pod/users

ssh root@pod.local "echo \"Files owned by root in /home:\" &&  find /home/ -user root -maxdepth 4"

exit 0
