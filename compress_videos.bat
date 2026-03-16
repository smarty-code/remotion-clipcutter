@echo off
setlocal EnableDelayedExpansion

:: Configuration
set "INPUT_DIR=storage"
set "OUTPUT_DIR=compressed"
set "CRF=28"
set "PRESET=medium"

echo ==========================
echo STARTING VIDEO COMPRESSION
echo ==========================

:: Check if input directory exists
if not exist "%INPUT_DIR%" (
    echo Error: Directory '%INPUT_DIR%' not found!
    goto :eof
)

:: Create output directory
if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

:: Flag to check if any files were processed
set "FILES_FOUND=0"

:: Process all mp4 files in the input directory
for %%F in ("%INPUT_DIR%\*.mp4") do (
    set "FILES_FOUND=1"
    echo Compressing %%~nxF...
    
    ffmpeg -i "%%F" -vcodec libx264 -crf %CRF% -preset %PRESET% -acodec copy "%OUTPUT_DIR%\%%~nxF"
)

if "%FILES_FOUND%"=="0" (
    echo No MP4 files found in '%INPUT_DIR%'.
)

echo ==========================
echo COMPRESSION COMPLETED
echo ==========================

pause
