$arguments = @{
    url        = 'https://download.microsoft.com/download/5/0/B/50B02ECB-CB5C-4C23-A1D3-DAB4467604DA/SSMS-Setup-ENU.exe'
    checksum   = '54692D0A38B44C6D0318C12C32CA69D3852C68116642914C8EFDCBA020C89DDA'
    silentArgs = '/install /quiet /norestart'
}

Install-Package $arguments
