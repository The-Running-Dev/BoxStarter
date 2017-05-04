$arguments          = @{
    url             = 'https://secure-appldnld.apple.com/itunes12/091-04060-20170323-F8B6662A-39E9-46EE-BA40-BDA0CCD05F40/iTunes64Setup.exe'
    checksum        = 'E8337FB4D96C530E3B63E243D29D59645EDA5B86087A4D06823B16C113D46653'
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
