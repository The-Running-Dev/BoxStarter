function Invoke-GitPull {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, ValueFromPipeline)][string] $branch
    )

    $logicalBranch = $branch.replace("refs/heads/", "")

    if ($logicalBranch) {
        # Update the local branch from the remote
        git pull origin $logicalBranch
    }
}