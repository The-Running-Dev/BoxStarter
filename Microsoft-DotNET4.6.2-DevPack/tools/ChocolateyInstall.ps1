$arguments = @{
    url        = 'https://download.microsoft.com/download/E/F/D/EFD52638-B804-4865-BB57-47F4B9C80269/NDP462-DevPack-KB3151934-ENU.exe'
    checksum   = 'E21D111FCA26C1B39CC09A619127A962137C242CE086AD25B8B5E097A0C8E199'
    silentArgs = "/q /NoRestart /Log ""${Env:TEMP}\${packageName}.log"""
}

Install-Package $arguments
