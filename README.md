# Remotion Clip Cutter (FFmpeg Batch Workflow)

This project splits `.mp4` videos into short chunks and renders each chunk into a vertical format with a background and title overlay.

It uses a Windows batch script (`run.bat`) powered by FFmpeg.

## What It Does

1. Scans the project folder for `.mp4` input videos.
2. Splits each video into 20-second chunks.
3. Renders each chunk onto a 1080x1920 background.
4. Adds a white title bar + chunk name text.
5. Writes edited clips to `storage/`.

## Project Structure

```text
.
|- run.bat
|- background.png
|- chunks/
`- storage/
```

## Requirements

- Windows
- FFmpeg installed and available in PATH

## Quick Start

1. Put one or more source `.mp4` files in the project root.
2. Ensure `background.png` exists in the project root.
3. Double-click `run.bat` (or run it from CMD/PowerShell).
4. Check outputs in `storage/`.

## How It Works

- Chunk duration is controlled by `SEGMENT` in `run.bat` (default: `20` seconds).
- Split chunks are created in `chunks/`.
- Edited vertical clips are created in `storage/`.
- Title text is automatically derived from chunk filename.

## Notes

- Existing files in `chunks/` and `storage/` may be overwritten if names collide.
- Keep source media files out of git history if they are large.
- `.gitignore` already excludes generated chunk/output videos.

## Troubleshooting

- `ffmpeg is not recognized`: install FFmpeg and restart terminal.
- No output in `storage/`: verify source videos are in root and `background.png` exists.
- Text render issues: ensure FFmpeg build supports `drawtext` filter.

## License

Use this project according to your own licensing policy for source media and generated clips.