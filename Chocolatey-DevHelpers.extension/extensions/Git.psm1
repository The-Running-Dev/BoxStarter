function Invoke-GitConfig
{
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true)] [string] $email,
        [Parameter(ValueFromPipeline = $true)] [string] $name
    )

    # Configure Git
    Exec { git config user.email $email; git config user.name $name}
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
        Exec { git pull origin $logicalBranch }
    }
}

function Invoke-GitAdd
{
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true)] [string] $file
    )

    GitConfig

    # Add the file
    Exec { git add $file }
}

function Invoke-GitCommit
{
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true)] [string] $message,
        [string] $branch
    )

    $logicalBranch = $branch.replace("refs/heads/", "")

    if (![string]::IsNullOrEmpty($logicalBranch)) {
        Exec { git commit -m $message }

        # Push the version configuration commit
        Exec { git push --set-upstream origin $logicalBranch }
    }
}

Export-ModuleMember -Function *