$arguments = @{
    url         = 'https://releases.hashicorp.com/terraform/0.9.8/terraform_0.9.8_windows_amd64.zip'
    checksum    = '1B1632D2F574D3F6033FBFABACC4CEF16973C5E32585820C70F9A2E42E526B4A'
    destination = Join-Path $env:AppData 'Terraform'
}

Install-FromZip $arguments

Install-ChocolateyPath "$($arguments.destination)" -PathType 'Machine'
