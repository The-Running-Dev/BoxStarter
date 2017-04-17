$arguments          = @{
    file            = 'MetaXSetup.exe'
    url             = 'http://www.danhinsley.com/downloads/MetaXSetup.exe'
    checksum        = 'A421F6D400B93AA0BEA1EB142309CB543E36B26FA1C79187302840EBB4E8C6BE'
    silentArgs      = "/C /T:`"$env:ChocolateyPackageFolder`""
}

Install-CustomPackage $arguments

$arguments          = @{
    file            = 'MetaXSetup.msi'
}

Install-CustomPackage $arguments