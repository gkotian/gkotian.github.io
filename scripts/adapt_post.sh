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

# Substitute the “ or ” characters with a double apostrophe
sed -i 's/“/"/g' ${TARGET_FILE}
sed -i 's/”/"/g' ${TARGET_FILE}

# Delete `<p style="text-align:center;">` lines
sed -i '/^<p style="text-align:center;">$/d' ${TARGET_FILE}

echo "Open '${TARGET_FILE}' and do the following:"
echo "    - remove useless stuff in frontmatter (but keep categories)"
echo "    - remove useless stuff at the end"
echo "    - add blank line after frontmatter"
echo "    - remove '<p>' & '</p>' tags"
echo "    - remove other HTML"
echo "    - add an excerpt"
waitForConfirmation

DATE=$(echo ${FILENAME_WITHOUT_EXTN} | cut -d"-" -f1,2,3)

ARR=(`grep "href=" ${TARGET_FILE} | sed 's|^.*caption="\(.*\)".*href="\(.*\)">.*$|\1ö\2|g' | sed 's|\s|-|g' | sed 's|öhttp| https|g'`)

# 'ARR' will now contain pairs of 'short-name image-url'
# An example pair is:
#     The-Independence-monument https://googs123.files.wordpress.com/2010/03/sam_0533.jpg

TMP_FILE=$(mktemp)

for ((i = 0; i < ${#ARR[@]}; i+=2))
do
    SHORT_NAME=$(echo ${ARR[$i]} | awk '{print tolower($0)}')
    echo "${SHORT_NAME}" >> ${TMP_FILE}
done

echo "Short names written to '${TMP_FILE}'. Edit as necessary, but don't change the order."
waitForConfirmation

# Read the new short names, and replace the existing short names in 'ARR'
# (short names are present in even indices)
i=0
while IFS='' read -r SHORT_NAME || [[ -n "$SHORT_NAME" ]]
do
    ARR[$i]=$SHORT_NAME
    ((i+=2))
done < "${TMP_FILE}"

echo "Downloading images:"
for ((i = 0; i < ${#ARR[@]}; i+=2))
do
    SHORT_NAME=${ARR[$i]}
    IMAGE_URL=${ARR[$i+1]}

    EXTENSION=${IMAGE_URL##*.}
    IMAGE_FILE_NAME=${DATE}-${SHORT_NAME}
    IMAGE_FILE_PATH=${PLAY_DIR}/website/assets/travels/${IMAGE_FILE_NAME}.${EXTENSION}

    curl -o ${IMAGE_FILE_PATH} ${IMAGE_URL} 2> /dev/null

    echo "${IMAGE_FILE_NAME}.${EXTENSION}"
done

echo ""
echo "Post adapted and images downloaded."
echo "Post to edit: ${TARGET_FILE}"

rm -f ${TMP_FILE}
