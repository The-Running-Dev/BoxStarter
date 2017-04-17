function Install-FromZip {
    param([PSCustomObject] $arguments)

    if (Test-FileExists $arguments.file) {
        Write-Verbose "Install-FromZip: Unzipping to $($arguments.destination)"

        Get-ChocolateyUnzip `
            -FileFullPath $arguments.file `
            -Destination $arguments.destination -Force
    }
    elseif ($arguments.url) {
        Write-Verbose "Install-FromZip: Installing zip with Install-ChocolateyZipPackage"
        Install-ChocolateyZipPackage @arguments
    }

    if ($arguments.executableRegEx) {
        Write-Host "Install-FromZip: No executable specified, using regex '$($arguments.executableRegEx)'"
        $arguments.file = Get-Executable $arguments.destination $arguments.executableRegEx
    }
    else {
        # Remnap the file to the unzip executable
        $arguments.file = Join-Path $arguments.destination $arguments.executable
    }

    # Remnap the file type
    $arguments.fileType = Get-FileExtension $arguments.file

    Write-Host "Install-FromZip: Installing with $($arguments.file)"
    Install-ChocolateyInstallPackage @arguments
}