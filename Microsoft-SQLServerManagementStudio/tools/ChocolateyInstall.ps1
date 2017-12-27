$arguments = @{
    url        = 'https://download.microsoft.com/download/0/A/E/0AE3B5C9-0D22-4EF3-B48A-73181A7F8EF7/SSMS-Setup-ENU.exe'
    checksum   = 'CD174C1C01FCDE5A992A6ACB12A5B21B44F88D595EFE646644E9A4797C52F1C4'
    silentArgs = '/install /quiet /norestart'
}

Install-Package $arguments
