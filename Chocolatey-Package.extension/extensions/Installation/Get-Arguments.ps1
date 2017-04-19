function Get-Arguments {
    param(
        [PSCustomObject] $arguments
    )

    $packageArgs = @{
        packageName = Get-Argument $arguments 'packageName' $env:ChocolateyPackageName
        softwareName = Get-Argument $arguments 'softwareName' $env:ChocolateyPackageTitle
        destination = Get-Argument $arguments 'destination' $env:ChocolateyPackageFolder
        url = Get-Argument $arguments 'url'
        file = Join-Path $env:ChocolateyPackageFolder (Get-Argument $arguments 'file' ([System.IO.Path]::GetFileName($arguments['url'])))
        executable = Get-Argument $arguments 'executable'
        executableArgs = Get-Argument $arguments 'executableArgs'
        executableRegEx = Get-Argument $arguments 'executableRegEx'
        checksum = Get-Argument $arguments 'checksum'
        checksumType = Get-Argument $arguments 'checksumType' 'sha256'
        silentArgs = Get-Argument $arguments 'silentArgs'
        validExitCodes = Get-Argument $arguments 'validExitCodes'
    }

    [Array]$packageArgs.validExitCodes += $global:defaultValidExitCodes
    $packageArgs.fileType = Get-FileExtension $packageArgs.file
    $packageArgs.executableType = Get-FileExtension $executable.file

    # No file provided, find the first executable or zip in the package directory
    if (![System.IO.File]::Exists($packageArgs.file)) {
        $packageArgs.file = (Get-ChildItem -Path $env:ChocolateyPackageFolder -Include *.zip, *.exe, *.msi -Recurse -File `
            | Select-Object -First 1 -ExpandProperty FullName)
    }

    if (!$packageArgs.silentArgs -and $packageArgs.fileType -eq 'msi') {
        $packageArgs.silentArgs = '/quiet'
    }

    if (!$packageArgs.executableArgs -and $packageArgs.executableType -eq 'msi') {
        $packageArgs.executableArgs = '/quiet'
    }

    Write-Message "Get-Arguments: $($packageArgs | Out-String)"

    return $packageArgs
}