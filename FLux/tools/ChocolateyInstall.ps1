$arguments          = @{
    url             = 'https://justgetflux.com/flux-setup.exe'
    checksum        = '78F9D1C15AA2AB1EEFEA9DC05B96503C05920AA8AD5386FD0B85FDF634E27BE0'
    silentArgs      = '/S'
}

Install-Package $arguments

if (Get-Process -Name 'iexplore' -ErrorAction SilentlyContinue) {
    Stop-Process -processname 'iexplore'
}
