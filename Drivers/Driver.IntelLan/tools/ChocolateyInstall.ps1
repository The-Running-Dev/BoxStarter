$packageChecksum    = '5621BB371C03C07EA179F6E35551D6B1819E8BF2EBC54EDD4285D898452584277D33EABB49D2B91D5883EFDC899E4636A33DC868199B96CBEFE7D068646ACE6E'
$arguments          = @{
    file            = 'Lan(v20.2_PV_v2).zip'
    url             = 'http://asrock.pc.cdn.bitgravity.com/Drivers/Intel/LAN/Lan(v20.2_PV_v2).zip'
    checksum        = '7D33EABB49D2B91D5883EFDC899E4636A33DC868199B96CBEFE7D068646ACE6E'
    executable      = 'LAN(v20.2_PV_v2)\APPS\PROSETDX\Winx64\DxSetup.exe'
    silentArgs      = '/quiet'
}

Install-CustomPackage $arguments
