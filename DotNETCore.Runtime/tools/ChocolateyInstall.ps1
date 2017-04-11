$installer          = 'dotnet-win-x64.1.1.1.exe'
$url                = 'https://download.microsoft.com/download/9/5/1/95198156-644E-4CCE-8DA1-C41F7658510C/dotnet-win-x64.1.1.1.exe'
$checksum           = 'C0B2344526033907B6F2F0BD3FB0F776C9FC1FD20114075BAF987012E2390E36'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $env:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = "/install /quiet /norestart /log ""${env:temp}\$($data.PackageName).log"""
    validExitCodes  = @(0, 1641, 3010)
}

Install-CustomPackage $arguments
