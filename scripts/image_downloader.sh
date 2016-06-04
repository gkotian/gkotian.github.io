#!/bin/bash

DATE=$1

IMAGES_TO_DOWNLOAD=(
)

for ((i = 0; i < ${#IMAGES_TO_DOWNLOAD[@]}; i+=2))
do
    SHORT_NAME=${IMAGES_TO_DOWNLOAD[$i]}
    IMAGE_URL=${IMAGES_TO_DOWNLOAD[$i+1]}

    EXTENSION=${IMAGE_URL##*.}
    TARGET_FILE_NAME=${DATE}-${SHORT_NAME}
    TARGET_FILE_PATH=${PLAY_DIR}/website/assets/travels/${TARGET_FILE_NAME}.${EXTENSION}

    curl -o ${TARGET_FILE_PATH} ${IMAGE_URL} 2> /dev/null
done
