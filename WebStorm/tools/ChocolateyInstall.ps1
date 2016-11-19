$installerType = 'EXE'
$url = 'https://download.jetbrains.com/webstorm/WebStorm-2016.3.exe'
$url64 = $url
$silentArgs = '/S'
$validExitCodes = @(0)
$checksumType = 'sha256';
$checksum = '0a8ef9562c826148d6ea6d230e35b680e99a7867f3cc181803f5e5ebc718c29b';

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64" -validExitCodes $validExitCodes -Checksum64 "$checksum" -ChecksumType64 $checksumType -ChecksumType "$checksumType" -Checksum "$checksum"