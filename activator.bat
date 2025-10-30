@echo off
title VoiceMeeter Utility Tool
color 0A
mode con: cols=80 lines=25

:mainmenu
cls
echo ============================================================
echo                VoiceMeeter Utility Tool
echo ============================================================
echo.
echo  [1] Activate (Add Registry Key)
echo  [2] Deactivate (Remove Registry Key)
echo  [3] Block VoiceMeeter Internet Access (Firewall)
echo  [4] Exit
echo.
set /p choice=Enter your choice [1-4]: 

if "%choice%"=="1" goto addkey
if "%choice%"=="2" goto removekey
if "%choice%"=="3" goto blockfirewall
if "%choice%"=="4" goto exittool
echo.
echo Invalid choice. Please enter 1, 2, 3, or 4.
pause
goto mainmenu

:addkey
cls
echo ============================================================
echo                    Adding Registry Key
echo ============================================================
echo.
reg add "HKEY_CURRENT_USER\VB-Audio\VoiceMeeter" /v "code" /t REG_DWORD /d 0x00123456 /f >nul 2>&1
if %errorlevel%==0 (
    echo Activation complete! Registry key added successfully.
) else (
    echo ERROR: Failed to add registry key.
)
echo.
pause
goto mainmenu

:removekey
cls
echo ============================================================
echo                    Removing Registry Key
echo ============================================================
echo.
reg delete "HKEY_CURRENT_USER\VB-Audio\VoiceMeeter" /v "code" /f >nul 2>&1
if %errorlevel%==0 (
    echo Deactivation complete! Registry key removed successfully.
) else (
    echo ERROR: Failed to remove registry key or it may not exist.
)
echo.
pause
goto mainmenu

:blockfirewall
cls
echo ============================================================
echo           Blocking VoiceMeeter Internet Access
echo ============================================================
echo.

setlocal
set "vm_paths="
set "vm_paths=%ProgramFiles(x86)%\VB\Voicemeeter\voicemeeterpro.exe"
set "vm_paths=%vm_paths%|%ProgramFiles%\VB\Voicemeeter\voicemeeterpro.exe"
set "vm_paths=%vm_paths%|%ProgramFiles(x86)%\VB\Voicemeeter\voicemeeter.exe"
set "vm_paths=%vm_paths%|%ProgramFiles%\VB\Voicemeeter\voicemeeter.exe"

set "blocked=0"
for %%p in (%vm_paths:|= %) do (
    if exist "%%p" (
        echo Blocking %%p ...
        netsh advfirewall firewall add rule name="Block VoiceMeeter (%%~nxp)" ^
        dir=out program="%%p" action=block enable=yes >nul 2>&1
        netsh advfirewall firewall add rule name="Block VoiceMeeter (%%~nxp)" ^
        dir=in program="%%p" action=block enable=yes >nul 2>&1
        set blocked=1
    )
)

if "%blocked%"=="1" (
    echo VoiceMeeter has been blocked from internet access successfully.
) else (
    echo Could not find VoiceMeeter executables in default locations.
    echo Please check your installation path and try again.
)
endlocal
echo.
pause
goto mainmenu

:exittool
cls
echo Exiting VoiceMeeter Utility Tool...
timeout /t 1 >nul
exit
