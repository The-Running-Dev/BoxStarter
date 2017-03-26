$installer          = 'dotnet-win-x64.1.1.0.exe'
$url                = 'https://download.microsoft.com/download/1/4/1/141760B3-805B-4583-B17C-8C5BC5A876AB/Installers/dotnet-win-x64.1.1.0.exe'
$checksum           = '6F3CE7234A427DFB6280D2C725329F3217B8439DF48CE83C6780E9EFB30AA7F5'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $evn:ChocolateyPackageTitle
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