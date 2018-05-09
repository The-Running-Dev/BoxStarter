$arguments = @{
    url        = 'https://secure-appldnld.apple.com/itunes12/091-76333-20180329-6D5B026C-32F7-11E8-A675-99BAB071F5CF/iTunes64Setup.exe'
    checksum   = 'F4B923ABBB515D87F1D7B363C8D66E108001E0B914BDAE90DFCF9453E874891A'
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