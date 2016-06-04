#!/bin/bash

POST_TO_ADAPT=`basename $1`

FILENAME_WITHOUT_EXTN="${POST_TO_ADAPT%.*}"

TARGET_FILE=${PLAY_DIR}/website/travels/_posts/${FILENAME_WITHOUT_EXTN}.md

git mv ${PLAY_DIR}/website/_posts/${POST_TO_ADAPT} $TARGET_FILE

# Substitute the ’ character with a single apostrophe
sed -i 's/’/'\''/g' ${TARGET_FILE}

# Delete `<p style="text-align:center;">` lines
sed -i '/^<p style="text-align:center;">$/d' ${TARGET_FILE}

echo "To do next:"
echo "    - remove useless stuff in frontmatter (but keep categories)"
echo "    - remove useless stuff at the end"
echo "    - add blank line after frontmatter"
echo "    - remove '<p>' & '</p>' tags"
echo "    - remove other HTML"
echo "    - add an excerpt"
echo "    - run the image downloader script"
echo "    - rename downloaded image files if necessary"
echo ""

git status
