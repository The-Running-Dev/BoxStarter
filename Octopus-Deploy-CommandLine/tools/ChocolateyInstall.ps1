$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus-tools/4.22.1/OctopusTools.4.22.1.zip'
    checksum    = '9E24783A793E059929AD463268A985484D424D1EEA5F78342206473E3E653D17'
    destination = Join-Path $env:AppData 'Octopus'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
