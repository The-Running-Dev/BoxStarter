$installerScript    = Join-Path $packageDir 'Install.exe'
$arguments          = @{
    file            = 'lastappinstall_x64.exe'
    url             = 'https://lastpass.com/download/cdn/lastappinstall_x64.exe'
    checksum        = '29CB9F2E69CFED90DCEFBEC8A13615BA7DB9C1B74AE6EFFAD1D0E0A078A30BB9'
    silentArgs      = '-si'
}

# Launch the AutoHotkey script that install the application
Start-Process $installerScript

Install-Package $arguments
