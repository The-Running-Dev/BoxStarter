$installerType = 'EXE'
$url = "https://download.jetbrains.com/webstorm/WebStorm-2016.2.3.exe"
$url64 = $url
$silentArgs = '/S'
$validExitCodes = @(0) 
$checksumType = 'sha256';
$checksum = '439d7580e7e4e5452d92a153063ad7ea4fcca3536f7e6314d7339de861eae402';
 
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64" -validExitCodes $validExitCodes -Checksum64 "$checksum" -ChecksumType64 $checksumType -ChecksumType "$checksumType" -Checksum "$checksum"