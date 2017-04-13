function Invoke-GitMaster {
    [Alias("gitm")]
    [CmdletBinding()]param()

    git checkout master
}