$arguments = @{
    url         = 'https://github.com/pshdo/Carbon/releases/download/2.7.0/Carbon.zip'
    checksum    = 'FF5B221BE44339DDDFDBF8287CA486C2B60F0FEAAB5F86F255C32C64CD5D5A7A'
    destination = Join-Path $env:ProgramFiles 'WindowsPowerShell\Modules'
}

Install-FromZip $arguments

Get-ChildItem "$($arguments.destination)\license.txt", "$($arguments.destination)\notice.txt" | Remove-Item -Force
Remove-Item $(Join-Path $arguments.destination 'Examples') -Force -Recurse

& (Join-Path $arguments.destination 'Carbon\Import-Carbon.ps1' -Resolve)

Install-ChocolateyPath (Join-Path $arguments.destination 'Carbon') 'Machine'
