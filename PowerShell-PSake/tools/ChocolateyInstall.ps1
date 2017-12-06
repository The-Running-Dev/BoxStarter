$arguments = @{
    url         = 'https://github.com/psake/psake/archive/v4.7.0.zip'
    checksum    = 'B5286E0A260B0E8981070BC4A567D6E421464C406D99A390EC48849FAD6D4D34'
    destination = Join-Path $env:ProgramFiles 'WindowsPowerShell\Modules'
}

Install-FromZip $arguments

# Move PSake-4.6.0 to PSake
Get-ChildItem $arguments.destination PSake* | Select-Object -First 1 | Move-Item -Destination (Join-Path $env:ProgramFiles 'WindowsPowerShell\Modules\PSake')

Install-ChocolateyPath (Join-Path $arguments.destination 'PSake') 'Machine'
