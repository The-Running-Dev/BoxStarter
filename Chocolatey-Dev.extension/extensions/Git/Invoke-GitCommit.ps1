function Invoke-GitCommit {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $message
    )

    git add .
    git commit -m $message

    Invoke-GitPush
}