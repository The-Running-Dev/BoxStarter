$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus-tools/4.22.0/OctopusTools.4.22.0.zip'
    checksum    = 'A6AE44555453892FF4A1C75EE8281A83EC9F8E8714B39398E7EF37B7B7BAC511'
    destination = Join-Path $env:AppData 'Octopus'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
