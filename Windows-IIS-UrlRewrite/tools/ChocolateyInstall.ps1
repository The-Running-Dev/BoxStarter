$arguments          = @{
    file            = 'rewrite_amd64.msi'
    url             = 'http://download.microsoft.com/download/C/9/E/C9E8180D-4E51-40A6-A9BF-776990D8BCA9/rewrite_amd64.msi'
    checksum        = '64F99F1F8521B735CAFC64AF14344FFC075B3B0D7CD4BD0D0826DB5F8C45F4EA'
    silentArgs      = "/qn /norestart /l*v `"$env:TEMP\chocolatey\$($packageName)\$($packageName).MsiInstall.log`""
}

Install-Package $arguments
