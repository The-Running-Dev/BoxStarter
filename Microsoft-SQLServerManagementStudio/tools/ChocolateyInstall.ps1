$arguments = @{
    url        = 'http://download.microsoft.com/download/A/7/7/A77F55AC-6DFF-4B73-B2BD-420A97B946A3/SSMS-Setup-ENU.exe'
    checksum   = '52C78DF04182FB4359E02FF9E971B1C0750B3B3F363DE78C2D4035B9B146E0F1'
    silentArgs = '/install /quiet /norestart'
}

Install-Package $arguments
