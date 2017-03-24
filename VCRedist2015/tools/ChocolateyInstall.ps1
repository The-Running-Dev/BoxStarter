$installer          = 'vc_redist.x86.exe'
$url                = 'https://download.microsoft.com/download/6/A/A/6AA4EDFF-645B-48C5-81CC-ED5963AEAD48/vc_redist.x86.exe'
$checksum           = '12A69AF8623D70026690BA14139BF3793CC76C865759CAD301B207C1793063ED'
$arguments          = @{
    packageName     = 'VCRedist2015_x86'
    softwareName    = 'VCRedist2015_x86*'
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/Q /norestart'
    validExitCodes  = @(0, 1641, 3010)
}

Install-LocalOrRemote $arguments

$installerfile      = 'vc_redist.x64.exe'
$url                = 'https://download.microsoft.com/download/6/A/A/6AA4EDFF-645B-48C5-81CC-ED5963AEAD48/vc_redist.x64.exe'
$checksum           = 'DA66717784C192F1004E856BBCF7B3E13B7BF3EA45932C48E4C9B9A50CA80965'
$arguments          = @{
    packageName     = 'VCRedist2015_x64'
    softwareName    = 'VCRedist2015_x64*'
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/Q /norestart'
    validExitCodes  = @(0, 1641, 3010)
}

Install-LocalOrRemote $arguments