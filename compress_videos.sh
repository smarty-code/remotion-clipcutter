#!/bin/bash

# Configuration
INPUT_DIR="storage"
OUTPUT_DIR="compressed"
CRF=28 # 0-51, lower is better quality/larger size. 28 is a good medium compression.
PRESET="medium" # ultrafast, superfast, veryfast, faster, fast, medium, slow, slower, veryslow

echo "=========================="
echo "STARTING VIDEO COMPRESSION"
echo "=========================="

# Check if input directory exists
if [ ! -d "$INPUT_DIR" ]; then
    echo "Error: Directory '$INPUT_DIR' not found!"
    exit 1
fi

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Process all mp4 files in the input directory
shopt -s nullglob
files=("$INPUT_DIR"/*.mp4)

if [ ${#files[@]} -eq 0 ]; then
    echo "No MP4 files found in '$INPUT_DIR'."
    exit 0
fi

for file in "${files[@]}"; do
    filename=$(basename "$file")
    echo "Compressing $filename..."
    
    ffmpeg -i "$file" -vcodec libx264 -crf $CRF -preset $PRESET -acodec copy "$OUTPUT_DIR/$filename"
done

echo "=========================="
echo "COMPRESSION COMPLETED"
echo "=========================="
