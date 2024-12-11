@echo off
cls


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
:: VERSION
::-------------------
set "LOCAL_VERSION=1.0"

for /f "delims=" %%i in ('powershell -Command "(Invoke-WebRequest -Uri https://pastebin.com/raw/ikwbpnXd).Content"') do set "LATEST_VERSION=%%i"

if "%LOCAL_VERSION%"=="%LATEST_VERSION%" (
    goto main_menu
) else (
    echo A new version is available: %COLOR_LIGHT_YELLOW%%LATEST_VERSION%%COLOR_RESET%. 
    echo Your current version is: %COLOR_YELLOW%%LOCAL_VERSION%%COLOR_RESET%.
    echo %COLOR_DARK_RED%Please update the script to the latest version.%COLOR_RESET%
    echo.
    :ask_update
    echo Do you want to download and install the latest version from GitHub? %COLOR_YELLOW%Y/N%COLOR_RESET%
    set /p install_update="< "
)
    if /i "%install_update%"=="y" (
        :: Download and Install the latest version
        echo Downloading the latest version from GitHub...
        powershell -Command "Invoke-WebRequest -Uri https://raw.githubusercontent.com/fr0st-iwnl/WinConfigs/master/WinConfigs.bat -OutFile WinConfigs.bat"
        echo Latest version has been downloaded and installed.
        echo Restarting the script...
        timeout /t 2 >nul
        call WinConfigs.bat
    ) else if /i "%install_update%"=="n" (
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
echo %COLOR_YELLOW%[4] WinUtil%COLOR_RESET%
echo %COLOR_LIGHT_RED%[0] Exit%COLOR_RESET%
echo.
set /p choice="< "

if "%choice%"=="1" goto package_manager
if "%choice%"=="2" goto custom_repositories
if "%choice%"=="3" goto system_utilities
if "%choice%"=="4" goto winutil
if "%choice%"=="0" goto exit_script
echo %COLOR_RED%Invalid choice. Please try again.%COLOR_RESET%
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
:: WINUTIL
::-------------------
:winutil
cls
type ASCII\ascii.txt
echo.
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo %COLOR_CYAN%WinUtil: Enhance Your Windows Experience%COLOR_RESET%
echo %COLOR_MAGENTA%************************************%COLOR_RESET%
echo.
echo %COLOR_WHITE%Github: https://github.com/ChrisTitusTech/winutil%COLOR_RESET%
echo.
echo WinUtil installs performance tweaks and useful tools.
echo Would you like to install WinUtil? %COLOR_YELLOW%Y/N%COLOR_RESET%
set /p winutil_confirm="< "
if /i "%winutil_confirm%"=="y" (
    echo Installing WinUtil...
    powershell -Command "If (-NOT (Test-Path 'HKCU:\Software\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell')) { Exit 1 }"
    if errorlevel 1 (
        echo %COLOR_RED%Error:%COLOR_RESET% PowerShell is not running as Administrator. Please run as Administrator.
        pause
        goto main_menu
    )
    powershell -Command "Start-Process powershell -ArgumentList 'irm \"https://christitus.com/win\" | iex' -Verb runAs"
    echo %COLOR_GREEN%WinUtil has been installed.%COLOR_RESET%
) else (
    echo Installation canceled.
)
pause
goto main_menu


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
echo %COLOR_GREEN%[2] Install Packages%COLOR_RESET%
echo %COLOR_GREEN%[3] Update Scoop%COLOR_RESET%
echo %COLOR_GREEN%[4] Uninstall Scoop%COLOR_RESET%
echo %COLOR_LIGHT_RED%[0] Back to Main Menu%COLOR_RESET%
echo.
set /p pm_choice="< "

if "%pm_choice%"=="1" goto install_scoop
if "%pm_choice%"=="2" goto install_packages
if "%pm_choice%"=="3" goto update_scoop
if "%pm_choice%"=="4" goto uninstall_scoop
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
powershell -Command "Set-ExecutionPolicy RemoteSigned -scope CurrentUser"
powershell -Command "irm get.scoop.sh | iex"
echo %COLOR_GREEN%Scoop installed successfully!%COLOR_RESET%
pause
goto package_manager


::-------------------
:: INSTALL PACKAGES
::-------------------
:install_packages
cls
type ASCII\ascii.txt
echo.
echo Installing Packages via Scoop...
echo %COLOR_WHITE%Please wait while we install the essentials...%COLOR_RESET%
powershell -Command "scoop bucket add extras"
powershell -Command "scoop install git"
powershell -Command "scoop install nodejs"
echo %COLOR_GREEN%Packages installed successfully!%COLOR_RESET%
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
powershell -Command "scoop uninstall scoop"
pause
goto package_manager


::-------------------
:: CUSTOM REPOSITORIES
::-------------------
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
echo %COLOR_YELLOW%[1] \\ Wallz [https://github.com/fr0st-iwnl/wallz]%COLOR_RESET%
echo %COLOR_YELLOW%[2] \\ WinMacros [https://github.com/fr0st-iwnl/WinMacros]%COLOR_RESET%
echo %COLOR_YELLOW%[3] \\ XPicker [https://github.com/fr0st-iwnl/XPicker]%COLOR_RESET%
echo %COLOR_LIGHT_RED%[0] Back to Main Menu%COLOR_RESET%
echo.
set /p repo_choice="< "

if "%repo_choice%"=="1" goto install_wallz
if "%repo_choice%"=="2" goto install_winmacros
if "%repo_choice%"=="3" goto install_xpicker
if "%repo_choice%"=="0" goto main_menu
echo %COLOR_RED%Invalid choice. Please try again.%COLOR_RESET%
pause
goto custom_repositories


::-------------------
:: INSTALL WALLZ
::-------------------
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
echo Would you like to install it? %COLOR_YELLOW%Y/N%COLOR_RESET%
set /p wallz_confirm="< "
if /i "%wallz_confirm%"=="y" (
    echo Installing Wallz repository...
    powershell -Command "cd $env:USERPROFILE\Pictures; git clone https://github.com/fr0st-iwnl/wallz.git"
    echo %COLOR_GREEN%Wallz repository has been installed to your Pictures folder.%COLOR_RESET%
) else (
    echo Installation canceled.
)
pause
goto custom_repositories


::-------------------
:: INSTALL WINMACROS
::-------------------
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
echo Would you like to install it? %COLOR_YELLOW%Y/N%COLOR_RESET%
set /p winmacros_confirm="< "
if /i "%winmacros_confirm%"=="y" (
    echo Installing WinMacros repository...
    powershell -Command "cd $env:USERPROFILE\Documents; git clone https://github.com/fr0st-iwnl/WinMacros.git"
    echo %COLOR_GREEN%WinMacros repository has been installed to your Documents folder.%COLOR_RESET%
) else (
    echo Installation canceled.
)
pause
goto custom_repositories


::-------------------
:: INSTALL XPICKER
::-------------------
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
echo Would you like to install it? %COLOR_YELLOW%Y/N%COLOR_RESET%
set /p xpicker_confirm="< "
if /i "%xpicker_confirm%"=="y" (
    echo Installing XPicker repository...
    powershell -Command "cd $env:USERPROFILE\Documents; git clone https://github.com/fr0st-iwnl/XPicker.git"
    echo %COLOR_GREEN%XPicker repository has been installed to your Documents folder.%COLOR_RESET%
) else (
    echo Installation canceled.
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
