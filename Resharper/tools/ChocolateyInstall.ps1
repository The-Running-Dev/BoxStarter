$installerType = 'EXE'
$url = 'https://download.jetbrains.com/resharper/JetBrains.ReSharperUltimate.2016.2.2.exe'
$url64 = $url
$silentArgs = '/S'
$validExitCodes = @(0)
$checksumType = 'sha256';
$checksum = 'eccad508fb83428f8c5a3a9a4fc9d930251f101f4929845fc4aea3ab004169dd';

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64" -validExitCodes $validExitCodes -Checksum64 "$checksum" -ChecksumType64 $checksumType -ChecksumType "$checksumType" -Checksum "$checksum"