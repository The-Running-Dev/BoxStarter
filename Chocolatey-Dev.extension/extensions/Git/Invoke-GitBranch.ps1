function Invoke-GitBranch {
    [Alias("gitb")]
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory = $true)][string] $branchName
    )

    git checkout master
    git checkout -b $branchName
}