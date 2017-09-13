$arguments          = @{
    url             = 'https://download.jetbrains.com/resharper/JetBrains.ReSharperUltimate.2017.2.exe'
    checksum        = '34FA7A5D891E185D51B5CBBAAA5E0716F622377A2913DE45BE0F87EC305539A9'
    silentArgs      = '/VsVersion=14.0;15.0 /SpecificProductNames=dotCover;dotMemory;dotPeek;dotTrace;ReSharperCpp;teamCityAddin;ReSharper /Silent=True'
}

Install-Package $arguments
