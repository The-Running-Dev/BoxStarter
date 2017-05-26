$linkNameGen = "UpdateGenerator.lnk"
$linkNameInst = "UpdateInstaller.lnk"
$programs = [environment]::GetFolderPath([environment+specialfolder]::Programs)
$shortcutFilePathGen = Join-Path $programs $linkNameGen
$shortcutFilePathInst = Join-Path $programs $linkNameInst

if(Test-Path $shortcutFilePathGen) {
    del $shortcutFilePathGen
}

if(Test-Path $shortcutFilePathInst) {
    del $shortcutFilePathInst
}