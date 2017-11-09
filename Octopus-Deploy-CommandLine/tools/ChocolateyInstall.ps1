$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus-tools/4.24.3/OctopusTools.4.24.3.zip'
    checksum    = 'F9E0FBBCA7676D5E8283436189EBB3BCCF316277230DB18B70A062D6EC90C1C5'
    destination = Join-Path $env:AppData 'Octopus'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
