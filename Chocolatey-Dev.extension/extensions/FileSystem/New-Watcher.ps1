function New-Watcher {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Position = 0, Mandatory = $true)][ValidateNotNullOrEmpty()] [String] $path,
        [Parameter(Position = 1, Mandatory = $false)][string] $filter = '*.*',
        [Parameter(Position = 2, Mandatory = $false)] [System.IO.NotifyFilters] $notifyFilter = ('FileName', 'LastWrite', 'LastAccess'),
        [Switch] $recurse
    )

    if ($PSCmdlet.ShouldProcess("$Path\$Filter", 'Initialize fileSystemWatcher')) {
        $fileSystemWatcher = New-Object System.IO.FileSystemWatcher
        $fileSystemWatcher.Path = $path
        $fileSystemWatcher.Filter = $filter
        $fileSystemWatcher.NotifyFilter = $notifyFilter

        if ($recurse) {
            $fileSystemWatcher.IncludeSubdirectories = $true
        }

        $fileSystemWatcher.EnableRaisingEvents = $true

        return $fileSystemWatcher
    }
}