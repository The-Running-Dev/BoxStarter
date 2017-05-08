if ($force) {
    Update-Package -Force -ChecksumFor none -NoCheckChocoVersion -NoCheckUrl
}
else {
    Update-Package -ChecksumFor none -NoCheckChocoVersion -NoCheckUrl
}

$packageInstaller = Join-Path $packageDir $Latest.FileName32
$existingPackageInstaller = Join-Path $installersPath $Latest.FileName32

if ([System.IO.File]::Exists($packageInstaller) -and ![System.IO.File]::Exists($existingPackageInstaller)) {
    # Get the beggining of the installer name, without the version
    $installer = $packageInstaller -replace '.*\\([a-z0-9]+).*$', '$1'

    # Delete any previous versions of the same installer
    Get-ChildItem $installersPath -File | `
        Where-Object { $_.Name -match $installer } | Remove-Item

    Move-Item $packageInstaller $installersPath -Force
}

Remove-Item $packageInstaller -ErrorAction SilentlyContinue
Remove-Item "$($packageInstaller).ignore" -ErrorAction SilentlyContinue

if ($push) {
    & (Join-Path $PSScriptRoot ..\push.ps1) $Latest.PackageName
}

Pop-Location