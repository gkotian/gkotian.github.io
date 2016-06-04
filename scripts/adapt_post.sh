#!/bin/bash

function waitForConfirmation
{
    echo "Press 'Enter' when done."
    read -s -n 1 C
    while [ -n "$C" ];
    do
        read -s -n 1 C
    done
    echo ""
}

POST_TO_ADAPT=`basename $1`

FILENAME_WITHOUT_EXTN="${POST_TO_ADAPT%.*}"

TARGET_FILE=${PLAY_DIR}/website/travels/_posts/${FILENAME_WITHOUT_EXTN}.md

git mv ${PLAY_DIR}/website/_posts/${POST_TO_ADAPT} ${TARGET_FILE}

# Substitute the ’ character with a single apostrophe
sed -i 's/’/'\''/g' ${TARGET_FILE}

# Delete `<p style="text-align:center;">` lines
sed -i '/^<p style="text-align:center;">$/d' ${TARGET_FILE}

echo "Open '${TARGET_FILE}' and do the following:"
echo "    - remove useless stuff in frontmatter (but keep categories)"
echo "    - remove useless stuff at the end"
echo "    - add blank line after frontmatter"
echo "    - remove '<p>' & '</p>' tags"
echo "    - remove other HTML"
echo "    - add an excerpt"

echo ""
waitForConfirmation

DATE=$(echo ${FILENAME_WITHOUT_EXTN} | cut -d"-" -f1,2,3)

ARR=(`grep "href=" ${TARGET_FILE} | sed 's|^.*caption="\(.*\)".*href="\(.*\)">.*$|\1ö\2|g' | sed 's|\s|-|g' | sed 's|öhttp| https|g'`)

# 'ARR' will contain pairs of 'short-name image-url'
# An example pair is:
#     The-Independence-monument https://googs123.files.wordpress.com/2010/03/sam_0533.jpg

echo "Paste this into the IMAGES_TO_DOWNLOAD array in the image downloader script, and edit the short names as necessary:"
for ((i = 0; i < ${#ARR[@]}; i+=2))
do
    SHORT_NAME=$(echo ${ARR[$i]} | awk '{print tolower($0)}')
    IMAGE_URL=${ARR[$i+1]}
    echo "${SHORT_NAME} ${IMAGE_URL}"
done

echo ""
waitForConfirmation

/home/ubuntu/play/website/scripts/image_downloader.sh ${DATE}
