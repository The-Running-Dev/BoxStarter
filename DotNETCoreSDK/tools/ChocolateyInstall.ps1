$script             = $MyInvocation.MyCommand.Definition
$version            = '1.0.1'
$packageArgs        = @{
    packageName     = 'DotNetCoreSDK'
    unzipLocation   = (Get-CurrentDirectory $script)
    file            = Join-Path (Get-ParentDirectory $script) 'DotNetCore.1.0.1-SDK.1.0.0.Preview2-003133-x64.exe'
    fileType        = 'exe'
    url             = 'https://go.microsoft.com/fwlink/?LinkID=827524'
    softwareName    = 'DotNetCoreSDK*'
    checksum        = '27DFA0EA2D2AAA80F76D77D8747E9E2C1178F40592C3650FBD3BCFB512144132'
    checksumType    = 'sha256'
    silentArgs      = '/quiet'
    validExitCodes  = @(0, 3010, 1641)
}

if (Test-RegistryValue -Path 'HKLM:\SOFTWARE\Wow6432Node\dotnet\Setup\InstalledVersions\x64\sdk' -Value $version) {
    Write-Host "Microsoft .NET Core SDK is already installed on your machine."
}
else {
    Install-LocalOrRemote $packageArgs
}