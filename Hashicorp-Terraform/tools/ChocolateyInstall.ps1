$arguments = @{
    url         = 'https://releases.hashicorp.com/terraform/0.11.1/terraform_0.11.1_windows_amd64.zip'
    checksum    = 'B72152B537907C3297A17A6928DEF5C0ACBCBA8C0D92CBB5B12C24BE59380ED3'
    destination = Join-Path $env:AppData 'Terraform'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
