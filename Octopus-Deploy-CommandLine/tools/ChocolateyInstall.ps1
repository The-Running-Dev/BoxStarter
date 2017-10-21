$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus-tools/4.24.2/OctopusTools.4.24.2.zip'
    checksum    = 'DC69253799D16C32B53A0CF02DA8FD2429E5AB9EB790FA291C7505438E3A2ECD'
    destination = Join-Path $env:AppData 'Octopus'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
