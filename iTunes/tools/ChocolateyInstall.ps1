$arguments          = @{
    url             = 'https://secure-appldnld.apple.com/itunes12/091-56359-20171213-EDF2198A-E039-11E7-9A9F-D21A1E4B8CED/iTunes64Setup.exe'
    checksum        = '7CD6CC4DA573DD5E4BA09E7710C2B97FB8E3AB4F2BCF729908BA26BD21AAC388'
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
