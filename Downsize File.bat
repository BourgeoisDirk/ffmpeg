@ECHO OFF

set /p "source=Enter Source Path: "
set /p "target=Enter Target Path: "
set /p "quality=Enter Quality Compression (0 to 51, lower is better): "

"..\ffmpeg.exe" -nostdin -y -i %source% -c:s copy -map 0 -crf %quality% %target%

PAUSE  