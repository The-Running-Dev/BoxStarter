$arguments      = @{
    url         = 'https://dist.nuget.org/win-x86-commandline/latest/nuget.exe'
    checksum    = '399EC24C26ED54D6887CDE61994BB3D1CADA7956C1B19FF880F06F060C039918'
    destination = Join-Path $env:AppData 'NuGet'
}

Install-WithCopy $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
