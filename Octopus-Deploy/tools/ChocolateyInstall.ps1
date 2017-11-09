$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus/Octopus.3.17.11-x64.msi'
    checksum    = '57850EAACD1909EB8F2244A25A1464DBCD86B83A545A8619EBD2ECBD8753AFEB'
}

Install-Package $arguments
