# Define the URL for the latest release of Cascadia Code
$fontUrl = "https://github.com/microsoft/cascadia-code/releases/download/v2404.23/CascadiaCode-2404.23.zip"
$zipPath = "$env:TEMP\CascadiaCode.zip"
$extractPath = "$env:TEMP\CascadiaCode"

# Download the zip file
Invoke-WebRequest -Uri $fontUrl -OutFile $zipPath

# Extract the zip file
Expand-Archive -Path $zipPath -DestinationPath $extractPath

# Function to add font
function Add-Font {
    param (
        [string]$Path
    )
    $shell = New-Object -ComObject Shell.Application
    $folder = $shell.Namespace(0x14)
    $folder.CopyHere($Path)
}

# Install the fonts
$fontFiles = Get-ChildItem -Path "$extractPath\ttf" -Filter "CascadiaCodeNF.ttf"
foreach ($fontFile in $fontFiles) {
    $fontFilePath = $fontFile.FullName
    Write-Output "Installing $fontFilePath"
    Add-Font -Path $fontFilePath
}

# Clean up
Remove-Item -Path $zipPath
Remove-Item -Path $extractPath -Recurse

# Install Windows Terminal
winget install --id Microsoft.WindowsTerminal --source msstore

# Ensure WSL is enabled
Write-Host "Enabling WSL..."
wsl --install --no-distribution

# Set WSL version to 2
Write-Host "Setting WSL version to 2..."
wsl --set-default-version 2

# Install Ubuntu 24.04
Write-Host "Installing Ubuntu 24.04 from Microsoft store..."
winget install --id Canonical.Ubuntu.24.04 --source msstore

# Verify installation
Write-Host "Verifying installation..."
$installedDistros = wsl --list --verbose
if ($installedDistros -match "Ubuntu-24.04") {
    Write-Host "Ubuntu 24.04 has been successfully installed on WSL2. Starting..."
    ubuntu2404.exe install
} else {
    Write-Host "There was an issue installing Ubuntu 24.04."
}
