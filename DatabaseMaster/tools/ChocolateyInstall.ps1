$arguments = @{
    url      = 'http://nucleonsoftware.com/download/DatabaseMasterSetup.msi'
    checksum = '7D36777F2D98AA217D187D4DE2E14C26B74D874EAB6C0CEA33D6BD5B0E35085E'
}

Install-Package $arguments
