$arguments          = @{
    url             = 'https://downloads.slack-edge.com/releases_x64/SlackSetup.exe'
    checksum        = '622E0DF3050FC5D605366820B28BE4CD7188E396DBF84BB94234110BE812D18D'
    silentArgs      = '/s'
    cleanUp         = $false
}

Install-Package $arguments

Install-BinFile 'Slack' (Join-Path $env:AppData 'Slack\Slack.exe')
