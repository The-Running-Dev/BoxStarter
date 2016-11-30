$arch = get-processorBits

if($arch -eq 64 )
{
    $progFile = "$env:programFiles (x86)"
}
else
{
    $progFile = "$env:programFiles"
}

$dirPath = "\DisplayFusion"
$installPath = $progFile + $dirPath
$localeTwoLetter = (Get-Culture).TwoLetterISOLanguageName
 
$packageName = 'DisplayFusion'
$fileType = 'exe'
$silentArgs = "/VERYSILENT /LANG=$localeTwoLetter /DIR=`"$installPath`" /STARTUPALL=1 /CONTEXTMENU=0 /LAUNCHAFTER=0 /MERGETASKS=`"!desktopicon,!desktopicon\common,!desktopicon\user`""
$url = 'https://www.binaryfortress.com/Data/Download/?package=displayfusion&log=101'
 
install-ChocolateyPackage -packageName $packageName -fileType $fileType -silentArgs $silentArgs -url $url