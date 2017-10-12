$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus-tools/4.24.0/OctopusTools.4.24.0.zip'
    checksum    = 'B48E3DD22D825556BDC109E4B076A91E98986D13D4CCEFFEB4CECC3FBDDB8D76'
    destination = Join-Path $env:AppData 'Octopus'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
