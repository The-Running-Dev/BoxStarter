$arguments = @{
    url        = 'https://github.com/atom/atom/releases/download/v1.26.0/AtomSetup-x64.exe'
    checksum   = '07FD07BB830594B98B060101E19F3CDEDF13832AD405455A00EB18D06489D973'
    silentArgs = '--silent'
}

Install-Package $arguments
