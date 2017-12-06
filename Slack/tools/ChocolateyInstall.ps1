$arguments          = @{
    url             = 'https://downloads.slack-edge.com/releases_x64/SlackSetup.exe'
    checksum        = 'CAF9E9DF4AF8B4483A679B37EF2FA2E8D3B58A78D8E8811FEFB28FB01347C638'
    silentArgs      = '/s'
    cleanUp         = $false
}

Install-Package $arguments

Install-BinFile 'Slack' (Join-Path (Get-AppInstallLocation $env:ChocolateyPackageTitle) 'Slack.exe')
