$arguments      = @{
    url         = 'https://download.visualstudio.microsoft.com/download/pr/d4592a50-b583-434a-bcda-529e506a7e0d/b1fee3bb02e4d5b831bd6057af67a91b/dotnet-sdk-2.2.101-win-x64.exe'
    checksum    = 'AF888982ABB405E8BBC90BA9B97E83988E6602B40A39806187043CE5A55161D6'
    silentArgs  = '/quiet'
}

if (Test-RegistryValue -Path 'HKLM:\SOFTWARE\Wow6432Node\dotnet\Setup\InstalledVersions\x64\sdk' -Value $version) {
    Write-Host "Microsoft .NET Core SDK is already installed on your machine."
}
else {
    Install-Package $arguments
}
