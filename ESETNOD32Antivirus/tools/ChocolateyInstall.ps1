$arguments          = @{
    file            = 'eav_nt64_enu.exe'
    url             = 'https://download.eset.com/com/eset/apps/home/eav/windows/latest/eav_nt64_enu.exe'
    checksum        = '8265FCFCD9C5B6E03B9B39304AB451922068FA2BED68A0A6D95D2E8BEEFD8EA9'
}

Install-WithAutoHotKey $arguments
