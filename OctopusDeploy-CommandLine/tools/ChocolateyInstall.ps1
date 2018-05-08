$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus-tools/4.34.0/OctopusTools.4.34.0.zip'
    checksum    = '2AC391A0ABE2D5DE51F16D8949A6EC11D4781CA906C30DEB19AF57E3CF6DA928'
    destination = Join-Path $env:AppData 'Octopus'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
