@echo off
setlocal EnableDelayedExpansion

set SEGMENT=20
set CHUNKS_DIR=chunks
set OUTPUT_DIR=storage
set BACKGROUND=background.png

if not exist "%CHUNKS_DIR%" mkdir "%CHUNKS_DIR%"
if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

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
    "%CHUNKS_DIR%\%%~nF.%%d.mp4"
)

echo ==========================
echo STEP 2: EDITING CHUNKS
echo ==========================

for %%F in ("%CHUNKS_DIR%\*.mp4") do (
    echo Editing %%~nxF ...
    set "TITLE=%%~nF"
    set "TITLE=!TITLE:\=\\!"
    set "TITLE=!TITLE:'=\''!"
    set "TITLE=!TITLE::=\:!"
    ffmpeg -i "%%F" -loop 1 -i "%BACKGROUND%" -filter_complex "[1:v]scale=1080:1920[bg];[0:v]scale=1400:-2[vid];[bg][vid]overlay=0:500[tmp];[tmp]drawbox=x=0:y=420:w=iw:h=80:color=white@1:t=fill[titlebg];[titlebg]drawtext=text='!TITLE!':fontcolor=black:borderw=2:bordercolor=black:fontsize=48:x=(w-text_w)/2:y=440[withtitle];[withtitle]drawbox=x=0:y=340:w=iw:h=80:color=white@1:t=fill:enable='between(t,15,20)'[commbg];[commbg]drawtext=text='Comment Link to get full video':fontcolor=black:fontsize=40:x=(w-text_w)/2:y=360:enable='between(t,15,20)'" -shortest -c:v libx264 -preset veryfast -crf 18 "%OUTPUT_DIR%\%%~nxF"
)

echo ==========================
echo ALL TASKS COMPLETED
echo ==========================

pause