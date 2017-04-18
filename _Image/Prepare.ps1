$ntLitePath = 'C:\Program Files\NTLite\NTLite.exe'
$imageMountDir = 'C:\Users\Boyan\AppData\Local\Temp\NLMount01'
$imageWorkingPath = Join-Path $PSScriptRoot '..\..\..\..\Temp' -Resolve

$pathToWimImage = Join-Path $imageWorkingPath 'Windows 10 Enterprise v1703.2017.04.04\sources\install.wim'

$setupDir = Join-Path $imageMountDir 'Setup'
$boxStarterPublishDir = Join-Path $PSScriptRoot '..\..\..\BoxStarter' -Resolve
$boxStarterProjectDir = Join-Path $PSScriptRoot '..' -Resolve
$appAssociations = Join-Path $PSScriptRoot 'AppAssociations.xml'

if (Test-Path $imageMountDir) {
    # Unmount the image
    dism /Unmount-Wim /MountDir:"$imageMountDir" /discard
}

# Call the BoxStarter cleanup script to remove older version
& $boxStarterProjectDir\_Scripts\push.clean.ps1

# Push the install scripts to th BoxStarter publish directory
& $boxStarterProjectDir\_Scripts\push.install.ps1

# Remove and re-create the mount dir
if (Test-Path $imageMountDir) {
    Remove-Item -Recurse $imageMountDir -Force | Out-Null
}
New-Item -ItemType Directory $imageMountDir -Force | Out-Null

# Mount the windows images
dism /Mount-Wim /WimFile:"$pathToWimImage" /index:1 /MountDir:"$imageMountDir"

# Import the default file associations
dism /Image:"$imageMountDir" /Import-DefaultAppAssociations:"$appAssociations"

# Remove and re-create the setup directory in the mounted image directory
if (Test-Path $setupDir) {
    Remove-Item -Recurse $setupDir -Force | Out-Null
}
New-Item -ItemType Directory $setupDir -Force | Out-Null

# Copy extensions, external packages and the choco install script
Copy-Item "$boxStarterPublishDir\Extensions\**" $setupDir\
Copy-Item "$boxStarterPublishDir\External\**" $setupDir\
Copy-Item "$boxStarterPublishDir\Install\install.choco.ps1" $setupDir\
Copy-Item "$boxStarterProjectDir\_Image\Setup.ps1" $imageWorkingPath\

# Start NTLite
if (Test-Path $ntLitePath) {
    & $ntLitePath
}