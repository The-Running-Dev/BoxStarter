$installer          = 'VMware-workstation-full-12.5.4-5192485.exe'
$url                = 'https://download3.vmware.com/software/wkst/file/VMware-workstation-full-12.5.4-5192485.exe'
$checksum           = '79B88AA10A9CCD010D0FAF23F563CAA18F1BD6DDF2BA3F08CB0F92FBEA369B6D'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $evn:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/s /nsr /v/qn EULAS_AGREED=1'
    validExitCodes  = @(0, 1641, 3010)
}

Install-LocalOrRemote $arguments