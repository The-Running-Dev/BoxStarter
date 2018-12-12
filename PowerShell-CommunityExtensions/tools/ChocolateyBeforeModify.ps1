# Remove any existing installation

$arguments = @{
    destination = Join-Path $env:ProgramFiles 'WindowsPowerShell\Modules'
}

Get-ChildItem $arguments.destination Pscx* | Remove-Item -Recurse -Force