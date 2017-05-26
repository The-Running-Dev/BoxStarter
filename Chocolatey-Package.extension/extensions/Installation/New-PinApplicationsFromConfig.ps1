function Invoke-PinApplications {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $configFile
    )

    foreach ($line in Get-Content -Path $configFile | Where-Object {$_.trim() -notmatch '(^\s*$)|(^#)'}) {
        New-PinnedApplication $line
    }
}