$updatedOn = '2017.06.08 12:24:58'
$arguments = @{
    file       = 'INF(v10.1.2.10).zip'
    url        = 'http://asrock.pc.cdn.bitgravity.com/Drivers/Intel/INF/INF(v10.1.2.10).zip'
    checksum   = 'D1E9A7E0B170C4B819E1223B956E47B37CF7F2728ECE52C43A3D3D5ED91CD7FA'
    executable = 'INF(v10.1.2.10)\SetupChipset.exe'
    silentArgs = '/S /v/qn'
}

Install-FromZip $arguments
