$arguments = @{
    url         = 'https://github.com/psake/psake/archive/v4.6.0.zip'
    checksum    = '3AB9B982E2690D995ECEA372337AFA5F18D878482F2B63CAF32A4C011ABE5D26'
    destination = Join-Path $env:ProgramFiles 'WindowsPowerShell\Modules'
}

Install-FromZip $arguments

# Move PSake-4.6.0 to PSake
Get-ChildItem $arguments.destination PSake* | Select-Object -First 1 | Move-Item -Destination (Join-Path $env:ProgramFiles 'WindowsPowerShell\Modules\PSake')

Install-ChocolateyPath (Join-Path $arguments.destination 'PSake') 'Machine'
