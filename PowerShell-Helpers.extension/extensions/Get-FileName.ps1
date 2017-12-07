function Get-FileName {
    param(
        [Parameter(Position = 0, ValueFromPipeline)][string] $file
    )

    return [System.IO.Path]::GetFileName($file)
}