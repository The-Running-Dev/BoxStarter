$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus-tools/4.43.0/OctopusTools.4.43.0.zip'
    checksum    = '98B13571B3E47EA3C3C2DB8B4F15E61DEF7E54FD8B7DC0F882917168CF2A4727'
    destination = Join-Path $env:AppData 'Octopus'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
