$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus-tools/4.42.6/OctopusTools.4.42.6.zip'
    checksum    = '2586C9C0CAB3BF00A6BCDDAD3609B32100EAF2E3567AE1F22D452EB8245C7778'
    destination = Join-Path $env:AppData 'Octopus'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
