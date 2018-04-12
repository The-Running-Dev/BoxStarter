$arguments          = @{
    url             = 'https://justgetflux.com/flux-setup.exe'
    checksum        = '79FC802D9225D98EE15A288393BB2D4708575315B9EDAD33DBFCF29D1AF578B1'
    silentArgs      = '/S'
}

Install-Package $arguments

if (Get-Process -Name 'iexplore' -ErrorAction SilentlyContinue) {
    Stop-Process -processname 'iexplore'
}
