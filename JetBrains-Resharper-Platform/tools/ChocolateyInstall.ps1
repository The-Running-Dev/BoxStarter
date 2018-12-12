$arguments = @{
    url        = 'https://download.jetbrains.com/resharper/ReSharperUltimate.2018.2.3/JetBrains.ReSharperUltimate.2018.2.3.exe'
    checksum   = 'BBF113DFFF09DF15C07609DFA1B1F2885D8E2065FCE5107AE7A5E3D8B3214AE9'
    silentArgs = '/VsVersion=15.0 /SpecificProductNames=ReSharper;dotCover;dotMemory;dotPeek;dotTrace;teamCityAddin /Silent=True'
}

Install-Package $arguments
