$programFiles       = Join-Path (Get-ProgramFilesDirectory) 'DisplayFusion'
$localeTwoLetter    = (Get-Culture).TwoLetterISOLanguageName
$arguments          = @{
    url             = 'https://binaryfortressdownloads.com/Download/BFSFiles/101/DisplayFusionSetup-8.1.2.exe'
    checksum        = '547DF90EC756A4B4FD73675403547C0E08EB1345180107D52E4CDE2FD08C3DC0'
    silentArgs      = "/VERYSILENT /LANG=$localeTwoLetter /DIR=`"$programFiles`" /STARTUPALL=1 /CONTEXTMENU=0 /LAUNCHAFTER=0 /MERGETASKS=`"!desktopicon,!desktopicon\common,!desktopicon\user`""
}

Install-Package $arguments
