$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus/Octopus.3.14.1-x64.msi'
    checksum    = '68379C23ED22F12BB9C36EBBD7F6AB05B67F46EBCD3153EF7C7E0C3F64E919F2'
}

Install-Package $arguments
