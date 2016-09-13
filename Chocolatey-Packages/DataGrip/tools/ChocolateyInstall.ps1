$installerType = 'EXE'
$url = "https://download.jetbrains.com/datagrip/datagrip-2016.2.3.exe"
$url64 = $url
$silentArgs = '/S'
$validExitCodes = @(0)
$checksumType = 'sha256';
$checksum = 'd123e545a1bb0375ae150492989395e8e4f2a95cac12405bba2efbc1a81aaff8';

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64" -validExitCodes $validExitCodes -Checksum64 "$checksum" -ChecksumType64 $checksumType -ChecksumType "$checksumType" -Checksum "$checksum"