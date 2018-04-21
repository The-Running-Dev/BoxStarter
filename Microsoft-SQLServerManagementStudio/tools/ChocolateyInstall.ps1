$arguments = @{
    url        = 'https://download.microsoft.com/download/A/F/5/AF52C08E-AF5C-41F0-8E50-2E4DE2A3A33A/SSMS-Setup-ENU.exe'
    checksum   = 'CD174C1C01FCDE5A992A6ACB12A5B21B44F88D595EFE646644E9A4797C52F1C4'
    silentArgs = '/install /quiet /norestart'
}

Install-Package $arguments
