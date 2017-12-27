$arguments = @{
    url      = 'https://download.octopusdeploy.com/octopus/Octopus.Tentacle.3.16.3-x64.msi'
    checksum = 'C6874BB29FE8550F275F879264FA60C9B196B39CC97D3148F969C3CC3341D440'
}

Install-Package $arguments
