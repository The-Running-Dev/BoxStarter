$arguments      = @{
    url         = 'https://www.xyplorer.com/download/xyplorer_full_noinstall.zip'
    checksum    = '4B35C11B4BE1749A320A626CC029DE870F44689FD205407E9EDD8DF424460737'
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
