 @ECHO OFF
 SET exe=%cd%\ffmpeg.exe

 SET /p "source=Enter Source Directory: "
 SET target=%source%\Converted

 MKDIR "%target%" 2> NULL
 ECHO Outputting to "%target%"
 PAUSE

 PUSHD "%source%" 

 SETLOCAL
 FOR %%F IN (*.*) DO (
  ECHO.
  IF EXIST "%target%\%%F" (
   ECHO File already Converted "%%F"
  ) ELSE (
   ECHO Converting "%%F"
   "%exe%" -loglevel error -stats -nostdin -y -i "%%F" -c:s copy -map 0 -crf 24 "%target%\%%F"
  )
 )
 ENDLOCAL

 POPD

 ECHO.
 ECHO Finished
 PAUSE