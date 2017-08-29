$arguments      = @{
    url         = 'https://releases.hashicorp.com/packer/1.0.4/packer_1.0.4_windows_amd64.zip'
    checksum    = '1A2AE283A71810A307299C05DF73E96890FB7503F1B32C52850356DDB750D877'
    destination = Join-Path $env:AppData 'Packer'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
