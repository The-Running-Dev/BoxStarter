if ($force) {
    Update-Package -Force -ChecksumFor none -NoCheckChocoVersion -NoCheckUrl
}
else {
    Update-Package -ChecksumFor none -NoCheckChocoVersion -NoCheckUrl
}

# Only cleanup if this is not a personal package
if ($Latest.PackageName -notmatch '\-Personal$') {
    $packageInstaller = Join-Path $packageInstallerDir $Latest.FileName32
    $existingPackageInstaller = Join-Path $installersPath $Latest.FileName32

    if (((Test-FileExists $packageInstaller) -and (-not (Test-FileExists $existingPackageInstaller))) -or $Latest.UpdateInstaller) {
        # Get the beggining of the installer name, without the version
        $installer = $packageInstaller -replace '.*\\([a-z0-9]+).*$', '$1'

        # Delete any previous versions of the same installer
        Get-ChildItem $installersPath -File | `
            Where-Object { $_.Name -match $installer } | Remove-Item

        Move-Item $packageInstaller $installersPath -Force
    }

    Remove-Item $packageInstaller -ErrorAction SilentlyContinue
    Remove-Item "$($packageInstaller).ignore" -ErrorAction SilentlyContinue
}

Pop-Location