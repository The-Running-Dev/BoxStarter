$arguments = @{
    url            = 'http://get.videolan.org/vlc/3.0.4/win64/vlc-3.0.4-win64.exe'
    checksum       = 'C73AA2A4CAD7703E3F4FE756BF307351BD39F864C1B654F43BCCC9415AFFBEE9'
    silentArgs     = '/S'
}

Install-Package $arguments
