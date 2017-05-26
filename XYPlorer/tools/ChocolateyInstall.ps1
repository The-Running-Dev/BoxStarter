$arguments      = @{
    url         = 'https://www.xyplorer.com/download/xyplorer_full_noinstall.zip'
    checksum    = 'CEF786ED5A6AC5500662EEFAA0C67FF1BF981C870552368E090FC9EB2F5CE675'
    destination = Join-Path $env:AppData 'XYplorer'
}

$process = (Get-Process -name 'XYplorer' -ErrorAction SilentlyContinue)

if ($process) {
    Stop-Process $process
}

Install-FromZip $arguments

if ($process) {
    & (Join-Path $arguments.destination 'XYPlorer.exe')
}
