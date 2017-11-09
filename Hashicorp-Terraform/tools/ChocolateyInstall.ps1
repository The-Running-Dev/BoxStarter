$arguments = @{
    url         = 'https://releases.hashicorp.com/terraform/0.10.8/terraform_0.10.8_windows_amd64.zip'
    checksum    = '6BBAF59AAF80B476ECBF765369678F5D8C296CB3A30E4D783AD560F0E4B81A76'
    destination = Join-Path $env:AppData 'Terraform'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
