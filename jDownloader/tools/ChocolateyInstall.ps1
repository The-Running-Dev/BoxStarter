$packageName = 'jdownloader'
$url = 'https://download.teamviewer.com/download/TeamViewer_Setup_en.exe'
$url64 = 'http://installer.jdownloader.org/ic/JD2SilentSetup_x64.exe'

$arguments = @{
    url        = 'https://download.teamviewer.com/download/TeamViewer_Setup_en.exe'
    checksum   = '878DD404F868B8B03B5655553EB3401ACDC4D94CF60EC8C67070149B0F0582E5'
    silentArgs = '-q'
}

Install-Package $arguments
