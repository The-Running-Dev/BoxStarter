$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus-tools/4.15.7/OctopusTools.4.15.7.zip'
    checksum    = 'C08190D58DAA53BA99A3A78F206C5E4D6EFC595E18BA1B05FBB7FBF17044E1A0'
    destination = Join-Path $env:AppData 'Octopus'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
