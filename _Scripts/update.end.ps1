if ($force) {
    Update-Package -Force -ChecksumFor none -NoCheckChocoVersion
}
else {
    Update-Package -ChecksumFor none -NoCheckChocoVersion
}

$packageInstaller = Join-Path $packageDir ($Latest.FileName32 -replace '_x32', '')
$existingPackageInstaller = Join-Path $installersPath $Latest.FileName32

if ((Test-Path $packageInstaller) -and !(Test-Path($existingPackageInstaller))) {
    Move-Item $packageInstaller $installersPath -Force
    Move-Item "$($packageInstaller).ignore" $installersPath -Force
}

Remove-Item $packageInstaller -ErrorAction SilentlyContinue
Remove-Item "$($packageInstaller).ignore" -ErrorAction SilentlyContinue

if ($push) {
    & (Join-Path $PSScriptRoot ..\push.ps1) $Latest.PackageName
}

# Original location is defined in the individual update script
Set-Location $originalLocation