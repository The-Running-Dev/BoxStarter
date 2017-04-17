$packageChecksum        = '38773EF4A60C58F6404343785E628FB9E0604BE7D89D550E47F37C480C1A23E0FA11CDA561EDD59D01049C707F0EA5765F04D838E78CD32CB22096793CDC8311'
$arguments              = @{
    file                = 'ASMedia_USB3.1(v1.16.35.1).zip'
    url                 = 'http://asrock.pc.cdn.bitgravity.com/Drivers/All/USB/ASMedia_USB3.1(v1.16.35.1).zip'
    checksum            = '38773EF4A60C58F6404343785E628FB9E0604BE7D89D550E47F37C480C1A23E0'
    executableRegEx     = 'Setup\.exe'
    silentArgs          = '/S /v/qn'
}

Install-CustomPackage $arguments
