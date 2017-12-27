$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus-tools/4.29.0/OctopusTools.4.29.0.zip'
    checksum    = '6D7A1147EFDC1CBE180DBC282CF1BAD1507794908CF16D0E6D975DF7C16D8633'
    destination = Join-Path $env:AppData 'Octopus'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
