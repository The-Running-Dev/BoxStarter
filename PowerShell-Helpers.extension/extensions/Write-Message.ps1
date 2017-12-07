function Write-Message {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $message
    )

    if ($env:ChocoDebug) {
        Write-Host $message
    }
    else {
        Write-Verbose $message
    }
}