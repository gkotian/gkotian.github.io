#!/bin/bash

POST_TO_ADAPT=$1

FILENAME_WITHOUT_EXTN="${POST_TO_ADAPT%.*}"

TARGET_FILE=${PLAY_DIR}/website/travels/_posts/${FILENAME_WITHOUT_EXTN}.md

git mv ${PLAY_DIR}/website/_posts/${POST_TO_ADAPT} $TARGET_FILE

echo "To do next:"
echo "    - remove useless stuff in frontmatter (but keep categories)"
echo "    - remove useless stuff at the end"
echo "    - add blank line after frontmatter"
echo "    - remove '<p>' & '</p>' tags"
echo "    - remove other HTML"
echo "    - break up long lines"
echo "    - add an excerpt"

cd ~/play/website

git status
