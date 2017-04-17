param([switch] $force)

$currentDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$installLatestBeta = $false
$installLocalFile = $true
$chocoPackage = 'chocolatey.0.10.5.nupkg'
$currentDirChocoPackage = Join-Path $currentDir $chocoPackage
$localChocoPackage = 'D:\Dropbox\Boxstarter\$chocoPackage'
$nasChocoPackage = '\\nas\Applications\_BoxStarter\External\$chocoPackage'

if ([System.IO.File]::Exists($currentDirChocoPackage)) {
    $chocolateyPackagePath = $currentDirChocoPackage
}
elseif ([System.IO.File]::Exists($localChocoPackage)) {
    $chocolateyPackagePath = $localChocoPackage
}
elseif ([System.IO.File]::Exists($nasChocoPackage)) {
    $chocolateyPackagePath = $nasChocoPackage
}
else {
    $installLocalFile = $false
}

$chocoInstallPath = "$($env:SystemDrive)\ProgramData\Chocolatey\bin"
$env:ChocolateyInstall = "$($env:SystemDrive)\ProgramData\Chocolatey"
$env:Path += ";$chocoInstallPath"

function Install-ChocolateyPackage {
    param (
        [string]$chocolateyPackageFilePath = ''
    )

    if ($chocolateyPackageFilePath -eq $null -or $chocolateyPackageFilePath -eq '') {
        throw "You must specify a local package to run the local install."
    }

    if (!(Test-Path($chocolateyPackageFilePath))) {
        throw "No file exists at $chocolateyPackageFilePath"
    }

    if ($env:TEMP -eq $null) {
        $env:TEMP = Join-Path $env:SystemDrive 'temp'
    }

    $chocTempDir = Join-Path $env:TEMP "chocolatey"
    $tempDir = Join-Path $chocTempDir "chocInstall"

    [System.IO.Directory]::CreateDirectory($tempDir)

    $file = Join-Path $tempDir "chocolatey.zip"
    Copy-Item $chocolateyPackageFilePath $file -Force

    # unzip the package
    Write-Output "Extracting $file to $tempDir..."
    $shellApplication = new-object -com shell.application
    $zipPackage = $shellApplication.NameSpace($file)
    $destinationFolder = $shellApplication.NameSpace($tempDir)
    $destinationFolder.CopyHere($zipPackage.Items(), 0x10)

    # Call chocolatey install
    $toolsFolder = Join-Path $tempDir "tools"
    $chocInstallPS1 = Join-Path $toolsFolder "chocolateyInstall.ps1"

    & $chocInstallPS1

    $chocInstallVariableName = "ChocolateyInstall"
    $chocoPath = [Environment]::GetEnvironmentVariable($chocInstallVariableName)
    if ($chocoPath -eq $null -or $chocoPath -eq '') {
        $chocoPath = 'C:\ProgramData\Chocolatey'
    }

    $chocoExePath = Join-Path $chocoPath 'bin'

    if ($($env:Path).ToLower().Contains($($chocoExePath).ToLower()) -eq $false) {
        $env:Path = [Environment]::GetEnvironmentVariable('Path', [System.EnvironmentVariableTarget]::Machine);
    }
}

if (!(Test-Path $chocoInstallPath) -or $force) {
    # Install Chocolatey
    if ($installLocalFile) {
        Install-ChocolateyPackage $chocolateyPackagePath
    }
    else {
        if ($installLatestBeta) {
            Invoke-Expression ((new-object net.webclient).DownloadString('https://chocolatey.org/installabsolutelatest.ps1'))
        }
        else {
            Invoke-Expression ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
        }
    }

    choco feature enable -n allowGlobalConfirmation

    # Add temporary sources if they are accessable
    if (Test-Path $externalSourceBase) {
        choco source add -n 'External-Temp' -s $externalSource -priority 100
        choco source add -n 'Personal-Temp' -s $personalSource -priority 101
        choco source add -n 'Extensions-Temp' -s $extensionsSource -priority 102

        choco install Chocolatey-Personal -s $personalSource
    }
}