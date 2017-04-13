function Start-Watcher {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [Alias('FSW')] [ValidateNotNullOrEmpty()] [System.IO.FileSystemWatcher] $fileSystemWatcher,
        [Parameter(Mandatory = $false)]
        [ValidateSet('All', 'Changed', 'Created', 'Deleted', 'Disposed', 'Error', 'Renamed')] [String] $type = 'All',
        [Parameter(Mandatory = $false)] [Int] $timeOut = 10000,
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