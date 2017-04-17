function Install-FromZip {
    param(
        [PSCustomObject] $arguments
    )

    $originalFile = $arguments.file

    if (Test-FileExists $arguments.file) {
        Write-Message "Install-FromZip: Unzipping to $($arguments.destination)"

         Get-ChocolateyUnzip @arguments
    }
    elseif ($arguments.url) {
        Write-Message "Install-FromZip: Installing zip with Install-ChocolateyZipPackage"
        Install-ChocolateyZipPackage @arguments
    }

    if ($arguments.executableRegEx) {
        Write-Message "Install-FromZip: No executable specified, using regex '$($arguments.executableRegEx)'"
        $arguments.file = Get-Executable $arguments.destination $arguments.executableRegEx

        # Re-map the file type
        $arguments.fileType = Get-FileExtension $arguments.file
    }
    elseif ($arguments.executable) {
        Write-Message "Install-FromZip: Finding executable '$($arguments.executable)' in $arguments.destination"
        # Re-map the file to the unzip executable
        $arguments.file = Join-Path $arguments.destination $arguments.executable

        # Re-map the file type
        $arguments.fileType = Get-FileExtension $arguments.file
    }

    # The original zip was extracted and the file was re-maped
    if ($originalFile -ne $arguments.file) {
        Write-Message "Install-FromZip: Installing with $($arguments.file)"
        Install-ChocolateyInstallPackage @arguments
    }
}