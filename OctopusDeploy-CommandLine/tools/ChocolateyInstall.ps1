$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus-tools/4.32.0/OctopusTools.4.32.0.zip'
    checksum    = '5EBC7A07B25D80CB231209624BD9153FDEE225C51017416433675CA0B16F140B'
    destination = Join-Path $env:AppData 'Octopus'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
