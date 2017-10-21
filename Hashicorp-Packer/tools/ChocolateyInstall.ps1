$arguments      = @{
    url         = 'https://releases.hashicorp.com/packer/1.1.1/packer_1.1.1_windows_amd64.zip'
    checksum    = 'CCFDBA603D7BA225E99BEB753F71C0CFBA58FC9AC24250356E77EAC5A7464CC5'
    destination = Join-Path $env:AppData 'Packer'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
