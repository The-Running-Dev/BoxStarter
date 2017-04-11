function Invoke-GitAdd
{
    [Alias("gita")]
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true)] [string] $file
    )

    GitConfig

    git add $file
}

function Invoke-GitBranch {
    [Alias("gitb")]
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory = $true)][string] $branchName
    )

    git checkout master
    git checkout -b $branchName
}

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

function Invoke-GitConfig
{
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true)] [string] $email,
        [Parameter(ValueFromPipeline = $true)] [string] $name
    )

    git config user.email $email
    git config user.name $name
}

function Invoke-GitMaster {
    [Alias("gitm")]
    [CmdletBinding()]param()

    git checkout master
}

function Invoke-GitPush {
    [Alias("gitp")]
    $branchName = git rev-parse --abbrev-ref HEAD

    git push --set-upstream origin $branchName
}

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

Export-ModuleMember -Function *