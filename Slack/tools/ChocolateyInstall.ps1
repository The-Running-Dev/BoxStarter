$arguments          = @{
    url             = 'https://downloads.slack-edge.com/releases_x64/SlackSetup.exe'
    checksum        = '3CBAEB0EB13A96BDBF16B534ECB19A629610AAB803877C563059585BFC03790E'
    silentArgs      = '/s'
    cleanUp         = $false
}

Install-Package $arguments

Install-BinFile 'Slack' (Join-Path (Get-AppInstallLocation $env:ChocolateyPackageTitle) 'Slack.exe')
