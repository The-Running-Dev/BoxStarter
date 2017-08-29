$arguments = @{
    url         = 'https://releases.hashicorp.com/terraform/0.10.2/terraform_0.10.2_windows_amd64.zip'
    checksum    = 'B117DFDE4C64C626A0551B88EDA94C0D08015FF221935C0C82855203D7378C99'
    destination = Join-Path $env:AppData 'Terraform'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
