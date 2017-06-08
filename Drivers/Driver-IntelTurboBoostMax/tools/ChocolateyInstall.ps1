$updatedOn = '2017.06.08 12:25:14'
$arguments = @{
    file       = 'ITBM_v1.0.0.1027.zip'
    url        = 'http://asrock.pc.cdn.bitgravity.com/Drivers/Intel/Others/ITBM_v1.0.0.1027.zip'
    checksum   = 'F63F64610A842CC4B3BB2D006389C4358E4018492D07AE046626DC745A4C6014'
    executable = 'ITBM_v1.0.0.1027\ITBM_Setup(v1.0.0.1027).exe'
    silentArgs = '/SP- /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /NOCLOSEAPPLICATIONS /NORESTARTAPPLICATIONS /NOICONS'
}

Install-CustomPackage $arguments
