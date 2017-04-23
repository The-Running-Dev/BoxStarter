function Get-Arguments {
    param(
        [PSCustomObject] $arguments
    )

    $packageArgs = @{
        packageName = Get-Argument $arguments 'packageName' $env:ChocolateyPackageName
        softwareName = Get-Argument $arguments 'softwareName' $env:ChocolateyPackageTitle
        destination = Get-Argument $arguments 'destination' $env:ChocolateyPackageFolder
        url = Get-Argument $arguments 'url'
        file = Get-Argument $arguments 'file' ([System.IO.Path]::GetFileName($arguments.url))
        executablePackageName = Get-Argument $arguments 'executablePackageName'
        executable = Get-Argument $arguments 'executable'
        executableArgs = Get-Argument $arguments 'executableArgs'
        executableRegEx = Get-Argument $arguments 'executableRegEx'
        processName = Get-Argument $arguments 'processName'
        checksum = Get-Argument $arguments 'checksum'
        checksumType = Get-Argument $arguments 'checksumType' 'sha256'
        silentArgs = Get-Argument $arguments 'silentArgs'
        validExitCodes = (Get-Argument $arguments 'validExitCodes')
    }

    [Array]$packageArgs.validExitCodes += $global:defaultValidExitCodes

    $packageArgs.fileType = Get-FileExtension $packageArgs.file
    $packageArgs.executableType = Get-FileExtension $executable.file

    # The file parameter does not contain a full path
    if (![System.IO.Path]::IsPathRooted($packageArgs.file)) {
        $packageArgs.file = Join-Path $env:ChocolateyPackageFolder $packageArgs.file
    }

    # No file provided, find the first executable or zip in the package directory
    if (![System.IO.File]::Exists($packageArgs.file) -and !$packageArgs.url) {
        $packageArgs.file = (Get-ChildItem -Path $env:ChocolateyPackageFolder `
            -Include *.zip, *.exe, *.msi, *.reg -Recurse -File `
            | Select-Object -First 1 -ExpandProperty FullName)
    }

    # No silent arguments provided and the file type is MSI
    if (!$packageArgs.silentArgs -and $packageArgs.fileType -eq 'msi') {
        $packageArgs.silentArgs = '/quiet'
    }

    # No executable silent arguments provided and the executable file type is MSI
    if (!$packageArgs.executableArgs -and $packageArgs.executableType -eq 'msi') {
        $packageArgs.executableArgs = '/quiet'
    }

    Write-Message "Get-Arguments: $($packageArgs | Out-String)"

    return $packageArgs
}