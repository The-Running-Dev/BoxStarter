$packageName = 'jdownloader'
$url = 'https://download.teamviewer.com/download/TeamViewer_Setup_en.exe'
$url64 = 'http://installer.jdownloader.org/ic/JD2SilentSetup_x64.exe'

$arguments = @{
    url        = 'https://download.teamviewer.com/download/TeamViewer_Setup_en.exe'
    checksum   = 'C4E3E3A7F31C2E5AA3A6B981CB82E43A797D366FB8D370102134429AB8E14EC3'
    silentArgs = '-q'
}

Install-Package $arguments
