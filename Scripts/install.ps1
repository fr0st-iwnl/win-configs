# Define variables
$repoUrl = "https://github.com/fr0st-iwnl/WinConfigs/archive/refs/heads/master.zip"
$destinationFolder = "$env:USERPROFILE\Desktop\WinConfigs"
$tempZip = "$env:TEMP\WinConfigs.zip"

# Step 1: Download the ZIP file
Write-Host "Downloading the repository..." -ForegroundColor Cyan
Invoke-WebRequest -Uri $repoUrl -OutFile $tempZip

# Step 2: Create the destination folder
if (-Not (Test-Path -Path $destinationFolder)) {
    Write-Host "Creating the destination folder..." -ForegroundColor Cyan
    New-Item -ItemType Directory -Path $destinationFolder | Out-Null
}

# Step 3: Extract the ZIP file
Write-Host "Extracting the repository to Desktop..." -ForegroundColor Cyan
Expand-Archive -Path $tempZip -DestinationPath $destinationFolder -Force

# Step 4: Handle double folder structure
$innerFolder = Get-ChildItem -Path $destinationFolder -Directory | Select-Object -First 1
if ($innerFolder) {
    Write-Host "Fixing folder structure..." -ForegroundColor Yellow
    Move-Item -Path "$($innerFolder.FullName)\*" -Destination $destinationFolder -Force
    Remove-Item -Path $innerFolder.FullName -Recurse -Force
}

# Step 5: Cleanup the temporary ZIP file
Remove-Item -Path $tempZip -Force
Write-Host "Repository downloaded and extracted to $destinationFolder" -ForegroundColor Green
