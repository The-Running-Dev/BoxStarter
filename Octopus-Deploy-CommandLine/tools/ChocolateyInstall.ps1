$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus-tools/4.15.6/OctopusTools.4.15.6.zip'
    checksum    = 'F7AF8C873B8522E318B1EA8CC0E5A863D67D16B5696570256175F7A61F730DBE'
    destination = Join-Path $env:AppData 'Octopus'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
