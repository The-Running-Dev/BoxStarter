$arguments = @{
    packageName    = $env:ChocolateyPackageName
    softwareName   = 'JetBrains DataGrip*'
    fileType       = 'exe'
    silentArgs     = '/S'
    validExitCodes = @(0)
}

[array]$key = Get-UninstallRegistryKey -SoftwareName $arguments.softwareName

$key | ForEach-Object {
    Write-Host "Running...$($_.UninstallString)"

    Uninstall-ChocolateyPackage `
        -PackageName $arguments.packageName `
        -FileType $arguments.fileType `
        -SilentArgs $arguments.silentArgs `
        -ValidExitCodes $arguments.validExitCodes `
        -File $($_.UninstallString)
}