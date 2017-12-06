$programFiles       = Join-Path (Get-ProgramFilesDirectory) 'DisplayFusion'
$localeTwoLetter    = (Get-Culture).TwoLetterISOLanguageName
$arguments          = @{
    url             = 'https://binaryfortressdownloads.com/Download/BFSFiles/101/DisplayFusionSetup-9.1.exe'
    checksum        = '8F1CFAFDA844C018A87FC216B38BC38C69269A1A0798BDD1B41CCA17F9ED6C08'
    silentArgs      = "/VERYSILENT /LANG=$localeTwoLetter /DIR=`"$programFiles`" /STARTUPALL=1 /CONTEXTMENU=0 /LAUNCHAFTER=0 /MERGETASKS=`"!desktopicon,!desktopicon\common,!desktopicon\user`""
}

Install-Package $arguments
