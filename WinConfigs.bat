@echo off
cls
title "WinConfigs v1.5 | made by @fr0st-iwnl"

::========================================================================================================
::
::   Want to customize your script? Feel free to make adjustments!
::
::  # ISSUES
::
::   Have an idea or suggestion? You can share it by creating an issue here:
::   https://github.com/fr0st-iwnl/WinConfigs/issues
::
::  # PULL REQUESTS
::
::   If you'd like to contribute or add something to the script, submit a pull request here:
::   https://github.com/fr0st-iwnl/WinConfigs/pulls
::
::========================================================================================================




::-----------------------------
:: CHECK IF ASCII FILE EXISTS
::-----------------------------
if not exist "ASCII\ascii.txt" (
    echo %COLOR_RED%Error: ASCII file not found. Please extract the files correctly.%COLOR_RESET%
    pause
    exit
)

for /F %%A in ('echo prompt $E ^| cmd') do set "ESC=%%A"

::-------------------
:: COLOR CODES
::-------------------
set "COLOR_RESET=%ESC%[0m"
set "COLOR_GREEN=%ESC%[32m"
set "COLOR_YELLOW=%ESC%[33m"
set "COLOR_RED=%ESC%[31m"
set "COLOR_LIGHT_RED=%ESC%[38;5;217m"
set "COLOR_SLIGHT_RED=%ESC%[38;5;196m"
set "COLOR_LIGHT_CYAN=%ESC%[38;5;159m"
set "COLOR_BLUE=%ESC%[38;2;59;120;255m"
set "COLOR_CYAN=%ESC%[36m"
set "COLOR_LIGHT_YELLOW=%ESC%[38;5;230m"
set "COLOR_WHITE=%ESC%[97m"
set "COLOR_MAGENTA=%ESC%[35m"

::-------------------
:: VERSION CHECK
::-------------------
set "LOCAL_VERSION=1.5"

for /f "delims=" %%i in ('powershell -Command "(Invoke-WebRequest -Uri https://pastebin.com/raw/ikwbpnXd).Content.Trim()"') do set "LATEST_VERSION=%%i"

if "%LOCAL_VERSION%"=="%LATEST_VERSION%" (
    goto main_menu
) else (
    echo %COLOR_LIGHT_YELLOW%A new version is available: %LATEST_VERSION%%COLOR_RESET%.
    echo %COLOR_YELLOW%Your current version is: %LOCAL_VERSION%%COLOR_RESET%.
    echo %COLOR_DARK_RED%Please update the script to the latest version.%COLOR_RESET%
    echo.
    :ask_update
    echo Do you want to download and update to the latest version from GitHub? %COLOR_YELLOW%Y/N%COLOR_RESET%
    set /p install_update="< "
)

if /i "%install_update%"=="y" (
    echo %COLOR_LIGHT_CYAN%Downloading the latest version from GitHub...%COLOR_RESET%
    
    powershell -Command "Invoke-WebRequest -Uri https://github.com/fr0st-iwnl/WinConfigs/archive/refs/heads/master.zip -OutFile WinConfigs.zip"
    
    if exist WinConfigs.zip (
        echo %COLOR_GREEN%ZIP file downloaded successfully.%COLOR_RESET%
        
        powershell -Command "Expand-Archive -Path WinConfigs.zip -DestinationPath . -Force"
        
        echo.
        echo %COLOR_LIGHT_YELLOW%Files after extraction:%COLOR_RESET%
        dir /b /s WinConfigs-master
        echo.
        
        echo %COLOR_CYAN%Preserving user configuration files...%COLOR_RESET%
        
        if exist "Configuration\custom-repos\repos-list.txt" (
            move /y "Configuration\custom-repos\repos-list.txt" "%TEMP%\repos-list-user.txt" >nul
        )
        if exist "Configuration\scoop-packages\packages-list.txt" (
            move /y "Configuration\scoop-packages\packages-list.txt" "%TEMP%\packages-list-user.txt" >nul
        )
        
        echo %COLOR_YELLOW%Removing old files...%COLOR_RESET%
        for %%d in (ASCII Assets Configuration Scripts) do (
            if exist %%d rmdir /s /q %%d
        )
        
        echo %COLOR_LIGHT_CYAN%Moving new files...%COLOR_RESET%
        powershell -Command "Move-Item -Path '.\WinConfigs-master\*' -Destination . -Force"
        
        echo %COLOR_LIGHT_YELLOW%Restoring user configuration files...%COLOR_RESET%
        if exist "%TEMP%\repos-list-user.txt" (
            move /y "%TEMP%\repos-list-user.txt" "Configuration\custom-repos\repos-list.txt" >nul
        )
        if exist "%TEMP%\packages-list-user.txt" (
            move /y "%TEMP%\packages-list-user.txt" "Configuration\scoop-packages\packages-list.txt" >nul
        )
        
        del WinConfigs.zip
        rmdir /s /q WinConfigs-master
        
        echo %COLOR_GREEN%The latest version has been downloaded and installed!%COLOR_RESET%
        echo %COLOR_LIGHT_CYAN%Restarting the script...%COLOR_RESET%
        timeout /t 2 >nul
        
        start "" "%~dp0WinConfigs.bat"
        exit
    ) else (
        echo %COLOR_RED%Failed to download the ZIP file. Please check your network connection.%COLOR_RESET%
        pause
        goto main_menu
    )
) else if /i "%install_update%"=="n" (
    echo %COLOR_YELLOW%Update canceled. Returning to the main menu...%COLOR_RESET%
    pause
    goto main_menu
)



::-------------------
:: MAIN MENU
::-------------------
:main_menu
cls
type ASCII\ascii.txt
echo.
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo %COLOR_BLUE%           MAIN MENU%COLOR_RESET%
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo.
echo %COLOR_GREEN%[1] Package Manager%COLOR_RESET%
echo %COLOR_GREEN%[2] Custom Repositories%COLOR_RESET%
echo %COLOR_CYAN%[3] System Utilities%COLOR_RESET%
echo %COLOR_BLUE%[4] WinUtil%COLOR_RESET%
echo %COLOR_MAGENTA%[5] Tweaks%COLOR_RESET%
echo.
echo %COLOR_LIGHT_RED%[0] Exit%COLOR_RESET%
echo.
set /p choice="< "

if "%choice%"=="1" goto package_manager
if "%choice%"=="2" goto custom_repositories
if "%choice%"=="3" goto system_utilities
if "%choice%"=="4" goto winutil
if "%choice%"=="5" goto tweaks
if "%choice%"=="0" goto exit_script
echo %COLOR_RED%Invalid choice. Please try again.%COLOR_RESET%
pause
goto main_menu


:tweaks
cls
type ASCII\ascii.txt
echo.
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo %COLOR_CYAN%               TWEAKS%COLOR_RESET%
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo.
echo %COLOR_LIGHT_YELLOW%[#] Want more advanced tweaks?%COLOR_RESET% %COLOR_BLUE%Install WinUtil%COLOR_RESET% %COLOR_LIGHT_YELLOW%from the Main Menu!%COLOR_RESET%
echo.
echo %COLOR_GREEN%[1] EdgeRemover - Removes Microsoft Edge%COLOR_RESET%
echo %COLOR_GREEN%[2] Remove Unnecessary Apps%COLOR_RESET%
echo %COLOR_GREEN%[3] MAS - Microsoft Activation Scripts%COLOR_RESET%
echo %COLOR_GREEN%[4] Search Indexing%COLOR_RESET%
echo %COLOR_GREEN%[5] Themes%COLOR_RESET%
echo %COLOR_GREEN%[6] Context Menu%COLOR_RESET%
echo %COLOR_GREEN%[7] Notifications%COLOR_RESET%
echo %COLOR_GREEN%[8] Web Search%COLOR_RESET%
echo %COLOR_RED%[9] Remove Windows Defender%COLOR_RESET%
echo.
echo %COLOR_LIGHT_RED%[0] Back to Main Menu%COLOR_RESET%
echo.
set /p tweaks_choice="< "

if "%tweaks_choice%"=="1" goto remove_edge
if "%tweaks_choice%"=="2" goto remove_unnecessary_apps
if "%tweaks_choice%"=="3" goto mas  
if "%tweaks_choice%"=="4" goto search_indexing
if "%tweaks_choice%"=="5" goto themes
if "%tweaks_choice%"=="6" goto context_menu
if "%tweaks_choice%"=="7" goto notifications
if "%tweaks_choice%"=="8" goto websearch
if "%tweaks_choice%"=="9" goto windows_defender
if "%tweaks_choice%"=="0" goto main_menu
echo %COLOR_RED%Invalid choice. Please try again.%COLOR_RESET%
pause
goto tweaks


::-------------------
:: WINDOWS DEFENDER
::-------------------
:windows_defender
cls
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo %COLOR_CYAN%         WINDOWS DEFENDER%COLOR_RESET%
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo.
echo %COLOR_CYAN% $ Official Repository : https://github.com/ionuttbara/windows-defender-remover%COLOR_RESET%
echo.
echo - [%COLOR_RED%WARNING%COLOR_RESET%] %COLOR_CYAN%This will turn off your antivirus and remove some system processes, making your computer "faster"
echo   but with less protection. It won't ask for permissions when running apps anymore!%COLOR_RESET%
echo.
echo - [%COLOR_GREEN%ALERT%COLOR_RESET%]  %COLOR_CYAN%Only do this if you're sure you know what you're doing! YOU CANNOT TURN IT BACK ON!%COLOR_RESET%
echo.
:ask_windows_defender
set /p USER_INPUT="[1] Do you want to remove WINDOWS DEFENDER? (Y/N): "
if /i "%USER_INPUT%"=="Y" goto confirm_windows_defender
if /i "%USER_INPUT%"=="N" goto tweaks
echo %COLOR_RED%Invalid choice. Please try again.%COLOR_RESET%
goto ask_windows_defender

:confirm_windows_defender
set /p USER_INPUT="[2] Are you sure? (Y/N): "
if /i "%USER_INPUT%"=="Y" goto apply_windows_defender
if /i "%USER_INPUT%"=="N" goto tweaks
echo %COLOR_RED%Invalid choice. Please try again.%COLOR_RESET%
goto confirm_windows_defender

:apply_windows_defender
echo Opening DefenderRemover.exe...

:: Run DefenderRemover.exe from the dynamic path based on script's location
start "" "%~dp0Scripts\DefenderRemover.exe"
goto tweaks


:websearch
cls
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo %COLOR_CYAN%      WEBSEARCH%COLOR_RESET%
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo.
echo %COLOR_GREEN%[1] Enable Web Search%COLOR_RESET%
echo %COLOR_GREEN%[2] Disable Web Search%COLOR_LIGHT_RED% (Recommended)%COLOR_RESET% %COLOR_RESET%
echo.
echo %COLOR_LIGHT_RED%[0] Back to Tweaks%COLOR_RESET%
echo.
set /p web_choice="< "

set web_choice=%web_choice: =%

if "%web_choice%"=="1" goto add_websearch
if "%web_choice%"=="2" goto remove_websearch
if "%web_choice%"=="0" goto tweaks

:: Invalid choice handling
echo %COLOR_RED%Invalid choice. Please try again.%COLOR_RESET%
pause
goto websearch



::-----------------------------------
:: REMOVE WEBSEARCH AND BING SEARCH
::-----------------------------------
:remove_websearch
cls
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo %COLOR_CYAN%   REMOVING WEBSEARCH AND BINGSEARCH%COLOR_RESET%
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo.
echo Removing WebSearch and BingSearch...

powershell -Command "Start-Process cmd.exe -ArgumentList '/c reg add \"HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search\" /v \"AllowSearchToUseLocation\" /t REG_DWORD /d 0 /f && reg add \"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\" /v \"BingSearchEnabled\" /t REG_DWORD /d 0 /f && reg add \"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings\" /v \"IsAADCloudSearchEnabled\" /t REG_DWORD /d 0 /f && reg add \"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings\" /v \"IsDeviceSearchHistoryEnabled\" /t REG_DWORD /d 0 /f && reg add \"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings\" /v \"IsMSACloudSearchEnabled\" /t REG_DWORD /d 0 /f && reg add \"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings\" /v \"SafeSearchMode\" /t REG_DWORD /d 0 /f && reg add \"HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search\" /v \"ConnectedSearchUseWeb\" /t REG_DWORD /d 0 /f && reg add \"HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search\" /v \"DisableWebSearch\" /t REG_DWORD /d 1 /f && reg add \"HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer\" /v \"DisableSearchBoxSuggestions\" /t REG_DWORD /d 1 /f && reg add \"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\" /v \"SearchboxTaskbarMode\" /t REG_DWORD /d 1 /f && reg add \"HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search\" /v \"EnableDynamicContentInWSB\" /t REG_DWORD /d 0 /f && reg add \"HKCU\Software\Microsoft\Windows\CurrentVersion\SearchSettings\" /v \"IsDynamicSearchBoxEnabled\" /t REG_DWORD /d 0 /f' -Verb RunAs"

powershell -Command "Start-Process powershell.exe -ArgumentList '-NoP -NonI -Command Get-AppxPackage -AllUsers Microsoft.BingSearch* ^| Remove-AppxPackage -AllUsers' -Verb RunAs"


:: Wait for a moment before restarting Explorer (adding a delay to make sure it applies)
timeout /t 2 /nobreak >nul

:: Restart Explorer and SearchHost to apply changes
taskkill /f /im explorer.exe >nul 2>&1
taskkill /f /im SearchHost.exe >nul 2>&1
start explorer.exe


echo %COLOR_GREEN%WebSearch and BingSearch has been removed.%COLOR_RESET%
pause
goto tweaks



::-----------------------------------
:: ENABLE WEBSEARCH AND BING SEARCH 
::-----------------------------------
:add_websearch
cls
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo %COLOR_CYAN%   ADD WEBSEARCH AND BINGSEARCH%COLOR_RESET%
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo.
echo Adding WebSearch and BingSearch...

powershell -Command "Start-Process cmd.exe -ArgumentList '/c reg add \"HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search\" /v \"AllowSearchToUseLocation\" /t REG_DWORD /d 1 /f && reg add \"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\" /v \"BingSearchEnabled\" /t REG_DWORD /d 1 /f && reg add \"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings\" /v \"IsAADCloudSearchEnabled\" /t REG_DWORD /d 1 /f && reg add \"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings\" /v \"IsDeviceSearchHistoryEnabled\" /t REG_DWORD /d 1 /f && reg add \"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings\" /v \"IsMSACloudSearchEnabled\" /t REG_DWORD /d 1 /f && reg add \"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings\" /v \"SafeSearchMode\" /t REG_DWORD /d 1 /f && reg add \"HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search\" /v \"ConnectedSearchUseWeb\" /t REG_DWORD /d 1 /f && reg add \"HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search\" /v \"DisableWebSearch\" /t REG_DWORD /d 0 /f && reg add \"HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer\" /v \"DisableSearchBoxSuggestions\" /t REG_DWORD /d 0 /f && reg add \"HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search\" /v \"EnableDynamicContentInWSB\" /t REG_DWORD /d 1 /f && reg add \"HKCU\Software\Microsoft\Windows\CurrentVersion\SearchSettings\" /v \"IsDynamicSearchBoxEnabled\" /t REG_DWORD /d 1 /f' -Verb RunAs"
timeout /t 2 /nobreak >nul

:: Restart Explorer and SearchHost to apply changes
taskkill /f /im explorer.exe >nul 2>&1
taskkill /f /im SearchHost.exe >nul 2>&1
start explorer.exe

echo %COLOR_GREEN%WebSearch and BingSearch has been added.%COLOR_RESET%
pause
goto tweaks



::-------------------
:: REMOVE UNNECESSARY APPS
::-------------------
:remove_unnecessary_apps
cls
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo %COLOR_CYAN%   REMOVE UNNECESSARY APPS%COLOR_RESET%
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo.

:: List of apps to remove
setlocal enabledelayedexpansion
set "APP1=Microsoft 365 Office|Get-AppxPackage -Name Microsoft.MicrosoftOfficeHub"
set "APP2=Microsoft To Do|Get-AppxPackage -Name Microsoft.Todos"
set "APP3=News|Get-AppxPackage -Name Microsoft.BingNews"
set "APP4=Microsoft Teams|Get-AppxPackage *Teams*"
set "APP5=Outlook|Get-AppxPackage *outlook*"
set "APP6=Power Automate|Get-AppxPackage -Name Microsoft.PowerAutomateDesktop"
set "APP7=Quick Assist|Get-AppxPackage -Name MicrosoftCorporationII.QuickAssist"
set "APP8=Solitaire & Casual Games|Get-AppxPackage -Name Microsoft.MicrosoftSolitaireCollection"
set "APP9=Sound Recorder|Get-AppxPackage -Name Microsoft.WindowsSoundRecorder"
set "APP10=Sticky Notes|Get-AppxPackage -Name Microsoft.MicrosoftStickyNotes"
set "APP11=Weather|Get-AppxPackage -Name Microsoft.BingWeather"
set "APP12=Windows Clock|Get-AppxPackage -Name Microsoft.WindowsAlarms"
set "APP13=Xbox Live|Get-AppxPackage -Name Microsoft.Xbox.TCUI"
set "APP14=Feedback Hub|Get-AppxPackage -Name Microsoft.WindowsFeedbackHub"
set "APP15=Camera|Get-AppxPackage -Name Microsoft.WindowsCamera"
set "APP16=Microsoft ClipChamp|Get-AppxPackage *clipchamp*"
set "APP17=Xbox|Get-AppxPackage -Name  Microsoft.XboxApp"
set "APP18=Get Help|Get-AppxPackage -Name Microsoft.GetHelp"
set "APP19=Phone Link|Get-AppxPackage -Name Microsoft.YourPhone"
set "APP20=People|Get-AppxPackage -Name Microsoft.People"
set "APP21=Office OneNote|Get-AppxPackage -Name Microsoft.Office.OneNote"
set "APP22=Skype|Get-AppxPackage -Name Microsoft.SkypeApp"
set "APP23=Mixed Reality Portal|Get-AppxPackage -Name Microsoft.MixedReality.Portal"
set "APP24=Maps|Get-AppxPackage -Name Microsoft.WindowsMaps"
set "APP25=Snip & Sketch|Get-AppxPackage -Name Microsoft.ScreenSketch"
set "APP26=Cortana|Get-AppxPackage -Name Microsoft.549981C3F5F10"
set "APP27=Mail|Get-AppxPackage -Name microsoft.windowscommunicationsapps"
set "APP28=Photos|Get-AppxPackage *photos*"
set "APP29=Bing Search|Get-AppxPackage *bingsearch*"
set "APP30=Dev Home|Get-AppxPackage *devhome*"

:: Display the list of apps
echo Would you like to uninstall these apps?
echo.
for /L %%i in (1,1,30) do (
    for /F "tokens=1,* delims=|" %%A in ("!APP%%i!") do (
        echo %COLOR_LIGHT_CYAN%- %%A%COLOR_RESET%
    )
)
echo.

set /p choice=Enter your choice (Y/N): 
if /i "%choice%"=="y" (
    :: Uninstall all apps
    for /L %%i in (1,1,30) do (
        for /F "tokens=1,* delims=|" %%A in ("!APP%%i!") do (
            powershell -Command "if ((%%B)) { %%B | Remove-AppxPackage }"
            timeout /t 1 > nul
            if %ERRORLEVEL% EQU 0 (
                echo [%COLOR_YELLOW%SUCCESS%COLOR_RESET%] %%A uninstalled successfully!
            ) else (
                echo [%COLOR_RED%ERROR%COLOR_RESET%] %%A could not be uninstalled or was not installed.
            )
        )
    )
    echo %COLOR_GREEN%Uninstallation process completed successfully!%COLOR_RESET%
) else (
    echo %COLOR_RED%Uninstallation canceled.%COLOR_RESET%
)



pause
goto tweaks



::-------------------
:: NOTIFICATIONS
::-------------------
:notifications
cls
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo %COLOR_CYAN%           NOTIFICATIONS%COLOR_RESET%
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo.
echo %COLOR_GREEN%[1] Add Notifications%COLOR_RESET%
echo %COLOR_GREEN%[2] Remove Notifications %COLOR_LIGHT_RED%(Not Recommended)%COLOR_RESET% %COLOR_RESET%
echo.
echo %COLOR_LIGHT_RED%[0] Back to Tweaks%COLOR_RESET%
echo.
set /p notifications_choice="< "

set notification_choice=%notification_choice: =%

if "%notifications_choice%"=="1" goto add_notifications
if "%notifications_choice%"=="2" goto remove_notifications
if "%notifications_choice%"=="0" goto tweaks

:: Invalid choice handling
echo %COLOR_RED%Invalid choice. Please try again.%COLOR_RESET%
pause
goto notifications


::----------------------
:: REMOVE NOTIFICATIONS
::----------------------
:remove_notifications
cls
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo %COLOR_CYAN%   REMOVING NOTIFICATIONS%COLOR_RESET%
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo.
echo Removing Notifications...

:: Run the PowerShell script in a new admin window and close after execution
powershell -Command "Start-Process PowerShell -ArgumentList '-NoProfile', '-ExecutionPolicy Bypass', '-Command', 'if (-not (Test-Path HKCU:\\Software\\Microsoft\\Windows\\CurrentVersion\\PushNotifications)) { New-Item -Path HKCU:\\Software\\Microsoft\\Windows\\CurrentVersion\\PushNotifications -Force | Out-Null; } Set-ItemProperty -Path HKCU:\\Software\\Microsoft\\Windows\\CurrentVersion\\PushNotifications -Name ToastEnabled -Type DWord -Value 0; if (-not (Test-Path HKCU:\\Software\\Microsoft\\Windows\\CurrentVersion\\Notifications\\Settings)) { New-Item -Path HKCU:\\Software\\Microsoft\\Windows\\CurrentVersion\\Notifications\\Settings -Force | Out-Null; } Set-ItemProperty -Path HKCU:\\Software\\Microsoft\\Windows\\CurrentVersion\\Notifications\\Settings -Name NOC_GLOBAL_SETTING_TOASTS_ENABLED -Type DWord -Value 0; Set-ItemProperty -Path HKCU:\\Software\\Microsoft\\Windows\\CurrentVersion\\Notifications\\Settings -Name NOC_GLOBAL_SETTING_NOTIFICATION_BANNERS_ENABLED -Type DWord -Value 0; if (-not (Test-Path HKCU:\\Software\\Policies\\Microsoft\\Windows\\Explorer)) { New-Item -Path HKCU:\\Software\\Policies\\Microsoft\\Windows\\Explorer -Force | Out-Null; } Set-ItemProperty -Path HKCU:\\Software\\Policies\\Microsoft\\Windows\\Explorer -Name DisableNotificationCenter -Type DWord -Value 1' -Verb RunAs"

:: Wait for a moment before restarting Explorer (adding a delay to make sure it applies)
timeout /t 3 /nobreak >nul

:: Restart Explorer to apply the changes (without opening File Explorer)
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe


echo %COLOR_GREEN%Notifications have been removed.%COLOR_RESET%
pause
goto tweaks





::--------------------
:: ADD NOTIFICATIONS
::--------------------
:add_notifications
cls
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo %COLOR_CYAN%   ADD NOTIFICATIONS%COLOR_RESET%
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo.
echo Adding Notifications...

:: Run the PowerShell script in a new admin window and close after execution
powershell -Command "Start-Process PowerShell -ArgumentList '-NoProfile', '-ExecutionPolicy Bypass', '-Command', 'if (-not (Test-Path HKCU:\\Software\\Microsoft\\Windows\\CurrentVersion\\PushNotifications)) { New-Item -Path HKCU:\\Software\\Microsoft\\Windows\\CurrentVersion\\PushNotifications -Force | Out-Null; } Set-ItemProperty -Path HKCU:\\Software\\Microsoft\\Windows\\CurrentVersion\\PushNotifications -Name ToastEnabled -Type DWord -Value 1; if (-not (Test-Path HKCU:\\Software\\Microsoft\\Windows\\CurrentVersion\\Notifications\\Settings)) { New-Item -Path HKCU:\\Software\\Microsoft\\Windows\\CurrentVersion\\Notifications\\Settings -Force | Out-Null; } Set-ItemProperty -Path HKCU:\\Software\\Microsoft\\Windows\\CurrentVersion\\Notifications\\Settings -Name NOC_GLOBAL_SETTING_TOASTS_ENABLED -Type DWord -Value 1; Set-ItemProperty -Path HKCU:\\Software\\Microsoft\\Windows\\CurrentVersion\\Notifications\\Settings -Name NOC_GLOBAL_SETTING_NOTIFICATION_BANNERS_ENABLED -Type DWord -Value 1; if (-not (Test-Path HKCU:\\Software\\Policies\\Microsoft\\Windows\\Explorer)) { New-Item -Path HKCU:\\Software\\Policies\\Microsoft\\Windows\\Explorer -Force | Out-Null; } Set-ItemProperty -Path HKCU:\\Software\\Policies\\Microsoft\\Windows\\Explorer -Name DisableNotificationCenter -Type DWord -Value 0' -Verb RunAs"

:: Wait for a moment before restarting Explorer (adding a delay to make sure it applies)
timeout /t 3 /nobreak >nul

:: Restart Explorer to apply the changes (without opening File Explorer)
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo %COLOR_GREEN%Notifications has been added.%COLOR_RESET%
pause
goto tweaks





::-------------------
:: CONTEXT MENU
::-------------------
:context_menu
cls
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo %COLOR_CYAN%           CONTEXT MENU%COLOR_RESET%
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo.
echo %COLOR_GREEN%[1] Add Container Context Menu%COLOR_RESET%
echo %COLOR_GREEN%[2] Remove Container Context Menu %COLOR_LIGHT_RED%(Recommended)%COLOR_RESET%%COLOR_RESET%
echo.
echo %COLOR_LIGHT_RED%[0] Back to Tweaks%COLOR_RESET%
echo.
set /p context_choice="< "

set context_choice=%context_choice: =%

if "%context_choice%"=="1" goto add_context_menu
if "%context_choice%"=="2" goto remove_context_menu
if "%context_choice%"=="0" goto tweaks

:: Invalid choice handling
echo %COLOR_RED%Invalid choice. Please try again.%COLOR_RESET%
pause
goto context_menu


::-------------------
:: REMOVE CONTEXT MENU
::-------------------
:remove_context_menu
cls
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo %COLOR_CYAN%   REMOVING CONTEXT MENU%COLOR_RESET%
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo.
echo Removing Context Menu...

:: Stop the search task if it's running
reg.exe add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve >nul 2>&1

:: Restart Explorer to apply the changes
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo %COLOR_GREEN%Context Menu has been removed.%COLOR_RESET%
pause
goto tweaks



::-------------------
:: ADD CONTEXT MENU
::-------------------
:add_context_menu
cls
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo %COLOR_CYAN%   ADD CONTEXT MENU%COLOR_RESET%
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo.
echo Adding Context Menu...

:: Stop the search task if it's running
reg.exe delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f >nul 2>&1

:: Restart Explorer to apply the changes
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo %COLOR_GREEN%Context Menu has been added.%COLOR_RESET%
pause
goto tweaks





::-------------------
:: THEMES
::-------------------
:themes
cls
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo %COLOR_CYAN%               THEMES%COLOR_RESET%
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo.
echo %COLOR_GREEN%[1] Lightweight Theme%COLOR_RESET%
echo %COLOR_GREEN%[2] Heavyweight Theme%COLOR_RESET%
echo.
echo %COLOR_LIGHT_RED%[0] Back to Tweaks%COLOR_RESET%
echo.
set /p themes_choice="< "

if "%themes_choice%"=="1" goto lightweight_theme
if "%themes_choice%"=="2" goto heavyweight_theme
if "%themes_choice%"=="0" goto tweaks

:: Invalid choice handling
echo %COLOR_RED%Invalid choice. Please try again.%COLOR_RESET%
pause
goto themes


::-------------------
:: LIGHTWEIGHT THEME
::-------------------
:lightweight_theme
cls
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo %COLOR_CYAN%   LIGHTWEIGHT THEME%COLOR_RESET%
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo.
echo %COLOR_GREEN%- Reduced animations for smoother performance.%COLOR_RESET%
echo %COLOR_GREEN%- Disables Widgets.%COLOR_RESET%
echo %COLOR_GREEN%- Turns OFF Task View.%COLOR_RESET%
echo %COLOR_GREEN%- Turns OFF Learn about this picture.%COLOR_RESET%
echo %COLOR_GREEN%- Turns ON File Extensions.%COLOR_RESET%
echo %COLOR_GREEN%- Taskbar is on the left.%COLOR_RESET%
echo %COLOR_GREEN%- Changed search icon to default.%COLOR_RESET%
echo.
:ask_lightweight
set /p USER_INPUT="Do you want to apply this Lightweight theme? (Y/N): "
if /i "%USER_INPUT%"=="Y" goto apply_lightweight
if /i "%USER_INPUT%"=="N" goto themes
echo %COLOR_RED%Invalid choice. Please try again.%COLOR_RESET%
goto ask_lightweight

:: Apply Lightweight theme settings
:apply_lightweight
echo Applying Lightweight theme settings...

:: Disable Animations
echo %COLOR_LIGHT_CYAN%= Applying animations.%COLOR_RESET%
reg add "HKCU\Control Panel\Desktop" /v "FontSmoothing" /t REG_SZ /d "2" /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "UserPreferencesMask" /t REG_BINARY /d "9012038010000000" /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "DragFullWindows" /t REG_SZ /d "1" /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewAlphaSelect" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "IconsOnly" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAnimations" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewShadow" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "EnableAeroPeek" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "AlwaysHibernateThumbnails" /t REG_DWORD /d "0" /f >nul 2>&1

:: Disable Task View (set "ShowTaskViewButton" to 0)
echo %COLOR_LIGHT_CYAN%= Turning off Task View.%COLOR_RESET%
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d "0" /f >nul 2>&1


:: Disable "Learn about this picture icon"
echo %COLOR_LIGHT_CYAN%= Turning off Learn about this picture..%COLOR_RESET%
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{2cc5ca98-6485-489a-920e-b3e88a6ccce3}" /t REG_DWORD /d 1 /f >nul 2>&1

:: Enable File Extensions
echo %COLOR_LIGHT_CYAN%= Enabling Show File Extensions%COLOR_RESET%
powershell -Command "Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'HideFileExt' -value 0"

:: Hide Search Icon (set "ShowSearchBox" to 0)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSearchBox" /t REG_DWORD /d "0" /f >nul 2>&1

:: Change Taskbar Alignment to Left using PowerShell
echo %COLOR_LIGHT_CYAN%= Changing the Taskbar Alignment to left..%COLOR_RESET%
powershell -Command "Set-ItemProperty -Path 'HKCU:\software\microsoft\windows\currentversion\explorer\advanced' -Name 'TaskbarAl' -Type 'DWord' -Value 0"


:: Change Search Icon to Search (icon only) using PowerShell
echo %COLOR_LIGHT_CYAN%= Changing the Search Icon to icon-only..%COLOR_RESET%
powershell -Command "Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' -Name 'SearchboxTaskbarMode' -Type 'DWord' -Value 1"

:: Remove Widgets (News and interests) using PowerShell
echo %COLOR_LIGHT_CYAN%= Disabling Widgets...%COLOR_RESET%
powershell -Command "Start-Process cmd.exe -ArgumentList '/c reg add \"HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds\" /v EnableFeeds /t REG_DWORD /d 0 /f && reg add \"HKLM\SOFTWARE\Policies\Microsoft\Dsh\" /v AllowNewsAndInterests /t REG_DWORD /d 0 /f' -Verb RunAs"


:: Wait for a moment before restarting Explorer (adding a delay to make sure it applies)
timeout /t 2 /nobreak >nul

:: Restart Explorer and SearchHost to apply changes
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

:: Show success message and notification to restart
echo %COLOR_GREEN%Lightweight theme applied successfully!%COLOR_RESET%
echo.
echo %COLOR_YELLOW%To fully apply animations, you will need to restart your computer or just sign out.%COLOR_RESET%
:: Ask the user if they want to sign out (shutdown.exe /l)
set /p USER_INPUT="Do you want to sign out now for the changes to take effect? (Y/N): "
if /i "%USER_INPUT%"=="Y" goto sign_out
if /i "%USER_INPUT%"=="N" goto themes

:: If user input is anything else, return to the main themes menu
goto themes


::-------------------
:: HEAVYWEIGHT THEME
::-------------------
:heavyweight_theme
cls
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo %COLOR_CYAN%   HEAVYWEIGHT THEME%COLOR_RESET%
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo.
echo %COLOR_GREEN%- Enabled all animations for best appearance.%COLOR_RESET%
echo %COLOR_GREEN%- Enables Widgets.%COLOR_RESET%
echo %COLOR_GREEN%- Turns ON Task View.%COLOR_RESET%
echo %COLOR_GREEN%- Turns OFF Learn about this picture.%COLOR_RESET%
echo %COLOR_GREEN%- Turns ON File Extensions.%COLOR_RESET%
echo %COLOR_GREEN%- Taskbar is centered.%COLOR_RESET%
echo %COLOR_GREEN%- Changed search icon to search box.%COLOR_RESET%
echo.
:ask_heavyweight
set /p USER_INPUT="Do you want to apply this Heavyweight theme? (Y/N): "
if /i "%USER_INPUT%"=="Y" goto apply_heavyweight
if /i "%USER_INPUT%"=="N" goto themes
echo %COLOR_RED%Invalid choice. Please try again.%COLOR_RESET%
goto ask_heavyweight

:: Apply Heavyweight theme settings
:apply_heavyweight
echo Applying Heavyweight theme settings...

:: Set VisualFXSetting to 1 (Best for Appearance) for animations
echo %COLOR_LIGHT_CYAN%= Applying animations.%COLOR_RESET%
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d "1" /f >nul 2>&1
:: Enable Task View (set "ShowTaskViewButton" to 1)
echo %COLOR_LIGHT_CYAN%= Turning on Task View.%COLOR_RESET%
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d "1" /f >nul 2>&1

:: Disable "Learn about this picture icon"
echo %COLOR_LIGHT_CYAN%= Turning off Learn about this picture..%COLOR_RESET%
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{2cc5ca98-6485-489a-920e-b3e88a6ccce3}" /t REG_DWORD /d 1 /f >nul 2>&1

:: Enable File Extensions
echo %COLOR_LIGHT_CYAN%= Enabling Show File Extensions%COLOR_RESET%
powershell -Command "Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'HideFileExt' -value 0"

:: Revert Search Box (set "SearchboxTaskbarMode" to 2 for Search Box)
powershell -Command "Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' -Name 'SearchboxTaskbarMode' -Type 'DWord' -Value 2"

:: Change Taskbar Alignment to Center (set "TaskbarAl" to 1)
echo %COLOR_LIGHT_CYAN%= Changing the Taskbar Alignment to center..%COLOR_RESET%
powershell -Command "Set-ItemProperty -Path 'HKCU:\software\microsoft\windows\currentversion\explorer\advanced' -Name 'TaskbarAl' -Type 'DWord' -Value 1"

:: Enables Widgets
echo %COLOR_LIGHT_CYAN%= Adding Widgets...%COLOR_RESET%
powershell -Command "Start-Process cmd.exe -ArgumentList '/c reg add \"HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds\" /v EnableFeeds /t REG_DWORD /d 1 /f && reg add \"HKLM\SOFTWARE\Policies\Microsoft\Dsh\" /v AllowNewsAndInterests /t REG_DWORD /d 1 /f' -Verb RunAs"

:: Wait for a moment before restarting Explorer (adding a delay to make sure it applies)
timeout /t 2 /nobreak >nul

:: Restart Explorer and SearchHost to apply changes
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

:: Show success message
echo %COLOR_GREEN%Heavyweight theme applied successfully!%COLOR_RESET%
echo.
echo %COLOR_YELLOW%To fully apply animations, you will need to restart your computer or just sign out.%COLOR_RESET%
:: Ask the user if they want to sign out (shutdown.exe /l)
set /p USER_INPUT="Do you want to sign out now for the changes to take effect? (Y/N): "
if /i "%USER_INPUT%"=="Y" goto sign_out
if /i "%USER_INPUT%"=="N" goto themes

:: If user input is anything else, return to the main themes menu
goto themes





::-------------------
:: SEARCH INDEXING
::-------------------
:search_indexing
cls
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo %COLOR_CYAN%         SEARCH INDEXING%COLOR_RESET%
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo.
echo %COLOR_GREEN%[1] Enable Search Indexing%COLOR_RESET%
echo %COLOR_GREEN%[2] Disable Search Indexing %COLOR_LIGHT_RED%(Not Recommended)%COLOR_RESET%%COLOR_RESET%
echo.
echo %COLOR_LIGHT_RED%[0] Back to Tweaks%COLOR_RESET%
echo.
set /p search_choice="< "

set search_choice=%search_choice: =%

if "%search_choice%"=="1" goto enable_search_indexing
if "%search_choice%"=="2" goto disable_search_indexing
if "%search_choice%"=="0" goto tweaks
echo %COLOR_RED%Invalid choice. Please try again.%COLOR_RESET%
pause
goto search_indexing


::-------------------
:: DISABLE SEARCH INDEXING
::-------------------
:disable_search_indexing
cls
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo %COLOR_CYAN%   DISABLING SEARCH INDEXING%COLOR_RESET%
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo.
echo Disabling search indexing...

:: Run the stop and disable command in a new admin Command Prompt window
powershell -Command "Start-Process cmd.exe -ArgumentList '/c sc stop wsearch && sc config wsearch start=disabled' -Verb RunAs"

:: Attempt to terminate SearchApp.exe and SearchHost.exe processes

:: Check and kill SearchApp.exe (used in Windows 10 and some Windows 11 builds)
tasklist | findstr /i "SearchApp.exe" >nul && (
    taskkill /F /IM "SearchApp.exe" >nul 2>&1
)

:: Check and kill SearchHost.exe (used in Windows 11 builds)
tasklist | findstr /i "SearchHost.exe" >nul && (
    taskkill /F /IM "SearchHost.exe" >nul 2>&1
)


echo %COLOR_GREEN%Search indexing has been disabled.%COLOR_RESET%
pause
goto tweaks



::-------------------
:: ENABLE SEARCH INDEXING
::-------------------
:enable_search_indexing
cls
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo %COLOR_CYAN%   ENABLING SEARCH INDEXING%COLOR_RESET%
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo.
echo Enabling search indexing...

:: Run the start and enable command in a new admin Command Prompt window
powershell -Command "Start-Process cmd.exe -ArgumentList '/c sc config wsearch start=delayed-auto && sc start wsearch' -Verb RunAs"

:: Attempt to terminate SearchApp.exe and SearchHost.exe processes

:: Check and kill SearchApp.exe (used in Windows 10 and some Windows 11 builds)
tasklist | findstr /i "SearchApp.exe" >nul && (
    taskkill /F /IM "SearchApp.exe" >nul 2>&1
)

:: Check and kill SearchHost.exe (used in Windows 11 builds)
tasklist | findstr /i "SearchHost.exe" >nul && (
    taskkill /F /IM "SearchHost.exe" >nul 2>&1
)



echo %COLOR_GREEN%Search indexing has been enabled.%COLOR_RESET%
pause
goto tweaks

::-------------------
:: REMOVE MICROSOFT EDGE
::-------------------
:remove_edge
cls
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo %COLOR_CYAN%      REMOVE MICROSOFT EDGE%COLOR_RESET%
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo.
echo %COLOR_YELLOW%Running PowerShell script to remove Microsoft Edge...%COLOR_RESET%

:: Run the PowerShell script from Scripts folder with admin privileges
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File \"%CD%\Scripts\RemoveEdge.ps1\"' -Verb RunAs"

:: Wait for the process to complete
echo %COLOR_GREEN%EdgeRemover script has been executed.%COLOR_RESET%
pause
goto tweaks



::-------------------
:: MAS
::-------------------
:mas
cls
type ASCII\ascii.txt
echo.
echo %COLOR_MAGENTA%********************************************%COLOR_RESET%
echo %COLOR_CYAN%Microsoft Activation Scripts (MAS)%COLOR_RESET%
echo %COLOR_MAGENTA%********************************************%COLOR_RESET%
echo.
echo %COLOR_GREEN%Github: https://github.com/massgravel/Microsoft-Activation-Scripts%COLOR_RESET%
echo.
echo Open-source Windows and Office activator featuring HWID, Ohook, KMS38, and Online KMS activation methods, along with advanced troubleshooting.
echo Would you like to install MAS? %COLOR_YELLOW%Y/N%COLOR_RESET%
set /p mas_confirm="< "
if /i "%mas_confirm%"=="y" (
    echo Installing MAS...
    
    :: Start a new PowerShell window as Administrator and run the MAS install command
    powershell -Command "Start-Process powershell -ArgumentList 'irm \"https://get.activated.win\" | iex' -Verb runAs"
    
    echo %COLOR_GREEN%MAS has been installed.%COLOR_RESET%
) else (
    echo %COLOR_RED%Installation canceled.%COLOR_RESET%
)
pause
goto tweaks

::-------------------
:: WINUTIL
::-------------------
:winutil
cls
type ASCII\ascii.txt
echo.
echo %COLOR_MAGENTA%********************************************%COLOR_RESET%
echo %COLOR_CYAN%WinUtil: Enhance Your Windows Experience%COLOR_RESET%
echo %COLOR_MAGENTA%********************************************%COLOR_RESET%
echo.
echo %COLOR_GREEN%Github: https://github.com/ChrisTitusTech/winutil%COLOR_RESET%
echo.
echo WinUtil installs performance tweaks and useful tools.
echo Would you like to install WinUtil? %COLOR_YELLOW%Y/N%COLOR_RESET%
set /p winutil_confirm="< "
if /i "%winutil_confirm%"=="y" (
    echo Installing WinUtil...
    powershell -Command "Start-Process powershell -ArgumentList 'irm \"https://christitus.com/win\" | iex' -Verb runAs"
    
    echo %COLOR_GREEN%WinUtil has been installed.%COLOR_RESET%
) else (
    echo %COLOR_RED%Installation canceled.%COLOR_RESET%
)
pause
goto main_menu


::-------------------
:: SYSTEM UTILITIES
::-------------------
:system_utilities
cls
type ASCII\ascii.txt
echo.
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo %COLOR_CYAN%       SYSTEM UTILITIES%COLOR_RESET%
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo.
echo %COLOR_GREEN%[1] System Info%COLOR_RESET%
echo %COLOR_GREEN%[2] System Monitor%COLOR_RESET%
echo.
echo %COLOR_LIGHT_RED%[0] Back to Main Menu%COLOR_RESET%
echo.
set /p sys_util_choice="< "

if "%sys_util_choice%"=="1" goto system_info
if "%sys_util_choice%"=="2" goto system_monitor
if "%sys_util_choice%"=="0" goto main_menu
echo %COLOR_RED%Invalid choice. Please try again.%COLOR_RESET%
pause
goto system_utilities






::-------------------
:: PACKAGE MANAGER
::-------------------
:package_manager
cls
type ASCII\ascii.txt
echo.
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo %COLOR_BLUE%      PACKAGE MANAGER MENU%COLOR_RESET%
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo.
echo %COLOR_GREEN%[1] Install Scoop%COLOR_RESET%
echo %COLOR_GREEN%[2] Update Scoop%COLOR_RESET%
echo %COLOR_GREEN%[3] Uninstall Scoop%COLOR_RESET%
echo.
echo %COLOR_CYAN%************* Packages *************%COLOR_RESET%
echo.
echo %COLOR_GREEN%[4] Install Packages%COLOR_RESET%
echo %COLOR_GREEN%[5] Uninstall Packages%COLOR_RESET%
echo.
echo %COLOR_LIGHT_RED%[0] Back to Main Menu%COLOR_RESET%
echo.
set /p pm_choice="< "

if "%pm_choice%"=="1" goto install_scoop
if "%pm_choice%"=="2" goto update_scoop
if "%pm_choice%"=="3" goto uninstall_scoop
if "%pm_choice%"=="4" goto install_packages
if "%pm_choice%"=="5" goto uninstall_packages
if "%pm_choice%"=="0" goto main_menu
echo %COLOR_RED%Invalid choice. Please try again.%COLOR_RESET%
pause
goto package_manager

::-------------------
:: INSTALL SCOOP
::-------------------
:install_scoop
cls
type ASCII\ascii.txt
echo.
echo Installing Scoop...

:: Set execution policy to allow scripts
powershell -Command "Set-ExecutionPolicy RemoteSigned -scope CurrentUser"

:: Install Scoop
powershell -Command "irm get.scoop.sh | iex"

:: Check if Scoop installation succeeded
if errorlevel 1 (
    echo %COLOR_RED%Failed to install Scoop. Please check your internet connection.%COLOR_RESET%
    pause
    goto package_manager
)

:: Indicate success
echo %COLOR_GREEN%Scoop installed successfully!%COLOR_RESET%
echo.
echo %COLOR_YELLOW%RESTARTING SCRIPT TO UPDATE THE PATH FOR SCOOP...%COLOR_RESET%
echo.
powershell -Command "[console]::beep(600, 300)"
:: Wait for a few seconds to show the message
timeout /t 3 > nul

:: Reload the PATH into the current session
set PATH=%PATH%;%USERPROFILE%\scoop\shims

:: Restart the script
start "" "%~f0"
exit

::----------------------
:: INSTALL PACKAGES
::----------------------
:install_packages
cls
type ASCII\ascii.txt
echo.
echo.
echo %COLOR_LIGHT_YELLOW%[#] Want to add more apps? Visit:%COLOR_RESET% %COLOR_BLUE%https://scoop.sh/#/apps%COLOR_RESET%
echo.
echo Checking packages to install from 'Configuration\scoop-packages\packages-list.txt'

if not exist "Configuration\scoop-packages\packages-list.txt" (
    echo %COLOR_RED%Error: The file 'packages-list.txt' was not found in 'Configuration\scoop-packages'.%COLOR_RESET%
    pause
    goto package_manager
)

echo The following packages will be installed:
echo.
for /f "usebackq delims=" %%p in ("Configuration\scoop-packages\packages-list.txt") do (
    echo %COLOR_YELLOW%[+] %%p%COLOR_RESET%
)
echo.

set /p confirm_install=Do you want to proceed with the installation? %COLOR_YELLOW%Y/N%COLOR_RESET% 
if /i not "%confirm_install%"=="y" (
    echo %COLOR_RED%Installation canceled.%COLOR_RESET%
    pause
    goto package_manager
)

cls
type ASCII\ascii.txt
echo.
echo Installing Packages via Scoop...
echo %COLOR_WHITE%Please wait while we install the essentials...%COLOR_RESET%


echo Checking if Git is installed...
powershell -Command "if (-not (Get-Command git -ErrorAction SilentlyContinue)) { exit 1 }"

if errorlevel 1 (
    echo %COLOR_RED%Git is not installed. Installing Git...%COLOR_RESET%
    powershell -Command "scoop install git"
    echo %COLOR_GREEN%Git installed successfully!%COLOR_RESET%
)


powershell -Command "scoop bucket add extras"


for /f "usebackq delims=" %%p in ("Configuration\scoop-packages\packages-list.txt") do (
    echo Installing package: %%p
    powershell -Command "scoop install %%p"
)

echo %COLOR_GREEN%Packages installed successfully!%COLOR_RESET%
pause
goto package_manager


::----------------------
:: UNINSTALL PACKAGES
::----------------------
:uninstall_packages
cls
type ASCII\ascii.txt
echo.
echo %COLOR_MAGENTA%**************************************%COLOR_RESET%
echo %COLOR_RED%          WARNING!%COLOR_RESET%
echo %COLOR_YELLOW%    THIS WILL UNINSTALL THE PACKAGES%COLOR_RESET%
echo %COLOR_MAGENTA%**************************************%COLOR_RESET%
echo.
echo Checking packages to uninstall from 'Configuration\scoop-packages\packages-list.txt'

if not exist "Configuration\scoop-packages\packages-list.txt" (
    echo %COLOR_RED%Error: The file 'packages-list.txt' was not found in 'Configuration\scoop-packages'.%COLOR_RESET%
    pause
    goto package_manager
)

echo The following packages will be uninstalled:
echo.
for /f "usebackq delims=" %%p in ("Configuration\scoop-packages\packages-list.txt") do (
    echo %COLOR_YELLOW%[-] %%p%COLOR_RESET%
)
echo.

set /p confirm_uninstall=Do you want to proceed with the uninstallation? %COLOR_YELLOW%Y/N%COLOR_RESET% 
if /i not "%confirm_uninstall%"=="y" (
    echo %COLOR_RED%Uninstallation canceled.%COLOR_RESET%
    pause
    goto package_manager
)

cls
type ASCII\ascii.txt
echo.
echo Uninstalling Packages via Scoop...
echo %COLOR_WHITE%Please wait while we uninstall the packages...%COLOR_RESET%

for /f "usebackq delims=" %%p in ("Configuration\scoop-packages\packages-list.txt") do (
    echo Uninstalling package: %%p
    powershell -Command "scoop uninstall %%p"
)

echo %COLOR_GREEN%Packages uninstalled successfully!%COLOR_RESET%
pause
goto package_manager



::-------------------
:: UPDATE SCOOP
::-------------------
:update_scoop
cls
type ASCII\ascii.txt
echo.
powershell -Command "scoop update"
pause
goto package_manager


::-------------------
:: UNINSTALL SCOOP
::-------------------
:uninstall_scoop
cls
type ASCII\ascii.txt
echo.
echo %COLOR_YELLOW%Before uninstalling Scoop, all installed Scoop apps must be uninstalled.%COLOR_RESET%
echo %COLOR_CYAN%Would you like to uninstall all Scoop apps first? (Y/N)%COLOR_RESET%
set /p confirm_uninstall_apps="< "

if /i "%confirm_uninstall_apps%"=="y" (
    echo %COLOR_YELLOW%Uninstalling all Scoop apps...%COLOR_RESET%
    powershell -Command "if ((scoop list | Measure-Object).Count -ne 0) { scoop list | ForEach-Object { $_.Name } | ForEach-Object { scoop uninstall $_ } }"
    if errorlevel 1 (
        echo %COLOR_RED%Failed to uninstall some Scoop apps. Please check manually.%COLOR_RESET%
        pause
        goto package_manager
    )
    echo %COLOR_GREEN%All Scoop apps have been uninstalled successfully!%COLOR_RESET%
) else (
    echo %COLOR_RED%Uninstallation canceled. Returning to Package Manager menu.%COLOR_RESET%
    pause
    goto package_manager
)


echo %COLOR_YELLOW%Now uninstalling Scoop itself...%COLOR_RESET%
powershell -Command "scoop uninstall scoop"
if errorlevel 1 (
    echo %COLOR_RED%Failed to uninstall Scoop. Please check manually.%COLOR_RESET%
    pause
    goto package_manager
)
echo %COLOR_GREEN%Scoop uninstalled successfully!%COLOR_RESET%
pause
goto package_manager


::-----------------------
:: CUSTOM REPOSITORIES
::-----------------------
:custom_repositories
cls
type ASCII\ascii.txt
echo.
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo %COLOR_CYAN%       CUSTOM REPOSITORIES%COLOR_RESET%
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo.
echo %COLOR_LIGHT_CYAN%If you want to add a new repository, please create a pull request here:%COLOR_RESET%
echo %COLOR_LIGHT_CYAN%https://github.com/fr0st-iwnl/WinConfigs/pulls%COLOR_RESET%
echo.

setlocal enabledelayedexpansion
set /a counter=0

if not exist "Configuration\custom-repos\repos-list.txt" (
    echo %COLOR_RED%Error: File 'repos-list.txt' not found at 'Configuration\custom-repos\'.%COLOR_RESET%
    pause
    goto main_menu
)

:: Read the repos-list.txt and display options
for /f "tokens=1,2,3,4 delims=#" %%A in (Configuration\custom-repos\repos-list.txt) do (
    set /a counter+=1
    set "repo_url_!counter!=%%A"
    set "repo_name_!counter!=%%B"
    set "repo_dir_!counter!=%%C"
    set "repo_desc_!counter!=%%D"

    echo %COLOR_YELLOW%[!counter!] \\ %%B%COLOR_RESET%
)

echo.
echo %COLOR_LIGHT_RED%[0] Back to Main Menu%COLOR_RESET%
echo.


if %counter%==0 (
    echo %COLOR_RED%No repositories found in 'repos-list.txt'.%COLOR_RESET%
    pause
    goto main_menu
)


set /p repo_choice="< "

if "%repo_choice%"=="0" goto main_menu
if %repo_choice% gtr %counter% (
    echo %COLOR_RED%Invalid choice. Please try again.%COLOR_RESET%
    pause
    goto custom_repositories
)

if %repo_choice% lss 1 (
    echo %COLOR_RED%Invalid choice. Please try again.%COLOR_RESET%
    pause
    goto custom_repositories
)

:: REPOSITORY DETAILS
set "selected_url=!repo_url_%repo_choice%!"
set "selected_name=!repo_name_%repo_choice%!"
set "selected_dir=!repo_dir_%repo_choice%!"
set "selected_desc=!repo_desc_%repo_choice%!"

:: Display repository info and prompt for installation
cls
type ASCII\ascii.txt
echo.
echo %COLOR_CYAN%************************************%COLOR_RESET%
echo %COLOR_GREEN%       !selected_name! Repository%COLOR_RESET%
echo %COLOR_CYAN%************************************%COLOR_RESET%
echo.
echo %COLOR_GREEN%$ Official Repository : !selected_url!%COLOR_RESET%
echo.
echo %COLOR_LIGHT_YELLOW%@ Directory: %USERPROFILE%\%selected_dir%%COLOR_RESET%
echo.
echo %COLOR_LIGHT_CYAN%# !selected_desc!%COLOR_RESET%
echo.
echo %COLOR_YELLOW%Would you like to install it? %COLOR_GREEN%Y/N%COLOR_RESET%
set /p confirm_install="< "
if /i "%confirm_install%"=="y" (
    call :install_repository "!selected_url!" "!selected_name!" "!selected_dir!" "!selected_desc!"
) else (
    echo %COLOR_RED%Installation canceled.%COLOR_RESET%
    pause
)
goto custom_repositories

::-----------------------
:: INSTALL REPOSITORY
::-----------------------
:install_repository
:: Parameters: %1=repo_url, %2=repo_name, %3=install_dir, %4=repo_desc
cls
type ASCII\ascii.txt
echo.
echo %COLOR_CYAN%************************************%COLOR_RESET%
echo %COLOR_GREEN%Installing %~2 Repository%COLOR_RESET%
echo %COLOR_CYAN%************************************%COLOR_RESET%
echo.
echo %COLOR_LIGHT_YELLOW%@ Target Directory: %USERPROFILE%\%~3%COLOR_RESET%
echo.
echo %COLOR_LIGHT_CYAN%# Description: %~4%COLOR_RESET%
echo.
echo %COLOR_YELLOW%Proceeding with installation...%COLOR_RESET%

call :check_git_installed
if errorlevel 1 (
    pause
    goto custom_repositories
)

set "install_dir=%USERPROFILE%\%~3"
if not exist "%install_dir%" (
    echo %COLOR_YELLOW%Target directory does not exist. Creating: %install_dir%%COLOR_RESET%
    mkdir "%install_dir%"
)


echo %COLOR_LIGHT_CYAN%Cloning repository from %~1...%COLOR_RESET%
powershell -Command "cd '%install_dir%' ; git clone %~1"
if errorlevel 1 (
    echo %COLOR_RED%Failed to clone the repository. The repository may already exist, there could be network issues, or the URL may be invalid.%COLOR_RESET%
) else (
    echo %COLOR_GREEN%Repository '%~2' has been installed in %install_dir%!%COLOR_RESET%
)
pause
goto custom_repositories





::-------------------
:: SYSTEM INFO
::-------------------
:system_info
cls
type ASCII\ascii.txt
echo.
call :check_scoop_installed
if errorlevel 1 (
    echo %COLOR_RED%Error:%COLOR_RESET% Scoop is not installed. Please install Scoop to proceed with system info.
    pause
    goto main_menu
)

if not exist "%USERPROFILE%\scoop\apps\fastfetch\current\fastfetch.exe" (
    echo Fastfetch is not installed. Installing Fastfetch now...
    powershell -Command "scoop install fastfetch"
    timeout /t 5 >nul
)

echo.
echo %COLOR_LIGHT_YELLOW%Displaying System Info with Fastfetch...%COLOR_RESET%
echo.
powershell -Command "fastfetch"
pause
goto system_utilities


::-------------------
:: SYSTEM MONITOR
::-------------------
:system_monitor
cls
type ASCII\ascii.txt
echo.
call :check_scoop_installed
if errorlevel 1 (
    echo %COLOR_RED%Error:%COLOR_RESET% Scoop is not installed. Please install Scoop to proceed with system monitor.
    pause
    goto system_utilities
)

if not exist "%USERPROFILE%\scoop\apps\ntop\current\ntop.exe" (
    echo NTop is not installed. Installing NTop now...
    powershell -Command "scoop install ntop"
    timeout /t 5 >nul
)

echo.
echo %COLOR_LIGHT_YELLOW%Displaying System Monitor with NTop...%COLOR_RESET%
echo.
powershell -Command "ntop"
pause
goto system_utilities




::============================================================================
::                                 MISC
::============================================================================


::-----------------------------
:: CHECK IF SCOOP IS INSTALLED
::-----------------------------
:check_scoop_installed
where scoop >nul 2>nul
if errorlevel 1 (
    exit /b 1
) else (
    exit /b 0
)


::---------------------------
:: CHECK IF GIT IS INSTALLED
::---------------------------
:check_git_installed
where git >nul 2>nul
if errorlevel 1 (
    echo %COLOR_RED%Error:%COLOR_RESET% Git is not installed. Please install Git to continue.
    exit /b 1
) else (
    exit /b 0
)


::-------------------
:: EXIT SCRIPT
::-------------------
:exit_script
cls
exit


::-------------------
:: SIGN OUT
::-------------------
:sign_out
echo Signing out...
shutdown.exe /l
goto themes
