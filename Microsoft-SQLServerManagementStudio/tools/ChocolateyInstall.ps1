$arguments = @{
    url        = 'https://download.microsoft.com/download/0/D/2/0D26856F-E602-4FB6-8F12-43D2559BDFE4/SSMS-Setup-ENU.exe'
    checksum   = '78591C090A91256CCBEBD871DD77EC1677436FC5CEB87560C914C6921D176FBD'
    silentArgs = '/install /quiet /norestart'
}

Install-Package $arguments
