$arguments          = @{
    url             = 'https://downloads.slack-edge.com/releases_x64/SlackSetup.exe'
    checksum        = 'F091E169BE2E7DF3A3EB77A26F211FA504EB982C4447E1EC61F9A4AA37D6F280'
    silentArgs      = '/s'
    cleanUp         = $false
}

Install-Package $arguments

Install-BinFile 'Slack' (Join-Path (Get-AppInstallLocation $env:ChocolateyPackageTitle) 'Slack.exe')
