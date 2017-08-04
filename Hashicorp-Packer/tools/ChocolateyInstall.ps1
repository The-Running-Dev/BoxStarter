$arguments      = @{
    url         = 'https://releases.hashicorp.com/packer/1.0.3/packer_1.0.3_windows_amd64.zip'
    checksum    = '774699160352E65891483BE0C60AFF557DB32761D907AC5748CF65AEB9489FB1'
    destination = Join-Path $env:AppData 'Packer'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
