$arguments          = @{
    url             = 'https://secure-appldnld.apple.com/itunes12/031-97715-20170912-DE51D95C-97F5-11E7-8FE6-1494FCD6B433/iTunes64Setup.exe'
    checksum        = '860BF23D7FD474E29BB3CB05433E85AC6702BC136AC17830965A3A02918CF087'
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
