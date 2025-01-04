@echo off
:menu
cls
echo 1. Add registry key
echo 2. Remove registry key
echo 3. Exit/Cancel
set /p choice=Enter your choice: 
if %choice%==1 goto addkey
if %choice%==2 goto removekey
if %choice%==3 goto cancel
goto menu

:addkey
reg add "HKEY_CURRENT_USER\VB-Audio\VoiceMeeter" /v "code" /t REG_DWORD /d 0x00123456 /f
echo Activation complete
pause
goto menu

:removekey
reg delete "HKEY_CURRENT_USER\VB-Audio\VoiceMeeter" /v "code" /f
echo Deactivation complete
pause
goto menu

:cancel
exit