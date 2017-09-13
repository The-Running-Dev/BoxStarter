function New-Watcher {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [ValidateNotNullOrEmpty()] [String] $path,
        [Parameter(Mandatory = $false, Position = 1)] [String] $filter = '*.*',
        [Parameter(Mandatory = $false)] [System.IO.NotifyFilters] $notifyFilter = ('FileName', 'LastWrite', 'LastAccess'),
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