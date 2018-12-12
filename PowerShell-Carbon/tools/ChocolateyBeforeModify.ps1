# Remove any existing installation

$arguments = @{
    destination = Join-Path $env:ProgramFiles 'WindowsPowerShell\Modules'
}

Get-ChildItem $arguments.destination Carbon* | Remove-Item -Recurse -Force