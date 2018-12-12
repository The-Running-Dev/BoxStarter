$arguments          = @{
    file            = 'eav_nt64_enu.exe'
    url             = 'https://download.eset.com/com/eset/apps/home/eav/windows/latest/eav_nt64_enu.exe'
    checksum        = 'C0D377FFBE419E5E84986690B0C22BBF54B5D480FB819C6FFCB2F3DD51568216'
}

Install-WithAutoHotKey $arguments
