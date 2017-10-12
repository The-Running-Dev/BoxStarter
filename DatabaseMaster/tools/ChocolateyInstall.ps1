$arguments = @{
    url      = 'http://nucleonsoftware.com/download/DatabaseMasterSetup.msi'
    checksum = '0EB8D48AFB0371E5560B5C8BF9258EC81733C0F5118086ED5B7BAF63C3A51057'
}

Install-Package $arguments
