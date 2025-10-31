 @ECHO OFF
 SET exe=%cd%\ffmpeg.exe

 SET /p "source=Enter Source Directory: "
 SET target=%source%\Converted
 MKDIR "%target%" 2> NULL
 ECHO Outputting to "%target%"
 ECHO.
 ECHO We need a Quality Encoding Value: Scale is 0 to 51, where 0 is lossless, 23 is the default, and 51 is worst quality possible
 SET /p "quality=Enter the Quality Value: "
 PAUSE

 PUSHD "%source%" 

 SETLOCAL
 FOR %%F IN (*.*) DO (
  ECHO.
  IF EXIST "%target%\%%F" (
   ECHO File already Converted "%%F"
  ) ELSE (
   ECHO Converting "%%F"
   "%exe%" -loglevel error -stats -nostdin -y -i "%%F" -c:s copy -map 0 -crf %quality% "%target%\%%F"
  )
 )
 ENDLOCAL

 POPD

 ECHO.
 ECHO Finished
 PAUSE

