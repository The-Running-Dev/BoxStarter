$arguments      = @{
    url         = 'https://releases.hashicorp.com/packer/1.0.2/packer_1.0.2_windows_amd64.zip'
    checksum    = '32DB9260A98A42B42D4591EA48C8BE04FB6F77FD04FE4FA1A832B93D81EC123C'
    destination = Join-Path $env:AppData 'Packer'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
