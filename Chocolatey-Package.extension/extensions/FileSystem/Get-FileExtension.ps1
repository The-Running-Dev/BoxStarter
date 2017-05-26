function Get-FileExtension {
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $file
    )

    return [System.IO.Path]::GetExtension($file).ToLower().Replace('.', '')
}