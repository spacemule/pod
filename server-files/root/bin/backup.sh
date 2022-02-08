#!/bin/bash

source /root/backup/db.env

podman pull registry.opensuse.org/home/spacemule/branches/opensuse/templates/images/tumbleweed/containers/restic

su -lc - nextcloud 'podman exec -u 82 nextcloud-php sh -c "/var/www/html/occ maintenance:mode --on"'

rsync --delete -av --exclude "*.log" /home/dmz/html/ /home/dmz/html-backup

su -lc - nextcloud 'podman exec mariadb bash -c "mysqldump -h localhost --single-transaction --default-character-set=utf8mb4 -uroot -p'${MYSQL_ROOT}' nextcloud" > /home/nextcloud/nextcloud/sql.bak'

su -lc - nextcloud 'podman exec -u 82 nextcloud-php sh -c "/var/www/html/occ maintenance:mode --off"'

systemctl --machine=lytics@.host --user stop pod-lytics.service
systemctl --machine=noah@.host   --user stop pod-paperless.service

podman run -v /home/:/backup/home:ro \
	   -v restic-cache:/root/.cache \
	   -v /root/backup/restic-backup.sh:/restic.sh:ro \
	   -v /root/backup/excludes:/excludes:ro \
	   --env-file /root/backup/restic.env \
	   --rm \
	   --hostname nextcloud-restic \
	   registry.opensuse.org/home/spacemule/branches/opensuse/templates/images/tumbleweed/containers/restic

systemctl --machine=lytics@.host --user start pod-lytics.service
systemctl --machine=noah@.host   --user start pod-paperless.service

exit 0
