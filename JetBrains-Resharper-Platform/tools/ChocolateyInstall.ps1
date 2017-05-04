$arguments          = @{
    url             = 'https://download-cf.jetbrains.com/resharper/JetBrains.ReSharperUltimate.2017.1.1.exe'
    checksum        = '420E1A73885E3EA2B749DE1881E89476A2072A34134B81C9B43515B1D910A88D'
    silentArgs      = '/VsVersion=14.0;15.0 /SpecificProductNames=dotCover;dotMemory;dotPeek;dotTrace;ReSharperCpp;teamCityAddin;ReSharper /Silent=True'
}

Install-Package $arguments
