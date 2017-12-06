$arguments      = @{
    url         = 'https://www.xyplorer.com/download/xyplorer_full_noinstall.zip'
    checksum    = '3E2F7E179668439646ADE4C37891BE9F05193565B28E7519397B598ED3811765'
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
