@echo off
setlocal

:menu
cls
echo 1. Add registry key
echo 2. Remove registry key
echo 3. Exit/Cancel
set /p choice=Enter your choice: 

if "%choice%"=="1" goto addkey
if "%choice%"=="2" goto removekey
if "%choice%"=="3" goto cancel
goto menu

:addkey
echo Activating VoiceMeeter settings...

rem Set activation code
reg add "HKEY_CURRENT_USER\VB-Audio\VoiceMeeter" ^
    /v "code" /t REG_DWORD /d 0x00123456 /f

rem Create DelayedStartS key and set default value to 0
reg add "HKEY_CURRENT_USER\VB-Audio\VoiceMeeter\DelayedStartS" ^
    /ve /t REG_DWORD /d 0 /f

echo Activation complete
pause
goto menu

:removekey
echo Removing VoiceMeeter settings...

rem Remove activation code
reg delete "HKEY_CURRENT_USER\VB-Audio\VoiceMeeter" ^
    /v "code" /f

rem Remove DelayedStartS key entirely
reg delete "HKEY_CURRENT_USER\VB-Audio\VoiceMeeter\DelayedStartS" /f

echo Deactivation complete
pause
goto menu

:cancel
endlocal
exit
