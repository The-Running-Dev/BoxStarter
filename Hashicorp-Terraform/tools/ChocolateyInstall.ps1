$arguments = @{
    url         = 'https://releases.hashicorp.com/terraform/0.10.0/terraform_0.10.0_windows_amd64.zip'
    checksum    = 'D9697B0153BED48AF4B077C711197F8FCA1163E94D5A1C067B077A02201BE25F'
    destination = Join-Path $env:AppData 'Terraform'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
