$installOptionsFile = Join-Path $PSScriptRoot 'InstallOptions.xml'

if (!(Test-Path $installOptionsFile)) {
    throw "Install options file missing. Could not uninstall."
}

$arguments = Import-CliXml -Path $installOptionsFile

if ((Get-Service $arguments.serviceName -ErrorAction SilentlyContinue)) {
    Stop-Service $arguments.serviceName
    Uninstall-Service $arguments.serviceName
}

Remove-Item $arguments.installDir -Recurse -Force