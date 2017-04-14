function Get-InstallerFromIso([Hashtable] $arguments) {
    $file = $arguments['file']
    $baseDir = $arguments['unzipLocation']
    $executable = $arguments['executable']
    $executableRegEx = $arguments['executableRegEx']
    $isoPath = $file

    if (![System.IO.Path]::IsPathRooted($file)) {
        Write-Verbose "Get-InstallerFromIso: $file is a relative path"
        $isoPath = Join-Path (Get-BaseDirectory) $file

        # No ISO found in the package
        if (!(Test-Path $isoPath)) {
            Write-Verbose "Get-InstallerFromIso: No ISO in package"

            # Reset the base directory
            $isoPath = Join-Path (Get-BaseDirectory '') $file

            Write-Verbose "Get-InstallerFromIso: ISO set to $isoPath"

            if (!(Test-Path $isoPath)) {
                Write-Verbose "Get-InstallerFromIso: No ISO found"
                return
            }`
        }
    }

    $global:mustDismountIso = $true
    $global:isoPath = $isoPath

    $iso = Mount-DiskImage $isoPath -PassThru
    $driveLetter = ($iso | Get-Volume).DriveLetter
    Get-PSDrive | Out-Null

    return Get-Executable "$driveLetter`:\" $executable $exeRegEx
}