$arguments      = @{
    url         = 'https://download.handbrake.fr/releases/1.1.2/HandBrake-1.1.2-x86_64-Win_GUI.exe'
    checksum    = 'F4CCE05A18402D9DFA768529CABAC2DD721B733CB0D631B940125D6A94BF1A0E'
    silentArgs  = '/S'
}

Install-Package $arguments

New-StartMenuShortcut (Join-Path $env:ProgramFiles 'HandBrake\HandBrake.exe')

# Remove the shortcut on the desktop
Get-ChildItem "$env:Public\Desktop" 'HandBrake*' | Remove-Item
