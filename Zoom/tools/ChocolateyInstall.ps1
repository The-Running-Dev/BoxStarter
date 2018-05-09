$arguments      = @{
    url         = 'https://zoom.us/client/latest/ZoomInstaller.exe'
    checksum    = '0F89B16A09CC9645E049577D4FDEFE80F3A2FFEE05919852715451BA829E34E4'
    silentArgs  = '/Q'
}

Install-Package $arguments

# Stop Zoom if it's running
Get-Process -Name Zoom -ErrorAction SilentlyContinue | Stop-Process
