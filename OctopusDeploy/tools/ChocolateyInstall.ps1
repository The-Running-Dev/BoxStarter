$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus/Octopus.4.0.10-x64.msi'
    checksum    = '1355FED136401F23EF0D98D9D08FB12D307EF87798F196A7EBE05F900B2964D7'
}

Install-Package $arguments
