$arguments = @{
    url      = 'https://download.octopusdeploy.com/octopus/Octopus.Tentacle.3.24.0-x64.msi'
    checksum = '1E0512F23E5CBBE87B53027A8335F87CD0A9BF658DBA0DCE9E9F6F37EA63B512'
}

Install-Package $arguments
