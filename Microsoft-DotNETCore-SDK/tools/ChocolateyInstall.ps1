$arguments      = @{
    url         = 'https://download.microsoft.com/download/2/9/3/293BC432-348C-4D1C-B628-5AC8AB7FA162/dotnet-sdk-2.1.3-win-x64.exe'
    checksum    = '8AC8724C465FD05C5473CF379ABA7C3F478217D48BF66351BCC209AD81C62E5B'
    silentArgs  = '/quiet'
}

if (Test-RegistryValue -Path 'HKLM:\SOFTWARE\Wow6432Node\dotnet\Setup\InstalledVersions\x64\sdk' -Value $version) {
    Write-Host "Microsoft .NET Core SDK is already installed on your machine."
}
else {
    Install-Package $arguments
}
