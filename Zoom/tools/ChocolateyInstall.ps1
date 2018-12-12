$arguments      = @{
    url         = 'https://zoom.us/client/latest/ZoomInstaller.exe'
    checksum    = 'ED507357743AA36A3A80B27397D812FDF5734DE30816A4B25382859B385F1BEF'
    silentArgs  = '/Q'
}

Install-Package $arguments

# Stop Zoom if it's running
Get-Process -Name Zoom -ErrorAction SilentlyContinue | Stop-Process
