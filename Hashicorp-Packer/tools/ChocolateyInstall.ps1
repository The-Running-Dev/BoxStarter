$arguments      = @{
    url         = 'https://releases.hashicorp.com/packer/1.0.1/packer_1.0.1_windows_amd64.zip'
    checksum    = '311B0414CA03BD98BAD4CD58B070FECE08F16BE75CD0DDC8F12FEDFE21626AFC'
    destination = Join-Path $env:AppData 'Packer'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
