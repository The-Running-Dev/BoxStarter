function Test-DirectoryExists {
    param(
        [Parameter(Position = 0, ValueFromPipeline)][string] $path
    )

    return [System.IO.Directory]::Exists($path)
}