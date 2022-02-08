#!/bin/bash

podman pull docker.io/library/ubuntu:latest

podman build /home/apt-cacher/dockerfiles/apt-cacher -t apt-cacher

exit 0
