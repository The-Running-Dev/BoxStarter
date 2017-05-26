function Get-FileName {
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $file
    )

    return [System.IO.Path]::GetFileName($file)
}