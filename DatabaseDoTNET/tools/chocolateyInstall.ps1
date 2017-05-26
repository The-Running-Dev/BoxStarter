$packageName = 'databasenet'
$url = 'http://fishcodelib.com/files/DatabaseNet4.zip'
$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
Install-ChocolateyZipPackage $packageName $url $unzipLocation -Checksum 918F11CA71B0B09D9D0A3E1EF91DBF53E7B1C6EE76FAB1AEDB6DD46DA954EBA6 -ChecksumType 'sha256'
$shortcutPath = Join-Path ([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::StartMenu)) "Database4.lnk"
$targetPath = Join-Path $unzipLocation "Database4.exe"
Install-ChocolateyShortcut -shortcutFilePath $shortcutPath -targetPath $targetPath