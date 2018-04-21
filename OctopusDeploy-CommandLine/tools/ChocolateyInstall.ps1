$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus-tools/4.32.1/OctopusTools.4.32.1.zip'
    checksum    = 'F52B98C6F070DE34035B6EF1CD970FFDC9F11CAE9B4EA47BB6A1996C234F69F0'
    destination = Join-Path $env:AppData 'Octopus'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
