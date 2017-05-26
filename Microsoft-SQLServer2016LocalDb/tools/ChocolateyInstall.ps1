$arguments      = @{
    file        = 'SqlLocalDB.msi'
    checksum    = '413E739B79068BA0D91A8C62DB14BCCD37591E86515F4AE74F4C91C270F02D45'
    silentArgs = "/qn /norestart /l*v `"$($env:TEMP)\$($env:ChocolateyPackageName).MsiInstall.log`" IAcceptSQLLocalDbLicenseTerms=YES"
}

Install-Package $arguments
