$installer          = 'ConEmuSetup.170326.exe'
$url                = 'https://github.com/Maximus5/ConEmu/releases/download/v17.03.26/ConEmuSetup.170326.exe'
$checksum           = '3868ceaf105c4bc57601396818edd5e1af404161016211b30cb605e143635089'
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
