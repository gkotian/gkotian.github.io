#!/bin/bash

POST_PATH=$1
POST_NAME=`basename $1`

DATE=$(echo ${POST_NAME} | cut -d"-" -f1,2,3)

ARR=(`grep "href=" ${POST_PATH} | sed 's|^.*caption="\(.*\)".*href="\(.*\)">.*$|\1ö\2|g' | sed 's|\s|-|g' | sed 's|öhttp| https|g'`)

# 'ARR' will contain pairs of 'short-name image-url'
# An example pair is:
#     The-Independence-monument https://googs123.files.wordpress.com/2010/03/sam_0533.jpg

for ((i = 0; i < ${#ARR[@]}; i+=2))
do
    SHORT_NAME=$(echo ${ARR[$i]} | awk '{print tolower($0)}')
    IMAGE_URL=${ARR[$i+1]}

    EXTENSION=${IMAGE_URL##*.}
    TARGET_FILE_NAME=${DATE}-${SHORT_NAME}
    TARGET_FILE_PATH=${PLAY_DIR}/website/assets/travels/${TARGET_FILE_NAME}.${EXTENSION}

    curl -o ${TARGET_FILE_PATH} ${ARR[$i+1]} 2> /dev/null

    echo "${TARGET_FILE_NAME}.${EXTENSION}"
done
