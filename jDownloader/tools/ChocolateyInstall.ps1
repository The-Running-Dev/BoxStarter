$packageName = 'jdownloader'
$url = 'https://download.teamviewer.com/download/TeamViewer_Setup_en.exe'
$url64 = 'http://installer.jdownloader.org/ic/JD2SilentSetup_x64.exe'

$arguments = @{
    url        = 'https://download.teamviewer.com/download/TeamViewer_Setup_en.exe'
    checksum   = 'CE34113260805F46169CC8569440F62EE5EDF3E7C252BF0CB8393B285BA57C1F'
    silentArgs = '-q'
}

Install-Package $arguments
