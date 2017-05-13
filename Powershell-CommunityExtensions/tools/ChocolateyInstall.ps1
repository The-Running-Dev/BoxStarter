$arguments          = @{
    file            = 'Pscx-3.2.0.msi'
    url             = 'http://download-codeplex.sec.s-msft.com/Download/Release?ProjectName=pscx&DownloadId=923562&FileTime=130585918034470000&Build=21050'
    checksum        = '4C823A86B5EFE3313201F5531BA99D55C95C75C5F9D941A130A75E243D7F3E82'
}

Install-Package $arguments
