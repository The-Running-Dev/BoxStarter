function Invoke-GitBranch {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $name
    )

    git checkout master
    git checkout -b $name
}