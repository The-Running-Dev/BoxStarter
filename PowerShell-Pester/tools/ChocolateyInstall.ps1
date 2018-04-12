$arguments = @{
    url         = 'https://github.com/pester/Pester/archive/4.3.1.zip'
    checksum    = 'ECEB854072D747C2E08551762FE8AD5E9E2DB268A5789955F8416A133437D644'
    destination = Join-Path $env:ProgramFiles 'WindowsPowerShell\Modules'
}

Install-FromZip $arguments

# Move Pester3.4.3 to Pester
Get-ChildItem $arguments.destination Pester* | Select-Object -First 1 | Move-Item -Destination (Join-Path $env:ProgramFiles 'WindowsPowerShell\Modules\Pester')

Install-ChocolateyPath (Join-Path $arguments.destination 'Pester') 'Machine'
