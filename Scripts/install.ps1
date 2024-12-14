# Define variables
$repoUrl = "https://github.com/fr0st-iwnl/WinConfigs/archive/refs/heads/master.zip"
$destinationFolder = "$env:USERPROFILE\Desktop\WinConfigs"
$tempZip = "$env:TEMP\WinConfigs.zip"

# Step 1: Download the ZIP file
Write-Host "Downloading the repository..." -ForegroundColor Cyan
Invoke-WebRequest -Uri $repoUrl -OutFile $tempZip

# Step 2: Check if the destination folder already exists
if (Test-Path -Path $destinationFolder) {
    Write-Host "Destination folder already exists. Cleaning up..." -ForegroundColor Yellow
    Remove-Item -Path "$destinationFolder\*" -Recurse -Force
} else {
    # Step 3: Create the destination folder if it doesn't exist
    Write-Host "Creating the destination folder..." -ForegroundColor Cyan
    New-Item -ItemType Directory -Path $destinationFolder | Out-Null
}

# Step 4: Extract the ZIP file to the destination folder
Write-Host "Extracting the repository to Desktop..." -ForegroundColor Cyan
Expand-Archive -Path $tempZip -DestinationPath $destinationFolder -Force

# Step 5: Handle double folder structure (if any)
$innerFolder = Get-ChildItem -Path $destinationFolder -Directory | Select-Object -First 1
if ($innerFolder.Name -match "WinConfigs-master") {
    Write-Host "Fixing folder structure..." -ForegroundColor Yellow
    Move-Item -Path "$($innerFolder.FullName)\*" -Destination $destinationFolder -Force
    Remove-Item -Path $innerFolder.FullName -Recurse -Force
}

# Step 6: Cleanup the temporary ZIP file
Remove-Item -Path $tempZip -Force
Write-Host "Repository downloaded and extracted to $destinationFolder" -ForegroundColor Green
