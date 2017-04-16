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

$x86Installer       = 'jre-8u121-windows-i586.exe'
$x64Installer       = 'jre-8u121-windows-x64.exe'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $env:ChocolateyPackageTitle
    destination   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $x64Installer
    url             = 'http://javadl.oracle.com/webapps/download/AutoDL?BundleId=218831_e9e7ea248e2c4826b92b3f075a80e441'
    url64           = 'http://javadl.oracle.com/webapps/download/AutoDL?BundleId=218833_e9e7ea248e2c4826b92b3f075a80e441'
    checksum        = '13d5ed94fe40d9403d5d25b1ef46593dc7f96993df735ea36a32db3dc8ed8ec7'
    checksum64      = '6741acefeb3845964534b3821d459b95c7dfa079f104c5041d1f95d3b6b7a502'
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
    Install-CustomPackage $arguments
}
else {
    if ((Get-ProcessorBits) -eq 64) {
        if (!($thisJreInstalledHash[1]) -and $exclude -ne '64') {
            Install-CustomPackage $arguments
        }
    }

    if (!($thisJreInstalledHash[0]) -and $exclude -ne '32') {
        $arguments['file'] = Join-Path $env:ChocolateyPackageFolder $x86Installer
        $arguments['url64'] = ''
        $arguments['checksum64'] = ''
        Install-CustomPackage $arguments
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
