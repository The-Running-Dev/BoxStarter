$arguments          = @{
    url             = 'https://justgetflux.com/flux-setup.exe'
    checksum        = '30FAB888B39E362A8C80CC7902D7B7B5B641569A4A628FB82814B46FBE73671D'
    silentArgs      = '/S'
}

Install-Package $arguments

if (Get-Process -Name 'iexplore' -ErrorAction SilentlyContinue) {
    Stop-Process -processname 'iexplore'
}
