$arguments      = @{
    url         = 'https://download.microsoft.com/download/2/E/C/2EC018A0-A0FC-40A2-849D-AA692F68349E/dotnet-sdk-2.1.105-win-x64.exe'
    checksum    = '1A8476A0949DF2BD3B8FE9117FAA192D2AA4385E35B2F0B87523448FDC40360A'
    silentArgs  = '/quiet'
}

if (Test-RegistryValue -Path 'HKLM:\SOFTWARE\Wow6432Node\dotnet\Setup\InstalledVersions\x64\sdk' -Value $version) {
    Write-Host "Microsoft .NET Core SDK is already installed on your machine."
}
else {
    Install-Package $arguments
}
