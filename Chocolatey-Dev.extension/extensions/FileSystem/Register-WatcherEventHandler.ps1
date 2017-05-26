function Register-WatcherEventHandler {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Position = 0, Mandatory = $true)] [Alias('FSW')] [ValidateNotNullOrEmpty()] [System.IO.FileSystemWatcher] $fileSystemWatcher,
        [Parameter(Position = 1, Mandatory = $true)] [ValidateSet('Changed', 'Created', 'Deleted', 'Disposed', 'Error', 'Renamed')] [String] $eventName,
        [Parameter(Position = 2, Mandatory = $true)] [Alias('Identifier')] [string] $eventIdentifier,
        [Parameter(Position = 3, Mandatory = $true)] [Alias('Action')] [scriptblock] $eventAction,
        [Parameter(Position = 4, Mandatory = $false)] [Alias('MessageData')] [PSObject] $data
    )

    if ($PSCmdlet.ShouldProcess("$($FileSystemWatcher.Path)", "Register Event Handler (for File $EventName)")) {
        $writeOutput = {
            if ($EventArgs.Data -ne $null) {
                $line = $EventArgs.Data

                if ($line.StartsWith("- ")) {
                    $global:zipFileList.AppendLine($global:zipDestinationFolder + "\" + $line.Substring(2))
                }
            }
        }

        $writeError = {
            write-Host $(EventArgs | Out-String)
        }

        Register-ObjectEvent `
            -InputObject $fileSystemWatcher `
            -EventName $eventName `
            -Action $eventAction `
            -SourceIdentifier $eventIdentifier `
            -MessageData $data `
            -Verbose

        Register-ObjectEvent -InputObject $fileSystemWatcher -SourceIdentifier "$($eventIdentifier)_Errors" -EventName Error -Action  $writeError | Out-Null
    }
}