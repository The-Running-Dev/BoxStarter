$arguments          = @{
    file            = 'eav_nt64_enu.exe'
    url             = 'https://download.eset.com/com/eset/apps/home/eav/windows/latest/eav_nt64_enu.exe'
    checksum        = '4D364E06035C4C2922E111D5FDA0C4EA1D0C7F496E2644B30869C70B910584FA'
}

Install-WithAutoHotKey $arguments
