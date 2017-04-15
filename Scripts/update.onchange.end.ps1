if ($force) {
    Update-Package -Force -ChecksumFor none -NoCheckChocoVersion
}
else {
    Update-Package -ChecksumFor none -NoCheckChocoVersion
}

if ($push) {
    & (Join-Path $PSScriptRoot ..\push.ps1) $Latest.PackageName
}

# Original location is defined in the individual update script
Set-Location $originalLocation