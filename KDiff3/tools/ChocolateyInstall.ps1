$arguments      = @{
    url         = 'https://downloads.sourceforge.net/project/kdiff3/kdiff3/0.9.98/KDiff3-64bit-Setup_0.9.98-2.exe'
    checksum    = 'D630AB0FDCA3B4F1A85AB7E453F669FDC901CB81BB57F7E20DE64C02AC9A1EEB'
    silentArgs  = '/S'
}

Install-Package $arguments
