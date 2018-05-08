if ($force) {
    Write-Host "Running Update: Update-Package -Force -ChecksumFor none -NoCheckChocoVersion -NoCheckUrl"
    Update-Package -Force -ChecksumFor none -NoCheckChocoVersion -NoCheckUrl
}
else {
    Write-Host "Running Update: Update-Package -ChecksumFor none -NoCheckChocoVersion -NoCheckUrl"
    Update-Package -ChecksumFor none -NoCheckChocoVersion -NoCheckUrl
}

Pop-Location