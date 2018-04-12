$arguments          = @{
    url             = 'https://download.jetbrains.com/resharper/JetBrains.ReSharperUltimate.2017.3.5.exe'
    checksum        = '704225A14DF1EDA65F42747F948B31B4157BB63ACCBF638DE2F89539B6623AD9'
    silentArgs      = '/VsVersion=14.0;15.0 /SpecificProductNames=dotCover;dotMemory;dotPeek;dotTrace;ReSharperCpp;teamCityAddin;ReSharper /Silent=True'
}

Install-Package $arguments
