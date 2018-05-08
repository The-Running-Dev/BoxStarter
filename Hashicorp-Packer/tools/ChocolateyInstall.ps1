$arguments      = @{
    url         = 'https://releases.hashicorp.com/packer/1.2.3/packer_1.2.3_windows_amd64.zip'
    checksum    = 'C28C4D0710526A9029A9EB4ECC7AB967C267B5BE1020680667484F4FE016BD99'
    destination = Join-Path $env:AppData 'Packer'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
