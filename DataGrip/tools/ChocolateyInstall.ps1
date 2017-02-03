$script           = $MyInvocation.MyCommand.Definition
$arguments        = @{
    packageName     = 'DataGrip'
    unzipLocation   = (Get-CurrentDirectory $script)
    file            = Join-Path (Get-ParentDirectory $script) 'Datagrip-2016.3.3.exe'
    fileType        = 'exe'
    url             = 'https://download.jetbrains.com/datagrip/datagrip-2016.3.3.exe'
    softwareName    = 'DataGrip*'
    checksum        = '010c8a7cb7b52ebc3f064738483acef4bf1aec12f6120392db3c566064bb5c44'
    checksumType    = 'sha256'
    silentArgs      = '/S'
    validExitCodes  = @(0, 3010, 1641)
}

Install-LocalOrRemote $arguments