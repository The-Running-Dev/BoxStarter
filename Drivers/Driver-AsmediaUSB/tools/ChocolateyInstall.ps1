$updatedOn = '2017.06.08 12:24:56'
$arguments = @{
    file            = 'ASMedia_USB3.1(v1.16.35.1).zip'
    url             = 'http://asrock.pc.cdn.bitgravity.com/Drivers/All/USB/ASMedia_USB3.1(v1.16.35.1).zip'
    checksum        = '38773EF4A60C58F6404343785E628FB9E0604BE7D89D550E47F37C480C1A23E0'
    executableRegEx = 'Setup\.exe'
    silentArgs      = '/S /v/qn'
}

Install-CustomPackage $arguments
