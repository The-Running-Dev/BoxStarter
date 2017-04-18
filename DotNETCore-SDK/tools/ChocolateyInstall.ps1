$arguments      = @{
    file        = 'dotnet-dev-win-x64.1.0.1.exe'
    url         = 'https://download.microsoft.com/download/8/F/9/8F9659B9-E628-4D1A-B6BF-C3004C8C954B/dotnet-dev-win-x64.1.0.1.exe'
    checksum    = '8F252094A8A572A10AB75E923EE5905748990D2CE4DE3E5F065356D509DFEF43'
    silentArgs  = '/quiet'
}

if (Test-RegistryValue -Path 'HKLM:\SOFTWARE\Wow6432Node\dotnet\Setup\InstalledVersions\x64\sdk' -Value $version) {
    Write-Host "Microsoft .NET Core SDK is already installed on your machine."
}
else {
    Install-Package $arguments
}
