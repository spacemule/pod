#!/bin/bash

podman pull docker.io/library/nextcloud:fpm-alpine

podman build /home/nextcloud/dockerfiles/nextcloud -t nextcloud-ffmpeg

exit 0
