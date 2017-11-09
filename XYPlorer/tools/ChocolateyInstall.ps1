$arguments      = @{
    url         = 'https://www.xyplorer.com/download/xyplorer_full_noinstall.zip'
    checksum    = '76850A76C2AFE3B89E858D30C4EA00EC57EB4587597776086DF5E01927051683'
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
