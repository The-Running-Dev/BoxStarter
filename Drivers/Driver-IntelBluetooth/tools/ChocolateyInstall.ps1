$updatedOn = '08FBE210827E689930D82B7A6D107A575A5026C8740083C1DDA85B565581E67BD72E1E6AAD4F2CA947A443838CCF415580912EC13577E6257F1038CA35D2323D'
$arguments = @{
    file           = 'Intel_Bluetooth(v19.10).zip'
    url            = 'http://asrock.pc.cdn.bitgravity.com/Drivers/Intel/Bluetooteh/Intel_Bluetooth(v19.10).zip'
    checksum       = 'D72E1E6AAD4F2CA947A443838CCF415580912EC13577E6257F1038CA35D2323D'
    executable     = 'Intel_Bluetooth(v19.10)\INF_INSTALL\Win10\x64\dpinst.exe'
    silentArgs     = '/q /se /sa /sw'
    validExitCodes = @(2304)
}

Install-CustomPackage $arguments