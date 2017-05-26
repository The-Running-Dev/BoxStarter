function Resolve-PathSafe {
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $path
    )

    $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($path)
}