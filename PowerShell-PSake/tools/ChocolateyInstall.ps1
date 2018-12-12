$arguments = @{
    url         = 'https://github.com/psake/psake/archive/v4.7.4.zip'
    checksum    = '2D4B0E46D2E69D7772E0AFD1C80E3475CD0A702201D6F7B54727A2AB309F16B7'
    destination = Join-Path $env:ProgramFiles 'WindowsPowerShell\Modules'
}

Install-FromZip $arguments

# Move PSake-4.6.0 to PSake
Get-ChildItem $arguments.destination PSake* | Select-Object -First 1 | Move-Item -Destination (Join-Path $env:ProgramFiles 'WindowsPowerShell\Modules\PSake')

Import-Module "$(Join-Path(Join-Path $arguments.destination 'PSake') 'src\psake.psm1')"

Install-ChocolateyPath (Join-Path $arguments.destination 'PSake\src') 'Machine'
