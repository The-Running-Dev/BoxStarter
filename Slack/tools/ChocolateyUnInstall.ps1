$packageName = "slack"
$fileType = "exe"
$args = "--uninstall -s"
$filePath = "$env:APPDATA\..\Local\slack\Update.exe"
 
Uninstall-ChocolateyPackage $packageName $fileType $args $filePath