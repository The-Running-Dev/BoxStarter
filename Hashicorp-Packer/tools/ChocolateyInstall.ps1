$arguments      = @{
    url         = 'https://releases.hashicorp.com/packer/1.3.3/packer_1.3.3_windows_amd64.zip'
    checksum    = '493A88D0F0D3492D1AC3046EDC22119490C211630510060FB611A2898F6D15D0'
    destination = Join-Path $env:AppData 'Packer'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
