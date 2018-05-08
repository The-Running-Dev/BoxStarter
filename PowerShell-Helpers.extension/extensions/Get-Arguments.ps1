function Get-Arguments {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, ValueFromPipeline)][PSCustomObject] $arguments
    )

    $packageArgs = @{}

    if ($arguments) {
        $arguments.GetEnumerator() | ForEach-Object {
            $packageArgs[$_.Key] = $_.Value
        }
    }

    $packageArgs.packageName = Get-Argument $arguments 'packageName' $env:ChocolateyPackageName
    $packageArgs.softwareName = Get-Argument $arguments 'softwareName' $env:ChocolateyPackageTitle
    $packageArgs.destination = Get-Argument $arguments 'destination' $env:ChocolateyPackageFolder
    $packageArgs.url = Get-Argument $arguments 'url'
    $packageArgs.file = Get-Argument $arguments 'file' ([System.IO.Path]::GetFileName($arguments.url) -replace '%20', ' ')
    $packageArgs.fileFullPath = Join-Path $env:ChocolateyPackageFolder ([System.IO.Path]::GetFileName($packageArgs.file))
    $packageArgs.executablePackageName = Get-Argument $arguments 'executablePackageName'
    $packageArgs.executable = Get-Argument $arguments 'executable'
    $packageArgs.executableArgs = Get-Argument $arguments 'executableArgs'
    $packageArgs.executableRegEx = Get-Argument $arguments 'executableRegEx'
    $packageArgs.processName = Get-Argument $arguments 'processName'
    $packageArgs.checksum = Get-Argument $arguments 'checksum'
    $packageArgs.checksumType = Get-Argument $arguments 'checksumType' 'sha256'
    $packageArgs.silentArgs = Get-Argument $arguments 'silentArgs'
    $packageArgs.validExitCodes = Get-Argument $arguments 'validExitCodes'
    $packageArgs.cleanUp = Get-Argument $arguments 'cleanUp' $true

    [Array]$packageArgs.validExitCodes += $global:defaultValidExitCodes

    $fileName = $packageArgs.file

    # If the file does not contain a full path,
    # look for the file in the package directory
    if (-not [System.IO.Path]::IsPathRooted($packageArgs.file)) {
        $file = Join-Path $env:ChocolateyPackageFolder $fileName

        if (Test-FileExists $file) {
            $packageArgs.file = $file
        }
    }

    # Next look in the installers directory
    if (-not (Test-FileExists $packageArgs.file) -and (Test-DirectoryExists $env:installers)) {
        $file = Join-Path $env:installers $fileName

        if (Test-FileExists $file) {
            $packageArgs.file = $file
        }
    }

    # Next, find the first executable or zip in the package directory
    if (-not (Test-FileExists $packageArgs.file)) {
        $file = (Get-ChildItem -Path $env:ChocolateyPackageFolder `
                -Include *.zip, *.7z, *.tar.gz, *.exe, *.msi, *.reg -Recurse -File `
                | Select-Object -First 1 -ExpandProperty FullName)

        if (Test-FileExists $file) {
            $packageArgs.file = $file
        }
    }

    $packageArgs.fileType = Get-FileExtension $packageArgs.file
    $packageArgs.executableType = Get-FileExtension $packageArgs.executable

    # No silent arguments provided and the file type is MSI
    if (-not $packageArgs.silentArgs -and $packageArgs.fileType -eq 'msi') {
        $packageArgs.silentArgs = '/quiet /norestart'
    }

    # No executable silent arguments provided and the executable file type is MSI
    if (!$packageArgs.executableArgs -and $packageArgs.executableType -eq 'msi') {
        $packageArgs.executableArgs = '/quiet /norestart'
    }

    Write-Message "Get-Arguments: $($packageArgs | Out-String)"

    return $packageArgs
}