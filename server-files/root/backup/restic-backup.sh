#!/bin/bash

restic -r ${REPO_BASE}${REPO_PATH} unlock
restic -r ${REPO_BASE}${REPO_PATH} --verbose backup ${BACKUP_DIR} ${EXCLUDES}

restic -r ${B2_REPO_BASE}${REPO_PATH} unlock
restic -r ${B2_REPO_BASE}${REPO_PATH} --verbose backup ${BACKUP_DIR} ${EXCLUDES}
sleep 10
restic -r ${B2_REPO_BASE}${REPO_PATH} unlock
restic -r ${B2_REPO_BASE}${REPO_PATH} forget --keep-last 7 --keep-daily 7 --keep-weekly 5 --keep-monthly 6 --keep-yearly 3 --prune

exit 0
