$arguments          = @{
    file            = 'iTunes6464Setup.exe'
    url             = 'https://secure-appldnld.apple.com/itunes12/031-34005-20150916-98D38F1E-5C11-11E5-A6AD-C05A6DA99CB1/iTunes6464Setup.exe'
    checksum        = 'F1A36984C02DF41A3CFC6B2A2695FC4FAE8B32BB88B4DEF53193870E462A7EF6'
    silentArgs      = '/qn /norestart'
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
