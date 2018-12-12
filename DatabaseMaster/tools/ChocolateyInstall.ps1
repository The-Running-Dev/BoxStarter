$arguments = @{
    url      = 'http://nucleonsoftware.com/download/DatabaseMasterSetup.msi'
    checksum = '8642CBB6EB71E442742053F90B05A8EDCC3D1DDBC4DD7338CA2B8C759AED45CE'
}

Install-Package $arguments
