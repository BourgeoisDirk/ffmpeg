@echo off
setlocal enabledelayedexpansion

:: Ask for input folder
set /p "input_folder=Enter the full path to your input folder: "
if "%input_folder:~-1%"=="\" set "input_folder=%input_folder:~0,-1%"

:: Ask ONCE whether to replace originals
echo.
set /p "replace_choice=Do you want to replace the original image files? (Y/N): "
set "replace_choice=!replace_choice:~0,1!"
set "replace_choice=!replace_choice!"

:: Choose output folder once
if /I "!replace_choice!"=="Y" (
    set "output_folder=!input_folder!"
) else (
    set "output_folder=!input_folder!\Converted"
    if not exist "!output_folder!" mkdir "!output_folder!"
)

:: Loop over supported image formats
for %%f in ("%input_folder%\*.jpg") do call :process "%%f" "!output_folder!"
for %%f in ("%input_folder%\*.jpeg") do call :process "%%f" "!output_folder!"
for %%f in ("%input_folder%\*.png") do call :process "%%f" "!output_folder!"
for %%f in ("%input_folder%\*.bmp") do call :process "%%f" "!output_folder!"

echo.
echo All image files processed.
pause
exit /b

:: ---- Subroutine ----
:process
set "input_file=%~1"
set "target_folder=%~2"
set "filename=%~n1"
ffmpeg -y -hide_banner -loglevel error -i "%input_file%" -frames:v 1 -q:v 2 "%target_folder%\%filename%.jpg"
echo Processed: %input_file% → %target_folder%\%filename%.jpg
exit /b

