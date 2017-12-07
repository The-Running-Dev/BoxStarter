$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus-tools/4.27.3/OctopusTools.4.27.3.zip'
    checksum    = 'B0D1289D135D2C85DEBF2A67FBD1C1B615E5428CED95AD3070C44412BFA5F144'
    destination = Join-Path $env:AppData 'Octopus'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
