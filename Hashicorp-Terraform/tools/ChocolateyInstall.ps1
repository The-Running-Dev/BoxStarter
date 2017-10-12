$arguments = @{
    url         = 'https://releases.hashicorp.com/terraform/0.10.7/terraform_0.10.7_windows_amd64.zip'
    checksum    = '872FA58641020C242A579587838BB0842361E1DAF0AE1F97FC3E9BAB9A4D63AF'
    destination = Join-Path $env:AppData 'Terraform'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
