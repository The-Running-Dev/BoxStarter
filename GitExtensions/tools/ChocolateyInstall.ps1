$arguments = @{
    url        = 'https://github.com/gitextensions/gitextensions/releases/download/v3.00.00/GitExtensions-3.00.00.4433.msi'
    checksum   = 'E5E399C9BDA74EBD3F3E28AA0E618A6082624371B077F8F4E476E7BD6AC443DB'
    silentArgs = '/quiet /norestart'
}

$parameters = $env:ChocolateyPackageParameters

if ($parameters) {
    $arguments.silentArgs += " $parameters"
}

Install-Package $arguments

Install-BinFile gitex "$(Get-AppInstallLocation GitExtensions)\gitex.cmd"

# Remove the shortcut on the desktop
Get-ChildItem "$env:Public\Desktop" 'Git Extensions*' | Remove-Item
