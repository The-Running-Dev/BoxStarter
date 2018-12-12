$arguments      = @{
    url         = 'https://binaryfortressdownloads.com/Download/BFSFiles/117/LogFusionSetup-6.2.1.exe'
    checksum    = '55CE7BA56D448B4C32E153997C6C8D12938CC87FCC9FBD1FFFCB3C70BC350170'
    silentArgs  = '/VERYSILENT /LAUNCHAFTER=0 /MERGETASKS=`"!desktopicon,!desktopicon\common,!desktopicon\user`"'
}

Install-Package $arguments

Install-BinFile LogFusion 'C:\Program Files (x86)\LogFusion\LogFusion.exe'

# Remove the shortcut on the desktop
Get-ChildItem "$env:Public\Desktop" LogFusion* | Remove-Item
