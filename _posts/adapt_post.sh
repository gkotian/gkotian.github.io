#!/bin/bash

POST_TO_ADAPT=$1

FILENAME_WITHOUT_EXTN="${POST_TO_ADAPT%.*}"

TARGET_FILE=${PLAY_DIR}/website/travels/_posts/${FILENAME_WITHOUT_EXTN}.md

git mv ${PLAY_DIR}/website/_posts/${POST_TO_ADAPT} $TARGET_FILE

chmod -x $TARGET_FILE

git add $TARGET_FILE
