Set-ExecutionPolicy Unrestricted

# Download and install Chocolatey
$chocoInstallScriptUrl = 'https://raw.githubusercontent.com/The-Running-Dev/Chocolatey-BoxStarter/master/Install/install.choco.ps1'
$chocoInstallScript = Join-Path $env:Temp 'Install.Choco.ps1'
$downloader = New-Object System.Net.WebClient
$downloader.DownloadFile($chocoInstallScriptUrl, $chocoInstallScript)
& $chocoInstallScript

# Add the My-Get source that contains all the packages
choco source add -n='BoxStarter-MyGet' -s 'https://www.myget.org/F/win-boxstarter/api/v2' -priority=1
choco source add -n=Chocolatey -s "https://chocolatey.org/api/v2/" -priority=2

choco install ClipboardFusion
choco install ConEmu
choco install DisplayFusion