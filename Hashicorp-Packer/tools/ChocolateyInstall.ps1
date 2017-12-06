$arguments      = @{
    url         = 'https://releases.hashicorp.com/packer/1.1.2/packer_1.1.2_windows_amd64.zip'
    checksum    = '0BD1DF6A5FAD08DA93B01AC931F46B517BB77750964AEE365CA56A230B571308'
    destination = Join-Path $env:AppData 'Packer'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
