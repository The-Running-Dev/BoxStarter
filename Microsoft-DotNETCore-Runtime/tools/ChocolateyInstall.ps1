$arguments          = @{
    url             = 'https://download.microsoft.com/download/A/9/F/A9F8872C-48B2-41DB-8AAD-D5908D988592/dotnet-runtime-2.0.7-win-x64.exe'
    checksum        = 'C9F5A4059EF8A0E188F9DF193A323BB9561AC033162351778D08498CA63960E8'
    silentArgs      = "/install /quiet /norestart /log ""${env:temp}\$($data.PackageName).log"""
}

Install-Package $arguments
