$packageChecksum    = '33BAD182F3B58BF8B9D7796E5D7BAD8B4CA008ED3B96A842920B0AD1739D0C4FD1E9A7E0B170C4B819E1223B956E47B37CF7F2728ECE52C43A3D3D5ED91CD7FA'
$arguments          = @{
    file            = 'INF(v10.1.2.10).zip'
    url             = 'http://asrock.pc.cdn.bitgravity.com/Drivers/Intel/INF/INF(v10.1.2.10).zip'
    checksum        = 'D1E9A7E0B170C4B819E1223B956E47B37CF7F2728ECE52C43A3D3D5ED91CD7FA'
    executable      = 'INF(v10.1.2.10)\SetupChipset.exe'
    silentArgs      = '/S /v/qn'
}

Install-CustomPackage $arguments
