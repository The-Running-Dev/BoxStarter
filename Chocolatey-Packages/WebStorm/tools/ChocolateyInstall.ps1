$installerType = 'EXE'
$url = 'https://download.jetbrains.com/webstorm/WebStorm-2016.2.4.exe'
$url64 = $url
$silentArgs = '/S'
$validExitCodes = @(0)
$checksumType = 'sha256';
$checksum = 'f47bd314260b9313343988b340217cf75e011b4798283ae3bef034a4b0e96832';

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64" -validExitCodes $validExitCodes -Checksum64 "$checksum" -ChecksumType64 $checksumType -ChecksumType "$checksumType" -Checksum "$checksum"