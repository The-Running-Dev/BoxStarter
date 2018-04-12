$arguments          = @{
    file            = 'eav_nt64_enu.exe'
    url             = 'https://download.eset.com/com/eset/apps/home/eav/windows/latest/eav_nt64_enu.exe'
    checksum        = '9241F7721BB588246C6C46322B8B278566F613609DA0D35F4AA1AE04B40114C4'
}

Install-WithAutoHotKey $arguments
