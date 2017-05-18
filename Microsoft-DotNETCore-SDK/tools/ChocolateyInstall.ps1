$arguments      = @{
    url         = 'https://download.microsoft.com/download/B/9/F/B9F1AF57-C14A-4670-9973-CDF47209B5BF/dotnet-dev-win-x64.1.0.4.exe'
    checksum    = 'A8B2A928E66EAC6CCB939916D55D2D181B8F1433FC1FBF0D894713E8C86C7303'
    silentArgs  = '/quiet'
}

if (Test-RegistryValue -Path 'HKLM:\SOFTWARE\Wow6432Node\dotnet\Setup\InstalledVersions\x64\sdk' -Value $version) {
    Write-Host "Microsoft .NET Core SDK is already installed on your machine."
}
else {
    Install-Package $arguments
}
