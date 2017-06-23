$arguments          = @{
    url             = 'http://www.7-zip.org/a/7z1604-x64.exe'
    checksum        = '9BB4DC4FAB2A2A45C15723C259DC2F7313C89A5AC55AB7C3F76BBA26EDC8BCAA'
    silentArgs      = '/S'
}

Install-Package $arguments

Install-BinFile '7z' (Join-Path (Get-AppInstallLocation $env:ChocolateyPackageTitle) '7z.exe')
