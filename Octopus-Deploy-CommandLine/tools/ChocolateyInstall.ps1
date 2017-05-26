$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus-tools/4.15.5/OctopusTools.4.15.5.zip'
    checksum    = '3C49078EFADB11FBC094DBE378EB3E633B550CDA6B55EAA7C9A8785C52F4F97B'
    destination = Join-Path $env:AppData 'Octopus'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
