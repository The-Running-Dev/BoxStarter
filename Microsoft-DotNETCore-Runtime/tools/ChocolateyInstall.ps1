$arguments          = @{
    url             = 'https://download.microsoft.com/download/5/6/B/56BFEF92-9045-4414-970C-AB31E0FC07EC/dotnet-runtime-2.0.0-win-x64.exe'
    checksum        = 'EA7F9FCE864932B25B6C709D3FE9E4432CB6D119658D1DAFCAFAAC59B75066A1'
    silentArgs      = "/install /quiet /norestart /log ""${env:temp}\$($data.PackageName).log"""
}

Install-Package $arguments
