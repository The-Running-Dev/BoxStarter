$arguments      = @{
    url         = 'https://dist.nuget.org/win-x86-commandline/latest/nuget.exe'
    checksum    = '4C1DE9B026E0C4AB087302FF75240885742C0FAA62BD2554F913BBE1F6CB63A0'
    destination = Join-Path $env:AppData 'NuGet'
}

Install-WithCopy $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
