$arguments          = @{
    url             = 'https://download.microsoft.com/download/9/5/1/95198156-644E-4CCE-8DA1-C41F7658510C/dotnet-win-x64.1.1.1.exe'
    checksum        = 'C0B2344526033907B6F2F0BD3FB0F776C9FC1FD20114075BAF987012E2390E36'
    silentArgs      = "/install /quiet /norestart /log ""${env:temp}\$($data.PackageName).log"""
}

Install-Package $arguments
