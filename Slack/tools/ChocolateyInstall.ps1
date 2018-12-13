$arguments          = @{
    url             = 'https://downloads.slack-edge.com/releases_x64/SlackSetup.exe'
    checksum        = '79D28A2F7A95C891FD4E4E6BDBF1F2D5139AC6534FE144A3F689406584F48AAC'
    silentArgs      = '/s'
    cleanUp         = $false
}

Install-Package $arguments

Install-BinFile 'Slack' (Join-Path $env:AppData 'Slack\Slack.exe')

# Remove the shortcut on the desktop
Get-ChildItem "$env:UserProfile\Desktop" 'Slack*' | Remove-Item

# Remove from Windows startup
Remove-ItemProperty `
    -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run' `
    -Name 'com.squirrel.slack.slack' -ErrorAction SilentlyContinue
