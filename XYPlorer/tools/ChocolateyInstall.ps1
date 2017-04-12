$installer            = 'xyplorer_full_noinstall.zip'
$url                  = 'https://www.xyplorer.com/download/xyplorer_full_noinstall.zip'
$checksum             = '1221906C44485F0446B32BEBC7AF6C9F08A20672EF2D4787C09BC5C1744BC21F'
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
