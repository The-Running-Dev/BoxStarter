$arguments          = @{
    url             = 'https://download.jetbrains.com/resharper/JetBrains.ReSharperUltimate.2018.1.exe'
    checksum        = 'B81D315E36F7AB68C9EC70B6762F059973BEBBCFD98D612F23EE9DC2B9D45B46'
    silentArgs      = '/VsVersion=14.0;15.0 /SpecificProductNames=dotCover;dotMemory;dotPeek;dotTrace;ReSharperCpp;teamCityAddin;ReSharper /Silent=True'
}

Install-Package $arguments
