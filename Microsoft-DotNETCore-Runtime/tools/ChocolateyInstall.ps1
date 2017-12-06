$arguments          = @{
    url             = 'https://download.microsoft.com/download/5/C/1/5C190037-632B-443D-842D-39085F02E1E8/dotnet-runtime-2.0.3-win-x64.exe'
    checksum        = 'E8EC46C2C35D1043BA1825F70348D736BF5D44ACC06C5DE3ADE3283FBAFF9C26'
    silentArgs      = "/install /quiet /norestart /log ""${env:temp}\$($data.PackageName).log"""
}

Install-Package $arguments
