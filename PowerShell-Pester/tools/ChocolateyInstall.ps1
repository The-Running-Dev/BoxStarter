$arguments = @{
    url         = 'https://github.com/pester/Pester/archive/3.4.3.zip'
    checksum    = '7145BC579C5ACE1B1EF06EC064282305011B2CDF87F34359CDA4795FBC5EE46B'
    destination = Join-Path $env:ProgramFiles 'WindowsPowerShell\Modules'
}

Install-FromZip $arguments

# Move Pester3.4.3 to Pester
Get-ChildItem $arguments.destination Pester* | Select-Object -First 1 | Move-Item -Destination (Join-Path $env:ProgramFiles 'WindowsPowerShell\Modules\Pester')

Install-ChocolateyPath (Join-Path $arguments.destination 'Pester') 'Machine'
