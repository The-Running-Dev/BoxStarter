$arguments = @{
    url        = 'https://github.com/atom/atom/releases/download/v1.26.1/AtomSetup-x64.exe'
    checksum   = '1E4A2FB45CDB069BED34DB4E9B83B1D4AADA04F8A9EE5782ACBDEEAC9B03B6A9'
    silentArgs = '--silent'
}

Install-Package $arguments
