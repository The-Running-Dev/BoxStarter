$script             = $MyInvocation.MyCommand.Definition
$os                 = if (IsSystem32Bit) { "86" } else { "64" }
$arguments          = @{
    packageName     = 'ESETNod32Antivirus'
    unzipLocation   = (Get-CurrentDirectory $script)
    url             = 'https://download.eset.com/com/eset/apps/home/eav/windows/latest/eav_nt32_enu.exe'
    url64           = 'https://download.eset.com/com/eset/apps/home/eav/windows/latest/eav_nt64_enu.exe'
    checksum        = 'E327943B0BD61B43E6D19B1A51C950F1F0BE2119DAA57A3FE7EB2C75A832ECC3'
    checksum64      = '7DCE0D5DC064DCE7B2AA4EA2968EBE69843197F0BD12AB2E431A2A6C10852DB0'
    checksumType    = 'sha256'
    fileType        = 'exe'
    file            = Join-Path (Get-ParentDirectory $script) "eav_nt$($os)_enu.exe"
    softwareName    = 'ESETNod32Antivirus*'
    validExitCodes  = @(0, 3010, 1641)
}

# Launch the AutoHotkey script that install the application
Start-Process (Join-Path (Get-ParentDirectory $script) 'Install.exe')

Install-LocalOrRemote $arguments