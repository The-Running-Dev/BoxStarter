$updatedOn = '2017.06.08 12:25:05'
$arguments = @{
    file       = 'Lan(v20.2_PV_v2).zip'
    url        = 'http://asrock.pc.cdn.bitgravity.com/Drivers/Intel/LAN/Lan(v20.2_PV_v2).zip'
    checksum   = '7D33EABB49D2B91D5883EFDC899E4636A33DC868199B96CBEFE7D068646ACE6E'
    executable = 'LAN(v20.2_PV_v2)\APPS\PROSETDX\Winx64\DxSetup.exe'
    silentArgs = '/quiet'
}

Install-FromZip $arguments
