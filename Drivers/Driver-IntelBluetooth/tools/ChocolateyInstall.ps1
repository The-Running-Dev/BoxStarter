$updatedOn = '2017.06.08 12:24:59'
$arguments = @{
    file           = 'Intel_Bluetooth(v19.10).zip'
    url            = 'http://asrock.pc.cdn.bitgravity.com/Drivers/Intel/Bluetooteh/Intel_Bluetooth(v19.10).zip'
    checksum       = 'D72E1E6AAD4F2CA947A443838CCF415580912EC13577E6257F1038CA35D2323D'
    executable     = 'Intel_Bluetooth(v19.10)\Win10\Intel Bluetooth.msi'
    validExitCodes = @(2304)
}

Install-FromZip $arguments
