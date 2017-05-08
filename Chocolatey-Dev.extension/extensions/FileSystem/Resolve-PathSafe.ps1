function Resolve-PathSafe
{
    param(
        [Parameter(Position = 0, Mandatory = $true)][string] $path
    )

    $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($path)
}