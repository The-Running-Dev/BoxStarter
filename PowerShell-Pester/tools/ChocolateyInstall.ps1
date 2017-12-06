$arguments = @{
    url         = 'https://github.com/pester/Pester/archive/4.1.0.zip'
    checksum    = '08F3BAFF51DE9F759D65E75AFD6751F68AB68A1E421ABAE28C9CA5CCFDE40403'
    destination = Join-Path $env:ProgramFiles 'WindowsPowerShell\Modules'
}

Install-FromZip $arguments

# Move Pester3.4.3 to Pester
Get-ChildItem $arguments.destination Pester* | Select-Object -First 1 | Move-Item -Destination (Join-Path $env:ProgramFiles 'WindowsPowerShell\Modules\Pester')

Install-ChocolateyPath (Join-Path $arguments.destination 'Pester') 'Machine'
