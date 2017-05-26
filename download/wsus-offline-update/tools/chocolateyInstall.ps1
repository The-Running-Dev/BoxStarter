$packageName = 'wsus-offline-update'
$url = 'http://download.wsusoffline.net/wsusoffline1092.zip'
$destdir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
Install-ChocolateyZipPackage "$packageName" "$url" "$destdir" -Checksum 80491d0630ec449b16a2744e05c9e0143ec54f86a3fc94f3213c2874d13d3b9f -ChecksumType 'sha256'

#install start menu shortcut
$fileNameGen = "UpdateGenerator.exe"
$fileNameInst = "UpdateInstaller.exe"
$linkNameGen = "UpdateGenerator.lnk"
$linkNameInst = "UpdateInstaller.lnk"
$programs = [environment]::GetFolderPath([environment+specialfolder]::Programs)
$shortcutFilePathGen = Join-Path $programs $linkNameGen
$shortcutFilePathInst = Join-Path $programs $linkNameInst
$targetPathGen = Join-Path "$destdir\wsusoffline" $fileNameGen
$targetPathInst = Join-Path "$destdir\wsusoffline\client" $fileNameInst
Install-ChocolateyShortcut -shortcutFilePath $shortcutFilePathGen -targetPath $targetPathGen
Install-ChocolateyShortcut -shortcutFilePath $shortcutFilePathInst -targetPath $targetPathInst