$arguments          = @{
    url             = 'https://download.jetbrains.com/resharper/JetBrains.ReSharperUltimate.2017.2.2.exe'
    checksum        = '5B14EFFFD5C088923C3B9165CD6AC49673F90F7AF01EE89B39894CF26EAE234C'
    silentArgs      = '/VsVersion=14.0;15.0 /SpecificProductNames=dotCover;dotMemory;dotPeek;dotTrace;ReSharperCpp;teamCityAddin;ReSharper /Silent=True'
}

Install-Package $arguments
