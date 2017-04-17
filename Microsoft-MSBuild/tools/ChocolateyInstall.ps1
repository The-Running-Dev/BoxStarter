$arguments      = @{
    file        = 'Microsoft.MSBuild.zip'
    destination = 'C:\Program Files (x86)\MSBuild'
}

Install-CustomPackage $arguments