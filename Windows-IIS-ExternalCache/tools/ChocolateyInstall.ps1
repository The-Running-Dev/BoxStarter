$arguments          = @{
    url             = 'http://download.microsoft.com/download/C/A/5/CA5FAD87-1E93-454A-BB74-98310A9C523C/ExternalDiskCache_amd64.msi'
    checksum        = '6BF8E5FDA2B993193B922C977AA8D41F78262C5DB0F04305EC19434C2AB5FA53'
    silentArgs      = "/qn /norestart /l*v `"$env:TEMP\chocolatey\$($packageName)\$($packageName).MsiInstall.log`""
}

Install-Package $arguments
