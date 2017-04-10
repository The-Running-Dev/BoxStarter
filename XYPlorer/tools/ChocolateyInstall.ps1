$installer            = 'xyplorer_full_noinstall.zip'
$url                  = 'https://www.xyplorer.com/download/xyplorer_full_noinstall.zip'
$checksum             = '170758F2C8D0FAD745CAF6A913F76B1ABA39FE8D99E3EE52EA5BC848511EA9D4'
$arguments            = @{
    packageName       = $env:ChocolateyPackageName
    softwareName      = $env:ChocolateyPackageTitle
    unzipLocation     = Join-Path ${env:ProgramFiles(x86)} 'XYplorer'
    unzipOnly         = $true
    file              = Join-Path $env:ChocolateyPackageFolder $installer
    url               = $url
    checksum          = $checksum
    fileType          = 'zip'
    checksumType      = 'sha256'
    validExitCodes    = @(0, 1641, 3010)
}

Install-CustomPackage $arguments
