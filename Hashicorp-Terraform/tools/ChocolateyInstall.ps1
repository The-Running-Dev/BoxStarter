$arguments = @{
    url         = 'https://releases.hashicorp.com/terraform/0.11.10/terraform_0.11.10_windows_amd64.zip'
    checksum    = '7BBB3D631FA0050431CC73E7FC9892EF60128D838ED8B4AFC1A36F1398C717A2'
    destination = Join-Path $env:AppData 'Terraform'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
