$arguments          = @{
    url             = 'https://secure-appldnld.apple.com/itunes12/091-22850-20170719-8AC53D14-6BB9-11E7-A878-C6374A4DD6D5/iTunes64Setup.exe'
    checksum        = '1CACADB282960C3428AF3122B66E7BB59CB7BF94B5F6764C4A0715F5635D134F'
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
