$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus-tools/4.27.2/OctopusTools.4.27.2.zip'
    checksum    = '1D53182FDAB821EB36BD0853A7BD922036F62D5E0EAC39B05E9FD76788D2D3EE'
    destination = Join-Path $env:AppData 'Octopus'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
