$arguments = @{
    url         = 'https://releases.hashicorp.com/terraform/0.9.11/terraform_0.9.11_windows_amd64.zip'
    checksum    = 'D3DB33DF518BD09D85858CAD5AED5AEBF92BEA28815F500DFCAA231BA762E5E7'
    destination = Join-Path $env:AppData 'Terraform'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
