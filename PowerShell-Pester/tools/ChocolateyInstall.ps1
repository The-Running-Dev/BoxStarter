$arguments = @{
    url         = 'https://github.com/pester/Pester/archive/4.0.8.zip'
    checksum    = '284B455C5892D1523AA90A9FE69772A48801B2A8FDF76C1FB3CAA8B2AFCCCFB4'
    destination = Join-Path $env:ProgramFiles 'WindowsPowerShell\Modules'
}

Install-FromZip $arguments

# Move Pester3.4.3 to Pester
Get-ChildItem $arguments.destination Pester* | Select-Object -First 1 | Move-Item -Destination (Join-Path $env:ProgramFiles 'WindowsPowerShell\Modules\Pester')

Install-ChocolateyPath (Join-Path $arguments.destination 'Pester') 'Machine'
