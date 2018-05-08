function Install-FromZip {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, ValueFromPipeline)][PSCustomObject] $arguments
    )

    $packageArgs = Get-Arguments $arguments

    $originalFile = $packageArgs.file

    if (Test-FileExists $packageArgs.file) {
        Write-Message "Install-FromZip: Unzipping to $($packageArgs.destination)"
        Get-ChocolateyUnzip  `
            -PackageName $packageArgs.packageName `
            -FileFullPath $packageArgs.file `
            -Destination $packageArgs.destination
    }
    elseif ($packageArgs.url) {
        Write-Message "Install-FromZip: Installing with Install-ChocolateyZipPackage"

        Install-ChocolateyZipPackage `
            -PackageName $packageArgs.packageName `
            -Url $packageArgs.Url `
            -UnzipLocation $packageArgs.destination
    }

    if ($packageArgs.executableRegEx) {
        Write-Message "Install-FromZip: No executable specified, using regex '$($packageArgs.executableRegEx)'"
        $packageArgs.file = Get-Executable $packageArgs.destination $packageArgs.executableRegEx

        # Re-map the file type
        $packageArgs.fileType = Get-FileExtension $packageArgs.file
    }
    elseif ($packageArgs.executable) {
        Write-Message "Install-FromZip: Finding executable '$($packageArgs.executable)' in $($ackageArgs.destination)"

        # Re-map the file to the unzip executable
        $packageArgs.file = Join-Path $packageArgs.destination $packageArgs.executable

        # Re-map the file type
        $packageArgs.fileType = Get-FileExtension $packageArgs.file

        if ($packageArgs.executableArgs) {
            # Re-map the silent arguments
            $packageArgs.silentArgs = $packageArgs.executableArgs
        }
    }

    # The original zip was extracted and the file was re-maped
    if ($originalFile -ne $packageArgs.file) {
        Write-Message "Install-FromZip: Installing with $($packageArgs.file)"
        Install-ChocolateyInstallPackage @packageArgs
    }

    if ($packageArgs.cleanUp) {
        Get-ChildItem -Path $env:ChocolateyPackageFolder `
            -Include *.zip, *.7z, *.exe, *.msi, *.reg -Recurse -File | Remove-Item
    }
}