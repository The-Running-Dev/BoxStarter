$installer          = 'JetBrains.ReSharperUltimate.2016.3.2.exe'
$url                = 'https://download-cf.jetbrains.com/resharper/JetBrains.ReSharperUltimate.2016.3.2.exe'
$checksum           = '81a83904e0afb1724ff3191941aae22ffc923538f99f004a1ffa968d09982f52'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $env:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    executable      = $installer
    url             = $url
    checksum        = $checksum
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/VsVersion=14.0;15.0 /SpecificProductNames=dotCover;dotMemory;dotPeek;dotTrace;ReSharperCpp;teamCityAddin;ReSharper /Silent=True'
    validExitCodes  = @(0, 1641, 3010)
}

Install-CustomPackage $arguments