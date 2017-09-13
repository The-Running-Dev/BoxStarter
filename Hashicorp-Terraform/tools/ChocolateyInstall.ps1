$arguments = @{
    url         = 'https://releases.hashicorp.com/terraform/0.10.4/terraform_0.10.4_windows_amd64.zip'
    checksum    = '27E40FA8D944B8E1C68B1968A8890625A3EF18E4E752782EAA4DC6E99C6DED3A'
    destination = Join-Path $env:AppData 'Terraform'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
