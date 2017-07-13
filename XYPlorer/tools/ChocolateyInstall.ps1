$arguments      = @{
    url         = 'https://www.xyplorer.com/download/xyplorer_full_noinstall.zip'
    checksum    = '0C717715310A8F124AA40F7C269395DB05015A2B0DAC49144D94386698D53E6B'
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
