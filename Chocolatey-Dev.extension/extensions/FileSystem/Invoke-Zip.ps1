function Invoke-Zip {
    [Alias("zip")]
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory = $true)][string] $fileOrDirectory
    )

    if ([System.IO.Path]::IsPathRooted($fileOrDirectory)) {
        $fileSystemEntry = $fileOrDirectory
    }
    else {
        $fileSystemEntry = Join-Path -Resolve . $fileOrDirectory
    }

    $parentDirectory = Split-Path -Parent $fileSystemEntry

    if ([System.IO.File]::Exists($fileSystemEntry)) {
        $destinationPath = Join-Path $parentDirectory ([System.IO.Path]::GetFileNameWithoutExtension(($fileSystemEntry)))
    }
    else {
        $destinationPath = Split-Path -Leaf $fileSystemEntry
    }

    Write-Zip -level 9 -Quiet $fileSystemEntry "$($destinationPath).zip"
}