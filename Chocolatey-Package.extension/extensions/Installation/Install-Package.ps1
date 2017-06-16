function Install-Package {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, ValueFromPipeline)][PSCustomObject] $arguments
    )

    $packageArgs = Get-Arguments $arguments

    if (-not (Test-FileExists $packageArgs.file) -and $packageArgs.url) {
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

        Install-ChocolateyInstallPackage `
            -PackageName $packageArgs.packageName `
            -File $packageArgs.executable `
            -FileType (Get-FileExtension $packageArgs.executable) `
            -SilentArgs $packageArgs.executableArgs `
            -ValidExitCodes $packageArgs.validExitCodes
    }

    if ($packageArgs.cleanUp) {
        Get-ChildItem -Path $env:ChocolateyPackageFolder `
            -Include *.zip, *.7z, *.tar.gz, *.exe, *.msi, *.reg -Recurse -File | Remove-Item
    }
}
