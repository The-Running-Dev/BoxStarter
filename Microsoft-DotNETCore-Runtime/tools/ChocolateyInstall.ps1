$arguments          = @{
    url             = 'https://download.microsoft.com/download/2/B/2/2B2854E7-7EAE-4FE9-85D2-19ACCD716F18/dotnet-runtime-2.0.4-win-x64.exe'
    checksum        = 'EF92EC3B458BB813F29514E917B56DFFF7247FE30180E6636AC2161FA0358ABB'
    silentArgs      = "/install /quiet /norestart /log ""${env:temp}\$($data.PackageName).log"""
}

Install-Package $arguments
