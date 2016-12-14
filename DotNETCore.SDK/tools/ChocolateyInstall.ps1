$script             = $MyInvocation.MyCommand.Definition
$packageArgs        = @{
    packageName     = 'DotNetCoreSDK'
    version         = '1.1.0'
    unzipLocation   = (Get-CurrentDirectory $script)
    file            = Join-Path (Get-ParentDirectory $script) 'dotnet-dev-win-x64.1.0.0-preview2-1-003177.exe'
    fileType        = 'exe'
    url             = 'https://go.microsoft.com/fwlink/?LinkID=835014'
    softwareName    = 'DotNetCoreSDK*'
    checksum        = '0C15A66958B1FA593129E5FFCFCD0558B756187EB4767B0B06F718D0AA6F4FCE'
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