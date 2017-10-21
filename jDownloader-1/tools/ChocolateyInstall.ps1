$packageName = 'jdownloader'
$url = 'https://download.teamviewer.com/download/TeamViewer_Setup_en.exe'
$url64 = 'http://installer.jdownloader.org/ic/JD2SilentSetup_x64.exe'

$arguments = @{
    url        = 'https://download.teamviewer.com/download/TeamViewer_Setup_en.exe'
    checksum   = 'B348E0701262F54DCB6FA7111973CDE6940102E27691600977A124231FF38E92'
    silentArgs = '-q'
}

Install-Package $arguments
