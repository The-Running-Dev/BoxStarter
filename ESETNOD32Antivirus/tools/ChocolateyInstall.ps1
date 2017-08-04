$arguments          = @{
    file            = 'eav_nt64_enu.exe'
    url             = 'https://download.eset.com/com/eset/apps/home/eav/windows/latest/eav_nt64_enu.exe'
    checksum        = '2BB99B28191BDE91C0C4182C10BF78FB9D2396C28A7D5D69EDDE7DB686AB903C'
}

Install-WithAutoHotKey $arguments
