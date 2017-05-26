function Invoke-PinApplications {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateScript( {Test-Path $_ -PathType Leaf})][string] $configFile
    )

    foreach ($line in Get-Content -Path $configFile | Where-Object {$_.trim() -notmatch '(^\s*$)|(^#)'}) {
        New-PinnedApplication $line
    }
}