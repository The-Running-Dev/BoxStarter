$packageChecksum    = 'B93AAB9D1099D48C6A6E1940A81FE0D447C19CC87FC18A4830111FC9A26326EF7D33EABB49D2B91D5883EFDC899E4636A33DC868199B96CBEFE7D068646ACE6E'
$arguments          = @{
    file            = 'Lan(v20.2_PV_v2).zip'
    url             = 'http://asrock.pc.cdn.bitgravity.com/Drivers/Intel/LAN/Lan(v20.2_PV_v2).zip'
    checksum        = '7D33EABB49D2B91D5883EFDC899E4636A33DC868199B96CBEFE7D068646ACE6E'
    executable      = 'LAN(v20.2_PV_v2)\APPS\PROSETDX\Winx64\DxSetup.exe'
    silentArgs      = '/quiet'
}

Install-CustomPackage $arguments
