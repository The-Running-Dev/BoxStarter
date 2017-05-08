$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus/Octopus.3.13.0-x64.msi'
    checksum    = 'DB51B74A8297600C15271DF7F7AF610FE33DE11BA24C5E571DC13BD828491DF0'
}

Install-Package $arguments
