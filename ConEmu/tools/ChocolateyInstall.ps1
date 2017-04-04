$installer          = 'ConEmuSetup.170402.exe'
$url                = 'https://github.com/Maximus5/ConEmu/releases/download/v17.04.02/ConEmuSetup.170402.exe'
$checksum           = 'E45D38BA862B0798A59E19A050CD0A9DCC7567DE7CC2E79627303AC597CA6CDE'
$os                 = if (IsSystem32Bit) { 'x86' } else { 'x64' }
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $env:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = "/p:$os /quiet /norestart"
    validExitCodes  = @(0, 1641, 3010)
}

Install-CustomPackage $arguments
