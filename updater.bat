@echo off
::setting current version... I want to read a file and check version in it
if exist version.txt (
     set /p version=<version.txt
) else (
     echo 0.1 > version.txt
)
::checking latest version
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://www.dropbox.com/s/pr6hlr0wdgy03yv/version.txt?dl=1', 'version.txt.tmp')"
powershell -Command "Invoke-WebRequest https://www.dropbox.com/s/pr6hlr0wdgy03yv/version.txt?dl=1 -OutFile version.txt.tmp"
set /p nwstvrsn=<version.txt
set nwstvrsn=%nwstvrsn: =%
if %version% lss %nwstvrsn% goto newupdateavailable
if %version%==%nwstvrsn% goto noupdateavailable

:newupdateavailable
::downloading new version if it exists
echo Downloading Update
del version.txt
copy version.tmp.txt version.txt
del version.txt.tmp
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://www.dropbox.com/s/zf7txqtfuqp4330/updater.bat?dl=1', 'version.txt')"
powershell -Command "Invoke-WebRequest https://www.dropbox.com/s/zf7txqtfuqp4330/updater.bat?dl=1 -OutFile version.txt"

:noupdateavailable
echo No Update Available
del version.txt.tmp
::run main program... or do nothing :D


pause
