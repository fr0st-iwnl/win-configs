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
:: VERSION CHECK
::-------------------
set "LOCAL_VERSION=1.3"

for /f "delims=" %%i in ('powershell -Command "(Invoke-WebRequest -Uri https://pastebin.com/raw/ikwbpnXd).Content.Trim()"') do set "LATEST_VERSION=%%i"

if "%LOCAL_VERSION%"=="%LATEST_VERSION%" (
    goto main_menu
) else (
    echo A new version is available: %COLOR_LIGHT_YELLOW%%LATEST_VERSION%%COLOR_RESET%.
    echo Your current version is: %COLOR_YELLOW%%LOCAL_VERSION%%COLOR_RESET%.
    echo %COLOR_DARK_RED%Please update the script to the latest version.%COLOR_RESET%
    echo.
    :ask_update
    echo Do you want to download and update to the latest version from GitHub? %COLOR_YELLOW%Y/N%COLOR_RESET%
    set /p install_update="< "
)
    if /i "%install_update%"=="y" (
        echo Downloading the latest version from GitHub...
        
        powershell -Command "Invoke-WebRequest -Uri https://github.com/fr0st-iwnl/WinConfigs/archive/refs/heads/master.zip -OutFile WinConfigs.zip"
        
        if exist WinConfigs.zip (
            echo ZIP file downloaded successfully.
            
            powershell -Command "Expand-Archive -Path WinConfigs.zip -DestinationPath . -Force"
            
            echo.
            echo Files after extraction:
            dir /b /s WinConfigs-master
            echo.
            
            echo Removing old files...
            
            for %%d in (ASCII Assets Configuration Scripts) do (
                if exist %%d rmdir /s /q %%d
            )

            echo Moving new files...
            powershell -Command "Move-Item -Path '.\WinConfigs-master\*' -Destination . -Force"
            
            del WinConfigs.zip
            rmdir /s /q WinConfigs-master
            
            echo %COLOR_GREEN%The latest version has been downloaded and installed!%COLOR_RESET%.
            echo Restarting the script...
            timeout /t 2 >nul

            start "" "%~dp0WinConfigs.bat"
            exit
        ) else (
            echo %COLOR_RED%Failed to download the ZIP file. Please check your network connection.%COLOR_RESET%
            pause
            goto main_menu
        )
    ) else if /i "%install_update%"=="n" (
        echo Update canceled. Returning to the main menu...
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
echo %COLOR_YELLOW%[4] WinUtil%COLOR_RESET%
echo.
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
    echo %COLOR_RED%Installation canceled.%COLOR_RESET%
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
powershell -Command "Set-ExecutionPolicy RemoteSigned -scope CurrentUser"
powershell -Command "irm get.scoop.sh | iex"
if errorlevel 1 (
    echo %COLOR_RED%Failed to install Scoop. Please check your internet connection.%COLOR_RESET%
    pause
    goto package_manager
)
echo %COLOR_GREEN%Scoop installed successfully!%COLOR_RESET%
echo.
echo %COLOR_YELLOW%RESTARTING SCRIPT TO MAKE THE SCOOP COMMAND WORK...%COLOR_RESET%
echo.
powershell -Command "[console]::beep(600, 300)"
timeout /t 3 > nul
start "" "%~f0"
exit



::----------------------
:: INSTALL PACKAGES
::----------------------
:install_packages
cls
type ASCII\ascii.txt
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
