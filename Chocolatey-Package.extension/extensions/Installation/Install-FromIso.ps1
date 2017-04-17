function Get-InstallerFromIso {
    param(
        [PSCustomObject] $arguments
    )

    if (![System.IO.Path]::IsPathRooted($arguments.file)) {
        Write-Message "Get-InstallerFromIso: $arguments.file is a relative path"
        $isoPath = Join-Path (Get-BaseDirectory) $arguments.file

        # No ISO found in the package
        if (!(Test-Path $isoPath)) {
            Write-Message "Get-InstallerFromIso: No ISO in package"

            # Reset the base directory
            $isoPath = Join-Path (Get-BaseDirectory '') $arguments.file

            Write-Message "Get-InstallerFromIso: ISO set to $isoPath"

            if (!(Test-Path $isoPath)) {
                Write-Message "Get-InstallerFromIso: No ISO found"
                return
            }`
        }
    }

    $global:mustDismountIso = $true
    $global:isoPath = $isoPath

    $iso = Mount-DiskImage $isoPath -PassThru
    $driveLetter = ($iso | Get-Volume).DriveLetter
    Get-PSDrive | Out-Null

    return Get-Executable "$driveLetter`:\" $arguments.executableRegEx
}