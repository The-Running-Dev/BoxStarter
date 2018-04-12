$arguments      = @{
    url         = 'https://releases.hashicorp.com/packer/1.2.2/packer_1.2.2_windows_amd64.zip'
    checksum    = '9C066BBE463376F9E7991326ECBA09672B121776A0F2566C2D8E6EF72D52106E'
    destination = Join-Path $env:AppData 'Packer'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
