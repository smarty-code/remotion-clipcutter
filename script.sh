#!/bin/bash

SEGMENT=20
CHUNKS_DIR="chunks"
OUTPUT_DIR="storage"
BACKGROUND="background.png"

mkdir -p "$CHUNKS_DIR"
mkdir -p "$OUTPUT_DIR"

echo "=========================="
echo "STEP 1: SPLITTING VIDEOS"
echo "=========================="

for file in *.mp4; do
    echo "Splitting $file ..."
    filename=$(basename "$file" .mp4)

    ffmpeg -i "$file" \
        -f segment \
        -segment_time $SEGMENT \
        -reset_timestamps 1 \
        -start_number 1 \
        -c copy \
        "$CHUNKS_DIR/$filename.%d.mp4"
done


echo "=========================="
echo "STEP 2: EDITING CHUNKS"
echo "=========================="

for file in "$CHUNKS_DIR"/*.mp4; do
    name=$(basename "$file")
    title=$(basename "$file" .mp4)

    echo "Editing $name ..."

    ffmpeg -i "$file" -loop 1 -i "$BACKGROUND" \
    -filter_complex "[1:v]scale=1080:1920[bg];[0:v]scale=1400:-2[vid];[bg][vid]overlay=0:500[tmp];[tmp]drawbox=x=0:y=420:w=iw:h=80:color=white@1:t=fill[boxed];[boxed]drawtext=text='$title':fontcolor=black:borderw=2:bordercolor=black:fontsize=48:x=(w-text_w)/2:y=440" \
    -shortest \
    -c:v libx264 \
    -preset veryfast \
    -crf 18 \
    "$OUTPUT_DIR/$name"

done

echo "=========================="
echo "ALL TASKS COMPLETED"
echo "=========================="