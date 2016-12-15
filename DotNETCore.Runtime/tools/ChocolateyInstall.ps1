$script             = $MyInvocation.MyCommand.Definition
$arguments          = @{
    packageName     = 'DotNETCore.Runtime'
    Version         = '1.1.0'
    softwareName    = 'Microsoft .NET Core 1.1.0 - Runtime*'
    unzipLocation   = (Get-CurrentDirectory $script)
    UninstallerName = 'dotnet-win-*.1.1.0.exe'
    file            = Join-Path (Get-ParentDirectory $script) 'dotnet-win-x64.1.1.0.exe'
    fileType        = 'exe'
    url             = 'https://download.microsoft.com/download/1/4/1/141760B3-805B-4583-B17C-8C5BC5A876AB/Installers/dotnet-win-x86.1.1.0.exe'
    Url64           = 'https://download.microsoft.com/download/1/4/1/141760B3-805B-4583-B17C-8C5BC5A876AB/Installers/dotnet-win-x64.1.1.0.exe'
    checksum        = '6F3CE7234A427DFB6280D2C725329F3217B8439DF48CE83C6780E9EFB30AA7F5'
    Checksum64      = '7D56D0D7BC363F129D8552271583BEE503FD5455EB0ABC8741107282E899ABC2'
    checksumType    = 'sha256'
    silentArgs      = "/install /quiet /norestart /log ""${env:temp}\$($data.PackageName).log"""
    validExitCodes  = @(0, 3010, 1641)
}

Install-LocalOrRemote $arguments