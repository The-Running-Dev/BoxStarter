$arguments = @{
    url         = 'https://github.com/pshdo/Carbon/archive/2.5.0.zip'
    checksum    = '7B2531E025E28A1AE8174AD921E8A79796373A8D08627C932AFA4A097366ABCA'
    destination = Join-Path $env:ProgramFiles 'WindowsPowerShell\Modules'
}

Install-FromZip $arguments

# Move Carbon* to Carbon
Get-ChildItem $arguments.destination Carbon* | Select-Object -First 1 | Move-Item -Destination (Join-Path $env:ProgramFiles 'WindowsPowerShell\Modules\Carbon')

Install-ChocolateyPath (Join-Path $arguments.destination 'Carbon') 'Machine'

& (Join-Path $arguments.destination 'Carbon\Carbon\Import-Carbon.ps1' -Resolve)
