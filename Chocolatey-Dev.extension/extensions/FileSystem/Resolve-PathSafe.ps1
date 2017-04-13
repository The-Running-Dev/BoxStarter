function Resolve-PathSafe
{
    param(
        [string] $path
    )

    $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($path)
}