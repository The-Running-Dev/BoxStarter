$arguments = @{
    url            = 'https://download.docker.com/win/stable/Docker for Windows Installer.exe'
    checksum       = 'D5A0C83EFE20445556B07D07482A2E95CD7A50E39C82A06489CA35589D018C16'
    silentArgs     = "install --quiet"
    validExitCodes = @(0, 3010, 1641)
}

Install-Package $arguments
