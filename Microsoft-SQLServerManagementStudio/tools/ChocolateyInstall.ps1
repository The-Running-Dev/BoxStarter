$arguments = @{
    url        = 'https://download.microsoft.com/download/3/C/7/3C77BAD3-4E0F-4C6B-84DD-42796815AFF6/SSMS-Setup-ENU.exe'
    checksum   = '0AB0B14F36603D337D332E32EAF63C5FD953A9A0792C6384AC7925F5DEA26244'
    silentArgs = '/install /quiet /norestart'
}

Install-Package $arguments
