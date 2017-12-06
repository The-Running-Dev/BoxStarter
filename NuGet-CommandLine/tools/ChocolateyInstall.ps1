$arguments      = @{
    url         = 'https://dist.nuget.org/win-x86-commandline/latest/nuget.exe'
    checksum    = '781930966CF218CA01560C11F99F3C7423AA734C3BBE480179B85A7EBA69D9B2'
    destination = Join-Path $env:AppData 'NuGet'
}

Install-WithCopy $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
