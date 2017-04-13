function Get-InstallerFromIso([Hashtable] $arguments) {
    $file = $arguments['file']
    $baseDir = $arguments['unzipLocation']
    $executable = $arguments['executable']
    $executableRegEx = $arguments['executableRegEx']
    $isoPath = $file

    if (![System.IO.Path]::IsPathRooted($file)) {
        $isoPath = Join-Path (Get-BaseDirectory) $file

        # No ISO found in the package
        if (!(Test-Path $isoPath)) {
            # Reset the base directory
            $isoPath = Join-Path (Get-BaseDirectory '') $file

            if (!(Test-Path $isoPath)) {
                return
            }
        }
    }

    $global:mustDismountIso = $true
    $global:isoPath = $isoPath

    $iso = Mount-DiskImage $isoPath -PassThru
    $driveLetter = ($iso | Get-Volume).DriveLetter
    Get-PSDrive | Out-Null

    return Get-Executable "$driveLetter`:\" $executable $exeRegEx
}