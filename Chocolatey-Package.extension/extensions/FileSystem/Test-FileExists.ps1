function Test-FileExists {
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $file
    )

    return [System.IO.File]::Exists($file)
}