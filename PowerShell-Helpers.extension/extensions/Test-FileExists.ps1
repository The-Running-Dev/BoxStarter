function Test-FileExists {
    param(
        [Parameter(Position = 0, ValueFromPipeline)][string] $file
    )

    return [System.IO.File]::Exists($file)
}