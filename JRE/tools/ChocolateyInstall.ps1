function thisJreInstalled($version) {
    $productSearch = Get-WmiObject -Class Win32_Product | Where-Object {$_.Name -match '^Java \d+ Update \d+'}

    # The regexes for the name of the JRE registry entries (32- and 64 bit versions)
    $nameRegex32 = '^Java \d+ Update \d+$'
    $nameRegex64 = '^Java \d+ Update \d+ \(64-bit\)$'
    $versionRegex = $('^' + $version + '\d*$')

    $x86_32 = $productSearch | Where-Object {$_.Name -match $nameRegex32 -and $_.Version -match $versionRegex}
    $x86_64 = $productSearch | Where-Object {$_.Name -match $nameRegex64 -and $_.Version -match $versionRegex}

    if ($x86_32 -eq $null) {
        $x86_32 = $false
    }

    if ($x86_64 -eq $null) {
        $x86_64 = $false
    }

    return $x86_32, $x86_64
}

$x86Installer       = 'jre-8u171-windows-i586.exe'
$arguments          = @{
    file            = 'jre-8u171-windows-x64.exe'
    url             = 'http://javadl.oracle.com/webapps/download/AutoDL?BundleId=233170_512cd62ec5174c3487ac17c61aaa89e8'
    url64           = 'http://javadl.oracle.com/webapps/download/AutoDL?BundleId=233172_512cd62ec5174c3487ac17c61aaa89e8'
    checksum        = 'ECAA6BF5DC3C02D5F3A93382268D44B1540F322C508E88E679CA17F8DCC906D7'
    checksum64      = 'D5256B3D1A6DA959EA98EA2A2BE3A05A7DF9D1A5CD75DB3930F935AB71CE43B8'
    fileType        = 'exe'
    checksumType    = 'sha256'
    checksumType64  = 'sha256'
    silentArgs      = "/s REBOOT=0 SPONSORS=0 AUTO_UPDATE=0 REMOVEOUTOFDATEJRES=1"
    validExitCodes  = @(0, 1641, 3010)
}

$parameters = Get-Parameters $env:chocolateyPackageParameters
if ($parameters.ContainsKey("exclude")) {
    $exclude = $arguments["exclude"]
}

$thisJreInstalledHash = thisJreInstalled($version)

if (!($thisJreInstalledHash[0]) -and !($thisJreInstalledHash[1])) {
    Install-Package $arguments
}
else {
    if ((Get-ProcessorBits) -eq 64) {
        if (!($thisJreInstalledHash[1]) -and $exclude -ne '64') {
            Install-Package $arguments
        }
    }

    if (!($thisJreInstalledHash[0]) -and $exclude -ne '32') {
        $arguments.file = Join-Path $env:ChocolateyPackageFolder $x86Installer
        $arguments.url64 = 'http://javadl.oracle.com/webapps/download/AutoDL?BundleId=233172_512cd62ec5174c3487ac17c61aaa89e8'
        $arguments.checksum64 = 'D5256B3D1A6DA959EA98EA2A2BE3A05A7DF9D1A5CD75DB3930F935AB71CE43B8'

        Install-Package $arguments
    }
}

#Uninstalls the previous version of Java if either version exists
$oldJreInstalledHash = thisJreInstalled($oldVersion)

if ($oldJreInstalledHash[0]) {
    $32 = $oldJreInstalledHash[0].IdentifyingNumber
    Start-ChocolateyProcessAsAdmin "/qn /norestart /X$32" -exeToRun "msiexec.exe" -validExitCodes @(0, 1605, 3010)
}

if ($oldJreInstalledHash[1]) {
    $64 = $oldJreInstalledHash[1].IdentifyingNumber
    Start-ChocolateyProcessAsAdmin "/qn /norestart /X$64" -exeToRun "msiexec.exe" -validExitCodes @(0, 1605, 3010)
}
