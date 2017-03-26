$installer          = 'ConEmuSetup.170305.exe'
$url                = 'https://github.com/Maximus5/ConEmu/releases/download/v17.03.05/ConEmuSetup.170305.exe'
$checksum           = '323450F87F24CCAF1B30D9E5794C87F5CEEE4DA699C0EDE73BD8EE869BD92455'
$os                 = if (IsSystem32Bit) { 'x86' } else { 'x64' }
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $evn:ChocolateyPackageTitle
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