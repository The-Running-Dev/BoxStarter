$installerType = 'EXE'
$url = 'https://download.jetbrains.com/datagrip/datagrip-2016.2.6.exe'
$url64 = $url
$silentArgs = '/S'
$validExitCodes = @(0)
$checksumType = 'sha256';
$checksum = '7dcd1d9e70e6786aee40ffe3258fafb47d64d225249b973bb59565427459d826';

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64" -validExitCodes $validExitCodes -Checksum64 "$checksum" -ChecksumType64 $checksumType -ChecksumType "$checksumType" -Checksum "$checksum"