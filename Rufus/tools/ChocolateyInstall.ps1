$installer          = 'rufus-2.14.exe'
$url                = 'http://rufus.akeo.ie/downloads/rufus-2.14.exe'
$checksum           = 'C1191E6690CBE5D872C3937A4BD352CBFA5178078D6F31C2BC2DCAB9A20F237C'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $env:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/s'
    validExitCodes  = @(0, 1641, 3010)
}

Set-Content -Path ("$installer.gui") -Value $null

Install-CustomPackage $arguments
