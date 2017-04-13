function Register-WatcherEventHandler {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Mandatory = $true, Position = 0)] [Alias('FSW')] [ValidateNotNullOrEmpty()] [System.IO.FileSystemWatcher] $fileSystemWatcher,
        [Parameter(Mandatory = $true, Position = 1)] [ValidateSet('Changed', 'Created', 'Deleted', 'Disposed', 'Error', 'Renamed')] [String] $eventName,
        [Parameter(Mandatory = $true, Position = 2)] [Alias('Identifier')] [String] $eventIdentifier,
        [Parameter(Mandatory = $true, Position = 3)] [Alias('Action')] [Scriptblock] $eventAction,
        [Parameter(Mandatory = $false, Position = 4)] [Alias('MessageData')] [PSObject] $data
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