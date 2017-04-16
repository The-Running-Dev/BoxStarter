$arguments          = @{
    file            = 'GitExtensions-2.49.03-SetupComplete.msi'
    url             = 'https://github.com/gitextensions/gitextensions/releases/download/v2.49.03/GitExtensions-2.49.03-SetupComplete.msi'
    checksum        = 'ADE16FB9ECB92538ACFDCC70C377A4BD67EBE954FDCFABD6C6E35F27A96146DB'
    silentArgs      = '/quiet /norestart'
}

Install-CustomPackage $arguments
