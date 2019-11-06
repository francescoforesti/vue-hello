#!/usr/bin/env bash

npm run build

IMAGE_NAME=hello-vue
IMAGE_REPO_BASE=francescoforestiphoopsit
TAG_DATE=`date +%Y%m%d%H%M%S`
docker build -t ${IMAGE_NAME}:${TAG_DATE} -t ${IMAGE_REPO_BASE}/${IMAGE_NAME}:${TAG_DATE} ./
if [ $? -eq 0 ]; then
  printf "Build done! You can push to docker repository with:\ndocker push ${IMAGE_REPO_BASE}/${IMAGE_NAME}:${TAG_DATE}\n"
else
  echo "Build failed!"
fi
