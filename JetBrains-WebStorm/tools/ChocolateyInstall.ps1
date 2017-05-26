$arguments          = @{
    url             = 'https://download.jetbrains.com/webstorm/WebStorm-2017.1.2.exe'
    checksum        = '33A694290D808858253A61335D71F1FCE77B3B664697721C084CEC82EF1D0300'
    silentArgs      = '/S'
}

Install-Package $arguments
