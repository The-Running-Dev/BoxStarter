$arguments          = @{
    url             = 'http://www.7-zip.org/a/7z1805-x64.exe'
    checksum        = 'C1E42D8B76A86EA1890AD080E69A04C75A5F2C0484BDCD838DC8FA908DD4A84C'
    silentArgs      = '/S'
}

Install-Package $arguments

Install-BinFile '7z' (Join-Path (Get-AppInstallLocation $env:ChocolateyPackageTitle) '7z.exe')
