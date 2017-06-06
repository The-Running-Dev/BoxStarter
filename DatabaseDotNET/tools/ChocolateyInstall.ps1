$arguments = @{
    url        = 'http://fishcodelib.com/files/DatabaseNet4.zip'
    checksum   = 'D157DCB9F32B7BF6EC37DAB46102904CC5E941660C058A14BC08F7674FFEF3D2'
    destination = Join-Path $env:AppData 'DatabaseDotNET'
}

Install-FromZip $arguments

New-StartMenuShortcut (Join-Path $arguments.destination 'Database4.exe')
