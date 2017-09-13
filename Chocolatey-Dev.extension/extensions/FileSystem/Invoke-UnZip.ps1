function Invoke-UnZip {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory = $true)] [string] $file
    )

    if ([System.IO.Path]::IsPathRooted($file)) {
        $filePath = $file
    }
    else {
        $filePath = Join-Path -Resolve . $file
    }

    $parentDirectory = Split-Path -Parent $filePath
    $destinationPath = Join-Path $parentDirectory ([System.IO.Path]::GetFileNameWithoutExtension($filePath))

    Get-ChocolateyUnzip -FileFullPath $filePath -Destination $destinationPath
}