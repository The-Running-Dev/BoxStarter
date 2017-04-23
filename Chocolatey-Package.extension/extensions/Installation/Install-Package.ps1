function Install-Package {
    param(
        [PSCustomObject] $arguments
    )

    $packageArgs = Get-Arguments $arguments

    if (!(Test-FileExists $packageArgs.file)) {
        Write-Message "Install-Package: Downloading from '$($arguments.url)'"

        $arguments.file = Get-ChocolateyWebFile @packageArgs
    }

    Install-ChocolateyInstallPackage `
        -PackageName $packageArgs.packageName `
        -File $packageArgs.file `
        -FileType $packageArgs.fileType `
        -SilentArgs $packageArgs.silentArgs `
        -ValidExitCodes $packageArgs.validExitCodes

    if ($packageArgs.executable) {
        # The file parameter does not contain a full path
        if (![System.IO.Path]::IsPathRooted($packageArgs.executable)) {
            $packageArgs.executable = Join-Path $packageArgs.destination $packageArgs.executable
        }

        # Recreate the arguments using the executable parameters
        $packageArgs = @{
            packageName = $packageArgs.executablePackageName
            file = $packageArgs.executable
            silentArgs = $packageArgs.executableArgs
            fileType = Get-FileExtension $packageArgs.file
            validExitCodes = $packageArgs.validExitCodes
        }

        Write-Message "Install-Package: $($packageArgs | Out-String)"

        Install-ChocolateyInstallPackage @packageArgs
    }
}