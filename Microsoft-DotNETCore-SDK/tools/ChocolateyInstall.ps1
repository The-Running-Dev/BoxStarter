$arguments      = @{
    url         = 'https://download.microsoft.com/download/3/7/1/37189942-C91D-46E9-907B-CF2B2DE584C7/dotnet-sdk-2.1.200-win-x64.exe'
    checksum    = 'A8DBA5AD5AB8F4C97E81D2DF1B9F6397E2ADEB7FB1488E096CAF9E40B11EB797'
    silentArgs  = '/quiet'
}

if (Test-RegistryValue -Path 'HKLM:\SOFTWARE\Wow6432Node\dotnet\Setup\InstalledVersions\x64\sdk' -Value $version) {
    Write-Host "Microsoft .NET Core SDK is already installed on your machine."
}
else {
    Install-Package $arguments
}
