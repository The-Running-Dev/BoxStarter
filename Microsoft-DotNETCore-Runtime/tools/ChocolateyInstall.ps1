$arguments          = @{
    url             = 'https://download.microsoft.com/download/D/0/2/D028801E-0802-43C8-9F9F-C7DB0A39B344/dotnet-win-x64.1.1.2.exe'
    checksum        = '104B18531CEE34C2BA3AC19C7F717FE57791B76240D3C2455F26CDBBF5D8DC22'
    silentArgs      = "/install /quiet /norestart /log ""${env:temp}\$($data.PackageName).log"""
}

Install-Package $arguments
