$installer          = 'dotnet-dev-win-x64.1.0.0-preview2-1-003177.exe'
$url                = 'https://go.microsoft.com/fwlink/?LinkID=835014'
$checksum           = '0C15A66958B1FA593129E5FFCFCD0558B756187EB4767B0B06F718D0AA6F4FCE'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $evn:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/quiet'
    validExitCodes  = @(0, 1641, 3010)
}

if (Test-RegistryValue -Path 'HKLM:\SOFTWARE\Wow6432Node\dotnet\Setup\InstalledVersions\x64\sdk' -Value $version) {
    Write-Host "Microsoft .NET Core SDK is already installed on your machine."
}
else {
    Install-CustomPackage $arguments
}