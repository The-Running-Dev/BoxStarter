function Register-WatcherEventHandler {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Position = 0, Mandatory)][Alias('fsw')][ValidateNotNullOrEmpty()][System.IO.FileSystemWatcher] $fileSystemWatcher,
        [Parameter(Position = 1, Mandatory)][ValidateSet('Changed', 'Created', 'Deleted', 'Disposed', 'Error', 'Renamed')][string] $eventName,
        [Parameter(Position = 2, Mandatory)][Alias('Identifier')][string] $eventIdentifier,
        [Parameter(Position = 3, Mandatory)][Alias('Action')][scriptblock] $eventAction,
        [Parameter(Position = 4)] [Alias('MessageData')][psobject] $data
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