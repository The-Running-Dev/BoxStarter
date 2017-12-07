function Get-FileExtension {
    param(
        [Parameter(Position = 0, ValueFromPipeline)][string] $file
    )

    return [System.IO.Path]::GetExtension($file).ToLower().Replace('.', '')
}