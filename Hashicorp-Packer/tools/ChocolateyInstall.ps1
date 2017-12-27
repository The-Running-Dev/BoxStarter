$arguments      = @{
    url         = 'https://releases.hashicorp.com/packer/1.1.3/packer_1.1.3_windows_amd64.zip'
    checksum    = '8A8662E8341BD6FD45A2E43EE2B5E56B63C89CE355D5E367069B319AAA538044'
    destination = Join-Path $env:AppData 'Packer'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
