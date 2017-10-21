$arguments          = @{
    url             = 'https://justgetflux.com/flux-setup.exe'
    checksum        = '826A4040B9B3281DB6C426B55987876D93F756FF6B7D1D826E7C7B0ACE17A768'
    silentArgs      = '/S'
}

Install-Package $arguments

if (Get-Process -Name 'iexplore' -ErrorAction SilentlyContinue) {
    Stop-Process -processname 'iexplore'
}
