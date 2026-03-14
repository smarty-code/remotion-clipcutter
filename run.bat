@echo off

set SEGMENT=20

mkdir chunks
mkdir compressed

echo ==========================
echo STEP 1: SPLITTING VIDEOS
echo ==========================

for %%F in (*.mp4) do (
    echo Splitting %%F ...
    ffmpeg -i "%%F" ^
    -f segment ^
    -segment_time %SEGMENT% ^
    -reset_timestamps 1 ^
    -start_number 1 ^
    -c copy ^
    "chunks\%%~nF.%%d.mp4"
)

echo ==========================
echo STEP 2: COMPRESSING CHUNKS
echo (Running in Parallel)
echo ==========================


echo ==========================
echo ALL TASKS STARTED
echo ==========================

pause