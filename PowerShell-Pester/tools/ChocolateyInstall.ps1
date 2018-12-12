$arguments = @{
    url         = 'https://github.com/pester/Pester/archive/4.4.3.zip'
    checksum    = ''
    destination = Join-Path $env:ProgramFiles 'WindowsPowerShell\Modules'
}

Install-FromZip $arguments

# Move Pester1.2.3 to Pester
Get-ChildItem $arguments.destination Pester* | Select-Object -First 1 | Move-Item -Destination (Join-Path $env:ProgramFiles 'WindowsPowerShell\Modules\Pester')

Import-Module Pester

Install-ChocolateyPath (Join-Path $arguments.destination 'Pester') 'Machine'
