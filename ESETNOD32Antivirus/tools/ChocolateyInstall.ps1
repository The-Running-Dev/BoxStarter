$arguments          = @{
    file            = 'eav_nt64_enu.exe'
    url             = 'https://download.eset.com/com/eset/apps/home/eav/windows/latest/eav_nt64_enu.exe'
    checksum        = 'BE7CFCE74859DFB70FC72CF9F363BDC59019D3CF471F840A0ADECC35829DCAC6'
}

Install-WithAutoHotKey $arguments
