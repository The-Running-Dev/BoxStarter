function Test-DirectoryExists {
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $path
    )

    return [System.IO.Directory]::Exists($path)
}