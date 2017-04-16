$packageChecksum        = '38773EF4A60C58F6404343785E628FB9E0604BE7D89D550E47F37C480C1A23E0D5218CE0F2B5496BD52532E158200329BB4DBCEB0E4D4211E13E9D95889B4A62'
$arguments              = @{
    file                = 'ASMedia_USB3.1(v1.16.35.1).zip'
    url                 = 'http://asrock.pc.cdn.bitgravity.com/Drivers/All/USB/ASMedia_USB3.1(v1.16.35.1).zip'
    checksum            = '38773EF4A60C58F6404343785E628FB9E0604BE7D89D550E47F37C480C1A23E0'
    executableRegEx     = 'Setup\.exe'
    silentArgs          = '/S /v/qn'
}

Install-CustomPackage $arguments
