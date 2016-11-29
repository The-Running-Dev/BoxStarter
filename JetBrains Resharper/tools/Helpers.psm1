function Install {
param(
    [string] $packageName,
    [string] $url,
    [string] $checksum,
    [string] $silentArgs
)
    $installerType = 'exe'
    $validExitCodes = @(0)
    $checksumType = 'sha256';

    Install-ChocolateyPackage $packageName `
        $installerType `
        $silentArgs `
        $url `
        $url `
        -validExitCodes $validExitCodes `
        -Checksum64 $checksum `
        -ChecksumType64 $checksumType `
        -ChecksumType $checksumType `
        -Checksum $checksum
}

Export-ModuleMember *