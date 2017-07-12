$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus-tools/4.19.0/OctopusTools.4.19.0.zip'
    checksum    = '281CE7F908E7E1C95493242F7BD942D3EED3A339E68853F0F7B8340D2D616416'
    destination = Join-Path $env:AppData 'Octopus'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
