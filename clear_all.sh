#!/bin/bash

# This script deletes all MP4 files from the chunks and storage directories.

CHUNKS_DIR="chunks"
STORAGE_DIR="storage"

echo "=========================="
echo "CLEARING DIRECTORIES"
echo "=========================="

if [ -d "$CHUNKS_DIR" ]; then
    echo "Cleaning $CHUNKS_DIR..."
    rm -f "$CHUNKS_DIR"/*.mp4 2>/dev/null
else
    echo "$CHUNKS_DIR directory not found."
fi

if [ -d "$STORAGE_DIR" ]; then
    echo "Cleaning $STORAGE_DIR..."
    rm -f "$STORAGE_DIR"/*.mp4 2>/dev/null
else
    echo "$STORAGE_DIR directory not found."
fi

echo "=========================="
echo "CLEANUP COMPLETED"
echo "=========================="
