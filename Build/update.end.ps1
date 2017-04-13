if ($force) {
    Update-Package -Force -ChecksumFor none -NoCheckChocoVersion
}
else {
    Update-Package -ChecksumFor none -NoCheckChocoVersion
}

$installer = Join-Path $packageDir ($Latest.FileName32 -replace '_x32', '')
Remove-Item $installer -ErrorAction SilentlyContinue
Remove-Item "$($installer).ignore" -ErrorAction SilentlyContinue