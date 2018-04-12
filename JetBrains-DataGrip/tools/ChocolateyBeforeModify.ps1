$arguments = @{
    packageName    = $env:ChocolateyPackageName
    fileType       = 'exe'
    silentArgs     = '/S'
    validExitCodes = @(0)
}

[array]$key = Get-UninstallRegistryKey -SoftwareName $softwareName

$key | ForEach-Object {
    Uninstall-ChocolateyPackage `
        -PackageName $arguments.packageName `
        -FileType $arguments.fileType `
        -SilentArgs $arguments.silentArgs `
        -ValidExitCodes $arguments.validExitCodes `
        -File $($_.UninstallString)
}