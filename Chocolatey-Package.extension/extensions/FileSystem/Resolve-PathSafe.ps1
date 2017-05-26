function Resolve-PathSafe {
    param(
        [Parameter(Position = 0, ValueFromPipeline)][string] $path
    )

    $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($path)
}