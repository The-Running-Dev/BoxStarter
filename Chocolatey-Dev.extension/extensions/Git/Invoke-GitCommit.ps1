function Invoke-GitCommit {
    [Alias("gitc")]
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory = $true)][string] $message
    )

    git add .
    git commit -m $message

    Invoke-GitPush
}