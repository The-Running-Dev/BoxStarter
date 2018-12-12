$arguments          = @{
    url             = 'https://justgetflux.com/flux-setup.exe'
    checksum        = '606FA89FF2A594C88595F4EF152FA7C6F89EA36FCA49D26D66756680816477E8'
    silentArgs      = '/S'
}

Install-Package $arguments

if (Get-Process -Name 'iexplore' -ErrorAction SilentlyContinue) {
    Stop-Process -processname 'iexplore'
}
