$arguments      = @{
    url         = 'https://download.microsoft.com/download/D/8/1/D8131218-F121-4E13-8C5F-39B09A36E406/dotnet-sdk-2.1.104-win-x64.exe'
    checksum    = 'BE12095FD228306402F204684DF09BFDDBC83F37445D34C20BAF7AF8FAB817DE'
    silentArgs  = '/quiet'
}

if (Test-RegistryValue -Path 'HKLM:\SOFTWARE\Wow6432Node\dotnet\Setup\InstalledVersions\x64\sdk' -Value $version) {
    Write-Host "Microsoft .NET Core SDK is already installed on your machine."
}
else {
    Install-Package $arguments
}
