function Invoke-GitPull
{
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true)] [string] $branch
    )

    $logicalBranch = $branch.replace("refs/heads/", "")

    if (![string]::IsNullOrEmpty($logicalBranch)) {
        # Update the local branch from the remote
        git pull origin $logicalBranch
    }
}