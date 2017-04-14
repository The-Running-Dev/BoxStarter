$installer          = 'mysql-workbench-community-6.3.9-winx64.msi'
$url                = 'https://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community-6.3.9-winx64.msi'
$checksum           = 'FA93CFF0124F65E94DAC4749A4C2BCDF5F79E1ECAE3777E5D276B4D5491B7FC5'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $env:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    fileType        = 'msi'
    checksumType    = 'sha256'
    silentArgs      = "/quiet /norestart /l*v `"$($env:TEMP)\$($env:ChocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
    validExitCodes  = @(0, 1641, 3010)
}

Install-CustomPackage $arguments
