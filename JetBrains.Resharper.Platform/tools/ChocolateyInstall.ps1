$arguments          = @{
    file            = 'JetBrains.ReSharperUltimate.2016.3.2.exe'
    url             = 'https://download-cf.jetbrains.com/resharper/JetBrains.ReSharperUltimate.2016.3.2.exe'
    checksum        = '81A83904E0AFB1724FF3191941AAE22FFC923538F99F004A1FFA968D09982F52'
    silentArgs      = '/VsVersion=14.0;15.0 /SpecificProductNames=dotCover;dotMemory;dotPeek;dotTrace;ReSharperCpp;teamCityAddin;ReSharper /Silent=True'
}

Install-CustomPackage $arguments
