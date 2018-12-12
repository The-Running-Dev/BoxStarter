$programFiles       = Join-Path (Get-ProgramFilesDirectory) 'DisplayFusion'
$localeTwoLetter    = (Get-Culture).TwoLetterISOLanguageName
$arguments          = @{
    url             = 'https://binaryfortressdownloads.com/Download/BFSFiles/101/DisplayFusionSetup-9.4-Beta6.exe'
    checksum        = '1273ED255D60E782817F4E0AABA29B7BD45ED856E718D064E1A031B1D9329BD7'
    silentArgs      = "/VERYSILENT /LANG=$localeTwoLetter /DIR=`"$programFiles`" /STARTUPALL=1 /CONTEXTMENU=0 /LAUNCHAFTER=0 /MERGETASKS=`"!desktopicon,!desktopicon\common,!desktopicon\user`""
}

Install-Package $arguments
