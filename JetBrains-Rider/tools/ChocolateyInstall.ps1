$arguments          = @{
    url             = 'https://download.jetbrains.com/resharper/JetBrains.Rider-2017.3.exe'
    checksum        = 'B953716A481379058EFA173A4DBF55DE69C5287DCD16D3BCEB0609BDE70FA4BB'
    silentArgs      = '/S'
}

Install-Package $arguments
