$arguments = @{
    url         = 'https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_windows_amd64.zip'
    checksum    = '5FD003EF20F7A6A85CED4AD30BF95698AFD4D0BFD477541583FF014E96026D6C'
    destination = Join-Path $env:AppData 'Terraform'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
