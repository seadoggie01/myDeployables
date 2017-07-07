rem Stop all commands from printing
@echo off

rem Setting current version if version.txt exists
if exist version.txt (

     rem Set variable 'version' equal to the text in version.txt
     set /p version=<version.txt

) else (

     rem Else create it with asumed lowest version
     echo 0.1 > version.txt
)

rem Downloading latest version(.txt) (currently on dropbox, but I hope to use github here as well...)
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://www.dropbox.com/s/pr6hlr0wdgy03yv/version.txt?dl=1', 'version.txt.tmp')"
powershell -Command "Invoke-WebRequest https://www.dropbox.com/s/pr6hlr0wdgy03yv/version.txt?dl=1 -OutFile version.txt.tmp"

rem Get the text of version.txt and store it in newestVersion
set /p newestVersion=<version.txt
set newestVersion=%newestVersion: =%
rem If version is less than the newestVersion go to the label 
if %version% lss %nwstvrsn% goto newUpdateAvailable
goto noUpdateAvailable

:newUpdateAvailable
rem downloading new version if it exists
echo Downloading Update
del version.txt
copy version.tmp.txt version.txt
del version.txt.tmp

rem download another file from dropbox
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://www.dropbox.com/s/zf7txqtfuqp4330/updater.bat?dl=1', 'version.txt')"
powershell -Command "Invoke-WebRequest https://www.dropbox.com/s/zf7txqtfuqp4330/updater.bat?dl=1 -OutFile version.txt"

rem go to the end of the file
goto eof

:noUpdateAvailable
echo No Update Available
del version.txt.tmp

rem eof-end of file
:eof

rem make "Press any key to continue..." show up
pause

rem this is where I would call the main function (that gets updated) and run it
