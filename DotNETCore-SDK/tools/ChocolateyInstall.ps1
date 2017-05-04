$arguments      = @{
    url         = 'https://download.microsoft.com/download/1/1/4/114223DE-0AD6-4B8A-A8FB-164E5862AF6E/dotnet-dev-win-x64.1.0.3.exe'
    checksum    = 'B349CF09915C715CD77A66A9F8DCD0649179CBB15231B8698075E4C6F7417677'
    silentArgs  = '/quiet'
}

if (Test-RegistryValue -Path 'HKLM:\SOFTWARE\Wow6432Node\dotnet\Setup\InstalledVersions\x64\sdk' -Value $version) {
    Write-Host "Microsoft .NET Core SDK is already installed on your machine."
}
else {
    Install-Package $arguments
}
