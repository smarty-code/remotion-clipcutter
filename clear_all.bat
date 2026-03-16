@echo off
:: This script deletes all MP4 files from the chunks and storage directories.

set "CHUNKS_DIR=chunks"
set "STORAGE_DIR=storage"

echo ==========================
echo CLEARING DIRECTORIES
echo ==========================

if exist "%CHUNKS_DIR%" (
    echo Cleaning %CHUNKS_DIR%...
    del /q "%CHUNKS_DIR%\*.mp4" 2>nul
) else (
    echo %CHUNKS_DIR% directory not found.
)

if exist "%STORAGE_DIR%" (
    echo Cleaning %STORAGE_DIR%...
    del /q "%STORAGE_DIR%\*.mp4" 2>nul
) else (
    echo %STORAGE_DIR% directory not found.
)

echo ==========================
echo CLEANUP COMPLETED
echo ==========================

pause
