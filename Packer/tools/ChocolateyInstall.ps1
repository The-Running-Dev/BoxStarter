$arguments      = @{
    url         = 'https://releases.hashicorp.com/packer/1.0.0/packer_1.0.0_windows_amd64.zip'
    checksum    = '54B2C92548F0A4F434771703F083B6E0FBBF73A8BF81963FD43E429D2561A4E0'
    destination = Join-Path $env:AppData 'Packer'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
