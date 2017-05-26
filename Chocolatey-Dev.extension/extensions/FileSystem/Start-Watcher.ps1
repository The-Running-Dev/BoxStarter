function Start-Watcher {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)][Alias('FSW')] [ValidateNotNullOrEmpty()] [System.IO.FileSystemWatcher] $fileSystemWatcher,
        [Parameter(Position = 1, Mandatory = $false)][ValidateSet('All', 'Changed', 'Created', 'Deleted', 'Disposed', 'Error', 'Renamed')] [String] $type = 'All',
        [Parameter(Position = 2, Mandatory = $false)][int] $timeOut = 10000,
        [Switch] $infinite
    )

    if ($PSCmdlet.ShouldProcess("$($FileSystemWatcher.Path)", "WaitForChanged($type, $timeOut)")) {
        do {
            $fileSystemChange = $fileSystemWatcher.WaitforChanged($type, $timeOut)

            if (!$fileSystemChange.TimedOut) {
                #$fileSystemChange
            }
        }
        while ($Infinite)
    }
}