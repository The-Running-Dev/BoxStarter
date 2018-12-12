$arguments = @{
    url         = 'https://psg-prod-eastus.azureedge.net/packages/pscx.3.3.2.nupkg'
    checksum    = '1078599AF91A46D1C1393EE36B523FE25D2AF8525387E5564A94C54310628DCC'
    destination = Join-Path $env:ProgramFiles 'WindowsPowerShell\Modules\Pscx'
}

Install-FromZip $arguments

Import-Module Pscx

Install-ChocolateyPath $arguments.destination 'Machine'
