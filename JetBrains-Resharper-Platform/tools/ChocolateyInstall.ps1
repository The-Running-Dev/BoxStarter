$arguments          = @{
    url             = 'https://download.jetbrains.com/resharper/JetBrains.ReSharperUltimate.2017.3.1.exe'
    checksum        = '4DACDE5BDFF6CC0D41C2F178875A1A80597FCE5C284FE1949BCE8B259D573BC6'
    silentArgs      = '/VsVersion=14.0;15.0 /SpecificProductNames=dotCover;dotMemory;dotPeek;dotTrace;ReSharperCpp;teamCityAddin;ReSharper /Silent=True'
}

Install-Package $arguments
