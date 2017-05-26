$arguments = @{
    url        = 'https://download.microsoft.com/download/C/8/A/C8AE3D51-5AAD-4DCF-809C-667D691629E4/SSMS-Setup-ENU.exe'
    checksum   = '54692D0A38B44C6D0318C12C32CA69D3852C68116642914C8EFDCBA020C89DDA'
    silentArgs = '/install /quiet /norestart'
}

Install-Package $arguments
