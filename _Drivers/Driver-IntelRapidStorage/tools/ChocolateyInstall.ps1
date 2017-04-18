$packageChecksum    = '2C1923082BDD5586D0D83534AA0FFA716B856000C51B75FBF42ABC5DFF80D3B940F07F0173889651B3D1E72BC657E1C2EAA85744B4D0AC23926957FF63548E5E'
$arguments          = @{
    file            = 'RapidStorage(v14.8.0.1042_PV).zip'
    url             = 'http://asrock.pc.cdn.bitgravity.com/Drivers/Intel/SATA/RapidStorage(v14.8.0.1042_PV).zip'
    checksum        = '40F07F0173889651B3D1E72BC657E1C2EAA85744B4D0AC23926957FF63548E5E'
    executable      = 'RapidStorage(v14.8.0.1042_PV)\SetupRST.exe'
    silentArgs      = '-s -overwrite'
}

Install-CustomPackage $arguments
