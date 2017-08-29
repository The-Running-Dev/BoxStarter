$arguments = @{
    url        = 'https://download.microsoft.com/download/C/3/D/C3DBFF11-C72E-429A-A861-4C316524368F/SSMS-Setup-ENU.exe'
    checksum   = '8F110A033102C2C375C286189BBA48A01CD0B1288E2771E2C3322A3D621237A1'
    silentArgs = '/install /quiet /norestart'
}

Install-Package $arguments
