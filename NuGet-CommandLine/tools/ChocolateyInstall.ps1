$arguments      = @{
    url         = 'https://dist.nuget.org/win-x86-commandline/latest/nuget.exe'
    checksum    = '2C562C1A18D720D4885546083EC8EAAD6773A6B80BEFB02564088CC1E55B304E'
    destination = Join-Path $env:AppData 'NuGet'
}

Install-WithCopy $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
