#!/bin/bash
export DOCKER_IMAGE_NAME=datadog/twui
export DOCKER_IMAGE_VERSION=0.2

../../scripts/docker-build-image.sh
