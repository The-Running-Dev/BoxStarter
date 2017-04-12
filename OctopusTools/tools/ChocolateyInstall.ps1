$installer          = 'OctopusTools.4.13.13.zip'
$url                = 'https://download.octopusdeploy.com/octopus-tools/4.13.13/OctopusTools.4.13.13.zip'
$checksum           = 'D513F879DC0D1AFF5ED2572FB5203FB85B2FBB1D454807B6FB8FBED30511C5D5'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $env:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    unzipOnly       = $true
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    checksumType    = 'sha256'
    validExitCodes  = @(0, 1641, 3010)
}

Install-CustomPackage $arguments

$env:Path = "$($env:Path);$($env:ChocolateyPackageFolder)"
