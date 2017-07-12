$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus/Octopus.3.15.3-x64.msi'
    checksum    = 'EEA861783AC8D9E62DAC9936E64845D36661CF1C96F88EB18EFB7CBB6A9757AC'
}

Install-Package $arguments
