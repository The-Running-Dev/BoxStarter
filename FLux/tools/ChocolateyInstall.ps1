$arguments          = @{
    url             = 'https://justgetflux.com/flux-setup.exe'
    checksum        = 'EED100B96A9D20A35D8D961E317248F5C00D921C28EB479604861DD847671857'
    silentArgs      = '/S'
}

Install-Package $arguments

if (Get-Process -Name 'iexplore' -ErrorAction SilentlyContinue) {
    Stop-Process -processname 'iexplore'
}
