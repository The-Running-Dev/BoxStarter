$arguments          = @{
    url             = 'https://downloads.slack-edge.com/releases_x64/SlackSetup.exe'
    checksum        = 'F7EE5313670A563EB4AB27E8EF69BE76222FB892330F54069C94E8CA21F1C63E'
    silentArgs      = '/s'
    cleanUp         = $false
}

Install-Package $arguments

Install-BinFile 'Slack' (Join-Path (Get-AppInstallLocation $env:ChocolateyPackageTitle) 'Slack.exe')
