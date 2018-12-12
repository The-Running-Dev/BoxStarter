$arguments      = @{
    url         = 'https://dist.nuget.org/win-x86-commandline/latest/nuget.exe'
    checksum    = '82E3AA0205415CD18D8AE34613911717DAD3ED4E8AC58143E55CA432A5BF3C0A'
    destination = Join-Path $env:AppData 'NuGet'
}

Install-WithCopy $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
