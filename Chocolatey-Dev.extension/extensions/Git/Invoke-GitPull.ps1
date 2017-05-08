function Invoke-GitPull
{
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, ValueFromPipeline = $true)][string] $branch
    )

    $logicalBranch = $branch.replace("refs/heads/", "")

    if (![string]::IsNullOrEmpty($logicalBranch)) {
        # Update the local branch from the remote
        git pull origin $logicalBranch
    }
}