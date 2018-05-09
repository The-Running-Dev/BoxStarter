$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus-tools/4.35.0/OctopusTools.4.35.0.zip'
    checksum    = '6B78854F1C4F93A02313F35CB9E1DC536D30B386E1C5F4411D0F53A9CBB0B36B'
    destination = Join-Path $env:AppData 'Octopus'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
