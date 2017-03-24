$installer          = 'iTunes6464Setup.exe'
$url                = 'https://secure-appldnld.apple.com/itunes12/031-94939-20170123-014E4004-DF1D-11E6-8CA3-56D3D55B5B9D/iTunes6464Setup.exe'
$checksum           = '46DF29E6EEF6EEB26AFEC49BB3428AEA935EB4C8B4A79C8D1154B86FF3E02B51'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $evn:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    fileType        = 'msi'
    checksumType    = 'sha256'
    silentArgs      = '/qn /norestart'
    validExitCodes  = @(0, 1641, 3010)
}

# Check if the same version of iTunes is already installed
$app = Get-WmiObject -Class Win32_Product | Where-Object {$_.Name -match 'iTunes'}
if ($app -and ([version]$app.Version -ge [version]$arguments['version'])) {
    Write-Output $(
        'iTunes ' + $version + ' or higher is already installed. '
    )
}
else {
    $parameters = Get-Parameters $env:chocolateyPackageParameters
    $arguments['file'] = Get-Installer $arguments

    Get-ChocolateyUnzip @arguments

    $msiFilesList = (Get-ChildItem -Path $arguments['destination'] -Filter '*.msi' | Where-Object {
            $_.Name -notmatch 'AppleSoftwareUpdate*.msi'
        }).Name

    # Loop over each file and install it. iTunes requires all of them to be installed
    foreach ($msiFileName in $msiFilesList) {
        Install-ChocolateyInstallPackage `
      -packageName $msiFileName `
      -fileType $arguments['fileType'] `
      -silentArgs $arguments['silentArgs'] `
      -file (Join-Path $arguments['destination'] $msiFileName) `
      -validExitCodes $arguments['validExitCodes']
    }
}
