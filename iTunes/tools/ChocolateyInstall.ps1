$arguments = @{
    url        = 'https://secure-appldnld.apple.com/itunes12/041-17808-20181205-8DD4E9E8-F720-11E8-BB37-E021828CC72D/iTunes64Setup.exe'
    checksum   = '87EE89D60C27FA2D1206BCA0C48FB6D839302224F3D01CD66C1E6EB6115C5513'
    silentArgs = '/qn /norestart'
}

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
