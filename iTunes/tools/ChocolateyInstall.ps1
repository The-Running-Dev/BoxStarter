$installer          = 'iTunes6464Setup.exe'
$url                = 'https://secure-appldnld.apple.com/itunes12/031-34005-20150916-98D38F1E-5C11-11E5-A6AD-C05A6DA99CB1/iTunes6464Setup.exe'
$checksum           = 'f1a36984c02df41a3cfc6b2a2695fc4fae8b32bb88b4def53193870e462a7ef6'
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
