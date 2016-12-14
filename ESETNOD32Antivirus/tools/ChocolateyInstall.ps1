$script           = $MyInvocation.MyCommand.Definition
$os               = if (IsSystem32Bit) { "86" } else { "64" }
$packageArgs      = @{
    packageName     = 'ESETNod32Antivirus'
    unzipLocation   = (Get-CurrentDirectory $script)
    url             = 'https://download.eset.com/com/eset/apps/home/eav/windows/latest/eav_nt64_enu.exe'
    url64           = 'https://download.eset.com/com/eset/apps/home/eav/windows/latest/eav_nt32_enu.exe'
    checksum        = 'B916E6ABD6198C1739E695E9350F8609A9AF84E08DC5F4FCAE9B446543CF788F'
    checksum64      = '3799DC039B8263385C3A9CC75EA2D76758092BFBE0F9C729C9A1E582088CA5D7'
    checksumType    = 'sha256'
    fileType        = 'exe'
    file            = Join-Path (Get-ParentDirectory $script) "eav_nt$($os)_enu.exe"
    softwareName    = 'ESETNod32Antivirus*'
    validExitCodes  = @(0, 3010, 1641)
}

# Launch the AutoHotkey script that install the application
Start-Process (Join-Path (Get-ParentDirectory $script) 'Install.exe')

Install-LocalOrRemote $packageArgs