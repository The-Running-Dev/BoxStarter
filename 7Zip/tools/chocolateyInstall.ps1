$arguments          = @{
    url             = 'http://www.7-zip.org/a/7z1801-x64.exe'
    checksum        = '86670D63429281A4A65C36919CA0F3099E3F803E3096C3A9722D61B3D31E4A9F'
    silentArgs      = '/S'
}

Install-Package $arguments

Install-BinFile '7z' (Join-Path (Get-AppInstallLocation $env:ChocolateyPackageTitle) '7z.exe')
