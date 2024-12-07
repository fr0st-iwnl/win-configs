@echo off
cls

for /F %%A in ('echo prompt $E ^| cmd') do set "ESC=%%A"

:: color codes
set "COLOR_RESET=%ESC%[0m"
set "COLOR_GREEN=%ESC%[32m"
set "COLOR_YELLOW=%ESC%[33m"
set "COLOR_RED=%ESC%[31m"
set "COLOR_BLUE=%ESC%[38;2;59;120;255m"
set "COLOR_CYAN=%ESC%[36m"
set "COLOR_LIGHTERYELLOW=%ESC%[38;5;230m"

:main_menu
cls
type ASCII\ascii.txt
echo.
:: Pause here so the user can see the banner

echo MAIN MENU
echo =====================
echo [1] Package Manager
echo [2] System Info
echo [3] System Monitor
echo [4] Custom Repositories
echo [5] WinUtil
echo [6] Exit
echo.
set /p choice="Enter your choice: "

if "%choice%"=="1" goto package_manager
if "%choice%"=="2" goto system_info
if "%choice%"=="3" goto system_monitor
if "%choice%"=="4" goto custom_repositories
if "%choice%"=="5" goto winutil
if "%choice%"=="6" goto exit_script
echo Invalid choice. Please try again.
pause
goto main_menu

:winutil
cls
type ASCII\ascii.txt
echo.
echo %COLOR_CYAN%Github: https://github.com/ChrisTitusTech/winutil%COLOR_RESET%
echo.
echo %COLOR_CYAN%WinUtil - A utility to enhance your Windows experience%COLOR_RESET%
echo ========================================================
echo WinUtil is a script that installs useful Windows utilities to help enhance your Windows experience.
echo These utilities include performance tweaks, helpful tools, and other improvements.
echo Would you like to install WinUtil? (y/n)
set /p winutil_confirm="Enter your choice: "
if /i "%winutil_confirm%"=="y" (
    echo Installing WinUtil...
    :: Check if PowerShell is running as admin
    powershell -Command "If (-NOT (Test-Path 'HKCU:\Software\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell')) { Exit 1 }"
    if errorlevel 1 (
        echo %COLOR_RED%Error:%COLOR_RESET% PowerShell is not running as Administrator. Please run the script as an Administrator.
        pause
        goto main_menu
    )
    echo Installing WinUtil via PowerShell...

    :: Corrected method to run PowerShell as Admin and execute the script
    powershell -Command "Start-Process powershell -ArgumentList 'irm \"https://christitus.com/win\" | iex' -Verb runAs"
    echo WinUtil has been installed.
) else (
    echo Installation canceled.
)
pause
goto main_menu


:package_manager
cls
type ASCII\ascii.txt
echo.
echo PACKAGE MANAGER MENU
echo =====================
echo [1] Install Scoop
echo [2] Install Packages
echo [3] Update Scoop
echo [4] Uninstall Scoop
echo [5] Back to Main Menu
echo.
set /p pm_choice="Enter your choice: "

if "%pm_choice%"=="1" goto install_scoop
if "%pm_choice%"=="2" goto install_packages
if "%pm_choice%"=="3" goto update_scoop
if "%pm_choice%"=="4" goto uninstall_scoop
if "%pm_choice%"=="5" goto main_menu
echo Invalid choice. Please try again.
pause
goto package_manager

:install_scoop
cls
type ASCII\ascii.txt
echo.
echo Installing Scoop...
powershell -Command "Set-ExecutionPolicy RemoteSigned -scope CurrentUser"
powershell -Command "irm get.scoop.sh | iex"
echo Scoop installed successfully!
pause
goto package_manager

:install_packages
cls
type ASCII\ascii.txt
echo.
echo Installing Packages via Scoop...
echo Please wait while we install the essentials...
powershell -Command "scoop bucket add extras"
powershell -Command "scoop install git"
powershell -Command "scoop install nodejs"
echo Packages installed successfully!
pause
goto package_manager

:update_scoop
cls
type ASCII\ascii.txt
echo.
powershell -Command "scoop update"
pause
goto package_manager

:uninstall_scoop
cls
type ASCII\ascii.txt
echo.
powershell -Command "scoop uninstall scoop"
pause
goto package_manager

:custom_repositories
cls
type ASCII\ascii.txt
echo.
echo %COLOR_CYAN%CUSTOM REPOSITORIES%COLOR_RESET%
echo =====================
echo [1] %COLOR_YELLOW%\\ Wallz [https://github.com/fr0st-iwnl/wallz]%COLOR_RESET%
echo [2] %COLOR_YELLOW%\\ WinMacros [https://github.com/fr0st-iwnl/WinMacros]%COLOR_RESET%
echo [3] %COLOR_YELLOW%\\ XPicker [https://github.com/fr0st-iwnl/XPicker]%COLOR_RESET%
echo [4] Back to Main Menu
echo.
set /p repo_choice="Enter your choice: "

if "%repo_choice%"=="1" goto install_wallz
if "%repo_choice%"=="2" goto install_winmacros
if "%repo_choice%"=="3" goto install_xpicker
if "%repo_choice%"=="4" goto main_menu
echo Invalid choice. Please try again.
pause
goto custom_repositories

:install_wallz
cls
type ASCII\ascii.txt
echo.
echo %COLOR_CYAN%Wallz Repository%COLOR_RESET%
echo This repository provides curated wallpapers with powerful download automation.
call :check_git_installed
if errorlevel 1 (
    pause
    goto custom_repositories
)
echo Would you like to install it? (y/n)
set /p wallz_confirm="Enter your choice: "
if /i "%wallz_confirm%"=="y" (
    echo Installing Wallz repository...
    powershell -Command "cd $env:USERPROFILE\Pictures; git clone https://github.com/fr0st-iwnl/wallz.git"
    echo Wallz repository has been installed to your Pictures folder.
) else (
    echo Installation canceled.
)
pause
goto custom_repositories

:install_winmacros
cls
type ASCII\ascii.txt
echo.
echo %COLOR_CYAN%WinMacros Repository%COLOR_RESET%
echo This repository provides powerful macros to enhance productivity on Windows.
call :check_git_installed
if errorlevel 1 (
    pause
    goto custom_repositories
)
echo Would you like to install it? (y/n)
set /p winmacros_confirm="Enter your choice: "
if /i "%winmacros_confirm%"=="y" (
    echo Installing WinMacros repository...
    powershell -Command "cd $env:USERPROFILE\Documents; git clone https://github.com/fr0st-iwnl/WinMacros.git"
    echo WinMacros repository has been installed to your Documents folder.
) else (
    echo Installation canceled.
)
pause
goto custom_repositories


:install_xpicker
cls
type ASCII\ascii.txt
echo.
echo %COLOR_CYAN%XPicker Repository%COLOR_RESET%
echo This repository contains a Slim color picker made in AutoHotkey. 
call :check_git_installed
if errorlevel 1 (
    pause
    goto custom_repositories
)
echo Would you like to install it? (y/n)
set /p xpicker_confirm="Enter your choice: "
if /i "%xpicker_confirm%"=="y" (
    echo Installing XPicker repository...
    powershell -Command "cd $env:USERPROFILE\Documents; git clone https://github.com/fr0st-iwnl/XPicker.git"
    echo XPicker repository has been installed to your Documents folder.
) else (
    echo Installation canceled.
)
pause
goto custom_repositories

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

:: Check if Fastfetch is installed by looking for fastfetch.exe in the scoop apps directory
if not exist "%USERPROFILE%\scoop\apps\fastfetch\current\fastfetch.exe" (
    echo Fastfetch is not installed. Installing Fastfetch now...
    powershell -Command "scoop install fastfetch"
    timeout /t 5 >nul
)

:: Display system info with Fastfetch
echo.
echo %COLOR_LIGHTERYELLOW%Displaying System Info with Fastfetch...%COLOR_RESET%
echo.
powershell -Command "fastfetch"
pause
goto main_menu


:system_monitor
cls
type ASCII\ascii.txt
echo.
call :check_scoop_installed
if errorlevel 1 (
    echo %COLOR_RED%Error:%COLOR_RESET% Scoop is not installed. Please install Scoop to proceed with system monitor.
    pause
    goto main_menu
)

:: Check if Fastfetch is installed by looking for fastfetch.exe in the scoop apps directory
if not exist "%USERPROFILE%\scoop\apps\ntop\current\ntop.exe" (
    echo NTop is not installed. Installing NTop now...
    powershell -Command "scoop install ntop"
    timeout /t 5 >nul
)

:: Display system info with Fastfetch
echo.
echo %COLOR_LIGHTERYELLOW%Displaying System Monitor with NTop...%COLOR_RESET%
echo.
powershell -Command "ntop"
pause
goto main_menu




:check_scoop_installed
where scoop >nul 2>nul
if errorlevel 1 (
    exit /b 1
) else (
    exit /b 0
)

:check_git_installed
where git >nul 2>nul
if errorlevel 1 (
    echo %COLOR_RED%Error:%COLOR_RESET% Git is not installed. Please install Git to continue.
    exit /b 1
) else (
    exit /b 0
)

:exit_script
cls
echo Bye :c
pause
exit
