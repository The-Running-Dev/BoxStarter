$global:ahkCompiler = Join-Path $PSScriptRoot "AutoHotKey\Ahk2Exe.exe"

function CompileAutoHotKey([string] $directoryPath) {
    $ahkFiles = Get-ChildItem -Path $directoryPath -Filter *.ahk -Recurse

    foreach ($f in $ahkFiles) {
        Start-Process $global:ahkCompiler "/in $($f.FullName)" -Wait
    }
}

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
                Write-Verbose "$line"
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