$arguments = @{
    url         = 'https://github.com/pester/Pester/archive/4.1.1.zip'
    checksum    = 'DB089AC725A67331FA22B261860EFD3F906F35A6DFA460F09EE59A27350B22F8'
    destination = Join-Path $env:ProgramFiles 'WindowsPowerShell\Modules'
}

Install-FromZip $arguments

# Move Pester3.4.3 to Pester
Get-ChildItem $arguments.destination Pester* | Select-Object -First 1 | Move-Item -Destination (Join-Path $env:ProgramFiles 'WindowsPowerShell\Modules\Pester')

Install-ChocolateyPath (Join-Path $arguments.destination 'Pester') 'Machine'
