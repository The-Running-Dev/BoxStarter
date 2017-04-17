function Get-Arguments {
    param([PSCustomObject] $arguments)

    $packageArgs = @{
        packageName = Get-Argument $arguments 'packageName' $env:ChocolateyPackageName
        softwareName = Get-Argument $arguments 'softwareName' $env:ChocolateyPackageTitle
        destination = Get-Argument $arguments 'destination' $env:ChocolateyPackageFolder
        url = Get-Argument $arguments 'url'
        file = Join-Path $env:ChocolateyPackageFolder (Get-Argument $arguments 'file' ([System.IO.Path]::GetFileName($arguments['url'])))
        executable = Get-Argument $arguments 'executable'
        executableRegEx = Get-Argument $arguments 'executableRegEx'
        checksum = Get-Argument $arguments 'checksum'
        checksumType = Get-Argument $arguments 'checksumType' 'sha256'
        silentArgs = Get-Argument $arguments 'silentArgs'
        validExitCodes = Get-Argument $arguments 'validExitCodes'
    }

    [Array]$packageArgs.validExitCodes += $global:defaultValidExitCodes
    $packageArgs.fileType = Get-FileExtension $packageArgs.file

    if (!$packageArgs.silentArgs -and $packageArgs.fileType -eq 'msi') {
        $packageArgs.silentArgs = '/quiet'
    }

    Write-Host "Get-Arguments: $($packageArgs | Out-String)"

    return $packageArgs
}