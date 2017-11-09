$programFiles       = Join-Path (Get-ProgramFilesDirectory) 'DisplayFusion'
$localeTwoLetter    = (Get-Culture).TwoLetterISOLanguageName
$arguments          = @{
    url             = 'https://binaryfortressdownloads.com/Download/BFSFiles/101/DisplayFusionSetup-9.0c.exe'
    checksum        = '75364A1E974580C6C9CC866F3DD2E5AD8504358FA6555668017AB2AFD0832BA9'
    silentArgs      = "/VERYSILENT /LANG=$localeTwoLetter /DIR=`"$programFiles`" /STARTUPALL=1 /CONTEXTMENU=0 /LAUNCHAFTER=0 /MERGETASKS=`"!desktopicon,!desktopicon\common,!desktopicon\user`""
}

Install-Package $arguments
