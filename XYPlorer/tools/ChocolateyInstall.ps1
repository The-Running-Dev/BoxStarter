$arguments      = @{
    file        = 'xyplorer_full_noinstall.zip'
    url         = 'https://www.xyplorer.com/download/xyplorer_full_noinstall.zip'
    checksum    = '1221906C44485F0446B32BEBC7AF6C9F08A20672EF2D4787C09BC5C1744BC21F'
    destination = Join-Path $env:AppData 'XYplorer'
}

Install-FromZip $arguments