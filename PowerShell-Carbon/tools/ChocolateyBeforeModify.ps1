# Remove any existing installation

$arguments = @{
    destination = Join-Path $env:ProgramFiles 'WindowsPowerShell\Modules'
}

Get-ChildItem $arguments.destination Carbon* | Select-Object -First 1 | Remove-Item