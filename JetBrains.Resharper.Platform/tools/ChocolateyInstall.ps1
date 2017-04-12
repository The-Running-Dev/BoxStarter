$installer          = 'JetBrains.ReSharperUltimate.2016.3.2.exe'
$url                = 'https://download-cf.jetbrains.com/resharper/JetBrains.ReSharperUltimate.2016.3.2.exe'
$checksum           = '81A83904E0AFB1724FF3191941AAE22FFC923538F99F004A1FFA968D09982F52'
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
