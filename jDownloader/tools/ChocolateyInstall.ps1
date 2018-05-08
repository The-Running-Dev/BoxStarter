$packageName = 'jdownloader'
$url = 'https://download.teamviewer.com/download/TeamViewer_Setup_en.exe'
$url64 = 'http://installer.jdownloader.org/ic/JD2SilentSetup_x64.exe'

$arguments = @{
    url        = 'https://download.teamviewer.com/download/TeamViewer_Setup_en.exe'
    checksum   = 'F60062CF21ED42BA0ADF64A296F124074EF4AD92B6B58E2F488C4B028A286BF4'
    silentArgs = '-q'
}

Install-Package $arguments
