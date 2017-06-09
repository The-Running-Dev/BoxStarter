$arguments          = @{
    url             = 'https://justgetflux.com/flux-setup.exe'
    checksum        = '2696C35394CA9125098458FC080461B6C841D6D8FD263B40270D21A8823C65B0'
    silentArgs      = '/S'
}

Install-Package $arguments

if (Get-Process -Name 'iexplore' -ErrorAction SilentlyContinue) {
    Stop-Process -processname 'iexplore'
}
