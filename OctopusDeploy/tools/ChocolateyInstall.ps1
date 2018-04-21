$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus/Octopus.2018.4.2-x64.msi'
    checksum    = '8C74077FF2E833ACE28A4945F4D19F2BA67E62618979180ACA6D129D4C17F5AC'
}

Install-Package $arguments
