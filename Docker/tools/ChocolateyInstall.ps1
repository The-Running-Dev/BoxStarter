$arguments = @{
    url            = 'https://download.docker.com/win/stable/Docker for Windows Installer.exe'
    checksum       = '27615F98E95DD829AF0CC649AD75BA0EDB8618C780A143B96204426A4A3698EF'
    silentArgs     = "install --quiet"
    validExitCodes = @(0, 3010, 1641)
}

Install-Package $arguments
