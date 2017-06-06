$arguments = @{
    url      = 'http://nucleonsoftware.com/download/DatabaseMasterSetup.msi'
    checksum = '3FB2DC799D5E6C35A8ECB19061EAE5E1E06976CB6058175B97526DA2A3EF02EB'
}

Install-Package $arguments
