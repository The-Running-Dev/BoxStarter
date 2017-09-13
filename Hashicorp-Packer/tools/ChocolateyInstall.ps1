$arguments      = @{
    url         = 'https://releases.hashicorp.com/packer/1.1.0/packer_1.1.0_windows_amd64.zip'
    checksum    = 'FCF1D9725515E60575C2292128362F3793A58E014CBB5E78575E4E56B839BFF8'
    destination = Join-Path $env:AppData 'Packer'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
