$arguments = @{
    url        = 'https://download.microsoft.com/download/5/0/B/50B02ECB-CB5C-4C23-A1D3-DAB4467604DA/SSMS-Setup-ENU.exe'
    checksum   = 'E7EB0843299DA85BB294082D408F986191F2EE63F6D21813FDCEAA6019848E47'
    silentArgs = '/install /quiet /norestart'
}

Install-Package $arguments
