$arguments          = @{
    url             = 'https://download.microsoft.com/download/8/D/A/8DA04DA7-565B-4372-BBCE-D44C7809A467/dotnet-runtime-2.0.6-win-x64.exe'
    checksum        = 'D70CCC6BAEBEF3978DDF5A96C6AC0B4A60A59BC48FA4E3F417099468EE4BA9E8'
    silentArgs      = "/install /quiet /norestart /log ""${env:temp}\$($data.PackageName).log"""
}

Install-Package $arguments
