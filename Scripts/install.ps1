# Define variables
$repoUrl = "https://github.com/fr0st-iwnl/WinConfigs/archive/refs/heads/master.zip"
$desktopPath = [System.IO.Path]::Combine($env:USERPROFILE, "Desktop")
$tempZip = "$env:TEMP\WinConfigs.zip"
$iconUrl = "https://raw.githubusercontent.com/fr0st-iwnl/WinConfigs/refs/heads/master/Assets/icon.ico"
$extractedFolder = "$env:LOCALAPPDATA\Temp\WinConfigs"  # Extracted folder location in AppData\Local\Temp
$shortcutPath = "$desktopPath\WinConfigs.lnk"  # Shortcut will be on Desktop

# Step 1: Download the ZIP file
Write-Host "Downloading the repository..." -ForegroundColor Cyan
Invoke-WebRequest -Uri $repoUrl -OutFile $tempZip

# Step 2: Clean up any existing folder in the Temp directory (Force deletion)
if (Test-Path -Path $extractedFolder) {
    Write-Host "Removing old extracted folder..." -ForegroundColor Yellow
    # Attempt to remove the folder and forcefully remove it
    try {
        # Try deleting the folder
        Remove-Item -Path $extractedFolder -Recurse -Force -ErrorAction Stop
    } catch {
        Write-Host "Could not remove existing folder. Trying again..." -ForegroundColor Red
        # If there was an issue, wait for a few seconds and retry
        Start-Sleep -Seconds 3
        Remove-Item -Path $extractedFolder -Recurse -Force -ErrorAction Stop
    }
}

# Step 3: Create the directory for extraction (will recreate if it was deleted)
Write-Host "Creating directory for extraction..." -ForegroundColor Cyan
New-Item -ItemType Directory -Path $extractedFolder -Force | Out-Null

# Step 4: Extract the ZIP file to the specified folder in Temp
Write-Host "Extracting the repository..." -ForegroundColor Cyan
Expand-Archive -Path $tempZip -DestinationPath $extractedFolder -Force

# Step 5: Handle double folder structure (if any)
$innerFolder = Get-ChildItem -Path $extractedFolder -Directory | Select-Object -First 1
if ($innerFolder.Name -match "WinConfigs-master") {
    Write-Host "Fixing folder structure..." -ForegroundColor Yellow
    Move-Item -Path "$($innerFolder.FullName)\*" -Destination $extractedFolder -Force
    Remove-Item -Path $innerFolder.FullName -Recurse -Force
}

# Step 6: Cleanup the temporary ZIP file
Remove-Item -Path $tempZip -Force

# Step 7: Download the icon file to the Assets folder (will overwrite if exists)
Write-Host "Downloading the icon file..." -ForegroundColor Cyan
Invoke-WebRequest -Uri $iconUrl -OutFile "$extractedFolder\Assets\icon.ico"

# Step 8: Create the desktop shortcut (will overwrite if exists)
Write-Host "Creating a desktop shortcut..." -ForegroundColor Cyan
$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut($shortcutPath)

# Set the target to the folder where the files are extracted
$shortcut.TargetPath = $extractedFolder
$shortcut.WorkingDirectory = $extractedFolder
$shortcut.WindowStyle = 1
$shortcut.IconLocation = "$extractedFolder\Assets\icon.ico" # Use the downloaded icon from the extracted folder
$shortcut.Save()

# Step 9: Optional: Remove the extracted folder from Temp if no longer needed (comment out if you want to keep)
# Remove-Item -Path $extractedFolder -Recurse -Force

Write-Host "Repository downloaded, extracted to AppData\Local\Temp, and shortcut created on Desktop." -ForegroundColor Green
