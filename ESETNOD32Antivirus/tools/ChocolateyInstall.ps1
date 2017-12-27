$arguments          = @{
    file            = 'eav_nt64_enu.exe'
    url             = 'https://download.eset.com/com/eset/apps/home/eav/windows/latest/eav_nt64_enu.exe'
    checksum        = 'BA3E41D793D8A0D741954BCDCA646BD37327207AA4CBE77EB92C77D5C7CB7BBC'
}

Install-WithAutoHotKey $arguments
