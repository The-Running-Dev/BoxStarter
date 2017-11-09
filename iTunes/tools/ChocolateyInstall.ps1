$arguments          = @{
    url             = 'https://secure-appldnld.apple.com/itunes12/091-30751-20171030-2E96FF02-B9B4-11E7-81C5-9CE3DF1CD815/iTunes64Setup.exe'
    checksum        = '8708406EBF6D8250D1979141ADFF14E7FE656C90C91E61107BAAE64AF623B4EB'
    silentArgs      = '/qn /norestart'
}

# Check if the same version of iTunes is already installed
$app = Get-WmiObject -Class Win32_Product | Where-Object {$_.Name -match 'iTunes'}
if ($app -and ([version]$app.Version -ge [version]$arguments['version'])) {
    Write-Output $(
        "iTunes is already installed."
    )
}
else {
    $packageArgs = Get-Arguments $arguments

    Get-ChocolateyUnzip @packageArgs

    $msiFilesList = (Get-ChildItem -Path $packageArgs.destination -Filter '*.msi' | Where-Object {
            $_.Name -notmatch 'AppleSoftwareUpdate*.msi'
        }).FullName

    # Istall all MSI files besides the Update
    foreach ($msiFile in $msiFilesList) {
        $packageArgs.file = $msiFile
        $packageArgs.fileType = 'msi'

        Install-ChocolateyInstallPackage @packageArgs
    }
}
