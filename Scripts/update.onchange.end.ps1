if ($force) {
    Update-Package -Force -ChecksumFor none -NoCheckChocoVersion -NoCheckUrl
}
else {
    Update-Package -ChecksumFor none -NoCheckChocoVersion -NoCheckUrl
}

if ($push) {
    & (Join-Path $PSScriptRoot ..\push.ps1) $Latest.PackageName
}

Pop-Location