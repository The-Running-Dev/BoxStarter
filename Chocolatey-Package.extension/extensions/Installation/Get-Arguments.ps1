function Get-Arguments {
    param(
        [PSCustomObject] $arguments
    )

    $packageArgs = @{}

    $arguments.GetEnumerator() | ForEach-Object {
        $packageArgs[$_.Key] = $_.Value
    }

    $packageArgs.packageName = Get-Argument $arguments 'packageName' $env:ChocolateyPackageName
    $packageArgs.softwareName = Get-Argument $arguments 'softwareName' $env:ChocolateyPackageTitle
    $packageArgs.destination = Get-Argument $arguments 'destination' $env:ChocolateyPackageFolder
    $packageArgs.url = Get-Argument $arguments 'url'
    $packageArgs.file = Get-Argument $arguments 'file' ([System.IO.Path]::GetFileName($arguments.url) -replace '%20', ' ')
    $packageArgs.executablePackageName = Get-Argument $arguments 'executablePackageName'
    $packageArgs.executable = Get-Argument $arguments 'executable'
    $packageArgs.executableArgs = Get-Argument $arguments 'executableArgs'
    $packageArgs.executableRegEx = Get-Argument $arguments 'executableRegEx'
    $packageArgs.processName = Get-Argument $arguments 'processName'
    $packageArgs.checksum = Get-Argument $arguments 'checksum'
    $packageArgs.checksumType = Get-Argument $arguments 'checksumType' 'sha256'
    $packageArgs.silentArgs = Get-Argument $arguments 'silentArgs'
    $packageArgs.validExitCodes = (Get-Argument $arguments 'validExitCodes')

    [Array]$packageArgs.validExitCodes += $global:defaultValidExitCodes

    # The file parameter does not contain a full path
    if (![System.IO.Path]::IsPathRooted($packageArgs.file)) {
        $packageArgs.file = Join-Path $env:ChocolateyPackageFolder $packageArgs.file
    }

    # No file provided, find the first executable or zip in the package directory
    if (![System.IO.File]::Exists($packageArgs.file) -and !$packageArgs.url) {
        $packageArgs.file = (Get-ChildItem -Path $env:ChocolateyPackageFolder `
            -Include *.zip, *.7z, *.tar.gz, *.exe, *.msi, *.reg -Recurse -File `
            | Select-Object -First 1 -ExpandProperty FullName)
    }

    $packageArgs.fileType = Get-FileExtension $packageArgs.file
    $packageArgs.executableType = Get-FileExtension $executable.file

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