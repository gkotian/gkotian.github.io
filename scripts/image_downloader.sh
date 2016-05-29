#!/bin/bash

DATE=2010-02-20

IMAGES_TO_DOWNLOAD=(
floating-church https://googs123.files.wordpress.com/2010/02/sam_0399.jpg
crocodile-farm https://googs123.files.wordpress.com/2010/02/sam_0407.jpg
tonle-sap-lake https://googs123.files.wordpress.com/2010/02/sam_0401.jpg
begging-boats https://googs123.files.wordpress.com/2010/02/sam_0393.jpg
bucket-boy https://googs123.files.wordpress.com/2010/02/sam_0395.jpg
lotus-field https://googs123.files.wordpress.com/2010/02/sam_0416.jpg
kids-at-lotus-field https://googs123.files.wordpress.com/2010/02/sam_0423.jpg
)

for ((i = 0; i < ${#IMAGES_TO_DOWNLOAD[@]}; i+=2))
do
    TARGET_FILE=${PLAY_DIR}/website/assets/travels/${DATE}-${IMAGES_TO_DOWNLOAD[$i]}.jpg
    curl -o ${TARGET_FILE} ${IMAGES_TO_DOWNLOAD[$i+1]}
done
