$arguments          = @{
    url             = 'https://download.jetbrains.com/datagrip/datagrip-2017.2.exe'
    checksum        = '096B896A6C9C46735E36DB78FB9803DE395BBFEEFA7097BC1AEE4FBA1561586A'
    silentArgs      = '/S'
}

Install-Package $arguments
