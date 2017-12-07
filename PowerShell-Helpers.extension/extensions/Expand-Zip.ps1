function Expand-Zip {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateScript( {Test-Path $_ -PathType Leaf})][string] $file,
        [Parameter(Position = 1, ValueFromPipelineByPropertyName)][string] $destination
    )

    if ([System.IO.Path]::IsPathRooted($file)) {
        $filePath = $file
    }
    else {
        $filePath = Join-Path -Resolve . $file
    }

    if (-not $destination) {
        $parentDirectory = Split-Path -Parent $filePath
        $destination = Join-Path $parentDirectory ([System.IO.Path]::GetFileNameWithoutExtension($filePath))
    }

    Get-ChocolateyUnzip -FileFullPath $filePath -Destination $destination
}
