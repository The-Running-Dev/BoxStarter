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

$x86Installer       = 'jre-8u161-windows-i586.exe'
$arguments          = @{
    file            = 'jre-8u161-windows-x64.exe'
    url             = 'http://javadl.oracle.com/webapps/download/AutoDL?BundleId=230540_2f38c3b165be4555a1fa6e98c45e0808'
    url64           = 'http://javadl.oracle.com/webapps/download/AutoDL?BundleId=230542_2f38c3b165be4555a1fa6e98c45e0808'
    checksum        = '9D4AB1C5EFF210FD165A1ACA33734DA82C6BAC9437BD8F20637E68460F3E9008'
    checksum64      = '59C02EB80ACFAEEAF3728C3841440C68EA9E3B4D5E735A7A863F6E2492760B5D'
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
        $arguments.url64 = 'http://javadl.oracle.com/webapps/download/AutoDL?BundleId=230542_2f38c3b165be4555a1fa6e98c45e0808'
        $arguments.checksum64 = '59C02EB80ACFAEEAF3728C3841440C68EA9E3B4D5E735A7A863F6E2492760B5D'

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
