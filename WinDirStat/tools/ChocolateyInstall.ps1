$arguments = @{
    url        = 'https://netcologne.dl.sourceforge.net/project/windirstat/windirstat/1.1.2%20installer%20re-release%20%28more%20languages%21%29/windirstat1_1_2_setup.exe'
    checksum   = '370A27A30EE57247FADDEB1F99A83933247E07C8760A07ED82E451E1CB5E5CDD'
    silentArgs = '/S'
}

Install-Package $arguments

# Remove the shortcut on the desktop
Get-ChildItem "$env:UserProfile\Desktop" WinDirStat* | Remove-Item
